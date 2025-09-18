Return-Path: <linux-kernel+bounces-756266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA07B1B212
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8028A189D783
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3466323C397;
	Tue,  5 Aug 2025 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="TwPFkMb0"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39D2E36FE;
	Tue,  5 Aug 2025 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389898; cv=none; b=af3aXfdWMo1I2+yYjcHmk0Nj7uO8ih+aYARUkkmrikcq004xqsliUVEvfL6+jpiRv6cvz9u060sAGw/nI5jgTsQMlPzLavlG5YuXH/xd+NzaNAvalW6eYyI7VZvWqCmQM6sZaO6rvN/sKuG6olPWDL0hi0uv58Vg0d+7T8rch9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389898; c=relaxed/simple;
	bh=VX73fvAX2C/Nkhl8kyhA5FeexCFZrZoO6BABxvPNWpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRsV1yHzogOQGnzRoFH0OxGIU/Ozlz0iOaYhzp57bnNvN0oMls6q82cHPRTDheM5RS54WUwc5tTJiIPzYBU1b8DlV5Z1yqf50ONaaE0jHXrQiTo7ObhaGQdjBMgjbwKwJ/c8u1hnt/uDLKQ+b8JsjP6WJn6TDdzH76zf7nxKR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=TwPFkMb0; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=NkDraYLWy/wNeKb1r3e5Ne5PVWfrK3rmr1BEPfRl0NA=;
	b=TwPFkMb0zL9KlqaHgbjl1m/SXyGBIpTUK653kPItivWFN4IuSyX1fVNV9JNz7W
	/jcBdMG3UD3C/VQf7JItnBd0H6nLSTExdAc/BtZqYzon0alo0+6+TiQWnhBq9UC+
	a+NGXKeNS/YeCqRNqrSTcgufBHI0r4D6bF5sMtmJTZsCI=
Received: from mps-HP-EliteBook-840-G3.monolithicpower.com (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCnDwTm2pFoQFEdAg--.18285S3;
	Tue, 05 Aug 2025 18:20:25 +0800 (CST)
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
Subject: [PATCH v5 2/3] hwmon: add MP2869,MP29608,MP29612 and MP29816 series driver
Date: Tue,  5 Aug 2025 18:20:19 +0800
Message-Id: <20250805102020.749850-2-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250805102020.749850-1-wenswang@yeah.net>
References: <20250805101754.749492-1-wenswang@yeah.net>
 <20250805102020.749850-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgCnDwTm2pFoQFEdAg--.18285S3
X-Coremail-Antispam: 1Uf129KBjvAXoWfZFWDKF48ZF4rtr48Xr1UJrb_yoW5Jr4Duo
	Z5Wa98Zw1Utw1UCFWkKF4IqFyxXF1UGFWvya1aya9xWry7Ar45Ka93Aw4ava47ta1fXw1x
	uaykA3s3tay7ZF17n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUODGOUUUUU
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiAR+gpGiRnayuvwAAsD

From: Wensheng Wang <wenswang@yeah.net>

Add support for MPS VR mp2869/mp2869a,mp29608/mp29608a,mp29612/mp29612a
and mp29816/mp29816a/mp29816b/mp29816c controller. This driver exposes
telemetry and limit value readings and writtings.

Signed-off-by: Wensheng Wang <wenswang@yeah.net>
---
V4 -> V5:
    1. modify the syntax of mp2869 driver code

V3 -> V4:
    1. split patches for MP2869,mp29608,mp29612,mp29816,mp29502
    2. add description for vender specific registers

V2 -> V3:
    merge patches for MP2869,mp29608,mp29612,mp29816,mp29502

V1 -> V2:
    add Rob's Acked-by

 Documentation/hwmon/index.rst  |   1 +
 Documentation/hwmon/mp2869.rst | 175 +++++++++
 MAINTAINERS                    |   7 +
 drivers/hwmon/pmbus/Kconfig    |   9 +
 drivers/hwmon/pmbus/Makefile   |   1 +
 drivers/hwmon/pmbus/mp2869.c   | 659 +++++++++++++++++++++++++++++++++
 6 files changed, 852 insertions(+)
 create mode 100644 Documentation/hwmon/mp2869.rst
 create mode 100644 drivers/hwmon/pmbus/mp2869.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index d292a86ac5da..36303148dc43 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -173,6 +173,7 @@ Hardware Monitoring Kernel Drivers
    menf21bmc
    mlxreg-fan
    mp2856
+   mp2869
    mp2888
    mp2891
    mp2975
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 1b57dd4fcf01..061dfb97f448 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17152,6 +17152,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
 F:	drivers/video/backlight/mp3309c.c
 
+MPS MP2869 DRIVER
+M:	Wensheng Wang <wenswang@yeah.net>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/mp2869.rst
+F:	drivers/hwmon/pmbus/mp2869.c
+
 MPS MP2891 DRIVER
 M:	Noah Wang <noahwang.wang@outlook.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 55e492452ce8..976b018af859 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -373,6 +373,15 @@ config SENSORS_MP2856
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
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 29cd8a3317d2..6177047414ee 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
 obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
 obj-$(CONFIG_SENSORS_MP2856)	+= mp2856.o
+obj-$(CONFIG_SENSORS_MP2869)	+= mp2869.o
 obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
 obj-$(CONFIG_SENSORS_MP2891)	+= mp2891.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
diff --git a/drivers/hwmon/pmbus/mp2869.c b/drivers/hwmon/pmbus/mp2869.c
new file mode 100644
index 000000000000..cc69a1e91dfe
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp2869.c
@@ -0,0 +1,659 @@
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
+/*
+ * Vender specific registers, the register MFR_SVI3_IOUT_PRT(0x67),
+ * READ_PIN_EST(0x94)and READ_IIN_EST(0x95) redefine the standard
+ * PMBUS register. The MFR_VOUT_LOOP_CTRL(0x29) is used to identify
+ * the vout scale and the MFR_SVI3_IOUT_PRT(0x67) is used to identify
+ * the iout scale. The READ_PIN_EST(0x94) is used to read input power
+ * per rail. The MP2891 does not have standard READ_IIN register(0x89),
+ * the iin telemetry can be obtained through the vendor redefined
+ * register READ_IIN_EST(0x95).
+ */
+#define MFR_SVI3_IOUT_PRT	0x67
+#define MFR_READ_PIN_EST	0x94
+#define MFR_READ_IIN_EST	0x95
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
+struct mp2869_data {
+	struct pmbus_driver_info info;
+	bool mfr_thwn_flt_en;
+	int vout_scale[MP2869_PAGE_NUM];
+	int iout_scale[MP2869_PAGE_NUM];
+};
+
+static const int mp2869_vout_sacle[8] = {6400, 5120, 2560, 2048, 1024,
+										 4, 2, 1};
+static const int mp2869_iout_sacle[8] = {32, 1, 2, 4, 8, 16, 32, 64};
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
+	data->mfr_thwn_flt_en = FIELD_GET(GENMASK(13, 13), ret);
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
+	ret = i2c_smbus_read_word_data(client, PMBUS_VOUT_SCALE_LOOP);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The output voltage is equal to the READ_VOUT(0x8B) register value multiply
+	 * by vout_scale.
+	 * Obtain vout scale from the register PMBUS_VOUT_SCALE_LOOP, bits 12-10
+	 * PMBUS_VOUT_SCALE_LOOP[12:10]:
+	 * 000b - 6.25mV/LSB, 001b - 5mV/LSB, 010b - 2.5mV/LSB, 011b - 2mV/LSB
+	 * 100b - 1mV/Lsb, 101b - (1/256)mV/LSB, 110b - (1/512)mV/LSB,
+	 * 111b - (1/1024)mV/LSB
+	 */
+	data->vout_scale[page] = mp2869_vout_sacle[FIELD_GET(GENMASK(12, 10), ret)];
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
+	data->iout_scale[page] = mp2869_iout_sacle[FIELD_GET(GENMASK(2, 0), ret)];
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
+		if (!data->mfr_thwn_flt_en)
+			return -ENODATA;
+
+		ret = pmbus_read_byte_data(client, page, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = (ret & ~GENMASK(2, 2)) |
+			FIELD_PREP(GENMASK(2, 2),
+				   FIELD_GET(GENMASK(1, 1),
+					     pmbus_read_byte_data(client, page,
+								  PMBUS_STATUS_MFR_SPECIFIC)));
+		break;
+	case PMBUS_STATUS_TEMPERATURE:
+		/*
+		 * If the tsns digital fault is enabled, the OT Fault and OT Warning
+		 * flag of PMBUS_STATUS_TEMPERATURE should come from STATUS_MFR_SPECIFIC
+		 * register bit1.
+		 */
+		if (!data->mfr_thwn_flt_en)
+			return -ENODATA;
+
+		ret = pmbus_read_byte_data(client, page, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = (ret & ~GENMASK(7, 6)) |
+			FIELD_PREP(GENMASK(6, 6),
+				   FIELD_GET(GENMASK(1, 1),
+					     pmbus_read_byte_data(client, page,
+								  PMBUS_STATUS_MFR_SPECIFIC))) |
+			 FIELD_PREP(GENMASK(7, 7),
+				    FIELD_GET(GENMASK(1, 1),
+					      pmbus_read_byte_data(client, page,
+								   PMBUS_STATUS_MFR_SPECIFIC)));
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
+		if (!data->mfr_thwn_flt_en)
+			return -ENODATA;
+
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = (ret & ~GENMASK(2, 2)) |
+			 FIELD_PREP(GENMASK(2, 2),
+				    FIELD_GET(GENMASK(1, 1),
+					      pmbus_read_byte_data(client, page,
+								   PMBUS_STATUS_MFR_SPECIFIC)));
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
+		if (data->mfr_thwn_flt_en)
+			return -EINVAL;
+
+		/*
+		 * The MP2869 scale of MP2869 PMBUS_OT_FAULT_LIMIT and PMBUS_OT_WARN_LIMIT
+		 * have 40°C offset. The bit0-bit7 is the limit value, and bit8-bit15
+		 * should not be changed.
+		 */
+		ret = pmbus_read_word_data(client, page, 0xff, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = pmbus_write_word_data(client, page, reg,
+					    (ret & ~GENMASK(7, 0)) |
+					 FIELD_PREP(GENMASK(7, 0),
+						    word + MP2869_TEMP_LIMIT_OFFSET));
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
+					    DIV_ROUND_CLOSEST(word * MP2869_READ_IOUT_DIV,
+							      MP2869_IOUT_LIMIT_UINT *
+								  data->iout_scale[page]));
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
+	{"mp2869", 0},
+	{"mp29608", 1},
+	{"mp29612", 2},
+	{"mp29816", 3},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mp2869_id);
+
+static const struct of_device_id __maybe_unused mp2869_of_match[] = {
+	{.compatible = "mps,mp2869", .data = (void *)0},
+	{.compatible = "mps,mp29608", .data = (void *)1},
+	{.compatible = "mps,mp29612", .data = (void *)2},
+	{.compatible = "mps,mp29816", .data = (void *)3},
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
-- 
2.25.1


