Return-Path: <linux-kernel+bounces-729114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3196B031F2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE404178765
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431A627FB2A;
	Sun, 13 Jul 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAW4C7oP"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B7827FD40
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752422406; cv=none; b=cnkP4N+yrQefLBuYCxblMGnfWy38256zN2hlsxy/sFDHMpwEe1AqtkOPhKlYfoGgIwUhcdtVau2sCf0iIKYCrmBWCkJ9qTUtCGXHUZb9/QXgZbqXkWOzpTGMzsKYxAQgcwPiwnRonbgfo8t4KndfSkflXmmMJ6LbSRh+WL/zvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752422406; c=relaxed/simple;
	bh=uVps96x+owl/k/QEQGecdlA9EabWOuhbfKNHVC9O1UM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NCapL93ijrAmYOzhIGTPVsevP6CBFl8r+NEu+7ljJEvjVVGiYF+izDHO1uAG3+bf0GuJOOF+capvIa25UQ9Lp+h+63Sh61tE9I2Ph2HIX1bmpn5aBquYK318BZd7gYJ9YSSK5ef/3iCa6hWEItbwPWNpz+iPpavHhoi23JZeG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DAW4C7oP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-456133b8d47so524255e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752422403; x=1753027203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2z3Hm8MWtD6dyPG2UFKQINb5SAxLFMt52qkT1qEFYCg=;
        b=DAW4C7oPWq2BEuVQlRXqswb4qi0I1SLfnmZFilJQ/t33BJu7wzRWTk6Jd9aOavLBdd
         moTKhgCS+PV7/d8rZMRR1SIn91pMnx5SThOZ28XRZjh33dTx9MRgnWbWCRwhwZLWvs7l
         FrZNW/+XeekXQEMnVdXwE5hvBymEQnb1DtQ51v8mMg5LsK3ixZBYmu7dh6r3gTnizuo9
         XLm/WUIXFt3Vfer+hufGJSgbi9NyS7SbWocGlwPqBNsfZnLUTIOUq9GN3XAHDPz6zYDK
         mFSEWP4RsnqjSWgL8o+PpIKRkxrANv6l4CHqLHS7Pdff63pviwMboqeTm/c83IwCaZBp
         /VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752422403; x=1753027203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2z3Hm8MWtD6dyPG2UFKQINb5SAxLFMt52qkT1qEFYCg=;
        b=t7PI3fmjUozc2W+KXWdy3xG99eWcKHP7O2TQozwanrGmDkBR2l35sg/1vzjAvszkvO
         3u3TxVtWww+drkL08YU3Zcqpllmf70ikuq0aWE7lU3RgCWn2fzXRuCAPq2rdNR52Fcl7
         6rN/VySadVoa0ISi7LjVOaE/Iung/AVDW0XUZmXMf9rew799xnEZXEwG0AiocMOjQuyJ
         jTN2w9zYID6zExCeJEf2jqpMOOh6TuhP1g66Gv36qL6x5pn+cQ7fOQm2dJE37197EtLF
         K5Q8stLNpxtvelFvyhijHWgALRMkSphKf+ny9RDCj0u1i90uF0DR1iYa4LaOCDDMuL1J
         AHPg==
X-Forwarded-Encrypted: i=1; AJvYcCXDmy++R3FSE70E6ZoDkQTRsTouXxeSWf4nTTbfITxXOGFDEpeuvBSDDFNMJliLKrr0HFKqFuDbvr00Ry8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgMPPZz3cB3qpqnhE5H5Tw5A1a7cywHribHOQEqdzJcMDt5xO
	7eD5zn7jcbB6gftEKJve5i2LX1D1scnphmL9Fg4lagq9FaUjNzAyxojv0e/ds0yYqy4=
X-Gm-Gg: ASbGncsPwlftoneF7yXU9aZerIO/IpsaMeNFei7fyA0gy8HJHbhkfZn3U76Fogof1Jj
	zWQTMGLs6LWjC67JcIQoUE0M2Rcjw2Jj87j+CI+B/h87w2TzZbqqUvfiLHNfWqjZfA5RqLecHZ2
	56KxBFSEHb6WeS1VxzRiUgZAOwwbBxkHFnBYyds5coNyhUfHHL91QWdhIBxYfwVpftj8deOMnya
	eZGuOXMSoBleS1k/Z75+7hz6ShVbajCkh/R0iCHrZCcK19+MhMN3FwCrRmENsNf6KzuaFdm/b4+
	HF6Mh+QbwcSWqNkjEyjSOPhTGlomqsx13P11yYBeGgUT7EV8f/ltwfxJ89PeojuJDNog3wnzrt7
	/34J/s62RUdLL/RV82nHcNzp+YSg9wyle70IR
X-Google-Smtp-Source: AGHT+IG8rNvGIbz7zPQ7M9GshMhyyoX5JtNGscCJWwQHvOhgoqHwi4JHZ7I4oUVNE+n49V4zjOOFvg==
X-Received: by 2002:a05:6000:1787:b0:3a5:2d42:aa1e with SMTP id ffacd0b85a97d-3b5f2e773dcmr3163576f8f.15.1752422402860;
        Sun, 13 Jul 2025 09:00:02 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc23cfsm10244123f8f.37.2025.07.13.09.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 09:00:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 13 Jul 2025 17:59:55 +0200
Subject: [PATCH 1/4] iio: adc: ti-adc12138: Simplify with
 devm_clk_get_enabled()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-iio-clk-get-enabled-v1-1-70abc1f9ce6c@linaro.org>
References: <20250713-iio-clk-get-enabled-v1-0-70abc1f9ce6c@linaro.org>
In-Reply-To: <20250713-iio-clk-get-enabled-v1-0-70abc1f9ce6c@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3513;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=uVps96x+owl/k/QEQGecdlA9EabWOuhbfKNHVC9O1UM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoc9f8b4/sA131XgYnDZE1pSb7s14GlZGX2q14+
 naJlxiIkP2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHPX/AAKCRDBN2bmhouD
 1/nCD/9uQ2t8qPVIqwnsINsnxB8jR5nkNLA7zroD5rVIYgMH6C8FTTKGGSeIsQglcLpzOgO43UO
 Wc69pR5MYEPGUX3LW4Rwqt5o0xK6RRo2I+jPLcosdQUxVToJpohK0Fw9XAymTAwMc9rO03JqBt3
 EE+KJXFUL0kJdM8sxN6W9xTa9f1ZXkJPJRbjkX4Vmygai+F8E4RdsArZvq6RDsYlKaVEPx4+l/d
 V27SmLoIDXxqlShaKtCifv0oNS1ZNE3dkGE+au+YIhqz1at0k7HUo08jJe6AQX75w6V833eXMmw
 E5KHybtTTMEDpgynSRAKJmMiOVpqeKSf5OeKo2k0lAuJorAUFeMcblwYhP/zTKwwHm1YJsXWoJW
 Js4Xs3zoGQ6mt5SB8fxsOtut6P90kTJRSfLZQHKtMTGqXTlSJ2cfhhMVeXWk4C/KKujgzUkAZjW
 88pXr0tkjHgJilzZmo0d1ToeO3YMPR6im/4NPEnvnqEKusuXrwYB/crcpQ+u1gLYpAerXjzqZAF
 T2IKzugmF+GRZMwrEy+Z/wyW5lcvyg3YiCQtXmMTnX/+57J99hBfD865CDh9ymZXlAplkKiDkAo
 YcK0cG75Hp8HygMxScrHf0qesKeU3elHq0OCfGJZOfb+toQywmiqgtcgDCbMrNQwZR8NWWEMNMK
 LtsJApPcf+V2HNQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver is getting clock and almost immediately enabling it, with the
devm_request_irq() as the only relevant code executed between, thus the
probe path and cleanups can be simplified with devm_clk_get_enabled().

Move devm_request_irq() earlier, so the interrupt handler will be
registered before clock is enabled.  This might be important in case
regulator supplies are enabled by other device driver and this device
raises interrupt immediately after clock sarts ticking.

The change does not reverse cleanup paths - first regulator will be
disabled, then clock and finally interrupt handler freed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware.
---
 drivers/iio/adc/ti-adc12138.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
index 9dc465a10ffc8d9f596e34215af685999235d690..e5ec4b073daae33d0e51cf21a3520f0ab2184828 100644
--- a/drivers/iio/adc/ti-adc12138.c
+++ b/drivers/iio/adc/ti-adc12138.c
@@ -38,15 +38,13 @@ enum {
 struct adc12138 {
 	struct spi_device *spi;
 	unsigned int id;
-	/* conversion clock */
-	struct clk *cclk;
 	/* positive analog voltage reference */
 	struct regulator *vref_p;
 	/* negative analog voltage reference */
 	struct regulator *vref_n;
 	struct mutex lock;
 	struct completion complete;
-	/* The number of cclk periods for the S/H's acquisition time */
+	/* The number of conversion clock periods for the S/H's acquisition time */
 	unsigned int acquisition_time;
 	/*
 	 * Maximum size needed: 16x 2 bytes ADC data + 8 bytes timestamp.
@@ -400,6 +398,7 @@ static int adc12138_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct adc12138 *adc;
+	struct clk *cclk;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
@@ -435,9 +434,14 @@ static int adc12138_probe(struct spi_device *spi)
 	if (ret)
 		adc->acquisition_time = 10;
 
-	adc->cclk = devm_clk_get(&spi->dev, NULL);
-	if (IS_ERR(adc->cclk))
-		return PTR_ERR(adc->cclk);
+	ret = devm_request_irq(&spi->dev, spi->irq, adc12138_eoc_handler,
+			       IRQF_TRIGGER_RISING, indio_dev->name, indio_dev);
+	if (ret)
+		return ret;
+
+	cclk = devm_clk_get_enabled(&spi->dev, NULL);
+	if (IS_ERR(cclk))
+		return PTR_ERR(cclk);
 
 	adc->vref_p = devm_regulator_get(&spi->dev, "vref-p");
 	if (IS_ERR(adc->vref_p))
@@ -454,18 +458,9 @@ static int adc12138_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	ret = devm_request_irq(&spi->dev, spi->irq, adc12138_eoc_handler,
-			       IRQF_TRIGGER_RISING, indio_dev->name, indio_dev);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(adc->cclk);
-	if (ret)
-		return ret;
-
 	ret = regulator_enable(adc->vref_p);
 	if (ret)
-		goto err_clk_disable;
+		return ret;
 
 	if (!IS_ERR(adc->vref_n)) {
 		ret = regulator_enable(adc->vref_n);
@@ -496,8 +491,6 @@ static int adc12138_probe(struct spi_device *spi)
 		regulator_disable(adc->vref_n);
 err_vref_p_disable:
 	regulator_disable(adc->vref_p);
-err_clk_disable:
-	clk_disable_unprepare(adc->cclk);
 
 	return ret;
 }
@@ -512,7 +505,6 @@ static void adc12138_remove(struct spi_device *spi)
 	if (!IS_ERR(adc->vref_n))
 		regulator_disable(adc->vref_n);
 	regulator_disable(adc->vref_p);
-	clk_disable_unprepare(adc->cclk);
 }
 
 static const struct of_device_id adc12138_dt_ids[] = {

-- 
2.43.0


