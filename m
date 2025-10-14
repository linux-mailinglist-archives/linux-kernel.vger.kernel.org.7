Return-Path: <linux-kernel+bounces-851848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 202A6BD76E0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1165618A2B16
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A95286890;
	Tue, 14 Oct 2025 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFTBpdO2"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EF429B8D9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419979; cv=none; b=Cvku3eHey1NLJx0e538/qEQhXpxycoGV3coK8pR0/7lhI6rqf/ERA27u0UHFA5JdNwQoF2R2vrapERzXYsWeEMcZM7TgVnjubP/8h81nUcfpTZ/IyBbcsCx9HXNDXWp3/S8AEJPEBi54ILA+uBY60DFaV6z1NFARS841wZzXIog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419979; c=relaxed/simple;
	bh=5PrgYBnchXYsediQo8MoI6kCUpghwG71Y37o/Zm0hxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oRJRE62yCyB93rtQpNaO+zZLmEqKB3F7zOJo8ZdGwX0trwySJeRr9qQSmDX9Vd96NLK2QUfRbHNBLMbRf+hVSIlMdsV8msDQmW4lxxGxamxctr+feMmA9sVwhCa9aq97J2CHkFKi3HmQjSyC02zyxVH4vgfbyrwOf15c2yVLbg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFTBpdO2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so4408000b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760419976; x=1761024776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyrvvaa+NrJAFvrquBUgQoGgjsrRKom3UvYrhexiLSs=;
        b=ZFTBpdO2QHc2yKnwRPL2mTV3TqitD8qYXyhzYAqO9Q9YO4xVncqi3NGNUdsSNWZazv
         kUjhxsd0EH1P+abvuK6P70S863KIUoTh5gQeBhRC9VJ86DCz6RZQ/hYUwdJhi9cOuctC
         PgAHdWG5gX8tObtNRYg48K9wscDT/4Pw2vfjDni8LMdPlv6teTtAgIPibeljf7ZdjCS+
         CFB78AlQaYxbadD6ZZQFY1zYV5RzAqXLMSM8l5koxX6g4HK3S2pPKXbquZZIn1k60U4P
         9qoqVIqqmPwcHdGniNzbrPAUJnA1Bb7GLMT/TXnq6OxswVm54dohbms9/nbCHcY7uBpQ
         HKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760419976; x=1761024776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyrvvaa+NrJAFvrquBUgQoGgjsrRKom3UvYrhexiLSs=;
        b=mJ5wdvlWjU4z9vs/NS0kFEOZSVq/pDYY6XcYDTUaYSmVFqO1Ry4cvgNDQrjfIx4xWq
         Q4KwoNvGmLWLTmp0AB7iK/jJhW4oRIz483SOQyOuH/1A62aoRCfVY9y7572LhMoKPcKs
         7x4pDAv17aj9b/BJs0OsTIDdovq7cuPgkVAnwLkK2FPta/WEHoFG2aL0L/hZd8GRXsGn
         srr8ZUsV70huoMHsR9OwNEcyDv7QWQ2+eAGkxx5VUGsicgxBrLcirB6Kh+2x5Sla1nSq
         XpZuI/lb87pnlO/E3JAUHkVNssRdeWXiXnN2GJZjUkFnwSJ/jPlQ++1gslpP/9G57j5k
         Tvwg==
X-Forwarded-Encrypted: i=1; AJvYcCVwRRJtpJHSWzqEbPJ990le20b8lJLm9dIDeffb7+QNyN827XK2f7g9Vssl4zVsVpBwfYTQc0v0akj/vgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/yqCICpECCByMZ2fdFu8NRWQ1bEO+wF6y7ZdaGTy4zBgRH94h
	EuPlZMlggIeX2me54tQGjaLrxf5EjVYkOkx4OHvA93S9koKgalPwXmbA
X-Gm-Gg: ASbGncs3dSGE5EYE997fBGqP4Ge9+9Qr9ZbfvMzAkT4W0o32SYJHllznE2mNvozbQh0
	YJEcVkgq/c6bz1IvYJ3btDHr6Gz07OmNTUhiBDywQo5JW/IWE1Dwyjwh6IKkHNHTPvZATTySZmG
	rshjbcxLXvXT1nsT7MTX3ce1W8XlU9Llvb7lINUQXTD69xH8ShHWPGLmYQDBozll+/MXvoH0Z0m
	nuwAtx+ZwOkfwIdlb69RjCS9jLUlLL1SqKQte4oyINiRWbQshrkTN6ENPiujyw+NSIjjfwpv4Mt
	5qrcAN2Jdk+3hSsUORSqpKDjBR7jRM2RXDyDSa+8bb08aMNoAovuELxjMAspzrK2U/YXrgCfbgR
	UQXPhWUCnstRFwyuZaI7g8z5tTlokth8TH4EzIanV1u9BU9j6yAksC0I0N8psGaea98tP+6g=
X-Google-Smtp-Source: AGHT+IHg7124qG++18xXL9hNkJVXpuAmVWVgSjy0Y1h/m5+vNezdbx3eCwYmcjwn3cjRltGdSc6V8Q==
X-Received: by 2002:a05:6a00:4fcf:b0:781:1916:c5fb with SMTP id d2e1a72fcca58-79385ddc921mr30833578b3a.14.1760419976030;
        Mon, 13 Oct 2025 22:32:56 -0700 (PDT)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb11ca0sm13707518b3a.32.2025.10.13.22.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 22:32:55 -0700 (PDT)
From: Joan-Na-adi <joan.na.devcode@gmail.com>
X-Google-Original-From: Joan-Na-adi <joan.na@analog.com>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Joan Na <joan.na@analog.com>
Subject: [PATCH v3 2/3] regulator: max77675: Add MAX77675 regulator driver
Date: Tue, 14 Oct 2025 14:31:41 +0900
Message-Id: <20251014053142.15835-3-joan.na@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014053142.15835-1-joan.na@analog.com>
References: <20251014053142.15835-1-joan.na@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joan Na <joan.na@analog.com>

This patch adds support for the Maxim Integrated MAX77675 PMIC regulator.

The MAX77675 is a compact, highly efficient SIMO (Single Inductor Multiple Output)
power management IC that provides four programmable buck-boost switching regulators
with only one inductor. It supports up to 700mA total output current and operates
from a single-cell Li-ion battery.

An integrated power-up sequencer and I2C interface allow flexible startup
configuration and runtime control.

Fixes:
- Removed unused variable 'value'
- Removed duplicate .list_voltage initializer
- Wrapped of_match_table with of_match_ptr() to fix build failure when CONFIG_OF is not set
- Updated driver code to match new DT binding schema
- Changed regmap_config from REGCACHE_NONE to REGCACHE_MAPLE for improved performance
- Added volatile_reg() to mark status registers as non-cacheable

Signed-off-by: Joan Na <joan.na@analog.com>
---
 drivers/regulator/Kconfig              |   9 +
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/max77675-regulator.c | 868 +++++++++++++++++++++++++
 drivers/regulator/max77675-regulator.h | 220 +++++++
 4 files changed, 1098 insertions(+)
 create mode 100644 drivers/regulator/max77675-regulator.c
 create mode 100644 drivers/regulator/max77675-regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index eaa6df1c9f80..783e718e64a4 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -641,6 +641,15 @@ config REGULATOR_MAX77650
 	  Semiconductor. This device has a SIMO with three independent
 	  power rails and an LDO.
 
+config REGULATOR_MAX77675
+	tristate "Maxim MAX77675 regulator driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver controls the Maxim MAX77675 power regulator via I2C.
+	  It supports four programmable buck-boost outputs.
+	  Say Y here to enable the regulator driver
+
 config REGULATOR_MAX77857
 	tristate "ADI MAX77857/MAX77831 regulator support"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index be98b29d6675..fa9dadd71edd 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_REGULATOR_MAX77503) += max77503-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77541) += max77541-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77650) += max77650-regulator.o
+obj-$(CONFIG_REGULATOR_MAX77675) += max77675-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8649)	+= max8649.o
 obj-$(CONFIG_REGULATOR_MAX8660) += max8660.o
 obj-$(CONFIG_REGULATOR_MAX8893) += max8893.o
diff --git a/drivers/regulator/max77675-regulator.c b/drivers/regulator/max77675-regulator.c
new file mode 100644
index 000000000000..c61fac77cabf
--- /dev/null
+++ b/drivers/regulator/max77675-regulator.c
@@ -0,0 +1,868 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Analog Devices, Inc.
+ * ADI regulator driver for MAX77675.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/bitfield.h>
+#include <dt-bindings/regulator/maxim,max77675-regulator.h>
+
+#include "max77675-regulator.h"
+
+struct max77675_regulator_pdata {
+	u8   fps_slot;
+	bool fixed_slew_rate;
+};
+
+struct max77675_config {
+	u8   en_mode;
+	u8   latency_mode;
+	u8   drv_sbb_strength;
+	u8   dvs_slew_rate;
+	u8   en_debounce_time;
+	u8   manual_reset_time;
+	bool en_pullup_disable;
+	bool bias_low_power_request;
+	bool simo_int_ldo_always_on;
+};
+
+struct max77675_regulator {
+	struct device *dev;
+	struct regmap *regmap;
+	struct max77675_config config;
+	struct max77675_regulator_pdata pdata[MAX77675_ID_NUM_MAX];
+};
+
+/**
+ * Set latency mode.
+ *
+ * @param maxreg Pointer to max77675 device structure.
+ * @param enable true to enable latency mode, false to disable.
+ */
+static int max77675_set_latency_mode(struct max77675_regulator *maxreg, bool enable)
+{
+	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_SBB_TOP_B,
+				  MAX77675_LAT_MODE_BIT,
+				  FIELD_PREP(MAX77675_LAT_MODE_BIT, enable));
+}
+
+/**
+ * Set DVS slew rate mode.
+ *
+ * @param maxreg Pointer to max77675 device structure.
+ * @param enable true to use DVS-controlled slew rate, false for fixed 2mV/us.
+ */
+static int max77675_set_dvs_slew_rate(struct max77675_regulator *maxreg, bool enable)
+{
+	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_SBB_TOP_B,
+				  MAX77675_DVS_SLEW_BIT,
+				  FIELD_PREP(MAX77675_DVS_SLEW_BIT, enable));
+}
+
+/**
+ * Set drive strength.
+ *
+ * @param maxreg Pointer to max77675 device structure.
+ * @param strength 2-bit drive strength value (0-3).
+ *
+ * @return 0 on success, negative error code on failure.
+ */
+static int max77675_set_drv_sbb_strength(struct max77675_regulator *maxreg, u8 strength)
+{
+	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_SBB_TOP_A,
+				  MAX77675_DRV_SBB_MASK,
+				  FIELD_PREP(MAX77675_DRV_SBB_MASK, strength));
+}
+
+/**
+ * Set manual reset time (MRT) for EN pin.
+ *
+ * @param maxreg Pointer to max77675 device structure.
+ * @param mrt 2-bit value (0x0: 4s, 0x1: 8s, 0x2: 12s, 0x3: 16s)
+ */
+static int max77675_set_manual_reset_time(struct max77675_regulator *maxreg, u8 mrt)
+{
+	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_GLBL_A,
+				  MAX77675_MRT_MASK,
+				  FIELD_PREP(MAX77675_MRT_MASK, mrt));
+}
+
+/**
+ * Enable or disable internal pull-up resistor on EN pin.
+ *
+ * @param maxreg Pointer to max77675 device structure.
+ * @param disable true to disable pull-up, false to enable
+ */
+static int max77675_set_en_pullup_disable(struct max77675_regulator *maxreg, bool disable)
+{
+	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_GLBL_A,
+				  MAX77675_PU_DIS_BIT,
+				  FIELD_PREP(MAX77675_PU_DIS_BIT, disable));
+}
+
+/**
+ * Request main bias to enter low-power mode.
+ *
+ * @param maxreg Pointer to max77675 device structure.
+ * @param enable true to request low-power mode, false for normal
+ */
+static int max77675_set_bias_low_power_request(struct max77675_regulator *maxreg, bool enable)
+{
+	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_GLBL_A,
+				  MAX77675_BIAS_LPM_BIT,
+				  FIELD_PREP(MAX77675_BIAS_LPM_BIT, enable));
+}
+
+/**
+ * Force SIMO internal LDO to always supply 1.8V.
+ *
+ * @param maxreg Pointer to max77675 device structure.
+ * @param enable true to always supply 1.8V, false for normal operation
+ */
+static int max77675_set_simo_int_ldo_always_on(struct max77675_regulator *maxreg, bool enable)
+{
+	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_GLBL_A,
+				  MAX77675_SIMO_CH_DIS_BIT,
+				  FIELD_PREP(MAX77675_SIMO_CH_DIS_BIT, enable));
+}
+
+/**
+ * Set EN pin mode.
+ *
+ * @param maxreg Pointer to max77675 device structure.
+ * @param mode 2-bit value: 0x0 (push-button), 0x1 (slide-switch), 0x2 (logic)
+ */
+static int max77675_set_en_mode(struct max77675_regulator *maxreg, u8 mode)
+{
+	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_GLBL_A,
+				  MAX77675_EN_MODE_MASK,
+				  FIELD_PREP(MAX77675_EN_MODE_MASK, mode));
+}
+
+/**
+ * Set debounce time for EN pin.
+ *
+ * @param maxreg Pointer to max77675 device structure.
+ * @param debounce_30ms true for 30ms, false for 100us
+ */
+static int max77675_set_en_debounce_time(struct max77675_regulator *maxreg, bool debounce_30ms)
+{
+	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_GLBL_A,
+				  MAX77675_DBEN_EN_BIT,
+				  FIELD_PREP(MAX77675_DBEN_EN_BIT, debounce_30ms));
+}
+
+static int max77675_regulator_get_fps_src(struct max77675_regulator *maxreg, int id)
+{
+	unsigned int reg_addr;
+	unsigned int val;
+	int ret;
+
+	switch (id) {
+	case MAX77675_ID_SBB0:
+		reg_addr = MAX77675_REG_CNFG_SBB0_B;
+		break;
+	case MAX77675_ID_SBB1:
+		reg_addr = MAX77675_REG_CNFG_SBB1_B;
+		break;
+	case MAX77675_ID_SBB2:
+		reg_addr = MAX77675_REG_CNFG_SBB2_B;
+		break;
+	case MAX77675_ID_SBB3:
+		reg_addr = MAX77675_REG_CNFG_SBB3_B;
+		break;
+	default:
+		dev_err(maxreg->dev, "Invalid regulator id: %d\n", id);
+		return -EINVAL;
+	}
+
+	ret = regmap_read(maxreg->regmap, reg_addr, &val);
+	if (ret < 0) {
+		dev_err(maxreg->dev, "Failed to read FPS source (reg 0x%02x): %d\n",
+			reg_addr, ret);
+		return ret;
+	}
+
+	return val & MAX77675_EN_SBB_MASK;
+}
+
+static int max77675_regulator_set_fps_src(struct max77675_regulator *maxreg, int id, u8 fps_src)
+{
+	unsigned int reg_addr;
+	int ret;
+
+	switch (id) {
+	case MAX77675_ID_SBB0:
+		reg_addr = MAX77675_REG_CNFG_SBB0_B;
+		break;
+	case MAX77675_ID_SBB1:
+		reg_addr = MAX77675_REG_CNFG_SBB1_B;
+		break;
+	case MAX77675_ID_SBB2:
+		reg_addr = MAX77675_REG_CNFG_SBB2_B;
+		break;
+	case MAX77675_ID_SBB3:
+		reg_addr = MAX77675_REG_CNFG_SBB3_B;
+		break;
+	default:
+		dev_err(maxreg->dev, "Invalid regulator id: %d\n", id);
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(maxreg->regmap, reg_addr,
+				 MAX77675_EN_SBB_MASK, fps_src);
+	if (ret < 0) {
+		dev_err(maxreg->dev, "Failed to set FPS source (reg 0x%02x): %d\n",
+			reg_addr, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * max77675_set_sbb_slew_rate_fixed - Set the slew rate for a specific SBB regulator channel
+ *
+ * @maxreg: Pointer to the max77675 regulator structure
+ * @id: Regulator channel ID (ID_SBB0 ~ ID_SBB3)
+ * @fixed: Slew rate value (true = 2mV/us, false = use DVS_SLEW)
+ *
+ * This function configures the slew rate control source for the specified SBB channel by
+ * updating the corresponding bits in the CNFG_SBB_TOP_B register.
+ *
+ * Return: 0 on success, negative error code on failure (e.g., invalid channel ID).
+ */
+static int max77675_set_sbb_slew_rate_fixed(struct max77675_regulator *maxreg, int id, bool fixed)
+{
+	u8 mask, value;
+	u8 slew_src_ctrl_bit = fixed ? 0 : 1;
+
+	switch (id) {
+	case MAX77675_ID_SBB0:
+		mask = MAX77675_SR_SBB0_BIT;
+		value = FIELD_PREP(MAX77675_SR_SBB0_BIT, slew_src_ctrl_bit);
+		break;
+
+	case MAX77675_ID_SBB1:
+		mask = MAX77675_SR_SBB1_BIT;
+		value = FIELD_PREP(MAX77675_SR_SBB1_BIT, slew_src_ctrl_bit);
+		break;
+
+	case MAX77675_ID_SBB2:
+		mask = MAX77675_SR_SBB2_BIT;
+		value = FIELD_PREP(MAX77675_SR_SBB2_BIT, slew_src_ctrl_bit);
+		break;
+
+	case MAX77675_ID_SBB3:
+		mask = MAX77675_SR_SBB3_BIT;
+		value = FIELD_PREP(MAX77675_SR_SBB3_BIT, slew_src_ctrl_bit);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_SBB_TOP_B, mask, value);
+}
+
+static int max77675_init_regulator(struct max77675_regulator *maxreg, int id)
+{
+	struct max77675_regulator_pdata *rpdata = &maxreg->pdata[id];
+	int ret;
+
+	if (rpdata->fps_slot == MAX77675_FPS_DEF) {
+		ret = max77675_regulator_get_fps_src(maxreg, id);
+		if (ret < 0) {
+			dev_err(maxreg->dev, "Failed to read FPS source for ID %d\n", id);
+			return ret;
+		}
+		rpdata->fps_slot = ret;
+	} else {
+		ret = max77675_regulator_set_fps_src(maxreg, id, rpdata->fps_slot);
+		if (ret)
+			dev_warn(maxreg->dev, "Failed to set FPS source for ID %d\n", id);
+	}
+
+	ret = max77675_set_sbb_slew_rate_fixed(maxreg, id, rpdata->fixed_slew_rate);
+	if (ret)
+		dev_warn(maxreg->dev, "Failed to set slew rate for ID %d\n", id);
+
+	return 0;
+}
+
+static int max77675_of_parse_cb(struct device_node *np,
+				const struct regulator_desc *desc,
+				struct regulator_config *config)
+{
+	struct max77675_regulator *maxreg = config->driver_data;
+	struct max77675_regulator_pdata *rpdata = &maxreg->pdata[desc->id];
+	u32 pval;
+	int ret;
+
+	/* Parse FPS slot from DT */
+	ret = of_property_read_u32(np, "maxim,fps-slot", &pval);
+	rpdata->fps_slot = (!ret) ? (u8)pval : MAX77675_FPS_DEF;
+
+	/* Parse slew rate control source */
+	rpdata->fixed_slew_rate = of_property_read_bool(np, "maxim,fixed-slew-rate");
+
+	/* Apply parsed configuration */
+	return max77675_init_regulator(maxreg, desc->id);
+}
+
+static int max77675_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+{
+	struct max77675_regulator *maxreg = rdev_get_drvdata(rdev);
+	unsigned int int_flags;
+	int id = rdev_get_id(rdev);
+	int ret;
+
+	ret = regmap_read(maxreg->regmap, MAX77675_REG_INT_GLBL, &int_flags);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to read INT_GLBL: %d\n", ret);
+		return ret;
+	}
+
+	*flags = 0;
+
+	switch (id) {
+	case MAX77675_ID_SBB0:
+		if (int_flags & MAX77675_INT_SBB0_F_BIT)
+			*flags |= REGULATOR_ERROR_FAIL;
+		break;
+	case MAX77675_ID_SBB1:
+		if (int_flags & MAX77675_INT_SBB1_F_BIT)
+			*flags |= REGULATOR_ERROR_FAIL;
+		break;
+	case MAX77675_ID_SBB2:
+		if (int_flags & MAX77675_INT_SBB2_F_BIT)
+			*flags |= REGULATOR_ERROR_FAIL;
+		break;
+	case MAX77675_ID_SBB3:
+		if (int_flags & MAX77675_INT_SBB3_F_BIT)
+			*flags |= REGULATOR_ERROR_FAIL;
+		break;
+	default:
+		dev_warn(maxreg->dev, "Unsupported regulator ID: %d\n", id);
+		break;
+	}
+
+	if (int_flags & MAX77675_INT_TJAL2_R_BIT) {
+		/* TJAL2 interrupt: Over-temperature condition (above 120 degree) */
+		*flags |= REGULATOR_ERROR_OVER_TEMP;
+	}
+
+	return 0;
+}
+
+static const struct regulator_ops max77675_regulator_ops = {
+	.list_voltage         = regulator_list_voltage_linear,
+	.enable               = regulator_enable_regmap,
+	.disable              = regulator_disable_regmap,
+	.is_enabled           = regulator_is_enabled_regmap,
+	.map_voltage          = regulator_map_voltage_linear,
+	.set_voltage_sel      = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel      = regulator_get_voltage_sel_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.get_error_flags      = max77675_get_error_flags,
+};
+
+static struct regulator_desc max77675_regulators[MAX77675_ID_NUM_MAX] = {
+	{
+		.name                  = "sbb0",
+		.of_match              = of_match_ptr("sbb0"),
+		.regulators_node       = of_match_ptr("regulators"),
+		.of_parse_cb           = max77675_of_parse_cb,
+		.id                    = MAX77675_ID_SBB0,
+		.ops                   = &max77675_regulator_ops,
+		.type                  = REGULATOR_VOLTAGE,
+		.owner                 = THIS_MODULE,
+		.n_voltages            = MAX77675_NUM_LEVELS_25MV,
+		.min_uV                = MAX77675_MIN_UV,
+		.uV_step               = MAX77675_STEP_25MV,
+		.vsel_reg              = MAX77675_REG_CNFG_SBB0_A,
+		.vsel_mask             = MAX77675_TV_SBB0_MASK,
+		.enable_reg            = MAX77675_REG_CNFG_SBB0_B,
+		.enable_mask           = MAX77675_EN_SBB0_MASK,
+		.enable_val            = MAX77675_ENABLE_ON,
+		.disable_val           = MAX77675_ENABLE_OFF,
+		.active_discharge_off  = MAX77675_REGULATOR_AD_OFF,
+		.active_discharge_on   = MAX77675_REGULATOR_AD_ON,
+		.active_discharge_mask = MAX77675_ADE_SBB0_BIT,
+		.active_discharge_reg  = MAX77675_REG_CNFG_SBB0_B,
+	},
+	{
+		.name                  = "sbb1",
+		.of_match              = of_match_ptr("sbb1"),
+		.regulators_node       = of_match_ptr("regulators"),
+		.of_parse_cb           = max77675_of_parse_cb,
+		.id                    = MAX77675_ID_SBB1,
+		.ops                   = &max77675_regulator_ops,
+		.type                  = REGULATOR_VOLTAGE,
+		.owner                 = THIS_MODULE,
+		.n_voltages            = MAX77675_NUM_LEVELS_25MV,
+		.min_uV                = MAX77675_MIN_UV,
+		.uV_step               = MAX77675_STEP_25MV,
+		.vsel_reg              = MAX77675_REG_CNFG_SBB1_A,
+		.vsel_mask             = MAX77675_TV_SBB1_MASK,
+		.enable_reg            = MAX77675_REG_CNFG_SBB1_B,
+		.enable_mask           = MAX77675_EN_SBB1_MASK,
+		.enable_val            = MAX77675_ENABLE_ON,
+		.disable_val           = MAX77675_ENABLE_OFF,
+		.active_discharge_off  = MAX77675_REGULATOR_AD_OFF,
+		.active_discharge_on   = MAX77675_REGULATOR_AD_ON,
+		.active_discharge_mask = MAX77675_ADE_SBB1_BIT,
+		.active_discharge_reg  = MAX77675_REG_CNFG_SBB1_B,
+	},
+	{
+		.name                  = "sbb2",
+		.of_match              = of_match_ptr("sbb2"),
+		.regulators_node       = of_match_ptr("regulators"),
+		.of_parse_cb           = max77675_of_parse_cb,
+		.id                    = MAX77675_ID_SBB2,
+		.ops                   = &max77675_regulator_ops,
+		.type                  = REGULATOR_VOLTAGE,
+		.owner                 = THIS_MODULE,
+		.n_voltages            = MAX77675_NUM_LEVELS_25MV,
+		.min_uV                = MAX77675_MIN_UV,
+		.uV_step               = MAX77675_STEP_25MV,
+		.vsel_reg              = MAX77675_REG_CNFG_SBB2_A,
+		.vsel_mask             = MAX77675_TV_SBB2_MASK,
+		.enable_reg            = MAX77675_REG_CNFG_SBB2_B,
+		.enable_mask           = MAX77675_EN_SBB2_MASK,
+		.enable_val            = MAX77675_ENABLE_ON,
+		.disable_val           = MAX77675_ENABLE_OFF,
+		.active_discharge_off  = MAX77675_REGULATOR_AD_OFF,
+		.active_discharge_on   = MAX77675_REGULATOR_AD_ON,
+		.active_discharge_mask = MAX77675_ADE_SBB2_BIT,
+		.active_discharge_reg  = MAX77675_REG_CNFG_SBB2_B,
+	},
+	{
+		.name                  = "sbb3",
+		.of_match              = of_match_ptr("sbb3"),
+		.regulators_node       = of_match_ptr("regulators"),
+		.of_parse_cb           = max77675_of_parse_cb,
+		.id                    = MAX77675_ID_SBB3,
+		.ops                   = &max77675_regulator_ops,
+		.type                  = REGULATOR_VOLTAGE,
+		.owner                 = THIS_MODULE,
+		.n_voltages            = MAX77675_NUM_LEVELS_25MV,
+		.min_uV                = MAX77675_MIN_UV,
+		.uV_step               = MAX77675_STEP_25MV,
+		.vsel_reg              = MAX77675_REG_CNFG_SBB3_A,
+		.vsel_mask             = MAX77675_TV_SBB3_MASK,
+		.enable_reg            = MAX77675_REG_CNFG_SBB3_B,
+		.enable_mask           = MAX77675_EN_SBB3_MASK,
+		.enable_val            = MAX77675_ENABLE_ON,
+		.disable_val           = MAX77675_ENABLE_OFF,
+		.active_discharge_off  = MAX77675_REGULATOR_AD_OFF,
+		.active_discharge_on   = MAX77675_REGULATOR_AD_ON,
+		.active_discharge_mask = MAX77675_ADE_SBB3_BIT,
+		.active_discharge_reg  = MAX77675_REG_CNFG_SBB3_B,
+	},
+};
+
+static bool max77675_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX77675_REG_CNFG_GLBL_B:
+		/* This register can be updated by an internal state machine */
+	case MAX77675_REG_INT_GLBL:
+	case MAX77675_REG_STAT_GLBL:
+	case MAX77675_REG_ERCF_GLBL:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config max77675_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX77675_MAX_REGISTER,
+	.cache_type = REGCACHE_MAPLE,
+	.volatile_reg = max77675_volatile_reg,
+};
+
+static int max77675_apply_config(struct max77675_regulator *maxreg)
+{
+	const struct max77675_config *config = &maxreg->config;
+	int ret;
+
+	ret = max77675_set_en_mode(maxreg, config->en_mode);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to set EN mode: %d\n", ret);
+		return ret;
+	}
+
+	ret = max77675_set_latency_mode(maxreg, config->latency_mode);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to set latency mode: %d\n", ret);
+		return ret;
+	}
+
+	ret = max77675_set_drv_sbb_strength(maxreg, config->drv_sbb_strength);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to set drive strength: %d\n", ret);
+		return ret;
+	}
+
+	ret = max77675_set_dvs_slew_rate(maxreg, config->dvs_slew_rate);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to set DVS slew rate: %d\n", ret);
+		return ret;
+	}
+
+	ret = max77675_set_en_debounce_time(maxreg, config->en_debounce_time);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to set EN debounce time: %d\n", ret);
+		return ret;
+	}
+
+	ret = max77675_set_manual_reset_time(maxreg, config->manual_reset_time);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to set manual reset time: %d\n", ret);
+		return ret;
+	}
+
+	ret = max77675_set_en_pullup_disable(maxreg, config->en_pullup_disable);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to set EN pull-up disable: %d\n", ret);
+		return ret;
+	}
+
+	ret = max77675_set_bias_low_power_request(maxreg, config->bias_low_power_request);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to set bias low-power request: %d\n", ret);
+		return ret;
+	}
+
+	ret = max77675_set_simo_int_ldo_always_on(maxreg, config->simo_int_ldo_always_on);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to set SIMO internal LDO always-on: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static u8 max77675_parse_latency_mode(struct device_node *np)
+{
+	const char *str;
+
+	if (!of_property_read_string(np, "maxim,latency-mode", &str)) {
+		if (!strcasecmp(str, "low"))
+			return MAX77675_LOW_LATENCY_MODE;
+		else if (!strcasecmp(str, "high"))
+			return MAX77675_HIGH_LATENCY_MODE;
+	}
+
+	/* default: high latency */
+	return MAX77675_HIGH_LATENCY_MODE;
+}
+
+static u8 max77675_parse_en_mode(struct device_node *np)
+{
+	const char *str;
+
+	if (!of_property_read_string(np, "maxim,en-mode", &str)) {
+		if (!strcasecmp(str, "push-button"))
+			return MAX77675_EN_PUSH_BUTTON;
+		else if (!strcasecmp(str, "slide-switch"))
+			return MAX77675_EN_SLIDE_SWITCH;
+		else if (!strcasecmp(str, "logic"))
+			return MAX77675_EN_LOGIC;
+	}
+
+	/* default : slide-switch */
+	return MAX77675_EN_SLIDE_SWITCH;
+}
+
+static u8 max77675_parse_manual_reset_time(struct device_node *np)
+{
+	u32 val;
+
+	if (!of_property_read_u32(np, "maxim,manual-reset-time-sec", &val)) {
+		switch (val) {
+		case 4:
+			return MAX77675_MRT_4S;
+		case 8:
+			return MAX77675_MRT_8S;
+		case 12:
+			return MAX77675_MRT_12S;
+		case 16:
+			return MAX77675_MRT_16S;
+		default:
+			break;
+		}
+	}
+
+	/* default : 4 seconds */
+	return MAX77675_MRT_4S;
+}
+
+static u8 max77675_parse_dvs_slew_rate(struct device_node *np)
+{
+	u32 val;
+
+	if (!of_property_read_u32(np, "maxim,dvs-slew-rate-mv-per-us", &val)) {
+		switch (val) {
+		case 5:
+			return MAX77675_DVS_SLEW_5MV_PER_US;
+		case 10:
+			return MAX77675_DVS_SLEW_10MV_PER_US;
+		default:
+			break;
+		}
+	}
+
+	/* default: 5 mV/us */
+	return MAX77675_DVS_SLEW_5MV_PER_US;
+}
+
+static u8 max77675_parse_drv_sbb_strength(struct device_node *np)
+{
+	const char *str;
+
+	if (!of_property_read_string(np, "maxim,drv-sbb-strength", &str)) {
+		if (!strcasecmp(str, "max"))
+			return MAX77675_DRV_SBB_STRENGTH_MAX;
+		else if (!strcasecmp(str, "high"))
+			return MAX77675_DRV_SBB_STRENGTH_HIGH;
+		else if (!strcasecmp(str, "low"))
+			return MAX77675_DRV_SBB_STRENGTH_LOW;
+		else if (!strcasecmp(str, "min"))
+			return MAX77675_DRV_SBB_STRENGTH_MIN;
+	}
+
+	/* default : maximum */
+	return MAX77675_DRV_SBB_STRENGTH_MAX;
+}
+
+static u32 max77675_parse_en_debounce_time_us(struct device_node *np)
+{
+	u32 val;
+
+	if (!of_property_read_u32(np, "maxim,en-debounce-time-us", &val)) {
+		switch (val) {
+		case 100:
+			return MAX77675_DBEN_100US;
+		case 30000:
+			return MAX77675_DBEN_30000US;
+		default:
+			break;
+		}
+	}
+
+	/* default: 100 us */
+	return MAX77675_DBEN_100US;
+}
+
+static int max77675_parse_config(struct max77675_regulator *maxreg)
+{
+	struct device_node *np = maxreg->dev->of_node;
+	struct max77675_config *config = &maxreg->config;
+	int ret;
+
+	/* EN pin mode: push-button, slide-switch, or logic */
+	config->en_mode = max77675_parse_en_mode(np);
+
+	/* latency mode */
+	config->latency_mode = max77675_parse_latency_mode(np);
+
+	/* drive strength */
+	config->drv_sbb_strength = max77675_parse_drv_sbb_strength(np);
+
+	/* drv slew rate */
+	config->dvs_slew_rate = max77675_parse_dvs_slew_rate(np);
+
+	/* Debounce time for EN pin */
+	config->en_debounce_time = max77675_parse_en_debounce_time_us(np);
+
+	/* Manual reset time for EN pin */
+	config->manual_reset_time = max77675_parse_manual_reset_time(np);
+
+	/* Disable internal pull-up resistor on EN pin */
+	config->en_pullup_disable = of_property_read_bool(np, "maxim,en-pullup-disable");
+
+	/* Request low-power mode for main bias */
+	config->bias_low_power_request = of_property_read_bool(np, "maxim,bias-low-power-request");
+
+	/* Force internal LDO to always supply 1.8V */
+	config->simo_int_ldo_always_on = of_property_read_bool(np, "maxim,simo-int-ldo-always-on");
+
+	ret = max77675_apply_config(maxreg);
+
+	return ret;
+}
+
+static int max77675_init_event(struct max77675_regulator *maxreg)
+{
+	unsigned int ercflag, int_glbl;
+	int ret;
+
+	ret = regmap_read(maxreg->regmap, MAX77675_REG_ERCF_GLBL, &ercflag);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to read CID register: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(maxreg->regmap, MAX77675_REG_INT_GLBL, &int_glbl);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to read INT_GLBL register: %d\n", ret);
+		return ret;
+	}
+
+	if (ercflag & MAX77675_SFT_CRST_F_BIT)
+		dev_info(maxreg->dev, "Software Cold Reset Flag is set\n");
+
+	if (ercflag & MAX77675_SFT_OFF_F_BIT)
+		dev_info(maxreg->dev, "Software Off Flag is set\n");
+
+	if (ercflag & MAX77675_MRST_BIT)
+		dev_info(maxreg->dev, "Manual Reset Timer Flag is set\n");
+
+	if (ercflag & MAX77675_UVLO_BIT)
+		dev_info(maxreg->dev, "Undervoltage Lockout Flag is set\n");
+
+	if (ercflag & MAX77675_OVLO_BIT)
+		dev_info(maxreg->dev, "Overvoltage Lockout Flag is set\n");
+
+	if (ercflag & MAX77675_TOVLD_BIT)
+		dev_info(maxreg->dev, "Thermal Overload Flag is set\n");
+
+	if (int_glbl & MAX77675_INT_SBB3_F_BIT)
+		dev_info(maxreg->dev, "SBB3 Channel Fault Interrupt occurred\n");
+
+	if (int_glbl & MAX77675_INT_SBB2_F_BIT)
+		dev_info(maxreg->dev, "SBB2 Channel Fault Interrupt occurred\n");
+
+	if (int_glbl & MAX77675_INT_SBB1_F_BIT)
+		dev_info(maxreg->dev, "SBB1 Channel Fault Interrupt occurred\n");
+
+	if (int_glbl & MAX77675_INT_SBB0_F_BIT)
+		dev_info(maxreg->dev, "SBB0 Channel Fault Interrupt occurred\n");
+
+	if (int_glbl & MAX77675_INT_TJAL2_R_BIT)
+		dev_info(maxreg->dev, "Thermal Alarm 2 Rising Interrupt occurred\n");
+
+	if (int_glbl & MAX77675_INT_TJAL1_R_BIT)
+		dev_info(maxreg->dev, "Thermal Alarm 1 Rising Interrupt occurred\n");
+
+	if (int_glbl & MAX77675_INT_EN_R_BIT)
+		dev_info(maxreg->dev, "nEN Rising Edge Interrupt occurred\n");
+
+	if (int_glbl & MAX77675_INT_EN_F_BIT)
+		dev_info(maxreg->dev, "nEN Falling Edge Interrupt occurred\n");
+
+	return 0;
+}
+
+static int max77675_regulator_probe(struct i2c_client *client)
+{
+	struct max77675_regulator *maxreg;
+	struct regulator_config config = {};
+	struct device_node *regulators_np;
+	int i, ret;
+
+	maxreg = devm_kzalloc(&client->dev, sizeof(*maxreg), GFP_KERNEL);
+	if (!maxreg)
+		return -ENOMEM;
+
+	maxreg->dev = &client->dev;
+
+	maxreg->regmap = devm_regmap_init_i2c(client, &max77675_regmap_config);
+	if (IS_ERR(maxreg->regmap))
+		return dev_err_probe(maxreg->dev,
+				     PTR_ERR(maxreg->regmap),
+				     "Failed to init regmap\n");
+
+	ret = max77675_init_event(maxreg);
+	if (ret)
+		return dev_err_probe(maxreg->dev, ret, "Failed to init event\n");
+
+	ret = max77675_parse_config(maxreg);
+	if (ret)
+		return dev_err_probe(maxreg->dev, ret, "Failed to apply config\n");
+
+	config.dev = &client->dev;
+	config.regmap = maxreg->regmap;
+	config.driver_data = maxreg;
+
+	regulators_np = of_get_child_by_name(client->dev.of_node, "regulators");
+	if (!regulators_np) {
+		dev_err(maxreg->dev, "No 'regulators' subnode found in DT\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < MAX77675_ID_NUM_MAX; i++) {
+		const struct regulator_desc *desc = &max77675_regulators[i];
+		struct regulator_dev *rdev;
+		struct device_node *child_np;
+
+		child_np = of_get_child_by_name(regulators_np, desc->name);
+		if (!child_np) {
+			dev_warn(maxreg->dev, "No DT node for regulator %s\n", desc->name);
+			continue;
+		}
+
+		config.of_node = child_np;
+
+		rdev = devm_regulator_register(&client->dev, desc, &config);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
+			dev_err(maxreg->dev,
+				"Failed to register regulator %d (%s): %d\n",
+				i, desc->name, ret);
+			of_node_put(child_np);
+			return ret;
+		}
+		of_node_put(child_np);
+	}
+
+	i2c_set_clientdata(client, maxreg);
+
+	return 0;
+}
+
+static void max77675_regulator_remove(struct i2c_client *client)
+{
+	/* Nothing to clean up currently */
+}
+
+static const struct i2c_device_id max77675_i2c_id[] = {
+	{ "max77675", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max77675_i2c_id);
+
+static const struct of_device_id __maybe_unused max77675_of_match[] = {
+	{ .compatible = "maxim,max77675", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77675_of_match);
+
+static struct i2c_driver max77675_regulator_driver = {
+	.driver = {
+		.name = "max77675",
+		.of_match_table = of_match_ptr(max77675_of_match),
+	},
+	.probe = max77675_regulator_probe,
+	.remove = max77675_regulator_remove,
+	.id_table = max77675_i2c_id,
+};
+
+module_i2c_driver(max77675_regulator_driver);
+
+MODULE_DESCRIPTION("MAX77675 Regulator Driver");
+MODULE_AUTHOR("Joan Na <joan.na@analog.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/max77675-regulator.h b/drivers/regulator/max77675-regulator.h
new file mode 100644
index 000000000000..d0679c284b22
--- /dev/null
+++ b/drivers/regulator/max77675-regulator.h
@@ -0,0 +1,220 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * MAX77675 Register Definitions
+ * Reference: MAX77675 Datasheet
+ */
+
+#ifndef __MAX77675_REG_H__
+#define __MAX77675_REG_H__
+
+#include <linux/bitops.h>
+
+/* Register Addresses */
+#define MAX77675_REG_CNFG_GLBL_A     0x00
+#define MAX77675_REG_CNFG_GLBL_B     0x01
+#define MAX77675_REG_INT_GLBL        0x02
+#define MAX77675_REG_INTM_GLBL       0x03
+#define MAX77675_REG_STAT_GLBL       0x04
+#define MAX77675_REG_ERCF_GLBL       0x05
+#define MAX77675_REG_CID             0x06
+#define MAX77675_REG_CNFG_SBB_TOP_A  0x07
+#define MAX77675_REG_CNFG_SBB0_A     0x08
+#define MAX77675_REG_CNFG_SBB0_B     0x09
+#define MAX77675_REG_CNFG_SBB1_A     0x0A
+#define MAX77675_REG_CNFG_SBB1_B     0x0B
+#define MAX77675_REG_CNFG_SBB2_A     0x0C
+#define MAX77675_REG_CNFG_SBB2_B     0x0D
+#define MAX77675_REG_CNFG_SBB3_A     0x0E
+#define MAX77675_REG_CNFG_SBB3_B     0x0F
+#define MAX77675_REG_CNFG_SBB_TOP_B  0x10
+
+/* CNFG_GLBL_A (0x00) bit masks and shifts */
+#define MAX77675_MRT_MASK           GENMASK(7, 6)    /* Manual Reset Time (bits 7:6) */
+#define MAX77675_MRT_SHIFT          6
+#define MAX77675_PU_DIS_BIT         BIT(5)           /* Pullup Disable (bit 5) */
+#define MAX77675_PU_DIS_SHIFT       5
+#define MAX77675_BIAS_LPM_BIT       BIT(4)           /* Bias Low Power Mode (bit 4) */
+#define MAX77675_BIAS_LPM_SHIFT     4
+#define MAX77675_SIMO_CH_DIS_BIT    BIT(3)           /* SIMO Internal Channel Disable (bit 3) */
+#define MAX77675_SIMO_CH_DIS_SHIFT  3
+#define MAX77675_EN_MODE_MASK       GENMASK(2, 1)    /* nEN Mode (bits 2:1) */
+#define MAX77675_EN_MODE_SHIFT      1
+#define MAX77675_DBEN_EN_BIT        BIT(0)           /* Debounce Enable (bit 0) */
+#define MAX77675_DBEN_EN_SHIFT      0
+
+/* CNFG_GLBL_B (0x01) */
+#define MAX77675_SFT_CTRL_MASK      GENMASK(2, 0)    /* Soft Start Control */
+#define MAX77675_SFT_CTRL_SHIFT     0
+
+/* INT_GLBL (0x02) bit bits and shifts */
+#define MAX77675_INT_SBB3_F_BIT     BIT(7)
+#define MAX77675_INT_SBB3_F_SHIFT   7
+#define MAX77675_INT_SBB2_F_BIT     BIT(6)
+#define MAX77675_INT_SBB2_F_SHIFT   6
+#define MAX77675_INT_SBB1_F_BIT     BIT(5)
+#define MAX77675_INT_SBB1_F_SHIFT   5
+#define MAX77675_INT_SBB0_F_BIT     BIT(4)
+#define MAX77675_INT_SBB0_F_SHIFT   4
+#define MAX77675_INT_TJAL2_R_BIT    BIT(3)
+#define MAX77675_INT_TJAL2_R_SHIFT  3
+#define MAX77675_INT_TJAL1_R_BIT    BIT(2)
+#define MAX77675_INT_TJAL1_R_SHIFT  2
+#define MAX77675_INT_EN_R_BIT       BIT(1)
+#define MAX77675_INT_EN_R_SHIFT     1
+#define MAX77675_INT_EN_F_BIT       BIT(0)
+#define MAX77675_INT_EN_F_SHIFT     0
+
+/* INTM_GLBL (0x03) bits and shifts */
+#define MAX77675_INTM_SBB3_F_BIT    BIT(7)
+#define MAX77675_INTM_SBB3_F_SHIFT  7
+#define MAX77675_INTM_SBB2_F_BIT    BIT(6)
+#define MAX77675_INTM_SBB2_F_SHIFT  6
+#define MAX77675_INTM_SBB1_F_BIT    BIT(5)
+#define MAX77675_INTM_SBB1_F_SHIFT  5
+#define MAX77675_INTM_SBB0_F_BIT    BIT(4)
+#define MAX77675_INTM_SBB0_F_SHIFT  4
+#define MAX77675_INTM_TJAL2_R_BIT   BIT(3)
+#define MAX77675_INTM_TJAL2_R_SHIFT 3
+#define MAX77675_INTM_TJAL1_R_BIT   BIT(2)
+#define MAX77675_INTM_TJAL1_R_SHIFT 2
+#define MAX77675_INTM_EN_R_BIT      BIT(1)
+#define MAX77675_INTM_EN_R_SHIFT    1
+#define MAX77675_INTM_EN_F_BIT      BIT(0)
+#define MAX77675_INTM_EN_F_SHIFT    0
+
+/* STAT_GLBL (0x04) bits and shifts */
+#define MAX77675_STAT_SBB3_S_BIT    BIT(7)
+#define MAX77675_STAT_SBB3_S_SHIFT  7
+#define MAX77675_STAT_SBB2_S_BIT    BIT(6)
+#define MAX77675_STAT_SBB2_S_SHIFT  6
+#define MAX77675_STAT_SBB1_S_BIT    BIT(5)
+#define MAX77675_STAT_SBB1_S_SHIFT  5
+#define MAX77675_STAT_SBB0_S_BIT    BIT(4)
+#define MAX77675_STAT_SBB0_S_SHIFT  4
+#define MAX77675_STAT_TJAL2_S_BIT   BIT(2)
+#define MAX77675_STAT_TJAL2_S_SHIFT 2
+#define MAX77675_STAT_TJAL1_S_BIT   BIT(1)
+#define MAX77675_STAT_TJAL1_S_SHIFT 1
+#define MAX77675_STAT_STAT_EN_BIT   BIT(0)
+#define MAX77675_STAT_STAT_EN_SHIFT 0
+
+#define MAX77675_STAT_STAT_EN_BIT   BIT(0)
+#define MAX77675_STAT_STAT_EN_SHIFT 0
+
+/* ERCFLAG (0x05) bits and shifts */
+#define MAX77675_SFT_CRST_F_BIT     BIT(5)  /* Software Cold Reset Flag */
+#define MAX77675_SFT_CRST_F_SHIFT   5
+#define MAX77675_SFT_OFF_F_BIT      BIT(4)  /* Software Off Flag */
+#define MAX77675_SFT_OFF_F_SHIFT    4
+#define MAX77675_MRST_BIT           BIT(3)  /* Manual Reset Timer Flag */
+#define MAX77675_MRST_SHIFT         3
+#define MAX77675_UVLO_BIT           BIT(2)  /* Undervoltage Lockout Flag */
+#define MAX77675_UVLO_SHIFT         2
+#define MAX77675_OVLO_BIT           BIT(1)  /* Overvoltage Lockout Flag */
+#define MAX77675_OVLO_SHIFT         1
+#define MAX77675_TOVLD_BIT          BIT(0)  /* Thermal Overload Flag */
+#define MAX77675_TOVLD_SHIFT        0
+
+/* CID (0x06) bits and shifts */
+#define MAX77675_CID_MASK           GENMASK(4, 0)  /* Chip Identification Code mask */
+#define MAX77675_CID_SHIFT          0              /* Starts at bit 0 */
+
+/* CNFG_SBB_TOP_A (0x07) bits and shifts */
+#define MAX77675_STEP_SZ_SBB3_BIT   BIT(5)
+#define MAX77675_STEP_SZ_SBB3_SHIFT 5
+#define MAX77675_STEP_SZ_SBB2_BIT   BIT(4)
+#define MAX77675_STEP_SZ_SBB2_SHIFT 4
+#define MAX77675_STEP_SZ_SBB1_BIT   BIT(3)
+#define MAX77675_STEP_SZ_SBB1_SHIFT 3
+#define MAX77675_STEP_SZ_SBB0_BIT   BIT(2)
+#define MAX77675_STEP_SZ_SBB0_SHIFT 2
+#define MAX77675_DRV_SBB_MASK       GENMASK(1, 0)
+#define MAX77675_DRV_SBB_SHIFT      0
+
+/* CNFG_SBB0_A (0x08) bits and shifts */
+#define MAX77675_TV_SBB0_MASK       GENMASK(7, 0)
+#define MAX77675_TV_SBB0_SHIFT      0
+
+/* CNFG_SBB0_B (0x09) bits and shifts */
+#define MAX77675_ADE_SBB0_BIT       BIT(3)
+#define MAX77675_ADE_SBB0_SHIFT     3
+#define MAX77675_EN_SBB0_MASK       GENMASK(2, 0)
+#define MAX77675_EN_SBB0_SHIFT      0
+
+/* CNFG_SBB1_A (0x0A) bits and shifts */
+#define MAX77675_TV_SBB1_MASK       GENMASK(7, 0)
+#define MAX77675_TV_SBB1_SHIFT      0
+
+/* CNFG_SBB1_B (0x0B) bits and shifts */
+#define MAX77675_ADE_SBB1_BIT       BIT(3)
+#define MAX77675_ADE_SBB1_SHIFT     3
+#define MAX77675_EN_SBB1_MASK       GENMASK(2, 0)
+#define MAX77675_EN_SBB1_SHIFT      0
+
+/* CNFG_SBB2_A (0x0C) bits and shifts */
+#define MAX77675_TV_SBB2_MASK       GENMASK(7, 0)
+#define MAX77675_TV_SBB2_SHIFT      0
+
+/* CNFG_SBB2_B (0x0D) bits and shifts */
+#define MAX77675_ADE_SBB2_BIT       BIT(3)
+#define MAX77675_ADE_SBB2_SHIFT     3
+#define MAX77675_EN_SBB2_MASK       GENMASK(2, 0)
+#define MAX77675_EN_SBB2_SHIFT      0
+
+/* CNFG_SBB3_A (0x0E) bits and shifts */
+#define MAX77675_TV_SBB3_MASK       GENMASK(7, 0)
+#define MAX77675_TV_SBB3_SHIFT      0
+
+/* CNFG_SBB3_B (0x0F) bits and shifts */
+#define MAX77675_ADE_SBB3_BIT       BIT(3)
+#define MAX77675_ADE_SBB3_SHIFT     3
+#define MAX77675_EN_SBB3_MASK       GENMASK(2, 0)
+#define MAX77675_EN_SBB3_SHIFT      0
+
+#define MAX77675_EN_SBB_MASK        GENMASK(2, 0)
+
+/* CNFG_SBB_TOP_B (0x10) bits and shifts */
+#define MAX77675_DVS_SLEW_BIT       BIT(5)
+#define MAX77675_DVS_SLEW_SHIFT     5
+#define MAX77675_LAT_MODE_BIT       BIT(4)
+#define MAX77675_LAT_MODE_SHIFT     4
+#define MAX77675_SR_SBB3_BIT        BIT(3)
+#define MAX77675_SR_SBB3_SHIFT      3
+#define MAX77675_SR_SBB2_BIT        BIT(2)
+#define MAX77675_SR_SBB2_SHIFT      2
+#define MAX77675_SR_SBB1_BIT        BIT(1)
+#define MAX77675_SR_SBB1_SHIFT      1
+#define MAX77675_SR_SBB0_BIT        BIT(0)
+#define MAX77675_SR_SBB0_SHIFT      0
+
+#define MAX77675_MAX_REGISTER       0x10
+
+/* Common minimum voltage (in microvolts) */
+#define MAX77675_MIN_UV             500000     // 500 mV
+
+/* Voltage step configuration for 25mV mode */
+#define MAX77675_STEP_25MV          25000      // Step size: 25 mV
+#define MAX77675_MAX_UV_25MV        5500000    // Max voltage: 5.5 V
+#define MAX77675_NUM_LEVELS_25MV    201        // levels = (5500mV - 500mV) / 25mV + 1
+
+/* Voltage step configuration for 12.5mV mode */
+#define MAX77675_STEP_12_5MV        12500      // Step size: 12.5 mV
+#define MAX77675_MAX_UV_12_5MV      3687500    // Max voltage: 3.6875 V
+#define MAX77675_NUM_LEVELS_12_5MV  255        // levels = (3687.5mV - 500mV) / 12.5mV + 1
+
+#define MAX77675_ENABLE_OFF         0x04
+#define MAX77675_ENABLE_ON          0x06
+
+#define MAX77675_REGULATOR_AD_OFF   0x00
+#define MAX77675_REGULATOR_AD_ON    BIT(3)
+
+/* Regulator ID enumeration */
+enum max77675_regulator_id {
+	MAX77675_ID_SBB0 = 0,
+	MAX77675_ID_SBB1,
+	MAX77675_ID_SBB2,
+	MAX77675_ID_SBB3,
+	MAX77675_ID_NUM_MAX,
+};
+
+#endif /* __MAX77675_REG_H__ */
--
2.34.1


