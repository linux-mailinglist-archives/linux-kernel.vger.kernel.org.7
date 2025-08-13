Return-Path: <linux-kernel+bounces-765752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578DDB23DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9562A77E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58191199934;
	Wed, 13 Aug 2025 01:41:23 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D10E2C0F6F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049282; cv=none; b=oUuKbLAcVt3NqXfUaV/ihneTR/xNvNCW2r8PXCCRNN68+F0at8QGxLg44Av0eaBoHf7zqsFp6LDD6bHMMZ35PIuF12Wu7c4qIfmWxUA2+j/oo1EjXvabbHRXXLBQ/lh1TwuVO+TyeC7AE8G3NM/IjxLvlRrkMXznHwWUUMXdIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049282; c=relaxed/simple;
	bh=kw8408HuwYLqZ5Gs1QhHwXIggsYHzqYnO5HxaEkSCAo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uZojXKdMLQzfvHB3PvknHz7E2Z03pa7yaD745KGh7HCSH0zPmU0/ZO9a7QdM54HVjMmXbFuBI4v3oppNs6++ugcrW3pSGeqPMTvfAJug2J9wd+0gz2ChOair4WPF6my3+PmFvQA/COwGFFtC4pkAAbFGs8bxW5yXBxC6RUC09sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.126])
	by gateway (Coremail) with SMTP id _____8AxlnA57Ztobys_AQ--.53782S3;
	Wed, 13 Aug 2025 09:41:13 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
	by front1 (Coremail) with SMTP id qMiowJCxdOQv7ZtoCf5HAA--.11751S3;
	Wed, 13 Aug 2025 09:41:11 +0800 (CST)
Subject: Re: [PATCH] LoongArch: time: Fix the issue of high cpu usage of vcpu
 threads in virtual machines
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Bibo Mao <maobibo@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250812090056.771379-1-lixianglai@loongson.cn>
 <CAAhV-H7pXxFR8PnAOv8CirotXUSPgbb7AEsHU0VGh_YMFFoyJA@mail.gmail.com>
 <da4311b0-7e8e-647a-260f-1733878cf394@loongson.cn>
 <CAAhV-H7uhvZeZ9L40AWuRN7t4JAFLNDj4YUOZ_K-oPrCcnpEjA@mail.gmail.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <13a54d23-24c2-8e59-77ac-900a63cd38ef@loongson.cn>
Date: Wed, 13 Aug 2025 09:39:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7uhvZeZ9L40AWuRN7t4JAFLNDj4YUOZ_K-oPrCcnpEjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJCxdOQv7ZtoCf5HAA--.11751S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxKrWUXr45uw13Jr1xKr45Jwc_yoW7WF1Dpr
	WDCFs8Krs5Kr1avw1aq3sFvF9xKw4kGr12vF93Gr17Ar9FvF93WF48tryq9FyrGFWDuF40
	vw10qws3uFWDtrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==

Hi Huacai Chen:
> On Tue, Aug 12, 2025 at 8:50 PM lixianglai <lixianglai@loongson.cn> wrote:
>>
>>
>> Hi Huacai Chen:
>>> Hi, Xianglai,
>>>
>>> There is something that can be improved.
>>>
>>> On Tue, Aug 12, 2025 at 5:24 PM Xianglai Li <lixianglai@loongson.cn> wrote:
>>>> When the cpu is offline, the timer under loongarch is not correctly closed,
>>>> resulting in an excessively high cpu usage rate of the offline vcpu thread
>>>> in the virtual machine.
>>>>
>>>> To correctly close the timer, we have made the following modifications:
>>>>
>>>> Register the cpu hotplug timer start event for loongarch.This event will
>>>> be called to close the timer when the cpu is offline.
>>>>
>>>> Clear the timer interrupt when the timer is turned off
>>>>
>>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>>> ---
>>>>    arch/loongarch/kernel/time.c | 20 ++++++++++++++++++++
>>>>    include/linux/cpuhotplug.h   |  1 +
>>>>    2 files changed, 21 insertions(+)
>>>>
>>>> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
>>>> index 367906b10f81..4daa11512eba 100644
>>>> --- a/arch/loongarch/kernel/time.c
>>>> +++ b/arch/loongarch/kernel/time.c
>>>> @@ -12,6 +12,7 @@
>>>>    #include <linux/kernel.h>
>>>>    #include <linux/sched_clock.h>
>>>>    #include <linux/spinlock.h>
>>>> +#include <linux/cpu.h>
>>>>
>>>>    #include <asm/cpu-features.h>
>>>>    #include <asm/loongarch.h>
>>>> @@ -86,6 +87,9 @@ static int constant_set_state_shutdown(struct clock_event_device *evt)
>>>>           timer_config &= ~CSR_TCFG_EN;
>>>>           csr_write64(timer_config, LOONGARCH_CSR_TCFG);
>>>>
>>>> +       /* Clear Timer Interrupt */
>>>> +       write_csr_tintclear(CSR_TINTCLR_TI);
>>>> +
>>>>           raw_spin_unlock(&state_lock);
>>>>
>>>>           return 0;
>>>> @@ -208,8 +212,17 @@ int __init constant_clocksource_init(void)
>>>>           return res;
>>>>    }
>>>>
>>>> +static int arch_timer_dying_cpu(unsigned int cpu)
>>> We can use arch_timer_dying() for short. And then add an
>>> arch_timer_starting() like this:
>>>
>>> static int arch_timer_starting(unsigned int cpu)
>>> {
>>>           set_csr_ecfg(ECFGF_TIMER);
>>>
>>>           return 0;
>>> }
>>>
>>> Though ECFGF_TIMER may be enabled in other places, for syntax we need it here.
>>>
>>>> +{
>>>> +       constant_set_state_shutdown(NULL);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>>    void __init time_init(void)
>>>>    {
>>>> +       int err;
>>>> +
>>>>           if (!cpu_has_cpucfg)
>>>>                   const_clock_freq = cpu_clock_freq;
>>>>           else
>>>> @@ -220,4 +233,11 @@ void __init time_init(void)
>>>>           constant_clockevent_init();
>>>>           constant_clocksource_init();
>>>>           pv_time_init();
>>>> +
>>>> +       err = cpuhp_setup_state_nocalls(CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
>>>> +                                       "loongarch/timer:starting",
>>>> +                                       NULL, arch_timer_dying_cpu);
>>> Then we need use cpuhp_setup_state() here, because we have a startup
>>> function now.
>>>
>>> And "loongarch/timer:starting" should be
>>> "clockevents/loongarch/timer:starting" like others.
>>>
>>> And the whole should be moved to the last of
>>> constant_clockevent_init() because it is clockevent specific.
>> like this?
>>
>> @@ -164,6 +182,10 @@ int constant_clockevent_init(void)
>>
>>           timer_irq_installed = 1;
>>
>> +       cpuhp_setup_state(CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
>> +                         "clockevents/loongarch/timer:starting",
>> +                         arch_timer_starting, arch_timer_dying_cpu);
>> +
>>           sync_counter();
>>
>>
>> I was wondering whether it should be placed before or after the
>> "timer_irq_installed" judgment
> Should be after "timer_irq_installed" because we only need to run once.
>
> The best place is after pr_info("Constant clock event device register\n");

Got it!
> And there is another question:
> Should we move "write_csr_tintclear(CSR_TINTCLR_TI)" from
> constant_set_state_shutdown() to arch_timer_dying()?

We may not need to do this. If the context in which the timer is
turned off is to disable interrupts, and the last timing period just
arrives during this process, when the interrupt is re-enabled,
an additional interrupt will be triggered and the next timing expiration
time will be filled. This is not in line with expectations.
Isn't it more reasonable to clean up the interrupt flag after turning off
the timer instead of just doing so cpu offline context cleaning.

Thanks!
Xianglai.

>
> Huacai
>
>>
>>>> +       if (err)
>>>> +               pr_info("cpu hotplug event register failed");
>>> This is not so useful, because the error isn't fatal.
>>>
>>>
>>> Huacai
>>>
>>>> +
>>>>    }
>>>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>>>> index edfa61d80702..6606c1546afc 100644
>>>> --- a/include/linux/cpuhotplug.h
>>>> +++ b/include/linux/cpuhotplug.h
>>>> @@ -159,6 +159,7 @@ enum cpuhp_state {
>>>>           CPUHP_AP_PERF_ARM_STARTING,
>>>>           CPUHP_AP_PERF_RISCV_STARTING,
>>>>           CPUHP_AP_ARM_L2X0_STARTING,
>>>> +       CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
>>>>           CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>>>>           CPUHP_AP_ARM_ARCH_TIMER_STARTING,
>>>>           CPUHP_AP_ARM_ARCH_TIMER_EVTSTRM_STARTING,
>>>>
>>>> base-commit: 53e760d8949895390e256e723e7ee46618310361
>>>> --
>>>> 2.39.1
>>>>
>>


