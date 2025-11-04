Return-Path: <linux-kernel+bounces-883887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8EDC2EA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 01:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2493B7511
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 00:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CDD22154F;
	Tue,  4 Nov 2025 00:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx4eIsYk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3021E087;
	Tue,  4 Nov 2025 00:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216971; cv=none; b=H3KQexuiUBmu+PAmVdR37XQazyf1KQnbH6qvtM9SegmUsdd9+G9A9aU7c5PMGtsjX4Yj2t33K1k8/fIpOtCG2cjCXQW/IDAnfSeTFG7xrOqZLwHvDxY+FDGCtXEjz5qESqpAEeJA990463UlhorsSSv/h952U/Q2A+TKrZ4tWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216971; c=relaxed/simple;
	bh=NQHPgj7Q85ucYXFc5eaFj3394zi1UKUr6D44XAIHhRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIckNs9SJDsLnumDg+YL50SJU6EGAj/+9KV551kN9rv9lsR/n25pyml29iSLMm0rZsVt4GwneKJBFU1WBXKjp+3qZDrd1/0JgMwW1NWYXmoN4gcCmAbe2BuE4KCbbfKQFXZb/yE9MqJ2Rlt20rjzb3QTl8lrDu2ybrQ0QZHRtbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx4eIsYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3354C4CEFD;
	Tue,  4 Nov 2025 00:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762216970;
	bh=NQHPgj7Q85ucYXFc5eaFj3394zi1UKUr6D44XAIHhRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kx4eIsYk05QYtl01aXA5wgWF0LKAp+vSuHPjnJ7Os63I/ds6ItxndhSHj9XF+F1fX
	 JWrKK6yEWsGMWN/uYCcm44F6h2jibf3KQM9RKdBxJ3rjbHzUH4SM6Pg68jRcUXw8OL
	 Asfd+/Rfq9v7RHWvduJfUrYyWk9EEMzPZuXOo7sDR9C3DPSIxxNV8nL4GcKzbc+rd/
	 n9oVUCJK03fRyN4N5tO3XREWicXiPbdU4fXv6xJz9CO1Jc1EbGbC1chm25SELJFLfP
	 PFLR64SZwqlcxhH10JGLdEUfpVVGzrZCK5WYHCeqoojqQP++3buTIcvY8GZhZzLzmI
	 JzSdaqiWXjP6A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: dwc2: fix hang during suspend if set as peripheral
Date: Tue,  4 Nov 2025 08:25:03 +0800
Message-ID: <20251104002503.17158-3-jszhang@kernel.org>
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

But the dwc2_suspend() tries to read the dwc2's reg to check whether
is_device_mode or not, this would result in hang during suspend if dwc2
is configured as peripheral mode.

Fix this hang by bypassing suspend/resume if lowlevel hw isn't
enabled.

Fixes: 09a75e857790 ("usb: dwc2: refactor common low-level hw code to platform.c")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/usb/dwc2/platform.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index b07bdf16326a..ef0d73077034 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -649,9 +649,13 @@ static int dwc2_driver_probe(struct platform_device *dev)
 static int __maybe_unused dwc2_suspend(struct device *dev)
 {
 	struct dwc2_hsotg *dwc2 = dev_get_drvdata(dev);
-	bool is_device_mode = dwc2_is_device_mode(dwc2);
+	bool is_device_mode;
 	int ret = 0;
 
+	if (!dwc2->ll_hw_enabled)
+		return 0;
+
+	is_device_mode = dwc2_is_device_mode(dwc2);
 	if (is_device_mode)
 		dwc2_hsotg_suspend(dwc2);
 
@@ -728,6 +732,9 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 	struct dwc2_hsotg *dwc2 = dev_get_drvdata(dev);
 	int ret = 0;
 
+	if (!dwc2->ll_hw_enabled)
+		return 0;
+
 	if (dwc2->phy_off_for_suspend && dwc2->ll_hw_enabled) {
 		ret = __dwc2_lowlevel_hw_enable(dwc2);
 		if (ret)
-- 
2.50.0


