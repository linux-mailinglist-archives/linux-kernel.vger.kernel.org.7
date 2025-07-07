Return-Path: <linux-kernel+bounces-719952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F91AFB511
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62699188F891
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1D1A23A4;
	Mon,  7 Jul 2025 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A2kj/J0K"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BB2BD022;
	Mon,  7 Jul 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895911; cv=none; b=TUvYt1xiSs1ldV47B3hu0F2ZUkq6bpbWYTt5GJ1x2uzwr0xEKPjo+qJNCJb3eitgIacxw+pgJ92iUY3z/aR65gaAym9GNQ1Hmeugi5TN0zaBymB8j98ziXe7/dqJLEmwhcObO+S16r5s+RKn0W7vF1EtHjSFEXd9J6eYDEROFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895911; c=relaxed/simple;
	bh=JoP+4Vr16B4fR0DibWYu3/+N4sWJHx31snVXa8jn5Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGyAcsPqviEvAjtWeb1xlIUvMUfPsPGUseSOUAZbrO4shWiAcpCLy+gNhxsKIzDJzK8HLPGtujBwk87mrijxBY0Or8nrA++kBb9RU+xf8tKQ3uyj0t1bX9CU5iJ06LGLfL9ay+5vaGdaOM0GQUTE9AMR9IJFsGsJRZP+yqJW9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A2kj/J0K; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751895904;
	bh=JoP+4Vr16B4fR0DibWYu3/+N4sWJHx31snVXa8jn5Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2kj/J0Kj8xUndYO/sHC3RdJT572PqNYMhr6pwLDRk8MrCYJm+G71yQLyY8TSALyp
	 scq7dv5H/gGJj2D8mrHxieuhJsAWmqg8wOwgMtlpImGQhWS/KHfS4qd08yqW4lExIW
	 Z2tHHGRIPXS9njv3rWL76YWMS1X5VH/YpLWWkb0esdJQNhOYCeDcsY7EP6p9qRhQhm
	 nKulXlO15r/ciLZfpCvaQn9nRZ9pCBGDqL7316/MAKIQr2s6vseTfY5V9l2a91uSpU
	 FXF3cndUqrlzjdWObVMRBno8ISYWHSYrmTsSQzceyOCXsBEDaFRuR1ovDqC1CMyCh7
	 lDGyyTI0RDcFQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F096C17E10D0;
	Mon,  7 Jul 2025 15:45:03 +0200 (CEST)
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
	kernel@collabora.com
Subject: [PATCH v2 4/8] regulator: Add support for MediaTek MT6363 SPMI PMIC Regulators
Date: Mon,  7 Jul 2025 15:44:47 +0200
Message-ID: <20250707134451.154346-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707134451.154346-1-angelogioacchino.delregno@collabora.com>
References: <20250707134451.154346-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the regulators found on the MT6363 PMIC, fully
controlled by SPMI interface.
This PMIC regulates voltage with an input range of 2.6-5.0V, and
features 10 buck converters and 26 LDOs.

Link: https://lore.kernel.org/r/20250624073548.29732-5-angelogioacchino.delregno@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/regulator/Kconfig                  |    9 +
 drivers/regulator/Makefile                 |    1 +
 drivers/regulator/mt6363-regulator.c       | 1076 ++++++++++++++++++++
 include/linux/regulator/mt6363-regulator.h |  326 ++++++
 4 files changed, 1412 insertions(+)
 create mode 100644 drivers/regulator/mt6363-regulator.c
 create mode 100644 include/linux/regulator/mt6363-regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 81f2acd0f960..d770e51f7ad1 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -936,6 +936,15 @@ config REGULATOR_MT6360
 	  2-channel buck with Thermal Shutdown and Overload Protection
 	  6-channel High PSRR and Low Dropout LDO.
 
+config REGULATOR_MT6363
+	tristate "MT6363 SPMI PMIC regulator driver"
+	depends on SPMI || COMPILE_TEST
+	help
+          Say Y here to enable support for regulators found in the MediaTek
+          MT6363 SPMI PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
+
 config REGULATOR_MT6370
 	tristate "MT6370 SubPMIC Regulator"
 	depends on MFD_MT6370
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 46c0e75f6107..41eaeac5547d 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -111,6 +111,7 @@ obj-$(CONFIG_REGULATOR_MT6357)	+= mt6357-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
 obj-$(CONFIG_REGULATOR_MT6359)	+= mt6359-regulator.o
 obj-$(CONFIG_REGULATOR_MT6360) += mt6360-regulator.o
+obj-$(CONFIG_REGULATOR_MT6363) += mt6363-regulator.o
 obj-$(CONFIG_REGULATOR_MT6370) += mt6370-regulator.o
 obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
 obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
diff --git a/drivers/regulator/mt6363-regulator.c b/drivers/regulator/mt6363-regulator.c
new file mode 100644
index 000000000000..ea7d4e4f38cb
--- /dev/null
+++ b/drivers/regulator/mt6363-regulator.c
@@ -0,0 +1,1076 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2024 MediaTek Inc.
+// Copyright (c) 2025 Collabora Ltd
+//                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+#include <linux/delay.h>
+#include <linux/devm-helpers.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/mt6363-regulator.h>
+#include <linux/regulator/of_regulator.h>
+
+#define MT6363_REGULATOR_MODE_NORMAL	0
+#define MT6363_REGULATOR_MODE_FCCM	1
+#define MT6363_REGULATOR_MODE_LP	2
+#define MT6363_REGULATOR_MODE_ULP	3
+
+#define EN_SET_OFFSET	0x1
+#define EN_CLR_OFFSET	0x2
+#define OP_CFG_OFFSET	0x5
+
+#define NORMAL_OP_CFG	0x10
+#define NORMAL_OP_EN	0x800000
+
+#define OC_IRQ_ENABLE_DELAY_MS		10
+
+/* Unlock keys for TMA and BUCK_TOP */
+#define MT6363_TMA_UNLOCK_VALUE		0x9c9c
+#define MT6363_BUCK_TOP_UNLOCK_VALUE	0x5543
+
+#define MT6363_RG_BUCK_EFUSE_RSV1	0x1447
+#define MT6363_RG_BUCK_EFUSE_RSV1_MASK	GENMASK(7, 4)
+
+enum {
+	MT6363_ID_VS2,
+	MT6363_ID_VBUCK1,
+	MT6363_ID_VBUCK2,
+	MT6363_ID_VBUCK3,
+	MT6363_ID_VBUCK4,
+	MT6363_ID_VBUCK5,
+	MT6363_ID_VBUCK6,
+	MT6363_ID_VBUCK7,
+	MT6363_ID_VS1,
+	MT6363_ID_VS3,
+	MT6363_ID_VBUCK1_SSHUB,
+	MT6363_ID_VBUCK2_SSHUB,
+	MT6363_ID_VBUCK4_SSHUB,
+	MT6363_ID_VSRAM_DIGRF,
+	MT6363_ID_VSRAM_MDFE,
+	MT6363_ID_VSRAM_MODEM,
+	MT6363_ID_VSRAM_CPUB,
+	MT6363_ID_VSRAM_CPUM,
+	MT6363_ID_VSRAM_CPUL,
+	MT6363_ID_VSRAM_APU,
+	MT6363_ID_VEMC,
+	MT6363_ID_VCN13,
+	MT6363_ID_VTREF18,
+	MT6363_ID_VAUX18,
+	MT6363_ID_VCN15,
+	MT6363_ID_VUFS18,
+	MT6363_ID_VIO18,
+	MT6363_ID_VM18,
+	MT6363_ID_VA15,
+	MT6363_ID_VRF18,
+	MT6363_ID_VRFIO18,
+	MT6363_ID_VIO075,
+	MT6363_ID_VUFS12,
+	MT6363_ID_VA12_1,
+	MT6363_ID_VA12_2,
+	MT6363_ID_VRF12,
+	MT6363_ID_VRF13,
+	MT6363_ID_VRF09,
+	MT6363_ID_ISINK_LOAD
+};
+
+/**
+ * struct mt6363_regulator_info - MT6363 regulators information
+ * @desc: Regulator description structure
+ * @lp_mode_reg: Low Power mode register (normal/idle)
+ * @lp_mode_mask: Low Power mode regulator mask
+ * @hw_lp_mode_reg: Hardware voted Low Power mode register (normal/idle)
+ * @hw_lp_mode_mask: Hardware voted Low Power mode regulator mask
+ * @modeset_reg: AUTO/PWM mode register
+ * @modeset_mask: AUTO/PWM regulator mask
+ * @vocal_reg: Voltage Output Calibration register
+ * @vocal_mask: Voltage Output Calibration regulator mask
+ * @lp_imax_uA: Maximum load current (microamps), for Low Power mode only
+ * @op_en_reg: Operation mode enablement register
+ * @orig_op_en: Backup of a regulator's operation mode enablement register
+ * @orig_op_cfg: Backup of a regulator's operation mode configuration register
+ * @oc_work: Delayed work for enabling overcurrent IRQ
+ * @irq: Interrupt for overcurrent event
+ */
+struct mt6363_regulator_info {
+	struct regulator_desc desc;
+	u16 lp_mode_reg;
+	u16 lp_mode_mask;
+	u16 hw_lp_mode_reg;
+	u16 hw_lp_mode_mask;
+	u16 modeset_reg;
+	u16 modeset_mask;
+	u16 vocal_reg;
+	u16 vocal_mask;
+	int lp_imax_uA;
+	u16 op_en_reg;
+	u32 orig_op_en;
+	u8 orig_op_cfg;
+	struct delayed_work oc_work;
+	int irq;
+};
+
+#define MT6363_BUCK(match, vreg, min, max, step, en_reg, en_bit, vs_reg,\
+		    vs_mask, lp_reg, lp_bit, mset_reg, mset_bit)\
+[MT6363_ID_##vreg] = {							\
+	.desc = {							\
+		.name = match,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6363_vreg_setclr_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6363_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min) / step + 1,			\
+		.min_uV = min,						\
+		.uV_step = step,					\
+		.enable_reg = en_reg,					\
+		.enable_mask = BIT(en_bit),				\
+		.vsel_reg = vs_reg,					\
+		.vsel_mask = vs_mask,					\
+		.of_map_mode = mt6363_map_mode,				\
+	},								\
+	.lp_mode_reg = lp_reg,						\
+	.lp_mode_mask = BIT(lp_bit),					\
+	.hw_lp_mode_reg = MT6363_BUCK_##vreg##_HW_LP_MODE,		\
+	.hw_lp_mode_mask = 0xc,						\
+	.modeset_reg = mset_reg,					\
+	.modeset_mask = BIT(mset_bit),					\
+	.lp_imax_uA = 100000,						\
+	.op_en_reg = MT6363_BUCK_##vreg##_OP_EN_0,			\
+}
+
+#define MT6363_SSHUB(match, vreg, min, max, step, en_reg,		\
+		     vs_reg, vs_mask)					\
+[MT6363_ID_##vreg] = {							\
+	.desc = {							\
+		.name = match,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6363_sshub_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6363_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min) / step + 1,			\
+		.min_uV = min,						\
+		.uV_step = step,					\
+		.enable_reg = en_reg,					\
+		.enable_mask = BIT(0),					\
+		.vsel_reg = vs_reg,					\
+		.vsel_mask = vs_mask,					\
+		.of_map_mode = mt6363_map_mode,				\
+	},								\
+}
+
+#define MT6363_LDO_LINEAR_OPS(match, vreg, vops, min, max, step,	\
+			      en_reg, en_bit, vs_reg, vs_mask,		\
+			      lp_reg, lp_bit)				\
+[MT6363_ID_##vreg] = {							\
+	.desc = {							\
+		.name = match,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &vops,						\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6363_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min) / step + 1,			\
+		.min_uV = min,						\
+		.uV_step = step,					\
+		.enable_reg = en_reg,					\
+		.enable_mask = BIT(en_bit),				\
+		.vsel_reg = vs_reg,					\
+		.vsel_mask = vs_mask,					\
+		.of_map_mode = mt6363_map_mode,				\
+	},								\
+	.lp_mode_reg = lp_reg,						\
+	.lp_mode_mask = BIT(lp_bit),					\
+	.hw_lp_mode_reg = MT6363_LDO_##vreg##_HW_LP_MODE,		\
+	.hw_lp_mode_mask = 0x4,						\
+}
+
+#define MT6363_LDO_L_SC(match, vreg, min, max, step, en_reg, en_bit,	\
+			vs_reg, vs_mask, lp_reg, lp_bit)		\
+	MT6363_LDO_LINEAR_OPS(match, vreg, mt6363_vreg_setclr_ops,	\
+			      min, max, step, en_reg, en_bit,		\
+			      vs_reg, vs_mask, lp_reg, lp_bit)
+
+#define MT6363_LDO_L(match, vreg, min, max, step, en_reg, en_bit,	\
+		     vs_reg, vs_mask, lp_reg, lp_bit)			\
+	MT6363_LDO_LINEAR_OPS(match, vreg, mt6363_ldo_linear_ops,	\
+			      min, max, step, en_reg, en_bit,		\
+			      vs_reg, vs_mask, lp_reg, lp_bit)
+
+#define MT6363_LDO_VT_OPS(match, vreg, vops, vtable, en_reg, en_bit,	\
+			  vs_reg, vs_mask, cal_reg, cal_mask,		\
+			  lp_reg, lp_bit)				\
+[MT6363_ID_##vreg] = {							\
+	.desc = {							\
+		.name = match,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &vops,						\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6363_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.volt_table = vtable,					\
+		.n_voltages = ARRAY_SIZE(vtable),			\
+		.enable_reg = en_reg,					\
+		.enable_mask = BIT(en_bit),				\
+		.vsel_reg = vs_reg,					\
+		.vsel_mask = vs_mask,					\
+		.of_map_mode = mt6363_map_mode,				\
+	},								\
+	.vocal_reg = cal_reg,						\
+	.vocal_mask = cal_mask,						\
+	.lp_mode_reg = lp_reg,						\
+	.lp_mode_mask = BIT(lp_bit),					\
+	.hw_lp_mode_reg = MT6363_LDO_##vreg##_HW_LP_MODE,		\
+	.hw_lp_mode_mask = 0x4,						\
+	.lp_imax_uA = 10000,						\
+	.op_en_reg = MT6363_LDO_##vreg##_OP_EN0,			\
+}
+
+#define MT6363_LDO_VT(match, vreg, vtable, en_reg, en_bit, vsel_reg,	\
+		      vs_mask, cal_reg, cal_mask, lp_reg, lp_bit)	\
+	MT6363_LDO_VT_OPS(match, vreg, mt6363_ldo_vtable_ops, vtable,	\
+			  en_reg, en_bit, vsel_reg, vs_mask,		\
+			  cal_reg, cal_mask, lp_reg, lp_bit)
+
+static const unsigned int ldo_vemc_volt_table[] = {
+	1200000, 1300000, 1500000, 1700000, 1800000, 2000000, 2500000, 2600000,
+	2700000, 2800000, 2900000, 3000000, 3100000, 3300000, 3400000, 3500000,
+};
+
+static const unsigned int ldo_volt_table1[] = {
+	900000, 1000000, 1100000, 1200000, 1300000, 1700000, 1800000, 1810000,
+};
+
+static const unsigned int ldo_volt_table2[] = {
+	1800000, 1900000, 2000000, 2100000, 2200000, 2300000, 2400000, 2500000,
+	2600000, 2700000, 2800000, 2900000, 3000000, 3100000, 3200000, 3300000,
+};
+
+static const unsigned int ldo_volt_table3[] = {
+	600000, 700000, 800000, 900000, 1000000, 1100000, 1200000, 1300000,
+	1400000, 1500000, 1600000, 1700000, 1800000, 1900000, 2000000, 2100000,
+};
+
+static const unsigned int ldo_volt_table4[] = {
+	550000, 600000, 650000, 700000, 750000, 800000, 900000, 950000,
+	1000000, 1050000, 1100000, 1150000, 1700000, 1750000, 1800000, 1850000,
+};
+
+static const unsigned int ldo_volt_table5[] = {
+	600000, 650000, 700000, 750000, 800000,
+};
+
+static int mt6363_vreg_enable_setclr(struct regulator_dev *rdev)
+{
+	return regmap_write(rdev->regmap, rdev->desc->enable_reg + EN_SET_OFFSET,
+			    rdev->desc->enable_mask);
+}
+
+static int mt6363_vreg_disable_setclr(struct regulator_dev *rdev)
+{
+	return regmap_write(rdev->regmap, rdev->desc->enable_reg + EN_CLR_OFFSET,
+			    rdev->desc->enable_mask);
+}
+
+static inline unsigned int mt6363_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case MT6363_REGULATOR_MODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	case MT6363_REGULATOR_MODE_FCCM:
+		return REGULATOR_MODE_FAST;
+	case MT6363_REGULATOR_MODE_LP:
+		return REGULATOR_MODE_IDLE;
+	case MT6363_REGULATOR_MODE_ULP:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static unsigned int mt6363_regulator_get_mode(struct regulator_dev *rdev)
+{
+	struct mt6363_regulator_info *info = rdev_get_drvdata(rdev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, info->modeset_reg, &val);
+	if (ret) {
+		dev_err(&rdev->dev, "Failed to get mt6363 mode: %d\n", ret);
+		return ret;
+	}
+
+	if (val & info->modeset_mask)
+		return REGULATOR_MODE_FAST;
+
+	if (info->hw_lp_mode_reg) {
+		ret = regmap_read(rdev->regmap, info->hw_lp_mode_reg, &val);
+		val &= info->hw_lp_mode_mask;
+	} else {
+		ret = regmap_read(rdev->regmap, info->lp_mode_reg, &val);
+		val &= info->lp_mode_mask;
+	}
+
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
+static int mt6363_buck_unlock(struct regmap *map, bool unlock)
+{
+	u16 buf = unlock ? MT6363_BUCK_TOP_UNLOCK_VALUE : 0;
+
+	return regmap_bulk_write(map, MT6363_BUCK_TOP_KEY_PROT_LO, &buf, sizeof(buf));
+}
+
+static int mt6363_regulator_set_mode(struct regulator_dev *rdev,
+				     unsigned int mode)
+{
+	struct mt6363_regulator_info *info = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev->regmap;
+	int cur_mode, ret;
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		ret = mt6363_buck_unlock(regmap, true);
+		if (ret)
+			break;
+
+		ret = regmap_set_bits(regmap, info->modeset_reg, info->modeset_mask);
+
+		mt6363_buck_unlock(regmap, false);
+		break;
+	case REGULATOR_MODE_NORMAL:
+		cur_mode = mt6363_regulator_get_mode(rdev);
+		if (cur_mode < 0) {
+			ret = cur_mode;
+			break;
+		}
+
+		if (cur_mode == REGULATOR_MODE_FAST) {
+			ret = mt6363_buck_unlock(regmap, true);
+			if (ret)
+				break;
+
+			ret = regmap_clear_bits(regmap, info->modeset_reg, info->modeset_mask);
+
+			mt6363_buck_unlock(regmap, false);
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
+static int mt6363_regulator_set_load(struct regulator_dev *rdev, int load_uA)
+{
+	struct mt6363_regulator_info *info = rdev_get_drvdata(rdev);
+	unsigned int opmode_cfg, opmode_en;
+	int i, ret;
+
+	if (!info->lp_imax_uA)
+		return -EINVAL;
+
+	if (load_uA >= info->lp_imax_uA) {
+		ret = mt6363_regulator_set_mode(rdev, REGULATOR_MODE_NORMAL);
+		if (ret)
+			return ret;
+
+		opmode_cfg = NORMAL_OP_CFG;
+		opmode_en = NORMAL_OP_EN;
+	} else {
+		opmode_cfg = info->orig_op_cfg;
+		opmode_en = info->orig_op_en;
+	}
+
+	ret = regmap_write(rdev->regmap, info->op_en_reg + OP_CFG_OFFSET, opmode_cfg);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < 3; i++) {
+		ret = regmap_write(rdev->regmap, info->op_en_reg + i,
+				   (opmode_en >> (i * 8)) & GENMASK(7, 0));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int mt6363_vemc_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
+{
+	const u16 tma_unlock_key = MT6363_TMA_UNLOCK_VALUE;
+	struct regmap *regmap = rdev->regmap;
+	unsigned int val;
+	u16 mask;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, MT6363_TOP_TRAP, &val);
+	if (ret)
+		return ret;
+
+	if (val > 1)
+		return -EINVAL;
+
+	/* Unlock TMA for writing */
+	ret = regmap_bulk_write(rdev->regmap, MT6363_TOP_TMA_KEY_L,
+				&tma_unlock_key, sizeof(tma_unlock_key));
+	if (ret)
+		return ret;
+
+	/* If HW trapping value is 1, use VEMC_VOSEL_1 instead of VEMC_VOSEL_0 */
+	if (val == 1) {
+		mask = MT6363_RG_VEMC_VOSEL_1_MASK;
+		sel = FIELD_PREP(MT6363_RG_VEMC_VOSEL_1_MASK, sel);
+	} else {
+		mask = rdev->desc->vsel_mask;
+	}
+
+	/* Function must return the result of this write operation */
+	ret = regmap_update_bits(regmap, rdev->desc->vsel_reg, mask, sel);
+
+	/* Unconditionally re-lock TMA */
+	val = 0;
+	regmap_bulk_write(rdev->regmap, MT6363_TOP_TMA_KEY_L, &val, 2);
+
+	return ret;
+}
+
+static int mt6363_vemc_get_voltage_sel(struct regulator_dev *rdev)
+{
+	unsigned int sel, trap;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, rdev->desc->vsel_reg, &sel);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(rdev->regmap, MT6363_TOP_TRAP, &trap);
+	if (ret)
+		return ret;
+
+	/* If HW trapping value is 1, use VEMC_VOSEL_1 instead of VEMC_VOSEL_0 */
+	if (trap > 1)
+		return -EINVAL;
+	else if (trap == 1)
+		ret = FIELD_GET(MT6363_RG_VEMC_VOSEL_1_MASK, sel);
+	else
+		ret = sel & rdev->desc->vsel_mask;
+
+	return ret;
+}
+
+static int mt6363_va15_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
+{
+	struct regmap *regmap = rdev->regmap;
+	int ret;
+
+	ret = mt6363_buck_unlock(regmap, true);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(regmap, rdev->desc->vsel_reg, rdev->desc->vsel_mask, sel);
+	if (ret)
+		goto va15_unlock;
+
+	ret = regmap_update_bits(regmap, MT6363_RG_BUCK_EFUSE_RSV1,
+				 MT6363_RG_BUCK_EFUSE_RSV1_MASK, sel);
+	if (ret)
+		goto va15_unlock;
+
+va15_unlock:
+	mt6363_buck_unlock(rdev->regmap, false);
+	return ret;
+}
+
+static void mt6363_oc_irq_enable_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct mt6363_regulator_info *info =
+		container_of(dwork, struct mt6363_regulator_info, oc_work);
+
+	enable_irq(info->irq);
+}
+
+static irqreturn_t mt6363_oc_isr(int irq, void *data)
+{
+	struct regulator_dev *rdev = (struct regulator_dev *)data;
+	struct mt6363_regulator_info *info = rdev_get_drvdata(rdev);
+
+	disable_irq_nosync(info->irq);
+
+	if (regulator_is_enabled_regmap(rdev))
+		regulator_notifier_call_chain(rdev, REGULATOR_EVENT_OVER_CURRENT, NULL);
+
+	schedule_delayed_work(&info->oc_work, msecs_to_jiffies(OC_IRQ_ENABLE_DELAY_MS));
+
+	return IRQ_HANDLED;
+}
+
+static int mt6363_set_ocp(struct regulator_dev *rdev, int lim, int severity, bool enable)
+{
+	struct mt6363_regulator_info *info = rdev_get_drvdata(rdev);
+
+	/* MT6363 supports only enabling protection and does not support limits */
+	if (lim || severity != REGULATOR_SEVERITY_PROT || !enable)
+		return -EINVAL;
+
+	/* If there is no OCP interrupt, there's nothing to set */
+	if (info->irq <= 0)
+		return -EINVAL;
+
+	return devm_request_threaded_irq(&rdev->dev, info->irq, NULL,
+					 mt6363_oc_isr, IRQF_ONESHOT,
+					 info->desc.name, rdev);
+}
+
+static const struct regulator_ops mt6363_vreg_setclr_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = mt6363_vreg_enable_setclr,
+	.disable = mt6363_vreg_disable_setclr,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6363_regulator_set_mode,
+	.get_mode = mt6363_regulator_get_mode,
+	.set_load = mt6363_regulator_set_load,
+	.set_over_current_protection = mt6363_set_ocp,
+};
+
+/* SSHUB LDO doesn't support mode and load settings */
+static const struct regulator_ops mt6363_sshub_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_over_current_protection = mt6363_set_ocp,
+};
+
+static const struct regulator_ops mt6363_ldo_linear_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6363_regulator_set_mode,
+	.get_mode = mt6363_regulator_get_mode,
+	.set_over_current_protection = mt6363_set_ocp,
+};
+
+static const struct regulator_ops mt6363_ldo_vtable_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6363_regulator_set_mode,
+	.get_mode = mt6363_regulator_get_mode,
+	.set_load = mt6363_regulator_set_load,
+	.set_over_current_protection = mt6363_set_ocp,
+};
+
+static const struct regulator_ops mt6363_ldo_vemc_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = mt6363_vemc_set_voltage_sel,
+	.get_voltage_sel = mt6363_vemc_get_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6363_regulator_set_mode,
+	.get_mode = mt6363_regulator_get_mode,
+	.set_load = mt6363_regulator_set_load,
+	.set_over_current_protection = mt6363_set_ocp,
+};
+
+static const struct regulator_ops mt6363_ldo_va15_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = mt6363_va15_set_voltage_sel,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6363_regulator_set_mode,
+	.get_mode = mt6363_regulator_get_mode,
+	.set_load = mt6363_regulator_set_load,
+	.set_over_current_protection = mt6363_set_ocp,
+};
+
+static int mt6363_isink_load_enable(struct regulator_dev *rdev)
+{
+	int ret;
+
+	ret = regmap_set_bits(rdev->regmap, MT6363_ISINK_EN_CTRL0,
+			      MT6363_ISINK_CTRL0_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(rdev->regmap, MT6363_ISINK_EN_CTRL1,
+			       MT6363_ISINK_CTRL1_MASK);
+}
+
+static int mt6363_isink_load_disable(struct regulator_dev *rdev)
+{
+	int ret;
+
+	ret = regmap_clear_bits(rdev->regmap, MT6363_ISINK_EN_CTRL1, MT6363_ISINK_CTRL1_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_clear_bits(rdev->regmap, MT6363_ISINK_EN_CTRL0, MT6363_ISINK_CTRL0_MASK);
+}
+
+static int mt6363_isink_load_is_enabled(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, MT6363_ISINK_EN_CTRL1, &val);
+	if (ret)
+		return ret;
+
+	return (val & MT6363_ISINK_CTRL1_MASK) == MT6363_ISINK_CTRL1_MASK;
+}
+
+static const struct regulator_ops mt6363_isink_load_ops = {
+	.enable = mt6363_isink_load_enable,
+	.disable = mt6363_isink_load_disable,
+	.is_enabled = mt6363_isink_load_is_enabled,
+};
+
+/* The array is indexed by id(MT6363_ID_XXX) */
+static struct mt6363_regulator_info mt6363_regulators[] = {
+	MT6363_BUCK("buck-vs2", VS2, 0, 1600000, 12500,
+		    MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK_VS2_EN_BIT,
+		    MT6363_RG_BUCK_VS2_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VS2_VOSEL_MASK,
+		    MT6363_RG_BUCK0_LP_ADDR,
+		    MT6363_RG_BUCK_VS2_LP_BIT,
+		    MT6363_RG_BUCK0_FCCM_ADDR,
+		    MT6363_RG_VS2_FCCM_BIT),
+	MT6363_BUCK("buck-vb1", VBUCK1, 0, 1193750, 6250,
+		    MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK_VBUCK1_EN_BIT,
+		    MT6363_RG_BUCK_VBUCK1_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VBUCK1_VOSEL_MASK,
+		    MT6363_RG_BUCK0_LP_ADDR,
+		    MT6363_RG_BUCK_VBUCK1_LP_BIT,
+		    MT6363_RG_BUCK0_FCCM_ADDR,
+		    MT6363_RG_VBUCK1_FCCM_BIT),
+	MT6363_BUCK("buck-vb2", VBUCK2, 0, 1193750, 6250,
+		    MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK_VBUCK2_EN_BIT,
+		    MT6363_RG_BUCK_VBUCK2_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VBUCK2_VOSEL_MASK,
+		    MT6363_RG_BUCK0_LP_ADDR,
+		    MT6363_RG_BUCK_VBUCK2_LP_BIT,
+		    MT6363_RG_BUCK0_FCCM_ADDR,
+		    MT6363_RG_VBUCK2_FCCM_BIT),
+	MT6363_BUCK("buck-vb3", VBUCK3, 0, 1193750, 6250,
+		    MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK_VBUCK3_EN_BIT,
+		    MT6363_RG_BUCK_VBUCK3_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VBUCK3_VOSEL_MASK,
+		    MT6363_RG_BUCK0_LP_ADDR,
+		    MT6363_RG_BUCK_VBUCK3_LP_BIT,
+		    MT6363_RG_BUCK0_FCCM_ADDR,
+		    MT6363_RG_VBUCK3_FCCM_BIT),
+	MT6363_BUCK("buck-vb4", VBUCK4, 0, 1193750, 6250,
+		    MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK_VBUCK4_EN_BIT,
+		    MT6363_RG_BUCK_VBUCK4_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VBUCK4_VOSEL_MASK,
+		    MT6363_RG_BUCK0_LP_ADDR,
+		    MT6363_RG_BUCK_VBUCK4_LP_BIT,
+		    MT6363_RG_BUCK0_1_FCCM_ADDR,
+		    MT6363_RG_VBUCK4_FCCM_BIT),
+	MT6363_BUCK("buck-vb5", VBUCK5, 0, 1193750, 6250,
+		    MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK_VBUCK5_EN_BIT,
+		    MT6363_RG_BUCK_VBUCK5_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VBUCK5_VOSEL_MASK,
+		    MT6363_RG_BUCK0_LP_ADDR,
+		    MT6363_RG_BUCK_VBUCK5_LP_BIT,
+		    MT6363_RG_BUCK0_1_FCCM_ADDR,
+		    MT6363_RG_VBUCK5_FCCM_BIT),
+	MT6363_BUCK("buck-vb6", VBUCK6, 0, 1193750, 6250,
+		    MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK_VBUCK6_EN_BIT,
+		    MT6363_RG_BUCK_VBUCK6_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VBUCK6_VOSEL_MASK,
+		    MT6363_RG_BUCK0_LP_ADDR,
+		    MT6363_RG_BUCK_VBUCK6_LP_BIT,
+		    MT6363_RG_BUCK0_1_FCCM_ADDR,
+		    MT6363_RG_VBUCK6_FCCM_BIT),
+	MT6363_BUCK("buck-vb7", VBUCK7, 0, 1193750, 6250,
+		    MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK_VBUCK7_EN_BIT,
+		    MT6363_RG_BUCK_VBUCK7_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VBUCK7_VOSEL_MASK,
+		    MT6363_RG_BUCK0_LP_ADDR,
+		    MT6363_RG_BUCK_VBUCK7_LP_BIT,
+		    MT6363_RG_BUCK0_1_FCCM_ADDR,
+		    MT6363_RG_VBUCK7_FCCM_BIT),
+	MT6363_BUCK("buck-vs1", VS1, 0, 2200000, 12500,
+		    MT6363_RG_BUCK1_EN_ADDR,
+		    MT6363_RG_BUCK_VS1_EN_BIT,
+		    MT6363_RG_BUCK_VS1_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VS1_VOSEL_MASK,
+		    MT6363_RG_BUCK1_LP_ADDR,
+		    MT6363_RG_BUCK_VS1_LP_BIT,
+		    MT6363_RG_VS1_FCCM_ADDR,
+		    MT6363_RG_VS1_FCCM_BIT),
+	MT6363_BUCK("buck-vs3", VS3, 0, 1193750, 6250,
+		    MT6363_RG_BUCK1_EN_ADDR,
+		    MT6363_RG_BUCK_VS3_EN_BIT,
+		    MT6363_RG_BUCK_VS3_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VS3_VOSEL_MASK,
+		    MT6363_RG_BUCK1_LP_ADDR,
+		    MT6363_RG_BUCK_VS3_LP_BIT,
+		    MT6363_RG_VS3_FCCM_ADDR,
+		    MT6363_RG_VS3_FCCM_BIT),
+	MT6363_SSHUB("buck-sshub1", VBUCK1_SSHUB, 0, 1193750, 6250,
+		     MT6363_RG_BUCK_VBUCK1_SSHUB_EN_ADDR,
+		     MT6363_RG_BUCK_VBUCK1_SSHUB_VOSEL_ADDR,
+		     MT6363_RG_BUCK_VBUCK1_SSHUB_VOSEL_MASK),
+	MT6363_SSHUB("buck-sshub2", VBUCK2_SSHUB, 0, 1193750, 6250,
+		     MT6363_RG_BUCK_VBUCK2_SSHUB_EN_ADDR,
+		     MT6363_RG_BUCK_VBUCK2_SSHUB_VOSEL_ADDR,
+		     MT6363_RG_BUCK_VBUCK2_SSHUB_VOSEL_MASK),
+	MT6363_SSHUB("buck-sshub4", VBUCK4_SSHUB, 0, 1193750, 6250,
+		     MT6363_RG_BUCK_VBUCK4_SSHUB_EN_ADDR,
+		     MT6363_RG_BUCK_VBUCK4_SSHUB_VOSEL_ADDR,
+		     MT6363_RG_BUCK_VBUCK4_SSHUB_VOSEL_MASK),
+	MT6363_LDO_L_SC("ldo-vsram-digrf", VSRAM_DIGRF, 400000, 1193750, 6250,
+			MT6363_RG_BUCK1_EN_ADDR,
+			MT6363_RG_LDO_VSRAM_DIGRF_EN_BIT,
+			MT6363_RG_LDO_VSRAM_DIGRF_VOSEL_ADDR,
+			MT6363_RG_LDO_VSRAM_DIGRF_VOSEL_MASK,
+			MT6363_RG_BUCK1_LP_ADDR,
+			MT6363_RG_LDO_VSRAM_DIGRF_LP_BIT),
+	MT6363_LDO_L_SC("ldo-vsram-mdfe", VSRAM_MDFE, 400000, 1193750, 6250,
+			MT6363_RG_BUCK1_EN_ADDR,
+			MT6363_RG_LDO_VSRAM_MDFE_EN_BIT,
+			MT6363_RG_LDO_VSRAM_MDFE_VOSEL_ADDR,
+			MT6363_RG_LDO_VSRAM_MDFE_VOSEL_MASK,
+			MT6363_RG_BUCK1_LP_ADDR,
+			MT6363_RG_LDO_VSRAM_MDFE_LP_BIT),
+	MT6363_LDO_L_SC("ldo-vsram-modem", VSRAM_MODEM, 400000, 1193750, 6250,
+			MT6363_RG_BUCK1_EN_ADDR,
+			MT6363_RG_LDO_VSRAM_MODEM_EN_BIT,
+			MT6363_RG_LDO_VSRAM_MODEM_VOSEL_ADDR,
+			MT6363_RG_LDO_VSRAM_MODEM_VOSEL_MASK,
+			MT6363_RG_BUCK1_LP_ADDR,
+			MT6363_RG_LDO_VSRAM_MODEM_LP_BIT),
+	MT6363_LDO_L("ldo-vsram-cpub", VSRAM_CPUB, 400000, 1193750, 6250,
+		     MT6363_RG_LDO_VSRAM_CPUB_ADDR,
+		     MT6363_RG_LDO_VSRAM_CPUB_EN_BIT,
+		     MT6363_RG_LDO_VSRAM_CPUB_VOSEL_ADDR,
+		     MT6363_RG_LDO_VSRAM_CPUB_VOSEL_MASK,
+		     MT6363_RG_LDO_VSRAM_CPUB_ADDR,
+		     MT6363_RG_LDO_VSRAM_CPUB_LP_BIT),
+	MT6363_LDO_L("ldo-vsram-cpum", VSRAM_CPUM, 400000, 1193750, 6250,
+		     MT6363_RG_LDO_VSRAM_CPUM_ADDR,
+		     MT6363_RG_LDO_VSRAM_CPUM_EN_BIT,
+		     MT6363_RG_LDO_VSRAM_CPUM_VOSEL_ADDR,
+		     MT6363_RG_LDO_VSRAM_CPUM_VOSEL_MASK,
+		     MT6363_RG_LDO_VSRAM_CPUM_ADDR,
+		     MT6363_RG_LDO_VSRAM_CPUM_LP_BIT),
+	MT6363_LDO_L("ldo-vsram-cpul", VSRAM_CPUL, 400000, 1193750, 6250,
+		     MT6363_RG_LDO_VSRAM_CPUL_ADDR,
+		     MT6363_RG_LDO_VSRAM_CPUL_EN_BIT,
+		     MT6363_RG_LDO_VSRAM_CPUL_VOSEL_ADDR,
+		     MT6363_RG_LDO_VSRAM_CPUL_VOSEL_MASK,
+		     MT6363_RG_LDO_VSRAM_CPUL_ADDR,
+		     MT6363_RG_LDO_VSRAM_CPUL_LP_BIT),
+	MT6363_LDO_L("ldo-vsram-apu", VSRAM_APU, 400000, 1193750, 6250,
+		     MT6363_RG_LDO_VSRAM_APU_ADDR,
+		     MT6363_RG_LDO_VSRAM_APU_EN_BIT,
+		     MT6363_RG_LDO_VSRAM_APU_VOSEL_ADDR,
+		     MT6363_RG_LDO_VSRAM_APU_VOSEL_MASK,
+		     MT6363_RG_LDO_VSRAM_APU_ADDR,
+		     MT6363_RG_LDO_VSRAM_APU_LP_BIT),
+	MT6363_LDO_VT_OPS("ldo-vemc", VEMC, mt6363_ldo_vemc_ops, ldo_vemc_volt_table,
+			  MT6363_RG_LDO_VEMC_ADDR, MT6363_RG_LDO_VEMC_EN_BIT,
+			  MT6363_RG_VEMC_VOSEL_0_ADDR,
+			  MT6363_RG_VEMC_VOSEL_0_MASK,
+			  MT6363_RG_VEMC_VOCAL_0_ADDR,
+			  MT6363_RG_VEMC_VOCAL_0_MASK,
+			  MT6363_RG_LDO_VEMC_ADDR,
+			  MT6363_RG_LDO_VEMC_LP_BIT),
+	MT6363_LDO_VT("ldo-vcn13", VCN13, ldo_volt_table1,
+		      MT6363_RG_LDO_VCN13_ADDR, MT6363_RG_LDO_VCN13_EN_BIT,
+		      MT6363_RG_VCN13_VOSEL_ADDR,
+		      MT6363_RG_VCN13_VOSEL_MASK,
+		      MT6363_RG_VCN13_VOCAL_ADDR,
+		      MT6363_RG_VCN13_VOCAL_MASK,
+		      MT6363_RG_LDO_VCN13_ADDR,
+		      MT6363_RG_LDO_VCN13_LP_BIT),
+	MT6363_LDO_VT("ldo-vtref18", VTREF18, ldo_volt_table2,
+		      MT6363_RG_LDO_VTREF18_ADDR, MT6363_RG_LDO_VTREF18_EN_BIT,
+		      MT6363_RG_VTREF18_VOSEL_ADDR,
+		      MT6363_RG_VTREF18_VOSEL_MASK,
+		      MT6363_RG_VTREF18_VOCAL_ADDR,
+		      MT6363_RG_VTREF18_VOCAL_MASK,
+		      MT6363_RG_LDO_VTREF18_ADDR,
+		      MT6363_RG_LDO_VTREF18_LP_BIT),
+	MT6363_LDO_VT("ldo-vaux18", VAUX18, ldo_volt_table2,
+		      MT6363_RG_LDO_VAUX18_ADDR, MT6363_RG_LDO_VAUX18_EN_BIT,
+		      MT6363_RG_VAUX18_VOSEL_ADDR,
+		      MT6363_RG_VAUX18_VOSEL_MASK,
+		      MT6363_RG_VAUX18_VOCAL_ADDR,
+		      MT6363_RG_VAUX18_VOCAL_MASK,
+		      MT6363_RG_LDO_VAUX18_ADDR,
+		      MT6363_RG_LDO_VAUX18_LP_BIT),
+	MT6363_LDO_VT("ldo-vcn15", VCN15, ldo_volt_table3,
+		      MT6363_RG_LDO_VCN15_ADDR, MT6363_RG_LDO_VCN15_EN_BIT,
+		      MT6363_RG_VCN15_VOSEL_ADDR,
+		      MT6363_RG_VCN15_VOSEL_MASK,
+		      MT6363_RG_VCN15_VOCAL_ADDR,
+		      MT6363_RG_VCN15_VOCAL_MASK,
+		      MT6363_RG_LDO_VCN15_ADDR,
+		      MT6363_RG_LDO_VCN15_LP_BIT),
+	MT6363_LDO_VT("ldo-vufs18", VUFS18, ldo_volt_table3,
+		      MT6363_RG_LDO_VUFS18_ADDR, MT6363_RG_LDO_VUFS18_EN_BIT,
+		      MT6363_RG_VUFS18_VOSEL_ADDR,
+		      MT6363_RG_VUFS18_VOSEL_MASK,
+		      MT6363_RG_VUFS18_VOCAL_ADDR,
+		      MT6363_RG_VUFS18_VOCAL_MASK,
+		      MT6363_RG_LDO_VUFS18_ADDR,
+		      MT6363_RG_LDO_VUFS18_LP_BIT),
+	MT6363_LDO_VT("ldo-vio18", VIO18, ldo_volt_table3,
+		      MT6363_RG_LDO_VIO18_ADDR, MT6363_RG_LDO_VIO18_EN_BIT,
+		      MT6363_RG_VIO18_VOSEL_ADDR,
+		      MT6363_RG_VIO18_VOSEL_MASK,
+		      MT6363_RG_VIO18_VOCAL_ADDR,
+		      MT6363_RG_VIO18_VOCAL_MASK,
+		      MT6363_RG_LDO_VIO18_ADDR,
+		      MT6363_RG_LDO_VIO18_LP_BIT),
+	MT6363_LDO_VT("ldo-vm18", VM18, ldo_volt_table4,
+		      MT6363_RG_LDO_VM18_ADDR, MT6363_RG_LDO_VM18_EN_BIT,
+		      MT6363_RG_VM18_VOSEL_ADDR,
+		      MT6363_RG_VM18_VOSEL_MASK,
+		      MT6363_RG_VM18_VOCAL_ADDR,
+		      MT6363_RG_VM18_VOCAL_MASK,
+		      MT6363_RG_LDO_VM18_ADDR,
+		      MT6363_RG_LDO_VM18_LP_BIT),
+	MT6363_LDO_VT_OPS("ldo-va15", VA15, mt6363_ldo_va15_ops, ldo_volt_table3,
+			  MT6363_RG_LDO_VA15_ADDR, MT6363_RG_LDO_VA15_EN_BIT,
+			  MT6363_RG_VA15_VOSEL_ADDR,
+			  MT6363_RG_VA15_VOSEL_MASK,
+			  MT6363_RG_VA15_VOCAL_ADDR,
+			  MT6363_RG_VA15_VOCAL_MASK,
+			  MT6363_RG_LDO_VA15_ADDR,
+			  MT6363_RG_LDO_VA15_LP_BIT),
+	MT6363_LDO_VT("ldo-vrf18", VRF18, ldo_volt_table3,
+		      MT6363_RG_LDO_VRF18_ADDR, MT6363_RG_LDO_VRF18_EN_BIT,
+		      MT6363_RG_VRF18_VOSEL_ADDR,
+		      MT6363_RG_VRF18_VOSEL_MASK,
+		      MT6363_RG_VRF18_VOCAL_ADDR,
+		      MT6363_RG_VRF18_VOCAL_MASK,
+		      MT6363_RG_LDO_VRF18_ADDR,
+		      MT6363_RG_LDO_VRF18_LP_BIT),
+	MT6363_LDO_VT("ldo-vrf-io18", VRFIO18, ldo_volt_table3,
+		      MT6363_RG_LDO_VRFIO18_ADDR, MT6363_RG_LDO_VRFIO18_EN_BIT,
+		      MT6363_RG_VRFIO18_VOSEL_ADDR,
+		      MT6363_RG_VRFIO18_VOSEL_MASK,
+		      MT6363_RG_VRFIO18_VOCAL_ADDR,
+		      MT6363_RG_VRFIO18_VOCAL_MASK,
+		      MT6363_RG_LDO_VRFIO18_ADDR,
+		      MT6363_RG_LDO_VRFIO18_LP_BIT),
+	MT6363_LDO_VT("ldo-vio0p75", VIO075, ldo_volt_table5,
+		      MT6363_RG_LDO_VIO075_ADDR, MT6363_RG_LDO_VIO075_EN_BIT,
+		      MT6363_RG_VIO075_VOCFG_ADDR,
+		      MT6363_RG_VIO075_VOSEL_MASK,
+		      MT6363_RG_VIO075_VOCFG_ADDR,
+		      MT6363_RG_VIO075_VOCAL_MASK,
+		      MT6363_RG_LDO_VIO075_ADDR,
+		      MT6363_RG_LDO_VIO075_LP_BIT),
+	MT6363_LDO_VT("ldo-vufs12", VUFS12, ldo_volt_table4,
+		      MT6363_RG_LDO_VUFS12_ADDR, MT6363_RG_LDO_VUFS12_EN_BIT,
+		      MT6363_RG_VUFS12_VOSEL_ADDR,
+		      MT6363_RG_VUFS12_VOSEL_MASK,
+		      MT6363_RG_VUFS12_VOCAL_ADDR,
+		      MT6363_RG_VUFS12_VOCAL_MASK,
+		      MT6363_RG_LDO_VUFS12_ADDR,
+		      MT6363_RG_LDO_VUFS12_LP_BIT),
+	MT6363_LDO_VT("ldo-va12-1", VA12_1, ldo_volt_table3,
+		      MT6363_RG_LDO_VA12_1_ADDR, MT6363_RG_LDO_VA12_1_EN_BIT,
+		      MT6363_RG_VA12_1_VOSEL_ADDR,
+		      MT6363_RG_VA12_1_VOSEL_MASK,
+		      MT6363_RG_VA12_1_VOCAL_ADDR,
+		      MT6363_RG_VA12_1_VOCAL_MASK,
+		      MT6363_RG_LDO_VA12_1_ADDR,
+		      MT6363_RG_LDO_VA12_1_LP_BIT),
+	MT6363_LDO_VT("ldo-va12-2", VA12_2, ldo_volt_table3,
+		      MT6363_RG_LDO_VA12_2_ADDR, MT6363_RG_LDO_VA12_2_EN_BIT,
+		      MT6363_RG_VA12_2_VOSEL_ADDR,
+		      MT6363_RG_VA12_2_VOSEL_MASK,
+		      MT6363_RG_VA12_2_VOCAL_ADDR,
+		      MT6363_RG_VA12_2_VOCAL_MASK,
+		      MT6363_RG_LDO_VA12_2_ADDR,
+		      MT6363_RG_LDO_VA12_2_LP_BIT),
+	MT6363_LDO_VT("ldo-vrf12", VRF12, ldo_volt_table3,
+		      MT6363_RG_LDO_VRF12_ADDR, MT6363_RG_LDO_VRF12_EN_BIT,
+		      MT6363_RG_VRF12_VOSEL_ADDR,
+		      MT6363_RG_VRF12_VOSEL_MASK,
+		      MT6363_RG_VRF12_VOCAL_ADDR,
+		      MT6363_RG_VRF12_VOCAL_MASK,
+		      MT6363_RG_LDO_VRF12_ADDR,
+		      MT6363_RG_LDO_VRF12_LP_BIT),
+	MT6363_LDO_VT("ldo-vrf13", VRF13, ldo_volt_table1,
+		      MT6363_RG_LDO_VRF13_ADDR, MT6363_RG_LDO_VRF13_EN_BIT,
+		      MT6363_RG_VRF13_VOSEL_ADDR,
+		      MT6363_RG_VRF13_VOSEL_MASK,
+		      MT6363_RG_VRF13_VOCAL_ADDR,
+		      MT6363_RG_VRF13_VOCAL_MASK,
+		      MT6363_RG_LDO_VRF13_ADDR,
+		      MT6363_RG_LDO_VRF13_LP_BIT),
+	MT6363_LDO_VT("ldo-vrf0p9", VRF09, ldo_volt_table1,
+		      MT6363_RG_LDO_VRF09_ADDR, MT6363_RG_LDO_VRF09_EN_BIT,
+		      MT6363_RG_VRF09_VOSEL_ADDR,
+		      MT6363_RG_VRF09_VOSEL_MASK,
+		      MT6363_RG_VRF09_VOCAL_ADDR,
+		      MT6363_RG_VRF09_VOCAL_MASK,
+		      MT6363_RG_LDO_VRF09_ADDR,
+		      MT6363_RG_LDO_VRF09_LP_BIT),
+	[MT6363_ID_ISINK_LOAD] = {
+		.desc = {
+			.name = "ISINK_LOAD",
+			.of_match = of_match_ptr("isink-load"),
+			.id = MT6363_ID_ISINK_LOAD,
+			.type = REGULATOR_CURRENT,
+			.ops = &mt6363_isink_load_ops,
+			.owner = THIS_MODULE,
+		},
+	}
+};
+
+static int mt6363_backup_op_setting(struct regmap *map, struct mt6363_regulator_info *info)
+{
+	unsigned int i, val;
+	int ret;
+
+	ret = regmap_read(map, info->op_en_reg + OP_CFG_OFFSET, &val);
+	if (ret)
+		return ret;
+
+	info->orig_op_cfg = val;
+
+	for (i = 0; i < 3; i++) {
+		ret = regmap_read(map, info->op_en_reg + i, &val);
+		if (ret)
+			return ret;
+
+		info->orig_op_en |= val << (i * 8);
+	}
+
+	return 0;
+}
+
+static int mt6363_regulator_probe(struct platform_device *pdev)
+{
+	struct regulator_config config = {};
+	struct mt6363_regulator_info *info;
+	struct regulator_dev *rdev;
+	int i, ret;
+
+	config.regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!config.regmap)
+		return dev_err_probe(&pdev->dev, -ENODEV, "Cannot get regmap\n");
+
+	config.dev = &pdev->dev;
+
+	for (i = 0; i < ARRAY_SIZE(mt6363_regulators); i++) {
+		info = &mt6363_regulators[i];
+		info->irq = platform_get_irq_byname_optional(pdev, info->desc.name);
+
+		config.driver_data = info;
+		rdev = devm_regulator_register(&pdev->dev, &info->desc, &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
+					     "failed to register %s\n", info->desc.name);
+
+		if (info->lp_imax_uA) {
+			ret = mt6363_backup_op_setting(config.regmap, info);
+			if (ret) {
+				dev_warn(&pdev->dev, "failed to backup op_setting for %s\n",
+					 info->desc.name);
+				info->lp_imax_uA = 0;
+			}
+		}
+
+		if (info->irq > 0)
+			INIT_DELAYED_WORK(&info->oc_work, mt6363_oc_irq_enable_work);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id mt6363_regulator_match[] = {
+	{ .compatible = "mediatek,mt6363-regulator" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver mt6363_regulator_driver = {
+	.driver = {
+		.name = "mt6363-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = mt6363_regulator_match,
+	},
+	.probe = mt6363_regulator_probe,
+};
+module_platform_driver(mt6363_regulator_driver);
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6363 PMIC");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/mt6363-regulator.h b/include/linux/regulator/mt6363-regulator.h
new file mode 100644
index 000000000000..e2580bcd4d73
--- /dev/null
+++ b/include/linux/regulator/mt6363-regulator.h
@@ -0,0 +1,326 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ * Copyright (c) 2025 Collabora Ltd
+ */
+
+#include <linux/bits.h>
+
+#ifndef __LINUX_REGULATOR_MT6363_H
+#define __LINUX_REGULATOR_MT6363_H
+
+/* Register */
+#define MT6363_TOP_TRAP				0x36
+#define MT6363_TOP_TMA_KEY_L			0x39e
+#define MT6363_RG_BUCK0_EN_ADDR			0x240
+#define MT6363_RG_BUCK_VS2_EN_BIT		0
+#define MT6363_RG_BUCK_VBUCK1_EN_BIT		1
+#define MT6363_RG_BUCK_VBUCK2_EN_BIT		2
+#define MT6363_RG_BUCK_VBUCK3_EN_BIT		3
+#define MT6363_RG_BUCK_VBUCK4_EN_BIT		4
+#define MT6363_RG_BUCK_VBUCK5_EN_BIT		5
+#define MT6363_RG_BUCK_VBUCK6_EN_BIT		6
+#define MT6363_RG_BUCK_VBUCK7_EN_BIT		7
+#define MT6363_RG_BUCK1_EN_ADDR			0x243
+#define MT6363_RG_BUCK_VS1_EN_BIT		0
+#define MT6363_RG_BUCK_VS3_EN_BIT		1
+#define MT6363_RG_LDO_VSRAM_DIGRF_EN_BIT	4
+#define MT6363_RG_LDO_VSRAM_MDFE_EN_BIT		5
+#define MT6363_RG_LDO_VSRAM_MODEM_EN_BIT	6
+#define MT6363_RG_BUCK0_LP_ADDR			0x246
+#define MT6363_RG_BUCK_VS2_LP_BIT		0
+#define MT6363_RG_BUCK_VBUCK1_LP_BIT		1
+#define MT6363_RG_BUCK_VBUCK2_LP_BIT		2
+#define MT6363_RG_BUCK_VBUCK3_LP_BIT		3
+#define MT6363_RG_BUCK_VBUCK4_LP_BIT		4
+#define MT6363_RG_BUCK_VBUCK5_LP_BIT		5
+#define MT6363_RG_BUCK_VBUCK6_LP_BIT		6
+#define MT6363_RG_BUCK_VBUCK7_LP_BIT		7
+#define MT6363_RG_BUCK1_LP_ADDR			0x249
+#define MT6363_RG_BUCK_VS1_LP_BIT		0
+#define MT6363_RG_BUCK_VS3_LP_BIT		1
+#define MT6363_RG_LDO_VSRAM_DIGRF_LP_BIT	4
+#define MT6363_RG_LDO_VSRAM_MDFE_LP_BIT		5
+#define MT6363_RG_LDO_VSRAM_MODEM_LP_BIT	6
+#define MT6363_RG_BUCK_VS2_VOSEL_ADDR		0x24c
+#define MT6363_RG_BUCK_VS2_VOSEL_MASK		GENMASK(7, 0)
+#define MT6363_RG_BUCK_VBUCK1_VOSEL_ADDR	0x24d
+#define MT6363_RG_BUCK_VBUCK1_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_RG_BUCK_VBUCK2_VOSEL_ADDR	0x24e
+#define MT6363_RG_BUCK_VBUCK2_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_RG_BUCK_VBUCK3_VOSEL_ADDR	0x24f
+#define MT6363_RG_BUCK_VBUCK3_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_RG_BUCK_VBUCK4_VOSEL_ADDR	0x250
+#define MT6363_RG_BUCK_VBUCK4_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_RG_BUCK_VBUCK5_VOSEL_ADDR	0x251
+#define MT6363_RG_BUCK_VBUCK5_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_RG_BUCK_VBUCK6_VOSEL_ADDR	0x252
+#define MT6363_RG_BUCK_VBUCK6_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_RG_BUCK_VBUCK7_VOSEL_ADDR	0x253
+#define MT6363_RG_BUCK_VBUCK7_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_RG_BUCK_VS1_VOSEL_ADDR		0x254
+#define MT6363_RG_BUCK_VS1_VOSEL_MASK		GENMASK(7, 0)
+#define MT6363_RG_BUCK_VS3_VOSEL_ADDR		0x255
+#define MT6363_RG_BUCK_VS3_VOSEL_MASK		GENMASK(7, 0)
+#define MT6363_RG_LDO_VSRAM_DIGRF_VOSEL_ADDR	0x258
+#define MT6363_RG_LDO_VSRAM_DIGRF_VOSEL_MASK	GENMASK(6, 0)
+#define MT6363_RG_LDO_VSRAM_MDFE_VOSEL_ADDR	0x259
+#define MT6363_RG_LDO_VSRAM_MDFE_VOSEL_MASK	GENMASK(6, 0)
+#define MT6363_RG_LDO_VSRAM_MODEM_VOSEL_ADDR	0x25a
+#define MT6363_RG_LDO_VSRAM_MODEM_VOSEL_MASK	GENMASK(6, 0)
+#define MT6363_BUCK_TOP_KEY_PROT_LO		0x142a
+#define MT6363_BUCK_VS2_WDTDBG_VOSEL_ADDR	0x142c
+#define MT6363_BUCK_VBUCK1_WDTDBG_VOSEL_ADDR	0x142d
+#define MT6363_BUCK_VBUCK2_WDTDBG_VOSEL_ADDR	0x142e
+#define MT6363_BUCK_VBUCK3_WDTDBG_VOSEL_ADDR	0x142f
+#define MT6363_BUCK_VBUCK4_WDTDBG_VOSEL_ADDR	0x1430
+#define MT6363_BUCK_VBUCK5_WDTDBG_VOSEL_ADDR	0x1431
+#define MT6363_BUCK_VBUCK6_WDTDBG_VOSEL_ADDR	0x1432
+#define MT6363_BUCK_VBUCK7_WDTDBG_VOSEL_ADDR	0x1433
+#define MT6363_BUCK_VS1_WDTDBG_VOSEL_ADDR	0x1434
+#define MT6363_BUCK_VS3_WDTDBG_VOSEL_ADDR	0x1435
+#define MT6363_BUCK_VS2_OP_EN_0			0x148d
+#define MT6363_BUCK_VS2_HW_LP_MODE		0x1498
+#define MT6363_BUCK_VBUCK1_OP_EN_0		0x150d
+#define MT6363_BUCK_VBUCK1_HW_LP_MODE		0x1518
+#define MT6363_RG_BUCK_VBUCK1_SSHUB_EN_ADDR	0x151a
+#define MT6363_RG_BUCK_VBUCK1_SSHUB_VOSEL_ADDR	0x151b
+#define MT6363_RG_BUCK_VBUCK1_SSHUB_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_BUCK_VBUCK2_OP_EN_0		0x158d
+#define MT6363_BUCK_VBUCK2_HW_LP_MODE		0x1598
+#define MT6363_RG_BUCK_VBUCK2_SSHUB_EN_ADDR	0x159a
+#define MT6363_RG_BUCK_VBUCK2_SSHUB_VOSEL_ADDR	0x159b
+#define MT6363_RG_BUCK_VBUCK2_SSHUB_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_BUCK_VBUCK3_OP_EN_0		0x160d
+#define MT6363_BUCK_VBUCK3_HW_LP_MODE		0x1618
+#define MT6363_BUCK_VBUCK4_OP_EN_0		0x168d
+#define MT6363_BUCK_VBUCK4_HW_LP_MODE		0x1698
+#define MT6363_RG_BUCK_VBUCK4_SSHUB_EN_ADDR	0x169a
+#define MT6363_RG_BUCK_VBUCK4_SSHUB_VOSEL_ADDR	0x169b
+#define MT6363_RG_BUCK_VBUCK4_SSHUB_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_BUCK_VBUCK5_OP_EN_0		0x170d
+#define MT6363_BUCK_VBUCK5_HW_LP_MODE		0x1718
+#define MT6363_BUCK_VBUCK6_OP_EN_0		0x178d
+#define MT6363_BUCK_VBUCK6_HW_LP_MODE		0x1798
+#define MT6363_BUCK_VBUCK7_OP_EN_0		0x180d
+#define MT6363_BUCK_VBUCK7_HW_LP_MODE		0x1818
+#define MT6363_BUCK_VS1_OP_EN_0			0x188d
+#define MT6363_BUCK_VS1_HW_LP_MODE		0x1898
+#define MT6363_BUCK_VS3_OP_EN_0			0x190d
+#define MT6363_BUCK_VS3_HW_LP_MODE		0x1918
+#define MT6363_RG_VS1_FCCM_ADDR			0x1994
+#define MT6363_RG_VS1_FCCM_BIT			0
+#define MT6363_RG_VS3_FCCM_ADDR			0x19a3
+#define MT6363_RG_VS3_FCCM_BIT			0
+#define MT6363_RG_BUCK0_FCCM_ADDR		0x1a32
+#define MT6363_RG_VBUCK1_FCCM_BIT		0
+#define MT6363_RG_VBUCK2_FCCM_BIT		1
+#define MT6363_RG_VBUCK3_FCCM_BIT		2
+#define MT6363_RG_VS2_FCCM_BIT			3
+#define MT6363_RG_BUCK0_1_FCCM_ADDR		0x1ab2
+#define MT6363_RG_VBUCK4_FCCM_BIT		0
+#define MT6363_RG_VBUCK5_FCCM_BIT		1
+#define MT6363_RG_VBUCK6_FCCM_BIT		2
+#define MT6363_RG_VBUCK7_FCCM_BIT		3
+#define MT6363_RG_VCN13_VOSEL_ADDR		0x1b3f
+#define MT6363_RG_VCN13_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VEMC_VOSEL_0_ADDR		0x1b40
+#define MT6363_RG_VEMC_VOSEL_0_MASK		GENMASK(3, 0)
+#define MT6363_RG_VEMC_VOSEL_1_MASK		GENMASK(7, 4)
+#define MT6363_RG_LDO_VSRAM_CPUB_VOSEL_ADDR	0x1b44
+#define MT6363_RG_LDO_VSRAM_CPUB_VOSEL_MASK	GENMASK(6, 0)
+#define MT6363_RG_LDO_VSRAM_CPUM_VOSEL_ADDR	0x1b45
+#define MT6363_RG_LDO_VSRAM_CPUM_VOSEL_MASK	GENMASK(6, 0)
+#define MT6363_RG_LDO_VSRAM_CPUL_VOSEL_ADDR	0x1b46
+#define MT6363_RG_LDO_VSRAM_CPUL_VOSEL_MASK	GENMASK(6, 0)
+#define MT6363_RG_LDO_VSRAM_APU_VOSEL_ADDR	0x1b47
+#define MT6363_RG_LDO_VSRAM_APU_VOSEL_MASK	GENMASK(6, 0)
+#define MT6363_RG_VEMC_VOCAL_0_ADDR		0x1b4b
+#define MT6363_RG_VEMC_VOCAL_0_MASK		GENMASK(3, 0)
+#define MT6363_RG_LDO_VCN15_ADDR		0x1b87
+#define MT6363_RG_LDO_VCN15_EN_BIT		0
+#define MT6363_RG_LDO_VCN15_LP_BIT		1
+#define MT6363_LDO_VCN15_HW_LP_MODE		0x1b8b
+#define MT6363_LDO_VCN15_OP_EN0			0x1b8c
+#define MT6363_RG_LDO_VRF09_ADDR		0x1b95
+#define MT6363_RG_LDO_VRF09_EN_BIT		0
+#define MT6363_RG_LDO_VRF09_LP_BIT		1
+#define MT6363_LDO_VRF09_HW_LP_MODE		0x1b99
+#define MT6363_LDO_VRF09_OP_EN0			0x1b9a
+#define MT6363_RG_LDO_VRF12_ADDR		0x1ba3
+#define MT6363_RG_LDO_VRF12_EN_BIT		0
+#define MT6363_RG_LDO_VRF12_LP_BIT		1
+#define MT6363_LDO_VRF12_HW_LP_MODE		0x1ba7
+#define MT6363_LDO_VRF12_OP_EN0			0x1ba8
+#define MT6363_RG_LDO_VRF13_ADDR		0x1bb1
+#define MT6363_RG_LDO_VRF13_EN_BIT		0
+#define MT6363_RG_LDO_VRF13_LP_BIT		1
+#define MT6363_LDO_VRF13_HW_LP_MODE		0x1bb5
+#define MT6363_LDO_VRF13_OP_EN0			0x1bb6
+#define MT6363_RG_LDO_VRF18_ADDR		0x1bbf
+#define MT6363_RG_LDO_VRF18_EN_BIT		0
+#define MT6363_RG_LDO_VRF18_LP_BIT		1
+#define MT6363_LDO_VRF18_HW_LP_MODE		0x1bc3
+#define MT6363_LDO_VRF18_OP_EN0			0x1bc4
+#define MT6363_RG_LDO_VRFIO18_ADDR		0x1bcd
+#define MT6363_RG_LDO_VRFIO18_EN_BIT		0
+#define MT6363_RG_LDO_VRFIO18_LP_BIT		1
+#define MT6363_LDO_VRFIO18_HW_LP_MODE		0x1bd1
+#define MT6363_LDO_VRFIO18_OP_EN0		0x1bd2
+#define MT6363_RG_LDO_VTREF18_ADDR		0x1c07
+#define MT6363_RG_LDO_VTREF18_EN_BIT		0
+#define MT6363_RG_LDO_VTREF18_LP_BIT		1
+#define MT6363_LDO_VTREF18_HW_LP_MODE		0x1c0b
+#define MT6363_LDO_VTREF18_OP_EN0		0x1c0c
+#define MT6363_RG_LDO_VAUX18_ADDR		0x1c15
+#define MT6363_RG_LDO_VAUX18_EN_BIT		0
+#define MT6363_RG_LDO_VAUX18_LP_BIT		1
+#define MT6363_LDO_VAUX18_HW_LP_MODE		0x1c19
+#define MT6363_LDO_VAUX18_OP_EN0		0x1c1a
+#define MT6363_RG_LDO_VEMC_ADDR			0x1c23
+#define MT6363_RG_LDO_VEMC_EN_BIT		0
+#define MT6363_RG_LDO_VEMC_LP_BIT		1
+#define MT6363_LDO_VEMC_HW_LP_MODE		0x1c27
+#define MT6363_LDO_VEMC_OP_EN0			0x1c28
+#define MT6363_RG_LDO_VUFS12_ADDR		0x1c31
+#define MT6363_RG_LDO_VUFS12_EN_BIT		0
+#define MT6363_RG_LDO_VUFS12_LP_BIT		1
+#define MT6363_LDO_VUFS12_HW_LP_MODE		0x1c35
+#define MT6363_LDO_VUFS12_OP_EN0		0x1c36
+#define MT6363_RG_LDO_VUFS18_ADDR		0x1c3f
+#define MT6363_RG_LDO_VUFS18_EN_BIT		0
+#define MT6363_RG_LDO_VUFS18_LP_BIT		1
+#define MT6363_LDO_VUFS18_HW_LP_MODE		0x1c43
+#define MT6363_LDO_VUFS18_OP_EN0		0x1c44
+#define MT6363_RG_LDO_VIO18_ADDR		0x1c4d
+#define MT6363_RG_LDO_VIO18_EN_BIT		0
+#define MT6363_RG_LDO_VIO18_LP_BIT		1
+#define MT6363_LDO_VIO18_HW_LP_MODE		0x1c51
+#define MT6363_LDO_VIO18_OP_EN0			0x1c52
+#define MT6363_RG_LDO_VIO075_ADDR		0x1c87
+#define MT6363_RG_LDO_VIO075_EN_BIT		0
+#define MT6363_RG_LDO_VIO075_LP_BIT		1
+#define MT6363_LDO_VIO075_HW_LP_MODE		0x1c8b
+#define MT6363_LDO_VIO075_OP_EN0		0x1c8c
+#define MT6363_RG_LDO_VA12_1_ADDR		0x1c95
+#define MT6363_RG_LDO_VA12_1_EN_BIT		0
+#define MT6363_RG_LDO_VA12_1_LP_BIT		1
+#define MT6363_LDO_VA12_1_HW_LP_MODE		0x1c99
+#define MT6363_LDO_VA12_1_OP_EN0		0x1c9a
+#define MT6363_RG_LDO_VA12_2_ADDR		0x1ca3
+#define MT6363_RG_LDO_VA12_2_EN_BIT		0
+#define MT6363_RG_LDO_VA12_2_LP_BIT		1
+#define MT6363_LDO_VA12_2_HW_LP_MODE		0x1ca7
+#define MT6363_LDO_VA12_2_OP_EN0		0x1ca8
+#define MT6363_RG_LDO_VA15_ADDR			0x1cb1
+#define MT6363_RG_LDO_VA15_EN_BIT		0
+#define MT6363_RG_LDO_VA15_LP_BIT		1
+#define MT6363_LDO_VA15_HW_LP_MODE		0x1cb5
+#define MT6363_LDO_VA15_OP_EN0			0x1cb6
+#define MT6363_RG_LDO_VM18_ADDR			0x1cbf
+#define MT6363_RG_LDO_VM18_EN_BIT		0
+#define MT6363_RG_LDO_VM18_LP_BIT		1
+#define MT6363_LDO_VM18_HW_LP_MODE		0x1cc3
+#define MT6363_LDO_VM18_OP_EN0			0x1cc4
+#define MT6363_RG_LDO_VCN13_ADDR		0x1d07
+#define MT6363_RG_LDO_VCN13_EN_BIT		0
+#define MT6363_RG_LDO_VCN13_LP_BIT		1
+#define MT6363_LDO_VCN13_HW_LP_MODE		0x1d0b
+#define MT6363_LDO_VCN13_OP_EN0			0x1d14
+#define MT6363_LDO_VSRAM_DIGRF_HW_LP_MODE	0x1d21
+#define MT6363_LDO_VSRAM_DIGRF_OP_EN0		0x1d2a
+#define MT6363_LDO_VSRAM_MDFE_HW_LP_MODE	0x1d8b
+#define MT6363_LDO_VSRAM_MDFE_OP_EN0		0x1d94
+#define MT6363_LDO_VSRAM_MODEM_HW_LP_MODE	0x1da6
+#define MT6363_LDO_VSRAM_MODEM_OP_EN0		0x1daf
+#define MT6363_RG_LDO_VSRAM_CPUB_ADDR		0x1e07
+#define MT6363_RG_LDO_VSRAM_CPUB_EN_BIT		0
+#define MT6363_RG_LDO_VSRAM_CPUB_LP_BIT		1
+#define MT6363_LDO_VSRAM_CPUB_HW_LP_MODE	0x1e0b
+#define MT6363_LDO_VSRAM_CPUB_OP_EN0		0x1e14
+#define MT6363_RG_LDO_VSRAM_CPUM_ADDR		0x1e1d
+#define MT6363_RG_LDO_VSRAM_CPUM_EN_BIT		0
+#define MT6363_RG_LDO_VSRAM_CPUM_LP_BIT		1
+#define MT6363_LDO_VSRAM_CPUM_HW_LP_MODE	0x1e21
+#define MT6363_LDO_VSRAM_CPUM_OP_EN0		0x1e2a
+#define MT6363_RG_LDO_VSRAM_CPUL_ADDR		0x1e87
+#define MT6363_RG_LDO_VSRAM_CPUL_EN_BIT		0
+#define MT6363_RG_LDO_VSRAM_CPUL_LP_BIT		1
+#define MT6363_LDO_VSRAM_CPUL_HW_LP_MODE	0x1e8b
+#define MT6363_LDO_VSRAM_CPUL_OP_EN0		0x1e94
+#define MT6363_RG_LDO_VSRAM_APU_ADDR		0x1e9d
+#define MT6363_RG_LDO_VSRAM_APU_EN_BIT		0
+#define MT6363_RG_LDO_VSRAM_APU_LP_BIT		1
+#define MT6363_LDO_VSRAM_APU_HW_LP_MODE		0x1ea1
+#define MT6363_LDO_VSRAM_APU_OP_EN0		0x1eaa
+#define MT6363_RG_VTREF18_VOCAL_ADDR		0x1f08
+#define MT6363_RG_VTREF18_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VTREF18_VOSEL_ADDR		0x1f09
+#define MT6363_RG_VTREF18_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VAUX18_VOCAL_ADDR		0x1f0c
+#define MT6363_RG_VAUX18_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VAUX18_VOSEL_ADDR		0x1f0d
+#define MT6363_RG_VAUX18_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VCN15_VOCAL_ADDR		0x1f13
+#define MT6363_RG_VCN15_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VCN15_VOSEL_ADDR		0x1f14
+#define MT6363_RG_VCN15_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VUFS18_VOCAL_ADDR		0x1f17
+#define MT6363_RG_VUFS18_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VUFS18_VOSEL_ADDR		0x1f18
+#define MT6363_RG_VUFS18_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VIO18_VOCAL_ADDR		0x1f1b
+#define MT6363_RG_VIO18_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VIO18_VOSEL_ADDR		0x1f1c
+#define MT6363_RG_VIO18_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VM18_VOCAL_ADDR		0x1f1f
+#define MT6363_RG_VM18_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VM18_VOSEL_ADDR		0x1f20
+#define MT6363_RG_VM18_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VA15_VOCAL_ADDR		0x1f23
+#define MT6363_RG_VA15_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VA15_VOSEL_ADDR		0x1f24
+#define MT6363_RG_VA15_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF18_VOCAL_ADDR		0x1f27
+#define MT6363_RG_VRF18_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF18_VOSEL_ADDR		0x1f28
+#define MT6363_RG_VRF18_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRFIO18_VOCAL_ADDR		0x1f2b
+#define MT6363_RG_VRFIO18_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRFIO18_VOSEL_ADDR		0x1f2c
+#define MT6363_RG_VRFIO18_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VIO075_VOCFG_ADDR		0x1f31
+#define MT6363_RG_VIO075_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VIO075_VOSEL_MASK		GENMASK(6, 4)
+#define MT6363_RG_VCN13_VOCAL_ADDR		0x1f88
+#define MT6363_RG_VCN13_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VUFS12_VOCAL_ADDR		0x1f91
+#define MT6363_RG_VUFS12_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VUFS12_VOSEL_ADDR		0x1f92
+#define MT6363_RG_VUFS12_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VA12_1_VOCAL_ADDR		0x1f95
+#define MT6363_RG_VA12_1_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VA12_1_VOSEL_ADDR		0x1f96
+#define MT6363_RG_VA12_1_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VA12_2_VOCAL_ADDR		0x1f99
+#define MT6363_RG_VA12_2_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VA12_2_VOSEL_ADDR		0x1f9a
+#define MT6363_RG_VA12_2_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF12_VOCAL_ADDR		0x1f9d
+#define MT6363_RG_VRF12_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF12_VOSEL_ADDR		0x1f9e
+#define MT6363_RG_VRF12_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF13_VOCAL_ADDR		0x1fa1
+#define MT6363_RG_VRF13_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF13_VOSEL_ADDR		0x1fa2
+#define MT6363_RG_VRF13_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF09_VOCAL_ADDR		0x1fa8
+#define MT6363_RG_VRF09_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF09_VOSEL_ADDR		0x1fa9
+#define MT6363_RG_VRF09_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_ISINK_EN_CTRL0			0x220b
+#define MT6363_ISINK_CTRL0_MASK			GENMASK(7, 0)
+#define MT6363_ISINK_EN_CTRL1			0x220c
+#define MT6363_ISINK_CTRL1_MASK			GENMASK(7, 4)
+
+#endif /* __LINUX_REGULATOR_MT6363_H */
-- 
2.49.0


