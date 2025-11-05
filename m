Return-Path: <linux-kernel+bounces-886270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55E1C3520B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEEA3B8126
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEE3307499;
	Wed,  5 Nov 2025 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl9moNAX"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622630505B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338979; cv=none; b=tOyWbql2zqG8H1jmUPsaj6K+q2CtxmkUYKZpt/o4NdYvG+ufTRAuFTmeqJu88FynTUq2wguy/3Zg6kJMMBF3mVWfSCZxaCqm6pgdpdvSHBjBHxTMWTcc8YDpAAXpE1nI7ktIYFtlVzdzbTkBWfbbvwwJS0/cXwzVdekOcGXi30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338979; c=relaxed/simple;
	bh=KDesIfsn2xu6U2CtUzSWMng87iI1n+RYPUP8WaYWAoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljKLId/zTrtJEbXvBBfRGzW1Y4TrSPrA+cC7TytZJOsYW2bZHz6DkrF3pfh8mg0vMZ/3Q+Pfu4s8PW+jFikcqlz5TVz+36bPPbViCEzCKaNUaE63+mHML2Zfk2S+bdzX0Yf6LW4peuTwgN4yQYz56CIfgIZGfAHhlVsEjPYjYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cl9moNAX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so1173527066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762338974; x=1762943774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiWeWU99+P2OBlwtwLukYVoiHCgrNeTiK3bQO2+aHuQ=;
        b=Cl9moNAXDHNcQpfGIGCc2uow2sveCRVmKwVvl6zBGUGEQu3vMqpWsqmQ4IUmWnOYam
         s9tWS7yICph/WKP2fx+AwlLgWoUNH+mqvPlJUmVJkt7AXvuXTyzL/TVo4h5YMu7GTvKe
         J70ZcwHWULdCTl9fAHuSxdlIanWqB01RcvLqfamNgNIRB0inzkQpEbPgE3ZGIQsz6Vjc
         1MkcZAlm6O9ZxuYgMFgxpo8cW0Lt1eQrcr5nGmriIH6+dUTmAAtev/6I3h+6FszmD9y+
         8s7CwlmoQPh9t4vMgQItxjXk/C/xWY5J5zi0bVSSJ2U2DcvVSFvo1aoJ3HTXxqKkUe0V
         YO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338974; x=1762943774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiWeWU99+P2OBlwtwLukYVoiHCgrNeTiK3bQO2+aHuQ=;
        b=aWrZK+I6Pz18qJRVeJtlHe3zhP6VcS4zu8V8/BlmE4krL4r+Q589bQyFfJ4a7QGh40
         vwOFYqKC8GHszbURDzfzdl0xcPjZc6Hr80Fp8SdsGRe7J8/KJxYsPTxoxaCWD73rIOrD
         u7dKLOmtvgdVDIhJFlSQdaXZ+umg1gfUmS6Ximj19sK7lg4UIyr0vRzkWVDLbWDUg3WH
         EwGzan5V7/OYc6K7O05kBupR7Me1uiqg6c99zkDDsNNSskIeb/Tl5i/i31niaWd6UV7U
         ioKCRenLh3t6+el2zvs2jNv1tVTrGcwU1RQ4wIw5BE+lYtJLY5a+4D2rfGU61YLkl/Fj
         6VBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDO4iP3c0OcBRamKzqlLbZ0TxxKuRZfk6PD6OSZ6QbmmDXl2CP4XT+5w9i0s6zdEYH3H7ZkZbtRTWmZTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCT78MEO5h4PYHt/sYr6bv44IgYzoF7ZLqpUHGL0EftQy9GFzc
	izcYOfGdHrBEM4y9k38CvLQwiWRjaSD8ydyPdh9ECW6t6cWmY7D+gVBV
X-Gm-Gg: ASbGncsh8Lc8ApwbmIfJm3rDMY75miz3wv1IeSlj35bPrjgoYELUnppcpEGbIwPg95i
	1aBaipZzz8EF9qzsKDV7tHdYpU4KGOh6sg67dH0LhXPTkJttJArBwtbdvUWMOoO84Yy5MeHdICQ
	PDL14B9xehE/NkFmWsrZA89Wu0mWXDKbzRboRjpnBesCjbppwG+t6KxIHNofYkQXA30ks1WLkDD
	8UbCwFXciCmHqhSEqkl0A7KgJ80n3PjxUKFK1533GW4O/rZll1HJSvIuTWYNFg3IsNJ6V+zwgFo
	CVdGamZOWYHzC1K4pG14l77tOyTnKmdtASNJLfLnz0i/h96XV3/5IBU7BLNT3kxqmg5LZsmfdnX
	k2SQobNjdeG5e0Dw4lnUyikWsviusyigdQYDrpV7ImTa5UVNQ6a1LFLhizv8dDAi05twdjjakAs
	qqwZI=
X-Google-Smtp-Source: AGHT+IEM16NafFW2nC97ok9XEm+53qMVZBe4OIJxe3eLowZZOL6gKamZMEdrt0F28He7dGEhTIoj1g==
X-Received: by 2002:a17:907:6e89:b0:b70:b1e1:8294 with SMTP id a640c23a62f3a-b7265156582mr234675166b.4.1762338974287;
        Wed, 05 Nov 2025 02:36:14 -0800 (PST)
Received: from builder.. ([2001:9e8:f106:5b16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7270b56f18sm83426066b.33.2025.11.05.02.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:36:14 -0800 (PST)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Richard <thomas.richard@bootlin.com>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH v4 2/2] gpio: add gpio-line-mux driver
Date: Wed,  5 Nov 2025 10:36:06 +0000
Message-ID: <20251105103607.393353-3-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251105103607.393353-1-jelonek.jonas@gmail.com>
References: <20251105103607.393353-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new driver which provides a 1-to-many mapping for a single real
GPIO using a multiplexer. Each virtual GPIO corresponds to a multiplexer
state which, if set for the multiplexer, connects the real GPIO to the
corresponding virtual GPIO.

This can help in various usecases. One practical case is the special
hardware design of the Realtek-based XS1930-10 switch from Zyxel. It
features two SFP+ ports/cages whose signals are wired directly to the
switch SoC. Although Realtek SoCs are short on GPIOs, there are usually
enough the fit the SFP signals without any hacks.

However, Zyxel did some weird design and connected RX_LOS, MOD_ABS and
TX_FAULT of one SFP cage onto a single GPIO line controlled by a
multiplexer (the same for the other SFP cage). The single multiplexer
controls the lines for both SFP and depending on the state, the
designated 'signal GPIO lines' are connected to one of the three SFP
signals.

Because the SFP core/driver doesn't support multiplexer but needs single
GPIOs for each of the signals, this driver fills the gap between both.
It registers a gpio_chip, provides multiple virtual GPIOs and sets the
backing multiplexer accordingly.

Due to several practical issues, this is input-only and doesn't support
IRQs.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 MAINTAINERS                  |   6 ++
 drivers/gpio/Kconfig         |   9 +++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-line-mux.c | 129 +++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+)
 create mode 100644 drivers/gpio/gpio-line-mux.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3da2c26a796b..66f8706d9b4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10653,6 +10653,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/irled/gpio-ir-tx.yaml
 F:	drivers/media/rc/gpio-ir-tx.c
 
+GPIO LINE MUX
+M:	Jonas Jelonek <jelonek.jonas@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/gpio-line-mux.yaml
+F:	drivers/gpio/gpio-line-mux.c
+
 GPIO MOCKUP DRIVER
 M:	Bamvor Jian Zhang <bamv2005@gmail.com>
 L:	linux-gpio@vger.kernel.org
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ce237398fa00..5f8082ae99cc 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1986,6 +1986,15 @@ config GPIO_LATCH
 	  Say yes here to enable a driver for GPIO multiplexers based on latches
 	  connected to other GPIOs.
 
+config GPIO_LINE_MUX
+	tristate "GPIO line mux driver"
+	depends on OF_GPIO
+	select MULTIPLEXER
+	help
+	  Say Y here to support the GPIO line mux, which can provide virtual
+	  GPIOs backed by a shared real GPIO and a multiplexer in a 1-to-many
+	  fashion.
+
 config GPIO_MOCKUP
 	tristate "GPIO Testing Driver (DEPRECATED)"
 	select IRQ_SIM
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index ee260a0809d3..6caee52b0356 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_GPIO_IXP4XX)		+= gpio-ixp4xx.o
 obj-$(CONFIG_GPIO_JANZ_TTL)		+= gpio-janz-ttl.o
 obj-$(CONFIG_GPIO_KEMPLD)		+= gpio-kempld.o
 obj-$(CONFIG_GPIO_LATCH)		+= gpio-latch.o
+obj-$(CONFIG_GPIO_LINE_MUX)		+= gpio-line-mux.o
 obj-$(CONFIG_GPIO_LJCA) 		+= gpio-ljca.o
 obj-$(CONFIG_GPIO_LOGICVC)		+= gpio-logicvc.o
 obj-$(CONFIG_GPIO_LOONGSON1)		+= gpio-loongson1.o
diff --git a/drivers/gpio/gpio-line-mux.c b/drivers/gpio/gpio-line-mux.c
new file mode 100644
index 000000000000..50e351d212b8
--- /dev/null
+++ b/drivers/gpio/gpio-line-mux.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPIO line mux which acts as virtual gpiochip and provides a 1-to-many
+ * mapping between virtual GPIOs and a real GPIO + multiplexer.
+ *
+ * Copyright (c) 2025 Jonas Jelonek <jelonek.jonas@gmail.com>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/mux/consumer.h>
+#include <linux/platform_device.h>
+
+#define MUX_SELECT_DELAY_US	100
+
+struct gpio_lmux {
+	struct gpio_chip gc;
+	struct mux_control *mux;
+
+	struct gpio_desc *shared_gpio;
+	/* dynamically sized, must be last */
+	unsigned int gpio_mux_states[];
+};
+
+static int gpio_lmux_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_lmux *glm = gpiochip_get_data(gc);
+	int ret;
+
+	if (offset > gc->ngpio)
+		return -EINVAL;
+
+	ret = mux_control_select_delay(glm->mux, glm->gpio_mux_states[offset],
+				       MUX_SELECT_DELAY_US);
+	if (ret < 0)
+		return ret;
+
+	ret = gpiod_get_raw_value_cansleep(glm->shared_gpio);
+	mux_control_deselect(glm->mux);
+	return ret;
+}
+
+static int gpio_lmux_gpio_set(struct gpio_chip *gc, unsigned int offset,
+			      int value)
+{
+	return -EOPNOTSUPP;
+}
+
+static int gpio_lmux_gpio_get_direction(struct gpio_chip *gc,
+					unsigned int offset)
+{
+	return GPIO_LINE_DIRECTION_IN;
+}
+
+static int gpio_lmux_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct gpio_lmux *glm;
+	unsigned int ngpio;
+	size_t size;
+	int ret;
+
+	ngpio = device_property_count_u32(dev, "gpio-line-mux-states");
+	if (!ngpio)
+		return -EINVAL;
+
+	size = struct_size(glm, gpio_mux_states, ngpio);
+	glm = devm_kzalloc(dev, size, GFP_KERNEL);
+	if (!glm)
+		return -ENOMEM;
+
+	glm->gc.base = -1;
+	glm->gc.can_sleep = true;
+	glm->gc.fwnode = dev_fwnode(dev);
+	glm->gc.label = dev_name(dev);
+	glm->gc.ngpio = ngpio;
+	glm->gc.owner = THIS_MODULE;
+	glm->gc.parent = dev;
+
+	glm->gc.get = gpio_lmux_gpio_get;
+	glm->gc.set = gpio_lmux_gpio_set;
+	glm->gc.get_direction = gpio_lmux_gpio_get_direction;
+
+	glm->mux = devm_mux_control_get(dev, NULL);
+	if (IS_ERR(glm->mux))
+		return dev_err_probe(dev, PTR_ERR(glm->mux),
+				     "could not get mux controller\n");
+
+	glm->shared_gpio = devm_gpiod_get(dev, "shared", GPIOD_ASIS);
+	if (IS_ERR(glm->shared_gpio))
+		return dev_err_probe(dev, PTR_ERR(glm->shared_gpio),
+				     "could not get shared-gpio\n");
+
+	ret = gpiod_direction_input(glm->shared_gpio);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not set shared gpio as input\n");
+
+	ret = device_property_read_u32_array(dev, "gpio-line-mux-states",
+					     &glm->gpio_mux_states[0], ngpio);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not get mux states\n");
+
+	ret = devm_gpiochip_add_data(dev, &glm->gc, glm);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add gpiochip\n");
+
+	return 0;
+}
+
+static const struct of_device_id gpio_lmux_of_match[] = {
+	{ .compatible = "gpio-line-mux" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gpio_lmux_of_match);
+
+static struct platform_driver gpio_lmux_driver = {
+	.driver = {
+		.name = "gpio-line-mux",
+		.of_match_table = gpio_lmux_of_match,
+	},
+	.probe = gpio_lmux_probe,
+};
+module_platform_driver(gpio_lmux_driver);
+
+MODULE_AUTHOR("Jonas Jelonek <jelonek.jonas@gmail.com>");
+MODULE_DESCRIPTION("GPIO line mux driver");
+MODULE_LICENSE("GPL");
-- 
2.48.1


