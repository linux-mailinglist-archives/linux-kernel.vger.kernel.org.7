Return-Path: <linux-kernel+bounces-826637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1367B8F02E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC5F189C10A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0632F0C45;
	Mon, 22 Sep 2025 05:21:03 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D07D2EC0BF;
	Mon, 22 Sep 2025 05:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758518463; cv=none; b=DmqCxiASj129QJIFvLYiqdmk0hRcO15SDS0ygM5pV15kKkMa4R3KxL+3DFm+2DKM3WeePOgrF4gbdoSVTjz5v/MNrVDgbRYr3BF6j2L1yQ/yoG7ubt9AF5Okgt+mIuTW75jvZI8mlQrbk4Tuftmn/qx4sUxHxNjVfX1Eea79YjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758518463; c=relaxed/simple;
	bh=w1x3RIjvxJY3r2qRlnkKedK1Xs++HbYecJfNbrnWc8A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3pOP41VbSfWaqYQWxY4Y8Iu9D3atAzYz3eiRqz+4LJ1ucenm9vuwtnCt5thW/T+yJcGiAw9WRKp78Uuc6YswnE0+cxnZgi8adhyGrJOjFic0Svw0OOILdFJwU2H7qttf1oTW/WhOHnCg+t5XyGdya45uiBLoyUow3oyLuHgmx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 22 Sep
 2025 13:20:45 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 22 Sep 2025 13:20:45 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/4] usb: uhci: Add Aspeed AST2700 support
Date: Mon, 22 Sep 2025 13:20:45 +0800
Message-ID: <20250922052045.2421480-5-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922052045.2421480-1-ryan_chen@aspeedtech.com>
References: <20250922052045.2421480-1-ryan_chen@aspeedtech.com>
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
 drivers/usb/host/uhci-platform.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index aa75b546672b..37607f985cc0 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -65,9 +65,13 @@ static const struct hc_driver uhci_platform_hc_driver = {
 	.hub_control =		uhci_hub_control,
 };
 
+static const u64 dma_mask_32 = DMA_BIT_MASK(32);
+static const u64 dma_mask_64 = DMA_BIT_MASK(64);
+
 static int uhci_hcd_platform_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	const u64 *dma_mask_ptr;
 	struct usb_hcd *hcd;
 	struct uhci_hcd	*uhci;
 	struct resource *res;
@@ -81,7 +85,11 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
 	 * Since shared usb code relies on it, set it here for now.
 	 * Once we have dma capability bindings this can go away.
 	 */
-	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	dma_mask_ptr = (u64 *)of_device_get_match_data(&pdev->dev);
+	if (!dma_mask_ptr)
+		dma_mask_ptr = &dma_mask_32;
+
+	ret = dma_coerce_mask_and_coherent(&pdev->dev, *dma_mask_ptr);
 	if (ret)
 		return ret;
 
@@ -114,7 +122,8 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
 		}
 		if (of_device_is_compatible(np, "aspeed,ast2400-uhci") ||
 		    of_device_is_compatible(np, "aspeed,ast2500-uhci") ||
-		    of_device_is_compatible(np, "aspeed,ast2600-uhci")) {
+		    of_device_is_compatible(np, "aspeed,ast2600-uhci") ||
+		    of_device_is_compatible(np, "aspeed,ast2700-uhci")) {
 			uhci->is_aspeed = 1;
 			dev_info(&pdev->dev,
 				 "Enabled Aspeed implementation workarounds\n");
@@ -191,6 +200,7 @@ static void uhci_hcd_platform_shutdown(struct platform_device *op)
 static const struct of_device_id platform_uhci_ids[] = {
 	{ .compatible = "generic-uhci", },
 	{ .compatible = "platform-uhci", },
+	{ .compatible = "aspeed,ast2700-uhci", .data = &dma_mask_64},
 	{}
 };
 MODULE_DEVICE_TABLE(of, platform_uhci_ids);
-- 
2.34.1


