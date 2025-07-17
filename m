Return-Path: <linux-kernel+bounces-735565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BDCB0910C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6443A1FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6A12FC3B3;
	Thu, 17 Jul 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B/lh5RBE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921C2FA648;
	Thu, 17 Jul 2025 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767732; cv=none; b=U8diUwsTYsmjgPUJYf1Nay8jJ8Y9DQ3DSsB7FKh/pZCGfyyV5BkfS67lo+TjFgwSaayKXsPB0wgS0Ui656xTZvR9iHkwsh8VhrvWaJ+eMYQvsjJOrC7DOUkNtLoLYKIQY/lvthvwpN3WHfxXWz02Ur/Hb/krilpNXrdqrABOlnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767732; c=relaxed/simple;
	bh=2URY2vrp2VUg0fswoG7QKU1FIa8Q8yhLzv1tO9NJNAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yj48C3qkH/kUdxbHQL1b4WqIOpzGQAf4Mx2KYio7U80JBw2irHiE/b2ZsbGB1kH6EYHDf2gXZbs7Optt3vFgXyZkXrqpjp8Kik6+kcowEES/qc+wYLq+hcPqYoc7W80QD964ZgsT/Om+/dHu2aEXAvQj/T5pDUm+pwZOlpsOO38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B/lh5RBE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752767728;
	bh=2URY2vrp2VUg0fswoG7QKU1FIa8Q8yhLzv1tO9NJNAQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B/lh5RBEiLP5WH1UEVT9t6HBvwNbbV6nYq5o6OoBBCtiqPZ6RG0fqI3jDxDBhwrzs
	 8TlIN2kb4YQSKpveBe7gHDBH6V9NC36YZsLj9VCTrKSCw6G1v85z1E9Wpjety6niQG
	 p/UqwVECnvZzoJQFxlEeK8KBNeNEZTVi+NEnN2JdN8HgyELp+F75ZGf8K+kk5bOWxE
	 Sq6cnplAHl9aTO0M1GbvCkU0VjpysxlXPNTs4nmmjmmtlNQ3ORZuHqXp8GNjfkQzMU
	 M6jIVaLRozDMeHy+nrK3q9aOBDFEXd8fFh+iAEPFRseoBPpBHIvtX8Ge5DJlOXE49L
	 98wQbtunyZu1Q==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 9A2D217E1336;
	Thu, 17 Jul 2025 17:55:28 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 17 Jul 2025 18:54:54 +0300
Subject: [PATCH 5/9] usb: vhci-hcd: Do not split quoted strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-vhci-hcd-suspend-fix-v1-5-2b000cd05952@collabora.com>
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
In-Reply-To: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
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

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 3f888455d238b983a6aafa52418fb89a914c32b5..53691d5e77d386b0b0e16fe9d08824baa04c0b1e 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -376,8 +376,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 			if (hcd->speed >= HCD_USB3) {
-				pr_err(" ClearPortFeature: USB_PORT_FEAT_SUSPEND req not "
-				       "supported for USB 3.0 roothub\n");
+				pr_err(" ClearPortFeature: USB_PORT_FEAT_SUSPEND req not supported for USB 3.0 roothub\n");
 				goto error;
 			}
 
@@ -506,8 +505,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_LINK_STATE:
 			usbip_dbg_vhci_rh(" SetPortFeature: USB_PORT_FEAT_LINK_STATE\n");
 			if (hcd->speed < HCD_USB3) {
-				pr_err("USB_PORT_FEAT_LINK_STATE req not "
-				       "supported for USB 2.0 roothub\n");
+				pr_err("USB_PORT_FEAT_LINK_STATE req not supported for USB 2.0 roothub\n");
 				goto error;
 			}
 
@@ -523,8 +521,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			usbip_dbg_vhci_rh(" SetPortFeature: USB_PORT_FEAT_U2_TIMEOUT\n");
 			/* TODO: add suspend/resume support! */
 			if (hcd->speed < HCD_USB3) {
-				pr_err("USB_PORT_FEAT_U1/2_TIMEOUT req not "
-				       "supported for USB 2.0 roothub\n");
+				pr_err("USB_PORT_FEAT_U1/2_TIMEOUT req not supported for USB 2.0 roothub\n");
 				goto error;
 			}
 			break;
@@ -532,8 +529,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			usbip_dbg_vhci_rh(" SetPortFeature: USB_PORT_FEAT_SUSPEND\n");
 			/* Applicable only for USB2.0 hub */
 			if (hcd->speed >= HCD_USB3) {
-				pr_err("USB_PORT_FEAT_SUSPEND req not "
-				       "supported for USB 3.0 roothub\n");
+				pr_err("USB_PORT_FEAT_SUSPEND req not supported for USB 3.0 roothub\n");
 				goto error;
 			}
 
@@ -565,8 +561,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 			/* Applicable only for USB3.0 hub */
 			if (hcd->speed < HCD_USB3) {
-				pr_err("USB_PORT_FEAT_BH_PORT_RESET req not "
-				       "supported for USB 2.0 roothub\n");
+				pr_err("USB_PORT_FEAT_BH_PORT_RESET req not supported for USB 2.0 roothub\n");
 				goto error;
 			}
 			fallthrough;
@@ -620,8 +615,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	case GetPortErrorCount:
 		usbip_dbg_vhci_rh(" GetPortErrorCount\n");
 		if (hcd->speed < HCD_USB3) {
-			pr_err("GetPortErrorCount req not "
-			       "supported for USB 2.0 roothub\n");
+			pr_err("GetPortErrorCount req not supported for USB 2.0 roothub\n");
 			goto error;
 		}
 		/* We'll always return 0 since this is a dummy hub */
@@ -630,8 +624,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	case SetHubDepth:
 		usbip_dbg_vhci_rh(" SetHubDepth\n");
 		if (hcd->speed < HCD_USB3) {
-			pr_err("SetHubDepth req not supported for "
-			       "USB 2.0 roothub\n");
+			pr_err("SetHubDepth req not supported for USB 2.0 roothub\n");
 			goto error;
 		}
 		break;

-- 
2.50.0


