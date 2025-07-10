Return-Path: <linux-kernel+bounces-726374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC7AB00C81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A88777BA085
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A492FD890;
	Thu, 10 Jul 2025 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sWlnIoAp"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77702FE31A;
	Thu, 10 Jul 2025 20:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178070; cv=none; b=KTuJZh9WZQC0R1zZnK68wSYiXcoI1H1dRahSy1NFYfxWUYOfZ1X4nHoGCd8EanDH/zydgxcXSW6Nt6hmFXFxqm+QU4ebdjeNpdjD3aKaqhB2+x/hFG2cZwJHxuYVs54f7vlmud/acsRMmP2CNo1Dout/BjVqoKdWQPtgEtJvG44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178070; c=relaxed/simple;
	bh=t0SSORaKE/2bjrqsbe5GGJ2HRf1IqwuYJphL8uhM3rc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYlFHcOG1ok6YzK3LNb3UAYunt4PwBhC2Iwn+6wT6zt5QVtOwStOhGUHtrPGpUZgxWmKlRCspZlgy9OSGD8SMq73tVoWu1CXusNLRRTUogpcAB39u+ZTeKT50c9GvhZRJVneRxkI8I5rENluqC428/Bks1U/n3Z0tuSSTaKWXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sWlnIoAp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752178069; x=1783714069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t0SSORaKE/2bjrqsbe5GGJ2HRf1IqwuYJphL8uhM3rc=;
  b=sWlnIoApqCni5hlQ1i7t8+CygRwRKTAvwIvOdDb+dfwk1y3IrSgb88ni
   nAdhI7M4e5U8z4yL5FPxXa4RLh39Fg7fOyEwAq8mJWd3gyWmS+lWoM0bN
   F27P5Qq3dV+190A1rMFztEOfewhZhA7FBFEbCgM9Qtyx7uunIyGEzuswE
   xwXdBLTgeYoG6jeCd9d/DQVLkSI2thedQg+5UqbG2UIyhZYuMTJzSfh77
   PZHytWwuoMFBv9u++pSo0cayfubOWGwJr8RIqthxhSxcyXSbpYs71qnXZ
   NBViOypCVe7VREHH5ui1D6JJsaiRTwhe69qQuWv0zRbOUPkfPacEftP1f
   Q==;
X-CSE-ConnectionGUID: qOQSLemoQZOGUxBCHa7nXg==
X-CSE-MsgGUID: ly4bFosgR5uyCKps6m4j7g==
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="275215678"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 13:07:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 10 Jul 2025 13:07:33 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 10 Jul 2025 13:07:33 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <varshini.rajendran@microchip.com>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robh@kernel.org>
Subject: [PATCH v3 20/32] clk: at91: clk-slow: add support for parent_hw
Date: Thu, 10 Jul 2025 13:07:13 -0700
Message-ID: <1450fe7c64df3fb1b3123633c5edce6708a5a5d6.1752176711.git.Ryan.Wanner@microchip.com>
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

Add support for parent_hw in slow clock drivers. With this parent-child
relation is described with pointers rather than strings making
registration a bit faster.

All the SoC based drivers that rely on clk-slow were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/at91sam9260.c | 2 +-
 drivers/clk/at91/clk-slow.c    | 8 ++++++--
 drivers/clk/at91/dt-compat.c   | 2 +-
 drivers/clk/at91/pmc.h         | 1 +
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index f39deb3ec00a..55350331b07e 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -385,7 +385,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 		parent_names[0] = "slow_rc_osc";
 		parent_names[1] = "slow_xtal";
 		hw = at91_clk_register_sam9260_slow(regmap, "slck",
-						    parent_names, 2);
+						    parent_names, NULL, 2);
 		if (IS_ERR(hw))
 			goto err_free;
 
diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
index ac9f7a48b76e..5b7fc6210e09 100644
--- a/drivers/clk/at91/clk-slow.c
+++ b/drivers/clk/at91/clk-slow.c
@@ -39,11 +39,12 @@ struct clk_hw * __init
 at91_clk_register_sam9260_slow(struct regmap *regmap,
 			       const char *name,
 			       const char **parent_names,
+			       struct clk_parent_data *parent_data,
 			       int num_parents)
 {
 	struct clk_sam9260_slow *slowck;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	if (!name)
@@ -58,7 +59,10 @@ at91_clk_register_sam9260_slow(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &sam9260_slow_ops;
-	init.parent_names = parent_names;
+	if (parent_data)
+		init.parent_data = (const struct clk_parent_data *)&parent_data;
+	else
+		init.parent_names = parent_names;
 	init.num_parents = num_parents;
 	init.flags = 0;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 5afd7c9f53fd..fa8658d3be7b 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -823,7 +823,7 @@ static void __init of_at91sam9260_clk_slow_setup(struct device_node *np)
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	hw = at91_clk_register_sam9260_slow(regmap, name, parent_names,
+	hw = at91_clk_register_sam9260_slow(regmap, name, parent_names, NULL,
 					    num_parents);
 	if (IS_ERR(hw))
 		return;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index e5ab2fb3bc89..24c32e42f264 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -273,6 +273,7 @@ struct clk_hw * __init
 at91_clk_register_sam9260_slow(struct regmap *regmap,
 			       const char *name,
 			       const char **parent_names,
+			       struct clk_parent_data *parent_data,
 			       int num_parents);
 
 struct clk_hw * __init
-- 
2.43.0


