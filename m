Return-Path: <linux-kernel+bounces-804033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 355EDB468F7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05091C85278
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CF1266B6C;
	Sat,  6 Sep 2025 04:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="FeglAnNC"
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1D207DF3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 04:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132595; cv=none; b=n5g1mP8UF7C5ZgUf1OYhV/25OpKClpvci/pY5TM06LkihjEgjHqNcUpXBCZDLU0aZIuad4NsgxFna0Q8lacskzgkyuxoS6nuvQXKlKPRkDWwI+Vv+cy7IFzqFPTxNQzKV4suZ38CM/HNJnVlcEuFRytT1qHDginTkkOvpk4rerg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132595; c=relaxed/simple;
	bh=VRcthwiZ/Kgi4u9X5UHDVvgEs3pmxtChOpXs+uqYqnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYhTKUgUppMk6X11iL1GWbEjcT/KnHm4gydQxTJ8lIhG0bx82SlLI+rgtvcq7gbaZiLi16vBT1SJUDqAWCg75qH2axQ9u7TZgDUxcrbgkcJZuXIhAmuka35M97dRJsDP9+cBxuoOoG0Fpk5VCggThbhBt3OuMYVO2127CHYm1yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=FeglAnNC; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757132590; x=1757391790;
	bh=PvbD34szSEgeqc+KzaftMYOkMIJGVpeLd0A/rEswxXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FeglAnNCh4LsFIWCD2XgKrkkYrV19+WMjtjMy9mkPDNAhiiBBaVGt8ZK5JZ5V+oce
	 FsiCdINnIfMcbdp43F5gEHE9vA26kyYqXKMJC9PtEztyKP14TWTVz+t5A5+9KzcfGO
	 EV9FwUXZXMyiD225LEfPwTcJc4hq9nC0TVRwh84dpCsCbapJjsjw1okv7u0mH4pNlK
	 mT3zOuoyPmRghM3k8/U8IseRm8x9109XPbNEWmbb5Ez3tMPkv55+QAnIgWWlDfIC8y
	 5SEqOtZel7hFFGlyYENpAD/tjQC05yjIdqbsplSuaWPHfDbZKualhfdijwUwXfZLJw
	 9EjHbDxsVjdGQ==
X-Pm-Submission-Id: 4cJg7H59YFz2ScWl
Date: Sat, 6 Sep 2025 04:23:05 +0000
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
Subject: Re: [PATCH 04/14] rust: sync: atomic: Add generic atomics
Message-ID: <aLu3KcucNI6Jes3y@archiso>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
 <20250905044141.77868-5-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-5-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:31PM -0700, Boqun Feng wrote:
> To provide using LKMM atomics for Rust code, a generic `Atomic<T>` is
> added, currently `T` needs to be Send + Copy because these are the
> straightforward usages and all basic types support this.
> 
> Implement `AtomicType` for `i32` and `i64`, and so far only basic
> operations load() and store() are introduced.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/all/20250719030827.61357-5-boqun.feng@gmail.com/
> ---
>  rust/kernel/sync/atomic.rs           | 271 +++++++++++++++++++++++++++
>  rust/kernel/sync/atomic/predefine.rs |  15 ++
>  2 files changed, 286 insertions(+)
>  create mode 100644 rust/kernel/sync/atomic/predefine.rs
> 
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index 2302e6d51fe2..ea5782b6ee95 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -19,6 +19,277 @@
>  #[allow(dead_code, unreachable_pub)]
>  mod internal;
>  pub mod ordering;
> +mod predefine;
>  
>  pub use internal::AtomicImpl;
>  pub use ordering::{Acquire, Full, Relaxed, Release};
> +
> +use crate::build_error;
> +use internal::{AtomicBasicOps, AtomicRepr};
> +use ordering::OrderingType;
> +
> +/// A memory location which can be safely modified from multiple execution contexts.
> +///
> +/// This has the same size, alignment and bit validity as the underlying type `T`. And it disables
> +/// niche optimization for the same reason as [`UnsafeCell`].
> +///
> +/// The atomic operations are implemented in a way that is fully compatible with the [Linux Kernel
> +/// Memory (Consistency) Model][LKMM], hence they should be modeled as the corresponding
> +/// [`LKMM`][LKMM] atomic primitives. With the help of [`Atomic::from_ptr()`] and
> +/// [`Atomic::as_ptr()`], this provides a way to interact with [C-side atomic operations]
> +/// (including those without the `atomic` prefix, e.g. `READ_ONCE()`, `WRITE_ONCE()`,
> +/// `smp_load_acquire()` and `smp_store_release()`).
> +///
> +/// # Invariants
> +///
> +/// `self.0` is a valid `T`.
> +///
> +/// [`UnsafeCell`]: core::cell::UnsafeCell
> +/// [LKMM]: srctree/tools/memory-model/
> +/// [C-side atomic operations]: srctree/Documentation/atomic_t.txt
> +#[repr(transparent)]
> +pub struct Atomic<T: AtomicType>(AtomicRepr<T::Repr>);
> +
> +// SAFETY: `Atomic<T>` is safe to share among execution contexts because all accesses are atomic.
> +unsafe impl<T: AtomicType> Sync for Atomic<T> {}
> +
> +/// Types that support basic atomic operations.
> +///
> +/// # Round-trip transmutability
> +///
> +/// `T` is round-trip transmutable to `U` if and only if both of these properties hold:
> +///
> +/// - Any valid bit pattern for `T` is also a valid bit pattern for `U`.
> +/// - Transmuting (e.g. using [`transmute()`]) a value of type `T` to `U` and then to `T` again
> +///   yields a value that is in all aspects equivalent to the original value.
> +///
> +/// # Safety
> +///
> +/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
> +/// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
> +///
> +/// Note that this is more relaxed than requiring the bi-directional transmutability (i.e.
> +/// [`transmute()`] is always sound between `U` and `T`) because of the support for atomic
> +/// variables over unit-only enums, see [Examples].
> +///
> +/// # Limitations
> +///
> +/// Because C primitives are used to implement the atomic operations, and a C function requires a
> +/// valid object of a type to operate on (i.e. no `MaybeUninit<_>`), hence at the Rust <-> C
> +/// surface, only types with all the bits initialized can be passed. As a result, types like `(u8,
> +/// u16)` (padding bytes are uninitialized) are currently not supported.
> +///
> +/// # Examples
> +///
> +/// A unit-only enum that implements [`AtomicType`]:
> +///
> +/// ```
> +/// use kernel::sync::atomic::{AtomicType, Atomic, Relaxed};
> +///
> +/// #[derive(Clone, Copy, PartialEq, Eq)]
> +/// #[repr(i32)]
> +/// enum State {
> +///     Uninit = 0,
> +///     Working = 1,
> +///     Done = 2,
> +/// };
> +///
> +/// // SAFETY: `State` and `i32` has the same size and alignment, and it's round-trip
> +/// // transmutable to `i32`.
> +/// unsafe impl AtomicType for State {
> +///     type Repr = i32;
> +/// }
> +///
> +/// let s = Atomic::new(State::Uninit);
> +///
> +/// assert_eq!(State::Uninit, s.load(Relaxed));
> +/// ```
> +/// [`transmute()`]: core::mem::transmute
> +/// [round-trip transmutable]: AtomicType#round-trip-transmutability
> +/// [Examples]: AtomicType#examples
> +pub unsafe trait AtomicType: Sized + Send + Copy {
> +    /// The backing atomic implementation type.
> +    type Repr: AtomicImpl;
> +}
> +
> +#[inline(always)]
> +const fn into_repr<T: AtomicType>(v: T) -> T::Repr {
> +    // SAFETY: Per the safety requirement of `AtomicType`, `T` is round-trip transmutable to
> +    // `T::Repr`, therefore the transmute operation is sound.
> +    unsafe { core::mem::transmute_copy(&v) }
> +}
> +
> +/// # Safety
> +///
> +/// `r` must be a valid bit pattern of `T`.
> +#[inline(always)]
> +const unsafe fn from_repr<T: AtomicType>(r: T::Repr) -> T {
> +    // SAFETY: Per the safety requirement of the function, the transmute operation is sound.
> +    unsafe { core::mem::transmute_copy(&r) }
> +}
> +
> +impl<T: AtomicType> Atomic<T> {
> +    /// Creates a new atomic `T`.
> +    pub const fn new(v: T) -> Self {
> +        // INVARIANT: Per the safety requirement of `AtomicType`, `into_repr(v)` is a valid `T`.
> +        Self(AtomicRepr::new(into_repr(v)))
> +    }
> +
> +    /// Creates a reference to an atomic `T` from a pointer of `T`.
> +    ///
> +    /// This usually is used when communicating with C side or manipulating a C struct, see
> +    /// examples below.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `ptr` is aligned to `align_of::<T>()`.
> +    /// - `ptr` is valid for reads and writes for `'a`.
> +    /// - For the duration of `'a`, other accesses to `*ptr` must not cause data races (defined
> +    ///   by [`LKMM`]) against atomic operations on the returned reference. Note that if all other
> +    ///   accesses are atomic, then this safety requirement is trivially fulfilled.
> +    ///
> +    /// [`LKMM`]: srctree/tools/memory-model
> +    ///
> +    /// # Examples
> +    ///
> +    /// Using [`Atomic::from_ptr()`] combined with [`Atomic::load()`] or [`Atomic::store()`] can
> +    /// achieve the same functionality as `READ_ONCE()`/`smp_load_acquire()` or
> +    /// `WRITE_ONCE()`/`smp_store_release()` in C side:
> +    ///
> +    /// ```
> +    /// # use kernel::types::Opaque;
> +    /// use kernel::sync::atomic::{Atomic, Relaxed, Release};
> +    ///
> +    /// // Assume there is a C struct `foo`.
> +    /// mod cbindings {
> +    ///     #[repr(C)]
> +    ///     pub(crate) struct foo {
> +    ///         pub(crate) a: i32,
> +    ///         pub(crate) b: i32
> +    ///     }
> +    /// }
> +    ///
> +    /// let tmp = Opaque::new(cbindings::foo { a: 1, b: 2 });
> +    ///
> +    /// // struct foo *foo_ptr = ..;
> +    /// let foo_ptr = tmp.get();
> +    ///
> +    /// // SAFETY: `foo_ptr` is valid, and `.a` is in bounds.
> +    /// let foo_a_ptr = unsafe { &raw mut (*foo_ptr).a };
> +    ///
> +    /// // a = READ_ONCE(foo_ptr->a);
> +    /// //
> +    /// // SAFETY: `foo_a_ptr` is valid for read, and all other accesses on it is atomic, so no
> +    /// // data race.
> +    /// let a = unsafe { Atomic::from_ptr(foo_a_ptr) }.load(Relaxed);
> +    /// # assert_eq!(a, 1);
> +    ///
> +    /// // smp_store_release(&foo_ptr->a, 2);
> +    /// //
> +    /// // SAFETY: `foo_a_ptr` is valid for writes, and all other accesses on it is atomic, so
> +    /// // no data race.
> +    /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
> +    /// ```
> +    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
> +    where
> +        T: Sync,
> +    {
> +        // CAST: `T` and `Atomic<T>` have the same size, alignment and bit validity.
> +        // SAFETY: Per function safety requirement, `ptr` is a valid pointer and the object will
> +        // live long enough. It's safe to return a `&Atomic<T>` because function safety requirement
> +        // guarantees other accesses won't cause data races.
> +        unsafe { &*ptr.cast::<Self>() }
> +    }
> +
> +    /// Returns a pointer to the underlying atomic `T`.
> +    ///
> +    /// Note that use of the return pointer must not cause data races defined by [`LKMM`].
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// The returned pointer is valid and properly aligned (i.e. aligned to [`align_of::<T>()`]).
> +    ///
> +    /// [`LKMM`]: srctree/tools/memory-model
> +    /// [`align_of::<T>()`]: core::mem::align_of
> +    pub const fn as_ptr(&self) -> *mut T {
> +        // GUARANTEE: Per the function guarantee of `AtomicRepr::as_ptr()`, the `self.0.as_ptr()`
> +        // must be a valid and properly aligned pointer for `T::Repr`, and per the safety guarantee
> +        // of `AtomicType`, it's a valid and properly aligned pointer of `T`.
> +        self.0.as_ptr().cast()
> +    }
> +
> +    /// Returns a mutable reference to the underlying atomic `T`.
> +    ///
> +    /// This is safe because the mutable reference of the atomic `T` guarantees exclusive access.
> +    pub fn get_mut(&mut self) -> &mut T {
> +        // CAST: `T` and `T::Repr` has the same size and alignment per the safety requirement of
> +        // `AtomicType`, and per the type invariants `self.0` is a valid `T`, therefore the casting
> +        // result is a valid pointer of `T`.
> +        // SAFETY: The pointer is valid per the CAST comment above, and the mutable reference
> +        // guarantees exclusive access.
> +        unsafe { &mut *self.0.as_ptr().cast() }
> +    }
> +}
> +
> +impl<T: AtomicType> Atomic<T>
> +where
> +    T::Repr: AtomicBasicOps,
> +{
> +    /// Loads the value from the atomic `T`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42i32);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// let x = Atomic::new(42i64);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    /// ```
> +    #[doc(alias("atomic_read", "atomic64_read"))]
> +    #[inline(always)]
> +    pub fn load<Ordering: ordering::AcquireOrRelaxed>(&self, _: Ordering) -> T {
> +        let v = {
> +            match Ordering::TYPE {
> +                OrderingType::Relaxed => T::Repr::atomic_read(&self.0),
> +                OrderingType::Acquire => T::Repr::atomic_read_acquire(&self.0),
> +                _ => build_error!("Wrong ordering"),
> +            }
> +        };
> +
> +        // SAFETY: `v` comes from reading `self.0`, which is a valid `T` per the type invariants.
> +        unsafe { from_repr(v) }
> +    }
> +
> +    /// Stores a value to the atomic `T`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42i32);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// x.store(43, Relaxed);
> +    ///
> +    /// assert_eq!(43, x.load(Relaxed));
> +    /// ```
> +    #[doc(alias("atomic_set", "atomic64_set"))]
> +    #[inline(always)]
> +    pub fn store<Ordering: ordering::ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
> +        let v = into_repr(v);
> +
> +        // INVARIANT: `v` is a valid `T`, and is stored to `self.0` by `atomic_set*()`.
> +        match Ordering::TYPE {
> +            OrderingType::Relaxed => T::Repr::atomic_set(&self.0, v),
> +            OrderingType::Release => T::Repr::atomic_set_release(&self.0, v),
> +            _ => build_error!("Wrong ordering"),
> +        }
> +    }
> +}
> diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
> new file mode 100644
> index 000000000000..33356deee952
> --- /dev/null
> +++ b/rust/kernel/sync/atomic/predefine.rs
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Pre-defined atomic types
> +
> +// SAFETY: `i32` has the same size and alignment with itself, and is round-trip transmutable to
> +// itself.
> +unsafe impl super::AtomicType for i32 {
> +    type Repr = i32;
> +}
> +
> +// SAFETY: `i64` has the same size and alignment with itself, and is round-trip transmutable to
> +// itself.
> +unsafe impl super::AtomicType for i64 {
> +    type Repr = i64;
> +}
> -- 
> 2.51.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

