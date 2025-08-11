Return-Path: <linux-kernel+bounces-761726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A39B1FDC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C1F3B9987
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA34284B51;
	Mon, 11 Aug 2025 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVTF40pW"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52C277C96;
	Mon, 11 Aug 2025 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754879001; cv=none; b=Bv3Ll7vtQrI20by5218NiVxKSXFgZx4aJZUsrR+yUh1GaaqC5ct+MT9o2K+R9YjgSu9eCMDJR/VjR3uO/+HQORIIOeeb9+AVi+g6V59ZZWw2LprqsBPdH5FBbG6p5J3y23O+kM3pnPfQUA4yX1v2WY8ycIuxOV4jR9zcBdPcep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754879001; c=relaxed/simple;
	bh=ENVa0irmOc/bbLcbUfYi0N0BZgXjuIxrRyD1FecvFx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGSwMoy6pOlWQE6WMUKIW7y6eTvA69s1bjSR8J7jr1CUdx9PCce1ZRhp0Mj+qF/VWJSa4RKphTW3DYdjgr3qDhndY57mbTrGy9Jymno4tW82mWCnIn7+HdkR3MVpoXsCPZ0XREX/3tRob9GO5T5fzPl2jQosoZ0qL/chIr43ipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVTF40pW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bde897110so2978423b3a.3;
        Sun, 10 Aug 2025 19:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754878999; x=1755483799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQpnC1b1ZAHd+3vbKEzRnqbfblJkicMxg/sCkxfbSow=;
        b=BVTF40pWyS0nvvIAzBLqNgmUKAz/wrKNsNU8D4gY7XWCPRZv+Ttdr8M6gX4Bj42CAm
         BGKl3ZXXwDWC9nmP0MlkhobA8hfT0C8ZAo/gq+hqL1xFp/MFESbCHraTTzduNRsT0G/6
         hx3tWtVYnvKOLCWd2oneaSBobWb4M8kIHXlCXEodHZC2jATGkP+KLHy4mILKINyPF2nP
         d1tt/rmUM5hpYils6ntMbkTXo2Qka0qDnTZxOKyiE11BcpGV2lNC4g5sAsqB+fMjhw1b
         7YZ1BM9b07fxyDaMqujYcx6omPd5cCe+svZm90eRhtEOADBIxDnIv8CNoJ+t08gRhPNI
         tA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754878999; x=1755483799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQpnC1b1ZAHd+3vbKEzRnqbfblJkicMxg/sCkxfbSow=;
        b=aeCfkJD7qiDv0uir/RxiHSAckPwCDWSLm5r/6DXBc3SLnbLB+ATmGoalvGpr/k5UFw
         DXKXKP7BwZEYVPOtkw972a50h7Nm3Mu4C2f3tJ2s5LMg1U2l0QvWT/cJnsjqWIrG6oke
         2/X4cSc6dEYCjtWjAyOr0HguCNcxziwxiHowJFvWRREVcY6r5Wo67JWRS/bgsvQ6Ztj4
         /C3+DP2G8dqX3H0PwMNJicuj9qOORQskSqyrvSrnmcWwT2jbsV4YT7RLYj7xA8+v1Zwr
         EftdkwwE74+r1CFm5BUomzcH3REiHQm3lYIe86VPKfnA8ICn6PmSqrCweu/o9pV+Mlka
         GKnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6hdYXS6X7P4kmSFN3UDhgVUsblRTV3d6Qyj3s2PPfPcwSvXPUcFXBgaNz0DBWmqn3Spm9REfOmjdgErM=@vger.kernel.org, AJvYcCV/LqanySEh32ERMAAkiamU10BTs4uCo7NtxwiDOik2yY7GMp5q4BW5LQ2z4DnVc6gwMBd3y7x4Y1REah8JbyjQLSXwrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJmv+65OvjE4+iB+pivzVfUK4xafBblPgAq/VeGSZqZc3nybR
	Fuv1r8gRe5LTasktYMYiZv6pZ4QvvCL6jOIN+icAsK9F4UcgtqCEn5droy8Yxg==
X-Gm-Gg: ASbGncudZ4JkoWvFWs20XzaAcZsI0+NuYHlUS+810ikILeW73NQfTkIbT4xPaUPRRTV
	CKprWap2MDDuper3qDyJDiTb+H838flrPP732jicWcR5BwtgpmiNQF1KnlTg5piqVP+GsmPWNjR
	wXqT/cxy6jOqo5cPpgz9Zcalm32tSy7IE8XV7N1M/CSsGzBH6P4fhZx0DzQkM9rpnR/UCUP8L/w
	0yCrffzohM7PX24xWO4Ya7vVnnsu+oJDwWztIsYe6IISk5HicUC0VV9a/wUkikY7mTLFIe72Jk9
	20smgc1zYgRaPQHnJC7ViJ83i+Any9Fe0tmd4QpmmMIhc5AWRqxgS+kCXaPtcUQ8WFNDnjzCktI
	KsddtXodamNj4iJDEbZYhcJKlN+5Ra4EX6akMqJxrzErms0WpfiZ+LzT+
X-Google-Smtp-Source: AGHT+IGgQ4TtnzRJzjJduSacEwu2QjtcIYt9xnZWz8OTxwWtJAKBh/etqdbjPUP4PIixgUPC2HFwTw==
X-Received: by 2002:a05:6a21:99a4:b0:220:4750:133a with SMTP id adf61e73a8af0-240551604abmr17953391637.25.1754878999033;
        Sun, 10 Aug 2025 19:23:19 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422be2b3a5sm21880366a12.46.2025.08.10.19.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 19:23:18 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] platform/x86: x86-android-tablets: convert HID-I2C devices to GPIO references
Date: Sun, 10 Aug 2025 19:22:54 -0700
Message-ID: <20250810-x86-andoroid-tablet-v2-8-9c7a1b3c32b2@gmail.com>
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
driver away from using GPIO lookup tables for HID-I2C touchscreens to
using PROPERTY_ENTRY_GPIO() to keep all touchscreen properties together.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/other.c | 32 +++---------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index 6f2d389a0258..38c5e7bd88b0 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -588,6 +588,7 @@ const struct x86_dev_info whitelabel_tm800a550l_info __initconst = {
 static const struct property_entry vexia_edu_atla10_5v_touchscreen_props[] = {
 	PROPERTY_ENTRY_U32("hid-descr-addr", 0x0000),
 	PROPERTY_ENTRY_U32("post-reset-deassert-delay-ms", 120),
+	PROPERTY_ENTRY_GPIO("reset-gpios", &baytrail_gpiochip_nodes[1], 26, GPIO_ACTIVE_LOW),
 	{ }
 };
 
@@ -622,23 +623,10 @@ static const struct x86_i2c_client_info vexia_edu_atla10_5v_i2c_clients[] __init
 	}
 };
 
-static struct gpiod_lookup_table vexia_edu_atla10_5v_ft5416_gpios = {
-	.dev_id = "i2c-FTSC1000",
-	.table = {
-		GPIO_LOOKUP("INT33FC:01", 26, "reset", GPIO_ACTIVE_LOW),
-		{ }
-	},
-};
-
-static struct gpiod_lookup_table * const vexia_edu_atla10_5v_gpios[] = {
-	&vexia_edu_atla10_5v_ft5416_gpios,
-	NULL
-};
-
 const struct x86_dev_info vexia_edu_atla10_5v_info __initconst = {
 	.i2c_client_info = vexia_edu_atla10_5v_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(vexia_edu_atla10_5v_i2c_clients),
-	.gpiod_lookup_tables = vexia_edu_atla10_5v_gpios,
+	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
 };
 
 /*
@@ -674,6 +662,7 @@ static const struct software_node vexia_edu_atla10_9v_accel_node = {
 static const struct property_entry vexia_edu_atla10_9v_touchscreen_props[] = {
 	PROPERTY_ENTRY_U32("hid-descr-addr", 0x0000),
 	PROPERTY_ENTRY_U32("post-reset-deassert-delay-ms", 120),
+	PROPERTY_ENTRY_GPIO("reset-gpios", &baytrail_gpiochip_nodes[0], 60, GPIO_ACTIVE_LOW),
 	{ }
 };
 
@@ -766,19 +755,6 @@ static const struct x86_serdev_info vexia_edu_atla10_9v_serdevs[] __initconst =
 	},
 };
 
-static struct gpiod_lookup_table vexia_edu_atla10_9v_ft5416_gpios = {
-	.dev_id = "i2c-FTSC1000",
-	.table = {
-		GPIO_LOOKUP("INT33FC:00", 60, "reset", GPIO_ACTIVE_LOW),
-		{ }
-	},
-};
-
-static struct gpiod_lookup_table * const vexia_edu_atla10_9v_gpios[] = {
-	&vexia_edu_atla10_9v_ft5416_gpios,
-	NULL
-};
-
 static int __init vexia_edu_atla10_9v_init(struct device *dev)
 {
 	struct pci_dev *pdev;
@@ -808,9 +784,9 @@ const struct x86_dev_info vexia_edu_atla10_9v_info __initconst = {
 	.i2c_client_count = ARRAY_SIZE(vexia_edu_atla10_9v_i2c_clients),
 	.serdev_info = vexia_edu_atla10_9v_serdevs,
 	.serdev_count = ARRAY_SIZE(vexia_edu_atla10_9v_serdevs),
-	.gpiod_lookup_tables = vexia_edu_atla10_9v_gpios,
 	.init = vexia_edu_atla10_9v_init,
 	.use_pci = true,
+	.gpiochip_type = X86_GPIOCHIP_BAYTRAIL,
 };
 
 /*

-- 
2.51.0.rc0.155.g4a0f42376b-goog


