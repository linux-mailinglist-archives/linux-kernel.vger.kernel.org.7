Return-Path: <linux-kernel+bounces-818272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B90B58F33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CE3321BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F872E0935;
	Tue, 16 Sep 2025 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHnKv1Pp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B312279DD8;
	Tue, 16 Sep 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007951; cv=none; b=XLLvnEaV68EoNN9EMWUKTxXY+apnpGFnSEVCq60yKmtl739h47TmLV+vKnzrmGwbKpGFVwrpIOVTrOGgrzOBCUoqKUjZIGnVVvUA+0HzhfwBjYumrMtsF7Z7cPtgdFbZggXlSg4obUkonxIe8GjbthtwrtXVXWYUaRasVemrxyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007951; c=relaxed/simple;
	bh=IWZzOtyPCKRdI0+hToW/fnJJYkRULeN+gzOWf1AjNkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRIBJ3m3WL9UkN4vi6yIBt1d9rOIKq7jU6fVVO+07ffU3wa2P/fB8muXPxxilzhsoZQegV1yRPiaFslaFrS7QxQmifHCtaM2mfEUXxgbJCBek2YCZ4VOcbqesTfERF1WZKI1QBZBh27FZTSRZ3E59MrvncoD3QC8jHrCOIDFDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHnKv1Pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526A2C4CEFD;
	Tue, 16 Sep 2025 07:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758007951;
	bh=IWZzOtyPCKRdI0+hToW/fnJJYkRULeN+gzOWf1AjNkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GHnKv1Pp0tvFEz3pCbixGilPKt8kobdgb8+pVMCk+aJ83OEJyYkpq4oNPL5tRF1fD
	 9d260B+Az8pQw3/SDCczfKbakugUDvMaEw4JnkRyOWrs97qcYrrDmDvo0vaYvqiOf6
	 lJxPVkhf5f3cYhABiK9zWvgKFBUYR4xxpYfuKS4ca//1IBhK+9j02CTQVN60OO0Ava
	 hQw9GvszlxU14IwMJrI4jU2k+MWFXsI4vLcD7KSVoQg6MTFSDdYTnUHOC3eBfxNjS8
	 7e7QvqbTfJC9HAjZH+i157DTyDOHDy2ZSnNgo11ErKUX+6dsBwifkTnkfHAsvinTXK
	 QzaKdm9+yyg5Q==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 1/4] dma-mapping: prepare dma_map_ops to conversion to physical address
Date: Tue, 16 Sep 2025 10:32:04 +0300
Message-ID: <f40855cc9733160c9ba842bf6e7cac58f0bf1dbb.1758006942.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758006942.git.leon@kernel.org>
References: <cover.1758006942.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Add new .map_phys() and .unmap_phys() callbacks to dma_map_ops as a
preparation to replace .map_page() and .unmap_page() respectively.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-map-ops.h | 7 +++++++
 kernel/dma/mapping.c        | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 71f5b30254159..25603cb273769 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -37,6 +37,13 @@ struct dma_map_ops {
 	void (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
 			size_t size, enum dma_data_direction dir,
 			unsigned long attrs);
+
+	dma_addr_t (*map_phys)(struct device *dev, phys_addr_t phys,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs);
+	void (*unmap_phys)(struct device *dev, dma_addr_t dma_handle,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs);
 	/*
 	 * map_sg should return a negative error code on error. See
 	 * dma_map_sgtable() for a list of appropriate error codes
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index fe7472f13b106..4080aebe5debb 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -169,6 +169,8 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 		addr = dma_direct_map_phys(dev, phys, size, dir, attrs);
 	else if (use_dma_iommu(dev))
 		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
+	else if (ops->map_phys)
+		addr = ops->map_phys(dev, phys, size, dir, attrs);
 	else if (is_mmio) {
 		if (!ops->map_resource)
 			return DMA_MAPPING_ERROR;
@@ -223,6 +225,8 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
 		dma_direct_unmap_phys(dev, addr, size, dir, attrs);
 	else if (use_dma_iommu(dev))
 		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
+	else if (ops->unmap_phys)
+		ops->unmap_phys(dev, addr, size, dir, attrs);
 	else if (is_mmio) {
 		if (ops->unmap_resource)
 			ops->unmap_resource(dev, addr, size, dir, attrs);
-- 
2.51.0


