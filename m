Return-Path: <linux-kernel+bounces-764791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C3FB2275F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED904501446
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D826AA88;
	Tue, 12 Aug 2025 12:50:17 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0731225949A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003017; cv=none; b=gA6PHUcUvUlS8UjVHsmZexHXmvChs/LsbUO1fhUbyavJntQQSw/1wPHg3RupJlu52+5cRvTVbJuVvHByMssK03fTCLNv0v91kdFz5z/O/HfLz4oQ5LhBg9VVX6viTGVIiIU0iTTyWDfbtFpr3uzsbutmwciPXEauuhBeNwLJf3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003017; c=relaxed/simple;
	bh=BQ9qfFghJkHCuYTaa5QLrx/7K3yz+3ozWDI00+epl04=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=G/2yrclZecTD9M9343Mjg0RbX+P22rMHt/eubdV4X3CTVvHT9kmNkUN7howsuhaTmJovBCBk6TKzJYKls3om8bRxA4N7mx3+bTr0Dzet3w+1WlR2OaW0rFlFEt1WfyqbrnJrZ0XrVangtpHIieFQC/Jtg0AvsQ7PCm5rkF436Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.126])
	by gateway (Coremail) with SMTP id _____8AxlnB+OJtoS_Y+AQ--.53318S3;
	Tue, 12 Aug 2025 20:50:06 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
	by front1 (Coremail) with SMTP id qMiowJAxE+R6OJtoeaNGAA--.5023S3;
	Tue, 12 Aug 2025 20:50:05 +0800 (CST)
Subject: Re: [PATCH] LoongArch: time: Fix the issue of high cpu usage of vcpu
 threads in virtual machines
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Bibo Mao <maobibo@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250812090056.771379-1-lixianglai@loongson.cn>
 <CAAhV-H7pXxFR8PnAOv8CirotXUSPgbb7AEsHU0VGh_YMFFoyJA@mail.gmail.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <da4311b0-7e8e-647a-260f-1733878cf394@loongson.cn>
Date: Tue, 12 Aug 2025 20:48:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7pXxFR8PnAOv8CirotXUSPgbb7AEsHU0VGh_YMFFoyJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJAxE+R6OJtoeaNGAA--.5023S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1rZr1xCw47Ar15Kw48GrX_yoWrAF45pr
	WkCFs8KrZYkrn2vw13t3srZFy3tw4kGw12vFyfXF17Ar9rZr9YgF40qryq9Fy5Jaykur40
	vw10vrnxuF4DtrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
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
> Hi, Xianglai,
>
> There is something that can be improved.
>
> On Tue, Aug 12, 2025 at 5:24 PM Xianglai Li <lixianglai@loongson.cn> wrote:
>> When the cpu is offline, the timer under loongarch is not correctly closed,
>> resulting in an excessively high cpu usage rate of the offline vcpu thread
>> in the virtual machine.
>>
>> To correctly close the timer, we have made the following modifications:
>>
>> Register the cpu hotplug timer start event for loongarch.This event will
>> be called to close the timer when the cpu is offline.
>>
>> Clear the timer interrupt when the timer is turned off
>>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> ---
>>   arch/loongarch/kernel/time.c | 20 ++++++++++++++++++++
>>   include/linux/cpuhotplug.h   |  1 +
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
>> index 367906b10f81..4daa11512eba 100644
>> --- a/arch/loongarch/kernel/time.c
>> +++ b/arch/loongarch/kernel/time.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/sched_clock.h>
>>   #include <linux/spinlock.h>
>> +#include <linux/cpu.h>
>>
>>   #include <asm/cpu-features.h>
>>   #include <asm/loongarch.h>
>> @@ -86,6 +87,9 @@ static int constant_set_state_shutdown(struct clock_event_device *evt)
>>          timer_config &= ~CSR_TCFG_EN;
>>          csr_write64(timer_config, LOONGARCH_CSR_TCFG);
>>
>> +       /* Clear Timer Interrupt */
>> +       write_csr_tintclear(CSR_TINTCLR_TI);
>> +
>>          raw_spin_unlock(&state_lock);
>>
>>          return 0;
>> @@ -208,8 +212,17 @@ int __init constant_clocksource_init(void)
>>          return res;
>>   }
>>
>> +static int arch_timer_dying_cpu(unsigned int cpu)
> We can use arch_timer_dying() for short. And then add an
> arch_timer_starting() like this:
>
> static int arch_timer_starting(unsigned int cpu)
> {
>          set_csr_ecfg(ECFGF_TIMER);
>
>          return 0;
> }
>
> Though ECFGF_TIMER may be enabled in other places, for syntax we need it here.
>
>> +{
>> +       constant_set_state_shutdown(NULL);
>> +
>> +       return 0;
>> +}
>> +
>>   void __init time_init(void)
>>   {
>> +       int err;
>> +
>>          if (!cpu_has_cpucfg)
>>                  const_clock_freq = cpu_clock_freq;
>>          else
>> @@ -220,4 +233,11 @@ void __init time_init(void)
>>          constant_clockevent_init();
>>          constant_clocksource_init();
>>          pv_time_init();
>> +
>> +       err = cpuhp_setup_state_nocalls(CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
>> +                                       "loongarch/timer:starting",
>> +                                       NULL, arch_timer_dying_cpu);
> Then we need use cpuhp_setup_state() here, because we have a startup
> function now.
>
> And "loongarch/timer:starting" should be
> "clockevents/loongarch/timer:starting" like others.
>
> And the whole should be moved to the last of
> constant_clockevent_init() because it is clockevent specific.

like this?

@@ -164,6 +182,10 @@ int constant_clockevent_init(void)

         timer_irq_installed = 1;

+       cpuhp_setup_state(CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
+                         "clockevents/loongarch/timer:starting",
+                         arch_timer_starting, arch_timer_dying_cpu);
+
         sync_counter();


I was wondering whether it should be placed before or after the 
"timer_irq_installed" judgment


>> +       if (err)
>> +               pr_info("cpu hotplug event register failed");
> This is not so useful, because the error isn't fatal.
>
>
> Huacai
>
>> +
>>   }
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index edfa61d80702..6606c1546afc 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -159,6 +159,7 @@ enum cpuhp_state {
>>          CPUHP_AP_PERF_ARM_STARTING,
>>          CPUHP_AP_PERF_RISCV_STARTING,
>>          CPUHP_AP_ARM_L2X0_STARTING,
>> +       CPUHP_AP_LOONGARCH_ARCH_TIMER_STARTING,
>>          CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>>          CPUHP_AP_ARM_ARCH_TIMER_STARTING,
>>          CPUHP_AP_ARM_ARCH_TIMER_EVTSTRM_STARTING,
>>
>> base-commit: 53e760d8949895390e256e723e7ee46618310361
>> --
>> 2.39.1
>>


