Return-Path: <linux-kernel+bounces-748277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5592CB13EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0347B18949F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC0A274B5E;
	Mon, 28 Jul 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqS+nC0a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B84418A6AB;
	Mon, 28 Jul 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717179; cv=none; b=R4/iVu3QG8Vxz3ZoSd2OFpkFxrupsmcTJK3rw2kA0aHK9QJjiEol1G2HhErgXeircatIdHxrSxVYULsJ/eKEqPPfrfLMbmCqBhPvZLBO/Uupfn+9n4u9EVAE9EAS3xxrVx6GcIGlSen+yI0Aebf8+rdsGhsP32pHqdp/ToM7piY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717179; c=relaxed/simple;
	bh=cFi44ncW4MLjAmtCd1ltfr6b+orIKdQtgComk8+rcgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=idiUdPy0g0f4sfkwwZAupZhL1pWALjecZ7/k1mexC1E51fDIejtaa+WjcPXR8j4cdJ41XK0bnfAYWKPklMmW0QBje7MgR0AP2hHcXCFq/ZFnYiayp/8bjFofEF91OEyJ9/P2e6wUTaCDOxMBv4NAqTKHSiHpvg5o2TAnbQ13MWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqS+nC0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5B16C4CEF7;
	Mon, 28 Jul 2025 15:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753717178;
	bh=cFi44ncW4MLjAmtCd1ltfr6b+orIKdQtgComk8+rcgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LqS+nC0am/Xdg2Lw4s+SvMCVin19X8OFX6HQqOaLsI2rRX19Ijax4rVRrY34nlULU
	 I2NJGMVPnvGP2cgAX7AIOvEMjZxe27bEFM/Baj1FhI/JF+f2OJ8Pm1jq8wbzH0ErNz
	 Uc2JbeCyqbKZ8dY6Q2ChvzlpokWsDV0dRzxik5oE0aaK9v350AMb2uTOFHWljBrh3A
	 PiocqsIBgdmQ7IMbleuLuzlkfzvDURhcopo3dYt/2g/0RcQD9yLCPDWuNRC5Ls0LuE
	 h80bDTZLau829MCRluXDY0K1k9VC1DU74hxTkxaJV2pkQQnFrDIL6Wjj96CwcbOC3O
	 4kG4YJtfH/Ttw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE12DC87FCB;
	Mon, 28 Jul 2025 15:39:38 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 28 Jul 2025 17:39:30 +0200
Subject: [PATCH 2/2] phy: add basic support for NXPs TJA1145 CAN
 transceiver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-tja1145-support-v1-2-ebd8494d545c@liebherr.com>
References: <20250728-tja1145-support-v1-0-ebd8494d545c@liebherr.com>
In-Reply-To: <20250728-tja1145-support-v1-0-ebd8494d545c@liebherr.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753717177; l=7261;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=xQm1ZMNyyki2fr/Z9Lg4N4qqLulA01+okhg1FBDHbTI=;
 b=q1Yjlb9vh+DnMv54ZDY3F/knMVixj141CVkcp3bXqda8uSp4GVGy+TibUE1ICSIPjtHFKhy3t
 ivoIWOZJfjXC1Cl11jTrpvGBmYcAqeZRzbXFLUvRqqo7t5L1YGVhOqc
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Add basic driver support for NXPs TJA1145 CAN transceiver which brings the
PHY up/down by switching to normal/standby mode using SPI commands.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/phy/Kconfig           |  10 +++
 drivers/phy/Makefile          |   1 +
 drivers/phy/phy-nxp-tja1145.c | 185 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 58c911e1b2d20a0398f02550e938ce62633230d4..c47e2b62fa6279ee610493b028d3c14f6499ca85 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -101,6 +101,16 @@ config PHY_NXP_PTN3222
 	  schemes. It supports all three USB 2.0 data rates: Low Speed, Full
 	  Speed and High Speed.
 
+config PHY_NXP_TJA1145
+	tristate "NXP TJA1145 CAN transceiver PHY"
+	select GENERIC_PHY
+	select REGMAP_SPI
+	depends on SPI
+	help
+	  This option enables support for NXPs TJA1145 CAN transceiver as a PHY.
+	  This driver provides function for putting the transceiver in various
+	  functional modes using SPI commands.
+
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index c670a8dac46807863c9ef990beb149082238ad16..16da564c74b0f14befb486366dcd10cd5fc67741 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PHY_SNPS_EUSB2)		+= phy-snps-eusb2.o
 obj-$(CONFIG_USB_LGM_PHY)		+= phy-lgm-usb.o
 obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
 obj-$(CONFIG_PHY_NXP_PTN3222)		+= phy-nxp-ptn3222.o
+obj-$(CONFIG_PHY_NXP_TJA1145)		+= phy-nxp-tja1145.o
 obj-y					+= allwinner/	\
 					   amlogic/	\
 					   broadcom/	\
diff --git a/drivers/phy/phy-nxp-tja1145.c b/drivers/phy/phy-nxp-tja1145.c
new file mode 100644
index 0000000000000000000000000000000000000000..fa8f588f84913ec3d49533d7be540b3d61b6b304
--- /dev/null
+++ b/drivers/phy/phy-nxp-tja1145.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Liebherr-Electronics and Drives GmbH
+ */
+#include <linux/bitfield.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include <linux/phy/phy.h>
+#include <linux/spi/spi.h>
+
+#define TJA1145_MODE_CTRL		0x01
+#define TJA1145_MODE_CTRL_MC		GENMASK(2, 0)
+#define TJA1145_MODE_CRTL_STBY		BIT(2)
+#define TJA1145_MODE_CRTL_NORMAL	TJA1145_MODE_CTRL_MC
+
+#define TJA1145_CAN_CTRL		0x20
+#define TJA1145_CAN_CTRL_CMC		GENMASK(1, 0)
+#define TJA1145_CAN_CTRL_ACTIVE		BIT(1)
+
+#define TJA1145_IDENT			0x7e
+#define TJA1145_IDENT_TJA1145T		0x70
+
+#define TJA1145_SPI_READ_BIT		BIT(0)
+#define TJA1145T_MAX_BITRATE		1000000
+
+static int tja1145_phy_power_on(struct phy *phy)
+{
+	struct regmap *map = phy_get_drvdata(phy);
+	int ret;
+
+	/*
+	 * Switch operating mode to normal which is the active operating mode.
+	 * In this mode, the device is fully operational.
+	 */
+	ret = regmap_update_bits(map, TJA1145_MODE_CTRL, TJA1145_MODE_CTRL_MC,
+				 TJA1145_MODE_CRTL_NORMAL);
+	if (ret)
+		return ret;
+
+	/*
+	 * Switch to CAN operating mode active where the PHY can transmit and
+	 * receive data.
+	 */
+	return regmap_update_bits(map, TJA1145_CAN_CTRL, TJA1145_CAN_CTRL_CMC,
+				  TJA1145_CAN_CTRL_ACTIVE);
+}
+
+static int tja1145_phy_power_off(struct phy *phy)
+{
+	struct regmap *map = phy_get_drvdata(phy);
+
+	/*
+	 * Switch to operating mode standby, the PHY is unable to transmit or
+	 * receive data in standby mode.
+	 */
+	return regmap_update_bits(map, TJA1145_MODE_CTRL, TJA1145_MODE_CTRL_MC,
+				  TJA1145_MODE_CRTL_STBY);
+}
+
+static const struct phy_ops tja1145_phy_ops = {
+	.power_on = tja1145_phy_power_on,
+	.power_off = tja1145_phy_power_off,
+};
+
+static const struct regmap_range tja1145_wr_holes_ranges[] = {
+	regmap_reg_range(0x00, 0x00),
+	regmap_reg_range(0x02, 0x03),
+	regmap_reg_range(0x05, 0x05),
+	regmap_reg_range(0x0b, 0x1f),
+	regmap_reg_range(0x21, 0x22),
+	regmap_reg_range(0x24, 0x25),
+	regmap_reg_range(0x30, 0x4b),
+	regmap_reg_range(0x4d, 0x60),
+	regmap_reg_range(0x62, 0x62),
+	regmap_reg_range(0x65, 0x67),
+	regmap_reg_range(0x70, 0xff),
+};
+
+static const struct regmap_access_table tja1145_wr_table = {
+	.no_ranges = tja1145_wr_holes_ranges,
+	.n_no_ranges = ARRAY_SIZE(tja1145_wr_holes_ranges),
+};
+
+static const struct regmap_range tja1145_rd_holes_ranges[] = {
+	regmap_reg_range(0x00, 0x00),
+	regmap_reg_range(0x02, 0x02),
+	regmap_reg_range(0x05, 0x05),
+	regmap_reg_range(0x0b, 0x1f),
+	regmap_reg_range(0x21, 0x21),
+	regmap_reg_range(0x24, 0x25),
+	regmap_reg_range(0x30, 0x4a),
+	regmap_reg_range(0x4d, 0x5f),
+	regmap_reg_range(0x62, 0x62),
+	regmap_reg_range(0x65, 0x67),
+	regmap_reg_range(0x70, 0x7d),
+	regmap_reg_range(0x7f, 0xff),
+};
+
+static const struct regmap_access_table tja1145_rd_table = {
+	.no_ranges = tja1145_rd_holes_ranges,
+	.n_no_ranges = ARRAY_SIZE(tja1145_rd_holes_ranges),
+};
+
+
+static const struct regmap_config tja1145_regmap_config = {
+	.reg_bits = 8,
+	.reg_shift = -1,
+	.val_bits = 8,
+	.wr_table = &tja1145_wr_table,
+	.rd_table = &tja1145_rd_table,
+	.read_flag_mask = TJA1145_SPI_READ_BIT,
+	.max_register = TJA1145_IDENT,
+};
+
+static int tja1145_check_ident(struct device *dev, struct regmap *map)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(map, TJA1145_IDENT, &val);
+	if (ret)
+		return ret;
+
+	if (val != TJA1145_IDENT_TJA1145T) {
+		dev_err(dev, "Expected device id: 0x%02x, got: 0x%02x\n",
+			TJA1145_IDENT_TJA1145T, val);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int tja1145_probe(struct spi_device *spi)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &spi->dev;
+	struct regmap *map;
+	struct phy *phy;
+	int ret;
+
+	map = devm_regmap_init_spi(spi, &tja1145_regmap_config);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map), "failed to init regmap\n");
+
+	ret = tja1145_check_ident(dev, map);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to identify device\n");
+
+	phy = devm_phy_create(dev, dev->of_node, &tja1145_phy_ops);
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy), "failed to create PHY\n");
+
+	phy->attrs.max_link_rate = TJA1145T_MAX_BITRATE;
+	phy_set_drvdata(phy, map);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct spi_device_id tja1145_spi_id[] = {
+	{ "tja1145" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, tja1145_spi_id);
+
+static const struct of_device_id tja1145_of_match[] = {
+	{ .compatible = "nxp,tja1145" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tja1145_of_match);
+
+static struct spi_driver tja1145_driver = {
+	.driver = {
+		.name = "tja1145",
+		.of_match_table = tja1145_of_match,
+	},
+	.probe = tja1145_probe,
+	.id_table = tja1145_spi_id,
+};
+module_spi_driver(tja1145_driver);
+
+MODULE_DESCRIPTION("NXP TJA1145 CAN transceiver PHY driver");
+MODULE_AUTHOR("Dimitri Fedrau <dimitri.fedrau@liebherr.com>");
+MODULE_LICENSE("GPL");

-- 
2.39.5



