Return-Path: <linux-kernel+bounces-784750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E50B340A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDBC1A850E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D32276020;
	Mon, 25 Aug 2025 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVi/+NOa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F6274FEF;
	Mon, 25 Aug 2025 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128358; cv=none; b=uT8DGaMWKffLLrXGrN9KnITlHJdyFOXmbJdKnbqoOPxr4VfEExzXFWka7FS4CK4FUkwd+5j3SfoEbWf/R1UCeylYpv2TWfEV3/9AKD8U8TpvrXuLTkTnYsLvzhNYVYqzmQj/vxrM68VWJXm6hZ8xBUjHCr5ghn2ZTZm/LrezsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128358; c=relaxed/simple;
	bh=A3L0Nwe0/dbduzO9gX/IxMSFwYiKAMDTLYKwRVn49xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdyGI+Ja1NhlAU2v8BluNZU9fjbBaCwmSH7rJQkXePBppRanXR+EML6XXRYHMLY8GwVTTCIFUEYu5gHeoDjcBck2PD8z8jwAmGgvoydIouXMalGsqpIh23wgvccJoWr4hoIXWbzz/g8Zn0dKczfKrMCvkhoStsDlchbgTYAdLXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVi/+NOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C543AC4CEED;
	Mon, 25 Aug 2025 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128358;
	bh=A3L0Nwe0/dbduzO9gX/IxMSFwYiKAMDTLYKwRVn49xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cVi/+NOaxUVCkFSRXU/63mm/BBVqoke+aWXYjTlNh34qBMGopiUcFyK3vWTizgrVr
	 HLnrrdUuKVoJkfQl9EZpZPO4No0lZF3ToEmd6GoaBLEXvW51Xg9xWBfCTBxNvzJq04
	 5iGiceyrHGc3PqdxNKmy+VDBqkiVugAxLNjoHqRnFjiXTn/w7gopXzb33Xta/FytA+
	 D9OZdpZiM4cSDJVIBcW3+pAaQGFY6tiQ6Y+WvH8UXd4oCy61lm9hnYgDDE4fNrAulY
	 JhrAJGbbVpMr9WXssnSiUynN+J7vVakORY+4I3qcmv4O5Q/NjdTSIl+UzeAauegu5d
	 tgScsjdFuVdBA==
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
Subject: [PATCH v3 2/5] rust: dma: add type alias for bindings::dma_addr_t
Date: Mon, 25 Aug 2025 15:24:41 +0200
Message-ID: <20250825132539.122412-3-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250825132539.122412-1-dakr@kernel.org>
References: <20250825132539.122412-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a type alias for bindings::dma_addr_t (DmaAddress), such that we do
not have to access bindings directly.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
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
index 27b25f041f32..b2a6282876da 100644
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
2.51.0


