Return-Path: <linux-kernel+bounces-786388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03B0B35924
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E806686295
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8C318130;
	Tue, 26 Aug 2025 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ouF2HHLq"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EC433470A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200927; cv=none; b=HSUgI8SRkzyHtfToS7Ry8FkI1VKpPj3o9LDteoUs39+5Epz76bKvHVCVEUL0qjF1AL9N2y+YfL8zC7Oc+y/q8SRf6tBK601sNOwEMfqu/3yC1SMMnOlJkpbTAlJV6Q8DVDIkB5yqBDeNmIM8fHenfD0gI0tz7/WaPwNOnImeGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200927; c=relaxed/simple;
	bh=89XO/cSDlDrqvDiy5hnnSyv8S9ENOfSPYBciHEOYcmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onOkyI8a/CY4tGjwMSXzbUpbJ6fG6LaIBIyUhOT4HJM2RJwIuRXEk1UM7KKiJm3bKtx0Rautr3tMrheXplPBwdUsUHRUl8eXLcr9z9UeanBD3eyglQi/dhSHT3VYqPPYNZGywK1Uv8xTy5f744dnsIVsKRWpVaeZc9WoTzZ7mMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ouF2HHLq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c8fe6bd1a2so742945f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756200923; x=1756805723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9/kqdJdxWIzIpzlajuvcdUTzcyLVthHgSoaB5kX8CM=;
        b=ouF2HHLqQwNKFNuOxCXn7R3K5UTV8lbQj+/lb16kJ/PXUXb3q20fS2T0h0jRl5OIFE
         pG6+0Sw0X5SWKxyjSPyQdzpS9e2KlBpzrGPU97miPqeeCdoRyHd2+7ifmbcAgwt9vQPd
         Om9B7WnBgTC2xb7wv39H/8mj9yar+2yHzZUErSjVXcFYZbXbNqSfPwvw49bl8UPBSIzG
         bHcRx1E71zmXXNIPCL3WxrYUDFvwUXpaq78BWSF+XIHTT7cj9EpE7gI+/HSPxZuqz3ra
         luuG3bWeOKUa3i70YIMwrX1VMJIsSkWBVOmkSDqlQu6DbvKiLMw7XqieLB/qB0IkuDJ0
         OI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200923; x=1756805723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9/kqdJdxWIzIpzlajuvcdUTzcyLVthHgSoaB5kX8CM=;
        b=mi9uAsEfz/QFN4CsPemtZeLDOSSeXXyfdni3wOoCHeUnR0Mae8Me3RekQ0QPkjMtcp
         f9iZnfDYThDhPqVXzI9bQgQQ2EByu1OAnkUY41KQCFV2+LM+GvH9hcu44eFZAaqPPp4i
         xc3fB4fsTyiGfKjCRZfatLKH/Q2qzgyOjT4iEsMSCfyH4Tepb8h9ywKeQLXZGkmzWdtU
         7zEEdITDuFf/d/kyfLux5G3WSeOImf1u7O4avuIsBEOFa9MJqfaSC7QqRE3yC1cs+F8O
         8gbaCqujgMpLqSuHH5RMoBLdcdkAG1NjLJMwMahfPaXA5X6jASG/JUZtgzHc2H/HEtK0
         sQKw==
X-Forwarded-Encrypted: i=1; AJvYcCXGRDW+3S+wmZscEdEc9c3x4arkNyWWRW5sOFlDdGikHdCkYSwXxEj1tVaFn5E0VTCL02s0uYZd0Y1+atY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS++Wbck9oVZ6pPGf+uhGLgUgXoXqWA/M0FtEiLYNEG7XIG48G
	RbiH4Xy46oXNxPdmUeErvKRRp/hvx7VY2TW2ZQBC6TX8W0SWSu6mwNsBLvGyouDTQpg=
X-Gm-Gg: ASbGncvAx2TriGlcW4fzfGmNukzEbsc7TXYut8TSz9MqsZxr4Bfvb2b9WSlb+61XkIy
	geekj3GPZ5zemiHF0MCLKL2l/DbGMS5FIqbAkSJRok9nh4+cV+XPatFz4oGFF6LZS1lJPTIoOoi
	C/gb+F/TsEVvd4E+yGa0BqJX4IDCAqEkBkIfjFaHHEbtMvt4+wbmV3rYPQfW8GHSyMAwB6fkUaM
	RqX87wu6wrk/ahjaqQ4FlNOud35n3VIyMaOwjYhVGpenaMnCpdxFLmmvE2q9/FRo8g9aEHlMD1k
	NxHiVzucHZPsjzZ2MoLEBMyD+Re1Pmhk1tcwvKJO3DjsvkMScBhXufYFK+kcZneWlfglGhMg8Yc
	3vocL/+QFB1jj2+JSUUnA6ZupNjk=
X-Google-Smtp-Source: AGHT+IHhqCZTTh38nJ9OEB6j03N/ymjt8499IA6NoJIW3vQyaWoOGjFqqoGaQBY7r9K6SnO7/9Dt/A==
X-Received: by 2002:a05:6000:1ac8:b0:3ca:99ad:5191 with SMTP id ffacd0b85a97d-3ca99ad5743mr2771250f8f.8.1756200923181;
        Tue, 26 Aug 2025 02:35:23 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5b10sm15308255f8f.47.2025.08.26.02.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:35:22 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Aug 2025 11:35:11 +0200
Subject: [PATCH 10/12] gpio: hisi: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-gpio-mmio-gpio-conv-part2-v1-10-f67603e4b27e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4915;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=6Mqj30ZaBzEYO/i4p5Yuij8imY9alsKREk3LJC3mQCk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorX/OZLkAi3tbz0g8kZe2iQka9yX236eZwcXpm
 zN2K0t6BSaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK1/zgAKCRARpy6gFHHX
 cjfBEACYtgt9Zss04cf7kKQJ93aA8/2Cm03zXtnSWIt0g9bpYwn5i2vaR1XPPEqvm0ANtUgonUD
 QkebsSs384De1FePWsu6S2QSAF/500qGclluBNfJZmKvUVCAFNVGzNtWXSZi2li3R59ArLWGT7G
 80w1Bk2KszNtKFRglzYv9VWn7hljzpxcwLzcv4WqcITYT0lG0G53JDhQh+8GSzh0FyQw+q/e8w/
 dip4YjPllUjQoQAOQvNovjWRbXNDukdmIq8k5z8vvS27EUd5ZTlR61mrYh2FV3MaVhThCEiQapm
 CfYZe5EW/LtyRlRrnun0qGjTF43hTNTX5sKc8n6VKcRwthxMwvcT/dvIeQFnKrGjUPelo9s4aLu
 OcXio2M5QpnRTK/g1PsIPc54TB/VGmh45AAc2YvH2R7fk1bJl42hc8bAAn3LitQIFXyRUH4fXTc
 Nh6immFsHmAZbCv7dqFPUf0L/dqiTGaZfu0FJ7b1NWeMIU/hH9pUvVl4MyyXzCmzMbpOLhTCjjy
 SuueZkprVyEnwcKoWcq2Td8MNjueS4+rSci1rDm7+ciVhafAYVeWCqkvA0tjYUR0SujBnjsT3Dp
 GeU2U7ViG44dNjlsE7f2TsdLL9OndQnibEDdm09J1XhED7CO47HaVIYhGMQlWAxwYHP2/jMHJRb
 54f5EVCVEzM9flQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-hisi.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-hisi.c b/drivers/gpio/gpio-hisi.c
index 6016e6f0ed0fb80ea670ebb575452d9ec23976fa..01a99ac613d94e933d30f782520776693f048d1c 100644
--- a/drivers/gpio/gpio-hisi.c
+++ b/drivers/gpio/gpio-hisi.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2020 HiSilicon Limited. */
+
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
@@ -33,7 +35,7 @@
 #define HISI_GPIO_DRIVER_NAME	"gpio-hisi"
 
 struct hisi_gpio {
-	struct gpio_chip	chip;
+	struct gpio_generic_chip chip;
 	struct device		*dev;
 	void __iomem		*reg_base;
 	unsigned int		line_num;
@@ -43,8 +45,8 @@ struct hisi_gpio {
 static inline u32 hisi_gpio_read_reg(struct gpio_chip *chip,
 				     unsigned int off)
 {
-	struct hisi_gpio *hisi_gpio =
-			container_of(chip, struct hisi_gpio, chip);
+	struct hisi_gpio *hisi_gpio = container_of(to_gpio_generic_chip(chip),
+						   struct hisi_gpio, chip);
 	void __iomem *reg = hisi_gpio->reg_base + off;
 
 	return readl(reg);
@@ -53,8 +55,8 @@ static inline u32 hisi_gpio_read_reg(struct gpio_chip *chip,
 static inline void hisi_gpio_write_reg(struct gpio_chip *chip,
 				       unsigned int off, u32 val)
 {
-	struct hisi_gpio *hisi_gpio =
-			container_of(chip, struct hisi_gpio, chip);
+	struct hisi_gpio *hisi_gpio = container_of(to_gpio_generic_chip(chip),
+						   struct hisi_gpio, chip);
 	void __iomem *reg = hisi_gpio->reg_base + off;
 
 	writel(val, reg);
@@ -180,14 +182,14 @@ static void hisi_gpio_irq_disable(struct irq_data *d)
 static void hisi_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct hisi_gpio *hisi_gpio = irq_desc_get_handler_data(desc);
-	unsigned long irq_msk = hisi_gpio_read_reg(&hisi_gpio->chip,
+	unsigned long irq_msk = hisi_gpio_read_reg(&hisi_gpio->chip.gc,
 						   HISI_GPIO_INTSTATUS_WX);
 	struct irq_chip *irq_c = irq_desc_get_chip(desc);
 	int hwirq;
 
 	chained_irq_enter(irq_c, desc);
 	for_each_set_bit(hwirq, &irq_msk, HISI_GPIO_LINE_NUM_MAX)
-		generic_handle_domain_irq(hisi_gpio->chip.irq.domain,
+		generic_handle_domain_irq(hisi_gpio->chip.gc.irq.domain,
 					  hwirq);
 	chained_irq_exit(irq_c, desc);
 }
@@ -206,7 +208,7 @@ static const struct irq_chip hisi_gpio_irq_chip = {
 
 static void hisi_gpio_init_irq(struct hisi_gpio *hisi_gpio)
 {
-	struct gpio_chip *chip = &hisi_gpio->chip;
+	struct gpio_chip *chip = &hisi_gpio->chip.gc;
 	struct gpio_irq_chip *girq_chip = &chip->irq;
 
 	gpio_irq_chip_set_chip(girq_chip, &hisi_gpio_irq_chip);
@@ -264,6 +266,7 @@ static void hisi_gpio_get_pdata(struct device *dev,
 
 static int hisi_gpio_probe(struct platform_device *pdev)
 {
+	struct gpio_generic_chip_config config;
 	struct device *dev = &pdev->dev;
 	struct hisi_gpio *hisi_gpio;
 	int port_num;
@@ -289,26 +292,31 @@ static int hisi_gpio_probe(struct platform_device *pdev)
 
 	hisi_gpio->dev = dev;
 
-	ret = bgpio_init(&hisi_gpio->chip, hisi_gpio->dev, 0x4,
-			 hisi_gpio->reg_base + HISI_GPIO_EXT_PORT_WX,
-			 hisi_gpio->reg_base + HISI_GPIO_SWPORT_DR_SET_WX,
-			 hisi_gpio->reg_base + HISI_GPIO_SWPORT_DR_CLR_WX,
-			 hisi_gpio->reg_base + HISI_GPIO_SWPORT_DDR_SET_WX,
-			 hisi_gpio->reg_base + HISI_GPIO_SWPORT_DDR_CLR_WX,
-			 BGPIOF_NO_SET_ON_INPUT | BGPIOF_UNREADABLE_REG_DIR);
+	config = (typeof(config)){
+		.dev = hisi_gpio->dev,
+		.sz = 4,
+		.dat = hisi_gpio->reg_base + HISI_GPIO_EXT_PORT_WX,
+		.set = hisi_gpio->reg_base + HISI_GPIO_SWPORT_DR_SET_WX,
+		.clr = hisi_gpio->reg_base + HISI_GPIO_SWPORT_DR_CLR_WX,
+		.dirout = hisi_gpio->reg_base + HISI_GPIO_SWPORT_DDR_SET_WX,
+		.dirin = hisi_gpio->reg_base + HISI_GPIO_SWPORT_DDR_CLR_WX,
+		.flags = BGPIOF_NO_SET_ON_INPUT | BGPIOF_UNREADABLE_REG_DIR,
+	};
+
+	ret = gpio_generic_chip_init(&hisi_gpio->chip, &config);
 	if (ret) {
 		dev_err(dev, "failed to init, ret = %d\n", ret);
 		return ret;
 	}
 
-	hisi_gpio->chip.set_config = hisi_gpio_set_config;
-	hisi_gpio->chip.ngpio = hisi_gpio->line_num;
-	hisi_gpio->chip.base = -1;
+	hisi_gpio->chip.gc.set_config = hisi_gpio_set_config;
+	hisi_gpio->chip.gc.ngpio = hisi_gpio->line_num;
+	hisi_gpio->chip.gc.base = -1;
 
 	if (hisi_gpio->irq > 0)
 		hisi_gpio_init_irq(hisi_gpio);
 
-	ret = devm_gpiochip_add_data(dev, &hisi_gpio->chip, hisi_gpio);
+	ret = devm_gpiochip_add_data(dev, &hisi_gpio->chip.gc, hisi_gpio);
 	if (ret) {
 		dev_err(dev, "failed to register gpiochip, ret = %d\n", ret);
 		return ret;

-- 
2.48.1


