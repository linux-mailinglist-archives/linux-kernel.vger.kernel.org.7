Return-Path: <linux-kernel+bounces-593841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA21A8048A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 14:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73484A2294
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 12:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A43E26A085;
	Tue,  8 Apr 2025 12:00:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DEC3AC1C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113649; cv=none; b=S3VAOYe9UFz7eTXuaYI8h/cfi7mxD7DnLBumjtzYmhwTYeNJAYctTLji8xIYxRpCMyMcQkBW8NbNpmdox403yMMpZDbq3jC4FcejM7ui5LY6d37nJDWeE/NXrW5k6Sh1Xe7XJocnWV9EI9MtgOvN1URawS0igOqbxQDmBF3zj4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113649; c=relaxed/simple;
	bh=SNmgf6M8WFqn6ocasuCuHmlE7wB50v8uTyy6VtweTRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrbTy6VBuCcsrPnOQb7XOcm2jhtez5xK0u+rNSXzUHhA5F8y1Npyms4C2DJ88jaMuii3Zq36NFvEXH6jowJYpyYf7N5WTmCO8d8MkTRyVLATVpus3Wfwogoevz4e2r0Dap2GKqED3kG291oW6Hmgf/pwNDQYST6g4K4e4TGA9X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u27d0-0000jr-Eg; Tue, 08 Apr 2025 14:00:30 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u27d0-003vQ1-0D;
	Tue, 08 Apr 2025 14:00:30 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u27cz-00GJS1-37;
	Tue, 08 Apr 2025 14:00:29 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 08 Apr 2025 14:00:23 +0200
Subject: [PATCH 2/3] clk: add TI CDCE6214 clock driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250408-clk-cdce6214-v1-2-bd4e7092a91f@pengutronix.de>
References: <20250408-clk-cdce6214-v1-0-bd4e7092a91f@pengutronix.de>
In-Reply-To: <20250408-clk-cdce6214-v1-0-bd4e7092a91f@pengutronix.de>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@pengutronix.de, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744113629; l=34175;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=SNmgf6M8WFqn6ocasuCuHmlE7wB50v8uTyy6VtweTRE=;
 b=uMWfyqzuO/ut+z8W4+dvBIcFTCBYIv63R6aRNhPCY7tdKCSSbGy8JVfB32JL6gxfU3rx3zzwR
 XlNzmaFZuLVB9I0NfTNnrrWhZKvaeSay+jz8WJX74xTjzv/lEUjqfM7
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The CDCE6214 is a Ultra-Low Power Clock Generator With One PLL, Four
Differential Outputs, Two Inputs, and Internal EEPROM. This patch adds
a common clk framework driver for this chip.

- Two inputs (PRIREF and SECREF)
- Programmable 8bit divider or x2 multiplier between input and PLL
- 16b integer / 24bit fractional PLL
- Two programmable /4, /5, /6 dividers after PLL (PSA/PSB)
- Four outputs (OUT1-OUT4) with programmable 14b dividers,
  muxable between PSA, PSB and PLL input
- One output (OUT0) fed from PLL input

- PRIREF can be configured as LVCMOS or differential input
- SECREF can be configured as LVCMOS, differential or oscillator input
- OUT0 is a LVCMOS output
- OUT1 and OUT4 can be configured as LVDS, LP-HCSL or LVCMOS outputs
- OUT2 and OUT3 can be configured as LVDS or LP-HCSL outputs

All clocks are registered without parent rate propagation, so each of
the clocks must be configured separately via device tree or consumer.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/Kconfig                     |    7 +
 drivers/clk/Makefile                    |    1 +
 drivers/clk/clk-cdce6214.c              | 1105 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/ti,cdce6214.h |   24 +
 4 files changed, 1137 insertions(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 713573b6c86c7..499fd610c0467 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -170,6 +170,13 @@ config COMMON_CLK_BM1880
 	help
 	  This driver supports the clocks on Bitmain BM1880 SoC.
 
+config COMMON_CLK_CDCE6214
+	tristate "Clock driver for TI CDCE6214 clock synthesizer"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver supports TI CDCE6214 programmable 1-PLL clock synthesizer.
+
 config COMMON_CLK_CDCE706
 	tristate "Clock driver for TI CDCE706 clock synthesizer"
 	depends on I2C
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index bf4bd45adc3a0..0f87b13b137b5 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
 obj-$(CONFIG_COMMON_CLK_BD718XX)	+= clk-bd718x7.o
 obj-$(CONFIG_COMMON_CLK_BM1880)		+= clk-bm1880.o
+obj-$(CONFIG_COMMON_CLK_CDCE6214)	+= clk-cdce6214.o
 obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
 obj-$(CONFIG_COMMON_CLK_CDCE925)	+= clk-cdce925.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
diff --git a/drivers/clk/clk-cdce6214.c b/drivers/clk/clk-cdce6214.c
new file mode 100644
index 0000000000000..a825cd71bb11b
--- /dev/null
+++ b/drivers/clk/clk-cdce6214.c
@@ -0,0 +1,1105 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the TI CDCE6214 clock generator
+ *
+ * Copyright (c) 2023 Alvin Šipraga <alsi@bang-olufsen.dk>
+ * Copyright (c) 2025 Sascha Hauer <s.hauer@pengutronix.de>
+ */
+
+#include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <dt-bindings/clock/ti,cdce6214.h>
+
+#define RO_I2C_A0			BIT(15)
+#define RO_PDN_INPUT_SEL		BIT(14)
+#define RO_GPIO4_DIR_SEL		BIT(13)
+#define RO_GPIO1_DIR_SEL		BIT(12)
+#define RO_ZDM_CLOCKSEL			BIT(10)
+#define RO_ZDM_EN			BIT(8)
+#define RO_SYNC				BIT(5)
+#define RO_RECAL			BIT(4)
+#define RO_RESETN_SOFT			BIT(3)
+#define RO_SWRST			BIT(2)
+#define RO_POWERDOWN			BIT(1)
+#define RO_MODE				BIT(0)
+
+#define R1_GPIO4_INPUT_SEL		GENMASK(15, 12)
+#define R1_GPIO3_INPUT_SEL		GENMASK(11, 8)
+#define R1_GPIO2_INPUT_SEL		GENMASK(7, 4)
+#define R1_GPIO1_INPUT_SEL		GENMASK(3, 0)
+
+#define R2_GPIO4_OUTPUT_SEL		GENMASK(9, 6)
+#define R2_GPIO1_OUTPUT_SEL		GENMASK(5, 2)
+#define R2_REFSEL_SW			GENMASK(1, 0)
+
+#define R3_DISABLE_CRC			BIT(13)
+#define R3_UPDATE_CRC			BIT(12)
+#define R3_NVMCOMMIT			BIT(11)
+#define R3_REGCOMMIT			BIT(10)
+#define R3_REGCOMMIT_PAGE		BIT(9)
+#define R3_FREQ_DEC_REG			BIT(6)
+#define R3_FREQ_INC_REG			BIT(5)
+#define R3_FREQ_INC_DEC_REG_MODE	BIT(4)
+#define R3_FREQ_INC_DEC_EN		BIT(3)
+
+#define R4_CH4_PD			BIT(7)
+#define R4_CH3_PD			BIT(6)
+#define R4_CH2_PD			BIT(5)
+#define R4_CH1_PD			BIT(4)
+#define R4_POST_EE_DLY			GENMASK(3, 0)
+
+#define R5_PLL_VCOBUFF_LDO_PD		BIT(8)
+#define R5_PLL_VCO_LDO_PD		BIT(7)
+#define R5_PLL_VCO_BUFF_PD		BIT(6)
+#define R5_PLL_CP_LDO_PD		BIT(5)
+#define R5_PLL_LOCKDET_PD		BIT(4)
+#define R5_PLL_PSB_PD			BIT(3)
+#define R5_PLL_PSA_PD			BIT(2)
+#define R5_PLL_PFD_PD			BIT(1)
+
+#define R7_NVMCRCERR			BIT(5)
+#define R7_LOCK_DET_S			BIT(1)
+#define R7_LOCK_DET			BIT(0)
+
+#define R9_NVMLCRC			GENMASK(15, 0)
+
+#define R10_NVMSCRC			GENMASK(15, 0)
+
+#define R11_NVM_RD_ADDR			GENMASK(5, 0)
+
+#define R12_NVM_RD_DATA			GENMASK(15, 0)
+
+#define R13_NVM_WR_ADDR			GENMASK(5, 0)
+
+#define R14_NVM_WR_DATA			GENMASK(15, 0)
+
+#define R15_EE_LOCK			GENMASK(15, 12)
+#define R15_CAL_MUTE			BIT(5)
+
+#define R24_IP_PRIREF_BUF_SEL		BIT(15)
+#define R24_IP_XO_CLOAD			GENMASK(12, 8)
+#define R24_IP_BIAS_SEL_XO		GENMASK(5, 2)
+#define R24_IP_SECREF_BUF_SEL		GENMASK(1, 0)
+#define R24_IP_SECREF_BUF_SEL_XTAL	0
+#define R24_IP_SECREF_BUF_SEL_LVCMOS	1
+#define R24_IP_SECREF_BUF_SEL_DIFF	2
+
+#define R25_IP_REF_TO_OUT4_EN		BIT(14)
+#define R25_IP_REF_TO_OUT3_EN		BIT(13)
+#define R25_IP_REF_TO_OUT2_EN		BIT(12)
+#define R25_IP_REF_TO_OUT1_EN		BIT(11)
+#define R25_IP_BYP_OUT0_EN		BIT(10)
+#define R25_REF_CH_MUX			BIT(9)
+#define R25_IP_RDIV			GENMASK(7, 0)
+
+#define R27_MASH_ORDER			GENMASK(1, 0)
+
+#define R30_PLL_NDIV			GENMASK(14, 0)
+
+#define R31_PLL_NUM_15_0		GENMASK(15, 0)
+
+#define R32_PLL_NUM_23_16		GENMASK(7, 0)
+
+#define R33_PLL_DEN_15_0		GENMASK(15, 0)
+
+#define R34_PLL_DEN_23_16		GENMASK(7, 0)
+
+#define R41_SSC_EN			BIT(15)
+
+#define R42_SSC_TYPE			BIT(5)
+#define R42_SSC_SEL			GENMASK(3, 1)
+
+#define R43_FREQ_INC_DEC_DELTA		GENMASK(15, 0)
+
+#define R47_PLL_CP_DN			GENMASK(12, 7)
+#define R47_PLL_PSB			GENMASK(6, 5)
+#define R47_PLL_PSA			GENMASK(4, 3)
+
+#define R48_PLL_LF_RES			GENMASK(14, 11)
+#define R48_PLL_CP_UP			GENMASK(5, 0)
+
+#define R49_PLL_LF_ZCAP			GENMASK(4, 0)
+
+#define R50_PLL_LOCKDET_WINDOW		GENMASK(10, 8)
+
+#define R51_PLL_PFD_DLY_EN		BIT(10)
+#define R51_PLL_PFD_CTRL		BIT(6)
+
+#define R52_PLL_NCTRL_EN		BIT(6)
+#define R52_PLL_CP_EN			BIT(3)
+
+#define R55_PLL_LF_3_PCTRIM		GENMASK(9, 8)
+#define R55_PLL_LF_3_PRTRIM		GENMASK(7, 6)
+
+#define R56_CH1_MUX			GENMASK(15, 14)
+#define R56_CH1_DIV			GENMASK(13, 0)
+
+#define R57_CH1_LPHCSL_EN		BIT(14)
+#define R57_CH1_1P8VDET			BIT(12)
+#define R57_CH1_GLITCHLESS_EN		BIT(9)
+#define R57_CH1_SYNC_DELAY		GENMASK(8, 4)
+#define R57_CH1_SYNC_EN			BIT(3)
+#define R57_CH1_MUTE_SEL		BIT(1)
+#define R57_CH1_MUTE			BIT(0)
+
+#define R59_CH1_LVDS_EN			BIT(15)
+#define R59_CH1_CMOSN_EN		BIT(14)
+#define R59_CH1_CMOSP_EN		BIT(13)
+#define R59_CH1_CMOSN_POL		BIT(12)
+#define R59_CH1_CMOSP_POL		BIT(11)
+
+#define R60_CH1_DIFFBUF_IBIAS_TRIM	GENMASK(15, 12)
+#define R60_CH1_LVDS_CMTRIM_INC		GENMASK(11, 10)
+#define R60_CH1_LVDS_CMTRIM_DEC		GENMASK(5, 4)
+#define R60_CH1_CMOS_SLEW_RATE_CTRL	GENMASK(3, 0)
+
+#define R62_CH2_MUX			GENMASK(15, 14)
+#define R62_CH2_DIV			GENMASK(13, 0)
+
+#define R63_CH2_LPHCSL_EN		BIT(13)
+#define R63_CH2_1P8VDET			BIT(12)
+#define R63_CH2_GLITCHLESS_EN		BIT(9)
+#define R63_CH2_SYNC_DELAY		GENMASK(8, 4)
+#define R63_CH2_SYNC_EN			BIT(3)
+#define R63_CH2_MUTE_SEL		BIT(1)
+#define R63_CH2_MUTE			BIT(0)
+
+#define R65_CH2_LVDS_CMTRIM_DEC		GENMASK(14, 13)
+#define R65_CH2_LVDS_EN			BIT(11)
+
+#define R66_CH2_LVDS_CMTRIM_IN		GENMASK(5, 4)
+#define R66_CH2_DIFFBUF_IBIAS_TRIM	GENMASK(3, 0)
+
+#define R67_CH3_MUX			GENMASK(15, 14)
+#define R67_CH3_DIV			GENMASK(13, 0)
+
+#define R68_CH3_LPHCSL_EN		BIT(13)
+#define R68_CH3_1P8VDET			BIT(12)
+#define R68_CH3_GLITCHLESS_EN		BIT(9)
+#define R68_CH3_SYNC_DELAY		GENMASK(8, 4)
+#define R68_CH3_SYNC_EN			BIT(3)
+#define R68_CH3_MUTE_SEL		BIT(1)
+#define R68_CH3_MUTE			BIT(0)
+
+#define R70_CH3_LVDS_EN			BIT(11)
+
+#define R71_CH3_LVDS_CMTRIM_DEC		GENMASK(10, 9)
+#define R71_CH3_LVDS_CMTRIM_INC		GENMASK(5, 4)
+#define R71_CH3_DIFFBUF_IBIAS_TR	GENMASK(3, 0)
+
+#define R72_CH4_MUX			GENMASK(15, 14)
+#define R72_CH4_DIV			GENMASK(13, 0)
+
+#define R73_CH4_LPHCSL_EN		BIT(13)
+#define R73_CH4_1P8VDET			BIT(12)
+#define R73_CH4_GLITCHLESS_EN		BIT(9)
+#define R73_CH4_SYNC_DELAY		GENMASK(8, 4)
+#define R73_CH4_SYNC_EN			BIT(3)
+#define R73_CH4_MUTE_SEL		BIT(1)
+#define R73_CH4_MUTE			BIT(0)
+
+#define R75_CH4_LVDS_EN			BIT(15)
+#define R75_CH4_CMOSP_EN		BIT(14)
+#define R75_CH4_CMOSN_EN		BIT(13)
+#define R75_CH4_CMOSP_POL		BIT(12)
+#define R75_CH4_CMOSN_POL		BIT(11)
+
+#define R76_CH4_DIFFBUF_IBIAS_TRIM	GENMASK(9, 6)
+#define R76_CH4_LVDS_CMTRIM_IN		GENMASK(5, 4)
+#define R76_CH4_CMOS_SLEW_RATE_CTRL	GENMASK(3, 0)
+
+#define R77_CH4_LVDS_CMTRIM_DEC		GENMASK(1, 0)
+
+#define R78_CH0_EN			BIT(12)
+
+#define R79_SAFETY_1P8V_MODE		BIT(9)
+#define R79_CH0_CMOS_SLEW_RATE_CTRL	GENMASK(3, 0)
+
+#define R81_PLL_LOCK_MASK		BIT(3)
+
+#define CDCE6214_VCO_MIN 2335000000
+#define CDCE6214_VCO_MAX 2625000000
+#define CDCE6214_DENOM_DEFAULT (1 << 24)
+
+static char *clk_names[] = {
+	[CDCE6214_CLK_PRIREF] = "priref",
+	[CDCE6214_CLK_SECREF] = "secref",
+	[CDCE6214_CLK_OUT0] = "out0",
+	[CDCE6214_CLK_OUT1] = "out1",
+	[CDCE6214_CLK_OUT2] = "out2",
+	[CDCE6214_CLK_OUT3] = "out3",
+	[CDCE6214_CLK_OUT4] = "out4",
+	[CDCE6214_CLK_PLL] = "pll",
+	[CDCE6214_CLK_PSA] = "psa",
+	[CDCE6214_CLK_PSB] = "psb",
+};
+
+#define CDCE6214_NUM_CLOCKS	ARRAY_SIZE(clk_names)
+
+struct cdce6214;
+
+struct cdce6214_clock {
+	struct clk_hw hw;
+	struct cdce6214 *priv;
+	int index;
+};
+
+struct cdce6214_config {
+	const struct reg_default *reg_default;
+	int reg_default_size;
+};
+
+struct cdce6214 {
+	struct i2c_client *client;
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *reset_gpio;
+	const struct cdce6214_config *config;
+	struct cdce6214_clock clk[CDCE6214_NUM_CLOCKS];
+};
+
+static inline struct cdce6214_clock *hw_to_cdce6214_clk(struct clk_hw *hw)
+{
+	return container_of(hw, struct cdce6214_clock, hw);
+}
+
+static struct clk_hw *cdce6214_of_clk_get(struct of_phandle_args *clkspec,
+					  void *data)
+{
+	struct cdce6214 *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= CDCE6214_NUM_CLOCKS)
+		return ERR_PTR(-EINVAL);
+	if (idx <= CDCE6214_CLK_SECREF)
+		return ERR_PTR(-EINVAL);
+
+	return &priv->clk[idx].hw;
+}
+
+static const struct regmap_config cdce6214_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 16,
+	.reg_stride = 1,
+	.max_register = 0x0055,
+};
+
+static int cdce6214_configure(struct cdce6214 *priv)
+{
+	regmap_update_bits(priv->regmap, 2, R2_REFSEL_SW,
+			   FIELD_PREP(R2_REFSEL_SW, 2));
+
+	return 0;
+}
+
+static unsigned long cdce6214_clk_out0_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int val, div;
+
+	regmap_read(priv->regmap, 25, &val);
+
+	div = FIELD_GET(R25_IP_RDIV, val);
+
+	if (!div)
+		return parent_rate * 2;
+
+	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
+}
+
+static long cdce6214_clk_out0_round_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long *best_parent_rate)
+{
+	unsigned int div;
+
+	if (rate >= *best_parent_rate)
+		return *best_parent_rate * 2;
+
+	div = DIV_ROUND_CLOSEST(*best_parent_rate, rate);
+
+	return DIV_ROUND_UP_ULL((u64)*best_parent_rate, div);
+}
+
+static int cdce6214_clk_out0_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int div;
+
+	if (rate >= parent_rate) {
+		regmap_update_bits(priv->regmap, 25, R25_IP_RDIV, FIELD_PREP(R25_IP_RDIV, 0));
+		return 0;
+	}
+
+	div = DIV_ROUND_CLOSEST(parent_rate, rate);
+	if (div > R25_IP_RDIV)
+		div = R25_IP_RDIV;
+
+	regmap_update_bits(priv->regmap, 25, R25_IP_RDIV, FIELD_PREP(R25_IP_RDIV, div));
+
+	return 0;
+}
+
+static u8 cdce6214_clk_out0_get_parent(struct clk_hw *hw)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int val, idx;
+
+	regmap_read(priv->regmap, 2, &val);
+
+	idx = FIELD_GET(R2_REFSEL_SW, val);
+
+	switch (idx) {
+		case 0:
+		case 1:
+			idx = 0;
+			break;
+		case 2:
+			idx = 1;
+			break;
+		case 3:
+			idx = 0;
+			break;
+	};
+
+	return idx;
+}
+
+static int cdce6214_clk_out0_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+
+	regmap_update_bits(priv->regmap, 25, R25_REF_CH_MUX, FIELD_PREP(R25_REF_CH_MUX, index));
+
+	return 0;
+}
+
+static const struct clk_ops cdce6214_clk_out0_ops = {
+	.recalc_rate = cdce6214_clk_out0_recalc_rate,
+	.round_rate = cdce6214_clk_out0_round_rate,
+	.set_rate = cdce6214_clk_out0_set_rate,
+	.get_parent = cdce6214_clk_out0_get_parent,
+	.set_parent = cdce6214_clk_out0_set_parent,
+};
+
+static int cdce6214_clk_out_ldo(struct clk_hw *hw, int enable)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int mask, val;
+
+	switch (clock->index) {
+	case CDCE6214_CLK_OUT1:
+		mask = R4_CH1_PD;
+		break;
+	case CDCE6214_CLK_OUT2:
+		mask = R4_CH2_PD;
+		break;
+	case CDCE6214_CLK_OUT3:
+		mask = R4_CH3_PD;
+		break;
+	case CDCE6214_CLK_OUT4:
+		mask = R4_CH4_PD;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	if (enable > 0) {
+		regmap_clear_bits(priv->regmap, 4, mask);
+	} else if (!enable) {
+		regmap_set_bits(priv->regmap, 4, mask);
+	} else {
+		regmap_read(priv->regmap, 4, &val);
+		return !(val & mask);
+	}
+
+	return 0;
+}
+
+static int cdce6214_clk_out_prepare(struct clk_hw *hw)
+{
+	return cdce6214_clk_out_ldo(hw, 1);
+}
+
+static void cdce6214_clk_out_unprepare(struct clk_hw *hw)
+{
+	cdce6214_clk_out_ldo(hw, 0);
+}
+
+static int cdce6214_clk_out_is_prepared(struct clk_hw *hw)
+{
+	return cdce6214_clk_out_ldo(hw, -1);
+}
+
+static unsigned long cdce6214_clk_out_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int val, div;
+	unsigned long r;
+
+	switch (clock->index) {
+	case CDCE6214_CLK_OUT1:
+		regmap_read(priv->regmap, 56, &val);
+		div = FIELD_GET(R56_CH1_DIV, val);
+		break;
+	case CDCE6214_CLK_OUT2:
+		regmap_read(priv->regmap, 62, &val);
+		div = FIELD_GET(R62_CH2_DIV, val);
+		break;
+	case CDCE6214_CLK_OUT3:
+		regmap_read(priv->regmap, 67, &val);
+		div = FIELD_GET(R67_CH3_DIV, val);
+		break;
+	case CDCE6214_CLK_OUT4:
+		regmap_read(priv->regmap, 72, &val);
+		div = FIELD_GET(R72_CH4_DIV, val);
+		break;
+	};
+
+	if (!div)
+		div = 1;
+
+	r = DIV_ROUND_UP_ULL((u64)parent_rate, div);
+
+	return r;
+}
+
+static int cdce6214_get_out_div(unsigned long rate, unsigned long parent_rate)
+{
+	unsigned int div = DIV_ROUND_CLOSEST(parent_rate, rate);
+
+	if (div < 1)
+		div = 1;
+
+	if (div > R72_CH4_DIV)
+		div = R72_CH4_DIV;
+
+	return div;
+}
+
+static long cdce6214_clk_out_round_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long *best_parent_rate)
+{
+	unsigned int div = cdce6214_get_out_div(rate, *best_parent_rate);
+
+	return DIV_ROUND_UP_ULL((u64)*best_parent_rate, div);
+}
+
+static int cdce6214_clk_out_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	unsigned int div = cdce6214_get_out_div(rate, parent_rate);
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+
+	switch (clock->index) {
+	case CDCE6214_CLK_OUT1:
+		regmap_update_bits(priv->regmap, 56, R56_CH1_DIV,
+				   FIELD_PREP(R56_CH1_DIV, div));
+		break;
+	case CDCE6214_CLK_OUT2:
+		regmap_update_bits(priv->regmap, 62, R62_CH2_DIV,
+				   FIELD_PREP(R62_CH2_DIV, div));
+		break;
+	case CDCE6214_CLK_OUT3:
+		regmap_update_bits(priv->regmap, 67, R67_CH3_DIV,
+				   FIELD_PREP(R67_CH3_DIV, div));
+		break;
+	case CDCE6214_CLK_OUT4:
+		regmap_update_bits(priv->regmap, 72, R72_CH4_DIV,
+				   FIELD_PREP(R72_CH4_DIV, div));
+		break;
+	};
+
+	return 0;
+}
+
+static u8 cdce6214_clk_out_get_parent(struct clk_hw *hw)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int val, idx;
+
+	switch (clock->index) {
+	case CDCE6214_CLK_OUT1:
+		regmap_read(priv->regmap, 56, &val);
+		idx = FIELD_GET(R56_CH1_MUX, val);
+		break;
+	case CDCE6214_CLK_OUT2:
+		regmap_read(priv->regmap, 62, &val);
+		idx = FIELD_GET(R62_CH2_MUX, val);
+		break;
+	case CDCE6214_CLK_OUT3:
+		regmap_read(priv->regmap, 67, &val);
+		idx = FIELD_GET(R67_CH3_MUX, val);
+		break;
+	case CDCE6214_CLK_OUT4:
+		regmap_read(priv->regmap, 72, &val);
+		idx = FIELD_GET(R72_CH4_MUX, val);
+		break;
+	};
+
+	return idx;
+}
+
+static int cdce6214_clk_out_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+
+	switch (clock->index) {
+	case CDCE6214_CLK_OUT1:
+		regmap_update_bits(priv->regmap, 56, R56_CH1_MUX, FIELD_PREP(R56_CH1_MUX, index));
+		break;
+	case CDCE6214_CLK_OUT2:
+		regmap_update_bits(priv->regmap, 62, R62_CH2_MUX, FIELD_PREP(R62_CH2_MUX, index));
+		break;
+	case CDCE6214_CLK_OUT3:
+		regmap_update_bits(priv->regmap, 67, R67_CH3_MUX, FIELD_PREP(R67_CH3_MUX, index));
+		break;
+	case CDCE6214_CLK_OUT4:
+		regmap_update_bits(priv->regmap, 72, R72_CH4_MUX, FIELD_PREP(R72_CH4_MUX, index));
+		break;
+	};
+
+	return 0;
+}
+
+static const struct clk_ops cdce6214_clk_out_ops = {
+	.prepare = cdce6214_clk_out_prepare,
+	.unprepare = cdce6214_clk_out_unprepare,
+	.is_prepared = cdce6214_clk_out_is_prepared,
+	.recalc_rate = cdce6214_clk_out_recalc_rate,
+	.round_rate = cdce6214_clk_out_round_rate,
+	.set_rate = cdce6214_clk_out_set_rate,
+	.get_parent = cdce6214_clk_out_get_parent,
+	.set_parent = cdce6214_clk_out_set_parent,
+};
+
+static int pll_calc_values(unsigned long parent_rate, unsigned long out,
+			   unsigned long *ndiv, unsigned long *num, unsigned long *den)
+{
+	u64 a;
+
+	if (out < CDCE6214_VCO_MIN || out > CDCE6214_VCO_MAX)
+		return -EINVAL;
+
+	*den = 10000000;
+	*ndiv = out / parent_rate;
+	a = (out % parent_rate);
+	a *= *den;
+	do_div(a, parent_rate);
+	*num = a;
+
+	return 0;
+}
+
+static unsigned long cdce6214_clk_pll_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned long ndiv, num, den;
+	unsigned int val;
+
+	regmap_read(priv->regmap, 30, &val);
+	ndiv = FIELD_GET(R30_PLL_NDIV, val);
+
+	regmap_read(priv->regmap, 31, &val);
+	num = FIELD_GET(R31_PLL_NUM_15_0, val);
+
+	regmap_read(priv->regmap, 32, &val);
+	num |= FIELD_GET(R32_PLL_NUM_23_16, val) << 16;
+
+	regmap_read(priv->regmap, 33, &val);
+	den = FIELD_GET(R33_PLL_DEN_15_0, val);
+
+	regmap_read(priv->regmap, 34, &val);
+	den |= FIELD_GET(R34_PLL_DEN_23_16, val) << 16;
+
+	if (!den)
+		den = CDCE6214_DENOM_DEFAULT;
+
+	return parent_rate * ndiv + DIV_ROUND_CLOSEST(parent_rate * num, den);
+}
+
+static long cdce6214_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long *best_parent_rate)
+{
+	if (rate < CDCE6214_VCO_MIN)
+		rate = CDCE6214_VCO_MIN;
+	if (rate > CDCE6214_VCO_MAX)
+		rate = CDCE6214_VCO_MAX;
+	if (rate < *best_parent_rate * 24)
+		return -EINVAL;
+
+	return rate;
+}
+
+static bool cdce6214_pll_locked(struct cdce6214 *priv)
+{
+	unsigned int val;
+
+	regmap_read(priv->regmap, 7, &val);
+
+	return val & R7_LOCK_DET;
+}
+
+static int cdce6214_wait_pll_lock(struct cdce6214 *priv)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read_poll_timeout(priv->regmap, 7, val,
+				       val & R7_LOCK_DET, 0, 1000);
+	if (ret)
+		dev_err(priv->dev, "Timeout waiting for PLL lock\n");
+
+	return ret;
+}
+
+#define R5_PLL_POWER_BITS (R5_PLL_VCOBUFF_LDO_PD | \
+			   R5_PLL_VCO_LDO_PD | \
+			   R5_PLL_VCO_BUFF_PD)
+
+static int cdce6214_clk_pll_prepare(struct clk_hw *hw)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+
+	regmap_clear_bits(priv->regmap, 5, R5_PLL_POWER_BITS);
+
+	regmap_set_bits(priv->regmap, 0, RO_RECAL);
+
+	return cdce6214_wait_pll_lock(priv);
+}
+
+static void cdce6214_clk_pll_unprepare(struct clk_hw *hw)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+
+	regmap_set_bits(priv->regmap, 5, R5_PLL_POWER_BITS);
+}
+
+static bool cdce6214_clk_pll_powered(struct cdce6214 *priv)
+{
+	unsigned int val;
+
+	regmap_read(priv->regmap, 5, &val);
+
+	return (val & R5_PLL_POWER_BITS) == 0;
+}
+
+static int cdce6214_clk_pll_is_prepared(struct clk_hw *hw)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+
+	return cdce6214_pll_locked(priv);
+}
+
+static int cdce6214_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned long ndiv, num, den;
+	int ret;
+
+	ret = pll_calc_values(parent_rate, rate, &ndiv, &num, &den);
+	if (ret < 0)
+		return ret;
+
+	if (den == CDCE6214_DENOM_DEFAULT)
+		den = 0;
+
+	regmap_update_bits(priv->regmap, 34, R34_PLL_DEN_23_16,
+			   FIELD_PREP(R34_PLL_DEN_23_16, den >> 16));
+	regmap_update_bits(priv->regmap, 33, R33_PLL_DEN_15_0,
+			   FIELD_PREP(R33_PLL_DEN_15_0, den & 0xffff));
+	regmap_update_bits(priv->regmap, 32, R32_PLL_NUM_23_16,
+			   FIELD_PREP(R32_PLL_NUM_23_16, num >> 16));
+	regmap_update_bits(priv->regmap, 31, R31_PLL_NUM_15_0,
+			   FIELD_PREP(R31_PLL_NUM_15_0, num & 0xffff));
+	regmap_update_bits(priv->regmap, 30, R30_PLL_NDIV,
+			   FIELD_PREP(R30_PLL_NDIV, ndiv));
+
+	regmap_update_bits(priv->regmap, 3, R3_FREQ_INC_DEC_REG_MODE | R3_FREQ_INC_DEC_EN,
+			   R3_FREQ_INC_DEC_REG_MODE | R3_FREQ_INC_DEC_EN);
+
+	if (cdce6214_clk_pll_powered(priv)) {
+		regmap_set_bits(priv->regmap, 0, RO_RECAL);
+		ret = cdce6214_wait_pll_lock(priv);
+	}
+
+	return ret;
+}
+
+static const struct clk_ops cdce6214_clk_pll_ops = {
+	.prepare = cdce6214_clk_pll_prepare,
+	.unprepare = cdce6214_clk_pll_unprepare,
+	.is_prepared = cdce6214_clk_pll_is_prepared,
+	.recalc_rate = cdce6214_clk_pll_recalc_rate,
+	.round_rate = cdce6214_clk_pll_round_rate,
+	.set_rate = cdce6214_clk_pll_set_rate,
+};
+
+static int cdce6214_clk_psx_ldo(struct clk_hw *hw, int enable)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int mask, val;
+
+	switch (clock->index) {
+	case CDCE6214_CLK_PSA:
+		mask = R5_PLL_PSA_PD;
+		break;
+	case CDCE6214_CLK_PSB:
+		mask = R5_PLL_PSB_PD;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	if (enable > 0 ) {
+		regmap_clear_bits(priv->regmap, 5, mask);
+	} else if (!enable) {
+		regmap_set_bits(priv->regmap, 5, mask);
+	} else {
+		regmap_read(priv->regmap, 5, &val);
+
+		return !(val & mask);
+	}
+
+	return 0;
+}
+
+static int cdce6214_clk_psx_prepare(struct clk_hw *hw)
+{
+	return cdce6214_clk_psx_ldo(hw, 1);
+}
+
+static void cdce6214_clk_psx_unprepare(struct clk_hw *hw)
+{
+	cdce6214_clk_psx_ldo(hw, 0);
+}
+
+static int cdce6214_clk_psx_is_prepared(struct clk_hw *hw)
+{
+	return cdce6214_clk_psx_ldo(hw, -1);
+}
+
+static unsigned long cdce6214_clk_psx_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int psx[] = { 4, 5, 6, 6 };
+	unsigned int val, div;
+
+	regmap_read(priv->regmap, 47, &val);
+
+	switch (clock->index) {
+	case CDCE6214_CLK_PSA:
+		div = psx[FIELD_GET(R47_PLL_PSA, val)];
+		break;
+	case CDCE6214_CLK_PSB:
+		div = psx[FIELD_GET(R47_PLL_PSB, val)];
+		break;
+	};
+
+	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
+}
+
+static int cdce6214_get_psx_div(unsigned long rate, unsigned long parent_rate)
+{
+	unsigned int div = DIV_ROUND_CLOSEST(parent_rate, rate);
+
+	if (div < 4)
+		div = 4;
+
+	if (div > 6)
+		div = 6;
+
+	return div;
+}
+
+static long cdce6214_clk_psx_round_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long *best_parent_rate)
+{
+	unsigned int div = cdce6214_get_psx_div(rate, *best_parent_rate);
+
+	return DIV_ROUND_UP_ULL((u64)*best_parent_rate, div);
+}
+
+static int cdce6214_clk_psx_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	unsigned int div = cdce6214_get_psx_div(rate, parent_rate);
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+
+	switch (clock->index) {
+	case CDCE6214_CLK_PSA:
+		regmap_update_bits(priv->regmap, 47, R47_PLL_PSA,
+				   FIELD_PREP(R47_PLL_PSA, div));
+		break;
+	case CDCE6214_CLK_PSB:
+		regmap_update_bits(priv->regmap, 47, R47_PLL_PSB,
+				   FIELD_PREP(R47_PLL_PSB, div));
+		break;
+	};
+	
+	return 0;
+}
+
+static const struct clk_ops cdce6214_clk_psx_ops = {
+	.prepare = cdce6214_clk_psx_prepare,
+	.unprepare = cdce6214_clk_psx_unprepare,
+	.is_prepared = cdce6214_clk_psx_is_prepared,
+	.recalc_rate = cdce6214_clk_psx_recalc_rate,
+	.round_rate = cdce6214_clk_psx_round_rate,
+	.set_rate = cdce6214_clk_psx_set_rate,
+};
+
+static int cdce6214_clk_register(struct cdce6214 *priv)
+{
+	struct clk_init_data init[CDCE6214_NUM_CLOCKS] = { 0 };
+	struct clk_parent_data pdata_out0[2] = {};
+	struct clk_parent_data pdata_out[4] = {};
+	struct clk_parent_data pdata_pll = {};
+	struct clk_parent_data pdata_psx = {};
+	int i, ret;
+
+	pdata_out0[0].fw_name = "priref";
+	pdata_out0[1].fw_name = "secref";
+
+	init[CDCE6214_CLK_OUT0].ops = &cdce6214_clk_out0_ops;
+	init[CDCE6214_CLK_OUT0].num_parents = 2;
+	init[CDCE6214_CLK_OUT0].parent_data = pdata_out0;
+	init[CDCE6214_CLK_OUT0].flags = CLK_SET_RATE_NO_REPARENT;
+
+	pdata_out[0].hw = &priv->clk[CDCE6214_CLK_PSA].hw;
+	pdata_out[1].hw = &priv->clk[CDCE6214_CLK_PSB].hw;
+	pdata_out[3].hw = &priv->clk[CDCE6214_CLK_OUT0].hw;
+
+	for (i = CDCE6214_CLK_OUT1; i <= CDCE6214_CLK_OUT4; i++) {
+		init[i].ops = &cdce6214_clk_out_ops;
+		init[i].num_parents = 4;
+		init[i].parent_data = pdata_out;
+		init[i].flags = CLK_SET_RATE_NO_REPARENT;
+	}
+
+	init[CDCE6214_CLK_PLL].ops = &cdce6214_clk_pll_ops;
+	init[CDCE6214_CLK_PLL].num_parents = 1;
+	pdata_pll.hw = &priv->clk[CDCE6214_CLK_OUT0].hw;
+	init[CDCE6214_CLK_PLL].parent_data = &pdata_pll;
+
+	pdata_psx.hw = &priv->clk[CDCE6214_CLK_PLL].hw;
+	for (i = CDCE6214_CLK_PSA; i <= CDCE6214_CLK_PSB; i++) {
+		init[i].ops = &cdce6214_clk_psx_ops;
+		init[i].num_parents = 1;
+		init[i].parent_data = &pdata_psx;
+	}
+
+	for (i = 0; i < CDCE6214_NUM_CLOCKS; i++) {
+		struct cdce6214_clock *clk = &priv->clk[i];
+		char name[128];
+
+		if (!init[i].ops)
+			continue;
+
+		snprintf(name, sizeof(name), "%s_%s", dev_name(priv->dev), clk_names[i]);
+		init[i].name = name;
+		clk->hw.init = &init[i];
+		clk->priv = priv;
+		clk->index = i;
+		ret = devm_clk_hw_register(priv->dev, &clk->hw);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static inline int regmap_clrset_bit(struct cdce6214 *priv, unsigned int reg,
+				    unsigned int bit, bool set)
+{
+	return regmap_update_bits(priv->regmap, reg, bit, set ? bit : 0);
+}
+
+static int cdce6214_parse_subnode(struct cdce6214 *priv, struct device_node *np)
+{
+	unsigned int idx, mode;
+	struct cdce6214_clock *clk;
+	bool lphcsl, lvds, cmosp, cmosn, ref_xtal, ref_lvcmos, ref_diff;
+	int ret;
+
+	ret = of_property_read_u32(np, "reg", &idx);
+	if (ret) {
+		dev_err(priv->dev, "missing reg property in child: %s\n",
+			np->full_name);
+		return ret;
+	}
+
+	if (idx >= CDCE6214_NUM_CLOCKS)
+		return -EINVAL;
+
+	clk = &priv->clk[idx];
+
+	lphcsl = of_property_read_bool(np, "ti,lphcsl");
+	lvds = of_property_read_bool(np, "ti,lvds");
+	cmosp = of_property_read_bool(np, "ti,cmosp");
+	cmosn = of_property_read_bool(np, "ti,cmosn");
+
+	ref_xtal = of_property_read_bool(np, "ti,ref-xtal");
+	ref_lvcmos = of_property_read_bool(np, "ti,ref-lvcmos");
+	ref_diff = of_property_read_bool(np, "ti,ref-diff");
+
+	switch (idx) {
+	case CDCE6214_CLK_OUT1:
+		regmap_clrset_bit(priv, 57, R57_CH1_LPHCSL_EN, lphcsl);
+		regmap_clrset_bit(priv, 59, R59_CH1_LVDS_EN, lvds);
+		regmap_clrset_bit(priv, 59, R59_CH1_CMOSP_EN, cmosp);
+		regmap_clrset_bit(priv, 59, R59_CH1_CMOSN_EN, cmosn);
+		lphcsl = lvds = cmosp = cmosn = false;
+		break;
+	case CDCE6214_CLK_OUT2:
+		regmap_clrset_bit(priv, 63, R63_CH2_LPHCSL_EN, lphcsl);
+		regmap_clrset_bit(priv, 65, R65_CH2_LVDS_EN, lvds);
+		lphcsl = lvds = false;
+		break;
+	case CDCE6214_CLK_OUT3:
+		regmap_clrset_bit(priv, 68, R68_CH3_LPHCSL_EN, lphcsl);
+		regmap_clrset_bit(priv, 70, R70_CH3_LVDS_EN, lvds);
+		lphcsl = lvds = false;
+		break;
+	case CDCE6214_CLK_OUT4:
+		regmap_clrset_bit(priv, 73, R73_CH4_LPHCSL_EN, lphcsl);
+		regmap_clrset_bit(priv, 75, R75_CH4_LVDS_EN, lvds);
+		regmap_clrset_bit(priv, 75, R75_CH4_CMOSP_EN, cmosp);
+		regmap_clrset_bit(priv, 75, R75_CH4_CMOSN_EN, cmosn);
+		lphcsl = lvds = cmosp = cmosn = false;
+		break;
+	case CDCE6214_CLK_PRIREF:
+		if (ref_lvcmos + ref_diff != 1) {
+			dev_err(priv->dev, "Multiple or no input modes in %pOF\n", np);
+			return -EINVAL;
+		}
+
+		if (ref_lvcmos)
+			regmap_clear_bits(priv->regmap, 24, R24_IP_PRIREF_BUF_SEL);
+		if (ref_diff)
+			regmap_set_bits(priv->regmap, 24, R24_IP_PRIREF_BUF_SEL);
+
+		ref_lvcmos = ref_diff = false;
+		break;
+	case CDCE6214_CLK_SECREF:
+		if (ref_xtal + ref_lvcmos + ref_diff != 1) {
+			dev_err(priv->dev, "Multiple or no input modes in %pOF\n", np);
+			return -EINVAL;
+		}
+
+		if (ref_xtal)
+			mode = R24_IP_SECREF_BUF_SEL_XTAL;
+		else if (ref_lvcmos)
+			mode = R24_IP_SECREF_BUF_SEL_LVCMOS;
+		else
+			mode = R24_IP_SECREF_BUF_SEL_DIFF;
+
+		regmap_update_bits(priv->regmap, 24, R24_IP_SECREF_BUF_SEL, mode);
+		ref_xtal = ref_lvcmos = ref_diff = false;
+		break;
+	}
+
+	if (lphcsl || lvds || cmosp || cmosn || ref_xtal || ref_lvcmos || ref_diff)
+		dev_warn(priv->dev, "%pOF contains unhandled properties\n", np);
+
+	return 0;
+}
+
+static int cdce6214_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct device_node *child;
+	struct cdce6214 *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->config = device_get_match_data(dev);
+	priv->client = client;
+	priv->dev = dev;
+	i2c_set_clientdata(client, priv);
+	dev_set_drvdata(dev, priv);
+
+	priv->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->reset_gpio)) {
+		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
+				     "failed to get reset gpio\n");
+	}
+
+	priv->regmap = devm_regmap_init_i2c(client, &cdce6214_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	ret = cdce6214_configure(priv);
+	if (ret)
+		return ret;
+
+	for_each_child_of_node(dev->of_node, child) {
+		ret = cdce6214_parse_subnode(priv, child);
+		if (ret)
+			return ret;
+	}
+
+	ret = cdce6214_clk_register(priv);
+	if (ret)
+		return ret;
+
+	ret = devm_of_clk_add_hw_provider(dev, cdce6214_of_clk_get, priv);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id cdce6214_ids[] = {
+	{
+		.compatible = "ti,cdce6214-24mhz",
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, cdce6214_ids);
+
+static struct i2c_driver cdce6214_driver = {
+	.driver = {
+		.name = "cdce6214",
+		.of_match_table = cdce6214_ids,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe = cdce6214_probe,
+};
+module_i2c_driver(cdce6214_driver);
+
+MODULE_AUTHOR("Alvin Šipraga <alsi@bang-olufsen.dk>");
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_DESCRIPTION("TI CDCE6214 driver");
+MODULE_LICENSE("GPL");
diff --git a/include/dt-bindings/clock/ti,cdce6214.h b/include/dt-bindings/clock/ti,cdce6214.h
new file mode 100644
index 0000000000000..1b41060896cc3
--- /dev/null
+++ b/include/dt-bindings/clock/ti,cdce6214.h
@@ -0,0 +1,24 @@
+#ifndef _DT_BINDINGS_CLK_TI_CDCE6214_H
+#define _DT_BINDINGS_CLK_TI_CDCE6214_H
+
+/*
+ * primary/secondary inputs. Not registered as clocks, but used
+ * as reg properties for the subnodes specifying the input properties
+ */
+#define CDCE6214_CLK_PRIREF	0
+#define CDCE6214_CLK_SECREF	1
+
+/*
+ * Clock indices for the clocks provided by the CDCE6214. Also used
+ * as reg properties for the subnodes specifying the output properties
+ */
+#define CDCE6214_CLK_OUT0	2
+#define CDCE6214_CLK_OUT1	3
+#define CDCE6214_CLK_OUT2	4
+#define CDCE6214_CLK_OUT3	5
+#define CDCE6214_CLK_OUT4	6
+#define CDCE6214_CLK_PLL	7
+#define CDCE6214_CLK_PSA	8
+#define CDCE6214_CLK_PSB	9
+
+#endif /* _DT_BINDINGS_CLK_TI_CDCE6214_H */

-- 
2.39.5


