Return-Path: <linux-kernel+bounces-735574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC47B0911E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63682A454B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3A42FBFE5;
	Thu, 17 Jul 2025 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MjlDAhTk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C7B2FE320;
	Thu, 17 Jul 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767760; cv=none; b=POt1Jmel8TQN2T4I0yucikBnUNz+kIbUQgKx8etoVIVx57W4dz/vAXmr4ZvRdiFdYNsVJ7FrvUpYt4C/0ndtR+atNlmjgYl6ASEWk1rStZYnDV82nUsbWfJNEpDJtGDynp8Idfq3n6RaI+Sj8xMqMbYqM3K1M/hAO+cjl+tR4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767760; c=relaxed/simple;
	bh=31AqHo3GIvu3IzySTWWesuZK0J2sD7GkvCbF0fO1rZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFrfDBUeFMM1Ny1aTfuHMthfz9NwGvEoowC74FYmKwwWFYZzlLT6/GahvFlHpX4F2umOcC5g4a82JjWiIsS4d3kebur/mPrNIvDjc7+6u/DRafQAp+vMvtltmCxr5waMVyXVTY0/+KT/E5Nj59gZdEmADWpPlV02tXYFWLBeYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MjlDAhTk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752767757;
	bh=31AqHo3GIvu3IzySTWWesuZK0J2sD7GkvCbF0fO1rZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MjlDAhTkQaYS7v9/hj5wXQWjOj7tBYWdWGw9lwWqc3ActlAfxw2JoRt2BdZf4GaHP
	 7OX3BN+HvbOfubAcBhT1JMLg0x39rtpBda1O8MVqkV6ZoADLErHOEQgACDo7My3gR+
	 HBH/GX3qf3Yc+XIBdBaKMYq83NpX/0zvHHfkhJK2CAnJ/c5jdgBwQN556PoUObOCge
	 T2ut7xSmtwRzgbOr4VYQfrech7aU762XStbMeI6vudKqpyrjfDOwiNAzYyISp+nw+T
	 S9b5YkBaJ/RhBd4PtU+Y+cKV6Hy+5+1I2CSBfx7GNc5rpjssR16Bs+ew0gY8qdZf8L
	 iOkaVr1cWoB9Q==
Received: from [192.168.0.2] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 105A417E1541;
	Thu, 17 Jul 2025 17:55:54 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 17 Jul 2025 12:55:24 -0300
Subject: [PATCH v15 3/3] rust: platform: add resource accessors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-topics-tyr-platform_iomem-v15-3-beca780b77e3@collabora.com>
References: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com>
In-Reply-To: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com>
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

The previous patches have added the abstractions for Resources and the
ability to map them and therefore read and write the underlying memory .

The only thing missing to make this accessible for platform devices is
to provide accessors that return instances of IoRequest<'a>. These
ensure that the resource are valid only for the lifetime of the platform
device, and that the platform device is in the Bound state.

Therefore, add these accessors. Also make it possible to retrieve
resources from platform devices in Rust using either a name or an index.

Acked-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/platform.rs | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 86f9d73c64b38ffe067be329a77b2fc04564c7fe..57f9964bb736cf5749ec3954def03c0d02873642 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -5,8 +5,11 @@
 //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
 
 use crate::{
-    acpi, bindings, container_of, device, driver,
+    acpi, bindings, container_of,
+    device::{self, Bound},
+    driver,
     error::{to_result, Result},
+    io::{mem::IoRequest, Resource},
     of,
     prelude::*,
     str::CStr,
@@ -211,6 +214,61 @@ impl<Ctx: device::DeviceContext> Device<Ctx> {
     fn as_raw(&self) -> *mut bindings::platform_device {
         self.0.get()
     }
+
+    /// Returns the resource at `index`, if any.
+    pub fn resource_by_index(&self, index: u32) -> Option<&Resource> {
+        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct platform_device`.
+        let resource = unsafe {
+            bindings::platform_get_resource(self.as_raw(), bindings::IORESOURCE_MEM, index)
+        };
+
+        if resource.is_null() {
+            return None;
+        }
+
+        // SAFETY: `resource` is a valid pointer to a `struct resource` as
+        // returned by `platform_get_resource`.
+        Some(unsafe { Resource::from_raw(resource) })
+    }
+
+    /// Returns the resource with a given `name`, if any.
+    pub fn resource_by_name(&self, name: &CStr) -> Option<&Resource> {
+        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct
+        // platform_device` and `name` points to a valid C string.
+        let resource = unsafe {
+            bindings::platform_get_resource_byname(
+                self.as_raw(),
+                bindings::IORESOURCE_MEM,
+                name.as_char_ptr(),
+            )
+        };
+
+        if resource.is_null() {
+            return None;
+        }
+
+        // SAFETY: `resource` is a valid pointer to a `struct resource` as
+        // returned by `platform_get_resource`.
+        Some(unsafe { Resource::from_raw(resource) })
+    }
+}
+
+impl Device<Bound> {
+    /// Returns an `IoRequest` for the resource at `index`, if any.
+    pub fn io_request_by_index(&self, index: u32) -> Option<IoRequest<'_>> {
+        // SAFETY: `resource` is a valid resource for `&self` during the
+        // lifetime of the `IoRequest`.
+        self.resource_by_index(index)
+            .map(|resource| unsafe { IoRequest::new(self.as_ref(), resource) })
+    }
+
+    /// Returns an `IoRequest` for the resource with a given `name`, if any.
+    pub fn io_request_by_name(&self, name: &CStr) -> Option<IoRequest<'_>> {
+        // SAFETY: `resource` is a valid resource for `&self` during the
+        // lifetime of the `IoRequest`.
+        self.resource_by_name(name)
+            .map(|resource| unsafe { IoRequest::new(self.as_ref(), resource) })
+    }
 }
 
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic

-- 
2.50.0


