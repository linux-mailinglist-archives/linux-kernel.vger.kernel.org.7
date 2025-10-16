Return-Path: <linux-kernel+bounces-856498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5181DBE4537
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495AC19A6AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEFB350D57;
	Thu, 16 Oct 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE11jwQ6"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C81234F47D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629598; cv=none; b=hejx1c/V32E1IMR6gGhv0KS25/zzwgRaJRq/nQJXpCo+zvcn2c6HM9MEZcqLV6DiwSBF8TXD5qy0XB8WpqTl0E3whKhwXWv5Y/dfMRd+VCIdvmAX4yYNf9vH1cQuaIrOGwZV/jaZS5oZkTWZpBRq+qMGHOK3EQNLg8ZDW/LHV9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629598; c=relaxed/simple;
	bh=kUCeFgHQMCRWh0vi3n2eXqVII7Jhb7VzNj8JhwyAw1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQpFPYosApqWpFfQg7GKuGJop/z2hIFy7V/HvEKTDXuN5BIyAGhQk/63d9QAa7tIAojFpj2dGprWPVLDN7VbVdZhe/LD5w7dUrfsforSMbQNQ5W0CZYb8X8CCs/hIRrH4YFr+LyaBdM77ZXfkFYGQqiITPlHzhB00fyCjD1l7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fE11jwQ6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6394938e0ecso1574466a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760629595; x=1761234395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTOdQ6EvuzATlkoQOWo/SqmOTJM5gobylAZ7Hzz1+yw=;
        b=fE11jwQ6TDyFYms1RVcFZdjvxB0vpm5q6nUsUK+EhQZdk5SnAGt1LPp6fRn3T022L0
         ZmGlm+sjUIXKNFoAXdIrxMyYdvLVop6HKZR+NDZZckVzcD0sfYOSqeqgLMKa7LP9TqVq
         z/soEQFvBEeRdzLg0/hM0hGrx+2IeuIiaPpmICN2o9KrVmZZlGhxsBHakaY7VUzgFnUS
         CQaj/rmTjOj5u8Ymh4SqvtIvLeERe1Ftj3+8URXWEfLmT/s0ijBjHouYwmkoV7nZ53TT
         mpI2QdywaHyNiJqdYQEXDJA15j0rsab12Uc1XXI9JZB/+TIFz14IT6kFHLRCw4cm/JYr
         BCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760629595; x=1761234395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTOdQ6EvuzATlkoQOWo/SqmOTJM5gobylAZ7Hzz1+yw=;
        b=N3UzMdwEE7RfsLXqkO6UYWu37qSDmDfAQ0zCfJXSh/FvZkZWBgbQBh5lmK9nCD8VUb
         b5VuNBSubtFiYAbxjpXOWm9dzcOkGvm59WMjMtdlDqyepwFAKUgfybMv+TujNmPl7x7O
         NcQR1yhHfatfo8p93dgr6wtJz/Uzt8OBZQakxstEsRVoaf57YNp+XABE5U59zw1ZR9sS
         Ra0BLZxoubA+A5EVDe+/VtTY9llfctBs6d6IRWP13GOhYv1J6L0aeo1EO8gcgY3whSY9
         P2fCIjmFUeFSAdCSQsUKDTER1wSa09Ojh6CN841dldjk59jduwgFIpo3OuR+KM0aTEtI
         7ZRw==
X-Forwarded-Encrypted: i=1; AJvYcCV6u5cMFbA6oEr4aQt/g5NUIRP3WYCkFczxUl3O+jmlJhLJ6ntVMiP8Mj2NPNL4HbtvbiO29z3MUvDRo0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMB0qfAZGKpdc+zW8wO91LJL5CsU/hYD1eGtwgiXRz/3G4/Hma
	+W2T07OH2V3NNPinrvvIoM6bxrXSElvI4glWQPUUDW/q2yde+xrrYViz
X-Gm-Gg: ASbGnct+pR5sz78cEMbi5Jb7PbZpfgfeWOblWrd8oKYXFNohmrs0jHqpb1BIVP558AV
	LKButX0vdr6BiEfX3i7VQ0Q6Cp05VVtvpKTIwCtb20g45rjw8t5BCzelsqOMwBgc8pi6RrJ40rh
	LXtD9RuXiK83M41vrDaoVHT0zrdZJkzfkxMf2eOSLUeFQjdPPuF0v+V7jVB1bH4lQYy9OwVWKR7
	UQVoEbzeMx8OAjXz6r0jTMTty/ZxSfiPsBygzlAONfOpwgU0pwWsz5YN4BY6WercAcejD1ScjBB
	mRBrj/8fYIDugeoi0+BE43/PJ3GSYaMpPY3SYF3UP/1vMEAMTBW8e9d88OI8XJaVcTqqhFRdLyp
	TTcDX0rmJ+F5HK2vSPRRGhu38x3JuqJ+jXtAW53Wj2R4J+sQhY6uE+K2CY2E0db8cL2N4pusEOV
	V8iNa8b76gRkpx/RkzqQ==
X-Google-Smtp-Source: AGHT+IHPF8qvl92qn4O9HhTI1Ru2B9M2uJdkrL9b57C7ScKd/dNGobpzHj6JIHuzPjJ880jsHGaSFQ==
X-Received: by 2002:aa7:c551:0:b0:634:544b:a756 with SMTP id 4fb4d7f45d1cf-63c1f6dfbe8mr243723a12.32.1760629595073;
        Thu, 16 Oct 2025 08:46:35 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c12279a54sm1237989a12.11.2025.10.16.08.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:46:34 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dmaengine: dw-axi-dmac: add reset control support
Date: Thu, 16 Oct 2025 18:46:26 +0300
Message-ID: <20251016154627.175796-3-a.shimko.dev@gmail.com>
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
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 42 ++++++++++++-------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 8b7cf3baf5d3..ac23e1a5e218 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1321,6 +1321,8 @@ static int axi_dma_suspend(struct device *dev)
 	axi_dma_irq_disable(chip);
 	axi_dma_disable(chip);
 
+	reset_control_assert(chip->resets);
+
 	clk_disable_unprepare(chip->core_clk);
 	clk_disable_unprepare(chip->cfgr_clk);
 
@@ -1340,6 +1342,8 @@ static int axi_dma_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
+	reset_control_deassert(chip->resets);
+
 	axi_dma_enable(chip);
 	axi_dma_irq_enable(chip);
 
@@ -1455,7 +1459,6 @@ static int dw_probe(struct platform_device *pdev)
 	struct axi_dma_chip *chip;
 	struct dw_axi_dma *dw;
 	struct dw_axi_dma_hcfg *hdata;
-	struct reset_control *resets;
 	unsigned int flags;
 	u32 i;
 	int ret;
@@ -1487,16 +1490,6 @@ static int dw_probe(struct platform_device *pdev)
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
@@ -1507,18 +1500,28 @@ static int dw_probe(struct platform_device *pdev)
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
@@ -1605,6 +1608,8 @@ static int dw_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(chip->dev);
+err_exit:
+	reset_control_assert(chip->resets);
 
 	return ret;
 }
@@ -1616,9 +1621,14 @@ static void dw_remove(struct platform_device *pdev)
 	struct axi_dma_chan *chan, *_chan;
 	u32 i;
 
-	/* Enable clk before accessing to registers */
+	/*
+	 * The peripheral must be clocked and out of reset
+	 * before its registers can be accessed.
+	 */
 	clk_prepare_enable(chip->cfgr_clk);
 	clk_prepare_enable(chip->core_clk);
+	reset_control_deassert(chip->resets);
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


