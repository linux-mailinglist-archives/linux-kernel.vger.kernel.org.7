Return-Path: <linux-kernel+bounces-855811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCB3BE266E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D85004FA607
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0822331B81C;
	Thu, 16 Oct 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H/nBJ42S"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D5319617;
	Thu, 16 Oct 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607077; cv=none; b=p4x1Y+l65gel3Q5B7CbzsCfppSx1k68LbDBqoHOYSX2J12TBTN1d7qNC8PRB9R2LY+2WIK8TSkRJB7A+fePnKDVwF9kkc9cieei/yMdLZwHJ965Jn8S+LSvmZBz230XqgZ5EWKwe0ldA6j2oGt4FN2TVQ+Xt9+bseCqxJDsADks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607077; c=relaxed/simple;
	bh=GO7+ZQ7/W8gsqvxjQ9l8J4XjWzgGHvyrkp2yD6nnWMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hs8orAMuPpMy4NiuZkLJqQNsXXCE4s87N3XGRojPhRW610zpfg+sAVQ9b8X5ha5J4ZHN9crTdYWJgboOTLFRsFyvy0/XlEHonbjcnjVmdSZIhQQIMDg5iByIUuERZn5kVCE5edJP+cp+YI35QHtN8LfExTZG9ODUxA2VWPRo64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H/nBJ42S; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760607068;
	bh=GO7+ZQ7/W8gsqvxjQ9l8J4XjWzgGHvyrkp2yD6nnWMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/nBJ42Sk9XnPRRtgIPjyUvPrCxofQnRPIIep050Ctm66S2FcFhp9VJgVJ0eri3cJ
	 x654CjsYLM4ITaTj25X3lNQBDW3ujK9KKGx3cb3NTU9Ow54yg6ZriZ9nga/qJcXwBc
	 ITRhYpP3q86AdsUJAPo+GstI70AMWmBCD43psp+v2QydHSoWYaMVsQCv6IsILj4+iJ
	 ieBazO6eAAxbK3PHXIrZU0WtP/AnhcoKQz4IuuEu7jMALe41L9WyFZZREKLT4vvez8
	 hxP4BliLRpYZ86Yb9m5NXZWiFArCLphwT4LVqDmOIxTl98ZaYEaHxn3M79DEY3Bu3n
	 qjcmTDZgVs9LA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0245A17E1413;
	Thu, 16 Oct 2025 11:31:07 +0200 (CEST)
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
Subject: [PATCH v9 9/9] drivers: mfd: Add support for MediaTek SPMI PMICs and MT6363/73
Date: Thu, 16 Oct 2025 11:30:54 +0200
Message-ID: <20251016093054.126293-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016093054.126293-1-angelogioacchino.delregno@collabora.com>
References: <20251016093054.126293-1-angelogioacchino.delregno@collabora.com>
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

As for the interrupt spec, this driver wants 3 interrupt cells,
but ignores the first one: this is because of how this first
revision of the MediaTek SPMI 2.0 Controller works, which does
not hold irq number information in its register, but delegates
that to the SPMI device - it's possible that this will change
in the future with a newer revision of the controller IP, and
this is the main reason for that.

To make use of this implementation, this driver also adds the
required bits to support MediaTek MT6363 and MT6373 SPMI PMICs.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mfd/Kconfig         |  17 ++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/mtk-spmi-pmic.c | 410 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mt6363.h  |  26 +++
 include/linux/mfd/mt6373.h  |  21 ++
 5 files changed, 475 insertions(+)
 create mode 100644 drivers/mfd/mtk-spmi-pmic.c
 create mode 100644 include/linux/mfd/mt6363.h
 create mode 100644 include/linux/mfd/mt6373.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6cec1858947b..fb32d857294f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1120,6 +1120,23 @@ config MFD_MT6397
 	  accessing the device; additional drivers must be enabled in order
 	  to use the functionality of the device.
 
+config MFD_MTK_SPMI_PMIC
+	tristate "MediaTek SPMI PMICs"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on OF
+	depends on SPMI
+	select REGMAP_SPMI
+	default y if ARCH_MEDIATEK
+	help
+	  Say yes here to enable support for MediaTek's SPMI PMICs.
+	  These PMICs made their first appearance in board designs using the
+          MediaTek Dimensity 9400 series of SoCs.
+	  Note that this will only be useful paired with descriptions of the
+	  independent functions as children nodes in the device tree.
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
index 000000000000..a8e5387339a3
--- /dev/null
+++ b/drivers/mfd/mtk-spmi-pmic.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ * Copyright (c) 2025 Collabora Ltd
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/spmi.h>
+#include <linux/types.h>
+#include <linux/regmap.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/mfd/mt6363.h>
+#include <linux/mfd/mt6373.h>
+
+#define MTK_SPMI_PMIC_VAL_BITS		8
+#define MTK_SPMI_PMIC_CHIP_ID_REG_M	0xb
+#define MTK_SPMI_PMIC_RCS_IRQ_DONE	0x41b
+
+/**
+ * mtk_spmi_pmic_irq_group - Group of interrupts in SPMI PMIC
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
+ * mtk_spmi_pmic_pdata - SPMI PMIC Platform Data
+ * @pmic_irq:    Group of interrupts in SPMI PMIC
+ * @num_groups:  Number of groups of interrupts
+ * @con_reg_sz:  Size of Control registers, depends on existence
+ *               of SET and CLR registers in the layout
+ * @top_irq_reg: Global interrupt status register, explains which
+ *               group needs attention because of a group irq
+ * @chip_id_reg: Chip ID Register
+ */
+struct mtk_spmi_pmic_pdata {
+	const struct mtk_spmi_pmic_irq_grp *pmic_irq;
+	u8 num_groups;
+	u8 con_reg_sz;
+	u8 top_irq_reg;
+	u8 chip_id_reg;
+};
+
+/**
+ * mtk_spmi_pmic - Main driver structure
+ * @pdata:    SPMI PMIC Platform data
+ * @dev:      Handle to SPMI Device
+ * @dom:      IRQ Domain of the PMIC's interrupt controller
+ * @regmap:   Handle to PMIC regmap
+ * @irq_lock: Lock for the PMIC's irqchip
+ * @irq:      PMIC chained interrupt
+ */
+struct mtk_spmi_pmic {
+	const struct mtk_spmi_pmic_pdata *pdata;
+	struct device *dev;
+	struct irq_domain *dom;
+	struct regmap *regmap;
+	struct mutex irq_lock;
+	int irq;
+};
+
+static void mtk_spmi_pmic_irq_set_unmasking(struct irq_data *d, bool unmask)
+{
+	struct mtk_spmi_pmic *pmic = irq_data_get_irq_chip_data(d);
+	const struct mtk_spmi_pmic_pdata *pdata = pmic->pdata;
+	struct regmap *regmap = pmic->regmap;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned short i;
+
+	for (i = 0; i < pdata->num_groups; i++) {
+		const struct mtk_spmi_pmic_irq_grp *irq_grp = &pdata->pmic_irq[i];
+		u32 con_reg;
+		u8 irq_en_bit;
+
+		if (hwirq < irq_grp->hwirq_base)
+			continue;
+
+		con_reg = irq_grp->con_reg + (pdata->con_reg_sz * i);
+		irq_en_bit = hwirq - irq_grp->hwirq_base;
+
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
+static void mtk_spmi_pmic_irq_lock(struct irq_data *d)
+{
+	struct mtk_spmi_pmic *pmic = irq_data_get_irq_chip_data(d);
+
+	mutex_lock(&pmic->irq_lock);
+}
+
+static void mtk_spmi_pmic_irq_sync_unlock(struct irq_data *d)
+{
+	struct mtk_spmi_pmic *pmic = irq_data_get_irq_chip_data(d);
+
+	mutex_unlock(&pmic->irq_lock);
+}
+
+static struct irq_chip mtk_spmi_pmic_irq_chip = {
+	.name = "mtk-spmi-pmic",
+	.irq_mask = mtk_spmi_pmic_irq_mask,
+	.irq_unmask = mtk_spmi_pmic_irq_unmask,
+	.irq_bus_lock = mtk_spmi_pmic_irq_lock,
+	.irq_bus_sync_unlock = mtk_spmi_pmic_irq_sync_unlock,
+	.flags = IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int mtk_spmi_pmic_irq_domain_map(struct irq_domain *d, unsigned int virq,
+					irq_hw_number_t hwirq)
+{
+	struct mtk_spmi_pmic *pmic = d->host_data;
+
+	irq_set_chip_data(virq, pmic);
+	irq_set_chip_and_handler(virq, &mtk_spmi_pmic_irq_chip, handle_level_irq);
+
+	return 0;
+}
+
+static int mtk_spmi_pmic_irq_xlate(struct irq_domain *d, struct device_node *ctrlr,
+				  const u32 *intspec, unsigned int intsize,
+				  unsigned long *out_hwirq, unsigned int *out_type)
+{
+	struct mtk_spmi_pmic *pmic = d->host_data;
+	struct device *dev = pmic->dev;
+
+	if (intsize < 3) {
+		dev_err(dev, "Expected IRQ specifier of size 3, got %u\n", intsize);
+		return -EINVAL;
+	}
+
+	/*
+	 * The IRQ number in intspec[0] is ignored on purpose here!
+	 *
+	 * This is because of how at least the first revision of the SPMI 2.0
+	 * controller works in MediaTek SoCs: the controller will raise an
+	 * interrupt for each SID (but doesn't know the details!), and the
+	 * specific IRQ number that got raised must be read from the PMIC or
+	 * its sub-device driver.
+	 * It's possible that this will change in the future with a newer
+	 * revision of the SPMI controller, and this is why the devicetree
+	 * holds the full intspec.
+	 */
+	*out_hwirq = intspec[1];
+	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
+
+	dev_dbg(dev, "Found device IRQ %u chained from SPMI IRQ %x (map: 0x%lx)\n",
+		intspec[1], intspec[0], *out_hwirq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops mtk_spmi_pmic_irq_domain_ops = {
+	.map = mtk_spmi_pmic_irq_domain_map,
+	.xlate = mtk_spmi_pmic_irq_xlate,
+};
+
+static int mtk_spmi_pmic_handle_group_irq(struct mtk_spmi_pmic *pmic, int group)
+{
+	const struct mtk_spmi_pmic_irq_grp *irq_grp = &pmic->pdata->pmic_irq[group];
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
+			/* Each reg has 8 bits: this is the first irq of this group */
+			hwirq = MTK_SPMI_PMIC_VAL_BITS * i;
+
+			/* Offset by this group's start interrupt */
+			hwirq += irq_grp->hwirq_base;
+
+			/* Finally, offset by the fired irq's bit number */
+			hwirq += bit;
+
+			status &= ~BIT(bit);
+
+			generic_handle_domain_irq(pmic->dom, hwirq);
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
+	const struct mtk_spmi_pmic_pdata *pdata = pmic->pdata;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct regmap *regmap = pmic->regmap;
+	bool irq_handled = false;
+	int i, ret;
+	u32 val;
+
+	chained_irq_enter(chip, desc);
+
+	ret = regmap_read(regmap, pdata->top_irq_reg, &val);
+	if (ret)
+		handle_bad_irq(desc);
+
+	dev_dbg(pmic->dev, "PMIC IRQ Status: %x\n", val);
+
+	/* This is very unlikely to happen */
+	if (val == 0) {
+		chained_irq_exit(chip, desc);
+		return;
+	}
+
+	for (i = 0; i < pdata->num_groups; i++) {
+		const struct mtk_spmi_pmic_irq_grp *irq_grp = &pdata->pmic_irq[i];
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
+static int mtk_spmi_pmic_irq_init(struct spmi_device *sdev, struct regmap *regmap,
+				  const struct mtk_spmi_pmic_pdata *pdata)
+{
+	struct mtk_spmi_pmic *pmic;
+	int ret;
+
+	pmic = devm_kzalloc(&sdev->dev, sizeof(*pmic), GFP_KERNEL);
+	if (!pmic)
+		return -ENOMEM;
+
+	pmic->irq = of_irq_get(sdev->dev.of_node, 0);
+	if (pmic->irq < 0)
+		return dev_err_probe(&sdev->dev, pmic->irq, "Cannot get IRQ\n");
+
+	pmic->dev = &sdev->dev;
+	pmic->regmap = regmap;
+	pmic->pdata = pdata;
+	mutex_init(&pmic->irq_lock);
+
+	pmic->dom = irq_domain_add_tree(sdev->dev.of_node,
+					&mtk_spmi_pmic_irq_domain_ops, pmic);
+	if (!pmic->dom)
+		return dev_err_probe(&sdev->dev, -ENOMEM, "Cannot create IRQ domain\n");
+
+	ret = devm_add_action_or_reset(&sdev->dev, mtk_spmi_pmic_irq_remove, pmic);
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
+#define MTK_SPMI_PMIC_IRQ_GROUP(pmic, grp, gnum, first_irq, last_irq)	\
+{									\
+	.hwirq_base = first_irq,					\
+	.num_int_regs = ((last_irq - first_irq) /			\
+			 MTK_SPMI_PMIC_VAL_BITS) + 1,			\
+	.con_reg = pmic##_##grp##_TOP_INT_CON0,				\
+	.sta_reg = pmic##_##grp##_TOP_INT_STATUS0,			\
+	.group_num = gnum,						\
+}
+
+static const struct mtk_spmi_pmic_irq_grp mt6363_irq_groups[] = {
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, BUCK, 0, 0, 9),
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, LDO, 1, 16, 40),
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, PSC, 2, 48, 57),
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, MISC, 3, 64, 79),
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, HK, 4, 80, 87),
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6363, BM, 6, 88, 107)
+};
+
+static const struct mtk_spmi_pmic_irq_grp mt6373_irq_groups[] = {
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6373, BUCK, 0, 0, 9),
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6373, LDO, 1, 16, 39),
+	MTK_SPMI_PMIC_IRQ_GROUP(MT6373, MISC, 3, 56, 71),
+};
+
+static const struct mtk_spmi_pmic_pdata mt6363_pdata = {
+	.pmic_irq = mt6363_irq_groups,
+	.num_groups = ARRAY_SIZE(mt6363_irq_groups),
+	.con_reg_sz = 3,
+	.top_irq_reg = MT6363_TOP_INT_STATUS1,
+	.chip_id_reg = MTK_SPMI_PMIC_CHIP_ID_REG_M,
+};
+
+static const struct mtk_spmi_pmic_pdata mt6373_pdata = {
+	.pmic_irq = mt6373_irq_groups,
+	.num_groups = ARRAY_SIZE(mt6373_irq_groups),
+	.con_reg_sz = 3,
+	.top_irq_reg = MT6373_TOP_INT_STATUS1,
+	.chip_id_reg = MTK_SPMI_PMIC_CHIP_ID_REG_M,
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
+	const struct mtk_spmi_pmic_pdata *pdata;
+	struct device *dev = &sdev->dev;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_spmi_ext(sdev, &mtk_spmi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	pdata = (const struct mtk_spmi_pmic_pdata *)device_get_match_data(&sdev->dev);
+	if (pdata && pdata->num_groups) {
+		ret = mtk_spmi_pmic_irq_init(sdev, regmap, pdata);
+		if (ret)
+			return ret;
+	}
+
+	return devm_of_platform_populate(dev);
+}
+
+static const struct of_device_id mtk_pmic_spmi_id_table[] = {
+	{ .compatible = "mediatek,mt6363", .data = &mt6363_pdata },
+	{ .compatible = "mediatek,mt6373", .data = &mt6373_pdata },
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
diff --git a/include/linux/mfd/mt6363.h b/include/linux/mfd/mt6363.h
new file mode 100644
index 000000000000..2e13398f5af5
--- /dev/null
+++ b/include/linux/mfd/mt6363.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Copyright (c) 2025 Collabora Ltd
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef __MFD_MT6363_H__
+#define __MFD_MT6363_H__
+
+/* PMIC Registers */
+#define MT6363_MISC_TOP_INT_CON0	0x37
+#define MT6363_MISC_TOP_INT_STATUS0	0x43
+#define MT6363_TOP_INT_STATUS1		0x4e
+#define MT6363_PSC_TOP_INT_CON0		0x90f
+#define MT6363_PSC_TOP_INT_STATUS0	0x91b
+#define MT6363_BM_TOP_INT_CON0		0xc24
+#define MT6363_BM_TOP_INT_STATUS0	0xc36
+#define MT6363_HK_TOP_INT_CON0		0xf92
+#define MT6363_HK_TOP_INT_STATUS0	0xf9e
+#define MT6363_BUCK_TOP_INT_CON0	0x1411
+#define MT6363_BUCK_TOP_INT_STATUS0	0x141d
+#define MT6363_LDO_TOP_INT_CON0		0x1b11
+#define MT6363_LDO_TOP_INT_STATUS0	0x1b29
+
+#endif /* __MFD_MT6363_H__ */
diff --git a/include/linux/mfd/mt6373.h b/include/linux/mfd/mt6373.h
new file mode 100644
index 000000000000..3509e46447bd
--- /dev/null
+++ b/include/linux/mfd/mt6373.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Copyright (c) 2025 Collabora Ltd
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef __MFD_MT6373_H__
+#define __MFD_MT6373_H__
+
+/* PMIC Registers */
+#define MT6373_MISC_TOP_INT_CON0	0x3c
+#define MT6373_MISC_TOP_INT_STATUS0	0x48
+#define MT6373_TOP_INT_MASK_CON0	0x4c
+#define MT6373_TOP_INT_STATUS1		0x53
+#define MT6373_BUCK_TOP_INT_CON0	0x1411
+#define MT6373_BUCK_TOP_INT_STATUS0	0x141d
+#define MT6373_LDO_TOP_INT_CON0		0x1b10
+#define MT6373_LDO_TOP_INT_STATUS0	0x1b22
+
+#endif /* __MFD_MT6373_H__ */
-- 
2.51.0


