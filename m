Return-Path: <linux-kernel+bounces-747775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B63B137F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3880E18825D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9AE2571AC;
	Mon, 28 Jul 2025 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3TBWuZq+"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057925C827
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695790; cv=none; b=l6tCEvMPfQKHjwD4IzerScxAJE2vARQQD9KiXV3AZFIMAqrfxBIkeQZorwKahOqsMp9DdswbdsFiJenn8IbqaILwd+1IoLy/+PyoXEv5wXiMkKB9IG8NewfhNRT/i2vK9hJayb963+/jjF+/FrNgXHR1bS5fyYgieT4l1T5pFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695790; c=relaxed/simple;
	bh=np/gcN5m4MW2LLygCOMOx8cuw1o8AFXIBEsbdvS7NOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jxOui01vG2mxSkdOusTOxDZBYM/eyO9ZFmpHZxWL2Nxpdn6/YerBDtgPfw0k3+Zygzq2wHJAme5hr4LrUNCnP51uXoWY85flLHJF6uDCGZ4frMuraByeKapbczQal7E1QH9evHwY7S7s6QNo/qoukuPDfQBKhrZovjkxX0H8lUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3TBWuZq+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4561bc2f477so20618605e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753695787; x=1754300587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f23mdrJtX4cECnR9yhw2cVkgQ/+P2GFW65BzXk2ui44=;
        b=3TBWuZq+/+3DywuBKk2hX0RLQ8CMgrLdkbZp5UQ2TljlRIuOS95bb6T6gas+ImLFDd
         CunTUk+6dz8shK8DDOa8YFMJYDCn4CEv+IQPfLe+aP6LdjgYNlRtlvbNkZVVZOf0jVlw
         k9NpQLMgWj5t8f0hDO9p/jbUJZYJG3HtCrOTI4qNyw85sIRtoL/yIHwssZN3kzS6AoDX
         k58CQYsOqhNITtoxCzyTkmU61tlQyTvsXIMwjHOYoKEU7+Elg4i9S1940W7vLxV33rDI
         sMjR4oJV9n20Qr6embBbwl+b17mSygWIG6kM2UbH5XxXPVhrxhgcI6ufENa24cg0wn+q
         UQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695787; x=1754300587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f23mdrJtX4cECnR9yhw2cVkgQ/+P2GFW65BzXk2ui44=;
        b=b4euOzGKqaac7T510A1IirupfKpMpm7sj3tWM/9SzeEQGUER+eozKfvpmUyX4VbHRZ
         dAtu6ttMdMMNkzbjZwvDuUlP0KQBJ308v5+ebiRV9jZ0muC/F8nnpjrMdUrEWyKpk+9u
         oN5/GQJx3HO2yqLe7c+e92Rej7ATLfWSiDmVvKndVSZgSSuFPuXhLCtvlUaNmhlCbnDJ
         Z4Jj6/5Z3hP9hM+5NllCmDwU3kPD4JSyM/k3rq23/4QsgyqPFHlYoqC15CwZLPO+rPQH
         tRshnGSkWDaBKZbk7CtUcmde6Hsqv9dV7WdN9EE4FeTwwR4myjwvuhNcouXlvIXjR0no
         /3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTc1/2nLdQaXAwYUYsE2sstPfGAa8L/QLy8EXkozhb9wPGTMPHQ5Lzb7CcG7blbG1Xxz8Idwh77LzTVEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDDxd5//QXKKKBxxHbu+pP4aNtfF2IjkVISO/3VVgKgXWKG+1F
	tqlxD/BMyYrivFLd7fxbH7CiZHDZUXJ/95BCtI4Er/K30lRN/EgiF644ugaMmBJjSW6tOAYQSL/
	Xa2M/otO6WPsUN40lbw==
X-Google-Smtp-Source: AGHT+IGZevCfpzMP0vuNgBaCdLJtz9mM/Oj9S8mRwI1C4qqC98ZGTEX33Mt7j7fTojLZ1GQiUAnGrHbESCLijmg=
X-Received: from wmbem22.prod.google.com ([2002:a05:600c:8216:b0:458:715c:51a1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c173:b0:456:18f3:b951 with SMTP id 5b1f17b1804b1-458788a2116mr89024445e9.15.1753695786877;
 Mon, 28 Jul 2025 02:43:06 -0700 (PDT)
Date: Mon, 28 Jul 2025 09:42:56 +0000
In-Reply-To: <20250728-lock-class-key-cleanup-v2-0-ad02b80c69e1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728-lock-class-key-cleanup-v2-0-ad02b80c69e1@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5390; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=np/gcN5m4MW2LLygCOMOx8cuw1o8AFXIBEsbdvS7NOE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoh0YnpX9fzxOyP2UjXbBtQu6a8QSJNk3YCJ0Pq
 okx/PVtJ+OJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaIdGJwAKCRAEWL7uWMY5
 Ro5+D/wLdui8frFRBP8zhE1x7IAQORblg1mlbn5H5VbU8M7Bnm7iN2zz7d4JaAhtubobWuvbcHT
 2jcehaXOPfMRReYhORIiN/Q9B/t2Aq1OxfjaGIIfagMTbPJ9m3DiwNcsBVsF5V4DTdT1sHGPXF1
 qTM1Ul29s8Dk/BPk+1I1NNNIi6NlA03ZGJFV0n0w1bmkFfG4vcRzY+9E3/m+vqdo5wBT/0+cdG1
 5Y9+C7zWOFDWG2d0elDfrx5OIG687lrbqEWzbyk3kikn9f7oYWenIfSJTZMPC7H0juwXNpFHT48
 969y7UnCOTw6f4HrVPkmXqxLiSthJm6R+VOzIfp+Ju1HVVMXcrO8jPSQPqu5ejTUgayrcqOEO+R
 Xtow0eBZNovdU7JTXWRr5lV3EbvwCKjg9iO0uOVVzBQ1KNzAdu/9iWpZVBqurQ2X4/1VpHt63hY
 35owKb2/yRE2wdwm8vlMVWbEtJAlUkN7kzuJ8bjJUq4FNSimQ7+Jaut6ku7drg8q4FlWx3iUljT
 931Sy9K6Fzxv2lMbsfE8ZwgD3oQOIOzuEWC/A9hQyvCBqtA2/lYYtuGwmvef9Ya4xXyNUlPvlwW
 v/dM7VudMHViSyn/Y+krndHE2kVkBr4M4aNPday+ZybvW2bnltyTvAjDK+5fiAtwwbbiU6O2sOF iGHW76vN7hKsytw==
X-Mailer: b4 0.14.2
Message-ID: <20250728-lock-class-key-cleanup-v2-2-ad02b80c69e1@google.com>
Subject: [PATCH v2 2/2] rust: sync: clean up LockClassKey and its docs
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Several aspects of the code and documentation for this type is
incomplete. Also several things are hidden from the docs. Thus, clean it
up and make it easier to read the rendered html docs.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync.rs | 55 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 2c04a3806ca885637583fde336d054426f569fe5..66d0a3c2f92d76213bc7fdb7b86d54d4835aee79 100644
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
@@ -41,29 +47,31 @@ unsafe impl Sync for LockClassKey {}
 impl LockClassKey {
     /// Initializes a statically allocated lock class key.
     ///
-    /// This is usually used indirectly through the [`static_lock_class!`] macro.
+    /// This is usually used indirectly through the [`static_lock_class!`] macro. See its
+    /// documentation for more information.
     ///
     /// # Safety
     ///
     /// * Before using the returned value, it must be pinned in a static memory location.
     /// * The destructor must never run on the returned `LockClassKey`.
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
@@ -81,7 +89,6 @@ impl LockClassKey {
     /// // SAFETY: We dropped `num`, the only use of the key, so the result of the previous
     /// // `borrow` has also been dropped. Thus, it's safe to use from_foreign.
     /// unsafe { drop(<Pin<KBox<LockClassKey>> as ForeignOwnable>::from_foreign(key_ptr)) };
-    ///
     /// # Ok::<(), Error>(())
     /// ```
     pub fn new_dynamic() -> impl PinInit<Self> {
@@ -91,7 +98,10 @@ pub fn new_dynamic() -> impl PinInit<Self> {
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
@@ -99,14 +109,28 @@ pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
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
@@ -118,6 +142,7 @@ macro_rules! static_lock_class {
         $crate::prelude::Pin::static_ref(&CLASS)
     }};
 }
+pub use static_lock_class;
 
 /// Returns the given string, if one is provided, otherwise generates one based on the source code
 /// location.

-- 
2.50.1.470.g6ba607880d-goog


