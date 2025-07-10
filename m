Return-Path: <linux-kernel+bounces-726384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CFFB00C96
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1286436EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A852303DCF;
	Thu, 10 Jul 2025 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VKX/tU8m"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0142FF483;
	Thu, 10 Jul 2025 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178078; cv=none; b=JCuh8DrBBt6N4yPRnqvwip/J7skedA+lyp/nmLA1IvSibHtwlQVdhUxg1a6+VyHLhMcJTA0g8o2xw9d5g9moBJ0b/fuKcGPWOXtu1PBEebv5K7nm1VMrFP+9n7eZTyuK1K0KAjv8FP7kVVX41FNH1lFDKM7DySk7NOJlVh5xVVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178078; c=relaxed/simple;
	bh=CsoBwXBJ9Hg7XHUSTSvRziWeLdpewiOQcfQHGS8adhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNqnPuD0/uVmi25s+tRE5EhsC8hdnCMv1Mk/b38tCRbwfj8KcFoNopskyIm7RnzhVQhEs2NIbYHbxKVtZVRfJzNae944fyvJTLIk9U+8+8edV3wAOFxL48scJUd51uCHfmpEir/D+BDx9dbw2lKygKvMIavdrS3jYmPaR7nrp/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VKX/tU8m; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752178077; x=1783714077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CsoBwXBJ9Hg7XHUSTSvRziWeLdpewiOQcfQHGS8adhc=;
  b=VKX/tU8m6PJPTwyCq2gc+jJBU8cbnv1fEMqMHgfSbpUIr0X5wUfxy66g
   NheXWOWEegrLrSQLzN2Uoio997m6q3S49dRl8bXjroBUwqkbqgRpfqVGJ
   WpVL1fz2Alxngs3S5NmM9ZCZO3ZLXd3BcEFbtlt3H4SBAXtquHWtoz6WJ
   rWsjHDE32zbThoZ20FbznMcLW3gE9Owi7gkokhO9hZlQoVzvTV0fuIr99
   sQxut9AtfqyJESDg+EjbuvObbkBiihszRZ7dyHwpbxc7prLL1HEey5hT/
   DjPB3LwWA+ubPE+R8SNFIosmqo1YdrAD1nq4X48W1T4Sp7V39jfVQKJgu
   w==;
X-CSE-ConnectionGUID: qOQSLemoQZOGUxBCHa7nXg==
X-CSE-MsgGUID: bIMdraYCRciwpo76SU0mJg==
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="275215688"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 13:07:41 -0700
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
Subject: [PATCH v3 30/32] clk: at91: at91sam9n12: switch to parent_hw and parent_data
Date: Thu, 10 Jul 2025 13:07:23 -0700
Message-ID: <bef389b9e70f019ef6bd5b31ace2d2a1b1d82c46.1752176711.git.Ryan.Wanner@microchip.com>
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

Switch AT91SAM9N12 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/at91sam9n12.c | 106 +++++++++++++++++----------------
 1 file changed, 54 insertions(+), 52 deletions(-)

diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 34dd7645f964..88950003a58e 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -51,9 +51,9 @@ static const struct clk_pll_characteristics pllb_characteristics = {
 	.out = pllb_out,
 };
 
-static const struct {
+static struct {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	unsigned long flags;
 	u8 id;
 } at91sam9n12_systemck[] = {
@@ -61,12 +61,12 @@ static const struct {
 	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
 	 * to keep it enabled in case there is no Linux consumer for it.
 	 */
-	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
-	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
-	{ .n = "uhpck", .p = "usbck",        .id = 6 },
-	{ .n = "udpck", .p = "usbck",        .id = 7 },
-	{ .n = "pck0",  .p = "prog0",        .id = 8 },
-	{ .n = "pck1",  .p = "prog1",        .id = 9 },
+	{ .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
+	{ .n = "lcdck", .id = 3 },
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "udpck", .id = 7 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
 };
 
 static const struct clk_pcr_layout at91sam9n12_pcr_layout = {
@@ -111,25 +111,15 @@ static const struct pck at91sam9n12_periphck[] = {
 
 static void __init at91sam9n12_pmc_setup(struct device_node *np)
 {
+	const char *slow_clk_name = "slowck", *main_xtal_name = "main_xtal";
+	struct clk_hw *usbck_hw, *hw, *main_rc_hw, *main_osc_hw;
+	u8 slow_clk_index = 0, main_xtal_index = 1;
 	struct clk_range range = CLK_RANGE(0, 0);
-	const char *slck_name, *mainxtal_name;
+	struct clk_parent_data parent_data[5];
 	struct pmc_data *at91sam9n12_pmc;
-	const char *parent_names[6];
 	struct regmap *regmap;
-	struct clk_hw *hw;
-	int i;
 	bool bypass;
-
-	i = of_property_match_string(np, "clock-names", "slow_clk");
-	if (i < 0)
-		return;
-
-	slck_name = of_clk_get_parent_name(np, i);
-
-	i = of_property_match_string(np, "clock-names", "main_xtal");
-	if (i < 0)
-		return;
-	mainxtal_name = of_clk_get_parent_name(np, i);
+	int i;
 
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
@@ -140,50 +130,53 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 	if (!at91sam9n12_pmc)
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
+						 &AT91_CLK_PD_NAME(main_xtal_name, main_xtal_index),
+						 bypass);
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
 
 	at91sam9n12_pmc->chws[PMC_MAIN] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL,
+				   &AT91_CLK_PD_HW(at91sam9n12_pmc->chws[PMC_MAIN]), 0,
 				   &at91rm9200_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", "pllack", NULL);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, &AT91_CLK_PD_HW(hw));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91sam9n12_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", NULL, 1,
+	hw = at91_clk_register_pll(regmap, "pllbck", NULL,
+				   &AT91_CLK_PD_HW(at91sam9n12_pmc->chws[PMC_MAIN]), 1,
 				   &at91rm9200_pll_layout, &pllb_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91sam9n12_pmc->chws[PMC_PLLBCK] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "pllbck";
+	parent_data[0] = AT91_CLK_PD_NAME(slow_clk_name, slow_clk_index);
+	parent_data[1] = AT91_CLK_PD_HW(at91sam9n12_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(at91sam9n12_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(at91sam9n12_pmc->chws[PMC_PLLBCK]);
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names, NULL,
+					   NULL, parent_data,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics,
 					   &at91sam9n12_mck_lock);
@@ -191,7 +184,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL,
+					  NULL, &AT91_CLK_PD_HW(hw),
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics,
 					  &at91sam9n12_mck_lock,
@@ -201,22 +194,23 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 
 	at91sam9n12_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91sam9n12_clk_register_usb(regmap, "usbck", "pllbck", NULL);
-	if (IS_ERR(hw))
+	usbck_hw = at91sam9n12_clk_register_usb(regmap, "usbck", NULL,
+						&AT91_CLK_PD_HW(at91sam9n12_pmc->chws[PMC_PLLBCK]));
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "pllbck";
-	parent_names[4] = "masterck_div";
+	parent_data[0] = AT91_CLK_PD_NAME(slow_clk_name, slow_clk_index);
+	parent_data[1] = AT91_CLK_PD_HW(at91sam9n12_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(at91sam9n12_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(at91sam9n12_pmc->chws[PMC_PLLBCK]);
+	parent_data[4] = AT91_CLK_PD_HW(at91sam9n12_pmc->chws[PMC_MCK]);
 	for (i = 0; i < 2; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 5, i,
+						    NULL, parent_data, 5, i,
 						    &at91sam9x5_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -225,9 +219,16 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 		at91sam9n12_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	at91sam9n12_systemck[0].parent_hw = at91sam9n12_pmc->chws[PMC_MCK];
+	at91sam9n12_systemck[1].parent_hw = at91sam9n12_pmc->chws[PMC_MCK];
+	at91sam9n12_systemck[2].parent_hw = usbck_hw;
+	at91sam9n12_systemck[3].parent_hw = usbck_hw;
+	at91sam9n12_systemck[4].parent_hw = at91sam9n12_pmc->pchws[0];
+	at91sam9n12_systemck[5].parent_hw = at91sam9n12_pmc->pchws[1];
 	for (i = 0; i < ARRAY_SIZE(at91sam9n12_systemck); i++) {
-		hw = at91_clk_register_system(regmap, at91sam9n12_systemck[i].n,
-					      at91sam9n12_systemck[i].p, NULL,
+		hw = at91_clk_register_system(regmap, at91sam9n12_systemck[i].n, NULL,
+					      &AT91_CLK_PD_HW(at91sam9n12_systemck[i].parent_hw),
 					      at91sam9n12_systemck[i].id,
 					      at91sam9n12_systemck[i].flags);
 		if (IS_ERR(hw))
@@ -240,7 +241,8 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &at91sam9n12_pcr_layout,
 							 at91sam9n12_periphck[i].n,
-							 "masterck_div", NULL,
+							 NULL,
+							 &AT91_CLK_PD_HW(at91sam9n12_pmc->chws[PMC_MCK]),
 							 at91sam9n12_periphck[i].id,
 							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
-- 
2.43.0


