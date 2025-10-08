Return-Path: <linux-kernel+bounces-845782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC56CBC6172
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9536119E3F99
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A7A2F5A1E;
	Wed,  8 Oct 2025 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SkIdyrQe"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12602EBB87;
	Wed,  8 Oct 2025 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942508; cv=none; b=M+HgL9RK63bcxkNa35hiGW2l64v18KxIjNIA356d6PK8G4shGay99buUvV0r3w6t0JYkvCsxB8Rr9FzlHfIjsilPj10MpDzB77p7o2biNO17FQ+q7PBqtXf/qRnb0erAhJvjPRjaQ4Ek7Fpp9PCFL7dw/wtNecM5BCwiLqhQ72M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942508; c=relaxed/simple;
	bh=23HXs/BzkHecZCbZPBCOLZ0W6C+gh3KPP6L425XDanU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rkMNuIu7PJWthkmsqasCwogaC+idUaxxWFqtdjI8fa9FNvwPVh3yg+heT/ByIGeNuSL66t6edCJ1alYYOo8RpUzFWAAnsi6xl6fLNxHIFgxi/4AgSHx4dxYq5HSL4FA7r7KLOSWxaO+arfra+6HoAyhEicL6fBaPYmZe3L80IxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SkIdyrQe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759942497;
	bh=23HXs/BzkHecZCbZPBCOLZ0W6C+gh3KPP6L425XDanU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SkIdyrQeCKFw6dKwU2EcVj8HgskBpgjBr5Gjjr10aQ4Oqp6xD2djZygks4vPRIYFy
	 6rfQJJwR0EI8tCcQsfbQLy1m56MW9+IJim7QM1e8r8384ktk7+cvz1/wm0ao1Yf3Mh
	 DsLqdpJ6Xj6E/g5HZToBJH3WqJUuGJ9XjktzpqkecrZY3WHfd0Nf2/wErp7avtye4p
	 h+awfY1znV8iLGkAI31jEbMQsRT1pauHjnB5FDeSVApiXXnUoCIZKde4BK2DwjDLTK
	 8HkNxYapkeP8vKLTNrpZtqygqJQpplTvt/vhBFcnGWqeu/2HciWpIFL4IXY2Ch7iCJ
	 nUIDaVJ+HX+uA==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 7D5E817E0A28;
	Wed,  8 Oct 2025 18:54:57 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 08 Oct 2025 19:54:26 +0300
Subject: [PATCH v2 1/2] usb: vhci-hcd: Switch to dev_err_probe() in probe
 path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-vhci-hcd-cleanup-v2-1-b6acc4dd6e44@collabora.com>
References: <20251008-vhci-hcd-cleanup-v2-0-b6acc4dd6e44@collabora.com>
In-Reply-To: <20251008-vhci-hcd-cleanup-v2-0-b6acc4dd6e44@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.3

Replace pr_err() calls in vhci_hcd_probe() with dev_err_probe(), to
simplify error handling a bit and improve consistency.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 0d6c10a8490c..275391844aec 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1372,10 +1372,9 @@ static int vhci_hcd_probe(struct platform_device *pdev)
 	 * Our private data is also allocated automatically.
 	 */
 	hcd_hs = usb_create_hcd(&vhci_hc_driver, &pdev->dev, dev_name(&pdev->dev));
-	if (!hcd_hs) {
-		pr_err("create primary hcd failed\n");
-		return -ENOMEM;
-	}
+	if (!hcd_hs)
+		return dev_err_probe(&pdev->dev, -ENOMEM, "create primary hcd failed\n");
+
 	hcd_hs->has_tt = 1;
 
 	/*
@@ -1383,22 +1382,21 @@ static int vhci_hcd_probe(struct platform_device *pdev)
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


