Return-Path: <linux-kernel+bounces-734933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED18B08877
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564134A97E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F4128A1FB;
	Thu, 17 Jul 2025 08:51:51 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91F2874F1;
	Thu, 17 Jul 2025 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742310; cv=none; b=Sq2TbhU9abiABroWPM+/HLbZXFcDLZHRh/xEHKkszAt7K+Whzm+9Y82sBCRSAUy3ALJLx9nD0Zf1VgSJV3gzJaLUBNQMkwvLRp6lqayP6mA6cEDxZWqb8KQmIxHbntUDvIM1iku38Efv2/9u4YG/ilG+Pb1GrGIVTq8hTfUP94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742310; c=relaxed/simple;
	bh=XVnrJrnPlbmyF5O6waoygGLEWehIpZKU6n4gcMXuS+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T78A/BbvQ9Fva4cOBtNQJrkyyrjUFDCgKa3VD00F726c3YGWZF/akQycq97uiQovNVqu4D9XP3qzDFCEjWfeR9ZkURjWcSMXCHu/56ue3dm5nf7fTjyI/VfWor9MGNsBcUylRaoJKeuVaXmEn9+UBIO/Tr725z/a2zk1JmIvR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B0C2433EE;
	Thu, 17 Jul 2025 08:51:35 +0000 (UTC)
Message-ID: <412b2b72-093d-4d55-b012-b185a840aa7e@ghiti.fr>
Date: Thu, 17 Jul 2025 10:51:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] riscv: Add xmipsexectl as a vendor extension
To: aleksa.paunovic@htecgroup.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250625-p8700-pause-v4-0-6c7dd7f85756@htecgroup.com>
 <20250625-p8700-pause-v4-2-6c7dd7f85756@htecgroup.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250625-p8700-pause-v4-2-6c7dd7f85756@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppedukeehrddvudefrdduheegrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudekhedrvddufedrudehgedrudehuddphhgvlhhopegluddtrddugedrtddrudefngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegrlhgvkhhsrgdrphgruhhnohhvihgtsehhthgvtghgrhhouhhprdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvl
 hhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvth
X-GND-Sasl: alex@ghiti.fr

Hi Aleksa,

On 6/25/25 16:20, Aleksa Paunovic via B4 Relay wrote:
> From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
>
> Add support for MIPS vendor extensions. Add support for the xmipsexectl
> vendor extension.
>
> Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
> ---
>   arch/riscv/Kconfig.vendor                       | 13 +++++++++++++
>   arch/riscv/include/asm/vendor_extensions/mips.h | 16 ++++++++++++++++
>   arch/riscv/kernel/vendor_extensions.c           | 10 ++++++++++
>   arch/riscv/kernel/vendor_extensions/Makefile    |  1 +
>   arch/riscv/kernel/vendor_extensions/mips.c      | 22 ++++++++++++++++++++++
>   5 files changed, 62 insertions(+)
>
> diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> index e14f26368963c178e3271e0f716b27fff7671e78..3c1f92e406c3f21481b56e61229716fd02ab81b2 100644
> --- a/arch/riscv/Kconfig.vendor
> +++ b/arch/riscv/Kconfig.vendor
> @@ -16,6 +16,19 @@ config RISCV_ISA_VENDOR_EXT_ANDES
>   	  If you don't know what to do here, say Y.
>   endmenu
>   
> +menu "MIPS"
> +config RISCV_ISA_VENDOR_EXT_MIPS
> +	bool "MIPS vendor extension support"
> +	select RISCV_ISA_VENDOR_EXT
> +	default y
> +	help
> +	  Say N here to disable detection of and support for all MIPS vendor
> +	  extensions. Without this option enabled, MIPS vendor extensions will
> +	  not be detected at boot and their presence not reported to userspace.
> +
> +	  If you don't know what to do here, say Y.
> +endmenu
> +
>   menu "SiFive"
>   config RISCV_ISA_VENDOR_EXT_SIFIVE
>   	bool "SiFive vendor extension support"
> diff --git a/arch/riscv/include/asm/vendor_extensions/mips.h b/arch/riscv/include/asm/vendor_extensions/mips.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..757c941cfd86e9fced6169b1a82200e6bb5c6132
> --- /dev/null
> +++ b/arch/riscv/include/asm/vendor_extensions/mips.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 MIPS.
> + */
> +
> +#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_MIPS_H
> +#define _ASM_RISCV_VENDOR_EXTENSIONS_MIPS_H
> +
> +#include <asm/vendor_extensions.h>
> +#include <linux/types.h>
> +
> +#define RISCV_ISA_VENDOR_EXT_XMIPSEXECTL	0
> +
> +extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_mips;
> +
> +#endif // _ASM_RISCV_VENDOR_EXTENSIONS_MIPS_H
> diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
> index 92d8ff81f42c9ceba63bef0170ab134564a24a4e..bb4a7592368560ebacbcd8a5ce335eea6312ea5c 100644
> --- a/arch/riscv/kernel/vendor_extensions.c
> +++ b/arch/riscv/kernel/vendor_extensions.c
> @@ -6,6 +6,7 @@
>   #include <asm/vendorid_list.h>
>   #include <asm/vendor_extensions.h>
>   #include <asm/vendor_extensions/andes.h>
> +#include <asm/vendor_extensions/mips.h>
>   #include <asm/vendor_extensions/sifive.h>
>   #include <asm/vendor_extensions/thead.h>
>   
> @@ -16,6 +17,9 @@ struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[] = {
>   #ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
>   	&riscv_isa_vendor_ext_list_andes,
>   #endif
> +#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_MIPS
> +	&riscv_isa_vendor_ext_list_mips,
> +#endif
>   #ifdef CONFIG_RISCV_ISA_VENDOR_EXT_SIFIVE
>   	&riscv_isa_vendor_ext_list_sifive,
>   #endif
> @@ -49,6 +53,12 @@ bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsig
>   		cpu_bmap = riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap;
>   		break;
>   	#endif
> +	#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_MIPS
> +	case MIPS_VENDOR_ID:
> +		bmap = &riscv_isa_vendor_ext_list_mips.all_harts_isa_bitmap;
> +		cpu_bmap = riscv_isa_vendor_ext_list_mips.per_hart_isa_bitmap;
> +		break;
> +	#endif
>   	#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_SIFIVE
>   	case SIFIVE_VENDOR_ID:
>   		bmap = &riscv_isa_vendor_ext_list_sifive.all_harts_isa_bitmap;
> diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/kernel/vendor_extensions/Makefile
> index a4eca96d1c8a2fd165220f6439a3884cf90a9593..ccad4ebafb43412e72e654da3bdb9face53b80c6 100644
> --- a/arch/riscv/kernel/vendor_extensions/Makefile
> +++ b/arch/riscv/kernel/vendor_extensions/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
>   obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_ANDES)	+= andes.o
> +obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_MIPS)  	+= mips.o
>   obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_SIFIVE)	+= sifive.o
>   obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_SIFIVE)	+= sifive_hwprobe.o
>   obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)	+= thead.o
> diff --git a/arch/riscv/kernel/vendor_extensions/mips.c b/arch/riscv/kernel/vendor_extensions/mips.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f691129f96c21f2ef089124f4b64a6f0a8e6d4aa
> --- /dev/null
> +++ b/arch/riscv/kernel/vendor_extensions/mips.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 MIPS.
> + */
> +
> +#include <asm/cpufeature.h>
> +#include <asm/vendor_extensions.h>
> +#include <asm/vendor_extensions/mips.h>
> +
> +#include <linux/array_size.h>
> +#include <linux/cpumask.h>
> +#include <linux/types.h>
> +
> +/* All MIPS vendor extensions supported in Linux */
> +static const struct riscv_isa_ext_data riscv_isa_vendor_ext_mips[] = {
> +	__RISCV_ISA_EXT_DATA(xmipsexectl, RISCV_ISA_VENDOR_EXT_XMIPSEXECTL),
> +};
> +
> +struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_mips = {
> +	.ext_data_count = ARRAY_SIZE(riscv_isa_vendor_ext_mips),
> +	.ext_data = riscv_isa_vendor_ext_mips,
> +};


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


