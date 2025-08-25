Return-Path: <linux-kernel+bounces-784431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB33B33BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F19B3B19EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB7D2D47FA;
	Mon, 25 Aug 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zwMW1qVF"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603972D372E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115341; cv=none; b=GPNu3SRjYJWLtTkfr3C30C1GNDk3ZJwYiNM79UbWRzrZhNT35BHVSHLTM29Hbq7P0FsbV+82sdOK/lDjLC4/8G4xxeY5TO4ZTzRL5d7qre9iTBzCJwlpHczX9GXZDB/3TmsnPJ1SbvUc2h/UHMqfEBLtHIQIwS69K1aUG5oSQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115341; c=relaxed/simple;
	bh=SYiQSK9Yx+cBGLCJfpD8TWgHeSTe3Ypi2zryPKR/RRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ui3XtVoCYhHrho4pHmwr8Qk00EvJXgt9/dPdPQmHxM98WOzUoVHfsv7Xez/FmWoSRqtW5KlGLSN5DcSE3tP1NQAQaweWXiy52rw5Uy1dL/nfgUz2Apy3BIvIwfPhLBsYshK4rjIedcEAD/SgX6J5F2CuvltBJaa7W/L1//R2Nkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zwMW1qVF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b4d8921f2so29531865e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756115338; x=1756720138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2pDGvu2eB22QFjf1je4Uit6bFjIzrUYVwBKgpkRJ98=;
        b=zwMW1qVFjKkgAp3jYbUGSAkV1dShcv8AN6HbAtanTQL4Bah7C//Imu7DalhgF4TMUl
         9KcJRnAo0Ja6JbXUXOuOm3QPtwssvELGRXDqiNj3kjOI9mWxlL7SoeLjrNXRWg8jSNJ0
         HXhj6r3XVeetDn4SVda9HvCuzPUbZROyV4i1w4Fv0hseN4ewrwV4Gy1hAU0IL6Fj663C
         hTIummAkEqGw4CzYf0OO0rXRZaoOjXMmHCOFCpUqFc636+QqJuLsB83Cjy2+al+TzjqC
         wXNWBjEALHFgq1l2WIDqmFTawtyFwbhLGdZ50S4n/S8wfCMQRUyO0Q1pskrh6HtTlTK9
         kGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115338; x=1756720138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2pDGvu2eB22QFjf1je4Uit6bFjIzrUYVwBKgpkRJ98=;
        b=DYsr99qknPI0jqy4u76cbhYJKLYA6TwcGEz8Xh5agVAAzta960aQJ2wCr6o5bQ9T3n
         cJdpuKJBMOf7LKefl6wmu02l7B1K1P2xQwwn0Y6/SyCo9NdixkVrano9UHa5t5kxpeHR
         ndVhyTQFY+3xNpUWJycUPB/Zau1ie37IGG+uSsNVQ4+Ch8qwaXwf62Ls+DL4u5qoPWCE
         p1GAn24PQDDBHtBKLy633YbWANMXvzNkGcX5YPFhy1rq6X/MoSvvKr6ZVGiQE5FGJyMR
         fBiPPb6to1+DNYV+i74sLW6tlfxIvPoCx1vlkSUD2QDtarWW6FpVw+o7e7HAd2+7upHb
         Rbpg==
X-Forwarded-Encrypted: i=1; AJvYcCXZaVm8rlajyMPwBEMVs0V31Elza4T1rUmuvfh1iMFDhzR5pT7YAM/kRsqkeEaOwmCqWRnTWDY2Kx50Fn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjbb3jr6KIP0LbXesr2Hjywz2Qt227MfNZ4xkv110iGwbnhhs5
	sSXvn5vhhKGEv7Oi+59TVt9m/zwmJFoz+BzkwUAuTCJT51Bn9VQ7IGM2KiSX4dgKc+o=
X-Gm-Gg: ASbGncsTXJACa3h3SliY2IifrgEUC4rNSbHNeyZGQaj4EJG4NQHNPY3iizrsvd7Bl7k
	ksLLRAzbHAZtWTkdkZ5xrgT3dzIyes0p8p8s/cn41xrPbE4OneO7iCHG1O01XN1XgaP7o7tddmN
	o2fSS9E/ZQ9VIXheby25F9iDFpwoDdotJiqWAbjctDsrrzczX4sitmz4cChVL81hwiVYMl9hHz8
	bor4tXFt0CVnnILxILpv3ntgrQTtfj7CkIs+MA4/P5uFgP1Dq/l4PlSG+oSLutbi9kfSAutHsy3
	mYCUgVWDvzWZIFGxbDVtMjuxPUmm04RFtAB+iPrR/VKLuU55p8MNupk7DqoqJFfIUCW9AGBlPux
	GOUeyDztmub344SSRENoqdlXHQPB7
X-Google-Smtp-Source: AGHT+IFYJoaiYNhbtO6y78gQmvYykaingiZAuZhD/t0MWXbkvRMK3wLcbpn1m/B1NP197mhw7oFTRw==
X-Received: by 2002:a05:600c:3b95:b0:456:1d93:4365 with SMTP id 5b1f17b1804b1-45b5179f29cmr95803915e9.5.1756115337600;
        Mon, 25 Aug 2025 02:48:57 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef52:fc8d:34ad:9bfe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711bb1e3asm10877449f8f.57.2025.08.25.02.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:48:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Aug 2025 11:48:48 +0200
Subject: [PATCH RESEND 07/14] gpio: ts4800: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-gpio-mmio-gpio-conv-v1-7-356b4b1d5110@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2141;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=zakPacry7z23T70PXyuXPcLNJS53LcxlBowKWXzkU5o=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorDF+ExP6IhLOXMDPJawqEBFW9tKJ6dklXZLv6
 cu2Zbe9FoeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaKwxfgAKCRARpy6gFHHX
 ch3CD/90F4v0Q6F/uhejHJ1+b0K1bJg4j7+1Tcd4v/iFvHZLr6mGNfTQH1PHn5Z8P1jIqd3phc4
 /UIz1Z+Ah3EA8xKtwC2EgOLftASv0a3vfm8iduaZbnE2Cuo3V5ZCxMHKUJZm8lFAJeJBiOQbopu
 VDQHeX/KeJCLdrxfAzWjkGWNxUYIhdBTWimdYJZHDB4Jh0/AQebrakt6W95euQBn7RZUVydrWDr
 kEjcSWmDN8mqOFvEAD63+8nTe9dNL7KYFb8I2fPOb30w54jSmsaWnvjenNH6T2QyygioJtlYoa+
 zjDadKTpvOQxZ7g3Qlynab/3Oz0xn7tjbCgBigbcrKpV8sxNb94jSY/v5sqWh8q7KzY3MQHIjoT
 zcu6aamlj7SiqZol3sbS5lkPDDJCsLbheNx1/WGVCJbWm/IqfGhCnuAQlyYkGKlSmWzOiRwAT4x
 R8yCMC5M5yDN18uSIkf8X/JWGGNYXdG4m9FOlgBRSY5UBEMUOPAXna7v5kzUI6ka3sQtVfsOuyh
 CxiYTwhFYSLqPMiAhL62V3C8goiwjgQHeotliIuqHI26I0aY21xH361tbM7oPZz3D2OGhuC0MvU
 Px08jtlpsCcSxAtXP911LqBRRej+2smyRWbkrgB7eSZlKKJJFYwCquII9576lMq7bPE/NOFis6o
 +jC3TdEyLqFO1HA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ts4800.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
index cb3eeeb1e9df9aa687e880b16f8d0a31b04a3b07..844347945e8e71fa0f456be0ba8de7217f6760a3 100644
--- a/drivers/gpio/gpio-ts4800.c
+++ b/drivers/gpio/gpio-ts4800.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -17,13 +18,14 @@
 
 static int ts4800_gpio_probe(struct platform_device *pdev)
 {
+	struct gpio_generic_chip_config config;
 	struct device *dev = &pdev->dev;
-	struct gpio_chip *chip;
+	struct gpio_generic_chip *chip;
 	void __iomem *base_addr;
 	int retval;
 	u32 ngpios;
 
-	chip = devm_kzalloc(&pdev->dev, sizeof(struct gpio_chip), GFP_KERNEL);
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
@@ -37,15 +39,22 @@ static int ts4800_gpio_probe(struct platform_device *pdev)
 	else if (retval)
 		return retval;
 
-	retval = bgpio_init(chip, &pdev->dev, 2, base_addr + INPUT_REG_OFFSET,
-			    base_addr + OUTPUT_REG_OFFSET, NULL,
-			    base_addr + DIRECTION_REG_OFFSET, NULL, 0);
+	config = (typeof(config)){
+		.dev = dev,
+		.sz = 2,
+		.dat = base_addr + INPUT_REG_OFFSET,
+		.set = base_addr + OUTPUT_REG_OFFSET,
+		.dirout = base_addr + DIRECTION_REG_OFFSET,
+	};
+
+	retval = gpio_generic_chip_init(chip, &config);
 	if (retval)
-		return dev_err_probe(dev, retval, "bgpio_init failed\n");
+		return dev_err_probe(dev, retval,
+				     "failed to initialize the generic GPIO chip\n");
 
-	chip->ngpio = ngpios;
+	chip->gc.ngpio = ngpios;
 
-	return devm_gpiochip_add_data(&pdev->dev, chip, NULL);
+	return devm_gpiochip_add_data(dev, &chip->gc, NULL);
 }
 
 static const struct of_device_id ts4800_gpio_of_match[] = {

-- 
2.48.1


