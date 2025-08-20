Return-Path: <linux-kernel+bounces-778222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C72EB2E2B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7276DA04F62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA42334715;
	Wed, 20 Aug 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am2GhER3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E132779F;
	Wed, 20 Aug 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708890; cv=none; b=jDIGg5jcXgj2Rvh6XCYr/wkDTN43RP7Da+tDq9HwTdhYuDImcxexBBDU9wDv4jdm75DZXleG/T9pd0vTh0hB7v8TqRLTUYA5kor/ADclnIMySSLzz/F0FkEtW6sNYozoRmOdpLNUww1l/0FYX7hKQkwj0D83dBUwPyTBiJZM1BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708890; c=relaxed/simple;
	bh=ZuG4V3x4Aoyo3VVzpfFRO87y1Z8MNkIM9ec01WX1rUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gdvt0JrCigzhAKkyLO4QTkkO/UHrEsvi+dcOermQ3cK6iUxKUJcSVUT31wyFMBN10mqHw3Fu1az9prC+r4nKlDqaggXMZsog8i4hj1NYpoarz4Khim/3w8/iZEE7ZeLpOdmF/9v0eSSajs2vHtksBjXeAj4maD+wu94d2X7nH2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am2GhER3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457ADC116B1;
	Wed, 20 Aug 2025 16:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755708889;
	bh=ZuG4V3x4Aoyo3VVzpfFRO87y1Z8MNkIM9ec01WX1rUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Am2GhER3GBoQMdaiqDqxSuhOeTsUUfhPgaoIk9+RXL/xfZOYx0BZQpECCAJP3UW9m
	 wAnz2T1xjj2E6UWtN/P9sQ3Wzv688fIi/TKAZ2rNacuNEMPOqJ1haytw4w52WZKZZz
	 LlNoqfvb63EWHkmF5HM92vRXVvJhhofsCGarPU0tj9qH/ad55gQjqLt+fMPfVChmlX
	 R/DlzFG3qDc4x62VuF4c3MMl6ZjcBtNJcWqnejRfENQl+06OcwAIh+S4Io6g+zn4ny
	 PM0bnyvGt8sHFeyGyIFHCP03XYtkF5fvOWnid6Rka6E4+M3d1xUOsmJ/R742aPxOGa
	 lR0u2eNvS7JZA==
From: Danilo Krummrich <dakr@kernel.org>
To: akpm@linux-foundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	abdiel.janulgue@gmail.com,
	acourbot@nvidia.com,
	jgg@ziepe.ca,
	lyude@redhat.com,
	robin.murphy@arm.com,
	daniel.almeida@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 1/5] rust: dma: implement DataDirection
Date: Wed, 20 Aug 2025 18:52:55 +0200
Message-ID: <20250820165431.170195-2-dakr@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820165431.170195-1-dakr@kernel.org>
References: <20250820165431.170195-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the `DataDirection` struct, a newtype wrapper around the C
`enum dma_data_direction`.

This provides a type-safe Rust interface for specifying the direction of
DMA transfers.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/dma.rs              | 68 +++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 0e140e07758b..c2cc52ee9945 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -47,6 +47,7 @@
 #include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/device/faux.h>
+#include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 2bc8ab51ec28..5daba00ecc78 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -244,6 +244,74 @@ pub mod attrs {
     pub const DMA_ATTR_PRIVILEGED: Attrs = Attrs(bindings::DMA_ATTR_PRIVILEGED);
 }
 
+/// DMA data direction.
+///
+/// Corresponds to the C [`enum dma_data_direction`].
+///
+/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
+#[derive(Copy, Clone, PartialEq, Eq, Debug)]
+#[repr(u32)]
+pub enum DataDirection {
+    /// The DMA mapping is for bidirectional data transfer.
+    ///
+    /// This is used when the buffer can be both read from and written to by the device.
+    /// The cache for the corresponding memory region is both flushed and invalidated.
+    Bidirectional = Self::const_cast(bindings::dma_data_direction_DMA_BIDIRECTIONAL),
+
+    /// The DMA mapping is for data transfer from memory to the device (write).
+    ///
+    /// The CPU has prepared data in the buffer, and the device will read it.
+    /// The cache for the corresponding memory region is flushed.
+    ToDevice = Self::const_cast(bindings::dma_data_direction_DMA_TO_DEVICE),
+
+    /// The DMA mapping is for data transfer from the device to memory (read).
+    ///
+    /// The device will write data into the buffer for the CPU to read.
+    /// The cache for the corresponding memory region is invalidated before CPU access.
+    FromDevice = Self::const_cast(bindings::dma_data_direction_DMA_FROM_DEVICE),
+
+    /// The DMA mapping is not for data transfer.
+    ///
+    /// This is primarily for debugging purposes. With this direction, the DMA mapping API
+    /// will not perform any cache coherency operations.
+    None = Self::const_cast(bindings::dma_data_direction_DMA_NONE),
+}
+
+impl DataDirection {
+    /// Casts the bindgen-generated enum type to a `u32` at compile time.
+    ///
+    /// This function will cause a compile-time error if the underlying value of the
+    /// C enum is out of bounds for `u32`.
+    const fn const_cast(val: bindings::dma_data_direction) -> u32 {
+        // CAST: The C standard allows compilers to choose different integer types for enums.
+        // To safely check the value, we cast it to a wide signed integer type (`i128`)
+        // which can hold any standard C integer enum type without truncation.
+        let wide_val = val as i128;
+
+        // Check if the value is outside the valid range for the target type `u32`.
+        // CAST: `u32::MAX` is cast to `i128` to match the type of `wide_val` for the comparison.
+        if wide_val < 0 || wide_val > u32::MAX as i128 {
+            // Trigger a compile-time error in a const context.
+            build_error!("C enum value is out of bounds for the target type `u32`.");
+        }
+
+        // CAST: This cast is valid because the check above guarantees that `wide_val`
+        // is within the representable range of `u32`.
+        wide_val as u32
+    }
+}
+
+impl From<DataDirection> for bindings::dma_data_direction {
+    /// Returns the raw representation of [`enum dma_data_direction`].
+    fn from(direction: DataDirection) -> Self {
+        // CAST: `direction as u32` gets the underlying representation of our `#[repr(u32)]` enum.
+        // The subsequent cast to `Self` (the bindgen type) assumes the C enum is compatible
+        // with the enum variants of `DataDirection`, which is a valid assumption given our
+        // compile-time checks.
+        direction as u32 as Self
+    }
+}
+
 /// An abstraction of the `dma_alloc_coherent` API.
 ///
 /// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
-- 
2.50.1


