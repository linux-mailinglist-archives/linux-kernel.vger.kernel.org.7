Return-Path: <linux-kernel+bounces-832266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F21B9EC53
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43124A04EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F6B2F83B1;
	Thu, 25 Sep 2025 10:40:46 +0000 (UTC)
Received: from out198-17.us.a.mail.aliyun.com (out198-17.us.a.mail.aliyun.com [47.90.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95B2EB871
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796846; cv=none; b=NpeEEkyZ+kOn5bxBTVuwJWJFGPQ+bul5QyoJ+3nDOHS6CoTkP8R0gbmFEO3Cajvfz4DU0f/F2iFCaWRd5DMeoERU3O/kWqnsOTr/BweA/IwYCtl2bl+LVhIPe7juWDUfJYoFoG9jY5lyFFDp1VJc6vje8mvDXu1r8VpQUjnvqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796846; c=relaxed/simple;
	bh=1bK6cqqkzEFJzP1Jtb3iI0Ku8RA8Hv/t+Bm93uyPSuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rRv57GxzMGFX1Co0wMtziJQEQKFMlDxsW4Mjn3W3UJGiuDDGgQiGaoPV5L3L1L+ueRH29RrJZctes3+hcVlDiIw+d9yT7fjlEQ00xDzpwZw4SonJ7KD0OKom+JDn1eviZa2ukkf6nGFtZyLvYfMcnpPmq5jNSNS/vj1yvFJelFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=47.90.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from guoyaxing.localdomain(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.enEG1Ov_1758796820 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 18:40:28 +0800
From: Yaxing Guo <guoyaxing@bosc.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	wangran@bosc.ac.cn,
	zhangjian@bosc.ac.cn,
	anxu@bosc.ac.cn,
	guoyaxing@bosc.ac.cn
Subject: [PATCH v2 1/3] uio: Add SVA support for PCI devices via uio_pci_generic_sva.c
Date: Thu, 25 Sep 2025 18:40:16 +0800
Message-Id: <20250925104018.57053-1-guoyaxing@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new UIO driver, uio_pci_generic_sva, which
extends the functionality of uio_pci_generic by adding support for
Shared Virtual Addressing (SVA) when IOMMU is enabled in the system.

The key enhancement allows PCI devices to directly use user-space virtual
addresses for DMA operations, eliminating the need for bounce buffers or
explicit IOVA mapping. This is achieved by leveraging the kernel's IOMMU-SVA
subsystem, including process address space attachment, page fault handling,
and shared context management between CPU and device.

With this driver, userspace applications can perform zero-copy DMA using
native pointers:

    void *addr = malloc(N);
    set_dma_addr((uint64_t)addr);  // Pass user VA directly
    start_dma();

The device can now access 'addr' through the IOMMU's PASID-based translation,
provided that the underlying IOMMU hardware (e.g., Intel VT-d 3.1+, AMD-Vi,
ARM SMMU, RISCV IOMMU) and platform support SVA.

Dependencies:
- CONFIG_IOMMU_SVA must be enabled.
- The platform must support PRI (Page Request Interface) and PASID.
- Device drivers/userspace must handle page faults if demand-paging is used.

The implementation reuses core logic from uio_pci_generic.c while adding
PASID setting, and integration with the IOMMU SVA APIs.

Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
---
Changes in v2:
  -- Use sysfs_emit() instead of sprintf in pasid_show()
  -- Use the default attribute list instead of sysfs_create_file
  -- Add MODULE_DESCRIPTION
  -- Modify "2024" to "2025" in copyright

 drivers/uio/uio_pci_generic_sva.c | 192 ++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)
 create mode 100644 drivers/uio/uio_pci_generic_sva.c

diff --git a/drivers/uio/uio_pci_generic_sva.c b/drivers/uio/uio_pci_generic_sva.c
new file mode 100644
index 000000000000..97e9ab9a081a
--- /dev/null
+++ b/drivers/uio/uio_pci_generic_sva.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * UIO PCI Express sva driver
+ *
+ * Copyright (c) 2025 Beijing Institute of Open Source Chip (BOSC)
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/uio_driver.h>
+#include <linux/iommu.h>
+
+struct uio_pci_sva_dev {
+	struct pci_dev *pdev;
+	struct uio_info info;
+	struct iommu_sva *sva_handle;
+	int pasid;
+};
+
+static irqreturn_t irq_handler(int irq, struct uio_info *dev_info)
+{
+	return IRQ_HANDLED;
+}
+
+static int uio_pci_sva_open(struct uio_info *info, struct inode *inode)
+{
+	struct iommu_sva *handle;
+	struct uio_pci_sva_dev *udev = info->priv;
+	struct iommu_domain *domain;
+
+	if (!udev && !udev->pdev)
+		return -ENODEV;
+
+	domain = iommu_get_domain_for_dev(&udev->pdev->dev);
+	if (domain)
+		iommu_detach_device(domain, &udev->pdev->dev);
+
+	handle = iommu_sva_bind_device(&udev->pdev->dev, current->mm);
+	if (IS_ERR(handle))
+		return -EINVAL;
+
+	udev->pasid = iommu_sva_get_pasid(handle);
+
+	udev->sva_handle = handle;
+
+	return 0;
+}
+
+static int uio_pci_sva_release(struct uio_info *info, struct inode *inode)
+{
+	struct uio_pci_sva_dev *udev = info->priv;
+
+	if (!udev && !udev->pdev)
+		return -ENODEV;
+
+	iommu_sva_unbind_device(udev->sva_handle);
+
+	return 0;
+}
+
+static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct uio_pci_sva_dev *udev;
+	int ret, i, irq = 0;
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "pci_enable_device failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret)
+		goto out_disable;
+
+	pci_set_master(pdev);
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (ret > 0) {
+		irq = pci_irq_vector(pdev, 0);
+		if (irq < 0) {
+			dev_err(&pdev->dev, "Failed to get MSI vector\n");
+			ret = irq;
+			goto out_disable;
+		}
+	} else
+		dev_warn(&pdev->dev,
+			 "No IRQ vectors available (%d), using polling\n", ret);
+
+	udev = devm_kzalloc(&pdev->dev, sizeof(struct uio_pci_sva_dev),
+			    GFP_KERNEL);
+	if (!udev) {
+		ret =  -ENOMEM;
+		goto out_disable;
+	}
+
+	udev->pdev = pdev;
+	udev->info.name = "uio_pci_sva";
+	udev->info.version = "0.0.1";
+	udev->info.open = uio_pci_sva_open;
+	udev->info.release = uio_pci_sva_release;
+	udev->info.irq = irq;
+	udev->info.handler = irq_handler;
+	udev->info.priv = udev;
+
+	for (i = 0; i < MAX_UIO_MAPS; i++) {
+		struct resource *r = &pdev->resource[i];
+		struct uio_mem *uiomem = &udev->info.mem[i];
+
+		if (r->flags != (IORESOURCE_SIZEALIGN | IORESOURCE_MEM))
+			continue;
+
+		if (uiomem >= &udev->info.mem[MAX_UIO_MAPS]) {
+			dev_warn(&pdev->dev, "Do not support more than %d iomem\n",
+				 MAX_UIO_MAPS);
+			break;
+		}
+
+		uiomem->memtype = UIO_MEM_PHYS;
+		uiomem->addr = r->start & PAGE_MASK;
+		uiomem->offs = r->start & ~PAGE_MASK;
+		uiomem->size =
+			(uiomem->offs + resource_size(r) + PAGE_SIZE - 1) &
+			PAGE_MASK;
+		uiomem->name = r->name;
+	}
+
+	ret = devm_uio_register_device(&pdev->dev, &udev->info);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register uio device\n");
+		goto out_free;
+	}
+
+	pci_set_drvdata(pdev, udev);
+
+	return 0;
+
+out_free:
+	kfree(udev);
+out_disable:
+	pci_disable_device(pdev);
+
+	return ret;
+}
+
+static void remove(struct pci_dev *pdev)
+{
+	struct uio_pci_sva_dev *udev = pci_get_drvdata(pdev);
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	kfree(udev);
+}
+
+static ssize_t pasid_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct uio_pci_sva_dev *udev = pci_get_drvdata(pdev);
+
+	return sysfs_emit(buf, "%d\n", udev->pasid);
+}
+static DEVICE_ATTR_RO(pasid);
+
+static struct attribute *uio_pci_sva_attrs[] = {
+	&dev_attr_pasid.attr,
+	NULL
+};
+
+static const struct attribute_group uio_pci_sva_attr_group = {
+	.attrs = uio_pci_sva_attrs,
+};
+
+static const struct attribute_group *uio_pci_sva_attr_groups[] = {
+	&uio_pci_sva_attr_group,
+	NULL
+};
+
+static struct pci_driver uio_pci_generic_sva_driver = {
+	.name = "uio_pci_sva",
+	.dev_groups = uio_pci_sva_attr_groups,
+	.id_table = NULL,
+	.probe = probe,
+	.remove = remove,
+};
+
+module_pci_driver(uio_pci_generic_sva_driver);
+MODULE_VERSION("0.0.01");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yaxing Guo <guoyaxing@bosc.ac.cn>");
+MODULE_DESCRIPTION("Generic UIO sva driver for PCI");
-- 
2.34.1


