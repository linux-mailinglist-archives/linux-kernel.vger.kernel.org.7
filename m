Return-Path: <linux-kernel+bounces-761729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4D1B1FDC9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 674D57AA4D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0535F2D838F;
	Mon, 11 Aug 2025 02:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRX9hBw9"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF7285CB0;
	Mon, 11 Aug 2025 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754879004; cv=none; b=dgiDyRjVNNJ+PZoQDztiP2JSUbo1Cd8FvW2F7DOjeDU3SvFIsb3JBfgAuDe6acHbVAdEE5xKKHHiPd20LJteQsLxeP7NEndirw2LTtxDeXu1v4ULQskAYqI9yv+nqz1pmvvzvfHieYV7lnK/wgz6Q9X7oigxXOSw4cHqy1MiS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754879004; c=relaxed/simple;
	bh=tkg9uXrsU0kfP1J4wKHXdPxWLrfWQgNzypBdnkXmcxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XT96IGrGg2SBab8bZSPK6Ae8Z5pJEpzeFPZTzJZRBFn0KrOkSXNSxz6FRP0taAZDuvzv5Xe0pkQtEOjm+KodPYLxKdXKJsK+Epezx3BvRA1641ncgKftorwcofO1SdGUGzj+ZqMk1Iouc8t4ZGLgK2W7+DYVVggfS2b8A+pC648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRX9hBw9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76be8e4b59aso3140919b3a.1;
        Sun, 10 Aug 2025 19:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754879002; x=1755483802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zc0OmXKKIKzJxLhoELmXzeUr9qo5ipAMm7/O57p0HGY=;
        b=PRX9hBw9A2mMvMEVROEh/yzjCxMkXwx7js0oyQDYzdKOsz0UGm28NgjUvh3tcAfalp
         OuSkNoBCLtAgpxrUGR9bGdzYWpYwVh0h8HcR6ajoaL1TAXMyRxByiBVWCbZKnyXD4flJ
         MpfXSi3ltQLSD9kROrEWC4+kPQpK8CusbUn/bHdWjPclSIumOjeHpn3c9/1fyBxj2jQB
         IOxLIUJS/zkPr/IGHqzH7yuVsF1hn2v7jW031IDfOoYtwttaRM3ned6V1Fsl0PfOEwC0
         DM/k9/Zd9R56PtGd5Isk4w712QHMBJBWq3yoO3bAWrrUPSGY4t3AFiRw3Mt0D9KBd4ZQ
         sN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754879002; x=1755483802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zc0OmXKKIKzJxLhoELmXzeUr9qo5ipAMm7/O57p0HGY=;
        b=v5d83odNuBQP+6jyWt52vG6crKCmfJBNHDuV/rwADb5UGo/X/lKBuiD31/vdWAf5GJ
         lTH8znwKOgHYjATrM7eCFfTk0ss77h7uTGL2jjwbXfa7SOrNlFYFb1dvDJcFXtkNIRkU
         VxQWmliG4Gym1/p8o6i1AY2caVQpSbAMihdM0LzcErKqfwBZFSvC6nYQ1kRwAPJFas6w
         yKJ6GVvdOV5wx10+bBllwvcMchqf6V0AphTaDWONN9isyPOqT/ox0Fqk9Au4f+8rSqSI
         wSeqOXh4BGkxqJ3AuK6q9dRhylveib+x8Hnp++PqYJZWoAC1QkZVq4GfrB1B1Xfkd2da
         Iqlw==
X-Forwarded-Encrypted: i=1; AJvYcCURP+4UlJYZLZ01Fu0hUpC9dnRBJoajTl+0ggMuJA1YQ/gD7onnAVMOwD6EJQgrqk7A75srxkG1b2MZcQPAP3pgZ6LVAg==@vger.kernel.org, AJvYcCVcUpHQj6ANQmBW4+8IV2XEprcP76PbC/iHba94SgGeWg05lEvV/x4bLLhVMnK0t127djzEgDtB0MOQ/X4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0ynZ21zl4bMf7pPaCtUW0DSDoV2t+4YABignQNdGP1bQcNfr
	v5PbNhEBI4wSv74t3ZfKxa2gk6cUeK5T59ubLOQjxNE6qsERmM2xFWzR
X-Gm-Gg: ASbGncurgg8WF4FChxaYw4xkdjg1IhrhHKQNdmxMN9YGZGEh89xSg4XRRR9nXVobuki
	MGTGp17QqcpYB8Q7DEGYaaQRKIKMDIKdW3Ar+LncVtyvPl3g7JrWdr3lc9sA4RFpgn1MF1f5XM8
	iVJCAY4ncgA0TumY+PQ09BBQOOiXvNScvstdXcmqcqx560t1NX1ppCV4kTRx6hnn+MMhUflqWLT
	zLJBvBrCwuVXr9TFycV7pkWc+YRBwP9XY7CkCFdSfJlGm0lg+eYDGrVMXLafkvnS4Pp/+VsyXkE
	6wXymdmJpmmaIvI6UxV3ApgoUr8ny2odLoGLmbnW25+C8d0FYeW1CgTJZ+4o11WYaI2lnqJeDaH
	iCyYirZGy16gIdNQ5KJALs3bZDrTmGGbV3YTaqAs1OAK5nw==
X-Google-Smtp-Source: AGHT+IHVIafIzp2Ny4atF7F4CpYo8rTGVyou4mhKOPf9znFtYZduCLWZ99MsCK4L1IL2zWUQgCIhXw==
X-Received: by 2002:a05:6a20:3ca5:b0:23d:de52:a5c9 with SMTP id adf61e73a8af0-240550142eemr16946211637.1.1754879001839;
        Sun, 10 Aug 2025 19:23:21 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422be2b3a5sm21880366a12.46.2025.08.10.19.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 19:23:21 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] platform/x86: x86-android-tablets: convert gpio_keys devices to GPIO references
Date: Sun, 10 Aug 2025 19:22:57 -0700
Message-ID: <20250810-x86-andoroid-tablet-v2-11-9c7a1b3c32b2@gmail.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
In-Reply-To: <20250810-x86-andoroid-tablet-v2-0-9c7a1b3c32b2@gmail.com>
References: <20250810-x86-andoroid-tablet-v2-0-9c7a1b3c32b2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-e44bb
Content-Transfer-Encoding: 8bit

Now that gpiolib supports software nodes to describe GPIOs, switch the
driver away from using GPIO lookup tables for wm1502 devices to using
PROPERTY_ENTRY_GPIO().

With that we can remove support for gpiod_lookup_tables from the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/asus.c    |  42 ++++---
 drivers/platform/x86/x86-android-tablets/core.c    |  44 +++----
 drivers/platform/x86/x86-android-tablets/lenovo.c  |  79 +++++++-----
 drivers/platform/x86/x86-android-tablets/other.c   | 138 +++++++++++++--------
 .../x86/x86-android-tablets/x86-android-tablets.h  |  10 +-
 5 files changed, 177 insertions(+), 136 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/asus.c b/drivers/platform/x86/x86-android-tablets/asus.c
index ce581d161551..91245f1bfd87 100644
--- a/drivers/platform/x86/x86-android-tablets/asus.c
+++ b/drivers/platform/x86/x86-android-tablets/asus.c
@@ -10,7 +10,7 @@
 
 #include <linux/gpio/machine.h>
 #include <linux/gpio/property.h>
-#include <linux/input.h>
+#include <linux/input-event-codes.h>
 #include <linux/platform_device.h>
 
 #include "shared-psy-info.h"
@@ -31,17 +31,29 @@ static const struct platform_device_info asus_me176c_tf103c_pdevs[] __initconst
 	},
 };
 
-static const struct x86_gpio_button asus_me176c_tf103c_lid __initconst = {
-	.button = {
-		.code = SW_LID,
-		.active_low = true,
-		.desc = "lid_sw",
-		.type = EV_SW,
-		.wakeup = true,
-		.debounce_interval = 50,
-	},
-	.chip = "INT33FC:02",
-	.pin = 12,
+static const struct software_node asus_me176c_tf103c_gpio_keys_node = {
+	.name = "lid_sw",
+};
+
+static const struct property_entry asus_me176c_tf103c_lid_props[] = {
+	PROPERTY_ENTRY_U32("linux,input-type", EV_SW),
+	PROPERTY_ENTRY_U32("linux,code", SW_LID),
+	PROPERTY_ENTRY_STRING("label", "lid_sw"),
+	PROPERTY_ENTRY_GPIO("gpios", &baytrail_gpiochip_nodes[2], 12, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_U32("debounce-interval", 50),
+	PROPERTY_ENTRY_BOOL("wakeup-source"),
+	{ }
+};
+
+static const struct software_node asus_me176c_tf103c_lid_node = {
+	.parent = &asus_me176c_tf103c_gpio_keys_node,
+	.properties = asus_me176c_tf103c_lid_props,
+};
+
+static const struct software_node *asus_me176c_tf103c_lid_swnodes[] = {
+	&asus_me176c_tf103c_gpio_keys_node,
+	&asus_me176c_tf103c_lid_node,
+	NULL
 };
 
 /* Asus ME176C tablets have an Android factory image with everything hardcoded */
@@ -177,8 +189,7 @@ const struct x86_dev_info asus_me176c_info __initconst = {
 	.pdev_count = ARRAY_SIZE(asus_me176c_tf103c_pdevs),
 	.serdev_info = asus_me176c_serdevs,
 	.serdev_count = ARRAY_SIZE(asus_me176c_serdevs),
-	.gpio_button = &asus_me176c_tf103c_lid,
-	.gpio_button_count = 1,
+	.gpio_button_swnodes = asus_me176c_tf103c_lid_swnodes,
 	.bat_swnode = &generic_lipo_hv_4v35_battery_node,
 	.modules = bq24190_modules,
 	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
@@ -301,8 +312,7 @@ const struct x86_dev_info asus_tf103c_info __initconst = {
 	.i2c_client_count = ARRAY_SIZE(asus_tf103c_i2c_clients),
 	.pdev_info = asus_me176c_tf103c_pdevs,
 	.pdev_count = ARRAY_SIZE(asus_me176c_tf103c_pdevs),
-	.gpio_button = &asus_me176c_tf103c_lid,
-	.gpio_button_count = 1,
+	.gpio_button_swnodes = asus_me176c_tf103c_lid_swnodes,
 	.bat_swnode = &generic_lipo_4v2_battery_node,
 	.modules = bq24190_modules,
 	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 94942921b203..232f6076aa99 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -152,7 +152,7 @@ static struct i2c_client **i2c_clients;
 static struct spi_device **spi_devs;
 static struct platform_device **pdevs;
 static struct serdev_device **serdevs;
-static struct gpio_keys_button *buttons;
+static const struct software_node **gpio_button_swnodes;
 static const struct software_node *bat_swnode;
 static const struct software_node **gpiochip_node_group;
 static void (*exit_handler)(void);
@@ -374,7 +374,6 @@ static void x86_android_tablet_remove(struct platform_device *pdev)
 		platform_device_unregister(pdevs[i]);
 
 	kfree(pdevs);
-	kfree(buttons);
 
 	for (i = spi_dev_count - 1; i >= 0; i--)
 		spi_unregister_device(spi_devs[i]);
@@ -389,6 +388,9 @@ static void x86_android_tablet_remove(struct platform_device *pdev)
 	if (exit_handler)
 		exit_handler();
 
+	if (gpio_button_swnodes)
+		software_node_unregister_node_group(gpio_button_swnodes);
+
 	if (bat_swnode)
 		software_node_unregister(bat_swnode);
 
@@ -515,38 +517,22 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (dev_info->gpio_button_count) {
-		struct gpio_keys_platform_data pdata = { };
-		struct gpio_desc *gpiod;
+	if (dev_info->gpio_button_swnodes) {
+		struct platform_device_info button_info = {
+			.name = "gpio-keys",
+			.id = PLATFORM_DEVID_AUTO,
+		};
 
-		buttons = kcalloc(dev_info->gpio_button_count, sizeof(*buttons), GFP_KERNEL);
-		if (!buttons) {
+		ret = software_node_register_node_group(dev_info->gpio_button_swnodes);
+		if (ret < 0) {
 			x86_android_tablet_remove(pdev);
-			return -ENOMEM;
-		}
-
-		for (i = 0; i < dev_info->gpio_button_count; i++) {
-			ret = x86_android_tablet_get_gpiod(dev_info->gpio_button[i].chip,
-							   dev_info->gpio_button[i].pin,
-							   dev_info->gpio_button[i].button.desc,
-							   false, GPIOD_IN, &gpiod);
-			if (ret < 0) {
-				x86_android_tablet_remove(pdev);
-				return ret;
-			}
-
-			buttons[i] = dev_info->gpio_button[i].button;
-			buttons[i].gpio = desc_to_gpio(gpiod);
-			/* Release GPIO descriptor so that gpio-keys can request it */
-			devm_gpiod_put(&x86_android_tablet_device->dev, gpiod);
+			return ret;
 		}
 
-		pdata.buttons = buttons;
-		pdata.nbuttons = dev_info->gpio_button_count;
+		gpio_button_swnodes = dev_info->gpio_button_swnodes;
 
-		pdevs[pdev_count] = platform_device_register_data(&pdev->dev, "gpio-keys",
-								  PLATFORM_DEVID_AUTO,
-								  &pdata, sizeof(pdata));
+		button_info.fwnode = software_node_fwnode(dev_info->gpio_button_swnodes[0]);
+		pdevs[pdev_count] = platform_device_register_full(&button_info);
 		if (IS_ERR(pdevs[pdev_count])) {
 			ret = PTR_ERR(pdevs[pdev_count]);
 			x86_android_tablet_remove(pdev);
diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index 7c6a6fc6be42..0cee7f4f1f98 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -13,6 +13,7 @@
 #include <linux/efi.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio/property.h>
+#include <linux/input-event-codes.h>
 #include <linux/mfd/arizona/pdata.h>
 #include <linux/mfd/arizona/registers.h>
 #include <linux/mfd/intel_soc_pmic.h>
@@ -199,17 +200,34 @@ static const struct x86_serdev_info lenovo_yb1_x90_serdevs[] __initconst = {
 	},
 };
 
-static const struct x86_gpio_button lenovo_yb1_x90_lid __initconst = {
-	.button = {
-		.code = SW_LID,
-		.active_low = true,
-		.desc = "lid_sw",
-		.type = EV_SW,
-		.wakeup = true,
-		.debounce_interval = 50,
-	},
-	.chip = "INT33FF:02",
-	.pin = 19,
+/*
+ * Software node attached to gpio-keys device representing the LID and
+ * serving as a parent to software nodes representing individual keys/buttons
+ * as required by the device tree binding.
+ */
+static const struct software_node lenovo_lid_gpio_keys_node = {
+	.name = "lid_sw",
+};
+
+static const struct property_entry lenovo_yb1_x90_lid_props[] = {
+	PROPERTY_ENTRY_U32("linux,input-type", EV_SW),
+	PROPERTY_ENTRY_U32("linux,code", SW_LID),
+	PROPERTY_ENTRY_STRING("label", "lid_sw"),
+	PROPERTY_ENTRY_GPIO("gpios", &cherryview_gpiochip_nodes[2], 19, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_U32("debounce-interval", 50),
+	PROPERTY_ENTRY_BOOL("wakeup-source"),
+	{ }
+};
+
+static const struct software_node lenovo_yb1_x90_lid_node = {
+	.parent = &lenovo_lid_gpio_keys_node,
+	.properties = lenovo_yb1_x90_lid_props,
+};
+
+static const struct software_node *lenovo_yb1_x90_lid_swnodes[] = {
+	&lenovo_lid_gpio_keys_node,
+	&lenovo_yb1_x90_lid_node,
+	NULL
 };
 
 static int __init lenovo_yb1_x90_init(struct device *dev)
@@ -238,8 +256,7 @@ const struct x86_dev_info lenovo_yogabook_x90_info __initconst = {
 	.pdev_count = ARRAY_SIZE(lenovo_yb1_x90_pdevs),
 	.serdev_info = lenovo_yb1_x90_serdevs,
 	.serdev_count = ARRAY_SIZE(lenovo_yb1_x90_serdevs),
-	.gpio_button = &lenovo_yb1_x90_lid,
-	.gpio_button_count = 1,
+	.gpio_button_swnodes = lenovo_yb1_x90_lid_swnodes,
 	.gpiochip_type = X86_GPIOCHIP_CHERRYVIEW,
 	.init = lenovo_yb1_x90_init,
 };
@@ -276,17 +293,25 @@ static const struct software_node lenovo_yoga_tab2_830_1050_bq24190_node = {
 	.properties = lenovo_yoga_tab2_830_1050_bq24190_props,
 };
 
-static const struct x86_gpio_button lenovo_yoga_tab2_830_1050_lid __initconst = {
-	.button = {
-		.code = SW_LID,
-		.active_low = true,
-		.desc = "lid_sw",
-		.type = EV_SW,
-		.wakeup = true,
-		.debounce_interval = 50,
-	},
-	.chip = "INT33FC:02",
-	.pin = 26,
+static const struct property_entry lenovo_yoga_tab2_830_1050_lid_props[] = {
+	PROPERTY_ENTRY_U32("linux,input-type", EV_SW),
+	PROPERTY_ENTRY_U32("linux,code", SW_LID),
+	PROPERTY_ENTRY_STRING("label", "lid_sw"),
+	PROPERTY_ENTRY_GPIO("gpios", &baytrail_gpiochip_nodes[2], 26, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_U32("debounce-interval", 50),
+	PROPERTY_ENTRY_BOOL("wakeup-source"),
+	{ }
+};
+
+static const struct software_node lenovo_yoga_tab2_830_1050_lid_node = {
+	.parent = &lenovo_lid_gpio_keys_node,
+	.properties = lenovo_yoga_tab2_830_1050_lid_props,
+};
+
+static const struct software_node *lenovo_yoga_tab2_830_1050_lid_swnodes[] = {
+	&lenovo_lid_gpio_keys_node,
+	&lenovo_yoga_tab2_830_1050_lid_node,
+	NULL
 };
 
 /* This gets filled by lenovo_yoga_tab2_830_1050_init() */
@@ -422,8 +447,7 @@ const struct x86_dev_info lenovo_yoga_tab2_830_1050_info __initconst = {
 	.i2c_client_count = ARRAY_SIZE(lenovo_yoga_tab2_830_1050_i2c_clients),
 	.pdev_info = lenovo_yoga_tab2_830_1050_pdevs,
 	.pdev_count = ARRAY_SIZE(lenovo_yoga_tab2_830_1050_pdevs),
-	.gpio_button = &lenovo_yoga_tab2_830_1050_lid,
-	.gpio_button_count = 1,
+	.gpio_button_swnodes = lenovo_yoga_tab2_830_1050_lid_swnodes,
 	.bat_swnode = &generic_lipo_hv_4v35_battery_node,
 	.modules = bq24190_modules,
 	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
@@ -785,8 +809,7 @@ const struct x86_dev_info lenovo_yoga_tab2_1380_info __initconst = {
 	.i2c_client_count = ARRAY_SIZE(lenovo_yoga_tab2_1380_i2c_clients),
 	.pdev_info = lenovo_yoga_tab2_1380_pdevs,
 	.pdev_count = ARRAY_SIZE(lenovo_yoga_tab2_1380_pdevs),
-	.gpio_button = &lenovo_yoga_tab2_830_1050_lid,
-	.gpio_button_count = 1,
+	.gpio_button_swnodes = lenovo_yoga_tab2_830_1050_lid_swnodes,
 	.bat_swnode = &generic_lipo_hv_4v35_battery_node,
 	.modules = lenovo_yoga_tab2_1380_modules,
 	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index 38c5e7bd88b0..8bb63546097f 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -11,7 +11,7 @@
 #include <linux/acpi.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio/property.h>
-#include <linux/input.h>
+#include <linux/input-event-codes.h>
 #include <linux/leds.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -115,22 +115,32 @@ const struct x86_dev_info acer_b1_750_info __initconst = {
  * which is not described in the ACPI tables in anyway.
  * Use the x86-android-tablets infra to create a gpio-keys device for this.
  */
-static const struct x86_gpio_button advantech_mica_071_button __initconst = {
-	.button = {
-		.code = KEY_PROG1,
-		.active_low = true,
-		.desc = "prog1_key",
-		.type = EV_KEY,
-		.wakeup = false,
-		.debounce_interval = 50,
-	},
-	.chip = "INT33FC:00",
-	.pin = 2,
+static const struct software_node advantech_mica_071_gpio_keys_node = {
+	.name = "prog1_key",
+};
+
+static const struct property_entry advantech_mica_071_prog1_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", KEY_PROG1),
+	PROPERTY_ENTRY_STRING("label", "prog1_key"),
+	PROPERTY_ENTRY_GPIO("gpios", &baytrail_gpiochip_nodes[0], 2, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_U32("debounce-interval", 50),
+	{ }
+};
+
+static const struct software_node advantech_mica_071_prog1_key_node = {
+	.parent = &advantech_mica_071_gpio_keys_node,
+	.properties = advantech_mica_071_prog1_key_props,
+};
+
+static const struct software_node *advantech_mica_071_button_swnodes[] = {
+	&advantech_mica_071_gpio_keys_node,
+	&advantech_mica_071_prog1_key_node,
+	NULL
 };
 
 const struct x86_dev_info advantech_mica_071_info __initconst = {
-	.gpio_button = &advantech_mica_071_button,
-	.gpio_button_count = 1,
+	.gpio_button_swnodes = advantech_mica_071_button_swnodes,
+	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
 };
 
 /*
@@ -226,36 +236,46 @@ const struct x86_dev_info chuwi_hi8_info __initconst = {
  * in the button row with the power + volume-buttons labeled P and F.
  * Use the x86-android-tablets infra to create a gpio-keys device for these.
  */
-static const struct x86_gpio_button cyberbook_t116_buttons[] __initconst = {
-	{
-		.button = {
-			.code = KEY_PROG1,
-			.active_low = true,
-			.desc = "prog1_key",
-			.type = EV_KEY,
-			.wakeup = false,
-			.debounce_interval = 50,
-		},
-		.chip = "INT33FF:00",
-		.pin = 30,
-	},
-	{
-		.button = {
-			.code = KEY_PROG2,
-			.active_low = true,
-			.desc = "prog2_key",
-			.type = EV_KEY,
-			.wakeup = false,
-			.debounce_interval = 50,
-		},
-		.chip = "INT33FF:03",
-		.pin = 48,
-	},
+static const struct software_node cyberbook_t116_gpio_keys_node = {
+	.name = "prog_keys",
+};
+
+static const struct property_entry cyberbook_t116_prog1_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", KEY_PROG1),
+	PROPERTY_ENTRY_STRING("label", "prog1_key"),
+	PROPERTY_ENTRY_GPIO("gpios", &cherryview_gpiochip_nodes[0], 30, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_U32("debounce-interval", 50),
+	{ }
+};
+
+static const struct software_node cyberbook_t116_prog1_key_node = {
+	.parent = &cyberbook_t116_gpio_keys_node,
+	.properties = cyberbook_t116_prog1_key_props,
+};
+
+static const struct property_entry cyberbook_t116_prog2_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", KEY_PROG2),
+	PROPERTY_ENTRY_STRING("label", "prog2_key"),
+	PROPERTY_ENTRY_GPIO("gpios", &cherryview_gpiochip_nodes[3], 48, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_U32("debounce-interval", 50),
+	{ }
+};
+
+static const struct software_node cyberbook_t116_prog2_key_node = {
+	.parent = &cyberbook_t116_gpio_keys_node,
+	.properties = cyberbook_t116_prog2_key_props,
+};
+
+static const struct software_node *cyberbook_t116_buttons_swnodes[] = {
+	&cyberbook_t116_gpio_keys_node,
+	&cyberbook_t116_prog1_key_node,
+	&cyberbook_t116_prog2_key_node,
+	NULL
 };
 
 const struct x86_dev_info cyberbook_t116_info __initconst = {
-	.gpio_button = cyberbook_t116_buttons,
-	.gpio_button_count = ARRAY_SIZE(cyberbook_t116_buttons),
+	.gpio_button_swnodes = cyberbook_t116_buttons_swnodes,
+	.gpiochip_type = X86_GPIOCHIP_CHERRYVIEW,
 };
 
 #define CZC_EC_EXTRA_PORT	0x68
@@ -495,22 +515,32 @@ const struct x86_dev_info nextbook_ares8a_info __initconst = {
  * This button has a WMI interface, but that is broken. Instead of trying to
  * use the broken WMI interface, instantiate a gpio-keys device for this.
  */
-static const struct x86_gpio_button peaq_c1010_button __initconst = {
-	.button = {
-		.code = KEY_SOUND,
-		.active_low = true,
-		.desc = "dolby_key",
-		.type = EV_KEY,
-		.wakeup = false,
-		.debounce_interval = 50,
-	},
-	.chip = "INT33FC:00",
-	.pin = 3,
+static const struct software_node peaq_c1010_gpio_keys_node = {
+	.name = "gpio_keys",
+};
+
+static const struct property_entry peaq_c1010_dolby_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", KEY_SOUND),
+	PROPERTY_ENTRY_STRING("label", "dolby_key"),
+	PROPERTY_ENTRY_GPIO("gpios", &baytrail_gpiochip_nodes[0], 3, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_U32("debounce-interval", 50),
+	{ }
+};
+
+static const struct software_node peaq_c1010_dolby_key_node = {
+	.parent = &peaq_c1010_gpio_keys_node,
+	.properties = peaq_c1010_dolby_key_props,
+};
+
+static const struct software_node *peaq_c1010_button_swnodes[] = {
+	&peaq_c1010_gpio_keys_node,
+	&peaq_c1010_dolby_key_node,
+	NULL
 };
 
 const struct x86_dev_info peaq_c1010_info __initconst = {
-	.gpio_button = &peaq_c1010_button,
-	.gpio_button_count = 1,
+	.gpio_button_swnodes = peaq_c1010_button_swnodes,
+	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
 };
 
 /*
diff --git a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
index d037e3962a51..f4a67a9b74ea 100644
--- a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
+++ b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
@@ -11,7 +11,6 @@
 #define __PDX86_X86_ANDROID_TABLETS_H
 
 #include <linux/gpio/consumer.h>
-#include <linux/gpio_keys.h>
 #include <linux/i2c.h>
 #include <linux/irqdomain_defs.h>
 #include <linux/spi/spi.h>
@@ -81,12 +80,6 @@ struct x86_serdev_info {
 	const char *serdev_hid;
 };
 
-struct x86_gpio_button {
-	struct gpio_keys_button button;
-	const char *chip;
-	int pin;
-};
-
 struct x86_dev_info {
 	const char * const *modules;
 	const struct software_node *bat_swnode;
@@ -94,12 +87,11 @@ struct x86_dev_info {
 	const struct x86_spi_dev_info *spi_dev_info;
 	const struct platform_device_info *pdev_info;
 	const struct x86_serdev_info *serdev_info;
-	const struct x86_gpio_button *gpio_button;
+	const struct software_node **gpio_button_swnodes;
 	int i2c_client_count;
 	int spi_dev_count;
 	int pdev_count;
 	int serdev_count;
-	int gpio_button_count;
 	int (*init)(struct device *dev);
 	void (*exit)(void);
 	bool use_pci;

-- 
2.51.0.rc0.155.g4a0f42376b-goog


