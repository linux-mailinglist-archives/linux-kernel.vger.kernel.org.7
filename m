Return-Path: <linux-kernel+bounces-784439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 360C6B33BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A013B16D31C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80232D7DED;
	Mon, 25 Aug 2025 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NreOSR1M"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736F2D6E67
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115349; cv=none; b=hhYUbwysIa0F5YWTsjpSBOY1sR2ZT8b4UvAdbUk/P7NrkELSCngYD2mJsy5va78b7datWczribgGa872ZASjURd8gcfhmmQAiMJn0zcETuGqb665M7kpQF7Yuqno8Y+929JROaYtC9JhKhOQQ/vOL7mvT3zzvJpgfC96PpxEQnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115349; c=relaxed/simple;
	bh=f3XDHr8xYS2BjL20qDCCzhyytv+tnz4ZBdR/dqLusIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6n/I2JqeHtkGsGmpP27QdPb9c0xl6e5ihHmJ5pwAeajEfvcVjB58Cn8fzPknhlwdlmLmIYkd4w1vBxWOPStlT0Ua/tLH0mhXUd5Ka92UzLvNkSQn5i9DC9hAAZG5oHWaXOLBptpo7huNi+S97p4izIcoGt+aUiZVm3EgzvvC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NreOSR1M; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a20c51c40so33228145e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756115346; x=1756720146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cm9l30Z/3e08iuv7sMN2PFeVixoBoGdwhV2fpocwB1E=;
        b=NreOSR1MvCumoI9seAAtLQhqncz7PaefjVpqshNgfajKjYNOEP2NM93dM+Q0TCTGD0
         Rssac7sBxfrG3MNujdwSi7l82Lzx3vHU+AmhYbXv42VOTyONJPT3p9/wSI8rxHxFwTJa
         e9UvM1J5HcC8/33qF6XycYBSJoBZLQyt3mDxpSQ4Cd9x+9f4xN06bqmYN2DP4h952hWz
         9nUCu8//sVMiQtSxsq/e7Y1Qx/K2LPbQqQhldxgAD7fETf4gt9lB/ABl1G6U9GPzZ6IW
         9Dme+0xN+aMLYgnvmnVaJzlGf5aq6BGGGkJHg2Hv/VGqrLlxZoYzVM9M9N5uMgXWxQyx
         oZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115346; x=1756720146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cm9l30Z/3e08iuv7sMN2PFeVixoBoGdwhV2fpocwB1E=;
        b=qFw/SKxg3CPfp+PYCsJPJmXM5EP4xSIg4xcu6ioBA2qjyu4oOjdsFyIfjJcotgkg2D
         DB4Vcz3ki4Zi8WvPDXJO1HFauQP2RqCmw5RwEyl6M1VALf1hygkx8CxtKzHi8Nr2NC0x
         D4HkpRSZz/5yt9tKiYel60XS8ikGPutuUbB2BQuy8rGDDyi3h/VUl7XPkA9zkET5KtDB
         vwS9JvLSX3iSem6xNc3PJbt1iFgvvZ82pv/PYgtYOFUrxfwLZ7rMpFd/aVtIUgjmbXhv
         OLxYfaF3GoVYW5HEB9eDkZqo/6yYrIYdGYMTkG/D0CLdAXh5dsyjUcnTkIG2p5Q28DAM
         sN5g==
X-Forwarded-Encrypted: i=1; AJvYcCWXefF6BphjOqapMFOXdy0FPERv2jqy/dqfen1OzkVSphU7Mdi4AS54GfU/YgRjyRncFRQM4MFwkD+W8HY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyld08H55TWmARSNRi7MMFop9gul5+IbnWB0Fo7TyDfAHXaGEz
	F2jgU+F0UBmy7nmZqhttdtPMUbWG8ONx0cBH4dw7+RNvxqxp9X6LfZJiBDxw32s0/yA=
X-Gm-Gg: ASbGncta+E3h9AVj2wpRq9di4Up3MCeQHUEelhzmWEysgC8H6P6u1apZwH0kCAQBVGs
	rmLiWG07zriZNNUNQSX2QWYjVdJm8VfIQkdbzsSEj+uW1fTyh72pjeh5eDTkTqwe/KV9ajIGZ0L
	sT9KAQLhbJwbiJzelXqqsOfa1q86kJ10CK+tA30mx0Jd4JiPachvBMBCY7/TnQ3SYnHA2iX//B0
	B/H3ushD3h543FiDJ9+BAxYGnFNFapMVC5Phir32mHSXo2U1Xlqwr4XuxDr0ucyTP9SxE1qyNiE
	6QmDNUXGTxvdFj2pmxsUUg4Ecfue4yXrPGugAnrqvUu50derHw/mNyST/bzuwtZ0H9B/1Xx6trT
	4wOneA4gZTvaoONzzEuW29ysC5Y46
X-Google-Smtp-Source: AGHT+IFWEVlMhLNcEIGyB39ruCt7EDG55/hLvszV7xQZAZ9yaGfkwJ1sUtcqfCZfVdrByX/HCQU1Vw==
X-Received: by 2002:a5d:5f86:0:b0:3c7:516c:f664 with SMTP id ffacd0b85a97d-3c7516cfafcmr4616609f8f.50.1756115345785;
        Mon, 25 Aug 2025 02:49:05 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef52:fc8d:34ad:9bfe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711bb1e3asm10877449f8f.57.2025.08.25.02.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:49:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Aug 2025 11:48:55 +0200
Subject: [PATCH RESEND 14/14] gpio: ge: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-gpio-mmio-gpio-conv-v1-14-356b4b1d5110@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=TSWl5L0uf8C7UyiKKr/acYMJZJe4qvP633C/saVULBE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorDGAR+XtNETwaYSD9Bj1SsL1CyCwdMGTcUo+r
 Gl8ilVub9WJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaKwxgAAKCRARpy6gFHHX
 cg02D/4xg2B8QQcN1cwN9dgslHRAMpaEu+qCGhNJm82Ol63GnzHaQBFZae3SePQrdg8jYkQ0RLs
 MDJ8coRcYKBvHBalthxtliGkZdcytUG7G///Qf9/FkFmxVYAPrHT0dex0sN8KYBNUrNJvImTT6+
 aZsPlZ4SWR2ktM2OROyeHSy1VYQNrIOZ5LigVY/kvAjSp3zOrRA4suznme36ySfKC+l0jW6YwVl
 9Y8vgF6/cmWh8BF13RQVCwMzcY12XCzrR5I6zwOjDYaqjmX8tnyskFCgc5UKAKTf9sLmogL+bT1
 2d0XnMLobR3N3/opIY425A/jwYxVN+AbuWDboqJPupMNGnMtPStPxeriKVx4a7O9gvlcriI6p/w
 eFjwcVlHCWtDi56fGI5PcmsFkmvzMqzkLNiW3JUu8oYT/AytHWDCSZd+sv8ILlAfV7YaOTzZQi0
 EFwDXoKis3dUzMC2+xfgYUb8Fmac7qioq3C8nl75XFu2k4pnxGGMefuVLy75kIXbvekr50+hep9
 0gdDWfVE11cRVtxUYjU/XQN77swSKuUE5PHvrnBkURRrEkmR5Qes+1EAV1hjRfLtOpxgCBV6n6b
 2ZD3ftR9eBPrrGKMa3Yo+YLaFTwgfPM4zjAyZinTrc4pO9IKy3vWS5h5S3IuDJl/jdTbj5bqKmm
 JisKextEJ3Eix6A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ge.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index 5dc49648d8e378e9741213f9c2de05b4c75b347f..a02dd322e0d4cecd4564a71a550204983df33568 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
@@ -51,24 +52,36 @@ MODULE_DEVICE_TABLE(of, gef_gpio_ids);
 
 static int __init gef_gpio_probe(struct platform_device *pdev)
 {
+	struct gpio_generic_chip_config config;
 	struct device *dev = &pdev->dev;
+	struct gpio_generic_chip *chip;
 	struct gpio_chip *gc;
 	void __iomem *regs;
 	int ret;
 
-	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
-	if (!gc)
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
 		return -ENOMEM;
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	ret = bgpio_init(gc, dev, 4, regs + GEF_GPIO_IN, regs + GEF_GPIO_OUT,
-			 NULL, NULL, regs + GEF_GPIO_DIRECT,
-			 BGPIOF_BIG_ENDIAN_BYTE_ORDER);
+	config = (typeof(config)){
+		.dev = dev,
+		.sz = 4,
+		.dat = regs + GEF_GPIO_IN,
+		.set = regs + GEF_GPIO_OUT,
+		.dirin = regs + GEF_GPIO_DIRECT,
+		.flags = BGPIOF_BIG_ENDIAN_BYTE_ORDER,
+	};
+
+	ret = gpio_generic_chip_init(chip, &config);
 	if (ret)
-		return dev_err_probe(dev, ret, "bgpio_init failed\n");
+		return dev_err_probe(dev, ret,
+				     "failed to initialize the generic GPIO chip\n");
+
+	gc = &chip->gc;
 
 	/* Setup pointers to chip functions */
 	gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pfw", dev_fwnode(dev));

-- 
2.48.1


