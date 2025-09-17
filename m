Return-Path: <linux-kernel+bounces-820457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46925B806B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDEDB7A371B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61E522D78A;
	Wed, 17 Sep 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAJKxemu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262CE2DECBF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104185; cv=none; b=BMkjJDZbL7eID4xfRtVf/3HiXWpiREdCa1k0U7pzKXjsKzMHHu/oPvcf6a7UoahJME18c+ER3lyIqaEG8+zPIAQlVeYuLeGW9tkiiXvg7rD0h41UCt2OqRuvSYaeGCV1UdHcqMKk4ahBQa04GvIgBAsM9vUdHZQGdfZUCyTdj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104185; c=relaxed/simple;
	bh=FV3YzMUIlDQ/ACtsBX/BoY2m1QmvGjJL4Oc0FDB6s3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OneBXa4B8TcDig7Yj7bKg3K6iOn2B/9RdipPTsV3Wi+swEPnuLO7Vxf3rAvCwBmiQajMwrL3xJH228Z6Be/WmXVPILzD2jrMu1hQvaPABKA6fhvXcyzncFj0wuR6aj1tbcNjtrwfAJYuXM2jc4Oadin8I1E+DdA9e0DnSYlC8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAJKxemu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4751C4CEF5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104184;
	bh=FV3YzMUIlDQ/ACtsBX/BoY2m1QmvGjJL4Oc0FDB6s3s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qAJKxemuXRgXicrk1W+3iy0EJnFVWGgJahCkdUajSjNf4njSmp2Te3PgL0G4IWi4P
	 FBz+PGpTWodzQRatwr0uGVs5HtRv7m//sdCYnI6dqfraKPPfHgJQaLg4alUt7HYy90
	 TJFY7fCLZhyviIwTn+6vU6Fr3qM+YPcV+nnSIiUoH0Sw2ehjxtNhbJ3JDsap8AwO0A
	 qh9+D1tCevafuJZMY+dHXeb3Cc5E33DHcUAKyiA1/lv0+I0o/b1B6NtMyEgyFbCvQs
	 E0myy+YczTMMUSiPHjpAfHRsor6w6Nv/6dQlY/Tt8H9AkHDhMOmhaTVh/iATlbPkNS
	 CpUFJgitjOlsw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b07c2908f3eso779758666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:16:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUD6LPXNoroMoNRP6QhXwvz5pvm8sw4nXE47e/4kR0yu1DiQcBsYaBpAPcsj7AThXn6cjK2zyyWiJRuB7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1AInaRiAKobY0aTQlq0elTzqeI3HzZeMWWm8gPugJYF6yVdWH
	PEarjEqpKvOhtiOShzUTNORkn1luPEZm8d1waPC9xJVfAPw6SuDmZGFYfsQoMMWHmDaZ4hl6niG
	D13bjked3Pa2SANJOL0DT++CdDRhU5iM=
X-Google-Smtp-Source: AGHT+IF7fGodltx1kpWL49MQTNyLgMsqD3ylHseIhazBD0g2sV/4fO5FkmPSY5FjDMoIMwOryC81aFHSAQRH2m0s1cw=
X-Received: by 2002:a17:906:730d:b0:b04:725c:bcb with SMTP id
 a640c23a62f3a-b1bb60490a5mr191370566b.23.1758104183377; Wed, 17 Sep 2025
 03:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917011007.4540-1-yangtiezhu@loongson.cn> <20250917011007.4540-4-yangtiezhu@loongson.cn>
 <CAAhV-H6yKyqU+jQ=-RoOOc0fyRgjFfdorJAk1LashV0Gt=Y=AQ@mail.gmail.com> <bfd7035b-ca08-66d2-bdc5-d28743144128@loongson.cn>
In-Reply-To: <bfd7035b-ca08-66d2-bdc5-d28743144128@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 17 Sep 2025 18:16:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H738P94-XJQx=KMH5oGfp_eji_edvKr1HAgK3mnVjh3Mw@mail.gmail.com>
X-Gm-Features: AS18NWASloU-JqjqzSklb5PnbdxA4guCjeP15AlRq9Xd6SIGha8Htpxv0p0vK1U
Message-ID: <CAAhV-H738P94-XJQx=KMH5oGfp_eji_edvKr1HAgK3mnVjh3Mw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] objtool/LoongArch: Fix unreachable instruction
 warnings about entry points
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 5:47=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2025/9/17 =E4=B8=8B=E5=8D=883:07, Huacai Chen wrote:
> > Hi, Tiezhu,
> >
> > On Wed, Sep 17, 2025 at 9:10=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> >>
> >> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
> >> following objtool warnings:
> >>
> >>    vmlinux.o: warning: objtool: kernel_entry+0x0: unreachable instruct=
ion
> >>    vmlinux.o: warning: objtool: smpboot_entry+0x0: unreachable instruc=
tion
> >>
> >> kernel_entry() and smpboot_entry() are in arch/loongarch/kernel/head.S=
,
> >> there is "OBJECT_FILES_NON_STANDARD_head.o :=3D y" to skip objtool che=
cking
> >> for head.o, but the STACK_FRAME_NON_STANDARD macro does not work for l=
ink
> >> time validation of vmlinux.o according to objtool documentation, just =
give
> >> a proper unwind hint to fix the warnings.
> >>
> >> By the way, ASM_BUG() can be removed due to unnecessary, otherwise the=
re
> >> are following warnings:
> >>
> >>    kernel_entry+0xf4: start_kernel() missing __noreturn
> >>    in .c/.h or NORETURN() in noreturns.h
> >>
> >>    smpboot_entry+0x68: start_secondary() missing __noreturn
> >>    in .c/.h or NORETURN() in noreturns.h
> >>
> >> This is because the previous instructions of kernel_entry+0xf4 and
> >> smpboot_entry+0x68 are the 'bl' instructions, start_kernel() and
> >> start_secondary() are the respective call destination symbols which
> >> are noreturn functions, then the 'bl' instructions are already marked
> >> as dead end in annotate_call_site().
> >>
> >> For now, it is time to remove "OBJECT_FILES_NON_STANDARD_head.o :=3D y=
"
> >> in arch/loongarch/kernel/Makefile.
>
> ...
>
> >> -OBJECT_FILES_NON_STANDARD_head.o :=3D y
> > This line should be kept, othewise we get:
> >
> > arch/loongarch/kernel/head.o: warning: objtool: kernel_entry+0xf4:
> > start_kernel() missing __noreturn in .c/.h or NORETURN() in
> > noreturns.h
> >
> > even without LTO. This is a regression, we can only remove it after
> > the above warning be fixed.
>
> As said in the commit message, ASM_BUG() needs to be removed
> to fix the above warning.
>
> I tested again with GCC and LLVM (with and without LTO),
> there is no the warning what you said, please double check.
I'm sorry, I was confused by the similar warnings described in this
patch and the cover letter.

Huacai

>
> (1) GCC
> make ARCH=3Dloongarch defconfig
> make ARCH=3Dloongarch -j8
>
> (2) LLVM without LTO
> make ARCH=3Dloongarch LLVM=3D1 clean defconfig
> make ARCH=3Dloongarch LLVM=3D1 olddefconfig all -j8
>
> (3) LLVM with LTO
> make ARCH=3Dloongarch LLVM=3D1 clean defconfig
> scripts/config -d LTO_NONE -e LTO_CLANG_THIN
> make ARCH=3Dloongarch LLVM=3D1 olddefconfig all -j8
>
> Thanks,
> Tiezhu
>

