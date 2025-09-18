Return-Path: <linux-kernel+bounces-823642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBC5B87108
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5FF3AB9A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAF72F5A3F;
	Thu, 18 Sep 2025 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Kt8Qd0S8"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FAF2FC892;
	Thu, 18 Sep 2025 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230197; cv=none; b=X5fe1cgP0kN6YTVCUILlwvDgv2GKycGQjYk9znFz/xRa9oW4+uBdGEDs5ZmTJ19Si51ACjky3+WyJOqFmyubOdXUe3XbxJ4cgaPZNwgLiP9SuDm1froCXnWRFJU8SWx3v4g/iJEnoJNhHiVEVR7wZ2VZ9dbeGuU1q2/ydy7EU9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230197; c=relaxed/simple;
	bh=xVtTdz67TIDJp0bBOLbwWbSjBCKlKESMlqlocbWr/nQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVTajH5LaLBbH7xq8IwdYqo2kEghmpaPE1RIxTln3Iz65znfQ8v3lpYX1AazF9iLBxMzDapD/KSPfdtTuninZNrmk8XdnwNr0ure3DqMrVzrkyLoyZYCdJAs6h8KXZTY9UmXnGyxm9Q0s9UEkqA+o/nkWYbAfgFPVFQEOG90gZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Kt8Qd0S8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230196; x=1789766196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xVtTdz67TIDJp0bBOLbwWbSjBCKlKESMlqlocbWr/nQ=;
  b=Kt8Qd0S8b3yU9prXdM/JPQCo19zTW/FtntW2QJAKy7IffFARM9mahgLr
   NoJfhx5Nm/9zVKhRkIdfk+gnCf/H+8xzUGKaznp0llmpMJD1KIzJyguBR
   e2vq45EX3VSi80GvMSQMvxuZ73W+eSPEaZ0dKcsEgNTzgvwgq//zeDwbT
   h/TviLm/VdKp8u25Lc51Yas6NNcNdLAFRrGPxdrA5xAEJBH9nVcarDCUS
   SXe5U67gcmSIaNnu5b8/iqqdRCsb/P8ZtfyhA06GvATvR0/Qcd1AOM4br
   gViGaemD65cwI9hYrQ6bNGy9HhgVXXQ8KAMKrpNrfy92OaVUBKmkaYa8S
   w==;
X-CSE-ConnectionGUID: 31sRM3ybQuOqhqj3gb2ViA==
X-CSE-MsgGUID: jwVSVcSDQpybBC905lv1Ug==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="278071387"
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
	<linux-kernel@vger.kernel.org>, <varshini.rajendran@microchip.com>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v4 13/31] clk: at91: sama7d65: switch to parent_hw and parent_data
Date: Thu, 18 Sep 2025 14:15:55 -0700
Message-ID: <cd47c45215f4c6a38447151222094616850a9d0d.1758226719.git.Ryan.Wanner@microchip.com>
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

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Switch the system clocks to use parent_hw and parent_data. Having this
allows the driver to conform to the new clk-system API.

The parent registration is after the USBCK registration due to one of
the system clocks being dependent on USBCK.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/sama7d65.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
index 986e8ef57dea..38c44b5d5d42 100644
--- a/drivers/clk/at91/sama7d65.c
+++ b/drivers/clk/at91/sama7d65.c
@@ -537,23 +537,23 @@ static struct {
 /*
  * System clock description
  * @n:	clock name
- * @p:	clock parent name
+ * @p:	clock parent hw
  * @id: clock id
  */
-static const struct {
+static struct {
 	const char *n;
-	const char *p;
+	struct clk_hw *parent_hw;
 	u8 id;
 } sama7d65_systemck[] = {
-	{ .n = "uhpck",		.p = "usbck", .id = 6 },
-	{ .n = "pck0",		.p = "prog0", .id = 8, },
-	{ .n = "pck1",		.p = "prog1", .id = 9, },
-	{ .n = "pck2",		.p = "prog2", .id = 10, },
-	{ .n = "pck3",		.p = "prog3", .id = 11, },
-	{ .n = "pck4",		.p = "prog4", .id = 12, },
-	{ .n = "pck5",		.p = "prog5", .id = 13, },
-	{ .n = "pck6",		.p = "prog6", .id = 14, },
-	{ .n = "pck7",		.p = "prog7", .id = 15, },
+	{ .n = "uhpck",		.id = 6 },
+	{ .n = "pck0",		.id = 8, },
+	{ .n = "pck1",		.id = 9, },
+	{ .n = "pck2",		.id = 10, },
+	{ .n = "pck3",		.id = 11, },
+	{ .n = "pck4",		.id = 12, },
+	{ .n = "pck5",		.id = 13, },
+	{ .n = "pck6",		.id = 14, },
+	{ .n = "pck7",		.id = 15, },
 };
 
 /* Mux table for programmable clocks. */
@@ -1299,9 +1299,19 @@ static void __init sama7d65_pmc_setup(struct device_node *np)
 		sama7d65_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	sama7d65_systemck[0].parent_hw = usbck_hw;
+	sama7d65_systemck[1].parent_hw = sama7d65_pmc->pchws[0];
+	sama7d65_systemck[2].parent_hw = sama7d65_pmc->pchws[1];
+	sama7d65_systemck[3].parent_hw = sama7d65_pmc->pchws[2];
+	sama7d65_systemck[4].parent_hw = sama7d65_pmc->pchws[3];
+	sama7d65_systemck[5].parent_hw = sama7d65_pmc->pchws[4];
+	sama7d65_systemck[6].parent_hw = sama7d65_pmc->pchws[5];
+	sama7d65_systemck[7].parent_hw = sama7d65_pmc->pchws[6];
+	sama7d65_systemck[8].parent_hw = sama7d65_pmc->pchws[7];
 	for (i = 0; i < ARRAY_SIZE(sama7d65_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama7d65_systemck[i].n,
-					      sama7d65_systemck[i].p, NULL,
+					      NULL, &AT91_CLK_PD_HW(sama7d65_systemck[i].parent_hw),
 					      sama7d65_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
-- 
2.43.0


