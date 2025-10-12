Return-Path: <linux-kernel+bounces-849412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA3EBD00EB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 12:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 503E94E5413
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 10:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D97F261B64;
	Sun, 12 Oct 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B522r6L2"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80DB26056A
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760263253; cv=none; b=kMRIlZLWFrUNpS4htLH5BMUTN280VW9b05huckmKYjDRN12rwXo9ZuEDnv+UgiOovIU1y6xpRVG53T4S6n0Hhsu18PiVuOS2vuPmoXS06WuoNIPovTrH5dY63AODmTUVdlh4Vvd8GoDDM6+259Oe5MM76BesoZRrHT2R+S/CYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760263253; c=relaxed/simple;
	bh=NpLOcZjJLcpiLDNkxx1t2kSCTYhfiFQWIPqEvtzTMpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYkHwkjFQZl/G1htZ4d7a3/NTsgeM1l+kK+7NrMlSobE3C/8AoxG7fy7bh6ldqoN1JTbE7nckWZWdRXYOFQHrFLGSvqk/GCGjOEUGnQ7iwgi7YlJCyRSO62U7fUdCvFqh/fpI3jh0NzmAQ8Rh0xgFv+mFUDSTm6Vr3tCJbBdsWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B522r6L2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57f1b88354eso3737747e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760263250; x=1760868050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt/08zDoZHi6QCv0lr9Mfxvpxfaye7PST9WTNSBZ4AE=;
        b=B522r6L2LgCb6MFlEjprPs/ip9ruvdWMKvkHpCQe0kiIguLShmG7ScDFyUrSZEwbhz
         qODd43sSMiXHC7/itg4HzOKeLcw4H/CQv4Eyq6l2lEeByZKGTKY3Ze2hcfkeTuKBRJMU
         +i2RzMTx9iwV/ZJpUd9y70F+yfwYPSG5/kdXZM0rDh1jg2vgT90DIoqe48SH+NWvaUrP
         PsQfVy1heI0eOCCmY3b94zEthN+VGvanlFDNuVOzdLpm1A0NR5+Vau7xQQ12x/55v5o8
         HKNnwtJsrWpKCd6RHZm0NTCsFbxJscTNLeeDUzwQjTFWsdA1BpLCNQpTluZDknUPzKiI
         tIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760263250; x=1760868050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt/08zDoZHi6QCv0lr9Mfxvpxfaye7PST9WTNSBZ4AE=;
        b=QwIOW/QjNYlhOAIfCLhP4GZZzwjCjqRIYrIADt3dlAEQunxg5RWEkl1ONxP5EK/682
         cgrhA1lydOWvxV1pxgtCm0xSLASnSVL+3HMKfu10KpUG9xl8pLV5pvO7+XEReF2z7/f2
         qa7kN6/hTPFT5DaWZEKfyxMJf6PUSafXCpq1C3wqZXHsl0njYE/JYpYRwKIxtQClzZn7
         RG1KbzKZbtEV/0/9iSvOTnb94iwCs35baMngjywWszcTm8He8KnHp2S4BJasPGzkDXV7
         AHlLxcFciIhRRH/h8YGpGOHQ/agZXS5wMeaI7vFAxs/W0VNIL5sw5h3RpLPkLJ4/N/25
         UQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCW8QCFM1rYATE2li4vW4OMF6cX3oncqPdVZ0EVZQkT8DW/2QMzTlGwnXlfRumx4yqI6Qa/j2HkQyrFjJsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3gak6Ce6/cEi/GuWTLpICJ4/N5F6rBFpKvAh+sfn1ALwwUDEf
	qXYxYrGpgD6YnjqrvC8XmgvvmgrY3u0bbLL/im7Y/83eGlMyvPf9Pcg0
X-Gm-Gg: ASbGncu2x7S3EpEsy7vu0BvtEicnZcqni0mzd7mzYembnGFn5cnElpfHd7V80lcqbFx
	honixke9oKih4bc4QFNNt3nbkFGjACuc9+OXedh0kBjctLb06axlx6Xyy685iqopHS1qB+XB8Ll
	dbjzCwTws/CG8SB8wJXRBbgCcKKZzNO2gwDwAw8vkmpXio8GMBbNUDBxz2vWFYsKiQjgbpwtr5J
	UOCjqqf2giFfhvDysRyevZyuSY6VAoSZdbucPhHHxrHJO9PY/+r8yZV2yiazjqui945vXxjxw6m
	9w9ouNkoaJ74sKHZ0WjnTUANN+h7Co7camTaJoYCM+XKsUwqLrWWDU+S/9/gqevqYytburUqae8
	0D9co2NOyQBKZhvK44wSCoypJM4BrXbPQ2MAt/V4Fnw==
X-Google-Smtp-Source: AGHT+IEvjh++oNk5D6Hd/JRHER8RRDiSIgrbmvMDu6YMHrVhPmjga47WRCExnEXlmGwt+/hye4sK+g==
X-Received: by 2002:a05:6512:68f:b0:55f:6fb4:e084 with SMTP id 2adb3069b0e04-5906db047d7mr4801424e87.50.1760263249647;
        Sun, 12 Oct 2025 03:00:49 -0700 (PDT)
Received: from NB-6746.. ([94.25.228.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088585860sm2823882e87.128.2025.10.12.03.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 03:00:49 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: a.shimko.dev@gmail.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: dw-axi-dmac: add reset control support
Date: Sun, 12 Oct 2025 13:00:00 +0300
Message-ID: <20251012100002.2959213-3-a.shimko.dev@gmail.com>
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
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 41 ++++++++++++-------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 8b7cf3baf5d3..3f4dd2178498 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1321,6 +1321,9 @@ static int axi_dma_suspend(struct device *dev)
 	axi_dma_irq_disable(chip);
 	axi_dma_disable(chip);
 
+	if (chip->has_resets)
+		reset_control_assert(chip->resets);
+
 	clk_disable_unprepare(chip->core_clk);
 	clk_disable_unprepare(chip->cfgr_clk);
 
@@ -1340,6 +1343,9 @@ static int axi_dma_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
+	if (chip->has_resets)
+		reset_control_deassert(chip->resets);
+
 	axi_dma_enable(chip);
 	axi_dma_irq_enable(chip);
 
@@ -1455,7 +1461,6 @@ static int dw_probe(struct platform_device *pdev)
 	struct axi_dma_chip *chip;
 	struct dw_axi_dma *dw;
 	struct dw_axi_dma_hcfg *hdata;
-	struct reset_control *resets;
 	unsigned int flags;
 	u32 i;
 	int ret;
@@ -1487,16 +1492,6 @@ static int dw_probe(struct platform_device *pdev)
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
@@ -1507,18 +1502,31 @@ static int dw_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->cfgr_clk))
 		return PTR_ERR(chip->cfgr_clk);
 
+	chip->has_resets = !!(flags & AXI_DMA_FLAG_HAS_RESETS);
+	if (chip->has_resets) {
+		chip->resets = devm_reset_control_array_get_exclusive(&pdev->dev);
+		if (IS_ERR(chip->resets))
+			return PTR_ERR(chip->resets);
+
+		ret = reset_control_deassert(chip->resets);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "Failed to deassert resets\n");
+	}
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
@@ -1605,6 +1613,9 @@ static int dw_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(chip->dev);
+err_exit:
+	if (chip->has_resets)
+		reset_control_assert(chip->resets);
 
 	return ret;
 }
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b842e6a8d90d..56dc3d75fe92 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -71,6 +71,8 @@ struct axi_dma_chip {
 	struct clk		*core_clk;
 	struct clk		*cfgr_clk;
 	struct dw_axi_dma	*dw;
+	struct reset_control	*resets;
+	bool			has_resets;
 };
 
 /* LLI == Linked List Item */
-- 
2.43.0


