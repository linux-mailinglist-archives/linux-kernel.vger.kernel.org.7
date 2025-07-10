Return-Path: <linux-kernel+bounces-726376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36534B00C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0075C237B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6752FF468;
	Thu, 10 Jul 2025 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TL5FyMna"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E03E2FCFE4;
	Thu, 10 Jul 2025 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178072; cv=none; b=e+J57KuaC8GY/oUII9cQXULZ/Ap86yzRb0+wqgwiiPHkocJvNhS96cBg9GhATKzvyre9E3BQfO3M9DSlyFF9QXMFeRRMlIvkRuM7HHpSIKQIJ4v5977er52oi0B7GUk1bQS9/chgspzeRb/BjpXurd2UfBcx5fODwqv63Em98Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178072; c=relaxed/simple;
	bh=9to6H0DM8tW/QbiHAgqZuBE6jDPb0ZjAgtNWRvt5vNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAccFwI4COy2YS4usr4x1OgAbbhwylhuSGHDFzjmDWaXR47HW8EP3EHBela0GU/bP95RlaskfqQBLvNWGt5kwfPbhG1r9Zz7PnQNg/X/sk35YhLrjCEw0fG7ePExEL+lDc844lrfKtfwQfcd0+cxqnEI4kayOXdNdOmSUL8V1y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TL5FyMna; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752178071; x=1783714071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9to6H0DM8tW/QbiHAgqZuBE6jDPb0ZjAgtNWRvt5vNU=;
  b=TL5FyMnaFj4bZRPsasxQcxBu45zlOrxAHuLVLC2SsOCPR/owtqeiUNH4
   TD0s5FNgCQ9uWgYDTp/K//HFU15RLqVg1sHb+IluzxjWc5otAS+zOO+27
   ok9jG1/42t58VZghx1oDxFvEojmRC7OCbvY0ntWA0X2KABy0HyE4p+EST
   i9Dl/xg3xk0yf7H9lxLLSeUEicyxJo8MMTYPYs9gLBMD7Bxpgm4o5XYnV
   tYMK4zzICQBKYGwdPG6pxbfT+WQbzTx6wkYfVbNK3IjHfmckKJRbUoJ9p
   NWWpmSHlMsSO+bnpB+La6yi1+bM8O0Lmr5EX57m6hjwomK17Tl0Zuxw5q
   A==;
X-CSE-ConnectionGUID: qOQSLemoQZOGUxBCHa7nXg==
X-CSE-MsgGUID: 7icMaR8gRnqQxp8WYMkKfQ==
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="275215680"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 13:07:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 10 Jul 2025 13:07:33 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 10 Jul 2025 13:07:33 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <varshini.rajendran@microchip.com>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robh@kernel.org>
Subject: [PATCH v3 22/32] clk: at91: sam9x60: switch to parent_hw and parent_data
Date: Thu, 10 Jul 2025 13:07:15 -0700
Message-ID: <7f90312300d24617c51f63aa0a1c7bbb4a0212cc.1752176711.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752176711.git.Ryan.Wanner@microchip.com>
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Switch SAM9X60 clocks to use modern parent_hw and parent_data.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/sam9x60.c | 109 +++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 58 deletions(-)

diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index eb38da77d69a..b2e86e600a9f 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -79,9 +79,9 @@ static const struct clk_pcr_layout sam9x60_pcr_layout = {
 	.pid_mask = GENMASK(6, 0),
 };
 
-static const struct {
+static struct {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	unsigned long flags;
 	u8 id;
 } sam9x60_systemck[] = {
@@ -89,11 +89,11 @@ static const struct {
 	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
 	 * to keep it enabled in case there is no Linux consumer for it.
 	 */
-	{ .n = "ddrck",  .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
-	{ .n = "uhpck",  .p = "usbck",    .id = 6 },
-	{ .n = "pck0",   .p = "prog0",    .id = 8 },
-	{ .n = "pck1",   .p = "prog1",    .id = 9 },
-	{ .n = "qspick", .p = "masterck_div", .id = 19 },
+	{ .n = "ddrck",  .id = 2, .flags = CLK_IS_CRITICAL },
+	{ .n = "uhpck",  .id = 6 },
+	{ .n = "pck0",   .id = 8 },
+	{ .n = "pck1",   .id = 9 },
+	{ .n = "qspick", .id = 19 },
 };
 
 static const struct {
@@ -184,32 +184,17 @@ static const struct {
 
 static void __init sam9x60_pmc_setup(struct device_node *np)
 {
+	const char *td_slck_name = "td_slck", *md_slck_name = "md_slck";
+	u8 td_slck_index = 0, md_slck_index = 1, main_xtal_index = 2;
+	struct clk_hw *hw, *main_rc_hw, *main_osc_hw;
+	const char *main_xtal_name = "main_xtal";
 	struct clk_range range = CLK_RANGE(0, 0);
-	const char *td_slck_name, *md_slck_name, *mainxtal_name;
+	struct clk_parent_data parent_data[6];
 	struct pmc_data *sam9x60_pmc;
-	const char *parent_names[6];
-	struct clk_hw *main_osc_hw;
+	struct clk_hw *usbck_hw;
 	struct regmap *regmap;
-	struct clk_hw *hw;
 	int i;
 
-	i = of_property_match_string(np, "clock-names", "td_slck");
-	if (i < 0)
-		return;
-
-	td_slck_name = of_clk_get_parent_name(np, i);
-
-	i = of_property_match_string(np, "clock-names", "md_slck");
-	if (i < 0)
-		return;
-
-	md_slck_name = of_clk_get_parent_name(np, i);
-
-	i = of_property_match_string(np, "clock-names", "main_xtal");
-	if (i < 0)
-		return;
-	mainxtal_name = of_clk_get_parent_name(np, i);
-
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		return;
@@ -221,19 +206,20 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	if (!sam9x60_pmc)
 		return;
 
-	hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
-					   50000000);
-	if (IS_ERR(hw))
+	main_rc_hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
+						   50000000);
+	if (IS_ERR(main_rc_hw))
 		goto err_free;
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL, 0);
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
+						 &AT91_CLK_PD_NAME(main_xtal_name, main_xtal_index),
+						 0);
 	if (IS_ERR(hw))
 		goto err_free;
-	main_osc_hw = hw;
 
-	parent_names[0] = "main_rc_osc";
-	parent_names[1] = "main_osc";
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, NULL, 2);
+	parent_data[0] = AT91_CLK_PD_HW(main_rc_hw);
+	parent_data[1] = AT91_CLK_PD_HW(main_osc_hw);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_data, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
@@ -254,7 +240,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 		goto err_free;
 
 	hw = sam9x60_clk_register_div_pll(regmap, &pmc_pll_lock, "pllack_divck",
-					  "pllack_fracck", NULL, 0, &plla_characteristics,
+					  NULL, hw, 0, &plla_characteristics,
 					  &pll_div_layout,
 					   /*
 					    * This feeds CPU. It should not
@@ -275,7 +261,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 		goto err_free;
 
 	hw = sam9x60_clk_register_div_pll(regmap, &pmc_pll_lock, "upllck_divck",
-					  "upllck_fracck", NULL, 1, &upll_characteristics,
+					  NULL, hw, 1, &upll_characteristics,
 					  &pll_div_layout,
 					  CLK_SET_RATE_GATE |
 					  CLK_SET_PARENT_GATE |
@@ -285,17 +271,17 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 
 	sam9x60_pmc->chws[PMC_UTMI] = hw;
 
-	parent_names[0] = md_slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "pllack_divck";
+	parent_data[0] = AT91_CLK_PD_NAME(md_slck_name, md_slck_index);
+	parent_data[1] = AT91_CLK_PD_HW(sam9x60_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(sam9x60_pmc->chws[PMC_PLLACK]);
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 3,
-					   parent_names, NULL, &sam9x60_master_layout,
+					   NULL, parent_data, &sam9x60_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL, &sam9x60_master_layout,
+					  NULL, &AT91_CLK_PD_HW(hw), &sam9x60_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
@@ -303,26 +289,26 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 
 	sam9x60_pmc->chws[PMC_MCK] = hw;
 
-	parent_names[0] = "pllack_divck";
-	parent_names[1] = "upllck_divck";
-	parent_names[2] = "main_osc";
-	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, NULL, 3);
-	if (IS_ERR(hw))
+	parent_data[0] = AT91_CLK_PD_HW(sam9x60_pmc->chws[PMC_PLLACK]);
+	parent_data[1] = AT91_CLK_PD_HW(sam9x60_pmc->chws[PMC_UTMI]);
+	parent_data[2] = AT91_CLK_PD_HW(main_osc_hw);
+	usbck_hw = sam9x60_clk_register_usb(regmap, "usbck", NULL, parent_data, 3);
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	parent_names[0] = md_slck_name;
-	parent_names[1] = td_slck_name;
-	parent_names[2] = "mainck";
-	parent_names[3] = "masterck_div";
-	parent_names[4] = "pllack_divck";
-	parent_names[5] = "upllck_divck";
+	parent_data[0] = AT91_CLK_PD_NAME(md_slck_name, md_slck_index);
+	parent_data[1] = AT91_CLK_PD_NAME(td_slck_name, td_slck_index);
+	parent_data[2] = AT91_CLK_PD_HW(sam9x60_pmc->chws[PMC_MAIN]);
+	parent_data[3] = AT91_CLK_PD_HW(sam9x60_pmc->chws[PMC_MCK]);
+	parent_data[4] = AT91_CLK_PD_HW(sam9x60_pmc->chws[PMC_PLLACK]);
+	parent_data[5] = AT91_CLK_PD_HW(sam9x60_pmc->chws[PMC_UTMI]);
 	for (i = 0; i < 2; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 6, i,
+						    NULL, parent_data, 6, i,
 						    &sam9x60_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -331,9 +317,15 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 		sam9x60_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	sam9x60_systemck[0].parent_hw = sam9x60_pmc->chws[PMC_MCK];
+	sam9x60_systemck[1].parent_hw = usbck_hw;
+	sam9x60_systemck[2].parent_hw = sam9x60_pmc->pchws[0];
+	sam9x60_systemck[3].parent_hw = sam9x60_pmc->pchws[1];
+	sam9x60_systemck[4].parent_hw = sam9x60_pmc->chws[PMC_MCK];
 	for (i = 0; i < ARRAY_SIZE(sam9x60_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sam9x60_systemck[i].n,
-					      sam9x60_systemck[i].p, NULL,
+					      NULL, &AT91_CLK_PD_HW(sam9x60_systemck[i].parent_hw),
 					      sam9x60_systemck[i].id,
 					      sam9x60_systemck[i].flags);
 		if (IS_ERR(hw))
@@ -346,7 +338,8 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sam9x60_pcr_layout,
 							 sam9x60_periphck[i].n,
-							 "masterck_div", NULL,
+							 NULL,
+							 &AT91_CLK_PD_HW(sam9x60_pmc->chws[PMC_MCK]),
 							 sam9x60_periphck[i].id,
 							 &range, INT_MIN,
 							 sam9x60_periphck[i].flags);
@@ -360,7 +353,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &sam9x60_pcr_layout,
 						 sam9x60_gck[i].n,
-						 parent_names, NULL, NULL, 6,
+						 NULL, parent_data, NULL, 6,
 						 sam9x60_gck[i].id,
 						 &sam9x60_gck[i].r, INT_MIN);
 		if (IS_ERR(hw))
-- 
2.43.0


