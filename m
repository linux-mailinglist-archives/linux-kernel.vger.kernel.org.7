Return-Path: <linux-kernel+bounces-842341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F16ABB98A6
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 16:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4104D1890EF1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C127428B4F0;
	Sun,  5 Oct 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1BvxJgG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8D192D68
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759676102; cv=none; b=S9K6kUMIZWSuatn6mdwPBEXxZFBFryumCRIKoP98afpa0J9fFEMZC6zHfkQe6M+4CYruJnaGpJFPQ9vKSVM5HOG+Y8ghnknWVqmTpXLXjGaUqUACnUM3Ucle0NNhFUAbnjEIvu/nOTC6NKcJ0CoSDLw7Uz9xG5GUEfiCoRbA22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759676102; c=relaxed/simple;
	bh=ZYk6FsRH/jslXCq9/JcYnqOpDmX7r2GE6f0FlyCufN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KW6dF6PDJMaUHs/EIXbu7CDL9/Z/WcSApbtAwFE/iaPovB/4epp8dkM7WDPcQF10UlNptfdSk0iK2F+wTJd+9rUaR472KjqF9gxxleROy1qky0M4/wd1phrh3wi5XqC/HV55ThS55mZAUZHhxV5XjeMogT8HzTX4BdQtczOcV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1BvxJgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B74C4CEF4
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759676101;
	bh=ZYk6FsRH/jslXCq9/JcYnqOpDmX7r2GE6f0FlyCufN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b1BvxJgGYWtcwBRRq327um1fnP0lBeCEz7UGPXdPP2f5skpT0SDfvUuRJohTfYNpx
	 xKCbOhSVwXMx49vtfIH+mazpkNHhxtyl8gvj3egwkjIthhhTUtRxOvbk6c2HC8X+Ae
	 hNi5HJCT/QbpBeem7Nl/3TLnq5CSGQSeUEnf+7lUXQX6dZc6Hr0A4OuqeZchnRBS4C
	 tkXR85iGX10PsDkS60FvCD/wMpv0UQ3LpHnSQGBjoAOPrmd42cttLUr4FfEKSOBWbH
	 qk0ZUgYTitIbOAHSnud2gcpiXlLZPs8/hrkzR/Hf+WLicLN30EljzRHgJf+3KNLETZ
	 ASogja45v2Qow==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-367ce660b61so39171981fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 07:55:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHZPsUkwjYhzUHdJbDFJsMVg8X/9Jan2FefaAkV7S+XD/JqA1HvEPHg7vw50ldqxMIAKwi5SeDjRXjlOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzlsP5Ve8yvr6lKZ+0vk7Tp8sE0i9g7iSswiJu2rU3FINX1BcT
	t22wWU7m+XkZicXCCz/fCBdnnoGJGU2SO67RAoyBfZFRFldonrgImo5mi4cBBMvlXH4e1aAZw8d
	jSWLK7HoR9O5E2omgiaWhREmqKlFHR0k=
X-Google-Smtp-Source: AGHT+IEWPLhimWsF9enpUuiQN4vp9kszXmdsUSVze7V2BuBpO3kLXs30fu/IjwtJEP8PxidGp4iNP3GkdNE0i5UM0aQ=
X-Received: by 2002:a05:651c:19a6:b0:372:921b:4b83 with SMTP id
 38308e7fff4ca-374c37eb675mr27154721fa.20.1759676100148; Sun, 05 Oct 2025
 07:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com> <20251001210201.838686-42-ardb+git@google.com>
 <20251003201818.GA24598@quark>
In-Reply-To: <20251003201818.GA24598@quark>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 5 Oct 2025 16:54:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEMZO8RLiqxHFkVqy-xe_e7D3JGTTdObRP=93B98PFR9g@mail.gmail.com>
X-Gm-Features: AS18NWBDyP2sRFU_7qLcyZdPGkaKIOB0fx5JmAkiVfN9-rbRf3z-I5vTQBCXLIE
Message-ID: <CAMj1kXEMZO8RLiqxHFkVqy-xe_e7D3JGTTdObRP=93B98PFR9g@mail.gmail.com>
Subject: Re: [PATCH v2 20/20] arm64/fpsimd: Allocate kernel mode FP/SIMD
 buffers on the stack
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	herbert@gondor.apana.org.au, linux@armlinux.org.uk, 
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Kees Cook <keescook@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 22:18, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Oct 01, 2025 at 11:02:22PM +0200, Ard Biesheuvel wrote:
> > diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> > index 4f8d677b73ee..93bca4d454d7 100644
> > --- a/arch/arm64/include/asm/processor.h
> > +++ b/arch/arm64/include/asm/processor.h
> > @@ -172,7 +172,7 @@ struct thread_struct {
> >       unsigned long           fault_code;     /* ESR_EL1 value */
> >       struct debug_info       debug;          /* debugging */
> >
> > -     struct user_fpsimd_state        kernel_fpsimd_state;
> > +     struct user_fpsimd_state        *kernel_fpsimd_state;
>
> Is TIF_KERNEL_FPSTATE redundant with kernel_fpsimd_state != NULL?

Not entirely.

The generic kernel_fpu_begin/end API that the amdgpu driver uses
cannot straight-forwardly use a stack buffer, given how the API is
implemented. Since this code already disables preemption when using
the FPU, and should not assume being able to use kernel mode FP in
softirq context, I think we'll end up doing something like the
following for arm64

void kernel_fpu_begin(void)
{
  preempt_disable();
  local_bh_disable();
  kernel_neon_begin(NULL);
}

etc, as it never actually needs this buffer to begin with.

Technically, setting TIF_KERNEL_FPSTATE is not necessary when no
scheduling or softirq interruptions may be expected, but I still think
it is better to keep these separate.

> > +void kernel_neon_begin(struct user_fpsimd_state *s)
> >  {
> >       if (WARN_ON(!system_supports_fpsimd()))
> >               return;
> > @@ -1866,8 +1869,16 @@ void kernel_neon_begin(void)
> >                * mode in task context. So in this case, setting the flag here
> >                * is always appropriate.
> >                */
> > -             if (IS_ENABLED(CONFIG_PREEMPT_RT) || !in_serving_softirq())
> > +             if (IS_ENABLED(CONFIG_PREEMPT_RT) || !in_serving_softirq()) {
> > +                     /*
> > +                      * Record the caller provided buffer as the kernel mode
> > +                      * FP/SIMD buffer for this task, so that the state can
> > +                      * be preserved and restored on a context switch.
> > +                      */
> > +                     if (cmpxchg(&current->thread.kernel_fpsimd_state, NULL, s))
> > +                             BUG();
>
> Does this really need to be a cmpxchg, vs. a regular load and store?
> It's just operating on current.
>

It does not need to be atomic, no. I moved this around a bit while I
was working on it, but in its current form, we can just BUG/WARN on
the old value being wrong, and set the new one using an ordinary store
(in both cases).

