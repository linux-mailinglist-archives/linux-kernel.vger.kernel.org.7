Return-Path: <linux-kernel+bounces-761722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8FEB1FDB9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EA81898930
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B68626E179;
	Mon, 11 Aug 2025 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOnm6FGd"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B823258CDA;
	Mon, 11 Aug 2025 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754878997; cv=none; b=QFs6vV3PUfSVThtOgotcBDDQZyjS8nVVsOQlBp4TyC85rD8ZWw24IgJDsdRAfgL4cRM39rghmKg2Sv+E4Yk2zu1qhM9CVCLCaLgEzzpW/jLi+8rlkjflHOOOyVKoNPX/VKewHYkFAGbxgUQ1lkIKt7esLHYDuWu7HvaeFTtGDwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754878997; c=relaxed/simple;
	bh=/NLkUjorWXIPo5Y7M2TKac2fwNSpCjt0Dv1J5eV8V/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIXhZJC/F0TxyAyfWlVEL4BCpYMGoaag7wry1tooT/kEwWYHxiv/ONM3a5c5/KDzsuULEJvHWYIQilvWCk4mbYWaDkE3EtaVrsppDliqtd/MGSHUmTuIgd/uuvUPYmjK6ruBGdiqU/WbLQ+XiycxybH6oB2ufH3iRIo5qa8ECUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOnm6FGd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31ef50d8d57so2662574a91.0;
        Sun, 10 Aug 2025 19:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754878995; x=1755483795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eTsl7kSlQklvBZ9iIicLjf55io1M9uN3LrqY6jh8G8=;
        b=DOnm6FGdhkRAj/dYQKhOmck8Tzr9+f+gaEextayg3RGNQ0zg6EpK1XfkoQaVwYkJh0
         334E98QtyD+9A1/YH8uJwgqHyBrezx1DUdx6oxnleWNsJvH0k053ufIhSwJzwBOYviR2
         Zx6DSSL40T1haydJ34Y5Hjjt8e4uxZOo0u4rTzeGI5sg8wZhcOvazE5QD+MY2GcCf1Fm
         ZzKFL2G7nPcVOySKM+gHLEqpIt5u9IzeyiHL+UJU1Ur6aeoSBHvAmBcL9WXs+CYkWa1Z
         aNLsX9mcxvUAQWuyAWo6+4QKIsYTuht+tdcZQ7Iz5lKjkowVeWtuSvJz2P2tVIckVX/D
         4p8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754878995; x=1755483795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eTsl7kSlQklvBZ9iIicLjf55io1M9uN3LrqY6jh8G8=;
        b=bpP1tD38sFcxRntsYEi9z5RaGqWPmLkdU20vq7Zd0Un8612xBQt1X/EAHowbgeJ1N0
         F0NIJ8VBrkONjEy1p1+dhOEPr+Ap5HvHoJw/qRIBV3PUf0nxDrCSVF8ksyFpvhqpg/en
         RbzZUceuTZ0eN79HAEiAZq8XaMzztGkv4slPVpHNHKLkJY6d0ZyWgVGFK4OZp3FVrkeB
         LLMzPyMQnrboYgC8DHR0OxGZ0Gc5lPU3ngSid7Zr4M03On6RTc7EBNfZ1SzxGvA9U0dD
         njvNWpT/jO7fvW8+sJEhmENuVMhvjjTCb6nZNC33aU4zFvtvF3oYm3+13e+EnsHcv2rE
         CbGw==
X-Forwarded-Encrypted: i=1; AJvYcCV6liRxshjxyKU1fhjdkc+kiY1Yn9c+Fkhjy7g2hd0olQQyJFamVolm0wOn0rAEvdIWFvB1QXTaZUvr008=@vger.kernel.org, AJvYcCVsZW/pjVl3B/8OfHqQjbZzMpcWKVu9+/MC/fNqKAhmLCRNU9b5moSqzA8HG8RjCvy9LXHmH9R505lgsH7yj1bg7dLfWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/YEyCXDpKNpsZQfwCm7EZjxGXZpvM5YXbIcAUn+6yOsDdXkG
	LQJrgO1ZBoeKeQ7qaOh4NfOfHH3eYTt4wIo3w+rsXXcn9ZfxA580LQaf
X-Gm-Gg: ASbGncsWA+RE7ilE73mW+WdV5qd/z07F+/yjHYSB/DPQQFfqFrBVTqTOD0qonMLW2QM
	/duNCgUBgI9t7zAGT+kbXEhoUjcXDMXUFAxKX8BHJyJOS2sPV/AbtrpOxecHIv/WbkfzSGnzACn
	foSaU9FeTqF3nSCRyx99VYFKmWP92OuQRUNSIxdzud6nzL2J+mDZq1nOoYWMsRTw0oVSzrySDyy
	ueZ8EZXVWxGVyVCxpw3I2Fsxt0Tfg+GoFN0h6IWXAGOkOKY1Tup0tTk/NYIc4L+UnRF09lTVlTo
	WGWs8w06j1EgK+yUc4rwMOyz969Z8yS1XnObvDDQjjEjwj3huJr1tanzQZaukib+4uIIsZs7aFR
	RbccVfcUuaUXOSbr0RfK4DHY13WOjA24rezDs6A4tnW62pQ==
X-Google-Smtp-Source: AGHT+IGS1gxcW3r4YQ3boNKcJqb5GQDxxUGuecVeAyv7wpjlnsMQM5r9dnuz7tuMEodk98p4eku7uw==
X-Received: by 2002:a17:90b:390f:b0:31f:3cfd:d33d with SMTP id 98e67ed59e1d1-32183a19a97mr17874689a91.15.1754878995475;
        Sun, 10 Aug 2025 19:23:15 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422be2b3a5sm21880366a12.46.2025.08.10.19.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 19:23:14 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/11] platform/x86: x86-android-tablets: convert Novatek devices to GPIO references
Date: Sun, 10 Aug 2025 19:22:50 -0700
Message-ID: <20250810-x86-andoroid-tablet-v2-4-9c7a1b3c32b2@gmail.com>
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
driver away from using GPIO lookup tables for Novatek touchscreens to
using PROPERTY_ENTRY_GPIO() to keep all touchscreen properties together.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/other.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index e3907812c8bc..95c5001004a1 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -38,6 +38,15 @@ static const struct software_node acer_b1_750_bma250e_node = {
 	.properties = acer_b1_750_bma250e_props,
 };
 
+static const struct property_entry acer_b1_750_novatek_props[] = {
+	PROPERTY_ENTRY_GPIO("reset-gpios", &baytrail_gpiochip_nodes[1], 26, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node acer_b1_750_novatek_node = {
+	.properties = acer_b1_750_novatek_props,
+};
+
 static const struct x86_i2c_client_info acer_b1_750_i2c_clients[] __initconst = {
 	{
 		/* Novatek NVT-ts touchscreen */
@@ -45,6 +54,7 @@ static const struct x86_i2c_client_info acer_b1_750_i2c_clients[] __initconst =
 			.type = "nt11205-ts",
 			.addr = 0x34,
 			.dev_name = "NVT-ts",
+			.swnode = &acer_b1_750_novatek_node,
 		},
 		.adapter_path = "\\_SB_.I2C4",
 		.irq_data = {
@@ -74,16 +84,7 @@ static const struct x86_i2c_client_info acer_b1_750_i2c_clients[] __initconst =
 	},
 };
 
-static struct gpiod_lookup_table acer_b1_750_nvt_ts_gpios = {
-	.dev_id = "i2c-NVT-ts",
-	.table = {
-		GPIO_LOOKUP("INT33FC:01", 26, "reset", GPIO_ACTIVE_LOW),
-		{ }
-	},
-};
-
 static struct gpiod_lookup_table * const acer_b1_750_gpios[] = {
-	&acer_b1_750_nvt_ts_gpios,
 	&int3496_reference_gpios,
 	NULL
 };
@@ -94,6 +95,7 @@ const struct x86_dev_info acer_b1_750_info __initconst = {
 	.pdev_info = int3496_pdevs,
 	.pdev_count = 1,
 	.gpiod_lookup_tables = acer_b1_750_gpios,
+	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
 };
 
 /*

-- 
2.51.0.rc0.155.g4a0f42376b-goog


