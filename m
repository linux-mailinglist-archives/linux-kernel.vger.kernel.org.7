Return-Path: <linux-kernel+bounces-876365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F776C1BA22
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 946D44E9A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B09283683;
	Wed, 29 Oct 2025 14:33:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1754A2BD001
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748417; cv=none; b=kKhJ/2UQR3hML4d1GYvqDnxLngBkq6m6DHdZUTEzC+lIHWHbgQV8oC3Fa4m34MuFehT6Ol9H1iBjYuitMQJrjyAvOH0go0VV8H9z61Cx9xEaBvr9YTqXoeVeyXXVwqrhEpZrB6rX2pDJQC0PFDqg7eU8DGP1J/Q7gDp+eYjdo+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748417; c=relaxed/simple;
	bh=YS6sQNVHlAdBS6vHtXcSV/2beSmCmquuq27nnmmYGHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1+v/+oBGv4DtF2ceai76dpbSbNBqzhFpgg4m4RFjCBh7D7mS0yHYgsl9Sw8WL0MkbF5XPaxAM1+uYsm1GP1MUb/98RuOLVo7PEzvQ/VkEe7NK+jyDDKuNTieNj+Hu9xEGpuMyirMdUgs9MmEoP7pWxL07DO3YIh3OINRSm9QiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 918791AC1;
	Wed, 29 Oct 2025 07:33:26 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B60463F66E;
	Wed, 29 Oct 2025 07:33:32 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:33:26 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ben Niu <benniu@meta.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, tytso@mit.edu, Jason@zx2c4.com,
	Ben Niu <niuben003@gmail.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Enable kprobe tracing for Arm64 asm functions
Message-ID: <aQIltqoIVDwh4A6p@J2N7QTR9R3>
References: <20251027181749.240466-1-benniu@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027181749.240466-1-benniu@meta.com>

On Mon, Oct 27, 2025 at 11:17:49AM -0700, Ben Niu wrote:
> Currently, Arm64 assembly functions always have a bti c
> instruction inserted before the prologue. When ftrace is enabled,
> no padding nops are inserted at all.
> 
> This breaks kprobe tracing for asm functions, which assumes that
> proper nops are added before and within functions (when ftrace is
> enabled) and bti c is only present when CONFIG_ARM64_BTI_KERNEL is
> defined.

What exactly do you mean by "breaks kprobe tracing"?

The kprobes code knows NOTHING about those ftrace NOPs, so I cannot see
how those are relevant.

The patch adds entries to __patchable_function_entries, which is owned
by ftrace, and has NOTHING to do with kprobes.

> The patch fixes the bug by inserting nops and bti c in Arm64 asm
> in the same way as compiled C code.

As it stands, NAK to this change.

I'm not averse to making (some) assembly functions traceable by ftrace,
and hence giving those NOPs. However, that's not safe generally (e.g.
due to noinstr requirements), and so special care will need to be taken.

The rationale above does not make sense; it conflates distinct things,
and I think a more complete explanation is necessary.

Mark.

> Note: although this patch unblocks kprobe tracing, fentry is still
> broken because no BTF info gets generated from assembly files. A
> separate patch is needed to fix that.
> 
> I built this patch with different combos of the following features
> and confirmed kprobe tracing for asm function __arch_copy_to_user
> worked in all cases:
> 
> CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> CONFIG_ARM64_BTI_KERNEL
> 
> Signed-off-by: Ben Niu <benniu@meta.com>
> ---
>  arch/arm64/include/asm/linkage.h           | 103 ++++++++++++++++-----
>  arch/arm64/kernel/vdso/vgetrandom-chacha.S |   2 +-
>  2 files changed, 81 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
> index d3acd9c87509..f3f3bc168162 100644
> --- a/arch/arm64/include/asm/linkage.h
> +++ b/arch/arm64/include/asm/linkage.h
> @@ -5,8 +5,47 @@
>  #include <asm/assembler.h>
>  #endif
>  
> -#define __ALIGN		.balign CONFIG_FUNCTION_ALIGNMENT
> -#define __ALIGN_STR	".balign " #CONFIG_FUNCTION_ALIGNMENT
> +#define __ALIGN .balign CONFIG_FUNCTION_ALIGNMENT
> +#define __ALIGN_STR ".balign " #CONFIG_FUNCTION_ALIGNMENT
> +
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> +
> +#define PRE_FUNCTION_NOPS                                                   \
> +	ALIGN;                                                              \
> +	nops CONFIG_FUNCTION_ALIGNMENT / 4 - 2;                             \
> +	.pushsection __patchable_function_entries, "awo", @progbits, .text; \
> +	.p2align 3;                                                         \
> +	.8byte 1f;                                                          \
> +	.popsection;                                                        \
> +	1 :;                                                                \
> +	nops 2;
> +
> +#define PRE_PROLOGUE_NOPS nops 2;
> +
> +#elif defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS)
> +
> +#define PRE_FUNCTION_NOPS
> +
> +#define PRE_PROLOGUE_NOPS                                                   \
> +	.pushsection __patchable_function_entries, "awo", @progbits, .text; \
> +	.p2align 3;                                                         \
> +	.8byte 1f;                                                          \
> +	.popsection;                                                        \
> +	1 :;                                                                \
> +	nops 2;
> +
> +#else
> +
> +#define PRE_FUNCTION_NOPS
> +#define PRE_PROLOGUE_NOPS
> +
> +#endif
> +
> +#ifdef CONFIG_ARM64_BTI_KERNEL
> +#define BTI_C bti c;
> +#else
> +#define BTI_C
> +#endif
>  
>  /*
>   * When using in-kernel BTI we need to ensure that PCS-conformant
> @@ -15,32 +54,50 @@
>   * everything, the override is done unconditionally so we're more
>   * likely to notice any drift from the overridden definitions.
>   */
> -#define SYM_FUNC_START(name)				\
> -	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
> -	bti c ;
> +#define SYM_FUNC_START(name)                       \
> +	PRE_FUNCTION_NOPS                          \
> +	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
> +	BTI_C                                      \
> +	PRE_PROLOGUE_NOPS
> +
> +#define SYM_FUNC_START_NOTRACE(name)               \
> +	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
> +	BTI_C
>  
> -#define SYM_FUNC_START_NOALIGN(name)			\
> -	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
> -	bti c ;
> +#define SYM_FUNC_START_NOALIGN(name)              \
> +	PRE_FUNCTION_NOPS                         \
> +	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE) \
> +	BTI_C                                     \
> +	PRE_PROLOGUE_NOPS
>  
> -#define SYM_FUNC_START_LOCAL(name)			\
> -	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
> -	bti c ;
> +#define SYM_FUNC_START_LOCAL(name)                \
> +	PRE_FUNCTION_NOPS                         \
> +	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN) \
> +	BTI_C                                     \
> +	PRE_PROLOGUE_NOPS
>  
> -#define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
> -	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
> -	bti c ;
> +#define SYM_FUNC_START_LOCAL_NOALIGN(name)       \
> +	PRE_FUNCTION_NOPS                        \
> +	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE) \
> +	BTI_C                                    \
> +	PRE_PROLOGUE_NOPS
>  
> -#define SYM_FUNC_START_WEAK(name)			\
> -	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
> -	bti c ;
> +#define SYM_FUNC_START_WEAK(name)                \
> +	PRE_FUNCTION_NOPS                        \
> +	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN) \
> +	BTI_C                                    \
> +	PRE_PROLOGUE_NOPS
>  
> -#define SYM_FUNC_START_WEAK_NOALIGN(name)		\
> -	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
> -	bti c ;
> +#define SYM_FUNC_START_WEAK_NOALIGN(name)       \
> +	PRE_FUNCTION_NOPS                       \
> +	SYM_START(name, SYM_L_WEAK, SYM_A_NONE) \
> +	BTI_C                                   \
> +	PRE_PROLOGUE_NOPS
>  
> -#define SYM_TYPED_FUNC_START(name)				\
> -	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
> -	bti c ;
> +#define SYM_TYPED_FUNC_START(name)                       \
> +	PRE_FUNCTION_NOPS                                \
> +	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN) \
> +	BTI_C                                            \
> +	PRE_PROLOGUE_NOPS
>  
>  #endif
> diff --git a/arch/arm64/kernel/vdso/vgetrandom-chacha.S b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> index 67890b445309..21c27b64cf9f 100644
> --- a/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> +++ b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> @@ -40,7 +40,7 @@
>   *	x2: 8-byte counter input/output
>   *	x3: number of 64-byte block to write to output
>   */
> -SYM_FUNC_START(__arch_chacha20_blocks_nostack)
> +SYM_FUNC_START_NOTRACE(__arch_chacha20_blocks_nostack)
>  
>  	/* copy0 = "expand 32-byte k" */
>  	mov_q		x8, 0x3320646e61707865
> -- 
> 2.47.3
> 
> 

