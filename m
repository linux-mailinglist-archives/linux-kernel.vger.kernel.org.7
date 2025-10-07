Return-Path: <linux-kernel+bounces-843976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E7BBC0C31
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788973AEDDE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241202D5C97;
	Tue,  7 Oct 2025 08:38:04 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1979A2571BD;
	Tue,  7 Oct 2025 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826283; cv=none; b=RCfIjMRowI1R2pOb2pC5Wv2io9dVHTytpvvOaMignnx31HeDweB6hj2FOzM3VPySQqo2S0Pr0KzlsbEmadLVUuhmtxaGoArFZZ3C4oI8C1Hi2EArxRkVI5gIFz1718Vkuqnk3sEhUIsY/FvpOvF6MvxZpaTeBPCqkP/ChVF4NqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826283; c=relaxed/simple;
	bh=qpcqu+blCYTEGW/oR+TT2Q7IbBLF+U8hpYCvlTBUr04=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1YexVj9IlFzFgEXMIFaeCd3osKStPiDeOJh2rtoNKPnIEiS+CVLyd6hPbcEphauwH8OTt38xm/2i4lZgrMeK5xBWd7T0F3lYCLZ8X3Dy26wOkMW0W6TFmtcFYYiKyfyTYBHbqx1GOmEFSup9lDU2VYro0KpGlW4O3wVjKCY8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 7 Oct
 2025 16:36:50 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 7 Oct 2025 16:36:50 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <wim@linux-watchdog.org>, <linux@roeck-us.net>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<BMC-SW@aspeedtech.com>
Subject: [PATCH 3/3] watchdog: aspeed: Add support for AST2700 platform
Date: Tue, 7 Oct 2025 16:36:50 +0800
Message-ID: <20251007083650.2155317-4-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007083650.2155317-1-chin-ting_kuo@aspeedtech.com>
References: <20251007083650.2155317-1-chin-ting_kuo@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add AST2700 platform support to the ASPEED watchdog driver. This includes
a new per-platform configuration with SCU reset status register at
SCU1_070 and support for 5 reset mask registers.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/watchdog/aspeed_wdt.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index e15f70c5e416..f2245a28ac10 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -84,10 +84,24 @@ static const struct aspeed_wdt_config ast2600_config = {
 	.num_reset_masks = 2,
 };
 
+static const struct aspeed_wdt_config ast2700_config = {
+	.ext_pulse_width_mask = 0xfffff,
+	.irq_shift = 0,
+	.irq_mask = GENMASK(31, 10),
+	.scu = {
+		.compatible = "aspeed,ast2700-scu0",
+		.reset_status_reg = 0x70,
+		.wdt_reset_mask = 0xf,
+		.wdt_reset_mask_shift = 0,
+	},
+	.num_reset_masks = 5,
+};
+
 static const struct of_device_id aspeed_wdt_of_table[] = {
 	{ .compatible = "aspeed,ast2400-wdt", .data = &ast2400_config },
 	{ .compatible = "aspeed,ast2500-wdt", .data = &ast2500_config },
 	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2600_config },
+	{ .compatible = "aspeed,ast2700-wdt", .data = &ast2700_config },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
@@ -484,8 +498,9 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	}
 
 	if ((of_device_is_compatible(np, "aspeed,ast2500-wdt")) ||
-		(of_device_is_compatible(np, "aspeed,ast2600-wdt"))) {
-		u32 reset_mask[2];
+	    (of_device_is_compatible(np, "aspeed,ast2600-wdt")) ||
+	    (of_device_is_compatible(np, "aspeed,ast2700-wdt"))) {
+		u32 reset_mask[5];
 		size_t nrstmask = wdt->cfg->num_reset_masks;
 		u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
 		int i;
-- 
2.34.1


