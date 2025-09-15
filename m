Return-Path: <linux-kernel+bounces-817183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F48B57EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B07D7A818D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620B6324B22;
	Mon, 15 Sep 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qbvCBD8m"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB962FFDF7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946597; cv=none; b=g0ZwORwAaHu4f+rIjFF73MmHLVu4ruJRQpGbHyi9rsj4kQaSlRXpbRFdSoAuRKl2yWwG27TZPC911rMZ6WixYwuiR/Dx0XAdi/fcV9novJ6jCWK6z5mLehcSHQmH8KiT7QKNJ5bnkrAiZop6J6KB/8PfEWh9jnXOyEwk+sG8RcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946597; c=relaxed/simple;
	bh=Vag2gnBb/vURH7J+sFwDP2yfkuPnkkqrFPGa8fWRmRg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QcLooeSi7wUKkN9mAP+9uAioiW74JKroiiLPUJp5kY/3NXjDJyTA/kMQ0Sh9eq4azqq8U/H9RcnkYqThlJRF5PSL/BuHBBVCtWHKinrVTKP/RdEi3keLFV4F+bxtX3aX0Z6XG4UDKiG5PsTrfwzsESW+4KtKKi3dUNcRTdq6U1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qbvCBD8m; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757946596; x=1789482596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vag2gnBb/vURH7J+sFwDP2yfkuPnkkqrFPGa8fWRmRg=;
  b=qbvCBD8mDlUv90FAcC/xbSGBEQhljP1TgjRvLoftlTWD6Fpl98bIAm7Q
   mERKlEMyc4HDiqJ0D9D4CZd95OA7bNhFCnWCjSMmSXNcymQCtNneaORxX
   yEKFciz2bLbxmusnwl07dXkrigbi8M4cnw7yYgFIcJyxCybm7HXhl5gH1
   LxUxaNAWn4EzYaBucKBT5FVa7JHvU3Smj5zIIrwF5sUJ/5PD68kkXDRd1
   ZFMQUvaQajHfCSxXqloDFR7Fp5ozRGIjF5E/uwCPvlHKg0GHiodiCqNTR
   BJ/p1EDRKjLI74gxhsoxlb9VOv4LElealo9RoEy4emDkArJDGO1lY03kZ
   Q==;
X-CSE-ConnectionGUID: LXjrnypeSNyBrbf8fuQoPA==
X-CSE-MsgGUID: 5jpjx4GUTgyDK4/MLlSw3g==
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="47065475"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2025 07:29:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 15 Sep 2025 07:29:32 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 15 Sep 2025 07:29:30 -0700
From: <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Cristian Birsan <cristian.birsan@microchip.com>, Ryan Wanner
	<ryan.wanner@microchip.com>, Varshini Rajendran
	<varshini.rajendran@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 1/2] clk: at91: add ACR in all PLL settings
Date: Mon, 15 Sep 2025 16:29:07 +0200
Message-ID: <20250915142908.18737-1-nicolas.ferre@microchip.com>
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

Add the ACR register to all PLL settings and provide the correct
ACR value for each PLL used in different SoCs.

Suggested-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
[nicolas.ferre@microchip.com: add sama7d65 and review commit message]
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/clk/at91/pmc.h      | 1 +
 drivers/clk/at91/sam9x60.c  | 2 ++
 drivers/clk/at91/sam9x7.c   | 5 +++++
 drivers/clk/at91/sama7d65.c | 4 ++++
 drivers/clk/at91/sama7g5.c  | 2 ++
 5 files changed, 14 insertions(+)

diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 4fb29ca111f7..5daa32c4cf25 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -80,6 +80,7 @@ struct clk_pll_characteristics {
 	u16 *icpll;
 	u8 *out;
 	u8 upll : 1;
+	u32 acr;
 };
 
 struct clk_programmable_layout {
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index db6db9e2073e..18baf4a256f4 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -36,6 +36,7 @@ static const struct clk_pll_characteristics plla_characteristics = {
 	.num_output = ARRAY_SIZE(plla_outputs),
 	.output = plla_outputs,
 	.core_output = core_outputs,
+	.acr = UL(0x00020010),
 };
 
 static const struct clk_range upll_outputs[] = {
@@ -48,6 +49,7 @@ static const struct clk_pll_characteristics upll_characteristics = {
 	.output = upll_outputs,
 	.core_output = core_outputs,
 	.upll = true,
+	.acr = UL(0x12023010), /* fIN = [18 MHz, 32 MHz]*/
 };
 
 static const struct clk_pll_layout pll_frac_layout = {
diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
index 740f52906f6b..89868a0aeaba 100644
--- a/drivers/clk/at91/sam9x7.c
+++ b/drivers/clk/at91/sam9x7.c
@@ -107,6 +107,7 @@ static const struct clk_pll_characteristics plla_characteristics = {
 	.num_output = ARRAY_SIZE(plla_outputs),
 	.output = plla_outputs,
 	.core_output = plla_core_outputs,
+	.acr = UL(0x00020010), /* Old ACR_DEFAULT_PLLA value */
 };
 
 static const struct clk_pll_characteristics upll_characteristics = {
@@ -115,6 +116,7 @@ static const struct clk_pll_characteristics upll_characteristics = {
 	.output = upll_outputs,
 	.core_output = upll_core_outputs,
 	.upll = true,
+	.acr = UL(0x12023010), /* fIN=[20 MHz, 32 MHz] */
 };
 
 static const struct clk_pll_characteristics lvdspll_characteristics = {
@@ -122,6 +124,7 @@ static const struct clk_pll_characteristics lvdspll_characteristics = {
 	.num_output = ARRAY_SIZE(lvdspll_outputs),
 	.output = lvdspll_outputs,
 	.core_output = lvdspll_core_outputs,
+	.acr = UL(0x12023010), /* fIN=[20 MHz, 32 MHz] */
 };
 
 static const struct clk_pll_characteristics audiopll_characteristics = {
@@ -129,6 +132,7 @@ static const struct clk_pll_characteristics audiopll_characteristics = {
 	.num_output = ARRAY_SIZE(audiopll_outputs),
 	.output = audiopll_outputs,
 	.core_output = audiopll_core_outputs,
+	.acr = UL(0x12023010), /* fIN=[20 MHz, 32 MHz] */
 };
 
 static const struct clk_pll_characteristics plladiv2_characteristics = {
@@ -136,6 +140,7 @@ static const struct clk_pll_characteristics plladiv2_characteristics = {
 	.num_output = ARRAY_SIZE(plladiv2_outputs),
 	.output = plladiv2_outputs,
 	.core_output = plladiv2_core_outputs,
+	.acr = UL(0x00020010),  /* Old ACR_DEFAULT_PLLA value */
 };
 
 /* Layout for fractional PLL ID PLLA. */
diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
index a5d40df8b2f2..7dee2b160ffb 100644
--- a/drivers/clk/at91/sama7d65.c
+++ b/drivers/clk/at91/sama7d65.c
@@ -138,6 +138,7 @@ static const struct clk_pll_characteristics cpu_pll_characteristics = {
 	.num_output = ARRAY_SIZE(cpu_pll_outputs),
 	.output = cpu_pll_outputs,
 	.core_output = core_outputs,
+	.acr = UL(0x00070010),
 };
 
 /* PLL characteristics. */
@@ -146,6 +147,7 @@ static const struct clk_pll_characteristics pll_characteristics = {
 	.num_output = ARRAY_SIZE(pll_outputs),
 	.output = pll_outputs,
 	.core_output = core_outputs,
+	.acr = UL(0x00070010),
 };
 
 static const struct clk_pll_characteristics lvdspll_characteristics = {
@@ -153,6 +155,7 @@ static const struct clk_pll_characteristics lvdspll_characteristics = {
 	.num_output = ARRAY_SIZE(lvdspll_outputs),
 	.output = lvdspll_outputs,
 	.core_output = lvdspll_core_outputs,
+	.acr = UL(0x00070010),
 };
 
 static const struct clk_pll_characteristics upll_characteristics = {
@@ -160,6 +163,7 @@ static const struct clk_pll_characteristics upll_characteristics = {
 	.num_output = ARRAY_SIZE(upll_outputs),
 	.output = upll_outputs,
 	.core_output = upll_core_outputs,
+	.acr = UL(0x12020010),
 	.upll = true,
 };
 
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 8385badc1c70..1340c2b00619 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -113,6 +113,7 @@ static const struct clk_pll_characteristics cpu_pll_characteristics = {
 	.num_output = ARRAY_SIZE(cpu_pll_outputs),
 	.output = cpu_pll_outputs,
 	.core_output = core_outputs,
+	.acr = UL(0x00070010),
 };
 
 /* PLL characteristics. */
@@ -121,6 +122,7 @@ static const struct clk_pll_characteristics pll_characteristics = {
 	.num_output = ARRAY_SIZE(pll_outputs),
 	.output = pll_outputs,
 	.core_output = core_outputs,
+	.acr = UL(0x00070010),
 };
 
 /*
-- 
2.43.0


