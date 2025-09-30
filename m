Return-Path: <linux-kernel+bounces-837440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA008BAC548
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B354816BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831712FC89C;
	Tue, 30 Sep 2025 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYSzv/FH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511F2F7461;
	Tue, 30 Sep 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225052; cv=none; b=o3p+zPKYXkRQpCVbV8Jb28gcRuxbXVMDdhtC7LTN6/aAh2O6qM05iAbWi+NszkriNQrKoaFepr08IK6GAzJsXjJN7+q5EtyGSPDCiyBfUTT8f++GasgS7/0EtXwydIK30OyzWvCjVaWKAqCACjMxiUlMSpUThFhU4iKT0rlyN+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225052; c=relaxed/simple;
	bh=JhV6skffu+U/f+2pBI+0199BgRiLUbf/66Men8rpJ9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D0vugI150G+HxtuVEkBYR3rCEVbmUPG5EpyNjtn/wEfAqsw2yv20LtWrJziygeDjD88QAnf7jL0ChPKHAi8D0fRm8Zb+u62M89rOZJW5YGESkboNlLTmlAwmlDg6EUP54yszmVxvs0ejoU9QknuVGHVK2B3rzlsMtXQVxMhzU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYSzv/FH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 411CFC2BCB0;
	Tue, 30 Sep 2025 09:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759225052;
	bh=JhV6skffu+U/f+2pBI+0199BgRiLUbf/66Men8rpJ9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TYSzv/FHJ6jv2cSohc4wT8dGy533RYKQLuYlTscYRHLpLJ/2ibgJd5tDuupIZYVYf
	 0dfoubZDQmcK+rxo96GZ5i5Lq8yhvtceHPIXLYaAFUxUiY5vYDuIrJ9Cy6YpO4HwxO
	 LJbVRw6Izqvl1PFljpd7c6OEB7aXkQHuAea/udhg5vfeBIzoXuijXaXAXbUw3mhcme
	 hrWAGMdNkJFNfOgmVf0DjsAPyI0vCVYeNOFK4gnu7KS7qqBnXgzW88NhJFn0tvxCDu
	 PyiWZNja1OI3SbqiRDg2wVV934710o8FM27ghrz/e73RMM528AgWRMPrj2W64hl0AS
	 Gz77WSwBMkAbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363D7CCA470;
	Tue, 30 Sep 2025 09:37:32 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 30 Sep 2025 17:37:28 +0800
Subject: [PATCH 15/19] clk: amlogic: Add A5 PLL clock controller driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-a4_a5_add_clock_driver-v1-15-a9acf7951589@amlogic.com>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
In-Reply-To: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759225047; l=13661;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=IAgkTKQ5BLzjttr74FEQCH4E1ZalhIwg2M7io4Tt3jc=;
 b=Z0WVdsIso0VbUVCLhVeyWbbM1ouMzoGxNvX6+MkS5nXukHaErVZvzjTxRuxEX25QZjVLTWg2O
 1r++KjHWeRiBTXDjnZnt4hGgWWir+0Dimni5GN+RAO80cT2qgdsIKip
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the PLL clock controller driver for the Amlogic A5 SoC family.

Co-developed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/Kconfig  |  14 ++
 drivers/clk/meson/Makefile |   1 +
 drivers/clk/meson/a5-pll.c | 476 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 491 insertions(+)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 860625ca6e9b..db4b98abf4f4 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -158,6 +158,20 @@ config COMMON_CLK_A4_PERIPHERALS
 	  Support for the Peripherals clock controller on Amlogic BA40X device,
 	  AKA A4. Say Y if you want the peripherals clock to work.
 
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
index 88f6b336a6ca..ff73d2486f05 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
 obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
 obj-$(CONFIG_COMMON_CLK_A4_PLL) += a4-pll.o
 obj-$(CONFIG_COMMON_CLK_A4_PERIPHERALS) += a4-peripherals.o
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



