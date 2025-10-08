Return-Path: <linux-kernel+bounces-845215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB3BC3EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3866419E3E38
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A87C2F3C34;
	Wed,  8 Oct 2025 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1yWU/4v"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9721DF247
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913378; cv=none; b=K8auPcTINF3xLN6VYC0nH8/C+z+vQikqPPmf29C2LMMGk34JEnMlJomyenVqqT6MA9zeT2k8CKHHgWzFfscn9RTax0wzSTwzmIOLjmob/C3a5FOgEuMPasji0ANK3Yg3IZPCwSxkLaNmoNK09Qr2pCAY7ooOhRMY7Ql0G6rfbGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913378; c=relaxed/simple;
	bh=+UDuO6DO/Ym52LDlFXI3rp7SrLJSwX1eI96AAhMosoA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HYo2lK7A9yEKFv1BKTSVDvjKSvJwDek96+NBzi4vJaDRe505ebq9jiI+EOgzvSWy8mlFoCoUjy44yti5AAOdO1ngVE8IIMP/qaZ4nOdd2hsOHAolQS4m7iiFHxEOiFWQjQhjumyfgIZYyPS3qdhQ9faSyuVFkwcMo+fKurWjrvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1yWU/4v; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so4769556a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759913376; x=1760518176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v063PFHSc1gjQVRPTuEMNoZ9lB106FcvcJqBcKcRy2Y=;
        b=i1yWU/4vZolSIXQE6j7KH1P0Q1ZJHZKRG2SOmO6kQO9SqEMNHDihVogaonE7Ejs4Rn
         P0ppCAJSpByfsnbM1eJhm9+SPtjWj1h0PTxJEN8+o6M6ZZn+1jh6D0+iNpaqizUKjDmr
         ZlQvMVdOUhNHaqf9QoGxfonSvBJ1elBxcmGku5D/tODiWhAs0IVN3A8TNLpPHXXLuISq
         i7gRbGmjozAvA18DILj5ZgMpRuZvWfXJHpQWtPCjmBfSnjaDCt3oLVipuW+69UrDvJeb
         c0zkAKfbBVJMKyi00Ayf9/0QaTy8hq4ChlTZ5sGa9n1zVn1Z4/RyLc2WYLzhdZcgnwS3
         j6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913376; x=1760518176;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v063PFHSc1gjQVRPTuEMNoZ9lB106FcvcJqBcKcRy2Y=;
        b=Qpg79oyRV4cpB7dAbT9JuvdOMnIVWmD1PN/BCaMskanxOB7FN/nmG3bmSMz/wmMWc3
         06OLT3IUfqrx44PEMwU/1l8vpQqNfs/3flK6BMw6ICwg9l25fQc3fMlqHJDQo9gjSWET
         UcBPMgJbGoCPnn6qk5svI6kDsqZLbMJgilfqX/7lr5KRr3r6eyLyHFyfBcgITrayOJJA
         AWBon+im0ZlPzeopJSWmNi3Dtvbk6TM1i6bxZ7zEpxy0tuFUccHROFIDAk5mAKy2AhRL
         nt63CMEB946pLRtbDfJ8vS02PbNRl76kmE/6uvxWVc57p/MhQDGm29QSwFvasLw8+O2o
         a3DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs89A1vZw9mGHUYF1fNupQJUe7VOtDFm2spv3+ux8QqhA5+ScLSJ1aOByFx3zEzr74r8NYuOre/asSOBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlGZGjCqsX95KIG6edNonJDj7QR5gHPtkRNuuDGBjMXx9lkJ2I
	1Pz++dOkFroNeKhhEFJHPEXP9hAEiRqHLckD6Cgi3ReTBWs3MWN8QBCB
X-Gm-Gg: ASbGnctKFAPqAUFYlzB7rHcGG24cE9ELc2I1dcVtkDUqeoqxcf7nYH5dqn+cEaAhQl9
	x7xUXGuMzJxPI8DA4iUyvFYDIMidT207gWwZBBPA19imRkoRc9/9RbqH8gEpGp0nOvVkeDoFa8p
	c0WUyGrEuxiiF0SLr4uF2MzzTCL3sC8lz+u/eabSpvuhtNbA2ac62JPg4ygXf94ia4HZhSyed/w
	D8b30m7tt6n6Dbyjyjx6uITwGHanV2ODhziOn7h3sTt5wNEDIFuNTx8ZR0LDmcZHyU1Y7KNejZN
	uYz+8BSPCUsEMx926iPflopYUep05u06a0Q9FtISm6ZWziOXXl4GI/SJh6Lel+d5YNx9hHDaFQ0
	IoluT+LrBpAqQO+HRx2cbASwPao0+/LIZHn2K1gpL+6bZjMUY
X-Google-Smtp-Source: AGHT+IEn4dr9WPi2dRHtbGX/nSAXQJpfA4KLTasMB6vT0AgR33JypLI3Jn8Z0xOPQzZtBHvu86ojaQ==
X-Received: by 2002:a17:90b:4b04:b0:32e:8c14:5d09 with SMTP id 98e67ed59e1d1-33b51105bbfmr3466478a91.7.1759913375457;
        Wed, 08 Oct 2025 01:49:35 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b510e91d4sm2540549a91.1.2025.10.08.01.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:49:34 -0700 (PDT)
Message-ID: <6c7dfe6b-8cc0-4cde-945b-c423ef517be8@gmail.com>
Date: Wed, 8 Oct 2025 01:48:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] rvtrace: Add trace encoder driver
From: Bo Gan <ganboing@gmail.com>
To: Anup Patel <apatel@ventanamicro.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Greg KH <gregkh@linuxfoundation.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Alexandre Ghiti <alex@ghiti.fr>, Atish Patra <atish.patra@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Anup Patel <anup@brainfault.org>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Ingo Molnar
 <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Mayuresh Chitale <mchitale@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-riscv@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>,
 Liang Kan <kan.liang@linux.intel.com>
References: <20251002060732.100213-1-apatel@ventanamicro.com>
 <20251002060732.100213-6-apatel@ventanamicro.com>
 <793a00d6-a1ae-4928-a326-3d276a30bdbd@gmail.com>
Content-Language: en-US
In-Reply-To: <793a00d6-a1ae-4928-a326-3d276a30bdbd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/7/25 00:09, Bo Gan wrote:
> On 10/1/25 23:07, Anup Patel wrote:
>> From: Mayuresh Chitale <mchitale@ventanamicro.com>
>>
>> Add initial implementation of RISC-V trace encoder driver. The encoder
>> is defined in the RISC-V Trace Control Interface specification.
>>
>> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>> ---
>>   drivers/hwtracing/rvtrace/Kconfig           |   7 ++
>>   drivers/hwtracing/rvtrace/Makefile          |   1 +
>>   drivers/hwtracing/rvtrace/rvtrace-encoder.c | 107 ++++++++++++++++++++
>>   3 files changed, 115 insertions(+)
>>   create mode 100644 drivers/hwtracing/rvtrace/rvtrace-encoder.c
>>
>> diff --git a/drivers/hwtracing/rvtrace/Kconfig b/drivers/hwtracing/rvtrace/Kconfig
>> index f8f6feea1953..ba35c05f3f54 100644
>> --- a/drivers/hwtracing/rvtrace/Kconfig
>> +++ b/drivers/hwtracing/rvtrace/Kconfig
>> @@ -14,3 +14,10 @@ menuconfig RVTRACE
>>         To compile this driver as a module, choose M here: the module
>>         will be called rvtrace.
>> +
>> +config RVTRACE_ENCODER
>> +    tristate "RISC-V Trace Encoder driver"
>> +    depends on RVTRACE
>> +    default y
>> +    help
>> +      This driver provides support for RISC-V Trace Encoder component.
>> diff --git a/drivers/hwtracing/rvtrace/Makefile b/drivers/hwtracing/rvtrace/Makefile
>> index 988525a379cf..f320693a1fc5 100644
>> --- a/drivers/hwtracing/rvtrace/Makefile
>> +++ b/drivers/hwtracing/rvtrace/Makefile
>> @@ -2,3 +2,4 @@
>>   obj-$(CONFIG_RVTRACE) += rvtrace.o
>>   rvtrace-y := rvtrace-core.o rvtrace-platform.o
>> +obj-$(CONFIG_RVTRACE_ENCODER) += rvtrace-encoder.o
>> diff --git a/drivers/hwtracing/rvtrace/rvtrace-encoder.c b/drivers/hwtracing/rvtrace/rvtrace-encoder.c
>> new file mode 100644
>> index 000000000000..45d1c5b12c51
>> --- /dev/null
>> +++ b/drivers/hwtracing/rvtrace/rvtrace-encoder.c
>> @@ -0,0 +1,107 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2025 Ventana Micro Systems Inc.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_graph.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/property.h>
>> +#include <linux/rvtrace.h>
>> +#include <linux/types.h>
>> +
>> +#define RVTRACE_COMPONENT_CTRL_ITRACE_MASK    0x1
>> +#define RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT    2
>> +#define RVTRACE_COMPONENT_CTRL_INSTMODE_MASK    0x7
>> +#define RVTRACE_COMPONENT_CTRL_INSTMODE_SHIFT    4
>> +
>> +static int rvtrace_encoder_start(struct rvtrace_component *comp)
>> +{
>> +    u32 val;
>> +
>> +    val = rvtrace_read32(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET);
>> +    val |= BIT(RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT);
>> +    rvtrace_write32(comp->pdata, val, RVTRACE_COMPONENT_CTRL_OFFSET);
>> +    return rvtrace_poll_bit(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET,
>> +                RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT, 1,
>> +                comp->pdata->control_poll_timeout_usecs);
>> +}
>> +
>> +static int rvtrace_encoder_stop(struct rvtrace_component *comp)
>> +{
>> +    u32 val;
>> +
>> +    val = rvtrace_read32(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET);
>> +    val &= ~BIT(RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT);
>> +    rvtrace_write32(comp->pdata, val, RVTRACE_COMPONENT_CTRL_OFFSET);
>> +    return rvtrace_poll_bit(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET,
>> +                RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT, 0,
>> +                comp->pdata->control_poll_timeout_usecs);
>> +}
>> +
>> +static void rvtrace_encoder_setmode(struct rvtrace_component *comp, u32 mode)
>> +{
>> +    u32 val;
>> +
>> +    val = rvtrace_read32(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET);
>> +    val |= (mode << RVTRACE_COMPONENT_CTRL_INSTMODE_SHIFT);
>> +    rvtrace_write32(comp->pdata, val, RVTRACE_COMPONENT_CTRL_OFFSET);
>> +}
>> +
>> +static int rvtrace_encoder_probe(struct rvtrace_component *comp)
>> +{
>> +    int ret;
>> +
>> +    rvtrace_encoder_setmode(comp, 0x6);
>> +    ret = rvtrace_enable_component(comp);
>> +    if (ret)
>> +        return dev_err_probe(&comp->dev, ret, "failed to enable encoder.\n");
>> +
>> +    return 0;
>> +}
> Trace components needs proper probing before use. Refer to Control Interface
> Spec: https://github.com/riscv-non-isa/tg-nexus-trace/releases/download/1.0_Ratified/RISC-V-Trace-Control-Interface.pdf
> Chapter 5. This versioning applies to all components, e.g., sinks/funnels...
> The driver should check the HW impl version with what it supports, and
> rejects registering the component(s) if not supported. Chapter 5. has more
> details.
> 
Forgot to mention another thing: you also need to follow Control Interface
Spec Chapter 11.2 Reset and Discovery to toggle tr??Active. Do not access
any other registers or set any other bits in tr??Control before properly
enable tr??Active. My userspace driver does the reset as:
https://github.com/ganboing/riscv-trace-umd/blob/master/rvtrace/device.py#L57

Your HW IP might ignore tr??Active bit and the trace components are always
clocked, and that's probably why you don't see any issue without proper
resetting. However, on my p550 (EIC7700), I adopted your code to a v6.6
tree, boot, and load it as module. The core immediately hangs, very likely
due to it tries to set tr??Control bits without proper resetting. You
should expect other IPs that implement clock gating and strictly follow
the Spec. Thanks.

>> +
>> +static void rvtrace_encoder_remove(struct rvtrace_component *comp)
>> +{
>> +    int ret;
>> +
>> +    ret = rvtrace_disable_component(comp);
>> +    if (ret)
>> +        dev_err(&comp->dev, "failed to disable encoder.\n");
>> +}
>> +
>> +static struct rvtrace_component_id rvtrace_encoder_ids[] = {
>> +    { .type = RVTRACE_COMPONENT_TYPE_ENCODER,
>> +      .version = rvtrace_component_mkversion(1, 0), },
>> +    {},
>> +};
>> +
>> +static struct rvtrace_driver rvtrace_encoder_driver = {
>> +    .id_table = rvtrace_encoder_ids,
>> +    .start = rvtrace_encoder_start,
>> +    .stop = rvtrace_encoder_stop,
>> +    .probe = rvtrace_encoder_probe,
>> +    .remove = rvtrace_encoder_remove,
>> +    .driver = {
>> +        .name = "rvtrace-encoder",
>> +    },
>> +};
>> +
>> +static int __init rvtrace_encoder_init(void)
>> +{
>> +    return rvtrace_register_driver(&rvtrace_encoder_driver);
>> +}
>> +
>> +static void __exit rvtrace_encoder_exit(void)
>> +{
>> +    rvtrace_unregister_driver(&rvtrace_encoder_driver);
>> +}
>> +
>> +module_init(rvtrace_encoder_init);
>> +module_exit(rvtrace_encoder_exit);
>> +
>> +/* Module information */
>> +MODULE_AUTHOR("Mayuresh Chitale <mchitale@ventanamicro.com>");
>> +MODULE_DESCRIPTION("RISC-V Trace Encoder Driver");
>> +MODULE_LICENSE("GPL");
> 
> Bo

Bo

