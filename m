Return-Path: <linux-kernel+bounces-762741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BBDB20A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D6A426DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F5E2DECA5;
	Mon, 11 Aug 2025 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="f0HEuFmF"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8BD2DE1FE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919391; cv=none; b=o1BMmgNxCRiuHcBtSZUc1TKG9oIme7arWWY/1d94r1/UX57ulDyjNPqCA1/e2CE4unGfg8mKS1r99KKSBmFF7i2JCgc2Sx65CpxIUhosiiZZjfbksC2K5jyL/+rxoqYqHNvxBZEV4pXJqSEm4asij2EgW+FBzgIyA0hFROi3RhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919391; c=relaxed/simple;
	bh=wcWxI/ORPnWYflybpCO5FCh2FVXOIlQ7jBDtMn0/U3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hs4L8yoWQ6AzVebv/LjO7w4XFpNQyQbX8fAhlIZLrnF6DJmsUdY0OcvcBomEHF9vP1oZvBbbcRuwjd/Pa6JGXKtv9td7trrT9o5yx703ZGQRlGM6B65X/gSF1FkMPYACvGPJrXSckDo7SPITp5iKnFSyYI1Z4esZ/7yvuzizoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=f0HEuFmF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459fdc391c6so16945445e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754919388; x=1755524188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnKcEkqbIMfPFHK4N+PMDGhcrN9nsn9H5PP2EHh6DhY=;
        b=f0HEuFmFKbOFqIESNeYx3cpuyNfE9QM4axv5/OMDS7XDBWc7El0konC1EewyBQ0LgB
         O5wwhcRAu2deLq/rzx7nw/fmF8bFbc6WdpaPfDY4REpmHQ3kCGQd+mZ1WaPpSqE6QDvO
         EJRge0sRPj/MiTpG5r0a7TMoEICl84OV3PTHNCi79dYi9/1eRbcZVaMNtP5uQjmemUPc
         sK2tsRb/dzwz6cbYwL3GbmWUsSY8iJcELBFcY7plDBVe7+W3pth3O7OaFb6kqRPOrJ4r
         xciWpbtj18qK/a2/o8SFN8wCZmvjSB+H9enf1dQlYOiI1qH28EZdbhyAhjaJhMEL9jU9
         LvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754919388; x=1755524188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnKcEkqbIMfPFHK4N+PMDGhcrN9nsn9H5PP2EHh6DhY=;
        b=qRgkqIZM1BwjtTZXa7olDHipusLLOHIuclHNep2ODdwoin7zeLuLfi1bfXdBkRwZf7
         7JoZxLMOw0ZI+OYzsrKVeAwbqpnBXTR9Z+qmKjMpAIrMiYLghtCe8ms+7EYBSpOdtTbD
         aUk2DY/jJ5iUQqf1cR4H69zzvlWQ77+81q0OAhNGZgI6SGzS8XfLDLj3tGkMk5NxKd9F
         4ouMZHS3fXP+L3SvbvFx/nzrYykdCFg4zfKkaEXXU243wd2ynEvWix1DOxKQbuBPLOO+
         8kgYC6XiQ/J7AHvVFTQWrsHnK49KHqoWtzPlc0hVo9ytEvBUEeU0iDYrZjBBylN+yzk2
         a12g==
X-Forwarded-Encrypted: i=1; AJvYcCWhXAca+YMixK8EADprzvhBWZZK5wDkm1USvxI/Sp4JOnZ4XetXTdQa2Iz9EE4wfH8Zged1sPZWeKlJnCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmH7bfP7AZNC3AmRwtf4hOd4FT9VwhwcDPkZYBiNIInjFxa6Ls
	1yWY0X475pq++a8WxUKeDSSXpgwmNqZdJq9dQCsYeDaQa5+3s4PIjwnPHUj9y6bone0=
X-Gm-Gg: ASbGncvoz/kucPtMvggOroNp5N8BPCg78g7HHYcKSz8327eLQnacyNuKlCC2j7PCj2k
	M3FLuX7Lhs45cPDYyr8wIe38VimGYAdvgESvmeHKGd0dgxcLqYHA6hREgQT1NOtLuXnKYILwbQQ
	R59jRzCsDYQYxYY4EC4mACxl7CAsJK6fOaO8ejX/jucFOz2my7GyW526OSdau1MUK0sTOTSZG3j
	0+2uHilWVsNOkb+broPym21gMFlr8Utx2+z778gLAJxePER5qsUHl/cqoMfzBT8cQGximT+FFQ+
	7MhAUtYA5BrSar1tJfT1JOZVgSjdTpKKa/gh2IwC+rHfBMWwJ5SAuSzs4EAiukscyOEnYS+kH61
	YH/sQDD2W+OnsZYFzlxPNbOWuMEK6
X-Google-Smtp-Source: AGHT+IEZRe5mubxwzfOZXxCLQyUhvG2u7hesb/LpwWxgwrAcEN/2Kgvpu75YBEWiGSMSpRCy9Y5sQA==
X-Received: by 2002:a05:600c:4f88:b0:456:1923:7549 with SMTP id 5b1f17b1804b1-459f4faf710mr105194645e9.26.1754919387765;
        Mon, 11 Aug 2025 06:36:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:6841:8926:4410:c880])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587d378sm253045105e9.23.2025.08.11.06.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:36:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 11 Aug 2025 15:36:17 +0200
Subject: [PATCH 2/2] mfd: vexpress-sysreg: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-gpio-mmio-mfd-conv-v1-2-68c5c958cf80@linaro.org>
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
In-Reply-To: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
To: Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Pawel Moll <pawel.moll@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=9ATs1N+RIqy7HQcsjCsQ/Bu2Dkvoga6N4G9979jNyL8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomfHYrwsag5Tr9+cDH/r8nmh0r7g+C82rk2d56
 RwUl4GYmmWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJnx2AAKCRARpy6gFHHX
 coQ6EADdzduKhWY9iLHH/zEsVv5UlqMm1QLwEwn18/scNJbERA+TB1iwReBryX4dGi6GuAbI6LH
 Yge5RV7vzIy1/QJb+RfmpoG3Z4cluJr8Yk3O3rBVknkCl1WJ3xx85cLwmFPeZSFP/BN97wZeM7F
 u94Lhm3ijHi2jJsD5I0GIDn6NAAyw8obWQRL037lT8H4dgke3HX1vHAsEutUWJjR//FixdPQ+i1
 kclU1s21x+DWOtcGer/LILtz4u0LGPrZ2uLy5aRjS5FGhcyY+CmgdKwCoUVWcek5fvtNlzsm6jd
 5RxYHHut2AsZJ8EFf+f8f0qbih8jmxtsU5m0+CNVwfthRscP1qsM1rqGc0X97CPz1HdFl0TFocr
 pUcgMIAr3KQaL7y7kWirFCNEKK25dBC2PK8PRpsBWA1+N5ti7cNR/rqBUG/SRggQVSbwjANCfZO
 Bq2pPCA1b972kH0c8usvFHuvJduQ9oj6PpMd0KYx4A833EZ9BI/xRRhvwmbch7Xg0uZBq/NsKtu
 3YN/YOZHLc9GxQhgcrpiWVAyLaUD0pOtn2QNtwzXMXIiJWZ1UO8u67dZ2sfxIf3rGo81lVbD4/I
 bhnGIWSIMQdp6caE1hHFbx43LipZfVZZUaMFed6B5UVKKjHJbzSmV72woSXZeVJpIITmNE+JbFf
 7CQkN6vC0WXE0Xw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mfd/vexpress-sysreg.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 77245c1e5d7df497fda2f6dd8cfb08b5fbcee719..9399eb850ca29b0a9d9be2173bee4bcf6888d10f 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/mfd/core.h>
@@ -96,9 +97,10 @@ static struct mfd_cell vexpress_sysreg_cells[] = {
 
 static int vexpress_sysreg_probe(struct platform_device *pdev)
 {
+	struct gpio_generic_chip *mmc_gpio_chip;
+	struct gpio_generic_chip_config config;
 	struct resource *mem;
 	void __iomem *base;
-	struct gpio_chip *mmc_gpio_chip;
 	int ret;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -117,11 +119,20 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 			GFP_KERNEL);
 	if (!mmc_gpio_chip)
 		return -ENOMEM;
-	bgpio_init(mmc_gpio_chip, &pdev->dev, 0x4, base + SYS_MCI,
-			NULL, NULL, NULL, NULL, 0);
-	mmc_gpio_chip->ngpio = 2;
 
-	ret = devm_gpiochip_add_data(&pdev->dev, mmc_gpio_chip, NULL);
+	config = (typeof(config)){
+		.dev = &pdev->dev,
+		.sz = 4,
+		.dat = base + SYS_MCI,
+	};
+
+	ret = gpio_generic_chip_init(mmc_gpio_chip, &config);
+	if (ret)
+		return ret;
+
+	mmc_gpio_chip->gc.ngpio = 2;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &mmc_gpio_chip->gc, NULL);
 	if (ret)
 		return ret;
 

-- 
2.48.1


