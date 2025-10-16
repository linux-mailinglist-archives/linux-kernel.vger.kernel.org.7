Return-Path: <linux-kernel+bounces-856495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8EDBE4528
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5FBBF358F45
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3851434F483;
	Thu, 16 Oct 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRQrZ46W"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0050334374
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629596; cv=none; b=oZOZzSzUyPHFQiM5vwDLao8AwQemm/yG5JruEQG2TI4gD9vlA3SkymjitFda7VnkCF1tGhUi4++DVyUU+PoR9+WOlKYiiN52O1HSFKgRggOXkgoS5AFoEdTpgP6xOCAKov7djYXCf+LAAgc5DheRJxzWasx2I6XOM+DelnpYlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629596; c=relaxed/simple;
	bh=OzK0aYW2LWITX9fdd4z7rDbgFG5oDHlyFtFytqntWLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/Lqv9ulYKIXTUEgBFEIJAAdXMCFbihDu9tGVfjccA/iFobs0Kjh632PhBbacD3qt9JWO9k7DPB/3v7l+++grzpGLStLitgPmuXSZQo9uYh/EzixtHgHZJoC5jqBUNA46EGF0n3gG10ProYHRHySbbPtJGxZUqWvk/H5TRMP7MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRQrZ46W; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c1006fdcfso1539125a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760629593; x=1761234393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXSMFjXcnbUgtoA/eC/AHIzf0ylAZ7zJ33rVYw0AFyk=;
        b=mRQrZ46WeSWPrHBajjqXmUEaaXTD0TBKQV16FGs1AMW04zcJfo9Th/xQdtGiPL4EWm
         HZvGgCg8XjxF59orln/gtghQOWLZ44hJRc9DDgo4CLumm32vw6TKGMpp8XvfDNBsK6eh
         l/FRFtongyCuVHaUWG0f4BYNE/2ajkBJnlqc7xCWOXrhVbAwSkqX1vh3xZAKDyEmYtNy
         F2qbZ3EipxTe5j71XrVHXgaxHIkEvwKFUoc1/xAjNkK3v/LoCOSanFtBKWODZCyJZf9O
         EjnFeRFoMP2YmS30sLUL3zcl3RsvS3sj2loZO6wg7Lo7CThFU7WcsKkwJKMgcipXZa95
         kwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760629593; x=1761234393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXSMFjXcnbUgtoA/eC/AHIzf0ylAZ7zJ33rVYw0AFyk=;
        b=F6aw4salWcJbtpKlAwvkxmc4YjJOus7/CMUTu6F88oMFO9OetgqLNO8sxSGEQiJ9T8
         +s0aqE1EDRVfHr1PVb2llK6CIFobejI80RiyPMJMdUQ99ZPrwMDJFPLZtsVCI1dbvBvg
         Ues+ixGhmPK1ELcHOxHMVWle0fCx5JMb4unW7pJuVhsTyVyoJ7BbeAP/WX/bvuZRXfux
         xEtTIkr5JmRlx50kGuj6fKB2PFR0owUBlu7R1A/wMOm1AMgebjaft7580KhMIrPlUGfl
         cHU99bPycczR6yuI/Cx9ejrw60P3ojEinzfn4M1MnAVEmCKgonGJhgbGeYDQy8m8bq44
         Xawg==
X-Forwarded-Encrypted: i=1; AJvYcCV3o+BGDmW6/lHO+orgb2lt5j/zpAT/LSBDWy/4Mu/ltvPAYWCN6WupdVwmskg4B0VtH0OX/Tk6STypaTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8o33aXFL4UyYB1N7mTPiUlGWi6O5tdvcH6TZlvNtwjXvw8Hg
	oo44GlgUhi6HBOxR0MwX4eAxMtffJtVDERh3ZvrO3ziaOPmYBs5t8+F7n4bmwQ==
X-Gm-Gg: ASbGncv1KcNfZfAr2dAe1uQ1Hzcns8U5VHCp7XFeBo7IAMvT7Hot07RiLK5cpH4MFC+
	D6EIzx6+i7ibV62TgEfYmUBV9scrUR+e9zd+iQbB08Ft016QDJGV87+T/Sh+HshAhRtHWst/jua
	Bo2diPUEZjMIf3zHT2Knw05VdL5uVPp4hJOuTHEFIGqZv4TLyxDYMsDpCdOrtrz32fF+/c2mN8J
	AKYhlqhrGpppmNxcyq3UqRD6rgUlz2/jlJOHnQ7AlZvmFgM87ilWFCKTKrK3k3zDcT7QEk8uUSY
	xWRIII7i8WBpUnT31NiNtZZkUMLr+nj0vyIv4Y1VitNbgTA7XZnHa8hkLMWt2Ei3k7YD7Zzcopq
	u5CmDhVMRMJTQ4LglsXiVbJ3ZMJmB776vxv9wEohIcSLtQgWhL5OuaaU+L7a7nIZocgmmUkufxr
	UnT7QKGZe0aRXxHQiXL20o/FJHnBZz
X-Google-Smtp-Source: AGHT+IGa47IwIEhUciz8R5X/HKhA6vp9Amv7n7WiwS9+yqHKoStQugBWBhHlks75VQUoSvBoKGi9kA==
X-Received: by 2002:a05:6402:3491:b0:63c:1e95:dd62 with SMTP id 4fb4d7f45d1cf-63c1f6c36c0mr374154a12.26.1760629592939;
        Thu, 16 Oct 2025 08:46:32 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c12279a54sm1237989a12.11.2025.10.16.08.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:46:32 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: p.zabel@pengutronix.de,
	Artem Shimko <a.shimko.dev@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
Date: Thu, 16 Oct 2025 18:46:25 +0300
Message-ID: <20251016154627.175796-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016154627.175796-1-a.shimko.dev@gmail.com>
References: <20251016154627.175796-1-a.shimko.dev@gmail.com>
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


