Return-Path: <linux-kernel+bounces-701676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81901AE77C9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 09:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FD83A5DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 07:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527E81FC0F3;
	Wed, 25 Jun 2025 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="R+I9Ha5U"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F01F9F51;
	Wed, 25 Jun 2025 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750835363; cv=none; b=C8Y9QaNDyIfiEHfR2UCQRKy601YHkM4QCiYhELnDhDKhjLZR9hw200zpYFe05JsIRpoxhtx8GOENbHl4Dj3u5NYm2PMyEjpKwPvQZ40F24Cvl+MT9MsLN0QUUp5VBR6svaqr+5MjY7Hj/Qh8oyUpGWbgDzG9LJ79oVC2jse+AeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750835363; c=relaxed/simple;
	bh=gIYfVw1q3vq+QM3sU/fBJQ2zFf/LvKkQnonEaEIRgRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTnGwzPw+TlwwkBoPcEeb1Z/dIA01QZYyhPcwM6O8abAw1Q5WXrgkruEQXdLWDyIQTZUouqQyMbEyX9rSVnJwRBqh2AS7uDmREOoRqpm7igU45pTF2mHpnALNS2zYEJrU2SAPZPqP7tLfLy6uUnQ/vr8LjrQQTxMfuzqA1CjNvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=R+I9Ha5U; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=y4xREOkV8qTXv1rNTO1rrmboLIo3xYvYnzrqBYQQ5c8=;
	b=R+I9Ha5UaV2nuhbU0W4y6TkkzWomf463gucE8FmwUUncMcPa5KSsfsWT3iBefk
	oowwcuTBaxEIZxL8Ej/qXJBUlN8G8I6R6poCZKfYhFlGvGA1exQ/z+G6u+bG74ft
	peEHC8DAVaYOlXAcGTwCE1I5xl2vvTGhhzl5W8jL+r8xc=
Received: from mps-HP-EliteBook-840-G3.monolithicpower.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3F3w8oFtoI3SCAQ--.44888S3;
	Wed, 25 Jun 2025 15:07:48 +0800 (CST)
From: wenswang@yeah.net
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net
Cc: Jonathan.Cameron@huawei.com,
	michal.simek@amd.com,
	naresh.solanki@9elements.com,
	festevam@gmail.com,
	rodrigo.gobbi.7@gmail.com,
	grantpeltier93@gmail.com,
	laurent.pinchart@ideasonboard.com,
	cedricjustine.encarnacion@analog.com,
	nuno.sa@analog.com,
	ninad@linux.ibm.com,
	jbrunet@baylibre.com,
	kimseer.paller@analog.com,
	xzeol@yahoo.com,
	leo.yang.sy0@gmail.com,
	Mariel.Tinaco@analog.com,
	johnerasmusmari.geronimo@analog.com,
	linux@weissschuh.net,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Wensheng Wang <wenswang@yeah.net>
Subject: [PATCH 4/4] hwmon: add MP29502 driver
Date: Wed, 25 Jun 2025 15:07:33 +0800
Message-Id: <20250625070733.965469-2-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250625070733.965469-1-wenswang@yeah.net>
References: <20250625065956.964759-1-wenswang@yeah.net>
 <20250625070733.965469-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgD3F3w8oFtoI3SCAQ--.44888S3
X-Coremail-Antispam: 1Uf129KBjvAXoWfZFWkXF1xXr4UWw48AFy5Arb_yoW8tF15Xo
	Z3WFWruw1UJr1UuFWkKF4IqF17Xr1UAr9Yy3WayanrWa47Ar4Fva93Cw4aqa4aya1rXws5
	ua4vk34fta17AF17n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUT2QDUUUUU
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiAQ13pGhbhgVhngAAsQ

From: Wensheng Wang <wenswang@yeah.net>

Add support for MPS VR controller mp29502. This driver exposes
telemetry and limits value readings and writtings.

Signed-off-by: Wensheng Wang <wenswang@yeah.net>
---
 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/mp29502.rst | 104 +++++
 MAINTAINERS                     |   7 +
 drivers/hwmon/pmbus/Kconfig     |   9 +
 drivers/hwmon/pmbus/Makefile    |   1 +
 drivers/hwmon/pmbus/mp29502.c   | 691 ++++++++++++++++++++++++++++++++
 6 files changed, 813 insertions(+)
 create mode 100644 Documentation/hwmon/mp29502.rst
 create mode 100644 drivers/hwmon/pmbus/mp29502.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 7e278aa0aac3..ebc5c92e50b0 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -175,6 +175,7 @@ Hardware Monitoring Kernel Drivers
    mp2869
    mp2888
    mp2891
+   mp29502
    mp2975
    mp2993
    mp5023
diff --git a/Documentation/hwmon/mp29502.rst b/Documentation/hwmon/mp29502.rst
new file mode 100644
index 000000000000..89c8109abde2
--- /dev/null
+++ b/Documentation/hwmon/mp29502.rst
@@ -0,0 +1,104 @@
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
+  * Datasheet
+    https://scnbwymvp-my.sharepoint.com/personal/admin_scnbwy_com/_layouts/15/onedrive.aspx?ga=1&id=%2Fpersonal%2Fadmin%5Fscnbwy%5Fcom%2FDocuments%2FMPSFiles%2FMP29502%2Epdf&parent=%2Fpersonal%2Fadmin%5Fscnbwy%5Fcom%2FDocuments%2FMPSFiles
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
+**power1_max**
+
+**power1_alarm**
+
+The driver provides the following attributes for output power:
+
+**power2_input**
+
+**power2_label**
+
+**power2_max**
+
+**power2_max_alarm**
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
index ee8117355902..1ee03e0b1e12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16859,6 +16859,13 @@ S:	Maintained
 F:	Documentation/hwmon/mp2891.rst
 F:	drivers/hwmon/pmbus/mp2891.c
 
+MPS MP29502 DRIVER
+M:	Wensheng Wang <wenswang@yeah.net>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/mp29502.rst
+F:	drivers/hwmon/pmbus/mp29502.c
+
 MPS MP2993 DRIVER
 M:	Noah Wang <noahwang.wang@outlook.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index f3bf7b7fb76d..d0bdd1b5feb6 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -391,6 +391,15 @@ config SENSORS_MP2891
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
index 6177047414ee..4c5ff3f32c5e 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_SENSORS_MP2856)	+= mp2856.o
 obj-$(CONFIG_SENSORS_MP2869)	+= mp2869.o
 obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
 obj-$(CONFIG_SENSORS_MP2891)	+= mp2891.o
+obj-$(CONFIG_SENSORS_MP29502)	+= mp29502.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
 obj-$(CONFIG_SENSORS_MP2993)	+= mp2993.o
 obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
diff --git a/drivers/hwmon/pmbus/mp29502.c b/drivers/hwmon/pmbus/mp29502.c
new file mode 100644
index 000000000000..15290e37bae9
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp29502.c
@@ -0,0 +1,691 @@
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
+#define MP29502_OVUV_DELTA_SCALE	50
+#define MP29502_POUT_OP_GAIN	2
+#define MP28502_VOUT_OV_GAIN	512
+#define MP28502_VOUT_OV_SCALE	40
+#define MP29502_VOUT_UV_OFFSET	36
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
+	int	vout_top_div;
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
+
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
+		ret = pmbus_read_word_data(client, page, phase, MFR_READ_IIN_EST);
+		if (ret < 0)
+			return ret;
+
+		break;
+	case PMBUS_READ_PIN:
+		/*
+		 * The MP29502 MFR_READ_PIN_EST register is linear11 format, and the
+		 * exponent is not a constant value. But the pin scale is set to
+		 * 1W/Lsb(using r/m/b scale). As a result, the pout read from MP29502
+		 * should be calculated to W, then return the result to pmbus core.
+		 */
+
+		ret = pmbus_read_word_data(client, page, phase, MFR_READ_PIN_EST);
+		if (ret < 0)
+			return ret;
+
+		ret = mp29502_reg2data_linear11(ret);
+		break;
+	case PMBUS_READ_POUT:
+		/*
+		 * The MP29502 PMBUS_READ_POUT register is linear11 format, and the
+		 * exponent is not a constant value. But the pout scale is set to
+		 * 1W/Lsb(using r/m/b scale). As a result, the pout read from MP29502
+		 * should be calculated to W, then return the result to pmbus core.
+		 */
+
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = mp29502_reg2data_linear11(ret);
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
+	case PMBUS_POUT_OP_WARN_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = (ret & GENMASK(11, 0)) * MP29502_POUT_OP_GAIN;
+		break;
+	case PMBUS_PIN_OP_WARN_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = (ret & GENMASK(11, 0)) * MP29502_POUT_OP_GAIN;
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
+	case PMBUS_POUT_OP_WARN_LIMIT:
+		/*
+		 * The PMBUS_POUT_OP_WARN_LIMIT[11:0] and bit12-bit15 should not be
+		 * changed.
+		 */
+		ret = pmbus_read_word_data(client, page, 0xff, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = pmbus_write_word_data(client, page, reg,
+					    (ret & ~GENMASK(11, 0)) |
+				FIELD_PREP(GENMASK(11, 0),
+					   DIV_ROUND_CLOSEST(word,
+							     MP29502_POUT_OP_GAIN)));
+		break;
+	case PMBUS_PIN_OP_WARN_LIMIT:
+		ret = pmbus_write_word_data(client, page, reg,
+					    DIV_ROUND_CLOSEST(word,
+							      MP29502_POUT_OP_GAIN));
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
+	.format[PSC_CURRENT_OUT] = direct,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_POWER] = direct,
+	.format[PSC_CURRENT_IN] = linear,
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


