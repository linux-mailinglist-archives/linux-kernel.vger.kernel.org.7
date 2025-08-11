Return-Path: <linux-kernel+bounces-761723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E10B1FDBB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949E71898ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79801581F8;
	Mon, 11 Aug 2025 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU8JbNgR"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB01265CCB;
	Mon, 11 Aug 2025 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754878999; cv=none; b=Srcr8DLqO3KU75gdfdbkxXhFJIEVYgBXFs2wh+Zymr9dYdrZWT7/ZPrpz4HkBB5ImsMbn61YLJRd+usc1ph9ceFHRsCiGtCpC/EnELVi8bAhjdQK4F8O4811kllG8X9b9AXS4mo6by/OzqOhSAEc/UL8ofuZh4WBOhQIFbH1ZIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754878999; c=relaxed/simple;
	bh=aCKb1761fkbHxuL/ttlkN7JjmDdUzWg57B4oJyi7jvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrWi/T0gz3ds+myg0F0RehXMGm/CGYxWR5JWrNx/wQ5fliYQBcouVtIlP2ZKMWdTl7tgqvl7BRqgZHWYGO8oc61WnsG9SNoCC57JoZXVfzIoPuO6oi0L2AmeWTFVmcskqPkrDg020R3DnSBGVeR2ocFcuepZaHizZZQGpBeXpHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU8JbNgR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bed310fa1so3143654b3a.2;
        Sun, 10 Aug 2025 19:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754878996; x=1755483796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zkp0z3grdOEJ7uLBKwsJh5wjt9qXCKu4X94POi899Y4=;
        b=MU8JbNgR/sPPy907CBytR3NA/cvAaTbNqVJHbn88L3eFk395HXHZZnSYx+Ko7ePvhS
         tip87GLITDvMACFDK2m9J56Mb9krzGVjzPNQL4HGTlpFkTq3+2NJiyhJjiR6PetlNqgz
         ZW99nolD4K2vTrP80lSdY7mFzgPiwdqNURXDSgCuPiaj14DH2hWhg0AaqDOli9977utv
         pv51Mo08P58F8Ev4uaIufcVNxnPEUudfoy5afbySKeK5WIbTHbAhic+tZYflkH/tPjxM
         oRhTAxln73rz1eD5hgRjF7bxyoyZ4vp6tikJ6pBut4yS1fZBibUsdFNGk/xysYGsHtlG
         mW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754878996; x=1755483796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zkp0z3grdOEJ7uLBKwsJh5wjt9qXCKu4X94POi899Y4=;
        b=pA1Ewl8iPwBogjICEqfCpj1SDbV4xeb+xzwuuZNuFryYVI7HRczthc9J/LstRfy3YH
         45wAj+h/+pwcN6iSfhYeQfja/SX8uMdBrMYh2kDim4F2L7/l5Epc6IyxxKvOCKCIBXAi
         uij15JExLcvrbzs+psVPYbMAyIcPcoSwv+91pKvn9omGiCy1BA5f/RT7hJWZ1hLTB17K
         9A4pITyyA7YsKoMhmFbyIzA8JQc8LXqfMQNMF8i9WQufreUO+zPFSRkk4G06s7p3BFll
         WKm6IQY/G02ZRykN2RZ/9ehwIKv2hTEFg72zaSiqUQOY+wrfc5Ik8R6h/2UDOgDM/g0b
         GM/g==
X-Forwarded-Encrypted: i=1; AJvYcCVHaGImti/ZesYkIlQYoF6bi5V2t0Mo9282nupVhbdHeaty3fEJ11UP6wgHBa4nViNlVLiNVYXOvXsPQKGMjHd22zMA4A==@vger.kernel.org, AJvYcCWzpyIuoCCOqoQRL2TLva1fwbaEl7gD3CiKOU8esB12jvl0Fe9FvdfYK2I3AEbTc6QiOS1VSgUZspecobQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYhes/sOBVgLZRTZ7dzXi+zVAJmnUrLHBKhUGjdyU+okjPtDn
	eSwOxT6Pfv3sJX1j8wrWJLjCaja3TSJVhHdL1MgTE1HAHpxx+sTHWrua
X-Gm-Gg: ASbGncu9aFuko2hI0cL8SSI+qzBqIV3H0Zuu04AfWfXMfnVyXYfwVavSu1y6AxN53Yl
	bQl+Ou8MPIHQYVptu79Iz5NQbv5fwqrsfyphF+D6jjyEf9gAdvLaYNDVatweU3yruLz1LXMRDy5
	hzH5HWhfU0AXB620suXv9hLOxBjLTWqedVl3hi7ieMeDSZq96FBXw+ZTTCPr8g0Q4FTXbrTg8JK
	Z9Zc86wUshxjryCkSjA6PzDX3yL741qQPY4dIWzzWnf0T9npxP+AThyjU56nx7pSzgL8s2ax+ZK
	fGxyjVtDs8xZbFMqvxlzbVGVDk+HltZ86YCPwkjvC5OdjCu+nVdfPmS/e6Q4aC3mjOudRqGBRLM
	ZSBAcYDqzIRWJVfFaf4H72K5Ey3gyAtZDaw7Pi1tOwk0qww==
X-Google-Smtp-Source: AGHT+IECzLfXyJi2obECIdhAtSQjhPm/iQ7n8S5oApaQ4mH3DDGncS8XMj94ujJFAG2MoqHFuzgCIQ==
X-Received: by 2002:a05:6a20:1611:b0:237:d013:8a78 with SMTP id adf61e73a8af0-240551d83f2mr14627578637.37.1754878996424;
        Sun, 10 Aug 2025 19:23:16 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422be2b3a5sm21880366a12.46.2025.08.10.19.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 19:23:15 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] platform/x86: x86-android-tablets: convert EDT devices to GPIO references
Date: Sun, 10 Aug 2025 19:22:51 -0700
Message-ID: <20250810-x86-andoroid-tablet-v2-5-9c7a1b3c32b2@gmail.com>
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
driver away from using GPIO lookup tables for EDT touchscreens to using
PROPERTY_ENTRY_GPIO() to keep all touchscreen properties together.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/other.c | 28 +++++++++++-------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index 95c5001004a1..0f3cc0ea877e 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -436,6 +436,17 @@ static const struct software_node nextbook_ares8a_accel_node = {
 	.properties = nextbook_ares8a_accel_props,
 };
 
+static const struct property_entry nextbook_ares8a_ft5416_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 800),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
+	PROPERTY_ENTRY_GPIO("reset-gpios", &cherryview_gpiochip_nodes[1], 25, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node nextbook_ares8a_ft5416_node = {
+	.properties = nextbook_ares8a_ft5416_props,
+};
+
 static const struct x86_i2c_client_info nextbook_ares8a_i2c_clients[] __initconst = {
 	{
 		/* Freescale MMA8653FC accelerometer */
@@ -452,7 +463,7 @@ static const struct x86_i2c_client_info nextbook_ares8a_i2c_clients[] __initcons
 			.type = "edt-ft5x06",
 			.addr = 0x38,
 			.dev_name = "ft5416",
-			.swnode = &nextbook_ares8_touchscreen_node,
+			.swnode = &nextbook_ares8a_ft5416_node,
 		},
 		.adapter_path = "\\_SB_.PCI0.I2C6",
 		.irq_data = {
@@ -466,23 +477,10 @@ static const struct x86_i2c_client_info nextbook_ares8a_i2c_clients[] __initcons
 	},
 };
 
-static struct gpiod_lookup_table nextbook_ares8a_ft5416_gpios = {
-	.dev_id = "i2c-ft5416",
-	.table = {
-		GPIO_LOOKUP("INT33FF:01", 25, "reset", GPIO_ACTIVE_LOW),
-		{ }
-	},
-};
-
-static struct gpiod_lookup_table * const nextbook_ares8a_gpios[] = {
-	&nextbook_ares8a_ft5416_gpios,
-	NULL
-};
-
 const struct x86_dev_info nextbook_ares8a_info __initconst = {
 	.i2c_client_info = nextbook_ares8a_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(nextbook_ares8a_i2c_clients),
-	.gpiod_lookup_tables = nextbook_ares8a_gpios,
+	.gpiochip_type = X86_GPIOCHIP_CHERRYVIEW,
 };
 
 /*

-- 
2.51.0.rc0.155.g4a0f42376b-goog


