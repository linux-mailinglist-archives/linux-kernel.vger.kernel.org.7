Return-Path: <linux-kernel+bounces-817197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C84B57F25
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924E9487420
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657A8335BC6;
	Mon, 15 Sep 2025 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="G1UTySBi"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D9D30C379
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946866; cv=none; b=Ewv7vCJ2bxnEKvy163Jnk1eblQYS2LljJrWHrNP3ZOUY25WyqsLjDYELs1iy8lnPYha9J7PlTCkKFxiGG+t+e0C6C9RYLs62c0i3UexXSjjlf0kWvdb5FJrX/zu0A8Tn+jNiZMRKuBBjRY8w1lNTc4os9Y/lC34Nc9eyE4b1+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946866; c=relaxed/simple;
	bh=6G5vs2cyxeBTHwZWABgSNrCBXx1XdkeNKjCIKpoDxFQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XWUUO/G80Fkz+FeRJuiKPCYjmCJTt0/3SckAlab7mWDS9MkHB4VGBwMJ7e+1IYGqGD7rBsc5k/k6ey0qVeYFMfSDplnVnmCihBTZ+/oMnftqhx/98/GouC/mZsvB5ASq7i32jbSf07kR1QSRNyADudK+qujTH4v42iTu26OoXXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=G1UTySBi; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757946865; x=1789482865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6G5vs2cyxeBTHwZWABgSNrCBXx1XdkeNKjCIKpoDxFQ=;
  b=G1UTySBi3BsbAwWORwH7mcwA5eqh7LG/9XnMftzIHPA587RwXhdqPif4
   zXS5REPyl+8ZRCM0GLuGy/9xzXjrg9i8vmXaGMAG8O+za7/5Le62ByLmS
   RU+zFRMdoDQWAF8mMho5MBT+2sFh3V58vyHOU4hLTSXwOJvdrRaERmkkK
   1/LAQSipel3kFglpU7L4riGMjBMckxIKaemthW3FbpguUYfWkxcFkyVU5
   2CrWy60BU/jytcV3DABY4fkTMFvBLZ379s05K9xjWeHNmLG50NMoVcA7J
   k7PON8p/EiZrIFLptm1sQKYPIAU74Zrv9sQJpNQsnaXIKQzCE6/I/oXHp
   A==;
X-CSE-ConnectionGUID: DF1M/GhBQMGN2tUVc32rVw==
X-CSE-MsgGUID: XRRqoovgT3yxUJMX9QI+Jg==
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="277891866"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2025 07:34:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 15 Sep 2025 07:33:55 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 15 Sep 2025 07:33:53 -0700
From: <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Cristian Birsan <cristian.birsan@microchip.com>, Ryan Wanner
	<ryan.wanner@microchip.com>, Varshini Rajendran
	<varshini.rajendran@microchip.com>
Subject: [PATCH 2/2] ARM: at91: remove default values for PMC_PLL_ACR
Date: Mon, 15 Sep 2025 16:33:45 +0200
Message-ID: <20250915143345.18998-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Cristian Birsan <cristian.birsan@microchip.com>

Remove default values for PMC PLL Analog Control Register(ACR) as the
values are specific for each SoC and PLL and load them from PLL
characteristics structure

Co-developed-by: Andrei Simion <andrei.simion@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
[nicolas.ferre@microchip.com: fix pll acr write sequence, preserve val]
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 7 ++-----
 include/linux/clk/at91_pmc.h       | 2 --
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index a035dc15454b..3dc75a394ce1 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -103,11 +103,8 @@ static int sam9x60_frac_pll_set(struct sam9x60_pll_core *core)
 	    (cmul == frac->mul && cfrac == frac->frac))
 		goto unlock;
 
-	/* Recommended value for PMC_PLL_ACR */
-	if (core->characteristics->upll)
-		val = AT91_PMC_PLL_ACR_DEFAULT_UPLL;
-	else
-		val = AT91_PMC_PLL_ACR_DEFAULT_PLLA;
+	/* Load recommended value for PMC_PLL_ACR */
+	val = core->characteristics->acr;
 	regmap_write(regmap, AT91_PMC_PLL_ACR, val);
 
 	regmap_write(regmap, AT91_PMC_PLL_CTRL1,
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 7af499bdbecb..d60ce9708ea2 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -47,8 +47,6 @@
 #define	AT91_PMC_PCSR		0x18			/* Peripheral Clock Status Register */
 
 #define AT91_PMC_PLL_ACR	0x18			/* PLL Analog Control Register [for SAM9X60] */
-#define		AT91_PMC_PLL_ACR_DEFAULT_UPLL	UL(0x12020010)	/* Default PLL ACR value for UPLL */
-#define		AT91_PMC_PLL_ACR_DEFAULT_PLLA	UL(0x00020010)	/* Default PLL ACR value for PLLA */
 #define		AT91_PMC_PLL_ACR_UTMIVR		(1 << 12)	/* UPLL Voltage regulator Control */
 #define		AT91_PMC_PLL_ACR_UTMIBG		(1 << 13)	/* UPLL Bandgap Control */
 
-- 
2.43.0


