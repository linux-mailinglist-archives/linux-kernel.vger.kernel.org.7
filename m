Return-Path: <linux-kernel+bounces-746431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18ECB1269D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4183A6A57
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE1026D4E8;
	Fri, 25 Jul 2025 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IXuWfXuF"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBDC26AABD;
	Fri, 25 Jul 2025 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481309; cv=none; b=mHskv7muvfASE0zrBwhheykh4XhY5OZsF2DJ6SWaG0zh6HB1kwVUfR5Ty2y3vPVz0I/3pr29UXbV4nM4HNYYfNDxYKs1KniCGuIolMCOF8svV5qwUQc0fKOI9pjC55xFNwoBEOrtOFHIa3Tj1S4IKIPi0lTGsAJKs+ZkW27IFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481309; c=relaxed/simple;
	bh=mS1vPmHlBcEA3tG8hdyev2j06crtXOGFlAAclm8afF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0SzcokId4dMdy/vgr2D+UCMjMLnuNoZizFf5hhPt1A0Jzf7scyJvZmX3AKuqa8GE5QCUbG64+AKMWuXLM4GmV7Y4uNpsu8ISJlXziPC2NF/E7/KqDTcQR+1iD47r9iPCyCpePsstDxThOtOcL6hxRvvZpJE3qX+Wh6JJgrRBZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IXuWfXuF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481306;
	bh=mS1vPmHlBcEA3tG8hdyev2j06crtXOGFlAAclm8afF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IXuWfXuFL4SgBWYpmOPvHjclkv1Mb8H7v2EcSAJbjSnLtbh3ibBTGAUlBQSu8YyDG
	 9KqjtiXGEglXz0/TjlN047/iLnFZizxVH61unCqiedTgIMPKGSOR2WIEos1xqLjS7D
	 eUOqJSVTdo+5mlQFz52CVx17JQRv6xNbsjnoFQPdEZt5RKe1uUCVDanhJDyMXOK9qS
	 T5+Izrq639E6ZanYG/jibClBFDc1CkDw8GnK8xIAgm68xYN7zWQYAbcuuh6pDHm+rj
	 PCuYyZKbeSTQO8FpOTdzwtM3JPQz9YCs6w1ECXRygpZLsHkLhe2JL66+DSD1r5hQo0
	 0OjbQ0kKL/0Yg==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id D060817E14DC;
	Sat, 26 Jul 2025 00:08:25 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:11 +0300
Subject: [PATCH v2 09/18] usb: vhci-hcd: Fix open parenthesis alignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-9-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Address a bunch of checkpatch complaints:

  CHECK: Alignment should match open parenthesis

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index d74bfde1f71c50f2f4e7b69dfaf7687619e8c310..15e1613f4d196e0172131ac722e62c5c579c6346 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -360,7 +360,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	if (usbip_dbg_flag_vhci_rh) {
 		if (!invalid_rhport)
 			memcpy(prev_port_status, vhci_hcd->port_status,
-				sizeof(prev_port_status));
+			       sizeof(prev_port_status));
 	}
 
 	switch (typeReq) {
@@ -408,8 +408,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	case GetHubDescriptor:
 		usbip_dbg_vhci_rh(" GetHubDescriptor\n");
 		if (hcd->speed >= HCD_USB3 &&
-				(wLength < USB_DT_SS_HUB_SIZE ||
-				 wValue != (USB_DT_SS_HUB << 8))) {
+		    (wLength < USB_DT_SS_HUB_SIZE || wValue != (USB_DT_SS_HUB << 8))) {
 			pr_err("Wrong hub descriptor type for USB 3.0 roothub.\n");
 			goto error;
 		}
@@ -711,7 +710,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	vdev = &vhci_hcd->vdev[portnum - 1];
 
 	if (!urb->transfer_buffer && !urb->num_sgs &&
-	     urb->transfer_buffer_length) {
+	    urb->transfer_buffer_length) {
 		dev_dbg(dev, "Null URB transfer buffer\n");
 		return -EINVAL;
 	}
@@ -978,7 +977,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 }
 
 static void vhci_cleanup_unlink_list(struct vhci_device *vdev,
-		struct list_head *unlink_list)
+				     struct list_head *unlink_list)
 {
 	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
 	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
@@ -1322,8 +1321,8 @@ static int vhci_bus_resume(struct usb_hcd *hcd)
 
 /* Change a group of bulk endpoints to support multiple stream IDs */
 static int vhci_alloc_streams(struct usb_hcd *hcd, struct usb_device *udev,
-	struct usb_host_endpoint **eps, unsigned int num_eps,
-	unsigned int num_streams, gfp_t mem_flags)
+			      struct usb_host_endpoint **eps, unsigned int num_eps,
+			      unsigned int num_streams, gfp_t mem_flags)
 {
 	dev_dbg(&hcd->self.root_hub->dev, "vhci_alloc_streams not implemented\n");
 	return 0;
@@ -1331,8 +1330,8 @@ static int vhci_alloc_streams(struct usb_hcd *hcd, struct usb_device *udev,
 
 /* Reverts a group of bulk endpoints back to not using stream IDs. */
 static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
-	struct usb_host_endpoint **eps, unsigned int num_eps,
-	gfp_t mem_flags)
+			     struct usb_host_endpoint **eps, unsigned int num_eps,
+			     gfp_t mem_flags)
 {
 	dev_dbg(&hcd->self.root_hub->dev, "vhci_free_streams not implemented\n");
 	return 0;

-- 
2.50.0


