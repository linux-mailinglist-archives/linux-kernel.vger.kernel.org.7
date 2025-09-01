Return-Path: <linux-kernel+bounces-794050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CFEB3DC28
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A2E57AAAF6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1CE253B4C;
	Mon,  1 Sep 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gik7oPrH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A58233149;
	Mon,  1 Sep 2025 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714821; cv=none; b=UQZyc82d+zF4m7v5nTXhdLksybsndThOrGqsfHnK/9D1TJA4K2dRIQxRYCClppXDhq0jOUZ66WUK8pn48nqF5g9J4HtjEL+rHTP08XdUJQtFatmiZWy1walRc2IR1DMBFSufP4ffRyP3npybPcDNQM0Wqkbg/60FKuNN9prP4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714821; c=relaxed/simple;
	bh=zvN4MhG8R7eqp6XEv4Ny2CmRe4e0u83TGuBsremkeZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3mZudQQgI4q/2oKlzDT2TeLeAo7+bGqZqXiRqG1NC8b8iBBp6hQjL5NTv95as9HmIlNQvPlTXjeXJgvJVGb26hSIA8QUuVfrDMsq30UTV3AqhQkk2SCGxtUM5BZstEpnWuMNu6P45fQ6pgjP4obIIM7MNGCDIb0AyEihXyMPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gik7oPrH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kc1JMKz1kOG2DZTIPmCW9JCS5gq3B4TzLi84ah9UiLo=; b=gik7oPrHOsb+aqj8HGp4uwGpCy
	CNshygIK9o5rgCEHXO8RuovcX1zFHCtT8GQPQCOu4cBD2+Lpa/AqvhWH2E6QafKMJ1VaCnDmWuwV9
	QRH+Tj0PHkP5740sSI4nJNUXDLLQbAEcvMdki/UQ5VboIJbNduDrpX1sYWrwjO14w/xSEWkD3f68p
	xBqGhLDohP1w3+9CwXqVpDPPWKecSypZngeXriNAj7lc7ZDLXXjGwc09suAGwFRXPfIABFGWJYsc9
	/ZrjslccE0HIva1tN573UY78NYQjDIi7D/VWv2/a6s9Sknfxh9bQ/fyE2tOd4mwxJxsvdjAshK39i
	esVfhyWA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uszlw-000000059T8-3j5X;
	Mon, 01 Sep 2025 08:20:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1CEA1300342; Mon, 01 Sep 2025 10:20:17 +0200 (CEST)
Date: Mon, 1 Sep 2025 10:20:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] LoongArch: Fix unreachable instruction warnings
 about entry functions
Message-ID: <20250901082017.GC4067720@noisy.programming.kicks-ass.net>
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-4-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901072156.31361-4-yangtiezhu@loongson.cn>

On Mon, Sep 01, 2025 at 03:21:56PM +0800, Tiezhu Yang wrote:
> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
> following objtool warnings:
> 
>   vmlinux.o: warning: objtool: kernel_entry+0x0: unreachable instruction
>   vmlinux.o: warning: objtool: smpboot_entry+0x0: unreachable instruction
> 
> kernel_entry() and smpboot_entry() are in arch/loongarch/kernel/head.S,
> there is "OBJECT_FILES_NON_STANDARD_head.o := y" to skip objtool checking
> for head.o, but the STACK_FRAME_NON_STANDARD macro does not work for link
> time validation of vmlinux.o according to objtool documentation, just give
> a proper unwind hint to silence the warnings.
> 
> By the way, ASM_BUG() can be removed due to unnecessary, otherwise there
> are following warnings:
> 
>   kernel_entry+0xf4: start_kernel() missing __noreturn
>   in .c/.h or NORETURN() in noreturns.h
> 
>   smpboot_entry+0x68: start_secondary() missing __noreturn
>   in .c/.h or NORETURN() in noreturns.h
> 
> This is because the previous instructions of kernel_entry+0xf4 and
> smpboot_entry+0x68 are the 'bl' instructions, start_kernel() and
> start_secondary() are the respective call destination symbols which
> are noreturn functions, then the 'bl' instructions are already marked
> as dead end in annotate_call_site().
> 
> For now, it is time to remove "OBJECT_FILES_NON_STANDARD_head.o := y"
> in arch/loongarch/kernel/Makefile.
> 
> Link: https://lore.kernel.org/lkml/20250814083651.GR4067720@noisy.programming.kicks-ass.net/
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Right, this looks good.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/loongarch/kernel/Makefile | 2 --
>  arch/loongarch/kernel/head.S   | 6 ++----
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index 6f5a4574a911..4302c5b0a201 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -3,8 +3,6 @@
>  # Makefile for the Linux/LoongArch kernel.
>  #
>  
> -OBJECT_FILES_NON_STANDARD_head.o := y
> -
>  always-$(KBUILD_BUILTIN)	:= vmlinux.lds
>  
>  obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index e3865e92a917..a11880f3a7e1 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -42,6 +42,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
>  	.align 12
>  
>  SYM_CODE_START(kernel_entry)			# kernel entry point
> +	UNWIND_HINT_UNDEFINED
>  
>  	/* Config direct window and set PG */
>  	SETUP_DMWINS	t0
> @@ -109,8 +110,6 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
>  #endif
>  
>  	bl		start_kernel
> -	ASM_BUG()
> -
>  SYM_CODE_END(kernel_entry)
>  
>  #ifdef CONFIG_SMP
> @@ -120,6 +119,7 @@ SYM_CODE_END(kernel_entry)
>   * function after setting up the stack and tp registers.
>   */
>  SYM_CODE_START(smpboot_entry)
> +	UNWIND_HINT_UNDEFINED
>  
>  	SETUP_DMWINS	t0
>  	JUMP_VIRT_ADDR	t0, t1
> @@ -142,8 +142,6 @@ SYM_CODE_START(smpboot_entry)
>  	ld.d		tp, t0, CPU_BOOT_TINFO
>  
>  	bl		start_secondary
> -	ASM_BUG()
> -
>  SYM_CODE_END(smpboot_entry)
>  
>  #endif /* CONFIG_SMP */
> -- 
> 2.42.0
> 

