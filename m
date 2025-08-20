Return-Path: <linux-kernel+bounces-778225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62732B2E2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D225D5A32DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BBD3375B4;
	Wed, 20 Aug 2025 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApIPPA1B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60537334396;
	Wed, 20 Aug 2025 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708901; cv=none; b=PfvYSzHI9/tg8WN4upmNLqFByuLgBj/9GiiHb7zsMsJu2WgBgnKFE/ka0FUlKeao/KPubgOIoDPZLY9Yiyu2XIxW6e87uzBAPcgN9PeZDEN5vUkzqKAj0+fxrmKDcX/H1Rtwm+1W/AnSoaGO70+tAi5sGNM5AMXbbBajVdD80t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708901; c=relaxed/simple;
	bh=Yx9Wgg0SaERfu9zSvQZiIsZcKR+loSpfb1dF/VURoFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eK7eI/f52Fu+QTdPae6ft+lqsITa+EWi/RofD/GVLDT7thMzByxOJZDoLgnvwSz1kydJtVT9XJJcRkXt0jKPogH4axJbbO+ue9OplpSbwu0eA8voeoCJR+k5ZgU1iOxHmTXZg2JV57/WGUUs4JbpWT8oe6EVvCWYlRf/OjjA+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApIPPA1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE88BC113CF;
	Wed, 20 Aug 2025 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755708901;
	bh=Yx9Wgg0SaERfu9zSvQZiIsZcKR+loSpfb1dF/VURoFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApIPPA1BtKS4eaNV9cjXGrRhCdWnvDrg4jxyQ18Jp8sjCoM0wB3u2P83TtnrbpvbO
	 oL2MAMB7xYcbC5tb53nvIr2/xl/ayWrKHwtRwsIxRT3wrpVntkic7LdFQ7vS+cToBZ
	 hYflUkA8AZZRHCelNC6ASO5ZfdViHhlKATbNNvdIyVBHBa4r1FG7niEDSJt7uSLqj9
	 9vU5JkouhWkFPaFaQdnoRtgyVJeZoT1tbYXIT67yJviiG6CumIhbcUeVJWLy4NSaT9
	 JMLmHNPOmOaW/xo8lZ2Zm+CyFe1hOEpYLueafWdi0d/bjqMri08Z+ITlTlxV1HJBIE
	 ccOBSJTHtlygA==
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
Subject: [PATCH v2 4/5] samples: rust: dma: add sample code for SGTable
Date: Wed, 20 Aug 2025 18:52:58 +0200
Message-ID: <20250820165431.170195-5-dakr@kernel.org>
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

Add sample code for allocating and mapping a scatter-gather table
(`SGTable`).

Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_dma.rs | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index c5e7cce68654..d9532bef6d2c 100644
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
+        let sgt = SGTable::new(pdev.as_ref(), pages, DataDirection::ToDevice, GFP_KERNEL);
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


