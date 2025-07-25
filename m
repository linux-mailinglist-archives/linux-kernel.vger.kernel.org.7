Return-Path: <linux-kernel+bounces-746428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DD2B12694
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7AE3A2A31
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0553B26B2BE;
	Fri, 25 Jul 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qq+qyJNU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD5D25FA1D;
	Fri, 25 Jul 2025 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481307; cv=none; b=PDYljLCbomi62rAXQFIIAIy/4srUAJbLLX0pjMgutcP7OEwpTpee/O4CvNLPyjhvN9oWmAxFkYy9EAq/EYXI+o9WfCNNGBxz5/FscPa+ww0ODLAaiaiocHkaXHNkm4bp2Qe8iU8fwlbrpj9gLSGdH54TDruu16VmdZuI7eprkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481307; c=relaxed/simple;
	bh=3Lld/ZdX6oD4wzXwjGI+1Lt0L30PGu/6rMJnkGfvWI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFeqRAoDalgy6HbAOI9VsxPSIarna1CoQsYhAuDLNj/2AuGC9nAXC8eSTfraGgaVl2LO4t1zIJ8DSaaHxmEh29nsopMCOOnSPrOaCZaj/KlqQWVMsNZo+JNVk43vFmZadF56BinvJc/yirE0/n3spkcl6L0/11oUtWMQ8olRzdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qq+qyJNU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481303;
	bh=3Lld/ZdX6oD4wzXwjGI+1Lt0L30PGu/6rMJnkGfvWI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qq+qyJNUql4oeKo8iomQ6W9BmRqLfRQXbff+bMYdNC1gN/ZFpkYmCYvI36KPTmEDd
	 QrGGok/azPDY1VcXo28vrFcgeBHwd5PMjZpEUtorOFs9cqely3d96jRWRAsEMnmkGK
	 b4WlHpMwv3JiO/J2uQcWtsLfpeAhbxOs/+hhhIk8pshvSln+HsUwsiCvGuw67Sfsr2
	 1JQTAaeyBAYY0oZtRDF/2iZPcT4mTgoJpo0ANLS7mBxWXDHI8QepTC2Y888JpYCzpm
	 oy+L7AxHiQN8eLYerfwNDARZ6RqFcQqIFdwEaDArEhsJaNNc8Nz97zxHPFQwyvI+wk
	 rMLsJSLFfGEsw==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 5B6B317E1325;
	Sat, 26 Jul 2025 00:08:23 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:08 +0300
Subject: [PATCH v2 06/18] usb: vhci-hcd: Drop spaces after casts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-6-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Fix a bunch of checkpatch reports:

  CHECK: No space is necessary after a cast

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index c739107a3e0411ba2e8227ea6db46802b4882177..5b2d4a57dddf06fcbb8ce8e39306d1b5c4b23b38 100644
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
2.50.0


