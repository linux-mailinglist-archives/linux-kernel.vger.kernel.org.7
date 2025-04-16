Return-Path: <linux-kernel+bounces-605424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50A3A8A107
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 16:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E40A7A7910
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF5F28E5FC;
	Tue, 15 Apr 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="WOuTZAeZ"
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E7275105;
	Tue, 15 Apr 2025 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727198; cv=pass; b=aNkN70STqn6+xIdk38eTNaEwF/ZIPs/zOxDUfV2SOUFnPNX0Og7HnQFibQa5VNmecaA6d2i8wTdNCVbea4+GEPOGGQYJFf6s2jG3hkdqRlYjhbwyX9kXaa56dDw3ZzPkSeR6HSUyk36cXSvwyMscIb095TVdp0Xf0ThSmax6fHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727198; c=relaxed/simple;
	bh=MBtbNO9Hf+dz7BWlE0u2kU2jdQpQfr485mBAiyn/haM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TAr+glwoCDyUc+1PaMxy3+qzkrtoJr90FAJpnF2ueir8maywv0yxpLRESEX8ThelTpzkaI+0ZhXCHNDhih1JtI3Ayw0WB9p/X9Rv90Dps0gQ4n7mgNusxlkJOZ54Vzof3koO1tWqQXGS5B95neoV5axxvnCafLitu8U9XpGiSLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=WOuTZAeZ; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1744727166; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cAiaHhlKY2DY90ti3JtKrANy0JdifXwxXIxkDDt2mUErOtQEjy2Vxw1pt1RsMxVSvtMcFU2/asXWalNaq+XNiCfdOaDhuNI2lPJJowelvt0d0TalsjUmXd6m6OnysrIwfUYpfyJW5ofHFGXEd4LGwUMMw4/DwcxcWWZcC6tg134=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744727166; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MiKaFyLX75Sm9r6/FKWMvTQ+iD5uvLgM/00SDYJRLmc=; 
	b=WOekWcMrOgatnkRYCViQSVVl+wwWo/KddlLwnRjY8sbQj4TBER+KQBIrgKP9IPVfquz6jx/wmtenea1AWt+W6gbRJLAMsoA/fKWOvBoMWaqv15gdOjL6thjz4Xu/iFOao92UFRXnBpIsDPlpPOBRNr3rj+h+hyOE+Z18SwShFM4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744727166;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=MiKaFyLX75Sm9r6/FKWMvTQ+iD5uvLgM/00SDYJRLmc=;
	b=WOuTZAeZKwMrm32mymHcFbzuIKd0tlMTMt/jplcJ5NY/dYRHTQvu8U4q4xetfAlY
	J29yi7MhtnU+qb8qPSDqUFv3lnOAhZ2O7Lc79DdmhDP3MxcfU6VY/CfCTtLWUGcg9+p
	hAWu3WPCcIIq5oVOFGd/GFiFhBUdNIOU2B6F1DU8=
Received: by mx.zohomail.com with SMTPS id 17447271627234.166329974105679;
	Tue, 15 Apr 2025 07:26:02 -0700 (PDT)
From: Xukai Wang <kingxukai@zohomail.com>
Date: Tue, 15 Apr 2025 22:25:12 +0800
Subject: [PATCH v6 2/3] clk: canaan: Add clock driver for Canaan K230
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-k230-clk-v6-2-7fd89f427250@zohomail.com>
References: <20250415-b4-k230-clk-v6-0-7fd89f427250@zohomail.com>
In-Reply-To: <20250415-b4-k230-clk-v6-0-7fd89f427250@zohomail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xukai Wang <kingxukai@zohomail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Troy Mitchell <TroyMitchell988@gmail.com>
X-Mailer: b4 0.14.2
Feedback-ID: rr080112271f81cff2612fbe5c89eb63b60000ca51b57bd58931e0524cf6c9ff9b55e4b2c83d9330dd1ad0c5:zu08011227e948a5eda6c2d61a2f49e15c000093186450c453c0613bc0459152e0d4b2a486cfcf7dda20abc9:rf0801122c3d564f7bdb8ed9fe27a7c8e000003b1fd56250917c440c54ae7a73b12e96e2cfdccf1ca0f3b1b8b6c541118f:ZohoMail
X-ZohoMailClient: External

This patch provides basic support for the K230 clock, which does not
cover all clocks.

The clock tree of the K230 SoC consists of OSC24M, PLLs and sysclk.

Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
---
 drivers/clk/Kconfig    |    6 +
 drivers/clk/Makefile   |    1 +
 drivers/clk/clk-k230.c | 1710 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1717 insertions(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 299bc678ed1b9fcd9110bb8c5937a1bd1ea60e23..1817b8883af9a3d00ac7af2cb88496274b591001 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -464,6 +464,12 @@ config COMMON_CLK_K210
 	help
 	  Support for the Canaan Kendryte K210 RISC-V SoC clocks.
 
+config COMMON_CLK_K230
+	bool "Clock driver for the Canaan Kendryte K230 SoC"
+	depends on ARCH_CANAAN || COMPILE_TEST
+        help
+          Support for the Canaan Kendryte K230 RISC-V SoC clocks.
+
 config COMMON_CLK_SP7021
 	tristate "Clock driver for Sunplus SP7021 SoC"
 	depends on SOC_SP7021 || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index fb8878a5d7d93da6bec487460cdf63f1f764a431..5df50b1e14c701ed38397bfb257db26e8dd278b8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_MACH_ASPEED_G6)		+= clk-ast2600.o
 obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
 obj-$(CONFIG_CLK_HSDK)			+= clk-hsdk-pll.o
 obj-$(CONFIG_COMMON_CLK_K210)		+= clk-k210.o
+obj-$(CONFIG_COMMON_CLK_K230)		+= clk-k230.o
 obj-$(CONFIG_LMK04832)			+= clk-lmk04832.o
 obj-$(CONFIG_COMMON_CLK_LAN966X)	+= clk-lan966x.o
 obj-$(CONFIG_COMMON_CLK_LOCHNAGAR)	+= clk-lochnagar.o
diff --git a/drivers/clk/clk-k230.c b/drivers/clk/clk-k230.c
new file mode 100644
index 0000000000000000000000000000000000000000..84a4a2a293e5f278d21510d73888aee4ff9351df
--- /dev/null
+++ b/drivers/clk/clk-k230.c
@@ -0,0 +1,1710 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Kendryte Canaan K230 Clock Drivers
+ *
+ * Author: Xukai Wang <kingxukai@zohomail.com>
+ * Author: Troy Mitchell <troymitchell988@gmail.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <dt-bindings/clock/canaan,k230-clk.h>
+
+/* PLL control register bits. */
+#define K230_PLL_BYPASS_ENABLE				BIT(19)
+#define K230_PLL_GATE_ENABLE				BIT(2)
+#define K230_PLL_GATE_WRITE_ENABLE			BIT(18)
+#define K230_PLL_OD_SHIFT				24
+#define K230_PLL_OD_MASK				0xF
+#define K230_PLL_R_SHIFT				16
+#define K230_PLL_R_MASK					0x3F
+#define K230_PLL_F_SHIFT				0
+#define K230_PLL_F_MASK					0x1FFFF
+#define K230_PLL0_OFFSET_BASE				0x00
+#define K230_PLL1_OFFSET_BASE				0x10
+#define K230_PLL2_OFFSET_BASE				0x20
+#define K230_PLL3_OFFSET_BASE				0x30
+#define K230_PLL_DIV_REG_OFFSET				0x00
+#define K230_PLL_BYPASS_REG_OFFSET			0x04
+#define K230_PLL_GATE_REG_OFFSET			0x08
+#define K230_PLL_LOCK_REG_OFFSET			0x0C
+
+/* PLL lock register bits.  */
+#define K230_PLL_STATUS_MASK				BIT(0)
+
+/* K230 CLK registers offset */
+#define K230_CLK_AUDIO_CLKDIV_OFFSET			0x34
+#define K230_CLK_PDM_CLKDIV_OFFSET			0x40
+#define K230_CLK_CODEC_ADC_MCLKDIV_OFFSET		0x38
+#define K230_CLK_CODEC_DAC_MCLKDIV_OFFSET		0x3c
+
+/* K230 CLK OPS. */
+#define K230_CLK_OPS_GATE				\
+	.enable		= k230_clk_enable,		\
+	.disable	= k230_clk_disable,		\
+	.is_enabled	= k230_clk_is_enabled
+
+#define K230_CLK_OPS_RATE				\
+	.set_rate	= k230_clk_set_rate,		\
+	.round_rate	= k230_clk_round_rate,		\
+	.recalc_rate	= k230_clk_get_rate
+
+#define K230_CLK_OPS_MUX				\
+	.set_parent	= k230_clk_set_parent,		\
+	.get_parent	= k230_clk_get_parent,		\
+	.determine_rate	= clk_hw_determine_rate_no_reparent
+
+#define K230_CLK_OPS_ID_NONE				0
+#define K230_CLK_OPS_ID_GATE_ONLY			1
+#define K230_CLK_OPS_ID_RATE_ONLY			2
+#define K230_CLK_OPS_ID_RATE_GATE			3
+#define K230_CLK_OPS_ID_MUX_ONLY			4
+#define K230_CLK_OPS_ID_MUX_GATE			5
+#define K230_CLK_OPS_ID_MUX_RATE			6
+#define K230_CLK_OPS_ID_ALL				7
+#define K230_CLK_OPS_ID_NUM				8
+
+/* K230 CLK MACROS */
+#define K230_CLK_MAX_PARENT_NUM				6
+
+#define K230_GATE_FORMAT(_reg, _bit, _reverse)					\
+	.gate_reg_off = (_reg),							\
+	.gate_bit_enable = (_bit),						\
+	.gate_bit_reverse = (_reverse)
+
+#define K230_RATE_FORMAT(_mul_min, _mul_max, _mul_shift, _mul_mask,		\
+			_div_min, _div_max, _div_shift, _div_mask,		\
+			_reg, _bit, _method)					\
+	.rate_mul_min = (_mul_min),						\
+	.rate_mul_max = (_mul_max),						\
+	.rate_mul_shift = (_mul_shift),						\
+	.rate_mul_mask = (_mul_mask),						\
+	.rate_div_min = (_div_min),						\
+	.rate_div_max = (_div_max),						\
+	.rate_div_shift = (_div_shift),						\
+	.rate_div_mask = (_div_mask),						\
+	.rate_reg_off = (_reg),							\
+	.rate_write_enable_bit = (_bit),					\
+	.method = (_method)
+
+#define K230_RATE_C_FORMAT(_mul_min, _mul_max, _mul_shift, _mul_mask,		\
+			   _reg, _bit)						\
+	.rate_mul_min_c = (_mul_min),						\
+	.rate_mul_max_c = (_mul_max),						\
+	.rate_mul_shift_c = (_mul_shift),					\
+	.rate_mul_mask_c = (_mul_mask),						\
+	.rate_reg_off_c = (_reg),						\
+	.rate_write_enable_bit_c = (_bit)
+
+#define K230_MUX_FORMAT(_reg, _shift, _mask)					\
+	.mux_reg_off = (_reg),							\
+	.mux_reg_shift = (_shift),						\
+	.mux_reg_mask = (_mask)
+
+struct k230_sysclk;
+
+enum k230_pll_id {
+	K230_PLL0,
+	K230_PLL1,
+	K230_PLL2,
+	K230_PLL3,
+	K230_PLL_NUM
+};
+
+struct k230_pll {
+	enum k230_pll_id id;
+	struct k230_sysclk *ksc;
+	void __iomem *div, *bypass, *gate, *lock;
+	struct clk_hw hw;
+};
+
+#define to_k230_pll(_hw)	container_of(_hw, struct k230_pll, hw)
+
+struct k230_pll_cfg {
+	u32 reg;
+	const char *name;
+	struct k230_pll *pll;
+};
+
+struct k230_pll_div {
+	struct k230_sysclk *ksc;
+	struct clk_hw *hw;
+};
+
+struct k230_pll_div_cfg {
+	const char *parent_name, *name;
+	int div;
+	struct k230_pll_div *pll_div;
+};
+
+enum k230_pll_div_id {
+	K230_PLL0_DIV2,
+	K230_PLL0_DIV3,
+	K230_PLL0_DIV4,
+	K230_PLL0_DIV16,
+	K230_PLL1_DIV2,
+	K230_PLL1_DIV3,
+	K230_PLL1_DIV4,
+	K230_PLL2_DIV2,
+	K230_PLL2_DIV3,
+	K230_PLL2_DIV4,
+	K230_PLL3_DIV2,
+	K230_PLL3_DIV3,
+	K230_PLL3_DIV4,
+	K230_PLL_DIV_NUM
+};
+
+enum k230_clk_div_type {
+	K230_MUL,
+	K230_DIV,
+	K230_MUL_DIV,
+};
+
+struct k230_clk {
+	int id;
+	struct k230_sysclk *ksc;
+	struct clk_hw hw;
+};
+
+#define to_k230_clk(_hw)	container_of(_hw, struct k230_clk, hw)
+
+struct k230_sysclk {
+	struct platform_device *pdev;
+	void __iomem	       *pll_regs, *regs;
+	spinlock_t	       pll_lock, clk_lock;
+	struct k230_pll	       *plls;
+	struct k230_clk	       *clks;
+	struct k230_pll_div    *dclks;
+};
+
+struct k230_clk_rate_cfg {
+	/* rate reg */
+	u32 rate_reg_off;
+	void __iomem *rate_reg;
+	/* rate info*/
+	u32 rate_write_enable_bit;
+	enum k230_clk_div_type method;
+	/* rate mul */
+	u32 rate_mul_min;
+	u32 rate_mul_max;
+	u32 rate_mul_shift;
+	u32 rate_mul_mask;
+	/* rate div */
+	u32 rate_div_min;
+	u32 rate_div_max;
+	u32 rate_div_shift;
+	u32 rate_div_mask;
+};
+
+struct k230_clk_rate_cfg_c {
+	/* rate_c reg */
+	u32 rate_reg_off_c;
+	void __iomem *rate_reg_c;
+
+	/* rate_c info */
+	u32 rate_write_enable_bit_c;
+
+	/* rate mul-changable */
+	u32 rate_mul_min_c;
+	u32 rate_mul_max_c;
+	u32 rate_mul_shift_c;
+	u32 rate_mul_mask_c;
+};
+
+struct k230_clk_gate_cfg {
+	/* gate reg */
+	u32 gate_reg_off;
+	void __iomem *gate_reg;
+
+	/* gate info*/
+	u32 gate_bit_enable;
+	bool gate_bit_reverse;
+};
+
+struct k230_clk_mux_cfg {
+	/* mux reg */
+	u32 mux_reg_off;
+	void __iomem *mux_reg;
+
+	/* mux info */
+	u32 mux_reg_shift;
+	u32 mux_reg_mask;
+};
+
+enum k230_clk_parent_type {
+	K230_OSC24M,
+	K230_PLL,
+	K230_PLL_DIV,
+	K230_CLK_COMPOSITE,
+};
+
+struct k230_clk_cfg;
+
+struct k230_clk_parent {
+	enum k230_clk_parent_type type;
+	union {
+		struct k230_pll_cfg	*pll_cfg;
+		struct k230_pll_div_cfg	*pll_div_cfg;
+		struct k230_clk_cfg	*clk_cfg;
+	};
+};
+
+struct k230_clk_cfg {
+	/* attr */
+	const char *name;
+
+	/* 0-read & write; 1-read only */
+	bool read_only;
+	int num_parent;
+	struct k230_clk_parent parent[K230_CLK_MAX_PARENT_NUM];
+	struct k230_clk *clk;
+	int flags;
+
+	/* cfgs */
+	struct k230_clk_rate_cfg	*rate_cfg;
+	struct k230_clk_rate_cfg_c	*rate_cfg_c;
+	struct k230_clk_gate_cfg	*gate_cfg;
+	struct k230_clk_mux_cfg		*mux_cfg;
+};
+
+static struct k230_pll_cfg k230_pll_cfgs[] = {
+	[K230_PLL0] = {
+		.reg = K230_PLL0_OFFSET_BASE,
+		.name = "pll0",
+		.pll = NULL,
+	},
+	[K230_PLL1] = {
+		.reg = K230_PLL1_OFFSET_BASE,
+		.name = "pll1",
+		.pll = NULL,
+	},
+	[K230_PLL2] = {
+		.reg = K230_PLL2_OFFSET_BASE,
+		.name = "pll2",
+		.pll = NULL,
+	},
+	[K230_PLL3] = {
+		.reg = K230_PLL3_OFFSET_BASE,
+		.name = "pll3",
+		.pll = NULL,
+	},
+};
+
+static struct k230_pll_div_cfg k230_pll_div_cfgs[] = {
+	[K230_PLL0_DIV2]	= { "pll0", "pll0_div2", 2, NULL},
+	[K230_PLL0_DIV3]	= { "pll0", "pll0_div3", 3, NULL},
+	[K230_PLL0_DIV4]	= { "pll0", "pll0_div4", 4, NULL},
+	[K230_PLL0_DIV16]	= { "pll0", "pll0_div16", 16, NULL},
+	[K230_PLL1_DIV2]	= { "pll1", "pll1_div2", 2, NULL},
+	[K230_PLL1_DIV3]	= { "pll1", "pll1_div3", 3, NULL},
+	[K230_PLL1_DIV4]	= { "pll1", "pll1_div4", 4, NULL},
+	[K230_PLL2_DIV2]	= { "pll2", "pll2_div2", 2, NULL},
+	[K230_PLL2_DIV3]	= { "pll2", "pll2_div3", 3, NULL},
+	[K230_PLL2_DIV4]	= { "pll2", "pll2_div4", 4, NULL},
+	[K230_PLL3_DIV2]	= { "pll3", "pll3_div2", 2, NULL},
+	[K230_PLL3_DIV3]	= { "pll3", "pll3_div3", 3, NULL},
+	[K230_PLL3_DIV4]	= { "pll3", "pll3_div4", 4, NULL},
+};
+
+static struct k230_clk_rate_cfg k230_cpu0_src_rate = {
+	K230_RATE_FORMAT(1, 16, 0, 0,
+			 16, 16, 1, 0xf,
+			 0x0, 31, K230_MUL)
+};
+
+static struct k230_clk_gate_cfg k230_cpu0_src_gate = {
+	K230_GATE_FORMAT(0, 0, false)
+};
+
+static struct k230_clk_rate_cfg k230_cpu0_aclk_rate = {
+	K230_RATE_FORMAT(1, 1, 0, 0,
+			 1, 8, 6, 0x7,
+			 0x0, 31, K230_DIV)
+};
+
+static struct k230_clk_rate_cfg k230_cpu0_plic_rate = {
+	K230_RATE_FORMAT(1, 1, 0, 0,
+			 1, 8, 10, 0x7,
+			 0x0, 31, K230_DIV)
+};
+
+static struct k230_clk_gate_cfg k230_cpu0_plic_gate = {
+	K230_GATE_FORMAT(0x0, 9, false)
+};
+
+static struct k230_clk_gate_cfg k230_cpu0_noc_ddrcp4_gate = {
+	K230_GATE_FORMAT(0x60, 7, false)
+};
+
+static struct k230_clk_rate_cfg k230_cpu0_pclk_rate = {
+	K230_RATE_FORMAT(1, 1, 0, 0,
+			 1, 8, 15, 0x7,
+			 0x0, 31, K230_DIV)
+};
+
+static struct k230_clk_gate_cfg k230_cpu0_pclk_gate = {
+	K230_GATE_FORMAT(0x0, 13, false)
+};
+
+static struct k230_clk_gate_cfg k230_pmu_pclk_gate = {
+	K230_GATE_FORMAT(0x10, 0, false)
+};
+
+static struct k230_clk_gate_cfg k230_hs_ospi_src_gate = {
+	K230_GATE_FORMAT(0x18, 24, false)
+};
+
+static struct k230_clk_mux_cfg k230_hs_ospi_src_mux = {
+	K230_MUX_FORMAT(0x20, 18, 0x1)
+};
+
+static struct k230_clk_rate_cfg k230_ls_apb_src_rate = {
+	K230_RATE_FORMAT(1, 1, 0, 0,
+			 1, 8, 0, 0x7,
+			 0x30, 31, K230_DIV)
+};
+
+static struct k230_clk_gate_cfg k230_ls_apb_src_gate = {
+	K230_GATE_FORMAT(0x24, 0, false)
+};
+
+static struct k230_clk_gate_cfg k230_ls_uart0_apb_gate = {
+	K230_GATE_FORMAT(0x24, 1, false)
+};
+
+static struct k230_clk_gate_cfg k230_ls_uart1_apb_gate = {
+	K230_GATE_FORMAT(0x24, 2, false)
+};
+
+static struct k230_clk_gate_cfg k230_ls_uart2_apb_gate = {
+	K230_GATE_FORMAT(0x24, 3, false)
+};
+
+static struct k230_clk_gate_cfg k230_ls_uart3_apb_gate = {
+	K230_GATE_FORMAT(0x24, 4, false)
+};
+
+static struct k230_clk_gate_cfg k230_ls_uart4_apb_gate = {
+	K230_GATE_FORMAT(0x24, 5, false)
+};
+
+static struct k230_clk_rate_cfg k230_ls_uart0_rate = {
+	K230_RATE_FORMAT(1, 1, 0, 0,
+			 1, 8, 0, 0x7,
+			 0x2C, 31, K230_DIV)
+};
+
+static struct k230_clk_gate_cfg k230_ls_uart0_gate = {
+	K230_GATE_FORMAT(0x24, 16, false)
+};
+
+static struct k230_clk_rate_cfg k230_ls_uart1_rate = {
+	K230_RATE_FORMAT(1, 1, 0, 0,
+			 1, 8, 3, 0x7,
+			 0x2C, 31, K230_DIV)
+};
+
+static struct k230_clk_gate_cfg k230_ls_uart1_gate = {
+	K230_GATE_FORMAT(0x24, 17, false)
+};
+
+static struct k230_clk_rate_cfg k230_ls_uart2_rate = {
+	K230_RATE_FORMAT(1, 1, 0, 0,
+			 1, 8, 6, 0x7,
+			 0x2C, 31, K230_DIV)
+};
+
+static struct k230_clk_gate_cfg k230_ls_uart2_gate = {
+	K230_GATE_FORMAT(0x24, 18, false)
+};
+
+static struct k230_clk_rate_cfg k230_ls_uart3_rate = {
+	K230_RATE_FORMAT(1, 1, 0, 0,
+			 1, 8, 9, 0x7,
+			 0x2C, 31, K230_DIV)
+};
+
+static struct k230_clk_gate_cfg k230_ls_uart3_gate = {
+	K230_GATE_FORMAT(0x24, 19, false)
+};
+
+static struct k230_clk_rate_cfg k230_ls_uart4_rate = {
+	K230_RATE_FORMAT(1, 1, 0, 0,
+			 1, 8, 12, 0x7,
+			 0x2C, 31, K230_DIV)
+};
+
+static struct k230_clk_gate_cfg k230_ls_uart4_gate = {
+	K230_GATE_FORMAT(0x24, 20, false)
+};
+
+static struct k230_clk_gate_cfg k230_shrm_axi_src_gate = {
+	K230_GATE_FORMAT(0x5C, 12, false)
+};
+
+static struct k230_clk_gate_cfg k230_shrm_sdma_axi_gate = {
+	K230_GATE_FORMAT(0x5C, 5, false)
+};
+
+static struct k230_clk_gate_cfg k230_shrm_pdma_axi_gate = {
+	K230_GATE_FORMAT(0x5C, 3, false)
+};
+
+static struct k230_clk_cfg k230_cpu0_src = {
+	.name = "cpu0_src",
+	.read_only = false,
+	.flags = 0,
+	.num_parent = 1,
+	.parent[0] = {
+		.type = K230_PLL_DIV,
+		.pll_div_cfg = &k230_pll_div_cfgs[K230_PLL0_DIV2],
+	},
+	.rate_cfg = &k230_cpu0_src_rate,
+	.rate_cfg_c = NULL,
+	.gate_cfg = &k230_cpu0_src_gate,
+	.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_cpu0_aclk = {
+	.name = "cpu0_aclk",
+	.read_only = false,
+	.flags = 0,
+	.num_parent = 1,
+	.parent[0] = {
+		.type = K230_CLK_COMPOSITE,
+		.clk_cfg = &k230_cpu0_src,
+	},
+	.rate_cfg = &k230_cpu0_aclk_rate,
+	.rate_cfg_c = NULL,
+	.gate_cfg = NULL,
+	.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_cpu0_plic = {
+	.name = "cpu0_plic",
+	.read_only = false,
+	.flags = 0,
+	.num_parent = 1,
+	.parent[0] = {
+		.type = K230_CLK_COMPOSITE,
+		.clk_cfg = &k230_cpu0_src,
+
+	},
+	.rate_cfg = &k230_cpu0_plic_rate,
+	.rate_cfg_c = NULL,
+	.gate_cfg = &k230_cpu0_plic_gate,
+	.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_cpu0_noc_ddrcp4 = {
+	.name = "cpu0_noc_ddrcp4",
+	.read_only = false,
+	.flags = 0,
+	.num_parent = 1,
+	.parent[0] = {
+		.type = K230_CLK_COMPOSITE,
+		.clk_cfg = &k230_cpu0_src,
+	},
+	.rate_cfg = NULL,
+	.rate_cfg_c = NULL,
+	.gate_cfg = &k230_cpu0_noc_ddrcp4_gate,
+	.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_cpu0_pclk = {
+	.name = "cpu0_pclk",
+	.read_only = false,
+	.flags = 0,
+	.num_parent = 1,
+	.parent[0] = {
+		.type = K230_PLL_DIV,
+		.pll_div_cfg = &k230_pll_div_cfgs[K230_PLL0_DIV4],
+	},
+	.rate_cfg = &k230_cpu0_pclk_rate,
+	.rate_cfg_c = NULL,
+	.gate_cfg = &k230_cpu0_pclk_gate,
+	.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_pmu_pclk = {
+		.name = "pmu_pclk",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_OSC24M,
+		},
+		.rate_cfg = NULL,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_pmu_pclk_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_hs_ospi_src = {
+		.name = "hs_ospi_src",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 2,
+		.parent[0] = {
+			.type = K230_PLL_DIV,
+			.pll_div_cfg = &k230_pll_div_cfgs[K230_PLL0_DIV2],
+		},
+		.parent[1] = {
+			.type = K230_PLL_DIV,
+			.pll_div_cfg = &k230_pll_div_cfgs[K230_PLL2_DIV4],
+		},
+		.rate_cfg = NULL,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_hs_ospi_src_gate,
+		.mux_cfg = &k230_hs_ospi_src_mux,
+};
+
+static struct k230_clk_cfg k230_ls_apb_src = {
+		.name = "ls_apb_src",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_PLL_DIV,
+			.pll_div_cfg = &k230_pll_div_cfgs[K230_PLL0_DIV4],
+		},
+		.rate_cfg = &k230_ls_apb_src_rate,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_ls_apb_src_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_ls_uart0_apb = {
+		.name = "ls_uart0_apb",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_CLK_COMPOSITE,
+			.clk_cfg = &k230_ls_apb_src,
+		},
+		.rate_cfg = NULL,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_ls_uart0_apb_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_ls_uart1_apb = {
+		.name = "ls_uart1_apb",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_CLK_COMPOSITE,
+			.clk_cfg = &k230_ls_apb_src,
+		},
+		.rate_cfg = NULL,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_ls_uart1_apb_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_ls_uart2_apb = {
+		.name = "ls_uart2_apb",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_CLK_COMPOSITE,
+			.clk_cfg = &k230_ls_apb_src,
+		},
+		.rate_cfg = NULL,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_ls_uart2_apb_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_ls_uart3_apb = {
+		.name = "ls_uart3_apb",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_CLK_COMPOSITE,
+			.clk_cfg = &k230_ls_apb_src,
+		},
+		.rate_cfg = NULL,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_ls_uart3_apb_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_ls_uart4_apb = {
+		.name = "ls_uart4_apb",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_CLK_COMPOSITE,
+			.clk_cfg = &k230_ls_apb_src,
+		},
+		.rate_cfg = NULL,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_ls_uart4_apb_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_ls_uart0 = {
+		.name = "ls_uart0",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_PLL_DIV,
+			.pll_div_cfg = &k230_pll_div_cfgs[K230_PLL0_DIV16],
+		},
+		.rate_cfg = &k230_ls_uart0_rate,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_ls_uart0_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_ls_uart1 = {
+		.name = "ls_uart1",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_PLL_DIV,
+			.pll_div_cfg = &k230_pll_div_cfgs[K230_PLL0_DIV16],
+		},
+		.rate_cfg = &k230_ls_uart1_rate,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_ls_uart1_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_ls_uart2 = {
+		.name = "ls_uart2",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_PLL_DIV,
+			.pll_div_cfg = &k230_pll_div_cfgs[K230_PLL0_DIV16],
+		},
+		.rate_cfg = &k230_ls_uart2_rate,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_ls_uart2_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_ls_uart3 = {
+		.name = "ls_uart3",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_PLL_DIV,
+			.pll_div_cfg = &k230_pll_div_cfgs[K230_PLL0_DIV16],
+		},
+		.rate_cfg = &k230_ls_uart3_rate,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_ls_uart3_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_ls_uart4 = {
+		.name = "ls_uart4",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_PLL_DIV,
+			.pll_div_cfg = &k230_pll_div_cfgs[K230_PLL0_DIV16],
+		},
+		.rate_cfg = &k230_ls_uart4_rate,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_ls_uart4_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_shrm_axi_src = {
+		.name = "shrm_axi_src",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_PLL_DIV,
+			.pll_div_cfg = &k230_pll_div_cfgs[K230_PLL0_DIV4],
+		},
+		.rate_cfg = NULL,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_shrm_axi_src_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_shrm_sdma_axi = {
+		.name = "shrm_sdma_axi",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_CLK_COMPOSITE,
+			.clk_cfg = &k230_shrm_axi_src,
+		},
+		.rate_cfg = NULL,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_shrm_sdma_axi_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg k230_shrm_pdma_axi = {
+		.name = "shrm_pdma_axi",
+		.read_only = false,
+		.flags = 0,
+		.num_parent = 1,
+		.parent[0] = {
+			.type = K230_CLK_COMPOSITE,
+			.clk_cfg = &k230_shrm_axi_src,
+		},
+		.rate_cfg = NULL,
+		.rate_cfg_c = NULL,
+		.gate_cfg = &k230_shrm_pdma_axi_gate,
+		.mux_cfg = NULL,
+};
+
+static struct k230_clk_cfg *k230_clk_cfgs[] = {
+	[K230_CPU0_SRC]			=	&k230_cpu0_src,
+	[K230_CPU0_ACLK]		=	&k230_cpu0_aclk,
+	[K230_CPU0_PLIC]		=	&k230_cpu0_plic,
+	[K230_CPU0_NOC_DDRCP4]		=	&k230_cpu0_noc_ddrcp4,
+	[K230_CPU0_PCLK]		=	&k230_cpu0_pclk,
+	[K230_PMU_PCLK]			=	&k230_pmu_pclk,
+	[K230_HS_OSPI_SRC]		=	&k230_hs_ospi_src,
+	[K230_LS_APB_SRC]		=	&k230_ls_apb_src,
+	[K230_LS_UART0_APB]		=	&k230_ls_uart0_apb,
+	[K230_LS_UART1_APB]		=	&k230_ls_uart1_apb,
+	[K230_LS_UART2_APB]		=	&k230_ls_uart2_apb,
+	[K230_LS_UART3_APB]		=	&k230_ls_uart3_apb,
+	[K230_LS_UART4_APB]		=	&k230_ls_uart4_apb,
+	[K230_LS_UART0]			=	&k230_ls_uart0,
+	[K230_LS_UART1]			=	&k230_ls_uart1,
+	[K230_LS_UART2]			=	&k230_ls_uart2,
+	[K230_LS_UART3]			=	&k230_ls_uart3,
+	[K230_LS_UART4]			=	&k230_ls_uart4,
+	[K230_SHRM_AXI_SRC]		=	&k230_shrm_axi_src,
+	[K230_SHRM_SDMA_AXI_GATE]	=	&k230_shrm_sdma_axi,
+	[K230_SHRM_PDMA_AXI_GATE]	=	&k230_shrm_pdma_axi,
+};
+
+#define K230_CLK_NUM	ARRAY_SIZE(k230_clk_cfgs)
+
+static void k230_init_pll(void __iomem *regs, enum k230_pll_id pll_id,
+			  struct k230_pll *pll)
+{
+	void __iomem *base;
+
+	pll->id = pll_id;
+	base = regs + k230_pll_cfgs[pll_id].reg;
+	pll->div = base + K230_PLL_DIV_REG_OFFSET;
+	pll->bypass = base + K230_PLL_BYPASS_REG_OFFSET;
+	pll->gate = base + K230_PLL_GATE_REG_OFFSET;
+	pll->lock = base + K230_PLL_LOCK_REG_OFFSET;
+}
+
+static int k230_pll_prepare(struct clk_hw *hw)
+{
+	struct k230_pll *pll = to_k230_pll(hw);
+	u32 reg;
+
+	/* wait for PLL lock until it reaches lock status */
+	return readl_poll_timeout(pll->lock, reg,
+				  (reg & K230_PLL_STATUS_MASK) == K230_PLL_STATUS_MASK,
+				  400, 0);
+}
+
+static bool k230_pll_hw_is_enabled(struct k230_pll *pll)
+{
+	return (readl(pll->gate) & K230_PLL_GATE_ENABLE) == K230_PLL_GATE_ENABLE;
+}
+
+static void k230_pll_enable_hw(void __iomem *regs, struct k230_pll *pll)
+{
+	u32 reg;
+
+	if (k230_pll_hw_is_enabled(pll))
+		return;
+
+	/* Set PLL factors */
+	reg = readl(pll->gate);
+	reg |= (K230_PLL_GATE_ENABLE | K230_PLL_GATE_WRITE_ENABLE);
+	writel(reg, pll->gate);
+}
+
+static int k230_pll_enable(struct clk_hw *hw)
+{
+	struct k230_pll *pll = to_k230_pll(hw);
+	struct k230_sysclk *ksc = pll->ksc;
+
+	guard(spinlock)(&ksc->pll_lock);
+	k230_pll_enable_hw(ksc->regs, pll);
+
+	return 0;
+}
+
+static void k230_pll_disable(struct clk_hw *hw)
+{
+	struct k230_pll *pll = to_k230_pll(hw);
+	struct k230_sysclk *ksc = pll->ksc;
+	u32 reg;
+
+	guard(spinlock)(&ksc->pll_lock);
+	reg = readl(pll->gate);
+	reg &= ~(K230_PLL_GATE_ENABLE);
+	reg |= (K230_PLL_GATE_WRITE_ENABLE);
+	writel(reg, pll->gate);
+}
+
+static int k230_pll_is_enabled(struct clk_hw *hw)
+{
+	return k230_pll_hw_is_enabled(to_k230_pll(hw));
+}
+
+static int k230_pll_init(struct clk_hw *hw)
+{
+	if (k230_pll_is_enabled(hw))
+		return clk_prepare_enable(hw->clk);
+
+	return 0;
+}
+
+static unsigned long k230_pll_get_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct k230_pll *pll = to_k230_pll(hw);
+	struct k230_sysclk *ksc = pll->ksc;
+	u32 reg;
+	u32 r, f, od;
+
+	reg = readl(pll->bypass);
+	if (reg & K230_PLL_BYPASS_ENABLE)
+		return parent_rate;
+
+	reg = readl(pll->lock);
+	if (!(reg & (K230_PLL_STATUS_MASK))) {
+		dev_err(&ksc->pdev->dev, "%s is unlock.\n", clk_hw_get_name(hw));
+		return 0;
+	}
+
+	reg = readl(pll->div);
+	r = ((reg >> K230_PLL_R_SHIFT) & K230_PLL_R_MASK) + 1;
+	f = ((reg >> K230_PLL_F_SHIFT) & K230_PLL_F_MASK) + 1;
+	od = ((reg >> K230_PLL_OD_SHIFT) & K230_PLL_OD_MASK) + 1;
+
+	return mul_u64_u32_div(parent_rate, f, r * od);
+}
+
+static const struct clk_ops k230_pll_ops = {
+	.init		= k230_pll_init,
+	.prepare	= k230_pll_prepare,
+	.enable	        = k230_pll_enable,
+	.disable	= k230_pll_disable,
+	.is_enabled	= k230_pll_is_enabled,
+	.recalc_rate	= k230_pll_get_rate,
+};
+
+static int k230_register_pll(struct platform_device *pdev,
+			     struct k230_sysclk *ksc,
+			     enum k230_pll_id pll_id,
+			     const char *name,
+			     int num_parents,
+			     const struct clk_ops *ops)
+{
+	struct k230_pll *pll = &ksc->plls[pll_id];
+	struct clk_init_data init = {};
+	struct device *dev = &pdev->dev;
+	int ret;
+	const struct clk_parent_data parent_data[] = {
+		{ .index = 0, },
+	};
+
+	init.name = name;
+	init.parent_data = parent_data;
+	init.num_parents = num_parents;
+	init.ops = ops;
+
+	pll->hw.init = &init;
+	pll->ksc = ksc;
+
+	ret = devm_clk_hw_register(dev, &pll->hw);
+	if (ret)
+		return ret;
+
+	k230_pll_cfgs[pll_id].pll = pll;
+
+	return 0;
+}
+
+static int k230_register_plls(struct platform_device *pdev, struct k230_sysclk *ksc)
+{
+	int i, ret;
+	const struct k230_pll_cfg *cfg;
+
+	for (i = 0; i < K230_PLL_NUM; i++) {
+		cfg = &k230_pll_cfgs[i];
+
+		k230_init_pll(ksc->pll_regs, i, &ksc->plls[i]);
+
+		ret = k230_register_pll(pdev, ksc, i, cfg->name, 1, &k230_pll_ops);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int k230_register_pll_divs(struct platform_device *pdev, struct k230_sysclk *ksc)
+{
+	struct device *dev = &pdev->dev;
+	struct k230_pll_div *pll_div;
+	struct clk_hw *hw;
+
+	for (int i = 0; i < K230_PLL_DIV_NUM; i++) {
+		hw = devm_clk_hw_register_fixed_factor(dev, k230_pll_div_cfgs[i].name,
+						       k230_pll_div_cfgs[i].parent_name,
+						       0, 1, k230_pll_div_cfgs[i].div);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+
+		pll_div = &ksc->dclks[i];
+		pll_div->hw = hw;
+		pll_div->ksc = ksc;
+		k230_pll_div_cfgs[i].pll_div = pll_div;
+	}
+
+	return 0;
+}
+
+static int k230_clk_enable(struct clk_hw *hw)
+{
+	struct k230_clk *clk = to_k230_clk(hw);
+	struct k230_sysclk *ksc = clk->ksc;
+	struct k230_clk_cfg *cfg = k230_clk_cfgs[clk->id];
+	struct k230_clk_gate_cfg *gate_cfg = cfg->gate_cfg;
+	u32 reg;
+
+	guard(spinlock)(&ksc->clk_lock);
+	reg = readl(gate_cfg->gate_reg);
+	if (gate_cfg->gate_bit_reverse)
+		reg &= ~BIT(gate_cfg->gate_bit_enable);
+	else
+		reg |= BIT(gate_cfg->gate_bit_enable);
+	writel(reg, gate_cfg->gate_reg);
+
+	return 0;
+}
+
+static void k230_clk_disable(struct clk_hw *hw)
+{
+	struct k230_clk *clk = to_k230_clk(hw);
+	struct k230_sysclk *ksc = clk->ksc;
+	struct k230_clk_cfg *cfg = k230_clk_cfgs[clk->id];
+	struct k230_clk_gate_cfg *gate_cfg = cfg->gate_cfg;
+	u32 reg;
+
+	guard(spinlock)(&ksc->clk_lock);
+	reg = readl(gate_cfg->gate_reg);
+
+	if (gate_cfg->gate_bit_reverse)
+		reg |= BIT(gate_cfg->gate_bit_enable);
+	else
+		reg &= ~BIT(gate_cfg->gate_bit_enable);
+
+	writel(reg, gate_cfg->gate_reg);
+}
+
+static int k230_clk_is_enabled(struct clk_hw *hw)
+{
+	struct k230_clk *clk = to_k230_clk(hw);
+	struct k230_sysclk *ksc = clk->ksc;
+	struct k230_clk_cfg *cfg = k230_clk_cfgs[clk->id];
+	struct k230_clk_gate_cfg *gate_cfg = cfg->gate_cfg;
+	u32 reg;
+
+	guard(spinlock)(&ksc->clk_lock);
+	reg = readl(gate_cfg->gate_reg);
+
+	/* Check gate bit condition based on configuration and then set ret */
+	if (gate_cfg->gate_bit_reverse)
+		return (BIT(gate_cfg->gate_bit_enable) & reg) ? 1 : 0;
+	else
+		return (BIT(gate_cfg->gate_bit_enable) & ~reg) ? 1 : 0;
+}
+
+static int k230_clk_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct k230_clk *clk = to_k230_clk(hw);
+	struct k230_sysclk *ksc = clk->ksc;
+	struct k230_clk_cfg *cfg = k230_clk_cfgs[clk->id];
+	struct k230_clk_mux_cfg *mux_cfg = cfg->mux_cfg;
+	u8 reg;
+
+	guard(spinlock)(&ksc->clk_lock);
+	reg = (mux_cfg->mux_reg_mask & index) << mux_cfg->mux_reg_shift;
+	writeb(reg, mux_cfg->mux_reg);
+
+	return 0;
+}
+
+static u8 k230_clk_get_parent(struct clk_hw *hw)
+{
+	struct k230_clk *clk = to_k230_clk(hw);
+	struct k230_sysclk *ksc = clk->ksc;
+	struct k230_clk_cfg *cfg = k230_clk_cfgs[clk->id];
+	struct k230_clk_mux_cfg *mux_cfg = cfg->mux_cfg;
+	u8 reg;
+
+	guard(spinlock)(&ksc->clk_lock);
+	reg = readb(mux_cfg->mux_reg);
+
+	return reg;
+}
+
+static unsigned long k230_clk_get_rate(struct clk_hw *hw,
+				       unsigned long parent_rate)
+{
+	struct k230_clk *clk = to_k230_clk(hw);
+	struct k230_sysclk *ksc = clk->ksc;
+	struct k230_clk_cfg *cfg = k230_clk_cfgs[clk->id];
+	struct k230_clk_rate_cfg *rate_cfg = cfg->rate_cfg;
+	struct k230_clk_rate_cfg_c *rate_cfg_c = cfg->rate_cfg_c;
+	u32 mul, div;
+
+	if (!rate_cfg) /* no divider, return parents' clk */
+		return parent_rate;
+
+	guard(spinlock)(&ksc->clk_lock);
+	switch (rate_cfg->method) {
+	/*
+	 * K230_MUL: div_mask+1/div_max...
+	 * K230_DIV: mul_max/div_mask+1
+	 * K230_MUL_DIV: mul_mask/div_mask...
+	 */
+	case K230_MUL:
+		div = rate_cfg->rate_div_max;
+		mul = (readl(rate_cfg->rate_reg) >> rate_cfg->rate_div_shift)
+			& rate_cfg->rate_div_mask;
+		mul++;
+		break;
+	case K230_DIV:
+		mul = rate_cfg->rate_mul_max;
+		div = (readl(rate_cfg->rate_reg) >> rate_cfg->rate_div_shift)
+			& rate_cfg->rate_div_mask;
+		div++;
+		break;
+	case K230_MUL_DIV:
+		if (!rate_cfg_c) {
+			mul = (readl(rate_cfg->rate_reg) >> rate_cfg->rate_mul_shift)
+				& rate_cfg->rate_mul_mask;
+			div = (readl(rate_cfg->rate_reg) >> rate_cfg->rate_div_shift)
+				& rate_cfg->rate_div_mask;
+		} else {
+			mul = (readl(rate_cfg_c->rate_reg_c) >> rate_cfg_c->rate_mul_shift_c)
+				& rate_cfg_c->rate_mul_mask_c;
+			div = (readl(rate_cfg->rate_reg) >> rate_cfg->rate_div_shift)
+				& rate_cfg->rate_div_mask;
+		}
+		break;
+	}
+
+	return mul_u64_u32_div(parent_rate, mul, div);
+}
+
+static int k230_clk_find_approximate(struct k230_clk *clk,
+				     u32 mul_min,
+				     u32 mul_max,
+				     u32 div_min,
+				     u32 div_max,
+				     enum k230_clk_div_type method,
+				     unsigned long rate,
+				     unsigned long parent_rate,
+				     u32 *div,
+				     u32 *mul)
+{
+	long abs_min;
+	long abs_current;
+	long perfect_divide;
+	struct k230_clk_cfg *cfg = k230_clk_cfgs[clk->id];
+	struct k230_clk_rate_cfg *rate_cfg = cfg->rate_cfg;
+
+	const u32 codec_clk[9] = {
+		2048000,
+		3072000,
+		4096000,
+		6144000,
+		8192000,
+		11289600,
+		12288000,
+		24576000,
+		49152000
+	};
+
+	const u32 codec_div[9][2] = {
+		{3125, 16},
+		{3125, 24},
+		{3125, 32},
+		{3125, 48},
+		{3125, 64},
+		{15625, 441},
+		{3125, 96},
+		{3125, 192},
+		{3125, 384}
+	};
+
+	const u32 pdm_clk[20] = {
+		128000,
+		192000,
+		256000,
+		384000,
+		512000,
+		768000,
+		1024000,
+		1411200,
+		1536000,
+		2048000,
+		2822400,
+		3072000,
+		4096000,
+		5644800,
+		6144000,
+		8192000,
+		11289600,
+		12288000,
+		24576000,
+		49152000
+	};
+
+	const u32 pdm_div[20][2] = {
+		{3125, 1},
+		{6250, 3},
+		{3125, 2},
+		{3125, 3},
+		{3125, 4},
+		{3125, 6},
+		{3125, 8},
+		{125000, 441},
+		{3125, 12},
+		{3125, 16},
+		{62500, 441},
+		{3125, 24},
+		{3125, 32},
+		{31250, 441},
+		{3125, 48},
+		{3125, 64},
+		{15625, 441},
+		{3125, 96},
+		{3125, 192},
+		{3125, 384}
+	};
+
+	switch (method) {
+	/* only mul can be changeable 1/12,2/12,3/12...*/
+	case K230_MUL:
+		perfect_divide = (long)((parent_rate * 1000) / rate);
+		abs_min = abs(perfect_divide -
+			     (long)(((long)div_max * 1000) / (long)mul_min));
+		*mul = mul_min;
+
+		for (u32 i = mul_min + 1; i <= mul_max; i++) {
+			abs_current = abs(perfect_divide -
+					(long)((long)((long)div_max * 1000) / (long)i));
+			if (abs_min > abs_current) {
+				abs_min = abs_current;
+				*mul = i;
+			}
+		}
+
+		*div = div_max;
+		break;
+	/* only div can be changeable, 1/1,1/2,1/3...*/
+	case K230_DIV:
+		perfect_divide = (long)((parent_rate * 1000) / rate);
+		abs_min = abs(perfect_divide -
+			     (long)(((long)div_min * 1000) / (long)mul_max));
+		*div = div_min;
+
+		for (u32 i = div_min + 1; i <= div_max; i++) {
+			abs_current = abs(perfect_divide -
+					 (long)((long)((long)i * 1000) / (long)mul_max));
+			if (abs_min > abs_current) {
+				abs_min = abs_current;
+				*div = i;
+			}
+		}
+
+		*mul = mul_max;
+		break;
+	/* mul and div can be changeable. */
+	case K230_MUL_DIV:
+		if (rate_cfg->rate_reg_off == K230_CLK_CODEC_ADC_MCLKDIV_OFFSET ||
+		    rate_cfg->rate_reg_off == K230_CLK_CODEC_DAC_MCLKDIV_OFFSET) {
+			for (u32 j = 0; j < 9; j++) {
+				if (0 == (rate - codec_clk[j])) {
+					*div = codec_div[j][0];
+					*mul = codec_div[j][1];
+				}
+			}
+		} else if (rate_cfg->rate_reg_off == K230_CLK_AUDIO_CLKDIV_OFFSET ||
+			   rate_cfg->rate_reg_off == K230_CLK_PDM_CLKDIV_OFFSET) {
+			for (u32 j = 0; j < 20; j++) {
+				if (0 == (rate - pdm_clk[j])) {
+					*div = pdm_div[j][0];
+					*mul = pdm_div[j][1];
+				}
+			}
+		} else {
+			return -EINVAL;
+		}
+		break;
+	}
+
+	return 0;
+}
+
+static long k230_clk_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *parent_rate)
+{
+	struct k230_clk *clk = to_k230_clk(hw);
+	struct k230_sysclk *ksc = clk->ksc;
+	struct k230_clk_cfg *cfg = k230_clk_cfgs[clk->id];
+	struct k230_clk_rate_cfg *rate_cfg = cfg->rate_cfg;
+	u32 div = 0, mul = 0;
+
+	if (k230_clk_find_approximate(clk,
+				      rate_cfg->rate_mul_min, rate_cfg->rate_mul_max,
+				      rate_cfg->rate_div_min, rate_cfg->rate_div_max,
+				      rate_cfg->method, rate, *parent_rate, &div, &mul)) {
+		return 0;
+	}
+
+	return mul_u64_u32_div(*parent_rate, mul, div);
+}
+
+static int k230_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct k230_clk *clk = to_k230_clk(hw);
+	struct k230_sysclk *ksc = clk->ksc;
+	struct k230_clk_cfg *cfg = k230_clk_cfgs[clk->id];
+	struct k230_clk_rate_cfg *rate_cfg = cfg->rate_cfg;
+	struct k230_clk_rate_cfg_c *rate_cfg_c = cfg->rate_cfg_c;
+	u32 div = 0, mul = 0, reg = 0, reg_c;
+
+	if (rate > parent_rate || rate == 0 || parent_rate == 0) {
+		dev_err(&ksc->pdev->dev, "rate or parent_rate error\n");
+		return -EINVAL;
+	}
+
+	if (cfg->read_only) {
+		dev_err(&ksc->pdev->dev, "This clk rate is read only\n");
+		return -EPERM;
+	}
+
+	if (k230_clk_find_approximate(clk,
+				      rate_cfg->rate_mul_min, rate_cfg->rate_mul_max,
+				      rate_cfg->rate_div_min, rate_cfg->rate_div_max,
+				      rate_cfg->method, rate, parent_rate, &div, &mul)) {
+		return -EINVAL;
+	}
+
+	guard(spinlock)(&ksc->clk_lock);
+	if (!rate_cfg_c) {
+		reg = readl(rate_cfg->rate_reg);
+		reg &= ~((rate_cfg->rate_div_mask) << (rate_cfg->rate_div_shift));
+
+		if (rate_cfg->method == K230_DIV) {
+			reg &= ~((rate_cfg->rate_mul_mask) << (rate_cfg->rate_mul_shift));
+			reg |= ((div - 1) & rate_cfg->rate_div_mask) << (rate_cfg->rate_div_shift);
+		} else if (rate_cfg->method == K230_MUL) {
+			reg |= ((mul - 1) & rate_cfg->rate_div_mask) << (rate_cfg->rate_div_shift);
+		} else {
+			reg |= (mul & rate_cfg->rate_mul_mask) << (rate_cfg->rate_mul_shift);
+			reg |= (div & rate_cfg->rate_div_mask) << (rate_cfg->rate_div_shift);
+		}
+		reg |= BIT(rate_cfg->rate_write_enable_bit);
+	} else {
+		reg = readl(rate_cfg->rate_reg);
+		reg_c = readl(rate_cfg_c->rate_reg_c);
+		reg &= ~((rate_cfg->rate_div_mask) << (rate_cfg->rate_div_shift));
+		reg_c &= ~((rate_cfg_c->rate_mul_mask_c) << (rate_cfg_c->rate_mul_shift_c));
+		reg_c |= BIT(rate_cfg_c->rate_write_enable_bit_c);
+
+		reg_c |= (mul & rate_cfg_c->rate_mul_mask_c) << (rate_cfg_c->rate_mul_shift_c);
+		reg |= (div & rate_cfg->rate_div_mask) << (rate_cfg->rate_div_shift);
+
+		writel(reg_c, rate_cfg_c->rate_reg_c);
+	}
+	writel(reg, rate_cfg->rate_reg);
+
+	return 0;
+}
+
+static const struct clk_ops k230_clk_ops_arr[K230_CLK_OPS_ID_NUM] = {
+	[K230_CLK_OPS_ID_NONE] = {
+		/* Sentinel */
+	},
+	[K230_CLK_OPS_ID_GATE_ONLY] = {
+		K230_CLK_OPS_GATE,
+	},
+	[K230_CLK_OPS_ID_RATE_ONLY] = {
+		K230_CLK_OPS_RATE,
+	},
+	[K230_CLK_OPS_ID_RATE_GATE] = {
+		K230_CLK_OPS_RATE,
+		K230_CLK_OPS_GATE,
+	},
+	[K230_CLK_OPS_ID_MUX_ONLY] = {
+		K230_CLK_OPS_MUX,
+	},
+	[K230_CLK_OPS_ID_MUX_GATE] = {
+		K230_CLK_OPS_MUX,
+		K230_CLK_OPS_GATE,
+	},
+	[K230_CLK_OPS_ID_MUX_RATE] = {
+		K230_CLK_OPS_MUX,
+		K230_CLK_OPS_RATE,
+	},
+	[K230_CLK_OPS_ID_ALL] = {
+		K230_CLK_OPS_MUX,
+		K230_CLK_OPS_RATE,
+		K230_CLK_OPS_GATE,
+	},
+};
+
+static int k230_register_clk(struct platform_device *pdev,
+			     struct k230_sysclk *ksc,
+			     int id,
+			     const struct clk_parent_data *parent_data,
+			     u8 num_parents,
+			     unsigned long flags)
+{
+	struct k230_clk *clk = &ksc->clks[id];
+	struct k230_clk_cfg *cfg = k230_clk_cfgs[id];
+	struct k230_clk_gate_cfg *gate_cfg = cfg->gate_cfg;
+	struct k230_clk_rate_cfg *rate_cfg = cfg->rate_cfg;
+	struct k230_clk_mux_cfg *mux_cfg = cfg->mux_cfg;
+	struct k230_clk_rate_cfg_c *rate_cfg_c = cfg->rate_cfg_c;
+	struct clk_init_data init = {};
+	int clk_id = 0;
+	int ret;
+
+	if (rate_cfg) {
+		rate_cfg->rate_reg = ksc->regs + rate_cfg->rate_reg_off;
+		clk_id += K230_CLK_OPS_ID_RATE_ONLY;
+	}
+
+	if (mux_cfg) {
+		mux_cfg->mux_reg = ksc->regs + mux_cfg->mux_reg_off;
+		clk_id += K230_CLK_OPS_ID_MUX_ONLY;
+
+		/* mux clock doesn't match the case that num_parents less than 2 */
+		if (num_parents < 2)
+			return -EINVAL;
+	}
+
+	if (gate_cfg) {
+		gate_cfg->gate_reg = ksc->regs + gate_cfg->gate_reg_off;
+		clk_id += K230_CLK_OPS_ID_GATE_ONLY;
+	}
+
+	if (rate_cfg_c)
+		rate_cfg_c->rate_reg_c = ksc->regs + rate_cfg_c->rate_reg_off_c;
+
+	init.name = k230_clk_cfgs[id]->name;
+	init.flags = flags;
+	init.parent_data = parent_data;
+	init.num_parents = num_parents;
+	init.ops = &k230_clk_ops_arr[clk_id];
+
+	clk->id = id;
+	clk->ksc = ksc;
+	clk->hw.init = &init;
+
+	ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
+	if (ret)
+		return ret;
+
+	k230_clk_cfgs[id]->clk = clk;
+
+	return 0;
+}
+
+static int k230_register_mux_clk(struct platform_device *pdev,
+				 struct k230_sysclk *ksc,
+				 struct clk_parent_data *parent_data,
+				 int num_parent,
+				 int id)
+{
+	return k230_register_clk(pdev, ksc, id, parent_data, num_parent, 0);
+}
+
+static int k230_register_osc24m_child(struct platform_device *pdev,
+				      struct k230_sysclk *ksc,
+				      int id)
+{
+	const struct clk_parent_data parent_data = {
+		.index = 0,
+	};
+	return k230_register_clk(pdev, ksc, id, &parent_data, 1, 0);
+}
+
+static int k230_register_pll_child(struct platform_device *pdev,
+				   struct k230_sysclk *ksc,
+				   int id,
+				   struct clk_hw *parent_hw,
+				   unsigned long flags)
+{
+	const struct clk_parent_data parent_data = {
+		.hw = parent_hw,
+	};
+	return k230_register_clk(pdev, ksc, id, &parent_data, 1, flags);
+}
+
+static int k230_register_pll_div_child(struct platform_device *pdev,
+				       struct k230_sysclk *ksc,
+				       int id,
+				       struct clk_hw *parent_hw,
+				       unsigned long flags)
+{
+	const struct clk_parent_data parent_data = {
+		.hw = parent_hw,
+	};
+	return k230_register_clk(pdev, ksc, id, &parent_data, 1, flags);
+}
+
+static int k230_register_clk_child(struct platform_device *pdev,
+				   struct k230_sysclk *ksc,
+				   int id,
+				   struct clk_hw *parent_hw)
+{
+	const struct clk_parent_data parent_data = {
+		.hw = parent_hw,
+	};
+	return k230_register_clk(pdev, ksc, id, &parent_data, 1, 0);
+}
+
+static int k230_clk_get_parent_data(struct k230_clk_parent *pclk,
+				    struct clk_parent_data *parent_data)
+{
+	switch (pclk->type) {
+	case K230_OSC24M:
+		parent_data->index = 0;
+		break;
+	case K230_PLL:
+		parent_data->hw = &pclk->pll_cfg->pll->hw;
+		break;
+	case K230_PLL_DIV:
+		parent_data->hw = pclk->pll_div_cfg->pll_div->hw;
+		break;
+	case K230_CLK_COMPOSITE:
+		parent_data->hw = &pclk->clk_cfg->clk->hw;
+		break;
+	}
+
+	return 0;
+}
+
+static int k230_clk_mux_get_parent_data(struct k230_clk_cfg *cfg,
+					struct clk_parent_data *parent_data)
+{
+	int ret;
+	struct k230_clk_parent *pclk = cfg->parent;
+
+	for (int i = 0; i < cfg->num_parent; i++) {
+		ret = k230_clk_get_parent_data(&pclk[i], &parent_data[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int k230_register_clks(struct platform_device *pdev, struct k230_sysclk *ksc)
+{
+	struct k230_clk_cfg *cfg;
+	struct k230_clk_parent *pclk;
+	struct clk_parent_data parent_data[K230_CLK_MAX_PARENT_NUM];
+	int ret, i;
+
+	/*
+	 *  Single parent clock:
+	 *  pll0_div2 sons: cpu0_src
+	 *  pll0_div4 sons: cpu0_pclk
+	 *  cpu0_src sons: cpu0_aclk, cpu0_plic, cpu0_noc_ddrcp4, pmu_pclk
+	 *
+	 *  Mux clock:
+	 *  hs_ospi_src parents: pll0_div2, pll2_div4
+	 */
+	for (i = 0; i < K230_CLK_NUM; i++) {
+		cfg = k230_clk_cfgs[i];
+		if (!cfg)
+			continue;
+
+		if (cfg->mux_cfg) {
+			ret = k230_clk_mux_get_parent_data(cfg, parent_data);
+			if (ret)
+				return ret;
+
+			ret = k230_register_mux_clk(pdev, ksc, parent_data,
+						    cfg->num_parent, i);
+		} else {
+			pclk = cfg->parent;
+			switch (pclk->type) {
+			case K230_OSC24M:
+				ret = k230_register_osc24m_child(pdev, ksc, i);
+				break;
+			case K230_PLL:
+				ret = k230_register_pll_child(pdev, ksc, i,
+							      &pclk->pll_cfg->pll->hw,
+							      cfg->flags);
+				break;
+			case K230_PLL_DIV:
+				ret = k230_register_pll_div_child(pdev, ksc, i,
+								  pclk->pll_div_cfg->pll_div->hw,
+								  cfg->flags);
+				break;
+			case K230_CLK_COMPOSITE:
+				ret = k230_register_clk_child(pdev, ksc, i,
+							      &pclk->clk_cfg->clk->hw);
+				break;
+			}
+		}
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static struct clk_hw *k230_clk_hw_onecell_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct k230_sysclk *ksc;
+	unsigned int idx;
+
+	if (clkspec->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	idx = clkspec->args[0];
+	if (idx >= K230_CLK_NUM)
+		return ERR_PTR(-EINVAL);
+
+	if (!data)
+		return ERR_PTR(-EINVAL);
+
+	ksc = data;
+
+	return &ksc->clks[idx].hw;
+}
+
+static int k230_clk_init_plls(struct platform_device *pdev)
+{
+	int ret;
+	struct k230_sysclk *ksc = platform_get_drvdata(pdev);
+
+	spin_lock_init(&ksc->pll_lock);
+
+	ksc->pll_regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ksc->pll_regs))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ksc->pll_regs), "map registers failed\n");
+
+	ret = k230_register_plls(pdev, ksc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "register plls failed\n");
+
+	ret = k230_register_pll_divs(pdev, ksc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "register pll_divs failed\n");
+
+	for (int i = 0; i < K230_PLL_DIV_NUM; i++) {
+		ret = devm_clk_hw_register_clkdev(&pdev->dev, ksc->dclks[i].hw,
+						  k230_pll_div_cfgs[i].name, NULL);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "clock_lookup create failed\n");
+	}
+
+	return 0;
+}
+
+static int k230_clk_init_clks(struct platform_device *pdev)
+{
+	int ret;
+	struct k230_sysclk *ksc = platform_get_drvdata(pdev);
+
+	spin_lock_init(&ksc->clk_lock);
+
+	ksc->regs = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(ksc->regs))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ksc->regs), "failed to map registers\n");
+
+	ret = k230_register_clks(pdev, ksc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "register clock provider failed\n");
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, k230_clk_hw_onecell_get, ksc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "add clock provider failed\n");
+
+	return 0;
+}
+
+static int k230_clk_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct k230_sysclk *ksc;
+
+	ksc = devm_kzalloc(&pdev->dev, sizeof(*ksc), GFP_KERNEL);
+	if (!ksc)
+		return -ENOMEM;
+
+	ksc->plls = devm_kcalloc(&pdev->dev, K230_PLL_NUM,
+				 sizeof(*ksc->plls), GFP_KERNEL);
+	if (!ksc->plls)
+		return -ENOMEM;
+
+	ksc->dclks = devm_kcalloc(&pdev->dev, K230_PLL_DIV_NUM,
+				  sizeof(*ksc->dclks), GFP_KERNEL);
+	if (!ksc->dclks)
+		return -ENOMEM;
+
+	ksc->clks = devm_kcalloc(&pdev->dev, K230_CLK_NUM,
+				 sizeof(*ksc->clks), GFP_KERNEL);
+	if (!ksc->clks)
+		return -ENOMEM;
+
+	ksc->pdev = pdev;
+	platform_set_drvdata(pdev, ksc);
+
+	ret = k230_clk_init_plls(pdev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "init plls failed\n");
+
+	ret = k230_clk_init_clks(pdev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "init clks failed\n");
+
+	return 0;
+}
+
+static const struct of_device_id k230_clk_ids[] = {
+	{ .compatible = "canaan,k230-clk" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, k230_clk_ids);
+
+static struct platform_driver k230_clk_driver = {
+	.driver = {
+		.name  = "k230_clock_controller",
+		.of_match_table = k230_clk_ids,
+	},
+	.probe = k230_clk_probe,
+};
+builtin_platform_driver(k230_clk_driver);

-- 
2.34.1


