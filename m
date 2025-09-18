Return-Path: <linux-kernel+bounces-823657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB52B87168
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7181C86845
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12EC322A15;
	Thu, 18 Sep 2025 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="n3agaUsc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08E3321284;
	Thu, 18 Sep 2025 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230206; cv=none; b=mj8y3WcyULo+m/LeUU4CwmQPeFbzbjNuEmZIxID/oqNPAheVn/zFNUn0GlsvBAcgm4Sf84tlmrNuChd1pxYCIvQ70B/SpWdPmHL1P0QHcwsI/v0wKMQPBUZjYFRJ7qbNkB5yHe1ZYwVt6mLANrhWD0hAw4th7Mrqp873AAwPkd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230206; c=relaxed/simple;
	bh=vVhRnuOxtx40U4X6AiR/OMJ1gOwse9+LnGmz9ZDzWwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrDW6URcm8xbC/GbMqWUP++44QcR7iYCyM8cZID4lb+2tcKriFCMlbKL2igpwCAvNrG8kr1yPJ/anS/AOlZhgeVN49tAhjjEzLOCvIwMvQGwpxv7fOLiqHaMm9l7O6rcaSFFEgy+zYSkifP1ygmHbLXMOMNN+pYZDsAM40QdV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=n3agaUsc; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230205; x=1789766205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vVhRnuOxtx40U4X6AiR/OMJ1gOwse9+LnGmz9ZDzWwY=;
  b=n3agaUscp9TJgh42kOx+YsLjsExVHArq9eaKv+eh7BH6sRbf9C6lLN7a
   XrhKw4Rqe/NMxvTKfNgGNOX8NKQfL42Cdh9JRH1tu/hFFY1OObpn/8h23
   F1gXudzxJxLeDmRA4254eYyStx1WkU1b4rnXuLaKCpy79Q2HkxTYzAjE4
   bVuS6V9E97d8jIqk8Jxq4jE5WPDyRyYSQtb2F+FdnX3ImhqHpdx7cOxAn
   ISvaSF5Tje40ZNbSltfTZdIeNXH7jsTktbSV0A01YTU4n6wCrW26VOiMc
   od1IjAJpD1RayjwmGPR/Wm4zAm3UDnPxiFZN5jXSBgRLIUmPjZdwGhPxH
   Q==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: CW3luNmXSj6B+P7uGSImMg==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071404"
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
Subject: [PATCH v4 28/31] clk: at91: at91sam9260: switch to parent_hw and parent_data
Date: Thu, 18 Sep 2025 14:16:10 -0700
Message-ID: <a85eafe6b462d385c399f8e56773dbedaa1f3260.1758226719.git.Ryan.Wanner@microchip.com>
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

Switch AT91SAM92600 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/at91sam9260.c | 120 ++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 53 deletions(-)

diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 55350331b07e..2ac2a340da2f 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -9,7 +9,7 @@
 
 struct sck {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	u8 id;
 };
 
@@ -24,7 +24,7 @@ struct at91sam926x_data {
 	const struct clk_pll_layout *pllb_layout;
 	const struct clk_pll_characteristics *pllb_characteristics;
 	const struct clk_master_characteristics *mck_characteristics;
-	const struct sck *sck;
+	struct sck *sck;
 	const struct pck *pck;
 	u8 num_sck;
 	u8 num_pck;
@@ -72,11 +72,11 @@ static const struct clk_pll_characteristics sam9260_pllb_characteristics = {
 	.out = sam9260_pllb_out,
 };
 
-static const struct sck at91sam9260_systemck[] = {
-	{ .n = "uhpck", .p = "usbck",    .id = 6 },
-	{ .n = "udpck", .p = "usbck",    .id = 7 },
-	{ .n = "pck0",  .p = "prog0",    .id = 8 },
-	{ .n = "pck1",  .p = "prog1",    .id = 9 },
+static struct sck at91sam9260_systemck[] = {
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "udpck", .id = 7 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
 };
 
 static const struct pck at91sam9260_periphck[] = {
@@ -213,15 +213,15 @@ static const struct clk_pll_characteristics sam9261_pllb_characteristics = {
 	.out = sam9261_pllb_out,
 };
 
-static const struct sck at91sam9261_systemck[] = {
-	{ .n = "uhpck", .p = "usbck",    .id = 6 },
-	{ .n = "udpck", .p = "usbck",    .id = 7 },
-	{ .n = "pck0",  .p = "prog0",    .id = 8 },
-	{ .n = "pck1",  .p = "prog1",    .id = 9 },
-	{ .n = "pck2",  .p = "prog2",    .id = 10 },
-	{ .n = "pck3",  .p = "prog3",    .id = 11 },
-	{ .n = "hclk0", .p = "masterck_div", .id = 16 },
-	{ .n = "hclk1", .p = "masterck_div", .id = 17 },
+static struct sck at91sam9261_systemck[] = {
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "udpck", .id = 7 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
+	{ .n = "pck2",  .id = 10 },
+	{ .n = "pck3",  .id = 11 },
+	{ .n = "hclk0", .id = 16 },
+	{ .n = "hclk1", .id = 17 },
 };
 
 static const struct pck at91sam9261_periphck[] = {
@@ -277,13 +277,13 @@ static const struct clk_pll_characteristics sam9263_pll_characteristics = {
 	.out = sam9260_plla_out,
 };
 
-static const struct sck at91sam9263_systemck[] = {
-	{ .n = "uhpck", .p = "usbck",    .id = 6 },
-	{ .n = "udpck", .p = "usbck",    .id = 7 },
-	{ .n = "pck0",  .p = "prog0",    .id = 8 },
-	{ .n = "pck1",  .p = "prog1",    .id = 9 },
-	{ .n = "pck2",  .p = "prog2",    .id = 10 },
-	{ .n = "pck3",  .p = "prog3",    .id = 11 },
+static struct sck at91sam9263_systemck[] = {
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "udpck", .id = 7 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
+	{ .n = "pck2",  .id = 10 },
+	{ .n = "pck3",  .id = 11 },
 };
 
 static const struct pck at91sam9263_periphck[] = {
@@ -330,12 +330,11 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 					 struct at91sam926x_data *data)
 {
 	const char *slowxtal_name, *mainxtal_name;
+	struct clk_parent_data parent_data[4];
 	struct pmc_data *at91sam9260_pmc;
 	u32 usb_div[] = { 1, 2, 4, 0 };
-	const char *parent_names[6];
-	const char *slck_name;
+	struct clk_hw *usbck_hw, *hw;
 	struct regmap *regmap;
-	struct clk_hw *hw;
 	int i;
 	bool bypass;
 
@@ -363,12 +362,13 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
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
 
@@ -382,20 +382,17 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 		if (IS_ERR(hw))
 			goto err_free;
 
-		parent_names[0] = "slow_rc_osc";
-		parent_names[1] = "slow_xtal";
-		hw = at91_clk_register_sam9260_slow(regmap, "slck",
-						    parent_names, NULL, 2);
+		parent_data[0] = AT91_CLK_PD_HW(hw);
+		parent_data[1] = AT91_CLK_PD_NAME(slowxtal_name);
+		hw = at91_clk_register_sam9260_slow(regmap, "slck", NULL, parent_data, 2);
 		if (IS_ERR(hw))
 			goto err_free;
 
 		at91sam9260_pmc->chws[PMC_SLOW] = hw;
-		slck_name = "slck";
-	} else {
-		slck_name = slowxtal_name;
 	}
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL,
+				   &AT91_CLK_PD_HW(at91sam9260_pmc->chws[PMC_MAIN]), 0,
 				   data->plla_layout,
 				   data->plla_characteristics);
 	if (IS_ERR(hw))
@@ -403,7 +400,8 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 	at91sam9260_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", NULL, 1,
+	hw = at91_clk_register_pll(regmap, "pllbck", NULL,
+				   &AT91_CLK_PD_HW(at91sam9260_pmc->chws[PMC_MAIN]), 1,
 				   data->pllb_layout,
 				   data->pllb_characteristics);
 	if (IS_ERR(hw))
@@ -411,12 +409,12 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 	at91sam9260_pmc->chws[PMC_PLLBCK] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "pllack";
-	parent_names[3] = "pllbck";
+	parent_data[0] = AT91_CLK_PD_NAME(slowxtal_name);
+	parent_data[1] = AT91_CLK_PD_HW(at91sam9260_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(at91sam9260_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(at91sam9260_pmc->chws[PMC_PLLACK]);
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names, NULL,
+					   NULL, parent_data,
 					   &at91rm9200_master_layout,
 					   data->mck_characteristics,
 					   &at91sam9260_mck_lock);
@@ -424,7 +422,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL,
+					  NULL, &AT91_CLK_PD_HW(hw),
 					  &at91rm9200_master_layout,
 					  data->mck_characteristics,
 					  &at91sam9260_mck_lock,
@@ -434,21 +432,23 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 	at91sam9260_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", NULL, usb_div);
-	if (IS_ERR(hw))
+	usbck_hw = at91rm9200_clk_register_usb(regmap, "usbck", NULL,
+					       &AT91_CLK_PD_HW(at91sam9260_pmc->chws[PMC_PLLBCK]),
+					       usb_div);
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "pllack";
-	parent_names[3] = "pllbck";
+	parent_data[0] = AT91_CLK_PD_NAME(slowxtal_name);
+	parent_data[1] = AT91_CLK_PD_HW(at91sam9260_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(at91sam9260_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(at91sam9260_pmc->chws[PMC_PLLBCK]);
 	for (i = 0; i < data->num_progck; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 4, i,
+						    NULL, parent_data, 4, i,
 						    &at91rm9200_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -457,9 +457,22 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 		at91sam9260_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	data->sck[0].parent_hw = usbck_hw;
+	data->sck[1].parent_hw = usbck_hw;
+	data->sck[2].parent_hw = at91sam9260_pmc->pchws[0];
+	data->sck[3].parent_hw = at91sam9260_pmc->pchws[1];
+	if (data->num_sck == 6) {
+		data->sck[4].parent_hw = at91sam9260_pmc->pchws[2];
+		data->sck[5].parent_hw = at91sam9260_pmc->pchws[3];
+	}
+	if (data->num_sck == 8) {
+		data->sck[6].parent_hw = at91sam9260_pmc->chws[PMC_MCK];
+		data->sck[7].parent_hw = at91sam9260_pmc->chws[PMC_MCK];
+	}
 	for (i = 0; i < data->num_sck; i++) {
-		hw = at91_clk_register_system(regmap, data->sck[i].n,
-					      data->sck[i].p, NULL,
+		hw = at91_clk_register_system(regmap, data->sck[i].n, NULL,
+					      &AT91_CLK_PD_HW(data->sck[i].parent_hw),
 					      data->sck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
@@ -470,7 +483,8 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 	for (i = 0; i < data->num_pck; i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  data->pck[i].n,
-						  "masterck_div", NULL,
+						  NULL,
+						  &AT91_CLK_PD_HW(at91sam9260_pmc->chws[PMC_MCK]),
 						  data->pck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
-- 
2.43.0


