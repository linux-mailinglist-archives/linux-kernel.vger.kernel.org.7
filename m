Return-Path: <linux-kernel+bounces-851118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1050ABD5963
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B383BE581
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AF42459C9;
	Mon, 13 Oct 2025 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzy1Iyfn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56F2C3254;
	Mon, 13 Oct 2025 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377681; cv=none; b=gWgHkp8uwWTIJcIlkW6cJDbhvVUA2WPX8HPuAL/+bFBNdEyPxEGfBz3FHjR9dg9yhbU7LjYESPRm1lA0DOijziVFX9DBzJFQBtvZIp+8Jw5N8LE8yf3Lg82WmQJ5a1K7Tty33lLuJHwDICdZ/2qWQE99Wc6iNXPOTllL5w+e0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377681; c=relaxed/simple;
	bh=UhdZWEJqTaXoG+KGtMhkw3hvhO/326WPdw06H5t0h0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSURLeCEBAY0PT/ybww+MLBg7Nd11F9W+ET1V5qVdkmTe32uYBQR3E+lisi2MMf/Wz9r4XLl3nTMp5wSawfxYR/+8dYALBSG4xUuTZVeoPHR4xpsoqihglSFJNP8YJwUsCtWzSGbrgjqpdS1Cwr6bvbaRHCamiLnlTvupk6tNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzy1Iyfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10E9C4CEE7;
	Mon, 13 Oct 2025 17:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377680;
	bh=UhdZWEJqTaXoG+KGtMhkw3hvhO/326WPdw06H5t0h0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzy1Iyfng5jJSuQu7buDtUiKcPA7x5nhEm3E7c0SiPqI/WKxlTu5knzPj1VRoq7YU
	 JJUMu3u9bjp+EOLaoczSwswP1zdidBWSo/qNpJ0Ooz6y9IPuOebbzk9yXqcMoQ7HYd
	 aPs1RoJLZuTU4teT+dasqSMQdap2wlc7y2UXaw5Mg+7X7RtbGKBeCc+PwzC0ytuHas
	 rDFBazujNmEVAesEnXDkOkAe/AX19YmewOzQY1B4ZSq+orOs5PRAzLytEw/wx0ls3F
	 GI0UF27ixhK/2d3aOG6Ol+CsoXka9Ebw11SGqb6XpAk2UZFGYQ1P498Vpd5hNSLv1e
	 6hYbnK3NxSLiA==
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
Subject: [PATCH v5 5/9] clk: microchip: mpfs: use regmap for clocks
Date: Mon, 13 Oct 2025 18:45:37 +0100
Message-ID: <20251013-undercook-flatfoot-70dca974cd19@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013-album-bovine-faf9f5ebc5d4@spud>
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12719; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=tKeSiWQ6AV92c0bFuS+NXSiRQH403qtpuI89XqsoORk=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlvrQ5YMp+a6HR+YZ0OfzxH974/X7aKWE7omN/kv/WfT faNx6cWdpSyMIhxMciKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiu9wZGWa9npSyP2Fe2IKp jbJcUZzsFlde3IrQ4ZHiXrN06+5D6yYz/M9LdzmiYmgjJ/vFO7PM9dNp9Rs1SvsTHLSfreatf+d cxwQA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Convert the PolarFire SoC clock driver to use regmaps instead of iomem
addresses as a preparatory work for supporting the new binding for this
device that will only provide the second of the two register regions, and
will require the use of syscon regmap to access the "cfg" and "periph"
clocks currently supported by the driver.

This is effectively a revert of commit 4da2404bb003 ("clk: microchip:
mpfs: convert cfg_clk to clk_divider") and commit d815569783e6 ("clk:
microchip: mpfs: convert periph_clk to clk_gate") as it resurrects the
ops structures removed in those commits, with the readl()s and
writel()s replaced by regmap_read()s and regmap_writes()s.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/Kconfig    |   2 +
 drivers/clk/microchip/clk-mpfs.c | 250 ++++++++++++++++++++++++++-----
 2 files changed, 211 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/microchip/Kconfig b/drivers/clk/microchip/Kconfig
index 0724ce65898f..1b9e43eb5497 100644
--- a/drivers/clk/microchip/Kconfig
+++ b/drivers/clk/microchip/Kconfig
@@ -7,6 +7,8 @@ config MCHP_CLK_MPFS
 	bool "Clk driver for PolarFire SoC"
 	depends on ARCH_MICROCHIP_POLARFIRE || COMPILE_TEST
 	default ARCH_MICROCHIP_POLARFIRE
+	depends on MFD_SYSCON
 	select AUXILIARY_BUS
+	select REGMAP_MMIO
 	help
 	  Supports Clock Configuration for PolarFire SoC
diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index c22632a7439c..e3362be9b266 100644
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
 
+static const struct regmap_config mpfs_clk_regmap_config = {
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
@@ -67,18 +78,37 @@ struct mpfs_msspll_out_hw_clock {
 
 #define to_mpfs_msspll_out_clk(_hw) container_of(_hw, struct mpfs_msspll_out_hw_clock, hw)
 
+struct mpfs_cfg_clock {
+	struct regmap *map;
+	const struct clk_div_table *table;
+	u8 map_offset;
+	u8 shift;
+	u8 width;
+	u8 flags;
+};
+
 struct mpfs_cfg_hw_clock {
-	struct clk_divider cfg;
-	struct clk_init_data init;
+	struct mpfs_cfg_clock cfg;
+	struct clk_hw hw;
 	unsigned int id;
-	u32 reg_offset;
+};
+
+#define to_mpfs_cfg_clk(_hw) container_of(_hw, struct mpfs_cfg_hw_clock, hw)
+
+struct mpfs_periph_clock {
+	struct regmap *map;
+	u8 map_offset;
+	u8 shift;
 };
 
 struct mpfs_periph_hw_clock {
-	struct clk_gate periph;
+	struct mpfs_periph_clock periph;
+	struct clk_hw hw;
 	unsigned int id;
 };
 
+#define to_mpfs_periph_clk(_hw) container_of(_hw, struct mpfs_periph_hw_clock, hw)
+
 /*
  * mpfs_clk_lock prevents anything else from writing to the
  * mpfs clk block while a software locked register is being written.
@@ -219,16 +249,66 @@ static int mpfs_clk_register_msspll_outs(struct device *dev,
 /*
  * "CFG" clocks
  */
+static unsigned long mpfs_cfg_clk_recalc_rate(struct clk_hw *hw, unsigned long prate)
+{
+	struct mpfs_cfg_hw_clock *cfg_hw = to_mpfs_cfg_clk(hw);
+	struct mpfs_cfg_clock *cfg = &cfg_hw->cfg;
+	u32 val;
 
-#define CLK_CFG(_id, _name, _parent, _shift, _width, _table, _flags, _offset) {		\
-	.id = _id,									\
-	.cfg.shift = _shift,								\
-	.cfg.width = _width,								\
-	.cfg.table = _table,								\
-	.reg_offset = _offset,								\
-	.cfg.flags = _flags,								\
-	.cfg.hw.init = CLK_HW_INIT(_name, _parent, &clk_divider_ops, 0),		\
-	.cfg.lock = &mpfs_clk_lock,							\
+	regmap_read(cfg->map, cfg->map_offset, &val);
+	val >>= cfg->shift;
+	val &= clk_div_mask(cfg->width);
+
+	return divider_recalc_rate(hw, prate, val, cfg->table, cfg->flags, cfg->width);
+}
+
+static long mpfs_cfg_clk_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *prate)
+{
+	struct mpfs_cfg_hw_clock *cfg_hw = to_mpfs_cfg_clk(hw);
+	struct mpfs_cfg_clock *cfg = &cfg_hw->cfg;
+
+	return divider_round_rate(hw, rate, prate, cfg->table, cfg->width, 0);
+}
+
+static int mpfs_cfg_clk_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long prate)
+{
+	struct mpfs_cfg_hw_clock *cfg_hw = to_mpfs_cfg_clk(hw);
+	struct mpfs_cfg_clock *cfg = &cfg_hw->cfg;
+	unsigned long flags;
+	u32 val;
+	int divider_setting;
+
+	divider_setting = divider_get_val(rate, prate, cfg->table, cfg->width, 0);
+
+	if (divider_setting < 0)
+		return divider_setting;
+
+	spin_lock_irqsave(&mpfs_clk_lock, flags);
+
+	regmap_read(cfg->map, cfg->map_offset, &val);
+	val &= ~(clk_div_mask(cfg->width) << cfg_hw->cfg.shift);
+	val |= divider_setting << cfg->shift;
+	regmap_write(cfg->map, cfg->map_offset, val);
+
+	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops mpfs_clk_cfg_ops = {
+	.recalc_rate = mpfs_cfg_clk_recalc_rate,
+	.round_rate = mpfs_cfg_clk_round_rate,
+	.set_rate = mpfs_cfg_clk_set_rate,
+};
+
+#define CLK_CFG(_id, _name, _parent, _shift, _width, _table, _flags, _offset) {	\
+	.id = _id,								\
+	.cfg.shift = _shift,							\
+	.cfg.width = _width,							\
+	.cfg.table = _table,							\
+	.cfg.map_offset = _offset,						\
+	.cfg.flags = _flags,							\
+	.hw.init = CLK_HW_INIT(_name, _parent, &mpfs_clk_cfg_ops, 0),		\
 }
 
 #define CLK_CPU_OFFSET		0u
@@ -248,10 +328,10 @@ static struct mpfs_cfg_hw_clock mpfs_cfg_clks[] = {
 		.cfg.shift = 0,
 		.cfg.width = 12,
 		.cfg.table = mpfs_div_rtcref_table,
-		.reg_offset = REG_RTC_CLOCK_CR,
+		.cfg.map_offset = REG_RTC_CLOCK_CR,
 		.cfg.flags = CLK_DIVIDER_ONE_BASED,
-		.cfg.hw.init =
-			CLK_HW_INIT_PARENTS_DATA("clk_rtcref", mpfs_ext_ref, &clk_divider_ops, 0),
+		.hw.init =
+			CLK_HW_INIT_PARENTS_DATA("clk_rtcref", mpfs_ext_ref, &mpfs_clk_cfg_ops, 0),
 	}
 };
 
@@ -264,14 +344,14 @@ static int mpfs_clk_register_cfgs(struct device *dev, struct mpfs_cfg_hw_clock *
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_cfg_hw_clock *cfg_hw = &cfg_hws[i];
 
-		cfg_hw->cfg.reg = data->base + cfg_hw->reg_offset;
-		ret = devm_clk_hw_register(dev, &cfg_hw->cfg.hw);
+		cfg_hw->cfg.map = data->regmap;
+		ret = devm_clk_hw_register(dev, &cfg_hw->hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     cfg_hw->id);
 
 		id = cfg_hw->id;
-		data->hw_data.hws[id] = &cfg_hw->cfg.hw;
+		data->hw_data.hws[id] = &cfg_hw->hw;
 	}
 
 	return 0;
@@ -281,15 +361,67 @@ static int mpfs_clk_register_cfgs(struct device *dev, struct mpfs_cfg_hw_clock *
  * peripheral clocks - devices connected to axi or ahb buses.
  */
 
-#define CLK_PERIPH(_id, _name, _parent, _shift, _flags) {			\
-	.id = _id,								\
-	.periph.bit_idx = _shift,						\
-	.periph.hw.init = CLK_HW_INIT_HW(_name, _parent, &clk_gate_ops,		\
-				  _flags),					\
-	.periph.lock = &mpfs_clk_lock,						\
+static int mpfs_periph_clk_enable(struct clk_hw *hw)
+{
+	struct mpfs_periph_hw_clock *periph_hw = to_mpfs_periph_clk(hw);
+	struct mpfs_periph_clock *periph = &periph_hw->periph;
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpfs_clk_lock, flags);
+
+	regmap_read(periph->map, periph->map_offset, &val);
+	val |= 1u << periph->shift;
+	regmap_write(periph->map, periph->map_offset, val);
+
+	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
+
+	return 0;
 }
 
-#define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT##_OFFSET].cfg.hw)
+static void mpfs_periph_clk_disable(struct clk_hw *hw)
+{
+	struct mpfs_periph_hw_clock *periph_hw = to_mpfs_periph_clk(hw);
+	struct mpfs_periph_clock *periph = &periph_hw->periph;
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpfs_clk_lock, flags);
+
+	regmap_read(periph->map, periph->map_offset, &val);
+	val &= ~(1u << periph->shift);
+	regmap_write(periph->map, periph->map_offset, val);
+
+	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
+}
+
+static int mpfs_periph_clk_is_enabled(struct clk_hw *hw)
+{
+	struct mpfs_periph_hw_clock *periph_hw = to_mpfs_periph_clk(hw);
+	struct mpfs_periph_clock *periph = &periph_hw->periph;
+	u32 val;
+
+	regmap_read(periph->map, periph->map_offset, &val);
+	if (val & (1u << periph->shift))
+		return 1;
+
+	return 0;
+}
+
+static const struct clk_ops mpfs_periph_clk_ops = {
+	.enable = mpfs_periph_clk_enable,
+	.disable = mpfs_periph_clk_disable,
+	.is_enabled = mpfs_periph_clk_is_enabled,
+};
+
+#define CLK_PERIPH(_id, _name, _parent, _shift, _flags) {				\
+	.id = _id,									\
+	.periph.map_offset = REG_SUBBLK_CLOCK_CR,					\
+	.periph.shift = _shift,								\
+	.hw.init = CLK_HW_INIT_HW(_name, _parent, &mpfs_periph_clk_ops, _flags),	\
+}
+
+#define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT##_OFFSET].hw)
 
 /*
  * Critical clocks:
@@ -346,19 +478,60 @@ static int mpfs_clk_register_periphs(struct device *dev, struct mpfs_periph_hw_c
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_periph_hw_clock *periph_hw = &periph_hws[i];
 
-		periph_hw->periph.reg = data->base + REG_SUBBLK_CLOCK_CR;
-		ret = devm_clk_hw_register(dev, &periph_hw->periph.hw);
+		periph_hw->periph.map = data->regmap;
+		ret = devm_clk_hw_register(dev, &periph_hw->hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
 					     periph_hw->id);
 
 		id = periph_hws[i].id;
-		data->hw_data.hws[id] = &periph_hw->periph.hw;
+		data->hw_data.hws[id] = &periph_hw->hw;
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
+	clk_data->regmap = devm_regmap_init_mmio(dev, clk_data->base, &mpfs_clk_regmap_config);
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
@@ -374,13 +547,12 @@ static int mpfs_clk_probe(struct platform_device *pdev)
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
@@ -406,11 +578,7 @@ static int mpfs_clk_probe(struct platform_device *pdev)
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
2.51.0


