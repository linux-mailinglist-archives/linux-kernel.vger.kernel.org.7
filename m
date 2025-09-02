Return-Path: <linux-kernel+bounces-796336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60834B3FEFD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33A81B26B79
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB153093C8;
	Tue,  2 Sep 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZyluWRcc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB19306D3F;
	Tue,  2 Sep 2025 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814231; cv=none; b=dZawysY+OBpUu1y2vy8YqkY1BIQZn92KKss1h7NaIKxi62Xc3pHVGucKeT+nEXmAcOZEavBqg/1y+44guBS426pT6Bs16wbp5Ur7IPRBbG5+hSuIWDz/2iL2AJp2ASTlznnS4dqgGUwgHhVv/hlqEbxi8erl2j/WtBxOxd8o3f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814231; c=relaxed/simple;
	bh=yE4k/N92zxT8/ez56q76hETeCl2+RzWZurf0SczBZ1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aSRyKEkUFDh992Lp7mz3hrneyZzjm1ZNw3AglknCLYsn3Jc7QTmY8McJf0+FwqYEHLn7XfKotY4JrdIczvdHPY/YplqcvmSnZMs2SefsdbkWn3PaFl92mheAqbujqm0LBdAPJq59z+bo1NA8DA1Ecu1njH24caW43ToX7zFVCks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZyluWRcc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814227;
	bh=yE4k/N92zxT8/ez56q76hETeCl2+RzWZurf0SczBZ1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZyluWRccMxk7iA3YNY/oikM/fS8xnj9abGZpRiAwVUeXK2ISLokIJNa3XY98JJVat
	 E7j9i+mULdp74VwdtBXo59UaCJR2/JMOOd+UKLOvjma6G5u/ZtYfP/c/JT4Vq4qQHk
	 EybmQJDYcF4gXXDEey2eSArbS5GH7AbmH+xOL7gHWPzAoELprCjYBZ2Tiqte0gKj1x
	 2/c6uwZCoq+zlcBbL73t4tdZUJujnOxGaVIXQVTZf3+MJR7+uf2O5dN9wtKLbBSrxZ
	 aeR6vU2HLESiARf5X4LqAmVr/sG2mwHZ3KVHWg5HjUh40t0skBYEpdFCP8nftD/68P
	 MsJnrC6MnLB8A==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 7E6C917E1355;
	Tue,  2 Sep 2025 13:57:07 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:36 +0300
Subject: [PATCH 14/17] usb: vhci-hcd: Consistently use __func__
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-14-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Replace all explicit function names in string literals with __func__ and
silent several checkpatch complaints similar to the following one:

  WARNING: Prefer using '"%s...", __func__' to using 'vhci_start', this function's name, in a string

In case of the usbip_dbg_*() helpers, which are wrappers over
pr_debug(), the function names end up duplicated, hence replace the
superfluous strings with some useful info or simply drop the log entries
altogether if they become ftrace-like.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index a71a542e6eec42c79cff091fe0168f44c8c9b4b2..c790e3a435e2b1493c1ed88d3a98edb7c2e35912 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -160,8 +160,6 @@ void rh_port_connect(struct vhci_device *vdev, enum usb_device_speed speed)
 	u32		status;
 	unsigned long	flags;
 
-	usbip_dbg_vhci_rh("rh_port_connect %d\n", rhport);
-
 	spin_lock_irqsave(&vhci->lock, flags);
 
 	status = vhci_hcd->port_status[rhport];
@@ -183,6 +181,8 @@ void rh_port_connect(struct vhci_device *vdev, enum usb_device_speed speed)
 
 	spin_unlock_irqrestore(&vhci->lock, flags);
 
+	usbip_dbg_vhci_rh("rhport: %d status: %u\n", rhport, status);
+
 	usb_hcd_poll_rh_status(vhci_hcd_to_hcd(vhci_hcd));
 }
 
@@ -194,8 +194,6 @@ static void rh_port_disconnect(struct vhci_device *vdev)
 	u32		status;
 	unsigned long	flags;
 
-	usbip_dbg_vhci_rh("rh_port_disconnect %d\n", rhport);
-
 	spin_lock_irqsave(&vhci->lock, flags);
 
 	status = vhci_hcd->port_status[rhport];
@@ -206,6 +204,9 @@ static void rh_port_disconnect(struct vhci_device *vdev)
 	vhci_hcd->port_status[rhport] = status;
 
 	spin_unlock_irqrestore(&vhci->lock, flags);
+
+	usbip_dbg_vhci_rh("rhport: %d status: %u\n", rhport, status);
+
 	usb_hcd_poll_rh_status(vhci_hcd_to_hcd(vhci_hcd));
 }
 
@@ -1173,8 +1174,6 @@ static int vhci_start(struct usb_hcd *hcd)
 	int id, rhport;
 	int err;
 
-	usbip_dbg_vhci_hc("enter vhci_start\n");
-
 	if (usb_hcd_is_primary_hcd(hcd))
 		spin_lock_init(&vhci_hcd->vhci->lock);
 
@@ -1296,7 +1295,7 @@ static int vhci_alloc_streams(struct usb_hcd *hcd, struct usb_device *udev,
 			      struct usb_host_endpoint **eps, unsigned int num_eps,
 			      unsigned int num_streams, gfp_t mem_flags)
 {
-	dev_dbg(&hcd->self.root_hub->dev, "vhci_alloc_streams not implemented\n");
+	dev_dbg(&hcd->self.root_hub->dev, "%s not implemented\n", __func__);
 	return 0;
 }
 
@@ -1305,7 +1304,7 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 			     struct usb_host_endpoint **eps, unsigned int num_eps,
 			     gfp_t mem_flags)
 {
-	dev_dbg(&hcd->self.root_hub->dev, "vhci_free_streams not implemented\n");
+	dev_dbg(&hcd->self.root_hub->dev, "%s not implemented\n", __func__);
 	return 0;
 }
 

-- 
2.51.0


