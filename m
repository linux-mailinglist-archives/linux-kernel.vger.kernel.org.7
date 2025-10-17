Return-Path: <linux-kernel+bounces-857852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F243BE812E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F01F503A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53D1312839;
	Fri, 17 Oct 2025 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQhBI81v"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EEE310625
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697009; cv=none; b=NiKnHFUwNRFyu6IwYT9eAssLO28iddneaBG53RUQ5vqoLnoEuYOgULTHvioNbNbdLVXaWxynG9e42YI9so3nWK/aNwzoYMpGZcCO6HDvTHyvJZqq6h8kLaJnLKa7dXHy5g4dX4r/t/qKE7PZMtQDsZr4xVilOGnmPxOrQ8KMHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697009; c=relaxed/simple;
	bh=u9onCZFnkyOeL3qm5HRG8OOBb4DovM2OXzKSTiIzBEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ojvuvjo6J3OQnHURna13PvDn7xcB8VXs1V9hTzPgWLy2O0pme9NOwNbuDDoy2ulzQFuVIyIKbGspUhuzHsM7Td35XGWGEWqWURNqu3NG7peTcbGRwnF8ktB+g6U2gpieNSdBy6uZG+HXsNA3C+0rJwpl3NoNJ6e3AkwOE1/YDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQhBI81v; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b50645ecfbbso352303266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760697006; x=1761301806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8VSdu2t9NRUYTTU5ICP1vv1R4+iQEnq5RqVLQWy3WY=;
        b=NQhBI81vfx0Ha/mkojU9fw06lgSpMRecsuEHj+Dq9vb0fiI+l9xDrm/ZnAvYOuMMJS
         GyDv+A0SxqskmO8wUFp0qn7LADUnlGt0EyAykqNegEqAAn9Em34Zdhr6cma1YLhKKLdk
         SZzB7rn/mr2FRZTOCHG/MgxpNYRZYDoJKMcXWJFq1KBd4e8TW9+aihMg66qwUz0e7Rg2
         /nx3bXt4hchj1SoaRlqiIYkhpGly2StPyz5riPFiusQucAcUoV/jZ+yo+ZXPKFJLLskQ
         SwzgBiaY6fk2Zb3jfUK3T790rMWkQLbs8fAZHa2xxEqSWRZUdyC2Z5DRkc4kSZGTiG7W
         zYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760697006; x=1761301806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8VSdu2t9NRUYTTU5ICP1vv1R4+iQEnq5RqVLQWy3WY=;
        b=N6dc1OnF63blKJNMMiziOSlBXEDwFHeOWS6eS8wfetfIVgwQENGRQOUnS6CG37Mcnq
         oNWNETTTOf60HB//t7Rdcnd7yLPKx7+PXDpPogED+pCGxU1hD4oKgT5fEGTMlD1os6o4
         896ViO/KUUm8VSK/r3CMA8kzPzrF4+jeNU3xKp7BsgGO/20o6oOJKzGmIcfhbrHTEuYM
         pi+IhgUYTOX7XGBlWoL8Y8lN6A8sk5KQw+6zTXSim5O0UtgKNB6u8G/ed/yD5r+xQ6Q5
         AJaM/qbqxNPGeqtl454L3QXVOzqHV1V6ufcOdWo5DLbEpwjXq1RfDoA4LQgoHBXRkYcw
         YHxA==
X-Forwarded-Encrypted: i=1; AJvYcCVpTRNq0HYYTNaoyMrFtf6iobBxSu/sTnDi9De/eSAx6SA+9F3BDUfDZD2bB5KtOvzVq1VHJ8i6db4j+us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8Kw5JqOxqYqsNwxN00E0hqxK0JH8puNVgDBJPG/ZPTLh5tPI
	ReUr6RUkHl00CUV8wSExARwiBRlKMl6AITnd5/GggHAdTBz4Us79e4Eu
X-Gm-Gg: ASbGncu8sizAJjCyajnRe9M7AKqBdGQAEAFfPVWjxkHQt7paj6+ts+gYiXUni6aAyhp
	cYelvQGBUKORyZ96TsDI2zm1M2EHpshi4qMiwnbTWpLK/HnvzSvcUvPw9g/ChkCCwgSfpQTeh8M
	/paYTCbSW+NbxaeqG9ZF3wLl50P1xTcCl8rY0TOy0CB7gtmaLlWXEVWJLre2idpwJ0vhn6t7bjB
	ELGXGx3Ib2YwfetdsKKrqykRdlSzTSm6b1EVaIPUijjnjEO1/kokrAO1Q4r7iImiLfFIApNSTvQ
	lkFrlaQiTy+CVUBkwmI+gkbNWswovvxjrsFjDw+X18vcXqnEn6t+OhdUZT4BlT8cseHk9nNPcaW
	EVK8uzwi/e47ZMUrCQToaDgpCgRq9QDaaWxIskuiRuG0nIml9jEncE1++SuHL36oRxqjCm+BNWM
	fqrWs1VNjJfhcITolJ
X-Google-Smtp-Source: AGHT+IGt+vxRxvH0ftehwbeuAyjL/SJZiN8MxMewjMTAh2gMoBH1nNML8SGUVWpNG4PV/3t0F/QwXw==
X-Received: by 2002:a17:907:7f1b:b0:b0b:20e5:89f6 with SMTP id a640c23a62f3a-b6475609da0mr311488866b.60.1760697006025;
        Fri, 17 Oct 2025 03:30:06 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdacd88sm780513166b.43.2025.10.17.03.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:30:05 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] dmaengine: dw-axi-dmac: add reset control support
Date: Fri, 17 Oct 2025 13:29:49 +0300
Message-ID: <20251017102950.206443-3-a.shimko.dev@gmail.com>
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

Add proper reset control handling to the AXI DMA driver to ensure
reliable initialization and power management. The driver now manages
resets during probe, remove, and system suspend/resume operations.

The implementation stores reset control in the chip structure and adds
reset assert/deassert calls at the appropriate points: resets are
deasserted during probe after clock acquisition, asserted during remove
and error cleanup, and properly managed during suspend/resume cycles.
Additionally, proper error handling is implemented for reset control
operations to ensure robust behavior.

This ensures the controller is properly reset during power transitions
and prevents potential issues with incomplete initialization.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 50 +++++++++++++------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 8b7cf3baf5d3..a3e93b658c21 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1316,11 +1316,16 @@ static int dma_chan_resume(struct dma_chan *dchan)
 
 static int axi_dma_suspend(struct device *dev)
 {
+	int ret;
 	struct axi_dma_chip *chip = dev_get_drvdata(dev);
 
 	axi_dma_irq_disable(chip);
 	axi_dma_disable(chip);
 
+	ret = reset_control_assert(chip->resets);
+	if (ret)
+		dev_warn(dev, "Failed to assert resets, but continuing suspend\n");
+
 	clk_disable_unprepare(chip->core_clk);
 	clk_disable_unprepare(chip->cfgr_clk);
 
@@ -1340,6 +1345,10 @@ static int axi_dma_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
+	ret = reset_control_deassert(chip->resets);
+	if (ret)
+		return ret;
+
 	axi_dma_enable(chip);
 	axi_dma_irq_enable(chip);
 
@@ -1455,7 +1464,6 @@ static int dw_probe(struct platform_device *pdev)
 	struct axi_dma_chip *chip;
 	struct dw_axi_dma *dw;
 	struct dw_axi_dma_hcfg *hdata;
-	struct reset_control *resets;
 	unsigned int flags;
 	u32 i;
 	int ret;
@@ -1487,16 +1495,6 @@ static int dw_probe(struct platform_device *pdev)
 			return PTR_ERR(chip->apb_regs);
 	}
 
-	if (flags & AXI_DMA_FLAG_HAS_RESETS) {
-		resets = devm_reset_control_array_get_exclusive(&pdev->dev);
-		if (IS_ERR(resets))
-			return PTR_ERR(resets);
-
-		ret = reset_control_deassert(resets);
-		if (ret)
-			return ret;
-	}
-
 	chip->dw->hdata->use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);
 
 	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
@@ -1507,18 +1505,28 @@ static int dw_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->cfgr_clk))
 		return PTR_ERR(chip->cfgr_clk);
 
+	chip->resets = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
+	if (IS_ERR(chip->resets))
+		return PTR_ERR(chip->resets);
+
+	ret = reset_control_deassert(chip->resets);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to deassert resets\n");
+
 	ret = parse_device_properties(chip);
 	if (ret)
-		return ret;
+		goto err_exit;
 
 	dw->chan = devm_kcalloc(chip->dev, hdata->nr_channels,
 				sizeof(*dw->chan), GFP_KERNEL);
-	if (!dw->chan)
-		return -ENOMEM;
+	if (!dw->chan) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
 
 	ret = axi_req_irqs(pdev, chip);
 	if (ret)
-		return ret;
+		goto err_exit;
 
 	INIT_LIST_HEAD(&dw->dma.channels);
 	for (i = 0; i < hdata->nr_channels; i++) {
@@ -1605,20 +1613,30 @@ static int dw_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(chip->dev);
+err_exit:
+	reset_control_assert(chip->resets);
 
 	return ret;
 }
 
 static void dw_remove(struct platform_device *pdev)
 {
+	int ret;
 	struct axi_dma_chip *chip = platform_get_drvdata(pdev);
 	struct dw_axi_dma *dw = chip->dw;
 	struct axi_dma_chan *chan, *_chan;
 	u32 i;
 
-	/* Enable clk before accessing to registers */
+	/*
+	 * The peripheral must be clocked and out of reset
+	 * before its registers can be accessed.
+	 */
 	clk_prepare_enable(chip->cfgr_clk);
 	clk_prepare_enable(chip->core_clk);
+	ret = reset_control_deassert(chip->resets);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to deassert resets\n");
+
 	axi_dma_irq_disable(chip);
 	for (i = 0; i < dw->hdata->nr_channels; i++) {
 		axi_chan_disable(&chip->dw->chan[i]);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b842e6a8d90d..c74affb9f344 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -71,6 +71,7 @@ struct axi_dma_chip {
 	struct clk		*core_clk;
 	struct clk		*cfgr_clk;
 	struct dw_axi_dma	*dw;
+	struct reset_control	*resets;
 };
 
 /* LLI == Linked List Item */
-- 
2.43.0


