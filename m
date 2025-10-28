Return-Path: <linux-kernel+bounces-873098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3B9C1315B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908CF1AA683B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B27929C33F;
	Tue, 28 Oct 2025 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HNtf1IBu"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B62727FD
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631811; cv=none; b=NC21QAQsBb6M9vyIh+rfw8pHeeoQUylcOe4aQLCQWkMnnDSUSNpLlN6sDUJ1eWhwu2oN6KzrwkVyl/yAiyYUu6ZQbQL0lgrnl/c3GDNsRtBB12uIH+YYGZKxrWA3tWqF+T2VkDM/dkYJFlcFuU6yxQyuHbbpKAGy0Eb7IlLPm6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631811; c=relaxed/simple;
	bh=ci1BVgjrG/vR5NYDEPeJFRGFDFGAkEYdIwwqsI1pb70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X72JjszBJAEH3sILARmzFnl4unHF6cUNeW22ea/jCz0k/SLPQtJUzIEqSG028q0zZKwZmbCkLl7oyqallkRbfvVuev5SZTCPjoap/SiAyHNcPzDooEziDJnfrSeVr9JUBBT45s3N37hp2xgzM+MFcsDko+doBNXm/IUQ09SXh98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HNtf1IBu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S0bV1f003058;
	Tue, 28 Oct 2025 06:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FMPLtD
	MhgCXTcvJhPpe2oJ48NbUtLESJxawAH9znXV8=; b=HNtf1IBu8xMlfGYUJiRQg3
	5lblOkCQ9aYJijKzOWn6aZIrXFWE5cYQVVj7CuxSSOxc66f/K4IA7NJLXxWf2K6J
	Z5omBsM7bfKD7/tadBoXbcTjV8U+TM2rwK5chisK/dlboR599KhP14GA6D+OHXSk
	W/Q0QxaV6bemRPJTE6RZV1qBLFgcyU8ubo0PFs9AynsI7U9TSZKqf63VcODNvQqW
	4Hldn4o5hP9SqmdzXvGlPzmGRe9AN4b7BJAQSsi15YC1uThqeRMrufNhbuzMKaQl
	rCfFb9ymuf0o/044+T0eBitAxniY4CbVsF2o3x3KaFJQ+6oFZH3TrXzWz/7KTQrw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p9929wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 06:09:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S3dwGa030426;
	Tue, 28 Oct 2025 06:09:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a1acjs8gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 06:09:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59S69Xr857016652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 06:09:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40A5720043;
	Tue, 28 Oct 2025 06:09:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 668E420040;
	Tue, 28 Oct 2025 06:09:31 +0000 (GMT)
Received: from [9.124.208.236] (unknown [9.124.208.236])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 06:09:31 +0000 (GMT)
Message-ID: <bfa0a61e-7cb8-4bdd-b913-1bf241f316c7@linux.ibm.com>
Date: Tue, 28 Oct 2025 11:39:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tick/sched: Limit non-timekeeper CPUs calling jiffies
 update
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20251027183456.343407-1-steve.wahl@hpe.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251027183456.343407-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=69005e20 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=VnNF1IyMAAAA:8 a=VZn0IcEeGtm_vNzOb4sA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 1QfdobD7maIvnBas8iAZDX8FgMYkDb0R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfXwr5SqZOR2y1e
 n/G0FDuRIMas9RFah85w+BEfWykoe6vyR3ud5f82ZA/r+jKDunVMo9emXeVLkpTWFMur0I0VtvA
 5JBB4giepIO3XL02GnVP0Dkshgwj1hHHkJwl/Ga3aMlIwAEerxiVJ6GR7u5OdWCVIfyf9nDqky5
 eXebt4YOBwLlBCfjFQ/rJg9WTSuNlieX17rmLcfwRGfcqqkcmtBrtUPgS6y2wyYSe6iRd1k/PQO
 6tlxeVN6IVN5Y5tynEWOnwP2VInJO3DwDiFoeUrNkTWADSc+ZJq6gtMH/hZbsnG6nG4+1zqkCw4
 UGmEt9OMK2vvT39m4dExsOaMaElvCAIQW4ljGMlyccONMG3XHJ6M4weLclygAxelCsVYsg98LXo
 Yf8lwm1x2uUU683OfUSiXmre1ori0g==
X-Proofpoint-ORIG-GUID: 1QfdobD7maIvnBas8iAZDX8FgMYkDb0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250019



On 10/28/25 12:04 AM, Steve Wahl wrote:
> On large NUMA systems, while running a test program that saturates the
> inter-processor and inter-NUMA links, acquiring the jiffies_lock can
> be very expensive.  If the cpu designated to do jiffies updates
> (tick_do_timer_cpu) gets delayed and other cpus decide to do the
> jiffies update themselves, a large number of them decide to do so at
> the same time.  The inexpensive check against tick_next_period is far
> quicker than actually acquiring the lock, so most of these get in line
> to obtain the lock.  If obtaining the lock is slow enough, this
> spirals into the vast majority of CPUs continuously being stuck
> waiting for this lock, just to obtain it and find out that time has
> already been updated by another cpu. For example, on one random entry
> to kdb by manually-injected NMI, I saw 2912 of 3840 cpus stuck here.
> 
> To avoid this, allow only one non-timekeeper CPU to call
> tick_do_update_jiffies64() at any given time, resetting ts->stalled
> jiffies only if the jiffies update function is actually called.
> 
> With this change, manually interrupting the test I find at most two
> CPUs in the tick_do_update_jiffies64 function (the timekeeper and one
> other).
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
> 
> v2: Rewritten to use an atomic to gate non-timekeeping cpus calling the
>      jiffies update, as suggested by tglx. Title of patch has changed
>      since trylock is no longer used.
> 
> v1 discussion: https://lore.kernel.org/all/20251013150959.298288-1-steve.wahl@hpe.com/
> 
>   kernel/time/tick-sched.c | 30 ++++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index c527b421c865..3ff3eb1f90d0 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -201,6 +201,27 @@ static inline void tick_sched_flag_clear(struct tick_sched *ts,
>   	ts->flags &= ~flag;
>   }
>   
> +/*
> + * Allow only one non-timekeeper CPU at a time update jiffies from
> + * the timer tick.
> + *
> + * Returns true if update was run.
> + */
> +static bool tick_limited_update_jiffies64(struct tick_sched *ts, ktime_t now)
> +{
> +	static atomic_t in_progress;
> +	int inp;
> +
> +	inp = atomic_read(&in_progress);
> +	if (inp || !atomic_try_cmpxchg(&in_progress, &inp, 1))
> +		return false;
> +

You come here if (ts->last_tick_jiffies == jiffies). So it may be not necessary to check again.

> +	if (ts->last_tick_jiffies == jiffies)
> +		tick_do_update_jiffies64(now);
> +	atomic_set(&in_progress, 0);
> +	return true;
> +}
> +
>   #define MAX_STALLED_JIFFIES 5
>   
>   static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
> @@ -239,10 +260,11 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
>   		ts->stalled_jiffies = 0;
>   		ts->last_tick_jiffies = READ_ONCE(jiffies);
>   	} else {
> -		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
> -			tick_do_update_jiffies64(now);
> -			ts->stalled_jiffies = 0;
> -			ts->last_tick_jiffies = READ_ONCE(jiffies);
> +		if (++ts->stalled_jiffies >= MAX_STALLED_JIFFIES) {
> +			if (tick_limited_update_jiffies64(ts, now)) {
> +				ts->stalled_jiffies = 0;
> +				ts->last_tick_jiffies = READ_ONCE(jiffies);
> +			}
>   		}
>   	}
>   


Yes. This could help large systems.

Acked-by: Shrikanth Hegde <sshegde@linux.ibm.com>

