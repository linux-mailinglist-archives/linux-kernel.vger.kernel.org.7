Return-Path: <linux-kernel+bounces-724332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CC1AFF17A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B866E5A551D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9634F23D28D;
	Wed,  9 Jul 2025 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCZHdGYe"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88923F41A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088188; cv=none; b=KbETxJSvVt/SkxhCEVKBXxiwckX8k+r1b40/D6wMWn/5bchJ8Nspi08iWKcaL56yYTdBGH3Vjlq7TZVLT471HOzoJ4jNZfHWvgMaSCVVFqHbmcV97lzabfFaMak6KFTBRE2Gay063+KxCiD1tXWNm4OVjRWNVs/DohLjRNrTWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088188; c=relaxed/simple;
	bh=2xMXvnwdehEJpRes29S5HTu29jmng1EgLMgZ0BcjSMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XKlIqBcL4K3Z9DSZCauSK6oQS/O4AA2j65x1OQGoDr23jjAFWsmm51luS1toBWvCwD01eJeMIxjz1gUi/dqV2qgE1HRqqji6hWmGbmWsMlpu2+NHVp7wSd3udMy/O7y6jZmJWleuNoFDBa4D774AxxTlta3zLwQ4mTje/gyhTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WCZHdGYe; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ad608d60aso121917b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752088186; x=1752692986; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYtB32NJTeIv/b7Je1focZ0Ga/KNiuYXzRHxWQcjtBg=;
        b=WCZHdGYe5J/XcM8zQa2QzQEfXsqGjIYBt91MgVdSDcKS9ptHzAX8lvqVeZi5xnHIf7
         ky2qz+1b3wSzrLcnLlnVoz4jQwYQB26ZgbPFFQfmYiR9OkqiNgsloIeV/ftDNiVxSFw9
         0tlZqjuoLNLMjz+CxkWhkUHmu/hA9TMkckzjgaN+Rdux0u+jg0Sl/pQaSBsIYoyhYeLe
         DD9y7D+FCk6PZD3A033yLut9G4kb9YFuWqUc+I95GK6ZdpRBVuxm0qd1XzFQZUcjj2Br
         knN2C3B+uY+C8bUEAV66Q35kT44jmmTFjPM5c0C4ObQyO+E2/xDDL/T6UWCgjvi3CIge
         E/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088186; x=1752692986;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYtB32NJTeIv/b7Je1focZ0Ga/KNiuYXzRHxWQcjtBg=;
        b=CGD2OSlgSqoXefWMy1PusTEXyY3p/06BWQVbWQYazuoE0XmNGJ8OIu9wUc2OJ2GQ3B
         ZTldLxWkxDoixwutudgEt2WBOfXX1SBvhv94tvRyJc9dHClcJUJN7tOjNddkea0V8fbg
         hmC/I0O12RClZyLy9rW3uVboX0Q9G1X9LaNWdHQ8NYfq02LFU/wfZCjYarL0TAPkY3JX
         wpcXYVLe9vx67UZ+zAzXy75pIKtnpfVL+eCl22lNkfF0ixwDS7lwm+Lg4ymclVekMwf/
         R951VDm0Fodgo2n1WRgdaHpkaLsgh5ryqjj3xq4BvrEUT1UoCQ87js1EnDARSgB2/Sb4
         bgFQ==
X-Gm-Message-State: AOJu0YwYbLOzZ2uwlAtAlDC3ABeZw4lb3UgPGvg6THcWBaUHPR/Is2lb
	uoQRA9BmnHGxPZLNmDVcu9h+4mU0CrphIOufsf86RvE7aT3qYmCT6vNO7m5qNE2NBNA+w5Yu5WC
	5K/gaYjGW+A==
X-Google-Smtp-Source: AGHT+IHYrt50dBP3H7XchHPpdCvmoQ39JsAAAzyP1dC7yMptJZ1AomsPrvE638XBJnJXU3RQgB2AS3d6HXdF
X-Received: from pfoo19.prod.google.com ([2002:a05:6a00:1a13:b0:746:18ec:d11a])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22d2:b0:748:e5a0:aa77
 with SMTP id d2e1a72fcca58-74eb558ed64mr923038b3a.13.1752088186294; Wed, 09
 Jul 2025 12:09:46 -0700 (PDT)
Date: Wed, 09 Jul 2025 19:09:28 +0000
In-Reply-To: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752088183; l=7535;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=2xMXvnwdehEJpRes29S5HTu29jmng1EgLMgZ0BcjSMY=; b=yY0F+uYOTXb6bwaMkBLATUk5Sqhto4XeDcz5spLLWEaJ9LhewltVIunONhW6llm2YxaRsKPov
 VmhfQIaHKM6DpqkCXcMs+kzGLRfixVF9tshsSudXln3n68OtpmbbuEm
X-Mailer: b4 0.14.2
Message-ID: <20250709-debugfs-rust-v9-1-92b9eab5a951@google.com>
Subject: [PATCH v9 1/5] rust: debugfs: Bind DebugFS directory creation
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

Support creating DebugFS directories and subdirectories. Similar to the
original DebugFS API, errors are hidden.

Directories persist until their handle and the handles of any child
objects have been dropped.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 MAINTAINERS                     |  2 +
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/debugfs.rs          | 90 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/debugfs/entry.rs    | 58 ++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 152 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f8ddeec3b177772caf6160de65ca9985912cac8..1427af9d9779b1f6463409f4392e2900438bdc2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7367,6 +7367,8 @@ F:	include/linux/kobj*
 F:	include/linux/property.h
 F:	include/linux/sysfs.h
 F:	lib/kobj*
+F:	rust/kernel/debugfs.rs
+F:	rust/kernel/debugfs/
 F:	rust/kernel/device.rs
 F:	rust/kernel/device/
 F:	rust/kernel/device_id.rs
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 7e8f2285064797d5bbac5583990ff823b76c6bdc..8600b361bce3f3b613d5189b7acd1704326b6284 100644
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
index 0000000000000000000000000000000000000000..2359bd11cd664fb9f7206f8fe38f758dc43d2cb8
--- /dev/null
+++ b/rust/kernel/debugfs.rs
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Google LLC.
+
+//! DebugFS Abstraction
+//!
+//! C header: [`include/linux/debugfs.h`](srctree/include/linux/debugfs.h)
+
+#[cfg(CONFIG_DEBUG_FS)]
+use crate::prelude::GFP_KERNEL;
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
+/// This directory will be cleaned up when the handle and all child directory/file handles have
+/// been dropped.
+// We hold a reference to our parent if it exists to prevent the dentry we point to from being
+// cleaned up when our parent is removed.
+pub struct Dir(#[cfg(CONFIG_DEBUG_FS)] Option<Arc<Entry>>);
+
+impl Dir {
+    /// Create a new directory in DebugFS. If `parent` is [`None`], it will be created at the root.
+    #[cfg(CONFIG_DEBUG_FS)]
+    fn create(name: &CStr, parent: Option<&Dir>) -> Self {
+        let parent_ptr = match parent {
+            // If the parent couldn't be allocated, just early-return
+            Some(Dir(None)) => return Self(None),
+            Some(Dir(Some(entry))) => entry.as_ptr(),
+            None => core::ptr::null_mut(),
+        };
+        // SAFETY:
+        // * `name` argument points to a NUL-terminated string that lives across the call, by
+        //   invariants of `&CStr`.
+        // * If `parent` is `None`, `parent_ptr` is null to mean create at root.
+        // * If `parent` is `Some`, `parent_ptr` is a live dentry debugfs pointer.
+        let dir = unsafe { bindings::debugfs_create_dir(name.as_char_ptr(), parent_ptr) };
+
+        Self(
+            // If Arc creation fails, the `Entry` will be dropped, so the directory will be cleaned
+            // up.
+            Arc::new(
+                // SAFETY: `debugfs_create_dir` either returns an error code or a legal `dentry`
+                // pointer, and the parent is the same one passed to `debugfs_create_dir`
+                unsafe { Entry::new(dir, parent.and_then(|dir| dir.0.clone())) },
+                GFP_KERNEL,
+            )
+            .ok(),
+        )
+    }
+
+    #[cfg(not(CONFIG_DEBUG_FS))]
+    fn create(_name: &CStr, _parent: Option<&Dir>) -> Self {
+        Self()
+    }
+
+    /// Create a DebugFS subdirectory.
+    ///
+    /// Subdirectory handles cannot outlive the directory handle they were created from.
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
+}
diff --git a/rust/kernel/debugfs/entry.rs b/rust/kernel/debugfs/entry.rs
new file mode 100644
index 0000000000000000000000000000000000000000..ae0e2c4e1d58e878ebb081a71e4ac0f4a7d99b91
--- /dev/null
+++ b/rust/kernel/debugfs/entry.rs
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Google LLC.
+
+use crate::sync::Arc;
+
+/// Owning handle to a DebugFS entry.
+///
+/// # Invariants
+///
+/// The wrapped pointer will always be `NULL`, an error, or an owned DebugFS `dentry`.
+pub(crate) struct Entry {
+    entry: *mut bindings::dentry,
+    _parent: Option<Arc<Entry>>,
+}
+
+// SAFETY: [`Entry`] is just a `dentry` under the hood, which the API promises can be transferred
+// between threads.
+unsafe impl Send for Entry {}
+
+// SAFETY: All the native functions we re-export use interior locking, and the contents of the
+// struct are opaque to Rust.
+unsafe impl Sync for Entry {}
+
+impl Entry {
+    /// Constructs a new DebugFS [`Entry`] from the underlying pointer.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must either be an error code, `NULL`, or represent a transfer of ownership of a
+    /// live DebugFS directory. If this is a child directory or file, `'a` must be less than the
+    /// lifetime of the parent directory.
+    ///
+    /// If the dentry has a parent, it must be provided as the parent argument.
+    pub(crate) unsafe fn new(entry: *mut bindings::dentry, parent: Option<Arc<Entry>>) -> Self {
+        Self {
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
+    /// code, NULL, or a live DebugFS directory.
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
index 5bbf3627212f0a26d34be0d6c160a370abf1e996..8b4d7c95bcc895cf15544d9688941f93f2780510 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -67,6 +67,7 @@
 pub mod cpufreq;
 pub mod cpumask;
 pub mod cred;
+pub mod debugfs;
 pub mod device;
 pub mod device_id;
 pub mod devres;

-- 
2.50.0.727.gbf7dc18ff4-goog


