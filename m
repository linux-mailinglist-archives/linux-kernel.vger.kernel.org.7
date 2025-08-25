Return-Path: <linux-kernel+bounces-785399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9A9B34A18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C574188BB11
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598BD305E29;
	Mon, 25 Aug 2025 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Ay44qVJ6"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C26730E0CC;
	Mon, 25 Aug 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145943; cv=pass; b=Mgezz49dJ107nv2tTtylcc1tkLqHCmlPmM04mjXUSsh0bJUSwt+5U/0Rq3Xbt8968aVc8JqKM18ZRApfQ+y8GuH+sZHJXd/qU2As+hQ1kF0TEFOG2FeQ+w9fvhpqZhqmw/4ZLeQSAESCPnu1Yz4fMQ+KcVHUHlPmSGE7GvnX0ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145943; c=relaxed/simple;
	bh=PQSR1VDhV/248F3Dp6TGNCQrmaMlBk1IQfLjXt9+uZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fEVb31e7vv9l0t3/1PZ2vPmQPsa6BvuxLx1W4Iwrc2zPrHwOGZi9Rasqm4EdfEDuk3F8oADMH0Uo4CvhgpzhDCSIUxYPEsPLW3PnicWtI1QpqtbTLbkAGbPx20/DoBt+as6eCGEKpVVAxYFlowOoKLND+xu2X90HiWkZ/L4x0tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Ay44qVJ6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756145924; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=buoeYFsz9mv82u9C7p7qlmVq6WNErE46JN3mzQVZEH7LiFOyQPbFWC6SNoxpzqL+Mm1bKCpt3hFczCj49NBYF0PHiY5aO4XfQJoCXPq5cQ3xA6u/CcdhBlB05pYIW+9OfDVk4mZSnSwnMFd9u/d4oxVU85pWFaVVhtL47PDXq/0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756145924; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T6L4ihPCixDhKjnZXjbU8G5ryDJI7vkOSrIjhoWFKW4=; 
	b=FIYCif4qI4A/Phm12h8PdV3fJf/xddh9giqDoC8EKqy3USgPep2RFYxbZoD9GDD78n+xOx5h287xu1YiSBofsFCDqSDYncl6c03ewEGw4P65tOrrxwLpbfaobYxBa2y8UFuJZFHmpZUXIlXewhoBKyK37/H0wAYyy9dI+OURYEA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756145924;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=T6L4ihPCixDhKjnZXjbU8G5ryDJI7vkOSrIjhoWFKW4=;
	b=Ay44qVJ6FDcZNo/mNTfWnPOHvgAvnE4Pve6IWrltnCvodDBVmPFcYEYEWD9Z4lIw
	wrCdQvP6LzMFwjGXSzwHCpYNlDHPWynZw0hy0SmSP0vL4aY5aTIoD+U/astLodt3VGf
	5qy00M9v0tB0HMZw/oqClsqz5qkRwtiYsphsN1R0=
Received: by mx.zohomail.com with SMTPS id 1756145921495307.7421950393119;
	Mon, 25 Aug 2025 11:18:41 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 25 Aug 2025 15:18:05 -0300
Subject: [PATCH 1/2] rust: usb: add basic USB abstractions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
In-Reply-To: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-usb@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

Add basic USB abstractions, consisting of usb::{Device, Interface,
Driver, Adapter, DeviceId} and the module_usb_driver macro. This is the
first step in being able to write USB device drivers, which paves the
way for USB media drivers - for example - among others.

This initial support will then be used by a subsequent sample driver,
which constitutes the only user of the USB abstractions so far.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/usb.c              |   8 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/usb.rs              | 457 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 469 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 69a975da829f0c35760f71a1b32b8fcb12c8a8dc..645afe578668097ae04455d9eefb102d1f1ce4af 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -73,6 +73,7 @@
 #include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/tracepoint.h>
+#include <linux/usb.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 44b2005d50140d34a44ae37d01c2ddbae6aeaa32..da1ee0d3705739e789c7ad21b957bbdb7ca23521 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -48,6 +48,7 @@
 #include "task.c"
 #include "time.c"
 #include "uaccess.c"
+#include "usb.c"
 #include "vmalloc.c"
 #include "wait.c"
 #include "workqueue.c"
diff --git a/rust/helpers/usb.c b/rust/helpers/usb.c
new file mode 100644
index 0000000000000000000000000000000000000000..fb2aad0cbf4d26ac7fb1a3f176ee7a1d30800f92
--- /dev/null
+++ b/rust/helpers/usb.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/usb.h>
+
+struct usb_device *rust_helper_interface_to_usbdev(struct usb_interface *intf)
+{
+	return interface_to_usbdev(intf);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f8db761c5c95fc66e4c55f539b17fca613161ada..b15277a02028aa1d27480d0630f9f599cacd6e4d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -127,6 +127,8 @@
 pub mod tracepoint;
 pub mod transmute;
 pub mod types;
+#[cfg(CONFIG_USB)]
+pub mod usb;
 pub mod uaccess;
 pub mod workqueue;
 pub mod xarray;
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
new file mode 100644
index 0000000000000000000000000000000000000000..8899e7520b58d4e4b08927d54c8912650b78da33
--- /dev/null
+++ b/rust/kernel/usb.rs
@@ -0,0 +1,457 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (C) 2025 Collabora Ltd.
+
+//! Abstractions for the USB bus.
+//!
+//! C header: [`include/linux/usb.h`](srctree/include/linux/usb.h)
+
+use crate::{
+    bindings, device,
+    device_id::{RawDeviceId, RawDeviceIdIndex},
+    driver,
+    error::{from_result, to_result, Result},
+    prelude::*,
+    str::CStr,
+    types::{AlwaysRefCounted, Opaque},
+    ThisModule,
+};
+use core::{marker::PhantomData, mem::MaybeUninit, ptr::NonNull};
+
+/// An adapter for the registration of USB drivers.
+pub struct Adapter<T: Driver>(T);
+
+// SAFETY: A call to `unregister` for a given instance of `RegType` is guaranteed to be valid if
+// a preceding call to `register` has been successful.
+unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+    type RegType = bindings::usb_driver;
+
+    unsafe fn register(
+        udrv: &Opaque<Self::RegType>,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        // SAFETY: It's safe to set the fields of `struct usb_driver` on initialization.
+        unsafe {
+            (*udrv.get()).name = name.as_char_ptr();
+            (*udrv.get()).probe = Some(Self::probe_callback);
+            (*udrv.get()).disconnect = Some(Self::disconnect_callback);
+            (*udrv.get()).id_table = T::ID_TABLE.as_ptr();
+        }
+
+        // SAFETY: `udrv` is guaranteed to be a valid `RegType`.
+        to_result(unsafe {
+            bindings::usb_register_driver(udrv.get(), module.0, name.as_char_ptr())
+        })
+    }
+
+    unsafe fn unregister(udrv: &Opaque<Self::RegType>) {
+        // SAFETY: `udrv` is guaranteed to be a valid `RegType`.
+        unsafe { bindings::usb_deregister(udrv.get()) };
+    }
+}
+
+impl<T: Driver + 'static> Adapter<T> {
+    extern "C" fn probe_callback(
+        intf: *mut bindings::usb_interface,
+        id: *const bindings::usb_device_id,
+    ) -> kernel::ffi::c_int {
+        // SAFETY: The USB core only ever calls the probe callback with a valid pointer to a
+        // `struct usb_interface` and `struct usb_device_id`.
+        //
+        // INVARIANT: `intf` is valid for the duration of `probe_callback()`.
+        let intf = unsafe { &*intf.cast::<Interface<device::CoreInternal>>() };
+
+        from_result(|| {
+            // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct usb_device_id` and
+            // does not add additional invariants, so it's safe to transmute.
+            let id = unsafe { &*id.cast::<DeviceId>() };
+
+            let info = T::ID_TABLE.info(id.index());
+            let data = T::probe(intf, id, info)?;
+
+            let dev: &device::Device<device::CoreInternal> = intf.as_ref();
+            dev.set_drvdata(data);
+            Ok(0)
+        })
+    }
+
+    extern "C" fn disconnect_callback(intf: *mut bindings::usb_interface) {
+        // SAFETY: The USB core only ever calls the disconnect callback with a valid pointer to a
+        // `struct usb_interface`.
+        //
+        // INVARIANT: `intf` is valid for the duration of `disconnect_callback()`.
+        let intf = unsafe { &*intf.cast::<Interface<device::CoreInternal>>() };
+
+        let dev: &device::Device<device::CoreInternal> = intf.as_ref();
+
+        // SAFETY: `disconnect_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T>>`.
+        let data = unsafe { dev.drvdata_obtain::<Pin<KBox<T>>>() };
+
+        T::disconnect(intf, data.as_ref());
+    }
+}
+
+/// Abstraction for the USB device ID structure, i.e. [`struct usb_device_id`].
+///
+/// [`struct usb_device_id`]: https://docs.kernel.org/driver-api/basics.html#c.usb_device_id
+#[repr(transparent)]
+#[derive(Clone, Copy)]
+pub struct DeviceId(bindings::usb_device_id);
+
+impl DeviceId {
+    /// Equivalent to C's `USB_DEVICE` macro.
+    pub const fn from_id(vendor: u16, product: u16) -> Self {
+        Self(bindings::usb_device_id {
+            match_flags: bindings::USB_DEVICE_ID_MATCH_DEVICE as u16,
+            idVendor: vendor,
+            idProduct: product,
+            // SAFETY: It is safe to use all zeroes for the other fields of `usb_device_id`.
+            ..unsafe { MaybeUninit::zeroed().assume_init() }
+        })
+    }
+
+    /// Equivalent to C's `USB_DEVICE_VER` macro.
+    pub const fn from_device_ver(vendor: u16, product: u16, bcd_lo: u16, bcd_hi: u16) -> Self {
+        Self(bindings::usb_device_id {
+            match_flags: bindings::USB_DEVICE_ID_MATCH_DEVICE_AND_VERSION as u16,
+            idVendor: vendor,
+            idProduct: product,
+            bcdDevice_lo: bcd_lo,
+            bcdDevice_hi: bcd_hi,
+            // SAFETY: It is safe to use all zeroes for the other fields of `usb_device_id`.
+            ..unsafe { MaybeUninit::zeroed().assume_init() }
+        })
+    }
+
+    /// Equivalent to C's `USB_DEVICE_INFO` macro.
+    pub const fn from_device_info(class: u8, subclass: u8, protocol: u8) -> Self {
+        Self(bindings::usb_device_id {
+            match_flags: bindings::USB_DEVICE_ID_MATCH_DEV_INFO as u16,
+            bDeviceClass: class,
+            bDeviceSubClass: subclass,
+            bDeviceProtocol: protocol,
+            // SAFETY: It is safe to use all zeroes for the other fields of `usb_device_id`.
+            ..unsafe { MaybeUninit::zeroed().assume_init() }
+        })
+    }
+
+    /// Equivalent to C's `USB_INTERFACE_INFO` macro.
+    pub const fn from_interface_info(class: u8, subclass: u8, protocol: u8) -> Self {
+        Self(bindings::usb_device_id {
+            match_flags: bindings::USB_DEVICE_ID_MATCH_INT_INFO as u16,
+            bInterfaceClass: class,
+            bInterfaceSubClass: subclass,
+            bInterfaceProtocol: protocol,
+            // SAFETY: It is safe to use all zeroes for the other fields of `usb_device_id`.
+            ..unsafe { MaybeUninit::zeroed().assume_init() }
+        })
+    }
+
+    /// Equivalent to C's `USB_DEVICE_INTERFACE_CLASS` macro.
+    pub const fn from_device_interface_class(vendor: u16, product: u16, class: u8) -> Self {
+        Self(bindings::usb_device_id {
+            match_flags: (bindings::USB_DEVICE_ID_MATCH_DEVICE
+                | bindings::USB_DEVICE_ID_MATCH_INT_CLASS) as u16,
+            idVendor: vendor,
+            idProduct: product,
+            bInterfaceClass: class,
+            // SAFETY: It is safe to use all zeroes for the other fields of `usb_device_id`.
+            ..unsafe { MaybeUninit::zeroed().assume_init() }
+        })
+    }
+
+    /// Equivalent to C's `USB_DEVICE_INTERFACE_PROTOCOL` macro.
+    pub const fn from_device_interface_protocol(vendor: u16, product: u16, protocol: u8) -> Self {
+        Self(bindings::usb_device_id {
+            match_flags: (bindings::USB_DEVICE_ID_MATCH_DEVICE
+                | bindings::USB_DEVICE_ID_MATCH_INT_PROTOCOL) as u16,
+            idVendor: vendor,
+            idProduct: product,
+            bInterfaceProtocol: protocol,
+            // SAFETY: It is safe to use all zeroes for the other fields of `usb_device_id`.
+            ..unsafe { MaybeUninit::zeroed().assume_init() }
+        })
+    }
+
+    /// Equivalent to C's `USB_DEVICE_INTERFACE_NUMBER` macro.
+    pub const fn from_device_interface_number(vendor: u16, product: u16, number: u8) -> Self {
+        Self(bindings::usb_device_id {
+            match_flags: (bindings::USB_DEVICE_ID_MATCH_DEVICE
+                | bindings::USB_DEVICE_ID_MATCH_INT_NUMBER) as u16,
+            idVendor: vendor,
+            idProduct: product,
+            bInterfaceNumber: number,
+            // SAFETY: It is safe to use all zeroes for the other fields of `usb_device_id`.
+            ..unsafe { MaybeUninit::zeroed().assume_init() }
+        })
+    }
+
+    /// Equivalent to C's `USB_DEVICE_AND_INTERFACE_INFO` macro.
+    pub const fn from_device_and_interface_info(
+        vendor: u16,
+        product: u16,
+        class: u8,
+        subclass: u8,
+        protocol: u8,
+    ) -> Self {
+        Self(bindings::usb_device_id {
+            match_flags: (bindings::USB_DEVICE_ID_MATCH_INT_INFO
+                | bindings::USB_DEVICE_ID_MATCH_DEVICE) as u16,
+            idVendor: vendor,
+            idProduct: product,
+            bInterfaceClass: class,
+            bInterfaceSubClass: subclass,
+            bInterfaceProtocol: protocol,
+            // SAFETY: It is safe to use all zeroes for the other fields of `usb_device_id`.
+            ..unsafe { MaybeUninit::zeroed().assume_init() }
+        })
+    }
+}
+
+// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `usb_device_id` and does not add
+// additional invariants, so it's safe to transmute to `RawType`.
+unsafe impl RawDeviceId for DeviceId {
+    type RawType = bindings::usb_device_id;
+}
+
+// SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_info` field.
+unsafe impl RawDeviceIdIndex for DeviceId {
+    const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::usb_device_id, driver_info);
+
+    fn index(&self) -> usize {
+        self.0.driver_info
+    }
+}
+
+/// [`IdTable`](kernel::device_id::IdTable) type for USB.
+pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
+
+/// Create a USB `IdTable` with its alias for modpost.
+#[macro_export]
+macro_rules! usb_device_table {
+    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
+        const $table_name: $crate::device_id::IdArray<
+            $crate::usb::DeviceId,
+            $id_info_type,
+            { $table_data.len() },
+        > = $crate::device_id::IdArray::new($table_data);
+
+        $crate::module_device_table!("usb", $module_table_name, $table_name);
+    };
+}
+
+/// The USB driver trait.
+///
+/// # Examples
+///
+///```
+/// # use kernel::{bindings, device::Core, usb};
+/// use kernel::prelude::*;
+///
+/// struct MyDriver;
+///
+/// kernel::usb_device_table!(
+///     USB_TABLE,
+///     MODULE_USB_TABLE,
+///     <MyDriver as usb::Driver>::IdInfo,
+///     [
+///         (usb::DeviceId::from_id(0x1234, 0x5678), ()),
+///         (usb::DeviceId::from_id(0xabcd, 0xef01), ()),
+///     ]
+/// );
+///
+/// impl usb::Driver for MyDriver {
+///     type IdInfo = ();
+///     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
+///
+///     fn probe(
+///         _interface: &usb::Interface<Core>,
+///         _id: &usb::DeviceId,
+///         _info: &Self::IdInfo,
+///     ) -> Result<Pin<KBox<Self>>> {
+///         Err(ENODEV)
+///     }
+///
+///     fn disconnect(_interface: &usb::Interface<Core>, _data: Pin<&Self>) {}
+/// }
+///```
+pub trait Driver {
+    /// The type holding information about each one of the device ids supported by the driver.
+    type IdInfo: 'static;
+
+    /// The table of device ids supported by the driver.
+    const ID_TABLE: IdTable<Self::IdInfo>;
+
+    /// USB driver probe.
+    ///
+    /// Called when a new USB interface is bound to this driver.
+    /// Implementers should attempt to initialize the interface here.
+    fn probe(
+        interface: &Interface<device::Core>,
+        id: &DeviceId,
+        id_info: &Self::IdInfo,
+    ) -> Result<Pin<KBox<Self>>>;
+
+    /// USB driver disconnect.
+    ///
+    /// Called when the USB interface is about to be unbound from this driver.
+    fn disconnect(interface: &Interface<device::Core>, data: Pin<&Self>);
+}
+
+/// A USB interface.
+///
+/// This structure represents the Rust abstraction for a C [`struct usb_interface`].
+/// The implementation abstracts the usage of a C [`struct usb_interface`] passed
+/// in from the C side.
+///
+/// # Invariants
+///
+/// An [`Interface`] instance represents a valid [`struct usb_interface`] created
+/// by the C portion of the kernel.
+///
+/// [`struct usb_interface`]: https://www.kernel.org/doc/html/latest/driver-api/usb/usb.html#c.usb_interface
+#[repr(transparent)]
+pub struct Interface<Ctx: device::DeviceContext = device::Normal>(
+    Opaque<bindings::usb_interface>,
+    PhantomData<Ctx>,
+);
+
+impl<Ctx: device::DeviceContext> Interface<Ctx> {
+    fn as_raw(&self) -> *mut bindings::usb_interface {
+        self.0.get()
+    }
+}
+
+// SAFETY: `Interface` is a transparent wrapper of a type that doesn't depend on
+// `Interface`'s generic argument.
+kernel::impl_device_context_deref!(unsafe { Interface });
+kernel::impl_device_context_into_aref!(Interface);
+
+impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Interface<Ctx> {
+    fn as_ref(&self) -> &device::Device<Ctx> {
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct usb_interface`.
+        let dev = unsafe { &raw mut ((*self.as_raw()).dev) };
+
+        // SAFETY: `dev` points to a valid `struct device`.
+        unsafe { device::Device::from_raw(dev) }
+    }
+}
+
+impl<Ctx: device::DeviceContext> AsRef<Device<Ctx>> for Interface<Ctx> {
+    fn as_ref(&self) -> &Device<Ctx> {
+        // SAFETY: `self.as_raw()` is valid by the type invariants. For a valid interface,
+        // the helper should always return a valid USB device pointer.
+        let usb_dev = unsafe { bindings::interface_to_usbdev(self.as_raw()) };
+
+        // SAFETY: The helper returns a valid interface pointer that shares the
+        // same `DeviceContext`.
+        unsafe { &*(usb_dev.cast()) }
+    }
+}
+
+// SAFETY: Instances of `Interface` are always reference-counted.
+unsafe impl AlwaysRefCounted for Interface {
+    fn inc_ref(&self) {
+        // SAFETY: The invariants of `Interface` guarantee that `self.as_raw()`
+        // returns a valid `struct usb_interface` pointer, for which we will
+        // acquire a new refcount.
+        unsafe { bindings::usb_get_intf(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::usb_put_intf(obj.cast().as_ptr()) }
+    }
+}
+
+// SAFETY: A `Interface` is always reference-counted and can be released from any thread.
+unsafe impl Send for Interface {}
+
+// SAFETY: It is safe to send a &Interface to another thread because we do not
+// allow any mutation through a shared reference.
+unsafe impl Sync for Interface {}
+
+/// A USB device.
+///
+/// This structure represents the Rust abstraction for a C [`struct usb_device`].
+/// The implementation abstracts the usage of a C [`struct usb_device`] passed in
+/// from the C side.
+///
+/// # Invariants
+///
+/// A [`Device`] instance represents a valid [`struct usb_device`] created by the C portion of the
+/// kernel.
+///
+/// [`struct usb_device`]: https://www.kernel.org/doc/html/latest/driver-api/usb/usb.html#c.usb_device
+#[repr(transparent)]
+pub struct Device<Ctx: device::DeviceContext = device::Normal>(
+    Opaque<bindings::usb_device>,
+    PhantomData<Ctx>,
+);
+
+impl<Ctx: device::DeviceContext> Device<Ctx> {
+    fn as_raw(&self) -> *mut bindings::usb_device {
+        self.0.get()
+    }
+}
+
+// SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
+// argument.
+kernel::impl_device_context_deref!(unsafe { Device });
+kernel::impl_device_context_into_aref!(Device);
+
+// SAFETY: Instances of `Device` are always reference-counted.
+unsafe impl AlwaysRefCounted for Device {
+    fn inc_ref(&self) {
+        // SAFETY: The invariants of `Device` guarantee that `self.as_raw()`
+        // returns a valid `struct usb_device` pointer, for which we will
+        // acquire a new refcount.
+        unsafe { bindings::usb_get_dev(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::usb_put_dev(obj.cast().as_ptr()) }
+    }
+}
+
+impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
+    fn as_ref(&self) -> &device::Device<Ctx> {
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct usb_device`.
+        let dev = unsafe { &raw mut ((*self.as_raw()).dev) };
+
+        // SAFETY: `dev` points to a valid `struct device`.
+        unsafe { device::Device::from_raw(dev) }
+    }
+}
+
+// SAFETY: A `Device` is always reference-counted and can be released from any thread.
+unsafe impl Send for Device {}
+
+// SAFETY: It is safe to send a &Device to another thread because we do not
+// allow any mutation through a shared reference.
+unsafe impl Sync for Device {}
+
+/// Declares a kernel module that exposes a single USB driver.
+///
+/// # Examples
+///
+/// ```ignore
+/// module_usb_driver! {
+///     type: MyDriver,
+///     name: "Module name",
+///     author: ["Author name"],
+///     description: "Description",
+///     license: "GPL v2",
+/// }
+/// ```
+#[macro_export]
+macro_rules! module_usb_driver {
+    ($($f:tt)*) => {
+        $crate::module_driver!(<T>, $crate::usb::Adapter<T>, { $($f)* });
+    }
+}

-- 
2.50.1


