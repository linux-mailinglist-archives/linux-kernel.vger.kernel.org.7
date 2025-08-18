Return-Path: <linux-kernel+bounces-773637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDD5B2A378
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AB418A181D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D7D31E105;
	Mon, 18 Aug 2025 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="C2R5O80o"
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C431B13E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522254; cv=none; b=Zgrs05IFXAoSwsTWc6PQJm7mpUuN4y13ObHQZTj7IEpXdjRRSbaBgUth8y5uYYmt9UXprnBCYsDAaUw7D5YWqBR6dPxdcxeOhum290l+0tI8PKaK4O9v5ShNaSgORHfDdDfEGTDXZFw0G4DunP2VLOkvwGYJiHEkvLnnV0JvRcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522254; c=relaxed/simple;
	bh=ovtw76AST8X0yEqX9EV8DDMSo4gT4mWdbUggDhpSdYM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2peGOL+ZEtVV/6p8f9UIqMPuKU3FvvswXVH9m/U3C95nrpkVdf/X/ML7Lt0nIZ/0zRyTHkCiquTHvvdOW+nYCGyKeVhJCCBo1Ygi2c2s9U2xgyZO3BXR1yUDXAp5f7bI6IAFJ0tui/c7KVlMXl1O5KdRKCrpdSpb4xmKngqm/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=C2R5O80o; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1755522250; x=1755781450;
	bh=DZvjTHaI8k6zlVcmqY/Yl0UN/uJQddBW9hhcPGqy7lM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=C2R5O80oCDt8PRIygEWYCtwRxRXhs7JFy3JxROn8ajpuc394Abb+NMIZi4EIL4LPm
	 9X2LfztlQkt58jXi/HoPonegblL5W7qOOJh6ffrx+7AVVHUBE598eFrdjiXcMj79g7
	 aBQ7qye3x7vGAmmEROfRPT0H+Lqh1NCFoOW1ym+34KVqome82NsLAZPVA2DHvDiBL0
	 RGDg9+hfUrwjbLVOvvQ2mkeLVkjp0GSxSxE1Ufa6sIui6JxDPFhYsqMst0siPoX1oL
	 Y1aJmJMtamSvLoPOFeo7ZGUxEZKy0xkineJ/sDsgXn1PfM2liLePyqEz8dfTXCXDus
	 xT5iRgxsbb7Fg==
Date: Mon, 18 Aug 2025 13:04:02 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
Message-ID: <aKMkvHAfDozzDjkB@mango>
In-Reply-To: <87o6scdchf.fsf@t14s.mail-host-address-is-not-set>
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me> <2OkNj7ab-vTaPaqMj_KRpIjaKTWgOW-F9Cn-CxnR12E6Dwg4lnjr6fx1vkjnoTx0boUeReeIVDbSyVFBWlYx7g==@protonmail.internalid> <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me> <87o6scdchf.fsf@t14s.mail-host-address-is-not-set>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: be97ba88dc5725431ec7c2111e29f76722a0897b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250818 1446, Andreas Hindborg wrote:
> "Oliver Mangold" <oliver.mangold@pm.me> writes:
>=20
> > From: Asahi Lina <lina+kernel@asahilina.net>
> >
> > By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
> > (typically C FFI) type that *may* be owned by Rust, but need not be. Un=
like
> > `AlwaysRefCounted`, this mechanism expects the reference to be unique
> > within Rust, and does not allow cloning.
> >
> > Conceptually, this is similar to a `KBox<T>`, except that it delegates
> > resource management to the `T` instead of using a generic allocator.
> >
> > Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@=
asahilina.net/
> > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > [ om:
> >   - split code into separate file and `pub use` it from types.rs
> >   - make from_raw() and into_raw() public
> >   - fixes to documentation and commit message
> > ]
> > Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/kernel/types.rs         |   7 +++
> >  rust/kernel/types/ownable.rs | 134 +++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 141 insertions(+)
> >
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index 22985b6f69820d6df8ff3aae0bf815fad36a9d92..c12ff4d2a3f2d79b760c34c=
0b84a51b507d0cfb1 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -11,6 +11,9 @@
> >  };
> >  use pin_init::{PinInit, Zeroable};
> >
> > +pub mod ownable;
> > +pub use ownable::{Ownable, OwnableMut, Owned};
> > +
> >  /// Used to transfer ownership to and from foreign (non-Rust) language=
s.
> >  ///
> >  /// Ownership is transferred from Rust to a foreign language by callin=
g [`Self::into_foreign`] and
> > @@ -425,6 +428,10 @@ pub const fn raw_get(this: *const Self) -> *mut T =
{
> >  /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) =
to create reference-counted
> >  /// instances of a type.
> >  ///
> > +/// Note: Implementing this trait allows types to be wrapped in an [`A=
Ref<Self>`]. It requires an
> > +/// internal reference count and provides only shared references. If u=
nique references are required
> > +/// [`Ownable`] should be implemented which allows types to be wrapped=
 in an [`Owned<Self>`].
> > +///
> >  /// # Safety
> >  ///
> >  /// Implementers must ensure that increments to the reference count ke=
ep the object alive in memory
> > diff --git a/rust/kernel/types/ownable.rs b/rust/kernel/types/ownable.r=
s
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..f4065a0d627a62d3ecb15ed=
abf306e9b812556e1
> > --- /dev/null
> > +++ b/rust/kernel/types/ownable.rs
> > @@ -0,0 +1,134 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Owned reference types.
> > +
> > +use core::{
> > +    marker::PhantomData,
> > +    mem::ManuallyDrop,
> > +    ops::{Deref, DerefMut},
> > +    ptr::NonNull,
> > +};
> > +
> > +/// Types that may be owned by Rust code or borrowed, but have a lifet=
ime managed by C code.
> > +///
> > +/// It allows such types to define their own custom destructor functio=
n to be called when a
> > +/// Rust-owned reference is dropped.
> > +///
> > +/// This is usually implemented by wrappers to existing structures on =
the C side of the code.
> > +///
> > +/// Note: Implementing this trait allows types to be wrapped in an [`O=
wned<Self>`]. This does not
> > +/// provide reference counting but represents a unique, owned referenc=
e. If reference counting is
> > +/// required [`AlwaysRefCounted`](crate::types::AlwaysRefCounted) shou=
ld be implemented which allows
> > +/// types to be wrapped in an [`ARef<Self>`](crate::types::ARef).
> > +///
> > +/// # Safety
> > +///
> > +/// Implementers must ensure that:
> > +/// - The [`release()`](Ownable::release) method leaves the underlying=
 object in a state which the
> > +///   kernel expects after ownership has been relinquished (i.e. no da=
ngling references in the
> > +///   kernel is case it frees the object, etc.).
> > +pub unsafe trait Ownable {
> > +    /// Releases the object (frees it or returns it to foreign ownersh=
ip).
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that:
> > +    /// - `this` points to a valid `Self`.
> > +    /// - The object is no longer referenced after this call.
> > +    unsafe fn release(this: NonNull<Self>);
> > +}
> > +
> > +/// Type where [`Owned<Self>`] derefs to `&mut Self`.
> > +///
> > +/// # Safety
> > +///
> > +/// Implementers must ensure that access to a `&mut T` is safe, implyi=
ng that:
> > +/// - It is safe to call [`core::mem::swap`] on the [`Ownable`]. This =
excludes pinned types
> > +///   (i.e. most kernel types).
> > +/// - The kernel will never access the underlying object (excluding in=
ternal mutability that follows
> > +///   the usual rules) while Rust owns it.
> > +pub unsafe trait OwnableMut: Ownable {}
> > +
> > +/// An owned reference to an ownable kernel object.
> > +///
> > +/// The object is automatically freed or released when an instance of =
[`Owned`] is
> > +/// dropped.
> > +///
> > +/// # Invariants
> > +///
> > +/// The pointer stored in `ptr` can be considered owned by the [`Owned=
`] instance.
> > +pub struct Owned<T: Ownable> {
> > +    ptr: NonNull<T>,
> > +    _p: PhantomData<T>,
> > +}
> > +
> > +// SAFETY: It is safe to send `Owned<T>` to another thread when the un=
derlying `T` is `Send` because
> > +// it effectively means sending a `&mut T` (which is safe because `T` =
is `Send`).
> > +unsafe impl<T: Ownable + Send> Send for Owned<T> {}
> > +
> > +// SAFETY: It is safe to send `&Owned<T>` to another thread when the u=
nderlying `T` is `Sync`
> > +// because it effectively means sharing `&T` (which is safe because `T=
` is `Sync`).
> > +unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}
> > +
> > +impl<T: Ownable> Owned<T> {
> > +    /// Creates a new instance of [`Owned`].
> > +    ///
> > +    /// It takes over ownership of the underlying object.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that:
> > +    /// - Ownership of the underlying object can be transferred to the=
 `Owned<T>` (i.e. operations
> > +    ///   which require ownership will be safe).
> > +    /// - No other Rust references to the underlying object exist. Thi=
s implies that the underlying
> > +    ///   object is not accessed through `ptr` anymore after the funct=
ion call (at least until the
> > +    ///   the `Owned<T>` is dropped).
> > +    /// - The C code follows the usual shared reference requirements. =
That is, the kernel will never
> > +    ///   mutate or free the underlying object (excluding interior mut=
ability that follows the usual
> > +    ///   rules) while Rust owns it.
> > +    /// - In case `T` implements [`OwnableMut`] the previous requireme=
nt is extended from shared to
> > +    ///   mutable reference requirements. That is, the kernel will not=
 mutate or free the underlying
> > +    ///   object and is okay with it being modified by Rust code.
> > +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> > +        // INVARIANT: The safety requirements guarantee that the new i=
nstance now owns the
> > +        // reference.
> > +        Self {
> > +            ptr,
> > +            _p: PhantomData,
> > +        }
> > +    }
> > +
> > +    /// Consumes the [`Owned`], returning a raw pointer.
> > +    ///
> > +    /// This function does not actually relinquish ownership of the ob=
ject. After calling this
> > +    /// function, the caller is responsible for ownership previously m=
anaged
> > +    /// by the [`Owned`].
> > +    pub fn into_raw(me: Self) -> NonNull<T> {
> > +        ManuallyDrop::new(me).ptr
> > +    }
> > +}
> > +
> > +impl<T: Ownable> Deref for Owned<T> {
> > +    type Target =3D T;
> > +
> > +    fn deref(&self) -> &Self::Target {
> > +        // SAFETY: The type invariants guarantee that the object is va=
lid.
> > +        unsafe { self.ptr.as_ref() }
> > +    }
> > +}
> > +
> > +impl<T: OwnableMut> DerefMut for Owned<T> {
> > +    fn deref_mut(&mut self) -> &mut Self::Target {
> > +        // SAFETY: The type invariants guarantee that the object is va=
lid, and that we can safely
> > +        // return a mutable reference to it.
> > +        unsafe { self.ptr.as_mut() }
> > +    }
> > +}
>=20
> I think someone mentioned this before, but handing out mutable
> references can be a problem if `T: !Unpin`. For instance, we don't want
> to hand out `&mut Page` in case of `Owned<Page>`.
>

That was the reason, why `OwnableMut` was introduced in the first place.
It's clear, I guess, that as-is it cannot be implemented on many classes.

> Could we do something like this:
>=20
>   diff --git a/rust/kernel/types/ownable.rs b/rust/kernel/types/ownable.r=
s
>   index 29729dc10cb4..52d21e41c26b 100644
>   --- a/rust/kernel/types/ownable.rs
>   +++ b/rust/kernel/types/ownable.rs
>   @@ -3,6 +3,7 @@
>   //! Owned reference types.
>=20
>   use crate::{
>   +    prelude::*,
>       sync::aref::{ARef, RefCounted},
>       types::ForeignOwnable,
>   };
>   @@ -112,6 +113,17 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>       pub fn into_raw(me: Self) -> NonNull<T> {
>           ManuallyDrop::new(me).ptr
>       }
>   +
>   +    /// Get a pinned mutable reference to the data owned by this `Owne=
d<T>`.
>   +    pub fn get_pin_mut(&mut self) -> Pin<&mut T> {
>   +        // SAFETY: The type invariants guarantee that the object is va=
lid, and that we can safely
>   +        // return a mutable reference to it.
>   +        let unpinned =3D unsafe { self.ptr.as_mut() };
>   +
>   +        // SAFETY: We never hand out unpinned mutable references to th=
e data in
>   +        // `Self`, unless the contained type is `Unpin`.
>   +        unsafe { Pin::new_unchecked(unpinned) }
>   +    }
>   }
>=20
>   impl<T: Ownable> Deref for Owned<T> {
>   @@ -123,7 +135,7 @@ fn deref(&self) -> &Self::Target {
>       }
>   }
>=20
>   -impl<T: OwnableMut> DerefMut for Owned<T> {
>   +impl<T: OwnableMut + Unpin> DerefMut for Owned<T> {
>       fn deref_mut(&mut self) -> &mut Self::Target {
>           // SAFETY: The type invariants guarantee that the object is val=
id, and that we can safely
>           // return a mutable reference to it.
>=20

Good question, I have been thinking about it, too. But it might
be, that it isn't needed at all. As I understand, usually Rust wrappers
are around non-movable C structs. Do we actually have a useful application
for OwnableMut?

Best,

Oliver


