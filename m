Return-Path: <linux-kernel+bounces-823641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D421B87117
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4938C7E0E28
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FEE2FE041;
	Thu, 18 Sep 2025 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="izRI1nMU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EE62FC007;
	Thu, 18 Sep 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230196; cv=none; b=nb8Wo35/elld/8CjcrdB1uNHJKypo7LL2ShdkkBl6reKNHno/KEJehcCn+6YOK2m46YKCMCTVljRP+x6V8a96lwFkzR0upEy0xU4k6Y4fyIlt0E0Hn9TP4vZ3fYlaQXX/y477BDpJkMcdmj0n/7WcqC8owR7/S+Hgm/6ReDe6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230196; c=relaxed/simple;
	bh=Wf79rFOX8K0bDHuXbUvrCx8GNF3GY+kFIQyuorcPp+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxrMUJ6FHULEbbH8d7Rmvlc4Q14UbaboxGAl+7vyXYbOr3k53YlygK9nsGf5tXfcPHNMs9/kZARqL02pubyW3YQbSfEzZMStD62InSNQiTUX+HAby+2IxT0++DWxgnhJVJPhgXJGl4X8rljiYC+hxEawth/7I99ICoqLdjKKT7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=izRI1nMU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230195; x=1789766195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wf79rFOX8K0bDHuXbUvrCx8GNF3GY+kFIQyuorcPp+E=;
  b=izRI1nMU26NQeNeQQU4NtTfRMbS6BmEN16jaNAnd2Ipf6uW3PcAtCfLl
   rRCZ8/FImNhfbR1zkemDqsciignUt+IcKjfXZSk555wFG9kuSAidDGRCK
   +m0VbnZa0wkkp5AK+8x4Pn+CzSePIQ2corDLSMR+84lmwkCc8L4+RAccJ
   NsAjIYNZbCU5646ZzVFMQXs4URGbJxfN4EouVKdCgQgAACKClUmlIPcQ+
   73IHJEB+2iqtyPvotz7FoD5jVRgV+9L+VrFBJhB1WoNNXlxNLuTl2MY7Q
   wn1OYmcN5W2bk3fzImJaVQeLM3S5cVBX2R3jrd5Pl5zIVs4cgxd4fAPb8
   Q==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: B/mbOGIqQf2w/Wtnudxn9Q==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071385"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 14:16:24 -0700
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
Subject: [PATCH v4 11/31] clk: at91: clk-usb: add support for clk_parent_data
Date: Thu, 18 Sep 2025 14:15:53 -0700
Message-ID: <6979b3734462c97381159f3968a3f22b6193e04d.1758226719.git.Ryan.Wanner@microchip.com>
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

Add support for clk_parent_data in usb clock driver.

All the SoC based drivers that rely on clk-usb were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Remove the use of __clk_get_hw() for the slow clocks.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
[ryan.wanner@microchip: Add SAMA7D65 and SAM9X75 SoCs to the changes.
Change how the main_xtal and slcks are initialized so they match the
parent_data API]
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/at91rm9200.c  |  2 +-
 drivers/clk/at91/at91sam9260.c |  2 +-
 drivers/clk/at91/at91sam9g45.c |  2 +-
 drivers/clk/at91/at91sam9n12.c |  2 +-
 drivers/clk/at91/at91sam9x5.c  |  2 +-
 drivers/clk/at91/clk-usb.c     | 41 ++++++++++++++++++++++------------
 drivers/clk/at91/dt-compat.c   |  6 ++---
 drivers/clk/at91/pmc.h         | 11 +++++----
 drivers/clk/at91/sam9x60.c     |  2 +-
 drivers/clk/at91/sam9x7.c      | 21 +++++++++--------
 drivers/clk/at91/sama5d2.c     |  2 +-
 drivers/clk/at91/sama5d3.c     |  2 +-
 drivers/clk/at91/sama5d4.c     |  2 +-
 drivers/clk/at91/sama7d65.c    | 24 +++++++++++---------
 14 files changed, 72 insertions(+), 49 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 3f19e737ae4d..e5a034f208d8 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -157,7 +157,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	at91rm9200_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", usb_div);
+	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", NULL, usb_div);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 0799a13060ea..ae6f126f204a 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -434,7 +434,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 	at91sam9260_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", usb_div);
+	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", NULL, usb_div);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index f45a7b80f7d8..684d2bcb36e8 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -176,7 +176,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 
 	parent_names[0] = "plladivck";
 	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
+	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 751786184ae2..9fc20b177b13 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -201,7 +201,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 
 	at91sam9n12_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91sam9n12_clk_register_usb(regmap, "usbck", "pllbck");
+	hw = at91sam9n12_clk_register_usb(regmap, "usbck", "pllbck", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 3b801d12fac0..5728cfb9036f 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -222,7 +222,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 
 	parent_names[0] = "plladivck";
 	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
+	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index b0696a928aa9..b2503fad4543 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -221,12 +221,12 @@ static const struct clk_ops at91sam9n12_usb_ops = {
 
 static struct clk_hw * __init
 _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
-			     const char **parent_names, u8 num_parents,
-			     u32 usbs_mask)
+			     const char **parent_names, struct clk_parent_data *parent_data,
+			     u8 num_parents, u32 usbs_mask)
 {
 	struct at91sam9x5_clk_usb *usb;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
@@ -235,7 +235,10 @@ _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &at91sam9x5_usb_ops;
-	init.parent_names = parent_names;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
+	else
+		init.parent_names = parent_names;
 	init.num_parents = num_parents;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
 		     CLK_SET_RATE_PARENT;
@@ -257,27 +260,30 @@ _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
-			    const char **parent_names, u8 num_parents)
+			    const char **parent_names, struct clk_parent_data *parent_data,
+			    u8 num_parents)
 {
 	return _at91sam9x5_clk_register_usb(regmap, name, parent_names,
-					    num_parents, SAM9X5_USBS_MASK);
+					    parent_data, num_parents, SAM9X5_USBS_MASK);
 }
 
 struct clk_hw * __init
 sam9x60_clk_register_usb(struct regmap *regmap, const char *name,
-			 const char **parent_names, u8 num_parents)
+			 const char **parent_names, struct clk_parent_data *parent_data,
+			 u8 num_parents)
 {
 	return _at91sam9x5_clk_register_usb(regmap, name, parent_names,
-					    num_parents, SAM9X60_USBS_MASK);
+					    parent_data, num_parents,
+					    SAM9X60_USBS_MASK);
 }
 
 struct clk_hw * __init
 at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
-			     const char *parent_name)
+			     const char *parent_name, struct clk_parent_data *parent_data)
 {
 	struct at91sam9x5_clk_usb *usb;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
@@ -286,7 +292,10 @@ at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &at91sam9n12_usb_ops;
-	init.parent_names = &parent_name;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT;
 
@@ -390,11 +399,12 @@ static const struct clk_ops at91rm9200_usb_ops = {
 
 struct clk_hw * __init
 at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
-			    const char *parent_name, const u32 *divisors)
+			    const char *parent_name, struct clk_parent_data *parent_data,
+			    const u32 *divisors)
 {
 	struct at91rm9200_clk_usb *usb;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
@@ -403,7 +413,10 @@ at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &at91rm9200_usb_ops;
-	init.parent_names = &parent_name;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_PARENT;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index f5a5f9ba7634..7883198f6a98 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -946,7 +946,7 @@ static void __init of_at91sam9x5_clk_usb_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91sam9x5_clk_register_usb(regmap, name, parent_names,
+	hw = at91sam9x5_clk_register_usb(regmap, name, parent_names, NULL,
 					 num_parents);
 	if (IS_ERR(hw))
 		return;
@@ -976,7 +976,7 @@ static void __init of_at91sam9n12_clk_usb_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91sam9n12_clk_register_usb(regmap, name, parent_name);
+	hw = at91sam9n12_clk_register_usb(regmap, name, parent_name, NULL);
 	if (IS_ERR(hw))
 		return;
 
@@ -1009,7 +1009,7 @@ static void __init of_at91rm9200_clk_usb_setup(struct device_node *np)
 	of_node_put(parent_np);
 	if (IS_ERR(regmap))
 		return;
-	hw = at91rm9200_clk_register_usb(regmap, name, parent_name, divisors);
+	hw = at91rm9200_clk_register_usb(regmap, name, parent_name, NULL, divisors);
 	if (IS_ERR(hw))
 		return;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 2aa84c49bd2f..84dc53849ae2 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -288,16 +288,19 @@ at91_clk_register_system(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
-			    const char **parent_names, u8 num_parents);
+			    const char **parent_names, struct clk_parent_data *parent_data,
+			    u8 num_parents);
 struct clk_hw * __init
 at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
-			     const char *parent_name);
+			     const char *parent_name, struct clk_parent_data *parent_data);
 struct clk_hw * __init
 sam9x60_clk_register_usb(struct regmap *regmap, const char *name,
-			 const char **parent_names, u8 num_parents);
+			 const char **parent_names, struct clk_parent_data *parent_data,
+			 u8 num_parents);
 struct clk_hw * __init
 at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
-			    const char *parent_name, const u32 *divisors);
+			    const char *parent_name, struct clk_parent_data *parent_data,
+			    const u32 *divisors);
 
 struct clk_hw * __init
 at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index bee35c65aceb..2ab7deab95f3 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -308,7 +308,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	parent_names[0] = "pllack_divck";
 	parent_names[1] = "upllck_divck";
 	parent_names[2] = "main_osc";
-	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, 3);
+	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, NULL, 3);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
index 0266119e125e..536f1271d62a 100644
--- a/drivers/clk/at91/sam9x7.c
+++ b/drivers/clk/at91/sam9x7.c
@@ -746,12 +746,12 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 	struct clk_range range = CLK_RANGE(0, 0);
 	const char *main_xtal_name, *td_slck_name, *md_slck_name;
 	struct pmc_data *sam9x7_pmc;
-	const char *parent_names[9];
 	void **clk_mux_buffer = NULL;
 	int clk_mux_buffer_size = 0;
 	struct regmap *regmap;
-	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
+	struct clk_hw *hw, *main_rc_hw, *main_osc_hw;
 	struct clk_hw *usbck_hw;
+	struct clk *main_xtal;
 	struct clk_parent_data parent_data[9];
 	int i, j;
 
@@ -816,18 +816,21 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 				switch (sam9x7_plls[i][j].p) {
 				case SAM9X7_PLL_PARENT_MAINCK:
 					parent_data[0] = AT91_CLK_PD_NAME("mainck");
-					hw = sam9x7_pmc->chws[PMC_MAIN];
+					parent_rate = clk_hw_get_rate(sam9x7_pmc->chws[PMC_MAIN]);
 					break;
 				case SAM9X7_PLL_PARENT_MAIN_XTAL:
+					main_xtal = of_clk_get_by_name(np, main_xtal_name);
+					if (IS_ERR(main_xtal))
+						goto err_free;
 					parent_data[0] = AT91_CLK_PD_NAME(main_xtal_name);
-					hw = main_xtal_hw;
+					parent_rate = clk_get_rate(main_xtal);
+					clk_put(main_xtal);
 					break;
 				default:
 					/* Should not happen. */
 					break;
 				}
 
-				parent_rate = clk_hw_get_rate(hw);
 				if (!parent_rate)
 					return;
 
@@ -882,10 +885,10 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 
 	sam9x7_pmc->chws[PMC_MCK] = hw;
 
-	parent_names[0] = "plla_divpmcck";
-	parent_names[1] = "upll_divpmcck";
-	parent_names[2] = "main_osc";
-	usbck_hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, 3);
+	parent_data[0] = AT91_CLK_PD_HW(sam9x7_plls[PLL_ID_PLLA][PLL_COMPID_DIV0].hw);
+	parent_data[1] = AT91_CLK_PD_HW(sam9x7_plls[PLL_ID_UPLL][PLL_COMPID_DIV0].hw);
+	parent_data[2] = AT91_CLK_PD_HW(main_osc_hw);
+	usbck_hw = sam9x60_clk_register_usb(regmap, "usbck", NULL, parent_data, 3);
 	if (IS_ERR(usbck_hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index c16594fce90c..8bbc34e22cda 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -284,7 +284,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 	parent_names[0] = "plladivck";
 	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
+	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 522ce6031446..05d0cdd22bc4 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -201,7 +201,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 
 	parent_names[0] = "plladivck";
 	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
+	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 160c0bddb6a3..da84b4cef827 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -222,7 +222,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 
 	parent_names[0] = "plladivck";
 	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
+	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
index faad4fd28e85..986e8ef57dea 100644
--- a/drivers/clk/at91/sama7d65.c
+++ b/drivers/clk/at91/sama7d65.c
@@ -1095,11 +1095,11 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 {
 	const char *main_xtal_name, *md_slck_name, *td_slck_name;
 	struct pmc_data *sama7d65_pmc;
-	const char *parent_names[11];
 	void **alloc_mem = NULL;
 	int alloc_mem_size = 0;
+	struct clk *main_xtal;
 	struct regmap *regmap;
-	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
+	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *usbck_hw;
 	struct clk_parent_data parent_data[10];
 	bool bypass;
 	int i, j;
@@ -1169,17 +1169,21 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 				switch (sama7d65_plls[i][j].p) {
 				case SAMA7D65_PLL_PARENT_MAINCK:
 					parent_data[0] = AT91_CLK_PD_NAME("mainck");
-					hw = sama7d65_pmc->chws[PMC_MAIN];
+					parent_rate = clk_hw_get_rate(sama7d65_pmc->chws[PMC_MAIN]);
 					break;
 				case SAMA7D65_PLL_PARENT_MAIN_XTAL:
+					main_xtal = of_clk_get_by_name(np, main_xtal_name);
+					if (IS_ERR(main_xtal))
+						goto err_free;
 					parent_data[0] = AT91_CLK_PD_NAME(main_xtal_name);
-					hw = main_xtal_hw;
+					parent_rate = clk_get_rate(main_xtal);
+					clk_put(main_xtal);
 					break;
 				default:
 					/* Should not happen. */
 					break;
 				}
-				parent_rate = clk_hw_get_rate(hw);
+
 				if (!parent_rate)
 					return;
 
@@ -1263,11 +1267,11 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 			sama7d65_pmc->chws[sama7d65_mckx[i].eid] = hw;
 	}
 
-	parent_names[0] = "syspll_divpmcck";
-	parent_names[1] = "usbpll_divpmcck";
-	parent_names[2] = "main_osc";
-	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, 3);
-	if (IS_ERR(hw))
+	parent_data[0] = AT91_CLK_PD_HW(sama7d65_plls[PLL_ID_SYS][PLL_COMPID_DIV0].hw);
+	parent_data[1] = AT91_CLK_PD_HW(sama7d65_plls[PLL_ID_USB][PLL_COMPID_DIV0].hw);
+	parent_data[2] = AT91_CLK_PD_HW(main_osc_hw);
+	usbck_hw = sam9x60_clk_register_usb(regmap, "usbck", NULL, parent_data, 3);
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
 	parent_data[0] = AT91_CLK_PD_NAME(md_slck_name);
-- 
2.43.0


