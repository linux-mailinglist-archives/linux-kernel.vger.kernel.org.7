Return-Path: <linux-kernel+bounces-801647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C24CB44850
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966473B593E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E216E2C17B3;
	Thu,  4 Sep 2025 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aijcNr77"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14532BF3F3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020451; cv=none; b=opzxEQtYsEnqte/fGUpF9vgKdzGBoP4TwIQJ/ry1bEashvMFscTxLfiOkx5jN6doDom8fqt6JzOHff6TuXTz8CRQZiY4ZdgQ3PJxdBHHE3txv3wDAKDwUcJvniHaK8nx8YZpd3APt6OVBkccCnr7X7jlEQP8onB3gCsV6pqgmvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020451; c=relaxed/simple;
	bh=VBQJoE+Lm8CzDWuYMiCor0vZ902eURER25jDonvcF78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lXT2qlIGLzl78LjpahfRdv/gFAr8pvDnJEwzRR63hbH3M0ftvcrQGMoNc53hbXmA6ua2DKM+j7+ms2Vzo4CSL57c/5NHcdNEr9JtDgwYnk3JF9YnAQEsjFzamNx5u3lbYCqXuFsBtYJGGMrsrRwcxREy9mYlt8MqriJmfMWrckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aijcNr77; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4d48818a04so1021734a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757020449; x=1757625249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEBpj/QWOHMN6zKC2IFSIRLeTaHgu8MbKbl5WICV5ps=;
        b=aijcNr77trrDx3Sf/nDDkIXnKkwFvdrpUQnbgtcw5cvFEcYHMv/evriYZ546SdIqwc
         18875I272yFTF6+WCa18QpipAL88VwlR5PAnvnxEcK5lOrJUJ490oCEdbTW+Qvjbh9iy
         66NoGMMOkbzem9XFNlcSA8Hjv/o97OkiB5+Ff6MUDcBU0PBrl90mDbjhgz4+Pd/4ExAw
         peJ4baxpZ0spEvEOUc6F1bCj3nApHMQ6FohudgmRbDaC9rxKAqhyUEw9lvCwqdtiX3xs
         kxNUIxV/Xox8eU6GUWSodfqPtYkbvitlEoZsrWRaOAnO8xLYsDEDcpGyPA8yPcscHJEH
         E4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757020449; x=1757625249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEBpj/QWOHMN6zKC2IFSIRLeTaHgu8MbKbl5WICV5ps=;
        b=JH4sLf4VonmhscEsfi7d46W1ahrfb+z1Mealp6QBsw0RiFg8CDFj602mox2eSy8o8D
         f/2Xc7+OQZeoI4Nh6nPi6Gr+iSYZo8/VW+hMSRrMCar4eimN8445xAcOsAbMJafcqgyC
         rEyFvQQ79EW8un5zd+PBlJ4oRqsSOY2GN14H6aWGJ5CiFDUkaken7wQ5j5MLcyieGdKy
         VX4Z++wKOWxXN8VKQo6EpeVpJ4Q5nKxA714AmXz1q7cb4My+n8sK1Vmx6vaXR9QJgseW
         DFL0mghtIhdn2Ome2ScGgOxLlEv3D5ZnvgL4IiGvLJthwvdFHVJHtOv+4xDLU0wkp3NG
         OL8A==
X-Gm-Message-State: AOJu0YxJGrhuWwdfJCrrivxGw8g8C+aXVxsEypdJVu+jUW19hKhAJeAI
	3GnoQfRnQLG6zzAPqNEdiCkieLla/qdsX5dxPfEu/8kt7bxGdi0IyThfhx+vYMXvX4xhZBoSoCo
	oCnSunQ7Ubg==
X-Google-Smtp-Source: AGHT+IGbS/wyh1uE8LybvJ86AyH49A6f/q1fbYysOfAJ3VDRse5YpA4slFp/VCzkU7qFmAIG4oezk/FPqPjQ
X-Received: from plez7.prod.google.com ([2002:a17:902:ccc7:b0:24c:829d:8a31])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f92:b0:24c:784c:4a90
 with SMTP id d9443c01a7336-24c784c4f25mr135221085ad.1.1757020449145; Thu, 04
 Sep 2025 14:14:09 -0700 (PDT)
Date: Thu, 04 Sep 2025 21:13:55 +0000
In-Reply-To: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757020440; l=10441;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=VBQJoE+Lm8CzDWuYMiCor0vZ902eURER25jDonvcF78=; b=4yvOnY7aq++9sixiTSlDJ66p5sgpKg8M1iQFPoYkoUEbBai4xRYv8lCE4vAMamqvsom0z2Ezm
 5/+XYC1AZBdALNM4ZXKIEDlwJi2mJnmqZkkOqHMfal0PUxiTjGlMhtD
X-Mailer: b4 0.14.2
Message-ID: <20250904-debugfs-rust-v11-4-7d12a165685a@google.com>
Subject: [PATCH v11 4/7] rust: debugfs: Add support for callback-based files
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

Extends the `debugfs` API to support creating files with content
generated and updated by callbacks. This is done via the
`read_callback_file`, `write_callback_file`, and
`read_write_callback_file` methods.

These methods allow for more flexible file definition, either because
the type already has a `Writer` or `Reader` method that doesn't
do what you'd like, or because you cannot implement it (e.g. because
it's a type defined in another crate or a primitive type).

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/kernel/debugfs.rs                   |  89 ++++++++++++++++++++++
 rust/kernel/debugfs/callback_adapters.rs | 122 +++++++++++++++++++++++++++++++
 rust/kernel/debugfs/file_ops.rs          |   8 ++
 3 files changed, 219 insertions(+)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index 1f041f09a6eaf5603170ce4c7724b3ef50eecf13..1032f279da380c549991e903c4162b7e4aaec571 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -12,12 +12,16 @@
 use crate::str::CStr;
 #[cfg(CONFIG_DEBUG_FS)]
 use crate::sync::Arc;
+use crate::uaccess::UserSliceReader;
+use core::fmt;
 use core::marker::PhantomPinned;
 use core::ops::Deref;
 
 mod traits;
 pub use traits::{Reader, Writer};
 
+mod callback_adapters;
+use callback_adapters::{FormatAdapter, NoWriter, WritableAdapter};
 mod file_ops;
 use file_ops::{FileOps, ReadFile, ReadWriteFile, WriteFile};
 #[cfg(CONFIG_DEBUG_FS)]
@@ -143,6 +147,46 @@ pub fn read_only_file<'a, T, E: 'a>(
         self.create_file(name, data, file_ops)
     }
 
+    /// Creates a read-only file in this directory, with contents from a callback.
+    ///
+    /// `f` must be a function item or a non-capturing closure.
+    /// This is statically asserted and not a safety requirement.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use core::sync::atomic::{AtomicU32, Ordering};
+    /// # use kernel::c_str;
+    /// # use kernel::debugfs::Dir;
+    /// # use kernel::prelude::*;
+    /// # let dir = Dir::new(c_str!("foo"));
+    /// let file = KBox::pin_init(
+    ///     dir.read_callback_file(c_str!("bar"),
+    ///     AtomicU32::new(3),
+    ///     &|val, f| {
+    ///       let out = val.load(Ordering::Relaxed);
+    ///       writeln!(f, "{out:#010x}")
+    ///     }),
+    ///     GFP_KERNEL)?;
+    /// // Reading "foo/bar" will show "0x00000003".
+    /// file.store(10, Ordering::Relaxed);
+    /// // Reading "foo/bar" will now show "0x0000000a".
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn read_callback_file<'a, T, E: 'a, F>(
+        &'a self,
+        name: &'a CStr,
+        data: impl PinInit<T, E> + 'a,
+        _f: &'static F,
+    ) -> impl PinInit<File<T>, E> + 'a
+    where
+        T: Send + Sync + 'static,
+        F: Fn(&T, &mut fmt::Formatter<'_>) -> fmt::Result + Send + Sync,
+    {
+        let file_ops = <FormatAdapter<T, F>>::FILE_OPS.adapt();
+        self.create_file(name, data, file_ops)
+    }
+
     /// Creates a read-write file in this directory.
     ///
     /// Reading the file uses the [`Writer`] implementation.
@@ -159,6 +203,31 @@ pub fn read_write_file<'a, T, E: 'a>(
         self.create_file(name, data, file_ops)
     }
 
+    /// Creates a read-write file in this directory, with logic from callbacks.
+    ///
+    /// Reading from the file is handled by `f`. Writing to the file is handled by `w`.
+    ///
+    /// `f` and `w` must be function items or non-capturing closures.
+    /// This is statically asserted and not a safety requirement.
+    pub fn read_write_callback_file<'a, T, E: 'a, F, W>(
+        &'a self,
+        name: &'a CStr,
+        data: impl PinInit<T, E> + 'a,
+        _f: &'static F,
+        _w: &'static W,
+    ) -> impl PinInit<File<T>, E> + 'a
+    where
+        T: Send + Sync + 'static,
+        F: Fn(&T, &mut fmt::Formatter<'_>) -> fmt::Result + Send + Sync,
+        W: Fn(&T, &mut UserSliceReader) -> Result<(), Error> + Send + Sync,
+    {
+        let file_ops =
+            <WritableAdapter<FormatAdapter<T, F>, W> as file_ops::ReadWriteFile<_>>::FILE_OPS
+                .adapt()
+                .adapt();
+        self.create_file(name, data, file_ops)
+    }
+
     /// Creates a write-only file in this directory.
     ///
     /// The file owns its backing data. Writing to the file uses the [`Reader`]
@@ -175,6 +244,26 @@ pub fn write_only_file<'a, T, E: 'a>(
     {
         self.create_file(name, data, &T::FILE_OPS)
     }
+
+    /// Creates a write-only file in this directory, with write logic from a callback.
+    ///
+    /// `w` must be a function item or a non-capturing closure.
+    /// This is statically asserted and not a safety requirement.
+    pub fn write_callback_file<'a, T, E: 'a, W>(
+        &'a self,
+        name: &'a CStr,
+        data: impl PinInit<T, E> + 'a,
+        _w: &'static W,
+    ) -> impl PinInit<File<T>, E> + 'a
+    where
+        T: Send + Sync + 'static,
+        W: Fn(&T, &mut UserSliceReader) -> Result<(), Error> + Send + Sync,
+    {
+        let file_ops = <WritableAdapter<NoWriter<T>, W> as WriteFile<_>>::FILE_OPS
+            .adapt()
+            .adapt();
+        self.create_file(name, data, file_ops)
+    }
 }
 
 #[pin_data]
diff --git a/rust/kernel/debugfs/callback_adapters.rs b/rust/kernel/debugfs/callback_adapters.rs
new file mode 100644
index 0000000000000000000000000000000000000000..6c024230f676d55c8ddacb69de9c27587e29c636
--- /dev/null
+++ b/rust/kernel/debugfs/callback_adapters.rs
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Google LLC.
+
+//! Adapters which allow the user to supply a write or read implementation as a value rather
+//! than a trait implementation. If provided, it will override the trait implementation.
+
+use super::{Reader, Writer};
+use crate::prelude::*;
+use crate::uaccess::UserSliceReader;
+use core::fmt;
+use core::fmt::Formatter;
+use core::marker::PhantomData;
+use core::ops::Deref;
+
+/// # Safety
+///
+/// To implement this trait, it must be safe to cast a `&Self` to a `&Inner`.
+/// It is intended for use in unstacking adapters out of `FileOps` backings.
+pub(crate) unsafe trait Adapter {
+    type Inner;
+}
+
+/// Adapter to implement `Reader` via a callback with the same representation as `T`.
+///
+/// * Layer it on top of `WriterAdapter` if you want to add a custom callback for `write`.
+/// * Layer it on top of `NoWriter` to pass through any support present on the underlying type.
+///
+/// # Invariants
+///
+/// If an instance for `WritableAdapter<_, W>` is constructed, `W` is inhabited.
+#[repr(transparent)]
+pub(crate) struct WritableAdapter<D, W> {
+    inner: D,
+    _writer: PhantomData<W>,
+}
+
+// SAFETY: Stripping off the adapter only removes constraints
+unsafe impl<D, W> Adapter for WritableAdapter<D, W> {
+    type Inner = D;
+}
+
+impl<D: Writer, W> Writer for WritableAdapter<D, W> {
+    fn write(&self, fmt: &mut fmt::Formatter<'_>) -> fmt::Result {
+        self.inner.write(fmt)
+    }
+}
+
+impl<D: Deref, W> Reader for WritableAdapter<D, W>
+where
+    W: Fn(&D::Target, &mut UserSliceReader) -> Result + Send + Sync + 'static,
+{
+    fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result {
+        // SAFETY: WritableAdapter<_, W> can only be constructed if W is inhabited
+        let w: &W = unsafe { materialize_zst() };
+        w(self.inner.deref(), reader)
+    }
+}
+
+/// Adapter to implement `Writer` via a callback with the same representation as `T`.
+///
+/// # Invariants
+///
+/// If an instance for `FormatAdapter<_, F>` is constructed, `F` is inhabited.
+#[repr(transparent)]
+pub(crate) struct FormatAdapter<D, F> {
+    inner: D,
+    _formatter: PhantomData<F>,
+}
+
+impl<D, F> Deref for FormatAdapter<D, F> {
+    type Target = D;
+    fn deref(&self) -> &D {
+        &self.inner
+    }
+}
+
+impl<D, F> Writer for FormatAdapter<D, F>
+where
+    F: Fn(&D, &mut Formatter<'_>) -> fmt::Result + 'static,
+{
+    fn write(&self, fmt: &mut Formatter<'_>) -> fmt::Result {
+        // SAFETY: FormatAdapter<_, F> can only be constructed if F is inhabited
+        let f: &F = unsafe { materialize_zst() };
+        f(&self.inner, fmt)
+    }
+}
+
+// SAFETY: Stripping off the adapter only removes constraints
+unsafe impl<D, F> Adapter for FormatAdapter<D, F> {
+    type Inner = D;
+}
+
+#[repr(transparent)]
+pub(crate) struct NoWriter<D> {
+    inner: D,
+}
+
+// SAFETY: Stripping off the adapter only removes constraints
+unsafe impl<D> Adapter for NoWriter<D> {
+    type Inner = D;
+}
+
+impl<D> Deref for NoWriter<D> {
+    type Target = D;
+    fn deref(&self) -> &D {
+        &self.inner
+    }
+}
+
+/// For types with a unique value, produce a static reference to it.
+///
+/// # Safety
+///
+/// The caller asserts that F is inhabited
+unsafe fn materialize_zst<F>() -> &'static F {
+    const { assert!(core::mem::size_of::<F>() == 0) };
+    let zst_dangle: core::ptr::NonNull<F> = core::ptr::NonNull::dangling();
+    // SAFETY: While the pointer is dangling, it is a dangling pointer to a ZST, based on the
+    // assertion above. The type is also inhabited, by the caller's assertion. This means
+    // we can materialize it.
+    unsafe { zst_dangle.as_ref() }
+}
diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_ops.rs
index 2060c8d14d83455efa6ec179669f2c3fcc35ccaf..50fead17b6f31feaf1caaef31c24ccdf6d8a5835 100644
--- a/rust/kernel/debugfs/file_ops.rs
+++ b/rust/kernel/debugfs/file_ops.rs
@@ -2,6 +2,7 @@
 // Copyright (C) 2025 Google LLC.
 
 use super::{Reader, Writer};
+use crate::debugfs::callback_adapters::Adapter;
 use crate::prelude::*;
 use crate::seq_file::SeqFile;
 use crate::seq_print;
@@ -46,6 +47,13 @@ pub(crate) const fn mode(&self) -> u16 {
     }
 }
 
+impl<T: Adapter> FileOps<T> {
+    pub(super) const fn adapt(&self) -> &FileOps<T::Inner> {
+        // SAFETY: `Adapter` asserts that `T` can be legally cast to `T::Inner`.
+        unsafe { core::mem::transmute(self) }
+    }
+}
+
 #[cfg(CONFIG_DEBUG_FS)]
 impl<T> Deref for FileOps<T> {
     type Target = bindings::file_operations;

-- 
2.51.0.355.g5224444f11-goog


