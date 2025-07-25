Return-Path: <linux-kernel+bounces-746425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E44DB1268E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A738AE3F48
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4D925FA0A;
	Fri, 25 Jul 2025 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UX1LbHVI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFB221703;
	Fri, 25 Jul 2025 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481304; cv=none; b=LCW5I/e+8Fb/1nyCf88GVPfTh4kBaIqje4j7pNRozmcX48ow7RpZX8LZ5IfXHoFcsa6hvjXh5RiE6hOgVIL4yAG8x5bVel/312cp9y2TKTSyghN7OnWIdL7yKfPrrAvOYDVrBb+n3AfOZA/I+IYhy8vjUWekYIXef/mLoNI1lfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481304; c=relaxed/simple;
	bh=Y4TJVkfkRTXKcJwkJcS+G3Yye3rX4fOXCfZPRoeos+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U4t9LJpD/VYsZVwP3vakIB08CKQGr0TzZmRwyLgqf2nJBO0ton/Eg+/0Y96hhFIarQ5NifwFfvHj6nZRIgQ5+ykZ96NbyzWsxAH2t/eX465T0+Hb4edei/RCdQJOe0TtFDO2vjMFPu7AbNXy35mRhdejf7QPN3CeQoSh8dSwz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UX1LbHVI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481301;
	bh=Y4TJVkfkRTXKcJwkJcS+G3Yye3rX4fOXCfZPRoeos+c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UX1LbHVIDlXU7af4N5Xoc0ekEtC/lwm/oodPMpAFJw0q7O5M2XKQeg96AdOKZ3PmS
	 UdOj8cipVeCgD2NLi1wtcyr7ulA650XousH1aa6OL/Vh/BqwMs3TstF0oVYKfzuBel
	 qu/Ccv8baIT3eO+qsSj3XC+JXoZ7WLCxeUNGMICsw3d3pZmnR4fYQ0FGBUj3OCOCH0
	 RWQJUmxYoW3bsrUfg45p0cEIofo7lImqz1UUsv1vYTuOySFxBJ37HikD71QrVJqhfN
	 d8yS71ES1a/RCYCYtBkcvuqGHhk7el+rXBfWth5oJp8KRs0G8Eps9eoIBNM4UbdEsr
	 KCfnZYdsO77kg==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id CDD5217E1314;
	Sat, 26 Jul 2025 00:08:20 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:05 +0300
Subject: [PATCH v2 03/18] usb: vhci-hcd: Consistently use the braces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-3-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Fix the inconsistent usage of braces as reported by checkpatch:

  CHECK: braces {} should be used on all arms of this statement
  CHECK: Unbalanced braces around else statement

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index ec82a8dcabb90fd975e5a216c6e0835d2010a7b6..dfdd6ae2cf95c7d5a24d97f713d86588c2dab350 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -346,8 +346,9 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		invalid_rhport = true;
 		if (wIndex > VHCI_HC_PORTS)
 			pr_err("invalid port number %d\n", wIndex);
-	} else
+	} else {
 		rhport = wIndex - 1;
+	}
 
 	vhci_hcd = hcd_to_vhci_hcd(hcd);
 	vhci = vhci_hcd->vhci;
@@ -598,11 +599,12 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
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

-- 
2.50.0


