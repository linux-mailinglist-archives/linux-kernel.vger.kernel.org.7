Return-Path: <linux-kernel+bounces-876601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 920CEC1BD1B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752F51A22FED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9910233B6FF;
	Wed, 29 Oct 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="shL+nQyg"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27732BF3D;
	Wed, 29 Oct 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753108; cv=none; b=MlMIFv9nL7QjOUHNhpQAqbtM7lj7oRV57eN4qFesvpO07LHFDJiboOY6n8n6ZEsQPBhbSI0SvlKqE0zXKQ+S0UhWN0wQHwumYspO9VYCjQNN03HA5GIdXKQacwK1oieDDgpBLVJfJcOAlk09HB38M0hu+SXXh08me8bXONvdst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753108; c=relaxed/simple;
	bh=1IDdOpeFlq0bn2+3tK04M34Fqe0y9mYhrBdVMI+8xEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=osHbTRk9Qk2zqOeDZ4822Tdwd0Orsqo7fw91/rl1UilLh+AvetKSFMX9eJv0FRaLZpWNLPtF1jzxypdVHVk2VZL9ofUk46a09vdQFHE4PDBJzw9nsaOegkzoWym0wLbbFfy+qt7Cdv1kfZjPbYCVBVCx5BcEc1oTbkpg++w7XTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=shL+nQyg; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761753105; x=1793289105;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1IDdOpeFlq0bn2+3tK04M34Fqe0y9mYhrBdVMI+8xEM=;
  b=shL+nQyggiOM87delZ0ICdOZRYhgNGW9NVTXMsFhLIG/Bio/ZjBkBCa0
   3w4Mcs227ExW/eknpzLmn/iri7FIibY7x3CiCar5DcVRSIg6uUJ+WoaVK
   raY9kt2w64wssb9igpKDApfr/NJAQonm3+YGF7XAV7SzJTOVGd7pOoz7P
   3V42xcLwQp/iOyplnG1c+eZP08x6Y8qhX+N2+zBjQat2m27qjSpaGHerF
   TUcl8lOsFclF9qZyRfes0qJ6gmtw3wSbjcvR5Ab0I6DLCMAr8fn40mtV2
   vTXJgDqUU+3T+vhwv/M96fI+xlEbe1nppa2z44zaEPuDkLOOBDniNucWf
   Q==;
X-CSE-ConnectionGUID: iyBWzYvURAWNjcJpeOx0pg==
X-CSE-MsgGUID: mRxPYG4eRHK+zbo2WYBUfg==
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="54712636"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:51:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 29 Oct 2025 08:51:15 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 29 Oct 2025 08:51:12 -0700
From: Marius Cristea <marius.cristea@microchip.com>
Date: Wed, 29 Oct 2025 17:50:59 +0200
Subject: [PATCH 2/2] hwmon: temperature: add support for EMC1812
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20251029-hw_mon-emc1812-v1-2-be4fd8af016a@microchip.com>
References: <20251029-hw_mon-emc1812-v1-0-be4fd8af016a@microchip.com>
In-Reply-To: <20251029-hw_mon-emc1812-v1-0-be4fd8af016a@microchip.com>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Marius Cristea
	<marius.cristea@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=35595;
 i=marius.cristea@microchip.com; h=from:subject:message-id;
 bh=1IDdOpeFlq0bn2+3tK04M34Fqe0y9mYhrBdVMI+8xEM=;
 b=owGbwMvMwCW2tbSTZa7u0x2Mp9WSGDKZzF/LbeOv+dErkZB+7/SiKw8P7Vt+06TzeXKu5T6WW
 9IaG00aOkpZGMS4GGTFFFlWvPVTq1r74bKSWKYOzBxWJpAhDFycAjAR55OMDJd4tleG+Hx5kuvz
 TUxycU//lmVuM+fZnxDmqj+ZNqew8jvD/zCHXy6vBG89vLF7qS6v3ZrTGjOntZXEleh3eB9/pn9
 TkRkA
X-Developer-Key: i=marius.cristea@microchip.com; a=openpgp;
 fpr=E32F8D4396E72E463E8CCD91446DE0ABD9140C3E

This is the hwmon driver for Microchip EMC1812/13/14/15/33
Multichannel Low-Voltage Remote Diode Sensor Family.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 Documentation/hwmon/emc1812.rst |  68 +++
 MAINTAINERS                     |   2 +
 drivers/hwmon/Kconfig           |  11 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/emc1812.c         | 967 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1049 insertions(+)

diff --git a/Documentation/hwmon/emc1812.rst b/Documentation/hwmon/emc1812.rst
new file mode 100644
index 0000000000000000000000000000000000000000..799111a89541c57a839a121bb3dfc12f42604bc2
--- /dev/null
+++ b/Documentation/hwmon/emc1812.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver emc1802
+=====================
+
+Supported chips:
+
+  * Microchip EMC1812, EMC1813, EMC1814, EMC1815, EMC1833
+
+    Addresses scanned: I2C 0x1c, 0x3c, 0x4c, 0x4d, 0x5c, 0x6c, 0x7c
+
+    Prefix: 'emc1812'
+
+    Datasheets:
+
+	- https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/EMC1812-3-4-5-33-Data-Sheet-DS20005751.pdf
+
+Author:
+    Marius Cristea <marius.cristea@microchip.com
+
+
+Description
+-----------
+
+The Microchip EMC181x/33 chips contain up to 4 remote temperature sensors
+and one internal.
+- The EMC1812 is a single channel remote temperature sensor.
+- The EMC1813 and EMC1833 is a dual channel remote temperature sensor. The
+remote channels for this selection of devices can support substrate diodes,
+discrete diode-connected transistors or CPU/GPU thermal diodes.
+- The EMC1814 is a three channel remote temperature sensor that supports
+Anti-Parallel Diode (APD) only on one channel. For the channel that does not
+support APD functionality, substrate diodes, discrete diode-connected
+transistors or CPU/GPU thermal diodes are supported. For the channel that
+supports APD, only discrete diode-connected transistors may be implemented.
+However, if APD is disabled on the EMC1814, then the channel that supports
+APD will be functional with substrate diodes, discrete diode-connected
+transistors and CPU/GPU thermal diodes.
+- The EMC1815 is a four channel remote temperature sensor. The EMC1815 and
+EMC1833 support APD on all channels. When APD is enabled, the channels support
+only diode-connected transistors. If APD is disabled, then the channels will
+support substrate transistors, discrete diode-connected transistors and
+CPU/GPU thermal diodes.
+
+Note: Disabling APD functionality to implement substrate diodes on devices
+that support APD eliminates the benefit of APD (two diodes on one channel).
+
+The chips implement three limits for each sensor: low (tempX_min), high
+(tempX_max) and critical (tempX_crit). The chips also implement an
+hysteresis mechanism which applies to all limits. The relative difference
+is stored in a single register on the chip, which means that the relative
+difference between the limit and its hysteresis is always the same for
+all three limits.
+
+This implementation detail implies the following:
+
+* When setting a limit, its hysteresis will automatically follow, the
+  difference staying unchanged. For example, if the old critical limit was
+  80 degrees C, and the hysteresis was 75 degrees C, and you change the
+  critical limit to 90 degrees C, then the hysteresis will automatically
+  change to 85 degrees C.
+* The hysteresis values can't be set independently. We decided to make
+  only tempX_crit_hyst writable, while all other hysteresis attributes
+  are read-only. Setting tempX_crit_hyst writes the difference between
+  tempX_crit_hyst and tempX_crit into the chip, and the same relative
+  hysteresis applies automatically to all other limits.
+* The limits should be set before the hysteresis. At power up the device
+  starts with a 10 degree written into hysteresis register.
diff --git a/MAINTAINERS b/MAINTAINERS
index 85c236df781e47c78deeb7ef4d80bc94bba604c4..fcb712549ea679d49fde8c97840af9528b52d52b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16651,6 +16651,8 @@ M:	Marius Cristea <marius.cristea@microchip.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/hwmon/microchip,emc1812.yaml
+F:	Documentation/hwmon/emc1812.rst
+F:	drivers/hwmon/emc1812.c
 
 MICROCHIP I2C DRIVER
 M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2760feb9f83b5d3b990b27acff572e587b373e9d..3b53572fd8bfbd752c2235ca429c4f74b1db3095 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2042,6 +2042,17 @@ config SENSORS_EMC1403
 	  Threshold values can be configured using sysfs.
 	  Data from the different diodes are accessible via sysfs.
 
+config SENSORS_EMC1812
+	tristate "Microchip Technology EMC1812 driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here to build support for Microchip Technology's
+	  EMC181X/33  Multichannel Low-Voltage Remote Diode Sensor Family.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called emc1812.
+
 config SENSORS_EMC2103
 	tristate "SMSC EMC2103"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 73b2abdcc6dd9cfae4c84b350febc5d8c191e385..e93e4051e99db698dbaae97ac4841e6d810ee8c4 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_SENSORS_DRIVETEMP)	+= drivetemp.o
 obj-$(CONFIG_SENSORS_DS620)	+= ds620.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_EMC1403)	+= emc1403.o
+obj-$(CONFIG_SENSORS_EMC1812)	+= emc1812.o
 obj-$(CONFIG_SENSORS_EMC2103)	+= emc2103.o
 obj-$(CONFIG_SENSORS_EMC2305)	+= emc2305.o
 obj-$(CONFIG_SENSORS_EMC6W201)	+= emc6w201.o
diff --git a/drivers/hwmon/emc1812.c b/drivers/hwmon/emc1812.c
new file mode 100644
index 0000000000000000000000000000000000000000..78038dace1fd218346beae7c7d7447f68072d0f4
--- /dev/null
+++ b/drivers/hwmon/emc1812.c
@@ -0,0 +1,967 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * HWMON driver for Microchip EMC1812/13/14/15/33 Multichannel high-accuracy
+ * 2-wire low-voltage remote diode temperature monitor family.
+ *
+ * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Marius Cristea <marius.cristea@microchip.com>
+ *
+ * Datasheet can be found here:
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/EMC1812-3-4-5-33-Data-Sheet-DS20005751.pdf
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/string.h>
+#include <linux/units.h>
+
+/* EMC1812 Registers Addresses */
+#define EMC1812_STATUS_ADDR				0x02
+#define EMC1812_CONFIG_LO_ADDR				0x03
+
+#define EMC1812_CFG_ADDR				0x09
+#define EMC1812_CONV_ADDR				0x0A
+#define EMC1812_INT_DIODE_HIGH_LIMIT_ADDR		0x0B
+#define EMC1812_INT_DIODE_LOW_LIMIT_ADDR		0x0C
+#define EMC1812_EXT1_HIGH_LIMIT_HIGH_BYTE_ADDR		0x0D
+#define EMC1812_EXT1_LOW_LIMIT_HIGH_BYTE_ADDR		0x0E
+#define EMC1812_ONE_SHOT_ADDR				0x0F
+
+#define EMC1812_EXT1_HIGH_LIMIT_LOW_BYTE_ADDR		0x13
+#define EMC1812_EXT1_LOW_LIMIT_LOW_BYTE_ADDR		0x14
+#define EMC1812_EXT2_HIGH_LIMIT_HIGH_BYTE_ADDR		0x15
+#define EMC1812_EXT2_LOW_LIMIT_HIGH_BYTE_ADDR		0x16
+#define EMC1812_EXT2_HIGH_LIMIT_LOW_BYTE_ADDR		0x17
+#define EMC1812_EXT2_LOW_LIMIT_LOW_BYTE_ADDR		0x18
+#define EMC1812_EXT1_THERM_LIMIT_ADDR			0x19
+#define EMC1812_EXT2_THERM_LIMIT_ADDR			0x1A
+#define EMC1812_EXT_DIODE_FAULT_STATUS_ADDR		0x1B
+
+#define EMC1812_DIODE_FAULT_MASK_ADDR			0x1F
+#define EMC1812_INT_DIODE_THERM_LIMIT_ADDR		0x20
+#define EMC1812_THRM_HYS_ADDR				0x21
+#define EMC1812_CONSEC_ALERT_ADDR			0x22
+
+#define EMC1812_EXT1_BETA_CONFIG_ADDR			0x25
+#define EMC1812_EXT2_BETA_CONFIG_ADDR			0x26
+#define EMC1812_EXT1_IDEALITY_FACTOR_ADDR		0x27
+#define EMC1812_EXT2_IDEALITY_FACTOR_ADDR		0x28
+
+#define EMC1812_EXT3_HIGH_LIMIT_HIGH_BYTE_ADDR		0x2C
+#define EMC1812_EXT3_LOW_LIMIT_HIGH_BYTE_ADDR		0x2D
+#define EMC1812_EXT3_HIGH_LIMIT_LOW_BYTE_ADDR		0x2E
+#define EMC1812_EXT3_LOW_LIMIT_LOW_BYTE_ADDR		0x2F
+#define EMC1812_EXT3_THERM_LIMIT_ADDR			0x30
+#define EMC1812_EXT3_IDEALITY_FACTOR_ADDR		0x31
+
+#define EMC1812_EXT4_HIGH_LIMIT_HIGH_BYTE_ADDR		0x34
+#define EMC1812_EXT4_LOW_LIMIT_HIGH_BYTE_ADDR		0x35
+#define EMC1812_EXT4_HIGH_LIMIT_LOW_BYTE_ADDR		0x36
+#define EMC1812_EXT4_LOW_LIMIT_LOW_BYTE_ADDR		0x37
+#define EMC1812_EXT4_THERM_LIMIT_ADDR			0x38
+#define EMC1812_EXT4_IDEALITY_FACTOR_ADDR		0x39
+#define EMC1812_HIGH_LIMIT_STATUS_ADDR			0x3A
+#define EMC1812_LOW_LIMIT_STATUS_ADDR			0x3B
+#define EMC1812_THERM_LIMIT_STATUS_ADDR			0x3C
+#define EMC1812_ROC_GAIN_ADDR				0x3D
+#define EMC1812_ROC_CONFIG_ADDR				0x3E
+#define EMC1812_ROC_STATUS_ADDR				0x3F
+#define EMC1812_R1_RESH_ADDR				0x40
+#define EMC1812_R1_LIMH_ADDR				0x41
+#define EMC1812_R1_LIML_ADDR				0x42
+#define EMC1812_R1_SMPL_ADDR				0x43
+#define EMC1812_R2_RESH_ADDR				0x44
+#define EMC1812_R2_3_RESL_ADDR				0x45
+#define EMC1812_R2_LIMH_ADDR				0x46
+#define EMC1812_R2_LIML_ADDR				0x47
+#define EMC1812_R2_SMPL_ADDR				0x48
+#define EMC1812_PER_MAXTH_1_ADDR			0x49
+#define EMC1812_PER_MAXT1L_ADDR				0x4A
+#define EMC1812_PER_MAXTH_2_ADDR			0x4B
+#define EMC1812_PER_MAXT2_3L_ADDR			0x4C
+#define EMC1812_GBL_MAXT1H_ADDR				0x4D
+#define EMC1812_GBL_MAXT1L_ADDR				0x4E
+#define EMC1812_GBL_MAXT2H_ADDR				0x4F
+#define EMC1812_GBL_MAXT2L_ADDR				0x50
+#define EMC1812_FILTER_SEL_ADDR				0x51
+
+#define EMC1812_INT_HIGH_BYTE_ADDR		0x60
+#define EMC1812_INT_LOW_BYTE_ADDR		0x61
+#define EMC1812_EXT1_HIGH_BYTE_ADDR		0x62
+#define EMC1812_EXT1_LOW_BYTE_ADDR		0x63
+#define EMC1812_EXT2_HIGH_BYTE_ADDR		0x64
+#define EMC1812_EXT2_LOW_BYTE_ADDR		0x65
+#define EMC1812_EXT3_HIGH_BYTE_ADDR		0x66
+#define EMC1812_EXT3_LOW_BYTE_ADDR		0x67
+#define EMC1812_EXT4_HIGH_BYTE_ADDR		0x68
+#define EMC1812_EXT4_LOW_BYTE_ADDR		0x69
+#define EMC1812_HOTTEST_DIODE_HIGH_BYTE_ADDR	0x6A
+#define EMC1812_HOTTEST_DIODE_LOW_BYTE_ADDR	0x6B
+#define EMC1812_HOTTEST_STATUS_ADDR		0x6C
+#define EMC1812_HOTTEST_CFG_ADDR		0x6D
+
+#define EMC1812_PRODUCT_ID_ADDR			0xFD
+#define EMC1812_MANUFACTURER_ID_ADDR		0xFE
+#define EMC1812_REVISION_ADDR			0xFF
+
+/* EMC1812 Config Bits */
+#define EMC1812_CFG_MSKAL			BIT(7)
+#define EMC1812_CFG_RS				BIT(6)
+#define EMC1812_CFG_ATTHM			BIT(5)
+#define EMC1812_CFG_RECD12			BIT(4)
+#define EMC1812_CFG_RECD34			BIT(3)
+#define EMC1812_CFG_RANGE			BIT(2)
+#define EMC1812_CFG_DA_ENA			BIT(1)
+#define EMC1812_CFG_APDD			BIT(0)
+
+/* EMC1812 Status Bits */
+#define EMC1812_STATUS_ROCF			BIT(7)
+#define EMC1812_STATUS_HOTCHG			BIT(6)
+#define EMC1812_STATUS_BUSY			BIT(5)
+#define EMC1812_STATUS_HIGH			BIT(4)
+#define EMC1812_STATUS_LOW			BIT(3)
+#define EMC1812_STATUS_FAULT			BIT(2)
+#define EMC1812_STATUS_ETHRM			BIT(1)
+#define EMC1812_STATUS_ITHRM			BIT(0)
+
+#define EMC1812_BETA_LOCK_VAL			0x0F
+
+#define EMC1812_TEMP_CH_ADDR(index)		(0x60 + 2 * (index))
+
+#define EMC1812_FILTER_MASK_LEN			2
+
+#define EMC1812_PID				0x81
+#define EMC1813_PID				0x87
+#define EMC1814_PID				0x84
+#define EMC1815_PID				0x85
+#define EMC1833_PID				0x83
+
+/* The maximum number of channels a member of the family can have */
+#define EMC1812_MAX_NUM_CHANNELS		5
+#define EMC1812_TEMP_OFFSET			64
+
+#define EMC1812_DEFAULT_IDEALITY_FACTOR		0x12
+
+static const struct hwmon_channel_info * const emc1812_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_CRIT | HWMON_T_MIN_HYST | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT_HYST | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM | HWMON_T_FAULT |
+			   HWMON_T_LABEL,
+
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_CRIT | HWMON_T_MIN_HYST | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT_HYST | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM | HWMON_T_FAULT |
+			   HWMON_T_LABEL,
+
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_CRIT | HWMON_T_MIN_HYST | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT_HYST | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM | HWMON_T_FAULT |
+			   HWMON_T_LABEL,
+
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_CRIT | HWMON_T_MIN_HYST | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT_HYST | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM | HWMON_T_FAULT |
+			   HWMON_T_LABEL,
+
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_CRIT | HWMON_T_MIN_HYST | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT_HYST | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM | HWMON_T_FAULT |
+			   HWMON_T_LABEL
+			   ),
+	NULL
+};
+
+/**
+ * struct emc1812_features - features of a emc1812 instance
+ * @name:		chip's name
+ * @phys_channels:	number of physical channels supported by the chip
+ */
+struct emc1812_features {
+	const char	*name;
+	u8		phys_channels;
+};
+
+static const struct emc1812_features emc1833_chip_config = {
+	.name = "emc1833",
+	.phys_channels = 3,
+};
+
+static const struct emc1812_features emc1812_chip_config = {
+	.name = "emc1812",
+	.phys_channels = 2,
+};
+
+static const struct emc1812_features emc1813_chip_config = {
+	.name = "emc1813",
+	.phys_channels = 3,
+};
+
+static const struct emc1812_features emc1814_chip_config = {
+	.name = "emc1814",
+	.phys_channels = 4,
+};
+
+static const struct emc1812_features emc1815_chip_config = {
+	.name = "emc1815",
+	.phys_channels = 5,
+};
+
+enum emc1812_limit_type {temp_min, temp_max};
+
+static u8 emc1812_temp_map[] = {
+	[hwmon_temp_min] = temp_min,
+	[hwmon_temp_max] = temp_max,
+};
+
+static u8 emc1812_temp_crit_regs[] = {
+	[0] = EMC1812_INT_DIODE_THERM_LIMIT_ADDR,
+	[1] = EMC1812_EXT1_THERM_LIMIT_ADDR,
+	[2] = EMC1812_EXT2_THERM_LIMIT_ADDR,
+	[3] = EMC1812_EXT3_THERM_LIMIT_ADDR,
+	[4] = EMC1812_EXT4_THERM_LIMIT_ADDR,
+};
+
+static u8 emc1812_limit_regs[][2] = {
+	[0] = {
+		[temp_min] = EMC1812_INT_DIODE_LOW_LIMIT_ADDR,
+		[temp_max] = EMC1812_INT_DIODE_HIGH_LIMIT_ADDR,
+	},
+	[1] = {
+		[temp_min] = EMC1812_EXT1_LOW_LIMIT_HIGH_BYTE_ADDR,
+		[temp_max] = EMC1812_EXT1_HIGH_LIMIT_HIGH_BYTE_ADDR,
+	},
+	[2] = {
+		[temp_min] = EMC1812_EXT2_LOW_LIMIT_HIGH_BYTE_ADDR,
+		[temp_max] = EMC1812_EXT2_HIGH_LIMIT_HIGH_BYTE_ADDR,
+	},
+	[3] = {
+		[temp_min] = EMC1812_EXT3_LOW_LIMIT_HIGH_BYTE_ADDR,
+		[temp_max] = EMC1812_EXT3_HIGH_LIMIT_HIGH_BYTE_ADDR,
+	},
+	[4] = {
+		[temp_min] = EMC1812_EXT4_LOW_LIMIT_HIGH_BYTE_ADDR,
+		[temp_max] = EMC1812_EXT4_HIGH_LIMIT_HIGH_BYTE_ADDR,
+	},
+};
+
+static u8 emc1812_limit_regs_low[][3] = {
+	[0] = {
+		[temp_min] = 0xff,
+		[temp_max] = 0xff,
+	},
+	[1] = {
+		[temp_min] = EMC1812_EXT1_LOW_LIMIT_LOW_BYTE_ADDR,
+		[temp_max] = EMC1812_EXT1_HIGH_LIMIT_LOW_BYTE_ADDR,
+	},
+	[2] = {
+		[temp_min] = EMC1812_EXT2_LOW_LIMIT_LOW_BYTE_ADDR,
+		[temp_max] = EMC1812_EXT2_HIGH_LIMIT_LOW_BYTE_ADDR,
+	},
+	[3] = {
+		[temp_min] = EMC1812_EXT3_LOW_LIMIT_LOW_BYTE_ADDR,
+		[temp_max] = EMC1812_EXT3_HIGH_LIMIT_LOW_BYTE_ADDR,
+	},
+	[4] = {
+		[temp_min] = EMC1812_EXT4_LOW_LIMIT_LOW_BYTE_ADDR,
+		[temp_max] = EMC1812_EXT4_HIGH_LIMIT_LOW_BYTE_ADDR,
+	},
+};
+
+/* Lookup table for temperature conversion times in msec */
+static const u16 emc1812_conv_time[] = {
+	16000, 8000, 4000, 2000, 1000, 500, 250, 125, 62, 31, 16
+};
+
+/**
+ * struct emc1812_data - information about chip parameters
+ * @client:		i2c client
+ * @hwmon_dev:		hwmon device
+ * @labels:		labels of the channels
+ * @active_ch_mask:	active channels
+ * @chip:		pointer to structure holding chip features
+ * @freq_idx:		index representing the current sampling frequency
+ * @regmap:		device register map
+ * @recd34_en:		state of Resistance Error Correction (REC) on channels 3 and 4
+ * @recd12_en:		state of Resistance Error Correction (REC) on channels 1 and 2
+ * @lock:		synchronize access to driver's state members
+ * @apdd_en:		state of anti-parallel diode mode
+ * @num_channels:	number of active physical channels
+ */
+struct emc1812_data {
+	struct i2c_client *client;
+	struct device *hwmon_dev;
+	const char *labels[EMC1812_MAX_NUM_CHANNELS];
+	unsigned long active_ch_mask;
+	const struct emc1812_features *chip;
+	unsigned int freq_idx;
+	struct regmap *regmap;
+	bool recd34_en;
+	bool recd12_en;
+	struct mutex lock;	 /* Synchronize access to driver's state members */
+	bool apdd_en;
+	u8 num_channels;
+};
+
+/* emc1812 regmap configuration */
+static const struct regmap_range emc1812_regmap_writable_ranges[] = {
+	regmap_reg_range(EMC1812_CFG_ADDR, EMC1812_ONE_SHOT_ADDR),
+	regmap_reg_range(EMC1812_EXT1_HIGH_LIMIT_LOW_BYTE_ADDR,
+			 EMC1812_EXT_DIODE_FAULT_STATUS_ADDR),
+	regmap_reg_range(EMC1812_DIODE_FAULT_MASK_ADDR, EMC1812_CONSEC_ALERT_ADDR),
+	regmap_reg_range(EMC1812_EXT1_BETA_CONFIG_ADDR, EMC1812_FILTER_SEL_ADDR),
+	regmap_reg_range(EMC1812_HOTTEST_STATUS_ADDR, EMC1812_HOTTEST_CFG_ADDR),
+};
+
+static const struct regmap_access_table emc1812_regmap_wr_table = {
+	.yes_ranges = emc1812_regmap_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(emc1812_regmap_writable_ranges),
+};
+
+static const struct regmap_range emc1812_regmap_rd_ranges[] = {
+	regmap_reg_range(EMC1812_STATUS_ADDR, EMC1812_CONFIG_LO_ADDR),
+	regmap_reg_range(EMC1812_CFG_ADDR, EMC1812_ONE_SHOT_ADDR),
+	regmap_reg_range(EMC1812_EXT1_HIGH_LIMIT_LOW_BYTE_ADDR,
+			 EMC1812_EXT_DIODE_FAULT_STATUS_ADDR),
+	regmap_reg_range(EMC1812_DIODE_FAULT_MASK_ADDR, EMC1812_CONSEC_ALERT_ADDR),
+	regmap_reg_range(EMC1812_EXT1_BETA_CONFIG_ADDR, EMC1812_FILTER_SEL_ADDR),
+	regmap_reg_range(EMC1812_INT_HIGH_BYTE_ADDR, EMC1812_HOTTEST_CFG_ADDR),
+	regmap_reg_range(EMC1812_PRODUCT_ID_ADDR, EMC1812_REVISION_ADDR),
+};
+
+static const struct regmap_access_table emc1812_regmap_rd_table = {
+	.yes_ranges = emc1812_regmap_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(emc1812_regmap_rd_ranges),
+};
+
+static bool emc1812_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case EMC1812_STATUS_ADDR:
+	case EMC1812_EXT_DIODE_FAULT_STATUS_ADDR:
+	case EMC1812_DIODE_FAULT_MASK_ADDR:
+	case EMC1812_EXT1_BETA_CONFIG_ADDR:
+	case EMC1812_EXT2_BETA_CONFIG_ADDR:
+	case EMC1812_HIGH_LIMIT_STATUS_ADDR:
+	case EMC1812_LOW_LIMIT_STATUS_ADDR:
+	case EMC1812_THERM_LIMIT_STATUS_ADDR:
+	case EMC1812_ROC_STATUS_ADDR:
+	case EMC1812_PER_MAXTH_1_ADDR:
+	case EMC1812_PER_MAXT1L_ADDR:
+	case EMC1812_PER_MAXTH_2_ADDR:
+	case EMC1812_PER_MAXT2_3L_ADDR:
+	case EMC1812_GBL_MAXT1H_ADDR:
+	case EMC1812_GBL_MAXT1L_ADDR:
+	case EMC1812_GBL_MAXT2H_ADDR:
+	case EMC1812_GBL_MAXT2L_ADDR:
+	case EMC1812_INT_HIGH_BYTE_ADDR:
+	case EMC1812_INT_LOW_BYTE_ADDR:
+	case EMC1812_EXT1_HIGH_BYTE_ADDR:
+	case EMC1812_EXT1_LOW_BYTE_ADDR:
+	case EMC1812_EXT2_HIGH_BYTE_ADDR:
+	case EMC1812_EXT2_LOW_BYTE_ADDR:
+	case EMC1812_EXT3_HIGH_BYTE_ADDR:
+	case EMC1812_EXT3_LOW_BYTE_ADDR:
+	case EMC1812_EXT4_HIGH_BYTE_ADDR:
+	case EMC1812_EXT4_LOW_BYTE_ADDR:
+	case EMC1812_HOTTEST_DIODE_HIGH_BYTE_ADDR:
+	case EMC1812_HOTTEST_DIODE_LOW_BYTE_ADDR:
+	case EMC1812_HOTTEST_STATUS_ADDR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config emc1812_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &emc1812_regmap_rd_table,
+	.wr_table = &emc1812_regmap_wr_table,
+	.volatile_reg = emc1812_is_volatile_reg,
+	.max_register = EMC1812_REVISION_ADDR,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static umode_t emc1812_is_visible(const void *_data, enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	const struct emc1812_data *data = _data;
+
+	switch (type) {
+	case hwmon_temp:
+		/* Don't show channels which are not described into the device tree. */
+		if (!(data->active_ch_mask & (1 << channel)))
+			return 0;
+
+		/* Don't show channels which are not physically connected. */
+		if (channel >= data->chip->phys_channels)
+			return 0;
+
+		switch (attr) {
+		case hwmon_temp_input:
+		case hwmon_temp_min_alarm:
+		case hwmon_temp_max_alarm:
+		case hwmon_temp_crit_alarm:
+		case hwmon_temp_fault:
+		case hwmon_temp_min_hyst:
+		case hwmon_temp_max_hyst:
+		case hwmon_temp_label:
+			return 0444;
+		case hwmon_temp_min:
+		case hwmon_temp_max:
+		case hwmon_temp_crit:
+		case hwmon_temp_crit_hyst:
+			return 0644;
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
+};
+
+static int emc1812_get_temp(struct emc1812_data *data, int channel, long *val)
+{
+	__be16 tmp_be16;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, EMC1812_TEMP_CH_ADDR(channel),
+			       &tmp_be16, sizeof(tmp_be16));
+	if (ret)
+		return ret;
+
+	/* Range is always -64 to 191.875°C */
+	*val = ((be16_to_cpu(tmp_be16) >> 5) - 512) * 125;
+
+	return 0;
+}
+
+static int emc1812_get_crit_limit_temp(struct emc1812_data *data, int channel, long *val)
+{
+	unsigned int tmp;
+	int ret;
+
+	/* Critical register is 8bits long and keeps only integer part of temperature */
+	ret = regmap_read(data->regmap, emc1812_temp_crit_regs[channel], &tmp);
+	if (ret)
+		return ret;
+
+	/* Range is always -64 to 191°C */
+	*val = (tmp - EMC1812_TEMP_OFFSET) * 1000;
+
+	return 0;
+}
+
+static int emc1812_get_limit_temp(struct emc1812_data *data, int ch,
+				  enum emc1812_limit_type type, long *val)
+{
+	unsigned int regvalh;
+	unsigned int regvall = 0;
+	int ret;
+
+	ret = regmap_read(data->regmap, emc1812_limit_regs[ch][type], &regvalh);
+	if (ret < 0)
+		return ret;
+
+	if (ch) {
+		ret = regmap_read(data->regmap, emc1812_limit_regs_low[ch][type], &regvall);
+		if (ret < 0)
+			return ret;
+	}
+	/* Range is always -64 to 191.875°C */
+	*val = (((regvalh - EMC1812_TEMP_OFFSET) << 3) | (regvall >> 5)) * 125;
+
+	return 0;
+}
+
+static int emc1812_read_reg(struct device *dev, struct emc1812_data *data, u32 attr,
+			    int channel, long *val)
+{
+	unsigned int mask;
+	int hyst, ret;
+
+	switch (attr) {
+	case hwmon_temp_min:
+		return emc1812_get_limit_temp(data, channel, temp_min, val);
+	case hwmon_temp_max:
+		return emc1812_get_limit_temp(data, channel, temp_max, val);
+	case hwmon_temp_crit:
+		return emc1812_get_crit_limit_temp(data, channel, val);
+	case hwmon_temp_input:
+		return emc1812_get_temp(data, channel, val);
+	case hwmon_temp_min_hyst:
+		ret = emc1812_get_limit_temp(data, channel, temp_min, val);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_read(data->regmap, EMC1812_THRM_HYS_ADDR, &hyst);
+		if (ret < 0)
+			return ret;
+
+		*val = *val + hyst * 1000;
+
+		return 0;
+
+	case hwmon_temp_max_hyst:
+		ret = emc1812_get_limit_temp(data, channel, temp_max, val);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_read(data->regmap, EMC1812_THRM_HYS_ADDR, &hyst);
+		if (ret < 0)
+			return ret;
+
+		*val = *val - hyst * 1000;
+
+		return 0;
+	case hwmon_temp_crit_hyst:
+		ret = emc1812_get_crit_limit_temp(data, channel, val);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_read(data->regmap, EMC1812_THRM_HYS_ADDR, &hyst);
+		if (ret < 0)
+			return ret;
+
+		*val = *val - hyst * 1000;
+		return 0;
+	case hwmon_temp_min_alarm:
+		mask = 1 << channel;
+		*val = regmap_test_bits(data->regmap, EMC1812_LOW_LIMIT_STATUS_ADDR, mask);
+		if (*val < 0)
+			return *val;
+		return 0;
+	case hwmon_temp_max_alarm:
+		mask = 1 << channel;
+		*val = regmap_test_bits(data->regmap, EMC1812_HIGH_LIMIT_STATUS_ADDR, mask);
+		if (*val < 0)
+			return *val;
+		return 0;
+	case hwmon_temp_crit_alarm:
+		mask = 1 << channel;
+		*val = regmap_test_bits(data->regmap, EMC1812_THERM_LIMIT_STATUS_ADDR, mask);
+		if (*val < 0)
+			return *val;
+		return 0;
+	case hwmon_temp_fault:
+		mask = 1 << channel;
+		*val = regmap_test_bits(data->regmap, EMC1812_EXT_DIODE_FAULT_STATUS_ADDR, mask);
+		if (*val < 0)
+			return *val;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int emc1812_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+			int channel, long *val)
+{
+	struct emc1812_data *data = dev_get_drvdata(dev);
+	unsigned int convrate;
+	int ret;
+
+	switch (type) {
+	case hwmon_temp:
+		return emc1812_read_reg(dev, data, attr, channel, val);
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_update_interval:
+			ret = regmap_read(data->regmap, EMC1812_CONV_ADDR, &convrate);
+			if (ret < 0)
+				return ret;
+
+			if (convrate > 10)
+				convrate = 4;
+
+			*val = 16000 >> convrate;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int emc1812_read_string(struct device *dev, enum hwmon_sensor_types type,
+			       u32 attr, int channel, const char **str)
+{
+	struct emc1812_data *data = dev_get_drvdata(dev);
+
+	if (channel >= data->chip->phys_channels)
+		return 0;
+
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_label:
+			*str = data->labels[channel];
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int emc1812_set_hyst(struct emc1812_data *data, int channel, long val)
+{
+	int hyst, ret;
+	int limit;
+
+	/* Critical register is 8bits long and keeps only integer part of temperature */
+	ret = regmap_read(data->regmap, emc1812_temp_crit_regs[channel], &limit);
+	if (ret)
+		return ret;
+
+	hyst = clamp_val(limit - val, 0, 256);
+
+	ret = regmap_write(data->regmap, EMC1812_THRM_HYS_ADDR, hyst);
+
+	return ret;
+}
+
+static int emc1812_set_temp(struct emc1812_data *data, int channel,
+			    enum emc1812_limit_type map, long val)
+{
+	int ret;
+	u8 regh, regl;
+
+	regh = emc1812_limit_regs[channel][map];
+	regl = emc1812_limit_regs_low[channel][map];
+
+	ret = regmap_write(data->regmap, regh, (val >> 3) & 0xff);
+	if (ret < 0)
+		return ret;
+
+	if (channel)
+		ret = regmap_write(data->regmap, regl, (val & 0x07) << 5);
+
+	return ret;
+}
+
+static int emc1812_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+			 int channel, long val)
+{
+	struct emc1812_data *data = dev_get_drvdata(dev);
+	unsigned int interval;
+	int convrate;
+
+	switch (type) {
+	case hwmon_temp:
+		/* Range is always -64 to 191.875°C */
+		val = clamp_val(val, -64000, 191875);
+		val = val + (EMC1812_TEMP_OFFSET * 1000);
+		val = DIV_ROUND_CLOSEST(val, 125);
+
+		switch (attr) {
+		case hwmon_temp_min:
+		case hwmon_temp_max:
+			return emc1812_set_temp(data, channel, emc1812_temp_map[attr], val);
+		case hwmon_temp_crit:
+			val = (val >> 3) & 0xff;
+			return regmap_write(data->regmap, emc1812_temp_crit_regs[channel], val);
+		case hwmon_temp_crit_hyst:
+			val = (val >> 3) & 0xff;
+			return emc1812_set_hyst(data, channel, val);
+		default:
+			return -EOPNOTSUPP;
+		}
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_update_interval:
+			interval = clamp_val(val, 0, 16000);
+			convrate = find_closest_descending(interval, emc1812_conv_time,
+							   ARRAY_SIZE(emc1812_conv_time));
+			return regmap_write(data->regmap, EMC1812_CONV_ADDR, convrate);
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int emc1812_init(struct emc1812_data *priv)
+{
+	int ret;
+	u8 val;
+
+	/*
+	 * Set default values in registers. APDD, RECD12 and RECD34 are active
+	 * on 0.
+	 * Set the device to be in Run (Active) state and converting on all
+	 * channels.
+	 * The temperature measurement range is -64°C to +191.875°C.
+	 */
+	val = FIELD_PREP(EMC1812_CFG_MSKAL, 1) |
+	      FIELD_PREP(EMC1812_CFG_RS, 0) |
+	      FIELD_PREP(EMC1812_CFG_ATTHM, 1) |
+	      FIELD_PREP(EMC1812_CFG_RECD12, !priv->recd12_en) |
+	      FIELD_PREP(EMC1812_CFG_RECD34, !priv->recd34_en) |
+	      FIELD_PREP(EMC1812_CFG_RANGE, 1) |
+	      FIELD_PREP(EMC1812_CFG_DA_ENA, 0) |
+	      FIELD_PREP(EMC1812_CFG_APDD, !priv->apdd_en);
+
+	ret = regmap_write(priv->regmap, EMC1812_CFG_ADDR, val);
+	if (ret)
+		return ret;
+
+	/* Default is 4 conversions/seconds */
+	ret = regmap_write(priv->regmap, EMC1812_CONV_ADDR, 6);
+	if (ret)
+		return ret;
+	priv->freq_idx = 6;
+
+	ret = regmap_write(priv->regmap, EMC1812_THRM_HYS_ADDR, 0x0A);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, EMC1812_CONSEC_ALERT_ADDR, 0x70);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, EMC1812_FILTER_SEL_ADDR, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, EMC1812_HOTTEST_CFG_ADDR, 0);
+	if (ret)
+		return ret;
+
+	/* Enables the beta compensation factor auto-detection function for beta1 and beta2 */
+	ret = regmap_write(priv->regmap, EMC1812_EXT1_BETA_CONFIG_ADDR,
+			   EMC1812_BETA_LOCK_VAL);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, EMC1812_EXT2_BETA_CONFIG_ADDR,
+			   EMC1812_BETA_LOCK_VAL);
+	if (ret)
+		return ret;
+
+	/* Set ideality factor for all external channels */
+	ret = regmap_write(priv->regmap, EMC1812_EXT1_IDEALITY_FACTOR_ADDR,
+			   EMC1812_DEFAULT_IDEALITY_FACTOR);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, EMC1812_EXT2_IDEALITY_FACTOR_ADDR,
+			   EMC1812_DEFAULT_IDEALITY_FACTOR);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, EMC1812_EXT3_IDEALITY_FACTOR_ADDR,
+			   EMC1812_DEFAULT_IDEALITY_FACTOR);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, EMC1812_EXT4_IDEALITY_FACTOR_ADDR,
+			   EMC1812_DEFAULT_IDEALITY_FACTOR);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int emc1812_parse_fw_config(struct emc1812_data *data, struct device *dev)
+{
+	unsigned int reg_nr = 0;
+	int ret;
+
+	data->apdd_en = device_property_read_bool(dev, "microchip,enable-anti-parallel");
+	data->recd12_en = device_property_read_bool(dev, "microchip,parasitic-res-on-channel1-2");
+	data->recd34_en = device_property_read_bool(dev, "microchip,parasitic-res-on-channel3-4");
+
+	data->num_channels = device_get_child_node_count(dev) + 1;
+
+	if (data->num_channels > data->chip->phys_channels)
+		return dev_err_probe(dev, -E2BIG, "More channels than the chip supports\n");
+
+	/* internal temperature channel as always active */
+	data->labels[reg_nr] = "internal_diode";
+	set_bit(reg_nr, &data->active_ch_mask);
+
+	device_for_each_child_node_scoped(dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &reg_nr);
+		if (ret || reg_nr >= data->chip->phys_channels)
+			return dev_err_probe(dev, -EINVAL,
+				     "The index of the channels does not match the chip\n");
+		/* mark external channel as active */
+		set_bit(reg_nr, &data->active_ch_mask);
+
+		fwnode_property_read_string(child, "label", &data->labels[reg_nr]);
+	}
+
+	return 0;
+}
+
+static int emc1812_chip_identify(struct emc1812_data *data, struct i2c_client *client)
+{
+	int ret, tmp;
+
+	ret = regmap_read(data->regmap, EMC1812_PRODUCT_ID_ADDR, &tmp);
+	if (ret)
+		return ret;
+
+	switch (tmp) {
+	case EMC1812_PID:
+		data->chip = &emc1812_chip_config;
+		break;
+	case EMC1813_PID:
+		data->chip = &emc1813_chip_config;
+		break;
+	case EMC1814_PID:
+		data->chip = &emc1814_chip_config;
+		break;
+	case EMC1815_PID:
+		data->chip = &emc1815_chip_config;
+		break;
+	case EMC1833_PID:
+		data->chip = &emc1833_chip_config;
+		break;
+	default:
+		/*
+		 * If failed to identify the hardware based on internal registers,
+		 * try using fallback compatible in device tree to deal with some
+		 * newer part number.
+		 */
+		data->chip = device_get_match_data(&client->dev);
+		if (!data->chip)
+			return -EINVAL;
+		break;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_ops emc1812_ops = {
+	.is_visible = emc1812_is_visible,
+	.read = emc1812_read,
+	.read_string = emc1812_read_string,
+	.write = emc1812_write,
+};
+
+static const struct hwmon_chip_info emc1812_chip_info = {
+	.ops = &emc1812_ops,
+	.info = emc1812_info,
+};
+
+static int emc1812_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct emc1812_data *data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	data->client = client;
+
+	data->regmap = devm_regmap_init_i2c(client, &emc1812_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "Cannot initialize register map\n");
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
+	ret = emc1812_chip_identify(data, client);
+	if (ret)
+		return dev_err_probe(dev, ret, "Chip identification fails\n");
+
+	dev_info(dev, "Device name: %s\n", data->chip->name);
+
+	ret = emc1812_parse_fw_config(data, dev);
+	if (ret)
+		return ret;
+
+	ret = emc1812_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot initialize device\n");
+
+	data->hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data,
+							       &emc1812_chip_info, NULL);
+	if (IS_ERR(data->hwmon_dev))
+		return PTR_ERR(data->hwmon_dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id emc1812_id[] = {
+	{ .name = "emc1812", .driver_data = (kernel_ulong_t)&emc1812_chip_config },
+	{ .name = "emc1813", .driver_data = (kernel_ulong_t)&emc1813_chip_config },
+	{ .name = "emc1814", .driver_data = (kernel_ulong_t)&emc1814_chip_config },
+	{ .name = "emc1815", .driver_data = (kernel_ulong_t)&emc1815_chip_config },
+	{ .name = "emc1833", .driver_data = (kernel_ulong_t)&emc1833_chip_config },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, emc1812_id);
+
+static const struct of_device_id emc1812_of_match[] = {
+	{
+		.compatible = "microchip,emc1812",
+		.data = &emc1812_chip_config
+	},
+	{
+		.compatible = "microchip,emc1813",
+		.data = &emc1813_chip_config
+	},
+	{
+		.compatible = "microchip,emc1814",
+		.data = &emc1814_chip_config
+	},
+	{
+		.compatible = "microchip,emc1815",
+		.data = &emc1815_chip_config
+	},
+	{
+		.compatible = "microchip,emc1833",
+		.data = &emc1833_chip_config
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, emc1812_of_match);
+
+static struct i2c_driver emc1812_driver = {
+	.driver	 = {
+		.name = "emc1812",
+		.of_match_table = emc1812_of_match,
+	},
+	.probe = emc1812_probe,
+	.id_table = emc1812_id,
+};
+module_i2c_driver(emc1812_driver);
+
+MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
+MODULE_DESCRIPTION("EMC1812/13/14/15/33 high-accuracy remote diode temperature monitor Driver");
+MODULE_LICENSE("GPL");

-- 
2.48.1


