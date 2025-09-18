Return-Path: <linux-kernel+bounces-823653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AECB8717D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA56B61200
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379963218B5;
	Thu, 18 Sep 2025 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="k8bC2Y7K"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7480331E89C;
	Thu, 18 Sep 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230203; cv=none; b=kZFG9NiJZ1nrneQWlrDAqsi0MqEi1xDOF4/q4aipqNI/8EUu/dRjrQdeNfSNBT/Vw4b4VA65C/Tl7LqZo+z/twiB1O0S6Sul3t0xy40HVcuqkgHl3y+381sXv9UmmPEViem0Spa08cZ/MboXC0olhNuykd9+jmfubAOdHa2RK1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230203; c=relaxed/simple;
	bh=lvaurE692FNh174h6e4E8YiXCoEBA9AEZ6HXWtw9NGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obnTPewmB/1thL31GBkTpTeL6lbfdo6rrRm29OixY9IbJ+9iM9fitdbupFefXPm0eCcsMdDP4U9SZDjzCK7RBmEE97HBKk0xeJkvWI6WiFHKUsMg6eF0m1etrcu5jy2ot4y8/UqhtpKwJ8Ol64kxfgpszBgzHOOie5BT0fI9qu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=k8bC2Y7K; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230202; x=1789766202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lvaurE692FNh174h6e4E8YiXCoEBA9AEZ6HXWtw9NGg=;
  b=k8bC2Y7KyWH+1uV/yvBSMplTeZm4hEGzrQfKDU2+KScI1HNr3/TFzkmr
   a1ClXqiVb+74duDozsQtRWQ9Znn8DDe+NIGzSkwmuH5MRrnyrEmaNlsFD
   oXriwomaUqpXyHcQ3SNN7KAp+cTGXhhuDK0lxnk43zxmUwk1a1S+YahY7
   esgmMhplkf3ofNLW76xsIzNqRwBDzf+05MqdCA4ycQ3rA1id3jGR+sEnH
   IQ4mZLi9TIfzoqvHCgPgXbjH0Il7x3Wu+fCGRIFUvQmgF39MSAKjiP8A2
   cY4kUnp5f3ZoG2d+AvgzBsEi9wM6DRVSJhpj4A8E/z4Lr2rthOi31OQCb
   Q==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: +gF/1ptHRAWKgnpTdYHxiQ==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071399"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 14:16:28 -0700
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
Subject: [PATCH v4 24/31] clk: at91: sama5d3: switch to parent_hw and parent_data
Date: Thu, 18 Sep 2025 14:16:06 -0700
Message-ID: <35853aa4f7d06a7aeec45dc553c7286e74cb53c0.1758226719.git.Ryan.Wanner@microchip.com>
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

Switch SAMA5D3 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/sama5d3.c | 112 +++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 49 deletions(-)

diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 8326bb6a291c..65b0e776dc13 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -37,9 +37,9 @@ static const struct clk_pcr_layout sama5d3_pcr_layout = {
 	.div_mask = GENMASK(17, 16),
 };
 
-static const struct {
+static struct {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	unsigned long flags;
 	u8 id;
 } sama5d3_systemck[] = {
@@ -47,14 +47,14 @@ static const struct {
 	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
 	 * to keep it enabled in case there is no Linux consumer for it.
 	 */
-	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
-	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
-	{ .n = "smdck", .p = "smdclk",       .id = 4 },
-	{ .n = "uhpck", .p = "usbck",        .id = 6 },
-	{ .n = "udpck", .p = "usbck",        .id = 7 },
-	{ .n = "pck0",  .p = "prog0",        .id = 8 },
-	{ .n = "pck1",  .p = "prog1",        .id = 9 },
-	{ .n = "pck2",  .p = "prog2",        .id = 10 },
+	{ .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
+	{ .n = "lcdck", .id = 3 },
+	{ .n = "smdck", .id = 4 },
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "udpck", .id = 7 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
+	{ .n = "pck2",  .id = 10 },
 };
 
 static const struct {
@@ -114,11 +114,12 @@ static const struct {
 
 static void __init sama5d3_pmc_setup(struct device_node *np)
 {
-	const char *slck_name, *mainxtal_name;
+	struct clk_hw *main_rc_hw, *main_osc_hw, *mainck_hw;
+	const char *slow_clk_name, *main_xtal_name;
+	struct clk_hw *smdck_hw, *usbck_hw, *hw;
+	struct clk_parent_data parent_data[5];
 	struct pmc_data *sama5d3_pmc;
-	const char *parent_names[5];
 	struct regmap *regmap;
-	struct clk_hw *hw;
 	int i;
 	bool bypass;
 
@@ -126,12 +127,12 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
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
@@ -143,54 +144,55 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 	if (!sama5d3_pmc)
 		return;
 
-	hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
-					   50000000);
-	if (IS_ERR(hw))
+	main_rc_hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
+						   50000000);
+	if (IS_ERR(main_rc_hw))
 		goto err_free;
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
-					bypass);
-	if (IS_ERR(hw))
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
+						 &AT91_CLK_PD_NAME(main_xtal_name),
+						 bypass);
+	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
-	parent_names[0] = "main_rc_osc";
-	parent_names[1] = "main_osc";
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, NULL, 2);
-	if (IS_ERR(hw))
+	parent_data[0] = AT91_CLK_PD_HW(main_rc_hw);
+	parent_data[1] = AT91_CLK_PD_HW(main_osc_hw);
+	mainck_hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_data, 2);
+	if (IS_ERR(mainck_hw))
 		goto err_free;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL, &AT91_CLK_PD_HW(mainck_hw), 0,
 				   &sama5d3_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", "pllack", NULL);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, &AT91_CLK_PD_HW(hw));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d3_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck", NULL);
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", NULL, &AT91_CLK_PD_HW(mainck_hw));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d3_pmc->chws[PMC_UTMI] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
+	parent_data[0] = AT91_CLK_PD_NAME(slow_clk_name);
+	parent_data[1] = AT91_CLK_PD_HW(mainck_hw);
+	parent_data[2] = AT91_CLK_PD_HW(sama5d3_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(sama5d3_pmc->chws[PMC_UTMI]);
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names, NULL,
+					   NULL, parent_data,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL,
+					  NULL, &AT91_CLK_PD_HW(hw),
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
@@ -199,28 +201,30 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 
 	sama5d3_pmc->chws[PMC_MCK] = hw;
 
-	parent_names[0] = "plladivck";
-	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
-	if (IS_ERR(hw))
+	parent_data[0] = AT91_CLK_PD_HW(sama5d3_pmc->chws[PMC_PLLACK]);
+	parent_data[1] = AT91_CLK_PD_HW(sama5d3_pmc->chws[PMC_UTMI]);
+	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", NULL, parent_data, 2);
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_names, NULL, 2);
-	if (IS_ERR(hw))
+	parent_data[0] = AT91_CLK_PD_HW(sama5d3_pmc->chws[PMC_PLLACK]);
+	parent_data[1] = AT91_CLK_PD_HW(sama5d3_pmc->chws[PMC_UTMI]);
+	smdck_hw = at91sam9x5_clk_register_smd(regmap, "smdclk", NULL, parent_data, 2);
+	if (IS_ERR(smdck_hw))
 		goto err_free;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
-	parent_names[4] = "masterck_div";
+	parent_data[0] = AT91_CLK_PD_NAME(slow_clk_name);
+	parent_data[1] = AT91_CLK_PD_HW(mainck_hw);
+	parent_data[2] = AT91_CLK_PD_HW(sama5d3_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(sama5d3_pmc->chws[PMC_UTMI]);
+	parent_data[4] = AT91_CLK_PD_HW(sama5d3_pmc->chws[PMC_MCK]);
 	for (i = 0; i < 3; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 5, i,
+						    NULL, parent_data, 5, i,
 						    &at91sam9x5_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -229,9 +233,18 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 		sama5d3_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	sama5d3_systemck[0].parent_hw = sama5d3_pmc->chws[PMC_MCK];
+	sama5d3_systemck[1].parent_hw = sama5d3_pmc->chws[PMC_MCK];
+	sama5d3_systemck[2].parent_hw = smdck_hw;
+	sama5d3_systemck[3].parent_hw = usbck_hw;
+	sama5d3_systemck[4].parent_hw = usbck_hw;
+	sama5d3_systemck[5].parent_hw = sama5d3_pmc->pchws[0];
+	sama5d3_systemck[6].parent_hw = sama5d3_pmc->pchws[1];
+	sama5d3_systemck[7].parent_hw = sama5d3_pmc->pchws[2];
 	for (i = 0; i < ARRAY_SIZE(sama5d3_systemck); i++) {
-		hw = at91_clk_register_system(regmap, sama5d3_systemck[i].n,
-					      sama5d3_systemck[i].p, NULL,
+		hw = at91_clk_register_system(regmap, sama5d3_systemck[i].n, NULL,
+					      &AT91_CLK_PD_HW(sama5d3_systemck[i].parent_hw),
 					      sama5d3_systemck[i].id,
 					      sama5d3_systemck[i].flags);
 		if (IS_ERR(hw))
@@ -244,7 +257,8 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d3_pcr_layout,
 							 sama5d3_periphck[i].n,
-							 "masterck_div", NULL,
+							 NULL,
+							 &AT91_CLK_PD_HW(sama5d3_pmc->chws[PMC_MCK]),
 							 sama5d3_periphck[i].id,
 							 &sama5d3_periphck[i].r,
 							 INT_MIN,
-- 
2.43.0


