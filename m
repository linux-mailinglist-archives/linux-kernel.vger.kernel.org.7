Return-Path: <linux-kernel+bounces-752331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E42B17426
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75430585666
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95607211A35;
	Thu, 31 Jul 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqSTVuN2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25DF1DF991;
	Thu, 31 Jul 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976982; cv=none; b=Uh8oF099++eqxTp3hMHmR8ivgvv24P9YL3H1PATngqodJa2HVp0bC+YprcsFmyt35vMBx5Uwbi1++/tHmtIUDqs+9hEUgRHAMrgd6h72DQE4TH5gNoFwoZ2YBIbVC2obFhfCXuXXetNKGxNgAevdBMfFj/QHe3irGtfO6hKfHWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976982; c=relaxed/simple;
	bh=r97UwXG1579xAWFCkWZJzKyFqYZzuvi9ibi+ySY8Gs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhFFpOSJQp5XNuuHP0ogkn9+zWAenPEPpuv/dVVCsTiZtkMFdrBWwS3CZ2ygiEoEKXJlg+iMz4oq4f3M9SP8V1E9RX5YzW1s2AJtfXNOJOMM3iokti3nVfCum5LZCm9mGuBArHDb00TRuN0kgAC8wp9QgZHp6jGDB34jPI0ls8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqSTVuN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D84C4CEF7;
	Thu, 31 Jul 2025 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753976981;
	bh=r97UwXG1579xAWFCkWZJzKyFqYZzuvi9ibi+ySY8Gs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EqSTVuN2zxfwZ1frunNoQ63lBeWmPwz6UKKe2gisXeuR5NNASuWfzv4HNoKu/iLs4
	 7tpvVxDzKyToaxJ28prMBA+9RiELT7DrqKzJCis7ex3zEEkbNVL/APlEHN3EBB+imV
	 lSMvZlQNwLxCdRHR/Qfhd5ffsDWXC1CaIsoY+U+QYmDc+84OXEXnE+UtmXS75Lgm6x
	 MXJ3RjHkqHqeykxrBTo4tfHoC9UNZYNrwbGPuWZrXsvwJL7MWaBdbcmJFewG8c5qAu
	 lLh3fs7zqYeZVM6cnUG6//29/+25RQpg7ZE3tv3nXB3tl0c7yxKJy838Tam4MSEN6s
	 MSpY6Vlh1B0/g==
From: Danilo Krummrich <dakr@kernel.org>
To: lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	urezki@gmail.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/4] rust: drm: ensure kmalloc() compatible Layout
Date: Thu, 31 Jul 2025 17:48:07 +0200
Message-ID: <20250731154919.4132-3-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250731154919.4132-1-dakr@kernel.org>
References: <20250731154919.4132-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm::Device is allocated through __drm_dev_alloc() (which uses
kmalloc()) and the driver private data, <T as drm::Driver>::Data, is
initialized in-place.

Due to the order of fields in drm::Device

  pub struct Device<T: drm::Driver> {
     dev: Opaque<bindings::drm_device>,
     data: T::Data,
  }

even with an arbitrary large alignment requirement of T::Data it can't
happen that the size of Device is smaller than its alignment requirement.

However, let's not rely on this subtle circumstance and create a proper
kmalloc() compatible Layout.

Fixes: 1e4b8896c0f3 ("rust: drm: add device abstraction")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 3bb7c83966cf..d19410deaf6c 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -5,6 +5,7 @@
 //! C header: [`include/linux/drm/drm_device.h`](srctree/include/linux/drm/drm_device.h)
 
 use crate::{
+    alloc::allocator::Kmalloc,
     bindings, device, drm,
     drm::driver::AllocImpl,
     error::from_err_ptr,
@@ -12,7 +13,7 @@
     prelude::*,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
-use core::{mem, ops::Deref, ptr, ptr::NonNull};
+use core::{alloc::Layout, mem, ops::Deref, ptr, ptr::NonNull};
 
 #[cfg(CONFIG_DRM_LEGACY)]
 macro_rules! drm_legacy_fields {
@@ -96,6 +97,10 @@ impl<T: drm::Driver> Device<T> {
 
     /// Create a new `drm::Device` for a `drm::Driver`.
     pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<ARef<Self>> {
+        // `__drm_dev_alloc` uses `kmalloc()` to allocate memory, hence ensure a `kmalloc()`
+        // compatible `Layout`.
+        let layout = Kmalloc::aligned_layout(Layout::new::<Self>());
+
         // SAFETY:
         // - `VTABLE`, as a `const` is pinned to the read-only section of the compilation,
         // - `dev` is valid by its type invarants,
@@ -103,7 +108,7 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<A
             bindings::__drm_dev_alloc(
                 dev.as_raw(),
                 &Self::VTABLE,
-                mem::size_of::<Self>(),
+                layout.size(),
                 mem::offset_of!(Self, dev),
             )
         }
-- 
2.50.0


