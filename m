Return-Path: <linux-kernel+bounces-823937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B72B87C47
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B901A1C23428
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E134A26E16A;
	Fri, 19 Sep 2025 02:57:21 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1A269CE5;
	Fri, 19 Sep 2025 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758250641; cv=none; b=nWwl2mStYtZRy+P3HPYy00sjo5BUKLHmPM+ZZjQfgZ5sFXAkq/zeUxUramSP1AtBq4LKIHU2A2NRN6EwhRfPZwlcbfclGEUrmQ7jv3lXd1GDdMXOWVjOhYh7v5lRZ5p5k0N3piZPEH3vkhL/KuYnGcvf/ONT+AFdX+8QPSQvvHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758250641; c=relaxed/simple;
	bh=geJcDqLWAU5xS0NZ+uBv9dd9zO08aWrmQ2L38iDv2J0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmCIZKWYL1xCiaRSzdCG+8ss6rStt21j5RbUtjS5X50niJyCTq53whVwJydHwHnz1Be7SpjoaxqmIufdX0azOQrzuW8W92a+UXw0fX6vtLbrRaa1LaIGNKMXIzrtnSVR8zZyw4la/R7hrcBldVXfBFPmTVaiwgecU/pc5pB1DPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 19 Sep
 2025 10:57:12 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 19 Sep 2025 10:57:12 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Alan
 Stern" <stern@rowland.harvard.edu>, Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/4] usb: uhci: Add reset control support
Date: Fri, 19 Sep 2025 10:57:10 +0800
Message-ID: <20250919025712.719246-3-ryan_chen@aspeedtech.com>
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

Some SoCs, such as the Aspeed AST2700, require the UHCI controller
to be taken out of reset before it can operate. Add optional reset
control support to the UHCI platform driver.

The driver now acquires an optional reset line from device tree,
deasserts it during probe, and asserts it again in the error path
and shutdown.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/usb/host/uhci-hcd.h      |  1 +
 drivers/usb/host/uhci-platform.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
index 13ee2a6144b2..4326d1f3ca76 100644
--- a/drivers/usb/host/uhci-hcd.h
+++ b/drivers/usb/host/uhci-hcd.h
@@ -445,6 +445,7 @@ struct uhci_hcd {
 	short load[MAX_PHASE];			/* Periodic allocations */
 
 	struct clk *clk;			/* (optional) clock source */
+	struct reset_control *rsts;		/* (optional) clock reset */
 
 	/* Reset host controller */
 	void	(*reset_hc) (struct uhci_hcd *uhci);
diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index 62318291f566..f255358d6242 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 
 static int uhci_platform_init(struct usb_hcd *hcd)
 {
@@ -132,17 +133,29 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
 		goto err_rmr;
 	}
 
+	uhci->rsts = devm_reset_control_array_get_optional_shared(&pdev->dev);
+	if (IS_ERR(uhci->rsts)) {
+		ret = PTR_ERR(uhci->rsts);
+		goto err_clk;
+	}
+	ret = reset_control_deassert(uhci->rsts);
+	if (ret)
+		goto err_clk;
+
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto err_clk;
+		goto err_reset;
 
 	ret = usb_add_hcd(hcd, ret, IRQF_SHARED);
 	if (ret)
-		goto err_clk;
+		goto err_reset;
 
 	device_wakeup_enable(hcd->self.controller);
 	return 0;
 
+err_reset:
+	if (!IS_ERR_OR_NULL(uhci->rsts))
+		reset_control_assert(uhci->rsts);
 err_clk:
 	clk_disable_unprepare(uhci->clk);
 err_rmr:
@@ -156,6 +169,7 @@ static void uhci_hcd_platform_remove(struct platform_device *pdev)
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
 
+	reset_control_assert(uhci->rsts);
 	clk_disable_unprepare(uhci->clk);
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
-- 
2.34.1


