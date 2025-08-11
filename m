Return-Path: <linux-kernel+bounces-761720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ABFB1FDB4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F198189880B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5F125A35A;
	Mon, 11 Aug 2025 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iatm71fk"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCCF1E32DB;
	Mon, 11 Aug 2025 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754878995; cv=none; b=pZyPy0BFT6ZLWCf8S5I8tUenROmFhRlfiPFMt9kOFkKF4BoI8fK9Uu/cQXJLTG6Gu3ztX6p7+UdfOiwgD0i4mVx3Nom1XNMTgMQuNq1wIW8X5OU3IOKRsiFvJNR+5idLSBT2BQufDBZikaZhakPWyRt9gq6dLBcDR/yfJ/Nf9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754878995; c=relaxed/simple;
	bh=2ubWgRaXL0bhOze22YD0OHmuphyo1tC6HJoV+tDyi/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OC0J2z281Dw2ZqOi3fvXgbLEAqPO+UaxU1ZYUGfjmT0xO5PYTrS1Y51vqW9RWaSS2eYmYwgJymj6GzVXqa0bzEUHdRWRbE5NYeBM1DIPqxClbBVh+kuTZ7q9MU2S2f5nGYBgANLph8q+6azOtDGjjWGyegnUsuUrcIARcnHUk8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iatm71fk; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31f255eb191so3959062a91.0;
        Sun, 10 Aug 2025 19:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754878994; x=1755483794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhrINpeq5njRFRa8XYg96CvHaDhaqbivlGAX2pcb5zE=;
        b=iatm71fkwGuy4FNxHx8Lc2Z+z8eXJI4vKITsYjKOZgCvyLZMiQv77+fojX5gdUdR+f
         1yyPMK2k+wUKJIy1WRsuCyP1sWAZEbi2lI1V2sRapOW1aJoyI+Ihlusdc4n+SL4jc9qo
         S1n11hlFXsbZiB8TQTwhC0uJQsvljotgKxYvsvskwSj1Jdr81GQ4C3ibzUq6or49u0Di
         pyDYe+eIZC48PJpDNQXSjCe1bsPYV/Gkpo/CkBWURvmGA7vQk3n/r4+QI3eOTMeKg9+5
         cPezLyZeZdLiKkZainVWMh19U7jPH/HdEsUhqkEXB3i+Uc+uhHHbEu50tsBh9zJ5Zny0
         7I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754878994; x=1755483794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhrINpeq5njRFRa8XYg96CvHaDhaqbivlGAX2pcb5zE=;
        b=WZbRAyiRL3xopSAcbvW4R6S+TlC+UNRyPeF6pJP7BsvLlDYc7YkCL3iYsKE9H6NKnn
         /rivoERNnRZGgdgz/cZ/yzJKFsEmvefJvE0kYLYplppwIuZVpYi0wU/lt8VDmPcAt7Cf
         1T+ZKTsUIS+ZZ7XbxbEdEvWygzC5RIu8L/TdbYDIXTR4qGe0JWozYQFsBte9YvFs3T3b
         dCbMCth/XwZFvviq759GcG1S2diVumhfe2bReoAfI5cXt8VHPv5BmsAKtaOLcFu9o6mS
         GkfHsNLCHgrzNRZxNrmNejsKeB7XXTh2GA793uKr6XNvucVRFyqtpAsMH4rXSvfp52v2
         Jv9g==
X-Forwarded-Encrypted: i=1; AJvYcCVb86IX5MNGMklRTDwulpSmNstDEHG0BWixbSihoFlbQB4yS/zUa9WPnM2jWdEbMZ/gaZYKy5/TC/w8pl7fKXv29aVy6A==@vger.kernel.org, AJvYcCXtjeiXqHzpDGfxxQUMgh7K5q4wd58Za9MGpfNiLf1MQguYwqqTp69nOKsvIlnUO1iJ/b2JHh7TXQoVTLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4IiMo7U/l39XC8lxCrPFYxJJYtGusfrsJlcbv6hgj5gNf7X0
	yz90dLK89JzfCWWuRZep5LJy35wl/Cb7xumbyfbAAoq2/hPn1IBAQUf3VJyUJw==
X-Gm-Gg: ASbGnctSFuvCnmUON0neiSllFCdT+xNXSuoxcIzf8eHFvNtmHbS0MaWLi8NlqaSthtm
	T5bNSmynDnVcgnfunnEi5Ql/AGDK1O1WdsJWPjKc533vt1RJKX0QvLcaCcSEBSMyfy8bOVU1fIh
	khdlOmR2rZpDScMfYjC58D2rlVMCyywwWa7CuWg69iRj8a0NI64ug9t79XPf547sEvf86T9xVvQ
	+g9o1Gw/6KsgI4I/uB8iFlugqsEwNN0e6Qy1cVT6LzTaA7lKKzxC7it5rSh6tEhJcCfkmU+yG/1
	OntWY3RaaFBm0QJnqUwlzQ4f8h3FSl3hYj5cRZzS449RVs/IoZmR1onKihv5zwupS4bzUey7dDX
	lyqNfLPJlOX4MYijiNwTtARuwU0RTr6XY4kBvqdJ4TVZY4y05IgjQ//8V
X-Google-Smtp-Source: AGHT+IEoWEUkLjo9N8YvaIzQFpeJJJ0ww65LHPUXXaeuq3aNVlERKrU/c2KK5qdMd/8Ix62kE3iwHg==
X-Received: by 2002:a17:90b:5105:b0:321:380b:9e85 with SMTP id 98e67ed59e1d1-321b3e81b2emr981651a91.8.1754878993533;
        Sun, 10 Aug 2025 19:23:13 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422be2b3a5sm21880366a12.46.2025.08.10.19.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 19:23:13 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] platform/x86: x86-android-tablets: convert Wacom devices to GPIO references
Date: Sun, 10 Aug 2025 19:22:48 -0700
Message-ID: <20250810-x86-andoroid-tablet-v2-2-9c7a1b3c32b2@gmail.com>
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
driver away from using GPIO lookup tables for Wacom touchscreens to using
PROPERTY_ENTRY_GPIO() to keep all touchscreen properties together.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/lenovo.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index 22fe76ef5b5a..f8d261d37284 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -75,6 +75,7 @@ static const struct software_node lenovo_yb1_x90_goodix_node = {
 static const struct property_entry lenovo_yb1_x90_wacom_props[] = {
 	PROPERTY_ENTRY_U32("hid-descr-addr", 0x0001),
 	PROPERTY_ENTRY_U32("post-reset-deassert-delay-ms", 150),
+	PROPERTY_ENTRY_GPIO("reset-gpios", &cherryview_gpiochip_nodes[0], 82, GPIO_ACTIVE_LOW),
 	{ }
 };
 
@@ -218,17 +219,8 @@ static struct gpiod_lookup_table lenovo_yb1_x90_hideep_gpios = {
 	},
 };
 
-static struct gpiod_lookup_table lenovo_yb1_x90_wacom_gpios = {
-	.dev_id = "i2c-wacom",
-	.table = {
-		GPIO_LOOKUP("INT33FF:00", 82, "reset", GPIO_ACTIVE_LOW),
-		{ }
-	},
-};
-
 static struct gpiod_lookup_table * const lenovo_yb1_x90_gpios[] = {
 	&lenovo_yb1_x90_hideep_gpios,
-	&lenovo_yb1_x90_wacom_gpios,
 	NULL
 };
 

-- 
2.51.0.rc0.155.g4a0f42376b-goog


