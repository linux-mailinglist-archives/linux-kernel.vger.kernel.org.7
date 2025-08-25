Return-Path: <linux-kernel+bounces-784433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A72E3B33BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5168484B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5DD2D0C97;
	Mon, 25 Aug 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qQK9zNXa"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34D2D47E8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115344; cv=none; b=iWLHflO6SSDANOwkJVfts2kdteQgacrNoY2wAq3InIAcOSV2Qa9pZdNJHnPH2DBVw31RBNQPfwC2ihMcTSqz82walrpXaZg5w1YS2qp2bCPkvwjwEG1BrggwiARXZgIlG+xBe+y/XDifSqlgbk5jg5lC/dQ6f2pcBrtW0H/f+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115344; c=relaxed/simple;
	bh=Lbx82MpdObcs8DWdhpfUiOwmKXRpNixx0jGeIxOjyxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jCmMFKX/XCI0LmumArVGs3840y+y5AydYI7J6AGdP6PoJsiuFsb1wBYGg9e5qesIdWXuIinFDLkIxBx3C6m9pvgeGIk1oWtNsOH4ovWBJ+5yOpMIyDltdJicD9/FKtydoZDmeioWyxYx6T207AuJchkWO48sSEdvifoGKuoCiQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qQK9zNXa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0c52f3so24915335e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756115340; x=1756720140; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8AGdT/nih1iqZ1qXrp+c0t2R6GBFKDYWuJsRpdsd7o=;
        b=qQK9zNXatiFqMczfPHNiuDSZjcncFtqqw/xoCWctyIGIgLt4LvMDM54xW4sKIDPukX
         0lsq0HQuNq+HjVVnm9obX+Q6jfQEOIa/B3JPY9fOZarkC2dgYjvLlbHmmrxNULf2OBZf
         QSYEVJmTvKTIXV8OLtnu4biKphCgROyL1dpMvk5+SBv9R6PNjNcyZGYQOpDoKVpVnhzb
         Vg4M+kjWaKwqj3/nWtKDaBwCdqiRSMn565unt/HBeOLOmGu0deFc2UWPOjyy8QoY4xKD
         t/tmtHvFV+1Yc83/2dkh2zi7s4uIUwOElpAV3x0yVNR0nDhlCQSkuGW9m8OOGZYyOKU4
         xumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115340; x=1756720140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8AGdT/nih1iqZ1qXrp+c0t2R6GBFKDYWuJsRpdsd7o=;
        b=Ei6ZH4lgfdGT/ZOneOHr4SnDkK2gfGOskSQ2g0L5gfkEmQ1ox1qcNjA4SdWemQiM0F
         aUDQ121mZC7UbDsHgty6MRuqPaTFKhw63169nhSRBZcTKeJm4Xb+iaGavhgT+Jx7A34r
         SffxZRJ8IGROLjx7dOO95L1/sDoA+eqxLpflPwamTY+TU7HEwovZjHH9cTmRHjNl5ZxZ
         pkDYteOSSViBPe3mxQrtGetR0undxT9f6cQF6EraLNZVBndnGXXLORqWojG7ePS7TTTv
         gIXVBwLPdNLh0h+G/h47CzGDnv2UmXUuC+ud7TxYjveP4HGVvfY5/TGG7Nvuvz7oN66T
         vubQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgff16ciTBY6vsR1gXD1BOKgxrxjp26PTFPHuSacUR8sFI0WTyuY3pzkvqsH66Eu4pbSjZYIuOL4v/zdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNi0jIfZo6uI/VAP60uoB03kAiapIUiru5EgEfZ0kAg0M/CCs/
	iMNEtGwr+0Ih/t6XPb0ci6aTF1QJJV7VkXUw3KaqhPYgu6882fh9wOnPd1qGosgMtIJSZwrwFf+
	L5DLs
X-Gm-Gg: ASbGncvMx8Vgd/EiZxBEfjKMIb9H6x0aaFbESz9ZWbilbzafbsBuQey/qRJsJrFO6/b
	901aZwhB4DazV+huc+om5scQSNEqjwjbiHwBThjLjWOiK5rhc1ljW9P7ZBtBqW3l2cd2ae3hYXO
	OExgeM78hSRxB2nwgEb2oSgreZO4HQnIPWsTCiKKMV7lrVeFq+s1XwRHsDpWX0OdUQk0nCWq/pm
	V/HSsPdwbrP7mIRpCIUnrfoTe4g1TkKllArnG/ubg8iTrLFYc7n8y+VJeLXWEQ5rXoDs2TprMMK
	ps2Oz5f0x5q1kBH3gfpcFgrvuo2sB5i3HU0MQS5jBeWj/yy2iVHzlvOdFioEYQig0MgZsaEvpEo
	mf6XPs3HHZNwxvQhGkJ/01zcPSpOc
X-Google-Smtp-Source: AGHT+IHWW6bKtKAx/d5aZk6j4o6ODo4SBX9rVF1UwyD5/QakOtfhQoIdXdawwVTazHvmZAvaeEuooQ==
X-Received: by 2002:a05:600c:8b35:b0:458:bfe1:4a8a with SMTP id 5b1f17b1804b1-45b5179f915mr69269935e9.14.1756115340110;
        Mon, 25 Aug 2025 02:49:00 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef52:fc8d:34ad:9bfe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711bb1e3asm10877449f8f.57.2025.08.25.02.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:48:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Aug 2025 11:48:50 +0200
Subject: [PATCH RESEND 09/14] gpio: dwapb: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-gpio-mmio-gpio-conv-v1-9-356b4b1d5110@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13939;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=bJtZHBh+83sX2WnxophXL3lqiaxB1fbZNtH20byx7Cc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorDF/nLSt37oG6Yt370yyxR2YCwJEobsgh7ew+
 qYrjzQVcI2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaKwxfwAKCRARpy6gFHHX
 cgxMEADPB0eCiUwCHXNh/gx5ggF3WpxGY4SQJKyw1gsu4nVAN1pOAin5BEL4lW4i1otfoJwDH6E
 Bdkvzi2oYih9XQ7bkbJEeZ0XRAIvVXY0lCdKa3pNhdvlT9XnoNrUg4/exFprtM1nVi0JBnlxP68
 5XEWm101WZUjhOCsh2Mc7pwAl5Gx3RLbMRuCsEO3lHtWXzt968MXrqPFSKT1LRieKhjXOqnWVbD
 TzcxzleZwuJ9jAeNzfu533vdUtNBIhaeWpU0PgfuegZ79Ju8AXGWyMeMB3I7N1lgVRvR6KIsnpC
 D9cP1twztqYASNDVqvGVxNcDImQrRFFTM/nf5rmv9Y8CeniHy3GQbmkH7hwNbzcvoHzP6NiF2pa
 auSZF+wfemuIY+ylqoX1gqhZDk+kgEJJbaPafrbdNfpIfxj/YXxAl9KjP3XSKJyohIllWDCCzc8
 tgYcOZThhl0MxRqDJqtA6uhnj69cVlnLsuzVUls5dGNsUGSi+IbsfTllFH8LJThg62kZoKvbO7w
 DMoE7KRWIdcXDCP4L1JvHOvWaaI/q2mmYgvsfMBSTl4yYk4jCrDAPH206TONmYMa4I474Yqnc0S
 kzzzGOB7DYnbvXb8/OfpunAy7UTvRWo7iH+9BcOOouF+sSw78HHHBJBGql05JT8F81wgj0/aLiJ
 oU6sbTuOafh30nQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-dwapb.c | 160 +++++++++++++++++++++++++---------------------
 1 file changed, 86 insertions(+), 74 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 43b667b41f5dce4a1a971af4506146e4ffb59b25..0fb781ca9da29545dce23ddbdf3bd5927c714b4c 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -99,7 +100,7 @@ struct dwapb_gpio_port_irqchip {
 };
 
 struct dwapb_gpio_port {
-	struct gpio_chip	gc;
+	struct gpio_generic_chip chip;
 	struct dwapb_gpio_port_irqchip *pirq;
 	struct dwapb_gpio	*gpio;
 #ifdef CONFIG_PM_SLEEP
@@ -107,8 +108,12 @@ struct dwapb_gpio_port {
 #endif
 	unsigned int		idx;
 };
-#define to_dwapb_gpio(_gc) \
-	(container_of(_gc, struct dwapb_gpio_port, gc)->gpio)
+
+static inline struct dwapb_gpio *to_dwapb_gpio(struct gpio_chip *gc)
+{
+	return container_of(to_gpio_generic_chip(gc),
+			    struct dwapb_gpio_port, chip)->gpio;
+}
 
 struct dwapb_gpio {
 	struct	device		*dev;
@@ -148,19 +153,19 @@ static inline u32 gpio_reg_convert(struct dwapb_gpio *gpio, unsigned int offset)
 
 static inline u32 dwapb_read(struct dwapb_gpio *gpio, unsigned int offset)
 {
-	struct gpio_chip *gc	= &gpio->ports[0].gc;
-	void __iomem *reg_base	= gpio->regs;
+	struct gpio_generic_chip *chip = &gpio->ports[0].chip;
+	void __iomem *reg_base = gpio->regs;
 
-	return gc->read_reg(reg_base + gpio_reg_convert(gpio, offset));
+	return gpio_generic_read_reg(chip, reg_base + gpio_reg_convert(gpio, offset));
 }
 
 static inline void dwapb_write(struct dwapb_gpio *gpio, unsigned int offset,
 			       u32 val)
 {
-	struct gpio_chip *gc	= &gpio->ports[0].gc;
-	void __iomem *reg_base	= gpio->regs;
+	struct gpio_generic_chip *chip = &gpio->ports[0].chip;
+	void __iomem *reg_base = gpio->regs;
 
-	gc->write_reg(reg_base + gpio_reg_convert(gpio, offset), val);
+	gpio_generic_write_reg(chip, reg_base + gpio_reg_convert(gpio, offset), val);
 }
 
 static struct dwapb_gpio_port *dwapb_offs_to_port(struct dwapb_gpio *gpio, unsigned int offs)
@@ -186,7 +191,7 @@ static void dwapb_toggle_trigger(struct dwapb_gpio *gpio, unsigned int offs)
 
 	if (!port)
 		return;
-	gc = &port->gc;
+	gc = &port->chip.gc;
 
 	pol = dwapb_read(gpio, GPIO_INT_POLARITY);
 	/* Just read the current value right out of the data register */
@@ -201,13 +206,13 @@ static void dwapb_toggle_trigger(struct dwapb_gpio *gpio, unsigned int offs)
 
 static u32 dwapb_do_irq(struct dwapb_gpio *gpio)
 {
-	struct gpio_chip *gc = &gpio->ports[0].gc;
+	struct gpio_generic_chip *gen_gc = &gpio->ports[0].chip;
 	unsigned long irq_status;
 	irq_hw_number_t hwirq;
 
 	irq_status = dwapb_read(gpio, GPIO_INTSTATUS);
 	for_each_set_bit(hwirq, &irq_status, DWAPB_MAX_GPIOS) {
-		int gpio_irq = irq_find_mapping(gc->irq.domain, hwirq);
+		int gpio_irq = irq_find_mapping(gen_gc->gc.irq.domain, hwirq);
 		u32 irq_type = irq_get_trigger_type(gpio_irq);
 
 		generic_handle_irq(gpio_irq);
@@ -237,27 +242,27 @@ static irqreturn_t dwapb_irq_handler_mfd(int irq, void *dev_id)
 static void dwapb_irq_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_generic_chip *gen_gc = to_gpio_generic_chip(gc);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
 	u32 val = BIT(irqd_to_hwirq(d));
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
+	guard(gpio_generic_lock_irqsave)(gen_gc);
+
 	dwapb_write(gpio, GPIO_PORTA_EOI, val);
-	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static void dwapb_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_generic_chip *gen_gc = to_gpio_generic_chip(gc);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	unsigned long flags;
 	u32 val;
 
-	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	val = dwapb_read(gpio, GPIO_INTMASK) | BIT(hwirq);
-	dwapb_write(gpio, GPIO_INTMASK, val);
-	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	scoped_guard(gpio_generic_lock_irqsave, gen_gc) {
+		val = dwapb_read(gpio, GPIO_INTMASK) | BIT(hwirq);
+		dwapb_write(gpio, GPIO_INTMASK, val);
+	}
 
 	gpiochip_disable_irq(gc, hwirq);
 }
@@ -265,59 +270,61 @@ static void dwapb_irq_mask(struct irq_data *d)
 static void dwapb_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_generic_chip *gen_gc = to_gpio_generic_chip(gc);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	unsigned long flags;
 	u32 val;
 
 	gpiochip_enable_irq(gc, hwirq);
 
-	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
+	guard(gpio_generic_lock_irqsave)(gen_gc);
+
 	val = dwapb_read(gpio, GPIO_INTMASK) & ~BIT(hwirq);
 	dwapb_write(gpio, GPIO_INTMASK, val);
-	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static void dwapb_irq_enable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_generic_chip *gen_gc = to_gpio_generic_chip(gc);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	unsigned long flags;
 	u32 val;
 
-	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
+	guard(gpio_generic_lock_irqsave)(gen_gc);
+
 	val = dwapb_read(gpio, GPIO_INTEN) | BIT(hwirq);
 	dwapb_write(gpio, GPIO_INTEN, val);
 	val = dwapb_read(gpio, GPIO_INTMASK) & ~BIT(hwirq);
 	dwapb_write(gpio, GPIO_INTMASK, val);
-	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static void dwapb_irq_disable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_generic_chip *gen_gc = to_gpio_generic_chip(gc);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	unsigned long flags;
 	u32 val;
 
-	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
+	guard(gpio_generic_lock_irqsave)(gen_gc);
+
 	val = dwapb_read(gpio, GPIO_INTMASK) | BIT(hwirq);
 	dwapb_write(gpio, GPIO_INTMASK, val);
 	val = dwapb_read(gpio, GPIO_INTEN) & ~BIT(hwirq);
 	dwapb_write(gpio, GPIO_INTEN, val);
-	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static int dwapb_irq_set_type(struct irq_data *d, u32 type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_generic_chip *gen_gc = to_gpio_generic_chip(gc);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
 	irq_hw_number_t bit = irqd_to_hwirq(d);
-	unsigned long level, polarity, flags;
+	unsigned long level, polarity;
+
+	guard(gpio_generic_lock_irqsave)(gen_gc);
 
-	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 	level = dwapb_read(gpio, GPIO_INTTYPE_LEVEL);
 	polarity = dwapb_read(gpio, GPIO_INT_POLARITY);
 
@@ -352,7 +359,6 @@ static int dwapb_irq_set_type(struct irq_data *d, u32 type)
 	dwapb_write(gpio, GPIO_INTTYPE_LEVEL, level);
 	if (type != IRQ_TYPE_EDGE_BOTH)
 		dwapb_write(gpio, GPIO_INT_POLARITY, polarity);
-	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	return 0;
 }
@@ -393,11 +399,12 @@ static int dwapb_gpio_set_debounce(struct gpio_chip *gc,
 				   unsigned offset, unsigned debounce)
 {
 	struct dwapb_gpio_port *port = gpiochip_get_data(gc);
+	struct gpio_generic_chip *gen_gc = to_gpio_generic_chip(gc);
 	struct dwapb_gpio *gpio = port->gpio;
-	unsigned long flags, val_deb;
+	unsigned long val_deb;
 	unsigned long mask = BIT(offset);
 
-	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
+	guard(gpio_generic_lock_irqsave)(gen_gc);
 
 	val_deb = dwapb_read(gpio, GPIO_PORTA_DEBOUNCE);
 	if (debounce)
@@ -406,8 +413,6 @@ static int dwapb_gpio_set_debounce(struct gpio_chip *gc,
 		val_deb &= ~mask;
 	dwapb_write(gpio, GPIO_PORTA_DEBOUNCE, val_deb);
 
-	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
-
 	return 0;
 }
 
@@ -445,7 +450,7 @@ static void dwapb_configure_irqs(struct dwapb_gpio *gpio,
 				 struct dwapb_port_property *pp)
 {
 	struct dwapb_gpio_port_irqchip *pirq;
-	struct gpio_chip *gc = &port->gc;
+	struct gpio_chip *gc = &port->chip.gc;
 	struct gpio_irq_chip *girq;
 	int err;
 
@@ -501,6 +506,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 			       struct dwapb_port_property *pp,
 			       unsigned int offs)
 {
+	struct gpio_generic_chip_config config;
 	struct dwapb_gpio_port *port;
 	void __iomem *dat, *set, *dirout;
 	int err;
@@ -519,32 +525,39 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 	set = gpio->regs + GPIO_SWPORTA_DR + pp->idx * GPIO_SWPORT_DR_STRIDE;
 	dirout = gpio->regs + GPIO_SWPORTA_DDR + pp->idx * GPIO_SWPORT_DDR_STRIDE;
 
+	config = (typeof(config)){
+		.dev = gpio->dev,
+		.sz = 4,
+		.dat = dat,
+		.set = set,
+		.dirout = dirout,
+	};
+
 	/* This registers 32 GPIO lines per port */
-	err = bgpio_init(&port->gc, gpio->dev, 4, dat, set, NULL, dirout,
-			 NULL, 0);
+	err = gpio_generic_chip_init(&port->chip, &config);
 	if (err) {
 		dev_err(gpio->dev, "failed to init gpio chip for port%d\n",
 			port->idx);
 		return err;
 	}
 
-	port->gc.fwnode = pp->fwnode;
-	port->gc.ngpio = pp->ngpio;
-	port->gc.base = pp->gpio_base;
-	port->gc.request = gpiochip_generic_request;
-	port->gc.free = gpiochip_generic_free;
+	port->chip.gc.fwnode = pp->fwnode;
+	port->chip.gc.ngpio = pp->ngpio;
+	port->chip.gc.base = pp->gpio_base;
+	port->chip.gc.request = gpiochip_generic_request;
+	port->chip.gc.free = gpiochip_generic_free;
 
 	/* Only port A support debounce */
 	if (pp->idx == 0)
-		port->gc.set_config = dwapb_gpio_set_config;
+		port->chip.gc.set_config = dwapb_gpio_set_config;
 	else
-		port->gc.set_config = gpiochip_generic_config;
+		port->chip.gc.set_config = gpiochip_generic_config;
 
 	/* Only port A can provide interrupts in all configurations of the IP */
 	if (pp->idx == 0)
 		dwapb_configure_irqs(gpio, port, pp);
 
-	err = devm_gpiochip_add_data(gpio->dev, &port->gc, port);
+	err = devm_gpiochip_add_data(gpio->dev, &port->chip.gc, port);
 	if (err) {
 		dev_err(gpio->dev, "failed to register gpiochip for port%d\n",
 			port->idx);
@@ -750,38 +763,37 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
 static int dwapb_gpio_suspend(struct device *dev)
 {
 	struct dwapb_gpio *gpio = dev_get_drvdata(dev);
-	struct gpio_chip *gc	= &gpio->ports[0].gc;
-	unsigned long flags;
+	struct gpio_generic_chip *gen_gc = &gpio->ports[0].chip;
 	int i;
 
-	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	for (i = 0; i < gpio->nr_ports; i++) {
-		unsigned int offset;
-		unsigned int idx = gpio->ports[i].idx;
-		struct dwapb_context *ctx = gpio->ports[i].ctx;
+	scoped_guard(gpio_generic_lock_irqsave, gen_gc) {
+		for (i = 0; i < gpio->nr_ports; i++) {
+			unsigned int offset;
+			unsigned int idx = gpio->ports[i].idx;
+			struct dwapb_context *ctx = gpio->ports[i].ctx;
 
-		offset = GPIO_SWPORTA_DDR + idx * GPIO_SWPORT_DDR_STRIDE;
-		ctx->dir = dwapb_read(gpio, offset);
+			offset = GPIO_SWPORTA_DDR + idx * GPIO_SWPORT_DDR_STRIDE;
+			ctx->dir = dwapb_read(gpio, offset);
 
-		offset = GPIO_SWPORTA_DR + idx * GPIO_SWPORT_DR_STRIDE;
-		ctx->data = dwapb_read(gpio, offset);
+			offset = GPIO_SWPORTA_DR + idx * GPIO_SWPORT_DR_STRIDE;
+			ctx->data = dwapb_read(gpio, offset);
 
-		offset = GPIO_EXT_PORTA + idx * GPIO_EXT_PORT_STRIDE;
-		ctx->ext = dwapb_read(gpio, offset);
+			offset = GPIO_EXT_PORTA + idx * GPIO_EXT_PORT_STRIDE;
+			ctx->ext = dwapb_read(gpio, offset);
 
-		/* Only port A can provide interrupts */
-		if (idx == 0) {
-			ctx->int_mask	= dwapb_read(gpio, GPIO_INTMASK);
-			ctx->int_en	= dwapb_read(gpio, GPIO_INTEN);
-			ctx->int_pol	= dwapb_read(gpio, GPIO_INT_POLARITY);
-			ctx->int_type	= dwapb_read(gpio, GPIO_INTTYPE_LEVEL);
-			ctx->int_deb	= dwapb_read(gpio, GPIO_PORTA_DEBOUNCE);
+			/* Only port A can provide interrupts */
+			if (idx == 0) {
+				ctx->int_mask = dwapb_read(gpio, GPIO_INTMASK);
+				ctx->int_en = dwapb_read(gpio, GPIO_INTEN);
+				ctx->int_pol = dwapb_read(gpio, GPIO_INT_POLARITY);
+				ctx->int_type = dwapb_read(gpio, GPIO_INTTYPE_LEVEL);
+				ctx->int_deb = dwapb_read(gpio, GPIO_PORTA_DEBOUNCE);
 
-			/* Mask out interrupts */
-			dwapb_write(gpio, GPIO_INTMASK, ~ctx->wake_en);
+				/* Mask out interrupts */
+				dwapb_write(gpio, GPIO_INTMASK, ~ctx->wake_en);
+			}
 		}
 	}
-	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	clk_bulk_disable_unprepare(DWAPB_NR_CLOCKS, gpio->clks);
 
@@ -791,8 +803,8 @@ static int dwapb_gpio_suspend(struct device *dev)
 static int dwapb_gpio_resume(struct device *dev)
 {
 	struct dwapb_gpio *gpio = dev_get_drvdata(dev);
-	struct gpio_chip *gc	= &gpio->ports[0].gc;
-	unsigned long flags;
+	struct gpio_chip *gc = &gpio->ports[0].chip.gc;
+	struct gpio_generic_chip *gen_gc = to_gpio_generic_chip(gc);
 	int i, err;
 
 	err = clk_bulk_prepare_enable(DWAPB_NR_CLOCKS, gpio->clks);
@@ -801,7 +813,8 @@ static int dwapb_gpio_resume(struct device *dev)
 		return err;
 	}
 
-	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
+	guard(gpio_generic_lock_irqsave)(gen_gc);
+
 	for (i = 0; i < gpio->nr_ports; i++) {
 		unsigned int offset;
 		unsigned int idx = gpio->ports[i].idx;
@@ -828,7 +841,6 @@ static int dwapb_gpio_resume(struct device *dev)
 			dwapb_write(gpio, GPIO_PORTA_EOI, 0xffffffff);
 		}
 	}
-	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	return 0;
 }

-- 
2.48.1


