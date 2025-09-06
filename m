Return-Path: <linux-kernel+bounces-804031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17084B468F5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8B61C8455B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE5D2673BE;
	Sat,  6 Sep 2025 04:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="X+ruerYm"
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D921260588;
	Sat,  6 Sep 2025 04:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132553; cv=none; b=FHBpoRQ7E7S1R9s+Nyfp1xIl2H2H6a9EB/8/lF0HeKSKwkybGEq0NRw5mDZ0UTd0Ee0SesjZksOLPdOMXZmWcBEIWWJEZQgJ4cG/UmNNkMFxLjXtnYscxKAXAW9ydfZ+ARZNP4gYYbImQzOVxZCiHbG1TG0IaYJZMjYLdoTsAXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132553; c=relaxed/simple;
	bh=2c9t2h21bwv/tWhjzVvLXN2PVQQrdXDuwLsOGZ5srs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7KqRjY/HFUsOrtuz96QVv+JqCrGqkIOtzF2G9js2LQmmTNz+P91Gj3GEV3K5lapJeeRiYpcRhc8NH+SZxUOB8u0fdqIwVuwJNV4YCMBaMb6lNUZI2Y12MtpIQXm/OVsj+cLGPxcwA40KUeDjDaZg2YgD8e7iTbfuUmH1GclDvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=X+ruerYm; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757132546; x=1757391746;
	bh=++JN76tJAqldoC1nOCXyVX8TaxJpU2hfhPuA89M2Rrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=X+ruerYmarIfFAyp85AB3GkTJYOxE6wQJnJceQ+D8fHTQXzS37hVwuPp7Unx/Fs8T
	 5oY2X8PGLr8yA0NUW5s7ADDJ4irU+hgMMEI7tiz6NxFAXVvDQ6mgLR+AS9Qtu3BnoF
	 4thURgDI+XtmTHa36foxE/fdOE+JGbDSBFmOfc6OfNqLkCBJGfrnxvUVBODVApcklE
	 +7tKnGj/w0DuxXKRJONl4dUABGoIqk5qyfjUc33k2+0XkQtN+0UXpO9wpR2vLcEJzM
	 zCoAycKcpSwD3mPKUGEue2aht4wmT1ppW4OqrBCwgMNVvHjKFvLNhuOhJl1RUXzRxf
	 Zpwji4vTpcO8g==
X-Pm-Submission-Id: 4cJg6S3n6Jz1DF4V
Date: Sat, 6 Sep 2025 04:22:21 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>, stern@rowland.harvard.edu,
	Miguel Ojeda <ojeda@kernel.org>, alex.gaynor@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH 02/14] rust: sync: Add basic atomic operation mapping
 framework
Message-ID: <aLu2_V00MUjg0aUV@archiso>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
 <20250905044141.77868-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-3-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:29PM -0700, Boqun Feng wrote:
> Preparation for generic atomic implementation. To unify the
> implementation of a generic method over `i32` and `i64`, the C side
> atomic methods need to be grouped so that in a generic method, they can
> be referred as <type>::<method>, otherwise their parameters and return
> value are different between `i32` and `i64`, which would require using
> `transmute()` to unify the type into a `T`.
> 
> Introduce `AtomicImpl` to represent a basic type in Rust that has the
> direct mapping to an atomic implementation from C. Use a sealed trait to
> restrict `AtomicImpl` to only support `i32` and `i64` for now.
> 
> Further, different methods are put into different `*Ops` trait groups,
> and this is for the future when smaller types like `i8`/`i16` are
> supported but only with a limited set of API (e.g. only set(), load(),
> xchg() and cmpxchg(), no add() or sub() etc).
> 
> While the atomic mod is introduced, documentation is also added for
> memory models and data races.
> 
> Also bump my role to the maintainer of ATOMIC INFRASTRUCTURE to reflect
> my responsibility on the Rust atomic mod.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/all/20250719030827.61357-3-boqun.feng@gmail.com/
> ---
>  MAINTAINERS                         |   4 +-
>  rust/kernel/sync.rs                 |   1 +
>  rust/kernel/sync/atomic.rs          |  22 +++
>  rust/kernel/sync/atomic/internal.rs | 265 ++++++++++++++++++++++++++++
>  4 files changed, 291 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/sync/atomic.rs
>  create mode 100644 rust/kernel/sync/atomic/internal.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index daf520a13bdf..37a753ec2aca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3989,7 +3989,7 @@ F:	drivers/input/touchscreen/atmel_mxt_ts.c
>  ATOMIC INFRASTRUCTURE
>  M:	Will Deacon <will@kernel.org>
>  M:	Peter Zijlstra <peterz@infradead.org>
> -R:	Boqun Feng <boqun.feng@gmail.com>
> +M:	Boqun Feng <boqun.feng@gmail.com>
>  R:	Mark Rutland <mark.rutland@arm.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
> @@ -3998,6 +3998,8 @@ F:	arch/*/include/asm/atomic*.h
>  F:	include/*/atomic*.h
>  F:	include/linux/refcount.h
>  F:	scripts/atomic/
> +F:	rust/kernel/sync/atomic.rs
> +F:	rust/kernel/sync/atomic/
>  
>  ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
>  M:	Bradley Grove <linuxdrivers@attotech.com>
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 00f9b558a3ad..7e962e5429d2 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -11,6 +11,7 @@
>  
>  mod arc;
>  pub mod aref;
> +pub mod atomic;
>  pub mod completion;
>  mod condvar;
>  pub mod lock;
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> new file mode 100644
> index 000000000000..b9f2f4780073
> --- /dev/null
> +++ b/rust/kernel/sync/atomic.rs
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Atomic primitives.
> +//!
> +//! These primitives have the same semantics as their C counterparts: and the precise definitions of
> +//! semantics can be found at [`LKMM`]. Note that Linux Kernel Memory (Consistency) Model is the
> +//! only model for Rust code in kernel, and Rust's own atomics should be avoided.
> +//!
> +//! # Data races
> +//!
> +//! [`LKMM`] atomics have different rules regarding data races:
> +//!
> +//! - A normal write from C side is treated as an atomic write if
> +//!   CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y.
> +//! - Mixed-size atomic accesses don't cause data races.
> +//!
> +//! [`LKMM`]: srctree/tools/memory-model/
> +
> +#[allow(dead_code, unreachable_pub)]
> +mod internal;
> +
> +pub use internal::AtomicImpl;
> diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
> new file mode 100644
> index 000000000000..6fdd8e59f45b
> --- /dev/null
> +++ b/rust/kernel/sync/atomic/internal.rs
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Atomic internal implementations.
> +//!
> +//! Provides 1:1 mapping to the C atomic operations.
> +
> +use crate::bindings;
> +use crate::macros::paste;
> +use core::cell::UnsafeCell;
> +
> +mod private {
> +    /// Sealed trait marker to disable customized impls on atomic implementation traits.
> +    pub trait Sealed {}
> +}
> +
> +// `i32` and `i64` are only supported atomic implementations.
> +impl private::Sealed for i32 {}
> +impl private::Sealed for i64 {}
> +
> +/// A marker trait for types that implement atomic operations with C side primitives.
> +///
> +/// This trait is sealed, and only types that have directly mapping to the C side atomics should
> +/// impl this:
> +///
> +/// - `i32` maps to `atomic_t`.
> +/// - `i64` maps to `atomic64_t`.
> +pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
> +    /// The type of the delta in arithmetic or logical operations.
> +    ///
> +    /// For example, in `atomic_add(ptr, v)`, it's the type of `v`. Usually it's the same type of
> +    /// [`Self`], but it may be different for the atomic pointer type.
> +    type Delta;
> +}
> +
> +// `atomic_t` implements atomic operations on `i32`.
> +impl AtomicImpl for i32 {
> +    type Delta = Self;
> +}
> +
> +// `atomic64_t` implements atomic operations on `i64`.
> +impl AtomicImpl for i64 {
> +    type Delta = Self;
> +}
> +
> +/// Atomic representation.
> +#[repr(transparent)]
> +pub struct AtomicRepr<T: AtomicImpl>(UnsafeCell<T>);
> +
> +impl<T: AtomicImpl> AtomicRepr<T> {
> +    /// Creates a new atomic representation `T`.
> +    pub const fn new(v: T) -> Self {
> +        Self(UnsafeCell::new(v))
> +    }
> +
> +    /// Returns a pointer to the underlying `T`.
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// The returned pointer is valid and properly aligned (i.e. aligned to [`align_of::<T>()`]).
> +    pub const fn as_ptr(&self) -> *mut T {
> +        // GUARANTEE: `self.0` is an `UnsafeCell<T>`, therefore the pointer returned by `.get()`
> +        // must be valid and properly aligned.
> +        self.0.get()
> +    }
> +}
> +
> +// This macro generates the function signature with given argument list and return type.
> +macro_rules! declare_atomic_method {
> +    (
> +        $(#[doc=$doc:expr])*
> +        $func:ident($($arg:ident : $arg_type:ty),*) $(-> $ret:ty)?
> +    ) => {
> +        paste!(
> +            $(#[doc = $doc])*
> +            fn [< atomic_ $func >]($($arg: $arg_type,)*) $(-> $ret)?;
> +        );
> +    };
> +    (
> +        $(#[doc=$doc:expr])*
> +        $func:ident [$variant:ident $($rest:ident)*]($($arg_sig:tt)*) $(-> $ret:ty)?
> +    ) => {
> +        paste!(
> +            declare_atomic_method!(
> +                $(#[doc = $doc])*
> +                [< $func _ $variant >]($($arg_sig)*) $(-> $ret)?
> +            );
> +        );
> +
> +        declare_atomic_method!(
> +            $(#[doc = $doc])*
> +            $func [$($rest)*]($($arg_sig)*) $(-> $ret)?
> +        );
> +    };
> +    (
> +        $(#[doc=$doc:expr])*
> +        $func:ident []($($arg_sig:tt)*) $(-> $ret:ty)?
> +    ) => {
> +        declare_atomic_method!(
> +            $(#[doc = $doc])*
> +            $func($($arg_sig)*) $(-> $ret)?
> +        );
> +    }
> +}
> +
> +// This macro generates the function implementation with given argument list and return type, and it
> +// will replace "call(...)" expression with "$ctype _ $func" to call the real C function.
> +macro_rules! impl_atomic_method {
> +    (
> +        ($ctype:ident) $func:ident($($arg:ident: $arg_type:ty),*) $(-> $ret:ty)? {
> +            $unsafe:tt { call($($c_arg:expr),*) }
> +        }
> +    ) => {
> +        paste!(
> +            #[inline(always)]
> +            fn [< atomic_ $func >]($($arg: $arg_type,)*) $(-> $ret)? {
> +                // TODO: Ideally we want to use the SAFETY comments written at the macro invocation
> +                // (e.g. in `declare_and_impl_atomic_methods!()`, however, since SAFETY comments
> +                // are just comments, and they are not passed to macros as tokens, therefore we
> +                // cannot use them here. One potential improvement is that if we support using
> +                // attributes as an alternative for SAFETY comments, then we can use that for macro
> +                // generating code.
> +                //
> +                // SAFETY: specified on macro invocation.
> +                $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
> +            }
> +        );
> +    };
> +    (
> +        ($ctype:ident) $func:ident[$variant:ident $($rest:ident)*]($($arg_sig:tt)*) $(-> $ret:ty)? {
> +            $unsafe:tt { call($($arg:tt)*) }
> +        }
> +    ) => {
> +        paste!(
> +            impl_atomic_method!(
> +                ($ctype) [< $func _ $variant >]($($arg_sig)*) $( -> $ret)? {
> +                    $unsafe { call($($arg)*) }
> +            }
> +            );
> +        );
> +        impl_atomic_method!(
> +            ($ctype) $func [$($rest)*]($($arg_sig)*) $( -> $ret)? {
> +                $unsafe { call($($arg)*) }
> +            }
> +        );
> +    };
> +    (
> +        ($ctype:ident) $func:ident[]($($arg_sig:tt)*) $( -> $ret:ty)? {
> +            $unsafe:tt { call($($arg:tt)*) }
> +        }
> +    ) => {
> +        impl_atomic_method!(
> +            ($ctype) $func($($arg_sig)*) $(-> $ret)? {
> +                $unsafe { call($($arg)*) }
> +            }
> +        );
> +    }
> +}
> +
> +// Delcares $ops trait with methods and implements the trait for `i32` and `i64`.
> +macro_rules! declare_and_impl_atomic_methods {
> +    ($(#[$attr:meta])* $pub:vis trait $ops:ident {
> +        $(
> +            $(#[doc=$doc:expr])*
> +            fn $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> $ret:ty)? {
> +                $unsafe:tt { bindings::#call($($arg:tt)*) }
> +            }
> +        )*
> +    }) => {
> +        $(#[$attr])*
> +        $pub trait $ops: AtomicImpl {
> +            $(
> +                declare_atomic_method!(
> +                    $(#[doc=$doc])*
> +                    $func[$($variant)*]($($arg_sig)*) $(-> $ret)?
> +                );
> +            )*
> +        }
> +
> +        impl $ops for i32 {
> +            $(
> +                impl_atomic_method!(
> +                    (atomic) $func[$($variant)*]($($arg_sig)*) $(-> $ret)? {
> +                        $unsafe { call($($arg)*) }
> +                    }
> +                );
> +            )*
> +        }
> +
> +        impl $ops for i64 {
> +            $(
> +                impl_atomic_method!(
> +                    (atomic64) $func[$($variant)*]($($arg_sig)*) $(-> $ret)? {
> +                        $unsafe { call($($arg)*) }
> +                    }
> +                );
> +            )*
> +        }
> +    }
> +}
> +
> +declare_and_impl_atomic_methods!(
> +    /// Basic atomic operations
> +    pub trait AtomicBasicOps {
> +        /// Atomic read (load).
> +        fn read[acquire](a: &AtomicRepr<Self>) -> Self {
> +            // SAFETY: `a.as_ptr()` is valid and properly aligned.
> +            unsafe { bindings::#call(a.as_ptr().cast()) }
> +        }
> +
> +        /// Atomic set (store).
> +        fn set[release](a: &AtomicRepr<Self>, v: Self) {
> +            // SAFETY: `a.as_ptr()` is valid and properly aligned.
> +            unsafe { bindings::#call(a.as_ptr().cast(), v) }
> +        }
> +    }
> +);
> +
> +declare_and_impl_atomic_methods!(
> +    /// Exchange and compare-and-exchange atomic operations
> +    pub trait AtomicExchangeOps {
> +        /// Atomic exchange.
> +        ///
> +        /// Atomically updates `*a` to `v` and returns the old value.
> +        fn xchg[acquire, release, relaxed](a: &AtomicRepr<Self>, v: Self) -> Self {
> +            // SAFETY: `a.as_ptr()` is valid and properly aligned.
> +            unsafe { bindings::#call(a.as_ptr().cast(), v) }
> +        }
> +
> +        /// Atomic compare and exchange.
> +        ///
> +        /// If `*a` == `*old`, atomically updates `*a` to `new`. Otherwise, `*a` is not
> +        /// modified, `*old` is updated to the current value of `*a`.
> +        ///
> +        /// Return `true` if the update of `*a` occurred, `false` otherwise.
> +        fn try_cmpxchg[acquire, release, relaxed](
> +            a: &AtomicRepr<Self>, old: &mut Self, new: Self
> +        ) -> bool {
> +            // SAFETY: `a.as_ptr()` is valid and properly aligned. `core::ptr::from_mut(old)`
> +            // is valid and properly aligned.
> +            unsafe { bindings::#call(a.as_ptr().cast(), core::ptr::from_mut(old), new) }
> +        }
> +    }
> +);
> +
> +declare_and_impl_atomic_methods!(
> +    /// Atomic arithmetic operations
> +    pub trait AtomicArithmeticOps {
> +        /// Atomic add (wrapping).
> +        ///
> +        /// Atomically updates `*a` to `(*a).wrapping_add(v)`.
> +        fn add[](a: &AtomicRepr<Self>, v: Self::Delta) {
> +            // SAFETY: `a.as_ptr()` is valid and properly aligned.
> +            unsafe { bindings::#call(v, a.as_ptr().cast()) }
> +        }
> +
> +        /// Atomic fetch and add (wrapping).
> +        ///
> +        /// Atomically updates `*a` to `(*a).wrapping_add(v)`, and returns the value of `*a`
> +        /// before the update.
> +        fn fetch_add[acquire, release, relaxed](a: &AtomicRepr<Self>, v: Self::Delta) -> Self {
> +            // SAFETY: `a.as_ptr()` is valid and properly aligned.
> +            unsafe { bindings::#call(v, a.as_ptr().cast()) }
> +        }
> +    }
> +);
> -- 
> 2.51.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

