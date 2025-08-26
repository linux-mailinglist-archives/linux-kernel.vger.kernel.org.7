Return-Path: <linux-kernel+bounces-786386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F8BB35921
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A11687D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766C43375A1;
	Tue, 26 Aug 2025 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZDND5GCU"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9212D322524
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200924; cv=none; b=MTDLF9jOQbwUSL9B8aV1X7XRLO79yOyfEwQCj9pmQ3DYiDCitTIZHuxXXcH6/o2YNgB4cg6hAGrrADyhE392RYteSTYGbj5EOgKG/AGC6kfBLc2Sg1TgN9sRdtov5rBzqgNWukPcG9511RVu48By+HOH2NMxCvt0InYnUSe9yIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200924; c=relaxed/simple;
	bh=4pgJ76z8CLhArC9qYQdQzWo1qSAKNk492KC0kKL17oY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p57eOSl36kP1rLxnPDscbziLA+tgZZ7QtppOq3F+dXgxSFsaBUnz6rMQHfErTtlSDvrVaxBkxvb+vKCJPklLiUzUUGNaO5lJcj/vx8FktcvO6JH0HUL84pdzfRY5s1ynpB4rMaCcTTmiE4d5hG9Oqf7GPiYbfRDMP0hWIMdLCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZDND5GCU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3cbb3ff70a0so190052f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756200921; x=1756805721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAicBEYxH4Wq0iMqjkmBP1ydMlvyJQbxDwaiB57cyeU=;
        b=ZDND5GCUr91HA79SOEG+VxkitfO9fOixTXuDJmcLwkTod+5tXDNGivmy/euqudQiZa
         NRzAzhOBsAQfEq7LDyaOfQUmntkzV3mYGuQd0KFVOfkQ6il6HSm18CcG1DxhAFe/qAkt
         5yMiP4NqxLm3rrbcNwOjzNseXhCO1pTyTYVz0FKkiUBHmA/14Kll7Jo1NE44bPxn2+2t
         1nFOkg+Qsf47v2MakJdjS0kB1vhmWitKjKUGQ/AuWfxsWDWQgY3gQtCNesSzD8CY7y0X
         5fmjVpbJ/oAZLhkMjDFj8U4i7UAV2zAD2XhqgXs6eg2aomwrgGCKpQnl3LFSSO6UQo0y
         VSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200921; x=1756805721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAicBEYxH4Wq0iMqjkmBP1ydMlvyJQbxDwaiB57cyeU=;
        b=O+r4sWn3pBvLfiLyqh897glgIMhaOZqpobslL/oDcgj0btGWxFabquxCKAk4eoru8O
         2+zdCmPLh8iVuknok53EcbfYgx+UsJi51R+Z584D1SsUz8BcXCIMHd/FlG4fPnXxoBLl
         kjFHBvcumUVPYxUyxHjXBZ9fUYbmVNCCl+5kg2QLbuYLf4lzjD3NLoILMiz72BTxsPtK
         1CsJ0ilVRIxldJxXK+/RSfw3WCkhVXl/u7/Y6YCR99bi6T96oNCjjj+yZ03vKN8MtJ+m
         Au1IQKxh7w30+AfGUh7vlw6PgmU/ONWIp4/Y2cP3R0bvg8lRx+a9cQU/uOh1oYP8kYkp
         ntww==
X-Forwarded-Encrypted: i=1; AJvYcCUktnay7giB4YV253cCqvNfvBzYGm3fFRI7+lib/KxLrVx4czAQgK6lQtzaOM5sN9aDHdFYDkF4llGWKs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PhLpCbHNvoU29U90PLws4otmXxAChPICzPyPqREtSLi/18TL
	BRFD4rnENZc9wvRFpH1Fx2OFRwZ0V2lOSvBNvuy7OY6Ip8cAurjNiHznOwD89tgYqq8=
X-Gm-Gg: ASbGncuBl3G8Yu0xj00u16VuiFaDuqkfl74VrKUfEgAQMhhJSxBbhwfwsFk8MlSRfd7
	7sO+EgZelBTcoVanyHKtodTG53gEtrAbOkNijwaBB6WRD8BpsPp7B04qWa1n0BKUK3LoNBoc7jL
	+c4whiW/1Imtjs1UrNIV5qFmRPUPYKKgYzM1R+pVMiiH9htt3Hi65lwXJKXM1MNkYL4ZcWK3wG9
	bu1tRWF2IAaQKomQeA5C6Uumo4G2l3W2MdcyxDOBpZfrV+L51Hc+u4/5AjOmFB8mNk6U1+3YG6h
	6v4bFxPid2iOjOKKmqqkOy0nM79iu2n6pj+Avb8l47VTQNGFbME1RJEK7y/wXGRctWiy2lEWCb9
	0T6t6K1qZJMUHEzxy
X-Google-Smtp-Source: AGHT+IFpS9xXWMY2Dm1hPaoX2TY/sMKcuRIGpn0bg1DjysIZvtrpX2vCzH3rGMaLHK0/5fha31aU9w==
X-Received: by 2002:a5d:5d87:0:b0:3c9:469d:c054 with SMTP id ffacd0b85a97d-3c9469dc236mr4724123f8f.63.1756200920562;
        Tue, 26 Aug 2025 02:35:20 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5b10sm15308255f8f.47.2025.08.26.02.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:35:19 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Aug 2025 11:35:09 +0200
Subject: [PATCH 08/12] gpio: ftgpio010: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-gpio-mmio-gpio-conv-part2-v1-8-f67603e4b27e@linaro.org>
References: <20250826-gpio-mmio-gpio-conv-part2-v1-0-f67603e4b27e@linaro.org>
In-Reply-To: <20250826-gpio-mmio-gpio-conv-part2-v1-0-f67603e4b27e@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Yang Shen <shenyang39@huawei.com>, 
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=sNq5AHyzS/pQA5YDfBiBOreqsVgAub+i5MXKUwXqNI0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorX/N4KYXmzF6Cg0MaDbG0pp3RTIGwO49gGsAe
 qJ9pzvJqjSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK1/zQAKCRARpy6gFHHX
 cjcND/9da8AdGmBg/JbIu1BPLF5WyvYdgdS+Dl7+Ag6JInBicBZinpzZjhoKyKl3aTkYpdrI0D4
 xsleetUZK9dsiSv2qpRP9K27n5kBSYdsvp6wY9Nx6IH3PgR/k9UYkuSgCoj0yJBe0XfUVwrG3LB
 XhTucuLiOuJ6JTZYCIkxENv80ts3hYZPj+pbR80RymELfoGEdY6JwsJHji424KuSWmJjN1sCap9
 TgMDX+RQZ22zRItzzh8tmBRRuiLkK4K14fH11aUfrRaE2Fazi0f5/+oimccLNXKtsDov35sksbj
 OoNnf8hH982iL5RF7zyI1h6qWTARAotWgvYp36flEp4aB1G1dXrarhSP5i6vFoq8TbbndY04mXD
 ysBeHSj3AqZuKJKzeeO8DTytdX+NqBRH4hcpRLKUdo778w+cIywo+03hi4W24kXSlbJShIf3nq7
 guElSKzFW4Ez3KW1Enz9YcBi6zfQ3DDtqKU1k4Fy2DtHrpjKH+4I1VfXpYsOhM2i3BdrNX/mIuT
 akAlgu12pLzJmh1PRhpDJ4B+r1TWbjoMzjGbI3pFuTEfWg693E0c5XHusfIFbVRe9TuaQfCJMpG
 w7+/+E/XjaRS6BUWGCA+RYXMWtf9HT3fIbglLkNl+48fZ892Fhb+TKXqih6xN6trIbg4J1mgBDT
 /GvsEwTjY4IVjrA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ftgpio010.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.c
index 56666ca8889bc92b91b160751728b65e287b0123..dfa2c9444960a304d411e8d20db9bce0f8afa1c6 100644
--- a/drivers/gpio/gpio-ftgpio010.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -14,6 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
@@ -41,13 +42,13 @@
 /**
  * struct ftgpio_gpio - Gemini GPIO state container
  * @dev: containing device for this instance
- * @gc: gpiochip for this instance
+ * @chip: generic GPIO chip for this instance
  * @base: remapped I/O-memory base
  * @clk: silicon clock
  */
 struct ftgpio_gpio {
 	struct device *dev;
-	struct gpio_chip gc;
+	struct gpio_generic_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
@@ -234,6 +235,7 @@ static const struct irq_chip ftgpio_irq_chip = {
 
 static int ftgpio_gpio_probe(struct platform_device *pdev)
 {
+	struct gpio_generic_chip_config config;
 	struct device *dev = &pdev->dev;
 	struct ftgpio_gpio *g;
 	struct gpio_irq_chip *girq;
@@ -262,27 +264,30 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 		 */
 		return PTR_ERR(g->clk);
 
-	ret = bgpio_init(&g->gc, dev, 4,
-			 g->base + GPIO_DATA_IN,
-			 g->base + GPIO_DATA_SET,
-			 g->base + GPIO_DATA_CLR,
-			 g->base + GPIO_DIR,
-			 NULL,
-			 0);
+	config = (typeof(config)){
+		.dev = dev,
+		.sz = 4,
+		.dat = g->base + GPIO_DATA_IN,
+		.set = g->base + GPIO_DATA_SET,
+		.clr = g->base + GPIO_DATA_CLR,
+		.dirout = g->base + GPIO_DIR,
+	};
+
+	ret = gpio_generic_chip_init(&g->chip, &config);
 	if (ret)
 		return dev_err_probe(dev, ret, "unable to init generic GPIO\n");
 
-	g->gc.label = dev_name(dev);
-	g->gc.base = -1;
-	g->gc.parent = dev;
-	g->gc.owner = THIS_MODULE;
-	/* ngpio is set by bgpio_init() */
+	g->chip.gc.label = dev_name(dev);
+	g->chip.gc.base = -1;
+	g->chip.gc.parent = dev;
+	g->chip.gc.owner = THIS_MODULE;
+	/* ngpio is set by gpio_generic_chip_init() */
 
 	/* We need a silicon clock to do debounce */
 	if (!IS_ERR(g->clk))
-		g->gc.set_config = ftgpio_gpio_set_config;
+		g->chip.gc.set_config = ftgpio_gpio_set_config;
 
-	girq = &g->gc.irq;
+	girq = &g->chip.gc.irq;
 	gpio_irq_chip_set_chip(girq, &ftgpio_irq_chip);
 	girq->parent_handler = ftgpio_gpio_irq_handler;
 	girq->num_parents = 1;
@@ -303,7 +308,7 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 	/* Clear any use of debounce */
 	writel(0x0, g->base + GPIO_DEBOUNCE_EN);
 
-	return devm_gpiochip_add_data(dev, &g->gc, g);
+	return devm_gpiochip_add_data(dev, &g->chip.gc, g);
 }
 
 static const struct of_device_id ftgpio_gpio_of_match[] = {

-- 
2.48.1


