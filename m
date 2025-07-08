Return-Path: <linux-kernel+bounces-722182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F7CAFD652
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7C9171E18
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A772E7655;
	Tue,  8 Jul 2025 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GJ8gLQ6N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5MWgU9fv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA9D2E6D01
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998828; cv=none; b=hnVxGGY3Jsnt9hxJnEwuJSuOp+KyzKisEWUxJSRicO1tML9YMT0K313/yEKySPs7MFBHddkqNPu/6rvVYGwLNU/y9hNljZEe9N1/kIgpMRgnkG4YtWRjfyPj/sqU8QBhc8SuEdT0/xGS5JqrDph1rAn8jVSKLajtHEgEI9N5JZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998828; c=relaxed/simple;
	bh=fs63dAatZtdURAcgrxaj2klPRt2jmf+XkH9j+roloNk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FtKdSzYGkLTEmMytX/aHP7BKqSt+acwKJRO1XTZuxuOvxLP1cxs+IjBLoPzWptvqF51035RB8ojPpA5GJsk2n0uRYGmEuY25vs6efD/vklU18clEbYtokypNzKAJbjgzknB4994Qmv6Z9l22l8Ug7sbhTod69K5CGWTTAtOUXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GJ8gLQ6N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5MWgU9fv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo/6iSAsGRAtE8vTI8HO8ZGtS+Nkyi/nrqqZyaWI/Dg=;
	b=GJ8gLQ6NhXryiCtHm2X8uSyLW0uzyXjuVLoLZq2N/QroadUVilI8+mWMLyWapbTLDR90Cv
	HH1/2KK/pvaD8FSA+QE10tWIWqw0xioXxHPMqIBRYYrDb1+UflcBQpv9BP/EN39xmtrtyD
	5J8aw49q9JkH4RQ9H/9KtRMdoMMnCE7krqk/ySMfMAhgR2PUHT1lT7i/RDHiCN1qJkAOVe
	mF52LiiQYXbfOvtwGWsqhlae1a8WRL7p52JaGbAHIW6kzEoW95DEmVGjJXjfqDl83wypIJ
	rtr/msjDSHRLORXU+cjvuun0in30j3qvmV/BY6IBCqt+lRsMQxWzb3JFJU1G0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo/6iSAsGRAtE8vTI8HO8ZGtS+Nkyi/nrqqZyaWI/Dg=;
	b=5MWgU9fvb78K1VHtkoRpF+i+ludmmvxlzAhVSBkZ40kj8G05GJyQyldg8rR1q14QjXjJzl
	MZCKItTD5FMYOnBA==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject:
 [irqchip: irq/irqchip-next] irqchip/gic-v3: Rename GICv3 ITS MSI parent
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20250703-gicv5-host-v7-26-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-26-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199882286.406.13969003660524287726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     b4ead12d95002b9c65e3c646cf73e0a91c608024
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b4ead12d95002b9c65e3c646cf73e0a91c608024
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:16 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:52 +01:00

irqchip/gic-v3: Rename GICv3 ITS MSI parent

The GICv5 ITS will reuse some GICv3 ITS MSI parent functions therefore
it makes sense to keep the code functionality in a compilation unit
shared by the two drivers.

Rename the GICv3 ITS MSI parent file and update the related
Kconfig/Makefile entries to pave the way for code sharing.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-26-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig                     |   4 +-
 drivers/irqchip/Makefile                    |   3 +-
 drivers/irqchip/irq-gic-common.h            |   2 +-
 drivers/irqchip/irq-gic-its-msi-parent.c    | 210 +++++++++++++++++++-
 drivers/irqchip/irq-gic-its-msi-parent.h    |  11 +-
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 210 +-------------------
 drivers/irqchip/irq-gic-v3-its.c            |   1 +-
 7 files changed, 228 insertions(+), 213 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-its-msi-parent.c
 create mode 100644 drivers/irqchip/irq-gic-its-msi-parent.h
 delete mode 100644 drivers/irqchip/irq-gic-v3-its-msi-parent.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 3e4fb08..f9eae1a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -41,10 +41,14 @@ config ARM_GIC_V3
 	select HAVE_ARM_SMCCC_DISCOVERY
 	select IRQ_MSI_IOMMU
 
+config ARM_GIC_ITS_PARENT
+	bool
+
 config ARM_GIC_V3_ITS
 	bool
 	select GENERIC_MSI_IRQ
 	select IRQ_MSI_LIB
+	select ARM_GIC_ITS_PARENT
 	default ARM_GIC_V3
 	select IRQ_MSI_IOMMU
 
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 7a0e6ce..3ce6ea9 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -33,7 +33,8 @@ obj-$(CONFIG_ARCH_REALVIEW)		+= irq-gic-realview.o
 obj-$(CONFIG_IRQ_MSI_LIB)		+= irq-msi-lib.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
-obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
+obj-$(CONFIG_ARM_GIC_ITS_PARENT)	+= irq-gic-its-msi-parent.o
+obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v4.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
 obj-$(CONFIG_ARM_GIC_V5)		+= irq-gic-v5.o irq-gic-v5-irs.o
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 020ecdf..710cab6 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -29,8 +29,6 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data);
 
-extern const struct msi_parent_ops gic_v3_its_msi_parent_ops;
-
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED     (1 << 1)
 #define RDIST_FLAGS_FORCE_NON_SHAREABLE        (1 << 2)
diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
new file mode 100644
index 0000000..8beecfe
--- /dev/null
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
+// Author: Marc Zyngier <marc.zyngier@arm.com>
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#include <linux/acpi_iort.h>
+#include <linux/pci.h>
+
+#include "irq-gic-its-msi-parent.h"
+#include <linux/irqchip/irq-msi-lib.h>
+
+#define ITS_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define ITS_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_PCI_MSIX      |	\
+				 MSI_FLAG_MULTI_PCI_MSI)
+
+#ifdef CONFIG_PCI_MSI
+static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
+{
+	int msi, msix, *count = data;
+
+	msi = max(pci_msi_vec_count(pdev), 0);
+	msix = max(pci_msix_vec_count(pdev), 0);
+	*count += max(msi, msix);
+
+	return 0;
+}
+
+static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct pci_dev **alias_dev = data;
+
+	*alias_dev = pdev;
+
+	return 0;
+}
+
+static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
+			       int nvec, msi_alloc_info_t *info)
+{
+	struct pci_dev *pdev, *alias_dev;
+	struct msi_domain_info *msi_info;
+	int alias_count = 0, minnvec = 1;
+
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	pdev = to_pci_dev(dev);
+	/*
+	 * If pdev is downstream of any aliasing bridges, take an upper
+	 * bound of how many other vectors could map to the same DevID.
+	 * Also tell the ITS that the signalling will come from a proxy
+	 * device, and that special allocation rules apply.
+	 */
+	pci_for_each_dma_alias(pdev, its_get_pci_alias, &alias_dev);
+	if (alias_dev != pdev) {
+		if (alias_dev->subordinate)
+			pci_walk_bus(alias_dev->subordinate,
+				     its_pci_msi_vec_count, &alias_count);
+		info->flags |= MSI_ALLOC_FLAGS_PROXY_DEVICE;
+	}
+
+	/* ITS specific DeviceID, as the core ITS ignores dev. */
+	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain->parent, pdev);
+
+	/*
+	 * Always allocate a power of 2, and special case device 0 for
+	 * broken systems where the DevID is not wired (and all devices
+	 * appear as DevID 0). For that reason, we generously allocate a
+	 * minimum of 32 MSIs for DevID 0. If you want more because all
+	 * your devices are aliasing to DevID 0, consider fixing your HW.
+	 */
+	nvec = max(nvec, alias_count);
+	if (!info->scratchpad[0].ul)
+		minnvec = 32;
+	nvec = max_t(int, minnvec, roundup_pow_of_two(nvec));
+
+	msi_info = msi_get_domain_info(domain->parent);
+	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, info);
+}
+#else /* CONFIG_PCI_MSI */
+#define its_pci_msi_prepare	NULL
+#endif /* !CONFIG_PCI_MSI */
+
+static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
+				  u32 *dev_id)
+{
+	int ret, index = 0;
+
+	/* Suck the DeviceID out of the msi-parent property */
+	do {
+		struct of_phandle_args args;
+
+		ret = of_parse_phandle_with_args(dev->of_node,
+						 "msi-parent", "#msi-cells",
+						 index, &args);
+		if (args.np == irq_domain_get_of_node(domain)) {
+			if (WARN_ON(args.args_count != 1))
+				return -EINVAL;
+			*dev_id = args.args[0];
+			break;
+		}
+		index++;
+	} while (!ret);
+
+	if (ret) {
+		struct device_node *np = NULL;
+
+		ret = of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, dev_id);
+		if (np)
+			of_node_put(np);
+	}
+
+	return ret;
+}
+
+int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
+{
+	return -1;
+}
+
+static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
+			    int nvec, msi_alloc_info_t *info)
+{
+	struct msi_domain_info *msi_info;
+	u32 dev_id;
+	int ret;
+
+	if (dev->of_node)
+		ret = of_pmsi_get_dev_id(domain->parent, dev, &dev_id);
+	else
+		ret = iort_pmsi_get_dev_id(dev, &dev_id);
+	if (ret)
+		return ret;
+
+	/* ITS specific DeviceID, as the core ITS ignores dev. */
+	info->scratchpad[0].ul = dev_id;
+
+	/* Allocate at least 32 MSIs, and always as a power of 2 */
+	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
+
+	msi_info = msi_get_domain_info(domain->parent);
+	return msi_info->ops->msi_prepare(domain->parent,
+					  dev, nvec, info);
+}
+
+static void its_msi_teardown(struct irq_domain *domain, msi_alloc_info_t *info)
+{
+	struct msi_domain_info *msi_info;
+
+	msi_info = msi_get_domain_info(domain->parent);
+	msi_info->ops->msi_teardown(domain->parent, info);
+}
+
+static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		/*
+		 * FIXME: This probably should be done after a (not yet
+		 * existing) post domain creation callback once to make
+		 * support for dynamic post-enable MSI-X allocations
+		 * work without having to reevaluate the domain size
+		 * over and over. It is known already at allocation
+		 * time via info->hwsize.
+		 *
+		 * That should work perfectly fine for MSI/MSI-X but needs
+		 * some thoughts for purely software managed MSI domains
+		 * where the index space is only limited artificially via
+		 * %MSI_MAX_INDEX.
+		 */
+		info->ops->msi_prepare = its_pci_msi_prepare;
+		info->ops->msi_teardown = its_msi_teardown;
+		break;
+	case DOMAIN_BUS_DEVICE_MSI:
+	case DOMAIN_BUS_WIRED_TO_MSI:
+		/*
+		 * FIXME: See the above PCI prepare comment. The domain
+		 * size is also known at domain creation time.
+		 */
+		info->ops->msi_prepare = its_pmsi_prepare;
+		info->ops->msi_teardown = its_msi_teardown;
+		break;
+	default:
+		/* Confused. How did the lib return true? */
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	return true;
+}
+
+const struct msi_parent_ops gic_v3_its_msi_parent_ops = {
+	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
+	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.prefix			= "ITS-",
+	.init_dev_msi_info	= its_init_dev_msi_info,
+};
diff --git a/drivers/irqchip/irq-gic-its-msi-parent.h b/drivers/irqchip/irq-gic-its-msi-parent.h
new file mode 100644
index 0000000..75e223e
--- /dev/null
+++ b/drivers/irqchip/irq-gic-its-msi-parent.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 ARM Limited, All Rights Reserved.
+ */
+
+#ifndef _IRQ_GIC_ITS_MSI_PARENT_H
+#define _IRQ_GIC_ITS_MSI_PARENT_H
+
+extern const struct msi_parent_ops gic_v3_its_msi_parent_ops;
+
+#endif /* _IRQ_GIC_ITS_MSI_PARENT_H */
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
deleted file mode 100644
index a5e110f..0000000
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ /dev/null
@@ -1,210 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-// Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
-// Author: Marc Zyngier <marc.zyngier@arm.com>
-// Copyright (C) 2022 Linutronix GmbH
-// Copyright (C) 2022 Intel
-
-#include <linux/acpi_iort.h>
-#include <linux/pci.h>
-
-#include "irq-gic-common.h"
-#include <linux/irqchip/irq-msi-lib.h>
-
-#define ITS_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
-				 MSI_FLAG_PCI_MSI_MASK_PARENT)
-
-#define ITS_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
-				 MSI_FLAG_PCI_MSIX      |	\
-				 MSI_FLAG_MULTI_PCI_MSI)
-
-#ifdef CONFIG_PCI_MSI
-static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
-{
-	int msi, msix, *count = data;
-
-	msi = max(pci_msi_vec_count(pdev), 0);
-	msix = max(pci_msix_vec_count(pdev), 0);
-	*count += max(msi, msix);
-
-	return 0;
-}
-
-static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
-{
-	struct pci_dev **alias_dev = data;
-
-	*alias_dev = pdev;
-
-	return 0;
-}
-
-static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
-			       int nvec, msi_alloc_info_t *info)
-{
-	struct pci_dev *pdev, *alias_dev;
-	struct msi_domain_info *msi_info;
-	int alias_count = 0, minnvec = 1;
-
-	if (!dev_is_pci(dev))
-		return -EINVAL;
-
-	pdev = to_pci_dev(dev);
-	/*
-	 * If pdev is downstream of any aliasing bridges, take an upper
-	 * bound of how many other vectors could map to the same DevID.
-	 * Also tell the ITS that the signalling will come from a proxy
-	 * device, and that special allocation rules apply.
-	 */
-	pci_for_each_dma_alias(pdev, its_get_pci_alias, &alias_dev);
-	if (alias_dev != pdev) {
-		if (alias_dev->subordinate)
-			pci_walk_bus(alias_dev->subordinate,
-				     its_pci_msi_vec_count, &alias_count);
-		info->flags |= MSI_ALLOC_FLAGS_PROXY_DEVICE;
-	}
-
-	/* ITS specific DeviceID, as the core ITS ignores dev. */
-	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain->parent, pdev);
-
-	/*
-	 * Always allocate a power of 2, and special case device 0 for
-	 * broken systems where the DevID is not wired (and all devices
-	 * appear as DevID 0). For that reason, we generously allocate a
-	 * minimum of 32 MSIs for DevID 0. If you want more because all
-	 * your devices are aliasing to DevID 0, consider fixing your HW.
-	 */
-	nvec = max(nvec, alias_count);
-	if (!info->scratchpad[0].ul)
-		minnvec = 32;
-	nvec = max_t(int, minnvec, roundup_pow_of_two(nvec));
-
-	msi_info = msi_get_domain_info(domain->parent);
-	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, info);
-}
-#else /* CONFIG_PCI_MSI */
-#define its_pci_msi_prepare	NULL
-#endif /* !CONFIG_PCI_MSI */
-
-static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
-				  u32 *dev_id)
-{
-	int ret, index = 0;
-
-	/* Suck the DeviceID out of the msi-parent property */
-	do {
-		struct of_phandle_args args;
-
-		ret = of_parse_phandle_with_args(dev->of_node,
-						 "msi-parent", "#msi-cells",
-						 index, &args);
-		if (args.np == irq_domain_get_of_node(domain)) {
-			if (WARN_ON(args.args_count != 1))
-				return -EINVAL;
-			*dev_id = args.args[0];
-			break;
-		}
-		index++;
-	} while (!ret);
-
-	if (ret) {
-		struct device_node *np = NULL;
-
-		ret = of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, dev_id);
-		if (np)
-			of_node_put(np);
-	}
-
-	return ret;
-}
-
-int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
-{
-	return -1;
-}
-
-static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *info)
-{
-	struct msi_domain_info *msi_info;
-	u32 dev_id;
-	int ret;
-
-	if (dev->of_node)
-		ret = of_pmsi_get_dev_id(domain->parent, dev, &dev_id);
-	else
-		ret = iort_pmsi_get_dev_id(dev, &dev_id);
-	if (ret)
-		return ret;
-
-	/* ITS specific DeviceID, as the core ITS ignores dev. */
-	info->scratchpad[0].ul = dev_id;
-
-	/* Allocate at least 32 MSIs, and always as a power of 2 */
-	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
-
-	msi_info = msi_get_domain_info(domain->parent);
-	return msi_info->ops->msi_prepare(domain->parent,
-					  dev, nvec, info);
-}
-
-static void its_msi_teardown(struct irq_domain *domain, msi_alloc_info_t *info)
-{
-	struct msi_domain_info *msi_info;
-
-	msi_info = msi_get_domain_info(domain->parent);
-	msi_info->ops->msi_teardown(domain->parent, info);
-}
-
-static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
-				  struct irq_domain *real_parent, struct msi_domain_info *info)
-{
-	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
-		return false;
-
-	switch(info->bus_token) {
-	case DOMAIN_BUS_PCI_DEVICE_MSI:
-	case DOMAIN_BUS_PCI_DEVICE_MSIX:
-		/*
-		 * FIXME: This probably should be done after a (not yet
-		 * existing) post domain creation callback once to make
-		 * support for dynamic post-enable MSI-X allocations
-		 * work without having to reevaluate the domain size
-		 * over and over. It is known already at allocation
-		 * time via info->hwsize.
-		 *
-		 * That should work perfectly fine for MSI/MSI-X but needs
-		 * some thoughts for purely software managed MSI domains
-		 * where the index space is only limited artificially via
-		 * %MSI_MAX_INDEX.
-		 */
-		info->ops->msi_prepare = its_pci_msi_prepare;
-		info->ops->msi_teardown = its_msi_teardown;
-		break;
-	case DOMAIN_BUS_DEVICE_MSI:
-	case DOMAIN_BUS_WIRED_TO_MSI:
-		/*
-		 * FIXME: See the above PCI prepare comment. The domain
-		 * size is also known at domain creation time.
-		 */
-		info->ops->msi_prepare = its_pmsi_prepare;
-		info->ops->msi_teardown = its_msi_teardown;
-		break;
-	default:
-		/* Confused. How did the lib return true? */
-		WARN_ON_ONCE(1);
-		return false;
-	}
-
-	return true;
-}
-
-const struct msi_parent_ops gic_v3_its_msi_parent_ops = {
-	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
-	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
-	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
-	.bus_select_token	= DOMAIN_BUS_NEXUS,
-	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
-	.prefix			= "ITS-",
-	.init_dev_msi_info	= its_init_dev_msi_info,
-};
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d54fa06..467cb78 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -41,6 +41,7 @@
 #include <asm/exception.h>
 
 #include "irq-gic-common.h"
+#include "irq-gic-its-msi-parent.h"
 #include <linux/irqchip/irq-msi-lib.h>
 
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)

