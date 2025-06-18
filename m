Return-Path: <linux-kernel+bounces-691608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 172E4ADE6A2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 11:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD341898CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 09:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B032836A0;
	Wed, 18 Jun 2025 09:21:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B17283153
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238487; cv=none; b=CRvLdT7c7msk2QllWEnjV6BbE6rt3NMWkG3MzpayWQkaSzElk3PFHK/gbDdq0DH0EtsSaAuSHonRMcKomN00qewhJjefvHF5rnH2Rt7Qk7h60QM6dbzvSHOT64guU4seM0RvlFS44/czPutzayivVNXgKBVosbmkBgD4L8Mhnig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238487; c=relaxed/simple;
	bh=n4He+9lCGyr05E4vnM/4zXZPkv6B3E6WSDM1zgIo1EQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9F8hKlCaOriyWlnBPR8AS939poUyZvRgZiGZa22g9kb7Z1Mk7yL84n3dExPLZna5PQ0idqKXRXlltrm2Ct8TtZF24jlOKV4ygDzlvk3rOAZydS4u3yLqOUVAGOrY85MDuBPw6bsU1MVffSPfe7MjyKiIqWuIMC3e6A+sO2VTCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1uRoyr-0003B8-6p; Wed, 18 Jun 2025 11:21:17 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1uRoyq-004755-2O;
	Wed, 18 Jun 2025 11:21:16 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1uRoyq-005QWt-27;
	Wed, 18 Jun 2025 11:21:16 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 18 Jun 2025 11:21:13 +0200
Subject: [PATCH v5 2/4] clk: add TI CDCE6214 clock driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250618-clk-cdce6214-v5-2-9938b8ed0b94@pengutronix.de>
References: <20250618-clk-cdce6214-v5-0-9938b8ed0b94@pengutronix.de>
In-Reply-To: <20250618-clk-cdce6214-v5-0-9938b8ed0b94@pengutronix.de>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@pengutronix.de, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750238476; l=32395;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=n4He+9lCGyr05E4vnM/4zXZPkv6B3E6WSDM1zgIo1EQ=;
 b=X2BBLgxkAjLwnfdlSCn5BG7PSVSDva9QcngWj12RjndSDwbFoz0Q50xEH1wD0R66ZOD2c61XC
 wKbhhJ9VBn4C7luXmlR+NyLOg+h5CPqxFw2VHKmJU82KhhGave2Eplg
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
 drivers/clk/Kconfig        |    7 +
 drivers/clk/Makefile       |    1 +
 drivers/clk/clk-cdce6214.c | 1077 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1085 insertions(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 19c1ed280fd7f6958a4144975337abe1728e1e85..beff3161f5dcf0e907c072ffaf568e6dd6790010 100644
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
index 42867cd37c33d2ca000b58375874c3e20ef479d4..94588c4fb8a8797ad0a122e5dd42d6eba2f9d03a 100644
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
index 0000000000000000000000000000000000000000..41d18597fbbba638b56e6e94141ee0261d355cde
--- /dev/null
+++ b/drivers/clk/clk-cdce6214.c
@@ -0,0 +1,1077 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the TI CDCE6214 clock generator
+ *
+ * datasheet available at https://www.ti.com/lit/gpn/cdce6214
+ *
+ * Copyright (c) 2023 Alvin Šipraga <alsi@bang-olufsen.dk>
+ * Copyright (c) 2025 Sascha Hauer <s.hauer@pengutronix.de>
+ */
+
+#include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/clk-provider.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
+#include <dt-bindings/clock/ti,cdce6214.h>
+
+#define R0	0
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
+#define R1	1
+#define R1_GPIO4_INPUT_SEL		GENMASK(15, 12)
+#define R1_GPIO3_INPUT_SEL		GENMASK(11, 8)
+#define R1_GPIO2_INPUT_SEL		GENMASK(7, 4)
+#define R1_GPIO1_INPUT_SEL		GENMASK(3, 0)
+
+#define R2	2
+#define R2_GPIO4_OUTPUT_SEL		GENMASK(9, 6)
+#define R2_GPIO1_OUTPUT_SEL		GENMASK(5, 2)
+#define R2_REFSEL_SW			GENMASK(1, 0)
+
+#define R3	3
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
+#define R4	4
+#define R4_CH4_PD			BIT(7)
+#define R4_CH3_PD			BIT(6)
+#define R4_CH2_PD			BIT(5)
+#define R4_CH1_PD			BIT(4)
+#define R4_POST_EE_DLY			GENMASK(3, 0)
+
+#define R5	5
+#define R5_PLL_VCOBUFF_LDO_PD		BIT(8)
+#define R5_PLL_VCO_LDO_PD		BIT(7)
+#define R5_PLL_VCO_BUFF_PD		BIT(6)
+#define R5_PLL_CP_LDO_PD		BIT(5)
+#define R5_PLL_LOCKDET_PD		BIT(4)
+#define R5_PLL_PSB_PD			BIT(3)
+#define R5_PLL_PSA_PD			BIT(2)
+#define R5_PLL_PFD_PD			BIT(1)
+
+#define R7	7
+#define R7_NVMCRCERR			BIT(5)
+#define R7_LOCK_DET_S			BIT(1)
+#define R7_LOCK_DET			BIT(0)
+
+#define R9	9
+#define R9_NVMLCRC			GENMASK(15, 0)
+
+#define R10	10
+#define R10_NVMSCRC			GENMASK(15, 0)
+
+#define R11	11
+#define R11_NVM_RD_ADDR			GENMASK(5, 0)
+
+#define R12	12
+#define R12_NVM_RD_DATA			GENMASK(15, 0)
+
+#define R13	13
+#define R13_NVM_WR_ADDR			GENMASK(5, 0)
+
+#define R14	14
+#define R14_NVM_WR_DATA			GENMASK(15, 0)
+
+#define R15	15
+#define R15_EE_LOCK			GENMASK(15, 12)
+#define R15_CAL_MUTE			BIT(5)
+
+#define R24	24
+#define R24_IP_PRIREF_BUF_SEL		BIT(15)
+#define R24_IP_XO_CLOAD			GENMASK(12, 8)
+#define R24_IP_BIAS_SEL_XO		GENMASK(5, 2)
+#define R24_IP_SECREF_BUF_SEL		GENMASK(1, 0)
+#define R24_IP_SECREF_BUF_SEL_XTAL	0
+#define R24_IP_SECREF_BUF_SEL_LVCMOS	1
+#define R24_IP_SECREF_BUF_SEL_DIFF	2
+
+#define R25	25
+#define R25_IP_REF_TO_OUT4_EN		BIT(14)
+#define R25_IP_REF_TO_OUT3_EN		BIT(13)
+#define R25_IP_REF_TO_OUT2_EN		BIT(12)
+#define R25_IP_REF_TO_OUT1_EN		BIT(11)
+#define R25_IP_BYP_OUT0_EN		BIT(10)
+#define R25_REF_CH_MUX			BIT(9)
+#define R25_IP_RDIV			GENMASK(7, 0)
+
+#define R27	27
+#define R27_MASH_ORDER			GENMASK(1, 0)
+
+#define R30	30
+#define R30_PLL_NDIV			GENMASK(14, 0)
+
+#define R31	31
+#define R31_PLL_NUM_15_0		GENMASK(15, 0)
+
+#define R32	32
+#define R32_PLL_NUM_23_16		GENMASK(7, 0)
+
+#define R33	33
+#define R33_PLL_DEN_15_0		GENMASK(15, 0)
+
+#define R34	34
+#define R34_PLL_DEN_23_16		GENMASK(7, 0)
+
+#define R41	41
+#define R41_SSC_EN			BIT(15)
+
+#define R42	42
+#define R42_SSC_TYPE			BIT(5)
+#define R42_SSC_SEL			GENMASK(3, 1)
+
+#define R43	43
+#define R43_FREQ_INC_DEC_DELTA		GENMASK(15, 0)
+
+#define R47	47
+#define R47_PLL_CP_DN			GENMASK(12, 7)
+#define R47_PLL_PSB			GENMASK(6, 5)
+#define R47_PLL_PSA			GENMASK(4, 3)
+
+#define R48	48
+#define R48_PLL_LF_RES			GENMASK(14, 11)
+#define R48_PLL_CP_UP			GENMASK(5, 0)
+
+#define R49	49
+#define R49_PLL_LF_ZCAP			GENMASK(4, 0)
+
+#define R50	50
+#define R50_PLL_LOCKDET_WINDOW		GENMASK(10, 8)
+
+#define R51	51
+#define R51_PLL_PFD_DLY_EN		BIT(10)
+#define R51_PLL_PFD_CTRL		BIT(6)
+
+#define R52	52
+#define R52_PLL_NCTRL_EN		BIT(6)
+#define R52_PLL_CP_EN			BIT(3)
+
+#define R55	55
+#define R55_PLL_LF_3_PCTRIM		GENMASK(9, 8)
+#define R55_PLL_LF_3_PRTRIM		GENMASK(7, 6)
+
+#define R56	56
+#define R56_CH1_MUX			GENMASK(15, 14)
+#define R56_CH1_DIV			GENMASK(13, 0)
+
+#define R57	57
+#define R57_CH1_LPHCSL_EN		BIT(14)
+#define R57_CH1_1P8VDET			BIT(12)
+#define R57_CH1_GLITCHLESS_EN		BIT(9)
+#define R57_CH1_SYNC_DELAY		GENMASK(8, 4)
+#define R57_CH1_SYNC_EN			BIT(3)
+#define R57_CH1_MUTE_SEL		BIT(1)
+#define R57_CH1_MUTE			BIT(0)
+
+#define R59	59
+#define R59_CH1_LVDS_EN			BIT(15)
+#define R59_CH1_CMOSN_EN		BIT(14)
+#define R59_CH1_CMOSP_EN		BIT(13)
+#define R59_CH1_CMOSN_POL		BIT(12)
+#define R59_CH1_CMOSP_POL		BIT(11)
+
+#define R60	60
+#define R60_CH1_DIFFBUF_IBIAS_TRIM	GENMASK(15, 12)
+#define R60_CH1_LVDS_CMTRIM_INC		GENMASK(11, 10)
+#define R60_CH1_LVDS_CMTRIM_DEC		GENMASK(5, 4)
+#define R60_CH1_CMOS_SLEW_RATE_CTRL	GENMASK(3, 0)
+
+#define R62	62
+#define R62_CH2_MUX			GENMASK(15, 14)
+#define R62_CH2_DIV			GENMASK(13, 0)
+
+#define R63	63
+#define R63_CH2_LPHCSL_EN		BIT(13)
+#define R63_CH2_1P8VDET			BIT(12)
+#define R63_CH2_GLITCHLESS_EN		BIT(9)
+#define R63_CH2_SYNC_DELAY		GENMASK(8, 4)
+#define R63_CH2_SYNC_EN			BIT(3)
+#define R63_CH2_MUTE_SEL		BIT(1)
+#define R63_CH2_MUTE			BIT(0)
+
+#define R65	65
+#define R65_CH2_LVDS_CMTRIM_DEC		GENMASK(14, 13)
+#define R65_CH2_LVDS_EN			BIT(11)
+
+#define R66	66
+#define R66_CH2_LVDS_CMTRIM_IN		GENMASK(5, 4)
+#define R66_CH2_DIFFBUF_IBIAS_TRIM	GENMASK(3, 0)
+
+#define R67	67
+#define R67_CH3_MUX			GENMASK(15, 14)
+#define R67_CH3_DIV			GENMASK(13, 0)
+
+#define R68	68
+#define R68_CH3_LPHCSL_EN		BIT(13)
+#define R68_CH3_1P8VDET			BIT(12)
+#define R68_CH3_GLITCHLESS_EN		BIT(9)
+#define R68_CH3_SYNC_DELAY		GENMASK(8, 4)
+#define R68_CH3_SYNC_EN			BIT(3)
+#define R68_CH3_MUTE_SEL		BIT(1)
+#define R68_CH3_MUTE			BIT(0)
+
+#define R70	70
+#define R70_CH3_LVDS_EN			BIT(11)
+
+#define R71	71
+#define R71_CH3_LVDS_CMTRIM_DEC		GENMASK(10, 9)
+#define R71_CH3_LVDS_CMTRIM_INC		GENMASK(5, 4)
+#define R71_CH3_DIFFBUF_IBIAS_TR	GENMASK(3, 0)
+
+#define R72	72
+#define R72_CH4_MUX			GENMASK(15, 14)
+#define R72_CH4_DIV			GENMASK(13, 0)
+
+#define R73	73
+#define R73_CH4_LPHCSL_EN		BIT(13)
+#define R73_CH4_1P8VDET			BIT(12)
+#define R73_CH4_GLITCHLESS_EN		BIT(9)
+#define R73_CH4_SYNC_DELAY		GENMASK(8, 4)
+#define R73_CH4_SYNC_EN			BIT(3)
+#define R73_CH4_MUTE_SEL		BIT(1)
+#define R73_CH4_MUTE			BIT(0)
+
+#define R75	75
+#define R75_CH4_LVDS_EN			BIT(15)
+#define R75_CH4_CMOSP_EN		BIT(14)
+#define R75_CH4_CMOSN_EN		BIT(13)
+#define R75_CH4_CMOSP_POL		BIT(12)
+#define R75_CH4_CMOSN_POL		BIT(11)
+
+#define R76	76
+#define R76_CH4_DIFFBUF_IBIAS_TRIM	GENMASK(9, 6)
+#define R76_CH4_LVDS_CMTRIM_IN		GENMASK(5, 4)
+#define R76_CH4_CMOS_SLEW_RATE_CTRL	GENMASK(3, 0)
+
+#define R77	77
+#define R77_CH4_LVDS_CMTRIM_DEC		GENMASK(1, 0)
+
+#define R78	78
+#define R78_CH0_EN			BIT(12)
+
+#define R79	79
+#define R79_SAFETY_1P8V_MODE		BIT(9)
+#define R79_CH0_CMOS_SLEW_RATE_CTRL	GENMASK(3, 0)
+
+#define R81	81
+#define R81_PLL_LOCK_MASK		BIT(3)
+
+#define CDCE6214_VCO_MIN 2335000000
+#define CDCE6214_VCO_MAX 2625000000
+#define CDCE6214_PLL_NDIV_MIN 24
+#define CDCE6214_DENOM_DEFAULT 0x1000000
+
+#define CDCE6214_CLKIN_FMT_CMOS		0
+#define CDCE6214_CLKIN_FMT_XTAL		1
+#define CDCE6214_CLKIN_FMT_DIFF		2
+#define CDCE6214_CLKIN_FMT_KEEP		3
+
+#define CDCE6214_CLKOUT_FMT_CMOS	0
+#define CDCE6214_CLKOUT_FMT_LVDS	1
+#define CDCE6214_CLKOUT_FMT_LPHCSL	2
+#define CDCE6214_CLKOUT_FMT_KEEP	3
+
+#define CDCE6214_CMOS_MODE_DISABLED	0
+#define CDCE6214_CMOS_MODE_HIGH		1
+#define CDCE6214_CMOS_MODE_LOW		2
+#define CDCE6214_CMOS_MODE_KEEP		3
+
+static const char * const clk_names[] = {
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
+static const char * const clkkin_fmt_names[] = {
+	[CDCE6214_CLKIN_FMT_CMOS] = "cmos",
+	[CDCE6214_CLKIN_FMT_XTAL] = "xtal",
+	[CDCE6214_CLKIN_FMT_DIFF] = "differential",
+};
+
+static const char * const clkkout_fmt_names[] = {
+	[CDCE6214_CLKOUT_FMT_CMOS] = "cmos",
+	[CDCE6214_CLKOUT_FMT_LVDS] = "lvds",
+	[CDCE6214_CLKOUT_FMT_LPHCSL] = "lp-hcsl",
+};
+
+static const char * const cmos_mode_names[] = {
+	[CDCE6214_CMOS_MODE_DISABLED] = "disabled",
+	[CDCE6214_CMOS_MODE_HIGH] = "high",
+	[CDCE6214_CMOS_MODE_LOW] = "low",
+};
+
+#define CDCE6214_NUM_CLOCKS	ARRAY_SIZE(clk_names)
+
+struct cdce6214;
+
+struct cdce6214_clock {
+	struct clk_hw hw;
+	struct cdce6214 *priv;
+	unsigned int index;
+};
+
+struct cdce6214 {
+	struct i2c_client *client;
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *reset_gpio;
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
+	regmap_update_bits(priv->regmap, R2, R2_REFSEL_SW,
+			   FIELD_PREP(R2_REFSEL_SW, 2));
+
+	return 0;
+}
+
+static unsigned long cdce6214_clk_out0_recalc_rate(struct clk_hw *hw,
+						   unsigned long parent_rate)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int val, div;
+
+	regmap_read(priv->regmap, R25, &val);
+
+	div = FIELD_GET(R25_IP_RDIV, val);
+
+	if (!div)
+		return parent_rate * 2;
+
+	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
+}
+
+static int cdce6214_clk_out0_determine_rate(struct clk_hw *hw,
+					    struct clk_rate_request *req)
+{
+	unsigned int div;
+
+	if (req->rate >= req->best_parent_rate)
+		req->rate = req->best_parent_rate * 2;
+
+	div = DIV_ROUND_CLOSEST(req->best_parent_rate, req->rate);
+
+	req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
+
+	return 0;
+}
+
+static int cdce6214_clk_out0_set_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long parent_rate)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int div;
+
+	if (rate >= parent_rate) {
+		regmap_update_bits(priv->regmap, R25, R25_IP_RDIV, FIELD_PREP(R25_IP_RDIV, 0));
+		return 0;
+	}
+
+	div = DIV_ROUND_CLOSEST(parent_rate, rate);
+	if (div > R25_IP_RDIV)
+		div = R25_IP_RDIV;
+
+	regmap_update_bits(priv->regmap, R25, R25_IP_RDIV, FIELD_PREP(R25_IP_RDIV, div));
+
+	return 0;
+}
+
+static u8 cdce6214_clk_out0_get_parent(struct clk_hw *hw)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int val;
+
+	regmap_read(priv->regmap, R2, &val);
+
+	if (FIELD_GET(R2_REFSEL_SW, val) == 2)
+		return 1;
+
+	return 0;
+}
+
+static int cdce6214_clk_out0_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+
+	regmap_update_bits(priv->regmap, R25, R25_REF_CH_MUX, FIELD_PREP(R25_REF_CH_MUX, index));
+
+	return 0;
+}
+
+static const struct clk_ops cdce6214_clk_out0_ops = {
+	.recalc_rate = cdce6214_clk_out0_recalc_rate,
+	.determine_rate = cdce6214_clk_out0_determine_rate,
+	.set_rate = cdce6214_clk_out0_set_rate,
+	.get_parent = cdce6214_clk_out0_get_parent,
+	.set_parent = cdce6214_clk_out0_set_parent,
+};
+
+static unsigned int cdce6214_clk_out_mask(unsigned int index)
+{
+	switch (index) {
+	case CDCE6214_CLK_OUT1:
+		return R4_CH1_PD;
+	case CDCE6214_CLK_OUT2:
+		return R4_CH2_PD;
+	case CDCE6214_CLK_OUT3:
+		return R4_CH3_PD;
+	case CDCE6214_CLK_OUT4:
+		return R4_CH4_PD;
+	default:
+		return 0;
+	};
+}
+
+static int cdce6214_clk_out_prepare(struct clk_hw *hw)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int mask = cdce6214_clk_out_mask(clock->index);
+
+	if (!mask)
+		return -EINVAL;
+
+	return regmap_clear_bits(priv->regmap, R4, mask);
+}
+
+static void cdce6214_clk_out_unprepare(struct clk_hw *hw)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int mask = cdce6214_clk_out_mask(clock->index);
+
+	if (!mask)
+		return;
+
+	regmap_set_bits(priv->regmap, R4, mask);
+}
+
+static int cdce6214_clk_out_is_prepared(struct clk_hw *hw)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int mask = cdce6214_clk_out_mask(clock->index);
+	unsigned int val;
+
+	if (!mask)
+		return -EINVAL;
+
+	regmap_read(priv->regmap, R4, &val);
+
+	return !(val & mask);
+}
+
+static unsigned long cdce6214_clk_out_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int val, div;
+	unsigned long r;
+
+	switch (clock->index) {
+	case CDCE6214_CLK_OUT1:
+		regmap_read(priv->regmap, R56, &val);
+		div = FIELD_GET(R56_CH1_DIV, val);
+		break;
+	case CDCE6214_CLK_OUT2:
+		regmap_read(priv->regmap, R62, &val);
+		div = FIELD_GET(R62_CH2_DIV, val);
+		break;
+	case CDCE6214_CLK_OUT3:
+		regmap_read(priv->regmap, R67, &val);
+		div = FIELD_GET(R67_CH3_DIV, val);
+		break;
+	case CDCE6214_CLK_OUT4:
+		regmap_read(priv->regmap, R72, &val);
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
+static unsigned int cdce6214_get_out_div(unsigned long rate, unsigned long parent_rate)
+{
+	unsigned int div;
+
+	div = divider_get_val(rate, parent_rate, NULL, 14, CLK_DIVIDER_ONE_BASED);
+
+	if (div < 1)
+		div = 1;
+
+	return div;
+}
+
+static int cdce6214_clk_out_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
+{
+	unsigned int div = cdce6214_get_out_div(req->rate, req->best_parent_rate);
+
+	req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
+
+	return 0;
+}
+
+static int cdce6214_clk_out_set_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long parent_rate)
+{
+	unsigned int div = cdce6214_get_out_div(rate, parent_rate);
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+
+	switch (clock->index) {
+	case CDCE6214_CLK_OUT1:
+		regmap_update_bits(priv->regmap, R56, R56_CH1_DIV,
+				   FIELD_PREP(R56_CH1_DIV, div));
+		break;
+	case CDCE6214_CLK_OUT2:
+		regmap_update_bits(priv->regmap, R62, R62_CH2_DIV,
+				   FIELD_PREP(R62_CH2_DIV, div));
+		break;
+	case CDCE6214_CLK_OUT3:
+		regmap_update_bits(priv->regmap, R67, R67_CH3_DIV,
+				   FIELD_PREP(R67_CH3_DIV, div));
+		break;
+	case CDCE6214_CLK_OUT4:
+		regmap_update_bits(priv->regmap, R72, R72_CH4_DIV,
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
+		regmap_read(priv->regmap, R56, &val);
+		idx = FIELD_GET(R56_CH1_MUX, val);
+		break;
+	case CDCE6214_CLK_OUT2:
+		regmap_read(priv->regmap, R62, &val);
+		idx = FIELD_GET(R62_CH2_MUX, val);
+		break;
+	case CDCE6214_CLK_OUT3:
+		regmap_read(priv->regmap, R67, &val);
+		idx = FIELD_GET(R67_CH3_MUX, val);
+		break;
+	case CDCE6214_CLK_OUT4:
+		regmap_read(priv->regmap, R72, &val);
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
+		regmap_update_bits(priv->regmap, R56, R56_CH1_MUX, FIELD_PREP(R56_CH1_MUX, index));
+		break;
+	case CDCE6214_CLK_OUT2:
+		regmap_update_bits(priv->regmap, R62, R62_CH2_MUX, FIELD_PREP(R62_CH2_MUX, index));
+		break;
+	case CDCE6214_CLK_OUT3:
+		regmap_update_bits(priv->regmap, R67, R67_CH3_MUX, FIELD_PREP(R67_CH3_MUX, index));
+		break;
+	case CDCE6214_CLK_OUT4:
+		regmap_update_bits(priv->regmap, R72, R72_CH4_MUX, FIELD_PREP(R72_CH4_MUX, index));
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
+	.determine_rate = cdce6214_clk_out_determine_rate,
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
+	a = out % parent_rate;
+	a *= *den;
+	do_div(a, parent_rate);
+	*num = a;
+
+	return 0;
+}
+
+static unsigned long cdce6214_clk_pll_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned long ndiv, num, den;
+	unsigned int val;
+
+	regmap_read(priv->regmap, R30, &val);
+	ndiv = FIELD_GET(R30_PLL_NDIV, val);
+
+	regmap_read(priv->regmap, R31, &val);
+	num = FIELD_GET(R31_PLL_NUM_15_0, val);
+
+	regmap_read(priv->regmap, R32, &val);
+	num |= FIELD_GET(R32_PLL_NUM_23_16, val) << 16;
+
+	regmap_read(priv->regmap, R33, &val);
+	den = FIELD_GET(R33_PLL_DEN_15_0, val);
+
+	regmap_read(priv->regmap, R34, &val);
+	den |= FIELD_GET(R34_PLL_DEN_23_16, val) << 16;
+
+	if (!den)
+		den = CDCE6214_DENOM_DEFAULT;
+
+	return parent_rate * ndiv + DIV_ROUND_CLOSEST(parent_rate * num, den);
+}
+
+static int cdce6214_clk_pll_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
+{
+	req->rate = clamp(req->rate, CDCE6214_VCO_MIN, CDCE6214_VCO_MAX);
+
+	if (req->rate < req->best_parent_rate * CDCE6214_PLL_NDIV_MIN)
+		return -EINVAL;
+
+	req->min_rate = CDCE6214_VCO_MIN;
+	req->max_rate = CDCE6214_VCO_MAX;
+
+	return 0;
+}
+
+static bool cdce6214_pll_locked(struct cdce6214 *priv)
+{
+	unsigned int val;
+
+	regmap_read(priv->regmap, R7, &val);
+
+	return val & R7_LOCK_DET;
+}
+
+static int cdce6214_wait_pll_lock(struct cdce6214 *priv)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read_poll_timeout(priv->regmap, R7, val,
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
+	regmap_clear_bits(priv->regmap, R5, R5_PLL_POWER_BITS);
+
+	regmap_set_bits(priv->regmap, R0, RO_RECAL);
+
+	return cdce6214_wait_pll_lock(priv);
+}
+
+static void cdce6214_clk_pll_unprepare(struct clk_hw *hw)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+
+	regmap_set_bits(priv->regmap, R5, R5_PLL_POWER_BITS);
+}
+
+static bool cdce6214_clk_pll_powered(struct cdce6214 *priv)
+{
+	unsigned int val;
+
+	regmap_read(priv->regmap, R5, &val);
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
+				     unsigned long parent_rate)
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
+	regmap_update_bits(priv->regmap, R34, R34_PLL_DEN_23_16,
+			   FIELD_PREP(R34_PLL_DEN_23_16, den >> 16));
+	regmap_update_bits(priv->regmap, R33, R33_PLL_DEN_15_0,
+			   FIELD_PREP(R33_PLL_DEN_15_0, den & 0xffff));
+	regmap_update_bits(priv->regmap, R32, R32_PLL_NUM_23_16,
+			   FIELD_PREP(R32_PLL_NUM_23_16, num >> 16));
+	regmap_update_bits(priv->regmap, R31, R31_PLL_NUM_15_0,
+			   FIELD_PREP(R31_PLL_NUM_15_0, num & 0xffff));
+	regmap_update_bits(priv->regmap, R30, R30_PLL_NDIV,
+			   FIELD_PREP(R30_PLL_NDIV, ndiv));
+
+	regmap_update_bits(priv->regmap, R3, R3_FREQ_INC_DEC_REG_MODE | R3_FREQ_INC_DEC_EN,
+			   R3_FREQ_INC_DEC_REG_MODE | R3_FREQ_INC_DEC_EN);
+
+	if (cdce6214_clk_pll_powered(priv)) {
+		regmap_set_bits(priv->regmap, R0, RO_RECAL);
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
+	.determine_rate = cdce6214_clk_pll_determine_rate,
+	.set_rate = cdce6214_clk_pll_set_rate,
+};
+
+static unsigned int cdce6214_clk_psx_mask(int index)
+{
+	switch (index) {
+	case CDCE6214_CLK_PSA:
+		return R5_PLL_PSA_PD;
+	case CDCE6214_CLK_PSB:
+		return R5_PLL_PSB_PD;
+	default:
+		return 0;
+	};
+}
+
+static int cdce6214_clk_psx_prepare(struct clk_hw *hw)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int mask = cdce6214_clk_psx_mask(clock->index);
+
+	if (!mask)
+		return -EINVAL;
+
+	return regmap_clear_bits(priv->regmap, R5, mask);
+}
+
+static void cdce6214_clk_psx_unprepare(struct clk_hw *hw)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int mask = cdce6214_clk_psx_mask(clock->index);
+
+	if (!mask)
+		return;
+
+	regmap_set_bits(priv->regmap, R5, mask);
+}
+
+static int cdce6214_clk_psx_is_prepared(struct clk_hw *hw)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	unsigned int mask = cdce6214_clk_psx_mask(clock->index);
+	unsigned int val;
+
+	if (!mask)
+		return -EINVAL;
+
+	regmap_read(priv->regmap, R5, &val);
+
+	return !(val & mask);
+}
+
+static unsigned long cdce6214_clk_psx_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+	const unsigned int psx[] = { 4, 5, 6, 6 };
+	unsigned int val, div;
+
+	regmap_read(priv->regmap, R47, &val);
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
+	return clamp(div, 4, 6);
+}
+
+static int cdce6214_clk_psx_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
+{
+	unsigned int div = cdce6214_get_psx_div(req->rate, req->best_parent_rate);
+
+	req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
+
+	return 0;
+}
+
+static int cdce6214_clk_psx_set_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long parent_rate)
+{
+	unsigned int div = cdce6214_get_psx_div(rate, parent_rate);
+	struct cdce6214_clock *clock = hw_to_cdce6214_clk(hw);
+	struct cdce6214 *priv = clock->priv;
+
+	switch (clock->index) {
+	case CDCE6214_CLK_PSA:
+		regmap_update_bits(priv->regmap, R47, R47_PLL_PSA,
+				   FIELD_PREP(R47_PLL_PSA, div));
+		break;
+	case CDCE6214_CLK_PSB:
+		regmap_update_bits(priv->regmap, R47, R47_PLL_PSB,
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
+	.determine_rate = cdce6214_clk_psx_determine_rate,
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
+	init[CDCE6214_CLK_OUT0].num_parents = ARRAY_SIZE(pdata_out);
+	init[CDCE6214_CLK_OUT0].parent_data = pdata_out0;
+	init[CDCE6214_CLK_OUT0].flags = CLK_SET_RATE_NO_REPARENT;
+
+	pdata_out[0].hw = &priv->clk[CDCE6214_CLK_PSA].hw;
+	pdata_out[1].hw = &priv->clk[CDCE6214_CLK_PSB].hw;
+	pdata_out[3].hw = &priv->clk[CDCE6214_CLK_OUT0].hw;
+
+	for (i = CDCE6214_CLK_OUT1; i <= CDCE6214_CLK_OUT4; i++) {
+		init[i].ops = &cdce6214_clk_out_ops;
+		init[i].num_parents = ARRAY_SIZE(pdata_out);
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
+static int cdce6214_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct cdce6214 *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
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
+		return dev_err_probe(dev, PTR_ERR(priv->regmap),
+				     "failed to init regmap\n");
+
+	ret = cdce6214_configure(priv);
+	if (ret)
+		return ret;
+
+	ret = cdce6214_clk_register(priv);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register clocks\n");
+
+	return devm_of_clk_add_hw_provider(dev, cdce6214_of_clk_get, priv);
+}
+
+static const struct of_device_id cdce6214_ids[] = {
+	{ .compatible = "ti,cdce6214" },
+	{ /* sentinel */ }
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

-- 
2.39.5


