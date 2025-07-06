Return-Path: <linux-kernel+bounces-711585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB29BAEFCB8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 16:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572753B1B96
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7590277815;
	Tue,  1 Jul 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="bvlHW6yR"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D849274FFC;
	Tue,  1 Jul 2025 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380536; cv=pass; b=lZkD3M0S631QhC99kNVDfbQDdRF4s8vRfesRQd0E59gkh6iSp+VtIY8n141BUH6k97lwFcy3pSCp4sXMunrbouW2DL8DIVhNj95rGobJSwqBH17gXAULTDMh4DxffMgNFzA8cklLc/BfY2zuk3kqPULAgKzV+esXsmXiIAGr8PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380536; c=relaxed/simple;
	bh=L6HGAuoOWz16KJQyCN1VBJQ0GGYAw625gy+vfasU8v4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kA7sxVrXS3wS4yrTJZGp91fXYs2B0WjsbP6XsVd4YABEDaRrjt5ZvKQxvJn5TKMgCam3rof7FZMzxYqPNUE9RXIB9pVwV4nFd+txvKgFDE+HhOOljjnPP1zxRd4oBP6ua/3w5tF0v3H1cuZFHlVpRBZvZblMC3dGb8YQki+bOBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=bvlHW6yR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751380511; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UrkOcHZJp0oAlNoEYXah58xpfp3GdGPm9PniOS9YRFMADvWeViLwbAgAlZKjp4AOYDm7T1N57dKk8HHiLQNe6XD14hS64LL7MWrIWWppjC+2PZYAT1SVEeeZowCdMWmoF+oXwUSkrf4XdDY22B43h0ZXBdfmV5HpRoIe6knmdtM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751380511; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=am1+k9Vgsj0sTx4Gf9bt86y9Yfop8AO+jd4VXp6U3OQ=; 
	b=jp21Z521pTOaIT8RiRaHB3ppDlop1Fxz76y1fXmdKfGP4w2TW7y1XGtlK25xAgdyhDVwzwiVPAQ/M8QUFDNL5NxNdKJ7A+in72YCV83FsBesjDf5CGQTRwx9MawWcQjaFTo0fy3mV+Ez5xoIM4qg5BQI/PNv64J4YL41AerKk7g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751380511;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=am1+k9Vgsj0sTx4Gf9bt86y9Yfop8AO+jd4VXp6U3OQ=;
	b=bvlHW6yRc/FOGLRn7O7nS0h6wh/SK4QYn+cVf60uV+PWSJwxaqOhhGGQiHdgm2EI
	Vw8Yo5PnHGX1PiUzn4Q+miXb878dM1MfJd8ck1CqPRhB4S/j5d0I84OdcOBhZCrIK+B
	Hb9wh+PPW+q/0ITbQLiL+m+VZFFQKx7/HSziFMEo=
Received: by mx.zohomail.com with SMTPS id 175138051036077.87853010475237;
	Tue, 1 Jul 2025 07:35:10 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 01 Jul 2025 11:34:39 -0300
Subject: [PATCH v11 1/4] rust: io: add resource abstraction
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-topics-tyr-platform_iomem-v11-1-6cd5d5061151@collabora.com>
References: <20250701-topics-tyr-platform_iomem-v11-0-6cd5d5061151@collabora.com>
In-Reply-To: <20250701-topics-tyr-platform_iomem-v11-0-6cd5d5061151@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Ying Huang <huang.ying.caritas@gmail.com>, Benno Lossin <lossin@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Fiona Behrens <me@kloenk.dev>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

In preparation for ioremap support, add a Rust abstraction for struct
resource.

A future commit will introduce the Rust API to ioremap a resource from a
platform device. The current abstraction, therefore, adds only the
minimum API needed to get that done.

Co-developed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/io.c               |  36 +++++++
 rust/kernel/io.rs               |   4 +
 rust/kernel/io/resource.rs      | 222 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 263 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 7e8f2285064797d5bbac5583990ff823b76c6bdc..5f795e60e889b9fc887013743c81b1cf92a52adb 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -53,6 +53,7 @@
 #include <linux/file.h>
 #include <linux/firmware.h>
 #include <linux/fs.h>
+#include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
 #include <linux/mdio.h>
diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index 15ea187c5466256effd07efe6f6995a1dd95a967..404776cf6717c8570c7600a24712ce6e4623d3c6 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/io.h>
+#include <linux/ioport.h>
 
 void __iomem *rust_helper_ioremap(phys_addr_t offset, size_t size)
 {
@@ -99,3 +100,38 @@ void rust_helper_writeq_relaxed(u64 value, void __iomem *addr)
 	writeq_relaxed(value, addr);
 }
 #endif
+
+resource_size_t rust_helper_resource_size(struct resource *res)
+{
+	return resource_size(res);
+}
+
+struct resource *rust_helper_request_mem_region(resource_size_t start,
+						resource_size_t n,
+						const char *name)
+{
+	return request_mem_region(start, n, name);
+}
+
+void rust_helper_release_mem_region(resource_size_t start, resource_size_t n)
+{
+	release_mem_region(start, n);
+}
+
+struct resource *rust_helper_request_region(resource_size_t start,
+					    resource_size_t n, const char *name)
+{
+	return request_region(start, n, name);
+}
+
+struct resource *rust_helper_request_muxed_region(resource_size_t start,
+						  resource_size_t n,
+						  const char *name)
+{
+	return request_muxed_region(start, n, name);
+}
+
+void rust_helper_release_region(resource_size_t start, resource_size_t n)
+{
+	release_region(start, n);
+}
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 72d80a6f131e3e826ecd9d2c3bcf54e89aa60cc3..7b70d5b5477e57d6d0f24bcd26bd8b0071721bc0 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -7,6 +7,10 @@
 use crate::error::{code::EINVAL, Result};
 use crate::{bindings, build_assert};
 
+pub mod resource;
+
+pub use resource::Resource;
+
 /// Raw representation of an MMIO region.
 ///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
new file mode 100644
index 0000000000000000000000000000000000000000..611eca8cc693d83bccc2c384db2ff22d11e7ac46
--- /dev/null
+++ b/rust/kernel/io/resource.rs
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for system resources.
+//!
+//! C header: [`include/linux/ioport.h`](srctree/include/linux/ioport.h)
+
+use core::ops::Deref;
+use core::ptr::NonNull;
+
+use crate::str::CStr;
+use crate::types::Opaque;
+
+#[cfg(CONFIG_HAS_IOPORT)]
+/// Returns a reference to the global `ioport_resource` variable.
+pub fn ioport_resource() -> &'static Resource {
+    // SAFETY: `bindings::ioport_resoure` has global lifetime and is of type Resource.
+    unsafe { Resource::as_ref(&raw mut bindings::ioport_resource) }
+}
+
+#[cfg(CONFIG_HAS_IOMEM)]
+/// Returns a reference to the global `iomem_resource` variable.
+pub fn iomem_resource() -> &'static Resource {
+    // SAFETY: `bindings::iomem_resoure` has global lifetime and is of type Resource.
+    unsafe { Resource::as_ref(&raw mut bindings::iomem_resource) }
+}
+
+/// Resource Size type.
+///
+/// This is a type alias to `u64` depending on the config option
+/// `CONFIG_PHYS_ADDR_T_64BIT`.
+#[cfg(CONFIG_PHYS_ADDR_T_64BIT)]
+pub type ResourceSize = u64;
+
+/// Resource Size type.
+///
+/// This is a type alias to `u32` depending on the config option
+/// `CONFIG_PHYS_ADDR_T_64BIT`.
+#[cfg(not(CONFIG_PHYS_ADDR_T_64BIT))]
+pub type ResourceSize = u32;
+
+/// A region allocated from a parent [`Resource`].
+///
+/// # Invariants
+///
+/// - `self.0` points to a valid `bindings::resource` that was obtained through
+///   `bindings::__request_region`.
+pub struct Region(NonNull<bindings::resource>);
+
+impl Deref for Region {
+    type Target = Resource;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: Safe as per the invariant of `Region`
+        unsafe { Resource::as_ref(self.0.as_ptr()) }
+    }
+}
+
+impl Drop for Region {
+    fn drop(&mut self) {
+        // SAFETY: Safe as per the invariant of `Region`
+        let res = unsafe { Resource::as_ref(self.0.as_ptr()) };
+        let flags = res.flags();
+
+        let release_fn = if flags.contains(flags::IORESOURCE_MEM) {
+            bindings::release_mem_region
+        } else {
+            bindings::release_region
+        };
+
+        // SAFETY: Safe as per the invariant of `Region`
+        unsafe { release_fn(res.start(), res.size()) };
+    }
+}
+
+// SAFETY: `Region` only holds a pointer to a C `struct resource`, which is safe to be used from
+// any thread.
+unsafe impl Send for Region {}
+
+// SAFETY: `Region` only holds a pointer to a C `struct resource`, references to which are
+// safe to be used from any thread.
+unsafe impl Sync for Region {}
+
+/// A resource abstraction.
+///
+/// # Invariants
+///
+/// [`Resource`] is a transparent wrapper around a valid `bindings::resource`.
+#[repr(transparent)]
+pub struct Resource(Opaque<bindings::resource>);
+
+impl Resource {
+    /// Creates a reference to a [`Resource`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that for the duration of 'a, the pointer will
+    /// point at a valid `bindings::resource`.
+    ///
+    /// The caller must also ensure that the [`Resource`] is only accessed via the
+    /// returned reference for the duration of 'a.
+    pub(crate) const unsafe fn as_ref<'a>(ptr: *mut bindings::resource) -> &'a Self {
+        // SAFETY: Self is a transparent wrapper around `Opaque<bindings::resource>`.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Requests a resource region.
+    ///
+    /// Exclusive access will be given and the region will be marked as busy.
+    /// Further calls to [`Self::request_region`] will return [`None`] if
+    /// the region, or a part of it, is already in use.
+    pub fn request_region(
+        &self,
+        start: ResourceSize,
+        size: ResourceSize,
+        name: &'static CStr,
+        flags: Flags,
+    ) -> Option<Region> {
+        // SAFETY: Safe as per the invariant of `Resource`
+        let region = unsafe {
+            bindings::__request_region(
+                self.0.get(),
+                start,
+                size,
+                name.as_char_ptr(),
+                flags.0 as i32,
+            )
+        };
+
+        Some(Region(NonNull::new(region)?))
+    }
+
+    /// Returns the size of the resource.
+    pub fn size(&self) -> ResourceSize {
+        let inner = self.0.get();
+        // SAFETY: safe as per the invariants of `Resource`
+        unsafe { bindings::resource_size(inner) }
+    }
+
+    /// Returns the start address of the resource.
+    pub fn start(&self) -> u64 {
+        let inner = self.0.get();
+        // SAFETY: safe as per the invariants of `Resource`
+        unsafe { *inner }.start
+    }
+
+    /// Returns the name of the resource.
+    pub fn name(&self) -> &'static CStr {
+        let inner = self.0.get();
+        // SAFETY: safe as per the invariants of `Resource`
+        unsafe { CStr::from_char_ptr((*inner).name) }
+    }
+
+    /// Returns the flags associated with the resource.
+    pub fn flags(&self) -> Flags {
+        let inner = self.0.get();
+        // SAFETY: safe as per the invariants of `Resource`
+        let flags = unsafe { *inner }.flags;
+
+        Flags(flags)
+    }
+}
+
+// SAFETY: `Resource` only holds a pointer to a C `struct resource`, which is safe to be used from
+// any thead.
+unsafe impl Send for Resource {}
+
+// SAFETY: `Resource` only holds a pointer to a C `struct resource`, references to which are
+// safe to be used from any thead.
+unsafe impl Sync for Resource {}
+
+/// Resource flags as stored in the C `struct resource::flags` field.
+///
+/// They can be combined with the operators `|`, `&`, and `!`.
+///
+/// Values can be used from the [`flags`] module.
+#[derive(Clone, Copy, PartialEq)]
+pub struct Flags(usize);
+
+impl Flags {
+    /// Check whether `flags` is contained in `self`.
+    pub fn contains(self, flags: Flags) -> bool {
+        (self & flags) == flags
+    }
+}
+
+impl core::ops::BitOr for Flags {
+    type Output = Self;
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+impl core::ops::BitAnd for Flags {
+    type Output = Self;
+    fn bitand(self, rhs: Self) -> Self::Output {
+        Self(self.0 & rhs.0)
+    }
+}
+
+impl core::ops::Not for Flags {
+    type Output = Self;
+    fn not(self) -> Self::Output {
+        Self(!self.0)
+    }
+}
+
+/// Resource flags as stored in the `struct resource::flags` field.
+pub mod flags {
+    use super::Flags;
+
+    /// PCI/ISA I/O ports.
+    pub const IORESOURCE_IO: Flags = Flags(bindings::IORESOURCE_IO as usize);
+
+    /// Resource is software muxed.
+    pub const IORESOURCE_MUXED: Flags = Flags(bindings::IORESOURCE_MUXED as usize);
+
+    /// Resource represents a memory region.
+    pub const IORESOURCE_MEM: Flags = Flags(bindings::IORESOURCE_MEM as usize);
+
+    /// Resource represents a memory region that must be ioremaped using `ioremap_np`.
+    pub const IORESOURCE_MEM_NONPOSTED: Flags = Flags(bindings::IORESOURCE_MEM_NONPOSTED as usize);
+}

-- 
2.50.0


