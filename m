Return-Path: <linux-kernel+bounces-823939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB27FB87C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A15565D65
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3230274B50;
	Fri, 19 Sep 2025 02:57:25 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D8271464;
	Fri, 19 Sep 2025 02:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758250645; cv=none; b=DMJynEs1U8oSVaXwZBCXhxD0vvJKMN1WBTcqflybBgmaz38PsXgzerq4KSQceVx5DSLj9DcpoSj2Hm+pIxIzpwgU0kCo0UFr1BrNa73CWaIOZVo9gMEfRnf2jBHlKW4C5nQaDhWwKU3MBJdvwRDh9CEGfoPCBb7IK3vh3vSm+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758250645; c=relaxed/simple;
	bh=dIXm72jYVUSRnA1JaqY2TM09z0JcIh39eokbKve6ZVM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGV+OIzq9KWjsEQ+TfzseqIUrjlykZPpYwE2wY7VWXyi7mcKLqwFPTWahT1TFiY3gH1dH7UE/7YdIXnwVWf41VZgnCr/VQjBVL1nCC9PeyiVAc0GUtJ61cOtHqqJbKxC3kXSO1p2om3T5JeusVWbjAI41LP556o65wfpV9HVaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 19 Sep
 2025 10:57:13 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 19 Sep 2025 10:57:13 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/4] usb: uhci: Add Aspeed AST2700 support
Date: Fri, 19 Sep 2025 10:57:12 +0800
Message-ID: <20250919025712.719246-5-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919025712.719246-1-ryan_chen@aspeedtech.com>
References: <20250919025712.719246-1-ryan_chen@aspeedtech.com>
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
index f255358d6242..5b4be9a5764a 100644
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
@@ -189,9 +192,13 @@ static void uhci_hcd_platform_shutdown(struct platform_device *op)
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


