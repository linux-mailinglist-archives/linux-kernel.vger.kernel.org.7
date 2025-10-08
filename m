Return-Path: <linux-kernel+bounces-845781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1EBC616C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F76319E43AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88262F361A;
	Wed,  8 Oct 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ehA5i2Va"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117B261B70;
	Wed,  8 Oct 2025 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942508; cv=none; b=qcQdxPMaAx6duNK5axDmdvLLdR4inAOpi8SR7TATVV+/RE8bN8KscuLUj6pYM1PBwYYkba6NPlT+EsUJUNYTy4qIiYBVpYVky8z79pFzi3H8UVzGfpw4fu7AK1POoE5myNgHETnq14F5Xj0Kv4smkbjc/+n3jyO20d5rTZTHgo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942508; c=relaxed/simple;
	bh=YahqDDuhRZa4g13oY+WjhTtVkJAzOwJQm4YBAXCNn1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKSJTR6zCJGyn7UvPlS8UyISQKF0HdKm1gVB7gN4im6Tb/dmcwnfguIOlEbIVj5QutySzb6RgmdV4qtufPNOYfoTLpn6KazdvxQ5iwRVjGbaip6+blB43sYae8D3uyLnjnuH4FZklhW1gQZXwNYxdrWyO//XDuLnIQCOhp6IS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ehA5i2Va; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759942498;
	bh=YahqDDuhRZa4g13oY+WjhTtVkJAzOwJQm4YBAXCNn1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ehA5i2VaPbUuteclN3ozLjGgbMAA9cK8QQoYpStTVafMiEm+KnFtY38YiV6H1klO5
	 Pgx2JnVOxZ7yYfBQJxkEZ5k14zvnm77Ibr33C1urTUUclAu4ofTVTGsIgG0PaahbEP
	 QNQx/guladkbwrqjGwlh/7N7BZFF7zRBltudcjEVe6AAZnB02xczsG9MEPAk5gTyx5
	 +uUnhhpM2W99LS2SPwsUrPQwZ2DHaMEwQKJWgDMNPQMoW95fif7JFbsGhSPjZxjX0K
	 1mRdAu0IXKp6oMZHPKPj51Y3DY1M1mOkLnlYw3KVxyblbGqfZlv5kTua8VCpfsqH0c
	 cDaxc4A4N/HFg==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 507B817E0CF8;
	Wed,  8 Oct 2025 18:54:58 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 08 Oct 2025 19:54:27 +0300
Subject: [PATCH v2 2/2] usb: vhci-hcd: Replace pr_*() with dev_*() logging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-vhci-hcd-cleanup-v2-2-b6acc4dd6e44@collabora.com>
References: <20251008-vhci-hcd-cleanup-v2-0-b6acc4dd6e44@collabora.com>
In-Reply-To: <20251008-vhci-hcd-cleanup-v2-0-b6acc4dd6e44@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.3

Where possible, use driver model logging helpers dev_*() instead of
pr_*() to ensure the messages are always associated with the
corresponding device/driver.

While at it, join the split strings to make checkpatch happy and regain
ability to grep for those log messages in the source code:

  WARNING: quoted string split across lines

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 74 +++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 275391844aec..72e9a8e74931 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -346,9 +346,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	if (wIndex < 1 || wIndex > VHCI_HC_PORTS) {
 		invalid_rhport = true;
 		if (wIndex > VHCI_HC_PORTS)
-			pr_err("invalid port number %d\n", wIndex);
-	} else
+			dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
+	} else {
 		rhport = wIndex - 1;
+	}
 
 	vhci_hcd = hcd_to_vhci_hcd(hcd);
 	vhci = vhci_hcd->vhci;
@@ -368,14 +369,14 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		break;
 	case ClearPortFeature:
 		if (invalid_rhport) {
-			pr_err("invalid port number %d\n", wIndex);
+			dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 			goto error;
 		}
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 			if (hcd->speed >= HCD_USB3) {
-				pr_err(" ClearPortFeature: USB_PORT_FEAT_SUSPEND req not "
-				       "supported for USB 3.0 roothub\n");
+				dev_err(hcd_dev(hcd),
+					"ClearPortFeature: USB_PORT_FEAT_SUSPEND req not supported for USB 3.0 roothub\n");
 				goto error;
 			}
 			usbip_dbg_vhci_rh(
@@ -408,7 +409,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		if (hcd->speed >= HCD_USB3 &&
 				(wLength < USB_DT_SS_HUB_SIZE ||
 				 wValue != (USB_DT_SS_HUB << 8))) {
-			pr_err("Wrong hub descriptor type for USB 3.0 roothub.\n");
+			dev_err(hcd_dev(hcd),
+				"Wrong hub descriptor type for USB 3.0 roothub.\n");
 			goto error;
 		}
 		if (hcd->speed >= HCD_USB3)
@@ -433,7 +435,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	case GetPortStatus:
 		usbip_dbg_vhci_rh(" GetPortStatus port %x\n", wIndex);
 		if (invalid_rhport) {
-			pr_err("invalid port number %d\n", wIndex);
+			dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 			retval = -EPIPE;
 			goto error;
 		}
@@ -483,7 +485,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 						USB_PORT_STAT_LOW_SPEED;
 					break;
 				default:
-					pr_err("vhci_device speed not set\n");
+					dev_err(hcd_dev(hcd), "vhci_device speed not set\n");
 					break;
 				}
 			}
@@ -505,8 +507,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_LINK_STATE\n");
 			if (hcd->speed < HCD_USB3) {
-				pr_err("USB_PORT_FEAT_LINK_STATE req not "
-				       "supported for USB 2.0 roothub\n");
+				dev_err(hcd_dev(hcd),
+					"USB_PORT_FEAT_LINK_STATE req not supported for USB 2.0 roothub\n");
 				goto error;
 			}
 			/*
@@ -523,8 +525,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				" SetPortFeature: USB_PORT_FEAT_U2_TIMEOUT\n");
 			/* TODO: add suspend/resume support! */
 			if (hcd->speed < HCD_USB3) {
-				pr_err("USB_PORT_FEAT_U1/2_TIMEOUT req not "
-				       "supported for USB 2.0 roothub\n");
+				dev_err(hcd_dev(hcd),
+					"USB_PORT_FEAT_U1/2_TIMEOUT req not supported for USB 2.0 roothub\n");
 				goto error;
 			}
 			break;
@@ -533,13 +535,13 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				" SetPortFeature: USB_PORT_FEAT_SUSPEND\n");
 			/* Applicable only for USB2.0 hub */
 			if (hcd->speed >= HCD_USB3) {
-				pr_err("USB_PORT_FEAT_SUSPEND req not "
-				       "supported for USB 3.0 roothub\n");
+				dev_err(hcd_dev(hcd),
+					"USB_PORT_FEAT_SUSPEND req not supported for USB 3.0 roothub\n");
 				goto error;
 			}
 
 			if (invalid_rhport) {
-				pr_err("invalid port number %d\n", wIndex);
+				dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 				goto error;
 			}
 
@@ -549,7 +551,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_POWER\n");
 			if (invalid_rhport) {
-				pr_err("invalid port number %d\n", wIndex);
+				dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 				goto error;
 			}
 			if (hcd->speed >= HCD_USB3)
@@ -561,13 +563,13 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_BH_PORT_RESET\n");
 			if (invalid_rhport) {
-				pr_err("invalid port number %d\n", wIndex);
+				dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 				goto error;
 			}
 			/* Applicable only for USB3.0 hub */
 			if (hcd->speed < HCD_USB3) {
-				pr_err("USB_PORT_FEAT_BH_PORT_RESET req not "
-				       "supported for USB 2.0 roothub\n");
+				dev_err(hcd_dev(hcd),
+					"USB_PORT_FEAT_BH_PORT_RESET req not supported for USB 2.0 roothub\n");
 				goto error;
 			}
 			fallthrough;
@@ -575,7 +577,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_RESET\n");
 			if (invalid_rhport) {
-				pr_err("invalid port number %d\n", wIndex);
+				dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 				goto error;
 			}
 			/* if it's already enabled, disable */
@@ -598,7 +600,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			usbip_dbg_vhci_rh(" SetPortFeature: default %d\n",
 					  wValue);
 			if (invalid_rhport) {
-				pr_err("invalid port number %d\n", wIndex);
+				dev_err(hcd_dev(hcd), "invalid port number %d\n", wIndex);
 				goto error;
 			}
 			if (wValue >= 32)
@@ -618,8 +620,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	case GetPortErrorCount:
 		usbip_dbg_vhci_rh(" GetPortErrorCount\n");
 		if (hcd->speed < HCD_USB3) {
-			pr_err("GetPortErrorCount req not "
-			       "supported for USB 2.0 roothub\n");
+			dev_err(hcd_dev(hcd),
+				"GetPortErrorCount req not supported for USB 2.0 roothub\n");
 			goto error;
 		}
 		/* We'll always return 0 since this is a dummy hub */
@@ -628,13 +630,14 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	case SetHubDepth:
 		usbip_dbg_vhci_rh(" SetHubDepth\n");
 		if (hcd->speed < HCD_USB3) {
-			pr_err("SetHubDepth req not supported for "
-			       "USB 2.0 roothub\n");
+			dev_err(hcd_dev(hcd),
+				"SetHubDepth req not supported for USB 2.0 roothub\n");
 			goto error;
 		}
 		break;
 	default:
-		pr_err("default hub control req: %04x v%04x i%04x l%d\n",
+		dev_err(hcd_dev(hcd),
+			"default hub control req: %04x v%04x i%04x l%d\n",
 			typeReq, wValue, wIndex, wLength);
 error:
 		/* "protocol stall" on error */
@@ -642,7 +645,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	}
 
 	if (usbip_dbg_flag_vhci_rh) {
-		pr_debug("port %d\n", rhport);
+		dev_dbg(hcd_dev(hcd), "%s port %d\n", __func__, rhport);
 		/* Only dump valid port status */
 		if (!invalid_rhport) {
 			dump_port_status_diff(prev_port_status[rhport],
@@ -702,7 +705,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	unsigned long flags;
 
 	if (portnum > VHCI_HC_PORTS) {
-		pr_err("invalid port number %d\n", portnum);
+		dev_err(hcd_dev(hcd), "invalid port number %d\n", portnum);
 		return -ENODEV;
 	}
 	vdev = &vhci_hcd->vdev[portnum-1];
@@ -958,7 +961,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 
 		unlink->seqnum = atomic_inc_return(&vhci_hcd->seqnum);
 		if (unlink->seqnum == 0xffff)
-			pr_info("seqnum max\n");
+			dev_info(hcd_dev(hcd), "seqnum max\n");
 
 		unlink->unlink_seqnum = priv->seqnum;
 
@@ -1036,10 +1039,11 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
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
 
@@ -1052,7 +1056,7 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 		kthread_stop_put(vdev->ud.tcp_tx);
 		vdev->ud.tcp_tx = NULL;
 	}
-	pr_info("stop threads\n");
+	dev_info(hcd_dev(hcd), "stop threads\n");
 
 	/* active connection is closed */
 	if (vdev->ud.tcp_socket) {
@@ -1060,7 +1064,7 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 		vdev->ud.tcp_socket = NULL;
 		vdev->ud.sockfd = -1;
 	}
-	pr_info("release socket\n");
+	dev_info(hcd_dev(hcd), "release socket\n");
 
 	vhci_device_unlink_cleanup(vdev);
 
@@ -1086,7 +1090,7 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 	 */
 	rh_port_disconnect(vdev);
 
-	pr_info("disconnect device\n");
+	dev_info(hcd_dev(hcd), "disconnect device\n");
 }
 
 static void vhci_device_reset(struct usbip_device *ud)
@@ -1222,7 +1226,7 @@ static int vhci_start(struct usb_hcd *hcd)
 
 	id = hcd_name_to_id(hcd_name(hcd));
 	if (id < 0) {
-		pr_err("invalid vhci name %s\n", hcd_name(hcd));
+		dev_err(hcd_dev(hcd), "invalid vhci name %s\n", hcd_name(hcd));
 		return -EINVAL;
 	}
 
@@ -1239,7 +1243,7 @@ static int vhci_start(struct usb_hcd *hcd)
 			vhci_finish_attr_group();
 			return err;
 		}
-		pr_info("created sysfs %s\n", hcd_name(hcd));
+		dev_info(hcd_dev(hcd), "created sysfs %s\n", hcd_name(hcd));
 	}
 
 	return 0;

-- 
2.51.0


