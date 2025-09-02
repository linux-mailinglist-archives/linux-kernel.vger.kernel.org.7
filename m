Return-Path: <linux-kernel+bounces-796330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B67CB3FEF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8991B26304
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16A83054E9;
	Tue,  2 Sep 2025 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="USOqyiMq"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9542FABF0;
	Tue,  2 Sep 2025 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814226; cv=none; b=ZozaY/GrAdTnqZQMaDwYCxXnXuJ20ol2i3y2X7RFiX1EgqGPmtkvZQesNgPZ+DjQJNQtPJw+jBvr97NEB9m42estcC+01H8tAcdmsxGtP/S0Bm82bZRO3Ukeb/wH9ZlC3ZfMuxUSIu24SmXHE8ltzZ4/hMY63BZRKakWmIxq1sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814226; c=relaxed/simple;
	bh=eO6DXUp+7fqvHDto63oXo6Aw4m2d1kYsvTgupSq4tNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=joiX4UJNqP0LD1eTTv4yk9zJi4MvW8a9B56xtJhpheqFQxCZxWmLoMQpHgSaTDW2yg87QFUDD7/dLL+0v8/QOcnSxzn5fDc4KLfHCjaYyQ9y2tBlfe1C16A1F7zOba6Vp1MT1ekNwcuQ8DEqZw9rxhWYqQyh4zzyVgHnvV3rg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=USOqyiMq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814222;
	bh=eO6DXUp+7fqvHDto63oXo6Aw4m2d1kYsvTgupSq4tNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=USOqyiMqdncciLpJ5iuvUQfyZ+sJuyzqjXaSIIx3ADXORv+5g6UY62x8bvKMIHk0P
	 4ZrojD7roVSmfeFu3JEy2KMv10OGpoR+KNI5ka+o4D53sRdGmyFteT2OlB5JIRyatV
	 td2xoPD6kc8R02lKJ8VUeKSYFxtgj39uWAbqYyiv+fhGSc20b8TmrUwFgTSAdMmj3x
	 zbF8ZtX8i3pab287wPlUvQ1PolK0KpONNArDJKKOtqdcOM7iiXQk+AGnNty2B8jY4q
	 9xmA4Dz5HRXXqhp9PpwnQH0Lj5zUWPRgm7nHTg/cl8RPShc1H0h7+Vx93o0CtMFLy8
	 0f/HAKuiqKc5A==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 9E4A217E10B7;
	Tue,  2 Sep 2025 13:57:02 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:30 +0300
Subject: [PATCH 08/17] usb: vhci-hcd: Fix open parenthesis alignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-8-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Address a bunch of checkpatch complaints:

  CHECK: Alignment should match open parenthesis

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 4ddf7972490d115620f180aa7d4c9bf09e2aaae7..d3933979689f8cd141b3554e902c1e7b9fc6c694 100644
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
@@ -956,7 +955,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 }
 
 static void vhci_cleanup_unlink_list(struct vhci_device *vdev,
-		struct list_head *unlink_list)
+				     struct list_head *unlink_list)
 {
 	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
 	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
@@ -1300,8 +1299,8 @@ static int vhci_bus_resume(struct usb_hcd *hcd)
 
 /* Change a group of bulk endpoints to support multiple stream IDs */
 static int vhci_alloc_streams(struct usb_hcd *hcd, struct usb_device *udev,
-	struct usb_host_endpoint **eps, unsigned int num_eps,
-	unsigned int num_streams, gfp_t mem_flags)
+			      struct usb_host_endpoint **eps, unsigned int num_eps,
+			      unsigned int num_streams, gfp_t mem_flags)
 {
 	dev_dbg(&hcd->self.root_hub->dev, "vhci_alloc_streams not implemented\n");
 	return 0;
@@ -1309,8 +1308,8 @@ static int vhci_alloc_streams(struct usb_hcd *hcd, struct usb_device *udev,
 
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
2.51.0


