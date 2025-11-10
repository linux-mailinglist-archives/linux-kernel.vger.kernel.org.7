Return-Path: <linux-kernel+bounces-892961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E83D2C4637E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 062B54EA901
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A69F211A14;
	Mon, 10 Nov 2025 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOcmLUC3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2409309F07;
	Mon, 10 Nov 2025 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773846; cv=none; b=KEfkxN2gBpZgazOXUjA7Ca5ayLVvk2h+dMTXZgYUocySQdd+nPnbfb4b+uLQuYYQ1dnYOgAeKl6TgPp+OsKgrrgc45NatKROrkE/VAlq0xZEF54RmmSDMH6GeyZxFgYQBxGnsrjFhPLDGuIArKY8ocCtGIadoCkjYzGRmWQXYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773846; c=relaxed/simple;
	bh=CmXoBLuxUJoBzrxKmX5dd5XpWc+0xXD7kEShU5FrSRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSY+vvkYkqYraTVAlvmHxm9tDIV2Qny+uQkNzSJb6EglVU/HF3RE+RUVxVxa41vX/28gP1ejXq31EdsPdg/OpkJw1w19cWFD739iRUBt1mKm3wDMDEi/mz4JBB3Z5Q5lwpIrQ1vZjSYmr7NkatxpVopMcscjw1ilFMDX0499BnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOcmLUC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D840C19421;
	Mon, 10 Nov 2025 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773846;
	bh=CmXoBLuxUJoBzrxKmX5dd5XpWc+0xXD7kEShU5FrSRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOcmLUC3TrceYQ9JL7asupXpkrb/756TEH+Xu73myypmYEpbqoPLK3ZbmgBwO6aYT
	 N+39PJS2+9c7p3RrBu5cbxO9Xo7AxPGAQGMcU5gXMOwdaDgeEmcN9WM6VEL8KK9eo9
	 ubzxGpHxR0rsRhOziFnSM13Nfc919qqhAHBBKRoMGMF0BmOcj6VYJsAMEZqDabD1oL
	 fIeqX3662wW0GdADVAn8WPI13+IRnEFcAlvlERk4XchZjLo4mV2LS7vNWdyalFX2qX
	 rUOANWMairTSFYfZtka8Ptejx5RvcEIs+68F6fE3Bmst7PHjsNXLuBd3EeqCFyS0O2
	 KVNV+9pV414EQ==
From: Conor Dooley <conor@kernel.org>
To: claudiu.beznea@tuxon.dev
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/5] reset: mpfs: add non-auxiliary bus probing
Date: Mon, 10 Nov 2025 11:23:50 +0000
Message-ID: <20251110-evict-gratified-bb816e2799a2@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110-zookeeper-femur-68a0ae346397@spud>
References: <20251110-zookeeper-femur-68a0ae346397@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8983; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=clSSL3dc+HDx0t1TsHPtxBl7W72R564AkCTNoIHCzak=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJmCp93nVaacL9yoH7+CO8mVPXGmY8sNDXaVn9WfLYr86 7Qfij3uKGVhEONikBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwEQuHmT4wxHiXbZgk2ftxMYf 3gxR1vdW5r9Rj79ep6e+56E078dN2xn+aTh9kg9a8HDWY4edhaohIlqsvbMMu0seeQqfLq06lvq VGwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

While the auxiliary bus was a nice bandaid, and meant that re-writing
the representation of the clock regions in devicetree was not required,
it has run its course. The "mss_top_sysreg" region that contains the
clock and reset regions, also contains pinctrl and an interrupt
controller, so the time has come rewrite the devicetree and probe the
reset controller from an mfd devicetree node, rather than implement
those drivers using the auxiliary bus. Wanting to avoid propagating this
naive/incorrect description of the hardware to the new pic64gx SoC is a
major motivating factor here.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v7:
- move entirely to regmap
- use clear/set instead of update

v6:
- depend on MFD_SYSCON
- return regmap_update_bits() result directly instead of an additional
  return 0

v4:
- Only use driver specific lock for non-regmap writes

v2:
- Implement the request to use regmap_update_bits(). I found that I then
  hated the read/write helpers since they were just bloat, so I ripped
  them out. I replaced the regular spin_lock_irqsave() stuff with a
  guard(spinlock_irqsave), since that's a simpler way of handling the two
  different paths through such a trivial pair of functions.
---
 drivers/clk/microchip/clk-mpfs.c |  4 +-
 drivers/reset/Kconfig            |  1 +
 drivers/reset/reset-mpfs.c       | 92 +++++++++++++++++++-------------
 include/soc/microchip/mpfs.h     |  3 +-
 4 files changed, 61 insertions(+), 39 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 484893e68b67..ee58304913ef 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -38,7 +38,7 @@ static const struct regmap_config mpfs_clk_regmap_config = {
 	.reg_stride = 4,
 	.val_bits = 32,
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
-	.max_register = REG_SUBBLK_CLOCK_CR,
+	.max_register = REG_SUBBLK_RESET_CR,
 };
 
 /*
@@ -502,7 +502,7 @@ static inline int mpfs_clk_old_format_probe(struct mpfs_clock_data *clk_data,
 	if (IS_ERR(clk_data->regmap))
 		return PTR_ERR(clk_data->regmap);
 
-	return mpfs_reset_controller_register(dev, clk_data->base + REG_SUBBLK_RESET_CR);
+	return mpfs_reset_controller_register(dev, clk_data->regmap);
 }
 
 static int mpfs_clk_probe(struct platform_device *pdev)
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 78b7078478d4..0ec4b7cd08d6 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -200,6 +200,7 @@ config RESET_PISTACHIO
 config RESET_POLARFIRE_SOC
 	bool "Microchip PolarFire SoC (MPFS) Reset Driver"
 	depends on MCHP_CLK_MPFS
+	depends on MFD_SYSCON
 	select AUXILIARY_BUS
 	default MCHP_CLK_MPFS
 	help
diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
index f6fa10e03ea8..d00212450990 100644
--- a/drivers/reset/reset-mpfs.c
+++ b/drivers/reset/reset-mpfs.c
@@ -7,13 +7,16 @@
  *
  */
 #include <linux/auxiliary_bus.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
+#include <linux/regmap.h>
 #include <linux/reset-controller.h>
+#include <linux/slab.h>
 #include <dt-bindings/clock/microchip,mpfs-clock.h>
 #include <soc/microchip/mpfs.h>
 
@@ -27,11 +30,10 @@
 #define MPFS_SLEEP_MIN_US	100
 #define MPFS_SLEEP_MAX_US	200
 
-/* block concurrent access to the soft reset register */
-static DEFINE_SPINLOCK(mpfs_reset_lock);
+#define REG_SUBBLK_RESET_CR	0x88u
 
 struct mpfs_reset {
-	void __iomem *base;
+	struct regmap *regmap;
 	struct reset_controller_dev rcdev;
 };
 
@@ -46,41 +48,25 @@ static inline struct mpfs_reset *to_mpfs_reset(struct reset_controller_dev *rcde
 static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
-	unsigned long flags;
-	u32 reg;
 
-	spin_lock_irqsave(&mpfs_reset_lock, flags);
+	return regmap_set_bits(rst->regmap, REG_SUBBLK_RESET_CR, BIT(id));
 
-	reg = readl(rst->base);
-	reg |= BIT(id);
-	writel(reg, rst->base);
-
-	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
-
-	return 0;
 }
 
 static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
-	unsigned long flags;
-	u32 reg;
 
-	spin_lock_irqsave(&mpfs_reset_lock, flags);
+	return regmap_clear_bits(rst->regmap, REG_SUBBLK_RESET_CR, BIT(id));
 
-	reg = readl(rst->base);
-	reg &= ~BIT(id);
-	writel(reg, rst->base);
-
-	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
-
-	return 0;
 }
 
 static int mpfs_status(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
-	u32 reg = readl(rst->base);
+	u32 reg;
+
+	regmap_read(rst->regmap, REG_SUBBLK_RESET_CR, &reg);
 
 	/*
 	 * It is safe to return here as MPFS_NUM_RESETS makes sure the sign bit
@@ -130,23 +116,58 @@ static int mpfs_reset_xlate(struct reset_controller_dev *rcdev,
 	return index - MPFS_PERIPH_OFFSET;
 }
 
-static int mpfs_reset_probe(struct auxiliary_device *adev,
-			    const struct auxiliary_device_id *id)
+static int mpfs_reset_mfd_probe(struct platform_device *pdev)
 {
-	struct device *dev = &adev->dev;
 	struct reset_controller_dev *rcdev;
+	struct device *dev = &pdev->dev;
 	struct mpfs_reset *rst;
 
 	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
 	if (!rst)
 		return -ENOMEM;
 
-	rst->base = (void __iomem *)adev->dev.platform_data;
+	rcdev = &rst->rcdev;
+	rcdev->dev = dev;
+	rcdev->ops = &mpfs_reset_ops;
+
+	rcdev->of_node = pdev->dev.parent->of_node;
+	rcdev->of_reset_n_cells = 1;
+	rcdev->of_xlate = mpfs_reset_xlate;
+	rcdev->nr_resets = MPFS_NUM_RESETS;
+
+	rst->regmap = device_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(rst->regmap))
+		return dev_err_probe(dev, PTR_ERR(rst->regmap),
+				     "Failed to find syscon regmap\n");
+
+	return devm_reset_controller_register(dev, rcdev);
+}
+
+static struct platform_driver mpfs_reset_mfd_driver = {
+	.probe = mpfs_reset_mfd_probe,
+	.driver = {
+		.name = "mpfs-reset",
+	},
+};
+module_platform_driver(mpfs_reset_mfd_driver);
+
+static int mpfs_reset_adev_probe(struct auxiliary_device *adev,
+				 const struct auxiliary_device_id *id)
+{
+	struct reset_controller_dev *rcdev;
+	struct device *dev = &adev->dev;
+	struct mpfs_reset *rst;
+
+	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
+	if (!rst)
+		return -ENOMEM;
+
+	rst->regmap = (struct regmap *)adev->dev.platform_data;
 
 	rcdev = &rst->rcdev;
 	rcdev->dev = dev;
-	rcdev->dev->parent = dev->parent;
 	rcdev->ops = &mpfs_reset_ops;
+
 	rcdev->of_node = dev->parent->of_node;
 	rcdev->of_reset_n_cells = 1;
 	rcdev->of_xlate = mpfs_reset_xlate;
@@ -155,12 +176,11 @@ static int mpfs_reset_probe(struct auxiliary_device *adev,
 	return devm_reset_controller_register(dev, rcdev);
 }
 
-int mpfs_reset_controller_register(struct device *clk_dev, void __iomem *base)
+int mpfs_reset_controller_register(struct device *clk_dev, struct regmap *map)
 {
 	struct auxiliary_device *adev;
 
-	adev = devm_auxiliary_device_create(clk_dev, "reset-mpfs",
-					    (__force void *)base);
+	adev = devm_auxiliary_device_create(clk_dev, "reset-mpfs", (void *)map);
 	if (!adev)
 		return -ENODEV;
 
@@ -176,12 +196,12 @@ static const struct auxiliary_device_id mpfs_reset_ids[] = {
 };
 MODULE_DEVICE_TABLE(auxiliary, mpfs_reset_ids);
 
-static struct auxiliary_driver mpfs_reset_driver = {
-	.probe		= mpfs_reset_probe,
+static struct auxiliary_driver mpfs_reset_aux_driver = {
+	.probe		= mpfs_reset_adev_probe,
 	.id_table	= mpfs_reset_ids,
 };
 
-module_auxiliary_driver(mpfs_reset_driver);
+module_auxiliary_driver(mpfs_reset_aux_driver);
 
 MODULE_DESCRIPTION("Microchip PolarFire SoC Reset Driver");
 MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
diff --git a/include/soc/microchip/mpfs.h b/include/soc/microchip/mpfs.h
index 0bd67e10b704..ec04c98a8b63 100644
--- a/include/soc/microchip/mpfs.h
+++ b/include/soc/microchip/mpfs.h
@@ -14,6 +14,7 @@
 
 #include <linux/types.h>
 #include <linux/of_device.h>
+#include <linux/regmap.h>
 
 struct mpfs_sys_controller;
 
@@ -44,7 +45,7 @@ struct mtd_info *mpfs_sys_controller_get_flash(struct mpfs_sys_controller *mpfs_
 
 #if IS_ENABLED(CONFIG_MCHP_CLK_MPFS)
 #if IS_ENABLED(CONFIG_RESET_POLARFIRE_SOC)
-int mpfs_reset_controller_register(struct device *clk_dev, void __iomem *base);
+int mpfs_reset_controller_register(struct device *clk_dev, struct regmap *map);
 #else
 static inline int mpfs_reset_controller_register(struct device *clk_dev, void __iomem *base) { return 0; }
 #endif /* if IS_ENABLED(CONFIG_RESET_POLARFIRE_SOC) */
-- 
2.51.0


