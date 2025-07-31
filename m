Return-Path: <linux-kernel+bounces-751462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2601EB169D4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6491218C7476
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503C42E40E;
	Thu, 31 Jul 2025 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="bbUSthJZ"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBA8EAFA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753923967; cv=none; b=FxEr3CcQ2U3YjWD6DtW5dhMgWIAnr9V7oJGkxM51C9XH1KuvBMDxLe5pnusGHyAYrNBTAh4+H4vN3/pKDpFHdfUag52tJZXqXFDyJlE28V511e9U2vzBiSOWUiPi55Qxb9QWxb1c1i8qGC0ZpZ/I9/TRXe8ag8pRQsV1KBbiwRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753923967; c=relaxed/simple;
	bh=voUiPDD/VJwMqvklKyTXYB8JnNBbeLP5CuSUMC7uYPI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=YdJkiAm/eTzpBH5lzUOGJcJUB3jGFM1gZq9mWyEMpEcZO6dmYn9HT8YRkHlJzVHk3rRvFghdypdqTHO8McCXt1be+HfFSxz6uw79f/JbJvpbYDHCJSu9WHiD1XHZm89YHAZ2oTE72mBUNn/BRIVo/2gvkrMjkgzjsSBsoX+vwos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=bbUSthJZ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31ee880f7d2so456912a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1753923961; x=1754528761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdyh6VXwkAfvxERUzBdY6UfC1oO6pBpGRvc13yyypPY=;
        b=bbUSthJZ8YktetGm3exhbIN8zE14HHS6SWUOz69eHli7fbTnNS/dpnqE69kZ7auv3A
         FtwN1RhyyQCWU3dcl8uw+FyOc+mGSJYtw05xv++8XS45m5Cj0Zg8LK/varsf9mLXpe2v
         HfAwBMfDkv3PNRwczL1FuxeON/UrI39SI9XKRoNPwMzXWwMDYNp4Y36EWEjijyTn/5BX
         ctWPnD47SnMINuXZ2HZYUnZI6byERxIirerCZpM9lR+E/1duJTf8nb0fjSDwaTFyopLl
         CTn8FOFtfWNxeptsmTZJXEEli7RGhkyHPsOdr2lgUx53NGxPfE/o/lenqZmlI/NX11pa
         fz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753923961; x=1754528761;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdyh6VXwkAfvxERUzBdY6UfC1oO6pBpGRvc13yyypPY=;
        b=X7Di7BsZQxtGnuT8fgrhBvVJwUXL+ydyEMdnlS+HklJShvQxXgZBKOudGNV7g2U6XS
         0MonMxjP90XuRYmcH2A5YRiQvYx2sbSM/k3gY4s/6If8WCnQtUJQ1CcJLcTz1rcUvFh8
         MPnV0zQrBcZgby7l9b4A0tzsGJc9N1EUZsgAnla50Z1HyRdgFRZ/199XV0OtGNiT1aVa
         dDsVJKUQFXOFGxBTdEweJzZaTKC5a2e8kIvuSvL3meLiZHq96iykzwGC468rysdar2X+
         rAMJyndTTO213MSI1cV9z6B7UBEzszWTCzBESbVIZXVJrqkELYETD6XxHPkj5INxhEfn
         ApSg==
X-Forwarded-Encrypted: i=1; AJvYcCXkYlihPAiQflV/DbCP3SX+5aVooRpwOJWz9iiSPpot8qDkuyfgs5Pic/ohC/BTF/LdRko8Si/Ahc0E4rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW2mGLDrZAQgmzlSKVMu9r+V4TItxdSkk4Mv8rrbSV/Uhv7GwD
	qHRiGig1DOvgt0XTACvez0XyoaBM4dp/v+FKOFdYFjFcfYqyZQAFyDzrw5b/kKr5CZs=
X-Gm-Gg: ASbGncsBcR3QCmVF+J9OxByJ5rKa7HMEgJ8CHh3hPUEwsnATZv2z2JvjWvjP58P/uwF
	X8/I8wDb4XAiHVeEa8HXC+H8bvL3A7y/uFXxl0TgGL0O5zujTokLimMNBYczPij8O33ppgYCWlM
	JJFHoPu7A+KCvgQRL3VrWZ3hN+cAZF7x4WtxYgsIKsUARhT2U37TzPXWoNi1l3B5FDpr3VIQbl8
	/iJhkiW9j12+d7jVAf1SkUzP0MtTLShZmM2F9Tlwv8sF19enSYXEclCsHpKsGF6GsquzrKKXDX9
	RLHH6NmDrSaO9YRvsRCkV0v24LHKpJnWjkEtVv0C8nLRy6B2g641KoireCKtX+aL88WISzGYRYF
	Gr0nPbK4uhLgZzLzWOa+otp8/bFgbeCF6QLoyxlUqJiw74w==
X-Google-Smtp-Source: AGHT+IFb66tbhTzdTWT9ySJpwp5cY+LGlbPQQrJtDC5ft56L8OAOgN+oAeGIQ0FHVWx/yxVsrp5u7w==
X-Received: by 2002:a17:90b:388a:b0:313:fb08:4261 with SMTP id 98e67ed59e1d1-31f5de7b6c6mr6417950a91.32.1753923960683;
        Wed, 30 Jul 2025 18:06:00 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31f63f0cb39sm3076891a91.30.2025.07.30.18.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 18:05:59 -0700 (PDT)
Date: Wed, 30 Jul 2025 18:05:59 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Jul 2025 18:02:07 PDT (-0700)
Subject:     Re: [PATCH] riscv: Add sysctl to control discard of vstate during syscall
In-Reply-To: <DBHTIDY0HRM0.2B8L1WG7IBCXM@ventanamicro.com>
CC: fustini@kernel.org, Bjorn Topel <bjorn@rivosinc.com>,
  Alexandre Ghiti <alex@ghiti.fr>, Paul Walmsley <paul.walmsley@sifive.com>, samuel.holland@sifive.com,
  dfustini@tenstorrent.com, andybnac@gmail.com, Conor Dooley <conor.dooley@microchip.com>,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv-bounces@lists.infradead.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: rkrcmar@ventanamicro.com
Message-ID: <mhng-E49DDC7D-A330-4626-A122-4146AADDBB33@Palmers-Mini.rwc.dabbelt.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 21 Jul 2025 07:54:25 PDT (-0700), rkrcmar@ventanamicro.com wrote:
> 2025-07-21T14:35:38+02:00, Radim Krčmář <rkrcmar@ventanamicro.com>:
>> Shouldn't the RISC-V Linux syscall ABI be defined somewhere?
>
> To clarify this point.  My issue is with the following part in
> Documentation/arch/riscv/vector.rst:
>
>>>  As indicated by version 1.0 of the V extension [1], vector registers are
>>>  clobbered by system calls.
>>>  [...]
>>>  1: https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.adoc
>
> The ISA does not say that vector registers are clobbered by system
> calls.  All the ISA says is:
>
>   "This Appendix is only a placeholder to help explain the conventions
>    used in the code examples, and is not considered frozen or
>    part of the ratification process.  The official RISC-V psABI document
>    is being expanded to specify the vector calling conventions."

It also says

    Executing a system call causes all caller-saved vector registers 
    (v0-v31, vl, vtype) and vstart to become unspecied.

in the ISA manual, a few sentences later in that page.  So that's what 
we were trying to get at with the documentation pointer, but maybe it's 
better to have something more explicit like

    diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
    index 3987f5f76a9d..e8591660a7bb 100644
    --- a/Documentation/arch/riscv/vector.rst
    +++ b/Documentation/arch/riscv/vector.rst
    @@ -134,7 +134,10 @@ processes in form of sysctl knob:
     3.  Vector Register State Across System Calls
     ---------------------------------------------
    
    -As indicated by version 1.0 of the V extension [1], vector registers are
    -clobbered by system calls.
    +Linux adopts the syscall ABI proposed  by version 1.0 of the V extension [1],
    +where vector registers are clobbered by system calls.  Specifically
    +
    +    Executing a system call causes all caller-saved vector registers
    +    (v0-v31, vl, vtype) and vstart to become unspecied.
    
     1: https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.adoc

> while the RISC-V psABI says:
>
>   "The calling convention for system calls does not fall within the
>    scope of this document. Please refer to the documentation of the
>    RISC-V execution environment interface (e.g OS kernel ABI, SBI)."
>
> We made a circular dependency, misinterpreted the ISA, and probably
> implemented a suboptimal syscall ABI -- preserving vector registers
> seems strictly better.

We'd really need userspace to have an ABI that preserves vector 
registers for it to be useful in the kernel.  As it stands there's 
pretty much nothing that's going to have useful vector state over a 
syscall, as they're almost always hidden behind some C function and 
those clobber the vector state.  I have a patch out for GCC that enables 
a system-wide vector ABI, but I don't have time to test/benchmark it so 
it's kind of hard to justify.

That said:

My first guess here would be that trashing the V register 
state is still faster on the machines that triggered this patch, it's 
just that the way we're trashing it is slow.  We're doing some wacky 
things in there (VILL, LMUL, clearing to -1), so it's not surprising 
that some implementations are slow on these routines.

This came up during the original patch and we decided to just go with 
this way (which is recommended by the ISA) until someone could 
demonstrate it's slow, so sounds like it's time to go revisit those.  

So I'd start with something like

    diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
    index b61786d43c20..1fba33e62d2b 100644
    --- a/arch/riscv/include/asm/vector.h
    +++ b/arch/riscv/include/asm/vector.h
    @@ -287,7 +287,6 @@ static inline void __riscv_v_vstate_discard(void)
                    "vmv.v.i        v8, -1\n\t"
                    "vmv.v.i        v16, -1\n\t"
                    "vmv.v.i        v24, -1\n\t"
    -               "vsetvl         %0, x0, %1\n\t"
                    ".option pop\n\t"
                    : "=&r" (vl) : "r" (vtype_inval));

to try and see if we're tripping over bad implementation behavior, in 
which case we can just hide this all in the kernel.  Then we can split 
out these performance issues from other things like lazy save/restore 
and a V-preserving uABI, as it stands this is all sort of getting mixed 
up.

>> How come we could have broken it with 9657e9b7d253?
>
> We changed the ABI once, so maybe we can change it back?

We didn't change the ABI, the documentation always said "vector registers are
clobbered by system calls".

