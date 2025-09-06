Return-Path: <linux-kernel+bounces-804034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46DEB468F8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34C07C8D19
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6ED2676E9;
	Sat,  6 Sep 2025 04:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="SWkzuPQJ"
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F9D261594
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 04:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132616; cv=none; b=NNwhl5E8/GEIRiXhqLlvXO7WP65mVLcXlHlbjb6c5XwM1q+96l17O3IJuOoFus9fuUw5vlO2d6IsXDzzmpXSVT2etuAN2dvHQYWCV4tTaX6EgTdPWMEMhm+af9Mt99MbzpGEQfOx75btP8dVtNAqR0uAkVCuSrgvIcEJ8/SIN9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132616; c=relaxed/simple;
	bh=kyz6DDwj0aqxNYfSd6xOGLNF0/iRkjFKKjV5KIF6KQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/g05b7UeiZq2wJDuubfuMF/j3UJ9HF1MW53Zki2Kw9xpW+kj7s8vKwMiwktVx0whES+IzsxEzzV4+QLDwJXvFhqyTybHx0aHOVwd9+Fd6MeUxK3EryI0ZoF30SN5F6q9Aaf56DewQOirOKISsU6T58TQk4qtvyz4lxHCrjANos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=SWkzuPQJ; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757132612; x=1757391812;
	bh=4VU70ERqzg05NnLwKVEFpWOrZpZbKWfcuTLy8005LFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SWkzuPQJ6ENzMcl0F2TDncx0Kdf2MP7WKmH0FvXxtehPaK8Wzo0Jufmv4/K+fWFlE
	 iCyQ9YoJzKFhydltCLK3rmplKhR/SIr8hnupl81rDO8xysFnfOBHV8fV6xSzYUsqkZ
	 32H4x54G//DRWWepZfAzko9BH+MEVrihBxPUp6fsMsdAEu7fvT/iOvWzEVJDAFhvE1
	 /X/qkgcAzinDZp30Ar8Xe5sHO89on8So279lZSRruXDnHpwRbEwTmainW3tLd/4ogk
	 fu3VewQX5Bd34kZqg+2Wj9hzel3p6yZatX/3O016z642HYpK94SHcqMHghGU45Rq6z
	 81rhkobv3uczg==
X-Pm-Submission-Id: 4cJg7k0tblz2ScWl
Date: Sat, 6 Sep 2025 04:23:27 +0000
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
Subject: Re: [PATCH 05/14] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
Message-ID: <aLu3P7-eV9yCGziJ@archiso>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
 <20250905044141.77868-6-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-6-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:32PM -0700, Boqun Feng wrote:
> xchg() and cmpxchg() are basic operations on atomic. Provide these based
> on C APIs.
> 
> Note that cmpxchg() use the similar function signature as
> compare_exchange() in Rust std: returning a `Result`, `Ok(old)` means
> the operation succeeds and `Err(old)` means the operation fails.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/all/20250719030827.61357-6-boqun.feng@gmail.com/
> ---
>  rust/kernel/sync/atomic.rs | 168 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 167 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index ea5782b6ee95..4c32d12dc61e 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -25,7 +25,7 @@
>  pub use ordering::{Acquire, Full, Relaxed, Release};
>  
>  use crate::build_error;
> -use internal::{AtomicBasicOps, AtomicRepr};
> +use internal::{AtomicBasicOps, AtomicExchangeOps, AtomicRepr};
>  use ordering::OrderingType;
>  
>  /// A memory location which can be safely modified from multiple execution contexts.
> @@ -293,3 +293,169 @@ pub fn store<Ordering: ordering::ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
>          }
>      }
>  }
> +
> +impl<T: AtomicType> Atomic<T>
> +where
> +    T::Repr: AtomicExchangeOps,
> +{
> +    /// Atomic exchange.
> +    ///
> +    /// Atomically updates `*self` to `v` and returns the old value of `*self`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::sync::atomic::{Atomic, Acquire, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42);
> +    ///
> +    /// assert_eq!(42, x.xchg(52, Acquire));
> +    /// assert_eq!(52, x.load(Relaxed));
> +    /// ```
> +    #[doc(alias("atomic_xchg", "atomic64_xchg", "swap"))]
> +    #[inline(always)]
> +    pub fn xchg<Ordering: ordering::Ordering>(&self, v: T, _: Ordering) -> T {
> +        let v = into_repr(v);
> +
> +        // INVARIANT: `self.0` is a valid `T` after `atomic_xchg*()` because `v` is transmutable to
> +        // `T`.
> +        let ret = {
> +            match Ordering::TYPE {
> +                OrderingType::Full => T::Repr::atomic_xchg(&self.0, v),
> +                OrderingType::Acquire => T::Repr::atomic_xchg_acquire(&self.0, v),
> +                OrderingType::Release => T::Repr::atomic_xchg_release(&self.0, v),
> +                OrderingType::Relaxed => T::Repr::atomic_xchg_relaxed(&self.0, v),
> +            }
> +        };
> +
> +        // SAFETY: `ret` comes from reading `*self`, which is a valid `T` per type invariants.
> +        unsafe { from_repr(ret) }
> +    }
> +
> +    /// Atomic compare and exchange.
> +    ///
> +    /// If `*self` == `old`, atomically updates `*self` to `new`. Otherwise, `*self` is not
> +    /// modified.
> +    ///
> +    /// Compare: The comparison is done via the byte level comparison between `*self` and `old`.
> +    ///
> +    /// Ordering: When succeeds, provides the corresponding ordering as the `Ordering` type
> +    /// parameter indicates, and a failed one doesn't provide any ordering, the load part of a
> +    /// failed cmpxchg is a [`Relaxed`] load.
> +    ///
> +    /// Returns `Ok(value)` if cmpxchg succeeds, and `value` is guaranteed to be equal to `old`,
> +    /// otherwise returns `Err(value)`, and `value` is the current value of `*self`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::sync::atomic::{Atomic, Full, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42);
> +    ///
> +    /// // Checks whether cmpxchg succeeded.
> +    /// let success = x.cmpxchg(52, 64, Relaxed).is_ok();
> +    /// # assert!(!success);
> +    ///
> +    /// // Checks whether cmpxchg failed.
> +    /// let failure = x.cmpxchg(52, 64, Relaxed).is_err();
> +    /// # assert!(failure);
> +    ///
> +    /// // Uses the old value if failed, probably re-try cmpxchg.
> +    /// match x.cmpxchg(52, 64, Relaxed) {
> +    ///     Ok(_) => { },
> +    ///     Err(old) => {
> +    ///         // do something with `old`.
> +    ///         # assert_eq!(old, 42);
> +    ///     }
> +    /// }
> +    ///
> +    /// // Uses the latest value regardlessly, same as atomic_cmpxchg() in C.
> +    /// let latest = x.cmpxchg(42, 64, Full).unwrap_or_else(|old| old);
> +    /// # assert_eq!(42, latest);
> +    /// assert_eq!(64, x.load(Relaxed));
> +    /// ```
> +    ///
> +    /// [`Relaxed`]: ordering::Relaxed
> +    #[doc(alias(
> +        "atomic_cmpxchg",
> +        "atomic64_cmpxchg",
> +        "atomic_try_cmpxchg",
> +        "atomic64_try_cmpxchg",
> +        "compare_exchange"
> +    ))]
> +    #[inline(always)]
> +    pub fn cmpxchg<Ordering: ordering::Ordering>(
> +        &self,
> +        mut old: T,
> +        new: T,
> +        o: Ordering,
> +    ) -> Result<T, T> {
> +        // Note on code generation:
> +        //
> +        // try_cmpxchg() is used to implement cmpxchg(), and if the helper functions are inlined,
> +        // the compiler is able to figure out that branch is not needed if the users don't care
> +        // about whether the operation succeeds or not. One exception is on x86, due to commit
> +        // 44fe84459faf ("locking/atomic: Fix atomic_try_cmpxchg() semantics"), the
> +        // atomic_try_cmpxchg() on x86 has a branch even if the caller doesn't care about the
> +        // success of cmpxchg and only wants to use the old value. For example, for code like:
> +        //
> +        //     let latest = x.cmpxchg(42, 64, Full).unwrap_or_else(|old| old);
> +        //
> +        // It will still generate code:
> +        //
> +        //     movl    $0x40, %ecx
> +        //     movl    $0x34, %eax
> +        //     lock
> +        //     cmpxchgl        %ecx, 0x4(%rsp)
> +        //     jne     1f
> +        //     2:
> +        //     ...
> +        //     1:  movl    %eax, %ecx
> +        //     jmp 2b
> +        //
> +        // This might be "fixed" by introducing a try_cmpxchg_exclusive() that knows the "*old"
> +        // location in the C function is always safe to write.
> +        if self.try_cmpxchg(&mut old, new, o) {
> +            Ok(old)
> +        } else {
> +            Err(old)
> +        }
> +    }
> +
> +    /// Atomic compare and exchange and returns whether the operation succeeds.
> +    ///
> +    /// If `*self` == `old`, atomically updates `*self` to `new`. Otherwise, `*self` is not
> +    /// modified, `*old` is updated to the current value of `*self`.
> +    ///
> +    /// "Compare" and "Ordering" part are the same as [`Atomic::cmpxchg()`].
> +    ///
> +    /// Returns `true` means the cmpxchg succeeds otherwise returns `false`.
> +    #[inline(always)]
> +    fn try_cmpxchg<Ordering: ordering::Ordering>(&self, old: &mut T, new: T, _: Ordering) -> bool {
> +        let mut tmp = into_repr(*old);
> +        let new = into_repr(new);
> +
> +        // INVARIANT: `self.0` is a valid `T` after `atomic_try_cmpxchg*()` because `new` is
> +        // transmutable to `T`.
> +        let ret = {
> +            match Ordering::TYPE {
> +                OrderingType::Full => T::Repr::atomic_try_cmpxchg(&self.0, &mut tmp, new),
> +                OrderingType::Acquire => {
> +                    T::Repr::atomic_try_cmpxchg_acquire(&self.0, &mut tmp, new)
> +                }
> +                OrderingType::Release => {
> +                    T::Repr::atomic_try_cmpxchg_release(&self.0, &mut tmp, new)
> +                }
> +                OrderingType::Relaxed => {
> +                    T::Repr::atomic_try_cmpxchg_relaxed(&self.0, &mut tmp, new)
> +                }
> +            }
> +        };
> +
> +        // SAFETY: `tmp` comes from reading `*self`, which is a valid `T` per type invariants.
> +        *old = unsafe { from_repr(tmp) };
> +
> +        ret
> +    }
> +}
> -- 
> 2.51.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

