Return-Path: <linux-kernel+bounces-786213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E91B35699
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072221B6230D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1652F746F;
	Tue, 26 Aug 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CIw7fc2O"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63442F744D;
	Tue, 26 Aug 2025 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196464; cv=none; b=ZP7a6rLa2FF+ngL3+1P8UJer746Q0IRjH38ThZB3Pqs0EWXBWO8L88mk+GBtKANYtnh2h3KHI2YLK+uk5OnXDzAXud8AjQiPY21T2NifPKbO4+nVZMGscHn3UOAGUDtE4E6l+Bvx71vh4SqxpEFZ6ga9ggjT3hdFAaMyysM7NQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196464; c=relaxed/simple;
	bh=zyOGpBT6MU4etiUjt/+Sh12XWH1nahSQBOLNyqnlQWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzS/l2OPMnhw3rncYKs3dmpw2ID2i6UyBZqmULDHEASxUGfORrQkZgEMpeJZJbLWs1GVA1SwN5Q3QlYWglgVDv6KeDPYnoXY1l3vRmRnicpqh/Z7bN9fAykkZZiYIBcQOmWp10avu7bEobE69DNHfgGKWIDaX4856Risa2UzpaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CIw7fc2O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eW0qdKlKEDtIany2UuaD5p42GlzthPL/TQWYZP8788M=; b=CIw7fc2OrZsjpXqHLNwYmAz1Le
	8GEghXTiWVWAMn71wDSBl8yFKxdbVOfo0IBpEFdEif7zmH5WiisbDFiubGax1Y+F2f5UqkwYGAGh5
	7AD6vVJonNr6m8GXiSNwkNdcW+aLHEGXfVc5oRTCHZOofrz3vDh967B7xQ3X/pTp5EdP8uKJuDenF
	fMnnE7AMaEuT1p5hPlrbuYym6DbNpgGdCNvqjcp3kluFBpn0a1iQw90IEQRf7z4YSSk+/tCoI5Zcu
	dtKkyxen/3EW53p5/rTRTmjab5+Zlmtx+T4cASx34DTV9wbK0bjAdQhcpdDSvO+IVYHRfuZ/pdrBN
	rRcdKtLQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqovJ-0000000F2u3-1rni;
	Tue, 26 Aug 2025 08:20:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A0AE03002C5; Tue, 26 Aug 2025 10:20:57 +0200 (CEST)
Date: Tue, 26 Aug 2025 10:20:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] objtool/LoongArch: Fix unreachable instruction
 warnings about head.S
Message-ID: <20250826082057.GE3245006@noisy.programming.kicks-ass.net>
References: <20250826064631.9617-1-yangtiezhu@loongson.cn>
 <20250826064631.9617-3-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826064631.9617-3-yangtiezhu@loongson.cn>

On Tue, Aug 26, 2025 at 02:46:31PM +0800, Tiezhu Yang wrote:
> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
> following objtool warnings after silencing all of the other warnings:
> 
>   LD      vmlinux.o
> vmlinux.o: warning: objtool: .head.text+0x0: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x18: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x38: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x3c: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x40: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x44: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x54: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x58: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x6c: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x84: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x94: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x9c: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0xc4: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0xf8: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0xfc: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x104: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x10c: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x11c: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x120: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x124: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x144: unreachable instruction
> vmlinux.o: warning: objtool: kernel_entry+0x0: unreachable instruction
> vmlinux.o: warning: objtool: smpboot_entry+0x0: unreachable instruction
> 
> All of the above instructions are in arch/loongarch/kernel/head.S,
> and there is "OBJECT_FILES_NON_STANDARD_head.o := y" in Makefile
> to skip objtool checking for head.o, but OBJECT_FILES_NON_STANDARD
> does not work for link time validation of vmlinux.o according to
> tools/objtool/Documentation/objtool.txt.
> 
> Just give a proper unwind hint to silence the above warnings. By the way,
> the previous instructions of kernel_entry+0xf4 and smpboot_entry+0x68 are
> the 'bl' instructions, the call destination symbols are start_kernel() and
> start_secondary() which are noreturn functions, then the 'bl' instructions
> are marked as dead end in annotate_call_site(), so actually ASM_BUG() can
> be removed due to unnecessary, otherwise there are following warnings:
> 
>   kernel_entry+0xf4: start_kernel() missing __noreturn
>   in .c/.h or NORETURN() in noreturns.h
> 
>   smpboot_entry+0x68: start_secondary() missing __noreturn
>   in .c/.h or NORETURN() in noreturns.h
> 
> Link: https://lore.kernel.org/lkml/20250814083651.GR4067720@noisy.programming.kicks-ass.net/
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/kernel/head.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

At this point you should also be able to remove that Makefile thing,
right?


> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index e3865e92a917..566a1dbf5fa0 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -20,6 +20,7 @@
>  	__HEAD
>  
>  _head:
> +	UNWIND_HINT_UNDEFINED
>  	.word	IMAGE_DOS_SIGNATURE	/* "MZ", MS-DOS header */
>  	.org	0x8
>  	.dword	_kernel_entry		/* Kernel entry point (physical address) */
> @@ -30,6 +31,7 @@ _head:
>  	.long	pe_header - _head	/* Offset to the PE header */
>  
>  pe_header:
> +	UNWIND_HINT_UNDEFINED
>  	__EFI_PE_HEADER
>  
>  SYM_DATA(kernel_asize, .long _kernel_asize);
> @@ -42,6 +44,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
>  	.align 12
>  
>  SYM_CODE_START(kernel_entry)			# kernel entry point
> +	UNWIND_HINT_UNDEFINED
>  
>  	/* Config direct window and set PG */
>  	SETUP_DMWINS	t0
> @@ -109,8 +112,6 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
>  #endif
>  
>  	bl		start_kernel
> -	ASM_BUG()
> -
>  SYM_CODE_END(kernel_entry)
>  
>  #ifdef CONFIG_SMP
> @@ -120,6 +121,7 @@ SYM_CODE_END(kernel_entry)
>   * function after setting up the stack and tp registers.
>   */
>  SYM_CODE_START(smpboot_entry)
> +	UNWIND_HINT_UNDEFINED
>  
>  	SETUP_DMWINS	t0
>  	JUMP_VIRT_ADDR	t0, t1
> @@ -142,8 +144,6 @@ SYM_CODE_START(smpboot_entry)
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

