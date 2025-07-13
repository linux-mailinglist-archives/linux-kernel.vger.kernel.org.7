Return-Path: <linux-kernel+bounces-729197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4703B03315
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 23:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E518A7AD3CE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 21:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E312A1F4634;
	Sun, 13 Jul 2025 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrYBltIU"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF41273F9;
	Sun, 13 Jul 2025 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752442612; cv=none; b=u+QuiLJT4Y48JesNEcW7selG4LwELn/RoJMdqvrityZ8UBx1KhZ27fz7wieovxth9FamUSE9yOaY4CHv7B5joZcRc2KyAyRZuethxzrFljG+4VZjhHjIKy7a/pQ7VlNHCBLBhF1DgdBSsqeTXmwpfDDC/P07Ebc6Dhc7lPgwhYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752442612; c=relaxed/simple;
	bh=r9UgCSXv2IzeyxHIrw+JzbtlcKJBP9bQbJT7QAjBbO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRDpeoExfITAKr6G324wJ/S1U0nDm3S1AG6pZPigGbRC5nYhujAs7OR6WDBvF7RixZwRAPS6p9vUffHzhNXuFMRbGgrVMJ5Y6lXlnRHZKb0VWZ+BHjl0OVitzSaXoAoghhl7OpWcBu1Xrz7l6oGPAuwPFZnU26itHFbXl4CRzbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrYBltIU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so978552a12.2;
        Sun, 13 Jul 2025 14:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752442610; x=1753047410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgSnZanbplY8mXao/iMhdmKlXlQlKDtXtoxDc3shZME=;
        b=IrYBltIUG4zXECUIQQ0x+mO9j56RNbTrsPOb9w4eR+IQaVWqIRW16WJT7Lmu8jJ/T1
         PjRT56l7PxgLyUTJe+Y1JaIR6uxsdCedf48baxWrnX1dCJyMbJ3Lo9aAXAHnEO7EZbIg
         fO01pGZdPSBXIkncS+CZPnSRwZoilc2MkOb+m9e7L9NP6yN1V/XOG0+X0c/Sg5iDMmjI
         Jywt58+59rBxGvbxXHnkuF6BrJ3xxV+t/o6/0Xu6BaCyDeUej43nsMJ8Fay/COjriQfY
         50yHYCYk6Y9QlqmELvPp6L387tjetExgBYa5A7TjiNJcUV6spKIy8W/W7GNT0hZHLpnN
         FPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752442610; x=1753047410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgSnZanbplY8mXao/iMhdmKlXlQlKDtXtoxDc3shZME=;
        b=RypCMu4Lqbr9rOpg44Hnp9cNLlOEeEsuHRUlKoffD+QmN5r3UK3cfnGZKtSQ/xESxc
         GnFOFMO+jQJYXwfgFgLWk+SDo5ZRqNsqRU3DhkK0o3Fjz7PWFPnCehhrK6BUTHlsBaXS
         FG9C96PBXThugORlp1lSeftq/RmcN5zFU/msTkic0eypKt26Ns004C1EMcJiu9F2xiui
         jU6GuqlvARXOgH4S7veN8JOl9Pb+2NSawwvj//kK5rG3GvvgNmDzONiFTQJtyqekxfDx
         FkfusULK6kwJaxwzwrhn/CFsjZyb/dOVwwcq7OTLdTJvYbatNa8Ys8c54SYdf894VYvR
         pWww==
X-Forwarded-Encrypted: i=1; AJvYcCWAmkncNJOLRLkQwYSvk83631J8BW6fsH5ceiEtVDJqdkmwK5q1XUEQNUHAKhZaZoCQNKcGe3rtMhpPz3HY4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz20RCc+ujnQsmHb1rDc842jEYd1Gr1BPa69vL8uOg3kFUEgWVP
	PBwSd6BnC0+duW/t8rOaNKR/89n6MTKWQ5fxDCJzI7xVqWlVby1VupeGVI4VudLx
X-Gm-Gg: ASbGncsxzRQ9vxwR0L7waMULLe10IAP+ExNYYQWa+y7IwAveiPIt4YhXunkw9BS2211
	QRNeU46V9EAB9FjJmCHmMKBj60KfQhTM08Uwuh5YwKqjGmNdYBxnq2+ttOfdANPgA8lfOBXwYLS
	ukZo0si7Ogaewx/WJi5X9HtQ77l/HHlQ98u8uxaICuL+esaDtECfgyQ178d3EY5caJC9Ojy1xP9
	AUfp5+5X0ntMwjrGvhEEwRwuNXbWwwiKPNxBja3uvg6ZRnwWKpZK9djZ/0PWMZ5DZwaxuM5eii2
	RKUi2rOeNVuq4MqFm/4MIazE7NuMDGybdoDNnJKMlOYQEc3ubl70vZxRI6uOifRgnXmuIokcpGK
	n0LYxk+BeSYtAaeRJupqWAcLY2Vh827GxD/dDKDs=
X-Google-Smtp-Source: AGHT+IEGve25vW4ySkRIXR7qclVSNpLLDv9sppUVLfRMsEYfCCJD11zHHUgqLWTHW/j69+jqLc0Eaw==
X-Received: by 2002:a17:90b:33c3:b0:313:2768:3f6b with SMTP id 98e67ed59e1d1-31c50e2d069mr15578763a91.27.1752442609571;
        Sun, 13 Jul 2025 14:36:49 -0700 (PDT)
Received: from shankari-IdeaPad.. ([49.128.169.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322e7fsm86308575ad.93.2025.07.13.14.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 14:36:49 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH v3 2/2] rust: update ARef and AlwaysRefCounted call sites to import from sync::aref
Date: Mon, 14 Jul 2025 03:06:14 +0530
Message-Id: <20250713213614.188921-2-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250713213614.188921-1-shankari.ak0208@gmail.com>
References: <20250713213614.188921-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites to import ARef and AlwaysRefCounted directly 
from sync::aref instead of indirectly via types.
Remove the re-export of their definitions in types.rs.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
v2 -> v3: solved the styling error triggered by the kernel bot.
---
 drivers/block/rnull.rs               |  3 +--
 drivers/gpu/drm/nova/driver.rs       |  4 +++-
 drivers/gpu/drm/nova/gem.rs          |  2 +-
 rust/kernel/auxiliary.rs             |  2 +-
 rust/kernel/block/mq.rs              |  8 ++++----
 rust/kernel/block/mq/operations.rs   |  2 +-
 rust/kernel/block/mq/request.rs      |  3 ++-
 rust/kernel/cred.rs                  |  6 +-----
 rust/kernel/device.rs                | 10 +++-------
 rust/kernel/devres.rs                |  3 +--
 rust/kernel/dma.rs                   |  2 +-
 rust/kernel/drm/device.rs            |  3 ++-
 rust/kernel/drm/driver.rs            |  2 +-
 rust/kernel/drm/gem/mod.rs           |  3 ++-
 rust/kernel/fs/file.rs               |  3 ++-
 rust/kernel/mm.rs                    |  3 ++-
 rust/kernel/mm/mmput_async.rs        |  2 +-
 rust/kernel/opp.rs                   | 13 +++++++------
 rust/kernel/pci.rs                   |  5 +++--
 rust/kernel/pid_namespace.rs         |  5 +----
 rust/kernel/platform.rs              |  2 +-
 rust/kernel/task.rs                  |  7 ++++---
 rust/kernel/types.rs                 |  2 --
 samples/rust/rust_dma.rs             |  2 +-
 samples/rust/rust_driver_pci.rs      |  2 +-
 samples/rust/rust_driver_platform.rs |  2 +-
 samples/rust/rust_misc_device.rs     |  3 +--
 27 files changed, 49 insertions(+), 55 deletions(-)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index d07e76ae2c13..80a0f7aa949e 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -20,8 +20,7 @@
     error::Result,
     new_mutex, pr_info,
     prelude::*,
-    sync::{Arc, Mutex},
-    types::ARef,
+    sync::{aref::ARef, Arc, Mutex},
 };
 
 module! {
diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index b28b2e05cc15..91b7380f83ab 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{auxiliary, c_str, device::Core, drm, drm::gem, drm::ioctl, prelude::*, types::ARef};
+use kernel::{
+    auxiliary, c_str, device::Core, drm, drm::gem, drm::ioctl, prelude::*, sync::aref::ARef,
+};
 
 use crate::file::File;
 use crate::gem::NovaObject;
diff --git a/drivers/gpu/drm/nova/gem.rs b/drivers/gpu/drm/nova/gem.rs
index 33b62d21400c..cd82773dab92 100644
--- a/drivers/gpu/drm/nova/gem.rs
+++ b/drivers/gpu/drm/nova/gem.rs
@@ -4,7 +4,7 @@
     drm,
     drm::{gem, gem::BaseObject},
     prelude::*,
-    types::ARef,
+    sync::aref::ARef,
 };
 
 use crate::{
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index d2cfe1eeefb6..776c63387832 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -250,7 +250,7 @@ extern "C" fn release(dev: *mut bindings::device) {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 831445d37181..3e7e0de92604 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -20,7 +20,7 @@
 //! The kernel will interface with the block device driver by calling the method
 //! implementations of the `Operations` trait.
 //!
-//! IO requests are passed to the driver as [`kernel::types::ARef<Request>`]
+//! IO requests are passed to the driver as [`kernel::sync::aref::ARef<Request>`]
 //! instances. The `Request` type is a wrapper around the C `struct request`.
 //! The driver must mark end of processing by calling one of the
 //! `Request::end`, methods. Failure to do so can lead to deadlock or timeout
@@ -57,12 +57,12 @@
 //!
 //! ```rust
 //! use kernel::{
 //!     alloc::flags,
 //!     block::mq::*,
 //!     new_mutex,
 //!     prelude::*,
-//!     sync::{Arc, Mutex},
-//!     types::{ARef, ForeignOwnable},
+//!     sync::{aref::ARef, Arc, Mutex},
+//!     types::ForeignOwnable,
 //! };
 //!
 //! struct MyBlkDevice;
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index c2b98f507bcb..18d858763e08 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -10,7 +10,7 @@
     block::mq::Request,
     error::{from_result, Result},
     prelude::*,
-    types::ARef,
+    sync::aref::ARef,
 };
 use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
 
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index fefd394f064a..9cca7852b309 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -8,7 +8,8 @@
     bindings,
     block::mq::Operations,
     error::Result,
-    types::{ARef, AlwaysRefCounted, Opaque},
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::Opaque,
 };
 use core::{
     marker::PhantomData,
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index 2599f01e8b28..4a2229542fb7 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -8,11 +8,7 @@
 //!
 //! Reference: <https://www.kernel.org/doc/html/latest/security/credentials.html>
 
-use crate::{
-    bindings,
-    task::Kuid,
-    types::{AlwaysRefCounted, Opaque},
-};
+use crate::{bindings, sync::aref::AlwaysRefCounted, task::Kuid, types::Opaque};
 
 /// Wraps the kernel's `struct cred`.
 ///
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 5c946af3a4d5..8b965b82163c 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -4,11 +4,7 @@
 //!
 //! C header: [`include/linux/device.h`](srctree/include/linux/device.h)
 
-use crate::{
-    bindings,
-    str::CStr,
-    types::{ARef, Opaque},
-};
+use crate::{bindings, str::CStr, sync::aref::ARef, types::Opaque};
 use core::{fmt, marker::PhantomData, ptr};
 
 #[cfg(CONFIG_PRINTK)]
@@ -216,7 +212,7 @@ pub fn property_present(&self, name: &CStr) -> bool {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_raw()) };
@@ -322,7 +318,7 @@ macro_rules! impl_device_context_deref {
 #[macro_export]
 macro_rules! __impl_device_context_into_aref {
     ($src:ty, $device:tt) => {
-        impl ::core::convert::From<&$device<$src>> for $crate::types::ARef<$device> {
+        impl ::core::convert::From<&$device<$src>> for $crate::sync::aref::ARef<$device> {
             fn from(dev: &$device<$src>) -> Self {
                 (&**dev).into()
             }
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index d0e6c6e162c2..7a1e2f2721b8 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -13,8 +13,7 @@
     ffi::c_void,
     prelude::*,
     revocable::{Revocable, RevocableGuard},
-    sync::{rcu, Arc, Completion},
-    types::ARef,
+    sync::{aref::ARef, rcu, Arc, Completion},
 };
 
 #[pin_data]
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 8e317005decd..7e6407655969 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -9,8 +9,8 @@
     device::{Bound, Device},
     error::code::*,
     error::Result,
+    sync::aref::ARef,
     transmute::{AsBytes, FromBytes},
-    types::ARef,
 };
 
 /// Possible attributes associated with a DMA mapping.
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index b7ee3c464a12..d8f0be5fdce7 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -10,7 +10,8 @@
     error::from_err_ptr,
     error::Result,
     prelude::*,
-    types::{ARef, AlwaysRefCounted, Opaque},
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::Opaque,
 };
 use core::{mem, ops::Deref, ptr, ptr::NonNull};
 
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index acb638086131..9f3450f77ca0 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -11,7 +11,7 @@
     error::{to_result, Result},
     prelude::*,
     str::CStr,
-    types::ARef,
+    sync::aref::ARef,
 };
 use macros::vtable;
 
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 4cd69fa84318..d2c28397f810 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -10,7 +10,8 @@
     drm::driver::{AllocImpl, AllocOps},
     error::{to_result, Result},
     prelude::*,
-    types::{ARef, AlwaysRefCounted, Opaque},
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::Opaque,
 };
 use core::{mem, ops::Deref, ptr::NonNull};
 
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 35fd5db35c46..18cf579d3312 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -11,7 +11,8 @@
     bindings,
     cred::Credential,
     error::{code::*, Error, Result},
-    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::{NotThreadSafe, Opaque},
 };
 use core::ptr;
 
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 43f525c0d16c..4764d7b68f2a 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -13,7 +13,8 @@
 
 use crate::{
     bindings,
-    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::{NotThreadSafe, Opaque},
 };
 use core::{ops::Deref, ptr::NonNull};
 
diff --git a/rust/kernel/mm/mmput_async.rs b/rust/kernel/mm/mmput_async.rs
index 9289e05f7a67..b8d2f051225c 100644
--- a/rust/kernel/mm/mmput_async.rs
+++ b/rust/kernel/mm/mmput_async.rs
@@ -10,7 +10,7 @@
 use crate::{
     bindings,
     mm::MmWithUser,
-    types::{ARef, AlwaysRefCounted},
+    sync::aref::{ARef, AlwaysRefCounted},
 };
 use core::{ops::Deref, ptr::NonNull};
 
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 0e94cb2703ec..de1fea9964f3 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -16,7 +16,8 @@
     ffi::c_ulong,
     prelude::*,
     str::CString,
-    types::{ARef, AlwaysRefCounted, Opaque},
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::Opaque,
 };
 
 #[cfg(CONFIG_CPU_FREQ)]
@@ -162,7 +163,7 @@ fn from(power: MicroWatt) -> Self {
 /// use kernel::device::Device;
 /// use kernel::error::Result;
 /// use kernel::opp::{Data, MicroVolt, Token};
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 ///
 /// fn create_opp(dev: &ARef<Device>, freq: Hertz, volt: MicroVolt, level: u32) -> Result<Token> {
 ///     let data = Data::new(freq, volt, level, false);
@@ -211,7 +212,7 @@ fn drop(&mut self) {
 /// use kernel::device::Device;
 /// use kernel::error::Result;
 /// use kernel::opp::{Data, MicroVolt, Token};
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 ///
 /// fn create_opp(dev: &ARef<Device>, freq: Hertz, volt: MicroVolt, level: u32) -> Result<Token> {
 ///     let data = Data::new(freq, volt, level, false);
@@ -262,7 +263,7 @@ fn freq(&self) -> Hertz {
 /// use kernel::clk::Hertz;
 /// use kernel::error::Result;
 /// use kernel::opp::{OPP, SearchType, Table};
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 ///
 /// fn find_opp(table: &Table, freq: Hertz) -> Result<ARef<OPP>> {
 ///     let opp = table.opp_from_freq(freq, Some(true), None, SearchType::Exact)?;
@@ -335,7 +336,7 @@ fn drop(&mut self) {
 /// use kernel::error::Result;
 /// use kernel::opp::{Config, ConfigOps, ConfigToken};
 /// use kernel::str::CString;
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 /// use kernel::macros::vtable;
 ///
 /// #[derive(Default)]
@@ -581,7 +582,7 @@ extern "C" fn config_regulators(
 /// use kernel::device::Device;
 /// use kernel::error::Result;
 /// use kernel::opp::Table;
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 ///
 /// fn get_table(dev: &ARef<Device>, mask: &mut Cpumask, freq: Hertz) -> Result<Table> {
 ///     let mut opp_table = Table::from_of_cpumask(dev, mask)?;
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 6b94fd7a3ce9..c7d95459e745 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -14,7 +14,8 @@
     io::Io,
     io::IoRaw,
     str::CStr,
-    types::{ARef, ForeignOwnable, Opaque},
+    sync::aref::ARef,
+    types::{ForeignOwnable, Opaque},
     ThisModule,
 };
 use core::{
@@ -438,7 +439,7 @@ pub fn set_master(&self) {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::pci_dev_get(self.as_raw()) };
diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
index 0e93808e4639..979a9718f153 100644
--- a/rust/kernel/pid_namespace.rs
+++ b/rust/kernel/pid_namespace.rs
@@ -7,10 +7,7 @@
 //! C header: [`include/linux/pid_namespace.h`](srctree/include/linux/pid_namespace.h) and
 //! [`include/linux/pid.h`](srctree/include/linux/pid.h)
 
-use crate::{
-    bindings,
-    types::{AlwaysRefCounted, Opaque},
-};
+use crate::{bindings, sync::aref::AlwaysRefCounted, types::Opaque};
 use core::ptr;
 
 /// Wraps the kernel's `struct pid_namespace`. Thread safe.
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 0a6a6be732b2..9c9807b7da54 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -198,7 +198,7 @@ fn as_raw(&self) -> *mut bindings::platform_device {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 927413d85484..b46488f6d1a8 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -9,7 +9,8 @@
     ffi::{c_int, c_long, c_uint},
     mm::MmWithUser,
     pid_namespace::PidNamespace,
-    types::{ARef, NotThreadSafe, Opaque},
+    sync::aref::ARef,
+    types::{NotThreadSafe, Opaque},
 };
 use core::{
     cmp::{Eq, PartialEq},
@@ -76,7 +77,7 @@ macro_rules! current {
 /// incremented when creating `State` and decremented when it is dropped:
 ///
 /// ```
-/// use kernel::{task::Task, types::ARef};
+/// use kernel::{task::Task, sync::aref::ARef};
 ///
 /// struct State {
 ///     creator: ARef<Task>,
@@ -340,7 +341,7 @@ pub fn active_pid_ns(&self) -> Option<&PidNamespace> {
 }
 
 // SAFETY: The type invariants guarantee that `Task` is always refcounted.
-unsafe impl crate::types::AlwaysRefCounted for Task {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Task {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
         unsafe { bindings::get_task_struct(self.as_ptr()) };
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 60cb48285630..fccb3ee71345 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -10,8 +10,6 @@
 };
 use pin_init::{PinInit, Zeroable};
 
-pub use crate::sync::aref::{ARef, AlwaysRefCounted};
-
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///
 /// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 874c2c964afa..4aa3ecb7e999 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, device::Core, dma::CoherentAllocation, pci, prelude::*, types::ARef};
+use kernel::{bindings, device::Core, dma::CoherentAllocation, pci, prelude::*, sync::aref::ARef};
 
 struct DmaSampleDriver {
     pdev: ARef<pci::Device>,
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 15147e4401b2..adcdfbb57c6b 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
+use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, sync::aref::ARef};
 
 struct Regs;
 
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 8b42b3cfb363..da7d0f3ae90d 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -2,7 +2,7 @@
 
 //! Rust Platform driver sample.
 
-use kernel::{c_str, device::Core, of, platform, prelude::*, types::ARef};
+use kernel::{c_str, device::Core, of, platform, prelude::*, sync::aref::ARef};
 
 struct SampleDriver {
     pdev: ARef<platform::Device>,
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index c881fd6dbd08..3f4954e3eb9c 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -105,8 +105,7 @@
     miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
     new_mutex,
     prelude::*,
-    sync::Mutex,
-    types::ARef,
+    sync::{aref::ARef, Mutex},
     uaccess::{UserSlice, UserSliceReader, UserSliceWriter},
 };
 
-- 
2.34.1


