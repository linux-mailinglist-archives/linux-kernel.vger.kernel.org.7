Return-Path: <linux-kernel+bounces-768526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9F0B26219
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8597F5A0F00
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C382F83B6;
	Thu, 14 Aug 2025 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJnTdVoA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45452BF009;
	Thu, 14 Aug 2025 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166440; cv=none; b=N5P1Ms5VMfG9pbPbBkzIqIvcbGXsJ5/4tF7EIr3WnhLt0sJ8zD87jvnMo6hOAALk/Tj9yNqHDsU6m2Xb3U8jCDjz1k58mpjF52lP3u51p1B7RHkbSHPl0GIo35ZUHUWVN4aMN5sva0o0j7YkTgZSIOuRD51UOR690hFP4TJE5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166440; c=relaxed/simple;
	bh=20hTY/Bpuo8LaRouoti+FqOb/uYNdZEkCPYgzhSUTHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nufKmAPHcwdL07A+kcx5ss9SHXe2hLUqXgOPGRz1C1vaXFLIoZKtDdSAZs9HLfAA/Hm9GpoPgS1HVPYNtO54mltaL/K9+HfRbI1EBp1B1NcHaq5Zebr7IHPhe3hCj3EMXTKb1C99c+7aQTWvip4ITV5ps5vdnk6XFpXDVy0EWMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJnTdVoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CB7C4CEED;
	Thu, 14 Aug 2025 10:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755166438;
	bh=20hTY/Bpuo8LaRouoti+FqOb/uYNdZEkCPYgzhSUTHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJnTdVoAAfN+/Xmg0sENmXfmecar7mR18tZJR2Bssi/yKcCFsAqfqd8yIy8d6+7T0
	 4cpGu3Nev5L57PEt//45pHdIh1Lpgnsn3eKqfNvyldstATPdrx9y+2/wvt8O1xOqYx
	 0TARiCfmcQFlgM0m24ah0By4BQ8/wzSRKeUT8fci1OYqIQCC9JFc5UOL7W2TCrSXfR
	 vjl32GDpJ+pmD1jY1ixOBoax/KXXLxrXKqp77CRTekhWEwW+gmg/C8r27lcyIl4yD4
	 CLA6A8gMmOrf5aBfQnCOLLhuuCdEKTsxzAwuGVvNkUYlC0V8TNUlpNK6i0NxDGLSyW
	 EVsttayqq2y3g==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nvme@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v2 01/16] dma-mapping: introduce new DMA attribute to indicate MMIO memory
Date: Thu, 14 Aug 2025 13:13:19 +0300
Message-ID: <f832644c76e13de504ecf03450fd5d125f72f4c6.1755153054.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755153054.git.leon@kernel.org>
References: <cover.1755153054.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

This patch introduces the DMA_ATTR_MMIO attribute to mark DMA buffers
that reside in memory-mapped I/O (MMIO) regions, such as device BARs
exposed through the host bridge, which are accessible for peer-to-peer
(P2P) DMA.

This attribute is especially useful for exporting device memory to other
devices for DMA without CPU involvement, and avoids unnecessary or
potentially detrimental CPU cache maintenance calls.

DMA_ATTR_MMIO is supposed to provide dma_map_resource() functionality
without need to call to special function and perform branching by
the callers.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/core-api/dma-attributes.rst | 18 ++++++++++++++++++
 include/linux/dma-mapping.h               | 20 ++++++++++++++++++++
 include/trace/events/dma.h                |  3 ++-
 rust/kernel/dma.rs                        |  3 +++
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 1887d92e8e92..58a1528a9bb9 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -130,3 +130,21 @@ accesses to DMA buffers in both privileged "supervisor" and unprivileged
 subsystem that the buffer is fully accessible at the elevated privilege
 level (and ideally inaccessible or at least read-only at the
 lesser-privileged levels).
+
+DMA_ATTR_MMIO
+-------------
+
+This attribute indicates the physical address is not normal system
+memory. It may not be used with kmap*()/phys_to_virt()/phys_to_page()
+functions, it may not be cachable, and access using CPU load/store
+instructions may not be allowed.
+
+Usually this will be used to describe MMIO addresses, or other non
+cachable register addresses. When DMA mapping this sort of address we
+call the operation Peer to Peer as a one device is DMA'ing to another
+device. For PCI devices the p2pdma APIs must be used to determine if
+DMA_ATTR_MMIO is appropriate.
+
+For architectures that require cache flushing for DMA coherence
+DMA_ATTR_MMIO will not perform any cache flushing. The address
+provided must never be mapped cachable into the CPU.
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 55c03e5fe8cb..ead5514d389e 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -58,6 +58,26 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_MMIO - Indicates memory-mapped I/O (MMIO) region for DMA mapping
+ *
+ * This attribute indicates the physical address is not normal system
+ * memory. It may not be used with kmap*()/phys_to_virt()/phys_to_page()
+ * functions, it may not be cachable, and access using CPU load/store
+ * instructions may not be allowed.
+ *
+ * Usually this will be used to describe MMIO addresses, or other non
+ * cachable register addresses. When DMA mapping this sort of address we
+ * call the operation Peer to Peer as a one device is DMA'ing to another
+ * device. For PCI devices the p2pdma APIs must be used to determine if
+ * DMA_ATTR_MMIO is appropriate.
+ *
+ * For architectures that require cache flushing for DMA coherence
+ * DMA_ATTR_MMIO will not perform any cache flushing. The address
+ * provided must never be mapped cachable into the CPU.
+ */
+#define DMA_ATTR_MMIO		(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index d8ddc27b6a7c..ee90d6f1dcf3 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -31,7 +31,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
 		{ DMA_ATTR_FORCE_CONTIGUOUS, "FORCE_CONTIGUOUS" }, \
 		{ DMA_ATTR_ALLOC_SINGLE_PAGES, "ALLOC_SINGLE_PAGES" }, \
 		{ DMA_ATTR_NO_WARN, "NO_WARN" }, \
-		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" })
+		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
+		{ DMA_ATTR_MMIO, "MMIO" })
 
 DECLARE_EVENT_CLASS(dma_map,
 	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 2bc8ab51ec28..61d9eed7a786 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -242,6 +242,9 @@ pub mod attrs {
     /// Indicates that the buffer is fully accessible at an elevated privilege level (and
     /// ideally inaccessible or at least read-only at lesser-privileged levels).
     pub const DMA_ATTR_PRIVILEGED: Attrs = Attrs(bindings::DMA_ATTR_PRIVILEGED);
+
+    /// Indicates that the buffer is MMIO memory.
+    pub const DMA_ATTR_MMIO: Attrs = Attrs(bindings::DMA_ATTR_MMIO);
 }
 
 /// An abstraction of the `dma_alloc_coherent` API.
-- 
2.50.1


