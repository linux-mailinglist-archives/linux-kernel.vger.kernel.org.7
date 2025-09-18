Return-Path: <linux-kernel+bounces-823656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C12B87163
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381CF188D972
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA80322757;
	Thu, 18 Sep 2025 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lVA88iBH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8F321277;
	Thu, 18 Sep 2025 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230206; cv=none; b=iXOmqrlBF/IoXuftYdLix3bW7mKPWcKXJQrKxgA1D9Krw3C1JbSr6Ak5dQ/N4avfAnMzqdRvIZTPAIMWx+wcPVVbw1FB3Wdt4/Uree7cOfF0CjpcYW99DPXMceEtxuZDnXVIRTr0zXUlDJacxEyKl8uP4njQT35uHVQo/BOCzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230206; c=relaxed/simple;
	bh=XCKw/fzhILEu49Iq3bKLiDkP1UiVyTS4zAjU4YzgJmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqrEH2QfGU8zkK2X0D6Cu3oz0qWkK65Bru0RrZzrG1vrqHikRdRJ0krM/pg8FUFSRa3o3gzKrs1HjMmHSEp1XM2LyX/7JKZswa+4jiVTaRMVgl9yKw9dZmjwQct6eg1mDSwEw3dIrB49xAJqjELxBv/cPPw+byKOepEqoGsZgqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lVA88iBH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230204; x=1789766204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XCKw/fzhILEu49Iq3bKLiDkP1UiVyTS4zAjU4YzgJmU=;
  b=lVA88iBH6+Wdhsm/zgy/+waXbvpbehcBm20FajJeAPYQd7bK/4r71Nuq
   X7bSMBAG4UhTiIMTxBlN4Bbzc+7kUhEz/IODdWaDATBO3zW4qUiaFdrsJ
   7z0rzefJMdK2ANoGoxX6zdCDPBXIFhYpATTRICFkRN0ZKlcegxOTLxFZW
   lt2oI87k+Xgjg3Lvl/MBjKRlis73sZ9MqaWtH75XMNvVqvkCEh72qu28H
   QarM1uvSk96j4XZTd7h/pOBHTPnYPsDeslUJWrWAO158MWDcMfVBqYX0P
   ZuQ9ZEjrVVzlDDZ7ejeGF2lOa53nKb/2eoqh24O0CQRMRqqV15du6D1aK
   Q==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: LDGvG1grRlSsjNlf0ectfA==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071403"
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
Subject: [PATCH v4 27/31] clk: at91: at91rm9200: switch to parent_hw and parent_data
Date: Thu, 18 Sep 2025 14:16:09 -0700
Message-ID: <95a91edf982c6a567640b226dfea75e2fdcaf93b.1758226719.git.Ryan.Wanner@microchip.com>
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

Switch AT91RM9200 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/at91rm9200.c | 79 ++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 623e232ec9c6..20bb51ec683f 100644
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
@@ -77,11 +77,11 @@ static const struct pck at91rm9200_periphck[] = {
 static void __init at91rm9200_pmc_setup(struct device_node *np)
 {
 	const char *slowxtal_name, *mainxtal_name;
+	struct clk_hw *usbck_hw, *main_osc_hw, *hw;
+	struct clk_parent_data parent_data[6];
 	struct pmc_data *at91rm9200_pmc;
 	u32 usb_div[] = { 1, 2, 0, 0 };
-	const char *parent_names[6];
 	struct regmap *regmap;
-	struct clk_hw *hw;
 	int i;
 	bool bypass;
 
@@ -108,18 +108,21 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
-					bypass);
-	if (IS_ERR(hw))
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
+						 &AT91_CLK_PD_NAME(mainxtal_name),
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
@@ -127,7 +130,8 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	at91rm9200_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", NULL, 1,
+	hw = at91_clk_register_pll(regmap, "pllbck", NULL,
+				   &AT91_CLK_PD_HW(at91rm9200_pmc->chws[PMC_MAIN]), 1,
 				   &at91rm9200_pll_layout,
 				   &rm9200_pll_characteristics);
 	if (IS_ERR(hw))
@@ -135,20 +139,19 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	at91rm9200_pmc->chws[PMC_PLLBCK] = hw;
 
-	parent_names[0] = slowxtal_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "pllack";
-	parent_names[3] = "pllbck";
+	parent_data[0] = AT91_CLK_PD_NAME(slowxtal_name);
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
@@ -157,21 +160,23 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
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
+	parent_data[0] = AT91_CLK_PD_NAME(slowxtal_name);
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
@@ -180,9 +185,16 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
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
@@ -193,7 +205,8 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
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


