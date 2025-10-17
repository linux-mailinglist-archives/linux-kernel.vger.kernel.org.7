Return-Path: <linux-kernel+bounces-857851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 442A0BE8125
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F40434FE1C8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597443126A9;
	Fri, 17 Oct 2025 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijvcSNA1"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68EA3126B7
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697007; cv=none; b=LvmfY7nN/Vm+Nl1P49gnt4zrDPKMBsy++JuEd9sVZmeIkFUfzpvP1alI5kDxGmzvqLxlh+XhomDSe5q4HWzpJpRt7DuqT9JRasU8vmNVIBt+Dv2ccCw+R7vyHMkAgWx4UZpcLVt3t17x+XqEh0I5hf27ozLyTCd8NHam0G8rwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697007; c=relaxed/simple;
	bh=OzK0aYW2LWITX9fdd4z7rDbgFG5oDHlyFtFytqntWLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzD+1bPnhqynbT/aE5C45npROtjnc3Bg1gFgJMhtjDYNmDyi9p274/VxYd38v0JOVPicRYsC0XeFE0svonK4aYe8HvYmTWkP7wwBPnjO11dQR8O00CcKlZmQb7+sLPFNQyykqewoYwlgljsmdvR3+WEhrkMccSj7gv9hWDaTeSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijvcSNA1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b48d8deafaeso369593266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760697004; x=1761301804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXSMFjXcnbUgtoA/eC/AHIzf0ylAZ7zJ33rVYw0AFyk=;
        b=ijvcSNA1o4yZw8Bs0KBl8xFMPpR7+lO+gOIztjrCYiKnQMOO01o7492+R9qkApsGFC
         pl0kiHiG6uZCmJ109/nJeE8sizT4jl1ohuBtwxKRPC2xjXEqsmNwiQDWJN2X/ZAEvlwX
         w65+PeZ184vO8f3/Zh0xUPXr2TnsR5Hj3NwU3hATELuBvgjpJ7e7qak0fNGKmlQFkjDc
         iSvA5S8IPTok+RF/KXWFEJ9WjNh3TtmEV9qaRrFKpNKgNsgK/rroRyDG3V7P2iyFG2T3
         cTPZZ8W1IoliD6UqpRTxd0z7KfWdSTqWjb+15y225CuoQgvTimOhmkGtVews61UExMRe
         3CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760697004; x=1761301804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXSMFjXcnbUgtoA/eC/AHIzf0ylAZ7zJ33rVYw0AFyk=;
        b=kQyQPQWm92CTE6u0Nh7vNPublfepgWsL5zbWhT/mUs7AzxNA/iV2wG0HNFvpuMSv6m
         HUQsmnUvef8uQS9SdUQp/MpgqMGvn+Dgp7WjApYqu7Qya6xYV/m6MwMTzipZSmJvsRoo
         jmyPFT4Lo5EnijoJVCu1rMeZUUk+WZVoIyOzlYFQz8JaYup14LVj1ceiQgJcHA/xCB3h
         GuiBldwPy1nYBYyC/1GydXwtRbzvXa+o/njNqy1A7Zik8aLnGsR0806J51H98V/gQWge
         8JK86kwdPy+rEkEi29W51h2BMkIyfeZ5IGCBrgj9rc5IIMiFRvdjMjyOBW6E1ZoVOAEv
         ZqIg==
X-Forwarded-Encrypted: i=1; AJvYcCVkfdJGzkj/mY9NX2ZUMkEzi6Otj/wRdO4UaW3myaA9w8Vg0cyTxJz6RZlpyjrVu6gXpGsq3NPKTGpdnsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbYEgWs/vtS5KEeqLne4EVblWHTCzoXy/jLL5ed7aF4BH7nQhz
	+SXTzO3YLM+L5pDmjaROZaMlSvK+pp2vjhqdAlt1BhOC3HPWbHr9KdGj
X-Gm-Gg: ASbGnctdQ1gRtmgP88EOgCrh2BgGxKLJXsh9oj+oPkFrsRTbHWFrVBQRYKxwpodOwJo
	99xHurBy3IKtZ55J8l4Qan6Ic3SNqusPL4qOHhCHsdokKVr2vpYcDqQI8IH9xQW/woWr+9WbgHU
	/2U5AKHqID233Z27HQqbnNqqhKafCwB4pGOMVwG0pVMIOC6+cFbXLo3i/Pgxjc7qjlX7OeF6kTP
	x/QpT5fEp8AFIqi1ZZ248QAwXLhV+R4n6P+qHti3pN6cAh2I/PuXBd66xbFXKbM16xjWx0vo3C3
	vTEVS6nvWrtrFyp6z/Yx+NAm/ImNRQvkfkeyglSOn/6M3F7fSiKfXXnUFwYrLSu0LntCRBRBoBJ
	VGsEsoWwe8Uf0f0444b84U3hoBoJbcPZmD9gkdpPR4y7WXtdg3Xq5WvjU7RSnqjuBzHmACIberV
	UdVdYYkIJpIHDIWbxs
X-Google-Smtp-Source: AGHT+IF5gSR2M2MiuN3SoOR9pgQV4QlGdicE+1VsOagna/9hxbsiwFcdvaUC577ZxJBWxnrkc06fEw==
X-Received: by 2002:a17:907:9607:b0:b3e:26ae:7288 with SMTP id a640c23a62f3a-b6471d48331mr342475066b.8.1760697004054;
        Fri, 17 Oct 2025 03:30:04 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdacd88sm780513166b.43.2025.10.17.03.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:30:03 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: p.zabel@pengutronix.de,
	Artem Shimko <a.shimko.dev@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
Date: Fri, 17 Oct 2025 13:29:48 +0300
Message-ID: <20251017102950.206443-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017102950.206443-1-a.shimko.dev@gmail.com>
References: <20251017102950.206443-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the power management code by removing redundant wrapper functions
and using modern kernel PM macros. This reduces code duplication and
improves maintainability.

The changes convert the suspend/resume functions to take device pointer
directly instead of the chip structure, allowing removal of the runtime
PM wrapper functions. The manual PM ops definition is replaced with
DEFINE_RUNTIME_DEV_PM_OPS() macro and pm_ptr() is used for the platform
driver. Probe and remove functions are updated to call PM functions with
device pointer.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 31 ++++++-------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..8b7cf3baf5d3 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1314,8 +1314,10 @@ static int dma_chan_resume(struct dma_chan *dchan)
 	return 0;
 }
 
-static int axi_dma_suspend(struct axi_dma_chip *chip)
+static int axi_dma_suspend(struct device *dev)
 {
+	struct axi_dma_chip *chip = dev_get_drvdata(dev);
+
 	axi_dma_irq_disable(chip);
 	axi_dma_disable(chip);
 
@@ -1325,9 +1327,10 @@ static int axi_dma_suspend(struct axi_dma_chip *chip)
 	return 0;
 }
 
-static int axi_dma_resume(struct axi_dma_chip *chip)
+static int axi_dma_resume(struct device *dev)
 {
 	int ret;
+	struct axi_dma_chip *chip = dev_get_drvdata(dev);
 
 	ret = clk_prepare_enable(chip->cfgr_clk);
 	if (ret < 0)
@@ -1343,20 +1346,6 @@ static int axi_dma_resume(struct axi_dma_chip *chip)
 	return 0;
 }
 
-static int __maybe_unused axi_dma_runtime_suspend(struct device *dev)
-{
-	struct axi_dma_chip *chip = dev_get_drvdata(dev);
-
-	return axi_dma_suspend(chip);
-}
-
-static int __maybe_unused axi_dma_runtime_resume(struct device *dev)
-{
-	struct axi_dma_chip *chip = dev_get_drvdata(dev);
-
-	return axi_dma_resume(chip);
-}
-
 static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args *dma_spec,
 					    struct of_dma *ofdma)
 {
@@ -1590,7 +1579,7 @@ static int dw_probe(struct platform_device *pdev)
 	 * driver to work also without Runtime PM.
 	 */
 	pm_runtime_get_noresume(chip->dev);
-	ret = axi_dma_resume(chip);
+	ret = axi_dma_resume(chip->dev);
 	if (ret < 0)
 		goto err_pm_disable;
 
@@ -1638,7 +1627,7 @@ static void dw_remove(struct platform_device *pdev)
 	axi_dma_disable(chip);
 
 	pm_runtime_disable(chip->dev);
-	axi_dma_suspend(chip);
+	axi_dma_suspend(chip->dev);
 
 	for (i = 0; i < DMAC_MAX_CHANNELS; i++)
 		if (chip->irq[i] > 0)
@@ -1653,9 +1642,7 @@ static void dw_remove(struct platform_device *pdev)
 	}
 }
 
-static const struct dev_pm_ops dw_axi_dma_pm_ops = {
-	SET_RUNTIME_PM_OPS(axi_dma_runtime_suspend, axi_dma_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(dw_axi_dma_pm_ops, axi_dma_suspend, axi_dma_resume, NULL);
 
 static const struct of_device_id dw_dma_of_id_table[] = {
 	{
@@ -1680,7 +1667,7 @@ static struct platform_driver dw_driver = {
 	.driver = {
 		.name	= KBUILD_MODNAME,
 		.of_match_table = dw_dma_of_id_table,
-		.pm = &dw_axi_dma_pm_ops,
+		.pm = pm_ptr(&dw_axi_dma_pm_ops),
 	},
 };
 module_platform_driver(dw_driver);
-- 
2.43.0


