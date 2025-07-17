Return-Path: <linux-kernel+bounces-735182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AF9B08BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2F7189CA05
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D26229B227;
	Thu, 17 Jul 2025 11:43:25 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7F219EB;
	Thu, 17 Jul 2025 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752604; cv=none; b=TSj8cXzpQA6hxka39KALMyaLJW4lKFctLebiHNhq6o2Ig9M5bHlT2S6k5vnKdfvc9M49kmVkXEwEwLw6mM4yYpg5NHCJPw0Wk6tMSvAY+CclMRcj51kqpihyPVd89cg62+QHHeiST/8fic9x2y8ao3yLaIC6C2OSVsl1ALvwtjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752604; c=relaxed/simple;
	bh=f/JGPIlkArCSuP1Bl9uUK8vHBn/y8/bhPS4T0Rg/pVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mlp/6AkEr7KtLwjAFg/ccSuVZT00Ta0l06lF69M9ndqcna4v2cJD4+hOWmogq7gvybN9u5mtQidBiZVytcU/yr2gXPbA2THtENBvuooAWbbD8wTk9XtYc59MmZF2o+92xC0f6n703er7jUud1FIG6IaIKRbBgEd5sMUEbDFfXBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB5944394B;
	Thu, 17 Jul 2025 11:43:13 +0000 (UTC)
Message-ID: <9c6135a9-3edd-443f-9ff2-fd70d8c8197d@ghiti.fr>
Date: Thu, 17 Jul 2025 13:43:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] riscv: errata: Fix the PAUSE Opcode for MIPS P8700
To: aleksa.paunovic@htecgroup.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Raj Vishwanathan4 <rvishwanathan@mips.com>
References: <20250625-p8700-pause-v4-0-6c7dd7f85756@htecgroup.com>
 <20250625-p8700-pause-v4-7-6c7dd7f85756@htecgroup.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250625-p8700-pause-v4-7-6c7dd7f85756@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhephffhtdefjeetgfdvhfehgefhteekkeevffehheegtedtieduheeltdegheeuleffnecuffhomhgrihhnpegvnhhtrhihrdhssgenucfkphepudekhedrvddufedrudehgedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedukeehrddvudefrdduheegrdduhedupdhhvghloheplgdutddrudegrddtrddufegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheprghlvghkshgrrdhprghunhhovhhitgeshhhtvggtghhrohhuphdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtp
 hhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvght
X-GND-Sasl: alex@ghiti.fr

On 6/25/25 16:21, Aleksa Paunovic via B4 Relay wrote:
> From: Djordje Todorovic <djordje.todorovic@htecgroup.com>
>
> Add ERRATA_MIPS and ERRATA_MIPS_P8700_PAUSE_OPCODE configs.
> Handle errata for the MIPS PAUSE instruction.
>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
> Signed-off-by: Raj Vishwanathan4 <rvishwanathan@mips.com>
> Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
> ---
>   arch/riscv/Kconfig.errata               | 23 +++++++++++
>   arch/riscv/errata/Makefile              |  1 +
>   arch/riscv/errata/mips/Makefile         |  5 +++
>   arch/riscv/errata/mips/errata.c         | 67 +++++++++++++++++++++++++++++++++
>   arch/riscv/include/asm/alternative.h    |  3 ++
>   arch/riscv/include/asm/cmpxchg.h        |  3 +-
>   arch/riscv/include/asm/errata_list.h    | 17 ++++++++-
>   arch/riscv/include/asm/vdso/processor.h |  4 +-
>   arch/riscv/include/asm/vendorid_list.h  |  1 +
>   arch/riscv/kernel/alternative.c         |  5 +++
>   arch/riscv/kernel/entry.S               |  2 +
>   arch/riscv/mm/init.c                    |  1 +
>   12 files changed, 129 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index e318119d570de0acc0850a2e1a2505ecb71bea08..aca9b0cfcfecf91d4d1910f294ee109ed15f2d6c 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -21,6 +21,29 @@ config ERRATA_ANDES_CMO
>   
>   	  If you don't know what to do here, say "Y".
>   
> +config ERRATA_MIPS
> +	bool "MIPS errata"
> +	depends on RISCV_ALTERNATIVE
> +	help
> +	  All MIPS errata Kconfig depend on this Kconfig. Disabling
> +	  this Kconfig will disable all MIPS errata. Please say "Y"
> +	  here if your platform uses MIPS CPU cores.
> +
> +	  Otherwise, please say "N" here to avoid unnecessary overhead.
> +
> +config ERRATA_MIPS_P8700_PAUSE_OPCODE
> +	bool "Fix the PAUSE Opcode for MIPS P8700"
> +	depends on ERRATA_MIPS && 64BIT
> +	default n
> +	help
> +	   The RISCV MIPS P8700 uses a different opcode for PAUSE.
> +	   It is a 'hint' encoding of the SLLI instruction,
> +	   with rd=0, rs1=0 and imm=5. It will behave as a NOP
> +	   instruction if no additional behavior beyond that of
> +	   SLLI is implemented.
> +
> +	   If you are not using the P8700 processor, say n.
> +
>   config ERRATA_SIFIVE
>   	bool "SiFive errata"
>   	depends on RISCV_ALTERNATIVE
> diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
> index bc6c77ba837d2da4c98dabab18083d27f46629c7..02a7a3335b1d557933e04cd6d0cf7bf4260b8c40 100644
> --- a/arch/riscv/errata/Makefile
> +++ b/arch/riscv/errata/Makefile
> @@ -13,5 +13,6 @@ endif
>   endif
>   
>   obj-$(CONFIG_ERRATA_ANDES) += andes/
> +obj-$(CONFIG_ERRATA_MIPS) += mips/
>   obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
>   obj-$(CONFIG_ERRATA_THEAD) += thead/
> diff --git a/arch/riscv/errata/mips/Makefile b/arch/riscv/errata/mips/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..6278c389b801ee6e54e808c80e6e236c026329c7
> --- /dev/null
> +++ b/arch/riscv/errata/mips/Makefile
> @@ -0,0 +1,5 @@
> +ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
> +CFLAGS_errata.o := -mcmodel=medany
> +endif
> +
> +obj-y += errata.o
> diff --git a/arch/riscv/errata/mips/errata.c b/arch/riscv/errata/mips/errata.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..e984a8152208c34690f89d8101571b097485c360
> --- /dev/null
> +++ b/arch/riscv/errata/mips/errata.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 MIPS.
> + */
> +
> +#include <linux/memory.h>
> +#include <linux/module.h>
> +#include <asm/text-patching.h>
> +#include <asm/alternative.h>
> +#include <asm/errata_list.h>
> +#include <asm/vendorid_list.h>
> +#include <asm/vendor_extensions.h>
> +#include <asm/vendor_extensions/mips.h>
> +
> +static inline bool errata_probe_pause(void)
> +{
> +	if (!IS_ENABLED(CONFIG_ERRATA_MIPS_P8700_PAUSE_OPCODE))
> +		return false;
> +
> +	if (!riscv_isa_vendor_extension_available(MIPS_VENDOR_ID, XMIPSEXECTL))
> +		return false;
> +
> +	return true;
> +}
> +
> +static u32 mips_errata_probe(void)
> +{
> +	u32 cpu_req_errata = 0;
> +
> +	if (errata_probe_pause())
> +		cpu_req_errata |= BIT(ERRATA_MIPS_P8700_PAUSE_OPCODE);
> +
> +	return cpu_req_errata;
> +}
> +
> +void mips_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> +			    unsigned long archid, unsigned long impid,
> +			    unsigned int stage)
> +{
> +	struct alt_entry *alt;
> +	u32 cpu_req_errata = mips_errata_probe();
> +	u32 tmp;
> +
> +	BUILD_BUG_ON(ERRATA_MIPS_NUMBER >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
> +
> +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return;
> +
> +	for (alt = begin; alt < end; alt++) {
> +		if (alt->vendor_id != MIPS_VENDOR_ID)
> +			continue;
> +
> +		if (alt->patch_id >= ERRATA_MIPS_NUMBER) {
> +			WARN(1, "MIPS errata id:%d not in kernel errata list\n",
> +			     alt->patch_id);
> +			continue;
> +		}
> +
> +		tmp = (1U << alt->patch_id);
> +		if (cpu_req_errata && tmp) {
> +			mutex_lock(&text_mutex);
> +			patch_text_nosync(ALT_OLD_PTR(alt), ALT_ALT_PTR(alt),
> +					  alt->alt_len);
> +			mutex_unlock(&text_mutex);
> +		}
> +	}
> +}
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> index 3c2b59b25017929df92b4e6741ac1a9308bfec54..bc3ada8190a9e7dc7d904aeb3174c78329e4d8d7 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -48,6 +48,9 @@ struct alt_entry {
>   void andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>   			     unsigned long archid, unsigned long impid,
>   			     unsigned int stage);
> +void mips_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> +			      unsigned long archid, unsigned long impid,
> +			      unsigned int stage);
>   void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>   			      unsigned long archid, unsigned long impid,
>   			      unsigned int stage);
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 0b749e7102162477432f7cf9a34768fbdf2e8cc7..80bd52363c68690f33bfd54e0cc40399cd60b57b 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -14,6 +14,7 @@
>   #include <asm/insn-def.h>
>   #include <asm/cpufeature-macros.h>
>   #include <asm/processor.h>
> +#include <asm/errata_list.h>
>   
>   #define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,		\
>   			   swap_append, r, p, n)				\
> @@ -438,7 +439,7 @@ static __always_inline void __cmpwait(volatile void *ptr,
>   	return;
>   
>   no_zawrs:
> -	asm volatile(RISCV_PAUSE : : : "memory");
> +	ALT_RISCV_PAUSE();
>   }
>   
>   #define __cmpwait_relaxed(ptr, val) \
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 6e426ed7919a4acd997b60b723c0d5cfddb4cff6..618dee38d8d1347711fd46a459bfc8d2cb7bf42b 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -5,7 +5,6 @@
>   #ifndef ASM_ERRATA_LIST_H
>   #define ASM_ERRATA_LIST_H
>   
> -#include <asm/alternative.h>
>   #include <asm/csr.h>
>   #include <asm/insn-def.h>
>   #include <asm/hwcap.h>
> @@ -29,6 +28,11 @@
>   #define	ERRATA_THEAD_NUMBER 3
>   #endif
>   
> +#ifdef CONFIG_ERRATA_MIPS
> +#define ERRATA_MIPS_P8700_PAUSE_OPCODE 0
> +#define ERRATA_MIPS_NUMBER 1
> +#endif
> +
>   #ifdef __ASSEMBLY__
>   
>   #define ALT_INSN_FAULT(x)						\
> @@ -59,6 +63,17 @@ asm(ALTERNATIVE("sfence.vma %0, %1", "sfence.vma", SIFIVE_VENDOR_ID,	\
>   		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
>   		: : "r" (addr), "r" (asid) : "memory")
>   
> +#define ALT_RISCV_PAUSE()					\
> +asm(ALTERNATIVE(	\
> +		RISCV_PAUSE, /* Original RISC‑V pause insn */	\
> +		".4byte 0x00501013", /* Replacement for MIPS P8700 */	\


Here  you should use MIPS_PAUSE


> +		MIPS_VENDOR_ID, /* Vendor ID to match */	\
> +		ERRATA_MIPS_P8700_PAUSE_OPCODE, /* patch_id */	\
> +		CONFIG_ERRATA_MIPS_P8700_PAUSE_OPCODE)	\
> +	: /* no outputs */	\
> +	: /* no inputs */	\
> +	: "memory")
> +
>   /*
>    * _val is marked as "will be overwritten", so need to set it to 0
>    * in the default case.
> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
> index 8f383f05a290f123d941226b5dd975381d7d8536..8f749552ecfe6220bbc35f1c4677c6de8f7abdec 100644
> --- a/arch/riscv/include/asm/vdso/processor.h
> +++ b/arch/riscv/include/asm/vdso/processor.h
> @@ -5,6 +5,8 @@
>   #ifndef __ASSEMBLY__
>   
>   #include <asm/barrier.h>
> +


New line ^


> +#include <asm/errata_list.h>
>   #include <asm/insn-def.h>
>   
>   static inline void cpu_relax(void)
> @@ -19,7 +21,7 @@ static inline void cpu_relax(void)
>   	 * Reduce instruction retirement.
>   	 * This assumes the PC changes.
>   	 */
> -	__asm__ __volatile__ (RISCV_PAUSE);
> +	ALT_RISCV_PAUSE();
>   	barrier();
>   }
>   
> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
> index a5150cdf34d87f01baf6d3ef843bc2d6d8d54095..3b09874d7a6dfb8f8aa45b0be41c20711d539e78 100644
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -9,5 +9,6 @@
>   #define MICROCHIP_VENDOR_ID	0x029
>   #define SIFIVE_VENDOR_ID	0x489
>   #define THEAD_VENDOR_ID		0x5b7
> +#define MIPS_VENDOR_ID		0x722
>   
>   #endif
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
> index 7eb3cb1215c62130c63a72fc650cddff6bae62af..7642704c7f1841f67fc23738063f22b4ecf58194 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -47,6 +47,11 @@ static void riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info
>   		cpu_mfr_info->patch_func = andes_errata_patch_func;
>   		break;
>   #endif
> +#ifdef CONFIG_ERRATA_MIPS
> +	case MIPS_VENDOR_ID:
> +		cpu_mfr_info->patch_func = mips_errata_patch_func;
> +		break;
> +#endif
>   #ifdef CONFIG_ERRATA_SIFIVE
>   	case SIFIVE_VENDOR_ID:
>   		cpu_mfr_info->patch_func = sifive_errata_patch_func;
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 75656afa2d6be8ca5f2c4711455567c7f8fc0b97..b18373ed23d65df0dc828246269e9039bb0b0c6b 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -15,6 +15,8 @@
>   #include <asm/thread_info.h>
>   #include <asm/asm-offsets.h>
>   #include <asm/errata_list.h>
> +#include <asm/alternative.h>
> +
>   #include <linux/sizes.h>
>   
>   	.section .irqentry.text, "ax"
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 8d0374d7ce8ed72320f58e4cea212d0e2bce8fd4..7ee95ebadc258a3a46e59698cd143266f6797a0c 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -33,6 +33,7 @@
>   #include <asm/soc.h>
>   #include <asm/sparsemem.h>
>   #include <asm/tlbflush.h>
> +#include <asm/alternative.h>
>   
>   #include "../kernel/head.h"
>   
>
Why do you include alternative.h in both files above? That does not seem 
needed.

Other than that:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


