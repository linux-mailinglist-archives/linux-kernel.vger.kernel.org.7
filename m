Return-Path: <linux-kernel+bounces-764730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59606B2268E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0A76230C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1307E2F3C1F;
	Tue, 12 Aug 2025 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="env1mJpG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E19A2F5322
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000791; cv=none; b=lhRNU9DHWHgKZ+FzYg2S9QgP2trOif0ZXqMDBHbC6jX9rC90zDIpft2/W2gsdcuYxgitlN95TNHteL/hGjJow3HpZXxZnI8eATptVFzoZQgxbVlOZ8yDwk5QPO5EUr/nC4a9wbHR2DFZp3lG6B0OB6dmD8O9RgVbcv3ZBn5LxQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000791; c=relaxed/simple;
	bh=hum5I1GPDuLqOSB9j4Zgav5iBNyPswfyro5xC1hpoVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dhmaj/Yh+qGsU9dHgbIG2/AoXnzvk+lon/7d59w9hPdo4ZzG0Q6KXOU74J8kTbTOOGfgUbstrJmYQSs79/uUpnR3BcnAUak4stgkXRLuPfcLbs4aQ5xUyKxzSQmK7okP1bZhLDi1zG3Q07vcwB3mKk08BCST9FEEnLjv49Yytfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=env1mJpG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so46687475e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755000788; x=1755605588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnIvSpX6XaNR1KpnyS1XpJFUwit84iSFYji6KHBKLOk=;
        b=env1mJpGj3TVhSrlaFsVCXzsrny6mKQj/YR8LP7Um1CKq/r4b6GhcNSofa8AC0eXE5
         okbEZSfzY07DM3AgTQVtzg7IAbCnsBP2mWAlsv/9NHO6PyvSXYs5uaPwTp5IUnq5ofZm
         ym7bp6M8Kex5Ml05yjzjTTvVZ2owa7SY9IeixjS25UpZ6LOrBjHFUmnRu28cjYtFpPJx
         YVIpZOKSGS7rAlfcLfoX3pDxKeiJaxS8J7DhYStiURih3e876kMlfbFFEq8s4VSCsnB8
         vHPgdu88mYP/vSRdUT7E0SqKvalrWjmYXocUFKhDKji8t/HDWKMTlQuDBoJ1vFK/2qob
         2ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000788; x=1755605588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnIvSpX6XaNR1KpnyS1XpJFUwit84iSFYji6KHBKLOk=;
        b=p5vZG3HFc2e50MDhPfrYA8TjBr7DAyHUjQBfvhS8CjiEcJglWcZspojHfMS/R1VJGe
         EBkq1Jq9/mJtUInTC89DCgU1XjyLqamwhVeWVX7NdAFa1RgSzdD2rfpv71zoqnK9KElL
         P0SS1VvOC+BXb0fH7/uXBMhPT59Cy/Ei+pZYcngS+DstpV3k3/xOoXopG2P4n8WakHxx
         XAmcpcf59SE5VzN7XbWsaUJXh9VUipUvHTHalgV0uNWqJy5d0Zc6hV9ifI7+jtjVV3u+
         iMsuVQA9UkoPBqOB4twuIjxVfJfHRai/Oudg8AvEwwBL2xWO4+Fqbc5hF2EHiztwZrtl
         9saQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUhyf/T3dg43WmtJb4PZs//8hUoGmztLDUk5D67Gf+XpwFhhYqzESZ5jpWyz5YRdwOdhNdaiC+m8gDtKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6kGgqhrITgNzdMMK1ghNGR+FoTPcEXIUzHbbkXwo/N3RsTRn
	0MhXcU5WmrT6L5ioITKmtCZxUgykEGG+/YuMeo1gHPOYnlWRcXJDeC4c2ERoxtja09A=
X-Gm-Gg: ASbGnct3BEydfWa5E/1L+JWLOxZwtY9HZHfAed8DGEFCRywhsqMEXwJbUuI3TIxaO0Y
	U4GvLIBSqaqVnO1KUB12pc9lrqnnkXhRPD4o4Qqj4KVu6ekqZfxpVkLGE6wX0PhnXik1e502s1Y
	kFLbNV0yVZt73tuW1hObxfGSBHf3y5OdyEpSKAGiFS5P7pbeYcp4mBZa/MRQFGA0vFEx+iKGVII
	Rt6mudR/iYdtZOGkGdxkIFt+khgWCefyxIp9OwPF3OhrVGVlRMC0Eq3y2cBUbX4TdJ8MXTueRKA
	rwtZfu6pE6Xgq9epY9voJDHXa4ekppBkiPSUdsE0u3PfKN92D7GVCc0UhxATpIMfUkg/QAGUv0I
	a6AvGwN9grENlfzU=
X-Google-Smtp-Source: AGHT+IG2z59iLf/0tiinlk/NCu54c4fP+IRhPRFft6sYvAq9TFD8nzvjvNYIAkd5km34zkZGblvybQ==
X-Received: by 2002:a05:600c:300a:b0:456:1442:86e with SMTP id 5b1f17b1804b1-459f691391emr76664995e9.21.1755000787612;
        Tue, 12 Aug 2025 05:13:07 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm298878535e9.6.2025.08.12.05.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:13:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 14:12:55 +0200
Subject: [PATCH RESEND 13/14] gpio: mpc8xxx: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-13-aac41d656979@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10008;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=8xlnAhAzfwO4+HhxnfhDkoiDZ7pkFtIamWGlMtDqlhM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomy/BD/P/xaKsdeGc+eVubcf3SBVOQW3li84GX
 T7I2LtL3RWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsvwQAKCRARpy6gFHHX
 ckahD/wOI88EUItkZnUpOxrHCMdSSXQHbpiHNnCobvI4RrEZHjhEGhbZqFXVz4l/FcH62kvUBPK
 crpJY3loYZaQn9PnGhkGKAf+BsPYuQF7UEGloMb4/+Tt9EWssHSLVIzwgqhERnRVKVopSqwyomD
 ZlZzBluREJoGiE67Tysf7TSqm1nXYyqdi8y9zDHbskLdSme9v8woThvPZBIPcaqiPqfnFPjKIOY
 FqNPiN2upsAUTSXt9APqX3M79HY5OhgKxmYrYXMflZx7pIUGOHxDFuS8bOfYQ3U1GESDjE6A8M+
 Q5E4PqYoRlpe8sjt/YVL8VkEOA7m57RpXdMy1cY/fUP3sf0bBmHqlM6KjAxJuk3frz4Ja1BK1pL
 ldQmwOKFb4T2jvT2Vck7IoXgA/ZMVMAoaAdVPpOOQBMDD5cnnpmJnryB4BqURV48JkveBEVJIdD
 emtqTKnFgM6QWCHSU7eavO/RS+ighIlkpFjw8RU8JdDkOKYWqZMlqLO2mbPks1tdICszaHtG5wI
 EmysuD8juH/B97h2bOpSqPgWiiTk8BTCew0EaOlEdT0ZwELE5B2IRV3mxEYAz4sxpFmjV+ru3iE
 Z35C/A1OhZZCtXnB0tInzQ9W/nvZ2mq4Y6f+lWPHVAkfrSfK16w7IH9wWnpX2X63X4DPHSdF9B1
 3Ho8+wKSAB4iltg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mpc8xxx.c | 102 +++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 40 deletions(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 121efdd71e451d4f992fa195b0d56d7146a6f3dd..38643fb813c562957076aab48d804f8048cee5e4 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -34,7 +35,7 @@
 #define GPIO_IBE		0x18
 
 struct mpc8xxx_gpio_chip {
-	struct gpio_chip	gc;
+	struct gpio_generic_chip chip;
 	void __iomem *regs;
 	raw_spinlock_t lock;
 
@@ -66,8 +67,10 @@ static int mpc8572_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = gpiochip_get_data(gc);
 	u32 out_mask, out_shadow;
 
-	out_mask = gc->read_reg(mpc8xxx_gc->regs + GPIO_DIR);
-	val = gc->read_reg(mpc8xxx_gc->regs + GPIO_DAT) & ~out_mask;
+	out_mask = gpio_generic_read_reg(&mpc8xxx_gc->chip,
+					 mpc8xxx_gc->regs + GPIO_DIR);
+	val = gpio_generic_read_reg(&mpc8xxx_gc->chip,
+				    mpc8xxx_gc->regs + GPIO_DAT) & ~out_mask;
 	out_shadow = gc->bgpio_data & out_mask;
 
 	return !!((val | out_shadow) & mpc_pin2mask(gpio));
@@ -108,12 +111,13 @@ static int mpc8xxx_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 static irqreturn_t mpc8xxx_gpio_irq_cascade(int irq, void *data)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = data;
-	struct gpio_chip *gc = &mpc8xxx_gc->gc;
 	unsigned long mask;
 	int i;
 
-	mask = gc->read_reg(mpc8xxx_gc->regs + GPIO_IER)
-		& gc->read_reg(mpc8xxx_gc->regs + GPIO_IMR);
+	mask = gpio_generic_read_reg(&mpc8xxx_gc->chip,
+				     mpc8xxx_gc->regs + GPIO_IER) &
+	       gpio_generic_read_reg(&mpc8xxx_gc->chip,
+				     mpc8xxx_gc->regs + GPIO_IMR);
 	for_each_set_bit(i, &mask, 32)
 		generic_handle_domain_irq(mpc8xxx_gc->irq, 31 - i);
 
@@ -124,15 +128,17 @@ static void mpc8xxx_irq_unmask(struct irq_data *d)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	struct gpio_chip *gc = &mpc8xxx_gc->gc;
+	struct gpio_chip *gc = &mpc8xxx_gc->chip.gc;
 	unsigned long flags;
 
 	gpiochip_enable_irq(gc, hwirq);
 
 	raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 
-	gc->write_reg(mpc8xxx_gc->regs + GPIO_IMR,
-		gc->read_reg(mpc8xxx_gc->regs + GPIO_IMR)
+	gpio_generic_write_reg(&mpc8xxx_gc->chip,
+			       mpc8xxx_gc->regs + GPIO_IMR,
+		gpio_generic_read_reg(&mpc8xxx_gc->chip,
+				      mpc8xxx_gc->regs + GPIO_IMR)
 		| mpc_pin2mask(irqd_to_hwirq(d)));
 
 	raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
@@ -142,13 +148,14 @@ static void mpc8xxx_irq_mask(struct irq_data *d)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	struct gpio_chip *gc = &mpc8xxx_gc->gc;
+	struct gpio_chip *gc = &mpc8xxx_gc->chip.gc;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 
-	gc->write_reg(mpc8xxx_gc->regs + GPIO_IMR,
-		gc->read_reg(mpc8xxx_gc->regs + GPIO_IMR)
+	gpio_generic_write_reg(&mpc8xxx_gc->chip, mpc8xxx_gc->regs + GPIO_IMR,
+		gpio_generic_read_reg(&mpc8xxx_gc->chip,
+				      mpc8xxx_gc->regs + GPIO_IMR)
 		& ~mpc_pin2mask(irqd_to_hwirq(d)));
 
 	raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
@@ -159,32 +166,34 @@ static void mpc8xxx_irq_mask(struct irq_data *d)
 static void mpc8xxx_irq_ack(struct irq_data *d)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
-	struct gpio_chip *gc = &mpc8xxx_gc->gc;
 
-	gc->write_reg(mpc8xxx_gc->regs + GPIO_IER,
+	gpio_generic_write_reg(&mpc8xxx_gc->chip, mpc8xxx_gc->regs + GPIO_IER,
 		      mpc_pin2mask(irqd_to_hwirq(d)));
 }
 
 static int mpc8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
-	struct gpio_chip *gc = &mpc8xxx_gc->gc;
 	unsigned long flags;
 
 	switch (flow_type) {
 	case IRQ_TYPE_EDGE_FALLING:
 	case IRQ_TYPE_LEVEL_LOW:
 		raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		gc->write_reg(mpc8xxx_gc->regs + GPIO_ICR,
-			gc->read_reg(mpc8xxx_gc->regs + GPIO_ICR)
+		gpio_generic_write_reg(&mpc8xxx_gc->chip,
+				       mpc8xxx_gc->regs + GPIO_ICR,
+			gpio_generic_read_reg(&mpc8xxx_gc->chip,
+					      mpc8xxx_gc->regs + GPIO_ICR)
 			| mpc_pin2mask(irqd_to_hwirq(d)));
 		raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
 		raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		gc->write_reg(mpc8xxx_gc->regs + GPIO_ICR,
-			gc->read_reg(mpc8xxx_gc->regs + GPIO_ICR)
+		gpio_generic_write_reg(&mpc8xxx_gc->chip,
+				       mpc8xxx_gc->regs + GPIO_ICR,
+			gpio_generic_read_reg(&mpc8xxx_gc->chip,
+					      mpc8xxx_gc->regs + GPIO_ICR)
 			& ~mpc_pin2mask(irqd_to_hwirq(d)));
 		raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 		break;
@@ -199,7 +208,6 @@ static int mpc8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
 static int mpc512x_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
-	struct gpio_chip *gc = &mpc8xxx_gc->gc;
 	unsigned long gpio = irqd_to_hwirq(d);
 	void __iomem *reg;
 	unsigned int shift;
@@ -217,7 +225,9 @@ static int mpc512x_irq_set_type(struct irq_data *d, unsigned int flow_type)
 	case IRQ_TYPE_EDGE_FALLING:
 	case IRQ_TYPE_LEVEL_LOW:
 		raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		gc->write_reg(reg, (gc->read_reg(reg) & ~(3 << shift))
+		gpio_generic_write_reg(&mpc8xxx_gc->chip, reg,
+				       (gpio_generic_read_reg(&mpc8xxx_gc->chip,
+							      reg) & ~(3 << shift))
 			| (2 << shift));
 		raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 		break;
@@ -225,14 +235,18 @@ static int mpc512x_irq_set_type(struct irq_data *d, unsigned int flow_type)
 	case IRQ_TYPE_EDGE_RISING:
 	case IRQ_TYPE_LEVEL_HIGH:
 		raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		gc->write_reg(reg, (gc->read_reg(reg) & ~(3 << shift))
+		gpio_generic_write_reg(&mpc8xxx_gc->chip, reg,
+				       (gpio_generic_read_reg(&mpc8xxx_gc->chip,
+							      reg) & ~(3 << shift))
 			| (1 << shift));
 		raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
 		raw_spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
-		gc->write_reg(reg, (gc->read_reg(reg) & ~(3 << shift)));
+		gpio_generic_write_reg(&mpc8xxx_gc->chip, reg,
+				       (gpio_generic_read_reg(&mpc8xxx_gc->chip,
+							      reg) & ~(3 << shift)));
 		raw_spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
 		break;
 
@@ -309,6 +323,7 @@ static const struct of_device_id mpc8xxx_gpio_ids[] = {
 static int mpc8xxx_probe(struct platform_device *pdev)
 {
 	const struct mpc8xxx_gpio_devtype *devtype = NULL;
+	struct gpio_generic_chip_config config;
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc;
 	struct device *dev = &pdev->dev;
 	struct fwnode_handle *fwnode;
@@ -327,26 +342,28 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 	if (IS_ERR(mpc8xxx_gc->regs))
 		return PTR_ERR(mpc8xxx_gc->regs);
 
-	gc = &mpc8xxx_gc->gc;
+	gc = &mpc8xxx_gc->chip.gc;
 	gc->parent = dev;
 
+	config = (typeof(config)){
+		.dev = dev,
+		.sz = 4,
+		.dat = mpc8xxx_gc->regs + GPIO_DAT,
+		.dirout = mpc8xxx_gc->regs + GPIO_DIR,
+		.flags = BGPIOF_BIG_ENDIAN
+	};
+
 	if (device_property_read_bool(dev, "little-endian")) {
-		ret = bgpio_init(gc, dev, 4, mpc8xxx_gc->regs + GPIO_DAT,
-				 NULL, NULL, mpc8xxx_gc->regs + GPIO_DIR,
-				 NULL, BGPIOF_BIG_ENDIAN);
-		if (ret)
-			return ret;
 		dev_dbg(dev, "GPIO registers are LITTLE endian\n");
 	} else {
-		ret = bgpio_init(gc, dev, 4, mpc8xxx_gc->regs + GPIO_DAT,
-				 NULL, NULL, mpc8xxx_gc->regs + GPIO_DIR,
-				 NULL, BGPIOF_BIG_ENDIAN
-				 | BGPIOF_BIG_ENDIAN_BYTE_ORDER);
-		if (ret)
-			return ret;
+		config.flags |= BGPIOF_BIG_ENDIAN_BYTE_ORDER;
 		dev_dbg(dev, "GPIO registers are BIG endian\n");
 	}
 
+	ret = gpio_generic_chip_init(&mpc8xxx_gc->chip, &config);
+	if (ret)
+		return ret;
+
 	mpc8xxx_gc->direction_output = gc->direction_output;
 
 	devtype = device_get_match_data(dev);
@@ -379,10 +396,13 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 	    device_is_compatible(dev, "fsl,ls1028a-gpio") ||
 	    device_is_compatible(dev, "fsl,ls1088a-gpio") ||
 	    is_acpi_node(fwnode)) {
-		gc->write_reg(mpc8xxx_gc->regs + GPIO_IBE, 0xffffffff);
+		gpio_generic_write_reg(&mpc8xxx_gc->chip,
+				       mpc8xxx_gc->regs + GPIO_IBE, 0xffffffff);
 		/* Also, latch state of GPIOs configured as output by bootloader. */
-		gc->bgpio_data = gc->read_reg(mpc8xxx_gc->regs + GPIO_DAT) &
-			gc->read_reg(mpc8xxx_gc->regs + GPIO_DIR);
+		gc->bgpio_data = gpio_generic_read_reg(&mpc8xxx_gc->chip,
+						       mpc8xxx_gc->regs + GPIO_DAT) &
+				 gpio_generic_read_reg(&mpc8xxx_gc->chip,
+						       mpc8xxx_gc->regs + GPIO_DIR);
 	}
 
 	ret = devm_gpiochip_add_data(dev, gc, mpc8xxx_gc);
@@ -405,8 +425,10 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 		return 0;
 
 	/* ack and mask all irqs */
-	gc->write_reg(mpc8xxx_gc->regs + GPIO_IER, 0xffffffff);
-	gc->write_reg(mpc8xxx_gc->regs + GPIO_IMR, 0);
+	gpio_generic_write_reg(&mpc8xxx_gc->chip,
+			       mpc8xxx_gc->regs + GPIO_IER, 0xffffffff);
+	gpio_generic_write_reg(&mpc8xxx_gc->chip,
+			       mpc8xxx_gc->regs + GPIO_IMR, 0);
 
 	ret = devm_request_irq(dev, mpc8xxx_gc->irqn,
 			       mpc8xxx_gpio_irq_cascade,

-- 
2.48.1


