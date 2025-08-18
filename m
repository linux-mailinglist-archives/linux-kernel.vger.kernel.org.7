Return-Path: <linux-kernel+bounces-773598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE727B2A200
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A001E3B2972
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A8831AF24;
	Mon, 18 Aug 2025 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l92Zmez9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D73218DA;
	Mon, 18 Aug 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521174; cv=none; b=aZQQNbuPLc1AVq1vIkW4K1F+qMWDTgAM+4sr2+qRSViObly7a5xBRwylHjWHsYt8Cw+K7T7WJ4KlRmRDgWUUQt2n0+fpmLT9r6ZJaxpGSrurT4GWTTrq8wgXbHOVyOICPln8u1YIPaWjJ75CAVC6Egr1cGWOyMD5d9PN3hEg118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521174; c=relaxed/simple;
	bh=24WakrD9fixJlitRHi8Gn7rJ/IlnrJTZ5fFbAmLiezE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hibtDaha7sFMJRi+a3xI2t2bvfxxoJT+b/TGKnBtnek7d4Flb5BN8l3crkihF14vgv9COIqnKU3vCKRgPgmxR0YE0BJ2bXjd4X/TlEl2mKLl7FwQ6XwlwtVhmxOFmT0yzufeXCQkMFPJcmarpOyAZwPd76tB+qHnEHiQ+gUdvpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l92Zmez9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB80C4CEEB;
	Mon, 18 Aug 2025 12:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755521173;
	bh=24WakrD9fixJlitRHi8Gn7rJ/IlnrJTZ5fFbAmLiezE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=l92Zmez9tMbXAX42s/rK8pmChjhD5oFF1E9vV4ASffQeNHsgI+eKX5/0QDNkXlI78
	 rzbG+xVfVgF8jFCUEb+3sQeqwoaA+wd58Ve72FkzuERpCzPr3NkFX9UnC76bQFq7Em
	 9VpvST4VHDaatAvgh0/WaJ0GlFocXkM6Ygv0MYByrCAT+BW8bGPlOtE6RAyZRaEHFS
	 rMziECu1SYQgP28jC49I4WTxm00eyga5xAnr6MnUheMxaN0XhsyaKsqhFaiSHaV/r8
	 +1cHz8VfGnUjFkMLBYOZbhdo33m1JbkICKADCPGFXRuTfNHGcuGKtIqGolygioLcDA
	 AlZyUeGuc+H/g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Oliver Mangold <oliver.mangold@pm.me>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno
 Lossin <lossin@kernel.org>, Asahi Lina <lina+kernel@asahilina.net>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver
 Mangold <oliver.mangold@pm.me>
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
In-Reply-To: <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <2OkNj7ab-vTaPaqMj_KRpIjaKTWgOW-F9Cn-CxnR12E6Dwg4lnjr6fx1vkjnoTx0boUeReeIVDbSyVFBWlYx7g==@protonmail.internalid>
 <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
Date: Mon, 18 Aug 2025 14:46:04 +0200
Message-ID: <87o6scdchf.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Oliver Mangold" <oliver.mangold@pm.me> writes:

> From: Asahi Lina <lina+kernel@asahilina.net>
>
> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
> (typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
> `AlwaysRefCounted`, this mechanism expects the reference to be unique
> within Rust, and does not allow cloning.
>
> Conceptually, this is similar to a `KBox<T>`, except that it delegates
> resource management to the `T` instead of using a generic allocator.
>
> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ om:
>   - split code into separate file and `pub use` it from types.rs
>   - make from_raw() and into_raw() public
>   - fixes to documentation and commit message
> ]
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/types.rs         |   7 +++
>  rust/kernel/types/ownable.rs | 134 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 141 insertions(+)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 22985b6f69820d6df8ff3aae0bf815fad36a9d92..c12ff4d2a3f2d79b760c34c0b84a51b507d0cfb1 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -11,6 +11,9 @@
>  };
>  use pin_init::{PinInit, Zeroable};
>
> +pub mod ownable;
> +pub use ownable::{Ownable, OwnableMut, Owned};
> +
>  /// Used to transfer ownership to and from foreign (non-Rust) languages.
>  ///
>  /// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and
> @@ -425,6 +428,10 @@ pub const fn raw_get(this: *const Self) -> *mut T {
>  /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
>  /// instances of a type.
>  ///
> +/// Note: Implementing this trait allows types to be wrapped in an [`ARef<Self>`]. It requires an
> +/// internal reference count and provides only shared references. If unique references are required
> +/// [`Ownable`] should be implemented which allows types to be wrapped in an [`Owned<Self>`].
> +///
>  /// # Safety
>  ///
>  /// Implementers must ensure that increments to the reference count keep the object alive in memory
> diff --git a/rust/kernel/types/ownable.rs b/rust/kernel/types/ownable.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..f4065a0d627a62d3ecb15edabf306e9b812556e1
> --- /dev/null
> +++ b/rust/kernel/types/ownable.rs
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Owned reference types.
> +
> +use core::{
> +    marker::PhantomData,
> +    mem::ManuallyDrop,
> +    ops::{Deref, DerefMut},
> +    ptr::NonNull,
> +};
> +
> +/// Types that may be owned by Rust code or borrowed, but have a lifetime managed by C code.
> +///
> +/// It allows such types to define their own custom destructor function to be called when a
> +/// Rust-owned reference is dropped.
> +///
> +/// This is usually implemented by wrappers to existing structures on the C side of the code.
> +///
> +/// Note: Implementing this trait allows types to be wrapped in an [`Owned<Self>`]. This does not
> +/// provide reference counting but represents a unique, owned reference. If reference counting is
> +/// required [`AlwaysRefCounted`](crate::types::AlwaysRefCounted) should be implemented which allows
> +/// types to be wrapped in an [`ARef<Self>`](crate::types::ARef).
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that:
> +/// - The [`release()`](Ownable::release) method leaves the underlying object in a state which the
> +///   kernel expects after ownership has been relinquished (i.e. no dangling references in the
> +///   kernel is case it frees the object, etc.).
> +pub unsafe trait Ownable {
> +    /// Releases the object (frees it or returns it to foreign ownership).
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that:
> +    /// - `this` points to a valid `Self`.
> +    /// - The object is no longer referenced after this call.
> +    unsafe fn release(this: NonNull<Self>);
> +}
> +
> +/// Type where [`Owned<Self>`] derefs to `&mut Self`.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that access to a `&mut T` is safe, implying that:
> +/// - It is safe to call [`core::mem::swap`] on the [`Ownable`]. This excludes pinned types
> +///   (i.e. most kernel types).
> +/// - The kernel will never access the underlying object (excluding internal mutability that follows
> +///   the usual rules) while Rust owns it.
> +pub unsafe trait OwnableMut: Ownable {}
> +
> +/// An owned reference to an ownable kernel object.
> +///
> +/// The object is automatically freed or released when an instance of [`Owned`] is
> +/// dropped.
> +///
> +/// # Invariants
> +///
> +/// The pointer stored in `ptr` can be considered owned by the [`Owned`] instance.
> +pub struct Owned<T: Ownable> {
> +    ptr: NonNull<T>,
> +    _p: PhantomData<T>,
> +}
> +
> +// SAFETY: It is safe to send `Owned<T>` to another thread when the underlying `T` is `Send` because
> +// it effectively means sending a `&mut T` (which is safe because `T` is `Send`).
> +unsafe impl<T: Ownable + Send> Send for Owned<T> {}
> +
> +// SAFETY: It is safe to send `&Owned<T>` to another thread when the underlying `T` is `Sync`
> +// because it effectively means sharing `&T` (which is safe because `T` is `Sync`).
> +unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}
> +
> +impl<T: Ownable> Owned<T> {
> +    /// Creates a new instance of [`Owned`].
> +    ///
> +    /// It takes over ownership of the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that:
> +    /// - Ownership of the underlying object can be transferred to the `Owned<T>` (i.e. operations
> +    ///   which require ownership will be safe).
> +    /// - No other Rust references to the underlying object exist. This implies that the underlying
> +    ///   object is not accessed through `ptr` anymore after the function call (at least until the
> +    ///   the `Owned<T>` is dropped).
> +    /// - The C code follows the usual shared reference requirements. That is, the kernel will never
> +    ///   mutate or free the underlying object (excluding interior mutability that follows the usual
> +    ///   rules) while Rust owns it.
> +    /// - In case `T` implements [`OwnableMut`] the previous requirement is extended from shared to
> +    ///   mutable reference requirements. That is, the kernel will not mutate or free the underlying
> +    ///   object and is okay with it being modified by Rust code.
> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> +        // INVARIANT: The safety requirements guarantee that the new instance now owns the
> +        // reference.
> +        Self {
> +            ptr,
> +            _p: PhantomData,
> +        }
> +    }
> +
> +    /// Consumes the [`Owned`], returning a raw pointer.
> +    ///
> +    /// This function does not actually relinquish ownership of the object. After calling this
> +    /// function, the caller is responsible for ownership previously managed
> +    /// by the [`Owned`].
> +    pub fn into_raw(me: Self) -> NonNull<T> {
> +        ManuallyDrop::new(me).ptr
> +    }
> +}
> +
> +impl<T: Ownable> Deref for Owned<T> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is valid.
> +        unsafe { self.ptr.as_ref() }
> +    }
> +}
> +
> +impl<T: OwnableMut> DerefMut for Owned<T> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
> +        // return a mutable reference to it.
> +        unsafe { self.ptr.as_mut() }
> +    }
> +}

I think someone mentioned this before, but handing out mutable
references can be a problem if `T: !Unpin`. For instance, we don't want
to hand out `&mut Page` in case of `Owned<Page>`.

Could we do something like this:

  diff --git a/rust/kernel/types/ownable.rs b/rust/kernel/types/ownable.rs
  index 29729dc10cb4..52d21e41c26b 100644
  --- a/rust/kernel/types/ownable.rs
  +++ b/rust/kernel/types/ownable.rs
  @@ -3,6 +3,7 @@
  //! Owned reference types.

  use crate::{
  +    prelude::*,
      sync::aref::{ARef, RefCounted},
      types::ForeignOwnable,
  };
  @@ -112,6 +113,17 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
      pub fn into_raw(me: Self) -> NonNull<T> {
          ManuallyDrop::new(me).ptr
      }
  +
  +    /// Get a pinned mutable reference to the data owned by this `Owned<T>`.
  +    pub fn get_pin_mut(&mut self) -> Pin<&mut T> {
  +        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
  +        // return a mutable reference to it.
  +        let unpinned = unsafe { self.ptr.as_mut() };
  +
  +        // SAFETY: We never hand out unpinned mutable references to the data in
  +        // `Self`, unless the contained type is `Unpin`.
  +        unsafe { Pin::new_unchecked(unpinned) }
  +    }
  }

  impl<T: Ownable> Deref for Owned<T> {
  @@ -123,7 +135,7 @@ fn deref(&self) -> &Self::Target {
      }
  }

  -impl<T: OwnableMut> DerefMut for Owned<T> {
  +impl<T: OwnableMut + Unpin> DerefMut for Owned<T> {
      fn deref_mut(&mut self) -> &mut Self::Target {
          // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
          // return a mutable reference to it.


Best regards,
Andreas Hindborg



