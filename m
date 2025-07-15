Return-Path: <linux-kernel+bounces-732000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D36B060CA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB35A504796
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D36274FE7;
	Tue, 15 Jul 2025 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c4jpfeg3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AA1231845;
	Tue, 15 Jul 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588206; cv=none; b=qn+dPiQgUhZ3UbjEYo9Z6uDpbTb1IiM5dywBWXsI+jRyUmM7uwU9RuOCy/mUn1Xst101Aq665JMm22+Q50ihBmBFGFqG1C6rJFFEn83AZVFKcFHVSocOxgHwJhfGncn4u+rQGepYmP41mxVN1gWIhIEqt7rWTBLogUv6FbXiHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588206; c=relaxed/simple;
	bh=B7hc6U0QixeObmU8eJxwtnTAkS1IESKLiTJ+eSNdG3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOn4bCWuUTu+pxxS/D9W8d5yXZVcY8oVFuazUgtvGkPxbFFC2bxJQYTQKwwGU1JtWRu+qqKGnQPY909NYH0HLpih6LpnvtfSG2bEc+4DZP+OjVk9uN4LtG/o4oEV4ahugvxg1oCHYf7Fh9RTEzIWUmq1IOitsafKLPEa2Rlz/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c4jpfeg3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752588200;
	bh=B7hc6U0QixeObmU8eJxwtnTAkS1IESKLiTJ+eSNdG3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4jpfeg3ACYXo+fEtmZ81X0ARdRI05mat2ngkGuUqsgT2RWRhZsgKccuUR0I0WZZ7
	 WzJoA6B+5lrsUTLwhmrAqVIffoXAppdB8HnIk+NHz6UFBqZD9MKKff2Ga/m2/GF4ZU
	 R2wCb3y2jfJ8A1rBCvf1A0hZVA3Ey4TLZrS0ccvSiULLakqAQF4+5KWtUaOl5hga9p
	 iZIfSw8+UATKZPD4UPnMpubE6/Xp9Ybwds2gg4KPUSWYncZ56vNyNdsPOT02piiKEI
	 osMexM9/XdaEd7RIOb/2MjIisy9Qd7gYQop6Jl6l9lLTxVz7o1bsn0Q2rmQqjfXBpP
	 uzocRJjUTitMg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2785117E1301;
	Tue, 15 Jul 2025 16:03:20 +0200 (CEST)
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
Subject: [PATCH v5 4/8] regulator: Add support for MediaTek MT6363 SPMI PMIC Regulators
Date: Tue, 15 Jul 2025 16:02:20 +0200
Message-ID: <20250715140224.206329-5-angelogioacchino.delregno@collabora.com>
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

Add a driver for the regulators found on the MT6363 PMIC, fully
controlled by SPMI interface.
This PMIC regulates voltage with an input range of 2.6-5.0V, and
features 10 buck converters and 26 LDOs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/regulator/Kconfig                  |   9 +
 drivers/regulator/Makefile                 |   1 +
 drivers/regulator/mt6363-regulator.c       | 934 +++++++++++++++++++++
 include/linux/regulator/mt6363-regulator.h | 331 ++++++++
 4 files changed, 1275 insertions(+)
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
index 000000000000..e2376ca8cadf
--- /dev/null
+++ b/drivers/regulator/mt6363-regulator.c
@@ -0,0 +1,934 @@
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
+enum {
+	MT6363_ID_VBUCK1,
+	MT6363_ID_VBUCK2,
+	MT6363_ID_VBUCK3,
+	MT6363_ID_VBUCK4,
+	MT6363_ID_VBUCK5,
+	MT6363_ID_VBUCK6,
+	MT6363_ID_VBUCK7,
+	MT6363_ID_VS1,
+	MT6363_ID_VS2,
+	MT6363_ID_VS3,
+	MT6363_ID_VA12_1,
+	MT6363_ID_VA12_2,
+	MT6363_ID_VA15,
+	MT6363_ID_VAUX18,
+	MT6363_ID_VCN13,
+	MT6363_ID_VCN15,
+	MT6363_ID_VEMC,
+	MT6363_ID_VIO075,
+	MT6363_ID_VIO18,
+	MT6363_ID_VM18,
+	MT6363_ID_VSRAM_APU,
+	MT6363_ID_VSRAM_CPUB,
+	MT6363_ID_VSRAM_CPUM,
+	MT6363_ID_VSRAM_CPUL,
+	MT6363_ID_VSRAM_DIGRF,
+	MT6363_ID_VSRAM_MDFE,
+	MT6363_ID_VSRAM_MODEM,
+	MT6363_ID_VRF09,
+	MT6363_ID_VRF12,
+	MT6363_ID_VRF13,
+	MT6363_ID_VRF18,
+	MT6363_ID_VRFIO18,
+	MT6363_ID_VTREF18,
+	MT6363_ID_VUFS12,
+	MT6363_ID_VUFS18,
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
+ * @lp_imax_uA: Maximum load current (microamps), for Low Power mode only
+ * @op_en_reg: Operation mode enablement register
+ * @orig_op_en: Backup of a regulator's operation mode enablement register
+ * @orig_op_cfg: Backup of a regulator's operation mode configuration register
+ * @oc_work: Delayed work for enabling overcurrent IRQ
+ * @hwirq: PMIC-Internal HW Interrupt for overcurrent event
+ * @virq: Mapped Interrupt for overcurrent event
+ */
+struct mt6363_regulator_info {
+	struct regulator_desc desc;
+	u16 lp_mode_reg;
+	u16 lp_mode_mask;
+	u16 hw_lp_mode_reg;
+	u16 hw_lp_mode_mask;
+	u16 modeset_reg;
+	u16 modeset_mask;
+	int lp_imax_uA;
+	u16 op_en_reg;
+	u32 orig_op_en;
+	u8 orig_op_cfg;
+	struct delayed_work oc_work;
+	u8 hwirq;
+	int virq;
+};
+
+#define MT6363_BUCK(match, vreg, min, max, step, en_reg, lp_reg,	\
+		    mset_reg, ocp_intn)					\
+[MT6363_ID_##vreg] = {							\
+	.desc = {							\
+		.name = match,						\
+		.supply_name = "vsys-"match,				\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6363_vreg_setclr_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6363_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min) / step + 1,			\
+		.min_uV = min,						\
+		.uV_step = step,					\
+		.enable_reg = en_reg,					\
+		.enable_mask = BIT(MT6363_RG_BUCK_##vreg##_EN_BIT),	\
+		.vsel_reg = MT6363_RG_BUCK_##vreg##_VOSEL_ADDR,		\
+		.vsel_mask = MT6363_RG_BUCK_##vreg##_VOSEL_MASK,	\
+		.of_map_mode = mt6363_map_mode,				\
+	},								\
+	.lp_mode_reg = lp_reg,						\
+	.lp_mode_mask = BIT(MT6363_RG_BUCK_##vreg##_LP_BIT),		\
+	.hw_lp_mode_reg = MT6363_BUCK_##vreg##_HW_LP_MODE,		\
+	.hw_lp_mode_mask = 0xc,						\
+	.modeset_reg = mset_reg,					\
+	.modeset_mask = BIT(MT6363_RG_##vreg##_FCCM_BIT),		\
+	.lp_imax_uA = 100000,						\
+	.op_en_reg = MT6363_BUCK_##vreg##_OP_EN_0,			\
+	.hwirq = ocp_intn,						\
+}
+
+#define MT6363_LDO_LINEAR_OPS(match, vreg, in_sup, vops, min, max,	\
+			      step, buck_reg, ocp_intn)			\
+[MT6363_ID_##vreg] = {							\
+	.desc = {							\
+		.name = match,						\
+		.supply_name = in_sup,					\
+		.of_match = of_match_ptr(match),			\
+		.ops = &vops,						\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6363_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min) / step + 1,			\
+		.min_uV = min,						\
+		.uV_step = step,					\
+		.enable_reg = MT6363_RG_##buck_reg##_EN_ADDR,		\
+		.enable_mask = BIT(MT6363_RG_LDO_##vreg##_EN_BIT),	\
+		.vsel_reg = MT6363_RG_LDO_##vreg##_VOSEL_ADDR,		\
+		.vsel_mask = MT6363_RG_LDO_##vreg##_VOSEL_MASK,		\
+		.of_map_mode = mt6363_map_mode,				\
+	},								\
+	.lp_mode_reg = MT6363_RG_##buck_reg##_LP_ADDR,			\
+	.lp_mode_mask = BIT(MT6363_RG_LDO_##vreg##_LP_BIT),		\
+	.hw_lp_mode_reg = MT6363_LDO_##vreg##_HW_LP_MODE,		\
+	.hw_lp_mode_mask = 0x4,						\
+	.hwirq = ocp_intn,						\
+}
+
+#define MT6363_LDO_L_SC(match, vreg, inp, min, max, step, buck_reg,	\
+			ocp_intn)					\
+	MT6363_LDO_LINEAR_OPS(match, vreg, inp, mt6363_vreg_setclr_ops,	\
+			      min, max, step, buck_reg, ocp_intn)
+
+#define MT6363_LDO_L(match, vreg, inp, min, max, step, buck_reg,	\
+		     ocp_intn)						\
+	MT6363_LDO_LINEAR_OPS(match, vreg, inp, mt6363_ldo_linear_ops,	\
+			      min, max, step, buck_reg, ocp_intn)
+
+#define MT6363_LDO_LINEAR_CAL_OPS(match, vreg, in_sup, vops, vrnum,	\
+				  ocp_intn)				\
+[MT6363_ID_##vreg] = {							\
+	.desc = {							\
+		.name = match,						\
+		.supply_name = in_sup,					\
+		.of_match = of_match_ptr(match),			\
+		.ops = &vops,						\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6363_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = ARRAY_SIZE(ldo_volt_ranges##vrnum) * 11,	\
+		.linear_ranges = ldo_volt_ranges##vrnum,		\
+		.n_linear_ranges = ARRAY_SIZE(ldo_volt_ranges##vrnum),	\
+		.linear_range_selectors_bitfield = ldos_cal_selectors,	\
+		.enable_reg = MT6363_RG_LDO_##vreg##_ADDR,		\
+		.enable_mask = BIT(MT6363_RG_LDO_##vreg##_EN_BIT),	\
+		.vsel_reg = MT6363_RG_##vreg##_VOCAL_ADDR,		\
+		.vsel_mask = MT6363_RG_##vreg##_VOCAL_MASK,		\
+		.vsel_range_reg = MT6363_RG_##vreg##_VOSEL_ADDR,	\
+		.vsel_range_mask = MT6363_RG_##vreg##_VOSEL_MASK,	\
+		.of_map_mode = mt6363_map_mode,				\
+	},								\
+	.lp_mode_reg = MT6363_RG_LDO_##vreg##_ADDR,			\
+	.lp_mode_mask = BIT(MT6363_RG_LDO_##vreg##_LP_BIT),		\
+	.hw_lp_mode_reg = MT6363_LDO_##vreg##_HW_LP_MODE,		\
+	.hw_lp_mode_mask = 0x4,						\
+	.lp_imax_uA = 10000,						\
+	.op_en_reg = MT6363_LDO_##vreg##_OP_EN0,			\
+	.hwirq = ocp_intn,						\
+}
+
+#define MT6363_LDO_VT(match, vreg, inp, vranges_num, ocp_intn)		\
+	MT6363_LDO_LINEAR_CAL_OPS(match, vreg, inp, mt6363_ldo_vtable_ops,\
+				  vranges_num, ocp_intn)
+
+static const unsigned int ldos_cal_selectors[] = {
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
+};
+
+static const struct linear_range ldo_volt_ranges0[] = {
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
+static const struct linear_range ldo_volt_ranges1[] = {
+	REGULATOR_LINEAR_RANGE(900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1810000, 0, 10, 10000)
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
+	REGULATOR_LINEAR_RANGE(550000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(600000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(650000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(700000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(750000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(800000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(900000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(950000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(1000000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(1050000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(1100000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(1150000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(1700000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(1750000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(1850000, 0, 10, 5000)
+};
+
+static const struct linear_range ldo_volt_ranges5[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(650000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(700000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(750000, 0, 10, 5000),
+	REGULATOR_LINEAR_RANGE(800000, 0, 10, 5000)
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
+	if (info->modeset_reg) {
+		ret = regmap_read(rdev->regmap, info->modeset_reg, &val);
+		if (ret) {
+			dev_err(&rdev->dev, "Failed to get mt6363 mode: %d\n", ret);
+			return ret;
+		}
+
+		if (val & info->modeset_mask)
+			return REGULATOR_MODE_FAST;
+	} else {
+		val = 0;
+	};
+
+	ret = regmap_read(rdev->regmap, info->hw_lp_mode_reg, &val);
+	val &= info->hw_lp_mode_mask;
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
+	if (!info->modeset_reg && mode == REGULATOR_MODE_FAST)
+		return -EOPNOTSUPP;
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
+	const struct regulator_desc *rdesc = rdev->desc;
+	struct regmap *regmap = rdev->regmap;
+	unsigned int range, val;
+	int i, ret;
+	u16 mask;
+
+	for (i = 0; i < rdesc->n_linear_ranges; i++) {
+		const struct linear_range *r = &rdesc->linear_ranges[i];
+		unsigned int voltages_in_range = linear_range_values_in_range(r);
+
+		if (sel < voltages_in_range)
+			break;
+		sel -= voltages_in_range;
+	}
+
+	if (i == rdesc->n_linear_ranges)
+		return -EINVAL;
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
+		mask = rdesc->vsel_mask;
+	}
+
+	sel <<= ffs(rdesc->vsel_mask) - 1;
+	sel += rdesc->linear_ranges[i].min_sel;
+
+	range = rdesc->linear_range_selectors_bitfield[i];
+	range <<= ffs(rdesc->vsel_range_mask) - 1;
+
+	/* Write to the vreg calibration register for voltage finetuning */
+	ret = regmap_update_bits(regmap, rdesc->vsel_range_reg,
+				 rdesc->vsel_range_mask, range);
+	if (ret)
+		goto lock_tma;
+
+	/* Function must return the result of this write operation */
+	ret = regmap_update_bits(regmap, rdesc->vsel_reg, mask, sel);
+
+lock_tma:
+	/* Unconditionally re-lock TMA */
+	val = 0;
+	regmap_bulk_write(rdev->regmap, MT6363_TOP_TMA_KEY_L, &val, 2);
+
+	return ret;
+}
+
+static int mt6363_vemc_get_voltage_sel(struct regulator_dev *rdev)
+{
+	const struct regulator_desc *rdesc = rdev->desc;
+	unsigned int vosel, trap, calsel;
+	int vcal, vsel, range, ret;
+
+	ret = regmap_read(rdev->regmap, rdesc->vsel_reg, &vosel);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(rdev->regmap, rdesc->vsel_range_reg, &calsel);
+	if (ret)
+		return ret;
+
+	calsel &= rdesc->vsel_range_mask;
+	for (range = 0; range < rdesc->n_linear_ranges; range++)
+		if (rdesc->linear_range_selectors_bitfield[range] != calsel)
+			break;
+
+	if (range == rdesc->n_linear_ranges)
+		return -EINVAL;
+
+	ret = regmap_read(rdev->regmap, MT6363_TOP_TRAP, &trap);
+	if (ret)
+		return ret;
+
+	/* If HW trapping value is 1, use VEMC_VOSEL_1 instead of VEMC_VOSEL_0 */
+	if (trap > 1)
+		return -EINVAL;
+	else if (trap == 1)
+		vsel = FIELD_GET(MT6363_RG_VEMC_VOSEL_1_MASK, vosel);
+	else
+		vsel = vosel & rdesc->vsel_mask;
+
+	vcal = linear_range_values_in_range_array(rdesc->linear_ranges, range);
+
+	return vsel + vcal;
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
+	ret = regulator_set_voltage_sel_pickable_regmap(rdev, sel);
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
+	enable_irq(info->virq);
+}
+
+static irqreturn_t mt6363_oc_isr(int irq, void *data)
+{
+	struct regulator_dev *rdev = (struct regulator_dev *)data;
+	struct mt6363_regulator_info *info = rdev_get_drvdata(rdev);
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
+static int mt6363_set_ocp(struct regulator_dev *rdev, int lim, int severity, bool enable)
+{
+	struct mt6363_regulator_info *info = rdev_get_drvdata(rdev);
+
+	/* MT6363 supports only enabling protection and does not support limits */
+	if (lim || severity != REGULATOR_SEVERITY_PROT || !enable)
+		return -EOPNOTSUPP;
+
+	/* If there is no OCP interrupt, there's nothing to set */
+	if (info->virq <= 0)
+		return -EOPNOTSUPP;
+
+	return devm_request_threaded_irq(&rdev->dev, info->virq, NULL,
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
+	.list_voltage = regulator_list_voltage_pickable_linear_range,
+	.map_voltage = regulator_map_voltage_pickable_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_pickable_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
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
+	.list_voltage = regulator_list_voltage_pickable_linear_range,
+	.map_voltage = regulator_map_voltage_pickable_linear_range,
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
+	.list_voltage = regulator_list_voltage_pickable_linear_range,
+	.map_voltage = regulator_map_voltage_pickable_linear_range,
+	.set_voltage_sel = mt6363_va15_set_voltage_sel,
+	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
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
+/* The array is indexed by id(MT6363_ID_XXX) */
+static struct mt6363_regulator_info mt6363_regulators[] = {
+	MT6363_BUCK("vbuck1", VBUCK1, 0, 1193750, 6250, MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK0_LP_ADDR, MT6363_RG_BUCK0_FCCM_ADDR, 1),
+	MT6363_BUCK("vbuck2", VBUCK2, 0, 1193750, 6250, MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK0_LP_ADDR, MT6363_RG_BUCK0_FCCM_ADDR, 2),
+	MT6363_BUCK("vbuck3", VBUCK3, 0, 1193750, 6250, MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK0_LP_ADDR, MT6363_RG_BUCK0_FCCM_ADDR, 3),
+	MT6363_BUCK("vbuck4", VBUCK4, 0, 1193750, 6250, MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK0_LP_ADDR, MT6363_RG_BUCK0_1_FCCM_ADDR, 4),
+	MT6363_BUCK("vbuck5", VBUCK5, 0, 1193750, 6250, MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK0_LP_ADDR, MT6363_RG_BUCK0_1_FCCM_ADDR, 5),
+	MT6363_BUCK("vbuck6", VBUCK6, 0, 1193750, 6250, MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK0_LP_ADDR, MT6363_RG_BUCK0_1_FCCM_ADDR, 6),
+	MT6363_BUCK("vbuck7", VBUCK7, 0, 1193750, 6250, MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK0_LP_ADDR, MT6363_RG_BUCK0_1_FCCM_ADDR, 7),
+	MT6363_BUCK("vs1", VS1, 0, 2200000, 12500, MT6363_RG_BUCK1_EN_ADDR,
+		    MT6363_RG_BUCK1_LP_ADDR, MT6363_RG_VS1_FCCM_ADDR, 8),
+	MT6363_BUCK("vs2", VS2, 0, 1600000, 12500, MT6363_RG_BUCK0_EN_ADDR,
+		    MT6363_RG_BUCK0_LP_ADDR, MT6363_RG_BUCK0_FCCM_ADDR, 0),
+	MT6363_BUCK("vs3", VS3, 0, 1193750, 6250, MT6363_RG_BUCK1_EN_ADDR,
+		    MT6363_RG_BUCK1_LP_ADDR, MT6363_RG_VS3_FCCM_ADDR, 9),
+	MT6363_LDO_VT("va12-1", VA12_1, "vs2-ldo2", 3, 37),
+	MT6363_LDO_VT("va12-2", VA12_2, "vs2-ldo2", 3, 38),
+	MT6363_LDO_LINEAR_CAL_OPS("va15", VA15, "vs1-ldo1", mt6363_ldo_va15_ops, 3, 39),
+	MT6363_LDO_VT("vaux18", VAUX18, "vsys-ldo1", 2, 31),
+	MT6363_LDO_VT("vcn13", VCN13, "vs2-ldo2", 1, 17),
+	MT6363_LDO_VT("vcn15", VCN15, "vs1-ldo2", 3, 16),
+	MT6363_LDO_LINEAR_CAL_OPS("vemc", VEMC, "vsys-ldo1", mt6363_ldo_vemc_ops, 0, 32),
+	MT6363_LDO_VT("vio0p75", VIO075, "vs1-ldo1", 5, 36),
+	MT6363_LDO_VT("vio18", VIO18, "vs1-ldo2", 3, 35),
+	MT6363_LDO_VT("vm18", VM18, "vs1-ldo1", 4, 40),
+	MT6363_LDO_L("vsram-apu", VSRAM_APU, "vs3-ldo1", 400000, 1193750, 6250, BUCK1, 30),
+	MT6363_LDO_L("vsram-cpub", VSRAM_CPUB, "vs2-ldo1", 400000, 1193750, 6250, BUCK1, 27),
+	MT6363_LDO_L("vsram-cpum", VSRAM_CPUM, "vs2-ldo1", 400000, 1193750, 6250, BUCK1, 28),
+	MT6363_LDO_L("vsram-cpul", VSRAM_CPUL, "vs2-ldo2", 400000, 1193750, 6250, BUCK1, 29),
+	MT6363_LDO_L_SC("vsram-digrf", VSRAM_DIGRF, "vs3-ldo1", 400000, 1193750, 6250, BUCK1, 23),
+	MT6363_LDO_L_SC("vsram-mdfe", VSRAM_MDFE, "vs3-ldo1", 400000, 1193750, 6250, BUCK1, 24),
+	MT6363_LDO_L_SC("vsram-modem", VSRAM_MODEM, "vs3-ldo2", 400000, 1193750, 6250, BUCK1, 25),
+	MT6363_LDO_VT("vrf0p9", VRF09, "vs3-ldo2", 1, 18),
+	MT6363_LDO_VT("vrf12", VRF12, "vs2-ldo1", 3, 19),
+	MT6363_LDO_VT("vrf13", VRF13, "vs2-ldo1", 1, 20),
+	MT6363_LDO_VT("vrf18", VRF18, "vs1-ldo1", 3, 21),
+	MT6363_LDO_VT("vrf-io18", VRFIO18, "vs1-ldo1", 3, 22),
+	MT6363_LDO_VT("vtref18", VTREF18, "vsys-ldo1", 2, 26),
+	MT6363_LDO_VT("vufs12", VUFS12, "vs2-ldo1", 4, 33),
+	MT6363_LDO_VT("vufs18", VUFS18, "vs1-ldo2", 3, 34),
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
+static void mt6363_irq_remove(void *data)
+{
+	int *virq = data;
+
+	irq_dispose_mapping(*virq);
+}
+
+static void mt6363_spmi_remove(void *data)
+{
+	struct spmi_device *sdev = data;
+
+	spmi_device_remove(sdev);
+};
+
+static struct regmap *mt6363_spmi_register_regmap(struct device *dev)
+{
+	struct regmap_config mt6363_regmap_config = {
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
+	ret = devm_add_action_or_reset(dev, mt6363_spmi_remove, sdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	mt6363_regmap_config.reg_base = base;
+
+	return devm_regmap_init_spmi_ext(sdev, &mt6363_regmap_config);
+}
+
+static int mt6363_regulator_probe(struct platform_device *pdev)
+{
+	struct irq_fwspec fwspec = {
+		.param_count = 2,
+		.param = { 0, IRQ_TYPE_LEVEL_HIGH },
+	};
+	struct device_node *interrupt_parent;
+	struct regulator_config config = {};
+	struct mt6363_regulator_info *info;
+	struct device *dev = &pdev->dev;
+	struct regulator_dev *rdev;
+	struct irq_domain *domain;
+	int i, ret;
+
+	config.regmap = mt6363_spmi_register_regmap(dev);
+	if (!config.regmap)
+		return dev_err_probe(dev, PTR_ERR(config.regmap),
+				     "Cannot get regmap\n");
+	config.dev = dev;
+
+	interrupt_parent = of_irq_find_parent(dev->of_node);
+	if (!interrupt_parent)
+		return dev_err_probe(dev, -EINVAL, "Cannot find IRQ parent\n");
+
+	domain = irq_find_host(interrupt_parent);
+	of_node_put(interrupt_parent);
+	fwspec.fwnode = domain->fwnode;
+
+	for (i = 0; i < ARRAY_SIZE(mt6363_regulators); i++) {
+		info = &mt6363_regulators[i];
+
+		fwspec.param[0] = info->hwirq;
+		info->virq = irq_create_fwspec_mapping(&fwspec);
+		if (!info->virq)
+			return dev_err_probe(dev, -EINVAL,
+					     "Failed to map IRQ%d\n", info->hwirq);
+
+		ret = devm_add_action_or_reset(dev, mt6363_irq_remove, &info->virq);
+		if (ret) {
+			irq_dispose_mapping(info->hwirq);
+			return ret;
+		}
+
+		config.driver_data = info;
+		INIT_DELAYED_WORK(&info->oc_work, mt6363_oc_irq_enable_work);
+
+		rdev = devm_regulator_register(dev, &info->desc, &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(dev, PTR_ERR(rdev),
+					     "failed to register %s\n", info->desc.name);
+
+		if (info->lp_imax_uA) {
+			ret = mt6363_backup_op_setting(config.regmap, info);
+			if (ret) {
+				dev_warn(dev, "Failed to backup op_setting for %s\n",
+					 info->desc.name);
+				info->lp_imax_uA = 0;
+			}
+		}
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
index 000000000000..5df2bf21469c
--- /dev/null
+++ b/include/linux/regulator/mt6363-regulator.h
@@ -0,0 +1,331 @@
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
+#define MT6363_TOP_TRAP				0x6
+#define MT6363_TOP_TMA_KEY_L			0x36e
+#define MT6363_RG_BUCK0_EN_ADDR			0x210
+#define MT6363_RG_BUCK_VS2_EN_BIT		0
+#define MT6363_RG_BUCK_VBUCK1_EN_BIT		1
+#define MT6363_RG_BUCK_VBUCK2_EN_BIT		2
+#define MT6363_RG_BUCK_VBUCK3_EN_BIT		3
+#define MT6363_RG_BUCK_VBUCK4_EN_BIT		4
+#define MT6363_RG_BUCK_VBUCK5_EN_BIT		5
+#define MT6363_RG_BUCK_VBUCK6_EN_BIT		6
+#define MT6363_RG_BUCK_VBUCK7_EN_BIT		7
+#define MT6363_RG_BUCK1_EN_ADDR			0x213
+#define MT6363_RG_BUCK_VS1_EN_BIT		0
+#define MT6363_RG_BUCK_VS3_EN_BIT		1
+#define MT6363_RG_LDO_VSRAM_DIGRF_EN_BIT	4
+#define MT6363_RG_LDO_VSRAM_MDFE_EN_BIT		5
+#define MT6363_RG_LDO_VSRAM_MODEM_EN_BIT	6
+#define MT6363_RG_BUCK0_LP_ADDR			0x216
+#define MT6363_RG_BUCK_VS2_LP_BIT		0
+#define MT6363_RG_BUCK_VBUCK1_LP_BIT		1
+#define MT6363_RG_BUCK_VBUCK2_LP_BIT		2
+#define MT6363_RG_BUCK_VBUCK3_LP_BIT		3
+#define MT6363_RG_BUCK_VBUCK4_LP_BIT		4
+#define MT6363_RG_BUCK_VBUCK5_LP_BIT		5
+#define MT6363_RG_BUCK_VBUCK6_LP_BIT		6
+#define MT6363_RG_BUCK_VBUCK7_LP_BIT		7
+#define MT6363_RG_BUCK1_LP_ADDR			0x219
+#define MT6363_RG_BUCK_VS1_LP_BIT		0
+#define MT6363_RG_BUCK_VS3_LP_BIT		1
+#define MT6363_RG_LDO_VSRAM_DIGRF_LP_BIT	4
+#define MT6363_RG_LDO_VSRAM_MDFE_LP_BIT		5
+#define MT6363_RG_LDO_VSRAM_MODEM_LP_BIT	6
+#define MT6363_RG_BUCK_VS2_VOSEL_ADDR		0x21c
+#define MT6363_RG_BUCK_VS2_VOSEL_MASK		GENMASK(7, 0)
+#define MT6363_RG_BUCK_VBUCK1_VOSEL_ADDR	0x21d
+#define MT6363_RG_BUCK_VBUCK1_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_RG_BUCK_VBUCK2_VOSEL_ADDR	0x21e
+#define MT6363_RG_BUCK_VBUCK2_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_RG_BUCK_VBUCK3_VOSEL_ADDR	0x21f
+#define MT6363_RG_BUCK_VBUCK3_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_RG_BUCK_VBUCK4_VOSEL_ADDR	0x220
+#define MT6363_RG_BUCK_VBUCK4_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_RG_BUCK_VBUCK5_VOSEL_ADDR	0x221
+#define MT6363_RG_BUCK_VBUCK5_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_RG_BUCK_VBUCK6_VOSEL_ADDR	0x222
+#define MT6363_RG_BUCK_VBUCK6_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_RG_BUCK_VBUCK7_VOSEL_ADDR	0x223
+#define MT6363_RG_BUCK_VBUCK7_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_RG_BUCK_VS1_VOSEL_ADDR		0x224
+#define MT6363_RG_BUCK_VS1_VOSEL_MASK		GENMASK(7, 0)
+#define MT6363_RG_BUCK_VS3_VOSEL_ADDR		0x225
+#define MT6363_RG_BUCK_VS3_VOSEL_MASK		GENMASK(7, 0)
+#define MT6363_RG_LDO_VSRAM_DIGRF_VOSEL_ADDR	0x228
+#define MT6363_RG_LDO_VSRAM_DIGRF_VOSEL_MASK	GENMASK(6, 0)
+#define MT6363_RG_LDO_VSRAM_MDFE_VOSEL_ADDR	0x229
+#define MT6363_RG_LDO_VSRAM_MDFE_VOSEL_MASK	GENMASK(6, 0)
+#define MT6363_RG_LDO_VSRAM_MODEM_VOSEL_ADDR	0x22a
+#define MT6363_RG_LDO_VSRAM_MODEM_VOSEL_MASK	GENMASK(6, 0)
+#define MT6363_BUCK_TOP_KEY_PROT_LO		0x13fa
+#define MT6363_BUCK_VS2_WDTDBG_VOSEL_ADDR	0x13fc
+#define MT6363_BUCK_VBUCK1_WDTDBG_VOSEL_ADDR	0x13fd
+#define MT6363_BUCK_VBUCK2_WDTDBG_VOSEL_ADDR	0x13fe
+#define MT6363_BUCK_VBUCK3_WDTDBG_VOSEL_ADDR	0x13ff
+#define MT6363_BUCK_VBUCK4_WDTDBG_VOSEL_ADDR	0x1400
+#define MT6363_BUCK_VBUCK5_WDTDBG_VOSEL_ADDR	0x1401
+#define MT6363_BUCK_VBUCK6_WDTDBG_VOSEL_ADDR	0x1402
+#define MT6363_BUCK_VBUCK7_WDTDBG_VOSEL_ADDR	0x1403
+#define MT6363_BUCK_VS1_WDTDBG_VOSEL_ADDR	0x1404
+#define MT6363_BUCK_VS3_WDTDBG_VOSEL_ADDR	0x1405
+#define MT6363_RG_BUCK_EFUSE_RSV1		0x1417
+#define MT6363_RG_BUCK_EFUSE_RSV1_MASK		GENMASK(7, 4)
+#define MT6363_BUCK_VS2_OP_EN_0			0x145d
+#define MT6363_BUCK_VS2_HW_LP_MODE		0x1468
+#define MT6363_BUCK_VBUCK1_OP_EN_0		0x14dd
+#define MT6363_BUCK_VBUCK1_HW_LP_MODE		0x14e8
+#define MT6363_RG_BUCK_VBUCK1_SSHUB_EN_ADDR	0x14ea
+#define MT6363_RG_BUCK_VBUCK1_SSHUB_VOSEL_ADDR	0x14eb
+#define MT6363_RG_BUCK_VBUCK1_SSHUB_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_BUCK_VBUCK2_OP_EN_0		0x155d
+#define MT6363_BUCK_VBUCK2_HW_LP_MODE		0x1568
+#define MT6363_RG_BUCK_VBUCK2_SSHUB_EN_ADDR	0x156a
+#define MT6363_RG_BUCK_VBUCK2_SSHUB_VOSEL_ADDR	0x156b
+#define MT6363_RG_BUCK_VBUCK2_SSHUB_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_BUCK_VBUCK3_OP_EN_0		0x15dd
+#define MT6363_BUCK_VBUCK3_HW_LP_MODE		0x15e8
+#define MT6363_BUCK_VBUCK4_OP_EN_0		0x165d
+#define MT6363_BUCK_VBUCK4_HW_LP_MODE		0x1668
+#define MT6363_RG_BUCK_VBUCK4_SSHUB_EN_ADDR	0x166a
+#define MT6363_RG_BUCK_VBUCK4_SSHUB_VOSEL_ADDR	0x166b
+#define MT6363_RG_BUCK_VBUCK4_SSHUB_VOSEL_MASK	GENMASK(7, 0)
+#define MT6363_BUCK_VBUCK5_OP_EN_0		0x16dd
+#define MT6363_BUCK_VBUCK5_HW_LP_MODE		0x16e8
+#define MT6363_BUCK_VBUCK6_OP_EN_0		0x175d
+#define MT6363_BUCK_VBUCK6_HW_LP_MODE		0x1768
+#define MT6363_BUCK_VBUCK7_OP_EN_0		0x17dd
+#define MT6363_BUCK_VBUCK7_HW_LP_MODE		0x17e8
+#define MT6363_BUCK_VS1_OP_EN_0			0x185d
+#define MT6363_BUCK_VS1_HW_LP_MODE		0x1868
+#define MT6363_BUCK_VS3_OP_EN_0			0x18dd
+#define MT6363_BUCK_VS3_HW_LP_MODE		0x18e8
+#define MT6363_RG_VS1_FCCM_ADDR			0x1964
+#define MT6363_RG_VS1_FCCM_BIT			0
+#define MT6363_RG_VS3_FCCM_ADDR			0x1973
+#define MT6363_RG_VS3_FCCM_BIT			0
+#define MT6363_RG_BUCK0_FCCM_ADDR		0x1a02
+#define MT6363_RG_VBUCK1_FCCM_BIT		0
+#define MT6363_RG_VBUCK2_FCCM_BIT		1
+#define MT6363_RG_VBUCK3_FCCM_BIT		2
+#define MT6363_RG_VS2_FCCM_BIT			3
+#define MT6363_RG_BUCK0_1_FCCM_ADDR		0x1a82
+#define MT6363_RG_VBUCK4_FCCM_BIT		0
+#define MT6363_RG_VBUCK5_FCCM_BIT		1
+#define MT6363_RG_VBUCK6_FCCM_BIT		2
+#define MT6363_RG_VBUCK7_FCCM_BIT		3
+#define MT6363_RG_VCN13_VOSEL_ADDR		0x1b0f
+#define MT6363_RG_VCN13_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VEMC_VOSEL_ADDR		0x1b10
+#define MT6363_RG_VEMC_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VEMC_VOSEL_1_MASK		GENMASK(7, 4)
+#define MT6363_RG_LDO_VSRAM_CPUB_VOSEL_ADDR	0x1b14
+#define MT6363_RG_LDO_VSRAM_CPUB_VOSEL_MASK	GENMASK(6, 0)
+#define MT6363_RG_LDO_VSRAM_CPUM_VOSEL_ADDR	0x1b15
+#define MT6363_RG_LDO_VSRAM_CPUM_VOSEL_MASK	GENMASK(6, 0)
+#define MT6363_RG_LDO_VSRAM_CPUL_VOSEL_ADDR	0x1b16
+#define MT6363_RG_LDO_VSRAM_CPUL_VOSEL_MASK	GENMASK(6, 0)
+#define MT6363_RG_LDO_VSRAM_APU_VOSEL_ADDR	0x1b17
+#define MT6363_RG_LDO_VSRAM_APU_VOSEL_MASK	GENMASK(6, 0)
+#define MT6363_RG_VEMC_VOCAL_ADDR		0x1b1b
+#define MT6363_RG_VEMC_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_LDO_VCN15_ADDR		0x1b57
+#define MT6363_RG_LDO_VCN15_EN_BIT		0
+#define MT6363_RG_LDO_VCN15_LP_BIT		1
+#define MT6363_LDO_VCN15_HW_LP_MODE		0x1b5b
+#define MT6363_LDO_VCN15_OP_EN0			0x1b5c
+#define MT6363_RG_LDO_VRF09_ADDR		0x1b65
+#define MT6363_RG_LDO_VRF09_EN_BIT		0
+#define MT6363_RG_LDO_VRF09_LP_BIT		1
+#define MT6363_LDO_VRF09_HW_LP_MODE		0x1b69
+#define MT6363_LDO_VRF09_OP_EN0			0x1b6a
+#define MT6363_RG_LDO_VRF12_ADDR		0x1b73
+#define MT6363_RG_LDO_VRF12_EN_BIT		0
+#define MT6363_RG_LDO_VRF12_LP_BIT		1
+#define MT6363_LDO_VRF12_HW_LP_MODE		0x1b77
+#define MT6363_LDO_VRF12_OP_EN0			0x1b78
+#define MT6363_RG_LDO_VRF13_ADDR		0x1b81
+#define MT6363_RG_LDO_VRF13_EN_BIT		0
+#define MT6363_RG_LDO_VRF13_LP_BIT		1
+#define MT6363_LDO_VRF13_HW_LP_MODE		0x1b85
+#define MT6363_LDO_VRF13_OP_EN0			0x1b86
+#define MT6363_RG_LDO_VRF18_ADDR		0x1b8f
+#define MT6363_RG_LDO_VRF18_EN_BIT		0
+#define MT6363_RG_LDO_VRF18_LP_BIT		1
+#define MT6363_LDO_VRF18_HW_LP_MODE		0x1b93
+#define MT6363_LDO_VRF18_OP_EN0			0x1b94
+#define MT6363_RG_LDO_VRFIO18_ADDR		0x1b9d
+#define MT6363_RG_LDO_VRFIO18_EN_BIT		0
+#define MT6363_RG_LDO_VRFIO18_LP_BIT		1
+#define MT6363_LDO_VRFIO18_HW_LP_MODE		0x1ba1
+#define MT6363_LDO_VRFIO18_OP_EN0		0x1ba2
+#define MT6363_RG_LDO_VTREF18_ADDR		0x1bd7
+#define MT6363_RG_LDO_VTREF18_EN_BIT		0
+#define MT6363_RG_LDO_VTREF18_LP_BIT		1
+#define MT6363_LDO_VTREF18_HW_LP_MODE		0x1bdb
+#define MT6363_LDO_VTREF18_OP_EN0		0x1bdc
+#define MT6363_RG_LDO_VAUX18_ADDR		0x1be5
+#define MT6363_RG_LDO_VAUX18_EN_BIT		0
+#define MT6363_RG_LDO_VAUX18_LP_BIT		1
+#define MT6363_LDO_VAUX18_HW_LP_MODE		0x1be9
+#define MT6363_LDO_VAUX18_OP_EN0		0x1bea
+#define MT6363_RG_LDO_VEMC_ADDR			0x1bf3
+#define MT6363_RG_LDO_VEMC_EN_BIT		0
+#define MT6363_RG_LDO_VEMC_LP_BIT		1
+#define MT6363_LDO_VEMC_HW_LP_MODE		0x1bf7
+#define MT6363_LDO_VEMC_OP_EN0			0x1bf8
+#define MT6363_RG_LDO_VUFS12_ADDR		0x1c01
+#define MT6363_RG_LDO_VUFS12_EN_BIT		0
+#define MT6363_RG_LDO_VUFS12_LP_BIT		1
+#define MT6363_LDO_VUFS12_HW_LP_MODE		0x1c05
+#define MT6363_LDO_VUFS12_OP_EN0		0x1c06
+#define MT6363_RG_LDO_VUFS18_ADDR		0x1c0f
+#define MT6363_RG_LDO_VUFS18_EN_BIT		0
+#define MT6363_RG_LDO_VUFS18_LP_BIT		1
+#define MT6363_LDO_VUFS18_HW_LP_MODE		0x1c13
+#define MT6363_LDO_VUFS18_OP_EN0		0x1c14
+#define MT6363_RG_LDO_VIO18_ADDR		0x1c1d
+#define MT6363_RG_LDO_VIO18_EN_BIT		0
+#define MT6363_RG_LDO_VIO18_LP_BIT		1
+#define MT6363_LDO_VIO18_HW_LP_MODE		0x1c21
+#define MT6363_LDO_VIO18_OP_EN0			0x1c22
+#define MT6363_RG_LDO_VIO075_ADDR		0x1c57
+#define MT6363_RG_LDO_VIO075_EN_BIT		0
+#define MT6363_RG_LDO_VIO075_LP_BIT		1
+#define MT6363_LDO_VIO075_HW_LP_MODE		0x1c5b
+#define MT6363_LDO_VIO075_OP_EN0		0x1c5c
+#define MT6363_RG_LDO_VA12_1_ADDR		0x1c65
+#define MT6363_RG_LDO_VA12_1_EN_BIT		0
+#define MT6363_RG_LDO_VA12_1_LP_BIT		1
+#define MT6363_LDO_VA12_1_HW_LP_MODE		0x1c69
+#define MT6363_LDO_VA12_1_OP_EN0		0x1c6a
+#define MT6363_RG_LDO_VA12_2_ADDR		0x1c73
+#define MT6363_RG_LDO_VA12_2_EN_BIT		0
+#define MT6363_RG_LDO_VA12_2_LP_BIT		1
+#define MT6363_LDO_VA12_2_HW_LP_MODE		0x1c77
+#define MT6363_LDO_VA12_2_OP_EN0		0x1c78
+#define MT6363_RG_LDO_VA15_ADDR			0x1c81
+#define MT6363_RG_LDO_VA15_EN_BIT		0
+#define MT6363_RG_LDO_VA15_LP_BIT		1
+#define MT6363_LDO_VA15_HW_LP_MODE		0x1c85
+#define MT6363_LDO_VA15_OP_EN0			0x1c86
+#define MT6363_RG_LDO_VM18_ADDR			0x1c8f
+#define MT6363_RG_LDO_VM18_EN_BIT		0
+#define MT6363_RG_LDO_VM18_LP_BIT		1
+#define MT6363_LDO_VM18_HW_LP_MODE		0x1c93
+#define MT6363_LDO_VM18_OP_EN0			0x1c94
+#define MT6363_RG_LDO_VCN13_ADDR		0x1cd7
+#define MT6363_RG_LDO_VCN13_EN_BIT		0
+#define MT6363_RG_LDO_VCN13_LP_BIT		1
+#define MT6363_LDO_VCN13_HW_LP_MODE		0x1cdb
+#define MT6363_LDO_VCN13_OP_EN0			0x1ce4
+#define MT6363_LDO_VSRAM_DIGRF_HW_LP_MODE	0x1cf1
+#define MT6363_LDO_VSRAM_DIGRF_OP_EN0		0x1cfa
+#define MT6363_LDO_VSRAM_MDFE_HW_LP_MODE	0x1d5b
+#define MT6363_LDO_VSRAM_MDFE_OP_EN0		0x1d64
+#define MT6363_LDO_VSRAM_MODEM_HW_LP_MODE	0x1d76
+#define MT6363_LDO_VSRAM_MODEM_OP_EN0		0x1d7f
+#define MT6363_RG_LDO_VSRAM_CPUB_ADDR		0x1dd7
+#define MT6363_RG_LDO_VSRAM_CPUB_EN_BIT		0
+#define MT6363_RG_LDO_VSRAM_CPUB_LP_BIT		1
+#define MT6363_LDO_VSRAM_CPUB_HW_LP_MODE	0x1ddb
+#define MT6363_LDO_VSRAM_CPUB_OP_EN0		0x1de4
+#define MT6363_RG_LDO_VSRAM_CPUM_ADDR		0x1ded
+#define MT6363_RG_LDO_VSRAM_CPUM_EN_BIT		0
+#define MT6363_RG_LDO_VSRAM_CPUM_LP_BIT		1
+#define MT6363_LDO_VSRAM_CPUM_HW_LP_MODE	0x1df1
+#define MT6363_LDO_VSRAM_CPUM_OP_EN0		0x1dfa
+#define MT6363_RG_LDO_VSRAM_CPUL_ADDR		0x1e57
+#define MT6363_RG_LDO_VSRAM_CPUL_EN_BIT		0
+#define MT6363_RG_LDO_VSRAM_CPUL_LP_BIT		1
+#define MT6363_LDO_VSRAM_CPUL_HW_LP_MODE	0x1e5b
+#define MT6363_LDO_VSRAM_CPUL_OP_EN0		0x1e64
+#define MT6363_RG_LDO_VSRAM_APU_ADDR		0x1e6d
+#define MT6363_RG_LDO_VSRAM_APU_EN_BIT		0
+#define MT6363_RG_LDO_VSRAM_APU_LP_BIT		1
+#define MT6363_LDO_VSRAM_APU_HW_LP_MODE		0x1e71
+#define MT6363_LDO_VSRAM_APU_OP_EN0		0x1e7a
+#define MT6363_RG_VTREF18_VOCAL_ADDR		0x1ed8
+#define MT6363_RG_VTREF18_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VTREF18_VOSEL_ADDR		0x1ed9
+#define MT6363_RG_VTREF18_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VAUX18_VOCAL_ADDR		0x1edc
+#define MT6363_RG_VAUX18_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VAUX18_VOSEL_ADDR		0x1edd
+#define MT6363_RG_VAUX18_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VCN15_VOCAL_ADDR		0x1ee3
+#define MT6363_RG_VCN15_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VCN15_VOSEL_ADDR		0x1ee4
+#define MT6363_RG_VCN15_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VUFS18_VOCAL_ADDR		0x1ee7
+#define MT6363_RG_VUFS18_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VUFS18_VOSEL_ADDR		0x1ee8
+#define MT6363_RG_VUFS18_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VIO18_VOCAL_ADDR		0x1eeb
+#define MT6363_RG_VIO18_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VIO18_VOSEL_ADDR		0x1eec
+#define MT6363_RG_VIO18_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VM18_VOCAL_ADDR		0x1eef
+#define MT6363_RG_VM18_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VM18_VOSEL_ADDR		0x1ef0
+#define MT6363_RG_VM18_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VA15_VOCAL_ADDR		0x1ef3
+#define MT6363_RG_VA15_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VA15_VOSEL_ADDR		0x1ef4
+#define MT6363_RG_VA15_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF18_VOCAL_ADDR		0x1ef7
+#define MT6363_RG_VRF18_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF18_VOSEL_ADDR		0x1ef8
+#define MT6363_RG_VRF18_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRFIO18_VOCAL_ADDR		0x1efb
+#define MT6363_RG_VRFIO18_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRFIO18_VOSEL_ADDR		0x1efc
+#define MT6363_RG_VRFIO18_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VIO075_VOCFG_ADDR		0x1f01
+#define MT6363_RG_VIO075_VOCAL_ADDR		MT6363_RG_VIO075_VOCFG_ADDR
+#define MT6363_RG_VIO075_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VIO075_VOSEL_ADDR		MT6363_RG_VIO075_VOCFG_ADDR
+#define MT6363_RG_VIO075_VOSEL_MASK		GENMASK(6, 4)
+#define MT6363_RG_VCN13_VOCAL_ADDR		0x1f58
+#define MT6363_RG_VCN13_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VUFS12_VOCAL_ADDR		0x1f61
+#define MT6363_RG_VUFS12_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VUFS12_VOSEL_ADDR		0x1f62
+#define MT6363_RG_VUFS12_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VA12_1_VOCAL_ADDR		0x1f65
+#define MT6363_RG_VA12_1_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VA12_1_VOSEL_ADDR		0x1f66
+#define MT6363_RG_VA12_1_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VA12_2_VOCAL_ADDR		0x1f69
+#define MT6363_RG_VA12_2_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VA12_2_VOSEL_ADDR		0x1f6a
+#define MT6363_RG_VA12_2_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF12_VOCAL_ADDR		0x1f6d
+#define MT6363_RG_VRF12_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF12_VOSEL_ADDR		0x1f6e
+#define MT6363_RG_VRF12_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF13_VOCAL_ADDR		0x1f71
+#define MT6363_RG_VRF13_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF13_VOSEL_ADDR		0x1f72
+#define MT6363_RG_VRF13_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF09_VOCAL_ADDR		0x1f78
+#define MT6363_RG_VRF09_VOCAL_MASK		GENMASK(3, 0)
+#define MT6363_RG_VRF09_VOSEL_ADDR		0x1f79
+#define MT6363_RG_VRF09_VOSEL_MASK		GENMASK(3, 0)
+#define MT6363_ISINK_EN_CTRL0			0x21db
+#define MT6363_ISINK_CTRL0_MASK			GENMASK(7, 0)
+#define MT6363_ISINK_EN_CTRL1			0x21dc
+#define MT6363_ISINK_CTRL1_MASK			GENMASK(7, 4)
+
+#endif /* __LINUX_REGULATOR_MT6363_H */
+
-- 
2.50.1


