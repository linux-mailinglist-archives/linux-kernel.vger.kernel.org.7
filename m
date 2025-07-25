Return-Path: <linux-kernel+bounces-746433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E42B1269F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5B81CE0C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116CF26F467;
	Fri, 25 Jul 2025 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W/zHl5e+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF126A0AF;
	Fri, 25 Jul 2025 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481311; cv=none; b=My51cJMIrSUsqbt+b6J5ypCLBy3Nw4+M+pfn4125Ly9BJjOdiszil/wsl9hV64uBNfIiK9almSkeC1X+GaCs5CRwNSwRY6QX9jEYAXlHFZmZkUu/2Y9UlcB4+XEj8KiHxd1iPSULEs4YrAWdI9t3Dz6HprUH4HUg2+Y7B8T0guM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481311; c=relaxed/simple;
	bh=b8rhHUt6ZqRiawu90SB1XnIW5xwZlN+mO4kLgoqwxjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6i34Ux9FcLgpAFdepPMWOV2cxV2xZQBQndZ4aDhlmkfjOjpSKZLQlD9NllasIssbNHRrGiUBX53RMYxm54wLSnAOmUnqko/aP67oibVvlIr3N/b0bmclz0FGouNPaXvKQm/P5ZNtJ9akr2paBf2cRzm1BcpYD4OWKH0tYqsr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=W/zHl5e+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481307;
	bh=b8rhHUt6ZqRiawu90SB1XnIW5xwZlN+mO4kLgoqwxjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W/zHl5e+tEz/GEEdWPbUi8VxIfQHbvyPU7+3lQKQLqP08gwN0sx8YOzOpjXcYr0sJ
	 GmQH2j5lf1ivw0ZioeB9KINx1YkuI0nq3BgTFSQdxSDaXVFXJLsx1RFwHOhyzn2UKU
	 GhD8kvc0wqXCOpwhz3f0r7jIiPSv+8KjrWY8L2mvEHq7suHHF9FOWFOl1D86JwJDoL
	 z623pV4O/votfdvAVqpKwxMqwwcxJSNiKITv7OIjs6mtzMKwUALIDdIbWSJPuh9oaz
	 cMs+m4x47aM7Ogb3RUDCBuWZN5+dvW8DL9EJqiwYyobPTOBatfWCxzOrlKhWF68zal
	 KzA07ogPmFKPg==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id A0A6017E14FE;
	Sat, 26 Jul 2025 00:08:27 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:13 +0300
Subject: [PATCH v2 11/18] usb: vhci-hcd: Simplify kzalloc usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-11-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Use the shorter variants as suggested by checkpatch.pl:

  CHECK: Prefer kzalloc(sizeof(*priv)...) over kzalloc(sizeof(struct vhci_priv)...)
  CHECK: Prefer kzalloc(sizeof(*unlink)...) over kzalloc(sizeof(struct vhci_unlink)...)

This also improves further maintainability.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index cda42ca492897e4ebf0055a317916874cab94ad6..34ce2d70cfca6ba7fd3003b878036c8eb332eb81 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -670,7 +670,7 @@ static void vhci_tx_urb(struct urb *urb, struct vhci_device *vdev)
 	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
 	unsigned long flags;
 
-	priv = kzalloc(sizeof(struct vhci_priv), GFP_ATOMIC);
+	priv = kzalloc(sizeof(*priv), GFP_ATOMIC);
 	if (!priv) {
 		usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_MALLOC);
 		return;
@@ -948,7 +948,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		spin_lock(&vdev->priv_lock);
 
 		/* setup CMD_UNLINK pdu */
-		unlink = kzalloc(sizeof(struct vhci_unlink), GFP_ATOMIC);
+		unlink = kzalloc(sizeof(*unlink), GFP_ATOMIC);
 		if (!unlink) {
 			spin_unlock(&vdev->priv_lock);
 			spin_unlock_irqrestore(&vhci->lock, flags);

-- 
2.50.0


