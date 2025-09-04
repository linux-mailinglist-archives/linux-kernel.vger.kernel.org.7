Return-Path: <linux-kernel+bounces-801649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4C0B44852
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65591A05CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66283002A2;
	Thu,  4 Sep 2025 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFe5aPo8"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5E2D0C8F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020456; cv=none; b=qdIYzFA4aGvLXPaA82xBFn7zXgcBIvVv/ZxHHC5oPm8Br7B/ABIk4/d8pXOQsTN9waDPlB00WFl2t1i/VTSwZB6SZ7t1Izrx+k+2zBJskVrSDgaKtupx4Xk3/UpJged3tTmBKMicd8Cb4B2BY/ROegIg5PxNz8tpGme5AHfz7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020456; c=relaxed/simple;
	bh=Rp2/78z6wWbP31ZJ/pcLvnZHB8e6n7jyKbwJrkKBH+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X+tgGdcKcS59IqKn1Qka+bmKtflkxN5jZ/ppKnQD3fADRViObXPd/d1XRfX528l5ZIJPaBLRmtrF7Uq+8OvNtpZpTchetKgI3noUkx/pYYrIPiAQfYefJ6DDvcPQFcj8menD8pDvL1UN7N/famk5ZbRbQ2c6mAVs2ktv7HXRDCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFe5aPo8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329745d6960so1353914a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757020453; x=1757625253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YK7rIEOJLTE2g+CUqPb3mblCrnFm8qMnQL5EsmM3boQ=;
        b=OFe5aPo8fIkg0jNMAzXA7VTAW2XPHotX3++QI9fGeJwrEUxC2dHdryloU16P6F60Xr
         YsxXtLW7YrJbm9ZU4X+Nls4OR84iXM51ajwrMMLUeAKlIbBUHTZSlnDSZ0mfjiIAdbm6
         LpLGV4rI8Pb/FE4BHlrh6DMSDWKxNUa7TxqyQvS0fbxLplxC0bXSg/j0weEA9k7bEOAC
         MA6AIVU992qtlyiQtioE3GGy0uzHPz4KIIiwKNdu8/6C/HKINqE4smYiBwoiMNP6WzZ6
         A56lUeXaLoHAzmxxi+karTQOjk0YKsBmvI4G2eAf3wD1h+EDosJg83OhVZffXt0z6VWN
         FTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757020453; x=1757625253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YK7rIEOJLTE2g+CUqPb3mblCrnFm8qMnQL5EsmM3boQ=;
        b=IKZmwXKc0D9vioLiD0HOIz5Lh6fMN2t6lRNprmeaQAM2JcWoALPqGVpXO0noIJinSL
         R42yCevjdtOY7mXh8Ws+liC5iM1biv1ckazNwqFaSTCuqGHYhd134+qn2lV1iP/pl5q4
         D2jwV9uspCyXFwbJowd0vo4M7WaPGEiqWdeTo2Y0A6G7SfhzsxzZZlmKTU0XpRRQOStF
         RHDJjECRV3lwW8wckwfJFaXbW4CfCN1CSUViJNeCl/XAkpZ/Utxr0lUcr+U8slUrPj0C
         i2naTPIUMefCJE7CSvdhekNxasOSTWZW11sJNkhV38X4FpzR3gcuiMJdSr/8N5NrVzOC
         CQ2g==
X-Gm-Message-State: AOJu0YzI46q4f3hZYnwft6pfmiwybDMM3g+FgdiuqNDYCGuONigxDs91
	c/iIans6HyTnzadxdiNTe9dN0oU96IrqodfS3SGiHOJ2WKGwYawWU//9Y2DwZtZ/UadbIMcTo0i
	qIdDY/k3yzg==
X-Google-Smtp-Source: AGHT+IFJTm4WLkU5TNw6hUUMIiPxQOgn8IqE+zNoMTL78lMxGMTKL6T/kxc0f1x7J5hLBLOXp85luo8ZS4OL
X-Received: from pjg4.prod.google.com ([2002:a17:90b:3f44:b0:327:e021:e61d])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d87:b0:32b:65e6:ec39
 with SMTP id 98e67ed59e1d1-32b65e6f260mr8059481a91.21.1757020452465; Thu, 04
 Sep 2025 14:14:12 -0700 (PDT)
Date: Thu, 04 Sep 2025 21:13:57 +0000
In-Reply-To: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757020440; l=17878;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=Rp2/78z6wWbP31ZJ/pcLvnZHB8e6n7jyKbwJrkKBH+E=; b=Nq4SlhLFTdjYz2h4iLTTJKY1OPZ55f4+Z2oIEzk1tmeeC5x28imOgvctz4AGeTmjRVjCfiy4g
 xlhPIGaIPfOArOS9CHuVLyypNsZTH9t8Ak9jNldkLVqR5YUvjbSKWDW
X-Mailer: b4 0.14.2
Message-ID: <20250904-debugfs-rust-v11-6-7d12a165685a@google.com>
Subject: [PATCH v11 6/7] rust: debugfs: Add support for scoped directories
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

Introduces the concept of a `ScopedDir`, which allows for the creation
of debugfs directories and files that are tied to the lifetime of a
particular data structure. This ensures that debugfs entries do not
outlive the data they refer to.

The new `Dir::scope` method creates a new directory that is owned by a
`Scope` handle. All files and subdirectories created within this scope
are automatically cleaned up when the `Scope` is dropped.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/kernel/debugfs.rs       | 262 +++++++++++++++++++++++++++++++++++++++++--
 rust/kernel/debugfs/entry.rs |  73 +++++++++++-
 2 files changed, 320 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index 1032f279da380c549991e903c4162b7e4aaec571..ecfcce845d3f1e9183a55e16629564776f80c6f0 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -14,7 +14,10 @@
 use crate::sync::Arc;
 use crate::uaccess::UserSliceReader;
 use core::fmt;
+use core::marker::PhantomData;
 use core::marker::PhantomPinned;
+#[cfg(CONFIG_DEBUG_FS)]
+use core::mem::ManuallyDrop;
 use core::ops::Deref;
 
 mod traits;
@@ -40,7 +43,7 @@
 // able to refer to us. In this case, we need to silently fail. All future child directories/files
 // will silently fail as well.
 #[derive(Clone)]
-pub struct Dir(#[cfg(CONFIG_DEBUG_FS)] Option<Arc<Entry>>);
+pub struct Dir(#[cfg(CONFIG_DEBUG_FS)] Option<Arc<Entry<'static>>>);
 
 impl Dir {
     /// Create a new directory in DebugFS. If `parent` is [`None`], it will be created at the root.
@@ -264,17 +267,67 @@ pub fn write_callback_file<'a, T, E: 'a, W>(
             .adapt();
         self.create_file(name, data, file_ops)
     }
+
+    // While this function is safe, it is intentionally not public because it's a bit of a
+    // footgun.
+    //
+    // Unless you also extract the `entry` later and schedule it for `Drop` at the appropriate
+    // time, a `ScopedDir` with a `Dir` parent will never be deleted.
+    fn scoped_dir<'data>(&self, name: &CStr) -> ScopedDir<'data, 'static> {
+        #[cfg(CONFIG_DEBUG_FS)]
+        {
+            let parent_entry = match &self.0 {
+                None => return ScopedDir::empty(),
+                Some(entry) => entry.clone(),
+            };
+            ScopedDir {
+                entry: ManuallyDrop::new(Entry::dynamic_dir(name, Some(parent_entry))),
+                _phantom: PhantomData,
+            }
+        }
+        #[cfg(not(CONFIG_DEBUG_FS))]
+        ScopedDir::empty()
+    }
+
+    /// Creates a new scope, which is a directory associated with some data `T`.
+    ///
+    /// The created directory will be a subdirectory of `self`. The `init` closure is called to
+    /// populate the directory with files and subdirectories. These files can reference the data
+    /// stored in the scope.
+    ///
+    /// The entire directory tree created within the scope will be removed when the returned
+    /// `Scope` handle is dropped.
+    pub fn scope<'a, T: 'a, E: 'a, F>(
+        &'a self,
+        data: impl PinInit<T, E> + 'a,
+        name: &'a CStr,
+        init: F,
+    ) -> impl PinInit<Scope<T>, E> + 'a
+    where
+        F: for<'data, 'dir> FnOnce(&'data T, &'dir ScopedDir<'data, 'dir>) + 'a,
+    {
+        Scope::new(data, |data| {
+            let scoped = self.scoped_dir(name);
+            init(data, &scoped);
+            scoped.into_entry()
+        })
+    }
 }
 
 #[pin_data]
-/// Handle to a DebugFS scope, which ensures that attached `data` will outlive the provided
-/// [`Entry`] without moving.
-/// Currently, this is used to back [`File`] so that its `read` and/or `write` implementations
-/// can assume that their backing data is still alive.
-struct Scope<T> {
+/// Handle to a DebugFS scope, which ensures that attached `data` will outlive the DebugFS entry
+/// without moving.
+///
+/// This is internally used to back [`File`], and used in the API to represent the attachment
+/// of a directory lifetime to a data structure which may be jointly accessed by a number of
+/// different files.
+///
+/// When dropped, a `Scope` will remove all directories and files in the filesystem backed by the
+/// attached data structure prior to releasing the attached data.
+pub struct Scope<T> {
     // This order is load-bearing for drops - `_entry` must be dropped before `data`.
     #[cfg(CONFIG_DEBUG_FS)]
-    _entry: Entry,
+    _entry: Entry<'static>,
     #[pin]
     data: T,
     // Even if `T` is `Unpin`, we still can't allow it to be moved.
@@ -312,14 +365,14 @@ fn new<E: 'b, F>(data: impl PinInit<T, E> + 'b, init: F) -> impl PinInit<Self, E
 
 #[cfg(CONFIG_DEBUG_FS)]
 impl<'b, T: 'b> Scope<T> {
-    fn entry_mut(self: Pin<&mut Self>) -> &mut Entry {
+    fn entry_mut(self: Pin<&mut Self>) -> &mut Entry<'static> {
         // SAFETY: _entry is not structurally pinned.
         unsafe { &mut Pin::into_inner_unchecked(self)._entry }
     }
 
     fn new<E: 'b, F>(data: impl PinInit<T, E> + 'b, init: F) -> impl PinInit<Self, E> + 'b
     where
-        F: for<'a> FnOnce(&'a T) -> Entry + 'b,
+        F: for<'a> FnOnce(&'a T) -> Entry<'static> + 'b,
     {
         try_pin_init! {
             Self {
@@ -335,6 +388,31 @@ fn new<E: 'b, F>(data: impl PinInit<T, E> + 'b, init: F) -> impl PinInit<Self, E
     }
 }
 
+impl<'a, T: 'a> Scope<T> {
+    /// Creates a new scope, which is a directory at the root of the debugfs filesystem,
+    /// associated with some data `T`.
+    ///
+    /// The `init` closure is called to populate the directory with files and subdirectories. These
+    /// files can reference the data stored in the scope.
+    ///
+    /// The entire directory tree created within the scope will be removed when the returned
+    /// `Scope` handle is dropped.
+    pub fn dir<E: 'a, F>(
+        data: impl PinInit<T, E> + 'a,
+        name: &'a CStr,
+        init: F,
+    ) -> impl PinInit<Self, E> + 'a
+    where
+        F: for<'data, 'dir> FnOnce(&'data T, &'dir ScopedDir<'data, 'dir>) + 'a,
+    {
+        Scope::new(data, |data| {
+            let scoped = ScopedDir::new(name);
+            init(data, &scoped);
+            scoped.into_entry()
+        })
+    }
+}
+
 impl<T> Deref for Scope<T> {
     type Target = T;
     fn deref(&self) -> &T {
@@ -348,3 +426,169 @@ fn deref(&self) -> &T {
         &self.scope
     }
 }
+
+/// A handle to a directory which will live at most `'dir`, accessing data that will live for at
+/// least `'data`.
+///
+/// Dropping a ScopedDir will not delete or clean it up, this is expected to occur through dropping
+/// the `Scope` that created it.
+pub struct ScopedDir<'data, 'dir> {
+    #[cfg(CONFIG_DEBUG_FS)]
+    entry: ManuallyDrop<Entry<'dir>>,
+    _phantom: PhantomData<fn(&'data ()) -> &'dir ()>,
+}
+
+impl<'data, 'dir> ScopedDir<'data, 'dir> {
+    /// Creates a subdirectory inside this `ScopedDir`.
+    ///
+    /// The returned directory handle cannot outlive this one.
+    pub fn dir<'dir2>(&'dir2 self, name: &CStr) -> ScopedDir<'data, 'dir2> {
+        #[cfg(not(CONFIG_DEBUG_FS))]
+        let _ = name;
+        ScopedDir {
+            #[cfg(CONFIG_DEBUG_FS)]
+            entry: ManuallyDrop::new(Entry::dir(name, Some(&*self.entry))),
+            _phantom: PhantomData,
+        }
+    }
+
+    fn create_file<T: Sync>(&self, name: &CStr, data: &'data T, vtable: &'static FileOps<T>) {
+        #[cfg(CONFIG_DEBUG_FS)]
+        core::mem::forget(Entry::file(name, &self.entry, data, vtable));
+    }
+
+    /// Creates a read-only file in this directory.
+    ///
+    /// The file's contents are produced by invoking [`Writer::write`]`.
+    ///
+    /// This function does not produce an owning handle to the file. The created
+    /// file is removed when the [`Scope`] that this directory belongs
+    /// to is dropped.
+    pub fn read_only_file<T: Writer + Send + Sync + 'static>(&self, name: &CStr, data: &'data T) {
+        self.create_file(name, data, &T::FILE_OPS)
+    }
+
+    /// Creates a read-only file in this directory, with contents from a callback.
+    ///
+    /// The file contents are generated by calling `f` with `data`.
+    ///
+    ///
+    /// `f` must be a function item or a non-capturing closure.
+    /// This is statically asserted and not a safety requirement.
+    ///
+    /// This function does not produce an owning handle to the file. The created
+    /// file is removed when the [`Scope`] that this directory belongs
+    /// to is dropped.
+    pub fn read_callback_file<T, F>(&self, name: &CStr, data: &'data T, _f: &'static F)
+    where
+        T: Send + Sync + 'static,
+        F: Fn(&T, &mut fmt::Formatter<'_>) -> fmt::Result + Send + Sync,
+    {
+        let vtable = <FormatAdapter<T, F> as ReadFile<_>>::FILE_OPS.adapt();
+        self.create_file(name, data, vtable)
+    }
+
+    /// Creates a read-write file in this directory.
+    ///
+    /// Reading the file uses the [`Writer`] implementation on `data`. Writing to the file uses
+    /// the [`Reader`] implementation on `data`.
+    ///
+    /// This function does not produce an owning handle to the file. The created
+    /// file is removed when the [`Scope`] that this directory belongs
+    /// to is dropped.
+    pub fn read_write_file<T: Writer + Reader + Send + Sync + 'static>(
+        &self,
+        name: &CStr,
+        data: &'data T,
+    ) {
+        let vtable = &<T as ReadWriteFile<_>>::FILE_OPS;
+        self.create_file(name, data, vtable)
+    }
+
+    /// Creates a read-write file in this directory, with logic from callbacks.
+    ///
+    /// Reading from the file is handled by `f`. Writing to the file is handled by `w`.
+    ///
+    /// `f` and `w` must be function items or non-capturing closures.
+    /// This is statically asserted and not a safety requirement.
+    ///
+    /// This function does not produce an owning handle to the file. The created
+    /// file is removed when the [`Scope`] that this directory belongs
+    /// to is dropped.
+    pub fn read_write_callback_file<T, F, W>(
+        &self,
+        name: &CStr,
+        data: &'data T,
+        _f: &'static F,
+        _w: &'static W,
+    ) where
+        T: Send + Sync + 'static,
+        F: Fn(&T, &mut fmt::Formatter<'_>) -> fmt::Result + Send + Sync,
+        W: Fn(&T, &mut UserSliceReader) -> Result<(), Error> + Send + Sync,
+    {
+        let vtable = <WritableAdapter<FormatAdapter<T, F>, W> as ReadWriteFile<_>>::FILE_OPS
+            .adapt()
+            .adapt();
+        self.create_file(name, data, vtable)
+    }
+
+    /// Creates a write-only file in this directory.
+    ///
+    /// Writing to the file uses the [`Reader`] implementation on `data`.
+    ///
+    /// This function does not produce an owning handle to the file. The created
+    /// file is removed when the [`Scope`] that this directory belongs
+    /// to is dropped.
+    pub fn write_only_file<T: Reader + Send + Sync + 'static>(&self, name: &CStr, data: &'data T) {
+        let vtable = &<T as WriteFile<_>>::FILE_OPS;
+        self.create_file(name, data, vtable)
+    }
+
+    /// Creates a write-only file in this directory, with write logic from a callback.
+    ///
+    /// Writing to the file is handled by `w`.
+    ///
+    /// `w` must be a function item or a non-capturing closure.
+    /// This is statically asserted and not a safety requirement.
+    ///
+    /// This function does not produce an owning handle to the file. The created
+    /// file is removed when the [`Scope`] that this directory belongs
+    /// to is dropped.
+    pub fn write_only_callback_file<T, W>(&self, name: &CStr, data: &'data T, _w: &'static W)
+    where
+        T: Send + Sync + 'static,
+        W: Fn(&T, &mut UserSliceReader) -> Result<(), Error> + Send + Sync,
+    {
+        let vtable = &<WritableAdapter<NoWriter<T>, W> as WriteFile<_>>::FILE_OPS
+            .adapt()
+            .adapt();
+        self.create_file(name, data, vtable)
+    }
+
+    fn empty() -> Self {
+        ScopedDir {
+            #[cfg(CONFIG_DEBUG_FS)]
+            entry: ManuallyDrop::new(Entry::empty()),
+            _phantom: PhantomData,
+        }
+    }
+    #[cfg(CONFIG_DEBUG_FS)]
+    fn into_entry(self) -> Entry<'dir> {
+        ManuallyDrop::into_inner(self.entry)
+    }
+    #[cfg(not(CONFIG_DEBUG_FS))]
+    fn into_entry(self) {}
+}
+
+impl<'data> ScopedDir<'data, 'static> {
+    // This is safe, but intentionally not exported due to footgun status. A ScopedDir with no
+    // parent will never be released by default, and needs to have its entry extracted and used
+    // somewhere.
+    fn new(name: &CStr) -> ScopedDir<'data, 'static> {
+        ScopedDir {
+            #[cfg(CONFIG_DEBUG_FS)]
+            entry: ManuallyDrop::new(Entry::dir(name, None)),
+            _phantom: PhantomData,
+        }
+    }
+}
diff --git a/rust/kernel/debugfs/entry.rs b/rust/kernel/debugfs/entry.rs
index 227fa50b7a79aeab49779e54b8c4241f455777c3..f99402cd3ba0ca12f62d3699e4d6e460d0085d26 100644
--- a/rust/kernel/debugfs/entry.rs
+++ b/rust/kernel/debugfs/entry.rs
@@ -5,26 +5,29 @@
 use crate::ffi::c_void;
 use crate::str::CStr;
 use crate::sync::Arc;
+use core::marker::PhantomData;
 
 /// Owning handle to a DebugFS entry.
 ///
 /// # Invariants
 ///
 /// The wrapped pointer will always be `NULL`, an error, or an owned DebugFS `dentry`.
-pub(crate) struct Entry {
+pub(crate) struct Entry<'a> {
     entry: *mut bindings::dentry,
     // If we were created with an owning parent, this is the keep-alive
-    _parent: Option<Arc<Entry>>,
+    _parent: Option<Arc<Entry<'static>>>,
+    // If we were created with a non-owning parent, this prevents us from outliving it
+    _phantom: PhantomData<&'a ()>,
 }
 
 // SAFETY: [`Entry`] is just a `dentry` under the hood, which the API promises can be transferred
 // between threads.
-unsafe impl Send for Entry {}
+unsafe impl Send for Entry<'_> {}
 
 // SAFETY: All the C functions we call on the `dentry` pointer are threadsafe.
-unsafe impl Sync for Entry {}
+unsafe impl Sync for Entry<'_> {}
 
-impl Entry {
+impl Entry<'static> {
     pub(crate) fn dynamic_dir(name: &CStr, parent: Option<Arc<Self>>) -> Self {
         let parent_ptr = match &parent {
             Some(entry) => entry.as_ptr(),
@@ -39,6 +42,7 @@ pub(crate) fn dynamic_dir(name: &CStr, parent: Option<Arc<Self>>) -> Self {
         Entry {
             entry,
             _parent: parent,
+            _phantom: PhantomData,
         }
     }
 
@@ -71,14 +75,71 @@ pub(crate) unsafe fn dynamic_file<T>(
         Entry {
             entry,
             _parent: Some(parent),
+            _phantom: PhantomData,
         }
     }
+}
+
+impl<'a> Entry<'a> {
+    pub(crate) fn dir(name: &CStr, parent: Option<&'a Entry<'_>>) -> Self {
+        let parent_ptr = match &parent {
+            Some(entry) => entry.as_ptr(),
+            None => core::ptr::null_mut(),
+        };
+        // SAFETY: The invariants of this function's arguments ensure the safety of this call.
+        // * `name` is a valid C string by the invariants of `&CStr`.
+        // * `parent_ptr` is either `NULL` (if `parent` is `None`), or a pointer to a valid
+        //   `dentry` (because `parent` is a valid reference to an `Entry`). The lifetime `'a`
+        //   ensures that the parent outlives this entry.
+        let entry = unsafe { bindings::debugfs_create_dir(name.as_char_ptr(), parent_ptr) };
+
+        Entry {
+            entry,
+            _parent: None,
+            _phantom: PhantomData,
+        }
+    }
+
+    pub(crate) fn file<T>(
+        name: &CStr,
+        parent: &'a Entry<'_>,
+        data: &'a T,
+        file_ops: &FileOps<T>,
+    ) -> Self {
+        // SAFETY: The invariants of this function's arguments ensure the safety of this call.
+        // * `name` is a valid C string by the invariants of `&CStr`.
+        // * `parent.as_ptr()` is a pointer to a valid `dentry` because we have `&'a Entry`.
+        // * `data` is a valid pointer to `T` for lifetime `'a`.
+        // * The returned `Entry` has lifetime `'a`, so it cannot outlive `parent` or `data`.
+        // * The caller guarantees that `vtable` is compatible with `data`.
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
+            _parent: None,
+            _phantom: PhantomData,
+        }
+    }
+}
 
+impl Entry<'_> {
     /// Constructs a placeholder DebugFS [`Entry`].
     pub(crate) fn empty() -> Self {
         Self {
             entry: core::ptr::null_mut(),
             _parent: None,
+            _phantom: PhantomData,
         }
     }
 
@@ -94,7 +155,7 @@ pub(crate) fn as_ptr(&self) -> *mut bindings::dentry {
     }
 }
 
-impl Drop for Entry {
+impl Drop for Entry<'_> {
     fn drop(&mut self) {
         // SAFETY: `debugfs_remove` can take `NULL`, error values, and legal DebugFS dentries.
         // `as_ptr` guarantees that the pointer is of this form.

-- 
2.51.0.355.g5224444f11-goog


