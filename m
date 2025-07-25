Return-Path: <linux-kernel+bounces-746440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA5EB126AE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EAB17F068
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF0A26FD9B;
	Fri, 25 Jul 2025 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dsnw0OAW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06F0271470;
	Fri, 25 Jul 2025 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481317; cv=none; b=hFTCTu3fOKkaYa4fOZhKZteGbUn7vb8N7InypZaCDg+AYEijKTENjRr6WLIkTHHvNjBfgTsVj5kumLoGJgn4OSSc99+wWRWMC2/bmCAJgIC3yzOcfp5i5+AMS8jrVhh4xR/zq5C/rlanwDD8dVG6A1ADxZaVQQoApBHsyLrxxc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481317; c=relaxed/simple;
	bh=ltAqzVc50U+Po3OUKy1W8MsDXuZqQh/NKCR+MlMUIZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m/+YX5khyvpdQc9uP25f5VA47JED+EzVGRH82DuwecfNuRD9jJGNBPl/9oeqykBRbaA24FXStp9Ti069LEAtnkoRQcrYkBB5Yb4mOunHaXYigruEVzacYe9x/A165qcLFaWcL2S7Hpnq6pLLgdWfXGVFQemiFlAzximl/i8vsZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dsnw0OAW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481313;
	bh=ltAqzVc50U+Po3OUKy1W8MsDXuZqQh/NKCR+MlMUIZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dsnw0OAW4oW9uxmYfd7ZEIpkO6va68kRZ04jKdCq35q44USbSfKVexyTxptulhHTz
	 BNuX+ZHlyRs0sFiQVRqYVMPQaeXkHKcstHEzY1FaHhMPW3DD65jRfu7fmMciNbB884
	 LbeHv2pSdQceof+VZPB2OxJNkr+qL7OX9a2TUqLY0AKEzfCUwUwDzqL3CUYjR+cy9f
	 fsfv++8qWavvYYc5VBHfLsaQanBAMaI9KfRTsf3dEbJ73nIyS0ahE7SavP25UmAluf
	 Mc310c75aM4R2rmGs2UPJ4q/N/QU54nDzS5rZtzwAink9d6Aj4/qEkzwCRwDGFAmwv
	 to/SDDoXBAQyg==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 517F717E159B;
	Sat, 26 Jul 2025 00:08:33 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:20 +0300
Subject: [PATCH v2 18/18] usb: vhci-hcd: Replace pr_*() with dev_*()
 logging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-18-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Where possible, use driver model logging helpers dev_*() instead of
pr_*() to ensure the messages are always associated with the
corresponding device/driver.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 5d2983a6c2b05d2a769424e1595b4212a806c2a2..96c93e47fba131fc32c969adfaa8f425c55ea7ae 100644
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
@@ -958,7 +960,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 
 		unlink->seqnum = atomic_inc_return(&vhci_hcd->seqnum);
 		if (unlink->seqnum == 0xffff)
-			pr_info("seqnum max\n");
+			dev_info(hcd_dev(hcd), "seqnum max\n");
 
 		unlink->unlink_seqnum = priv->seqnum;
 
@@ -1035,10 +1037,11 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
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
 
@@ -1051,7 +1054,7 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 		kthread_stop_put(vdev->ud.tcp_tx);
 		vdev->ud.tcp_tx = NULL;
 	}
-	pr_info("stop threads\n");
+	dev_info(hcd_dev(hcd), "stop threads\n");
 
 	/* active connection is closed */
 	if (vdev->ud.tcp_socket) {
@@ -1059,7 +1062,7 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 		vdev->ud.tcp_socket = NULL;
 		vdev->ud.sockfd = -1;
 	}
-	pr_info("release socket\n");
+	dev_info(hcd_dev(hcd), "release socket\n");
 
 	vhci_device_unlink_cleanup(vdev);
 
@@ -1085,7 +1088,7 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 	 */
 	rh_port_disconnect(vdev);
 
-	pr_info("disconnect device\n");
+	dev_info(hcd_dev(hcd), "disconnect device\n");
 }
 
 static void vhci_device_reset(struct usbip_device *ud)
@@ -1219,7 +1222,7 @@ static int vhci_start(struct usb_hcd *hcd)
 
 	id = hcd_name_to_id(hcd_name(hcd));
 	if (id < 0) {
-		pr_err("invalid vhci name %s\n", hcd_name(hcd));
+		dev_err(hcd_dev(hcd), "invalid vhci name %s\n", hcd_name(hcd));
 		return -EINVAL;
 	}
 
@@ -1238,7 +1241,7 @@ static int vhci_start(struct usb_hcd *hcd)
 			return err;
 		}
 
-		pr_info("created sysfs %s\n", hcd_name(hcd));
+		dev_info(hcd_dev(hcd), "created sysfs %s\n", hcd_name(hcd));
 	}
 
 	return 0;

-- 
2.50.0


