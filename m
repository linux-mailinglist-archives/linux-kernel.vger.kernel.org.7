Return-Path: <linux-kernel+bounces-831202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8789EB9BD5E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 056807A7970
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4F9323F75;
	Wed, 24 Sep 2025 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ObPxcJur"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30118327A1A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745113; cv=none; b=Ep+8lVwsViKo97uaKYcOTEhFMp5B9P7sQRIA2ybMjAcHP1z5sFb2rGrcpZOCd9Ar5dbLJpVZFa3sD1yZbLw99ir9jaP0xBjSWryNDs6AUcwC4mC+sSTh9w5qdsykxtsTyyL7yDcDvbWKBPjNf6FI0LMTiMy4d+uxIZi1XSZlZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745113; c=relaxed/simple;
	bh=RGD3QOePiicKNdREN70yoNQJezzvYWsuaApnVvvYuT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtERvBevJomvnnJMIH4QHj8aNKgpb+/qJP8hnbZxFQ47wXlO7A65wuIAUFuxvfOmtUIWHQhX3zAkJG/mN10bJDoK7Nb2RO12Vhmq9NQ/qs9ccPxdADU7zQS2PCX3spZu/KMmcK/MmVje7CHbq5p38wKq/STspdGG7j9O3gRgJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ObPxcJur; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OGfvQ2015409;
	Wed, 24 Sep 2025 20:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G6hE0q
	hYH+SLfXrlJasCg+Z+QZknl4cpzc4X+DNBpPs=; b=ObPxcJurb0aPYGP1nfvLNI
	aoJQcvqdKtagHBtPNZH6OmwF2NQsPx+A1TZy0GUtwf3iRwX1t9kMI1109GK+G7Ar
	flXO4Ahv1CssU8mF+IGQRTA2YjaUE9Qo1nbOi0nDhVea0bswblJe+KULz3827V68
	hV+FkuXAcTs6bveqJgOVhnL7ksTpl+Hk4FSRFvHxL6jhSL9JcLeHPtnHPQGsRzCj
	rlhcnnrteKIXbqGlrhLeVGlIvsaT2qgsg7QwSd/g3NmnMy66cMbAB/q3uaXZpmhe
	AfBPVFirC0K/BSCtWf2YzLBJ+769yskkgUxVSNSN/3DPlmz/dzPqG1jeDhzSImsw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksc1vra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 20:17:41 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58OKG7s7006450;
	Wed, 24 Sep 2025 20:17:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksc1vr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 20:17:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58OHONJg013329;
	Wed, 24 Sep 2025 20:17:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49cj349jce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 20:17:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58OKHcAi43647484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 20:17:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFE5A20040;
	Wed, 24 Sep 2025 20:17:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CE5720043;
	Wed, 24 Sep 2025 20:17:31 +0000 (GMT)
Received: from [9.61.52.22] (unknown [9.61.52.22])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Sep 2025 20:17:30 +0000 (GMT)
Message-ID: <409bde01-720b-4602-bde9-a04262ea2c73@linux.ibm.com>
Date: Thu, 25 Sep 2025 01:47:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/19] sched/fair: Use rq->nohz_tick_stopped in
 update_nohz_stats()
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20250904041516.3046-1-kprateek.nayak@amd.com>
 <20250904041516.3046-4-kprateek.nayak@amd.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250904041516.3046-4-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NWOjTwsZbg6f3Net1tTt7yI6GtgkkWPa
X-Proofpoint-GUID: lYJwCxw0Pnbs3QzY-RwCfqJhsOVr-aS0
X-Authority-Analysis: v=2.4 cv=SdH3duRu c=1 sm=1 tr=0 ts=68d451e5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=zd2uoN0lAAAA:8 a=e0ugSSi9uvxMxiJAq8MA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX8pJPcNjMwozl
 wv3+m8wznyHBww6UQfUEnWb9ZYeG8Hp2t9emf56npkNuZxQ83oJjDMbyaqM6hC1fTjK0zo/cVTl
 m1P60RsOO37LnFBOoSJhqSCL9sHFRod2YjS34CObTCLT5d1j7L3GI6zeztxWEiKQYStExfCHfnl
 Xu4S9jh+j5KIkol55CV0VaVqzE4HO5UKFSP7U/asZt641EQWclI/iD69aa4Af7oySCw/kSvYJX/
 HaPzc7TuV6yZ/Jbe9kMb8GPtLh1fXVkOBFDXKrWUgtARC/xMzaUcO5uV6+b6cyXtv8D+uK86g2n
 TbfW57esq7WAdWf14l664bIWhXBLzRNNsv1JRAYeGRQAkzeqQZZxVRa3JI9MCkSnCSDv60IDtGP
 RdBmxHIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_06,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020



On 9/4/25 9:44 AM, K Prateek Nayak wrote:
> "rq->nohz_tick_stopped" always follows the state of CPU on
> "nohz.idle_cpus_mask". Use the local rq indicator instead of checking
> for the CPU on the "idle_cpus_mask".
> 
> Use READ_ONCE() and WRITE_ONCE() for "rq->nohz_tick_stopped" to ensure
> update_nohz_stats() always sees the latest value.
> 

Is this ever called by remote CPU? If not, is READ/WRITE ONCE is necessary?

> This cleanup is necessary to avoid the number of references to the
> global "nohz.idle_cpus_mask" to ease the transition to a distributed
> nohz idle tracking strategy.
> 
> No functional changes intended.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---

