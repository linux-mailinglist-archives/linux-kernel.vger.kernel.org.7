Return-Path: <linux-kernel+bounces-796338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC47B3FEFA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E6B7A3AEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509A030BF69;
	Tue,  2 Sep 2025 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hPftfvSo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960E93081B8;
	Tue,  2 Sep 2025 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814232; cv=none; b=G/rEkFN/LS62rLEEA4Dz+tSVo93vn3Sue/XYN1K3/nGDqbNJzGfo+TiKlQg9BvpICYlds7XdqBSOLS55JIe1lO707w1vrOdqojSED3hjwWKqHLkDWk5z7qRjEYPsh5TCIszVH+3TFuUK8rR50i9zOJXc214yga4dayruBEGbhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814232; c=relaxed/simple;
	bh=pxp/AjuqCxmQtXbkgQBKdOvYIqT/+fTupjCzJc3e4MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0fMY8etzQTX/pLp0FGTitt4u6dhDBwZ1j4d0GYzSif+3Asf95Pmzca4WpoKB6wVOoUhYHrqYRy1rO2hahTSDqEYXk13aZyn9TVskcAT0S4Zmkl8YNPm8Bo6HNhzcVmYROIc7FSAXaAELtFFFJ2vHj8Zk8bZin/70RFndg/68iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hPftfvSo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814229;
	bh=pxp/AjuqCxmQtXbkgQBKdOvYIqT/+fTupjCzJc3e4MQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hPftfvSocgMhQ4oJxnOX1b9IrnvUq+JYLX/DhIZsJ4POlkM6UzWVOxNlfafr6sMPk
	 AJfcJNFARMEvt61Pu+hqYmF2CrgX8zSazpAoiN4COfUi4/fsnOPeukq9hZX97p83DR
	 EstqtI99LsQnZXGBrSzf8H4JlcoCkyuDBvTZ/1kduv1o4rwa1tI0neDw5yo9Ql1y5h
	 WrZftV8Ci56LUEXTiTzHvrVlBGDkioYmJFlxjPvqlgAKLsDq5eBxP9kxg655MgtiIK
	 rMX6tmVhlOtnPikS6wuwNHvbZ3HmQLOyb82IU8e8pEcHJUUQQ7DqxOOIPv4gIjKP0q
	 uHe5bALY4IAKA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 0FD6717E1353;
	Tue,  2 Sep 2025 13:57:09 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:38 +0300
Subject: [PATCH 16/17] usb: vhci-hcd: Switch to dev_err_probe() in probe
 path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-16-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Replace pr_err() calls in vhci_hcd_probe() with dev_err_probe(), to
simplify error handling a bit and improve consistency.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 9e88fe6424f723709c07e91df21481ae91c1f1b5..8304df3dc94c415bea5252dc0044611f4c862ba5 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1347,10 +1347,8 @@ static int vhci_hcd_probe(struct platform_device *pdev)
 	 * Our private data is also allocated automatically.
 	 */
 	hcd_hs = usb_create_hcd(&vhci_hc_driver, &pdev->dev, dev_name(&pdev->dev));
-	if (!hcd_hs) {
-		pr_err("create primary hcd failed\n");
-		return -ENOMEM;
-	}
+	if (!hcd_hs)
+		return dev_err_probe(&pdev->dev, -ENOMEM, "create primary hcd failed\n");
 
 	hcd_hs->has_tt = 1;
 
@@ -1359,22 +1357,21 @@ static int vhci_hcd_probe(struct platform_device *pdev)
 	 * Call the driver's reset() and start() routines.
 	 */
 	ret = usb_add_hcd(hcd_hs, 0, 0);
-	if (ret != 0) {
-		pr_err("usb_add_hcd hs failed %d\n", ret);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "usb_add_hcd hs failed\n");
 		goto put_usb2_hcd;
 	}
 
 	hcd_ss = usb_create_shared_hcd(&vhci_hc_driver, &pdev->dev,
 				       dev_name(&pdev->dev), hcd_hs);
 	if (!hcd_ss) {
-		ret = -ENOMEM;
-		pr_err("create shared hcd failed\n");
+		ret = dev_err_probe(&pdev->dev, -ENOMEM, "create shared hcd failed\n");
 		goto remove_usb2_hcd;
 	}
 
 	ret = usb_add_hcd(hcd_ss, 0, 0);
 	if (ret) {
-		pr_err("usb_add_hcd ss failed %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "usb_add_hcd ss failed\n");
 		goto put_usb3_hcd;
 	}
 

-- 
2.51.0


