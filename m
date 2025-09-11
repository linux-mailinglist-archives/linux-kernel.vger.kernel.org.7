Return-Path: <linux-kernel+bounces-811763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B03AB52D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2BF1BC1C46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECD32EFDA8;
	Thu, 11 Sep 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxHux3c4"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088F42EE279
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583820; cv=none; b=BuuaKvHlDyVEjeOO+bk+4D9QqHdHFlVTTQsI7bxrCNzxvw6wZ6NPw1ni3ucmISpo8XqwYA0itu1qsi+9Y7ZJhc+wgIK5h9beSTMyuYmOzF85vf42hl7IX/PHXKm3yAIHFlcgaIco8By/jDxp3M4g/tirS8m99xdcjDdvF1U467U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583820; c=relaxed/simple;
	bh=sumypjm5su+//BJZ7zcWLArNigqTGnmSYrUE7kO9jkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bdYwMRFowzkcogrNz8apsrSxOaP9O6p0fJjB5m4HcEQry06aWELSbWmyCkfwS4XimQXlH80m5w+6kANlYI0WUKl/lrPnGO0KZNveMUDCu+rInPdTeg5OYQY4lhu7Ws4MJtXPiWQEWE3ZCgV5IwpoE1Fcggd0bEiJG+hjO0HmV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sxHux3c4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3d9e0a6aa4aso61558f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757583817; x=1758188617; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOK2rQuOJsLR6f1VEysNbCIuj//keNB8l7Qc/i/XdYU=;
        b=sxHux3c4o3YKLzUnNbpZtpeFTVjGz8B3s+dY7niMITU1gOtvIMQCL/3KQa39CnXYkD
         Krat7PKCo3jpohAYZD5Qoxy27hIOnP9mWnE+jvKD5JM5kQMbfb1GkWTkWd+Q3A1w49yE
         /8OXdSdhAtkWPbezxQ4TZ2aZbDg1XYMr23htsbUhGvmjZXgA8k883T3ScosA0Cz8YRmX
         DNOVEllVOJs/hMeKv9iKVHqs1H3iSgCZINt8PzeU/tneFwLKT0Gz/DLFE17GQg4P+Zuh
         uQr8FC6v/uRS7Hi4ItAZXNdVlvUpcRC+xasWW4Y41SJKrwNTbpoJ6d7fKt/pNLw04dbB
         KqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757583817; x=1758188617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOK2rQuOJsLR6f1VEysNbCIuj//keNB8l7Qc/i/XdYU=;
        b=mNPFEj3+2FW9pLZK/zhxKGTsfVSHnY36VQjv692tYzntTIYHcB2kYYfOEOckh+DflW
         ZkBL2K1yy2mOWxiBE4NbbY2yIqY2Smo2C17NHgY/yPXz9qNd2GG3+vwgZk14IrXJv+YB
         RCuqXbAquunzDWO0Hce1cpzuzgDKBF44q8LL6eqxwJUj09WXSVb8wGkgIYturnvq1TEM
         GFPsauUOsOT6gelC+G2P0+5UU7Ik87N1/piwH2y+KknpNKYiehAMxxQ13gu5SGhWP93k
         1dD5sTXN/az/o/FCQ6bvbuAJ+lDvuZWiJnuC2EaFZikTbFZdOF8RQtDqlbrrN1ImZb9g
         xIMA==
X-Gm-Message-State: AOJu0YxqAfdDdveS02ZfICeN21Ym6xtq9BYMOSeRmZShILspGmaytEYm
	OiwwersO8Br7Z8+5zkg+DDIZHt/BmDmY3ofHiD9lupitONx5TJkH3lv6fjn/mB2hfBs=
X-Gm-Gg: ASbGncsWpn6IwEN/ONjea6kqGv6vSfFutYDtPbFCYqi9rfNJ27vqEChZvkqmJkZu24i
	xZKKIXU+dwZF0y2gXqq7Kws1/UsglJkeg7EZS1Td5mt6M3h/eA1ZbJvirVADGeEmnH5OQOxEmeo
	XBnj9Ep1U5Hp3aaosf5LzSkcfrZoVcw0l9kNkvrw0sLTrq1+QCazaetGRCqCfpAkORM8v4xhO1T
	XQxekUU8IDb0jtdBkMRpRxQcC/Mj8ZAzr75QqoQpZiVZVarjYn+Rvb/oUsGr5LANtTC7720HVtd
	jHw+7tHZrrw6KcGKV0UEV9GtmdtMed/FZEjzV0Il9rJ2YEkYDuMa0lEOdDp24/MIQHi4cO+kttK
	H4JHTK2MqKjf8Ul0lg08EBqUXs9sPqoAc3UeBeds=
X-Google-Smtp-Source: AGHT+IFkAwrAZp0H9jBCgjtU096PPs4fGUojk6A9dTh9oIHMsZzNgAkOrY3q9UlVUhF4a29UZ3zC5Q==
X-Received: by 2002:a05:600c:34c5:b0:45d:d0a9:18b3 with SMTP id 5b1f17b1804b1-45ddded6bd4mr86496415e9.4.1757583817310;
        Thu, 11 Sep 2025 02:43:37 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e76078fe3bsm1759218f8f.28.2025.09.11.02.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:43:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 11 Sep 2025 11:43:20 +0200
Subject: [PATCH v2 09/13] memory: tegra124-emc: Simplify and handle
 deferred probe with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-memory-tegra-cleanup-v2-9-d08022ff2f85@linaro.org>
References: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
In-Reply-To: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=sumypjm5su+//BJZ7zcWLArNigqTGnmSYrUE7kO9jkw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowpm5zmIUlCl08oxthWj/NRTMFIrk/VS7v9CZA
 lsRM4+xbDWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMKZuQAKCRDBN2bmhouD
 14ZSD/9mJ4vpTvPjFqTXWclWNCkypobbcRrapFPN84NAmWthC3x9B4m46oqxPKmlJIe22xzKEMn
 tRoeHvUiogSJ8/3feS01kOtEgmKt5zBqnHpL03afu2bYoVfcSdIF8OGkLyqx5NIFtjpGrEYz96s
 go50oNXRev3NabD3hWhVZMgkLDO6+2eUQP/THzrDuoBKTuaggmFBxCjDVzUNCtiGJ8B07Q2So5L
 lFNWs8NsJhnOuf/bvYVWRxTFnYaDY4L2pprB/5ERZBlcPdPzAWLmAWAckKHblZdLf0+e6E6BNeK
 psP/KTesA5CqLOM2SZSh/1rSZWBpiTB9el9sxjzgUtmI2EQKPJYnw5KFmDjHbJbuzWK8NxmIO0x
 b+piCBylcm1vo7Ve7azJMuMxxiH9AoTIv+z/09DaUdBYll1W3OX/28w5FpMdf7EQEOkwYd/ACDP
 N4gFjGSxDiburwOaQ6tjWEDcYA/uJgYP2j+SIOdJZAITpQ5tzmQgTurPEbZS59YpLlTOiGVVf9+
 pPOQXUEddOeZpOLA1pQORQtH7YGI4k8iHu9rtVAE/NVkdHUNr4Fw29SfF+2j2cCQTKw51cJktOV
 JplC3f/Vmxgdixgj3Wq3WRpA7LXIcUchi1h3WnmgjHeBXHG/HSblri6qzAy+LhRzNy7TLru/mPN
 yqOT3H9hM072yRg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Certain calls, like clk_get, can cause probe deferral and driver should
handle it.  Use dev_err_probe() to fix that and also change other
non-deferred errors cases to make the code simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra124-emc.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index f3372bd78ce8db666015a7844cba4e6aad79e61c..f4d703103d9ca155eca92331ee762cecd4e01302 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1379,9 +1379,8 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 
 remove_nodes:
 	icc_nodes_remove(&emc->provider);
-	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
 
-	return err;
+	return dev_err_probe(emc->dev, err, "failed to initialize ICC\n");
 }
 
 static int tegra_emc_opp_table_init(struct tegra_emc *emc)
@@ -1390,18 +1389,18 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 	int opp_token, err;
 
 	err = dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
-	if (err < 0) {
-		dev_err(emc->dev, "failed to set OPP supported HW: %d\n", err);
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(emc->dev, err, "failed to set OPP supported HW\n");
+
 	opp_token = err;
 
 	err = dev_pm_opp_of_add_table(emc->dev);
 	if (err) {
 		if (err == -ENODEV)
-			dev_err(emc->dev, "OPP table not found, please update your device tree\n");
+			dev_err_probe(emc->dev, err,
+				      "OPP table not found, please update your device tree\n");
 		else
-			dev_err(emc->dev, "failed to add OPP table: %d\n", err);
+			dev_err_probe(emc->dev, err, "failed to add OPP table\n");
 
 		goto put_hw_table;
 	}
@@ -1412,7 +1411,7 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 	/* first dummy rate-set initializes voltage state */
 	err = dev_pm_opp_set_rate(emc->dev, clk_get_rate(emc->clk));
 	if (err) {
-		dev_err(emc->dev, "failed to initialize OPP clock: %d\n", err);
+		dev_err_probe(emc->dev, err, "failed to initialize OPP clock\n");
 		goto remove_table;
 	}
 
@@ -1480,11 +1479,9 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		return err;
 
 	emc->clk = devm_clk_get(&pdev->dev, "emc");
-	if (IS_ERR(emc->clk)) {
-		err = PTR_ERR(emc->clk);
-		dev_err(&pdev->dev, "failed to get EMC clock: %d\n", err);
-		return err;
-	}
+	if (IS_ERR(emc->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(emc->clk),
+				     "failed to get EMC clock\n");
 
 	err = tegra_emc_opp_table_init(emc);
 	if (err)

-- 
2.48.1


