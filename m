Return-Path: <linux-kernel+bounces-761721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4A1B1FDB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 880A27A4094
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556D826529E;
	Mon, 11 Aug 2025 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJzeM2/j"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412F2242D62;
	Mon, 11 Aug 2025 02:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754878996; cv=none; b=ps/PwGTfZbu/gPmKctyqKGg2fix3Rsuo3PBwQcgWtK3OFAoX2MRi0lmwJE7jkErpWKYKJE4nF6Zc1EvVCLUoOApF4uUFC8IadzyPpBdrRBFgSMptrKsXJxX1ehQSFiVqrzPzhsNstbAwBFOt/wQr/f/SAPkSY9aKpS3CG/SVG0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754878996; c=relaxed/simple;
	bh=OYiTCD65UyICNRtzOzAxFm/BAp3FuST9gSe2kdWm9Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5Y10TAACzs/EsyKaqjpWYFkAhm49PCNkloZnqd0eZ8hQEc3XyLgMGYCtpU4f2qWfz1OQHp5j7atEBzcwnXjziMwf8baw1RV4oDAUsFCwUm6bNbLmvI/RT9RB+yAl78cKpaLF3HYaHVqbBuJyS5QIXhZTJ6r+f7WPfyqFNIoImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJzeM2/j; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso3170569b3a.0;
        Sun, 10 Aug 2025 19:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754878994; x=1755483794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f849tze61YQDeAIBS3cct031MobvtmnSiBzSO+mMBTw=;
        b=NJzeM2/j/j9iMbnNA6T8v47Crxx1fk7o9qSn1WAxlYPzsRW4jK8/gxMcWvt6un3fWu
         9sIy6mKrF0Vd6sslO8Ty22Uobr+KOygiN6c7XrpRd+wExGSjiie9hUQ+8s1pvgmJYqs8
         GdPxn6tLF5ieQN16rpVMTJ1fe7ycy4o8fixjoYpFMgRdkyTTy3b1EKGCuju8I2ZmCF+W
         VEG6IC3uqQfrxoMij2OzDYOXAFJP6Ya97mlQ/caZ3dwvUOamVmRWn0m4nootVnmQB4YH
         Ol+KGkYiIyDK76YReQqeAFMLmIKzDEe97gL9OF86SFHKGYwRadzqiwft5V73a4RKKzR+
         UqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754878994; x=1755483794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f849tze61YQDeAIBS3cct031MobvtmnSiBzSO+mMBTw=;
        b=deZfI+cy/3g11haAczKhwYdOZ4BeKa4928MQIyDvmDlkv9JYVBUmuaSQ03V6IN9xO3
         6QljVonhgmJtIbv5oWGArir4OwzckgwyBjxcj4oMzD62OS+pdPJfWVqGiEB8kQej6d1E
         lDO94EF/iG3ZmVIwkgLwPNrH8PzLVLek4SXKEosTvaC80vkAmul88YFeMxGMnXYPNifd
         6dUtEhq9twDKPRFnzRBiwWs2rTX/Qr9BDp9O8XCjGnj8e1qNGZNSedSXyAtFyml11BUg
         zR2biLZ/cy862pMCQhHLvDhn/B51XQPfkcPr7s6XZaQmsq69cEznPfpS2xHJqe4+s53e
         0T0A==
X-Forwarded-Encrypted: i=1; AJvYcCUel+1kUqMpsFgfDNKO47C+xy3OdXRaayqLeE2bU//DuUPh+rV++aYm/h10FD5UjEPahQKCc0Mb5i4P4DYlnzrdxMjo9w==@vger.kernel.org, AJvYcCVxh/+ME5myUKh4ZOJ13nKgFrkpS8aKCazaQRb6pvM0BvtUh6ekf511KCEGE/MAaKTcWRcvgcorkqvqjvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6KgsJ5KLEqf8vmZqFQgPdXELaHfYbXzDWgo8mAuRX4Fq2NXZ
	GnaAeW4rKa6eikE26uPYNpv3HQe5RO5yrfZ0pOWiBTQp2PMd+9vkxjLb3+NH/A==
X-Gm-Gg: ASbGnctRnm370KlsvQavJv+LHh+vwmavSdw2Y5Vv5aNBDDlfxJ4eFOhrmCEJyUmNhlZ
	maCXSHfaq1XFHEk4DTML4YJkNoG2Jf4k9mfjPWzqDWegUThO8CUNItZ7/yPIGCtOZuaMs0USiZe
	oAL3aioFdThCVFKdSyJHA+WFpVRd55GEKFFW/izLhXaPdCFL4octTIDO+b89VtCr5rmlJQagzOT
	+NKDHqgJu4jnRvrTSBOP1S8C/JPYxvim5JvxD+EAFdqIn9pQcdkTWqV1mmFpCuCqlvv6n1tEVdd
	J0NKZ6VDb1TkD2HVBh01gvpSV2h0cgHIatxt+fhS4BP3q4IplUKoRSnsInCT1ENkinfQ0fu74h7
	XIAWoW3b+CHv6pGi6CUoYoHHxjgOknnjNBV0OIU7W6THnhw==
X-Google-Smtp-Source: AGHT+IH+ASno63WsTsv5M/NPgEp4Z+u/WSjWdTG1K2MeKorz3pEx4VP982TDi1MJ0LuhZOgqYfHRcg==
X-Received: by 2002:a05:6a21:32a5:b0:23f:f493:7667 with SMTP id adf61e73a8af0-2405501523fmr16683253637.3.1754878994487;
        Sun, 10 Aug 2025 19:23:14 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422be2b3a5sm21880366a12.46.2025.08.10.19.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 19:23:13 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] platform/x86: x86-android-tablets: convert HiDeep devices to GPIO references
Date: Sun, 10 Aug 2025 19:22:49 -0700
Message-ID: <20250810-x86-andoroid-tablet-v2-3-9c7a1b3c32b2@gmail.com>
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
driver away from using GPIO lookup tables for HiDeep touchscreens to using
PROPERTY_ENTRY_GPIO() to keep all touchscreen properties together.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/lenovo.c | 26 +++--------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index f8d261d37284..49388266201b 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -97,6 +97,7 @@ static const struct property_entry lenovo_yb1_x90_hideep_ts_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1920),
 	PROPERTY_ENTRY_U32("touchscreen-max-pressure", 16384),
 	PROPERTY_ENTRY_BOOL("hideep,force-native-protocol"),
+	PROPERTY_ENTRY_GPIO("reset-gpios", &cherryview_gpiochip_nodes[0], 7, GPIO_ACTIVE_LOW),
 	{ }
 };
 
@@ -211,19 +212,6 @@ static const struct x86_gpio_button lenovo_yb1_x90_lid __initconst = {
 	.pin = 19,
 };
 
-static struct gpiod_lookup_table lenovo_yb1_x90_hideep_gpios = {
-	.dev_id = "i2c-hideep_ts",
-	.table = {
-		GPIO_LOOKUP("INT33FF:00", 7, "reset", GPIO_ACTIVE_LOW),
-		{ }
-	},
-};
-
-static struct gpiod_lookup_table * const lenovo_yb1_x90_gpios[] = {
-	&lenovo_yb1_x90_hideep_gpios,
-	NULL
-};
-
 static int __init lenovo_yb1_x90_init(struct device *dev)
 {
 	/* Enable the regulators used by the touchscreens */
@@ -252,7 +240,6 @@ const struct x86_dev_info lenovo_yogabook_x90_info __initconst = {
 	.serdev_count = ARRAY_SIZE(lenovo_yb1_x90_serdevs),
 	.gpio_button = &lenovo_yb1_x90_lid,
 	.gpio_button_count = 1,
-	.gpiod_lookup_tables = lenovo_yb1_x90_gpios,
 	.gpiochip_type = X86_GPIOCHIP_CHERRYVIEW,
 	.init = lenovo_yb1_x90_init,
 };
@@ -819,6 +806,7 @@ static const struct property_entry lenovo_yt3_hideep_ts_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1600),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 2560),
 	PROPERTY_ENTRY_U32("touchscreen-max-pressure", 255),
+	PROPERTY_ENTRY_GPIO("reset-gpios", &cherryview_gpiochip_nodes[0], 7, GPIO_ACTIVE_LOW),
 	{ }
 };
 
@@ -1008,14 +996,6 @@ static int __init lenovo_yt3_init(struct device *dev)
 	return 0;
 }
 
-static struct gpiod_lookup_table lenovo_yt3_hideep_gpios = {
-	.dev_id = "i2c-hideep_ts",
-	.table = {
-		GPIO_LOOKUP("INT33FF:00", 7, "reset", GPIO_ACTIVE_LOW),
-		{ }
-	},
-};
-
 static struct gpiod_lookup_table lenovo_yt3_wm5102_gpios = {
 	.dev_id = "spi1.0",
 	.table = {
@@ -1028,7 +1008,6 @@ static struct gpiod_lookup_table lenovo_yt3_wm5102_gpios = {
 };
 
 static struct gpiod_lookup_table * const lenovo_yt3_gpios[] = {
-	&lenovo_yt3_hideep_gpios,
 	&lenovo_yt3_wm5102_gpios,
 	NULL
 };
@@ -1039,5 +1018,6 @@ const struct x86_dev_info lenovo_yt3_info __initconst = {
 	.spi_dev_info = lenovo_yt3_spi_devs,
 	.spi_dev_count = ARRAY_SIZE(lenovo_yt3_spi_devs),
 	.gpiod_lookup_tables = lenovo_yt3_gpios,
+	.gpiochip_type = X86_GPIOCHIP_CHERRYVIEW,
 	.init = lenovo_yt3_init,
 };

-- 
2.51.0.rc0.155.g4a0f42376b-goog


