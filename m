Return-Path: <linux-kernel+bounces-809985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5A1B5144A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72567B715A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDD131A05E;
	Wed, 10 Sep 2025 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFjOG2Gb"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843AF319847
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501067; cv=none; b=dLQ1T37BJnsc5QUaltZbI5a0ZlHJ7jlpjc7NayzBBcUtfB3MFtVo9owUfogOea8tfIPHKTT8eh8C4igWVeaADakDHyr6rWJo2IwUfu3u6JXFmfUvGEgyexRF3WOkyNn2E4B3FkgqCJveQCEjrxnAlhyCMcloBJFGUevXTAqdn88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501067; c=relaxed/simple;
	bh=sumypjm5su+//BJZ7zcWLArNigqTGnmSYrUE7kO9jkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrkb5fie+AkAswS8JxIizxYC7qIUI0ldGt7i1YhAwHvRxc7ft3g/pJ/GeKSAzYAoiiwwhS2EDamKd1kvrMDMtkItyQS8huMpBI5/Q/iEDWjufZGJHSnsafMNT8q1k7rMYfpXM9m/sik4R7vrOJrXCcQeVsnh3zvnmS0Zz9CECQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IFjOG2Gb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b078af34f8aso5201366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757501064; x=1758105864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOK2rQuOJsLR6f1VEysNbCIuj//keNB8l7Qc/i/XdYU=;
        b=IFjOG2GbrqL7OTrWskkgfsJ61+WjDD2IAbCeZL8Qx5IHCwu9BeDJvOmy0E/rl50QAP
         qSaFiDGqdPfGOvMPdNenR+VSWuVfabSfaCOv/28yiQ933JSqP5ssEaSksMQGHHD+DSyG
         dOMydt6let5QFMZvrQ9Mk010gWlOBXtJla8CytnH0fWCM4FGGmqnTtHSfs1ylYcK5T9q
         ZUizRjiWNM2G6W4wAoiyDf1elb46IKYWSLBexD4wuW3iJ1RX4Iv9SRqa2wV/6mo3m+rq
         BVRfjZkdC+ZYnM7Qf5DQ+UZlkBmPrXCQnDxRpTglw4EhaVRkmEsx6MuK0pk7d4jyA4sG
         Uyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501064; x=1758105864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOK2rQuOJsLR6f1VEysNbCIuj//keNB8l7Qc/i/XdYU=;
        b=Dkddyh74xkLJdbAFp41nGeTyyFrMdtUUXX/xBzMOu4uA5pDnrudyPAJ7xriXWA0N4+
         eJjPzRQyLwfW1MSZ+9op+0q1bCU0UZswrCJrGexpdph023J5Hj/XgzNyd95kfemZRQwJ
         8RruviUp8E1PgSS57qsyHTjkl51aO4WeDf+R3TxMEpWUEXU/Q9o+1JTvvPOHj3krFc2V
         ECyWDAaC3r7gYbjpL+EfiCa6LET3BnPCyQeDQCukx+Id+4b5qkBPYEXJCKsylG9f6zZt
         gvbWjAWOPESMG2EdqoLTC7j/GSd9WB4PKLIc7JGJbqksZh2Q3ZdtDLD7YXGomUO01PIb
         Y59A==
X-Gm-Message-State: AOJu0YysgSHnHrHrbbv+k+AOftFrQwYPqcTqwAUZn38FIS6P1DyZ1pN3
	Y6LTrbrJaR2lEk/Jh8MZ01aFtMxpfwhC1OSL6MiyXS/1d0E5VGdu51Ap15V4w/QAhbc=
X-Gm-Gg: ASbGnctj+zjlkjJ6vauUhuO+/k8DqcUS1CDgL5hWRWlJnu7AG/n7yb64g9Y8m7LHWpu
	vQlXnYqQNbes/2J5a86ph2xV3/GhBt9J5pHBEHmrpmFbGs49kjf47FsP+AHX3a2Yux1ieC3KQg8
	qO28ugYiGnhdJtoZkDx7/Cl4yRdhoCx5OlpHcFdKwqBB51Vm6cD9/5wWbrH7gyprbNYAPl+Mio6
	2FoJjsh4F+XvpWFM+3aLlIiPFXFpA5gnJrEAPQUPgGeyoNbpAyYsERpUTEamKn8ho0dSYHI8oWb
	ilg4AQey8uPPcjdaYuHn5KKidCwaGakT8p2NctHG3wXZaJ/4F263JljHJ7a7T1ylmIlZMSW2xhV
	A0OqTLuskpm/r7n1w3r3QyFXX+4UZdD64lEu9rEX4jykr4jAQ5g==
X-Google-Smtp-Source: AGHT+IHt9WChMw0+rY+8EShFnRqB8JsLiQJz6XJJbue94qNa0yNdnkkXZabhr0KiARU+GoUEdm4goA==
X-Received: by 2002:a05:6402:42c5:b0:61c:3847:680e with SMTP id 4fb4d7f45d1cf-62373eee562mr7728900a12.1.1757501063860;
        Wed, 10 Sep 2025 03:44:23 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01ae5f75sm3144890a12.46.2025.09.10.03.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 03:44:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 10 Sep 2025 12:44:05 +0200
Subject: [PATCH 09/13] memory: tegra124-emc: Simplify and handle deferred
 probe with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-memory-tegra-cleanup-v1-9-023c33a2d997@linaro.org>
References: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
In-Reply-To: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowVZ2vhXVORmE0UBFyEJs1mgv9ug/wYJcfTIst
 KmztF1Wo2mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMFWdgAKCRDBN2bmhouD
 17CED/9WkA3GTNjR9hH5/Bgi2MEp8cmWRLy23FJaMLB/wg6jo48W9lMULvGXblt2H8rHk+5v+lf
 3omqp/TJciy6Jfx5/pKBrkD2q6XwCspvoK8vr/t5VW29/8KWc1dRvgbHtIqMW2XMC5VdDCvokAX
 JwD+me8AvHVAtSFjyVvciffEdWGKIJMLrT4JQwZIdHKtyZY3MHB0p6fFAzqEFbOTg9OFpp/RfxX
 r1XbOuiBcOMhVm6828ZuTmCym3GYOmC7GNdakCYjYpEQRTWx5h3eHTdDEraIaF6x+XTK+gpsPOH
 t3i1owWjAdSSXfdW66DLlkJnccD9gDGAmHSs9kkCwU6vzQ3oXOeYaa9vk0dY2LDXPtNhazk3FQs
 YExryTstvsUSeGpWgCNve8T4D8T/mIhR//gxI1Q444Uj7uhhPrxhUqN13Z3nNiDmm6l9G1kRryz
 YFF4VvztJvsMv87R+e9OGFWVm6u16b9qqtyxHF7wgIletWNfvEziiPTANO8/gEJ6YiSrJj0+JGf
 otvAMn7dxcceztGc54UagCBcGal1rin5XpEtjA2J7qZaSp5b2iI1TGQNi47Zz0inrROCMKHQGOB
 XI4YY5mKMtPinLk/8ogdc+VquEe69iatFeEFkPSdwzFIDmDpOF6n8jOP1LDcL9rc5JYjGOzysqC
 mWFUso4M1rpzqZw==
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


