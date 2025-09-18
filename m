Return-Path: <linux-kernel+bounces-823655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5061FB8715C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560B118912F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C693218BE;
	Thu, 18 Sep 2025 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uc8/mAVj"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEFE320CD3;
	Thu, 18 Sep 2025 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230205; cv=none; b=cv3IamsxnrHF0qOu9LDhpaSE8S7Pg7rPBfU3yKFTS9ac1sI/Shf29Hv+ESmbvafIEUr52snkpWwgZIkWV2OaCVp3cTXY3g+4oUPxkjXSmStshW8VgJjZUEzJkqIzcxICeZ/bEtNn2znTlWY+jFrDzv6bwcxBRjPGqz6fR0hreAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230205; c=relaxed/simple;
	bh=jz3tgRGRyI6GC9l2gIhHwJ05zKr/E2Q0GiCbAAitlSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ft8Ds/Eda81qt1I3u3zp4IcLZvzkyNoGRkupoBPFMmTQiGb7Mp48353/JmQ1TXAiTZoIVxUQXLYIWOwCoSnpnb9PfroI9aBYBA/v4lnUiDos4LP0Rx9wh6YoHUvjO6hHHERZHJQGCEW2FoPquvkAdwJvA1C4k2QWmUUkerguVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uc8/mAVj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230204; x=1789766204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jz3tgRGRyI6GC9l2gIhHwJ05zKr/E2Q0GiCbAAitlSY=;
  b=uc8/mAVjw8UB7DQpvTHSjudhN+FlTj53EZ7W1s1ilmWGYQgW61mSTJFM
   aq3zaYoXy8aWGO8zKxZ5mgShtiiiImGjeNJEYg2CQBfjvkyLZmAxgzwfS
   cucLl0n9WdTw32jl8IpXSg+Vs2WRrTf0OAh/69Fk1zu2Zl7uiPhir0xx8
   SlXBBWfbRRcKFvY/RdoU5tpOsEA8F2TZ8l3kV6WSDsM+vl16CXnigoLmj
   5aIahBMQRhntPjVmQYryEHxX5RGSwKt0VRJZo79scdv4VvJLEfiCUzSXt
   ytXIKPyG+jOiJMjTc5M9e0CDwoOasl2tGD5/MSnOs2lfCGAPILu1rAGTu
   w==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: zmXHEi4HRHSg/jWFrFxgUA==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071402"
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
Subject: [PATCH v4 26/31] clk: at91: at91sam9x5: switch to parent_hw and parent_data
Date: Thu, 18 Sep 2025 14:16:08 -0700
Message-ID: <015b98fa475f97ae8e952343ee9703c9c0d37d19.1758226719.git.Ryan.Wanner@microchip.com>
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

Switch AT91SAM9X5 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/at91sam9x5.c | 108 +++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 47 deletions(-)

diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 13331e015dd7..46d5ea2e6417 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -38,9 +38,9 @@ static const struct clk_pll_characteristics plla_characteristics = {
 	.out = plla_out,
 };
 
-static const struct {
+static struct {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	unsigned long flags;
 	u8 id;
 } at91sam9x5_systemck[] = {
@@ -48,12 +48,12 @@ static const struct {
 	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
 	 * to keep it enabled in case there is no Linux consumer for it.
 	 */
-	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
-	{ .n = "smdck", .p = "smdclk",   .id = 4 },
-	{ .n = "uhpck", .p = "usbck",    .id = 6 },
-	{ .n = "udpck", .p = "usbck",    .id = 7 },
-	{ .n = "pck0",  .p = "prog0",    .id = 8 },
-	{ .n = "pck1",  .p = "prog1",    .id = 9 },
+	{ .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
+	{ .n = "smdck", .id = 4 },
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "udpck", .id = 7 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
 };
 
 static const struct clk_pcr_layout at91sam9x5_pcr_layout = {
@@ -133,12 +133,13 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 					const struct pck *extra_pcks,
 					bool has_lcdck)
 {
+	struct clk_hw *main_rc_hw, *main_osc_hw, *hw;
 	struct clk_range range = CLK_RANGE(0, 0);
 	const char *slck_name, *mainxtal_name;
 	struct pmc_data *at91sam9x5_pmc;
-	const char *parent_names[6];
+	struct clk_parent_data parent_data[6];
 	struct regmap *regmap;
-	struct clk_hw *hw;
+	struct clk_hw *smdck_hw, *usbck_hw;
 	int i;
 	bool bypass;
 
@@ -162,56 +163,58 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	if (!at91sam9x5_pmc)
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
+						 &AT91_CLK_PD_NAME(mainxtal_name), bypass);
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
 
 	at91sam9x5_pmc->chws[PMC_MAIN] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL,
+				   &AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_MAIN]), 0,
 				   &at91rm9200_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", "pllack", NULL);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, &AT91_CLK_PD_HW(hw));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91sam9x5_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck", NULL);
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", NULL,
+				    &AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_MAIN]));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91sam9x5_pmc->chws[PMC_UTMI] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
+	parent_data[0] = AT91_CLK_PD_NAME(slck_name);
+	parent_data[1] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_UTMI]);
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
@@ -220,28 +223,30 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 
 	at91sam9x5_pmc->chws[PMC_MCK] = hw;
 
-	parent_names[0] = "plladivck";
-	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
-	if (IS_ERR(hw))
+	parent_data[0] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_PLLACK]);
+	parent_data[1] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_UTMI]);
+	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", NULL, parent_data, 2);
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_names, NULL, 2);
-	if (IS_ERR(hw))
+	parent_data[0] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_PLLACK]);
+	parent_data[1] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_UTMI]);
+	smdck_hw = at91sam9x5_clk_register_smd(regmap, "smdclk", NULL, parent_data, 2);
+	if (IS_ERR(smdck_hw))
 		goto err_free;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
-	parent_names[4] = "masterck_div";
+	parent_data[0] = AT91_CLK_PD_NAME(slck_name);
+	parent_data[1] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_UTMI]);
+	parent_data[4] = AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_MCK]);
 	for (i = 0; i < 2; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 5, i,
+						    NULL, parent_data, 5, i,
 						    &at91sam9x5_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -250,9 +255,16 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 		at91sam9x5_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	at91sam9x5_systemck[0].parent_hw = at91sam9x5_pmc->chws[PMC_MCK];
+	at91sam9x5_systemck[1].parent_hw = smdck_hw;
+	at91sam9x5_systemck[2].parent_hw = usbck_hw;
+	at91sam9x5_systemck[3].parent_hw = usbck_hw;
+	at91sam9x5_systemck[4].parent_hw = at91sam9x5_pmc->pchws[0];
+	at91sam9x5_systemck[5].parent_hw = at91sam9x5_pmc->pchws[1];
 	for (i = 0; i < ARRAY_SIZE(at91sam9x5_systemck); i++) {
-		hw = at91_clk_register_system(regmap, at91sam9x5_systemck[i].n,
-					      at91sam9x5_systemck[i].p, NULL,
+		hw = at91_clk_register_system(regmap, at91sam9x5_systemck[i].n, NULL,
+					      &AT91_CLK_PD_HW(at91sam9x5_systemck[i].parent_hw),
 					      at91sam9x5_systemck[i].id,
 					      at91sam9x5_systemck[i].flags);
 		if (IS_ERR(hw))
@@ -262,8 +274,8 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	}
 
 	if (has_lcdck) {
-		hw = at91_clk_register_system(regmap, "lcdck", "masterck_div",
-					      NULL, 3, 0);
+		hw = at91_clk_register_system(regmap, "lcdck", NULL,
+					      &AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_MCK]), 3, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -274,7 +286,8 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &at91sam9x5_pcr_layout,
 							 at91sam9x5_periphck[i].n,
-							 "masterck_div", NULL,
+							 NULL,
+							 &AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_MCK]),
 							 at91sam9x5_periphck[i].id,
 							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
@@ -287,7 +300,8 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &at91sam9x5_pcr_layout,
 							 extra_pcks[i].n,
-							 "masterck_div", NULL,
+							 NULL,
+							 &AT91_CLK_PD_HW(at91sam9x5_pmc->chws[PMC_MCK]),
 							 extra_pcks[i].id,
 							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
-- 
2.43.0


