Return-Path: <linux-kernel+bounces-724333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EACAFF17E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6351BC0E86
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6C3242D65;
	Wed,  9 Jul 2025 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyPfKP61"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914982405E8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088190; cv=none; b=neMv1xj1oQuDylsFnFYjLQwc88EfjdLdKW9dY0eiu6MTkdmlGugTevhIEOBzLPw7k63iZDUwrHcT4QTUU9bVJKRgLxJVcpWS0S6AAsYWaX9Lk7S08b5/rmcKgEgvs3N2zbvuN+nVX2W/39EhNc0ZVGjl/YoCu1xzbCmZys1xN8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088190; c=relaxed/simple;
	bh=QRiqyW+DCxPHLC6LuzDOu/jPtN7jYe5i/M7V+NqpsBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KrUwWKhXKjYMRywyr4MMqrRJUuwonUEu9Z/p7gg40QXvhw5PUgbblyTkHka47WZCZFXSzNyBidDy78bvggLPFWU55pw5W/wHl7BB1Pql5VS9sDU67tvhE/U+tsT1Gmh9hC5QzHUU4Ne4YHkhXzbWoyMb/89m1smDwFeHJTaiAgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyPfKP61; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b38fc4d8dbaso262989a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752088188; x=1752692988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zPooK67XTY1HlJ292G/Ieoo/IDz4butYV3iYjuxKXdc=;
        b=OyPfKP61gVJuUuOPRoVhjzYH26G+Hp3MTahWwHsOiX2hxb0OnKuD57mDNWR/OZi4uw
         9FyMlzvVFodF9e1QHwbuC/Yof8j/1ACjZkLqN/ZYzhhtjTi8XsaYtOGrwe7n8GmHOcX3
         sLWAg/2BrmucvcIoyUzWZSk76lDJXwUq/1eEgLzuB4ESTX0E9XwATFJ1x1DDBYxoCr9S
         dAudvwvQFVl06rE+ajtYxH+TFT6b831FD0PQzGnF5lltNuPPNaYTCHdBzN2JzsR1mfbc
         vVsR76XS4sljqEUDXea35Bh9heeTriri7tdqrvbExI14zZEHb34Yg5zxbg/R8dDSb7nU
         Lt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088188; x=1752692988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPooK67XTY1HlJ292G/Ieoo/IDz4butYV3iYjuxKXdc=;
        b=lvCyb/FmreqNWWhnJFGJO8RtmWiPCd8X6eEkYEk0GwhjHbcLzprUajqfrEZTH+hUHY
         UYHquX6o4K9RbCxyt/sY/ZSzKYE4h9mpWNtB6xD0veq/M4hVngvP1DV53WTWRsDqgHyC
         9gYanSxJjKWAKwgPrlbPv4U2pzcwfFrv/h9IW/y5bZU5tyzr3VIlaHPvR94f/l4kAWkG
         AZkXFrvUJV205EZW5jv0iWk4cmKi9jq5sOaGoGxwxQnteSBLd/WMrbK7AfNmFC6CPG1a
         Fdtj6UtaTcHTkBV+twCEJov2tCjr54nmgK+wcLyfVJQhgQTC0w48M1kBZbMJxtjcR7Qm
         mLuw==
X-Gm-Message-State: AOJu0YxgQoIsz2SBfqQLg/ow3eiljSEHH3gKqk+ZUS/g0DHJJLqWZBZg
	9dhpuQ5nQ918eLzidIGHQyHg7rMoVlj1NMxt3fVNFQwrjEcWF/P6LDCzetl2+erTSwqcaiViIcy
	uDvWEHgsEyg==
X-Google-Smtp-Source: AGHT+IHWVMlOwYW++LmgsC4IEAN7tHaGgbzJ2Rx0MyZHTNqRafNy1V/OS6L5f3GoMD0S3BUQJzzfV/fr6IU2
X-Received: from pldr21.prod.google.com ([2002:a17:903:4115:b0:231:c831:9520])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32d1:b0:235:ea0d:ae10
 with SMTP id d9443c01a7336-23ddb2e1591mr61894145ad.12.1752088187813; Wed, 09
 Jul 2025 12:09:47 -0700 (PDT)
Date: Wed, 09 Jul 2025 19:09:29 +0000
In-Reply-To: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752088183; l=7413;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=QRiqyW+DCxPHLC6LuzDOu/jPtN7jYe5i/M7V+NqpsBs=; b=95F2k3uRDz2giN1M1JsUFd8J114spRlVrjgEZENf15eRCoPuYsJQvfs2GfzLUhB+vdjkfrrZV
 OSVcIob+5HjBWAwbDtubPmhjXfemvA4MPHdyogp8A0cEjBZx/WmtX4d
X-Mailer: b4 0.14.2
Message-ID: <20250709-debugfs-rust-v9-2-92b9eab5a951@google.com>
Subject: [PATCH v9 2/5] rust: debugfs: Bind file creation for long-lived Display
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

Allows creation of files for references that live forever and lack
metadata through the `Display` implementation.

The `Display` implementation is used because `seq_printf` needs to route
through `%pA`, which in turn routes through Arguments.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/kernel/debugfs.rs              | 62 ++++++++++++++++++++++++++++++++++++
 rust/kernel/debugfs/display_file.rs | 63 +++++++++++++++++++++++++++++++++++++
 rust/kernel/debugfs/entry.rs        |  8 +++++
 3 files changed, 133 insertions(+)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index 2359bd11cd664fb9f7206f8fe38f758dc43d2cb8..e5b6497d1deb67671d22ffd90cd5baa855bb9257 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -10,7 +10,10 @@
 use crate::str::CStr;
 #[cfg(CONFIG_DEBUG_FS)]
 use crate::sync::Arc;
+use core::fmt::Display;
 
+#[cfg(CONFIG_DEBUG_FS)]
+mod display_file;
 #[cfg(CONFIG_DEBUG_FS)]
 mod entry;
 #[cfg(CONFIG_DEBUG_FS)]
@@ -59,6 +62,43 @@ fn create(_name: &CStr, _parent: Option<&Dir>) -> Self {
         Self()
     }
 
+    #[cfg(CONFIG_DEBUG_FS)]
+    fn create_file<T: Display + Sized + Sync>(&self, name: &CStr, data: &'static T) -> File {
+        let Some(parent) = &self.0 else {
+            return File {
+                _entry: Entry::empty(),
+            };
+        };
+        // SAFETY:
+        // * `name` is a NUL-terminated C string, living across the call, by `CStr` invariant.
+        // * `parent` is a live `dentry` since we have a reference to it.
+        // * `vtable` is all stock `seq_file` implementations except for `open`.
+        //   `open`'s only requirement beyond what is provided to all open functions is that the
+        //   inode's data pointer must point to a `T` that will outlive it, which we know because
+        //   we have a static reference.
+        let ptr = unsafe {
+            bindings::debugfs_create_file_full(
+                name.as_char_ptr(),
+                0o444,
+                parent.as_ptr(),
+                data as *const _ as *mut _,
+                core::ptr::null(),
+                &<T as display_file::DisplayFile>::VTABLE,
+            )
+        };
+
+        // SAFETY: `debugfs_create_file_full` either returns an error code or a legal
+        // dentry pointer, so `Entry::new` is safe to call here.
+        let entry = unsafe { Entry::new(ptr, Some(parent.clone())) };
+
+        File { _entry: entry }
+    }
+
+    #[cfg(not(CONFIG_DEBUG_FS))]
+    fn create_file<T: Display + Sized + Sync>(&self, _name: &CStr, _data: &'static T) -> File {
+        File {}
+    }
+
     /// Create a DebugFS subdirectory.
     ///
     /// Subdirectory handles cannot outlive the directory handle they were created from.
@@ -75,6 +115,22 @@ pub fn subdir(&self, name: &CStr) -> Self {
         Dir::create(name, Some(self))
     }
 
+    /// Create a file in a DebugFS directory with the provided name, and contents from invoking
+    /// [`Display::fmt`] on the provided reference.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::c_str;
+    /// # use kernel::debugfs::Dir;
+    /// let dir = Dir::new(c_str!("my_debugfs_dir"));
+    /// dir.display_file(c_str!("foo"), &200);
+    /// // "my_debugfs_dir/foo" now contains the number 200.
+    /// ```
+    pub fn display_file<T: Display + Sized + Sync>(&self, name: &CStr, data: &'static T) -> File {
+        self.create_file(name, data)
+    }
+
     /// Create a new directory in DebugFS at the root.
     ///
     /// # Examples
@@ -88,3 +144,9 @@ pub fn new(name: &CStr) -> Self {
         Dir::create(name, None)
     }
 }
+
+/// Handle to a DebugFS file.
+pub struct File {
+    #[cfg(CONFIG_DEBUG_FS)]
+    _entry: Entry,
+}
diff --git a/rust/kernel/debugfs/display_file.rs b/rust/kernel/debugfs/display_file.rs
new file mode 100644
index 0000000000000000000000000000000000000000..2a58ca2685258b050089e4cfd62188885f7f5f04
--- /dev/null
+++ b/rust/kernel/debugfs/display_file.rs
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Google LLC.
+
+use crate::prelude::*;
+use crate::seq_file::SeqFile;
+use crate::seq_print;
+use core::fmt::Display;
+
+/// Implements `open` for `file_operations` via `single_open` to fill out a `seq_file`.
+///
+/// # Safety
+///
+/// * `inode`'s private pointer must point to a value of type `T` which will outlive the `inode`
+///   and will not have any unique references alias it during the call.
+/// * `file` must point to a live, not-yet-initialized file object.
+pub(crate) unsafe extern "C" fn display_open<T: Display + Sync>(
+    inode: *mut bindings::inode,
+    file: *mut bindings::file,
+) -> c_int {
+    // SAFETY:
+    // * `file` is acceptable by caller precondition.
+    // * `print_act` will be called on a `seq_file` with private data set to the third argument,
+    //   so we meet its safety requirements.
+    // * The `data` pointer passed in the third argument is a valid `T` pointer that outlives
+    //   this call by caller preconditions.
+    unsafe { bindings::single_open(file, Some(display_act::<T>), (*inode).i_private) }
+}
+
+/// Prints private data stashed in a seq_file to that seq file.
+///
+/// # Safety
+///
+/// `seq` must point to a live `seq_file` whose private data is a live pointer to a `T` which may
+/// not have any unique references alias it during the call.
+pub(crate) unsafe extern "C" fn display_act<T: Display + Sync>(
+    seq: *mut bindings::seq_file,
+    _: *mut c_void,
+) -> c_int {
+    // SAFETY: By caller precondition, this pointer is live, points to a value of type `T`, and
+    // there are not and will not be any unique references until we are done.
+    let data = unsafe { &*((*seq).private as *mut T) };
+    // SAFETY: By caller precondition, `seq_file` points to a live `seq_file`, so we can lift
+    // it.
+    let seq_file = unsafe { SeqFile::from_raw(seq) };
+    seq_print!(seq_file, "{}", data);
+    0
+}
+
+// Work around lack of generic const items.
+pub(crate) trait DisplayFile {
+    const VTABLE: bindings::file_operations;
+}
+
+impl<T: Display + Sync> DisplayFile for T {
+    const VTABLE: bindings::file_operations = bindings::file_operations {
+        read: Some(bindings::seq_read),
+        llseek: Some(bindings::seq_lseek),
+        release: Some(bindings::single_release),
+        open: Some(display_open::<Self>),
+        // SAFETY: `file_operations` supports zeroes in all fields.
+        ..unsafe { core::mem::zeroed() }
+    };
+}
diff --git a/rust/kernel/debugfs/entry.rs b/rust/kernel/debugfs/entry.rs
index ae0e2c4e1d58e878ebb081a71e4ac0f4a7d99b91..2baaf31c326c3071b92b5bc37552907fa1102246 100644
--- a/rust/kernel/debugfs/entry.rs
+++ b/rust/kernel/debugfs/entry.rs
@@ -38,6 +38,14 @@ pub(crate) unsafe fn new(entry: *mut bindings::dentry, parent: Option<Arc<Entry>
         }
     }
 
+    /// Constructs a placeholder DebugFS [`Entry`].
+    pub(crate) fn empty() -> Self {
+        Self {
+            entry: core::ptr::null_mut(),
+            _parent: None,
+        }
+    }
+
     /// Returns the pointer representation of the DebugFS directory.
     ///
     /// # Guarantees

-- 
2.50.0.727.gbf7dc18ff4-goog


