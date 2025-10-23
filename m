Return-Path: <linux-kernel+bounces-867720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6EDC035CC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C3C5503200
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFED25DCF0;
	Thu, 23 Oct 2025 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0Lc56hL"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1026D4E5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250913; cv=none; b=ZvO1jnz1Lb9KKJqQzuaXvTpyoGS3h/s65DDQGuW7cZ6+4l8xvO+DHWR26PikKkQ3eDAq1unr5PDkGkFzHPBFR9pPqTBVrck+I9ra5ZlZVUg6Ajq0VkSQXq9Z5ezqShE9PPyov9unbHtDCoRaMEhnm5W7Goj5rMxHmNle/1hALhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250913; c=relaxed/simple;
	bh=OzK0aYW2LWITX9fdd4z7rDbgFG5oDHlyFtFytqntWLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6cHUqpr951IQfKLEVfWtuTMgT7u1Do2i79hAomQ7IoSOiGof8vUvq+9EDSiHy7J2mgxvVEb7VFB5nL+94Wim2cpeB/8YOvIxTPOL5zm47WwDjtxV9EsdfXXg4funIb/x5HUQDd3JprQ3RJLIwjpDM1otPao8C1MsK7Jz7kQPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0Lc56hL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-592f7e50da2so1209698e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761250910; x=1761855710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXSMFjXcnbUgtoA/eC/AHIzf0ylAZ7zJ33rVYw0AFyk=;
        b=F0Lc56hLrJkKqAYfTs21ey38dcsd5hzIEooON+hazK9yoaj3qqp3QAK6SLcptdjR5k
         nPNIBrZ90OYnLsZSFcToUOct1jqmq2Q66oD4loBcQIvJmWqJJIfJRSZUa98vvwzFIVh+
         Luu6HLQ7n0sB3kBl1b8qYauaQZoZJKS98awrvKX02YzOUS717nW5IHhxZePT36VmRopc
         mVawB0qDcGlFZdU04NFN/O0QcpJ+6CPCzUmlHcEwsEhBwYD7fz2mRjui6XF15H9DRK9I
         4sUAvl/JCAa/j9GQTIS2yuSYAgFsIXRIK/tfFPbKqhdEwJT8onzSJFGvjEPOGEBZaGRc
         cRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250910; x=1761855710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXSMFjXcnbUgtoA/eC/AHIzf0ylAZ7zJ33rVYw0AFyk=;
        b=auEywkQdONyTv+e0eISeSK1jo2Pe+iVdrJ5kCQnYL+B9bgMMzDf2xK9EZAmmjV12IZ
         QBbYz2YfdebmHUg4DlFixcovcCn50mpm61TOYe6Z3SJs7VLQlbWniWNUZY4M1UXWyd66
         75MZbxvhgk5IBxyko/biTWBNmXORNq/q9d7hm8S4bzCjU1l/blB56OzIxodfCFJ6nInd
         2PKahMNoGG9CoOepugZ1/NJOYNiicL8RA/qFOGYnS0wBIIPBw3EMcVzPuRnh1l3gWxjg
         d2SEQy63pTzEpuhsMeavg8zzzAhVyuazEgWhT0URpiD0rcGARMBIpn4oJlyURmXgDzuZ
         YxWg==
X-Forwarded-Encrypted: i=1; AJvYcCW/HRqtpqKYNAUJEGd8lddc72g5Mco+m2IY8v4WmZKS4iWr5Ucuwz+kvTdywOIr6OyfRQO5uI+UjNF1zgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVhDaZhGTrQYi5l4uXTKj5oMrRVl7QmR8QX6L9f6OmQW36+Mag
	5hQzXfAlNyfhGZ7hOR2JaXd7Bq+4kS/LFEkwtkDHq3GBiUzoTtQvllbV
X-Gm-Gg: ASbGncvyNRC0XldAE/D0gD9wZd9pD+0GNhGux539vN0SpYB1gEvE0UosHifaLUhJZtR
	BIVYrX902vV0fMnPE5a/p99VCkqU+aVvjLz3D9XwBorWrjXaebzGxjrrn5H381s3kCPMKUpITrL
	fuq8vdpKBdpzUyGwIcQyc86VGaDoLBPtM8otF3/jsZjZ4ww63J2fJVtCglR3Vhup6nuv17pdgFm
	20aUSJnWLoI3Q2Fn+St88se4UwL6KBFW7vhVAHNVFKi5SttbLBUtaH5DQcwy92FkQEF6wuLA9nD
	UEnfZ5bm2czAOjDFEWP0Q+hlyb1ImSB3mc0x1qothPLjqnw9KsPdKjOMvTslgD+KziajtqQ3GmZ
	wdqvFEUOz6mRUBr8T9rqYXirWB8LQ6uLp8teMzAYXgVSK5BYBD/bMj78l4OpFdFI/5gvEJZlH24
	PZCi53Pszatv3bzIh00otwcWhXCOze
X-Google-Smtp-Source: AGHT+IGhJsm2NpnPxILDX/uu4WQpKiT5lGc6J2i4hbTtY+u/Vz/nCFDqIfrcf/Qu4VuDtoOnYneSxw==
X-Received: by 2002:a05:6512:3e06:b0:58b:75:8fc6 with SMTP id 2adb3069b0e04-592fc12a69emr45480e87.19.1761250909270;
        Thu, 23 Oct 2025 13:21:49 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d2cf30sm977522e87.97.2025.10.23.13.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:21:48 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: p.zabel@pengutronix.de,
	dan.carpenter@linaro.org,
	a.shimko.dev@gmail.com,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v5 1/3] dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
Date: Thu, 23 Oct 2025 23:21:31 +0300
Message-ID: <20251023202134.1291034-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023202134.1291034-1-a.shimko.dev@gmail.com>
References: <20251023202134.1291034-1-a.shimko.dev@gmail.com>
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


