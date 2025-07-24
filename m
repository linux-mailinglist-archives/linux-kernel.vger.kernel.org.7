Return-Path: <linux-kernel+bounces-743930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 452D0B105A5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC5E1CC1914
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E03127A452;
	Thu, 24 Jul 2025 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfaC8/LD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F81259CBE;
	Thu, 24 Jul 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348771; cv=none; b=EemD/nKrLBL+/K2IHu48coonHT7Ux2GaIZ3givzuk5oJ7xluyMtTsEJwAIZfB8dCLDy7TNQU3HzqXFzaCJXSZHznLMkiL+H437s4/vjFJsWrX9x8aST8irEFwMa6Emx34XZtIPiZDSrI19uKFp0m2fSqLqwjrIbh+91XTGjTzOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348771; c=relaxed/simple;
	bh=NbStAABgbrjlf2qgwLuqJgJIAxPU8lYNEP9E56E4CUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEJ1g2eDvBd0Vhf8TRVOLNJmd1waLFpoigw+47dOcx36nS8bpdczKMOCSnoy3NdfcP6gCxf0+C5oOwYUiypPeJ+xRhBsuic+IBjiMfJBIYFTJg0WkLpNHrc1GJKWNxTqs/P2uSmZthCv7iapQxgp8zB+fwcq724DQWp4FtJZ3Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfaC8/LD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F25EC4CEF4;
	Thu, 24 Jul 2025 09:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753348771;
	bh=NbStAABgbrjlf2qgwLuqJgJIAxPU8lYNEP9E56E4CUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfaC8/LDtZ/sjkj2J7raZ/DoaXymzy43nsmOcYsttXLpMZ9OD5wBna8lupayEav/E
	 d7bvxqM5X3gN52+gl/9XZRyvvUqBy9MHZU2rOu2w6oGCxi9Acog+bfx2Bpsp3iNk6U
	 aKWPEjjVYliVU1gz8VyBX2OC62CLNZspt1RMAT5jkjWCzVG1qWsXaS75qlaUCOfSl3
	 24Gg+4Bk9VziwhD8X3wQUxdSAYQ3iSMEEyi55EWREz4rDzcjIcPCqZx6AT+rdhAPxD
	 OOeEwB2LhnNo7fJQhYZr1eUVgLIlj3n0z++QrhK6kAX/Kno3BEK4w09KVGqkEy4wOe
	 MHneIvnwI2L0g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ues6o-000000005V4-02KN;
	Thu, 24 Jul 2025 11:19:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Bin Liu <b-liu@ti.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/5] usb: musb: omap2430: clean up probe error handling
Date: Thu, 24 Jul 2025 11:19:10 +0200
Message-ID: <20250724091910.21092-6-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250724091910.21092-1-johan@kernel.org>
References: <20250724091910.21092-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using numbered error labels is discouraged (e.g. as it requires
renumbering them when adding a new intermediate error path).

Rename the error labels after what they do.

While at it, drop the redundant platform allocation failure dev_err()
as the error would already have been logged by the allocator.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/musb/omap2430.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 36f756f9b7f6..c35c07b7488c 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -318,13 +318,11 @@ static int omap2430_probe(struct platform_device *pdev)
 
 	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue)
-		goto err0;
+		return -ENOMEM;
 
 	musb = platform_device_alloc("musb-hdrc", PLATFORM_DEVID_AUTO);
-	if (!musb) {
-		dev_err(&pdev->dev, "failed to allocate musb device\n");
-		goto err0;
-	}
+	if (!musb)
+		return -ENOMEM;
 
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= &omap2430_dmamask;
@@ -349,15 +347,15 @@ static int omap2430_probe(struct platform_device *pdev)
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
-		goto err2;
+		goto err_put_musb;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
-		goto err2;
+		goto err_put_musb;
 
 	config = devm_kzalloc(&pdev->dev, sizeof(*config), GFP_KERNEL);
 	if (!config)
-		goto err2;
+		goto err_put_musb;
 
 	of_property_read_u32(np, "mode", (u32 *)&pdata->mode);
 	of_property_read_u32(np, "interface-type",
@@ -380,7 +378,7 @@ static int omap2430_probe(struct platform_device *pdev)
 		if (!control_pdev) {
 			dev_err(&pdev->dev, "Failed to get control device\n");
 			ret = -EINVAL;
-			goto err2;
+			goto err_put_musb;
 		}
 		glue->control_otghs = &control_pdev->dev;
 	}
@@ -456,20 +454,19 @@ static int omap2430_probe(struct platform_device *pdev)
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err3;
+		goto err_disable_rpm;
 	}
 
 	return 0;
 
-err3:
+err_disable_rpm:
 	pm_runtime_disable(glue->dev);
 err_put_control_otghs:
 	if (!IS_ERR(glue->control_otghs))
 		put_device(glue->control_otghs);
-err2:
+err_put_musb:
 	platform_device_put(musb);
 
-err0:
 	return ret;
 }
 
-- 
2.49.1


