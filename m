Return-Path: <linux-kernel+bounces-823635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A613B870E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C51E1C85B75
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4882FC01B;
	Thu, 18 Sep 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cnb2Yqx3"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F342F9D92;
	Thu, 18 Sep 2025 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230193; cv=none; b=nwkQV+y6UOCikhJk1KIHcL7lT+emJQot5duboYP6zLEDGlv0t8egRWYHwxllx/dSWGI+EJJnqM+1AkR69uMUKDeDWph3w03wCVl2W6nHawAHTXsfjUiVqfrhMidkSmyvVvJtrHukbC4K+Fx3IHZmRGN7SNSeuMCTarl3Abr24ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230193; c=relaxed/simple;
	bh=87vLGMW5OjSBWLqBweghZ7yHNC7moDT8cDc12mxnWN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acPvkcWowUUEJ5l/ojmEWzyHQil6uD6kv4Kr25iUizhTcbNEGrGzjihSV7+VXLV4JFxdqEAjB4Nu9IqaQcFDuEApNrT7trqGLKIfpXzRuX8wLy30YuOMmcijMM0ZiFDNeCDrGxkBJeMSgrEDRV3HK0enBVPTBZqWHi9wYjFAJy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cnb2Yqx3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230192; x=1789766192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=87vLGMW5OjSBWLqBweghZ7yHNC7moDT8cDc12mxnWN0=;
  b=cnb2Yqx3u2sypraBfQkdWk9dSWv6zVkzkm5Nby2CWM916UJtZWG9rFp/
   9JGl1SutYOnOPu1mAEU0RAc+pH3BUCQwVaSZIItq7AuDF9w7yLGzZcKTB
   00Q79noDe7Lk5TQdr8rxLr2vE6g/jO4Ok8zku+QgiHRaMfuzxWO1uq92k
   SMYGfSZJ3DPiJJ5Aa+WM1DaaKRiQUWjCo9ir7dxYpdbLkV4vltk/JiYNl
   LwVphDlT4/rmQ2lqdORwz+r5Y+HoA8yltt3ZezSa8P7vyV6ENOewXc1Dl
   EomWqkBV9W72wwkZ3MbRsAoJ1uHIDu9O+xSyDiohIN4gQgYKnf7aIJOd4
   Q==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: mAIXgCm0TBKiGhgmGwBc7g==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071380"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 14:16:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 14:15:51 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 14:15:51 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <varshini.rajendran@microchip.com>
Subject: [PATCH v4 06/31] clk: at91: clk-main: switch to clk parent data
Date: Thu, 18 Sep 2025 14:15:48 -0700
Message-ID: <0f8054488ac3cd658d7a6fc0d5cd4f684ce8355a.1758226719.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758226719.git.Ryan.Wanner@microchip.com>
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Use struct clk_parent_data instead of parent_hw for the main clock
to less usage of __clk_get_hw() in SoC specific clock drivers and simpler
conversion of existing SoC specific clock drivers from parent_names to
modern clk_parent_data structures. This will lead in the end at removing
__clk_get_hw() in SoC specific drivers
(that will be solved by subsequent commits).

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
[ryan.wanner@microchip: Add SAMA7D65 and SAM9X75 SoCs to use parent_data.]
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/clk-main.c | 16 ++++++++--------
 drivers/clk/at91/pmc.h      |  4 ++--
 drivers/clk/at91/sam9x7.c   | 14 +++++++-------
 drivers/clk/at91/sama7d65.c | 14 +++++++-------
 drivers/clk/at91/sama7g5.c  |  8 ++++----
 5 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 9b462becc693..514c5690253f 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -402,7 +402,7 @@ struct clk_hw * __init
 at91_clk_register_rm9200_main(struct regmap *regmap,
 			      const char *name,
 			      const char *parent_name,
-			      struct clk_hw *parent_hw)
+			      struct clk_parent_data *parent_data)
 {
 	struct clk_rm9200_main *clkmain;
 	struct clk_init_data init = {};
@@ -412,7 +412,7 @@ at91_clk_register_rm9200_main(struct regmap *regmap,
 	if (!name)
 		return ERR_PTR(-EINVAL);
 
-	if (!(parent_name || parent_hw))
+	if (!(parent_name || parent_data))
 		return ERR_PTR(-EINVAL);
 
 	clkmain = kzalloc(sizeof(*clkmain), GFP_KERNEL);
@@ -421,8 +421,8 @@ at91_clk_register_rm9200_main(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &rm9200_main_ops;
-	if (parent_hw)
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
 	else
 		init.parent_names = &parent_name;
 	init.num_parents = 1;
@@ -552,7 +552,7 @@ struct clk_hw * __init
 at91_clk_register_sam9x5_main(struct regmap *regmap,
 			      const char *name,
 			      const char **parent_names,
-			      struct clk_hw **parent_hws,
+			      struct clk_parent_data *parent_data,
 			      int num_parents)
 {
 	struct clk_sam9x5_main *clkmain;
@@ -564,7 +564,7 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
 	if (!name)
 		return ERR_PTR(-EINVAL);
 
-	if (!(parent_hws || parent_names) || !num_parents)
+	if (!(parent_data || parent_names) || !num_parents)
 		return ERR_PTR(-EINVAL);
 
 	clkmain = kzalloc(sizeof(*clkmain), GFP_KERNEL);
@@ -573,8 +573,8 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &sam9x5_main_ops;
-	if (parent_hws)
-		init.parent_hws = (const struct clk_hw **)parent_hws;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
 	else
 		init.parent_names = parent_names;
 	init.num_parents = num_parents;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 9b0c641e747b..13d125793216 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -198,11 +198,11 @@ struct clk_hw * __init
 at91_clk_register_rm9200_main(struct regmap *regmap,
 			      const char *name,
 			      const char *parent_name,
-			      struct clk_hw *parent_hw);
+			      struct clk_parent_data *parent_data);
 struct clk_hw * __init
 at91_clk_register_sam9x5_main(struct regmap *regmap, const char *name,
 			      const char **parent_names,
-			      struct clk_hw **parent_hws, int num_parents);
+			      struct clk_parent_data *parent_data, int num_parents);
 
 struct clk_hw * __init
 at91_clk_register_master_pres(struct regmap *regmap, const char *name,
diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
index ff9dbaac5f04..f00045d4f425 100644
--- a/drivers/clk/at91/sam9x7.c
+++ b/drivers/clk/at91/sam9x7.c
@@ -752,7 +752,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 	struct regmap *regmap;
 	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
 	struct clk_hw *td_slck_hw, *md_slck_hw, *usbck_hw;
-	static struct clk_parent_data parent_data;
+	struct clk_parent_data parent_data[2];
 	struct clk_hw *parent_hws[9];
 	int i, j;
 
@@ -790,9 +790,9 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
-	parent_hws[0] = main_rc_hw;
-	parent_hws[1] = main_osc_hw;
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
+	parent_data[0] = AT91_CLK_PD_HW(main_rc_hw);
+	parent_data[1] = AT91_CLK_PD_HW(main_osc_hw);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_data, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
@@ -809,11 +809,11 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 			case PLL_TYPE_FRAC:
 				switch (sam9x7_plls[i][j].p) {
 				case SAM9X7_PLL_PARENT_MAINCK:
-					parent_data = AT91_CLK_PD_NAME("mainck");
+					parent_data[0] = AT91_CLK_PD_NAME("mainck");
 					hw = sam9x7_pmc->chws[PMC_MAIN];
 					break;
 				case SAM9X7_PLL_PARENT_MAIN_XTAL:
-					parent_data = AT91_CLK_PD_NAME(main_xtal_name);
+					parent_data[0] = AT91_CLK_PD_NAME(main_xtal_name);
 					hw = main_xtal_hw;
 					break;
 				default:
@@ -828,7 +828,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 				hw = sam9x60_clk_register_frac_pll(regmap,
 								   &pmc_pll_lock,
 								   sam9x7_plls[i][j].n,
-								   &parent_data, parent_rate, i,
+								   parent_data, parent_rate, i,
 								   sam9x7_plls[i][j].c,
 								   sam9x7_plls[i][j].l,
 								   sam9x7_plls[i][j].f);
diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
index 6367fa7efd06..b12d796cbea4 100644
--- a/drivers/clk/at91/sama7d65.c
+++ b/drivers/clk/at91/sama7d65.c
@@ -1101,7 +1101,7 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 	struct regmap *regmap;
 	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
 	struct clk_hw *td_slck_hw, *md_slck_hw;
-	static struct clk_parent_data parent_data;
+	struct clk_parent_data parent_data[2];
 	struct clk_hw *parent_hws[10];
 	bool bypass;
 	int i, j;
@@ -1143,9 +1143,9 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
-	parent_hws[0] = main_rc_hw;
-	parent_hws[1] = main_osc_hw;
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
+	parent_data[0] = AT91_CLK_PD_HW(main_rc_hw);
+	parent_data[1] = AT91_CLK_PD_HW(main_osc_hw);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_data, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
@@ -1162,11 +1162,11 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 			case PLL_TYPE_FRAC:
 				switch (sama7d65_plls[i][j].p) {
 				case SAMA7D65_PLL_PARENT_MAINCK:
-					parent_data = AT91_CLK_PD_NAME("mainck");
+					parent_data[0] = AT91_CLK_PD_NAME("mainck");
 					hw = sama7d65_pmc->chws[PMC_MAIN];
 					break;
 				case SAMA7D65_PLL_PARENT_MAIN_XTAL:
-					parent_data = AT91_CLK_PD_NAME(main_xtal_name);
+					parent_data[0] = AT91_CLK_PD_NAME(main_xtal_name);
 					hw = main_xtal_hw;
 					break;
 				default:
@@ -1179,7 +1179,7 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 
 				hw = sam9x60_clk_register_frac_pll(regmap,
 					&pmc_pll_lock, sama7d65_plls[i][j].n,
-					&parent_data, parent_rate, i,
+					parent_data, parent_rate, i,
 					sama7d65_plls[i][j].c,
 					sama7d65_plls[i][j].l,
 					sama7d65_plls[i][j].f);
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 091845ca251c..b1b0e9e67228 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1020,9 +1020,9 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
-	parent_hws[0] = main_rc_hw;
-	parent_hws[1] = main_osc_hw;
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
+	parent_data[0] = AT91_CLK_PD_HW(main_rc_hw);
+	parent_data[1] = AT91_CLK_PD_HW(main_osc_hw);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_data, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
@@ -1057,7 +1057,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 				hw = sam9x60_clk_register_frac_pll(regmap,
 					&pmc_pll_lock, sama7g5_plls[i][j].n,
-					&parent_data, parent_rate, i,
+					parent_data, parent_rate, i,
 					sama7g5_plls[i][j].c,
 					sama7g5_plls[i][j].l,
 					sama7g5_plls[i][j].f);
-- 
2.43.0


