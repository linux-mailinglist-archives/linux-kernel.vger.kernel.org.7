Return-Path: <linux-kernel+bounces-746438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9795BB126A7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAAEE1CE1237
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D201526158D;
	Fri, 25 Jul 2025 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jSd2SE6s"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A352701D2;
	Fri, 25 Jul 2025 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481315; cv=none; b=Qyzj95P9+JLBW+Tw7oiWnbC9ME0XjGHE/kiNEng3OiexZFu2hygjxnf/O+gfsZyBRHyAu7W2lXvZftHsqZa+lQ3TURUBY5ciAixWaDYqLuQFgEzkW8iqlT7U1uPBYZdFTNxcXbTkkMvQYiNE9UpvJ8vS2HURvK7LCardS6EbHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481315; c=relaxed/simple;
	bh=WFxQT5F/weiZK3TGl9+364zxlnGP1pNFv66Myqb2rXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxZ/v52zqIryH0Gw3+GNAM8hQbacc+B7RaWCz689NXPkzo0UZm49AcduF/hkwR5zcuY0iIZvN6kcSYYvmPqgFUmc9lIx6U3lwLOvWWNjl33n625JrclEZt6NWUJLKKJgy62s1OG/0fYJkEmHEVdGSzOmAp3uBALBmBVN+QHR06w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jSd2SE6s; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481311;
	bh=WFxQT5F/weiZK3TGl9+364zxlnGP1pNFv66Myqb2rXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jSd2SE6sjEut61xq8bbDQzGWrpACr5Yclm1hVIP6cfsCrxXocD/R1WiXoWNxNwfRB
	 Mx9RfAS8k2P8CNvzI7A1uJtXF/lqEtlIiXiCje8FlPkut1yCMT+fcQkUC2cwRyQAbL
	 0x/76ekmIERDngrbZk3O/BKvvivfaIQRTiNx3gIBBdJN2LDLEXruiYISK/rIomRSxr
	 nkmaYYp/8iuQzvUTn+bo6hFPzmzMJYOGcRZAnAh1/hEcNPANoFATSbJPer1sBZBAr2
	 DhwVvrh7AEd/OxbSWURsmMN+6UIoJBD0U/T/TFvC6CxWYEXfxqcavuF+0cwMo36a4B
	 Uk21+jP2QboPQ==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id B6C4817E156C;
	Sat, 26 Jul 2025 00:08:31 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:18 +0300
Subject: [PATCH v2 16/18] usb: vhci-hcd: Do not split quoted strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-16-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Join the split strings to make checkpatch happy and regain ability to
grep for those log messages in the source code:

  WARNING: quoted string split across lines

While at it, replace the affected pr_err() calls with dev_err().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 00377a7cbebd4e0de3f9a0fb756d93c9cedac148..73c5979fee3ce345ea2c212fea03adabde55243a 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -377,8 +377,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 			if (hcd->speed >= HCD_USB3) {
-				pr_err(" ClearPortFeature: USB_PORT_FEAT_SUSPEND req not "
-				       "supported for USB 3.0 roothub\n");
+				dev_err(hcd_dev(hcd),
+					"ClearPortFeature: USB_PORT_FEAT_SUSPEND req not supported for USB 3.0 roothub\n");
 				goto error;
 			}
 
@@ -507,8 +507,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_LINK_STATE:
 			usbip_dbg_vhci_rh("SetPortFeature: USB_PORT_FEAT_LINK_STATE\n");
 			if (hcd->speed < HCD_USB3) {
-				pr_err("USB_PORT_FEAT_LINK_STATE req not "
-				       "supported for USB 2.0 roothub\n");
+				dev_err(hcd_dev(hcd),
+					"USB_PORT_FEAT_LINK_STATE req not supported for USB 2.0 roothub\n");
 				goto error;
 			}
 
@@ -524,8 +524,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			usbip_dbg_vhci_rh("SetPortFeature: USB_PORT_FEAT_U2_TIMEOUT\n");
 			/* TODO: add suspend/resume support! */
 			if (hcd->speed < HCD_USB3) {
-				pr_err("USB_PORT_FEAT_U1/2_TIMEOUT req not "
-				       "supported for USB 2.0 roothub\n");
+				dev_err(hcd_dev(hcd),
+					"USB_PORT_FEAT_U1/2_TIMEOUT req not supported for USB 2.0 roothub\n");
 				goto error;
 			}
 			break;
@@ -533,8 +533,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			usbip_dbg_vhci_rh("SetPortFeature: USB_PORT_FEAT_SUSPEND\n");
 			/* Applicable only for USB2.0 hub */
 			if (hcd->speed >= HCD_USB3) {
-				pr_err("USB_PORT_FEAT_SUSPEND req not "
-				       "supported for USB 3.0 roothub\n");
+				dev_err(hcd_dev(hcd),
+					"USB_PORT_FEAT_SUSPEND req not supported for USB 3.0 roothub\n");
 				goto error;
 			}
 
@@ -566,8 +566,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 			/* Applicable only for USB3.0 hub */
 			if (hcd->speed < HCD_USB3) {
-				pr_err("USB_PORT_FEAT_BH_PORT_RESET req not "
-				       "supported for USB 2.0 roothub\n");
+				dev_err(hcd_dev(hcd),
+					"USB_PORT_FEAT_BH_PORT_RESET req not supported for USB 2.0 roothub\n");
 				goto error;
 			}
 			fallthrough;
@@ -621,8 +621,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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
@@ -631,8 +631,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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

-- 
2.50.0


