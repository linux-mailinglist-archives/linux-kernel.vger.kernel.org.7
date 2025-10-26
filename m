Return-Path: <linux-kernel+bounces-870236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD9BC0A3F9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 07:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC44D4E87BE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 06:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A0F27AC59;
	Sun, 26 Oct 2025 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="hsjhHQPW"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D125B2FA
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761461466; cv=none; b=mnNqEj/KH1tShs4+TC3/zTMpnm3GirFmxB6XUdMp0Eqt9vQh4tdok/iFpLO/R+DbSx229DqmekKZQvyzcVF3c2ZSKdusyDjtor38amMwRkOOOmWukXmFO/gPZnl2WUbTFiGdpwESNkPqZ66p54asQydriLhbnjG9n+UEaGfcto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761461466; c=relaxed/simple;
	bh=zlOemitbqaznpy+czGFVs/Mr1akY8MN9pOL1wO81TNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Os6ulDK7MCDzaW9WJYxzCFFydKDoQDTqn6GDiIwSh9lCpKrJSK20meM6Xm3DS6nYsjJpHQzkwdOkV5uI7v8niFF6wq5v1nncpEe9n1L8Qm5wF9tMjoVc+TaaUT2w2JW4LfKyX41m4vhKY7/g2C+3N+xYHkD9k0VaJDOmjQPaCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=hsjhHQPW; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6cf07258e3so2630706a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1761461463; x=1762066263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caOGaySIbNPBFvZo31ZBy7wR96V18ME0q26vW6D4AZY=;
        b=hsjhHQPWADXo3RbVEm436iyIusdKsUvo2z472JWMavM7b84N2Ui83O2faIuCTXdeOZ
         SMinoJy7cCZ3DXCsNmA8Zu6ET4iQFiJ1HoYrH2UjVqtQ4OPtOEHCrI0M+JtyE24KX76p
         EZArxjKcBfFAzLoUTfHh17/Vz9Niw5JEWVlieP78QZAtUE23RFnZHCgwcxoL1vu8Z60M
         cksca+BEAZ2LeVjUHROOHVU94GxSopqHufGSzWNwglMOdY9nMLZ+nx1MsKcECpQOxBKj
         onT3u3jnHl2F4Z/y8fMM12mue7SImnJy78wf4eRlKnH2fUywc0FnrP2Zh3fqCghc5vy8
         2xFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761461463; x=1762066263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caOGaySIbNPBFvZo31ZBy7wR96V18ME0q26vW6D4AZY=;
        b=mi+bzeXsejdOIpqKLU5QsvjhZPPGPTLTzbC3bD+CtXLhDYbc+Gn7JQzh3In1QcLLq/
         SXzaeGGUhsK57lhnIwKtcSSbMAB6qXSbmuMX+nxzvlmTdRH5bHXdNZWUen26qro0pN1Y
         z9TKnssrFeyJHZNp7TZC+NaB9eg52jkEEmw3Mb50TsfQpffgxFcW8KytYvX5b6MNa8ZZ
         i4UnXGF+X7ZI18bC2pAJQaP8W2totPN00JfpFO8/PeE20+gfgBiUPiU8iJB9bqqdRNrX
         BMDIND2HGPHC6JmRXbfUetM7+9Q+ACZ2rxpD04TBl7PFiDzVXW+6htO2WoUs7q3if6xt
         9QLg==
X-Forwarded-Encrypted: i=1; AJvYcCU4RialtPonGnq4R/WZM+PUzIBF0PyZb59SU4q2+NOzrBUO9dCj5R6tn5GYoXQREzdTyTOpFopa1yt3a80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+hurFd+pwmb+x9yHJcDW1lRLac8nrTKM7H14xDYac4v094SOe
	+yUo1e/n7345WaePFPvGgutZ0TfHp/YY+xzzpsNM4wuzYKl5EbJDtoh1O0U2bpfJkNE=
X-Gm-Gg: ASbGncu08mo9LbbPiBullFp55/7PN3hId5jaSUn4Txi962+Nhxnw16n4r+ktWFfeaeb
	SVV0QMCTjsjGFBFbqD68uqZqbULWvNgMJ5PsxLwEfXLE+DQRH0iVVVuxn7lsf8tLk4rQcY0ypWg
	zAgVq/TJ4z4Ohc788bmvjIRYd8o1EKfdEZLhDLtlhUVAAQM6QRIl1++eHhP6oRHhe3NTsR0aHWg
	/E58ZK2HOOqTO1AaRiW7CNCVxapQeKQ2bB/b0t1UHjeOU3NolQropRqut87s+kDpPdFtrDfj8jc
	hg1HFvwufbuFNcW7rxm4o81cAI1ADMt65E7tCXdoaK2IlEspMWUmY1y/r40Aw9PEb1/kqjfpalp
	++WGSWLOtyfleqyZir47qo2wqgrrNzAF6i541reEFoL2Qz8lP12D93ysNpEtZQlHTauRqjVKUvP
	BW3VaUqRsKiFfxLDX6
X-Google-Smtp-Source: AGHT+IF2KdDPzBU5+euFEVI3Qe8zFyL2X8fEIzj3RQCzwcwZ04QVrg0hTOD/FSjCJ91cmQ0YNxJiwQ==
X-Received: by 2002:a17:902:f647:b0:279:daa1:676d with SMTP id d9443c01a7336-290c9c89cecmr311297835ad.8.1761461462572;
        Sat, 25 Oct 2025 23:51:02 -0700 (PDT)
Received: from z440.. ([2601:1c0:4502:2d00:640c:95e5:94c3:cc2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d4288asm43184905ad.84.2025.10.25.23.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 23:51:02 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: linux-hwmon@vger.kernel.org
Cc: conor+dt@kernel.org,
	corbet@lwn.net,
	david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 2/2] hwmon: Add TSC1641 I2C power monitor driver
Date: Sat, 25 Oct 2025 23:50:57 -0700
Message-ID: <20251026065057.627276-3-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026065057.627276-1-igor@reznichenko.net>
References: <20251022044708.314287-1-igor@reznichenko.net>
 <20251026065057.627276-1-igor@reznichenko.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the ST Microelectronics TSC1641 16-bit high-precision
power monitor. The driver supports reading bus voltage, current, power,
and temperature. Sysfs attributes are exposed for shunt resistor and
update interval. The driver integrates with the hwmon subsystem and
supports optional ALERT pin polarity configuration.

Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
---
 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/tsc1641.rst |  84 ++++
 drivers/hwmon/Kconfig           |  12 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/tsc1641.c         | 703 ++++++++++++++++++++++++++++++++
 5 files changed, 801 insertions(+)
 create mode 100644 Documentation/hwmon/tsc1641.rst
 create mode 100644 drivers/hwmon/tsc1641.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 51a5bdf75b08..4fb9f91f83b3 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -253,6 +253,7 @@ Hardware Monitoring Kernel Drivers
    tps40422
    tps53679
    tps546d24
+   tsc1641
    twl4030-madc-hwmon
    ucd9000
    ucd9200
diff --git a/Documentation/hwmon/tsc1641.rst b/Documentation/hwmon/tsc1641.rst
new file mode 100644
index 000000000000..f692a8ccbffc
--- /dev/null
+++ b/Documentation/hwmon/tsc1641.rst
@@ -0,0 +1,84 @@
+Kernel driver tsc1641
+=====================
+
+Supported chips:
+
+  * ST TSC1641
+
+    Prefix: 'tsc1641'
+
+    Addresses scanned: -
+
+    Datasheet:
+	https://www.st.com/resource/en/datasheet/tsc1641.pdf
+
+Author:
+	- Igor Reznichenko <igor@reznichenko.net>
+
+
+Description
+-----------
+
+The TSC1641 is a high-precision current, voltage, power, and temperature
+monitoring analog front-end (AFE). It monitors current into a shunt resistor and
+load voltage up to 60 V in a synchronized way. Digital bus interface is
+I2C/SMbus. The TSC1641 allows the assertion of several alerts regarding the
+voltage, current, power and temperature.
+
+Usage Notes
+-----------
+
+The TSC1641 driver requires the value of the external shunt resistor to
+correctly compute current and power measurements. The resistor value, in
+micro-ohms, should be provided either through the device tree property
+"shunt-resistor-micro-ohms" or via writable sysfs attribute "shunt_resistor".
+Please refer to the Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
+for bindings if the device tree is used.
+
+Supported range of shunt resistor values is from 100 uOhm to 655.35 mOhm.
+When selecting the value keep in mind device maximum DC power measurement is
+1600W. See datasheet p.22 for ST recommendations on selecting shunt value.
+
+If the shunt resistor value is not specified in the device tree, the driver
+initializes it to 1000 uOhm by default. Users may configure the correct shunt
+resistor value at runtime by writing to the "shunt_resistor" sysfs attribute.
+
+The driver only supports continuous operating mode.
+Measurement ranges:
+
+================ ===============================================================
+Current          Dependent on shunt
+Bus voltage      0-60V
+Maximum DC power 1600W
+Temperature      -40C to +125C
+================ ===============================================================
+
+Sysfs entries
+-------------
+
+==================== ===========================================================
+in0_input            bus voltage (mV)
+in0_crit             bus voltage crit alarm limit (mV)
+in0_crit_alarm       bus voltage crit alarm limit exceeded
+in0_lcrit            bus voltage low-crit alarm limit (mV)
+in0_lcrit_alarm      bus voltage low-crit alarm limit exceeded
+
+curr1_input          current measurement (mA)
+curr1_crit           current crit alarm limit (mA)
+curr1_crit_alarm     current crit alarm limit exceeded
+curr1_lcrit          current low-crit alarm limit (mA)
+curr1_lcrit_alarm    current low-crit alarm limit exceeded
+
+power1_input         power measurement (uW)
+power1_crit          power crit alarm limit (uW)
+power1_crit_alarm    power crit alarm limit exceeded
+
+shunt_resistor       shunt resistor value (uOhms)
+
+temp1_input          temperature measurement (mdegC)
+temp1_crit           temperature crit alarm limit (mdegC)
+temp1_crit_alarm     temperature crit alarm limit exceeded
+
+update_interval      data conversion time (1 - 33ms), longer conversion time
+                     corresponds to higher effective resolution in bits
+==================== ===========================================================
\ No newline at end of file
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2760feb9f83b..b9d7b02932a6 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2434,6 +2434,18 @@ config SENSORS_TMP513
 	  This driver can also be built as a module. If so, the module
 	  will be called tmp513.
 
+config SENSORS_TSC1641
+	tristate "ST Microelectronics TSC1641 Power Monitor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for TSC1641 power  monitor chip.
+	  The TSC1641 driver is configured for the default configuration of
+	  the part except temperature is enabled by default.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called tsc1641.
+
 config SENSORS_VEXPRESS
 	tristate "Versatile Express"
 	depends on VEXPRESS_CONFIG
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 73b2abdcc6dd..a8de5bc69f2a 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -233,6 +233,7 @@ obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
 obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
 obj-$(CONFIG_SENSORS_TMP464)	+= tmp464.o
 obj-$(CONFIG_SENSORS_TMP513)	+= tmp513.o
+obj-$(CONFIG_SENSORS_TSC1641)	+= tsc1641.o
 obj-$(CONFIG_SENSORS_VEXPRESS)	+= vexpress-hwmon.o
 obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
diff --git a/drivers/hwmon/tsc1641.c b/drivers/hwmon/tsc1641.c
new file mode 100644
index 000000000000..56f6d0ba2b49
--- /dev/null
+++ b/drivers/hwmon/tsc1641.c
@@ -0,0 +1,703 @@
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
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
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
+#define TSC1641_RSHUNT_DEFAULT	1000   /* 1mOhm */
+#define TSC1641_CONFIG_DEFAULT	0x003F /* Enable temperature sensor */
+#define TSC1641_MASK_DEFAULT	0xFC00 /* Unmask all alerts */
+
+/* Bit mask for conversion time in the configuration register */
+#define TSC1641_CONV_TIME_MASK	GENMASK(7, 4)
+
+#define TSC1641_CONV_TIME_DEFAULT	1024
+#define TSC1641_MIN_UPDATE_INTERVAL	1024
+
+/* LSB value of different registers */
+#define TSC1641_VLOAD_LSB_MVOLT		2
+#define TSC1641_POWER_LSB_UWATT		25000
+#define TSC1641_VSHUNT_LSB_NVOLT	2500 /* Use nanovolts to make it integer */
+#define TSC1641_RSHUNT_LSB_UOHM		10
+#define TSC1641_TEMP_LSB_MDEGC		500
+
+/* Limits based on datasheet */
+#define TSC1641_RSHUNT_MIN_UOHM		100
+#define TSC1641_RSHUNT_MAX_UOHM		655350
+#define TSC1641_VLOAD_MAX_MVOLT		60000
+#define TSC1641_CURRENT_MIN_MAMP	(-819175)
+#define TSC1641_CURRENT_MAX_MAMP	819175
+#define TSC1641_TEMP_MIN_MDEGC		(-20000)
+#define TSC1641_TEMP_MAX_MDEGC		145000
+#define TSC1641_POWER_MAX_UWATT		1600000000
+
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
+	long current_lsb_ua;
+	struct regmap *regmap;
+	struct i2c_client *client;
+};
+
+/*
+ * Upper limit due to chip 16-bit shunt register, lower limit to
+ * prevent current and power registers overflow
+ */
+static inline int tsc1641_validate_shunt(u32 val)
+{
+	if (val < TSC1641_RSHUNT_MIN_UOHM || val > TSC1641_RSHUNT_MAX_UOHM)
+		return -EINVAL;
+	return 0;
+}
+
+static int tsc1641_set_shunt(struct tsc1641_data *data, u32 val)
+{
+	struct regmap *regmap = data->regmap;
+	long rshunt_reg;
+
+	if (tsc1641_validate_shunt(val) < 0)
+		return -EINVAL;
+
+	data->rshunt_uohm = val;
+	data->current_lsb_ua = DIV_ROUND_CLOSEST(TSC1641_VSHUNT_LSB_NVOLT * 1000,
+						 data->rshunt_uohm);
+	/* RSHUNT register LSB is 10uOhm so need to divide further*/
+	rshunt_reg = DIV_ROUND_CLOSEST(data->rshunt_uohm, TSC1641_RSHUNT_LSB_UOHM);
+	return regmap_write(regmap, TSC1641_RSHUNT, clamp_val(rshunt_reg, 0, USHRT_MAX));
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
+				     ARRAY_SIZE(tsc1641_conv_times));
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
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
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
+	int ret, reg;
+
+	switch (attr) {
+	case hwmon_in_input:
+		reg = TSC1641_LOAD_VOLTAGE;
+		break;
+	case hwmon_in_lcrit:
+		reg = TSC1641_LUL;
+		break;
+	case hwmon_in_crit:
+		reg = TSC1641_LOL;
+		break;
+	case hwmon_in_lcrit_alarm:
+		return tsc1641_alert_read(regmap, TSC1641_LOAD_UV_FLAG, val);
+	case hwmon_in_crit_alarm:
+		return tsc1641_alert_read(regmap, TSC1641_LOAD_OV_FLAG, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = regmap_read(regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	*val = regval * TSC1641_VLOAD_LSB_MVOLT;
+	return 0;
+}
+
+static int tsc1641_curr_read(struct device *dev, u32 attr, long *val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	int regval;
+	int ret, reg;
+
+	/* Current limits are the shunt under/over voltage limits */
+	switch (attr) {
+	case hwmon_curr_input:
+		reg = TSC1641_CURRENT;
+		break;
+	case hwmon_curr_lcrit:
+		reg = TSC1641_SUL;
+		break;
+	case hwmon_curr_crit:
+		reg = TSC1641_SOL;
+		break;
+	case hwmon_curr_lcrit_alarm:
+		return tsc1641_alert_read(regmap, TSC1641_SHUNT_UV_FLAG, val);
+	case hwmon_curr_crit_alarm:
+		return tsc1641_alert_read(regmap, TSC1641_SHUNT_OV_FLAG, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = regmap_read(regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	/* Current in milliamps */
+	*val = DIV_ROUND_CLOSEST((s16)regval * data->current_lsb_ua, 1000);
+	return 0;
+}
+
+static int tsc1641_power_read(struct device *dev, u32 attr, long *val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	unsigned int regval;
+	int ret, reg;
+
+	switch (attr) {
+	case hwmon_power_input:
+		reg = TSC1641_POWER;
+		break;
+	case hwmon_power_crit:
+		reg = TSC1641_POL;
+		break;
+	case hwmon_power_crit_alarm:
+		return tsc1641_alert_read(regmap, TSC1641_POWER_OVER_FLAG, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = regmap_read(regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	*val = regval * TSC1641_POWER_LSB_UWATT;
+	return 0;
+}
+
+static int tsc1641_temp_read(struct device *dev, u32 attr, long *val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	unsigned int regval;
+	int ret, reg;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		reg = TSC1641_TEMP;
+		break;
+	case hwmon_temp_crit:
+		reg = TSC1641_TOL;
+		break;
+	case hwmon_temp_crit_alarm:
+		return tsc1641_alert_read(regmap, TSC1641_TEMP_OVER_FLAG, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = regmap_read(regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	*val = (s16)regval * TSC1641_TEMP_LSB_MDEGC;
+	return 0;
+}
+
+static int tsc1641_in_write(struct device *dev, u32 attr, long val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	unsigned int regval;
+	int reg;
+
+	switch (attr) {
+	case hwmon_in_lcrit:
+		reg = TSC1641_LUL;
+		break;
+	case hwmon_in_crit:
+		reg = TSC1641_LOL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	val = clamp_val(val, 0, TSC1641_VLOAD_MAX_MVOLT);
+	regval = DIV_ROUND_CLOSEST(val, TSC1641_VLOAD_LSB_MVOLT);
+
+	return regmap_write(regmap, reg, clamp_val(regval, 0, USHRT_MAX));
+}
+
+static int tsc1641_curr_write(struct device *dev, u32 attr, long val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	int reg, regval;
+
+	switch (attr) {
+	case hwmon_curr_lcrit:
+		reg = TSC1641_SUL;
+		break;
+	case hwmon_curr_crit:
+		reg = TSC1641_SOL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	/* Clamp to max 16-bit represantable current at min Rshunt */
+	val = clamp_val(val, TSC1641_CURRENT_MIN_MAMP, TSC1641_CURRENT_MAX_MAMP);
+	/* Convert val in milliamps to voltage */
+	regval = DIV_ROUND_CLOSEST(val * data->rshunt_uohm, TSC1641_VSHUNT_LSB_NVOLT);
+
+	return regmap_write(regmap, reg, clamp_val(regval, SHRT_MIN, SHRT_MAX));
+}
+
+static int tsc1641_power_write(struct device *dev, u32 attr, long val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	unsigned int regval;
+
+	switch (attr) {
+	case hwmon_power_crit:
+		val = clamp_val(val, 0, TSC1641_POWER_MAX_UWATT);
+		regval = DIV_ROUND_CLOSEST(val, TSC1641_POWER_LSB_UWATT);
+		return regmap_write(regmap, TSC1641_POL, clamp_val(regval, 0, USHRT_MAX));
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int tsc1641_temp_write(struct device *dev, u32 attr, long val)
+{
+	struct tsc1641_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	int regval;
+
+	switch (attr) {
+	case hwmon_temp_crit:
+		val = clamp_val(val, TSC1641_TEMP_MIN_MDEGC, TSC1641_TEMP_MAX_MDEGC);
+		regval = DIV_ROUND_CLOSEST(val, TSC1641_TEMP_LSB_MDEGC);
+		return regmap_write(regmap, TSC1641_TOL, clamp_val(regval, SHRT_MIN, SHRT_MAX));
+	default:
+		return -EOPNOTSUPP;
+	}
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
+	if (val > U32_MAX)
+		return -EINVAL;
+
+	ret = tsc1641_set_shunt(data, (u32)val);
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
+
+/* Shunt resistor value is exposed via sysfs attribute */
+static struct attribute *tsc1641_attrs[] = {
+	&dev_attr_shunt_resistor.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(tsc1641);
+
+static int tsc1641_init(struct device *dev, struct tsc1641_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	bool active_high;
+	u32 shunt;
+	int ret;
+
+	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms", &shunt) < 0)
+		shunt = TSC1641_RSHUNT_DEFAULT;
+
+	if (tsc1641_validate_shunt(shunt) < 0) {
+		dev_err(dev, "invalid shunt resistor value %u\n", shunt);
+		return -EINVAL;
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
+	active_high = device_property_read_bool(dev, "st,alert-polarity-active-high");
+
+	return regmap_write(regmap, TSC1641_MASK, TSC1641_MASK_DEFAULT |
+			    FIELD_PREP(TSC1641_ALERT_POL_MASK, active_high));
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
-- 
2.43.0


