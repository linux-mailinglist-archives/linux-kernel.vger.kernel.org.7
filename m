Return-Path: <linux-kernel+bounces-822969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AD7B852FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268A33A05A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0F0314B72;
	Thu, 18 Sep 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoVP/5b0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352E313D49;
	Thu, 18 Sep 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204626; cv=none; b=VZ7Gmt2hDPT12eIPmcJ2SQ9kdMChBgB2BgkQp0GXDO/7LMWM/B7r5E8WR2EhHNFOw/vZ5u5pAdt5o5HcE3uIJdv5ozEXM/4kMYfvST67Q+xz4S/fzPNpPfGAoVdWFjIQcewwf+ppQ2tLJrn6PpA06pPxe++E0VywjLNZZhqcYb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204626; c=relaxed/simple;
	bh=bCSF8Et7U2q9+qx5MPBbsnViuVi0S7sFmZruYcbRwJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMh3XYWwMNQRJdkbiiVrO0HIKEA8ShuynQTjt3qFckWDeCUg/wfIxV5lg+ea/+BHl/xm0JI9GGGbudGC8aDBasbDTy29whyIPOR1otNABnth4S0v/gorPJHlb7wrV/UvFDLbRFxObJnfiMZGNabnESVzARsRTXwPeJKqdKziC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoVP/5b0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A7EC4CEF7;
	Thu, 18 Sep 2025 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758204626;
	bh=bCSF8Et7U2q9+qx5MPBbsnViuVi0S7sFmZruYcbRwJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MoVP/5b00YLfpONB+ZmiTt6bw1i/Juohr4q/ZKYvTZpHSp5bkKkRXU1owc5fimxKL
	 JEsDthAvGnkY9ujXmwjpMkELIgpmXqCejwBzjtfW4bEYdBEZezMp0IR2njJfDh4MIq
	 EFMZGE46XQiSkNEHXSpjI6QbfiAqc/DFCOObBoepOtJrsVd4G4/AEUGxjSWA35zitw
	 M6HJlzy+fVyWwp1dW5gJnd5gnkbJesqSXTVbmS/ccfh45O28M1ujNm1IzqCUV/n7Bl
	 6RbWxO+0Fhu8b5bqS8lHfOr9GkMWNeIAwu0W/zlJWFX+FfnQowWK3ntA4XWemR8xyz
	 Qbh3YgOgpdY4g==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Stefano Stabellini <sstabellini@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v4 4/6] ARM: dma-mapping: Switch to physical address mapping callbacks
Date: Thu, 18 Sep 2025 17:09:27 +0300
Message-ID: <110f3bd0ad179b6a26cf236c3214818dbec6a723.1758203802.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758203802.git.leon@kernel.org>
References: <cover.1758203802.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Combine resource and page mappings routines to one function, which
handles both these flows at the same manner. This conversion allows
us to remove .map_resource/.unmap_resource callbacks completely.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 arch/arm/mm/dma-mapping.c | 100 +++++++++-----------------------------
 1 file changed, 23 insertions(+), 77 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 449fe6bf525e5..a6606ba0584f4 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -732,6 +732,9 @@ static int __dma_info_to_prot(enum dma_data_direction dir, unsigned long attrs)
 	if (attrs & DMA_ATTR_PRIVILEGED)
 		prot |= IOMMU_PRIV;
 
+	if (attrs & DMA_ATTR_MMIO)
+		prot |= IOMMU_MMIO;
+
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
 		return prot | IOMMU_READ | IOMMU_WRITE;
@@ -1350,25 +1353,27 @@ static void arm_iommu_sync_sg_for_device(struct device *dev,
 }
 
 /**
- * arm_iommu_map_page
+ * arm_iommu_map_phys
  * @dev: valid struct device pointer
- * @page: page that buffer resides in
- * @offset: offset into page for start of buffer
+ * @phys: physical address that buffer resides in
  * @size: size of buffer to map
  * @dir: DMA transfer direction
+ * @attrs: DMA mapping attributes
  *
  * IOMMU aware version of arm_dma_map_page()
  */
-static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
-	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     unsigned long attrs)
+static dma_addr_t arm_iommu_map_phys(struct device *dev, phys_addr_t phys,
+	     size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	int len = PAGE_ALIGN(size + offset_in_page(phys));
+	phys_addr_t addr = phys & PAGE_MASK;
 	dma_addr_t dma_addr;
-	int ret, prot, len = PAGE_ALIGN(size + offset);
+	int ret, prot;
 
-	if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		arch_sync_dma_for_device(page_to_phys(page), offset, size, dir);
+	if (!dev->dma_coherent &&
+	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
+		arch_sync_dma_for_device(phys, size, dir);
 
 	dma_addr = __alloc_iova(mapping, len);
 	if (dma_addr == DMA_MAPPING_ERROR)
@@ -1376,12 +1381,11 @@ static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
 
 	prot = __dma_info_to_prot(dir, attrs);
 
-	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len,
-			prot, GFP_KERNEL);
+	ret = iommu_map(mapping->domain, dma_addr, addr, len, prot, GFP_KERNEL);
 	if (ret < 0)
 		goto fail;
 
-	return dma_addr + offset;
+	return dma_addr + offset_in_page(phys);
 fail:
 	__free_iova(mapping, dma_addr, len);
 	return DMA_MAPPING_ERROR;
@@ -1393,10 +1397,11 @@ static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
  * @handle: DMA address of buffer
  * @size: size of buffer (same as passed to dma_map_page)
  * @dir: DMA transfer direction (same as passed to dma_map_page)
+ * @attrs: DMA mapping attributes
  *
- * IOMMU aware version of arm_dma_unmap_page()
+ * IOMMU aware version of arm_dma_unmap_phys()
  */
-static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
+static void arm_iommu_unmap_phys(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
@@ -1407,7 +1412,8 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 	if (!iova)
 		return;
 
-	if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
+	if (!dev->dma_coherent &&
+	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
 		phys_addr_t phys = iommu_iova_to_phys(mapping->domain, iova);
 
 		arch_sync_dma_for_cpu(phys + offset, size, dir);
@@ -1417,63 +1423,6 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 	__free_iova(mapping, iova, len);
 }
 
-/**
- * arm_iommu_map_resource - map a device resource for DMA
- * @dev: valid struct device pointer
- * @phys_addr: physical address of resource
- * @size: size of resource to map
- * @dir: DMA transfer direction
- */
-static dma_addr_t arm_iommu_map_resource(struct device *dev,
-		phys_addr_t phys_addr, size_t size,
-		enum dma_data_direction dir, unsigned long attrs)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-	dma_addr_t dma_addr;
-	int ret, prot;
-	phys_addr_t addr = phys_addr & PAGE_MASK;
-	unsigned int offset = phys_addr & ~PAGE_MASK;
-	size_t len = PAGE_ALIGN(size + offset);
-
-	dma_addr = __alloc_iova(mapping, len);
-	if (dma_addr == DMA_MAPPING_ERROR)
-		return dma_addr;
-
-	prot = __dma_info_to_prot(dir, attrs) | IOMMU_MMIO;
-
-	ret = iommu_map(mapping->domain, dma_addr, addr, len, prot, GFP_KERNEL);
-	if (ret < 0)
-		goto fail;
-
-	return dma_addr + offset;
-fail:
-	__free_iova(mapping, dma_addr, len);
-	return DMA_MAPPING_ERROR;
-}
-
-/**
- * arm_iommu_unmap_resource - unmap a device DMA resource
- * @dev: valid struct device pointer
- * @dma_handle: DMA address to resource
- * @size: size of resource to map
- * @dir: DMA transfer direction
- */
-static void arm_iommu_unmap_resource(struct device *dev, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-	dma_addr_t iova = dma_handle & PAGE_MASK;
-	unsigned int offset = dma_handle & ~PAGE_MASK;
-	size_t len = PAGE_ALIGN(size + offset);
-
-	if (!iova)
-		return;
-
-	iommu_unmap(mapping->domain, iova, len);
-	__free_iova(mapping, iova, len);
-}
-
 static void arm_iommu_sync_single_for_cpu(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
@@ -1510,8 +1459,8 @@ static const struct dma_map_ops iommu_ops = {
 	.mmap		= arm_iommu_mmap_attrs,
 	.get_sgtable	= arm_iommu_get_sgtable,
 
-	.map_page		= arm_iommu_map_page,
-	.unmap_page		= arm_iommu_unmap_page,
+	.map_phys		= arm_iommu_map_phys,
+	.unmap_phys		= arm_iommu_unmap_phys,
 	.sync_single_for_cpu	= arm_iommu_sync_single_for_cpu,
 	.sync_single_for_device	= arm_iommu_sync_single_for_device,
 
@@ -1519,9 +1468,6 @@ static const struct dma_map_ops iommu_ops = {
 	.unmap_sg		= arm_iommu_unmap_sg,
 	.sync_sg_for_cpu	= arm_iommu_sync_sg_for_cpu,
 	.sync_sg_for_device	= arm_iommu_sync_sg_for_device,
-
-	.map_resource		= arm_iommu_map_resource,
-	.unmap_resource		= arm_iommu_unmap_resource,
 };
 
 /**
-- 
2.51.0


