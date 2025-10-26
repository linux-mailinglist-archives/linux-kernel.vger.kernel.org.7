Return-Path: <linux-kernel+bounces-870682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3971C0B71A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CAE84EE40E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B9A301472;
	Sun, 26 Oct 2025 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYBs0RWD"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3713009F1
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761520704; cv=none; b=IP/fv09Uaa791adGAdYAS42hCG/aW4XqgVs3E9zE7sagYBNOQgWZAJjEBOvuog/Nu8/xV2EJbJHxLrUcZmWWlDcw/nAE3k+O/R0tMDX0vpLRaRZXllsVXlaCWIGbAT4Uyod5FbBOwutoJ+2Ftc2L0TPFTwHYS1djsaJw0a9toB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761520704; c=relaxed/simple;
	bh=7yeFvsm7y+OcP+6YYa2T6lB+IhTPTeupClFiL+f5Hoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhOXM+hict5emWmHN3vSGPmL9JL3YdojtgWgiGAZnUg7kLao+Ei38A+y0AoRU7W53hnk0yLgaKp9GNtnLxvTSNb0pBGthxh9P+amBrj4MUNGQKF/oOvLPxmjeka1J7ms/Qgb3m9eNQHfrK22ZVq2XtcmU2SowWQ91cF/xEQ1UpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYBs0RWD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63e0cec110eso6708212a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761520700; x=1762125500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiCHn54lzDQaN7TwQ+Eqf6Al/yn9V8tvKFsvfsxpy+0=;
        b=QYBs0RWD6rJVQnDUVOEt8SYz1sErz6Ec+/oBZrRLbDuqj74wJHUW7VKsHpVcDx2+Iu
         WJmQ3/mNiE7dXef0l5G4Aiy89JTaUrAX12+aQYW0ODqOe7m2zxRNJAQMlCQTToOFKgQk
         no8qnQZLpnnr9NqVGO9d2d0LN+d5g/Amj4mb6a47uLHbl7O9pCDFT7gut+SLE5CENXAN
         biC2Mitd3HFefn6Hb92H1SgcmwRwE1L8D1fUSgZjJBzI58d3jQTOLj8iHyNyYbIvL42N
         0UXDEYTzZhP/naOoLgwlSg1bHTImj/UeqIUDK8cmk4VQd0RCORnfh1M/U8QdjI5kZICG
         gbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761520700; x=1762125500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiCHn54lzDQaN7TwQ+Eqf6Al/yn9V8tvKFsvfsxpy+0=;
        b=XaaEocnxx4lfunHzSYIY++sNiInxOyn6bBhk2GoILX21j1+WaoQ7SS27OngDxogM4D
         Kd/Xu+TpMY/Kjjffl06d6v7lTsEBIgvy6Klpdnjxso6ASt02Wb6vQy5JkHZAIMkECme/
         PmhVctokUxnxPlA9CL0CuWqjaNSoWeQcd81TDmY81zW6V67YVdQfpwvYHx6UlfAWW8As
         SqpH1bSAR7Es0g36jpNp0TvetBD+8FiPYO/IQLafO8bk6dSNGx4u1VRYlRaDPevFSRK9
         sm15w0LFWWktYqnLf9MYBtL+DZ0qLEcZGz6deR+jKTippT35Y7/zSwhNXrAXBX45zQ/F
         AYMg==
X-Forwarded-Encrypted: i=1; AJvYcCURtyK3P5/qusbHxaFvXIFxIo2C3g2mpoBGvTX/OmyxmstEzWT96wBUGnZrXvvEYDXfRMnr1OXxT8raS1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBF3SJ7lkea/hFxT00lBJ9ZFVCqoTKNEUigH0KUQCGNnsx+hz
	AcIIFGxNIqt04KIIgLE15I9O4cPdwfRIsIwii01jK9uTCtXdn+UImRMV
X-Gm-Gg: ASbGnctTy0zQXaOQU3FmmC7D/N31ng/8nrolS8ykT/vYxqUnCWwv8Djg8fL30IZDIFX
	oOleBvMBkPX6ZvAucW/ctNQpBYPLws2T0yTDXX1kTEWG2b2mclec6rUdOlNf6DRhZMK0oxIErsu
	mRmnp3YjLQ+znmzCAsUSUu0Zsel/lSvNzNkNc5rnOGZtSN2nog1oByIcTj5wjcNr7WfOwo930c9
	raOHoyM7GAtK5vkgc/mZelY2yEwb+eyasCllwy33VMJr0Xg2ie6ide2AWjrrt6kXNN2CC/XzCuz
	DvhKN+XQykIHjgSDTrtSk7ExLbZMdFT971zXFcK6Dvm/Ck3AOD8afLdm0VMhirNx7JOvQ5sXifR
	d3SG+Ckz/uTJks1uDRkxhHpmwgAAgrTFqaDR4xxESjCKTczbrws0mqswzV09yENgTntziZUaCTS
	uCZ3Z8toH5kreWSw==
X-Google-Smtp-Source: AGHT+IGfSBAx7rKJ9rbLheLMuPNvx1uHbgzNIQmoW7B3qNuSzrLIBkDJXf+4XG6YFt6PUK/mSLJtnw==
X-Received: by 2002:a05:6402:2791:b0:63e:23c0:c33e with SMTP id 4fb4d7f45d1cf-63e23c0c43amr15741859a12.27.1761520700268;
        Sun, 26 Oct 2025 16:18:20 -0700 (PDT)
Received: from builder.. ([2001:9e8:f109:5716:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef82865sm4847379a12.9.2025.10.26.16.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 16:18:19 -0700 (PDT)
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
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH v2 2/2] gpio: add gpio-line-mux driver
Date: Sun, 26 Oct 2025 23:17:54 +0000
Message-ID: <20251026231754.2368904-3-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251026231754.2368904-1-jelonek.jonas@gmail.com>
References: <20251026231754.2368904-1-jelonek.jonas@gmail.com>
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

For now, this doesn't support advanced features like IRQs, just normal
IN and OUT functionality of GPIOs.

This can help in various usecases. One practical case is the special
hardware design of the Realtek-based XS1930-10 switch from Zyxel. It
features two SFP+ ports/cages whose signals are wired to directly to the
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

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 MAINTAINERS                  |   6 ++
 drivers/gpio/Kconfig         |  10 ++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-line-mux.c | 194 +++++++++++++++++++++++++++++++++++
 4 files changed, 211 insertions(+)
 create mode 100644 drivers/gpio/gpio-line-mux.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..4d75253fe451 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10647,6 +10647,12 @@ S:	Maintained
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
index ce237398fa00..93695b86a955 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1986,6 +1986,16 @@ config GPIO_LATCH
 	  Say yes here to enable a driver for GPIO multiplexers based on latches
 	  connected to other GPIOs.
 
+config GPIO_LINE_MUX
+	tristate "GPIO line mux driver"
+	depends on OF_GPIO
+	select GPIO_AGGREGATOR
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
index 000000000000..a367e8f585c6
--- /dev/null
+++ b/drivers/gpio/gpio-line-mux.c
@@ -0,0 +1,194 @@
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
+#include <linux/mux/driver.h>
+#include <linux/platform_device.h>
+
+struct gpio_lmux {
+	struct gpio_chip gc;
+	struct mux_control *mux;
+	struct device *dev;
+
+	struct mutex lock;
+
+	struct gpio_desc *shared_gpio;
+	/* dynamically sized, must be last */
+	unsigned int gpio_mux_states[];
+};
+
+DEFINE_GUARD(gpio_lmux, struct gpio_lmux *, mutex_lock(&_T->lock), mutex_unlock(&_T->lock))
+
+static int gpio_lmux_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_lmux *glm = (struct gpio_lmux *)gpiochip_get_data(gc);
+	int ret;
+
+	if (offset > gc->ngpio)
+		return -EINVAL;
+
+	guard(gpio_lmux)(glm);
+
+	ret = mux_control_select(glm->mux, glm->gpio_mux_states[offset]);
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
+	struct gpio_lmux *glm = (struct gpio_lmux *)gpiochip_get_data(gc);
+	int ret;
+
+	if (offset > gc->ngpio)
+		return -EINVAL;
+
+	guard(gpio_lmux)(glm);
+
+	ret = mux_control_select(glm->mux, glm->gpio_mux_states[offset]);
+	if (ret < 0)
+		return ret;
+
+	gpiod_set_raw_value_cansleep(glm->shared_gpio, value);
+	mux_control_deselect(glm->mux);
+	return 0;
+}
+
+static int gpio_lmux_gpio_get_direction(struct gpio_chip *gc,
+					unsigned int offset)
+{
+	struct gpio_lmux *glm = (struct gpio_lmux *)gpiochip_get_data(gc);
+
+	if (offset > gc->ngpio)
+		return -EINVAL;
+
+	guard(gpio_lmux)(glm);
+
+	return gpiod_get_direction(glm->shared_gpio);
+}
+
+static int gpio_lmux_gpio_direction_input(struct gpio_chip *gc,
+					  unsigned int offset)
+{
+	struct gpio_lmux *glm = (struct gpio_lmux *)gpiochip_get_data(gc);
+
+	if (offset > gc->ngpio)
+		return -EINVAL;
+
+	guard(gpio_lmux)(glm);
+
+	return gpiod_direction_input(glm->shared_gpio);
+}
+
+static int gpio_lmux_gpio_direction_output(struct gpio_chip *gc,
+					   unsigned int offset, int value)
+{
+	struct gpio_lmux *glm = (struct gpio_lmux *)gpiochip_get_data(gc);
+
+	if (offset > gc->ngpio)
+		return -EINVAL;
+
+	guard(gpio_lmux)(glm);
+
+	return gpiod_direction_output_raw(glm->shared_gpio, value);
+}
+
+static int gpio_lmux_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct gpio_lmux *glm;
+	unsigned int ngpio, size;
+	int ret;
+
+	ngpio = device_property_count_u32(dev, "gpio-line-mux-states");
+	if (!ngpio)
+		return -EINVAL;
+
+	size = sizeof(*glm) + (sizeof(unsigned int) * ngpio);
+	glm = devm_kzalloc(dev, size, GFP_KERNEL);
+	if (!glm)
+		return -ENOMEM;
+
+	mutex_init(&glm->lock);
+
+	glm->dev = dev;
+	glm->gc.base = -1;
+	glm->gc.can_sleep = true;
+	glm->gc.fwnode = dev_fwnode(dev);
+	glm->gc.label = "gpio-line-mux";
+	glm->gc.ngpio = ngpio;
+	glm->gc.owner = THIS_MODULE;
+	glm->gc.parent = dev;
+
+	glm->gc.get = gpio_lmux_gpio_get;
+	glm->gc.set = gpio_lmux_gpio_set;
+	glm->gc.get_direction = gpio_lmux_gpio_get_direction;
+	glm->gc.direction_input = gpio_lmux_gpio_direction_input;
+	glm->gc.direction_output = gpio_lmux_gpio_direction_output;
+
+	glm->mux = devm_mux_control_get(dev, NULL);
+	if (IS_ERR(glm->mux)) {
+		if (PTR_ERR(glm->mux) == -EPROBE_DEFER) {
+			dev_err(dev, "mux-controller not ready, deferring probe\n");
+			return -EPROBE_DEFER;
+		}
+
+		dev_err(dev, "could not get mux-controller\n");
+		return PTR_ERR(glm->mux);
+	}
+
+	glm->shared_gpio = devm_gpiod_get(dev, "shared", GPIOD_ASIS);
+	if (IS_ERR(glm->shared_gpio)) {
+		dev_err(dev, "could not get shared-gpio\n");
+		return PTR_ERR(glm->shared_gpio);
+	}
+
+	ret = device_property_read_u32_array(dev, "gpio-line-mux-states",
+					     &glm->gpio_mux_states[0], ngpio);
+	if (ret) {
+		dev_err(dev, "could not get mux states\n");
+		return ret;
+	}
+		
+	ret = devm_gpiochip_add_data(dev, &glm->gc, glm);
+	if (ret) {
+		dev_err(dev, "failed to add gpiochip: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(dev, "providing %u virtual GPIOs for real GPIO %u\n", ngpio,
+		 desc_to_gpio(glm->shared_gpio));
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


