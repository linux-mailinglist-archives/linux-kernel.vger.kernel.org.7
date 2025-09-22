Return-Path: <linux-kernel+bounces-826890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 852C4B8F8E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396132A08A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F61027E048;
	Mon, 22 Sep 2025 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="EJ8uSHRI"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9D27A10D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529905; cv=none; b=BVsKhIPxzVdVKzGuwcvaqEbWpePRUyaXm06k38VcQ5skbWW8p9l69sE3cb82dYm9cXfPINMkPEvjMpksnssvSD0bizrnWnKqhZpR2ZIECzuaPsT572uoOqB1coY8+94IJSfWYqHNFENseBTh4CBu7whXjJhM9H26KY1+lXebD5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529905; c=relaxed/simple;
	bh=FirYu0l5QrjUMH7H5DAGBjRU90XnIUKkvxx11BGMq3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BI6liK6dMqhSW5drzr68Ex3IFlZx6EfdVc8k86+KiySVs0weL7UBi0EZIGP+4+vXFIbhgjW8sN8NRojc1IxKp4oHjXhOGAbHQVJCYTk0qQCmB3HqYZPcP3dLHPvz4T6NPOBF3fhMH49PMgA0UJ/LigmG4FheaWD9tt+1bEhLc9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=EJ8uSHRI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so2336732f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1758529901; x=1759134701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97lwVNlj4fcnM/Rf6y7n2gTeJuJTiJv3CIcVJBpEWgw=;
        b=EJ8uSHRI6h0a06RF67xBbe/fT/8jMHTKEaGoOXum7DbJ64Vg6x+/7HtMd11h/+sCRa
         CFPI310JWRS1xLV624P/NMUWX7OHdZ3exEYsGGaZPWgvZ4ItpaHG2sxvDUOlMpaCk3Rn
         gVuEQ7GXYaIFGPTpKQvCoWPTy094sSHJtL1QCcJbfQynVV7VV22CNFcV60THf41weTdS
         eGuDnJE26w48GrVleUnHKCGkwNzzqmKkFXbfVnjPwF0rQpLczATWWqW+whuTh0xjoFZ8
         R+G4G8Ii6AH+3Z6K6kRN6BSZ71ZYn74JdQV+JmZt6LGS0z1yWqVsr6p28nmu+TGAqKua
         eXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529901; x=1759134701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97lwVNlj4fcnM/Rf6y7n2gTeJuJTiJv3CIcVJBpEWgw=;
        b=f5v9a6UHX2CYvGCvRiSlZtTvl2F/hpdY2qgXwmtdbFHnLUA4L/1Kf8RAIJ5n0jSVVS
         0jD2yFeVU99sj4a0GEo8RiKSq1t4uVkKsMqN4oNvSv+0G8RDNAf3CzRRJgeBooDAOn/f
         ctSm4ddjHW29jgnMYjA/tk6Z3aNpR12TQLr0y36YKsnZe4FxeHJeS/bL7Bt/Aat2A6sI
         MDTHJX51U7LTh7giWVdYAW7eAkAk7Qt/8uBsYdcoAnJUEooHnVSIO6I4IBsm920VU3j3
         otuSX0hJWgA2AzlrQ0t6TIvo3w8IvDf1OGtEQyS3z1UzwvjPV4pyenTPQx9jHm3VCCaD
         Kb2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMHMJzHP16xfwFcwOCltdBVMOhExG4EQvxbVvqWr4yGO7AMU/nAZbAkqUxB0wcT3Xa76nB8S6pohg8DN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3DVkG9AwBE7OjzA2+ulJ17hMSIMxpya2DMtpW+0nWWwDWnsyk
	ONXbKkQQtI5Z4DmNrLjBIpHX5nPlsqJCPd4+kbs09gCFprVNurlK5hp4/jlnG6KKq7s=
X-Gm-Gg: ASbGnctSyqyhR2dqJT2i4AbOa1AxrhaesE7aeJ1hQra5R2UF3SwkOATv88XI2Q59cBz
	Xy2MbH5kMZEvbHiYhTFWF7lywoAtJvzgHvzz4o3+JRmfErnvjY9PLhjXF0xKrKqAvOksVMuSl4j
	+LGwyIUIGQ4n2ZUBloxWFX2+w7Z4X9WbqAiN7WPL0njhUvXkwxj7fghSR74s96KP1ST5X8z7t+Z
	XJh60MdrpRiEUbd5QeTnw83FPgd92//l3qrSO1ic1tGURKDhAPIg9HfbM3ZP8K+onM7yBTn8SOq
	bbr+qR51jEYim2DHcnmPTL05soDjsDa8CJZRgZG4iFikSGZhV9KfWjWHMfWAhoWWI7cKwYXurrJ
	9F1cgEARiZrMSUhL+qeyOtARz2ucJmfPQBV9OssF5LAaNL+S7T7nB/nbKnOzI+gjeOwQ=
X-Google-Smtp-Source: AGHT+IF0qMgnELSsh/SaUjjhvEZ5H2dsiw2RvHN61r4yu8dmqfDrHJsQn6VYJ97UynNVG/ZYSAEKyw==
X-Received: by 2002:a05:6000:420e:b0:3e4:f194:2872 with SMTP id ffacd0b85a97d-3ee8435a56fmr9939669f8f.31.1758529900679;
        Mon, 22 Sep 2025 01:31:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fc00a92sm19031245f8f.63.2025.09.22.01.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 01:31:40 -0700 (PDT)
Message-ID: <52792fdf-e12f-4de5-ad9e-069a0f2fef42@rivosinc.com>
Date: Mon, 22 Sep 2025 10:31:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH RFC 1/1] drivers: firmware: riscv: add
 unknown NMI support
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, conor@kernel.org, atishp@rivosinc.com,
 ajones@ventanamicro.com, apatel@ventanamicro.com, mchitale@ventanamicro.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250919070048.94646-1-cuiyunhui@bytedance.com>
 <20250919070048.94646-2-cuiyunhui@bytedance.com>
 <ae93899e-372e-425a-ae23-deb4bbab3eeb@rivosinc.com>
 <CAEEQ3wkpNwE14o7cLvf-cXc8xWy-s7_p_5-nShJaadqz6kVnBg@mail.gmail.com>
 <CAEEQ3w=g_-y6AoGYcGLOow6eOd6zX1D6JXyHerortX=VYp1B8g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAEEQ3w=g_-y6AoGYcGLOow6eOd6zX1D6JXyHerortX=VYp1B8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/09/2025 10:11, yunhui cui wrote:
> Hi Clément,
> 
> On Fri, Sep 19, 2025 at 3:52 PM yunhui cui <cuiyunhui@bytedance.com> wrote:
>>
>> Hi Clément,
>>
>> On Fri, Sep 19, 2025 at 3:18 PM Clément Léger <cleger@rivosinc.com> wrote:
>>>
>>>
>>>
>>> On 19/09/2025 09:00, Yunhui Cui wrote:
>>>> Unknown NMI can force the kernel to respond (e.g., panic) when the
>>>> system encounters unrecognized critical hardware events, aiding in
>>>> troubleshooting system faults. This is implemented via the Supervisor
>>>> Software Events (SSE) framework.
>>>>
>>>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>>>> ---
>>>>  arch/riscv/include/asm/sbi.h     |  1 +
>>>>  drivers/firmware/riscv/Kconfig   | 10 +++++
>>>>  drivers/firmware/riscv/Makefile  |  1 +
>>>>  drivers/firmware/riscv/sse_nmi.c | 77 ++++++++++++++++++++++++++++++++
>>>>  4 files changed, 89 insertions(+)
>>>>  create mode 100644 drivers/firmware/riscv/sse_nmi.c
>>>>
>>>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>>>> index 874cc1d7603a5..5801f90a88f62 100644
>>>> --- a/arch/riscv/include/asm/sbi.h
>>>> +++ b/arch/riscv/include/asm/sbi.h
>>>> @@ -481,6 +481,7 @@ enum sbi_sse_attr_id {
>>>>
>>>>  #define SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS    0x00000000
>>>>  #define SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP              0x00000001
>>>> +#define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI                      0x00000002
>>>
>>> Was this submitted to the PRS WG ? This a specification modification so
>>> it should go through the usual process.
>>>
>>>>  #define SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS   0x00008000
>>>>  #define SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW     0x00010000
>>>>  #define SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS     0x00100000
>>>> diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/Kconfig
>>>> index ed5b663ac5f91..746bac862ac46 100644
>>>> --- a/drivers/firmware/riscv/Kconfig
>>>> +++ b/drivers/firmware/riscv/Kconfig
>>>> @@ -12,4 +12,14 @@ config RISCV_SBI_SSE
>>>>         this option provides support to register callbacks on specific SSE
>>>>         events.
>>>>
>>>> +config RISCV_SSE_UNKNOWN_NMI
>>>> +     bool "Enable SBI Supervisor Software Events unknown NMI support"
>>>> +     depends on RISCV_SBI_SSE
>>>> +     default y
>>>> +     help
>>>> +       This option enables support for delivering unknown Non-Maskable Interrupt (NMI)
>>>> +       notifications via the Supervisor Software Events (SSE) framework. When enabled,
>>>> +       unknown NMIs can trigger kernel responses (e.g., panic) for unrecognized critical
>>>> +       hardware events, aiding in system fault diagnosis.
>>>> +
>>>>  endmenu
>>>> diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv/Makefile
>>>> index c8795d4bbb2ea..9242c6cd5e3e9 100644
>>>> --- a/drivers/firmware/riscv/Makefile
>>>> +++ b/drivers/firmware/riscv/Makefile
>>>> @@ -1,3 +1,4 @@
>>>>  # SPDX-License-Identifier: GPL-2.0
>>>>
>>>>  obj-$(CONFIG_RISCV_SBI_SSE)          += riscv_sbi_sse.o
>>>> +obj-$(CONFIG_RISCV_SSE_UNKNOWN_NMI)  += sse_nmi.o
>>>> diff --git a/drivers/firmware/riscv/sse_nmi.c b/drivers/firmware/riscv/sse_nmi.c
>>>> new file mode 100644
>>>> index 0000000000000..43063f42efff0
>>>> --- /dev/null
>>>> +++ b/drivers/firmware/riscv/sse_nmi.c
>>>> @@ -0,0 +1,77 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +
>>>> +#include <linux/mm.h>
>>>> +#include <linux/nmi.h>
>>>> +#include <linux/riscv_sbi_sse.h>
>>>> +#include <linux/sched/debug.h>
>>>> +#include <linux/sysctl.h>
>>>> +
>>>> +#include <asm/irq_regs.h>
>>>> +#include <asm/sbi.h>
>>>> +
>>>> +int panic_on_unknown_nmi = 1;
>>>> +struct sse_event *evt;
>>>> +static struct ctl_table_header *unknown_nmi_sysctl_header;
>>>> +
>>>> +const struct ctl_table unknown_nmi_table[] = {
>>>> +     {
>>>> +             .procname       = "panic_enable",
>>>> +             .data           = &panic_on_unknown_nmi,
>>>> +             .maxlen         = sizeof(int),
>>>> +             .mode           = 0644,
>>>> +             .proc_handler   = proc_dointvec_minmax,
>>>> +             .extra1         = SYSCTL_ZERO,
>>>> +             .extra2         = SYSCTL_ONE,
>>>> +     },
>>>> +};
>>>> +
>>>> +static void nmi_handler(struct pt_regs *regs)
>>>> +{
>>>> +     pr_emerg("NMI received for unknown on CPU %d.\n", smp_processor_id());
>>>> +
>>>> +     if (panic_on_unknown_nmi)
>>>> +             nmi_panic(regs, "NMI: Not continuing");
>>>> +
>>>> +     pr_emerg("Dazed and confused, but trying to continue\n");
>>>> +}
>>>
>>> I'm dazed and confused as well ;) What's the point of this except
>>> interrupting the kernel with a panic ? It seems like it's a better idea
>>> to let the firmware handle that properly and display whatever
>>> information are needed. Was your idea to actually force the kernel to
>>> enter in some debug mode ?
>>
>> There is an important scenario: when the kernel becomes unresponsive,
>> we need to trigger an unknown NMI to cause the system to panic() and
>> then collect the vmcore, and such a requirement is common on x86
>> servers.
>>
>>>
>>> Thanks,
>>>
>>> Clément
>>>
>>>> +
>>>> +static int nmi_sse_handler(u32 evt, void *arg, struct pt_regs *regs)
>>>> +{
>>>> +     nmi_handler(regs);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int sse_nmi_init(void)
>>>> +{
>>>> +     int ret;
>>>> +
>>>> +     evt = sse_event_register(SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI, 0,
>>>> +                              nmi_sse_handler, NULL);
> 
> Should we add this UNKNOWN_NMI event ID in Chapter 17 of the SBI spec?

Hi Yunhui,

If you want it to be part of the spec, that should indeed be submitted
for review.

Thanks,

Clément

> 
> 
>>>> +     if (IS_ERR(evt))
>>>> +             return PTR_ERR(evt);
>>>> +
>>>> +     ret = sse_event_enable(evt);
>>>> +     if (ret) {
>>>> +             sse_event_unregister(evt);
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     unknown_nmi_sysctl_header = register_sysctl("kernel", unknown_nmi_table);
>>>> +     if (!unknown_nmi_sysctl_header) {
>>>> +             sse_event_disable(evt);
>>>> +             sse_event_unregister(evt);
>>>> +             return -ENOMEM;
>>>> +     }
>>>> +
>>>> +     pr_info("Using SSE for NMI event delivery\n");
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int __init unknow_nmi_init(void)
>>>> +{
>>>> +     return sse_nmi_init();
>>>> +}
>>>> +
>>>> +late_initcall(unknow_nmi_init);
>>>
>>
>> Thanks,
>> Yunhui
> 
> Thanks,
> Yunhui


