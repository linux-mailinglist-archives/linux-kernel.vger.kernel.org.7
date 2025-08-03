Return-Path: <linux-kernel+bounces-754262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2144B19198
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 04:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BC77A3910
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 02:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE0686328;
	Sun,  3 Aug 2025 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="gy5xwUNr"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C0192D97
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 02:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754189902; cv=none; b=caJvNo1PzEbE7Nm7rQ3oDnohhV1/MKn5Sr+ek9kgtoRY+HE6JHJD9SRS+NNBFaZ62Rg3U2N4qPQRgEeWyazgCOTbqB3xCxfpPi5I+yGtvbcUA/S4XB5ml8k6XwW8TEehhRNv3y9CUbVeLhUIqzNvIfk201sX86XX6tcgutH4jx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754189902; c=relaxed/simple;
	bh=Vy3dh1W+OnJYZ/v5Lz/MZTnW63W8BbEAjIg6oorEZCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7pRCQJV1yTR1ypjwKkf3iLkOo7+cuO2CYTaO1T1UfZic1YXBR+4cBL7CoAF9UrFdPvqbPmyjLByVirEBSTSOR4MJmULwiL3l0nHboF+CTOPKo7enLJSKYwAYZQf2SvKQBIwvZF/rnaWKNBKSOfbT9Kg0Y/JJN7LwRcqeGoCtPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=gy5xwUNr; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e3ff43383fso24442595ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 19:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1754189900; x=1754794700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NseEEgxawgGlvZ2aogsjO1yTSFjdm2ClsU1ufLIjy44=;
        b=gy5xwUNrAw4vhulcbEJZJhYZmhsPW7FLoBbblRiXbyXDWkUDTVsNYWcN4Xt1jv1pod
         /QkKzoiwCY+f55ypecVd+QFN/tOJzsitZN6/g2YwnOkmAHA+gFoBeDsv4R61RcwzzC3Z
         Lp/lIY1UQkgqaBhnJcmod5TLgchHwzoOIJh2xnRVGQPJxBq3MW+TNUyV14SGwB5Hweqv
         UopyHFbTCU/XCq8lVuGqWEcGMgY+gwJzrjrubblvQZssWWySRfdgYjz4zLReIrWtYr7a
         J+x0xItZoDn9HsoMXUO5rOLBLGxvmRlhK4nFGI29DrKMMrF8MaSdfuSa/o4/ue8ySMQU
         g0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754189900; x=1754794700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NseEEgxawgGlvZ2aogsjO1yTSFjdm2ClsU1ufLIjy44=;
        b=nRN83tXO5pIKooo2zlSr1kWZnO1an8B9lACDenHr+r4KaKL53hPtycHXDItkKB1m1T
         jm8ggv7TcUnaF/O4h5Xmfsp7mm+QhxOGpHHVERrQxAZdFAijwlPTVErYGj28CfSd/7Mj
         n7CNeAAWkO9J/s62ZZiC8s2mh84ZsfJ2fDwjpzEJZ1Kbgpd7cBgu9QZT53v1Wj7XEl50
         bHVuhsC7eOL3VGydMHRWRjEK8f+RfLMRXM6/sTVRQ2ItCsaymmNQYALb7YHazTZ+xXDh
         oVTFKheHQxAqGMYWCHJThj21ld69BwE8xNvwU0+/TTnkiCMC8wSQ+p50Wu8Xpl8Ca2VW
         qHzw==
X-Forwarded-Encrypted: i=1; AJvYcCVjSisVt4vW4c5gybWKdjz5VJOt0yWj3v14KoIjI5i1p3ugdphIahdV5XxjGLCSrQvuVGLmdB61kovY8fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNj0tOw/DlhOYtbH6eKqlZcqkY6EQb/z2OX7ZewalspJYIJ1n
	PyBRUV0hfxY0pLjt20b+3wdv3B2VZ7BOzEgVqZap0i29cLq7Uue56JXajZH/W4qJ4Sk=
X-Gm-Gg: ASbGncsMzCY9WTHnpikQOw6AVJXyUA1WSOnswwBcugQEbDNGGRl/lRqBhIvTkgCxwk1
	bLzF6lx8diF7Uw7jlvN/MThdEcxUlcAT+VUE4YucRDRu2MbgCCm3UchFFKYBXkMBVwtbziaWCpW
	RsPQTQSU9NhBG/ytfggiK0Teb8ba0DVaf5FapJbqYn4VVYTexFdCMpxqOQNQQULSd/ZvV9/2B2l
	+F4lVv4/R2gOrJtu65ckBYtS0GlCkrq/wl8vjCpUyfODaeVu2iQBtCfb602E6EVHFXbPHKIjSSJ
	5VDczXTjl9YMrAmA/xuYL46J1TTaKed5AtBnyj4qM7vUJaspd5j3vnhB7cl9tk2dxpMZ1Ku24KJ
	0mVgQqfuPW7jeDq4ddv5BOlvPV81t7GgOiaLcoJYW8+a4BMkgBaiw8wFY+McDZLQ8VQ==
X-Google-Smtp-Source: AGHT+IHbWkpg5C9tOqNoKe/8SDkAZAG3y2fHUU7GpFbL1Wroag43Y3qOh1rkD1ERdFbRzCvMRbwEWA==
X-Received: by 2002:a05:6e02:351e:b0:3e3:e4b2:8a5f with SMTP id e9e14a558f8ab-3e416116edamr89715755ab.8.1754189900043;
        Sat, 02 Aug 2025 19:58:20 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55b1ac2esm2251906173.1.2025.08.02.19.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 19:58:19 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux.amoon@gmail.com,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/7] mfd: simple-mfd-i2c: add SpacemiT P1 support
Date: Sat,  2 Aug 2025 21:58:06 -0500
Message-ID: <20250803025812.373029-3-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250803025812.373029-1-elder@riscstar.com>
References: <20250803025812.373029-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable support for the RTC and regulators found in the SpacemiT P1
PMIC.  Support is implemented by the simple I2C MFD driver.

The P1 PMIC is normally implemented with the SpacemiT K1 SoC.  This
PMIC provides 6 buck converters and 12 LDO regulators.  It also
implements a switch, watchdog timer, real-time clock, and more.
Initially its RTC and regulators are supported.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/mfd/Kconfig          | 11 +++++++++++
 drivers/mfd/simple-mfd-i2c.c | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8f11b2df14704..3fe242ffcb31d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1238,6 +1238,17 @@ config MFD_QCOM_RPM
 	  Say M here if you want to include support for the Qualcomm RPM as a
 	  module. This will build a module called "qcom_rpm".
 
+config MFD_SPACEMIT_P1
+	tristate "SpacemiT P1 PMIC"
+	depends on I2C
+	select MFD_SIMPLE_MFD_I2C
+	help
+	  This option supports the I2C-based SpacemiT P1 PMIC, which
+	  contains regulators, a power switch, GPIOs, an RTC, and more.
+	  This option is selected when any of the supported sub-devices
+	  is configured.  The basic functionality is implemented by the
+	  simple MFD I2C driver.
+
 config MFD_SPMI_PMIC
 	tristate "Qualcomm SPMI PMICs"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 22159913bea03..47ffaac035cae 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -93,12 +93,30 @@ static const struct simple_mfd_data maxim_mon_max77705 = {
 	.mfd_cell_size = ARRAY_SIZE(max77705_sensor_cells),
 };
 
+
+static const struct regmap_config spacemit_p1_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct mfd_cell spacemit_p1_cells[] = {
+	{ .name = "spacemit-p1-regulator", },
+	{ .name = "spacemit-p1-rtc", },
+};
+
+static const struct simple_mfd_data spacemit_p1 = {
+	.regmap_config = &spacemit_p1_regmap_config,
+	.mfd_cell = spacemit_p1_cells,
+	.mfd_cell_size = ARRAY_SIZE(spacemit_p1_cells),
+};
+
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "kontron,sl28cpld" },
 	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
 	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
 	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
 	{ .compatible = "maxim,max77705-battery", .data = &maxim_mon_max77705},
+	{ .compatible = "spacemit,p1", .data = &spacemit_p1, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
-- 
2.48.1


