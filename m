Return-Path: <linux-kernel+bounces-702303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C14AE80AA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 13:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C34B3B6D83
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B212BEC23;
	Wed, 25 Jun 2025 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKpmi56a"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88A29ACF9;
	Wed, 25 Jun 2025 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849920; cv=none; b=XhN214pmxJlXr1uiUQkbrCLom/69nt77uOgwS/oEOJdevR3ie928uegIxCPRU3gbrj/mFfWA729yz1Dmlm6ZxaKDkdwvoHKQmG6NfxiCzlhxbkyuKoKbkPgH7irUi9/wR1MWWsq32qSP0fQDL/UHE+17q0s3SFpO/Pglb68urkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849920; c=relaxed/simple;
	bh=jHR0bPaYIi58VgUeOdBsTdTI1oZUfYjXFb+y4BCL5Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Kk+eeucAUcjOvY29uxLwMuBkOEIrKbGh/k7glhW6Kwp2aUhWCqr/BER0kdMYN1DSEihGWwdxosM4Ru1Dvciii8okCbpG5BXf+pydboR2K0QvUiYlANp1u6WavgjsJi0qsQlra3VGC50Qb1XG/yfL8K2aN7yzpL8XFRITXlyUJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKpmi56a; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7490cb9a892so695525b3a.0;
        Wed, 25 Jun 2025 04:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750849917; x=1751454717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L2SqXIiCaVImBouPqYt5Pcr5G1n4XvOv6tRKQ2x6qxk=;
        b=kKpmi56aoxBexrWGg/ABRyIHoaN+mZWDcwibAS2sY96TVRLlNzvAlR3q4BJHj8CB8h
         MjJ/u16yfCJ3fF7zLCBMTKkbydIaMFBiEjJ4TJATpRZoHYoflRoTMl42Y2rLsU3nbqOE
         EJqWDHFdMJE+sdMS7NnIGGTH4qZATk8pvBeRbX4vYh3Myv23Ci/i9V6kPDn8siU7DRmy
         vlSeSDq5nPEqdSkgzTPWKq2Ny+etHJNHp2yXJhIj8eh14i8274z7VtrMChiGhx7Mt2H0
         kmu3mY8YNgDCxJIpfkW8acolJ1sXuABJ7RtqeBirVtvLZ1ka0NOP0Rk6TG4vaWy0xtZ8
         0/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750849917; x=1751454717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2SqXIiCaVImBouPqYt5Pcr5G1n4XvOv6tRKQ2x6qxk=;
        b=Rt2qWihrqIrNBV2rFYXpn305y4PGYnR8xZRrJMC+TFCv2n1OICQUoMjHBeqnLSp5M2
         sAdhQNiVxshmMjC3axC166oFVsBpzsjrHvFqH/FgioG9Swkn1ghHvqR4ag4+mGci6maS
         3mHomej3jIbhC2p1MvJgZ91jVPawQUVXJ38pLWlp90Q3nG00Fd+vQH0yknKcIo8Aa71Q
         X4Ea7gajsGHMtBFKLS8hznHc4F0QstyXMPE886irDW/eOBCfoPinagRcKaF0WDXeT3e+
         yeLxNNK4xAWrmF/KTKn5eP88PSAo6VgbCALkA3OcOWR/P0aJ//xFMOZ/CgiDCkXS/PBC
         EGQg==
X-Forwarded-Encrypted: i=1; AJvYcCWTGGFpg85yNGz9bicwA/DRvII+Bo2ooU1MdL71ER2Yq8PhStKr9FeJhoDqac/9LDOLN0d4FAgXPINz07b2hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYsVEwWP9ZMzZymlGStmfkgF17mNGxZ5+c25GqfVy5nKMjc9ZI
	xoWotFT+erdvUBZDiUW6Qkz+A/cpkxOZNXQwGBMzZA8M421coY74PqgSZYWzU0Af
X-Gm-Gg: ASbGncvqX7lmwsxnjOZCy6dIznOnoVW/MZwliKldiwB63w0yJuipCux6r/RYpGXMIOI
	zX6CqPoZeDZqHS0EC1wRo1EDQ5ucldt1J1LBFDRySxU7YxKPf37Dn4dKDQMRy7LOnfJnvmyO7XI
	BxXWyHrKDdvcNtKcjdsCDxJlraqjRupQ0xZ7k1kLgnUpm/1UU1rQdgrqzEPK7OJLv3BUeyxz5oy
	thWOWcd/o7owvE2ZmBCM75kvaXAm6Qw/f889ira0h7Sm+uU2nhH4L/WTNkOZd6mM6YlkIa/+eA3
	uHwVmI9oyIgcSDPuNUCGRWM3oqQ3kCcLfG8I64Pw/5iP0q05LdWFQzx8UPAWROSBo0mxeJWBp85
	QGsPZ
X-Google-Smtp-Source: AGHT+IEt9pRkhmBu+/7O4yXM8DWTP8mMPoKirlHTiHDNGGoTSyB/gIGQ3q9P82PCR7W0FP9OSQNOQA==
X-Received: by 2002:a05:6a20:748f:b0:220:105b:46dd with SMTP id adf61e73a8af0-2207f2fb655mr4957531637.36.1750849917189;
        Wed, 25 Jun 2025 04:11:57 -0700 (PDT)
Received: from shankari-IdeaPad.. ([2409:4080:10:4ef8:7bae:5763:c10a:8810])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34aabc3842sm2561417a12.50.2025.06.25.04.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 04:11:56 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	patches@lists.linux.dev
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH v2 1/2] rust: move ARef and AlwaysRefCounted to sync::aref
Date: Wed, 25 Jun 2025 16:41:32 +0530
Message-Id: <20250625111133.698481-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the definitions of `ARef` and `AlwaysRefCounted` from `types.rs`
to a new file `sync/aref.rs`.
Define the corresponding `aref` module under `rust/kernel/sync.rs`.
These types are better grouped in `sync`.

To avoid breaking existing imports, they are re-exported from `types.rs`.
Drop unused imports `mem::ManuallyDrop`, `ptr::NonNull` from `types.rs`,
they are now only used in `sync/aref.rs`, where they are already imported.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
v1 -> v2 : Added git base commit id
Rebased the repository to the recent HEAD in the rust-next. Solved the conflict (a commit adding a module to sync.rs).
Changed the in-file reference of {ARef, AlwaysRefCounted}. Rest remains unchanged.
---
 rust/kernel/sync.rs      |   1 +
 rust/kernel/sync/aref.rs | 170 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/types.rs     | 154 +----------------------------------
 3 files changed, 174 insertions(+), 151 deletions(-)
 create mode 100644 rust/kernel/sync/aref.rs

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 63c99e015ad6..8fd126788e02 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -10,6 +10,7 @@
 use pin_init;
 
 mod arc;
+pub mod aref;
 pub mod completion;
 mod condvar;
 pub mod lock;
diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
new file mode 100644
index 000000000000..93a23b493e21
--- /dev/null
+++ b/rust/kernel/sync/aref.rs
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic reference-counted pointer abstraction.
+//!
+//! This module provides [`ARef<T>`], an owned reference to a value that implements
+//! [`AlwaysRefCounted`] — an unsafe trait for types that manage their own reference count.
+//!
+//! It is based on the Linux kernel's manual reference counting model and is typically used
+//! with C types that implement reference counting (e.g., via `refcount_t` or `kref`).
+//!
+//! For Rust-managed objects, prefer using [`Arc`](crate::sync::Arc) instead.
+
+use core::{
+    marker::PhantomData,
+    mem::ManuallyDrop,
+    ops::Deref,
+    ptr::NonNull,
+};
+
+/// Trait for types that are _always_ reference-counted.
+///
+/// This trait allows types to define custom reference increment and decrement logic.
+/// It enables safe conversion from a shared reference `&T` to an owned [`ARef<T>`].
+///
+/// This is usually implemented by wrappers around C types with manual refcounting.
+///
+/// For purely Rust-managed memory, consider using [`Arc`](crate::sync::Arc) instead.
+///
+/// # Safety
+///
+/// Implementers must ensure that:
+///
+/// - Calling [`AlwaysRefCounted::inc_ref`] keeps the object alive in memory until a matching [`AlwaysRefCounted::dec_ref`] is called.
+/// - The object is always managed by a reference count; it must never be stack-allocated or
+///   otherwise untracked.
+/// - When the count reaches zero in [`AlwaysRefCounted::dec_ref`], the object is properly freed and no further
+///   access occurs.
+///
+/// Failure to follow these rules may lead to use-after-free or memory corruption.
+
+pub unsafe trait AlwaysRefCounted {
+    /// Increments the reference count on the object.
+    fn inc_ref(&self);
+
+    /// Decrements the reference count on the object.
+    ///
+    /// Frees the object when the count reaches zero.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that there was a previous matching increment to the reference count,
+    /// and that the object is no longer used after its reference count is decremented (as it may
+    /// result in the object being freed), unless the caller owns another increment on the refcount
+    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
+    /// [`AlwaysRefCounted::dec_ref`] once).
+    unsafe fn dec_ref(obj: NonNull<Self>);
+}
+
+/// An owned reference to an always-reference-counted object.
+///
+/// The object's reference count is automatically decremented when an instance of [`ARef`] is
+/// dropped. It is also automatically incremented when a new instance is created via
+/// [`ARef::clone`].
+///
+/// # Invariants
+///
+/// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
+/// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
+pub struct ARef<T: AlwaysRefCounted> {
+    ptr: NonNull<T>,
+    _p: PhantomData<T>,
+}
+
+// SAFETY: It is safe to send `ARef<T>` to another thread when the underlying `T` is `Sync` because
+// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
+// `T` to be `Send` because any thread that has an `ARef<T>` may ultimately access `T` using a
+// mutable reference, for example, when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
+
+// SAFETY: It is safe to send `&ARef<T>` to another thread when the underlying `T` is `Sync`
+// because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
+// it needs `T` to be `Send` because any thread that has a `&ARef<T>` may clone it and get an
+// `ARef<T>` on that thread, so the thread may ultimately access `T` using a mutable reference, for
+// example, when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
+
+impl<T: AlwaysRefCounted> ARef<T> {
+    /// Creates a new instance of [`ARef`].
+    ///
+    /// It takes over an increment of the reference count on the underlying object.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the reference count was incremented at least once, and that they
+    /// are properly relinquishing one increment. That is, if there is only one increment, callers
+    /// must not use the underlying object anymore -- it is only safe to do so via the newly
+    /// created [`ARef`].
+    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
+        // INVARIANT: The safety requirements guarantee that the new instance now owns the
+        // increment on the refcount.
+        Self {
+            ptr,
+            _p: PhantomData,
+        }
+    }
+
+    /// Consumes the `ARef`, returning a raw pointer.
+    ///
+    /// This function does not change the refcount. After calling this function, the caller is
+    /// responsible for the refcount previously managed by the `ARef`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use core::ptr::NonNull;
+    /// use kernel::sync::aref::{ARef, AlwaysRefCounted};
+    ///
+    /// struct Empty {}
+    ///
+    /// # // SAFETY: TODO.
+    /// unsafe impl AlwaysRefCounted for Empty {
+    ///     fn inc_ref(&self) {}
+    ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
+    /// }
+    ///
+    /// let mut data = Empty {};
+    /// let ptr = NonNull::<Empty>::new(&mut data).unwrap();
+    /// # // SAFETY: TODO.
+    /// let data_ref: ARef<Empty> = unsafe { ARef::from_raw(ptr) };
+    /// let raw_ptr: NonNull<Empty> = ARef::into_raw(data_ref);
+    ///
+    /// assert_eq!(ptr, raw_ptr);
+    /// ```
+    pub fn into_raw(me: Self) -> NonNull<T> {
+        ManuallyDrop::new(me).ptr
+    }
+}
+
+impl<T: AlwaysRefCounted> Clone for ARef<T> {
+    fn clone(&self) -> Self {
+        self.inc_ref();
+        // SAFETY: We just incremented the refcount above.
+        unsafe { Self::from_raw(self.ptr) }
+    }
+}
+
+impl<T: AlwaysRefCounted> Deref for ARef<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid.
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+impl<T: AlwaysRefCounted> From<&T> for ARef<T> {
+    fn from(b: &T) -> Self {
+        b.inc_ref();
+        // SAFETY: We just incremented the refcount above.
+        unsafe { Self::from_raw(NonNull::from(b)) }
+    }
+}
+
+impl<T: AlwaysRefCounted> Drop for ARef<T> {
+    fn drop(&mut self) {
+        // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
+        // decrement.
+        unsafe { T::dec_ref(self.ptr) };
+    }
+}
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 22985b6f6982..60cb48285630 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -5,12 +5,13 @@
 use core::{
     cell::UnsafeCell,
     marker::{PhantomData, PhantomPinned},
-    mem::{ManuallyDrop, MaybeUninit},
+    mem::MaybeUninit,
     ops::{Deref, DerefMut},
-    ptr::NonNull,
 };
 use pin_init::{PinInit, Zeroable};
 
+pub use crate::sync::aref::{ARef, AlwaysRefCounted};
+
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///
 /// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and
@@ -415,155 +416,6 @@ pub const fn raw_get(this: *const Self) -> *mut T {
     }
 }
 
-/// Types that are _always_ reference counted.
-///
-/// It allows such types to define their own custom ref increment and decrement functions.
-/// Additionally, it allows users to convert from a shared reference `&T` to an owned reference
-/// [`ARef<T>`].
-///
-/// This is usually implemented by wrappers to existing structures on the C side of the code. For
-/// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
-/// instances of a type.
-///
-/// # Safety
-///
-/// Implementers must ensure that increments to the reference count keep the object alive in memory
-/// at least until matching decrements are performed.
-///
-/// Implementers must also ensure that all instances are reference-counted. (Otherwise they
-/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_ref`] keep the object
-/// alive.)
-pub unsafe trait AlwaysRefCounted {
-    /// Increments the reference count on the object.
-    fn inc_ref(&self);
-
-    /// Decrements the reference count on the object.
-    ///
-    /// Frees the object when the count reaches zero.
-    ///
-    /// # Safety
-    ///
-    /// Callers must ensure that there was a previous matching increment to the reference count,
-    /// and that the object is no longer used after its reference count is decremented (as it may
-    /// result in the object being freed), unless the caller owns another increment on the refcount
-    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
-    /// [`AlwaysRefCounted::dec_ref`] once).
-    unsafe fn dec_ref(obj: NonNull<Self>);
-}
-
-/// An owned reference to an always-reference-counted object.
-///
-/// The object's reference count is automatically decremented when an instance of [`ARef`] is
-/// dropped. It is also automatically incremented when a new instance is created via
-/// [`ARef::clone`].
-///
-/// # Invariants
-///
-/// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
-/// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
-pub struct ARef<T: AlwaysRefCounted> {
-    ptr: NonNull<T>,
-    _p: PhantomData<T>,
-}
-
-// SAFETY: It is safe to send `ARef<T>` to another thread when the underlying `T` is `Sync` because
-// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
-// `T` to be `Send` because any thread that has an `ARef<T>` may ultimately access `T` using a
-// mutable reference, for example, when the reference count reaches zero and `T` is dropped.
-unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
-
-// SAFETY: It is safe to send `&ARef<T>` to another thread when the underlying `T` is `Sync`
-// because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
-// it needs `T` to be `Send` because any thread that has a `&ARef<T>` may clone it and get an
-// `ARef<T>` on that thread, so the thread may ultimately access `T` using a mutable reference, for
-// example, when the reference count reaches zero and `T` is dropped.
-unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
-
-impl<T: AlwaysRefCounted> ARef<T> {
-    /// Creates a new instance of [`ARef`].
-    ///
-    /// It takes over an increment of the reference count on the underlying object.
-    ///
-    /// # Safety
-    ///
-    /// Callers must ensure that the reference count was incremented at least once, and that they
-    /// are properly relinquishing one increment. That is, if there is only one increment, callers
-    /// must not use the underlying object anymore -- it is only safe to do so via the newly
-    /// created [`ARef`].
-    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
-        // INVARIANT: The safety requirements guarantee that the new instance now owns the
-        // increment on the refcount.
-        Self {
-            ptr,
-            _p: PhantomData,
-        }
-    }
-
-    /// Consumes the `ARef`, returning a raw pointer.
-    ///
-    /// This function does not change the refcount. After calling this function, the caller is
-    /// responsible for the refcount previously managed by the `ARef`.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// use core::ptr::NonNull;
-    /// use kernel::types::{ARef, AlwaysRefCounted};
-    ///
-    /// struct Empty {}
-    ///
-    /// # // SAFETY: TODO.
-    /// unsafe impl AlwaysRefCounted for Empty {
-    ///     fn inc_ref(&self) {}
-    ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
-    /// }
-    ///
-    /// let mut data = Empty {};
-    /// let ptr = NonNull::<Empty>::new(&mut data).unwrap();
-    /// # // SAFETY: TODO.
-    /// let data_ref: ARef<Empty> = unsafe { ARef::from_raw(ptr) };
-    /// let raw_ptr: NonNull<Empty> = ARef::into_raw(data_ref);
-    ///
-    /// assert_eq!(ptr, raw_ptr);
-    /// ```
-    pub fn into_raw(me: Self) -> NonNull<T> {
-        ManuallyDrop::new(me).ptr
-    }
-}
-
-impl<T: AlwaysRefCounted> Clone for ARef<T> {
-    fn clone(&self) -> Self {
-        self.inc_ref();
-        // SAFETY: We just incremented the refcount above.
-        unsafe { Self::from_raw(self.ptr) }
-    }
-}
-
-impl<T: AlwaysRefCounted> Deref for ARef<T> {
-    type Target = T;
-
-    fn deref(&self) -> &Self::Target {
-        // SAFETY: The type invariants guarantee that the object is valid.
-        unsafe { self.ptr.as_ref() }
-    }
-}
-
-impl<T: AlwaysRefCounted> From<&T> for ARef<T> {
-    fn from(b: &T) -> Self {
-        b.inc_ref();
-        // SAFETY: We just incremented the refcount above.
-        unsafe { Self::from_raw(NonNull::from(b)) }
-    }
-}
-
-impl<T: AlwaysRefCounted> Drop for ARef<T> {
-    fn drop(&mut self) {
-        // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
-        // decrement.
-        unsafe { T::dec_ref(self.ptr) };
-    }
-}
-
 /// A sum type that always holds either a value of type `L` or `R`.
 ///
 /// # Examples

base-commit: 0303584766b7bdb6564c7e8f13e0b59b6ef44984
-- 
2.34.1


