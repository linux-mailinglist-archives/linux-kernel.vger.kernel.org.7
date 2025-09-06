Return-Path: <linux-kernel+bounces-804042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95875B46904
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDEAAA558E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED6F207DF3;
	Sat,  6 Sep 2025 04:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="MHb6aEuL"
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E6922F177;
	Sat,  6 Sep 2025 04:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132787; cv=none; b=FJvoxRrpf/MTA9jCuluhwG7CfHDhRMBeKK8diDv1LC6pXkt/miTZXgRKRE5VBJmD1NQH4iPWXcMSP9E2Yh30ey2FaLjK0rv1hGketU4BB9rbL/1tVyH1OYEieQ42dNPHC77Fw4C7sZqP6Pq/6DUzUgr8udm6v3/erOAK5HmDf6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132787; c=relaxed/simple;
	bh=CRU5oRwHMTJ4V//E/aAjckw5vRW3Vcskwmfd4PsbaTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvW1W/g2IReLLOLznbXRnGdv86uPalbogbVt88Gi+oFp/N8iULm7SZqTYLzVxFgwPc3MNe5ZIWUztE9CkUj5jpjEzKi19vR0zSalekPKULtshogJDx/OPA0/MQOSbu3zs/bd61ILbBzz9iufk3HBSjgC2u9hy61oq9+KZouRW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=MHb6aEuL; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757132783; x=1757391983;
	bh=4V6xqKVmAKOXOZ07BR1qTz74/ZH1hY7kYx8aEsbPyNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MHb6aEuLLpNSl/9pS5SYVbkegCnatDuPhHjppBcfwD5g560SUc/CUAmWILG5qHCCm
	 yuwWKGVys4+Wf88w5ru0YfftoO8YBLj/w/tFu9alwTG3VkI1jdWqvOu35GiqAbVXsP
	 UjZ8pmoXK05DiQkcRs0lvqQUqCYW4u17rRHD01WZuoMc2mlTLk5LuzKp758fNAk4EB
	 dKfuHZ7GGQaXooIZLp+mUI2B81BGi9LI69wfXZr9twlZio2Kzk/MkBBUOV993HySN3
	 a9qbw8xuN/YqhYEmKPcBZO8NIV2FrKSmPbU8fHSd9U7wtOQV7x4IVDi2Q9xIVlkpVs
	 /iWsTIStbdjcw==
X-Pm-Submission-Id: 4cJgC05YmNz2ScWl
Date: Sat, 6 Sep 2025 04:26:17 +0000
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
	David Gow <davidgow@google.com>
Subject: Re: [PATCH 13/14] rust: block: convert `block::mq` to use `Refcount`
Message-ID: <aLu36T1A8hFwgxI1@archiso>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
 <20250905044141.77868-14-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-14-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:40PM -0700, Boqun Feng wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> Currently there's a custom reference counting in `block::mq`, which uses
> `AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
> architectures. We cannot just change it to use 32-bit atomics, because
> doing so will make it vulnerable to refcount overflow. So switch it to
> use the kernel refcount `kernel::sync::Refcount` instead.
> 
> There is an operation needed by `block::mq`, atomically decreasing
> refcount from 2 to 0, which is not available through refcount.h, so
> I exposed `Refcount::as_atomic` which allows accessing the refcount
> directly.
> 
> Tested-by: David Gow <davidgow@google.com>
> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> [boqun: Adopt the LKMM atomic API]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/r/20250723233312.3304339-5-gary@kernel.org
> ---
>  rust/kernel/block/mq/operations.rs |  7 +--
>  rust/kernel/block/mq/request.rs    | 73 +++++++++---------------------
>  rust/kernel/sync/refcount.rs       | 15 ++++++
>  3 files changed, 40 insertions(+), 55 deletions(-)
> 
> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
> index c2b98f507bcb..c0f95a9419c4 100644
> --- a/rust/kernel/block/mq/operations.rs
> +++ b/rust/kernel/block/mq/operations.rs
> @@ -10,9 +10,10 @@
>      block::mq::Request,
>      error::{from_result, Result},
>      prelude::*,
> +    sync::Refcount,
>      types::ARef,
>  };
> -use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
> +use core::marker::PhantomData;
>  
>  /// Implement this trait to interface blk-mq as block devices.
>  ///
> @@ -78,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
>          let request = unsafe { &*(*bd).rq.cast::<Request<T>>() };
>  
>          // One refcount for the ARef, one for being in flight
> -        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
> +        request.wrapper_ref().refcount().set(2);
>  
>          // SAFETY:
>          //  - We own a refcount that we took above. We pass that to `ARef`.
> @@ -187,7 +188,7 @@ impl<T: Operations> OperationsVTable<T> {
>  
>              // SAFETY: The refcount field is allocated but not initialized, so
>              // it is valid for writes.
> -            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU64::new(0)) };
> +            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(Refcount::new(0)) };
>  
>              Ok(0)
>          })
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
> index fefd394f064a..f62a376dc313 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -8,13 +8,10 @@
>      bindings,
>      block::mq::Operations,
>      error::Result,
> +    sync::{atomic::Relaxed, Refcount},
>      types::{ARef, AlwaysRefCounted, Opaque},
>  };
> -use core::{
> -    marker::PhantomData,
> -    ptr::NonNull,
> -    sync::atomic::{AtomicU64, Ordering},
> -};
> +use core::{marker::PhantomData, ptr::NonNull};
>  
>  /// A wrapper around a blk-mq [`struct request`]. This represents an IO request.
>  ///
> @@ -37,6 +34,9 @@
>  /// We need to track 3 and 4 to ensure that it is safe to end the request and hand
>  /// back ownership to the block layer.
>  ///
> +/// Note that the driver can still obtain new `ARef` even if there is no `ARef`s in existence by
> +/// using `tag_to_rq`, hence the need to distinguish B and C.
> +///
>  /// The states are tracked through the private `refcount` field of
>  /// `RequestDataWrapper`. This structure lives in the private data area of the C
>  /// [`struct request`].
> @@ -98,13 +98,16 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
>      ///
>      /// [`struct request`]: srctree/include/linux/blk-mq.h
>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, ARef<Self>> {
> -        // We can race with `TagSet::tag_to_rq`
> -        if let Err(_old) = this.wrapper_ref().refcount().compare_exchange(
> -            2,
> -            0,
> -            Ordering::Relaxed,
> -            Ordering::Relaxed,
> -        ) {
> +        // To hand back the ownership, we need the current refcount to be 2.
> +        // Since we can race with `TagSet::tag_to_rq`, this needs to atomically reduce
> +        // refcount to 0. `Refcount` does not provide a way to do this, so use the underlying
> +        // atomics directly.
> +        if let Err(_old) = this
> +            .wrapper_ref()
> +            .refcount()
> +            .as_atomic()
> +            .cmpxchg(2, 0, Relaxed)
> +        {
>              return Err(this);
>          }
>  
> @@ -173,13 +176,13 @@ pub(crate) struct RequestDataWrapper {
>      /// - 0: The request is owned by C block layer.
>      /// - 1: The request is owned by Rust abstractions but there are no [`ARef`] references to it.
>      /// - 2+: There are [`ARef`] references to the request.
> -    refcount: AtomicU64,
> +    refcount: Refcount,
>  }
>  
>  impl RequestDataWrapper {
>      /// Return a reference to the refcount of the request that is embedding
>      /// `self`.
> -    pub(crate) fn refcount(&self) -> &AtomicU64 {
> +    pub(crate) fn refcount(&self) -> &Refcount {
>          &self.refcount
>      }
>  
> @@ -189,7 +192,7 @@ pub(crate) fn refcount(&self) -> &AtomicU64 {
>      /// # Safety
>      ///
>      /// - `this` must point to a live allocation of at least the size of `Self`.
> -    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
> +    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut Refcount {
>          // SAFETY: Because of the safety requirements of this function, the
>          // field projection is safe.
>          unsafe { &raw mut (*this).refcount }
> @@ -205,47 +208,13 @@ unsafe impl<T: Operations> Send for Request<T> {}
>  // mutate `self` are internally synchronized`
>  unsafe impl<T: Operations> Sync for Request<T> {}
>  
> -/// Store the result of `op(target.load())` in target, returning new value of
> -/// target.
> -fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64 {
> -    let old = target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| Some(op(x)));
> -
> -    // SAFETY: Because the operation passed to `fetch_update` above always
> -    // return `Some`, `old` will always be `Ok`.
> -    let old = unsafe { old.unwrap_unchecked() };
> -
> -    op(old)
> -}
> -
> -/// Store the result of `op(target.load)` in `target` if `target.load() !=
> -/// pred`, returning [`true`] if the target was updated.
> -fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pred: u64) -> bool {
> -    target
> -        .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
> -            if x == pred {
> -                None
> -            } else {
> -                Some(op(x))
> -            }
> -        })
> -        .is_ok()
> -}
> -
>  // SAFETY: All instances of `Request<T>` are reference counted. This
>  // implementation of `AlwaysRefCounted` ensure that increments to the ref count
>  // keeps the object alive in memory at least until a matching reference count
>  // decrement is executed.
>  unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
>      fn inc_ref(&self) {
> -        let refcount = &self.wrapper_ref().refcount();
> -
> -        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
> -        let updated = atomic_relaxed_op_unless(refcount, |x| x + 1, 0);
> -
> -        #[cfg(CONFIG_DEBUG_MISC)]
> -        if !updated {
> -            panic!("Request refcount zero on clone")
> -        }
> +        self.wrapper_ref().refcount().inc();
>      }
>  
>      unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
> @@ -257,10 +226,10 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
>          let refcount = unsafe { &*RequestDataWrapper::refcount_ptr(wrapper_ptr) };
>  
>          #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
> -        let new_refcount = atomic_relaxed_op_return(refcount, |x| x - 1);
> +        let is_zero = refcount.dec_and_test();
>  
>          #[cfg(CONFIG_DEBUG_MISC)]
> -        if new_refcount == 0 {
> +        if is_zero {
>              panic!("Request reached refcount zero in Rust abstractions");
>          }
>      }
> diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
> index cc1a80ae7ae9..19236a5bccde 100644
> --- a/rust/kernel/sync/refcount.rs
> +++ b/rust/kernel/sync/refcount.rs
> @@ -5,6 +5,7 @@
>  //! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
>  
>  use crate::build_assert;
> +use crate::sync::atomic::Atomic;
>  use crate::types::Opaque;
>  
>  /// Atomic reference counter.
> @@ -34,6 +35,20 @@ fn as_ptr(&self) -> *mut bindings::refcount_t {
>          self.0.get()
>      }
>  
> +    /// Get the underlying atomic counter that backs the refcount.
> +    ///
> +    /// NOTE: Usage of this function is discouraged as it can circumvent the protections offered by
> +    /// `refcount.h`. If there is no way to achieve the result using APIs in `refcount.h`, then
> +    /// this function can be used. Otherwise consider adding a binding for the required API.
> +    #[inline]
> +    pub fn as_atomic(&self) -> &Atomic<i32> {
> +        let ptr = self.0.get().cast();
> +        // SAFETY: `refcount_t` is a transparent wrapper of `atomic_t`, which is an atomic 32-bit
> +        // integer that is layout-wise compatible with `Atomic<i32>`. All values are valid for
> +        // `refcount_t`, despite some of the values being considered saturated and "bad".
> +        unsafe { &*ptr }
> +    }
> +
>      /// Set a refcount's value.
>      #[inline]
>      pub fn set(&self, value: i32) {
> -- 
> 2.51.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

