Return-Path: <linux-kernel+bounces-874061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6628C15741
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2953D501F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1727342CA4;
	Tue, 28 Oct 2025 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ApLctyjB"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EFE341AAF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664982; cv=none; b=HS2RlLXQ6fmiSRIFX4TxDO6hEN7ME36RkCuC18KEaV2m+UCTq0z4YvFQFZfKEtoj57/8lolzi7w8g46UzJyCdGPnsQFV44CjBE2p6HJaWy//Witd8N3qOs5wfVmSLMxGWhVzIs+2UOfyKppxA/IZG0H0eqkRIj35A+8uA89QREc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664982; c=relaxed/simple;
	bh=+gITBtsrEBNHIlZRULwQ8Ie6Dl0t98P9mSuhYYZyeyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNKOsElWUaFInTqNZDBFL91QUmfqUNwcq4xciTABd3rooCEq8U2ExX27qLb8FDjJYcLWSNX3Be51Igg1il2ODIXJMdM7ThR/YvR9Btm2QxkLlnlJteumeq0kg6SRY1iiNJraXWKOcI/Ke1ddI40YT4XChHpRxbGpAaJft71mwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ApLctyjB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SEmheQ019381;
	Tue, 28 Oct 2025 15:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GzTG+4
	Va58fqDERVs6/8q4fbYOuzHxvbGxTZpRw/dKc=; b=ApLctyjBEnM7i60AxkdrQU
	E/bxq22iuAEGQ8hzrdeHPXLrz3NnthAhtwTCTMNVyv6twrgOOyC+B8YRyWC/zxUd
	m/zFhCvUTT4xlJ209GPqXjOneFettERRrPVGZYCy9MErHLm7Y/zU+YblIX/OVJhb
	jLbBBAx6zSO9/o7v0qTzNfXUCQyjzR16Ki0HWUpaEEuF+HV9uxxvuiaS3Mkn0Sld
	i3KSy3XboL8BiMD5lNy8qKturtmrDbUtRXkP6JM9lA7bUrIw55/tg6+JDIsB7wOQ
	faEsJ2OJfNGFw5KS2/KZHJpGNPu8aZuliuC0nh6N2nNRTsrLtCRJKkWQ1kTCNMwg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0mys4x0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 15:22:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59SCmIWB009424;
	Tue, 28 Oct 2025 15:22:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1b3j3bmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 15:22:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59SFMgwt32113064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 15:22:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B787420043;
	Tue, 28 Oct 2025 15:22:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D37420040;
	Tue, 28 Oct 2025 15:22:38 +0000 (GMT)
Received: from [9.39.28.25] (unknown [9.39.28.25])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 15:22:37 +0000 (GMT)
Message-ID: <32315105-af88-4894-8d45-35f8700df534@linux.ibm.com>
Date: Tue, 28 Oct 2025 20:52:37 +0530
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
 <bfa0a61e-7cb8-4bdd-b913-1bf241f316c7@linux.ibm.com>
 <aQDSMxKDr85kPCJJ@swahl-home.5wahls.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aQDSMxKDr85kPCJJ@swahl-home.5wahls.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nIqcuMENb3PBP92be16w5dh_MXivq4pO
X-Authority-Analysis: v=2.4 cv=ct2WUl4i c=1 sm=1 tr=0 ts=6900dfc5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=VnNF1IyMAAAA:8 a=lduqjLL1b4jg6t0sNgkA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMCBTYWx0ZWRfX88l5mlwzqMYC
 tKMc+kBesrTEbu1G6jNtY6eEP3LBxyuYWM5iAvANwEadZKDl3OUy6mSOfyPEDwYs9nQ+qfOpSOa
 tHcHNIeSEwqLyrUdNuT28onNVHrgh5SyHATSJXgcEl/mpvMd1CnjC6Ej3sEmeBtv1x3UBFSsFFa
 PeTnmWkColBKG0L4kG+SILcMDplgo9IY3Uw7R9YiNrlOifOZEh5n6wzHd4Bndt/zT8l0iF0Qhph
 b4FEt3YNSLdQzgdSBF/2mGyu6A1CSBwkbIyYR9WOPaPqjMvcqj6psrRaAvd4Qkbj5WqEvPgCxo0
 fxJ0mEm8mFQn46L8Xs89EvfkVkN0LPoybze/eD1ftckXfFXOXkwp72SWNA8kor6B9LH49LV0QHI
 Y+wK98vqVBvmyDma5XA3b5+pGEuPJQ==
X-Proofpoint-GUID: nIqcuMENb3PBP92be16w5dh_MXivq4pO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250010



On 10/28/25 7:54 PM, Steve Wahl wrote:
> On Tue, Oct 28, 2025 at 11:39:30AM +0530, Shrikanth Hegde wrote:
>>
>>
>> On 10/28/25 12:04 AM, Steve Wahl wrote:
>>> On large NUMA systems, while running a test program that saturates the
>>> inter-processor and inter-NUMA links, acquiring the jiffies_lock can
>>> be very expensive.  If the cpu designated to do jiffies updates
>>> (tick_do_timer_cpu) gets delayed and other cpus decide to do the
>>> jiffies update themselves, a large number of them decide to do so at
>>> the same time.  The inexpensive check against tick_next_period is far
>>> quicker than actually acquiring the lock, so most of these get in line
>>> to obtain the lock.  If obtaining the lock is slow enough, this
>>> spirals into the vast majority of CPUs continuously being stuck
>>> waiting for this lock, just to obtain it and find out that time has
>>> already been updated by another cpu. For example, on one random entry
>>> to kdb by manually-injected NMI, I saw 2912 of 3840 cpus stuck here.
>>>
>>> To avoid this, allow only one non-timekeeper CPU to call
>>> tick_do_update_jiffies64() at any given time, resetting ts->stalled
>>> jiffies only if the jiffies update function is actually called.
>>>
>>> With this change, manually interrupting the test I find at most two
>>> CPUs in the tick_do_update_jiffies64 function (the timekeeper and one
>>> other).
>>>
>>> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
>>> ---
>>>
>>> v2: Rewritten to use an atomic to gate non-timekeeping cpus calling the
>>>       jiffies update, as suggested by tglx. Title of patch has changed
>>>       since trylock is no longer used.
>>>
>>> v1 discussion:
>>> https://lore.kernel.org/all/20251013150959.298288-1-steve.wahl@hpe.com/
>>>
>>>    kernel/time/tick-sched.c | 30 ++++++++++++++++++++++++++----
>>>    1 file changed, 26 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>>> index c527b421c865..3ff3eb1f90d0 100644
>>> --- a/kernel/time/tick-sched.c
>>> +++ b/kernel/time/tick-sched.c
>>> @@ -201,6 +201,27 @@ static inline void tick_sched_flag_clear(struct tick_sched *ts,
>>>    	ts->flags &= ~flag;
>>>    }
>>> +/*
>>> + * Allow only one non-timekeeper CPU at a time update jiffies from
>>> + * the timer tick.
>>> + *
>>> + * Returns true if update was run.
>>> + */
>>> +static bool tick_limited_update_jiffies64(struct tick_sched *ts, ktime_t now)
>>> +{
>>> +	static atomic_t in_progress;
>>> +	int inp;
>>> +
>>> +	inp = atomic_read(&in_progress);
>>> +	if (inp || !atomic_try_cmpxchg(&in_progress, &inp, 1))
>>> +		return false;
>>> +
>>
>> You come here if (ts->last_tick_jiffies == jiffies). So it may be not necessary to check again.
> 
> TGLX had this in his rewrite suggestion, and I looked pretty intensely
> at this test.
> 
> The situation I'm looking to resolve is caused by inter-NUMA links
> being abnormally swamped with traffic.  Especially for writes, access
> to shared memory locations, such as the atomic operations to
> in_progress right above this, take longer than one usually would
> expect.  So to me it makes sense that things may have changed since
> the atomic_try_cmpxchg was initiated, and so I left the check in
> place.
> 

I see, one possibility is

- if it runs in parallel by that time on tick_cpu.( which always updates it)

>>> +	if (ts->last_tick_jiffies == jiffies)
>>> +		tick_do_update_jiffies64(now);
>>> +	atomic_set(&in_progress, 0);
>>> +	return true;
>>> +}
>>> +
>>>    #define MAX_STALLED_JIFFIES 5
>>>    static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
>>> @@ -239,10 +260,11 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
>>>    		ts->stalled_jiffies = 0;
>>>    		ts->last_tick_jiffies = READ_ONCE(jiffies);
>>>    	} else {
>>> -		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
>>> -			tick_do_update_jiffies64(now);
>>> -			ts->stalled_jiffies = 0;
>>> -			ts->last_tick_jiffies = READ_ONCE(jiffies);
>>> +		if (++ts->stalled_jiffies >= MAX_STALLED_JIFFIES) {
>>> +			if (tick_limited_update_jiffies64(ts, now)) {
>>> +				ts->stalled_jiffies = 0;
>>> +				ts->last_tick_jiffies = READ_ONCE(jiffies);
>>> +			}
>>>    		}
>>>    	}
>>
>>
>> Yes. This could help large systems.
>>
>> Acked-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
> Thanks for your time reviewing!
> 
> --> Steve Wahl
> 


