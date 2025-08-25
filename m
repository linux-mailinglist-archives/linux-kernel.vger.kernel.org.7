Return-Path: <linux-kernel+bounces-784752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AFCB340A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C44A5E134C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E341C278754;
	Mon, 25 Aug 2025 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZyi7xes"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427BE277CAF;
	Mon, 25 Aug 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128366; cv=none; b=rdMpHcG5AbEtJAVmHEgfiD8QozRD/hEScm8EqRft+JDQOmH7yO7QBMJVCzuYgvfNRPg9KCf85pnC0Yb8LRlC9fdftZzsNXQK31MtIGFWfpscmkEC0s8SepfUqNjHgufBc3JJO4Cf8SgQgA/zf3AMGMYz6HjkF/Bll3KIdJMeAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128366; c=relaxed/simple;
	bh=SJh5t8S3nGrnslvyfeBojfqqKV9PCASWSn3mgBhpZZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCC3AqtM4fssnnp2VymJZtn9kWm3R7YoGsdIgOSs1c0QijaAftMEzaY479o/62Ev8rlfOEomQpDnES9/jZ/BcE7264IVT+04M2tLNlSFoXO0e34xaGVMsxU9IDfjtTVChl+/SuuBX/Ky04AK8wZjog3HEAtYVUrweOQyF1cQPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZyi7xes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFB0C113D0;
	Mon, 25 Aug 2025 13:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128365;
	bh=SJh5t8S3nGrnslvyfeBojfqqKV9PCASWSn3mgBhpZZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZyi7xes+Bcn7ilguHlnSH6ReNnQ4aLB6OVj7qoUxc8XTAx/GH5sWAJozC4+U/SoT
	 2fQJYdhbQYnxVcIqZE0XRGZEzzuPA5z4ukT+LgEJV93eajJeLJIk6WJa0tnPMs0ARo
	 94d6wET5Sh3C21+SeUrTwUcc2N9PjM2HzGUQqfGhnK+gOcmwCC1QB22pQoPynbJItt
	 NHvQvsYyHVagPHROFBbNZa27gVEam4IAjIfHZ00vn2uH5+RWfV7NvgeavRLmtOanls
	 M7v1T0awdrSQzJZ98F3SK34QYpOcBcxt9fbROFscILn72PaQSqLtO0I4rLT/yyNwdC
	 nB3FZphU1WsEw==
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
Subject: [PATCH v3 4/5] samples: rust: dma: add sample code for SGTable
Date: Mon, 25 Aug 2025 15:24:43 +0200
Message-ID: <20250825132539.122412-5-dakr@kernel.org>
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

Add sample code for allocating and mapping a scatter-gather table
(`SGTable`).

Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_dma.rs | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index c5e7cce68654..04007e29fd85 100644
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
+        for (i, entry) in self.sgt.iter().enumerate() {
+            dev_info!(dev, "Entry[{}]: DMA address: {:#x}", i, entry.dma_address());
+        }
     }
 }
 
-- 
2.51.0


