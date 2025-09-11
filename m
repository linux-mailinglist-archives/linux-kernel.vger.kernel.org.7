Return-Path: <linux-kernel+bounces-811760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD18B52D86
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EF6A08609
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9512EDD63;
	Thu, 11 Sep 2025 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdTOju7G"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7ED2EC0AB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583817; cv=none; b=rnjFOj60h7iSA7GHOuigCgqBOUpbdyPTGbNi6NdSV/bjvd5AWdcXF/g1r6QLNXCm4r7lj5FITTSoFg/txrTWQFwNIkZg3wIlWN/dQXOA6d6kNh951dAAoN807p69bzQiIx+9+En0VqC5r5mWSni2XZ5iUaG4FTXrFCh8KTGoKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583817; c=relaxed/simple;
	bh=9uLbL4CfehXgK0FgR1jl+4z97FyCLswBjlNfgLA3G44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jnJGwPgfghRqHF9OQe1vk3/SPYIk5HECzW8exY4pBh8Rna5b7XoE01h50e7eaX/3LqhkEoULb9VfqhoqZkHQqpRZtl2+IQtQVtrnpQwYIjN7MCYbsvbcF2DvT8KMeZJZBJ1OCqtjszESD/vHQaikH2/hTCMwziEOPiG75OvbEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tdTOju7G; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0ce15fso933485e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757583814; x=1758188614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqRItD2bt3js5TTmQrynwO8hQqUf0mH+3ap8vOPgmc0=;
        b=tdTOju7GIecgXuPKmodd/ZazcvvbehnWM6hZV88ooWbZTHNJwEBUKy6VM9BzhG9MEL
         k+IFdrL7lwci9Ks/WmDJc0zApCdQl2T0gog+sM+9eOdGlkcTRu4ekz+W3u+1A8W/MVdw
         XWDdXzJG4iXms+30531xxllCg1uXCzeyCu5HE6yo4SVnjc0bPw4ZGFsHq3Ti3ejqoCd2
         OsjjPCEEWFZvEPAfOiQT3oY411L3nq4ut+YVyUhX5bZ4cuPwT50mzLR6zzVpnFZrEjfO
         PlV3+jRwAw42fDaU+0j0JI7saHI6fwaOIzcaHWIGyl3fJpLJHJpgl5TsseFZWDNLgZVf
         4lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757583814; x=1758188614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqRItD2bt3js5TTmQrynwO8hQqUf0mH+3ap8vOPgmc0=;
        b=A3d9JGG8TJzyEDLbBkC8Bdf09lSuHp56sF7qeITJ2Smtg6nHAkzY8dH/I39zh05omM
         vWNl8+qklkOVcLpTN9vTuopZtei5YAhNL+/8FhW/D6xIdMcmtP8fBmrbRppaFYa+LWlH
         WMYw6uNMk4F7jjgwNb6S5JeKZ4u5jKJ88+psGM0iALFdD5Gk2hqnzq/IY3Xzj8R6TWM/
         IDvSOG7/CPEsSnSMvICurF8hEdOcSVtfPvwaqpsvh3S0yDnYFNVJbkec5qG8BF6mYl6G
         7Sa1FZ1+Jj4csQSKS/FP0kkOj70FoHM8QLlg8OpXTX2h1MxUcBsv/OMkf9S+J+WDDID2
         142w==
X-Gm-Message-State: AOJu0Yx6lsWhfNpgiITUfqcxJ0WwaeQwTTBqVVXkkRckNJb8wJA04eC2
	iM2Hitl4SeG84ARZQfB0Jpb3wh9hQtIMs1W3BPZ7SPaWSMKuWHsF7OR6r7or4XzRun4=
X-Gm-Gg: ASbGncsJYZCaPVelaHBt4yxXD6FjtUig0stL0ywTrKno9ky0K+6bhZj/RQ35urYos8m
	s7rPIR42Ch5ulNTRAA/3gqWQWa/F6hx7qPw/3DNLIzoCsdcrKmd9ETRAmNHeCmmuoS4OxLRI9dY
	QS9iD/GxO8NqMzWlBu6D8Ui9cq17NpL5U5HV7A1MtDQhAg3rDKlMbx2dfZj8hywT2s1dj7mUAww
	qkLmj9WAXkifM2AJ6ekxh8QSjPg9zISYOGg3a9KHRy0DdDHqxwg90Mtzf5nSsPAgJfVlJ4svxJ9
	64MXAv26MLyZt7+64GLWat6J1GkGZ/xgX8R0saai8Ax59pCMH+ofS4+js0DE0nhDUbhZkEzamSX
	LP20bqD7iLVwoUYVIFN2Y9Vaeg77LpZD/W4fUJxXfdjZGJky3/w==
X-Google-Smtp-Source: AGHT+IF/UhrqWprkaN640qed/DfCGwg7Vw72qdq8PFaV5rt/q6nx97cRxngQECQXshfiBlN0JgRgdQ==
X-Received: by 2002:a05:600c:1993:b0:45d:da49:c475 with SMTP id 5b1f17b1804b1-45ddde0a13cmr81741435e9.0.1757583813832;
        Thu, 11 Sep 2025 02:43:33 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e76078fe3bsm1759218f8f.28.2025.09.11.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:43:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 11 Sep 2025 11:43:17 +0200
Subject: [PATCH v2 06/13] memory: tegra30-emc: Simplify and handle deferred
 probe with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-memory-tegra-cleanup-v2-6-d08022ff2f85@linaro.org>
References: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
In-Reply-To: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2183;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=9uLbL4CfehXgK0FgR1jl+4z97FyCLswBjlNfgLA3G44=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowpm24oqvTHVAOF9Rq8i0mjZwTtnJuKFFxYt2j
 opJqGjF5B+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMKZtgAKCRDBN2bmhouD
 1+woEACLJwCCvryDUj6nedFa7ciRAt6z6uMVkga16E5DH6vokdSkj3K86WCISjS03oAvZp/5a9f
 Ap0GaKgfndRG95e2VKczvWjGEO8dZdvYtOsammc3FveGGjIGsYfnEKYbM3TNRhfmERsUOvKmuWU
 VKX6OhUzm7xLG6jI8XaMAsd26YkO8O0UN3I1N7BN2aXAww5G4NZM1f2FO4sh84jwbqdS87++/Ps
 AxlpDqfcCurrriA3E4lTXS5vvZALjejUkCrOkO0nJQbTeqoF/PPtTg2gP5yeigoaFIwh9vP0A/Q
 /2IFKwJj8R9VDU3Ge0WF4dG/oxk5gtDqQctP6Qlem6cMN8OLUAS5+t7QwqM4gDZGaE3eZrapRYq
 HkWWuxhRlZH9lkla2J4xXTPY75Q6kd16mVP4PGwPBTILzlBsr6VjSjAIhHgPkjlRzcl/SyTqELd
 rzLL9fwRDMTGr/PsQWfmgzvm2YjVcZGJG4c+0a5rBecKAWQ54IZSeDRvKhfNUwwAEuT3eJ0gqnS
 igyDVhYPTaAlxU3hwIK7YcLNIXBmz8Kk/s7+ijo5xI7S3NdkAFKZB8bGn1eznbQPfjkfNH8KjdX
 YfF2TpqFp8yDhFvyPqPU0Tx/3pQmkkgCwnMBxlrFa3afHU4gJkUf9gaDQSdHckwr6uQPvifODBz
 x4JgGde4f959Wng==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Certain calls, like clk_get, can cause probe deferral and driver should
handle it.  Use dev_err_probe() to fix that and also change other
non-deferred errors cases to make the code simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra30-emc.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index c96aa63a5aa085a409ae7ec901d2a210748f5bcb..cca386af423e9647266878ce6cd1bcec09c8eba4 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1563,9 +1563,8 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 
 remove_nodes:
 	icc_nodes_remove(&emc->provider);
-	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
 
-	return err;
+	return dev_err_probe(emc->dev, err, "failed to initialize ICC\n");
 }
 
 static void devm_tegra_emc_unset_callback(void *data)
@@ -1592,16 +1591,13 @@ static int tegra_emc_init_clk(struct tegra_emc *emc)
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
@@ -1654,10 +1650,8 @@ static int tegra_emc_probe(struct platform_device *pdev)
 
 	err = devm_request_irq(&pdev->dev, emc->irq, tegra_emc_isr, 0,
 			       dev_name(&pdev->dev), emc);
-	if (err) {
-		dev_err(&pdev->dev, "failed to request irq: %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "failed to request irq\n");
 
 	err = tegra_emc_init_clk(emc);
 	if (err)

-- 
2.48.1


