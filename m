Return-Path: <linux-kernel+bounces-845264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC4BC4337
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 164AF4E662F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F2C2ED151;
	Wed,  8 Oct 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkLVvkEP"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0025785F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917142; cv=none; b=tuGM2OgvmONZzMMszU3bKhIVyIMTB/0sNFbjYaWClYzDjXjL41ik4CnDeEw3qP4ZJV02oc7AMcKDOVmQ+uTf9F56mMps6EJeYdzJTQuu1Zi+emy3ftlacC2T4NaA6yzbG/yjHA+5NrBUcEJ87P0RCvm1EAQW3K3JzRwfaDtxJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917142; c=relaxed/simple;
	bh=qHCgsgykMSyzOuvZ2AeubKZFx4zeaQXXVVYa5Io8L8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hv/ozbq2wwCqdzDsB8I1yQcQcJFQV3eJEX4tCygzAIXS02M88/Uw38rwowSSDzXh23SWKNke8VF4HKJbA+BgQS1YjIUc/qxYXoK/lMI7LN6zgqYCugQ3dI53uIitYeoloi9Yw04FsnWRR1eXdH3I1q4RyFnHWQscGCzOh90ITn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkLVvkEP; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7930132f59aso2089179b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759917140; x=1760521940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=niBQI4wdNmfICupayJGPpljB3EAcSEmpaehe6tNs1gs=;
        b=hkLVvkEPWaCG+MpAC2nfpbWj78bkMnzxpGKhJO+X3bcGD+tl5AEZgxIhU1pSX1Ov5X
         yrrlJWb+LAo21TeGZxp/IT11h5eYZt2YVJ9McKLkz6d+2fgxcQ838X5a/qMLPqTAQNao
         D3slD55YugVK7CP2LEs0zrG9DmdtjDNHBYXwseLxo/uxO6UlDQgltXeypxjB0XVOIB3M
         leD3qiUM1GbkjY4vol+37p+f5EpGOEGTFz3an190F2zZ+Bby2eES/2IgYaa/BqYDDi3O
         2NGB1sHcfyM+T36hfW7QONcq1EwXwA50fVhltx1kxXrGb+vWyXeHeG+miXH2ds/PIKoO
         Dvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759917140; x=1760521940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niBQI4wdNmfICupayJGPpljB3EAcSEmpaehe6tNs1gs=;
        b=GPFQYJi0qLcg+mLNLLT6WHYkH4gdi2SlqmCTfM65ZLod4yqrxxMEwxIl9rl3+yCAAf
         zK2mKH4XTQJ6mjHiYxo/KYKPrhQcSI40Sh+il9KSr1g2DSIldojkImp9ROGzo9T3Nz9g
         Ue7XHahUwy2Fbok8indiFM1TmSnqhjhDxxWLl9ue92/zmuj5Aaqu54Lg9X+43YZO/d3d
         SF+nmoYUEZl11gRAyRTu/ibvEowuguuYLhTCBK5hvkSD+8NLdRzqSPiRebL4Imz8CWx9
         GFtaMEvdz0EM9DWJwmTp5dZOSfos4efozIOSqZHtNglvKyDfrCMIEavqQ+p434lYGZ59
         cNvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX80k+COCI+pbH85gjp/Ci0Ju55KPRFu1R5529nz1dfvbPY/9tETENMf3YLMaXCykvKSJ2sGmhmVgcb5sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykoiLk227O3Vbzy5rrqdnVe1jwGuMt1IXfJijVR3Wk8/gD6NzU
	I0gVz9VmS3AYJR3H4D1bYcYINhRzjNhHofH1g5VvkfO9tpB7KBABG7PU
X-Gm-Gg: ASbGncuwe+dqa5cW7fr7vG9RUeJEyRzOzMVqG0ylQ4L27uJ+lU0mBZiyKue9kzOTLYV
	Ee918HdZYpw8Vr65I8Q/EiT3hCvLxc+Pb7/vPKM72QAJYLhD/bzyBg4nFVOIqa9NicJ47BsciJm
	rrDcfEEQWKeLyYdmaGBfI/G1UH68dlaupjEUKmTfWMM9zAfZPonarcCqJ/SWSh+M9BT1UQgm7ye
	jfdaZTL2vfuK44m4AAgT5dwKET6nDgF9us4RSD9XnaYvfVVLVg7yGTPH6ZaROkGFVYfpvfHB4xq
	bMB408HfgnzDHFPEQnZriNLSzLYSCReAaUBRC+poWl8ChB54mNpFZCcNjApZTAyZ0QeNDu/6TE2
	aJAPavTrdJYV/rBfXshMxyhSNvjCHY93rdTJXgGR0U1v8GVji
X-Google-Smtp-Source: AGHT+IFwQkvGKoZHWAnrh2lfyZMOv6A7t9n7YsWCJ98mHKPctdenWxoJc0sGGTbHO53VIlfe4gOk7g==
X-Received: by 2002:a05:6a00:23c1:b0:77c:6621:6168 with SMTP id d2e1a72fcca58-79387e05457mr2760087b3a.30.1759917140318;
        Wed, 08 Oct 2025 02:52:20 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-793a9c6e916sm2000255b3a.50.2025.10.08.02.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:52:19 -0700 (PDT)
Message-ID: <11594604-a6f6-44cb-96f9-0c06e2cc9ae0@gmail.com>
Date: Wed, 8 Oct 2025 02:51:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] rvtrace: Add trace encoder driver
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Greg KH <gregkh@linuxfoundation.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
 Atish Patra <atish.patra@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Anup Patel <anup@brainfault.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mayuresh Chitale <mchitale@gmail.com>,
 Namhyung Kim <namhyung@kernel.org>, linux-riscv@lists.infradead.org,
 Andrew Jones <ajones@ventanamicro.com>, Liang Kan <kan.liang@linux.intel.com>
References: <20251002060732.100213-1-apatel@ventanamicro.com>
 <20251002060732.100213-6-apatel@ventanamicro.com>
 <793a00d6-a1ae-4928-a326-3d276a30bdbd@gmail.com>
 <6c7dfe6b-8cc0-4cde-945b-c423ef517be8@gmail.com>
 <CAN37VV7uBkRzYsQcgGtw_iFg=za91OH7_1OSJ+b8eeuCzL5iDw@mail.gmail.com>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <CAN37VV7uBkRzYsQcgGtw_iFg=za91OH7_1OSJ+b8eeuCzL5iDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mayuresh,

I overlooked the ordering of your rvtrace_component_reset and registering
on rvtrace bus. Yes, you are doing proper reset, so please ignore my
previous msg. Sorry for the noise. Now back to figure out why my hacked
version doesn't work on my p550...

On a side note, it seems that there's something wrong with your email
client? I don't see your reply on the mailing-list:
https://lore.kernel.org/all/20251002060732.100213-1-apatel@ventanamicro.com/
And your reply mail appears not in plain text mode.

On 10/8/25 02:22, Mayuresh Chitale wrote:
> 
> 
> On Wed, Oct 8, 2025 at 2:19 PM Bo Gan <ganboing@gmail.com <mailto:ganboing@gmail.com>> wrote:
> 
>     On 10/7/25 00:09, Bo Gan wrote:
>      > On 10/1/25 23:07, Anup Patel wrote:
>      >> From: Mayuresh Chitale <mchitale@ventanamicro.com <mailto:mchitale@ventanamicro.com>>
>      >>
>      >> Add initial implementation of RISC-V trace encoder driver. The encoder
>      >> is defined in the RISC-V Trace Control Interface specification.
>      >>
>      >> Co-developed-by: Anup Patel <apatel@ventanamicro.com <mailto:apatel@ventanamicro.com>>
>      >> Signed-off-by: Anup Patel <apatel@ventanamicro.com <mailto:apatel@ventanamicro.com>>
>      >> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com <mailto:mchitale@ventanamicro.com>>
>      >> ---
>      >>   drivers/hwtracing/rvtrace/Kconfig           |   7 ++
>      >>   drivers/hwtracing/rvtrace/Makefile          |   1 +
>      >>   drivers/hwtracing/rvtrace/rvtrace-encoder.c | 107 ++++++++++++++++++++
>      >>   3 files changed, 115 insertions(+)
>      >>   create mode 100644 drivers/hwtracing/rvtrace/rvtrace-encoder.c
>      >>
>      >> diff --git a/drivers/hwtracing/rvtrace/Kconfig b/drivers/hwtracing/rvtrace/Kconfig
>      >> index f8f6feea1953..ba35c05f3f54 100644
>      >> --- a/drivers/hwtracing/rvtrace/Kconfig
>      >> +++ b/drivers/hwtracing/rvtrace/Kconfig
>      >> @@ -14,3 +14,10 @@ menuconfig RVTRACE
>      >>         To compile this driver as a module, choose M here: the module
>      >>         will be called rvtrace.
>      >> +
>      >> +config RVTRACE_ENCODER
>      >> +    tristate "RISC-V Trace Encoder driver"
>      >> +    depends on RVTRACE
>      >> +    default y
>      >> +    help
>      >> +      This driver provides support for RISC-V Trace Encoder component.
>      >> diff --git a/drivers/hwtracing/rvtrace/Makefile b/drivers/hwtracing/rvtrace/Makefile
>      >> index 988525a379cf..f320693a1fc5 100644
>      >> --- a/drivers/hwtracing/rvtrace/Makefile
>      >> +++ b/drivers/hwtracing/rvtrace/Makefile
>      >> @@ -2,3 +2,4 @@
>      >>   obj-$(CONFIG_RVTRACE) += rvtrace.o
>      >>   rvtrace-y := rvtrace-core.o rvtrace-platform.o
>      >> +obj-$(CONFIG_RVTRACE_ENCODER) += rvtrace-encoder.o
>      >> diff --git a/drivers/hwtracing/rvtrace/rvtrace-encoder.c b/drivers/hwtracing/rvtrace/rvtrace-encoder.c
>      >> new file mode 100644
>      >> index 000000000000..45d1c5b12c51
>      >> --- /dev/null
>      >> +++ b/drivers/hwtracing/rvtrace/rvtrace-encoder.c
>      >> @@ -0,0 +1,107 @@
>      >> +// SPDX-License-Identifier: GPL-2.0
>      >> +/*
>      >> + * Copyright (c) 2025 Ventana Micro Systems Inc.
>      >> + */
>      >> +
>      >> +#include <linux/device.h>
>      >> +#include <linux/io.h>
>      >> +#include <linux/of.h>
>      >> +#include <linux/of_graph.h>
>      >> +#include <linux/platform_device.h>
>      >> +#include <linux/property.h>
>      >> +#include <linux/rvtrace.h>
>      >> +#include <linux/types.h>
>      >> +
>      >> +#define RVTRACE_COMPONENT_CTRL_ITRACE_MASK    0x1
>      >> +#define RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT    2
>      >> +#define RVTRACE_COMPONENT_CTRL_INSTMODE_MASK    0x7
>      >> +#define RVTRACE_COMPONENT_CTRL_INSTMODE_SHIFT    4
>      >> +
>      >> +static int rvtrace_encoder_start(struct rvtrace_component *comp)
>      >> +{
>      >> +    u32 val;
>      >> +
>      >> +    val = rvtrace_read32(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET);
>      >> +    val |= BIT(RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT);
>      >> +    rvtrace_write32(comp->pdata, val, RVTRACE_COMPONENT_CTRL_OFFSET);
>      >> +    return rvtrace_poll_bit(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET,
>      >> +                RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT, 1,
>      >> +                comp->pdata->control_poll_timeout_usecs);
>      >> +}
>      >> +
>      >> +static int rvtrace_encoder_stop(struct rvtrace_component *comp)
>      >> +{
>      >> +    u32 val;
>      >> +
>      >> +    val = rvtrace_read32(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET);
>      >> +    val &= ~BIT(RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT);
>      >> +    rvtrace_write32(comp->pdata, val, RVTRACE_COMPONENT_CTRL_OFFSET);
>      >> +    return rvtrace_poll_bit(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET,
>      >> +                RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT, 0,
>      >> +                comp->pdata->control_poll_timeout_usecs);
>      >> +}
>      >> +
>      >> +static void rvtrace_encoder_setmode(struct rvtrace_component *comp, u32 mode)
>      >> +{
>      >> +    u32 val;
>      >> +
>      >> +    val = rvtrace_read32(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET);
>      >> +    val |= (mode << RVTRACE_COMPONENT_CTRL_INSTMODE_SHIFT);
>      >> +    rvtrace_write32(comp->pdata, val, RVTRACE_COMPONENT_CTRL_OFFSET);
>      >> +}
>      >> +
>      >> +static int rvtrace_encoder_probe(struct rvtrace_component *comp)
>      >> +{
>      >> +    int ret;
>      >> +
>      >> +    rvtrace_encoder_setmode(comp, 0x6);
>      >> +    ret = rvtrace_enable_component(comp);
>      >> +    if (ret)
>      >> +        return dev_err_probe(&comp->dev, ret, "failed to enable encoder.\n");
>      >> +
>      >> +    return 0;
>      >> +}
>      > Trace components needs proper probing before use. Refer to Control Interface
>      > Spec: https://github.com/riscv-non-isa/tg-nexus-trace/releases/download/1.0_Ratified/RISC-V-Trace-Control-Interface.pdf <https://github.com/riscv-non-isa/tg-nexus-trace/releases/download/1.0_Ratified/RISC-V-Trace-Control-Interface.pdf>
>      > Chapter 5. This versioning applies to all components, e.g., sinks/funnels...
>      > The driver should check the HW impl version with what it supports, and
>      > rejects registering the component(s) if not supported. Chapter 5. has more
>      > details.
>      >
>     Forgot to mention another thing: you also need to follow Control Interface
>     Spec Chapter 11.2 Reset and Discovery to toggle tr??Active. Do not access
>     any other registers or set any other bits in tr??Control before properly
>     enable tr??Active. My userspace driver does the reset as:
>     https://github.com/ganboing/riscv-trace-umd/blob/master/rvtrace/device.py#L57 <https://github.com/ganboing/riscv-trace-umd/blob/master/rvtrace/device.py#L57>
> 
> 
> Actually reset is done when a component is registered (rvtrace_register_component) and it is enabled when it gets probed (rvtrace_enable_component).  I will incorporate the other changes in V2.
> 
>     Your HW IP might ignore tr??Active bit and the trace components are always
>     clocked, and that's probably why you don't see any issue without proper
>     resetting. However, on my p550 (EIC7700), I adopted your code to a v6.6
>     tree, boot, and load it as module. The core immediately hangs, very likely
>     due to it tries to set tr??Control bits without proper resetting. You
>     should expect other IPs that implement clock gating and strictly follow
>     the Spec. Thanks.
> 
>      >> +
>      >> +static void rvtrace_encoder_remove(struct rvtrace_component *comp)
>      >> +{
>      >> +    int ret;
>      >> +
>      >> +    ret = rvtrace_disable_component(comp);
>      >> +    if (ret)
>      >> +        dev_err(&comp->dev, "failed to disable encoder.\n");
>      >> +}
>      >> +
>      >> +static struct rvtrace_component_id rvtrace_encoder_ids[] = {
>      >> +    { .type = RVTRACE_COMPONENT_TYPE_ENCODER,
>      >> +      .version = rvtrace_component_mkversion(1, 0), },
>      >> +    {},
>      >> +};
>      >> +
>      >> +static struct rvtrace_driver rvtrace_encoder_driver = {
>      >> +    .id_table = rvtrace_encoder_ids,
>      >> +    .start = rvtrace_encoder_start,
>      >> +    .stop = rvtrace_encoder_stop,
>      >> +    .probe = rvtrace_encoder_probe,
>      >> +    .remove = rvtrace_encoder_remove,
>      >> +    .driver = {
>      >> +        .name = "rvtrace-encoder",
>      >> +    },
>      >> +};
>      >> +
>      >> +static int __init rvtrace_encoder_init(void)
>      >> +{
>      >> +    return rvtrace_register_driver(&rvtrace_encoder_driver);
>      >> +}
>      >> +
>      >> +static void __exit rvtrace_encoder_exit(void)
>      >> +{
>      >> +    rvtrace_unregister_driver(&rvtrace_encoder_driver);
>      >> +}
>      >> +
>      >> +module_init(rvtrace_encoder_init);
>      >> +module_exit(rvtrace_encoder_exit);
>      >> +
>      >> +/* Module information */
>      >> +MODULE_AUTHOR("Mayuresh Chitale <mchitale@ventanamicro.com <mailto:mchitale@ventanamicro.com>>");
>      >> +MODULE_DESCRIPTION("RISC-V Trace Encoder Driver");
>      >> +MODULE_LICENSE("GPL");
>      >
>      > Bo
> 
>     Bo
> 

Bo

