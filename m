Return-Path: <linux-kernel+bounces-778223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBDFB2E2B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C4D5A582F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF1433472E;
	Wed, 20 Aug 2025 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li4ycH6B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37B132779F;
	Wed, 20 Aug 2025 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708894; cv=none; b=A5aCkrnn9CK1A8k2f4qxsk/kouohgj0CSIy4qQXYJ2NXPpjs8cUCFh2x3Depxqjr6Dg6A5vA3V3R5fry+jRrO7gvLBahg0WKJRrBBFj2b/LCq4ZQ70/o6oGiw1KBBs29l8itkDj5mMB4NIqY6pn0NTQJwEYRcClR9YFm00jKgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708894; c=relaxed/simple;
	bh=Qj2E/WTXs6WxEg2by2OuQniXuAmpDlTnHOyvcPjbGcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzKkYX5L9jwcosLnJXRsHM+DmcW+6jU11+DPIMqW4itpQYH3RZBXnbsMdKwtpCfKu67chcQVbFOLTKMFZIB5a/85ooM6BcCnNwAUHapF+QCEpRn4W5NnkXiUD53bGgFwK54smBv7nqlwwdWYyEqsx7ekf7OGEAfL4+JpfphCr78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li4ycH6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219DBC113CF;
	Wed, 20 Aug 2025 16:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755708893;
	bh=Qj2E/WTXs6WxEg2by2OuQniXuAmpDlTnHOyvcPjbGcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Li4ycH6BioKqXd6KQLw/2yt70VbK2MCnxvNaPjfpmEigsrDRASJrP+paorDY9863x
	 m3iCl3MEgS1k4jYc9OSJxyATYgaddiKKXjSlVUMe/kE2Tda5xzjxj6Xyq3l6RgqWc0
	 4D/QfLiolWv+ObqaMUsUm0SuWyYjj1HwDAOiT9KEfcg+A5YnzDVBn+zlRFTKftJ7T5
	 lwYRw8JcVuWhJeOPVcfEW1pZKm5GJfnhvR4tinqWQVXDwyYhPz5FIUjoJhK+4ClHWn
	 MCiPu3f+2UaJFrrM1G6739cCfTqYs/6z0UUpgsTeXRet+o3q+OmNWYiUtCWhdbCPPh
	 G8olDxWKDvJgQ==
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
Subject: [PATCH v2 2/5] rust: dma: add type alias for bindings::dma_addr_t
Date: Wed, 20 Aug 2025 18:52:56 +0200
Message-ID: <20250820165431.170195-3-dakr@kernel.org>
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

Add a type alias for bindings::dma_addr_t (DmaAddress), such that we do
not have to access bindings directly.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/falcon.rs |  4 ++--
 rust/kernel/dma.rs              | 18 ++++++++++++++----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 50437c67c14a..aa36ed8c04ed 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -4,8 +4,8 @@
 
 use core::ops::Deref;
 use hal::FalconHal;
-use kernel::bindings;
 use kernel::device;
+use kernel::dma::DmaAddress;
 use kernel::prelude::*;
 use kernel::time::Delta;
 use kernel::types::ARef;
@@ -443,7 +443,7 @@ fn dma_wr<F: FalconFirmware<Target = E>>(
                 fw.dma_handle_with_offset(load_offsets.src_start as usize)?,
             ),
         };
-        if dma_start % bindings::dma_addr_t::from(DMA_LEN) > 0 {
+        if dma_start % DmaAddress::from(DMA_LEN) > 0 {
             dev_err!(
                 self.dev,
                 "DMA transfer start addresses must be a multiple of {}",
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 5daba00ecc78..ceb215f80049 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -13,6 +13,16 @@
     types::ARef,
 };
 
+/// DMA address type.
+///
+/// Represents a bus address used for Direct Memory Access (DMA) operations.
+///
+/// This is an alias of the kernel's `dma_addr_t`, which may be `u32` or `u64` depending on
+/// `CONFIG_ARCH_DMA_ADDR_T_64BIT`.
+///
+/// Note that this may be `u64` even on 32-bit architectures.
+pub type DmaAddress = bindings::dma_addr_t;
+
 /// Trait to be implemented by DMA capable bus devices.
 ///
 /// The [`dma::Device`](Device) trait should be implemented by bus specific device representations,
@@ -343,7 +353,7 @@ fn from(direction: DataDirection) -> Self {
 // entire `CoherentAllocation` including the allocated memory itself.
 pub struct CoherentAllocation<T: AsBytes + FromBytes> {
     dev: ARef<device::Device>,
-    dma_handle: bindings::dma_addr_t,
+    dma_handle: DmaAddress,
     count: usize,
     cpu_addr: *mut T,
     dma_attrs: Attrs,
@@ -444,7 +454,7 @@ pub fn start_ptr_mut(&mut self) -> *mut T {
 
     /// Returns a DMA handle which may be given to the device as the DMA address base of
     /// the region.
-    pub fn dma_handle(&self) -> bindings::dma_addr_t {
+    pub fn dma_handle(&self) -> DmaAddress {
         self.dma_handle
     }
 
@@ -452,13 +462,13 @@ pub fn dma_handle(&self) -> bindings::dma_addr_t {
     /// device as the DMA address base of the region.
     ///
     /// Returns `EINVAL` if `offset` is not within the bounds of the allocation.
-    pub fn dma_handle_with_offset(&self, offset: usize) -> Result<bindings::dma_addr_t> {
+    pub fn dma_handle_with_offset(&self, offset: usize) -> Result<DmaAddress> {
         if offset >= self.count {
             Err(EINVAL)
         } else {
             // INVARIANT: The type invariant of `Self` guarantees that `size_of::<T> * count` fits
             // into a `usize`, and `offset` is inferior to `count`.
-            Ok(self.dma_handle + (offset * core::mem::size_of::<T>()) as bindings::dma_addr_t)
+            Ok(self.dma_handle + (offset * core::mem::size_of::<T>()) as DmaAddress)
         }
     }
 
-- 
2.50.1


