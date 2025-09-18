Return-Path: <linux-kernel+bounces-768535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E069B2623D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2BD47BC450
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A3530E856;
	Thu, 14 Aug 2025 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIx4Ac7c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E72FC887;
	Thu, 14 Aug 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166472; cv=none; b=jT//KAOSG5ZU4sfKdg0ryqQKM2Fs9H/rN1UPHgwCgZx1My4bVS6zYOtxZmrycAdvLs+EtkWLsfUwR+PFc4wroF7qDxPzvD1dET68Ymt5wPGd2OzsqLw9f5vU24ERQoPruQYAaKvkOedhQs8iaTac4Fe2S0heY4shHQCdr8DWdos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166472; c=relaxed/simple;
	bh=mumQPgsq9Kf0AWe0fgzmf/aTx7Jf080Kzh/1H2MDSvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDRuZosEzJFDnfqFaLdFE5oO6hDhtaqQwRRB9N+zC0+NXXRHaYoBJ1+qyWUo0t7LCtuawYrg6hcxQGGUuoyf4pVOBVKXYDFUfpsSGIfqk1yymIHrDaPHJhRb3hpAfQosWInwea9NZ3IqRxicOFAkoFZFPeypvUZVzhayelRbImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIx4Ac7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECBDC4CEF1;
	Thu, 14 Aug 2025 10:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755166471;
	bh=mumQPgsq9Kf0AWe0fgzmf/aTx7Jf080Kzh/1H2MDSvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIx4Ac7cVVjZ2Ed+hWctz60brK/KYnVbDuH2cXHHXv1TI0qojibPtsDYZzrfWS3rt
	 XNKPJRYTIpN/nYC7nh5uT19tgM7J4doyZ3A3BRZF5vytEFlIuLsGx9mE8jPxpptsC8
	 t6Qh1daRGxzJzrH79f5TmyZ1Xi+vzSQ/n+0mBF7NSVlH+IT1qDjnlNBd1CcLCU+Qy0
	 qZfWxUDHYILmp5QJV7kZaTc6PEaZa0dtAQMEAiq7gNZyhyDIddPmmu0cZHm2bFy7+3
	 idy44mZq3rLfAkQF3mSJMjMIrDJWBlZGI/bW1vX4BR3ZG+jLzolBP6WiaxvxWggedy
	 JAvdYPWErGE2w==
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
Subject: [PATCH v2 11/16] dma-mapping: export new dma_*map_phys() interface
Date: Thu, 14 Aug 2025 13:13:29 +0300
Message-ID: <a67057aad8bb4b700b8ce597e1a10152f1fac185.1755153054.git.leon@kernel.org>
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

Introduce new DMA mapping functions dma_map_phys() and dma_unmap_phys()
that operate directly on physical addresses instead of page+offset
parameters. This provides a more efficient interface for drivers that
already have physical addresses available.

The new functions are implemented as the primary mapping layer, with
the existing dma_map_page_attrs()/dma_map_resource() and
dma_unmap_page_attrs()/dma_unmap_resource() functions converted to simple
wrappers around the phys-based implementations.

In case dma_map_page_attrs(), the struct page is converted to physical
address with help of page_to_phys() function and dma_map_resource()
provides physical address as is together with addition of DMA_ATTR_MMIO
attribute.

The old page-based API is preserved in mapping.c to ensure that existing
code won't be affected by changing EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
variant for dma_*map_phys().

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c   | 14 --------
 include/linux/dma-direct.h  |  2 --
 include/linux/dma-mapping.h | 13 +++++++
 include/linux/iommu-dma.h   |  4 ---
 include/trace/events/dma.h  |  2 --
 kernel/dma/debug.c          | 43 -----------------------
 kernel/dma/debug.h          | 21 -----------
 kernel/dma/direct.c         | 16 ---------
 kernel/dma/mapping.c        | 69 ++++++++++++++++++++-----------------
 9 files changed, 50 insertions(+), 134 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 6804aaf034a1..7944a3af4545 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1556,20 +1556,6 @@ void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 		__iommu_dma_unmap(dev, start, end - start);
 }
 
-dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	return __iommu_dma_map(dev, phys, size,
-			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
-			dma_get_mask(dev));
-}
-
-void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	__iommu_dma_unmap(dev, handle, size);
-}
-
 static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 {
 	size_t alloc_size = PAGE_ALIGN(size);
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index f3bc0bcd7098..c249912456f9 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -149,7 +149,5 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 		struct page *page, dma_addr_t dma_addr,
 		enum dma_data_direction dir);
 int dma_direct_supported(struct device *dev, u64 mask);
-dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
 
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ead5514d389e..cebfbe237595 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -138,6 +138,10 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		unsigned long attrs);
 void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs);
+dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
+		enum dma_data_direction dir, unsigned long attrs);
+void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
+		enum dma_data_direction dir, unsigned long attrs);
 unsigned int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
 void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
@@ -192,6 +196,15 @@ static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 }
+static inline dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	return DMA_MAPPING_ERROR;
+}
+static inline void dma_unmap_phys(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+}
 static inline unsigned int dma_map_sg_attrs(struct device *dev,
 		struct scatterlist *sg, int nents, enum dma_data_direction dir,
 		unsigned long attrs)
diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
index 485bdffed988..a92b3ff9b934 100644
--- a/include/linux/iommu-dma.h
+++ b/include/linux/iommu-dma.h
@@ -42,10 +42,6 @@ size_t iommu_dma_opt_mapping_size(void);
 size_t iommu_dma_max_mapping_size(struct device *dev);
 void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t handle, unsigned long attrs);
-dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
-void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
 struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
 		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs);
 void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 84416c7d6bfa..5da59fd8121d 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -73,7 +73,6 @@ DEFINE_EVENT(dma_map, name, \
 	TP_ARGS(dev, phys_addr, dma_addr, size, dir, attrs))
 
 DEFINE_MAP_EVENT(dma_map_phys);
-DEFINE_MAP_EVENT(dma_map_resource);
 
 DECLARE_EVENT_CLASS(dma_unmap,
 	TP_PROTO(struct device *dev, dma_addr_t addr, size_t size,
@@ -111,7 +110,6 @@ DEFINE_EVENT(dma_unmap, name, \
 	TP_ARGS(dev, addr, size, dir, attrs))
 
 DEFINE_UNMAP_EVENT(dma_unmap_phys);
-DEFINE_UNMAP_EVENT(dma_unmap_resource);
 
 DECLARE_EVENT_CLASS(dma_alloc_class,
 	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index da6734e3a4ce..06e31fd216e3 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -38,7 +38,6 @@ enum {
 	dma_debug_single,
 	dma_debug_sg,
 	dma_debug_coherent,
-	dma_debug_resource,
 	dma_debug_phy,
 };
 
@@ -141,7 +140,6 @@ static const char *type2name[] = {
 	[dma_debug_single] = "single",
 	[dma_debug_sg] = "scatter-gather",
 	[dma_debug_coherent] = "coherent",
-	[dma_debug_resource] = "resource",
 	[dma_debug_phy] = "phy",
 };
 
@@ -1448,47 +1446,6 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 	check_unmap(&ref);
 }
 
-void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size_t size,
-			    int direction, dma_addr_t dma_addr,
-			    unsigned long attrs)
-{
-	struct dma_debug_entry *entry;
-
-	if (unlikely(dma_debug_disabled()))
-		return;
-
-	entry = dma_entry_alloc();
-	if (!entry)
-		return;
-
-	entry->type		= dma_debug_resource;
-	entry->dev		= dev;
-	entry->paddr		= addr;
-	entry->size		= size;
-	entry->dev_addr		= dma_addr;
-	entry->direction	= direction;
-	entry->map_err_type	= MAP_ERR_NOT_CHECKED;
-
-	add_dma_entry(entry, attrs);
-}
-
-void debug_dma_unmap_resource(struct device *dev, dma_addr_t dma_addr,
-			      size_t size, int direction)
-{
-	struct dma_debug_entry ref = {
-		.type           = dma_debug_resource,
-		.dev            = dev,
-		.dev_addr       = dma_addr,
-		.size           = size,
-		.direction      = direction,
-	};
-
-	if (unlikely(dma_debug_disabled()))
-		return;
-
-	check_unmap(&ref);
-}
-
 void debug_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 				   size_t size, int direction)
 {
diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
index 76adb42bffd5..424b8f912ade 100644
--- a/kernel/dma/debug.h
+++ b/kernel/dma/debug.h
@@ -30,14 +30,6 @@ extern void debug_dma_alloc_coherent(struct device *dev, size_t size,
 extern void debug_dma_free_coherent(struct device *dev, size_t size,
 				    void *virt, dma_addr_t addr);
 
-extern void debug_dma_map_resource(struct device *dev, phys_addr_t addr,
-				   size_t size, int direction,
-				   dma_addr_t dma_addr,
-				   unsigned long attrs);
-
-extern void debug_dma_unmap_resource(struct device *dev, dma_addr_t dma_addr,
-				     size_t size, int direction);
-
 extern void debug_dma_sync_single_for_cpu(struct device *dev,
 					  dma_addr_t dma_handle, size_t size,
 					  int direction);
@@ -88,19 +80,6 @@ static inline void debug_dma_free_coherent(struct device *dev, size_t size,
 {
 }
 
-static inline void debug_dma_map_resource(struct device *dev, phys_addr_t addr,
-					  size_t size, int direction,
-					  dma_addr_t dma_addr,
-					  unsigned long attrs)
-{
-}
-
-static inline void debug_dma_unmap_resource(struct device *dev,
-					    dma_addr_t dma_addr, size_t size,
-					    int direction)
-{
-}
-
 static inline void debug_dma_sync_single_for_cpu(struct device *dev,
 						 dma_addr_t dma_handle,
 						 size_t size, int direction)
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index fa75e3070073..1062caac47e7 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -502,22 +502,6 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	return ret;
 }
 
-dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	dma_addr_t dma_addr = paddr;
-
-	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
-		dev_err_once(dev,
-			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
-			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
-		WARN_ON_ONCE(1);
-		return DMA_MAPPING_ERROR;
-	}
-
-	return dma_addr;
-}
-
 int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 8725508a6c57..7e0e21a7ba04 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -152,12 +152,10 @@ static inline bool dma_map_direct(struct device *dev,
 	return dma_go_direct(dev, *dev->dma_mask, ops);
 }
 
-dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
-		size_t offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
+dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-	phys_addr_t phys = page_to_phys(page) + offset;
 	bool is_mmio = attrs & DMA_ATTR_MMIO;
 	dma_addr_t addr;
 
@@ -177,6 +175,9 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 
 		addr = ops->map_resource(dev, phys, size, dir, attrs);
 	} else {
+		struct page *page = phys_to_page(phys);
+		size_t offset = offset_in_page(phys);
+
 		/*
 		 * The dma_ops API contract for ops->map_page() requires
 		 * kmappable memory, while ops->map_resource() does not.
@@ -190,9 +191,26 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 
 	return addr;
 }
+EXPORT_SYMBOL_GPL(dma_map_phys);
+
+dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
+		size_t offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	phys_addr_t phys = page_to_phys(page) + offset;
+
+	if (unlikely(attrs & DMA_ATTR_MMIO))
+		return DMA_MAPPING_ERROR;
+
+	if (IS_ENABLED(CONFIG_DMA_API_DEBUG) &&
+	    WARN_ON_ONCE(is_zone_device_page(page)))
+		return DMA_MAPPING_ERROR;
+
+	return dma_map_phys(dev, phys, size, dir, attrs);
+}
 EXPORT_SYMBOL(dma_map_page_attrs);
 
-void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
+void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -212,6 +230,16 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 	trace_dma_unmap_phys(dev, addr, size, dir, attrs);
 	debug_dma_unmap_phys(dev, addr, size, dir);
 }
+EXPORT_SYMBOL_GPL(dma_unmap_phys);
+
+void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
+		 enum dma_data_direction dir, unsigned long attrs)
+{
+	if (unlikely(attrs & DMA_ATTR_MMIO))
+		return;
+
+	dma_unmap_phys(dev, addr, size, dir, attrs);
+}
 EXPORT_SYMBOL(dma_unmap_page_attrs);
 
 static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
@@ -337,41 +365,18 @@ EXPORT_SYMBOL(dma_unmap_sg_attrs);
 dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	dma_addr_t addr = DMA_MAPPING_ERROR;
-
-	BUG_ON(!valid_dma_direction(dir));
-
-	if (WARN_ON_ONCE(!dev->dma_mask))
+	if (IS_ENABLED(CONFIG_DMA_API_DEBUG) &&
+	    WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
 		return DMA_MAPPING_ERROR;
 
-	if (dma_map_direct(dev, ops))
-		addr = dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
-	else if (use_dma_iommu(dev))
-		addr = iommu_dma_map_resource(dev, phys_addr, size, dir, attrs);
-	else if (ops->map_resource)
-		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
-
-	trace_dma_map_resource(dev, phys_addr, addr, size, dir, attrs);
-	debug_dma_map_resource(dev, phys_addr, size, dir, addr, attrs);
-	return addr;
+	return dma_map_phys(dev, phys_addr, size, dir, attrs | DMA_ATTR_MMIO);
 }
 EXPORT_SYMBOL(dma_map_resource);
 
 void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (dma_map_direct(dev, ops))
-		; /* nothing to do: uncached and no swiotlb */
-	else if (use_dma_iommu(dev))
-		iommu_dma_unmap_resource(dev, addr, size, dir, attrs);
-	else if (ops->unmap_resource)
-		ops->unmap_resource(dev, addr, size, dir, attrs);
-	trace_dma_unmap_resource(dev, addr, size, dir, attrs);
-	debug_dma_unmap_resource(dev, addr, size, dir);
+	dma_unmap_phys(dev, addr, size, dir, attrs | DMA_ATTR_MMIO);
 }
 EXPORT_SYMBOL(dma_unmap_resource);
 
-- 
2.50.1


