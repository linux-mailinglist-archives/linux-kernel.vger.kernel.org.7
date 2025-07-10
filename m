Return-Path: <linux-kernel+bounces-726391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8370AB00CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623511C210C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEC8309A58;
	Thu, 10 Jul 2025 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d+uFLcZm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA9C307AFC;
	Thu, 10 Jul 2025 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178085; cv=none; b=UO6/JOXr7cmMEk5M2skRAaqU7aOwMjVNTaS2dA0eal4lwEZdTKdPTwIIzlhjsz9dbroReBoK5ceepj9WUqtqiQuQ5QaNs/8JFtugAMmcz6vp0pqsMFUV9xBOE+sfC1uV2JS8aJYDrH7VPAChflN77SdU8+N1TqGqr0JkUsjad5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178085; c=relaxed/simple;
	bh=B32xddJoeeIpwlgISm5VVZTX+V+01ZDyEYAj5zmF75c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEfD8sXdxs4J4zwNQUkaOMYbCjb3G0Z/JwVBMT3rIFv+BDPYpWGZ5SU1wqxVUCygdTy9P2TT22aNvHf9e6o2F3pAjNP8hZTekuXsxMhITQ3q2dxRXc5iErDOs2WrZFanC6+0WinsH24oeYF1z7yalsl+94Dovl43mov2rxheD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d+uFLcZm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752178084; x=1783714084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B32xddJoeeIpwlgISm5VVZTX+V+01ZDyEYAj5zmF75c=;
  b=d+uFLcZmSt/xjDvnZNXPIUbeuX2cUAEONNcJ7Fikr9h6chXwX1WP482R
   vXv+SplriUflUuvGuGnrUWYD3Z8EUNp/9eenqChbkAVK0IEKMHX46CKLI
   zrKQ0ryAMwlgeONW05zmp51ekNm5S3XfLVLNRoDwozc4yUG4Zb1cwHnKz
   Kgqp0LZOL+9dMxejNhczmFKYCG8FqTiGwZKQK/qbSZrdFI5AFf+3PKW4N
   HlmjvTXPabLYPP4cf4/oJYh9yPbsaRdYxdu5yRbeQm3p2Hjx7MdzvSsBQ
   ZgEo65n1ta6vrr/rcRMttvIgXwDdE07jWheVAVBLOPE+4y/P2CoUjfpD3
   A==;
X-CSE-ConnectionGUID: VcY24SkbRKSMnNSaLxS1vA==
X-CSE-MsgGUID: RDyBJja1Qm2UNq4ITe+UrQ==
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="44448160"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 13:07:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 10 Jul 2025 13:07:30 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 10 Jul 2025 13:07:30 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <varshini.rajendran@microchip.com>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robh@kernel.org>
Subject: [PATCH v3 05/32] clk: at91: clk-peripheral: switch to clk_parent_data
Date: Thu, 10 Jul 2025 13:06:58 -0700
Message-ID: <657143d460ed5f2f726413385895c0c80ddddef9.1752176711.git.Ryan.Wanner@microchip.com>
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

Use struct clk_parent_data instead of parent_hw for peripheral clocks.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
[ryan.wanner@microchip.com: Add SAMA7D65 and SAM9X7 SoCs to the use the
structs.]
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/clk-peripheral.c | 16 ++++++++--------
 drivers/clk/at91/pmc.h            |  4 ++--
 drivers/clk/at91/sam9x7.c         |  2 +-
 drivers/clk/at91/sama7d65.c       |  2 +-
 drivers/clk/at91/sama7g5.c        |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index c173a44c800a..ed97b3c0a66b 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -97,7 +97,7 @@ static const struct clk_ops peripheral_ops = {
 
 struct clk_hw * __init
 at91_clk_register_peripheral(struct regmap *regmap, const char *name,
-			     const char *parent_name, struct clk_hw *parent_hw,
+			     const char *parent_name, struct clk_parent_data *parent_data,
 			     u32 id)
 {
 	struct clk_peripheral *periph;
@@ -105,7 +105,7 @@ at91_clk_register_peripheral(struct regmap *regmap, const char *name,
 	struct clk_hw *hw;
 	int ret;
 
-	if (!name || !(parent_name || parent_hw) || id > PERIPHERAL_ID_MAX)
+	if (!name || !(parent_name || parent_data) || id > PERIPHERAL_ID_MAX)
 		return ERR_PTR(-EINVAL);
 
 	periph = kzalloc(sizeof(*periph), GFP_KERNEL);
@@ -114,8 +114,8 @@ at91_clk_register_peripheral(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &peripheral_ops;
-	if (parent_hw)
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
 	else
 		init.parent_names = &parent_name;
 	init.num_parents = 1;
@@ -448,7 +448,7 @@ struct clk_hw * __init
 at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 				    const struct clk_pcr_layout *layout,
 				    const char *name, const char *parent_name,
-				    struct clk_hw *parent_hw,
+				    struct clk_parent_data *parent_data,
 				    u32 id, const struct clk_range *range,
 				    int chg_pid, unsigned long flags)
 {
@@ -457,7 +457,7 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 	struct clk_hw *hw;
 	int ret;
 
-	if (!name || !(parent_name || parent_hw))
+	if (!name || !(parent_name || parent_data))
 		return ERR_PTR(-EINVAL);
 
 	periph = kzalloc(sizeof(*periph), GFP_KERNEL);
@@ -465,8 +465,8 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	if (parent_hw)
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
 	else
 		init.parent_names = &parent_name;
 	init.num_parents = 1;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index b43f6652417f..b6f2aca1e1fd 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -226,13 +226,13 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
 
 struct clk_hw * __init
 at91_clk_register_peripheral(struct regmap *regmap, const char *name,
-			     const char *parent_name, struct clk_hw *parent_hw,
+			     const char *parent_name, struct clk_parent_data *parent_data,
 			     u32 id);
 struct clk_hw * __init
 at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 				    const struct clk_pcr_layout *layout,
 				    const char *name, const char *parent_name,
-				    struct clk_hw *parent_hw,
+				    struct clk_parent_data *parent_data,
 				    u32 id, const struct clk_range *range,
 				    int chg_pid, unsigned long flags);
 
diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
index edd5fd3a1fa5..d7dc5f381ebe 100644
--- a/drivers/clk/at91/sam9x7.c
+++ b/drivers/clk/at91/sam9x7.c
@@ -922,7 +922,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sam9x7_pcr_layout,
 							 sam9x7_periphck[i].n,
-							 NULL, sam9x7_pmc->chws[PMC_MCK],
+							 NULL, &AT91_CLK_PD_HW(sam9x7_pmc->chws[PMC_MCK]),
 							 sam9x7_periphck[i].id,
 							 &range, INT_MIN,
 							 sam9x7_periphck[i].f);
diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
index 17725c175d3b..372e530f4107 100644
--- a/drivers/clk/at91/sama7d65.c
+++ b/drivers/clk/at91/sama7d65.c
@@ -1306,7 +1306,7 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 							 &sama7d65_pcr_layout,
 							 sama7d65_periphck[i].n,
 							 NULL,
-							 sama7d65_mckx[sama7d65_periphck[i].p].hw,
+							 &AT91_CLK_PD_HW(sama7d65_mckx[sama7d65_periphck[i].p].hw),
 							 sama7d65_periphck[i].id,
 							 &sama7d65_periphck[i].r,
 							 sama7d65_periphck[i].chgp ? 0 :
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 733e4fc6a515..f28fe419ae5e 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1181,7 +1181,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 						&sama7g5_pcr_layout,
 						sama7g5_periphck[i].n,
 						NULL,
-						sama7g5_mckx[sama7g5_periphck[i].p].hw,
+						&AT91_CLK_PD_HW(sama7g5_mckx[sama7g5_periphck[i].p].hw),
 						sama7g5_periphck[i].id,
 						&sama7g5_periphck[i].r,
 						sama7g5_periphck[i].chgp ? 0 :
-- 
2.43.0


