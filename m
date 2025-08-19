Return-Path: <linux-kernel+bounces-776611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE32B2CF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437EA1C25F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5182620C3;
	Tue, 19 Aug 2025 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvOhLV5d"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629402494FF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755644030; cv=none; b=qEimZX4tpFzvBr0abeweEU63mermXpAUL3UwzdrRT/TxsLXA0k5J3GuZjCw3ojFc0fVzmHcz8qlkFnubKNjd8Lp65k1FrlrwF7j081V386FhVYCHD0VjOUtQAebtFxCr0zlKT4qzGYv84W7n6M6pnIxnILJuCMwUAFQxdDf5nAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755644030; c=relaxed/simple;
	bh=9xvFviyFtcxJh2vxhNHl4ezZw79kWDSBe2uv8ULynnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HzooUUvy7Ea2CECO0GMTrC0j2eBsurmSmAL8DY200gS74yEsf940vrEXIDulwjTEXWFGK470GMkM7YVVvWZLgPTbTOBI/rNCcdZRJw9sX/0OMRoD3ieNCx3hvmmhISEyAOwvrdzmDcosZnbKuWEf5L3nO5xDGlcLC4za4pg8w2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvOhLV5d; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326bd7502so5202165a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755644028; x=1756248828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OXQqr0jamg7WIkvF5k/2nGStwbn54x7YRQeARNyaUng=;
        b=MvOhLV5dT379KzDsxzCq9clrdXkDZDRxIsfSRAQ4O5CApnFVfh1QAhrk/bLznm10t/
         2rMyWzxRxm9bqmipWVmXAC9vl0oe8ffscXKe/KANul1GHKlaeXRFk5vUQPN2b+eYpV1A
         rxlaYihEK79uwafL6ZyjI6nP+87C8ugVoBRwfAbOTz9OhWfXbuKYOGw/d3ML0k35TqKb
         v+6Cdng7pyUZOqPvVTvj6gN1djFVpmbu7HLwW5ctmvrsgClmkH8qqHtcu71PMCvBbWKD
         aRF1jIz7VWZITbjx6yotYxVYCwHUeb464klZ0LHgOgCktOXd5EMfq97+lC4ZpkCLiUhg
         e2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755644028; x=1756248828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXQqr0jamg7WIkvF5k/2nGStwbn54x7YRQeARNyaUng=;
        b=MRIrO5K+kALAbnyEwlqRvM9g6jUkXjdLTg6/KaOkw+lAmaaOcFs4O4x35T7jA0RMcY
         er26IXQgikRqnu3xSxVWXkiWemRmqq37RhLjcdt09h12FqjmreKckfxVWWAD36zjSwow
         0r5L0P0+Kgx1CCGS8kzY19I3/DHS3Fh7rRNt9rp1mBCNHceSH3vg2Rll8NFFdOI6jf01
         MncYJ0fWsPxIyGGLqVCjRx78PfYv+5+80YSJnBe+7DTS7j5uNH9EBlZ+f3ULb+x0yP9k
         BscqH2UFEAjh8CJNvn372AnM7gE5bhp9jcmhrtZxmh1BFTXJpq0U3pYKZacLj3+vQx54
         3L/g==
X-Gm-Message-State: AOJu0Ywz1gXNz+/AavFGxODlJM4tn5MYMtMjDv3RLjm/tMvv7UK4ovEM
	R+Kg5cKhqXFxQIZtNAQ7q3HjoUSi0kBcOJ9Csrjxxwq1iuxBOnIm1XZ9NmGo5JWfrUHJ5LZtWVC
	fnGpO5JI2uQ==
X-Google-Smtp-Source: AGHT+IF7rJS0JgdEObO2kLIendfBNucoHFxr0vzjfs9fV9IR9EmY+lSfuo8EuEAeaOpbAufEGw4yFxjZnAcD
X-Received: from pjboh13.prod.google.com ([2002:a17:90b:3a4d:b0:31f:26b:cc66])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3dcf:b0:321:2b8a:430a
 with SMTP id 98e67ed59e1d1-324e140bdedmr934145a91.28.1755644027720; Tue, 19
 Aug 2025 15:53:47 -0700 (PDT)
Date: Tue, 19 Aug 2025 22:53:37 +0000
In-Reply-To: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755644022; l=14032;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=9xvFviyFtcxJh2vxhNHl4ezZw79kWDSBe2uv8ULynnk=; b=xx3uWkG7wUoqxkUytlHlTitEuKIqtpUmvcpWtth8Vm0UYl2ItnVaeoX5hIRcBCU2VuSCDo6Mc
 68EC+Xf3RRODd1tXV488aHC3F8IT2tme5MyiIpUCv+rzvUCA1XjuPQi
X-Mailer: b4 0.14.2
Message-ID: <20250819-debugfs-rust-v10-2-86e20f3cf3bb@google.com>
Subject: [PATCH v10 2/7] rust: debugfs: Add support for read-only files
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
that implements the `Render` trait.

The file's content is generated by the `Render` implementation, and the
file is automatically removed when the returned `File` handle is
dropped.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/kernel/debugfs.rs          | 142 +++++++++++++++++++++++++++++++++++++++-
 rust/kernel/debugfs/entry.rs    |  42 ++++++++++++
 rust/kernel/debugfs/file_ops.rs | 125 +++++++++++++++++++++++++++++++++++
 rust/kernel/debugfs/traits.rs   |  28 ++++++++
 4 files changed, 336 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index 893aee54b920bac80f77c2726567da76929b7244..875d433fc3608cc9ffcf022d7c00cb207016f146 100644
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
+pub use traits::Render;
 
+mod file_ops;
+use file_ops::{FileOps, ReadFile};
 #[cfg(CONFIG_DEBUG_FS)]
 mod entry;
 #[cfg(CONFIG_DEBUG_FS)]
@@ -53,6 +59,31 @@ fn create(name: &CStr, parent: Option<&Dir>) -> Self {
         Self()
     }
 
+    /// Creates a DebugFS file which will own the data produced by the initializer provided in
+    /// `data`.
+    fn create_file<'a, T: Sync + 'static, E: 'a, TI: PinInit<T, E> + 'a>(
+        &'a self,
+        name: &'a CStr,
+        data: TI,
+        file_ops: &'static FileOps<T>,
+    ) -> impl PinInit<File<T>, E> + 'a {
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
@@ -79,4 +110,113 @@ pub fn new(name: &CStr) -> Self {
     pub fn subdir(&self, name: &CStr) -> Self {
         Dir::create(name, Some(self))
     }
+
+    /// Creates a read-only file in this directory.
+    ///
+    /// The file's contents are produced by invoking [`Render::render`] on the value initialized by
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
+    pub fn read_only_file<'a, T: Render + Send + Sync + 'static, E: 'a, TI: PinInit<T, E> + 'a>(
+        &'a self,
+        name: &'a CStr,
+        data: TI,
+    ) -> impl PinInit<File<T>, E> + 'a {
+        let file_ops = &<T as ReadFile<_>>::FILE_OPS;
+        self.create_file(name, data, file_ops)
+    }
+}
+
+#[pin_data]
+/// Handle to a DebugFS scope, which allows a variety of DebugFS files/directories to hang off a
+/// single structure.
+pub struct Scope<T> {
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
+impl<T> Scope<T> {
+    fn new<E, TI: PinInit<T, E>, F: for<'a> FnOnce(&'a T)>(
+        data: TI,
+        init: F,
+    ) -> impl PinInit<Self, E> {
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
+impl<T> Scope<T> {
+    fn entry_mut(self: Pin<&mut Self>) -> &mut Entry {
+        // SAFETY: _entry is not structurally pinned
+        unsafe { &mut Pin::into_inner_unchecked(self)._entry }
+    }
+    fn new<'b, E: 'b, TI: PinInit<T, E> + 'b, F: for<'a> FnOnce(&'a T) -> Entry + 'b>(
+        data: TI,
+        init: F,
+    ) -> impl PinInit<Self, E> + 'b
+    where
+        T: 'b,
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
index 0000000000000000000000000000000000000000..134ac26e80f2e5b9cae53ed5a00462af7ce1aa38
--- /dev/null
+++ b/rust/kernel/debugfs/file_ops.rs
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Google LLC.
+
+use super::Render;
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
+    #[cfg(CONFIG_DEBUG_FS)]
+    pub(crate) const fn mode(&self) -> u16 {
+        self.mode
+    }
+}
+
+#[cfg(CONFIG_DEBUG_FS)]
+impl<T> Deref for FileOps<T> {
+    type Target = bindings::file_operations;
+    fn deref(&self) -> &Self::Target {
+        &self.operations
+    }
+}
+
+struct RenderAdapter<T>(T);
+
+impl<'a, T: Render> Display for RenderAdapter<&'a T> {
+    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
+        self.0.render(f)
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
+unsafe extern "C" fn render_open<T: Render + Sync>(
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
+    unsafe { bindings::single_open(file, Some(render_act::<T>), data) }
+}
+
+/// Prints private data stashed in a seq_file to that seq file.
+///
+/// # Safety
+///
+/// `seq` must point to a live `seq_file` whose private data is a live pointer to a `T` which may
+/// not have any unique references alias it during the call.
+unsafe extern "C" fn render_act<T: Render + Sync>(
+    seq: *mut bindings::seq_file,
+    _: *mut c_void,
+) -> c_int {
+    // SAFETY: By caller precondition, this pointer is live, points to a value of type `T`, and
+    // there are not and will not be any unique references until we are done.
+    let data = unsafe { &*((*seq).private.cast::<T>()) };
+    // SAFETY: By caller precondition, `seq_file` points to a live `seq_file`, so we can lift
+    // it.
+    let seq_file = unsafe { SeqFile::from_raw(seq) };
+    seq_print!(seq_file, "{}", RenderAdapter(data));
+    0
+}
+
+// Work around lack of generic const items.
+pub(crate) trait ReadFile<T> {
+    const FILE_OPS: FileOps<T>;
+}
+
+impl<T: Render + Sync> ReadFile<T> for T {
+    const FILE_OPS: FileOps<T> = {
+        let operations = bindings::file_operations {
+            read: Some(bindings::seq_read),
+            llseek: Some(bindings::seq_lseek),
+            release: Some(bindings::single_release),
+            open: Some(render_open::<Self>),
+            // SAFETY: `file_operations` supports zeroes in all fields.
+            ..unsafe { core::mem::zeroed() }
+        };
+        // SAFETY: `operations` is all stock `seq_file` implementations except for `render_open`.
+        // `open`'s only requirement beyond what is provided to all open functions is that the
+        // inode's data pointer must point to a `T` that will outlive it, which matches the
+        // `FileOps` requirements.
+        unsafe { FileOps::new(operations, 0o400) }
+    };
+}
diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.rs
new file mode 100644
index 0000000000000000000000000000000000000000..2939e18e3dda39571cd7255505e5f605f0e3d154
--- /dev/null
+++ b/rust/kernel/debugfs/traits.rs
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Google LLC.
+
+//! Traits for rendering or updating values exported to DebugFS.
+
+use crate::sync::Mutex;
+use core::fmt::{self, Debug, Formatter};
+
+/// A trait for types that can be rendered into a string.
+///
+/// This works very similarly to `Debug`, and is automatically implemented if `Debug` is
+/// implemented for a type. It is also implemented for any renderable type inside a `Mutex`.
+pub trait Render {
+    /// Formats the value using the given formatter.
+    fn render(&self, f: &mut Formatter<'_>) -> fmt::Result;
+}
+
+impl<T: Render> Render for Mutex<T> {
+    fn render(&self, f: &mut Formatter<'_>) -> fmt::Result {
+        self.lock().render(f)
+    }
+}
+
+impl<T: Debug> Render for T {
+    fn render(&self, f: &mut Formatter<'_>) -> fmt::Result {
+        writeln!(f, "{self:?}")
+    }
+}

-- 
2.51.0.rc1.167.g924127e9c0-goog


