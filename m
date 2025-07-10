Return-Path: <linux-kernel+bounces-724790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 943E0AFF6F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E417BA20A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81733280303;
	Thu, 10 Jul 2025 02:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lab126.com header.i=@lab126.com header.b="Yf+jUnyp"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E927F187;
	Thu, 10 Jul 2025 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115362; cv=none; b=gxQm/0HqsIxU4k+COub/XxqcbVJnX0Tw8ctjZnMmANn/qKK9UQBUk/wRBZwO6ElEKSq4CPZFSR5zffTlshW7D0FFJ4dAE3ZXiZ502aG25pLx+4DA+4lP3dxoaEzJGRqVqSlEo0SvoAel3Fs7c4c6MDwb2SMK/cPWohxLZinVpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115362; c=relaxed/simple;
	bh=dAfksxdv3fjg3Vk9lKSVU8SY1AH2/3lcsly9d0mzraw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgT/DAMMkzhu62D8NiwaPumkDC/tKnG73D5j0FUYQljddRBwGqvvSjJwuyiqpUITKXnC8dCvkQZJ4ipDhd/qPEbSG69fMq+eUh5d3IGgiSgc4skF5LJvrG1RNwng1WxXnpcvftp1BQEHGq6yI/wypU4LKnm0gPitff6/644J6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lab126.com; spf=pass smtp.mailfrom=lab126.com; dkim=pass (2048-bit key) header.d=lab126.com header.i=@lab126.com header.b=Yf+jUnyp; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lab126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lab126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=lab126.com; i=@lab126.com; q=dns/txt; s=amazoncorp2;
  t=1752115360; x=1783651360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6I0/pA1YJ4nL2BLkVcWVaXIQ5lSfcGJfu8j65+5jWWM=;
  b=Yf+jUnypL/+HCfOJfN02lit/DYE9Mntb7p1wnRVUe7jkASIiaR2lGdDW
   AC3ITUnxXSIUYHIElNdeldviEukOyaLF3jhSSQJ8/ElaCuR1MqpdhmrXd
   ckhPsoQeDosSp3yfqxhb8f3Jm4fw2yo7ED2me7rJkL7KxScqa2lwrmCVJ
   j4kgjOxYEB/fO8JEnvdROTvsO+MBMFO+ruEk0ec4JpIyxja8fD27qgMEL
   wNzjEgcWI6qlb/PgxQ2LFW4vzfPmBDEMkMmZ4TjewYQSfxicKGd2kyeSL
   iVLKibhDEn9yukT/1woq+TkS4UgOmhHpjtswZO+wb8T3OZYW9M6pDFJ+f
   w==;
X-IronPort-AV: E=Sophos;i="6.16,299,1744070400"; 
   d="scan'208";a="217757192"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:42:38 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:2059]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.102:2525] with esmtp (Farcaster)
 id a0d05b4a-81f9-4279-bd9f-c6518eb93719; Thu, 10 Jul 2025 02:42:38 +0000 (UTC)
X-Farcaster-Flow-ID: a0d05b4a-81f9-4279-bd9f-c6518eb93719
Received: from EX19D007UWB001.ant.amazon.com (10.13.138.75) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Jul 2025 02:42:38 +0000
Received: from u1cb251c9c70150.ant.amazon.com (10.68.99.17) by
 EX19D007UWB001.ant.amazon.com (10.13.138.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Jul 2025 02:42:37 +0000
From: Karthik Poduval <kpoduval@lab126.com>
To: <jyxiong@amazon.com>, <miguel.lopes@synopsys.com>, <anishkmr@amazon.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC: Karthik Poduval <kpoduval@lab126.com>
Subject: [PATCH v2 1/2] phy: dw-dphy-rx: Add Synopsys DesignWare D-PHY RX
Date: Wed, 9 Jul 2025 19:42:20 -0700
Message-ID: <2383f8cf2a8f5e1b914d4cf9bd11674ed55876d2.1752106239.git.kpoduval@lab126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752106239.git.kpoduval@lab126.com>
References: <cover.1752106239.git.kpoduval@lab126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D007UWB001.ant.amazon.com (10.13.138.75)

Add support for Synopsys DesignWare MIPI D-PHY RX v1.2. The driver
supports data rates from 80Mbps to 2500Mbps.

Signed-off-by: Karthik Poduval <kpoduval@lab126.com>
---
 drivers/phy/Kconfig       |  11 +
 drivers/phy/Makefile      |   1 +
 drivers/phy/phy-dw-dphy.c | 575 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 587 insertions(+)
 create mode 100644 drivers/phy/phy-dw-dphy.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 58c911e1b2d2..34c245ca5d12 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -101,6 +101,17 @@ config PHY_NXP_PTN3222
 	  schemes. It supports all three USB 2.0 data rates: Low Speed, Full
 	  Speed and High Speed.
 
+config PHY_SYNOPSYS_DW_DPHY_RX
+	tristate "Synopsys DesignWare D-PHY Rx Support"
+	depends on HAS_IOMEM && REGMAP_MMIO
+	select GENERIC_PHY
+	select GENERIC_PHY_MIPI_DPHY
+	help
+	  This option enables support for Synopsys DW MIPI D-PHY RX IP. This driver
+	  provides D-PHY functionality using Generic PHY framework and is meant to
+	  be used by MIPI CSI2 receivers over the PPI hardware interface. MIPI CSI2
+	  receivers may find this driver and use it via Generic PHY Framework API.
+
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index c670a8dac468..ed0836adb835 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PHY_SNPS_EUSB2)		+= phy-snps-eusb2.o
 obj-$(CONFIG_USB_LGM_PHY)		+= phy-lgm-usb.o
 obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
 obj-$(CONFIG_PHY_NXP_PTN3222)		+= phy-nxp-ptn3222.o
+obj-$(CONFIG_PHY_SYNOPSYS_DW_DPHY_RX)	+= phy-dw-dphy.o
 obj-y					+= allwinner/	\
 					   amlogic/	\
 					   broadcom/	\
diff --git a/drivers/phy/phy-dw-dphy.c b/drivers/phy/phy-dw-dphy.c
new file mode 100644
index 000000000000..2248f690b861
--- /dev/null
+++ b/drivers/phy/phy-dw-dphy.c
@@ -0,0 +1,575 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright © 2025 Amazon.com, Inc. or its affiliates.
+ * Copyright © 2025 Synopsys, Inc. (www.synopsys.com)
+ */
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/regmap.h>
+
+#include <linux/phy/phy.h>
+#include <linux/phy/phy-mipi-dphy.h>
+
+#define KHZ (1000)
+#define MHZ (KHZ * KHZ)
+
+enum dw_dphy_reg_fields_cfg1 {
+	PHY_SHUTDOWNZ,
+	DPHY_RSTZ,
+	TEST_CLR,
+	TEST_CLK,
+	TEST_IN,
+	TEST_OUT,
+	TEST_EN,
+	DW_DPHY_RF_CFG1_MAX
+};
+
+enum dw_dphy_reg_fields_cfg2 {
+	EN_CONT_REG_UPDATE,
+	TURN_REQUEST_0,
+	TURN_DISABLE_0,
+	ENABLE_CLK,
+	FORCE_TX_STOP_MODE_0,
+	FORCE_RX_MODE,
+	BASE_DIR_0,
+	CFG_CLK_FREQ_RANGE,
+	HS_FREQ_RANGE,
+	CONT_EN,
+	DW_DPHY_RF_CFG2_MAX
+};
+
+static const struct reg_field dw_dphy_v1_2_cfg1[DW_DPHY_RF_CFG1_MAX] = {
+	[PHY_SHUTDOWNZ] = REG_FIELD(0x0, 0, 0),
+	[DPHY_RSTZ] = REG_FIELD(0x4, 0, 0),
+	[TEST_CLR] = REG_FIELD(0x10, 0, 0),
+	[TEST_CLK] = REG_FIELD(0x10, 1, 1),
+	[TEST_IN] = REG_FIELD(0x14, 0, 7),
+	[TEST_OUT] = REG_FIELD(0x14, 8, 15),
+	[TEST_EN] = REG_FIELD(0x14, 16, 16),
+};
+
+static const struct reg_field dw_dphy_v1_2_cfg2[DW_DPHY_RF_CFG2_MAX] = {
+	[EN_CONT_REG_UPDATE] = REG_FIELD(0x0, 23, 23),
+	[TURN_REQUEST_0] = REG_FIELD(0x0, 22, 22),
+	[TURN_DISABLE_0] = REG_FIELD(0x0, 21, 21),
+	[ENABLE_CLK] = REG_FIELD(0x0, 20, 20),
+	[FORCE_TX_STOP_MODE_0] = REG_FIELD(0x0, 19, 19),
+	[FORCE_RX_MODE] = REG_FIELD(0x0, 15, 18),
+	[BASE_DIR_0] = REG_FIELD(0x0, 14, 14),
+	[CFG_CLK_FREQ_RANGE] = REG_FIELD(0x0, 8, 13),
+	[HS_FREQ_RANGE] = REG_FIELD(0x0, 1, 7),
+	[CONT_EN] = REG_FIELD(0x0, 0, 0),
+};
+
+enum dphy_12bit_interface_addr {
+	RX_SYS_0 = 0x01,
+	RX_SYS_1 = 0x02,
+	RX_SYS_7 = 0x08,
+	RX_RX_STARTUP_OVR_0 = 0xe0,
+	RX_RX_STARTUP_OVR_1 = 0xe1,
+	RX_RX_STARTUP_OVR_2 = 0xe2,
+	RX_RX_STARTUP_OVR_3 = 0xe3,
+	RX_RX_STARTUP_OVR_4 = 0xe4,
+};
+
+/**
+ * struct range_dphy_gen3 - frequency range calibration structure
+ *
+ * @freq: input freqency to calibration table
+ * @hsfregrange: corresponding clock to configure DW D-PHY IP
+ * @osc_freq_target: corresponding clock to configure DW D-PHY IP
+ *
+ **/
+struct range_dphy_gen3 {
+	u32 freq;
+	u8 hsfregrange;
+	u32 osc_freq_target;
+};
+
+/**
+ * struct dt_data_dw_dphy - DPHY configuration data structure
+ * @table: Pointer to array of DPHY Gen3 timing range configurations
+ * @table_size: Number of entries in the timing range table
+ * @phy_ops: Pointer to PHY operations structure containing callback functions
+ *
+ **/
+struct dt_data_dw_dphy {
+	struct range_dphy_gen3 *table;
+	int table_size;
+	const struct phy_ops *phy_ops;
+};
+
+/*
+ * DW DPHY Gen3 calibration table
+ *
+ */
+struct range_dphy_gen3 range_gen3[] = {
+	{ 80, 0b0000000, 460 },	  { 90, 0b0010000, 460 },
+	{ 100, 0b0100000, 460 },  { 110, 0b0110000, 460 },
+	{ 120, 0b0000001, 460 },  { 130, 0b0010001, 460 },
+	{ 140, 0b0100001, 460 },  { 150, 0b0110001, 460 },
+	{ 160, 0b0000010, 460 },  { 170, 0b0010010, 460 },
+	{ 180, 0b0100010, 460 },  { 190, 0b0110010, 460 },
+	{ 205, 0b0000011, 460 },  { 220, 0b0010011, 460 },
+	{ 235, 0b0100011, 460 },  { 250, 0b0110011, 460 },
+	{ 275, 0b0000100, 460 },  { 300, 0b0010100, 460 },
+	{ 325, 0b0100101, 460 },  { 350, 0b0110101, 460 },
+	{ 400, 0b0000101, 460 },  { 450, 0b0010110, 460 },
+	{ 500, 0b0100110, 460 },  { 550, 0b0110111, 460 },
+	{ 600, 0b0000111, 460 },  { 650, 0b0011000, 460 },
+	{ 700, 0b0101000, 460 },  { 750, 0b0111001, 460 },
+	{ 800, 0b0001001, 460 },  { 850, 0b0011001, 460 },
+	{ 900, 0b0101001, 460 },  { 950, 0b0111010, 460 },
+	{ 1000, 0b0001010, 460 }, { 1050, 0b0011010, 460 },
+	{ 1110, 0b0101010, 460 }, { 1150, 0b0111011, 460 },
+	{ 1200, 0b0001011, 460 }, { 1250, 0b0011011, 460 },
+	{ 1300, 0b0101011, 460 }, { 1350, 0b0111100, 460 },
+	{ 1400, 0b0001100, 460 }, { 1450, 0b0011100, 460 },
+	{ 1500, 0b0101100, 460 }, { 1550, 0b0111101, 285 },
+	{ 1600, 0b0001101, 295 }, { 1650, 0b0011101, 304 },
+	{ 1700, 0b0101110, 313 }, { 1750, 0b0111110, 322 },
+	{ 1800, 0b0001110, 331 }, { 1850, 0b0011110, 341 },
+	{ 1900, 0b0101111, 350 }, { 1950, 0b0111111, 359 },
+	{ 2000, 0b0001111, 368 }, { 2050, 0b1000000, 377 },
+	{ 2100, 0b1000001, 387 }, { 2150, 0b1000010, 396 },
+	{ 2200, 0b1000011, 405 }, { 2250, 0b1000100, 414 },
+	{ 2300, 0b1000101, 423 }, { 2350, 0b1000110, 432 },
+	{ 2400, 0b1000111, 442 }, { 2450, 0b1001000, 451 },
+	{ 2500, 0b1001001, 460 }
+};
+
+/**
+ * struct dw_dphy - DW D-PHY driver private structure
+ *
+ * @regmap: pointer to regmap
+ * @regmap_cfg1: pointer to config1 regmap
+ * @regmap_cfg2: pointer to config2 regmap
+ * @rf_cfg1: array of regfields for config1
+ * @rf_cfg2: array of regfields for config2
+ * @iomem_cfg1: MMIO address for cfg1 section
+ * @iomem_cfg2: MMIO address for cfg2 section
+ * @phy: pointer to the phy data structure
+ * @hs_clk_rate: high speed clock rate as per image sensor configuration
+ * @dt_data_dw_dphy: device tree specific data
+ *
+ **/
+struct dw_dphy {
+	struct regmap *regmap_cfg1;
+	struct regmap *regmap_cfg2;
+	struct regmap_field *rf_cfg1[DW_DPHY_RF_CFG1_MAX];
+	struct regmap_field *rf_cfg2[DW_DPHY_RF_CFG2_MAX];
+	void __iomem *iomem_cfg1;
+	void __iomem *iomem_cfg2;
+	struct phy *phy;
+	struct device *dev;
+	unsigned long hs_clk_rate;
+	struct dt_data_dw_dphy *dt_data;
+};
+
+/**
+ * dw_dphy_te_write - write register into test enable interface
+ *
+ * @dphy: pointer to the dw_dphy private data structure
+ * @addr: 12 bit TE address register (16 bit container)
+ * @data: 8 bit data to be written to TE register
+ *
+ **/
+static void dw_dphy_te_write(struct dw_dphy *dphy, u16 addr, u8 data)
+{
+	/* For writing the 4-bit testcode MSBs */
+
+	/* Ensure that testclk and testen is set to low */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 0);
+	regmap_field_write(dphy->rf_cfg1[TEST_EN], 0);
+
+	/* Set testen to high */
+	regmap_field_write(dphy->rf_cfg1[TEST_EN], 1);
+
+	/* Set testclk to high */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 1);
+
+	/* Place 0x00 in testdin */
+	regmap_field_write(dphy->rf_cfg1[TEST_IN], 0);
+
+	/*
+	 * Set testclk to low (with the falling edge on testclk, the testdin signal
+	 * content is latched internally)
+	 */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 0);
+
+	/* Set testen to low */
+	regmap_field_write(dphy->rf_cfg1[TEST_EN], 0);
+
+	/* Place the 8-bit word corresponding to the testcode MSBs in testdin */
+	regmap_field_write(dphy->rf_cfg1[TEST_IN], (addr >> 8));
+
+	/* Set testclk to high */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 1);
+
+	/* For writing the 8-bit testcode LSBs */
+
+	/* Set testclk to low */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 0);
+
+	/* Set testen to high */
+	regmap_field_write(dphy->rf_cfg1[TEST_EN], 1);
+
+	/* Set testclk to high */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 1);
+
+	/* Place the 8-bit word test data in testdin */
+	regmap_field_write(dphy->rf_cfg1[TEST_IN], (addr & 0xff));
+
+	/*
+	 * Set testclk to low (with the falling edge on testclk, the testdin signal
+	 * content is latched internally)
+	 */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 0);
+
+	/* Set testen to low */
+	regmap_field_write(dphy->rf_cfg1[TEST_EN], 0);
+
+	/* For writing the data */
+
+	/* Place the 8-bit word corresponding to the page offset in testdin */
+	regmap_field_write(dphy->rf_cfg1[TEST_IN], data);
+
+	/* Set testclk to high (test data is programmed internally) */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 1);
+}
+
+/**
+ * dw_dphy_te_read - read register from test enable interface
+ *
+ * @dphy: pointer to the dw_dphy private data structure
+ * @addr: 12 bit TE address register (16 bit container)
+ * @returns: 8 bit data from TE register
+ **/
+static u8 dw_dphy_te_read(struct dw_dphy *dphy, u16 addr)
+{
+	u32 data;
+
+	/* For writing the 4-bit testcode MSBs */
+
+	/* Ensure that testclk and testen is set to low */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 0);
+	regmap_field_write(dphy->rf_cfg1[TEST_EN], 0);
+
+	/* Set testen to high */
+	regmap_field_write(dphy->rf_cfg1[TEST_EN], 1);
+
+	/* Set testclk to high */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 1);
+
+	/* Place 0x00 in testdin */
+	regmap_field_write(dphy->rf_cfg1[TEST_IN], 0);
+
+	/*
+	 * Set testclk to low (with the falling edge on testclk, the testdin signal
+	 * content is latched internally)
+	 */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 0);
+
+	/* Set testen to low */
+	regmap_field_write(dphy->rf_cfg1[TEST_EN], 0);
+
+	/* Place the 8-bit word corresponding to the testcode MSBs in testdin */
+	regmap_field_write(dphy->rf_cfg1[TEST_IN], (addr >> 8));
+
+	/* Set testclk to high */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 1);
+
+	/* For writing the 8-bit testcode LSBs */
+
+	/* Set testclk to low */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 0);
+
+	/* Set testen to high */
+	regmap_field_write(dphy->rf_cfg1[TEST_EN], 1);
+
+	/* Set testclk to high */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 1);
+
+	/* Place the 8-bit word test data in testdin */
+	regmap_field_write(dphy->rf_cfg1[TEST_IN], (addr & 0xff));
+
+	/*
+	 * Set testclk to low (with the falling edge on testclk, the testdin signal
+	 * content is latched internally)
+	 */
+	regmap_field_write(dphy->rf_cfg1[TEST_CLK], 0);
+
+	/* Set testen to low */
+	regmap_field_write(dphy->rf_cfg1[TEST_EN], 0);
+
+	regmap_field_read(dphy->rf_cfg1[TEST_OUT], &data);
+
+	return (u8)data;
+}
+
+/**
+ * dw_dphy_configure - configure the D-PHY
+ *
+ * @phy: pointer to the phy data structure
+ * @opts: pointer to the phy configuration options
+ * @returns 0 if success else appropriate error code
+ *
+ **/
+static int dw_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
+{
+	struct dw_dphy *dphy = phy_get_drvdata(phy);
+
+	dphy->hs_clk_rate = opts->mipi_dphy.hs_clk_rate;
+	dev_dbg(dphy->dev, "hs_clk_rate=%ld\n", dphy->hs_clk_rate);
+
+	return 0;
+}
+
+/**
+ * dw_dphy_power_on_1p2 - power on the DPHY version 1.2
+ *
+ * @phy: pointer to the phy data structure
+ * @returns 0 if success else appropriate error code
+ *
+ **/
+static int dw_dphy_power_on_1p2(struct phy *phy)
+{
+	struct dw_dphy *dphy = phy_get_drvdata(phy);
+
+	uint8_t counter_for_des_en_config_if_rw = 0x1;
+	u8 range = 0;
+
+	for (range = 0;
+	     (range < dphy->dt_data->table_size - 1) &&
+	     ((dphy->hs_clk_rate) > dphy->dt_data->table[range].freq);
+	     range++)
+		;
+
+	/* in case requested hs_clk_rate is out of range, return -EINVAL */
+	if (range >= dphy->dt_data->table_size)
+		return -EINVAL;
+
+	dev_dbg(dphy->dev, "12bit: PHY GEN 3: Freq: %ld %x\n", dphy->hs_clk_rate,
+		 range_gen3[range].hsfregrange);
+
+	regmap_field_write(dphy->rf_cfg1[DPHY_RSTZ], 0);
+	regmap_field_write(dphy->rf_cfg1[PHY_SHUTDOWNZ], 0);
+	regmap_field_write(dphy->rf_cfg1[TEST_CLR], 0);
+	regmap_field_write(dphy->rf_cfg1[TEST_CLR], 1);
+	regmap_field_write(dphy->rf_cfg1[TEST_CLR], 0);
+	regmap_field_write(dphy->rf_cfg2[CFG_CLK_FREQ_RANGE], 0x28);
+	dw_dphy_te_write(dphy, RX_SYS_1,
+			 dphy->dt_data->table[range].hsfregrange);
+	dw_dphy_te_write(dphy, RX_SYS_0, 0x20);
+	dw_dphy_te_write(dphy, RX_RX_STARTUP_OVR_2,
+			 (u8)dphy->dt_data->table[range].osc_freq_target);
+	dw_dphy_te_write(dphy, RX_RX_STARTUP_OVR_3,
+			 (u8)(dphy->dt_data->table[range].osc_freq_target >>
+			      8));
+	dw_dphy_te_write(dphy, 0xe4,
+			 (counter_for_des_en_config_if_rw << 4) | 0b1);
+
+	dw_dphy_te_write(dphy, RX_RX_STARTUP_OVR_1, 0x01);
+	dw_dphy_te_write(dphy, RX_RX_STARTUP_OVR_0, 0x80);
+
+	regmap_field_write(dphy->rf_cfg2[BASE_DIR_0], 1);
+	regmap_field_write(dphy->rf_cfg2[ENABLE_CLK], 1);
+	regmap_field_write(dphy->rf_cfg2[FORCE_RX_MODE], 0x0);
+
+	regmap_field_write(dphy->rf_cfg1[PHY_SHUTDOWNZ], 1);
+	regmap_field_write(dphy->rf_cfg1[DPHY_RSTZ], 1);
+
+	return 0;
+}
+
+/**
+ * dw_dphy_power_off - power off the DPHY
+ *
+ * @phy: pointer to the phy data structure
+ * @returns 0 if success else appropriate error code
+ *
+ **/
+static int dw_dphy_power_off(struct phy *phy)
+{
+	struct dw_dphy *dphy = phy_get_drvdata(phy);
+
+	regmap_field_write(dphy->rf_cfg1[DPHY_RSTZ], 0);
+	regmap_field_write(dphy->rf_cfg1[PHY_SHUTDOWNZ], 0);
+	return 0;
+}
+
+/**
+ * dw_dphy_ops_1p2 - PHY operations for DWC DPHY v1.2
+ * @configure: Configures DPHY timing and operation parameters
+ * @power_on: Powers on the DPHY using v1.2 specific sequence
+ * @power_off: Powers off the DPHY
+ *
+ **/
+static const struct phy_ops dw_dphy_ops_1p2 = {
+	.configure = dw_dphy_configure,
+	.power_on = dw_dphy_power_on_1p2,
+	.power_off = dw_dphy_power_off,
+};
+
+/**
+ * dw_dphy_1p2 - DWC DPHY v1.2 configuration instance
+ * @table: Points to range_gen3 timing parameters table
+ * @table_size: Size of range_gen3 table calculated at compile time
+ * @phy_ops: Points to v1.2 specific PHY operations structure
+ *
+ **/
+struct dt_data_dw_dphy dw_dphy_1p2 = {
+	.table = range_gen3,
+	.table_size = ARRAY_SIZE(range_gen3),
+	.phy_ops = &dw_dphy_ops_1p2,
+};
+
+/**
+ * dw_dphy_regmap_cfg1 - Register map configuration for DW DPHY
+ * @reg_bits: Width of register address in bits (32)
+ * @val_bits: Width of register value in bits (32)
+ * @reg_stride: Number of bytes between registers (4)
+ * @name: Name identifier for this register map
+ * @fast_io: Flag to indicate fast I/O operations are supported
+ *
+ **/
+static const struct regmap_config dw_dphy_regmap_cfg1 = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.name = "dw-dhpy-cfg1",
+	.fast_io = true,
+};
+
+/**
+ * dw_dphy_regmap_cfg2 - Register map configuration for DW DPHY
+ * @reg_bits: Width of register address in bits (32)
+ * @val_bits: Width of register value in bits (32)
+ * @reg_stride: Number of bytes between registers (4)
+ * @name: Name identifier for this register map
+ * @fast_io: Flag to indicate fast I/O operations are supported
+ *
+ **/
+static const struct regmap_config dw_dphy_regmap_cfg2 = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.name = "dw-dhpy-cfg2",
+	.fast_io = true,
+};
+
+/**
+ * dw_dphy_probe - Probe and initialize DW DPHY device
+ * @pdev: Platform device pointer
+ * Return: 0 on success, negative error code on failure
+ *
+ **/
+static int dw_dphy_probe(struct platform_device *pdev)
+{
+	struct dw_dphy *dphy;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	int ret;
+
+	dphy = devm_kzalloc(&pdev->dev, sizeof(*dphy), GFP_KERNEL);
+	if (!dphy)
+		return -ENOMEM;
+
+	dphy->dt_data =
+		(struct dt_data_dw_dphy *)of_device_get_match_data(&pdev->dev);
+	dev_set_drvdata(&pdev->dev, dphy);
+	dphy->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dphy->iomem_cfg1 = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dphy->iomem_cfg1))
+		return PTR_ERR(dphy->iomem_cfg1);
+
+	dphy->regmap_cfg1 =
+		devm_regmap_init_mmio(dev, dphy->iomem_cfg1, &dw_dphy_regmap_cfg1);
+	if (IS_ERR(dphy->regmap_cfg1))
+		return PTR_ERR(dphy->regmap_cfg1);
+
+	ret = devm_regmap_field_bulk_alloc(dev, dphy->regmap_cfg1, dphy->rf_cfg1,
+					   dw_dphy_v1_2_cfg1, DW_DPHY_RF_CFG1_MAX);
+	if (ret < 0) {
+		dev_err(dev, "Could not alloc RF\n");
+		return ret;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	dphy->iomem_cfg2 = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dphy->iomem_cfg2))
+		return PTR_ERR(dphy->iomem_cfg2);
+
+	dphy->regmap_cfg2 = devm_regmap_init_mmio(dev, dphy->iomem_cfg2,
+						 &dw_dphy_regmap_cfg2);
+	if (IS_ERR(dphy->regmap_cfg2))
+		return PTR_ERR(dphy->regmap_cfg2);
+
+	ret = devm_regmap_field_bulk_alloc(dev, dphy->regmap_cfg2, dphy->rf_cfg2,
+					   dw_dphy_v1_2_cfg2, DW_DPHY_RF_CFG2_MAX);
+	if (ret < 0) {
+		dev_err(dev, "Could not alloc RF\n");
+		return ret;
+	}
+
+	dphy->phy = devm_phy_create(&pdev->dev, NULL, dphy->dt_data->phy_ops);
+	if (IS_ERR(dphy->phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(dphy->phy);
+	}
+
+	phy_set_drvdata(dphy->phy, dphy);
+	phy_provider =
+		devm_of_phy_provider_register(&pdev->dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+/**
+ * dw_dphy_of_match - Device tree match table for DW DPHY
+ * @compatible: Compatible string to match device tree node
+ * @data: Pointer to configuration data for matched device
+ *
+ * Table of compatible strings and associated configuration data
+ * for supported DW DPHY variants.
+ * Currently supports:
+ * - DW DPHY v1.2 ("snps,dw-dphy-1p2")
+ *
+ **/
+static const struct of_device_id dw_dphy_of_match[] = {
+	{ .compatible = "snps,dw-dphy-1p2", .data = &dw_dphy_1p2 },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, dw_dphy_of_match);
+
+/**
+ * dw_dphy_platform_driver - Platform driver structure for DW DPHY
+ * @probe: Pointer to probe function called on device discovery
+ * @driver: Core driver structure containing:
+ *         - name: Driver name used for matching and debugging
+ *         - of_match_table: Table of compatible device tree matches
+ *
+ **/
+static struct platform_driver dw_dphy_platform_driver = {
+	.probe		= dw_dphy_probe,
+	.driver		= {
+		.name		= "dw-dphy",
+		.of_match_table	= dw_dphy_of_match,
+	},
+};
+module_platform_driver(dw_dphy_platform_driver);
+
+MODULE_AUTHOR("Karthik Poduval <kpoduval@lab126.com>");
+MODULE_AUTHOR("Jason Xiong <jyxiong@amazon.com>");
+MODULE_AUTHOR("Miguel Lopes <miguel.lopes@synopsys.com>");
+MODULE_DESCRIPTION("DW D-PHY RX Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


