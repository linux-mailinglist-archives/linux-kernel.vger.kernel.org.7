Return-Path: <linux-kernel+bounces-849411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C502BD00E2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 12:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46D334E3EDD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0242609D9;
	Sun, 12 Oct 2025 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCN2Gccv"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29CB238C3B
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760263235; cv=none; b=NfzcnkrkNE9tbvauR/soylXoAe98WjujZelIqfoDCfhKFFnkOAq4IriKeGEb9iBymougobFL1nEUgt5iHichjH/LjrLqLkxFpLejusO+hKDrq8dAZaknWZ8C8rynhXaENypeAcATrbgAm5ZHmY2404zrkBnO+OjR1j+NmnfDqRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760263235; c=relaxed/simple;
	bh=vZJNHbvvtVosuU810afY1IEoJqCYkWU2Iw4KMxlX0Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8/SY4wlJYXoJ1e7fVOw3QWMKar6upIfKAU2ASKPi3yR104uioWQ9tPt/yHICucUzP1OgXYsxLVy+zvAAKmZPgDr4Hp69Zc5LXPGgop9AaDV/7ekY2GIvrDCeT9CABufDptVNSblqZz/7RE/1l+8yOyIbdrR2/hkI/UgTv0tfMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCN2Gccv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-586883eb9fbso4492373e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 03:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760263232; x=1760868032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYDF2+npqHbQw9zSrp12H/s1KYxESvsd8Xn/2hyxl7A=;
        b=GCN2Gccv2X4u50HDv4LL4dUGYD8cj8jbSPc/zMvVMEtSNvkOob2aCHUEMG1DMaXu9U
         CwI5eJWZGNDSjXukCts21CpwXhgl6QSzg6hUlPSjakZbK93RoD0xhc6sPxfhMBYLfqPo
         Vcd4QMcsIKa6ijlh08RIzipdB5Lbjv1lOQsB54cVNrm3YVaR5piU7Zp4rJHVtm5LJwGK
         9VchAf5pU0aVz1tl3SkCTbtT71sXTJQjc+HaDyuBbf3Re+8e+c2DjJupzXPfcVuAhY7d
         mcgN1axuwGFO9jG5d8QllzldxZw+81D8xmyU7nXHSQlHj4rxnGKTLXaneMbPaPDOTCtn
         9Lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760263232; x=1760868032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYDF2+npqHbQw9zSrp12H/s1KYxESvsd8Xn/2hyxl7A=;
        b=Kr0heqjEfhFvtOqA+1v/SJB30DwO7JMsxVml7T5vl0HJMd2GUulMbCnZaaRtjVMmOh
         GdA40gp63LBbyBSIIdL7OBe8i2XUTKuQlEjPpj6LRfTDkbHClPVt+fohdaVNKrEiV65J
         cd5mru0kHRwfFVnbeXVfmKm6UsgY0G6ZEskJ4SDqk4Mb/M+FzfQaI7aHnZYzw89enEKw
         BLjxash5/GDS8oK56ufm/FhSFYbyUHGyz0lKHfXzH8UCGGnKjzYyQttD4HDyRAXI66Tp
         EJABvOtgy4BBrCjWYJBS0GBPPBsyooKbt379ys6GgABeQz8GzlwC+EPv2YqTJMN1rG06
         P5OA==
X-Forwarded-Encrypted: i=1; AJvYcCUcRUboY5DE/mJmYXqJOm980bOKnwrm2ir2rRGtwFalQUCSSubYn1m+2JCyMnX6jYb7O8W3CjsnB1MCXIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZQcufcRnp94lnes94q/wrHG8kPp8/V2grwzupuQoUlf5v8mX
	zKGC9ZNOYCoOjd5fVuurkGGAcRzqM+kULxnfgV87UHG7zVPaOyf2heeC
X-Gm-Gg: ASbGncsfdSOgVdSJa1fLYYMYDZL8j+0FovDbXbLwoZXTNQzFn3PJi8f8W4OwvD+CHEL
	QHskh2+Dho20EURWB32PMDIc6xoWNym7E3wYoAIYTshBAHWUPiWZMskdi3PSnrcuOjHy1PU/xDL
	YYVj9C1ElNbilduXkhwTb0G+MFlg65UkY3rjFprw80hLkpK6T/E0BCP0ej9BbHOG+Lv8ptXuMQk
	7MMWodZS+6aZSvWu2ld4JaYTljJwbphSAkOVABxBNm0W35eZiMJ8mdkDg+0LIAR11buwORuwcby
	vM4hsQDl6UD4s0wl1LDNnQ4/OaRxUoXkFeDw0AwJHoZNX8o0NtbP8Ce+UTIXA+iByg83F7AI/vh
	Ont5yMNcrcOIbHBZuqykaQ5f350YLAFeHB5/+NGdWWKYltTSxTw0Y
X-Google-Smtp-Source: AGHT+IGWL1ei9PIDD8TDC51CGyly0xILPwGmdbo+11xbW/F19i3aU0zPMr0X7T0T3NyywfF50qx2wg==
X-Received: by 2002:a05:6512:2c04:b0:562:c06c:8c03 with SMTP id 2adb3069b0e04-5906d896d2dmr4569190e87.21.1760263231566;
        Sun, 12 Oct 2025 03:00:31 -0700 (PDT)
Received: from NB-6746.. ([94.25.228.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088585860sm2823882e87.128.2025.10.12.03.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 03:00:31 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: a.shimko.dev@gmail.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
Date: Sun, 12 Oct 2025 12:59:59 +0300
Message-ID: <20251012100002.2959213-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251012100002.2959213-1-a.shimko.dev@gmail.com>
References: <20251012100002.2959213-1-a.shimko.dev@gmail.com>
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
DEFINE_RUNTIME_DEV_PM_OPS() macro and pm_ptr(). Probe and remove
functions are updated to call PM functions with device pointer.

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


