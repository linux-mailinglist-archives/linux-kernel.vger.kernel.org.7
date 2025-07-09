Return-Path: <linux-kernel+bounces-723188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B86DAAFE42E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327161C426FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00F2285CB0;
	Wed,  9 Jul 2025 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="C58kRHAr"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472551D5150;
	Wed,  9 Jul 2025 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053746; cv=none; b=sJQvM2AN6OUX5+PE9rG4yG2hZ66G3UEFPkVMYdcynJXScCGp6Nlug5Lg33Eh9G4dj6fhokmrSL8wqImS87hlfKrgAf2Ex4ImqfcplWPceKLVsE9mVVm3dVcjNfaV9FIOMvoN1JKqRZwhKhY36hcyYQVY2w06REQCwaoRl5SZiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053746; c=relaxed/simple;
	bh=XaPW9tCqneks6bLJNqcmYSg33SkAsKP7Dhi0HKllPWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+o29CtTbFMPLhELHOFB4YuC5f+crOoaSk80/MhhmUHyVLt578G2ZrBFCk6felAv426jt2dX8KUUuzBcfFOy9D5cUCe5VlplHNo5a+AHnUDTrfKnBhQ3+oBlXzCzppGo8cWylcPbPhnXyPchf1arIySXe58m7LHdyT22oGByCcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=C58kRHAr; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=7HrIALFdm1uA1e3UZ1i2Mj3I/tYHz7aKMwjc+7aLRig=;
	b=C58kRHAr9QzdN8pC1oGmyOcx5J8odG/WYUJdm7q/+igTmU/tCBIWgo2ZM9FRrs
	UpuSBMb3glUObIpy9u/87a5W+wpoLDjZPSIVYsBG1MGZpHuGTEqVOap5AeTlg/AK
	6Y76ROymV6iUaBA23LmlnyzL+RjO94TPO+AwQNXSD4xKo=
Received: from mps-HP-EliteBook-840-G3.monolithicpower.com (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXTwakN25osQEcAA--.49192S3;
	Wed, 09 Jul 2025 17:34:32 +0800 (CST)
From: wenswang@yeah.net
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Wensheng Wang <wenswang@yeah.net>
Subject: [PATCH v3 2/2] hwmon: add MP2869 series and MP29502 driver
Date: Wed,  9 Jul 2025 17:34:20 +0800
Message-Id: <20250709093420.456304-2-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250709093420.456304-1-wenswang@yeah.net>
References: <20250709092734.455976-1-wenswang@yeah.net>
 <20250709093420.456304-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgDXTwakN25osQEcAA--.49192S3
X-Coremail-Antispam: 1Uf129KBjvAXoWDCryrXryxWF1fKFy8ZrWUurg_yoWrZF4xZo
	Z5WayrZw1UJr1UuFWvkF4IqF1xXF1UArZYy3WayanrWFy7Ar4Fya93Cw4aqa4aya1rXws5
	uaykA3s3tay7ZF17n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcUGOUUUUU
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiIQitUmhuN6gJ-QAA37

From: Wensheng Wang <wenswang@yeah.net>

Add support for MPS VR mp2869 series and mp29502 controller. The
driver exposes telemetry and limit value readings and writtings.

Signed-off-by: Wensheng Wang <wenswang@yeah.net>
---
V2 -> V3:
    merge patches for MP29502 and MP2869

V1 -> V2:
    add Rob's Acked-by

 Documentation/hwmon/index.rst   |   2 +
 Documentation/hwmon/mp2869.rst  | 175 ++++++++
 Documentation/hwmon/mp29502.rst |  93 +++++
 MAINTAINERS                     |   9 +
 drivers/hwmon/pmbus/Kconfig     |  18 +
 drivers/hwmon/pmbus/Makefile    |   2 +
 drivers/hwmon/pmbus/mp2869.c    | 711 ++++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/mp29502.c   | 670 ++++++++++++++++++++++++++++++
 8 files changed, 1680 insertions(+)
 create mode 100644 Documentation/hwmon/mp2869.rst
 create mode 100644 Documentation/hwmon/mp29502.rst
 create mode 100644 drivers/hwmon/pmbus/mp2869.c
 create mode 100644 drivers/hwmon/pmbus/mp29502.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index b45bfb4ebf30..ebc5c92e50b0 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -172,8 +172,10 @@ Hardware Monitoring Kernel Drivers
    menf21bmc
    mlxreg-fan
    mp2856
+   mp2869
    mp2888
    mp2891
+   mp29502
    mp2975
    mp2993
    mp5023
diff --git a/Documentation/hwmon/mp2869.rst b/Documentation/hwmon/mp2869.rst
new file mode 100644
index 000000000000..2d9d65fc86b6
--- /dev/null
+++ b/Documentation/hwmon/mp2869.rst
@@ -0,0 +1,175 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver mp2869
+====================
+
+Supported chips:
+
+  * MPS mp2869
+
+    Prefix: 'mp2869'
+
+  * MPS mp29608
+
+    Prefix: 'mp29608'
+
+  * MPS mp29612
+
+    Prefix: 'mp29612'
+
+  * MPS mp29816
+
+    Prefix: 'mp29816'
+
+Author:
+
+	Wensheng Wang <wenswang@yeah.net>
+
+Description
+-----------
+
+This driver implements support for Monolithic Power Systems, Inc. (MPS)
+MP2869 Dual Loop Digital Multi-phase Controller.
+
+Device compliant with:
+
+- PMBus rev 1.3 interface.
+
+The driver exports the following attributes via the 'sysfs' files
+for input voltage:
+
+**in1_input**
+
+**in1_label**
+
+**in1_crit**
+
+**in1_crit_alarm**
+
+**in1_lcrit**
+
+**in1_lcrit_alarm**
+
+**in1_min**
+
+**in1_min_alarm**
+
+The driver provides the following attributes for output voltage:
+
+**in2_input**
+
+**in2_label**
+
+**in2_crit**
+
+**in2_crit_alarm**
+
+**in2_lcrit**
+
+**in2_lcrit_alarm**
+
+**in3_input**
+
+**in3_label**
+
+**in3_crit**
+
+**in3_crit_alarm**
+
+**in3_lcrit**
+
+**in3_lcrit_alarm**
+
+The driver provides the following attributes for input current:
+
+**curr1_input**
+
+**curr1_label**
+
+**curr2_input**
+
+**curr2_label**
+
+The driver provides the following attributes for output current:
+
+**curr3_input**
+
+**curr3_label**
+
+**curr3_crit**
+
+**curr3_crit_alarm**
+
+**curr3_max**
+
+**curr3_max_alarm**
+
+**curr4_input**
+
+**curr4_label**
+
+**curr4_crit**
+
+**curr4_crit_alarm**
+
+**curr4_max**
+
+**curr4_max_alarm**
+
+The driver provides the following attributes for input power:
+
+**power1_input**
+
+**power1_label**
+
+**power2_input**
+
+**power2_label**
+
+The driver provides the following attributes for output power:
+
+**power3_input**
+
+**power3_label**
+
+**power3_input**
+
+**power3_label**
+
+**power3_max**
+
+**power3_max_alarm**
+
+**power4_input**
+
+**power4_label**
+
+**power4_input**
+
+**power4_label**
+
+**power4_max**
+
+**power4_max_alarm**
+
+The driver provides the following attributes for temperature:
+
+**temp1_input**
+
+**temp1_crit**
+
+**temp1_crit_alarm**
+
+**temp1_max**
+
+**temp1_max_alarm**
+
+**temp2_input**
+
+**temp2_crit**
+
+**temp2_crit_alarm**
+
+**temp2_max**
+
+**temp2_max_alarm**
diff --git a/Documentation/hwmon/mp29502.rst b/Documentation/hwmon/mp29502.rst
new file mode 100644
index 000000000000..7743056f0aa6
--- /dev/null
+++ b/Documentation/hwmon/mp29502.rst
@@ -0,0 +1,93 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver mp29502
+====================
+
+Supported chips:
+
+  * MPS mp29502
+
+    Prefix: 'mp29502'
+
+Author:
+
+	Wensheng Wang <wenswang@yeah.net>
+
+Description
+-----------
+
+This driver implements support for Monolithic Power Systems, Inc. (MPS)
+MP29502 Digital Multi-phase Controller.
+
+Device compliant with:
+
+- PMBus rev 1.3 interface.
+
+The driver exports the following attributes via the 'sysfs' files
+for input voltage:
+
+**in1_input**
+
+**in1_label**
+
+**in1_crit**
+
+**in1_crit_alarm**
+
+The driver provides the following attributes for output voltage:
+
+**in2_input**
+
+**in2_label**
+
+**in2_crit**
+
+**in2_crit_alarm**
+
+**in2_lcrit**
+
+**in2_lcrit_alarm**
+
+The driver provides the following attributes for input current:
+
+**curr1_input**
+
+**curr1_label**
+
+The driver provides the following attributes for output current:
+
+**curr2_input**
+
+**curr2_label**
+
+**curr2_crit**
+
+**curr2_crit_alarm**
+
+**curr2_max**
+
+**curr2_max_alarm**
+
+The driver provides the following attributes for input power:
+
+**power1_input**
+
+**power1_label**
+
+The driver provides the following attributes for output power:
+
+**power2_input**
+
+**power2_label**
+
+The driver provides the following attributes for temperature:
+
+**temp1_input**
+
+**temp1_crit**
+
+**temp1_crit_alarm**
+
+**temp1_max**
+
+**temp1_max_alarm**
diff --git a/MAINTAINERS b/MAINTAINERS
index 240793fbe64b..b4377f0eb3a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16839,6 +16839,15 @@ F:	scripts/module*
 F:	tools/testing/selftests/kmod/
 F:	tools/testing/selftests/module/
 
+MONOLITHIC POWER SYSTEM MULTI-PHASE CONTROLLER DRIVER
+M:	Wensheng Wang <wenswang@yeah.net>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/mp2869.rst
+F:	Documentation/hwmon/mp29502.rst
+F:	drivers/hwmon/pmbus/mp2869.c
+F:	drivers/hwmon/pmbus/mp29502.c
+
 MONOLITHIC POWER SYSTEM PMIC DRIVER
 M:	Saravanan Sekar <sravanhome@gmail.com>
 S:	Maintained
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 441f984a859d..d0bdd1b5feb6 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -364,6 +364,15 @@ config SENSORS_MP2856
 	  This driver can also be built as a module. If so, the module will
 	  be called mp2856.
 
+config SENSORS_MP2869
+	tristate "MPS MP2869"
+	help
+	  If you say yes here you get hardware monitoring support for MPS
+	  MP2869 Dual Loop Digital Multi-Phase Controller.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called mp2869.
+
 config SENSORS_MP2888
 	tristate "MPS MP2888"
 	help
@@ -382,6 +391,15 @@ config SENSORS_MP2891
       This driver can also be built as a module. If so, the module will
       be called mp2891.
 
+config SENSORS_MP29502
+	tristate "MPS MP29502"
+	help
+	  If you say yes here you get hardware monitoring support for MPS
+	  MP29502 Dual Loop Digital Multi-Phase Controller.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called mp29502.
+
 config SENSORS_MP2975
 	tristate "MPS MP2975"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 29cd8a3317d2..4c5ff3f32c5e 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -37,8 +37,10 @@ obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
 obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
 obj-$(CONFIG_SENSORS_MP2856)	+= mp2856.o
+obj-$(CONFIG_SENSORS_MP2869)	+= mp2869.o
 obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
 obj-$(CONFIG_SENSORS_MP2891)	+= mp2891.o
+obj-$(CONFIG_SENSORS_MP29502)	+= mp29502.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
 obj-$(CONFIG_SENSORS_MP2993)	+= mp2993.o
 obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
diff --git a/drivers/hwmon/pmbus/mp2869.c b/drivers/hwmon/pmbus/mp2869.c
new file mode 100644
index 000000000000..af233ffd5230
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp2869.c
@@ -0,0 +1,711 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hardware monitoring driver for MPS Multi-phase Digital VR Controllers(MP2869)
+ */
+
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include "pmbus.h"
+
+#define MFR_READ_PIN_EST	0x94
+#define MFR_READ_IIN_EST	0x95
+#define MFR_VOUT_SCALE_LOOP	0x29
+#define MFR_SVI3_IOUT_PRT	0x67
+#define STATUS_MFR_SPECIFIC	0x80
+#define MFR_CUR_GAIN	0xB5
+#define MFR_TSNS_FLT_SET	0xBB
+
+#define MP2869_VIN_OV_FAULT_GAIN	4
+#define MP2869_READ_VOUT_DIV	1024
+#define MP2869_READ_IOUT_DIV	32
+#define MP2869_OVUV_LIMIT_SCALE	10
+#define MP2869_OVUV_DELTA_SCALE	50
+#define MP2869_TEMP_LIMIT_OFFSET	40
+#define MP2869_IOUT_LIMIT_UINT	8
+#define MP2869_POUT_OP_GAIN	2
+
+#define MP2869_PAGE_NUM	2
+
+#define MP2869_RAIL1_FUNC	(PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | \
+							PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT | \
+							PMBUS_HAVE_TEMP | PMBUS_HAVE_PIN | \
+							PMBUS_HAVE_IIN | \
+							PMBUS_HAVE_STATUS_VOUT | \
+							PMBUS_HAVE_STATUS_IOUT | \
+							PMBUS_HAVE_STATUS_TEMP | \
+							PMBUS_HAVE_STATUS_INPUT)
+
+#define MP2869_RAIL2_FUNC	(PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | \
+							 PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP | \
+							 PMBUS_HAVE_PIN | PMBUS_HAVE_IIN | \
+							 PMBUS_HAVE_STATUS_VOUT | \
+							 PMBUS_HAVE_STATUS_IOUT | \
+							 PMBUS_HAVE_STATUS_TEMP | \
+							 PMBUS_HAVE_STATUS_INPUT)
+
+enum chips {mp2869, mp29608, mp29612, mp29816};
+
+struct mp2869_data {
+	struct pmbus_driver_info info;
+	bool mfr_thwn_flt_en;
+	int vout_scale[MP2869_PAGE_NUM];
+	int iout_scale[MP2869_PAGE_NUM];
+};
+
+#define to_mp2869_data(x)	container_of(x, struct mp2869_data, info)
+
+static u16 mp2869_reg2data_linear11(u16 word)
+{
+	s16 exponent;
+	s32 mantissa;
+	s64 val;
+
+	exponent = ((s16)word) >> 11;
+	mantissa = ((s16)((word & 0x7ff) << 5)) >> 5;
+	val = mantissa;
+
+	if (exponent >= 0)
+		val <<= exponent;
+	else
+		val >>= -exponent;
+
+	return val;
+}
+
+static int
+mp2869_identify_thwn_flt(struct i2c_client *client, struct pmbus_driver_info *info,
+			 int page)
+{
+	struct mp2869_data *data = to_mp2869_data(info);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, MFR_TSNS_FLT_SET);
+	if (ret < 0)
+		return ret;
+
+	if (FIELD_GET(GENMASK(13, 13), ret))
+		data->mfr_thwn_flt_en = true;
+	else
+		data->mfr_thwn_flt_en = false;
+
+	return 0;
+}
+
+static int
+mp2869_identify_vout_scale(struct i2c_client *client, struct pmbus_driver_info *info,
+			   int page)
+{
+	struct mp2869_data *data = to_mp2869_data(info);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, MFR_VOUT_SCALE_LOOP);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The output voltage is equal to the READ_VOUT(0x8B) register value multiply
+	 * by vout_scale.
+	 * Obtain vout scale from the register MFR_VOUT_SCALE_LOOP, bits 12-10
+	 * MFR_VOUT_SCALE_LOOP[12:10]:
+	 * 000b - 6.25mV/LSB, 001b - 5mV/LSB, 010b - 2.5mV/LSB, 011b - 2mV/LSB
+	 * 100b - 1mV/Lsb, 101b - (1/256)mV/LSB, 110b - (1/512)mV/LSB,
+	 * 111b - (1/1024)mV/LSB
+	 */
+	switch (FIELD_GET(GENMASK(12, 10), ret)) {
+	case 0:
+		data->vout_scale[page] = 6400;
+		break;
+	case 1:
+		data->vout_scale[page] = 5120;
+		break;
+	case 2:
+		data->vout_scale[page] = 2560;
+		break;
+	case 3:
+		data->vout_scale[page] = 2048;
+		break;
+	case 4:
+		data->vout_scale[page] = 1024;
+		break;
+	case 5:
+		data->vout_scale[page] = 4;
+		break;
+	case 6:
+		data->vout_scale[page] = 2;
+		break;
+	case 7:
+		data->vout_scale[page] = 1;
+		break;
+	default:
+		data->vout_scale[page] = 1;
+		break;
+	}
+
+	return 0;
+}
+
+static int
+mp2869_identify_iout_scale(struct i2c_client *client, struct pmbus_driver_info *info,
+			   int page)
+{
+	struct mp2869_data *data = to_mp2869_data(info);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, MFR_SVI3_IOUT_PRT);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The output current is equal to the READ_IOUT(0x8C) register value
+	 * multiply by iout_scale.
+	 * Obtain iout_scale from the register MFR_SVI3_IOUT_PRT[2:0].
+	 * The value is selected as below:
+	 * 000b - 1A/LSB, 001b - (1/32)A/LSB, 010b - (1/16)A/LSB,
+	 * 011b - (1/8)A/LSB, 100b - (1/4)A/LSB, 101b - (1/2)A/LSB
+	 * 110b - 1A/LSB, 111b - 2A/LSB
+	 */
+	switch (ret & GENMASK(2, 0)) {
+	case 0:
+	case 6:
+		data->iout_scale[page] = 32;
+		break;
+	case 1:
+		data->iout_scale[page] = 1;
+		break;
+	case 2:
+		data->iout_scale[page] = 2;
+		break;
+	case 3:
+		data->iout_scale[page] = 4;
+		break;
+	case 4:
+		data->iout_scale[page] = 8;
+		break;
+	case 5:
+		data->iout_scale[page] = 16;
+		break;
+	default:
+		data->iout_scale[page] = 64;
+		break;
+	}
+
+	return 0;
+}
+
+static int mp2869_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp2869_data *data = to_mp2869_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VOUT_MODE:
+		/*
+		 * The calculation of vout in this driver is based on direct format.
+		 * As a result, the format of vout is enforced to direct.
+		 */
+		ret = PB_VOUT_MODE_DIRECT;
+		break;
+	case PMBUS_STATUS_BYTE:
+		/*
+		 * If the tsns digital fault is enabled, the TEMPERATURE flag
+		 * of PMBUS_STATUS_BYTE should come from STATUS_MFR_SPECIFIC
+		 * register bit1.
+		 */
+		if (data->mfr_thwn_flt_en) {
+			ret = pmbus_read_byte_data(client, page, reg);
+			if (ret < 0)
+				return ret;
+
+			ret = (ret & ~GENMASK(2, 2)) |
+				FIELD_PREP(GENMASK(2, 2),
+					   FIELD_GET(GENMASK(1, 1),
+						     pmbus_read_byte_data(client, page,
+									  STATUS_MFR_SPECIFIC)));
+		} else {
+			ret = -ENODATA;
+		}
+		break;
+	case PMBUS_STATUS_TEMPERATURE:
+		/*
+		 * If the tsns digital fault is enabled, the OT Fault and OT Warning
+		 * flag of PMBUS_STATUS_TEMPERATURE should come from STATUS_MFR_SPECIFIC
+		 * register bit1.
+		 */
+		if (data->mfr_thwn_flt_en) {
+			ret = pmbus_read_byte_data(client, page, reg);
+			if (ret < 0)
+				return ret;
+
+			ret = (ret & ~GENMASK(7, 6)) |
+				FIELD_PREP(GENMASK(6, 6),
+					   FIELD_GET(GENMASK(1, 1),
+						     pmbus_read_byte_data(client, page,
+									  STATUS_MFR_SPECIFIC))) |
+				FIELD_PREP(GENMASK(7, 7),
+					   FIELD_GET(GENMASK(1, 1),
+						     pmbus_read_byte_data(client, page,
+									  STATUS_MFR_SPECIFIC)));
+		} else {
+			ret = -ENODATA;
+		}
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+
+	return ret;
+}
+
+static int mp2869_read_word_data(struct i2c_client *client, int page, int phase,
+				 int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp2869_data *data = to_mp2869_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_STATUS_WORD:
+		/*
+		 * If the tsns digital fault is enabled, the OT Fault flag
+		 * of PMBUS_STATUS_WORD should come from STATUS_MFR_SPECIFIC
+		 * register bit1.
+		 */
+		if (data->mfr_thwn_flt_en) {
+			ret = pmbus_read_word_data(client, page, phase, reg);
+			if (ret < 0)
+				return ret;
+
+			ret = (ret & ~GENMASK(2, 2)) |
+				FIELD_PREP(GENMASK(2, 2),
+					   FIELD_GET(GENMASK(1, 1),
+						     pmbus_read_byte_data(client, page,
+									  STATUS_MFR_SPECIFIC)));
+		} else {
+			ret = -ENODATA;
+		}
+		break;
+	case PMBUS_READ_VIN:
+		/*
+		 * The MP2869 PMBUS_READ_VIN[10:0] is the vin value, the vin scale is
+		 * 31.25mV/LSB. And the vin scale is set to 31.25mV/Lsb(using r/m/b scale)
+		 * in MP2869 pmbus_driver_info struct, so the word data bit0-bit10 can be
+		 * returned to pmbus core directly.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = FIELD_GET(GENMASK(10, 0), ret);
+		break;
+	case PMBUS_READ_IIN:
+		/*
+		 * The MP2869 redefine the standard 0x95 register as iin telemetry
+		 * per rail.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, MFR_READ_IIN_EST);
+		if (ret < 0)
+			return ret;
+
+		break;
+	case PMBUS_READ_PIN:
+		/*
+		 * The MP2869 redefine the standard 0x94 register as pin telemetry
+		 * per rail. The MP2869 MFR_READ_PIN_EST register is linear11 format,
+		 * but the pin scale is set to 1W/Lsb(using r/m/b scale). As a result,
+		 * the pin read from MP2869 should be converted to W, then return
+		 * the result to pmbus core.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, MFR_READ_PIN_EST);
+		if (ret < 0)
+			return ret;
+
+		ret = mp2869_reg2data_linear11(ret);
+		break;
+	case PMBUS_READ_VOUT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST((ret &  GENMASK(11, 0)) * data->vout_scale[page],
+					MP2869_READ_VOUT_DIV);
+		break;
+	case PMBUS_READ_IOUT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST((ret & GENMASK(10, 0)) * data->iout_scale[page],
+					MP2869_READ_IOUT_DIV);
+		break;
+	case PMBUS_READ_POUT:
+		/*
+		 * The MP2869 PMBUS_READ_POUT register is linear11 format, but the pout
+		 * scale is set to 1W/Lsb(using r/m/b scale). As a result, the pout read
+		 * from MP2869 should be converted to W, then return the result to pmbus
+		 * core.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = mp2869_reg2data_linear11(ret);
+		break;
+	case PMBUS_READ_TEMPERATURE_1:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = FIELD_GET(GENMASK(10, 0), ret);
+		break;
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		if (FIELD_GET(GENMASK(12, 9), ret))
+			ret = FIELD_GET(GENMASK(8, 0), ret) * MP2869_OVUV_LIMIT_SCALE +
+				(FIELD_GET(GENMASK(12, 9), ret) + 1) * MP2869_OVUV_DELTA_SCALE;
+		else
+			ret = FIELD_GET(GENMASK(8, 0), ret) * MP2869_OVUV_LIMIT_SCALE;
+		break;
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		if (FIELD_GET(GENMASK(12, 9), ret))
+			ret = FIELD_GET(GENMASK(8, 0), ret) * MP2869_OVUV_LIMIT_SCALE -
+				(FIELD_GET(GENMASK(12, 9), ret) + 1) * MP2869_OVUV_DELTA_SCALE;
+		else
+			ret = FIELD_GET(GENMASK(8, 0), ret) * MP2869_OVUV_LIMIT_SCALE;
+
+		ret = ret < 0 ? 0 : ret;
+		break;
+	case PMBUS_OT_FAULT_LIMIT:
+	case PMBUS_OT_WARN_LIMIT:
+		/*
+		 * The scale of MP2869 PMBUS_OT_FAULT_LIMIT and PMBUS_OT_WARN_LIMIT
+		 * is 1°C/LSB and they have 40°C offset.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = (ret & GENMASK(7, 0)) - MP2869_TEMP_LIMIT_OFFSET;
+		break;
+	case PMBUS_VIN_OV_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = (ret & GENMASK(7, 0)) * MP2869_VIN_OV_FAULT_GAIN;
+		break;
+	case PMBUS_VIN_UV_WARN_LIMIT:
+	case PMBUS_VIN_UV_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = FIELD_GET(GENMASK(9, 0), ret);
+		break;
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_WARN_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST((ret & GENMASK(7, 0)) * data->iout_scale[page] *
+						MP2869_IOUT_LIMIT_UINT, MP2869_READ_IOUT_DIV);
+		break;
+	case PMBUS_POUT_OP_WARN_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = (ret & GENMASK(7, 0)) * MP2869_POUT_OP_GAIN;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int mp2869_write_word_data(struct i2c_client *client, int page, int reg,
+				  u16 word)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp2869_data *data = to_mp2869_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+		/*
+		 * The MP2869 PMBUS_VOUT_UV_FAULT_LIMIT[8:0] is the limit value,
+		 * and bit9-bit15 should not be changed.
+		 */
+		ret = pmbus_read_word_data(client, page, 0xff, reg);
+		if (ret < 0)
+			return ret;
+
+		if (FIELD_GET(GENMASK(12, 9), ret))
+			ret = pmbus_write_word_data(client, page, reg,
+						    (ret & ~GENMASK(8, 0)) |
+				FIELD_PREP(GENMASK(8, 0),
+					   DIV_ROUND_CLOSEST(word +
+						(FIELD_GET(GENMASK(12, 9),
+						ret) + 1) *
+					MP2869_OVUV_DELTA_SCALE,
+					MP2869_OVUV_LIMIT_SCALE)));
+		else
+			ret = pmbus_write_word_data(client, page, reg,
+						    (ret & ~GENMASK(8, 0)) |
+					FIELD_PREP(GENMASK(8, 0),
+						   DIV_ROUND_CLOSEST(word,
+								     MP2869_OVUV_LIMIT_SCALE)));
+		break;
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+		/*
+		 * The MP2869 PMBUS_VOUT_OV_FAULT_LIMIT[8:0] is the limit value,
+		 * and bit9-bit15 should not be changed.
+		 */
+		ret = pmbus_read_word_data(client, page, 0xff, reg);
+		if (ret < 0)
+			return ret;
+
+		if (FIELD_GET(GENMASK(12, 9), ret))
+			ret = pmbus_write_word_data(client, page, reg,
+						    (ret & ~GENMASK(8, 0)) |
+				FIELD_PREP(GENMASK(8, 0),
+					   DIV_ROUND_CLOSEST(word -
+							(FIELD_GET(GENMASK(12, 9),
+							ret) + 1) *
+						MP2869_OVUV_DELTA_SCALE,
+						MP2869_OVUV_LIMIT_SCALE)));
+		else
+			ret = pmbus_write_word_data(client, page, reg,
+						    (ret & ~GENMASK(8, 0)) |
+				FIELD_PREP(GENMASK(8, 0),
+					   DIV_ROUND_CLOSEST(word,
+							     MP2869_OVUV_LIMIT_SCALE)));
+		break;
+	case PMBUS_OT_FAULT_LIMIT:
+	case PMBUS_OT_WARN_LIMIT:
+		/*
+		 * If the tsns digital fault is enabled, the PMBUS_OT_FAULT_LIMIT and
+		 * PMBUS_OT_WARN_LIMIT can not be written.
+		 */
+		if (data->mfr_thwn_flt_en) {
+			ret = -EINVAL;
+		} else {
+			/*
+			 * The MP2869 scale of MP2869 PMBUS_OT_FAULT_LIMIT and PMBUS_OT_WARN_LIMIT
+			 * have 40°C offset. The bit0-bit7 is the limit value, and bit8-bit15
+			 * should not be changed.
+			 */
+			ret = pmbus_read_word_data(client, page, 0xff, reg);
+			if (ret < 0)
+				return ret;
+
+			ret = pmbus_write_word_data(client, page, reg,
+						    (ret & ~GENMASK(7, 0)) |
+						 FIELD_PREP(GENMASK(7, 0),
+							    word + MP2869_TEMP_LIMIT_OFFSET));
+		}
+		break;
+	case PMBUS_VIN_OV_FAULT_LIMIT:
+		/*
+		 * The MP2869 PMBUS_VIN_OV_FAULT_LIMIT[7:0] is the limit value, and bit8-bit15
+		 * should not be changed. The scale of PMBUS_VIN_OV_FAULT_LIMIT is 125mV/Lsb,
+		 * but the vin scale is set to 31.25mV/Lsb(using r/m/b scale), so the word data
+		 * should divide by MP2869_VIN_OV_FAULT_GAIN(4)
+		 */
+		ret = pmbus_read_word_data(client, page, 0xff, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = pmbus_write_word_data(client, page, reg,
+					    (ret & ~GENMASK(7, 0)) |
+					FIELD_PREP(GENMASK(7, 0),
+						   DIV_ROUND_CLOSEST(word,
+								     MP2869_VIN_OV_FAULT_GAIN)));
+		break;
+	case PMBUS_VIN_UV_WARN_LIMIT:
+	case PMBUS_VIN_UV_FAULT_LIMIT:
+		/*
+		 * The PMBUS_VIN_UV_LIMIT[9:0] is the limit value, and bit10-bit15 should
+		 * not be changed. The scale of PMBUS_VIN_UV_LIMIT is 31.25mV/Lsb, and the
+		 * vin scale is set to 31.25mV/Lsb(using r/m/b scale), so the word data can
+		 * be written directly.
+		 */
+		ret = pmbus_read_word_data(client, page, 0xff, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = pmbus_write_word_data(client, page, reg,
+					    (ret & ~GENMASK(9, 0)) |
+						FIELD_PREP(GENMASK(9, 0),
+							   word));
+		break;
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_WARN_LIMIT:
+		ret = pmbus_write_word_data(client, page, reg,
+					    DIV_ROUND_CLOSEST(word *
+									MP2869_READ_IOUT_DIV,
+						    MP2869_IOUT_LIMIT_UINT *
+							data->iout_scale[page]));
+		break;
+	case PMBUS_POUT_OP_WARN_LIMIT:
+		/*
+		 * The POUT_OP_WARN_LIMIT[11:0] is the limit value, and bit12-bit15 should
+		 * not be changed. The scale of POUT_OP_WARN_LIMIT is 2W/Lsb.
+		 */
+		ret = pmbus_read_word_data(client, page, 0xff, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = pmbus_write_word_data(client, page, reg,
+					    (ret & ~GENMASK(11, 0)) |
+					FIELD_PREP(GENMASK(11, 0),
+						   DIV_ROUND_CLOSEST(word,
+								     MP2869_POUT_OP_GAIN)));
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int mp2869_identify(struct i2c_client *client, struct pmbus_driver_info *info)
+{
+	int ret;
+
+	/* Identify whether tsns digital fault is enable */
+	ret = mp2869_identify_thwn_flt(client, info, 1);
+	if (ret < 0)
+		return 0;
+
+	/* Identify vout scale for rail1. */
+	ret = mp2869_identify_vout_scale(client, info, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Identify vout scale for rail2. */
+	ret = mp2869_identify_vout_scale(client, info, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Identify iout scale for rail 1. */
+	ret = mp2869_identify_iout_scale(client, info, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Identify iout scale for rail 2. */
+	return mp2869_identify_iout_scale(client, info, 1);
+}
+
+static const struct pmbus_driver_info mp2869_info = {
+	.pages = MP2869_PAGE_NUM,
+	.format[PSC_VOLTAGE_IN] = direct,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_CURRENT_OUT] = direct,
+	.format[PSC_TEMPERATURE] = direct,
+	.format[PSC_POWER] = direct,
+	.format[PSC_VOLTAGE_OUT] = direct,
+
+	.m[PSC_VOLTAGE_IN] = 32,
+	.R[PSC_VOLTAGE_IN] = 0,
+	.b[PSC_VOLTAGE_IN] = 0,
+
+	.m[PSC_VOLTAGE_OUT] = 1,
+	.R[PSC_VOLTAGE_OUT] = 3,
+	.b[PSC_VOLTAGE_OUT] = 0,
+
+	.m[PSC_CURRENT_OUT] = 1,
+	.R[PSC_CURRENT_OUT] = 0,
+	.b[PSC_CURRENT_OUT] = 0,
+
+	.m[PSC_TEMPERATURE] = 1,
+	.R[PSC_TEMPERATURE] = 0,
+	.b[PSC_TEMPERATURE] = 0,
+
+	.m[PSC_POWER] = 1,
+	.R[PSC_POWER] = 0,
+	.b[PSC_POWER] = 0,
+
+	.func[0] = MP2869_RAIL1_FUNC,
+	.func[1] = MP2869_RAIL2_FUNC,
+	.read_word_data = mp2869_read_word_data,
+	.write_word_data = mp2869_write_word_data,
+	.read_byte_data = mp2869_read_byte_data,
+	.identify = mp2869_identify,
+};
+
+static int mp2869_probe(struct i2c_client *client)
+{
+	struct pmbus_driver_info *info;
+	struct mp2869_data *data;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct mp2869_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	memcpy(&data->info, &mp2869_info, sizeof(*info));
+	info = &data->info;
+
+	return pmbus_do_probe(client, info);
+}
+
+static const struct i2c_device_id mp2869_id[] = {
+	{"mp2869", mp2869},
+	{"mp29608", mp29608},
+	{"mp29612", mp29612},
+	{"mp29816", mp29816},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mp2869_id);
+
+static const struct of_device_id __maybe_unused mp2869_of_match[] = {
+	{.compatible = "mps,mp2869", .data = (void *)mp2869},
+	{.compatible = "mps,mp29608", .data = (void *)mp29608},
+	{.compatible = "mps,mp29612", .data = (void *)mp29612},
+	{.compatible = "mps,mp29816", .data = (void *)mp29816},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mp2869_of_match);
+
+static struct i2c_driver mp2869_driver = {
+	.driver = {
+		.name = "mp2869",
+		.of_match_table = mp2869_of_match,
+	},
+	.probe = mp2869_probe,
+	.id_table = mp2869_id,
+};
+
+module_i2c_driver(mp2869_driver);
+
+MODULE_AUTHOR("Wensheng Wang <wenswang@yeah.net>");
+MODULE_DESCRIPTION("PMBus driver for MPS MP2869");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("PMBUS");
diff --git a/drivers/hwmon/pmbus/mp29502.c b/drivers/hwmon/pmbus/mp29502.c
new file mode 100644
index 000000000000..7241373f1557
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp29502.c
@@ -0,0 +1,670 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hardware monitoring driver for MPS Multi-phase Digital VR Controllers(MP29502)
+ */
+
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include "pmbus.h"
+
+#define MFR_VOUT_SCALE_LOOP	0x29
+#define MFR_SVI3_IOUT_PRT	0x67
+#define MFR_READ_PIN_EST	0x94
+#define MFR_READ_IIN_EST	0x95
+#define MFR_VOUT_PROT1	0x3D
+#define MFR_VOUT_PROT2	0x51
+#define MFR_SLOPE_CNT_SET	0xA8
+#define MFR_TSNS_FLT_SET	0xBB
+
+#define MP29502_VIN_OV_GAIN	4
+#define MP29502_TEMP_LIMIT_OFFSET	40
+#define MP29502_READ_VOUT_DIV	1024
+#define MP29502_READ_IOUT_DIV	32
+#define MP29502_IOUT_LIMIT_UINT	8
+#define MP29502_OVUV_LIMIT_SCALE	10
+#define MP28502_VOUT_OV_GAIN	512
+#define MP28502_VOUT_OV_SCALE	40
+#define MP29502_VOUT_UV_OFFSET	36
+#define MP29502_PIN_GAIN	2
+#define MP29502_IIN_DIV	2
+
+#define MP29502_PAGE_NUM	1
+
+#define MP29502_RAIL_FUNC	(PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | \
+							PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT | \
+							PMBUS_HAVE_TEMP | PMBUS_HAVE_PIN | \
+							PMBUS_HAVE_IIN | \
+							PMBUS_HAVE_STATUS_VOUT | \
+							PMBUS_HAVE_STATUS_IOUT | \
+							PMBUS_HAVE_STATUS_TEMP | \
+							PMBUS_HAVE_STATUS_INPUT)
+
+struct mp29502_data {
+	struct pmbus_driver_info info;
+	int vout_scale;
+	int vout_bottom_div;
+	int vout_top_div;
+	int ovp_div;
+	int iout_scale;
+};
+
+#define to_mp29502_data(x)	container_of(x, struct mp29502_data, info)
+
+static u16 mp29502_reg2data_linear11(u16 word)
+{
+	s16 exponent;
+	s32 mantissa;
+	s64 val;
+
+	exponent = ((s16)word) >> 11;
+	mantissa = ((s16)((word & 0x7ff) << 5)) >> 5;
+	val = mantissa;
+
+	if (exponent >= 0)
+		val <<= exponent;
+	else
+		val >>= -exponent;
+
+	return val;
+}
+
+static int
+mp29502_identify_vout_scale(struct i2c_client *client, struct pmbus_driver_info *info,
+			    int page)
+{
+	struct mp29502_data *data = to_mp29502_data(info);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, MFR_VOUT_SCALE_LOOP);
+	if (ret < 0)
+		return ret;
+
+	switch (FIELD_GET(GENMASK(12, 10), ret)) {
+	case 0:
+		data->vout_scale = 6400;
+		break;
+	case 1:
+		data->vout_scale = 5120;
+		break;
+	case 2:
+		data->vout_scale = 2560;
+		break;
+	case 3:
+		data->vout_scale = 2048;
+		break;
+	case 4:
+		data->vout_scale = 1024;
+		break;
+	case 5:
+		data->vout_scale = 4;
+		break;
+	case 6:
+		data->vout_scale = 2;
+		break;
+	case 7:
+		data->vout_scale = 1;
+		break;
+	default:
+		data->vout_scale = 1;
+		break;
+	}
+
+	return 0;
+}
+
+static int
+mp29502_identify_vout_divider(struct i2c_client *client, struct pmbus_driver_info *info,
+			      int page)
+{
+	struct mp29502_data *data = to_mp29502_data(info);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, MFR_VOUT_PROT1);
+	if (ret < 0)
+		return ret;
+
+	data->vout_bottom_div = FIELD_GET(GENMASK(11, 0), ret);
+
+	ret = i2c_smbus_read_word_data(client, MFR_VOUT_PROT2);
+	if (ret < 0)
+		return ret;
+
+	data->vout_top_div = FIELD_GET(GENMASK(14, 0), ret);
+
+	return 0;
+}
+
+static int
+mp29502_identify_ovp_divider(struct i2c_client *client, struct pmbus_driver_info *info,
+			     int page)
+{
+	struct mp29502_data *data = to_mp29502_data(info);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, MFR_SLOPE_CNT_SET);
+	if (ret < 0)
+		return ret;
+
+	data->ovp_div = FIELD_GET(GENMASK(9, 0), ret);
+
+	return 0;
+}
+
+static int
+mp29502_identify_iout_scale(struct i2c_client *client, struct pmbus_driver_info *info,
+			    int page)
+{
+	struct mp29502_data *data = to_mp29502_data(info);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, MFR_SVI3_IOUT_PRT);
+	if (ret < 0)
+		return ret;
+
+	switch (ret & GENMASK(2, 0)) {
+	case 0:
+	case 6:
+		data->iout_scale = 32;
+		break;
+	case 1:
+		data->iout_scale = 1;
+		break;
+	case 2:
+		data->iout_scale = 2;
+		break;
+	case 3:
+		data->iout_scale = 4;
+		break;
+	case 4:
+		data->iout_scale = 8;
+		break;
+	case 5:
+		data->iout_scale = 16;
+		break;
+	default:
+		data->iout_scale = 64;
+		break;
+	}
+
+	return 0;
+}
+
+static int mp29502_read_vout_ov_limit(struct i2c_client *client, struct mp29502_data *data)
+{
+	int ret;
+	int ov_value;
+
+	/*
+	 * This is because the vout ov fault limit value comes from
+	 * page1 MFR_TSNS_FLT_SET reg, and other telemetry and limit
+	 * value comes from page0 reg. So the page should be set to
+	 * 0 after the reading of vout ov limit.
+	 */
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, MFR_TSNS_FLT_SET);
+	if (ret < 0)
+		return ret;
+
+	ov_value = DIV_ROUND_CLOSEST(FIELD_GET(GENMASK(12, 7), ret) *
+						   MP28502_VOUT_OV_GAIN * MP28502_VOUT_OV_SCALE,
+						   data->ovp_div);
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+	if (ret < 0)
+		return ret;
+
+	return ov_value;
+}
+
+static int mp29502_write_vout_ov_limit(struct i2c_client *client, u16 word,
+				       struct mp29502_data *data)
+{
+	int ret;
+
+	/*
+	 * This is because the vout ov fault limit value comes from
+	 * page1 MFR_TSNS_FLT_SET reg, and other telemetry and limit
+	 * value comes from page0 reg. So the page should be set to
+	 * 0 after the writing of vout ov limit.
+	 */
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, MFR_TSNS_FLT_SET);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_word_data(client, MFR_TSNS_FLT_SET,
+					(ret & ~GENMASK(12, 7)) |
+		FIELD_PREP(GENMASK(12, 7),
+			   DIV_ROUND_CLOSEST(word * data->ovp_div,
+					     MP28502_VOUT_OV_GAIN * MP28502_VOUT_OV_SCALE)));
+
+	return i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+}
+
+static int mp29502_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+	if (ret < 0)
+		return ret;
+
+	switch (reg) {
+	case PMBUS_VOUT_MODE:
+		ret = PB_VOUT_MODE_DIRECT;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+
+	return ret;
+}
+
+static int mp29502_read_word_data(struct i2c_client *client, int page,
+				  int phase, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp29502_data *data = to_mp29502_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_STATUS_WORD:
+		ret = -ENODATA;
+		break;
+	case PMBUS_READ_VIN:
+		/*
+		 * The MP29502 PMBUS_READ_VIN[10:0] is the vin value, the vin scale is
+		 * 125mV/LSB. And the vin scale is set to 125mV/Lsb(using r/m/b scale)
+		 * in MP29502 pmbus_driver_info struct, so the word data bit0-bit10 can
+		 * be returned to pmbus core directly.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = FIELD_GET(GENMASK(10, 0), ret);
+		break;
+	case PMBUS_READ_VOUT:
+		/*
+		 * The MP29502 PMBUS_READ_VOUT[11:0] is the vout value, and vout
+		 * value is calculated based on vout scale and vout divider.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST((ret &  GENMASK(11, 0)) *
+								data->vout_scale *
+								(data->vout_bottom_div +
+								4 * data->vout_top_div),
+								MP29502_READ_VOUT_DIV *
+								data->vout_bottom_div);
+		break;
+	case PMBUS_READ_IIN:
+		/*
+		 * The MP29502 MFR_READ_IIN_EST register is linear11 format, and the
+		 * exponent is not a constant value. But the iin scale is set to
+		 * 1A/Lsb(using r/m/b scale). As a result, the iin read from MP29502
+		 * should be calculated to A, then return the result to pmbus core.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, MFR_READ_IIN_EST);
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST(mp29502_reg2data_linear11(ret),
+					MP29502_IIN_DIV);
+		break;
+	case PMBUS_READ_PIN:
+		/*
+		 * The MP29502 MFR_READ_PIN_EST register is linear11 format, and the
+		 * exponent is not a constant value. But the pin scale is set to
+		 * 1W/Lsb(using r/m/b scale). As a result, the pout read from MP29502
+		 * should be calculated to W, then return the result to pmbus core.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, MFR_READ_PIN_EST);
+		if (ret < 0)
+			return ret;
+
+		ret = mp29502_reg2data_linear11(ret) * MP29502_PIN_GAIN;
+		break;
+	case PMBUS_READ_POUT:
+		/*
+		 * The MP29502 PMBUS_READ_POUT register is linear11 format, and the
+		 * exponent is not a constant value. But the pout scale is set to
+		 * 1W/Lsb(using r/m/b scale). As a result, the pout read from MP29502
+		 * should be calculated to W, then return the result to pmbus core.
+		 * And the pout is calculated based on vout divider.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST(mp29502_reg2data_linear11(ret) *
+					(data->vout_bottom_div +
+					4 * data->vout_top_div),
+					data->vout_bottom_div);
+		break;
+	case PMBUS_READ_IOUT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST((ret & GENMASK(10, 0)) * data->iout_scale,
+					MP29502_READ_IOUT_DIV);
+		break;
+	case PMBUS_READ_TEMPERATURE_1:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = FIELD_GET(GENMASK(10, 0), ret);
+		break;
+	case PMBUS_VIN_OV_FAULT_LIMIT:
+		/*
+		 * The MP29502 PMBUS_VIN_OV_FAULT_LIMIT is 500mV/Lsb, but
+		 * the vin  scale is set to 125mV/Lsb(using r/m/b scale),
+		 * so the word data should multiply by 4.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = FIELD_GET(GENMASK(7, 0), ret) * MP29502_VIN_OV_GAIN;
+		break;
+	case PMBUS_VIN_UV_WARN_LIMIT:
+	case PMBUS_VIN_UV_FAULT_LIMIT:
+		/*
+		 * The MP29502 PMBUS_VIN_UV_WARN_LIMIT and PMBUS_VIN_UV_FAULT_LIMIT
+		 * scale is 125mV/Lsb, but the vin scale is set to 125mV/Lsb(using
+		 * r/m/b scale), so the word data bit0-bit9 can be returned to pmbus
+		 * core directly.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = FIELD_GET(GENMASK(9, 0), ret);
+		break;
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+		/*
+		 * The MP29502 vout ov fault limit value comes from
+		 * page1 MFR_TSNS_FLT_SET[12:7].
+		 */
+		ret = mp29502_read_vout_ov_limit(client, data);
+		if (ret < 0)
+			return ret;
+
+		break;
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST((FIELD_GET(GENMASK(8, 0), ret) *
+								MP29502_OVUV_LIMIT_SCALE -
+								MP29502_VOUT_UV_OFFSET) *
+								(data->vout_bottom_div +
+								4 * data->vout_top_div),
+								data->vout_bottom_div);
+		break;
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_WARN_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST((ret & GENMASK(7, 0)) *
+								data->iout_scale *
+								MP29502_IOUT_LIMIT_UINT,
+								MP29502_READ_IOUT_DIV);
+		break;
+	case PMBUS_OT_FAULT_LIMIT:
+	case PMBUS_OT_WARN_LIMIT:
+		/*
+		 * The scale of MP29502 PMBUS_OT_FAULT_LIMIT and PMBUS_OT_WARN_LIMIT
+		 * is 1°C/LSB and they have 40°C offset.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = (ret & GENMASK(7, 0)) - MP29502_TEMP_LIMIT_OFFSET;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int mp29502_write_word_data(struct i2c_client *client, int page, int reg,
+				   u16 word)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp29502_data *data = to_mp29502_data(info);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+	if (ret < 0)
+		return ret;
+
+	switch (reg) {
+	case PMBUS_VIN_OV_FAULT_LIMIT:
+		/*
+		 * The PMBUS_VIN_OV_FAULT_LIMIT[7:0] is the limit value,
+		 * and bit8-bit15 should not be changed. The scale of
+		 * PMBUS_VIN_OV_FAULT_LIMIT is 500mV/Lsb, but the vin
+		 * scale is set to 125mV/Lsb(using r/m/b scale), so
+		 * the word data should divide by 4.
+		 */
+		ret = pmbus_read_word_data(client, page, 0xff, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = pmbus_write_word_data(client, page, reg,
+					    (ret & ~GENMASK(7, 0)) |
+				FIELD_PREP(GENMASK(7, 0),
+					   DIV_ROUND_CLOSEST(word,
+							     MP29502_VIN_OV_GAIN)));
+		break;
+	case PMBUS_VIN_UV_WARN_LIMIT:
+	case PMBUS_VIN_UV_FAULT_LIMIT:
+		/*
+		 * The PMBUS_VIN_UV_WARN_LIMIT[9:0] and PMBUS_VIN_UV_FAULT_LIMIT[9:0]
+		 * are the limit value, and bit10-bit15 should not be changed.
+		 */
+		ret = pmbus_read_word_data(client, page, 0xff, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = pmbus_write_word_data(client, page, reg,
+					    (ret & ~GENMASK(9, 0)) |
+							FIELD_PREP(GENMASK(9, 0),
+								   word));
+		break;
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+		ret = mp29502_write_vout_ov_limit(client, word, data);
+		if (ret < 0)
+			return ret;
+
+		break;
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, 0xff, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = pmbus_write_word_data(client, page, reg,
+					    (ret & ~GENMASK(8, 0)) |
+						FIELD_PREP(GENMASK(8, 0),
+							   DIV_ROUND_CLOSEST(word *
+									data->vout_bottom_div +
+									MP29502_VOUT_UV_OFFSET *
+									(data->vout_bottom_div +
+									4 * data->vout_top_div),
+									MP29502_OVUV_LIMIT_SCALE *
+									(data->vout_bottom_div +
+									4 * data->vout_top_div))));
+		break;
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_WARN_LIMIT:
+		ret = pmbus_write_word_data(client, page, reg,
+					    DIV_ROUND_CLOSEST(word *
+							MP29502_READ_IOUT_DIV,
+							MP29502_IOUT_LIMIT_UINT *
+							data->iout_scale));
+		break;
+	case PMBUS_OT_FAULT_LIMIT:
+	case PMBUS_OT_WARN_LIMIT:
+		/*
+		 * The PMBUS_OT_FAULT_LIMIT[7:0] and PMBUS_OT_WARN_LIMIT[7:0]
+		 * are the limit value, and bit8-bit15 should not be changed.
+		 */
+		ret = pmbus_read_word_data(client, page, 0xff, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = pmbus_write_word_data(client, page, reg,
+					    (ret & ~GENMASK(7, 0)) |
+					FIELD_PREP(GENMASK(7, 0),
+						   word + MP29502_TEMP_LIMIT_OFFSET));
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int mp29502_identify(struct i2c_client *client, struct pmbus_driver_info *info)
+{
+	int ret;
+
+	/* Identify vout scale */
+	ret = mp29502_identify_vout_scale(client, info, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Identify vout divider. */
+	ret = mp29502_identify_vout_divider(client, info, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Identify ovp divider. */
+	ret = mp29502_identify_ovp_divider(client, info, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Identify iout scale */
+	return mp29502_identify_iout_scale(client, info, 0);
+}
+
+static const struct pmbus_driver_info mp29502_info = {
+	.pages = MP29502_PAGE_NUM,
+	.format[PSC_VOLTAGE_IN] = direct,
+	.format[PSC_TEMPERATURE] = direct,
+	.format[PSC_CURRENT_IN] = direct,
+	.format[PSC_CURRENT_OUT] = direct,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_POWER] = direct,
+
+	.m[PSC_VOLTAGE_IN] = 8,
+	.R[PSC_VOLTAGE_IN] = 0,
+	.b[PSC_VOLTAGE_IN] = 0,
+
+	.m[PSC_VOLTAGE_OUT] = 1,
+	.R[PSC_VOLTAGE_OUT] = 3,
+	.b[PSC_VOLTAGE_OUT] = 0,
+
+	.m[PSC_TEMPERATURE] = 1,
+	.R[PSC_TEMPERATURE] = 0,
+	.b[PSC_TEMPERATURE] = 0,
+
+	.m[PSC_CURRENT_IN] = 1,
+	.R[PSC_CURRENT_IN] = 0,
+	.b[PSC_CURRENT_IN] = 0,
+
+	.m[PSC_CURRENT_OUT] = 1,
+	.R[PSC_CURRENT_OUT] = 0,
+	.b[PSC_CURRENT_OUT] = 0,
+
+	.m[PSC_POWER] = 1,
+	.R[PSC_POWER] = 0,
+	.b[PSC_POWER] = 0,
+
+	.func[0] = MP29502_RAIL_FUNC,
+	.read_word_data = mp29502_read_word_data,
+	.read_byte_data = mp29502_read_byte_data,
+	.write_word_data = mp29502_write_word_data,
+	.identify = mp29502_identify,
+};
+
+static int mp29502_probe(struct i2c_client *client)
+{
+	struct pmbus_driver_info *info;
+	struct mp29502_data *data;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct mp29502_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	memcpy(&data->info, &mp29502_info, sizeof(*info));
+	info = &data->info;
+
+	return pmbus_do_probe(client, info);
+}
+
+static const struct i2c_device_id mp29502_id[] = {
+	{"mp29502", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mp29502_id);
+
+static const struct of_device_id __maybe_unused mp29502_of_match[] = {
+	{.compatible = "mps,mp29502"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mp29502_of_match);
+
+static struct i2c_driver mp29502_driver = {
+	.driver = {
+		.name = "mp29502",
+		.of_match_table = mp29502_of_match,
+	},
+	.probe = mp29502_probe,
+	.id_table = mp29502_id,
+};
+
+module_i2c_driver(mp29502_driver);
+
+MODULE_AUTHOR("Wensheng Wang <wenswang@yeah.net");
+MODULE_DESCRIPTION("PMBus driver for MPS MP29502");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("PMBUS");
-- 
2.25.1


