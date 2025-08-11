Return-Path: <linux-kernel+bounces-761725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E9FB1FDBF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495093B906F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FF527F166;
	Mon, 11 Aug 2025 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw3C2SlY"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA8273D6B;
	Mon, 11 Aug 2025 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754879000; cv=none; b=TCF6vbAn7joQoH/ByAyIR0cgnwLAiVhOt9ub8e0ETs+n3xTlVN8DXQs4A60qWL23B/htTXZkzLTzPcSi5qjZA+ztGQo7YS3MakyNsPylVVF+/ZD4eewezWq2cd8Hhe2ApIjvVqWrK2nBksDL1z22y8Ns79FU5JVVrrw0oSJ9ylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754879000; c=relaxed/simple;
	bh=Fva0VR0ejZMCSZ/mJIr1eGYlzaM5enESo+LlAb7w5cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZ3E6ImmrTOQV34v8S/QK2ZSZhkEJCP4Cy1p+nmvNlCcT5YY9oWleZpZ8qxcl1kRa5GzaXHLpybYgvGQ8+XtzVNVa2p/PSAER60GDaPp6jSsENU8HmYGg/0nIkqbJkkcL+R/aXHuLG4eXNRcPR4CG4YGAsa1TZfhJ2HtdZ9O5tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw3C2SlY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bee58e01cso4531969b3a.1;
        Sun, 10 Aug 2025 19:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754878998; x=1755483798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzPKz3dIRSjxFXRkwalDKZa3i6W/EZANYwWE1NxDBnI=;
        b=Xw3C2SlYoducp8r37fnsQJOSg+0ALr5wu2SrUhz/+MCL+0kJJgF6ppwQuH/YElzNHx
         TbdsJlMcEQyBqdnyNKOWKf6LUArKxNZklyBPMwotl7mpPTVeQ7uL2/wS6D7aMgVhK9Ro
         PIFLMynx44wsvp8WYLQvg1sMjXknljsUaZjhxbc8DAkKdaCPpszMw8rSJYFMzwsChEhd
         i1lYoPEv8GQ6/uKphJqcn1lJ0AuOFvXrJNyWUn/6oBO/OgC8UxXsmwY5b4pVMcPaTlXd
         MGJd1LcGM5huuXvbVEfXLmnsVAGO+GPIyYw5IlPo62Ly6D6MD663+lFXiWaUtn1V7KSP
         b59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754878998; x=1755483798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzPKz3dIRSjxFXRkwalDKZa3i6W/EZANYwWE1NxDBnI=;
        b=xKvmgOeXUwiPTOZW/gLknT5cB/rMKBCwn2WO4FXBWRpFdZ1Hcv6b2UvucWWbapQvYA
         6e5xCbLw3+F3mJq+2pyxvIWaBCf/VQ2nnhh1FIlrAbzPeI+OewcebZ23LGh5dd22RDv7
         LUThLlADpXoZX81fi0taSpcmUwzOXrfVZvT0RiKO0Z5BzFT+aoojavBqoisZXDofpYJ2
         OFGU0WMybCKI7aJL9HHeuBopD56DX99DFH76Mo2cRAEzz3n43oYVH2cIpFMd1VYauD9V
         b5VOCAkWDn1QfrpDtvtuYoULnfriwUFO48PkPnEMUnYpQEW7MTpu8aB/3fqG4U4UPeSr
         PQ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdbXppm8ftOM3GcLtrTz4CYqfLPhd4UnO3y3MpsyH8bHABk6dmAybOHwjZejMX1mw+cB+UN+j2TaSyKABaGTpm+Kfvtg==@vger.kernel.org, AJvYcCVj5GonvUuxGOEEbDfAnlbeNIjt7Uv4mtxZDA2gov7t+YkqqI/28nWjV7h0N69m3Oj7sxy1pKPvZoIQA4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsnuyJK56AAVytVMzQDE/caUIbWhZD5AQXjtTI3Dix/QSiqoGY
	y9kl1L4boYxZ+aaWfabeVWrL0YV14P7n+lThQl/ZqcCW+Z6C8BFn4GHb5z17MA==
X-Gm-Gg: ASbGnctN+6bG/k9XeHisl39P0zDKHanERLCaBTLXT5qiDt0wecveyGcErwJKPziGYGx
	zGfBhzLsGN78UbC+Z7H0FfETza4gD6TD2lLc3kXm3Hj93xSmljrO+fBgr/jQ5HgY30+hTuB9GBJ
	d8UukBg41FL5lBvAwnGKk2jTAe54RZp/C3raGiUp2BVgdDxb7YhYW97UjxaIZJQFLfsMSbtJupD
	yr/34K+BNgXjSz2mepdaZznR/UkYWzc32t8VXyIyZXy3/JARGQ0516kYFR/dKSmFrkSW/JuaFmz
	qCTIQVnEn3zYK8lxZkMGlZeo75wh6zzLxRaQNcfoeQS7Md9ysy6HepQIiDq+jo8LTS4lbEO+Cby
	8vj2cOCDi+ijeBm1rbeNxQJOgM34850l+Cub/Nv70byAlp9BFIl09SIUy
X-Google-Smtp-Source: AGHT+IHcMJRH63vEm2e9aQie3Z5ZkjZR4z+QfZLogcVP8uYyK0mg3+V7Fm18xepO8FB28qHxxl53dg==
X-Received: by 2002:a05:6a20:2591:b0:23f:f96c:1197 with SMTP id adf61e73a8af0-240551a3e13mr16767644637.24.1754878998097;
        Sun, 10 Aug 2025 19:23:18 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422be2b3a5sm21880366a12.46.2025.08.10.19.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 19:23:17 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] platform/x86: x86-android-tablets: convert wm1502 devices to GPIO references
Date: Sun, 10 Aug 2025 19:22:53 -0700
Message-ID: <20250810-x86-andoroid-tablet-v2-7-9c7a1b3c32b2@gmail.com>
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

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/lenovo.c | 108 +++++++++++++++-------
 1 file changed, 76 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index db6337671357..811400d59697 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -383,19 +383,34 @@ static const struct platform_device_info lenovo_yoga_tab2_830_1050_pdevs[] __ini
 
 #define LENOVO_YOGA_TAB2_830_1050_CODEC_NAME "spi-10WM5102:00"
 
-static struct gpiod_lookup_table lenovo_yoga_tab2_830_1050_codec_gpios = {
-	.dev_id = LENOVO_YOGA_TAB2_830_1050_CODEC_NAME,
-	.table = {
-		GPIO_LOOKUP("gpio_crystalcove", 3, "reset", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FC:01", 23, "wlf,ldoena", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("arizona", 2, "wlf,spkvdd-ena", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("arizona", 4, "wlf,micd-pol", GPIO_ACTIVE_LOW),
-		{ }
-	},
+static const struct software_node lenovo_yoga_tab2_830_1050_crystalcove = {
+	.name = "gpio_crystalcove",
+};
+
+static const struct software_node lenovo_yoga_tab2_830_1050_arizona = {
+	.name = "arizona",
+};
+
+static const struct property_entry lenovo_yoga_tab2_830_1050_wm1502_props[] = {
+	PROPERTY_ENTRY_GPIO("reset-gpios",
+			    &lenovo_yoga_tab2_830_1050_crystalcove, 3, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("wlf,ldoena-gpios",
+			    &baytrail_gpiochip_nodes[1], 23, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("wlf,spkvdd-ena-gpios",
+			    &lenovo_yoga_tab2_830_1050_arizona, 2, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("wlf,micd-pol-gpios",
+			    &lenovo_yoga_tab2_830_1050_arizona, 4, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node lenovo_yoga_tab2_830_1050_wm5102 = {
+	.properties = lenovo_yoga_tab2_830_1050_wm1502_props,
 };
 
-static struct gpiod_lookup_table * const lenovo_yoga_tab2_830_1050_gpios[] = {
-	&lenovo_yoga_tab2_830_1050_codec_gpios,
+static const struct software_node *lenovo_yoga_tab2_830_1050_swnodes[] = {
+	&lenovo_yoga_tab2_830_1050_crystalcove,
+	&lenovo_yoga_tab2_830_1050_arizona,
+	&lenovo_yoga_tab2_830_1050_wm5102,
 	NULL
 };
 
@@ -409,7 +424,6 @@ const struct x86_dev_info lenovo_yoga_tab2_830_1050_info __initconst = {
 	.pdev_count = ARRAY_SIZE(lenovo_yoga_tab2_830_1050_pdevs),
 	.gpio_button = &lenovo_yoga_tab2_830_1050_lid,
 	.gpio_button_count = 1,
-	.gpiod_lookup_tables = lenovo_yoga_tab2_830_1050_gpios,
 	.bat_swnode = &generic_lipo_hv_4v35_battery_node,
 	.modules = bq24190_modules,
 	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
@@ -469,6 +483,7 @@ static const struct pinctrl_map lenovo_yoga_tab2_830_1050_codec_pinctrl_map =
 	PIN_MAP_MUX_GROUP(LENOVO_YOGA_TAB2_830_1050_CODEC_NAME, "codec_32khz_clk",
 			  "INT33FC:02", "pmu_clk2_grp", "pmu_clk");
 
+static struct device *lenovo_yoga_tab2_830_1050_codec_dev;
 static struct pinctrl *lenovo_yoga_tab2_830_1050_codec_pinctrl;
 static struct sys_off_handler *lenovo_yoga_tab2_830_1050_sys_off_handler;
 
@@ -495,12 +510,24 @@ static int __init lenovo_yoga_tab2_830_1050_init_codec(void)
 		goto err_unregister_mappings;
 	}
 
-	/* We're done with the codec_dev now */
-	put_device(codec_dev);
+	ret = software_node_register_node_group(lenovo_yoga_tab2_830_1050_swnodes);
+	if (ret) {
+		ret = dev_err_probe(codec_dev, ret, "registering software nodes\n");
+		goto err_unregister_mappings;
+	}
+
+	ret = device_add_software_node(codec_dev, &lenovo_yoga_tab2_830_1050_wm5102);
+	if (ret) {
+		ret = dev_err_probe(codec_dev, ret, "adding software node\n");
+		goto err_unregister_swnodes;
+	}
 
+	lenovo_yoga_tab2_830_1050_codec_dev = codec_dev;
 	lenovo_yoga_tab2_830_1050_codec_pinctrl = pinctrl;
 	return 0;
 
+err_unregister_swnodes:
+	software_node_unregister_node_group(lenovo_yoga_tab2_830_1050_swnodes);
 err_unregister_mappings:
 	pinctrl_unregister_mappings(&lenovo_yoga_tab2_830_1050_codec_pinctrl_map);
 err_put_device:
@@ -548,6 +575,12 @@ static void lenovo_yoga_tab2_830_1050_exit(void)
 {
 	unregister_sys_off_handler(lenovo_yoga_tab2_830_1050_sys_off_handler);
 
+	if (lenovo_yoga_tab2_830_1050_codec_dev) {
+		device_remove_software_node(lenovo_yoga_tab2_830_1050_codec_dev);
+		put_device(lenovo_yoga_tab2_830_1050_codec_dev);
+		software_node_unregister_node_group(lenovo_yoga_tab2_830_1050_swnodes);
+	}
+
 	if (lenovo_yoga_tab2_830_1050_codec_pinctrl) {
 		pinctrl_put(lenovo_yoga_tab2_830_1050_codec_pinctrl);
 		pinctrl_unregister_mappings(&lenovo_yoga_tab2_830_1050_codec_pinctrl_map);
@@ -750,7 +783,6 @@ static struct gpiod_lookup_table lenovo_yoga_tab2_1380_fc_gpios = {
 };
 
 static struct gpiod_lookup_table * const lenovo_yoga_tab2_1380_gpios[] = {
-	&lenovo_yoga_tab2_830_1050_codec_gpios,
 	&lenovo_yoga_tab2_1380_fc_gpios,
 	NULL
 };
@@ -947,12 +979,37 @@ static struct arizona_pdata lenovo_yt3_wm5102_pdata = {
 	},
 };
 
+static const struct software_node lenovo_yt3_arizona = {
+	.name = "arizona",
+};
+
+static const struct property_entry lenovo_yt3_wm1502_props[] = {
+	PROPERTY_ENTRY_GPIO("wlf,spkvdd-ena-gpios",
+			    &cherryview_gpiochip_nodes[0], 75, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("wlf,ldoena-gpios",
+			    &cherryview_gpiochip_nodes[0], 81, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("reset-gpios", &cherryview_gpiochip_nodes[0], 82, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("wlf,micd-pol-gpios", &lenovo_yt3_arizona, 2, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node lenovo_yt3_wm5102 = {
+	.properties = lenovo_yt3_wm1502_props,
+};
+
+static const struct software_node *lenovo_yt3_swnodes[] = {
+	&lenovo_yt3_arizona,
+	&lenovo_yt3_wm5102,
+	NULL
+};
+
 static const struct x86_spi_dev_info lenovo_yt3_spi_devs[] __initconst = {
 	{
 		/* WM5102 codec */
 		.board_info = {
 			.modalias = "wm5102",
 			.platform_data = &lenovo_yt3_wm5102_pdata,
+			.swnode = &lenovo_yt3_wm5102,
 			.max_speed_hz = 5000000,
 		},
 		.ctrl_path = "\\_SB_.PCI0.SPI1",
@@ -999,31 +1056,18 @@ static int __init lenovo_yt3_init(struct device *dev)
 	intel_soc_pmic_exec_mipi_pmic_seq_element(0x6e, 0x9b, 0x02, 0xff);
 	intel_soc_pmic_exec_mipi_pmic_seq_element(0x6e, 0xa0, 0x02, 0xff);
 
+	ret = software_node_register_node_group(lenovo_yt3_swnodes);
+	if (ret)
+		return dev_err_probe(dev, ret, "registering software nodes\n");
+
 	return 0;
 }
 
-static struct gpiod_lookup_table lenovo_yt3_wm5102_gpios = {
-	.dev_id = "spi1.0",
-	.table = {
-		GPIO_LOOKUP("INT33FF:00", 75, "wlf,spkvdd-ena", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FF:00", 81, "wlf,ldoena", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FF:00", 82, "reset", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("arizona", 2, "wlf,micd-pol", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
-static struct gpiod_lookup_table * const lenovo_yt3_gpios[] = {
-	&lenovo_yt3_wm5102_gpios,
-	NULL
-};
-
 const struct x86_dev_info lenovo_yt3_info __initconst = {
 	.i2c_client_info = lenovo_yt3_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(lenovo_yt3_i2c_clients),
 	.spi_dev_info = lenovo_yt3_spi_devs,
 	.spi_dev_count = ARRAY_SIZE(lenovo_yt3_spi_devs),
-	.gpiod_lookup_tables = lenovo_yt3_gpios,
 	.gpiochip_type = X86_GPIOCHIP_CHERRYVIEW,
 	.init = lenovo_yt3_init,
 };

-- 
2.51.0.rc0.155.g4a0f42376b-goog


