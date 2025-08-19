Return-Path: <linux-kernel+bounces-776612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA6FB2CF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 623F77B02AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CEF26FDBB;
	Tue, 19 Aug 2025 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ySrS5Yrt"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC1258EE9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755644031; cv=none; b=XWHACFzOZv5P9sY8zlqjDIlen904gAZJDzGoChGBszXof+4AhMdwi6EXmSE00f6ZV7kWtjL7nULVs0Zu3vzIrilWtRL9Y5zQXabpS66poMjQoVnfq2AjsBMXVP4mCg1XHwexg9B91uTiUuelRwLUb7HB3O+jvAd9iHF75xv/PoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755644031; c=relaxed/simple;
	bh=O+A6dgp2BS8VYQ5vzwke7ZnXg1yBMRZ4JxfOHZfkf4w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Czt5Ywe8hpKbxPT02dJvkXWuc/rBA4KGlc1uUFqdfOOlhbTOhuIdSUGskTy+lpr7OqxBe7bz4xQqw2jx8HNjjHC2SR9qloh/Mky3Z2tiYTFLKM9oduhpYvv5JPJWPgdCtQBOHwjunuj+SJEKRvVzFsvp9EKMrzQu6GAQwUJuOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ySrS5Yrt; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457f44a29so71736725ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755644029; x=1756248829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bcGp6peJGEPcea/LfRat8rVkOX5gU/294WJfcP8Kk0=;
        b=ySrS5Yrt0Exl+RZ4xukUxHONIbGoOPyUo+SRnHYEI/D2p7IwDHmLczdY8fLWV98l75
         MH2o4hWBDVElpA3VmsLomMb2HQwGT2TK4ru374hKV46ZGFbNpkTfuNeG8RJePm3/jW1e
         WcDhsSWjQ8v5Tud9bL64ilo//MInlt9UvoVHBKXd1ljlc8l7WEm/AqyLtuMhK08EDIcN
         PbAd65h5t3yG9DhCz6b3BzRvJMxYdca79UgB2QrZ5/KU0k5qSlsFYZkua/Z1Tvln/13T
         wOa2mM3NOtuWWjP3QOsH+knXRoQGVZTk1/JbeZuyfFtRFx8GftLo33hneXl5RNYU/pus
         e7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755644029; x=1756248829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bcGp6peJGEPcea/LfRat8rVkOX5gU/294WJfcP8Kk0=;
        b=FvWbW/WqLPNMxU9ujTGpWCsf6mWYLsGqJVwUwU6+jy6ylEknm6xHWfArdYAk6vutUP
         RWlNi8y4mZUJrnw6ZQVPnNj38oNLt6YFFK695fjZQ3Ef3GpNjS1Gu5BriiCmhLmbZOy2
         O0q0DNz72d0RZiB5CnhI6MlucvjjNpwmSw8icmtwuNf8GHinDXlOF0byZhRj9cecrCdz
         /qJOOB93pxstzg4cz2gnXAaoJkE3u5NmohmoIbdaYTw6Xq7cCoTbpkmJ3MGRGQpUIxAX
         44YoZvLQJjSFz0N1X46KRtUwfjVLJ4H43cQOZyM9W8fbNIpQAsAYOeeC+ksgYFXQlraW
         wprQ==
X-Gm-Message-State: AOJu0YzyageG2a6onyr5uf61WC39zq0RnFq16NUHesnVsBFvgD27Vd3B
	9wGj0/K5rRKRCgDrOI5yZm6CkrzZaWWORy1iNilfQh4vBuXeFgt4QHGoNuT6PhkWnKGvRj2ctQ/
	gAGd6FILgAQ==
X-Google-Smtp-Source: AGHT+IGI+obYjde/gY6lcO3uPnCqStCuQ/C4QjHznPDL7Oi9XnQ5kAT5YtFaewtYLwGWYsrBoJ6V32tIcBUE
X-Received: from plhu2.prod.google.com ([2002:a17:903:1242:b0:23f:fd13:e74d])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f312:b0:244:9c27:9829
 with SMTP id d9443c01a7336-245ef113d3cmr4376245ad.10.1755644029432; Tue, 19
 Aug 2025 15:53:49 -0700 (PDT)
Date: Tue, 19 Aug 2025 22:53:38 +0000
In-Reply-To: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755644022; l=10824;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=O+A6dgp2BS8VYQ5vzwke7ZnXg1yBMRZ4JxfOHZfkf4w=; b=Znvy+yVFxzuQ41yLC/kMxLvFcKXS/+upGpgyKn1EAbmIqrb56WY6yRVYamYZM05sZbl7hv+6v
 JtYa+rKAHacDE7+4cc+eQ1BQNfKHtDZ4/lsJcIFu9/CtEPpxtHRyWVe
X-Mailer: b4 0.14.2
Message-ID: <20250819-debugfs-rust-v10-3-86e20f3cf3bb@google.com>
Subject: [PATCH v10 3/7] rust: debugfs: Add support for writable files
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

Extends the `debugfs` API to support creating writable files. This
is done via the `Dir::write_only_file` and `Dir::read_write_file`
methods, which take a data object that implements the `UpdateFromSlice`
trait.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/kernel/debugfs.rs          |  41 +++++++++++++-
 rust/kernel/debugfs/file_ops.rs | 115 +++++++++++++++++++++++++++++++++++++++-
 rust/kernel/debugfs/traits.rs   |  69 ++++++++++++++++++++++++
 3 files changed, 222 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index 875d433fc3608cc9ffcf022d7c00cb207016f146..62bc2b1d4e5a4b21441a09e03bff74c32c6781d2 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -16,10 +16,10 @@
 use core::ops::Deref;
 
 mod traits;
-pub use traits::Render;
+pub use traits::{Render, UpdateFromSlice};
 
 mod file_ops;
-use file_ops::{FileOps, ReadFile};
+use file_ops::{FileOps, ReadFile, ReadWriteFile, WriteFile};
 #[cfg(CONFIG_DEBUG_FS)]
 mod entry;
 #[cfg(CONFIG_DEBUG_FS)]
@@ -136,6 +136,43 @@ pub fn read_only_file<'a, T: Render + Send + Sync + 'static, E: 'a, TI: PinInit<
         let file_ops = &<T as ReadFile<_>>::FILE_OPS;
         self.create_file(name, data, file_ops)
     }
+
+    /// Creates a read-write file in this directory.
+    ///
+    /// Reading the file uses the [`Render`] implementation.
+    /// Writing to the file uses the [`UpdateFromSlice`] implementation.
+    pub fn read_write_file<
+        'a,
+        T: Render + UpdateFromSlice + Send + Sync + 'static,
+        E: 'a,
+        TI: PinInit<T, E> + 'a,
+    >(
+        &'a self,
+        name: &'a CStr,
+        data: TI,
+    ) -> impl PinInit<File<T>, E> + 'a {
+        let file_ops = &<T as ReadWriteFile<_>>::FILE_OPS;
+        self.create_file(name, data, file_ops)
+    }
+
+    /// Creates a write-only file in this directory.
+    ///
+    /// The file owns its backing data. Writing to the file uses the [`UpdateFromSlice`]
+    /// implementation.
+    ///
+    /// The file is removed when the returned [`File`] is dropped.
+    pub fn write_only_file<
+        'a,
+        T: UpdateFromSlice + Send + Sync + 'static,
+        E: 'a,
+        TI: PinInit<T, E> + 'a,
+    >(
+        &'a self,
+        name: &'a CStr,
+        data: TI,
+    ) -> impl PinInit<File<T>, E> + 'a {
+        self.create_file(name, data, &T::FILE_OPS)
+    }
 }
 
 #[pin_data]
diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_ops.rs
index 134ac26e80f2e5b9cae53ed5a00462af7ce1aa38..30f6a0532c7f5f4a2974edc8f1100f5485aa8da9 100644
--- a/rust/kernel/debugfs/file_ops.rs
+++ b/rust/kernel/debugfs/file_ops.rs
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2025 Google LLC.
 
-use super::Render;
+use super::{Render, UpdateFromSlice};
 use crate::prelude::*;
 use crate::seq_file::SeqFile;
 use crate::seq_print;
+use crate::uaccess::UserSlice;
 use core::fmt::{Display, Formatter, Result};
 use core::marker::PhantomData;
 
@@ -123,3 +124,115 @@ impl<T: Render + Sync> ReadFile<T> for T {
         unsafe { FileOps::new(operations, 0o400) }
     };
 }
+
+fn update<T: UpdateFromSlice + Sync>(data: &T, buf: *const c_char, count: usize) -> isize {
+    let mut reader = UserSlice::new(UserPtr::from_ptr(buf as *mut c_void), count).reader();
+
+    if let Err(e) = data.update_from_slice(&mut reader) {
+        return e.to_errno() as isize;
+    }
+
+    count as isize
+}
+
+/// # Safety
+///
+/// `file` must be a valid pointer to a `file` struct.
+/// The `private_data` of the file must contain a valid pointer to a `seq_file` whose
+/// `private` data in turn points to a `T` that implements `UpdateFromSlice`.
+/// `buf` must be a valid user-space buffer.
+pub(crate) unsafe extern "C" fn write<T: UpdateFromSlice + Sync>(
+    file: *mut bindings::file,
+    buf: *const c_char,
+    count: usize,
+    _ppos: *mut bindings::loff_t,
+) -> isize {
+    // SAFETY: The file was opened with `single_open`, which sets `private_data` to a `seq_file`.
+    let seq = unsafe { &mut *((*file).private_data.cast::<bindings::seq_file>()) };
+    // SAFETY: By caller precondition, this pointer is live and points to a value of type `T`.
+    let data = unsafe { &*(seq.private as *const T) };
+    update(data, buf, count)
+}
+
+// A trait to get the file operations for a type.
+pub(crate) trait ReadWriteFile<T> {
+    const FILE_OPS: FileOps<T>;
+}
+
+impl<T: Render + UpdateFromSlice + Sync> ReadWriteFile<T> for T {
+    const FILE_OPS: FileOps<T> = {
+        let operations = bindings::file_operations {
+            open: Some(render_open::<T>),
+            read: Some(bindings::seq_read),
+            write: Some(write::<T>),
+            llseek: Some(bindings::seq_lseek),
+            release: Some(bindings::single_release),
+            // SAFETY: `file_operations` supports zeroes in all fields.
+            ..unsafe { core::mem::zeroed() }
+        };
+        // SAFETY: `operations` is all stock `seq_file` implementations except for `render_open`
+        // and `write`.
+        // `render_open`'s only requirement beyond what is provided to all open functions is that
+        // the inode's data pointer must point to a `T` that will outlive it, which matches the
+        // `FileOps` requirements.
+        // `write` only requires that the file's private data pointer points to `seq_file`
+        // which points to a `T` that will outlive it, which matches what `render_open`
+        // provides.
+        unsafe { FileOps::new(operations, 0o600) }
+    };
+}
+
+/// # Safety
+///
+/// `inode` must be a valid pointer to an `inode` struct.
+/// `file` must be a valid pointer to a `file` struct.
+unsafe extern "C" fn write_only_open(
+    inode: *mut bindings::inode,
+    file: *mut bindings::file,
+) -> c_int {
+    // SAFETY: The caller ensures that `inode` and `file` are valid pointers.
+    unsafe {
+        (*file).private_data = (*inode).i_private;
+    }
+    0
+}
+
+/// # Safety
+///
+/// * `file` must be a valid pointer to a `file` struct.
+/// * The `private_data` of the file must contain a valid pointer to a `T` that implements
+///   `UpdateFromSlice`.
+/// * `buf` must be a valid user-space buffer.
+pub(crate) unsafe extern "C" fn write_only_write<T: UpdateFromSlice + Sync>(
+    file: *mut bindings::file,
+    buf: *const c_char,
+    count: usize,
+    _ppos: *mut bindings::loff_t,
+) -> isize {
+    // SAFETY: The caller ensures that `file` is a valid pointer and that `private_data` holds a
+    // valid pointer to `T`.
+    let data = unsafe { &*((*file).private_data as *const T) };
+    update(data, buf, count)
+}
+
+pub(crate) trait WriteFile<T> {
+    const FILE_OPS: FileOps<T>;
+}
+
+impl<T: UpdateFromSlice + Sync> WriteFile<T> for T {
+    const FILE_OPS: FileOps<T> = {
+        let operations = bindings::file_operations {
+            open: Some(write_only_open),
+            write: Some(write_only_write::<T>),
+            llseek: Some(bindings::noop_llseek),
+            // SAFETY: `file_operations` supports zeroes in all fields.
+            ..unsafe { core::mem::zeroed() }
+        };
+        // SAFETY:
+        // * `write_only_open` populates the file private data with the inode private data
+        // * `write_only_write`'s only requirement is that the private data of the file point to
+        //   a `T` and be legal to convert to a shared reference, which `write_only_open`
+        //   satisfies.
+        unsafe { FileOps::new(operations, 0o200) }
+    };
+}
diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.rs
index 2939e18e3dda39571cd7255505e5f605f0e3d154..d64638898faaa1a6a9898c374b8c1114993376c9 100644
--- a/rust/kernel/debugfs/traits.rs
+++ b/rust/kernel/debugfs/traits.rs
@@ -3,8 +3,15 @@
 
 //! Traits for rendering or updating values exported to DebugFS.
 
+use crate::prelude::*;
 use crate::sync::Mutex;
+use crate::uaccess::UserSliceReader;
 use core::fmt::{self, Debug, Formatter};
+use core::str::FromStr;
+use core::sync::atomic::{
+    AtomicI16, AtomicI32, AtomicI64, AtomicI8, AtomicIsize, AtomicU16, AtomicU32, AtomicU64,
+    AtomicU8, AtomicUsize, Ordering,
+};
 
 /// A trait for types that can be rendered into a string.
 ///
@@ -26,3 +33,65 @@ fn render(&self, f: &mut Formatter<'_>) -> fmt::Result {
         writeln!(f, "{self:?}")
     }
 }
+
+/// A trait for types that can be updated from a user slice.
+///
+/// This works similarly to `FromStr`, but operates on a `UserSliceReader` rather than a &str.
+///
+/// It is automatically implemented for all atomic integers, or any type that implements `FromStr`
+/// wrapped in a `Mutex`.
+pub trait UpdateFromSlice {
+    /// Updates the value from the given user slice.
+    fn update_from_slice(&self, reader: &mut UserSliceReader) -> Result<()>;
+}
+
+impl<T: FromStr> UpdateFromSlice for Mutex<T> {
+    fn update_from_slice(&self, reader: &mut UserSliceReader) -> Result<()> {
+        let mut buf = [0u8; 128];
+        if reader.len() > buf.len() {
+            return Err(EINVAL);
+        }
+        let n = reader.len();
+        reader.read_slice(&mut buf[..n])?;
+
+        let s = core::str::from_utf8(&buf[..n]).map_err(|_| EINVAL)?;
+        let val = s.trim().parse::<T>().map_err(|_| EINVAL)?;
+        *self.lock() = val;
+        Ok(())
+    }
+}
+
+macro_rules! impl_update_from_slice_for_atomic {
+    ($(($atomic_type:ty, $int_type:ty)),*) => {
+        $(
+            impl UpdateFromSlice for $atomic_type {
+                fn update_from_slice(&self, reader: &mut UserSliceReader) -> Result<()> {
+                    let mut buf = [0u8; 21]; // Enough for a 64-bit number.
+                    if reader.len() > buf.len() {
+                        return Err(EINVAL);
+                    }
+                    let n = reader.len();
+                    reader.read_slice(&mut buf[..n])?;
+
+                    let s = core::str::from_utf8(&buf[..n]).map_err(|_| EINVAL)?;
+                    let val = s.trim().parse::<$int_type>().map_err(|_| EINVAL)?;
+                    self.store(val, Ordering::Relaxed);
+                    Ok(())
+                }
+            }
+        )*
+    };
+}
+
+impl_update_from_slice_for_atomic!(
+    (AtomicI16, i16),
+    (AtomicI32, i32),
+    (AtomicI64, i64),
+    (AtomicI8, i8),
+    (AtomicIsize, isize),
+    (AtomicU16, u16),
+    (AtomicU32, u32),
+    (AtomicU64, u64),
+    (AtomicU8, u8),
+    (AtomicUsize, usize)
+);

-- 
2.51.0.rc1.167.g924127e9c0-goog


