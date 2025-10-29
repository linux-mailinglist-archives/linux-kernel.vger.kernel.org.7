Return-Path: <linux-kernel+bounces-875867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D99C1A00D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63358464B43
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB43338906;
	Wed, 29 Oct 2025 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wHfsyfBC"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F44334684
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736874; cv=none; b=FTgTv5yqcXOsNrXQHYZIf3fUv/KphSwMW2LvizfYxvwtxIwYgr4bxL9J3wogA7OW9EerywtGsDFtt5ZW3Tg0nqvkh6q63YNcil6o18uJqQyUP6XeKlnCzb8/sPr7IfXGfFgGIIdcsgf68rHjOxhlG7Gydd5ag0WZwl33rD5Jq48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736874; c=relaxed/simple;
	bh=MVlKPIvAL/e9P6rRlyzXBZOIkV9VrbynrQLdkfSFr3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2W5HPolETaU92ehm+E5XWN+NWwSXOKSRsKqpG9FRb/jD0UiraMi4LLxZzrKUYbNj7El6rlH/M/g/mQwzOOBxQ1d2bTOEZgyb5oqfX2i5gPOvjNlh16pThBi4i/coAqAgJ/pWJQVaf3UqJX4LNAm8PSyL6U2RTUTIPRAs2Gx3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wHfsyfBC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47710acf715so18455855e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761736868; x=1762341668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwyOQFxKD6v8+Vijfrpb6af7Tgda7juGJv7xRyBxXBI=;
        b=wHfsyfBCn5RKLEH2usq1Hfh5pPvEMXZXNzOAZWZE4jagDmhnCI1YdkGgfjV+Fo4elr
         ZYvdVWMLlQPqbMyChkypygDzvbke19XP+T3FUX+OHuUxLIhOTcyO3OCsN2kIXJWkwlOH
         BFw9x+X0mhF2BMi2a64y9LP2XIc6bQBJHbHn1XQTGI4w4MyjtCh425C/49NpwMaZ4KLl
         yWA1GJFNRemKq0h1VBVLpCwetwEiJA3poffMA3sGJZjvmp+DumZ6AkBQika199s+vt13
         z/SMZtdUOAIgl8qRoBSi5Uao3RECx4zkcFxrefEzr5m0cUHksV6dIO8e0NppKPMVvl4m
         1MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736868; x=1762341668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwyOQFxKD6v8+Vijfrpb6af7Tgda7juGJv7xRyBxXBI=;
        b=lxiK+a9gW5Y3y312zR3zxP6XqDjyGQoB4Y9nesXSbaNOfNFDgN67MlaTkoiI28AcIX
         vVoNqNNHmxAgqc6t/SC2zQOAvnWmWMoM9Mj0bQIK8yjSWg9nPYX3tA87/0uO4J72stkI
         9VWLBMvKchUFA7zCfklLrHhMY3usMXYWoaww7VvYvwxpYYv2qQlRvoSyJoxCLC+f7F1Y
         B5VujyshnEduJMDAal4ec4nNSAtE0cGZmD0Yvqm0rvNoeVR4Oy7MfNZu/GMMNW2YScCs
         hlSCCn1D6I0NcXppziA/u+aZChkrpOgwiG1L8fYS1sgAwUxOEP76bKfEGfK+b9EZbyKt
         h72g==
X-Forwarded-Encrypted: i=1; AJvYcCU/4XP4Nz/ztoEik/+X89Q/PPx5Bmqc0KfBQnsTdfHpwIiXTfkrqxWOrX70IDhvI2R3cXi+vDJm9OfWf3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy19c5I/QM3jtVD4iHr3XddcAFB/dYTKtFa6PHMWlimAL2oMgm
	dw4jvJa8cJ97mGo7n+xcmWzAKpdzp8x/Ghl2+op2Jm4rm3Wr74XyroALSP8oaceQX/I=
X-Gm-Gg: ASbGncviSwpSsby0p8MHDF6YkTJ9qhHKb68wVE1/3pbqIct/CyONwcntKXik0BbscEj
	SjCiTHE5SzqlNoYQ7RM5QV1Dxm6feXTQl0CduzJQUEJ6/MZkSGclrjaQEWmw9RieS+bkhgpSw84
	EWC7t0w2hs/lvZvYLX1hz3ACs4CW/9D9BMdUEBPYwg0uomQnFW4JP9XMhRxPGGkL9wHZJGW1xv7
	gNhgopKgMTzgYU5AIcY/Cge6nDz1ZiiMJfCpzpn62bbYv+fvN9hrZzbeUAO7E7YPRe7uhTXA60p
	5EBGDP9PGLvTRHAFQr0WbHLPbP14L9ORzzzB/j7zXivHY1n2Z0wo9dZzDWHlgg+gb69uCba4FSS
	nHPyhQRr6sKhs+9LGQqNuSLfi4W9E7WzzAplXQimwZNIC9zGpD1CfAPKkbEWkt9HzsT4R3Q==
X-Google-Smtp-Source: AGHT+IFIp7+UTDG8Mo+34fKN/ODFuhtxQqO8HkLZOExm++avTsEPa/O05hlDIAIwB6f3V1lsHOMS/A==
X-Received: by 2002:a05:6000:3107:b0:427:370:20a3 with SMTP id ffacd0b85a97d-429aefbdc04mr2206317f8f.38.1761736867751;
        Wed, 29 Oct 2025 04:21:07 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df682sm25657486f8f.43.2025.10.29.04.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:21:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 12:20:42 +0100
Subject: [PATCH v3 06/10] gpio: provide gpiod_is_shared()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-gpio-shared-v3-6-71c568acf47c@linaro.org>
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
In-Reply-To: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
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
 Takashi Iwai <tiwai@suse.com>, Alexey Klimov <alexey.klimov@linaro.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4764;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=SHc2LMOdJGlhdyjQkFVMTs07D3cYT7+feKhUydYkGmE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAfiW0Na3G1N5t7fsKNsK2pUTfvrIgTuAwZdX6
 A4Q9KaaezWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQH4lgAKCRARpy6gFHHX
 ckPbEACjlYkF7MWG/wEbiOP6H5JvyALh/B9OFrKmPM1LM/UFQaXskpAsIWILwlcCFQjmfYb/OK5
 f0auh39mZpVSR2cHXl+2KYaEIZ4xmlTl1UATnRKrCt5QtWCGuLtwG5i/O/EFvrPpei3vJFFiO1R
 EPF2Li4Kd2y5OA0QrCf3ssPORs9Hl5e/QUvvSwCL/m8mfJ2AN3DZ13SVezWk5O3jGLPAYXEwO6p
 tCkFlhEvpIDQ5m1FuzjcphPFgK+NZsTnr3pgxjnEF3morSktQxFraqnL+McdZTMJiWaawgXw1Vo
 QgTg3JAOlq6kgoh4NrdYAlg7mboV3GtNssgRbqENq5p5fDK4LIp0xkfz1Zda18Qqe4ucpr/Pf1z
 XmLT5hl3Ee8hkY2Iu/zXhK618YH3gerDRmED6d/XCL7TWkEq/UvTpXmNWOKlxjTZ2a2Y3kx9xqs
 gTFnUcpokMmLC/eFwEcQIT6b+GClp+ufnH/l94/28rSRZt4QNNkULCrOSNMKLX+t+eA//Chxyfg
 GD9dFaGpJ7aQAk9OHImV+xhowrQPJ3ZVhjkmou5X6XoVqt8KxP9s5MXJDFOoF7kquHTIUqIZZ0j
 2FwjrM28Mg70hu4fkzW7MXfppWUYje8SFOGvWWDIj/I5yYNrugag4ZHP3U3mTnZXrUM4WHo62uO
 lr9QzzS3hxNQ5Dg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Provide an interface allowing consumers to check if a GPIO descriptor
represents a GPIO that can potentially be shared by multiple consumers
at the same time. This is exposed to allow subsystems that already
work around the limitations of the current non-exclusive GPIO handling
in some ways, to gradually convert to relying on the new shared GPIO
feature of GPIOLIB.

Extend the gpiolib-shared module to mark the GPIO shared proxy
descriptors with a flag checked by the new interface.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-shared.c | 18 ++++++++++++++++++
 drivers/gpio/gpiolib.c        | 20 ++++++++++++++++++++
 drivers/gpio/gpiolib.h        |  1 +
 include/linux/gpio/consumer.h |  9 +++++++++
 4 files changed, 48 insertions(+)

diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index 56b9b03cbb6dbcdf095a656fc36ff321770035da..c22eaf05eef23a7f5f111708c3db9412c4c30231 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -314,6 +314,24 @@ int gpio_device_setup_shared(struct gpio_device *gdev)
 
 	guard(mutex)(&gpio_shared_lock);
 
+	list_for_each_entry(entry, &gpio_shared_list, list) {
+		list_for_each_entry(ref, &entry->refs, list) {
+			if (gdev->dev.parent == &ref->adev.dev) {
+				/*
+				 * This is a shared GPIO proxy. Mark its
+				 * descriptor as such and return here.
+				 */
+				__set_bit(GPIOD_FLAG_SHARED_PROXY,
+					  &gdev->descs[0].flags);
+				return 0;
+			}
+		}
+	}
+
+	/*
+	 * This is not a shared GPIO proxy but it still may be the device
+	 * exposing shared pins. Find them and create the proxy devices.
+	 */
 	list_for_each_entry(entry, &gpio_shared_list, list) {
 		if (!device_match_fwnode(&gdev->dev, entry->fwnode))
 			continue;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c0c0e9370f150c340a7c79dc03c5afec64a440f4..fb4311d41161051dfd3c996b6e8e9e8556b97cbc 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3997,6 +3997,26 @@ int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name)
 }
 EXPORT_SYMBOL_GPL(gpiod_set_consumer_name);
 
+/**
+ * gpiod_is_shared() - check if this GPIO can be shared by multiple consumers
+ * @desc: GPIO to inspect
+ *
+ * Returns:
+ * True if this GPIO can be shared by multiple consumers at once. False if it's
+ * a regular, exclusive GPIO.
+ *
+ * Note:
+ * This function returning true does not mean that this GPIO is currently being
+ * shared. It means the GPIO core has registered the fact that the firmware
+ * configuration indicates that it can be shared by multiple consumers and is
+ * in charge of arbitrating the access.
+ */
+bool gpiod_is_shared(const struct gpio_desc *desc)
+{
+	return test_bit(GPIOD_FLAG_SHARED_PROXY, &desc->flags);
+}
+EXPORT_SYMBOL_GPL(gpiod_is_shared);
+
 /**
  * gpiod_to_irq() - return the IRQ corresponding to a GPIO
  * @desc: gpio whose IRQ will be returned (already requested)
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index c9de4bb10584206f4888c0f28468762a3680aae6..77f6f2936dc263a67b31a38799a841128a57603a 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -205,6 +205,7 @@ struct gpio_desc {
 #define GPIOD_FLAG_EVENT_CLOCK_REALTIME	18 /* GPIO CDEV reports REALTIME timestamps in events */
 #define GPIOD_FLAG_EVENT_CLOCK_HTE	19 /* GPIO CDEV reports hardware timestamps in events */
 #define GPIOD_FLAG_SHARED		20 /* GPIO is shared by multiple consumers */
+#define GPIOD_FLAG_SHARED_PROXY		21 /* GPIO is a virtual proxy to a physically shared pin. */
 
 	/* Connection label */
 	struct gpio_desc_label __rcu *label;
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 994d46874d560416175c9099e18180237839bd4c..cafeb7a40ad1c25aeb7deaf598410d5f2f004a82 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -167,6 +167,8 @@ int gpiod_cansleep(const struct gpio_desc *desc);
 int gpiod_to_irq(const struct gpio_desc *desc);
 int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name);
 
+bool gpiod_is_shared(const struct gpio_desc *desc);
+
 /* Convert between the old gpio_ and new gpiod_ interfaces */
 struct gpio_desc *gpio_to_desc(unsigned gpio);
 int desc_to_gpio(const struct gpio_desc *desc);
@@ -522,6 +524,13 @@ static inline int gpiod_set_consumer_name(struct gpio_desc *desc,
 	return -EINVAL;
 }
 
+static inline bool gpiod_is_shared(const struct gpio_desc *desc)
+{
+	/* GPIO can never have been requested */
+	WARN_ON(desc);
+	return false;
+}
+
 static inline struct gpio_desc *gpio_to_desc(unsigned gpio)
 {
 	return NULL;

-- 
2.48.1


