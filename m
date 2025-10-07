Return-Path: <linux-kernel+bounces-843873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC62BC0766
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 09:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A682C34B839
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 07:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D4C22A7E0;
	Tue,  7 Oct 2025 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feGyWaZT"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061BD202F7B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759821074; cv=none; b=p09lLdnTEBgZvajolu6hCw+9ZG8+12iqn+heoaU5EPxoHso2KtEw5/DuwCnDcUWAMmDfNvC6L9Ftxx1hFjfI7EsjYgMuxzqbNFyPcn5K+tL4UUnhlOEaH2y5+R4oD6F2eLMuM5pO7sbXyPbwiLTcUSqvrbkbP+4oYkuXQkOAsGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759821074; c=relaxed/simple;
	bh=7A5bW2hbfPv20QSyD+ba5k0L363+L7dhKHOke9K0hPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6KjWgnAEkE/1mAyMRm9KhpnKEetxQr4O6L1QI4uJm3oq9c79KNIIdETIg6MsKIILE4e07cyo1TFRZEQHdYGT0s2SgewTHm40CmnPFrj7tVAg535/OGwV5JfTyaSiaTK0aVezGGSln9+uceVFSSCSX7/0ZuTLWZY7IsUdBCUQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feGyWaZT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-793021f348fso52664b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 00:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759821071; x=1760425871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cz8Uq6JRWEUUJyfozPnxNFaDcuM+MyDcm3nmjddxu90=;
        b=feGyWaZTazpKOqL0hY32fjxNccGZMgEvtNziAUAHO7dEgT65Yp6uZ5RyAF5sid5N6a
         WPs+I6CVEluE3c6PT+s0K4lGEPNFBERwTd+Fk6kPIa7iTtqFx37izkraxFAdMEXxG10N
         xmWRR3EggHYw1eJAJxa3BkQCr1RAnHqL/v9XMZ6l7pNtA00KyfHRpfmqGh7m6BrwrqcI
         Rnh3+GYtuoSTavsF2jaqR0vnu+k7QEftwhPiiRV7oh2GaSz/4fsbPWHVXMf7AToZWyoQ
         E6NaBPI4Og351AAbRsKHCzpbZYxmYKYRXZ32f6aaluKzIs7HXOZIUGZMaUtrDToGfuJY
         9qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759821071; x=1760425871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cz8Uq6JRWEUUJyfozPnxNFaDcuM+MyDcm3nmjddxu90=;
        b=O9jCP7asPesE4b0MYxOgzZ43/F/S2qtA2Sj5RLsnK+fwumYthP+6LvzccKi87d5jmE
         aLHDL01MbA1UaM9YLayVdotDXbat+PDaB2PLKyhh0a+Tm79UBkcUw6zatWHpS33HzKo4
         ugTzWdc94w1cbNWLGTN9HHTFNLSvzGeUmPx/FltkDtlO06CqMPcxR3i/AsNI/6eA659q
         NSPPMxn/YkLvW7Rlc4nKR9BZKWNgwXU/Um2RZikA0S4z+X0L7LEPYYaWXDVqqkTA7MAE
         Fahh7XeQ3cj42U5r1cU1DQyo1pPA0Ixjp3oRF1m0aIDrh/LQAALPp0qebIyQ8ZtmaXRw
         2i7w==
X-Forwarded-Encrypted: i=1; AJvYcCUTuaNXGjIookQH4kTjUyXJFWkCsmU4S9HLHxou1kscxTW0VNKfp0hQ+PQF4EoFO/IjTXDgnzXNLTshWPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypCQY34esMc3X4ODCJH6RK0aLYl6b6J4/TFWdRYZfpRxpSGPWG
	PdIho7tRbD4wstUmGrAqxOzufY8fBawVma99eLMizRF04sGbWneJVUcn
X-Gm-Gg: ASbGncsSL1Ya577MIOH+WQGhpFVRWTEqHHSEuUy7pzeTTzKWo+LkQGzOUswgQY7fPbu
	Z9j+MEoXQTFmVqibbH/Rj3Sa3OuNAG3fzroTB2yremvnaoA/bkwbNpPF/agepajvGUeE0CAtXFM
	zogVO9GbL9E+5lQ9iXxQuqZkiszM74i3NmR11toAUxBNofeXw2MdbiBPpusarjb13hvOWLojU9t
	GAazWbd/kJumeLmsdRNh65Y3mUn8abhZSNdhw+haUbmWLhQue9uFSjqjBL6AolRKdd7e+svYBrB
	3mmeQ5vdbhR3cYyJwZimIUfHxj9vffh6eRUoaFaaC1WoKdA/8UUhrpWdd6em6mrKk0UtWps7R2y
	9RBZyJwKM6eDUuFWAVxM2fLu1CnttnWY+moYH+Lg6Q3Go5Rbf
X-Google-Smtp-Source: AGHT+IHQPTeQxqIh3DmyDul63D0hdktzTIH+hAqRQcLBDO2L74AlzSZcN3PTvolNafM1O2PLFa55Ow==
X-Received: by 2002:a05:6a20:6a08:b0:2ea:41f1:d53a with SMTP id adf61e73a8af0-32b620d9121mr18200629637.41.1759821071157;
        Tue, 07 Oct 2025 00:11:11 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb0548sm14737938b3a.27.2025.10.07.00.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 00:11:10 -0700 (PDT)
Message-ID: <793a00d6-a1ae-4928-a326-3d276a30bdbd@gmail.com>
Date: Tue, 7 Oct 2025 00:09:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] rvtrace: Add trace encoder driver
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
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <20251002060732.100213-6-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/25 23:07, Anup Patel wrote:
> From: Mayuresh Chitale <mchitale@ventanamicro.com>
> 
> Add initial implementation of RISC-V trace encoder driver. The encoder
> is defined in the RISC-V Trace Control Interface specification.
> 
> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
>   drivers/hwtracing/rvtrace/Kconfig           |   7 ++
>   drivers/hwtracing/rvtrace/Makefile          |   1 +
>   drivers/hwtracing/rvtrace/rvtrace-encoder.c | 107 ++++++++++++++++++++
>   3 files changed, 115 insertions(+)
>   create mode 100644 drivers/hwtracing/rvtrace/rvtrace-encoder.c
> 
> diff --git a/drivers/hwtracing/rvtrace/Kconfig b/drivers/hwtracing/rvtrace/Kconfig
> index f8f6feea1953..ba35c05f3f54 100644
> --- a/drivers/hwtracing/rvtrace/Kconfig
> +++ b/drivers/hwtracing/rvtrace/Kconfig
> @@ -14,3 +14,10 @@ menuconfig RVTRACE
>   
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called rvtrace.
> +
> +config RVTRACE_ENCODER
> +	tristate "RISC-V Trace Encoder driver"
> +	depends on RVTRACE
> +	default y
> +	help
> +	  This driver provides support for RISC-V Trace Encoder component.
> diff --git a/drivers/hwtracing/rvtrace/Makefile b/drivers/hwtracing/rvtrace/Makefile
> index 988525a379cf..f320693a1fc5 100644
> --- a/drivers/hwtracing/rvtrace/Makefile
> +++ b/drivers/hwtracing/rvtrace/Makefile
> @@ -2,3 +2,4 @@
>   
>   obj-$(CONFIG_RVTRACE) += rvtrace.o
>   rvtrace-y := rvtrace-core.o rvtrace-platform.o
> +obj-$(CONFIG_RVTRACE_ENCODER) += rvtrace-encoder.o
> diff --git a/drivers/hwtracing/rvtrace/rvtrace-encoder.c b/drivers/hwtracing/rvtrace/rvtrace-encoder.c
> new file mode 100644
> index 000000000000..45d1c5b12c51
> --- /dev/null
> +++ b/drivers/hwtracing/rvtrace/rvtrace-encoder.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Ventana Micro Systems Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/rvtrace.h>
> +#include <linux/types.h>
> +
> +#define RVTRACE_COMPONENT_CTRL_ITRACE_MASK	0x1
> +#define RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT	2
> +#define RVTRACE_COMPONENT_CTRL_INSTMODE_MASK	0x7
> +#define RVTRACE_COMPONENT_CTRL_INSTMODE_SHIFT	4
> +
> +static int rvtrace_encoder_start(struct rvtrace_component *comp)
> +{
> +	u32 val;
> +
> +	val = rvtrace_read32(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET);
> +	val |= BIT(RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT);
> +	rvtrace_write32(comp->pdata, val, RVTRACE_COMPONENT_CTRL_OFFSET);
> +	return rvtrace_poll_bit(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET,
> +				RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT, 1,
> +				comp->pdata->control_poll_timeout_usecs);
> +}
> +
> +static int rvtrace_encoder_stop(struct rvtrace_component *comp)
> +{
> +	u32 val;
> +
> +	val = rvtrace_read32(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET);
> +	val &= ~BIT(RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT);
> +	rvtrace_write32(comp->pdata, val, RVTRACE_COMPONENT_CTRL_OFFSET);
> +	return rvtrace_poll_bit(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET,
> +				RVTRACE_COMPONENT_CTRL_ITRACE_SHIFT, 0,
> +				comp->pdata->control_poll_timeout_usecs);
> +}
> +
> +static void rvtrace_encoder_setmode(struct rvtrace_component *comp, u32 mode)
> +{
> +	u32 val;
> +
> +	val = rvtrace_read32(comp->pdata, RVTRACE_COMPONENT_CTRL_OFFSET);
> +	val |= (mode << RVTRACE_COMPONENT_CTRL_INSTMODE_SHIFT);
> +	rvtrace_write32(comp->pdata, val, RVTRACE_COMPONENT_CTRL_OFFSET);
> +}
> +
> +static int rvtrace_encoder_probe(struct rvtrace_component *comp)
> +{
> +	int ret;
> +
> +	rvtrace_encoder_setmode(comp, 0x6);
> +	ret = rvtrace_enable_component(comp);
> +	if (ret)
> +		return dev_err_probe(&comp->dev, ret, "failed to enable encoder.\n");
> +
> +	return 0;
> +}
Trace components needs proper probing before use. Refer to Control Interface
Spec: https://github.com/riscv-non-isa/tg-nexus-trace/releases/download/1.0_Ratified/RISC-V-Trace-Control-Interface.pdf
Chapter 5. This versioning applies to all components, e.g., sinks/funnels...
The driver should check the HW impl version with what it supports, and
rejects registering the component(s) if not supported. Chapter 5. has more
details.

> +
> +static void rvtrace_encoder_remove(struct rvtrace_component *comp)
> +{
> +	int ret;
> +
> +	ret = rvtrace_disable_component(comp);
> +	if (ret)
> +		dev_err(&comp->dev, "failed to disable encoder.\n");
> +}
> +
> +static struct rvtrace_component_id rvtrace_encoder_ids[] = {
> +	{ .type = RVTRACE_COMPONENT_TYPE_ENCODER,
> +	  .version = rvtrace_component_mkversion(1, 0), },
> +	{},
> +};
> +
> +static struct rvtrace_driver rvtrace_encoder_driver = {
> +	.id_table = rvtrace_encoder_ids,
> +	.start = rvtrace_encoder_start,
> +	.stop = rvtrace_encoder_stop,
> +	.probe = rvtrace_encoder_probe,
> +	.remove = rvtrace_encoder_remove,
> +	.driver = {
> +		.name = "rvtrace-encoder",
> +	},
> +};
> +
> +static int __init rvtrace_encoder_init(void)
> +{
> +	return rvtrace_register_driver(&rvtrace_encoder_driver);
> +}
> +
> +static void __exit rvtrace_encoder_exit(void)
> +{
> +	rvtrace_unregister_driver(&rvtrace_encoder_driver);
> +}
> +
> +module_init(rvtrace_encoder_init);
> +module_exit(rvtrace_encoder_exit);
> +
> +/* Module information */
> +MODULE_AUTHOR("Mayuresh Chitale <mchitale@ventanamicro.com>");
> +MODULE_DESCRIPTION("RISC-V Trace Encoder Driver");
> +MODULE_LICENSE("GPL");

Bo

