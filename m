Return-Path: <linux-kernel+bounces-875268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 723FBC188FA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785371A611F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D8B30DED0;
	Wed, 29 Oct 2025 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCp2YCa7"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099ED30DD2A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761720899; cv=none; b=crepSyUbH/9KBotwgEaGA3JqB2ZAGzWPjN0wZBQzsS2WGntK2gdls+oHeH/KLiia0hhbCQ2QboVP5xGQxNtQSDUH26/L3kreSKWxkSlv8sB1MdJclB1f6BjtmBWvsWOXrNjFtxSA3Xzz8Kd2i5ziQwnfZn3MBVy8sHY8X1Y+eCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761720899; c=relaxed/simple;
	bh=mjpc/1Mb/IM7XeheZ62GlSURIARWOe3fzOgbpnv/XVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUH1kAUn4nlYInr61PJ9f0PkJpHEHrapYDN58FVgUVo3esWsrbc2bpeNUG8k+NN6/SU2X8ijbKCzCvidT8Sp0mHdaS7LiCCB6dsZCFswvis+37rhiCSHc5MFFlK2drGuhF6YyUJSXs0Xm1KcgOOYY+DVtZnAA8MsSzpUGsy7UJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCp2YCa7; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59310014b8eso1825806e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761720896; x=1762325696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDqF9BgrJ7R48G+OSHsQqZ22RHXmw3YvmJtykHqVDo8=;
        b=iCp2YCa73R/AcYny5E4dUcRvPta39b2PyzMXe9wshuegpEKraa8i3tMmTa7wav7ZF8
         Ul0z9s6jrKwuShnHUwN6D5MycnbB3/we8cGkoVYXRsUrYIRSFLUgClAYIzX3RGJk146A
         iOf75uqr26V8Eiw74g/2mM/1sd6b+a+ESCCvw8KME3PSTxf2fZcbCKBvCGH9hwG0hMx7
         94z0d75i1wEqUG4vuJtP1xBvcP4CGDlgiBQl1hlD/Buf9fLdQU8SkggOopoCPPQg39YS
         lES07e1/e8pbJgVjTIKns98k2pJepTvwWHlsltZIENn/KF4EWltCriZB8mc0tHEAy48Y
         i5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761720896; x=1762325696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDqF9BgrJ7R48G+OSHsQqZ22RHXmw3YvmJtykHqVDo8=;
        b=wGwip+nm8TpPE1ephPPDbCQuegyZ+QgihmMEE0Z2RbwFdxN5P6HwHxBcGNkuabCzrf
         phGAHozKhWMb1HnlliSf2qIFPvmPfNwn0GJyFGNTrvQ5n2DzqEs7sQIzDg+j/g2fUHP+
         wRzx1dTcHpMBkA+Aw4A2PsHKvn4jatbMZQEgk2/kkhF59HVyDzn9NVfXyPVy0Z2mWq6b
         CYmuv03QDG6N821LWLK4oNJVzgHg99jgqL71XEruGv2uQcbT3c5ZK2oyCqh7ookEYMiB
         5mKyH6kkV3HknyyPap2spfxHWHhpCF52eiIpWYzhcffxZZIBopB/CrpnK5sTpwDEMMNN
         KHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmCMUHo1f2V35YziUdtuy2A1AO8fFhPoNCY5LdUy8vDzBCWhbaZhpjeMZUHs6itpGCG41bJVQMPiEd1y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFjzasijOc+7ObR+kcpl5A6+uh1Dn37eLM7EVY7Q8SDS6pJkAg
	Py6PzeW1OBu1afg6najZPLcwLpl6O3rAu00xRxLkWiWunVpC9r4I7S8m1xZCWh2jmej9yDiwGqW
	SM6iQuGWf0KT/bJFzu4wvp5I5dpKJgw==
X-Gm-Gg: ASbGncsS/RFyvoNnsGBSuR9VpM6lSYTuxdcgCgsoj5SoTW7ee2D5aHgfik2/fp7ZZqH
	Sbu0Q9iBCt9Y4FKti4QaV7+moR6FJZIO55gQUwcW9RxcSMX+RxoEA5DtA+tyK+um/mfgEDj14b5
	O5TptRVK07nL77QfmAVxph2PWWrMnv3zod8y1kzaBDujq9dUYXlHw8kprBNSBtYJ2Dnvz9Gu/77
	c9rgi7INnVeugINvQxFaJXhULZCVDAMCZkBVu1dtQr92T49rt1IjKLFtPj/v4gWWph3pxCMIG0=
X-Google-Smtp-Source: AGHT+IGEuL5EZ1//R48jmqcfeWhsVo1m8oxthAF3NZBoYhNUuWGZKmZifPFDiAMnhMvwmoelT2mK6IbqIEbGCeJQ3WQ=
X-Received: by 2002:a05:6512:6c9:b0:57a:311:3234 with SMTP id
 2adb3069b0e04-594128e9881mr684224e87.55.1761720895815; Tue, 28 Oct 2025
 23:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026221208.1938173-1-hpa@zytor.com> <20251026221208.1938173-4-hpa@zytor.com>
In-Reply-To: <20251026221208.1938173-4-hpa@zytor.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 29 Oct 2025 02:54:43 -0400
X-Gm-Features: AWmQ_bmfiyfREKo0e-gaQFIywqypW-gaTtMVt4rv1DnveKwp_KlVvqDZ1gAvjyk
Message-ID: <CAMzpN2g1G9Jc6eL4L+Rq3kGvKALt-tuaA3NKUuZ-jJXeaKuPRA@mail.gmail.com>
Subject: Re: [PATCH 3/6] x86/entry/vdso32: remove int80_landing_pad
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Xin Li <xin@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	James Morse <james.morse@arm.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, Nam Cao <namcao@linutronix.de>, 
	Oleg Nesterov <oleg@redhat.com>, Perry Yuan <perry.yuan@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Thomas Huth <thuth@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-sgx@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:12=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> There is no fundamental reason for the int80_landing_pad symbol. If ip
> falls within the vdso, and the vdso is moved, we should change the ip
> accordingly, regardless of mode or location within the vdso. This
> *currently* can only happen on 32 bits, but there isn't any reason not
> to do so generically.
>
> Note that if this is ever possible from a vdso-internal call, then the
> user space stack will also needed to be adjusted (as well as the
> shadow stack, if enabled.) Fortunately this is not currently the case.
>
> At the moment, we don't even consider other threads when moving the
> vdso. The assumption is that it is only used by process freeze/thaw
> for migration, where this is not an issue.
>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> ---
>  arch/x86/entry/vdso/vdso32/system_call.S |  1 -
>  arch/x86/entry/vdso/vma.c                | 16 ++++++----------
>  arch/x86/tools/vdso2c.c                  |  1 -
>  3 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vd=
so/vdso32/system_call.S
> index 2a15634bbe75..d14eca4403c5 100644
> --- a/arch/x86/entry/vdso/vdso32/system_call.S
> +++ b/arch/x86/entry/vdso/vdso32/system_call.S
> @@ -62,7 +62,6 @@ __kernel_vsyscall:
>
>         /* Enter using int $0x80 */
>         int     $0x80
> -SYM_INNER_LABEL(int80_landing_pad, SYM_L_GLOBAL)

This is still needed by do_fast_syscall_32().


Brian Gerst

