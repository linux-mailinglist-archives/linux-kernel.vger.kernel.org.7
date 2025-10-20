Return-Path: <linux-kernel+bounces-861501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9959BF2E37
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1845034E081
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C5F2C3260;
	Mon, 20 Oct 2025 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="pvVWlff6"
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBD1C3C11;
	Mon, 20 Oct 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984071; cv=none; b=NhU/KGDDvhXmWp0LwsbUz3fSI6EjQEgOqF3y5G3xpyx0m6rW65qZq7ZkS4K6Ww72hytG8b0F1laivOvgqotHOflRgbcUvWVDKf5/LsF4xTNcG9MyF5imTuS/+2NgMXQ1QT3+6eaFLnzyuzdwW4yYcPRrF2llq+jYijpPNZ97t28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984071; c=relaxed/simple;
	bh=x8LmbRyZchnZUNyIaHjvmUmUQt2VnuP4Qr6fHL7PkxE=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nLRXVc2ju6S3Pyj5FWknOmKc5mn3PH/pYU2/3Swa0COwfPo/CI3h0QFgUbDSI6ZG70MbDpSEVJoprtAkA+XhWQXR78GbBjpTBmW4bvtg1wziuuorzA7pgNKMvPD4+QR7IRzqR26tVeKVMhsEEvQdesEfY8hJowZKZXIQ/Q+GJso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=pvVWlff6; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id C13608288084;
	Mon, 20 Oct 2025 13:14:28 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id RWmmGsTRhSKl; Mon, 20 Oct 2025 13:14:27 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id E94DB8288904;
	Mon, 20 Oct 2025 13:14:26 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com E94DB8288904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1760984067; bh=ak4S6mzD6FiiQJ+IrmIGE6TKCA8sZ3Kf6zRRnkRKdyw=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=pvVWlff64UX6Mo56Behcqq/HyafgPZbBtpdVeBUj7CEo90CWqRSvsHNpaFC6SkNul
	 33QUHVm3O0QmaIufAysl0BZhg/LyIj3bEaWl1hYMyucFfEtV4Ug1nuA1GL/1ic4L3P
	 9t6QNhdI82NEdNCrRXaUPHwj6QqIRa1ORrTYD748=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LNfe_VP59RVn; Mon, 20 Oct 2025 13:14:26 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id B2F8D8288084;
	Mon, 20 Oct 2025 13:14:26 -0500 (CDT)
Date: Mon, 20 Oct 2025 13:14:26 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lee Jones <lee@kernel.org>, 
	Georgy Yakovlev <Georgy.Yakovlev@sony.com>
Message-ID: <13657666.1802042.1760984066594.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <1587929609.1802041.1760983921227.JavaMail.zimbra@raptorengineeringinc.com>
References: <1787448596.1802034.1760983830792.JavaMail.zimbra@raptorengineeringinc.com> <1587929609.1802041.1760983921227.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v4 2/4] mfd: sony-cronos-smc: Add driver for Sony Cronos SMC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC141 (Linux)/8.5.0_GA_3042)
Thread-Topic: sony-cronos-smc: Add driver for Sony Cronos SMC
Thread-Index: 2sKQBCK/cFq8bcVeB0FycJRZCrk72uhu0OzSZMBtKSw=

The Sony Cronos Platform Controller is a multi-purpose platform controller
that provides both a watchdog timer and an LED controller for the Sony
Interactive Entertainment Cronos x86 server platform. As both functions
are provided by the same CPLD, a multi-function device is exposed as the
parent of both functions.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
---
 MAINTAINERS                     |   7 ++
 drivers/mfd/Kconfig             |  11 ++
 drivers/mfd/Makefile            |   2 +
 drivers/mfd/sony-cronos-smc.c   | 212 ++++++++++++++++++++++++++++++++
 include/linux/mfd/sony-cronos.h |  61 +++++++++
 5 files changed, 293 insertions(+)
 create mode 100644 drivers/mfd/sony-cronos-smc.c
 create mode 100644 include/linux/mfd/sony-cronos.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 545a4776795e..8570b12a3f66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23881,6 +23881,13 @@ S:	Maintained
 F:	drivers/ssb/
 F:	include/linux/ssb/
 
+SONY CRONOS SMC DRIVER
+M:	Georgy Yakovlev <Georgy.Yakovlev@sony.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/sony,cronos-smc.yaml
+F:	drivers/mfd/sony-cronos-smc.c
+F:	include/linux/mfd/sony-cronos.h
+
 SONY IMX208 SENSOR DRIVER
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6cec1858947b..1b08f5ae648d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2382,6 +2382,17 @@ config MFD_QCOM_PM8008
 	  under it in the device tree. Additional drivers must be enabled in
 	  order to use the functionality of the device.
 
+config MFD_SONY_CRONOS_SMC
+	tristate "Sony Cronos System Management Controller"
+	select MFD_CORE
+	select REGMAP_I2C
+	depends on I2C && OF
+	help
+      Support for the Sony Cronos system controller. Additional drivers must
+      be enabled in order to use the functionality of the device, including LED
+      control and the system watchdog. The controller itself is a custom design
+      tailored to the specific needs of the Sony Cronos hardware platform.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 865e9f12faff..99700f423fe7 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -300,6 +300,8 @@ obj-$(CONFIG_MFD_QNAP_MCU)	+= qnap-mcu.o
 obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o rsmu_core.o
 obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
 
+obj-$(CONFIG_MFD_SONY_CRONOS_SMC)	+= sony-cronos-smc.o
+
 obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
 
 obj-$(CONFIG_MFD_LOONGSON_SE)	+= loongson-se.o
diff --git a/drivers/mfd/sony-cronos-smc.c b/drivers/mfd/sony-cronos-smc.c
new file mode 100644
index 000000000000..9d9b5402f89b
--- /dev/null
+++ b/drivers/mfd/sony-cronos-smc.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Device driver for Sony Cronos SMCs
+ * Copyright (C) 2015-2017  Dialog Semiconductor
+ * Copyright (C) 2022-2025  Raptor Engineering, LLC
+ */
+
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/sony-cronos.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+static const struct mfd_cell cronos_smc_devs[] = {
+	{
+		.name = "cronos-watchdog",
+		.of_compatible = "sony,cronos-watchdog",
+	},
+	{
+		.name = "cronos-led",
+		.of_compatible = "sony,cronos-led",
+	},
+};
+
+static int sony_cronos_get_device_type(struct sony_cronos_smc *ddata)
+{
+	int device_id;
+	int byte_high;
+	int byte_low;
+	int ret;
+
+	ret = regmap_read(ddata->regmap, CRONOS_SMC_DEVICE_ID_HIGH_REG, &byte_high);
+	if (ret) {
+		dev_err(ddata->dev, "Cannot read ddata ID high byte.\n");
+		return -EIO;
+	}
+	ret = regmap_read(ddata->regmap, CRONOS_SMC_DEVICE_ID_LOW_REG, &byte_low);
+	if (ret) {
+		dev_err(ddata->dev, "Cannot read ddata ID low byte.\n");
+		return -EIO;
+	}
+
+	device_id = byte_high << 8;
+	device_id |= byte_low;
+
+	if (device_id != CRONOS_SMC_DEVICE_ID) {
+		dev_err(ddata->dev, "Unsupported device ID 0x%04x\n", device_id);
+		return -ENODEV;
+	}
+
+	return ret;
+}
+
+static bool cronos_smc_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CRONOS_SMC_BRIGHTNESS_RED_REG:
+	case CRONOS_SMC_BRIGHTNESS_GREEN_REG:
+	case CRONOS_SMC_BRIGHTNESS_BLUE_REG:
+	case CRONOS_LEDS_SMC_STATUS_REG:
+	case CRONOS_LEDS_SWITCH_STATUS_REG:
+	case CRONOS_LEDS_CCM1_STATUS_REG:
+	case CRONOS_LEDS_CCM2_STATUS_REG:
+	case CRONOS_LEDS_CCM3_STATUS_REG:
+	case CRONOS_LEDS_CCM4_STATUS_REG:
+	case CRONOS_LEDS_CCM_POWER_REG:
+
+	case CRONOS_WDT_CTL_REG:
+	case CRONOS_WDT_CLR_REG:
+
+	case CRONOS_SMC_UART_MUX_REG:
+	case CRONOS_SMC_SWITCH_BOOT_FLASH_SELECT_REG:
+	case CRONOS_SMC_SWITCH_RESET_CMD_REG:
+	case CRONOS_SMC_BMC_BOOT_FLASH_SELECT_REG:
+	case CRONOS_SMC_PAYLOAD_POWER_CTL_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cronos_smc_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CRONOS_SMC_REVISION_HIGH_REG:
+	case CRONOS_SMC_REVISION_LOW_REG:
+	case CRONOS_SMC_DEVICE_ID_HIGH_REG:
+	case CRONOS_SMC_DEVICE_ID_LOW_REG:
+
+	case CRONOS_SMC_BRIGHTNESS_RED_REG:
+	case CRONOS_SMC_BRIGHTNESS_GREEN_REG:
+	case CRONOS_SMC_BRIGHTNESS_BLUE_REG:
+	case CRONOS_LEDS_SMC_STATUS_REG:
+	case CRONOS_LEDS_SWITCH_STATUS_REG:
+	case CRONOS_LEDS_CCM1_STATUS_REG:
+	case CRONOS_LEDS_CCM2_STATUS_REG:
+	case CRONOS_LEDS_CCM3_STATUS_REG:
+	case CRONOS_LEDS_CCM4_STATUS_REG:
+	case CRONOS_LEDS_CCM_POWER_REG:
+
+	case CRONOS_WDT_CTL_REG:
+	case CRONOS_WDT_CLR_REG:
+
+	case CRONOS_SMC_STATUS_2_REG:
+	case CRONOS_SMC_UART_MUX_REG:
+	case CRONOS_SMC_SWITCH_BOOT_FLASH_SELECT_REG:
+	case CRONOS_SMC_SWITCH_RESET_CMD_REG:
+	case CRONOS_SMC_BMC_BOOT_FLASH_SELECT_REG:
+	case CRONOS_SMC_PAYLOAD_POWER_CTL_REG:
+
+	case CRONOS_SMC_BMC_MAC_LOW_REG ... CRONOS_SMC_BMC_MAC_HIGH_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cronos_smc_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CRONOS_SMC_REVISION_HIGH_REG:
+	case CRONOS_SMC_REVISION_LOW_REG:
+
+	case CRONOS_SMC_SWITCH_BOOT_FLASH_SELECT_REG:
+	case CRONOS_SMC_SWITCH_RESET_CMD_REG:
+	case CRONOS_SMC_BMC_BOOT_FLASH_SELECT_REG:
+	case CRONOS_SMC_PAYLOAD_POWER_CTL_REG:
+
+	case CRONOS_WDT_CTL_REG:
+	case CRONOS_WDT_CLR_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static struct regmap_config cronos_smc_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = CRONOS_SMC_REVISION_HIGH_REG,
+	.writeable_reg = cronos_smc_is_writeable_reg,
+	.readable_reg = cronos_smc_is_readable_reg,
+	.volatile_reg = cronos_smc_is_volatile_reg,
+	.use_single_read = true,
+	.use_single_write = true,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static const struct of_device_id cronos_smc_dt_ids[] = {
+	{
+		.compatible = "sony,cronos-smc",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, cronos_smc_dt_ids);
+
+static int sony_cronos_i2c_probe(struct i2c_client *i2c)
+{
+	struct sony_cronos_smc *ddata;
+	int ret;
+
+	ddata = devm_kzalloc(&i2c->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, ddata);
+	ddata->dev = &i2c->dev;
+
+	ddata->regmap = devm_regmap_init_i2c(i2c, &cronos_smc_regmap_config);
+	if (IS_ERR(ddata->regmap)) {
+		return dev_err_probe(ddata->dev, PTR_ERR(ddata->regmap),
+				     "Failed to allocate register map\n");
+	}
+
+	ret = sony_cronos_get_device_type(ddata);
+	if (ret)
+		return ret;
+
+	ret = mfd_add_devices(ddata->dev, PLATFORM_DEVID_AUTO, cronos_smc_devs,
+			      ARRAY_SIZE(cronos_smc_devs), NULL, 0, NULL);
+	if (ret) {
+		dev_err(ddata->dev, "Failed to register child devices\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static void sony_cronos_i2c_remove(struct i2c_client *i2c)
+{
+	struct sony_cronos_smc *ddata = i2c_get_clientdata(i2c);
+
+	mfd_remove_devices(ddata->dev);
+}
+
+static struct i2c_driver sony_cronos_i2c_driver = {
+	.driver = {
+		.name = "sony-cronos-smc",
+		.of_match_table = of_match_ptr(cronos_smc_dt_ids),
+	},
+	.probe = sony_cronos_i2c_probe,
+	.remove = sony_cronos_i2c_remove,
+};
+module_i2c_driver(sony_cronos_i2c_driver);
+
+MODULE_DESCRIPTION("Device driver for the Sony Cronos system management controller");
+MODULE_AUTHOR("Raptor Engineering, LLC <tpearson@raptorengineering.com>");
+MODULE_LICENSE("GPL");
\ No newline at end of file
diff --git a/include/linux/mfd/sony-cronos.h b/include/linux/mfd/sony-cronos.h
new file mode 100644
index 000000000000..d82e46176bf7
--- /dev/null
+++ b/include/linux/mfd/sony-cronos.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2015-2017  Dialog Semiconductor
+ * Copyright (C) 2022  Raptor Engineering, LLC
+ */
+
+#ifndef __MFD_SONY_CRONOS_H__
+#define __MFD_SONY_CRONOS_H__
+
+#define CRONOS_SMC_DEVICE_ID				0x0134
+
+#define CRONOS_SMC_SWITCH_BOOT_FLASH_SELECT_REG		0x00
+#define CRONOS_SMC_SWITCH_RESET_CMD_REG			0x01
+#define CRONOS_SMC_BMC_BOOT_FLASH_SELECT_REG		0x02
+#define CRONOS_BMC_RESET_REG				0x03
+#define CRONOS_WDT_CLR_REG				0x03
+#define CRONOS_SMC_STATUS_2_REG				0x05
+#define CRONOS_SMC_PAYLOAD_POWER_CTL_REG		0x0a
+#define CRONOS_WDT_CTL_REG				0x0c
+#define CRONOS_SMC_UART_MUX_REG				0x0e
+
+#define CRONOS_SMC_BRIGHTNESS_RED_REG			0x17
+#define CRONOS_SMC_BRIGHTNESS_GREEN_REG			0x18
+#define CRONOS_SMC_BRIGHTNESS_BLUE_REG			0x19
+
+#define CRONOS_LEDS_SMC_STATUS_REG			0x10
+#define CRONOS_LEDS_SWITCH_STATUS_REG			0x11
+
+#define CRONOS_LEDS_CCM3_STATUS_REG			0x12
+#define CRONOS_LEDS_CCM2_STATUS_REG			0x13
+#define CRONOS_LEDS_CCM4_STATUS_REG			0x14
+#define CRONOS_LEDS_CCM1_STATUS_REG			0x15
+
+#define CRONOS_LEDS_CCM_POWER_REG			0x16
+
+#define CRONOS_SMC_BMC_MAC_LOW_REG			0x30
+#define CRONOS_SMC_BMC_MAC_HIGH_REG			0x35
+
+#define CRONOS_SMC_DEVICE_ID_LOW_REG			0x70
+#define CRONOS_SMC_DEVICE_ID_HIGH_REG			0x71
+#define CRONOS_SMC_REVISION_LOW_REG			0x72
+#define CRONOS_SMC_REVISION_HIGH_REG			0x73
+
+#define CRONOS_SMC_LEDS_BRIGHTNESS_SET_MASK		0x7F
+#define CRONOS_LEDS_MAX_BRIGHTNESS			0x7F
+
+#define CRONOS_BMC_RESET_VAL				0xc2
+
+#define CRONOS_WDT_CLR_VAL				0xc3
+#define CRONOS_WDT_ENABLE_MASK				0x80
+#define CRONOS_WDT_ENABLE_VAL				0x80
+#define CRONOS_WDT_DISABLE_VAL				0x00
+#define CRONOS_WDT_TIMEOUT_MASK				0x07
+#define CRONOS_WDT_CTL_RESET_VAL			0x00
+
+struct sony_cronos_smc {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+#endif /* __MFD_SONY_CRONOS_H__ */
-- 
2.39.5

