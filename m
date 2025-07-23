Return-Path: <linux-kernel+bounces-742434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81DCB0F1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55C3960609
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC20D2E5415;
	Wed, 23 Jul 2025 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZaOevE+"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B32E4990
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753271394; cv=none; b=rtfXG3MLjuZkdGXeiXDFBcWyMOwI4b72hvPBdpjbXrXAiZDYPsveduSSbKh4/F09xVKzDeF3ULh/ueF2EBsPZBknFpRucWTwiUmvzBEmhXqHOB4z72dN8p5lS75i+16E4Wh5Fzkc+oCnwiNcua2KxdbXM9T23+XHfMNi0e2HXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753271394; c=relaxed/simple;
	bh=Jl3j2KN6FsmwfKPXawUT3dvR57fP7gvUZdiSB23zpd0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y49GoKmIsy/D0l7g9vOrF5VHbNOpuWdacG+kEdgPEdGRpLxFjtvFZsnQQWepwgvCpqxRvOVjV1RABsFolxoG93Gd3NBIFFHBC1YXRQZieED4s8M+6pj75/+AjSxiI02vdez+KulMmrjdq3xfzZqGWuS//dng3Ot04jhDK/rsB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZaOevE+; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a5058f9ef4so2590720f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753271390; x=1753876190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PtSPCkq/PTayIKe2ZEyGHa8jliw50tdP9tCgSVooY1c=;
        b=sZaOevE+xzy/Y4msjeas0hryz8EP8NwNt9LS3wl7NRY7ZU7GL6trEcnkn2sMMai4IZ
         iZ3wnE1EwDFDP5omEjgEgkiR075UkE0duMIhpL6cdI9mfoUD5g6w+F33Z2rDr3sRorrh
         1FsVnsb3qsdCI0ccsm+Vn7sNDFcxotphJMlMjZlqjeKCG1hpXjzmMh2fDkZaX6yfdkSZ
         lxD1zuBHGOsgGGqxtAzM4gzZgYxPX2qubNmylXaHvD86pr5LQ88BuP7kfpiqPoIJTgZ6
         XPMPCTPqXLJAUc9UVQLZWsUc+eQ41lGMUrnxu23H+Szsq9w5GDItnW4Tm/b9Kes3MjIJ
         BabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753271390; x=1753876190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtSPCkq/PTayIKe2ZEyGHa8jliw50tdP9tCgSVooY1c=;
        b=TtNhkSW095Oty9QWM3izG3wg+3BTgsqya7uiu4MaI8jcMclE96KMlTSxYaDBXO5WyL
         MdeDBeEOkb6kDWB33pGSDnEtdv79j0qImTdQ89i7hjLS8D7WYu1loaEAKtZyMFOWtkGV
         NQovlovCeMOv3gV6Eubn77/4fX37cuNCItIB7odL3aIR6gzBd8trsmxg6jvervK8YwDk
         ZLAELa7d6INIavogTr/MetpIaWLOZU7VBh7QYBqWfwyqzwbXlkp6XCtIuondKF/gs1/j
         7R13IxdSeo9CT4TKF2D6qodta/8J5tzmh7rQhPKHj3qLNS064/YPJPpmEGCUDG/M8D9w
         IAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWBFDfAwXz4Vj1EgCfOm7iy1HERBGT+L/QrnFi5G16tvLaKjsTwP1rZS9lhSPu8kN15cZmA5Kzmwn7P34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW/DhnfnhBaYLM/Pz+wd71yx5aaWbK19qQ1vzBczJDUpGkR6HC
	Ly566lUE9sQXy4SvHuo0l2nkuuIx+dQCIYlQ1KdYT/quK0XlUFXg7IhjlpmJTjg/9ZlgeiW0H7g
	8Rzy4lIE3AOPU/4oZZw==
X-Google-Smtp-Source: AGHT+IHdfq3jPSpw+Px+tgVOWhCEwJdlmL2XUuwVX92V/cTj6nyl4IBAnuKF3apb5y4KsYLbN+JzZcHjk59+CUc=
X-Received: from wrbdq6.prod.google.com ([2002:a05:6000:cc6:b0:3a5:2a0b:d7a3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4383:b0:3b6:489:b7e5 with SMTP id ffacd0b85a97d-3b768f08603mr2466747f8f.49.1753271390536;
 Wed, 23 Jul 2025 04:49:50 -0700 (PDT)
Date: Wed, 23 Jul 2025 11:49:34 +0000
In-Reply-To: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5236; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Jl3j2KN6FsmwfKPXawUT3dvR57fP7gvUZdiSB23zpd0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBogMxauPienb7eYP64sRlrEKiQW4+3oEuovSTdn
 5ezk5T4NEaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaIDMWgAKCRAEWL7uWMY5
 Ro/nEACxtBqA4JBKPBWIOC09R19yxzSPlXAg0hSb1U58p/Q2qbjfGH5cNu6VkN/a/W2UViMblIr
 3iPI2AOQGSvKsjwySN2YLcINDjD+3a+G5JsV0v5RPlI46XCFcaWzYWz4ZX3fp/ECjqXH52CmpWZ
 yYiAMr24AV8Ndna+AneHtoxAxY6FM2JpMZpMg6M+Rk8pK0I/m0aMtkJ7LlQqwNoN97mazqxts7L
 BkgKJ6wyL1keJuQg6sIVb6mfbaw/huh0P96TdasgLe4U7XLFBozPmwvslO9IMPPi7ZaNBC01LPq
 tEmCaPRUHl26/PSYzp3AYtNbJYFNFzF+ojanmgvWTubxa9w8YLHn0HGV0to+guTIEvA5u8NvQaO
 Oap9cqVN5hF4CFx60E7PlT4T9bbppZy39CgpQxDLzYhGiXhQqFV+nBj2/8dRt+3TGNtKiB+jIeG
 Ji7VZWu/m14w8dC+ye2dLZ2SFZ8HNj7RBWtau48T8Nb257qpESjU8TQ5I9PH9R7QGG6cso4ZyjC
 /opth9zFnacD2UcjErm5AKKsDJn4FwjgMOyInuhE0HR1EIdQTV+gUmhdNvJfiGhVa6oOROOIlv4
 P8qFvPPFY71BwM9FB1vnAyG5nbDaHLmV7u8ieTOZnsE5FQhu5jH8b5Dh7deHBXa6J1yXlbWNZZb QGD+5Jyvoxc0lWQ==
X-Mailer: b4 0.14.2
Message-ID: <20250723-lock-class-key-cleanup-v1-2-85fa506b8ca4@google.com>
Subject: [PATCH 2/2] rust: sync: clean up LockClassKey and its docs
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Several aspects of the code and documentation for this type is
incomplete. Also several things are hidden from the docs. Thus, clean it
up and make it easier to read the rendered html docs.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync.rs | 55 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 9545bedf47b67976ab8c22d8368991cf1f382e42..5019a0bc95446fe30bad02ce040a1cbbe6d9ad5b 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -26,7 +26,9 @@
 pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
 pub use locked_by::LockedBy;
 
-/// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
+/// Represents a lockdep class.
+///
+/// Wraps the kernel's `struct lock_class_key`.
 #[repr(transparent)]
 #[pin_data(PinnedDrop)]
 pub struct LockClassKey {
@@ -34,6 +36,10 @@ pub struct LockClassKey {
     inner: Opaque<bindings::lock_class_key>,
 }
 
+// SAFETY: Unregistering a lock class key from a different thread than where it was registered is
+// allowed.
+unsafe impl Send for LockClassKey {}
+
 // SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
 // provides its own synchronization.
 unsafe impl Sync for LockClassKey {}
@@ -41,28 +47,30 @@ unsafe impl Sync for LockClassKey {}
 impl LockClassKey {
     /// Initializes a statically allocated lock class key.
     ///
-    /// This is usually used indirectly through the [`static_lock_class!`] macro.
+    /// This is usually used indirectly through the [`static_lock_class!`] macro. See its
+    /// documentation for more information.
     ///
     /// # Safety
     ///
     /// The destructor must never run on the returned `LockClassKey`.
-    #[doc(hidden)]
     pub const unsafe fn new_static() -> Self {
         LockClassKey {
             inner: Opaque::uninit(),
         }
     }
 
-    /// Initializes a dynamically allocated lock class key. In the common case of using a
-    /// statically allocated lock class key, the static_lock_class! macro should be used instead.
+    /// Initializes a dynamically allocated lock class key.
+    ///
+    /// In the common case of using a statically allocated lock class key, the
+    /// [`static_lock_class!`] macro should be used instead.
     ///
     /// # Examples
+    ///
     /// ```
-    /// # use kernel::c_str;
-    /// # use kernel::alloc::KBox;
-    /// # use kernel::types::ForeignOwnable;
-    /// # use kernel::sync::{LockClassKey, SpinLock};
-    /// # use pin_init::stack_pin_init;
+    /// use kernel::c_str;
+    /// use kernel::types::ForeignOwnable;
+    /// use kernel::sync::{LockClassKey, SpinLock};
+    /// use pin_init::stack_pin_init;
     ///
     /// let key = KBox::pin_init(LockClassKey::new_dynamic(), GFP_KERNEL)?;
     /// let key_ptr = key.into_foreign();
@@ -80,7 +88,6 @@ impl LockClassKey {
     /// // SAFETY: We dropped `num`, the only use of the key, so the result of the previous
     /// // `borrow` has also been dropped. Thus, it's safe to use from_foreign.
     /// unsafe { drop(<Pin<KBox<LockClassKey>> as ForeignOwnable>::from_foreign(key_ptr)) };
-    ///
     /// # Ok::<(), Error>(())
     /// ```
     pub fn new_dynamic() -> impl PinInit<Self> {
@@ -90,7 +97,10 @@ pub fn new_dynamic() -> impl PinInit<Self> {
         })
     }
 
-    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
+    /// Returns a raw pointer to the inner C struct.
+    ///
+    /// It is up to the caller to use the raw pointer correctly.
+    pub fn as_ptr(&self) -> *mut bindings::lock_class_key {
         self.inner.get()
     }
 }
@@ -98,14 +108,28 @@ pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
 #[pinned_drop]
 impl PinnedDrop for LockClassKey {
     fn drop(self: Pin<&mut Self>) {
-        // SAFETY: self.as_ptr was registered with lockdep and self is pinned, so the address
-        // hasn't changed. Thus, it's safe to pass to unregister.
+        // SAFETY: `self.as_ptr()` was registered with lockdep and `self` is pinned, so the address
+        // hasn't changed. Thus, it's safe to pass it to unregister.
         unsafe { bindings::lockdep_unregister_key(self.as_ptr()) }
     }
 }
 
 /// Defines a new static lock class and returns a pointer to it.
-#[doc(hidden)]
+///
+/// # Examples
+///
+/// ```
+/// use kernel::c_str;
+/// use kernel::sync::{static_lock_class, Arc, SpinLock};
+///
+/// fn new_locked_int() -> Result<Arc<SpinLock<u32>>> {
+///     Arc::pin_init(SpinLock::new(
+///         42,
+///         c_str!("new_locked_int"),
+///         static_lock_class!(),
+///     ), GFP_KERNEL)
+/// }
+/// ```
 #[macro_export]
 macro_rules! static_lock_class {
     () => {{
@@ -117,6 +141,7 @@ macro_rules! static_lock_class {
         $crate::prelude::Pin::static_ref(&CLASS)
     }};
 }
+pub use static_lock_class;
 
 /// Returns the given string, if one is provided, otherwise generates one based on the source code
 /// location.

-- 
2.50.0.727.gbf7dc18ff4-goog


