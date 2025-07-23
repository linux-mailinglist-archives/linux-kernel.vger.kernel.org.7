Return-Path: <linux-kernel+bounces-743190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2C5B0FBC5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CA918907A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED2F234973;
	Wed, 23 Jul 2025 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr+T9hWD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE971EE7B7;
	Wed, 23 Jul 2025 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753303102; cv=none; b=ZSHlhz1M0wD1aIqN2UB/JsoZR87ObxPUGN6Ki29FmldYEhxHiEQt7L2Ts/DCwKo/ndZUO4EW0n2gfc0WmRGCPQO9Mim6ohmW2EO4mgngknh23n9vb7y1apqG4j3lbapB++wn6BWpmgd1Uaucb36D/NnO1Fi7wpPUA/ZIvXGIwLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753303102; c=relaxed/simple;
	bh=9HNtOmWOqBA9MDAf1rg0CNb82k9Xilz5R6GgRbnDlKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfvRQJv1UVWRd781f0Eh6JUhuvedNyx0uxObGg1Iy+IFXGj4Fxih6wixkhJPXCuBbfw+Wxo6+gOKtZvs09/ONXJ7znptKZLaEx0wX8YaZPINrQkVrtB4qUfa/ghkT8mLmtXvh9K+er+FZsiqSGp+dPQPs2SkO/MDLcIwwsqz/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr+T9hWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BDDC4CEE7;
	Wed, 23 Jul 2025 20:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753303101;
	bh=9HNtOmWOqBA9MDAf1rg0CNb82k9Xilz5R6GgRbnDlKY=;
	h=From:To:Cc:Subject:Date:From;
	b=Jr+T9hWD8LniYr/imGWg5yglu0MlPbyf+XTZajOitU3qhi8hpp1UmZ7uSIxynVUgc
	 nTc3x/lRMKnEVo4xQjcuRvBxqk7BUGl49RWOL3Jm3niuUIdhLwls8dEQ8O+cbnSSUM
	 KUXScmT9vhG3WyCOym8ubD56mxtqTJF1mXyxCDjF6UepKsNI3DPjETuYn0qGVCfDT3
	 /io46ExPi0lVKHSG0vnKHpGsJJHEm/8TkYXG50zWDudoFjgtciD3Gns1rj08EfwpF2
	 5+JojzFvapkhDnizr+WbN0LyZr/pQ4AAk58bWCHsjKhi+6HUsTDMWIKJAtgDOfgzOZ
	 GPT2ATCyWSURQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] clk: Fix typos
Date: Wed, 23 Jul 2025 15:38:10 -0500
Message-ID: <20250723203819.2910289-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos, mostly in comments except CLKGATE_SEPERATED_* (definition and
uses updated).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/clk/baikal-t1/clk-ccu-div.c            |  2 +-
 drivers/clk/baikal-t1/clk-ccu-pll.c            |  2 +-
 drivers/clk/bcm/clk-bcm2835.c                  |  2 +-
 drivers/clk/bcm/clk-bcm53573-ilp.c             |  2 +-
 drivers/clk/berlin/berlin2-avpll.c             |  2 +-
 drivers/clk/clk-asm9260.c                      |  4 ++--
 drivers/clk/clk-ast2600.c                      |  2 +-
 drivers/clk/clk-axi-clkgen.c                   |  2 +-
 drivers/clk/clk-clps711x.c                     |  2 +-
 drivers/clk/clk-eyeq.c                         |  2 +-
 drivers/clk/clk-gate.c                         |  2 +-
 drivers/clk/clk-hsdk-pll.c                     |  2 +-
 drivers/clk/clk-s2mps11.c                      |  2 +-
 drivers/clk/clk-scmi.c                         |  2 +-
 drivers/clk/clk-si5351.c                       |  6 +++---
 drivers/clk/clk-si544.c                        |  2 +-
 drivers/clk/clk-si570.c                        |  4 ++--
 drivers/clk/clk-sp7021.c                       |  2 +-
 drivers/clk/clk-stm32f4.c                      |  2 +-
 drivers/clk/clk-versaclock5.c                  |  2 +-
 drivers/clk/clk_test.c                         |  2 +-
 drivers/clk/davinci/pll.h                      |  2 +-
 drivers/clk/hisilicon/clkgate-separated.c      | 16 ++++++++--------
 drivers/clk/imx/clk-fixup-div.c                |  2 +-
 drivers/clk/imx/clk-fixup-mux.c                |  2 +-
 drivers/clk/imx/clk-gate-exclusive.c           |  2 +-
 drivers/clk/imx/clk-imx5.c                     |  2 +-
 drivers/clk/imx/clk-imx8-acm.c                 |  2 +-
 drivers/clk/imx/clk-scu.c                      |  2 +-
 drivers/clk/ingenic/cgu.h                      |  2 +-
 drivers/clk/meson/axg.c                        |  2 +-
 drivers/clk/meson/g12a.c                       |  6 +++---
 drivers/clk/meson/gxbb.c                       |  2 +-
 drivers/clk/microchip/clk-core.c               |  2 +-
 drivers/clk/mmp/clk-gate.c                     |  2 +-
 drivers/clk/mvebu/armada-xp.c                  |  5 ++---
 drivers/clk/mxs/clk-div.c                      |  2 +-
 drivers/clk/nxp/clk-lpc18xx-ccu.c              |  2 +-
 drivers/clk/qcom/gcc-sm8150.c                  |  6 +++---
 drivers/clk/rockchip/clk-cpu.c                 |  6 +++---
 drivers/clk/rockchip/clk-mmc-phase.c           |  4 ++--
 drivers/clk/rockchip/clk-pll.c                 |  2 +-
 drivers/clk/rockchip/clk.h                     |  2 +-
 drivers/clk/samsung/clk-cpu.c                  |  2 +-
 drivers/clk/samsung/clk-pll.c                  |  2 +-
 drivers/clk/sophgo/clk-sg2042-clkgen.c         |  2 +-
 drivers/clk/spear/spear1340_clock.c            |  2 +-
 drivers/clk/sprd/gate.h                        |  2 +-
 drivers/clk/sprd/ums512-clk.c                  |  4 ++--
 drivers/clk/starfive/clk-starfive-jh7110-sys.c |  2 +-
 drivers/clk/stm32/clk-stm32mp1.c               |  2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c         |  2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c           |  2 +-
 drivers/clk/sunxi-ng/ccu_common.c              |  2 +-
 drivers/clk/tegra/clk-tegra210.c               |  2 +-
 drivers/clk/ti/autoidle.c                      |  2 +-
 drivers/clk/ti/clk-43xx.c                      |  2 +-
 drivers/clk/ti/mux.c                           |  2 +-
 drivers/clk/versatile/clk-icst.c               |  2 +-
 drivers/clk/visconti/pll.c                     |  2 +-
 60 files changed, 80 insertions(+), 81 deletions(-)

diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
index 84555a00f950..17d75e8e2e8f 100644
--- a/drivers/clk/baikal-t1/clk-ccu-div.c
+++ b/drivers/clk/baikal-t1/clk-ccu-div.c
@@ -405,7 +405,7 @@ static void ccu_div_clk_unregister(struct ccu_div_data *data, bool defer)
 {
 	int idx;
 
-	/* Uninstall only the clocks registered on the specfied stage */
+	/* Uninstall only the clocks registered on the specified stage */
 	for (idx = 0; idx < data->divs_num; ++idx) {
 		if (!!(data->divs_info[idx].features & CCU_DIV_BASIC) ^ defer)
 			continue;
diff --git a/drivers/clk/baikal-t1/clk-ccu-pll.c b/drivers/clk/baikal-t1/clk-ccu-pll.c
index fce02ce77347..921b87024feb 100644
--- a/drivers/clk/baikal-t1/clk-ccu-pll.c
+++ b/drivers/clk/baikal-t1/clk-ccu-pll.c
@@ -196,7 +196,7 @@ static void ccu_pll_clk_unregister(struct ccu_pll_data *data, bool defer)
 {
 	int idx;
 
-	/* Uninstall only the clocks registered on the specfied stage */
+	/* Uninstall only the clocks registered on the specified stage */
 	for (idx = 0; idx < CCU_PLL_NUM; ++idx) {
 		if (!!(pll_info[idx].features & CCU_PLL_BASIC) ^ defer)
 			continue;
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index fb04734afc80..3ec95319b711 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1550,7 +1550,7 @@ static const char *const bcm2835_clock_osc_parents[] = {
 	.parents = bcm2835_clock_osc_parents,				\
 	__VA_ARGS__)
 
-/* main peripherial parent mux */
+/* main peripheral parent mux */
 static const char *const bcm2835_clock_per_parents[] = {
 	"gnd",
 	"xosc",
diff --git a/drivers/clk/bcm/clk-bcm53573-ilp.c b/drivers/clk/bcm/clk-bcm53573-ilp.c
index 83ef41d618be..b2fc05b60783 100644
--- a/drivers/clk/bcm/clk-bcm53573-ilp.c
+++ b/drivers/clk/bcm/clk-bcm53573-ilp.c
@@ -59,7 +59,7 @@ static unsigned long bcm53573_ilp_recalc_rate(struct clk_hw *hw,
 	/*
 	 * At minimum we should loop for a bit to let hardware do the
 	 * measurement. This isn't very accurate however, so for a better
-	 * precision lets try getting 20 different values for and use average.
+	 * precision let's try getting 20 different values and use average.
 	 */
 	while (num < 20) {
 		regmap_read(regmap, PMU_XTAL_FREQ_RATIO, &cur_val);
diff --git a/drivers/clk/berlin/berlin2-avpll.c b/drivers/clk/berlin/berlin2-avpll.c
index aa89b4c9464e..79f3d37a0ee0 100644
--- a/drivers/clk/berlin/berlin2-avpll.c
+++ b/drivers/clk/berlin/berlin2-avpll.c
@@ -319,7 +319,7 @@ berlin2_avpll_channel_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 
 	/*
 	 * AV3 divider start at VCO_CTRL14, bit 7; each 4 bits wide.
-	 * AV2/AV3 form a fractional divider, where only specfic values for AV3
+	 * AV2/AV3 form a fractional divider, where only specific values for AV3
 	 * are allowed. AV3 != 0 divides by AV2/2, AV3=0 is bypass.
 	 */
 	if (ch->index < 6) {
diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
index 3432c801f1bd..595cfa533fb9 100644
--- a/drivers/clk/clk-asm9260.c
+++ b/drivers/clk/clk-asm9260.c
@@ -92,8 +92,8 @@ static const struct asm9260_div_clk asm9260_div_clks[] __initconst = {
 	{ CLKID_SYS_CPU,	"cpu_div", "main_gate", HW_CPUCLKDIV },
 	{ CLKID_SYS_AHB,	"ahb_div", "cpu_div", HW_SYSAHBCLKDIV },
 
-	/* i2s has two deviders: one for only external mclk and internal
-	 * devider for all clks. */
+	/* i2s has two dividers: one for only external mclk and internal
+	 * divider for all clks. */
 	{ CLKID_SYS_I2S0M,	"i2s0m_div", "i2s0_mclk",  HW_I2S0MCLKDIV },
 	{ CLKID_SYS_I2S1M,	"i2s1m_div", "i2s1_mclk",  HW_I2S1MCLKDIV },
 	{ CLKID_SYS_I2S0S,	"i2s0s_div", "i2s0_gate",  HW_I2S0SCLKDIV },
diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
index faf88324f7b1..114afc13d640 100644
--- a/drivers/clk/clk-ast2600.c
+++ b/drivers/clk/clk-ast2600.c
@@ -92,7 +92,7 @@ static u8 soc_rev;
  *
  * There are some gates that do not have an associated reset; these are
  * handled by using -1 as the index for the reset, and the consumer must
- * explictly assert/deassert reset lines as required.
+ * explicitly assert/deassert reset lines as required.
  *
  * Clocks marked with CLK_IS_CRITICAL:
  *
diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 934e53a96ddd..31dc74d9d556 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -172,7 +172,7 @@ static void axi_clkgen_calc_params(const struct axi_clkgen_limits *limits,
 		}
 	}
 
-	/* Lets see if we find a better setting in fractional mode */
+	/* Let's see if we find a better setting in fractional mode */
 	if (fract_shift == 0) {
 		fract_shift = 3;
 		goto again;
diff --git a/drivers/clk/clk-clps711x.c b/drivers/clk/clk-clps711x.c
index f8417ee2961a..402ab74d9bfb 100644
--- a/drivers/clk/clk-clps711x.c
+++ b/drivers/clk/clk-clps711x.c
@@ -99,7 +99,7 @@ static void __init clps711x_clk_init_dt(struct device_node *np)
 	 */
 	tmp &= ~(SYSCON1_TC1M | SYSCON1_TC1S);
 	/* Timer2 in prescale mode.
-	 * Value writen is automatically re-loaded when
+	 * Value written is automatically re-loaded when
 	 * the counter underflows.
 	 */
 	tmp |= SYSCON1_TC2M | SYSCON1_TC2S;
diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
index 640c25788487..ea1c3d78e7cd 100644
--- a/drivers/clk/clk-eyeq.c
+++ b/drivers/clk/clk-eyeq.c
@@ -131,7 +131,7 @@ struct eqc_early_match_data {
  * Both factors (mult and div) must fit in 32 bits. When an operation overflows,
  * this function throws away low bits so that factors still fit in 32 bits.
  *
- * Precision loss depends on amplitude of mult and div. Worst theorical
+ * Precision loss depends on amplitude of mult and div. Worst theoretical
  * loss is: (UINT_MAX+1) / UINT_MAX - 1 = 2.3e-10.
  * This is 1Hz every 4.3GHz.
  */
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 68e585a02fd9..4746f8219132 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -15,7 +15,7 @@
 #include <linux/string.h>
 
 /**
- * DOC: basic gatable clock which can gate and ungate its output
+ * DOC: basic gateable clock which can gate and ungate its output
  *
  * Traits of this clock:
  * prepare - clk_(un)prepare only ensures parent is (un)prepared
diff --git a/drivers/clk/clk-hsdk-pll.c b/drivers/clk/clk-hsdk-pll.c
index 5d2a90addf1a..921523fc26f2 100644
--- a/drivers/clk/clk-hsdk-pll.c
+++ b/drivers/clk/clk-hsdk-pll.c
@@ -265,7 +265,7 @@ static int hsdk_pll_core_update_rate(struct hsdk_pll_clk *clk,
 		return -EINVAL;
 
 	/*
-	 * Program divider to div-by-1 if we succesfuly set core clock below
+	 * Program divider to div-by-1 if we successfully set core clock below
 	 * 500MHz threshold.
 	 */
 	if (rate <= CORE_IF_CLK_THRESHOLD_HZ)
diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index 8ddf3a9a53df..d4e9c3577b35 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -235,7 +235,7 @@ MODULE_DEVICE_TABLE(platform, s2mps11_clk_id);
  * through platform_device_id.
  *
  * However if device's DT node contains proper clock compatible and driver is
- * built as a module, then the *module* matching will be done trough DT aliases.
+ * built as a module, then the *module* matching will be done through DT aliases.
  * This requires of_device_id table.  In the same time this will not change the
  * actual *device* matching so do not add .of_match_table.
  */
diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 15510c2ff21c..6a8f188629aa 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -451,7 +451,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 
 		/*
 		 * Note that the scmi_clk_ops_db is on the stack, not global,
-		 * because it cannot be shared between mulitple probe-sequences
+		 * because it cannot be shared between multiple probe-sequences
 		 * to avoid sharing the devm_ allocated clk_ops between multiple
 		 * SCMI clk driver instances.
 		 */
diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index a4c92c5ef3ff..e755db545e2e 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -655,7 +655,7 @@ static int si5351_msynth_determine_rate(struct clk_hw *hw,
 	unsigned long a, b, c;
 	int divby4;
 
-	/* multisync6-7 can only handle freqencies < 150MHz */
+	/* multisync6-7 can only handle frequencies < 150MHz */
 	if (hwdata->num >= 6 && rate > SI5351_MULTISYNTH67_MAX_FREQ)
 		rate = SI5351_MULTISYNTH67_MAX_FREQ;
 
@@ -1048,11 +1048,11 @@ static int si5351_clkout_determine_rate(struct clk_hw *hw,
 	unsigned long rate = req->rate;
 	unsigned char rdiv;
 
-	/* clkout6/7 can only handle output freqencies < 150MHz */
+	/* clkout6/7 can only handle output frequencies < 150MHz */
 	if (hwdata->num >= 6 && rate > SI5351_CLKOUT67_MAX_FREQ)
 		rate = SI5351_CLKOUT67_MAX_FREQ;
 
-	/* clkout freqency is 8kHz - 160MHz */
+	/* clkout frequency is 8kHz - 160MHz */
 	if (rate > SI5351_CLKOUT_MAX_FREQ)
 		rate = SI5351_CLKOUT_MAX_FREQ;
 	if (rate < SI5351_CLKOUT_MIN_FREQ)
diff --git a/drivers/clk/clk-si544.c b/drivers/clk/clk-si544.c
index c88650558f32..ca3473efa314 100644
--- a/drivers/clk/clk-si544.c
+++ b/drivers/clk/clk-si544.c
@@ -39,7 +39,7 @@
 /* Max freq depends on speed grade */
 #define SI544_MIN_FREQ	    200000U
 
-/* Si544 Internal oscilator runs at 55.05 MHz */
+/* Si544 Internal oscillator runs at 55.05 MHz */
 #define FXO		  55050000U
 
 /* VCO range is 10.8 .. 12.1 GHz, max depends on speed grade */
diff --git a/drivers/clk/clk-si570.c b/drivers/clk/clk-si570.c
index a549ea13be20..e97fe90443a6 100644
--- a/drivers/clk/clk-si570.c
+++ b/drivers/clk/clk-si570.c
@@ -63,7 +63,7 @@ struct clk_si570_info {
  * struct clk_si570:
  * @hw:	Clock hw struct
  * @regmap:	Device's regmap
- * @div_offset:	Rgister offset for dividers
+ * @div_offset:	Register offset for dividers
  * @info:	Device info
  * @fxtal:	Factory xtal frequency
  * @n1:		Clock divider N1
@@ -181,7 +181,7 @@ static int si570_update_rfreq(struct clk_si570 *data)
 }
 
 /**
- * si570_calc_divs() - Caluclate clock dividers
+ * si570_calc_divs() - Calculate clock dividers
  * @frequency:	Target frequency
  * @data:	Driver data structure
  * @out_rfreq:	RFREG fractional multiplier (output)
diff --git a/drivers/clk/clk-sp7021.c b/drivers/clk/clk-sp7021.c
index 7cb7d501d7a6..95d66191df4b 100644
--- a/drivers/clk/clk-sp7021.c
+++ b/drivers/clk/clk-sp7021.c
@@ -14,7 +14,7 @@
 
 #include <dt-bindings/clock/sunplus,sp7021-clkc.h>
 
-/* speical div_width values for PLLTV/PLLA */
+/* special div_width values for PLLTV/PLLA */
 #define DIV_TV		33
 #define DIV_A		34
 
diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 85e23961ec34..719cddc82ae6 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -19,7 +19,7 @@
 #include <linux/mfd/syscon.h>
 
 /*
- * Include list of clocks wich are not derived from system clock (SYSCLOCK)
+ * Include list of clocks which are not derived from system clock (SYSCLOCK)
  * The index of these clocks is the secondary index of DT bindings
  *
  */
diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 6d31cd54d7cf..4200022d2084 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -136,7 +136,7 @@
 #define VC5_MAX_FOD_NUM	4
 
 /* flags to describe chip features */
-/* chip has built-in oscilator */
+/* chip has built-in oscillator */
 #define VC5_HAS_INTERNAL_XTAL	BIT(0)
 /* chip has PFD requency doubler */
 #define VC5_HAS_PFD_FREQ_DBL	BIT(1)
diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index f08feeaa3750..70fcc30a13bf 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -292,7 +292,7 @@ static void clk_test_set_set_get_rate(struct kunit *test)
 }
 
 /*
- * Test that clk_round_rate and clk_set_rate are consitent and will
+ * Test that clk_round_rate and clk_set_rate are consistent and will
  * return the same frequency.
  */
 static void clk_test_round_set_get_rate(struct kunit *test)
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index 20bfcec2d3b5..ad286ba4ce0c 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -80,7 +80,7 @@ static const struct davinci_pll_sysclk_info n = {	\
  * @name: The name of the clock
  * @parent_names: Array of names of the parent clocks
  * @num_parents: Length of @parent_names
- * @table: Array of values to write to OCSEL[OCSRC] cooresponding to
+ * @table: Array of values to write to OCSEL[OCSRC] corresponding to
  *         @parent_names
  * @ocsrc_mask: Bitmask for OCSEL[OCSRC]
  */
diff --git a/drivers/clk/hisilicon/clkgate-separated.c b/drivers/clk/hisilicon/clkgate-separated.c
index 90d858522967..21d4297f3225 100644
--- a/drivers/clk/hisilicon/clkgate-separated.c
+++ b/drivers/clk/hisilicon/clkgate-separated.c
@@ -17,9 +17,9 @@
 #include "clk.h"
 
 /* clock separated gate register offset */
-#define CLKGATE_SEPERATED_ENABLE		0x0
-#define CLKGATE_SEPERATED_DISABLE		0x4
-#define CLKGATE_SEPERATED_STATUS		0x8
+#define CLKGATE_SEPARATED_ENABLE		0x0
+#define CLKGATE_SEPARATED_DISABLE		0x4
+#define CLKGATE_SEPARATED_STATUS		0x8
 
 struct clkgate_separated {
 	struct clk_hw	hw;
@@ -40,7 +40,7 @@ static int clkgate_separated_enable(struct clk_hw *hw)
 		spin_lock_irqsave(sclk->lock, flags);
 	reg = BIT(sclk->bit_idx);
 	writel_relaxed(reg, sclk->enable);
-	readl_relaxed(sclk->enable + CLKGATE_SEPERATED_STATUS);
+	readl_relaxed(sclk->enable + CLKGATE_SEPARATED_STATUS);
 	if (sclk->lock)
 		spin_unlock_irqrestore(sclk->lock, flags);
 	return 0;
@@ -56,8 +56,8 @@ static void clkgate_separated_disable(struct clk_hw *hw)
 	if (sclk->lock)
 		spin_lock_irqsave(sclk->lock, flags);
 	reg = BIT(sclk->bit_idx);
-	writel_relaxed(reg, sclk->enable + CLKGATE_SEPERATED_DISABLE);
-	readl_relaxed(sclk->enable + CLKGATE_SEPERATED_STATUS);
+	writel_relaxed(reg, sclk->enable + CLKGATE_SEPARATED_DISABLE);
+	readl_relaxed(sclk->enable + CLKGATE_SEPARATED_STATUS);
 	if (sclk->lock)
 		spin_unlock_irqrestore(sclk->lock, flags);
 }
@@ -68,7 +68,7 @@ static int clkgate_separated_is_enabled(struct clk_hw *hw)
 	u32 reg;
 
 	sclk = container_of(hw, struct clkgate_separated, hw);
-	reg = readl_relaxed(sclk->enable + CLKGATE_SEPERATED_STATUS);
+	reg = readl_relaxed(sclk->enable + CLKGATE_SEPARATED_STATUS);
 	reg &= BIT(sclk->bit_idx);
 
 	return reg ? 1 : 0;
@@ -100,7 +100,7 @@ struct clk *hisi_register_clkgate_sep(struct device *dev, const char *name,
 	init.parent_names = (parent_name ? &parent_name : NULL);
 	init.num_parents = (parent_name ? 1 : 0);
 
-	sclk->enable = reg + CLKGATE_SEPERATED_ENABLE;
+	sclk->enable = reg + CLKGATE_SEPARATED_ENABLE;
 	sclk->bit_idx = bit_idx;
 	sclk->flags = clk_gate_flags;
 	sclk->hw.init = &init;
diff --git a/drivers/clk/imx/clk-fixup-div.c b/drivers/clk/imx/clk-fixup-div.c
index 100ca828b052..ac1f2ee0edbf 100644
--- a/drivers/clk/imx/clk-fixup-div.c
+++ b/drivers/clk/imx/clk-fixup-div.c
@@ -18,7 +18,7 @@
  * @fixup: a hook to fixup the write value
  *
  * The imx fixup divider clock is a subclass of basic clk_divider
- * with an addtional fixup hook.
+ * with an additional fixup hook.
  */
 struct clk_fixup_div {
 	struct clk_divider divider;
diff --git a/drivers/clk/imx/clk-fixup-mux.c b/drivers/clk/imx/clk-fixup-mux.c
index b48701864ef0..418ac9fe2c26 100644
--- a/drivers/clk/imx/clk-fixup-mux.c
+++ b/drivers/clk/imx/clk-fixup-mux.c
@@ -17,7 +17,7 @@
  * @fixup: a hook to fixup the write value
  *
  * The imx fixup multiplexer clock is a subclass of basic clk_mux
- * with an addtional fixup hook.
+ * with an additional fixup hook.
  */
 struct clk_fixup_mux {
 	struct clk_mux mux;
diff --git a/drivers/clk/imx/clk-gate-exclusive.c b/drivers/clk/imx/clk-gate-exclusive.c
index 77342893bb71..7017e9d4e188 100644
--- a/drivers/clk/imx/clk-gate-exclusive.c
+++ b/drivers/clk/imx/clk-gate-exclusive.c
@@ -18,7 +18,7 @@
  *	gate clock
  *
  * The imx exclusive gate clock is a subclass of basic clk_gate
- * with an addtional mask to indicate which other gate bits in the same
+ * with an additional mask to indicate which other gate bits in the same
  * register is mutually exclusive to this gate clock.
  */
 struct clk_gate_exclusive {
diff --git a/drivers/clk/imx/clk-imx5.c b/drivers/clk/imx/clk-imx5.c
index b82044911603..9c5f489b3975 100644
--- a/drivers/clk/imx/clk-imx5.c
+++ b/drivers/clk/imx/clk-imx5.c
@@ -454,7 +454,7 @@ static void __init mx51_clocks_init(struct device_node *np)
 	 * longer supported. Set to one for better power saving.
 	 *
 	 * The effect of not setting these bits is that MIPI clocks can't be
-	 * enabled without the IPU clock being enabled aswell.
+	 * enabled without the IPU clock being enabled as well.
 	 */
 	val = readl(MXC_CCM_CCDR);
 	val |= 1 << 18;
diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index c169fe53a35f..790f7e44b11e 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -22,7 +22,7 @@
  * struct clk_imx_acm_pm_domains - structure for multi power domain
  * @pd_dev: power domain device
  * @pd_dev_link: power domain device link
- * @num_domains: power domain nummber
+ * @num_domains: power domain number
  */
 struct clk_imx_acm_pm_domains {
 	struct device **pd_dev;
diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index b27186aaf2a1..e7773c9e45bf 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -729,7 +729,7 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 	if (ret)
 		goto put_device;
 
-	/* For API backwards compatiblilty, simply return NULL for success */
+	/* For API backwards compatibility, simply return NULL for success */
 	return NULL;
 
 put_device:
diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index 99da9bd86e63..0d417d69dab7 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -239,7 +239,7 @@ ingenic_cgu_new(const struct ingenic_cgu_clk_info *clock_info,
  *
  * Register the clocks described by the CGU with the common clock framework.
  *
- * Return: 0 on success or -errno if unsuccesful.
+ * Return: 0 on success or -errno if unsuccessful.
  */
 int ingenic_cgu_register_clocks(struct ingenic_cgu *cgu);
 
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 448eece246ca..663de28e315b 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -918,7 +918,7 @@ static const struct clk_parent_data axg_sd_emmc_clk0_parent_data[] = {
 	/*
 	 * Following these parent clocks, we should also have had mpll2, mpll3
 	 * and gp0_pll but these clocks are too precious to be used here. All
-	 * the necessary rates for MMC and NAND operation can be acheived using
+	 * the necessary rates for MMC and NAND operation can be achieved using
 	 * xtal or fclk_div clocks
 	 */
 };
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index d9e546e006d7..72767bc44715 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -2489,7 +2489,7 @@ static const struct clk_parent_data g12a_sd_emmc_clk0_parent_data[] = {
 	/*
 	 * Following these parent clocks, we should also have had mpll2, mpll3
 	 * and gp0_pll but these clocks are too precious to be used here. All
-	 * the necessary rates for MMC and NAND operation can be acheived using
+	 * the necessary rates for MMC and NAND operation can be achieved using
 	 * g12a_ee_core or fclk_div clocks
 	 */
 };
@@ -3753,8 +3753,8 @@ static struct clk_regmap g12a_mipi_dsi_pxclk_sel = {
 };
 
 /*
- * FIXME: Force as bypass by forcing a single /1 table entry, and doensn't on boot value
- * when setting a clock whith this node in the clock path, but doesn't garantee the divider
+ * FIXME: Force as bypass by forcing a single /1 table entry, and doesn't on boot value
+ * when setting a clock with this node in the clock path, but doesn't guarantee the divider
  * is at /1 at boot until a rate is set.
  */
 static const struct clk_div_table g12a_mipi_dsi_pxclk_div_table[] = {
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 3abb44a2532b..9fcf026fc491 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1335,7 +1335,7 @@ static const struct clk_parent_data gxbb_sd_emmc_clk0_parent_data[] = {
 	/*
 	 * Following these parent clocks, we should also have had mpll2, mpll3
 	 * and gp0_pll but these clocks are too precious to be used here. All
-	 * the necessary rates for MMC and NAND operation can be acheived using
+	 * the necessary rates for MMC and NAND operation can be achieved using
 	 * xtal or fclk_div clocks
 	 */
 };
diff --git a/drivers/clk/microchip/clk-core.c b/drivers/clk/microchip/clk-core.c
index 1b4f023cdc8b..6fbc6dc50ca3 100644
--- a/drivers/clk/microchip/clk-core.c
+++ b/drivers/clk/microchip/clk-core.c
@@ -326,7 +326,7 @@ static void roclk_calc_div_trim(unsigned long rate,
 	 * i.e. fout = fin / 2 * DIV
 	 *      whereas DIV = rodiv + (rotrim / 512)
 	 *
-	 * Since kernel does not perform floating-point arithmatic so
+	 * Since kernel does not perform floating-point arithmetic so
 	 * (rotrim/512) will be zero. And DIV & rodiv will result same.
 	 *
 	 * ie. fout = (fin * 256) / [(512 * rodiv) + rotrim]  ... from (1)
diff --git a/drivers/clk/mmp/clk-gate.c b/drivers/clk/mmp/clk-gate.c
index 350eeb3e9e25..6855815ee8be 100644
--- a/drivers/clk/mmp/clk-gate.c
+++ b/drivers/clk/mmp/clk-gate.c
@@ -15,7 +15,7 @@
 #include "clk.h"
 
 /*
- * Some clocks will have mutiple bits to enable the clocks, and
+ * Some clocks will have multiple bits to enable the clocks, and
  * the bits to disable the clock is not same as enabling bits.
  */
 
diff --git a/drivers/clk/mvebu/armada-xp.c b/drivers/clk/mvebu/armada-xp.c
index 45665655a258..8d31a595a27c 100644
--- a/drivers/clk/mvebu/armada-xp.c
+++ b/drivers/clk/mvebu/armada-xp.c
@@ -7,7 +7,6 @@
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  * Andrew Lunn <andrew@lunn.ch>
- *
  */
 
 #include <linux/kernel.h>
@@ -19,8 +18,8 @@
 /*
  * Core Clocks
  *
- * Armada XP Sample At Reset is a 64 bit bitfiled split in two
- * register of 32 bits
+ * Armada XP Sample At Reset is a 64 bit bitfield split in two
+ * registers of 32 bits
  */
 
 #define SARL				0	/* Low part [0:31] */
diff --git a/drivers/clk/mxs/clk-div.c b/drivers/clk/mxs/clk-div.c
index 928e8b1c46a1..0a78ef380646 100644
--- a/drivers/clk/mxs/clk-div.c
+++ b/drivers/clk/mxs/clk-div.c
@@ -16,7 +16,7 @@
  * @busy: busy bit shift
  *
  * The mxs divider clock is a subclass of basic clk_divider with an
- * addtional busy bit.
+ * additional busy bit.
  */
 struct clk_div {
 	struct clk_divider divider;
diff --git a/drivers/clk/nxp/clk-lpc18xx-ccu.c b/drivers/clk/nxp/clk-lpc18xx-ccu.c
index ddb28b38f549..751b786d73f8 100644
--- a/drivers/clk/nxp/clk-lpc18xx-ccu.c
+++ b/drivers/clk/nxp/clk-lpc18xx-ccu.c
@@ -148,7 +148,7 @@ static int lpc18xx_ccu_gate_endisable(struct clk_hw *hw, bool enable)
 		val |= LPC18XX_CCU_RUN;
 	} else {
 		/*
-		 * To safely disable a branch clock a squence of two separate
+		 * To safely disable a branch clock a sequence of two separate
 		 * writes must be used. First write should set the AUTO bit
 		 * and the next write should clear the RUN bit.
 		 */
diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index cefceb780889..a93d1f412a7b 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -1245,7 +1245,7 @@ static struct clk_branch gcc_boot_rom_ahb_clk = {
 };
 
 /*
- * Clock ON depends on external parent 'config noc', so cant poll
+ * Clock ON depends on external parent 'config noc', so can't poll
  * delay and also mark as crtitical for camss boot
  */
 static struct clk_branch gcc_camera_ahb_clk = {
@@ -1398,7 +1398,7 @@ static struct clk_branch gcc_ddrss_gpu_axi_clk = {
 };
 
 /*
- * Clock ON depends on external parent 'config noc', so cant poll
+ * Clock ON depends on external parent 'config noc', so can't poll
  * delay and also mark as crtitical for disp boot
  */
 static struct clk_branch gcc_disp_ahb_clk = {
@@ -3339,7 +3339,7 @@ static struct clk_branch gcc_usb3_sec_phy_pipe_clk = {
 };
 
 /*
- * Clock ON depends on external parent 'config noc', so cant poll
+ * Clock ON depends on external parent 'config noc', so can't poll
  * delay and also mark as crtitical for video boot
  */
 static struct clk_branch gcc_video_ahb_clk = {
diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index 398a226ad34e..dcc9dcb597ae 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -16,14 +16,14 @@
  * of the SoC or supplied after the SoC characterization.
  *
  * The below implementation of the CPU clock allows the rate changes of the CPU
- * clock and the corresponding rate changes of the auxillary clocks of the CPU
+ * clock and the corresponding rate changes of the auxiliary clocks of the CPU
  * domain. The platform clock driver provides a clock register configuration
  * for each configurable rate which is then used to program the clock hardware
- * registers to acheive a fast co-oridinated rate change for all the CPU domain
+ * registers to achieve a fast co-oridinated rate change for all the CPU domain
  * clocks.
  *
  * On a rate change request for the CPU clock, the rate change is propagated
- * upto the PLL supplying the clock to the CPU domain clock blocks. While the
+ * up to the PLL supplying the clock to the CPU domain clock blocks. While the
  * CPU domain PLL is reconfigured, the CPU domain clocks are driven using an
  * alternate clock source. If required, the alternate clock source is divided
  * down in order to keep the output clock rate within the previous OPP limits.
diff --git a/drivers/clk/rockchip/clk-mmc-phase.c b/drivers/clk/rockchip/clk-mmc-phase.c
index b3ed8e7523e5..8b1292c56863 100644
--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -174,11 +174,11 @@ static int rockchip_mmc_clk_rate_notify(struct notifier_block *nb,
 
 	/*
 	 * rockchip_mmc_clk is mostly used by mmc controllers to sample
-	 * the intput data, which expects the fixed phase after the tuning
+	 * the input data, which expects the fixed phase after the tuning
 	 * process. However if the clock rate is changed, the phase is stale
 	 * and may break the data sampling. So here we try to restore the phase
 	 * for that case, except that
-	 * (1) cached_phase is invaild since we inevitably cached it when the
+	 * (1) cached_phase is invalid since we inevitably cached it when the
 	 * clock provider be reparented from orphan to its real parent in the
 	 * first place. Otherwise we may mess up the initialization of MMC cards
 	 * since we only set the default sample phase and drive phase later on.
diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index af74439a7457..c9d599c31923 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -68,7 +68,7 @@ static long rockchip_pll_round_rate(struct clk_hw *hw,
 	const struct rockchip_pll_rate_table *rate_table = pll->rate_table;
 	int i;
 
-	/* Assumming rate_table is in descending order */
+	/* Assuming rate_table is in descending order */
 	for (i = 0; i < pll->rate_count; i++) {
 		if (drate >= rate_table[i].rate)
 			return rate_table[i].rate;
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 1e9c3c0d31e3..7c5e74c7a2e2 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -532,7 +532,7 @@ struct rockchip_pll_rate_table {
  *
  * Flags:
  * ROCKCHIP_PLL_SYNC_RATE - check rate parameters to match against the
- *	rate_table parameters and ajust them if necessary.
+ *	rate_table parameters and adjust them if necessary.
  * ROCKCHIP_PLL_FIXED_MODE - the pll operates in normal mode only
  */
 struct rockchip_pll_clock {
diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 97982662e1a6..4e1ebd8a30b1 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -243,7 +243,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 		if (cpuclk->flags & CLK_CPU_NEEDS_DEBUG_ALT_DIV) {
 			/*
 			 * In Exynos4210, ATB clock parent is also mout_core. So
-			 * ATB clock also needs to be mantained at safe speed.
+			 * ATB clock also needs to be maintained at safe speed.
 			 */
 			alt_div |= E4210_DIV0_ATB_MASK;
 			alt_div_mask |= E4210_DIV0_ATB_MASK;
diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index fe8abe442c51..e4faf02b631e 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -56,7 +56,7 @@ static long samsung_pll_round_rate(struct clk_hw *hw,
 	const struct samsung_pll_rate_table *rate_table = pll->rate_table;
 	int i;
 
-	/* Assumming rate_table is in descending order */
+	/* Assuming rate_table is in descending order */
 	for (i = 0; i < pll->rate_count; i++) {
 		if (drate >= rate_table[i].rate)
 			return rate_table[i].rate;
diff --git a/drivers/clk/sophgo/clk-sg2042-clkgen.c b/drivers/clk/sophgo/clk-sg2042-clkgen.c
index a334963e83ce..9e61288d34f3 100644
--- a/drivers/clk/sophgo/clk-sg2042-clkgen.c
+++ b/drivers/clk/sophgo/clk-sg2042-clkgen.c
@@ -968,7 +968,7 @@ static int sg2042_mux_notifier_cb(struct notifier_block *nb,
 		/*
 		 * "1" is the array index of the second parent input source of
 		 * mux. For SG2042, it's fpll for all mux clocks.
-		 * "0" is the array index of the frist parent input source of
+		 * "0" is the array index of the first parent input source of
 		 * mux, For SG2042, it's mpll.
 		 * FIXME, any good idea to avoid magic number?
 		 */
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index 361d344bfaf0..fdfb26c67188 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -199,7 +199,7 @@ static struct frac_rate_tbl amba_synth_rtbl[] = {
  * We can program this synthesizer to make cpu run on different clock
  * frequencies.
  * Following table provides configuration values to let cpu run on 200,
- * 250, 332, 400 or 500 MHz considering different possibilites of input
+ * 250, 332, 400 or 500 MHz considering different possibilities of input
  * (vco1div2) clock.
  *
  * --------------------------------------------------------------------
diff --git a/drivers/clk/sprd/gate.h b/drivers/clk/sprd/gate.h
index e738dafa4fe9..775519eb1cb6 100644
--- a/drivers/clk/sprd/gate.h
+++ b/drivers/clk/sprd/gate.h
@@ -26,7 +26,7 @@ struct sprd_gate {
  * CLK_GATE_BIG_ENDIAN		BIT(2)
  * so we define new flags from	BIT(3)
  */
-#define SPRD_GATE_NON_AON BIT(3) /* not alway powered on, check before read */
+#define SPRD_GATE_NON_AON BIT(3) /* not always powered on, check before read */
 
 #define SPRD_SC_GATE_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,	\
 				    _sc_offset, _enable_mask, _flags,	\
diff --git a/drivers/clk/sprd/ums512-clk.c b/drivers/clk/sprd/ums512-clk.c
index 9384ecc6c741..f763d83de9ee 100644
--- a/drivers/clk/sprd/ums512-clk.c
+++ b/drivers/clk/sprd/ums512-clk.c
@@ -1550,7 +1550,7 @@ static struct sprd_clk_desc ums512_aon_gate_desc = {
 
 /* audcp apb gates */
 /* Audcp apb clocks configure CLK_IGNORE_UNUSED because these clocks may be
- * controlled by audcp sys at the same time. It may be cause an execption if
+ * controlled by audcp sys at the same time. It may cause an exception if
  * kernel gates these clock.
  */
 static SPRD_SC_GATE_CLK_HW(audcp_wdg_eb, "audcp-wdg-eb",
@@ -1592,7 +1592,7 @@ static const struct sprd_clk_desc ums512_audcpapb_gate_desc = {
 
 /* audcp ahb gates */
 /* Audcp aphb clocks configure CLK_IGNORE_UNUSED because these clocks may be
- * controlled by audcp sys at the same time. It may be cause an execption if
+ * controlled by audcp sys at the same time. It may cause an exception if
  * kernel gates these clock.
  */
 static SPRD_SC_GATE_CLK_HW(audcp_iis0_eb, "audcp-iis0-eb",
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index e9d8168d02b8..52833d4241c5 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -376,7 +376,7 @@ EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
 
 /*
  * This clock notifier is called when the rate of PLL0 clock is to be changed.
- * The cpu_root clock should save the curent parent clock and switch its parent
+ * The cpu_root clock should save the current parent clock and switch its parent
  * clock to osc before PLL0 rate will be changed. Then switch its parent clock
  * back after the PLL0 rate is completed.
  */
diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
index 5fcc4c77c11f..b8b45ed22f98 100644
--- a/drivers/clk/stm32/clk-stm32mp1.c
+++ b/drivers/clk/stm32/clk-stm32mp1.c
@@ -2041,7 +2041,7 @@ static const struct clock_config stm32mp1_clock_cfg[] = {
 	KCLK(ADFSDM_K, "adfsdm_k", sai_src, 0, G_ADFSDM, M_SAI1),
 	KCLK(USBO_K, "usbo_k", usbo_src, 0, G_USBO, M_USBO),
 
-	/* Particulary Kernel Clocks (no mux or no gate) */
+	/* Particularly Kernel Clocks (no mux or no gate) */
 	MGATE_MP1(DFSDM_K, "dfsdm_k", "ck_mcu", 0, G_DFSDM),
 	MGATE_MP1(DSI_PX, "dsi_px", "pll4_q", CLK_SET_RATE_PARENT, G_DSI),
 	MGATE_MP1(LTDC_PX, "ltdc_px", "pll4_q", CLK_SET_RATE_PARENT, G_LTDC),
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index acb4e8b9b1ba..d24fa3449303 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -80,7 +80,7 @@ static struct ccu_div r_apb2_clk = {
  * in the BSP source code, although most of them are unused. The existence
  * of the hardware block is verified with "3.1 Memory Mapping" chapter in
  * "Allwinner H6 V200 User Manual V1.1"; and the parent APB buses are verified
- * with "3.3.2.1 System Bus Tree" chapter inthe same document.
+ * with "3.3.2.1 System Bus Tree" chapter in the same document.
  */
 static SUNXI_CCU_GATE(r_apb1_timer_clk,	"r-apb1-timer",	"r-apb1",
 		      0x11c, BIT(0), 0);
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index 8b729c9b3545..44565830881d 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -439,7 +439,7 @@ static SUNXI_CCU_GATE(bus_i2c2_clk,	"bus-i2c2",	"apb2",
 static SUNXI_CCU_GATE(bus_i2c3_clk,	"bus-i2c3",	"apb2",
 		      0x06c, BIT(3), 0);
 /*
- * In datasheet here's "Reserved", however the gate exists in BSP soucre
+ * In datasheet here's "Reserved", however the gate exists in BSP source
  * code.
  */
 static SUNXI_CCU_GATE(bus_can_clk,	"bus-can",	"apb2",
diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
index 88ed89658d45..c7e00f0c29a5 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -66,7 +66,7 @@ EXPORT_SYMBOL_NS_GPL(ccu_is_better_rate, "SUNXI_CCU");
  * changed. In common PLL designs, changes to the dividers take effect
  * almost immediately, while changes to the multipliers (implemented
  * as dividers in the feedback loop) take a few cycles to work into
- * the feedback loop for the PLL to stablize.
+ * the feedback loop for the PLL to stabilize.
  *
  * Sometimes when the PLL clock rate is changed, the decrease in the
  * divider is too much for the decrease in the multiplier to catch up.
diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index a3488aaac3f7..412902f573b5 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -255,7 +255,7 @@
 /* VIC register to handle during MBIST WAR */
 #define NV_PVIC_THI_SLCG_OVERRIDE_LOW 0x8c
 
-/* APE, DISPA and VIC base addesses needed for MBIST WAR */
+/* APE, DISPA and VIC base addresses needed for MBIST WAR */
 #define TEGRA210_AHUB_BASE  0x702d0000
 #define TEGRA210_DISPA_BASE 0x54200000
 #define TEGRA210_VIC_BASE  0x54340000
diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index 27e6b9cb1881..a99aaf2e7684 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -30,7 +30,7 @@ static LIST_HEAD(autoidle_clks);
 
 /*
  * we have some non-atomic read/write
- * operations behind it, so lets
+ * operations behind it, so let's
  * take one lock for handling autoidle
  * of all clocks
  */
diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
index f24f6eb2157a..35af3079c002 100644
--- a/drivers/clk/ti/clk-43xx.c
+++ b/drivers/clk/ti/clk-43xx.c
@@ -286,7 +286,7 @@ int __init am43xx_dt_clk_init(void)
 	/*
 	 * cpsw_cpts_rft_clk  has got the choice of 3 clocksources
 	 * dpll_core_m4_ck, dpll_core_m5_ck and dpll_disp_m2_ck.
-	 * By default dpll_core_m4_ck is selected, witn this as clock
+	 * By default dpll_core_m4_ck is selected, with this as clock
 	 * source the CPTS doesnot work properly. It gives clockcheck errors
 	 * while running PTP.
 	 * clockcheck: clock jumped backward or running slower than expected!
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index f684fc306ecc..d6d247ff2be5 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -84,7 +84,7 @@ static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 }
 
 /**
- * clk_mux_save_context - Save the parent selcted in the mux
+ * clk_mux_save_context - Save the parent selected in the mux
  * @hw: pointer  struct clk_hw
  *
  * Save the parent mux value.
diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index d5cb372f0901..b69c3fbdfbce 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -194,7 +194,7 @@ static int vco_set(struct clk_icst *icst, struct icst_vco vco)
 			pr_err("ICST error: tried to use RDW != 22\n");
 		break;
 	default:
-		/* Regular auxilary oscillator */
+		/* Regular auxiliary oscillator */
 		mask = VERSATILE_AUX_OSC_BITS;
 		val = vco.v | (vco.r << 9) | (vco.s << 16);
 		break;
diff --git a/drivers/clk/visconti/pll.c b/drivers/clk/visconti/pll.c
index 3f929cf8dd2f..8ca1bad61864 100644
--- a/drivers/clk/visconti/pll.c
+++ b/drivers/clk/visconti/pll.c
@@ -107,7 +107,7 @@ static long visconti_pll_round_rate(struct clk_hw *hw,
 	const struct visconti_pll_rate_table *rate_table = pll->rate_table;
 	int i;
 
-	/* Assumming rate_table is in descending order */
+	/* Assuming rate_table is in descending order */
 	for (i = 0; i < pll->rate_count; i++)
 		if (rate >= rate_table[i].rate)
 			return rate_table[i].rate;
-- 
2.43.0


