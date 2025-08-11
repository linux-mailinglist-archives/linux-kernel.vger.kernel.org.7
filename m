Return-Path: <linux-kernel+bounces-761727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B67B1FDC4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3BD177E09
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13E82877F1;
	Mon, 11 Aug 2025 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrchvwTv"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CDC279DC3;
	Mon, 11 Aug 2025 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754879002; cv=none; b=YWaIo/Om9PiKVvRrim2v7XiN5xPezoTdXcPEu3/UvpGG44MDRoVLU/6tR1RPfDpJlYarXg1ET0uA7AiONvBtGy1yJlmKrSP/T0dNvOJP1XO6Avk3q+ar7p3aRFxB+f51aI3L57P4uYFuxl/w9v5e9h4R3k41oet4M8hKN2NDi+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754879002; c=relaxed/simple;
	bh=9ObgYvD/nUmVyffG+pMhNsco8jhko9HDl60Ok/mU77k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quqJyMl2ImLCiuk1ue+G4v5/p9YJ4ZBRostdkMW+kNdsqf9UK2Cl5XjqB9m80be2vKsvHI7vC6Yvq7/jOBna5IXNeAYmOTSCi/1Y5jEgjdd7CdrIaWl8RzKRuMtH3MzzB+gRqQS3ZRx76wnjdC96MP9uHwSwBnhRTX/1pyz/qLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrchvwTv; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31ece02ad92so2877938a91.2;
        Sun, 10 Aug 2025 19:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754879000; x=1755483800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zdGiG7YFnd0Kp+RpykoXidbDR/sORi9+DDlj5r3pTw=;
        b=nrchvwTvdte6PifOnGtXrMB2xgMGnDb4JxMgXBXiDxIhXlXeHZ6zb3bN8AIij8pQ+b
         CzXAlozVF8Y4uaK1chjsqkN2rzegCtlOHyTL2IhKs9v+3R/Qr/5tiLQCDGdA9zfJ6An0
         aZ0uCyxzGzxluImK7xPft9viaAYNgaRgeMUGah8qkWktHqmygwTBZjORRYe0VSe2mSHH
         CHNW9ikGXD4BrgQLRRz2Z/zF6CRwVb3RjtGns0qEyUJMfET7PFBza8Uh8dhDbwPqpQ0H
         aIpT+MJltaES2M3WkHV4gydivOVShzv2nIoj9olqC+gG6Bf2DjmOKSQF8e6f3F6fXFer
         wkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754879000; x=1755483800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zdGiG7YFnd0Kp+RpykoXidbDR/sORi9+DDlj5r3pTw=;
        b=FjtQzNR2WD2ZBZhTWB+o7admrJMl0bv56iIgW1Z6R6G8LhWwinzKjzeBVjXFX+zK2U
         lvEv4GdUb9hxW8RKz3Xe1BUhg/2mt3p6URFRicK0zIFmx1miUL5jnJhL1fC8S0oMSslo
         UhRAAY5UIeVZaaVeXA5DjygA/zYuwY78+X8wl1MLOEZILtxxd6FApiUxcaQP5n/NirW4
         lZD+cH0I8PUOuNd1UQg6jVXErAbmIKyOe9ByCevrv88hCF5k3uy37QlbceOhU53l5Ach
         bCOpgMHNKrrmu8rBVa94abfqWCzaei2n7hOijbcaYb9TvJkc+hfj1ri40xMkre4m6b0d
         kOwA==
X-Forwarded-Encrypted: i=1; AJvYcCU2WXWLNIPBwLJymXJWhpKs4w9Mk/HSrqz78DQvG1YbkXGF849vymjlUhT4oARz5Oxr4X3fde0zRMVOt0NaszYVCj3EVQ==@vger.kernel.org, AJvYcCV5HGS2KgDeiLgxU9adWuX2zJYFiX1+eVYyyMKv03FoOKmi2fQwYUOhVtA2b5OT9lxFp2/zmKCmjuPiU2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyu9kME+vYARUHWooXc3Z4b/SG8JhxHGUXQ2QMEKf6BTMN955u
	gIzU49zERBgGA5cPbmGzPyYXcHS0b7gwfqLyMXRzIYoQzpOi0YXZmKtLPG60pw==
X-Gm-Gg: ASbGncukeyZ7cBwCgzcp8zquOp+y1cSa/AANu1f2LMpYdwzLUCpQXRf3FBenxHrKCKo
	sDrCuxpwy0L3sqPD9fAwFgFf41hOhj1LjkObtl166SRdmtTbW6QfuHmvwmX2eFzYZixxKG/LZPl
	g7gy8HWye03NVhWaLvf+CR1xNRBBE4IPYC+yY4JXLWTECMQ8dhJgVX6K1R52OY0Y3EljW4FhvmY
	v72N8213Jq7nHEBsRksfObxon9A0Zlx/k6CNJcgT+TCwLw37/R6TTijMaG9ATUSFoSnWBSeawAJ
	tOrkNtm8h5efrIcMmy2byYpl1Km7ds/d3aaDD7of82u/KnRWdle6A4wbtOKqG3SgYEWi/0ZIRHF
	qXJuql+sTF0A1+++1vy1s5v4PXv2NT5HIvK8XPcU+pHnwxQ==
X-Google-Smtp-Source: AGHT+IFzjX1s2TAUfx6eG25HtP/sPk8MMlWTZVsEwS1S66JKoi0FAaj3CM8tt7rAWrT/dAKfrKBzvQ==
X-Received: by 2002:a17:90b:280e:b0:31f:30a6:56ff with SMTP id 98e67ed59e1d1-32183b3f52dmr16481362a91.19.1754878999933;
        Sun, 10 Aug 2025 19:23:19 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422be2b3a5sm21880366a12.46.2025.08.10.19.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 19:23:19 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] platform/x86: x86-android-tablets: convert Yoga Tab2 fast charger to GPIO references
Date: Sun, 10 Aug 2025 19:22:55 -0700
Message-ID: <20250810-x86-andoroid-tablet-v2-9-9c7a1b3c32b2@gmail.com>
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
driver away from using GPIO lookup tables for the fast charger device
to using PROPERTY_ENTRY_GPIO().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/lenovo.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index 811400d59697..7c6a6fc6be42 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -739,11 +739,18 @@ static const struct x86_i2c_client_info lenovo_yoga_tab2_1380_i2c_clients[] __in
 	}
 };
 
+static const struct property_entry lenovo_yoga_tab2_1380_fc_props[] = {
+	PROPERTY_ENTRY_GPIO("uart3_txd-gpios", &baytrail_gpiochip_nodes[0], 57, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("uart3_rxd-gpios", &baytrail_gpiochip_nodes[0], 61, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
 static const struct platform_device_info lenovo_yoga_tab2_1380_pdevs[] __initconst = {
 	{
 		/* For the Tablet 2 Pro 1380's custom fast charging driver */
 		.name = "lenovo-yoga-tab2-pro-1380-fastcharger",
 		.id = PLATFORM_DEVID_NONE,
+		.properties = lenovo_yoga_tab2_1380_fc_props,
 	},
 };
 
@@ -773,20 +780,6 @@ static int __init lenovo_yoga_tab2_1380_init(struct device *dev)
 	return 0;
 }
 
-static struct gpiod_lookup_table lenovo_yoga_tab2_1380_fc_gpios = {
-	.dev_id = "serial0-0",
-	.table = {
-		GPIO_LOOKUP("INT33FC:00", 57, "uart3_txd", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FC:00", 61, "uart3_rxd", GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
-static struct gpiod_lookup_table * const lenovo_yoga_tab2_1380_gpios[] = {
-	&lenovo_yoga_tab2_1380_fc_gpios,
-	NULL
-};
-
 const struct x86_dev_info lenovo_yoga_tab2_1380_info __initconst = {
 	.i2c_client_info = lenovo_yoga_tab2_1380_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(lenovo_yoga_tab2_1380_i2c_clients),
@@ -794,9 +787,9 @@ const struct x86_dev_info lenovo_yoga_tab2_1380_info __initconst = {
 	.pdev_count = ARRAY_SIZE(lenovo_yoga_tab2_1380_pdevs),
 	.gpio_button = &lenovo_yoga_tab2_830_1050_lid,
 	.gpio_button_count = 1,
-	.gpiod_lookup_tables = lenovo_yoga_tab2_1380_gpios,
 	.bat_swnode = &generic_lipo_hv_4v35_battery_node,
 	.modules = lenovo_yoga_tab2_1380_modules,
+	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
 	.init = lenovo_yoga_tab2_1380_init,
 	.exit = lenovo_yoga_tab2_830_1050_exit,
 };

-- 
2.51.0.rc0.155.g4a0f42376b-goog


