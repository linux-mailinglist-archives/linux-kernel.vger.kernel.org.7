Return-Path: <linux-kernel+bounces-868101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC82C045CF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D10B35260D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC4242D79;
	Fri, 24 Oct 2025 05:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gnome.org header.i=@gnome.org header.b="UoTAeoGR"
Received: from smtp.gnome.org (smtp.gnome.org [44.216.4.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8B627453;
	Fri, 24 Oct 2025 05:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.216.4.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761282622; cv=none; b=Us11nva1NFLnvCDQDobVvHyning8Nlhsur+JOQmgwFaPN4Y21dOg/nj29v+KVKGAfmJHnONZcY4H+8keXPtpzg+zDnanX6/+VRuibKeTGgEQoJvHxGVc+vOK3qaayXLn2MqsE8bJ0CSa+SrCJb2LiOo10HWzxQmrJNnnfMxQQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761282622; c=relaxed/simple;
	bh=Urwgcr2L/ptERtPb+G50MiZipzJbGH3Jjwhugkp1UHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnRAO5bF96z5FuE8Cs6UOuyDL/8ihBoAkEiKooLaE/sQMnM7N7O8v5+thxdvApKvojazIv0LnCrnhBruvi4af3s5wxx5eyYow/ayYUFfYJ+GzjL2DkE2DkSdAKvqpI2rRgae2sX6Vi7w2GHX1xNFR2hWwL/NA9nT01PWI/Ztc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnome.org; spf=pass smtp.mailfrom=gnome.org; dkim=pass (1024-bit key) header.d=gnome.org header.i=@gnome.org header.b=UoTAeoGR; arc=none smtp.client-ip=44.216.4.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnome.org
Received: from localhost.localdomain (unknown [61.185.218.172])
	by smtp.gnome.org (Postfix) with ESMTPSA id BFB2D1097BDB7;
	Fri, 24 Oct 2025 05:10:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.gnome.org BFB2D1097BDB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gnome.org;
	s=default; t=1761282613;
	bh=cI21lBfR4dG12MnKXNFuhm6TwazI758CBbnr9dZ7s1A=;
	h=From:To:Cc:Subject:Date:From;
	b=UoTAeoGRpiseHqkorS2OjiLmpLFN8DGdM61S3MCYVD1vNfWP9m5FnoRFJvE1ocp8G
	 0oZUS2EJS4gnPa2lm+ui2Xo4efYjU9I0Tf2tVkMBpyS0ir7nXC8xqpLJvAIUY6UAYM
	 QLXa6WJhCJSPfIy6b+bi3n+JNRNDiPXB0rSqqTvE=
From: Qiu Wenbo <qiuwenbo@gnome.org>
To: Daniel Scally <djrscally@gmail.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Qiu Wenbo <qiuwenbo@kylinsec.com.cn>,
	Qiu Wenbo <qiuwenbo@gnome.org>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen=20?= <ilpo.jarvinen@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH] platform/x86: int3472: Fix double free of GPIO device during unregister
Date: Fri, 24 Oct 2025 13:05:37 +0800
Message-ID: <20251024050537.92440-1-qiuwenbo@gnome.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiu Wenbo <qiuwenbo@kylinsec.com.cn>

regulator_unregister() already frees the associated GPIO device. On
ThinkPad X9 (Lunar Lake), this causes a double free issue that leads to
random failures when other drivers (typically Intel THC) attempt to
allocate interrupts. The root cause is that the reference count of the
pinctrl_intel_platform module unexpectedly drops to zero when this
driver defers its probe.

This behavior can also be reproduced by unloading the module directly.

Fix the issue by removing the redundant release of the GPIO device
during regulator unregistration.

Fixes: 1e5d088a52c2 ("platform/x86: int3472: Stop using devm_gpiod_get()")

Signed-off-by: Qiu Wenbo <qiuwenbo@kylinsec.com.cn>
---
 drivers/platform/x86/intel/int3472/clk_and_regulator.c | 5 +----
 include/linux/platform_data/x86/int3472.h              | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/clk_and_regulator.c b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
index 476ec24d37020..9e052b164a1ab 100644
--- a/drivers/platform/x86/intel/int3472/clk_and_regulator.c
+++ b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
@@ -245,15 +245,12 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
 	if (IS_ERR(regulator->rdev))
 		return PTR_ERR(regulator->rdev);
 
-	int3472->regulators[int3472->n_regulator_gpios].ena_gpio = gpio;
 	int3472->n_regulator_gpios++;
 	return 0;
 }
 
 void skl_int3472_unregister_regulator(struct int3472_discrete_device *int3472)
 {
-	for (int i = 0; i < int3472->n_regulator_gpios; i++) {
+	for (int i = 0; i < int3472->n_regulator_gpios; i++)
 		regulator_unregister(int3472->regulators[i].rdev);
-		gpiod_put(int3472->regulators[i].ena_gpio);
-	}
 }
diff --git a/include/linux/platform_data/x86/int3472.h b/include/linux/platform_data/x86/int3472.h
index 1571e9157fa50..b1b837583d544 100644
--- a/include/linux/platform_data/x86/int3472.h
+++ b/include/linux/platform_data/x86/int3472.h
@@ -100,7 +100,6 @@ struct int3472_gpio_regulator {
 	struct regulator_consumer_supply supply_map[GPIO_REGULATOR_SUPPLY_MAP_COUNT * 2];
 	char supply_name_upper[GPIO_SUPPLY_NAME_LENGTH];
 	char regulator_name[GPIO_REGULATOR_NAME_LENGTH];
-	struct gpio_desc *ena_gpio;
 	struct regulator_dev *rdev;
 	struct regulator_desc rdesc;
 };
-- 
2.51.1


