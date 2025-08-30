Return-Path: <linux-kernel+bounces-792916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84946B3CA64
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA321C20564
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED8426D4F8;
	Sat, 30 Aug 2025 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFi8f7TC"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA327B356
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756552196; cv=none; b=XO4ONPXHOMi1V2ESQcxpiOwTuXI2nHZs0jfmyac8ej12yeQWEnOah6ajJHpfiM1s39iDyV47VkoeV1o7uEfW9Yna5EwPHE1K8cyVvDZQq5wYTWRJIOah8u1qhXLLNTtuVH+KVsRsXEQpPBPUil1c5Ii1Y8ILKeIFGcMba6DgAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756552196; c=relaxed/simple;
	bh=KjoP2OpIwgvcEU8lQlbyugpaZUrY36rc56GQiCq2XW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amZsoBH8uRZGZGvQ+OMe2rnTOXR9ZURoabexTJ5Di7YFkmZzWkZfKz0wTBVL2K/eNu+kXnueyPnpexejc60bbKr1tO5paIaZfLEyROawVPf+5jHv+4mKJlP4bN5aT6g4ARVVmkpXw8a8X76j4++7SVNKfrw0Ki6yL5KinlkDk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IFi8f7TC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afe7f9fdb96so37273566b.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756552192; x=1757156992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbqsXZ0a+2gRMmLHMi/t44FvhwPty9xFovSO5BTpK8k=;
        b=IFi8f7TCxN+nVFQuDVoK8TIJzUUDh12mv1OLrds3nptTbnaoVcikWPjB9L/um1NBPH
         HMWS5F24ez7u0k1mWUAHSSusIBq+Xlf29b0sIQ0WpPUyd7Iuzscj4UMwR6jqzGu13idI
         8HQxqbQ82Omv9rLXfQh7tgwosc8abC1xLdPUTBnh/fMh00zUg+/VfWXPq9GwuQlLxLJo
         4OCJab1EFItjJhXBaw4aNdO31ppnBCxreUKYIDVAtvprErnk8DqSBzIzsiJiPGtxKlLv
         ugDayC4pjjjegsrZf5/U4d9uQ+dLqYF+zxKUyncSfAq+zcWNek10CQHxxMxNJcXrWTT7
         StZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756552192; x=1757156992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbqsXZ0a+2gRMmLHMi/t44FvhwPty9xFovSO5BTpK8k=;
        b=Qd28B/5Mvo4OjX+hFSiLmWcyLZIgNw1quOSgxlOA1mVYZ/FZt4FWTzNs7iQm59ricf
         X93Tm4TYrKJoRtwhjeDtTsACZvRecdcJFVpqyO+cBIQVtUOiw0BT0YJnfhb65+/YsC0F
         elmj2Bw1Ehos4xPto+Big6UdXXreh/772biYmxebdIgQY1gWDSGcqgj/cVB1HvSFmWg3
         JaAiKZmlMyhmroWCNaAX1HaIqHOqArMFIvqKoMJpqgbXsoL8yzRm5/vJWWdPuZlzw9KU
         xtyTXwM6CtOcXJaXh37ZjOV50ganA+1rHU7WyTgGQj21F0bAWB/OIfPqiiNRHHuI41Fe
         reOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXiFXYDZVZWR2eh+Ctlbjky8lrbIgr1IG4qDQkWakRyvIr7iwljA3NRddJUJloqiPYvoviYVk1pV12wX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOaC+K2MDhsq8tfIxyD19L9XjuItLtHZxW+eg2zIOCbxaBuvqi
	N/DM8pXrQUZqgsIjGeBre5U9PejNHsRS7BxbHSCz1G/RGyivvrMq96/8tVKfXbeZOME=
X-Gm-Gg: ASbGncvoXv1+w49wajnCXVJOtAk7si5GMEOxuYKCyOmrKUcOC8v5ID9GlhkAVuw9B0k
	jhbZ+eHiC5NdgEryTesJTaB/m1CxBMLoC+vLZBzJ2WrSzpcLZbOwxECVI7VP8fc5iUc/hCH7MUK
	eDtRrskpzuAvtHzSNQIhDHhToy7eyibrtmHGcMf5uJQlbvC6xymgro1pPFlPY5p+0EATtWmXE6/
	gcQ66srRIBXdXHnAtlbW9Em3J3yhu8wOZL4JZGj+dNLHDBe1ks5eR3bpTgo4jcq6UVMhhwL1UFx
	cztXMGiVF3E6U/HCaMp+kXsvCcSYCHeAqEWgrQ28Bpe8IY3cN59ZZXcrMSHtGDjEveLuFqgZuuV
	nVLFt2xlB2/k/sJ9GoD3HFBEkeFhYtBFTcPHNbB8=
X-Google-Smtp-Source: AGHT+IHYI3tcuSfMfYLyvgkgErLnZ1GzeCpm9S3JwFpVHykTzgSrhsFx7MfV7tYp5tXNWutnC3a91w==
X-Received: by 2002:a05:6402:354c:b0:61c:d7e5:47a3 with SMTP id 4fb4d7f45d1cf-61d0d365421mr1981474a12.3.1756552192554;
        Sat, 30 Aug 2025 04:09:52 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc21542asm3285666a12.18.2025.08.30.04.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:09:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Aug 2025 13:09:40 +0200
Subject: [PATCH 3/5] iio: adc: exynos_adc: Drop platform data support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-s3c-cleanup-adc-v1-3-de54dfb1d9ea@linaro.org>
References: <20250830-s3c-cleanup-adc-v1-0-de54dfb1d9ea@linaro.org>
In-Reply-To: <20250830-s3c-cleanup-adc-v1-0-de54dfb1d9ea@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=KjoP2OpIwgvcEU8lQlbyugpaZUrY36rc56GQiCq2XW0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBostv13VGu7FUVwm7lV7kKSuqLAH95o21fWUsyk
 kZGd4D32xyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLLb9QAKCRDBN2bmhouD
 1xCpD/9RsBrZtrfnGAO6kOBtpZf3RsuYS4WozEoGAPOZ/+LUFG7GyY6PHdLh04yO0tyeru9lmnl
 NWiyylXT161JodBZBtmPzVGF03rHBTAOUplPZd5paYxfpJwt8PJb/xHmt+0xSbnapKtKq200hOX
 EUPwCpJQ9D8g6nPMbYUQ6Ens7xPCUMXbhA29e7wK9UBBL0oTOeUZRaBbz4p0phSh1Jm1shYTVXp
 QngUaBT09dvDLQfrg9tGI+JBpDndf89JRLDDK3yQ/Vj813uwCaXSU3NmD0OKS/vtuUyzo/J0OIt
 8vVneJFmFtj4xhz1JdbVUnA8vMsGRMZLf/f0M9GRJHxy7pHzmzW6OUolCzk+CHo3KCQgbOY1coA
 6v46Kib9uoMtvr7Y+3aQb0c+2zWCV24+9ia905h/shhAk8pEhuZun2FPDPiUxSr490p1irdBmt0
 6OCDoUzRL5lkSOt6avOdIL9235r4vBEvl2HvUzT9elT+Z6862INH90abu3DWL6oAm+rk4O2k401
 /PuIEEZckhNUQTxHX/j6Hsvdc+1QQgbLp5dQXn/VfZp8fCYyNy6NE+jvz2674Gdvk0LFg9KbCrn
 v26uvKiam2qS5ejw+6+GF74I/T7rOXWawPDPYNvrAjuXZOsC2O1WHTbgNsWyDAC4U4RJ3YDi9gQ
 EEPu7EfKv7b8Umg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

There are no Samsung Exynos SoC ADC driver users which bind via platform
ID, thus platform data is never set and can be dropped.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/exynos_adc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 30f6d8436e775a8d2177951b436cd45152307ea2..dd1494ee365a7b34d6b485ee4c9e753f50b5ff26 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -106,7 +106,6 @@ struct exynos_adc {
 	struct clk		*clk;
 	struct clk		*sclk;
 	unsigned int		irq;
-	unsigned int		delay;
 	struct regulator	*vdd;
 
 	struct completion	completion;
@@ -213,7 +212,7 @@ static void exynos_adc_v1_init_hw(struct exynos_adc *info)
 	writel(con1, ADC_V1_CON(info->regs));
 
 	/* set touchscreen delay */
-	writel(info->delay, ADC_V1_DLY(info->regs));
+	writel(10000, ADC_V1_DLY(info->regs));
 }
 
 static void exynos_adc_v1_exit_hw(struct exynos_adc *info)
@@ -556,7 +555,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 {
 	struct exynos_adc *info = NULL;
 	struct device_node *np = pdev->dev.of_node;
-	struct s3c2410_ts_mach_info *pdata = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = NULL;
 	int ret;
 	int irq;
@@ -657,11 +655,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (info->data->init_hw)
 		info->data->init_hw(info);
 
-	if (pdata)
-		info->delay = pdata->delay;
-	else
-		info->delay = 10000;
-
 	ret = of_platform_populate(np, exynos_adc_match, NULL, &indio_dev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed adding child nodes\n");

-- 
2.48.1


