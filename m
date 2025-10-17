Return-Path: <linux-kernel+bounces-858231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E75BE955A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D51135C10B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FE3335081;
	Fri, 17 Oct 2025 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EcZGZZV7"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864A433291D;
	Fri, 17 Oct 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712633; cv=none; b=K/ea6luZe6jtxiZP728Nd8cbTyajSkQcy7W8PzK9skg3qSPoWW15ZVKXfr41dSsb5A5kTddmK+MkkJXkBFDHW+3FVPwXRA0ZEwDy2O9OONzDJCDRZVxQFy3RxUQy4/vFnkn+N/U8z8LvZflDUS2/Xm3i5gqLSfCKkKxEkGS4Dfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712633; c=relaxed/simple;
	bh=I41wqT+slyrOuL6RJOlJuJ956m3tqTCbWWeVtDQOgNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=In7Jz3+HLfEmLiOHec5bFeQYJ9ZFqYvXWqM8Ipus7VBL2np7/+y+aaslAolMA02ioQkuBYq/0eZ/bNd/228luO2CL87A0va/5Z+dzdIiU04RbxvlDvH3HCDwaczCymv9iFG//rW1eV+7wCQdg2UT0l4riZqLtZjrJiRsnagOSoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EcZGZZV7; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760712629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQOiwvJHAprcF3S2canSZCrDDGSsG+867bjti4GoEgo=;
	b=EcZGZZV7COeOQbf9sUcm29ijvjCdR4mYYMV4F02pHzqWPNRrKmbgdLkYdqKIQSUXgJE4vt
	YES/MPAVcrUDB/cw3T1vFmPTAI92YWcKKMzv397W7/59yoaUzX369quI6CRHZ6RHlUMbgo
	KqrKmBjhy3ff/kYI1KRHcq24cWX3zmQ=
From: Ze Huang <huang.ze@linux.dev>
Date: Fri, 17 Oct 2025 22:49:53 +0800
Subject: [PATCH v6 2/2] phy: spacemit: support K1 USB2.0 PHY controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-k1-usb2phy-v6-2-7cf9ea2477a1@linux.dev>
References: <20251017-k1-usb2phy-v6-0-7cf9ea2477a1@linux.dev>
In-Reply-To: <20251017-k1-usb2phy-v6-0-7cf9ea2477a1@linux.dev>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Ze Huang <huang.ze@linux.dev>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Ze Huang <huangze@whut.edu.cn>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760712608; l=9055;
 i=huang.ze@linux.dev; s=20250705; h=from:subject:message-id;
 bh=I41wqT+slyrOuL6RJOlJuJ956m3tqTCbWWeVtDQOgNg=;
 b=L3o5/NhCgqn8Eb9GSbI9hfoM27LN6qOtignRjoVwamsxw9OwPAeYqSggydMoqdlJUjl7flt+u
 PE+bOHlfMQIBm4LB6rr8WIYWNHUAXeLJFW0VmpXo7jhVF00D7LCVglu
X-Developer-Key: i=huang.ze@linux.dev; a=ed25519;
 pk=Kzc4PMu5PTo8eZZQ5xmTNL9jeXcQ9Wml0cs+vlQpBkg=
X-Migadu-Flow: FLOW_OUT

The SpacemiT K1 SoC includes three USB ports:

- One USB2.0 OTG port
- One USB2.0 host-only port
- One USB3.0 port with an integrated USB2.0 DRD interface

Each of these ports is connected to a USB2.0 PHY responsible for USB2
transmission.

This commit adds support for the SpacemiT K1 USB2.0 PHY, which is
compliant with the USB 2.0 specification and supports both 8-bit 60MHz
and 16-bit 30MHz parallel interfaces.

Signed-off-by: Ze Huang <huang.ze@linux.dev>
---
 drivers/phy/Kconfig                |   1 +
 drivers/phy/Makefile               |   1 +
 drivers/phy/spacemit/Kconfig       |  13 +++
 drivers/phy/spacemit/Makefile      |   2 +
 drivers/phy/spacemit/phy-k1-usb2.c | 200 +++++++++++++++++++++++++++++++++++++
 5 files changed, 217 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 1984c2e56122..95ee47f0fbc7 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -134,6 +134,7 @@ source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/samsung/Kconfig"
 source "drivers/phy/socionext/Kconfig"
 source "drivers/phy/sophgo/Kconfig"
+source "drivers/phy/spacemit/Kconfig"
 source "drivers/phy/st/Kconfig"
 source "drivers/phy/starfive/Kconfig"
 source "drivers/phy/sunplus/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index a206133a3515..950dd4f14372 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -37,6 +37,7 @@ obj-y					+= allwinner/	\
 					   samsung/	\
 					   socionext/	\
 					   sophgo/	\
+					   spacemit/	\
 					   st/		\
 					   starfive/	\
 					   sunplus/	\
diff --git a/drivers/phy/spacemit/Kconfig b/drivers/phy/spacemit/Kconfig
new file mode 100644
index 000000000000..0136aee2e8a2
--- /dev/null
+++ b/drivers/phy/spacemit/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Phy drivers for SpacemiT platforms
+#
+config PHY_SPACEMIT_K1_USB2
+	tristate "SpacemiT K1 USB 2.0 PHY support"
+	depends on (ARCH_SPACEMIT || COMPILE_TEST) && OF
+	depends on COMMON_CLK
+	depends on USB_COMMON
+	select GENERIC_PHY
+	help
+	  Enable this to support K1 USB 2.0 PHY driver. This driver takes care of
+	  enabling and clock setup and will be used by K1 udc/ehci/otg/xhci driver.
diff --git a/drivers/phy/spacemit/Makefile b/drivers/phy/spacemit/Makefile
new file mode 100644
index 000000000000..fec0b425a948
--- /dev/null
+++ b/drivers/phy/spacemit/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_PHY_SPACEMIT_K1_USB2)		+= phy-k1-usb2.o
diff --git a/drivers/phy/spacemit/phy-k1-usb2.c b/drivers/phy/spacemit/phy-k1-usb2.c
new file mode 100644
index 000000000000..342061380012
--- /dev/null
+++ b/drivers/phy/spacemit/phy-k1-usb2.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SpacemiT K1 USB 2.0 PHY driver
+ *
+ * Copyright (C) 2025 SpacemiT (Hangzhou) Technology Co. Ltd
+ * Copyright (C) 2025 Ze Huang <huang.ze@linux.dev>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/usb/of.h>
+
+#define PHY_RST_MODE_CTRL		0x04
+#define  PHY_PLL_RDY			BIT(0)
+#define  PHY_CLK_CDR_EN			BIT(1)
+#define  PHY_CLK_PLL_EN			BIT(2)
+#define  PHY_CLK_MAC_EN			BIT(3)
+#define  PHY_MAC_RSTN			BIT(5)
+#define  PHY_CDR_RSTN			BIT(6)
+#define  PHY_PLL_RSTN			BIT(7)
+/*
+ * hs line state sel (Bit 13):
+ * - 1 (Default): Internal HS line state is set to 01 when usb_hs_tx_en is valid.
+ * - 0: Internal HS line state is always driven by usb_hs_lstate.
+ *
+ * fs line state sel (Bit 14):
+ * - 1 (Default): FS line state is determined by the output data
+ * (usb_fs_datain/b).
+ * - 0: FS line state is always determined by the input data (dmo/dpo).
+ */
+#define  PHY_HS_LINE_TX_MODE		BIT(13)
+#define  PHY_FS_LINE_TX_MODE		BIT(14)
+
+#define  PHY_INIT_MODE_BITS		(PHY_FS_LINE_TX_MODE | PHY_HS_LINE_TX_MODE)
+#define  PHY_CLK_ENABLE_BITS		(PHY_CLK_PLL_EN | PHY_CLK_CDR_EN | \
+					 PHY_CLK_MAC_EN)
+#define  PHY_DEASSERT_RST_BITS		(PHY_PLL_RSTN | PHY_CDR_RSTN | \
+					 PHY_MAC_RSTN)
+
+#define PHY_TX_HOST_CTRL		0x10
+#define  PHY_HST_DISC_AUTO_CLR		BIT(2)		/* autoclear hs host disc when re-connect */
+
+#define PHY_HSTXP_HW_CTRL		0x34
+#define  PHY_HSTXP_RSTN			BIT(2)		/* generate reset for clock hstxp */
+#define  PHY_CLK_HSTXP_EN		BIT(3)		/* clock hstxp enable */
+#define  PHY_HSTXP_MODE			BIT(4)		/* 0: force en_txp to be 1; 1: no force */
+
+#define PHY_PLL_DIV_CFG			0x98
+#define  PHY_FDIV_FRACT_8_15		GENMASK(7, 0)
+#define  PHY_FDIV_FRACT_16_19		GENMASK(11, 8)
+#define  PHY_FDIV_FRACT_20_21		BIT(12)		/* fdiv_reg<21>, <20>, bit21 == bit20 */
+/*
+ * freq_sel<1:0>
+ * if ref clk freq=24.0MHz-->freq_sel<2:0> == 3b'001, then internal divider value == 80
+ */
+#define  PHY_FDIV_FRACT_0_1		GENMASK(14, 13)
+/*
+ * pll divider value selection
+ * 1: divider value will choose internal default value ,dependent on freq_sel<1:0>
+ * 0: divider value will be over ride by fdiv_reg<21:0>
+ */
+#define  PHY_DIV_LOCAL_EN		BIT(15)
+
+#define  PHY_SEL_FREQ_24MHZ		0x01
+#define  FDIV_REG_MASK			(PHY_FDIV_FRACT_20_21 | PHY_FDIV_FRACT_16_19 | \
+					 PHY_FDIV_FRACT_8_15)
+#define  FDIV_REG_VAL			0x1ec4		/* 0x100 selects 24MHz, rest are default */
+
+#define K1_USB2PHY_RESET_TIME_MS	50
+
+struct spacemit_usb2phy {
+	struct phy *phy;
+	struct clk *clk;
+	struct regmap *regmap_base;
+};
+
+static const struct regmap_config phy_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x200,
+};
+
+static int spacemit_usb2phy_init(struct phy *phy)
+{
+	struct spacemit_usb2phy *sphy = phy_get_drvdata(phy);
+	struct regmap *map = sphy->regmap_base;
+	u32 val;
+	int ret;
+
+	ret = clk_enable(sphy->clk);
+	if (ret) {
+		dev_err(&phy->dev, "failed to enable clock\n");
+		clk_disable(sphy->clk);
+		return ret;
+	}
+
+	/*
+	 * make sure the usb controller is not under reset process before
+	 * any configuration
+	 */
+	usleep_range(150, 200);
+
+	/* 24M ref clk */
+	val = FIELD_PREP(FDIV_REG_MASK, FDIV_REG_VAL) |
+	      FIELD_PREP(PHY_FDIV_FRACT_0_1, PHY_SEL_FREQ_24MHZ) |
+	      PHY_DIV_LOCAL_EN;
+	regmap_write(map, PHY_PLL_DIV_CFG, val);
+
+	ret = regmap_read_poll_timeout(map, PHY_RST_MODE_CTRL, val,
+				       (val & PHY_PLL_RDY),
+				       500, K1_USB2PHY_RESET_TIME_MS * 1000);
+	if (ret) {
+		dev_err(&phy->dev, "wait PLLREADY timeout\n");
+		clk_disable(sphy->clk);
+		return ret;
+	}
+
+	/* release usb2 phy internal reset and enable clock gating */
+	val = (PHY_INIT_MODE_BITS | PHY_CLK_ENABLE_BITS | PHY_DEASSERT_RST_BITS);
+	regmap_write(map, PHY_RST_MODE_CTRL, val);
+
+	val = (PHY_HSTXP_RSTN | PHY_CLK_HSTXP_EN | PHY_HSTXP_MODE);
+	regmap_write(map, PHY_HSTXP_HW_CTRL, val);
+
+	/* auto clear host disc */
+	regmap_update_bits(map, PHY_TX_HOST_CTRL, PHY_HST_DISC_AUTO_CLR,
+			   PHY_HST_DISC_AUTO_CLR);
+
+	return 0;
+}
+
+static int spacemit_usb2phy_exit(struct phy *phy)
+{
+	struct spacemit_usb2phy *sphy = phy_get_drvdata(phy);
+
+	clk_disable(sphy->clk);
+
+	return 0;
+}
+
+static const struct phy_ops spacemit_usb2phy_ops = {
+	.init = spacemit_usb2phy_init,
+	.exit = spacemit_usb2phy_exit,
+	.owner = THIS_MODULE,
+};
+
+static int spacemit_usb2phy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct spacemit_usb2phy *sphy;
+	void __iomem *base;
+
+	sphy = devm_kzalloc(dev, sizeof(*sphy), GFP_KERNEL);
+	if (!sphy)
+		return -ENOMEM;
+
+	sphy->clk = devm_clk_get_prepared(&pdev->dev, NULL);
+	if (IS_ERR(sphy->clk))
+		return dev_err_probe(dev, PTR_ERR(sphy->clk), "Failed to get clock\n");
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	sphy->regmap_base = devm_regmap_init_mmio(dev, base, &phy_regmap_config);
+	if (IS_ERR(sphy->regmap_base))
+		return dev_err_probe(dev, PTR_ERR(sphy->regmap_base), "Failed to init regmap\n");
+
+	sphy->phy = devm_phy_create(dev, NULL, &spacemit_usb2phy_ops);
+	if (IS_ERR(sphy->phy))
+		return dev_err_probe(dev, PTR_ERR(sphy->phy), "Failed to create phy\n");
+
+	phy_set_drvdata(sphy->phy, sphy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id spacemit_usb2phy_dt_match[] = {
+	{ .compatible = "spacemit,k1-usb2-phy", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, spacemit_usb2phy_dt_match);
+
+static struct platform_driver spacemit_usb2_phy_driver = {
+	.probe	= spacemit_usb2phy_probe,
+	.driver = {
+		.name   = "spacemit-usb2-phy",
+		.of_match_table = spacemit_usb2phy_dt_match,
+	},
+};
+module_platform_driver(spacemit_usb2_phy_driver);
+
+MODULE_DESCRIPTION("Spacemit USB 2.0 PHY driver");
+MODULE_LICENSE("GPL");

-- 
2.51.1.dirty


