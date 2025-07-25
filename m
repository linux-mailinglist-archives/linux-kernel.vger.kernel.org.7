Return-Path: <linux-kernel+bounces-746436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C105B126A5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A931CE0E96
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A37270ECB;
	Fri, 25 Jul 2025 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EDom1ztz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0D26F44D;
	Fri, 25 Jul 2025 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481313; cv=none; b=rivbdmTCmDD6z5vOtyJ7bW8NIkZ/+R4gXdD83PqaZP9O7BLzn1LawU3j47JnKRaW1yDiFQQs5fAH38+jEuQmS1ykxS6t0EqmutmxX549B12dNpCqUDixS8SMrQaF0ajDiACT/OQ8c3+fhGXpkypdO8dhzoxeEuxC9ypq2dZlfSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481313; c=relaxed/simple;
	bh=jBm6bfBaZCWVHi9mKVYcuIFQ5VRypBtpWf4Hy86neuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCxKiOq8+w1vjkt3pDqqzF3epOwcZB+25O4DkF7xE4kYd0LKW3jCSKHbvJYQKEG72v3VpAL/IvJEfqNMNh2pQ9SW/qW/ZJij0pfDX7lvLnk40upa2X3gBtWeXRJJwK06pUB/TOWvg04DD0GtN6REd4MsldooBapF/ilBCFiCbXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EDom1ztz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481310;
	bh=jBm6bfBaZCWVHi9mKVYcuIFQ5VRypBtpWf4Hy86neuw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EDom1ztzVT2WY6NJmoIRWG36FHnr15NA4eNCaU+4SJZC550tJCitX2893yQ9JJGIq
	 E2xaPcwkn798is/e++XWFAJUHb34j2vJ4g4V6KMyyT9EgOKzDRIhab5TL3Xs0+eMWW
	 Ab2D0Lcez/+tyECttAuA0NOVTzpTxqFR8CLGW/8pToZhWvl0TLy0bhX3EVsUgn31Tb
	 WDoUYpsj6+zcfrWGBm60lHyh7ak4Oszlpk7zUf5afPnY7HwuczdBLR7sRlLBFkSunV
	 lfU12c+TyeoxcMM4gbhz7tWXPTSeXduehBWCHE8cmy7zFaWhSjUgeq8PI/wvfCK+aW
	 kXS4tMbAjQHHA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 23A5A17E154C;
	Sat, 26 Jul 2025 00:08:30 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 26 Jul 2025 01:08:16 +0300
Subject: [PATCH v2 14/18] usb: vhci-hcd: Remove ftrace-like logging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-14-189266dfdfaa@collabora.com>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Drop all superfluous log entries as reported by checkpatch:

  WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 0a552cf93be5d55409e2cffabce4c7a68e1360c4..f37f5f3680c2f1be8ed056d5c8579d75a0d0ad25 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1282,8 +1282,6 @@ static int vhci_bus_suspend(struct usb_hcd *hcd)
 	struct vhci *vhci = *((void **)dev_get_platdata(hcd->self.controller));
 	unsigned long flags;
 
-	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
-
 	spin_lock_irqsave(&vhci->lock, flags);
 	hcd->state = HC_STATE_SUSPENDED;
 	spin_unlock_irqrestore(&vhci->lock, flags);
@@ -1297,8 +1295,6 @@ static int vhci_bus_resume(struct usb_hcd *hcd)
 	int rc = 0;
 	unsigned long flags;
 
-	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
-
 	spin_lock_irqsave(&vhci->lock, flags);
 
 	if (!HCD_HW_ACCESSIBLE(hcd))
@@ -1450,8 +1446,6 @@ static int vhci_hcd_suspend(struct platform_device *pdev, pm_message_t state)
 	int ret = 0;
 	unsigned long flags;
 
-	dev_dbg(&pdev->dev, "%s\n", __func__);
-
 	hcd = platform_get_drvdata(pdev);
 	if (!hcd)
 		return 0;
@@ -1489,8 +1483,6 @@ static int vhci_hcd_resume(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
 
-	dev_dbg(&pdev->dev, "%s\n", __func__);
-
 	hcd = platform_get_drvdata(pdev);
 	if (!hcd)
 		return 0;

-- 
2.50.0


