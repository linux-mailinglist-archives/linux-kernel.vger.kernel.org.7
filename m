Return-Path: <linux-kernel+bounces-838344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CE2BAF004
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4C94A2C00
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFEE27B50C;
	Wed,  1 Oct 2025 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="REyEARYV"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5327B359
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759285311; cv=pass; b=DXNmlFrH46dDBc++5kpBRvCn6QVn0umDdpcF6Q/rXPCsbfwtcCuLQ6YwzJL9k5igQDKPjJ2UTjSW8cckxniWFKBJ25ND4Nb0BkzeY+8ReAL3s9S0p5Tgr7wDZFm3DuecXzhLFrW/vS0N6ZG4MaHqOBmSB/QkONcx7Vnpn95SmEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759285311; c=relaxed/simple;
	bh=PMeJfcvM2/X/EeO2r2NJayX/dMuXfj7jYnmUxHe6cmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvVWw1BIBSMPsSLm3jQW7ky6Zq4cOx9bBsTrGXSzqTg7WhJqPQzJhGapu6TjK6SsXDNuVx1U+/waH8L0dvmO3rF3MdyNFgy9ysjD5aUXC+eEEYUufhx+3AkpnzZJkr7fMJ2n+T46CXYeKfRzyIUulYZbqfjGhdpS3r35AvgDDd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=REyEARYV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759285290; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BPN58vPowx6SXszx0UkRnZuH6VqNqXnI/7JrHeIIdbWVezhNlk4g41cvRga0UMFvUlnm5Or/3ZJSicakXuLBMv97uBM3YMlTB6cSQ9YF2ZirrG3MnLMpcEcnIMr0QVM55lP9i0Djo9Rd2bhRm8Yqig5kePbjCEH7JmISBzsOJsc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759285290; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pVFlY6Bf+eKYXYw1L1WHcvUwPfuT3+o+YA4v3iBOCPM=; 
	b=Y1eYUdTG3y3EJGIWQnM9ldpatWwHHVeok5cnbyV+V1eSAsu9vF2GsPYahx64AFMWOGZU2S+4mE2kFFaWbmpS8pNZjKonAf6CeVWP/eraCygT9sW8ccIqb2oOidPahwQxCq5plDAK1/RyxsNoomoL+hzT3zWjJXgo1uTfRj2llR0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759285290;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pVFlY6Bf+eKYXYw1L1WHcvUwPfuT3+o+YA4v3iBOCPM=;
	b=REyEARYVrIT8Gh2HjZuW1II8HwqRiPwNMHNurRVNoeorkjrLoojYxQpVWXyFrAs2
	lR72v5oifksdLJxBDrwPKoDpvpsSMWQzgq8FxLREXFFW+Ox+wex4pRvTJc+M5J9J8ih
	+c96ZBe14e407j/u756u0hy+YARUV5U8Lj3p9npY=
Received: by mx.zohomail.com with SMTPS id 1759285289648850.8594329188137;
	Tue, 30 Sep 2025 19:21:29 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v4 05/10] drm/panfrost: Handle page mapping failure
Date: Wed,  1 Oct 2025 03:20:26 +0100
Message-ID: <20251001022039.1215976-6-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001022039.1215976-1-adrian.larumbe@collabora.com>
References: <20251001022039.1215976-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When mapping the pages of a BO, either a heap type at page fault time or
else a non-heap BO at object creation time, if the ARM page table mapping
function fails, we unmap what had been mapped so far and bail out.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 49 ++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index cf272b167feb..fb17c32855a5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -393,13 +393,32 @@ static void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
 	pm_runtime_put_autosuspend(pfdev->base.dev);
 }
 
+static void mmu_unmap_range(struct panfrost_mmu *mmu, u64 iova, size_t len)
+{
+	struct io_pgtable_ops *ops = mmu->pgtbl_ops;
+	size_t pgsize, unmapped_len = 0;
+	size_t unmapped_page, pgcount;
+
+	while (unmapped_len < len) {
+		pgsize = get_pgsize(iova, len - unmapped_len, &pgcount);
+
+		unmapped_page = ops->unmap_pages(ops, iova, pgsize, pgcount, NULL);
+		WARN_ON(unmapped_page != pgsize * pgcount);
+
+		iova += pgsize * pgcount;
+		unmapped_len += pgsize * pgcount;
+	}
+}
+
 static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 		      u64 iova, int prot, struct sg_table *sgt)
 {
 	unsigned int count;
 	struct scatterlist *sgl;
 	struct io_pgtable_ops *ops = mmu->pgtbl_ops;
+	size_t total_mapped = 0;
 	u64 start_iova = iova;
+	int ret;
 
 	for_each_sgtable_dma_sg(sgt, sgl, count) {
 		unsigned long paddr = sg_dma_address(sgl);
@@ -413,10 +432,14 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 			size_t pgcount, mapped = 0;
 			size_t pgsize = get_pgsize(iova | paddr, len, &pgcount);
 
-			ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
+			ret = ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
 				       GFP_KERNEL, &mapped);
+			if (ret)
+				goto err_unmap_pages;
+
 			/* Don't get stuck if things have gone wrong */
 			mapped = max(mapped, pgsize);
+			total_mapped += mapped;
 			iova += mapped;
 			paddr += mapped;
 			len -= mapped;
@@ -426,6 +449,10 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 	panfrost_mmu_flush_range(pfdev, mmu, start_iova, iova - start_iova);
 
 	return 0;
+
+err_unmap_pages:
+	mmu_unmap_range(mmu, start_iova, total_mapped);
+	return ret;
 }
 
 int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
@@ -436,6 +463,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 	struct panfrost_device *pfdev = to_panfrost_device(obj->dev);
 	struct sg_table *sgt;
 	int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE;
+	int ret;
 
 	if (WARN_ON(mapping->active))
 		return 0;
@@ -447,11 +475,18 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 	if (WARN_ON(IS_ERR(sgt)))
 		return PTR_ERR(sgt);
 
-	mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
-		   prot, sgt);
+	ret = mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
+			 prot, sgt);
+	if (ret)
+		goto err_put_pages;
+
 	mapping->active = true;
 
 	return 0;
+
+err_put_pages:
+	drm_gem_shmem_put_pages_locked(shmem);
+	return ret;
 }
 
 void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping)
@@ -635,8 +670,10 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	if (ret)
 		goto err_map;
 
-	mmu_map_sg(pfdev, bomapping->mmu, addr,
-		   IOMMU_WRITE | IOMMU_READ | IOMMU_CACHE | IOMMU_NOEXEC, sgt);
+	ret = mmu_map_sg(pfdev, bomapping->mmu, addr,
+			 IOMMU_WRITE | IOMMU_READ | IOMMU_CACHE | IOMMU_NOEXEC, sgt);
+	if (ret)
+		goto err_mmu_map_sg;
 
 	bomapping->active = true;
 	bo->heap_rss_size += SZ_2M;
@@ -650,6 +687,8 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 
 	return 0;
 
+err_mmu_map_sg:
+	dma_unmap_sgtable(pfdev->base.dev, sgt, DMA_BIDIRECTIONAL, 0);
 err_map:
 	sg_free_table(sgt);
 err_unlock:
-- 
2.51.0


