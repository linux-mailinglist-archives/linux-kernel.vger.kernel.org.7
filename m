Return-Path: <linux-kernel+bounces-809977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B62B51436
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 451907B0EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F8131355B;
	Wed, 10 Sep 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2FtIkHj"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251C269CF1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501058; cv=none; b=szixMRbZy+4+fF3xqmLneqX/Kja+1jwrjGPK4p97QH7kN4G1mB7Cbrg6SiNfX2qzRVfwW0vvgIb9qJSa6KlXP/3SXmhBQ0Y07dT4empiWh1JR93Ko48+F4m/2Dk3m9iwEcpORAuFlO1mvqpDN1Wu7IBHb6f86fCWlrIM+xbG2Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501058; c=relaxed/simple;
	bh=LQehtAx2kmaY57h5u012j/ttcRk/Yy2y8c0kuDacy/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o0sQOHtT7O2L1dqGaMtcptxNM7MVtVLdJ3ptvwGeqEXjCvWlqC0qm54q8lyesVEGpe13QPDgHRkf7wBU8Bjpz9bH7nunhleOO0ef7eOr4PIj9FiLMY1l4V6N2qcnTnGIYEdPGvuYptsp983is/a6NePQF5dC+7jOHaoqsjr+K8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G2FtIkHj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61ea08e565bso737751a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757501054; x=1758105854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJlYrA2HvnrAW5ag27Ypg8qPNoGajHDP94gxoPy/A6E=;
        b=G2FtIkHjjtRKCRMkNT58GH6FogHxVjMZyFAabf44v3PwhXwbxnOzrwo983oaip5TDf
         DFMjCYbXYcOz4gKTIV3U3TuzWaLX61jwXUfRDthw1oFR22bbBNHz0WrXnUjDociz/5jm
         O0pRH0OadGy8QzhpNA7blGgEHYfFZUgm1ZJB1GBpet+Lw0KtbUynicGehnFS/SvXUGF/
         Sa71EHx+IkHP/V9dJBXHx467D//qfOrHsZai4JeGxNNOwJx28EXFpdYbXf1P5PwU+uJO
         xspn50EFaGe7L95VC4tDZFtDI5EtN7w6FdmP9cIxmhpUag9yk3reBS9+QZA/Vm15aOI3
         9ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501054; x=1758105854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJlYrA2HvnrAW5ag27Ypg8qPNoGajHDP94gxoPy/A6E=;
        b=oZv+nMabdF7IjunYEtw5B6tnPUttamkck6gUydOEgSe0scbse9PsU6/jGlKY0L+0JN
         Psva8S0gk5KlppMFV3RBQ7HPZa4a666BuB/fMIizUBZcRVl5B5z3ZUunRjuB/7cd4g3G
         PXG1J+3ByPkhFPjqx+uXlX7R4izeZDEpr5dUcvvDzLWkjNu8faP8QyupvRazACJ1aGG4
         e1Olr7RbUOfwcyVhRS+Tf+JO3/EVGwcXu0eVPQnopK2C/tiEsRjeqoI5MJSaEhu3Kdm0
         ohi0kG2DQkEnIop08+VQdyeQgcQLujxCyjugcT6cNfz24WIF/vIt/Oksm1brnGtx6XLL
         skCA==
X-Gm-Message-State: AOJu0YxbGaDa9mHppf439DX8g7l5dPWWeohnZm67neH3LfuWX7emG6+H
	Xj4MyqTWrK3mlq7tYUy6Fr3YK/1l9/29tqQzJmr8dHTjp8oHyk+YoZq+3lg5RQWwiYw=
X-Gm-Gg: ASbGncv39XzPYIM/3qubijlvyoS04xEEchRWjDMJTTeC7jBu/Um3818Whj7yjdLHiuX
	WywxNoVMxpybvLDMMr9II8guChCbUnP/6LEp7jOXu4yIcaDB7cCpsQ4SnS+xbv5x0auy+SMGJKk
	34CAqoWirpIYcvHNVlc6i1BX9Rx+pksvxbjdXKYgGsDNX7dDXVIiHIKY3oTZu06pxBrZDH0OnMe
	DCjBv53ExC1PfgpITDUGgvMsajEnmnB4rJ1lXffJjbf5Avr+ioZrl9pRCivDsVjdy1DRnqUpvKS
	shpyy9CEpteIoDpfqvE9idmyhUkDAydP392yqcLg69Ao1Z0iUY8d8nQEOOzGQuR4K4x18kjoKXZ
	Z1Tn05qwiPPQMfPn4SnGDasy5yZQVyd5F3l9PY+X/Qwq3VTPcdA==
X-Google-Smtp-Source: AGHT+IEsbT70WA0co9xUhwpaWZsgJv5uTtdJ6Nltro31AURb0/cmiR5p357gd13wnuViD2P0JC7AOw==
X-Received: by 2002:a05:6402:520e:b0:620:bf3a:f6dc with SMTP id 4fb4d7f45d1cf-6237f37d626mr6201259a12.4.1757501054167;
        Wed, 10 Sep 2025 03:44:14 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01ae5f75sm3144890a12.46.2025.09.10.03.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 03:44:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 10 Sep 2025 12:43:57 +0200
Subject: [PATCH 01/13] memory: tegra124-emc: Simplify return of emc_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-memory-tegra-cleanup-v1-1-023c33a2d997@linaro.org>
References: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
In-Reply-To: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=LQehtAx2kmaY57h5u012j/ttcRk/Yy2y8c0kuDacy/Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowVZvbVtQiBWq7kKL7wqwIdyXaSh4vUFKxi4Nu
 jPvYcek1pyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMFWbwAKCRDBN2bmhouD
 1zOTD/93fxj5wirNSqO33U7YLJCBdMWpkWuctswCzYdN4zvpPNv3NXROTZXaO1B0awkxqvMO4TO
 40hvcqsVr/pBxZ4ybn14FSQcapT/JHGp9T8kp7e4WLnVqsVATxWj7BFBwSUfjigEcNoqIAdthJl
 iw/Rsj1/pzWe/JEHqvWmtRhiYNTw/EA/rD49G+V4M03XYhrSQeYgaO4nRSpQJ8spNp8Ta7vE+qn
 1J61Z7r+VO+LSH5LlBFHgvyRGAuApcSoPPVNms1eYy3ksm9yuDeuM73OIrW5EVYvT4XQFIovVKX
 OM3wp8gsU/sNfD52eyMpLP/mgB5YWUjccPQGB//9Lu7hYObSiu9Fh9heNMWO/Dkw7A6VXllJDB/
 rNWXGn1uc4zgKBaC3flbmJUhu4cXdbdtMSRrQrb0E24zDbT91PX/YZAs4HJzvFFiH7AXOp+T7Cj
 Q/+8dPe8awgtS2uuI8fOUlN4nHYjog+Yut77a+rKtlgcOQScZXgLfWESDpi/n55sp3N/J94aNRh
 NuqmrBpT64MhwtHd7S/qLHvcoK9m2pDn7dEZ/ub9GqCZlCBYE4DHrEDEJMJbA5LjxleDFvde0N9
 h3bQHqFQ6n1BjmeHbLInd3wzLgo5VIygdKWV+u0lksA/8WMR1+WpC9zGDbKr9xhRqqwurOicB88
 8kZElxNvKFoOSTQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

emc_init() returns always success, so just drop return valye to simplify
it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra124-emc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 03f1daa2d132a81d28705ec7c62d640d7d25a894..9aad02901613f1b2ed855c11bcd76fef153034af 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -896,7 +896,7 @@ static void emc_read_current_timing(struct tegra_emc *emc,
 	timing->emc_mode_reset = 0;
 }
 
-static int emc_init(struct tegra_emc *emc)
+static void emc_init(struct tegra_emc *emc)
 {
 	emc->dram_type = readl(emc->regs + EMC_FBIO_CFG5);
 
@@ -913,8 +913,6 @@ static int emc_init(struct tegra_emc *emc)
 	emc->dram_num = tegra_mc_get_emem_device_count(emc->mc);
 
 	emc_read_current_timing(emc, &emc->last_timing);
-
-	return 0;
 }
 
 static int load_one_timing_from_dt(struct tegra_emc *emc,
@@ -1472,11 +1470,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 			      ram_code);
 	}
 
-	err = emc_init(emc);
-	if (err) {
-		dev_err(&pdev->dev, "EMC initialization failed: %d\n", err);
-		return err;
-	}
+	emc_init(emc);
 
 	platform_set_drvdata(pdev, emc);
 

-- 
2.48.1


