Return-Path: <linux-kernel+bounces-752094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C908B17125
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6B03A8CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FD52BEC28;
	Thu, 31 Jul 2025 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="UyHqSG5A"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FF2230BE0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964697; cv=none; b=AXYyK0DnVuh8aRZb0TeJDIPo6NL4vYswzvB5I6BQUU1/MctQ56eK5bpzWN1zjjm3rblT2rTVyrrJRNqTvgAa1OjUy1NYU5CVy+RllOj4U5G1Wfnp31u05qwdZS3Mws9hgp2RKCXemlWG+mhUH7mwMqOmodNS4MPdIqzdcWzKHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964697; c=relaxed/simple;
	bh=O9+rvyi6cbnp6f9QemdqrQmGz6n77kYfJk2t38UVfzk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=UVSbCbFbvqUs/c3+qAxtvqlYT2bf25iWBrakQD2Ng8JlWOaq0ZOlaY7tfSiCnchkA0huWhF7QHlyxDU5b5F3oWXTfUSC6OKVAj6LUzpq+v9wHPETIp/9SHSzQi55a5BmsKmp6u4HOt83E3PoPB7qPEnrMnwRpDy/+YBDnGHeoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=UyHqSG5A; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4589c1f55aeso1387505e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753964694; x=1754569494; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+AToT976oTprX37SYOE+qDsua+BzFJg9f1qT1iu+OI=;
        b=UyHqSG5AgNDCX2+BZUFy83RY4ZWUiFKeG/b+9qr/a7SMx/9Ro+8UubSDGTIDBHFcN7
         qKCbTB16IR1cRffGe025NhUgbaWsn9e0gi0A6GB03quQ3dgpk8vtGFLNkQr+HrUMgIAG
         Y2ht8YGY9UgVj9bRG+Ph9u1VzEnG0BOqpcBrIMM5g3z6C9ON72IFllHAZ/fyb86acu1a
         Fav5ZrR1k6PJH5z3QsUJ3dY6q+s0hA4o79CZqnF7EGEpMdtj55JArQBWqOG23pbil8tR
         NcTfE+8HvB9mK4xRb5RhP4E2EKlUcHUURUSJvDan/aY3xXRbzy8EaUCJZE0dziBeurcS
         Jgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964694; x=1754569494;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u+AToT976oTprX37SYOE+qDsua+BzFJg9f1qT1iu+OI=;
        b=tB6uLN2T9rJqXG22UnxM8VPXWsUbdaShGuheZolUuw8m5vCseY09hYBjTw3D4ZdpPf
         4GPbo+6tNX31UtZSG9aKDl3jy+KwyKOtE4aF8R4I7kbyyXPwUYZ9GEUSVQod3Q6tAsBY
         ZY0aWORDj5Dd9cRAdbAj6wNi39mt8w6Bylkqz7EtHFtdnOx+CfjqgA0s4NRLf63Abbir
         aXNMJi+A7tmxfh4K/3K27lxKeLVFcmAcnCBnF7Q1ANse/NrP28hFXI5UjnPxq+XLcjmi
         6xHLhOHhG9rruzMoqBEKjiPXyNUp6fVYFq3WBYk2jNmpygah1H40IWd/5nfgEH7fP+5d
         3BrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpxzMHfNnB4lMgkn/G2JXgLr0tpWzipdxIHbzzWFRBdVz5kBmDlR0SbocLVpPi5eito0k7AUcZM2IJwX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAxL4Cd4dMHAiGvU8bspI+gpeLR+hofdUMBT3v43BuOm2q/Y/k
	0MnxLTthJ7FT+Nq9LjO1oGkkapR4NvhNedO53dYzUzpj7Xd3AEr8YBIG/TIVXgHWmvQ=
X-Gm-Gg: ASbGnctJCagAIO+5ifJYXj2wMWKUCLIniRDHKa2w2Lwu+j7IsVirgCoCBGyOpebQrEm
	FCzmhnA3ncheQYxn2iQ/tCMiNmfAwTPZOu6T+i2BgoW8iJD6Aggcp183WowsvQbbGrmz/cvOEZT
	frR0NQt0aPPDMczKYTqOkkVGVnF09moa/UISBZciq8fnfcU9h0FvKe5YixmrsPchUibupfiKdJh
	G5sCxPdWUpIGKhu/FYiklmhs/byymAk9Wz362K7bmrVJocberwvRABUsWyDhlVZDAjKpUBh9YuY
	6qdfrUgen+FnUVFOQwg1+dQ9ta5yzHr7v58EOyRhNkU85+FTDiQP8wEAUpPNDgvzXTVlBsUvIGS
	Vojmd2Oux/P684iGL1LXQhuD4h8/oUB141WpZYrA=
X-Google-Smtp-Source: AGHT+IESAHQC+ykUTh0duIW3JXCCP+0NnteNk5su7zlOXc8d9NMsI25MdmaiB9Di0GvN0Hzl3QMVdQ==
X-Received: by 2002:a05:600c:1d98:b0:442:e608:12a6 with SMTP id 5b1f17b1804b1-45892be8c50mr29067995e9.1.1753964693730;
        Thu, 31 Jul 2025 05:24:53 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:d2c3:7f6:d08a:bcdf])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458a7dd8cdesm2279175e9.19.2025.07.31.05.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Jul 2025 14:24:52 +0200
Message-Id: <DBQ8LC4H0HVO.2DOI8X0CKOGM0@ventanamicro.com>
Subject: Re: [PATCH] riscv: Add sysctl to control discard of vstate during
 syscall
Cc: <fustini@kernel.org>, "Bjorn Topel" <bjorn@rivosinc.com>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Paul Walmsley" <paul.walmsley@sifive.com>,
 <samuel.holland@sifive.com>, <dfustini@tenstorrent.com>,
 <andybnac@gmail.com>, "Conor Dooley" <conor.dooley@microchip.com>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv-bounces@lists.infradead.org>
To: "Palmer Dabbelt" <palmer@dabbelt.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <DBHTIDY0HRM0.2B8L1WG7IBCXM@ventanamicro.com>
 <mhng-E49DDC7D-A330-4626-A122-4146AADDBB33@Palmers-Mini.rwc.dabbelt.com>
In-Reply-To: <mhng-E49DDC7D-A330-4626-A122-4146AADDBB33@Palmers-Mini.rwc.dabbelt.com>

2025-07-30T18:05:59-07:00, Palmer Dabbelt <palmer@dabbelt.com>:
> On Mon, 21 Jul 2025 07:54:25 PDT (-0700), rkrcmar@ventanamicro.com wrote:
>> 2025-07-21T14:35:38+02:00, Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanam=
icro.com>:
>>> Shouldn't the RISC-V Linux syscall ABI be defined somewhere?
>>
>> To clarify this point.  My issue is with the following part in
>> Documentation/arch/riscv/vector.rst:
>>
>>>>  As indicated by version 1.0 of the V extension [1], vector registers =
are
>>>>  clobbered by system calls.
>>>>  [...]
>>>>  1: https://github.com/riscv/riscv-v-spec/blob/master/calling-conventi=
on.adoc
>>
>> The ISA does not say that vector registers are clobbered by system
>> calls.  All the ISA says is:
>>
>>   "This Appendix is only a placeholder to help explain the conventions
>>    used in the code examples, and is not considered frozen or
>>    part of the ratification process.  The official RISC-V psABI document
>>    is being expanded to specify the vector calling conventions."
>
> It also says
>
>     Executing a system call causes all caller-saved vector registers=20
>     (v0-v31, vl, vtype) and vstart to become unspecied.
>
> in the ISA manual, a few sentences later in that page.

It also says

  Most OSes will choose to either leave these registers intact or reset
  them to their initial state to avoid leaking information across
  process boundaries.

Both options make sense, but we're not doing either.

>                                                         So that's what=20
> we were trying to get at with the documentation pointer, but maybe it's=
=20
> better to have something more explicit like
>
>     diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch=
/riscv/vector.rst
>     index 3987f5f76a9d..e8591660a7bb 100644
>     --- a/Documentation/arch/riscv/vector.rst
>     +++ b/Documentation/arch/riscv/vector.rst
>     @@ -134,7 +134,10 @@ processes in form of sysctl knob:
>      3.  Vector Register State Across System Calls
>      ---------------------------------------------
>    =20
>     -As indicated by version 1.0 of the V extension [1], vector registers=
 are
>     -clobbered by system calls.
>     +Linux adopts the syscall ABI proposed  by version 1.0 of the V exten=
sion [1],

The whole section is just a non-normative convention for its own code
examples, so I wouldn't say the V extension proposed it for anyone.

We can just say what Linux does without referencing anything, because
nothing tells Linux what to do.

>     +where vector registers are clobbered by system calls.  Specifically
>     +
>     +    Executing a system call causes all caller-saved vector registers
>     +    (v0-v31, vl, vtype) and vstart to become unspecied.

We still need to define which registers are caller-saved.

No vector registers are preserved in the current syscall ABI, so I'd
just omit "caller-saved", to define that all vector registers become
unspecified.

>      1: https://github.com/riscv/riscv-v-spec/blob/master/calling-convent=
ion.adoc
>
>> while the RISC-V psABI says:
>>
>>   "The calling convention for system calls does not fall within the
>>    scope of this document. Please refer to the documentation of the
>>    RISC-V execution environment interface (e.g OS kernel ABI, SBI)."
>>
>> We made a circular dependency, misinterpreted the ISA, and probably
>> implemented a suboptimal syscall ABI -- preserving vector registers
>> seems strictly better.
>
> We'd really need userspace to have an ABI that preserves vector=20
> registers for it to be useful in the kernel.

I don't really like over-catering to the standard psABI -- it's a relic
of simpler times, and I hope programs will eventually be freed of it.

>                                               As it stands there's=20
> pretty much nothing that's going to have useful vector state over a=20
> syscall, as they're almost always hidden behind some C function and=20
> those clobber the vector state.

Userspace doesn't even have to carry vector state over syscall -- just
using vector, doing syscall, using other vector, doing syscall is
hindered by the current design, because each syscall has to touch vector
registers for not good reason.

>                                  I have a patch out for GCC that enables=
=20
> a system-wide vector ABI, but I don't have time to test/benchmark it so=
=20
> it's kind of hard to justify.

You mean enabling the alternative psABI for vectors?

https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/712449f8efcf6b3ac=
d9e2a2a7ddfe89486317877/riscv-cc.adoc#calling-convention-variant

> That said:
>
> My first guess here would be that trashing the V register=20
> state is still faster on the machines that triggered this patch, it's=20
> just that the way we're trashing it is slow.  We're doing some wacky=20
> things in there (VILL, LMUL, clearing to -1), so it's not surprising=20
> that some implementations are slow on these routines.

I am afraid we might end up with a commmandline, DT, or
mvendorid+marchid+mimpid hint to pick the best method at runtime, or
boot time benchmarking in case it's not even known.

> This came up during the original patch and we decided to just go with=20
> this way (which is recommended by the ISA) until someone could=20
> demonstrate it's slow, so sounds like it's time to go revisit those. =20
>
> So I'd start with something like
>
>     diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm=
/vector.h
>     index b61786d43c20..1fba33e62d2b 100644
>     --- a/arch/riscv/include/asm/vector.h
>     +++ b/arch/riscv/include/asm/vector.h
>     @@ -287,7 +287,6 @@ static inline void __riscv_v_vstate_discard(void)
>                     "vmv.v.i        v8, -1\n\t"
>                     "vmv.v.i        v16, -1\n\t"
>                     "vmv.v.i        v24, -1\n\t"
>     -               "vsetvl         %0, x0, %1\n\t"
>                     ".option pop\n\t"
>                     : "=3D&r" (vl) : "r" (vtype_inval));
>
> to try and see if we're tripping over bad implementation behavior, in=20
> which case we can just hide this all in the kernel.  Then we can split=20
> out these performance issues from other things like lazy save/restore=20
> and a V-preserving uABI, as it stands this is all sort of getting mixed=
=20
> up.

Yeah, the discussion got a bit out of hand.

I don't see much point in doing minor changes to the current design, as
it isn't anywhere near the Pareto front.

If we want to touch vectors on syscalls, I think it makes sense to start
with Vivian's proposal -- eagerly initializing vectors in syscalls
provides at least some advantage when eventually doing a context switch.

(If the performance is still bad, then we can initialize lazily on vector
 restore, which should be optimal for everything except programs that
 want to preserve vectors across syscalls.)

>>> How come we could have broken it with 9657e9b7d253?
>>
>> We changed the ABI once, so maybe we can change it back?
>
> We didn't change the ABI, the documentation always said "vector registers=
 are
> clobbered by system calls".

My bad, I didn't see the patch went in with the initial version, thanks.

