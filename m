Return-Path: <linux-kernel+bounces-831979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08986B9E0FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B24FC4E24BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F3F23E350;
	Thu, 25 Sep 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="T+IJyVVN"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422E4A1E;
	Thu, 25 Sep 2025 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789101; cv=none; b=oNHphkNisc662ajEeMLzHTNUz9mroIIcJvLJv+Aiq2mVYgm2m7fW0Z/lJRoD1vNd93J+nnfV/6W5zaHsG9mGWz5ylLQsyIngihMGKNVIVS/enx6ufdU1e7pTo74cVfFmUVkt2sDD4Hnc3Y/d/J6KK41JjL+cqe6HXsYJEUbARAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789101; c=relaxed/simple;
	bh=yFYhkPuT/6A+p396/AaW7nUVSxNun1mpGc9c2AuPclQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNmFUD/SvZc/CTlAAJ87H4CF6kgqfDD+O+DxdQRlVNZTKkjf7LDG+9FY27+IUNR2yLL2Q8u9AehrnJcuu1xjUZHxzLIuQmGSlBFVSOz5fKvRHsITOvtl7sYEQDXzhs1i1JYvWWH2G4bgGwyBd11Hy4GiQTZqf98rNm/a+BL3qt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=T+IJyVVN; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1758789091; x=1759048291;
	bh=HpijlZHR5DUt6PmUIjo0upRoVIpNNUVq0oY9+LHi5f4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=T+IJyVVNaWWoXP4nthGqcQO5fwDpdXCD8l3nXgAWY6N7pVBlh5shN/8oaS/llryh6
	 tK/BqU0hN3bjgNk/i5QivujHIWqKUJJAJYYCkBuW8INeB9duy5xnkbmF6E+fXVFBu1
	 JOVAI1NyvnV29d6FmFDaKgMIAroUEdgCrj0fh699rGDUNnW4azEC8OtzKt1lvk4az9
	 K07jeMkKbh3PdbNNmlQP4pVgztgoaqYJgUaIiEbjUtnbTp5VwvxRaMBEYkOZKkwXrF
	 b66SLa0hP7l0NFObLLSesxnVTiuLhYeujnpA31e0QUAbcJFwHCfFKg6C1jdT2xJb/b
	 i3GFQEY4CQQyg==
Date: Thu, 25 Sep 2025 08:31:28 +0000
To: Benno Lossin <lossin@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
Message-ID: <aNT92mzGsXfOsg2j@mango>
In-Reply-To: <DB1IPFNLFDWV.2V5O73DOB2RV6@kernel.org>
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me> <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me> <DB1IPFNLFDWV.2V5O73DOB2RV6@kernel.org>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 870cca1f6b9d5e243eceb95fbee6f6457768dce3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I finally found time to seriously work on completing this.

There a few questions that turned up for me, though.

On 250702 1303, Benno Lossin wrote:
>=20
> We shouldn't call this a reference. Also we should start the first
> paragraph with how this trait enables the usage of `Owned<Self>`.

Did you come up with any  suggesting what to call it? `Owned<T>` holds a
pointer to `T`. C++ would call it a smart pointer, but I guess that's also
not a good name in Rust.

>=20
> > +///
> > +/// # Safety
> > +///
> > +/// Implementers must ensure that:
> > +/// - The [`release()`](Ownable::release) method leaves the underlying=
 object in a state which the
> > +///   kernel expects after ownership has been relinquished (i.e. no da=
ngling references in the
> > +///   kernel is case it frees the object, etc.).
>=20
> This invariant sounds weird to me. It's vague "a state which the kernel
> expects" and difficult to use (what needs this invariant?).

The whole matter of what exactly are the safety conditions here is a bit
confusing, I find:

- That the passed `T` is (and stays) valid is a requirement on
  `Owned::from_raw`.
- That `Ownable::release()` is called with a live and unused `T` is a
  requirement for that function call.

I understand things like this then, that implementing `Ownable` is unsafe
because `Owned<T>::drop()` calls the unsafe `T::release()`.

So the requirement is basically:

- it is safe to call `T::release()` _once_ on a `T` stored on an `Owned<T>`
  if the `Owned<T>` isn't used anymore afterwards.

Not sure how to phrase that in a non-confusing way.

I went with this now:

"Implementers must ensure that the [`release()`](Self::release) function
frees the underlying object in the correct way for a valid, owned object
of this type."

> Maybe we should give `Ownable` the task to document the exact ownership
> semantics of `T`?

> > +pub struct Owned<T: Ownable> {
> > +    ptr: NonNull<T>,
> > +    _p: PhantomData<T>,
> > +}
> > +
> > +// SAFETY: It is safe to send `Owned<T>` to another thread when the un=
derlying `T` is `Send` because
> > +// it effectively means sending a `&mut T` (which is safe because `T` =
is `Send`).
>=20
> How does this amount to sending a `&mut T`?

Right, good point. I have to guess, but likely the reasoning was, that
Owned<T> is a wrapper around `*T` and has exclusive access, so somehow
equivalent to `&mut T`.

> I guess this also needs to be guaranteed by `Owned::from_raw`... ah the
> list grows...
>=20
> I'll try to come up with something to simplify this design a bit wrt the
> safety docs.

I added "`ptr` points to a valid instance of `T`" to the safety
requirements of `Owned::from_raw`. I think this should imply such things,
because a valid instance of `T` clearly has to be Send/Sync, if it is
implemented for the type `T`, no?

> > +unsafe impl<T: Ownable + Send> Send for Owned<T> {}
> > +
> > +// SAFETY: It is safe to send `&Owned<T>` to another thread when the u=
nderlying `T` is `Sync`
> > +// because it effectively means sharing `&T` (which is safe because `T=
` is `Sync`).
>=20
> Same here.

Isn't it okay here? All you can do with an `&Owned<T>` is to obtain a `&T`
from it.

Best regards,

Oliver


