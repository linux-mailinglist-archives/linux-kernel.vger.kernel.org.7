Return-Path: <linux-kernel+bounces-752333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33457B17428
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB4B16027C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDF121FF40;
	Thu, 31 Jul 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/X/JNrt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECFF1F30B2;
	Thu, 31 Jul 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976991; cv=none; b=M+tmv5WznujijSz0Cehmycy/olggA0A9Z/Jxzu7tG9B7u2SUByyx1S6AJUDIBBTYzbwUAoZ5zvi7Jkb5xFkKeyW1YNJoqI5oC0JA/r1AAE0jmfFo4/eV0z2KHhgP3JlaUB24k7CbA393aNNO9G3OrLRW4Z/6cY7rYFrfxSbm5h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976991; c=relaxed/simple;
	bh=TRPn+DgynwTBU4suc4xP+QjfUEO+i9ltjPYhmhrkr2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqhp6QRtSSNiPrKJPgumZJv+gOnp1Vy3tTqWpIoDbRxPo6ZD+HjnxvQ0T8eLghakBGnW4N7gcaxTvglnSNUMW7qXDQkrWyT5VidnduIbAe0hoIkDzR5GkWEAmhpsz4XDXLIIdOucUucflFZhneGlXNat9kqKTnej9EQ5DYP8SUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/X/JNrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20FCC4CEF7;
	Thu, 31 Jul 2025 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753976991;
	bh=TRPn+DgynwTBU4suc4xP+QjfUEO+i9ltjPYhmhrkr2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/X/JNrtyFakbTS/O9iOKZ67QuJWdk2GrjRdWBqwrDqXwaiu2XP315wrn0r0Z7bBY
	 UUPrHbbI2WuDp6O0ej47Bxii1HSJW7FKIYKQTuB7tSmfB/SIwnRpAUb3zVam9ibvQ4
	 mQR02O6FWGqKnPce2tJPaxVy14al1kNBVFaP2f4O6gH8Sheg2zlVb8/p4j64G9Byqx
	 BocWeAFMemBYxQ99Ju4Sq5UTSJg8deTAkU7kTr3tlEpKrte3IzPFD1XXcDI955jsTm
	 1l0+ifKC7nsak++M9SE0fkaRB7svvRG8+GXEchuaHrs7ASH7lhektT3SUjeftJQx6G
	 Q9IUshOilxNaA==
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
Subject: [PATCH 4/4] rust: drm: don't pass the address of drm::Device to drm_dev_put()
Date: Thu, 31 Jul 2025 17:48:09 +0200
Message-ID: <20250731154919.4132-5-dakr@kernel.org>
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

In drm_dev_put() call in AlwaysRefCounted::dec_ref() we rely on struct
drm_device to be the first field in drm::Device, whereas everywhere
else we correctly obtain the address of the actual struct drm_device.

Analogous to the from_drm_device() helper, provide the
into_drm_device() helper in order to address this.

Fixes: 1e4b8896c0f3 ("rust: drm: add device abstraction")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index d0a9528121f1..d29c477e89a8 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -120,9 +120,13 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<A
         // - `raw_data` is a valid pointer to uninitialized memory.
         // - `raw_data` will not move until it is dropped.
         unsafe { data.__pinned_init(raw_data) }.inspect_err(|_| {
-            // SAFETY: `__drm_dev_alloc()` was successful, hence `raw_drm` must be valid and the
+            // SAFETY: `raw_drm` is a valid pointer to `Self`, given that `__drm_dev_alloc` was
+            // successful.
+            let drm_dev = unsafe { Self::into_drm_device(raw_drm) };
+
+            // SAFETY: `__drm_dev_alloc()` was successful, hence `drm_dev` must be valid and the
             // refcount must be non-zero.
-            unsafe { bindings::drm_dev_put(ptr::addr_of_mut!((*raw_drm.as_ptr()).dev).cast()) };
+            unsafe { bindings::drm_dev_put(drm_dev) };
         })?;
 
         // SAFETY: The reference count is one, and now we take ownership of that reference as a
@@ -143,6 +147,14 @@ unsafe fn from_drm_device(ptr: *const bindings::drm_device) -> *mut Self {
         unsafe { crate::container_of!(Opaque::cast_from(ptr), Self, dev) }.cast_mut()
     }
 
+    /// # Safety
+    ///
+    /// `ptr` must be a valid pointer to `Self`.
+    unsafe fn into_drm_device(ptr: NonNull<Self>) -> *mut bindings::drm_device {
+        // SAFETY: By the safety requirements of this function, `ptr` is a valid pointer to `Self`.
+        unsafe { &raw mut (*ptr.as_ptr()).dev }.cast()
+    }
+
     /// Not intended to be called externally, except via declare_drm_ioctls!()
     ///
     /// # Safety
@@ -192,8 +204,11 @@ fn inc_ref(&self) {
     }
 
     unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: `obj` is a valid pointer to `Self`.
+        let drm_dev = unsafe { Self::into_drm_device(obj) };
+
         // SAFETY: The safety requirements guarantee that the refcount is non-zero.
-        unsafe { bindings::drm_dev_put(obj.cast().as_ptr()) };
+        unsafe { bindings::drm_dev_put(drm_dev) };
     }
 }
 
-- 
2.50.0


