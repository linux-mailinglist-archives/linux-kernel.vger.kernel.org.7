Return-Path: <linux-kernel+bounces-891752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7303CC43626
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 00:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0896D188EB63
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 23:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A7D285CB9;
	Sat,  8 Nov 2025 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lcARcs8p"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD228CF6F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643611; cv=none; b=gnYd+M0F0UEr3KNPiCf9rq3QUcrrFNnQ5BLGsqDD5mD2yse1fXR682DvJfBJVOWEXlXxs/vQbj2o3+lEgn1XM/UV319Q2RVsPKkgGG9rv0Yk8AU4j86oDvcli7PD2SGQW5R8dz4kDOXbwuTRHf00wc0mFXoqD85FcBQQWyWY4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643611; c=relaxed/simple;
	bh=MXwD98+QiCRKWpbu3tuuKlm8W3tPdoRbgTcv4H6yNxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkp78qaJPd0cgL7vWuMjwoWHv4EIdYKzOVmzzSmOz34AVlP70PfHJAPzgFLEuU5cdv9OiVkA8iaooOMFdX2wq0nCDpP9UG63PBv8KtAs8KSeZyWppXHnJPM8VvtZfxLyP0M97YyV7qwnD+I1wtq1A0gtxRRgO2Q5rqoZb6J7apc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lcARcs8p; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so2884072a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 15:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762643608; x=1763248408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cijZ+09YTsl3uHzpkuOiO4+DMdT2cKq32KSIaXuX+bQ=;
        b=lcARcs8pc6IYkG/VjQQqpJEWODaaz+Q6v4rMlVxi/IjvToEPCWsigNmSARD42S1U1+
         x9LHuMtbntSnTyK02NP9lGiTofuAMpYBCHidrElP/LgYQ43R3CMYXeWksojECSyvjxY1
         n874ZFELWwo4hECURFn4rxtmyBbAs7oodClMvb4qI4Zs0I0gZinAZpgxrrXUCq6XtgvD
         x4LcDejCpD7CIVkqOozXE/Tyel6JBPfJ6bD96o3vzSukZ3amdDAZHNCNAX/tIq3jCUI0
         FzL98KHUmwlac1dK0f90OFK9WhP/5oxCwPffQL2LZTFMfDMKHYX27hq0i9te1DPmbkGr
         yj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762643608; x=1763248408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cijZ+09YTsl3uHzpkuOiO4+DMdT2cKq32KSIaXuX+bQ=;
        b=OOPVux/Kd70ywBtdE9lEqqV0p3EeYxDKmH2OLfNwJc5twef8FDtH464js8JQTZKsZ5
         1jFA2zR/YqexVu9kWuE+dR22f8oJsgPoPexo8OUB3x7OrjoVf2WNi127FiTljhZ3a99k
         apnZXOeZzJag78LVZ//fn40Kh7Ei+j9juSCQY9BgrXolnHM4PY8e+w4MozCu/kuCu5Na
         exxfJNKEcPGF6iLhFKaHitghEvYuQh3r/m3uhTRk4t5JoET9IuZi4smBf7IB4ypTh8wW
         K1i1/UAzPnDFcscRV4WMYiCI8JY36N+z/BECt60k+/52TOZJ0sBkdYmARL8Jzu9PiOdy
         J9mA==
X-Forwarded-Encrypted: i=1; AJvYcCUnecR9Qi2sJp7UtZrM5ogVTgGg8AvnluGk7DACgkYQWRHtB8yQ29YQVCVu+Aj7WSZoya4RyROGRmTZmlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4yWvoe23kL7nP+JoVn1uC+3qGikcedxMQkf93pWDERXLHc2JI
	X0Fwob+qZ7aJdAd2eT2ffaxM0iZ0wODthMVyEGkJWmn2t9U857UvNYj1
X-Gm-Gg: ASbGnctVeEUGCj/TjutVmKJJ1IPNKiGPL6KIWCz5vC703HzJjXzUGbd465sgpkhFGcE
	jCKIxbMSgKg35ci9zk80aej/LZsguR4uLpF1iWqWg2qndcSss41Q4PcOyyZzFHN97QQIDeCLgL5
	rHJmzSE1tXtWsHITnyMD3aPTwQBkJrWR0fin5ej4OGMDULZej5T6yaNmNeZJYi5Ya0gV4JpLsrg
	F9xDbTYRRI9EPRlT5FrA02othyMrXCGG1/BdK2kEIErSLYL8Qt7Us0vPZyzwBxvAqErJ+Bb9GHj
	Dkwf7/3OQqcpBJaDzumDP++YHDZCcBeJWtB1juYsPWj50QUFmfvZaqh14KlKoHSS2S76pvXjMRC
	oqvWUbU6nz/5XZhdRT7JhKKfOD9hRmUwYKDxarORqnqYwxsjh/MLk/Fp9UnAwPgPq06Ew1D9kFE
	yeX2LyXw1Nq0M7+V9jZv6opqP3b6smnu0n1gYxtLZ27T/ZCCU8hjE9+7AuXGLKP9D62yFDPyXE5
	DoFzbQ0AzfLDF8R0AuZls7ZK3mf4Q4uM9623X6t0FQ=
X-Google-Smtp-Source: AGHT+IGhMEgUC8oM2+pqlrfLLlvVoY4z7bHF+SAAYNYxAbvCQcc6jUd5lgOvOXrATxrEZssO/EG4/Q==
X-Received: by 2002:a05:6402:4310:b0:63b:dc3e:f01c with SMTP id 4fb4d7f45d1cf-6415e6cc622mr2587683a12.12.1762643608311;
        Sat, 08 Nov 2025 15:13:28 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm7642807a12.13.2025.11.08.15.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:13:26 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 5/7] mmc: meson-mx-sdio: Use dev_err_probe() where appropriate
Date: Sun,  9 Nov 2025 00:12:51 +0100
Message-ID: <20251108231253.1641927-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This streamlines probe error handling / logging with other drivers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 214ce84f1ddd..052bcf8f32df 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -520,16 +520,14 @@ static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)
 	struct device *slot_dev = mmc_dev(mmc);
 	int ret;
 
-	if (of_property_read_u32(slot_dev->of_node, "reg", &host->slot_id)) {
-		dev_err(slot_dev, "missing 'reg' property\n");
-		return -EINVAL;
-	}
+	if (of_property_read_u32(slot_dev->of_node, "reg", &host->slot_id))
+		return dev_err_probe(slot_dev, -EINVAL,
+				     "missing 'reg' property\n");
 
-	if (host->slot_id >= MESON_MX_SDIO_MAX_SLOTS) {
-		dev_err(slot_dev, "invalid 'reg' property value %d\n",
-			host->slot_id);
-		return -EINVAL;
-	}
+	if (host->slot_id >= MESON_MX_SDIO_MAX_SLOTS)
+		return dev_err_probe(slot_dev, -EINVAL,
+				     "invalid 'reg' property value %d\n",
+				     host->slot_id);
 
 	/* Get regulators and the supported OCR mask */
 	ret = mmc_regulator_get_supply(mmc);
@@ -666,7 +664,8 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	host->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					     &meson_mx_sdio_regmap_config);
 	if (IS_ERR(host->regmap)) {
-		ret = PTR_ERR(host->regmap);
+		ret = dev_err_probe(host->controller_dev, PTR_ERR(host->regmap),
+				    "Failed to initialize regmap\n");
 		goto error_unregister_slot_pdev;
 	}
 
@@ -680,12 +679,16 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 					meson_mx_mmc_irq,
 					meson_mx_mmc_irq_thread, IRQF_ONESHOT,
 					NULL, host);
-	if (ret)
+	if (ret) {
+		dev_err_probe(host->controller_dev, ret,
+			      "Failed to request IRQ\n");
 		goto error_unregister_slot_pdev;
+	}
 
 	core_clk = devm_clk_get_enabled(host->controller_dev, "core");
 	if (IS_ERR(core_clk)) {
-		ret = PTR_ERR(core_clk);
+		ret = dev_err_probe(host->controller_dev, PTR_ERR(core_clk),
+				    "Failed to get and enable 'core' clock\n");
 		goto error_unregister_slot_pdev;
 	}
 
@@ -697,7 +700,8 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(host->cfg_div_clk);
 	if (ret) {
-		dev_err(host->controller_dev, "Failed to enable MMC clock\n");
+		dev_err_probe(host->controller_dev, ret,
+			      "Failed to enable MMC (cfg div) clock\n");
 		goto error_unregister_slot_pdev;
 	}
 
-- 
2.51.2


