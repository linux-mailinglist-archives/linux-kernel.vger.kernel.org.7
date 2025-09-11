Return-Path: <linux-kernel+bounces-811761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB53B52D88
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A43E1C860E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328A52EE5ED;
	Thu, 11 Sep 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbmG3QRR"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51142ECE8C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583818; cv=none; b=O52x+jXUodv+5mceil8IhN8U1F2Q16fnXzuAC+BIELV1YOx44i37yxHDnQYdC9A0yNaLQCHNJFY5l77UjeCsABcH/qOBIGlszxCgWNZWtfM+4PA/+xLCQ6Z3MyIBqtP9rpM5/foLI/aUtS1fHUoXdBMNInE84wNSIiONf0Y51/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583818; c=relaxed/simple;
	bh=M1UcDlfXbj/5vPqirllwe6Mt+pNopstDQ9HKCl8tOeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iLn9GQ5J6FUJkvntrDXhfdT+LpVWhxZlJNDWSVyG3uqoodjDbZzDrndUkF3fML+K6PmmhBYR0mo995NGqZOMOEnCu/39xNvCXYFQQlqlv6bblMOYgEyoHIzwKmnTutX7XKKKMwjAQVxHC/3lkjln/3fjVxsMM9eBw+Y+758hcm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CbmG3QRR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dec4289f0so166925e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757583815; x=1758188615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnBsMIetOHLgxvRafB9XZsD33miPY9fW8C/xMa98MG0=;
        b=CbmG3QRR9WJ5BKhZ4LzQ+u0NfeA964oyXNVJwhav6jELOKUT0GMYtaOhSOj/ergmpc
         5hbaiVIPeSNfJAZeBVzfUkyo3vaXz+PRxKhyEro+uTFYa13vbYCR9LygSIu2c60e5l98
         dv7GMGRksRwB6RPlmriYxaUVB0vKLRRFaTt0wd5Y7hiFlIdvn5zCecvaUx0DdIDFRqfP
         7Wq4z9dmCj1mJbwo3GqfyESuem1u4YvxdozPvr2EY452Ak5TkS+089VJv5cPNMj182O8
         xL1L4jBCOXfA3PW25nqEa0/6FYZ4fqCKAcG7enHSjcraKYuubPRrLSRPsXOcPOGtv4m0
         zNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757583815; x=1758188615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnBsMIetOHLgxvRafB9XZsD33miPY9fW8C/xMa98MG0=;
        b=KGTmqILwNdDtWVQGA9cTfAd9dfymaQZgRaNEIaR75TKZku2CzGzv2gUu/1jq7/JEsM
         B/hVMBMQ2+AHxOGJRbn2a673ItxiXmoHI+UppT0gMKireM2CETZA0rc63ieOpi7QDdQH
         2ZltCFcnIbDZICndh/B2540Np+73VlYqJ+5bpv4w9aPJN2xlm50MW+7Y/6skwwmDtHmO
         vRNpNCm58r28NNg1A8R/GBJmrDxpJzSVjB4USOSMRWQpirbTbmR9V0ucHTV95ojMDlPD
         c7u4w8KMYITTucB1fzLCcMsqrs1ElOB74kPb28D71Sh1NmMc98bsKJ6Pro29spjJYyf2
         Pdqw==
X-Gm-Message-State: AOJu0YxUBaIIrH9DOtVjXgSoeilMXP192c6Gh8idiA8PycRK4/+djIaw
	IPitcacHKinHAEXTizb91vglr5u/3epcM0guhIcUhs2EhXvNAN2mXScPgTYFTqNNksE=
X-Gm-Gg: ASbGncu9nSKKsPWBjcKqh8rA2EwkHfFzy7IDcjl+wQNbUU6FtfXp/ucTT6HADZahyrY
	42jsY9fqOfsW2eRCATmhrJcInfcZ4B3lHZfYljvrOg/zMLsy3gwsloVJMm6YEA/qoDdbFLgt69h
	EyakzS59LqCE39iHHAbzxFz7RtupblCzTdVG+uAn8JK7XiHs/jMObgTluOXH6T3U5Sl/rgZVc2e
	KGdVMGYB0RQEdzZLQwdYJDwMQA0zKGtepwrr18pg3sr6P66rojwYC9ZQwrvbGgzB7EgivIHyfqs
	r+UWKqCzwYcz88Jk/oWtoji/MhvwjlTWna+jNVtXI7LPE7gPkVzvqwXF/cYOG9tA8G1CNTMLAAX
	fvpeBclaes3CDa+ZLiO4c1tVWGggpVO7aC+OUxtA=
X-Google-Smtp-Source: AGHT+IHEMiH++JoRVvHy1y1PZidVKgVZFCcnyZuOWsGWb4yjXBnZ7oLGJoZr0iasMERrGw7+95wwXg==
X-Received: by 2002:a05:600c:1c0c:b0:45c:b659:6fd8 with SMTP id 5b1f17b1804b1-45e04660032mr7225905e9.3.1757583815068;
        Thu, 11 Sep 2025 02:43:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e76078fe3bsm1759218f8f.28.2025.09.11.02.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:43:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 11 Sep 2025 11:43:18 +0200
Subject: [PATCH v2 07/13] memory: tegra20-emc: Simplify and handle deferred
 probe with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-memory-tegra-cleanup-v2-7-d08022ff2f85@linaro.org>
References: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
In-Reply-To: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2340;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=M1UcDlfXbj/5vPqirllwe6Mt+pNopstDQ9HKCl8tOeY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowpm3l72Ukn3gSEbqLzDsJLPtuC+VvBTPRiSsL
 7Imq6KeqO+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMKZtwAKCRDBN2bmhouD
 18tlD/4ud8ibDbzpWdsBXFKTq4bK68MZ6ZdwnmDEBa8V1W1zMtqOpOmj2Z5D7OkWSMdYoU6gZOi
 JV0WDGq2YoFPoXngdUhrR7P3RXf6akwUTdfpjSB/huEnnLGD3WEIFyrBZ+kDkSah/Vz6zjh2C5E
 59XtqWvZV9Qaj2gzbxp/9X1zl4SUTDv6FbMTqpCoiQq2anNgNgu+z5z02dkrNgMm01IanhWVbcN
 5bNpT7hZ2xnLVSsMCF/kUU19QorVcODmTd/XqKRDjvySUg7Aik6GrpC6FrStsXy8JkQjpcQpcUi
 VcXx6fkPFgbrW8ggSffF7CR+tdItKgKRfpG6hrYBKWRLJnbud/JlltSu0Bs3drRe4Z4cOrZ2Rjj
 H1+cswNgYV37JrrhKCumJNmg8+Qx3KgfVrbE3FbEcFmJu6KqQ70dWUeJYzf4Hv1doRrT0ky868o
 HQV4zg3GhDqeY3gFzDI9Xk7X5aj5IHz3TYnLG0lqY2zk8pdkLcdqGsboTAIi2KkQOon0JNR1GEX
 nf58nPhwWIou6Pjnl2+11YaG6xEloZvuF00XbMy/trlT6PSEL7WImk0LvZulM04z6bRPaV55/rp
 t/GIbstDngLsYNjRDD3SLtHOL4g76o3bAbMtk9JtJJ2jG5nPzFuWKzQ3iky6xjXpAHnpgAHNKzR
 IigbD9IwF1fbegw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Certain calls, like clk_get, can cause probe deferral and driver should
handle it.  Use dev_err_probe() to fix that and also change other
non-deferred errors cases to make the code simpler.

Also fix missing new line in error message of devm_devfreq_add_device().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra20-emc.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index a34636a1c4c55419c323eabfe96c5f27375df344..18e266dde5d2a0fb962fadc04161b03fb79f76cb 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -1051,9 +1051,8 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 
 remove_nodes:
 	icc_nodes_remove(&emc->provider);
-	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
 
-	return err;
+	return dev_err_probe(emc->dev, err, "failed to initialize ICC\n");
 }
 
 static void devm_tegra_emc_unset_callback(void *data)
@@ -1080,16 +1079,13 @@ static int tegra_emc_init_clk(struct tegra_emc *emc)
 		return err;
 
 	emc->clk = devm_clk_get(emc->dev, NULL);
-	if (IS_ERR(emc->clk)) {
-		dev_err(emc->dev, "failed to get EMC clock: %pe\n", emc->clk);
-		return PTR_ERR(emc->clk);
-	}
+	if (IS_ERR(emc->clk))
+		return dev_err_probe(emc->dev, PTR_ERR(emc->clk),
+				     "failed to get EMC clock\n");
 
 	err = clk_notifier_register(emc->clk, &emc->clk_nb);
-	if (err) {
-		dev_err(emc->dev, "failed to register clk notifier: %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(emc->dev, err, "failed to register clk notifier\n");
 
 	err = devm_add_action_or_reset(emc->dev,
 				       devm_tegra_emc_unreg_clk_notifier, emc);
@@ -1172,10 +1168,9 @@ static int tegra_emc_devfreq_init(struct tegra_emc *emc)
 	devfreq = devm_devfreq_add_device(emc->dev, &tegra_emc_devfreq_profile,
 					  DEVFREQ_GOV_SIMPLE_ONDEMAND,
 					  &emc->ondemand_data);
-	if (IS_ERR(devfreq)) {
-		dev_err(emc->dev, "failed to initialize devfreq: %pe", devfreq);
-		return PTR_ERR(devfreq);
-	}
+	if (IS_ERR(devfreq))
+		return dev_err_probe(emc->dev, PTR_ERR(devfreq),
+				     "failed to initialize devfreq\n");
 
 	return 0;
 }

-- 
2.48.1


