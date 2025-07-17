Return-Path: <linux-kernel+bounces-735562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB9B09108
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6852584C48
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3FA2FBFF8;
	Thu, 17 Jul 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OR4JW4YE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275D1F30AD;
	Thu, 17 Jul 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767730; cv=none; b=WusJQaFtYIZuWzrgFs+zZpSmXEIXu3TxX2XFTfvrUtgmiFEd6jJgec7+FqyEPUqiqOl3TrgVU0M9PiWrQZNIJ50AqoRyZFZqqaDrWluizHapLDP047ekye2zkitwtwnbVGEV+cDehTGfkYX1XuITf+WLlJQ4RODrC8NBWmGG1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767730; c=relaxed/simple;
	bh=dAlBGJWzOQaxL/cJBq38h5CnyCsTBcPmMCLlpCIcODE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UtOyFXbqtXvwRYNrrhre0ZxRScb9AgQoz3K4tnv10KL2k0kEZntaNWfdUt0/c6JU6iEhCvsclH4Q5v6iOqRMNsPDOzJ/oXIqbjZr9Llp46UlnYgdL/awxGk14m+cGlrtjp7nkcJbUj+uK9AkPR21ODqcKYdP3+4UuyzJ4n07XBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OR4JW4YE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752767726;
	bh=dAlBGJWzOQaxL/cJBq38h5CnyCsTBcPmMCLlpCIcODE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OR4JW4YES6zxJKRiCHMnZ6C3BwMnlKpODS7iW/+xFX2gr6FIm3zt184HmdmbtQ1PE
	 rbVkW07PXGUAR/6oUEj6tWoDBclm645pG4cEXrAk1Z/S4AQQ265YTmMk7gd9LlfKjz
	 MQaJD7UZIanH34Zw1eIO3XGtjFQ0sEDYYeCuB2T05yf7Tnyg1W5d1qoGLnEQ0jGEDQ
	 9Ga2IksMrnndVGlaCIgeunL6BKCJADytzMQH02kg3JgHXtoumAjqTahSF0oRDP4xAN
	 9Hnwn2oUSDr4KYPbLlph9rf13uxCf+sk2zC9QIv8DEQCqeksqHJwlwB0qWMGGDRaxe
	 e0H8zCRuODQ/A==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 2569117E128C;
	Thu, 17 Jul 2025 17:55:26 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 17 Jul 2025 18:54:51 +0300
Subject: [PATCH 2/9] usb: vhci-hcd: Fix space, brace, alignment and line
 length issues
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-vhci-hcd-suspend-fix-v1-2-2b000cd05952@collabora.com>
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
In-Reply-To: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Perform a first round of coding style cleanup:

* Add new lines after several statement blocks
* Avoid line wrapping when 100-column width is not exceeded and it helps
  improve code readability
* Ensure lines do not end with '('
* Drop superfluous spaces or empty lines
* Add spaces where necessary, e.g. around operators
* Add braces for single if-statements when at least one branch of the
  conditional requires them

This helps getting rid of the following checkpatch complaints:

  CHECK: Lines should not end with a '('
  CHECK: braces {} should be used on all arms of this statement
  CHECK: Unbalanced braces around else statement
  CHECK: Blank lines aren't necessary before a close brace '}'
  CHECK: Unnecessary parentheses around
  CHECK: Alignment should match open parenthesis
  CHECK: No space is necessary after a cast
  CHECK: spaces preferred around that '-' (ctx:VxV)
  CHECK: spaces preferred around that '+' (ctx:VxV)

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 127 +++++++++++++++++++++++--------------------
 1 file changed, 67 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 762b60e10a9415e58147cde2f615045da5804a0e..f58ba3b5ed50c5cc68d2180a4df78ab4a5f5061d 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -145,6 +145,7 @@ static void dump_port_status_diff(u32 prev_status, u32 new_status, bool usb3)
 			if (bit == 1) /* USB_PORT_STAT_CONNECTION */
 				pr_debug(" %c%s\n", change, "USB_PORT_STAT_SPEED_5GBPS");
 		}
+
 		bit <<= 1;
 		i++;
 	}
@@ -254,7 +255,7 @@ static int vhci_hub_status(struct usb_hcd *hcd, char *buf)
 		}
 	}
 
-	if ((hcd->state == HC_STATE_SUSPENDED) && (changed == 1))
+	if (hcd->state == HC_STATE_SUSPENDED && changed == 1)
 		usb_hcd_resume_root_hub(hcd);
 
 done:
@@ -267,7 +268,6 @@ static struct {
 	struct usb_bos_descriptor bos;
 	struct usb_ss_cap_descriptor ss_cap;
 } __packed usb3_bos_desc = {
-
 	.bos = {
 		.bLength		= USB_DT_BOS_SIZE,
 		.bDescriptorType	= USB_DT_BOS,
@@ -289,8 +289,8 @@ ss_hub_descriptor(struct usb_hub_descriptor *desc)
 	memset(desc, 0, sizeof *desc);
 	desc->bDescriptorType = USB_DT_SS_HUB;
 	desc->bDescLength = 12;
-	desc->wHubCharacteristics = cpu_to_le16(
-		HUB_CHAR_INDV_PORT_LPSM | HUB_CHAR_COMMON_OCPM);
+	desc->wHubCharacteristics = cpu_to_le16(HUB_CHAR_INDV_PORT_LPSM |
+						HUB_CHAR_COMMON_OCPM);
 	desc->bNbrPorts = VHCI_HC_PORTS;
 	desc->u.ss.bHubHdrDecLat = 0x04; /* Worst case: 0.4 micro sec*/
 	desc->u.ss.DeviceRemovable = 0xffff;
@@ -302,11 +302,11 @@ static inline void hub_descriptor(struct usb_hub_descriptor *desc)
 
 	memset(desc, 0, sizeof(*desc));
 	desc->bDescriptorType = USB_DT_HUB;
-	desc->wHubCharacteristics = cpu_to_le16(
-		HUB_CHAR_INDV_PORT_LPSM | HUB_CHAR_COMMON_OCPM);
-
+	desc->wHubCharacteristics = cpu_to_le16(HUB_CHAR_INDV_PORT_LPSM |
+						HUB_CHAR_COMMON_OCPM);
 	desc->bNbrPorts = VHCI_HC_PORTS;
 	BUILD_BUG_ON(VHCI_HC_PORTS > USB_MAXCHILDREN);
+
 	width = desc->bNbrPorts / 8 + 1;
 	desc->bDescLength = USB_DT_HUB_NONVAR_SIZE + 2 * width;
 	memset(&desc->u.hs.DeviceRemovable[0], 0, width);
@@ -347,8 +347,9 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		invalid_rhport = true;
 		if (wIndex > VHCI_HC_PORTS)
 			pr_err("invalid port number %d\n", wIndex);
-	} else
+	} else {
 		rhport = wIndex - 1;
+	}
 
 	vhci_hcd = hcd_to_vhci_hcd(hcd);
 	vhci = vhci_hcd->vhci;
@@ -359,7 +360,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	if (usbip_dbg_flag_vhci_rh) {
 		if (!invalid_rhport)
 			memcpy(prev_port_status, vhci_hcd->port_status,
-				sizeof(prev_port_status));
+			       sizeof(prev_port_status));
 	}
 
 	switch (typeReq) {
@@ -371,6 +372,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			pr_err("invalid port number %d\n", wIndex);
 			goto error;
 		}
+
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 			if (hcd->speed >= HCD_USB3) {
@@ -378,8 +380,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				       "supported for USB 3.0 roothub\n");
 				goto error;
 			}
-			usbip_dbg_vhci_rh(
-				" ClearPortFeature: USB_PORT_FEAT_SUSPEND\n");
+
+			usbip_dbg_vhci_rh(" ClearPortFeature: USB_PORT_FEAT_SUSPEND\n");
 			if (vhci_hcd->port_status[rhport] & USB_PORT_STAT_SUSPEND) {
 				/* 20msec signaling */
 				vhci_hcd->resuming = 1;
@@ -387,8 +389,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			}
 			break;
 		case USB_PORT_FEAT_POWER:
-			usbip_dbg_vhci_rh(
-				" ClearPortFeature: USB_PORT_FEAT_POWER\n");
+			usbip_dbg_vhci_rh(" ClearPortFeature: USB_PORT_FEAT_POWER\n");
 			if (hcd->speed >= HCD_USB3)
 				vhci_hcd->port_status[rhport] &= ~USB_SS_PORT_STAT_POWER;
 			else
@@ -399,6 +400,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 					  wValue);
 			if (wValue >= 32)
 				goto error;
+
 			vhci_hcd->port_status[rhport] &= ~(1 << wValue);
 			break;
 		}
@@ -406,15 +408,15 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	case GetHubDescriptor:
 		usbip_dbg_vhci_rh(" GetHubDescriptor\n");
 		if (hcd->speed >= HCD_USB3 &&
-				(wLength < USB_DT_SS_HUB_SIZE ||
-				 wValue != (USB_DT_SS_HUB << 8))) {
+		    (wLength < USB_DT_SS_HUB_SIZE || wValue != (USB_DT_SS_HUB << 8))) {
 			pr_err("Wrong hub descriptor type for USB 3.0 roothub.\n");
 			goto error;
 		}
+
 		if (hcd->speed >= HCD_USB3)
-			ss_hub_descriptor((struct usb_hub_descriptor *) buf);
+			ss_hub_descriptor((struct usb_hub_descriptor *)buf);
 		else
-			hub_descriptor((struct usb_hub_descriptor *) buf);
+			hub_descriptor((struct usb_hub_descriptor *)buf);
 		break;
 	case DeviceRequest | USB_REQ_GET_DESCRIPTOR:
 		if (hcd->speed < HCD_USB3)
@@ -428,7 +430,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		break;
 	case GetHubStatus:
 		usbip_dbg_vhci_rh(" GetHubStatus\n");
-		*(__le32 *) buf = cpu_to_le32(0);
+		*(__le32 *)buf = cpu_to_le32(0);
 		break;
 	case GetPortStatus:
 		usbip_dbg_vhci_rh(" GetPortStatus port %x\n", wIndex);
@@ -464,10 +466,9 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				VDEV_ST_NOTASSIGNED ||
 			    vhci_hcd->vdev[rhport].ud.status ==
 				VDEV_ST_USED) {
-				usbip_dbg_vhci_rh(
-					" enable rhport %d (status %u)\n",
-					rhport,
-					vhci_hcd->vdev[rhport].ud.status);
+				usbip_dbg_vhci_rh(" enable rhport %d (status %u)\n",
+						  rhport,
+						  vhci_hcd->vdev[rhport].ud.status);
 				vhci_hcd->port_status[rhport] |=
 					USB_PORT_STAT_ENABLE;
 			}
@@ -488,8 +489,9 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
@@ -502,25 +504,23 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	case SetPortFeature:
 		switch (wValue) {
 		case USB_PORT_FEAT_LINK_STATE:
-			usbip_dbg_vhci_rh(
-				" SetPortFeature: USB_PORT_FEAT_LINK_STATE\n");
+			usbip_dbg_vhci_rh(" SetPortFeature: USB_PORT_FEAT_LINK_STATE\n");
 			if (hcd->speed < HCD_USB3) {
 				pr_err("USB_PORT_FEAT_LINK_STATE req not "
 				       "supported for USB 2.0 roothub\n");
 				goto error;
 			}
+
 			/*
 			 * Since this is dummy we don't have an actual link so
 			 * there is nothing to do for the SET_LINK_STATE cmd
 			 */
 			break;
 		case USB_PORT_FEAT_U1_TIMEOUT:
-			usbip_dbg_vhci_rh(
-				" SetPortFeature: USB_PORT_FEAT_U1_TIMEOUT\n");
+			usbip_dbg_vhci_rh(" SetPortFeature: USB_PORT_FEAT_U1_TIMEOUT\n");
 			fallthrough;
 		case USB_PORT_FEAT_U2_TIMEOUT:
-			usbip_dbg_vhci_rh(
-				" SetPortFeature: USB_PORT_FEAT_U2_TIMEOUT\n");
+			usbip_dbg_vhci_rh(" SetPortFeature: USB_PORT_FEAT_U2_TIMEOUT\n");
 			/* TODO: add suspend/resume support! */
 			if (hcd->speed < HCD_USB3) {
 				pr_err("USB_PORT_FEAT_U1/2_TIMEOUT req not "
@@ -529,8 +529,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			}
 			break;
 		case USB_PORT_FEAT_SUSPEND:
-			usbip_dbg_vhci_rh(
-				" SetPortFeature: USB_PORT_FEAT_SUSPEND\n");
+			usbip_dbg_vhci_rh(" SetPortFeature: USB_PORT_FEAT_SUSPEND\n");
 			/* Applicable only for USB2.0 hub */
 			if (hcd->speed >= HCD_USB3) {
 				pr_err("USB_PORT_FEAT_SUSPEND req not "
@@ -546,24 +545,24 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			vhci_hcd->port_status[rhport] |= USB_PORT_STAT_SUSPEND;
 			break;
 		case USB_PORT_FEAT_POWER:
-			usbip_dbg_vhci_rh(
-				" SetPortFeature: USB_PORT_FEAT_POWER\n");
+			usbip_dbg_vhci_rh(" SetPortFeature: USB_PORT_FEAT_POWER\n");
 			if (invalid_rhport) {
 				pr_err("invalid port number %d\n", wIndex);
 				goto error;
 			}
+
 			if (hcd->speed >= HCD_USB3)
 				vhci_hcd->port_status[rhport] |= USB_SS_PORT_STAT_POWER;
 			else
 				vhci_hcd->port_status[rhport] |= USB_PORT_STAT_POWER;
 			break;
 		case USB_PORT_FEAT_BH_PORT_RESET:
-			usbip_dbg_vhci_rh(
-				" SetPortFeature: USB_PORT_FEAT_BH_PORT_RESET\n");
+			usbip_dbg_vhci_rh(" SetPortFeature: USB_PORT_FEAT_BH_PORT_RESET\n");
 			if (invalid_rhport) {
 				pr_err("invalid port number %d\n", wIndex);
 				goto error;
 			}
+
 			/* Applicable only for USB3.0 hub */
 			if (hcd->speed < HCD_USB3) {
 				pr_err("USB_PORT_FEAT_BH_PORT_RESET req not "
@@ -572,12 +571,12 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			}
 			fallthrough;
 		case USB_PORT_FEAT_RESET:
-			usbip_dbg_vhci_rh(
-				" SetPortFeature: USB_PORT_FEAT_RESET\n");
+			usbip_dbg_vhci_rh(" SetPortFeature: USB_PORT_FEAT_RESET\n");
 			if (invalid_rhport) {
 				pr_err("invalid port number %d\n", wIndex);
 				goto error;
 			}
+
 			/* if it's already enabled, disable */
 			if (hcd->speed >= HCD_USB3) {
 				vhci_hcd->port_status[rhport] = 0;
@@ -601,18 +600,21 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				pr_err("invalid port number %d\n", wIndex);
 				goto error;
 			}
+
 			if (wValue >= 32)
 				goto error;
+
 			if (hcd->speed >= HCD_USB3) {
 				if ((vhci_hcd->port_status[rhport] &
 				     USB_SS_PORT_STAT_POWER) != 0) {
 					vhci_hcd->port_status[rhport] |= (1 << wValue);
 				}
-			} else
+			} else {
 				if ((vhci_hcd->port_status[rhport] &
 				     USB_PORT_STAT_POWER) != 0) {
 					vhci_hcd->port_status[rhport] |= (1 << wValue);
 				}
+			}
 		}
 		break;
 	case GetPortErrorCount:
@@ -623,7 +625,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			goto error;
 		}
 		/* We'll always return 0 since this is a dummy hub */
-		*(__le32 *) buf = cpu_to_le32(0);
+		*(__le32 *)buf = cpu_to_le32(0);
 		break;
 	case SetHubDepth:
 		usbip_dbg_vhci_rh(" SetHubDepth\n");
@@ -635,7 +637,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		break;
 	default:
 		pr_err("default hub control req: %04x v%04x i%04x l%d\n",
-			typeReq, wValue, wIndex, wLength);
+		       typeReq, wValue, wIndex, wLength);
 error:
 		/* "protocol stall" on error */
 		retval = -EPIPE;
@@ -683,7 +685,7 @@ static void vhci_tx_urb(struct urb *urb, struct vhci_device *vdev)
 	priv->vdev = vdev;
 	priv->urb = urb;
 
-	urb->hcpriv = (void *) priv;
+	urb->hcpriv = (void *)priv;
 
 	list_add_tail(&priv->list, &vdev->priv_tx);
 
@@ -705,10 +707,10 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		pr_err("invalid port number %d\n", portnum);
 		return -ENODEV;
 	}
-	vdev = &vhci_hcd->vdev[portnum-1];
+	vdev = &vhci_hcd->vdev[portnum - 1];
 
 	if (!urb->transfer_buffer && !urb->num_sgs &&
-	     urb->transfer_buffer_length) {
+	    urb->transfer_buffer_length) {
 		dev_dbg(dev, "Null URB transfer buffer\n");
 		return -EINVAL;
 	}
@@ -730,6 +732,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		spin_unlock_irqrestore(&vhci->lock, flags);
 		return -ENODEV;
 	}
+
 	spin_unlock(&vdev->ud.lock);
 
 	ret = usb_hcd_link_urb_to_ep(hcd, urb);
@@ -749,7 +752,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		struct usb_device *old;
 		__u8 type = usb_pipetype(urb->pipe);
 		struct usb_ctrlrequest *ctrlreq =
-			(struct usb_ctrlrequest *) urb->setup_packet;
+			(struct usb_ctrlrequest *)urb->setup_packet;
 
 		if (type != PIPE_CONTROL || !ctrlreq) {
 			dev_err(dev, "invalid request to devnum 0\n");
@@ -782,7 +785,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 
 		case USB_REQ_GET_DESCRIPTOR:
 			if (ctrlreq->wValue == cpu_to_le16(USB_DT_DEVICE << 8))
-				usbip_dbg_vhci_hc(
+				usbip_dbg_vhci_hc(/**/
 					"Not yet?:Get_Descriptor to device 0 (get max pipe size)\n");
 
 			vdev->udev = usb_get_dev(urb->dev);
@@ -799,7 +802,6 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 			ret =  -EINVAL;
 			goto no_need_xmit;
 		}
-
 	}
 
 out:
@@ -820,6 +822,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		usb_hcd_giveback_urb(hcd, urb, urb->status);
 		local_irq_enable();
 	}
+
 	return ret;
 }
 
@@ -876,6 +879,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	struct vhci_priv *priv;
 	struct vhci_device *vdev;
 	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&vhci->lock, flags);
 
@@ -887,14 +891,10 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		return -EIDRM;
 	}
 
-	{
-		int ret = 0;
-
-		ret = usb_hcd_check_unlink_urb(hcd, urb, status);
-		if (ret) {
-			spin_unlock_irqrestore(&vhci->lock, flags);
-			return ret;
-		}
+	ret = usb_hcd_check_unlink_urb(hcd, urb, status);
+	if (ret) {
+		spin_unlock_irqrestore(&vhci->lock, flags);
+		return ret;
 	}
 
 	 /* send unlink request here? */
@@ -957,7 +957,7 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 }
 
 static void vhci_cleanup_unlink_list(struct vhci_device *vdev,
-		struct list_head *unlink_list)
+				     struct list_head *unlink_list)
 {
 	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
 	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
@@ -1136,7 +1136,7 @@ static int hcd_name_to_id(const char *name)
 	if (c == NULL)
 		return 0;
 
-	ret = kstrtol(c+1, 10, &val);
+	ret = kstrtol(c + 1, 10, &val);
 	if (ret < 0)
 		return ret;
 
@@ -1213,12 +1213,14 @@ static int vhci_start(struct usb_hcd *hcd)
 			dev_err(hcd_dev(hcd), "init attr group failed, err = %d\n", err);
 			return err;
 		}
+
 		err = sysfs_create_group(&hcd_dev(hcd)->kobj, &vhci_attr_group);
 		if (err) {
 			dev_err(hcd_dev(hcd), "create sysfs files failed, err = %d\n", err);
 			vhci_finish_attr_group();
 			return err;
 		}
+
 		pr_info("created sysfs %s\n", hcd_name(hcd));
 	}
 
@@ -1280,10 +1282,12 @@ static int vhci_bus_resume(struct usb_hcd *hcd)
 	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
 
 	spin_lock_irqsave(&vhci->lock, flags);
+
 	if (!HCD_HW_ACCESSIBLE(hcd))
 		rc = -ESHUTDOWN;
 	else
 		hcd->state = HC_STATE_RUNNING;
+
 	spin_unlock_irqrestore(&vhci->lock, flags);
 
 	return rc;
@@ -1297,8 +1301,8 @@ static int vhci_bus_resume(struct usb_hcd *hcd)
 
 /* Change a group of bulk endpoints to support multiple stream IDs */
 static int vhci_alloc_streams(struct usb_hcd *hcd, struct usb_device *udev,
-	struct usb_host_endpoint **eps, unsigned int num_eps,
-	unsigned int num_streams, gfp_t mem_flags)
+			      struct usb_host_endpoint **eps, unsigned int num_eps,
+			      unsigned int num_streams, gfp_t mem_flags)
 {
 	dev_dbg(&hcd->self.root_hub->dev, "vhci_alloc_streams not implemented\n");
 	return 0;
@@ -1306,7 +1310,7 @@ static int vhci_alloc_streams(struct usb_hcd *hcd, struct usb_device *udev,
 
 /* Reverts a group of bulk endpoints back to not using stream IDs. */
 static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
-	struct usb_host_endpoint **eps, unsigned int num_eps,
+			     struct usb_host_endpoint **eps, unsigned int num_eps,
 	gfp_t mem_flags)
 {
 	dev_dbg(&hcd->self.root_hub->dev, "vhci_free_streams not implemented\n");
@@ -1356,6 +1360,7 @@ static int vhci_hcd_probe(struct platform_device *pdev)
 		pr_err("create primary hcd failed\n");
 		return -ENOMEM;
 	}
+
 	hcd_hs->has_tt = 1;
 
 	/*
@@ -1471,6 +1476,7 @@ static int vhci_hcd_resume(struct platform_device *pdev)
 	hcd = platform_get_drvdata(pdev);
 	if (!hcd)
 		return 0;
+
 	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	usb_hcd_poll_rh_status(hcd);
 
@@ -1502,6 +1508,7 @@ static void del_platform_devices(void)
 		platform_device_unregister(vhcis[i].pdev);
 		vhcis[i].pdev = NULL;
 	}
+
 	sysfs_remove_link(&platform_bus.kobj, driver_name);
 }
 

-- 
2.50.0


