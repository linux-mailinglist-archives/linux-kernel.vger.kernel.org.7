Return-Path: <linux-kernel+bounces-797950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02683B41796
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D54C5E0203
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355D82EA759;
	Wed,  3 Sep 2025 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DCwf0v5r"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0982E7BBC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886430; cv=none; b=UBi07g3bpcZaJXNnBB1dHA6/6nF3mXgjINu5VGZoU6bPAJu5+m0VE1ghy+Y6f6OmSYHtM+ShOKRipoRjltTgiPRsQqcoB0009CrCRGUve3dKc/H4E9w7itzHXa0JR19VyJjlQX6YwG13cVvOWoO+fhET27Kka2kz/Bk3+BMRuBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886430; c=relaxed/simple;
	bh=Cji6f/qefpMj5BhuvEqhIRHO3NzTY6SSV1P6dKzE+Bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tc4sUdhzgfiIgE5VCC1W3fHBfPNQ5/bBmAPAP5w82uXJ9QdMVDPZ0WFkT/tJ2zvL8hONp8QblKEfCsiHD4E2KZhArJspA1D1M66KFqzuZAzbg++kgYHxut+LHBE/SNpuRiBdobIo22JL32Ak+hzdiSlK72d6htrqtbKl+xoTKE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DCwf0v5r; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso38915795e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756886426; x=1757491226; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+DIEi97VRxowiBH9SZS+l4vGVYW+Y4BO4bSdhOraR0=;
        b=DCwf0v5rao2eCb+H1u9F6UlRARDA9TuUdu77EfaafNdqc2ww/XdRzb06IGOHSxNfox
         2pUTBZI9/pSw1Nugf1dqJX1/7ja58x1CDhvZpaBDC12c94yac6cYRtsTzLnqZVdrJ7Fb
         A5RqIr3dwINP1rwwJW0LXRBPiO1RCeeEfyk5ZO39dLxdRlo30o2NBRfe+PvYlouinMpN
         ZI7nSBfUJb/w2MuSvWeVZndneX4bP/d6rW+SFIa6mfkwixQdjVLREfaITFyxwd6rIJND
         ztig9TIRUUAgPHja9R0sYv8uFU/dyY7heFB2OMwJW1BqRCJ0CFiHtCYKrHXe20KvpY4G
         5xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756886426; x=1757491226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+DIEi97VRxowiBH9SZS+l4vGVYW+Y4BO4bSdhOraR0=;
        b=tKy+UgfRtHPDovRwCNpg2ehEyLRmWcq8qPT21vZgMZUEvf5wg1wE88TbGCefYdPTWC
         twHe90IYs7odY3JGZqsATQRODvsuNsb/lvMjzUdgD8IrH5cmqJPv+pGjwmrlEIB4sg9c
         kPA7JsgVZU4YYgL38n7T7hZvDPf89OPmEpcmPQro2Rv1Hq0u6FntJknfZUAGTxu5gg48
         Nsp27biBWXhqtOcRtOQ5v0uqYbPzM1A4P+1Rr3l+pRmf1hegTGQ1ZODzplzuxj0TBayq
         4wvEOxbW0ubsEps3wZg654OSRvwjoTjSjtvVB4wiJcZnyat0XDMjQ0oPaDQfjXV7dSXR
         K8cA==
X-Forwarded-Encrypted: i=1; AJvYcCXR/xlCE6SMpWkxJyzX2TjSe6KcfmrupMpb5XaC4HD7vJ0rC0HNuhqCzE+6ljW2lOdMsirSrBulOWqMx7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpT22lGIhUiMrxmBMFlBBp2UcG12AdhJMJeiBbukhAYVVRmGg5
	8+RlpPWiSQHhkvANuWjRzmtfFwr/DkdgcwdEF7f2MwwwFZ+doLd6gqBBSB7eyaLwCfQ=
X-Gm-Gg: ASbGncu58leL+NP+vYMDwjkNIoCwg9hY2bOQJMHMiIr/Jxj7yGQ5iqULKSqn073Ekao
	zmT4pYlnbx04gJ9Xh0uUlw9YRu+N+Tc9u15vcL+qSMT3sADrcMBA7yR1OJcCVUgdjjR6g9CZs+e
	v1KGHYAqOs7MjEwEOpPc2OEWlAwu8XvxfGnGKd3D/wI3QRCr8lyaQVnGzvVjCeWv1x3AyYfenKr
	OcA8fmz/eY6a6FhIvXM1WvBvbJGZ975ZDRLPI3D6xZeUhS52c1I/+kDXhGBjsmq/Y8SShn4pGyM
	hygkBs+c0AJZBNXmpY7UXH5bDhMVPV4sG5kedOH1BfhvVrxkoXA/IHBP6q0kvhY0tOtdJsOysCl
	BxS4tTQyOcu9tD+B/+B215INexa8=
X-Google-Smtp-Source: AGHT+IHKxGy6ueDBsEyQdQL/mk+XStM3UD+h7raXqFelNnqnwSJQLpRd1NJC05e3nunvconLiqQItQ==
X-Received: by 2002:a05:600c:1592:b0:45b:9a46:2655 with SMTP id 5b1f17b1804b1-45b9a4627b4mr23389375e9.13.1756886424911;
        Wed, 03 Sep 2025 01:00:24 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2f8b:4799:6bd6:35df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b83e954b7sm113331635e9.1.2025.09.03.01.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 01:00:24 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 03 Sep 2025 10:00:08 +0200
Subject: [PATCH 04/12] gpio: blzp1600: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-gpio-mmio-gpio-conv-part3-v1-4-ff346509f408@linaro.org>
References: <20250903-gpio-mmio-gpio-conv-part3-v1-0-ff346509f408@linaro.org>
In-Reply-To: <20250903-gpio-mmio-gpio-conv-part3-v1-0-ff346509f408@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>, 
 Imre Kaloz <kaloz@openwrt.org>, James Cowgill <james.cowgill@blaize.com>, 
 Matt Redfearn <matt.redfearn@blaize.com>, 
 Neil Jones <neil.jones@blaize.com>, 
 Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5038;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=F68ayGcj6tukamf2TyWlBtvd60fsol9kVvTSarVzm3w=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBot/WRHkgVPwU1jO6DA6F5jZ9sztCHx1zF51/sn
 JLDQOuTfCeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaLf1kQAKCRARpy6gFHHX
 chBRD/9PYRGoH3ZtNfKbqvOXMxEhMI+o65yuL3AwbTwEpq4lypxB8b3XWDAwhJLBjQXZjGG47v7
 rVyij2wcwFSsh68pJoARwoVsFmW60fSwm8Pdv4pvkSCM3GsgB/JqBoQlH9dET6Z7CYlRYDTdlXd
 vUOtLGYjdIMR852oqlgIDjLOPlMqj9nkCstPsc0qf4HDUcUfeyrlYtsQweG8sJFZVHuj7T8okuJ
 P6fSl1aJhBU33TPwu/IdOoMQBbaHqDGisjim3gIpOvpIKw86F/3UeWsESd6+50jCNDl16kdS5PW
 IsJ/QaVFuY8/3agB8KeOH9rvcjNVL4FXVOQbW6jiSMF7OXBLEjnQnuLkJLm5WTe3ZDaEqXjhLo8
 aiRnVEs4dAUtPFCtAfDiDPOsOnLTHrNYF+2w8Ul++kmhlzOF2/mQpjkgRvuTbhXQzgE/y0GgqhX
 tAaK82tybg8qE+JSbpw1ckq9gOccyiN+MzhSk4rCfaI9opC9odeqzfjBlPRrJIpqUyn+WdDj8q4
 lUuqszf5aoD/s64KdSEJ5OYTnVEqkzdyFXCpkD55NJ0TnzPr0MoqvHTpeS/6II7egFMB7O+esSM
 XCkaVN65+5/e79zJXTElrA72n/lp5PMHxIK1sprqBrfOm1P9q1nr98SLLh38znf3J4MqiSJYtYI
 2ZuBKYegz9uas2w==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-blzp1600.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-blzp1600.c b/drivers/gpio/gpio-blzp1600.c
index 055cb296ae54758cdc206d36aa1df7b8377d32ec..bfb35d59fa561c43889b186fdfb8d9184b750a53 100644
--- a/drivers/gpio/gpio-blzp1600.c
+++ b/drivers/gpio/gpio-blzp1600.c
@@ -6,6 +6,7 @@
 
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -36,7 +37,7 @@
 
 struct blzp1600_gpio {
 	void __iomem *base;
-	struct gpio_chip gc;
+	struct gpio_generic_chip gen_gc;
 	int irq;
 };
 
@@ -76,7 +77,7 @@ static void blzp1600_gpio_irq_mask(struct irq_data *d)
 {
 	struct blzp1600_gpio *chip = get_blzp1600_gpio_from_irq_data(d);
 
-	guard(raw_spinlock_irqsave)(&chip->gc.bgpio_lock);
+	guard(gpio_generic_lock_irqsave)(&chip->gen_gc);
 	blzp1600_gpio_rmw(chip->base + GPIO_IM_REG, BIT(d->hwirq), 1);
 }
 
@@ -84,7 +85,7 @@ static void blzp1600_gpio_irq_unmask(struct irq_data *d)
 {
 	struct blzp1600_gpio *chip = get_blzp1600_gpio_from_irq_data(d);
 
-	guard(raw_spinlock_irqsave)(&chip->gc.bgpio_lock);
+	guard(gpio_generic_lock_irqsave)(&chip->gen_gc);
 	blzp1600_gpio_rmw(chip->base + GPIO_IM_REG, BIT(d->hwirq), 0);
 }
 
@@ -99,9 +100,9 @@ static void blzp1600_gpio_irq_enable(struct irq_data *d)
 {
 	struct blzp1600_gpio *chip = get_blzp1600_gpio_from_irq_data(d);
 
-	gpiochip_enable_irq(&chip->gc, irqd_to_hwirq(d));
+	gpiochip_enable_irq(&chip->gen_gc.gc, irqd_to_hwirq(d));
 
-	guard(raw_spinlock_irqsave)(&chip->gc.bgpio_lock);
+	guard(gpio_generic_lock_irqsave)(&chip->gen_gc);
 	blzp1600_gpio_rmw(chip->base + GPIO_DIR_REG, BIT(d->hwirq), 0);
 	blzp1600_gpio_rmw(chip->base + GPIO_IEN_REG, BIT(d->hwirq), 1);
 }
@@ -110,9 +111,9 @@ static void blzp1600_gpio_irq_disable(struct irq_data *d)
 {
 	struct blzp1600_gpio *chip = get_blzp1600_gpio_from_irq_data(d);
 
-	guard(raw_spinlock_irqsave)(&chip->gc.bgpio_lock);
+	guard(gpio_generic_lock_irqsave)(&chip->gen_gc);
 	blzp1600_gpio_rmw(chip->base + GPIO_IEN_REG, BIT(d->hwirq), 0);
-	gpiochip_disable_irq(&chip->gc, irqd_to_hwirq(d));
+	gpiochip_disable_irq(&chip->gen_gc.gc, irqd_to_hwirq(d));
 }
 
 static int blzp1600_gpio_irq_set_type(struct irq_data *d, u32 type)
@@ -121,7 +122,7 @@ static int blzp1600_gpio_irq_set_type(struct irq_data *d, u32 type)
 	u32 edge_level, single_both, fall_rise;
 	int mask = BIT(d->hwirq);
 
-	guard(raw_spinlock_irqsave)(&chip->gc.bgpio_lock);
+	guard(gpio_generic_lock_irqsave)(&chip->gen_gc);
 	edge_level = blzp1600_gpio_read(chip, GPIO_IS_REG);
 	single_both = blzp1600_gpio_read(chip, GPIO_IBE_REG);
 	fall_rise = blzp1600_gpio_read(chip, GPIO_IEV_REG);
@@ -186,8 +187,8 @@ static void blzp1600_gpio_irqhandler(struct irq_desc *desc)
 
 	chained_irq_enter(irqchip, desc);
 	irq_status = blzp1600_gpio_read(gpio, GPIO_RIS_REG);
-	for_each_set_bit(hwirq, &irq_status, gpio->gc.ngpio)
-		generic_handle_domain_irq(gpio->gc.irq.domain, hwirq);
+	for_each_set_bit(hwirq, &irq_status, gpio->gen_gc.gc.ngpio)
+		generic_handle_domain_irq(gpio->gen_gc.gc.irq.domain, hwirq);
 
 	chained_irq_exit(irqchip, desc);
 }
@@ -197,7 +198,7 @@ static int blzp1600_gpio_set_debounce(struct gpio_chip *gc, unsigned int offset,
 {
 	struct blzp1600_gpio *chip = gpiochip_get_data(gc);
 
-	guard(raw_spinlock_irqsave)(&chip->gc.bgpio_lock);
+	guard(gpio_generic_lock_irqsave)(&chip->gen_gc);
 	blzp1600_gpio_rmw(chip->base + GPIO_DB_REG, BIT(offset), debounce);
 
 	return 0;
@@ -216,6 +217,7 @@ static int blzp1600_gpio_set_config(struct gpio_chip *gc, unsigned int offset, u
 
 static int blzp1600_gpio_probe(struct platform_device *pdev)
 {
+	struct gpio_generic_chip_config config;
 	struct blzp1600_gpio *chip;
 	struct gpio_chip *gc;
 	int ret;
@@ -228,14 +230,21 @@ static int blzp1600_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-	ret = bgpio_init(&chip->gc, &pdev->dev, 4, chip->base + GPIO_IDATA_REG,
-			 chip->base + GPIO_SET_REG, chip->base + GPIO_CLR_REG,
-			 chip->base + GPIO_DIR_REG, NULL, 0);
+	config = (typeof(config)){
+		.dev = &pdev->dev,
+		.sz = 4,
+		.dat = chip->base + GPIO_IDATA_REG,
+		.set = chip->base + GPIO_SET_REG,
+		.clr = chip->base + GPIO_CLR_REG,
+		.dirout = chip->base + GPIO_DIR_REG,
+	};
+
+	ret = gpio_generic_chip_init(&chip->gen_gc, &config);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to register generic gpio\n");
 
 	/* configure the gpio chip */
-	gc = &chip->gc;
+	gc = &chip->gen_gc.gc;
 	gc->set_config = blzp1600_gpio_set_config;
 
 	if (device_property_present(&pdev->dev, "interrupt-controller")) {

-- 
2.48.1


