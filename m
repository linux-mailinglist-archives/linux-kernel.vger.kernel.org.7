Return-Path: <linux-kernel+bounces-734891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A25BB087C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBDA3B38CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2824A043;
	Thu, 17 Jul 2025 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="Q9grM3H3"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2B35957
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740175; cv=none; b=uzgKgLDxEXeC7OICP7f4e7qwfGZI0aISfm5GuOgnodMadZwqKiePpNfCg/uQRXyo1jmNUJQy+CKKEfiben5Bgh3tY92LKF5JPMNYfquZDlnjmtlbWcA1x94gHrEqTziVsvAcxCxPXo5bbfwrqugewXNURzeoZFSZ+WzbqYxOT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740175; c=relaxed/simple;
	bh=aYdX+uR+eIEHP5ac77nSnAsdn3yGzU/i/nfzMEHfB5Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abm/VGWpoo64ed35SgZLD1gPs8z7TWHs4XU8br/t5/m3LW/QG1NmEhEE9pJugaVAB+oH1/rw44Ur0j/fKttWFjApamjSQliXbd89++xfV2ae3BIN04x/hKTX/7nHqErJxSQCZ+BUBhc6ackFm0f9DTaFJYUUxb1k2HDb2fmS0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=Q9grM3H3; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1752740163;
	bh=ltpsq3s9GI+f657+ddw4Jk2cWlGacgFw351fQspoHcM=; l=25289;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Q9grM3H34g+jLj+D2GFU2bhgYIbr4p26NkGx7RngF7ATUiSaX4Brvplvbb4Ud0e8S
	 rQK5z+M7aymrT6QLXIJnjcX84jiaVtAgK8z847Pz5LwS1I9do9lXeeCgtlRhao4vbm
	 9hLAjs4cCIN7AiGnzPEc2adZeMHBooc9I4KjYZwoGNw8qMGx93zp0SY3SM6PeW9g4G
	 VhfAR6QaXa05mSffL3fkBNdWiRplw8wa1oljWfT7Ylozd28Q/cd60YeL2Asj1ogugg
	 D0iDImvrqJt9cxO57hRsjowkHNVSQa6ECrusGBoBQonVU4lhp3ftCYtDCN45n+xXVn
	 TeGnLU2/37GTg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244587:0:AUTH_RELAY)
	(envelope-from <jeff_chang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 17 Jul 2025 16:15:48 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Jul
 2025 16:15:48 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Thu, 17 Jul 2025 16:15:48 +0800
From: <jeff_chang@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jeff_chang@richtek.com>
Subject: [PATCH] regulator: rt5133: Add RT5133 PMIC regulator Support
Date: Thu, 17 Jul 2025 16:16:01 +0800
Message-ID: <20250717081623.2674579-1-jeff_chang@richtek.com>
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

RT5133 is an intefrated chip. It includes 8 LDOs and 3 GPOs that
can be used to drive output high/low purpose. The dependency of the
GPO block is internally LDO1 Voltage. If LDO1 voltage output disabled,
GPO cannot be used to drive output high. It need to pay more attention
on the usage.

Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
---
 .../bindings/regulator/richtek,rt5133.yaml    | 164 +++++
 drivers/regulator/Kconfig                     |  13 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/rt5133-regulator.c          | 636 ++++++++++++++++++
 4 files changed, 814 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
 create mode 100644 drivers/regulator/rt5133-regulator.c

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
new file mode 100644
index 000000000000..e8091f2bedb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: GPL-6.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt5133.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5133 PMIC Regulator
+
+maintainers:
+  - ShihChia Chang <jeff_chang@richtek.com>
+
+description: |
+  RT5133 is an intefrated chip. It includes 8 LDOs and 3 GPOs that can be
+  used to drive output high/low purpose. The dependency of the GPO block
+  is internally LDO1 Voltage. If LDO1 voltage output disabled, GPO cannot
+  be used to drive output high. It need to pay more attention on the usage.
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt5133
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: A connection of the 'enable' gpio line.
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  regulators:
+    type: object
+
+  oc-shutdown-all:
+    type: object
+    description: |
+      Anyone of LDO OC state
+        0: LDO OC only shut down itself
+        1: LDO OC shut down all channels
+
+  pgb-shutdown-all:
+    type: object
+    description: |
+      Anyone of PGB OC state
+        0: LDO PGB only shut down itself
+        1: LDO PGB shut down all channels
+
+  soft-start-time-sel:
+    type: object
+    description: |
+      soft-start time of LDO
+        0: 1ms
+        1: 2ms
+        2: 4ms
+        3: 8ms
+
+  rt5133-ldo1-supply:
+    description: |
+      Only for LDO7 LDO8, pvin7 and pvin8 reference design are RT5133 LDO1.
+      If not connect to LDO1 vout, this property for pvin7 and pvin8 is necessary.
+    
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+  - wakeup-source
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt5133: rt5133@18 {
+        status = "ok";
+        compatible = "richtek,rt5133";
+        reg = <0x18>;
+        wakeup-source;
+        interrupts-extended = <&pio 187 0x0>;
+        enable-gpios = <&pio 186 0x0>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        regulators {
+          BASE {
+            regulator-name = "rt5133,base";
+            oc-shutdown-all = <0>;
+            pgb-shutdown-all = <0>;
+          };
+          rt5133_ldo1: LDO1 {
+            regulator-name = "rt5133-ldo1";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3199998>;
+            regulator-active-discharge;
+            soft-start-time-sel = <1>;
+          };
+          rt5133_ldo2: LDO2 {
+            regulator-name = "rt5133-ldo2";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3200000>;
+            regulator-active-discharge;
+            soft-start-time-sel = <1>;
+          };
+          rt5133_ldo3: LDO3 {
+            regulator-name = "rt5133-ldo3";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge;
+            soft-start-time-sel = <1>;
+          };
+          rt5133_ldo4: LDO4 {
+            regulator-name = "rt5133-ldo4";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge;
+            soft-start-time-sel = <1>;
+          };
+          rt5133_ldo5: LDO5 {
+            regulator-name = "rt5133-ldo5";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge;
+            soft-start-time-sel = <1>;
+          };
+          rt5133_ldo6: LDO6 {
+            regulator-name = "rt5133-ldo6";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge;
+            soft-start-time-sel = <1>;
+          };
+          rt5133_ldo7: LDO7 {
+            regulator-name = "rt5133-ldo7";
+            regulator-min-microvolt = <900000>;
+            regulator-max-microvolt = <1200000>;
+            regulator-active-discharge;
+            soft-start-time-sel = <1>;
+            rt5133-ldo1-supply = <&rt5133_ldo1>;
+          };
+          rt5133_ldo8: LDO8 {
+            regulator-name = "rt5133-ldo8";
+            regulator-min-microvolt = <855000>;
+            regulator-max-microvolt = <1200000>;
+            regulator-active-discharge;
+            soft-start-time-sel = <1>;
+            rt5133-ldo1-supply = <&rt5133_ldo1>;
+          };
+        };
+      };
+    };
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 6d8988387da4..d5a0e422772d 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1229,6 +1229,19 @@ config REGULATOR_RT5120
 	  600mV to 1395mV, per step 6.250mV. The others are all fixed voltage
 	  by external hardware circuit.
 
+config REGULATOR_RT5133
+	tristate "Richtek RT5133 PMIC Regulators"
+	depends on I2C && GPIOLIB
+	select REGMAP
+	select CRC8
+	select OF_GPIO
+	help
+	  RT5133 is an intefrated chip. It includes 8 LDOs and 3 GPOs that
+	  can be used to drive output high/low purpose. The dependency of the
+	  GPO block is internally LDO-1 Voltage. If LDO1 voltage output disabled,
+	  GPO cannot be used to drive output high. It need to pay more attention
+	  on the usage.
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
index 000000000000..c6e6f6f01e1f
--- /dev/null
+++ b/drivers/regulator/rt5133-regulator.c
@@ -0,0 +1,636 @@
+// SPDX-License-Identifier: GPL-4.0
+/*
+ * Copyright (C) 2025 Richtek Technology Corp.
+ *
+ * Author: ChiYuan Huang <cy_huang@richtek.com>
+ */
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
+static bool dbg_log_en;
+module_param(dbg_log_en, bool, 0644);
+#define rt_dbg(dev, fmt, ...)	\
+	do { \
+		if (dbg_log_en) \
+			dev_info(dev, "%s " fmt, __func__, ##__VA_ARGS__); \
+	} while (0)
+#define RT5133_DRV_VERSION		"1.0.2_MTK"
+
+#define RT5133_REG_CHIP_INFO		0x00
+#define RT5133_REG_RST_CTRL		0x06
+#define RT5133_REG_BASE_CTRL		0x09
+#define RT5133_REG_GPIO_CTRL		0x0B
+#define RT5133_REG_BASE_EVT		0x10
+#define RT5133_REG_BASE_MASK		0x16
+#define RT5133_REG_LDO_SHDN		0x19
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
+#define RT5133_PGBSHDN_ALL_MASK		BIT(6)
+
+#define RT5133_OCPTSEL_MASK		BIT(5)
+#define RT5133_PGBPTSEL_MASK		BIT(4)
+#define RT5133_STBTDSEL_MASK		GENMASK(1, 0)
+
+#define RT5133_LDO_ENABLE_MASK		BIT(7)
+#define RT5133_LDO_VSEL_MASK		GENMASK(7, 5)
+#define RT5133_LDO_AD_MASK		BIT(2)
+
+#define RT5133_GPIO_NR			3
+#define RT5133_GPIOEN_MASK(_id)		(BIT(7 - (_id)) | BIT(3 - (_id)))
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
+	unsigned int base_addr = 0;
+
+	const struct {
+		const char *prop_name;
+		unsigned int min;
+		unsigned int max;
+		unsigned int def_val;
+		unsigned int addr_offset;
+		unsigned int mask;
+	} base_props[] = {
+		{ "oc-shutdown-all", 0, 1, 0,
+			RT5133_REG_LDO_SHDN, RT5133_OCSHDN_ALL_MASK },
+		{ "pgb-shutdown-all", 0, 1, 0,
+			RT5133_REG_LDO_SHDN, RT5133_PGBSHDN_ALL_MASK }
+	}, ldo_props[] = {
+		{ "soft-start-time-sel", 0, 3, 1, 0, RT5133_STBTDSEL_MASK }
+	}, *props;
+	int i, props_size;
+
+	if (desc->id == RT5133_REGULATOR_BASE) {
+		props = base_props;
+		props_size = ARRAY_SIZE(base_props);
+	} else {
+		props = ldo_props;
+		props_size = ARRAY_SIZE(ldo_props);
+		base_addr = RT5133_LDO_REG_BASE(desc->id);
+	}
+
+	for (i = 0; i < props_size; i++) {
+		int shift = ffs(props[i].mask) - 1, ret;
+		unsigned int val;
+
+		ret = of_property_read_u32(node, props[i].prop_name, &val);
+		if (ret)
+			val = props[i].def_val;
+
+		if (val > props[i].max)
+			val = props[i].max;
+
+		ret = regmap_update_bits(priv->regmap,
+					 base_addr + props[i].addr_offset,
+					 props[i].mask, val << shift);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+#define RT5133_REGULATOR_DESC(_name, vtables, _supply) \
+{\
+	.name = #_name,\
+	.id = RT5133_REGULATOR_##_name,\
+	.of_match = of_match_ptr(#_name),\
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
+		.of_match = of_match_ptr("BASE"),
+		.regulators_node = of_match_ptr("regulators"),
+		.of_parse_cb = rt5133_of_parse_cb,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.ops = &rt5133_base_regulator_ops,
+		.enable_reg = RT5133_REG_BASE_CTRL,
+		.enable_mask = RT5133_FOFF_BASE_MASK,
+		.enable_is_inverted = true,
+	},
+	RT5133_REGULATOR_DESC(LDO1, vout_type1_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO2, vout_type1_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO3, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO4, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO5, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO6, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO7, vout_type3_tables, "rt5133-ldo1"),
+	RT5133_REGULATOR_DESC(LDO8, vout_type3_tables, "rt5133-ldo1"),
+};
+
+static const struct regulator_desc rt5133a_regulators[] = {
+	/* For digital part, base current control */
+	{
+		.name = "rt5133,base",
+		.id = RT5133_REGULATOR_BASE,
+		.of_match = of_match_ptr("BASE"),
+		.regulators_node = of_match_ptr("regulators"),
+		.of_parse_cb = rt5133_of_parse_cb,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.ops = &rt5133_base_regulator_ops,
+		.enable_reg = RT5133_REG_BASE_CTRL,
+		.enable_mask = RT5133_FOFF_BASE_MASK,
+		.enable_is_inverted = true,
+	},
+	RT5133_REGULATOR_DESC(LDO1, vout_type1_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO2, vout_type1_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO3, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO4, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO5, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO6, vout_type2_tables, "rt5133,base"),
+	RT5133_REGULATOR_DESC(LDO7, vout_type3_tables, "rt5133-ldo1"),
+	RT5133_REGULATOR_DESC(LDO8, vout_type4_tables, "rt5133-ldo1"),
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
+	return regmap_update_bits(priv->regmap, RT5133_REG_GPIO_CTRL,
+				  BIT(7-offset)|BIT(3-offset),
+				  value ? BIT(7-offset)|BIT(3-offset) : 0);
+}
+
+static int rt5133_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct rt5133_priv *priv = gpiochip_get_data(chip);
+
+	return !!(priv->gpio_output_flag & BIT(offset));
+}
+
+static void rt5133_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			    int set_val)
+{
+	struct rt5133_priv *priv = gpiochip_get_data(chip);
+	unsigned int mask = RT5133_GPIOEN_MASK(offset);
+	unsigned int val = set_val ? mask : 0;
+	unsigned int next_flag = priv->gpio_output_flag;
+	int ret;
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
+	if (ret)
+		goto out_intr_handler;
+
+	handle_evts = intr_evts & RT5133_BASE_EVT_MASK;
+	/*
+	 * VREF_EVT is a special case, if base off
+	 * this event will also be trigger. Skip it
+	 */
+	if (handle_evts & ~RT5133_VREF_EVT_MASK)
+		dev_info(priv->dev, "base event occurred [0x%02x]\n",
+			 handle_evts);
+
+	handle_evts = (intr_evts & RT5133_LDO_OC_EVT_MASK) >>
+		RT5133_LDO_OC_EVT_SHIFT;
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
+		goto out_intr_handler;
+
+	return IRQ_HANDLED;
+
+out_intr_handler:
+	return IRQ_NONE;
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
+	else if (ret != read_len) {
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
+	rt_dbg(priv->dev, "reg = 0x%02x, data = 0x%02x\n", reg, *(u8 *)val_buf);
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
+	rt_dbg(priv->dev, "reg = 0x%02x, data = 0x%02x\n", reg,
+	       *(u8 *)(buf + RT5133_PREDATA_LEN));
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
+static const struct regmap_config rt5133_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RT5133_REG_LDO8_CTRL4,
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
+	dev_info(&i2c->dev, "%s start(%s)\n", __func__, RT5133_DRV_VERSION);
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
+						priv->cdata->regulators + i,
+						&config);
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
+static const struct of_device_id __maybe_unused rt5133_ofid_tbls[] = {
+	{ .compatible = "richtek,rt5133", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt5133_ofid_tbls);
+
+static struct i2c_driver rt5133_driver = {
+	.driver = {
+		.name = "rt5133",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(rt5133_ofid_tbls),
+	},
+	.probe = rt5133_probe,
+};
+module_i2c_driver(rt5133_driver);
+
+MODULE_DESCRIPTION("RT5133 Regulator Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(RT5133_DRV_VERSION);
-- 
2.43.0


