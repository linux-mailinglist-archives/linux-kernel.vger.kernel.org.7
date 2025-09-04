Return-Path: <linux-kernel+bounces-801646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2943B4484F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52F03AEE19
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD372BD58A;
	Thu,  4 Sep 2025 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WnQ7uTeL"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9E62C027A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020450; cv=none; b=phArgg3hmZprMxLBIVFucezFYL0YfODcg+D9EKg1SqD5DuMzlVwodG84Q178DntY8AUnGJGCJwMQL82OTOhi59l+X031jJAufVIzNwxJ9/bykaP7944r40guAbehlNdIvJA48kUUshV/N6ua2lpxMBrIKtwHZ0nAN42qrSUb0ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020450; c=relaxed/simple;
	bh=GezwA+wXVKp0DRIhqN2BHGB5ngH9Od3xM+ZXjB5cz8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GRhJNEzGG5Q5YRiu67N6LtuUF0F8RK1ghuW9iiWGGuNvFctr31DNGSt2ysOFo1AYYuK4/C4xlvxCXMrg4ymrmTvi6RHzxJwerIDLtkicR/nOwDKIWRuq4hQUdNJK0GtzNtHHjUVqvaGUI7TM4UlbSxMW+LhKRVrCDakyze3+q6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WnQ7uTeL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e98962b132bso2786354276.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757020447; x=1757625247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyc9Sezqjjgx53ixJnCGx8glIsEj3Qx8OmK+mprgV5M=;
        b=WnQ7uTeLd6nygjbzf9qvIYLBd8OwPs427X59x4FKlCYuXgFvWoQijFlbOQgOPebpJ7
         9yqS+hbO3AsiGXAzSp7Yo4X4+J3DUXn3d9Q0czOOD/DCSj9sX+LVhAaVqTnOC2Q2vMyk
         OEWP6ikiZ58dErSvk52peaX7G5gkVsRrEl4j2lYDQjZbhwONAxzpSZoEzP+MagfWd/Xf
         BgXejL7lD0TK3tACLBeQwYk4EeZK6S3wRRmArx1TH+56Rr5CBzSTNVcnJ+ULNzfVMnLO
         ddhyyLdlYC/TQkihOHBPyc201OBlya90OTlplNcbuPe9NYjZltrNIDoTfztcYt05Lozk
         XEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757020447; x=1757625247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyc9Sezqjjgx53ixJnCGx8glIsEj3Qx8OmK+mprgV5M=;
        b=ZqRI935V1sWvilL96K+cUYfIkLf9XOiWiC2SWYz6NzLGzSgv7AN1sfoZFjYTFeZKPI
         36Xf8kTJbemZOyFTfBfRln9ukmyyGyEdZw+dKPaIfULJauZK+wI3gMVgV1fXqhh8g/2q
         nqM0h2oFf5bopGSqZUWTcmcDL2G6SVQzBam4ZAeW4X5M7FaoymubkHplJfZHrhSHCFAN
         8hv1OEBF10cNMbZJGb1Js5E0wyOvf76HROcmV0zOtqrT4IAxlBzrmQEof7UuVYWKW+gO
         OKu0qRUr7zg/D3UAC6m5G5gfZoh4+pPSigeDtuMpU46HNPJfNsshmHEDLBryOUhFrbbE
         JiOA==
X-Gm-Message-State: AOJu0YzEQAeCz+2ZF3TJc5tBVwHembRjqd9rkhAgKtUfiLZAzMTPKH3l
	GCL2bkeE95yN1kjOpE2sRu+HZ000mxtJEY2eqxUFvV66DQbkQbIGW/N5L9drL+xS1pG62aABcQL
	j2OZ86f0ytw==
X-Google-Smtp-Source: AGHT+IHtJUU+BwbDx4oO0LPbQFnhU87b9Fk4a0b0A/+npzA9WhgEO7z8wfilcXuJx8DFXvvID3ZDVJfqDlnn
X-Received: from ybmm5.prod.google.com ([2002:a25:2605:0:b0:e93:d518:e700])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:2b01:b0:e9b:c256:af4b
 with SMTP id 3f1490d57ef6-e9bc256b3e4mr10808881276.29.1757020447010; Thu, 04
 Sep 2025 14:14:07 -0700 (PDT)
Date: Thu, 04 Sep 2025 21:13:54 +0000
In-Reply-To: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757020440; l=10526;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=GezwA+wXVKp0DRIhqN2BHGB5ngH9Od3xM+ZXjB5cz8k=; b=NsN9PoG5PU/07PDksIzzAFi+2OAYpKBmAOjenprrduVLB8G+uCSyg3NnR7F4PAI4tkqTTyaHf
 e3hIoEts4h2Asy/lazghdBZ8Z8GwGraJuYlseidPEFuuAfnTFAgkff7
X-Mailer: b4 0.14.2
Message-ID: <20250904-debugfs-rust-v11-3-7d12a165685a@google.com>
Subject: [PATCH v11 3/7] rust: debugfs: Add support for writable files
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
methods, which take a data object that implements the `Reader`
trait.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/kernel/debugfs.rs          |  37 ++++++++++++-
 rust/kernel/debugfs/file_ops.rs | 113 +++++++++++++++++++++++++++++++++++++++-
 rust/kernel/debugfs/traits.rs   |  69 ++++++++++++++++++++++++
 3 files changed, 216 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index b28665f58cd6a17e188aef5e8c539f6c7433a3b0..1f041f09a6eaf5603170ce4c7724b3ef50eecf13 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -16,10 +16,10 @@
 use core::ops::Deref;
 
 mod traits;
-pub use traits::Writer;
+pub use traits::{Reader, Writer};
 
 mod file_ops;
-use file_ops::{FileOps, ReadFile};
+use file_ops::{FileOps, ReadFile, ReadWriteFile, WriteFile};
 #[cfg(CONFIG_DEBUG_FS)]
 mod entry;
 #[cfg(CONFIG_DEBUG_FS)]
@@ -142,6 +142,39 @@ pub fn read_only_file<'a, T, E: 'a>(
         let file_ops = &<T as ReadFile<_>>::FILE_OPS;
         self.create_file(name, data, file_ops)
     }
+
+    /// Creates a read-write file in this directory.
+    ///
+    /// Reading the file uses the [`Writer`] implementation.
+    /// Writing to the file uses the [`Reader`] implementation.
+    pub fn read_write_file<'a, T, E: 'a>(
+        &'a self,
+        name: &'a CStr,
+        data: impl PinInit<T, E> + 'a,
+    ) -> impl PinInit<File<T>, E> + 'a
+    where
+        T: Writer + Reader + Send + Sync + 'static,
+    {
+        let file_ops = &<T as ReadWriteFile<_>>::FILE_OPS;
+        self.create_file(name, data, file_ops)
+    }
+
+    /// Creates a write-only file in this directory.
+    ///
+    /// The file owns its backing data. Writing to the file uses the [`Reader`]
+    /// implementation.
+    ///
+    /// The file is removed when the returned [`File`] is dropped.
+    pub fn write_only_file<'a, T, E: 'a>(
+        &'a self,
+        name: &'a CStr,
+        data: impl PinInit<T, E> + 'a,
+    ) -> impl PinInit<File<T>, E> + 'a
+    where
+        T: Reader + Send + Sync + 'static,
+    {
+        self.create_file(name, data, &T::FILE_OPS)
+    }
 }
 
 #[pin_data]
diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_ops.rs
index c2fbef96580eaa2fab7cc8c1ba559c3284d12e1b..2060c8d14d83455efa6ec179669f2c3fcc35ccaf 100644
--- a/rust/kernel/debugfs/file_ops.rs
+++ b/rust/kernel/debugfs/file_ops.rs
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2025 Google LLC.
 
-use super::Writer;
+use super::{Reader, Writer};
 use crate::prelude::*;
 use crate::seq_file::SeqFile;
 use crate::seq_print;
+use crate::uaccess::UserSlice;
 use core::fmt::{Display, Formatter, Result};
 use core::marker::PhantomData;
 
@@ -126,3 +127,113 @@ impl<T: Writer + Sync> ReadFile<T> for T {
         unsafe { FileOps::new(operations, 0o400) }
     };
 }
+
+fn read<T: Reader + Sync>(data: &T, buf: *const c_char, count: usize) -> isize {
+    let mut reader = UserSlice::new(UserPtr::from_ptr(buf as *mut c_void), count).reader();
+
+    if let Err(e) = data.read_from_slice(&mut reader) {
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
+/// `private` data in turn points to a `T` that implements `Reader`.
+/// `buf` must be a valid user-space buffer.
+pub(crate) unsafe extern "C" fn write<T: Reader + Sync>(
+    file: *mut bindings::file,
+    buf: *const c_char,
+    count: usize,
+    _ppos: *mut bindings::loff_t,
+) -> isize {
+    // SAFETY: The file was opened with `single_open`, which sets `private_data` to a `seq_file`.
+    let seq = unsafe { &mut *((*file).private_data.cast::<bindings::seq_file>()) };
+    // SAFETY: By caller precondition, this pointer is live and points to a value of type `T`.
+    let data = unsafe { &*(seq.private as *const T) };
+    read(data, buf, count)
+}
+
+// A trait to get the file operations for a type.
+pub(crate) trait ReadWriteFile<T> {
+    const FILE_OPS: FileOps<T>;
+}
+
+impl<T: Writer + Reader + Sync> ReadWriteFile<T> for T {
+    const FILE_OPS: FileOps<T> = {
+        let operations = bindings::file_operations {
+            open: Some(writer_open::<T>),
+            read: Some(bindings::seq_read),
+            write: Some(write::<T>),
+            llseek: Some(bindings::seq_lseek),
+            release: Some(bindings::single_release),
+            // SAFETY: `file_operations` supports zeroes in all fields.
+            ..unsafe { core::mem::zeroed() }
+        };
+        // SAFETY: `operations` is all stock `seq_file` implementations except for `writer_open`
+        // and `write`.
+        // `writer_open`'s only requirement beyond what is provided to all open functions is that
+        // the inode's data pointer must point to a `T` that will outlive it, which matches the
+        // `FileOps` requirements.
+        // `write` only requires that the file's private data pointer points to `seq_file`
+        // which points to a `T` that will outlive it, which matches what `writer_open`
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
+    unsafe { (*file).private_data = (*inode).i_private };
+    0
+}
+
+/// # Safety
+///
+/// * `file` must be a valid pointer to a `file` struct.
+/// * The `private_data` of the file must contain a valid pointer to a `T` that implements
+///   `Reader`.
+/// * `buf` must be a valid user-space buffer.
+pub(crate) unsafe extern "C" fn write_only_write<T: Reader + Sync>(
+    file: *mut bindings::file,
+    buf: *const c_char,
+    count: usize,
+    _ppos: *mut bindings::loff_t,
+) -> isize {
+    // SAFETY: The caller ensures that `file` is a valid pointer and that `private_data` holds a
+    // valid pointer to `T`.
+    let data = unsafe { &*((*file).private_data as *const T) };
+    read(data, buf, count)
+}
+
+pub(crate) trait WriteFile<T> {
+    const FILE_OPS: FileOps<T>;
+}
+
+impl<T: Reader + Sync> WriteFile<T> for T {
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
index 0e6e461324de42a3d80b692264d50e78a48f561d..3d99482e53a395aef81bb045d3effe827f5f4386 100644
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
 
 /// A trait for types that can be written into a string.
 ///
@@ -31,3 +38,65 @@ fn write(&self, f: &mut Formatter<'_>) -> fmt::Result {
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
+pub trait Reader {
+    /// Updates the value from the given user slice.
+    fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result<()>;
+}
+
+impl<T: FromStr> Reader for Mutex<T> {
+    fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result<()> {
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
+macro_rules! impl_reader_for_atomic {
+    ($(($atomic_type:ty, $int_type:ty)),*) => {
+        $(
+            impl Reader for $atomic_type {
+                fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result<()> {
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
+impl_reader_for_atomic!(
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
2.51.0.355.g5224444f11-goog


