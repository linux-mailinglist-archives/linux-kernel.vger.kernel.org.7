Return-Path: <linux-kernel+bounces-881157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 862DAC27939
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 08:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6C2134AFFE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 07:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10C226ED4C;
	Sat,  1 Nov 2025 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pa1QPnqH"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94406257448
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761983817; cv=none; b=S9h5rrt1xF27XjuvFq+UQYQPnqQC5UqEtZNgtaC2fbKQPJe+57hPagVwU9aL58TINH3CQjunF7Wqu+3XZegvzQbYNMGI8/Jcxl+8yV5cbsrW3la7wJx45EDJOK3anGe2eC5FoA5vjqjKUklZGr42SLypM/6q4lOkq8UEp0Qb5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761983817; c=relaxed/simple;
	bh=oFYLAyUgUKVca6bX5z+JnclDAZnq1RY9Sq5wx6V9lBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ym3js5p/vPq5k+bnSsCb+ZcDRDEK5eriIu1utEBhJUg59BpOTYDRAOWJjm7q+lK2qS5B1Txv6tHl6RB3y4p52jzHRS1KT534XQkf7r7NE+618mjOiyXqPU8BR5vhzQaDbbB9DZqlSzIVSc9O0VBWJdnKyFObPPssU4yl9dbxvSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pa1QPnqH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A131arZ029142;
	Sat, 1 Nov 2025 07:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Qz5z4z
	Wp+0kzLrzXpj+cIxoReZBRNWWRZSQGf6FSCGI=; b=pa1QPnqHCQsyy9jFHkaiAt
	Ept8AbeBEKTTb9N7UmUt+usBiwQKYj8RztJN/CaNcoovPoSgVc9PmfaNY0JF3q+8
	gvZQGXrz7UozcT+1H4Nvn0mwKiKPkqoSSYd265CK3eJluHOSh3NgOhNemSDdMzOD
	NFF8HRg6RZKfaMFTa6AH5G+RPlFSu3NqvfYb6nzPvNAkm3ERmifdfyxeGBboRiTp
	dz2eHte4vXqrseRWslEfuQqyu0kgOpJ6q9pnn9L+MnLBIEveckr0Qicm40+3fYSs
	2NbJS1IkfWAPCHn90MZXSJB8rv04SpVaRIBRCcF3x9Nxs3SHCGcYe7c1KTI1jE5w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xbggms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Nov 2025 07:56:17 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A17uGbi015678;
	Sat, 1 Nov 2025 07:56:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xbggmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Nov 2025 07:56:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A15lKF2030770;
	Sat, 1 Nov 2025 07:56:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wx1w4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Nov 2025 07:56:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A17uDFo41681366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Nov 2025 07:56:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3106420043;
	Sat,  1 Nov 2025 07:56:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A85A20040;
	Sat,  1 Nov 2025 07:56:10 +0000 (GMT)
Received: from [9.124.213.44] (unknown [9.124.213.44])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Nov 2025 07:56:10 +0000 (GMT)
Message-ID: <3f7ec825-7e85-499f-bc44-1fcda0a862ae@linux.ibm.com>
Date: Sat, 1 Nov 2025 13:26:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 00/20] sched: Rewrite MM CID management
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
 <ae8de225-3c07-43ac-80d1-ecb6ac45d5d9@linux.ibm.com> <87ecqisw2h.ffs@tglx>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <87ecqisw2h.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX5x0Ux1rQ7MGm
 XvSm6IjGsf32oT3WwG2vkAZLAj3Nkgs4k+dEOazcteDTlOVITtsbIB2tPEuJiAZlfZvKpZE+ULz
 Rycj18Ph+xdwnDKeXZgSNkmLlLtNayDPUYVTxl3suwTrE6Ogg09O2gbwDG2CNbQGWWcyM67c5zv
 fWwoSp2Ns2ihlUG5/aR8LEuNuhk2tuIV8A89PxS4TSGZwy0yd7h2/7UBuYpX9XNpglpTnns0T4w
 UiNuN+YzEPQJnR5M3HL23nsyh+H4o8o/7l5XL/yGAY9iUOZENnB1/FD0FAlRT9LcAVzOMH0PD6h
 r+famzfPrJRroy7IMHSkFhDIjaNZP7Z8Z/u3eRbNGVFOrFUApWPg2gkH0Fcj2uSlxpmGlNaY+mJ
 tan/sZWBp0SXLbyuDUgqlxcspUi8lQ==
X-Proofpoint-GUID: LgZoCtd8AR86LuaX1gC0B4A5u9zuUlXi
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=6905bd21 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=w-UqUKPv55kzaV5c4kIA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: TALgBEPv3_sGAvWoFUSGCA25QXEeV8SV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021



On 11/1/25 1:06 AM, Thomas Gleixner wrote:
> On Thu, Oct 30 2025 at 12:10, Shrikanth Hegde wrote:
>>> I am running into crash at boot on power10 pseries.
>>> Thought of putting it here first. Me trying to figure out why.
>>>
>>> I am using your tree.
>>> git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
> 
> Can you update and revalidate? There are a couple of fixes there though
> I don't know how they would be related.

Tried with latest. It boots fine with NR_CPUS=8192.

at commit:
commit 870c1793316eddb6f8c9814f830f237e6e1c40ee (origin/rseq/cid)
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue Oct 14 10:51:04 2025 +0200

     sched/mmcid: Switch over to the new mechanism

