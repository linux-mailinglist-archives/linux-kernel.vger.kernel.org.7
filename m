Return-Path: <linux-kernel+bounces-726381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D68B00C95
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E685816E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFB530206B;
	Thu, 10 Jul 2025 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kUY0Rw4V"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C832FD878;
	Thu, 10 Jul 2025 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178076; cv=none; b=N5kgXpZs10ZnOhC47IeYofiO2SDpeAqi4KRqXkViUI+Iox1cJSStq6QT+8DeyaLB/xtuz1gsw0+CEYfnz1mWfXeLuvur7loFqjonF6zuR7++D1GmIYcBRhTQYI3xLcBOr4gB7Oxl38W71pyPddW0yDEWAJ7nXnjPCsD0pjozfuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178076; c=relaxed/simple;
	bh=0hAK7L1RYs0Sv39pZp/DbF7t/kadiEUNsBjaVw2GFMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FR3uY1k+RcUaCxK/S/ZW5utQFxDCN2LvxAgmnTCB3zM07noceMkC4/KIuu3zOHdcwR25hZLnB+50kGMPbdC2GLa5wQdNTwYI81CZxhceEZERRZlbajTL9dXKKnJmBKi11+h/wZikBhFD7Wzy3Br8pIxqLWerF88AtmPSAm6bX6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kUY0Rw4V; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752178075; x=1783714075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0hAK7L1RYs0Sv39pZp/DbF7t/kadiEUNsBjaVw2GFMk=;
  b=kUY0Rw4VB5HS7gvT/81MeVLqnOL3jHQ1seWgcBnUX72bDlarYHT4U665
   PqfE4O5m/d5vm1PdEQ0y/pda5gimEvFcpvc+8uW7B6yO2nmJomgxAT9rf
   rrhhIBOPaDdVLvubn0jsbjLBLDyqYubmmD8M9v0OSAkWuxW59DrzQufNa
   SdYAlvwHHKo8RVcKB0f5L5VPX2/dVf5MyAGuaBKwBYdPxLNU9Bp4n/xTo
   Qkt1Mo7EO1zxcEPQHVqRlqJnY0VLLrlFX791sEU79gFECgQ50ai0kznib
   sqaNRULdZ25nYLRHpksti45BuCysm3s3TUmxm0S2PR84oSDV60LCKKl9h
   w==;
X-CSE-ConnectionGUID: qOQSLemoQZOGUxBCHa7nXg==
X-CSE-MsgGUID: vlmqaKiyRa6YYYB1Cz4tvQ==
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="275215685"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 13:07:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 10 Jul 2025 13:07:34 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 10 Jul 2025 13:07:34 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <varshini.rajendran@microchip.com>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robh@kernel.org>
Subject: [PATCH v3 27/32] clk: at91: at91rm9200: switch to parent_hw and parent_data
Date: Thu, 10 Jul 2025 13:07:20 -0700
Message-ID: <a2adb10299993c0d8167a5eb443304022485d4ea.1752176711.git.Ryan.Wanner@microchip.com>
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

Switch AT91RM9200 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/at91rm9200.c | 95 ++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 46 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 623e232ec9c6..b834ca5ed092 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -11,7 +11,7 @@ static DEFINE_SPINLOCK(rm9200_mck_lock);
 
 struct sck {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	u8 id;
 };
 
@@ -39,13 +39,13 @@ static const struct clk_pll_characteristics rm9200_pll_characteristics = {
 	.out = rm9200_pll_out,
 };
 
-static const struct sck at91rm9200_systemck[] = {
-	{ .n = "udpck", .p = "usbck",    .id = 1 },
-	{ .n = "uhpck", .p = "usbck",    .id = 4 },
-	{ .n = "pck0",  .p = "prog0",    .id = 8 },
-	{ .n = "pck1",  .p = "prog1",    .id = 9 },
-	{ .n = "pck2",  .p = "prog2",    .id = 10 },
-	{ .n = "pck3",  .p = "prog3",    .id = 11 },
+static struct sck at91rm9200_systemck[] = {
+	{ .n = "udpck", .id = 1 },
+	{ .n = "uhpck", .id = 4 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
+	{ .n = "pck2",  .id = 10 },
+	{ .n = "pck3",  .id = 11 },
 };
 
 static const struct pck at91rm9200_periphck[] = {
@@ -76,25 +76,15 @@ static const struct pck at91rm9200_periphck[] = {
 
 static void __init at91rm9200_pmc_setup(struct device_node *np)
 {
-	const char *slowxtal_name, *mainxtal_name;
+	const char *slow_clk_name = "slowck", *main_xtal_name = "main_xtal";
+	struct clk_hw *usbck_hw, *main_osc_hw, *hw;
+	u8 slow_clk_index = 0, main_xtal_index = 1;
+	struct clk_parent_data parent_data[6];
 	struct pmc_data *at91rm9200_pmc;
 	u32 usb_div[] = { 1, 2, 0, 0 };
-	const char *parent_names[6];
 	struct regmap *regmap;
-	struct clk_hw *hw;
-	int i;
 	bool bypass;
-
-	i = of_property_match_string(np, "clock-names", "slow_xtal");
-	if (i < 0)
-		return;
-
-	slowxtal_name = of_clk_get_parent_name(np, i);
-
-	i = of_property_match_string(np, "clock-names", "main_xtal");
-	if (i < 0)
-		return;
-	mainxtal_name = of_clk_get_parent_name(np, i);
+	int i;
 
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
@@ -108,18 +98,21 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
-					bypass);
-	if (IS_ERR(hw))
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
+						 &AT91_CLK_PD_NAME(main_xtal_name, main_xtal_index),
+						 bypass);
+	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
-	hw = at91_clk_register_rm9200_main(regmap, "mainck", "main_osc", NULL);
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", NULL,
+					   &AT91_CLK_PD_HW(main_osc_hw));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91rm9200_pmc->chws[PMC_MAIN] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL,
+				   &AT91_CLK_PD_HW(at91rm9200_pmc->chws[PMC_MAIN]), 0,
 				   &at91rm9200_pll_layout,
 				   &rm9200_pll_characteristics);
 	if (IS_ERR(hw))
@@ -127,7 +120,8 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	at91rm9200_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", NULL, 1,
+	hw = at91_clk_register_pll(regmap, "pllbck", NULL,
+				   &AT91_CLK_PD_HW(at91rm9200_pmc->chws[PMC_MAIN]), 1,
 				   &at91rm9200_pll_layout,
 				   &rm9200_pll_characteristics);
 	if (IS_ERR(hw))
@@ -135,20 +129,19 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	at91rm9200_pmc->chws[PMC_PLLBCK] = hw;
 
-	parent_names[0] = slowxtal_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "pllack";
-	parent_names[3] = "pllbck";
+	parent_data[0] = AT91_CLK_PD_NAME(slow_clk_name, slow_clk_index);
+	parent_data[1] = AT91_CLK_PD_HW(at91rm9200_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(at91rm9200_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(at91rm9200_pmc->chws[PMC_PLLBCK]);
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names, NULL,
+					   NULL, parent_data,
 					   &at91rm9200_master_layout,
 					   &rm9200_mck_characteristics,
 					   &rm9200_mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL,
+	hw = at91_clk_register_master_div(regmap, "masterck_div", NULL, &AT91_CLK_PD_HW(hw),
 					  &at91rm9200_master_layout,
 					  &rm9200_mck_characteristics,
 					  &rm9200_mck_lock, CLK_SET_RATE_GATE, 0);
@@ -157,21 +150,23 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	at91rm9200_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", NULL, usb_div);
-	if (IS_ERR(hw))
+	usbck_hw = at91rm9200_clk_register_usb(regmap, "usbck", NULL,
+					       &AT91_CLK_PD_HW(at91rm9200_pmc->chws[PMC_PLLBCK]),
+					       usb_div);
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	parent_names[0] = slowxtal_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "pllack";
-	parent_names[3] = "pllbck";
+	parent_data[0] = AT91_CLK_PD_NAME(slow_clk_name, slow_clk_index);
+	parent_data[1] = AT91_CLK_PD_HW(at91rm9200_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(at91rm9200_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(at91rm9200_pmc->chws[PMC_PLLBCK]);
 	for (i = 0; i < 4; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 4, i,
+						    NULL, parent_data, 4, i,
 						    &at91rm9200_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -180,9 +175,16 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 		at91rm9200_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	at91rm9200_systemck[0].parent_hw = usbck_hw;
+	at91rm9200_systemck[1].parent_hw = usbck_hw;
+	at91rm9200_systemck[2].parent_hw = at91rm9200_pmc->pchws[0];
+	at91rm9200_systemck[3].parent_hw = at91rm9200_pmc->pchws[1];
+	at91rm9200_systemck[4].parent_hw = at91rm9200_pmc->pchws[2];
+	at91rm9200_systemck[5].parent_hw = at91rm9200_pmc->pchws[3];
 	for (i = 0; i < ARRAY_SIZE(at91rm9200_systemck); i++) {
-		hw = at91_clk_register_system(regmap, at91rm9200_systemck[i].n,
-					      at91rm9200_systemck[i].p, NULL,
+		hw = at91_clk_register_system(regmap, at91rm9200_systemck[i].n, NULL,
+					      &AT91_CLK_PD_HW(at91rm9200_systemck[i].parent_hw),
 					      at91rm9200_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
@@ -193,7 +195,8 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91rm9200_periphck); i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  at91rm9200_periphck[i].n,
-						  "masterck_div", NULL,
+						  NULL,
+						  &AT91_CLK_PD_HW(at91rm9200_pmc->chws[PMC_MCK]),
 						  at91rm9200_periphck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
-- 
2.43.0


