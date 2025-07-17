Return-Path: <linux-kernel+bounces-735568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B86AB09114
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1853B9DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B862FCFC9;
	Thu, 17 Jul 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DoefK9r0"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17CE2FC3A0;
	Thu, 17 Jul 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767734; cv=none; b=DeXPLwY2FKxP/fn7vFkYGQ8t3MzteCLZL4KR+u+k0JKsakfqWSmqiyX4YqHsM4ptwGtVCkw1Xh7aLnxTwzCOdN6DAZCxNwCvHKchhzA8dzJIbiJpAdHeJPKkqKsa10JyI+z8uwTTS9Fgdqx7DGThzFFSYmdjyI6qrhlI1a/fk/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767734; c=relaxed/simple;
	bh=yAcMEUIV0dG0+uHEGl30q+AsJo3WbPvIl4PIcWkT/sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WCbTnFJpcdX+WalMUNkxc/aX9XCZzOleoWCOmoOhWFwfyIcO2vihy08YT9fv2uKmF4xqaaDYR/e79yIlALBiD5u4S1jjiMDzgx4GaQMv9oIcEvDOSP4Z5e0FehnkjRTC972r3L6/1XEDGkuxwUfVUgmK0fNNtCw6vzx85S//vnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DoefK9r0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752767731;
	bh=yAcMEUIV0dG0+uHEGl30q+AsJo3WbPvIl4PIcWkT/sI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DoefK9r0l+Bu6P1Vc+y9ZzTOvkzQzR0yd37KwcTHXwW0qO2kkQ+QVdB+s/tL3njg+
	 AFiqIr0NFX6wteuVens2Og4CRs4TBNvaATCNs8UeuTy9oqLDp9wD8YEC95HKFMNtXj
	 vCE0Zrf0PctN8ykM9V0dnHv0d2ccJDOdQy1buY5lkYM5DwBC+eXFyOVtdZK9MTu6Rn
	 JReAQlb+8W9xn3xLrydTgzh3i5ULG9TUQwuy3sYs1M61+Pt5LiKz8ezddNKBDuw5cQ
	 WxRt8SIn/ky6lwa948cA346hcUococaQHnU7n+27DncKDwrm7qmS9C+j9k5iWqu8GZ
	 T/ICEYQ2flAEg==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 172EE17E14E7;
	Thu, 17 Jul 2025 17:55:31 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 17 Jul 2025 18:54:57 +0300
Subject: [PATCH 8/9] usb: vhci-hcd: Consistently use __func__
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-vhci-hcd-suspend-fix-v1-8-2b000cd05952@collabora.com>
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
In-Reply-To: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Replace all explicit function names in string literals with __func__ and
silent several checkpatch complaints similar to the following one:

  WARNING: Prefer using '"%s...", __func__' to using 'vhci_start', this function's name, in a string

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 841902482fb15d1d86525f23492e4966f35630a0..95034440c84f931bdf47552b499e0fdc6f726e59 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -160,7 +160,7 @@ void rh_port_connect(struct vhci_device *vdev, enum usb_device_speed speed)
 	u32		status;
 	unsigned long	flags;
 
-	usbip_dbg_vhci_rh("rh_port_connect %d\n", rhport);
+	usbip_dbg_vhci_rh("%s %d\n", __func__, rhport);
 
 	spin_lock_irqsave(&vhci->lock, flags);
 
@@ -194,7 +194,7 @@ static void rh_port_disconnect(struct vhci_device *vdev)
 	u32		status;
 	unsigned long	flags;
 
-	usbip_dbg_vhci_rh("rh_port_disconnect %d\n", rhport);
+	usbip_dbg_vhci_rh("%s %d\n", __func__, rhport);
 
 	spin_lock_irqsave(&vhci->lock, flags);
 
@@ -1172,7 +1172,7 @@ static int vhci_start(struct usb_hcd *hcd)
 	int id, rhport;
 	int err;
 
-	usbip_dbg_vhci_hc("enter vhci_start\n");
+	usbip_dbg_vhci_hc("enter %s\n", __func__);
 
 	if (usb_hcd_is_primary_hcd(hcd))
 		spin_lock_init(&vhci_hcd->vhci->lock);
@@ -1299,7 +1299,7 @@ static int vhci_alloc_streams(struct usb_hcd *hcd, struct usb_device *udev,
 			      struct usb_host_endpoint **eps, unsigned int num_eps,
 			      unsigned int num_streams, gfp_t mem_flags)
 {
-	dev_dbg(&hcd->self.root_hub->dev, "vhci_alloc_streams not implemented\n");
+	dev_dbg(&hcd->self.root_hub->dev, "%s not implemented\n", __func__);
 	return 0;
 }
 
@@ -1308,7 +1308,7 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 			     struct usb_host_endpoint **eps, unsigned int num_eps,
 	gfp_t mem_flags)
 {
-	dev_dbg(&hcd->self.root_hub->dev, "vhci_free_streams not implemented\n");
+	dev_dbg(&hcd->self.root_hub->dev, "%s not implemented\n", __func__);
 	return 0;
 }
 

-- 
2.50.0


