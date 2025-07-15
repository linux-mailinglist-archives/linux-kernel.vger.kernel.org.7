Return-Path: <linux-kernel+bounces-732002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99552B060EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138621C45B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71330279787;
	Tue, 15 Jul 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KQX1tz3c"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D224243956;
	Tue, 15 Jul 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588207; cv=none; b=V1cAKswOuGv5lpYsTJGYSrjgvt6S3vY/A/lIWEJfJYbZApgEI1YBt6CTnQZpMDjW1Oe9L3XE+UZY9y+4lVl//KR6lvKImysCG2hOeSF/hBWkQ5R6JWLIgfXnGG4uUpWNbjF8HmuyF7IrhDWnO7pp9+1ibeoTgnHG1rIXrTdHMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588207; c=relaxed/simple;
	bh=wWt6KKxEKDldIO+9mKnD7nW4NASWpMyD0GidRvldqFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeF1oyBQPYGTu+ACiKQvzYa1/Ht+tOME6M9LtWp2y83mdkJej6YCO+DGHRY7pcWyqZUmmh9YMLdmZTBsTM5KZTXW+j7KzJBuRSPsQ8jsp1Wa8j4WrLUkZfv74y/XAh/8FDPhRSP1Gp4qdzL7k34RShvJ5YvYNMhvsv3R51gx/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KQX1tz3c; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752588202;
	bh=wWt6KKxEKDldIO+9mKnD7nW4NASWpMyD0GidRvldqFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQX1tz3chJcSBwzIT4QyTFk8YQous9jgwXEebjodYnJwuVehY8QkGiYeYa+2c9POR
	 Q9hvfTGcmqpZPOfLcBALBu2EiCLDCkUJB6RsdJ4sOqanxbdhz8bJZn7Kd2hquYYkqu
	 2BA/8aH6wwxFyCYRgeUdOguHSP0yqIE4aB/DIi6sSv5aFr96k/MSqxrEM0DgVJFzqy
	 BGL6vrnmCgSZZzLFh3rYfC2ZqFA9pQpRorQWedLItFztl5b3NNUTibswvBi0FERf7F
	 r/M7AsWEUjY9FbumP0wIP8XmmfU4pxkkTCDm6m4Z+u5u/gPbR4Sa5ifjT+oV8fVeyf
	 R4tXqGkhSop8w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EEA8C17E0676;
	Tue, 15 Jul 2025 16:03:21 +0200 (CEST)
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
	wenst@chromium.org
Subject: [PATCH v5 6/8] regulator: Add support for MediaTek MT6373 SPMI PMIC Regulators
Date: Tue, 15 Jul 2025 16:02:22 +0200
Message-ID: <20250715140224.206329-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715140224.206329-1-angelogioacchino.delregno@collabora.com>
References: <20250715140224.206329-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the regulators found on the MediaTek MT6373 PMIC,
fully controlled by SPMI interface.
Similarly to MT6363, this PMIC regulates voltage with input range
of 2.6-5.0V, and features 10 buck converters and 25 LDOs.

This PMIC is usually found on board designs using the MT6991 or
MT8196 SoC, in combination with the MT6363 PMIC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/regulator/Kconfig                  |   9 +
 drivers/regulator/Makefile                 |   1 +
 drivers/regulator/mt6373-regulator.c       | 762 +++++++++++++++++++++
 include/linux/regulator/mt6373-regulator.h | 162 +++++
 4 files changed, 934 insertions(+)
 create mode 100644 drivers/regulator/mt6373-regulator.c
 create mode 100644 include/linux/regulator/mt6373-regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index d770e51f7ad1..ae1441c32881 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -953,6 +953,15 @@ config REGULATOR_MT6370
 	  This driver supports the control for DisplayBias voltages and one
 	  general purpose LDO which is commonly used to drive the vibrator.
 
+config REGULATOR_MT6373
+	tristate "MT6373 SPMI PMIC regulator driver"
+	depends on SPMI || COMPILE_TEST
+	help
+          Say Y here to enable support for buck and LDO regulators found in
+          the MediaTek MT6373 SPMI PMIC and its variants.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
+
 config REGULATOR_MT6380
 	tristate "MediaTek MT6380 PMIC"
 	depends on MTK_PMIC_WRAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 41eaeac5547d..d5124ea3c8c2 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -113,6 +113,7 @@ obj-$(CONFIG_REGULATOR_MT6359)	+= mt6359-regulator.o
 obj-$(CONFIG_REGULATOR_MT6360) += mt6360-regulator.o
 obj-$(CONFIG_REGULATOR_MT6363) += mt6363-regulator.o
 obj-$(CONFIG_REGULATOR_MT6370) += mt6370-regulator.o
+obj-$(CONFIG_REGULATOR_MT6373) += mt6373-regulator.o
 obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
 obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_MTK_DVFSRC) += mtk-dvfsrc-regulator.o
diff --git a/drivers/regulator/mt6373-regulator.c b/drivers/regulator/mt6373-regulator.c
new file mode 100644
index 000000000000..ed2141ca3bac
--- /dev/null
+++ b/drivers/regulator/mt6373-regulator.c
@@ -0,0 +1,762 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2024 MediaTek Inc.
+// Copyright (c) 2025 Collabora Ltd
+//                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/devm-helpers.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/spmi.h>
+
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/mt6373-regulator.h>
+#include <linux/regulator/of_regulator.h>
+
+#define MT6373_REGULATOR_MODE_NORMAL	0
+#define MT6373_REGULATOR_MODE_FCCM	1
+#define MT6373_REGULATOR_MODE_LP	2
+#define MT6373_REGULATOR_MODE_ULP	3
+
+#define EN_SET_OFFSET			0x1
+#define EN_CLR_OFFSET			0x2
+
+#define OC_IRQ_ENABLE_DELAY_MS		10
+
+/* Unlock key for mode setting */
+#define MT6373_BUCK_TOP_UNLOCK_VALUE	0x5543
+
+enum {
+	MT6373_ID_VBUCK0,
+	MT6373_ID_VBUCK1,
+	MT6373_ID_VBUCK2,
+	MT6373_ID_VBUCK3,
+	MT6373_ID_VBUCK4,
+	MT6373_ID_VBUCK5,
+	MT6373_ID_VBUCK6,
+	MT6373_ID_VBUCK7,
+	MT6373_ID_VBUCK8,
+	MT6373_ID_VBUCK9,
+	MT6373_ID_VANT18,
+	MT6373_ID_VAUD18,
+	MT6373_ID_VAUX18,
+	MT6373_ID_VCN18IO,
+	MT6373_ID_VCN33_1,
+	MT6373_ID_VCN33_2,
+	MT6373_ID_VCN33_3,
+	MT6373_ID_VEFUSE,
+	MT6373_ID_VFP,
+	MT6373_ID_VIBR,
+	MT6373_ID_VIO28,
+	MT6373_ID_VMC,
+	MT6373_ID_VMCH,
+	MT6373_ID_VMCH_EINT_HIGH,
+	MT6373_ID_VMCH_EINT_LOW,
+	MT6373_ID_VRF09_AIF,
+	MT6373_ID_VRF12_AIF,
+	MT6373_ID_VRF13_AIF,
+	MT6373_ID_VRF18_AIF,
+	MT6373_ID_VRFIO18_AIF,
+	MT6373_ID_VSRAM_DIGRF_AIF,
+	MT6373_ID_VTP,
+	MT6373_ID_VUSB,
+};
+
+/**
+ * struct mt6373_regulator_info - MT6373 regulators information
+ * @desc: Regulator description structure
+ * @lp_mode_reg: Low Power mode register (normal/idle)
+ * @lp_mode_mask: Low Power mode regulator mask
+ * @modeset_reg: AUTO/PWM mode register
+ * @modeset_mask: AUTO/PWM regulator mask
+ * @oc_work: Delayed work for enabling overcurrent IRQ
+ * @hwirq: PMIC-Internal HW Interrupt for overcurrent event
+ * @virq: Mapped Interrupt for overcurrent event
+ */
+struct mt6373_regulator_info {
+	struct regulator_desc desc;
+	u16 lp_mode_reg;
+	u16 lp_mode_mask;
+	u16 modeset_reg;
+	u16 modeset_mask;
+	struct delayed_work oc_work;
+	u8 hwirq;
+	int virq;
+};
+
+#define MT6373_BUCK(match, vreg, min, max, step, en_reg, lp_reg,	\
+		    mset_reg, ocp_intn)					\
+[MT6373_ID_##vreg] = {							\
+	.desc = {							\
+		.name = match,						\
+		.supply_name = "vsys-"match,				\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6373_vreg_setclr_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6373_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min) / step + 1,			\
+		.min_uV = min,						\
+		.uV_step = step,					\
+		.enable_reg = en_reg,					\
+		.enable_mask = BIT(MT6373_PMIC_RG_BUCK_##vreg##_EN_BIT),\
+		.vsel_reg = MT6373_PMIC_RG_BUCK_##vreg##_VOSEL_ADDR,	\
+		.vsel_mask = MT6373_PMIC_RG_BUCK_VOSEL_MASK,		\
+		.of_map_mode = mt6373_map_mode,				\
+	},								\
+	.lp_mode_reg = lp_reg,						\
+	.lp_mode_mask = BIT(MT6373_PMIC_RG_BUCK_##vreg##_LP_BIT),	\
+	.modeset_reg = mset_reg,					\
+	.modeset_mask = BIT(MT6373_PMIC_RG_##vreg##_FCCM_BIT),		\
+	.hwirq = ocp_intn,						\
+}
+
+
+#define MT6373_LDO_L(match, vreg, in_sup, min, max, step, ocp_intn)	\
+[MT6373_ID_##vreg] = {							\
+	.desc = {							\
+		.name = match,						\
+		.supply_name = in_sup,					\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6373_ldo_linear_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6373_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min) / step + 1,			\
+		.min_uV = min,						\
+		.uV_step = step,					\
+		.enable_reg = MT6373_PMIC_RG_LDO_##vreg##_ADDR,		\
+		.enable_mask = BIT(0),					\
+		.vsel_reg = MT6373_PMIC_RG_##vreg##_VOSEL_ADDR,		\
+		.vsel_mask = MT6373_PMIC_RG_##vreg##_VOSEL_MASK,	\
+		.of_map_mode = mt6373_map_mode,				\
+	},								\
+	.lp_mode_reg = MT6373_PMIC_RG_LDO_##vreg##_ADDR,		\
+	.lp_mode_mask = BIT(1),						\
+	.hwirq = ocp_intn,						\
+}
+
+#define MT6373_LDO_VT_OPS(match, vreg, in_sup, vops, vrnum, ocp_intn)	\
+[MT6373_ID_##vreg] = {							\
+	.desc = {							\
+		.name = match,						\
+		.supply_name = in_sup,					\
+		.of_match = of_match_ptr(match),			\
+		.ops = &vops,						\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6373_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = ARRAY_SIZE(ldo_volt_ranges##vrnum) * 11,	\
+		.linear_ranges = ldo_volt_ranges##vrnum,		\
+		.n_linear_ranges = ARRAY_SIZE(ldo_volt_ranges##vrnum),	\
+		.linear_range_selectors_bitfield = ldos_cal_selectors,	\
+		.enable_reg = MT6373_PMIC_RG_LDO_##vreg##_ADDR,		\
+		.enable_mask = BIT(0),					\
+		.vsel_reg = MT6373_PMIC_RG_##vreg##_VOCAL_ADDR,		\
+		.vsel_mask = MT6373_PMIC_RG_LDO_VT_VOCALSEL_MASK,	\
+		.vsel_range_reg = MT6373_PMIC_RG_##vreg##_VOSEL_ADDR,	\
+		.vsel_range_mask = MT6373_PMIC_RG_LDO_VT_VOCALSEL_MASK,	\
+		.of_map_mode = mt6373_map_mode,				\
+	},								\
+	.lp_mode_reg = MT6373_PMIC_RG_LDO_##vreg##_ADDR,		\
+	.lp_mode_mask = BIT(1),						\
+	.hwirq = ocp_intn,						\
+}
+
+#define MT6373_LDO_VT(match, vreg, inp, vrnum, ocp_intn)		\
+	MT6373_LDO_VT_OPS(match, vreg, inp, mt6373_ldo_vtable_ops,	\
+			  vrnum, ocp_intn)
+
+#define MT6373_LDO_EI(match, vreg, inp, vrnum, ocp_intn)		\
+	MT6373_LDO_VT_OPS(match, vreg, inp, mt6373_vmch_eint_ops,	\
+			  vrnum, ocp_intn)
+
+static const unsigned int ldos_cal_selectors[] = {
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
+};
+
+static const struct linear_range ldo_volt_ranges1[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3400000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3500000, 0, 10, 10000)
+};
+
+static const struct linear_range ldo_volt_ranges2[] = {
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2400000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2500000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2600000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3300000, 0, 10, 10000)
+};
+
+static const struct linear_range ldo_volt_ranges3[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1400000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1600000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2100000, 0, 10, 10000)
+};
+
+static const struct linear_range ldo_volt_ranges4[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2500000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2600000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(2900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3400000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(3500000, 0, 10, 10000)
+};
+
+static const struct linear_range ldo_volt_ranges5[] = {
+	REGULATOR_LINEAR_RANGE(900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0, 10, 10000),
+};
+
+static int mt6373_vreg_enable_setclr(struct regulator_dev *rdev)
+{
+	return regmap_write(rdev->regmap, rdev->desc->enable_reg + EN_SET_OFFSET,
+			    rdev->desc->enable_mask);
+}
+
+static int mt6373_vreg_disable_setclr(struct regulator_dev *rdev)
+{
+	return regmap_write(rdev->regmap, rdev->desc->enable_reg + EN_CLR_OFFSET,
+			    rdev->desc->enable_mask);
+}
+
+static inline unsigned int mt6373_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case MT6373_REGULATOR_MODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	case MT6373_REGULATOR_MODE_FCCM:
+		return REGULATOR_MODE_FAST;
+	case MT6373_REGULATOR_MODE_LP:
+		return REGULATOR_MODE_IDLE;
+	case MT6373_REGULATOR_MODE_ULP:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static int mt6373_vmch_eint_enable(struct regulator_dev *rdev)
+{
+	const struct regulator_desc *rdesc = rdev->desc;
+	unsigned int val;
+	int ret;
+
+	if (rdesc->id == MT6373_ID_VMCH_EINT_HIGH)
+		val = MT6373_PMIC_RG_LDO_VMCH_EINT_POL_BIT;
+	else
+		val = 0;
+
+	ret = regmap_update_bits(rdev->regmap,
+				 MT6373_PMIC_RG_LDO_VMCH_EINT_ADDR,
+				 MT6373_PMIC_RG_LDO_VMCH_EINT_POL_BIT, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(rdev->regmap,
+			      MT6373_PMIC_RG_LDO_VMCH_ADDR,
+			      rdesc->enable_mask);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(rdev->regmap, rdesc->enable_reg, rdesc->enable_mask);
+}
+
+static int mt6373_vmch_eint_disable(struct regulator_dev *rdev)
+{
+	const struct regulator_desc *rdesc = rdev->desc;
+	int ret;
+
+	ret = regmap_clear_bits(rdev->regmap,
+				MT6373_PMIC_RG_LDO_VMCH_ADDR,
+				rdesc->enable_mask);
+	if (ret)
+		return ret;
+
+	/* Wait for VMCH discharging */
+	usleep_range(1500, 1600);
+
+	return regmap_clear_bits(rdev->regmap, rdesc->enable_reg, rdesc->enable_mask);
+}
+
+static unsigned int mt6373_regulator_get_mode(struct regulator_dev *rdev)
+{
+	struct mt6373_regulator_info *info = rdev_get_drvdata(rdev);
+	unsigned int val;
+	int ret;
+
+	if (info->modeset_reg) {
+		ret = regmap_read(rdev->regmap, info->modeset_reg, &val);
+		if (ret) {
+			dev_err(&rdev->dev, "Failed to get mt6373 mode: %d\n", ret);
+			return ret;
+		}
+
+		if (val & info->modeset_mask)
+			return REGULATOR_MODE_FAST;
+	} else {
+		val = 0;
+	};
+
+	ret = regmap_read(rdev->regmap, info->lp_mode_reg, &val);
+	val &= info->lp_mode_mask;
+	if (ret) {
+		dev_err(&rdev->dev, "Failed to get lp mode: %d\n", ret);
+		return ret;
+	}
+
+	if (val)
+		return REGULATOR_MODE_IDLE;
+	else
+		return REGULATOR_MODE_NORMAL;
+}
+
+static int mt6373_buck_unlock(struct regmap *map, bool unlock)
+{
+	u16 buf = unlock ? MT6373_BUCK_TOP_UNLOCK_VALUE : 0;
+
+	return regmap_bulk_write(map, MT6373_BUCK_TOP_KEY_PROT_LO, &buf, sizeof(buf));
+}
+
+static int mt6373_regulator_set_mode(struct regulator_dev *rdev,
+				     unsigned int mode)
+{
+	struct mt6373_regulator_info *info = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev->regmap;
+	int cur_mode, ret;
+
+	if (!info->modeset_reg && mode == REGULATOR_MODE_FAST)
+		return -EOPNOTSUPP;
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		ret = mt6373_buck_unlock(regmap, true);
+		if (ret)
+			break;
+
+		ret = regmap_set_bits(regmap, info->modeset_reg, info->modeset_mask);
+
+		mt6373_buck_unlock(regmap, false);
+		break;
+	case REGULATOR_MODE_NORMAL:
+		cur_mode = mt6373_regulator_get_mode(rdev);
+		if (cur_mode < 0) {
+			ret = cur_mode;
+			break;
+		}
+
+		if (cur_mode == REGULATOR_MODE_FAST) {
+			ret = mt6373_buck_unlock(regmap, true);
+			if (ret)
+				break;
+
+			ret = regmap_clear_bits(regmap, info->modeset_reg, info->modeset_mask);
+
+			mt6373_buck_unlock(regmap, false);
+			break;
+		} else if (cur_mode == REGULATOR_MODE_IDLE) {
+			ret = regmap_clear_bits(regmap, info->lp_mode_reg, info->lp_mode_mask);
+			if (ret == 0)
+				usleep_range(100, 200);
+		} else {
+			ret = 0;
+		}
+		break;
+	case REGULATOR_MODE_IDLE:
+		ret = regmap_set_bits(regmap, info->lp_mode_reg, info->lp_mode_mask);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret) {
+		dev_err(&rdev->dev, "Failed to set mode %u: %d\n", mode, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void mt6373_oc_irq_enable_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct mt6373_regulator_info *info =
+		container_of(dwork, struct mt6373_regulator_info, oc_work);
+
+	enable_irq(info->virq);
+}
+
+static irqreturn_t mt6373_oc_isr(int irq, void *data)
+{
+	struct regulator_dev *rdev = (struct regulator_dev *)data;
+	struct mt6373_regulator_info *info = rdev_get_drvdata(rdev);
+
+	disable_irq_nosync(info->virq);
+
+	if (regulator_is_enabled_regmap(rdev))
+		regulator_notifier_call_chain(rdev, REGULATOR_EVENT_OVER_CURRENT, NULL);
+
+	schedule_delayed_work(&info->oc_work, msecs_to_jiffies(OC_IRQ_ENABLE_DELAY_MS));
+
+	return IRQ_HANDLED;
+}
+
+static int mt6373_set_ocp(struct regulator_dev *rdev, int lim, int severity, bool enable)
+{
+	struct mt6373_regulator_info *info = rdev_get_drvdata(rdev);
+
+	/* MT6373 supports only enabling protection and does not support limits */
+	if (lim || severity != REGULATOR_SEVERITY_PROT || !enable)
+		return -EINVAL;
+
+	/* If there is no OCP interrupt, there's nothing to set */
+	if (info->virq <= 0)
+		return -EINVAL;
+
+	return devm_request_threaded_irq(&rdev->dev, info->virq, NULL,
+					 mt6373_oc_isr, IRQF_ONESHOT,
+					 info->desc.name, rdev);
+}
+
+static const struct regulator_ops mt6373_vreg_setclr_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = mt6373_vreg_enable_setclr,
+	.disable = mt6373_vreg_disable_setclr,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6373_regulator_set_mode,
+	.get_mode = mt6373_regulator_get_mode,
+	.set_over_current_protection = mt6373_set_ocp,
+};
+
+static const struct regulator_ops mt6373_ldo_linear_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6373_regulator_set_mode,
+	.get_mode = mt6373_regulator_get_mode,
+	.set_over_current_protection = mt6373_set_ocp,
+};
+
+static const struct regulator_ops mt6373_ldo_vtable_ops = {
+	.list_voltage = regulator_list_voltage_pickable_linear_range,
+	.map_voltage = regulator_map_voltage_pickable_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_pickable_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6373_regulator_set_mode,
+	.get_mode = mt6373_regulator_get_mode,
+	.set_over_current_protection = mt6373_set_ocp,
+};
+
+static const struct regulator_ops mt6373_vmch_eint_ops = {
+	.list_voltage = regulator_list_voltage_pickable_linear_range,
+	.map_voltage = regulator_map_voltage_pickable_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_pickable_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = mt6373_vmch_eint_enable,
+	.disable = mt6373_vmch_eint_disable,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6373_regulator_set_mode,
+	.get_mode = mt6373_regulator_get_mode,
+	.set_over_current_protection = mt6373_set_ocp,
+};
+
+/* The array is indexed by id(MT6373_ID_XXX) */
+static struct mt6373_regulator_info mt6373_regulators[] = {
+	MT6373_BUCK("vbuck0", VBUCK0, 0, 1193750, 6250, MT6373_PMIC_RG_BUCK0_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK0_LP_ADDR, MT6373_PMIC_RG_BUCK0_FCCM_ADDR, 0),
+	MT6373_BUCK("vbuck1", VBUCK1, 0, 1193750, 6250, MT6373_PMIC_RG_BUCK0_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK0_LP_ADDR, MT6373_PMIC_RG_BUCK0_FCCM_ADDR, 1),
+	MT6373_BUCK("vbuck2", VBUCK2, 0, 1193750, 6250, MT6373_PMIC_RG_BUCK0_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK0_LP_ADDR, MT6373_PMIC_RG_BUCK0_FCCM_ADDR, 2),
+	MT6373_BUCK("vbuck3", VBUCK3, 0, 1193750, 6250, MT6373_PMIC_RG_BUCK0_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK0_LP_ADDR, MT6373_PMIC_RG_BUCK0_FCCM_ADDR, 3),
+	MT6373_BUCK("vbuck4", VBUCK4, 0, 0, 1, MT6373_PMIC_RG_BUCK0_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK0_LP_ADDR, MT6373_PMIC_RG_BUCK0_1_FCCM_ADDR, 4),
+	MT6373_BUCK("vbuck5", VBUCK5, 0, 1193750, 6250, MT6373_PMIC_RG_BUCK0_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK0_LP_ADDR, MT6373_PMIC_RG_BUCK0_1_FCCM_ADDR, 5),
+	MT6373_BUCK("vbuck6", VBUCK6, 0, 1193750, 6250, MT6373_PMIC_RG_BUCK0_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK0_LP_ADDR, MT6373_PMIC_RG_BUCK0_1_FCCM_ADDR, 6),
+	MT6373_BUCK("vbuck7", VBUCK7, 0, 1193750, 6250, MT6373_PMIC_RG_BUCK0_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK0_LP_ADDR, MT6373_PMIC_RG_BUCK0_1_FCCM_ADDR, 7),
+	MT6373_BUCK("vbuck8", VBUCK8, 0, 1193750, 6250, MT6373_PMIC_RG_BUCK1_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK1_LP_ADDR, MT6373_PMIC_RG_BUCK1_FCCM_ADDR, 8),
+	MT6373_BUCK("vbuck9", VBUCK9, 0, 1193750, 6250, MT6373_PMIC_RG_BUCK1_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK1_LP_ADDR, MT6373_PMIC_RG_BUCK1_FCCM_ADDR, 9),
+	MT6373_LDO_VT("vant18", VANT18, "vs1-ldo1", 3, 28),
+	MT6373_LDO_VT("vaud18", VAUD18, "vs1-ldo1", 3, 16),
+	MT6373_LDO_VT("vaux18", VAUX18, "vsys-ldo2", 2, 18),
+	MT6373_LDO_VT("vcn18io", VCN18IO, "vs1-ldo1", 3, 25),
+	MT6373_LDO_VT("vcn33-1", VCN33_1, "vsys-ldo1", 4, 22),
+	MT6373_LDO_VT("vcn33-2", VCN33_2, "vsys-ldo1", 4, 23),
+	MT6373_LDO_VT("vcn33-3", VCN33_3, "vsys-ldo2", 4, 24),
+	MT6373_LDO_VT("vefuse", VEFUSE, "vsys-ldo2", 1, 31),
+	MT6373_LDO_VT("vfp", VFP, "vsys-ldo2", 1, 36),
+	MT6373_LDO_VT("vibr", VIBR, "vsys-ldo2", 1, 34),
+	MT6373_LDO_VT("vio28", VIO28, "vsys-ldo2", 1, 35),
+	MT6373_LDO_VT("vmc", VMC, "vsys-ldo1", 1, 33),
+	MT6373_LDO_VT("vmch", VMCH, "vsys-ldo3", 4, 32),
+	MT6373_LDO_EI("vmch-eint-high", VMCH_EINT_HIGH, "vsys-ldo3", 4, 0),
+	MT6373_LDO_EI("vmch-eint-low", VMCH_EINT_LOW, "vsys-ldo3", 4, 0),
+	MT6373_LDO_VT("vrf09-aif", VRF09_AIF, "vs3-ldo1", 3, 26),
+	MT6373_LDO_VT("vrf12-aif", VRF12_AIF, "vs2-ldo1", 5, 27),
+	MT6373_LDO_VT("vrf13-aif", VRF13_AIF, "vs2-ldo1", 3, 19),
+	MT6373_LDO_VT("vrf18-aif", VRF18_AIF, "vs1-ldo1", 3, 20),
+	MT6373_LDO_VT("vrfio18-aif", VRFIO18_AIF, "vs1-ldo1", 3, 25),
+	MT6373_LDO_L("vsram-digrf-aif", VSRAM_DIGRF_AIF, "vs3-ldo1", 400000, 1193750, 6250, 29),
+	MT6373_LDO_VT("vtp", VTP, "vsys-ldo2", 1, 37),
+	MT6373_LDO_VT("vusb", VUSB, "vsys-ldo2", 1, 17)
+};
+
+static void mt6373_irq_remove(void *data)
+{
+	int *virq = data;
+
+	irq_dispose_mapping(*virq);
+}
+
+static void mt6373_spmi_remove(void *data)
+{
+	struct spmi_device *sdev = data;
+
+	spmi_device_remove(sdev);
+};
+
+static struct regmap *mt6373_spmi_register_regmap(struct device *dev)
+{
+	struct regmap_config mt6373_regmap_config = {
+		.reg_bits = 16,
+		.val_bits = 16,
+		.max_register = 0x1f90,
+		.fast_io = true,
+	};
+	struct spmi_device *sdev, *sparent;
+	u32 base;
+	int ret;
+
+	if (!dev->parent)
+		return ERR_PTR(-ENODEV);
+
+	ret = device_property_read_u32(dev, "reg", &base);
+	if (ret)
+		return ERR_PTR(ret);
+
+	sparent = to_spmi_device(dev->parent);
+	if (!sparent)
+		return ERR_PTR(-ENODEV);
+
+	sdev = spmi_device_alloc(sparent->ctrl);
+	if (!sdev)
+		return ERR_PTR(-ENODEV);
+
+	sdev->usid = sparent->usid;
+	dev_set_name(&sdev->dev, "%d-%02x-regulator", sdev->ctrl->nr, sdev->usid);
+	ret = device_add(&sdev->dev);
+	if (ret) {
+		put_device(&sdev->dev);
+		return ERR_PTR(ret);
+	};
+
+	ret = devm_add_action_or_reset(dev, mt6373_spmi_remove, sdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	mt6373_regmap_config.reg_base = base;
+
+	return devm_regmap_init_spmi_ext(sdev, &mt6373_regmap_config);
+}
+
+static int mt6373_regulator_probe(struct platform_device *pdev)
+{
+	struct irq_fwspec fwspec = {
+		.param_count = 2,
+		.param = { 0, IRQ_TYPE_LEVEL_HIGH },
+	};
+	struct device_node *interrupt_parent;
+	struct regulator_config config = {};
+	struct mt6373_regulator_info *info;
+	struct device *dev = &pdev->dev;
+	struct regulator_dev *rdev;
+	struct irq_domain *domain;
+	bool is_vbuck4_hw_ctrl;
+	bool is_cw_variant;
+	int i, ret;
+	u32 val;
+
+	config.regmap = mt6373_spmi_register_regmap(dev);
+	if (!config.regmap)
+		return dev_err_probe(dev, PTR_ERR(config.regmap),
+				     "Cannot get regmap\n");
+	config.dev = dev;
+
+	interrupt_parent = of_irq_find_parent(dev->of_node);
+	if (!interrupt_parent)
+		return -EINVAL;
+
+	domain = irq_find_host(interrupt_parent);
+	of_node_put(interrupt_parent);
+	fwspec.fwnode = domain->fwnode;
+
+	/* Read PMIC variant information */
+	ret = regmap_read(config.regmap, MT6373_PLG_CFG_ELR1, &val);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot read ID register\n");
+
+	val = FIELD_GET(MT6373_ELR_VARIANT_MASK, val);
+	is_cw_variant = (val == MT6373_ELR_VARIANT_MT6373CW);
+
+	/* Read Reserved-SW information */
+	ret = regmap_read(config.regmap, MT6373_RG_RSV_SWREG_H, &val);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot read RSV_SW register\n");
+
+	is_vbuck4_hw_ctrl = val & MT6373_RG_RSV_SWREG_VBUCK4_HW_CTRL;
+
+	for (i = 0; i < ARRAY_SIZE(mt6373_regulators); i++) {
+		info = &mt6373_regulators[i];
+
+		/* MT6373CW VBUCK4 constraints are different */
+		if (info->desc.id == MT6373_ID_VBUCK4) {
+			unsigned int vbuck4_max_uV;
+
+			/* VBUCK4 vreg software control not allowed in hw_ctrl mode */
+			if (is_vbuck4_hw_ctrl)
+				continue;
+
+			if (is_cw_variant) {
+				info->desc.uV_step = 6250;
+				vbuck4_max_uV = 1193750;
+			} else {
+				info->desc.uV_step = 13875;
+				vbuck4_max_uV = 2650125;
+			}
+			info->desc.n_voltages = vbuck4_max_uV / info->desc.uV_step + 1;
+		}
+
+		fwspec.param[0] = info->hwirq;
+		info->virq = irq_create_fwspec_mapping(&fwspec);
+		if (!info->virq)
+			return dev_err_probe(dev, -EINVAL,
+					     "Failed to map IRQ%d\n", info->hwirq);
+
+		ret = devm_add_action_or_reset(dev, mt6373_irq_remove, &info->virq);
+		if (ret) {
+			irq_dispose_mapping(info->virq);
+			return ret;
+		}
+
+		config.driver_data = info;
+		INIT_DELAYED_WORK(&info->oc_work, mt6373_oc_irq_enable_work);
+
+		rdev = devm_regulator_register(dev, &info->desc, &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(dev, PTR_ERR(rdev),
+					     "failed to register %s\n", info->desc.name);
+	}
+	dev_set_drvdata(dev, config.regmap);
+
+	return 0;
+}
+
+static void mt6373_regulator_shutdown(struct platform_device *pdev)
+{
+	struct regmap *regmap = dev_get_drvdata(&pdev->dev);
+
+	regmap_write(regmap, MT6373_TOP_CFG_ELR5, MT6373_TOP_CFG_ELR5_SHUTDOWN);
+}
+
+static const struct of_device_id mt6373_regulator_match[] = {
+	{ .compatible = "mediatek,mt6373-regulator" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver mt6373_regulator_driver = {
+	.driver = {
+		.name = "mt6373-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = mt6373_regulator_match,
+	},
+	.probe = mt6373_regulator_probe,
+	.shutdown = mt6373_regulator_shutdown
+};
+module_platform_driver(mt6373_regulator_driver);
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_DESCRIPTION("MediaTek MT6373 PMIC Regulator Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/mt6373-regulator.h b/include/linux/regulator/mt6373-regulator.h
new file mode 100644
index 000000000000..0f6a7c4739c2
--- /dev/null
+++ b/include/linux/regulator/mt6373-regulator.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ * Copyright (c) 2025 Collabora Ltd
+ */
+
+#include <linux/bits.h>
+
+#ifndef __LINUX_REGULATOR_MT6373_H
+#define __LINUX_REGULATOR_MT6373_H
+
+/* Register */
+#define MT6373_TOP_CFG_ELR5			0x117
+#define MT6373_TOP_CFG_ELR5_SHUTDOWN		BIT(0)
+
+#define MT6373_PMIC_RG_BUCK0_EN_ADDR		0x210
+#define MT6373_PMIC_RG_BUCK_VBUCK0_EN_BIT	0
+#define MT6373_PMIC_RG_BUCK_VBUCK1_EN_BIT	1
+#define MT6373_PMIC_RG_BUCK_VBUCK2_EN_BIT	2
+#define MT6373_PMIC_RG_BUCK_VBUCK3_EN_BIT	3
+#define MT6373_PMIC_RG_BUCK_VBUCK4_EN_BIT	4
+#define MT6373_PMIC_RG_BUCK_VBUCK5_EN_BIT	5
+#define MT6373_PMIC_RG_BUCK_VBUCK6_EN_BIT	6
+#define MT6373_PMIC_RG_BUCK_VBUCK7_EN_BIT	7
+
+#define MT6373_PMIC_RG_BUCK1_EN_ADDR		0x213
+#define MT6373_PMIC_RG_BUCK_VBUCK8_EN_BIT	0
+#define MT6373_PMIC_RG_BUCK_VBUCK9_EN_BIT	1
+
+#define MT6373_PMIC_RG_BUCK0_LP_ADDR		0x216
+#define MT6373_PMIC_RG_BUCK_VBUCK0_LP_BIT	0
+#define MT6373_PMIC_RG_BUCK_VBUCK1_LP_BIT	1
+#define MT6373_PMIC_RG_BUCK_VBUCK2_LP_BIT	2
+#define MT6373_PMIC_RG_BUCK_VBUCK3_LP_BIT	3
+#define MT6373_PMIC_RG_BUCK_VBUCK4_LP_BIT	4
+#define MT6373_PMIC_RG_BUCK_VBUCK5_LP_BIT	5
+#define MT6373_PMIC_RG_BUCK_VBUCK6_LP_BIT	6
+#define MT6373_PMIC_RG_BUCK_VBUCK7_LP_BIT	7
+
+#define MT6373_PMIC_RG_BUCK1_LP_ADDR		0x219
+#define MT6373_PMIC_RG_BUCK_VBUCK8_LP_BIT	0
+#define MT6373_PMIC_RG_BUCK_VBUCK9_LP_BIT	1
+
+#define MT6373_PMIC_RG_BUCK_VBUCK0_VOSEL_ADDR	0x21c
+#define MT6373_PMIC_RG_BUCK_VBUCK1_VOSEL_ADDR	0x21d
+#define MT6373_PMIC_RG_BUCK_VBUCK2_VOSEL_ADDR	0x21e
+#define MT6373_PMIC_RG_BUCK_VBUCK3_VOSEL_ADDR	0x21f
+#define MT6373_PMIC_RG_BUCK_VBUCK4_VOSEL_ADDR	0x220
+#define MT6373_PMIC_RG_BUCK_VBUCK5_VOSEL_ADDR	0x221
+#define MT6373_PMIC_RG_BUCK_VBUCK6_VOSEL_ADDR	0x222
+#define MT6373_PMIC_RG_BUCK_VBUCK7_VOSEL_ADDR	0x223
+#define MT6373_PMIC_RG_BUCK_VBUCK8_VOSEL_ADDR	0x224
+#define MT6373_PMIC_RG_BUCK_VBUCK9_VOSEL_ADDR	0x225
+#define MT6373_PMIC_RG_BUCK_VOSEL_MASK		GENMASK(8, 0)
+
+#define MT6373_PLG_CFG_ELR1			0x37b
+#define MT6373_ELR_VARIANT_MASK			GENMASK(3, 2)
+#define MT6373_ELR_VARIANT_MT6373CW		1
+#define MT6373_RG_RSV_SWREG_H			0x9d9
+#define MT6373_RG_RSV_SWREG_VBUCK4_HW_CTRL	BIT(0)
+
+#define MT6373_BUCK_TOP_KEY_PROT_LO		0x13fa
+
+#define MT6373_PMIC_RG_BUCK1_FCCM_ADDR		0x196d
+#define MT6373_PMIC_RG_VBUCK8_FCCM_BIT		6
+#define MT6373_PMIC_RG_VBUCK9_FCCM_BIT		7
+
+#define MT6373_PMIC_RG_BUCK0_FCCM_ADDR		0x1a02
+#define MT6373_PMIC_RG_VBUCK0_FCCM_BIT		0
+#define MT6373_PMIC_RG_VBUCK1_FCCM_BIT		1
+#define MT6373_PMIC_RG_VBUCK2_FCCM_BIT		2
+#define MT6373_PMIC_RG_VBUCK3_FCCM_BIT		3
+
+#define MT6373_PMIC_RG_BUCK0_1_FCCM_ADDR	0x1a82
+#define MT6373_PMIC_RG_VBUCK4_FCCM_BIT		0
+#define MT6373_PMIC_RG_VBUCK5_FCCM_BIT		1
+#define MT6373_PMIC_RG_VBUCK6_FCCM_BIT		2
+#define MT6373_PMIC_RG_VBUCK7_FCCM_BIT		3
+
+#define MT6373_PMIC_RG_VSRAM_DIGRF_AIF_VOSEL_ADDR 0x1b09
+#define MT6373_PMIC_RG_VSRAM_DIGRF_AIF_VOSEL_MASK GENMASK(6, 0)
+
+#define MT6373_PMIC_RG_LDO_VAUD18_ADDR		0x1b57
+#define MT6373_PMIC_RG_LDO_VUSB_ADDR		0x1b65
+#define MT6373_PMIC_RG_LDO_VAUX18_ADDR		0x1b73
+#define MT6373_PMIC_RG_LDO_VRF13_AIF_ADDR	0x1b81
+#define MT6373_PMIC_RG_LDO_VRF18_AIF_ADDR	0x1b8f
+#define MT6373_PMIC_RG_LDO_VRFIO18_AIF_ADDR	0x1b9d
+#define MT6373_PMIC_RG_LDO_VCN33_1_ADDR		0x1bd7
+#define MT6373_PMIC_RG_LDO_VCN33_2_ADDR		0x1be5
+#define MT6373_PMIC_RG_LDO_VCN33_3_ADDR		0x1bf3
+#define MT6373_PMIC_RG_LDO_VCN18IO_ADDR		0x1c01
+#define MT6373_PMIC_RG_LDO_VRF09_AIF_ADDR	0x1c0f
+#define MT6373_PMIC_RG_LDO_VRF12_AIF_ADDR	0x1c1d
+#define MT6373_PMIC_RG_LDO_VANT18_ADDR		0x1c57
+#define MT6373_PMIC_RG_LDO_VEFUSE_ADDR		0x1c73
+#define MT6373_PMIC_RG_LDO_VMCH_ADDR		0x1c81
+#define MT6373_PMIC_RG_LDO_VMCH_EINT_ADDR	0x1c8f
+#define MT6373_PMIC_RG_LDO_VMCH_EINT_HIGH_ADDR	MT6373_PMIC_RG_LDO_VMCH_EINT_ADDR
+#define MT6373_PMIC_RG_LDO_VMCH_EINT_LOW_ADDR	MT6373_PMIC_RG_LDO_VMCH_EINT_ADDR
+#define MT6373_PMIC_RG_LDO_VMCH_EINT_POL_BIT	BIT(2)
+#define MT6373_PMIC_RG_LDO_VMC_ADDR		0x1c90
+#define MT6373_PMIC_RG_LDO_VIBR_ADDR		0x1c9e
+#define MT6373_PMIC_RG_LDO_VIO28_ADDR		0x1cd7
+#define MT6373_PMIC_RG_LDO_VFP_ADDR		0x1ce5
+#define MT6373_PMIC_RG_LDO_VTP_ADDR		0x1cf3
+#define MT6373_PMIC_RG_LDO_VSIM1_ADDR		0x1d01
+#define MT6373_PMIC_RG_LDO_VSIM2_ADDR		0x1d10
+#define MT6373_PMIC_RG_LDO_VSIM2_LP_ADDR	0x1d10
+#define MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_ADDR	0x1d57
+#define MT6373_PMIC_RG_VAUX18_VOCAL_ADDR	0x1dd8
+#define MT6373_PMIC_RG_VAUX18_VOSEL_ADDR	0x1dd9
+#define MT6373_PMIC_RG_VUSB_VOCAL_ADDR		0x1ddc
+#define MT6373_PMIC_RG_VUSB_VOSEL_ADDR		0x1ddd
+#define MT6373_PMIC_RG_VCN33_1_VOCAL_ADDR	0x1de0
+#define MT6373_PMIC_RG_VCN33_1_VOSEL_ADDR	0x1de1
+#define MT6373_PMIC_RG_VCN33_2_VOCAL_ADDR	0x1de4
+#define MT6373_PMIC_RG_VCN33_2_VOSEL_ADDR	0x1de5
+#define MT6373_PMIC_RG_VCN33_3_VOCAL_ADDR	0x1de8
+#define MT6373_PMIC_RG_VCN33_3_VOSEL_ADDR	0x1de9
+#define MT6373_PMIC_RG_VMCH_VOCAL_ADDR		0x1dec
+#define MT6373_PMIC_RG_VMCH_VOSEL_ADDR		0x1ded
+#define MT6373_PMIC_RG_VMCH_EINT_HIGH_VOSEL_ADDR MT6373_PMIC_RG_VMCH_VOSEL_ADDR
+#define MT6373_PMIC_RG_VMCH_EINT_LOW_VOSEL_ADDR	MT6373_PMIC_RG_VMCH_VOSEL_ADDR
+#define MT6373_PMIC_RG_VEFUSE_VOCAL_ADDR	0x1df0
+#define MT6373_PMIC_RG_VEFUSE_VOSEL_ADDR	0x1df1
+#define MT6373_PMIC_RG_VMC_VOCAL_ADDR		0x1df4
+#define MT6373_PMIC_RG_VMCH_EINT_HIGH_VOCAL_ADDR MT6373_PMIC_RG_VMC_VOCAL_ADDR
+#define MT6373_PMIC_RG_VMCH_EINT_LOW_VOCAL_ADDR	MT6373_PMIC_RG_VMC_VOCAL_ADDR
+#define MT6373_PMIC_RG_VMC_VOSEL_ADDR		0x1df5
+#define MT6373_PMIC_RG_VIBR_VOCAL_ADDR		0x1df8
+#define MT6373_PMIC_RG_VIBR_VOSEL_ADDR		0x1df9
+#define MT6373_PMIC_RG_VIO28_VOCAL_ADDR		0x1dfc
+#define MT6373_PMIC_RG_VIO28_VOSEL_ADDR		0x1dfd
+#define MT6373_PMIC_RG_VFP_VOCAL_ADDR		0x1e00
+#define MT6373_PMIC_RG_VFP_VOSEL_ADDR		0x1e01
+#define MT6373_PMIC_RG_VTP_VOCAL_ADDR		0x1e04
+#define MT6373_PMIC_RG_VTP_VOSEL_ADDR		0x1e05
+#define MT6373_PMIC_RG_VSIM1_VOCAL_ADDR		0x1e08
+#define MT6373_PMIC_RG_VSIM1_VOSEL_ADDR		0x1e09
+#define MT6373_PMIC_RG_VSIM2_VOCAL_ADDR		0x1e0c
+#define MT6373_PMIC_RG_VSIM2_VOSEL_ADDR		0x1e0d
+#define MT6373_PMIC_RG_VAUD18_VOCAL_ADDR	0x1e58
+#define MT6373_PMIC_RG_VAUD18_VOSEL_ADDR	0x1e59
+#define MT6373_PMIC_RG_VRF18_AIF_VOCAL_ADDR	0x1e5c
+#define MT6373_PMIC_RG_VRF18_AIF_VOSEL_ADDR	0x1e5d
+#define MT6373_PMIC_RG_VCN18IO_VOCAL_ADDR	0x1e60
+#define MT6373_PMIC_RG_VCN18IO_VOSEL_ADDR	0x1e61
+#define MT6373_PMIC_RG_VRFIO18_AIF_VOCAL_ADDR	0x1e64
+#define MT6373_PMIC_RG_VRFIO18_AIF_VOSEL_ADDR	0x1e65
+#define MT6373_PMIC_RG_VANT18_VOCAL_ADDR	0x1e68
+#define MT6373_PMIC_RG_VANT18_VOSEL_ADDR	0x1e69
+#define MT6373_PMIC_RG_VRF13_AIF_VOCAL_ADDR	0x1ed8
+#define MT6373_PMIC_RG_VRF13_AIF_VOSEL_ADDR	0x1ed9
+#define MT6373_PMIC_RG_VRF12_AIF_VOCAL_ADDR	0x1edc
+#define MT6373_PMIC_RG_VRF12_AIF_VOSEL_ADDR	0x1edd
+#define MT6373_PMIC_RG_VRF09_AIF_VOCAL_ADDR	0x1f58
+#define MT6373_PMIC_RG_VRF09_AIF_VOSEL_ADDR	0x1f59
+#define MT6373_PMIC_RG_LDO_VT_VOCALSEL_MASK	GENMASK(7, 0)
+
+#endif /* __LINUX_REGULATOR_MT6363_H */
+
-- 
2.50.1


