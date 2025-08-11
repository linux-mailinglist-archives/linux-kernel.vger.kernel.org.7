Return-Path: <linux-kernel+bounces-763678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F61B2188F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4B21903E38
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7706A1E7C18;
	Mon, 11 Aug 2025 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnKL2Lgh"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4019D065;
	Mon, 11 Aug 2025 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952434; cv=none; b=p8mlMMPfVC1VCY2kOeMjkVVzwHaUKtbkgnHMJkXhDtqulKtfvrJu2mQY5gdHIejHkw0KKppgbrxH7+rQAQHMfOrlq5RHW8NXMwiSXT6vkUUYBc1Rox0u0ycsNwh0HccyR2AB9tCZdxjojhmoZmdRL4Vb74ID1paMVUlKncZwAPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952434; c=relaxed/simple;
	bh=G1PXVZ0UA9QR41dSWs8gtM+5c+QX+/q3d7AQMM//YIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TnKeZCiVeXNMhWGwZV3gTx1zJVcvvYurKkmrrCKqarHWZ0QWEOvPA7ZlGWf4sDBPeC1T1PSFQTTxWMDP2HH8LhggqbL6wxHej2Oo9KtbhPEUGXRf22oUay598ZyQleQQMGVhRv4fxrZwkBaBQqakc2vMyndhLMWbv28XtEAi8bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnKL2Lgh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso4464149b3a.3;
        Mon, 11 Aug 2025 15:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754952432; x=1755557232; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=de0me9/YGHnRXlTnZjgcGffuWlmy2iUubpAeKN1WIyY=;
        b=gnKL2LghFDcUn+D6vgQkXlBUZ6ZbR9H8ZYwnd4i2WxDBJZcP1RKA1qyIKmix2DSPDa
         r4sHxHrwO0IH71WwYfys6GlWvQQcqN5AD9qhq1C/7AIZ7gUPhDYsWhqn1ug7cFDeZ7ia
         mG/24HQxG1FlHdk+A+FXrBnWbGXLclUFCm9iVhCUON985u+9g8djsv4Cn282UjhDXjRV
         IkAhDfhWwaVOIw+V8WJIG1zt+6L60PFg7RGB3M41jP2R75TLAbbkWV+GhOgUENjxU1RV
         ++wLDjWZZ3XPKd9sHJTkvOldXvFFhoKOLGX9b03ltI6iVBKc7EbpHVE4X/9RHJgh3nDZ
         zFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754952432; x=1755557232;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=de0me9/YGHnRXlTnZjgcGffuWlmy2iUubpAeKN1WIyY=;
        b=qQqGXs9K6VEGgZyE9ucvTwzuiMSwt0lJG12NiiSe/xUYsddeUUI2Coi90a9OQjKNOt
         1Xd8wZQ2LWczBbT3EATaMvS0XayY8cZg4HdEsAH7W+D8da6s0Zqq4GlLqHXxPX5aODLG
         WxucV4/BpXbHsTI1lRWrPe/hNR62WR8IEfrmDV5nleGMwTp5VbUHlQLqpUsvG9WmxTMn
         6hzhsIEmdBf5BNc1QwoP3donKmnuK81yQ04gZzg8hQNVri6RRyd+FiJcCv5FcIs6BQEc
         +JLQzPKBIl8xjx4uEhgu69IUfHiKJ6FrtLZYwaeCZKoYGqoxY/3yprDz5duzQ63agfWe
         xPlA==
X-Forwarded-Encrypted: i=1; AJvYcCWVcNNDNQnapblauREQCFF7s4ZaBvfNlJeFcxJ9Z2bx5ck+FqrgC1pvcNFSu2y4XRSFlr+vWdkt0D17nOLGbeydCg9teA==@vger.kernel.org, AJvYcCWy+5pi0d4kgQ6Zx6bx6Ldm0nU3wnQ5XW7EnN31s3onoeonutWcISCl0LousG2CxFSGiXK95eVjegr6p+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxETtHkGhYTr9s8KAh9oev1rnwO2N5myDov/ddYXz7TGvn7ll9k
	6ZFIZwGwu3ZrWtbYWdaHmUQQH+IK08HY8HCZDLpF85aqJ7PsI52HEf7q
X-Gm-Gg: ASbGnct9XQXVC1qVA6LWncA0/XD5+mUIdqCfPCcsGJuSAgr9k6hLHU4WBNyGZtMeB0k
	zemqkjI459lY/E8na00gJAtgNhP3a550802EBUooHkfV7CSJuvMdKQbbjqatbivcwfCzXDmvvNF
	l88Pw2Oto2mD3cWEFbA5zINwxaodHxPefUUQcgH/8fxhkFMUn1Hglp7NknjmHa/6NfoCM3uT8uz
	fmMS60mI7eQXJVMd6DTt8RBwY1wUsZn0VAlnMBGL8mu0+ea7H8p6vole4Q5s8N7UUAeEyy2sY0q
	49uNUQ7jvoQLK/FDNft31/5tDox4oKgQUYvflbTiktdeDUTzB0mRDCfpYBK8xWYozz+4lEV+N3G
	RRITmg+yPcxx6Zk7gc5meVqw=
X-Google-Smtp-Source: AGHT+IEd0dxFQlD6GPQepFz/Y8Bd8LiRQimbwJf/I+mMRakh/i7T76SZamQZkrKQ//YkLZvuK3ZwTA==
X-Received: by 2002:a05:6a00:14c2:b0:736:3979:369e with SMTP id d2e1a72fcca58-76c46070b0fmr20213971b3a.9.1754952431778;
        Mon, 11 Aug 2025 15:47:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:7933:7499:67d8:279a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf1c6d5dcsm22360907b3a.74.2025.08.11.15.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:47:11 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:47:09 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: meraki-mx100: Use static device properties
Message-ID: <dzecghqrsrbe74akboqih7xculdm53rbhxa7dimt2ysdevyskd@hxhd2j3vnlt5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the Meraki MX100 board driver to use software nodes and static
device properties to describe the on-board LEDs and reset button.

This moves away from the legacy gpiod_lookup_table and platform_data
mechanisms, allowing consumer drivers like leds-gpio and gpio-keys
to rely on the unified device properties interface instead of
board-specific data.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This compiles but I have not tried this on real hardware.

 drivers/platform/x86/meraki-mx100.c | 404 ++++++++++++++++++----------
 1 file changed, 262 insertions(+), 142 deletions(-)

diff --git a/drivers/platform/x86/meraki-mx100.c b/drivers/platform/x86/meraki-mx100.c
index 3751ed36a980..8c5276d98512 100644
--- a/drivers/platform/x86/meraki-mx100.c
+++ b/drivers/platform/x86/meraki-mx100.c
@@ -15,135 +15,256 @@
 
 #include <linux/dmi.h>
 #include <linux/err.h>
-#include <linux/gpio_keys.h>
 #include <linux/gpio/machine.h>
-#include <linux/input.h>
+#include <linux/gpio/property.h>
+#include <linux/input-event-codes.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #define TINK_GPIO_DRIVER_NAME "gpio_ich"
 
+static const struct software_node gpio_ich_node = {
+	.name = TINK_GPIO_DRIVER_NAME,
+};
+
 /* LEDs */
-static const struct gpio_led tink_leds[] = {
-	{
-		.name = "mx100:green:internet",
-		.default_trigger = "default-on",
-	},
-	{
-		.name = "mx100:green:lan2",
-	},
-	{
-		.name = "mx100:green:lan3",
-	},
-	{
-		.name = "mx100:green:lan4",
-	},
-	{
-		.name = "mx100:green:lan5",
-	},
-	{
-		.name = "mx100:green:lan6",
-	},
-	{
-		.name = "mx100:green:lan7",
-	},
-	{
-		.name = "mx100:green:lan8",
-	},
-	{
-		.name = "mx100:green:lan9",
-	},
-	{
-		.name = "mx100:green:lan10",
-	},
-	{
-		.name = "mx100:green:lan11",
-	},
-	{
-		.name = "mx100:green:ha",
-	},
-	{
-		.name = "mx100:orange:ha",
-	},
-	{
-		.name = "mx100:green:usb",
-	},
-	{
-		.name = "mx100:orange:usb",
-	},
+static const struct software_node tink_gpio_leds_node = {
+	.name = "meraki-mx100-leds",
 };
 
-static const struct gpio_led_platform_data tink_leds_pdata = {
-	.num_leds	= ARRAY_SIZE(tink_leds),
-	.leds		= tink_leds,
-};
-
-static struct gpiod_lookup_table tink_leds_table = {
-	.dev_id = "leds-gpio",
-	.table = {
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 11,
-				NULL, 0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 18,
-				NULL, 1, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 20,
-				NULL, 2, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 22,
-				NULL, 3, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 23,
-				NULL, 4, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 32,
-				NULL, 5, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 34,
-				NULL, 6, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 35,
-				NULL, 7, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 36,
-				NULL, 8, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 37,
-				NULL, 9, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 48,
-				NULL, 10, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 16,
-				NULL, 11, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 7,
-				NULL, 12, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 21,
-				NULL, 13, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 19,
-				NULL, 14, GPIO_ACTIVE_LOW),
-		{} /* Terminating entry */
-	}
+static const struct property_entry tink_internet_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:green:internet"),
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "default-on"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 11, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node tink_internet_led_node = {
+	.name = "internet-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_internet_led_props,
+};
+
+static const struct property_entry tink_lan2_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:green:lan2"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 18, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node tink_lan2_led_node = {
+	.name = "lan2-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_lan2_led_props,
+};
+
+static const struct property_entry tink_lan3_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:green:lan3"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 20, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node tink_lan3_led_node = {
+	.name = "lan3-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_lan3_led_props,
+};
+
+static const struct property_entry tink_lan4_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:green:lan4"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 22, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node tink_lan4_led_node = {
+	.name = "lan4-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_lan4_led_props,
+};
+
+static const struct property_entry tink_lan5_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:green:lan5"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 23, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node tink_lan5_led_node = {
+	.name = "lan5-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_lan5_led_props,
+};
+
+static const struct property_entry tink_lan6_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:green:lan6"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 32, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node tink_lan6_led_node = {
+	.name = "lan6-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_lan6_led_props,
+};
+
+static const struct property_entry tink_lan7_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:green:lan7"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 34, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node tink_lan7_led_node = {
+	.name = "lan7-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_lan7_led_props,
+};
+
+static const struct property_entry tink_lan8_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:green:lan8"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 35, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node tink_lan8_led_node = {
+	.name = "lan8-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_lan8_led_props,
+};
+
+static const struct property_entry tink_lan9_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:green:lan9"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 36, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node tink_lan9_led_node = {
+	.name = "lan9-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_lan9_led_props,
+};
+
+static const struct property_entry tink_lan10_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:green:lan10"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 37, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node tink_lan10_led_node = {
+	.name = "lan10-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_lan10_led_props,
+};
+
+static const struct property_entry tink_lan11_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:green:lan11"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 48, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node tink_lan11_led_node = {
+	.name = "lan11-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_lan11_led_props,
+};
+
+static const struct property_entry tink_ha_green_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:green:ha"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 16, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node tink_ha_green_led_node = {
+	.name = "ha-green-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_ha_green_led_props,
+};
+
+static const struct property_entry tink_ha_orange_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:orange:ha"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 7, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node tink_ha_orange_led_node = {
+	.name = "ha-orange-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_ha_orange_led_props,
+};
+
+static const struct property_entry tink_usb_green_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:green:usb"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 21, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node tink_usb_green_led_node = {
+	.name = "usb-green-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_usb_green_led_props,
+};
+
+static const struct property_entry tink_usb_orange_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "mx100:orange:usb"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 19, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node tink_usb_orange_led_node = {
+	.name = "usb-orange-led",
+	.parent = &tink_gpio_leds_node,
+	.properties = tink_usb_orange_led_props,
 };
 
 /* Reset Button */
-static struct gpio_keys_button tink_buttons[] = {
-	{
-		.desc			= "Reset",
-		.type			= EV_KEY,
-		.code			= KEY_RESTART,
-		.active_low             = 1,
-		.debounce_interval      = 100,
-	},
+static const struct property_entry tink_gpio_keys_props[] = {
+	PROPERTY_ENTRY_U32("poll-interval", 20),
+	{ }
 };
 
-static const struct gpio_keys_platform_data tink_buttons_pdata = {
-	.buttons	= tink_buttons,
-	.nbuttons	= ARRAY_SIZE(tink_buttons),
-	.poll_interval  = 20,
-	.rep		= 0,
-	.name		= "mx100-keys",
+static const struct software_node tink_gpio_keys_node = {
+	.name = "mx100-keys",
+	.properties = tink_gpio_keys_props,
 };
 
-static struct gpiod_lookup_table tink_keys_table = {
-	.dev_id = "gpio-keys-polled",
-	.table = {
-		GPIO_LOOKUP_IDX(TINK_GPIO_DRIVER_NAME, 60,
-				NULL, 0, GPIO_ACTIVE_LOW),
-		{} /* Terminating entry */
-	}
+static const struct property_entry tink_reset_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", KEY_RESTART),
+	PROPERTY_ENTRY_STRING("label", "Reset"),
+	PROPERTY_ENTRY_GPIO("gpios", &gpio_ich_node, 60, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_U32("linux,input-type", EV_KEY),
+	PROPERTY_ENTRY_U32("debounce-interval", 100),
+	{ }
+};
+
+static const struct software_node tink_reset_key_node = {
+	.name = "reset",
+	.parent = &tink_gpio_keys_node,
+	.properties = tink_reset_key_props,
+};
+
+static const struct software_node *tink_swnodes[] = {
+	&gpio_ich_node,
+	/* LEDs nodes */
+	&tink_gpio_leds_node,
+	&tink_internet_led_node,
+	&tink_lan2_led_node,
+	&tink_lan3_led_node,
+	&tink_lan4_led_node,
+	&tink_lan5_led_node,
+	&tink_lan6_led_node,
+	&tink_lan7_led_node,
+	&tink_lan8_led_node,
+	&tink_lan9_led_node,
+	&tink_lan10_led_node,
+	&tink_lan11_led_node,
+	&tink_ha_green_led_node,
+	&tink_ha_orange_led_node,
+	&tink_usb_green_led_node,
+	&tink_usb_orange_led_node,
+	/* Keys nodes */
+	&tink_gpio_keys_node,
+	&tink_reset_key_node,
+	NULL
 };
 
 /* Board setup */
@@ -161,22 +282,17 @@ MODULE_DEVICE_TABLE(dmi, tink_systems);
 static struct platform_device *tink_leds_pdev;
 static struct platform_device *tink_keys_pdev;
 
-static struct platform_device * __init tink_create_dev(
-	const char *name, const void *pdata, size_t sz)
-{
-	struct platform_device *pdev;
-
-	pdev = platform_device_register_data(NULL,
-		name, PLATFORM_DEVID_NONE, pdata, sz);
-	if (IS_ERR(pdev))
-		pr_err("failed registering %s: %ld\n", name, PTR_ERR(pdev));
-
-	return pdev;
-}
-
 static int __init tink_board_init(void)
 {
-	int ret;
+	struct platform_device_info keys_info = {
+		.name = "gpio-keys-polled",
+		.id = PLATFORM_DEVID_NONE,
+	};
+	struct platform_device_info leds_info = {
+		.name = "leds-gpio",
+		.id = PLATFORM_DEVID_NONE,
+	};
+	int err;
 
 	if (!dmi_first_match(tink_systems))
 		return -ENODEV;
@@ -188,30 +304,35 @@ static int __init tink_board_init(void)
 	 */
 	outl(inl(0x530) | BIT(28), 0x530);
 
-	gpiod_add_lookup_table(&tink_leds_table);
-	gpiod_add_lookup_table(&tink_keys_table);
+	err = software_node_register_node_group(tink_swnodes);
+	if (err) {
+		pr_err("failed to register software nodes: %d\n", err);
+		return err;
+	}
 
-	tink_leds_pdev = tink_create_dev("leds-gpio",
-		&tink_leds_pdata, sizeof(tink_leds_pdata));
+	leds_info.fwnode = software_node_fwnode(&tink_gpio_leds_node);
+	tink_leds_pdev = platform_device_register_full(&leds_info);
 	if (IS_ERR(tink_leds_pdev)) {
-		ret = PTR_ERR(tink_leds_pdev);
-		goto err;
+		err = PTR_ERR(tink_leds_pdev);
+		pr_err("failed to create LED device: %d\n", err);
+		goto err_unregister_swnodes;
 	}
 
-	tink_keys_pdev = tink_create_dev("gpio-keys-polled",
-		&tink_buttons_pdata, sizeof(tink_buttons_pdata));
+	keys_info.fwnode = software_node_fwnode(&tink_gpio_keys_node);
+	tink_keys_pdev = platform_device_register_full(&keys_info);
 	if (IS_ERR(tink_keys_pdev)) {
-		ret = PTR_ERR(tink_keys_pdev);
-		platform_device_unregister(tink_leds_pdev);
-		goto err;
+		err = PTR_ERR(tink_keys_pdev);
+		pr_err("failed to create key device: %d\n", err);
+		goto err_unregister_leds;
 	}
 
 	return 0;
 
-err:
-	gpiod_remove_lookup_table(&tink_keys_table);
-	gpiod_remove_lookup_table(&tink_leds_table);
-	return ret;
+err_unregister_leds:
+	platform_device_unregister(tink_leds_pdev);
+err_unregister_swnodes:
+	software_node_unregister_node_group(tink_swnodes);
+	return err;
 }
 module_init(tink_board_init);
 
@@ -219,8 +340,7 @@ static void __exit tink_board_exit(void)
 {
 	platform_device_unregister(tink_keys_pdev);
 	platform_device_unregister(tink_leds_pdev);
-	gpiod_remove_lookup_table(&tink_keys_table);
-	gpiod_remove_lookup_table(&tink_leds_table);
+	software_node_unregister_node_group(tink_swnodes);
 }
 module_exit(tink_board_exit);
 
-- 
2.51.0.rc0.155.g4a0f42376b-goog


-- 
Dmitry

