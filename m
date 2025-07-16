Return-Path: <linux-kernel+bounces-734307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F8DB07FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A727AEA5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD762EE299;
	Wed, 16 Jul 2025 21:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XR1vVKey"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6B2ED87D;
	Wed, 16 Jul 2025 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702342; cv=none; b=KN2MJzr/oXyg2a/xiBqaF77n+ckH211MkUZvqDLSWRkWSmnGBqf3baxiJewwrDvR05vKNQvTvxSbArZriPilI4aSJCm+iFnORkzXfzosSkUMdreWRp+iZUG1buKRe6aaeue+JdEas8Q3mUUGeh+phjX7drUBCTQEXolpoTIBvlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702342; c=relaxed/simple;
	bh=wv/Vm8YrvCD/3HksOSprMnMXMEdtKRgjkN9k/T3BkU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9WsiOXn/w0+TPrxPcRfimS/WBRnmFO1ngh7KE3G7GJ/BRllexGHyPX0rE49HGJ77J24P/HV8lPnZEYqhOgmtR5TccP7scklIwJ38CQEalqMWCpUZfnF7PuohSR/k08UHLsvOV+OeLCzAvfSQAbJiovjenhyRCl80yoPGQn01cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XR1vVKey; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752702331;
	bh=wv/Vm8YrvCD/3HksOSprMnMXMEdtKRgjkN9k/T3BkU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XR1vVKey9aJ9aN4LAu/9OEOKFnPI+OB8Cwo4kzKo2q1AMFrsrjROCqxL9Wp9CPeyj
	 Oqz8YdVOhX1NobxYnTJNETV73nUwPBWTbk7q6FrC/faEAu0GHYXq8WN9y2Mc+HpLo4
	 7FhkIkSqstkZbZD0HdMwUYRbsrlapamGZUjeemBmOFtOHaIbmW/VJTYYpt553y3tPa
	 33Y+/h4k0LeEpHUxMG4ce6fN2XeTox/YnK/AJ0qqqMjhdwoE0SRFfAX4gilzYVXZCC
	 1iGHphKMi3vCob5fXEP5Ea+I73+GFqUVI6j6hojKaibmI2yOWZS6ieRQiwqvXxxPPh
	 sOQ66ClE3ATBA==
Received: from [192.168.0.2] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 36FAC17E11ED;
	Wed, 16 Jul 2025 23:45:29 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 16 Jul 2025 18:45:14 -0300
Subject: [PATCH v14 2/3] rust: io: mem: add a generic iomem abstraction
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-topics-tyr-platform_iomem-v14-2-2c2709135cb2@collabora.com>
References: <20250716-topics-tyr-platform_iomem-v14-0-2c2709135cb2@collabora.com>
In-Reply-To: <20250716-topics-tyr-platform_iomem-v14-0-2c2709135cb2@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

Add a generic iomem abstraction to safely read and write ioremapped
regions. This abstraction requires a previously acquired IoRequest
instance. This makes it so that both the resource and the device match,
or, in other words, that the resource is indeed a valid resource for a
given bound device.

A subsequent patch will add the ability to retrieve IoRequest instances
from platform devices.

The reads and writes are done through IoRaw, and are thus checked either
at compile-time, if the size of the region is known at that point, or at
runtime otherwise.

Non-exclusive access to the underlying memory region is made possible to
cater to cases where overlapped regions are unavoidable.

Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/helpers/io.c     |   5 +
 rust/kernel/io.rs     |   1 +
 rust/kernel/io/mem.rs | 282 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+)

diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index 404776cf6717c8570c7600a24712ce6e4623d3c6..c475913c69e647b1042e8e7d66b9148d892947a1 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -8,6 +8,11 @@ void __iomem *rust_helper_ioremap(phys_addr_t offset, size_t size)
 	return ioremap(offset, size);
 }
 
+void __iomem *rust_helper_ioremap_np(phys_addr_t offset, size_t size)
+{
+	return ioremap_np(offset, size);
+}
+
 void rust_helper_iounmap(void __iomem *addr)
 {
 	iounmap(addr);
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 7b70d5b5477e57d6d0f24bcd26bd8b0071721bc0..b7fc759f8b5d3c3ac6f33f5a66e9f619c58b7405 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -7,6 +7,7 @@
 use crate::error::{code::EINVAL, Result};
 use crate::{bindings, build_assert};
 
+pub mod mem;
 pub mod resource;
 
 pub use resource::Resource;
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
new file mode 100644
index 0000000000000000000000000000000000000000..9534f8ae42b2555ca79ec6317e874d93fc60c04f
--- /dev/null
+++ b/rust/kernel/io/mem.rs
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic memory-mapped IO.
+
+use core::ops::Deref;
+
+use crate::device::Bound;
+use crate::device::Device;
+use crate::devres::Devres;
+use crate::io;
+use crate::io::resource::Region;
+use crate::io::resource::Resource;
+use crate::io::Io;
+use crate::io::IoRaw;
+use crate::prelude::*;
+
+/// An IO request for a specific device and resource.
+pub struct IoRequest<'a> {
+    device: &'a Device<Bound>,
+    resource: &'a Resource,
+}
+
+impl<'a> IoRequest<'a> {
+    /// Creates a new [`IoRequest`] instance.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `resource` is valid for `device` during the
+    /// lifetime `'a`.
+    pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> Self {
+        IoRequest { device, resource }
+    }
+
+    /// Maps an [`IoRequest`] where the size is known at compile time.
+    ///
+    /// This uses the [`ioremap()`] C API.
+    ///
+    /// [`ioremap()`]: https://docs.kernel.org/driver-api/device-io.html#getting-access-to-the-device
+    ///
+    /// # Examples
+    ///
+    /// The following example uses a [`platform::Device`] for illustration
+    /// purposes.
+    ///
+    /// ```no_run
+    /// use kernel::{bindings, c_str, platform, of, device::Core};
+    /// struct SampleDriver;
+    ///
+    /// impl platform::Driver for SampleDriver {
+    ///    # type IdInfo = ();
+    ///    # const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
+    ///
+    ///    fn probe(
+    ///       pdev: &platform::Device<Core>,
+    ///       info: Option<&Self::IdInfo>,
+    ///    ) -> Result<Pin<KBox<Self>>> {
+    ///       let offset = 0; // Some offset.
+    ///
+    ///       // If the size is known at compile time, use [`Self::iomap_sized`].
+    ///       //
+    ///       // No runtime checks will apply when reading and writing.
+    ///       let request = pdev.request_io_by_index(0).ok_or(ENODEV)?;
+    ///       let iomem = request.iomap_sized::<42>();
+    ///       let iomem = KBox::pin_init(iomem, GFP_KERNEL)?;
+    ///
+    ///       let io = iomem.access(pdev.as_ref())?;
+    ///
+    ///       // Read and write a 32-bit value at `offset`.
+    ///       let data = io.read32_relaxed(offset);
+    ///
+    ///       io.write32_relaxed(data, offset);
+    ///
+    ///       # Ok(KBox::new(SampleDriver, GFP_KERNEL)?.into())
+    ///     }
+    /// }
+    /// ```
+    pub fn iomap_sized<const SIZE: usize>(self) -> impl PinInit<Devres<IoMem<SIZE>>, Error> + 'a {
+        IoMem::new(self)
+    }
+
+    /// Same as [`Self::iomap_sized`] but with exclusive access to the
+    /// underlying region.
+    ///
+    /// This uses the [`ioremap()`] C API.
+    ///
+    /// [`ioremap()`]: https://docs.kernel.org/driver-api/device-io.html#getting-access-to-the-device
+    pub fn iomap_exclusive_sized<const SIZE: usize>(
+        self,
+    ) -> impl PinInit<Devres<ExclusiveIoMem<SIZE>>, Error> + 'a {
+        ExclusiveIoMem::new(self)
+    }
+
+    /// Maps an [`IoRequest`] where the size is not known at compile time,
+    ///
+    /// This uses the [`ioremap()`] C API.
+    ///
+    /// [`ioremap()`]: https://docs.kernel.org/driver-api/device-io.html#getting-access-to-the-device
+    ///
+    /// # Examples
+    ///
+    /// The following example uses a [`platform::Device`] for illustration
+    /// purposes.
+    ///
+    /// ```no_run
+    /// use kernel::{bindings, c_str, platform, of, device::Core};
+    /// struct SampleDriver;
+    ///
+    /// impl platform::Driver for SampleDriver {
+    ///    # type IdInfo = ();
+    ///    # const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
+    ///
+    ///    fn probe(
+    ///       pdev: &platform::Device<Core>,
+    ///       info: Option<&Self::IdInfo>,
+    ///    ) -> Result<Pin<KBox<Self>>> {
+    ///       let offset = 0; // Some offset.
+    ///
+    ///       // Unlike [`Self::iomap_sized`], here the size of the memory region
+    ///       // is not known at compile time, so only the `try_read*` and `try_write*`
+    ///       // family of functions should be used, leading to runtime checks on every
+    ///       // access.
+    ///       let request = pdev.request_io_by_index(0).ok_or(ENODEV)?;
+    ///       let iomem = request.iomap();
+    ///       let iomem = KBox::pin_init(iomem, GFP_KERNEL)?;
+    ///
+    ///       let io = iomem.access(pdev.as_ref())?;
+    ///
+    ///       let data = io.try_read32_relaxed(offset)?;
+    ///
+    ///       io.try_write32_relaxed(data, offset)?;
+    ///
+    ///       # Ok(KBox::new(SampleDriver, GFP_KERNEL)?.into())
+    ///     }
+    /// }
+    /// ```
+    pub fn iomap(self) -> impl PinInit<Devres<IoMem<0>>, Error> + 'a {
+        Self::iomap_sized::<0>(self)
+    }
+
+    /// Same as [`Self::iomap`] but with exclusive access to the underlying
+    /// region.
+    pub fn iomap_exclusive(self) -> impl PinInit<Devres<ExclusiveIoMem<0>>, Error> + 'a {
+        Self::iomap_exclusive_sized::<0>(self)
+    }
+}
+
+/// An exclusive memory-mapped IO region.
+///
+/// # Invariants
+///
+/// - [`ExclusiveIoMem`] has exclusive access to the underlying [`IoMem`].
+pub struct ExclusiveIoMem<const SIZE: usize> {
+    /// The underlying `IoMem` instance.
+    iomem: IoMem<SIZE>,
+
+    /// The region abstraction. This represents exclusive access to the
+    /// range represented by the underlying `iomem`.
+    ///
+    /// This field is needed for ownership of the region.
+    _region: Region,
+}
+
+impl<const SIZE: usize> ExclusiveIoMem<SIZE> {
+    /// Creates a new `ExclusiveIoMem` instance.
+    fn ioremap(resource: &Resource) -> Result<Self> {
+        let start = resource.start();
+        let size = resource.size();
+        let name = resource.name().ok_or(EINVAL)?;
+
+        let region = resource
+            .request_region(
+                start,
+                size,
+                name.to_cstring()?,
+                io::resource::Flags::IORESOURCE_MEM,
+            )
+            .ok_or(EBUSY)?;
+
+        let iomem = IoMem::ioremap(resource)?;
+
+        let iomem = ExclusiveIoMem {
+            iomem,
+            _region: region,
+        };
+
+        Ok(iomem)
+    }
+
+    /// Creates a new `ExclusiveIoMem` instance from a previously acquired [`IoRequest`].
+    pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> + 'a {
+        let dev = io_request.device;
+        let res = io_request.resource;
+
+        Devres::new(dev, Self::ioremap(res))
+    }
+}
+
+impl<const SIZE: usize> Deref for ExclusiveIoMem<SIZE> {
+    type Target = Io<SIZE>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.iomem
+    }
+}
+
+/// A generic memory-mapped IO region.
+///
+/// Accesses to the underlying region is checked either at compile time, if the
+/// region's size is known at that point, or at runtime otherwise.
+///
+/// # Invariants
+///
+/// [`IoMem`] always holds an [`IoRaw`] instance that holds a valid pointer to the
+/// start of the I/O memory mapped region.
+pub struct IoMem<const SIZE: usize = 0> {
+    io: IoRaw<SIZE>,
+}
+
+impl<const SIZE: usize> IoMem<SIZE> {
+    fn ioremap(resource: &Resource) -> Result<Self> {
+        // Note: It looks like there aren't any 32-bit architectures that define
+        // ioremap_np. This means that sometimes this conversion will fail. If
+        // we performed a lossy cast, i.e., using `as`, then `bindings::ioremap`
+        // would return NULL anyway.
+        //
+        // TODO: Properly address this in the C code to avoid this `try_into`.
+        let size = resource.size().try_into()?;
+        if size == 0 {
+            return Err(EINVAL);
+        }
+
+        let res_start = resource.start();
+
+        let addr = if resource
+            .flags()
+            .contains(io::resource::Flags::IORESOURCE_MEM_NONPOSTED)
+        {
+            // SAFETY:
+            // - `res_start` and `size` are read from a presumably valid `struct resource`.
+            // - `size` is known not to be zero at this point.
+            unsafe { bindings::ioremap_np(res_start, size) }
+        } else {
+            // SAFETY:
+            // - `res_start` and `size` are read from a presumably valid `struct resource`.
+            // - `size` is known not to be zero at this point.
+            unsafe { bindings::ioremap(res_start, size) }
+        };
+
+        if addr.is_null() {
+            return Err(ENOMEM);
+        }
+
+        let io = IoRaw::new(addr as usize, size)?;
+        let io = IoMem { io };
+
+        Ok(io)
+    }
+
+    /// Creates a new `IoMem` instance from a previously acquired [`IoRequest`].
+    pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> + 'a {
+        let dev = io_request.device;
+        let res = io_request.resource;
+
+        Devres::new(dev, Self::ioremap(res))
+    }
+}
+
+impl<const SIZE: usize> Drop for IoMem<SIZE> {
+    fn drop(&mut self) {
+        // SAFETY: Safe as by the invariant of `Io`.
+        unsafe { bindings::iounmap(self.io.addr() as *mut c_void) }
+    }
+}
+
+impl<const SIZE: usize> Deref for IoMem<SIZE> {
+    type Target = Io<SIZE>;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: Safe as by the invariant of `IoMem`.
+        unsafe { Io::from_raw(&self.io) }
+    }
+}

-- 
2.50.0


