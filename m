Return-Path: <linux-kernel+bounces-804041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2888B46903
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADEF58917A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1908A266B6C;
	Sat,  6 Sep 2025 04:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="oO5mzYU2"
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624E925B67D;
	Sat,  6 Sep 2025 04:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132771; cv=none; b=IZ4y+dL1gWIL7+Ztzi56Q8j5hxKDkvwcHl2O/p5FBsESdxGNDw1E03p89ELXYCpBhVhFQaZWALZTejoBIhMxc/2Y+kZFDXUuuHgpTvNZXN9F9Y8s38nUS+KHDq+l2mW+HL7f1gosY5XcvO/VFzD1UorN+cX+IIVbTEde6fwDcec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132771; c=relaxed/simple;
	bh=HRzzQLL7HgyN3IET1oFCb+1tsnaXUdqKgOdnVrDvTkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/x5iMd5shvlkpUmbJz+6aAhLoaDyYlMUx+0RsEjXkVyjVyJmQj0/Q01LsIosTrCxoIZgT0+Xf46FUJLlvi++B/p9m59Bz1LavDN/AOyHIxeH8hvpG1cggDjCpiCX5IJKBtOPtUv5G5zXs+jx9DInNySRBwsUrN3flhQmRt8Wi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=oO5mzYU2; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757132766; x=1757391966;
	bh=MTSO5mLqb6QtLE1IH2HBBR5v+hWR8KIYiUIKItIkK8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=oO5mzYU2xFG81rh9MTmSqbrcja7AgiV5WmiIpAsPPnKbfM/2VL5i2SZNs7td6gyJy
	 qABTkSEgtO/kriO/uhUmYm0jOzQOATJe4oLrGMXzNV8QN2HPiPKtUZf7Il3buwa33u
	 vN3n3nx6sX79iu168sUzOjDTOTldzmxbWGqko14giP2pF11onCqmrGeXz4lBHGVHJr
	 ci+EPvVqA2gjyWvyK7J175HabbbdEwQF5kC6xfuU9DhWo8DixFzJuK8TfXYgY41q/V
	 Gyz3FPReb8eTj1Zx0ZuQvdswXlxIX8qqgUScxXSi+9swosLOpO+1r+49GvOPaqffVz
	 PUKpS5ZRQv+7A==
X-Pm-Submission-Id: 4cJgBh4Rtsz2ScDD
Date: Sat, 6 Sep 2025 04:26:01 +0000
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
	Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH 12/14] rust: convert `Arc` to use `Refcount`
Message-ID: <aLu32WE1La5eEdnS@archiso>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
 <20250905044141.77868-13-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-13-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:39PM -0700, Boqun Feng wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> With `Refcount` type created, `Arc` can use `Refcount` instead of
> calling into FFI directly.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/r/20250723233312.3304339-4-gary@kernel.org
> ---
>  rust/kernel/sync/arc.rs | 45 +++++++++++++----------------------------
>  1 file changed, 14 insertions(+), 31 deletions(-)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 4ee155b43b2d..9298993ea7d8 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -8,7 +8,7 @@
>  //! threads.
>  //!
>  //! It is different from the standard library's [`Arc`] in a few ways:
> -//! 1. It is backed by the kernel's `refcount_t` type.
> +//! 1. It is backed by the kernel's [`Refcount`] type.
>  //! 2. It does not support weak references, which allows it to be half the size.
>  //! 3. It saturates the reference count instead of aborting when it goes over a threshold.
>  //! 4. It does not provide a `get_mut` method, so the ref counted object is pinned.
> @@ -18,11 +18,11 @@
>  
>  use crate::{
>      alloc::{AllocError, Flags, KBox},
> -    bindings,
>      ffi::c_void,
>      init::InPlaceInit,
> +    sync::Refcount,
>      try_init,
> -    types::{ForeignOwnable, Opaque},
> +    types::ForeignOwnable,
>  };
>  use core::{
>      alloc::Layout,
> @@ -145,7 +145,7 @@ pub struct Arc<T: ?Sized> {
>  #[pin_data]
>  #[repr(C)]
>  struct ArcInner<T: ?Sized> {
> -    refcount: Opaque<bindings::refcount_t>,
> +    refcount: Refcount,
>      data: T,
>  }
>  
> @@ -157,7 +157,7 @@ impl<T: ?Sized> ArcInner<T> {
>      /// `ptr` must have been returned by a previous call to [`Arc::into_raw`], and the `Arc` must
>      /// not yet have been destroyed.
>      unsafe fn container_of(ptr: *const T) -> NonNull<ArcInner<T>> {
> -        let refcount_layout = Layout::new::<bindings::refcount_t>();
> +        let refcount_layout = Layout::new::<Refcount>();
>          // SAFETY: The caller guarantees that the pointer is valid.
>          let val_layout = Layout::for_value(unsafe { &*ptr });
>          // SAFETY: We're computing the layout of a real struct that existed when compiling this
> @@ -229,8 +229,7 @@ impl<T> Arc<T> {
>      pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
>          // INVARIANT: The refcount is initialised to a non-zero value.
>          let value = ArcInner {
> -            // SAFETY: There are no safety requirements for this FFI call.
> -            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
> +            refcount: Refcount::new(1),
>              data: contents,
>          };
>  
> @@ -348,18 +347,13 @@ pub fn into_unique_or_drop(this: Self) -> Option<Pin<UniqueArc<T>>> {
>          // We will manually manage the refcount in this method, so we disable the destructor.
>          let this = ManuallyDrop::new(this);
>          // SAFETY: We own a refcount, so the pointer is still valid.
> -        let refcount = unsafe { this.ptr.as_ref() }.refcount.get();
> +        let refcount = unsafe { &this.ptr.as_ref().refcount };
>  
>          // If the refcount reaches a non-zero value, then we have destroyed this `Arc` and will
>          // return without further touching the `Arc`. If the refcount reaches zero, then there are
>          // no other arcs, and we can create a `UniqueArc`.
> -        //
> -        // SAFETY: We own a refcount, so the pointer is not dangling.
> -        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
> -        if is_zero {
> -            // SAFETY: We have exclusive access to the arc, so we can perform unsynchronized
> -            // accesses to the refcount.
> -            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INIT(1)) };
> +        if refcount.dec_and_test() {
> +            refcount.set(1);
>  
>              // INVARIANT: We own the only refcount to this arc, so we may create a `UniqueArc`. We
>              // must pin the `UniqueArc` because the values was previously in an `Arc`, and they pin
> @@ -456,14 +450,10 @@ fn borrow(&self) -> &T {
>  
>  impl<T: ?Sized> Clone for Arc<T> {
>      fn clone(&self) -> Self {
> -        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
> -        // safe to dereference it.
> -        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
> -
> -        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
> +        // INVARIANT: `Refcount` saturates the refcount, so it cannot overflow to zero.
>          // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
>          // safe to increment the refcount.
> -        unsafe { bindings::refcount_inc(refcount) };
> +        unsafe { self.ptr.as_ref() }.refcount.inc();
>  
>          // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
>          unsafe { Self::from_inner(self.ptr) }
> @@ -472,16 +462,10 @@ fn clone(&self) -> Self {
>  
>  impl<T: ?Sized> Drop for Arc<T> {
>      fn drop(&mut self) {
> -        // SAFETY: By the type invariant, there is necessarily a reference to the object. We cannot
> -        // touch `refcount` after it's decremented to a non-zero value because another thread/CPU
> -        // may concurrently decrement it to zero and free it. It is ok to have a raw pointer to
> -        // freed/invalid memory as long as it is never dereferenced.
> -        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
> -
>          // INVARIANT: If the refcount reaches zero, there are no other instances of `Arc`, and
>          // this instance is being dropped, so the broken invariant is not observable.
> -        // SAFETY: Also by the type invariant, we are allowed to decrement the refcount.
> -        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
> +        // SAFETY: By the type invariant, there is necessarily a reference to the object.
> +        let is_zero = unsafe { self.ptr.as_ref() }.refcount.dec_and_test();
>          if is_zero {
>              // The count reached zero, we must free the memory.
>              //
> @@ -775,8 +759,7 @@ pub fn new_uninit(flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError>
>          // INVARIANT: The refcount is initialised to a non-zero value.
>          let inner = KBox::try_init::<AllocError>(
>              try_init!(ArcInner {
> -                // SAFETY: There are no safety requirements for this FFI call.
> -                refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
> +                refcount: Refcount::new(1),
>                  data <- pin_init::uninit::<T, AllocError>(),
>              }? AllocError),
>              flags,
> -- 
> 2.51.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

