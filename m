Return-Path: <linux-kernel+bounces-801644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFDDB4484D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7609217EC87
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB8E2BCF45;
	Thu,  4 Sep 2025 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x+P32p1y"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F112BD58A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020446; cv=none; b=HzAqGmR4mnMhQcCNQ7ninnEm3JMKYb9a+JlAB9j2ZhrtNnXpF4N87zKa8oOk2Nswdct5iNR8COEzwTNlqYufBeZa14tVNy5h+ylMjhF7bB8rw4y+fcLbWmsGYbzo2rcNje31y03oL0bC5sIuxCzzhEQLiVQ3AdoFUGRtBJ35qPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020446; c=relaxed/simple;
	bh=7Cs+rrmvUc6RnlQb7OHJuhyGOb5Nkjl9WcLbi0YymUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H5oAbfTdbQavc22t3adPp9UC0SuKG5kYDqdvfsJVByLQ5wvEL5q0XHexSbLGmHQc9glY2dzjLHhx09gW5CIio9m+ewQOXzGqJKI6CCH97RDy5/o3NW20wBX27h4QDwxDzLiYBygszcBQuT4JlT6S9xJovNVoxu1nAc9cgXYY7B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x+P32p1y; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327b5e7f2f6so1939527a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757020444; x=1757625244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYq6tB+gGL9lRINn2bAltq2P9gjzfb/ZMX7i5gK5qaM=;
        b=x+P32p1yayb4T+hPYhEo4b+qq9gxy3S4LE6bkHEzO72Drv4jKLqjOU8AcGiS1+sUjE
         lQpuwKO9IPYPbkmWfIXiMd91xUOPDzM/p895Yt6AnTV78/6z/NDurtQbB/WLgpfbVE8Y
         9YnFvvN49nZEt2FYMq8+qA/egBnC+FxuEE3Qpa96JTx+Q9+sMw4zhhrpAktXRwSrH5H3
         SDsH7DvTJ6T5YaUbcE9ocRrTt0v6ohI/utHNiAS0YgBIGK3RCHVpifKMt5/3XVSg3z0T
         mEG88G8WdPQY8q/vlwNQArij3Qumrm50GJCZ0m2sh5vesRV7XJpuBkgJaXuh0W1Uc/Ax
         CNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757020444; x=1757625244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYq6tB+gGL9lRINn2bAltq2P9gjzfb/ZMX7i5gK5qaM=;
        b=cuTgcjQAHXAqtq6IIeV9cNxkdFQdWMK5MgZpfF4oCtiNNpWTlghi8dAOTf3m1rjRB/
         rkzWq98HoWsPZh2Yk9kmvLDIY4ThTR+dblwzcb+tT2JPc+fBECFWZGzrYJ4fKD7tAws0
         SxQDr/m9/i1hLvbNQDe8mLEJDVT/G592R1Q4xA+O361y4DoOr5CP0ZJVnuGNOfdDQScV
         2lf4r6pwcAcbUtY7rHACv68+Sb7zfeRlrFutgHTv4MsiIAmP796YUd74qRwMwTfR/xUP
         UhncSiED4ENcG9H26bJjHs2FFed6VSNKtpAh50LCzFiJcfae6By5cy9fdOS5v0FKpqHf
         leIg==
X-Gm-Message-State: AOJu0YxKEb4FGZls3Rb5U/E1HErIJKa8jvJErI/A7Lw0lcJX60Q6SYc8
	NK+wsbpgJPJsBhVER5LWIMrQT/FU8i63WADP08/lnCB6aZvwEH13qTmGqJsV4k/qd2Sh/UmRDxb
	fdatFo139Tg==
X-Google-Smtp-Source: AGHT+IGXYqyfCWDovUpzGHCdIi4JQlyFuhKGtfDl9eflGOP98Whn/jF2Ow/e927xtqJV6ktkfHLgmuz23u9R
X-Received: from pjg5.prod.google.com ([2002:a17:90b:3f45:b0:325:220a:dd41])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5543:b0:32b:c5a9:7be9
 with SMTP id 98e67ed59e1d1-32bc5a97d11mr512876a91.25.1757020443710; Thu, 04
 Sep 2025 14:14:03 -0700 (PDT)
Date: Thu, 04 Sep 2025 21:13:52 +0000
In-Reply-To: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757020440; l=7433;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=7Cs+rrmvUc6RnlQb7OHJuhyGOb5Nkjl9WcLbi0YymUk=; b=Dd23oQQlC44VStRaoqy4wyvrm8FleZTxTYojIARhabJoQXxVAn5nzGpEvDcSVIcXe0UuUUJCH
 uFDKJ4RTUEiDXgnjB81H6iai7w3aqfXxOxbEpNSL3CIBdcDW1yngcF+
X-Mailer: b4 0.14.2
Message-ID: <20250904-debugfs-rust-v11-1-7d12a165685a@google.com>
Subject: [PATCH v11 1/7] rust: debugfs: Add initial support for directories
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

Adds a `debugfs::Dir` type that can be used to create and remove
DebugFS directories. The `Dir` handle automatically cleans up the
directory on `Drop`.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 MAINTAINERS                     |  2 +
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/debugfs.rs          | 82 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/debugfs/entry.rs    | 61 ++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 147 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf6a991c0160a96620f40308c29ee0..8f2dbf71ca3f8f97e4d7619375279ed11d1261b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7472,6 +7472,8 @@ F:	include/linux/kobj*
 F:	include/linux/property.h
 F:	include/linux/sysfs.h
 F:	lib/kobj*
+F:	rust/kernel/debugfs.rs
+F:	rust/kernel/debugfs/
 F:	rust/kernel/device.rs
 F:	rust/kernel/device/
 F:	rust/kernel/device_id.rs
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 84d60635e8a9baef1f1a1b2752dc0fa044f8542f..e847820dc807fdda2d682d496a3c6361bb944c10 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -46,6 +46,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/cred.h>
+#include <linux/debugfs.h>
 #include <linux/device/faux.h>
 #include <linux/dma-mapping.h>
 #include <linux/errname.h>
diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
new file mode 100644
index 0000000000000000000000000000000000000000..65be71600b8eda83c0d313f3d205d0713e8e9510
--- /dev/null
+++ b/rust/kernel/debugfs.rs
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Google LLC.
+
+//! DebugFS Abstraction
+//!
+//! C header: [`include/linux/debugfs.h`](srctree/include/linux/debugfs.h)
+
+// When DebugFS is disabled, many parameters are dead. Linting for this isn't helpful.
+#![cfg_attr(not(CONFIG_DEBUG_FS), allow(unused_variables))]
+
+#[cfg(CONFIG_DEBUG_FS)]
+use crate::prelude::*;
+use crate::str::CStr;
+#[cfg(CONFIG_DEBUG_FS)]
+use crate::sync::Arc;
+
+#[cfg(CONFIG_DEBUG_FS)]
+mod entry;
+#[cfg(CONFIG_DEBUG_FS)]
+use entry::Entry;
+
+/// Owning handle to a DebugFS directory.
+///
+/// The directory in the filesystem represented by [`Dir`] will be removed when handle has been
+/// dropped *and* all children have been removed.
+// If we have a parent, we hold a reference to it in the `Entry`. This prevents the `dentry`
+// we point to from being cleaned up if our parent `Dir`/`Entry` is dropped before us.
+//
+// The `None` option indicates that the `Arc` could not be allocated, so our children would not be
+// able to refer to us. In this case, we need to silently fail. All future child directories/files
+// will silently fail as well.
+#[derive(Clone)]
+pub struct Dir(#[cfg(CONFIG_DEBUG_FS)] Option<Arc<Entry>>);
+
+impl Dir {
+    /// Create a new directory in DebugFS. If `parent` is [`None`], it will be created at the root.
+    fn create(name: &CStr, parent: Option<&Dir>) -> Self {
+        #[cfg(CONFIG_DEBUG_FS)]
+        {
+            let parent_entry = match parent {
+                // If the parent couldn't be allocated, just early-return
+                Some(Dir(None)) => return Self(None),
+                Some(Dir(Some(entry))) => Some(entry.clone()),
+                None => None,
+            };
+            Self(
+                // If Arc creation fails, the `Entry` will be dropped, so the directory will be
+                // cleaned up.
+                Arc::new(Entry::dynamic_dir(name, parent_entry), GFP_KERNEL).ok(),
+            )
+        }
+        #[cfg(not(CONFIG_DEBUG_FS))]
+        Self()
+    }
+
+    /// Create a new directory in DebugFS at the root.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::c_str;
+    /// # use kernel::debugfs::Dir;
+    /// let debugfs = Dir::new(c_str!("parent"));
+    /// ```
+    pub fn new(name: &CStr) -> Self {
+        Dir::create(name, None)
+    }
+
+    /// Creates a subdirectory within this directory.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::c_str;
+    /// # use kernel::debugfs::Dir;
+    /// let parent = Dir::new(c_str!("parent"));
+    /// let child = parent.subdir(c_str!("child"));
+    /// ```
+    pub fn subdir(&self, name: &CStr) -> Self {
+        Dir::create(name, Some(self))
+    }
+}
diff --git a/rust/kernel/debugfs/entry.rs b/rust/kernel/debugfs/entry.rs
new file mode 100644
index 0000000000000000000000000000000000000000..d2fba0e65e20e954e2a33e776b872bac4adb12e8
--- /dev/null
+++ b/rust/kernel/debugfs/entry.rs
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Google LLC.
+
+use crate::str::CStr;
+use crate::sync::Arc;
+
+/// Owning handle to a DebugFS entry.
+///
+/// # Invariants
+///
+/// The wrapped pointer will always be `NULL`, an error, or an owned DebugFS `dentry`.
+pub(crate) struct Entry {
+    entry: *mut bindings::dentry,
+    // If we were created with an owning parent, this is the keep-alive
+    _parent: Option<Arc<Entry>>,
+}
+
+// SAFETY: [`Entry`] is just a `dentry` under the hood, which the API promises can be transferred
+// between threads.
+unsafe impl Send for Entry {}
+
+// SAFETY: All the C functions we call on the `dentry` pointer are threadsafe.
+unsafe impl Sync for Entry {}
+
+impl Entry {
+    pub(crate) fn dynamic_dir(name: &CStr, parent: Option<Arc<Self>>) -> Self {
+        let parent_ptr = match &parent {
+            Some(entry) => entry.as_ptr(),
+            None => core::ptr::null_mut(),
+        };
+        // SAFETY: The invariants of this function's arguments ensure the safety of this call.
+        // * `name` is a valid C string by the invariants of `&CStr`.
+        // * `parent_ptr` is either `NULL` (if `parent` is `None`), or a pointer to a valid
+        //   `dentry` by our invariant. `debugfs_create_dir` handles `NULL` pointers correctly.
+        let entry = unsafe { bindings::debugfs_create_dir(name.as_char_ptr(), parent_ptr) };
+
+        Entry {
+            entry,
+            _parent: parent,
+        }
+    }
+
+    /// Returns the pointer representation of the DebugFS directory.
+    ///
+    /// # Guarantees
+    ///
+    /// Due to the type invariant, the value returned from this function will always be an error
+    /// code, NULL, or a live DebugFS directory. If it is live, it will remain live at least as
+    /// long as this entry lives.
+    pub(crate) fn as_ptr(&self) -> *mut bindings::dentry {
+        self.entry
+    }
+}
+
+impl Drop for Entry {
+    fn drop(&mut self) {
+        // SAFETY: `debugfs_remove` can take `NULL`, error values, and legal DebugFS dentries.
+        // `as_ptr` guarantees that the pointer is of this form.
+        unsafe { bindings::debugfs_remove(self.as_ptr()) }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c0badf548025a57f946fa18bc73e3..828620c8441566a638f31d03633fc1bf4c1bda85 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -76,6 +76,7 @@
 pub mod cpufreq;
 pub mod cpumask;
 pub mod cred;
+pub mod debugfs;
 pub mod device;
 pub mod device_id;
 pub mod devres;

-- 
2.51.0.355.g5224444f11-goog


