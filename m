Return-Path: <linux-kernel+bounces-767706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818D8B257ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96857584909
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B5630AAC1;
	Wed, 13 Aug 2025 23:56:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902C4301487;
	Wed, 13 Aug 2025 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129394; cv=none; b=ssKP0hzgcHvGYpb4uRcSrcND0gc6cT8LN01CaDvIocZISee/WnnIb1dtCpDTeY/CIN8O9zsjs9n/QhABWnJ509XcqyLQSeQWJs1vKQ5h7Pi/KgjS2lsJb7yeohb5R5damX2nZkI0LbzsODpE8PMZo8HLlmNWQyNbTbyS3gT4t0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129394; c=relaxed/simple;
	bh=9SZaf2Pvy4PXnnkpfDP9DUd/h2+z4x5N2HUP0onsn4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezqkpQIuNpTALQzLcP7bA+gU3fnsgTkWsk2Zne7QsuMev9uVBLmOHH8OqLETNiPtKq8jvZOUOfN2bfnNvwaboaI0XOClnTQx9sHRsL00qx+dTKbwcjDTQZn1Vj8yxr5SOyRRhqZb4bS/1BKyAL6FQtEVEtga8fxdF4uIl283EWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B75F71595;
	Wed, 13 Aug 2025 16:56:23 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 002023F738;
	Wed, 13 Aug 2025 16:56:29 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] mfd: axp20x: Add support for AXP318W PMIC
Date: Thu, 14 Aug 2025 00:53:29 +0100
Message-ID: <20250813235330.24263-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250813235330.24263-1-andre.przywara@arm.com>
References: <20250813235330.24263-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AXP318W is a PMIC chip produced by X-Powers, it can be connected to
an I2C bus.

It has a large number of regulators: 9(!) DCDC buck converters, and 28
LDOs, also some ADCs, interrupts, and a power key.

Describe the regmap and the MFD bits, along with the registers exposed
via I2C only. This covers the regulator, interrupts and power key
devices for now.
Advertise the device using the new compatible string.

We use just "318" for the internal identifiers, for easier typing and
less churn, but use "318W" for anything externally visible. If something
else other than the "AXP318W" shows up, that's an easy change then.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mfd/axp20x-i2c.c   |  2 +
 drivers/mfd/axp20x.c       | 84 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h | 86 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index 5c93136f977e7..4e4ebfc78525c 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -65,6 +65,7 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
 	{ .compatible = "x-powers,axp221", .data = (void *)AXP221_ID },
 	{ .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
 	{ .compatible = "x-powers,axp313a", .data = (void *)AXP313A_ID },
+	{ .compatible = "x-powers,axp318w", .data = (void *)AXP318_ID },
 	{ .compatible = "x-powers,axp323", .data = (void *)AXP323_ID },
 	{ .compatible = "x-powers,axp717", .data = (void *)AXP717_ID },
 	{ .compatible = "x-powers,axp803", .data = (void *)AXP803_ID },
@@ -83,6 +84,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
 	{ "axp221" },
 	{ "axp223" },
 	{ "axp313a" },
+	{ "axp318w" },
 	{ "axp717" },
 	{ "axp803" },
 	{ "axp806" },
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index c5f0ebae327f5..be9c59e3de071 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -42,6 +42,7 @@ static const char * const axp20x_model_names[] = {
 	[AXP223_ID] = "AXP223",
 	[AXP288_ID] = "AXP288",
 	[AXP313A_ID] = "AXP313a",
+	[AXP318_ID] = "AXP318W",
 	[AXP323_ID] = "AXP323",
 	[AXP717_ID] = "AXP717",
 	[AXP803_ID] = "AXP803",
@@ -218,6 +219,31 @@ static const struct regmap_access_table axp313a_volatile_table = {
 	.n_yes_ranges = ARRAY_SIZE(axp313a_volatile_ranges),
 };
 
+static const struct regmap_range axp318_writeable_ranges[] = {
+	regmap_reg_range(AXP318_DCDC_OUTPUT_CONTROL1, AXP318_IRQ_STATE4),
+	regmap_reg_range(AXP318_SHUTDOWN_CTRL, AXP318_TEMP_ADC_H_EN),
+	regmap_reg_range(AXP318_DIE_TEMP_ADC_H_EN, AXP318_DIE_TEMP_ADC_H_EN),
+	regmap_reg_range(AXP318_GPADC_H_EN, AXP318_GPADC_H_EN),
+	regmap_reg_range(AXP318_GPIO_CTRL, AXP318_WDOG_CTRL),
+};
+
+static const struct regmap_range axp318_volatile_ranges[] = {
+	regmap_reg_range(AXP318_IRQ_EN1, AXP318_IRQ_STATE4),
+	regmap_reg_range(AXP318_POWER_REASON, AXP318_SHUTDOWN_REASON),
+	regmap_reg_range(AXP318_TEMP_ADC_H_EN, AXP318_GPADC_L),
+	regmap_reg_range(AXP318_GPIO_INPUT, AXP318_GPIO_INPUT),
+};
+
+static const struct regmap_access_table axp318_writeable_table = {
+	.yes_ranges = axp318_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(axp318_writeable_ranges),
+};
+
+static const struct regmap_access_table axp318_volatile_table = {
+	.yes_ranges = axp318_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(axp318_volatile_ranges),
+};
+
 static const struct regmap_range axp717_writeable_ranges[] = {
 	regmap_reg_range(AXP717_PMU_FAULT, AXP717_MODULE_EN_CONTROL_1),
 	regmap_reg_range(AXP717_MIN_SYS_V_CONTROL, AXP717_BOOST_CONTROL),
@@ -365,6 +391,11 @@ static const struct resource axp313a_pek_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP313A_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
 };
 
+static const struct resource axp318_pek_resources[] = {
+	DEFINE_RES_IRQ_NAMED(AXP318_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
+	DEFINE_RES_IRQ_NAMED(AXP318_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
+};
+
 static const struct resource axp717_pek_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP717_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
 	DEFINE_RES_IRQ_NAMED(AXP717_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
@@ -444,6 +475,15 @@ static const struct regmap_config axp313a_regmap_config = {
 	.cache_type = REGCACHE_MAPLE,
 };
 
+static const struct regmap_config axp318_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.wr_table = &axp318_writeable_table,
+	.volatile_table = &axp318_volatile_table,
+	.max_register = AXP318_WDOG_CTRL,
+	.cache_type = REGCACHE_MAPLE,
+};
+
 static const struct regmap_config axp323_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -660,6 +700,28 @@ static const struct regmap_irq axp313a_regmap_irqs[] = {
 	INIT_REGMAP_IRQ(AXP313A, DIE_TEMP_HIGH,		0, 0),
 };
 
+static const struct regmap_irq axp318_regmap_irqs[] = {
+	INIT_REGMAP_IRQ(AXP318, DCDC8_V_LOW,		0, 7),
+	INIT_REGMAP_IRQ(AXP318, DCDC7_V_LOW,		0, 6),
+	INIT_REGMAP_IRQ(AXP318, DCDC6_V_LOW,		0, 5),
+	INIT_REGMAP_IRQ(AXP318, DCDC5_V_LOW,		0, 4),
+	INIT_REGMAP_IRQ(AXP318, DCDC4_V_LOW,		0, 3),
+	INIT_REGMAP_IRQ(AXP318, DCDC3_V_LOW,		0, 2),
+	INIT_REGMAP_IRQ(AXP318, DCDC2_V_LOW,		0, 1),
+	INIT_REGMAP_IRQ(AXP318, DCDC1_V_LOW,		0, 0),
+	INIT_REGMAP_IRQ(AXP318, PEK_RIS_EDGE,		1, 6),
+	INIT_REGMAP_IRQ(AXP318, PEK_FAL_EDGE,		1, 5),
+	INIT_REGMAP_IRQ(AXP318, PEK_LONG,		1, 4),
+	INIT_REGMAP_IRQ(AXP318, PEK_SHORT,		1, 3),
+	INIT_REGMAP_IRQ(AXP318, DIE_TEMP_HIGH_LV2,	1, 2),
+	INIT_REGMAP_IRQ(AXP318, DIE_TEMP_HIGH_LV1,	1, 1),
+	INIT_REGMAP_IRQ(AXP318, DCDC9_V_LOW,		1, 0),
+	INIT_REGMAP_IRQ(AXP318, GPIO3_INPUT,		2, 6),
+	INIT_REGMAP_IRQ(AXP318, GPIO2_INPUT,		2, 5),
+	INIT_REGMAP_IRQ(AXP318, GPIO1_INPUT,		2, 4),
+	INIT_REGMAP_IRQ(AXP318, WDOG_EXPIRE,		3, 0),
+};
+
 static const struct regmap_irq axp717_regmap_irqs[] = {
 	INIT_REGMAP_IRQ(AXP717, SOC_DROP_LVL2,		0, 7),
 	INIT_REGMAP_IRQ(AXP717, SOC_DROP_LVL1,		0, 6),
@@ -881,6 +943,17 @@ static const struct regmap_irq_chip axp313a_regmap_irq_chip = {
 	.num_regs		= 1,
 };
 
+static const struct regmap_irq_chip axp318_regmap_irq_chip = {
+	.name			= "axp318w_irq_chip",
+	.status_base		= AXP318_IRQ_STATE1,
+	.ack_base		= AXP318_IRQ_STATE1,
+	.unmask_base		= AXP318_IRQ_EN1,
+	.init_ack_masked	= true,
+	.irqs			= axp318_regmap_irqs,
+	.num_irqs		= ARRAY_SIZE(axp318_regmap_irqs),
+	.num_regs		= 4,
+};
+
 static const struct regmap_irq_chip axp717_regmap_irq_chip = {
 	.name			= "axp717_irq_chip",
 	.status_base		= AXP717_IRQ0_STATE,
@@ -1058,6 +1131,11 @@ static struct mfd_cell axp313a_cells[] = {
 	MFD_CELL_RES("axp313a-pek", axp313a_pek_resources),
 };
 
+static struct mfd_cell axp318_cells[] = {
+	MFD_CELL_BASIC("axp20x-regulator", NULL, NULL, 0, 1),
+	MFD_CELL_RES("axp318w-pek", axp318_pek_resources),
+};
+
 static struct mfd_cell axp717_cells[] = {
 	MFD_CELL_NAME("axp20x-regulator"),
 	MFD_CELL_RES("axp20x-pek", axp717_pek_resources),
@@ -1310,6 +1388,12 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_cfg = &axp313a_regmap_config;
 		axp20x->regmap_irq_chip = &axp313a_regmap_irq_chip;
 		break;
+	case AXP318_ID:
+		axp20x->nr_cells = ARRAY_SIZE(axp318_cells);
+		axp20x->cells = axp318_cells;
+		axp20x->regmap_cfg = &axp318_regmap_config;
+		axp20x->regmap_irq_chip = &axp318_regmap_irq_chip;
+		break;
 	case AXP323_ID:
 		axp20x->nr_cells = ARRAY_SIZE(axp313a_cells);
 		axp20x->cells = axp313a_cells;
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 3c5aecf1d4b5b..a871789f6cfa9 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -19,6 +19,7 @@ enum axp20x_variants {
 	AXP223_ID,
 	AXP288_ID,
 	AXP313A_ID,
+	AXP318_ID,
 	AXP323_ID,
 	AXP717_ID,
 	AXP803_ID,
@@ -116,6 +117,69 @@ enum axp20x_variants {
 #define AXP313A_IRQ_STATE		0x21
 #define AXP323_DCDC_MODE_CTRL2		0x22
 
+#define AXP318_DCDC_OUTPUT_CONTROL1	0x10
+#define AXP318_DCDC_OUTPUT_CONTROL2	0x11
+#define AXP318_DCDC1_CONTROL		0x12
+#define AXP318_DCDC2_CONTROL		0x13
+#define AXP318_DCDC3_CONTROL		0x14
+#define AXP318_DCDC4_CONTROL		0x15
+#define AXP318_DCDC5_CONTROL		0x16
+#define AXP318_DCDC6_CONTROL		0x17
+#define AXP318_DCDC7_CONTROL		0x18
+#define AXP318_DCDC8_CONTROL		0x19
+#define AXP318_DCDC9_CONTROL		0x1a
+#define AXP318_LDO_OUTPUT_CONTROL1	0x20
+#define AXP318_LDO_OUTPUT_CONTROL2	0x21
+#define AXP318_LDO_OUTPUT_CONTROL3	0x22
+#define AXP318_LDO_OUTPUT_CONTROL4	0x23
+#define AXP318_ALDO1_CONTROL		0x24
+#define AXP318_ALDO2_CONTROL		0x25
+#define AXP318_ALDO3_CONTROL		0x26
+#define AXP318_ALDO4_CONTROL		0x27
+#define AXP318_ALDO5_CONTROL		0x28
+#define AXP318_ALDO6_CONTROL		0x29
+#define AXP318_BLDO1_CONTROL		0x2a
+#define AXP318_BLDO2_CONTROL		0x2b
+#define AXP318_BLDO3_CONTROL		0x2c
+#define AXP318_BLDO4_CONTROL		0x2d
+#define AXP318_BLDO5_CONTROL		0x2e
+#define AXP318_CLDO1_CONTROL		0x2f
+#define AXP318_CLDO2_CONTROL		0x30
+#define AXP318_CLDO3_CONTROL		0x31
+#define AXP318_CLDO4_CONTROL		0x32
+#define AXP318_CLDO5_CONTROL		0x33
+#define AXP318_DLDO1_CONTROL		0x34
+#define AXP318_DLDO2_CONTROL		0x35
+#define AXP318_DLDO3_CONTROL		0x36
+#define AXP318_DLDO4_CONTROL		0x37
+#define AXP318_DLDO5_CONTROL		0x38
+#define AXP318_DLDO6_CONTROL		0x39
+#define AXP318_ELDO1_CONTROL		0x3a
+#define AXP318_ELDO2_CONTROL		0x3b
+#define AXP318_ELDO3_CONTROL		0x3c
+#define AXP318_ELDO4_CONTROL		0x3d
+#define AXP318_ELDO5_CONTROL		0x3e
+#define AXP318_ELDO6_CONTROL		0x3f
+#define AXP318_IRQ_EN1			0x40
+#define AXP318_IRQ_EN2			0x41
+#define AXP318_IRQ_EN3			0x42
+#define AXP318_IRQ_EN4			0x43
+#define AXP318_IRQ_STATE1		0x48
+#define AXP318_IRQ_STATE2		0x49
+#define AXP318_IRQ_STATE3		0x4a
+#define AXP318_IRQ_STATE4		0x4b
+#define AXP318_POWER_REASON		0x50
+#define AXP318_SHUTDOWN_REASON		0x51
+#define AXP318_SHUTDOWN_CTRL		0x52
+#define AXP318_TEMP_ADC_H_EN		0x65
+#define AXP318_TEMP_ADC_L		0x66
+#define AXP318_DIE_TEMP_ADC_H_EN	0x67
+#define AXP318_GPADC_H_EN		0x69
+#define AXP318_GPADC_L			0x6a
+#define AXP318_GPIO_CTRL		0x70
+#define AXP318_GPIO_INPUT		0x71
+#define AXP318_WDOG_CTRL		0x77
+
 #define AXP717_ON_INDICATE		0x00
 #define AXP717_PMU_STATUS_2		0x01
 #define AXP717_BC_DETECT		0x05
@@ -816,6 +880,28 @@ enum axp313a_irqs {
 	AXP313A_IRQ_PEK_RIS_EDGE,
 };
 
+enum axp318_irqs {
+	AXP318_IRQ_DCDC1_V_LOW,
+	AXP318_IRQ_DCDC2_V_LOW,
+	AXP318_IRQ_DCDC3_V_LOW,
+	AXP318_IRQ_DCDC4_V_LOW,
+	AXP318_IRQ_DCDC5_V_LOW,
+	AXP318_IRQ_DCDC6_V_LOW,
+	AXP318_IRQ_DCDC7_V_LOW,
+	AXP318_IRQ_DCDC8_V_LOW,
+	AXP318_IRQ_DCDC9_V_LOW,
+	AXP318_IRQ_DIE_TEMP_HIGH_LV1,
+	AXP318_IRQ_DIE_TEMP_HIGH_LV2,
+	AXP318_IRQ_PEK_SHORT,
+	AXP318_IRQ_PEK_LONG,
+	AXP318_IRQ_PEK_FAL_EDGE,
+	AXP318_IRQ_PEK_RIS_EDGE,
+	AXP318_IRQ_GPIO1_INPUT = 20,
+	AXP318_IRQ_GPIO2_INPUT,
+	AXP318_IRQ_GPIO3_INPUT,
+	AXP318_IRQ_WDOG_EXPIRE = 24,
+};
+
 enum axp717_irqs {
 	AXP717_IRQ_VBUS_FAULT,
 	AXP717_IRQ_VBUS_OVER_V,
-- 
2.46.3


