Return-Path: <linux-kernel+bounces-776615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93553B2CF92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28771C23C57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBB02417F0;
	Tue, 19 Aug 2025 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1ME8vxL"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E95274B59
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755644038; cv=none; b=bleXQJcUQHqsVbfHKl5bmtf7trYnU5Te5wb67X/Ds9OkKFYdsAmUPjJs1mHHkxx/DjONycE5yiHma/3Qh8F6equHGY9CDRIhteSS+bJeIWWajau9HURqKCOlbkNeAnyBhMaYWNvrPeGQy2qN+Pp0jd8rUPNJPQN6EYJt0ZiZnZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755644038; c=relaxed/simple;
	bh=Q6gbENqBZLgftJNURwx+pcGrvP2HoM5MUdDZJTubatI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UvLPW19Boi82Lx7v+OInWfxd8nwOd2vQnJy9LSFLBj2AbkQr8dBA69/JCT9KbVAemDIKm4NztHHv97VxpTOx2JR8gOYpieRibO4D3s7qayl4pGXarEzrzzz2aDm9emyK8OyVpcJB28Iiycj3izcNEu/kpbxj+nm+uzOyicQCqZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F1ME8vxL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457f59889so61982905ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755644036; x=1756248836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iYi9g84IW9mJ6DZoQ8KgU6DxtgqHpReZrDyUTPXUQwY=;
        b=F1ME8vxL+fNdIgm0T3v+cctm/Jk50ZGqrW810nyDRhhGhLVUyylMuqOwixf+KX7urC
         NUGOnmT5TrhSyVmp5IqGge4LzU8qUyvKYzsJXN2E/DfzLhnEZ9532m93IN8xUlhWvPOd
         1vg48sGBRcWP4HxObjyuuuJrbsF+f31JRL9my829Noko7CafIYSOGb8Te2Xa4dpo6gSb
         lOqzUmejIVEaVKDCk2N06w7N6A/sJYWySS0VyNNRsiMQYenRmHpIa6F4Q4dXU6mvZW8Q
         Prkc037nKHR55j5ZNsHi97CRhYX5/QFKxw5SWYm10S7OLrXEdu7pGjHJxrkKOzU+qc5Y
         sbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755644036; x=1756248836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYi9g84IW9mJ6DZoQ8KgU6DxtgqHpReZrDyUTPXUQwY=;
        b=tuurW2nNhKEHQ3Q6XwyCDn8PssZdk+8BVx/jxq9QMrwZ1ZkTPnnGymubRTLYWngdpr
         aVexnyFt1s0XQK44rVc3YweBaj6mIr5a6rmUkOkzR/JOeW1F88xnlGWQZ/x5lslUei0G
         O1eoML/D3JYb4eYS1ll086lfK0slaQRkcK5wEagQoGhajU9VTj2d8ZeAgbWPj2S6AwF3
         OJNv9h+B9vrgbqeIGtiXhwHQW0ND/Jlfl7PzBRWw1MQCh0EM924suAhGoGIrGWJ3puIU
         2Aw1yC4Tijm50+62wn533GmOvHCz+kl2EKVoCF8jUkXiPH0nDIf2ivNsKKHhREZ2NSGq
         NMeQ==
X-Gm-Message-State: AOJu0YxOhped2DR20c/eKx+97lxEpcre+y7EXnuzIqh+NxzVDxpKH7Fi
	Rw8PkqAzwej8FQQsLdhMwaPtJX1VuNRacKnezmsWbRuDgA5MG85ihdqzHcJkS4NGUZCXmAz354p
	jXDUnTSebZQ==
X-Google-Smtp-Source: AGHT+IHFMsiN8zWFvgpPY4KvwcYgAO/SFPqahNYCFRQvt77/3GvahzpIinaV/VYbyYstkHvBGY5gInZDaxyU
X-Received: from pldo18.prod.google.com ([2002:a17:903:92:b0:235:f4e3:ba29])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef47:b0:240:99e6:6bc3
 with SMTP id d9443c01a7336-245ef15604cmr6993685ad.20.1755644035672; Tue, 19
 Aug 2025 15:53:55 -0700 (PDT)
Date: Tue, 19 Aug 2025 22:53:41 +0000
In-Reply-To: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755644022; l=17271;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=Q6gbENqBZLgftJNURwx+pcGrvP2HoM5MUdDZJTubatI=; b=JWi2UzldE/O4OPm9njbpBfh2G30Bs4WkbSyMoGucjKWWlNyaZftKZnSa6mOPqHvyYLCiT1NJf
 JqOtO/niVpeAp/KRB/cDTA28XaKYm+Aw6R2alKeVBKH0Q9/xbrW6sPb
X-Mailer: b4 0.14.2
Message-ID: <20250819-debugfs-rust-v10-6-86e20f3cf3bb@google.com>
Subject: [PATCH v10 6/7] rust: debugfs: Add support for scoped directories
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
 rust/kernel/debugfs.rs       | 267 ++++++++++++++++++++++++++++++++++++++++++-
 rust/kernel/debugfs/entry.rs |  73 +++++++++++-
 2 files changed, 330 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index a843d01506a54d5f8626dab5223d006c9a363a91..5e2b60cc1ea3eff859dbad8d7dd7a84d7c08d766 100644
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
@@ -268,6 +271,54 @@ pub fn write_callback_file<
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
+    pub fn scope<
+        'a,
+        T: 'a,
+        E: 'a,
+        TI: PinInit<T, E> + 'a,
+        F: for<'data, 'dir> FnOnce(&'data T, &'dir ScopedDir<'data, 'dir>) + 'a,
+    >(
+        &'a self,
+        data: TI,
+        name: &'a CStr,
+        init: F,
+    ) -> impl PinInit<Scope<T>, E> + 'a {
+        Scope::new(data, |data| {
+            let scoped = self.scoped_dir(name);
+            init(data, &scoped);
+            scoped.into_entry()
+        })
+    }
 }
 
 #[pin_data]
@@ -276,7 +327,7 @@ pub fn write_callback_file<
 pub struct Scope<T> {
     // This order is load-bearing for drops - `_entry` must be dropped before `data`.
     #[cfg(CONFIG_DEBUG_FS)]
-    _entry: Entry,
+    _entry: Entry<'static>,
     #[pin]
     data: T,
     // Even if `T` is `Unpin`, we still can't allow it to be moved.
@@ -314,11 +365,11 @@ fn new<E, TI: PinInit<T, E>, F: for<'a> FnOnce(&'a T)>(
 
 #[cfg(CONFIG_DEBUG_FS)]
 impl<T> Scope<T> {
-    fn entry_mut(self: Pin<&mut Self>) -> &mut Entry {
+    fn entry_mut(self: Pin<&mut Self>) -> &mut Entry<'static> {
         // SAFETY: _entry is not structurally pinned
         unsafe { &mut Pin::into_inner_unchecked(self)._entry }
     }
-    fn new<'b, E: 'b, TI: PinInit<T, E> + 'b, F: for<'a> FnOnce(&'a T) -> Entry + 'b>(
+    fn new<'b, E: 'b, TI: PinInit<T, E> + 'b, F: for<'a> FnOnce(&'a T) -> Entry<'static> + 'b>(
         data: TI,
         init: F,
     ) -> impl PinInit<Self, E> + 'b
@@ -339,6 +390,36 @@ fn new<'b, E: 'b, TI: PinInit<T, E> + 'b, F: for<'a> FnOnce(&'a T) -> Entry + 'b
     }
 }
 
+impl<T> Scope<T> {
+    /// Creates a new scope, which is a directory at the root of the debugfs filesystem,
+    /// associated with some data `T`.
+    ///
+    /// The `init` closure is called to populate the directory with files and subdirectories. These
+    /// files can reference the data stored in the scope.
+    ///
+    /// The entire directory tree created within the scope will be removed when the returned
+    /// `Scope` handle is dropped.
+    pub fn dir<
+        'a,
+        E: 'a,
+        TI: PinInit<T, E> + 'a,
+        F: for<'data, 'dir> FnOnce(&'data T, &'dir ScopedDir<'data, 'dir>) + 'a,
+    >(
+        data: TI,
+        name: &'a CStr,
+        init: F,
+    ) -> impl PinInit<Self, E> + 'a
+    where
+        T: 'a,
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
@@ -352,3 +433,181 @@ fn deref(&self) -> &T {
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
+    /// The file's contents are produced by invoking [`Render::render`]`.
+    ///
+    /// This function does not produce an owning handle to the file. The created
+    /// file is removed when the [`Scope`] that this directory belongs
+    /// to is dropped.
+    pub fn read_only_file<T: Render + Send + Sync + 'static>(&self, name: &CStr, data: &'data T) {
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
+    pub fn read_callback_file<
+        T: Send + Sync + 'static,
+        F: Fn(&T, &mut fmt::Formatter<'_>) -> fmt::Result + Send + Sync,
+    >(
+        &self,
+        name: &CStr,
+        data: &'data T,
+        _f: &'static F,
+    ) {
+        let vtable = <FormatAdapter<T, F> as ReadFile<_>>::FILE_OPS.adapt();
+        self.create_file(name, data, vtable)
+    }
+
+    /// Creates a read-write file in this directory.
+    ///
+    /// Reading the file uses the [`Render`] implementation on `data`. Writing to the file uses
+    /// the [`UpdateFromSlice`] implementation on `data`.
+    ///
+    /// This function does not produce an owning handle to the file. The created
+    /// file is removed when the [`Scope`] that this directory belongs
+    /// to is dropped.
+    pub fn read_write_file<T: Render + UpdateFromSlice + Send + Sync + 'static>(
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
+    pub fn read_write_callback_file<
+        T: Send + Sync + 'static,
+        F: Fn(&T, &mut fmt::Formatter<'_>) -> fmt::Result + Send + Sync,
+        W: Fn(&T, &mut UserSliceReader) -> Result<(), Error> + Send + Sync,
+    >(
+        &self,
+        name: &CStr,
+        data: &'data T,
+        _f: &'static F,
+        _w: &'static W,
+    ) {
+        let vtable = <WritableAdapter<FormatAdapter<T, F>, W> as ReadWriteFile<_>>::FILE_OPS
+            .adapt()
+            .adapt();
+        self.create_file(name, data, vtable)
+    }
+
+    /// Creates a write-only file in this directory.
+    ///
+    /// Writing to the file uses the [`UpdateFromSlice`] implementation on `data`.
+    ///
+    /// This function does not produce an owning handle to the file. The created
+    /// file is removed when the [`Scope`] that this directory belongs
+    /// to is dropped.
+    pub fn write_only_file<T: UpdateFromSlice + Send + Sync + 'static>(
+        &self,
+        name: &CStr,
+        data: &'data T,
+    ) {
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
+    pub fn write_only_callback_file<
+        T: Send + Sync + 'static,
+        W: Fn(&T, &mut UserSliceReader) -> Result<(), Error> + Send + Sync,
+    >(
+        &self,
+        name: &CStr,
+        data: &'data T,
+        _w: &'static W,
+    ) {
+        let vtable = &<WritableAdapter<NoRender<T>, W> as WriteFile<_>>::FILE_OPS
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
2.51.0.rc1.167.g924127e9c0-goog


