Return-Path: <linux-kernel+bounces-726394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC0BB00CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398BF1650EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C832730AAA7;
	Thu, 10 Jul 2025 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nhbQfC4K"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE473093DC;
	Thu, 10 Jul 2025 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178087; cv=none; b=YiASM4vq/ZNu7P/67Um5r6WSM70Yx6k+X8ZPcYSGPKKbVfh8R2RyUTgnU0UUx396kCcLX84Vqvq2daTBeJOKWB6titKJfh/kQOpdfckAv9GMJgrsqc1KcdQgGl3stIxIghSO9mHj46+u7X8tTXZvQ/0DB0QX+7SKJ6U1Tpe6FIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178087; c=relaxed/simple;
	bh=dmzN3tRvPXgb2oYN28OMYdlKH9V2K993WYw3DJZgQsc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiPE2ccB81eZDUZ/LDSdL+j1gxWWbIyxhDa2gKvyVf63zHOMnfm/xZLtil0HkF+nQKWzjy6qq4e/Ei3KAcrY5X1+OsqWYxMGTsIEtO8HuM/wClzRopU8u/kxBkbb+tkWxt3AMRI8ehCjAwWy1BrDJMfy2o0UEq2MS55TOptC5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nhbQfC4K; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752178085; x=1783714085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dmzN3tRvPXgb2oYN28OMYdlKH9V2K993WYw3DJZgQsc=;
  b=nhbQfC4K8Umq9CI4OJ5S8YYggGmLY+pCqaiyn3tZ8XC0qCcaPcTgUz0N
   v/IXy+EYtWCYqVWDTAnz1Cb0VdfdXlCyaB29rI7iXPdDc144MXUr6nCVE
   J+FyTI4cNj8+PqmkgsUAFH3jolk5mMQfHy3B8NZqccN86rzqbCsq55kmB
   J8Y7G8WNpoMHA0zelfuOLReR+LS6K92EI0xQNZlyN5xp1J4Map/fVYtXx
   miXGnYs6vL1kgp3n9HRexDMilTh8HVb8XiZVgZTxiZnGcwn6SCLpXw0Zo
   JuFWJcaDGeKGMsN9dw6BMQOzSkm+dE+s5lcPbptbeDJ+gYz7T0VxTO9J+
   g==;
X-CSE-ConnectionGUID: VcY24SkbRKSMnNSaLxS1vA==
X-CSE-MsgGUID: 6JFHviJmS2WLjHH68bd+dg==
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="44448162"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 13:07:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 10 Jul 2025 13:07:31 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 10 Jul 2025 13:07:31 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <varshini.rajendran@microchip.com>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robh@kernel.org>
Subject: [PATCH v3 07/32] clk: at91: clk-utmi: use clk_parent_data
Date: Thu, 10 Jul 2025 13:07:00 -0700
Message-ID: <04739269232f6c7ffbe9308a2b993e6b6eb883c8.1752176711.git.Ryan.Wanner@microchip.com>
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

Use struct clk_parent_data instead of struct parent_hw as this leads
to less usage of __clk_get_hw() in SoC specific clock drivers and simpler
conversion of existing SoC specific clock drivers from parent_names to
modern clk_parent_data structures.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/clk-utmi.c | 16 ++++++++--------
 drivers/clk/at91/pmc.h      |  4 ++--
 drivers/clk/at91/sama7g5.c  | 25 +++++++++++++++----------
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
index b991180beea1..38ffe4d712a5 100644
--- a/drivers/clk/at91/clk-utmi.c
+++ b/drivers/clk/at91/clk-utmi.c
@@ -144,7 +144,7 @@ static struct clk_hw * __init
 at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
 				struct regmap *regmap_sfr,
 				const char *name, const char *parent_name,
-				struct clk_hw *parent_hw,
+				struct clk_parent_data *parent_data,
 				const struct clk_ops *ops, unsigned long flags)
 {
 	struct clk_utmi *utmi;
@@ -152,7 +152,7 @@ at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
 	struct clk_init_data init = {};
 	int ret;
 
-	if (!(parent_name || parent_hw))
+	if (!(parent_name || parent_data))
 		return ERR_PTR(-EINVAL);
 
 	utmi = kzalloc(sizeof(*utmi), GFP_KERNEL);
@@ -161,8 +161,8 @@ at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
 
 	init.name = name;
 	init.ops = ops;
-	if (parent_hw)
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
 	else
 		init.parent_names = &parent_name;
 	init.num_parents = 1;
@@ -185,10 +185,10 @@ at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
 struct clk_hw * __init
 at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
 		       const char *name, const char *parent_name,
-		       struct clk_hw *parent_hw)
+		       struct clk_parent_data *parent_data)
 {
 	return at91_clk_register_utmi_internal(regmap_pmc, regmap_sfr, name,
-			parent_name, parent_hw, &utmi_ops, CLK_SET_RATE_GATE);
+			parent_name, parent_data, &utmi_ops, CLK_SET_RATE_GATE);
 }
 
 static int clk_utmi_sama7g5_prepare(struct clk_hw *hw)
@@ -287,8 +287,8 @@ static const struct clk_ops sama7g5_utmi_ops = {
 
 struct clk_hw * __init
 at91_clk_sama7g5_register_utmi(struct regmap *regmap_pmc, const char *name,
-			       const char *parent_name, struct clk_hw *parent_hw)
+			       const char *parent_name, struct clk_parent_data *parent_data)
 {
 	return at91_clk_register_utmi_internal(regmap_pmc, NULL, name,
-			parent_name, parent_hw, &sama7g5_utmi_ops, 0);
+			parent_name, parent_data, &sama7g5_utmi_ops, 0);
 }
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index e32a5e85d08f..d9a04fddb0b1 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -299,10 +299,10 @@ at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
 struct clk_hw * __init
 at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
 		       const char *name, const char *parent_name,
-		       struct clk_hw *parent_hw);
+		       struct clk_parent_data *parent_data);
 
 struct clk_hw * __init
 at91_clk_sama7g5_register_utmi(struct regmap *regmap, const char *name,
-			       const char *parent_name, struct clk_hw *parent_hw);
+			       const char *parent_name, struct clk_parent_data *parent_data);
 
 #endif /* __PMC_H_ */
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index f816a5551277..c4723b875a1d 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -975,30 +975,33 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	void **alloc_mem = NULL;
 	int alloc_mem_size = 0;
 	struct regmap *regmap;
-	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
+	struct clk_hw *hw, *main_rc_hw, *main_osc_hw;
 	struct clk_hw *td_slck_hw, *md_slck_hw;
 	struct clk_parent_data parent_data[2];
 	struct clk_hw *parent_hws[10];
+	struct clk *main_xtal;
 	bool bypass;
 	int i, j;
 
 	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
 	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
-	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
+	if (!td_slck_hw || !md_slck_hw)
+		return;
 
-	if (!td_slck_hw || !md_slck_hw || !main_xtal_hw)
+	main_xtal = of_clk_get(np, main_xtal_index);
+	if (IS_ERR(main_xtal))
 		return;
 
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
-		return;
+		goto put_main_xtal;
 
 	sama7g5_pmc = pmc_data_allocate(PMC_MCK1 + 1,
 					nck(sama7g5_systemck),
 					nck(sama7g5_periphck),
 					nck(sama7g5_gck), 8);
 	if (!sama7g5_pmc)
-		return;
+		goto put_main_xtal;
 
 	alloc_mem = kmalloc(sizeof(void *) *
 			    (ARRAY_SIZE(sama7g5_mckx) + ARRAY_SIZE(sama7g5_gck)),
@@ -1039,19 +1042,18 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 				switch (sama7g5_plls[i][j].p) {
 				case SAMA7G5_PLL_PARENT_MAINCK:
 					parent_data[0] = AT91_CLK_PD_NAME("mainck", -1);
-					hw = sama7g5_pmc->chws[PMC_MAIN];
+					parent_rate = clk_hw_get_rate(sama7g5_pmc->chws[PMC_MAIN]);
 					break;
 				case SAMA7G5_PLL_PARENT_MAIN_XTAL:
 					parent_data[0] = AT91_CLK_PD_NAME(main_xtal_name,
 									  main_xtal_index);
-					hw = main_xtal_hw;
+					parent_rate = clk_get_rate(main_xtal);
 					break;
 				default:
 					/* Should not happen. */
 					break;
 				}
 
-				parent_rate = clk_hw_get_rate(hw);
 				if (!parent_rate)
 					return;
 
@@ -1135,7 +1137,8 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 			sama7g5_pmc->chws[sama7g5_mckx[i].eid] = hw;
 	}
 
-	hw = at91_clk_sama7g5_register_utmi(regmap, "utmick", NULL, main_xtal_hw);
+	hw = at91_clk_sama7g5_register_utmi(regmap, "utmick", NULL,
+					    &AT91_CLK_PD_NAME(main_xtal_name, main_xtal_index));
 	if (IS_ERR(hw))
 		goto err_free;
 
@@ -1233,7 +1236,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 	of_clk_add_hw_provider(np, of_clk_hw_pmc_get, sama7g5_pmc);
 
-	return;
+	goto put_main_xtal;
 
 err_free:
 	if (alloc_mem) {
@@ -1243,6 +1246,8 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	}
 
 	kfree(sama7g5_pmc);
+put_main_xtal:
+	clk_put(main_xtal);
 }
 
 /* Some clks are used for a clocksource */
-- 
2.43.0


