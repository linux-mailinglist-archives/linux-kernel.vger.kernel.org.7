Return-Path: <linux-kernel+bounces-721313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D1AFC798
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579347AD637
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51B1268688;
	Tue,  8 Jul 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="QQLNDysn"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990AD267F4C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968633; cv=none; b=EDEXcJGFOWr6tvJykAwTlgtgkTSHBpy0db23N6TMy56qruSBKzDSAcCzLtvh6Qm/nYeEJ2zmh5VV2fBkzVXMv1auodfNycdSKfNuuTGYD6qjc/+1BZilx0g2R9RjlcJuMMhw68CSkAY2YaXHQVolrJibnUGDcm2d5TpL9eODI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968633; c=relaxed/simple;
	bh=UARk+kQbFmDW+kvV8YFNkg+2xZuu+oxOEUbZAp5I8mA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6UDuYcDAirBu6TX7+KvA1Lg7lSfmTcv/0PfUoPo3kEM99rZ/LscrdZMCl3KJ2MdTgcIPn8DWXQMZwp3o0FUapTqE+yajUhxl1TuJZ0CjlIUKPbIo0E3mNxs2+D0JVx3ZSMKsCQslKMQULAREVGMTXoMlhlSxMmfcVjbEn59HDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=QQLNDysn; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1751968621; x=1752227821;
	bh=2l3TkfjvjCWEDCpP4Te5SG1hFwqAhL+8OiIAkKRAXM4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QQLNDysnjPtAe4YwLvngov1AJZUMLVT2hOYvLiAz/yIyJZQx9wBiKIncBkqFTEmPq
	 6ofUkBqH9dsAdW1WV3OSWZ1MILYLXS/nuFMPCxnNmvZvMsPphwNy1iz+RQrYEa/h9k
	 Pas3HX9XA6/uLQtQXHwhyIz3zM2cSwGooIscJnhut3wrj7Cjo4yffstWEY79mL2Cn2
	 lLqD4I0EjP9fcarZFR/LJh8e4KChZWMLe269MeOHLftr1qi5u2YGlmkClP2BT1fc2W
	 NM27xVVK1IPbrGOpij6kXoA6FQQO1VseUInQfLC5hxqiOsE06fJjyZeJfpoTsOP8bi
	 qg+Zx/t9IrXIQ==
Date: Tue, 08 Jul 2025 09:56:57 +0000
To: Benno Lossin <lossin@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
Message-ID: <aGzrZqIrStGD_UBp@mango>
In-Reply-To: <DB5PPGOWNW4K.2C5A4UE9V9IEF@kernel.org>
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me> <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me> <DB1IPFNLFDWV.2V5O73DOB2RV6@kernel.org> <aGtv9qs682gTyQWX@mango> <DB5PPGOWNW4K.2C5A4UE9V9IEF@kernel.org>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 54e28f62d3ea56697116c9fa07669e83e4c37aad
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250707 1123, Benno Lossin wrote:
> On Mon Jul 7, 2025 at 8:58 AM CEST, Oliver Mangold wrote:
> > On 250702 1303, Benno Lossin wrote:
> >> On Wed Jun 18, 2025 at 2:27 PM CEST, Oliver Mangold wrote:
> >> > From: Asahi Lina <lina+kernel@asahilina.net>
> >> >
> >> > By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
> >> > (typically C FFI) type that *may* be owned by Rust, but need not be.=
 Unlike
> >> > `AlwaysRefCounted`, this mechanism expects the reference to be uniqu=
e
> >> > within Rust, and does not allow cloning.
> >> >
> >> > Conceptually, this is similar to a `KBox<T>`, except that it delegat=
es
> >> > resource management to the `T` instead of using a generic allocator.
> >> >
> >> > Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe5=
5e@asahilina.net/
> >> > Signed-off-by: Asahi Lina <lina@asahilina.net>
> >> > [ om:
> >> >   - split code into separate file and `pub use` it from types.rs
> >> >   - make from_raw() and into_raw() public
> >> >   - fixes to documentation and commit message
> >> > ]
> >> > Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> >> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> >> > ---
> >> >  rust/kernel/types.rs         |   7 +++
> >> >  rust/kernel/types/ownable.rs | 134 ++++++++++++++++++++++++++++++++=
+++++++++++
> >>
> >> I think we should name this file `owned.rs` instead. It's also what
> >> we'll have for `ARef` when that is moved to `sync/`.
> >>
> >> Also, I do wonder does this really belong into the `types` module? I
> >> feel like it's becoming our `utils` module and while it does fit, I
> >> think we should just make this a top level module. So
> >> `rust/kernel/owned.rs`. Thoughts?
> >
> > I don't have much of an opinion on on that. But maybe refactoring types=
.rs
> > should be an independent task?
>=20
> But you're adding the new file there? Just add it under
> `rust/kernel/owned.rs` instead.

To be honest, I don't really mind.

Note, though, that I already moved it from types.rs to types/ownable.rs on
request. It seems to me different people here have different ideas where it
should be placed. I feel now, that it would make sense to come to an
agreement between the interested parties about where it should finally be
placed, before I move it again. Could I ask that we settle that question
once and for all before my next revision?

> >> > +/// - It is safe to call [`core::mem::swap`] on the [`Ownable`]. Th=
is excludes pinned types
> >> > +///   (i.e. most kernel types).
> >>
> >> Can't we implicitly pin `Owned`?
> >
> > I have been thinking about that. But this would mean that the blanket
> > implementation for `Deref` would conflict with the one for `OwnableMut`=
.
>=20
> Yeah we could not implement `DerefMut` in that case (or only for `T:
> Unpin`).
>=20
> >> > +/// - The kernel will never access the underlying object (excluding=
 internal mutability that follows
> >> > +///   the usual rules) while Rust owns it.
> >> > +pub unsafe trait OwnableMut: Ownable {}
> >> > +
> >> > +/// An owned reference to an ownable kernel object.
> >>
> >> How about
> >>
> >>     An owned `T`.
> >
> >     A wrapper around `T`.
> >
> > maybe?
>=20
> "wrapper" seems wrong, since a wrapper in my mind is a newtype. So it
> would be `struct Owned(T)` which is wrong. The `T` is stored elsewhere.
>=20
> >> > +///
> >> > +/// The object is automatically freed or released when an instance =
of [`Owned`] is
> >> > +/// dropped.
> >>
> >> I don't think we need to say this, I always assume this for all Rust
> >> types except they document otherwise (eg `ManuallyDrop`, `MaybeUninit`
> >> and thus also `Opaque`.)
> >
> > Hmm, it is an important feature of the wrapper that it turns the `*Owna=
ble`
> > into an object that is automatically dropped. So shouldn't that be
> > mentioned here?
>=20
> I would expect that that happens, but sure we can leave it here.
>=20
> >> How about we provide some examples here?
> >>
> >> > +///
> >> > +/// # Invariants
> >> > +///
> >> > +/// The pointer stored in `ptr` can be considered owned by the [`Ow=
ned`] instance.
> >>
> >> What exactly is "owned" supposed to mean? It depends on the concrete `=
T`
> >> and that isn't well-defined (since it's a generic)...
> >
> > "owned" means that access to the `T` is exclusive through the `Owned<T>=
`,
> > so normal Rust semantics can be applied.
>=20
> Okay, in that case just say that `ptr` has exclusive access.

Or, ehm, sorry, I forgot, ownership also implies that the allocation of the
underlying resource/object is now under the responsibility of the owner,
i.e. the owner should free it at the appropriate time.

In short, just the standard meaning of ownership in Rust.

https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html

> >> Maybe we should give `Ownable` the task to document the exact ownershi=
p
> >> semantics of `T`?
> >>
> >> > +pub struct Owned<T: Ownable> {
> >> > +    ptr: NonNull<T>,
> >> > +    _p: PhantomData<T>,
> >> > +}
> >> > +
> >> > +// SAFETY: It is safe to send `Owned<T>` to another thread when the=
 underlying `T` is `Send` because
> >> > +// it effectively means sending a `&mut T` (which is safe because `=
T` is `Send`).
> >>
> >> How does this amount to sending a `&mut T`?
> >
> > Good point. That documentation hasn't been updated since `&mut T` acces=
s
> > has been split out into `OwnableMut`. Not sure how to phrase it now.
>=20
> I'm also unsure, also for the correct trait bounds on this impl.
>=20
> ---
> Cheers,
> Benno
>=20
> >> I guess this also needs to be guaranteed by `Owned::from_raw`... ah th=
e
> >> list grows...
> >>
> >> I'll try to come up with something to simplify this design a bit wrt t=
he
> >> safety docs.
> >>
> >> > +unsafe impl<T: Ownable + Send> Send for Owned<T> {}
> >> > +
> >> > +// SAFETY: It is safe to send `&Owned<T>` to another thread when th=
e underlying `T` is `Sync`
> >> > +// because it effectively means sharing `&T` (which is safe because=
 `T` is `Sync`).
> >>
> >> Same here.
> >>
> >> > +unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}


