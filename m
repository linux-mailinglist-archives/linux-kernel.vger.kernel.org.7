Return-Path: <linux-kernel+bounces-796323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE3EB3FEF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519AD1762C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA812FB98B;
	Tue,  2 Sep 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UiGp3BPE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9769D2FAC19;
	Tue,  2 Sep 2025 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814220; cv=none; b=VefYzlgTE86MKgCYoR/0D1fC2bBbrhboRW/m5i2GECf7zz4y3Qw2lIotAjBgyyfqLeJNmicv8oAHIfwtxfFY7vtMV4yds6vtX4ppLNnycR8WUrQX10iQ8liQJ29p0sP+5agGhOK4re3ebpSDXX2vAxBvUOawj1h0mmxrj8oAeTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814220; c=relaxed/simple;
	bh=G/XUaMfPj7nOSu821gUj7psQyMgYbdlYRDCsutzu018=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aijycCSiGjqZkHnsIoaoeewlFZ9lGFVNA7H8x5zXPwQh/xlelXBvYJ9atBsmyYKzD91F/OOh9So62hLKNli3+U9fzAee2azbYpLhqb/hTTKaha5GhuHDqCiUybpg6HI69Ad8RK8wqwXt7PY0y67kh6QDf3REeW5BaUKRtioRe5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UiGp3BPE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814216;
	bh=G/XUaMfPj7nOSu821gUj7psQyMgYbdlYRDCsutzu018=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UiGp3BPECSCU2+sKCNNgPYmoSeXyt9QYYPnWZJmig2O1tMAPO7PjZT4WLAgdBMmWd
	 i6xNyrNW2GXIEIX9IL4fl/u1d76igBLmYydA+svgFlSbfmZhQPvWjZKxRaFzpRCkJv
	 Ozu5V3d8+bVu6BSoaHLa4Vh2rtpaDrWRIxipvU+F1Z8m45Og09naN+eRq8iFypnFKf
	 w/fJppCor6Yt3P5v5hXgWNucCEToB/bVaEqkkc4eVVbA0n8jfZQj4LFo8QPkCPk2kl
	 609Cz7ktMatBo571AGu280l+QgiHuc64w1yahkXd3QPHKP9oJLAHvFWOAt5Aif2qgB
	 ZPn/L4PxY9VKw==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id AFBF817E0C21;
	Tue,  2 Sep 2025 13:56:56 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:23 +0300
Subject: [PATCH 01/17] usb: vhci-hcd: Ensure lines do not end with '('
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-1-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Format code to get rid of the checkpatch complaint:

  CHECK: Lines should not end with a '('

While at it, also remove the leading whitespace from the quoted
strings passed as arguments to the affected functions.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 46 +++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index e70fba9f55d6a0edf3c5fde56a614dd3799406a1..764ade343bd4fb9d680f518ead997f6165214214 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
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
@@ -302,9 +302,8 @@ static inline void hub_descriptor(struct usb_hub_descriptor *desc)
 
 	memset(desc, 0, sizeof(*desc));
 	desc->bDescriptorType = USB_DT_HUB;
-	desc->wHubCharacteristics = cpu_to_le16(
-		HUB_CHAR_INDV_PORT_LPSM | HUB_CHAR_COMMON_OCPM);
-
+	desc->wHubCharacteristics = cpu_to_le16(HUB_CHAR_INDV_PORT_LPSM |
+						HUB_CHAR_COMMON_OCPM);
 	desc->bNbrPorts = VHCI_HC_PORTS;
 	BUILD_BUG_ON(VHCI_HC_PORTS > USB_MAXCHILDREN);
 	width = desc->bNbrPorts / 8 + 1;
@@ -378,8 +377,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				       "supported for USB 3.0 roothub\n");
 				goto error;
 			}
-			usbip_dbg_vhci_rh(
-				" ClearPortFeature: USB_PORT_FEAT_SUSPEND\n");
+
+			usbip_dbg_vhci_rh("ClearPortFeature: USB_PORT_FEAT_SUSPEND\n");
 			if (vhci_hcd->port_status[rhport] & USB_PORT_STAT_SUSPEND) {
 				/* 20msec signaling */
 				vhci_hcd->resuming = 1;
@@ -387,8 +386,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			}
 			break;
 		case USB_PORT_FEAT_POWER:
-			usbip_dbg_vhci_rh(
-				" ClearPortFeature: USB_PORT_FEAT_POWER\n");
+			usbip_dbg_vhci_rh("ClearPortFeature: USB_PORT_FEAT_POWER\n");
 			if (hcd->speed >= HCD_USB3)
 				vhci_hcd->port_status[rhport] &= ~USB_SS_PORT_STAT_POWER;
 			else
@@ -464,10 +462,9 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				VDEV_ST_NOTASSIGNED ||
 			    vhci_hcd->vdev[rhport].ud.status ==
 				VDEV_ST_USED) {
-				usbip_dbg_vhci_rh(
-					" enable rhport %d (status %u)\n",
-					rhport,
-					vhci_hcd->vdev[rhport].ud.status);
+				usbip_dbg_vhci_rh("enable rhport %d (status %u)\n",
+						  rhport,
+						  vhci_hcd->vdev[rhport].ud.status);
 				vhci_hcd->port_status[rhport] |=
 					USB_PORT_STAT_ENABLE;
 			}
@@ -502,8 +499,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	case SetPortFeature:
 		switch (wValue) {
 		case USB_PORT_FEAT_LINK_STATE:
-			usbip_dbg_vhci_rh(
-				" SetPortFeature: USB_PORT_FEAT_LINK_STATE\n");
+			usbip_dbg_vhci_rh("SetPortFeature: USB_PORT_FEAT_LINK_STATE\n");
 			if (hcd->speed < HCD_USB3) {
 				pr_err("USB_PORT_FEAT_LINK_STATE req not "
 				       "supported for USB 2.0 roothub\n");
@@ -515,12 +511,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			 */
 			break;
 		case USB_PORT_FEAT_U1_TIMEOUT:
-			usbip_dbg_vhci_rh(
-				" SetPortFeature: USB_PORT_FEAT_U1_TIMEOUT\n");
+			usbip_dbg_vhci_rh("SetPortFeature: USB_PORT_FEAT_U1_TIMEOUT\n");
 			fallthrough;
 		case USB_PORT_FEAT_U2_TIMEOUT:
-			usbip_dbg_vhci_rh(
-				" SetPortFeature: USB_PORT_FEAT_U2_TIMEOUT\n");
+			usbip_dbg_vhci_rh("SetPortFeature: USB_PORT_FEAT_U2_TIMEOUT\n");
 			/* TODO: add suspend/resume support! */
 			if (hcd->speed < HCD_USB3) {
 				pr_err("USB_PORT_FEAT_U1/2_TIMEOUT req not "
@@ -529,8 +523,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			}
 			break;
 		case USB_PORT_FEAT_SUSPEND:
-			usbip_dbg_vhci_rh(
-				" SetPortFeature: USB_PORT_FEAT_SUSPEND\n");
+			usbip_dbg_vhci_rh("SetPortFeature: USB_PORT_FEAT_SUSPEND\n");
 			/* Applicable only for USB2.0 hub */
 			if (hcd->speed >= HCD_USB3) {
 				pr_err("USB_PORT_FEAT_SUSPEND req not "
@@ -546,8 +539,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			vhci_hcd->port_status[rhport] |= USB_PORT_STAT_SUSPEND;
 			break;
 		case USB_PORT_FEAT_POWER:
-			usbip_dbg_vhci_rh(
-				" SetPortFeature: USB_PORT_FEAT_POWER\n");
+			usbip_dbg_vhci_rh("SetPortFeature: USB_PORT_FEAT_POWER\n");
 			if (invalid_rhport) {
 				pr_err("invalid port number %d\n", wIndex);
 				goto error;
@@ -558,8 +550,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				vhci_hcd->port_status[rhport] |= USB_PORT_STAT_POWER;
 			break;
 		case USB_PORT_FEAT_BH_PORT_RESET:
-			usbip_dbg_vhci_rh(
-				" SetPortFeature: USB_PORT_FEAT_BH_PORT_RESET\n");
+			usbip_dbg_vhci_rh("SetPortFeature: USB_PORT_FEAT_BH_PORT_RESET\n");
 			if (invalid_rhport) {
 				pr_err("invalid port number %d\n", wIndex);
 				goto error;
@@ -572,8 +563,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			}
 			fallthrough;
 		case USB_PORT_FEAT_RESET:
-			usbip_dbg_vhci_rh(
-				" SetPortFeature: USB_PORT_FEAT_RESET\n");
+			usbip_dbg_vhci_rh("SetPortFeature: USB_PORT_FEAT_RESET\n");
 			if (invalid_rhport) {
 				pr_err("invalid port number %d\n", wIndex);
 				goto error;
@@ -781,7 +771,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 
 		case USB_REQ_GET_DESCRIPTOR:
 			if (ctrlreq->wValue == cpu_to_le16(USB_DT_DEVICE << 8))
-				usbip_dbg_vhci_hc(
+				usbip_dbg_vhci_hc(/**/
 					"Not yet?:Get_Descriptor to device 0 (get max pipe size)\n");
 
 			vdev->udev = usb_get_dev(urb->dev);

-- 
2.51.0


