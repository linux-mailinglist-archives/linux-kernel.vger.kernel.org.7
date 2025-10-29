Return-Path: <linux-kernel+bounces-875041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D4EC18110
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B7B1AA2060
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C5B2EBBB7;
	Wed, 29 Oct 2025 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c36vcHJ4"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC42EBB8D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705208; cv=none; b=OTSD6jiWoy2lSkrrrWhPVKHeYBYAyRpQzsOXY5a0bm/TUesuwWfDat4P1vZN+3/zSszRxUNR+TATPQU4D+lBnqCzba2Igy9qG+X+9er4g0yiYl6SHmGSWAkm92CUVteQXv702sAEIWPyrgYVs8AdrWkQNJr3pUoZrIKWBHYtjPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705208; c=relaxed/simple;
	bh=Oow8Ag7vguZNXxe8lqwfjZzi97Ch2SfWu3SsjvifdmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbTs2xaBMaCnaf3SOPTtS/fxqyq0b8AjZQhRvYzfvKCeZ1ntD0FL7zvE/z+K/A2TQgZ8QGrLaplCZo9gRSakwFG0UGb+Zx6nyZW1OENJ/Jm4bWwEEWkZ4UpypKXSqA9jF8GmMNOM5sa22fJMfi5dchygUsqOSqKqCukSYxLVlWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c36vcHJ4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so4087663a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761705205; x=1762310005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCKCXr08PD4cDopp/Mxm2Ji9B2eL21Zy/xW+Qa1BAeA=;
        b=c36vcHJ4m+FmX737Tc0/FtMWsYYoBXUCF2da05UhShRdkyPMbSapmLeC7FF4W+4d/i
         VaVeCpSzCZRg9YmM8UJ1bJotEbXxAxmU7wrPa0K9bHMaMKNNZFeN9aIqkyP58iUQvLGK
         Pzm0sWPMOLhXurFH0fNw3T8JimQStipisr6Lgc5/o8Oopp51lzaHgW1ZVTcLdsq0FiNH
         bigTGKkrElzCcPg4D0VpG3EnGaiZtXS5CtInqqq3FiSAN7jhNiX8/fzGgPilAT0aBMUl
         /1Lr8XaXPXjw+h/NVqs/I1P9YU0w76IM1wfMzLQccV4/KE4cDcOYPYV3fvUMOkz51T89
         6BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705205; x=1762310005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCKCXr08PD4cDopp/Mxm2Ji9B2eL21Zy/xW+Qa1BAeA=;
        b=snLZ7AICPo+sVc8ahkPZxDzg9iW7W8MbnP3HTJqDz7iRqP+mxMOsZKEfp5HYAUz/MV
         FzIWErWif/PwmDQv3xJSgNIy2WemV6kp7edd6jhuvBV/JDSjp9NN+GJgYgd7RF9oaODL
         LOG6JrY2cjD5qc830+03iNcvDnilmUZ5Q4BvHHfka7qqk7uehFRp+sFhfuMLqJECCUFy
         HYNKmfGdeBBkBQCx6IssSxinNFqajIPvtz7+oekRekzeMOq3gcZiQr8wA5cOE+t6KJe+
         oCmrn3kOcw65UBQw7rHqnzq9FXYnqtAJ+dieqGd0Jq189FEpT72kQtSM55mlQ5hnfXM7
         CkuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVwDK+YvmvwNxuFa1m+XWPLMcyLKlSW6hlUzND5eB48mmSUILhUUYmO+s50LAPjsWMT2cukCnQaZGnMhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsAlYSQXrT337TPq5XU348p0mL5IDm8p7nTKDxmrZ/vGEcIRF6
	likG6wgqOX1beXJhTSoa0w6diITmCB6/jeUtPBI7L9hgdwWnHy4kKDzn
X-Gm-Gg: ASbGncvRTn2JlPXASmdnSd6/DL3Fad17AJx+0iZ+kD4uMkBLwQ47i0jrZdZloHaTGmM
	2n0jhUlCnIPacgXQ7559qpdb2pZDjRiSV3zuMmlNupluNtmMAOfqLAoEvjhRXccNkFlYE9YEQFG
	emot+gkey1mT4b0Fqevsmqc2qTB7GYHcXWK4hVtZ/GbXalH/2vn88WqsCWNd76Vl9MziPjzWYA0
	dKXQLzUmv1YhuGOsA2QFQTtPNYr6wwuAyF//i000bA/7LjLOhjtNVeQF7ln635uusjSrRyF7isB
	sWGggecNaauAjb+2sjR/0PAv44IRCX4b0Vub324dEhLVo0LisTmLsjbkhu9Pq9SqZkZypA6KRQ4
	Axp+aJgyeUQlESGdfV5qiMf7/g9ZnAk9lX/QPTJJ0Evhz77IPBJbeNuu35y7ljPb2WTqPHNCNLm
	tWQZY476gVOuf3j+jd/nAdMmGjU9Cs/g==
X-Google-Smtp-Source: AGHT+IGXlW567gCNF0gwuqpbZixblKrwSQBahIqSQ1SHM2XS5dKZj8Gs7mVB7pSzN88xFdtv6atuVA==
X-Received: by 2002:a17:903:230b:b0:235:e8da:8d1 with SMTP id d9443c01a7336-294dedfc92bmr12144555ad.8.1761705205015;
        Tue, 28 Oct 2025 19:33:25 -0700 (PDT)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127bf47a1sm11826966a12.10.2025.10.28.19.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:33:24 -0700 (PDT)
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
Subject: [PATCH v5 2/2] regulator: max77675: Add MAX77675 regulator driver
Date: Wed, 29 Oct 2025 11:32:53 +0900
Message-Id: <20251029023253.150257-3-joan.na@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029023253.150257-1-joan.na@analog.com>
References: <20251029023253.150257-1-joan.na@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joan Na <joan.na@analog.com>

Add support for the Maxim Integrated MAX77675 PMIC regulator.

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
 drivers/regulator/max77675-regulator.c | 861 +++++++++++++++++++++++++
 drivers/regulator/max77675-regulator.h | 260 ++++++++
 4 files changed, 1131 insertions(+)
 create mode 100644 drivers/regulator/max77675-regulator.c
 create mode 100644 drivers/regulator/max77675-regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index d84f3d054c59..93131446e402 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -649,6 +649,15 @@ config REGULATOR_MAX77650
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
index b3101376029d..cdd99669cd24 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_REGULATOR_MAX77503) += max77503-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77541) += max77541-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77650) += max77650-regulator.o
+obj-$(CONFIG_REGULATOR_MAX77675) += max77675-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8649)	+= max8649.o
 obj-$(CONFIG_REGULATOR_MAX8660) += max8660.o
 obj-$(CONFIG_REGULATOR_MAX8893) += max8893.o
diff --git a/drivers/regulator/max77675-regulator.c b/drivers/regulator/max77675-regulator.c
new file mode 100644
index 000000000000..c1281f07fe43
--- /dev/null
+++ b/drivers/regulator/max77675-regulator.c
@@ -0,0 +1,861 @@
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
+	u8   voltage_change_latency;
+	u8   drv_sbb_strength;
+	u8   dvs_slew_rate;
+	u8   debounce_time;
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
+static int max77675_set_debounce_time(struct max77675_regulator *maxreg, bool debounce_30ms)
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
+	ret = max77675_set_latency_mode(maxreg, config->voltage_change_latency);
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
+	ret = max77675_set_debounce_time(maxreg, config->debounce_time);
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
+static u8 max77675_parse_voltage_change_latency(struct device_node *np)
+{
+	u32 val;
+
+	if (!of_property_read_u32(np, "maxim,voltage-change-latency-us", &val)) {
+		switch (val) {
+		case 10:
+			return MAX77675_LOW_LATENCY_MODE;
+		case 100:
+			return MAX77675_HIGH_LATENCY_MODE;
+		default:
+			break;
+		}
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
+	if (!of_property_read_u32(np, "reset-time-sec", &val)) {
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
+static u8 max77675_parse_debounce_time_us(struct device_node *np)
+{
+	u32 val;
+
+	if (!of_property_read_u32(np, "maxim,debounce-time-us", &val)) {
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
+	config->voltage_change_latency = max77675_parse_voltage_change_latency(np);
+
+	/* drive strength */
+	config->drv_sbb_strength = max77675_parse_drv_sbb_strength(np);
+
+	/* drv slew rate */
+	config->dvs_slew_rate = max77675_parse_dvs_slew_rate(np);
+
+	/* Debounce time for EN pin */
+	config->debounce_time = max77675_parse_debounce_time_us(np);
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
+
+		config.of_node = of_get_child_by_name(regulators_np, desc->name);
+		if (!config.of_node) {
+			dev_warn(maxreg->dev, "No DT node for regulator %s\n", desc->name);
+			continue;
+		}
+
+		rdev = devm_regulator_register(&client->dev, desc, &config);
+		of_node_put(config.of_node);
+		if (IS_ERR(rdev)) {
+			of_node_put(regulators_np);
+			return dev_err_probe(maxreg->dev, PTR_ERR(rdev),
+				"Failed to register regulator %d (%s): %d\n",
+				i, desc->name, ret);
+		}
+	}
+
+	of_node_put(regulators_np);
+	i2c_set_clientdata(client, maxreg);
+
+	return 0;
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
index 000000000000..0aaa30a630ca
--- /dev/null
+++ b/drivers/regulator/max77675-regulator.h
@@ -0,0 +1,260 @@
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
+/* FPS source */
+#define MAX77675_FPS_SLOT_0       0x0
+#define MAX77675_FPS_SLOT_1       0x1
+#define MAX77675_FPS_SLOT_2       0x2
+#define MAX77675_FPS_SLOT_3       0x3
+#define MAX77675_FPS_DEF          0x4
+
+/* nEN Manual Reset Time Configuration (MRT) */
+#define MAX77675_MRT_4S           0x0
+#define MAX77675_MRT_8S           0x1
+#define MAX77675_MRT_12S          0x2
+#define MAX77675_MRT_16S          0x3
+
+/* nEN Mode Configuration */
+#define MAX77675_EN_PUSH_BUTTON   0x0
+#define MAX77675_EN_SLIDE_SWITCH  0x1
+#define MAX77675_EN_LOGIC         0x2
+
+/* Debounce Timer Enable (DBEN_nEN) */
+#define MAX77675_DBEN_100US       0x0
+#define MAX77675_DBEN_30000US     0x1
+
+/* Rising slew rate control for SBB0 when ramping up */
+#define MAX77675_SR_2MV_PER_US    0x0  // 2 mV/us
+#define MAX77675_SR_USE_DVS       0x1  // Use DVS slew rate setting (maxim,dvs-slew-rate)
+
+/* Dynamic Voltage Scaling (DVS) Slew Rate */
+#define MAX77675_DVS_SLEW_5MV_PER_US    0x0  // 5 mV/us
+#define MAX77675_DVS_SLEW_10MV_PER_US   0x1  // 10 mV/us
+
+/* Latency Mode */
+#define MAX77675_HIGH_LATENCY_MODE  0x0   // High latency, low quiescent current (~100us)
+#define MAX77675_LOW_LATENCY_MODE   0x1   // Low latency, high quiescent current (~10us)
+
+/* SIMO Buck-Boost Drive Strength (All Channels) */
+#define MAX77675_DRV_SBB_STRENGTH_MAX  0x0  // Maximum drive strength (~0.6 ns transition time)
+#define MAX77675_DRV_SBB_STRENGTH_HIGH 0x1  // High drive strength (~1.2 ns transition time)
+#define MAX77675_DRV_SBB_STRENGTH_LOW  0x2  // Low drive strength (~1.8 ns transition time)
+#define MAX77675_DRV_SBB_STRENGTH_MIN  0x3  // Minimum drive strength (~8 ns transition time)
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


