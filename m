Return-Path: <linux-kernel+bounces-804035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEC5B468F9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7F0587FB0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED714266F00;
	Sat,  6 Sep 2025 04:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="IDu4ZBxa"
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531BD111BF;
	Sat,  6 Sep 2025 04:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132639; cv=none; b=f0lVnfCXefnGBMCM6EfNRyFJN3hj0kS1ZciyPfeG1rqglxSoPf4/HCN0ncz4mCKGM+0anLTwsEcO6qqRdlWDmTUjKCzAEprIWfrgvvf5vjOJ/bRULlR8st4sOsNfr6sOs5EJxg9Dlt/bDZQXviOwcC/VIFePAA5G1Uc4TSm/gVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132639; c=relaxed/simple;
	bh=Y5E9MLblc0DbIKjhkL0yfk/9eRnIqLD9oHWKhX2TX+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkdrDJXtCRSOZJaMSiqffrgxUJtkgySMvkaJhBIBmPCZi1/PHiy3rLA2kgkJIUBlUWBzWrpTtzEtKykXTPOGbrPtWFgRp+JQJmU2llv6WVPbqFWLlMoj4xx+162DIUYk8Jge8xGHk7v3TyktP4i5HhESZYxLiHoj4Lx9mBenSp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=IDu4ZBxa; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757132634; x=1757391834;
	bh=UKI/i5BwE5drO0Z5BnzqaNyhQEpkzUHtzUlJ0Xpbx/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IDu4ZBxacKPp8UDV8cPG8mP3u6KPX9/UZsxHAMo9gFlrVL4g/MQL8pMIaFFy4nJ7L
	 c0xT/B31WDJmVkkscGOHLR28S4d+cNEbArPJ62VOL6ZOyddvawPzdlyvW221gRJGFa
	 JxYQJdp2g2ILkSsWXwUEHGFPZjveUOjXLVhcP9nY7ma1dGuJv7BpHbQuzIOz5+CjC8
	 KPSUfS72tXHwH6t+mKnqu1kHfTpqA1PdsaLBPSZhiPic7wj9H+1F14ahOM7AMyPFrG
	 pCDyv3eprzvTGc3Tj9bWA5jumGVN4nPBHZjx4sYdxAsBosx4DPzL9J9fM45sxDsWBe
	 q2FKNPqOQeO6A==
X-Pm-Submission-Id: 4cJg8642m6z1DF4W
Date: Sat, 6 Sep 2025 04:23:47 +0000
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
Subject: Re: [PATCH 06/14] rust: sync: atomic: Add the framework of
 arithmetic operations
Message-ID: <aLu3U7T6Whasa2J-@archiso>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
 <20250905044141.77868-7-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-7-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:33PM -0700, Boqun Feng wrote:
> One important set of atomic operations is the arithmetic operations,
> i.e. add(), sub(), fetch_add(), add_return(), etc. However it may not
> make senses for all the types that `AtomicType` to have arithmetic
> operations, for example a `Foo(u32)` may not have a reasonable add() or
> sub(), plus subword types (`u8` and `u16`) currently don't have
> atomic arithmetic operations even on C side and might not have them in
> the future in Rust (because they are usually suboptimal on a few
> architecures). Therefore the plan is to add a few subtraits of
> `AtomicType` describing which types have and can do atomic arithemtic
> operations.
> 
> One trait `AtomicAdd` is added, and only add() and fetch_add() are
> added. The rest will be added in the future.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/all/20250719030827.61357-7-boqun.feng@gmail.com/
> ---
>  rust/kernel/sync/atomic.rs           | 94 +++++++++++++++++++++++++++-
>  rust/kernel/sync/atomic/predefine.rs | 14 +++++
>  2 files changed, 106 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index 4c32d12dc61e..016a6bcaf080 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -16,7 +16,6 @@
>  //!
>  //! [`LKMM`]: srctree/tools/memory-model/
>  
> -#[allow(dead_code, unreachable_pub)]
>  mod internal;
>  pub mod ordering;
>  mod predefine;
> @@ -25,7 +24,7 @@
>  pub use ordering::{Acquire, Full, Relaxed, Release};
>  
>  use crate::build_error;
> -use internal::{AtomicBasicOps, AtomicExchangeOps, AtomicRepr};
> +use internal::{AtomicArithmeticOps, AtomicBasicOps, AtomicExchangeOps, AtomicRepr};
>  use ordering::OrderingType;
>  
>  /// A memory location which can be safely modified from multiple execution contexts.
> @@ -112,6 +111,19 @@ pub unsafe trait AtomicType: Sized + Send + Copy {
>      type Repr: AtomicImpl;
>  }
>  
> +/// Types that support atomic add operations.
> +///
> +/// # Safety
> +///
> +// TODO: Properly defines `wrapping_add` in the following comment.
> +/// `wrapping_add` any value of type `Self::Repr::Delta` obtained by [`Self::rhs_into_delta()`] to
> +/// any value of type `Self::Repr` obtained through transmuting a value of type `Self` to must
> +/// yield a value with a bit pattern also valid for `Self`.
> +pub unsafe trait AtomicAdd<Rhs = Self>: AtomicType {
> +    /// Converts `Rhs` into the `Delta` type of the atomic implementation.
> +    fn rhs_into_delta(rhs: Rhs) -> <Self::Repr as AtomicImpl>::Delta;
> +}
> +
>  #[inline(always)]
>  const fn into_repr<T: AtomicType>(v: T) -> T::Repr {
>      // SAFETY: Per the safety requirement of `AtomicType`, `T` is round-trip transmutable to
> @@ -459,3 +471,81 @@ fn try_cmpxchg<Ordering: ordering::Ordering>(&self, old: &mut T, new: T, _: Orde
>          ret
>      }
>  }
> +
> +impl<T: AtomicType> Atomic<T>
> +where
> +    T::Repr: AtomicArithmeticOps,
> +{
> +    /// Atomic add.
> +    ///
> +    /// Atomically updates `*self` to `(*self).wrapping_add(v)`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// x.add(12, Relaxed);
> +    ///
> +    /// assert_eq!(54, x.load(Relaxed));
> +    /// ```
> +    #[inline(always)]
> +    pub fn add<Rhs>(&self, v: Rhs, _: ordering::Relaxed)
> +    where
> +        T: AtomicAdd<Rhs>,
> +    {
> +        let v = T::rhs_into_delta(v);
> +
> +        // INVARIANT: `self.0` is a valid `T` after `atomic_add()` due to safety requirement of
> +        // `AtomicAdd`.
> +        T::Repr::atomic_add(&self.0, v);
> +    }
> +
> +    /// Atomic fetch and add.
> +    ///
> +    /// Atomically updates `*self` to `(*self).wrapping_add(v)`, and returns the value of `*self`
> +    /// before the update.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::sync::atomic::{Atomic, Acquire, Full, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// assert_eq!(54, { x.fetch_add(12, Acquire); x.load(Relaxed) });
> +    ///
> +    /// let x = Atomic::new(42);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// assert_eq!(54, { x.fetch_add(12, Full); x.load(Relaxed) } );
> +    /// ```
> +    #[inline(always)]
> +    pub fn fetch_add<Rhs, Ordering: ordering::Ordering>(&self, v: Rhs, _: Ordering) -> T
> +    where
> +        T: AtomicAdd<Rhs>,
> +    {
> +        let v = T::rhs_into_delta(v);
> +
> +        // INVARIANT: `self.0` is a valid `T` after `atomic_fetch_add*()` due to safety requirement
> +        // of `AtomicAdd`.
> +        let ret = {
> +            match Ordering::TYPE {
> +                OrderingType::Full => T::Repr::atomic_fetch_add(&self.0, v),
> +                OrderingType::Acquire => T::Repr::atomic_fetch_add_acquire(&self.0, v),
> +                OrderingType::Release => T::Repr::atomic_fetch_add_release(&self.0, v),
> +                OrderingType::Relaxed => T::Repr::atomic_fetch_add_relaxed(&self.0, v),
> +            }
> +        };
> +
> +        // SAFETY: `ret` comes from reading `self.0`, which is a valid `T` per type invariants.
> +        unsafe { from_repr(ret) }
> +    }
> +}
> diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
> index 33356deee952..a6e5883be7cb 100644
> --- a/rust/kernel/sync/atomic/predefine.rs
> +++ b/rust/kernel/sync/atomic/predefine.rs
> @@ -8,8 +8,22 @@ unsafe impl super::AtomicType for i32 {
>      type Repr = i32;
>  }
>  
> +// SAFETY: The wrapping add result of two `i32`s is a valid `i32`.
> +unsafe impl super::AtomicAdd<i32> for i32 {
> +    fn rhs_into_delta(rhs: i32) -> i32 {
> +        rhs
> +    }
> +}
> +
>  // SAFETY: `i64` has the same size and alignment with itself, and is round-trip transmutable to
>  // itself.
>  unsafe impl super::AtomicType for i64 {
>      type Repr = i64;
>  }
> +
> +// SAFETY: The wrapping add result of two `i64`s is a valid `i64`.
> +unsafe impl super::AtomicAdd<i64> for i64 {
> +    fn rhs_into_delta(rhs: i64) -> i64 {
> +        rhs
> +    }
> +}
> -- 
> 2.51.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

