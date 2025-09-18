Return-Path: <linux-kernel+bounces-823660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D42B87177
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F4F460495
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBC63233EA;
	Thu, 18 Sep 2025 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="U0zeq66l"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615132252F;
	Thu, 18 Sep 2025 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230208; cv=none; b=U/uFmYpssSaIyH2KDeEJOTAv5w4KlYwBUXEpM9A5cclnDcxhbaUqLpiG+T8sXDStaXsgRAsCmqGCTCJcSYpwjarcp7QJIUJAk2bTTBVM8VkwhEXq+jVWJKH0FHj9f1ACwUJviSnMhyyBo82FW0P4o+Bi9c/2Culs6u7tsv5q5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230208; c=relaxed/simple;
	bh=xqoF1rlYiCbyUzgobq3CKtOYoiAr0pjHL3GMBCRIJXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hl0lT+FlQc6aK3H3Jif2Ee3FKUiRLl/65B50K9xznd8uAFw8Vkd5v3nXwOEZmPNOzOsejHdm0/mTptJtu+tIiDpYkclhcnO54o7qVBMebJfiIBLY390pxRqJSBhG0JGhuggFe69pEYbjKC/zyiejPiD5ChYrLbQAxqdW+xZ5kko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=U0zeq66l; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230207; x=1789766207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xqoF1rlYiCbyUzgobq3CKtOYoiAr0pjHL3GMBCRIJXM=;
  b=U0zeq66lOh7/60iCTqJBKnHYpnHkCmIE85O0AxhbT54278xsMbQLEvHB
   Uiy84aV5WPR0ZjX88T9qqyvfy7y/L7bxAKISc/pEZ02faFy8eAATEZh43
   fDEJFh9VLtQcMGYx/eMOMWEtMnp528MI3ZI3SlCY6+kptSGjDwsTg+0P5
   b7CVnpBBVrbXf/BG2LYQl73c9NpxzPVGukc6afl/iHyIRdH2CiGQ9KQrK
   QEBu/oS7YqweD9c55xiHh0kT4q2x3Q8YkF9DShTLsW63KQ6iGwGeKDwnf
   hgH3JDEBakBu8KPw4/qLWUZRMYVN2fBVSds6dA0dZjvPc29ByJUu4/E1C
   g==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: Q3ofXCo9Qz24xVkPcr8Hpw==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071407"
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
Subject: [PATCH v4 31/31] clk: at91: at91sam9rl: switch to clk_parent_data
Date: Thu, 18 Sep 2025 14:16:13 -0700
Message-ID: <d244c34b4b074e7babfc72c20e3fc4e87ceba64d.1758226719.git.Ryan.Wanner@microchip.com>
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

Switch AT91SAM9RL clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/at91sam9rl.c | 49 +++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 0e8657aac491..a5cc0c1ed194 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -28,13 +28,12 @@ static const struct clk_pll_characteristics sam9rl_plla_characteristics = {
 	.out = sam9rl_plla_out,
 };
 
-static const struct {
+static struct {
 	char *n;
-	char *p;
 	u8 id;
 } at91sam9rl_systemck[] = {
-	{ .n = "pck0",  .p = "prog0",    .id = 8 },
-	{ .n = "pck1",  .p = "prog1",    .id = 9 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
 };
 
 static const struct {
@@ -68,8 +67,8 @@ static const struct {
 static void __init at91sam9rl_pmc_setup(struct device_node *np)
 {
 	const char *slck_name, *mainxtal_name;
+	struct clk_parent_data parent_data[6];
 	struct pmc_data *at91sam9rl_pmc;
-	const char *parent_names[6];
 	struct regmap *regmap;
 	struct clk_hw *hw;
 	int i;
@@ -95,13 +94,15 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	if (!at91sam9rl_pmc)
 		return;
 
-	hw = at91_clk_register_rm9200_main(regmap, "mainck", mainxtal_name, NULL);
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", NULL,
+					   &AT91_CLK_PD_NAME(mainxtal_name));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91sam9rl_pmc->chws[PMC_MAIN] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL,
+				   &AT91_CLK_PD_HW(at91sam9rl_pmc->chws[PMC_MAIN]), 0,
 				   &at91rm9200_pll_layout,
 				   &sam9rl_plla_characteristics);
 	if (IS_ERR(hw))
@@ -109,18 +110,19 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 
 	at91sam9rl_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck", NULL);
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", NULL,
+				    &AT91_CLK_PD_HW(at91sam9rl_pmc->chws[PMC_MAIN]));
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91sam9rl_pmc->chws[PMC_UTMI] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "pllack";
-	parent_names[3] = "utmick";
+	parent_data[0] = AT91_CLK_PD_NAME(slck_name);
+	parent_data[1] = AT91_CLK_PD_HW(at91sam9rl_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(at91sam9rl_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(at91sam9rl_pmc->chws[PMC_UTMI]);
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names, NULL,
+					   NULL, parent_data,
 					   &at91rm9200_master_layout,
 					   &sam9rl_mck_characteristics,
 					   &sam9rl_mck_lock);
@@ -128,7 +130,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL,
+					  NULL, &AT91_CLK_PD_HW(hw),
 					  &at91rm9200_master_layout,
 					  &sam9rl_mck_characteristics,
 					  &sam9rl_mck_lock, CLK_SET_RATE_GATE, 0);
@@ -137,18 +139,18 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 
 	at91sam9rl_pmc->chws[PMC_MCK] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "pllack";
-	parent_names[3] = "utmick";
-	parent_names[4] = "masterck_div";
+	parent_data[0] = AT91_CLK_PD_NAME(slck_name);
+	parent_data[1] = AT91_CLK_PD_HW(at91sam9rl_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(at91sam9rl_pmc->chws[PMC_PLLACK]);
+	parent_data[3] = AT91_CLK_PD_HW(at91sam9rl_pmc->chws[PMC_UTMI]);
+	parent_data[4] = AT91_CLK_PD_HW(at91sam9rl_pmc->chws[PMC_MCK]);
 	for (i = 0; i < 2; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 5, i,
+						    NULL, parent_data, 5, i,
 						    &at91rm9200_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -158,8 +160,8 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(at91sam9rl_systemck); i++) {
-		hw = at91_clk_register_system(regmap, at91sam9rl_systemck[i].n,
-					      at91sam9rl_systemck[i].p, NULL,
+		hw = at91_clk_register_system(regmap, at91sam9rl_systemck[i].n, NULL,
+					      &AT91_CLK_PD_HW(at91sam9rl_pmc->pchws[0]),
 					      at91sam9rl_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
@@ -170,7 +172,8 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91sam9rl_periphck); i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  at91sam9rl_periphck[i].n,
-						  "masterck_div", NULL,
+						  NULL,
+						  &AT91_CLK_PD_HW(at91sam9rl_pmc->chws[PMC_MCK]),
 						  at91sam9rl_periphck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
-- 
2.43.0


