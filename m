Return-Path: <linux-kernel+bounces-864129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFEFBF9FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9628D4F81A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACAB2D94AB;
	Wed, 22 Oct 2025 04:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="R9YarRAT"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D512D73BD
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108434; cv=none; b=gBFJ9y4IZQbqvzYZyseEG3QVz8Likv0tHw9CKbWDw+YStTuS0CpvV9SJ6zAhdygVyCogQtRAlgruOKChGq7aWpweE6l9nkAvP6hCYDjg6Gn3sC/G/F3gF7gjy9yA6jYgDaDT20PUppy9Ae6kPg4e85555H0pIx3nZlXpl1xFnqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108434; c=relaxed/simple;
	bh=yaCly3CMjBMtRAdh+49SwgtUK8peefycmYSQ6GSuYbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ix3S/W0NW7ftwH7gsrHEELuZIsjXgv+LTI/o2yahP8YyD39TtKvN/dba9FGNdHJA2VIJpoGPq6jdtIj6FKD1I3lkX0S1mcvwDHDMVTepPSgfIK7i0oLtMPzfhEpFdLhfeIBZ/nTHX8YJNIKP/lGvmVeXHaSEbn21KcWhpaqbaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=R9YarRAT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7811fa91774so5706781b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1761108431; x=1761713231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNJchlzQ08KXzi693iiT+LF5MQjDTWP/auMCv7QeW18=;
        b=R9YarRATZZDslefDXAemSIbonitD3cjs93MpYLi8ogDBOUcP9UUHUkJDgpIeEHvO26
         IiywkbVr5n84WDH/9toMBNWfdpObUwi2+WpsXooRADaOQZRJ4Wygtl2KN2yLE39URMHC
         fg5l7BaVLIQK+wBYR/5CEXKvvZXi676fNYLLukC/tpya9PQ51bLHQpB+wDDlhiHUY+pK
         mt/QD2m2H76pOGDdzxfEJqHXOkfdq7NGNDTKxIcXFFwAGwjVvK/yN+r8QGFrQC5GF3w1
         AEZ6xQ5ZBUOR+xDLTVq0o05vgEyord/LxdmSRqdII2UQ4emQ95X30ETkMIrlzjb0TH4p
         9OIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761108431; x=1761713231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNJchlzQ08KXzi693iiT+LF5MQjDTWP/auMCv7QeW18=;
        b=JL9al7ezRW5ubA3Trmyq41/nbseBdZ/MAsTxIWmX2dtbPfwJe6p3Jd0lqFSYidWxSP
         7AHMfa5FyTx18ScMviOQ3rYYoLw8HmE8/Fasz3dnBx0SrdwXrO3WmuOnWDcEwyWwsILn
         uXUBTghs+jkGEDoiDWCRBDBoNdmWDUzl+/LRxH9rNhqUgpQQHeD3JJ06KBheDJgITL0P
         z0orM/7LybkTv4hExB/TtJIpzmFGpc2weB0hRicgaENCQHiEb2LIFAPtBeoFuFqUKG7D
         li7n1itQ+VhLh4z/6yGFJaQsFsJcl2jiHaTwHcQT5czdKkMdko6xR6va0/nxq25/GJmN
         J03Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUOqoAB9OW+UH2Ji2+8FIB6vkif4/yQJuULTl68GhCEYPpptFmKCKQNxQKyij1IEd77aTQBO1ddzf5m4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZFpqlaxC60+RaKfj1nWGfOTSAr79DD4FXHZi5voDMBjaHvkh
	DKIFg5sTZ1Z4sr2md1jJKEJBazRPKEPWotRNQLL6Rbvca58DPIw/xua6YHas3u+tw04=
X-Gm-Gg: ASbGncuOE8LFrWtQZWndx5dSbI8QxltR3j3jTAgwKAdm1niXjRqDQrmx54UT9SefQjZ
	+672i+Qh1JLj8v2JdVjx2PsdwOiDZck5j87zsipwYW+ImrOTKHy4U0ttfbjtWLcjG/+Lk8vdovT
	efAQpwB5mvs0znGMD+LibZlQvvJAmo2hlDQU+xKT2DIsjiuFAWasJcndxIJ/42otEcYKt3zItmb
	CukCnWLYEBfzqHZZoIGfdCLUKgw89jODAL1fWaliJ9aCpHcb0tm9L4Mfii928TE2wUDVwhZz95m
	V3RxEHa0KFNXGqjkWxlPiop9RmnPyCuEzl54Q+RbrAsx6YJjk0CYl3sqX1HI9seurEAweqq9MdS
	RzYqeGM0iWBuMScRPrHvy0qjPyhijF5dHfOS7ztX/eYG81ovgrbEYOmw5SNbfqJjsg7jOJ3LzqZ
	jdqjX1pWLPOYnTylBWhGVhEmvnfg==
X-Google-Smtp-Source: AGHT+IHew15Sp+Fu5zeu/8c4V23WqpmNJ0P8qYG2bNjS3g8AEomTe6/P1R1yKk/8jRN7ebVkmd8Rcg==
X-Received: by 2002:a05:6a20:e212:b0:334:871e:897 with SMTP id adf61e73a8af0-334a85260acmr26784926637.24.1761108430909;
        Tue, 21 Oct 2025 21:47:10 -0700 (PDT)
Received: from z440.. ([2601:1c0:4502:2d00:8004:e310:f3d:dd0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223dd9d6sm1257413a91.7.2025.10.21.21.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:47:10 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/5] drivers/hwmon: Add TSC1641 I2C power monitor driver
Date: Tue, 21 Oct 2025 21:47:04 -0700
Message-ID: <20251022044708.314287-2-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022044708.314287-1-igor@reznichenko.net>
References: <20251022044708.314287-1-igor@reznichenko.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new I2C hwmon driver for the ST Microelectronics TSC1641 16-bit
high-precision power monitor. The driver supports reading bus voltage,
current, power, and temperature. Sysfs attributes are exposed for
shunt resistor value, raw shunt voltage and update interval.
The driver integrates with the hwmon subsystem and supports optional
ALERT pin polarity configuration.

Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
---
 drivers/hwmon/tsc1641.c | 801 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 801 insertions(+)
 create mode 100644 drivers/hwmon/tsc1641.c

diff --git a/drivers/hwmon/tsc1641.c b/drivers/hwmon/tsc1641.c
new file mode 100644
index 000000000000..22b49a7918cf
--- /dev/null
+++ b/drivers/hwmon/tsc1641.c
@@ -0,0 +1,801 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for ST Microelectronics TSC1641 I2C power monitor
+ *
+ * 60 V, 16-bit high-precision power monitor with I2C and MIPI I3C interface
+ * Datasheet: https://www.st.com/resource/en/datasheet/tsc1641.pdf
+ *
+ * Copyright (C) 2025 Igor Reznichenko <igor@reznichenko.net>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+
+/* I2C registers */
+#define TSC1641_CONFIG		0x00
+#define TSC1641_SHUNT_VOLTAGE	0x01
+#define TSC1641_LOAD_VOLTAGE	0x02
+#define TSC1641_POWER		0x03
+#define TSC1641_CURRENT		0x04
+#define TSC1641_TEMP		0x05
+#define TSC1641_MASK		0x06
+#define TSC1641_FLAG		0x07
+#define TSC1641_RSHUNT		0x08 /* Shunt resistance */
+#define TSC1641_SOL		0x09
+#define TSC1641_SUL		0x0A
+#define TSC1641_LOL		0x0B
+#define TSC1641_LUL		0x0C
+#define TSC1641_POL		0x0D
+#define TSC1641_TOL		0x0E
+#define TSC1641_MANUF_ID	0xFE /* 0x0006 */
+#define TSC1641_DIE_ID		0xFF /* 0x1000 */
+#define TSC1641_MAX_REG		0xFF
+
+#define TSC1641_RSHUNT_DEFAULT	0x0000
+#define TSC1641_CONFIG_DEFAULT	0x003F /* Enable temperature sensor */
+
+/* Bit mask for conversion time in the configuration register */
+#define TSC1641_CONV_TIME_MASK	GENMASK(7, 4)
+
+#define TSC1641_CONV_TIME_DEFAULT	1024
+#define TSC1641_MIN_UPDATE_INTERVAL	1024
+
+/* LSB value of different registers */
+#define TSC1641_VLOAD_LSB_MILLIVOLT	2
+#define TSC1641_POWER_LSB_MICROWATT	25000
+#define TSC1641_VSHUNT_LSB_NANOVOLT	2500	/* Use nanovolts to make it integer */
+#define TSC1641_RSHUNT_LSB_UOHM		10
+#define TSC1641_TEMP_LSB_MILLIDEGC	500
+
+/* Bit masks for enabling limit alerts in TSC1641_MASK*/
+#define TSC1641_SHUNT_OV_MASK		BIT(15)
+#define TSC1641_SHUNT_UV_MASK		BIT(14)
+#define TSC1641_LOAD_OV_MASK		BIT(13)
+#define TSC1641_LOAD_UV_MASK		BIT(12)
+#define TSC1641_POWER_OVER_MASK		BIT(11)
+#define TSC1641_TEMP_OVER_MASK		BIT(10)
+#define TSC1641_ALERT_POL_MASK		BIT(1)
+#define TSC1641_ALERT_LATCH_EN_MASK	BIT(0)
+
+/* Flags indicating alerts in TSC1641_FLAG register*/
+#define TSC1641_SHUNT_OV_FLAG		BIT(6)
+#define TSC1641_SHUNT_UV_FLAG		BIT(5)
+#define TSC1641_LOAD_OV_FLAG		BIT(4)
+#define TSC1641_LOAD_UV_FLAG		BIT(3)
+#define TSC1641_POWER_OVER_FLAG		BIT(2)
+#define TSC1641_TEMP_OVER_FLAG		BIT(1)
+
+static bool tsc1641_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TSC1641_CONFIG:
+	case TSC1641_MASK:
+	case TSC1641_RSHUNT:
+	case TSC1641_SOL:
+	case TSC1641_SUL:
+	case TSC1641_LOL:
+	case TSC1641_LUL:
+	case TSC1641_POL:
+	case TSC1641_TOL:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool tsc1641_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TSC1641_SHUNT_VOLTAGE:
+	case TSC1641_LOAD_VOLTAGE:
+	case TSC1641_POWER:
+	case TSC1641_CURRENT:
+	case TSC1641_TEMP:
+	case TSC1641_FLAG:
+	case TSC1641_MANUF_ID:
+	case TSC1641_DIE_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config tsc1641_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.use_single_write = true,
+	.use_single_read = true,
+	.max_register = TSC1641_MAX_REG,
+	.cache_type = REGCACHE_MAPLE,
+	.volatile_reg = tsc1641_volatile_reg,
+	.writeable_reg = tsc1641_writeable_reg,
+};
+
+struct tsc1641_data {
+	long rshunt_uohm;
+	long current_lsb_uA;
+	/* protects register data during updates */
+	struct mutex update_lock;
+	struct regmap *regmap;
+	struct i2c_client *client;
+};
+
+static int tsc1641_set_shunt(struct tsc1641_data *data, u32 val)
+{
+	struct regmap *regmap = data->regmap;
+
+	if (!val)
+		return 0;
+
+	data->rshunt_uohm = val;
+	long mohm = DIV_ROUND_CLOSEST(data->rshunt_uohm, 1000);
+
+	data->current_lsb_uA = DIV_ROUND_CLOSEST(TSC1641_VSHUNT_LSB_NANOVOLT, mohm);
+	/* RSHUNT register LSB is 10uOhm so need to divide further*/
+	long rshunt_reg = DIV_ROUND_CLOSEST(data->rshunt_uohm, TSC1641_RSHUNT_LSB_UOHM);
+	int ret = regmap_write(regmap, TSC1641_RSHUNT, rshunt_reg);
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * Conversion times in uS, value in CONFIG[CT3:CT0] corresponds to index in this array
+ * See "Table 14. CT3 to CT0: conversion time" in:
+ * https://www.st.com/resource/en/datasheet/tsc1641.pdf
+ */
+static const int tsc1641_conv_times[] = { 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768 };
+
+static int tsc1641_reg_to_upd_interval(u16 config)
+{
+	int idx = FIELD_GET(TSC1641_CONV_TIME_MASK, config);
+
+	idx = clamp_val(idx, 0, ARRAY_SIZE(tsc1641_conv_times) - 1);
+	int conv_time = tsc1641_conv_times[idx];
+
+	/* Don't support sub-millisecond update interval as it's not supported in hwmon */
+	conv_time = max(conv_time, TSC1641_MIN_UPDATE_INTERVAL);
+	/* Return nearest value in milliseconds */
+	return DIV_ROUND_CLOSEST(conv_time, 1000);
+}
+
+static u16 tsc1641_upd_interval_to_reg(long interval)
+{
+	/* Supported interval is 1ms - 33ms */
+	interval = clamp_val(interval, 1, 33);
+
+	int conv = interval * 1000;
+	int conv_bits = find_closest(conv, tsc1641_conv_times,
+				 ARRAY_SIZE(tsc1641_conv_times));
+
+	return FIELD_PREP(TSC1641_CONV_TIME_MASK, conv_bits);
+}
+
+static int tsc1641_chip_write(struct device *dev, u32 attr, long val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_chip_update_interval:
+		return regmap_update_bits(data->regmap, TSC1641_CONFIG,
+					  TSC1641_CONV_TIME_MASK,
+					  tsc1641_upd_interval_to_reg(val));
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int tsc1641_chip_read(struct device *dev, u32 attr, long *val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+	u32 regval;
+	int ret;
+
+	switch (attr) {
+	case hwmon_chip_update_interval:
+		ret = regmap_read(data->regmap, TSC1641_CONFIG, &regval);
+		if (ret)
+			return ret;
+
+		*val = tsc1641_reg_to_upd_interval(regval);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int tsc1641_reg_to_value(struct tsc1641_data *data, u8 reg, unsigned int regval)
+{
+	int val;
+
+	switch (reg) {
+	case TSC1641_SHUNT_VOLTAGE:
+		val = (s16)regval * TSC1641_VSHUNT_LSB_NANOVOLT;
+		/* Return microvolts */
+		return DIV_ROUND_CLOSEST(val, 1000);
+	case TSC1641_SOL:
+		fallthrough;
+	case TSC1641_SUL:
+		/* Used for current limits only, so return current in mA */
+		val = (s16)regval * data->current_lsb_uA;
+		return DIV_ROUND_CLOSEST(val, 1000);
+	case TSC1641_LOL:
+		fallthrough;
+	case TSC1641_LUL:
+		fallthrough;
+	case TSC1641_LOAD_VOLTAGE:
+		return (regval * TSC1641_VLOAD_LSB_MILLIVOLT);
+	case TSC1641_POWER:
+		fallthrough;
+	case TSC1641_POL:
+		return (regval * TSC1641_POWER_LSB_MICROWATT);
+	case TSC1641_CURRENT:
+		val = regval * data->current_lsb_uA;
+		/* Current in milliamps */
+		return DIV_ROUND_CLOSEST(val, 1000);
+	case TSC1641_TEMP:
+		fallthrough;
+	case TSC1641_TOL:
+		return (regval * TSC1641_TEMP_LSB_MILLIDEGC);
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
+static int tsc1641_value_to_reg(struct tsc1641_data *data, u8 reg, unsigned int val)
+{
+	int regval;
+
+	switch (reg) {
+	case TSC1641_SOL:
+		fallthrough;
+	case TSC1641_SUL:
+		/* value is in milliamps, so convert to voltage first */
+		regval = (s16)val * data->rshunt_uohm;
+		regval = DIV_ROUND_CLOSEST(regval, TSC1641_VSHUNT_LSB_NANOVOLT);
+		return clamp_val(regval, SHRT_MIN, SHRT_MAX);
+	case TSC1641_LOL:
+		fallthrough;
+	case TSC1641_LUL:
+		regval = DIV_ROUND_CLOSEST(val, TSC1641_VLOAD_LSB_MILLIVOLT);
+		return clamp_val(regval, 0, USHRT_MAX);
+	case TSC1641_POL:
+		regval = DIV_ROUND_CLOSEST(val, TSC1641_POWER_LSB_MICROWATT);
+		return clamp_val(regval, 0, USHRT_MAX);
+	case TSC1641_TOL:
+		regval = DIV_ROUND_CLOSEST(val, TSC1641_TEMP_LSB_MILLIDEGC);
+		return clamp_val(regval, 0, USHRT_MAX);
+	default:
+		/* shouldn't be here */
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
+static int tsc1641_alert_limit_read(struct tsc1641_data *data, u32 mask, int reg, long *val)
+{
+	struct regmap *regmap = data->regmap;
+	int regval;
+	int ret;
+
+	mutex_lock(&data->update_lock);
+	ret = regmap_read(regmap, TSC1641_MASK, &regval);
+	if (ret)
+		goto abort;
+
+	if (regval & mask) {
+		ret = regmap_read(regmap, reg, &regval);
+		if (ret)
+			goto abort;
+		*val = tsc1641_reg_to_value(data, reg, regval);
+	} else {
+		*val = 0;
+	}
+abort:
+	mutex_unlock(&data->update_lock);
+	return ret;
+}
+
+static int tsc1641_alert_limit_write(struct tsc1641_data *data, u32 mask, int limit_reg,
+				     long val)
+{
+	struct regmap *regmap = data->regmap;
+	int ret;
+
+	if (val < 0)
+		return -EINVAL;
+
+	/*
+	 * Disable alert mask first, then write the value and enable alert mask
+	 */
+	mutex_lock(&data->update_lock);
+	ret = regmap_update_bits(regmap, TSC1641_MASK, mask, 0);
+	if (ret < 0)
+		goto abort;
+	ret = regmap_write(regmap, limit_reg, tsc1641_value_to_reg(data, limit_reg, val));
+	if (ret < 0)
+		goto abort;
+
+	if (val)
+		ret = regmap_update_bits(regmap, TSC1641_MASK, mask, mask);
+abort:
+	mutex_unlock(&data->update_lock);
+	return ret;
+}
+
+static int tsc1641_alert_read(struct regmap *regmap, u32 flag, long *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read_bypassed(regmap, TSC1641_FLAG, &regval);
+	if (ret)
+		return ret;
+
+	*val = !!(regval & flag);
+	return 0;
+}
+
+static int tsc1641_in_read(struct device *dev, u32 attr, long *val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	unsigned int regval;
+	int ret;
+
+	switch (attr) {
+	case hwmon_in_input:
+		ret = regmap_read(regmap, TSC1641_LOAD_VOLTAGE, &regval);
+		if (ret)
+			return ret;
+		*val = tsc1641_reg_to_value(data, TSC1641_LOAD_VOLTAGE, regval);
+		break;
+	case hwmon_in_lcrit:
+		return tsc1641_alert_limit_read(data, TSC1641_LOAD_UV_MASK, TSC1641_LUL, val);
+	case hwmon_in_crit:
+		return tsc1641_alert_limit_read(data, TSC1641_LOAD_OV_MASK, TSC1641_LOL, val);
+	case hwmon_in_lcrit_alarm:
+		return tsc1641_alert_read(regmap, TSC1641_LOAD_UV_FLAG, val);
+	case hwmon_in_crit_alarm:
+		return tsc1641_alert_read(regmap, TSC1641_LOAD_OV_FLAG, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int tsc1641_curr_read(struct device *dev, u32 attr, long *val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	unsigned int regval;
+	int ret;
+
+	/* Current limits are the shunt under/over voltage limits */
+	switch (attr) {
+	case hwmon_curr_input:
+		ret = regmap_read(regmap, TSC1641_CURRENT, &regval);
+		if (ret)
+			return ret;
+		*val = tsc1641_reg_to_value(data, TSC1641_CURRENT, regval);
+		break;
+	case hwmon_curr_lcrit:
+		return tsc1641_alert_limit_read(data, TSC1641_SHUNT_UV_MASK,
+						TSC1641_SUL, val);
+	case hwmon_curr_crit:
+		return tsc1641_alert_limit_read(data, TSC1641_SHUNT_OV_MASK,
+						TSC1641_SOL, val);
+	case hwmon_curr_lcrit_alarm:
+		return tsc1641_alert_read(regmap, TSC1641_SHUNT_UV_FLAG, val);
+	case hwmon_curr_crit_alarm:
+		return tsc1641_alert_read(regmap, TSC1641_SHUNT_OV_FLAG, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int tsc1641_power_read(struct device *dev, u32 attr, long *val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	unsigned int regval;
+	int ret;
+
+	switch (attr) {
+	case hwmon_power_input:
+		ret = regmap_read(regmap, TSC1641_POWER, &regval);
+		if (ret)
+			return ret;
+		*val = tsc1641_reg_to_value(data, TSC1641_POWER, regval);
+		break;
+	case hwmon_power_crit:
+		return tsc1641_alert_limit_read(data, TSC1641_POWER_OVER_MASK,
+						TSC1641_POL, val);
+	case hwmon_power_crit_alarm:
+		return tsc1641_alert_read(regmap, TSC1641_POWER_OVER_FLAG, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int tsc1641_temp_read(struct device *dev, u32 attr, long *val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	unsigned int regval;
+	int ret;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		ret = regmap_read(regmap, TSC1641_TEMP, &regval);
+		if (ret)
+			return ret;
+		*val = tsc1641_reg_to_value(data, TSC1641_TEMP, regval);
+		break;
+	case hwmon_temp_crit:
+		return tsc1641_alert_limit_read(data, TSC1641_TEMP_OVER_MASK,
+						TSC1641_TOL, val);
+	case hwmon_temp_crit_alarm:
+		return tsc1641_alert_read(regmap, TSC1641_TEMP_OVER_FLAG, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int tsc1641_in_write(struct device *dev, u32 attr, long val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_in_lcrit:
+		return tsc1641_alert_limit_write(data, TSC1641_LOAD_UV_MASK, TSC1641_LUL, val);
+	case hwmon_in_crit:
+		return tsc1641_alert_limit_write(data, TSC1641_LOAD_OV_MASK, TSC1641_LOL, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int tsc1641_curr_write(struct device *dev, u32 attr, long val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_curr_lcrit:
+		return tsc1641_alert_limit_write(data, TSC1641_SHUNT_UV_MASK,
+						TSC1641_SUL, val);
+	case hwmon_curr_crit:
+		return tsc1641_alert_limit_write(data, TSC1641_SHUNT_OV_MASK,
+						TSC1641_SOL, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int tsc1641_power_write(struct device *dev, u32 attr, long val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_power_crit:
+		return tsc1641_alert_limit_write(data, TSC1641_POWER_OVER_MASK,
+						 TSC1641_POL, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int tsc1641_temp_write(struct device *dev, u32 attr, long val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_temp_crit:
+		return tsc1641_alert_limit_write(data, TSC1641_TEMP_OVER_MASK,
+						 TSC1641_TOL, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static umode_t tsc1641_is_visible(const void *data, enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_update_interval:
+			return 0644;
+		default:
+			break;
+		}
+		break;
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			return 0444;
+		case hwmon_in_lcrit:
+		case hwmon_in_crit:
+			return 0644;
+		case hwmon_in_lcrit_alarm:
+		case hwmon_in_crit_alarm:
+			return 0444;
+		default:
+			break;
+		}
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			return 0444;
+		case hwmon_curr_lcrit:
+		case hwmon_curr_crit:
+			return 0644;
+		case hwmon_curr_lcrit_alarm:
+		case hwmon_curr_crit_alarm:
+			return 0444;
+		default:
+			break;
+		}
+		break;
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+			return 0444;
+		case hwmon_power_crit:
+			return 0644;
+		case hwmon_power_crit_alarm:
+			return 0444;
+		default:
+			break;
+		}
+		break;
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			return 0444;
+		case hwmon_temp_crit:
+			return 0644;
+		case hwmon_temp_crit_alarm:
+			return 0444;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int tsc1641_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_chip:
+		return tsc1641_chip_read(dev, attr, val);
+	case hwmon_in:
+		return tsc1641_in_read(dev, attr, val);
+	case hwmon_curr:
+		return tsc1641_curr_read(dev, attr, val);
+	case hwmon_power:
+		return tsc1641_power_read(dev, attr, val);
+	case hwmon_temp:
+		return tsc1641_temp_read(dev, attr, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int tsc1641_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	switch (type) {
+	case hwmon_chip:
+		return tsc1641_chip_write(dev, attr, val);
+	case hwmon_in:
+		return tsc1641_in_write(dev, attr, val);
+	case hwmon_curr:
+		return tsc1641_curr_write(dev, attr, val);
+	case hwmon_power:
+		return tsc1641_power_write(dev, attr, val);
+	case hwmon_temp:
+		return tsc1641_temp_write(dev, attr, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_channel_info * const tsc1641_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_UPDATE_INTERVAL),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_CRIT | HWMON_I_CRIT_ALARM |
+			   HWMON_I_LCRIT | HWMON_I_LCRIT_ALARM),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_CRIT | HWMON_C_CRIT_ALARM |
+			   HWMON_C_LCRIT | HWMON_C_LCRIT_ALARM),
+	HWMON_CHANNEL_INFO(power,
+			   HWMON_P_INPUT | HWMON_P_CRIT | HWMON_P_CRIT_ALARM),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_CRIT_ALARM),
+	NULL
+};
+
+static ssize_t shunt_resistor_show(struct device *dev,
+				   struct device_attribute *da, char *buf)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%li\n", data->rshunt_uohm);
+}
+
+static ssize_t shunt_voltage_uvolts_show(struct device *dev,
+					 struct device_attribute *da, char *buf)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(regmap, TSC1641_SHUNT_VOLTAGE, &regval);
+	if (ret)
+		return ret;
+	int val = tsc1641_reg_to_value(data, TSC1641_SHUNT_VOLTAGE, regval);
+
+	return sysfs_emit(buf, "%d\n", val);
+}
+
+static ssize_t shunt_resistor_store(struct device *dev,
+				    struct device_attribute *da,
+				    const char *buf, size_t count)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&data->update_lock);
+	ret = tsc1641_set_shunt(data, val);
+	mutex_unlock(&data->update_lock);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+
+static const struct hwmon_ops tsc1641_hwmon_ops = {
+	.is_visible = tsc1641_is_visible,
+	.read = tsc1641_read,
+	.write = tsc1641_write,
+};
+
+static const struct hwmon_chip_info tsc1641_chip_info = {
+	.ops = &tsc1641_hwmon_ops,
+	.info = tsc1641_info,
+};
+
+static DEVICE_ATTR_RW(shunt_resistor);
+static DEVICE_ATTR_RO(shunt_voltage_uvolts);
+
+/* Rshunt and shunt voltage value is exposed via sysfs attributes */
+static struct attribute *tsc1641_attrs[] = {
+	&dev_attr_shunt_resistor.attr,
+	&dev_attr_shunt_voltage_uvolts.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(tsc1641);
+
+static int tsc1641_init(struct device *dev, struct tsc1641_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	u32 shunt;
+	int ret;
+
+	if (device_property_read_u32(dev, "shunt-resistor", &shunt) < 0) {
+		shunt = TSC1641_RSHUNT_DEFAULT;
+		dev_info(dev, "using default shunt-resistor value =%u uOhm\n",
+			 shunt);
+	}
+
+	ret = tsc1641_set_shunt(data, shunt);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(regmap, TSC1641_CONFIG, TSC1641_CONFIG_DEFAULT);
+	if (ret < 0)
+		return ret;
+
+	bool active_high = device_property_read_bool(dev, "st,alert-polarity-active-high");
+
+	regmap_update_bits(regmap, TSC1641_MASK, TSC1641_ALERT_POL_MASK,
+			   FIELD_PREP(TSC1641_ALERT_POL_MASK, active_high));
+
+	return 0;
+}
+
+static int tsc1641_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct tsc1641_data *data;
+	struct device *hwmon_dev;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	mutex_init(&data->update_lock);
+
+	data->regmap = devm_regmap_init_i2c(client, &tsc1641_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		dev_err(dev, "failed to allocate register map\n");
+		return PTR_ERR(data->regmap);
+	}
+
+	ret = tsc1641_init(dev, data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to configure device\n");
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+							 data, &tsc1641_chip_info, tsc1641_groups);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+
+	dev_info(dev, "power monitor %s (Rshunt = %li uOhm)\n",
+		 client->name, data->rshunt_uohm);
+
+	return 0;
+}
+
+static const struct i2c_device_id tsc1641_id[] = {
+	{ "tsc1641", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tsc1641_id);
+
+static const struct of_device_id __maybe_unused tsc1641_of_match[] = {
+	{ .compatible = "st,tsc1641" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tsc1641_of_match);
+
+static struct i2c_driver tsc1641_driver = {
+	.driver = {
+		.name = "tsc1641",
+		.of_match_table = of_match_ptr(tsc1641_of_match),
+	},
+	.probe = tsc1641_probe,
+	.id_table = tsc1641_id,
+};
+
+module_i2c_driver(tsc1641_driver);
+
+MODULE_AUTHOR("Igor Reznichenko <igor@reznichenko.net>");
+MODULE_DESCRIPTION("tsc1641 driver");
+MODULE_LICENSE("GPL");
+
-- 
2.43.0


