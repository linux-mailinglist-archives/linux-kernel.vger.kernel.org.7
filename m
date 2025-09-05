Return-Path: <linux-kernel+bounces-801908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CF0B44B75
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686EAA42070
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD272080C8;
	Fri,  5 Sep 2025 02:06:33 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4298A8834
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757037992; cv=none; b=PC1v01nNdWXuSfbhhuq9TKQDB4vWmWos41vXPr6/ZLKgINfZXgAztPQ81Lj+mzyDdKrVB4v3C+LRRW4/CeI4rlyqygYcDUEc1n3RYZxTLL0K9zf9K1lLpStwWAeyCtTT7OYj4LG1kA63/ghjKxjpgzGW4w5LbtOnGDobP/g0Tb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757037992; c=relaxed/simple;
	bh=jWWA8e4f4ha2Dp6mGCmULD3qf2IKoMr5xgmCucDlwS0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SsSwWTHKPvTlruoIdkoj+JsHgOt/jfdXQenSxLS6n+7ach5BsSYribDYLngM1klaKYh8fcZT8RncSdP9nkyI8S19nTkUZ4tDNbZNscXZzz80DYm1KxWB9aAYEFJsetV0DEjD6ZpLpMMfeS/7aW403gPQ0Ax6ni+bUJs8vsjWMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Dx_7+aRbpooOcGAA--.14125S3;
	Fri, 05 Sep 2025 10:06:19 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxT+aVRbpoMER_AA--.7370S3;
	Fri, 05 Sep 2025 10:06:18 +0800 (CST)
Subject: Re: [PATCH v2 1/2] tick: Remove unreasonable detached state set in
 tick_shutdown()
To: Thomas Gleixner <tglx@linutronix.de>, Huacai Chen
 <chenhuacai@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 Xianglai Li <lixianglai@loongson.cn>
References: <20250904071732.3513694-1-maobibo@loongson.cn>
 <20250904071732.3513694-2-maobibo@loongson.cn> <87frd2xlat.ffs@tglx>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <5d9fe6d9-d694-6a46-96be-9f7306cd9be0@loongson.cn>
Date: Fri, 5 Sep 2025 10:04:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87frd2xlat.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxT+aVRbpoMER_AA--.7370S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xry8Aw1DGF1DJrWDGw1DCFX_yoW7WryUpF
	ykJF1YgrWkK3y0g3Waqw1kWF9xGay8Aws5Gw13G3s2krWrJryrtF4DKFWUAryrC39xZws2
	qa4Fqr18CFWUAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUU
	U



On 2025/9/4 下午11:57, Thomas Gleixner wrote:
> On Thu, Sep 04 2025 at 15:17, Bibo Mao wrote:
>> Function clockevents_switch_state() will check whether it has already
>> switched to specified state, do nothing if it has.
>>
>> In function tick_shutdown(), it will set detached state at first and
>> call clockevents_switch_state() in clockevents_exchange_device(). The
>> function clockevents_switch_state() will do nothing since it is already
>> detached state. So the tick timer device will not be shutdown when CPU
>> is offline. In guest VM system, timer interrupt will prevent vCPU to
>> sleep if vCPU is hot removed.
>>
>> Here remove state set before calling clockevents_exchange_device(),
>> its state will be set in function clockevents_switch_state() if it
>> succeeds to do so.
> 
> This explanation is incomplete. tick_shutdown() did this because it was
> originally invoked on a life CPU and not on the outgoing CPU.
> 
> That got changed in
> 
>    3b1596a21fbf ("clockevents: Shutdown and unregister current clockevents at CPUHP_AP_TICK_DYING")
> 
> which is the actual root cause.
> 
> The pile of 'Fixes:' below is just enumerating the subsequent problems.
> 
>> Fixes: bf9a001fb8e4 ("clocksource/drivers/timer-tegra: Remove clockevents shutdown call on offlining")
>> Fixes: cd165ce8314f ("clocksource/drivers/qcom: Remove clockevents shutdown call on offlining")
>> Fixes: 30f8c70a85bc ("clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on offlining")
>> Fixes: ba23b6c7f974 ("clocksource/drivers/exynos_mct: Remove clockevents shutdown call on offlining")
>> Fixes: 15b810e0496e ("clocksource/drivers/arm_global_timer: Remove clockevents shutdown call on offlining")
>> Fixes: 78b5c2ca5f27 ("clocksource/drivers/arm_arch_timer: Remove clockevents shutdown call on offlining")
>> Fixes: 900053d9eedf ("ARM: smp_twd: Remove clockevents shutdown call on offlining")
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>   kernel/time/tick-common.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
>> index 9a3859443c04..eb9b777f5492 100644
>> --- a/kernel/time/tick-common.c
>> +++ b/kernel/time/tick-common.c
>> @@ -424,11 +424,6 @@ void tick_shutdown(unsigned int cpu)
>>   
>>   	td->mode = TICKDEV_MODE_PERIODIC;
>>   	if (dev) {
>> -		/*
>> -		 * Prevent that the clock events layer tries to call
>> -		 * the set mode function!
>> -		 */
>> -		clockevent_set_state(dev, CLOCK_EVT_STATE_DETACHED);
>>   		clockevents_exchange_device(dev, NULL);
>>   		dev->event_handler = clockevents_handle_noop;
>>   		td->evtdev = NULL;
> 
> Can this pretty please cleanup the misleading comment above
> tick_shutdown() as well?
> 
>   * Shutdown an event device on a given cpu:
>   *
>   * This is called on a life CPU, when a CPU is dead. So we cannot
>   * access the hardware device itself.
>   * We just set the mode and remove it from the lists.
> 
> That should have been removed or updated with 3b1596a21fbf too, no?
> 
> With that the cpu argument is not longer useful either, because this is
> now guaranteed to be invoked on the outgoing CPU, no?

It is not easy with my poor English to spell out the comments :(
How about the patch like this?

Function clockevents_switch_state() will check whether it has already
switched to specified state, do nothing if it has.

In function tick_shutdown(), it will set detached state at first and
call clockevents_switch_state() in clockevents_exchange_device(). The
function clockevents_switch_state() will do nothing since it is already
detached state. So the tick timer device will not be shutdown when CPU
is offline.

Function tick_shutdown() did this because it was originally invoked
on a life CPU and not on the outgoing CPU. Now this function is called
on the outgoing CPU, the hardware device can be accessed.

Here remove state set before calling clockevents_exchange_device(), its
state will be set in function clockevents_switch_state() if it succeeds
to do so.

Fixes: 3b1596a21fbf ("clockevents: Shutdown and unregister current 
clockevents at CPUHP_AP_TICK_DYING")


  /*
- * Shutdown an event device on a given cpu:
+ * Shutdown an event device on the outgoing CPU:
   *
- * This is called on a life CPU, when a CPU is dead. So we cannot
- * access the hardware device itself.
- * We just set the mode and remove it from the lists.
+ * Called by the dying CPU during teardown, with clockevents_lock held
+ * and interrupts disabled.
   */
-void tick_shutdown(unsigned int cpu)
+void tick_shutdown(void)
  {
-       struct tick_device *td = &per_cpu(tick_cpu_device, cpu);
+       struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
         struct clock_event_device *dev = td->evtdev;

         td->mode = TICKDEV_MODE_PERIODIC;
         if (dev) {
-               /*
-                * Prevent that the clock events layer tries to call
-                * the set mode function!
-                */
-               clockevent_set_state(dev, CLOCK_EVT_STATE_DETACHED);
                 clockevents_exchange_device(dev, NULL);
                 dev->event_handler = clockevents_handle_noop;
                 td->evtdev = NULL;

Regards
Bibo Mao
> 
> Thanks,
> 
>          tglx
> 


