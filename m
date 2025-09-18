Return-Path: <linux-kernel+bounces-823643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D103EB87120
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835E31C86032
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A383131B120;
	Thu, 18 Sep 2025 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Nrlwr765"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106162FD1B2;
	Thu, 18 Sep 2025 21:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230198; cv=none; b=mFmCoq2h3GrbIRjL7g0ENSJzaUr8X09Xq6RpiiUgEBtCgv904Fp9X7t4ASi4YeYZ4SVba5zaE2ci/zAFGXdZBvCrflMpXRL1dCayDy4zV5eJmGOibQNCW/lBeuxjaB6iw+qAY66Dq6eXDDthkIg1wly5lsF2z3oCFGjtxHzlnEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230198; c=relaxed/simple;
	bh=crCaMaSWmdFRamt2gOK8NsRYsA2FYBdVL6EFcIXUhYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFIJJH1En783bMa1iISifcZpPzcgmINrb8Y1aFmAIkwH8piyRJRqr4aPLCw5geuIbzcT4sUttWYi2q8ehCZGp9DB93h6xFXdWsSLJMQcP33iEm5P0Mjm88g7JKm+dj7XxO8vDNIhgy/ua0n/A+VDe1RAkJUmSaxjLrdOHeyFkoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Nrlwr765; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230197; x=1789766197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=crCaMaSWmdFRamt2gOK8NsRYsA2FYBdVL6EFcIXUhYQ=;
  b=Nrlwr765mqomGpYRgZSbRFhE6SVJE47FrEZglrjdosDj8yukEkJFwn2T
   FgfV4LtJ7WUrD9W1VJuqCWi2yQl1WQxe1QIXqf5HaxgXm612BqP5qhtVR
   L5HqbImDX2gpK0Vj49drOVeBKch6H61+0PG2cg6+erMazZIqLEuo2gY2t
   Y0Wh/HEZ3YbFYOFW7TenvY7gNp/sWVryx5ROS14ThTbK1Bet/RMbV5PQw
   p4WQWbppVGFyUf29lZggqkqOwAMduWgxPbGKFKfXOEPNcDVNzTwgGE7GL
   fgNbK3fSMZhcmIj5WY456vzG+GqkmaUb5IYu+z0i/b2rJ9K29Y4rJFOLy
   Q==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: n94q5wq5R9aAaD4TEZQ/3Q==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071388"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 14:16:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 14:15:52 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 14:15:52 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <varshini.rajendran@microchip.com>
Subject: [PATCH v4 14/31] clk: at91: clk-pll: add support for parent_hw
Date: Thu, 18 Sep 2025 14:15:56 -0700
Message-ID: <50f2f18fb795c6f1e11073ba6ebe61cee9386433.1758226719.git.Ryan.Wanner@microchip.com>
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

Add support for parent_hw in pll clock driver. With this parent-child
relation is described with pointers rather than strings making
registration a bit faster.

All the SoC based drivers that rely on clk-pll were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/at91rm9200.c  | 4 ++--
 drivers/clk/at91/at91sam9260.c | 4 ++--
 drivers/clk/at91/at91sam9g45.c | 2 +-
 drivers/clk/at91/at91sam9n12.c | 4 ++--
 drivers/clk/at91/at91sam9rl.c  | 2 +-
 drivers/clk/at91/at91sam9x5.c  | 2 +-
 drivers/clk/at91/clk-pll.c     | 9 ++++++---
 drivers/clk/at91/dt-compat.c   | 2 +-
 drivers/clk/at91/pmc.h         | 2 +-
 drivers/clk/at91/sama5d2.c     | 2 +-
 drivers/clk/at91/sama5d3.c     | 2 +-
 drivers/clk/at91/sama5d4.c     | 2 +-
 12 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index e5a034f208d8..623e232ec9c6 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -119,7 +119,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	at91rm9200_pmc->chws[PMC_MAIN] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
 				   &at91rm9200_pll_layout,
 				   &rm9200_pll_characteristics);
 	if (IS_ERR(hw))
@@ -127,7 +127,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	at91rm9200_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", 1,
+	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", NULL, 1,
 				   &at91rm9200_pll_layout,
 				   &rm9200_pll_characteristics);
 	if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index ae6f126f204a..f39deb3ec00a 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -395,7 +395,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 		slck_name = slowxtal_name;
 	}
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
 				   data->plla_layout,
 				   data->plla_characteristics);
 	if (IS_ERR(hw))
@@ -403,7 +403,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 	at91sam9260_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", 1,
+	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", NULL, 1,
 				   data->pllb_layout,
 				   data->pllb_characteristics);
 	if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index 684d2bcb36e8..3436a09a6e8a 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -134,7 +134,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 
 	at91sam9g45_pmc->chws[PMC_MAIN] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
 				   &at91rm9200_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 9fc20b177b13..80ccd4a49df3 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -160,7 +160,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 
 	at91sam9n12_pmc->chws[PMC_MAIN] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
 				   &at91rm9200_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
@@ -171,7 +171,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 
 	at91sam9n12_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", 1,
+	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", NULL, 1,
 				   &at91rm9200_pll_layout, &pllb_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 969f809e7d65..0e8657aac491 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -101,7 +101,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 
 	at91sam9rl_pmc->chws[PMC_MAIN] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
 				   &at91rm9200_pll_layout,
 				   &sam9rl_plla_characteristics);
 	if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 5728cfb9036f..6b8c755fefdf 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -182,7 +182,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 
 	at91sam9x5_pmc->chws[PMC_MAIN] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
 				   &at91rm9200_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 249d6a53cedf..f973c3b1bbec 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -310,13 +310,13 @@ static const struct clk_ops pll_ops = {
 
 struct clk_hw * __init
 at91_clk_register_pll(struct regmap *regmap, const char *name,
-		      const char *parent_name, u8 id,
+		      const char *parent_name, struct clk_parent_data *parent_data, u8 id,
 		      const struct clk_pll_layout *layout,
 		      const struct clk_pll_characteristics *characteristics)
 {
 	struct clk_pll *pll;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int offset = PLL_REG(id);
 	unsigned int pllr;
 	int ret;
@@ -330,7 +330,10 @@ at91_clk_register_pll(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &pll_ops;
-	init.parent_names = &parent_name;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_GATE;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 7883198f6a98..2c5faa3b1cfd 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -665,7 +665,7 @@ of_at91_clk_pll_setup(struct device_node *np,
 	if (!characteristics)
 		return;
 
-	hw = at91_clk_register_pll(regmap, name, parent_name, id, layout,
+	hw = at91_clk_register_pll(regmap, name, parent_name, NULL, id, layout,
 				   characteristics);
 	if (IS_ERR(hw))
 		goto out_free_characteristics;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index d6ba32e348ba..b983e44b742a 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -241,7 +241,7 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 
 struct clk_hw * __init
 at91_clk_register_pll(struct regmap *regmap, const char *name,
-		      const char *parent_name, u8 id,
+		      const char *parent_name, struct clk_parent_data *parent_data, u8 id,
 		      const struct clk_pll_layout *layout,
 		      const struct clk_pll_characteristics *characteristics);
 struct clk_hw * __init
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 8bbc34e22cda..bc62b9ed4ea0 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -215,7 +215,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 	sama5d2_pmc->chws[PMC_MAIN] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
 				   &sama5d3_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 05d0cdd22bc4..9d86c350a1e7 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -161,7 +161,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
 				   &sama5d3_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index da84b4cef827..8491b1e0391d 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -176,7 +176,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
 				   &sama5d3_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
-- 
2.43.0


