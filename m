Return-Path: <linux-kernel+bounces-761719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 155D3B1FDB5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148B61898898
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780FC25A32E;
	Mon, 11 Aug 2025 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duiYOcRH"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A4670823;
	Mon, 11 Aug 2025 02:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754878995; cv=none; b=Ftufe+9F5ojZyFhd2ARCN9nMbln7oPvVEPhDdNNnxBvt6RCMhNCLaMJV6tyOaZvhnysa8EgoTp0YCJ11T72lSVc0vT/TYUsRVpwMICeAmFBj6ELfJlYGScdtcTAzXkLRKQdnDbeYdi+gkdEWUVhHbeOilnli7RhhwMdN5liunbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754878995; c=relaxed/simple;
	bh=mtGnTfnyeJ4h4MvSNwOYVf86NrrUxSZC6Op+FLPW0bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjJAxqAN6WygyKeYuUA5kwi+NY5Y5r0mE6W4GM4BHIdzEx33Ume7aXnMxaMMdSK6D909Os9pjeH3HVys6+93ByNyfDfEMU01/53bcNi/S+ZuGqp/xGjECsP/kj3vAmPyeo2Z4ZmBDTqpycDazxVfUoU7G2axLVgBp0xnQcw1s+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duiYOcRH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76b77a97a04so3393000b3a.1;
        Sun, 10 Aug 2025 19:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754878993; x=1755483793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5YkaQ7ud/PDBnvksOZ9mU1mS0vRmz7q3Fp2ER6X87Y=;
        b=duiYOcRHSP70U+ywqqJT2CGcrlEf6NbYOQGnO2N2IsN1YXKDvHX28Wdk+p2ZTVlPq4
         trR0qal+F/1TEgg/sc5ulHL8G4C6+MKoVTSv4MMVwTHi70PQeQjN9Cc7REOwiupMxRp0
         cFwzTSDfOx5H5rwEUdHQl0KGJbA2JzJ7v2Tem96Ym71AOmyC/VtIN5P39Wo6WuQxjzvu
         mVLc3uVmPA+E5xAn9Evgf9ErW2hcmN+5paxIusuSHvh+Lcir+ggrjXai2rKQ2cG0PgYC
         5OTDWugxSZheUu/4bCm76/gGAntYhp3c50QPH6YBcM4W4ezaNF0DkHJ1hmVN36CQ9A4z
         zo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754878993; x=1755483793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5YkaQ7ud/PDBnvksOZ9mU1mS0vRmz7q3Fp2ER6X87Y=;
        b=gZQcq5FNHaoVP2Pg/7eBcn30Nv6NClbVeIuA8YOZH1E7IVht0nSWJiXKA1Wl1N1k3v
         ehgfjhqkM15NvTk0GIkqVAWxY0XSsGu9/6iRJrhv0artSemfhiWXcPT/gOVGIqbUuw6R
         nAx7WVN1FIvcfGqJqpx+2KWvOmIJqXwA/yvZQHsKhLitAm2dngAYfQ4+hZ9BxQ0kYyHX
         zBNUUmeTM+H0RI+swByzV6KisgkNKnbdpqrP6VbE9PN6o/KfYAAu7OJDO+jBM1TwmVUJ
         Ah6PZsAc0OuNtImRq8+a38golgrKH1MKKqXS7FV+qJesdiFUyDQbd6xYxGR79tWQBuwB
         4KdA==
X-Forwarded-Encrypted: i=1; AJvYcCVKdMoryVmH0haMZkJJl33UcqDyxSgjrw7gmzE5rD969A9Y57uOd9wpUYhPUi/wyuFb5hOV53v2VHLa014=@vger.kernel.org, AJvYcCWftRYPT/TpclRX9PZnCZdusQRKTnDg0ZysBwBB4qUEKTyMQAfk4baPi1j9SL5938Nhnv8UtYkQSGKYPgbuP7HeL2iWvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmjj2YEEZNu/wNJ1d7FRE3KadN7CU6qJLyyImO6M8e4SK+j68q
	IO+D21Ur0nMG5lSmvjbSw3QJam1+Sv4qdRlUiUyvy21N/rrYCg4xBlxiFkPhzA==
X-Gm-Gg: ASbGncsUvjfNEJ64USCSdnq8W0Y1JhxZQfONa3IubZKb4qDB7OLDBMRnTxDhSzpXn8l
	RcQaQWoaVtp6uKoTmM4PPkZwR9onRj7QFXEX2nNtyqsMz6F8AGzuJxn8SJjEmEP7bpEoEjOsu/G
	UiQ/+V0c75O3P77TCwnrtgIxJ9pHNssiL94+7uKuhxbhM+j/I9qx1DliGkiQ89BoQT6rVFgdtoq
	5XgYAIlOasYqu2fJgtFXACMrv0i0z525M/LvCqYPATT7bKnLTU1Z4E4F1W+KURx0/sNmft8x+Qv
	sfaYDL+x6API/qsAW8ihpBN1TrA/y6uvFDE8CVZSuKOd6cXr4+MJume7/IuJ2cFVGCjgCkD+Fi7
	ejHVPt1uJFiZ2SuAd/9MWYN/8jsFMGF91YNnmGb4bTe82tQ==
X-Google-Smtp-Source: AGHT+IGsSjWIuxGnYM3vLIY01D7lO7FQq1Bvu2vExf1Yv2nV64+AzIQX7Pc2wXEaoooUJWsfw00Akw==
X-Received: by 2002:a05:6a20:1611:b0:237:d013:8a78 with SMTP id adf61e73a8af0-240551d83f2mr14627422637.37.1754878992632;
        Sun, 10 Aug 2025 19:23:12 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422be2b3a5sm21880366a12.46.2025.08.10.19.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 19:23:12 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] platform/x86: x86-android-tablets: convert Goodix devices to GPIO references
Date: Sun, 10 Aug 2025 19:22:47 -0700
Message-ID: <20250810-x86-andoroid-tablet-v2-1-9c7a1b3c32b2@gmail.com>
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
driver away from using GPIO lookup tables for Goodix touchscreens to
using PROPERTY_ENTRY_GPIO() to keep all touchscreen properties together.

Since the tablets are using either Baytrail or Cherryview GPIO
controllers x86_dev_info structure has been extended to carry gpiochip
type information so that the code can instantiate correct set of
software nodes representing the GPIO chip.

Because this adds a new point of failure in x86_android_tablet_probe(),
x86_android_tablet_remove() is rearranged to handle cases where battery
swnode has not been registered yet, and registering of GPIO lookup
tables is moved earlier as it can not fail.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/asus.c    | 23 ++++----
 drivers/platform/x86/x86-android-tablets/core.c    | 69 +++++++++++++++++++---
 drivers/platform/x86/x86-android-tablets/lenovo.c  | 23 ++++----
 drivers/platform/x86/x86-android-tablets/other.c   | 37 +++---------
 .../x86/x86-android-tablets/x86-android-tablets.h  | 11 ++++
 5 files changed, 105 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/asus.c b/drivers/platform/x86/x86-android-tablets/asus.c
index 97cd14c1fd23..6c4468f4004b 100644
--- a/drivers/platform/x86/x86-android-tablets/asus.c
+++ b/drivers/platform/x86/x86-android-tablets/asus.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <linux/input.h>
 #include <linux/platform_device.h>
 
@@ -77,6 +78,16 @@ static const struct software_node asus_me176c_ug3105_node = {
 	.properties = asus_me176c_ug3105_props,
 };
 
+static const struct property_entry asus_me176c_touchscreen_props[] = {
+	PROPERTY_ENTRY_GPIO("reset-gpios", &baytrail_gpiochip_nodes[0], 60, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("irq-gpios", &baytrail_gpiochip_nodes[2], 28, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node asus_me176c_touchscreen_node = {
+	.properties = asus_me176c_touchscreen_props,
+};
+
 static const struct x86_i2c_client_info asus_me176c_i2c_clients[] __initconst = {
 	{
 		/* bq24297 battery charger */
@@ -132,6 +143,7 @@ static const struct x86_i2c_client_info asus_me176c_i2c_clients[] __initconst =
 			.type = "GDIX1001:00",
 			.addr = 0x14,
 			.dev_name = "goodix_ts",
+			.swnode = &asus_me176c_touchscreen_node,
 		},
 		.adapter_path = "\\_SB_.I2C6",
 		.irq_data = {
@@ -152,18 +164,8 @@ static const struct x86_serdev_info asus_me176c_serdevs[] __initconst = {
 	},
 };
 
-static struct gpiod_lookup_table asus_me176c_goodix_gpios = {
-	.dev_id = "i2c-goodix_ts",
-	.table = {
-		GPIO_LOOKUP("INT33FC:00", 60, "reset", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FC:02", 28, "irq", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
 static struct gpiod_lookup_table * const asus_me176c_gpios[] = {
 	&int3496_gpo2_pin22_gpios,
-	&asus_me176c_goodix_gpios,
 	NULL
 };
 
@@ -179,6 +181,7 @@ const struct x86_dev_info asus_me176c_info __initconst = {
 	.gpiod_lookup_tables = asus_me176c_gpios,
 	.bat_swnode = &generic_lipo_hv_4v35_battery_node,
 	.modules = bq24190_modules,
+	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
 };
 
 /* Asus TF103C tablets have an Android factory image with everything hardcoded */
diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 2a9c47178505..b0d63d3c05cd 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -155,6 +155,7 @@ static struct serdev_device **serdevs;
 static struct gpio_keys_button *buttons;
 static struct gpiod_lookup_table * const *gpiod_lookup_tables;
 static const struct software_node *bat_swnode;
+static const struct software_node **gpiochip_node_group;
 static void (*exit_handler)(void);
 
 static __init struct i2c_adapter *
@@ -331,6 +332,34 @@ static __init int x86_instantiate_serdev(const struct x86_dev_info *dev_info, in
 	return ret;
 }
 
+const struct software_node baytrail_gpiochip_nodes[] = {
+	{ .name = "INT33FC:00" },
+	{ .name = "INT33FC:01" },
+	{ .name = "INT33FC:02" },
+};
+
+static const struct software_node *baytrail_gpiochip_node_group[] = {
+	&baytrail_gpiochip_nodes[0],
+	&baytrail_gpiochip_nodes[1],
+	&baytrail_gpiochip_nodes[2],
+	NULL
+};
+
+const struct software_node cherryview_gpiochip_nodes[] = {
+	{ .name = "INT33FF:00" },
+	{ .name = "INT33FF:01" },
+	{ .name = "INT33FF:02" },
+	{ .name = "INT33FF:03" },
+};
+
+static const struct software_node *cherryview_gpiochip_node_group[] = {
+	&cherryview_gpiochip_nodes[0],
+	&cherryview_gpiochip_nodes[1],
+	&cherryview_gpiochip_nodes[2],
+	&cherryview_gpiochip_nodes[3],
+	NULL
+};
+
 static void x86_android_tablet_remove(struct platform_device *pdev)
 {
 	int i;
@@ -361,10 +390,14 @@ static void x86_android_tablet_remove(struct platform_device *pdev)
 	if (exit_handler)
 		exit_handler();
 
+	if (bat_swnode)
+		software_node_unregister(bat_swnode);
+
+	if (gpiochip_node_group)
+		software_node_unregister_node_group(gpiochip_node_group);
+
 	for (i = 0; gpiod_lookup_tables && gpiod_lookup_tables[i]; i++)
 		gpiod_remove_lookup_table(gpiod_lookup_tables[i]);
-
-	software_node_unregister(bat_swnode);
 }
 
 static __init int x86_android_tablet_probe(struct platform_device *pdev)
@@ -388,16 +421,36 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
 	for (i = 0; dev_info->modules && dev_info->modules[i]; i++)
 		request_module(dev_info->modules[i]);
 
-	bat_swnode = dev_info->bat_swnode;
-	if (bat_swnode) {
-		ret = software_node_register(bat_swnode);
+	gpiod_lookup_tables = dev_info->gpiod_lookup_tables;
+	for (i = 0; gpiod_lookup_tables && gpiod_lookup_tables[i]; i++)
+		gpiod_add_lookup_table(gpiod_lookup_tables[i]);
+
+	switch (dev_info->gpiochip_type) {
+	case X86_GPIOCHIP_BAYTRAIL:
+		gpiochip_node_group = baytrail_gpiochip_node_group;
+		break;
+	case X86_GPIOCHIP_CHERRYVIEW:
+		gpiochip_node_group = cherryview_gpiochip_node_group;
+		break;
+	case X86_GPIOCHIP_UNSPECIFIED:
+		gpiochip_node_group = NULL;
+		break;
+	}
+
+	if (gpiochip_node_group) {
+		ret = software_node_register_node_group(gpiochip_node_group);
 		if (ret)
 			return ret;
 	}
 
-	gpiod_lookup_tables = dev_info->gpiod_lookup_tables;
-	for (i = 0; gpiod_lookup_tables && gpiod_lookup_tables[i]; i++)
-		gpiod_add_lookup_table(gpiod_lookup_tables[i]);
+	if (dev_info->bat_swnode) {
+		ret = software_node_register(dev_info->bat_swnode);
+		if (ret) {
+			x86_android_tablet_remove(pdev);
+			return ret;
+		}
+		bat_swnode = dev_info->bat_swnode;
+	}
 
 	if (dev_info->init) {
 		ret = dev_info->init(&pdev->dev);
diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index 1241a97cda39..22fe76ef5b5a 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -12,6 +12,7 @@
 
 #include <linux/efi.h>
 #include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <linux/mfd/arizona/pdata.h>
 #include <linux/mfd/arizona/registers.h>
 #include <linux/mfd/intel_soc_pmic.h>
@@ -61,6 +62,16 @@ static struct lp855x_platform_data lenovo_lp8557_reg_only_pdata = {
 
 /* Lenovo Yoga Book X90F / X90L's Android factory image has everything hardcoded */
 
+static const struct property_entry lenovo_yb1_x90_goodix_props[] = {
+	PROPERTY_ENTRY_GPIO("reset-gpios", &cherryview_gpiochip_nodes[1], 53, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("irq-gpios", &cherryview_gpiochip_nodes[1], 56, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node lenovo_yb1_x90_goodix_node = {
+	.properties = lenovo_yb1_x90_goodix_props,
+};
+
 static const struct property_entry lenovo_yb1_x90_wacom_props[] = {
 	PROPERTY_ENTRY_U32("hid-descr-addr", 0x0001),
 	PROPERTY_ENTRY_U32("post-reset-deassert-delay-ms", 150),
@@ -108,6 +119,7 @@ static const struct x86_i2c_client_info lenovo_yb1_x90_i2c_clients[] __initconst
 			.type = "GDIX1001:00",
 			.addr = 0x14,
 			.dev_name = "goodix_ts",
+			.swnode = &lenovo_yb1_x90_goodix_node,
 		},
 		.adapter_path = "\\_SB_.PCI0.I2C2",
 		.irq_data = {
@@ -198,15 +210,6 @@ static const struct x86_gpio_button lenovo_yb1_x90_lid __initconst = {
 	.pin = 19,
 };
 
-static struct gpiod_lookup_table lenovo_yb1_x90_goodix_gpios = {
-	.dev_id = "i2c-goodix_ts",
-	.table = {
-		GPIO_LOOKUP("INT33FF:01", 53, "reset", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FF:01", 56, "irq", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
 static struct gpiod_lookup_table lenovo_yb1_x90_hideep_gpios = {
 	.dev_id = "i2c-hideep_ts",
 	.table = {
@@ -225,7 +228,6 @@ static struct gpiod_lookup_table lenovo_yb1_x90_wacom_gpios = {
 
 static struct gpiod_lookup_table * const lenovo_yb1_x90_gpios[] = {
 	&lenovo_yb1_x90_hideep_gpios,
-	&lenovo_yb1_x90_goodix_gpios,
 	&lenovo_yb1_x90_wacom_gpios,
 	NULL
 };
@@ -259,6 +261,7 @@ const struct x86_dev_info lenovo_yogabook_x90_info __initconst = {
 	.gpio_button = &lenovo_yb1_x90_lid,
 	.gpio_button_count = 1,
 	.gpiod_lookup_tables = lenovo_yb1_x90_gpios,
+	.gpiochip_type = X86_GPIOCHIP_CHERRYVIEW,
 	.init = lenovo_yb1_x90_init,
 };
 
diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index f7bd9f863c85..e3907812c8bc 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <linux/input.h>
 #include <linux/leds.h>
 #include <linux/pci.h>
@@ -297,6 +298,8 @@ static const struct software_node medion_lifetab_s10346_accel_node = {
 static const struct property_entry medion_lifetab_s10346_touchscreen_props[] = {
 	PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
 	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_GPIO("reset-gpios", &baytrail_gpiochip_nodes[1], 26, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("irq-gpios", &baytrail_gpiochip_nodes[2], 3, GPIO_ACTIVE_HIGH),
 	{ }
 };
 
@@ -340,24 +343,10 @@ static const struct x86_i2c_client_info medion_lifetab_s10346_i2c_clients[] __in
 	},
 };
 
-static struct gpiod_lookup_table medion_lifetab_s10346_goodix_gpios = {
-	.dev_id = "i2c-goodix_ts",
-	.table = {
-		GPIO_LOOKUP("INT33FC:01", 26, "reset", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FC:02", 3, "irq", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
-static struct gpiod_lookup_table * const medion_lifetab_s10346_gpios[] = {
-	&medion_lifetab_s10346_goodix_gpios,
-	NULL
-};
-
 const struct x86_dev_info medion_lifetab_s10346_info __initconst = {
 	.i2c_client_info = medion_lifetab_s10346_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(medion_lifetab_s10346_i2c_clients),
-	.gpiod_lookup_tables = medion_lifetab_s10346_gpios,
+	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
 };
 
 /* Nextbook Ares 8 (BYT) tablets have an Android factory image with everything hardcoded */
@@ -543,6 +532,8 @@ static const struct property_entry whitelabel_tm800a550l_goodix_props[] = {
 	PROPERTY_ENTRY_STRING("firmware-name", "gt912-tm800a550l.fw"),
 	PROPERTY_ENTRY_STRING("goodix,config-name", "gt912-tm800a550l.cfg"),
 	PROPERTY_ENTRY_U32("goodix,main-clk", 54),
+	PROPERTY_ENTRY_GPIO("reset-gpios", &baytrail_gpiochip_nodes[1], 26, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("irq-gpios", &baytrail_gpiochip_nodes[2], 3, GPIO_ACTIVE_HIGH),
 	{ }
 };
 
@@ -578,24 +569,10 @@ static const struct x86_i2c_client_info whitelabel_tm800a550l_i2c_clients[] __in
 	},
 };
 
-static struct gpiod_lookup_table whitelabel_tm800a550l_goodix_gpios = {
-	.dev_id = "i2c-goodix_ts",
-	.table = {
-		GPIO_LOOKUP("INT33FC:01", 26, "reset", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FC:02", 3, "irq", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
-static struct gpiod_lookup_table * const whitelabel_tm800a550l_gpios[] = {
-	&whitelabel_tm800a550l_goodix_gpios,
-	NULL
-};
-
 const struct x86_dev_info whitelabel_tm800a550l_info __initconst = {
 	.i2c_client_info = whitelabel_tm800a550l_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(whitelabel_tm800a550l_i2c_clients),
-	.gpiod_lookup_tables = whitelabel_tm800a550l_gpios,
+	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
 };
 
 /*
diff --git a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
index dcf8d49e3b5f..a54d09408866 100644
--- a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
+++ b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
@@ -32,6 +32,12 @@ enum x86_acpi_irq_type {
 	X86_ACPI_IRQ_TYPE_PMIC,
 };
 
+enum x86_gpiochip_type {
+	X86_GPIOCHIP_UNSPECIFIED = 0,
+	X86_GPIOCHIP_BAYTRAIL,
+	X86_GPIOCHIP_CHERRYVIEW,
+};
+
 struct x86_acpi_irq_data {
 	char *chip;   /* GPIO chip label (GPIOINT) or PMIC ACPI path (PMIC) */
 	enum x86_acpi_irq_type type;
@@ -99,6 +105,7 @@ struct x86_dev_info {
 	int (*init)(struct device *dev);
 	void (*exit)(void);
 	bool use_pci;
+	enum x86_gpiochip_type gpiochip_type;
 };
 
 int x86_android_tablet_get_gpiod(const char *chip, int pin, const char *con_id,
@@ -106,6 +113,10 @@ int x86_android_tablet_get_gpiod(const char *chip, int pin, const char *con_id,
 				 struct gpio_desc **desc);
 int x86_acpi_irq_helper_get(const struct x86_acpi_irq_data *data);
 
+/* Software nodes representing GPIO chips used by various tablets */
+extern const struct software_node baytrail_gpiochip_nodes[];
+extern const struct software_node cherryview_gpiochip_nodes[];
+
 /*
  * Extern declarations of x86_dev_info structs so there can be a single
  * MODULE_DEVICE_TABLE(dmi, ...), while splitting the board descriptions.

-- 
2.51.0.rc0.155.g4a0f42376b-goog


