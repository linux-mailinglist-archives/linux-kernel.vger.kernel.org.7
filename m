Return-Path: <linux-kernel+bounces-704605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 927FAAE9F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06171C267A6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00CA26B970;
	Thu, 26 Jun 2025 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ala7Mcdo"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616C12E7F1C;
	Thu, 26 Jun 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946209; cv=none; b=lnBFUNM9L5k/Pk8dAEbONVwY75ztsxx68yiR4lpnNWso2KafyHTo0RA9gwbsUXUBbeOBqWERYkMESscdvaO8d2Yp5CGFl4p+HMr+PPLbdHgmr4UB+YqWab7tdNV4DE1Q5aqK04fsOeqyXcmqIu3wZgsufe7ITVsmQGogJxEGDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946209; c=relaxed/simple;
	bh=gjdHL52RORLpW8wvnJn6OWMRqxB5lI1erYSoLtMSVmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OD4qODYhwducq4hnAHrhcL/Ub1r9o3s0u7uBp36dFbQMOCIQCkqCHcvOiO7Q5eZSw880njCvCLHsSOKOGaUi8yYJ2GLZzTtfeoVPK4DNkNZ/emHLG7PW/w4EtnYhlZmGnqBto1ycBs44cXMajsuUFIYl4vEQlZD9NMYQIq5T3j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ala7Mcdo; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3137c20213cso1144681a91.3;
        Thu, 26 Jun 2025 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750946208; x=1751551008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvA01Sx6mR6kWi/vaxXvE8U/fUvAZjtw0tMx9Rr2caI=;
        b=ala7McdoMmXryixCWucdCxiyp1yWOj+f962PONx1Q85DvpzP2vgU2qUQcBFPAiXwC9
         Y7qvy7OpAY2RM4MO3qnxdpnqDaSFQLnvIPVt87+qhoTtbGS0gY0/DdBr+tFKL18C2rg+
         AR5MDjUHg+2I8xX4EO66jlz+Xl1FZs6X5mBkMGEzIVuitOjtSxmab1iq+Bdssxc4ZC0j
         fBnS35Nfqs/zLHzVVyDAkw22nsx0nJwt9YZreYNzZoG156zMQIPJiRPpHsGpMgh1lQxy
         KG/3cjs0WROFQ358hilaFPiXj54eOVqfddNzSKCokdXpZiPUeUqnRNuI5kS+7h0seoB5
         bQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750946208; x=1751551008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvA01Sx6mR6kWi/vaxXvE8U/fUvAZjtw0tMx9Rr2caI=;
        b=s295J/zL4RUMf37fZyHC2XJY91GmUCvlvGhH0vkWmw5YZKzA2vQ5tGYbeijCt/xaJD
         WR5T2y5USrF7innzFLVwiukShvemLNi+ti2Moy520gGAAp9JdsE2MUOYiKQ8cRlpzINr
         ChLvLBUEvinTi3xnz4HxfWIS03qP0tvH3AYk+qCzHJ1AplbCBTjadEl9mDpN/bEwf1pZ
         q2SOfEVyf6r69j1abDtrShOkmvwsnHJoevKHdhew4CA6I5kABGFHu/45AXwMh2gWuKqm
         8tPVmHO04TqYgGY2pTPidf4wB+Wny4T0thyLIO6NYINO7m9D5f4PtfErCnODiZLmBtWQ
         ETGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV03XEQa78Axe+YEqs+I8ojmH2tsozgDcfVM3NOBW9ZxyvCKyIp3ZFMjopD02jtoZwfEpT9R9mJ6lwvGeekIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23kacyxYC4sUc4b5yVqxmIo1DfDa7fIINm4YlfTa6d62CnQ6+
	Y26EOUzvjSigUSYOK1BTf3eWP/A64+h09ry/DG84+P0WzrOLn/tnZTjlO4F1mxR4oFRAQlvGFRs
	6g/KeKTeB2G4UtJnAnGxprKbwEiHwIDo=
X-Gm-Gg: ASbGncvNv6owtNNjhdMSCxqhajd1Uk+0x8T8g4UMKmHG8OeHl8gdOmeHgEPI4H0gXae
	sqIyNAk4F3jhZhlbFG5z6bh2fr6Nny5JoBm3RWvrvtY2Ao5RY1MYTYvuJSsGnm+9kgUoUc2/s0z
	9VzzsORBwz43JP1Lssvzu33+KywrMQQuSOZTBSRniF4yb7
X-Google-Smtp-Source: AGHT+IHa6yXbM+5t0Adv5dhFozO1ihksVo3U4Ek0FSY6Tg6xwKFT7Wimn2JDB77xa3AbviAVvHPk4vp6zrXXGggTnYM=
X-Received: by 2002:a17:90b:51c3:b0:312:ea46:3e66 with SMTP id
 98e67ed59e1d1-315f26771admr9880287a91.21.1750946207302; Thu, 26 Jun 2025
 06:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625111133.698481-1-shankari.ak0208@gmail.com> <DAVYWQE2PYZE.3TRIT906A9BJM@kernel.org>
In-Reply-To: <DAVYWQE2PYZE.3TRIT906A9BJM@kernel.org>
From: Shankari Anand <shankari.ak0208@gmail.com>
Date: Thu, 26 Jun 2025 19:25:00 +0530
X-Gm-Features: Ac12FXyUfuHgDsplwFCWon9SVCweA6V7I2FgMpfKrWvpZS6e0pfkq2b7MOiOMmw
Message-ID: <CAPRMd3=5aMx_DmhuXxWbNodM8OV6EWkXMTByAzOSr3ESoSj_BQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: move ARef and AlwaysRefCounted to sync::aref
To: Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Roy Baron <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
Thanks for your feedback!

> I'd say this module is about supporting objects with builtin reference
> counting.
I described the module as an "Atomic reference-counted pointer
abstraction" to highlight its similarity to Arc<T>, but for manually
refcounted types. Your version about =E2=80=9Csupporting objects with built=
-in
reference counting=E2=80=9D is definitely clearer, happy to adopt that
phrasing if preferred.

> I would lead with comparing `ARef<T>` to `Arc<T>` and only later mention
> `AlwaysRefCounted`.
I mentioned AlwaysRefCounted early on just to give readers a quick
idea of what the module is really about, but I understand your point
about introducing it a bit later and can rearrange that.

>
> You also rephrased these docs, can you do that in a separate patch?

I rephrased a few lines in the intro since we=E2=80=99re starting a new mod=
ule
and I thought it might help with readability. But if keeping the
original is better, I can revert those changes, no problem at all.


> Newline?
About the extra newline - I didn=E2=80=99t add it manually, but it might=E2=
=80=99ve
come from creating the new file. I=E2=80=99ll check the patch, and if it wa=
s
actually added, I=E2=80=99ll remove it.

> ---
> Cheers,
> Benno
---
Thanks and regards,
Shankari


On Thu, Jun 26, 2025 at 3:59=E2=80=AFAM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Wed Jun 25, 2025 at 1:11 PM CEST, Shankari Anand wrote:
> > diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> > new file mode 100644
> > index 000000000000..93a23b493e21
> > --- /dev/null
> > +++ b/rust/kernel/sync/aref.rs
> > @@ -0,0 +1,170 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Atomic reference-counted pointer abstraction.
>
> I'd say this module is about supporting objects with builtin reference
> counting.
>
> > +//!
> > +//! This module provides [`ARef<T>`], an owned reference to a value th=
at implements
> > +//! [`AlwaysRefCounted`] =E2=80=94 an unsafe trait for types that mana=
ge their own reference count.
>
> I would lead with comparing `ARef<T>` to `Arc<T>` and only later mention
> `AlwaysRefCounted`.
>
> > +//!
> > +//! It is based on the Linux kernel's manual reference counting model =
and is typically used
> > +//! with C types that implement reference counting (e.g., via `refcoun=
t_t` or `kref`).
> > +//!
> > +//! For Rust-managed objects, prefer using [`Arc`](crate::sync::Arc) i=
nstead.
> > +
> > +use core::{
> > +    marker::PhantomData,
> > +    mem::ManuallyDrop,
> > +    ops::Deref,
> > +    ptr::NonNull,
> > +};
> > +
> > +/// Trait for types that are _always_ reference-counted.
> > +///
> > +/// This trait allows types to define custom reference increment and d=
ecrement logic.
> > +/// It enables safe conversion from a shared reference `&T` to an owne=
d [`ARef<T>`].
> > +///
> > +/// This is usually implemented by wrappers around C types with manual=
 refcounting.
> > +///
> > +/// For purely Rust-managed memory, consider using [`Arc`](crate::sync=
::Arc) instead.
> > +///
> > +/// # Safety
> > +///
> > +/// Implementers must ensure that:
> > +///
> > +/// - Calling [`AlwaysRefCounted::inc_ref`] keeps the object alive in =
memory until a matching [`AlwaysRefCounted::dec_ref`] is called.
> > +/// - The object is always managed by a reference count; it must never=
 be stack-allocated or
> > +///   otherwise untracked.
> > +/// - When the count reaches zero in [`AlwaysRefCounted::dec_ref`], th=
e object is properly freed and no further
> > +///   access occurs.
> > +///
> > +/// Failure to follow these rules may lead to use-after-free or memory=
 corruption.
>
> You also rephrased these docs, can you do that in a separate patch?
>
> > +
>
> Newline?
>
> ---
> Cheers,
> Benno
>
> > +pub unsafe trait AlwaysRefCounted {
> > +    /// Increments the reference count on the object.
> > +    fn inc_ref(&self);
> > +
> > +    /// Decrements the reference count on the object.
> > +    ///
> > +    /// Frees the object when the count reaches zero.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that there was a previous matching increme=
nt to the reference count,
> > +    /// and that the object is no longer used after its reference coun=
t is decremented (as it may
> > +    /// result in the object being freed), unless the caller owns anot=
her increment on the refcount
> > +    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then call=
s
> > +    /// [`AlwaysRefCounted::dec_ref`] once).
> > +    unsafe fn dec_ref(obj: NonNull<Self>);
> > +}

