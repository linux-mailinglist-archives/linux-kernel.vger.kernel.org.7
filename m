Return-Path: <linux-kernel+bounces-786226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2D7B356C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34E37B2242
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFE52F90DC;
	Tue, 26 Aug 2025 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/ddcbLZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B3C2AE8D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196790; cv=none; b=OsM3/RAO1I7nNYUs33ksUxB7a/DRYflSP12ouYcRjxfXH5f859fpmkcVl4RWiABvHsVei8O7HHKlTWzYAWi+HeWg1ImHoBiQ7PFRF+OGX7DTHGgLdme/pVdwjelchhJuFTxSSfcthaLN/maMurpaIcmlIVyyIEOBKlmlTWGdOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196790; c=relaxed/simple;
	bh=BYIUsxzd64whGoRFXCzZ5dt78UhHZqqx/gVeEyPFu/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8Jw8D1ltwBobZAWRyQC0C6N5IvfjPep3eXAFGngTtjg3avR0z31HsVFXXj80F4HKXljMtInK9NW6X77DSIhzLtBXOMSBvXEAfCc8VBIJTIDe0JeNg1dLS5GCXTIdbkRJNqaOpVeUJGozwtF6uh25ZyjrDmWdRie8qcY4efp5Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/ddcbLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C774C4AF09
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756196790;
	bh=BYIUsxzd64whGoRFXCzZ5dt78UhHZqqx/gVeEyPFu/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e/ddcbLZiZlUV0NABVz3YLWSkwOecxQKG7WYnE66OpYNwHMZc3iFbefp+tB5UCDh5
	 1JSJiapQ+9XjAoPnUsRKVU9+yNI1kE+EWj457C+NovpDSKg66Thf2bIsNMZo2W5zYb
	 PhCc0Q1x4hxuS1gqIQ9DoHP6Pc0PQZzvv4jQ2J+zj80yTYFJEAYdkUS1Mz0yCDDNbM
	 eqpKHa2BNEfgko7KU42Ju66e32k+/fY64T2wrKtxEnRKmfOWsdOhCFQeaVGOP4d4Za
	 FHE9886RAXu5xwmCEfJ5CcWBVpt2TBeNZV311WiAULAU2s+8mnpvC7tIXNsvJGHvZ8
	 D4mFSFH2VOjvw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6188b5ae1e8so6250072a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 01:26:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvfXjtzMijiS0oUexfCWujgr5rkvya1SsLxThgaRiE33g04M0X6OvSzNC8hXEITOyn+n0gLub/9NQ4cZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwQNb4nQGoQe2BG7qcN6eUlhK7XfQdfFfFAASIRhXwKQnyTOl
	j8hJ7J46j5aosffTyGvae+fRtzOvu+Rgor62DYuU8Jsy1Pfo0nEknIPsV/9pZocv+j1fEbZN5Om
	bXs7hwzxpwY2LsKBjqT3lPsHmSz/HVXY=
X-Google-Smtp-Source: AGHT+IHky69aX1ytUrLeQjn70EkrzDwZTD8b04aKCI8SFIJf+StPfPdbQhhPSQt4nuP8VZogBWb0V2oxn3aLFInNQSU=
X-Received: by 2002:a05:6402:1d4b:b0:618:1250:ac5e with SMTP id
 4fb4d7f45d1cf-61c1b6f982amr12612104a12.19.1756196788881; Tue, 26 Aug 2025
 01:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826064631.9617-1-yangtiezhu@loongson.cn> <20250826064631.9617-3-yangtiezhu@loongson.cn>
In-Reply-To: <20250826064631.9617-3-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 26 Aug 2025 16:26:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7NNtH-oaqMsN5=2c+EdF0-dy5mxcsO=_KFGWqb-FZj_w@mail.gmail.com>
X-Gm-Features: Ac12FXylOWw-1eZbOdRMzAZ9EGR9AE5_FdM-moItNtL0zuTlZhTq0kNopY_6c_4
Message-ID: <CAAhV-H7NNtH-oaqMsN5=2c+EdF0-dy5mxcsO=_KFGWqb-FZj_w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] objtool/LoongArch: Fix unreachable instruction
 warnings about head.S
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 2:46=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
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
> and there is "OBJECT_FILES_NON_STANDARD_head.o :=3D y" in Makefile
> to skip objtool checking for head.o, but OBJECT_FILES_NON_STANDARD
> does not work for link time validation of vmlinux.o according to
> tools/objtool/Documentation/objtool.txt.
>
> Just give a proper unwind hint to silence the above warnings. By the way,
> the previous instructions of kernel_entry+0xf4 and smpboot_entry+0x68 are
> the 'bl' instructions, the call destination symbols are start_kernel() an=
d
> start_secondary() which are noreturn functions, then the 'bl' instruction=
s
> are marked as dead end in annotate_call_site(), so actually ASM_BUG() can
> be removed due to unnecessary, otherwise there are following warnings:
>
>   kernel_entry+0xf4: start_kernel() missing __noreturn
>   in .c/.h or NORETURN() in noreturns.h
>
>   smpboot_entry+0x68: start_secondary() missing __noreturn
>   in .c/.h or NORETURN() in noreturns.h
>
> Link: https://lore.kernel.org/lkml/20250814083651.GR4067720@noisy.program=
ming.kicks-ass.net/
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/kernel/head.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index e3865e92a917..566a1dbf5fa0 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -20,6 +20,7 @@
>         __HEAD
>
>  _head:
> +       UNWIND_HINT_UNDEFINED
>         .word   IMAGE_DOS_SIGNATURE     /* "MZ", MS-DOS header */
>         .org    0x8
>         .dword  _kernel_entry           /* Kernel entry point (physical a=
ddress) */
> @@ -30,6 +31,7 @@ _head:
>         .long   pe_header - _head       /* Offset to the PE header */
>
>  pe_header:
> +       UNWIND_HINT_UNDEFINED
>         __EFI_PE_HEADER
The efi header is completely not code, the annotations are very strange.

Huacai

>
>  SYM_DATA(kernel_asize, .long _kernel_asize);
> @@ -42,6 +44,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
>         .align 12
>
>  SYM_CODE_START(kernel_entry)                   # kernel entry point
> +       UNWIND_HINT_UNDEFINED
>
>         /* Config direct window and set PG */
>         SETUP_DMWINS    t0
> @@ -109,8 +112,6 @@ SYM_CODE_START(kernel_entry)                        #=
 kernel entry point
>  #endif
>
>         bl              start_kernel
> -       ASM_BUG()
> -
>  SYM_CODE_END(kernel_entry)
>
>  #ifdef CONFIG_SMP
> @@ -120,6 +121,7 @@ SYM_CODE_END(kernel_entry)
>   * function after setting up the stack and tp registers.
>   */
>  SYM_CODE_START(smpboot_entry)
> +       UNWIND_HINT_UNDEFINED
>
>         SETUP_DMWINS    t0
>         JUMP_VIRT_ADDR  t0, t1
> @@ -142,8 +144,6 @@ SYM_CODE_START(smpboot_entry)
>         ld.d            tp, t0, CPU_BOOT_TINFO
>
>         bl              start_secondary
> -       ASM_BUG()
> -
>  SYM_CODE_END(smpboot_entry)
>
>  #endif /* CONFIG_SMP */
> --
> 2.42.0
>

