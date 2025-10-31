Return-Path: <linux-kernel+bounces-880315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DECBFC25796
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E1644F6FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073A723F417;
	Fri, 31 Oct 2025 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFJrYsXb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5952A2512E6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919533; cv=none; b=sbMzNoJ81JyGtmsebkqXb2CHBgbnAQXjrihd9Ebx2v6+rjG4gAjhhJvW1KR7YBAktj4GSFxGdcHWv+WkbRUWYXcsC8b+4Z2iQrIbT6p2ENXwoc9Aqrvm8ZHxc5kXjxBdUcl+mTsu6c6n18be44UZ34I8pde9WJ4tlNY0hp9jhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919533; c=relaxed/simple;
	bh=uj/ZlfFSuGh87bLUZBain32EiwylAIzOLbNNPboS71c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GF5HDToOtK57RBDkw7IBlxRLH3nSRXb7D5O+QSQxo3NKskw9zXyFIn53glUKlKraL4n8IqPby/Q8Dcyv5VSjsH9ePgFnozm+ceJH2CjRGB/lZGWyF63O5tvCExxFTgfsK3xRDsJ4cm8mu4/Ub+SPUmaOkpXWAaR2VLGEDDDRWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFJrYsXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28608C4CEFD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761919533;
	bh=uj/ZlfFSuGh87bLUZBain32EiwylAIzOLbNNPboS71c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UFJrYsXbqrOJNvjxLmImQz4gJ+MWtlDo5SyX6Oc0Ool0gh13fHTVQpPuML3GLF74v
	 WKl6J4HtDo1hfwREpyz0F7IwSaYUfzVB8neaNmYVpHHciGdZdO193RZ/XF+E7VJS5T
	 AyOg7qnZBsZCj5q80JaOYlTBx2qeENWa5cfI7wYObFhv8C8V1bZ5oIambHR1edFOjZ
	 to+dLqSNQCgtc78NR0xYaXuBOaM+DAlzmsnGePsEyRPOzz7p7HDnHrQlMs6rvyfYpi
	 GAjx6SnSA2SiQs4k1RfgwbkDLfZyyaJNN+hC/Lk/D1V1ns2x/6KQbC5iWWY++6V+b0
	 LVlCHCMThzVig==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57992ba129eso3022560e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:05:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqI15OL51TK2hJDUhDBvm4agii97l6lHW14aKsRv09V3D0TLfGhUoSzPAJIXUSofexmD800P/iIIUs9FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWiMPEu/sZqw6jQta9k7w/z7YaJ1ltjrTMQqLZKvCu54XSTx6h
	Lu7sa8jeCoy/0eZj1Wkg1axJoA3S1TrS2JAC+cFXLJfSV2i50jjA1DtKIGrdhPgdKB2j8pHnyPS
	ZMb9zpVcqnW8pO4CmgKz9a3gbjZ/GW1o=
X-Google-Smtp-Source: AGHT+IHxedjSkvxKkv90NCDn2L1W+uzOFU/ki2EFNLnaSTgc3pXi1eADnpmiAPba+uDgY3ddk1bvQQvTu14wKMJoNJQ=
X-Received: by 2002:a05:6512:4019:b0:592:f41d:4dae with SMTP id
 2adb3069b0e04-5941d511d69mr1308147e87.3.1761919531454; Fri, 31 Oct 2025
 07:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031103858.529530-23-ardb+git@google.com> <20251031103858.529530-31-ardb+git@google.com>
 <20251031134909.00006bf3@huawei.com> <CAMj1kXHMa_Vj3DsuoAR-rvWW12Bsnz10w+BAze6mtngqpABZPw@mail.gmail.com>
In-Reply-To: <CAMj1kXHMa_Vj3DsuoAR-rvWW12Bsnz10w+BAze6mtngqpABZPw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 31 Oct 2025 15:05:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH_YCuBT4CbidTcVDNz2qNvYK9afS+v9eNkNggB3gopBw@mail.gmail.com>
X-Gm-Features: AWmQ_bl0cRHww67O1TA2qm0ejud4NB4PHqq4Dz-q88By71LxnM0QIuZZvhBuGWw
Message-ID: <CAMj1kXH_YCuBT4CbidTcVDNz2qNvYK9afS+v9eNkNggB3gopBw@mail.gmail.com>
Subject: Re: [PATCH v4 08/21] lib/crc: Switch ARM and arm64 to 'ksimd' scoped
 guard API
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 14:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 31 Oct 2025 at 14:49, Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> >
> > On Fri, 31 Oct 2025 11:39:07 +0100
> > Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Before modifying the prototypes of kernel_neon_begin() and
> > > kernel_neon_end() to accommodate kernel mode FP/SIMD state buffers
> > > allocated on the stack, move arm64 to the new 'ksimd' scoped guard API,
> > > which encapsulates the calls to those functions.
> > >
> > > For symmetry, do the same for 32-bit ARM too.
> > >
> > > Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  lib/crc/arm/crc-t10dif.h   | 16 +++++-----------
> > >  lib/crc/arm/crc32.h        | 11 ++++-------
> > >  lib/crc/arm64/crc-t10dif.h | 16 +++++-----------
> > >  lib/crc/arm64/crc32.h      | 16 ++++++----------
> > >  4 files changed, 20 insertions(+), 39 deletions(-)
> > >
> > > diff --git a/lib/crc/arm/crc-t10dif.h b/lib/crc/arm/crc-t10dif.h
> > > index 63441de5e3f1..aaeeab0defb5 100644
> > > --- a/lib/crc/arm/crc-t10dif.h
> > > +++ b/lib/crc/arm/crc-t10dif.h
> >
> > >  static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_neon);
> > > @@ -20,21 +19,16 @@ asmlinkage void crc_t10dif_pmull8(u16 init_crc, const u8 *buf, size_t len,
> > >  static inline u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t length)
> > >  {
> > >       if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE) {
> > > -             if (static_branch_likely(&have_pmull)) {
> > > -                     if (likely(may_use_simd())) {
> > > -                             kernel_neon_begin();
> > > -                             crc = crc_t10dif_pmull64(crc, data, length);
> > > -                             kernel_neon_end();
> > > -                             return crc;
> > > -                     }
> > > +             if (static_branch_likely(&have_pmull) && likely(may_use_simd())) {
> > > +                     scoped_ksimd()
> > > +                             return crc_t10dif_pmull64(crc, data, length);
> >
> > >               } else if (length > CRC_T10DIF_PMULL_CHUNK_SIZE &&
> > >                          static_branch_likely(&have_neon) &&
> > >                          likely(may_use_simd())) {
> >
> > I briefly thought this was a functional change but it's not because
> > of may_use_simd() being something that isn't going to change between
> > the two evaluations.
> >
> > Would it hurt at all to pull that up to be
> >         if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE && likely(may_use_simd())) {
> >                 if (static_branch_likely(&have_pmull)) {
> >                         scoped_ksimd()
> >                                 return crc_t10dif_pmull64(crc, data, length);
> >
> >                 } else if (length > CRC_T10DIF_PMULL_CHUNK_SIZE &&
> >                            static_branch_likely(&have_neon)) {
> >                 ...
> >
> > ?
> >
>
> Yeah that would be a reasonable cleanup, I guess.

Actually, looking more closely, that would result in may_use_simd()
being evaluated even when the static keys are set to false, given that
the compiler is unlikely to be able to figure out by itself that
may_use_simd() has no side effects.

