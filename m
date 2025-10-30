Return-Path: <linux-kernel+bounces-877626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997A4C1E9BB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C340D3A77DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6169221714;
	Thu, 30 Oct 2025 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aeIzdas2"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1E1E2858
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806460; cv=none; b=McZ10lB6UnciJhw2nedNV0Y9rSqFrXfCW+5RYxxCR5CNfqEP0+PyS85ke0rQkE75PTF+IebgP9UNvrSh1iED4161v8rQ1QFNAJkwrTGHMc8x+aZkUEgp4HRONbCme8c5bmcTBg3jGK48HbcSljFoE8d4qguxHblID1DUjbf3rKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806460; c=relaxed/simple;
	bh=hy2/5yIr2Ea4T1BOllbeW0MRxtTagsijfbZLYYGAOVE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=upKNqr8u5AHJZWR0whMSKB5fQKYGfNUc1BM7h8DObCC5edA032keElG87jax88EtsaRJQYvqICtjNITwlVBy3FoNkzY7X+oq/fhSn5nUrLBpS3C0aXSCPEjCzhbczWu47YJRHb3uE2FjWZARvrPlj6sFByvM0HaMO9VX4sQ8UTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aeIzdas2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TL1mCU019803;
	Thu, 30 Oct 2025 06:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U6nF7B
	xG94VhyveeWyJMmy2quUXjV6DFTJ/SVpr3SMw=; b=aeIzdas2YQ8VKOX6fX7eEC
	01g3f2sJi2REQ2IUkF1ai58r4nZk4R9+KRH5YdC1wSxLFDuFl6gPrl5W5ud2uFMw
	ybCMvwQ54rMp5oTCav4tkyaKy6aFYMs5cJbAUkQwxaRk5K2Zw7DwNnqCAp78jIZb
	RVuDMZ7yiq4KM11MUYs4fTjK+QqAAgmTmEvD/YVJ4cCQz8jMbc8fCiP7mJZDFnGl
	suOtSIDjrRpQ219Ts/ZaNs33oiC5NRJjmemTCGdJYBRF+pFqXUgobcrfkpp5bHAy
	wmov6I6YNTmKU+vMcjWJsx7S+Zkh8DgGsESMdr8Yy0TgZv9NiUZn9LwpGXx737uw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agps87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 06:40:36 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59U6eGwi015632;
	Thu, 30 Oct 2025 06:40:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agps82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 06:40:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U5fAWj019157;
	Thu, 30 Oct 2025 06:40:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xy76u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 06:40:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59U6eX7p44040698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 06:40:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C98420043;
	Thu, 30 Oct 2025 06:40:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C55220040;
	Thu, 30 Oct 2025 06:40:31 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Oct 2025 06:40:30 +0000 (GMT)
Message-ID: <ae8de225-3c07-43ac-80d1-ecb6ac45d5d9@linux.ibm.com>
Date: Thu, 30 Oct 2025 12:10:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 00/20] sched: Rewrite MM CID management
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Gabriele Monaco <gmonaco@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
        Yury Norov <yury.norov@gmail.com>
References: <20251029123717.886619142@linutronix.de>
 <47e73026-390e-40d6-a860-10e9378a3bf3@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <47e73026-390e-40d6-a860-10e9378a3bf3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K+gv3iWI c=1 sm=1 tr=0 ts=69030864 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EGPLfLqNyrsdq5xICDsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Y0DABLwWwSPLZ9Ardv4z5MQ-D7OgMk68
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXxLTEgi3U0/kp
 GJtq36c20Q/egvqCejpxAUlF9PyCZ39FB5UKZtfaKsi92etEy+XXQu+lOLkgvayKgqO1JBN+6xn
 71AUEj31vtGQM2znKJEg6D4loXy4Ua2epw3x1prjsJXaAqM56BFAH2RdcpAeAwRn9AZ39T3Y10S
 jWnPMV23Qd2OkTXhT7wMH7wkSRAkIT3x9M/F9Sif96F6FInVcyjqHO3Xvxs1D3tQgyGw4EAGefF
 kBVtVtCunltILCXY2Ha0HwhFzRvnzxtAne4d5YfUBA8njHU61/SmeVpMrylXcmiBTvtQuQih+vF
 Exz8osPW+YYU++Zk/e/b0wXyZOHtn3lf/uGUnFEbL0Pw7Qj7Hp6hTJbdF4YdRZvcQeVgIJeneKg
 rqE2gik509A80mdGSiHfHMKA71AQ/Q==
X-Proofpoint-GUID: YLrkVdXazFGtC-ICCRzMxBZdxNdYSwY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166



On 10/30/25 10:30 AM, Shrikanth Hegde wrote:
> Hi Thomas.

>> +----------------------
>>   kernel/sched/sched.h           |  395 ++++++++-----------
>>   kernel/signal.c                |    2
>>   lib/bitmap.c                   |    6
>>   16 files changed, 727 insertions(+), 823 deletions(-)
>>
>>
> 
> I am running into crash at boot on power10 pseries.
> Thought of putting it here first. Me trying to figure out why.
> 
> I am using your tree.
> git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
> 
> commit 789ff6e7cc5aa423473eb135f94812fe77b8aeab (HEAD -> rseq/cid, 
> origin/rseq/cid)
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Tue Oct 14 10:51:04 2025 +0200
> 
>      sched/mmcid: Switch over to the new mechanism
> 
> 
> Oops: Kernel access of bad area, sig: 7 [#3]
> LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
> Modules linked in: drm drm_panel_orientation_quirks xfs sd_mod sg 
> ibmvscsi ibmveth scsi_transport_srp pseries_wdt dm_mirror dm_region_hash 
> dm_log dm_mod fuse
> CPU: 96 UID: 0 PID: 0 Comm: swapper/96 Tainted: G      D W           
> 6.18.0-rc3+ #4 PREEMPT(lazy)
> Tainted: [D]=DIE, [W]=WARN
> NIP [c0000000001b5c10] mm_cid_switch_to+0x58/0x52c
> LR [c000000001117c84] __schedule+0x4bc/0x760
> Call Trace:
> [c00000668367fde0] [c0000000001b53c8] __pick_next_task+0x60/0x2ac 
> (unreliable)
> [c00000668367fe40] [c000000001117a14] __schedule+0x24c/0x760
> [c00000668367fee0] [c0000000011183d0] schedule_idle+0x3c/0x64
> [c00000668367ff10] [c0000000001f2470] do_idle+0x15c/0x1ac
> [c00000668367ff60] [c0000000001f2788] cpu_startup_entry+0x4c/0x50
> [c00000668367ff90] [c00000000005ef20] start_secondary+0x284/0x288
> [c00000668367ffe0] [c00000000000e158] start_secondary_prolog+0x10/0x14
> 

Issue happens with NR_CPUS=8192. System boots fine with NR_CPUS=2048

