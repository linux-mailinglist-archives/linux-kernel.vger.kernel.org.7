Return-Path: <linux-kernel+bounces-873126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A8C132CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1A118982E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F7229293D;
	Tue, 28 Oct 2025 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gnome.org header.i=@gnome.org header.b="PhVqOnrZ"
Received: from smtp.gnome.org (smtp.gnome.org [44.216.4.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E314280325;
	Tue, 28 Oct 2025 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.216.4.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633094; cv=none; b=hT5roZCx8Lf17DjURjiEoPqzXMWU8KRey3WuYmGAX1oMksEIZLxoDPUJecnHK/kLn0hSMbTvJ24GbIfBQwka8veb1WudHgDbwp9s98VSLO+zWAJckH3Cb7HDRVbPPLPrI53wI1JVyu8zBbsLT9ucbB9NELmXYGnK01LWtpeIMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633094; c=relaxed/simple;
	bh=zdg2WR5ElEOcFpZPdBEjMwQHKx2E+JT6vJwGPJcp43k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTiRZssUo7VXwF9H4Qfx6y0017D9Oh5b1bAHsam250qp/6/eSvLwaHggZToFyCsp4JLiOkLcvRHp+w1tPqJHTDxBrYtUwORRfDEwGn1njdDpSV2eDBeZ4LHlYBsiKuDIZeWuR2+VPQTDdUrDjZK3vrDukC/mlpYG0SiRS6XO75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnome.org; spf=pass smtp.mailfrom=gnome.org; dkim=pass (1024-bit key) header.d=gnome.org header.i=@gnome.org header.b=PhVqOnrZ; arc=none smtp.client-ip=44.216.4.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnome.org
Received: from localhost.localdomain (unknown [61.185.218.172])
	by smtp.gnome.org (Postfix) with ESMTPSA id 62CDD1098412F;
	Tue, 28 Oct 2025 06:31:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.gnome.org 62CDD1098412F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gnome.org;
	s=default; t=1761633086;
	bh=yh01/ijVBeH4YcUsL82QrdCb3TZ1vLYINr3BHOaQgsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PhVqOnrZHWSlcqtqwReeE0KmCPGBsMe/JlrcVgQb0UHN1ZCfBYeQBP4AZCkOnxVIr
	 rupvqUOqV7d8cc0/+TX0fnGrpkx4vULFTkFgJVuz7N6PieWxiiaCH1gZ4vSSAKHzl+
	 gywkY8VoXsDWiP3WB7sPk2YCedHQemiq7IlOmhXg=
From: Qiu Wenbo <qiuwenbo@gnome.org>
To: Daniel Scally <djrscally@gmail.com>,
	Hans de Goede <hansg@kernel.org>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: int3472: Fix double free of GPIO device during unregister
Date: Tue, 28 Oct 2025 14:30:09 +0800
Message-ID: <20251028063009.289414-1-qiuwenbo@gnome.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251024050537.92440-1-qiuwenbo@gnome.org>
References: <20251024050537.92440-1-qiuwenbo@gnome.org>
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

Cc: stable@vger.kernel.org
Fixes: 1e5d088a52c2 ("platform/x86: int3472: Stop using devm_gpiod_get()")
Signed-off-by: Qiu Wenbo <qiuwenbo@kylinsec.com.cn>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
Changes since V1:
 - Add Reviewed-by: from Andy Shevchenko and Sakari Ailus
 - Add Cc to stable@
 - Remove the blank line after Fixes:

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
2.51.2


