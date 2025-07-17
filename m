Return-Path: <linux-kernel+bounces-735569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 673B4B09116
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9F64E07B4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6D12FBFFE;
	Thu, 17 Jul 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Oat/WXqz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D82FC3C6;
	Thu, 17 Jul 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767735; cv=none; b=dbmtHoBGtJaYQvUnOzfnJuyVji4Zl/A9XqYCC/HGl9XGrDEIEq6RWYyikHMnH75hqGTl40zB5Sugwhy7dj0YzrO67B7XaRiW9MqpFt11ilWifXRBDzAWuNR1HIdg9s6EV5kdpryvVZdyJCueXvWUT0G3JzbUZE/qO4FdCDY/7J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767735; c=relaxed/simple;
	bh=iIBvm4isEZ0JANWXsNBsZTwrFMEvPBpiu/OSWJ1uQnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wk0RUtL9wC4KxaKYBWZLg1BwEXzjiNrtpymC50ECihRaknF1xyQDiOoXoeXbmiZGwACmwKBW8YZvJIa0WhMeAGkp3DtMlUkfhIN0iJPP3P9J+gqzGO6r9ZrjUOpQKSB/Rw4ojM4yK8ymx2REnmiB/nEZpWNrBDwwVzswS20xAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Oat/WXqz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752767732;
	bh=iIBvm4isEZ0JANWXsNBsZTwrFMEvPBpiu/OSWJ1uQnU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Oat/WXqzeyoWciB2mJvgxOVFO6xsfV+YT6rVBwxkz0RNEi4a0LlIDoBSFKrKknl12
	 Xnc07Rj4oOZ+++0YmRg0kgdtJPu2ec0RQvbAb96YCPxs3mOCbG0n+X+AyQriyks06f
	 MIkN+cE5Zzg9uOcZHmlW1xjHH61u9a07/PR+7CqZdP8Zoxh72AzjOYMTVTy9UXIqO/
	 CN/TZ2ncjPssQjoGqM5snifTA9MPdCqat2V5T49A7PrsxarrbInfz6790qwJdUvejQ
	 YpT7SeYmYq3GJU0BVg2fXlEYJO3lZTfxbaxEc/XRCuu2M59nz0HxJryZEUST8vfGiP
	 KbB3SU9O0n+ew==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id E34F217E1507;
	Thu, 17 Jul 2025 17:55:31 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 17 Jul 2025 18:54:58 +0300
Subject: [PATCH 9/9] usb: vhci-hcd: Remove ftrace-like logging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-vhci-hcd-suspend-fix-v1-9-2b000cd05952@collabora.com>
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
In-Reply-To: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Drop all superfluous log entries as reported by checkpatch:

  WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 95034440c84f931bdf47552b499e0fdc6f726e59..cb28be94de02627d01fcdab97a3571bca9cc0858 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1172,8 +1172,6 @@ static int vhci_start(struct usb_hcd *hcd)
 	int id, rhport;
 	int err;
 
-	usbip_dbg_vhci_hc("enter %s\n", __func__);
-
 	if (usb_hcd_is_primary_hcd(hcd))
 		spin_lock_init(&vhci_hcd->vhci->lock);
 
@@ -1259,8 +1257,6 @@ static int vhci_bus_suspend(struct usb_hcd *hcd)
 	struct vhci *vhci = *((void **)dev_get_platdata(hcd->self.controller));
 	unsigned long flags;
 
-	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
-
 	spin_lock_irqsave(&vhci->lock, flags);
 	hcd->state = HC_STATE_SUSPENDED;
 	spin_unlock_irqrestore(&vhci->lock, flags);
@@ -1274,8 +1270,6 @@ static int vhci_bus_resume(struct usb_hcd *hcd)
 	int rc = 0;
 	unsigned long flags;
 
-	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
-
 	spin_lock_irqsave(&vhci->lock, flags);
 
 	if (!HCD_HW_ACCESSIBLE(hcd))
@@ -1427,8 +1421,6 @@ static int vhci_hcd_suspend(struct platform_device *pdev, pm_message_t state)
 	int ret = 0;
 	unsigned long flags;
 
-	dev_dbg(&pdev->dev, "%s\n", __func__);
-
 	hcd = platform_get_drvdata(pdev);
 	if (!hcd)
 		return 0;
@@ -1466,8 +1458,6 @@ static int vhci_hcd_resume(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
 
-	dev_dbg(&pdev->dev, "%s\n", __func__);
-
 	hcd = platform_get_drvdata(pdev);
 	if (!hcd)
 		return 0;

-- 
2.50.0


