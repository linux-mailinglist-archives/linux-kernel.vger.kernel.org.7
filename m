Return-Path: <linux-kernel+bounces-809553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0989EB50F08
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB8944542D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1298A30E84F;
	Wed, 10 Sep 2025 07:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WK/Pv1Nm"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF70230DEC1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488398; cv=none; b=TusNn02zhdrEKOOkQN8PWxifzDK1yM/b6Sp7tF+lmYgMHTTyHVXwlW0EI5+TN+xuIzmIuF2EzewVEWDo43moD0z1PBVB4+APNpbPyBxrBHUqvYgRsSq1mX38jAAy+W5d0r8m/+/pc978kwMLQHa74+6HghSYRRF9STPyKv3hwJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488398; c=relaxed/simple;
	bh=t8A6G2KpCermmdZlD9H8szKTjgqpx1Xd7ULAgYLUi6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HgzeLTeXrNH8b0+OmkUB3N2JLMdYfCuAM2Gk2pNtBSna6YHe482KT+8y1ID1A3DNXsgSwbLU4dATiyUr9q72/hJMBZeelBAVpcMKyAYDdug3t6lXof83EmmUBXsJvap64GX044fwLOQpExGsYyv3E4F0x0SPWUdeJCby3Zq8mew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WK/Pv1Nm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so26896305e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757488394; x=1758093194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6c/pvFPyTaB2IKIW4xwQWlTQpyrmNMmH9gU68Ylyi64=;
        b=WK/Pv1NmieQdc7NcMZ4U9O6aiqfl3IZ09L5T+t/2wmLvJ9s1PoS4/jeVyeXQh8V2sr
         bDicoHFYGfsu8JBg305SyRsFj/qVgLI8Jct05Rn1ompaSssMMc/tM+84uxPO1tSMGyOp
         rK1HmPLZOCt/mXutdEmqo1KpGLg1bUCt9gEB6uuFBggayeNT1wLMC3DPMO4qYYLw+fw/
         wuh60TvT9S4CdtdXNLSqeecwwnk9+NLNcvGVme6b7xbc+zR4Vi1fNvzlpXUvEpZS6mK6
         pt1EU+cDXf9J/ZTRwDfENNSIgaRDuAIJVfpaOPnq2K2dDi3amFaNUzLkTpR507cFceRA
         w8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757488394; x=1758093194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6c/pvFPyTaB2IKIW4xwQWlTQpyrmNMmH9gU68Ylyi64=;
        b=iRCUR0OHT4GS1WCKNkWX9RKg5skUCVLL1Vz2+kbiN7/5bdGYV22uY5Crz/vsgHRBl4
         5tS+LISPtKMqWwuRlJlnEWCtiNRnSH1Slzu9p13rzd7bw2o9/tJCKYYDwHEt1wTO9Wth
         TPdKdRLunDlLA6sSINJMkCINbyHYLN/xaPq79vzpSRJg7/VtPLKpMbzBI/zuo9xGrNkj
         X3x/TKDVSkC6QrxiQ2eCKtwZOkI5S9eDQ1rVChO+WSy7PS5k9C1SYJL7F16KsoblsV9k
         +zuWQoHoz5Vd027mRBtkKqDjdn+slO+Ev/10tTu/A5noAnViJmvY/uUl38Yf9R6sxOD+
         NMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH+LrBeA/F+98n4cM/hW+WtOSqtex6B6sGMVCSzDgZpE419KUG1t/V3/niqz3zpzQY9jTqcXRh+sP4GlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD8RT/oSbdWMlGRPuOPqoAdc8DA0Kej6ezz1mkyN3H7odhVqyV
	dnAMMj2OQbKRppbP1gs24DXUXezEbqUF1xMMkk0SdZyh3UOycPeCMXn5Kf2nHA5Em58=
X-Gm-Gg: ASbGncsSOM37VmtDogZniQj8E3lE2cNZXo9Mlpy2wPXdE8FOvyNTJp8QZV4W33kfbXB
	4vB7gM7AHaOyw5vEPw1vbMUgttUPV2fEQgbj1LeCZG3BTr14UTK6ymAlMhu04FQpcHa542d/jHa
	tLaT89mBG/xcSP6+1I8q1XNGEZSZ7R03OKUFP7wjCECg8mFKb5/jDFDiYqvXJlOTEJeWhm3om8T
	aIELg8EWLrF4DD5rDtaoN8YeMtKg20Ogf0SCJnr9fzzY4pxrJyob2S/ByHQxmu88Rccwl1i/yr8
	q9JAW//js/IrxAzqoDBW6tVqv1NmcpaXk0VB65Hod7KlJ+oRRVam6uT+hTWVZdo4/UgV0ul9mUz
	aXsn9uq1KMnPketbWsov+hMBftKU=
X-Google-Smtp-Source: AGHT+IE8/2TOR5e5wBjK6bwnPnGoPFsiXC2aKo6sThqo4Y4RFbUV5dbrmcgYl3+7QyN1qmp1C0uHGQ==
X-Received: by 2002:a05:600c:4ed4:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-45debe22055mr75199565e9.31.1757488394170;
        Wed, 10 Sep 2025 00:13:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3936:709a:82c4:3e38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81d20d2sm16357035e9.8.2025.09.10.00.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 00:13:10 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Sep 2025 09:12:46 +0200
Subject: [PATCH v2 10/15] gpio: menz127: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-gpio-mmio-gpio-conv-part4-v2-10-f3d1a4c57124@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3350;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=2qJwbWHnGxbd4mos2wZZqovvMW1o0Hu1zLY8DCz5XAk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBowSTuC53hX0ok/Q7bV2FUvI7TGC0rpB5vDWeq2
 RyfDFLq142JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaMEk7gAKCRARpy6gFHHX
 clYxEAC3ZY6fYBuRFCcSFDyDskUwOZE2MX3YsufyWILM87g5ZR3/HcyQuHHqj2HQFbM3B2aD4z7
 jETazyJnFEwuK1Zu59qO4JN7NLxyh3p7swxsZUu/xaV+5rChm5DXPX/03l0TLe/OJuAKFrkzr8j
 6NuiO3U9+ljhbhkDSUWl5M2/KiYgR42isjnUCZHWhMzP141dBJBbZRcFqr2tINv4gU1GEaoToBT
 8bkmOtJ7gdezWtPlueZEjvVSpkR2RKQAVDkAACExtQ21X1tfW7Zc0BQBtXZqZqt7FsTDa744Vg3
 +0Zp7WiRMFTYfxEbByqHZShEUpFduKiMbYkzt7NmeRUhUAkmfPThvj0XT7jQWbS/mG8guHkYhCr
 UfQg5zgkbn8fKImUSFJDGis5nQB6LfJ8CybqlZXIHoLKXuG/HNXp4+xCrWu2skxu/9zavbYsFw7
 E3iscHrsHoZVdNbHTykbwgKr7DVBP4ROjyAcp+DVLSnu3hWkINY3udREpTVRHeNH86FfPQ919ou
 I8Gy+JRIXXHqNRWUMbnxsFcA5UU0ZptqQqHZDbck1gSaFtdpdrhJNUX9f2sQHWOs0PbodXHmx4L
 Zf7wbpgGa7xfMSQe7NcXrNOYi9hGxAUu6aCxSUoy+YMY5G5l/S/GmthMZn6ZPoIyy/XkJ6wLWdH
 f7j8pv/nNptmfUQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-menz127.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-menz127.c b/drivers/gpio/gpio-menz127.c
index ebe5da4933bce730c70f83c1c0f86fc4a4cc9906..da2bf9381cc43cd489f6a8593636bbbc95ab5660 100644
--- a/drivers/gpio/gpio-menz127.c
+++ b/drivers/gpio/gpio-menz127.c
@@ -12,6 +12,7 @@
 #include <linux/mcb.h>
 #include <linux/bitops.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 
 #define MEN_Z127_CTRL	0x00
 #define MEN_Z127_PSR	0x04
@@ -30,7 +31,7 @@
 					 (db <= MEN_Z127_DB_MAX_US))
 
 struct men_z127_gpio {
-	struct gpio_chip gc;
+	struct gpio_generic_chip chip;
 	void __iomem *reg_base;
 	struct resource *mem;
 };
@@ -64,7 +65,7 @@ static int men_z127_debounce(struct gpio_chip *gc, unsigned gpio,
 		debounce /= 50;
 	}
 
-	raw_spin_lock(&gc->bgpio_lock);
+	guard(gpio_generic_lock)(&priv->chip);
 
 	db_en = readl(priv->reg_base + MEN_Z127_DBER);
 
@@ -79,8 +80,6 @@ static int men_z127_debounce(struct gpio_chip *gc, unsigned gpio,
 	writel(db_en, priv->reg_base + MEN_Z127_DBER);
 	writel(db_cnt, priv->reg_base + GPIO_TO_DBCNT_REG(gpio));
 
-	raw_spin_unlock(&gc->bgpio_lock);
-
 	return 0;
 }
 
@@ -91,7 +90,8 @@ static int men_z127_set_single_ended(struct gpio_chip *gc,
 	struct men_z127_gpio *priv = gpiochip_get_data(gc);
 	u32 od_en;
 
-	raw_spin_lock(&gc->bgpio_lock);
+	guard(gpio_generic_lock)(&priv->chip);
+
 	od_en = readl(priv->reg_base + MEN_Z127_ODER);
 
 	if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN)
@@ -101,7 +101,6 @@ static int men_z127_set_single_ended(struct gpio_chip *gc,
 		od_en &= ~BIT(offset);
 
 	writel(od_en, priv->reg_base + MEN_Z127_ODER);
-	raw_spin_unlock(&gc->bgpio_lock);
 
 	return 0;
 }
@@ -137,6 +136,7 @@ static void men_z127_release_mem(void *data)
 static int men_z127_probe(struct mcb_device *mdev,
 			  const struct mcb_device_id *id)
 {
+	struct gpio_generic_chip_config config;
 	struct men_z127_gpio *men_z127_gpio;
 	struct device *dev = &mdev->dev;
 	int ret;
@@ -163,18 +163,21 @@ static int men_z127_probe(struct mcb_device *mdev,
 
 	mcb_set_drvdata(mdev, men_z127_gpio);
 
-	ret = bgpio_init(&men_z127_gpio->gc, &mdev->dev, 4,
-			 men_z127_gpio->reg_base + MEN_Z127_PSR,
-			 men_z127_gpio->reg_base + MEN_Z127_CTRL,
-			 NULL,
-			 men_z127_gpio->reg_base + MEN_Z127_GPIODR,
-			 NULL, 0);
+	config = (struct gpio_generic_chip_config) {
+		.dev = &mdev->dev,
+		.sz = 4,
+		.dat = men_z127_gpio->reg_base + MEN_Z127_PSR,
+		.set = men_z127_gpio->reg_base + MEN_Z127_CTRL,
+		.dirout = men_z127_gpio->reg_base + MEN_Z127_GPIODR,
+	};
+
+	ret = gpio_generic_chip_init(&men_z127_gpio->chip, &config);
 	if (ret)
 		return ret;
 
-	men_z127_gpio->gc.set_config = men_z127_set_config;
+	men_z127_gpio->chip.gc.set_config = men_z127_set_config;
 
-	ret = devm_gpiochip_add_data(dev, &men_z127_gpio->gc, men_z127_gpio);
+	ret = devm_gpiochip_add_data(dev, &men_z127_gpio->chip.gc, men_z127_gpio);
 	if (ret)
 		return dev_err_probe(dev, ret,
 			"failed to register MEN 16Z127 GPIO controller");

-- 
2.48.1


