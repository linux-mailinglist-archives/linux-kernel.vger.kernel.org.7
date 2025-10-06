Return-Path: <linux-kernel+bounces-842610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE74FBBD264
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 08:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534261892F81
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 06:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E9E253355;
	Mon,  6 Oct 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="VzIMEzIH"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014942A80
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759733037; cv=none; b=s4d+I/SwBjyVpCfBZS8/eClMlNLzqjNNR/4ER0/dzjKgW9rjH4QzyKrrXZNlDv3junwx99VOOXbKx4J31PoPK/F9uBww9JtxinwOfmY9Mr/34FVTGchRWeloYH6auujAbJ/pRZYBDJgVhNDLDolRSZqHuuP004SyE1HFIGVVl6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759733037; c=relaxed/simple;
	bh=TQ1wbZ7CmirNoj12FGc4wQaxccnvf+geZDjrJbcAQlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cv1xSuxaK4FUqMCY7Gv2gon8RupOxHJvpzUUUdGChQLJA44drrdH9qmvnoyiPlCm4CDzl1cr1MZpltW0aAIxKWgLc38yrv+B4FJUTrOub1SayoCuST7tXwwZgSBLWz3l1UYuq6A29qziCqrwYNR15vxhwrmBR33OrKpJVrFgHa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=VzIMEzIH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so43542295e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1759733033; x=1760337833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSKdaizxrwGwWb0mgdmG0HgstCpMtkvbzpGWk45LP3M=;
        b=VzIMEzIHvbZsf1ZhoSFyMaUjS11z9dDKskXJ7e6GFCs36lPgpNAuXKo1XXayOB5W1w
         ZknYwmUbNlf9SWn5O9DPBmsZOckgiR63FG9VnhlS+oJyamzjNyTnyDzjTYRZ/quYRh9k
         iRoMMwxMpvqIaw6WS+5MkPdRCOO+Q3H6pP4ldCzQP6fDYEnpedmW3hKeus3xWLc32XV7
         yn2zy++YDC2FM8mx70VRtd+sQAnH7/tWATAadMMzTKWWD+7I4Ic5TSSViTA8+nSVsj9R
         xwaTpVkzYW6JJH+7d7FeQrCACC06BvRQ4OsytfhADIqlUhFIuqROnlqCkRG+RTrYuiEX
         6Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759733033; x=1760337833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSKdaizxrwGwWb0mgdmG0HgstCpMtkvbzpGWk45LP3M=;
        b=MZe2ScRv7EdzdI2V/WT59kJSDpvHf03YoR5jpzKyQYOla8ZXF4cHSl33CFMFRj9ZFZ
         oPtqrVU0M6Q6xdDHjOa9tCu6SC4V9tFFWgVN7UH5YJqHx/qBSwqA6Wi+D58DdSsi5jw1
         d4ENRxvk2weqMpD8BeXexHTInFFvNFZb6sybxPFEXZHz0MdTVGP8+8cIPUsU1j2JgE63
         G1AKyK40MGDByu5peklmR2e73nQ85SzqfI5eeHe8WMq5TxTiL5gUN4dDZXA0RhTjp5X4
         hUSQj6zL6xr5aevS3EFfIL41pzLy6g443fZubIPNHoVvv+AG+fF7ViHTgVBWhmdSicaf
         LtgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeC1NroH7J8AyFnhkY7gWesk+b7vy9ORfPCZByK3PqVhsCRMY+V7meVzIi1kVOcAlT25HChyz5RJuqxNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwidcDUf6sT6MQSBB7RTe5P2usObYxrM1MQJ3YqN0YEM5X30fDu
	cLWmq8B5o8e75fVdrWyNkO30gPOIY8lDShboO8KZYszPUOuQ3NDvkk05xSwXsW+VyVk=
X-Gm-Gg: ASbGnct+/HAgdOEvtFnxMGhglBIu8L+/A9SZpO6OKmHn9CqERYaV/zr2jz0I6V9csOz
	oT4cIYcoKmbwH6Jyq4ZFHRDiDCkw5XNeg/fcIUJCGmElsVgvFtXgJC1zCyL+ez0BEIr4j8l9z4w
	uQ4wG2QJYC6ixpXVbDgEgM1DSx6biIO+n2cfpmbaZ3Vb9HGESVYZ8WKU4qLN+bwe9atvgc7OYgo
	F5jCTWoRc4Mykbt9GD8ls5m4VAZh1xCzsMeto5QeY5aKJX/wCvp8X79XZuuK3gXDK7UEKhp28kA
	wrML1iSMl4Qz5JKYu+WcV+1VOlFTUkDgmGQwKgsGvrGmkx1COpXgYpPE65z9OaY3brTKHI895pZ
	zdjqyWXaYerbdtPRk13GZBssrqm92bgu5Lu26F4NTpMjTXq9WUGL7u15lpcDA0rwJKO7bqiKEHS
	xdeGgFxz+9PO5UsY0=
X-Google-Smtp-Source: AGHT+IHHPocl07TDjCmmnnWB338xsYMRj+F6fDeyS7IBZh5D64Aw6QpHDiyk/ffxyRjyi2YE9I+aMQ==
X-Received: by 2002:a05:600c:1987:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-46e71146083mr71143455e9.26.1759733032715;
        Sun, 05 Oct 2025 23:43:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a4161bsm253473805e9.16.2025.10.05.23.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 23:43:51 -0700 (PDT)
Message-ID: <f42de04a-f6ed-475f-8e49-c7fad5c2d5b9@rivosinc.com>
Date: Mon, 6 Oct 2025 08:43:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] drivers: firmware: add riscv SSE support
To: Anup Patel <anup@brainfault.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>,
 Atish Patra <atishp@atishpatra.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20250908181717.1997461-1-cleger@rivosinc.com>
 <20250908181717.1997461-4-cleger@rivosinc.com>
 <CAAhSdy3fwEZ+SQ3Cgc=GbisshRVQsvUPv23kzDFDd45ic=GObg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAAhSdy3fwEZ+SQ3Cgc=GbisshRVQsvUPv23kzDFDd45ic=GObg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06/10/2025 07:38, Anup Patel wrote:
> On Mon, Sep 8, 2025 at 11:50 PM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> Add driver level interface to use RISC-V SSE arch support. This interface
>> allows registering SSE handlers, and receive them. This will be used by
>> PMU and GHES driver.
>>
>> Co-developed-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
>> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>  MAINTAINERS                            |  15 +
>>  drivers/firmware/Kconfig               |   1 +
>>  drivers/firmware/Makefile              |   1 +
>>  drivers/firmware/riscv/Kconfig         |  15 +
>>  drivers/firmware/riscv/Makefile        |   3 +
>>  drivers/firmware/riscv/riscv_sbi_sse.c | 701 +++++++++++++++++++++++++
>>  include/linux/riscv_sbi_sse.h          |  57 ++
>>  7 files changed, 793 insertions(+)
>>  create mode 100644 drivers/firmware/riscv/Kconfig
>>  create mode 100644 drivers/firmware/riscv/Makefile
>>  create mode 100644 drivers/firmware/riscv/riscv_sbi_sse.c
>>  create mode 100644 include/linux/riscv_sbi_sse.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fe168477caa4..684d23f852c3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21648,6 +21648,13 @@ T:     git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>>  F:     Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>>  F:     drivers/iommu/riscv/
>>
>> +RISC-V FIRMWARE DRIVERS
>> +M:     Conor Dooley <conor@kernel.org>
>> +L:     linux-riscv@lists.infradead.org
>> +S:     Maintained
>> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git
>> +F:     drivers/firmware/riscv/*
>> +
>>  RISC-V MICROCHIP FPGA SUPPORT
>>  M:     Conor Dooley <conor.dooley@microchip.com>
>>  M:     Daire McNamara <daire.mcnamara@microchip.com>
>> @@ -21712,6 +21719,14 @@ F:     arch/riscv/boot/dts/spacemit/
>>  N:     spacemit
>>  K:     spacemit
>>
>> +RISC-V SSE DRIVER
>> +M:     Clément Léger <cleger@rivosinc.com>
>> +R:     Himanshu Chauhan <himanshu@thechauhan.dev>
>> +L:     linux-riscv@lists.infradead.org
>> +S:     Maintained
>> +F:     drivers/firmware/riscv/riscv_sse.c
>> +F:     include/linux/riscv_sse.h
>> +
>>  RISC-V THEAD SoC SUPPORT
>>  M:     Drew Fustini <fustini@kernel.org>
>>  M:     Guo Ren <guoren@kernel.org>
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index bbd2155d8483..1894df87b08e 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -294,6 +294,7 @@ source "drivers/firmware/meson/Kconfig"
>>  source "drivers/firmware/microchip/Kconfig"
>>  source "drivers/firmware/psci/Kconfig"
>>  source "drivers/firmware/qcom/Kconfig"
>> +source "drivers/firmware/riscv/Kconfig"
>>  source "drivers/firmware/samsung/Kconfig"
>>  source "drivers/firmware/smccc/Kconfig"
>>  source "drivers/firmware/tegra/Kconfig"
>> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
>> index 4ddec2820c96..6cdd84570ea7 100644
>> --- a/drivers/firmware/Makefile
>> +++ b/drivers/firmware/Makefile
>> @@ -34,6 +34,7 @@ obj-y                         += efi/
>>  obj-y                          += imx/
>>  obj-y                          += psci/
>>  obj-y                          += qcom/
>> +obj-y                          += riscv/
>>  obj-y                          += samsung/
>>  obj-y                          += smccc/
>>  obj-y                          += tegra/
>> diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/Kconfig
>> new file mode 100644
>> index 000000000000..ed5b663ac5f9
>> --- /dev/null
>> +++ b/drivers/firmware/riscv/Kconfig
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +menu "Risc-V Specific firmware drivers"
>> +depends on RISCV
>> +
>> +config RISCV_SBI_SSE
>> +       bool "Enable SBI Supervisor Software Events support"
>> +       depends on RISCV_SBI
>> +       default y
>> +       help
>> +         The Supervisor Software Events support allows the SBI to deliver
>> +         NMI-like notifications to the supervisor mode software. When enabled,
>> +         this option provides support to register callbacks on specific SSE
>> +         events.
>> +
>> +endmenu
>> diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv/Makefile
>> new file mode 100644
>> index 000000000000..c8795d4bbb2e
>> --- /dev/null
>> +++ b/drivers/firmware/riscv/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_RISCV_SBI_SSE)            += riscv_sbi_sse.o
>> diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/riscv/riscv_sbi_sse.c
>> new file mode 100644
>> index 000000000000..57b6dad92482
>> --- /dev/null
>> +++ b/drivers/firmware/riscv/riscv_sbi_sse.c
>> @@ -0,0 +1,701 @@
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
>> +#include <linux/riscv_sbi_sse.h>
>> +#include <linux/slab.h>
>> +
>> +#include <asm/sbi.h>
>> +#include <asm/sse.h>
>> +
>> +struct sse_event {
>> +       struct list_head list;
>> +       u32 evt_id;
>> +       u32 priority;
>> +       sse_event_handler_fn *handler;
>> +       void *handler_arg;
>> +       /* Only valid for global events */
>> +       unsigned int cpu;
>> +
>> +       union {
>> +               struct sse_registered_event *global;
>> +               struct sse_registered_event __percpu *local;
>> +       };
>> +};
>> +
>> +static int sse_hp_state;
>> +static bool sse_available __ro_after_init;
>> +static DEFINE_SPINLOCK(events_list_lock);
>> +static LIST_HEAD(events);
>> +static DEFINE_MUTEX(sse_mutex);
>> +
>> +struct sse_registered_event {
>> +       struct sse_event_arch_data arch;
>> +       struct sse_event *event;
>> +       unsigned long attr;
>> +       bool is_enabled;
>> +};
>> +
> 
> <snip>
> 
>> +
>> +static int __init sse_init(void)
>> +{
>> +       int ret;
>> +
>> +       if (sbi_probe_extension(SBI_EXT_SSE) <= 0) {
>> +               pr_err("Missing SBI SSE extension\n");
> 
> We might have older firmware which implements an older
> SBI spec version so we should not throw errors over here.
> Please change this to pr_info().

Yeah indeed, that might confuse the end-user.

Thanks,

Clément

> 
> Regards,
> Anup


