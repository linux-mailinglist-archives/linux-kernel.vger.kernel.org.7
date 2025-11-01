Return-Path: <linux-kernel+bounces-881144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEEEC278ED
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 08:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC2B189E34A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 07:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F0928C87D;
	Sat,  1 Nov 2025 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh+EMWSD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6EF10942
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761980735; cv=none; b=MyQII6Mhhr5VmFShfhKGPG7lgGTWFoQvsj9jmGVtLglBdPnBRV+OshMGy6lSvAr6vjLjQ6YGyicElayJCVvLsh37oLF1VOA740tx/XC8Lz+uNaQ54xWOtdyHYsflk7EFUu86z3jLdwVh3d1+DCPxiEIkrDftpf3ZncF+GgaTsVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761980735; c=relaxed/simple;
	bh=OoLB9zA1eU6CFb/IwN/ClKeZ4Zkepwn9SGLVjOcdXiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frYKJ6jaiaHeILjGd9/5YOkUsi/SdY0uAyCgE6ZBR7yRZKw6LTqNs9oyh/v+zNX/LcH9OIDF5DLYU7QvW2fE32ihBIiSIWbF/OZZbtrHw6X+QNB+PVbGdKcy5/Rvg3F6axHeY4Gqcdfv16SYnLGVe1OMVoDFW5UaxKy2rVxMySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh+EMWSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68C1C4CEF1;
	Sat,  1 Nov 2025 07:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761980734;
	bh=OoLB9zA1eU6CFb/IwN/ClKeZ4Zkepwn9SGLVjOcdXiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vh+EMWSDfNSkvhWbVGEFRwt7dnGxPOIpq+hzLeh1Cc2cBT+SbpZA56iza96lzs81M
	 js8kpTa1PNQw2DwxvdJN7EjUks7r+vLXsoH4XO4PIBy9ZnA10gfjDb5arLj6eFQYx4
	 Sy+3hFLTc/b4gV3DIFuACtk8RAMuPSwlcL0TtyfhbhH/gkhLK8Y29l977uRhcGXiM7
	 vd91tVtlNgkddpvi8jhu8cY9AJre11paGvpDg4Q2hbk+G+Ti9JoXKVk4G+lOE2lYT7
	 kHzTMWY7zrYeWHkzoPai+tnDDm8+8bnMCzV5RFXz8sPUxkhV7T/U7HDb82uGpogDKi
	 wpdRWIn3gfWiQ==
Date: Sat, 1 Nov 2025 08:05:26 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: odd objtool 'unreachable instruction' warning
Message-ID: <aQWxNvi7FOkHt-bV@gmail.com>
References: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> That is a local hack that just removes the alternative noise for the 
> common ops, so that I actually see the fences and clac/stac 
> instructions as such, instead of seeing them as nops in the object 
> file or as horrible noise in the assembler output.
> 
> So that patch is not something I'd ever commit in general, but it's
> really useful for checking code generation [...]

> Subject: [PATCH] Avoid alternative assembler noise for common ops
> 
> Just hardcode the ones I have for SMP and LFENCE
> ---
>  arch/x86/include/asm/alternative.h |  7 +------
>  arch/x86/include/asm/barrier.h     |  2 +-
>  arch/x86/include/asm/smap.h        | 18 ++++++------------
>  arch/x86/lib/getuser.S             |  2 +-
>  4 files changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 15bc07a5ebb3..281c823a869e 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -42,12 +42,7 @@
>   */
>  
>  #ifdef CONFIG_SMP
> -#define LOCK_PREFIX_HERE \
> -		".pushsection .smp_locks,\"a\"\n"	\
> -		".balign 4\n"				\
> -		".long 671f - .\n" /* offset */		\
> -		".popsection\n"				\
> -		"671:"
> +#define LOCK_PREFIX_HERE

>  
>  #define LOCK_PREFIX LOCK_PREFIX_HERE "\n\tlock "
>  
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index db70832232d4..2b911c88467b 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -45,7 +45,7 @@
>  	__mask; })
>  
>  /* Prevent speculative execution past this barrier. */
> -#define barrier_nospec() alternative("", "lfence", X86_FEATURE_LFENCE_RDTSC)
> +#define barrier_nospec() asm volatile("lfence":::"memory")

So we could actually integrate much of this and avoid all the 
alternatives noise by keying it off CONFIG_X86_NATIVE_CPU and passing 
in two new config flags whether /proc/cpuinfo in the build environment 
has X86_FEATURE_LFENCE_RDTSC and X86_FEATURE_SMAP ("smap").

CONFIG_X86_NATIVE_CPU is not supposed to boot/work on any other CPU 
than the host CPU, so CPU-variant runtime patchery is pointless there.

Put differently: we could make alternative() use build-provided CPU 
flags if CONFIG_X86_NATIVE_CPU=y - or at least introduce an 
alternative() variant that can be used in the simpler cases.

We could even avoid .smp_locks if the build environment is SMP, or even 
just hardcode the LOCK prefix on CONFIG_X86_NATIVE_CPU, there's no 
modern UP processor in existence that we support and care about, and 
patching out the prefix should be of dubious value anyway on anything 
supported. LOCK used to have horrible overhead on some ancient CPUs but 
that's it - it should be ignored on any x86 CPU built in the last 20 
years?

Ie. I think we could integrate 100% of the functionality of your 
disassembly readability hack-patch. :-)

Thanks,

	Ingo

