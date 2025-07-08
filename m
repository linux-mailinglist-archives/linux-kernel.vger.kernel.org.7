Return-Path: <linux-kernel+bounces-721289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DFAAFC72D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BB33B053F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1A325C810;
	Tue,  8 Jul 2025 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Me8Rb2Im"
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041521CA0D;
	Tue,  8 Jul 2025 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967416; cv=none; b=rAEDbLWf2SW+aENHUnFHEu84p8uOEGTdFdodMUjw2DfiLPiN9nRxuvnVBNuQI3WTNf7/R/3Bt7DvhEpxDLc4W1OjwgbqV2HMwSFUAiasbiY1z3p2Li4Nn9hkrTC3TzBuR9vhoEQ0er5Uw50eKOBzE+OiK2uFl+5Jn9wV1BNeIyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967416; c=relaxed/simple;
	bh=sr9JKCrucqrOYgxNpZ30mEiwJhUbzxZ4qUAP94zM24Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJmgO81+8QVW21Sv/6zy756GhmQjWh1tGo4EH81YTQgTcdLx+0/JhPmSe+PKSoPCCaU1xuO7ZaAUVcS15MhOs6zfqbhMfIxoGFdfbvvZjl8NboPrro0dRLhgHthn1yJpabn6/+dN19pvokP2v8P0XwIG6dHyOAPUxW7iWBcGuvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Me8Rb2Im; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1751967405; x=1752226605;
	bh=F+WPDRCXS0ipV0YS4ZzxZsEEXBovLbNjpv6gT1R9BGg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Me8Rb2Im9ZSarJFaeLxvD0GC20UNiucKzED7ZXyPaEmNLkWyEF5Nv7rrAIA1ukIKL
	 BKTHIna+JDJix/siBN2YXW4DiDW627dJ6POPJnn7H9kNmDCT9OFH47uJP6SYvhqRU0
	 R4jCD9vObMQ6GLKSieAPseHbWSEvblWRb6/vMiDkMzR1ccZIpTYokBDnkmsJWQrut2
	 dXL8C8xFW4bicw1DYqi1rUewzmf5hiD0Lf/e+ib+bog/GBdai2LEMNHtqapGgX0hGY
	 1mLN+QZVyIqdXwnwwTqPLSRAUDCZd9aNGpN50rdTexJAuSONJ+CcrEfgxllVDb+o5b
	 jYfMcKLxFN2rQ==
Date: Tue, 08 Jul 2025 09:36:38 +0000
To: Benno Lossin <lossin@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 4/4] rust: Add `OwnableRefCounted`
Message-ID: <aGzmoMWvy1v7ayyn@mango>
In-Reply-To: <DB5PX74OB3DX.1UNT8MIBWNC2G@kernel.org>
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me> <20250618-unique-ref-v11-4-49eadcdc0aa6@pm.me> <DB1LPFAX66WG.1QL5JDCWI7RN4@kernel.org> <aGuAR7JCrlmzQrx4@mango> <DB5PX74OB3DX.1UNT8MIBWNC2G@kernel.org>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: dbc2e24d718f3945dab4840749ba988923c77922
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250707 1133, Benno Lossin wrote:
> On Mon Jul 7, 2025 at 10:07 AM CEST, Oliver Mangold wrote:
> > On 250702 1524, Benno Lossin wrote:
> >> On Wed Jun 18, 2025 at 2:27 PM CEST, Oliver Mangold wrote:
> >> > @@ -132,3 +134,124 @@ fn drop(&mut self) {
> >> >          unsafe { T::release(self.ptr) };
> >> >      }
> >> >  }
> >> > +
> >> > +/// A trait for objects that can be wrapped in either one of the re=
ference types [`Owned`] and
> >> > +/// [`ARef`].
> >> > +///
> >> > +/// # Safety
> >> > +///
> >> > +/// Implementers must ensure that:
> >> > +///
> >> > +/// - [`try_from_shared()`](OwnableRefCounted::into_shared) only re=
turns an [`Owned<Self>`] if
> >> > +///   exactly one [`ARef<Self>`] exists.
> >>
> >> This shouldn't be required?
> >
> > Ehm, why not? `Owned<T>` is supposed to be unique.
>=20
> It's not needed as a safety requirement for implementing the trait. If
> the implementation only contains sound code, then `Owned::from_raw`
> should already ensure that `Owned<Self>` is only created if there is
> exactly one reference to it.

Okay, got it now. I guess you are right, it is not strictly needed. If the
requirement should be removed, not sure, though. Isn't it error-prone if it
explicitly stated here (again) that it is required?

> >> > +/// - [`into_shared()`](OwnableRefCounted::into_shared) set the ref=
erence count to the value which
> >> > +///   the returned [`ARef<Self>`] expects for an object with a sing=
le reference in existence. This
> >> > +///   implies that if [`into_shared()`](OwnableRefCounted::into_sha=
red) is left on the default
> >> > +///   implementation, which just rewraps the underlying object, the=
 reference count needs not to be
> >> > +///   modified when converting an [`Owned<Self>`] to an [`ARef<Self=
>`].
> >>
> >> This also seems pretty weird...
> >>
> >> I feel like `OwnableRefCounted` is essentially just a compatibility
> >> condition between `Ownable` and `RefCounted`. It ensures that the
> >> ownership declared in `Ownable` corresponds to exactly one refcount
> >> declared in `RefCounted`.
> >>
> >> That being said, I think a `RefCounted` *always* canonically is
> >> `Ownable` by the following impl:
> >>
> >>     unsafe impl<T: RefCounted> Ownable for T {
> >>         unsafe fn release(this: NonNull<Self>) {
> >>             T::dec_ref(this)
> >>         }
> >>     }
> >>
> >> So I don't think that we need this trait at all?
> >
> > No. For an `ARef<T>` to be converted to an `Owned<T>` it requires a
> > `try_from_shared()` implementation. It is not even a given that the
> > function can implemented, if all the kernel exposes are some kind of
> > `inc_ref()` and `dec_ref()`.
>=20
> I don't understand this paragraph.

What I mean is, to convert from an `ARef` to an `Owned`, it is necessary to
check that there is only one reference. The API of the underlying object
might not provide that.

About the above documentation, it is a bit convoluted, because I had the
case of `mq::Request` in mind, where the refcount needs to be changed
during conversion.

> > Also there are more complicated cases like with `Mq::Request`, where th=
e
> > existence of an `Owned<T>` cannot be represented by the same refcount v=
alue
> > as the existence of exactly one `ARef<T>`.
>=20
> Ah right, I forgot about this. What was the refcount characteristics of
> this again?
>=20
> *  1 =3D in flight, owned by C
> *  2 =3D in flight, owned by Rust
> * >2 =3D in flight, owned by Rust + additional references used by Rust
>        code
>=20
> Correct? Maybe @Andreas can check.
>=20
> >> > +///
> >> > +/// # Examples
> >>
> >> If we're having an example here, then we should also have on on `Owned=
`.
> >
> > Yes, maybe. I mostly felt the need to create one for `OwnableRefCounted=
`
> > because it is a more complex idea than `Ownable`.
> >
> > If I remember correctly, I didn't create one for `Owned`, as it should
> > probably more or less the same as for `ARef` and the one there has even
> > more problems of the kind you are pointing out. So maybe it would be be=
st
> > to wait until someone fixes that and have the fixed version copied over=
 to
> > `Owned` in the process?
>=20
> Wait which problems on `ARef` do you mean? I disagree that `Owned` and
> `ARef` have the same example. `Owned` should expose operations that
> `ARef` can't otherwise there would be no value in using `Owned`.

I mean it uses a `struct Empty {}`, which doesn't do any refcounting and
the safety requirements of `ARef::from_raw()` are also not fulfilled.

The point of `Owned` is not that it provides more operations than `ARef`
but rather that it provides less. The reference cannot be cloned. Actually
it is not supposed to provide much features at all, except for freeing the
underlying object when it is dropped.

It is supposed to just be a safe wrapper around a `*T`, marking that the
reference is Owned/Unique. Safe functions defined elsewhere can then take a
`Owned<T>` or `&mut Owned<T>` which provides the assurance of
ownership/uniqueness.

> >> > +///
> >> > +/// A minimal example implementation of [`OwnableRefCounted`], [`Ow=
nable`] and its usage with
> >> > +/// [`ARef`] and [`Owned`] looks like this:
> >> > +///
> >> > +/// ```
> >> > +/// # #![expect(clippy::disallowed_names)]
> >> > +/// use core::cell::Cell;
> >> > +/// use core::ptr::NonNull;
> >> > +/// use kernel::alloc::{flags, kbox::KBox, AllocError};
> >> > +/// use kernel::types::{
> >> > +///     ARef, RefCounted, Owned, Ownable, OwnableRefCounted,
> >> > +/// };
> >> > +///
> >> > +/// struct Foo {
> >> > +///     refcount: Cell<usize>,
> >> > +/// }
> >> > +///
> >> > +/// impl Foo {
> >> > +///     fn new() -> Result<Owned<Self>, AllocError> {
> >> > +///         // Use a `KBox` to handle the actual allocation.
> >> > +///         let result =3D KBox::new(
> >> > +///             Foo {
> >> > +///                 refcount: Cell::new(1),
> >> > +///             },
> >> > +///             flags::GFP_KERNEL,
> >> > +///         )?;
> >> > +///         let result =3D NonNull::new(KBox::into_raw(result))
> >> > +///             .expect("Raw pointer to newly allocation KBox is nu=
ll, this should never happen.");
> >>
> >> I'm not really convinced that an example using `KBox` is a good one...
> >> Maybe we should just have a local invisible `bindings` module that
> >> exposes a `-> *mut foo`. (internally it can just create a KBox`)
> >
> > The example would become quite a bit more complicated then, no?
>=20
> Just hide those parts behind `#` lines in the example.

I don't know about this method. Can you give an example on how that works?

> ---
> Cheers,
> Benno


