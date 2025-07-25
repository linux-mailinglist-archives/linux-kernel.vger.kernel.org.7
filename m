Return-Path: <linux-kernel+bounces-746424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2401B1268C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83229AC3C37
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63A525F96D;
	Fri, 25 Jul 2025 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KkTHft0T"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1C233727;
	Fri, 25 Jul 2025 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481304; cv=none; b=J2L/2wZqt7Aa2X4W8SRtJBDz099dWJivN1GdfhQEFmujDDwzH+Rs/dEBcjpK76Ymut3HjIui3ZQDK2N1tAuuFEra0Vb4J/VtRRvEEpQm/uO0QG28J24zQAEdIT9GOvn5fhI1OXwBAXdYE6quWUZqyuWnV72PDa9wfCfjZ38OOAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481304; c=relaxed/simple;
	bh=KIDKVbMIjmNKsNhFukh7yRi1QC18aCvH853jRSmpofA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikACxgXrGxkfyG5O+sx6wtR5TANmeSPXP7yt4xMab29D+V+Tc5APCYbAcdo4Gqw9t3MFaIbvXRKivcLVQaH8IKIugwWMk5d7B0liBQFFEByZpfHh2B9Uimms6pwVCmntca1rKR4thUL9x/abrQhDrrAxGttZ7WiSAh+khQIPEek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KkTHft0T; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481300;
	bh=KIDKVbMIjmNKsNhFukh7yRi1QC18aCvH853jRSmpofA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KkTHft0TWVJmF7K2YFxREEQf9e2SHqxg99hTBZ2MPqZSHaZG+vrIbverOgYNp/o2Z
	 Bae13UvkcpFyrXxkTH2CazxvCgsba68fD/PfTX2//S8vdwXYvOx2Iqnb1IPxJWt5ac
	 Me/wTbUpOYo588luEwVMfPAbbPALrHKk7EmWbf5ck1m/hJ1Rrl1kfPIA7NWBfM9er7
	 FEFiyKtBqiQVacBO8TwETjO1aWMkeuX5HvFl7VrEbVeQ2bWP7W95ONoc79wVIkt1UB
	 5cMpbbFJDietusmyK9Ja6GO/mME0m2E5TP05c+uzGV5031LatYh5ijXFKhxFvDh0px
	 rPyYOtRPLCaUQ==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 0C19017E12A1;
	Sat, 26 Jul 2025 00:08:20 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:04 +0300
Subject: [PATCH v2 02/18] usb: vhci-hcd: Ensure lines do not end with '('
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-2-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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
index b4b0ed5d64966214636b157968478600e2e4178a..ec82a8dcabb90fd975e5a216c6e0835d2010a7b6 100644
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
@@ -792,7 +782,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 
 		case USB_REQ_GET_DESCRIPTOR:
 			if (ctrlreq->wValue == cpu_to_le16(USB_DT_DEVICE << 8))
-				usbip_dbg_vhci_hc(
+				usbip_dbg_vhci_hc(/**/
 					"Not yet?:Get_Descriptor to device 0 (get max pipe size)\n");
 
 			vdev->udev = usb_get_dev(urb->dev);

-- 
2.50.0


