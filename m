Return-Path: <linux-kernel+bounces-794386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCC9B3E0FB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF97F3B3E05
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFC9310783;
	Mon,  1 Sep 2025 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDain+GJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D108311C35;
	Mon,  1 Sep 2025 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724731; cv=none; b=MvvaIrZq2eCTiw148pGljEGOd3Zk3y/YjK3Yc3zUnAXSPvyGUcTn3xX6hc5iOVgd4rMvcPSzh0V6Qajif9PSd133GcgG5bm3L6qxoZONuQkF4ekboo4lBGdfFvD0h2dQZsd+iEdHvf4mjogyL2afZqiBI1XrlwOoKyA274R/plg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724731; c=relaxed/simple;
	bh=HrI7jlnnPgcTQ8EFovqHABHWUVM0AiXHJCDj0x1/d0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGZWDKQ2IdSaHi47H4Ki3UJQtBhRwMmtU3nFM/R5jA5wZWMZqOjI0sN6pHcr5xrjlPun3IrXupZd8mlXECRYNv836V93OvO59EVKmmXlVlG2XLy82zwmY8/pzF2k3uFXNLAPrFGWKCSrxsTjYjONAsPPe9AdGcsZmJ8BxumCfvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDain+GJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAB5C4CEF4;
	Mon,  1 Sep 2025 11:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756724730;
	bh=HrI7jlnnPgcTQ8EFovqHABHWUVM0AiXHJCDj0x1/d0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDain+GJsLHIWLqaWLpD7Er34lV33PKPhRkXcL9lh8qg063wxXLjlybC9l+OO2Oie
	 FDNjZ/AMbnDUnB+Wjjcec6yBpxvgkwFfXOGzHL3nyhLoo1LPej1IMrZaAT7h5WU6rO
	 KLfE8vCM5B3VOeQlIJYCPQoIUGmPZOXlXAkMazpaMz3PndOfCvd/4Bz/HvzrwoWm7o
	 cYmYRWcfbj+ZdrTxrE0elQiU4rR1GDdxBsGUaa9XIS2CQvdwrsGVZqLThj/S4atcIR
	 By8kSJtuv/N247zdFdSLag7MHKTJ35rRHdHBKkXE7UGGFHltXyLRF00EW2AM4JQSRd
	 8z3dgFRjWalrg==
From: Conor Dooley <conor@kernel.org>
To: sboyd@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
Subject: [PATCH v4 9/9] clk: microchip: mpfs: use regmap clock types
Date: Mon,  1 Sep 2025 12:04:21 +0100
Message-ID: <20250901-handful-cardinal-c988f42ac8d9@spud>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901-rigid-sacrifice-0039c6e6234e@spud>
References: <20250901-rigid-sacrifice-0039c6e6234e@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9989; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=0M+Pbcg7JV32uK4PkGDNKNBis48Qjna+wJfnLP00JjM=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlba9efS38iUBgj9j8xiXGXkWP0AqNYeZMrPy7uXLK0c LbZdG2tjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEykxY3hn5r5r9W8PUvu5xfy xK64YP8qa5/vB4c7LflrGs+zflf9H8LIsNd1goPoi5wdt9c9ehcZof9qMXsQ0zGpwpV9Rx84cG6 YxgQA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Convert the PolarFire SoC clock driver to use regmap clock types as a
preparatory work for supporting the new binding for this device that
will only provide the second of the two register regions, and will
require the use of syscon regmap to access the "cfg" and "periph" clocks
currently supported by the driver.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/Kconfig    |   3 +
 drivers/clk/microchip/clk-mpfs.c | 151 ++++++++++++++++++++-----------
 2 files changed, 100 insertions(+), 54 deletions(-)

diff --git a/drivers/clk/microchip/Kconfig b/drivers/clk/microchip/Kconfig
index 0724ce65898f3..72da1e0f437d9 100644
--- a/drivers/clk/microchip/Kconfig
+++ b/drivers/clk/microchip/Kconfig
@@ -7,6 +7,9 @@ config MCHP_CLK_MPFS
 	bool "Clk driver for PolarFire SoC"
 	depends on ARCH_MICROCHIP_POLARFIRE || COMPILE_TEST
 	default ARCH_MICROCHIP_POLARFIRE
+	depends on MFD_SYSCON
 	select AUXILIARY_BUS
+	select COMMON_CLK_REGMAP
+	select REGMAP_MMIO
 	help
 	  Supports Clock Configuration for PolarFire SoC
diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index c22632a7439c5..c7fec0fcbe379 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -6,8 +6,10 @@
  */
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <dt-bindings/clock/microchip,mpfs-clock.h>
 #include <soc/microchip/mpfs.h>
 
@@ -30,6 +32,14 @@
 #define MSSPLL_POSTDIV_WIDTH	0x07u
 #define MSSPLL_FIXED_DIV	4u
 
+static const struct regmap_config clk_mpfs_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.max_register = REG_SUBBLK_CLOCK_CR,
+};
+
 /*
  * This clock ID is defined here, rather than the binding headers, as it is an
  * internal clock only, and therefore has no consumers in other peripheral
@@ -39,6 +49,7 @@
 
 struct mpfs_clock_data {
 	struct device *dev;
+	struct regmap *regmap;
 	void __iomem *base;
 	void __iomem *msspll_base;
 	struct clk_hw_onecell_data hw_data;
@@ -68,14 +79,12 @@ struct mpfs_msspll_out_hw_clock {
 #define to_mpfs_msspll_out_clk(_hw) container_of(_hw, struct mpfs_msspll_out_hw_clock, hw)
 
 struct mpfs_cfg_hw_clock {
-	struct clk_divider cfg;
-	struct clk_init_data init;
+	struct clk_divider_regmap divider;
 	unsigned int id;
-	u32 reg_offset;
 };
 
 struct mpfs_periph_hw_clock {
-	struct clk_gate periph;
+	struct clk_gate_regmap gate;
 	unsigned int id;
 };
 
@@ -172,15 +181,15 @@ static int mpfs_clk_register_mssplls(struct device *dev, struct mpfs_msspll_hw_c
  * MSS PLL output clocks
  */
 
-#define CLK_PLL_OUT(_id, _name, _parent, _flags, _shift, _width, _offset) {	\
-	.id = _id,								\
-	.output.shift = _shift,							\
-	.output.width = _width,							\
-	.output.table = NULL,							\
-	.reg_offset = _offset,							\
-	.output.flags = _flags,							\
-	.output.hw.init = CLK_HW_INIT(_name, _parent, &clk_divider_ops, 0),	\
-	.output.lock = &mpfs_clk_lock,						\
+#define CLK_PLL_OUT(_id, _name, _parent, _flags, _shift, _width, _offset) {		\
+	.id = _id,									\
+	.output.shift = _shift,								\
+	.output.width = _width,								\
+	.output.table = NULL,								\
+	.reg_offset = _offset,								\
+	.output.flags = _flags,								\
+	.output.hw.init = CLK_HW_INIT(_name, _parent, &clk_divider_regmap_ops, 0),	\
+	.output.lock = &mpfs_clk_lock,							\
 }
 
 static struct mpfs_msspll_out_hw_clock mpfs_msspll_out_clks[] = {
@@ -220,15 +229,14 @@ static int mpfs_clk_register_msspll_outs(struct device *dev,
  * "CFG" clocks
  */
 
-#define CLK_CFG(_id, _name, _parent, _shift, _width, _table, _flags, _offset) {		\
-	.id = _id,									\
-	.cfg.shift = _shift,								\
-	.cfg.width = _width,								\
-	.cfg.table = _table,								\
-	.reg_offset = _offset,								\
-	.cfg.flags = _flags,								\
-	.cfg.hw.init = CLK_HW_INIT(_name, _parent, &clk_divider_ops, 0),		\
-	.cfg.lock = &mpfs_clk_lock,							\
+#define CLK_CFG(_id, _name, _parent, _shift, _width, _table, _flags, _offset) {	\
+	.id = _id,								\
+	.divider.shift = _shift,						\
+	.divider.width = _width,						\
+	.divider.table = _table,						\
+	.divider.map_offset = _offset,						\
+	.divider.flags = _flags,						\
+	.divider.hw.init = CLK_HW_INIT(_name, _parent, &clk_divider_regmap_ops, 0),	\
 }
 
 #define CLK_CPU_OFFSET		0u
@@ -245,13 +253,13 @@ static struct mpfs_cfg_hw_clock mpfs_cfg_clks[] = {
 		REG_CLOCK_CONFIG_CR),
 	{
 		.id = CLK_RTCREF,
-		.cfg.shift = 0,
-		.cfg.width = 12,
-		.cfg.table = mpfs_div_rtcref_table,
-		.reg_offset = REG_RTC_CLOCK_CR,
-		.cfg.flags = CLK_DIVIDER_ONE_BASED,
-		.cfg.hw.init =
-			CLK_HW_INIT_PARENTS_DATA("clk_rtcref", mpfs_ext_ref, &clk_divider_ops, 0),
+		.divider.shift = 0,
+		.divider.width = 12,
+		.divider.table = mpfs_div_rtcref_table,
+		.divider.map_offset = REG_RTC_CLOCK_CR,
+		.divider.flags = CLK_DIVIDER_ONE_BASED,
+		.divider.hw.init =
+			CLK_HW_INIT_PARENTS_DATA("clk_rtcref", mpfs_ext_ref, &clk_divider_regmap_ops, 0),
 	}
 };
 
@@ -264,14 +272,14 @@ static int mpfs_clk_register_cfgs(struct device *dev, struct mpfs_cfg_hw_clock *
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_cfg_hw_clock *cfg_hw = &cfg_hws[i];
 
-		cfg_hw->cfg.reg = data->base + cfg_hw->reg_offset;
-		ret = devm_clk_hw_register(dev, &cfg_hw->cfg.hw);
+		cfg_hw->divider.regmap = data->regmap;
+		ret = devm_clk_hw_register(dev, &cfg_hw->divider.hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     cfg_hw->id);
 
 		id = cfg_hw->id;
-		data->hw_data.hws[id] = &cfg_hw->cfg.hw;
+		data->hw_data.hws[id] = &cfg_hw->divider.hw;
 	}
 
 	return 0;
@@ -281,15 +289,14 @@ static int mpfs_clk_register_cfgs(struct device *dev, struct mpfs_cfg_hw_clock *
  * peripheral clocks - devices connected to axi or ahb buses.
  */
 
-#define CLK_PERIPH(_id, _name, _parent, _shift, _flags) {			\
-	.id = _id,								\
-	.periph.bit_idx = _shift,						\
-	.periph.hw.init = CLK_HW_INIT_HW(_name, _parent, &clk_gate_ops,		\
-				  _flags),					\
-	.periph.lock = &mpfs_clk_lock,						\
+#define CLK_PERIPH(_id, _name, _parent, _shift, _flags) {				\
+	.id = _id,									\
+	.gate.map_offset = REG_SUBBLK_CLOCK_CR,						\
+	.gate.bit_idx = _shift,								\
+	.gate.hw.init = CLK_HW_INIT_HW(_name, _parent, &clk_gate_regmap_ops, _flags),	\
 }
 
-#define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT##_OFFSET].cfg.hw)
+#define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT##_OFFSET].divider.hw)
 
 /*
  * Critical clocks:
@@ -346,19 +353,60 @@ static int mpfs_clk_register_periphs(struct device *dev, struct mpfs_periph_hw_c
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_periph_hw_clock *periph_hw = &periph_hws[i];
 
-		periph_hw->periph.reg = data->base + REG_SUBBLK_CLOCK_CR;
-		ret = devm_clk_hw_register(dev, &periph_hw->periph.hw);
+		periph_hw->gate.map = data->regmap;
+		ret = devm_clk_hw_register(dev, &periph_hw->gate.hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     periph_hw->id);
 
 		id = periph_hws[i].id;
-		data->hw_data.hws[id] = &periph_hw->periph.hw;
+		data->hw_data.hws[id] = &periph_hw->gate.hw;
 	}
 
 	return 0;
 }
 
+static inline int mpfs_clk_syscon_probe(struct mpfs_clock_data *clk_data,
+					struct platform_device *pdev)
+{
+	clk_data->regmap = syscon_regmap_lookup_by_compatible("microchip,mpfs-mss-top-sysreg");
+	if (IS_ERR(clk_data->regmap))
+		return PTR_ERR(clk_data->regmap);
+
+	clk_data->msspll_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(clk_data->msspll_base))
+		return PTR_ERR(clk_data->msspll_base);
+
+	return 0;
+}
+
+static inline int mpfs_clk_old_format_probe(struct mpfs_clock_data *clk_data,
+					    struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	dev_warn(&pdev->dev, "falling back to old devicetree format");
+
+	clk_data->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(clk_data->base))
+		return PTR_ERR(clk_data->base);
+
+	clk_data->msspll_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(clk_data->msspll_base))
+		return PTR_ERR(clk_data->msspll_base);
+
+	clk_data->regmap = devm_regmap_init_mmio(dev, clk_data->base, &clk_mpfs_regmap_config);
+	if (IS_ERR(clk_data->regmap))
+		return PTR_ERR(clk_data->regmap);
+
+	ret = mpfs_reset_controller_register(dev, clk_data->base + REG_SUBBLK_RESET_CR);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int mpfs_clk_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -374,13 +422,12 @@ static int mpfs_clk_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	clk_data->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(clk_data->base))
-		return PTR_ERR(clk_data->base);
-
-	clk_data->msspll_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(clk_data->msspll_base))
-		return PTR_ERR(clk_data->msspll_base);
+	ret = mpfs_clk_syscon_probe(clk_data, pdev);
+	if (ret) {
+		ret = mpfs_clk_old_format_probe(clk_data, pdev);
+		if (ret)
+			return ret;
+	}
 
 	clk_data->hw_data.num = num_clks;
 	clk_data->dev = dev;
@@ -406,11 +453,7 @@ static int mpfs_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, &clk_data->hw_data);
-	if (ret)
-		return ret;
-
-	return mpfs_reset_controller_register(dev, clk_data->base + REG_SUBBLK_RESET_CR);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, &clk_data->hw_data);
 }
 
 static const struct of_device_id mpfs_clk_of_match_table[] = {
-- 
2.47.2


