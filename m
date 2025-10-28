Return-Path: <linux-kernel+bounces-873443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD097C13F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F233ABC7C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A002D8DC4;
	Tue, 28 Oct 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Io0w7+YV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC37F303A03;
	Tue, 28 Oct 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645155; cv=none; b=YT4iBXI+ydsyzNrQ+2bDRTJUVocPFiVefO7gTdwdDNM+ffPH7fHl4qRMnhGJPbA/U7VU3ELO2/1hxfBWfi0jkLKbvaoZaaD24Z+tL/qHCHwapms/nP9CF8TztVdf5d8uom9IrDkqEFeiZ+ztYQNnCWPtHuVBJRZ1NrW7+GPc3yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645155; c=relaxed/simple;
	bh=MnV2BOCd8DTs0wVX3sUywUNj4t1O0jc50IRxp5XXIJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I3RF54tA4wbf2PQDlrFsio+J6u5CF9B5X6yaPfzV5sDJXi8g7PU+DishsL1DHibplGfbCG4lMxwGRhs9knwa2g2m6Cg6BC2PIsjL2dPySroiMJIJtt+A7njnIA1iFkdxwx0GmEWAc72a8hXg3hNj936NaLY+yO8v/3gzbsblxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Io0w7+YV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B14DC16AAE;
	Tue, 28 Oct 2025 09:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761645155;
	bh=MnV2BOCd8DTs0wVX3sUywUNj4t1O0jc50IRxp5XXIJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Io0w7+YV5lGMPmYa3+AZ29JcvmpusrVy0A8PrUVf43jpQH/nNPXqUcvS9AZzjQLH8
	 pQjQBRjvdYzIbVOo4D4VyM54ETncG5fqWayyXFJXRCsXD6Krqh0/JbYpbvWxo/59j0
	 olfF1TBgwQQ8iXxtaaGahZYZej/fcFFJMWIe1vMNU/0pmyE4AJ207byEw215/mBFsd
	 rohprq4p9PFwItP95byDlUcanX4jtP7/z3e6WMLQPWQhXdxbFK37a4V/9anI3RDz3o
	 AJpsfrnHyb/TQSj78V3e3xFdTURlTgyHj1RNBwhK5xPtLJWgf/D1T9tiTxEgbCcnac
	 uJbQApYAvYTLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824AFCCF9EE;
	Tue, 28 Oct 2025 09:52:35 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 28 Oct 2025 17:52:30 +0800
Subject: [PATCH v4 4/8] clk: amlogic: Add A5 PLL clock controller driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-a5-clk-v4-4-e62ca0aae243@amlogic.com>
References: <20251028-a5-clk-v4-0-e62ca0aae243@amlogic.com>
In-Reply-To: <20251028-a5-clk-v4-0-e62ca0aae243@amlogic.com>
To: Chuan Liu <chuan.liu@amlogic.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761645153; l=13554;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=bqPQfOJqLfFXBRF759KJLHWjqGxOIH91g1/52NuwjAA=;
 b=UV83sWcOCcECVREuHcUsKh5wKwRE2cT6hJ/tQB5fU1uM+Vbm0CCQ4CV6baZZ+O7rh1iboEQuS
 l2c7claT78iBr9hLCTIkTMnl/UkOvzRSJb/iVMWjKTqC9mKYRQkinIq
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the PLL clock controller driver for the Amlogic A5 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/clk/meson/Kconfig  |  14 ++
 drivers/clk/meson/Makefile |   1 +
 drivers/clk/meson/a5-pll.c | 476 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 491 insertions(+)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 71481607a6d5..b627821da081 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -132,6 +132,20 @@ config COMMON_CLK_A1_PERIPHERALS
 	  device, A1 SoC Family. Say Y if you want A1 Peripherals clock
 	  controller to work.
 
+config COMMON_CLK_A5_PLL
+	tristate "Amlogic A5 PLL clock controller"
+	depends on ARM64
+	default ARCH_MESON
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_PLL
+	select COMMON_CLK_MESON_MPLL
+	select COMMON_CLK_MESON_CLKC_UTILS
+	imply COMMON_CLK_SCMI
+	help
+	  Support for the PLL clock controller on Amlogic  A113X2 device, AKA A5.
+	  Say Y if you want the board to work, because PLLs are the parent
+	  of most peripherals.
+
 config COMMON_CLK_C3_PLL
 	tristate "Amlogic C3 PLL clock controller"
 	depends on ARM64
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index c6998e752c68..a074aa7e187f 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
 obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
 obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
 obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
+obj-$(CONFIG_COMMON_CLK_A5_PLL) += a5-pll.o
 obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
 obj-$(CONFIG_COMMON_CLK_C3_PERIPHERALS) += c3-peripherals.o
 obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
diff --git a/drivers/clk/meson/a5-pll.c b/drivers/clk/meson/a5-pll.c
new file mode 100644
index 000000000000..1789a7e6470d
--- /dev/null
+++ b/drivers/clk/meson/a5-pll.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Amlogic A5 PLL Controller Driver
+ *
+ * Copyright (c) 2024-2025 Amlogic, inc.
+ * Author: Chuan Liu <chuan.liu@amlogic.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include "clk-regmap.h"
+#include "clk-pll.h"
+#include "clk-mpll.h"
+#include "meson-clkc-utils.h"
+#include <dt-bindings/clock/amlogic,a5-pll-clkc.h>
+
+#define GP0PLL_CTRL0			0x80
+#define GP0PLL_CTRL1			0x84
+#define GP0PLL_CTRL2			0x88
+#define GP0PLL_CTRL3			0x8c
+#define GP0PLL_CTRL4			0x90
+#define GP0PLL_CTRL5			0x94
+#define GP0PLL_CTRL6			0x98
+#define HIFIPLL_CTRL0			0x100
+#define HIFIPLL_CTRL1			0x104
+#define HIFIPLL_CTRL2			0x108
+#define HIFIPLL_CTRL3			0x10c
+#define HIFIPLL_CTRL4			0x110
+#define HIFIPLL_CTRL5			0x114
+#define HIFIPLL_CTRL6			0x118
+#define MPLL_CTRL0			0x180
+#define MPLL_CTRL1			0x184
+#define MPLL_CTRL2			0x188
+#define MPLL_CTRL3			0x18c
+#define MPLL_CTRL4			0x190
+#define MPLL_CTRL5			0x194
+#define MPLL_CTRL6			0x198
+#define MPLL_CTRL7			0x19c
+#define MPLL_CTRL8			0x1a0
+
+static struct clk_fixed_factor a5_mpll_prediv = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll_prediv",
+		.ops = &clk_fixed_factor_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "fix_dco"
+		},
+		.num_parents = 1,
+	},
+};
+
+static const struct reg_sequence a5_mpll0_init_regs[] = {
+	{ .reg = MPLL_CTRL2,	.def = 0x40000033 },
+};
+
+static struct clk_regmap a5_mpll0_div = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = MPLL_CTRL1,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = MPLL_CTRL1,
+			.shift   = 30,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = MPLL_CTRL1,
+			.shift   = 20,
+			.width   = 9,
+		},
+		.ssen = {
+			.reg_off = MPLL_CTRL1,
+			.shift   = 29,
+			.width	 = 1,
+		},
+		.init_regs = a5_mpll0_init_regs,
+		.init_count = ARRAY_SIZE(a5_mpll0_init_regs),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll0_div",
+		.ops = &meson_clk_mpll_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a5_mpll_prediv.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a5_mpll0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = MPLL_CTRL1,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &a5_mpll0_div.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct reg_sequence a5_mpll1_init_regs[] = {
+	{ .reg = MPLL_CTRL4,	.def = 0x40000033 },
+};
+
+static struct clk_regmap a5_mpll1_div = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = MPLL_CTRL3,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = MPLL_CTRL3,
+			.shift   = 30,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = MPLL_CTRL3,
+			.shift   = 20,
+			.width   = 9,
+		},
+		.ssen = {
+			.reg_off = MPLL_CTRL3,
+			.shift   = 29,
+			.width	 = 1,
+		},
+		.init_regs = a5_mpll1_init_regs,
+		.init_count = ARRAY_SIZE(a5_mpll1_init_regs),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll1_div",
+		.ops = &meson_clk_mpll_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a5_mpll_prediv.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a5_mpll1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = MPLL_CTRL3,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "a5_mpll1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &a5_mpll1_div.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct reg_sequence a5_mpll2_init_regs[] = {
+	{ .reg = MPLL_CTRL6,	.def = 0x40000033 },
+};
+
+static struct clk_regmap a5_mpll2_div = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = MPLL_CTRL5,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = MPLL_CTRL5,
+			.shift   = 30,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = MPLL_CTRL5,
+			.shift   = 20,
+			.width   = 9,
+		},
+		.ssen = {
+			.reg_off = MPLL_CTRL5,
+			.shift   = 29,
+			.width	 = 1,
+		},
+		.init_regs = a5_mpll2_init_regs,
+		.init_count = ARRAY_SIZE(a5_mpll2_init_regs),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll2_div",
+		.ops = &meson_clk_mpll_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a5_mpll_prediv.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a5_mpll2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = MPLL_CTRL5,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &a5_mpll2_div.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct reg_sequence a5_mpll3_init_regs[] = {
+	{ .reg = MPLL_CTRL8,	.def = 0x40000033 },
+};
+
+static struct clk_regmap a5_mpll3_div = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = MPLL_CTRL7,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = MPLL_CTRL7,
+			.shift   = 30,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = MPLL_CTRL7,
+			.shift   = 20,
+			.width   = 9,
+		},
+		.ssen = {
+			.reg_off = MPLL_CTRL7,
+			.shift   = 29,
+			.width	 = 1,
+		},
+		.init_regs = a5_mpll3_init_regs,
+		.init_count = ARRAY_SIZE(a5_mpll3_init_regs),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll3_div",
+		.ops = &meson_clk_mpll_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a5_mpll_prediv.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a5_mpll3 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = MPLL_CTRL7,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll3",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &a5_mpll3_div.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct reg_sequence a5_gp0_init_regs[] = {
+	{ .reg = GP0PLL_CTRL3, .def = 0x6a295c00 },
+	{ .reg = GP0PLL_CTRL4, .def = 0x65771290 },
+	{ .reg = GP0PLL_CTRL5, .def = 0x3927200a },
+	{ .reg = GP0PLL_CTRL6, .def = 0x54540000 }
+};
+
+static const struct pll_mult_range a5_gp0_pll_mult_range = {
+	.min = 125,
+	.max = 250,
+};
+
+static struct clk_regmap a5_gp0_pll_dco = {
+	.data = &(struct meson_clk_pll_data) {
+		.en = {
+			.reg_off = GP0PLL_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = GP0PLL_CTRL0,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.frac = {
+			.reg_off = GP0PLL_CTRL1,
+			.shift   = 0,
+			.width   = 17,
+		},
+		.n = {
+			.reg_off = GP0PLL_CTRL0,
+			.shift   = 10,
+			.width   = 5,
+		},
+		.l = {
+			.reg_off = GP0PLL_CTRL0,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = GP0PLL_CTRL0,
+			.shift   = 29,
+			.width   = 1,
+		},
+		.range = &a5_gp0_pll_mult_range,
+		.init_regs = a5_gp0_init_regs,
+		.init_count = ARRAY_SIZE(a5_gp0_init_regs),
+		.frac_max = 100000,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "gp0_pll_dco",
+		.ops = &meson_clk_pll_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+/* The maximum frequency divider supports is 32, not 128(2^7) */
+static const struct clk_div_table a5_gp0_pll_od_table[] = {
+	{ 0,  1 },
+	{ 1,  2 },
+	{ 2,  4 },
+	{ 3,  8 },
+	{ 4, 16 },
+	{ 5, 32 },
+	{ /* sentinel */ }
+};
+
+static struct clk_regmap a5_gp0_pll = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = GP0PLL_CTRL0,
+		.shift = 16,
+		.width = 3,
+		.table = a5_gp0_pll_od_table,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "gp0_pll",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a5_gp0_pll_dco.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct reg_sequence a5_hifi_init_regs[] = {
+	{ .reg = HIFIPLL_CTRL3, .def = 0x6a285c00 },
+	{ .reg = HIFIPLL_CTRL4, .def = 0x65771290 },
+	{ .reg = HIFIPLL_CTRL5, .def = 0x3927200a },
+	{ .reg = HIFIPLL_CTRL6, .def = 0x56540000 }
+};
+
+static const struct pll_mult_range a5_hifi_pll_mult_range = {
+	.min = 125,
+	.max = 250,
+};
+
+static struct clk_regmap a5_hifi_pll_dco = {
+	.data = &(struct meson_clk_pll_data) {
+		.en = {
+			.reg_off = HIFIPLL_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = HIFIPLL_CTRL0,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.frac = {
+			.reg_off = HIFIPLL_CTRL1,
+			.shift   = 0,
+			.width   = 17,
+		},
+		.n = {
+			.reg_off = HIFIPLL_CTRL0,
+			.shift   = 10,
+			.width   = 5,
+		},
+		.l = {
+			.reg_off = HIFIPLL_CTRL0,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HIFIPLL_CTRL0,
+			.shift   = 29,
+			.width   = 1,
+		},
+		.range = &a5_hifi_pll_mult_range,
+		.init_regs = a5_hifi_init_regs,
+		.init_count = ARRAY_SIZE(a5_hifi_init_regs),
+		.frac_max = 100000,
+		.flags = CLK_MESON_PLL_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hifi_pll_dco",
+		.ops = &meson_clk_pll_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap a5_hifi_pll = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = HIFIPLL_CTRL0,
+		.shift = 16,
+		.width = 2,
+		.flags = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hifi_pll",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&a5_hifi_pll_dco.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_hw *a5_pll_hw_clks[] = {
+	[CLKID_MPLL_PREDIV]	= &a5_mpll_prediv.hw,
+	[CLKID_MPLL0_DIV]	= &a5_mpll0_div.hw,
+	[CLKID_MPLL0]		= &a5_mpll0.hw,
+	[CLKID_MPLL1_DIV]	= &a5_mpll1_div.hw,
+	[CLKID_MPLL1]		= &a5_mpll1.hw,
+	[CLKID_MPLL2_DIV]	= &a5_mpll2_div.hw,
+	[CLKID_MPLL2]		= &a5_mpll2.hw,
+	[CLKID_MPLL3_DIV]	= &a5_mpll3_div.hw,
+	[CLKID_MPLL3]		= &a5_mpll3.hw,
+	[CLKID_GP0_PLL_DCO]	= &a5_gp0_pll_dco.hw,
+	[CLKID_GP0_PLL]		= &a5_gp0_pll.hw,
+	[CLKID_HIFI_PLL_DCO]	= &a5_hifi_pll_dco.hw,
+	[CLKID_HIFI_PLL]	= &a5_hifi_pll.hw
+};
+
+static const struct meson_clkc_data a5_pll_clkc_data = {
+	.hw_clks = {
+		.hws = a5_pll_hw_clks,
+		.num = ARRAY_SIZE(a5_pll_hw_clks),
+	},
+};
+
+static const struct of_device_id a5_pll_clkc_match_table[] = {
+	{
+		.compatible = "amlogic,a5-pll-clkc",
+		.data = &a5_pll_clkc_data,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, a5_pll_clkc_match_table);
+
+static struct platform_driver a5_pll_clkc_driver = {
+	.probe = meson_clkc_mmio_probe,
+	.driver = {
+		.name = "a5-pll-clkc",
+		.of_match_table = a5_pll_clkc_match_table,
+	},
+};
+module_platform_driver(a5_pll_clkc_driver);
+
+MODULE_DESCRIPTION("Amlogic A5 PLL Clock Controller driver");
+MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("CLK_MESON");

-- 
2.42.0



