Return-Path: <linux-kernel+bounces-764508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93255B223EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447A43AFC57
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041762EBB8E;
	Tue, 12 Aug 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zjawjVfo"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D962EAB99
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992707; cv=none; b=obLM3Xp0ZGS0+ryerBju+MCauylc5ik0jrfuz0jAcHUzCbV8yuc90t1bM/fYa3vw6B/8KT+16kUwxBCk+mxjyWzzxONZp6hPeh68orARm4inopglqChB6CXLQW3FcY722A6KkwBlTxRaLTwWwxLbxg45IaYNwdbeoAs+dWYa5o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992707; c=relaxed/simple;
	bh=1thbdLmTFudV7ob9RYvrVsAtyDB0jUXy5XVU1fSzbt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgKDBTxSWSH3AucAf+7AK1SutC82w9iAHfAH/iCEsBr3xj36eZSRoS9I2453UxNy8ZkS31cuQdt9U/zmVNqToCIUrO8SqueZdi/6LU0yaIZts/uycT9g4eA0alJtWIonId1lDlq0bA/8+Y0mRx0xe4RBF5IpnDBN72D6xIRARCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zjawjVfo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-459d62184c9so31148775e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754992704; x=1755597504; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leTFdfCJ6+RyienTiSwh2q3pg0tznaooZOPdYThkYBU=;
        b=zjawjVfo9sY4t9+r/DEylgaB5hShbR3YMB+NOqgDrqAPbzqYgR/43B1+KDIRDG4Ila
         W0mK/RtNfY2hr5Pg40cSamgF3rQU/7PZlyEmD6Dne6m1PofmxB7ukiVK97o4/51/i+Q+
         oKAkpiv0j1/BedD42MAlYEQCX5McTo3n31kHFKpnef3Sy4oWcshrAxe39BJ24npQYrnA
         /iMGKjPW/I5k5rB+Kbj/ZuesBRmL3DEvtP2FMlaGYEaANnpf/ayyWu6u9swvV7ts/zaJ
         ztku/AnK9FffNYKs5IZy4y+lBWiXw0S1Tdy2AcP3jFsxfhbHZHqVjSgvgY/MhHBgf6pU
         K1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992704; x=1755597504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leTFdfCJ6+RyienTiSwh2q3pg0tznaooZOPdYThkYBU=;
        b=YBokrm7EBuqMhyVKesRbWsb0/dEFgSl5GLUZ2jEWTaMc/4GCVHWMJD6wKLmmY4ZjFh
         akGWS18upJfE215D1atGwR0lOxYtgMJyy+LRY+3UAoe9etw4SUmCd5MbMepfb9kzqRls
         EX3AnTwsMMRnLPz5P6bt9tj3sbiJFWhh0fltuWOxVmZxVW0QXSaTGzjZ23aSt7OEmO0F
         J5Ob5jX5nXw04Hh9Z/oOhnxzqcoIS57jYm+TSVlt6uzwgQPWQEHhJjybDezc3bc0RkDu
         XTX32OjdSmZ+qztGTD4oallAA+aA7NRWmfjBcsCHJsyIDT5h6Beq3QAivi1JapPRFlbV
         DEIg==
X-Forwarded-Encrypted: i=1; AJvYcCX8n9stt4sjj2vbG8KzdjPbyO+vp91GAetK9AZUmU839HcAiksatkSw7oXz5hAfOl4liUyMFraflK+5xHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWZsgw0WQ5L4+ogXQAPV6jG+RCLlaA9icHY34Q74RsJXtYy25Z
	k8yvbgC5OcayJor1Be/refVQ5rsFTBmSYcqc5YoQtypJw0AJRxNOsUMrHrAGEOQNSMfJsBc/Ygf
	44hqa
X-Gm-Gg: ASbGncs68Pd3rmkgR1HiyPT1SbXGDYro7V8ghIKZ3kYRXhwvWGFQ7BaVuL0mzl32vs8
	50NopqUKkV0rmLKqGB3bQ/rzGgwFtpyA7j6ZDgKLlAFcIX+3ICeXF54jL282AUoF4H8oMM8XsPU
	zyxP/lBBFqMAADizUmnQle6JFL+cxeW7wd2m6AT3x2c7D9hk802Y8J47d25cRHeRDKOYs0aNM0l
	1sgDC75y3hkimXeHPZ53/YptayPGObD0KKmVLEcI2ilOysGs4AR1LgsnorsjcgGkEi5Pan1y7qt
	xZmL40okJJC63P5k+2L92ieG9qgSq33xaIbFO4IXR4BTT2gzGgsuENbAQLwCD+8OINC4HvjNEx7
	6V2E3YucD16i41w==
X-Google-Smtp-Source: AGHT+IETc2VFJD6WTh/91nIk+3gAu+AcWC/ofcybzRsIFvbjSdsyABVww9OeJCzbqdCHVlFUHmhimQ==
X-Received: by 2002:a05:6000:2410:b0:3b7:9c28:f856 with SMTP id ffacd0b85a97d-3b91100f0aemr2158938f8f.48.1754992703989;
        Tue, 12 Aug 2025 02:58:23 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0b2d2fasm33098977f8f.50.2025.08.12.02.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:58:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 11:58:00 +0200
Subject: [PATCH RESEND 05/14] gpio: ts4800: use generic device properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-5-8492f4a4c1e4@linaro.org>
References: <20250812-gpio-mmio-gpio-conv-v1-0-8492f4a4c1e4@linaro.org>
In-Reply-To: <20250812-gpio-mmio-gpio-conv-v1-0-8492f4a4c1e4@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=nK9pJAlcVqEpACXDhaB9m0pP1KYR56NEQPbKtHUMK9c=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomxAn7DZWSmDqB5J9Fc8ZXnhimTO0gmQTjYaWM
 Kvgc8T9xu+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsQJwAKCRARpy6gFHHX
 cgS6D/9XMPtIAwi0zbr6uiskR2Wqc1guI1zNrelHFgOmZMDydKyTrrc6/W4f0X4mGgR/Qs8jirN
 DBba5LGqFntJJGSuhSVGp77VdKIUYdcPzKC71PgkuGGzERQiWszoYheEZLq4AsaaT9OQgB5X6/L
 CJj3l77/qI0Skc0XmPq98c6DJHkhOLlUnQ9ZYPFgTLe58AeCZEVrRj6HJBTR9YpC/I3InnCnEBc
 FgxOVaifUwTRExnnbPtAEzLEEqmtzoS0q3DBUzKE7z1eLYsG6hi4RBU3E6852/NsqqcSJaKcXYf
 fDS2D+amyX3erOx30crxMbR8ETVK55EcW5fBACwk1nolh0pZk6CXslpMdDOLjh6AFsxl4JrPPC7
 QTZytHNv2fRwK5pTdZFcWzCS3fcy0bveVpi6LgSXTJyhPr6wlNxuig0f6JezrGT2iR4p2lUK6LK
 W47alVB0AeB3Y0PYAJlhEOLNZU1154VTOq1cZYQaWkvyJ1QR6YN/roFuo8bYZEbO0KGZCddgX1R
 jDqTrb+wvonBXo5x05uqluoT3jQMbpc+uxIzNHqpO8eTIhkXVzYhQvOM5evc+QebCmIRiINHrrc
 sjb7gshciOtuWuqIyGy2zX2wQnqISrUU7fTflKa0WOPuptu5g3WofUhpU1Vy3dQPs92vTErZji/
 iC3ZvuVWnOC4Whw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Avoid pulling in linux/of.h by using the generic device properties.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ts4800.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
index 86f7947ca9b2d23292c1e6660fe93c611e0cb837..f4ae87325393c909c66eda3bb7b2f849e645b7a4 100644
--- a/drivers/gpio/gpio-ts4800.c
+++ b/drivers/gpio/gpio-ts4800.c
@@ -7,8 +7,8 @@
 
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #define DEFAULT_PIN_NUMBER      16
 #define INPUT_REG_OFFSET        0x00
@@ -17,7 +17,7 @@
 
 static int ts4800_gpio_probe(struct platform_device *pdev)
 {
-	struct device_node *node;
+	struct device *dev = &pdev->dev;
 	struct gpio_chip *chip;
 	void __iomem *base_addr;
 	int retval;
@@ -31,11 +31,7 @@ static int ts4800_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(base_addr))
 		return PTR_ERR(base_addr);
 
-	node = pdev->dev.of_node;
-	if (!node)
-		return -EINVAL;
-
-	retval = of_property_read_u32(node, "ngpios", &ngpios);
+	retval = device_property_read_u32(dev, "ngpios", &ngpios);
 	if (retval == -EINVAL)
 		ngpios = DEFAULT_PIN_NUMBER;
 	else if (retval)

-- 
2.48.1


