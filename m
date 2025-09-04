Return-Path: <linux-kernel+bounces-801645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3CAB4484E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D528C1C850CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815332C08C2;
	Thu,  4 Sep 2025 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LoqXfirR"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088EE2BE020
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020448; cv=none; b=a2SUpHM5m9TFmRRNwotibbR+pTg8mrv0A9V1EoecPLXI/Y8WlKsi4U55YW7vUBX+r7VzrCtxR0CD3D7tS526iyCjGzfMz87ONMKVMgM5rEeS+T/mHz/5SMfB5UeRJxLsJFwAg8FDm8extB6GpTHhTIp1ClgR+XupFGToGVFayjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020448; c=relaxed/simple;
	bh=ZUV/l0tgO0/gu7P9InBfYSi6gELScLGP48YsINmM9FQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D8LipFbbJ1hEK4RSTJ+KJpo6bniL79LHFFl1plKeT38MZhuHjGoQt+h54bJD1t7Bty2ResMfOoVXnem3nv9jF5UczOs9UBrN9z4w4PTx6Mek9gv7MtJxaZWJ3UJtUcR16sVnmX7UU+QBMFgX2/RK5Y/PmbwTK0H9l+jtfGnJN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LoqXfirR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445805d386so15662055ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757020445; x=1757625245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgnQBYuXpsRnOVkDIO8osDJStgMZHHV4XY3qeYJSpRo=;
        b=LoqXfirRS29kYH3TMG6CmtoL9R/6Oh00NIMUh0zcEL3YY+zj/dXxnfVLcBs9pqUfr1
         qgClULK1GM63JsXs3CJsdO47OmcD5kHpBLNe8IIAWjnHg0kaT6WKKkeVBPBqJhxiuJ3O
         j9sHKgaFcb6nxnsAod4CNYJrNJM3UPzdH/2j0yWGeRbwysm9yvSrrlFn8C4ey3wacPGn
         pXXA90zfvAOxmvZRteKp6SwT7x5RbgysOJ4WudsjwST3fppDFy4h/NcU7q3Sxf2WVqyE
         QuCKoC57zb/aMPx0j47xR8xqVy4HEskCsXO4F/vg9/NJPbYEK/wlK0yVcu35006zWTEA
         CfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757020445; x=1757625245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgnQBYuXpsRnOVkDIO8osDJStgMZHHV4XY3qeYJSpRo=;
        b=HpCRZa1r1JYg0a7Ji+d5xlyvbIQyyGvTjyMPplELL4Q12p5sMzHTa4+/LTnL9ymDm0
         zyLVj+PHyThZ//xiwmK0qSBwvnHaeio1fyd+H/yx/OuACrDONNCbsqwPKCwOCv/cLizZ
         LWj8c1EcVuJFPsw67Yhmd7ivBWI9YxeUkWjxViwq6T8C9Za+xcB3qG8JDo+VlHx/ytzC
         g01bmEooDBs0t2cJoua+9tVRIzs4/e+r/irE6B7gh/uAtDmkhJiHeMFx/GTLJ2uHlvVx
         hczrP1Hs0mHnjXHz65D/MlH/OUM70ibTZIB3AZDh+ytKo+gTXZlel5TOK1JYbGzavVCs
         03Kg==
X-Gm-Message-State: AOJu0YwaSi8qvbnwFkwX6q9sHJTSFu9L+DJ7ZTYH76/fTrSR1F7YYUy2
	cBtbL+aHOZ9/uC5kTh50n1uYM9H9Yi1xweSjIbK96mnh56tq2kMdhMEENIqob4jmoP3syKt2p+J
	leOsbjk/ecw==
X-Google-Smtp-Source: AGHT+IFFaO6y7SvElrpim9HOj1PeiwgqfzSjimV/D+OHG9aT4gphvY8EeN+mfgEO92TlQI5hYdduCEqy4ahZ
X-Received: from plbkv11.prod.google.com ([2002:a17:903:28cb:b0:24b:1148:97c5])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db03:b0:24b:1692:e0cc
 with SMTP id d9443c01a7336-24b1692e68amr154451625ad.15.1757020445290; Thu, 04
 Sep 2025 14:14:05 -0700 (PDT)
Date: Thu, 04 Sep 2025 21:13:53 +0000
In-Reply-To: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757020440; l=14493;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=ZUV/l0tgO0/gu7P9InBfYSi6gELScLGP48YsINmM9FQ=; b=Xk1DgkkNTmy2fGKP89cIBcCYC7piVsHDdE04eRRNSvtTc2UQ7WZQ5dryVy3x+rRsdl5bZX/b1
 ZK1RiGDyBkCBSgD8SVdME2X3PKxwuMYW80GXkvQQkcu9nJvZ/Ch2ncs
X-Mailer: b4 0.14.2
Message-ID: <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
Subject: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
From: Matthew Maurer <mmaurer@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>, 
	Dirk Beheme <dirk.behme@de.bosch.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

Extends the `debugfs` API to support creating read-only files. This
is done via the `Dir::read_only_file` method, which takes a data object
that implements the `Writer` trait.

The file's content is generated by the `Writer` implementation, and the
file is automatically removed when the returned `File` handle is
dropped.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/kernel/debugfs.rs          | 148 +++++++++++++++++++++++++++++++++++++++-
 rust/kernel/debugfs/entry.rs    |  42 ++++++++++++
 rust/kernel/debugfs/file_ops.rs | 128 ++++++++++++++++++++++++++++++++++
 rust/kernel/debugfs/traits.rs   |  33 +++++++++
 4 files changed, 350 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index 65be71600b8eda83c0d313f3d205d0713e8e9510..b28665f58cd6a17e188aef5e8c539f6c7433a3b0 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -8,12 +8,18 @@
 // When DebugFS is disabled, many parameters are dead. Linting for this isn't helpful.
 #![cfg_attr(not(CONFIG_DEBUG_FS), allow(unused_variables))]
 
-#[cfg(CONFIG_DEBUG_FS)]
 use crate::prelude::*;
 use crate::str::CStr;
 #[cfg(CONFIG_DEBUG_FS)]
 use crate::sync::Arc;
+use core::marker::PhantomPinned;
+use core::ops::Deref;
+
+mod traits;
+pub use traits::Writer;
 
+mod file_ops;
+use file_ops::{FileOps, ReadFile};
 #[cfg(CONFIG_DEBUG_FS)]
 mod entry;
 #[cfg(CONFIG_DEBUG_FS)]
@@ -53,6 +59,34 @@ fn create(name: &CStr, parent: Option<&Dir>) -> Self {
         Self()
     }
 
+    /// Creates a DebugFS file which will own the data produced by the initializer provided in
+    /// `data`.
+    fn create_file<'a, T, E: 'a>(
+        &'a self,
+        name: &'a CStr,
+        data: impl PinInit<T, E> + 'a,
+        file_ops: &'static FileOps<T>,
+    ) -> impl PinInit<File<T>, E> + 'a
+    where
+        T: Sync + 'static,
+    {
+        let scope = Scope::<T>::new(data, move |data| {
+            #[cfg(CONFIG_DEBUG_FS)]
+            if let Some(parent) = &self.0 {
+                // SAFETY: Because data derives from a scope, and our entry will be dropped before
+                // the data is dropped, it is guaranteed to outlive the entry we return.
+                unsafe { Entry::dynamic_file(name, parent.clone(), data, file_ops) }
+            } else {
+                Entry::empty()
+            }
+        });
+        try_pin_init! {
+            File {
+                scope <- scope
+            } ? E
+        }
+    }
+
     /// Create a new directory in DebugFS at the root.
     ///
     /// # Examples
@@ -79,4 +113,116 @@ pub fn new(name: &CStr) -> Self {
     pub fn subdir(&self, name: &CStr) -> Self {
         Dir::create(name, Some(self))
     }
+
+    /// Creates a read-only file in this directory.
+    ///
+    /// The file's contents are produced by invoking [`Writer::write`] on the value initialized by
+    /// `data`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::c_str;
+    /// # use kernel::debugfs::Dir;
+    /// # use kernel::prelude::*;
+    /// # let dir = Dir::new(c_str!("my_debugfs_dir"));
+    /// let file = KBox::pin_init(dir.read_only_file(c_str!("foo"), 200), GFP_KERNEL)?;
+    /// // "my_debugfs_dir/foo" now contains the number 200.
+    /// // The file is removed when `file` is dropped.
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn read_only_file<'a, T, E: 'a>(
+        &'a self,
+        name: &'a CStr,
+        data: impl PinInit<T, E> + 'a,
+    ) -> impl PinInit<File<T>, E> + 'a
+    where
+        T: Writer + Send + Sync + 'static,
+    {
+        let file_ops = &<T as ReadFile<_>>::FILE_OPS;
+        self.create_file(name, data, file_ops)
+    }
+}
+
+#[pin_data]
+/// Handle to a DebugFS scope, which ensures that attached `data` will outlive the provided
+/// [`Entry`] without moving.
+/// Currently, this is used to back [`File`] so that its `read` and/or `write` implementations
+/// can assume that their backing data is still alive.
+struct Scope<T> {
+    // This order is load-bearing for drops - `_entry` must be dropped before `data`.
+    #[cfg(CONFIG_DEBUG_FS)]
+    _entry: Entry,
+    #[pin]
+    data: T,
+    // Even if `T` is `Unpin`, we still can't allow it to be moved.
+    #[pin]
+    _pin: PhantomPinned,
+}
+
+#[pin_data]
+/// Handle to a DebugFS file, owning its backing data.
+///
+/// When dropped, the DebugFS file will be removed and the attached data will be dropped.
+pub struct File<T> {
+    #[pin]
+    scope: Scope<T>,
+}
+
+#[cfg(not(CONFIG_DEBUG_FS))]
+impl<'b, T: 'b> Scope<T> {
+    fn new<E: 'b, F>(data: impl PinInit<T, E> + 'b, init: F) -> impl PinInit<Self, E> + 'b
+    where
+        F: for<'a> FnOnce(&'a T) -> Entry + 'b,
+    {
+        try_pin_init! {
+            Self {
+                data <- data,
+                _pin: PhantomPinned
+            } ? E
+        }
+        .pin_chain(|scope| {
+            init(&scope.data);
+            Ok(())
+        })
+    }
+}
+
+#[cfg(CONFIG_DEBUG_FS)]
+impl<'b, T: 'b> Scope<T> {
+    fn entry_mut(self: Pin<&mut Self>) -> &mut Entry {
+        // SAFETY: _entry is not structurally pinned.
+        unsafe { &mut Pin::into_inner_unchecked(self)._entry }
+    }
+
+    fn new<E: 'b, F>(data: impl PinInit<T, E> + 'b, init: F) -> impl PinInit<Self, E> + 'b
+    where
+        F: for<'a> FnOnce(&'a T) -> Entry + 'b,
+    {
+        try_pin_init! {
+            Self {
+                _entry: Entry::empty(),
+                data <- data,
+                _pin: PhantomPinned
+            } ? E
+        }
+        .pin_chain(|scope| {
+            *scope.entry_mut() = init(&scope.data);
+            Ok(())
+        })
+    }
+}
+
+impl<T> Deref for Scope<T> {
+    type Target = T;
+    fn deref(&self) -> &T {
+        &self.data
+    }
+}
+
+impl<T> Deref for File<T> {
+    type Target = T;
+    fn deref(&self) -> &T {
+        &self.scope
+    }
 }
diff --git a/rust/kernel/debugfs/entry.rs b/rust/kernel/debugfs/entry.rs
index d2fba0e65e20e954e2a33e776b872bac4adb12e8..227fa50b7a79aeab49779e54b8c4241f455777c3 100644
--- a/rust/kernel/debugfs/entry.rs
+++ b/rust/kernel/debugfs/entry.rs
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2025 Google LLC.
 
+use crate::debugfs::file_ops::FileOps;
+use crate::ffi::c_void;
 use crate::str::CStr;
 use crate::sync::Arc;
 
@@ -40,6 +42,46 @@ pub(crate) fn dynamic_dir(name: &CStr, parent: Option<Arc<Self>>) -> Self {
         }
     }
 
+    /// # Safety
+    ///
+    /// * `data` must outlive the returned `Entry`.
+    pub(crate) unsafe fn dynamic_file<T>(
+        name: &CStr,
+        parent: Arc<Self>,
+        data: &T,
+        file_ops: &'static FileOps<T>,
+    ) -> Self {
+        // SAFETY: The invariants of this function's arguments ensure the safety of this call.
+        // * `name` is a valid C string by the invariants of `&CStr`.
+        // * `parent.as_ptr()` is a pointer to a valid `dentry` by invariant.
+        // * The caller guarantees that `data` will outlive the returned `Entry`.
+        // * The guarantees on `FileOps` assert the vtable will be compatible with the data we have
+        //   provided.
+        let entry = unsafe {
+            bindings::debugfs_create_file_full(
+                name.as_char_ptr(),
+                file_ops.mode(),
+                parent.as_ptr(),
+                core::ptr::from_ref(data) as *mut c_void,
+                core::ptr::null(),
+                &**file_ops,
+            )
+        };
+
+        Entry {
+            entry,
+            _parent: Some(parent),
+        }
+    }
+
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
diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_ops.rs
new file mode 100644
index 0000000000000000000000000000000000000000..c2fbef96580eaa2fab7cc8c1ba559c3284d12e1b
--- /dev/null
+++ b/rust/kernel/debugfs/file_ops.rs
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Google LLC.
+
+use super::Writer;
+use crate::prelude::*;
+use crate::seq_file::SeqFile;
+use crate::seq_print;
+use core::fmt::{Display, Formatter, Result};
+use core::marker::PhantomData;
+
+#[cfg(CONFIG_DEBUG_FS)]
+use core::ops::Deref;
+
+/// # Invariant
+///
+/// `FileOps<T>` will always contain an `operations` which is safe to use for a file backed
+/// off an inode which has a pointer to a `T` in its private data that is safe to convert
+/// into a reference.
+pub(super) struct FileOps<T> {
+    #[cfg(CONFIG_DEBUG_FS)]
+    operations: bindings::file_operations,
+    #[cfg(CONFIG_DEBUG_FS)]
+    mode: u16,
+    _phantom: PhantomData<T>,
+}
+
+impl<T> FileOps<T> {
+    /// # Safety
+    ///
+    /// The caller asserts that the provided `operations` is safe to use for a file whose
+    /// inode has a pointer to `T` in its private data that is safe to convert into a reference.
+    const unsafe fn new(operations: bindings::file_operations, mode: u16) -> Self {
+        Self {
+            #[cfg(CONFIG_DEBUG_FS)]
+            operations,
+            #[cfg(CONFIG_DEBUG_FS)]
+            mode,
+            _phantom: PhantomData,
+        }
+    }
+
+    #[cfg(CONFIG_DEBUG_FS)]
+    pub(crate) const fn mode(&self) -> u16 {
+        self.mode
+    }
+}
+
+#[cfg(CONFIG_DEBUG_FS)]
+impl<T> Deref for FileOps<T> {
+    type Target = bindings::file_operations;
+
+    fn deref(&self) -> &Self::Target {
+        &self.operations
+    }
+}
+
+struct WriterAdapter<T>(T);
+
+impl<'a, T: Writer> Display for WriterAdapter<&'a T> {
+    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
+        self.0.write(f)
+    }
+}
+
+/// Implements `open` for `file_operations` via `single_open` to fill out a `seq_file`.
+///
+/// # Safety
+///
+/// * `inode`'s private pointer must point to a value of type `T` which will outlive the `inode`
+///   and will not have any unique references alias it during the call.
+/// * `file` must point to a live, not-yet-initialized file object.
+unsafe extern "C" fn writer_open<T: Writer + Sync>(
+    inode: *mut bindings::inode,
+    file: *mut bindings::file,
+) -> c_int {
+    // SAFETY: The caller ensures that `inode` is a valid pointer.
+    let data = unsafe { (*inode).i_private };
+    // SAFETY:
+    // * `file` is acceptable by caller precondition.
+    // * `print_act` will be called on a `seq_file` with private data set to the third argument,
+    //   so we meet its safety requirements.
+    // * The `data` pointer passed in the third argument is a valid `T` pointer that outlives
+    //   this call by caller preconditions.
+    unsafe { bindings::single_open(file, Some(writer_act::<T>), data) }
+}
+
+/// Prints private data stashed in a seq_file to that seq file.
+///
+/// # Safety
+///
+/// `seq` must point to a live `seq_file` whose private data is a valid pointer to a `T` which may
+/// not have any unique references alias it during the call.
+unsafe extern "C" fn writer_act<T: Writer + Sync>(
+    seq: *mut bindings::seq_file,
+    _: *mut c_void,
+) -> c_int {
+    // SAFETY: By caller precondition, this pointer is valid pointer to a `T`, and
+    // there are not and will not be any unique references until we are done.
+    let data = unsafe { &*((*seq).private.cast::<T>()) };
+    // SAFETY: By caller precondition, `seq_file` points to a live `seq_file`, so we can lift
+    // it.
+    let seq_file = unsafe { SeqFile::from_raw(seq) };
+    seq_print!(seq_file, "{}", WriterAdapter(data));
+    0
+}
+
+// Work around lack of generic const items.
+pub(crate) trait ReadFile<T> {
+    const FILE_OPS: FileOps<T>;
+}
+
+impl<T: Writer + Sync> ReadFile<T> for T {
+    const FILE_OPS: FileOps<T> = {
+        let operations = bindings::file_operations {
+            read: Some(bindings::seq_read),
+            llseek: Some(bindings::seq_lseek),
+            release: Some(bindings::single_release),
+            open: Some(writer_open::<Self>),
+            // SAFETY: `file_operations` supports zeroes in all fields.
+            ..unsafe { core::mem::zeroed() }
+        };
+        // SAFETY: `operations` is all stock `seq_file` implementations except for `writer_open`.
+        // `open`'s only requirement beyond what is provided to all open functions is that the
+        // inode's data pointer must point to a `T` that will outlive it, which matches the
+        // `FileOps` requirements.
+        unsafe { FileOps::new(operations, 0o400) }
+    };
+}
diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.rs
new file mode 100644
index 0000000000000000000000000000000000000000..0e6e461324de42a3d80b692264d50e78a48f561d
--- /dev/null
+++ b/rust/kernel/debugfs/traits.rs
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Google LLC.
+
+//! Traits for rendering or updating values exported to DebugFS.
+
+use crate::sync::Mutex;
+use core::fmt::{self, Debug, Formatter};
+
+/// A trait for types that can be written into a string.
+///
+/// This works very similarly to `Debug`, and is automatically implemented if `Debug` is
+/// implemented for a type. It is also implemented for any writable type inside a `Mutex`.
+///
+/// The derived implementation of `Debug` [may
+/// change](https://doc.rust-lang.org/std/fmt/trait.Debug.html#stability)
+/// between Rust versions, so if stability is key for your use case, please implement `Writer`
+/// explicitly instead.
+pub trait Writer {
+    /// Formats the value using the given formatter.
+    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result;
+}
+
+impl<T: Writer> Writer for Mutex<T> {
+    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result {
+        self.lock().write(f)
+    }
+}
+
+impl<T: Debug> Writer for T {
+    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result {
+        writeln!(f, "{self:?}")
+    }
+}

-- 
2.51.0.355.g5224444f11-goog


