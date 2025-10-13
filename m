Return-Path: <linux-kernel+bounces-850841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53989BD466F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D233E1FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40F530E855;
	Mon, 13 Oct 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIzWI5jm"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4425230E84F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367803; cv=none; b=JQiQ7BjdDij+ta4fQMBhWxMmCXspnR82mgfr8kTFtOqAW9pKOtm3DBRoIomXvhQ+9EdbPhRKPEttNfqy6wOieaBEcVaN5AwSRXN7iOJsTqEdxxHgUTejJ/03/mf9JLRw2l/lWEfQO5B1OOUDSpPXs1eGgALy7C1AutmWobL5710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367803; c=relaxed/simple;
	bh=OzK0aYW2LWITX9fdd4z7rDbgFG5oDHlyFtFytqntWLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eX6jVLiyxWuYMbUFhwntM119qjszyGMNfBqgQB7/5eCaKACS1L/RUeGuS8vg1ZuHco+N7eAoB3tN3dr25HvLinRioy8tD6UnxFAmlPRC7mnyVI5gQPU9zeu9gfyO/uvpfEJXav7EUCkYcE69Jngg7ITo9Y6Bua4WfH4c/cPTUjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIzWI5jm; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso724434166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367799; x=1760972599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXSMFjXcnbUgtoA/eC/AHIzf0ylAZ7zJ33rVYw0AFyk=;
        b=KIzWI5jm6d4NAvRN8ov3Ehp4l4UiXqcDbDLv2khd3EUnlROlFkt4TwzK4YQTATCR8e
         mbUE+3ZWCaNJzpIzrLa1z7PxOa5pP8nB4aB6hZlI1lwkPPUacT/9ZvrFRgpXLkgK9iCJ
         Dg4U1gCCEZzN/+1vJw9j7RPGhFDEB8PZJjEh6AINhrKQkyXbKdtazB0KJRkhOYuTv9sR
         undva1bYu/OsFpKDVH+xLWqSngEh9moGFb+uYpkSI94dG312eg/V235PkHp4LGqliBAk
         7bvByDhzaEIbI/zmFQVGMU4Vow35SFxdMoTd0rvjNlogFwAzlJftSAVO/oc1Fydcn8/1
         uWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367799; x=1760972599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXSMFjXcnbUgtoA/eC/AHIzf0ylAZ7zJ33rVYw0AFyk=;
        b=TmZ3oiCM3uE5HMbErB8oKTg3vz7LqTaI2HB9ikZUa5m5W+Kw3XEkylyD7t0WFKLaLb
         4J0mcKtUg5I07OWXZNK8lUB19FUS51L+08gyIaTYCS5cd8ob5xCRX1fPmfF0BFpai7bj
         JYPDx3fxORmWGL3Q4cGLvAVD5cGNK8IBxwSk38XY17zlZM3uXgqcbc6sI0p8X7XRVqca
         9xJzeB+Mkh8jE9p/Sc0D8xO868OwRB4Vs19t7gTckNkvDW3r/aC1/c/JP3/gxVxFwmUs
         baHAE56gHADwsWRY6w1VlcKMRGbwZHY2hYdHR55X5+RkApiv9K+k9wbzVGTRfv7IBNJ/
         nArA==
X-Forwarded-Encrypted: i=1; AJvYcCUIykiABBL7Aud0081EFjAZ8kpG6hzVTuSv1UQV7XdrD3CRlOKZF9QcToo4JlTdSlnoSF+oqipVQAtsm+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSFjWzu75S0YMelB7/ySa0YPEd0fYhR2PFu2j5rU6x7MkxEtZd
	ssbWju7Y44gkQThyz6gx00X/zO+U4Aj6y/kof0zPQHokPwlRu6MJsGM5
X-Gm-Gg: ASbGncvikqAeyP/qy2OA0cM7fmFZMxp22erF/dNQceuHQ2jaDV6Wysk+aPSol3Ng65q
	Xb2oPFwPJ6pdMT5yZltSim/dy7b7TUzeDIEGZz6GZJxCZDzt0RC1+38iArDxSxQR766hiLFXOqF
	Ab6rNf6uJtzhEJwGMjZWMDuMWykoA5z5Ofyb0FCzdqhKVI1LQF0arH7/wgwT6fY8RpAZpya3Vod
	mnrFWyyZ8lKdwIvW6rVo/5KUeGqfgJPP3V71C/+3vAaV68UrESRF5g4Z0LIq6zdl4V6Ex3IPpw/
	JddbSKhKHBkJuzaFJ499613eJoHPo11MejfutSok2EuTTUMDdAkXTpQ6k309jH0eM4FWusxZowy
	/G3rmTsKfa4Lb9fM8TUY0y+9UGj2YJYWsO09K2J40P81fxMDqCFGo1PyhNxBYsy1+12QGnHIrxw
	==
X-Google-Smtp-Source: AGHT+IGXCqTReJ94d66EEB+8s5ZF34ZclwL1Q/rIdYVO7a5YUFeWWK/uxTC9yxu7YownwJ8zZfnCzQ==
X-Received: by 2002:a17:907:da2:b0:b2c:fa41:c1be with SMTP id a640c23a62f3a-b50acd299ffmr2305092066b.61.1760367799090;
        Mon, 13 Oct 2025 08:03:19 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c129c4sm957903866b.41.2025.10.13.08.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:03:18 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: p.zabel@pengutronix.de,
	Artem Shimko <a.shimko.dev@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
Date: Mon, 13 Oct 2025 18:02:32 +0300
Message-ID: <20251013150234.3200627-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013150234.3200627-1-a.shimko.dev@gmail.com>
References: <20251013150234.3200627-1-a.shimko.dev@gmail.com>
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


