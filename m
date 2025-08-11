Return-Path: <linux-kernel+bounces-761728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC13B1FDC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADFD177F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55AC22B595;
	Mon, 11 Aug 2025 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAdQDnbe"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9914E27F4E7;
	Mon, 11 Aug 2025 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754879003; cv=none; b=bG4vPKdw39wi7fb6ZYH4lM4KhnX9uB2NsmdTHSsbi8vEgeJHanJZvi7boWHnCEyUndrbLjykKiCq6t4WpqBFU8RpsYQ2p2xYYJAt5dQWRucYSj6R8lCNC6en+hVlq4CFgEZ6BthYoJfg46VeESWW9oq74LMhxqZtFvPzsY3Gpq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754879003; c=relaxed/simple;
	bh=+Bd6u30AjehdDMENozae9QTypNU3Fx/QJ235tPftDac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TF7gFzkUnjzE2lrNSPLfU72E7F0SPLHyxxe62hlvS1Kvhu3maFG69S3UAiDm+jV2NRmxI3slQsguiDipu7y5tdwGedE6XUd2cgCd96vEoHD2k3K99Y2gg54t96z9GO2y0TeBFzoY21ntIFzui0A67ASCBeouw0Dgi/VOe//xel4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAdQDnbe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76bd041c431so3290442b3a.2;
        Sun, 10 Aug 2025 19:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754879001; x=1755483801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQBghnO2hQiu1mEMG7VIvVmKmaRqdfyhY9m5vdrVGEE=;
        b=PAdQDnbeme62P7Q2fZwzCvRLEcaJMrqrh88C13DxlZYlbayuqDrVAyzEuUcsl36QCW
         UNPG5Dv8T8albjwfnXjY+NNLvOEDTlPlWA47kl2BA3tLdo7BrW3OybtXdHr3UFL3kS5x
         7PG7sZBQXe3YSSOPFXJll7+wqEnIcolrQhrH/BhTw8Ax1CaCFnXXnI4Kwx+umWA/HclH
         IDfEDQvS0WWd4iNR9+iPhK6o/7oniXzQlDZHnzUarghuC76BlMrEQcabjEsZ28LXvGw1
         75ebu7RBs/gcL+B7lDlm2SHum1rfr1ep2EY3cMC8vX/BiKsJrRWVefh0e139wydiePBI
         qDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754879001; x=1755483801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQBghnO2hQiu1mEMG7VIvVmKmaRqdfyhY9m5vdrVGEE=;
        b=OqOqTc3DAzOWtBONlBw5BSrXfuwO0k2qfVjIsVN34dEKWi7fyMiLf1ug6ms5c1V1bN
         HINFwulGTLxRDJ4lYuvFEUvaOpDeXC1O9ghc6TOPBAmQbMzY19C6i9qPa6JZsQDZOO0y
         HZIGKhXsOFEHhbxoxqsIqoDaFYgbcR3m+fbGdlG9935dFGvqdsGkhizTJzdP8gvObwFL
         bDKqkttgMTPceuuEi/A/AdYFWFUTJo/17KFj0W8pQca7wKyW57eaIThJprrxv6dC5RDN
         fZmeu3JjElNQcbIW7ySMygjco+OYlCWu1EMTX/MgVxoSX1l7b32mr+a0Uuf142JLaoAX
         kOKA==
X-Forwarded-Encrypted: i=1; AJvYcCXAL9Y+mpB3hv46OEpK/c5mmx9M66Jp99JkoR7BeJtl9Yplj4M+9ivS1dBbg6DtbVwu8KjUce1CL4wdpbc=@vger.kernel.org, AJvYcCXKaoxfeereb4MEP5vGG4w9HiFDn4UQiYC/pvgTw7vzJJ7eTSxqAlgkvlfsGKIrbqMx4leJYeHMEYfkqFQtCaHjPI6mug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFk3f22iCQhnLLZ1GIC52Bc9u/mk70LqM3WjGSskzk+hc44jNJ
	Kihr3MyPrmH/gxrJnq44hgJpa1GPjyfIfUY8uZ18A/sTGpy1Qd2YVEhjxw2zNg==
X-Gm-Gg: ASbGnctzNnva1v6RNpqRpFH0OUQ+jJI3RfZ4ubGUTqsmsVUMfHNcv4zPKzONB3wV2ph
	CnmxdY5df8mS0YqtsBbsVHTUJFWboZFT8Kc2rGqkFsY4rI0z8NrkEOzYPeP7GIKbDGxPk9KAv17
	u4tLco1p98YZCsuSmBA+9LjGwAvmDolx3Ll4Bk3z3TZYyjtpH+RChs3RiHy1kzSnRiJB9bdDsvw
	23T/1oQr/q1w29KoQzaGyyYIvdiD+7jdL+qWV3HzhXS7QWRixSZ0nIANdS4ib4EmHpF2fdT4/m2
	p0BhyGGgVwP9kCaY4JHpPiCgS27Ap8JquD2o4njHR/Y6QlM/aEGtzbOMTWA9h181bEI7peAddma
	ghsw19UFBeO8SCHRUjiNt0866A7jvSBvKAu8Lfhq7U/Eeqw==
X-Google-Smtp-Source: AGHT+IEFdmdZw0IExwtmiSqeOwAjGbNbj6vsklo6ADMPOaIhrMcIFoCzLn6zhQl5W0vvjKL+uourtw==
X-Received: by 2002:a05:6a20:4306:b0:240:5f9:6359 with SMTP id adf61e73a8af0-240551f7ea5mr17881806637.34.1754879000865;
        Sun, 10 Aug 2025 19:23:20 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422be2b3a5sm21880366a12.46.2025.08.10.19.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 19:23:20 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] platform/x86: x86-android-tablets: remove support for GPIO lookup tables
Date: Sun, 10 Aug 2025 19:22:56 -0700
Message-ID: <20250810-x86-andoroid-tablet-v2-10-9c7a1b3c32b2@gmail.com>
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

Now that everything that used the lookup tables has been switched to
using property entries to describe GPIOs, we can remove support for
registering and unregistering the lookup tables.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/core.c                | 8 --------
 drivers/platform/x86/x86-android-tablets/x86-android-tablets.h | 2 --
 2 files changed, 10 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index b0d63d3c05cd..94942921b203 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -153,7 +153,6 @@ static struct spi_device **spi_devs;
 static struct platform_device **pdevs;
 static struct serdev_device **serdevs;
 static struct gpio_keys_button *buttons;
-static struct gpiod_lookup_table * const *gpiod_lookup_tables;
 static const struct software_node *bat_swnode;
 static const struct software_node **gpiochip_node_group;
 static void (*exit_handler)(void);
@@ -395,9 +394,6 @@ static void x86_android_tablet_remove(struct platform_device *pdev)
 
 	if (gpiochip_node_group)
 		software_node_unregister_node_group(gpiochip_node_group);
-
-	for (i = 0; gpiod_lookup_tables && gpiod_lookup_tables[i]; i++)
-		gpiod_remove_lookup_table(gpiod_lookup_tables[i]);
 }
 
 static __init int x86_android_tablet_probe(struct platform_device *pdev)
@@ -421,10 +417,6 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
 	for (i = 0; dev_info->modules && dev_info->modules[i]; i++)
 		request_module(dev_info->modules[i]);
 
-	gpiod_lookup_tables = dev_info->gpiod_lookup_tables;
-	for (i = 0; gpiod_lookup_tables && gpiod_lookup_tables[i]; i++)
-		gpiod_add_lookup_table(gpiod_lookup_tables[i]);
-
 	switch (dev_info->gpiochip_type) {
 	case X86_GPIOCHIP_BAYTRAIL:
 		gpiochip_node_group = baytrail_gpiochip_node_group;
diff --git a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
index a54d09408866..d037e3962a51 100644
--- a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
+++ b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
@@ -17,7 +17,6 @@
 #include <linux/spi/spi.h>
 
 struct gpio_desc;
-struct gpiod_lookup_table;
 struct platform_device_info;
 struct software_node;
 
@@ -91,7 +90,6 @@ struct x86_gpio_button {
 struct x86_dev_info {
 	const char * const *modules;
 	const struct software_node *bat_swnode;
-	struct gpiod_lookup_table * const *gpiod_lookup_tables;
 	const struct x86_i2c_client_info *i2c_client_info;
 	const struct x86_spi_dev_info *spi_dev_info;
 	const struct platform_device_info *pdev_info;

-- 
2.51.0.rc0.155.g4a0f42376b-goog


