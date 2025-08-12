Return-Path: <linux-kernel+bounces-764727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3132B22689
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6B0620373
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B482EFDA0;
	Tue, 12 Aug 2025 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CBd6aVbg"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510842F3C3E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000786; cv=none; b=n4hRZdQLIzh+P5cBWswwgYEHpbAHuNW+dDhb8CqRmKm7dkp9MmIY3/Lw/ufgbwEcRiQeyhKeN4hXUBHQFSllf+Flkp2M+cG4rf6aJVzx824Zjuschjux7POpFC5zzBpCMmCigzr9cnUK6lZCw/EULgAl9x6TRS9j07bidRa3yXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000786; c=relaxed/simple;
	bh=JoATGmb5B+qG9j8i++GOB88ySA0sb3+2w5K/6Uoihrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PjPqdjexdZAIBIjy1SAKE2cKxa8wGG0T6jLI0oiwSyBA6nIheduTC379sRATZXFR2gDiqmhF9S0Bmx/LWRaX0WANzFkIalJvjxGMFAvXZlLuqL48R3RtarogX3sMsgM8qgm+28QlhiA55qJm6dG0dzBeGu/7poXZ/8SdV05ZB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CBd6aVbg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a0dc77a15so10539025e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755000783; x=1755605583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JXqL63qeFVdF/I9mGFbork5TN+ZaQ7aCD37gp/UqF0=;
        b=CBd6aVbg53If9KIZ0ojgPtLBMy5U9g+hTCsxCGTothzYCUWOD3p5U+skXC3PLoPcXi
         fSdm4/TMQckd/ubPdkYdu0YkqzA8It6Skgg/nuWQz6twXT2oNaM0xuIF6kz/q25ES27X
         jEQ3pJDCRSu7LUPDoxH5uTVLbR8FMdsyH9Ea09i+yBBzVgM1uRTca87a44IDx0U9WBIW
         BH4cQ20UziRlwoY+/G01Jml/Hfam740dHXsGcWs038ZfK8pKLsGeI/5uLS0CbChEroux
         dSIuZvSiWGHq1L0lpJ1hfjNpslo/8cbuFvrh2CNfBXkVunUjo7LkbjtCxj2z61OusqFl
         8UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000783; x=1755605583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JXqL63qeFVdF/I9mGFbork5TN+ZaQ7aCD37gp/UqF0=;
        b=xMu+a/AIZFe0e//jpXsEDzSqYp4A847z7dMOYciUeyut7kGEOZbg5yNYDckAqUP4jG
         FoRMTCKkGQKhmzzj1q1VssvYuEXw8BOocjaTropLLos2V659NsUN+fb93BAK/Br7TAaH
         XjNMRWeg2FooWfMCp6vcqLccQ1SyCBl3iTnSfE/+TnLfJG1BkPQZmP/ND332YUHgPmb9
         fm8Udky2DegLobLVEPq6z9/09nx2Y8ON4K+AZEsUU1gW5fwbvPXgimLpcNg8oBYH75gw
         2jsaIPdaJlcpgAwlXk2ZyG6hbHLE9dG0IhqiVf1PYLsPwy2OYlal2IA7si99GF7x7f+m
         GAKg==
X-Forwarded-Encrypted: i=1; AJvYcCWk2hZ3P6BSLHEuftg8uLOpwy856NYgOlvdmBCCaAX2tLtPe3gEU1QoBisqeIcHbetgk3qo4W5OMuzNMBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydJUPTnotm3U6P2XJ7dQD7scBcWaMNhYpfwL9YQ52FVD0p8a/L
	wr68L+dOBMcd4N4VSuS3r+gXeeC3n1d0UGJO0kFGyASEnjhdOa9d0FO65uzBByUkAcc=
X-Gm-Gg: ASbGncu/lzdAHDFZ+XVZOHFRNukV9hOzlhPYVjcbsGH4w+T+PxXXtDxiWuncaXLCnr4
	7as2utj66QYhlp5fh6ZIW7bu01Np7dh9hysr7QyP/HtvkoHwgs/6nEOijK9L9TrUdTcjuGQYNnf
	GX1gHAJSxZ7M3wIfHgT5nXE2Hs1i0BRhrwQmdR480AKTPARNhQTZOBJRHBhARDXTJe+rHIGeH9b
	QZ9PXWVn1V+NicwUu2nSkJJliJFh9MBn0usat8Mdk4aEVHahoEO4dZb/rpuVlHhglf9FIohLC8A
	RLvEzRt90sGPcCKCE7OS3JPHjruFh8FHsSfccazmWfbIKy2Fkkb6WeIeF+VErBh6M+DzyUjNkGY
	MSpbW9Qmx0gc+Y64=
X-Google-Smtp-Source: AGHT+IFCYSd3Po4+XCgGW5jHPNIoyljuwRSni53VHCwjwdUP7QVtuCEaq249i8u2GW/NoKXFHK/u+w==
X-Received: by 2002:a05:600c:46d1:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45a10c00677mr34160085e9.18.1755000782670;
        Tue, 12 Aug 2025 05:13:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm298878535e9.6.2025.08.12.05.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:13:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 14:12:52 +0200
Subject: [PATCH RESEND 10/14] gpio: amdpt: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-10-aac41d656979@linaro.org>
References: <20250812-gpio-mmio-gpio-conv-v1-0-aac41d656979@linaro.org>
In-Reply-To: <20250812-gpio-mmio-gpio-conv-v1-0-aac41d656979@linaro.org>
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
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomy/BELGF8WeZdyE8Hb//8DlU41prWqZVK+ZHx
 SzPK2xIFM2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsvwQAKCRARpy6gFHHX
 cjErD/9odeqgoWXMsX2plGrfcpj1RQRBtlsnb9eFQkWpAVjcW1hoCl4XAfvVDQmzRV0j8FjesqV
 EV3vPblsndq9BdJoGUSt8PPNWxdGwu8d7tI+RNqqlBpBop0y1tdWa3Ucm9KYYEY8l+CFlReGW3e
 pFPpXTdH4cxSYWrTWxtzS0chesSyWIU63ZOFixhjI2iHsv12Sato+vmcVjXLVZ1Eu0acgjzwxYK
 Wjyz008T6Tch9NfqM9hxx0DHzTPnD+YB1+IiCLjyNiZZ/pO1HeImB5T2ZsX1r6HHJ8TXLMtXroh
 sXsYaprSVJYsPnRYUc5rJfXkHiAAWQVD7DrVxC51JSZRKkOYFxgs4TaV4kc9ojCFjjf6OXSWQ+p
 qnqFsSNrStWXiEdrf36V6em8VFWMdiqGQski900NPGD1RFRf+V+Eof5+d2pkwubi7U1WpLNwnG1
 Gov2a5U8f3chK6lZVsz/E43l1iExRjhH+B7yuSrOKn0iW//hBvI3S7hZ0qmPmoT7qd8TApPS5VI
 R45U0wm+HUY+ADxLILCUZu4nlXSdLkad0hamI6rVOd/jv6nra/pjfkwMaGNvgfgKJCb8Vbyh+24
 4fH+tQSsqzr3dxNjWIpNdEl6Nw6WB4sKyVgXXkUzenkLTxILNHAd+CydMfJa8pW6eZbU8SgLnLb
 +WSik3H2GcYxE9Q==
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


