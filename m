Return-Path: <linux-kernel+bounces-790078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C181B39F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881EEA0337C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56473148A7;
	Thu, 28 Aug 2025 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKFmqw4v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B113312801;
	Thu, 28 Aug 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388032; cv=none; b=fMoPDeojyqoet2aaM2kJahvCGth/0bsJSa3Wo6+D98gPFraIXwLFQ/nYhCQljOrh7ysepJSgf11wTn0gAUWfzPG39TADaNx6Ck0NtEUQIR0xp5llRNNwiWTHx4o+yXWyT0qw7CV6yVJeZkb7ztkzNuroKOdVcAv06hTsPwH2yWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388032; c=relaxed/simple;
	bh=VEhwm2ECodQvAWIjeH0MwqDVbP+hyzKhO930qjxxU1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQfw8V675D9Xt6ZG8SIZMiJdcWSHyPuJDoiGaBqCN9pCwfCNCE/Llwy+xVUXdFVqPs9nw6wu65GkJaYjq5wDH5ralXVakmNBXg1Lq0g5OG8q74CEmiIUe9v37/NZNVHUDmoYWspGJN4NBzJ5FTQftWcFflaO2bWMno1vZDFr4wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKFmqw4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE53C4CEEB;
	Thu, 28 Aug 2025 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756388031;
	bh=VEhwm2ECodQvAWIjeH0MwqDVbP+hyzKhO930qjxxU1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DKFmqw4vHZE3XIx4IzYfKMHP+tE7nV74nfHX6QUmksGkulG5Hf4D4SUcGuIoXxCbO
	 u3/9SoGDwdfE1dj1sQvhZqEdCm08XSER6Rspz3CvV5rb/cDUBue8AiiT0UTI7J9BFW
	 MwjpcyrHY8DE/CE04AZ0kvuaHbfRecJzzzTf1tNGVpcoOO0sr6QGzDR+yg2WlGz60a
	 jngBes+6Ca0otclavUZXmic8LDttT7uST2iko5URrjIA0PE+iTVCfm2d3rL4tMprnl
	 EWmciYqXvvJyTfhoq7F6TRfQTDKf3ZH7qwvrkaYPlOmqhKHXfbfatHZNtzDp2rg+dy
	 BUw5FMi0H4daA==
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
Subject: [PATCH v4 4/5] samples: rust: dma: add sample code for SGTable
Date: Thu, 28 Aug 2025 15:32:17 +0200
Message-ID: <20250828133323.53311-5-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828133323.53311-1-dakr@kernel.org>
References: <20250828133323.53311-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sample code for allocating and mapping a scatter-gather table
(`SGTable`).

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
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


