Return-Path: <linux-kernel+bounces-865058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC4BFC24F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D65E4F41D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E334A791;
	Wed, 22 Oct 2025 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="n6FhFHt3"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4CC348877
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138673; cv=none; b=W4LndFAv/WWg5mN9eZL5zH8pflSwuLlaYYC5bZwZZNkgLSoFeeiK9FMKlxlneBwyHPwJt1XPPdsbSRYHbt9rwU3QRI6o2Hm9UOGDjChpDVevqfSrs+80p0qdVzLTbHSOlWenADhmr2C+35390p6UGXJ2PABJkoXY1AXnGcEj/+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138673; c=relaxed/simple;
	bh=PEW5VfmwKxTEd1s5F2KY5fqrtDh/1gqVWns6m/YBKno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9qNy2H7grvJFEhfoc3VoNbpr5/WmsSAGgKJXq3j9/2kQfPa45+xz4KjuGnKu0dktlqwHtfagMfKOlAJDMM8u/VLPxOL96dkwrmXjzroFUQR4GtZoECHXpUMXUECi6bn/xrFHg0C6Wgc5PHHK3jGYdy6UfqZsyJbaUfWUehHkSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=n6FhFHt3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47118259fd8so43227255e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761138669; x=1761743469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxefnDuFAgbuOWtzWxnGFUx9Bz27z/Zir2kMC7KD/PA=;
        b=n6FhFHt3Tlqr3H6IKDiXhw9YkNDLw6RCx2+0KUNbqMwbL65o69srHgkicovhebXStE
         LlNvWkm7nr+jAudPSklFyHimuaIih2a0gnqxNG+yjpxhgK4Kn/HFMDNBlVyAYBfLgDQM
         6UsT3t0kIWwM0SvxE9rdYf3ynon0NKarn5lBmKF8M386XzgF5WOpWPLrrXtVk0avQ7Z1
         gcRQMhbjD9yUsBkQnoq6fN6Ow/sea7BJuvMixtK1VCeOamuYHslDvYHwjKmwr4XLTj9C
         EDef+XcAY6ZUUiJanc2HavqQtk/edg8M5IozUc5InO47kFGJEH/u7XQmIeIZk+lTh4xk
         TiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138669; x=1761743469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxefnDuFAgbuOWtzWxnGFUx9Bz27z/Zir2kMC7KD/PA=;
        b=MAQ4VHXeCKrJTfkCdvHwye4t1AvG/+Kv3Y4+ugztLCrpbbrgKkTzND13LQIE5n6vzB
         OOqfhBbbNKZlrEzhQn369p6TKGl8PR2UQftiv8Q9WNrdP9HBkCW0HCKRTdWY0G+FrAGP
         rmHBshaQ9ff9RzBnjlj76SXUEKvX+OJFW+4foLqzTFKcNsbIKQ7pXFQ+Bjgf6wMQDtpE
         KUjguWpQ7M7R5Z5NqN2ADR4dC4U/oPG5oFTq4bF2+aLWmbTmXzckZPG1JxyWIwK43Occ
         gZ6Sj2uKnMHdU0o/6ouN3S7Ztju6vAwL9QNrCoXwu36vd+9sIGHRKfvE2mTBN9crou9y
         7Dxg==
X-Forwarded-Encrypted: i=1; AJvYcCUB7Fybf1YRdxq5ilt9TIizq5jNl9GzfnHR2yIPtuY+hUAHCxsb2ujcbBwYC4EDsn2+oNTX+MrYkNmaJxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKRem3szavTaH8W43FnNPJreLlTUhCkyVLESNbuS5qNDxP9Bmv
	ZXGG+0LAtvXv65QgvQi827EHnplGlWPCTuJ5PbQ5jr6vCKpplz/leJmHb1JQRUv/5hI=
X-Gm-Gg: ASbGncvYrQGH5StMF4GEcJQzbJ9vKhwOcjiMh3LQuvUZcQMQNl+loSfN8Pnr9hwnW0k
	JLgZQhQNm2uqSJOrJZh8Q1FKWhmWVyuAO/nOVDDw7wDrpsmAa8ov4iiNamsJPnW+3MpDYVbRymA
	ZG7ticbCkniqMQ+TCVQ/CIuCvDJiqLOgtKRXK9rVAe9fdVwZA0yuMRAOjoqId9EqxKe6p1yQPTd
	uyKlSRsw/0xEzsY3UxyuA9A9VTm3XgzSPMTw4/PdTVaXwM0SAAcOUeoxDvlujq4BudOPUKLINaX
	hJNojq8PrtGfl3K0pa46sznvo6A66auNYcFt6hAM+cYlJjWie33xo1KeqW2nksIo4i7V0JwvReh
	+0IrlO+fBWTBiYk4pXwId6QxLa9B8/eIEqpvMBt/0NVbBM75sEnRv1NVYmZ12xhxF6qmInZU=
X-Google-Smtp-Source: AGHT+IGwD09QAVGKkMJ5ze7OXZXe7q4kSFTqb0MMW6OeeC8cs5RR1p82ufb6WAVaKR6I6Zzal79dWQ==
X-Received: by 2002:a05:600c:3555:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-4711786d42dmr154030255e9.5.1761138668613;
        Wed, 22 Oct 2025 06:11:08 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm38839905e9.1.2025.10.22.06.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:11:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 15:10:43 +0200
Subject: [PATCH v2 04/10] gpio: shared-proxy: implement the shared GPIO
 proxy driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-gpio-shared-v2-4-d34aa1fbdf06@linaro.org>
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
In-Reply-To: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
To: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11952;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=4uKGAjNhsLa5igkAFf7fdbFeEXJRT/s3+XJIBfGT0lk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo+Nfd3bW7DRvSgrszLV/ABY7xyATTCs546XrvV
 rAnfLXdJpaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPjX3QAKCRARpy6gFHHX
 cpqmD/9i7psfG399MXY3NXK0CHucr13M79HAfxnt7gqJ/YQh6ITnU+nOKoarbi9PqZBhcNbsN1n
 SpnR89KWXZqY55/2CURR2/kXLmxFb+RUi4mbkESeF3tSG4P4xgRpgutOf3En8loLtoKMV38ZZTq
 Ffo280Ikv2yM2JWoc+nqcGml4u3MsPc2YroWYpa7E4jb40ozPrARNO4EsCVtntu2p/ImyFO/311
 QoSrUsfuZqeG0FJAIp9xha+9MS0CUDCcd0ljW2F55jCwftIm/9BGMCCqyV4L1f7kg68JdgNiMF1
 82AzMc4ixjgbHOvcbJOFnpZ0y/5HzE5Ih8NAW0w5ru+J+sZKMVoPxpJrPgpLWPFgdRkPuur054k
 nrqbEj09cNfGEgNc1p9Zm+7/Wod4L1YUfkMyd8pIRDjFIO3ozGv3zaEuOMdCVait/+1C89rSCuB
 p5EVmmcjTeIrJ+CTULGcQAd5JkDZr9BZPaNOZoL4RbRKgqHOjmmhCHbk8tZlZSjYNHHH4TB17J7
 kn/U/lyA0jqbbfK47EXAWBAec85JJWJmSXdBj7I3e+3PaJssEzBokXhSWcVf+2STPTrfEQLNc5P
 4cSGGmaUJwhicADyaht2xcQJ+ZZlfLtMvuCrVWjQD62ra0JLVqRaY1U15IA637/BMGuXn4OYX5E
 pbAMp6FAiLXUiag==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a virtual GPIO proxy driver which arbitrates access to a single
shared GPIO by multiple users. It works together with the core shared
GPIO support from GPIOLIB and functions by acquiring a reference to a
shared GPIO descriptor exposed by gpiolib-shared and making sure that
the state of the GPIO stays consistent.

In general: if there's only one user at the moment: allow it to do
anything as if this was a normal GPIO (in essence: just propagate calls
to the underlying real hardware driver). If there are more users: don't
allow to change the direction set by the initial user, allow to change
configuration options but warn about possible conflicts and finally:
treat the output-high value as a reference counted, logical "GPIO
enabled" setting, meaning: the GPIO value is set to high when the first
user requests it to be high and back to low once the last user stops
"voting" for high.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig             |   9 ++
 drivers/gpio/Makefile            |   1 +
 drivers/gpio/gpio-shared-proxy.c | 329 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 339 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 679a7385a9776eef96a86ca4f429ee83ac939362..de8e4febf344fc19a633cd7efe8412fe12166fb8 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -2025,6 +2025,15 @@ config GPIO_SIM
 	  This enables the GPIO simulator - a configfs-based GPIO testing
 	  driver.
 
+config GPIO_SHARED_PROXY
+	tristate "Proxy driver for non-exclusive GPIOs"
+	default m
+	depends on GPIO_SHARED || COMPILE_TEST
+	select AUXILIARY_BUS
+	help
+	  This enables the GPIO shared proxy driver - an abstraction layer
+	  for GPIO pins that are shared by multiple devices.
+
 endmenu
 
 menu "GPIO Debugging utilities"
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index f702f7e27e5b4017e7eab3019dae4ec912d534f8..d0020bc70b84f6fb9949165070c21725a60f47e2 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -160,6 +160,7 @@ obj-$(CONFIG_ARCH_SA1100)		+= gpio-sa1100.o
 obj-$(CONFIG_GPIO_SAMA5D2_PIOBU)	+= gpio-sama5d2-piobu.o
 obj-$(CONFIG_GPIO_SCH311X)		+= gpio-sch311x.o
 obj-$(CONFIG_GPIO_SCH)			+= gpio-sch.o
+obj-$(CONFIG_GPIO_SHARED_PROXY)		+= gpio-shared-proxy.o
 obj-$(CONFIG_GPIO_SIFIVE)		+= gpio-sifive.o
 obj-$(CONFIG_GPIO_SIM)			+= gpio-sim.o
 obj-$(CONFIG_GPIO_SIOX)			+= gpio-siox.o
diff --git a/drivers/gpio/gpio-shared-proxy.c b/drivers/gpio/gpio-shared-proxy.c
new file mode 100644
index 0000000000000000000000000000000000000000..9b3dd875a5ad9f56ca9d27f6f2246eb854829f1f
--- /dev/null
+++ b/drivers/gpio/gpio-shared-proxy.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Linaro Ltd.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+
+#include "gpiolib-shared.h"
+
+struct gpio_shared_proxy_data {
+	struct gpio_chip gc;
+	struct gpio_shared_desc *shared_desc;
+	struct device *dev;
+	bool voted_high;
+};
+
+static int
+gpio_shared_proxy_set_unlocked(struct gpio_shared_proxy_data *proxy,
+			       int (*set_func)(struct gpio_desc *desc, int value),
+			       int value)
+{
+	struct gpio_shared_desc *shared_desc = proxy->shared_desc;
+	struct gpio_desc *desc = shared_desc->desc;
+	int ret = 0;
+
+	gpio_shared_lockdep_assert(shared_desc);
+
+	if (value) {
+	       /* User wants to set value to high. */
+		if (proxy->voted_high)
+			/* Already voted for high, nothing to do. */
+			goto out;
+
+		/* Haven't voted for high yet. */
+		if (!shared_desc->highcnt) {
+			/*
+			 * Current value is low, need to actually set value
+			 * to high.
+			 */
+			ret = set_func(desc, 1);
+			if (ret)
+				goto out;
+		}
+
+		shared_desc->highcnt++;
+		proxy->voted_high = true;
+
+		goto out;
+	}
+
+	/* Desired value is low. */
+	if (!proxy->voted_high)
+		/* We didn't vote for high, nothing to do. */
+		goto out;
+
+	/* We previously voted for high. */
+	if (shared_desc->highcnt == 1) {
+		/* This is the last remaining vote for high, set value  to low. */
+		ret = set_func(desc, 0);
+		if (ret)
+			goto out;
+	}
+
+	shared_desc->highcnt--;
+	proxy->voted_high = false;
+
+out:
+	if (shared_desc->highcnt)
+		dev_dbg(proxy->dev,
+			"Voted for value '%s', effective value is 'high', number of votes for 'high': %u\n",
+			value ? "high" : "low", shared_desc->highcnt);
+	else
+		dev_dbg(proxy->dev, "Voted for value 'low', effective value is 'low'\n");
+
+	return ret;
+}
+
+static int gpio_shared_proxy_request(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_shared_proxy_data *proxy = gpiochip_get_data(gc);
+	struct gpio_shared_desc *shared_desc = proxy->shared_desc;
+
+	guard(gpio_shared_desc_lock)(shared_desc);
+
+	proxy->shared_desc->usecnt++;
+
+	dev_dbg(proxy->dev, "Shared GPIO requested, number of users: %u\n",
+		proxy->shared_desc->usecnt);
+
+	return 0;
+}
+
+static void gpio_shared_proxy_free(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_shared_proxy_data *proxy = gpiochip_get_data(gc);
+	struct gpio_shared_desc *shared_desc = proxy->shared_desc;
+
+	guard(gpio_shared_desc_lock)(shared_desc);
+
+	proxy->shared_desc->usecnt--;
+
+	dev_dbg(proxy->dev, "Shared GPIO freed, number of users: %u\n",
+		proxy->shared_desc->usecnt);
+}
+
+static int gpio_shared_proxy_set_config(struct gpio_chip *gc,
+					unsigned int offset, unsigned long cfg)
+{
+	struct gpio_shared_proxy_data *proxy = gpiochip_get_data(gc);
+	struct gpio_shared_desc *shared_desc = proxy->shared_desc;
+	struct gpio_desc *desc = shared_desc->desc;
+	int ret;
+
+	guard(gpio_shared_desc_lock)(shared_desc);
+
+	if (shared_desc->usecnt > 1) {
+		if (shared_desc->cfg != cfg) {
+			dev_dbg(proxy->dev,
+				"Shared GPIO's configuration already set, accepting changes but users may conflict!!\n");
+		} else {
+			dev_dbg(proxy->dev, "Equal config requested, nothing to do\n");
+			return 0;
+		}
+	}
+
+	ret = gpiod_set_config(desc, cfg);
+	if (ret && ret != -ENOTSUPP)
+		return ret;
+
+	shared_desc->cfg = cfg;
+	return 0;
+}
+
+static int gpio_shared_proxy_direction_input(struct gpio_chip *gc,
+					     unsigned int offset)
+{
+	struct gpio_shared_proxy_data *proxy = gpiochip_get_data(gc);
+	struct gpio_shared_desc *shared_desc = proxy->shared_desc;
+	struct gpio_desc *desc = shared_desc->desc;
+	int dir;
+
+	guard(gpio_shared_desc_lock)(shared_desc);
+
+	if (shared_desc->usecnt == 1) {
+		dev_dbg(proxy->dev,
+			"Only one user of this shared GPIO, allowing to set direction to input\n");
+
+		return gpiod_direction_input(desc);
+	}
+
+	dir = gpiod_get_direction(desc);
+	if (dir < 0)
+		return dir;
+
+	if (dir == GPIO_LINE_DIRECTION_OUT) {
+		dev_dbg(proxy->dev,
+			"Shared GPIO's direction already set to output, refusing to change\n");
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+static int gpio_shared_proxy_direction_output(struct gpio_chip *gc,
+					      unsigned int offset, int value)
+{
+	struct gpio_shared_proxy_data *proxy = gpiochip_get_data(gc);
+	struct gpio_shared_desc *shared_desc = proxy->shared_desc;
+	struct gpio_desc *desc = shared_desc->desc;
+	int ret, dir;
+
+	guard(gpio_shared_desc_lock)(shared_desc);
+
+	if (shared_desc->usecnt == 1) {
+		dev_dbg(proxy->dev,
+			"Only one user of this shared GPIO, allowing to set direction to output with value '%s'\n",
+			value ? "high" : "low");
+
+		ret = gpiod_direction_output(desc, value);
+		if (ret)
+			return ret;
+
+		if (value) {
+			proxy->voted_high = true;
+			shared_desc->highcnt = 1;
+		} else {
+			proxy->voted_high = false;
+			shared_desc->highcnt = 0;
+		}
+
+		return 0;
+	}
+
+	dir = gpiod_get_direction(desc);
+	if (dir < 0)
+		return dir;
+
+	if (dir == GPIO_LINE_DIRECTION_IN) {
+		dev_dbg(proxy->dev,
+			"Shared GPIO's direction already set to input, refusing to change\n");
+		return -EPERM;
+	}
+
+	return gpio_shared_proxy_set_unlocked(proxy, gpiod_direction_output, value);
+}
+
+static int gpio_shared_proxy_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_shared_proxy_data *proxy = gpiochip_get_data(gc);
+
+	return gpiod_get_value(proxy->shared_desc->desc);
+}
+
+static int gpio_shared_proxy_get_cansleep(struct gpio_chip *gc,
+					  unsigned int offset)
+{
+	struct gpio_shared_proxy_data *proxy = gpiochip_get_data(gc);
+
+	return gpiod_get_value_cansleep(proxy->shared_desc->desc);
+}
+
+static int gpio_shared_proxy_do_set(struct gpio_shared_proxy_data *proxy,
+				    int (*set_func)(struct gpio_desc *desc, int value),
+				    int value)
+{
+	guard(gpio_shared_desc_lock)(proxy->shared_desc);
+
+	return gpio_shared_proxy_set_unlocked(proxy, set_func, value);
+}
+
+static int gpio_shared_proxy_set(struct gpio_chip *gc, unsigned int offset,
+				 int value)
+{
+	struct gpio_shared_proxy_data *proxy = gpiochip_get_data(gc);
+
+	return gpio_shared_proxy_do_set(proxy, gpiod_set_value, value);
+}
+
+static int gpio_shared_proxy_set_cansleep(struct gpio_chip *gc,
+					  unsigned int offset, int value)
+{
+	struct gpio_shared_proxy_data *proxy = gpiochip_get_data(gc);
+
+	return gpio_shared_proxy_do_set(proxy, gpiod_set_value_cansleep, value);
+}
+
+static int gpio_shared_proxy_get_direction(struct gpio_chip *gc,
+					   unsigned int offset)
+{
+	struct gpio_shared_proxy_data *proxy = gpiochip_get_data(gc);
+
+	return gpiod_get_direction(proxy->shared_desc->desc);
+}
+
+static int gpio_shared_proxy_to_irq(struct gpio_chip *gc, unsigned int offset)
+{
+	struct gpio_shared_proxy_data *proxy = gpiochip_get_data(gc);
+
+	return gpiod_to_irq(proxy->shared_desc->desc);
+}
+
+static int gpio_shared_proxy_probe(struct auxiliary_device *adev,
+				   const struct auxiliary_device_id *id)
+{
+	struct gpio_shared_proxy_data *proxy;
+	struct gpio_shared_desc *shared_desc;
+	struct device *dev = &adev->dev;
+	struct gpio_chip *gc;
+
+	shared_desc = devm_gpiod_shared_get(dev);
+	if (IS_ERR(shared_desc))
+		return PTR_ERR(shared_desc);
+
+	proxy = devm_kzalloc(dev, sizeof(*proxy), GFP_KERNEL);
+	if (!proxy)
+		return -ENOMEM;
+
+	proxy->shared_desc = shared_desc;
+	proxy->dev = dev;
+
+	gc = &proxy->gc;
+	gc->base = -1;
+	gc->ngpio = 1;
+	gc->label = dev_name(dev);
+	gc->parent = dev;
+	gc->owner = THIS_MODULE;
+	gc->can_sleep = shared_desc->can_sleep;
+
+	gc->request = gpio_shared_proxy_request;
+	gc->free = gpio_shared_proxy_free;
+	gc->set_config = gpio_shared_proxy_set_config;
+	gc->direction_input = gpio_shared_proxy_direction_input;
+	gc->direction_output = gpio_shared_proxy_direction_output;
+	if (gc->can_sleep) {
+		gc->set = gpio_shared_proxy_set_cansleep;
+		gc->get = gpio_shared_proxy_get_cansleep;
+	} else {
+		gc->set = gpio_shared_proxy_set;
+		gc->get = gpio_shared_proxy_get;
+	}
+	gc->get_direction = gpio_shared_proxy_get_direction;
+	gc->to_irq = gpio_shared_proxy_to_irq;
+
+	return devm_gpiochip_add_data(dev, &proxy->gc, proxy);
+}
+
+static const struct auxiliary_device_id gpio_shared_proxy_id_table[] = {
+	{ .name = "gpiolib_shared.proxy" },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, gpio_shared_proxy_id_table);
+
+static struct auxiliary_driver gpio_shared_proxy_driver = {
+	.driver = {
+		.name = "gpio-shared-proxy",
+	},
+	.probe = gpio_shared_proxy_probe,
+	.id_table = gpio_shared_proxy_id_table,
+};
+module_auxiliary_driver(gpio_shared_proxy_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("Shared GPIO mux driver.");
+MODULE_LICENSE("GPL");

-- 
2.48.1


