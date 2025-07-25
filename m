Return-Path: <linux-kernel+bounces-746426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFF9B12690
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB855189BC8D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1E026980D;
	Fri, 25 Jul 2025 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jPHjxce3"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C225A620;
	Fri, 25 Jul 2025 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481305; cv=none; b=fMqxJJ/BuTarjg9xHBns68MTX5hPmD9n8cZ9XhvfjgBJPnIyLLSjwc5gHsguPqQicr8IcQ5wG7Z3wxtdnPbL1iWmgiXp0cBk6eHvQ0hfSSaPpWzxELjFK65Q6XTuQX7AHyCXjvE0DGw9IkzsQ2DmxOthzHTu3uij58KAPsSJeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481305; c=relaxed/simple;
	bh=KOj+eyujRFeFtivf7jk0L85lyc1oGzmXW8wKBy4jGDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5L6Bg1VM+angUDQhkOxSvmvY0pHOzyAA7XDBnj5H23s96ArQQiroPSu2er/HkXcXLtJcRodzzxKExYjTuodzJDCl3Ynf05ISy90VZH2Hz7Jp8JQhUvb75uuHB3XKv1eKPIwiJGZt/TKo74OgFXyofJVw4ccYUGnHeCxZJR851M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jPHjxce3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481301;
	bh=KOj+eyujRFeFtivf7jk0L85lyc1oGzmXW8wKBy4jGDM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jPHjxce3npd5xnHdkz3C4QDZTc60arrhq0j9fg+m+fvrOnKcmqbAuo5QbEjc47rn7
	 LnJcQZtYzodBp0Y435QFOHG/tEWBqn4jzerS8TGXUjyuUnl/Wvt8qP0BBzWqd112n/
	 lu/YqLPXRwccdUIsjy9XA+tn21n573rhJcR8j5oJzXM8tx7Tn6MH3l58CoOBTB01IJ
	 PUvCxuAbpIV2mLSSOefa1MMazN6vMBdmwMOV+lDacNDM2J+KX2Rcx/Wy12D6rLVmWL
	 2efbzuUL+43OdnrgVe1WSSkcrCCJwEUasq2m4JfHHsNzB+HyjwzWpu4oC1qE9KckQd
	 c4Qe5/MNxMCCg==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id AE2D017E131B;
	Sat, 26 Jul 2025 00:08:21 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:06 +0300
Subject: [PATCH v2 04/18] usb: vhci-hcd: Avoid unnecessary use of braces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-4-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Improve code readability in vhci_urb_dequeue() by getting rid of a pair
of braces and reduce the indentation level of the related code block.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index dfdd6ae2cf95c7d5a24d97f713d86588c2dab350..cace9bbbd528602703869cf955f93b311fddd045 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -888,6 +888,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	struct vhci_priv *priv;
 	struct vhci_device *vdev;
 	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&vhci->lock, flags);
 
@@ -899,14 +900,10 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		return -EIDRM;
 	}
 
-	{
-		int ret = 0;
-
-		ret = usb_hcd_check_unlink_urb(hcd, urb, status);
-		if (ret) {
-			spin_unlock_irqrestore(&vhci->lock, flags);
-			return ret;
-		}
+	ret = usb_hcd_check_unlink_urb(hcd, urb, status);
+	if (ret) {
+		spin_unlock_irqrestore(&vhci->lock, flags);
+		return ret;
 	}
 
 	 /* send unlink request here? */

-- 
2.50.0


