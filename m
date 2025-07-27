Return-Path: <linux-kernel+bounces-747212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6832EB130FF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B250A18963AD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA1F221571;
	Sun, 27 Jul 2025 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Egp0+X7U"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7B7BA3F;
	Sun, 27 Jul 2025 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638296; cv=none; b=TdhK6ao25BwPEGrdjOpRzY6rjFj/KA38kQBHXMGM1xsELjmXDn+b3Bkdw8E0PFUF17Rg4PudabZPMrXyMpyM9xuOFgkbXQDvz43sRK7xSkNnOjpY9stKV6PcOVt2KOSgvBHPSXC7st6hbNRm6wG5o2PDBCJ9L45ZJ2Q+9wuCTrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638296; c=relaxed/simple;
	bh=luZy4eZKmQcKzAmjb0W2hbu7XLSsCm4YttVeB4b4JKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ufpx0jaAdLiRdA9fzj4m07jOSYgUqX4zcD0PH8LzR2yYDQm9QdjVwnrq/mr+XJJ7oVD7ODKqbSiZiYa3fI36F+0+kFf7Y8ogcGArhGgCBmKYuGFL2rjwrpUwmQTAO/HiuRuzR7XnQLsGKP9Yibr4/Pj8GD1n/EMuZ2GjtuWjHgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Egp0+X7U; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-40a4de175a3so2160160b6e.0;
        Sun, 27 Jul 2025 10:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753638294; x=1754243094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XGroCA+Q9oleFuUP1DUfRwkk4GCwj8qwuq1UKkEblcc=;
        b=Egp0+X7U5CeMzsps2ImYbUs3rX/gYwoAvGJZjTIOR0qP1BvNpEWSqaDzPEhyQnCiyY
         5fYP1KyWPrHnzM0Y18UuEk8i5WdRizi2r3f2B79h0gA9jAc//xdQ1RKyujZTNG/ZJCDD
         oSlDSD0quuit5Mar9uI0GdfVsL9MNJ5b3v9+GoC12qjxe8nW4Jg3VrgId8MGlbP9VaTN
         MMsL+TNiUv447BbQSjKP0Zd6oqSHk83dyk54+nyFeAFCl4okaoOplDZRtTqK4GuF49Jj
         PmsgGlO2LpcZwcFeLDiWcpm3vmYL7rsN2IRapc7GDxfRdJteY3/Dg/p9cCNrpKYSKzz7
         nBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753638294; x=1754243094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGroCA+Q9oleFuUP1DUfRwkk4GCwj8qwuq1UKkEblcc=;
        b=cZk7Mo0AovjmBaOxeda5FHSionhUATefFR9C5KxaL6pt/2CRMl58tV6vaMxw12rML6
         Pbugn/A7U07e+53BGQiHOif2jGGmnzSVRUggtwn2uhsqBxXiMgX/JB0GxoOi/wWIRcQr
         pVWGfXcNkQ6P6E9ezYJemE3/Dyap3I9GTdyTP0MuUzOsDmSTJXKYHU2sRntkUz7czRiD
         QO8jdMBvTg8nZ2Kdxch50eqo6TjlwSG9uPF0qixcdsQm35m7NA6G5IcnOXc97Nq6E5iS
         YAlWA9ivJCKYdDqRrt8OUFUNZUThfb4yOY7fJZyrNh8VFJ4me7pcYDSN0skx7fiyeAUr
         PSGw==
X-Forwarded-Encrypted: i=1; AJvYcCVdg+MyHhiRF47puOsTg34nVhJbRheTOIlcPTNLhEUNlXP/gfmNHPCbETj1+uYb8upltmA1w+VqXVMH2ZhQvBY=@vger.kernel.org, AJvYcCX38/i44g/CaiU5CzYjjvVpBL2+aSgznYbTuCXlK4Llg93y54dEFlI4IcVRA4pF0Evtw6msAeeP0Wz+P6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLLeUndi2/QcB7YBfFMINJCQZTpdw8BBHUOJU1poC/Z6ID+++3
	c8jSynZB8HYUsCis1hnlUpyC1Y8/DFXBfQEOeR3ndDYqxzHJm3IXhdGuLIOY7dzXVTkc+um6Z/v
	wK/cQmxMm9mGW/rE951RdkOe9WkwR9dA=
X-Gm-Gg: ASbGncu9XcPbWEyHL1YSBVIwIWIiMejTIsOd4xQ/o5MKSlWkwgBoHNmiMJbF0I8wCgL
	dQMth1X55qq2v5XN+F9nHm+taBUsIFtBc8SygvJe9dOquDRWtQ/iV0ljlN1P/oNwrOIx+arPqXr
	1DC+Xb7WRJqhEXEes1w+VDF5hmfYfpQmToyBHRx+NHPOenBp08Fg1EX6EbGpX7jmi+xCv0KBbn3
	eSMxvqs/Q==
X-Google-Smtp-Source: AGHT+IEcnnq+XHAJsDe6I+R84usIoc8E3O69l2x91KvquQ7Ibo03OEsTStfabGqIVtL64hiD9yrZDixEvAlp2fSKaZ4=
X-Received: by 2002:a05:6808:4fe8:b0:406:6e4b:bd91 with SMTP id
 5614622812f47-42bb71f6138mr5453348b6e.7.1753638294032; Sun, 27 Jul 2025
 10:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727170217.206794-1-suchitkarunakaran@gmail.com> <DBN0JG0QP7TU.PZSZ8NZL5LD6@kernel.org>
In-Reply-To: <DBN0JG0QP7TU.PZSZ8NZL5LD6@kernel.org>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Sun, 27 Jul 2025 23:14:43 +0530
X-Gm-Features: Ac12FXwSad14yHXxRo13EgdT4JwnjtEG8O1CWDHmMGLelFE845ODAhv-6zpFidM
Message-ID: <CAO9wTFisWa5qY2qQE+BEdD40vacGwtzw=2xxPnV0V_w=Gt4jwg@mail.gmail.com>
Subject: Re: [PATCH] rust/pin-init: remove workaround for type inference cycle
To: Benno Lossin <lossin@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, me@kloenk.dev, 
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Jul 2025 at 22:58, Benno Lossin <lossin@kernel.org> wrote:
>
> On Sun Jul 27, 2025 at 7:02 PM CEST, Suchit Karunakaran wrote:
> > The `cast_pin_init` and `cast_init` functions previously used an
> > intermediate `let` binding before returning the result expression to work
> > around a Rust compiler issue causing type inference cycles. With the
> > minimum Rust compiler version for the kernel now at 1.78.0, where this
> > issue is fixed, the workaround is no longer needed. This patch removes the
> > unnecessary `let` variables and returns the expressions directly.
> >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
>
> I still encounter the cycle when compiling with 1.78.0, which version
> did you test this with?
>

Oops, I just realised that I compiled it locally and forgot that I had
installed version 1.78.0 on my VM and not on my local system. I
actually compiled it with version 1.88.0. Sorry for the inconvenience.

> One of The errors I see after applying the patch on top of
> `pin-init-next`:
>
>     error[E0391]: cycle detected when computing type of opaque `cast_pin_init::{opaque#0}`
>         --> rust/pin-init/src/lib.rs:1278:73
>          |
>     1278 | pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T, E>) -> impl PinInit<U, E> {
>          |                                                                         ^^^^^^^^^^^^^^^^^^
>          |
>     note: ...which requires borrow-checking `cast_pin_init`...
>         --> rust/pin-init/src/lib.rs:1278:1
>          |
>     1278 | pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T, E>) -> impl PinInit<U, E> {
>          | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     note: ...which requires promoting constants in MIR for `cast_pin_init`...
>         --> rust/pin-init/src/lib.rs:1278:1
>          |
>     1278 | pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T, E>) -> impl PinInit<U, E> {
>          | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     note: ...which requires const checking `cast_pin_init`...
>         --> rust/pin-init/src/lib.rs:1278:1
>          |
>     1278 | pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T, E>) -> impl PinInit<U, E> {
>          | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>          = note: ...which requires computing whether `cast_pin_init::{opaque#0}` is freeze...
>          = note: ...which requires evaluating trait selection obligation `cast_pin_init::{opaque#0}: core::marker::Freeze`...
>          = note: ...which again requires computing type of opaque `cast_pin_init::{opaque#0}`, completing the cycle
>     note: cycle used when computing type of `cast_pin_init::{opaque#0}`
>         --> rust/pin-init/src/lib.rs:1278:73
>          |
>     1278 | pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T, E>) -> impl PinInit<U, E> {
>          |                                                                         ^^^^^^^^^^^^^^^^^^
>          = note: see https://rustc-dev-guide.rust-lang.org/overview.html#queries and https://rustc-dev-guide.rust-lang.org/query.html for more information
>
> > ---
> >  rust/pin-init/src/lib.rs | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
> > index 62e013a5cc20..cc244eeb19cd 100644
> > --- a/rust/pin-init/src/lib.rs
> > +++ b/rust/pin-init/src/lib.rs
> > @@ -1278,10 +1278,7 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
> >  pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T, E>) -> impl PinInit<U, E> {
> >      // SAFETY: initialization delegated to a valid initializer. Cast is valid by function safety
> >      // requirements.
> > -    let res = unsafe { pin_init_from_closure(|ptr: *mut U| init.__pinned_init(ptr.cast::<T>())) };
> > -    // FIXME: remove the let statement once the nightly-MSRV allows it (1.78 otherwise encounters a
>
> Do note the comment mentioning that it is needed for version 1.78 here,
> so I think this patch still needs to wait until we bump the minimum.
>

Yup got it. I'll send the patch after the minimum version is
increased. Thanks for reviewing.

