Return-Path: <linux-kernel+bounces-880534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37175C2608B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01523B3AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B54286402;
	Fri, 31 Oct 2025 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e9ws2cEE"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA4F25B1D2;
	Fri, 31 Oct 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926404; cv=none; b=D7y4DWa2UmPCEvHEdWbIivEgsPpJuSv5BURyFxKeRQdlSz8sK+8Uq8+cpsIprnpc4i6n7Jz+7Zndv5Iud+bGW3EQ/0vwo68B9AZoLhv3XC8DL2nfUcR/8716uv1adsLKvHQNv8Zfd22hTD3UfpE3mVe85p6tGyfkI4W5PN6KM6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926404; c=relaxed/simple;
	bh=EOXoHT0rbZcBsMjkaOuWYnsLRXglJ5RByWqHVAd7Q60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHuxXwpHtN/6S8n+mSxantmQFuwR8ItvJlV34IkOQf2BGNeIYPdwZ5ltsB0krHnDYCGVqX6ikDZGVCIv+sgjnqABj+UoZz6+7XSZHqS4QK+oVLnDtZyBSQanl0BgKOQwHxbOT1beLYrtjUHqUo+y0qG0YzfFfH8LuSVWH2BTYZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e9ws2cEE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761926401; x=1793462401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EOXoHT0rbZcBsMjkaOuWYnsLRXglJ5RByWqHVAd7Q60=;
  b=e9ws2cEE10dhVJr2zAxxPnVvjeL98NQJX6lOShsT4Z1+q/ND86Vzu/y6
   IXKFlWtDGA8aELxR8S0oQ8alA8BfNw0OtweVigxQxrQnTszl+CHKV0JWa
   oYjYDzXjqNFWlcZJDji9feN5AkBx6vUW6uC+U4GlJf3CBDr2XEGwJZk1t
   XLwehOCT2nizALK5PsNAJjhBo2HhDeh81bAIT3+qzqWTljGmKaA6Vaaph
   VED/XtQSqOhIsNTCCVYfZUf7gYXxkYaqlHaoTCB0Xx8aan8kcBC1hnnb2
   s0l+91rKGkwsMYxG28FlgzI1xpd5N+XRlwzDc+Y8bf2pOSBaYrjO3A7M+
   w==;
X-CSE-ConnectionGUID: ayNLcR6iTHi9ENC+SNMWtg==
X-CSE-MsgGUID: CYLG5xG3QES+6wnXs3mjTQ==
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="54846318"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2025 08:59:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 31 Oct 2025 08:59:32 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 31 Oct 2025 08:59:30 -0700
From: <victor.duicu@microchip.com>
To: <linux@roeck-us.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <corbet@lwn.net>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v1 2/2] hwmon: add support for MCP998X
Date: Fri, 31 Oct 2025 17:58:31 +0200
Message-ID: <20251031155831.42763-3-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251031155831.42763-1-victor.duicu@microchip.com>
References: <20251031155831.42763-1-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Victor Duicu <victor.duicu@microchip.com>

This is the driver for Microchip MCP998X/33 and MCP998XD/33D
Multichannel Automotive Temperature Monitor Family.

Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---
 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/mcp9982.rst |  94 ++++
 MAINTAINERS                     |   2 +
 drivers/hwmon/Kconfig           |  10 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/mcp9982.c         | 756 ++++++++++++++++++++++++++++++++
 6 files changed, 864 insertions(+)
 create mode 100644 Documentation/hwmon/mcp9982.rst
 create mode 100644 drivers/hwmon/mcp9982.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 51a5bdf75b08..f052d80d752e 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -171,6 +171,7 @@ Hardware Monitoring Kernel Drivers
    mc33xs2410_hwmon
    mc34vr500
    mcp3021
+   mcp9982
    menf21bmc
    mlxreg-fan
    mp2856
diff --git a/Documentation/hwmon/mcp9982.rst b/Documentation/hwmon/mcp9982.rst
new file mode 100644
index 000000000000..58fa4fadf59e
--- /dev/null
+++ b/Documentation/hwmon/mcp9982.rst
@@ -0,0 +1,94 @@
+.. SPDX-License-Identifier: GPL-2.0+
+Kernel driver MCP998X
+=====================
+
+Supported chips:
+
+  * Microchip Technology MCP998X/MCP9933 MCP998XD/MCP9933D
+
+    Prefix: 'mcp9982'
+
+    Datasheet:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
+
+Authors:
+
+   - Victor Duicu <victor.duicu@microchip.com>
+
+Description
+-----------
+
+This driver implements support for the MCP998X family containing: MCP9982,
+MCP9982D, MCP9983, MCP9983D, MCP9984, MCP9984D, MCP9985, MCP9985D,
+MCP9933 and MCP9933D.
+
+The MCP998X Family is a high accuracy 2-wire multichannel automotive
+temperature monitor.
+
+The chips in the family have different numbers of external channels,
+ranging from 1 (MCP9982) to 4 channels (MCP9985). Reading diodes in
+anti-parallel connection is supported by MCP9984/85/33 and
+MCP9984D/85D/33D. Dedicated hardware shutdown circuitry is present
+only in MCP998XD and MCP9933D.
+
+Temperatures are read in millidegrees Celsius, ranging from -64 to
+191.875 with 0.125 precision.
+
+The chips measure temperatures with a variable conversion rate.
+Update_interval = Conversion/Second, so the available options are:
+
+- 16000 (ms) = 1 conv/16 sec
+- 8000 (ms) = 1 conv/8 sec
+- 4000 (ms) = 1 conv/4 sec
+- 2000 (ms) = 1 conv/2 sec
+- 1000 (ms) = 1 conv/sec
+- 500 (ms) = 2 conv/sec
+- 250 (ms) = 4 conv/sec
+- 125 (ms) = 8 conv/sec
+- 64 (ms) = 16 conv/sec
+- 32 (ms) = 32 conv/sec
+- 16 (ms) = 64 conv/sec
+
+Usage Notes
+-----------
+
+Parameters that can be configured in device tree:
+- anti-parallel diode mode operation
+- resistance error correction on channels 1 and 2
+- resistance error correction on channels 3 and 4
+Chips 82/83 and 82D/83D do not support anti-parallel diode mode.
+For chips with "D" in the name resistance error correction must be on.
+Please see Documentation/devicetree/bindings/hwmon/microchip,mcp9982.yaml
+for details.
+
+There are two power states:
+- Active state: in which the chip is converting on all channels at
+  the programmed rate.
+- Standby state: in which the host must initiate a conversion cycle.
+Chips with "D" in the name work in Active state and those without
+work in Standby state.
+
+Chips with "D" in the name can't set update interval slower than 1 second.
+
+Sysfs entries
+-------------
+
+The following attributes are supported. Update interval is read-write,
+the rest are read only.
+
+======================= ==================================================
+temp1_label		User name for internal channel.
+temp1_input		Measured temperature for internal channel.
+
+temp2_label		User name for external channel 1.
+temp2_input		Measured temperature for external channel 1.
+
+temp3_label		User name for external channel 2.
+temp3_input		Measured temperature for external channel 2.
+
+temp4_label		User name for external channel 3.
+temp4_input		Measured temperature for external channel 3.
+
+temp5_label		User name for external channel 4.
+temp5_input		Measured temperature for external channel 4.
+======================= ==================================================
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index 103e0b56f88e..30d52d8dd807 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16947,6 +16947,8 @@ M:	Victor Duicu <victor.duicu@microchip.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/hwmon/microchip,mcp9982.yaml
+F:	Documentation/hwmon/mcp9982.rst
+F:	drivers/hwmon/mcp9982.c
 
 MICROCHIP MMC/SD/SDIO MCI DRIVER
 M:	Aubin Constans <aubin.constans@microchip.com>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2760feb9f83b..d8e4603336b8 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1376,6 +1376,16 @@ config SENSORS_MCP3021
 	  This driver can also be built as a module. If so, the module
 	  will be called mcp3021.
 
+config SENSORS_MCP9982
+       tristate "Microchip Technology MCP9982 driver"
+       depends on I2C
+       help
+         Say yes here to include support for Microchip Technology's MCP998X/33
+         and MCP998XD/33D Multichannel Automotive Temperature Monitor Family.
+
+         This driver can also be built as a module. If so, the module
+         will be called mcp9982.
+
 config SENSORS_MLXREG_FAN
 	tristate "Mellanox FAN driver"
 	depends on MELLANOX_PLATFORM
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 73b2abdcc6dd..10614d9dc933 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -169,6 +169,7 @@ obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
 obj-$(CONFIG_SENSORS_MC33XS2410) += mc33xs2410_hwmon.o
 obj-$(CONFIG_SENSORS_MC34VR500)	+= mc34vr500.o
 obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
+obj-$(CONFIG_SENSORS_MCP9982)	+= mcp9982.o
 obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
 obj-$(CONFIG_SENSORS_TPS23861)	+= tps23861.o
 obj-$(CONFIG_SENSORS_MLXREG_FAN) += mlxreg-fan.o
diff --git a/drivers/hwmon/mcp9982.c b/drivers/hwmon/mcp9982.c
new file mode 100644
index 000000000000..b6750361f648
--- /dev/null
+++ b/drivers/hwmon/mcp9982.c
@@ -0,0 +1,756 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * HWMON driver for MCP998X/33 and MCP998XD/33D Multichannel Automotive
+ * Temperature Monitor Family
+ *
+ * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Victor Duicu <victor.duicu@microchip.com>
+ *
+ * Datasheet can be found here:
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device/devres.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/time64.h>
+#include <linux/unaligned.h>
+
+/* MCP9982 Registers */
+#define MCP9982_HIGH_BYTE_ADDR(index)		(2 * (index))
+#define MCP9982_ONE_SHOT_ADDR			0x0A
+#define MCP9982_INTERNAL_HIGH_LIMIT_ADDR	0x0B
+#define MCP9982_INTERNAL_LOW_LIMIT_ADDR		0x0C
+#define MCP9982_EXT1_HIGH_LIMIT_HIGH_BYTE_ADDR	0x0D
+#define MCP9982_EXT1_HIGH_LIMIT_LOW_BYTE_ADDR	0x0E
+#define MCP9982_EXT1_LOW_LIMIT_HIGH_BYTE_ADDR	0x0F
+#define MCP9982_EXT1_LOW_LIMIT_LOW_BYTE_ADDR	0x10
+#define MCP9982_INTERNAL_THERM_LIMIT_ADDR	0x1D
+#define MCP9982_EXT1_THERM_LIMIT_ADDR		0x1E
+#define MCP9982_CFG_ADDR			0x22
+#define MCP9982_CONV_ADDR			0x24
+#define MCP9982_HYS_ADDR			0x25
+#define MCP9982_CONSEC_ALRT_ADDR		0x26
+#define MCP9982_ALRT_CFG_ADDR			0x27
+#define MCP9982_RUNNING_AVG_ADDR		0x28
+#define MCP9982_HOTTEST_CFG_ADDR		0x29
+#define MCP9982_STATUS_ADDR			0x2A
+#define MCP9982_EXT_FAULT_STATUS_ADDR		0x2B
+#define MCP9982_HIGH_LIMIT_STATUS_ADDR		0x2C
+#define MCP9982_LOW_LIMIT_STATUS_ADDR		0x2D
+#define MCP9982_THERM_LIMIT_STATUS_ADDR		0x2E
+#define MCP9982_HOTTEST_HIGH_BYTE_ADDR		0x2F
+#define MCP9982_HOTTEST_LOW_BYTE_ADDR		0x30
+#define MCP9982_HOTTEST_STATUS_ADDR		0x31
+#define MCP9982_THERM_SHTDWN_CFG_ADDR		0x32
+#define MCP9982_HRDW_THERM_SHTDWN_LIMIT_ADDR	0x33
+#define MCP9982_EXT_BETA1_CFG_ADDR		0x34
+#define MCP9982_EXT_BETA2_CFG_ADDR		0x35
+#define MCP9982_EXT_IDEAL1_ADDR			0x36
+#define MCP9982_EXT_IDEAL2_ADDR			0x37
+#define MCP9982_EXT_IDEAL3_ADDR			0x38
+#define MCP9982_EXT_IDEAL4_ADDR			0x39
+/* 80h is the start address for temperature memory block */
+#define MCP9982_TEMP_MEM_BLOCK_ADDR(index)	(2 * (index) + 0x80)
+/* Addresses in the STATUS MEMORY BLOCK */
+#define MCP9982_STATUS_BLOCK_MEMORY		0x90
+#define MCP9982_STATUS_BLOCK_DIODE_FAULT	0x91
+#define MCP9982_STATUS_BLOCK_HIGH_LIMIT		0x92
+#define MCP9982_STATUS_BLOCK_LOW_LIMIT		0x93
+#define MCP9982_STATUS_BLOCK_THERM_LIMIT	0x94
+#define MCP9982_STATUS_BLOCK_HOTTEST_HIGH_BYTE	0x95
+#define MCP9982_STATUS_BLOCK_HOTTEST_LOW_BYTE	0x96
+#define MCP9982_STATUS_BLOCK_HOTTEST		0x97
+
+/* MCP9982 Bits */
+#define MCP9982_CFG_MSKAL			BIT(7)
+#define MCP9982_CFG_RS				BIT(6)
+#define MCP9982_CFG_ATTHM			BIT(5)
+#define MCP9982_CFG_RECD12			BIT(4)
+#define MCP9982_CFG_RECD34			BIT(3)
+#define MCP9982_CFG_RANGE			BIT(2)
+#define MCP9982_CFG_DA_ENA			BIT(1)
+#define MCP9982_CFG_APDD			BIT(0)
+
+#define MCP9982_STATUS_BUSY			BIT(5)
+
+/* The maximum number of channels a member of the family can have */
+#define MCP9982_MAX_NUM_CHANNELS		5
+#define MCP9982_BETA_AUTODETECT			16
+#define MCP9982_IDEALITY_DEFAULT		18
+#define MCP9982_OFFSET				64
+#define MCP9982_SCALE				256
+#define MCP9982_DEFAULT_CONSEC_ALRT_VAL		112
+#define MCP9982_DEFAULT_HYS_VAL			10
+#define MCP9982_DEFAULT_CONV_VAL		6
+#define MCP9982_WAKE_UP_TIME_MS			125
+#define MCP9982_CONVERSION_TIME_MS		125
+
+static const struct hwmon_channel_info * const mcp9985_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_UPDATE_INTERVAL),
+	NULL
+};
+
+/**
+ * struct mcp9982_features - features of a mcp9982 instance
+ * @name:			chip's name
+ * @phys_channels:		number of physical channels supported by the chip
+ * @hw_thermal_shutdown:	presence of hardware thermal shutdown circuitry
+ * @allow_apdd:			whether the chip supports enabling APDD
+ */
+struct mcp9982_features {
+	const char	*name;
+	u8		phys_channels;
+	bool		hw_thermal_shutdown;
+	bool		allow_apdd;
+};
+
+static const struct mcp9982_features mcp9933_chip_config = {
+	.name = "mcp9933",
+	.phys_channels = 3,
+	.hw_thermal_shutdown = false,
+	.allow_apdd = true,
+};
+
+static const struct mcp9982_features mcp9933d_chip_config = {
+	.name = "mcp9933d",
+	.phys_channels = 3,
+	.hw_thermal_shutdown = true,
+	.allow_apdd = true,
+};
+
+static const struct mcp9982_features mcp9982_chip_config = {
+	.name = "mcp9982",
+	.phys_channels = 2,
+	.hw_thermal_shutdown = false,
+	.allow_apdd = false,
+};
+
+static const struct mcp9982_features mcp9982d_chip_config = {
+	.name = "mcp9982d",
+	.phys_channels = 2,
+	.hw_thermal_shutdown = true,
+	.allow_apdd = false,
+};
+
+static const struct mcp9982_features mcp9983_chip_config = {
+	.name = "mcp9983",
+	.phys_channels = 3,
+	.hw_thermal_shutdown = false,
+	.allow_apdd = false,
+};
+
+static const struct mcp9982_features mcp9983d_chip_config = {
+	.name = "mcp9983d",
+	.phys_channels = 3,
+	.hw_thermal_shutdown = true,
+	.allow_apdd = false,
+};
+
+static const struct mcp9982_features mcp9984_chip_config = {
+	.name = "mcp9984",
+	.phys_channels = 4,
+	.hw_thermal_shutdown = false,
+	.allow_apdd = true,
+};
+
+static const struct mcp9982_features mcp9984d_chip_config = {
+	.name = "mcp9984d",
+	.phys_channels = 4,
+	.hw_thermal_shutdown = true,
+	.allow_apdd = true,
+};
+
+static const struct mcp9982_features mcp9985_chip_config = {
+	.name = "mcp9985",
+	.phys_channels = 5,
+	.hw_thermal_shutdown = false,
+	.allow_apdd = true,
+};
+
+static const struct mcp9982_features mcp9985d_chip_config = {
+	.name = "mcp9985d",
+	.phys_channels = 5,
+	.hw_thermal_shutdown = true,
+	.allow_apdd = true,
+};
+
+static const unsigned int mcp9982_update_interval[11] = {
+	16000,
+	8000,
+	4000,
+	2000,
+	1000,
+	500,
+	250,
+	125,
+	64,
+	32,
+	16,
+};
+
+/* MCP9982 regmap configuration */
+static const struct regmap_range mcp9982_regmap_wr_ranges[] = {
+	regmap_reg_range(MCP9982_ONE_SHOT_ADDR, MCP9982_EXT1_LOW_LIMIT_LOW_BYTE_ADDR),
+	regmap_reg_range(MCP9982_INTERNAL_THERM_LIMIT_ADDR, MCP9982_EXT1_THERM_LIMIT_ADDR),
+	regmap_reg_range(MCP9982_CFG_ADDR, MCP9982_CFG_ADDR),
+	regmap_reg_range(MCP9982_CONV_ADDR, MCP9982_HOTTEST_CFG_ADDR),
+	regmap_reg_range(MCP9982_THERM_SHTDWN_CFG_ADDR, MCP9982_THERM_SHTDWN_CFG_ADDR),
+	regmap_reg_range(MCP9982_EXT_BETA1_CFG_ADDR, MCP9982_EXT_IDEAL4_ADDR),
+};
+
+static const struct regmap_access_table mcp9982_regmap_wr_table = {
+	.yes_ranges = mcp9982_regmap_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp9982_regmap_wr_ranges),
+};
+
+static const struct regmap_range mcp9982_regmap_rd_ranges[] = {
+	regmap_reg_range(MCP9982_HIGH_BYTE_ADDR(0), MCP9982_EXT1_LOW_LIMIT_LOW_BYTE_ADDR),
+	regmap_reg_range(MCP9982_INTERNAL_THERM_LIMIT_ADDR, MCP9982_EXT1_THERM_LIMIT_ADDR),
+	regmap_reg_range(MCP9982_CFG_ADDR, MCP9982_CFG_ADDR),
+	regmap_reg_range(MCP9982_CONV_ADDR, MCP9982_EXT_IDEAL4_ADDR),
+	regmap_reg_range(MCP9982_TEMP_MEM_BLOCK_ADDR(0), MCP9982_STATUS_BLOCK_HOTTEST),
+};
+
+static const struct regmap_access_table mcp9982_regmap_rd_table = {
+	.yes_ranges = mcp9982_regmap_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp9982_regmap_rd_ranges),
+};
+
+static bool mcp9982_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MCP9982_ONE_SHOT_ADDR:
+	case MCP9982_INTERNAL_HIGH_LIMIT_ADDR:
+	case MCP9982_INTERNAL_LOW_LIMIT_ADDR:
+	case MCP9982_EXT1_HIGH_LIMIT_HIGH_BYTE_ADDR:
+	case MCP9982_EXT1_HIGH_LIMIT_LOW_BYTE_ADDR:
+	case MCP9982_EXT1_LOW_LIMIT_HIGH_BYTE_ADDR:
+	case MCP9982_EXT1_LOW_LIMIT_LOW_BYTE_ADDR:
+	case MCP9982_INTERNAL_THERM_LIMIT_ADDR:
+	case MCP9982_EXT1_THERM_LIMIT_ADDR:
+	case MCP9982_CFG_ADDR:
+	case MCP9982_CONV_ADDR:
+	case MCP9982_HYS_ADDR:
+	case MCP9982_CONSEC_ALRT_ADDR:
+	case MCP9982_ALRT_CFG_ADDR:
+	case MCP9982_RUNNING_AVG_ADDR:
+	case MCP9982_HOTTEST_CFG_ADDR:
+	case MCP9982_THERM_SHTDWN_CFG_ADDR:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static const struct regmap_config mcp9982_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &mcp9982_regmap_rd_table,
+	.wr_table = &mcp9982_regmap_wr_table,
+	.volatile_reg = mcp9982_is_volatile_reg,
+	.max_register = MCP9982_STATUS_BLOCK_HOTTEST,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+/**
+ * struct mcp9992_priv - information about chip parameters
+ * @regmap:			device register map
+ * @chip:			pointer to structure holding chip features
+ * @labels:			labels of the channels
+ * @sampl_idx:			index representing the current sampling frequency
+ * @time_limit:			time when it is safe to read
+ * @enabled_channel_mask:	mask containing which channels should be enabled
+ * @num_channels:		number of active physical channels
+ * @recd34_enable:		state of Resistance Error Correction(REC) on channels 3 and 4
+ * @recd12_enable:		state of Resistance Error Correction(REC) on channels 1 and 2
+ * @apdd_enable:		state of anti-parallel diode mode
+ * @run_state:			chip is in run state, otherwise is in standby state
+ * @wait_before_read:		whether we need to wait a delay before reading a new value
+ */
+struct mcp9982_priv {
+	struct regmap *regmap;
+	const struct mcp9982_features *chip;
+	const char *labels[MCP9982_MAX_NUM_CHANNELS];
+	unsigned int sampl_idx;
+	unsigned long  time_limit;
+	unsigned long enabled_channel_mask;
+	u8 num_channels;
+	bool recd34_enable;
+	bool recd12_enable;
+	bool apdd_enable;
+	bool run_state;
+	bool wait_before_read;
+};
+
+static int mcp9982_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	unsigned int reg_status;
+	struct mcp9982_priv *priv = dev_get_drvdata(dev);
+	int ret;
+	u8 bulk_read[3];
+
+	if (priv->run_state) {
+		/*
+		 * When working in Run mode, after modifying a parameter (like update
+		 * interval) we have to wait a delay before reading the new values.
+		 * We can't determine when the conversion is done based on the BUSY bit.
+		 */
+		if (priv->wait_before_read) {
+			if (!time_after(jiffies, priv->time_limit))
+				mdelay(jiffies_to_msecs(priv->time_limit - jiffies));
+			priv->wait_before_read = false;
+		}
+	} else {
+		ret = regmap_write(priv->regmap, MCP9982_ONE_SHOT_ADDR, 1);
+		if (ret)
+			return ret;
+		/*
+		 * In Standby state after writing in OneShot register wait for
+		 * the start of conversion and then poll the BUSY bit.
+		 */
+		mdelay(MCP9982_WAKE_UP_TIME_MS);
+		ret = regmap_read_poll_timeout(priv->regmap, MCP9982_STATUS_ADDR,
+					       reg_status, !(reg_status & MCP9982_STATUS_BUSY),
+					       (mcp9982_update_interval[priv->sampl_idx]) *
+					       USEC_PER_MSEC, 0);
+		if (ret)
+			return ret;
+	}
+
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			/*
+			 * The Block Read Protocol first returns the number of user readable
+			 * bytes, held in bulk_read[0], followed by the data.
+			 */
+			ret = regmap_bulk_read(priv->regmap, MCP9982_TEMP_MEM_BLOCK_ADDR(channel),
+					       &bulk_read, sizeof(bulk_read));
+
+			if (ret)
+				return ret;
+
+			*val = ((get_unaligned_be16(bulk_read + 1) >> 5) -
+			       (MCP9982_OFFSET << 3)) * 125;
+
+			return 0;
+		default:
+			return -EINVAL;
+		}
+
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_update_interval:
+			*val = mcp9982_update_interval[priv->sampl_idx];
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp9982_read_label(struct device *dev,
+			      enum hwmon_sensor_types type,
+			      u32 attr, int channel, const char **str)
+{
+	struct mcp9982_priv *priv = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_label:
+			if (priv->labels[channel]) {
+				*str = priv->labels[channel];
+				return 0;
+			} else {
+				return -EOPNOTSUPP;
+			}
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int mcp9982_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	unsigned int i, previous_sampl_idx;
+	struct mcp9982_priv *priv = dev_get_drvdata(dev);
+	unsigned long new_time_limit;
+	bool use_previous_freq = false;
+	int ret;
+
+	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_update_interval:
+			previous_sampl_idx = priv->sampl_idx;
+
+			/*
+			 * For MCP998XD and MCP9933D update interval
+			 * can't be slower than 1 second.
+			 */
+			i = priv->chip->hw_thermal_shutdown ? 4 : 0;
+			for (; i < ARRAY_SIZE(mcp9982_update_interval); i++)
+				if (val == mcp9982_update_interval[i])
+					break;
+
+			if (i == ARRAY_SIZE(mcp9982_update_interval))
+				return -EINVAL;
+
+			ret = regmap_write(priv->regmap, MCP9982_CONV_ADDR, i);
+			if (ret)
+				return ret;
+
+			priv->sampl_idx = i;
+
+			/*
+			 * When changing the frequency in Run mode, wait a delay based
+			 * on the previous value to ensure the new value becomes active.
+			 */
+			if (priv->run_state)
+				use_previous_freq = true;
+			else
+				return 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* update conversion delay in runmode */
+	if (use_previous_freq) {
+		new_time_limit = msecs_to_jiffies(mcp9982_update_interval[previous_sampl_idx]);
+		use_previous_freq = false;
+	} else {
+		new_time_limit = msecs_to_jiffies(mcp9982_update_interval[priv->sampl_idx]);
+	}
+
+	new_time_limit += jiffies + msecs_to_jiffies(MCP9982_CONVERSION_TIME_MS);
+
+	if (time_after(new_time_limit, priv->time_limit)) {
+		priv->time_limit = new_time_limit;
+		priv->wait_before_read = true;
+	}
+
+	return 0;
+}
+
+static umode_t mcp9982_is_visible(const void *_data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	const struct mcp9982_priv *priv = _data;
+
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_label:
+			if (priv->labels[channel])
+				return 0444;
+			else
+				return 0;
+		case hwmon_temp_input:
+			if (test_bit(channel, &priv->enabled_channel_mask))
+				return 0444;
+			else
+				return 0;
+		default:
+			return 0;
+		}
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_update_interval:
+			return 0644;
+		default:
+			return 0;
+		}
+	default:
+		return 0;
+	}
+}
+
+static const struct hwmon_ops mcp9982_hwmon_ops = {
+	.is_visible = mcp9982_is_visible,
+	.read = mcp9982_read,
+	.read_string = mcp9982_read_label,
+	.write = mcp9982_write,
+};
+
+static int mcp9982_init(struct device *dev, struct mcp9982_priv *priv)
+{
+	int ret;
+	u8 val;
+
+	/* Chips 82/83 and 82D/83D do not support anti-parallel diode mode. */
+	if (!priv->chip->allow_apdd && priv->apdd_enable == 1)
+		return dev_err_probe(dev, -EINVAL, "Incorrect setting of APDD.\n");
+
+	/* Chips with "D" work in Run state and those without work in Standby state. */
+	if (priv->chip->hw_thermal_shutdown)
+		priv->run_state = true;
+
+	/*
+	 * For chips with "D" in the name, resistance error correction must be on
+	 * so that hardware shutdown feature can't be overridden.
+	 */
+	if (priv->chip->hw_thermal_shutdown)
+		if (!priv->recd34_enable || !priv->recd12_enable)
+			return dev_err_probe(dev, -EINVAL, "Incorrect setting of RECD.\n");
+	/*
+	 * Set default values in registers.
+	 * APDD, RECD12 and RECD34 are active on 0.
+	 */
+	val = FIELD_PREP(MCP9982_CFG_MSKAL, 1) |
+	      FIELD_PREP(MCP9982_CFG_RS, !priv->run_state) |
+	      FIELD_PREP(MCP9982_CFG_ATTHM, 1) |
+	      FIELD_PREP(MCP9982_CFG_RECD12, !priv->recd12_enable) |
+	      FIELD_PREP(MCP9982_CFG_RECD34, !priv->recd34_enable) |
+	      FIELD_PREP(MCP9982_CFG_RANGE, 1) | FIELD_PREP(MCP9982_CFG_DA_ENA, 0) |
+	      FIELD_PREP(MCP9982_CFG_APDD, !priv->apdd_enable);
+
+	ret = regmap_write(priv->regmap, MCP9982_CFG_ADDR, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, MCP9982_CONV_ADDR, MCP9982_DEFAULT_CONV_VAL);
+	if (ret)
+		return ret;
+	priv->sampl_idx = MCP9982_DEFAULT_CONV_VAL;
+
+	ret = regmap_write(priv->regmap, MCP9982_HYS_ADDR, MCP9982_DEFAULT_HYS_VAL);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, MCP9982_CONSEC_ALRT_ADDR,
+			   MCP9982_DEFAULT_CONSEC_ALRT_VAL);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, MCP9982_RUNNING_AVG_ADDR, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, MCP9982_HOTTEST_CFG_ADDR, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Only external channels 1 and 2 support beta compensation.
+	 * Set beta auto-detection.
+	 */
+	ret = regmap_write(priv->regmap, MCP9982_EXT_BETA1_CFG_ADDR, MCP9982_BETA_AUTODETECT);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, MCP9982_EXT_BETA2_CFG_ADDR, MCP9982_BETA_AUTODETECT);
+	if (ret)
+		return ret;
+
+	/* Set ideality factor to default for all external channels. */
+	ret = regmap_write(priv->regmap, MCP9982_EXT_IDEAL1_ADDR, MCP9982_IDEALITY_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, MCP9982_EXT_IDEAL2_ADDR, MCP9982_IDEALITY_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, MCP9982_EXT_IDEAL3_ADDR, MCP9982_IDEALITY_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, MCP9982_EXT_IDEAL4_ADDR, MCP9982_IDEALITY_DEFAULT);
+	if (ret)
+		return ret;
+
+	priv->wait_before_read = false;
+	priv->time_limit = jiffies;
+
+	return 0;
+}
+
+static int mcp9982_parse_fw_config(struct device *dev, int device_nr_channels)
+{
+	unsigned int reg_nr;
+	struct mcp9982_priv *priv = dev_get_drvdata(dev);
+
+	/* For unit tests */
+	if (!dev_fwnode(dev)) {
+		priv->num_channels = device_nr_channels;
+		priv->enabled_channel_mask = BIT(priv->num_channels) - 1;
+		priv->apdd_enable = false;
+		priv->recd12_enable = true;
+		priv->recd34_enable = true;
+		return 0;
+	}
+
+	priv->apdd_enable =
+		device_property_read_bool(dev, "microchip,enable-anti-parallel");
+
+	priv->recd12_enable =
+		device_property_read_bool(dev, "microchip,parasitic-res-on-channel1-2");
+
+	priv->recd34_enable =
+		device_property_read_bool(dev, "microchip,parasitic-res-on-channel3-4");
+
+	priv->num_channels = device_get_child_node_count(dev) + 1;
+
+	if (priv->num_channels > device_nr_channels)
+		return dev_err_probe(dev, -E2BIG,
+				     "More channels than the chip supports.\n");
+
+	/* Initialise internal channel( which is always present ). */
+	priv->labels[0] = "internal diode";
+	priv->enabled_channel_mask = 1;
+
+	device_for_each_child_node_scoped(dev, child) {
+		reg_nr = 0;
+		fwnode_property_read_u32(child, "reg", &reg_nr);
+		if (!reg_nr || reg_nr >= device_nr_channels)
+			return dev_err_probe(dev, -EINVAL,
+			  "The index of the channels does not match the chip.\n");
+
+		fwnode_property_read_string(child, "label", &priv->labels[reg_nr]);
+		set_bit(reg_nr, &priv->enabled_channel_mask);
+	}
+
+	return 0;
+}
+
+static int mcp9982_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct hwmon_chip_info mcp998x_chip_info;
+	struct mcp9982_priv *priv;
+	const struct mcp9982_features *chip;
+	struct device *hwmon_dev;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(struct mcp9982_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = devm_regmap_init_i2c(client, &mcp9982_regmap_config);
+
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->regmap),
+				     "Cannot initialize register map.\n");
+
+	dev_set_drvdata(dev, priv);
+
+	chip = i2c_get_match_data(client);
+	if (!chip)
+		return -EINVAL;
+	priv->chip = chip;
+
+	ret = mcp9982_parse_fw_config(dev, chip->phys_channels);
+	if (ret)
+		return ret;
+
+	ret = mcp9982_init(dev, priv);
+	if (ret)
+		return ret;
+
+	mcp998x_chip_info.ops = &mcp9982_hwmon_ops;
+	mcp998x_chip_info.info = mcp9985_info;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, chip->name, priv,
+							 &mcp998x_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct i2c_device_id mcp9982_id[] = {
+	{ .name = "mcp9933", .driver_data = (kernel_ulong_t)&mcp9933_chip_config },
+	{ .name = "mcp9933d", .driver_data = (kernel_ulong_t)&mcp9933d_chip_config },
+	{ .name = "mcp9982", .driver_data = (kernel_ulong_t)&mcp9982_chip_config },
+	{ .name = "mcp9982d", .driver_data = (kernel_ulong_t)&mcp9982d_chip_config },
+	{ .name = "mcp9983", .driver_data = (kernel_ulong_t)&mcp9983_chip_config },
+	{ .name = "mcp9983d", .driver_data = (kernel_ulong_t)&mcp9983d_chip_config },
+	{ .name = "mcp9984", .driver_data = (kernel_ulong_t)&mcp9984_chip_config },
+	{ .name = "mcp9984d", .driver_data = (kernel_ulong_t)&mcp9984d_chip_config },
+	{ .name = "mcp9985", .driver_data = (kernel_ulong_t)&mcp9985_chip_config },
+	{ .name = "mcp9985d", .driver_data = (kernel_ulong_t)&mcp9985d_chip_config },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mcp9982_id);
+
+static const struct of_device_id mcp9982_of_match[] = {
+	{
+		.compatible = "microchip,mcp9933",
+		.data = &mcp9933_chip_config,
+	}, {
+		.compatible = "microchip,mcp9933d",
+		.data = &mcp9933d_chip_config,
+	}, {
+		.compatible = "microchip,mcp9982",
+		.data = &mcp9982_chip_config,
+	}, {
+		.compatible = "microchip,mcp9982d",
+		.data = &mcp9982d_chip_config,
+	}, {
+		.compatible = "microchip,mcp9983",
+		.data = &mcp9983_chip_config,
+	}, {
+		.compatible = "microchip,mcp9983d",
+		.data = &mcp9983d_chip_config,
+	}, {
+		.compatible = "microchip,mcp9984",
+		.data = &mcp9984_chip_config,
+	}, {
+		.compatible = "microchip,mcp9984d",
+		.data = &mcp9984d_chip_config,
+	}, {
+		.compatible = "microchip,mcp9985",
+		.data = &mcp9985_chip_config,
+	}, {
+		.compatible = "microchip,mcp9985d",
+		.data = &mcp9985d_chip_config,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mcp9982_of_match);
+
+static struct i2c_driver mcp9982_driver = {
+	.driver	 = {
+		.name = "mcp9982",
+		.of_match_table = mcp9982_of_match,
+	},
+	.probe = mcp9982_probe,
+	.id_table = mcp9982_id,
+};
+module_i2c_driver(mcp9982_driver);
+
+MODULE_AUTHOR("Victor Duicu <victor.duicu@microchip.com>");
+MODULE_DESCRIPTION("MCP998X/33 and MCP998XD/33D Multichannel Automotive Temperature Monitor Driver");
+MODULE_LICENSE("GPL");
-- 
2.48.1


