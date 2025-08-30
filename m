Return-Path: <linux-kernel+bounces-793066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141F8B3CDA7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCA02017B7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6822D24A6;
	Sat, 30 Aug 2025 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qkw891aE"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803CC168BD
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573282; cv=none; b=JXQbpfWOQLNVuko+3WPwNlQDrOnHRtSo6p6H2Ev+HDGFPLdUExrezeKwp5j1/FfvsDQNjMDFBjHBbdxBmWsnLElF7Y7L+3Ev8+n4uJD/b4V80TFw6qP5XUQA27ussRNywt7VDhUpkdCJeJA0T99YHN2BjTV+C6pb7teCF9zXwhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573282; c=relaxed/simple;
	bh=RPUJbg100xa0IEvnoF3u1mdVLmvj7pTfHeSRkyLDqeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7rJGI4zo4YhSh4ZZt7r6lZNQ1rR5R1TJ9DXdrUcdY0SPRP5Fn+4hOsW2pjCzGExgGe0ODFHyU5upGx0lNSP0kY1oiWqVc+rTOfL/m7sJpbVGnUjqHPrUIBvhxSpfzb/fUl9etnlOKz9Elu0UR0/ATjS/YTwvMt+pU+nJIbs0qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qkw891aE; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afe7f9fdb96so41301066b.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756573278; x=1757178078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdB5MqNC+p3bmf/ntWx5h3e+QQrokyQ+em8wO8bj1sc=;
        b=Qkw891aEUEZdoBQiqvMPCPc7lWTnfMqpIFI1KYxLzvRDWLJwVJ7sPHL+86IPyNk4lK
         iSxhk6SRsUe5HEtZ3dW3dmGp2B6Q0ouKJtdKtqvhn2zvgc/t+49M5i2l+pM2BtIvaoew
         RInTEqvYd11YgeHf3dgEb4huPTqSFMudmceaNutoEVcv7FFK1MMpsHMxEn0+sPAbctWk
         ppovUgoXnZVvjcoDdsQxEl6vFbI0p7984QowvvLdIL53uRxtrzA8xyLLl77ZUuNrT0H1
         hRMCexZOjkn4PY/a5tArVtkRwVsu2SDmCcJQVx2aWVUd5jLWqa8ItwGTtKjmjTdTES2c
         N6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756573278; x=1757178078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdB5MqNC+p3bmf/ntWx5h3e+QQrokyQ+em8wO8bj1sc=;
        b=aPCstdWSwADhgYFe0dO4/McRBYpidzdUSshnFnx8MJDB08gIXwefxDY8yTOxnxIJvt
         Mxo0J4dUGIBVA/itdoHy2G8AtrxtNuWJ5uzV2kiAYFoRnqTIOpJUHfcT7nClYoSwnrVV
         tWQ6WV6TUYQzXcwMnOPsMMY9dJvq989teXhz4tQBgCC5i21tuCldIeyK7j0AGi4gFElW
         aR2xxlG6StprPt0TluoK5TaQbcXF7D9+6nDSFvl5OMnaYrJIR+RdPwi5C/QY0x9NVopX
         /WbyBm42FGwx5BrDetM6PVo0h4R/MMUvOGBcNihnk+tGffG+zMV58XMViwm4vUk4PxRe
         YU0A==
X-Forwarded-Encrypted: i=1; AJvYcCXyPVdb0zvGuWEYbhZusEM6pMpHo0ZM9HPyn3GurpMTfCxd0acb7qvpUZaw+jQbAEVZwLHe8s6DnSvGppw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5FeZOArxtz/fXXofPmiX4XDvyKDPiJHqM6W/ec/UEXWxD/khX
	NzVrc6/YN+n8ze06No3i+Y8w1OoWBzXUxXWgYsZh4K/pcdsSKFB5KUy32HSHGYtKFbc=
X-Gm-Gg: ASbGncuPHuX/aF+ML4cC6di+tm0UVMl7pOWaofo+8tLJLYThdX0WkLu3Wn3VELB6r7t
	nWP5byIfaI8XFBxftEHwdSC7p0xpMgyVkSydf1lpfsnFcAhQkoMU3E4Z5GWj+XvTf1mF//7n7ff
	LbIf7OtAMNjad3wQKSRbiikBVaEOMC9i4ETd5WAILw92B2CEnSJoMzxlMsirT41nP2LRGGYNd63
	fc90VRJNe6N6dgisC+btKvPKRS6KoAKyM5bRELQkRc3BiIpepqFMps4ucRAIzrIooHPxHgb+rxe
	6wYzV2TbxNcsK9tjQD/ioEI9NUFWpuTbUG8HKkgc+bjW7qKbUkg0W1xk2CK2Wh1RNe2pEJnydzb
	n9bDGA0nF+OX2pBtHxSNUYKt+rLatsZxIoCYFB/RUl3TMNaTDAQ==
X-Google-Smtp-Source: AGHT+IHe++mZhWzLj+V2kR1/YfRvNVOIAhKLNUILUb6vPmc6HP8S/l0mFC1K58GUtxiQDbdzEfLucA==
X-Received: by 2002:a17:906:9f85:b0:afe:ae6c:4141 with SMTP id a640c23a62f3a-aff0ee05414mr274464566b.2.1756573277761;
        Sat, 30 Aug 2025 10:01:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff12a6b404sm309038766b.88.2025.08.30.10.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 10:01:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Aug 2025 19:01:09 +0200
Subject: [PATCH 1/4] mtd: rawnand: s3c2410: Drop S3C2410 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-s3c-cleanup-nand-v1-1-05b99ef990fe@linaro.org>
References: <20250830-s3c-cleanup-nand-v1-0-05b99ef990fe@linaro.org>
In-Reply-To: <20250830-s3c-cleanup-nand-v1-0-05b99ef990fe@linaro.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2620;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RPUJbg100xa0IEvnoF3u1mdVLmvj7pTfHeSRkyLDqeE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBosy5XzOuvSuRgZYrPBWhcA/8cx0Ta1ZMMtq3VA
 U97dWTDNgGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLMuVwAKCRDBN2bmhouD
 15CkD/9SA+hmrUU/1U3lo3ofl7xEfszMtOVsHre48VzovCwtJVbvY66wq2HilKGrcKVaCJzaThw
 /0pxt9R8+UI8qBpXmErjOiZoOSArSvZwnPrY2IQiynNufwCqsoBkvKOEuIaOtPTOJnsxkJKCk4H
 x9fLs6FX74gWPS9K38wmcebzL+rWDEy+oVtVB+L78jnjI64mH4xo2bv8HKnBQa9ZfCL1LdLNMbR
 d8VElMJoGEsZkOOZxR/stuuVdZD3dXombq/YjrCw2nRpJtyLap6CcTg5TmpVKGL35wdcmXI/OZI
 MjekuYui0ID1Ft43KT0xlyAQUK/IoESXLBVRuIUChjCFuyEuP7RY1u50r+ETJDQb7y8xTWHBE/D
 ZKRpBXP5BP8IiclImSst1JMUfKoM8+gzYSgQd/mOxY+iiUHv9Gb5j/hzNrkI4XBakbHWlHXd+C+
 ndvykMkA5Ymrasd+5bVN6fSUaY0gMUeu8vf+X1Zo4XP4fdMl6MlC6XXSAMvmwO39AxEt8zKVgZm
 dDoFqaKhVT0CHbg2mQfgG8Wr9wGRZ3Rwo5r+mqebEQ0E7kQ3Y9i4h3c18MrGoGn2HVRYpD/mYee
 C1izWKtMDfyU0Yhn1qP+CovK8XgHtSzrkczRxDC/VAivNBM4SJcrnRlUJt0qeZTRqoRew7wjkQu
 3z+KzqjjHeF0x4w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Samsung S3C24xx family of SoCs was removed from the Linux kernel in the
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
2023.  There are no in-kernel users of its compatibles and platform IDs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mtd/nand/raw/s3c2410.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index 229f2e87d56eeacf5fda0ad29df59655b328658e..33130d75c5bab709a3e5cfd6e95b273cf62e4d46 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -169,18 +169,6 @@ struct s3c24XX_nand_devtype_data {
 	enum s3c_cpu_type type;
 };
 
-static const struct s3c24XX_nand_devtype_data s3c2410_nand_devtype_data = {
-	.type = TYPE_S3C2410,
-};
-
-static const struct s3c24XX_nand_devtype_data s3c2412_nand_devtype_data = {
-	.type = TYPE_S3C2412,
-};
-
-static const struct s3c24XX_nand_devtype_data s3c2440_nand_devtype_data = {
-	.type = TYPE_S3C2440,
-};
-
 /* conversion functions */
 
 static struct s3c2410_nand_mtd *s3c2410_nand_mtd_toours(struct mtd_info *mtd)
@@ -944,22 +932,6 @@ static const struct nand_controller_ops s3c24xx_nand_controller_ops = {
 	.setup_interface = s3c2410_nand_setup_interface,
 };
 
-static const struct of_device_id s3c24xx_nand_dt_ids[] = {
-	{
-		.compatible = "samsung,s3c2410-nand",
-		.data = &s3c2410_nand_devtype_data,
-	}, {
-		/* also compatible with s3c6400 */
-		.compatible = "samsung,s3c2412-nand",
-		.data = &s3c2412_nand_devtype_data,
-	}, {
-		.compatible = "samsung,s3c2440-nand",
-		.data = &s3c2440_nand_devtype_data,
-	},
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, s3c24xx_nand_dt_ids);
-
 static int s3c24xx_nand_probe_dt(struct platform_device *pdev)
 {
 	const struct s3c24XX_nand_devtype_data *devtype_data;
@@ -1194,15 +1166,6 @@ static int s3c24xx_nand_resume(struct platform_device *dev)
 
 static const struct platform_device_id s3c24xx_driver_ids[] = {
 	{
-		.name		= "s3c2410-nand",
-		.driver_data	= TYPE_S3C2410,
-	}, {
-		.name		= "s3c2440-nand",
-		.driver_data	= TYPE_S3C2440,
-	}, {
-		.name		= "s3c2412-nand",
-		.driver_data	= TYPE_S3C2412,
-	}, {
 		.name		= "s3c6400-nand",
 		.driver_data	= TYPE_S3C2412, /* compatible with 2412 */
 	},
@@ -1219,7 +1182,6 @@ static struct platform_driver s3c24xx_nand_driver = {
 	.id_table	= s3c24xx_driver_ids,
 	.driver		= {
 		.name	= "s3c24xx-nand",
-		.of_match_table = s3c24xx_nand_dt_ids,
 	},
 };
 

-- 
2.48.1


