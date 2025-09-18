Return-Path: <linux-kernel+bounces-823648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCFDB87138
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C5C1C87764
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2337D31E8A8;
	Thu, 18 Sep 2025 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LotrB3mO"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE96D313D42;
	Thu, 18 Sep 2025 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230201; cv=none; b=YiaWj205ybM3J9SXIhHNFRlnCua/dwin3jgRAFc3m6+Kdg3zh+SXMQQJE23l0jvI+vBnhqto7Ukv7PidmgeLosOuIHtlA7QxYWS5RocqKt7S/P9yuGJfdxVfM5AzrRRx7Xwupzr+Z8Rhc4sAJ8HlcdqU8kG0HXHPZCs6HTpa+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230201; c=relaxed/simple;
	bh=exJ53jdmPDn4o8MZUDqAr7iOCtElm6cqfxMbjBXrCww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpNWbJuHXow6XsPp7rPhYhfn7toJUxcIrF2NGWfKaEb9cS2vpOw+fyqLtxkIlqYf22cJABuhh+dIli3Dsb+Scdwl1eYp4yEzchF+RQnJ2xblsbFxKJ+E3879EyTh19l2GY5iCRgHqw6CQosTbk/5QUA0YAAiNiPWmQ48kddFA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LotrB3mO; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230199; x=1789766199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=exJ53jdmPDn4o8MZUDqAr7iOCtElm6cqfxMbjBXrCww=;
  b=LotrB3mO4aPsj9f6mkS3CHVU3lVMhiuiVKCxinHnHUNsuJyWfqBMrYyP
   YW3H9bCKWwlE9n4pPp9aL4RvAC+pCZmcBHYp+0ykIjqagogeNcYS3uPUj
   fxZlMfa+iZORiuaqg91+cs9zIpTCfHygA2AT7QpzWUXpbj1VRLJl4vzBQ
   4z7PFZHlQHndjmDAex5NXQMR+j4VgdEmAimi87H4zPkCwJ/agFYfkieZ2
   /m3czrtcPNVaJgRGtNUtHVsvMNr+JS24s5i1eoDHWrNHkNUYjjKKmv+wi
   sDOzBbxJK/GZN7iHe+wOqQNXeoh7Kg8hYMdEzItkNX3mNJxtSq+BnlL4X
   Q==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: bluABRnfTUWYvZa/ZQ2CVg==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071394"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 14:16:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 14:15:53 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 14:15:53 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <varshini.rajendran@microchip.com>
Subject: [PATCH v4 19/31] clk: at91: clk-smd: add support for clk_parent_data
Date: Thu, 18 Sep 2025 14:16:01 -0700
Message-ID: <4e3f834e6901f7fcad0e697b56c85573c8e7ae52.1758226719.git.Ryan.Wanner@microchip.com>
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

Add support for parent_hw in smd clock drivers.
With this parent-child relation is described with pointers rather
than strings making registration a bit faster.

All the SoC based drivers that rely on clk-smd were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/at91sam9x5.c |  2 +-
 drivers/clk/at91/clk-smd.c    | 10 +++++++---
 drivers/clk/at91/dt-compat.c  |  2 +-
 drivers/clk/at91/pmc.h        |  3 ++-
 drivers/clk/at91/sama5d3.c    |  2 +-
 drivers/clk/at91/sama5d4.c    |  2 +-
 6 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 37280852f086..13331e015dd7 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -226,7 +226,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_names, 2);
+	hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/clk-smd.c b/drivers/clk/at91/clk-smd.c
index 09c649c8598e..d53dc32b36be 100644
--- a/drivers/clk/at91/clk-smd.c
+++ b/drivers/clk/at91/clk-smd.c
@@ -111,11 +111,12 @@ static const struct clk_ops at91sam9x5_smd_ops = {
 
 struct clk_hw * __init
 at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
-			    const char **parent_names, u8 num_parents)
+			    const char **parent_names, struct clk_parent_data *parent_data,
+			    u8 num_parents)
 {
 	struct at91sam9x5_clk_smd *smd;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	smd = kzalloc(sizeof(*smd), GFP_KERNEL);
@@ -124,7 +125,10 @@ at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &at91sam9x5_smd_ops;
-	init.parent_names = parent_names;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
+	else
+		init.parent_names = parent_names;
 	init.num_parents = num_parents;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 2b1aa834f111..5afd7c9f53fd 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -859,7 +859,7 @@ static void __init of_at91sam9x5_clk_smd_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	hw = at91sam9x5_clk_register_smd(regmap, name, parent_names,
+	hw = at91sam9x5_clk_register_smd(regmap, name, parent_names, NULL,
 					 num_parents);
 	if (IS_ERR(hw))
 		return;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 0a03e44237f1..e16621e01678 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -280,7 +280,8 @@ at91_clk_register_sam9260_slow(struct regmap *regmap,
 
 struct clk_hw * __init
 at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
-			    const char **parent_names, u8 num_parents);
+			    const char **parent_names, struct clk_parent_data *parent_data,
+			    u8 num_parents);
 
 struct clk_hw * __init
 at91_clk_register_system(struct regmap *regmap, const char *name,
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 7f2ac8f648dd..8326bb6a291c 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -205,7 +205,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_names, 2);
+	hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 04c848cd7001..1ff9286148da 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -228,7 +228,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 
 	parent_names[0] = "plladivck";
 	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_names, 2);
+	hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_names, NULL, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
-- 
2.43.0


