Return-Path: <linux-kernel+bounces-899647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513D7C58A00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB023A4C65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714C12F25E2;
	Thu, 13 Nov 2025 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OQFLcFO+"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECABB26E6F3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047865; cv=none; b=kD6AxsdEDSCBS74jSwwbe7IPUbtYHHxMVKfXNZ8BmPp2QlRH49yNa0/iYQO05ifxn91KAHqD3Fytu7adeUUK5cR4h0bgXkCamygvMCVVptZ8HA1hp97yuEr13UECEjGfXuZQg4BLTbZ0jHF5EKROTqk8H4huRZEyGjSQLIbLZ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047865; c=relaxed/simple;
	bh=Ca0AWLsvZ8pJ3VXEd7Jyq9mVNzFrysCMIrLNco6FEn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQMsTxVL/3rS1+/h1ahQNjKH4lhQ4ozMorGGItW+tL6qoHeGY0eFCJkpko0g88QDa6GVKKhn2ioEM85Y8ec7/Dyy8tBSmtu/46E57UuHjfYkkwilHD3JcthWkosni7gGoq5ojgaxaIdKhZT1+CDAr7bErjSfASsGtvlj9ovZNKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OQFLcFO+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Va+K4sYYYcuGxcNONY0J+Ck3zRKdFoVQxsy0V8zHpU4=; b=OQFLcFO+3Y+b1Iam9slsjX7OWt
	6sKiDHKwBUnMdH0LWmSm2+kCZrXwsM8Ma/NtMkMFmVAOmvdwIGUzufxOo48hwJDjiaBWrGbnHMrS9
	ejvu4sn/R/g0BxddPsXzDHcfVFlO3Qw/SmYHwvj7lfi6qHbch8qf7e6W1m2MuiXt3qCT4XTOzUOzk
	5MbIxDIAmXCeO0oGQMK1pdd+ttyHT6oLAdiCEy0qWAEKkv+YPOKcru2oZ90Dc1Ae7jLgMmRR0IuMD
	gfDn02jLjx/gUXGBlNWSaKXQfIX0tw/sBwyEk9PzOh1bLf+7z6woXbkMhkrKXlL3QUQoob64fw+L6
	YAuUJopQ==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vJZHf-000557-TT; Thu, 13 Nov 2025 16:30:51 +0100
Message-ID: <d36c9a72-3ac3-4a17-8f8e-795495fb734a@igalia.com>
Date: Thu, 13 Nov 2025 15:30:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/psi: Streamline the flow in psi_group_change
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 Suren Baghdasaryan <surenb@google.com>, Peter Ziljstra <peterz@infradead.org>
References: <20251113122254.40445-1-tvrtko.ursulin@igalia.com>
 <20251113152223.GA3465062@cmpxchg.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20251113152223.GA3465062@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 13/11/2025 15:22, Johannes Weiner wrote:
> On Thu, Nov 13, 2025 at 12:22:54PM +0000, Tvrtko Ursulin wrote:
>> Given that psi_group_change() can be called rather frequently from the
>> scheduler task switching code lets streamline it a bit to reduce the
>> number of loops and conditionals on the typical invocation.
>>
>> First thing is that we replace the open coded mask walks with the standard
>> for_each_set_bit(). This makes the source code a bit more readable and
>> also enables usage of the efficient CPU specific zero bit skip
>> instructions.
>>
>> In doing so we also remove the need to mask out the special TSK_ONCPU bit
>> from the set and clear masks, since for_each_set_bit() now directly limits
>> the array index to the safe range.
>>
>> As the last remaining step we can now easily move the new state mask
>> computation to only run when required.
>>
>> End result is hopefully more readable code and a very small but measurable
>> reduction in task switching CPU overhead.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Peter Ziljstra <peterz@infradead.org>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   kernel/sched/psi.c | 48 ++++++++++++++++++++--------------------------
>>   1 file changed, 21 insertions(+), 27 deletions(-)
>>
>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> index 59fdb7ebbf22..fe19aeef8dbd 100644
>> --- a/kernel/sched/psi.c
>> +++ b/kernel/sched/psi.c
>> @@ -798,39 +798,26 @@ static void psi_group_change(struct psi_group *group, int cpu,
>>   			     u64 now, bool wake_clock)
>>   {
>>   	struct psi_group_cpu *groupc;
>> -	unsigned int t, m;
>> +	unsigned long t, m;
>>   	u32 state_mask;
>>   
>>   	lockdep_assert_rq_held(cpu_rq(cpu));
>>   	groupc = per_cpu_ptr(group->pcpu, cpu);
>>   
>>   	/*
>> -	 * Start with TSK_ONCPU, which doesn't have a corresponding
>> -	 * task count - it's just a boolean flag directly encoded in
>> -	 * the state mask. Clear, set, or carry the current state if
>> -	 * no changes are requested.
>> +	 * TSK_ONCPU does not have a corresponding task count - it's just a
>> +	 * boolean flag directly encoded in the state mask. Clear, set, or carry
>> +	 * the current state if no changes are requested.
>> +	 *
>> +	 * The rest of the state mask is calculated based on the task counts.
>> +	 * Update those first, then construct the mask.
>>   	 */
>> -	if (unlikely(clear & TSK_ONCPU)) {
>> -		state_mask = 0;
>> -		clear &= ~TSK_ONCPU;
>> -	} else if (unlikely(set & TSK_ONCPU)) {
>> -		state_mask = PSI_ONCPU;
>> -		set &= ~TSK_ONCPU;
>> -	} else {
>> -		state_mask = groupc->state_mask & PSI_ONCPU;
>> -	}
> 
> This doesn't look right. Without PSI_ONCPU in state_mask, the results
> of test_states() will be bogus, as well as the PSI_MEM_FULL special
> case for an active reclaimer on the CPU.

You are completely right, I was sure local state_mask was not used 
outside the !group->enabled branch but missed it is an input parameter 
to test_states().

> 
>> -	/*
>> -	 * The rest of the state mask is calculated based on the task
>> -	 * counts. Update those first, then construct the mask.
>> -	 */
>> -	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
>> -		if (!(m & (1 << t)))
>> -			continue;
>> -		if (groupc->tasks[t]) {
>> +	m = clear;
>> +	for_each_set_bit(t, &m, ARRAY_SIZE(groupc->tasks)) {
> 
> The current version relies on !!m and doesn't need the range checks
> for_each_set_bit() introduces. This seems less efficient. Did you
> compare the generated code?

Yes, slightly more .text but empirically it looks a tiny bit fewer 
cycles. Which I thought was due being able to use the CPU specific 
optimised __ffs variants. So it still bails on as soon as the last set 
bit "goes away" just differently.

I will need to redo the tests with the state_mask breakage fixed.
>> +		if (likely(groupc->tasks[t])) {
>>   			groupc->tasks[t]--;
>>   		} else if (!psi_bug) {
>> -			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
>> +			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%lu tasks=[%u %u %u %u] clear=%x set=%x\n",
>>   					cpu, t, groupc->tasks[0],
>>   					groupc->tasks[1], groupc->tasks[2],
>>   					groupc->tasks[3], clear, set);
>> @@ -838,9 +825,9 @@ static void psi_group_change(struct psi_group *group, int cpu,
>>   		}
>>   	}
>>   
>> -	for (t = 0; set; set &= ~(1 << t), t++)
>> -		if (set & (1 << t))
>> -			groupc->tasks[t]++;
>> +	m = set;
>> +	for_each_set_bit(t, &m, ARRAY_SIZE(groupc->tasks))
>> +		groupc->tasks[t]++;
>>   
>>   	if (!group->enabled) {
>>   		/*
>> @@ -853,6 +840,13 @@ static void psi_group_change(struct psi_group *group, int cpu,
>>   		if (unlikely(groupc->state_mask & (1 << PSI_NONIDLE)))
>>   			record_times(groupc, now);
>>   
>> +		if (unlikely(clear & TSK_ONCPU))
>> +			state_mask = 0;
>> +		else if (unlikely(set & TSK_ONCPU))
>> +			state_mask = PSI_ONCPU;
>> +		else
>> +			state_mask = groupc->state_mask & PSI_ONCPU;
> 
> You moved it here, but this is the !group->enabled exception
> only. What about the common case when the group is enabled?

Yep, I was blind. I will get back to you with v2 if there is still some 
cpu cycles to be saved.

Regards,

Tvrtko


