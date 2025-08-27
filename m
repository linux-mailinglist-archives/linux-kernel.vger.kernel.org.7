Return-Path: <linux-kernel+bounces-788523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CACAB385C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CA11B63892
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9F126F2BB;
	Wed, 27 Aug 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vy+qqCQ2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7002D7BF;
	Wed, 27 Aug 2025 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307330; cv=none; b=DkJeJyV3DntbvmdB8qY6ETB8cTAKR7WP8fGswazPMDjTZKmVZ3mHfFFglTacfbHYh7BdSoDK1sP6j1ocrjSzMFDksjFDp7O82zAfA/tKP3KKbcjfCJuyBRxQR+i9ouHDGxRToiKju8g3R+wCG2a9pRSrXs1Rxmsfeg3cKrUG0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307330; c=relaxed/simple;
	bh=vsVLlhcQ+KKqzieS00XnTv/gOmjF8ih5RO9duEOOEO0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N8nbq8lyajW3cOA5mUJ1onmoQfbIwyvrgFrOh6FzWTt2KGqFFBPwo59Zfq2G6FVzV1SaHwybuXuxvvTZ8m6PhMXEMbPT7xytmsF3VByHwkzAqXOe9Jh1xNbZOZwuwCSwW/tP+dsHS+eUOgQivqoHjCHqSZDTog3ae3ST5Np1+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vy+qqCQ2; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756307328; x=1787843328;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vsVLlhcQ+KKqzieS00XnTv/gOmjF8ih5RO9duEOOEO0=;
  b=vy+qqCQ2wVO1/nMsp97oraUX1fP/rY6daI4ivulS28/26n7HQe8cHj+S
   NU729K90UeUQRQDG1z2l795BjGrYMBbFkbZXEyJzEI4FAUnq/IRFMYl8f
   SHNq3bh1Cm2fsWCgdeQQrZHJV5Cc1j65YqN5a55jOt56bjPqlzeFhWAQm
   ECsnBfZXq343dS0Gps+iGarh+999L5awlbA+vL0N8UPhEf9NIR2hif7EN
   7bbYZlB9+GPCT/xvuXDD/Tz+M+gePqHDREzR+dS0umPfKKgqq6IfUbAqk
   PEJ+GIetsVrBoR3u8KQnK7NvfIUxEIlRob+dnir52OsesYj6FVMJcPGyI
   w==;
X-CSE-ConnectionGUID: 7fWiaBvWRQeT6mu/Pdi95A==
X-CSE-MsgGUID: fEGIRcgxSdiXsdcob521EQ==
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="213137835"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2025 08:08:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 27 Aug 2025 08:08:18 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 27 Aug 2025 08:08:16 -0700
From: <nicolas.ferre@microchip.com>
To: ARM Maintainers <arm@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Ryan Wanner <ryan.wanner@microchip.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: Linux CLK <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>
Subject: [PATCH] clk: at91: clk-sam9x60-pll: force write to PLL_UPDT register
Date: Wed, 27 Aug 2025 17:08:10 +0200
Message-ID: <20250827150811.82496-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Nicolas Ferre <nicolas.ferre@microchip.com>

This register is important for sequencing the commands to PLLs, so
actually write the update bits with regmap_write_bits() instead of
relying on a read/modify/write regmap command that could skip the actual
hardware write if the value is identical to the one read.

It's changed when modification is needed to the PLL, when
read-only operation is done, we could keep the call to
regmap_update_bits().

Add a comment to the sam9x60_div_pll_set_div() function that uses this
PLL_UPDT register so that it's used consistently, according to the
product's datasheet.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Tested-by: Ryan Wanner <ryan.wanner@microchip.com> # on sama7d65 and sam9x75
---
 drivers/clk/at91/clk-sam9x60-pll.c | 33 ++++++++++++++++--------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index cefd9948e103..a3198323126f 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -93,7 +93,7 @@ static int sam9x60_frac_pll_set(struct sam9x60_pll_core *core)
 
 	spin_lock_irqsave(core->lock, flags);
 
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+	regmap_write_bits(regmap, AT91_PMC_PLL_UPDT,
 			   AT91_PMC_PLL_UPDT_ID_MSK, core->id);
 	regmap_read(regmap, AT91_PMC_PLL_CTRL1, &val);
 	cmul = (val & core->layout->mul_mask) >> core->layout->mul_shift;
@@ -128,7 +128,7 @@ static int sam9x60_frac_pll_set(struct sam9x60_pll_core *core)
 		udelay(10);
 	}
 
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+	regmap_write_bits(regmap, AT91_PMC_PLL_UPDT,
 			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
 			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
 
@@ -136,7 +136,7 @@ static int sam9x60_frac_pll_set(struct sam9x60_pll_core *core)
 			   AT91_PMC_PLL_CTRL0_ENLOCK | AT91_PMC_PLL_CTRL0_ENPLL,
 			   AT91_PMC_PLL_CTRL0_ENLOCK | AT91_PMC_PLL_CTRL0_ENPLL);
 
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+	regmap_write_bits(regmap, AT91_PMC_PLL_UPDT,
 			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
 			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
 
@@ -164,7 +164,7 @@ static void sam9x60_frac_pll_unprepare(struct clk_hw *hw)
 
 	spin_lock_irqsave(core->lock, flags);
 
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+	regmap_write_bits(regmap, AT91_PMC_PLL_UPDT,
 			   AT91_PMC_PLL_UPDT_ID_MSK, core->id);
 
 	regmap_update_bits(regmap, AT91_PMC_PLL_CTRL0, AT91_PMC_PLL_CTRL0_ENPLL, 0);
@@ -173,7 +173,7 @@ static void sam9x60_frac_pll_unprepare(struct clk_hw *hw)
 		regmap_update_bits(regmap, AT91_PMC_PLL_ACR,
 				   AT91_PMC_PLL_ACR_UTMIBG | AT91_PMC_PLL_ACR_UTMIVR, 0);
 
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+	regmap_write_bits(regmap, AT91_PMC_PLL_UPDT,
 			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
 			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
 
@@ -262,7 +262,7 @@ static int sam9x60_frac_pll_set_rate_chg(struct clk_hw *hw, unsigned long rate,
 
 	spin_lock_irqsave(core->lock, irqflags);
 
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT, AT91_PMC_PLL_UPDT_ID_MSK,
+	regmap_write_bits(regmap, AT91_PMC_PLL_UPDT, AT91_PMC_PLL_UPDT_ID_MSK,
 			   core->id);
 	regmap_read(regmap, AT91_PMC_PLL_CTRL1, &val);
 	cmul = (val & core->layout->mul_mask) >> core->layout->mul_shift;
@@ -275,7 +275,7 @@ static int sam9x60_frac_pll_set_rate_chg(struct clk_hw *hw, unsigned long rate,
 		     (frac->mul << core->layout->mul_shift) |
 		     (frac->frac << core->layout->frac_shift));
 
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+	regmap_write_bits(regmap, AT91_PMC_PLL_UPDT,
 			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
 			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
 
@@ -284,7 +284,7 @@ static int sam9x60_frac_pll_set_rate_chg(struct clk_hw *hw, unsigned long rate,
 			   AT91_PMC_PLL_CTRL0_ENLOCK |
 			   AT91_PMC_PLL_CTRL0_ENPLL);
 
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+	regmap_write_bits(regmap, AT91_PMC_PLL_UPDT,
 			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
 			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
 
@@ -338,7 +338,10 @@ static const struct clk_ops sam9x60_frac_pll_ops_chg = {
 	.restore_context = sam9x60_frac_pll_restore_context,
 };
 
-/* This function should be called with spinlock acquired. */
+/* This function should be called with spinlock acquired.
+ * Warning: this function must be called only if the same PLL ID was set in
+ *          PLL_UPDT register previously.
+ */
 static void sam9x60_div_pll_set_div(struct sam9x60_pll_core *core, u32 div,
 				    bool enable)
 {
@@ -350,7 +353,7 @@ static void sam9x60_div_pll_set_div(struct sam9x60_pll_core *core, u32 div,
 			   core->layout->div_mask | ena_msk,
 			   (div << core->layout->div_shift) | ena_val);
 
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+	regmap_write_bits(regmap, AT91_PMC_PLL_UPDT,
 			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
 			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
 
@@ -366,7 +369,7 @@ static int sam9x60_div_pll_set(struct sam9x60_pll_core *core)
 	unsigned int val, cdiv;
 
 	spin_lock_irqsave(core->lock, flags);
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+	regmap_write_bits(regmap, AT91_PMC_PLL_UPDT,
 			   AT91_PMC_PLL_UPDT_ID_MSK, core->id);
 	regmap_read(regmap, AT91_PMC_PLL_CTRL0, &val);
 	cdiv = (val & core->layout->div_mask) >> core->layout->div_shift;
@@ -398,13 +401,13 @@ static void sam9x60_div_pll_unprepare(struct clk_hw *hw)
 
 	spin_lock_irqsave(core->lock, flags);
 
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+	regmap_write_bits(regmap, AT91_PMC_PLL_UPDT,
 			   AT91_PMC_PLL_UPDT_ID_MSK, core->id);
 
 	regmap_update_bits(regmap, AT91_PMC_PLL_CTRL0,
 			   core->layout->endiv_mask, 0);
 
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+	regmap_write_bits(regmap, AT91_PMC_PLL_UPDT,
 			   AT91_PMC_PLL_UPDT_UPDATE | AT91_PMC_PLL_UPDT_ID_MSK,
 			   AT91_PMC_PLL_UPDT_UPDATE | core->id);
 
@@ -518,7 +521,7 @@ static int sam9x60_div_pll_set_rate_chg(struct clk_hw *hw, unsigned long rate,
 	div->div = DIV_ROUND_CLOSEST(parent_rate, rate) - 1;
 
 	spin_lock_irqsave(core->lock, irqflags);
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT, AT91_PMC_PLL_UPDT_ID_MSK,
+	regmap_write_bits(regmap, AT91_PMC_PLL_UPDT, AT91_PMC_PLL_UPDT_ID_MSK,
 			   core->id);
 	regmap_read(regmap, AT91_PMC_PLL_CTRL0, &val);
 	cdiv = (val & core->layout->div_mask) >> core->layout->div_shift;
@@ -574,7 +577,7 @@ static int sam9x60_div_pll_notifier_fn(struct notifier_block *notifier,
 	div->div = div->safe_div;
 
 	spin_lock_irqsave(core.lock, irqflags);
-	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT, AT91_PMC_PLL_UPDT_ID_MSK,
+	regmap_write_bits(regmap, AT91_PMC_PLL_UPDT, AT91_PMC_PLL_UPDT_ID_MSK,
 			   core.id);
 	regmap_read(regmap, AT91_PMC_PLL_CTRL0, &val);
 	cdiv = (val & core.layout->div_mask) >> core.layout->div_shift;
-- 
2.43.0


