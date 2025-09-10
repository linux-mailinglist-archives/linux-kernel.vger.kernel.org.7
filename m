Return-Path: <linux-kernel+bounces-809556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B9AB50F05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6325D7AC866
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6800030EF85;
	Wed, 10 Sep 2025 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RYvN9EKF"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D272221F39
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488405; cv=none; b=G+sxjXEsrN6T7XpHG2wCpcMq8iUlx5S+QrcsX3nmYv8acGJIWnszRMspwNHrvxkBdEC9IMxqqhQvv9ebvCd1KizCl/htF7GlppNI6efRWtYeybGhxGTTEkgFCvWAxvrbsYk+bTy5dDyKobaCX8ccqaxayt4R00WfHhbxtrZfvrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488405; c=relaxed/simple;
	bh=7r4RWlMJtKrg2TyNvMLgRc4Ce1ks8RTs6lB0GfrlarU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIqMcwKa4M5J3d9Aelnuy6xHlR9Kzb5c1DY5OH5MbKQgKaUT5I9gJsv8YL1aJgZQaqNw1JEuN/dgHJKNRPc0bf0Wi+2H0RsjAmBPsLFHUO11A1S5cyY293K2VivJtcORZpLXCxLW5UfPZdOm3sY9+SG2wVpYT/m1gRv46+BwIMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RYvN9EKF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45de56a042dso21543585e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757488402; x=1758093202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FElNXvbXkDRRQhtrQxdomLw+BBHH7zVlahtdS+KoDiE=;
        b=RYvN9EKFyaAPxhCdQh8jYq7nEmrfp/x6+oe+DzsrHoBX3g8+Kn3gQFeNtVXS3vABRu
         IqD4h+MCnqd2BA2wSFafSEbZy+YRnEQwR1+ekdSd5zsuZPBk/ob5wmPJhhqYYrZb3y2b
         FliNWzeC5LD9E1QZA/MHm8lkxHZBIzVO7B5W/cKiq8rnU71MPIBsbKNEKceIQZhQj1Qv
         ZCMRdyw0gPEo8RbEvBGqZpGLrmjWqZSn3GuzXa/nrB4FowW++cvnaCSrvweIAI1vc+XI
         pVax8WQBA5HwW4rcqp0B925+4l999mMXCQfXVDkZ3v0Q7oafQwDEUbryLfcadFNjK19n
         4Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757488402; x=1758093202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FElNXvbXkDRRQhtrQxdomLw+BBHH7zVlahtdS+KoDiE=;
        b=t9DMFSfo3agDaQtBO4siUuyn1iH0xVknmywN4u1gMAKiD5aq/UQC1gJNorPs/I4qbv
         XwmwUZMCu+C2hquOXwYbtMLoLePTu4rNgEw95VBEzWo5e1RfPGRrYoQdUZRfvu5JwVyQ
         6yMQJhCm0C/BsH9dzD7p2mzQ9J69VgV+aXvrHwioeYNd534XOnSANreBgq2bzYPatVPI
         17klW+7FVcsOOaF1eMErarlSVpsHrQ3a3cGl/PAyBtfOciKBMAFhCqwWmVHSGzDk1fsN
         XKD7Eb8/06FmZXi9x8/571ALldZEDj3GTI2e/F7YxCLgaak2WvDCj7xdKOzGYPldmG31
         nZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm0QNH1gp0Xa5Skrbz3V2kFk1VmvOHNV1ocjluadK3+OEYKqqh9Nh+C4yW0hB29VZThVnDwfKkRQ0NiOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy6v2ozZJCvauCvM7DzsIFY3wmshsQnqLgje8KR66dT9OO9K2a
	U1EaGfhmc6Q4v5lXRrSwDEEfBez+whWdIyzHBOcnmqdi7H0vycR3Z+90CjgLoNwC1Gk=
X-Gm-Gg: ASbGncutHZiZVVucowj5ymyCMILMnMPaRASb6ugZbI4kiG+nZGIYvu7d/e4199dWmTZ
	D1SWLq+jx7ca8rMRMTE6uZaFihCVzEGSE394GYr8+M//fQpgaX4QKncgabWQe7YtmCbfOw0O32X
	dYGf9PQe/9Fat57BxG4S+JPluwLFn5pml7Qsf9anfKjxiTNQAkcNxlG0UwIH6Ay4BojZWQQxXe7
	qsVqNHJfNyrOcyEqJc56aVuMMbUEFMiya/DZxw/hMi1j4NsYnrkUn+anqmZUFZ+/lJYE3QUmHrF
	7CB6k6A92CKmLiiNgqNU9j2jNwd92vqOqR96SrWjPnpPCHlglccgaVGBYiCQX0xbxD8xsh+MKJ0
	sqUQBaQ/jC2PBOiNE52gAPyGIKxc=
X-Google-Smtp-Source: AGHT+IHoepCvPrqffYJQ5UIHKGGHBJc1+/54cYHurrsaTibZhp2uHZLzVTLLB5uNCtxFJZunElj+PQ==
X-Received: by 2002:a05:600c:3b83:b0:45d:e326:96fb with SMTP id 5b1f17b1804b1-45de3269948mr124468195e9.30.1757488401630;
        Wed, 10 Sep 2025 00:13:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3936:709a:82c4:3e38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81d20d2sm16357035e9.8.2025.09.10.00.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 00:13:20 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Sep 2025 09:12:49 +0200
Subject: [PATCH v2 13/15] gpio: sodaville: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-gpio-mmio-gpio-conv-part4-v2-13-f3d1a4c57124@linaro.org>
References: <20250910-gpio-mmio-gpio-conv-part4-v2-0-f3d1a4c57124@linaro.org>
In-Reply-To: <20250910-gpio-mmio-gpio-conv-part4-v2-0-f3d1a4c57124@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Keguang Zhang <keguang.zhang@gmail.com>, Alban Bedel <albeu@free.fr>, 
 Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Samuel Holland <samuel.holland@sifive.com>, Yixun Lan <dlan@gentoo.org>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=7/h5cgPamRvVF+jLNZTPGYwaS32CB4zOrlr7VxAAzjc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBowSTv0yIdz4ll8MitMXBu+6Mc5Otn99oRiDLNN
 Q5yVNcT/N+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaMEk7wAKCRARpy6gFHHX
 cvWgD/4nU8cNVwDl8vk77Q2iyfBijC7A0S12Lla0fUkfGEnyo2aFOkDa7ATtYhvRNDLkgVycGJQ
 AMlaMmKhqg69nCQIHG2IWk40qU4Oof5Bul9lC2RZTsD1rfsccSrVwmUELFjq5ZskpBqtECS42jL
 yraGmhE2TWx5P/GUJxcWPh2owipXA58iir3CMe0xeUaHb4LnDJFCOzf1CAsm83Ay86MNZ5pdEOZ
 lZB3lP7Sv+MDBsn1PIOqFTqhbSUBRUsPSo1k4D13xXHxH+vGLn48ITJkRXUgxJc46q1QZpwIV4W
 x5AzzuRWYJbC+OojV9EKyzxSbTlSr6QemQs1JwukmYlRRv6qJDZ0tG1SoTzf6LsncxZH8ekwHu8
 UTttxkGTzZkQR4PQRWJfqJmDGA+1kJ5/CGDmv2Rm+mw5YTZiZcyvhe72yrVKPHGLAEuVKYgx3hY
 xkqhi3k+mbU5JcW9CB2+XAYfVfCckl0dDQBIXOiOIj6749sikgNH1PI25wigIkqo0Vlg4fVty5L
 hoZS5819zALkHM3NZdAfqgCCcrE3gDfevReAnBMTqeMlyy2Qk+wVmA4qaKXbqDs8n93hX0UgAW5
 4KlBoNsyGTJD9tc6nDzGA9kufi8QQ4TAZAX+u1yBdK2oB2/PCEME4LnoxufI6mKGjMdaqQVCH9c
 Mo4LZ6+Z65z3wag==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sodaville.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-sodaville.c b/drivers/gpio/gpio-sodaville.c
index abd13c79ace09db228e975f93c92e727d3864ef8..37c1338377295fa2995bac98f1ae2db892209602 100644
--- a/drivers/gpio/gpio-sodaville.c
+++ b/drivers/gpio/gpio-sodaville.c
@@ -9,6 +9,7 @@
 
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -39,7 +40,7 @@ struct sdv_gpio_chip_data {
 	void __iomem *gpio_pub_base;
 	struct irq_domain *id;
 	struct irq_chip_generic *gc;
-	struct gpio_chip chip;
+	struct gpio_generic_chip gen_gc;
 };
 
 static int sdv_gpio_pub_set_type(struct irq_data *d, unsigned int type)
@@ -180,6 +181,7 @@ static int sdv_register_irqsupport(struct sdv_gpio_chip_data *sd,
 static int sdv_gpio_probe(struct pci_dev *pdev,
 					const struct pci_device_id *pci_id)
 {
+	struct gpio_generic_chip_config config;
 	struct sdv_gpio_chip_data *sd;
 	int ret;
 	u32 mux_val;
@@ -206,15 +208,21 @@ static int sdv_gpio_probe(struct pci_dev *pdev,
 	if (!ret)
 		writel(mux_val, sd->gpio_pub_base + GPMUXCTL);
 
-	ret = bgpio_init(&sd->chip, &pdev->dev, 4,
-			sd->gpio_pub_base + GPINR, sd->gpio_pub_base + GPOUTR,
-			NULL, sd->gpio_pub_base + GPOER, NULL, 0);
+	config = (struct gpio_generic_chip_config) {
+		.dev = &pdev->dev,
+		.sz = 4,
+		.dat = sd->gpio_pub_base + GPINR,
+		.set = sd->gpio_pub_base + GPOUTR,
+		.dirout = sd->gpio_pub_base + GPOER,
+	};
+
+	ret = gpio_generic_chip_init(&sd->gen_gc, &config);
 	if (ret)
 		return ret;
 
-	sd->chip.ngpio = SDV_NUM_PUB_GPIOS;
+	sd->gen_gc.gc.ngpio = SDV_NUM_PUB_GPIOS;
 
-	ret = devm_gpiochip_add_data(&pdev->dev, &sd->chip, sd);
+	ret = devm_gpiochip_add_data(&pdev->dev, &sd->gen_gc.gc, sd);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "gpiochip_add() failed.\n");
 		return ret;

-- 
2.48.1


