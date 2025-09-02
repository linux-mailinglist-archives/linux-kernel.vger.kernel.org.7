Return-Path: <linux-kernel+bounces-796337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAE9B3FF18
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079F7171A8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855EB30AAD6;
	Tue,  2 Sep 2025 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BP1MMOSS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7DA255F5C;
	Tue,  2 Sep 2025 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814231; cv=none; b=Z2mC8JZvVAPWPAqwkd+zdaOlLDV9WYrlHWbiLRrgQ5MzZ36M090XfHH1Bd5uSAEM13MffGZQnGGMJYaU5zKA8AEriVo1tB2UOw0jN9QRxa8zX794Y+CNawU9O2KvXF/10H6M49K/miodFFK4tww/qswAF7WBSPLk+sVQAazSuxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814231; c=relaxed/simple;
	bh=KGlUlP+wqP8TkULvUNOhgzB0XAxuC0vVIsj3uFCmKRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FL++IF8kEeAbziVVD7q6kfHCKXOkDqqwM4MJtu8+mrdf96lrDOjsEuWjoZJF39sRqQIcppe5CfH0bQmsEnxUq1NXqdkOJkEzBwW8VvKWIjQZLlTt5vffAYtyrbhsMCYfKqzFrjgg8JlAHAr8nj8OK2FK3sPZs3DZs5tGCZJDYME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BP1MMOSS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814228;
	bh=KGlUlP+wqP8TkULvUNOhgzB0XAxuC0vVIsj3uFCmKRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BP1MMOSSTBo7VEaXomhy/iR+6nI5qUMk4Ph9SeYS7NnudVVB56ryt0/X7tVdtKp+V
	 6kDxx8jpSnA3/2hBJ7475aFOIt8ueHMpPAkVSaFkZsvI/RqlHTr63FBZCueQ4OsE5Y
	 NhLZOImCADkWXmPSggonbJuVYVXeYn77+vHW1+4PMTkJcXYKWpT+WdWG/38RKIazbP
	 bRitUhOf5DNPds6zc4xw7rHXvObZiI4vxGG7TYyjk6Z16/99kBQDcq0Zrm6Kij07Ho
	 lJdfgp+AF/zVwJOk/8AuePTya3VxHVPH2QetACzSRUrj1N4qVmQw5Igun8ohfTsAMh
	 HLCTvx3bjMfHg==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 46C4117E135D;
	Tue,  2 Sep 2025 13:57:08 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:37 +0300
Subject: [PATCH 15/17] usb: vhci-hcd: Do not split quoted strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-15-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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
index c790e3a435e2b1493c1ed88d3a98edb7c2e35912..9e88fe6424f723709c07e91df21481ae91c1f1b5 100644
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
2.51.0


