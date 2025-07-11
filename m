Return-Path: <linux-kernel+bounces-728339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20F0B026F2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96821C45FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679952222DA;
	Fri, 11 Jul 2025 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="he0m39JV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E28221561;
	Fri, 11 Jul 2025 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752273162; cv=none; b=DVBcECepeodVvP7mlJTtmT+4aFJMCFT65VA9eAgphpcuhc71godatmL3e8TNTLFD3f3zF9dHqQbtHZNtsVsGpfMWSrw1Iat7+nJEQOG6XR5V5VlT/ab0KVsQmpnjm6mXHLQ2ofR3o/Xe+mBOo6uTEW8V/przc0R7OXEGqyIoE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752273162; c=relaxed/simple;
	bh=pm2SvLkCXuUnof6fMWIhNHUi98XecqxrV8PZ8Ha55cQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fMu0NwwGDCgWou+YfYGj1wdAPBhKIx296JH1yIX6r9iI8x0lyJTfJULs5Nii4NY4sVmq3DsfDcBrczUeUA1+7MePyvfPp0C2vxbVsEezusq9KQ/VgBrJeyOTeApTVwoehkHCPMNru9pRJVgqgstxzkJeBn6W+AhVzaTpwqB6MAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=he0m39JV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752273156;
	bh=pm2SvLkCXuUnof6fMWIhNHUi98XecqxrV8PZ8Ha55cQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=he0m39JVGlB1++3DvOMSKNuRGOpt7bFhUlO1U2Z3pkWmuBVBDk+Rf6xxi+wEZmdc4
	 A0IcaNGIR0kvC8tVf/uO9WqUacZ4PDS5Au1Ddqm0RKb/g/dAbQo6uFNF9j/x5Ak3s/
	 KYTDT6E0u6TdUHXTTsAvf6yKvsssWYXNzZ3PQLEqmuphWKUsZl9su7lvVLVhE58PNC
	 yC+3Ts3pKkHNqSamkOB1b10NGef9xaR6P85WV5MTlzXHpVnWcrbDK+1pdGsT21269v
	 XHAtWGCmdUU5Oi+aOEv1+UZ4SCllkH5wBlJnUndwJPAVXU9Bmn80sq4tMrYu9m57/9
	 REHDXOFSDIDNw==
Received: from [192.168.0.2] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 46C9617E0930;
	Sat, 12 Jul 2025 00:32:34 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 11 Jul 2025 19:32:27 -0300
Subject: [PATCH v13 1/3] rust: io: add resource abstraction
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-topics-tyr-platform_iomem-v13-1-06328b514db3@collabora.com>
References: <20250711-topics-tyr-platform_iomem-v13-0-06328b514db3@collabora.com>
In-Reply-To: <20250711-topics-tyr-platform_iomem-v13-0-06328b514db3@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Fiona Behrens <me@kloenk.dev>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

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
 rust/kernel/io/resource.rs      | 204 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+)

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
index 0000000000000000000000000000000000000000..b20b2df3d65dfc8c14881c440ea901da0273b1bb
--- /dev/null
+++ b/rust/kernel/io/resource.rs
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for [system
+//! resources](https://docs.kernel.org/core-api/kernel-api.html#resources-management).
+//!
+//! C header: [`include/linux/ioport.h`](srctree/include/linux/ioport.h)
+
+use core::ops::Deref;
+use core::ptr::NonNull;
+
+use crate::prelude::*;
+use crate::str::CStr;
+use crate::types::Opaque;
+
+/// Resource Size type.
+///
+/// This is a type alias to either `u32` or `u64` depending on the config option
+/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
+pub type ResourceSize = bindings::phys_addr_t;
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
+        // SAFETY: Safe as per the invariant of `Region`.
+        unsafe { Resource::from_raw(self.0.as_ptr()) }
+    }
+}
+
+impl Drop for Region {
+    fn drop(&mut self) {
+        let (flags, start, size) = {
+            let res = &**self;
+            (res.flags(), res.start(), res.size())
+        };
+
+        let release_fn = if flags.contains(Flags::IORESOURCE_MEM) {
+            bindings::release_mem_region
+        } else {
+            bindings::release_region
+        };
+
+        // SAFETY: Safe as per the invariant of `Region`.
+        unsafe { release_fn(start, size) };
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
+    pub(crate) const unsafe fn from_raw<'a>(ptr: *mut bindings::resource) -> &'a Self {
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
+        // SAFETY:
+        // - Safe as per the invariant of `Resource`.
+        // - `__request_region` will store a reference to the name, but that is
+        // safe as the name is 'static.
+        let region = unsafe {
+            bindings::__request_region(
+                self.0.get(),
+                start,
+                size,
+                name.as_char_ptr(),
+                flags.0 as c_int,
+            )
+        };
+
+        Some(Region(NonNull::new(region)?))
+    }
+
+    /// Returns the size of the resource.
+    pub fn size(&self) -> ResourceSize {
+        let inner = self.0.get();
+        // SAFETY: safe as per the invariants of `Resource`.
+        unsafe { bindings::resource_size(inner) }
+    }
+
+    /// Returns the start address of the resource.
+    pub fn start(&self) -> u64 {
+        let inner = self.0.get();
+        // SAFETY: safe as per the invariants of `Resource`.
+        unsafe { (*inner).start }
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
+        let flags = unsafe { (*inner).flags };
+
+        Flags(flags)
+    }
+}
+
+// SAFETY: `Resource` only holds a pointer to a C `struct resource`, which is
+// safe to be used from any thread.
+unsafe impl Send for Resource {}
+
+// SAFETY: `Resource` only holds a pointer to a C `struct resource`, references
+// to which are safe to be used from any thread.
+unsafe impl Sync for Resource {}
+
+/// Resource flags as stored in the C `struct resource::flags` field.
+///
+/// They can be combined with the operators `|`, `&`, and `!`.
+///
+/// Values can be used from the [`flags`] module.
+#[derive(Clone, Copy, PartialEq)]
+pub struct Flags(c_ulong);
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
+impl Flags {
+    /// PCI/ISA I/O ports.
+    pub const IORESOURCE_IO: Flags = Flags(bindings::IORESOURCE_IO as c_ulong);
+
+    /// Resource is software muxed.
+    pub const IORESOURCE_MUXED: Flags = Flags(bindings::IORESOURCE_MUXED as c_ulong);
+
+    /// Resource represents a memory region.
+    pub const IORESOURCE_MEM: Flags = Flags(bindings::IORESOURCE_MEM as c_ulong);
+
+    /// Resource represents a memory region that must be ioremaped using `ioremap_np`.
+    pub const IORESOURCE_MEM_NONPOSTED: Flags =
+        Flags(bindings::IORESOURCE_MEM_NONPOSTED as c_ulong);
+}

-- 
2.50.0


