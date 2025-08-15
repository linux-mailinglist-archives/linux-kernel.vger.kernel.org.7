Return-Path: <linux-kernel+bounces-771256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324E9B284C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AEAA5E220A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8E2321436;
	Fri, 15 Aug 2025 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7+T4Iw9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2131814B;
	Fri, 15 Aug 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277874; cv=none; b=HBntlxAlZ4KGNL+GmF83s2b34Zh89mRfhNFDrI+mrx42upTK3wI5yw+wcuFYfjqPPRVLL5UyEVSJ8MG+G0rzIEdQ9BGozBijKdKT/GvxQ3/r9d5w1FCh6eoIgg/DcM8qaSsGGrKHtEfURAHJkpwfjdvnBuNE3jltAtVU9sezeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277874; c=relaxed/simple;
	bh=5GF/fPBri3zusHWMYumFRlNhCGJGYDbHoq1k0jnDBy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1Kg3QucpiVxrs1HS1OOADlrKUFFjXZIUFH999jF1jIUUZY5rE1A9CtwnR7YLn0EncoJF9qOjDmqTbaISC/ZeeAnWwFrnLKo5mSBHfPYWHlXCNAuWvSCPvmW2sOcqibYl+VukMGpVpiXfqS362tg0R0OHgSNjtf+uJL60DPl8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7+T4Iw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAD5C4CEF1;
	Fri, 15 Aug 2025 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755277874;
	bh=5GF/fPBri3zusHWMYumFRlNhCGJGYDbHoq1k0jnDBy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7+T4Iw9C0jUNglh534nlG6bA1LnmWp/y687grWwGYK2DPVCZdnf/PmXySdia6At3
	 +E6w8OpFhW554Rns/vDIrv65ozsiCb/8U1P+V6TScdRmaiGchIm6d0mpYakq/CaE1R
	 HZeWcK5vnUXqP+u9Mu5gvvVibipC+wDzOpMI7SKIucA/gzzStb+TzeBlOnfcWg7TAH
	 28xCIyDQLcNbvQYL+nnZ+MR4ZWrVEyop12glfvCvTkBk/3ilZe0b6EbUTMRGKJox+C
	 bpIeGiw/fnTy3OoPzXiOpbyQyvC2C9IA0JkXacKnm5Wj1YpTi+x3rv4/S+MZAxNtnc
	 yhMpNWsz2IVew==
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
Subject: [PATCH 1/4] rust: dma: implement DataDirection
Date: Fri, 15 Aug 2025 19:10:02 +0200
Message-ID: <20250815171058.299270-2-dakr@kernel.org>
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

Add the `DataDirection` struct, a newtype wrapper around the C
`enum dma_data_direction`.

This provides a type-safe Rust interface for specifying the direction of
DMA transfers.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/dma.rs              | 41 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

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
index 2bc8ab51ec28..b0950a2768a5 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -244,6 +244,47 @@ pub mod attrs {
     pub const DMA_ATTR_PRIVILEGED: Attrs = Attrs(bindings::DMA_ATTR_PRIVILEGED);
 }
 
+/// DMA data direction.
+///
+/// Corresponds to the C [`enum dma_data_direction`].
+///
+/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
+#[derive(Copy, Clone, PartialEq, Eq)]
+pub struct DataDirection(bindings::dma_data_direction);
+
+impl DataDirection {
+    /// The DMA mapping is for bidirectional data transfer.
+    ///
+    /// This is used when the buffer can be both read from and written to by the device.
+    /// The cache for the corresponding memory region is both flushed and invalidated.
+    pub const BIDIRECTIONAL: DataDirection =
+        DataDirection(bindings::dma_data_direction_DMA_BIDIRECTIONAL);
+
+    /// The DMA mapping is for data transfer from memory to the device (write).
+    ///
+    /// The CPU has prepared data in the buffer, and the device will read it.
+    /// The cache for the corresponding memory region is flushed.
+    pub const TO_DEVICE: DataDirection = DataDirection(bindings::dma_data_direction_DMA_TO_DEVICE);
+
+    /// The DMA mapping is for data transfer from the device to memory (read).
+    ///
+    /// The device will write data into the buffer for the CPU to read.
+    /// The cache for the corresponding memory region is invalidated before CPU access.
+    pub const FROM_DEVICE: DataDirection =
+        DataDirection(bindings::dma_data_direction_DMA_FROM_DEVICE);
+
+    /// The DMA mapping is not for data transfer.
+    ///
+    /// This is primarily for debugging purposes. With this direction, the DMA mapping API
+    /// will not perform any cache coherency operations.
+    pub const NONE: DataDirection = DataDirection(bindings::dma_data_direction_DMA_NONE);
+
+    /// Returns the raw representation of [`enum dma_data_direction`].
+    pub fn as_raw(self) -> bindings::dma_data_direction {
+        self.0
+    }
+}
+
 /// An abstraction of the `dma_alloc_coherent` API.
 ///
 /// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
-- 
2.50.1


