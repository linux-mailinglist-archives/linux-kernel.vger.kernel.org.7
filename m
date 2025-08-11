Return-Path: <linux-kernel+bounces-763689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F9EB218C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96ED7420588
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91EA2E3B01;
	Mon, 11 Aug 2025 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0YyXMcf"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E721F0995;
	Mon, 11 Aug 2025 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952611; cv=none; b=Ks7n3eiiO0T6MmcWSA5RBBSK9uwzV6F/JKKum/mG3GZQgk2VxdqKsgIxe/Fb9pDrBEWR8gZjAFwdDJnBE1eVJxz4PUvFKuB4krRb+GOiQEYyqoZol1gScWb1yz8PATB+d5Yve+mv1qPNbASBgEaEO7cKPkHPBYdi2D0zfRKc32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952611; c=relaxed/simple;
	bh=+IS7E2IoNvWKk53YhYWvkR8ZbYq/McVW6o/anVSOGcY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l2hiM+u90+QZ3MIxT1qTfG6gHCwk8NXgf+ggGEAKo1wj3eqm1XZIkpdcHEJd/dW/IznBR+iS+nXaCSx+bGz5tEoW91SzeBP689DqosJHY/KywDfEYz0oP/7LoweJMnDkLSWkC8deojd7URMcOjz5vYmEXdGp0Ueu87LVojwwykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0YyXMcf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76bfd457607so4762018b3a.0;
        Mon, 11 Aug 2025 15:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754952609; x=1755557409; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrqT6LJVUtfVfEIRhxlbdM/roBG32C3EVok0bPsKrAA=;
        b=i0YyXMcfGknW8OpV1bYONwQUn+0qtUGBriryj4ivEvB5XU760xoG4EQ/N38p56R2KU
         5BBmehxtj5ihXLQ6IqimdxH03biS9Owy2zG7N/DQYegawjrHZ8HFl7Qhch1OQykdDdlU
         e4YnuWX/WhbLh9SkIA7bYYQ+5cLsgwuZfxHvzQOdGg7oWoM/vK8RnAE8U+Q6truWtfqJ
         BMitfsEA5XARLsicRlN1TBN7d8w4VY3IyudXwA9F+FeAenn4q7VztvgKeJRfzFIXEXDS
         QdfSDtiXf05T+8fx7M8z3WCSu0a3dYGfnvocscQbs9mD3VcVEqUmWry0uxMtB4UjGowm
         dLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754952609; x=1755557409;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrqT6LJVUtfVfEIRhxlbdM/roBG32C3EVok0bPsKrAA=;
        b=DnR+tSTSfAe8F6XQqh9j3ZzgQeDi5WZKSiiwx3BMVccLz/5vV+PfXdJmZOMvzVRC73
         EnaHQ5RGqeocuPv2Gda5fEuqFipjh0agKwF5ycBkj02fcf5v+N1dCSwtGNz/fmtqPXrm
         dCrwv6G/li/7UNL+v29060t5UvYgWfMCS1UUmUvk6cOuC6McDmZgGpsHEDEqrKQHq1t3
         yNUjXDN6Ha2f6EjJdZTDPnwLnmZQnwVgcu3xgrJ5DqlTFpZ2QKnldINQtv93QyMJA2wk
         piF5HQ0KFw/E5P3XPGLLGrZDYX2EIowIja4nxSJSowHTA/TkJp0cW3GYExXm+uTOv5O6
         0wfA==
X-Forwarded-Encrypted: i=1; AJvYcCV3xc7DggqY3/LqBBb1D1h05oWT4FNALOwMarH8fDSxLtRsE9NfYZGLlwsFk2hllB26G39LTukxuNIYFcU=@vger.kernel.org, AJvYcCXNR2kTHAWYan2GuT1TE70e2qWmbZs36rRoM7V1i14BKz3lx4/ZSAgAll7Ep8BCG1TKxscBrZhJzj549EowaQQGpcOi/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9Ow9qy+3qthI9J/9L4g9GBYWBW6NcXIMtkxsqAJNHY4ZDrIg
	JFokpUGXgS3w/gXSJbwSAhjH64iyb9RI8JCN/3T90WY6VmqBUqYEJqZrZVJ2jA==
X-Gm-Gg: ASbGncsjZ9EIWywUQfjWWhS3dChy1Z9tjUBqmjDnFile2zB7yTb9Wn9SqNgVYfENKl1
	Hr6wg7yUZ35sci90jQftXeeXGqxabDwYQGfPMgGMCkbXCZeoPQ+PSdMtXd+oV3VvX53sCDizzuc
	aLJ27y4qwqIiHkw6vHl7cs2cgdrrsCWtu3Splx0LzVfLekMRa8VhwzFaKynlBRyPIwJ83AslBxy
	uIy8fM5qgr/HMGHwYXg7YpGttUZu0/JDO0xVMmsr/mVSgFPIEmuww3Dcpz71HQ4UV9qRYOeI38P
	G2qAZFVbCxTmMVExRBVFSoOJ+CWWK1Z1FotBJ5C5SCau7uNm3xpL0X37dfU0Mgt6V9n4+Nfa4u2
	UxESxdsvxc/YO4ILrgoRwwho=
X-Google-Smtp-Source: AGHT+IEX0ouW3wW4MIaKJU/yVxRpdxp7UsSV2qT/D29s1MQFh4ZsUoYpWtLbVt0viRjQUq6VWJfD9Q==
X-Received: by 2002:a05:6a00:2ea2:b0:76b:fe65:71d2 with SMTP id d2e1a72fcca58-76e0de41b55mr1495561b3a.10.1754952608538;
        Mon, 11 Aug 2025 15:50:08 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:7933:7499:67d8:279a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd1d4e312sm26928013b3a.17.2025.08.11.15.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:50:08 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:50:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Arnd Bergmann <arnd@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linus.walleij@linaro.org>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: pcengines-apuv2: Use static device properties
Message-ID: <yaaegm5z2vtkl6ci5jpfnv42aywfjtoqw3bjgtli43ypask2r6@a7gg37rwkpx2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the PC Engines APUv2/v3 board driver to use software nodes
and static device properties for its on-board LEDs and front button.

This change replaces the legacy gpiod_lookup_table and platform_data
with a modern software node implementation, which allows the leds-gpio
and gpio-keys drivers to use the standard device properties API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This compiles but I have not tried this on real hardware.

 drivers/platform/x86/pcengines-apuv2.c | 192 +++++++++++++++----------
 1 file changed, 118 insertions(+), 74 deletions(-)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index 3aa63b18a2e1..3b086863c6ac 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -12,13 +12,13 @@
 
 #include <linux/dmi.h>
 #include <linux/err.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
+#include <linux/input-event-codes.h>
 #include <linux/kernel.h>
-#include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/gpio_keys.h>
-#include <linux/gpio/machine.h>
-#include <linux/input.h>
+#include <linux/property.h>
 #include <linux/platform_data/gpio/gpio-amd-fch.h>
 
 /*
@@ -72,60 +72,91 @@ static const struct amd_fch_gpio_pdata board_apu2 = {
 	.gpio_names	= apu2_gpio_names,
 };
 
+static const struct software_node apu2_gpiochip_node = {
+	.name = AMD_FCH_GPIO_DRIVER_NAME,
+};
+
 /* GPIO LEDs device */
+static const struct software_node apu2_leds_node = {
+	.name = "apu2-leds",
+};
 
-static const struct gpio_led apu2_leds[] = {
-	{ .name = "apu:green:1" },
-	{ .name = "apu:green:2" },
-	{ .name = "apu:green:3" },
+static const struct property_entry apu2_led1_props[] = {
+	PROPERTY_ENTRY_STRING("label", "apu:green:1"),
+	PROPERTY_ENTRY_GPIO("gpios", &apu2_gpiochip_node,
+			    APU2_GPIO_LINE_LED1, GPIO_ACTIVE_LOW),
+	{ }
 };
 
-static const struct gpio_led_platform_data apu2_leds_pdata = {
-	.num_leds	= ARRAY_SIZE(apu2_leds),
-	.leds		= apu2_leds,
+static const struct software_node apu2_led1_swnode = {
+	.name = "led-1",
+	.parent = &apu2_leds_node,
+	.properties = apu2_led1_props,
 };
 
-static struct gpiod_lookup_table gpios_led_table = {
-	.dev_id = "leds-gpio",
-	.table = {
-		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED1,
-				NULL, 0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED2,
-				NULL, 1, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED3,
-				NULL, 2, GPIO_ACTIVE_LOW),
-		{} /* Terminating entry */
-	}
+static const struct property_entry apu2_led2_props[] = {
+	PROPERTY_ENTRY_STRING("label", "apu:green:2"),
+	PROPERTY_ENTRY_GPIO("gpios", &apu2_gpiochip_node,
+			    APU2_GPIO_LINE_LED2, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node apu2_led2_swnode = {
+	.name = "led-2",
+	.parent = &apu2_leds_node,
+	.properties = apu2_led2_props,
+};
+
+static const struct property_entry apu2_led3_props[] = {
+	PROPERTY_ENTRY_STRING("label", "apu:green:3"),
+	PROPERTY_ENTRY_GPIO("gpios", &apu2_gpiochip_node,
+			    APU2_GPIO_LINE_LED3, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node apu2_led3_swnode = {
+	.name = "led-3",
+	.parent = &apu2_leds_node,
+	.properties = apu2_led3_props,
 };
 
 /* GPIO keyboard device */
+static const struct property_entry apu2_keys_props[] = {
+	PROPERTY_ENTRY_U32("poll-interval", 100),
+	{ }
+};
 
-static struct gpio_keys_button apu2_keys_buttons[] = {
-	{
-		.code			= KEY_RESTART,
-		.active_low		= 1,
-		.desc			= "front button",
-		.type			= EV_KEY,
-		.debounce_interval	= 10,
-		.value			= 1,
-	},
+static const struct software_node apu2_keys_node = {
+	.name = "apu2-keys",
+	.properties = apu2_keys_props,
 };
 
-static const struct gpio_keys_platform_data apu2_keys_pdata = {
-	.buttons	= apu2_keys_buttons,
-	.nbuttons	= ARRAY_SIZE(apu2_keys_buttons),
-	.poll_interval	= 100,
-	.rep		= 0,
-	.name		= "apu2-keys",
+static const struct property_entry apu2_front_button_props[] = {
+	PROPERTY_ENTRY_STRING("label", "front button"),
+	PROPERTY_ENTRY_U32("linux,code", KEY_RESTART),
+	PROPERTY_ENTRY_GPIO("gpios", &apu2_gpiochip_node,
+			    APU2_GPIO_LINE_MODESW, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_U32("debounce-interval", 10),
+	{ }
 };
 
-static struct gpiod_lookup_table gpios_key_table = {
-	.dev_id = "gpio-keys-polled",
-	.table = {
-		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_MODESW,
-				NULL, 0, GPIO_ACTIVE_LOW),
-		{} /* Terminating entry */
-	}
+static const struct software_node apu2_front_button_swnode = {
+	.name = "front-button",
+	.parent = &apu2_keys_node,
+	.properties = apu2_front_button_props,
+};
+
+static const struct software_node *apu2_swnodes[] = {
+	&apu2_gpiochip_node,
+	/* LEDs nodes */
+	&apu2_leds_node,
+	&apu2_led1_swnode,
+	&apu2_led2_swnode,
+	&apu2_led3_swnode,
+	/* Keys nodes */
+	&apu2_keys_node,
+	&apu2_front_button_swnode,
+	NULL
 };
 
 /* Board setup */
@@ -222,23 +253,25 @@ static struct platform_device *apu_gpio_pdev;
 static struct platform_device *apu_leds_pdev;
 static struct platform_device *apu_keys_pdev;
 
-static struct platform_device * __init apu_create_pdev(
-	const char *name,
-	const void *pdata,
-	size_t sz)
+static struct platform_device * __init apu_create_pdev(const char *name,
+						       const void *data, size_t size,
+						       const struct software_node *swnode)
 {
+	struct platform_device_info pdev_info = {
+		.name = name,
+		.id = PLATFORM_DEVID_NONE,
+		.data = data,
+		.size_data = size,
+		.fwnode = software_node_fwnode(swnode),
+	};
 	struct platform_device *pdev;
+	int err;
 
-	pdev = platform_device_register_resndata(NULL,
-		name,
-		PLATFORM_DEVID_NONE,
-		NULL,
-		0,
-		pdata,
-		sz);
+	pdev = platform_device_register_full(&pdev_info);
 
-	if (IS_ERR(pdev))
-		pr_err("failed registering %s: %ld\n", name, PTR_ERR(pdev));
+	err = PTR_ERR_OR_ZERO(pdev);
+	if (err)
+		pr_err("failed registering %s: %d\n", name, err);
 
 	return pdev;
 }
@@ -246,6 +279,7 @@ static struct platform_device * __init apu_create_pdev(
 static int __init apu_board_init(void)
 {
 	const struct dmi_system_id *id;
+	int err;
 
 	id = dmi_first_match(apu_gpio_dmi_table);
 	if (!id) {
@@ -253,35 +287,45 @@ static int __init apu_board_init(void)
 		return -ENODEV;
 	}
 
-	gpiod_add_lookup_table(&gpios_led_table);
-	gpiod_add_lookup_table(&gpios_key_table);
+	err = software_node_register_node_group(apu2_swnodes);
+	if (err) {
+		pr_err("failed to register software nodes: %d\n", err);
+		return err;
+	}
 
-	apu_gpio_pdev = apu_create_pdev(
-		AMD_FCH_GPIO_DRIVER_NAME,
-		id->driver_data,
-		sizeof(struct amd_fch_gpio_pdata));
+	apu_gpio_pdev = apu_create_pdev(AMD_FCH_GPIO_DRIVER_NAME,
+					id->driver_data, sizeof(struct amd_fch_gpio_pdata), NULL);
+	err = PTR_ERR_OR_ZERO(apu_gpio_pdev);
+	if (err)
+		goto err_unregister_swnodes;
 
-	apu_leds_pdev = apu_create_pdev(
-		"leds-gpio",
-		&apu2_leds_pdata,
-		sizeof(apu2_leds_pdata));
+	apu_leds_pdev = apu_create_pdev("leds-gpio", NULL, 0, &apu2_leds_node);
+	err = PTR_ERR_OR_ZERO(apu_leds_pdev);
+	if (err)
+		goto err_unregister_gpio;
 
-	apu_keys_pdev = apu_create_pdev(
-		"gpio-keys-polled",
-		&apu2_keys_pdata,
-		sizeof(apu2_keys_pdata));
+	apu_keys_pdev = apu_create_pdev("gpio-keys-polled", NULL, 0, &apu2_keys_node);
+	err = PTR_ERR_OR_ZERO(apu_keys_pdev);
+	if (err)
+		goto err_unregister_leds;
 
 	return 0;
+
+err_unregister_leds:
+	platform_device_unregister(apu_leds_pdev);
+err_unregister_gpio:
+	platform_device_unregister(apu_gpio_pdev);
+err_unregister_swnodes:
+	software_node_unregister_node_group(apu2_swnodes);
+	return err;
 }
 
 static void __exit apu_board_exit(void)
 {
-	gpiod_remove_lookup_table(&gpios_led_table);
-	gpiod_remove_lookup_table(&gpios_key_table);
-
 	platform_device_unregister(apu_keys_pdev);
 	platform_device_unregister(apu_leds_pdev);
 	platform_device_unregister(apu_gpio_pdev);
+	software_node_unregister_node_group(apu2_swnodes);
 }
 
 module_init(apu_board_init);
-- 
2.51.0.rc0.155.g4a0f42376b-goog


-- 
Dmitry

