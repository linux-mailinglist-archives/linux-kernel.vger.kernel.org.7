Return-Path: <linux-kernel+bounces-734958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F56FB088D2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE171894083
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3837328F933;
	Thu, 17 Jul 2025 09:01:39 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610D728A715;
	Thu, 17 Jul 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742898; cv=none; b=uHzBH/5yk3Ofjb1rH1Q2Rw67leMcZutId/YxX/laBHY/y4s4vlzRMmMt75PvbSGnyjtbBD9r9Kzlu6kYXpUPSiRcAaCd+rbquw83t9FUgyZF0v7R53CsHG8tqv8uxego86U0vRNqXAVmYB6FCpzA3Z78DVhmgXOISsllc++RLjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742898; c=relaxed/simple;
	bh=n6tjybBAfhSWYdb2X5IJ/kL/Ezr9vo+W7eGkw3m0LxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDc8ZtMtivyePJCARsG1i/jgQyEbnNEfPcipnzuDy8HeE84Ss1byNAMF5qEgVHD8fOVqrtw+muofvXPvJMz4f9P6wu9OCpW3PjxFSnd/pxdoAuFi9y5am4ZekzZgRgolPoJk3djm07Xuf3DWdK9ioiraPed2fhSnpyBK8gw3vis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20A8042DF9;
	Thu, 17 Jul 2025 09:01:30 +0000 (UTC)
Message-ID: <d3c9e302-d8e6-47ef-b2f5-53c56f8ab5e2@ghiti.fr>
Date: Thu, 17 Jul 2025 11:01:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] riscv: hwprobe: Add MIPS vendor extension probing
To: aleksa.paunovic@htecgroup.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250625-p8700-pause-v4-0-6c7dd7f85756@htecgroup.com>
 <20250625-p8700-pause-v4-4-6c7dd7f85756@htecgroup.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250625-p8700-pause-v4-4-6c7dd7f85756@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppedukeehrddvudefrdduheegrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudekhedrvddufedrudehgedrudehuddphhgvlhhopegluddtrddugedrtddrudefngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegrlhgvkhhsrgdrphgruhhnohhvihgtsehhthgvtghgrhhouhhprdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvl
 hhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvth
X-GND-Sasl: alex@ghiti.fr

On 6/25/25 16:20, Aleksa Paunovic via B4 Relay wrote:
> From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
>
> Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_MIPS_0" which allows
> userspace to probe for the new xmipsexectl vendor extension.
>
> Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
> ---
>   arch/riscv/include/asm/hwprobe.h                   |  3 ++-
>   .../include/asm/vendor_extensions/mips_hwprobe.h   | 23 ++++++++++++++++++++++
>   arch/riscv/include/uapi/asm/hwprobe.h              |  1 +
>   arch/riscv/include/uapi/asm/vendor/mips.h          |  3 +++
>   arch/riscv/kernel/sys_hwprobe.c                    |  4 ++++
>   arch/riscv/kernel/vendor_extensions/Makefile       |  1 +
>   arch/riscv/kernel/vendor_extensions/mips_hwprobe.c | 22 +++++++++++++++++++++
>   7 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> index 7fe0a379474ae2c64d300d6fee4a012173f6a6d7..948d2b34e94e84e4c2c351ffe91f4b3afcefc3f7 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>   
>   #include <uapi/asm/hwprobe.h>
>   
> -#define RISCV_HWPROBE_MAX_KEY 13
> +#define RISCV_HWPROBE_MAX_KEY 14
>   
>   static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>   {
> @@ -22,6 +22,7 @@ static inline bool hwprobe_key_is_bitmask(__s64 key)
>   	case RISCV_HWPROBE_KEY_IMA_EXT_0:
>   	case RISCV_HWPROBE_KEY_CPUPERF_0:
>   	case RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0:
> +	case RISCV_HWPROBE_KEY_VENDOR_EXT_MIPS_0:
>   	case RISCV_HWPROBE_KEY_VENDOR_EXT_SIFIVE_0:
>   		return true;
>   	}
> diff --git a/arch/riscv/include/asm/vendor_extensions/mips_hwprobe.h b/arch/riscv/include/asm/vendor_extensions/mips_hwprobe.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..0af8c07c22f293b5f772709f774de78dd60c7f39
> --- /dev/null
> +++ b/arch/riscv/include/asm/vendor_extensions/mips_hwprobe.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 MIPS.
> + */
> +
> +#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_MIPS_HWPROBE_H_
> +#define _ASM_RISCV_VENDOR_EXTENSIONS_MIPS_HWPROBE_H_
> +
> +#include <linux/cpumask.h>
> +#include <uapi/asm/hwprobe.h>
> +
> +


2 newlines here ^


> +#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_MIPS
> +void hwprobe_isa_vendor_ext_mips_0(struct riscv_hwprobe *pair, const struct cpumask *cpus);
> +#else
> +static inline void hwprobe_isa_vendor_ext_mips_0(struct riscv_hwprobe *pair,
> +						 const struct cpumask *cpus)
> +{
> +	pair->value = 0;
> +}
> +#endif
> +
> +#endif // _ASM_RISCV_VENDOR_EXTENSIONS_MIPS_HWPROBE_H_
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index aaf6ad97049931381f9542bb9316c873ec6ab9f6..5d30a4fae37a82ef4d968d20b187420772ad8946 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -106,6 +106,7 @@ struct riscv_hwprobe {
>   #define RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0	11
>   #define RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE	12
>   #define RISCV_HWPROBE_KEY_VENDOR_EXT_SIFIVE_0	13
> +#define RISCV_HWPROBE_KEY_VENDOR_EXT_MIPS_0	14
>   /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>   
>   /* Flags */
> diff --git a/arch/riscv/include/uapi/asm/vendor/mips.h b/arch/riscv/include/uapi/asm/vendor/mips.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..11d41651178233a5f06ab9541ea0506d9883aa19
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/vendor/mips.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +
> +#define RISCV_HWPROBE_VENDOR_EXT_XMIPSEXECTL	(1 << 0)
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index 0b170e18a2beba576f4f8787d6ef6aa67c5c3d0e..6c73e167ef4ccc7f99dd2793acde2595fffdcbad 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -15,6 +15,7 @@
>   #include <asm/uaccess.h>
>   #include <asm/unistd.h>
>   #include <asm/vector.h>
> +#include <asm/vendor_extensions/mips_hwprobe.h>
>   #include <asm/vendor_extensions/sifive_hwprobe.h>
>   #include <asm/vendor_extensions/thead_hwprobe.h>
>   #include <vdso/vsyscall.h>
> @@ -309,6 +310,9 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>   	case RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0:
>   		hwprobe_isa_vendor_ext_thead_0(pair, cpus);
>   		break;
> +	case RISCV_HWPROBE_KEY_VENDOR_EXT_MIPS_0:
> +		hwprobe_isa_vendor_ext_mips_0(pair, cpus);
> +		break;
>   
>   	/*
>   	 * For forward compatibility, unknown keys don't fail the whole
> diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/kernel/vendor_extensions/Makefile
> index ccad4ebafb43412e72e654da3bdb9face53b80c6..bf116c82b6bdb3aee23e27fc0b2a69be7c7a5ccb 100644
> --- a/arch/riscv/kernel/vendor_extensions/Makefile
> +++ b/arch/riscv/kernel/vendor_extensions/Makefile
> @@ -2,6 +2,7 @@
>   
>   obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_ANDES)	+= andes.o
>   obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_MIPS)  	+= mips.o
> +obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_MIPS)  	+= mips_hwprobe.o
>   obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_SIFIVE)	+= sifive.o
>   obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_SIFIVE)	+= sifive_hwprobe.o
>   obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_THEAD)	+= thead.o
> diff --git a/arch/riscv/kernel/vendor_extensions/mips_hwprobe.c b/arch/riscv/kernel/vendor_extensions/mips_hwprobe.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..43944f2b484af257fa358cda53c12b4d6f54b78b
> --- /dev/null
> +++ b/arch/riscv/kernel/vendor_extensions/mips_hwprobe.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 MIPS.
> + */
> +
> +#include <asm/vendor_extensions/mips.h>
> +#include <asm/vendor_extensions/mips_hwprobe.h>
> +#include <asm/vendor_extensions/vendor_hwprobe.h>
> +
> +#include <linux/cpumask.h>
> +#include <linux/types.h>
> +
> +#include <uapi/asm/hwprobe.h>
> +#include <uapi/asm/vendor/mips.h>
> +
> +void hwprobe_isa_vendor_ext_mips_0(struct riscv_hwprobe *pair,
> +				   const struct cpumask *cpus)
> +{
> +	VENDOR_EXTENSION_SUPPORTED(
> +		pair, cpus, riscv_isa_vendor_ext_list_mips.per_hart_isa_bitmap,
> +		{ VENDOR_EXT_KEY(XMIPSEXECTL); });
> +}


I'll remove the superfluous newline when merging the patchset:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


