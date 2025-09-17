Return-Path: <linux-kernel+bounces-819879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435AFB7F665
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5ED43B83BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB202F7AAA;
	Wed, 17 Sep 2025 02:19:37 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE492F657C;
	Wed, 17 Sep 2025 02:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075577; cv=none; b=KsJUTUR+d7DuMrqW7M+cyZ3bLAh9WV+wLNAaTwUVb0kkOL7FzwYXqDjfU+qgkGO2yBMDm3agiEIf7zIOSCHe254luZ4qghLsm0jHbK6vnSefyMVlv4mE9BBl6+as8kbp3wQYusgWEcBtD7hI3igpCvSTrZfYkTt/2yZhfOjD1iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075577; c=relaxed/simple;
	bh=aGwGJsC1n5hTWmyRDYMaNRjqkaybxF0rZJmxziyrXcA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGswADnyaLZjs7kdNL4tjE1dEvhU0EF2JjKm5L0pIiDZjmZv5+cz9IBY6MjyMJvBt9WAwdKytFVMo/7HsjxnoQoGwVVZ0KW2Sljpxu4x78JYi8LmbwNI2o1GkC6m7CMXv3Rc2qEBEYgqJJKQBjj4StIjqclbkmrnU0a9oooEZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 17 Sep
 2025 10:19:26 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 17 Sep 2025 10:19:26 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] usb: uhci: Add Aspeed AST2700 support
Date: Wed, 17 Sep 2025 10:19:26 +0800
Message-ID: <20250917021926.3692137-5-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917021926.3692137-1-ryan_chen@aspeedtech.com>
References: <20250917021926.3692137-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Unlike earlier Aspeed SoCs (AST2400/2500/2600) which are limited to
32-bit DMA addressing, the UHCI controller in AST2700 supports 64-bit
DMA. Update the platform UHCI driver to select the appropriate DMA
mask based on the device tree compatible string.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/usb/host/uhci-platform.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index 1c1715bddc27..84867f75dfcd 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -71,6 +71,7 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
 	struct usb_hcd *hcd;
 	struct uhci_hcd	*uhci;
 	struct resource *res;
+	u64 *dma_mask_ptr;
 	int ret;
 
 	if (usb_disabled())
@@ -81,7 +82,8 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
 	 * Since shared usb code relies on it, set it here for now.
 	 * Once we have dma capability bindings this can go away.
 	 */
-	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	dma_mask_ptr = (u64 *)of_device_get_match_data(&pdev->dev);
+	ret = dma_coerce_mask_and_coherent(&pdev->dev, *dma_mask_ptr);
 	if (ret)
 		return ret;
 
@@ -114,7 +116,8 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
 		}
 		if (of_device_is_compatible(np, "aspeed,ast2400-uhci") ||
 		    of_device_is_compatible(np, "aspeed,ast2500-uhci") ||
-		    of_device_is_compatible(np, "aspeed,ast2600-uhci")) {
+		    of_device_is_compatible(np, "aspeed,ast2600-uhci") ||
+		    of_device_is_compatible(np, "aspeed,ast2700-uhci")) {
 			uhci->is_aspeed = 1;
 			dev_info(&pdev->dev,
 				 "Enabled Aspeed implementation workarounds\n");
@@ -188,9 +191,13 @@ static void uhci_hcd_platform_shutdown(struct platform_device *op)
 	uhci_hc_died(hcd_to_uhci(hcd));
 }
 
+static const u64 dma_mask_32 =	DMA_BIT_MASK(32);
+static const u64 dma_mask_64 =	DMA_BIT_MASK(64);
+
 static const struct of_device_id platform_uhci_ids[] = {
-	{ .compatible = "generic-uhci", },
-	{ .compatible = "platform-uhci", },
+	{ .compatible = "generic-uhci", .data = &dma_mask_32},
+	{ .compatible = "platform-uhci", .data = &dma_mask_32},
+	{ .compatible = "aspeed,ast2700-uhci", .data = &dma_mask_64},
 	{}
 };
 MODULE_DEVICE_TABLE(of, platform_uhci_ids);
-- 
2.34.1


