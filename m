Return-Path: <linux-kernel+bounces-786384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4859B3591D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDEF6835F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7558319840;
	Tue, 26 Aug 2025 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="17S6AXB9"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AF431280C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200922; cv=none; b=LOgfvzk5OSiZcFGcskdr3rcKZ60Vv8eu0UHr6mxUvfEPLkMznqmp5atmqBPaonbzkk4f3td/Lk+LJNXO3Kpp+uJs79Knt4CPJHSo0MzewbfRik0/86ScdcP1TBWrVD8Xt1CUKkt081lGXYA7Dxj9hZnCufz6tNPATZP3Evc9BLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200922; c=relaxed/simple;
	bh=imfxw2xd1+pamTM6m1Jv0l2FeqzWRn3Q68yy0zwdDYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VFb26hG9rBw0h8uUIJfqf//jESYE/LqyBVTcAxfzCxS6U7xu3EXNrOmNOARzmqmK3ulgzZjCODaFNt0+gAX3AXA7mJuBcM7mPfQHa0ue8wqRAkxp5ART5ldedvEBq0c3JaL/v21YDxIeGsyd8mkqazB/k37FzNBnEIYZd3iEsO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=17S6AXB9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c68ac7e238so1820757f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756200918; x=1756805718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5ozA9Bv06U/8Xqy1iShN9MOTwm74I3ECkjpnomfaao=;
        b=17S6AXB9j37EZSB0YFQnm+/4NCLIiwnYIwlzsAKKbMjW+Pa8o4GC/OHJty0F2o7uV3
         HRCCEASiLI/fthnP8SeLLvw6jjQ1Dv077zxg0KBFvkXJTWLKyAOOrsMaBJKxCQOxaRJk
         O92u1fQEs7S6L284PXNvh8FZjXgEGG+KdsUD6mCrepwVHVBoIkISbIrh5COseaC5aLJ3
         pFiLmxsUuEL+toYwDrd/id2Ad9GzOc9gMbHF+6fgpQcqZYX7b1qh12C4fswwLGYFeILx
         JNiVWYIap37aZTfpBljHp/jJmn/ZEclIyKPPRNYzMWg2YdvMP/d9BFWn4j6Jag/NQAjk
         Q+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200918; x=1756805718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5ozA9Bv06U/8Xqy1iShN9MOTwm74I3ECkjpnomfaao=;
        b=OZ4R2e5JibxJl5ukOoykRT0j53c5FAyyHxVTF5w2IPqBOB4GBGhKjYZKs/eQRPmOm6
         13SDSvi/RG5n21Mn+tacvJvhnmq8opDNiQGxJ2gwO+6HN6uSI0w/Y+2mAnWgg/N8GyVR
         JKmqp+1j115c34TtnJj8zxPa8+VH5PjN8CMhUOibLh5in1L7c004W3wYbL9/TM7IwKv/
         n/b2s+SIzPe5CD1QOh2IECDpgs+1WfYkXGOia37bOiFguyRzI1pxbRk52yUt0bI1ehPW
         QfnqnTOFz7zdZKmoIbIsGSVSEbMtdHoneplXrpNpyW4amaRpOK7VORYRz5QAAnYfXSiH
         3f7w==
X-Forwarded-Encrypted: i=1; AJvYcCWL+RNQHZAQ9BiBJ4WUCKl71UYnO6BUzmH1w9T7AUyrgI4kjPrlth+jNiXW9y6HmMsBcx+jxsWbljh7R8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXp7aEUh6AYnZIxBS/cA9K2k8IIIiVYr0CJQfsalWAn0o35Jq5
	D+7xSbrqYUc5DZCeWop3LBDW0Qa/a81g59eSP9WvWSH1nyhfmHUf6EH+jr74ol3CsBY=
X-Gm-Gg: ASbGncuEUI+teP3AVHzijGcL6YsSPnqj0fFUh7U7kdGZ+Fr3g2XzWw8A+Pfomho9CqY
	vs6UBfhc6w+a8DObvWmJFZvJY+zs6aE1Xy9hK51dcy46+g1csNxQm9GQr5RWMpMA9EHXE5pW/yi
	sGxjLw7jCMc0Ml7Y7JlkNs4fhRBos6ENmZIcvg3lIXGpLAATiavJNdCw3DAGvXEre3ZJ0GHY0xa
	Tl6OHVkvWz7VoKuKmNnYoYH+yiKiWHjUnCCwY2HN1ZjhQlWrwf2M48odHqAGJfD4DxFGMQji3VN
	sx1q2W2Oz0zPuUAyPnjN7DGe/EIHi0xUgpo/QRDljXmfeIWSI7rUpDXdmAHLplHWZjhDkyS/mt6
	TzTVxZwRNsEgUa23hjpD+/xB7vTw=
X-Google-Smtp-Source: AGHT+IE0tE/RzFmGAas6KXcSeY2T7eMH/vWwACoAstGhW9wtqaD4AW5ZX1XUBkucRXyAbfKxCt47IA==
X-Received: by 2002:a5d:64ec:0:b0:3a6:d95e:f38c with SMTP id ffacd0b85a97d-3c5dd8aa9e5mr11233482f8f.33.1756200918141;
        Tue, 26 Aug 2025 02:35:18 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5b10sm15308255f8f.47.2025.08.26.02.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:35:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Aug 2025 11:35:07 +0200
Subject: [PATCH 06/12] gpio: xgs-iproc: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-gpio-mmio-gpio-conv-part2-v1-6-f67603e4b27e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3659;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=cwcsufdleTyfdjvLH+M9bpnNNWhHDiBNP0A3nWGPBi0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorX/Nc2+ipMdtkTFzhs/H10ajPYFviqGbqVxeG
 qgjKSLlKdqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK1/zQAKCRARpy6gFHHX
 cpYaEACHIXIK2YjYL9eAp7i1sQJTexz1MuBdYOPR4A8it3r/OYVQqva9D6wvJZVdOK3RAj6Y4zQ
 +iuzGJOlk9UD+nuWtU9nZoIwOdwUj3KXHEcbNXhhfjBFsbtOpXecDO2wREoTop6Zo55K6rHeLZe
 XryN51bj02LGexSZpj8NppyCVBBJLQkzsYvLXIHlQ23Y5QD5K+HuRNyZrNBsLY03ENxsQnacuP9
 OTio5stWF8A4+eOAFS9K/eO+3wI9xzhxCu1A6NecCbPfcZI/K1KFm2+Z5SgQ+0oaDYN5hP/nP9+
 q7lyO0ih1LJHMm9O/NIME2cxYgqUXnq7Knwbz0AfSu/tNWVXTAlE8e7lZU+DE9D2XStL9LtDtwz
 k+AqgxfltD8j8pFNva1ZbkoNCUaroY6gyC5ZkxwrrK+426A0M201/St6LCyrIT4Gb6fjUIbOOed
 kDKeFy+keX0KrlE+Ts+EaMu4SaFEJxvLp3SQPeV4EAeULWR8SDXH6buihr7r/9QnNnXgThzBedG
 mL4677cYfwCL84zVntm7hmbFH1qCkT+Tc+bc75+NzG1lBUU6aBSZho/JNmqCFzL01+XYJmXIl6K
 WxYgCxGKuIUIxfp//ne7C+TbWCCxccQ5jj9A7N1ZfYseV0hVSo5yKFhXIwGBVboGOe6hqK7mHIz
 dBdf5yVrFHM8zyA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-xgs-iproc.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-xgs-iproc.c b/drivers/gpio/gpio-xgs-iproc.c
index 93544e98ccbd3f8172010658cf82f5692949c772..9cffdedd31b1c39123b93469465f483fbb4d076a 100644
--- a/drivers/gpio/gpio-xgs-iproc.c
+++ b/drivers/gpio/gpio-xgs-iproc.c
@@ -3,11 +3,12 @@
  * Copyright (C) 2017 Broadcom
  */
 
-#include <linux/gpio/driver.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -28,7 +29,7 @@
 #define IPROC_GPIO_CCA_INT_EDGE		0x24
 
 struct iproc_gpio_chip {
-	struct gpio_chip gc;
+	struct gpio_generic_chip gen_gc;
 	spinlock_t lock;
 	struct device *dev;
 	void __iomem *base;
@@ -38,7 +39,7 @@ struct iproc_gpio_chip {
 static inline struct iproc_gpio_chip *
 to_iproc_gpio(struct gpio_chip *gc)
 {
-	return container_of(gc, struct iproc_gpio_chip, gc);
+	return container_of(to_gpio_generic_chip(gc), struct iproc_gpio_chip, gen_gc);
 }
 
 static void iproc_gpio_irq_ack(struct irq_data *d)
@@ -213,6 +214,7 @@ static const struct irq_chip iproc_gpio_irq_chip = {
 
 static int iproc_gpio_probe(struct platform_device *pdev)
 {
+	struct gpio_generic_chip_config config;
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = pdev->dev.of_node;
 	struct iproc_gpio_chip *chip;
@@ -231,21 +233,23 @@ static int iproc_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-	ret = bgpio_init(&chip->gc, dev, 4,
-			 chip->base + IPROC_GPIO_CCA_DIN,
-			 chip->base + IPROC_GPIO_CCA_DOUT,
-			 NULL,
-			 chip->base + IPROC_GPIO_CCA_OUT_EN,
-			 NULL,
-			 0);
+	config = (typeof(config)){
+		.dev = dev,
+		.sz = 4,
+		.dat = chip->base + IPROC_GPIO_CCA_DIN,
+		.set = chip->base + IPROC_GPIO_CCA_DOUT,
+		.dirout = chip->base + IPROC_GPIO_CCA_OUT_EN,
+	};
+
+	ret = gpio_generic_chip_init(&chip->gen_gc, &config);
 	if (ret) {
 		dev_err(dev, "unable to init GPIO chip\n");
 		return ret;
 	}
 
-	chip->gc.label = dev_name(dev);
+	chip->gen_gc.gc.label = dev_name(dev);
 	if (!of_property_read_u32(dn, "ngpios", &num_gpios))
-		chip->gc.ngpio = num_gpios;
+		chip->gen_gc.gc.ngpio = num_gpios;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq > 0) {
@@ -266,13 +270,13 @@ static int iproc_gpio_probe(struct platform_device *pdev)
 		 * a flow-handler because the irq is shared.
 		 */
 		ret = devm_request_irq(dev, irq, iproc_gpio_irq_handler,
-				       IRQF_SHARED, chip->gc.label, &chip->gc);
+				       IRQF_SHARED, chip->gen_gc.gc.label, &chip->gen_gc.gc);
 		if (ret) {
 			dev_err(dev, "Fail to request IRQ%d: %d\n", irq, ret);
 			return ret;
 		}
 
-		girq = &chip->gc.irq;
+		girq = &chip->gen_gc.gc.irq;
 		gpio_irq_chip_set_chip(girq, &iproc_gpio_irq_chip);
 		/* This will let us handle the parent IRQ in the driver */
 		girq->parent_handler = NULL;
@@ -282,7 +286,7 @@ static int iproc_gpio_probe(struct platform_device *pdev)
 		girq->handler = handle_simple_irq;
 	}
 
-	ret = devm_gpiochip_add_data(dev, &chip->gc, chip);
+	ret = devm_gpiochip_add_data(dev, &chip->gen_gc.gc, chip);
 	if (ret) {
 		dev_err(dev, "unable to add GPIO chip\n");
 		return ret;

-- 
2.48.1


