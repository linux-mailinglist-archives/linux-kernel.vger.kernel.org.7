Return-Path: <linux-kernel+bounces-700683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5290BAE6B69
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 17:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EBA7B1EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 15:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7032DAFB6;
	Tue, 24 Jun 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5iT5cBb"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE663074AE
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778899; cv=none; b=TXUKWjwhzLt/DSQyUgRHraduZu8oMrBO498EGqaB485UjRXfs3KQNoJGpj++eKMfL5BggOWGa6gKFg/bYbDQS+m01i1aH4fVYa8tjJDHcDm8i8ijGIOkhEBq4v9xv2w9z8u0rrI7MfIpdYApg0TeA4aLDaeDUhKXs6bmGcFY8Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778899; c=relaxed/simple;
	bh=peN+bvKtriQzihD2XCaTJbAUUOuNoFI6C48PFSO1XRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CCt55iaXxawP5MrjbtgnvgWdxrkxM9QqIqNkmjjQjWc0n/WVxEusQgzTSEdle8UFVIzEnzJpTb6tN2eM85EUCSmvRpbXkkx+SbuY7vvpMETJO0y0Lv3LD/uDDCD80ApkjwuYt9L7BsLs7/gu0XV2slpcCxFaI25dsn9oDQCEpoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5iT5cBb; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-450d50eacafso4470325e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750778896; x=1751383696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2IkExrF99YG+DxQMnab3K3IgdvgL2KMBYLLGWFh2BU=;
        b=r5iT5cBbcHCSY0UTgysE2gsRINlvEkWn+rbTCDPSO6Eo7wg1xtapmnJSdYm8kIzX26
         Sgk+uzgYB6dLG8pJdaMIHePJ33F5todWYz9ecf2CLgjEr9Pdnn4kXAdqWa2x9w0x6eui
         wsLmI/9kUwPqLNyNW+5eTnOZ+AP9OAkgg/HglIkc94P+f9CEHUkTve4Z0Pe6ZB6bp39N
         H9zp2kBxA9hsZkN47XxLlG7azAp9Yu+QOsCyp9SWAZqWAMv78LwulYyadjBccGacmDPw
         0/ifKBn7JlexcTmWLfwztZ6njf69yjZf5e+P7CzUP3x260oEdG5iaA2/r2bwBaguZuMS
         DEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750778896; x=1751383696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2IkExrF99YG+DxQMnab3K3IgdvgL2KMBYLLGWFh2BU=;
        b=kcRMEKUv8gRZD+0XOI4TCMp7MZCPENkixb2dR4mR+aSVsccDsbiDPvG1JdD82RPe8x
         +1Z4BX4uXXsDJ5ac8cSxFm8qgIvobi34cUZdPUxBoZfe5iz5So4BsgUXRXNCoVG4TirM
         3IMNmeXN3WfHIYtxC588eS+l3o9fQpWTrGzoozGpaocK66blVV+ZK78b5TBR0eY1sO/u
         bdNwAiTwZsB72OtXwrE7FhdgGP4g2EpFJiIo5FRHRt1ryK7M8yAcnxWjD7805W2OJV92
         K9c+rfscX5w+0/5nMz1D2940dCERbogiecDZa0O2DXNo7GYErYMzaqWTkqrD3DldyTib
         ESRg==
X-Forwarded-Encrypted: i=1; AJvYcCWN3MulZ71jOHlqpTqY+6dLiZZaNN+d7w4ZxGHZicMFCsLPEPwqm3pvXxg3ua4qgIBJf5TiA4W8BAFXwxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz8GmezDAXVuUkWH1kaIp1QIOJbkVJMlxC5OuzPEQQjUptvR31
	ePcQxr1tG9h8fHzJzPT3hSRL/MfFi7vmdnehXu9fnAtWbmZaJ1ZcMrJnVP2EJNS98TImfddFwEu
	fojICC0a4wrBdipnFmg==
X-Google-Smtp-Source: AGHT+IEsYELmLcp+q5pese2gZ5+5lRYIC8d47Q+hmWHbOSr6E8D35YZ7BDB0sE+XJ7XXX59yF49DvSe0yueWynk=
X-Received: from wmbfs16.prod.google.com ([2002:a05:600c:3f90:b0:453:5a6:408d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5026:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-453654ce274mr178095355e9.14.1750778895994;
 Tue, 24 Jun 2025 08:28:15 -0700 (PDT)
Date: Tue, 24 Jun 2025 15:27:56 +0000
In-Reply-To: <20250624-opaque-from-raw-v2-0-e4da40bdc59c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624-opaque-from-raw-v2-0-e4da40bdc59c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=9600; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=peN+bvKtriQzihD2XCaTJbAUUOuNoFI6C48PFSO1XRo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoWsQIcfKqfBFigrYy10ZsG/0J2cMD7yeaoT8t8
 zb0F5JSUxuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaFrECAAKCRAEWL7uWMY5
 Ru3ZD/40WJRXsZ2GhE88fupZR1+SVP1WFuD99608gD6LoBp3fWgVWaLNg06WvYKANW1Kw/gd3po
 OB2mbwCZt/DJwGjlB3fQ+oa4HbTlpoSpY+wo5BOT6Y7/dYgZYPPdEdIHHrs3D73AHbRUSLv1aQk
 mtW5jSWTb0FnCQ5wcPoGLuwal2147ArZGZ/vQmTuDzI8896sVpXYcYDH4BERcKWSlv7vzP4Ak8Z
 aNg84m9LhCpcIo+/0IfFoXoLr+88Py2hBRy/zydqZMenHx4zcq9MhcpWeJANMTpSl1vdZ9NrNQP
 kXZq3VkrQnna8N68+a5PBAWnhTjZcCS/EaKn/yh07SRuEVv3D3xCIWK2c9c6xObvMLITB4fJf9T
 61513ZMZXGb52QvX3bnLws1aDLZEWq+Ds74y0QIyqqPi8WDqE1si5gWsPWwyHKMBf0Utu93JEPN
 3BU1WAIHuVWNq68Dkd/8kN9oLUDhfInvaUBvYUGVoFKZ3HhJ6D112JvrtE//znd5fElX1aJ6Eyc
 Pv/YSF0GEJju41Wwn1aEo/XDcDDW+VYzzjApi8rZOLnRbAqGG6N6zEdlamIj29hskC7PEVutYg0
 H/DKTAisBATr/qlD/2tZdRR9itEZrfTT8XT7iM5wgSQ6EyZn619pB/Pl7ZWcuV/ne2rq+6T3TaH tOpP5qcDg08bQNg==
X-Mailer: b4 0.14.2
Message-ID: <20250624-opaque-from-raw-v2-2-e4da40bdc59c@google.com>
Subject: [PATCH v2 2/2] rust: types: rename Opaque::raw_get to cast_into
From: Alice Ryhl <aliceryhl@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

In the previous patch we added Opaque::cast_from() that performs the
opposite operation to Opaque::raw_get(). For consistency with this
naming, rename raw_get() to cast_from().

There are a few other options such as calling cast_from() something
closer to raw_get() rather than renaming this method. However, I could
not find a great naming scheme that works with raw_get(). The previous
version of this patch used from_raw(), but functions of that name
typically have a different signature, so that's not a great option.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/configfs.rs                | 2 +-
 rust/kernel/init.rs                    | 6 +++---
 rust/kernel/lib.rs                     | 4 ++--
 rust/kernel/list.rs                    | 2 +-
 rust/kernel/list/impl_list_item_mod.rs | 4 ++--
 rust/kernel/time/hrtimer.rs            | 4 ++--
 rust/kernel/types.rs                   | 8 ++++----
 rust/kernel/workqueue.rs               | 2 +-
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 34d0bea4f9a517e890e5e0cdaa86698d397cd3b8..05d8c8ecfbb743ec60b13659f76c1d39e356d51a 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -279,7 +279,7 @@ pub fn new(
 // within the `group` field.
 unsafe impl<Data> HasGroup<Data> for Group<Data> {
     unsafe fn group(this: *const Self) -> *const bindings::config_group {
-        Opaque::raw_get(
+        Opaque::cast_into(
             // SAFETY: By impl and function safety requirements this field
             // projection is within bounds of the allocation.
             unsafe { &raw const (*this).group },
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 8d228c23795445e379b40f662e1c355a934cbd13..cf5eaad8c730deb3ae400bced1f226c8a93e76fb 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -108,13 +108,13 @@
 //!                 let foo = addr_of_mut!((*slot).foo);
 //!
 //!                 // Initialize the `foo`
-//!                 bindings::init_foo(Opaque::raw_get(foo));
+//!                 bindings::init_foo(Opaque::cast_into(foo));
 //!
 //!                 // Try to enable it.
-//!                 let err = bindings::enable_foo(Opaque::raw_get(foo), flags);
+//!                 let err = bindings::enable_foo(Opaque::cast_into(foo), flags);
 //!                 if err != 0 {
 //!                     // Enabling has failed, first clean up the foo and then return the error.
-//!                     bindings::destroy_foo(Opaque::raw_get(foo));
+//!                     bindings::destroy_foo(Opaque::cast_into(foo));
 //!                     return Err(Error::from_errno(err));
 //!                 }
 //!
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 529ce907499679997415cbaa6a97ac3939587a11..f61ac6f81f5d7cfd97045438bae25884aa1a141b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -204,11 +204,11 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
 
 /// Produces a pointer to an object from a pointer to one of its fields.
 ///
-/// If you encounter a type mismatch due to the [`Opaque`] type, then use [`Opaque::raw_get`] or
+/// If you encounter a type mismatch due to the [`Opaque`] type, then use [`Opaque::cast_into`] or
 /// [`Opaque::cast_from`] to resolve the mismatch.
 ///
 /// [`Opaque`]: crate::types::Opaque
-/// [`Opaque::raw_get`]: crate::types::Opaque::raw_get
+/// [`Opaque::cast_into`]: crate::types::Opaque::cast_into
 /// [`Opaque::cast_from`]: crate::types::Opaque::cast_from
 ///
 /// # Safety
diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index c391c30b80f890273a0c2ce5ae1a6a66ecedce90..dd9d4d8f63d0953432e1e9c033ff6185692b6a87 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -284,7 +284,7 @@ pub fn new() -> impl PinInit<Self> {
     #[inline]
     unsafe fn fields(me: *mut Self) -> *mut ListLinksFields {
         // SAFETY: The caller promises that the pointer is valid.
-        unsafe { Opaque::raw_get(ptr::addr_of!((*me).inner)) }
+        unsafe { Opaque::cast_into(ptr::addr_of!((*me).inner)) }
     }
 
     /// # Safety
diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index a0438537cee12d4a1772a9f12dd6eb6b772060db..9df7c52604947342cc0172a620e7014a7fea7062 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -209,7 +209,7 @@ unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate::list::ListLinks<$nu
                 // the pointer stays in bounds of the allocation.
                 let self_ptr = unsafe { (links_field as *const u8).add(spoff) }
                     as *const $crate::types::Opaque<*const Self>;
-                let cell_inner = $crate::types::Opaque::raw_get(self_ptr);
+                let cell_inner = $crate::types::Opaque::cast_into(self_ptr);
 
                 // SAFETY: This value is not accessed in any other places than `prepare_to_insert`,
                 // `post_remove`, or `view_value`. By the safety requirements of those methods,
@@ -252,7 +252,7 @@ unsafe fn view_value(links_field: *mut $crate::list::ListLinks<$num>) -> *const
                 // the pointer stays in bounds of the allocation.
                 let self_ptr = unsafe { (links_field as *const u8).add(spoff) }
                     as *const ::core::cell::UnsafeCell<*const Self>;
-                let cell_inner = ::core::cell::UnsafeCell::raw_get(self_ptr);
+                let cell_inner = ::core::cell::UnsafeCell::cast_into(self_ptr);
                 // SAFETY: This is not a data race, because the only function that writes to this
                 // value is `prepare_to_insert`, but by the safety requirements the
                 // `prepare_to_insert` method may not be called in parallel with `view_value` or
diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 9df3dcd2fa3942f75ee8471459734621f8dfb16a..3d39bb331d7f10a9dd6cf694b0040d1e9c438685 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -148,7 +148,7 @@ unsafe fn raw_get(this: *const Self) -> *mut bindings::hrtimer {
         // SAFETY: The field projection to `timer` does not go out of bounds,
         // because the caller of this function promises that `this` points to an
         // allocation of at least the size of `Self`.
-        unsafe { Opaque::raw_get(core::ptr::addr_of!((*this).timer)) }
+        unsafe { Opaque::cast_into(core::ptr::addr_of!((*this).timer)) }
     }
 
     /// Cancel an initialized and potentially running timer.
@@ -172,7 +172,7 @@ unsafe fn raw_get(this: *const Self) -> *mut bindings::hrtimer {
     /// `this` must point to a valid `Self`.
     pub(crate) unsafe fn raw_cancel(this: *const Self) -> bool {
         // SAFETY: `this` points to an allocation of at least `HrTimer` size.
-        let c_timer_ptr = unsafe { HrTimer::raw_get(this) };
+        let c_timer_ptr = unsafe { HrTimer::cast_into(this) };
 
         // If the handler is running, this will wait for the handler to return
         // before returning.
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 82e0c6fa5646dfd2aea52c8fe9ada769ad427e50..382e9f704c3eb55e2c16ae666c06c165e07b3397 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -377,7 +377,7 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> impl PinInit<Self> {
         // initialize the `T`.
         unsafe {
             pin_init::pin_init_from_closure::<_, ::core::convert::Infallible>(move |slot| {
-                init_func(Self::raw_get(slot));
+                init_func(Self::cast_into(slot));
                 Ok(())
             })
         }
@@ -397,7 +397,7 @@ pub fn try_ffi_init<E>(
         // SAFETY: We contain a `MaybeUninit`, so it is OK for the `init_func` to not fully
         // initialize the `T`.
         unsafe {
-            pin_init::pin_init_from_closure::<_, E>(move |slot| init_func(Self::raw_get(slot)))
+            pin_init::pin_init_from_closure::<_, E>(move |slot| init_func(Self::cast_into(slot)))
         }
     }
 
@@ -410,11 +410,11 @@ pub const fn get(&self) -> *mut T {
     ///
     /// This function is useful to get access to the value without creating intermediate
     /// references.
-    pub const fn raw_get(this: *const Self) -> *mut T {
+    pub const fn cast_into(this: *const Self) -> *mut T {
         UnsafeCell::raw_get(this.cast::<UnsafeCell<MaybeUninit<T>>>()).cast::<T>()
     }
 
-    /// The opposite operation of [`Opaque::raw_get`].
+    /// The opposite operation of [`Opaque::cast_into`].
     pub const fn cast_from(this: *const T) -> *const Self {
         this.cast()
     }
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index d092112d843f3225ea582e013581b39e36652a84..a3085a56419db9a7d4c4b757ddd0964b59e453f9 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -403,7 +403,7 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
         //
         // A pointer cast would also be ok due to `#[repr(transparent)]`. We use `addr_of!` so that
         // the compiler does not complain that the `work` field is unused.
-        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).work)) }
+        unsafe { Opaque::cast_into(core::ptr::addr_of!((*ptr).work)) }
     }
 }
 

-- 
2.50.0.714.g196bf9f422-goog


