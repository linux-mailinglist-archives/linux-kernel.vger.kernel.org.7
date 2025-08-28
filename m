Return-Path: <linux-kernel+bounces-789484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A37B39638
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE7B1BA815F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14542D6E7C;
	Thu, 28 Aug 2025 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="NgzAH/ul"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9F9849C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368462; cv=none; b=DcyO4u/+3+iJLUg7JdkGrWdOi16pWyFCtFsJbFlwU6XEpyi/NOzv7LzNt18k30MaEUFV6JbhuFHETVZdgj3jJqY0xLFdfSA3UEquHZgo9NuqPl3dDd5B12wGD5eM4kwIThE60WzDWbY8LLVqsvRbK54PQSttXyS54i7iZ4J6C+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368462; c=relaxed/simple;
	bh=RbXkeFar9HSixEF6Zd0LUhhyRwTJq/+H40/JVY5iWzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6si5KgJpk971K+QWb3QoLBNgkYpnRSNABS2ImjfKkQRXlftM+rrSbUNxh4YTkv72t5veVwWhGqrGkzFmRTs0aDgpsPf3FzO+0DKpx7/LFBSqKbSazHTI+aT+ZTVzCrG2V383RqcgX1s3Z7k5OhzWOkpiKRXtH5QUNw4XYMgpp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=NgzAH/ul; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so453479a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756368458; x=1756973258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwiUz45SZp0QbktCDDzI8S8ZztMxoNXM0JK+vCoNnjo=;
        b=NgzAH/ulJVPTDVtvBHP/zdnqxHCU/y1HjJF4L/GGOkAXCGmCh7tIwmyuh/pXp/0CGS
         qFa3tgo8ZOIB/JwOYdwE0kJOnSebH1AkyAS/bKVVzHKWQ/NsXTxNu1L7rViFNR2lWr3E
         ME351MYlvqEAeIPKcWRuih2lgmZRdST7V2Ftzq1U7b5qGl9IqzuD1/CArJzwm4GJLYo6
         djuT+TFnpU+JeXvVp/7XPRJPjrl2OEp+B0voQNlljgm3TiJ1UqkS3uri8XHvHfeiC+2z
         QiGG52B0U+vvMzmrl5WHn0ZJERtZQ4pnydubP8TpZ2I+yXYEFQKO3zX205OydeXwvOTf
         ZMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756368458; x=1756973258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwiUz45SZp0QbktCDDzI8S8ZztMxoNXM0JK+vCoNnjo=;
        b=q0leqfqTNHkjbFUTEFyYFLHgKM6ETmpXtfHDmixsdn6MIZdJ52sJR3ID2fMfRBQmH9
         2osNt2rWLqzVrBHxg83UiWdS6cqO3rVKFrFzTkilkI7Bmm0UfHK6RWYzG0ASndjKX/AK
         e2vt8KKG5YFjY18ZO6o+fTs1a1OVc0YP7erY6yQOJQUzC7YSjSZwG162LYisO+jQUCpC
         /Ury8PgrBANVOkl+STRWqVwz0Kj6c6Ro3JIAi2IXwwaNay5gfrMNLVakql3AZ48zDnv0
         zqa6Fum67X15mQiFB9TFsqkTdfYlEWkAXJ2ygncqFq408AmDLl5L5vwoY9UIWigfnWow
         sxAA==
X-Forwarded-Encrypted: i=1; AJvYcCVSnQymuppTTPKsLIypahhuFuU0A1rGUNjrnCMT5z7hQFdT/ckYnlfPbRG7ACLNQBKUTT8O14X62FJWxYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwsnd4ALHwtRyDvpXddVklZqJYIqJmbXlSbv+ngXM6H9BAPLJX
	DAj1zjRx3sjkWEcrWjqLgJ4Bu05Ofr+c8cAcwMAiGX1ZtGq2w1iTRDjfMx1Hv1FMo7M=
X-Gm-Gg: ASbGncuylQRQQdPvd+g1me1DUNCTaWf4BGI+sMXdverQ4G0wPjVyxkRgMyGgb/+g8PM
	HIBjUfBPzAbz3uo7l5I/s4hGkGF7wiK1kUKOrOuvbmTqKm/Hcn0tzqE3NLAnEU3vHMpzEEEov7S
	4nqZnGavsefHx75yBYUezQMU2iXYArpmDKAnwIs+VDMtPQ7gJ7kOUBCUKaYKlP0BJ4Kqu20lVSq
	TvBxekTo4b1IvxVGZrJ5oaBzS72i08ib+h7szMou9WCcwo6lipG4qWS03juL0nblzVrZkmhoOhb
	X+pGacars2X3Lwb/TcTjJjNbRxVxp+OS6VzJcWGoTJ+GU0zh0t211B9IUW7gRzFbDD4HX1VV0Kq
	/3u0zbP0z9iM8PDn0ME61En818yb9A86hjC7vLGGWk3F78KJ4OCIOto8U3NltSKx1qbg=
X-Google-Smtp-Source: AGHT+IHNqQVJY1n+VwmBalY6g3sEoTvD3N83vTyNsL6IWy3liqssqYb9XyvoBwh0+g5rPx4FIVETKw==
X-Received: by 2002:a17:903:2c08:b0:248:cd0b:3441 with SMTP id d9443c01a7336-248cd0b3888mr27707015ad.30.1756368458031;
        Thu, 28 Aug 2025 01:07:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877a084sm142672055ad.20.2025.08.28.01.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 01:07:37 -0700 (PDT)
Message-ID: <1b4e39ca-2af7-4e18-9ff2-58fad7bd9472@rivosinc.com>
Date: Thu, 28 Aug 2025 10:07:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] drivers: firmware: add riscv SSE support
To: Alexandre Ghiti <alex@ghiti.fr>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>,
 Atish Patra <atishp@atishpatra.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20250808153901.2477005-1-cleger@rivosinc.com>
 <20250808153901.2477005-4-cleger@rivosinc.com>
 <8b474f27-6632-4706-a6fc-544787d08b5c@ghiti.fr>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <8b474f27-6632-4706-a6fc-544787d08b5c@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alex,

On 13/08/2025 14:08, Alexandre Ghiti wrote:
> 
> On 8/8/25 17:38, Clément Léger wrote:
>> Add driver level interface to use RISC-V SSE arch support. This interface
>> allows registering SSE handlers, and receive them. This will be used by
>> PMU and GHES driver.
>>
>> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
>> Co-developed-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> 
> 
> Here you need to switch the Signed-off-by and the Co-developed-by

Acked.
> 
> 
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>   MAINTAINERS                        |  15 +
>>   drivers/firmware/Kconfig           |   1 +
>>   drivers/firmware/Makefile          |   1 +
>>   drivers/firmware/riscv/Kconfig     |  15 +
>>   drivers/firmware/riscv/Makefile    |   3 +
>>   drivers/firmware/riscv/riscv_sse.c | 694 +++++++++++++++++++++++++++++
>>   include/linux/riscv_sse.h          |  56 +++
>>   7 files changed, 785 insertions(+)
>>   create mode 100644 drivers/firmware/riscv/Kconfig
>>   create mode 100644 drivers/firmware/riscv/Makefile
>>   create mode 100644 drivers/firmware/riscv/riscv_sse.c
>>   create mode 100644 include/linux/riscv_sse.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index bd62ad58a47f..114396d47f76 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21640,6 +21640,13 @@ T:    git git://git.kernel.org/pub/scm/linux/
>> kernel/git/iommu/linux.git
>>   F:    Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>>   F:    drivers/iommu/riscv/
>>   +RISC-V FIRMWARE DRIVERS
>> +M:    Conor Dooley <conor@kernel.org>
>> +L:    linux-riscv@lists.infradead.org
>> +S:    Maintained
>> +T:    git git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git
>> +F:    drivers/firmware/riscv/*
>> +
>>   RISC-V MICROCHIP FPGA SUPPORT
>>   M:    Conor Dooley <conor.dooley@microchip.com>
>>   M:    Daire McNamara <daire.mcnamara@microchip.com>
>> @@ -21704,6 +21711,14 @@ F:    arch/riscv/boot/dts/spacemit/
>>   N:    spacemit
>>   K:    spacemit
>>   +RISC-V SSE DRIVER
>> +M:    Clément Léger <cleger@rivosinc.com>
>> +R:    Himanshu Chauhan <himanshu@thechauhan.dev>
>> +L:    linux-riscv@lists.infradead.org
>> +S:    Maintained
>> +F:    drivers/firmware/riscv/riscv_sse.c
>> +F:    include/linux/riscv_sse.h
>> +
>>   RISC-V THEAD SoC SUPPORT
>>   M:    Drew Fustini <fustini@kernel.org>
>>   M:    Guo Ren <guoren@kernel.org>
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index bbd2155d8483..1894df87b08e 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -294,6 +294,7 @@ source "drivers/firmware/meson/Kconfig"
>>   source "drivers/firmware/microchip/Kconfig"
>>   source "drivers/firmware/psci/Kconfig"
>>   source "drivers/firmware/qcom/Kconfig"
>> +source "drivers/firmware/riscv/Kconfig"
>>   source "drivers/firmware/samsung/Kconfig"
>>   source "drivers/firmware/smccc/Kconfig"
>>   source "drivers/firmware/tegra/Kconfig"
>> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
>> index 4ddec2820c96..6cdd84570ea7 100644
>> --- a/drivers/firmware/Makefile
>> +++ b/drivers/firmware/Makefile
>> @@ -34,6 +34,7 @@ obj-y                += efi/
>>   obj-y                += imx/
>>   obj-y                += psci/
>>   obj-y                += qcom/
>> +obj-y                += riscv/
>>   obj-y                += samsung/
>>   obj-y                += smccc/
>>   obj-y                += tegra/
>> diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/
>> Kconfig
>> new file mode 100644
>> index 000000000000..8056ed3262d9
>> --- /dev/null
>> +++ b/drivers/firmware/riscv/Kconfig
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +menu "Risc-V Specific firmware drivers"
>> +depends on RISCV
>> +
>> +config RISCV_SSE
>> +    bool "Enable SBI Supervisor Software Events support"
>> +    depends on RISCV_SBI
>> +    default y
>> +    help
>> +      The Supervisor Software Events support allow the SBI to deliver
> 
> 
> s/allow/allows
> 
> 
>> +      NMI-like notifications to the supervisor mode software. When
>> enable,
> 
> 
> s/enable/enabled
> 
> 
>> +      this option provides support to register callbacks on specific SSE
>> +      events.
>> +
>> +endmenu
> 
> 
> I think RISCV_SBI_SSE would be more accurate. Why do we need to gate SSE
> support behind this config though? I don't see similar configs for other
> SBI extensions.

SSE is way more intrusive/larger than the other extensions in terms of
code so it made sense to have a config option for it.

> 
> 
>> diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv/
>> Makefile
>> new file mode 100644
>> index 000000000000..4ccfcbbc28ea
>> --- /dev/null
>> +++ b/drivers/firmware/riscv/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_RISCV_SSE)        += riscv_sse.o
>> diff --git a/drivers/firmware/riscv/riscv_sse.c b/drivers/firmware/
>> riscv/riscv_sse.c
>> new file mode 100644
>> index 000000000000..edd107ade94a
>> --- /dev/null
>> +++ b/drivers/firmware/riscv/riscv_sse.c
>> @@ -0,0 +1,694 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2024 Rivos Inc.
>> + */
>> +
>> +#define pr_fmt(fmt) "sse: " fmt
>> +
>> +#include <linux/cpu.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/cpu_pm.h>
>> +#include <linux/hardirq.h>
>> +#include <linux/list.h>
>> +#include <linux/percpu-defs.h>
>> +#include <linux/reboot.h>
>> +#include <linux/riscv_sse.h>
>> +#include <linux/slab.h>
>> +
>> +#include <asm/sbi.h>
>> +#include <asm/sse.h>
>> +
>> +struct sse_event {
>> +    struct list_head list;
>> +    u32 evt_id;
>> +    u32 priority;
>> +    sse_event_handler *handler;
>> +    void *handler_arg;
>> +    /* Only valid for global events */
>> +    unsigned int cpu;
> 
> 
> Nit: Replace unsigned int with u32 to match evt_id and priority
> definition? I have noticed a mix of "unsigned int" and u32 also below,
> maybe stick to one? Same for other types.

The CPU is always defined as unsigned int though this file which matches
the cpu_online/cpu_offline definitions. I think keeping it like this is
fine.

> 
> 
>> +
>> +    union {
>> +        struct sse_registered_event *global;
>> +        struct sse_registered_event __percpu *local;
>> +    };
>> +};
>> +
>> +static int sse_hp_state;
>> +static bool sse_available __ro_after_init;
>> +static DEFINE_SPINLOCK(events_list_lock);
>> +static LIST_HEAD(events);
>> +static DEFINE_MUTEX(sse_mutex);
>> +
>> +struct sse_registered_event {
>> +    struct sse_event_arch_data arch;
>> +    struct sse_event *event;
>> +    unsigned long attr;
>> +    bool is_enabled;
>> +};
>> +
>> +void sse_handle_event(struct sse_event_arch_data *arch_event,
>> +              struct pt_regs *regs)
>> +{
>> +    int ret;
>> +    struct sse_registered_event *reg_evt =
>> +        container_of(arch_event, struct sse_registered_event, arch);
>> +    struct sse_event *evt = reg_evt->event;
>> +
>> +    ret = evt->handler(evt->evt_id, evt->handler_arg, regs);
>> +    if (ret)
>> +        pr_warn("event %x handler failed with error %d\n", evt-
>> >evt_id, ret);
>> +}
>> +
>> +static struct sse_event *sse_event_get(u32 evt)
>> +{
>> +    struct sse_event *event = NULL;
> 
> 
> No need to initialize to NULL
> 
> 
>> +
>> +    scoped_guard(spinlock, &events_list_lock) {
>> +        list_for_each_entry(event, &events, list) {
>> +            if (event->evt_id == evt)
>> +                return event;
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static phys_addr_t sse_event_get_attr_phys(struct
>> sse_registered_event *reg_evt)
>> +{
>> +    phys_addr_t phys;
>> +    void *addr = &reg_evt->attr;
>> +
>> +    if (sse_event_is_global(reg_evt->event->evt_id))
>> +        phys = virt_to_phys(addr);
>> +    else
>> +        phys = per_cpu_ptr_to_phys(addr);
>> +
>> +    return phys;
>> +}
>> +
>> +static struct sse_registered_event *sse_get_reg_evt(struct sse_event
>> *event)
>> +{
>> +    if (sse_event_is_global(event->evt_id))
>> +        return event->global;
>> +    else
>> +        return per_cpu_ptr(event->local, smp_processor_id());
>> +}
>> +
>> +static int sse_sbi_event_func(struct sse_event *event, unsigned long
>> func)
>> +{
>> +    struct sbiret ret;
>> +    u32 evt = event->evt_id;
>> +    struct sse_registered_event *reg_evt = sse_get_reg_evt(event);
>> +
>> +    ret = sbi_ecall(SBI_EXT_SSE, func, evt, 0, 0, 0, 0, 0);
>> +    if (ret.error) {
>> +        pr_warn("Failed to execute func %lx, event %x, error %ld\n",
>> +            func, evt, ret.error);
>> +        return sbi_err_map_linux_errno(ret.error);
>> +    }
>> +
>> +    if (func == SBI_SSE_EVENT_DISABLE)
>> +        reg_evt->is_enabled = false;
>> +    else if (func == SBI_SSE_EVENT_ENABLE)
>> +        reg_evt->is_enabled = true;
>> +
>> +    return 0;
>> +}
>> +
>> +int sse_event_disable_local(struct sse_event *event)
>> +{
>> +    return sse_sbi_event_func(event, SBI_SSE_EVENT_DISABLE);
>> +}
>> +EXPORT_SYMBOL_GPL(sse_event_disable_local);
>> +
>> +int sse_event_enable_local(struct sse_event *event)
>> +{
>> +    return sse_sbi_event_func(event, SBI_SSE_EVENT_ENABLE);
>> +}
>> +EXPORT_SYMBOL_GPL(sse_event_enable_local);
>> +
>> +static int sse_event_attr_get_no_lock(struct sse_registered_event
>> *reg_evt,
>> +                      unsigned long attr_id, unsigned long *val)
>> +{
>> +    struct sbiret sret;
>> +    u32 evt = reg_evt->event->evt_id;
>> +    unsigned long phys;
>> +
>> +    phys = sse_event_get_attr_phys(reg_evt);
>> +
>> +    sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, evt,
>> attr_id, 1,
>> +             phys, 0, 0);
>> +    if (sret.error) {
>> +        pr_debug("Failed to get event %x attr %lx, error %ld\n", evt,
>> +             attr_id, sret.error);
>> +        return sbi_err_map_linux_errno(sret.error);
>> +    }
>> +
>> +    *val = reg_evt->attr;
>> +
>> +    return 0;
>> +}
>> +
>> +static int sse_event_attr_set_nolock(struct sse_registered_event
>> *reg_evt,
>> +                     unsigned long attr_id, unsigned long val)
> 
> 
> Nit but here you use "nolock" and for the getter above, you use
> "no_lock" (and while scrolling I noticed "nolock" again in
> sse_event_set_target_cpu_nolock()).

Will use nolock like the other.

> 
> 
>> +{
>> +    struct sbiret sret;
>> +    u32 evt = reg_evt->event->evt_id;
>> +    unsigned long phys;
>> +
>> +    reg_evt->attr = val;
>> +    phys = sse_event_get_attr_phys(reg_evt);
>> +
>> +    sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_WRITE, evt,
>> attr_id, 1,
>> +             phys, 0, 0);
>> +    if (sret.error)
>> +        pr_debug("Failed to set event %x attr %lx, error %ld\n", evt,
>> +             attr_id, sret.error);
>> +
>> +    return sbi_err_map_linux_errno(sret.error);
>> +}
>> +
>> +static void sse_global_event_update_cpu(struct sse_event *event,
>> +                    unsigned int cpu)
>> +{
>> +    struct sse_registered_event *reg_evt = event->global;
>> +
>> +    event->cpu = cpu;
>> +    arch_sse_event_update_cpu(&reg_evt->arch, cpu);
>> +}
>> +
>> +static int sse_event_set_target_cpu_nolock(struct sse_event *event,
>> +                       unsigned int cpu)
>> +{
>> +    unsigned int hart_id = cpuid_to_hartid_map(cpu);
>> +    struct sse_registered_event *reg_evt = event->global;
>> +    u32 evt = event->evt_id;
>> +    bool was_enabled;
>> +    int ret;
>> +
>> +    if (!sse_event_is_global(evt))
>> +        return -EINVAL;
>> +
>> +    was_enabled = reg_evt->is_enabled;
>> +    if (was_enabled)
>> +        sse_event_disable_local(event);
>> +
>> +    ret = sse_event_attr_set_nolock(reg_evt,
>> SBI_SSE_ATTR_PREFERRED_HART,
>> +                    hart_id);
>> +    if (ret == 0)
>> +        sse_global_event_update_cpu(event, cpu);
>> +
>> +    if (was_enabled)
>> +        sse_event_enable_local(event);
>> +
>> +    return 0;
>> +}
>> +
>> +int sse_event_set_target_cpu(struct sse_event *event, unsigned int cpu)
>> +{
>> +    int ret;
>> +
>> +    scoped_guard(mutex, &sse_mutex) {
>> +        scoped_guard(cpus_read_lock) {
>> +            if (!cpu_online(cpu))
>> +                return -EINVAL;
>> +
>> +            ret = sse_event_set_target_cpu_nolock(event, cpu);
>> +        }
>> +    }
>> +
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(sse_event_set_target_cpu);
>> +
>> +static int sse_event_init_registered(unsigned int cpu,
>> +                     struct sse_registered_event *reg_evt,
>> +                     struct sse_event *event)
>> +{
>> +    reg_evt->event = event;
>> +
>> +    return arch_sse_init_event(&reg_evt->arch, event->evt_id, cpu);
>> +}
>> +
>> +static void sse_event_free_registered(struct sse_registered_event
>> *reg_evt)
>> +{
>> +    arch_sse_free_event(&reg_evt->arch);
>> +}
>> +
>> +static int sse_event_alloc_global(struct sse_event *event)
>> +{
>> +    int err;
>> +    struct sse_registered_event *reg_evt;
>> +
>> +    reg_evt = kzalloc(sizeof(*reg_evt), GFP_KERNEL);
>> +    if (!reg_evt)
>> +        return -ENOMEM;
>> +
>> +    event->global = reg_evt;
>> +    err = sse_event_init_registered(smp_processor_id(), reg_evt, event);
>> +    if (err)
>> +        kfree(reg_evt);
>> +
>> +    return err;
>> +}
>> +
>> +static int sse_event_alloc_local(struct sse_event *event)
>> +{
>> +    int err;
>> +    unsigned int cpu, err_cpu;
>> +    struct sse_registered_event *reg_evt;
>> +    struct sse_registered_event __percpu *reg_evts;
>> +
>> +    reg_evts = alloc_percpu(struct sse_registered_event);
>> +    if (!reg_evts)
>> +        return -ENOMEM;
>> +
>> +    event->local = reg_evts;
>> +
>> +    for_each_possible_cpu(cpu) {
>> +        reg_evt = per_cpu_ptr(reg_evts, cpu);
>> +        err = sse_event_init_registered(cpu, reg_evt, event);
>> +        if (err) {
>> +            err_cpu = cpu;
>> +            goto err_free_per_cpu;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +
>> +err_free_per_cpu:
>> +    for_each_possible_cpu(cpu) {
>> +        if (cpu == err_cpu)
>> +            break;
>> +        reg_evt = per_cpu_ptr(reg_evts, cpu);
>> +        sse_event_free_registered(reg_evt);
>> +    }
>> +
>> +    free_percpu(reg_evts);
>> +
>> +    return err;
>> +}
>> +
>> +static struct sse_event *sse_event_alloc(u32 evt, u32 priority,
>> +                     sse_event_handler *handler, void *arg)
>> +{
>> +    int err;
>> +    struct sse_event *event;
>> +
>> +    event = kzalloc(sizeof(*event), GFP_KERNEL);
>> +    if (!event)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    event->evt_id = evt;
>> +    event->priority = priority;
>> +    event->handler_arg = arg;
>> +    event->handler = handler;
>> +
>> +    if (sse_event_is_global(evt))
>> +        err = sse_event_alloc_global(event);
>> +    else
>> +        err = sse_event_alloc_local(event);
>> +
>> +    if (err) {
>> +        kfree(event);
>> +        return ERR_PTR(err);
>> +    }
>> +
>> +    return event;
>> +}
>> +
>> +static int sse_sbi_register_event(struct sse_event *event,
>> +                  struct sse_registered_event *reg_evt)
>> +{
>> +    int ret;
>> +
>> +    ret = sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PRIO,
>> +                    event->priority);
>> +    if (ret)
>> +        return ret;
>> +
>> +    return arch_sse_register_event(&reg_evt->arch);
>> +}
>> +
>> +static int sse_event_register_local(struct sse_event *event)
>> +{
>> +    int ret;
>> +    struct sse_registered_event *reg_evt;
>> +
>> +    reg_evt = per_cpu_ptr(event->local, smp_processor_id());
>> +    ret = sse_sbi_register_event(event, reg_evt);
>> +    if (ret)
>> +        pr_debug("Failed to register event %x: err %d\n", event->evt_id,
>> +             ret);
>> +
>> +    return ret;
>> +}
>> +
>> +static int sse_sbi_unregister_event(struct sse_event *event)
>> +{
>> +    return sse_sbi_event_func(event, SBI_SSE_EVENT_UNREGISTER);
>> +}
>> +
>> +struct sse_per_cpu_evt {
>> +    struct sse_event *event;
>> +    unsigned long func;
>> +    cpumask_t error;
>> +};
>> +
>> +static void sse_event_per_cpu_func(void *info)
>> +{
>> +    int ret;
>> +    struct sse_per_cpu_evt *cpu_evt = info;
>> +
>> +    if (cpu_evt->func == SBI_SSE_EVENT_REGISTER)
>> +        ret = sse_event_register_local(cpu_evt->event);
>> +    else
>> +        ret = sse_sbi_event_func(cpu_evt->event, cpu_evt->func);
>> +
>> +    if (ret)
>> +        cpumask_set_cpu(smp_processor_id(), &cpu_evt->error);
>> +}
>> +
>> +static void sse_event_free(struct sse_event *event)
>> +{
>> +    unsigned int cpu;
>> +    struct sse_registered_event *reg_evt;
>> +
>> +    if (sse_event_is_global(event->evt_id)) {
>> +        sse_event_free_registered(event->global);
>> +        kfree(event->global);
>> +    } else {
>> +        for_each_possible_cpu(cpu) {
>> +            reg_evt = per_cpu_ptr(event->local, cpu);
>> +            sse_event_free_registered(reg_evt);
>> +        }
>> +        free_percpu(event->local);
>> +    }
>> +
>> +    kfree(event);
>> +}
>> +
>> +static void sse_on_each_cpu(struct sse_event *event, unsigned long func,
>> +                unsigned long revert_func)
>> +{
>> +    struct sse_per_cpu_evt cpu_evt;
>> +
>> +    cpu_evt.event = event;
>> +    cpumask_clear(&cpu_evt.error);
>> +    cpu_evt.func = func;
>> +    on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
>> +    /*
>> +     * If there are some error reported by CPUs, revert event state
>> on the
>> +     * other ones
>> +     */
>> +    if (!cpumask_empty(&cpu_evt.error)) {
>> +        cpumask_t revert;
>> +
>> +        cpumask_andnot(&revert, cpu_online_mask, &cpu_evt.error);
>> +        cpu_evt.func = revert_func;
>> +        on_each_cpu_mask(&revert, sse_event_per_cpu_func, &cpu_evt, 1);
>> +    }
>> +}
>> +
>> +int sse_event_enable(struct sse_event *event)
>> +{
>> +    int ret = 0;
>> +
>> +    scoped_guard(mutex, &sse_mutex) {
>> +        scoped_guard(cpus_read_lock) {
>> +            if (sse_event_is_global(event->evt_id)) {
>> +                ret = sse_event_enable_local(event);
>> +            } else {
>> +                sse_on_each_cpu(event, SBI_SSE_EVENT_ENABLE,
>> +                        SBI_SSE_EVENT_DISABLE);
>> +            }
>> +        }
>> +    }
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(sse_event_enable);
>> +
>> +static int sse_events_mask(void)
>> +{
>> +    struct sbiret ret;
>> +
>> +    ret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_HART_MASK, 0, 0, 0, 0,
>> 0, 0);
>> +
>> +    return sbi_err_map_linux_errno(ret.error);
>> +}
>> +
>> +static int sse_events_unmask(void)
>> +{
>> +    struct sbiret ret;
>> +
>> +    ret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_HART_UNMASK, 0, 0, 0,
>> 0, 0, 0);
>> +
>> +    return sbi_err_map_linux_errno(ret.error);
>> +}
>> +
>> +static void sse_event_disable_nolock(struct sse_event *event)
>> +{
>> +    struct sse_per_cpu_evt cpu_evt;
>> +
>> +    if (sse_event_is_global(event->evt_id)) {
>> +        sse_event_disable_local(event);
>> +    } else {
>> +        cpu_evt.event = event;
>> +        cpu_evt.func = SBI_SSE_EVENT_DISABLE;
>> +        on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
>> +    }
>> +}
>> +
>> +void sse_event_disable(struct sse_event *event)
>> +{
>> +    scoped_guard(mutex, &sse_mutex) {
>> +        scoped_guard(cpus_read_lock) {
>> +            sse_event_disable_nolock(event);
>> +        }
>> +    }
>> +}
>> +EXPORT_SYMBOL_GPL(sse_event_disable);
>> +
>> +struct sse_event *sse_event_register(u32 evt, u32 priority,
>> +                     sse_event_handler *handler, void *arg)
>> +{
>> +    struct sse_event *event;
>> +    int cpu;
>> +    int ret = 0;
>> +
>> +    if (!sse_available)
>> +        return ERR_PTR(-EOPNOTSUPP);
>> +
>> +    guard(mutex)(&sse_mutex);
>> +    if (sse_event_get(evt))
>> +        return ERR_PTR(-EEXIST);
>> +
>> +    event = sse_event_alloc(evt, priority, handler, arg);
>> +    if (IS_ERR(event))
>> +        return event;
>> +
>> +    scoped_guard(cpus_read_lock) {
>> +        if (sse_event_is_global(evt)) {
>> +            unsigned long preferred_hart;
>> +
>> +            ret = sse_event_attr_get_no_lock(event->global,
>> +                            SBI_SSE_ATTR_PREFERRED_HART,
>> +                            &preferred_hart);
>> +            if (ret)
>> +                goto err_event_free;
>> +
>> +            cpu = riscv_hartid_to_cpuid(preferred_hart);
>> +            sse_global_event_update_cpu(event, cpu);
>> +
>> +            ret = sse_sbi_register_event(event, event->global);
>> +            if (ret)
>> +                goto err_event_free;
>> +
>> +        } else {
>> +            sse_on_each_cpu(event, SBI_SSE_EVENT_REGISTER,
>> +                    SBI_SSE_EVENT_DISABLE);
>> +        }
>> +    }
>> +
>> +    scoped_guard(spinlock, &events_list_lock)
>> +        list_add(&event->list, &events);
>> +
>> +    return event;
>> +
>> +err_event_free:
>> +    sse_event_free(event);
>> +
>> +    return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(sse_event_register);
>> +
>> +static void sse_event_unregister_nolock(struct sse_event *event)
>> +{
>> +    struct sse_per_cpu_evt cpu_evt;
>> +
>> +    if (sse_event_is_global(event->evt_id)) {
>> +        sse_sbi_unregister_event(event);
>> +    } else {
>> +        cpu_evt.event = event;
>> +        cpu_evt.func = SBI_SSE_EVENT_UNREGISTER;
>> +        on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
>> +    }
>> +}
>> +
>> +void sse_event_unregister(struct sse_event *event)
>> +{
>> +    scoped_guard(mutex, &sse_mutex) {
>> +        scoped_guard(cpus_read_lock)
>> +            sse_event_unregister_nolock(event);
>> +
>> +        scoped_guard(spinlock, &events_list_lock)
>> +            list_del(&event->list);
>> +
>> +        sse_event_free(event);
>> +    }
>> +}
>> +EXPORT_SYMBOL_GPL(sse_event_unregister);
>> +
>> +static int sse_cpu_online(unsigned int cpu)
>> +{
>> +    struct sse_event *event;
>> +
>> +    scoped_guard(spinlock, &events_list_lock) {
>> +        list_for_each_entry(event, &events, list) {
>> +            if (sse_event_is_global(event->evt_id))
>> +                continue;
>> +
>> +            sse_event_register_local(event);
>> +            if (sse_get_reg_evt(event))
>> +                sse_event_enable_local(event);
>> +        }
>> +    }
>> +
>> +    /* Ready to handle events. Unmask SSE. */
>> +    return sse_events_unmask();
>> +}
>> +
>> +static int sse_cpu_teardown(unsigned int cpu)
>> +{
>> +    int ret = 0;
>> +    unsigned int next_cpu;
>> +    struct sse_event *event;
>> +
>> +    /* Mask the sse events */
>> +    ret = sse_events_mask();
>> +    if (ret)
>> +        return ret;
>> +
>> +    scoped_guard(spinlock, &events_list_lock) {
>> +        list_for_each_entry(event, &events, list) {
>> +            if (!sse_event_is_global(event->evt_id)) {
>> +                if (event->global->is_enabled)
>> +                    sse_event_disable_local(event);
>> +
>> +                sse_sbi_unregister_event(event);
>> +                continue;
>> +            }
>> +
>> +            if (event->cpu != smp_processor_id())
>> +                continue;
>> +
>> +            /* Update destination hart for global event */
>> +            next_cpu = cpumask_any_but(cpu_online_mask, cpu);
>> +            ret = sse_event_set_target_cpu_nolock(event, next_cpu);
>> +        }
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static void sse_reset(void)
>> +{
>> +    struct sse_event *event;
>> +
>> +    list_for_each_entry(event, &events, list) {
>> +        sse_event_disable_nolock(event);
>> +        sse_event_unregister_nolock(event);
>> +    }
>> +}
>> +
>> +static int sse_pm_notifier(struct notifier_block *nb, unsigned long
>> action,
>> +               void *data)
>> +{
>> +    WARN_ON_ONCE(preemptible());
>> +
>> +    switch (action) {
>> +    case CPU_PM_ENTER:
>> +        sse_events_mask();
>> +        break;
>> +    case CPU_PM_EXIT:
>> +    case CPU_PM_ENTER_FAILED:
>> +        sse_events_unmask();
>> +        break;
>> +    default:
>> +        return NOTIFY_DONE;
>> +    }
>> +
>> +    return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block sse_pm_nb = {
>> +    .notifier_call = sse_pm_notifier,
>> +};
>> +
>> +/*
>> + * Mask all CPUs and unregister all events on panic, reboot or kexec.
>> + */
>> +static int sse_reboot_notifier(struct notifier_block *nb, unsigned
>> long action,
>> +                   void *data)
>> +{
>> +    cpuhp_remove_state(sse_hp_state);
>> +    sse_reset();
>> +
>> +    return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block sse_reboot_nb = {
>> +    .notifier_call = sse_reboot_notifier,
>> +};
>> +
>> +static int __init sse_init(void)
>> +{
>> +    int ret;
>> +
>> +    if (sbi_probe_extension(SBI_EXT_SSE) <= 0) {
>> +        pr_err("Missing SBI SSE extension\n");
>> +        return -EOPNOTSUPP;
>> +    }
>> +    pr_info("SBI SSE extension detected\n");
>> +
>> +    ret = cpu_pm_register_notifier(&sse_pm_nb);
>> +    if (ret) {
>> +        pr_warn("Failed to register CPU PM notifier...\n");
>> +        return ret;
>> +    }
>> +
>> +    ret = register_reboot_notifier(&sse_reboot_nb);
>> +    if (ret) {
>> +        pr_warn("Failed to register reboot notifier...\n");
>> +        goto remove_cpupm;
>> +    }
>> +
>> +    ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/sse:online",
>> +                sse_cpu_online, sse_cpu_teardown);
>> +    if (ret < 0)
>> +        goto remove_reboot;
>> +
>> +    sse_hp_state = ret;
>> +    sse_available = true;
>> +
>> +    return 0;
>> +
>> +remove_reboot:
>> +    unregister_reboot_notifier(&sse_reboot_nb);
>> +
>> +remove_cpupm:
>> +    cpu_pm_unregister_notifier(&sse_pm_nb);
>> +
>> +    return ret;
>> +}
>> +arch_initcall(sse_init);
>> diff --git a/include/linux/riscv_sse.h b/include/linux/riscv_sse.h
>> new file mode 100644
>> index 000000000000..d7bd0e22a00f
>> --- /dev/null
>> +++ b/include/linux/riscv_sse.h
>> @@ -0,0 +1,56 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2024 Rivos Inc.
>> + */
>> +
>> +#ifndef __LINUX_RISCV_SSE_H
>> +#define __LINUX_RISCV_SSE_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/linkage.h>
>> +
>> +struct sse_event;
>> +struct pt_regs;
>> +
>> +typedef int (sse_event_handler)(u32 event_num, void *arg, struct
>> pt_regs *regs);
> 
> 
> I don't see function pointer listed here https://www.kernel.org/doc/
> html/v4.10/process/coding-style.html#typedefs so I'd rather avoid this one.

Although not mentionned here, there are function typedefs in the kernel:

git grep (typedef.*_fn)

This one is used at various places of the driver and is quite long so I
would prefer to keep it. I'll rename it sse_event_handler_fn like a
majority of the one in the kernel though.

Thanks,

Clément

> 
> 
>> +
>> +#ifdef CONFIG_RISCV_SSE
>> +
>> +struct sse_event *sse_event_register(u32 event_num, u32 priority,
>> +                     sse_event_handler *handler, void *arg);
>> +
>> +void sse_event_unregister(struct sse_event *evt);
>> +
>> +int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int
>> cpu);
>> +
>> +int sse_event_enable(struct sse_event *sse_evt);
>> +
>> +void sse_event_disable(struct sse_event *sse_evt);
>> +
>> +int sse_event_enable_local(struct sse_event *sse_evt);
>> +int sse_event_disable_local(struct sse_event *sse_evt);
>> +
>> +#else
>> +static inline struct sse_event *sse_event_register(u32 event_num, u32
>> priority,
>> +                           sse_event_handler *handler,
>> +                           void *arg)
>> +{
>> +    return ERR_PTR(-EOPNOTSUPP);
>> +}
>> +
>> +static inline void sse_event_unregister(struct sse_event *evt) {}
>> +
>> +static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
>> +                       unsigned int cpu)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static inline int sse_event_enable(struct sse_event *sse_evt)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static inline void sse_event_disable(struct sse_event *sse_evt) {}
>> +#endif
>> +#endif /* __LINUX_RISCV_SSE_H */


