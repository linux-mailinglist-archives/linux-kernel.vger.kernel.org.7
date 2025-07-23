Return-Path: <linux-kernel+bounces-743374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A44B0FDD8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20DE1CE01EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C4B242D6D;
	Thu, 24 Jul 2025 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJdXS4qY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CDD24DCE3;
	Thu, 24 Jul 2025 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315221; cv=none; b=ODEEkIlPJdRrM5n++uzT91IbJQ+tQzLsDPZZo3qocw2xgjsLzuXPpVpdPPka5bb47Ck4gndUk+zEFDFuJ96B9zvAhmSneceNN55zxs6BAnrVrZmD6rg7yK/E15deTH7ByVbxM/KerdRSlpr6Tx1QG5EO82HMJHXSZeSPEaj6eb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315221; c=relaxed/simple;
	bh=TMO1q/yEQRaEVcz1Gj8Of2O2/owEkXMVj9dfWg7k7FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/jfltoBwiqVqVaJ/JKI7mkZ6MmwyUz4S7nI7Eco0Hiq+ByFiPb8C5M7FHtCs6FQVeGlXyERhP6fsMTOOzIbyOGBOazhd89P02t3ASeG7+NjR8KolTvWOpPiBEIsGzncR35Jqy9kvNTtKdUx/OY1/KnVp7jhCz5HlP/0b4WPHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJdXS4qY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB32C4CEEF;
	Thu, 24 Jul 2025 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753315219;
	bh=TMO1q/yEQRaEVcz1Gj8Of2O2/owEkXMVj9dfWg7k7FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJdXS4qYNrnsr8tUJ37NQb3l1bAsU16Jdm3hd8zSg9Q8zItzzKtziIaS1f0Wv42un
	 YkxA80wyWzCkJUM6n6VZP04XH/NRQeKflouthLyzbACAikxNOrHiS4HPFMstc6yo9I
	 vELOoPegx9wZ9kjdY1ah/Hnw7UDqooMrnuzlUPH5fwn+lKUaLXXBk7m65dnskCy80l
	 UZ9c8Yuar/rYplRu1TLeFwJmb/10BHbTiwX5UwvFZT0sAYifHezFkgwccWhVUQQPsR
	 RS5hw7FXHFp2omUc4qgcGAXnJXBhxob5bG8uYYiGNGg4dFiR861lMS8C8dOQYuuRyT
	 YqzWtWoMB2BVw==
From: Gary Guo <gary@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alex Mantel <alexmantel93@mailbox.org>
Cc: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] rust: convert `Arc` to use `Refcount`
Date: Thu, 24 Jul 2025 00:32:56 +0100
Message-ID: <20250723233312.3304339-4-gary@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250723233312.3304339-1-gary@kernel.org>
References: <20250723233312.3304339-1-gary@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

With `Refcount` type created, `Arc` can use `Refcount` instead of
calling into FFI directly.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/sync/arc.rs | 45 +++++++++++++----------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 4ee155b43b2dc..9298993ea7d8b 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -8,7 +8,7 @@
 //! threads.
 //!
 //! It is different from the standard library's [`Arc`] in a few ways:
-//! 1. It is backed by the kernel's `refcount_t` type.
+//! 1. It is backed by the kernel's [`Refcount`] type.
 //! 2. It does not support weak references, which allows it to be half the size.
 //! 3. It saturates the reference count instead of aborting when it goes over a threshold.
 //! 4. It does not provide a `get_mut` method, so the ref counted object is pinned.
@@ -18,11 +18,11 @@
 
 use crate::{
     alloc::{AllocError, Flags, KBox},
-    bindings,
     ffi::c_void,
     init::InPlaceInit,
+    sync::Refcount,
     try_init,
-    types::{ForeignOwnable, Opaque},
+    types::ForeignOwnable,
 };
 use core::{
     alloc::Layout,
@@ -145,7 +145,7 @@ pub struct Arc<T: ?Sized> {
 #[pin_data]
 #[repr(C)]
 struct ArcInner<T: ?Sized> {
-    refcount: Opaque<bindings::refcount_t>,
+    refcount: Refcount,
     data: T,
 }
 
@@ -157,7 +157,7 @@ impl<T: ?Sized> ArcInner<T> {
     /// `ptr` must have been returned by a previous call to [`Arc::into_raw`], and the `Arc` must
     /// not yet have been destroyed.
     unsafe fn container_of(ptr: *const T) -> NonNull<ArcInner<T>> {
-        let refcount_layout = Layout::new::<bindings::refcount_t>();
+        let refcount_layout = Layout::new::<Refcount>();
         // SAFETY: The caller guarantees that the pointer is valid.
         let val_layout = Layout::for_value(unsafe { &*ptr });
         // SAFETY: We're computing the layout of a real struct that existed when compiling this
@@ -229,8 +229,7 @@ impl<T> Arc<T> {
     pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
         let value = ArcInner {
-            // SAFETY: There are no safety requirements for this FFI call.
-            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+            refcount: Refcount::new(1),
             data: contents,
         };
 
@@ -348,18 +347,13 @@ pub fn into_unique_or_drop(this: Self) -> Option<Pin<UniqueArc<T>>> {
         // We will manually manage the refcount in this method, so we disable the destructor.
         let this = ManuallyDrop::new(this);
         // SAFETY: We own a refcount, so the pointer is still valid.
-        let refcount = unsafe { this.ptr.as_ref() }.refcount.get();
+        let refcount = unsafe { &this.ptr.as_ref().refcount };
 
         // If the refcount reaches a non-zero value, then we have destroyed this `Arc` and will
         // return without further touching the `Arc`. If the refcount reaches zero, then there are
         // no other arcs, and we can create a `UniqueArc`.
-        //
-        // SAFETY: We own a refcount, so the pointer is not dangling.
-        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
-        if is_zero {
-            // SAFETY: We have exclusive access to the arc, so we can perform unsynchronized
-            // accesses to the refcount.
-            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INIT(1)) };
+        if refcount.dec_and_test() {
+            refcount.set(1);
 
             // INVARIANT: We own the only refcount to this arc, so we may create a `UniqueArc`. We
             // must pin the `UniqueArc` because the values was previously in an `Arc`, and they pin
@@ -456,14 +450,10 @@ fn borrow(&self) -> &T {
 
 impl<T: ?Sized> Clone for Arc<T> {
     fn clone(&self) -> Self {
-        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
-        // safe to dereference it.
-        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
-
-        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
+        // INVARIANT: `Refcount` saturates the refcount, so it cannot overflow to zero.
         // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
         // safe to increment the refcount.
-        unsafe { bindings::refcount_inc(refcount) };
+        unsafe { self.ptr.as_ref() }.refcount.inc();
 
         // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
         unsafe { Self::from_inner(self.ptr) }
@@ -472,16 +462,10 @@ fn clone(&self) -> Self {
 
 impl<T: ?Sized> Drop for Arc<T> {
     fn drop(&mut self) {
-        // SAFETY: By the type invariant, there is necessarily a reference to the object. We cannot
-        // touch `refcount` after it's decremented to a non-zero value because another thread/CPU
-        // may concurrently decrement it to zero and free it. It is ok to have a raw pointer to
-        // freed/invalid memory as long as it is never dereferenced.
-        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
-
         // INVARIANT: If the refcount reaches zero, there are no other instances of `Arc`, and
         // this instance is being dropped, so the broken invariant is not observable.
-        // SAFETY: Also by the type invariant, we are allowed to decrement the refcount.
-        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
+        // SAFETY: By the type invariant, there is necessarily a reference to the object.
+        let is_zero = unsafe { self.ptr.as_ref() }.refcount.dec_and_test();
         if is_zero {
             // The count reached zero, we must free the memory.
             //
@@ -775,8 +759,7 @@ pub fn new_uninit(flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError>
         // INVARIANT: The refcount is initialised to a non-zero value.
         let inner = KBox::try_init::<AllocError>(
             try_init!(ArcInner {
-                // SAFETY: There are no safety requirements for this FFI call.
-                refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+                refcount: Refcount::new(1),
                 data <- pin_init::uninit::<T, AllocError>(),
             }? AllocError),
             flags,
-- 
2.49.0


