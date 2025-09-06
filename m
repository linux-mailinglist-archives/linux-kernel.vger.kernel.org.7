Return-Path: <linux-kernel+bounces-804039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C198B46901
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9ED588DF6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68D726657B;
	Sat,  6 Sep 2025 04:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="ChcSFRnl"
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679A42451F3;
	Sat,  6 Sep 2025 04:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132731; cv=none; b=oBDDIIEOAkriq/YWrgnT03WJpYjiCZ/rcMioTwDAuBgvd45kqJ4flR1IU71/7AlESazJ4cSwNYYakkW8SH/URHX5yEbTtivc5RQH0R4EcqDpe2ERigEmY5nfAneq9GMRGViu3t+YHQWud3BSXIcybFB1UtC3VquYm4lFXVpHzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132731; c=relaxed/simple;
	bh=NQxELZxmtl7ERMWJ7nZFocEwI4dAL5Hp8likrziF1Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4QyDsKmv2/665RNerz4pYtXdhHyQjlfyHCKkL6jxyDF9yhBrdCRsFj/ZRkCywIcOrabGFHyecPW1Vn93J7xSEDAi+8358oujaUQH5l4VBU8ljog7dc2BwBckguPhJTwk9sqJD7uxkeWSzGd3gwpQzz2hDlQaz5zkXqS5KoJv8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=ChcSFRnl; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757132726; x=1757391926;
	bh=E5rYSvJf839wrbszCE+bgeDcd5/+NXS0locXZjL2WkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ChcSFRnl0DCFcPoMt0tZ0q93174latPA4JNGdqJgz00fPv8MDd79y5zKM9Ls+BKwm
	 V+BuhVuJZW7IB5Am1/wlA76E2/a8ZQhJWoQ8pSxO6zNZqJYivuXDXiLgjTyVf1p8mE
	 bJmX5AQq70imlTj+gx6KthHevvejckE/hHgKxZw9VZWmrkJqp7zeh89RRTp0Mbte9u
	 NSTxYvoov/A1GRA498TYfg9DolSwesfqJlcPBwVjPbWYOtAaK/zHqkfg1OmNk7OraM
	 39N0mR+mtMmhgK3+K/yFFGayo86LANDASFvUf3ZydMmZpAt/p2fkvTHSHN8FAbQS7Y
	 atd0vXp9ZKa/A==
X-Pm-Submission-Id: 4cJg9w3M8Tz2ScD7
Date: Sat, 6 Sep 2025 04:25:21 +0000
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
	Andreas Hindborg <a.hindborg@kernel.org>,
	Fiona Behrens <me@kloenk.dev>
Subject: Re: [PATCH 10/14] rust: implement `kernel::sync::Refcount`
Message-ID: <aLu3saVN2506n7NZ@archiso>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
 <20250905044141.77868-11-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-11-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:37PM -0700, Boqun Feng wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> This is a wrapping layer of `include/linux/refcount.h`. Currently the
> kernel refcount has already been used in `Arc`, however it calls into
> FFI directly.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> [boqun: Add the missing <> for the link in comment]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/r/20250723233312.3304339-2-gary@kernel.org
> ---
>  rust/helpers/refcount.c      | 10 ++++
>  rust/kernel/sync.rs          |  2 +
>  rust/kernel/sync/refcount.rs | 98 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 110 insertions(+)
>  create mode 100644 rust/kernel/sync/refcount.rs
> 
> diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
> index d6adbd2e45a1..d175898ad7b8 100644
> --- a/rust/helpers/refcount.c
> +++ b/rust/helpers/refcount.c
> @@ -7,11 +7,21 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
>  	return (refcount_t)REFCOUNT_INIT(n);
>  }
>  
> +void rust_helper_refcount_set(refcount_t *r, int n)
> +{
> +	refcount_set(r, n);
> +}
> +
>  void rust_helper_refcount_inc(refcount_t *r)
>  {
>  	refcount_inc(r);
>  }
>  
> +void rust_helper_refcount_dec(refcount_t *r)
> +{
> +	refcount_dec(r);
> +}
> +
>  bool rust_helper_refcount_dec_and_test(refcount_t *r)
>  {
>  	return refcount_dec_and_test(r);
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index bf8943c88a89..cf5b638a097d 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -19,6 +19,7 @@
>  mod locked_by;
>  pub mod poll;
>  pub mod rcu;
> +mod refcount;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use completion::Completion;
> @@ -27,6 +28,7 @@
>  pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
>  pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
>  pub use locked_by::LockedBy;
> +pub use refcount::Refcount;
>  
>  /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
>  #[repr(transparent)]
> diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
> new file mode 100644
> index 000000000000..cc1a80ae7ae9
> --- /dev/null
> +++ b/rust/kernel/sync/refcount.rs
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Atomic reference counting.
> +//!
> +//! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
> +
> +use crate::build_assert;
> +use crate::types::Opaque;
> +
> +/// Atomic reference counter.
> +///
> +/// This type is conceptually an atomic integer, but provides saturation semantics compared to
> +/// normal atomic integers. Values in the negative range when viewed as a signed integer are
> +/// saturation (bad) values. For details about the saturation semantics, please refer to top of
> +/// [`include/linux/refcount.h`](srctree/include/linux/refcount.h).
> +///
> +/// Wraps the kernel's C `refcount_t`.
> +#[repr(transparent)]
> +pub struct Refcount(Opaque<bindings::refcount_t>);
> +
> +impl Refcount {
> +    /// Construct a new [`Refcount`] from an initial value.
> +    ///
> +    /// The initial value should be non-saturated.
> +    #[inline]
> +    pub fn new(value: i32) -> Self {
> +        build_assert!(value >= 0, "initial value saturated");
> +        // SAFETY: There are no safety requirements for this FFI call.
> +        Self(Opaque::new(unsafe { bindings::REFCOUNT_INIT(value) }))
> +    }
> +
> +    #[inline]
> +    fn as_ptr(&self) -> *mut bindings::refcount_t {
> +        self.0.get()
> +    }
> +
> +    /// Set a refcount's value.
> +    #[inline]
> +    pub fn set(&self, value: i32) {
> +        // SAFETY: `self.as_ptr()` is valid.
> +        unsafe { bindings::refcount_set(self.as_ptr(), value) }
> +    }
> +
> +    /// Increment a refcount.
> +    ///
> +    /// It will saturate if overflows and `WARN`. It will also `WARN` if the refcount is 0, as this
> +    /// represents a possible use-after-free condition.
> +    ///
> +    /// Provides no memory ordering, it is assumed that caller already has a reference on the
> +    /// object.
> +    #[inline]
> +    pub fn inc(&self) {
> +        // SAFETY: self is valid.
> +        unsafe { bindings::refcount_inc(self.as_ptr()) }
> +    }
> +
> +    /// Decrement a refcount.
> +    ///
> +    /// It will `WARN` on underflow and fail to decrement when saturated.
> +    ///
> +    /// Provides release memory ordering, such that prior loads and stores are done
> +    /// before.
> +    #[inline]
> +    pub fn dec(&self) {
> +        // SAFETY: `self.as_ptr()` is valid.
> +        unsafe { bindings::refcount_dec(self.as_ptr()) }
> +    }
> +
> +    /// Decrement a refcount and test if it is 0.
> +    ///
> +    /// It will `WARN` on underflow and fail to decrement when saturated.
> +    ///
> +    /// Provides release memory ordering, such that prior loads and stores are done
> +    /// before, and provides an acquire ordering on success such that memory deallocation
> +    /// must come after.
> +    ///
> +    /// Returns true if the resulting refcount is 0, false otherwise.
> +    ///
> +    /// # Notes
> +    ///
> +    /// A common pattern of using `Refcount` is to free memory when the reference count reaches
> +    /// zero. This means that the reference to `Refcount` could become invalid after calling this
> +    /// function. This is fine as long as the reference to `Refcount` is no longer used when this
> +    /// function returns `false`. It is not necessary to use raw pointers in this scenario, see
> +    /// <https://github.com/rust-lang/rust/issues/55005>.
> +    #[inline]
> +    #[must_use = "use `dec` instead if you do not need to test if it is 0"]
> +    pub fn dec_and_test(&self) -> bool {
> +        // SAFETY: `self.as_ptr()` is valid.
> +        unsafe { bindings::refcount_dec_and_test(self.as_ptr()) }
> +    }
> +}
> +
> +// SAFETY: `refcount_t` is thread-safe.
> +unsafe impl Send for Refcount {}
> +
> +// SAFETY: `refcount_t` is thread-safe.
> +unsafe impl Sync for Refcount {}
> -- 
> 2.51.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

