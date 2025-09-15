Return-Path: <linux-kernel+bounces-816874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D881FB579C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF06C4E1F13
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B9D302CD8;
	Mon, 15 Sep 2025 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2WCnXf2"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C43019BA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937779; cv=none; b=VSBhX4s/4chQbV+/c6XlZ5L8ljG9RH9tsumK/vO7feM4Klqn34f3o3y8rAiLFcBWGb95rGOkXBugKbukrGXbhGRo1JPMspxtn4V2JDmU3EcuZvbg97Ndz1RSbY7fbBKYxZjc2aLEo/dWoujWFEymXI8MpSgnJYPxHovVnjnHGVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937779; c=relaxed/simple;
	bh=sFJVLZ2KZ0Hcz5cJHFJSDExMCeJ3YzptQttWezMDcKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMRkYgNXC8lmHSKh50NH9DGc3GlsZDZmU5nYyC2ySv0FNlrjf7/M1Zrs+XW+b5m2HogUuedXk02rdP++NhQ9g6RbX97pY7r5WA9/t5DpzcXhrxrdkj8NPwa/X5VRF5RES6WSa3fc+E6c0pEVbQqueeIUiowq68cGiMP/oTR2DxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2WCnXf2; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4d4881897cso2635920a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757937776; x=1758542576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rkXTp59y9C0MEqVnEurpqF7SQ6VGFRiSZtPfZgLQH78=;
        b=K2WCnXf26Fma2ItmcNKbCk9+SfaVs/otvIt/CpCED6/kbhBnVxiiJBJ9YM9J6lYLGf
         3V68wpoHuSyw/ibcfW0LMkF/dYk4l20Kr5bnpD8RN8K9Y8tJYlCFrnU73CpuObImNYEw
         XUokdzRXwBnFtqzh3mv9aXocaeZbQZq8WyeLdZw+rtHq6RNOspTxrgfZFnbqXuHZ2+Rx
         TeUyMJE8TpBIsWXxY8Yi/BizzAJ7hgfQzKOtQkisaZ9hYIwLbr+WeMyTlvROMq4WHw61
         I5c/8XhZ4j7kfryiGRqVgZzYRLvU1yC/pRb7uePxTcmQw7ekngaEzEZ3Bz+2EN7nhI5M
         +02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757937776; x=1758542576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkXTp59y9C0MEqVnEurpqF7SQ6VGFRiSZtPfZgLQH78=;
        b=k1f+Rr+WObjsnNKkxHKhO8NPIn7Phatu/B2je+YrTRFEbxxDfBfX7ilnCt9ARytB4i
         I85IjkJNhMRbG0Lmt1ww5Tyk8/nENynO04d5qbmKpX3ALCGlbDdmO4QVnGromMyBLtrw
         p0KJEUwilKFpzfxMhyvXL61O+1Te5TF40QDd9Fbw4hMl1dyRer21kTe6RvrfZ6iQWuVL
         80AzjfFI8pu13VpameltxiHLjp4tGh5uwCedrVG5oYVSqVF5FWv5lQbuv7E2QvqJ46YM
         wN2KfriYm7QdeRHkIr4P4tAj5tVVXK1WWSpSdUis/hV/HxTv0BuEBOsep/AxhQycQKb2
         oNJA==
X-Gm-Message-State: AOJu0YykJ9DfO9bXk0xc4Gw2gtimfZfZksooxTPpwqWjKcOlcmc76TiG
	bVqL5yFwgguXN0v0qQ6dMs7DZkzAfTgq5MjwTaKWgWhpDKTsTFbRJUM=
X-Gm-Gg: ASbGncub5GCiDxlP3JkntuoLVPSaBKkV/i8wRqDi9FSh7e5a7eDJ9IUvO+tZlDjWTmj
	2IIH6fNdGwgbw9ZQzbf+Rdfj14CpEMRvadq1ASz5NmDTtbrNR3m4KvzQkRc8Rpo76X5+XU0Nz7r
	wbz52ZGC07n8Xhs26zs74Qm0a3TmPobgfLpwn4zdYAJGoejmBIJ2dJFMB4IIdBdRaKcGVbyp4C7
	6g5MO6PuOYrcBJDoNxIwWH1tTmMHw2yvvaFyVlyVE25VQixcmjKISNaHQWR3eQ3o9/m8G9SQKti
	rUjnXiU7S/g8FQnoIhiF/jOdtR/gq2CfbixXKQ616mbTQGnU5fVD820Hv1EqIJry4z4ECQ==
X-Google-Smtp-Source: AGHT+IHL/HryR9tiooOb7lDGKCroEx2G99AHs7zmSQOVmt8ODb0sMPwpnyH24OUKIczYAVQ64mshQg==
X-Received: by 2002:a17:902:fc4c:b0:263:d6b5:fbe1 with SMTP id d9443c01a7336-263d6b60724mr63969435ad.55.1757937773109;
        Mon, 15 Sep 2025 05:02:53 -0700 (PDT)
Received: from FZWforever ([223.160.191.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-264eeab7bc8sm41174815ad.28.2025.09.15.05.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:02:52 -0700 (PDT)
From: JaimeFine <jaimefine6@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	ojeda@kernel.org
Cc: Jaime Fine <jaimefine6@gmail.com>
Subject: [PATCH] rust: auxiliary: Fix 'initialialized' typo
Date: Mon, 15 Sep 2025 20:02:27 +0800
Message-ID: <20250915120235.1942-1-jaimefine6@gmail.com>
X-Mailer: git-send-email 2.50.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jaime Fine <jaimefine6@gmail.com>

Suggested-by: onur-ozkan

Link: https://github.com/Rust-for-Linux/linux/issues/1187
Signed-off-by: Jaime Fine <jaimefine6@gmail.com>
---
 rust/kernel/auxiliary.rs | 357 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 357 insertions(+)
 create mode 100644 rust/kernel/auxiliary.rs

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
new file mode 100644
index 0000000..3626072
--- /dev/null
+++ b/rust/kernel/auxiliary.rs
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for the auxiliary bus.
+//!
+//! C header: [`include/linux/auxiliary_bus.h`](srctree/include/linux/auxiliary_bus.h)
+
+use crate::{
+    bindings, container_of, device,
+    device_id::{RawDeviceId, RawDeviceIdIndex},
+    driver,
+    error::{from_result, to_result, Result},
+    prelude::*,
+    types::Opaque,
+    ThisModule,
+};
+use core::{
+    marker::PhantomData,
+    ptr::{addr_of_mut, NonNull},
+};
+
+/// An adapter for the registration of auxiliary drivers.
+pub struct Adapter<T: Driver>(T);
+
+// SAFETY: A call to `unregister` for a given instance of `RegType` is guaranteed to be valid if
+// a preceding call to `register` has been successful.
+unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+    type RegType = bindings::auxiliary_driver;
+
+    unsafe fn register(
+        adrv: &Opaque<Self::RegType>,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        // SAFETY: It's safe to set the fields of `struct auxiliary_driver` on initialization.
+        unsafe {
+            (*adrv.get()).name = name.as_char_ptr();
+            (*adrv.get()).probe = Some(Self::probe_callback);
+            (*adrv.get()).remove = Some(Self::remove_callback);
+            (*adrv.get()).id_table = T::ID_TABLE.as_ptr();
+        }
+
+        // SAFETY: `adrv` is guaranteed to be a valid `RegType`.
+        to_result(unsafe {
+            bindings::__auxiliary_driver_register(adrv.get(), module.0, name.as_char_ptr())
+        })
+    }
+
+    unsafe fn unregister(adrv: &Opaque<Self::RegType>) {
+        // SAFETY: `adrv` is guaranteed to be a valid `RegType`.
+        unsafe { bindings::auxiliary_driver_unregister(adrv.get()) }
+    }
+}
+
+impl<T: Driver + 'static> Adapter<T> {
+    extern "C" fn probe_callback(
+        adev: *mut bindings::auxiliary_device,
+        id: *const bindings::auxiliary_device_id,
+    ) -> kernel::ffi::c_int {
+        // SAFETY: The auxiliary bus only ever calls the probe callback with a valid pointer to a
+        // `struct auxiliary_device`.
+        //
+        // INVARIANT: `adev` is valid for the duration of `probe_callback()`.
+        let adev = unsafe { &*adev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `DeviceId` is a `#[repr(transparent)`] wrapper of `struct auxiliary_device_id`
+        // and does not add additional invariants, so it's safe to transmute.
+        let id = unsafe { &*id.cast::<DeviceId>() };
+        let info = T::ID_TABLE.info(id.index());
+
+        from_result(|| {
+            let data = T::probe(adev, info)?;
+
+            adev.as_ref().set_drvdata(data);
+            Ok(0)
+        })
+    }
+
+    extern "C" fn remove_callback(adev: *mut bindings::auxiliary_device) {
+        // SAFETY: The auxiliary bus only ever calls the probe callback with a valid pointer to a
+        // `struct auxiliary_device`.
+        //
+        // INVARIANT: `adev` is valid for the duration of `probe_callback()`.
+        let adev = unsafe { &*adev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `remove_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `Pin<KBox<T>>`.
+        drop(unsafe { adev.as_ref().drvdata_obtain::<Pin<KBox<T>>>() });
+    }
+}
+
+/// Declares a kernel module that exposes a single auxiliary driver.
+#[macro_export]
+macro_rules! module_auxiliary_driver {
+    ($($f:tt)*) => {
+        $crate::module_driver!(<T>, $crate::auxiliary::Adapter<T>, { $($f)* });
+    };
+}
+
+/// Abstraction for `bindings::auxiliary_device_id`.
+#[repr(transparent)]
+#[derive(Clone, Copy)]
+pub struct DeviceId(bindings::auxiliary_device_id);
+
+impl DeviceId {
+    /// Create a new [`DeviceId`] from name.
+    pub const fn new(modname: &'static CStr, name: &'static CStr) -> Self {
+        let name = name.as_bytes_with_nul();
+        let modname = modname.as_bytes_with_nul();
+
+        // TODO: Replace with `bindings::auxiliary_device_id::default()` once stabilized for
+        // `const`.
+        //
+        // SAFETY: FFI type is valid to be zero-initialized.
+        let mut id: bindings::auxiliary_device_id = unsafe { core::mem::zeroed() };
+
+        let mut i = 0;
+        while i < modname.len() {
+            id.name[i] = modname[i];
+            i += 1;
+        }
+
+        // Reuse the space of the NULL terminator.
+        id.name[i - 1] = b'.';
+
+        let mut j = 0;
+        while j < name.len() {
+            id.name[i] = name[j];
+            i += 1;
+            j += 1;
+        }
+
+        Self(id)
+    }
+}
+
+// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `auxiliary_device_id` and does not add
+// additional invariants, so it's safe to transmute to `RawType`.
+unsafe impl RawDeviceId for DeviceId {
+    type RawType = bindings::auxiliary_device_id;
+}
+
+// SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `driver_data` field.
+unsafe impl RawDeviceIdIndex for DeviceId {
+    const DRIVER_DATA_OFFSET: usize =
+        core::mem::offset_of!(bindings::auxiliary_device_id, driver_data);
+
+    fn index(&self) -> usize {
+        self.0.driver_data
+    }
+}
+
+/// IdTable type for auxiliary drivers.
+pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
+
+/// Create a auxiliary `IdTable` with its alias for modpost.
+#[macro_export]
+macro_rules! auxiliary_device_table {
+    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
+        const $table_name: $crate::device_id::IdArray<
+            $crate::auxiliary::DeviceId,
+            $id_info_type,
+            { $table_data.len() },
+        > = $crate::device_id::IdArray::new($table_data);
+
+        $crate::module_device_table!("auxiliary", $module_table_name, $table_name);
+    };
+}
+
+/// The auxiliary driver trait.
+///
+/// Drivers must implement this trait in order to get an auxiliary driver registered.
+pub trait Driver {
+    /// The type holding information about each device id supported by the driver.
+    ///
+    /// TODO: Use associated_type_defaults once stabilized:
+    ///
+    /// type IdInfo: 'static = ();
+    type IdInfo: 'static;
+
+    /// The table of device ids supported by the driver.
+    const ID_TABLE: IdTable<Self::IdInfo>;
+
+    /// Auxiliary driver probe.
+    ///
+    /// Called when an auxiliary device is matches a corresponding driver.
+    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>;
+}
+
+/// The auxiliary device representation.
+///
+/// This structure represents the Rust abstraction for a C `struct auxiliary_device`. The
+/// implementation abstracts the usage of an already existing C `struct auxiliary_device` within
+/// Rust code that we get passed from the C side.
+///
+/// # Invariants
+///
+/// A [`Device`] instance represents a valid `struct auxiliary_device` created by the C portion of
+/// the kernel.
+#[repr(transparent)]
+pub struct Device<Ctx: device::DeviceContext = device::Normal>(
+    Opaque<bindings::auxiliary_device>,
+    PhantomData<Ctx>,
+);
+
+impl<Ctx: device::DeviceContext> Device<Ctx> {
+    fn as_raw(&self) -> *mut bindings::auxiliary_device {
+        self.0.get()
+    }
+
+    /// Returns the auxiliary device' id.
+    pub fn id(&self) -> u32 {
+        // SAFETY: By the type invariant `self.as_raw()` is a valid pointer to a
+        // `struct auxiliary_device`.
+        unsafe { (*self.as_raw()).id }
+    }
+
+    /// Returns a reference to the parent [`device::Device`], if any.
+    pub fn parent(&self) -> Option<&device::Device> {
+        let ptr: *const Self = self;
+        // CAST: `Device<Ctx: DeviceContext>` types are transparent to each other.
+        let ptr: *const Device = ptr.cast();
+        // SAFETY: `ptr` was derived from `&self`.
+        let this = unsafe { &*ptr };
+
+        this.as_ref().parent()
+    }
+}
+
+impl Device {
+    extern "C" fn release(dev: *mut bindings::device) {
+        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
+        // embedded in `struct auxiliary_device`.
+        let adev = unsafe { container_of!(dev, bindings::auxiliary_device, dev) };
+
+        // SAFETY: `adev` points to the memory that has been allocated in `Registration::new`, via
+        // `KBox::new(Opaque::<bindings::auxiliary_device>::zeroed(), GFP_KERNEL)`.
+        let _ = unsafe { KBox::<Opaque<bindings::auxiliary_device>>::from_raw(adev.cast()) };
+    }
+}
+
+// SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
+// argument.
+kernel::impl_device_context_deref!(unsafe { Device });
+kernel::impl_device_context_into_aref!(Device);
+
+// SAFETY: Instances of `Device` are always reference-counted.
+unsafe impl crate::types::AlwaysRefCounted for Device {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::get_device(self.as_ref().as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // CAST: `Self` a transparent wrapper of `bindings::auxiliary_device`.
+        let adev: *mut bindings::auxiliary_device = obj.cast().as_ptr();
+
+        // SAFETY: By the type invariant of `Self`, `adev` is a pointer to a valid
+        // `struct auxiliary_device`.
+        let dev = unsafe { addr_of_mut!((*adev).dev) };
+
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::put_device(dev) }
+    }
+}
+
+impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
+    fn as_ref(&self) -> &device::Device<Ctx> {
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct auxiliary_device`.
+        let dev = unsafe { addr_of_mut!((*self.as_raw()).dev) };
+
+        // SAFETY: `dev` points to a valid `struct device`.
+        unsafe { device::Device::from_raw(dev) }
+    }
+}
+
+// SAFETY: A `Device` is always reference-counted and can be released from any thread.
+unsafe impl Send for Device {}
+
+// SAFETY: `Device` can be shared among threads because all methods of `Device`
+// (i.e. `Device<Normal>) are thread safe.
+unsafe impl Sync for Device {}
+
+/// The registration of an auxiliary device.
+///
+/// This type represents the registration of a [`struct auxiliary_device`]. When an instance of this
+/// type is dropped, its respective auxiliary device will be unregistered from the system.
+///
+/// # Invariants
+///
+/// `self.0` always holds a valid pointer to an initialized and registered
+/// [`struct auxiliary_device`].
+pub struct Registration(NonNull<bindings::auxiliary_device>);
+
+impl Registration {
+    /// Create and register a new auxiliary device.
+    pub fn new(parent: &device::Device, name: &CStr, id: u32, modname: &CStr) -> Result<Self> {
+        let boxed = KBox::new(Opaque::<bindings::auxiliary_device>::zeroed(), GFP_KERNEL)?;
+        let adev = boxed.get();
+
+        // SAFETY: It's safe to set the fields of `struct auxiliary_device` on initialization.
+        unsafe {
+            (*adev).dev.parent = parent.as_raw();
+            (*adev).dev.release = Some(Device::release);
+            (*adev).name = name.as_char_ptr();
+            (*adev).id = id;
+        }
+
+        // SAFETY: `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`,
+        // which has not been initialized yet.
+        unsafe { bindings::auxiliary_device_init(adev) };
+
+        // Now that `adev` is initialized, leak the `Box`; the corresponding memory will be freed
+        // by `Device::release` when the last reference to the `struct auxiliary_device` is dropped.
+        let _ = KBox::into_raw(boxed);
+
+        // SAFETY:
+        // - `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`, which has
+        //   been initialized,
+        // - `modname.as_char_ptr()` is a NULL terminated string.
+        let ret = unsafe { bindings::__auxiliary_device_add(adev, modname.as_char_ptr()) };
+        if ret != 0 {
+            // SAFETY: `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`,
+            // which has been initialized.
+            unsafe { bindings::auxiliary_device_uninit(adev) };
+
+            return Err(Error::from_errno(ret));
+        }
+
+        // SAFETY: `adev` is guaranteed to be non-null, since the `KBox` was allocated successfully.
+        //
+        // INVARIANT: The device will remain registered until `auxiliary_device_delete()` is called,
+        // which happens in `Self::drop()`.
+        Ok(Self(unsafe { NonNull::new_unchecked(adev) }))
+    }
+}
+
+impl Drop for Registration {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariant of `Self`, `self.0.as_ptr()` is a valid registered
+        // `struct auxiliary_device`.
+        unsafe { bindings::auxiliary_device_delete(self.0.as_ptr()) };
+
+        // This drops the reference we acquired through `auxiliary_device_init()`.
+        //
+        // SAFETY: By the type invariant of `Self`, `self.0.as_ptr()` is a valid registered
+        // `struct auxiliary_device`.
+        unsafe { bindings::auxiliary_device_uninit(self.0.as_ptr()) };
+    }
+}
+
+// SAFETY: A `Registration` of a `struct auxiliary_device` can be released from any thread.
+unsafe impl Send for Registration {}
+
+// SAFETY: `Registration` does not expose any methods or fields that need synchronization.
+unsafe impl Sync for Registration {}
-- 
2.50.0.windows.1


