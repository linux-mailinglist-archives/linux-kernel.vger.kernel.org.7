Return-Path: <linux-kernel+bounces-823640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69969B87114
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 354DA7BE7B0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F962FE063;
	Thu, 18 Sep 2025 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UkHHHz07"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9112F3620;
	Thu, 18 Sep 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230196; cv=none; b=N6IGnlwp9U/uLc/8FMX6lt5T1YcInzWuQnl854wd8ibTwY0ANE+n5/TPI5DNMrJWbwObKMMs12pHliXtN8x/YdoIwYu6Lhdehfa2xnL+uQYK2nJneuEld0tVlvp1gE81JUXoyn9WCxBhLl0QQiCufyX3bsBsNxRvMcWF6CyzhrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230196; c=relaxed/simple;
	bh=jzw7cbv8gGSdDKCkOVCyqm1lNPDSOzs55ychUDzk7Aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AezpkY9r8x0yRg8LrRXIE+aGwwiUeDuv8o34cebDKhKcN6goNeHIVjLCajBYwI1heZ2SBZDsdErX1ljjAdjkcChULuVVgbl/TXnCnNxB0VN3WHC67zCgiu1j+GNdoYwTqG891oXSUu5D35W2I9g1eWiyDAxvRjDg19mzbpmG/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UkHHHz07; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230195; x=1789766195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jzw7cbv8gGSdDKCkOVCyqm1lNPDSOzs55ychUDzk7Aw=;
  b=UkHHHz07vQr9XBQTx4uwis64ioryqqSo2xdtKSGeQEDe7IrLUI3Y2UjT
   4gmHJKPQN0dguAOINB79QukIGO92BKkJCS0EXV7ZJuQG3BS7+uu2OZckY
   mhfP8TPE4xR6/jeS26v0U6p6XFaYeR28/mU5GeDghUQXPicPz+Uo6Ovw0
   GM7mSNDL1hJ7pKSWTpVZ+YzN1R8NOKasJnAAZeW6Mjf+7SfuaEjQ4wpFv
   cj3lx+/9vDTi1lU78kwk4tdBTfNIKbY+blm14s5HIc3RU3DWSHU6XQJkq
   nL6tfUnxL8FPYjYVUaiXUPWzBg0O33/c0/UwbHFaQRs33ZeSj3A/E1sAC
   A==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: XNbh6R03R9SLup+zPIhyOQ==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071386"
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
Subject: [PATCH v4 12/31] clk: at91: clk-system: use clk_parent_data
Date: Thu, 18 Sep 2025 14:15:54 -0700
Message-ID: <333d27a5ffdfd18a4dffd501aad7e8dcc3ff3b28.1758226719.git.Ryan.Wanner@microchip.com>
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
modern clk_parent_data structures.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
[ryan.wanner@microchip: Update SAM9X75 clk-system to use parent_data.]
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/clk-system.c | 8 ++++----
 drivers/clk/at91/pmc.h        | 2 +-
 drivers/clk/at91/sam9x7.c     | 2 +-
 drivers/clk/at91/sama7g5.c    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
index 90eed39d0785..55f8e46fe9c7 100644
--- a/drivers/clk/at91/clk-system.c
+++ b/drivers/clk/at91/clk-system.c
@@ -105,7 +105,7 @@ static const struct clk_ops system_ops = {
 
 struct clk_hw * __init
 at91_clk_register_system(struct regmap *regmap, const char *name,
-			 const char *parent_name, struct clk_hw *parent_hw, u8 id,
+			 const char *parent_name, struct clk_parent_data *parent_data, u8 id,
 			 unsigned long flags)
 {
 	struct clk_system *sys;
@@ -113,7 +113,7 @@ at91_clk_register_system(struct regmap *regmap, const char *name,
 	struct clk_init_data init = {};
 	int ret;
 
-	if (!(parent_name || parent_hw) || id > SYSTEM_MAX_ID)
+	if (!(parent_name || parent_data) || id > SYSTEM_MAX_ID)
 		return ERR_PTR(-EINVAL);
 
 	sys = kzalloc(sizeof(*sys), GFP_KERNEL);
@@ -122,8 +122,8 @@ at91_clk_register_system(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &system_ops;
-	if (parent_hw)
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
 	else
 		init.parent_names = &parent_name;
 	init.num_parents = 1;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 84dc53849ae2..d6ba32e348ba 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -283,7 +283,7 @@ at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91_clk_register_system(struct regmap *regmap, const char *name,
-			 const char *parent_name, struct clk_hw *parent_hw,
+			 const char *parent_name, struct clk_parent_data *parent_data,
 			 u8 id, unsigned long flags);
 
 struct clk_hw * __init
diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
index 536f1271d62a..9262875c414b 100644
--- a/drivers/clk/at91/sam9x7.c
+++ b/drivers/clk/at91/sam9x7.c
@@ -921,7 +921,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 	sam9x7_systemck[3].parent_hw = sam9x7_pmc->pchws[1];
 	for (i = 0; i < ARRAY_SIZE(sam9x7_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sam9x7_systemck[i].n,
-					      NULL, sam9x7_systemck[i].parent_hw,
+					      NULL, &AT91_CLK_PD_HW(sam9x7_systemck[i].parent_hw),
 					      sam9x7_systemck[i].id,
 					      sam9x7_systemck[i].flags);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index ddbf69beb495..c8219fbd5d1a 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1175,7 +1175,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(sama7g5_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama7g5_systemck[i].n,
-					      NULL, sama7g5_pmc->pchws[i],
+					      NULL, &AT91_CLK_PD_HW(sama7g5_pmc->pchws[i]),
 					      sama7g5_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
-- 
2.43.0


