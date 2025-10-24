Return-Path: <linux-kernel+bounces-868379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE8EC0515B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95969402492
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80B83081CE;
	Fri, 24 Oct 2025 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dr2rK6KB"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840AD305E0C;
	Fri, 24 Oct 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294769; cv=none; b=tEB913DKI0s3K72YnOg+JLsLmKRmQrsC8Avvgz5FMxTliK3BMhyB7FE/IkTaM1P2/uhnONWU7iXwy+XolKSFJXodYqwQJKm/x7M/H7hzv5Dnv8EhiZ2wBhrCpXTwIrIfjQuYhxiU6r5d1KOzrTAOdDrdrg6EAN/EIcqDIbbjUpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294769; c=relaxed/simple;
	bh=pQHNTc8oLiehhPt9mLgCj0DuT6FtqbWbJn7oXh8qHHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnQnP2JXmFsVMvmskK0oMvItdbhbApWOBjp/ZpDQ0nCrcoplXgayzGG4vGrx4YYJlFmAYaJPb2BLZ/DUlIYlYxIm4y6Q3Qd4ZC0bw45o7vuL/D+DsBciYfkXduenPq/LwALDETkiejxjuiOFMfy7qfGLSTgia9j1rrl2OA8PYYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dr2rK6KB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761294764;
	bh=pQHNTc8oLiehhPt9mLgCj0DuT6FtqbWbJn7oXh8qHHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dr2rK6KBn55vCw6w4lhA94R+CTZ+qLAL7fep2ziGxqj8GDJACOHlHJ2akJa1+UfVy
	 dEWaHotlFo+c+BBjjbpwpZRwfO8AyRsWeHZVjdn9u4mWrCX1OAAM4hiC5issJmICbd
	 XZpwRZQdXGoPw7D+FHxPuIYU5fxyt4HpAAXDLY4s+21k873csw+UvS5wyQy0psUfTZ
	 u4wiKIyacCw1FqpqIqJgAYWfJ2C+eOn1FocWfMMgX6eCv6O14xyJ8Bv3nXqCFgGN1a
	 +b6OQGs9HuotrQjBzQq2NE1lJSzUKujUNnt2rbtKsA8zZSMF3u5VVQ+XhOovfV1v+W
	 qHQ/BU2C/p9ow==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F82117E1310;
	Fri, 24 Oct 2025 10:32:44 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v10 9/9] mfd: Add support for MediaTek SPMI PMICs and MT6363/73
Date: Fri, 24 Oct 2025 10:32:21 +0200
Message-ID: <20251024083221.25758-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024083221.25758-1-angelogioacchino.delregno@collabora.com>
References: <20251024083221.25758-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver adds support for the MediaTek SPMI PMICs and their
interrupt controller (which is present in 95% of the cases).

Other than probing all of the sub-devices of a SPMI PMIC, this
sets up a regmap from the relevant SPMI bus and initializes an
interrupt controller with its irq domain and irqchip to handle
chained interrupts, with the SPMI bus itself being its parent
irq controller, and the PMIC being the outmost device.

This driver hence holds all of the information about a specific
PMIC's interrupts and will properly handle them, calling the
ISR for any subdevice that requested an interrupt.

As for the interrupt spec, this driver wants either three or
two interrupt cells, but in the case 3 were given it ignores
the first one: this is because of how this first revision of
of the MediaTek SPMI 2.0 Controller works, which doesn't hold
hold irq number information in its register, but delegates
that to the SPMI device - it's possible that this will change
in the future with a newer revision of the controller IP, and
this is the main reason for that.

To make use of this implementation, this driver also adds the
required bits to support MediaTek MT6363 and MT6373 SPMI PMICs.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mfd/Kconfig                       |  16 +
 drivers/mfd/Makefile                      |   1 +
 drivers/mfd/mtk-spmi-pmic.c               | 427 ++++++++++++++++++++++
 include/linux/mfd/mt63x3_spmi/registers.h |  34 ++
 4 files changed, 478 insertions(+)
 create mode 100644 drivers/mfd/mtk-spmi-pmic.c
 create mode 100644 include/linux/mfd/mt63x3_spmi/registers.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6cec1858947b..d47a8661e68b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1120,6 +1120,22 @@ config MFD_MT6397
 	  accessing the device; additional drivers must be enabled in order
 	  to use the functionality of the device.
 
+config MFD_MTK_SPMI_PMIC
+	tristate "MediaTek SPMI PMICs"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on OF
+	depends on SPMI
+	select REGMAP_SPMI
+	help
+	  Say yes here to enable support for MediaTek's SPMI PMICs.
+	  These PMICs made their first appearance in board designs using the
+	  MediaTek Dimensity 9400 series of SoCs.
+	  Note that this will only be useful when paired with descriptions
+	  of the independent functions as child nodes in the device tree.
+
+	  Say M here if you want to include support for the MediaTek SPMI
+	  PMICs as a module. The module will be called "mtk-spmi-pmic".
+
 config MFD_MENF21BMC
 	tristate "MEN 14F021P00 Board Management Controller Support"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 865e9f12faff..33e5192c4ce3 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -188,6 +188,7 @@ obj-$(CONFIG_MFD_MT6360)	+= mt6360-core.o
 obj-$(CONFIG_MFD_MT6370)	+= mt6370.o
 mt6397-objs			:= mt6397-core.o mt6397-irq.o mt6358-irq.o
 obj-$(CONFIG_MFD_MT6397)	+= mt6397.o
+obj-$(CONFIG_MFD_MTK_SPMI_PMIC)	+= mtk-spmi-pmic.o
 
 obj-$(CONFIG_RZ_MTU3)		+= rz-mtu3.o
 obj-$(CONFIG_ABX500_CORE)	+= abx500-core.o
diff --git a/drivers/mfd/mtk-spmi-pmic.c b/drivers/mfd/mtk-spmi-pmic.c
new file mode 100644
index 000000000000..d1fc8156e696
--- /dev/null
+++ b/drivers/mfd/mtk-spmi-pmic.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek SPMI PMICs Driver
+ *
+ * Copyright (c) 2024 MediaTek Inc.
+ * Copyright (c) 2025 Collabora Ltd
+ *
+ * Authors:
+ * AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/mfd/mt63x3_spmi/registers.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/spmi.h>
+#include <linux/types.h>
+
+#define MTK_SPMI_PMIC_VAL_BITS		8
+#define MTK_SPMI_PMIC_REG_CHIP_ID	0xb
+#define MTK_SPMI_PMIC_RCS_IRQ_DONE	0x41b
+
+/**
+ * struct mtk_spmi_pmic_irq_group - Group of interrupts in SPMI PMIC
+ * @num_int_regs: Number of registers for this group of interrupts
+ * @con_reg:      PMIC Interrupt Group Control 0 register
+ * @sta_reg:      PMIC Interrupt Group Status 0 register
+ * @group_num:    PMIC Interrupt Group number - also corresponds to the
+ *                status bit in the global IRQ Control register
+ */
+struct mtk_spmi_pmic_irq_grp {
+	u8 hwirq_base;
+	u8 num_int_regs;
+	u16 con_reg;
+	u16 sta_reg;
+	u8 group_num;
+};
+
+/**
+ * struct mtk_spmi_pmic_variant - SPMI PMIC variant-specific data
+ * @pmic_irq:    Group of interrupts in SPMI PMIC
+ * @num_groups:  Number of groups of interrupts
+ * @con_reg_len: Length in bytes of Control registers, depends on
+ *               existence of SET and CLR registers in the layout
+ * @irq_grp_reg: Global interrupt status register, explains which
+ *               group needs attention because of a group IRQ;
+ *               if this is zero, it means that there is only one
+ *               group and the device has no irqgroup register
+ * @chip_id_reg: Chip ID Register
+ */
+struct mtk_spmi_pmic_variant {
+	const struct mtk_spmi_pmic_irq_grp *pmic_irq;
+	u8 num_groups;
+	u8 con_reg_len;
+	u8 irq_grp_reg;
+	u8 chip_id_reg;
+};
+
+/**
+ * struct mtk_spmi_pmic - Main driver structure
+ * @variant:  SPMI PMIC variant-specific data
+ * @dev:      Handle to SPMI Device
+ * @dom:      IRQ Domain of the PMIC's interrupt controller
+ * @regmap:   Handle to PMIC regmap
+ * @irq:      PMIC chained interrupt
+ */
+struct mtk_spmi_pmic {
+	const struct mtk_spmi_pmic_variant *variant;
+	struct device *dev;
+	struct irq_domain *dom;
+	struct regmap *regmap;
+	int irq;
+};
+
+static void mtk_spmi_pmic_irq_set_unmasking(struct irq_data *d, bool unmask)
+{
+	struct mtk_spmi_pmic *pmic = irq_data_get_irq_chip_data(d);
+	const struct mtk_spmi_pmic_variant *variant = pmic->variant;
+	struct regmap *regmap = pmic->regmap;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned short i;
+
+	for (i = 0; i < variant->num_groups; i++) {
+		const struct mtk_spmi_pmic_irq_grp *irq_grp = &variant->pmic_irq[i];
+		u32 con_reg;
+		u8 irq_en_bit;
+
+		if (hwirq < irq_grp->hwirq_base)
+			continue;
+
+		con_reg = irq_grp->con_reg + (variant->con_reg_len * i);
+		irq_en_bit = hwirq - irq_grp->hwirq_base;
+		regmap_assign_bits(regmap, con_reg, BIT(irq_en_bit), unmask);
+
+		break;
+	}
+}
+
+static void mtk_spmi_pmic_irq_mask(struct irq_data *d)
+{
+	mtk_spmi_pmic_irq_set_unmasking(d, false);
+}
+
+static void mtk_spmi_pmic_irq_unmask(struct irq_data *d)
+{
+	mtk_spmi_pmic_irq_set_unmasking(d, true);
+}
+
+static struct irq_chip mtk_spmi_pmic_irq_chip = {
+	.name = "mtk-spmi-pmic",
+	.irq_mask = mtk_spmi_pmic_irq_mask,
+	.irq_unmask = mtk_spmi_pmic_irq_unmask,
+	.flags = IRQCHIP_SKIP_SET_WAKE,
+};
+
+static struct lock_class_key mtk_spmi_pmic_irq_lock_class, mtk_spmi_pmic_irq_request_class;
+
+static int mtk_spmi_pmic_irq_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
+				       unsigned long *out_hwirq, unsigned int *out_type)
+{
+	struct mtk_spmi_pmic *pmic = d->host_data;
+	u32 intsize = fwspec->param_count;
+	u32 *intspec = fwspec->param;
+	unsigned int irq_type_index;
+	unsigned int irq_num_index;
+
+	/*
+	 * Interrupt cell index - For interrupt size 3:
+	 * [0] - SID Interrupt number
+	 * [1] - SPMI PMIC (Sub-)Device Interrupt number
+	 * [2] - Interrupt Type mask
+	 *
+	 * When only two cells are specified the SID Interrupt is not present.
+	 */
+	if (intsize != 2 && intsize != 3) {
+		dev_err(pmic->dev, "Expected IRQ specifier of size 2 or 3, got %u\n", intsize);
+		return -EINVAL;
+	}
+
+	/* irq_num_index refers to the SPMI (Sub-)Device Interrupt number */
+	irq_num_index = intsize - 2;
+	irq_type_index = irq_num_index + 1;
+
+	/*
+	 * For 3 cells, the IRQ number in intspec[0] is ignored on purpose here!
+	 *
+	 * This is because of how at least the first revision of the SPMI 2.0
+	 * controller works in MediaTek SoCs: the controller will raise an
+	 * interrupt for each SID (but doesn't know the details), and the
+	 * specific IRQ number that got raised must be read from the PMIC or
+	 * its sub-device driver.
+	 * It's possible that this will change in the future with a newer
+	 * revision of the SPMI controller, and this is why the device tree
+	 * holds the full interrupt specifier.
+	 *
+	 * out_hwirq: SPMI PMIC (Sub-)Device Interrupt number
+	 * out_type:  Interrupt type sense mask
+	 */
+	*out_hwirq = intspec[irq_num_index];
+	*out_type = intspec[irq_type_index] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
+static int mtk_spmi_pmic_irq_alloc(struct irq_domain *d, unsigned int virq,
+				   unsigned int nr_irqs, void *data)
+{
+	struct mtk_spmi_pmic *pmic = d->host_data;
+	struct irq_fwspec *fwspec = data;
+	irq_hw_number_t hwirq;
+	unsigned int irqtype;
+	int i, ret;
+
+	ret = mtk_spmi_pmic_irq_translate(d, fwspec, &hwirq, &irqtype);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_set_lockdep_class(virq, &mtk_spmi_pmic_irq_lock_class,
+				      &mtk_spmi_pmic_irq_request_class);
+		irq_domain_set_info(d, virq, hwirq, &mtk_spmi_pmic_irq_chip,
+				    pmic, handle_level_irq, NULL, NULL);
+	}
+
+	return 0;
+}
+
+
+static const struct irq_domain_ops mtk_spmi_pmic_irq_domain_ops = {
+	.alloc = mtk_spmi_pmic_irq_alloc,
+	.free = irq_domain_free_irqs_common,
+	.translate = mtk_spmi_pmic_irq_translate,
+};
+
+static int mtk_spmi_pmic_handle_group_irq(struct mtk_spmi_pmic *pmic, int group)
+{
+	const struct mtk_spmi_pmic_irq_grp *irq_grp = &pmic->variant->pmic_irq[group];
+	struct regmap *regmap = pmic->regmap;
+	struct device *dev = pmic->dev;
+	int i, ret;
+
+	for (i = 0; i < irq_grp->num_int_regs; i++) {
+		u32 status, saved_status;
+
+		ret = regmap_read(regmap, irq_grp->sta_reg + i, &status);
+		if (ret) {
+			dev_err(dev, "Could not read IRQ status register: %d", ret);
+			return ret;
+		}
+
+		if (status == 0)
+			continue;
+
+		saved_status = status;
+		do {
+			irq_hw_number_t hwirq;
+			u8 bit = __ffs(status);
+
+			/* Each register has 8 bits: this is the first IRQ of this group */
+			hwirq = MTK_SPMI_PMIC_VAL_BITS * i;
+
+			/* Offset by this group's start interrupt */
+			hwirq += irq_grp->hwirq_base;
+
+			/* Finally, offset by the fired IRQ's bit number */
+			hwirq += bit;
+
+			status &= ~BIT(bit);
+
+			generic_handle_domain_irq_safe(pmic->dom, hwirq);
+		} while (status);
+
+		/* Clear the interrupts by writing the previous status */
+		regmap_write(regmap, irq_grp->sta_reg + i, saved_status);
+	}
+
+	return 0;
+}
+
+static void mtk_spmi_pmic_handle_chained_irq(struct irq_desc *desc)
+{
+	struct mtk_spmi_pmic *pmic = irq_desc_get_handler_data(desc);
+	const struct mtk_spmi_pmic_variant *variant = pmic->variant;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct regmap *regmap = pmic->regmap;
+	bool irq_handled = false;
+	int i, ret;
+	u32 val;
+
+	chained_irq_enter(chip, desc);
+
+	/* If irq_grp_reg is present there are multiple IRQ groups */
+	if (variant->irq_grp_reg > 0) {
+		ret = regmap_read(regmap, variant->irq_grp_reg, &val);
+		if (ret)
+			handle_bad_irq(desc);
+
+		/* This is very unlikely to happen */
+		if (val == 0) {
+			chained_irq_exit(chip, desc);
+			return;
+		}
+	} else {
+		val = BIT(0);
+	}
+
+	for (i = 0; i < variant->num_groups; i++) {
+		const struct mtk_spmi_pmic_irq_grp *irq_grp = &variant->pmic_irq[i];
+		u8 group_bit = BIT(irq_grp[i].group_num);
+
+		if (val & group_bit) {
+			ret = mtk_spmi_pmic_handle_group_irq(pmic, i);
+			if (ret == 0)
+				irq_handled = true;
+		}
+	}
+
+	/* The RCS flag has to be cleared even if the IRQ was not handled. */
+	ret = regmap_write(regmap, MTK_SPMI_PMIC_RCS_IRQ_DONE, 1);
+	if (ret)
+		dev_warn(pmic->dev, "Could not clear RCS flag!\n");
+
+	if (!irq_handled)
+		handle_bad_irq(desc);
+
+	chained_irq_exit(chip, desc);
+}
+
+static void mtk_spmi_pmic_irq_remove(void *data)
+{
+	struct mtk_spmi_pmic *pmic = (struct mtk_spmi_pmic *)data;
+
+	irq_set_chained_handler_and_data(pmic->irq, NULL, NULL);
+	irq_domain_remove(pmic->dom);
+}
+
+static int mtk_spmi_pmic_irq_init(struct device *dev, struct regmap *regmap,
+				  const struct mtk_spmi_pmic_variant *variant)
+{
+	struct fwnode_handle *fwnode = of_fwnode_handle(dev->of_node);
+	struct mtk_spmi_pmic *pmic;
+	int ret;
+
+	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
+	if (!pmic)
+		return -ENOMEM;
+
+	pmic->irq = of_irq_get(dev->of_node, 0);
+	if (pmic->irq < 0)
+		return dev_err_probe(dev, pmic->irq, "Cannot get IRQ\n");
+
+	pmic->dev = dev;
+	pmic->regmap = regmap;
+	pmic->variant = variant;
+
+	pmic->dom = irq_domain_create_tree(fwnode, &mtk_spmi_pmic_irq_domain_ops, pmic);
+	if (!pmic->dom)
+		return dev_err_probe(dev, -ENOMEM, "Cannot create IRQ domain\n");
+
+	ret = devm_add_action_or_reset(dev, mtk_spmi_pmic_irq_remove, pmic);
+	if (ret) {
+		irq_domain_remove(pmic->dom);
+		return ret;
+	}
+
+	irq_set_chained_handler_and_data(pmic->irq, mtk_spmi_pmic_handle_chained_irq, pmic);
+
+	return 0;
+}
+
+#define MTK_SPMI_PMIC_IRQ_GROUP(pmic, group_name, group_index, first_irq, last_irq)	\
+{											\
+	.hwirq_base = first_irq,							\
+	.num_int_regs = ((last_irq - first_irq) / MTK_SPMI_PMIC_VAL_BITS) + 1,		\
+	.con_reg = pmic##_REG_##group_name##_TOP_INT_CON0,				\
+	.sta_reg = pmic##_REG_##group_name##_TOP_INT_STATUS0,				\
+	.group_num = group_index,							\
+}
+
+static const struct mtk_spmi_pmic_irq_grp mt6363_irq_groups[] = {
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, BUCK,	0,  0,   9),
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, LDO,	1, 16,  40),
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, PSC,	2, 48,  57),
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, MISC,	3, 64,  79),
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, HK,	4, 80,  87),
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, BM,	6, 88, 107)
+};
+
+static const struct mtk_spmi_pmic_irq_grp mt6373_irq_groups[] = {
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6373, BUCK,	0,  0,  9),
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6373, LDO,	1, 16, 39),
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6373, MISC,	3, 56, 71),
+};
+
+static const struct mtk_spmi_pmic_variant mt6363_variant = {
+	.pmic_irq = mt6363_irq_groups,
+	.num_groups = ARRAY_SIZE(mt6363_irq_groups),
+	.con_reg_len = 3,
+	.irq_grp_reg = MT6363_REG_TOP_INT_STATUS1,
+	.chip_id_reg = MTK_SPMI_PMIC_REG_CHIP_ID,
+};
+
+static const struct mtk_spmi_pmic_variant mt6373_variant = {
+	.pmic_irq = mt6373_irq_groups,
+	.num_groups = ARRAY_SIZE(mt6373_irq_groups),
+	.con_reg_len = 3,
+	.irq_grp_reg = MT6373_REG_TOP_INT_STATUS1,
+	.chip_id_reg = MTK_SPMI_PMIC_REG_CHIP_ID,
+};
+
+static const struct regmap_config mtk_spmi_regmap_config = {
+	.reg_bits	= 16,
+	.val_bits	= MTK_SPMI_PMIC_VAL_BITS,
+	.max_register	= 0xffff,
+	.fast_io	= true,
+};
+
+static int mtk_spmi_pmic_probe(struct spmi_device *sdev)
+{
+	const struct mtk_spmi_pmic_variant *variant;
+	struct device *dev = &sdev->dev;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_spmi_ext(sdev, &mtk_spmi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	variant = (const struct mtk_spmi_pmic_variant *)device_get_match_data(dev);
+	if (variant && variant->num_groups) {
+		ret = mtk_spmi_pmic_irq_init(dev, regmap, variant);
+		if (ret)
+			return ret;
+	}
+
+	return devm_of_platform_populate(dev);
+}
+
+static const struct of_device_id mtk_pmic_spmi_id_table[] = {
+	{ .compatible = "mediatek,mt6363", .data = &mt6363_variant },
+	{ .compatible = "mediatek,mt6373", .data = &mt6373_variant },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mtk_pmic_spmi_id_table);
+
+static struct spmi_driver mtk_spmi_pmic_driver = {
+	.probe = mtk_spmi_pmic_probe,
+	.driver = {
+		.name = "mtk-spmi-pmic",
+		.of_match_table = mtk_pmic_spmi_id_table,
+	},
+};
+module_spmi_driver(mtk_spmi_pmic_driver);
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_DESCRIPTION("MediaTek SPMI PMIC driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/mt63x3_spmi/registers.h b/include/linux/mfd/mt63x3_spmi/registers.h
new file mode 100644
index 000000000000..808927280b40
--- /dev/null
+++ b/include/linux/mfd/mt63x3_spmi/registers.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Copyright (c) 2025 Collabora Ltd
+ */
+
+#ifndef __MFD_MT63X3_SPMI_REGISTERS_H__
+#define __MFD_MT63X3_SPMI_REGISTERS_H__
+
+/* MT6363 PMIC Registers */
+#define MT6363_REG_MISC_TOP_INT_CON0		0x37
+#define MT6363_REG_MISC_TOP_INT_STATUS0		0x43
+#define MT6363_REG_TOP_INT_STATUS1		0x4e
+#define MT6363_REG_PSC_TOP_INT_CON0		0x90f
+#define MT6363_REG_PSC_TOP_INT_STATUS0		0x91b
+#define MT6363_REG_BM_TOP_INT_CON0		0xc24
+#define MT6363_REG_BM_TOP_INT_STATUS0		0xc36
+#define MT6363_REG_HK_TOP_INT_CON0		0xf92
+#define MT6363_REG_HK_TOP_INT_STATUS0		0xf9e
+#define MT6363_REG_BUCK_TOP_INT_CON0		0x1411
+#define MT6363_REG_BUCK_TOP_INT_STATUS0		0x141d
+#define MT6363_REG_LDO_TOP_INT_CON0		0x1b11
+#define MT6363_REG_LDO_TOP_INT_STATUS0		0x1b29
+
+/* MT6373 PMIC Registers */
+#define MT6373_REG_MISC_TOP_INT_CON0		0x3c
+#define MT6373_REG_MISC_TOP_INT_STATUS0		0x48
+#define MT6373_REG_TOP_INT_STATUS1		0x53
+#define MT6373_REG_BUCK_TOP_INT_CON0		0x1411
+#define MT6373_REG_BUCK_TOP_INT_STATUS0		0x141d
+#define MT6373_REG_LDO_TOP_INT_CON0		0x1b10
+#define MT6373_REG_LDO_TOP_INT_STATUS0		0x1b22
+
+#endif /* __MFD_MT63X3_SPMI_REGISTERS_H__ */
-- 
2.51.1


