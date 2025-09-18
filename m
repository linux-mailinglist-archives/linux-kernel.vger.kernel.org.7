Return-Path: <linux-kernel+bounces-823658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A92B87171
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3666B7C238A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0C322A2D;
	Thu, 18 Sep 2025 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="T4Nn4bVJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AAB32145B;
	Thu, 18 Sep 2025 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230207; cv=none; b=uRIqlMz3SNwBb7yrqWxMcdo6oFVUvad17hawzT4tgj/vr0KLkdKzshEDrz/+ZY44QkduheBtyPzYM8rWORkSlzyoQh/e9RiaO4B7cHtTKPDTY9yeJNNhw2xXM1qUtVxZs8pVrQYLQCHp/hi/MnC7ZQULLN44yHDlTBcN+NLPQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230207; c=relaxed/simple;
	bh=BEQXOJKWpxyFqzghfCssvHtpcN2ttraChzvVk74xo8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trr4gBCJTB1t8KCYNV2ROtF8ej+aSg3I8L/CshrQ4DfwTDoR6lrQexgrIBqX8Yqb6VyyKdfYsJCSS2K/xxme6SeMS4OH0bn7OAjNI04U5N1ak+ZdLjssXJTzvVa1kveE96SmoiHj9J/3kRaigcEhiuNMUT+9UsltJrEQ0qpOcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=T4Nn4bVJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230206; x=1789766206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BEQXOJKWpxyFqzghfCssvHtpcN2ttraChzvVk74xo8g=;
  b=T4Nn4bVJk8R57bOSsxdut8MciVdSNJa03Ezuhh1fB9kuFMapDTsxyMQL
   C6ktou6U/N3UyM7rPeysGp2lt2BwrRhPresfmVJ89YcXqCpjNUkdJ+ADH
   d8zNr/rSctvh9RaW1KYHwOmNOQYukl6xmTM7D4mkIeDaUocA/0PNBwnKf
   vZ8v5P4aCxjrMTgrsL+aEUNAGsHGX90NlJ/BkdBn9h/zJgntkuBDR1R0B
   PXH7TZqpih36Q+JyNSq/Za0qFqru/Wd2oa5dRBP890JVhfrwWV8uavH3i
   40JgjMYXePMMNuoG6j3VLmdzLKJ839ahVCQin2jJmBbniEyQviCebAxfk
   A==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: c63PvV3GR7+ZUaUI/K4X/g==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071405"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 14:16:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 14:15:55 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 14:15:55 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <varshini.rajendran@microchip.com>
Subject: [PATCH v4 29/31] clk: at91: at91sam9g45: switch to parent_hw and parent_data
Date: Thu, 18 Sep 2025 14:16:11 -0700
Message-ID: <834a4851a288d18d9d32c64cbbe2d380e01177c4.1758226719.git.Ryan.Wanner@microchip.com>
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

Switch AT91SAM9G45 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/at91sam9g45.c | 73 +++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index cb98d22c2e30..b74e2dee8e4c 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -37,9 +37,9 @@ static const struct clk_pll_characteristics plla_characteristics = {
 	.out = plla_out,
 };
 
-static const struct {
+static struct {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	unsigned long flags;
 	u8 id;
 } at91sam9g45_systemck[] = {
@@ -47,10 +47,10 @@ static const struct {
 	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
 	 * to keep it enabled in case there is no Linux consumer for it.
 	 */
-	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
-	{ .n = "uhpck", .p = "usbck",        .id = 6 },
-	{ .n = "pck0",  .p = "prog0",        .id = 8 },
-	{ .n = "pck1",  .p = "prog1",        .id = 9 },
+	{ .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
 };
 
 struct pck {
@@ -93,10 +93,10 @@ static const struct pck at91sam9g45_periphck[] = {
 static void __init at91sam9g45_pmc_setup(struct device_node *np)
 {
 	const char *slck_name, *mainxtal_name;
+	struct clk_parent_data parent_data[5];
 	struct pmc_data *at91sam9g45_pmc;
-	const char *parent_names[6];
+	struct clk_hw *usbck_hw, *hw;
 	struct regmap *regmap;
-	struct clk_hw *hw;
 	int i;
 	bool bypass;
 
@@ -123,40 +123,43 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
+	hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
+					&AT91_CLK_PD_NAME(mainxtal_name),
 					bypass);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_rm9200_main(regmap, "mainck", "main_osc", NULL);
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", NULL, &AT91_CLK_PD_HW(hw));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91sam9g45_pmc->chws[PMC_MAIN] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL,
+				   &AT91_CLK_PD_HW(at91sam9g45_pmc->chws[PMC_MAIN]), 0,
 				   &at91rm9200_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", "pllack", NULL);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, &AT91_CLK_PD_HW(hw));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91sam9g45_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck", NULL);
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", NULL,
+				    &AT91_CLK_PD_HW(at91sam9g45_pmc->chws[PMC_MAIN]));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91sam9g45_pmc->chws[PMC_UTMI] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
+	parent_data[0] = AT91_CLK_PD_NAME(slck_name);
+	parent_data[1] = AT91_CLK_PD_HW(at91sam9g45_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(at91sam9g45_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(at91sam9g45_pmc->chws[PMC_UTMI]);
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names, NULL,
+					   NULL, parent_data,
 					   &at91rm9200_master_layout,
 					   &mck_characteristics,
 					   &at91sam9g45_mck_lock);
@@ -164,7 +167,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL,
+					  NULL, &AT91_CLK_PD_HW(hw),
 					  &at91rm9200_master_layout,
 					  &mck_characteristics,
 					  &at91sam9g45_mck_lock,
@@ -174,24 +177,24 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 
 	at91sam9g45_pmc->chws[PMC_MCK] = hw;
 
-	parent_names[0] = "plladivck";
-	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
-	if (IS_ERR(hw))
+	parent_data[0] = AT91_CLK_PD_HW(at91sam9g45_pmc->chws[PMC_PLLACK]);
+	parent_data[1] = AT91_CLK_PD_HW(at91sam9g45_pmc->chws[PMC_UTMI]);
+	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", NULL, parent_data, 2);
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
-	parent_names[4] = "masterck_div";
+	parent_data[0] = AT91_CLK_PD_NAME(slck_name);
+	parent_data[1] = AT91_CLK_PD_HW(at91sam9g45_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(at91sam9g45_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(at91sam9g45_pmc->chws[PMC_UTMI]);
+	parent_data[4] = AT91_CLK_PD_HW(at91sam9g45_pmc->chws[PMC_MCK]);
 	for (i = 0; i < 2; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 5, i,
+						    NULL, parent_data, 5, i,
 						    &at91sam9g45_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -200,9 +203,14 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 		at91sam9g45_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	at91sam9g45_systemck[0].parent_hw = at91sam9g45_pmc->chws[PMC_MCK];
+	at91sam9g45_systemck[1].parent_hw = usbck_hw;
+	at91sam9g45_systemck[2].parent_hw = at91sam9g45_pmc->pchws[0];
+	at91sam9g45_systemck[3].parent_hw = at91sam9g45_pmc->pchws[1];
 	for (i = 0; i < ARRAY_SIZE(at91sam9g45_systemck); i++) {
-		hw = at91_clk_register_system(regmap, at91sam9g45_systemck[i].n,
-					      at91sam9g45_systemck[i].p, NULL,
+		hw = at91_clk_register_system(regmap, at91sam9g45_systemck[i].n, NULL,
+					      &AT91_CLK_PD_HW(at91sam9g45_systemck[i].parent_hw),
 					      at91sam9g45_systemck[i].id,
 					      at91sam9g45_systemck[i].flags);
 		if (IS_ERR(hw))
@@ -214,7 +222,8 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91sam9g45_periphck); i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  at91sam9g45_periphck[i].n,
-						  "masterck_div", NULL,
+						  NULL,
+						  &AT91_CLK_PD_HW(at91sam9g45_pmc->chws[PMC_MCK]),
 						  at91sam9g45_periphck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
-- 
2.43.0


