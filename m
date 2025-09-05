Return-Path: <linux-kernel+bounces-802021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F9DB44CD5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A097A4723C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEF728E5F3;
	Fri,  5 Sep 2025 04:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOTQzUsq"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461B285C91;
	Fri,  5 Sep 2025 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047334; cv=none; b=I4WFFWGeWLyQ4mp68fQJoh+KSJBz+OQHqllI+vs3toZt1a72jxhUZcS1FdPWSnVFQZUofOa/3TvnSrflDxv6X9IerQaWhPfAz6k3iyf6Qj/nCTEQSFr7+tfk9688fhQty/qQBt8TXdoUc6W7+Ep6Dbra0bWvDjMeAjbp2jDJTp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047334; c=relaxed/simple;
	bh=uBI6gyZVc+1Um14s6hPhgg3mBjdJQn5MO+D6KWTyoHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQzX06Wz3j/sYiVHs2VXMpskOWA+xuaLdKWUkcw6ctW1LfAnPimjtqNnil+zaos5D6Vrx69qR/NoG+6+aSrsxa1akNJlJ8hOBymz6nA7IwBTwrQJaKklNQO4pAZmRp7r3CusnxoO7npEQuLC65jdO3fp+vVM975H8RETdiF7OLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOTQzUsq; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b38d47fa9dso18070471cf.0;
        Thu, 04 Sep 2025 21:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047332; x=1757652132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uFPH1xGlJ9jsNOaI+QEknzlezPIufUhMzq3e7MIAKNo=;
        b=aOTQzUsqjqAkQs2ySENDdoJZ2UNEgddOvmhD3flOGTyphXD/6HRC6wRkRuTF5Kgghb
         js8cshIzUBG9My5MoriKDjqFHJwvkoZg7kvp6d/Up5pcBtMMgNTkibltvC5+7STEW0MP
         i+4eOgNhTODwqTBFFxNAuZGLgFQkJz6PEvx+eQsEFgM66x+8wgiEX1wd6ykS9YypIL/F
         ZJxfhXy7/skcBN25J9IbOYvRVUt9i+loeXrTD5UYX7+9GtOFHhgyArq5WYZoQhkhdNo0
         CAi5yWac80YS0E02DccOhD/zdarhpjuG7T2xe4ijsM4U0vprqrCrn/yIYmoIgJ4nrjJ7
         HcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047332; x=1757652132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFPH1xGlJ9jsNOaI+QEknzlezPIufUhMzq3e7MIAKNo=;
        b=KUvKNc+qfK/wh5JFGistCb26vwAfV/13p+R4ipg6tLq4SKXSXEDq7J0qLjups4aZ/Y
         GoXJs5M5HsZSUr4t0g2/QnoAajvARL9YOdzwrhLiPKT3hmfY3xOi7OYee69li7//1a0M
         n2ENqENSvFEa0+/0p46+vW8KcMJGB/J4ALrPYpqcPYjOEGMbLGRhEhKc4Q8BEDMVQajI
         /3N32dpEO+5kIyKC7tiMK8OmfYhm9QD3LjMLqB+pEAEsVEL4n/EaXtixOu0agQpocdi8
         N+6MVL8lvVg66tN6/gNJtifC9qBBTu5HiwVIk/eNy0mpsnDbv2pmC7u04BLZRPvVD4WN
         gJsA==
X-Forwarded-Encrypted: i=1; AJvYcCXJMJYEh/DQgmDzbLy3KnpBo0FYZ7MsKUTXCHQOFs6PkyiHyc/fyXoBrRK9GiUdsw6QftjBfI2z0lQjDig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjVQqtGHd5dPFSnX6NHOpKOkVK/Z5XxdxoeHhJMRqlzDi6N2d
	9opjetV96VZwajqxkY/EL/383BBc74UvJHaJqqi4hToETjRWQafS1xsr
X-Gm-Gg: ASbGncvbZEvU01eZPyl5kIX10cnZgnIdhHXXPN0ztFyySWWcswz5tsrcgqjhrW6C5NO
	kwzUBfVvNLs1a40YNYIU5txKFEPHjD5W5vbuSgeKxyJ8lcuLUmz26Lh4JXktbjZz9vKz1BwfSde
	2/AZcojlbgo0vUmtkdfZDGkQV3vY4NtonetLzytvQ8gVodBcUEqS1z9osWfmU+XObo5P0tFor0l
	eeUQ5wpslpfqww/ieb/pLAy76lIF3B3VgpGG+448AEroLXGRay3S9/semPBhEMh4ORi7LdiDTCj
	qwTG7SvpFDE3NEYnBcSCQdNuCRelDPfZ8rbSkFxouS9uUDjV0Q/oc5CPO1KbYd7eUAogA9ATBNN
	Fr5uOqnlFYoKbKE3bjna2gI/WCLq8cQlgjoBdlB6uYloVA3NZ19xffi9ofVQOtCsTiw3wVqEMgR
	39CfWGNlA+7e7r88cx458eZco=
X-Google-Smtp-Source: AGHT+IGMznZ+sLxiMUEFzriffR3VwEqBeHzxYlM0mov9/4ynKatl5Zd+Oc4dqYNZ9Pusf7/Q71DEZw==
X-Received: by 2002:a05:622a:10:b0:4b2:8ac4:ef85 with SMTP id d75a77b69052e-4b31dd3aad9mr245601351cf.84.1757047331768;
        Thu, 04 Sep 2025 21:42:11 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aabf586c5sm413666685a.60.2025.09.04.21.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 21:42:11 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id EACD2F40066;
	Fri,  5 Sep 2025 00:42:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 05 Sep 2025 00:42:10 -0400
X-ME-Sender: <xms:Imq6aLI5DTNxOpwSHBxr-j3JdyxCqQY1C5FuLqAxQa0iR8dpNf_2wA>
    <xme:Imq6aH-KSanfVajBcJ8iB_QezqucFwKwb2-UaObCD5GKiEEBNgkchiPBOgNIFa9Jg
    Be8EHmcyt2cDgHvRg>
X-ME-Received: <xmr:Imq6aFDDo5NvNK0Dm27suR6qJT_bnuM8qmrZ7o3EbR8UTrj-buxysLsrg5xhB_RNImD7O-Ai6L0dmZLuFAp9euuPjyl_fzUz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpedtheffuedvfefgleeiiefffffffedvkeehvdfggeduvedvgfektddvfedvueejgfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhpthhrrdgrshenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghr
    tghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehruhhsthdqfh
    horhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkh
    hmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopeifihhllheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohep
    mhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrh
    honhhigidruggvpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Imq6aJoNIwfuTeGC-AGxm39EvLrmEz973y2VDBHZABVnL6eSeNeG-w>
    <xmx:Imq6aGLO2EjKPFuxbxRr3Ebf_tEl3zhekhb5NLpma3ZbxDTwcLYynQ>
    <xmx:Imq6aDKJOVJjSPCzuAqCeYnQJNMIZZbFCPH6AHq7xMhWXCls48e2dA>
    <xmx:Imq6aHkdR6UF4HVxD3FZDTfM_9dbKieGF3HTXVE_9tzv-9_2ayxwRg>
    <xmx:Imq6aBKGDDKZnmXtEm6mDn9Trr8GmLlkXcalmN7CGx2_z9n1XN6nIvpp>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 00:42:10 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: "Will Deacon" <will@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Ingo Molnar" <mingo@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	stern@rowland.harvard.edu,
	"Miguel Ojeda" <ojeda@kernel.org>,
	alex.gaynor@gmail.com,
	"Gary Guo" <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <lossin@kernel.org>,
	"Alice Ryhl" <aliceryhl@google.com>,
	"Trevor Gross" <tmgross@umich.edu>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Andreas Hindborg" <a.hindborg@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 12/14] rust: convert `Arc` to use `Refcount`
Date: Thu,  4 Sep 2025 21:41:39 -0700
Message-ID: <20250905044141.77868-13-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905044141.77868-1-boqun.feng@gmail.com>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
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
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250723233312.3304339-4-gary@kernel.org
---
 rust/kernel/sync/arc.rs | 45 +++++++++++++----------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 4ee155b43b2d..9298993ea7d8 100644
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
2.51.0


