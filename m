Return-Path: <linux-kernel+bounces-761724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B6B1FDBE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 701387A4E48
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F321B27A93A;
	Mon, 11 Aug 2025 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c22hs3Ff"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468926CE07;
	Mon, 11 Aug 2025 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754878999; cv=none; b=h/Q6HJFRXJ5bfJ9R1ICfdF9e60TykRNREf9Km3mGJZ1bjnZNzS+C3NojsbQ/koJ8xNszQI39oZk2WOeBVJWzlCXxVz5A3hu/ScllkMI0OGrq+Mqjvu3ZJWo3IWyIhMOnqNmKgB0G0dr7gLr2DGvpDVLhodZ41xsVb2YLBlldSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754878999; c=relaxed/simple;
	bh=eKJcqUHacZN6EZXO9Un/1kkZp7FCDzlf6KDscV6eGNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+k2WNi2bQMcQVitAHMgV/VVkdJ1wmFdW3ZvEfbhbqz9B2fS8trMjBbYZlPoyjh1J3DPLpJPOp1nULvCwL4SGu/XIWh4G5TaGobez2LxvuN/B4WnINQhuWzCff5PRYrO2pjnpMPAbxDoB8zgEGPaVwqgQMnALuuWwkDY8uet3aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c22hs3Ff; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bee58e01cso4531965b3a.1;
        Sun, 10 Aug 2025 19:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754878997; x=1755483797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ+WEeN3LJOVsH6XHrmcNbepzuoFYhqp2xH+LEFjBug=;
        b=c22hs3FfiXaswk6GZqT0OmRaE3btjt2bYpfhf0oUZ6JKM5ZqabETGAemEoYtqotGSo
         bHukhk8eq8Ji3J6o+YIA0V+LbYjB/fK4JW22hNLDeTZrgb6XPBnF9opsmZ46pErmMsS2
         HDxt9xdozuTtyVIeo2BbayhgCZWl5nX1FO3GxnrqSxSYsxbwAOgs5mKH1me3FjOJoc+a
         BBfg6RO7YLEipxq58CNRdRad5P/NT0G5c9WPXS1ACJdJGf+sktlMId/ac4oQEDgo3awQ
         WpdTpGumwAg1eWa3IRcL4LBprylgKT0CTOrNurG5P/Xmphef4T0EjI4dARNEsg9wOYJ1
         rKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754878997; x=1755483797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ+WEeN3LJOVsH6XHrmcNbepzuoFYhqp2xH+LEFjBug=;
        b=XvjSFqnCrsuCTU2VAcjOjBMu4VI4s0xwTOp8Zft+kyHTMc4F3Z5BZ/9KTTKUmttjU9
         TtabiXEhi1st7jWZzCeVv0uRn05joBHXRTx41b/vHvjVn/wq/WeVABqeMHJ5U4KpgHlc
         auD7x9BExxjqONBB/oocICNr6h3Yfc2uPSPS/vOK4DaAlZw9621hwrlUuIad4clojrix
         B0+g8B9Rc2hW75QN6PbpBL+OawDji/x1xFwDiOCZ+gVH6PBP9Qx17EiTOSiU/peAn/1Z
         ibTYrSJpYGaL2Z/ms3EOyps/fnwrIBmO6yWjV9JqbGwa7Tg/k4Df2Wh80Cj6LsoccNYC
         Lu8w==
X-Forwarded-Encrypted: i=1; AJvYcCWNqbp6AStEBJW6iVxhdwSiRWbe9yDj203wv1+GM1FGSUEPyxWtCfULVKQuD3lqLXI7u+7KqhBUAcGXDPM=@vger.kernel.org, AJvYcCX700YubTF8ZHmLJKGd7lcHusV21Ru4z9EiZINPdIjiKzvLDP+nUr6rkoOLKWkK1a5AVo0OaFhu59IFew79UlgW1NZptQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKYpdHhW4c7v67NxD1LP9uU8jvjcnDxoT0L10RBJvZxxRrh6o8
	Uisi131dyFg+NNZktCV5HJ65i+EV0z3cyhKB2hbIfFJKBAoTTRw0OHEm
X-Gm-Gg: ASbGnctIDqYAsk7kf1ep86zap8p9lCMsYklzx1x5pcxnAzPGZaeSWhcxNHvf9NyQXLr
	4fo+bH3rWli9Ts9oqtbtIU9DMt1gpnn32X2WO0UGNLrzNromao3pYsR2KM0OtWUYAutya0oHr/i
	FF2OetKUCmEDm2mWvb3aqDmtRFSZKrzdC47/liz4pYYlL07ilmqboPwSiTi21pRlNZRI5gqVutB
	085SYhJjFuQpJROVxJG9XI5qFxZlWbayr1hbm4qaOFodUuPw0SpNtn+izno+oBA7c9Q+QdDPxCi
	W7vHtMMwY4zbMlRxcULGwCnn5FsKoWIKXKg53SPLJVcdBvrDccvrReA7iN7vs3Z35eloa8rm4t8
	mGwNr1Czr+ZNo6j4fFgVOzVAlU8oAmVYojGEIN2vwLXZwdQ==
X-Google-Smtp-Source: AGHT+IHxa8p/bPkOp/1LKDZsSqQIQSd7bI2HUmE7Mql321wOszkhsFAG2TC8bFuiB4nvTY3n6mLd4Q==
X-Received: by 2002:a05:6a20:1586:b0:240:a53:79fc with SMTP id adf61e73a8af0-2405519cf90mr16276313637.29.1754878997387;
        Sun, 10 Aug 2025 19:23:17 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422be2b3a5sm21880366a12.46.2025.08.10.19.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 19:23:16 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/11] platform/x86: x86-android-tablets: convert int3496 devices to GPIO references
Date: Sun, 10 Aug 2025 19:22:52 -0700
Message-ID: <20250810-x86-andoroid-tablet-v2-6-9c7a1b3c32b2@gmail.com>
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
driver away from using GPIO lookup tables for int3496 devices to using
PROPERTY_ENTRY_GPIO().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/asus.c    | 37 ++++++++++------------
 drivers/platform/x86/x86-android-tablets/lenovo.c  | 24 ++++++++------
 drivers/platform/x86/x86-android-tablets/other.c   | 34 ++++++++++++--------
 .../x86/x86-android-tablets/shared-psy-info.c      | 20 ------------
 .../x86/x86-android-tablets/shared-psy-info.h      |  5 ---
 5 files changed, 51 insertions(+), 69 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/asus.c b/drivers/platform/x86/x86-android-tablets/asus.c
index 6c4468f4004b..ce581d161551 100644
--- a/drivers/platform/x86/x86-android-tablets/asus.c
+++ b/drivers/platform/x86/x86-android-tablets/asus.c
@@ -17,11 +17,17 @@
 #include "x86-android-tablets.h"
 
 /* Asus ME176C and TF103C tablets shared data */
-static struct gpiod_lookup_table int3496_gpo2_pin22_gpios = {
-	.dev_id = "intel-int3496",
-	.table = {
-		GPIO_LOOKUP("INT33FC:02", 22, "id", GPIO_ACTIVE_HIGH),
-		{ }
+static const struct property_entry asus_me176c_tf103c_int3496_props[] __initconst = {
+	PROPERTY_ENTRY_GPIO("id-gpios", &baytrail_gpiochip_nodes[2], 22, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct platform_device_info asus_me176c_tf103c_pdevs[] __initconst = {
+	{
+		/* For micro USB ID pin handling */
+		.name = "intel-int3496",
+		.id = PLATFORM_DEVID_NONE,
+		.properties = asus_me176c_tf103c_int3496_props,
 	},
 };
 
@@ -164,21 +170,15 @@ static const struct x86_serdev_info asus_me176c_serdevs[] __initconst = {
 	},
 };
 
-static struct gpiod_lookup_table * const asus_me176c_gpios[] = {
-	&int3496_gpo2_pin22_gpios,
-	NULL
-};
-
 const struct x86_dev_info asus_me176c_info __initconst = {
 	.i2c_client_info = asus_me176c_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(asus_me176c_i2c_clients),
-	.pdev_info = int3496_pdevs,
-	.pdev_count = 1,
+	.pdev_info = asus_me176c_tf103c_pdevs,
+	.pdev_count = ARRAY_SIZE(asus_me176c_tf103c_pdevs),
 	.serdev_info = asus_me176c_serdevs,
 	.serdev_count = ARRAY_SIZE(asus_me176c_serdevs),
 	.gpio_button = &asus_me176c_tf103c_lid,
 	.gpio_button_count = 1,
-	.gpiod_lookup_tables = asus_me176c_gpios,
 	.bat_swnode = &generic_lipo_hv_4v35_battery_node,
 	.modules = bq24190_modules,
 	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
@@ -296,19 +296,14 @@ static const struct x86_i2c_client_info asus_tf103c_i2c_clients[] __initconst =
 	},
 };
 
-static struct gpiod_lookup_table * const asus_tf103c_gpios[] = {
-	&int3496_gpo2_pin22_gpios,
-	NULL
-};
-
 const struct x86_dev_info asus_tf103c_info __initconst = {
 	.i2c_client_info = asus_tf103c_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(asus_tf103c_i2c_clients),
-	.pdev_info = int3496_pdevs,
-	.pdev_count = 1,
+	.pdev_info = asus_me176c_tf103c_pdevs,
+	.pdev_count = ARRAY_SIZE(asus_me176c_tf103c_pdevs),
 	.gpio_button = &asus_me176c_tf103c_lid,
 	.gpio_button_count = 1,
-	.gpiod_lookup_tables = asus_tf103c_gpios,
 	.bat_swnode = &generic_lipo_4v2_battery_node,
 	.modules = bq24190_modules,
+	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
 };
diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index 49388266201b..db6337671357 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -366,12 +366,18 @@ static struct x86_i2c_client_info lenovo_yoga_tab2_830_1050_i2c_clients[] __init
 	},
 };
 
-static struct gpiod_lookup_table lenovo_yoga_tab2_830_1050_int3496_gpios = {
-	.dev_id = "intel-int3496",
-	.table = {
-		GPIO_LOOKUP("INT33FC:02", 1, "mux", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("INT33FC:02", 24, "id", GPIO_ACTIVE_HIGH),
-		{ }
+static const struct property_entry lenovo_yoga_tab2_830_1050_int3496_props[] __initconst = {
+	PROPERTY_ENTRY_GPIO("mux-gpios", &baytrail_gpiochip_nodes[2], 1, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_GPIO("id-gpios", &baytrail_gpiochip_nodes[2], 24, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct platform_device_info lenovo_yoga_tab2_830_1050_pdevs[] __initconst = {
+	{
+		/* For micro USB ID pin handling */
+		.name = "intel-int3496",
+		.id = PLATFORM_DEVID_NONE,
+		.properties = lenovo_yoga_tab2_830_1050_int3496_props,
 	},
 };
 
@@ -389,7 +395,6 @@ static struct gpiod_lookup_table lenovo_yoga_tab2_830_1050_codec_gpios = {
 };
 
 static struct gpiod_lookup_table * const lenovo_yoga_tab2_830_1050_gpios[] = {
-	&lenovo_yoga_tab2_830_1050_int3496_gpios,
 	&lenovo_yoga_tab2_830_1050_codec_gpios,
 	NULL
 };
@@ -400,13 +405,14 @@ static void lenovo_yoga_tab2_830_1050_exit(void);
 const struct x86_dev_info lenovo_yoga_tab2_830_1050_info __initconst = {
 	.i2c_client_info = lenovo_yoga_tab2_830_1050_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(lenovo_yoga_tab2_830_1050_i2c_clients),
-	.pdev_info = int3496_pdevs,
-	.pdev_count = 1,
+	.pdev_info = lenovo_yoga_tab2_830_1050_pdevs,
+	.pdev_count = ARRAY_SIZE(lenovo_yoga_tab2_830_1050_pdevs),
 	.gpio_button = &lenovo_yoga_tab2_830_1050_lid,
 	.gpio_button_count = 1,
 	.gpiod_lookup_tables = lenovo_yoga_tab2_830_1050_gpios,
 	.bat_swnode = &generic_lipo_hv_4v35_battery_node,
 	.modules = bq24190_modules,
+	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
 	.init = lenovo_yoga_tab2_830_1050_init,
 	.exit = lenovo_yoga_tab2_830_1050_exit,
 };
diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index 0f3cc0ea877e..6f2d389a0258 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -22,6 +22,23 @@
 #include "shared-psy-info.h"
 #include "x86-android-tablets.h"
 
+static const struct property_entry int3496_reference_props[] __initconst = {
+	PROPERTY_ENTRY_GPIO("vbus-gpios", &baytrail_gpiochip_nodes[1], 15, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("mux-gpios", &baytrail_gpiochip_nodes[2], 1, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("id-gpios", &baytrail_gpiochip_nodes[2], 18, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+/* Generic pdevs array and gpio-lookups for micro USB ID pin handling */
+static const struct platform_device_info int3496_pdevs[] __initconst = {
+	{
+		/* For micro USB ID pin handling */
+		.name = "intel-int3496",
+		.id = PLATFORM_DEVID_NONE,
+		.properties = int3496_reference_props,
+	},
+};
+
 /* Acer Iconia One 7 B1-750 has an Android factory image with everything hardcoded */
 static const char * const acer_b1_750_mount_matrix[] = {
 	"-1", "0", "0",
@@ -84,17 +101,11 @@ static const struct x86_i2c_client_info acer_b1_750_i2c_clients[] __initconst =
 	},
 };
 
-static struct gpiod_lookup_table * const acer_b1_750_gpios[] = {
-	&int3496_reference_gpios,
-	NULL
-};
-
 const struct x86_dev_info acer_b1_750_info __initconst = {
 	.i2c_client_info = acer_b1_750_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(acer_b1_750_i2c_clients),
 	.pdev_info = int3496_pdevs,
-	.pdev_count = 1,
-	.gpiod_lookup_tables = acer_b1_750_gpios,
+	.pdev_count = ARRAY_SIZE(int3496_pdevs),
 	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
 };
 
@@ -407,17 +418,12 @@ static const struct x86_i2c_client_info nextbook_ares8_i2c_clients[] __initconst
 	},
 };
 
-static struct gpiod_lookup_table * const nextbook_ares8_gpios[] = {
-	&int3496_reference_gpios,
-	NULL
-};
-
 const struct x86_dev_info nextbook_ares8_info __initconst = {
 	.i2c_client_info = nextbook_ares8_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(nextbook_ares8_i2c_clients),
 	.pdev_info = int3496_pdevs,
-	.pdev_count = 1,
-	.gpiod_lookup_tables = nextbook_ares8_gpios,
+	.pdev_count = ARRAY_SIZE(int3496_pdevs),
+	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
 };
 
 /* Nextbook Ares 8A (CHT) tablets have an Android factory image with everything hardcoded */
diff --git a/drivers/platform/x86/x86-android-tablets/shared-psy-info.c b/drivers/platform/x86/x86-android-tablets/shared-psy-info.c
index fe34cedb6257..8aa5db7351c3 100644
--- a/drivers/platform/x86/x86-android-tablets/shared-psy-info.c
+++ b/drivers/platform/x86/x86-android-tablets/shared-psy-info.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2021-2023 Hans de Goede <hdegoede@redhat.com>
  */
 
-#include <linux/gpio/machine.h>
 #include <linux/platform_device.h>
 #include <linux/power/bq24190_charger.h>
 #include <linux/property.h>
@@ -155,22 +154,3 @@ const char * const bq24190_modules[] __initconst = {
 	"bq24190_charger",            /* For the Vbus regulator for intel-int3496 */
 	NULL
 };
-
-/* Generic platform device array and GPIO lookup table for micro USB ID pin handling */
-const struct platform_device_info int3496_pdevs[] __initconst = {
-	{
-		/* For micro USB ID pin handling */
-		.name = "intel-int3496",
-		.id = PLATFORM_DEVID_NONE,
-	},
-};
-
-struct gpiod_lookup_table int3496_reference_gpios = {
-	.dev_id = "intel-int3496",
-	.table = {
-		GPIO_LOOKUP("INT33FC:01", 15, "vbus", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FC:02", 1, "mux", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FC:02", 18, "id", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
diff --git a/drivers/platform/x86/x86-android-tablets/shared-psy-info.h b/drivers/platform/x86/x86-android-tablets/shared-psy-info.h
index bcf9845ad275..fabfdfe4ffce 100644
--- a/drivers/platform/x86/x86-android-tablets/shared-psy-info.h
+++ b/drivers/platform/x86/x86-android-tablets/shared-psy-info.h
@@ -11,7 +11,6 @@
 #define __PDX86_SHARED_PSY_INFO_H
 
 struct bq24190_platform_data;
-struct gpiod_lookup_table;
 struct platform_device_info;
 struct software_node;
 
@@ -26,8 +25,4 @@ extern const struct software_node generic_lipo_hv_4v35_battery_node;
 
 extern struct bq24190_platform_data bq24190_pdata;
 extern const char * const bq24190_modules[];
-
-extern const struct platform_device_info int3496_pdevs[];
-extern struct gpiod_lookup_table int3496_reference_gpios;
-
 #endif

-- 
2.51.0.rc0.155.g4a0f42376b-goog


