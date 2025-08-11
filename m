Return-Path: <linux-kernel+bounces-762573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5076EB2088D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF312A0096
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40DF2D3A88;
	Mon, 11 Aug 2025 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQAkPiLw"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CCB2D3A7D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914495; cv=none; b=kAxso18waiBNyIB1kimbj023gln7+9K19w0Ha0hRopY6Zb+32iMtrCp12PUnKKP75YpI8/w7brk4kRdPcqlByfKZVWnH4kOnyRjmU9W4pU5pC3Ye1KUVE4h3zGg0F1wTcplHiCfMStepx5UKAcVS4YhS0d9jA50RfX8bXmM/+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914495; c=relaxed/simple;
	bh=inTfcWxI21lPJQXzU7Z7N4p3NIN75VGU7CO1vyPBf3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ExZA2FWKFZFE/6OGbtOg/1S6CeAYBqyrauLCg43qXcsURutGZOHtojMlupikdMu6/qhM5G+hy+6wgSysD/LdvjSWexVKfiY3gZrHafg6+UkOGFCfjGVwr03c6HwsPC1WsHiwO1vDwZERem5cK1He0Y0yiSv5XPPFHulgf4LJPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQAkPiLw; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-458f710f364so28803155e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754914492; x=1755519292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZCn+l+D1CGJCLcrqTRoPw8oi4akGAOQLFK2AqKAUHY=;
        b=nQAkPiLw+bq1eAnE2onpsm9nsWUoAYNjBG8UCN7Bl//up1guLtUeBX/1S1/jOzHQQy
         EA5+hJzAgPavSGvbWcuqc3MYIVeOCYtEZUWbNunXOUsR/i0vnZ1tnGAtVp8g5qNRqR3G
         L3kicZuMwUe/HshmsXzP9uTJl915kN5wqy4hg7PDfTxWzAc+aTMQRRztW+701QbNRu+3
         eYFAR6CyDrl4QUc3vBYlV4LeQrvCFPSsXXMWwtsFzb6E040L8X9t+RecBOEblaoWBzRE
         ZOXX5CwjfSLXywjTM68UWXoCzmDSQZcrFI1JeUNkyaYBpegR7WYbx1TEAH8dQtg0dqMO
         8YMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754914492; x=1755519292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZCn+l+D1CGJCLcrqTRoPw8oi4akGAOQLFK2AqKAUHY=;
        b=MIxz33AAEBKbAxRlwflRKpVyP6W79Lg71L95L6fRJCtIqfjLjdRBsBZdImB4AglK34
         YkkSVrIp8LKlmbHUGUMeD7LDqf+3ZOoDT625xj7F9FUeuRCZA6EvIqgVZGkd4/6797d4
         My256GNg7IZmiA373YT+oUs936aKRqFMcPtry9/lf2FP5yP7UhBZF4uvYLWjOfQr9ry/
         hE8qqgOuXrpQFBE7VPDqtuOLn30r8ogWM7jdAoN3uhBRd9/97MgyGRdMe1H9fIR407lR
         0ezaZ2tT3hSInxbK1eG+WVt58KA8257PstDqFCUWqPD9WLuDZXm7kbF0KarmW+87lIhT
         zMvg==
X-Forwarded-Encrypted: i=1; AJvYcCU+deD8gE9eTBhEOF1b8Pn3pe+l0VrxJFqc2LKbS39H1OJWVZBY9Hkcfa+UG0pjq83HWJlmnFNnZ01amck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUT3mUArkWRt8OVw1LgPEXB7jOCV9ly8ZJJkBZahf1XLiB4OVI
	yLLeDZWm0JHm8ygzNspEpQYehrzH4TYk3puNEqZbtvaxcekyENx48kDOTHrheHl7fVrzOQC4aV2
	PULCE8dL5b+tYIp5H3Q==
X-Google-Smtp-Source: AGHT+IGthxGGZHHnxfv70ddY1DHuXNQT8gfP7qIFLwdVnhuFx0T/4h2bonVzzSaw010u6E1zor7w34zPzKdSbr8=
X-Received: from wrbeh9.prod.google.com ([2002:a05:6000:4109:b0:3b8:fa02:c0b5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2910:b0:3b8:d22d:a8ad with SMTP id ffacd0b85a97d-3b900b448e7mr10199506f8f.3.1754914492344;
 Mon, 11 Aug 2025 05:14:52 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:14:42 +0000
In-Reply-To: <20250811-lock-class-key-cleanup-v3-0-b12967ee1ca2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811-lock-class-key-cleanup-v3-0-b12967ee1ca2@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5390; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=inTfcWxI21lPJQXzU7Z7N4p3NIN75VGU7CO1vyPBf3Y=;
 b=kA0DAAoBBFi+7ljGOUYByyZiAGiZ3rjIzYoIGyUmQHhUCDLOD+Q9bpzMDqXFxXmi6h0kSDgrJ
 okCMwQAAQoAHRYhBIOSopRNZAcK8Ui9sgRYvu5YxjlGBQJomd64AAoJEARYvu5YxjlGfSUP/iph
 KCK9TZfTfT37CWWrVyHsV0vW+nEoofv21gNkA6nsFlwgvN6EgCHbu45OhLrqqfGjv2DLVyLMpMr
 1V+KhceeN9lISIKB7QOWeCzD0k1jXGSRGmPqRVrcI4egO7nf1Y0U0lmRzccM736zoIzntRgpOOn
 OEhCamoU59s4ZvVeZv9UELwqOdwDWzgthTbTSqDI2ztQLXrmiBwgxpTcwZR5qlItroK54UvUPe7
 faXzt43o1qy/C7phL8ugTlpDFKgHs9pPKR7NLIXyyI1AAH6e+ZG+Fzp7SykINMRrlWtFGN0e3lc
 qu+MPGEswBmtEu1x9CbokZdkOFHrndmgp97BLoaX0Y9RE8zy8Wj/ByvcFpmGbqhvgBcI02gVtn/
 PrYntsElfH/zpdEyEq0in0sxQUB50GS5m/n11eEQsk/uKhkgo+spE3s7W2o5u++e3bR9zwBNtww
 fv4KjT1YT1deK8f3bqAphkvFi9OayI6dE74yfqMI3dDZJv7gA5L96RlTDP77A5uP/2GsWvwYm4g
 aOQCVH28uk5Bgaq/DDa22Kvr0ExMkh0ieSUQfbYJ8gybXpLPRyqWX/zj7qZVEJXC/Qy2cqjOsW8
 EOmHDIf6AcbfAlK4XFXC5po5x26NBrfUN/86b7yVt8XfccImfgaIQLDx/GMIZx3tQs5AaDzVOeD zI9ZJ
X-Mailer: b4 0.14.2
Message-ID: <20250811-lock-class-key-cleanup-v3-2-b12967ee1ca2@google.com>
Subject: [PATCH v3 2/2] rust: sync: clean up LockClassKey and its docs
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
index edc75f8713ffb6de4025d7bb7e0a9c30cc66fa99..caf137923114bfaf3202413fe09a870f5e784017 100644
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
2.50.1.703.g449372360f-goog


