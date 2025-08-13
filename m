Return-Path: <linux-kernel+bounces-766250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34395B24453
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0200F5A2596
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D2E2F0C7B;
	Wed, 13 Aug 2025 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ceVBx8vj"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C714A2F0C49
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073656; cv=none; b=bOHBqcZysTDkHMIfjRJcNezAwkIHwzW3tL++cDXrLzGT07BZnM63ONfNuAzCBBqu4ikKe5WRANKEP5R/E2SwhBFlsm3fg4ffoHD0NIBsQHtp4Syk/IEdymFz3uH0+MYxjmWG1tSByOmDmDuA8rE2jD5/2Jqz4pn2ceVYS8SC7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073656; c=relaxed/simple;
	bh=83CIG/yYVFV5oc5WpQxs7LvduOQS2arjCyxfm7bOmAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mhRSSyBYDo9tkOf9/XH3AXrluZ8SXwkRUZTRSOM7LNl7QcGxUdFlgLhub6N7f1VAdyB8/k3ItrQGGIzKQa5Cgv3vuLLrQa7Rta7B8CBoeQN24WmAbrJPmM3W/HbgqisRwF70fMhuGLOKO2gX6QlN3JEFdG/rvF7tGmWNCJ19BrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ceVBx8vj; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-458bf93f729so32829025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755073653; x=1755678453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv73A+++0TWQ7mgHKwS6GFRnfK2NLUU7501mITzCcHQ=;
        b=ceVBx8vjI7FjCAJaTtPzUca3LkTJEdKRDvpApYOgtyJvp9rn9yLY9yejjgF2XkPOAL
         YwuhJnP/7vdSWwb3e0DFNHr8e2dlEae4T8a1ChUGsL0Z3QKJ1UFHC1bdgnewjE6ayPUm
         FQ3YyKDhMMl1NlOB3yUMuc1NVow/UpWSveTIIUvDJh+LS/x17wyfTelgcax5z5H6jBvI
         5nTHkjlKJigRnK6Rcya+571H6MMKbCcvnD2OypXweDqGQS/etkJJiu58UAe+QGJ33DdD
         uYi0V8Qqu5/mHmkcvMRvwk8Y5rPfhHFmm1+M3fk7b25pbuur9WWsusMC45MvPAIylXSH
         07ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755073653; x=1755678453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv73A+++0TWQ7mgHKwS6GFRnfK2NLUU7501mITzCcHQ=;
        b=k47Jrz2PAr1uXRElIyRH2DWdXErWG17OhWspgxMT7j53MF+ZYgl3k/C6Ktuh9oDemH
         AD1T169z6qn/V9yYb0aAvCmBrwz7WGs2iz21qZFuAw+0gIEigjJJU7LjNbZOqNVLam0q
         l5CbMZIyy+tEMHjbgrPmezQnS92gahlUMH2Ktv6uRmuh5wT///gJgTCcCJdBew6/9ob/
         5ro8Hi50V7gRcQ11aK7YG4v/NgV77QE1ODEGHX8I+5jI+b+P5+bVUKiwEJTcZcputiM/
         EnFVNq7B1En/DBFs3YTDGvNMlM9+HnPM79OmRN0tFdmmMWNLBjmg3MJUiN6QVXUEWWoK
         vSxg==
X-Forwarded-Encrypted: i=1; AJvYcCXZurXrDjgj2eEI0DLp8tOcigF7sl5Q4UmJ1llFiWI6htnoYBtNOtGTUCsGdZC9zSdd91wSVTkhg4aM1FU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0rMmhzepLojlB2rqyhrjgbQdHVxTHl2VaNmwKOGbMcO57ivDX
	CTl2G4gTv6Ck7sxyLBogU72O68elK+bYTU6NHJPmJcwVQWA9/NQHtsUag/pQm2QYIARgCOA+rWo
	t61RUzF3jeH6Nh6rWqQ==
X-Google-Smtp-Source: AGHT+IHgWah8vaIyiZQvShZ+eP/Xc8juKyVKI8pMD5CVwQu1TaUbkPB2YIy8jD1J9uT8MJfn8rasAauKIeszqX8=
X-Received: from wmti10.prod.google.com ([2002:a05:600c:8b8a:b0:459:dede:aaea])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19cb:b0:459:e3f8:92ec with SMTP id 5b1f17b1804b1-45a165a5acfmr21538855e9.10.1755073653092;
 Wed, 13 Aug 2025 01:27:33 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:27:19 +0000
In-Reply-To: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7253; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=83CIG/yYVFV5oc5WpQxs7LvduOQS2arjCyxfm7bOmAQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBonExtDx2M5QU/HAIhxb7BlCGwVBsgpWSaCovO1
 5VlhROSc4mJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJxMbQAKCRAEWL7uWMY5
 Rl7DEACuHjq3unzYiXXF1gBZmhUGn5ZpZujbc23zRbQzccdMtRXMp0E8Pr+UP/2B66gNSLrevnT
 OtYobEWd3ZKxTNZRikw0oNOiLHq4IApLoQfZtXu3C44HSlSpNY+kdcQKYw3/625IeMVRDMvNSb2
 vVLuTICNlCy2y0TBjZnPpGs9y3F7Yy2bC23RUslHjifhizMBIZal0ivUqCxtkL+V6Dy4E+qBwgQ
 QPhXGtW9hrnP6R5v8l5K+789YKOXdcHNcRvd2PSsii3bxl1sTDRL99Y9x8Fh/oJJBhpDu6tjKda
 gcjYwHskokDXbHzBWhA1mJ9gIOUXRYz9Tf4EIy4Z+jtdvkyRCq0/DWp6ZhtLH++opF4pdnKccwM
 GUBeCKSGrJ/H/5YHRhd844addh6HilyspsL47h9c3qkXpnXa1d4ohutdBcjGxYyQvqWcXqwMX+E
 5Yy4jwwnIk7JgsVdQ0xSRwKFLNWq1ROrKzvw2h5SH0pp0pLJBRAST40CXN2cC25ruBnVH8kV8FU
 CjG48vlV3LXATIuWSOMPoJJxXtZR8GGDKpieYm0lgSp+7ijVkKPZgYoH0EPRuMoU+F9M34xQHwG
 gBoe7Y4hbEbZbdQ7Z2U6HjbjMnHJ/1nOWfFSNxyXg3sPlmj0VgnFmzRBYRoLp8YJNGVv1YTgtKO oEJPrzLkep36aNw==
X-Mailer: b4 0.14.2
Message-ID: <20250813-iov-iter-v4-3-c4f1932b05ef@google.com>
Subject: [PATCH v4 3/4] rust: miscdevice: Provide additional abstractions for
 iov_iter and kiocb structures
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Benno Lossin <lossin@kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

These will be used for the read_iter() and write_iter() callbacks, which
are now the preferred back-ends for when a user operates on a char device
with read() and write() respectively.

Cc: Christian Brauner <brauner@kernel.org>
Co-developed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/fs.rs         |  3 +++
 rust/kernel/fs/kiocb.rs   | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/miscdevice.rs | 63 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 0121b38c59e63d01a89f22c8ef6983ef5c3234de..6ba6bdf143cb991c6e78215178eb585260215da0 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -6,3 +6,6 @@
 
 pub mod file;
 pub use self::file::{File, LocalFile};
+
+mod kiocb;
+pub use self::kiocb::Kiocb;
diff --git a/rust/kernel/fs/kiocb.rs b/rust/kernel/fs/kiocb.rs
new file mode 100644
index 0000000000000000000000000000000000000000..84c936cd69b0e9b490d54c87d8c7279b27d4476a
--- /dev/null
+++ b/rust/kernel/fs/kiocb.rs
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Kernel IO callbacks.
+//!
+//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
+
+use core::marker::PhantomData;
+use core::ptr::NonNull;
+use kernel::types::ForeignOwnable;
+
+/// Wrapper for the kernel's `struct kiocb`.
+///
+/// Currently this abstractions is incomplete and is essentially just a tuple containing a
+/// reference to a file and a file position.
+///
+/// The type `T` represents the filesystem or driver specific data associated with the file.
+///
+/// # Invariants
+///
+/// `inner` points at a valid `struct kiocb` whose file has the type `T` as its private data.
+pub struct Kiocb<'a, T> {
+    inner: NonNull<bindings::kiocb>,
+    _phantom: PhantomData<&'a T>,
+}
+
+impl<'a, T: ForeignOwnable> Kiocb<'a, T> {
+    /// Create a `Kiocb` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must reference a valid `struct kiocb` for the duration of `'a`. The private
+    /// data of the file must be `T`.
+    pub unsafe fn from_raw(kiocb: *mut bindings::kiocb) -> Self {
+        Self {
+            // SAFETY: If a pointer is valid it is not null.
+            inner: unsafe { NonNull::new_unchecked(kiocb) },
+            _phantom: PhantomData,
+        }
+    }
+
+    /// Access the underlying `struct kiocb` directly.
+    pub fn as_raw(&self) -> *mut bindings::kiocb {
+        self.inner.as_ptr()
+    }
+
+    /// Get the filesystem or driver specific data associated with the file.
+    pub fn file(&self) -> <T as ForeignOwnable>::Borrowed<'a> {
+        // SAFETY: We have shared access to this kiocb and hence the underlying file, so we can
+        // read the file's private data.
+        let private = unsafe { (*(*self.as_raw()).ki_filp).private_data };
+        // SAFETY: The kiocb has shared access to the private data.
+        unsafe { <T as ForeignOwnable>::borrow(private) }
+    }
+
+    /// Gets the current value of `ki_pos`.
+    pub fn ki_pos(&self) -> i64 {
+        // SAFETY: We have shared access to the kiocb, so we can read its `ki_pos` field.
+        unsafe { (*self.as_raw()).ki_pos }
+    }
+
+    /// Gets a mutable reference to the `ki_pos` field.
+    pub fn ki_pos_mut(&mut self) -> &mut i64 {
+        // SAFETY: We have exclusive access to the kiocb, so we can write to `ki_pos`.
+        unsafe { &mut (*self.as_raw()).ki_pos }
+    }
+}
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 6373fe183b2748162988b45d7ed8f563045d3b4d..35630fc638751c416d009fcf0c0ffdf0a4da1218 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -13,7 +13,8 @@
     device::Device,
     error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
     ffi::{c_int, c_long, c_uint, c_ulong},
-    fs::File,
+    fs::{File, Kiocb},
+    iov::{IovIterDest, IovIterSource},
     mm::virt::VmaNew,
     prelude::*,
     seq_file::SeqFile,
@@ -141,6 +142,16 @@ fn mmap(
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
+    /// Read from this miscdevice.
+    fn read_iter(_kiocb: Kiocb<'_, Self::Ptr>, _iov: &mut IovIterDest<'_>) -> Result<usize> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Write to this miscdevice.
+    fn write_iter(_kiocb: Kiocb<'_, Self::Ptr>, _iov: &mut IovIterSource<'_>) -> Result<usize> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Handler for ioctls.
     ///
     /// The `cmd` argument is usually manipulated using the utilities in [`kernel::ioctl`].
@@ -245,6 +256,46 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         0
     }
 
+    /// # Safety
+    ///
+    /// `kiocb` must be correspond to a valid file that is associated with a
+    /// `MiscDeviceRegistration<T>`. `iter` must be a valid `struct iov_iter` for writing.
+    unsafe extern "C" fn read_iter(
+        kiocb: *mut bindings::kiocb,
+        iter: *mut bindings::iov_iter,
+    ) -> isize {
+        // SAFETY: The caller provides a valid `struct kiocb` associated with a
+        // `MiscDeviceRegistration<T>` file.
+        let kiocb = unsafe { Kiocb::from_raw(kiocb) };
+        // SAFETY: This is a valid `struct iov_iter` for writing.
+        let iov = unsafe { IovIterDest::from_raw(iter) };
+
+        match T::read_iter(kiocb, iov) {
+            Ok(res) => res as isize,
+            Err(err) => err.to_errno() as isize,
+        }
+    }
+
+    /// # Safety
+    ///
+    /// `kiocb` must be correspond to a valid file that is associated with a
+    /// `MiscDeviceRegistration<T>`. `iter` must be a valid `struct iov_iter` for writing.
+    unsafe extern "C" fn write_iter(
+        kiocb: *mut bindings::kiocb,
+        iter: *mut bindings::iov_iter,
+    ) -> isize {
+        // SAFETY: The caller provides a valid `struct kiocb` associated with a
+        // `MiscDeviceRegistration<T>` file.
+        let kiocb = unsafe { Kiocb::from_raw(kiocb) };
+        // SAFETY: This is a valid `struct iov_iter` for reading.
+        let iov = unsafe { IovIterSource::from_raw(iter) };
+
+        match T::write_iter(kiocb, iov) {
+            Ok(res) => res as isize,
+            Err(err) => err.to_errno() as isize,
+        }
+    }
+
     /// # Safety
     ///
     /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
@@ -341,6 +392,16 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         open: Some(Self::open),
         release: Some(Self::release),
         mmap: if T::HAS_MMAP { Some(Self::mmap) } else { None },
+        read_iter: if T::HAS_READ_ITER {
+            Some(Self::read_iter)
+        } else {
+            None
+        },
+        write_iter: if T::HAS_WRITE_ITER {
+            Some(Self::write_iter)
+        } else {
+            None
+        },
         unlocked_ioctl: if T::HAS_IOCTL {
             Some(Self::ioctl)
         } else {

-- 
2.51.0.rc0.205.g4a044479a3-goog


