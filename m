Return-Path: <linux-kernel+bounces-823652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 727F2B87150
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276D05821C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0F83218B1;
	Thu, 18 Sep 2025 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lOGosYGD"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4C831E10B;
	Thu, 18 Sep 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230203; cv=none; b=jTEuta9BAO0wCzgoX1FGJfi0DlrHJclomNMFHpuiYkDhotXdDhJKC9BCW8at/TB5AKiGobL0l/iLRHXu4ZB8Y4O4r7hm6Wr45m/4GgjC/4NF5HHnLjP9/PwmyEb6fW7Ay+stLRJDMhyqtbO2dXp6a4ZBoYrdCLnNgJVliRpVg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230203; c=relaxed/simple;
	bh=QB8JyTFY0ZzZF+uXc9lQ99fQbGsgSmcvnNL5f+ljo/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ga0hrM45Is/7dfhNS2E5e/Wd46gqxemKmqJkqlXnFsGsJ95Ba6Tn+GMEvMihyIBVVKxCSTIP+/y+DsPPP363rfmobGU9oa/J8GB0um4dr/BHOIghAKYWIzZVPKc+VOn1YQKbsxLX+Bq1+ZobfrUsRTR5L9YxU1Aj+mDMb+i7zeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lOGosYGD; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230202; x=1789766202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QB8JyTFY0ZzZF+uXc9lQ99fQbGsgSmcvnNL5f+ljo/E=;
  b=lOGosYGDNL+7Xa284SBFTaIuZIcMmDYFLZgETTw+n+40qJYY6s7OCNwV
   xqYdYDpQ3VmfSA7uxu6FiHIQRtCvWKniED0pjRe65Lt1FWMFBqeyKtFCb
   40nX2l0HtudDmnk2xj74P4r1pfibOErhKs1weaToqBE0dVMoDthOb/5DV
   Bj/81pZiTZMmG4pR/hAQ3Dg65VZ1d+DC+fgT66QPY5ovZfzcagJlgv2Nt
   E6P6Tvx7AyMTlSo5NgmCv80oG9uObb4zpBIg/tP3lgt6TpGM5DId0NBfa
   Jbxuxkk28Nu4v24CJn75PmfTLqg0X4vNXwgF/oGeDg+V5ykL7/WWttxn5
   w==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: slar8cZ1SXexvpo0+Uj5Xw==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071398"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 14:16:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 14:15:54 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 14:15:54 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <varshini.rajendran@microchip.com>
Subject: [PATCH v4 23/31] clk: at91: sama5d2: switch to parent_hw and parent_data
Date: Thu, 18 Sep 2025 14:16:05 -0700
Message-ID: <a2f7cce73739fc795d17710a3bb017158c090735.1758226719.git.Ryan.Wanner@microchip.com>
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

Switch SAMA5D2 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
[ryan.wanner@microchip.com: Adjust commit message.]
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/sama5d2.c | 157 ++++++++++++++++++++-----------------
 1 file changed, 85 insertions(+), 72 deletions(-)

diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index f5d6c7a96cf2..231cec1f80e1 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -37,9 +37,9 @@ static const struct clk_pcr_layout sama5d2_pcr_layout = {
 	.pid_mask = GENMASK(6, 0),
 };
 
-static const struct {
+static struct {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	unsigned long flags;
 	u8 id;
 } sama5d2_systemck[] = {
@@ -47,14 +47,14 @@ static const struct {
 	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
 	 * to keep it enabled in case there is no Linux consumer for it.
 	 */
-	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
-	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
-	{ .n = "uhpck", .p = "usbck",        .id = 6 },
-	{ .n = "udpck", .p = "usbck",        .id = 7 },
-	{ .n = "pck0",  .p = "prog0",        .id = 8 },
-	{ .n = "pck1",  .p = "prog1",        .id = 9 },
-	{ .n = "pck2",  .p = "prog2",        .id = 10 },
-	{ .n = "iscck", .p = "masterck_div", .id = 18 },
+	{ .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
+	{ .n = "lcdck", .id = 3 },
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "udpck", .id = 7 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
+	{ .n = "pck2",  .id = 10 },
+	{ .n = "iscck", .id = 18 },
 };
 
 static const struct {
@@ -164,12 +164,12 @@ static const struct clk_programmable_layout sama5d2_programmable_layout = {
 
 static void __init sama5d2_pmc_setup(struct device_node *np)
 {
+	struct clk_hw *hw, *audio_fracck_hw, *usbck_hw, *main_rc_hw, *main_osc_hw;
+	const char *slow_clk_name, *main_xtal_name;
 	struct clk_range range = CLK_RANGE(0, 0);
-	const char *slck_name, *mainxtal_name;
-	struct pmc_data *sama5d2_pmc;
-	const char *parent_names[6];
+	struct clk_parent_data parent_data[6];
 	struct regmap *regmap, *regmap_sfr;
-	struct clk_hw *hw;
+	struct pmc_data *sama5d2_pmc;
 	int i;
 	bool bypass;
 
@@ -177,12 +177,12 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (i < 0)
 		return;
 
-	slck_name = of_clk_get_parent_name(np, i);
+	slow_clk_name = of_clk_get_parent_name(np, i);
 
 	i = of_property_match_string(np, "clock-names", "main_xtal");
 	if (i < 0)
 		return;
-	mainxtal_name = of_clk_get_parent_name(np, i);
+	main_xtal_name = of_clk_get_parent_name(np, i);
 
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
@@ -195,51 +195,51 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (!sama5d2_pmc)
 		return;
 
-	hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
-					   100000000);
-	if (IS_ERR(hw))
+	main_rc_hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
+						   100000000);
+	if (IS_ERR(main_rc_hw))
 		goto err_free;
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
-					bypass);
-	if (IS_ERR(hw))
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
+						 &AT91_CLK_PD_NAME(main_xtal_name), bypass);
+	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
-	parent_names[0] = "main_rc_osc";
-	parent_names[1] = "main_osc";
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, NULL, 2);
+	parent_data[0] = AT91_CLK_PD_HW(main_rc_hw);
+	parent_data[1] = AT91_CLK_PD_HW(main_osc_hw);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_data, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d2_pmc->chws[PMC_MAIN] = hw;
-
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL,
+				   &AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_MAIN]), 0,
 				   &sama5d3_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", "pllack", NULL);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, &AT91_CLK_PD_HW(hw));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d2_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_audio_pll_frac(regmap, "audiopll_fracck",
-					      "mainck", NULL);
-	if (IS_ERR(hw))
+	audio_fracck_hw = at91_clk_register_audio_pll_frac(regmap, "audiopll_fracck", NULL,
+							   &AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_MAIN]));
+	if (IS_ERR(audio_fracck_hw))
 		goto err_free;
 
-	hw = at91_clk_register_audio_pll_pad(regmap, "audiopll_padck",
-					     "audiopll_fracck", NULL);
+	hw = at91_clk_register_audio_pll_pad(regmap, "audiopll_padck", NULL,
+					     &AT91_CLK_PD_HW(audio_fracck_hw));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d2_pmc->chws[PMC_AUDIOPINCK] = hw;
 
-	hw = at91_clk_register_audio_pll_pmc(regmap, "audiopll_pmcck",
-					     "audiopll_fracck", NULL);
+	hw = at91_clk_register_audio_pll_pmc(regmap, "audiopll_pmcck", NULL,
+					     &AT91_CLK_PD_HW(audio_fracck_hw));
 	if (IS_ERR(hw))
 		goto err_free;
 
@@ -249,25 +249,26 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap_sfr))
 		regmap_sfr = NULL;
 
-	hw = at91_clk_register_utmi(regmap, regmap_sfr, "utmick", "mainck", NULL);
+	hw = at91_clk_register_utmi(regmap, regmap_sfr, "utmick", NULL,
+				    &AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_MAIN]));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d2_pmc->chws[PMC_UTMI] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
+	parent_data[0] = AT91_CLK_PD_NAME(slow_clk_name);
+	parent_data[1] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_UTMI]);
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names, NULL,
+					   NULL, parent_data,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL,
+	hw = at91_clk_register_master_div(regmap, "masterck_div", NULL,
+					  &AT91_CLK_PD_HW(hw),
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
@@ -276,31 +277,32 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 	sama5d2_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91_clk_register_h32mx(regmap, "h32mxck", "masterck_div", NULL);
+	hw = at91_clk_register_h32mx(regmap, "h32mxck", NULL,
+				     &AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_MCK]));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d2_pmc->chws[PMC_MCK2] = hw;
 
-	parent_names[0] = "plladivck";
-	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
-	if (IS_ERR(hw))
+	parent_data[0] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_PLLACK]);
+	parent_data[1] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_UTMI]);
+	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", NULL, parent_data, 2);
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
-	parent_names[4] = "masterck_div";
-	parent_names[5] = "audiopll_pmcck";
+	parent_data[0] = AT91_CLK_PD_NAME(slow_clk_name);
+	parent_data[1] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_UTMI]);
+	parent_data[4] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_MCK]);
+	parent_data[5] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_AUDIOPLLCK]);
 	for (i = 0; i < 3; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 6, i,
+						    NULL, parent_data, 6, i,
 						    &sama5d2_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -309,9 +311,18 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		sama5d2_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	sama5d2_systemck[0].parent_hw = sama5d2_pmc->chws[PMC_MCK];
+	sama5d2_systemck[1].parent_hw = sama5d2_pmc->chws[PMC_MCK];
+	sama5d2_systemck[2].parent_hw = usbck_hw;
+	sama5d2_systemck[3].parent_hw = usbck_hw;
+	sama5d2_systemck[4].parent_hw = sama5d2_pmc->pchws[0];
+	sama5d2_systemck[5].parent_hw = sama5d2_pmc->pchws[1];
+	sama5d2_systemck[6].parent_hw = sama5d2_pmc->pchws[2];
+	sama5d2_systemck[7].parent_hw = sama5d2_pmc->chws[PMC_MCK];
 	for (i = 0; i < ARRAY_SIZE(sama5d2_systemck); i++) {
-		hw = at91_clk_register_system(regmap, sama5d2_systemck[i].n,
-					      sama5d2_systemck[i].p, NULL,
+		hw = at91_clk_register_system(regmap, sama5d2_systemck[i].n, NULL,
+					      &AT91_CLK_PD_HW(sama5d2_systemck[i].parent_hw),
 					      sama5d2_systemck[i].id,
 					      sama5d2_systemck[i].flags);
 		if (IS_ERR(hw))
@@ -324,7 +335,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d2_pcr_layout,
 							 sama5d2_periphck[i].n,
-							 "masterck_div", NULL,
+							 NULL,
+							 &AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_MCK]),
 							 sama5d2_periphck[i].id,
 							 &range, INT_MIN,
 							 sama5d2_periphck[i].flags);
@@ -338,7 +350,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d2_pcr_layout,
 							 sama5d2_periph32ck[i].n,
-							 "h32mxck", NULL,
+							 NULL,
+							 &AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_MCK2]),
 							 sama5d2_periph32ck[i].id,
 							 &sama5d2_periph32ck[i].r,
 							 INT_MIN, 0);
@@ -348,17 +361,17 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		sama5d2_pmc->phws[sama5d2_periph32ck[i].id] = hw;
 	}
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
-	parent_names[4] = "masterck_div";
-	parent_names[5] = "audiopll_pmcck";
+	parent_data[0] = AT91_CLK_PD_NAME(slow_clk_name);
+	parent_data[1] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_UTMI]);
+	parent_data[4] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_MCK]);
+	parent_data[5] = AT91_CLK_PD_HW(sama5d2_pmc->chws[PMC_AUDIOPLLCK]);
 	for (i = 0; i < ARRAY_SIZE(sama5d2_gck); i++) {
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &sama5d2_pcr_layout,
 						 sama5d2_gck[i].n,
-						 parent_names, NULL, NULL, 6,
+						 NULL, parent_data, NULL, 6,
 						 sama5d2_gck[i].id,
 						 &sama5d2_gck[i].r,
 						 sama5d2_gck[i].chg_pid);
@@ -369,19 +382,19 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	}
 
 	if (regmap_sfr) {
-		parent_names[0] = "i2s0_clk";
-		parent_names[1] = "i2s0_gclk";
+		parent_data[0] = AT91_CLK_PD_HW(sama5d2_pmc->phws[54]); /* i2s0_clk */
+		parent_data[1] = AT91_CLK_PD_HW(sama5d2_pmc->ghws[54]); /* i2s0_gclk */
 		hw = at91_clk_i2s_mux_register(regmap_sfr, "i2s0_muxclk",
-					       parent_names, NULL, 2, 0);
+					       NULL, parent_data, 2, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
 		sama5d2_pmc->chws[PMC_I2S0_MUX] = hw;
 
-		parent_names[0] = "i2s1_clk";
-		parent_names[1] = "i2s1_gclk";
+		parent_data[0] = AT91_CLK_PD_HW(sama5d2_pmc->phws[55]); /* i2s1_clk */
+		parent_data[1] = AT91_CLK_PD_HW(sama5d2_pmc->ghws[55]); /* i2s1_gclk */
 		hw = at91_clk_i2s_mux_register(regmap_sfr, "i2s1_muxclk",
-					       parent_names, NULL, 2, 1);
+					       NULL, parent_data, 2, 1);
 		if (IS_ERR(hw))
 			goto err_free;
 
-- 
2.43.0


