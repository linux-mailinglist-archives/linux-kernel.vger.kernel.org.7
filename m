Return-Path: <linux-kernel+bounces-758512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA2B1D01E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC59173CD4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F101A23BE;
	Thu,  7 Aug 2025 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="kjGoNI0W"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718AA1B425C;
	Thu,  7 Aug 2025 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754530287; cv=none; b=gJZnNaxAjNvp4CV/ZJjYyun3zkgnXaplW/UziC6K0fLyjGykxCltXWDIogFoEdR2YEzmJ8o+ipNco+m2XFyhUjfgUMglIQuwmjnz4TbN0h5WHphlJ7KkG6oGdoiQ4+DD4iaqyZN7u2YKZTbvjOXRlHs2zNRtM94fTvFgzhPqxU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754530287; c=relaxed/simple;
	bh=AbRB8J+EX7w4nB5/nq9KzAMM0hccGR6tSSToSFDQWvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mRB3FyvU2/oVoQlOkRPvx/j5v1RgCgwZ1u7HMr1sxzjnVSPsfjEAcnrk3T2J49agE+beYEFB22vmLUCdU5Su4aZ6+DgDFbhRcFD7EB+E2MGXa/1rcDmFE/Z2gUARrgvBsNu4UOztOrlC/Xb26nBtBABPCy5aXQINzRt4pMGKSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=kjGoNI0W; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754530221;
	bh=OU44WJoeZAKubf492SsoWRsfQCJn8pRFYEpU+6pMfV0=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=kjGoNI0WrYAe8XSNYp8kY8BdnpDcFG28vffumiAt+OFKHQ6oeq72baF738lJNEhoi
	 bcui1Lqt24sj0a+1DlULYqFgMos8Km0L14jd6I5IgwlapBBTL97bvoIkauHLuLJFmb
	 nkO8IVz1oilW4E8An3FBOBmmcW/w++5+Ay25QxiA=
X-QQ-mid: zesmtpsz2t1754530220t3a52aed6
X-QQ-Originating-IP: WL/WEHYpKq10uOstCy9jPUNzhYSHHI7doG4J4mJvHeg=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Aug 2025 09:30:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2328846353165535244
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 07 Aug 2025 09:30:11 +0800
Subject: [PATCH 2/2] clk: spacemit: introduce i2s pre-clock and fix i2s
 clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-k1-clk-i2s-generation-v1-2-7dc25eb4e4d3@linux.spacemit.com>
References: <20250807-k1-clk-i2s-generation-v1-0-7dc25eb4e4d3@linux.spacemit.com>
In-Reply-To: <20250807-k1-clk-i2s-generation-v1-0-7dc25eb4e4d3@linux.spacemit.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jinmei Wei <weijinmei@linux.spacemit.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754530210; l=15324;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=AbRB8J+EX7w4nB5/nq9KzAMM0hccGR6tSSToSFDQWvI=;
 b=bhuT5D5DQiZs2uGLUV+UtbwyM8Z1Pnbdv9yBsc+azvRH1R9FEwbAnbIrSTBhx/mvyRclgWXuJ
 P6koTDZiiMUCgHmmhW1cSuPq33n4k7qvJInmC4ygmaF+RskyOtnE5ZF
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OAf9apBnkUx3nmGJmOzgOJ0+o6d5i/mnT2DXBe+UwC1DeHsT4SRMlmUb
	CVxUTDXfVH07/CqUYwkqP3SogR+s5y1D+0BB6yPiBjgUUr6RDX08riMWNEdviH8DGL9kzHA
	LV9TCMVOI/J83/iYWmyFX1CWhIR8Ze2d01jAPOS199bfQ4i5PJiGb5tCe5Tb6qe4jICYK3r
	PaTFBcZv27LzCr8cEl/cj+EMU0ovhPpajPfPl8zpetCGiwt2a13uxXjLTEo8LMxbA/CbhFH
	a5i+9vn926rHK12sx0E8W4K4Nquh48opVyk741T/r/kScyBbnDBz9prd75N39wATo0mLXIo
	8XRraflZIyZe+lLX4hprB+D0Ada59dqO2t1AgGbs7M3bxbNTCBhtbVrZkqNT70Ie7r7T3Yc
	Q1Iv4QIK9yt62MrQhHjtefqMVr//WrUvwt/Ctp4Y0TKRXZNmssgCoWuJhmIHKDMmweGP1Yo
	k9tvkZWl4jhOV17pyYCXHMI1DjNsAFyAL7bmjQvFAG3M5sQJ8OigpwZ2D62/8HDiyISKFWm
	y92UaYuIPqc0gvIXLCCiKjoS9GVPeuayGFQyHZMWodt9cQUCGLLFbsakWE8X2yRH5usOrxD
	Qu4fBK8BBEDqwRrYBNaVPEc2i7GFUiwNyjfthuL3rzOoF9N5oH+7lt6ODok8YSG0iUMc4Ns
	UfP1GB7dXWwF1JhT0R6rFgpO3jp4xocBJgwWDRMIND2RxQIkukKy9RWpPOrbSgwzFWhHLR7
	sE6bM+BHajblu7OTm6pwQI0MiDpDQiIAkZnT5L1kD/uXlyxORtRt2nMUzy40Aqc0oSyTmCI
	YZICV3xnXxoAb16BIO6YEIZfewQVJk2v0rVV2D59E6p1MF5hCv8feDRLfZGq842CFQoo1MX
	BCcbctqXEmaFWuJwc43NoNPfN3Lj/J6mT0T6n7VJRi68gJeh4o/lCBc3dFNe9155BHOGm71
	Xvugb0hVAt6xJnHjd5j35guqCkTi5cnXmyLxxpoSk4YwU+Q82VvkxGTlzvw4d4xpaMWwY1H
	/cSXA8nlyTy+b63YfwBnCdFutTo7xIKa+m+lqdR8ta2hfjbUnrM22Grn+vVAdu0CE8MYOFD
	Gl/ziGwYLuTVRAQdpQZHXVgr9ARPR31XwTEXyP5tV6qWT/EwMvrmXQ=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Defining i2s_bclk and i2s_sysclk as fixed-rate clocks is insufficient
for real I2S use cases.

Moreover, the current I2S clock configuration does not work as expected
due to missing parent clocks.

This patch adds the missing parent clocks, defines i2s_sysclk as
a DDN clock, and i2s_bclk as a DIV clock.

The i2s_sysclk behaves as an M/N fractional divider in hardware,
with an additional gate control.

To properly model this, CCU_DDN_GATE_DEFINE is introduced.

The original DDN operations applied an implicit divide-by-2, which should
not be a default behavior.

This patch removes that assumption, letting each clock define its
actual behavior explicitly.

The i2s_bclk is a non-linear, discrete divider clock.
The previous macro only supported linear dividers,
so CCU_DIV_TABLE_GATE_DEFINE is introduced to support
the hardware accurately.

The I2S-related clock registers can be found here [1].

Link:
https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb
[1]

Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Co-developer: Jinmei Wei <weijinmei@linux.spacemit.com>
Signed-off-by: Jinmei Wei <weijinmei@linux.spacemit.com>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 drivers/clk/spacemit/ccu-k1.c     | 34 ++++++++++++++++++++++++----
 drivers/clk/spacemit/ccu_common.h | 13 +++++++++++
 drivers/clk/spacemit/ccu_ddn.c    | 47 ++++++++++++++++++++++++++++++++++-----
 drivers/clk/spacemit/ccu_ddn.h    | 25 +++++++++++++++++++--
 drivers/clk/spacemit/ccu_mix.c    | 47 +++++++++++++++++++++++++++++----------
 drivers/clk/spacemit/ccu_mix.h    | 26 +++++++++++++---------
 include/soc/spacemit/k1-syscon.h  |  7 +++---
 7 files changed, 161 insertions(+), 38 deletions(-)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index 65e6de030717afa60eefab7bda88f9a13b857650..a6773d4c2ff32d270e1f09b0d93cfff727ea98fa 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -136,13 +136,36 @@ CCU_GATE_DEFINE(pll1_d3_819p2, CCU_PARENT_HW(pll1_d3), MPMU_ACGR, BIT(14), 0);
 CCU_GATE_DEFINE(pll1_d2_1228p8, CCU_PARENT_HW(pll1_d2), MPMU_ACGR, BIT(16), 0);
 
 CCU_GATE_DEFINE(slow_uart, CCU_PARENT_NAME(osc), MPMU_ACGR, BIT(1), CLK_IGNORE_UNUSED);
-CCU_DDN_DEFINE(slow_uart1_14p74, pll1_d16_153p6, MPMU_SUCCR, 16, 13, 0, 13, 0);
-CCU_DDN_DEFINE(slow_uart2_48, pll1_d4_614p4, MPMU_SUCCR_1, 16, 13, 0, 13, 0);
+CCU_DDN_DEFINE(slow_uart1_14p74, pll1_d16_153p6, MPMU_SUCCR, 16, 13, 0, 13, 2, 0);
+CCU_DDN_DEFINE(slow_uart2_48, pll1_d4_614p4, MPMU_SUCCR_1, 16, 13, 0, 13, 2, 0);
 
 CCU_GATE_DEFINE(wdt_clk, CCU_PARENT_HW(pll1_d96_25p6), MPMU_WDTPCR, BIT(1), 0);
 
-CCU_FACTOR_GATE_DEFINE(i2s_sysclk, CCU_PARENT_HW(pll1_d16_153p6), MPMU_ISCCR, BIT(31), 50, 1);
-CCU_FACTOR_GATE_DEFINE(i2s_bclk, CCU_PARENT_HW(i2s_sysclk), MPMU_ISCCR, BIT(29), 1, 1);
+CCU_FACTOR_DEFINE(i2s_153p6, CCU_PARENT_HW(pll1_d8_307p2), 2, 1);
+
+static const struct clk_parent_data i2s_153p6_base_parents[] = {
+	CCU_PARENT_HW(i2s_153p6),
+	CCU_PARENT_HW(pll1_d8_307p2),
+};
+CCU_MUX_DEFINE(i2s_153p6_base, i2s_153p6_base_parents, MPMU_FCCR, 29, 1, 0);
+
+static const struct clk_parent_data i2s_sysclk_src_parents[] = {
+	CCU_PARENT_HW(pll1_d96_25p6),
+	CCU_PARENT_HW(i2s_153p6_base)
+};
+CCU_MUX_DEFINE(i2s_sysclk_src, i2s_sysclk_src_parents, MPMU_ISCCR, 30, 1, 0);
+
+CCU_DDN_GATE_DEFINE(i2s_sysclk, i2s_sysclk_src, MPMU_ISCCR, 0, 15, 15, 12, BIT(31), 1, 0);
+
+static const struct clk_div_table i2s_bclk_div_table[] = {
+	{ .val = 0, .div = 2 },
+	{ .val = 1, .div = 4 },
+	{ .val = 2, .div = 6 },
+	{ .val = 3, .div = 8 },
+	{ /* sentinel */ },
+};
+CCU_DIV_TABLE_GATE_DEFINE(i2s_bclk, CCU_PARENT_HW(i2s_sysclk), MPMU_ISCCR,
+			  27, 2, i2s_bclk_div_table, BIT(29), 0);
 
 static const struct clk_parent_data apb_parents[] = {
 	CCU_PARENT_HW(pll1_d96_25p6),
@@ -756,6 +779,9 @@ static struct clk_hw *k1_ccu_mpmu_hws[] = {
 	[CLK_I2S_BCLK]		= &i2s_bclk.common.hw,
 	[CLK_APB]		= &apb_clk.common.hw,
 	[CLK_WDT_BUS]		= &wdt_bus_clk.common.hw,
+	[CLK_I2S_153P6]		= &i2s_153p6.common.hw,
+	[CLK_I2S_153P6_BASE]	= &i2s_153p6_base.common.hw,
+	[CLK_I2S_SYSCLK_SRC]	= &i2s_sysclk_src.common.hw,
 };
 
 static const struct spacemit_ccu_data k1_ccu_mpmu_data = {
diff --git a/drivers/clk/spacemit/ccu_common.h b/drivers/clk/spacemit/ccu_common.h
index da72f3836e0b5c3482ffbb32d9d0f7f9185bfb54..ebe225dcfaee9ae79915a0d0f6dcbe8929038b3a 100644
--- a/drivers/clk/spacemit/ccu_common.h
+++ b/drivers/clk/spacemit/ccu_common.h
@@ -31,11 +31,24 @@ struct ccu_common {
 	struct clk_hw hw;
 };
 
+
+/**
+ * struct ccu_gate_config - Gate configuration
+ *
+ * @mask:	Mask to enable the gate. Some clocks may have more than one bit
+ *		set in this field.
+ */
+struct ccu_gate_config {
+	u32 mask;
+};
+
 static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
 {
 	return container_of(hw, struct ccu_common, hw);
 }
 
+#define CCU_GATE_INIT(_mask)		{ .mask = _mask }
+
 #define ccu_read(c, reg)						\
 	({								\
 		u32 tmp;						\
diff --git a/drivers/clk/spacemit/ccu_ddn.c b/drivers/clk/spacemit/ccu_ddn.c
index be311b045698e95a688a35858a8ac1bcfbffd2c7..c2b19dcb1b35c5e2092e5930e53236443f1355a9 100644
--- a/drivers/clk/spacemit/ccu_ddn.c
+++ b/drivers/clk/spacemit/ccu_ddn.c
@@ -22,21 +22,46 @@
 
 #include "ccu_ddn.h"
 
-static unsigned long ccu_ddn_calc_rate(unsigned long prate,
-				       unsigned long num, unsigned long den)
+static void ccu_gate_disable(struct clk_hw *hw)
 {
-	return prate * den / 2 / num;
+	struct ccu_ddn *ddn  = hw_to_ccu_ddn(hw);
+
+	ccu_update(&ddn->common, ctrl, ddn->gate.mask, 0);
+}
+
+static int ccu_gate_enable(struct clk_hw *hw)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	struct ccu_gate_config *gate = &ddn->gate;
+
+	ccu_update(&ddn->common, ctrl, gate->mask, gate->mask);
+
+	return 0;
+}
+
+static int ccu_gate_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	struct ccu_gate_config *gate = &ddn->gate;
+
+	return (ccu_read(&ddn->common, ctrl) & gate->mask) == gate->mask;
+}
+
+static unsigned long ccu_ddn_calc_rate(unsigned long prate, unsigned long num,
+				       unsigned long den, unsigned int pre_div)
+{
+	return prate * den / pre_div / num;
 }
 
 static unsigned long ccu_ddn_calc_best_rate(struct ccu_ddn *ddn,
 					    unsigned long rate, unsigned long prate,
 					    unsigned long *num, unsigned long *den)
 {
-	rational_best_approximation(rate, prate / 2,
+	rational_best_approximation(rate, prate / ddn->pre_div,
 				    ddn->den_mask >> ddn->den_shift,
 				    ddn->num_mask >> ddn->num_shift,
 				    den, num);
-	return ccu_ddn_calc_rate(prate, *num, *den);
+	return ccu_ddn_calc_rate(prate, *num, *den, ddn->pre_div);
 }
 
 static long ccu_ddn_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -58,7 +83,7 @@ static unsigned long ccu_ddn_recalc_rate(struct clk_hw *hw, unsigned long prate)
 	num = (val & ddn->num_mask) >> ddn->num_shift;
 	den = (val & ddn->den_mask) >> ddn->den_shift;
 
-	return ccu_ddn_calc_rate(prate, num, den);
+	return ccu_ddn_calc_rate(prate, num, den, ddn->pre_div);
 }
 
 static int ccu_ddn_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -81,3 +106,13 @@ const struct clk_ops spacemit_ccu_ddn_ops = {
 	.round_rate	= ccu_ddn_round_rate,
 	.set_rate	= ccu_ddn_set_rate,
 };
+
+const struct clk_ops spacemit_ccu_ddn_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.is_enabled	= ccu_gate_is_enabled,
+
+	.recalc_rate	= ccu_ddn_recalc_rate,
+	.round_rate	= ccu_ddn_round_rate,
+	.set_rate	= ccu_ddn_set_rate,
+};
diff --git a/drivers/clk/spacemit/ccu_ddn.h b/drivers/clk/spacemit/ccu_ddn.h
index a52fabe77d62eba16426867a9c13481e72f025c0..e44fb93065ed99041003f235a4f6f42233020298 100644
--- a/drivers/clk/spacemit/ccu_ddn.h
+++ b/drivers/clk/spacemit/ccu_ddn.h
@@ -13,18 +13,22 @@
 #include "ccu_common.h"
 
 struct ccu_ddn {
+	struct ccu_gate_config gate;
 	struct ccu_common common;
 	unsigned int num_mask;
 	unsigned int num_shift;
 	unsigned int den_mask;
 	unsigned int den_shift;
+	unsigned int pre_div;
 };
 
 #define CCU_DDN_INIT(_name, _parent, _flags) \
 	CLK_HW_INIT_HW(#_name, &_parent.common.hw, &spacemit_ccu_ddn_ops, _flags)
+#define CCU_DDN_GATE_INIT(_name, _parent, _flags) \
+	CLK_HW_INIT_HW(#_name, &_parent.common.hw, &spacemit_ccu_ddn_gate_ops, _flags)
 
 #define CCU_DDN_DEFINE(_name, _parent, _reg_ctrl, _num_shift, _num_width,	\
-		       _den_shift, _den_width, _flags)				\
+		       _den_shift, _den_width, _pre_div, _flags)		\
 static struct ccu_ddn _name = {							\
 	.common = {								\
 		.reg_ctrl	= _reg_ctrl,					\
@@ -33,7 +37,23 @@ static struct ccu_ddn _name = {							\
 	.num_mask	= GENMASK(_num_shift + _num_width - 1, _num_shift),	\
 	.num_shift	= _num_shift,						\
 	.den_mask	= GENMASK(_den_shift + _den_width - 1, _den_shift),	\
-	.den_shift	= _den_shift,					\
+	.den_shift	= _den_shift,						\
+	.pre_div	= _pre_div,						\
+}
+
+#define CCU_DDN_GATE_DEFINE(_name, _parent, _reg_ctrl, _num_shift, _num_width,		\
+			    _den_shift, _den_width, _mask_gate, _pre_div, _flags)	\
+static struct ccu_ddn _name = {								\
+	.gate	= CCU_GATE_INIT(_mask_gate),						\
+	.common = {									\
+		.reg_ctrl	= _reg_ctrl,						\
+		.hw.init	= CCU_DDN_GATE_INIT(_name, _parent, _flags),		\
+	},										\
+	.num_mask	= GENMASK(_num_shift + _num_width - 1, _num_shift),		\
+	.num_shift	= _num_shift,							\
+	.den_mask	= GENMASK(_den_shift + _den_width - 1, _den_shift),		\
+	.den_shift	= _den_shift,							\
+	.pre_div	= _pre_div,							\
 }
 
 static inline struct ccu_ddn *hw_to_ccu_ddn(struct clk_hw *hw)
@@ -44,5 +64,6 @@ static inline struct ccu_ddn *hw_to_ccu_ddn(struct clk_hw *hw)
 }
 
 extern const struct clk_ops spacemit_ccu_ddn_ops;
+extern const struct clk_ops spacemit_ccu_ddn_gate_ops;
 
 #endif
diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
index 9b852aa61f78aed5256bfe6fc3b01932d6db6256..183f56ccb92a63ab5f41fe093836bebc73e4162f 100644
--- a/drivers/clk/spacemit/ccu_mix.c
+++ b/drivers/clk/spacemit/ccu_mix.c
@@ -56,7 +56,7 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
 	val = ccu_read(&mix->common, ctrl) >> div->shift;
 	val &= (1 << div->width) - 1;
 
-	return divider_recalc_rate(hw, parent_rate, val, NULL, 0, div->width);
+	return divider_recalc_rate(hw, parent_rate, val, div->table, 0, div->width);
 }
 
 /*
@@ -92,6 +92,28 @@ static int ccu_factor_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static void ccu_mix_try_update_best(unsigned long tmp_rate, unsigned long rate,
+				    unsigned long *best_rate, u32 tmp_val,
+				    u32 *div_val, struct clk_hw *parent,
+				    struct clk_hw **best_parent,
+				    unsigned long *best_parent_rate)
+{
+	if (abs(tmp_rate - rate) < abs(*best_rate - rate)) {
+		*best_rate = tmp_rate;
+
+		if (div_val)
+			*div_val = tmp_val;
+
+		if (!best_parent)
+			return;
+
+		*best_parent = parent;
+		if (best_parent_rate)
+			*best_parent_rate = clk_hw_get_rate(parent);
+	}
+}
+
+
 static unsigned long
 ccu_mix_calc_best_rate(struct clk_hw *hw, unsigned long rate,
 		       struct clk_hw **best_parent,
@@ -113,20 +135,21 @@ ccu_mix_calc_best_rate(struct clk_hw *hw, unsigned long rate,
 
 		parent_rate = clk_hw_get_rate(parent);
 
-		for (int j = 1; j <= div_max; j++) {
-			unsigned long tmp = DIV_ROUND_CLOSEST_ULL(parent_rate, j);
+		if (div->table) {
+			int tmp_val = divider_get_val(rate, parent_rate, div->table, div->width, 0);
+			unsigned long tmp_rate = divider_recalc_rate(hw, parent_rate, tmp_val,
+								     div->table, 0, div->width);
 
-			if (abs(tmp - rate) < abs(best_rate - rate)) {
-				best_rate = tmp;
+			ccu_mix_try_update_best(tmp_rate, rate, &best_rate, tmp_val,
+						div_val, parent, best_parent, best_parent_rate);
+			continue;
+		}
 
-				if (div_val)
-					*div_val = j - 1;
+		for (int j = 1; j <= div_max; j++) {
+			unsigned long tmp = DIV_ROUND_CLOSEST_ULL(parent_rate, j);
 
-				if (best_parent) {
-					*best_parent      = parent;
-					*best_parent_rate = parent_rate;
-				}
-			}
+			ccu_mix_try_update_best(tmp, rate, &best_rate, j - 1,
+						div_val, parent, best_parent, best_parent_rate);
 		}
 	}
 
diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
index 54d40cd39b2752260f57d2a96eb8d3eed8116ecd..e93142f74458c0d91394c86d73f64e1521a17913 100644
--- a/drivers/clk/spacemit/ccu_mix.h
+++ b/drivers/clk/spacemit/ccu_mix.h
@@ -11,16 +11,6 @@
 
 #include "ccu_common.h"
 
-/**
- * struct ccu_gate_config - Gate configuration
- *
- * @mask:	Mask to enable the gate. Some clocks may have more than one bit
- *		set in this field.
- */
-struct ccu_gate_config {
-	u32 mask;
-};
-
 struct ccu_factor_config {
 	u32 div;
 	u32 mul;
@@ -34,6 +24,7 @@ struct ccu_mux_config {
 struct ccu_div_config {
 	u8 shift;
 	u8 width;
+	const struct clk_div_table *table;
 };
 
 struct ccu_mix {
@@ -44,10 +35,11 @@ struct ccu_mix {
 	struct ccu_common common;
 };
 
-#define CCU_GATE_INIT(_mask)		{ .mask = _mask }
 #define CCU_FACTOR_INIT(_div, _mul)	{ .div = _div, .mul = _mul }
 #define CCU_MUX_INIT(_shift, _width)	{ .shift = _shift, .width = _width }
 #define CCU_DIV_INIT(_shift, _width)	{ .shift = _shift, .width = _width }
+#define CCU_DIV_TABLE_INIT(_shift, _width, _table)	\
+					{ .shift = _shift, .width = _width, .table = _table}
 
 #define CCU_PARENT_HW(_parent)		{ .hw = &_parent.common.hw }
 #define CCU_PARENT_NAME(_name)		{ .fw_name = #_name }
@@ -141,6 +133,18 @@ static struct ccu_mix _name = {							\
 	}									\
 }
 
+#define CCU_DIV_TABLE_GATE_DEFINE(_name, _parent, _reg_ctrl, _shift, _width,	\
+				  _table, _mask_gate, _flags)			\
+static struct ccu_mix _name = {							\
+	.gate	= CCU_GATE_INIT(_mask_gate),					\
+	.div	= CCU_DIV_TABLE_INIT(_shift, _width, _table),			\
+	.common = {								\
+		.reg_ctrl	= _reg_ctrl,					\
+		CCU_MIX_INITHW(_name, _parent, spacemit_ccu_div_gate_ops,	\
+			       _flags),						\
+	}									\
+}
+
 #define CCU_MUX_DIV_GATE_DEFINE(_name, _parents, _reg_ctrl, _mshift, _mwidth,	\
 				 _muxshift, _muxwidth, _mask_gate, _flags)	\
 static struct ccu_mix _name = {							\
diff --git a/include/soc/spacemit/k1-syscon.h b/include/soc/spacemit/k1-syscon.h
index c59bd7a38e5b4219121341b9c0d9ffda13a9c3e2..253db8a602fe43a1109e2ba248af11109c7baa22 100644
--- a/include/soc/spacemit/k1-syscon.h
+++ b/include/soc/spacemit/k1-syscon.h
@@ -29,10 +29,11 @@ to_spacemit_ccu_adev(struct auxiliary_device *adev)
 #define APBS_PLL3_SWCR3			0x12c
 
 /* MPMU register offset */
+#define MPMU_FCCR			0x0008
 #define MPMU_POSR			0x0010
-#define  POSR_PLL1_LOCK			BIT(27)
-#define  POSR_PLL2_LOCK			BIT(28)
-#define  POSR_PLL3_LOCK			BIT(29)
+#define POSR_PLL1_LOCK			BIT(27)
+#define POSR_PLL2_LOCK			BIT(28)
+#define POSR_PLL3_LOCK			BIT(29)
 #define MPMU_SUCCR			0x0014
 #define MPMU_ISCCR			0x0044
 #define MPMU_WDTPCR			0x0200

-- 
2.50.1


