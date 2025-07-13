Return-Path: <linux-kernel+bounces-729196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A414B03314
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 23:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC55E3AD857
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 21:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3FB1F130A;
	Sun, 13 Jul 2025 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aucZDq+T"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4CC273F9;
	Sun, 13 Jul 2025 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752442604; cv=none; b=PnnLTF1rpogGSOYchYXpbInFmWAKU55zhOZbl3Q4jn+yulMRegYZjFshrtjVtWbxDk0WSDvlZSL4ZufNl6aLdWNprjmDU5cIbRZ0rsoLJsoXkIDCNoGWgzmjksmHy/r8daG/EmCDF+rEssX2irz5G5mQlCODeEAzRvlvHsyUYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752442604; c=relaxed/simple;
	bh=idIOgipqlCYU/T6ktDQT/beHECzA3uzWAgmANzMvpV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BFinxgT1PPjJ2ucFZFvtErid7/Do1WPCJ5agPQaVHsOUf5YuHtXuCDp2EVz4BBDGFK6Vo/LLTQHXCGN4S70dOO0tIdesLuPnshJAFVz0cYFELXbOZ6BEzuNj1rpEXuJOHv55hZgfyWfSFMDapYnGkBlqC5PpDz69iXE/juHdET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aucZDq+T; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3bcb168fd5so2128972a12.3;
        Sun, 13 Jul 2025 14:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752442601; x=1753047401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gM1i+nu9g2kcV+7xf8c/Mxb66BkmNbEi5B80DSIgCA=;
        b=aucZDq+Tr1fEIo4id8xlyDt8r73/ZX89AYD+EWb0QKqcIhBG2ESZxErWSRYAtiXzmH
         bi+1RQjv+ntMVqMx4mLjvut1FlOB7YNxN08uZgFq/w8+NjzS+rPhsACR+CQ8nzfCG3j5
         0NFkRQEqkVcPIKLYGimcJ4i9ErX8MhhxSlWBnUyr5qtqWRLusxJdeXMtPVlVeJqqmCEW
         3NjOw/UXRbMicWZfztOgO+fffS5VLfF1Ou6XqP4yUt/WPZXj9P/hd+VTa2ls6+isHMsj
         0y6yh7Xq0uw7PIphRMT7IwX+qnLFi3hmHQia1BIksuJEOfLjGy7nV/gOy9g/tTmISWV2
         oTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752442601; x=1753047401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gM1i+nu9g2kcV+7xf8c/Mxb66BkmNbEi5B80DSIgCA=;
        b=vLeTm4geFfdAf3z3BlnlgMQwl+lm/rN5Mfbxt09frWCFDZETLIS/K8JuI7Qld33dxF
         W1+v0IPJ67T4pRtsAueJ+dlvhQ+1Ec3DyihPxxQEk+rgywwtHffBCfztBM80TlHpY101
         A7mrtFRs7cP4hyT5AWB/2yTRozqu0JdedVRH78ikaWYLEBHXBrrht1HTU78r1SU26BlU
         lTrwuMYPcZycSImEOeLSq3BOVzQsW6E7ZBFyNkOPzv7fDV6A3iStS4SiA4+QKTZawoGU
         u7oB1CtwFvDUmNinRsroyvkkeaq8a02btj4UkYTVXoQb/bo82ClFxGrhTRDTNh/5lk7G
         97+g==
X-Forwarded-Encrypted: i=1; AJvYcCW3zo8KuhXu9BcI7XNYFzc5uDL0zevbXuYH+L3bnre8mVyXgkP3U3EWL1MpNS7vBMN9WIcwZed8xQ1qmquJIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbADsYO/gPIfF0YAseqQHTqBZq9PSli/Mb3/qAGNAPovE+CsEA
	qHXGZ3N2sB4n9O17UYAhe8OGfrqNGRJ64pDetzSXNflIcwFiPxHZWbepHTGjOOu/
X-Gm-Gg: ASbGncsgcfBTM6rB7GTNbb4t5JuZgHMU1pIKtnLloWphbjo4RQBVqgFAkZ5TPSrsWHL
	QTDfLKTV6IN0fRNIDWqm8YvdqU5VqRl2Hyaj9mHYTkbs6goh6AOOj7R+FrrJdAU7c8pjdCMWNUK
	vxcGGitP1NfB7ykj5DC/Qz5ypS9lBCvVEVjnRRI+0irG2nN+f74B7JvIpsPDEkXCRjX+GqsHRnl
	wb6ep+mx8lChEmoKKSE0wN3ZBBNFZ2TULNOH20jbCrNlt4ugcm+IdhuljhKqoc/pLWhZFvuHjX9
	z01sEY0KBrXZgBm5GeV7GRm2AfqiiQOOKOHDsGci4adcv4nb7/BTdwUz23ukslunKgh+nUQ6+sQ
	bZEhu81u+oDOVgONSZj24pG4LTSKFFORaKKAoHOs=
X-Google-Smtp-Source: AGHT+IERisCOpMXVByrmH6Uv/ozj0wii6UTrWs+dD6274+dxMw5dxwYqvN3J1Roh93Pljbd5dh3J9g==
X-Received: by 2002:a17:903:f76:b0:235:5d1:e366 with SMTP id d9443c01a7336-23dee1ab534mr128080085ad.10.1752442600893;
        Sun, 13 Jul 2025 14:36:40 -0700 (PDT)
Received: from shankari-IdeaPad.. ([49.128.169.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322e7fsm86308575ad.93.2025.07.13.14.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 14:36:40 -0700 (PDT)
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
Subject: [PATCH v3 1/4] rust: move ARef and AlwaysRefCounted to sync::aref
Date: Mon, 14 Jul 2025 03:06:13 +0530
Message-Id: <20250713213614.188921-1-shankari.ak0208@gmail.com>
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
v2 -> v3: Reverted the changes to docs, 
rewrote the title of aref.rs as suggested in the v2 review,
solved the styling error triggered by the kernel bot.
---
 rust/kernel/sync.rs      |   1 +
 rust/kernel/sync/aref.rs | 192 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/types.rs     | 154 +------------------------------
 3 files changed, 196 insertions(+), 151 deletions(-)
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
index 000000000000..c62dbb28282e
--- /dev/null
+++ b/rust/kernel/sync/aref.rs
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Built-in Reference Counting Support
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
+use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonNull};
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
+
+/// A sum type that always holds either a value of type `L` or `R`.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::types::Either;
+///
+/// let left_value: Either<i32, &str> = Either::Left(7);
+/// let right_value: Either<i32, &str> = Either::Right("right value");
+/// ```
+pub enum Either<L, R> {
+    /// Constructs an instance of [`Either`] containing a value of type `L`.
+    Left(L),
+
+    /// Constructs an instance of [`Either`] containing a value of type `R`.
+    Right(R),
+}
+
+/// Zero-sized type to mark types not [`Send`].
+///
+/// Add this type as a field to your struct if your type should not be sent to a different task.
+/// Since [`Send`] is an auto trait, adding a single field that is `!Send` will ensure that the
+/// whole type is `!Send`.
+///
+/// If a type is `!Send` it is impossible to give control over an instance of the type to another
+/// task. This is useful to include in types that store or reference task-local information. A file
+/// descriptor is an example of such task-local information.
+///
+/// This type also makes the type `!Sync`, which prevents immutable access to the value from
+/// several threads in parallel.
+pub type NotThreadSafe = PhantomData<*mut ()>;
+
+/// Used to construct instances of type [`NotThreadSafe`] similar to how `PhantomData` is
+/// constructed.
+///
+/// [`NotThreadSafe`]: type@NotThreadSafe
+#[allow(non_upper_case_globals)]
+pub const NotThreadSafe: NotThreadSafe = PhantomData;
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


