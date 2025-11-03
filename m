Return-Path: <linux-kernel+bounces-882576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0FBC2AC9F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91164343BD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF5E2F3608;
	Mon,  3 Nov 2025 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VVzmBMrX"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41912EF64F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162557; cv=none; b=a6yQYrfrgW2ws1m82RPYfdTCMhV+nYo8x8O8YkNIOjoKLhNeGSDI8brjZOJD1dmcemsVm1wEcSPaNKmEPLxJdaLWDk5Homjg+ebeSQdw5saRJKjXjNdKDS6ERmeE/RFDpmoeNYJ/l6gkhkjS0eRVRkBH2Fnx0WmWrQ2tUggWCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162557; c=relaxed/simple;
	bh=RblnhEgjT1ATQCpBOT39uE2nJPA2rhEO7IRHMN8Quh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qaH8n9WVZw+oGIpoE/PksmPEAIUH5L0di+BniEjPllzkxvOiVYa9fuwPgWvENSZasqA/ls/Aqj511gULF8weqiAhSCQNSIT6dueWiyDaZbEr9LnhhpWeo76V6Kytb9D3e+NpMwIkbx6aJBYXGtssGEFJS6BYFS4/TXBdCprxjYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VVzmBMrX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475dc0ed8aeso28315805e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762162553; x=1762767353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRbag5R4phUt0lvwmog2563w0RmrCN5eKMWnzPULmkg=;
        b=VVzmBMrXKFNBxkGpEXeesiRaURlqJTyFd3tsqzmu2PrGdwislc3oqnsSmhb8sMduuh
         iG7VtJvVXJc4l3CKYqu62ZSJE8rfNVdL2o1yKfrI5Swn6WLkfR6kO5euDuA4qjTkVJ8H
         gqPCOwe1Oz61cudA74lTvuzak4dJV4fPj6d1Zc5zvcXivjAYl2csZqLCECffJ2F+mN08
         M2BXWksu4XVucZ5NnuwWEHjbn/lBqD9DrpMGFNVvmIrr/iVXhsCSMifmTbzmHZovBwvc
         bKrIy9GdIOd3yI+069hHUGdhO3mn+63xHidj/xvXdwTRGXhSUUUTp62xJ+jTfvF/JEQ0
         j7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162553; x=1762767353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRbag5R4phUt0lvwmog2563w0RmrCN5eKMWnzPULmkg=;
        b=dPT1QycSkSwvscN75BX0ov661J2/4Mcs8NPmZqdbnlA1VuL/1Ne1aHh9dR4hPe7iMZ
         uRcEcXLF2G5pSMdpFVzFpEsxNwVRKb/VbTkMBSnYCjoJeY4GuKrTmYsh8pz1jfOCnSdz
         hLjhKD1T+v5lbNsU/xuTFtmc4tlAlR1ZmzKfv37EdWRZfFSX9khi836B6dyR5VI0h+hm
         Hjm8TDPLmIMbZ70Hf1/aKjqURSFMuksPNWhsopMWCmK9Jmlc6yroKHOo4M7Jan+7+GMe
         PgQNZt7UAAvd8zguDMOH2HG+KfPChxFChOgeDdpEyJjK+8SnzNvPxtgfvrEFVqlgNjsl
         sfSA==
X-Forwarded-Encrypted: i=1; AJvYcCX5M7S5lbJc5HzCNEuEVJhjIVc7WqZlCrm88/4MNUx0ZNxubo23NvKgfN+VW9CFrjLlyiWVJ5bLKmbiaz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3+vbwOOHjFf79FPzii3/WUctR6CzjluJ91JFHUKo6cwZDroQi
	eL/8dV290fgPFznLhChmQGxgJT6askbnyk9eiM0dO+XHVfwVwRVfDn3g0sAgfnX1Sgc=
X-Gm-Gg: ASbGncu+eSUR7+WDmt0h3teLISlwLLoxBTs0L7QF3Rs7L3rhUFAWKR8ycEbkev8/9Rk
	gtI+6d1+krpLe1HnbqrrQ5GxfGi0uUQz0xdLw4sK+0sYz1TOZACTJ+SkC/ZSbJKFOItXud8G9zB
	CUgTvwVYI7u8Rr+cTq7qr3XaCZWua+vhtr8LnVrxj61D2CI1tEpvqPLu/C3Dc3yj1BrsGCDvMT+
	IyPWe5e8myVUl9udhi8RdOuLpqJa31On8oxDVReAqWV7yqKdhfjyK8B9nc1Vae3C7u9yhaPG9VL
	xHP/5pm+RRc0KA0uWdIx1EOlZVYsUOtP6T7yVrTKIrFNEqW1K5D4kZ162gYfuJW0RtWn5PB72v7
	qARWyfy4/tqboY8uifVwlkfnRzDWF+1HJL/0cjECFTZyZZexbF4sAGoErNU6VhR+4S6wU2A==
X-Google-Smtp-Source: AGHT+IGcBGJiBYkfwUV9lZhAdhNnSzM/sLW3NyAe2T/Y3BWamsfkik9AHrtyKCRLE2J8iwil2VteUQ==
X-Received: by 2002:a05:600c:3e83:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-477308a4e55mr132233595e9.34.1762162552839;
        Mon, 03 Nov 2025 01:35:52 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac5d6sm147285675e9.8.2025.11.03.01.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:35:51 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Nov 2025 10:35:29 +0100
Subject: [PATCH v4 09/10] reset: gpio: convert the driver to using the
 auxiliary bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-reset-gpios-swnodes-v4-9-6461800b6775@linaro.org>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
In-Reply-To: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5084;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=f8XqWT6MV/Vm24ULyDMORR+Vw3utb1iWh132/5v3Ubw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCHdmPmpYf5eSE2EDR5bRdNl8PV7hR7lqj5JG/
 m619oHMrWCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQh3ZgAKCRARpy6gFHHX
 cuwbEACDF5Jr0z6W5lq1RUEfOpSd0yY7UaQ3FuLmI2Aj43N+1KOIZp8OhlCAbuPorGt6kVlyeuI
 0K8Jg6QftQ5v0MieQz8i5knxmkSKjH+grjHf85mzTzgymQooIrc8thq3FCrbHQp/4UN2hh42nOO
 AWAbHgQorq3/7VZeMBO5Q26ATV0I9ilWbMX1f6N7J+FX0UUCOzxRiyMP1Rbf+4Z1Vhe2dT/CYfh
 ZTU5lYz3qobQAOgPoIRC/c5Dft/hxk2518Dz/JpK3YJZnsgHc6/WjU2cGyhOsGxVh3ADQP9SUBQ
 fRZN/fzFOImUkS+G0RcLob5lUx2D4mDcXULsIqFZe6PsGvtzqWwYqq1sES1rYkPV1xzechTICHi
 KWJRE2fAEr+7d4r7K2RHPJLIfQmKbJ2rJQrpU2xmc2b4kfa9Y3leH4LMiAhY4aD9hoBLQCdM8S6
 Q/ZJ10xxY8mBumJrjDiSq3RW5xMRb4aX5GS9HRGsDkdTiEr4nhz6vO/asjcgAzF5kCVroIMpA2B
 6kVHgDy1agMSIM8LtvDO8717WIIooqlYTX4dbLtZSBChvgQCExfDsAmzchAOGXW9Y9xoEfWBoOP
 DCMs4RWgExNsWZGUcSDVtUfEIYJlPumnq3kYUjrE7huzbxxfPTn6Ase5T2lQ6PKc9LX3fzjThmf
 h4ELWWlC1oYKWxw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the reset-gpio devices are purely virtual and never instantiated from
real firmware nodes, let's convert the driver to using the - more
fitting - auxiliary bus.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/Kconfig      |  1 +
 drivers/reset/core.c       | 14 ++++++--------
 drivers/reset/reset-gpio.c | 19 ++++++++++---------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 67ca87c9a86ecdbd41cbd3397d2a0c9921227eef..26c8efce0394b238691e87b04087b3d705bfadb0 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -99,6 +99,7 @@ config RESET_EYEQ
 config RESET_GPIO
 	tristate "GPIO reset controller"
 	depends on GPIOLIB
+	select AUXILIARY_BUS
 	help
 	  This enables a generic reset controller for resets attached via
 	  GPIOs.  Typically for OF platforms this driver expects "reset-gpios"
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index af42f4d12bbbfcba225219eac6d6c7edbe2405cc..fcf1c24086e565015b0956fdd40334274a1edb00 100644
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
@@ -855,7 +855,7 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
 	if (!lookup)
 		return -ENOMEM;
 
-	lookup->dev_id = kasprintf(GFP_KERNEL, "reset-gpio.%d", id);
+	lookup->dev_id = kasprintf(GFP_KERNEL, "reset.gpio.%d", id);
 	if (!lookup->dev_id)
 		return -ENOMEM;
 
@@ -876,7 +876,7 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
 static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 {
 	struct reset_gpio_lookup *rgpio_dev;
-	struct platform_device *pdev;
+	struct auxiliary_device *adev;
 	int id, ret;
 
 	/*
@@ -932,11 +932,9 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
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
index 2290b25b6703536f2245f15cab870bd7092d3453..e5512b3b596b5290af20e5fdd99a38f81e670d2b 100644
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
+	{ .name = "reset.gpio" },
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
2.51.0


