Return-Path: <linux-kernel+bounces-784434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0719FB33BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A2A4826E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97B52D640D;
	Mon, 25 Aug 2025 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZpaxidKH"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29B2D4817
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115345; cv=none; b=gLL5O+wgenMMAWAQgj9ukGw38CUp0+Ddbw4LhawwF6BKcHTd+mK7TSEsfN5VDdxD/BVBmLJQfVDA2pHVyUL5xZA1W30V1sEis/1Fn33utn3eeOt4hYZ7xX/6FvT5BEOzdzF/flVe9aQjImhvzimrP5uHgDbMSeutozntcEqnR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115345; c=relaxed/simple;
	bh=JoATGmb5B+qG9j8i++GOB88ySA0sb3+2w5K/6Uoihrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIMufAZ9NXUnjCbVe1d/iFAmfavPah+ywMZ/+KdH/2tNo4QZuOSDcqZZQ1wayOPnwuDXZoYpPEbAVC74UVYjTjG0pm7LdRwfq/K0cG6HPcSYl66OASVwG01bwQBIBp4cAUMAYfKgaaMVoEDjBaumTIPP3g2+CfLoDG86fCVG8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZpaxidKH; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c68ac7e1c4so1096556f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756115341; x=1756720141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JXqL63qeFVdF/I9mGFbork5TN+ZaQ7aCD37gp/UqF0=;
        b=ZpaxidKHuSljwbQkaoS4rxy/mPLpAmHZQ4KCdlyh+vtgGKVNapHPnRl/dFeyRXs/8e
         v4+p3x7jo4lz/ji38hC7ijCBkMX7gisMy2gKJl1X+aSyvUwfpsO4OVmeyI93FGcOSQnK
         NJuyD4k+gecKgLlBis6Zg408BoWKA5FMD9n4gQQRnG6xBTeT5/OYXfoVQOglGbL9Nc7m
         /h19R9snABqTWxM0nIskE86ZNN8lFEKHohA439EMv43JXqYYWtIE3zS+VQWjboY2RPbr
         c1qdzl2dFrbgaUQvmUfAveH+if1sTQQy0GMn3OYHi8AiVXzGHWFExrzfinsBKrX7aY8S
         89mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115341; x=1756720141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JXqL63qeFVdF/I9mGFbork5TN+ZaQ7aCD37gp/UqF0=;
        b=LlyVD2lGEZmWYEkahp4u/e5O+fY9p4rluCc1Xlcozyu4b+gr/8GVpcjVTSkh6k2HWL
         XbS9tSBscUwoLdC94813AwI8P/903fJSi0dXtvQxJx1XrT0Cq02c+Bfo9w/6eG/PTU8J
         lWBff04G1oTB8YGwymVOWRDfb/cTsm00VPUjDo9JZDcI69mG7XpIQBoJiiiMndBVGwKT
         x7QvS5ZXWxlUX92R0YNtmti28VjTup6v4Zaku5rRObB5tDtFHK/jX0oh1yTQWSxeavAt
         2VsbuX1cnQzyEldHzj+T9MNVTZnbDzSuSr1B4muMAYZttHI1PkbT4UnSzdd78h5/xki2
         QUCA==
X-Forwarded-Encrypted: i=1; AJvYcCWVxmZvvNJ5dW4c/O4PK/GydRDeShcs3CzTu//uf0f98COVUl4r4DB5WIetfYGv2jdA9wIPtt0k/FWKAsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkNqXIMSLx4SDXlSyfolzMX8js01zBUwLvCRqE4oE3bMgXyxis
	AhjZDjn2QizFPPOJeknjaG8JDIoQEgM6Yz8A1Ex5w+468MiiwuKxYwvIO9Y7OEh5dyQ=
X-Gm-Gg: ASbGncsVC8X+lW2EYB1TKvn/DKMSj1yMMEFN/SdV4Eu+u2qxYrUDlYvdxV7ReNbD5mj
	m/T7nU6IJMNApwfp32AUu8dB2WIKymyWcWm2OoDISuVwcxV5HSXTdj289ungC/GPryI8on43ID3
	D08PhhgS5+vHqynlN//Z9NZQfR0ZQeN1dZvOh+VShtwt2rK/x5JCVVGh9dx5VCslaFX4Vh7o+G8
	KVAAvuegL4Xbo3YQVL6mK9SQ7A+9ln+NCNIsJeFTRPr5KqCGqh/dxO+vZzjCx/8e9KfBBY21qT2
	XZIhfgb3k1ehk5sTKR07azHN3ks9VGrvDzSk0mzmL/E6wI+a/dvMfBwrnCt2FbYxpsZjCMF0ad3
	P8cruYWBHqxoxRTEoBtAK6sQ/+rJx
X-Google-Smtp-Source: AGHT+IGqQFUyVzUhWNvcRXp/aqVwDzPVihVhyMJEm+AleXvTWHTL72e7MVyfwP+PUw30TkIPXUveHg==
X-Received: by 2002:a05:6000:4308:b0:3c8:443:4053 with SMTP id ffacd0b85a97d-3c804434626mr3718081f8f.1.1756115341323;
        Mon, 25 Aug 2025 02:49:01 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef52:fc8d:34ad:9bfe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711bb1e3asm10877449f8f.57.2025.08.25.02.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:49:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Aug 2025 11:48:51 +0200
Subject: [PATCH RESEND 10/14] gpio: amdpt: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-gpio-mmio-gpio-conv-v1-10-356b4b1d5110@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4007;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=J+TT9XjbJJKbjE77nqgtMEqiO3qZwqcbYA98JKh3zw8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorDF/x4Ui4aJKIzDH0rV5RTC964M761/7Rc/Gu
 oO2Vd9gFnOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaKwxfwAKCRARpy6gFHHX
 cjssEAC2/HEP7ClxN+Z8FxBVvzsXbdSfTrHqx8ubSZGhwCLUqGKdylAim9rPEKUHQQJB/fTrtSk
 egIV2DUIsexkGXJ1mJCvGuBNj/pfGF0RgghPgpVvghNihgUq3kyktUSiakewhKE+/wB9xY/zY5s
 7ejYlAKn3+KSQCUx+QM52LHaAVqmyS+Mh8zKZMniaYendSd22YsR5+8kFl6z/Q7jIV328Cx5k7V
 Jk+CdFJYezEdAqt+VK12+7oekT2rST3kwH+l4Ya3XVwf2KXKayHfYa8iVO336uUAAYVTEkxvOu1
 gaJfg7h9eN4sj8WdyPzUF6aKNsfpConZVaana8Qp8CFJwmm64Gz3H1pVbv9ypJCKAYzbL7MxeTo
 /lx2ztvw/OHEW9W9Gg3nKBJaPKKGLwujx49JiyIspjJkmzRFLpe9YwL3ZKWdXyj6/F2aCtKwzzj
 ySE/0nZ08eBBBWzTv8kmu1NZYGivXV1s+df1EAdJ6W/fYdfNGeV0mdle2jq9/MvVeHT6GhSx601
 IRTeESGbheUdw46N2E6VehPM3kfoz76g0ZJt8CfIBTzqmPCIMSmWi45ihLiWXhbqZsr9UXxWJKs
 mEvYxOpXORIGUWGbrA8P5KTcOQPCdV9rMn5CbM60cbPNHuruPDjzZ6M3AGpet3TGnIWBgKFxvAt
 J1c3T3Q9aDoUaRA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-amdpt.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
index b70036587d9c3f64bb73ed3b94e1c14f249c9e21..0a9b870705b90bdc9bdab93ce5a4a33ebdafccc6 100644
--- a/drivers/gpio/gpio-amdpt.c
+++ b/drivers/gpio/gpio-amdpt.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/spinlock.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
@@ -24,54 +25,50 @@
 #define PT_SYNC_REG        0x28
 
 struct pt_gpio_chip {
-	struct gpio_chip         gc;
+	struct gpio_generic_chip chip;
 	void __iomem             *reg_base;
 };
 
 static int pt_gpio_request(struct gpio_chip *gc, unsigned offset)
 {
+	struct gpio_generic_chip *gen_gc = to_gpio_generic_chip(gc);
 	struct pt_gpio_chip *pt_gpio = gpiochip_get_data(gc);
-	unsigned long flags;
 	u32 using_pins;
 
 	dev_dbg(gc->parent, "pt_gpio_request offset=%x\n", offset);
 
-	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
+	guard(gpio_generic_lock_irqsave)(gen_gc);
 
 	using_pins = readl(pt_gpio->reg_base + PT_SYNC_REG);
 	if (using_pins & BIT(offset)) {
 		dev_warn(gc->parent, "PT GPIO pin %x reconfigured\n",
 			 offset);
-		raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 		return -EINVAL;
 	}
 
 	writel(using_pins | BIT(offset), pt_gpio->reg_base + PT_SYNC_REG);
 
-	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
-
 	return 0;
 }
 
 static void pt_gpio_free(struct gpio_chip *gc, unsigned offset)
 {
+	struct gpio_generic_chip *gen_gc = to_gpio_generic_chip(gc);
 	struct pt_gpio_chip *pt_gpio = gpiochip_get_data(gc);
-	unsigned long flags;
 	u32 using_pins;
 
-	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
+	guard(gpio_generic_lock_irqsave)(gen_gc);
 
 	using_pins = readl(pt_gpio->reg_base + PT_SYNC_REG);
 	using_pins &= ~BIT(offset);
 	writel(using_pins, pt_gpio->reg_base + PT_SYNC_REG);
 
-	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
-
 	dev_dbg(gc->parent, "pt_gpio_free offset=%x\n", offset);
 }
 
 static int pt_gpio_probe(struct platform_device *pdev)
 {
+	struct gpio_generic_chip_config config;
 	struct device *dev = &pdev->dev;
 	struct pt_gpio_chip *pt_gpio;
 	int ret = 0;
@@ -91,22 +88,27 @@ static int pt_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(pt_gpio->reg_base);
 	}
 
-	ret = bgpio_init(&pt_gpio->gc, dev, 4,
-			 pt_gpio->reg_base + PT_INPUTDATA_REG,
-			 pt_gpio->reg_base + PT_OUTPUTDATA_REG, NULL,
-			 pt_gpio->reg_base + PT_DIRECTION_REG, NULL,
-			 BGPIOF_READ_OUTPUT_REG_SET);
+	config = (typeof(config)){
+		.dev = dev,
+		.sz = 4,
+		.dat = pt_gpio->reg_base + PT_INPUTDATA_REG,
+		.set = pt_gpio->reg_base + PT_OUTPUTDATA_REG,
+		.dirout = pt_gpio->reg_base + PT_DIRECTION_REG,
+		.flags = BGPIOF_READ_OUTPUT_REG_SET,
+	};
+
+	ret = gpio_generic_chip_init(&pt_gpio->chip, &config);
 	if (ret) {
-		dev_err(dev, "bgpio_init failed\n");
+		dev_err(dev, "failed to initialize the generic GPIO chip\n");
 		return ret;
 	}
 
-	pt_gpio->gc.owner            = THIS_MODULE;
-	pt_gpio->gc.request          = pt_gpio_request;
-	pt_gpio->gc.free             = pt_gpio_free;
-	pt_gpio->gc.ngpio            = (uintptr_t)device_get_match_data(dev);
+	pt_gpio->chip.gc.owner = THIS_MODULE;
+	pt_gpio->chip.gc.request = pt_gpio_request;
+	pt_gpio->chip.gc.free = pt_gpio_free;
+	pt_gpio->chip.gc.ngpio = (uintptr_t)device_get_match_data(dev);
 
-	ret = devm_gpiochip_add_data(dev, &pt_gpio->gc, pt_gpio);
+	ret = devm_gpiochip_add_data(dev, &pt_gpio->chip.gc, pt_gpio);
 	if (ret) {
 		dev_err(dev, "Failed to register GPIO lib\n");
 		return ret;

-- 
2.48.1


