Return-Path: <linux-kernel+bounces-776623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C246B2CFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45315564D99
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCFC26F2A9;
	Tue, 19 Aug 2025 23:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eO4WyzMA"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A7258EE9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645165; cv=none; b=CvHBS9wyJqU22XM2agCcPCWBjVUSneIoP6jHui5447lfysVFdwx8XUgqM/SB3i3iJXTAIG0j9Wi1K4+6PslI5/I1ZrOEHk6nPTmIbWsiR7ZBy5qqMXl54X5VJJb3SxTgULo7fTJ30yHt4x2FkatEz3KfgFVX8AHb5xWW2wUGiu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645165; c=relaxed/simple;
	bh=/sQtIBYFoOnpF5rNBeNufGj8k1f/8wsUIbzjXDdvRH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W4OogKcmnBBZmeQuqS7Ai/uzABCXlMG3h+3/KBsmhHFg2Dua9jNaTccNj0lBZ0jaHajdHn71RUmKGAZqii/P4/cbb1gtp8fGI1aQtFUCDaxcnsRx09v2oaYkHB4a29CkX83b2tXkkF42OVLJD0CT9ikNwBlJ6XLATThYKs1YpUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eO4WyzMA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-324e318d628so62302a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645161; x=1756249961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYRu41w7P7laHNqkDjkFmEfy6zg8q08IlScnpwVSpE8=;
        b=eO4WyzMAWB7i5Xf8SGTwBo8mwGdG/ldrVqp/X5tqJe/zWqc55LVb1334zopivk5yCr
         9q8+cWdK+ObZbyjCRrhwaPxBcK6eCFhMQfhcmvJ0COo78vNeMf1/ns82SIv50167t0OU
         d7OFXf4gKJP/A/bKvLj22Hd2uiJntzBr9Emzfx84R2x8Jsi+e1+Ky80qgeRcPdUOwacz
         5+CGR8xGDC3Oah8I7GG2xV+1roGaof+ilyl//jTkI24K32VY4T5hEfBnVXfJPCW4gwhk
         JaRWe5PxGSqa72v/rncDQw47GJc0hwu3aM6Pp5c9ieRfKn4QZMS3mdthZIEUcQktSUGb
         MlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645161; x=1756249961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYRu41w7P7laHNqkDjkFmEfy6zg8q08IlScnpwVSpE8=;
        b=lr/qZICqL/j3vFLAn6XBD2LH5RdWq3sr/9Nl2kx19IH0TAt+MHjAw6rXnlkQplybQK
         Y/YBt9brsnjS5mwNQv+VqGltpfiiw9+BcIb7pUDUczvsqA6e/Alu0bRr8RfbUSHLng3c
         aY+LL+UdEbj6F11jxl1+F5Go4f8ELLmrlzAQQDkc+5R2k9fySzJYThBIrG8FCgJsKsuy
         HILP0sf8YrliNrRsi7PIDZi8mF5Qz2f7uMKA0y+3VjF5xcauc8jkXQdPySZMg5w4RSm8
         j9Si7mjANSFQLQfLgttN4EGNixPYzmxuK1fK9zfyBY0wj7LqZlq/ABh1tfWb5DTCl3TQ
         6ApQ==
X-Gm-Message-State: AOJu0Yxa8kTDGn8SERlQ8OrGjrZbAloUqLp+hJrsqey55h4BWzYvuMzq
	92IqYt70dVM3noyeggSr40ymjtlDQf4X8Iz0mbLkT+eQbGBqyPVAc7yV8XCpHjwe0VSTfE38X+0
	f3aHq1IUS4Q==
X-Google-Smtp-Source: AGHT+IH1pH191A63Rhbgyri0LWOTl9R3+yumdoXIlkp89Db8xkaKvpm7+k+4T2kqoW/nSRXKvxKrM/RTk/bE
X-Received: from pjx7.prod.google.com ([2002:a17:90b:5687:b0:311:ef56:7694])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5405:b0:312:e8ed:758
 with SMTP id 98e67ed59e1d1-324e12d6bffmr1005537a91.13.1755645161597; Tue, 19
 Aug 2025 16:12:41 -0700 (PDT)
Date: Tue, 19 Aug 2025 23:12:32 +0000
In-Reply-To: <20250819-qcom-socinfo-v1-0-e8d32cc81270@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-qcom-socinfo-v1-0-e8d32cc81270@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755645158; l=6997;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=/sQtIBYFoOnpF5rNBeNufGj8k1f/8wsUIbzjXDdvRH4=; b=KBVrJ6ZJZK5H5PxPRzqmcbVwzyAJFZliSRPMJb0XsfWslq30dvXv5hue0VyqxvXmgtqKhB8iY
 AEK0KdQs6uGBQyy9BH/Qm/dZI8q1zF7kOkHXyECwGNf9Utmj2U3QMMg
X-Mailer: b4 0.14.2
Message-ID: <20250819-qcom-socinfo-v1-1-e8d32cc81270@google.com>
Subject: [PATCH WIP 1/5] rust: Add soc_device support
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

Adds the ability to register SoC devices.

(This will be sent upstream in a separate request, it's uploaded now as
a dependency of the example driver.)

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/soc.rs              | 137 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2cbe890085dbb6a652623b38dd0eadeeaa127a94..e0ff2731f1c2ae4bb01d361e99c1f4517fbd45d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7481,6 +7481,7 @@ F:	rust/kernel/devres.rs
 F:	rust/kernel/driver.rs
 F:	rust/kernel/faux.rs
 F:	rust/kernel/platform.rs
+F:	rust/kernel/soc.rs
 F:	samples/rust/rust_debugfs.rs
 F:	samples/rust/rust_scoped_debugfs.rs
 F:	samples/rust/rust_driver_platform.rs
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e847820dc807fdda2d682d496a3c6361bb944c10..140e2f4e60c0b745ac5d5c7456d60af28e21f55a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -72,6 +72,7 @@
 #include <linux/sched.h>
 #include <linux/security.h>
 #include <linux/slab.h>
+#include <linux/sys_soc.h>
 #include <linux/tracepoint.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 828620c8441566a638f31d03633fc1bf4c1bda85..045f1088938cf646519edea2102439402fb27660 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -117,6 +117,8 @@
 pub mod security;
 pub mod seq_file;
 pub mod sizes;
+#[cfg(CONFIG_SOC_BUS)]
+pub mod soc;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/soc.rs b/rust/kernel/soc.rs
new file mode 100644
index 0000000000000000000000000000000000000000..b8412751a5ca8839e588cf5bd52f2e6a7f33d457
--- /dev/null
+++ b/rust/kernel/soc.rs
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! SoC Driver Abstraction
+//!
+//! C header: [`include/linux/sys_soc.h`](srctree/include/linux/sys_soc.h)
+
+use crate::bindings;
+use crate::error;
+use crate::prelude::*;
+use crate::str::CString;
+use core::marker::PhantomPinned;
+use core::ptr::addr_of;
+
+/// Attributes for a SoC device
+pub struct DeviceAttribute {
+    /// Machine
+    pub machine: Option<CString>,
+    /// Family
+    pub family: Option<CString>,
+    /// Revision
+    pub revision: Option<CString>,
+    /// Serial Number
+    pub serial_number: Option<CString>,
+    /// SoC ID
+    pub soc_id: Option<CString>,
+}
+
+// SAFETY: We provide no operations through `&BuiltDeviceAttribute`
+unsafe impl Sync for BuiltDeviceAttribute {}
+
+// SAFETY: All pointers are normal allocations, not thread-specific
+unsafe impl Send for BuiltDeviceAttribute {}
+
+#[pin_data]
+struct BuiltDeviceAttribute {
+    #[pin]
+    backing: DeviceAttribute,
+    inner: bindings::soc_device_attribute,
+    // Since `inner` has pointers to `backing`, we are !Unpin
+    #[pin]
+    _pin: PhantomPinned,
+}
+
+fn cstring_to_c(mcs: &Option<CString>) -> *const kernel::ffi::c_char {
+    mcs.as_ref()
+        .map(|cs| cs.as_char_ptr())
+        .unwrap_or(core::ptr::null())
+}
+
+impl BuiltDeviceAttribute {
+    fn as_mut_ptr(&self) -> *mut bindings::soc_device_attribute {
+        core::ptr::from_ref(&self.inner).cast_mut()
+    }
+}
+
+impl DeviceAttribute {
+    fn build(self) -> impl PinInit<BuiltDeviceAttribute> {
+        pin_init!(BuiltDeviceAttribute {
+            inner: bindings::soc_device_attribute {
+                machine: cstring_to_c(&self.machine),
+                family: cstring_to_c(&self.family),
+                revision: cstring_to_c(&self.revision),
+                serial_number: cstring_to_c(&self.serial_number),
+                soc_id: cstring_to_c(&self.soc_id),
+                data: core::ptr::null(),
+                custom_attr_group: core::ptr::null(),
+            },
+            backing: self,
+            _pin: PhantomPinned,
+        })
+    }
+}
+
+// SAFETY: We provide no operations through &Device
+unsafe impl Sync for Device {}
+
+// SAFETY: Device holds a pointer to a `soc_device`, which may be sent to any thread.
+unsafe impl Send for Device {}
+
+/// A registered soc device
+#[repr(transparent)]
+pub struct Device(*mut bindings::soc_device);
+
+impl Device {
+    /// # Safety
+    /// * `attr` must be pinned
+    /// * `attr` must be valid for reads during the function call
+    /// * If a device is returned (e.g. no error), `attr` must remain valid for reads until the
+    ///   returned `Device` is dropped.
+    unsafe fn register(attr: *const BuiltDeviceAttribute) -> Result<Device> {
+        let raw_soc =
+            // SAFETY: The struct provided through attr is backed by pinned data next to it, so as
+            // long as attr lives, the strings pointed to by the struct will too. By caller
+            // invariant, `attr` is pinned, so the pinned data won't move. By caller invariant,
+            // `attr` is valid during this call. If it returns a device, and so others may try to
+            // read this data, by caller invariant, `attr` won't be released until the device is.
+            error::from_err_ptr(unsafe { bindings::soc_device_register((*attr).as_mut_ptr()) })?;
+        Ok(Device(raw_soc))
+    }
+}
+
+#[pin_data(PinnedDrop)]
+/// Registration handle for your soc_dev. If you let it go out of scope, your soc_dev will be
+/// unregistered.
+pub struct DeviceRegistration {
+    #[pin]
+    attr: BuiltDeviceAttribute,
+    soc_dev: Device,
+    // Since Device transitively points to the contents of attr, we are !Unpin
+    #[pin]
+    _pin: PhantomPinned,
+}
+
+#[pinned_drop]
+impl PinnedDrop for DeviceRegistration {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: Device always contains a live pointer to a soc_device that can be unregistered
+        unsafe { bindings::soc_device_unregister(self.soc_dev.0) }
+    }
+}
+
+impl DeviceRegistration {
+    /// Register a new SoC device
+    pub fn register(attr: DeviceAttribute) -> impl PinInit<Self, Error> {
+        try_pin_init!(&this in Self {
+                    attr <- attr.build(),
+                    // SAFETY: We have already initialized attr, and we are inside PinInit and Self
+                    // is !Unpin, so attr won't be moved and is valid. If it returns success, attr
+                    // will not be dropped until after our `PinnedDrop` implementation runs, so the
+                    // device will be unregistered first.
+                    soc_dev: unsafe { Device::register(addr_of!((*this.as_ptr()).attr))? },
+                    _pin: PhantomPinned,
+        }? Error)
+    }
+}

-- 
2.51.0.rc1.167.g924127e9c0-goog


