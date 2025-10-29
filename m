Return-Path: <linux-kernel+bounces-875788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C9FC19D36
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100AD1AA5BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528C334C20;
	Wed, 29 Oct 2025 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="e2jaEYsq"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E64E3346B1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733877; cv=none; b=XXD1WdQEoLz0jHi86NCAZCiqpedvvT7BETAvbwCrOY/BDSlpwmQrXj8ixoi+NLt0QNE3iX3/OL9CPOxMsy9C/P3sIcogo+IOM+Qr3Wktmq/yeg9PlikCgYNWIlYqakK5LY2WbSnYl0jIIMVhXAqwJHj98BDvxnIoIRiz3lm01ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733877; c=relaxed/simple;
	bh=a4yP0MpBGk+El+aYAb65pi4/zSp4ieqM8UHAS5pGx/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ge4oCOIOIq+FJ1vv+g5uIgOgWQvlOYVl+1HeG67hLSIC46HBO5ASyINhSPAskhb3yYvwOjKlTsMn64toU+YNSlcEFXaN0Im0iHmilvUHXn2jJor+QrMx8MTX5wV6JmL0aOp9V+TDX9l2l+g/XMvkzuIntlNVkqcru2RN4xlSvEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=e2jaEYsq; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3459111DD;
	Wed, 29 Oct 2025 11:29:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761733764;
	bh=a4yP0MpBGk+El+aYAb65pi4/zSp4ieqM8UHAS5pGx/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e2jaEYsqCmfImlfckwZF//3JhAjzXOcf7XnG80viGnxa1a+w8mz8wkiA71sm3WZjk
	 5WqkqNw06RhpTzUwKFDdeSu5ZNugJbtVyiLqS7ju/FPhw3wHnlWpvSig1v0Hl6652C
	 lRWY82+nXINx+HxP7MjkZYrblR7b5kk9ofU24x9o=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Wed, 29 Oct 2025 16:00:06 +0530
Subject: [PATCH v3 2/7] staging: vchiq_arm: Remove bcm2835_camera from
 vchiq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vchiq-destage-v3-2-da8d6c83c2c5@ideasonboard.com>
References: <20251029-vchiq-destage-v3-0-da8d6c83c2c5@ideasonboard.com>
In-Reply-To: <20251029-vchiq-destage-v3-0-da8d6c83c2c5@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com, 
 Stefan Wahren <wahrenst@gmx.net>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Phil Elwell <phil@raspberrypi.com>, Umang Jain <uajain@igalia.com>, 
 Jai Luthra <jai.luthra@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=a4yP0MpBGk+El+aYAb65pi4/zSp4ieqM8UHAS5pGx/Y=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpAeza/AM0+o01rLcRDO9DnIqEMZstG1wxAhCwu
 5lrv+g0Q9uJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQHs2gAKCRBD3pH5JJpx
 RXiOD/44pTx0vVOCdnyFHltHZMfkgkb2jW7xCg7dE+vo1yE5RwUKfM4Q62mEPEUuBqeIOTMtetZ
 raT+3KaY9AUSYmg6lS5u6rUkzFXGUPtwVdNbipZEeb67lNsbCjJXKAHrg81+UI2yirm0x/3blL2
 gUsjbbD9nYclz+T1r/wePQJWPnc7t2vnIaE1cz9luxUHxZ+mINq0QqR4dzFwNqK8s7PjizkSOpR
 3K9UKzAL0F6kEWaqYvbwAQball6BjXaUpJw4ezBXIgQnv+rV8qHD1gjP6lNcd401OVKfo7G67FX
 USEcULGnoQ6BrXt3suNRBY/y1zyrhEq/Ty5x2rgEb1NaQyrdOk+//duvQ+7H7tNUcmQodYskNxj
 QMHVmSZ/PabfXiLxlkbG9mzAlfGx3fI5gB/z73eHmPD73t2lDF2nO4jBEd4tcshW4mwBOOGlAHk
 uMph2iQCTPYQ98DYqbOWi2fPA8VpL1IPaDST2BQ7cPWxZdrXVhBgBeeNgTPkZhD3FyHqVyk2iOa
 5kR06N27KJy7SXrAcK6Jrdmv+P/vujiGihiXA2IqrW/HhrtqGTwzoaQ8SlWdUzrFKTG3e6wHbpY
 EhyZJVZOrvF/YchrYPITP1ZLVZUKT8IdWZRDH4+EMs5l8RpDami9AuvGybR0ynQJpkHhnEgZ1eF
 rsX4wtaErRPjy0A==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

As bcm2835_camera driver is dropped, also drop the loading/unloading
support for it in vchiq.

Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 721b15b7e13b9f25cee7619575bbfa1a4734cce8..c84304dfcdc96742f0f0ef655642a7de69552c3c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -62,7 +62,6 @@
  * the interface.
  */
 static struct vchiq_device *bcm2835_audio;
-static struct vchiq_device *bcm2835_camera;
 
 static const struct vchiq_platform_info bcm2835_info = {
 	.cache_line_size = 32,
@@ -1416,7 +1415,6 @@ static int vchiq_probe(struct platform_device *pdev)
 	vchiq_debugfs_init(&mgmt->state);
 
 	bcm2835_audio = vchiq_device_register(&pdev->dev, "bcm2835-audio");
-	bcm2835_camera = vchiq_device_register(&pdev->dev, "bcm2835-camera");
 
 	return 0;
 }
@@ -1426,7 +1424,6 @@ static void vchiq_remove(struct platform_device *pdev)
 	struct vchiq_drv_mgmt *mgmt = dev_get_drvdata(&pdev->dev);
 
 	vchiq_device_unregister(bcm2835_audio);
-	vchiq_device_unregister(bcm2835_camera);
 	vchiq_debugfs_deinit();
 	vchiq_deregister_chrdev();
 	vchiq_platform_uninit(mgmt);

-- 
2.51.0


