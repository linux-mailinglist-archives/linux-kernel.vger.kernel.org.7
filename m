Return-Path: <linux-kernel+bounces-724334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0DAFF17D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3945A609B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC38242D94;
	Wed,  9 Jul 2025 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yUu+Uqsx"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED14241680
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088191; cv=none; b=ehNa3qQ3cjrPCLZYs5UgMmheR4nxMKTaGp/H/Kcy4dfmN/cy8SDqsL615JeAfyEzu89qOpgY0geCal4jjmdoRGYw3g7oa0GOBdyfjRmPs0q3W0WTBT3kAXHmbltfMlRszouHsq0sxYlsKwmHSGt2C7ivLqjjSTGuQqtJ69oMil4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088191; c=relaxed/simple;
	bh=vClZs7+279+u3JU+CtWnditzSs55LyVZNeYQ3AsRgAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bv07SHxFbYw1xj7XQTRcew+muwJL8DPCPzFsBSDP4MJ2y+Avf/5XEH0mw58c98GIZ24AU2cT/rEWTKfEXUjy7Wa7no6q0Me0fndFdTlYFPwsOToOVl+pmqrZ2C1OZy9c9YexpDDwnlI1sWK4/PJ4H0FQyWsrcOU9OqKvJ3sPkN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yUu+Uqsx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748efefedb5so157449b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752088189; x=1752692989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkSaEMZguJnYB6nAxHEBOerDOjVtrb6rn4T/EUgMkSU=;
        b=yUu+UqsxZNF0zqaLRfgfJwPcYz70T5sZYG9uYZ2+gc5HlVXfmJm1Cn1v0uAiT3y3UR
         KECRL32OV2WEr72wxHJH8DK0wpPxgIhCeYsxmi2yY7yZQ1NqjpLaGLgfls+vBsvygQ4/
         lv2ozB/NxLEgaoO6+44LQpiZsgyc9QLkzGYZWEx9F3TLx8PBs9miAMPs+pdaFPM8IvLm
         Wjn9L7+6pRHMFbeDiUaZjryw4ASWoNPPjlV2/499EkZOJhegXOW8cAHz/Wgf3uFRY9a4
         1abzxPZmexVHlVkfgsfLtPVKjnj/q9uADe2Hl5TEIVakgn/AE7es40WgGZLfITzrefNP
         7OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088189; x=1752692989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkSaEMZguJnYB6nAxHEBOerDOjVtrb6rn4T/EUgMkSU=;
        b=lAbFPKwiJIWs69CFCAWgsa+XoMSenMjOjpSqek/ytRbkrSpBdK/5ii76icTr1rc/kV
         X6Kpbxm66jQO3Fzp6bRBOgOD6bKF3Mar2OurWdGUYXSJeIg/6vvpYg2uaOXx+pJ1pHIs
         yCTrJGVLbWrTj3l+/nS4DJXSiChf+Sx1acVIDzZb1CdAG6aRsogDtjM4HItgzGKB4nNX
         64EjiuJKDY9x0jrI71wUc23+S26ynCaOJTwxOQnaq/GT9iTnyOJghCqpOqZNy7MFOjvb
         Hzdh7dJ5ANCSrOSX6WTTbZfQCV3BhLqlGgQro0CNa0g9zv5lHG+UcFCtMSOsl9rhsiXI
         aCYQ==
X-Gm-Message-State: AOJu0YzOoLfi4jmTXrWT50BPv7zSyV7+/8ecq5YUixFj+AugBdhFZm80
	hrG+G5iniD8XoUx3cYRXEDR1cYBgTcetMNbBXdY99gFB6hq+oyd6HLLWX8zWCq8oDh6SVsNi4fE
	NW75g4Zr8EA==
X-Google-Smtp-Source: AGHT+IGPmy9r7ClYGJvVeQ9QKH+1IkCG0m923xuq+x2n6wWf1oi7t0yeUoZQBGMXnxRwXvAsNTPmk+wh0sLj
X-Received: from pfjc12.prod.google.com ([2002:a05:6a00:8c:b0:747:a8ac:ca05])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a10e:b0:224:a21:6b6f
 with SMTP id adf61e73a8af0-22cd7d94079mr5853974637.28.1752088189192; Wed, 09
 Jul 2025 12:09:49 -0700 (PDT)
Date: Wed, 09 Jul 2025 19:09:30 +0000
In-Reply-To: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752088183; l=7928;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=vClZs7+279+u3JU+CtWnditzSs55LyVZNeYQ3AsRgAc=; b=I2Dn/DK2EUuyTL5PD7d+3bnQH3KCuBsbJflss1ZAg+25tZVwIu6tH7LK96VD6q5JrA+78BoMn
 k2OnS8ZpRCHCoxHgZ/Wo/qCIsR3GPbSIu5ldDEHwVq6bqkyKAF5QADW
X-Mailer: b4 0.14.2
Message-ID: <20250709-debugfs-rust-v9-3-92b9eab5a951@google.com>
Subject: [PATCH v9 3/5] rust: debugfs: Support `PinInit` backing for `File`s.
From: Matthew Maurer <mmaurer@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

This allows `File`s to own their data, allowing DebugFS files to be
managed in sync with the data that backs them. Because DebugFS files are
intended to actually own data and provide access, `File`s still maintain
the same lifecycle for provided data when `CONFIG_DEBUG_FS` is disabled.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/kernel/debugfs.rs | 149 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 117 insertions(+), 32 deletions(-)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index e5b6497d1deb67671d22ffd90cd5baa855bb9257..a1a84dd309216f455ae8fe3d3c0fd00f957f82a9 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -5,12 +5,13 @@
 //!
 //! C header: [`include/linux/debugfs.h`](srctree/include/linux/debugfs.h)
 
-#[cfg(CONFIG_DEBUG_FS)]
-use crate::prelude::GFP_KERNEL;
+use crate::prelude::*;
 use crate::str::CStr;
 #[cfg(CONFIG_DEBUG_FS)]
 use crate::sync::Arc;
 use core::fmt::Display;
+use core::marker::PhantomPinned;
+use core::ops::Deref;
 
 #[cfg(CONFIG_DEBUG_FS)]
 mod display_file;
@@ -63,40 +64,78 @@ fn create(_name: &CStr, _parent: Option<&Dir>) -> Self {
     }
 
     #[cfg(CONFIG_DEBUG_FS)]
-    fn create_file<T: Display + Sized + Sync>(&self, name: &CStr, data: &'static T) -> File {
-        let Some(parent) = &self.0 else {
-            return File {
+    /// Creates a DebugFS file which will own the data produced by the initializer provided in
+    /// `data`.
+    ///
+    /// # Safety
+    ///
+    /// The provided vtable must be appropriate for implementing a seq_file if provided
+    /// with a private data pointer which provides shared access to a `T`.
+    unsafe fn create_file<'a, T: Sync, E, TI: PinInit<T, E>>(
+        &self,
+        name: &'a CStr,
+        data: TI,
+        vtable: &'static bindings::file_operations,
+    ) -> impl PinInit<File<T>, E> + use<'_, 'a, T, E, TI> {
+        try_pin_init! {
+            File {
                 _entry: Entry::empty(),
+                data <- data,
+                _pin: PhantomPinned,
+            } ? E
+        }
+        .pin_chain(|file| {
+            let Some(parent) = &self.0 else {
+                return Ok(());
             };
-        };
-        // SAFETY:
-        // * `name` is a NUL-terminated C string, living across the call, by `CStr` invariant.
-        // * `parent` is a live `dentry` since we have a reference to it.
-        // * `vtable` is all stock `seq_file` implementations except for `open`.
-        //   `open`'s only requirement beyond what is provided to all open functions is that the
-        //   inode's data pointer must point to a `T` that will outlive it, which we know because
-        //   we have a static reference.
-        let ptr = unsafe {
-            bindings::debugfs_create_file_full(
-                name.as_char_ptr(),
-                0o444,
-                parent.as_ptr(),
-                data as *const _ as *mut _,
-                core::ptr::null(),
-                &<T as display_file::DisplayFile>::VTABLE,
-            )
-        };
 
-        // SAFETY: `debugfs_create_file_full` either returns an error code or a legal
-        // dentry pointer, so `Entry::new` is safe to call here.
-        let entry = unsafe { Entry::new(ptr, Some(parent.clone())) };
+            // SAFETY:
+            // * `name` is a NUL-terminated C string, living across the call, by `CStr` invariant.
+            // * `parent` is a live `dentry` since we have a reference to it.
+            // * Since the file owns the `T` and it is pinned, we can safely assume the pointer
+            //   lives and is valid as long as we are.
+            // * Since the `Entry` will live in the `File`, it will be dropped before the pointer
+            //   is invalidated. Dropping the `Entry` will remove the DebugFS file and avoid
+            //   further access.
+            let ptr = unsafe {
+                bindings::debugfs_create_file_full(
+                    name.as_char_ptr(),
+                    0o444,
+                    parent.as_ptr(),
+                    &file.data as *const _ as *mut c_void,
+                    core::ptr::null(),
+                    vtable,
+                )
+            };
+
+            // SAFETY: `debugfs_create_file_full` either returns an error code or a legal
+            // dentry pointer, so `Entry::new` is safe to call here.
+            *file.entry_mut() = unsafe { Entry::new(ptr, Some(parent.clone())) };
 
-        File { _entry: entry }
+            Ok(())
+        })
     }
 
     #[cfg(not(CONFIG_DEBUG_FS))]
-    fn create_file<T: Display + Sized + Sync>(&self, _name: &CStr, _data: &'static T) -> File {
-        File {}
+    /// Creates a DebugFS file which will own the data produced by the initializer provided in
+    /// `data`.
+    ///
+    /// # Safety
+    ///
+    /// As DebugFS is disabled, this is actually entirely safe. It is marked unsafe for code
+    /// compatibility with the DebugFS-enabled variant.
+    unsafe fn create_file<'a, T: Sync, E, TI: PinInit<T, E>>(
+        &self,
+        _name: &'a CStr,
+        data: TI,
+        _vtable: (),
+    ) -> impl PinInit<File<T>, E> + use<'_, 'a, T, E, TI> {
+        try_pin_init! {
+            File {
+                data <- data,
+                _pin: PhantomPinned,
+            } ? E
+        }
     }
 
     /// Create a DebugFS subdirectory.
@@ -127,8 +166,32 @@ pub fn subdir(&self, name: &CStr) -> Self {
     /// dir.display_file(c_str!("foo"), &200);
     /// // "my_debugfs_dir/foo" now contains the number 200.
     /// ```
-    pub fn display_file<T: Display + Sized + Sync>(&self, name: &CStr, data: &'static T) -> File {
-        self.create_file(name, data)
+    ///
+    /// ```
+    /// # use kernel::c_str;
+    /// # use kernel::debugfs::Dir;
+    /// # use kernel::prelude::*;
+    /// let val = KBox::new(300, GFP_KERNEL)?;
+    /// let dir = Dir::new(c_str!("my_debugfs_dir"));
+    /// dir.display_file(c_str!("foo"), val);
+    /// // "my_debugfs_dir/foo" now contains the number 300.
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn display_file<'b, T: Display + Send + Sync, E, TI: PinInit<T, E>>(
+        &self,
+        name: &'b CStr,
+        data: TI,
+    ) -> impl PinInit<File<T>, E> + use<'_, 'b, T, E, TI> {
+        #[cfg(CONFIG_DEBUG_FS)]
+        let vtable = &<T as display_file::DisplayFile>::VTABLE;
+        #[cfg(not(CONFIG_DEBUG_FS))]
+        let vtable = ();
+
+        // SAFETY: `vtable` is all stock `seq_file` implementations except for `open`.
+        // `open`'s only requirement beyond what is provided to all open functions is that the
+        // inode's data pointer must point to a `T` that will outlive it, which is provided by
+        // `create_file`'s safety requirements.
+        unsafe { self.create_file(name, data, vtable) }
     }
 
     /// Create a new directory in DebugFS at the root.
@@ -146,7 +209,29 @@ pub fn new(name: &CStr) -> Self {
 }
 
 /// Handle to a DebugFS file.
-pub struct File {
+#[pin_data]
+pub struct File<T> {
+    // This order is load-bearing for drops - `_entry` must be dropped before `data`.
     #[cfg(CONFIG_DEBUG_FS)]
     _entry: Entry,
+    #[pin]
+    data: T,
+    // Even if `T` is `Unpin`, we still can't allow it to be moved.
+    #[pin]
+    _pin: PhantomPinned,
+}
+
+#[cfg(CONFIG_DEBUG_FS)]
+impl<T> File<T> {
+    fn entry_mut(self: Pin<&mut Self>) -> &mut Entry {
+        // SAFETY: _entry is not structurally pinned
+        unsafe { &mut Pin::into_inner_unchecked(self)._entry }
+    }
+}
+
+impl<T> Deref for File<T> {
+    type Target = T;
+    fn deref(&self) -> &T {
+        &self.data
+    }
 }

-- 
2.50.0.727.gbf7dc18ff4-goog


