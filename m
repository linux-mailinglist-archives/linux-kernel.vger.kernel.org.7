Return-Path: <linux-kernel+bounces-883886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB359C2EA85
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 01:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2337D4E9491
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 00:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2F121B1BC;
	Tue,  4 Nov 2025 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZJpjyMr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC92163B2;
	Tue,  4 Nov 2025 00:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216969; cv=none; b=Gu41FCkmHeGC/iHNu0fefwgMnT14xa9sbxjpMcy7BJmLCovr2C7Xc6HFJMCk3l+7BHaxamhoggwaYRBbealQjPomUSeq3w1jYjZP0Yoe4L1f6Qsdl2FMICvDkir6PD6+XtFba8QWCl9YlXOLIFzXizEm9154S8o8hZAnOcOnaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216969; c=relaxed/simple;
	bh=h5VNqWdnCTD1BhwDnGPO0h92CokXkEyMz8mp8dZE01U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lsrylx3i9EY9vwImMkZQifBDnsuR/wFmaq4AWXk8EWbckn0QFv7dnb1VjutBAT8lQIHdZi5Kh06ojxJjlflzC1WE/1vBRAe7d9Pa/1Jv4c6eYFCezrPFjxeqTomQSMXQMV7LVjDl0m41OQSkrm0ZT0G8p463oxP8WYrf3BLYw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZJpjyMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDF1C4CEE7;
	Tue,  4 Nov 2025 00:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762216969;
	bh=h5VNqWdnCTD1BhwDnGPO0h92CokXkEyMz8mp8dZE01U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZJpjyMrjWBJ7M+2qAWt9+rAjyVWXAy4CDm1kn0KgAnWR7I/iNlFjYr50nUFZ9897
	 Mz7/Z4mBXB5/Fzyh+pO6dzlVd9Fid4H9hOUcuX+MxOU59hT0aBH2g/LQuHdOMOMzMT
	 J1X0keLN5vI54f9RsUEHNbc4gD6JQQvrcSvKQroW/kfQNaZ3NiJWveAalvmZmizgo+
	 E3drWMmA9qCjCrrHmYclTICj2duZNL8p8ofii1ZjoFx0n8EWThIhgXTOLS7stiK94X
	 XgqDoXHKNtUSnWEl/X7QGd1S/OZFR4x9P4BqqpX2gujzpuqST5g22Zn/hCFnis1/uK
	 /wHN7SVmsJJ4A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usb: dwc2: fix hang during shutdown if set as peripheral
Date: Tue,  4 Nov 2025 08:25:02 +0800
Message-ID: <20251104002503.17158-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251104002503.17158-1-jszhang@kernel.org>
References: <20251104002503.17158-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dwc2 on most platforms needs phy controller, clock and power supply.
All of them must be enabled/activated to properly operate. If dwc2
is configured as peripheral mode, then all the above three hardware
resources are disabled at the end of the probe:

	/* Gadget code manages lowlevel hw on its own */
	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL)
		dwc2_lowlevel_hw_disable(hsotg);

But dwc2_driver_shutdown() tries to disable the interrupts on HW IP
level. This would result in hang during shutdown if dwc2 is configured
as peripheral mode.

Fix this hang by only disable and sync irq when lowlevel hw is enabled.

Fixes: 4fdf228cdf69 ("usb: dwc2: Fix shutdown callback in platform")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/usb/dwc2/platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 3f83ecc9fc23..b07bdf16326a 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -369,11 +369,11 @@ static void dwc2_driver_shutdown(struct platform_device *dev)
 {
 	struct dwc2_hsotg *hsotg = platform_get_drvdata(dev);
 
-	dwc2_disable_global_interrupts(hsotg);
-	synchronize_irq(hsotg->irq);
-
-	if (hsotg->ll_hw_enabled)
+	if (hsotg->ll_hw_enabled) {
+		dwc2_disable_global_interrupts(hsotg);
+		synchronize_irq(hsotg->irq);
 		dwc2_lowlevel_hw_disable(hsotg);
+	}
 }
 
 /**
-- 
2.50.0


