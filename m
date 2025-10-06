Return-Path: <linux-kernel+bounces-842982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8EFBBE1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E13D1886FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17903287505;
	Mon,  6 Oct 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="y758cxIC"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEAC2874FB
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755652; cv=none; b=lOgN2M8xyWXHN3E3Biq6HgjTK5onhYZVsW8n9ucsh1Mic8pFKJzNXVPS41f/ANc02vhlFMU7uxjjRRHN1SDMGXzPuexdR8DOjRE9WjQzPjK7KpqUvGYCGKOifyVGLAxX2Upn/XCS+o7Q3Sutk2/G00Vv/hgAAvaWW/Ve9xqMBVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755652; c=relaxed/simple;
	bh=+JKWx7l/NGPc9FMlvYOUnFzEo+vds2fhGntk/7dxXpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OpycLOf8AE7rqSIWKC/JiQXZo0Vus1DqLbIwcFNpXgveYyEfLLO940PcAHarIti29291co3qg0NNo9K0+VXOQXXSxD5E882aQw7LX6ABtwgzBAplcTKHIRduT1OKFwSFijv5Cwy7rOSD2TrRT1dVxxETa05qqZOg1kp/oyvC8r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=y758cxIC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so43780075e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759755648; x=1760360448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVJyVOFkJy3oLbXktrQuphyyROzCpxmHBAoz+N8Ld0Q=;
        b=y758cxICsCIyMiTxXZkjLiojKK1A5P/vRAVtXN4oYs70RqIIwYBVzE0pYHlj1JfFlQ
         YW+pv3xcbFmwxm+ZsfzA1FmycOi+aqXoJxoEEVJNMrbmbNomXhEEZ68BIuvM1WvmhbeY
         NmLofOQnYyfsGJZvr9LqM5N4e1HM2i3+oC0prAcpz2NtXGAVfJETxBQZwgXBvvIStTcx
         jn5ABqJY7Juwj8yEw38ljV1yxjDFTrAVvfE7d1Lvh1qVy9NI6uyYcJzf1hAUbeBWxc+T
         z5mxAdB23KavtNxqF/+88J3XY1ibkatmcQ/naaFs77nrHLkyjB5I48OdZBTjyH2VE7Zb
         D6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759755648; x=1760360448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVJyVOFkJy3oLbXktrQuphyyROzCpxmHBAoz+N8Ld0Q=;
        b=K25joNJ7vU77FvGQPOyO+zn+bcyaaw/D0B5M2ljajG85vsYp7HxqgKG0G3K20AL58V
         hmE2mT95hTLvrTiOcswv0hqB0GR+Zsdc29rafvDZ6RQp2Y6pLZT6A10yk7jVDqzddVGm
         8vYLL2htSfuGXSwZMY7JLmtzMVdBeq6D27dZK6trDgG32HQL0Pl8UdTK5tLTnWZqo2g4
         ejiEFGjoIXqvFAP40b0GxpvIqIfd9Bes5puIUT8A0s8RRmR4TlCbpcGbgfOw3GlMdGiH
         Tud0UlHfiz05l7x6vqd4vrxp+TzQJ1Xpc42MQh9onmvBFFJOWkrauH2FNZe+Ci2Oyc+f
         xWZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuZE5zJNHLtrAaukLZ2Imi+mOEnanpXxSUb2ASE1WK8qcJQ0sngqLulFqTwikCcINhpL5b9hfSwSQmbio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UIOME4wRtX/E8167006B/+4ozw8vOhhSNUk50s78Nd8bp+ZY
	bgMVLfc/l5bfV9P11VVidV3Wg6PFbWPi22vAgM1JwKEKYooPHKcNPYl19KPlypPIfsg=
X-Gm-Gg: ASbGncsZ2UpZGXXs4k9tbKgrszTIwREIWeyE33URWjv7b1vmxm7pQH8j+IJ3+RWD8II
	jKcNeNE2VpRHtaIO9gEocQOVXNxk8qggRJ/QAEmX+L4a/9JAWzgONJ0WX7iZabCtgUiwXyyK6tV
	KDtVs8NinHgNkCTmd93XgFf4RnDQEWiWjrOipvVB7VtuRJ/H3cBuYAWIiyNRf3Yrl5pEfIadW21
	SbSIYq8D23PpUnPPG+MC7c0oUVdyDDPXpKXo6mS79fkReIA1DB6agVFx/Uv/5KNZpb78bOjLYR4
	LNBCLQxtPgZdb48w7e8aHvZrlDzwjb53+mxhGSvcXmnbe20HTbxyKuIIDT8tXxEffJfopvOvUfK
	50eXtSG87mcO+49H+mdNNAALU0xuWt3KgSqirWXSwkDMSO/tL6A7Sf8d6gMAipt4=
X-Google-Smtp-Source: AGHT+IFlCtvcNUI7/9UCDYySnsA2ln8tnjyIuGxNS6pmkEEAPUcuxt4MMplcSTveGNvJxMUSaSAp9A==
X-Received: by 2002:a05:600c:8b83:b0:45b:8adf:cf2b with SMTP id 5b1f17b1804b1-46e71142e6fmr77497045e9.21.1759755648455;
        Mon, 06 Oct 2025 06:00:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ed2b:276f:1a72:aac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b86e1sm249725965e9.5.2025.10.06.06.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:00:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 06 Oct 2025 15:00:23 +0200
Subject: [PATCH 8/9] reset: gpio: convert the driver to using the auxiliary
 bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-reset-gpios-swnodes-v1-8-6d3325b9af42@linaro.org>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
In-Reply-To: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4980;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=e1WjM0ZFklLnJ17T2rheOhCBlqmI5B5UMpfU921B1x0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo471xNzeVNqTbZtwqmv6yknmoSEVvaZo52odAH
 xQbrrKmzMSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOO9cQAKCRARpy6gFHHX
 chOUEACgXCqiQjC+EWfJWYzYmL6O74m50iWj9aNOxM0bc87M1tYLvyTo4Pd4cNZP2mXjFPAkzOF
 rAG8GpV01eZeOerDxqHjc8pcLg4f1wbW9BlCLpQV03FnozcsKpyqu1EEjkySnQb7AqWge5QNcyn
 mPW4Pg54HTgh+v505ks0+TmzDnZyqDDpUK/oAYW9MoKoyM9+4IVStXepYAzEEA7X4Xk0Gc9VCS1
 D8PZV0t3eNzZLnN+m1zbRnn+DefsMdGuLwLr9yFUXpCjzv3r6Ny3deO/3VaYav9IgX3pLJT0EOJ
 SSYFpyV1Bf0ygUJoHvhUHuSnqFyqJS+GDwbv5l62Dp8Fh6CnRiHmtua29Oh7acLtoN9Dk2xKamG
 5jRz5o2ctXL1SsJkIyJDpMSEmdTWrcwJtHYsdt7B7YeH3NAneMfmTPdlvYAjAec5JfBOZUn1iG+
 2wM2ADVAL8js9AsLhcHYYqfKBfcVWjaHXt+RnqdbZU8l3Zkr0LuHCAwK1DyHB0phhtClaRIZxA/
 IoOYToEAg8BBLu4q9dTVvssuvXaLC26kirvnxnGm5xTzvPYGeOLcN2isH7hH5Eqg1eFm8p6hnGc
 xj9LcccT9h5S0APZf9tUSbeqQVJ/aMRrlq/5GwHCDMwBK6qSAPpJ53QVS2YLw/kzzd21tC03qJs
 0XYM8rvZEulPXCg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the reset-gpio devices are purely virtual and never instantiated from
real firmware nodes, let's convert the driver to using the - more
fitting - auxiliary bus.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/Kconfig      |  1 +
 drivers/reset/core.c       | 14 ++++++--------
 drivers/reset/reset-gpio.c | 19 ++++++++++---------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 3102f5d7a93690f262722733e475b1215f61051c..24c9048cc7a31d3a6c9fb9af0726a8387bb3154a 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -89,6 +89,7 @@ config RESET_EYEQ
 config RESET_GPIO
 	tristate "GPIO reset controller"
 	depends on GPIOLIB
+	select AUXILIARY_BUS
 	help
 	  This enables a generic reset controller for resets attached via
 	  GPIOs.  Typically for OF platforms this driver expects "reset-gpios"
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index ad85ddc8dd9fcf8b512cb09168586e0afca257f1..c9f13020ca3a7b9273488497a7d4240d0af762b0 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -7,6 +7,7 @@
 
 #include <linux/acpi.h>
 #include <linux/atomic.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -18,7 +19,6 @@
 #include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
@@ -882,7 +882,7 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
 	if (!lookup)
 		return -ENOMEM;
 
-	lookup->dev_id = kasprintf(GFP_KERNEL, "reset-gpio.%d", id);
+	lookup->dev_id = kasprintf(GFP_KERNEL, "reset.gpio.%d", id);
 	if (!lookup->dev_id)
 		return -ENOMEM;
 
@@ -903,7 +903,7 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
 static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 {
 	struct reset_gpio_lookup *rgpio_dev;
-	struct platform_device *pdev;
+	struct auxiliary_device *adev;
 	int id, ret;
 
 	/*
@@ -959,11 +959,9 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 * Hold reference as long as rgpio_dev memory is valid.
 	 */
 	of_node_get(rgpio_dev->of_args.np);
-	pdev = platform_device_register_data(gpio_device_to_device(gdev),
-					     "reset-gpio", id,
-					     &rgpio_dev->of_args,
-					     sizeof(rgpio_dev->of_args));
-	ret = PTR_ERR_OR_ZERO(pdev);
+	adev = auxiliary_device_create(gpio_device_to_device(gdev), "reset",
+				       "gpio", &rgpio_dev->of_args, id);
+	ret = PTR_ERR_OR_ZERO(adev);
 	if (ret)
 		goto err_put;
 
diff --git a/drivers/reset/reset-gpio.c b/drivers/reset/reset-gpio.c
index 2290b25b6703536f2245f15cab870bd7092d3453..7b43d61d0467aef5fbbad53d531294fa62f8084a 100644
--- a/drivers/reset/reset-gpio.c
+++ b/drivers/reset/reset-gpio.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/auxiliary_bus.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 
 struct reset_gpio_priv {
@@ -61,9 +61,10 @@ static void reset_gpio_of_node_put(void *data)
 	of_node_put(data);
 }
 
-static int reset_gpio_probe(struct platform_device *pdev)
+static int reset_gpio_probe(struct auxiliary_device *adev,
+			    const struct auxiliary_device_id *id)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = &adev->dev;
 	struct of_phandle_args *platdata = dev_get_platdata(dev);
 	struct reset_gpio_priv *priv;
 	int ret;
@@ -75,7 +76,7 @@ static int reset_gpio_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, &priv->rc);
+	auxiliary_set_drvdata(adev, &priv->rc);
 
 	priv->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->reset))
@@ -99,20 +100,20 @@ static int reset_gpio_probe(struct platform_device *pdev)
 	return devm_reset_controller_register(dev, &priv->rc);
 }
 
-static const struct platform_device_id reset_gpio_ids[] = {
-	{ .name = "reset-gpio", },
+static const struct auxiliary_device_id reset_gpio_ids[] = {
+	{ .name = "reset.gpio", },
 	{}
 };
-MODULE_DEVICE_TABLE(platform, reset_gpio_ids);
+MODULE_DEVICE_TABLE(auxiliary, reset_gpio_ids);
 
-static struct platform_driver reset_gpio_driver = {
+static struct auxiliary_driver reset_gpio_driver = {
 	.probe		= reset_gpio_probe,
 	.id_table	= reset_gpio_ids,
 	.driver	= {
 		.name = "reset-gpio",
 	},
 };
-module_platform_driver(reset_gpio_driver);
+module_auxiliary_driver(reset_gpio_driver);
 
 MODULE_AUTHOR("Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>");
 MODULE_DESCRIPTION("Generic GPIO reset driver");

-- 
2.48.1


