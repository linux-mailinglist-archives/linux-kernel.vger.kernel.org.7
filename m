Return-Path: <linux-kernel+bounces-726395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9B2B00CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D875461D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FCF30B9AC;
	Thu, 10 Jul 2025 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KvxFMzt9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FF8309A48;
	Thu, 10 Jul 2025 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178088; cv=none; b=RUCGbrXm5slsqJZ9xydI+AdFhXdFR+5Hp5/81Fg6PgY/c3w1RF8p5Qldad+45O/EWeoW74CFRe0uv9PFKrrbmf5ZEIqAOfu4TAqaA+yXx2tkWc2J4qHmo0nC1DBkjAUle41q5g3W0rcBKeifDfWp6hvjU+xh517T44oeCJP3xqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178088; c=relaxed/simple;
	bh=owdPZnRoPKIwHIIAcZxPhYP6ytN4Vl0rCVFo5X3uR4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpgzDpFsB3PAgc9NZQBhCffSCgAP8pJe3duMe0KJFZOcrxeynFT6t50NQEWOik3QRYQI+ngdzkhIkmgSEKRbyvePj04Ve9l90bOFstGFnJ2Lxcm581M0TQ6zor7DRJu6mefZJN9octXiPNH4ISXdkUNT7haXKVTbjtJY3xq1fis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KvxFMzt9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752178086; x=1783714086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=owdPZnRoPKIwHIIAcZxPhYP6ytN4Vl0rCVFo5X3uR4o=;
  b=KvxFMzt9MvEkq7Eft0Eyn9mlU16Jet4qoEn+yAe1nfLPVT4wKd4p2glq
   mLYICHYUyLuWvWx4I4mYhQ6XAMoUlRcGMXh9EdtVkgyWmDw2H/Kb30N8I
   PdsQ6oy4cquBl/Yvi0kWra+No1COgTLv6mqc9u/ikfPhR3jSQG8Gq98Dc
   2+Sai31IvhOcsliF+J6glOAYQHd4EJTjbFxJ795HJAB1GT1qw8iywigKK
   UrPervkIulgz/Ozlao5QUWagb282gL0HnKjsyGBbwGI+DgUCjpTtgb/R3
   a8qAk0DZEy1YSum8KFYcFP9WAZ+e1mkeNmhZj2VV4VwKZ/rxygFCtUs1x
   Q==;
X-CSE-ConnectionGUID: VcY24SkbRKSMnNSaLxS1vA==
X-CSE-MsgGUID: 2nNU0MMmSIekTXqw/NQoKA==
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="44448163"
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
Subject: [PATCH v3 08/32] clk: at91: clk-master: use clk_parent_data
Date: Thu, 10 Jul 2025 13:07:01 -0700
Message-ID: <4b404eaaab4062464a4142e95aaa76d5cba866f0.1752176711.git.Ryan.Wanner@microchip.com>
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

The md_slck name and index are added for the SAM9X75 SoC so the
clk-master can properly use parent_data.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
[ryan.wanner@microchip.com: Add clk-master changes to SAM9X75 and
SAMA7D65 SoCs. As well as add md_slck commit message.]
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/clk-master.c | 24 ++++++++++++------------
 drivers/clk/at91/pmc.h        |  6 +++---
 drivers/clk/at91/sam9x7.c     | 19 ++++++++++---------
 drivers/clk/at91/sama7d65.c   | 23 ++++++++++-------------
 drivers/clk/at91/sama7g5.c    | 29 +++++++++++++----------------
 5 files changed, 48 insertions(+), 53 deletions(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 7a544e429d34..cc4f3beb51e5 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -473,7 +473,7 @@ static struct clk_hw * __init
 at91_clk_register_master_internal(struct regmap *regmap,
 		const char *name, int num_parents,
 		const char **parent_names,
-		struct clk_hw **parent_hws,
+		struct clk_parent_data *parent_data,
 		const struct clk_master_layout *layout,
 		const struct clk_master_characteristics *characteristics,
 		const struct clk_ops *ops, spinlock_t *lock, u32 flags)
@@ -485,7 +485,7 @@ at91_clk_register_master_internal(struct regmap *regmap,
 	unsigned long irqflags;
 	int ret;
 
-	if (!name || !num_parents || !(parent_names || parent_hws) || !lock)
+	if (!name || !num_parents || !(parent_names || parent_data) || !lock)
 		return ERR_PTR(-EINVAL);
 
 	master = kzalloc(sizeof(*master), GFP_KERNEL);
@@ -494,8 +494,8 @@ at91_clk_register_master_internal(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = ops;
-	if (parent_hws)
-		init.parent_hws = (const struct clk_hw **)parent_hws;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
 	else
 		init.parent_names = parent_names;
 	init.num_parents = num_parents;
@@ -531,13 +531,13 @@ struct clk_hw * __init
 at91_clk_register_master_pres(struct regmap *regmap,
 		const char *name, int num_parents,
 		const char **parent_names,
-		struct clk_hw **parent_hws,
+		struct clk_parent_data *parent_data,
 		const struct clk_master_layout *layout,
 		const struct clk_master_characteristics *characteristics,
 		spinlock_t *lock)
 {
 	return at91_clk_register_master_internal(regmap, name, num_parents,
-						 parent_names, parent_hws, layout,
+						 parent_names, parent_data, layout,
 						 characteristics,
 						 &master_pres_ops,
 						 lock, CLK_SET_RATE_GATE);
@@ -546,7 +546,7 @@ at91_clk_register_master_pres(struct regmap *regmap,
 struct clk_hw * __init
 at91_clk_register_master_div(struct regmap *regmap,
 		const char *name, const char *parent_name,
-		struct clk_hw *parent_hw, const struct clk_master_layout *layout,
+		struct clk_parent_data *parent_data, const struct clk_master_layout *layout,
 		const struct clk_master_characteristics *characteristics,
 		spinlock_t *lock, u32 flags, u32 safe_div)
 {
@@ -560,7 +560,7 @@ at91_clk_register_master_div(struct regmap *regmap,
 
 	hw = at91_clk_register_master_internal(regmap, name, 1,
 					       parent_name ? &parent_name : NULL,
-					       parent_hw ? &parent_hw : NULL, layout,
+					       parent_data, layout,
 					       characteristics, ops,
 					       lock, flags);
 
@@ -812,7 +812,7 @@ struct clk_hw * __init
 at91_clk_sama7g5_register_master(struct regmap *regmap,
 				 const char *name, int num_parents,
 				 const char **parent_names,
-				 struct clk_hw **parent_hws,
+				 struct clk_parent_data *parent_data,
 				 u32 *mux_table,
 				 spinlock_t *lock, u8 id,
 				 bool critical, int chg_pid)
@@ -824,7 +824,7 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
 	unsigned int val;
 	int ret;
 
-	if (!name || !num_parents || !(parent_names || parent_hws) || !mux_table ||
+	if (!name || !num_parents || !(parent_names || parent_data) || !mux_table ||
 	    !lock || id > MASTER_MAX_ID)
 		return ERR_PTR(-EINVAL);
 
@@ -834,8 +834,8 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &sama7g5_master_ops;
-	if (parent_hws)
-		init.parent_hws = (const struct clk_hw **)parent_hws;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
 	else
 		init.parent_names = parent_names;
 	init.num_parents = num_parents;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index d9a04fddb0b1..54d472276fc9 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -204,14 +204,14 @@ at91_clk_register_sam9x5_main(struct regmap *regmap, const char *name,
 struct clk_hw * __init
 at91_clk_register_master_pres(struct regmap *regmap, const char *name,
 			      int num_parents, const char **parent_names,
-			      struct clk_hw **parent_hws,
+			      struct clk_parent_data *parent_data,
 			      const struct clk_master_layout *layout,
 			      const struct clk_master_characteristics *characteristics,
 			      spinlock_t *lock);
 
 struct clk_hw * __init
 at91_clk_register_master_div(struct regmap *regmap, const char *name,
-			     const char *parent_names, struct clk_hw *parent_hw,
+			     const char *parent_names, struct clk_parent_data *parent_data,
 			     const struct clk_master_layout *layout,
 			     const struct clk_master_characteristics *characteristics,
 			     spinlock_t *lock, u32 flags, u32 safe_div);
@@ -220,7 +220,7 @@ struct clk_hw * __init
 at91_clk_sama7g5_register_master(struct regmap *regmap,
 				 const char *name, int num_parents,
 				 const char **parent_names,
-				 struct clk_hw **parent_hws, u32 *mux_table,
+				 struct clk_parent_data *parent_data, u32 *mux_table,
 				 spinlock_t *lock, u8 id, bool critical,
 				 int chg_pid);
 
diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
index eaae05ba21ad..945983f72140 100644
--- a/drivers/clk/at91/sam9x7.c
+++ b/drivers/clk/at91/sam9x7.c
@@ -739,7 +739,8 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 {
 	struct clk_range range = CLK_RANGE(0, 0);
 	const char *main_xtal_name = "main_xtal";
-	u8 main_xtal_index = 2;
+	const char *const md_slck_name = "md_slck";
+	u8 md_slck_index = 1, main_xtal_index = 2;
 	struct pmc_data *sam9x7_pmc;
 	const char *parent_names[9];
 	void **clk_mux_buffer = NULL;
@@ -747,12 +748,12 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 	struct regmap *regmap;
 	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
 	struct clk_hw *td_slck_hw, *md_slck_hw, *usbck_hw;
-	struct clk_parent_data parent_data[2];
+	struct clk_parent_data parent_data[9];
 	struct clk_hw *parent_hws[9];
 	int i, j;
 
 	td_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "td_slck"));
-	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, "md_slck"));
+	md_slck_hw = __clk_get_hw(of_clk_get_by_name(np, md_slck_name));
 	main_xtal_hw = __clk_get_hw(of_clk_get_by_name(np, main_xtal_name));
 
 	if (!td_slck_hw || !md_slck_hw || !main_xtal_hw)
@@ -853,18 +854,18 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 		}
 	}
 
-	parent_hws[0] = md_slck_hw;
-	parent_hws[1] = sam9x7_pmc->chws[PMC_MAIN];
-	parent_hws[2] = sam9x7_plls[PLL_ID_PLLA][PLL_COMPID_DIV0].hw;
-	parent_hws[3] = sam9x7_plls[PLL_ID_UPLL][PLL_COMPID_DIV0].hw;
+	parent_data[0] = AT91_CLK_PD_NAME(md_slck_name, md_slck_index);
+	parent_data[1] = AT91_CLK_PD_HW(sam9x7_pmc->chws[PMC_MAIN]);
+	parent_data[2] = AT91_CLK_PD_HW(sam9x7_plls[PLL_ID_PLLA][PLL_COMPID_DIV0].hw);
+	parent_data[3] = AT91_CLK_PD_HW(sam9x7_plls[PLL_ID_UPLL][PLL_COMPID_DIV0].hw);
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   NULL, parent_hws, &sam9x7_master_layout,
+					   NULL, parent_data, &sam9x7_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  NULL, hw, &sam9x7_master_layout,
+					  NULL, &AT91_CLK_PD_HW(hw), &sam9x7_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
index 1d461db0438f..174b2317081f 100644
--- a/drivers/clk/at91/sama7d65.c
+++ b/drivers/clk/at91/sama7d65.c
@@ -1089,16 +1089,16 @@ static const struct clk_pcr_layout sama7d65_pcr_layout = {
 
 static void __init sama7d65_pmc_setup(struct device_node *np)
 {
-	const char *main_xtal_name = "main_xtal";
-	u8 main_xtal_index = 2;
+	u8 td_slck_index = 0, md_slck_index = 1, main_xtal_index = 2;
+	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
+	const char * const main_xtal_name = "main_xtal";
+	struct clk_parent_data parent_data[10];
 	struct pmc_data *sama7d65_pmc;
 	const char *parent_names[11];
 	void **alloc_mem = NULL;
 	int alloc_mem_size = 0;
 	struct regmap *regmap;
-	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *main_xtal_hw;
 	struct clk_hw *td_slck_hw, *md_slck_hw;
-	struct clk_parent_data parent_data[2];
 	struct clk_hw *parent_hws[10];
 	bool bypass;
 	int i, j;
@@ -1207,7 +1207,7 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 	}
 
 	hw = at91_clk_register_master_div(regmap, "mck0", NULL,
-					  sama7d65_plls[PLL_ID_CPU][1].hw,
+					  &AT91_CLK_PD_HW(sama7d65_plls[PLL_ID_CPU][1].hw),
 					  &mck0_layout, &mck0_characteristics,
 					  &pmc_mck0_lock, CLK_GET_RATE_NOCACHE, 5);
 	if (IS_ERR(hw))
@@ -1216,12 +1216,11 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 	sama7d65_pmc->chws[PMC_MCK] = hw;
 	sama7d65_mckx[PCK_PARENT_HW_MCK0].hw = hw;
 
-	parent_hws[0] = md_slck_hw;
-	parent_hws[1] = td_slck_hw;
-	parent_hws[2] = sama7d65_pmc->chws[PMC_MAIN];
+	parent_data[0] = AT91_CLK_PD_NAME("md_slck", md_slck_index);
+	parent_data[1] = AT91_CLK_PD_NAME("td_slck", td_slck_index);
+	parent_data[2] = AT91_CLK_PD_HW(sama7d65_pmc->chws[PMC_MAIN]);
 	for (i = PCK_PARENT_HW_MCK1; i < ARRAY_SIZE(sama7d65_mckx); i++) {
 		u8 num_parents = 3 + sama7d65_mckx[i].ep_count;
-		struct clk_hw *tmp_parent_hws[8];
 		u32 *mux_table;
 
 		mux_table = kmalloc_array(num_parents, sizeof(*mux_table),
@@ -1238,13 +1237,11 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 			u8 pll_id = sama7d65_mckx[i].ep[j].pll_id;
 			u8 pll_compid = sama7d65_mckx[i].ep[j].pll_compid;
 
-			tmp_parent_hws[j] = sama7d65_plls[pll_id][pll_compid].hw;
+			parent_data[3 + j] = AT91_CLK_PD_HW(sama7d65_plls[pll_id][pll_compid].hw);
 		}
-		PMC_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
-			       sama7d65_mckx[i].ep_count);
 
 		hw = at91_clk_sama7g5_register_master(regmap, sama7d65_mckx[i].n,
-						      num_parents, NULL, parent_hws,
+						      num_parents, NULL, parent_data,
 						      mux_table, &pmc_mckX_lock,
 						      sama7d65_mckx[i].id,
 						      sama7d65_mckx[i].c,
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index c4723b875a1d..263cdfc0858c 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -969,17 +969,17 @@ static const struct clk_pcr_layout sama7g5_pcr_layout = {
 
 static void __init sama7g5_pmc_setup(struct device_node *np)
 {
-	const char *main_xtal_name = "main_xtal";
-	u8 main_xtal_index = 2;
-	struct pmc_data *sama7g5_pmc;
-	void **alloc_mem = NULL;
-	int alloc_mem_size = 0;
-	struct regmap *regmap;
+	u8 td_slck_index = 0, md_slck_index = 1, main_xtal_index = 2;
+	const char * const main_xtal_name = "main_xtal";
 	struct clk_hw *hw, *main_rc_hw, *main_osc_hw;
+	struct clk_parent_data parent_data[10];
 	struct clk_hw *td_slck_hw, *md_slck_hw;
-	struct clk_parent_data parent_data[2];
 	struct clk_hw *parent_hws[10];
+	struct pmc_data *sama7g5_pmc;
+	void **alloc_mem = NULL;
+	int alloc_mem_size = 0;
 	struct clk *main_xtal;
+	struct regmap *regmap;
 	bool bypass;
 	int i, j;
 
@@ -1089,7 +1089,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 	}
 
 	hw = at91_clk_register_master_div(regmap, "mck0", NULL,
-					  sama7g5_plls[PLL_ID_CPU][1].hw,
+					  &AT91_CLK_PD_HW(sama7g5_plls[PLL_ID_CPU][1].hw),
 					  &mck0_layout, &mck0_characteristics,
 					  &pmc_mck0_lock, CLK_GET_RATE_NOCACHE, 5);
 	if (IS_ERR(hw))
@@ -1097,12 +1097,11 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 	sama7g5_mckx[PCK_PARENT_HW_MCK0].hw = sama7g5_pmc->chws[PMC_MCK] = hw;
 
-	parent_hws[0] = md_slck_hw;
-	parent_hws[1] = td_slck_hw;
-	parent_hws[2] = sama7g5_pmc->chws[PMC_MAIN];
+	parent_data[0] = AT91_CLK_PD_NAME("md_slck", md_slck_index);
+	parent_data[1] = AT91_CLK_PD_NAME("td_slck", td_slck_index);
+	parent_data[2] = AT91_CLK_PD_HW(sama7g5_pmc->chws[PMC_MAIN]);
 	for (i = PCK_PARENT_HW_MCK1; i < ARRAY_SIZE(sama7g5_mckx); i++) {
 		u8 num_parents = 3 + sama7g5_mckx[i].ep_count;
-		struct clk_hw *tmp_parent_hws[8];
 		u32 *mux_table;
 
 		mux_table = kmalloc_array(num_parents, sizeof(*mux_table),
@@ -1117,13 +1116,11 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 			u8 pll_id = sama7g5_mckx[i].ep[j].pll_id;
 			u8 pll_compid = sama7g5_mckx[i].ep[j].pll_compid;
 
-			tmp_parent_hws[j] = sama7g5_plls[pll_id][pll_compid].hw;
+			parent_data[3 + j] = AT91_CLK_PD_HW(sama7g5_plls[pll_id][pll_compid].hw);
 		}
-		PMC_FILL_TABLE(&parent_hws[3], tmp_parent_hws,
-			       sama7g5_mckx[i].ep_count);
 
 		hw = at91_clk_sama7g5_register_master(regmap, sama7g5_mckx[i].n,
-				   num_parents, NULL, parent_hws, mux_table,
+				   num_parents, NULL, parent_data, mux_table,
 				   &pmc_mckX_lock, sama7g5_mckx[i].id,
 				   sama7g5_mckx[i].c,
 				   sama7g5_mckx[i].ep_chg_id);
-- 
2.43.0


