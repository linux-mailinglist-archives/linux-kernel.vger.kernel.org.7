Return-Path: <linux-kernel+bounces-738737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD48B0BC79
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A58172351
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A926E704;
	Mon, 21 Jul 2025 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSmQw1Mq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606A2AD04
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079132; cv=none; b=jMD4qGasV8u+ScQtM/M8cM1K5qRTIxCOf70qircv36LYRAhD/6on0eJsoXdGZaOBqwrnj9GHgfkmdGJpwlQUw72L3hFMwEZM1mMfArQqImGxa3bKN10WhYopLdEqpV+k3gszj/GJEcb6nuxw3MY+7u/HF6nmJvmVAztzGxkV0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079132; c=relaxed/simple;
	bh=tm+z5zYFGDPQ045JrDJHPihATn7ewf+t8zrgvckluIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zr37vUZh051TMn1JvarN/aKneR7MBmyRbbVoF26pT4Z9cPLMjEvzuq4cpGttva40L5d36Axhu7l/iTEGI4DYHd3nul3IhwPgJQOb93ba/RK+3ZyfbCL2/RHVJXigmu3b/AsoXCAu6EI8PcdE5dbv2QvnVaUwvChUQE2tAsSSFhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSmQw1Mq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFBFC4CEF4
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753079131;
	bh=tm+z5zYFGDPQ045JrDJHPihATn7ewf+t8zrgvckluIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kSmQw1MqFG/1L1TZbmfoJ6l0Llf+smu/saW4jiMCldtQTFLyMc9fophG1S6tkYasT
	 UzQgK5POIpzcrgeQg2QF0rXktceiMpbhC/eNg5wtRlOOp/yxEL86UlfTHJNNUeu3yB
	 ZssH1CrcF4YvUBd5mGcucTwo/vXefdZQzhrsMycrvzA6m7bZ35kmLNxReAt3V6+k63
	 DSoeUrAQEGq45b4GKOSRkDy7Ko+I2cAg3ddOrGZOMaGFPIwpPyxs5eh6dVIwylLirS
	 sbGmN4gFrASKZicAehOhvrhLfeEf2sUVwb5vbDhzzTgTr0+de2D2vLZDmJE4mH3vj8
	 Mx+LAy8ykTY+g==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553d771435fso3950210e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 23:25:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnOuy3PkiUAd0kiECZRu4PqCfRwzTmpmMKseWURYy7SZ1JMKAuwZOitD3+Cua9KKXz0Yzqwt/zgPCi7Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5tTk8LjIreRSl2TVp+ygMwIzVXo8uVYkOjppBxnsY358jQooK
	rN2lGuswNZYsqAAShRj04G5U7TRI/Ri0AFrRQmTyT1RnYLXVmqfRWk7zCpZjwujK/7xVEsgGy6P
	0lvnCkiseA8If9UGbzWr2HQrusQSm95k=
X-Google-Smtp-Source: AGHT+IHoDRKEGUTkwRYhWxKCTLuXN1Vvsy5KUzTuy/Pa+GN7i1sat0KTejiwC+U7oYAMbOAcssLVAGsGVCQSs7lIvsM=
X-Received: by 2002:a05:6512:618:20b0:553:23f9:bb37 with SMTP id
 2adb3069b0e04-55a233b2fbemr3894938e87.40.1753079129778; Sun, 20 Jul 2025
 23:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175301303546.263023.1426155806374119244.tglx@xen13>
 <175301303889.263023.7762556142250207604.tglx@xen13> <CAHk-=wha6sXik-f0RC91TMbt4snau0jK+dPvQEMezGiVFDpKUQ@mail.gmail.com>
 <8734aqulch.ffs@tglx>
In-Reply-To: <8734aqulch.ffs@tglx>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 21 Jul 2025 16:25:12 +1000
X-Gmail-Original-Message-ID: <CAMj1kXFsC0yFm7nzpYFauAaKG2OEV4PNgCN8ThpxV3WGjcqj5w@mail.gmail.com>
X-Gm-Features: Ac12FXzv1CPYJxzHNA_deFA0JMwaApctOS_lcz4kDpLSXCN5hNkjlb_g52Nhpd4
Message-ID: <CAMj1kXFsC0yFm7nzpYFauAaKG2OEV4PNgCN8ThpxV3WGjcqj5w@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v6.16-rc7
To: tglx <tglx@linutronix.de>, Marco Elver <elver@google.com>, Daniel Axtens <dja@axtens.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

(cc Marco, Daniel)

Hi Thomas,

Thanks for getting to the bottom of this.

On Mon, 21 Jul 2025 at 16:08, tglx <tglx@linutronix.de> wrote:
>
> On Sun, Jul 20 2025 at 11:35, Linus Torvalds wrote:
> > On Sun, 20 Jul 2025 at 05:05, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> A single fix for a GCC wreckage, which emits a KCSAN instrumentation call
> >> in __sev_es_nmi_complete() despite the function being annotated with
> >> 'noinstr'. As all functions in that source file are noinstr, exclude the
> >> whole file from KCSAN in the Makefile to cure it.
> >
> > Hmm. I'm not entirely sure if this counts as a gcc bug.
> >
> > In particular, look at the *declaration* of __sev_es_nmi_complete() in
> > <asm/sev.h>, and note the complete lack of 'noinstr':
> >
> >     extern void __sev_es_nmi_complete(void);
> >
> > and I wonder if it might be the case that gcc might pick up the lack
> > of 'noinstr' from the declaration, even if it's there in the
> > definition..
> >
> > The fix for this obviously ends up working and is fine regardless, but
> > it's _possible_ that this is self-inflicted pain rather than an
> > outright compiler bug.
>
> I agree. See below.
>
> > Because having a declaration and a definition that doesn't match
> > sounds like a bad idea in the first place.
>
> I disagree here. When the compiler evaluates the function body it must
> have evaluated noinstr on the definition, no?
>
> Unfortunately the data provided in the change log does not tell what was
> actually instrumented inside of that function. I just reproduced it
> locally.
>
...
> __set_bit() resolves to:
>
> static __always_inline void ___set_bit(unsigned long nr, volatile unsigned long *addr)
> {
>         instrument_write(addr + BIT_WORD(nr), sizeof(long));
>         arch___set_bit(nr, addr);
> }
>

So this is the issue right here: an __always_inline function that
unconditionally calls the KASAN/KCSAN check functions. And indeed, the
compiler is not to blame here, because these instrumentations were
emitted by our code, and in a manner that doesn't care about the
compiler attributes that disable KASAN or KCSAN.

The upshot of this is that all noinstr users of __set_bit() end up
calling the instrumented version if the kconfig happens to have KASAN
or KCSAN enabled, and I seriously doubt that this is what we want.
Including one header or the other obviously doesn't work when
disabling these instrumentations at the function level.

Ideally, we'd have __builtin_kasan_enabled() and
__builtin_kcsan_enabled() compiler builtins that provide the correct
answer for the current function, but that will take a while to land if
we start working on it now (for both Clang and GCC).

