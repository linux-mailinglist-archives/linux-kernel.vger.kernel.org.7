Return-Path: <linux-kernel+bounces-820104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95671B7C417
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C66324492
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03972248861;
	Wed, 17 Sep 2025 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRZLLWPD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D56927CB35
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092851; cv=none; b=U4jmT1kRM1epx/42SGVAdQxCIULuwRmJZbWfOP94k+UJpUCBy9phpoMXfLBt8V2r69+ejlqMxMBdAntZdY0aJBSvgz70TnjnjmYZk9opOMQwBqcaFty57hrFv2gvDEDCzUVpGe4l1x2XJWNiRMh0ttBn9NKJOrkdscEbvE/YLXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092851; c=relaxed/simple;
	bh=OaRce51hMgVbE7SHXOBadRr7blVfjSSfr4N61mMeGH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPrqayjwVj5j4+BD9AWppn+ug74f0dAuiSBSEhT0O4NOm/q5BmWgXoOxTH93ZacNHh9bnh7O17vb9DQK49vJ8B0GUt6cRUmIV1Zfj+hh+1ubRNdsdB2mYY+ECOcBcgUJt1VagdVpiw23FqrvgEB/PyOSnz/z+fwvk2TeyA/bAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRZLLWPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED870C4CEF9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758092851;
	bh=OaRce51hMgVbE7SHXOBadRr7blVfjSSfr4N61mMeGH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uRZLLWPD0ApicP1dUNTh+eH97ahMBvlKcs/0TkMdhW0bL99qeJ556XwqbSDglASAR
	 pZM1SzOKMVf19gmfieZIh4bPsfE1itXaXdP2Es4nA25bEo/UGst8WkL1AYw9qez05b
	 o4G8ShWjAt0f3g/wxwhynogRK77tf6v+rHTFqZecd6remP4RWorvdXRepdOAjF7O6l
	 BJmJmPFLu/FF80yMbrSAh7x1LcVZoTiGxVibCqo/cbSoQubLFKDpNag9LSBzfHVsD5
	 DgS8GmAj3i3as+etlRoseiaI5oPomvCFJj7LzfGo6OqqxFoAJfUdz16lvXeNxQu5qa
	 Z3bKDQN5GuwsQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ae31caso1131487166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:07:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhMJ/0ct//8xvlSmGDH5bvlA/2kRDUzmFtV+UEi6UcRRsW7Sq2f29rqAi51XwQO8N6oHgFbnbqq576RNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2JLJ0Zc7woWFghRCUFBghgDRtvhGuh2/CWwFQmWpZpvv4tpy
	SsbPpKA6r5oj5cRpwHi8JQg/6rbh3s8e83gwoRpOYgm6CysQJfXZIujsMRbt4iiAY7fhJPU9Ruk
	oNNk8ZQPgBfplrRNoLFLsGER7Fx2Q5d8=
X-Google-Smtp-Source: AGHT+IHnWDsDAUsjhNqyZZZp/XBcsXnqgvg07HKOKV9eRxOWA7vHoJaEBhv12d3En2EYSoJh/CDl5oSnYc4C9a/rZBY=
X-Received: by 2002:a17:907:7fa7:b0:b04:4b0d:8e82 with SMTP id
 a640c23a62f3a-b1bb86d273fmr139668666b.50.1758092849526; Wed, 17 Sep 2025
 00:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917011007.4540-1-yangtiezhu@loongson.cn> <20250917011007.4540-4-yangtiezhu@loongson.cn>
In-Reply-To: <20250917011007.4540-4-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 17 Sep 2025 15:07:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6yKyqU+jQ=-RoOOc0fyRgjFfdorJAk1LashV0Gt=Y=AQ@mail.gmail.com>
X-Gm-Features: AS18NWDcFCYSyFl7KmJfFK-YsCl3-DOT73b5BYQ547WLX_PqpnPbI0ZcEI1ZxM0
Message-ID: <CAAhV-H6yKyqU+jQ=-RoOOc0fyRgjFfdorJAk1LashV0Gt=Y=AQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] objtool/LoongArch: Fix unreachable instruction
 warnings about entry points
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

On Wed, Sep 17, 2025 at 9:10=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
> following objtool warnings:
>
>   vmlinux.o: warning: objtool: kernel_entry+0x0: unreachable instruction
>   vmlinux.o: warning: objtool: smpboot_entry+0x0: unreachable instruction
>
> kernel_entry() and smpboot_entry() are in arch/loongarch/kernel/head.S,
> there is "OBJECT_FILES_NON_STANDARD_head.o :=3D y" to skip objtool checki=
ng
> for head.o, but the STACK_FRAME_NON_STANDARD macro does not work for link
> time validation of vmlinux.o according to objtool documentation, just giv=
e
> a proper unwind hint to fix the warnings.
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
> For now, it is time to remove "OBJECT_FILES_NON_STANDARD_head.o :=3D y"
> in arch/loongarch/kernel/Makefile.
>
> Link: https://lore.kernel.org/lkml/20250814083651.GR4067720@noisy.program=
ming.kicks-ass.net/
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/kernel/Makefile | 2 --
>  arch/loongarch/kernel/head.S   | 6 ++----
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makef=
ile
> index 6f5a4574a911..4302c5b0a201 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -3,8 +3,6 @@
>  # Makefile for the Linux/LoongArch kernel.
>  #
>
> -OBJECT_FILES_NON_STANDARD_head.o :=3D y
This line should be kept, othewise we get:

arch/loongarch/kernel/head.o: warning: objtool: kernel_entry+0xf4:
start_kernel() missing __noreturn in .c/.h or NORETURN() in
noreturns.h

even without LTO. This is a regression, we can only remove it after
the above warning be fixed.

Huacai
> -
>  always-$(KBUILD_BUILTIN)       :=3D vmlinux.lds
>
>  obj-y          +=3D head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o=
 genex.o \
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index 6ce999586757..c62dab32a06b 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -43,6 +43,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
>         .align 12
>
>  SYM_CODE_START(kernel_entry)                   # kernel entry point
> +       UNWIND_HINT_END_OF_STACK
>
>         /* Config direct window and set PG */
>         SETUP_DMWINS    t0
> @@ -110,8 +111,6 @@ SYM_CODE_START(kernel_entry)                        #=
 kernel entry point
>  #endif
>
>         bl              start_kernel
> -       ASM_BUG()
> -
>  SYM_CODE_END(kernel_entry)
>
>  #ifdef CONFIG_SMP
> @@ -121,6 +120,7 @@ SYM_CODE_END(kernel_entry)
>   * function after setting up the stack and tp registers.
>   */
>  SYM_CODE_START(smpboot_entry)
> +       UNWIND_HINT_END_OF_STACK
>
>         SETUP_DMWINS    t0
>         JUMP_VIRT_ADDR  t0, t1
> @@ -143,8 +143,6 @@ SYM_CODE_START(smpboot_entry)
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

