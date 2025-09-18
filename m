Return-Path: <linux-kernel+bounces-823632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BFDB870D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441001C8594E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0292FB0BB;
	Thu, 18 Sep 2025 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SUzgkUZc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711132E0905;
	Thu, 18 Sep 2025 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230191; cv=none; b=jAnKkLWfhOJIsjVeFzA7uJ2ofroxVQHepQgxsOV6cTXnlPTqgFTnRV6/nvtKMVDcB/P3w+4aUUNRK1UJapN+ddSMtA6bsoes44flRbtZvMYEW+8cS+x7MNuOlxXCI1gbAy0pIVbxNZBW7+sLfVPD2FtLkVoHTwx5qjesWFwjy6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230191; c=relaxed/simple;
	bh=c4Gn9p0qYQJUQcD3GCxEYQYm9cnkaiQMPpmWCJHuy3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekFAJrlq0kYq1tOpskMzyv1VJEcbecyM4g4kZgvuitSgvceIUdz40TxF98H5yeJXCsZd5bhWvauWPYTF9qGU/B2s5bMhW/SqUUFZ/90Tz8wqvFbXbxDQ2pgCM9WiC+veRI6Fh4rTM3e0fiHOLoy7K3SJ1wN8h9Li+KacktivAFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SUzgkUZc; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230190; x=1789766190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c4Gn9p0qYQJUQcD3GCxEYQYm9cnkaiQMPpmWCJHuy3c=;
  b=SUzgkUZcW5V+DjdPMM1PuQ1xvhPg89aV+wZK7RhxwNArQMokgpc6OzCJ
   GXDRQGkPiIqW9DBrGNCs2q45orR6QObElIqhY23XmUxBQTK7X/m0LH5cA
   YhuiVjJkDzQz2IFT5JBN/DiDnxFZqk+guLQZWY2ubcdDFi5JTL75HCoyw
   xW5DV/Ps7hL55SaQEGUd5vNwWqCJDbKTvzzVD7kngLTscbQVthSSKNROz
   J4rAOxl5sKMbwogGUEudGQaXqw/Wo1GPX0IAtek7je81xgbLgrNIBpUSW
   TZaSllCERCfTG9Y7UdVBcOHwwptLZFUTRbP3imhb50WterFHxrmLmEsBZ
   w==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: IKJ+PEi9TmWU1HZZ0Omi+w==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071378"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 14:16:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 14:15:51 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 14:15:51 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <varshini.rajendran@microchip.com>
Subject: [PATCH v4 04/31] clk: at91: clk-sam9x60-pll: use clk_parent_data
Date: Thu, 18 Sep 2025 14:15:46 -0700
Message-ID: <259824455f5325b35d0fb85163866a81ff24304e.1758226719.git.Ryan.Wanner@microchip.com>
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

Use struct clk_parent_data instead of struct parent_hw as this leads
to less usage of __clk_get_hw() in SoC specific clock drivers and simpler
conversion of existing SoC specific clock drivers from parent_names to
modern clk_parent_data structures. As clk-sam9x60-pll need to know
parent's rate at initialization we pass it now from SoC specific drivers.
This will lead in the end at removing __clk_get_hw() in SoC specific
drivers (that will be solved by subsequent commits).

Get the main_xtal name via of_clk_get_parent_name() to consistently get
the correct name for the main_xtal.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
[ryan.wanner@microchip.com: Add SAMA7D65 and SAM9X75 SoCs to the change set.]
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 14 +++++---------
 drivers/clk/at91/pmc.h             |  5 +++--
 drivers/clk/at91/sam9x60.c         |  8 +++++---
 drivers/clk/at91/sam9x7.c          | 16 +++++++++++-----
 drivers/clk/at91/sama7d65.c        | 25 ++++++++++++++-----------
 drivers/clk/at91/sama7g5.c         | 26 +++++++++++++++-----------
 6 files changed, 53 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 3dc75a394ce1..9895881c67d7 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -630,19 +630,19 @@ static const struct clk_ops sam9x60_fixed_div_pll_ops = {
 
 struct clk_hw * __init
 sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
-			      const char *name, const char *parent_name,
-			      struct clk_hw *parent_hw, u8 id,
+			      const char *name, const struct clk_parent_data *parent_data,
+			      unsigned long parent_rate, u8 id,
 			      const struct clk_pll_characteristics *characteristics,
 			      const struct clk_pll_layout *layout, u32 flags)
 {
 	struct sam9x60_frac *frac;
 	struct clk_hw *hw;
 	struct clk_init_data init = {};
-	unsigned long parent_rate, irqflags;
+	unsigned long irqflags;
 	unsigned int val;
 	int ret;
 
-	if (id > PLL_MAX_ID || !lock || !parent_hw)
+	if (id > PLL_MAX_ID || !lock || !parent_data)
 		return ERR_PTR(-EINVAL);
 
 	frac = kzalloc(sizeof(*frac), GFP_KERNEL);
@@ -650,10 +650,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	if (parent_name)
-		init.parent_names = &parent_name;
-	else
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	init.parent_data = (const struct clk_parent_data *)parent_data;
 	init.num_parents = 1;
 	if (flags & CLK_SET_RATE_GATE)
 		init.ops = &sam9x60_frac_pll_ops;
@@ -684,7 +681,6 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 		 * its rate leading to enabling this PLL with unsupported
 		 * rate. This will lead to PLL not being locked at all.
 		 */
-		parent_rate = clk_hw_get_rate(parent_hw);
 		if (!parent_rate) {
 			hw = ERR_PTR(-EINVAL);
 			goto free;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 16c2559889aa..d3fc38cf90eb 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -258,8 +258,9 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 
 struct clk_hw * __init
 sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
-			      const char *name, const char *parent_name,
-			      struct clk_hw *parent_hw, u8 id,
+			      const char *name,
+			      const struct clk_parent_data *parent_data,
+			      unsigned long parent_rate, u8 id,
 			      const struct clk_pll_characteristics *characteristics,
 			      const struct clk_pll_layout *layout, u32 flags);
 
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 18baf4a256f4..bee35c65aceb 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -242,7 +242,8 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	sam9x60_pmc->chws[PMC_MAIN] = hw;
 
 	hw = sam9x60_clk_register_frac_pll(regmap, &pmc_pll_lock, "pllack_fracck",
-					   "mainck", sam9x60_pmc->chws[PMC_MAIN],
+					   &AT91_CLK_PD_HW(sam9x60_pmc->chws[PMC_MAIN]),
+					   clk_hw_get_rate(sam9x60_pmc->chws[PMC_MAIN]),
 					   0, &plla_characteristics,
 					   &pll_frac_layout,
 					   /*
@@ -268,8 +269,9 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	sam9x60_pmc->chws[PMC_PLLACK] = hw;
 
 	hw = sam9x60_clk_register_frac_pll(regmap, &pmc_pll_lock, "upllck_fracck",
-					   "main_osc", main_osc_hw, 1,
-					   &upll_characteristics,
+					   &AT91_CLK_PD_HW(main_osc_hw),
+					   clk_hw_get_rate(main_osc_hw),
+					   1, &upll_characteristics,
 					   &pll_frac_layout, CLK_SET_RATE_GATE);
 	if (IS_ERR(hw))
 		goto err_free;
diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
index cb5849da494f..c80306715d90 100644
--- a/drivers/clk/at91/sam9x7.c
+++ b/drivers/clk/at91/sam9x7.c
@@ -752,6 +752,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 	struct regmap *regmap;
 	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
 	struct clk_hw *td_slck_hw, *md_slck_hw, *usbck_hw;
+	static struct clk_parent_data parent_data;
 	struct clk_hw *parent_hws[9];
 	int i, j;
 
@@ -799,7 +800,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < PLL_ID_MAX; i++) {
 		for (j = 0; j < PLL_COMPID_MAX; j++) {
-			struct clk_hw *parent_hw;
+			unsigned long parent_rate;
 
 			if (!sam9x7_plls[i][j].n)
 				continue;
@@ -808,21 +809,26 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 			case PLL_TYPE_FRAC:
 				switch (sam9x7_plls[i][j].p) {
 				case SAM9X7_PLL_PARENT_MAINCK:
-					parent_hw = sam9x7_pmc->chws[PMC_MAIN];
+					parent_data = AT91_CLK_PD_NAME("mainck");
+					hw = sam9x7_pmc->chws[PMC_MAIN];
 					break;
 				case SAM9X7_PLL_PARENT_MAIN_XTAL:
-					parent_hw = main_xtal_hw;
+					parent_data = AT91_CLK_PD_NAME(main_xtal_name);
+					hw = main_xtal_hw;
 					break;
 				default:
 					/* Should not happen. */
-					parent_hw = NULL;
 					break;
 				}
 
+				parent_rate = clk_hw_get_rate(hw);
+				if (!parent_rate)
+					return;
+
 				hw = sam9x60_clk_register_frac_pll(regmap,
 								   &pmc_pll_lock,
 								   sam9x7_plls[i][j].n,
-								   NULL, parent_hw, i,
+								   &parent_data, parent_rate, i,
 								   sam9x7_plls[i][j].c,
 								   sam9x7_plls[i][j].l,
 								   sam9x7_plls[i][j].f);
diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
index ec2ef1a0249a..6229b7dfbea1 100644
--- a/drivers/clk/at91/sama7d65.c
+++ b/drivers/clk/at91/sama7d65.c
@@ -1093,7 +1093,7 @@ static const struct clk_pcr_layout sama7d65_pcr_layout = {
 
 static void __init sama7d65_pmc_setup(struct device_node *np)
 {
-	const char *main_xtal_name = "main_xtal";
+	const char *main_xtal_name;
 	struct pmc_data *sama7d65_pmc;
 	const char *parent_names[11];
 	void **alloc_mem = NULL;
@@ -1108,10 +1108,11 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 
 	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
 	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
-	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
+	i = of_property_match_string(np, "clock-names", "main_xtal");
 
-	if (!td_slck_hw || !md_slck_hw || !main_xtal_hw)
+	if (!td_slck_hw || !md_slck_hw || !i)
 		return;
+	main_xtal_name = of_clk_get_parent_name(np, i);
 
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
@@ -1137,10 +1138,8 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	parent_data.name = main_xtal_name;
-	parent_data.fw_name = main_xtal_name;
 	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
-						 &parent_data, bypass);
+						 &AT91_CLK_PD_NAME(main_xtal_name), bypass);
 	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
@@ -1154,7 +1153,7 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < PLL_ID_MAX; i++) {
 		for (j = 0; j < PLL_COMPID_MAX; j++) {
-			struct clk_hw *parent_hw;
+			unsigned long parent_rate;
 
 			if (!sama7d65_plls[i][j].n)
 				continue;
@@ -1163,20 +1162,24 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 			case PLL_TYPE_FRAC:
 				switch (sama7d65_plls[i][j].p) {
 				case SAMA7D65_PLL_PARENT_MAINCK:
-					parent_hw = sama7d65_pmc->chws[PMC_MAIN];
+					parent_data = AT91_CLK_PD_NAME("mainck");
+					hw = sama7d65_pmc->chws[PMC_MAIN];
 					break;
 				case SAMA7D65_PLL_PARENT_MAIN_XTAL:
-					parent_hw = main_xtal_hw;
+					parent_data = AT91_CLK_PD_NAME(main_xtal_name);
+					hw = main_xtal_hw;
 					break;
 				default:
 					/* Should not happen. */
-					parent_hw = NULL;
 					break;
 				}
+				parent_rate = clk_hw_get_rate(hw);
+				if (!parent_rate)
+					return;
 
 				hw = sam9x60_clk_register_frac_pll(regmap,
 					&pmc_pll_lock, sama7d65_plls[i][j].n,
-					NULL, parent_hw, i,
+					&parent_data, parent_rate, i,
 					sama7d65_plls[i][j].c,
 					sama7d65_plls[i][j].l,
 					sama7d65_plls[i][j].f);
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 713f5dfe7be2..654c9f43fcf8 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -971,7 +971,7 @@ static const struct clk_pcr_layout sama7g5_pcr_layout = {
 
 static void __init sama7g5_pmc_setup(struct device_node *np)
 {
-	const char *main_xtal_name = "main_xtal";
+	const char *main_xtal_name;
 	struct pmc_data *sama7g5_pmc;
 	void **alloc_mem = NULL;
 	int alloc_mem_size = 0;
@@ -985,10 +985,11 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
 	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
-	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
+	i = of_property_match_string(np, "clock-names", "main_xtal");
 
-	if (!td_slck_hw || !md_slck_hw || !main_xtal_hw)
+	if (!td_slck_hw || !md_slck_hw || !i)
 		return;
+	main_xtal_name = of_clk_get_parent_name(np, i);
 
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
@@ -1014,10 +1015,8 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	parent_data.name = main_xtal_name;
-	parent_data.fw_name = main_xtal_name;
 	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
-						 &parent_data, bypass);
+						 &AT91_CLK_PD_NAME(main_xtal_name), bypass);
 	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
@@ -1031,7 +1030,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < PLL_ID_MAX; i++) {
 		for (j = 0; j < PLL_COMPID_MAX; j++) {
-			struct clk_hw *parent_hw;
+			unsigned long parent_rate;
 
 			if (!sama7g5_plls[i][j].n)
 				continue;
@@ -1040,20 +1039,25 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 			case PLL_TYPE_FRAC:
 				switch (sama7g5_plls[i][j].p) {
 				case SAMA7G5_PLL_PARENT_MAINCK:
-					parent_hw = sama7g5_pmc->chws[PMC_MAIN];
+					parent_data = AT91_CLK_PD_NAME("mainck");
+					hw = sama7g5_pmc->chws[PMC_MAIN];
 					break;
 				case SAMA7G5_PLL_PARENT_MAIN_XTAL:
-					parent_hw = main_xtal_hw;
+					parent_data = AT91_CLK_PD_NAME(main_xtal_name);
+					hw = main_xtal_hw;
 					break;
 				default:
 					/* Should not happen. */
-					parent_hw = NULL;
 					break;
 				}
 
+				parent_rate = clk_hw_get_rate(hw);
+				if (!parent_rate)
+					return;
+
 				hw = sam9x60_clk_register_frac_pll(regmap,
 					&pmc_pll_lock, sama7g5_plls[i][j].n,
-					NULL, parent_hw, i,
+					&parent_data, parent_rate, i,
 					sama7g5_plls[i][j].c,
 					sama7g5_plls[i][j].l,
 					sama7g5_plls[i][j].f);
-- 
2.43.0


