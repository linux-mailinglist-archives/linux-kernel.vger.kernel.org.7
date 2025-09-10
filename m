Return-Path: <linux-kernel+bounces-809982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12473B5143F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAFC487E54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54085319840;
	Wed, 10 Sep 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jp5UqNS1"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B3D2C2365
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501064; cv=none; b=F7ZOVBKVLJ/NFEjTJ3cYZDq26Rg8ms+SYei9Jx1NyP0fiQvWuGCUnEyQxBy3Xxa9hBlqFFFteZHCD2mtTVodCShd8m4+xj3WCChnOt0qv+haRUd48S144/jdYFcbdK+HMtjsjwQToUSjUFpgZEzI0ks76SKZhhx6PxAsTzXde6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501064; c=relaxed/simple;
	bh=9uLbL4CfehXgK0FgR1jl+4z97FyCLswBjlNfgLA3G44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXcjp4+ygzroOaZdeJdMDcIrDo0A0hvHHpbOjfYeAfOkG1pt4TirxbBouhDIoFuVYF5WVaKz/sVrooXadq+ezy0165m4Aq5ibAyLeLG8LSB75OZ7SsZh0RBczVUf4K2tREAQKNbDdj5AEeljLW+E67zllAwtaV8jChr9W/yaKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jp5UqNS1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6217798e8acso992503a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757501060; x=1758105860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqRItD2bt3js5TTmQrynwO8hQqUf0mH+3ap8vOPgmc0=;
        b=Jp5UqNS1eN9d8Wbrq5dRSOoFAUz0ZBrPhdanqQrMnlfWE4ePAOF/vuh35Bd5fRorXW
         7g27a+HIrInmcLsfJZHiN2D4A301ZvDEtdymFly6NW+PL87dNv2fqQi2NJEQl/cK0Xtz
         nbcO+JtKzfi3jaNo/EpyvbwTtR6WXs1cDe6n8zrBWNnHAaONPeYHhbZaUdg4C4GhCnhA
         EvhNicI5/ploCgnA4zMPrfqE/BXugHucamzWZLH5fJ+fqplgqkEy/Qpv1roPX9ZAnl4w
         ZrcgUTycHeeeq40bwKEgTtgeCdbFIMLg9Sk17/DxioVruW7e2ACJTmAohGBb69Ivcg6B
         rOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501060; x=1758105860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqRItD2bt3js5TTmQrynwO8hQqUf0mH+3ap8vOPgmc0=;
        b=nJKoArGlD/vyXqRJ2kr/wTcf4Qd4X1P6ro4uPhkj80Bok2RHGz5qhFzNVH+ku5lNq1
         V2F8Vcg0ETPpuY2rS/mlpkSejKk0obbHib45KKG5YuB/cXInN3qB7MsilUXlNmv8LcxI
         nfs4XGg6cwYKRk1LCCnfWAWIqIHNJ75P4pwYwOyoqm4gmt9sK6aJNz1SqvH+dH3ZLjP/
         G7N0x2rizvh5XCO+LIbSpKyryNEfDFZPhgL5yAdUNKO9AaqHBxiJYhguax8U3A3WA2lu
         Ful/8S2yC+HnyL3aAQPRMmfOQ0e6TxFOwyTY8Zhagz8gBm/zl1R2HFNYdUEX+3uzZDdz
         FQQw==
X-Gm-Message-State: AOJu0YzBSOABrF1N8uXq8+UMIY8TVRbQBMa5hpDnCvV0aCxIxiD3pnhH
	dmBzb5szk23iPDaLw9SkBJNT0VS7qlRLiUWeWukImwVDemRTPGjYvjHXHHsEhT3/qKQ=
X-Gm-Gg: ASbGncsOjOE3DseP+05/Sqxkvwkn1EDX6dXYOSvqXibr56iyjxTCbewGOzz4JxOPdKn
	psLuR9bWjgBfDKO32v6sxVce/Cahz9E/Ha9hGI0QVnN05/GLyHoED4D51ebmksU/mLdk0u9dyca
	YkOZcnpPOLliHv/mH9A7kslRSgbcgji/YsXt8lQ1hy3XXUZm0yY6ejmcfePXXpDW3luWddk8eP4
	iRDIfH9paK+L/Yii6WrSTq+pD35ArQcavBrUrjKYVc9vAY0CcYcV6dzzzjCcu0/9pnc/K5/cGlA
	kFyoXmIZbatR/Yeeidf6CQFdZf8St12xrFt4SIsu48Jqv0kZ08M/8W6iqu/cAlc/UrBkl/99vds
	r/V/HjPfsgArCUikyKHLm+dFplh1zAQAtRiByjDg=
X-Google-Smtp-Source: AGHT+IEpTQEtThVJ24rqHPh2z2AuC0Jni6hadwlzpRBmk8LSW8tMLyniWOtwKNncJCF0pQQNoWuS9Q==
X-Received: by 2002:a05:6402:325b:b0:62d:c7b9:b149 with SMTP id 4fb4d7f45d1cf-62dc7b9b348mr461877a12.2.1757501060110;
        Wed, 10 Sep 2025 03:44:20 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01ae5f75sm3144890a12.46.2025.09.10.03.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 03:44:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 10 Sep 2025 12:44:02 +0200
Subject: [PATCH 06/13] memory: tegra30-emc: Simplify and handle deferred
 probe with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-memory-tegra-cleanup-v1-6-023c33a2d997@linaro.org>
References: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
In-Reply-To: <20250910-memory-tegra-cleanup-v1-0-023c33a2d997@linaro.org>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowVZz3v9AbJoO2ZDaH8ze2R7RA8EtirBgZASnh
 lSu5ws/TJGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMFWcwAKCRDBN2bmhouD
 14nSD/4n+XU86XSAKNv1sV0NhsLqho9+ahJdat/d4NoY2PTqmvCcWi8fnFuAUo6QzycsCIAxofq
 eDJI/DYitrW42nBMAZZfM5SkaNohsY9bXviojcRLC6KQ5zTHaWF09EHEGUtcBGIEzCyc5A1HPtb
 PtooA36aEQHm9X2+K0qJrgdJKsk2Qpd3hrnFuUGRLgPx3gfenJFhvGLdH1WJWXo9lketY7ynjFC
 zyxbRvNoh+RRL6I+OgfQEX13zQSnOiWGP1FvLEccsDb0NIjUF+r6dPdTwZF55acqS7H7YiV1gdw
 jSLNeJWNzneRwHnHpviy7G+CJcGWbWlnqsF0Frn9zE8YPPuXIZMCJYjmclspe028FfeH6zLx70J
 BpqlOSpJFi9niVl9N++TVp02WgXaOwi4H/3N5fe1PB2yIdF2ZRC4/t7akwrOIHTCakfRej4jNoe
 H+8595OGsv2r93lquQoel4cHXJAwRvYUep4D6KWI9zWWFQy2Tl+YykeUCVj2Pp50jSrGldLRnP2
 g+9L4um2sAqgEsI6Khk2aqSUNai4B0gHWcnCwEqkVSyRN/saXktQ6wGHe+Ee5UtXrGxjKtoUHdq
 HTm17+Qzxz/P6r82SMkLMqjzsAYY+J9Tfe+IctJSCAIrKNID0aBryJTLj8IyHViNm63tam+zvkp
 bLx2I71sqNEs7Ng==
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


