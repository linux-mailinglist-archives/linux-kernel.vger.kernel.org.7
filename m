Return-Path: <linux-kernel+bounces-741681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A322B0E7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173841C28585
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB4C1519AC;
	Wed, 23 Jul 2025 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJZz0pPn"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80A42AA3;
	Wed, 23 Jul 2025 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753231715; cv=none; b=FHvKdAt4NgocrSN0hQYsGdztk2FpNh7BMNjFSDGDBL/QXD/uRYz17rGsCtUefTVYC/ci6Eqz4D0oML7d7/g15P+wNJD2+U6DJGLOlvrIf0/7hmxYoQL3qlEPWhgvctSj+pQyWfTZZebAMGEJqhw3syk0rlI8lT507tAxViSC6SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753231715; c=relaxed/simple;
	bh=fYQuLA5qMz03a7AGBgthH1t+FyaBC1FDyitoyKLvjpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyhFB0xo/CjqYprWPt97XikIGU+l+KISVLkjWIlWa5bsU4SVGgkGMtO/7LJlJWvKQS1CvYVqldhYF8JtwB1MeCbxIf8xYPJ0rpPizKn9aktGI/PQ0cQvXkls1Rlg3e+75ONkOHLcI+mC7Fe03YpllUB2y6YTLSDuLXrnYG+AmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJZz0pPn; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31306794b30so239584a91.2;
        Tue, 22 Jul 2025 17:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753231713; x=1753836513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDWwMCWNmNg13/uNfIiBkoY/WSAIAnYmTPwjUuO5SDo=;
        b=SJZz0pPnJYv74YC/0aA1tXWGykUl9KOsFl+a6I0I8nYcstE2GvClQ6cTwI3nzOWI/u
         OT7IaHOm8QXPjan9igUE4yntE41YlRDXSChZIrF6P6iUXBf/yMpoot3UTrd2a184aDkf
         MUZvOb9VMGYHWybrRogws9qqAjvSyw8xrfaVHtpuCjYkTdIvFXhiDYSFKR+H4fm4zdlk
         xoVbjmIE2OTtQcF8mrXZCclgrv4vaBGiIFxz8rwZtH3rxQpwFY2PFRZYRx6ASsgCo6xg
         /FgO5gnOS/Ter77VE97n3bFkExgYklBY9SPGmUYfwZKoLegWBxdL2AXu7nNP/0gA5uoz
         uLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753231713; x=1753836513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDWwMCWNmNg13/uNfIiBkoY/WSAIAnYmTPwjUuO5SDo=;
        b=N3aBycWpPqK841MBzugYudFtaTY3Tj+QgW92NigdA/T0loCh5KfGLVJcSmIBR4atOn
         +G5v/y7mTn/GevKXdtAAIGKnSSf5DCt3imoNYHfBclMa3bavDoNydrjfS1YbmJuaEjwI
         MM/ULBf/8CU0/Xok7aFmXfG2OYz8JzVrh0xfSboPJ3JoEFiWf+aTx6qwo8ystO5XySBV
         ZLH21oOSZXMpbo2wt2hdJn1VqDaFGSoFi+5bWzhI7KTRCWo6lz7w+2XIv7U5aHgUVP7Y
         NwqLFvjDV1SIo47TW033X1Z3WQmrivR/pnNQ48I7o/gLe0Em4cofEKF/18GRDPXde7j3
         g2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSkL5Ick2XjV2B00HQWHF2nMk8PQhP80vtvConhlWwOAznaggVUmQNL5miVSOD5I/ktnDBjljxu1mash+SQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNkOPByGwWHIKL0Is+dJ4/afAWJMoHfFPPNNedQeDf3FF+c0I
	9mGsCjC7dEmze+m86N8LO3u42lvwd4IIudqX2ZD76uxL4CXh/KinKrm1vdJrooatN5E3OlZNi9F
	XV+M7hlI8J1cCvpbkO0cyz0ZJ+BbAR9Q=
X-Gm-Gg: ASbGncsaL668VCCUq1H9JxJvPAaU/PfS+A4sF8KZpBtGFyhbrfj+H51Y8YbNQsR0dIn
	s7XpI3e/q1eNRnY3SQrFpazTpD/C3Dek78G5nlaNHy44iEhqrEhUj82zLHbwbaZNl2yMidWjIw8
	rmAMRTf+9uHms8RKwzXjrgBr811wQIhoKkGiM8mfualgoZOLHpEPxzo2fRfDJjRxtMgEk5S6hxw
	Ph7qE8A
X-Google-Smtp-Source: AGHT+IEROY3xKK1boGx8uMtw+7HtkmcD7Il1aBqwfuxTsZ79ub1lx8jvxICoebRQamqfzBv+TelUdZ/qR6LkFSGFHEw=
X-Received: by 2002:a17:90b:4d08:b0:310:cf92:7899 with SMTP id
 98e67ed59e1d1-31e50812d7cmr712415a91.3.1753231712760; Tue, 22 Jul 2025
 17:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502094537.231725-1-fujita.tomonori@gmail.com>
In-Reply-To: <20250502094537.231725-1-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 23 Jul 2025 02:48:20 +0200
X-Gm-Features: Ac12FXwgRZoR7Zgn1XC8m0WPG0N61nJSGet7-c0jdjdrsFebOoekk-VJ_EoxJF4
Message-ID: <CANiq72=Hr5rg7tYta8aUoxt8hOPjR2ik5_-xMWZwacr63=-7KA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] rust: Add bug/warn abstractions
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	x86@kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, peterz@infradead.org, hpa@zytor.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org, 
	kernel@xen0n.name, tangyouling@loongson.cn, hejinyang@loongson.cn, 
	yangtiezhu@loongson.cn, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 11:46=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> This patchset adds warn_on macro with the bug/warn abstraction that
> utilizes the kernel's BUG/WARN feature via assembly.

Ok, let's move forward with this.

I took a look at the first three patches and compared the expanded
output for the existing macros, to make sure we (hopefully) don't
break anything else.

It seems OK, I only noticed a removed newline. Was that intentional?
There was also a bad parameter name, but that was not hurting anything
since it was unused.

(For the x86 one could be closer removing a couple spaces, but it
should not matter and other x86 files format it that way, so I didn't
change it. I also noticed unexpected spaces used for aligning the
macro, but it turned out it was in the original already, so I left it
also unchanged.)

Then I found a few more bits on the last patch.

Tomo, could you please double-check you are OK with all the changes,
and please run the tests you did back then on `rust-next` again for
all arches, given it has been a while since you posted it (plus I did
a few changes on top, after all)? I would appreciate it, thanks in
advance!

To be clear, I didn't re-check every single thing/combination, but
hopefully what I caught helps. Since there are no users anyway (of the
last patch) right now, it should be fairly safe.

Applied to `rust-next` -- thanks everyone!

    [ Fixed typo in macro parameter name. - Miguel ]

    [ Remove ending newline in `ARCH_WARN_ASM` content to be closer to the
      original. - Miguel ]

    [ Avoid evaluating the condition twice (a good idea in general,
      but it also matches the C side). Simplify with `as_char_ptr()`
      to avoid a cast. Cast to `ffi` integer types for
      `warn_slowpath_fmt`. Avoid cast for `null()`. - Miguel ]

Cheers,
Miguel

