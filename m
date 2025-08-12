Return-Path: <linux-kernel+bounces-763923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA96BB21BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B8A189C5C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AA22D5C91;
	Tue, 12 Aug 2025 03:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="SsVZ7LSI";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="oVVZsHtL"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D52335C7;
	Tue, 12 Aug 2025 03:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754969102; cv=none; b=YHO5c1bfwc1ZQJsDYn44MPtuEHe3WY0AAcjMVt2mDiPTUB6AXk9YpyX1KX82QpNCmP7R0ki/ku7Xys+QtKRXn4Cp8x/cbH4St30cr3SL9qxpIJFXg0NErwoRF3xJCzVOVTvyyvQWZfy4EAG18lSYZfUldrMQSxJx8uNSnlYfogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754969102; c=relaxed/simple;
	bh=bx30k92PAHM8pxZwJLGjo1c/sR+c9cNdMVWrUvEY+9E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oY5NnvUjvAjpcaqB0WMtG7q7k+CDQDWNfqDbq0p5OwtYHK8T+64Yp3P7QUIXVcuI09QGP/ypftLNhd7dyTtULa/jmv/izm1IsqxUvJpcIK9skIrrnECVlg/CB+eA09ZJVhpE/Cy7Skw0vRxYoDONOrm72v0fdJZjKnM4Ekn7H+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=SsVZ7LSI; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=oVVZsHtL; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1754969096;
	bh=zcr92Hm+ZT6QesmFK/klnHPQZuVNuZyIehfGxgysMKA=; l=22218;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SsVZ7LSIrZoz6EmkctMA6cG6p+/LqOrV7eBZbR2lxUMoZG/KEe7RremjhscBs2bsj
	 XXju2JLbLUnYOigor/CF54dpF1SiJ4w9A92nQCeXcmlyobLrSk11zuokt6C8lTcEHl
	 kUtskrDLaAP/AycfoRKKSUmpEvZ8vuOApfsYOYIWRtLlKWjF7IB3kzH415h6hjT8tQ
	 XxwQaYx3VJhm89GTb8QmyqRYOAH7vhr6SIG073U3mHpZSnRNT+QxiKVbVlAe4djM3d
	 ok2urrcfZUN2N5SBu2MRrFx8qWGJItOsUyEKOsTwXBp8O0XI0OBru5laVEmPiZEvG5
	 Fcke0uOvdyytw==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(1128084:0:AUTH_RELAY)
	(envelope-from <prvs=1317C84BB3=jeff_chang@richtek.com>); Tue, 12 Aug 2025 11:24:54 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1754969094;
	bh=zcr92Hm+ZT6QesmFK/klnHPQZuVNuZyIehfGxgysMKA=; l=22218;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oVVZsHtLOpOZ5E1Bazg1pesq5N2bmIy3IyDPIkFm6s1t02UruPHR/A9WO3RvvsIZt
	 kwOGQjH8EQQyz4Fq02R+1JbtPzgsomm4RMc2tIQppX2Vb0hb8MzI9EoJ7ZFkacgs2h
	 hJR7DOyPBvxJkq4Am901wR4PxCRQnEDgFMCU6WT5Jfu2bD/6C1Osc6IjhNo5EY3qzR
	 hndKgLeABkp4U/5f/TefUOGkOKRSez1yJfmTr4OHUntOaLa6lERo/y2QQ42AelveO2
	 jLlhqycb8CK/LAAEUA3HM9lQhglNhSJkyvhyewDU9j6680H9Gj8bT7uPAEs8ARo8AO
	 nYWtkXaGlnK8g==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(817437:0:AUTH_RELAY)
	(envelope-from <jeff_chang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 12 Aug 2025 11:14:52 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 12 Aug
 2025 11:14:51 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 12 Aug 2025 11:14:51 +0800
From: <jeff_chang@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <jeff_chang@richtek.com>
Subject: [PATCH v7 2/2] regulator: rt5133: Add RT5133 PMIC regulator Support
Date: Tue, 12 Aug 2025 11:14:56 +0800
Message-ID: <20250812031541.2966667-1-jeff_chang@richtek.com>
X-Mailer: git-send-email 2.43.5
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

Changes in v7:
1. Fix function pointer type for gpio set
2. Patch 1 (YAML bindings) remains unchanged from v6 and has already been reviewed.

Changes in v6:
1. Rename rt5133,base -> base

Changes in v5:
1. Move oc-shutdown-all, pgb-shutdown-all properties to chip layer. Remove
   of_parse_cb of regulators_desc.
2. Using vin as LDO7's and LDO8's supply_name.

Changes in v4:
1. Re-order patches. DT patch before driver patch.
2. Return IRQ_NONE if rt5133_intr_handler handle nothing.
3. Using cache for regmap_config.
4. Add prefix for vendor property richtek,oc-shutdown-all and
   richtek,pgb-shutdown-all.
5. Add _node_name to RT5133_REGULATOR_DESC for lowercase regulator node.

Changes in v3:
1. Fix typo intefrated -> integrated
2. Remove yaml file
3. Remove soft-start-time-sel property
4. Remove GPL-4.0, using GPL-2.0
5. Using C++ comment
6. Using standard dev_dbg
7. Remove driver version
8. Using dev_dbg for base event occurred. And return IRQ_HANDLED
9. Because of CRC8 for IO, we don't use cache for regmap_config
10. Remove tracing logs.
11. Set can_sleep = true for gpio operations.
12. Kconfig add depends on OF

 drivers/regulator/Kconfig            |  12 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/rt5133-regulator.c | 642 +++++++++++++++++++++++++++
 3 files changed, 655 insertions(+)
 create mode 100644 drivers/regulator/rt5133-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index eaa6df1c9f80..280f67558cda 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1240,6 +1240,18 @@ config REGULATOR_RT5120
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
index be98b29d6675..3b6505350a3a 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -146,6 +146,7 @@ obj-$(CONFIG_REGULATOR_RT4803)	+= rt4803.o
 obj-$(CONFIG_REGULATOR_RT4831)	+= rt4831-regulator.o
 obj-$(CONFIG_REGULATOR_RT5033)	+= rt5033-regulator.o
 obj-$(CONFIG_REGULATOR_RT5120)	+= rt5120-regulator.o
+obj-$(CONFIG_REGULATOR_RT5133)	+= rt5133-regulator.o
 obj-$(CONFIG_REGULATOR_RT5190A) += rt5190a-regulator.o
 obj-$(CONFIG_REGULATOR_RT5739)	+= rt5739.o
 obj-$(CONFIG_REGULATOR_RT5759)	+= rt5759-regulator.o
diff --git a/drivers/regulator/rt5133-regulator.c b/drivers/regulator/rt5133-regulator.c
new file mode 100644
index 000000000000..d0f367381fbb
--- /dev/null
+++ b/drivers/regulator/rt5133-regulator.c
@@ -0,0 +1,642 @@
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
+#define RT5133_REGULATOR_DESC(_name, _node_name, vtables, _supply) \
+{\
+	.name = #_name,\
+	.id = RT5133_REGULATOR_##_name,\
+	.of_match = of_match_ptr(#_node_name),\
+	.regulators_node = of_match_ptr("regulators"),\
+	.supply_name = _supply,\
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
+		.name = "base",
+		.id = RT5133_REGULATOR_BASE,
+		.of_match = of_match_ptr("base"),
+		.regulators_node = of_match_ptr("regulators"),
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.ops = &rt5133_base_regulator_ops,
+		.enable_reg = RT5133_REG_BASE_CTRL,
+		.enable_mask = RT5133_FOFF_BASE_MASK,
+		.enable_is_inverted = true,
+	},
+	RT5133_REGULATOR_DESC(LDO1, ldo1, vout_type1_tables, "base"),
+	RT5133_REGULATOR_DESC(LDO2, ldo2, vout_type1_tables, "base"),
+	RT5133_REGULATOR_DESC(LDO3, ldo3, vout_type2_tables, "base"),
+	RT5133_REGULATOR_DESC(LDO4, ldo4, vout_type2_tables, "base"),
+	RT5133_REGULATOR_DESC(LDO5, ldo5, vout_type2_tables, "base"),
+	RT5133_REGULATOR_DESC(LDO6, ldo6, vout_type2_tables, "base"),
+	RT5133_REGULATOR_DESC(LDO7, ldo7, vout_type3_tables, "vin"),
+	RT5133_REGULATOR_DESC(LDO8, ldo8, vout_type3_tables, "vin"),
+};
+
+static const struct regulator_desc rt5133a_regulators[] = {
+	/* For digital part, base current control */
+	{
+		.name = "base",
+		.id = RT5133_REGULATOR_BASE,
+		.of_match = of_match_ptr("base"),
+		.regulators_node = of_match_ptr("regulators"),
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.ops = &rt5133_base_regulator_ops,
+		.enable_reg = RT5133_REG_BASE_CTRL,
+		.enable_mask = RT5133_FOFF_BASE_MASK,
+		.enable_is_inverted = true,
+	},
+	RT5133_REGULATOR_DESC(LDO1, ldo1, vout_type1_tables, "base"),
+	RT5133_REGULATOR_DESC(LDO2, ldo2, vout_type1_tables, "base"),
+	RT5133_REGULATOR_DESC(LDO3, ldo3, vout_type2_tables, "base"),
+	RT5133_REGULATOR_DESC(LDO4, ldo4, vout_type2_tables, "base"),
+	RT5133_REGULATOR_DESC(LDO5, ldo5, vout_type2_tables, "base"),
+	RT5133_REGULATOR_DESC(LDO6, ldo6, vout_type2_tables, "base"),
+	RT5133_REGULATOR_DESC(LDO7, ldo7, vout_type3_tables, "vin"),
+	RT5133_REGULATOR_DESC(LDO8, ldo8, vout_type4_tables, "vin"),
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
+static int rt5133_gpio_set(struct gpio_chip *chip, unsigned int offset, int set_val)
+{
+	struct rt5133_priv *priv = gpiochip_get_data(chip);
+	unsigned int mask = 0, val = 0, next_flag = priv->gpio_output_flag;
+	int ret = 0;
+
+	ret = rt5133_get_gpioen_mask(offset, &mask);
+	if (ret) {
+		dev_err(priv->dev, "%s get gpion en mask failed, offset(%d)\n", __func__, offset);
+		return ret;
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
+		return ret;
+	}
+
+	priv->gpio_output_flag = next_flag;
+	return 0;
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
+static int rt5133_parse_dt(struct rt5133_priv *priv)
+{
+	unsigned int val = 0;
+	int ret = 0;
+
+	if (!device_property_read_bool(priv->dev, "richtek,oc-shutdown-all"))
+		val = 0;
+	else
+		val = 1 << RT5133_OCSHDN_ALL_SHIFT;
+	ret = regmap_update_bits(priv->regmap, RT5133_REG_LDO_SHDN,
+				 RT5133_OCSHDN_ALL_MASK, val);
+	if (ret)
+		return ret;
+
+	if (!device_property_read_bool(priv->dev, "richtek,pgb-shutdown-all"))
+		val = 0;
+	else
+		val = 1 << RT5133_PGBSHDN_ALL_SHIFT;
+	return regmap_update_bits(priv->regmap, RT5133_REG_LDO_SHDN,
+				  RT5133_PGBSHDN_ALL_MASK, val);
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
+	ret = rt5133_parse_dt(priv);
+	if (ret) {
+		dev_err(&i2c->dev, "%s, Failed to parse dt\n", __func__);
+		return ret;
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


