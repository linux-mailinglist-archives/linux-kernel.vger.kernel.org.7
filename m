Return-Path: <linux-kernel+bounces-692245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 308DEADEEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 16:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6DE1890E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17C72EBDDD;
	Wed, 18 Jun 2025 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BkvDHgQr"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEEC2EAB71;
	Wed, 18 Jun 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255779; cv=none; b=Ugf0n0TTiM/6BXEre3C4IJCsSymCS4vtvkmueyJ1CGj9/Bd8QwKCl5yXl4xnzYQOkBQeTPoHwxMWfDoK2/QVxHsP69hEZbiP5FyG6G0glUrphF6oUmbppvvADXk3GOKXcNP4jTDbu1/5r5JuQ2kShSb2hax1EVK5auLtZiBFSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255779; c=relaxed/simple;
	bh=31+ndELgkH3EF+4bLDMuFMNCeuy1ubH0tlueAjxYrcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuFAZ09g7tV+RVMWSHOgfXQlQQj3kmZLGbNJVora94odswg4x+rR3orydbsaEElpleMirWR2Ex9MaZQKNHPl8cGXMcJAYWJ2EctGpJuGk+Tei2lyxkx4dUx67NAscby1nupejPaXkDmK+qhSZjZ5Rb7KhHCvY/R2JVC/ka9c968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BkvDHgQr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750255775;
	bh=31+ndELgkH3EF+4bLDMuFMNCeuy1ubH0tlueAjxYrcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkvDHgQrchbGkDlvAw/BEUCYVlvF2cn1kA52EMrQnatg6k2gmhyq8WYech5ATERPP
	 e87WRegZgf29Cq3if3Fivi84SJxOL5gQBfeB/Em5k4ZOtvlV/BfOaaxkFkxB3GA3wJ
	 fPaaSmq6QCXG3dD9JlWGwlYnH8kmUSb1HidmA5g/R2N+4IPZE4TpiDz81rqRrGub5b
	 oTAmCpCtbayQZrRXQqGXCZ0N4eHtS2rVdrCaiMlV90S/zc3mJNpSw/IcEJqSfiRF9E
	 2m432/4GMRnuYo3BsU8UlWjlp/FAwiP0Gzox9noeqZjVpJiOTHn7FHxZWt4nrwOr2O
	 LulbHeHNkbGWw==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:45c6:994a:f902:5c74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9625117E156A;
	Wed, 18 Jun 2025 16:09:34 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 3/5] iommu: Add verisilicon IOMMU driver
Date: Wed, 18 Jun 2025 16:09:12 +0200
Message-ID: <20250618140923.97693-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618140923.97693-1-benjamin.gaignard@collabora.com>
References: <20250618140923.97693-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Verisilicon IOMMU hardware block can be found in combination
with Verisilicon hardware video codecs (encoders or decoders) on
different SoCs.
Enable it will allow us to use non contiguous memory allocators
for Verisilicon video codecs.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
changes in version 2:
- Add a compatible "rockchip,rk3588-av1-iommu"
- Rework driver probe function
- Remove double flush
- Rework driver internal structures and avoid allocate
  in xlate function.

 drivers/iommu/Kconfig     |  12 +
 drivers/iommu/Makefile    |   1 +
 drivers/iommu/vsi-iommu.c | 841 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 854 insertions(+)
 create mode 100644 drivers/iommu/vsi-iommu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 0a33d995d15d..b63546d97916 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -383,4 +383,16 @@ config SPRD_IOMMU
 
 	  Say Y here if you want to use the multimedia devices listed above.
 
+config VSI_IOMMU
+	bool "Verisilicon IOMMU Support"
+	depends on ARM64
+	select IOMMU_API
+	select ARM_DMA_USE_IOMMU
+	help
+	  Support for IOMMUs used by Verisilicon sub-systems like video
+	  decoders or encoder hardware blocks.
+
+	  Say Y here if you want to use this IOMMU in front of these
+	  hardware blocks.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 355294fa9033..68aeff31af8b 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
 obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
 obj-$(CONFIG_APPLE_DART) += apple-dart.o
+obj-$(CONFIG_VSI_IOMMU) += vsi-iommu.o
diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
new file mode 100644
index 000000000000..a9b731846dcf
--- /dev/null
+++ b/drivers/iommu/vsi-iommu.c
@@ -0,0 +1,841 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Collabora Ltd.
+ *
+ * IOMMU API for Verisilicon
+ *
+ * Module Authors:	Yandong Lin <yandong.lin@rock-chips.com>
+ *			Simon Xue <xxm@rock-chips.com>
+ *			Benjamin Gaignard <benjamin.gaignard@collabora.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/iopoll.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_iommu.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "iommu-pages.h"
+
+struct vsi_iommu {
+	struct device *dev;
+	void __iomem **bases;
+	int num_mmu;
+	int num_irq;
+	struct clk_bulk_data *clocks;
+	int num_clocks;
+	struct iommu_device iommu;
+	struct list_head node; /* entry in vsi_iommu_domain.iommus */
+	struct iommu_domain *domain; /* domain to which iommu is attached */
+};
+
+struct vsi_iommu_domain {
+	struct device *dma_dev;
+	struct list_head iommus;
+	u32 *dt; /* page directory table */
+	dma_addr_t dt_dma;
+	spinlock_t iommus_lock; /* lock for iommus list */
+	spinlock_t dt_lock; /* lock for modifying page directory table */
+	struct iommu_domain domain;
+	/* for vsi iommu */
+	u64 *pta; /* page directory table */
+	dma_addr_t pta_dma;
+};
+
+#define NUM_DT_ENTRIES	1024
+#define NUM_PT_ENTRIES	1024
+#define PT_SIZE		(NUM_PT_ENTRIES * sizeof(u32))
+
+#define SPAGE_SIZE	BIT(12)
+
+/* vsi iommu regs address */
+#define VSI_MMU_CONFIG1_BASE			0x1ac
+#define VSI_MMU_AHB_EXCEPTION_BASE		0x380
+#define VSI_MMU_AHB_CONTROL_BASE		0x388
+#define VSI_MMU_AHB_TBL_ARRAY_BASE_L_BASE	0x38C
+
+/* MMU register offsets */
+#define VSI_MMU_FLUSH_BASE		0x184
+#define VSI_MMU_BIT_FLUSH		BIT(4)
+
+#define VSI_MMU_PAGE_FAULT_ADDR		0x380
+#define VSI_MMU_STATUS_BASE		0x384	/* IRQ status */
+
+#define VSI_MMU_BIT_ENABLE		BIT(0)
+
+#define VSI_MMU_OUT_OF_BOUND		BIT(28)
+/* Irq mask */
+#define VSI_MMU_IRQ_MASK		0x7
+
+#define VSI_DTE_PT_ADDRESS_MASK		0xffffffc0
+#define VSI_DTE_PT_VALID		BIT(0)
+
+#define VSI_PAGE_DESC_LO_MASK		0xfffff000
+#define VSI_PAGE_DESC_HI_MASK		GENMASK_ULL(39, 32)
+#define VSI_PAGE_DESC_HI_SHIFT		(32 - 4)
+
+static inline phys_addr_t vsi_dte_pt_address(u32 dte)
+{
+	return (phys_addr_t)dte & VSI_DTE_PT_ADDRESS_MASK;
+}
+
+static inline u32 vsi_mk_dte(u32 *dte)
+{
+	return (*dte) | VSI_DTE_PT_VALID;
+}
+
+#define VSI_PTE_PAGE_ADDRESS_MASK	0xfffffff0
+#define VSI_PTE_PAGE_WRITABLE		BIT(2)
+#define VSI_PTE_PAGE_VALID		BIT(0)
+
+static inline phys_addr_t vsi_pte_page_address(u32 pte)
+{
+	u64 pte_vsi = pte;
+
+	pte_vsi = ((pte_vsi & VSI_PAGE_DESC_HI_MASK) << VSI_PAGE_DESC_HI_SHIFT) |
+		  (pte_vsi & VSI_PAGE_DESC_LO_MASK);
+
+	return (phys_addr_t)pte_vsi;
+}
+
+static u32 vsi_mk_pte(phys_addr_t page, int prot)
+{
+	u32 flags = 0;
+
+	flags |= (prot & IOMMU_WRITE) ? VSI_PTE_PAGE_WRITABLE : 0;
+	page = (page & VSI_PAGE_DESC_LO_MASK) |
+	       ((page & VSI_PAGE_DESC_HI_MASK) >> VSI_PAGE_DESC_HI_SHIFT);
+	page &= VSI_PTE_PAGE_ADDRESS_MASK;
+
+	return page | flags | VSI_PTE_PAGE_VALID;
+}
+
+#define VSI_DTE_PT_VALID	BIT(0)
+
+static inline bool vsi_dte_is_pt_valid(u32 dte)
+{
+	return dte & VSI_DTE_PT_VALID;
+}
+
+static inline bool vsi_pte_is_page_valid(u32 pte)
+{
+	return pte & VSI_PTE_PAGE_VALID;
+}
+
+static u32 vsi_mk_pte_invalid(u32 pte)
+{
+	return pte & ~VSI_PTE_PAGE_VALID;
+}
+
+#define VSI_MASTER_TLB_MASK	GENMASK_ULL(31, 10)
+/* mode 0 : 4k */
+#define VSI_PTA_4K_MODE	0
+
+static u64 vsi_mk_pta(dma_addr_t dt_dma)
+{
+	u64 val = (dt_dma & VSI_MASTER_TLB_MASK) | VSI_PTA_4K_MODE;
+
+	return val;
+}
+
+static struct vsi_iommu_domain *to_vsi_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct vsi_iommu_domain, domain);
+}
+
+static void vsi_iommu_disable(struct vsi_iommu *iommu)
+{
+	int i;
+
+	/* Ignore error while disabling, just keep going */
+	WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
+	for (i = 0; i < iommu->num_mmu; i++)
+		writel(0, iommu->bases[i] + VSI_MMU_AHB_CONTROL_BASE);
+
+	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+}
+
+static int vsi_iommu_enable(struct vsi_iommu *iommu)
+{
+	struct iommu_domain *domain = iommu->domain;
+	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
+	int ret, i;
+
+	ret = clk_bulk_enable(iommu->num_clocks, iommu->clocks);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < iommu->num_mmu; i++) {
+		u32 val = readl(iommu->bases[i] + VSI_MMU_AHB_CONTROL_BASE);
+
+		if (!(val & VSI_MMU_BIT_ENABLE)) {
+			writel(vsi_domain->pta_dma,
+			       iommu->bases[i] + VSI_MMU_AHB_TBL_ARRAY_BASE_L_BASE);
+			writel(VSI_MMU_OUT_OF_BOUND, iommu->bases[i] + VSI_MMU_CONFIG1_BASE);
+			writel(VSI_MMU_BIT_ENABLE, iommu->bases[i] + VSI_MMU_AHB_EXCEPTION_BASE);
+			writel(VSI_MMU_BIT_ENABLE, iommu->bases[i] + VSI_MMU_AHB_CONTROL_BASE);
+		}
+	}
+	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+
+	return ret;
+}
+
+static inline void vsi_table_flush(struct vsi_iommu_domain *vsi_domain, dma_addr_t dma,
+				   unsigned int count)
+{
+	size_t size = count * sizeof(u32); /* count of u32 entry */
+
+	dma_sync_single_for_device(vsi_domain->dma_dev, dma, size, DMA_TO_DEVICE);
+}
+
+#define VSI_IOVA_DTE_MASK	0xffc00000
+#define VSI_IOVA_DTE_SHIFT	22
+#define VSI_IOVA_PTE_MASK	0x003ff000
+#define VSI_IOVA_PTE_SHIFT	12
+#define VSI_IOVA_PAGE_MASK	0x00000fff
+#define VSI_IOVA_PAGE_SHIFT	0
+
+static u32 vsi_iova_dte_index(dma_addr_t iova)
+{
+	return (u32)(iova & VSI_IOVA_DTE_MASK) >> VSI_IOVA_DTE_SHIFT;
+}
+
+static u32 vsi_iova_pte_index(dma_addr_t iova)
+{
+	return (u32)(iova & VSI_IOVA_PTE_MASK) >> VSI_IOVA_PTE_SHIFT;
+}
+
+static u32 vsi_iova_page_offset(dma_addr_t iova)
+{
+	return (u32)(iova & VSI_IOVA_PAGE_MASK) >> VSI_IOVA_PAGE_SHIFT;
+}
+
+static u32 vsi_iommu_read(void __iomem *base, u32 offset)
+{
+	return readl(base + offset);
+}
+
+static void vsi_iommu_write(void __iomem *base, u32 offset, u32 value)
+{
+	writel(value, base + offset);
+}
+
+static void vsi_iommu_flush_tlb_all(struct iommu_domain *domain)
+{
+	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
+	struct list_head *pos;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&vsi_domain->iommus_lock, flags);
+	list_for_each(pos, &vsi_domain->iommus) {
+		struct vsi_iommu *iommu;
+		int ret;
+
+		iommu = list_entry(pos, struct vsi_iommu, node);
+		ret = pm_runtime_get_if_in_use(iommu->dev);
+		if (WARN_ON_ONCE(ret < 0))
+			continue;
+		if (ret) {
+			WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
+			for (i = 0; i < iommu->num_mmu; i++) {
+				writel(VSI_MMU_BIT_FLUSH,
+				       iommu->bases[i] + VSI_MMU_FLUSH_BASE);
+				writel(0, iommu->bases[i] + VSI_MMU_FLUSH_BASE);
+			}
+			clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+			pm_runtime_put(iommu->dev);
+		}
+	}
+	spin_unlock_irqrestore(&vsi_domain->iommus_lock, flags);
+}
+
+static irqreturn_t vsi_iommu_irq(int irq, void *dev_id)
+{
+	struct vsi_iommu *iommu = dev_id;
+	u32 int_status;
+	dma_addr_t iova;
+	irqreturn_t ret = IRQ_NONE;
+	int i, err;
+
+	err = pm_runtime_get_if_in_use(iommu->dev);
+	if (!err || WARN_ON_ONCE(err < 0))
+		return ret;
+
+	if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
+		goto out;
+
+	for (i = 0; i < iommu->num_mmu; i++) {
+		int_status = vsi_iommu_read(iommu->bases[i], VSI_MMU_STATUS_BASE);
+		if (int_status & VSI_MMU_IRQ_MASK) {
+			dev_err(iommu->dev, "unexpected int_status=%08x\n", int_status);
+			iova = vsi_iommu_read(iommu->bases[i], VSI_MMU_PAGE_FAULT_ADDR);
+
+			if (iommu->domain)
+				report_iommu_fault(iommu->domain, iommu->dev, iova, int_status);
+			else
+				dev_err(iommu->dev,
+					"Page fault while iommu not attached to domain?\n");
+		}
+		vsi_iommu_write(iommu->bases[i], VSI_MMU_STATUS_BASE, 0);
+		ret = IRQ_HANDLED;
+	}
+
+	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+
+out:
+	pm_runtime_put(iommu->dev);
+	return ret;
+}
+
+static struct iommu_domain *vsi_iommu_domain_alloc_paging(struct device *dev)
+{
+	struct vsi_iommu_domain *vsi_domain;
+
+	vsi_domain = kzalloc(sizeof(*vsi_domain), GFP_KERNEL);
+	if (!vsi_domain)
+		return NULL;
+
+	vsi_domain->dma_dev = dev->iommu->iommu_dev->dev;
+
+	/*
+	 * iommu use a 2 level pagetable.
+	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
+	 * Allocate one 4 KiB page for each table.
+	 */
+	vsi_domain->dt = iommu_alloc_pages_sz(GFP_KERNEL | GFP_DMA32,
+					      SPAGE_SIZE);
+	if (!vsi_domain->dt)
+		goto err_free_domain;
+
+	vsi_domain->dt_dma = dma_map_single(vsi_domain->dma_dev, vsi_domain->dt,
+					    SPAGE_SIZE, DMA_TO_DEVICE);
+	if (dma_mapping_error(vsi_domain->dma_dev, vsi_domain->dt_dma)) {
+		dev_err(vsi_domain->dma_dev, "DMA map error for DT\n");
+		goto err_free_dt;
+	}
+
+	vsi_domain->pta = iommu_alloc_pages_sz(GFP_KERNEL | GFP_DMA32,
+					       SPAGE_SIZE);
+	if (!vsi_domain->pta)
+		goto err_unmap_dt;
+
+	vsi_domain->pta[0] = vsi_mk_pta(vsi_domain->dt_dma);
+	vsi_domain->pta_dma = dma_map_single(vsi_domain->dma_dev, vsi_domain->pta,
+					     SPAGE_SIZE, DMA_TO_DEVICE);
+	if (dma_mapping_error(vsi_domain->dma_dev, vsi_domain->pta_dma)) {
+		dev_err(vsi_domain->dma_dev, "DMA map error for PTA\n");
+		goto err_free_pta;
+	}
+
+	spin_lock_init(&vsi_domain->iommus_lock);
+	spin_lock_init(&vsi_domain->dt_lock);
+	INIT_LIST_HEAD(&vsi_domain->iommus);
+
+	vsi_domain->domain.geometry.aperture_start = 0;
+	vsi_domain->domain.geometry.aperture_end   = DMA_BIT_MASK(32);
+	vsi_domain->domain.geometry.force_aperture = true;
+	vsi_domain->domain.pgsize_bitmap = SZ_4K;
+
+	return &vsi_domain->domain;
+
+err_free_pta:
+	iommu_free_pages(vsi_domain->pta);
+err_unmap_dt:
+	dma_unmap_single(vsi_domain->dma_dev, vsi_domain->dt_dma,
+			 SPAGE_SIZE, DMA_TO_DEVICE);
+err_free_dt:
+	iommu_free_pages(vsi_domain->dt);
+err_free_domain:
+	kfree(vsi_domain);
+
+	return NULL;
+}
+
+static phys_addr_t vsi_iommu_iova_to_phys(struct iommu_domain *domain,
+					  dma_addr_t iova)
+{
+	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
+	unsigned long flags;
+	phys_addr_t pt_phys, phys = 0;
+	u32 dte, pte;
+	u32 *page_table;
+
+	spin_lock_irqsave(&vsi_domain->dt_lock, flags);
+
+	dte = vsi_domain->dt[vsi_iova_dte_index(iova)];
+	if (!vsi_dte_is_pt_valid(dte))
+		goto out;
+
+	pt_phys = vsi_dte_pt_address(dte);
+	page_table = (u32 *)phys_to_virt(pt_phys);
+	pte = page_table[vsi_iova_pte_index(iova)];
+	if (!vsi_pte_is_page_valid(pte))
+		goto out;
+
+	phys = vsi_pte_page_address(pte) + vsi_iova_page_offset(iova);
+out:
+	spin_unlock_irqrestore(&vsi_domain->dt_lock, flags);
+
+	return phys;
+}
+
+static u32 *vsi_dte_get_page_table(struct vsi_iommu_domain *vsi_domain, dma_addr_t iova)
+{
+	u32 *page_table, *dte_addr;
+	u32 dte_index, dte;
+	phys_addr_t pt_phys;
+	dma_addr_t pt_dma;
+
+	assert_spin_locked(&vsi_domain->dt_lock);
+
+	dte_index = vsi_iova_dte_index(iova);
+	dte_addr = &vsi_domain->dt[dte_index];
+	dte = *dte_addr;
+	if (vsi_dte_is_pt_valid(dte))
+		goto done;
+
+	page_table = iommu_alloc_pages_sz(GFP_ATOMIC | GFP_DMA32, SPAGE_SIZE);
+	if (!page_table)
+		return ERR_PTR(-ENOMEM);
+
+	dte = vsi_mk_dte(page_table);
+	*dte_addr = dte;
+
+	pt_dma = dma_map_single(vsi_domain->dma_dev, page_table, SPAGE_SIZE, DMA_TO_DEVICE);
+	if (dma_mapping_error(vsi_domain->dma_dev, pt_dma)) {
+		dev_err(vsi_domain->dma_dev, "DMA mapping error while allocating page table\n");
+		iommu_free_pages(page_table);
+		return ERR_PTR(-ENOMEM);
+	}
+
+done:
+	pt_phys = vsi_dte_pt_address(dte);
+	return (u32 *)phys_to_virt(pt_phys);
+}
+
+static size_t vsi_iommu_unmap_iova(struct vsi_iommu_domain *vsi_domain,
+				   u32 *pte_addr, dma_addr_t pte_dma,
+				   size_t size)
+{
+	unsigned int pte_count;
+	unsigned int pte_total = size / SPAGE_SIZE;
+
+	assert_spin_locked(&vsi_domain->dt_lock);
+
+	for (pte_count = 0; pte_count < pte_total; pte_count++) {
+		u32 pte = pte_addr[pte_count];
+
+		if (!vsi_pte_is_page_valid(pte))
+			break;
+
+		pte_addr[pte_count] = vsi_mk_pte_invalid(pte);
+	}
+
+	vsi_table_flush(vsi_domain, pte_dma, pte_count);
+
+	return pte_count * SPAGE_SIZE;
+}
+
+static int vsi_iommu_map_iova(struct vsi_iommu_domain *vsi_domain, u32 *pte_addr,
+			      dma_addr_t pte_dma, dma_addr_t iova,
+			      phys_addr_t paddr, size_t size, int prot)
+{
+	unsigned int pte_count;
+	unsigned int pte_total = size / SPAGE_SIZE;
+
+	assert_spin_locked(&vsi_domain->dt_lock);
+
+	for (pte_count = 0; pte_count < pte_total; pte_count++) {
+		u32 pte = pte_addr[pte_count];
+
+		if (vsi_pte_is_page_valid(pte))
+			goto unwind;
+
+		pte_addr[pte_count] = vsi_mk_pte(paddr, prot);
+
+		paddr += SPAGE_SIZE;
+	}
+
+	vsi_table_flush(vsi_domain, pte_dma, pte_total);
+
+	return 0;
+unwind:
+	/* Unmap the range of iovas that we just mapped */
+	vsi_iommu_unmap_iova(vsi_domain, pte_addr, pte_dma,
+			     pte_count * SPAGE_SIZE);
+
+	return -EADDRINUSE;
+}
+
+static size_t vsi_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
+			      size_t size, size_t count, struct iommu_iotlb_gather *gather)
+{
+	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
+	unsigned long flags;
+	dma_addr_t pte_dma, iova = (dma_addr_t)_iova;
+	phys_addr_t pt_phys;
+	u32 dte;
+	u32 *pte_addr;
+	size_t unmap_size;
+
+	spin_lock_irqsave(&vsi_domain->dt_lock, flags);
+
+	dte = vsi_domain->dt[vsi_iova_dte_index(iova)];
+	/* Just return 0 if iova is unmapped */
+	if (!vsi_dte_is_pt_valid(dte)) {
+		spin_unlock_irqrestore(&vsi_domain->dt_lock, flags);
+		return 0;
+	}
+
+	pt_phys = vsi_dte_pt_address(dte);
+	pte_addr = (u32 *)phys_to_virt(pt_phys) + vsi_iova_pte_index(iova);
+	pte_dma = pt_phys + vsi_iova_pte_index(iova) * sizeof(u32);
+	unmap_size = vsi_iommu_unmap_iova(vsi_domain, pte_addr, pte_dma, size);
+
+	spin_unlock_irqrestore(&vsi_domain->dt_lock, flags);
+
+	return unmap_size;
+}
+
+static int vsi_iommu_map(struct iommu_domain *domain, unsigned long _iova,
+			 phys_addr_t paddr, size_t size, size_t count,
+			 int prot, gfp_t gfp, size_t *mapped)
+{
+	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
+	unsigned long flags;
+	dma_addr_t pte_dma, iova = (dma_addr_t)_iova;
+	u32 *page_table, *pte_addr;
+	u32 dte, pte_index;
+	int ret;
+
+	spin_lock_irqsave(&vsi_domain->dt_lock, flags);
+
+	page_table = vsi_dte_get_page_table(vsi_domain, iova);
+	if (IS_ERR(page_table)) {
+		spin_unlock_irqrestore(&vsi_domain->dt_lock, flags);
+		return PTR_ERR(page_table);
+	}
+
+	dte = vsi_domain->dt[vsi_iova_dte_index(iova)];
+	pte_index = vsi_iova_pte_index(iova);
+	pte_addr = &page_table[pte_index];
+	pte_dma = vsi_dte_pt_address(dte) + pte_index * sizeof(u32);
+	ret = vsi_iommu_map_iova(vsi_domain, pte_addr, pte_dma, iova,
+				 paddr, size, prot);
+
+	spin_unlock_irqrestore(&vsi_domain->dt_lock, flags);
+	if (!ret)
+		*mapped = size;
+
+	return ret;
+}
+
+static void vsi_iommu_detach_device(struct iommu_domain *domain,
+				    struct device *dev)
+{
+	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
+	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
+	unsigned long flags;
+	int ret;
+
+	if (WARN_ON(!iommu))
+		return;
+
+	if (!iommu->domain)
+		return;
+
+	ret = pm_runtime_get_if_in_use(iommu->dev);
+	WARN_ON_ONCE(ret < 0);
+	if (ret > 0) {
+		vsi_iommu_disable(iommu);
+		pm_runtime_put(iommu->dev);
+	}
+	iommu->domain = NULL;
+
+	spin_lock_irqsave(&vsi_domain->iommus_lock, flags);
+	list_del_init(&iommu->node);
+	spin_unlock_irqrestore(&vsi_domain->iommus_lock, flags);
+}
+
+static int vsi_iommu_attach_device(struct iommu_domain *domain,
+				   struct device *dev)
+{
+	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
+	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
+	unsigned long flags;
+	int ret;
+
+	if (WARN_ON(!iommu))
+		return -ENODEV;
+
+	if (iommu->domain == domain)
+		return 0;
+
+	iommu->domain = domain;
+
+	spin_lock_irqsave(&vsi_domain->iommus_lock, flags);
+	list_add_tail(&iommu->node, &vsi_domain->iommus);
+	spin_unlock_irqrestore(&vsi_domain->iommus_lock, flags);
+
+	ret = pm_runtime_get_if_in_use(iommu->dev);
+	if (!ret || WARN_ON_ONCE(ret < 0))
+		return 0;
+
+	ret = vsi_iommu_enable(iommu);
+	if (ret)
+		vsi_iommu_detach_device(iommu->domain, dev);
+
+	pm_runtime_put(iommu->dev);
+
+	return ret;
+}
+
+static void vsi_iommu_domain_free(struct iommu_domain *domain)
+{
+	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
+	int i;
+
+	WARN_ON(!list_empty(&vsi_domain->iommus));
+
+	for (i = 0; i < NUM_DT_ENTRIES; i++) {
+		u32 dte = vsi_domain->dt[i];
+
+		if (vsi_dte_is_pt_valid(dte)) {
+			phys_addr_t pt_phys = vsi_dte_pt_address(dte);
+			u32 *page_table = phys_to_virt(pt_phys);
+
+			dma_unmap_single(vsi_domain->dma_dev, pt_phys,
+					 SPAGE_SIZE, DMA_TO_DEVICE);
+			iommu_free_pages(page_table);
+		}
+	}
+
+	dma_unmap_single(vsi_domain->dma_dev, vsi_domain->dt_dma,
+			 SPAGE_SIZE, DMA_TO_DEVICE);
+	iommu_free_pages(vsi_domain->dt);
+
+	dma_unmap_single(vsi_domain->dma_dev, vsi_domain->pta_dma,
+			 SPAGE_SIZE, DMA_TO_DEVICE);
+	iommu_free_pages(vsi_domain->pta);
+
+	kfree(vsi_domain);
+}
+
+static struct iommu_device *vsi_iommu_probe_device(struct device *dev)
+{
+	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
+	struct device_link *link;
+
+	if (!iommu)
+		return ERR_PTR(-ENODEV);
+
+	link = device_link_add(dev, iommu->dev,
+			       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
+	if (!link)
+		dev_err(dev, "Unable to link %s\n", dev_name(iommu->dev));
+
+	return &iommu->iommu;
+}
+
+static void vsi_iommu_release_device(struct device *dev)
+{
+	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
+
+	device_link_remove(dev, iommu->dev);
+}
+
+static int vsi_iommu_of_xlate(struct device *dev,
+			      const struct of_phandle_args *args)
+{
+	struct platform_device *iommu_dev;
+
+	if (!dev_iommu_priv_get(dev)) {
+		iommu_dev = of_find_device_by_node(args->np);
+		if (WARN_ON(!iommu_dev))
+			return -EINVAL;
+
+		dev_iommu_priv_set(dev, platform_get_drvdata(iommu_dev));
+	}
+
+	return iommu_fwspec_add_ids(dev, args->args, 1);
+}
+
+static struct iommu_ops vsi_iommu_ops = {
+	.domain_alloc_paging = vsi_iommu_domain_alloc_paging,
+	.probe_device = vsi_iommu_probe_device,
+	.release_device = vsi_iommu_release_device,
+	.device_group = generic_single_device_group,
+	.of_xlate = vsi_iommu_of_xlate,
+	.default_domain_ops = &(const struct iommu_domain_ops) {
+		.attach_dev		= vsi_iommu_attach_device,
+		.map_pages		= vsi_iommu_map,
+		.unmap_pages		= vsi_iommu_unmap,
+		.flush_iotlb_all	= vsi_iommu_flush_tlb_all,
+		.iova_to_phys		= vsi_iommu_iova_to_phys,
+		.free			= vsi_iommu_domain_free,
+	}
+};
+
+static const struct of_device_id vsi_iommu_dt_ids[] = {
+	{
+		.compatible = "verisilicon,iommu",
+	},
+	{
+		.compatible = "rockchip,rk3588-av1-iommu",
+	},
+	{ /* sentinel */ }
+};
+
+static int vsi_iommu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct vsi_iommu *iommu;
+	struct resource *res;
+	int num_res = pdev->num_resources;
+	int err, i;
+
+	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
+	if (!iommu)
+		return -ENOMEM;
+
+	iommu->dev = dev;
+	iommu->num_mmu = 0;
+
+	iommu->bases = devm_kcalloc(dev, num_res, sizeof(*iommu->bases),
+				    GFP_KERNEL);
+	if (!iommu->bases)
+		return -ENOMEM;
+
+	for (i = 0; i < num_res; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			continue;
+		iommu->bases[i] = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(iommu->bases[i]))
+			continue;
+		iommu->num_mmu++;
+	}
+	if (iommu->num_mmu == 0)
+		return PTR_ERR(iommu->bases[0]);
+
+	iommu->num_irq = platform_irq_count(pdev);
+	if (iommu->num_irq < 0)
+		return iommu->num_irq;
+
+	err = devm_clk_bulk_get_all(dev, &iommu->clocks);
+	if (err >= 0)
+		iommu->num_clocks = err;
+	else if (err == -ENOENT)
+		iommu->num_clocks = 0;
+	else
+		return err;
+
+	err = clk_bulk_prepare(iommu->num_clocks, iommu->clocks);
+	if (err)
+		return err;
+
+	for (i = 0; i < iommu->num_irq; i++) {
+		int irq = platform_get_irq(pdev, i);
+
+		if (irq < 0)
+			return irq;
+
+		err = devm_request_irq(iommu->dev, irq, vsi_iommu_irq,
+				       IRQF_SHARED, dev_name(dev), iommu);
+		if (err)
+			goto err_unprepare_clocks;
+	}
+
+	pm_runtime_enable(dev);
+
+	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
+	if (err)
+		goto err_runtime_disable;
+
+	err = iommu_device_register(&iommu->iommu, &vsi_iommu_ops, dev);
+	if (err)
+		goto err_remove_sysfs;
+
+	platform_set_drvdata(pdev, iommu);
+
+	return 0;
+
+err_remove_sysfs:
+	iommu_device_sysfs_remove(&iommu->iommu);
+err_runtime_disable:
+	pm_runtime_disable(dev);
+err_unprepare_clocks:
+	clk_bulk_unprepare(iommu->num_clocks, iommu->clocks);
+	return err;
+}
+
+static void vsi_iommu_shutdown(struct platform_device *pdev)
+{
+	struct vsi_iommu *iommu = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < iommu->num_irq; i++) {
+		int irq = platform_get_irq(pdev, i);
+
+		devm_free_irq(iommu->dev, irq, iommu);
+	}
+
+	pm_runtime_force_suspend(&pdev->dev);
+}
+
+static int __maybe_unused vsi_iommu_suspend(struct device *dev)
+{
+	struct vsi_iommu *iommu = dev_get_drvdata(dev);
+
+	if (!iommu->domain)
+		return 0;
+
+	vsi_iommu_disable(iommu);
+	return 0;
+}
+
+static int __maybe_unused vsi_iommu_resume(struct device *dev)
+{
+	struct vsi_iommu *iommu = dev_get_drvdata(dev);
+
+	if (!iommu->domain)
+		return 0;
+
+	return vsi_iommu_enable(iommu);
+}
+
+static const struct dev_pm_ops vsi_iommu_pm_ops = {
+	SET_RUNTIME_PM_OPS(vsi_iommu_suspend, vsi_iommu_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+static struct platform_driver rockchip_vsi_iommu_driver = {
+	.probe = vsi_iommu_probe,
+	.shutdown = vsi_iommu_shutdown,
+	.driver = {
+		   .name = "vsi_iommu",
+		   .of_match_table = vsi_iommu_dt_ids,
+		   .pm = &vsi_iommu_pm_ops,
+		   .suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(rockchip_vsi_iommu_driver);
-- 
2.43.0


