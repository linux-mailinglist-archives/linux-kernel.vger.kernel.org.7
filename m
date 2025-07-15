Return-Path: <linux-kernel+bounces-731697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2FB05865
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0ED81889601
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926378634C;
	Tue, 15 Jul 2025 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeHatiwU"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC322586C7;
	Tue, 15 Jul 2025 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577479; cv=none; b=HUDWDZeukiIs05QTM8c81xbWeGS9XCx4GvZOyZbXexhhTs+hb/ci59P1iyieggkD8he940td0mQyuRQ+YgSH5EvZzCNtpHCj9yFusqDbi+0xJ4RYEZCMxQo3XCwKJKZk4wqoGLpxIuwusA7PooWZq/8juBh1EDylrCyzDxr+Qek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577479; c=relaxed/simple;
	bh=trxZMc0YAsA/MYS+7XuNPO4qwb4PKoIe1//5birnoIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q44b0Goqf1LImYxa51VS7Ws14YrCbIE1h4eQ6cWixEZcGr2hcjPI9YLCCS/BQOQ+52F8dQE6AtMTTlEQcfS0ga0m3e4qFR1qrK+GSNxMhpURTXbmgNFeN7neVSQ84TLXTv3lVF3p2WKDVM7Uz6dlX9SNVYuMsuytlDNLD2EYx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeHatiwU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-748d982e92cso3457309b3a.1;
        Tue, 15 Jul 2025 04:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752577476; x=1753182276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GN/GA0HYuhYfjmgwvEl8615sxAOU2qYvspeazCxoj6I=;
        b=GeHatiwU0rE7V5ZrhoWEVXoAYGXy/zbWyFyfcGBekvglBlXLq2CWQ5JWn8yoFgicSy
         ZTmA/OrPhRzZmZfo/fGOoCUnqaEJcZM1A1GLLZv4JR1zNyZeFedt0MPAvg2vMHXjl7WX
         6zQqAbjl88K7Jrp76cS5eIa9BTsjYnuO5+598HHbNUCqFiIClv3SZF7LPoRLP0lMdl/K
         qxrHgrUqcjr4KQPnU/Q4LVRYEfBAbBfffwrPu45/d0qwS/jK+odcdtqDgsjoG74mWD+n
         N+Q1mkxPOvYLLix/3DYElFLdQH/L6Nr2dyjZfDlCZOTeLkNv3xeFax1mVKxXIybuYjcu
         vZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577476; x=1753182276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GN/GA0HYuhYfjmgwvEl8615sxAOU2qYvspeazCxoj6I=;
        b=OT7M3rfKxl2b9y0TXK9vW9Azf26n2qj7P50um8K/7qa9S+8arJs1rSJe5YVuz5oGjc
         7Ker+IFx93yCkYm6M0tA9U2P2HqvNZVhQ0HnbDe9TaZk/l2ZJqs4Q/tOOkRslYnIfztV
         xInczazzeVB1NmG1HDqZk3rmnouhSGmBtJDc442Sa006vR9ZbL+11tU0XhM9WLWb+VJB
         iCQ/lRtSbaAynJ/Na8+GAzXdaQCcsbH3oTD6B7gsT4ZF34O3RYhwR667hD1mHyClphtd
         plrXbZlxU0DF/J4YaPETnf1Bd+SO83pybFANu3tTQaRwzDuTzK6YWZXYxF3s2N9Hrp/w
         1pxw==
X-Forwarded-Encrypted: i=1; AJvYcCU9zXWKJk0e6bDiYOGZ6DFvVC5RyM0DIV2dcQP8GKzwT+ddf1tK3eq6Cn6T4kpGBCsmQtIUCPJI7ZQLG1AXbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPdTNLNHBTgeHhHiUhf6Uf8LZHDajeSC3BM0xRTY+uoO9sDOh0
	yugwOMx6KGJTVmf7VEBCPEx7zCEscIdnoxibwNN9d3CzlQwe0MnhfJel56rtzkbJ
X-Gm-Gg: ASbGncuSnZMgJ0idiHQpQNlkyZMpksJn0JfvnRnz7oLLGDtVfRJgL9cJ3oY/XC/+T5v
	1cLPScKyHKotU28ppj3Cbf4WcfAotIlQKBFjavRpnjYyZrttJxPqMnLRoNOSx299WAY9XMr5xN9
	WZGNxl84bTYAMMv+k/MUjA38ErwBNJpZX6A5gnO2Gt0oQ8c3PKwD+B3bMGZr++GI8+v5znnlmxr
	HfyKELMp7uh3B08w3zPHa5sZFsC5Jas6Yx4h9AvO4iX1BJi7yqdC+a82/wHuenBGvLuJ5h0K/uH
	hdLauSoPyWHmDEfADQ8YKRFIrsQdIl0PLvdrHAF5KPD+txvjm92P/1/Z21hUfiNuY1bnb8ihFIl
	zJyJMsyQx2n8xTgy48qOIgSgTB++UigjfbsV2GAsL8cmLt3GoBLAM
X-Google-Smtp-Source: AGHT+IGbwNWSh9dfZ82pF5QEVs5RcwXR698Ky9JoFnmZIriQI3v+djqe8pzaepb2PukrfzQ01RG51A==
X-Received: by 2002:a17:902:f687:b0:232:1daf:6f06 with SMTP id d9443c01a7336-23e1b1bcd70mr36099075ad.47.1752577476071;
        Tue, 15 Jul 2025 04:04:36 -0700 (PDT)
Received: from shankari-IdeaPad.. ([2409:4080:410:5eb2:ec3c:d341:faf0:a874])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017cc3bsm15326340a91.24.2025.07.15.04.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:04:35 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH v4] rust: move ARef and AlwaysRefCounted to sync::aref
Date: Tue, 15 Jul 2025 16:34:23 +0530
Message-Id: <20250715110423.334744-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
v3 -> v4: Changed the position of the use statement, 
removed the either type that was pasted in aref.rs by mistake.

I'll separate the patches for updation of call-sites subsystem-wise and send them subsequently.
---
 rust/kernel/sync.rs      |   1 +
 rust/kernel/sync/aref.rs | 154 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/types.rs     | 154 +--------------------------------------
 3 files changed, 158 insertions(+), 151 deletions(-)
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
index 000000000000..752eef31d45e
--- /dev/null
+++ b/rust/kernel/sync/aref.rs
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Built-in Reference Counting Support
+
+use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonNull};
+
+/// Types that are _always_ reference counted.
+///
+/// It allows such types to define their own custom ref increment and decrement functions.
+/// Additionally, it allows users to convert from a shared reference `&T` to an owned reference
+/// [`ARef<T>`].
+///
+/// This is usually implemented by wrappers to existing structures on the C side of the code. For
+/// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
+/// instances of a type.
+
+/// # Safety
+///
+/// Implementers must ensure that increments to the reference count keep the object alive in memory
+/// at least until matching decrements are performed.
+///
+/// Implementers must also ensure that all instances are reference-counted. (Otherwise they
+/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_ref`] keep the object
+/// alive.)
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
+    /// use kernel::types::{ARef, AlwaysRefCounted};
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

base-commit: 2009a2d5696944d85c34d75e691a6f3884e787c0
-- 
2.34.1


