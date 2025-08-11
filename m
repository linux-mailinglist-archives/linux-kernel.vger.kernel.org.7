Return-Path: <linux-kernel+bounces-762969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E1EB20D01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5448173FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57132DECB9;
	Mon, 11 Aug 2025 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Jz9N6B0R"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8F22E0408
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924538; cv=none; b=ZgBg/lZmVKKj2VwbGXHhKzbmneN8MJi+yjri4K+n59eR4TDfs02QH5A0tWN4+Kdaei/UPhZq+8gCzqSYzKRHzTNZbXW1/VB3WCS0VMJZGFz01Vw05/KoouNko0oG3FVXXW+UfTHrpYPfg6xrjCv8WJXOXesRFRgmYLbfOoUgsCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924538; c=relaxed/simple;
	bh=JrVzoF6/5W9MPbmnMZbsg9fhIAekqpgyP6QDd3zCrks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TXp5hmAheFVijEO+Y5zx4AzQ4Ghm97InU5z+hatrwDz/TDxnsrRPF1XkJRTFXoUJM9RslUomMDsUk1Y7NxacTq7iW8rW5rp5JJg2WyyG2TUGVFS4PWI4FSOswRdf6qd8NLd8fRNRX9jpXwyMzcYUL6j8t//ybCq6qrAGT5kef5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Jz9N6B0R; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so22497855e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754924535; x=1755529335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysJS8u8Fhvri8S6AtBehkn2Zfsj3AWbxJ9fTcztcrag=;
        b=Jz9N6B0RqGJb7k1Nmq1I0dfUH/uHOSffzZmBhQ+cMtRhRoCD2R0yjPtjC3Ny4gXiH0
         a7SFo4EhOE9ob3QmZbvxUWDaG2WSK1Z11IF2jaqMyULpuMYisI9d/DLLnQDQwC3uCzQH
         WozGtngN+7vySJqeyBIDKpaAwS4Zzx1+/MHHZvumFP0GvfJ1YFax+o23N6kh7zn1P4Ns
         fd9z8Vx46Cv8ef7hTyJdWnlT+CDtka5ynG9RIhHaGXBqt7rhLgTGVCDVLuHn0qt4KvfU
         zj1FmNO2TFO7jvSKfJeX6J1JxxkGahIQGgGP0n0APdAqB2J4wFtkbnu0LO1ygJBnpLWz
         mS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754924535; x=1755529335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysJS8u8Fhvri8S6AtBehkn2Zfsj3AWbxJ9fTcztcrag=;
        b=A3n+DA7/FCqWTtrCcEhXKuSM/OTUPL8XPcbYqH7eMoTaqKiNLeCNKXHGTP/bnK9mhs
         wfQfBAllUtUxmC6Px1uPwnZcjSzr8OXboucP/8ZMIFIq1LD51fkXFaQT07WF8fhP/VtB
         b48B76vRtPdlIPZvRER3FIHLVTVPcFA2XQWuJVN0IyVtY19c693bpi2cGeKiziWce3h9
         upUUhwKAcY03esoc/OHjrK/R/2080H2Tj3bNXARnxDdLHJhx9UPzgkP81al5YOoaZmFS
         0RXS/jbjSCMiOqE8HNy2yG3q5Eq6FnepUXKgd9rDZ3Tj0AplUgl2e1ruK1Z0Kc5lr74q
         ThAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf7Tx0+RXreptP5u+DeQGQHStOddbFfFL46LbCY87K3fMrsX8h7Av4Vic2GfauekdvMozifsNn2KIz3FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+crjF8pu/9TpjgLBXGlZkuORIAEtYfSuX/GJY07iol6xkP2Ho
	OFiNS+Ufzxd95CPjLWegE0tsfzgzBzTB/98zDrlvUQ8lehk191JL1LpCbfzt85HM1U0=
X-Gm-Gg: ASbGnctorPt+rMEZ5tTte10bVUzlKcbf3wm2jdQgXlug6hP6tMiFzdMni/a0lj3SQ7J
	WF88mq8oLgpJlD7i+xgWgd+oBv0TKjJxw7JpKV6Kvw1VdoQPvg1We8ME5WDcuL6NNzuI6VAcQLh
	ujI4Ny0ciXrz9/c1TTwZKNu3Th6fkXri8a+lXiB/tBBITAb6fQ83ekoV+BuYvofrrSAC/gu8s8L
	9S9RmDSskgqGvza3w2HK4JtPddUhFhtwWEOdoyL2E8eSzxYLg7YA6yx32D1LpE94UbI/LAG+r0O
	Ck03Q3xXxeF4KzgeW2IfK0ZdCEWgMxTGymvqAqN4fQ26TeiZ+inRnqbLbAHMcOt0fbURxB57Dlp
	oyUy4zkDhDAKVL9wf
X-Google-Smtp-Source: AGHT+IFiSDH4dTGzeIV+hH7h6pQJ8LcJq0Po1XDJ2GeMsEQEPO5rZY2CszDqq2FuZ2ThQvFn+PGHwg==
X-Received: by 2002:a05:600c:35c3:b0:456:1a69:94fd with SMTP id 5b1f17b1804b1-45a10b3a3edmr905615e9.0.1754924535221;
        Mon, 11 Aug 2025 08:02:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:6841:8926:4410:c880])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459eff7918csm192649605e9.25.2025.08.11.08.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:02:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 11 Aug 2025 17:02:04 +0200
Subject: [PATCH 5/5] pinctrl: wpcm450: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-gpio-mmio-pinctrl-conv-v1-5-a84c5da2be20@linaro.org>
References: <20250811-gpio-mmio-pinctrl-conv-v1-0-a84c5da2be20@linaro.org>
In-Reply-To: <20250811-gpio-mmio-pinctrl-conv-v1-0-a84c5da2be20@linaro.org>
To: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Avi Fishman <avifishman70@gmail.com>, 
 Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
 Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
 Benjamin Fair <benjaminfair@google.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4523;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=FuIHwRskLSRbzwrVaTM8WNQE9cJKBQppwXKNoQVeoEY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomgXtHEGmnbFBea5WN4RyVzy/ytLzLC9kh6vxq
 DDy5vP9Yv6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJoF7QAKCRARpy6gFHHX
 ch1FEACHNtA8UzYfZDTsRXPIaEfNVsIe/A7suWXcUxzJAJ4wCZsAylvzKkr4JN0hxegkQstolf7
 cqpnmT7yqQ1Qk6wcPN9hZ1SSYHmIrwvaf3mTmEloQV38NDiIm7IGi5WF2anqrWdsXNN3Fqw/Z03
 JdjyJUJ5kL/NyHTWt2wSuJS5hnvdvWygpCfSyzgVrSoOrLyFbcGlnT8I7BNO6P5D84sFm2wi7Jm
 mxORKa6aTz2hN16G9QVmbIatahVLcdG/fcDo/fqSdRfrFH54Sxws3Z1yVZiKcrsVWTD8E0xcIfi
 ah2zKGomVba+cXUDEYljd/xpKApsmMZRcMI7JjiZFjYoOXOGWQk/y66BEo7xGO5cm2Ek7E1c3vb
 cKltTFPFOiJa2IZQm5w2yvy6lA08elwimHnGHoWhZVIzJN/i3zKfcAYeYcM3+Wzv09D9vZIDGa4
 c2jq8H6LaAp67sWaKXv+xE4ZtQpaIDrhcTNQE3EvPDga8ATKWdhmZRx3sX9eaKFUiSdAskTrsxq
 Dr99n5NoKjTUCBXAsZpDkai4eXAliRMhl1omn+dBC7Yu2SOBy23wHHP91AJIGRlZt2CTyMq+9/z
 rvhkL4YUd2ZQIdIRTAOUqWRH/1+EHDZOjJGT66N8dJzDfMyUk55wkaiNTKtvBxo3NxRUbinLL7M
 rPWbiSQMV59HkEA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c | 44 ++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
index 8d8314ba0e4cb55db2b1d3adf2de07e6fb93c279..4dd8a3daa83e44b0e2780fedb03ab11fa46a4b7d 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
@@ -11,6 +11,7 @@
 
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/mfd/syscon.h>
@@ -47,7 +48,7 @@ struct wpcm450_pinctrl;
 struct wpcm450_bank;
 
 struct wpcm450_gpio {
-	struct gpio_chip	gc;
+	struct gpio_generic_chip chip;
 	struct wpcm450_pinctrl	*pctrl;
 	const struct wpcm450_bank *bank;
 };
@@ -184,11 +185,12 @@ static void wpcm450_gpio_irq_unmask(struct irq_data *d)
 }
 
 /*
- * This is an implementation of the gpio_chip->get() function, for use in
- * wpcm450_gpio_fix_evpol. Unfortunately, we can't use the bgpio-provided
- * implementation there, because it would require taking gpio_chip->bgpio_lock,
- * which is a spin lock, but wpcm450_gpio_fix_evpol must work in contexts where
- * a raw spin lock is held.
+ * FIXME: This is an implementation of the gpio_chip->get() function, for use
+ * in wpcm450_gpio_fix_evpol(). It was implemented back when gpio-mmio used a
+ * regular spinlock internally, while wpcm450_gpio_fix_evpol() needed to work
+ * in contexts with a raw spinlock held. Since then, the gpio generic chip has
+ * been switched to using a raw spinlock so this should be converted to using
+ * the locking interfaces provided in linux/gpio/gneneric.h.
  */
 static int wpcm450_gpio_get(struct wpcm450_gpio *gpio, int offset)
 {
@@ -329,7 +331,7 @@ static void wpcm450_gpio_irqhandler(struct irq_desc *desc)
 	for_each_set_bit(bit, &pending, 32) {
 		int offset = wpcm450_irq_bitnum_to_gpio(gpio, bit);
 
-		generic_handle_domain_irq(gpio->gc.irq.domain, offset);
+		generic_handle_domain_irq(gpio->chip.gc.irq.domain, offset);
 	}
 	chained_irq_exit(chip, desc);
 }
@@ -1012,7 +1014,7 @@ static int wpcm450_gpio_add_pin_ranges(struct gpio_chip *chip)
 	struct wpcm450_gpio *gpio = gpiochip_get_data(chip);
 	const struct wpcm450_bank *bank = gpio->bank;
 
-	return gpiochip_add_pin_range(&gpio->gc, dev_name(gpio->pctrl->dev),
+	return gpiochip_add_pin_range(&gpio->chip.gc, dev_name(gpio->pctrl->dev),
 				      0, bank->base, bank->length);
 }
 
@@ -1029,6 +1031,7 @@ static int wpcm450_gpio_register(struct platform_device *pdev,
 				     "Resource fail for GPIO controller\n");
 
 	for_each_gpiochip_node(dev, child) {
+		struct gpio_generic_chip_config config;
 		void __iomem *dat = NULL;
 		void __iomem *set = NULL;
 		void __iomem *dirout = NULL;
@@ -1060,17 +1063,26 @@ static int wpcm450_gpio_register(struct platform_device *pdev,
 		} else {
 			flags = BGPIOF_NO_OUTPUT;
 		}
-		ret = bgpio_init(&gpio->gc, dev, 4,
-				 dat, set, NULL, dirout, NULL, flags);
+
+		config = (typeof(config)){
+			.dev = dev,
+			.sz = 4,
+			.dat = dat,
+			.set = set,
+			.dirout = dirout,
+			.flags = flags,
+		};
+
+		ret = gpio_generic_chip_init(&gpio->chip, &config);
 		if (ret < 0)
 			return dev_err_probe(dev, ret, "GPIO initialization failed\n");
 
-		gpio->gc.ngpio = bank->length;
-		gpio->gc.set_config = wpcm450_gpio_set_config;
-		gpio->gc.fwnode = child;
-		gpio->gc.add_pin_ranges = wpcm450_gpio_add_pin_ranges;
+		gpio->chip.gc.ngpio = bank->length;
+		gpio->chip.gc.set_config = wpcm450_gpio_set_config;
+		gpio->chip.gc.fwnode = child;
+		gpio->chip.gc.add_pin_ranges = wpcm450_gpio_add_pin_ranges;
 
-		girq = &gpio->gc.irq;
+		girq = &gpio->chip.gc.irq;
 		gpio_irq_chip_set_chip(girq, &wpcm450_gpio_irqchip);
 		girq->parent_handler = wpcm450_gpio_irqhandler;
 		girq->parents = devm_kcalloc(dev, WPCM450_NUM_GPIO_IRQS,
@@ -1094,7 +1106,7 @@ static int wpcm450_gpio_register(struct platform_device *pdev,
 			girq->num_parents++;
 		}
 
-		ret = devm_gpiochip_add_data(dev, &gpio->gc, gpio);
+		ret = devm_gpiochip_add_data(dev, &gpio->chip.gc, gpio);
 		if (ret)
 			return dev_err_probe(dev, ret, "Failed to add GPIO chip\n");
 	}

-- 
2.48.1


