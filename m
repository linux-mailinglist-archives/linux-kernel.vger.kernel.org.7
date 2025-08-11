Return-Path: <linux-kernel+bounces-761779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90038B1FE5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA44176689
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84ED21C179;
	Mon, 11 Aug 2025 04:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0JuVKhA"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A91A2E36EC;
	Mon, 11 Aug 2025 04:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754886704; cv=none; b=KEJJdvDb0MOmb5HXoXK3owbqT644j/dMdcaVwvy2a4CaC6x7GZxr+0C+O0wWZopBuUQtAv8N5t5Hqwbn6q12tffvrhptLJK7EeN/pFO4yS02sXQgIthYNn+wnST96IQbR+eyN+3Ksj0QEcGTWiN9CY4J3cgb29BdOtKdi3KDo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754886704; c=relaxed/simple;
	bh=9jhQOGVHQSqrFgET5ndbks6uqT7zenqk32zCi2L313I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rVFs6JabH49E2ujy7ZNe+vWDJNMy13pKOytNdQ5meSzk9L7DgfQl2rOk5O7hOI+har89uzHeS60N+w0L7FNnnACyqhb7oeHYkY8pKShU1QFvCxfGMjVebzKMWJm4oionGjKknw4ql1wizF+3kfQNhsDdUJqpCRGOaHywoqWiRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0JuVKhA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24003ed822cso22389605ad.1;
        Sun, 10 Aug 2025 21:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754886701; x=1755491501; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KSIxzg7N5siQOaz/snNAUdpqjxAxtIvx/sSJBvLYGc=;
        b=S0JuVKhAjZwDc+/V8bMxDZuvdlRgdIadAKh83bXuL7ETuvf5xS15l9XEyq1Yne3s4N
         gcGR1z7y0ifbWOaOoNOl0olFWGBUZZJdT4OHGyD1JafgmhFEclJo1cWI+T6LRPcYInoY
         QO4G4BSLBJIe0/Foywm4oUEElrWLgu92GVPCdy1r72ZKYGQwhCir4nhlfVVpH/CzI3HJ
         RzOfMywwmH0YjrhsvAV9KZjVkPjH2M6Em89txPym07YibJQdo1w35LW+j6DT4nhvrcxx
         XgzJTmVSxwQb2zx0A9+bGk/9ur7vp4GEzX1byCvKvrNysfltw8r+C/P1kyGBPePjC8qJ
         Yj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754886701; x=1755491501;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KSIxzg7N5siQOaz/snNAUdpqjxAxtIvx/sSJBvLYGc=;
        b=JbTpaK3poDMdlBRaR12RLI/FNbuf1ZQ27eG82VLsw7mvyXsNChOKIAgnTfpl8nqUoS
         I+D2UX6h/4OjNfKpr1NPvGrpnXyiGBhK0XMJj1mn7mqTKOg0IhswnsEqHXUs2+AOFn7B
         i3AoocWJdbM1VbSylii1yfkRh3yu4pQ4i45cMhrh1ogT+tpjFT1sftQXfDs3nhKPquvM
         NgBFl1r59IKl2wm2OLE5df+xYwmPCmnQmUfnUn3f3Xn33yzsMmvQ30zHVvsvnzNCMvYm
         iTzTNB7+NTb4uu9ffUw4yvu7ZDJ4zvHgEYaxdv01CEESpq+pP1i6Z9FW1S3MSLs6tBGG
         MB4g==
X-Forwarded-Encrypted: i=1; AJvYcCUzWDpkt9dpfleUbj6Ey5OLwYory5fL31RUdi7rO3lFq8CANDQCj58JaEAr7Scu2gs8EBYaabWwdRc94YHU7vIscfEK5g==@vger.kernel.org, AJvYcCXEjKg/DEiAK+/4Zw7JHVv2PCk/cLbMKnzeQlDcd0ff7OTYc5rq3PSYWqhovg4eOtpzQJEQgF8pKGeNjkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIe1/3VXZEdX3pgp0eE7kSmk0cBAiu1zny7A5XQNmMGvjnwkP/
	a2FZFby8DnfANiLdQ3BSOUn7cAWqfLv6C0y/4VBwPDxWegFxZsY8ui6p
X-Gm-Gg: ASbGncu1GeVSeZ7NqxOjQC9OOKuHIVVAKI0uemPVQsmg4ebFIvD9oLF7/MEPWI+WPh4
	hig67TcvF/J1jHyBiMkwnjfNlSdG1eGDfQdQeRNFghG2doOpMmhqdd5sy5gyoC/WSq2JgbBD4uG
	mjS+V2Nh2qkFJdi+SGhquGlNg27g7JJBmN5EfEWb7aRJEf6E6ijRieytahQJTUNDsfr6zDXDtxO
	Mwz9Oj520YyB2uR8zJRo0NC8sfxVf8CSbww+eGIokKk4PGAKte0e7Rbyv0q2maDfistH0z21rxo
	33x2hxgQRAqixBJCTgK//jtNNeIP9RvuUnesapX7ANen2fsO1i4y7DvI8svrMgxCYspe062W4NF
	G7h6OHfPndosHG6ctE2eKmNg=
X-Google-Smtp-Source: AGHT+IGMSbJjyvC5x/Q9BBK55d1A3AH4P45mzdebf0h428MMT29Dqng2oH+AUinVYjhogPFHeFsmcQ==
X-Received: by 2002:a17:903:3b87:b0:240:86b2:aecf with SMTP id d9443c01a7336-242c1fdb118mr148969965ad.12.1754886700507;
        Sun, 10 Aug 2025 21:31:40 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a51esm263338555ad.115.2025.08.10.21.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 21:31:40 -0700 (PDT)
Date: Sun, 10 Aug 2025 21:31:37 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Santosh Kumar Yadav <santoshkumar.yadav@barco.com>, 
	Hans de Goede <hansg@kernel.org>
Cc: Peter Korsgaard <peter.korsgaard@barco.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
Message-ID: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In preparation of dropping support for legacy GPIO API from gpio-keys
switch the driver to use software nodes/properties to describe
GPIO-connected LED and button.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This is untested - no hardware.

 drivers/platform/x86/barco-p50-gpio.c | 104 +++++++++++++++-----------
 1 file changed, 62 insertions(+), 42 deletions(-)

diff --git a/drivers/platform/x86/barco-p50-gpio.c b/drivers/platform/x86/barco-p50-gpio.c
index 28012eebdb10..6f13e81f98fb 100644
--- a/drivers/platform/x86/barco-p50-gpio.c
+++ b/drivers/platform/x86/barco-p50-gpio.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
 #include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -18,10 +19,11 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/gpio_keys.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
-#include <linux/input.h>
+#include <linux/gpio/property.h>
+#include <linux/input-event-codes.h>
+#include <linux/property.h>
 
 
 #define DRIVER_NAME		"barco-p50-gpio"
@@ -78,44 +80,57 @@ static const char * const gpio_names[] = {
 	[P50_GPIO_LINE_BTN] = "identify-button",
 };
 
-
-static struct gpiod_lookup_table p50_gpio_led_table = {
-	.dev_id = "leds-gpio",
-	.table = {
-		GPIO_LOOKUP_IDX(DRIVER_NAME, P50_GPIO_LINE_LED, NULL, 0, GPIO_ACTIVE_HIGH),
-		{}
-	}
+static const struct software_node gpiochip_node = {
+	.name = DRIVER_NAME,
 };
 
 /* GPIO LEDs */
-static struct gpio_led leds[] = {
-	{ .name = "identify" }
+static const struct software_node gpio_leds_node = {
+	.name = "gpio-leds-identify",
 };
 
-static struct gpio_led_platform_data leds_pdata = {
-	.num_leds = ARRAY_SIZE(leds),
-	.leds = leds,
+static const struct property_entry identify_led_props[] = {
+	PROPERTY_ENTRY_GPIO("gpios", &gpiochip_node, P50_GPIO_LINE_LED, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node identify_led_node = {
+	.parent = &gpio_leds_node,
+	.name = "identify",
+	.properties = identify_led_props,
 };
 
 /* GPIO keyboard */
-static struct gpio_keys_button buttons[] = {
-	{
-		.code = KEY_VENDOR,
-		.gpio = P50_GPIO_LINE_BTN,
-		.active_low = 1,
-		.type = EV_KEY,
-		.value = 1,
-	},
+static const struct property_entry gpio_keys_props[] = {
+	PROPERTY_ENTRY_STRING("label", "identify"),
+	PROPERTY_ENTRY_U32("poll-interval", 100),
+	{ }
 };
 
-static struct gpio_keys_platform_data keys_pdata = {
-	.buttons = buttons,
-	.nbuttons = ARRAY_SIZE(buttons),
-	.poll_interval = 100,
-	.rep = 0,
-	.name = "identify",
+static const struct software_node gpio_keys_node = {
+	.name = "gpio-keys-identify",
+	.properties = gpio_keys_props,
 };
 
+static struct property_entry vendor_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", KEY_VENDOR),
+	PROPERTY_ENTRY_GPIO("gpios", &gpiochip_node, P50_GPIO_LINE_BTN, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node vendor_key_node = {
+	.parent = &gpio_keys_node,
+	.properties = vendor_key_props,
+};
+
+static const struct software_node *p50_swnodes[] = {
+	&gpiochip_node,
+	&gpio_leds_node,
+	&identify_led_node,
+	&gpio_keys_node,
+	&vendor_key_node,
+	NULL
+};
 
 /* low level access routines */
 
@@ -285,6 +300,16 @@ static int p50_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
 
 static int p50_gpio_probe(struct platform_device *pdev)
 {
+	struct platform_device_info key_info = {
+		.name	= "gpio-keys-polled",
+		.id	= PLATFORM_DEVID_NONE,
+		.parent	= &pdev->dev,
+	};
+	struct platform_device_info led_info = {
+		.name	= "leds-gpio",
+		.id	= PLATFORM_DEVID_NONE,
+		.parent	= &pdev->dev,
+	};
 	struct p50_gpio *p50;
 	struct resource *res;
 	int ret;
@@ -339,25 +364,20 @@ static int p50_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	gpiod_add_lookup_table(&p50_gpio_led_table);
-
-	p50->leds_pdev = platform_device_register_data(&pdev->dev,
-		"leds-gpio", PLATFORM_DEVID_NONE, &leds_pdata, sizeof(leds_pdata));
+	ret = software_node_register_node_group(p50_swnodes);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to register software nodes");
 
+	led_info.fwnode = software_node_fwnode(&gpio_leds_node);
+	p50->leds_pdev = platform_device_register_full(&led_info);
 	if (IS_ERR(p50->leds_pdev)) {
 		ret = PTR_ERR(p50->leds_pdev);
 		dev_err(&pdev->dev, "Could not register leds-gpio: %d\n", ret);
 		goto err_leds;
 	}
 
-	/* gpio-keys-polled uses old-style gpio interface, pass the right identifier */
-	buttons[0].gpio += p50->gc.base;
-
-	p50->keys_pdev =
-		platform_device_register_data(&pdev->dev, "gpio-keys-polled",
-					      PLATFORM_DEVID_NONE,
-					      &keys_pdata, sizeof(keys_pdata));
-
+	key_info.fwnode = software_node_fwnode(&gpio_keys_node);
+	p50->keys_pdev = platform_device_register_full(&key_info);
 	if (IS_ERR(p50->keys_pdev)) {
 		ret = PTR_ERR(p50->keys_pdev);
 		dev_err(&pdev->dev, "Could not register gpio-keys-polled: %d\n", ret);
@@ -369,7 +389,7 @@ static int p50_gpio_probe(struct platform_device *pdev)
 err_keys:
 	platform_device_unregister(p50->leds_pdev);
 err_leds:
-	gpiod_remove_lookup_table(&p50_gpio_led_table);
+	software_node_unregister_node_group(p50_swnodes);
 
 	return ret;
 }
@@ -381,7 +401,7 @@ static void p50_gpio_remove(struct platform_device *pdev)
 	platform_device_unregister(p50->keys_pdev);
 	platform_device_unregister(p50->leds_pdev);
 
-	gpiod_remove_lookup_table(&p50_gpio_led_table);
+	software_node_unregister_node_group(p50_swnodes);
 }
 
 static struct platform_driver p50_gpio_driver = {
-- 
2.51.0.rc0.155.g4a0f42376b-goog


-- 
Dmitry

