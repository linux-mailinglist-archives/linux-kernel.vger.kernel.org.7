Return-Path: <linux-kernel+bounces-796339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665DBB3FF1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C06B162681
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C0F255F5C;
	Tue,  2 Sep 2025 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hIwOtF85"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322830ACF9;
	Tue,  2 Sep 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814234; cv=none; b=SoUqusNeKrb5vhIfgOcSZA9r/j/7enW02OzDV1gnHk2fuWQ8EN4Ig5UcZZPr2Csaefhv/gD6Sleav5tFAeaWxa1VsUBNLf+I92KyRgMsowBObROzV1LM8ZPEEMW+jIuUNBOi+rcoXFDJ0p25Q+USP8Shpx7FUuWDNCY3KYe5/Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814234; c=relaxed/simple;
	bh=X2wWmrA7oxTuQEVLARGVrxI0qGFtwivbsfhTFPTU2wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqjPKwcyp65UG8oZWT6crKyCQMtvAFN4DGR0/+ZXrPEO07XprzUTl+BBXfwlnrVFU+XiO+HyiHiFquWLvvgkrZVE7QYe4Qrp9nMktH/LcxeRU4wA8Io+ozjf3PuEG7a8SzLWwHd4KiT2RKKHyD4PEtqcRJiYxl4FvO56p8h6w5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hIwOtF85; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814230;
	bh=X2wWmrA7oxTuQEVLARGVrxI0qGFtwivbsfhTFPTU2wc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hIwOtF85SbWrwXLcYnYeRvsNTlEAgL8YD8p8b6eB8ABB9l6TYtRVBGJakLlHeWWGh
	 mK7Ke6zgEUjBnJG9yWOrjO7eAg4FqdkwwtPnze2gBVv88LqJWC2dtxW80Abb+dScAy
	 aWf6u8p6JBuZgKMsF3xwvgdlU8q1YbtTlNzUgAVjAkT89YS4XJnPUgWoX3LYeKaROM
	 Aw63UNt9yMbaobdytQ4s8m4KOJPIClR8vxotAXLHQdAXfZG5Zff7BbfXlksan7NShL
	 KMBZhrxsGdwIwxAWXisGxc3GyPgPPnKPH6ODlmt3nEdSv9/q+1vfa0cIyhz+91JlAJ
	 1nrjzGFfKwJ0Q==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id CB50617E10B7;
	Tue,  2 Sep 2025 13:57:09 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:39 +0300
Subject: [PATCH 17/17] usb: vhci-hcd: Replace pr_*() with dev_*() logging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-17-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Where possible, use driver model logging helpers dev_*() instead of
pr_*() to ensure the messages are always associated with the
corresponding device/driver.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 8304df3dc94c415bea5252dc0044611f4c862ba5..64fe2f9e22f13b7d0234319521e0a7282c65411a 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -347,7 +347,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	if (wIndex < 1 || wIndex > VHCI_HC_PORTS) {
 		invalid_rhport = true;
 		if (wIndex > VHCI_HC_PORTS)
-			pr_err("invalid port number %d\n", wIndex);
+			dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 	} else {
 		rhport = wIndex - 1;
 	}
@@ -370,7 +370,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		break;
 	case ClearPortFeature:
 		if (invalid_rhport) {
-			pr_err("invalid port number %d\n", wIndex);
+			dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 			goto error;
 		}
 
@@ -410,7 +410,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		usbip_dbg_vhci_rh(" GetHubDescriptor\n");
 		if (hcd->speed >= HCD_USB3 &&
 		    (wLength < USB_DT_SS_HUB_SIZE || wValue != (USB_DT_SS_HUB << 8))) {
-			pr_err("Wrong hub descriptor type for USB 3.0 roothub.\n");
+			dev_err(hcd_dev(hcd),
+				"Wrong hub descriptor type for USB 3.0 roothub.\n");
 			goto error;
 		}
 
@@ -436,7 +437,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	case GetPortStatus:
 		usbip_dbg_vhci_rh(" GetPortStatus port %x\n", wIndex);
 		if (invalid_rhport) {
-			pr_err("invalid port number %d\n", wIndex);
+			dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 			retval = -EPIPE;
 			goto error;
 		}
@@ -485,7 +486,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 						USB_PORT_STAT_LOW_SPEED;
 					break;
 				default:
-					pr_err("vhci_device speed not set\n");
+					dev_err(hcd_dev(hcd), "vhci_device speed not set\n");
 					break;
 				}
 			}
@@ -539,7 +540,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			}
 
 			if (invalid_rhport) {
-				pr_err("invalid port number %d\n", wIndex);
+				dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 				goto error;
 			}
 
@@ -548,7 +549,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_POWER:
 			usbip_dbg_vhci_rh("SetPortFeature: USB_PORT_FEAT_POWER\n");
 			if (invalid_rhport) {
-				pr_err("invalid port number %d\n", wIndex);
+				dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 				goto error;
 			}
 
@@ -560,7 +561,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_BH_PORT_RESET:
 			usbip_dbg_vhci_rh("SetPortFeature: USB_PORT_FEAT_BH_PORT_RESET\n");
 			if (invalid_rhport) {
-				pr_err("invalid port number %d\n", wIndex);
+				dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 				goto error;
 			}
 
@@ -574,7 +575,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_RESET:
 			usbip_dbg_vhci_rh("SetPortFeature: USB_PORT_FEAT_RESET\n");
 			if (invalid_rhport) {
-				pr_err("invalid port number %d\n", wIndex);
+				dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 				goto error;
 			}
 
@@ -598,7 +599,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			usbip_dbg_vhci_rh(" SetPortFeature: default %d\n",
 					  wValue);
 			if (invalid_rhport) {
-				pr_err("invalid port number %d\n", wIndex);
+				dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 				goto error;
 			}
 
@@ -637,7 +638,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		}
 		break;
 	default:
-		pr_err("default hub control req: %04x v%04x i%04x l%d\n",
+		dev_err(hcd_dev(hcd),
+			"default hub control req: %04x v%04x i%04x l%d\n",
 			typeReq, wValue, wIndex, wLength);
 error:
 		/* "protocol stall" on error */
@@ -645,7 +647,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	}
 
 	if (usbip_dbg_flag_vhci_rh) {
-		pr_debug("port %d\n", rhport);
+		dev_dbg(hcd_dev(hcd), "%s port %d\n", __func__, rhport);
 		/* Only dump valid port status */
 		if (!invalid_rhport) {
 			dump_port_status_diff(prev_port_status[rhport],
@@ -705,7 +707,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	unsigned long flags;
 
 	if (portnum > VHCI_HC_PORTS) {
-		pr_err("invalid port number %d\n", portnum);
+		dev_err(hcd_dev(hcd), "invalid port number %d\n", portnum);
 		return -ENODEV;
 	}
 	vdev = &vhci_hcd->vdev[portnum - 1];
@@ -936,7 +938,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 
 		unlink->seqnum = atomic_inc_return(&vhci_hcd->seqnum);
 		if (unlink->seqnum == 0xffff)
-			pr_info("seqnum max\n");
+			dev_info(hcd_dev(hcd), "seqnum max\n");
 
 		unlink->unlink_seqnum = priv->seqnum;
 
@@ -1013,10 +1015,11 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
 static void vhci_shutdown_connection(struct usbip_device *ud)
 {
 	struct vhci_device *vdev = container_of(ud, struct vhci_device, ud);
+	struct usb_hcd *hcd = vhci_hcd_to_hcd(vdev_to_vhci_hcd(vdev));
 
 	/* need this? see stub_dev.c */
 	if (ud->tcp_socket) {
-		pr_debug("shutdown tcp_socket %d\n", ud->sockfd);
+		dev_dbg(hcd_dev(hcd), "shutdown tcp_socket %d\n", ud->sockfd);
 		kernel_sock_shutdown(ud->tcp_socket, SHUT_RDWR);
 	}
 
@@ -1029,7 +1032,7 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 		kthread_stop_put(vdev->ud.tcp_tx);
 		vdev->ud.tcp_tx = NULL;
 	}
-	pr_info("stop threads\n");
+	dev_info(hcd_dev(hcd), "stop threads\n");
 
 	/* active connection is closed */
 	if (vdev->ud.tcp_socket) {
@@ -1037,7 +1040,7 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 		vdev->ud.tcp_socket = NULL;
 		vdev->ud.sockfd = -1;
 	}
-	pr_info("release socket\n");
+	dev_info(hcd_dev(hcd), "release socket\n");
 
 	vhci_device_unlink_cleanup(vdev);
 
@@ -1063,7 +1066,7 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 	 */
 	rh_port_disconnect(vdev);
 
-	pr_info("disconnect device\n");
+	dev_info(hcd_dev(hcd), "disconnect device\n");
 }
 
 static void vhci_device_reset(struct usbip_device *ud)
@@ -1197,7 +1200,7 @@ static int vhci_start(struct usb_hcd *hcd)
 
 	id = hcd_name_to_id(hcd_name(hcd));
 	if (id < 0) {
-		pr_err("invalid vhci name %s\n", hcd_name(hcd));
+		dev_err(hcd_dev(hcd), "invalid vhci name %s\n", hcd_name(hcd));
 		return -EINVAL;
 	}
 
@@ -1216,7 +1219,7 @@ static int vhci_start(struct usb_hcd *hcd)
 			return err;
 		}
 
-		pr_info("created sysfs %s\n", hcd_name(hcd));
+		dev_info(hcd_dev(hcd), "created sysfs %s\n", hcd_name(hcd));
 	}
 
 	return 0;

-- 
2.51.0


