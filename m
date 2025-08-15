Return-Path: <linux-kernel+bounces-771259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D49B284C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E363EB67135
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684A5304BD5;
	Fri, 15 Aug 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6Lphe4A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A030E29C;
	Fri, 15 Aug 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277882; cv=none; b=SmbJPJQaNt4xrJnRkGNS76ucW1JZQBBiTSMWDKSb3JGmNITJovNLdi/MbN7+aHdzEIVRHm+/RSIxyKlLBL0+dB5IghVEi2CbNFso5Tdbni2GkOhHIPP3mGrKyd5ykcVGaE5XeJUW/YWTEZHsvshlxSG7rffBtT4uHTv9+V64aLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277882; c=relaxed/simple;
	bh=+sDeQRFDuVb5jpNfGn9781FGFQaIpiVLwwwtO/xBagA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQOr0CzoMLsK28BGLrZIiJTN2LgUfpXLl3DpUP6Nw2RFZCktBiZlxP5zfL5h1cPkmsi80hsrsB8BmTT9iL7DRA6SCwYsgJTsW9r7Xc2kHCqU+xA/rivy1SSvgKtjVYVhBUhMMkNHQTi0I21yDFgE24g4ftYlihBOya7VB73i1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6Lphe4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73ECC4CEF1;
	Fri, 15 Aug 2025 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755277882;
	bh=+sDeQRFDuVb5jpNfGn9781FGFQaIpiVLwwwtO/xBagA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6Lphe4AqkAgNWY61/ntJy4EKLWCOaHWYwtyuGh3VUe8HTAteMwg4JgQGEHXVoaN/
	 ZHD3B/PleVPegsCcGmHdFYHtNhTlzOTm33EBFKVhHFJnWvWf2v3NljL1c1mzpPEuaN
	 vSyb+AyNhFgvqxdmqGco1Y599BRgZ0h6IV+IW6Wor73OrAxRTQ7sRY0D82FIAz4tOj
	 UD9kF4v4+meQ9z3KozQGe1yL9QZ8Yb/mvM+aV+9ipHJX29FNnuVtV3QaNMUJ4IZIvc
	 FXwpCDZDQDddeOHsi31PXgXir+QyoQb79oa57xjpAuOnc2WJtrAnfvwFrP51vykLtC
	 vPCXOdIbIhdNQ==
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
Subject: [PATCH 3/4] samples: rust: dma: add sample code for SGTable
Date: Fri, 15 Aug 2025 19:10:04 +0200
Message-ID: <20250815171058.299270-4-dakr@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815171058.299270-1-dakr@kernel.org>
References: <20250815171058.299270-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sample code for allocating and mapping a scatter-gather table
(`SGTable`).

Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_dma.rs | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index c5e7cce68654..cc82327db0c2 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -7,15 +7,19 @@
 use kernel::{
     bindings,
     device::Core,
-    dma::{CoherentAllocation, Device, DmaMask},
-    pci,
+    dma::{CoherentAllocation, DataDirection, Device, DmaMask},
+    page, pci,
     prelude::*,
+    scatterlist::{Owned, SGTable},
     types::ARef,
 };
 
+#[pin_data(PinnedDrop)]
 struct DmaSampleDriver {
     pdev: ARef<pci::Device>,
     ca: CoherentAllocation<MyStruct>,
+    #[pin]
+    sgt: SGTable<Owned<VVec<u8>>>,
 }
 
 const TEST_VALUES: [(u32, u32); 5] = [
@@ -70,21 +74,30 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
             kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1))?;
         }
 
-        let drvdata = KBox::new(
-            Self {
+        let size = 4 * page::PAGE_SIZE;
+        let pages = VVec::with_capacity(size, GFP_KERNEL)?;
+
+        let sgt = SGTable::new(pdev.as_ref(), pages, DataDirection::TO_DEVICE, GFP_KERNEL);
+
+        let drvdata = KBox::pin_init(
+            try_pin_init!(Self {
                 pdev: pdev.into(),
                 ca,
-            },
+                sgt <- sgt,
+            }),
             GFP_KERNEL,
         )?;
 
-        Ok(drvdata.into())
+        Ok(drvdata)
     }
 }
 
-impl Drop for DmaSampleDriver {
-    fn drop(&mut self) {
-        dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
+#[pinned_drop]
+impl PinnedDrop for DmaSampleDriver {
+    fn drop(self: Pin<&mut Self>) {
+        let dev = self.pdev.as_ref();
+
+        dev_info!(dev, "Unload DMA test driver.\n");
 
         for (i, value) in TEST_VALUES.into_iter().enumerate() {
             let val0 = kernel::dma_read!(self.ca[i].h);
@@ -99,6 +112,10 @@ fn drop(&mut self) {
                 assert_eq!(val1, value.1);
             }
         }
+
+        for (i, entry) in self.sgt.into_iter().enumerate() {
+            dev_info!(dev, "Entry[{}]: DMA address: {:#x}", i, entry.dma_address());
+        }
     }
 }
 
-- 
2.50.1


