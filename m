Return-Path: <linux-kernel+bounces-592982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC42A7F396
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 06:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B65A3B13A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 04:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D861925F990;
	Tue,  8 Apr 2025 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ThR4RL+E"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C524C09B;
	Tue,  8 Apr 2025 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744086388; cv=none; b=p+MsIsBu9czUqm/gBUXR+ioqoCVLI/m0fuMgC+5wHTwgNVCFJGmbKnjkdVEUQbI/GURObxeqtGzkPKxtq0HJvEWgkrHATtql6uUXzWrogFk6U4bEa6plrOJI1zwxSCp5mfXlGdub1w61aMs7CKKN1TfSKbWWAjEqQKV27NoBT3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744086388; c=relaxed/simple;
	bh=G5F1L1BdTSmuacNHANAgIlR40oYMYJpYvCJzjGRBUyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OcOq5IveidgBDBYkeQ+hDBKeFtdR47Ulx+4k2kfUNhS/l+46Ykr7hK24WcdG1NFLnTHWntFfQDvP14SwFsTDVKXWcKi5vX/uoSWtpiOLYY5DBTRBSW8zQcr0jupyMuSmdRd2bd/lhC5AzpUxIAoc9gzdNa4y6Dsx2xi4Q+Iv9YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ThR4RL+E; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5383Et3e019577;
	Tue, 8 Apr 2025 00:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oKXSo
	u2Lww9VOcbsFPVUhPMQOZWpvLuEelox47vT0WA=; b=ThR4RL+EZkx46vNNPHQNm
	B3pDIsXlLjcssOVhVUf3dR+4RK2uwebRK9hZOWLR5Mtg4Pa6DET/48jdlq7vj3WS
	b0zpUzdgH5fHIEocpkuPDs97As/zmmBEgomF1zSIzNvDOd+4ATiymSLTTg67RykG
	0nmUMIQJRTm3HN/WEaorpug+biaNKkh9+QCL+cqcPFqORMNnQFjsxjRy301L3Ibh
	RcO9QUxsdVtK9PSNON3l+BX7pR+6E4aLLNYo0LttJzCxThcTNJXgWTXDkjFllFlh
	OJB4Pa2FBvkt9O0sizBSeQxT9EtDjdZobKCxoZFo4/b0mlaHz4LbI4keZkrzg23L
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45txc5ws6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 00:26:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5384QDdu061720
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 8 Apr 2025 00:26:13 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 8 Apr 2025 00:26:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 8 Apr 2025 00:26:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 8 Apr 2025 00:26:13 -0400
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.116.44.203])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5384Pr6Y013648;
	Tue, 8 Apr 2025 00:26:07 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Tue, 8 Apr 2025 12:25:49 +0800
Subject: [PATCH v5 2/2] regulator: adp5055: Add driver for adp5055
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250408-upstream-adp5055-v5-2-dc58d98a7a3d@analog.com>
References: <20250408-upstream-adp5055-v5-0-dc58d98a7a3d@analog.com>
In-Reply-To: <20250408-upstream-adp5055-v5-0-dc58d98a7a3d@analog.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "Alexis
 Czezar Torreno" <alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744086354; l=15505;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=G5F1L1BdTSmuacNHANAgIlR40oYMYJpYvCJzjGRBUyk=;
 b=k+T4LzJEppEWPuWFMjUJbnAEe0jECXas/VqCSz0vcbEohNmUdh39rFT6EgUzljOMHQyKD2LPh
 Pf8ZmgxSlrfDWnp4DGgZpwyjadTxpiPDZkYJdjyD6yUXLPd+OXnpuyY
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: bGE7ZzNPCCKvJ9trr1DBf0rs_MDfMAge
X-Proofpoint-ORIG-GUID: bGE7ZzNPCCKvJ9trr1DBf0rs_MDfMAge
X-Authority-Analysis: v=2.4 cv=KePSsRYD c=1 sm=1 tr=0 ts=67f4a567 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=AjDMckhpbq5XJRiZVbAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_01,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080030

Add ADI ADP5055 driver support. The device consists
of 3 buck regulators able to connect to high input voltages of up to 18V
with no preregulators.

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
 MAINTAINERS                           |   1 +
 drivers/regulator/Kconfig             |  11 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/adp5055-regulator.c | 432 ++++++++++++++++++++++++++++++++++
 4 files changed, 445 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2ec43f84d84765c319d8403fb5650afa273db83..7ac35d895b4c8297c6de70cd2bfaec516ff5b100 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1530,6 +1530,7 @@ M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.yaml
+F:	drivers/regulator/adp5055-regulator.c
 
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 39297f7d8177193e51c99bc2b360c6d9936e62fe..4c08cf755d88e5f5bc6431192fad5f27786caea8 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -122,6 +122,17 @@ config REGULATOR_AD5398
 	  This driver supports AD5398 and AD5821 current regulator chips.
 	  If building into module, its name is ad5398.ko.
 
+config REGULATOR_ADP5055
+	tristate "Analog Devices ADP5055 Triple Buck Regulator"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver controls an Analog Devices ADP5055 with triple buck
+	  regulators using an I2C interface.
+
+	  Say M here if you want to include support for the regulator as a
+	  module.
+
 config REGULATOR_ANATOP
 	tristate "Freescale i.MX on-chip ANATOP LDO regulators"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 3d5a803dce8a0556ba9557fa069c6e37593b3c69..71f45d9317d24e7081ac919eb31efff6652edf3f 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_REGULATOR_AB8500)	+= ab8500-ext.o ab8500.o
 obj-$(CONFIG_REGULATOR_ACT8865) += act8865-regulator.o
 obj-$(CONFIG_REGULATOR_ACT8945A) += act8945a-regulator.o
 obj-$(CONFIG_REGULATOR_AD5398) += ad5398.o
+obj-$(CONFIG_REGULATOR_ADP5055) += adp5055-regulator.o
 obj-$(CONFIG_REGULATOR_ANATOP) += anatop-regulator.o
 obj-$(CONFIG_REGULATOR_ARIZONA_LDO1) += arizona-ldo1.o
 obj-$(CONFIG_REGULATOR_ARIZONA_MICSUPP) += arizona-micsupp.o
diff --git a/drivers/regulator/adp5055-regulator.c b/drivers/regulator/adp5055-regulator.c
new file mode 100644
index 0000000000000000000000000000000000000000..8505fd456b427c2dc034ed63cc1b16878f320683
--- /dev/null
+++ b/drivers/regulator/adp5055-regulator.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Regulator driver for Analog Devices ADP5055
+//
+// Copyright (C) 2025 Analog Devices, Inc.
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+// ADP5055 Register Map.
+
+#define ADP5055_CTRL123         0xD1
+#define ADP5055_CTRL_MODE1      0xD3
+#define ADP5055_CTRL_MODE2      0xD4
+#define ADP5055_DLY0            0xD5
+#define ADP5055_DLY1            0xD6
+#define ADP5055_DLY2            0xD7
+#define ADP5055_VID0            0xD8
+#define ADP5055_VID1            0xD9
+#define ADP5055_VID2            0xDA
+#define ADP5055_DVS_LIM0        0xDC
+#define ADP5055_DVS_LIM1        0xDD
+#define ADP5055_DVS_LIM2        0xDE
+#define ADP5055_FT_CFG          0xDF
+#define ADP5055_PG_CFG          0xE0
+
+// ADP5055 Field Masks.
+
+#define	ADP5055_MASK_EN_MODE		BIT(0)
+#define	ADP5055_MASK_OCP_BLANKING	BIT(7)
+#define	ADP5055_MASK_PSM		BIT(4)
+#define	ADP5055_MASK_DIS2		BIT(2)
+#define	ADP5055_MASK_DIS1		BIT(1)
+#define	ADP5055_MASK_DIS0		BIT(0)
+#define	ADP5055_MASK_DIS_DLY		GENMASK(6, 4)
+#define	ADP5055_MASK_EN_DLY		GENMASK(2, 0)
+#define	ADP5055_MASK_DVS_LIM_UPPER	GENMASK(7, 4)
+#define	ADP5055_MASK_DVS_LIM_LOWER	GENMASK(3, 0)
+#define	ADP5055_MASK_FAST_TRANSIENT2	GENMASK(5, 4)
+#define	ADP5055_MASK_FAST_TRANSIENT1	GENMASK(3, 2)
+#define	ADP5055_MASK_FAST_TRANSIENT0	GENMASK(1, 0)
+#define	ADP5055_MASK_DLY_PWRGD		BIT(4)
+#define	ADP5055_MASK_PWRGD2		BIT(2)
+#define	ADP5055_MASK_PWRGD1		BIT(1)
+#define	ADP5055_MASK_PWRGD0		BIT(0)
+
+#define	ADP5055_MIN_VOUT		408000
+#define ADP5055_NUM_CH			3
+
+struct adp5055 {
+	struct device *dev;
+	struct regmap *regmap;
+	u32 tset;
+	struct gpio_desc *en_gpiod[ADP5055_NUM_CH];
+	bool en_mode_software;
+	int dvs_limit_upper[ADP5055_NUM_CH];
+	int dvs_limit_lower[ADP5055_NUM_CH];
+	u32 fast_transient[ADP5055_NUM_CH];
+	bool mask_power_good[ADP5055_NUM_CH];
+};
+
+static const unsigned int adp5055_tset_vals[] = {
+	2600,
+	20800,
+};
+
+static const unsigned int adp5055_enable_delay_vals_2_6[] = {
+	0,
+	2600,
+	5200,
+	7800,
+	10400,
+	13000,
+	15600,
+	18200,
+};
+
+static const unsigned int adp5055_enable_delay_vals_20_8[] = {
+	0,
+	20800,
+	41600,
+	62400,
+	83200,
+	104000,
+	124800,
+	145600,
+};
+
+static const char * const adp5055_fast_transient_vals[] = {
+	"none",
+	"3G_1.5%",
+	"5G_1.5%",
+	"5G_2.5%",
+};
+
+static int adp5055_get_prop_index(const u32 *table, size_t table_size,
+				  u32 value)
+{
+	int i;
+
+	for (i = 0; i < table_size; i++)
+		if (table[i] == value)
+			return i;
+
+	return -EINVAL;
+}
+
+static const struct regmap_range adp5055_reg_ranges[] = {
+	regmap_reg_range(0xD1, 0xE0),
+};
+
+static const struct regmap_access_table adp5055_access_ranges_table = {
+	.yes_ranges	= adp5055_reg_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(adp5055_reg_ranges),
+};
+
+static const struct regmap_config adp5055_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xE0,
+	.wr_table = &adp5055_access_ranges_table,
+	.rd_table = &adp5055_access_ranges_table,
+};
+
+static const struct linear_range adp5055_voltage_ranges[] = {
+	REGULATOR_LINEAR_RANGE(ADP5055_MIN_VOUT, 0, 255, 1500),
+};
+
+static int adp5055_parse_fw(struct device *dev, struct  adp5055 *adp5055)
+{
+	int i, ret;
+	struct regmap *regmap = adp5055->regmap;
+	int val;
+	bool ocp_blanking;
+	bool delay_power_good;
+
+	ret = device_property_read_u32(dev, "adi,tset-us", &adp5055->tset);
+	if (!ret) {
+		ret = adp5055_get_prop_index(adp5055_tset_vals,
+					ARRAY_SIZE(adp5055_tset_vals), adp5055->tset);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+				"Failed to initialize tset.");
+		adp5055->tset = adp5055_tset_vals[ret];
+	}
+
+	ocp_blanking = device_property_read_bool(dev, "adi,ocp-blanking");
+
+	delay_power_good = device_property_read_bool(dev,
+				    "adi,delay-power-good");
+
+	for (i = 0; i < ADP5055_NUM_CH; i++) {
+		val = FIELD_PREP(ADP5055_MASK_DVS_LIM_UPPER,
+				DIV_ROUND_CLOSEST_ULL(192000 - adp5055->dvs_limit_upper[i], 12000));
+		val |= FIELD_PREP(ADP5055_MASK_DVS_LIM_LOWER,
+				DIV_ROUND_CLOSEST_ULL(adp5055->dvs_limit_lower[i] + 190500, 12000));
+		ret = regmap_write(regmap, ADP5055_DVS_LIM0 + i, val);
+		if (ret)
+			return ret;
+
+		i++;
+	};
+
+	val = FIELD_PREP(ADP5055_MASK_EN_MODE, adp5055->en_mode_software);
+	ret = regmap_write(regmap, ADP5055_CTRL_MODE1, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(ADP5055_MASK_OCP_BLANKING, ocp_blanking);
+	ret = regmap_update_bits(regmap, ADP5055_CTRL_MODE2,
+				ADP5055_MASK_OCP_BLANKING, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(ADP5055_MASK_FAST_TRANSIENT2, adp5055->fast_transient[2]);
+	val |= FIELD_PREP(ADP5055_MASK_FAST_TRANSIENT1, adp5055->fast_transient[1]);
+	val |= FIELD_PREP(ADP5055_MASK_FAST_TRANSIENT0, adp5055->fast_transient[0]);
+	ret = regmap_write(regmap, ADP5055_FT_CFG, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(ADP5055_MASK_DLY_PWRGD, delay_power_good);
+	val |= FIELD_PREP(ADP5055_MASK_PWRGD2, adp5055->mask_power_good[2]);
+	val |= FIELD_PREP(ADP5055_MASK_PWRGD1, adp5055->mask_power_good[1]);
+	val |= FIELD_PREP(ADP5055_MASK_PWRGD0, adp5055->mask_power_good[0]);
+	ret = regmap_write(regmap, ADP5055_PG_CFG, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int adp5055_of_parse_cb(struct device_node *np,
+			      const struct regulator_desc *desc,
+			      struct regulator_config *config)
+{
+	struct adp5055 *adp5055 = config->driver_data;
+	int id, ret, pval, i;
+
+	id = desc->id;
+
+	if (of_property_read_bool(np, "enable-gpios")) {
+		adp5055->en_gpiod[id] = devm_fwnode_gpiod_get(config->dev,
+						of_fwnode_handle(np), "enable",
+						GPIOD_OUT_LOW, "enable");
+		if (IS_ERR(adp5055->en_gpiod[id]))
+			return dev_err_probe(config->dev, PTR_ERR(adp5055->en_gpiod[id]),
+					"Failed to get enable GPIO\n");
+
+		config->ena_gpiod = adp5055->en_gpiod[id];
+	} else {
+		adp5055->en_mode_software = true;
+	}
+
+	ret = of_property_read_u32(np, "adi,dvs-limit-upper-microvolt", &pval);
+	if (ret)
+		adp5055->dvs_limit_upper[id] = 192000;
+	else
+		adp5055->dvs_limit_upper[id] = pval;
+
+	if (adp5055->dvs_limit_upper[id] > 192000 || adp5055->dvs_limit_upper[id] < 12000)
+		return dev_err_probe(config->dev, adp5055->dvs_limit_upper[id],
+			"Out of range - dvs-limit-upper-microvolt value.");
+
+	ret = of_property_read_u32(np, "adi,dvs-limit-lower-microvolt", &pval);
+	if (ret)
+		adp5055->dvs_limit_lower[id] = -190500;
+	else
+		adp5055->dvs_limit_lower[id] = pval;
+
+	if (adp5055->dvs_limit_lower[id] > -10500 || adp5055->dvs_limit_lower[id] < -190500)
+		return dev_err_probe(config->dev, adp5055->dvs_limit_lower[id],
+			"Out of range - dvs-limit-lower-microvolt value.");
+
+	for (i = 0; i < 4; i++) {
+		ret = of_property_match_string(np, "adi,fast-transient",
+					adp5055_fast_transient_vals[i]);
+		if (!ret)
+			break;
+	}
+
+	if (ret < 0)
+		adp5055->fast_transient[id] = 3;
+	else
+		adp5055->fast_transient[id] = i;
+
+	adp5055->mask_power_good[id] = of_property_read_bool(np, "adi,mask-power-good");
+
+	return 0;
+}
+
+static int adp5055_set_mode(struct regulator_dev *rdev, u32 mode)
+{
+	struct adp5055 *adp5055 = rdev_get_drvdata(rdev);
+	int id, ret;
+
+	id = rdev_get_id(rdev);
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		ret = regmap_update_bits(adp5055->regmap, ADP5055_CTRL_MODE2,
+					ADP5055_MASK_PSM << id, 0);
+		break;
+	case REGULATOR_MODE_IDLE:
+		ret = regmap_update_bits(adp5055->regmap, ADP5055_CTRL_MODE2,
+					ADP5055_MASK_PSM << id, ADP5055_MASK_PSM << id);
+		break;
+	default:
+		return dev_err_probe(&rdev->dev, -EINVAL,
+				"Unsupported mode: %d\n", mode);
+	}
+
+	return ret;
+}
+
+static unsigned int adp5055_get_mode(struct regulator_dev *rdev)
+{
+	struct adp5055 *adp5055 = rdev_get_drvdata(rdev);
+	int id, ret, regval;
+
+	id = rdev_get_id(rdev);
+
+	ret = regmap_read(adp5055->regmap, ADP5055_CTRL_MODE2, &regval);
+	if (ret)
+		return ret;
+
+	if (regval & (ADP5055_MASK_PSM << id))
+		return REGULATOR_MODE_IDLE;
+	else
+		return REGULATOR_MODE_NORMAL;
+}
+
+static const struct regulator_ops adp5055_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = adp5055_set_mode,
+	.get_mode = adp5055_get_mode,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
+};
+
+#define ADP5055_REG_(_name, _id, _ch, _ops) \
+	[_id] = { \
+		.name = _name, \
+		.of_match = of_match_ptr(_name), \
+		.of_parse_cb = adp5055_of_parse_cb, \
+		.id = _id, \
+		.ops = _ops, \
+		.linear_ranges = adp5055_voltage_ranges, \
+		.n_linear_ranges = ARRAY_SIZE(adp5055_voltage_ranges), \
+		.vsel_reg = ADP5055_VID##_ch, \
+		.vsel_mask = GENMASK(7, 0), \
+		.enable_reg = ADP5055_CTRL123, \
+		.enable_mask = BIT(_ch), \
+		.active_discharge_on = ADP5055_MASK_DIS##_id, \
+		.active_discharge_off = 0, \
+		.active_discharge_mask = ADP5055_MASK_DIS##_id, \
+		.active_discharge_reg = ADP5055_CTRL_MODE2, \
+		.ramp_reg = ADP5055_DLY##_ch, \
+		.ramp_mask = ADP5055_MASK_EN_DLY, \
+		.n_ramp_values = ARRAY_SIZE(adp5055_enable_delay_vals_2_6), \
+		.type = REGULATOR_VOLTAGE, \
+		.owner = THIS_MODULE, \
+	}
+
+#define ADP5055_REG(_name, _id, _ch) \
+	ADP5055_REG_(_name, _id, _ch, &adp5055_ops)
+
+static struct regulator_desc adp5055_regulators[] = {
+	ADP5055_REG("buck0", 0, 0),
+	ADP5055_REG("buck1", 1, 1),
+	ADP5055_REG("buck2", 2, 2),
+};
+
+static const struct of_device_id adp5055_dt_ids[] = {
+	{ .compatible = "adi,adp5055"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adp5055_dt_ids);
+
+static int adp5055_probe(struct i2c_client *client)
+{
+	struct regulator_init_data *init_data;
+	struct device *dev = &client->dev;
+	struct adp5055 *adp5055;
+	int i, ret;
+
+	init_data = of_get_regulator_init_data(dev, client->dev.of_node,
+					       &adp5055_regulators[0]);
+	if (!init_data)
+		return -EINVAL;
+
+	adp5055 = devm_kzalloc(dev, sizeof(struct adp5055), GFP_KERNEL);
+	if (!adp5055)
+		return -ENOMEM;
+
+	adp5055->tset = 2600;
+	adp5055->en_mode_software = false;
+
+	adp5055->regmap = devm_regmap_init_i2c(client, &adp5055_regmap_config);
+	if (IS_ERR(adp5055->regmap))
+		return dev_err_probe(dev, PTR_ERR(adp5055->regmap), "Failed to allocate reg map");
+
+	for (i = 0; i < ADP5055_NUM_CH; i++) {
+		const struct regulator_desc *desc;
+		struct regulator_config config = { };
+		struct regulator_dev *rdev;
+
+		if (adp5055->tset == 2600)
+			adp5055_regulators[i].ramp_delay_table = adp5055_enable_delay_vals_2_6;
+		else
+			adp5055_regulators[i].ramp_delay_table = adp5055_enable_delay_vals_20_8;
+
+		desc = &adp5055_regulators[i];
+
+		config.dev = dev;
+		config.driver_data = adp5055;
+		config.regmap = adp5055->regmap;
+		config.init_data = init_data;
+
+		rdev = devm_regulator_register(dev, desc, &config);
+		if (IS_ERR(rdev)) {
+			return dev_err_probe(dev, PTR_ERR(rdev),
+					"Failed to register %s\n", desc->name);
+		}
+	}
+
+	ret = adp5055_parse_fw(dev, adp5055);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id adp5055_of_match[] = {
+	{ .compatible = "adi,adp5055", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adp5055_of_match);
+
+static const struct i2c_device_id adp5055_ids[] = {
+	{ .name = "adp5055"},
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, adp5055_ids);
+
+static struct i2c_driver adp5055_driver = {
+	.driver	= {
+		.name	= "adp5055",
+		.of_match_table = adp5055_of_match,
+	},
+	.probe		= adp5055_probe,
+	.id_table	= adp5055_ids,
+};
+module_i2c_driver(adp5055_driver);
+
+MODULE_DESCRIPTION("ADP5055 Voltage Regulator Driver");
+MODULE_AUTHOR("Alexis Czezar Torreno <alexisczezar.torreno@analog.com>");
+MODULE_LICENSE("GPL");

-- 
2.34.1


