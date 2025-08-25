Return-Path: <linux-kernel+bounces-784435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084B1B33BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDF12043AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81B82D6E49;
	Mon, 25 Aug 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uSoeqAPF"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303552D1303
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115346; cv=none; b=C6rB5qo2qa2pf2Wts89lHuanRnha9vBNR4wKKRoyEjVrGvogM21VP7WGwZEjs+P/Q5oYYYWX4WKKp5EQs+JjTjZNFy9mfBnvh9mPYWBkZm4aCbkOX6zFaEJwNxjmTmwHp4KEtSvS4NBgixESYvVHV44SLbvvz6+6aEhDEF5Vndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115346; c=relaxed/simple;
	bh=VZmT1mzJTnKz0ta2wfMvmpvQ/Njol7qiw7Xdu0aEovM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2stMrjF/XBqQchcybiXHhRSUImIWSvtDekiiausgBrchfvytizP0bMVSVA4dTsS0KxFCD+ZDnm4q26ulCbH5c8AjLPTG/1oK/OjdZTdoS2MKgvdmh4YxknDUXpaL/48dx9gkB8uQPpSSuNp8H/0dvhWK8KOPDDHdkhWXuPGqmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uSoeqAPF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c380aa1ad0so2025646f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756115342; x=1756720142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPrnuMVElbf0OVxOMvlRbagakQrZQomsS4SPCky3lf8=;
        b=uSoeqAPFWM1xx9+2xp8yPyV6oLVjrAddw/JW7fR9gHsJ4wRtu2vEJwWRNFB1KsEDRT
         WRZYxn77bAyk7VCSGCoWo2AsGxZwjupnoQQPjWZSKqjQZNiEVKvLVKHtnDluwQOoXx38
         LAp8Fajm0pIGnBj7DW/n+/vVvPHx4qXbUHR9MZu8BiEc+jNaZRg2p/gNuZDy8Udnq4D8
         6Thnt4k84QqJsTeFsjlzS2RBGI8881A+rlCeMOZneOWm3OAVAF6pyCQ5BauAciyOiJLN
         Bi7p0PnnJeh9NM5svfNrZxJDGuXd5vhvce653hsIFxI7t7z6EyfbafxSa/i8bUAxW0RG
         GjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115342; x=1756720142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPrnuMVElbf0OVxOMvlRbagakQrZQomsS4SPCky3lf8=;
        b=hq0pnPBq9cNnwpm2SbNYV++KuV5uPmxNBGV44ZY9IzEk2jbVZ2g7OqkFHpdRCW0Q9J
         J+eKEHUIHP+8YT5By7AdEIy4Ehv2lX9fodb5nVfB7L+9Km9+aDePA+siF7rtEf9psF5+
         6scsHKx5SAoHF+kGuvjipAgsVUx7XbrfCyc4v9kttCFJ2u4f8kj/xcdGmDwmumcRVFYc
         uQyNkJPc7xQpEGdvHOSJ2N0DOGVPb3qLMCi/ceaUCefHKgqlRag6ppzn0PuShxgYyTUL
         L8gIqepwkWPnFLlt9kFvhacCDDMkvxoSnHaAg9YdLvlp/L+85h8f4lV6uGojcjv4hQ70
         dj4w==
X-Forwarded-Encrypted: i=1; AJvYcCWVgKN305D2LIH8zBmEwS2VtNQjbZZkY5ueC/eXbowAgphQymvoyHpzySnBqegxxgpTbWIuGR+ZdfRiOHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6ep6ZwErVo+SyfiPZE8LyWRLqhxoKWOkNASilBuN0sAxAtM2
	E7mLilu+0nS0J+gnh0IJexbUyrQ0coNrIRSbeb/Tpst1yP26GkDW0fgzcELTi+UmPgw=
X-Gm-Gg: ASbGncuQTd6aQE76AwFxQNOMIGd6hU7cELxSz/EyaMovpc3Dvp54ULcnm8lXTjkm0Vl
	dpHUPeeJehBhHSg4jLlnmIE4B8R7rBU61oFNkDvPj0JeFybxAWzxG4UpfE7L2BK+uzMTWvzLs1x
	dMhJaqnlBY652ZqZP/KEuZXOCYuw6MCWmwiCbOzxGdKFSyGhYRl0yeqtl0HUBcEGnPIWC4lPCwj
	Wqj95xHf+7oYV3j2d67UBpXvYT/VlLpEAbyNwmOAWc8AGsooLUVu+UnXqiIS5jTyGiWN14JLp/f
	CfaRKj2YP0w4s66O3eJC97ZfYV/COtvWc5f9Ypn4EYHZKQCaauH3+1jU4zz2cVaINsffo/NEhWN
	N8hX5zbX/w8NhQqw6q1Tl5DzzGyu6
X-Google-Smtp-Source: AGHT+IFjgey1nCIviQTiPa1PzQ/EHonjOfKoB/cv7f8o1CADReniSO0YUmXyqIETzZ5nTpWlT0Jdcw==
X-Received: by 2002:a5d:5f81:0:b0:3b8:f2f2:e417 with SMTP id ffacd0b85a97d-3c5dcdfc643mr8781837f8f.51.1756115342395;
        Mon, 25 Aug 2025 02:49:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef52:fc8d:34ad:9bfe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711bb1e3asm10877449f8f.57.2025.08.25.02.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:49:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Aug 2025 11:48:52 +0200
Subject: [PATCH RESEND 11/14] gpio: rda: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-gpio-mmio-gpio-conv-v1-11-356b4b1d5110@linaro.org>
References: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
In-Reply-To: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2916;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=VEKDyVTn7CdAc/qOsHjVELR8QjmrXUmK9abPLIIpync=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorDF/jKamudiWZeik6VJ09Xx/iCNsa+hN9IVns
 kkGZw2lPySJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaKwxfwAKCRARpy6gFHHX
 ck5ZEADI5Vf5PU/5cpxG04FkHdFGw+RZmg5X8m+J/hOxMzbMW/iLAflxzkvfGG99nUmCRaXb3/K
 s4Lh95pT29u2GXQmTtbBDEe+GLI/8kYLPkP/M7ihXlIMl/sck1TYC2+zeiaxLCDr8knUZoqJJcA
 CAmwq/244Fm2XAPjxTfScQo8FAqc0kH9x+/KQKxcXx9JO4i03ttbT6PTpf9QI4BQi3neUvE1A20
 dxGk37C11FbihhBm5+9lLY12x0zIvZut+nMLEpuz5V3gYlPKda+Vd36VGvh8Gl/mw2JpqDfBJB+
 GC2vYqAoTeDyBlN3DpgO64GzmL/f5lVIZbspk3xFXDeo27d9SDDPVdcnN+kVACVhGAxkKM8FIqi
 r+pFSNqqPrCnsgmKlksdOW0y4iLuEGT+ELXLry3dB+Bx8dxz7BXlTXx7CvZO8YRRnOpL7EFYSZP
 5iBVm+Esr1+4ArdG/VB1Sx3MXoJXYCyg0lyEZVNGNhvJooLqhQNbLkNT8CF3XhJwoXVQ73fPsoI
 Kzm5ddFBOvovxO4DHfn2JQfL7no0OZU/wP6FGS6/7XEszAI7j73VXwvvV0ob1iyhv1lYzzZR7+7
 xlpxZLbmzIFqlfkwBigT0D8RYQ8SsIiVXyO/dSzJHEKeEW8YxCVyU3eYmKYGnMMP3eooLetpb49
 NCUph8Bx1R7VpNg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-rda.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
index cb2f63eee2aa10a2708ec91dfd610ed1ea76917d..bcd85a2237a532b875df9470d972ac88b95a91cc 100644
--- a/drivers/gpio/gpio-rda.c
+++ b/drivers/gpio/gpio-rda.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitops.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -35,7 +36,7 @@
 #define RDA_GPIO_BANK_NR	32
 
 struct rda_gpio {
-	struct gpio_chip chip;
+	struct gpio_generic_chip chip;
 	void __iomem *base;
 	spinlock_t lock;
 	int irq;
@@ -208,6 +209,7 @@ static const struct irq_chip rda_gpio_irq_chip = {
 
 static int rda_gpio_probe(struct platform_device *pdev)
 {
+	struct gpio_generic_chip_config config;
 	struct device *dev = &pdev->dev;
 	struct gpio_irq_chip *girq;
 	struct rda_gpio *rda_gpio;
@@ -235,24 +237,29 @@ static int rda_gpio_probe(struct platform_device *pdev)
 
 	spin_lock_init(&rda_gpio->lock);
 
-	ret = bgpio_init(&rda_gpio->chip, dev, 4,
-			 rda_gpio->base + RDA_GPIO_VAL,
-			 rda_gpio->base + RDA_GPIO_SET,
-			 rda_gpio->base + RDA_GPIO_CLR,
-			 rda_gpio->base + RDA_GPIO_OEN_SET_OUT,
-			 rda_gpio->base + RDA_GPIO_OEN_SET_IN,
-			 BGPIOF_READ_OUTPUT_REG_SET);
+	config = (typeof(config)){
+		.dev = dev,
+		.sz = 4,
+		.dat = rda_gpio->base + RDA_GPIO_VAL,
+		.set = rda_gpio->base + RDA_GPIO_SET,
+		.clr = rda_gpio->base + RDA_GPIO_CLR,
+		.dirout = rda_gpio->base + RDA_GPIO_OEN_SET_OUT,
+		.dirin = rda_gpio->base + RDA_GPIO_OEN_SET_IN,
+		.flags = BGPIOF_READ_OUTPUT_REG_SET,
+	};
+
+	ret = gpio_generic_chip_init(&rda_gpio->chip, &config);
 	if (ret) {
-		dev_err(dev, "bgpio_init failed\n");
+		dev_err(dev, "failed to initialize the generic GPIO chip\n");
 		return ret;
 	}
 
-	rda_gpio->chip.label = dev_name(dev);
-	rda_gpio->chip.ngpio = ngpios;
-	rda_gpio->chip.base = -1;
+	rda_gpio->chip.gc.label = dev_name(dev);
+	rda_gpio->chip.gc.ngpio = ngpios;
+	rda_gpio->chip.gc.base = -1;
 
 	if (rda_gpio->irq >= 0) {
-		girq = &rda_gpio->chip.irq;
+		girq = &rda_gpio->chip.gc.irq;
 		gpio_irq_chip_set_chip(girq, &rda_gpio_irq_chip);
 		girq->handler = handle_bad_irq;
 		girq->default_type = IRQ_TYPE_NONE;
@@ -269,7 +276,7 @@ static int rda_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rda_gpio);
 
-	return devm_gpiochip_add_data(dev, &rda_gpio->chip, rda_gpio);
+	return devm_gpiochip_add_data(dev, &rda_gpio->chip.gc, rda_gpio);
 }
 
 static const struct of_device_id rda_gpio_of_match[] = {

-- 
2.48.1


