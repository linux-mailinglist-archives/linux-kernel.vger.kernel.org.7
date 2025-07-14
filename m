Return-Path: <linux-kernel+bounces-729735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CC4B03AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4B6189FF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AFB23DEB6;
	Mon, 14 Jul 2025 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0+7kbuNM"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18522E3718;
	Mon, 14 Jul 2025 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485752; cv=none; b=XxPipE6T3IUvEp3iK0kVPtajqyLdFZ3N7H8nxY8EpNluc3Go/A1R4gVf1KusQ5IzjouKl2DUDoqyjc/8HWLsieDWd0o7/rcuKcswNTTJTAf9EfoImGJDkHoe6tGPsAt3RDrFA+07VytLxwbHwBmURJ/wktotCrlbCKKdvbx5psU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485752; c=relaxed/simple;
	bh=GJVLDfxtNl/j4ZoNgtsTJXDQzR2Jxyppvp7EVZRz2DA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pm3Jp2cpk0eVWVokgvmM24RwjPvdEmljXj8FbESiDRholeACxhQrKmeGmn548+0xTKWxEJngXe7DOKtiHzmu/l5XQVp47T74yY+yVBIv1Te1bAYm6TtIduVLQ4UN7THx2rLY9e9Sjs0LKEGqzE4tcfOasdhXD85z913Rc48rcBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0+7kbuNM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752485751; x=1784021751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GJVLDfxtNl/j4ZoNgtsTJXDQzR2Jxyppvp7EVZRz2DA=;
  b=0+7kbuNMsU7wQZw1co9nsbJLRotshWewPYFQGQWBv2EXZneFjcrSvf+B
   JKRul9tuUFQSkf/+f0gmcVyDmYj9tHCQ2VNZcj0Ock6uLsQPsNpshguxd
   KogHey8UcNi5d5BvtdF89kWzwGTgAM3hZeQMrAvkjAXW8pPxS9oyrJ8+a
   cODOl/CZVHuMRKdVtK1E/nzSShqLQuAhEuBUN4yCWToJ2BCyzp7Is1yC/
   AAEJxHVHay+mvuf7BqPmwKxeYTOITR8flEzAA0Uxx9lESRiMrqlLtMuNo
   A7LGlh4sMn240AgC/PxKx4v+3PUs2RVdKX9v2UG77Dho/DWTnb+AFQzy6
   w==;
X-CSE-ConnectionGUID: mtYVE3x4Sj+UnhzZ7qysFg==
X-CSE-MsgGUID: kFUKkyxyQiu7IpGMbzwELg==
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="44552087"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2025 02:35:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 14 Jul 2025 02:35:19 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 14 Jul 2025 02:35:16 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Patrice Vilchez <Patrice.Vilchez@microchip.com>
Subject: [PATCH v2] clk: at91: sam9x7: update pll clk ranges
Date: Mon, 14 Jul 2025 15:05:12 +0530
Message-ID: <20250714093512.29944-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update the min, max ranges of the PLL clocks according to the latest
datasheet to be coherent in the driver. This patch solves the issues in
configuring the clocks related to peripherals with the desired frequency
within the range.

Fixes: 33013b43e271 ("clk: at91: sam9x7: add sam9x7 pmc driver")
Suggested-by: Patrice Vilchez <Patrice.Vilchez@microchip.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v2:
- Adjusted the commit description to be generic.
---
 drivers/clk/at91/sam9x7.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
index cbb8b220f16b..ffab32b047a0 100644
--- a/drivers/clk/at91/sam9x7.c
+++ b/drivers/clk/at91/sam9x7.c
@@ -61,44 +61,44 @@ static const struct clk_master_layout sam9x7_master_layout = {
 
 /* Fractional PLL core output range. */
 static const struct clk_range plla_core_outputs[] = {
-	{ .min = 375000000, .max = 1600000000 },
+	{ .min = 800000000, .max = 1600000000 },
 };
 
 static const struct clk_range upll_core_outputs[] = {
-	{ .min = 600000000, .max = 1200000000 },
+	{ .min = 600000000, .max = 960000000 },
 };
 
 static const struct clk_range lvdspll_core_outputs[] = {
-	{ .min = 400000000, .max = 800000000 },
+	{ .min = 600000000, .max = 1200000000 },
 };
 
 static const struct clk_range audiopll_core_outputs[] = {
-	{ .min = 400000000, .max = 800000000 },
+	{ .min = 600000000, .max = 1200000000 },
 };
 
 static const struct clk_range plladiv2_core_outputs[] = {
-	{ .min = 375000000, .max = 1600000000 },
+	{ .min = 800000000, .max = 1600000000 },
 };
 
 /* Fractional PLL output range. */
 static const struct clk_range plla_outputs[] = {
-	{ .min = 732421, .max = 800000000 },
+	{ .min = 400000000, .max = 800000000 },
 };
 
 static const struct clk_range upll_outputs[] = {
-	{ .min = 300000000, .max = 600000000 },
+	{ .min = 300000000, .max = 480000000 },
 };
 
 static const struct clk_range lvdspll_outputs[] = {
-	{ .min = 10000000, .max = 800000000 },
+	{ .min = 175000000, .max = 550000000 },
 };
 
 static const struct clk_range audiopll_outputs[] = {
-	{ .min = 10000000, .max = 800000000 },
+	{ .min = 0, .max = 300000000 },
 };
 
 static const struct clk_range plladiv2_outputs[] = {
-	{ .min = 366210, .max = 400000000 },
+	{ .min = 200000000, .max = 400000000 },
 };
 
 /* PLL characteristics. */
-- 
2.34.1


