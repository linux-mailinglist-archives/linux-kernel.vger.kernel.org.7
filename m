Return-Path: <linux-kernel+bounces-840517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE1BB4979
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189D0189C240
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7529025A65A;
	Thu,  2 Oct 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0Y94/Tq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10C5186284
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423729; cv=none; b=s9wlpSS8wAtio16K10coLcS6rnbEHh/IXQmTT0DxXRfwAv34nZFD7PLiUxixvBhJFqSNtddxp0G29/JzLsrV/+swCQ58V4Lc+npLMnLRjyn2jtr921Z4t4/0Ef69IvvykqR7fc9ZCkRIsA80S5ILhJNvwbY7To7GsjaRnwPJ8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423729; c=relaxed/simple;
	bh=UXUa16DxRQlc+YoczpHucO1ugFqhBs0jsvbBdOCdJO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eo8q73wL+KLtK0060tFazfeVUdFVDIdZSMDfFY0ePa22OWhhHM0/3rUM9YQkgkOrLP4IKYty0X1Pk259A+umgaszdJfTMuMyWJg5UFvgN4BpfQ8B5CS8RdYXKaGA9gvq4vgMhyWNiZ+dvfismVXzbjg50zgAEqufRgqnC89am5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0Y94/Tq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6266DC4CEFB
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759423728;
	bh=UXUa16DxRQlc+YoczpHucO1ugFqhBs0jsvbBdOCdJO8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j0Y94/TqYpj+kjQCWs9eFlHW/1YN9UkIeBZQD85d5KgIk/tOkOxey0WUrpgbqn7/m
	 2TysR5EYWNUT1E4JsgFLLed3pNhBxyUKFVkDzbzJ0jJpiR8aQ7vZNH9D3tZCWZwFzj
	 Fnk24RzRsdAEwYRumnbEHYz+DuvVePn8RWRsSlsZnit+sJphLjYr8NjaOI1LYsG89Q
	 rFZHWlJ/T8nrt/iRHRm8w8oDCxS1krM8vsJCXLCWA4r2B8DoBjwhwWsvI5HD44gVvn
	 nVWIid8AXpqNG3TPSu2OzyteNP/gSgAvXvzJXvvPYvxdbWW3J80vKrkUUDu4DLYo3g
	 sVODSxeCsewyA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso3242747e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:48:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwwvxALctalWdjEqGnBIBTkGVN0VMv7j4Esq6COwieiDzAFxwgZMRsVHE+pEcEgW9gPNQOxpnUfuiUv94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4RLI+C4el5yDbhJwIYaQF5FNAiJrxvrxIa3O2LPkvibuc6Ze5
	S9rTX6Ryz4Z6SVIDTc1mRWKeKbR/aAo7i838v6JUku/cS7v8/QlERJe+2NdtQfMzyfSm2iTHbXF
	8wn+hku7a93RaaBTzs5SP4ioZtzU56sA=
X-Google-Smtp-Source: AGHT+IEqXM/Be3cRNs05VWOlXbMCnMSG6Mba0tmbOYQBA/5ovj738cWnL+OCbs5vXp6LcKhFkY87M5wOVli92mntFKw=
X-Received: by 2002:a05:6512:2397:b0:581:bdb8:6df9 with SMTP id
 2adb3069b0e04-58b00b5eb3emr1343410e87.10.1759423726612; Thu, 02 Oct 2025
 09:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com> <20251001210201.838686-26-ardb+git@google.com>
 <202510020918.7E358227@keescook>
In-Reply-To: <202510020918.7E358227@keescook>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 2 Oct 2025 18:48:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEK+ggQXC6pruZs2jkg6fmA7+Uv45DY4B_XqTRsRbTf2Q@mail.gmail.com>
X-Gm-Features: AS18NWAZ8uFcVmA6EvK7W0-OFglLBSKI4YbLO-lps_DOpY0PjMY5dUoH7ZngWew
Message-ID: <CAMj1kXEK+ggQXC6pruZs2jkg6fmA7+Uv45DY4B_XqTRsRbTf2Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] crypto: aegis128-neon - Move to more abstract
 'ksimd' guard API
To: Kees Cook <kees@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	herbert@gondor.apana.org.au, linux@armlinux.org.uk, 
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Oct 2025 at 18:20, Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 01, 2025 at 11:02:06PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Move away from calling kernel_neon_begin() and kernel_neon_end()
> > directly, and instead, use the newly introduced scoped_ksimd() API. This
> > permits arm64 to modify the kernel mode NEON API without affecting code
> > that is shared between ARM and arm64.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  crypto/aegis128-neon.c | 33 +++++++-------------
> >  1 file changed, 12 insertions(+), 21 deletions(-)
> >
> > diff --git a/crypto/aegis128-neon.c b/crypto/aegis128-neon.c
> > index 9ee50549e823..b41807e63bd3 100644
> > --- a/crypto/aegis128-neon.c
> > +++ b/crypto/aegis128-neon.c
> > @@ -4,7 +4,7 @@
> >   */
> >
> >  #include <asm/cpufeature.h>
> > -#include <asm/neon.h>
> > +#include <asm/simd.h>
> >
> >  #include "aegis.h"
> >  #include "aegis-neon.h"
> > @@ -24,32 +24,28 @@ void crypto_aegis128_init_simd(struct aegis_state *state,
> >                              const union aegis_block *key,
> >                              const u8 *iv)
> >  {
> > -     kernel_neon_begin();
> > -     crypto_aegis128_init_neon(state, key, iv);
> > -     kernel_neon_end();
> > +     scoped_ksimd()
> > +             crypto_aegis128_init_neon(state, key, iv);
> >  }
>
> For these cases (to avoid the indentation change), do you want to use
> just "guard" instead of "scope_guard", or do you want to explicitly
> require explicit scope context even when the scope ends at the function
> return?
>

I'm on the fence tbh. I think for future maintainability, being forced
to define the scope is perhaps better but in this case, the whole
function contains only a single line so there is little room for
confusion.

