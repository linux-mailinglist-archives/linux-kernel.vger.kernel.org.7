Return-Path: <linux-kernel+bounces-823647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B35B87135
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65127E1206
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A071631E8AA;
	Thu, 18 Sep 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="REjeozVB"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB9930EF97;
	Thu, 18 Sep 2025 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230200; cv=none; b=lDwq8wL7wWpS9OWk6ZvAWPfz+NqsW8lfRrEzS1FHQeAwhONavgjEiETKYyYTKq9eDKvmRQLeBCiS0+BbwQsI1BfWlPcpEpXal3DVKadl5QQR2621Q2cPrKjBGXAV5hVeEwp/dFYTokfTA62E6lkUMVat96vGqFZ++AerT0bMSI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230200; c=relaxed/simple;
	bh=4kVZWG6e0OXi5wjRbH85D47K7J0KyI2P518ayHRsyBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cV98w5F3Gb6UM+okhDfKeQvhAuaBX1+br685lq6QIWApFlUoV5A21kfpVJvKqkojVRXInYouxdWJtvNdGTrPPhLRj7AXAWeO/BkVEQghoUGxlBWtIK5MAlI13IEnNA4DQX6X39SgdcVldw4ZiGW2mK7EYEkI/pNcWdbGyUQoMuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=REjeozVB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230199; x=1789766199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4kVZWG6e0OXi5wjRbH85D47K7J0KyI2P518ayHRsyBE=;
  b=REjeozVB4VGfUETj/8LSLUT45GkOZGOOYKmq7kERIVUol9sYpWVP4ILx
   /AXitGy6xnr5D1euSyqP3RV0HGc2MigyHsMOM440Dk2JwCNVbOBLG4jtH
   vg0q0zBsV7ndC+1vT2BR1PfiRo7L3t3K4p22v/tjsnsw/tzjlXI3LG1Ij
   66U7RcUgtTWryAp08XNCyKt0mbmeflmBSrUChnIZVUKLXDnryxjLut2oW
   6pqXwX73aX6GNGPPxQ9jYYnADuqw58UFEzKlU30joXslecsaBTDkynGWo
   2sEjl75Kf2Tik1kzx04g3IXUK5LPWjJMzkacwxI7sI0zOPRrVdO6r5y0h
   w==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: Mh/QYQTgQDadXleJvaJb6A==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071393"
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
Subject: [PATCH v4 18/31] clk: at91: clk-i2s-mux: add support for parent_hw
Date: Thu, 18 Sep 2025 14:16:00 -0700
Message-ID: <276cf23db4b81668bedbcb7b2dd310b62c2ad025.1758226719.git.Ryan.Wanner@microchip.com>
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

Add support for parent_hw in i2s mux clock driver.
With this parent-child relation is described with pointers rather
than strings making registration a bit faster.

All the SoC based drivers that rely on clk-i2s-mux were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/clk-i2s-mux.c | 6 +++++-
 drivers/clk/at91/dt-compat.c   | 2 +-
 drivers/clk/at91/pmc.h         | 1 +
 drivers/clk/at91/sama5d2.c     | 4 ++--
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/at91/clk-i2s-mux.c b/drivers/clk/at91/clk-i2s-mux.c
index fe6ce172b8b0..04d9fcf940fb 100644
--- a/drivers/clk/at91/clk-i2s-mux.c
+++ b/drivers/clk/at91/clk-i2s-mux.c
@@ -51,6 +51,7 @@ static const struct clk_ops clk_i2s_mux_ops = {
 struct clk_hw * __init
 at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
 			  const char * const *parent_names,
+			  struct clk_parent_data *parent_data,
 			  unsigned int num_parents, u8 bus_id)
 {
 	struct clk_init_data init = {};
@@ -63,7 +64,10 @@ at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &clk_i2s_mux_ops;
-	init.parent_names = parent_names;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)parent_data;
+	else
+		init.parent_names = parent_names;
 	init.num_parents = num_parents;
 
 	i2s_ck->hw.init = &init;
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index ccdeba3a1130..2b1aa834f111 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -239,7 +239,7 @@ static void __init of_sama5d2_clk_i2s_mux_setup(struct device_node *np)
 			continue;
 
 		hw = at91_clk_i2s_mux_register(regmap_sfr, i2s_mux_np->name,
-					       parent_names, 2, bus_id);
+					       parent_names, NULL, 2, bus_id);
 		if (IS_ERR(hw))
 			continue;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 64faaa8123c9..0a03e44237f1 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -185,6 +185,7 @@ at91_clk_register_h32mx(struct regmap *regmap, const char *name,
 struct clk_hw * __init
 at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
 			  const char * const *parent_names,
+			  struct clk_parent_data *parent_data,
 			  unsigned int num_parents, u8 bus_id);
 
 struct clk_hw * __init
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 8c7ff0108b41..f5d6c7a96cf2 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -372,7 +372,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		parent_names[0] = "i2s0_clk";
 		parent_names[1] = "i2s0_gclk";
 		hw = at91_clk_i2s_mux_register(regmap_sfr, "i2s0_muxclk",
-					       parent_names, 2, 0);
+					       parent_names, NULL, 2, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
@@ -381,7 +381,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		parent_names[0] = "i2s1_clk";
 		parent_names[1] = "i2s1_gclk";
 		hw = at91_clk_i2s_mux_register(regmap_sfr, "i2s1_muxclk",
-					       parent_names, 2, 1);
+					       parent_names, NULL, 2, 1);
 		if (IS_ERR(hw))
 			goto err_free;
 
-- 
2.43.0


