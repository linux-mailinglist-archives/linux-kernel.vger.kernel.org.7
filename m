Return-Path: <linux-kernel+bounces-722030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BDDAFD2A9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B224F585B2D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1662E5B12;
	Tue,  8 Jul 2025 16:45:50 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61491FC0F3
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993150; cv=none; b=GBETIQfTjEZ2U6rednqyMAckSUt/f+cEvqpvZs0hmvVnHsNFexfrvgShz2LR9Ian+Bx1naZ5kYD6Zjb3vFd2RaUmEYq7SanOzidFNiFokH0hiVeyJ7yli6fCbI+jcVx4oPs05Pd5Vzwhe6r8OjcVUVC7ClnBQDvhDuZPzYiYR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993150; c=relaxed/simple;
	bh=gMh1/6uKY/DJAiBuQ8tbnP4Nsixfq+DafeaOp6S24dc=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hqcu0+pWHbCGSEoN7XPSjLN2T94IRNNATmOavBXj70D4OXjNJhSb6NHXQmwLos5cH0uSnYZvTSg9dQQ3upAsmYaRE9Qe3fPDcXa9QIn6fV/D11uOOiQihZvmEI67Fz7QiF9LLPv5lX/eRCRmX0t+Q5I0BosqS8K9FSA4ahthcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bc6Np08FVz1d1jX;
	Wed,  9 Jul 2025 00:43:06 +0800 (CST)
Received: from kwepemh100012.china.huawei.com (unknown [7.202.181.97])
	by mail.maildlp.com (Postfix) with ESMTPS id C0019180B63;
	Wed,  9 Jul 2025 00:45:43 +0800 (CST)
Received: from [10.174.177.133] (10.174.177.133) by
 kwepemh100012.china.huawei.com (7.202.181.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 00:45:43 +0800
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBocnRpbWVyczogVXBkYXRlIG5ldyBD?=
 =?UTF-8?Q?PU=27s_next_event_in_hrtimers=5fcpu=5fdying=28=29?=
From: "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
To: Frederic Weisbecker <frederic@kernel.org>, "wangxiongfeng (C)"
	<wangxiongfeng2@huawei.com>
CC: "anna-maria@linutronix.de" <anna-maria@linutronix.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Xiexiuqi <xiexiuqi@huawei.com>
References: <20250708101727.166892-1-wangxiongfeng2@huawei.com>
 <aG0RxASJqknbaUkM@localhost.localdomain>
 <d29ca2b182db4e8cba35db51467a961c@huawei.com>
Message-ID: <5228e7ee-f3d3-05df-2a95-ec64d963073d@huawei.com>
Date: Wed, 9 Jul 2025 00:45:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d29ca2b182db4e8cba35db51467a961c@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemh100012.china.huawei.com (7.202.181.97)

在 2025/7/9 0:23, Wangshaobo (bobo) 写道:
> -----邮件原件-----
> 发件人: Frederic Weisbecker [mailto:frederic@kernel.org]
> 发送时间: 2025年7月8日 20:41
> 收件人: wangxiongfeng (C) <wangxiongfeng2@huawei.com>
> 抄送: anna-maria@linutronix.de; tglx@linutronix.de; linux-kernel@vger.kernel.org; Xiexiuqi <xiexiuqi@huawei.com>; Wangshaobo (bobo) <bobo.shaobowang@huawei.com>
> 主题: Re: [PATCH] hrtimers: Update new CPU's next event in hrtimers_cpu_dying()
> 
> Le Tue, Jul 08, 2025 at 06:17:27PM +0800, Xiongfeng Wang a écrit :
>> When testing softirq based hrtimers on an ARM32 board, with high
>> resolution mode and nohz are both inactive, softirq based hrtimers
>> failed to trigger when moved away from an offline CPU. The flowpath is
>> as follows.
>>
>> CPU0				CPU1
>> 				softirq based hrtimers are queued
>> 				offline CPU1
>> 				move hrtimers to CPU0 in hrtimers_cpu_dying()
>> 				send IPI to CPU0 to retrigger next event 'softirq_expires_next' is
>> KTIME_MAX call retrigger_next_event() highres and nohz is
>> inactive,just return 'softirq_expires_next' is not updated hrtimer
>> softirq is never triggered
>>
>> Some softirq based hrtimers are queued on CPU1. Then we offline CPU1.
>> hrtimers_cpu_dying() moves hrtimers from CPU1 to CPU0, and then it
>> send a IPI to CPU0 to let CPU0 call retrigger_next_event(). But high
>> resolution mode and nohz are both inactive. So retrigger_next_event()
>> just returned. 'softirq_expires_next' is never updated and remains
>> KTIME_MAX. So hrtimer softirq is never raised.
>>
>> To fix this issue, we call hrtimer_update_next_event() in
>> hrtimers_cpu_dying() to update 'softirq_expires_next' for the new CPU.
>> It also update hardirq hrtimer's next event, but it should have no bad
>> effect.
>>
>> Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from
>> outgoing CPU earlier")
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>   kernel/time/hrtimer.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c index
>> 30899a8cc52c..ff97eb36c116 100644
>> --- a/kernel/time/hrtimer.c
>> +++ b/kernel/time/hrtimer.c
>> @@ -2298,8 +2298,11 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
>>   	/*
>>   	 * The migration might have changed the first expiring softirq
>>   	 * timer on this CPU. Update it.
>> +	 * We also need to update 'softirq_expires_next' here, because it will
>> +	 * not be updated in retrigger_next_event() if high resolution mode
>> +	 * and nohz are both inactive.
>>   	 */
>> -	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
>> +	hrtimer_update_next_event(new_base);
>>   	/* Tell the other CPU to retrigger the next event */
>>   	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
> 
> It seems that a similar problem can happen while enqueueing a timer from an offline CPU (see the call to smp_call_function_single_async()).
> 
> How about this (untested) instead? retrigger_next_event, is not a fast path so we don't care about rare extra cost:
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c index 30899a8cc52c..e8c479329282 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -787,10 +787,10 @@ static void retrigger_next_event(void *arg)
>   	 * of the next expiring timer is enough. The return from the SMP
>   	 * function call will take care of the reprogramming in case the
>   	 * CPU was in a NOHZ idle sleep.
> +	 *
> +	 * In periodic low resolution mode, the next softirq expiration
> +	 * must also be updated.
>   	 */
> -	if (!hrtimer_hres_active(base) && !tick_nohz_active)
> -		return;
> 

Could you explain in detail why this judgment is added? Is it due to 
security issues or efficiency impact?

- Wang ShaoBo

>
> 
> 	raw_spin_lock(&base->lock);
>   	hrtimer_update_base(base);
>   	if (hrtimer_hres_active(base))
> @@ -2295,11 +2295,6 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
>   				     &new_base->clock_base[i]);
>   	}
>   
> -	/*
> -	 * The migration might have changed the first expiring softirq
> -	 * timer on this CPU. Update it.
> -	 */
> -	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
>   	/* Tell the other CPU to retrigger the next event */
>   	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
>   
> 

