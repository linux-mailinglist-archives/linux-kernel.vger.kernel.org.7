Return-Path: <linux-kernel+bounces-746736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54188B12AA1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFEAF4E710C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A824DD1F;
	Sat, 26 Jul 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="HBM71kzc"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37724BCF5
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753535421; cv=none; b=eXsoaO4MwUkIFecTAKim9TjGuyHJ6/fqTrgOMBhmUUxnDaKENlrjtZQtXJeRvjKCFR42k83z4Ld4VH8uBgdNHL4tAJ72U6EQFLMWJy9syj2xDRiAr2I1Qalg+x3aaym0IYp332hMkiNmHnlwfr3OtHOiNUmHiwEyQrFPEuNeS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753535421; c=relaxed/simple;
	bh=C67aKO7FCd5ZDQiMSKTLq4HBKkrfUiLt/UEjYJGWykc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Te17mCg+MW5hl7A3r7jCoXgU0W6Z9GUpNDIwikq5IFswI3VTsT/yVnIYd5zH/n12UlLwyZ6UqesnoWiK3xBonbn+KeXY8G2QgQJMsejmj1nmlR4PbHWkWym8pq6A4MHPLev5zC0jdYsmPLSketAGyNkGQL7wMVAEKg3LLDwI9gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=HBM71kzc; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-880f2623a6dso96369639f.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1753535418; x=1754140218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skQxKpPrKNdpCm7T4rAP4k9qKdZRbQN/uiLC1I5fUpk=;
        b=HBM71kzcIZW5NUcBYnwVKpuykQClFbiE1le2kSNgWtxyw+7ADMxY43IcCgHaoVbXbe
         rvn3wZH4sdLURdXdi9F/EZfcoFqFypyyI1yFgviGH9sxAZNxa9rsBd7KAA5wTHY1LTja
         JXqIK76+L253ImPN+a82A0YJi4rBD1Z4YleFumsbB6uYocKY+mFray3vjTXB1MI1IcpB
         R6fLGDVaMjD/4CEnKNiCqgK7h17uF1AbNGuHO2t20ZK9XRZNMgE6CpoQrgwGYqCUNN2+
         4s4INkh5z++L6jHpv1oQsHRzKrPBywZduv4TFMD3USf8J15t9T3IQanLskSlAJ2NDtvQ
         76lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753535418; x=1754140218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skQxKpPrKNdpCm7T4rAP4k9qKdZRbQN/uiLC1I5fUpk=;
        b=VSje7Mn9wv/V4BDuocutzQAqP3x+ndwxc9elTEIXVfV9N6TxJ9UNIt2bGbVnVsbC7O
         6EsBHxU/sGEjpQiD/8aj6Qctk+GMdMqCJ/VCpNAZ76HKAot8rh1q5XWM9m7TC58UpNNH
         zn7vpaIi+ds5vzf4cgczTGpyrFGj2IVJa08LtRS9XZkQmz7I5uz08RIkAknModmXaaG0
         W63hlhE0g4bab6ROHRomzzQsUQtLRz2QUTqoalOrH2VX969wJOB3bWMUwCA2+fXrqEAq
         I/qLjbMTZ63BD0mA4zk2lBoKLKvH1Rwn6a5K8RYJjFl/l+S1Btwc4cy8zDoFX7CJ9CjQ
         7urA==
X-Forwarded-Encrypted: i=1; AJvYcCWU17eWmn5IkmjcbILiCplKYW+HqqOQzK//oyhNTZz2/vYVSVGMGc2XPle77nOcbFaoDj+BtHuEOKnLR6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTadJIU/ig3LYJNK5LHPYQyiG5dgQW+nFMSd+SMqEA69SGAYYO
	1loOxIFvyiuh5YZhjV5KYieOPRlLZKB5JsxaSiPbreFR0GteqsSd4wR6VxDnnAp1x3A=
X-Gm-Gg: ASbGnctNZR4g0S0m2kOzxLJx1fZ0VRZ74DuG9XjS5KmN2p8Xm8gOi3SgnnsG8/e0uVR
	RK1qGVfFj+gYO8bjXsVZ91Ceok/RafjNEnZJ+KJ1ivVWpelj67o31bKuk5bqYy5Xa06uyRwC1a+
	HHyoy49XnncbUk67SY6OuP7VG0jkPB2+pYml/eRRym2Hcc33uNkF4rwsg5e6nDUSHKgTGJj/Xuu
	H4e/p2HsrIJUET8Nf0lLtB9h0UR3qP4vL4qXnpKB0guc3xn4rWFZbmZG8nDGVluBdcqTLDvIcMz
	yp/QWRpxueFdZata9ybMQZ9Lh8aqQ1QJSRUoULOaEyT+eUEs2gV2bLbtyL1lWPfBvPXo/dQ0Av/
	ZCAKObSKJGJHy5vPf/x4ikvOIBkcYDmI2+2znXUrPhMNi6VWoIlrIHtlq79yvHs+PDQ==
X-Google-Smtp-Source: AGHT+IEOUDVs8LinrMieT7Bj2nM5l4zO9dDYMygetDt1jIp1At+3JnR8H5mlhp0nDQK9+1WX3RkAVQ==
X-Received: by 2002:a05:6602:60cc:b0:879:c9db:cbf0 with SMTP id ca18e2360f4ac-8800f101692mr1086353239f.2.1753535418382;
        Sat, 26 Jul 2025 06:10:18 -0700 (PDT)
Received: from zippy.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a4ee9fsm49551439f.33.2025.07.26.06.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:10:17 -0700 (PDT)
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
Subject: [PATCH v10 5/8] rtc: spacemit: support the SpacemiT P1 RTC
Date: Sat, 26 Jul 2025 08:09:59 -0500
Message-ID: <20250726131003.3137282-6-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726131003.3137282-1-elder@riscstar.com>
References: <20250726131003.3137282-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the RTC found in the SpacemiT P1 PMIC.  Initially
only setting and reading the time are supported.

The PMIC is implemented as a multi-function device.  This RTC is
probed based on this driver being named in a MFD cell in the simple
MFD I2C driver.

Signed-off-by: Alex Elder <elder@riscstar.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/Kconfig           |  10 ++
 drivers/rtc/Makefile          |   1 +
 drivers/rtc/rtc-spacemit-p1.c | 167 ++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 drivers/rtc/rtc-spacemit-p1.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 64f6e9756aff4..31d355b103d43 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -406,6 +406,16 @@ config RTC_DRV_MAX77686
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-max77686.
 
+config RTC_DRV_SPACEMIT_P1
+	tristate "SpacemiT P1 RTC"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	select MFD_SPACEMIT_P1
+	default ARCH_SPACEMIT
+	help
+	  Enable support for the RTC function in the SpacemiT P1 PMIC.
+	  This driver can also be built as a module, which will be called
+	  "spacemit-p1-rtc".
+
 config RTC_DRV_NCT3018Y
 	tristate "Nuvoton NCT3018Y"
 	depends on OF
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 789bddfea99d8..f41fdb4fabae9 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -171,6 +171,7 @@ obj-$(CONFIG_RTC_DRV_SD2405AL)	+= rtc-sd2405al.o
 obj-$(CONFIG_RTC_DRV_SD3078)	+= rtc-sd3078.o
 obj-$(CONFIG_RTC_DRV_SH)	+= rtc-sh.o
 obj-$(CONFIG_RTC_DRV_SNVS)	+= rtc-snvs.o
+obj-$(CONFIG_RTC_DRV_SPACEMIT_P1)	+= rtc-spacemit-p1.o
 obj-$(CONFIG_RTC_DRV_SPEAR)	+= rtc-spear.o
 obj-$(CONFIG_RTC_DRV_STARFIRE)	+= rtc-starfire.o
 obj-$(CONFIG_RTC_DRV_STK17TA8)	+= rtc-stk17ta8.o
diff --git a/drivers/rtc/rtc-spacemit-p1.c b/drivers/rtc/rtc-spacemit-p1.c
new file mode 100644
index 0000000000000..43ab62494bb4b
--- /dev/null
+++ b/drivers/rtc/rtc-spacemit-p1.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the RTC found in the SpacemiT P1 PMIC
+ *
+ * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
+ */
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+
+#define MOD_NAME	"spacemit-p1-rtc"
+
+/*
+ * Six consecutive 1-byte registers hold the seconds, minutes, hours,
+ * day-of-month, month, and year (respectively).
+ *
+ * The range of values in these registers is:
+ *    seconds	0-59
+ *    minutes	0-59
+ *    hours	0-59
+ *    day	0-30 (struct tm is 1-31)
+ *    month	0-11
+ *    year	years since 2000 (struct tm is since 1900)
+ *
+ * Note that the day and month must be converted after reading and
+ * before writing.
+ */
+#define RTC_TIME		0x0d	/* Offset of the seconds register */
+
+#define RTC_CTRL		0x1d
+#define RTC_EN		BIT(2)
+
+/* Number of attempts to read a consistent time stamp before giving up */
+#define RTC_READ_TRIES		20	/* At least 1 */
+
+struct p1_rtc {
+	struct regmap *regmap;
+	struct rtc_device *rtc;
+};
+
+/*
+ * The P1 hardware documentation states that the register values are
+ * latched to ensure a consistent time snapshot within the registers,
+ * but these are in fact unstable due to a bug in the hardware design.
+ * So we loop until we get two identical readings.
+ */
+static int p1_rtc_read_time(struct device *dev, struct rtc_time *t)
+{
+	struct p1_rtc *p1 = dev_get_drvdata(dev);
+	struct regmap *regmap = p1->regmap;
+	u32 count = RTC_READ_TRIES;
+	u8 seconds;
+	u8 time[6];
+	int ret;
+
+	if (!regmap_test_bits(regmap, RTC_CTRL, RTC_EN))
+		return -EINVAL;		/* RTC is disabled */
+
+	ret = regmap_bulk_read(regmap, RTC_TIME, time, sizeof(time));
+	if (ret)
+		return ret;
+
+	do {
+		seconds = time[0];
+		ret = regmap_bulk_read(regmap, RTC_TIME, time, sizeof(time));
+		if (ret)
+			return ret;
+	} while (time[0] != seconds && --count);
+
+	if (!count)
+		return -EIO;		/* Unable to get a consistent result */
+
+	t->tm_sec = time[0] & GENMASK(5, 0);
+	t->tm_min = time[1] & GENMASK(5, 0);
+	t->tm_hour = time[2] & GENMASK(4, 0);
+	t->tm_mday = (time[3] & GENMASK(4, 0)) + 1;
+	t->tm_mon = time[4] & GENMASK(3, 0);
+	t->tm_year = (time[5] & GENMASK(5, 0)) + 100;
+
+	return 0;
+}
+
+/*
+ * The P1 hardware documentation states that values in the registers are
+ * latched so when written they represent a consistent time snapshot.
+ * Nevertheless, this is not guaranteed by the implementation, so we must
+ * disable the RTC while updating it.
+ */
+static int p1_rtc_set_time(struct device *dev, struct rtc_time *t)
+{
+	struct p1_rtc *p1 = dev_get_drvdata(dev);
+	struct regmap *regmap = p1->regmap;
+	u8 time[6];
+	int ret;
+
+	time[0] = t->tm_sec;
+	time[1] = t->tm_min;
+	time[2] = t->tm_hour;
+	time[3] = t->tm_mday - 1;
+	time[4] = t->tm_mon;
+	time[5] = t->tm_year - 100;
+
+	/* Disable the RTC to update; re-enable again when done */
+	ret = regmap_clear_bits(regmap, RTC_CTRL, RTC_EN);
+	if (ret)
+		return ret;
+
+	/* If something goes wrong, leave the RTC disabled */
+	ret = regmap_bulk_write(regmap, RTC_TIME, time, sizeof(time));
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(regmap, RTC_CTRL, RTC_EN);
+}
+
+static const struct rtc_class_ops p1_rtc_class_ops = {
+	.read_time = p1_rtc_read_time,
+	.set_time = p1_rtc_set_time,
+};
+
+static int p1_rtc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rtc_device *rtc;
+	struct p1_rtc *p1;
+
+	p1 = devm_kzalloc(dev, sizeof(*p1), GFP_KERNEL);
+	if (!p1)
+		return -ENOMEM;
+	dev_set_drvdata(dev, p1);
+
+	p1->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!p1->regmap)
+		return dev_err_probe(dev, -ENODEV, "failed to get regmap\n");
+
+	rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc))
+		return dev_err_probe(dev, PTR_ERR(rtc),
+				     "error allocating device\n");
+	p1->rtc = rtc;
+
+	rtc->ops = &p1_rtc_class_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2063;
+
+	clear_bit(RTC_FEATURE_ALARM, rtc->features);
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
+
+	return devm_rtc_register_device(rtc);
+}
+
+static struct platform_driver p1_rtc_driver = {
+	.probe = p1_rtc_probe,
+	.driver = {
+		.name = MOD_NAME,
+	},
+};
+
+module_platform_driver(p1_rtc_driver);
+
+MODULE_DESCRIPTION("SpacemiT P1 RTC driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" MOD_NAME);
-- 
2.48.1


