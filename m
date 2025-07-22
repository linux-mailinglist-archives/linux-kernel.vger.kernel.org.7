Return-Path: <linux-kernel+bounces-740483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CB8B0D4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A401AA7FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B6F2D836F;
	Tue, 22 Jul 2025 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="21fmAHEj"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F82D3EFA;
	Tue, 22 Jul 2025 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173333; cv=none; b=mb8k84fom9YoYRP+dnKZhkU6OWJ8/sL1WLZC7Z0BHiLZx5b+Px7KexsewHzUQDzI6thAweCwRFOdHq5hGTjfprnZ/M5T5nLVyeoEC5SqBBqW5GeUWy7+wPshPpmVXY5LrHqlbgAzZ5GfrRC/qaKnkbW6SQlpRqVpk0QI+4dVY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173333; c=relaxed/simple;
	bh=P5AjsW8dsuTLhNeKt2ojZE2lixC1Wok3R8d3AeOrB8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrMYa9k/j9Xb2GX2CHnhSjrDWHQzTstwkHRdTCMzxwTIfVjEuoz9tqBrefWcfS0eTehdEJcEPSjqr6YqoSC5ieP2OSpb/LyhCkt8/VAYTceC8+NJ4Axg2LLT5AJWTwG7yEMv0/2HV06yVBmEoaqWdmxb7wsvNYL/fbDxP3BNCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=21fmAHEj; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753173320;
	bh=TMwMF+ttmrloBY2tiLJfdEHSPL15XjX0rblrfWDsaIw=; l=21684;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=21fmAHEj4sXqPqcTXeiUvOjnGM9nTp3xqjEbz6j43aV7Rrj+AMuRtKVH8ZFm06il7
	 jI1oNhGgvYO1n5vYi4PCRe1f3FQiiK0GqxioLRU8SCMmRXXfaeBPx3m0mFZJjqJmt5
	 D16Bm9tmkOL4nD5kxkUAhjRjCo5wQx1xZ62+mDNka0247tmmsE7ys0t5U8dLg51dxS
	 Ao2bkT5YYkQdsAYSG2EcJOH/uCCPSu5Go05Ma5tgfwAnQLBFD3pGYwgawlHDD1esyH
	 rk6zhujJzhhLlZRHLzYVmrV9pkBiRGW3tvPExJeXwiTVhmsT8AYSP5C6NJQUe/3KmP
	 aFFJOVpL5FtAg==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244572:0:AUTH_RELAY)
	(envelope-from <jeff_chang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 22 Jul 2025 16:35:06 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Jul
 2025 16:35:06 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 22 Jul 2025 16:35:06 +0800
From: <jeff_chang@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <jeff_chang@richtek.com>
Subject: [PATCH v4 2/2] regulator: rt5133: Add RT5133 PMIC regulator Support
Date: Tue, 22 Jul 2025 16:34:18 +0800
Message-ID: <20250722083543.2730796-2-jeff_chang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250722083543.2730796-1-jeff_chang@richtek.com>
References: <20250722083543.2730796-1-jeff_chang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Jeff Chang <jeff_chang@richtek.com>

RT5133 is a highly-integrated chip. It includes 8 LDOs and 3 GPOs that can
be used to drive output high/low purpose. The dependency of the GPO block is
internally LDO1 Voltage.

Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
---

PATCH v4
1. Re-order patches. DT patch before driver patch.
2. Return IRQ_NONE if rt5133_intr_handler handle nothing.
3. Using cache for regmap_config.
4. Add prefix for vendor property richtek,oc-shutdown-all and richtek,pgb-shutdown-all.
5. Add _node_name to RT5133_REGULATOR_DESC for lowercase regulator node.

 drivers/regulator/Kconfig            |  12 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/rt5133-regulator.c | 649 +++++++++++++++++++++++++++
 3 files changed, 662 insertions(+)
 create mode 100644 drivers/regulator/rt5133-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 6d8988387da4..bada46e86cd0 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1229,6 +1229,18 @@ config REGULATOR_RT5120
 	  600mV to 1395mV, per step 6.250mV. The others are all fixed voltage
 	  by external hardware circuit.

+config REGULATOR_RT5133
+	tristate "Richtek RT5133 PMIC Regulators"
+	depends on I2C && GPIOLIB && OF
+	select REGMAP
+	select CRC8
+	select OF_GPIO
+	help
+	  This driver adds support for RT5133 PMIC regulators.
+	  RT5133 is an integrated chip. It includes 8 LDOs and 3 GPOs that
+	  can be used to drive output high/low purpose. The dependency of the
+	  GPO block is internally LDO1 Voltage.
+
 config REGULATOR_RT5190A
 	tristate "Richtek RT5190A PMIC"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index c0bc7a0f4e67..709384ae0a0c 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -145,6 +145,7 @@ obj-$(CONFIG_REGULATOR_RT4803)	+= rt4803.o
 obj-$(CONFIG_REGULATOR_RT4831)	+= rt4831-regulator.o
 obj-$(CONFIG_REGULATOR_RT5033)	+= rt5033-regulator.o
 obj-$(CONFIG_REGULATOR_RT5120)	+= rt5120-regulator.o
+obj-$(CONFIG_REGULATOR_RT5133)	+= rt5133-regulator.o
 obj-$(CONFIG_REGULATOR_RT5190A) += rt5190a-regulator.o
 obj-$(CONFIG_REGULATOR_RT5739)	+= rt5739.o
 obj-$(CONFIG_REGULATOR_RT5759)	+= rt5759-regulator.o
diff --git a/drivers/regulator/rt5133-regulator.c b/drivers/regulator/rt5133-regulator.c
new file mode 100644
index 000000000000..48c09682c01a
--- /dev/null
+++ b/drivers/regulator/rt5133-regulator.c
@@ -0,0 +1,649 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025 Richtek Technology Corp.
+// Author: ChiYuan Huang <cy_huang@richtek.com>
+// Author: ShihChia Chang <jeff_chang@richtek.com>
+
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+
+#define RT5133_REG_CHIP_INFO		0x00
+#define RT5133_REG_RST_CTRL		0x06
+#define RT5133_REG_BASE_CTRL		0x09
+#define RT5133_REG_GPIO_CTRL		0x0B
+#define RT5133_REG_BASE_EVT		0x10
+#define RT5133_REG_LDO_PGB_STAT		0x15
+#define RT5133_REG_BASE_MASK		0x16
+#define RT5133_REG_LDO_SHDN		0x19
+#define RT5133_REG_LDO_ON		0x1A
+#define RT5133_REG_LDO_OFF		0x1B
+#define RT5133_REG_LDO1_CTRL1		0x20
+#define RT5133_REG_LDO1_CTRL2		0x21
+#define RT5133_REG_LDO1_CTRL3		0x22
+#define RT5133_REG_LDO2_CTRL1		0x24
+#define RT5133_REG_LDO2_CTRL2		0x25
+#define RT5133_REG_LDO2_CTRL3		0x26
+#define RT5133_REG_LDO3_CTRL1		0x28
+#define RT5133_REG_LDO3_CTRL2		0x29
+#define RT5133_REG_LDO3_CTRL3		0x2A
+#define RT5133_REG_LDO4_CTRL1		0x2C
+#define RT5133_REG_LDO4_CTRL2		0x2D
+#define RT5133_REG_LDO4_CTRL3		0x2E
+#define RT5133_REG_LDO5_CTRL1		0x30
+#define RT5133_REG_LDO5_CTRL2		0x31
+#define RT5133_REG_LDO5_CTRL3		0x32
+#define RT5133_REG_LDO6_CTRL1		0x34
+#define RT5133_REG_LDO6_CTRL2		0x35
+#define RT5133_REG_LDO6_CTRL3		0x36
+#define RT5133_REG_LDO7_CTRL1		0x38
+#define RT5133_REG_LDO7_CTRL2		0x39
+#define RT5133_REG_LDO7_CTRL3		0x3A
+#define RT5133_REG_LDO8_CTRL1		0x3C
+#define RT5133_REG_LDO8_CTRL2		0x3D
+#define RT5133_REG_LDO8_CTRL3		0x3E
+#define RT5133_REG_LDO8_CTRL4		0x3F
+
+#define RT5133_LDO_REG_BASE(_id)	(0x20 + ((_id) - 1) * 4)
+
+#define RT5133_VENDOR_ID_MASK		GENMASK(7, 4)
+#define RT5133_RESET_CODE		0xB1
+
+#define RT5133_FOFF_BASE_MASK		BIT(1)
+#define RT5133_OCSHDN_ALL_MASK		BIT(7)
+#define RT5133_OCSHDN_ALL_SHIFT		(7)
+#define RT5133_PGBSHDN_ALL_MASK		BIT(6)
+#define RT5133_PGBSHDN_ALL_SHIFT	(6)
+
+#define RT5133_OCPTSEL_MASK		BIT(5)
+#define RT5133_PGBPTSEL_MASK		BIT(4)
+#define RT5133_STBTDSEL_MASK		GENMASK(1, 0)
+
+#define RT5133_LDO_ENABLE_MASK		BIT(7)
+#define RT5133_LDO_VSEL_MASK		GENMASK(7, 5)
+#define RT5133_LDO_AD_MASK		BIT(2)
+#define RT5133_LDO_SOFT_START_MASK	GENMASK(1, 0)
+
+#define RT5133_GPIO_NR			3
+
+#define RT5133_LDO_PGB_EVT_MASK		GENMASK(23, 16)
+#define RT5133_LDO_PGB_EVT_SHIFT	16
+#define RT5133_LDO_OC_EVT_MASK		GENMASK(15, 8)
+#define RT5133_LDO_OC_EVT_SHIFT		8
+#define RT5133_VREF_EVT_MASK		BIT(6)
+#define RT5133_BASE_EVT_MASK		GENMASK(7, 0)
+#define RT5133_INTR_CLR_MASK		GENMASK(23, 0)
+#define RT5133_INTR_BYTE_NR		3
+
+#define RT5133_MAX_I2C_BLOCK_SIZE	1
+
+#define RT5133_CRC8_POLYNOMIAL		0x7
+
+#define RT5133_I2C_ADDR_LEN		1
+#define RT5133_PREDATA_LEN		2
+#define RT5133_I2C_CRC_LEN		1
+#define RT5133_REG_ADDR_LEN		1
+#define RT5133_I2C_DUMMY_LEN		1
+
+#define I2C_ADDR_XLATE_8BIT(_addr, _rw)	((((_addr) & 0x7F) << 1) | (_rw))
+
+enum {
+	RT5133_REGULATOR_BASE = 0,
+	RT5133_REGULATOR_LDO1,
+	RT5133_REGULATOR_LDO2,
+	RT5133_REGULATOR_LDO3,
+	RT5133_REGULATOR_LDO4,
+	RT5133_REGULATOR_LDO5,
+	RT5133_REGULATOR_LDO6,
+	RT5133_REGULATOR_LDO7,
+	RT5133_REGULATOR_LDO8,
+	RT5133_REGULATOR_MAX
+};
+
+struct chip_data {
+	const struct regulator_desc *regulators;
+	const u8 vendor_id;
+};
+
+struct rt5133_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *enable_gpio;
+	struct regulator_dev *rdev[RT5133_REGULATOR_MAX];
+	struct gpio_chip gc;
+	const struct chip_data *cdata;
+	unsigned int gpio_output_flag;
+	u8 crc8_tbls[CRC8_TABLE_SIZE];
+};
+
+static const unsigned int vout_type1_tables[] = {
+	1800000, 2500000, 2700000, 2800000, 2900000, 3000000, 3100000, 3200000
+};
+
+static const unsigned int vout_type2_tables[] = {
+	1700000, 1800000, 1900000, 2500000, 2700000, 2800000, 2900000, 3000000
+};
+
+static const unsigned int vout_type3_tables[] = {
+	900000, 950000, 1000000, 1050000, 1100000, 1150000, 1200000, 1800000
+};
+
+static const unsigned int vout_type4_tables[] = {
+	855000, 900000, 950000, 1000000, 1040000, 1090000, 1140000, 1710000
+};
+
+static const struct regulator_ops rt5133_regulator_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+};
+
+static const struct regulator_ops rt5133_base_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+static int rt5133_of_parse_cb(struct device_node *node,
+			      const struct regulator_desc *desc,
+			      struct regulator_config *config)
+{
+	struct rt5133_priv *priv = config->driver_data;
+	unsigned int val = 0;
+	int ret = 0;
+
+	switch (desc->id) {
+	case RT5133_REGULATOR_BASE:
+		if (!of_property_read_bool(node, "richtek,oc-shutdown-all"))
+			val = 0;
+		else
+			val = 1 << RT5133_OCSHDN_ALL_SHIFT;
+		ret = regmap_update_bits(priv->regmap, RT5133_REG_LDO_SHDN,
+					 RT5133_OCSHDN_ALL_MASK, val);
+		if (ret)
+			return ret;
+
+		if (!of_property_read_bool(node, "richtek,pgb-shutdown-all"))
+			val = 0;
+		else
+			val = 1 << RT5133_PGBSHDN_ALL_SHIFT;
+		return regmap_update_bits(priv->regmap, RT5133_REG_LDO_SHDN,
+					  RT5133_PGBSHDN_ALL_MASK, val);
+	default:
+		break;
+	};
+
+	return 0;
+}
+
+#define RT5133_REGULATOR_DESC(_name, _node_name, vtables, _supply) \
+{\
+	.name = #_name,\
+	.id = RT5133_REGULATOR_##_name,\
+	.of_match = of_match_ptr(#_node_name),\
+	.regulators_node = of_match_ptr("regulators"),\
+	.supply_name = _supply,\
+	.of_parse_cb = rt5133_of_parse_cb,\
+	.type = REGULATOR_VOLTAGE,\
+	.owner = THIS_MODULE,\
+	.ops = &rt5133_regulator_ops,\
+	.n_voltages = ARRAY_SIZE(vtables),\
+	.volt_table = vtables,\
+	.enable_reg = RT5133_REG_##_name##_CTRL1,\
+	.enable_mask = RT5133_LDO_ENABLE_MASK,\
+	.vsel_reg = RT5133_REG_##_name##_CTRL2,\
+	.vsel_mask = RT5133_LDO_VSEL_MASK,\
+	.active_discharge_reg = RT5133_REG_##_name##_CTRL3,\
+	.active_discharge_mask = RT5133_LDO_AD_MASK,\
+}
+
+static const struct regulator_desc rt5133_regulators[] = {
+	/* For digital part, base current control */
+	{
+		.name = "rt5133,base",
+		.id = RT5133_REGULATOR_BASE,
+		.of_match = of_match_ptr("base"),
+		.regulators_node = of_match_ptr("regulators"),
+		.of_parse_cb = rt5133_of_parse_cb,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.ops = &rt5133_base_regulator_ops,
+		.enable_reg = RT5133_REG_BASE_CTRL,
+		.enable_mask = RT5133_FOFF_BASE_MASK,
+		.enable_is_inverted = true,
+	},
+	RT5133_REGULATOR_DESC(LDO1, ldo1, vout_type1_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO2, ldo2, vout_type1_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO3, ldo3, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO4, ldo4, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO5, ldo5, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO6, ldo6, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO7, ldo7, vout_type3_tables, "rt5133-ldo1"),
+	RT5133_REGULATOR_DESC(LDO8, ldo8, vout_type3_tables, "rt5133-ldo1"),
+};
+
+static const struct regulator_desc rt5133a_regulators[] = {
+	/* For digital part, base current control */
+	{
+		.name = "rt5133,base",
+		.id = RT5133_REGULATOR_BASE,
+		.of_match = of_match_ptr("base"),
+		.regulators_node = of_match_ptr("regulators"),
+		.of_parse_cb = rt5133_of_parse_cb,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.ops = &rt5133_base_regulator_ops,
+		.enable_reg = RT5133_REG_BASE_CTRL,
+		.enable_mask = RT5133_FOFF_BASE_MASK,
+		.enable_is_inverted = true,
+	},
+	RT5133_REGULATOR_DESC(LDO1, ldo1, vout_type1_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO2, ldo2, vout_type1_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO3, ldo3, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO4, ldo4, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO5, ldo5, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO6, ldo6, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO7, ldo7, vout_type3_tables, "rt5133-ldo1"),
+	RT5133_REGULATOR_DESC(LDO8, ldo8, vout_type4_tables, "rt5133-ldo1"),
+};
+
+static const struct chip_data regulator_data[] = {
+	{ rt5133_regulators, 0x70},
+	{ rt5133a_regulators, 0x80},
+};
+
+static int rt5133_gpio_direction_output(struct gpio_chip *gpio,
+					unsigned int offset, int value)
+{
+	struct rt5133_priv *priv = gpiochip_get_data(gpio);
+
+	if (offset >= RT5133_GPIO_NR)
+		return -EINVAL;
+
+	return regmap_update_bits(priv->regmap, RT5133_REG_GPIO_CTRL,
+				  BIT(7 - offset) | BIT(3 - offset),
+				  value ? BIT(7 - offset) | BIT(3 - offset) : 0);
+}
+
+static int rt5133_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct rt5133_priv *priv = gpiochip_get_data(chip);
+
+	return !!(priv->gpio_output_flag & BIT(offset));
+}
+
+static int rt5133_get_gpioen_mask(unsigned int offset, unsigned int *mask)
+{
+	if (offset >= RT5133_GPIO_NR)
+		return -EINVAL;
+
+	*mask = (BIT(7 - offset) | BIT(3 - offset));
+
+	return 0;
+}
+
+static void rt5133_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			    int set_val)
+{
+	struct rt5133_priv *priv = gpiochip_get_data(chip);
+	unsigned int mask = 0, val = 0, next_flag = priv->gpio_output_flag;
+	int ret = 0;
+
+	ret = rt5133_get_gpioen_mask(offset, &mask);
+	if (ret) {
+		dev_err(priv->dev, "%s get gpion en mask failed, offset(%d)\n", __func__, offset);
+		return;
+	}
+
+	val = set_val ? mask : 0;
+
+	if (set_val)
+		next_flag |= BIT(offset);
+	else
+		next_flag &= ~BIT(offset);
+
+	ret = regmap_update_bits(priv->regmap, RT5133_REG_GPIO_CTRL, mask, val);
+	if (ret) {
+		dev_err(priv->dev, "Failed to set gpio [%d] val %d\n", offset,
+			set_val);
+		return;
+	}
+
+	priv->gpio_output_flag = next_flag;
+}
+
+static irqreturn_t rt5133_intr_handler(int irq_number, void *data)
+{
+	struct rt5133_priv *priv = data;
+	u32 intr_evts = 0, handle_evts;
+	int i, ret;
+
+	ret = regmap_bulk_read(priv->regmap, RT5133_REG_BASE_EVT, &intr_evts,
+			       RT5133_INTR_BYTE_NR);
+	if (ret) {
+		dev_err(priv->dev, "%s, read event failed\n", __func__);
+		return IRQ_NONE;
+	}
+
+	handle_evts = intr_evts & RT5133_BASE_EVT_MASK;
+	/*
+	 * VREF_EVT is a special case, if base off
+	 * this event will also be trigger. Skip it
+	 */
+	if (handle_evts & ~RT5133_VREF_EVT_MASK)
+		dev_dbg(priv->dev, "base event occurred [0x%02x]\n",
+			handle_evts);
+
+	handle_evts = (intr_evts & RT5133_LDO_OC_EVT_MASK) >>
+		RT5133_LDO_OC_EVT_SHIFT;
+
+	for (i = RT5133_REGULATOR_LDO1; i < RT5133_REGULATOR_MAX && handle_evts; i++) {
+		if (!(handle_evts & BIT(i - 1)))
+			continue;
+		regulator_notifier_call_chain(priv->rdev[i],
+					      REGULATOR_EVENT_OVER_CURRENT,
+					      &i);
+	}
+
+	handle_evts = (intr_evts & RT5133_LDO_PGB_EVT_MASK) >>
+		RT5133_LDO_PGB_EVT_SHIFT;
+	for (i = RT5133_REGULATOR_LDO1; i < RT5133_REGULATOR_MAX && handle_evts; i++) {
+		if (!(handle_evts & BIT(i - 1)))
+			continue;
+		regulator_notifier_call_chain(priv->rdev[i],
+					      REGULATOR_EVENT_FAIL, &i);
+	}
+
+	ret = regmap_bulk_write(priv->regmap, RT5133_REG_BASE_EVT, &intr_evts,
+				RT5133_INTR_BYTE_NR);
+	if (ret)
+		dev_err(priv->dev, "%s, clear event failed\n", __func__);
+
+	return IRQ_HANDLED;
+}
+
+static int rt5133_enable_interrupts(int irq_no, struct rt5133_priv *priv)
+{
+	u32 mask = RT5133_INTR_CLR_MASK;
+	int ret;
+
+	/* Force to write clear all events */
+	ret = regmap_bulk_write(priv->regmap, RT5133_REG_BASE_EVT, &mask,
+				RT5133_INTR_BYTE_NR);
+	if (ret) {
+		dev_err(priv->dev, "Failed to clear all interrupts\n");
+		return ret;
+	}
+
+	/* Unmask all interrupts */
+	mask = 0;
+	ret = regmap_bulk_write(priv->regmap, RT5133_REG_BASE_MASK, &mask,
+				RT5133_INTR_BYTE_NR);
+	if (ret) {
+		dev_err(priv->dev, "Failed to unmask all interrupts\n");
+		return ret;
+	}
+
+	return devm_request_threaded_irq(priv->dev, irq_no, NULL,
+					 rt5133_intr_handler, IRQF_ONESHOT,
+					 dev_name(priv->dev), priv);
+}
+
+static int rt5133_regmap_hw_read(void *context, const void *reg_buf,
+				 size_t reg_size, void *val_buf,
+				 size_t val_size)
+{
+	struct rt5133_priv *priv = context;
+	struct i2c_client *client = to_i2c_client(priv->dev);
+	u8 reg = *(u8 *)reg_buf, crc;
+	u8 *buf;
+	int buf_len = RT5133_PREDATA_LEN + val_size + RT5133_I2C_CRC_LEN;
+	int read_len, ret;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = I2C_ADDR_XLATE_8BIT(client->addr, I2C_SMBUS_READ);
+	buf[1] = reg;
+
+	read_len = val_size + RT5133_I2C_CRC_LEN;
+	ret = i2c_smbus_read_i2c_block_data(client, reg, read_len,
+					    buf + RT5133_PREDATA_LEN);
+
+	if (ret < 0)
+		goto out_read_err;
+
+	if (ret != read_len) {
+		ret = -EIO;
+		goto out_read_err;
+	}
+
+	crc = crc8(priv->crc8_tbls, buf, RT5133_PREDATA_LEN + val_size, 0);
+	if (crc != buf[RT5133_PREDATA_LEN + val_size]) {
+		ret = -EIO;
+		goto out_read_err;
+	}
+
+	memcpy(val_buf, buf + RT5133_PREDATA_LEN, val_size);
+	dev_dbg(priv->dev, "%s, reg = 0x%02x, data = 0x%02x\n", __func__, reg, *(u8 *)val_buf);
+
+out_read_err:
+	kfree(buf);
+	return (ret < 0) ? ret : 0;
+}
+
+static int rt5133_regmap_hw_write(void *context, const void *data, size_t count)
+{
+	struct rt5133_priv *priv = context;
+	struct i2c_client *client = to_i2c_client(priv->dev);
+	u8 reg = *(u8 *)data, crc;
+	u8 *buf;
+	int buf_len = RT5133_I2C_ADDR_LEN + count + RT5133_I2C_CRC_LEN +
+		RT5133_I2C_DUMMY_LEN;
+	int write_len, ret;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = I2C_ADDR_XLATE_8BIT(client->addr, I2C_SMBUS_WRITE);
+	buf[1] = reg;
+	memcpy(buf + RT5133_PREDATA_LEN, data + RT5133_REG_ADDR_LEN,
+	       count - RT5133_REG_ADDR_LEN);
+
+	crc = crc8(priv->crc8_tbls, buf, RT5133_I2C_ADDR_LEN + count, 0);
+	buf[RT5133_I2C_ADDR_LEN + count] = crc;
+
+	write_len = count - RT5133_REG_ADDR_LEN + RT5133_I2C_CRC_LEN +
+		RT5133_I2C_DUMMY_LEN;
+	ret = i2c_smbus_write_i2c_block_data(client, reg, write_len,
+					     buf + RT5133_PREDATA_LEN);
+
+	dev_dbg(priv->dev, "%s, reg = 0x%02x, data = 0x%02x\n", __func__, reg,
+		*(u8 *)(buf + RT5133_PREDATA_LEN));
+	kfree(buf);
+	return ret;
+}
+
+static const struct regmap_bus rt5133_regmap_bus = {
+	.read = rt5133_regmap_hw_read,
+	.write = rt5133_regmap_hw_write,
+	/* Due to crc, the block read/write length has the limit */
+	.max_raw_read = RT5133_MAX_I2C_BLOCK_SIZE,
+	.max_raw_write = RT5133_MAX_I2C_BLOCK_SIZE,
+};
+
+static bool rt5133_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RT5133_REG_CHIP_INFO:
+	case RT5133_REG_BASE_EVT...RT5133_REG_LDO_PGB_STAT:
+	case RT5133_REG_LDO_ON...RT5133_REG_LDO_OFF:
+	case RT5133_REG_LDO1_CTRL1:
+	case RT5133_REG_LDO2_CTRL1:
+	case RT5133_REG_LDO3_CTRL1:
+	case RT5133_REG_LDO4_CTRL1:
+	case RT5133_REG_LDO5_CTRL1:
+	case RT5133_REG_LDO6_CTRL1:
+	case RT5133_REG_LDO7_CTRL1:
+	case RT5133_REG_LDO8_CTRL1:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static const struct regmap_config rt5133_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RT5133_REG_LDO8_CTRL4,
+	.cache_type = REGCACHE_FLAT,
+	.num_reg_defaults_raw = RT5133_REG_LDO8_CTRL4 + 1,
+	.volatile_reg = rt5133_is_volatile_reg,
+};
+
+static int rt5133_chip_reset(struct rt5133_priv *priv)
+{
+	int ret;
+
+	ret = regmap_write(priv->regmap, RT5133_REG_RST_CTRL,
+			   RT5133_RESET_CODE);
+	if (ret)
+		return ret;
+
+	/* Wait for register reset to take effect */
+	udelay(2);
+
+	return 0;
+}
+
+static int rt5133_validate_vendor_info(struct rt5133_priv *priv)
+{
+	unsigned int val = 0;
+	int i, ret;
+
+	ret = regmap_read(priv->regmap, RT5133_REG_CHIP_INFO, &val);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(regulator_data); i++) {
+		if ((val & RT5133_VENDOR_ID_MASK) ==
+						regulator_data[i].vendor_id){
+			priv->cdata = &regulator_data[i];
+			break;
+		}
+	}
+	if (IS_ERR(priv->cdata)) {
+		dev_err(priv->dev, "Failed to find regualtor match version\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int rt5133_probe(struct i2c_client *i2c)
+{
+	struct rt5133_priv *priv;
+	struct regulator_config config = {0};
+	int i, ret;
+
+	priv = devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &i2c->dev;
+	crc8_populate_msb(priv->crc8_tbls, RT5133_CRC8_POLYNOMIAL);
+
+	priv->enable_gpio = devm_gpiod_get_optional(&i2c->dev, "enable",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->enable_gpio))
+		dev_err(&i2c->dev, "Failed to request HWEN gpio, check if default en=high\n");
+
+	priv->regmap = devm_regmap_init(&i2c->dev, &rt5133_regmap_bus, priv,
+					&rt5133_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(&i2c->dev, "Failed to register regmap\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	ret = rt5133_validate_vendor_info(priv);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to check vendor info [%d]\n", ret);
+		return ret;
+	}
+
+	ret = rt5133_chip_reset(priv);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to execute sw reset\n");
+		return ret;
+	}
+
+	config.dev = &i2c->dev;
+	config.driver_data = priv;
+	config.regmap = priv->regmap;
+
+	for (i = 0; i < RT5133_REGULATOR_MAX; i++) {
+		priv->rdev[i] = devm_regulator_register(&i2c->dev,
+							priv->cdata->regulators + i,
+							&config);
+		if (IS_ERR(priv->rdev[i])) {
+			dev_err(&i2c->dev,
+				"Failed to register [%d] regulator\n", i);
+			return PTR_ERR(priv->rdev[i]);
+		}
+	}
+
+	priv->gc.label = dev_name(&i2c->dev);
+	priv->gc.parent = &i2c->dev;
+	priv->gc.base = -1;
+	priv->gc.ngpio = RT5133_GPIO_NR;
+	priv->gc.set = rt5133_gpio_set;
+	priv->gc.get = rt5133_gpio_get;
+	priv->gc.direction_output = rt5133_gpio_direction_output;
+	priv->gc.can_sleep = true;
+
+	ret = devm_gpiochip_add_data(&i2c->dev, &priv->gc, priv);
+	if (ret)
+		return ret;
+
+	ret = rt5133_enable_interrupts(i2c->irq, priv);
+	if (ret) {
+		dev_err(&i2c->dev, "enable interrupt failed\n");
+		return ret;
+	}
+
+	i2c_set_clientdata(i2c, priv);
+
+	return ret;
+}
+
+static const struct of_device_id __maybe_unused rt5133_of_match_table[] = {
+	{ .compatible = "richtek,rt5133", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt5133_of_match_table);
+
+static struct i2c_driver rt5133_driver = {
+	.driver = {
+		.name = "rt5133",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = rt5133_of_match_table,
+	},
+	.probe = rt5133_probe,
+};
+module_i2c_driver(rt5133_driver);
+
+MODULE_DESCRIPTION("RT5133 Regulator Driver");
+MODULE_LICENSE("GPL v2");
--
2.43.0


