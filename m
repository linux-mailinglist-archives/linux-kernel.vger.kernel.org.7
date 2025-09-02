Return-Path: <linux-kernel+bounces-796335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61DDB3FF17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170AE165AE1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB42308F1D;
	Tue,  2 Sep 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PMv12iC+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1273002DC;
	Tue,  2 Sep 2025 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814230; cv=none; b=I1R4OZWFPeJytb9iauJTCnz7JpZdYYDBzb0lKp5LG1mnRSmcxlKd7PVRg2zQcxPTY2Fjvd+RfB4RUuHdkgdPQp//SXQaWLF/nhhtQ6puJUfXQTrWJvwxlxjQ9aRU/24GVMllCKwkZk6rl5JKCAAz05M7+QP+iliG+mrxsPB/SVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814230; c=relaxed/simple;
	bh=X3G+4Hfvkhb+UQsB/BD9eP8MNRGk6kjxDpXAACkKBqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G0sxQ+2zQNGdbRdkogeTBosu3G06axwtuWTFYGPlGDqG5qMU5/hgufo/baPHHH/6qJZmhrNz6bnhGiTzuA9woGL0kBUfV5/YIWUAnLNi9kgINGFwXsP8HVtoGlfZBpw9Mh/RCOpBc3+3EnP29XcN/yXCm/2LJ/AFbcQhPnZtt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PMv12iC+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814226;
	bh=X3G+4Hfvkhb+UQsB/BD9eP8MNRGk6kjxDpXAACkKBqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PMv12iC+cAbKQPHejVIs5nPM/vp6S5dUlPuh1DjM/UIcDWA6t8b9uFfNEUkovpen8
	 Vpk3tqaxzuvAlybZhEFOQ33/HqWZn8S3afsmdANFH5y5su4DJASVmDTRVewNp4Wq6P
	 K4orbbWnqt30nRbNFknJ7iqJiR6OwCeTovFOkJT8kZNKhKYTc2H93bhTCaG1SR+2aH
	 F4felpCo/93n1my8D1EiHLcpcNcPUHZsYSB+tcisVkrUzqmXt1e5r6M47caei5eyeY
	 mbl5YH7WXh+hP60jaBalVUHq1O6yMIfkDufSaO1+48QfRk2+pj2Yt3G0RXRweUONrX
	 JOmTc5n2PC1Mw==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id B65A117E1333;
	Tue,  2 Sep 2025 13:57:06 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:35 +0300
Subject: [PATCH 13/17] usb: vhci-hcd: Remove ftrace-like logging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-13-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Drop all superfluous log entries as reported by checkpatch:

  WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 5b4133f08d370499bdbc50fbea7ecbbc0fbd4b71..a71a542e6eec42c79cff091fe0168f44c8c9b4b2 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1260,8 +1260,6 @@ static int vhci_bus_suspend(struct usb_hcd *hcd)
 	struct vhci *vhci = *((void **)dev_get_platdata(hcd->self.controller));
 	unsigned long flags;
 
-	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
-
 	spin_lock_irqsave(&vhci->lock, flags);
 	hcd->state = HC_STATE_SUSPENDED;
 	spin_unlock_irqrestore(&vhci->lock, flags);
@@ -1275,8 +1273,6 @@ static int vhci_bus_resume(struct usb_hcd *hcd)
 	int rc = 0;
 	unsigned long flags;
 
-	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
-
 	spin_lock_irqsave(&vhci->lock, flags);
 
 	if (!HCD_HW_ACCESSIBLE(hcd))
@@ -1428,8 +1424,6 @@ static int vhci_hcd_suspend(struct platform_device *pdev, pm_message_t state)
 	int ret = 0;
 	unsigned long flags;
 
-	dev_dbg(&pdev->dev, "%s\n", __func__);
-
 	hcd = platform_get_drvdata(pdev);
 	if (!hcd)
 		return 0;
@@ -1467,8 +1461,6 @@ static int vhci_hcd_resume(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
 
-	dev_dbg(&pdev->dev, "%s\n", __func__);
-
 	hcd = platform_get_drvdata(pdev);
 	if (!hcd)
 		return 0;

-- 
2.51.0


