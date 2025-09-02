Return-Path: <linux-kernel+bounces-796327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F181B3FEFE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38152C8035
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6C82FE052;
	Tue,  2 Sep 2025 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GeMDQPCD"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C413B2FC00B;
	Tue,  2 Sep 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814223; cv=none; b=on3fhYeyIjyapAiDXfHdmxG6i+S3jOtq6bpqjZ5FqqoYVLjCYwRwvZlU2YhnrhuObhiqsyly9QSOYocrAmImiXcQFmQdaGgzuJF+5H8h5JB/htIPKxWpkfCoBxspSB6sPjrAbsCZKHerE+inD0FTLmrBBnf0OjDi+sZ7NKHLTAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814223; c=relaxed/simple;
	bh=x5ipybr/+/KsTjdHoTSzeA2id0uPKxF/Gvr5zbwV6ZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FUfZQgTMckG76MnsPB3W1E+MQJcAPnPywSUGMhL2ixZGr6KDsIy4hMyoX1cmzqHmmDdWukZKSxuevwxtX2WmjNUBGGcU8Do50C/qCEmWlxWc6+rd7H/6objWEItwXk/6WTKO7nxNHAoiYXAjNARm+a1xUE9srgLEWW0kj3WqNoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GeMDQPCD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814220;
	bh=x5ipybr/+/KsTjdHoTSzeA2id0uPKxF/Gvr5zbwV6ZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GeMDQPCDvUO61cV8KXB2kCydMJJ4acwj+kLbNRfwZyUz8+6HwqVmS709IxMuB+87p
	 zMiRtC5KR4PhFxQLu7/GQG6e+O439qe+/1znQ5OQ6u4nC7xFWE0ChFYRGQTC2dBKwS
	 3VispfG7qKMNcYwpMWM7YyUVMcsIs4nBaplFawEdXlJZCV+Kkon93XNLVoUx1XXrnb
	 vkMm3Fy4w8fqLXPhT4cj1AAHi2VM3i41GWL813DI1+YHprmawMhp9Y6hGaAsmvsp9y
	 HTnjq67PxqaDNGCVmZCmSEn2tGk6OVngf6qx9C84pggpS+/gtjLQMIKOD8xWbNO4V+
	 wetcDukmOWJ8g==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 0842E17E1353;
	Tue,  2 Sep 2025 13:57:00 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:27 +0300
Subject: [PATCH 05/17] usb: vhci-hcd: Drop spaces after casts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-5-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Fix a bunch of checkpatch reports:

  CHECK: No space is necessary after a cast

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 59478e8f6c97ac4dad0aaa887df3d169c13aee27..df25ac939a2273571391562227d5c1628a6377e2 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -415,9 +415,9 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		}
 
 		if (hcd->speed >= HCD_USB3)
-			ss_hub_descriptor((struct usb_hub_descriptor *) buf);
+			ss_hub_descriptor((struct usb_hub_descriptor *)buf);
 		else
-			hub_descriptor((struct usb_hub_descriptor *) buf);
+			hub_descriptor((struct usb_hub_descriptor *)buf);
 		break;
 	case DeviceRequest | USB_REQ_GET_DESCRIPTOR:
 		if (hcd->speed < HCD_USB3)
@@ -431,7 +431,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		break;
 	case GetHubStatus:
 		usbip_dbg_vhci_rh(" GetHubStatus\n");
-		*(__le32 *) buf = cpu_to_le32(0);
+		*(__le32 *)buf = cpu_to_le32(0);
 		break;
 	case GetPortStatus:
 		usbip_dbg_vhci_rh(" GetPortStatus port %x\n", wIndex);
@@ -490,8 +490,9 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				}
 			}
 		}
-		((__le16 *) buf)[0] = cpu_to_le16(vhci_hcd->port_status[rhport]);
-		((__le16 *) buf)[1] =
+
+		((__le16 *)buf)[0] = cpu_to_le16(vhci_hcd->port_status[rhport]);
+		((__le16 *)buf)[1] =
 			cpu_to_le16(vhci_hcd->port_status[rhport] >> 16);
 
 		usbip_dbg_vhci_rh(" GetPortStatus bye %x %x\n", ((u16 *)buf)[0],
@@ -625,7 +626,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			goto error;
 		}
 		/* We'll always return 0 since this is a dummy hub */
-		*(__le32 *) buf = cpu_to_le32(0);
+		*(__le32 *)buf = cpu_to_le32(0);
 		break;
 	case SetHubDepth:
 		usbip_dbg_vhci_rh(" SetHubDepth\n");
@@ -685,7 +686,7 @@ static void vhci_tx_urb(struct urb *urb, struct vhci_device *vdev)
 	priv->vdev = vdev;
 	priv->urb = urb;
 
-	urb->hcpriv = (void *) priv;
+	urb->hcpriv = (void *)priv;
 
 	list_add_tail(&priv->list, &vdev->priv_tx);
 
@@ -752,7 +753,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		struct usb_device *old;
 		__u8 type = usb_pipetype(urb->pipe);
 		struct usb_ctrlrequest *ctrlreq =
-			(struct usb_ctrlrequest *) urb->setup_packet;
+			(struct usb_ctrlrequest *)urb->setup_packet;
 
 		if (type != PIPE_CONTROL || !ctrlreq) {
 			dev_err(dev, "invalid request to devnum 0\n");

-- 
2.51.0


