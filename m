Return-Path: <linux-kernel+bounces-722709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED97AFDE0B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0092C174B0D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF2F1E5B91;
	Wed,  9 Jul 2025 03:18:28 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDAC35897
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 03:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752031107; cv=none; b=km8NZpKS/K19zlK7A4NsJUWzj3IW39pj8g/HpDGOXJZkWFgR2X7zeQR5j9naiIwG4XiFWZlzpo1nBi3DjgPLhf1PcTml9wtlIo5l78WB90DtyPp/aYI6egC+Cr9WEVqnJbB1CKAQYctroG/2nxyDNomuE/HukbZH/I0MUgME6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752031107; c=relaxed/simple;
	bh=WOtMu6HA03N/Gs2bBS53VqKpSSICtXsdSrrwofHawV0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DH7R2SPpiKcc4CVxaaExcnABzC1IcwPORLGza0mrZ+CNpfvxu84KEFfvygHLHm07tuv0vGMkRuriVXCu5G3uvTqiWGgJcH5IfXHrYGrPgMM4tkhhRp5qlgscblZftbt6t+uCpqv3QfNlWy4594qHzizUl1mMebtg0k1k6Y4zzN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bcNSP2nlnztSnj;
	Wed,  9 Jul 2025 11:17:09 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id F38E2180482;
	Wed,  9 Jul 2025 11:18:15 +0800 (CST)
Received: from kwepemq500009.china.huawei.com (7.202.195.53) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 11:18:15 +0800
Received: from [10.174.179.5] (10.174.179.5) by kwepemq500009.china.huawei.com
 (7.202.195.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 9 Jul
 2025 11:18:15 +0800
Subject: Re: [PATCH] hrtimers: Update new CPU's next event in
 hrtimers_cpu_dying()
To: Frederic Weisbecker <frederic@kernel.org>
CC: <anna-maria@linutronix.de>, <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
	<bobo.shaobowang@huawei.com>
References: <20250708101727.166892-1-wangxiongfeng2@huawei.com>
 <aG0RxASJqknbaUkM@localhost.localdomain>
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <cb65f989-eb16-f2d0-3a58-32deb3f65fb8@huawei.com>
Date: Wed, 9 Jul 2025 11:18:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aG0RxASJqknbaUkM@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500009.china.huawei.com (7.202.195.53)

Hi Frederic,

On 2025/7/8 20:40, Frederic Weisbecker wrote:
> Le Tue, Jul 08, 2025 at 06:17:27PM +0800, Xiongfeng Wang a écrit :
>> When testing softirq based hrtimers on an ARM32 board, with high
>> resolution mode and nohz are both inactive, softirq based hrtimers
>> failed to trigger when moved away from an offline CPU. The flowpath
>> is as follows.
>>
>> CPU0				CPU1
>> 				softirq based hrtimers are queued
>> 				offline CPU1
>> 				move hrtimers to CPU0 in hrtimers_cpu_dying()
>> 				send IPI to CPU0 to retrigger next event
>> 'softirq_expires_next' is KTIME_MAX
>> call retrigger_next_event()
>> highres and nohz is inactive,just return
>> 'softirq_expires_next' is not updated
>> hrtimer softirq is never triggered
>>
>> Some softirq based hrtimers are queued on CPU1. Then we offline CPU1.
>> hrtimers_cpu_dying() moves hrtimers from CPU1 to CPU0, and then it send
>> a IPI to CPU0 to let CPU0 call retrigger_next_event(). But high
>> resolution mode and nohz are both inactive. So retrigger_next_event()
>> just returned. 'softirq_expires_next' is never updated and remains
>> KTIME_MAX. So hrtimer softirq is never raised.
>>
>> To fix this issue, we call hrtimer_update_next_event() in
>> hrtimers_cpu_dying() to update 'softirq_expires_next' for the new CPU.
>> It also update hardirq hrtimer's next event, but it should have no bad
>> effect.
>>
>> Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  kernel/time/hrtimer.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
>> index 30899a8cc52c..ff97eb36c116 100644
>> --- a/kernel/time/hrtimer.c
>> +++ b/kernel/time/hrtimer.c
>> @@ -2298,8 +2298,11 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
>>  	/*
>>  	 * The migration might have changed the first expiring softirq
>>  	 * timer on this CPU. Update it.
>> +	 * We also need to update 'softirq_expires_next' here, because it will
>> +	 * not be updated in retrigger_next_event() if high resolution mode
>> +	 * and nohz are both inactive.
>>  	 */
>> -	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
>> +	hrtimer_update_next_event(new_base);
>>  	/* Tell the other CPU to retrigger the next event */
>>  	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
> 
> It seems that a similar problem can happen while enqueueing a timer
> from an offline CPU (see the call to smp_call_function_single_async()).
> 
> How about this (untested) instead? retrigger_next_event, is not a fast
> path so we don't care about rare extra cost:

This modification can solve the problem. Thanks a lot.

> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 30899a8cc52c..e8c479329282 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -787,10 +787,10 @@ static void retrigger_next_event(void *arg)
>  	 * of the next expiring timer is enough. The return from the SMP
>  	 * function call will take care of the reprogramming in case the
>  	 * CPU was in a NOHZ idle sleep.
> +	 *
> +	 * In periodic low resolution mode, the next softirq expiration
> +	 * must also be updated.
>  	 */
> -	if (!hrtimer_hres_active(base) && !tick_nohz_active)
> -		return;

Once we remove this check. The problem disappears.
Also I noticed that we check whether highres is active before we really program
the hardware in __hrtimer_reprogram(). So if the above check in
retrigger_next_event() is just to decrease extra cost, I think we can remove it.

Thanks,
Xiongfeng

> -
>  	raw_spin_lock(&base->lock);
>  	hrtimer_update_base(base);
>  	if (hrtimer_hres_active(base))
> @@ -2295,11 +2295,6 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
>  				     &new_base->clock_base[i]);
>  	}
>  
> -	/*
> -	 * The migration might have changed the first expiring softirq
> -	 * timer on this CPU. Update it.
> -	 */
> -	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
>  	/* Tell the other CPU to retrigger the next event */
>  	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
>  
> .
> 

