Return-Path: <linux-kernel+bounces-746437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23127B126A6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B251CE10FC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E60C271A6A;
	Fri, 25 Jul 2025 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="a/ly/gkN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126026FD9B;
	Fri, 25 Jul 2025 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481314; cv=none; b=LUMgEiF6dJMadT9izFYb4SegplCnDu7klnjhJLGcSZjdClb7BYPJxm9xTLy0jEaGssvZ6Xzg10dwGVvnW510xanw4CfkcWeUn0xPdQm6Tm4GxHw9QFnnxvDTWX+1Za4ffXEysozR3nuPDsnicQagRlVvubqisngG6L+OVRZaupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481314; c=relaxed/simple;
	bh=YQ0KGzga0Mr7AcIpOzTtxyYlYq3Su9hRIwFF55+EwjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ak1co1BrhbmHgNnAap3yVdZ7DFtmK7jkRgb3IaEstUdZ1eFvxqOew/GNx25P3n/T8lyYY7ZHDFX2ExPLusISHQW+SKszdrzPAb6HA7D0mWsn0J0vCxkzWpBBo/9X++DLkms2JI/+70kzYRHku1ky5Py2/fnFuvZZiA59FJcOCz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=a/ly/gkN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481311;
	bh=YQ0KGzga0Mr7AcIpOzTtxyYlYq3Su9hRIwFF55+EwjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a/ly/gkNkMhC+ZeC9+1xdNle3YKy15Prl9SMum8uvplLyPN1hTRSCM0EnBwppqQ16
	 MeB7dtQtlsvodCPg45TdhEL9gr1sgvMAs+mfJ8c7rgAn/7YeMjJjV3Em/c+ib0bN/m
	 I2FpVMuICZQRLrsU5cMr6N3zccY2BJPUmyuk0wZKH9nTu/LWCUrbZaCC7P0z4XyBcw
	 aYsQQKt5lwU2bpaz6g/kU7ddMR+jRRpP2SKUHWg5+JB5+BFqHDbH0q7LKKAkmEJ+go
	 iJiW298t1xawxu7YQ7VvhoUVoxvztrE6rrbMs7x/vPjqh/Rk11OnLnK1xfHhEswmPo
	 gqX1QkiCy6asA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id E795E17E1553;
	Sat, 26 Jul 2025 00:08:30 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:17 +0300
Subject: [PATCH v2 15/18] usb: vhci-hcd: Consistently use __func__
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-15-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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
index f37f5f3680c2f1be8ed056d5c8579d75a0d0ad25..00377a7cbebd4e0de3f9a0fb756d93c9cedac148 100644
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
 
@@ -1195,8 +1196,6 @@ static int vhci_start(struct usb_hcd *hcd)
 	int id, rhport;
 	int err;
 
-	usbip_dbg_vhci_hc("enter vhci_start\n");
-
 	if (usb_hcd_is_primary_hcd(hcd))
 		spin_lock_init(&vhci_hcd->vhci->lock);
 
@@ -1318,7 +1317,7 @@ static int vhci_alloc_streams(struct usb_hcd *hcd, struct usb_device *udev,
 			      struct usb_host_endpoint **eps, unsigned int num_eps,
 			      unsigned int num_streams, gfp_t mem_flags)
 {
-	dev_dbg(&hcd->self.root_hub->dev, "vhci_alloc_streams not implemented\n");
+	dev_dbg(&hcd->self.root_hub->dev, "%s not implemented\n", __func__);
 	return 0;
 }
 
@@ -1327,7 +1326,7 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 			     struct usb_host_endpoint **eps, unsigned int num_eps,
 			     gfp_t mem_flags)
 {
-	dev_dbg(&hcd->self.root_hub->dev, "vhci_free_streams not implemented\n");
+	dev_dbg(&hcd->self.root_hub->dev, "%s not implemented\n", __func__);
 	return 0;
 }
 

-- 
2.50.0


