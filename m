Return-Path: <linux-kernel+bounces-833623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21F8BA2765
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1B456153A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30D5278161;
	Fri, 26 Sep 2025 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBPooTgQ"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2FD2773E6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758865173; cv=none; b=Gik/mEXlpHFODGjmOPz547VkUJ1H4FgegxPPQ4//Q2aOVA2GSvSNh+vCMoDODAnrRgXWVZKqXRnl05FqiRT5tF+IH2+DJwDnUnZ+/6OSu87ImBJ//49bF4l++aJ1y0Fvsme9q9Wbw9KTf7/v+d9++QJ9t0YbHzQEFH5klUQlEBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758865173; c=relaxed/simple;
	bh=xmvhpg6ZPh2oNxBwB45tq3NwOUn+kc7I0ki74JCH8lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GuwEJhF1zHSbKDbdcWLRQr0iy/wCWQPbFkHKxFSGvuJEbBnPtddQUPZBj6wnIqUFNwt0TJEPXBtbcX9xMNQQnaV9sRD1Kjv4PX5pj25/IgG4Va8LmHvWwms/7M8qfwm6NWHe7+/W5jcbxBWZFG71CtjZNFANhvE31thWeukMLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBPooTgQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b553412a19bso1382453a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758865170; x=1759469970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mhfl3Ez0OnLPsKQ9uWdFHsWcvE565s25cm3b4g58hK8=;
        b=bBPooTgQOt6XTvnuOj4sUiq6OOJxxDOphem4FXIjLD/IKPgF80apf/fkvPQb+4LTP6
         HR6bsczhHMyI5tQAwmC4VJrPdz14LJKZIu9sM9aQyFQQ2SvS3mWywqM+cWRi/LRISWbn
         s5GovGE7bqoeMVn6v9MpMFNlu+Xh5KjNEvBB2dSk6ug41Tb40JX0maw9m7Dc+n/po87c
         BsBdwc/jfe4OvBIEzm5V23PCue1PYDxZo04nC59ZL88MYoP45zj5JwE4KlWvEtCFbA6N
         W3GgP5L8QjYMzE81PiaSLb2BqiYcPwzEpQb0UlFEaKOZqV0walECOW7nzAoCEWSls1P7
         s70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758865170; x=1759469970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mhfl3Ez0OnLPsKQ9uWdFHsWcvE565s25cm3b4g58hK8=;
        b=t7urMlg3bwi/c8qE/tAM6or61ympzRNdndpwq03nudL1ffvwMjIlngpraOOzdEB7ci
         xe0uyVrg1cHQLlqVswYxItrQ6yJyHXFmtXcXIEGxgy/BVtB9O9/HErcmgZE1nJuCuSEO
         KjTF6kSb4GzOw/SF+/U7Z9MfhOVC/lGSboEOkQaEpAhhkMOdvQWLgudmGvXh2F4HpQkB
         LhhoSdwI9loGxXw9/YUyXEy+8Rv6Cmdd7k+QlBwN2MT6YB873grF4EcKwsR/zFTTtI3+
         1I7PcuWOjQWZw46X0+FgWV5MYLdpsHxPmVa9Tda14uqI+/T2fcYkal8WMAk/vQK+vGTc
         4c6w==
X-Forwarded-Encrypted: i=1; AJvYcCUbV6PyMx4xOpd9XpksAxkn1IQLfoCeWDBNkopJQ1hOnP3C3rzO+/Ziyo3C6pr+MaYid3KqktFOZFePwzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk3HZVI2FmdIBZaOEAjTsxdpP005/YgD8KUnYC+hiR/ci+J3Hg
	KD1f0Ob9rnGxQPwYddPWaLdfU9Xj5wlbBLCCfyHhfSYeeDE/BrvCi+Gu
X-Gm-Gg: ASbGnctOODaUVTM2R2bv8InZa5yyUx7rF4v7yIJm3JqbW0XiFH2cvK2GA+vUIbdf5+i
	iJGIXR+8ApDCOnhvVtAkQVUGlY60y+cOi/BohUiwUdfNi1DQSWK/xyHOpysptA6EQiNGJXliKR/
	TQcbvS6ICq98UYtASXSYJZ/oN/OsUPaI06fibOLGxrZc1Kpw3UkUoCM3lVNsjKeOCf+bYLN1Au0
	fQGGcdicmmyA3FdnQWQVkGH8lUGmnKZ+T0H41261ozcmGIChnExJvrO19Yf1peSdYfZf94QzhBE
	/xh9GU/DYsdf1Uh2NK2/35KuNPNglYt4CD771qUjYF1gHmQ8vgewTCZ+s8GIOE5BJwDnmuk2CcU
	FXDsictbK0JXWXVOuRh81c61Vk2k=
X-Google-Smtp-Source: AGHT+IG4ttH5rzyp/jjnAhmf/AMBzcJ4b7Cmm0oFNxT5sxspVAH1lVGGAvj+qqa3XhNKKVZk5DBw8w==
X-Received: by 2002:a17:903:1b28:b0:269:ba8b:8476 with SMTP id d9443c01a7336-27ed4aea2abmr62972965ad.56.1758865169647;
        Thu, 25 Sep 2025 22:39:29 -0700 (PDT)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66fb07dsm41925025ad.36.2025.09.25.22.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 22:39:29 -0700 (PDT)
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
Subject: [PATCH 2/3] regulator: max77675: Add MAX77675 regulator driver
Date: Fri, 26 Sep 2025 14:37:56 +0900
Message-Id: <20250926053757.480086-3-joan.na@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926053757.480086-1-joan.na@analog.com>
References: <20250926053757.480086-1-joan.na@analog.com>
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

Signed-off-by: Joan Na <joan.na@analog.com>
---
 drivers/regulator/Kconfig              |   9 +
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/max77675-regulator.c | 794 +++++++++++++++++++++++++
 drivers/regulator/max77675-regulator.h | 252 ++++++++
 4 files changed, 1056 insertions(+)
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
index 000000000000..1c9e8736e05e
--- /dev/null
+++ b/drivers/regulator/max77675-regulator.c
@@ -0,0 +1,794 @@
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
+	u8 fps_slot;
+	u8 dvs_slew_rate;
+};
+
+struct max77675_config {
+	u8 drv_slew_rate;
+	u8 latency_mode;
+	u8 drv_sbb_strength;
+	u8 manual_reset_time;
+	u8 en_pullup_disable;
+	u8 bias_low_power_request;
+	u8 simo_int_ldo_always_on;
+	u8 en_mode;
+	u8 en_debounce_time;
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
+ * max77675_set_sbb_slew_rate - Set the slew rate for a specific SBB regulator channel
+ *
+ * @maxreg: Pointer to the max77675 regulator structure
+ * @id: Regulator channel ID (ID_SBB0 ~ ID_SBB3)
+ * @val: Slew rate value (0 = 2mV/us, 1 = use DVS_SLEW)
+ *
+ * This function configures the slew rate control source for the specified SBB channel by
+ * updating the corresponding bits in the CNFG_SBB_TOP_B register.
+ *
+ * Return: 0 on success, negative error code on failure (e.g., invalid channel ID).
+ */
+static int max77675_set_sbb_slew_rate(struct max77675_regulator *maxreg, int id, u8 val)
+{
+	u8 mask, value;
+
+	switch (id) {
+	case MAX77675_ID_SBB0:
+		mask = MAX77675_SR_SBB0_BIT;
+		value = FIELD_PREP(MAX77675_SR_SBB0_BIT, val);
+		break;
+
+	case MAX77675_ID_SBB1:
+		mask = MAX77675_SR_SBB1_BIT;
+		value = FIELD_PREP(MAX77675_SR_SBB1_BIT, val);
+		break;
+
+	case MAX77675_ID_SBB2:
+		mask = MAX77675_SR_SBB2_BIT;
+		value = FIELD_PREP(MAX77675_SR_SBB2_BIT, val);
+		break;
+
+	case MAX77675_ID_SBB3:
+		mask = MAX77675_SR_SBB3_BIT;
+		value = FIELD_PREP(MAX77675_SR_SBB3_BIT, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(maxreg->regmap, MAX77675_REG_CNFG_SBB_TOP_B, mask, val);
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
+	}
+
+	ret = max77675_regulator_set_fps_src(maxreg, id, rpdata->fps_slot);
+	if (ret)
+		dev_warn(maxreg->dev, "Failed to set FPS source for ID %d\n", id);
+
+	ret = max77675_set_sbb_slew_rate(maxreg, id, rpdata->dvs_slew_rate);
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
+	ret = of_property_read_u32(np, "maxim,slew-rate-use-drv", &pval);
+	rpdata->dvs_slew_rate = (!ret) ? (u8)pval : 0;
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
+	.list_voltage         = regulator_list_voltage_linear,
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
+		.active_discharge_mask = MAX77675_REGULATOR_AD_MASK,
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
+		.active_discharge_mask = MAX77675_REGULATOR_AD_MASK,
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
+		.active_discharge_mask = MAX77675_REGULATOR_AD_MASK,
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
+		.active_discharge_mask = MAX77675_REGULATOR_AD_MASK,
+		.active_discharge_reg  = MAX77675_REG_CNFG_SBB3_B,
+	},
+};
+
+static const struct regmap_config max77675_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX77675_MAX_REGISTER,
+	.cache_type = REGCACHE_NONE,
+};
+
+static int max77675_apply_config(struct max77675_regulator *maxreg)
+{
+	const struct max77675_config *config = &maxreg->config;
+	int ret;
+
+	ret = max77675_set_dvs_slew_rate(maxreg, config->drv_slew_rate);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to set DVS slew rate: %d\n", ret);
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
+	ret = max77675_set_en_mode(maxreg, config->en_mode);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to set EN mode: %d\n", ret);
+		return ret;
+	}
+
+	ret = max77675_set_en_debounce_time(maxreg, config->en_debounce_time);
+	if (ret) {
+		dev_err(maxreg->dev, "Failed to set EN debounce time: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int max77675_parse_config(struct max77675_regulator *maxreg)
+{
+	struct device_node *np = maxreg->dev->of_node;
+	struct max77675_config *config = &maxreg->config;
+	int ret;
+	u32 val;
+
+	/* drv slew rate */
+	ret = of_property_read_u32(np, "maxim,dvs-slew-rate", &val);
+	if (ret < 0)
+		val = MAX77675_DVS_SLEW_5MV;
+	config->drv_slew_rate = val;
+
+	/* latency mode */
+	ret = of_property_read_u32(np, "maxim,latency-mode", &val);
+	if (ret < 0)
+		val = MAX77675_LAT_MODE_HIGH_LATENCY;
+	config->latency_mode = val;
+
+	/* drive strength */
+	ret = of_property_read_u32(np, "maxim,drv-sbb-strength", &val);
+	if (ret < 0)
+		val = MAX77675_DRV_SBB_FASTEST;
+	config->drv_sbb_strength = val;
+
+	/* Manual reset time for EN pin */
+	ret = of_property_read_u32(np, "maxim,manual-reset-time", &val);
+	if (ret < 0)
+		val = MAX77675_MRT_4S;
+	config->manual_reset_time = val;
+
+	/* Disable internal pull-up resistor on EN pin */
+	ret = of_property_read_u32(np, "maxim,en-pullup-disable", &val);
+	if (ret < 0)
+		val = MAX77675_PU_EN;
+	config->en_pullup_disable = val;
+
+	/* Request low-power mode for main bias */
+	ret = of_property_read_u32(np, "maxim,bias-low-power-request", &val);
+	if (ret < 0)
+		val = MAX77675_BIAS_NORMAL;
+	config->bias_low_power_request = val;
+
+	/* Force internal LDO to always supply 1.8V */
+	ret = of_property_read_u32(np, "maxim,simo-int-ldo-always-on", &val);
+	if (ret < MAX77675_SIMO_INT_NORMAL)
+		val = MAX77675_BIAS_NORMAL;
+	config->simo_int_ldo_always_on = val;
+
+	/* EN pin mode: push-button, slide-switch, or logic */
+	ret = of_property_read_u32(np, "maxim,en-mode", &val);
+	if (ret < 0)
+		val = MAX77675_EN_SLIDE_SWITCH;
+	config->en_mode = val;
+
+	/* Debounce time for EN pin */
+	ret = of_property_read_u32(np, "maxim,en-debounce-time", &val);
+	if (ret < 0)
+		val = MAX77675_DBEN_100US;
+	config->en_debounce_time = val;
+
+	/* Debug print all parsed values */
+	pr_info("MAX77675 config parsed:\n"
+		 "  dvs_slew_rate: %u\n"
+		 "  latency_mode: %u\n"
+		 "  drv_sbb_strength: %u\n"
+		 "  manual_reset_time: %u\n"
+		 "  en_pullup_disable: %u\n"
+		 "  bias_low_power_request: %u\n"
+		 "  simo_int_ldo_always_on: %u\n"
+		 "  en_mode: %u\n"
+		 "  en_debounce_time: %u\n",
+		 config->drv_slew_rate,
+		 config->latency_mode,
+		 config->drv_sbb_strength,
+		 config->manual_reset_time,
+		 config->en_pullup_disable,
+		 config->bias_low_power_request,
+		 config->simo_int_ldo_always_on,
+		 config->en_mode,
+		 config->en_debounce_time);
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
+	struct max77675_regulator *maxreg = i2c_get_clientdata(client);
+
+	dev_info(maxreg->dev, "MAX77675 regulators removed\n");
+}
+
+static const struct i2c_device_id max77675_i2c_id[] = {
+	{ "max77675", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max77675_i2c_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id max77675_of_match[] = {
+	{ .compatible = "maxim,max77675", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77675_of_match);
+#endif
+
+static struct i2c_driver max77675_regulator_driver = {
+	.driver = {
+		.name = "max77675",
+		.of_match_table = max77675_of_match,
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
index 000000000000..087956ba7834
--- /dev/null
+++ b/drivers/regulator/max77675-regulator.h
@@ -0,0 +1,252 @@
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
+#define MAX77675_ENABLE_MASK        0x07
+#define MAX77675_ENABLE_OFF         0x04
+#define MAX77675_ENABLE_ON          0x06
+
+#define MAX77675_REGULATOR_AD_MASK  BIT(3)
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
+struct max77675_irq_status {
+	bool sbb3_fault;
+	bool sbb2_fault;
+	bool sbb1_fault;
+	bool sbb0_fault;
+	bool tjal2_rising;
+	bool tjal1_rising;
+	bool nen_rising;
+	bool nen_falling;
+};
+
+struct max77675_status {
+	bool sbb3_overload;
+	bool sbb2_overload;
+	bool sbb1_overload;
+	bool sbb0_overload;
+	bool tjal2_status;
+	bool tjal1_status;
+	bool nen_status;
+};
+
+struct max77675_ercf_status {
+	bool sft_crst_f;
+	bool sft_off_f;
+	bool mrst;
+	bool uvlo;
+	bool ovlo;
+	bool tovld;
+};
+
+#endif /* __MAX77675_REG_H__ */
--
2.34.1


