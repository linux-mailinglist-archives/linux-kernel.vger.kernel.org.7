Return-Path: <linux-kernel+bounces-805682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351B9B48C43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D656F16F769
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889CC22FDE8;
	Mon,  8 Sep 2025 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="YxvXZOx4"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E89522A4F4;
	Mon,  8 Sep 2025 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331208; cv=none; b=pf3hruXz5royIZoRvrZB8NUGpQ1avnoix5A60nl8/LAKygyYZPZyfTqs3+2vIXDrGzwe6UU69XdOgbnsp61LFF9AvyHfbeiaONflpfkV/grHGFFr2EQIDVHE3xuX9py8RPrz1AGq9TOyBp/C53lLwbKLnZELJ2epYQhlGBnyJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331208; c=relaxed/simple;
	bh=EbIbVG7HXyNM1nvVwxugWj1T9DJZYweYyr6HgkjEhng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSSMEAHtZtFpth963zoABSteIw1tg0aqAKPAIa99Jw683tyfhtQBABEcVAMNHGn6Gh4nDp5oazaUcoHK3nivo3BRSUY+0Qi/ulAbpppoXNRYj8KK2J3xCiSw28LC7lY9qe0865XdYoOBrZ6mYucu+WY828C8nAlztiPxzAvuTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=YxvXZOx4; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=8mfAUiDgeQEf+sy7JDlxpDZLR4H/DmjPlHjBHdGpBis=;
	b=YxvXZOx40B4RyPrkH3yIljtlFlzLSzevFzUCE+Ne1uR7A1ZDUHcVkJGEi1r5gA
	cD+ckyMBQk3exvp5CUcMsV9rErVeqC4E+fzgf69IVrdsvREnprAAPHhUs8BL8kTL
	hAmCNFIwVes8zWvEaXl/P9iKhXQ+m8NL9dhXGMGea2s6c=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnDyGQt75oaK06BA--.61995S3;
	Mon, 08 Sep 2025 19:01:41 +0800 (CST)
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
Subject: [PATCH 2/2] hwmon: add MP2925 and MP2929 driver
Date: Mon,  8 Sep 2025 19:01:28 +0800
Message-Id: <20250908110128.1002655-2-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250908110128.1002655-1-wenswang@yeah.net>
References: <20250908105951.1002332-1-wenswang@yeah.net>
 <20250908110128.1002655-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgDnDyGQt75oaK06BA--.61995S3
X-Coremail-Antispam: 1Uf129KBjvAXoW3tw1DCFWkJr1rCrWkXFW8Zwb_yoW8Gry5Ko
	Z3WFWrZw1DJr18uFZYkF4IgF93Xa48CrWFya12yFsxWFy3trn5Ka47Zw4ag3W7tw4rXw48
	u3y8A3s3tFW7Zr97n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUODGOUUUUU
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiNxXcgWi+t5Xd+AAA3u

From: Wensheng Wang <wenswang@yeah.net>

Add support for MPS VR mp2925 and mp2929 controller. This driver exposes
telemetry and limit value readings and writtings.

Signed-off-by: Wensheng Wang <wenswang@yeah.net>
---
 Documentation/hwmon/index.rst  |   1 +
 Documentation/hwmon/mp2925.rst | 151 ++++++++++++++++
 MAINTAINERS                    |   7 +
 drivers/hwmon/pmbus/Kconfig    |   9 +
 drivers/hwmon/pmbus/Makefile   |   1 +
 drivers/hwmon/pmbus/mp2925.c   | 312 +++++++++++++++++++++++++++++++++
 6 files changed, 481 insertions(+)
 create mode 100644 Documentation/hwmon/mp2925.rst
 create mode 100644 drivers/hwmon/pmbus/mp2925.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index d292a86ac5da..95bcf71ff6d9 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -175,6 +175,7 @@ Hardware Monitoring Kernel Drivers
    mp2856
    mp2888
    mp2891
+   mp2925
    mp2975
    mp2993
    mp5023
diff --git a/Documentation/hwmon/mp2925.rst b/Documentation/hwmon/mp2925.rst
new file mode 100644
index 000000000000..63eda215b6cb
--- /dev/null
+++ b/Documentation/hwmon/mp2925.rst
@@ -0,0 +1,151 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver mp2925
+====================
+
+Supported chips:
+
+  * MPS mp2925
+
+    Prefix: 'mp2925'
+
+  * MPS mp2929
+
+    Prefix: 'mp2929'
+
+Author:
+
+	Wensheng Wang <wenswang@yeah.net>
+
+Description
+-----------
+
+This driver implements support for Monolithic Power Systems, Inc. (MPS)
+MP2925 Dual Loop Digital Multi-phase Controller.
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
+**in1_max**
+
+**in1_max_alarm**
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
+**power4_input**
+
+**power4_label**
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
index cd7ff55b5d32..6444cf742098 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17184,6 +17184,13 @@ S:	Maintained
 F:	Documentation/hwmon/mp2891.rst
 F:	drivers/hwmon/pmbus/mp2891.c
 
+MPS MP2925 DRIVER
+M:	Noah Wang <wenswang@yeah.net>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/mp2925.rst
+F:	drivers/hwmon/pmbus/mp2925.c
+
 MPS MP2993 DRIVER
 M:	Noah Wang <noahwang.wang@outlook.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 55e492452ce8..d0e1eb500215 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -391,6 +391,15 @@ config SENSORS_MP2891
       This driver can also be built as a module. If so, the module will
       be called mp2891.
 
+config SENSORS_MP2925
+    tristate "MPS MP2925"
+    help
+      If you say yes here you get hardware monitoring support for MPS
+      MP2925 Dual Loop Digital Multi-Phase Controller.
+
+      This driver can also be built as a module. If so, the module will
+      be called mp2925.
+
 config SENSORS_MP2975
 	tristate "MPS MP2975"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 29cd8a3317d2..64c1b03bf47b 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
 obj-$(CONFIG_SENSORS_MP2856)	+= mp2856.o
 obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
 obj-$(CONFIG_SENSORS_MP2891)	+= mp2891.o
+obj-$(CONFIG_SENSORS_MP2925)	+= mp2925.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
 obj-$(CONFIG_SENSORS_MP2993)	+= mp2993.o
 obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
diff --git a/drivers/hwmon/pmbus/mp2925.c b/drivers/hwmon/pmbus/mp2925.c
new file mode 100644
index 000000000000..453995fca3bf
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp2925.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hardware monitoring driver for MPS Multi-phase Digital VR Controllers(MP2925)
+ */
+
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include "pmbus.h"
+
+/*
+ * Vender specific register MFR_VR_MULTI_CONFIG(0x08).
+ * This register is used to obtain vid scale.
+ */
+#define MFR_VR_MULTI_CONFIG	0x08
+
+#define MP2925_VOUT_DIV	512
+#define MP2925_VOUT_OVUV_UINT	195
+#define MP2925_VOUT_OVUV_DIV	100
+
+#define MP2925_PAGE_NUM	2
+
+#define MP2925_RAIL1_FUNC	(PMBUS_HAVE_VIN | PMBUS_HAVE_PIN | \
+							 PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | \
+							 PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP | \
+							 PMBUS_HAVE_STATUS_VOUT | \
+							 PMBUS_HAVE_STATUS_IOUT | \
+							 PMBUS_HAVE_STATUS_TEMP | \
+							 PMBUS_HAVE_STATUS_INPUT)
+
+#define MP2925_RAIL2_FUNC	(PMBUS_HAVE_PIN | PMBUS_HAVE_VOUT | \
+							 PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT | \
+							 PMBUS_HAVE_TEMP | PMBUS_HAVE_IIN | \
+							 PMBUS_HAVE_STATUS_VOUT | \
+							 PMBUS_HAVE_STATUS_IOUT | \
+							 PMBUS_HAVE_STATUS_TEMP | \
+							 PMBUS_HAVE_STATUS_INPUT)
+
+struct mp2925_data {
+	struct pmbus_driver_info info;
+	int vout_scale[MP2925_PAGE_NUM];
+};
+
+#define to_mp2925_data(x) container_of(x, struct mp2925_data, info)
+
+static u16 mp2925_linear_exp_transfer(u16 word, u16 expect_exponent)
+{
+	s16 exponent, mantissa, target_exponent;
+
+	exponent = ((s16)word) >> 11;
+	mantissa = ((s16)((word & 0x7ff) << 5)) >> 5;
+	target_exponent = (s16)((expect_exponent & 0x1f) << 11) >> 11;
+
+	if (exponent > target_exponent)
+		mantissa = mantissa << (exponent - target_exponent);
+	else
+		mantissa = mantissa >> (target_exponent - exponent);
+
+	return (mantissa & 0x7ff) | ((expect_exponent << 11) & 0xf800);
+}
+
+static int mp2925_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VOUT_MODE:
+		/*
+		 * The MP2925 does not follow standard PMBus protocol completely,
+		 * and the calculation of vout in this driver is based on direct
+		 * format. As a result, the format of vout is enforced to direct.
+		 */
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
+static int mp2925_read_word_data(struct i2c_client *client, int page, int phase,
+				 int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp2925_data *data = to_mp2925_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_READ_VOUT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST((ret & GENMASK(11, 0)) * data->vout_scale[page],
+					MP2925_VOUT_DIV);
+		break;
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST((ret & GENMASK(11, 0)) * MP2925_VOUT_OVUV_UINT,
+					MP2925_VOUT_OVUV_DIV);
+		break;
+	case PMBUS_STATUS_WORD:
+	case PMBUS_READ_VIN:
+	case PMBUS_READ_IOUT:
+	case PMBUS_READ_POUT:
+	case PMBUS_READ_PIN:
+	case PMBUS_READ_IIN:
+	case PMBUS_READ_TEMPERATURE_1:
+	case PMBUS_VIN_OV_FAULT_LIMIT:
+	case PMBUS_VIN_OV_WARN_LIMIT:
+	case PMBUS_VIN_UV_WARN_LIMIT:
+	case PMBUS_VIN_UV_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_WARN_LIMIT:
+	case PMBUS_OT_FAULT_LIMIT:
+	case PMBUS_OT_WARN_LIMIT:
+		ret = -ENODATA;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int mp2925_write_word_data(struct i2c_client *client, int page, int reg,
+				  u16 word)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VIN_OV_FAULT_LIMIT:
+	case PMBUS_VIN_OV_WARN_LIMIT:
+	case PMBUS_VIN_UV_WARN_LIMIT:
+	case PMBUS_VIN_UV_FAULT_LIMIT:
+		/*
+		 * The PMBUS_VIN_OV_FAULT_LIMIT, PMBUS_VIN_OV_WARN_LIMIT,
+		 * PMBUS_VIN_UV_WARN_LIMIT and PMBUS_VIN_UV_FAULT_LIMIT
+		 * of MP2925 is linear11 format, and the exponent is a
+		 * constant value(5'b11100)， so the exponent of word
+		 * parameter should be converted to 5'b11100(0x1C).
+		 */
+		ret = pmbus_write_word_data(client, page, reg,
+					    mp2925_linear_exp_transfer(word, 0x1C));
+		if (ret < 0)
+			return ret;
+		break;
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+		ret = pmbus_write_word_data(client, page, reg,
+					    (ret & ~GENMASK(11, 0)) |
+				FIELD_PREP(GENMASK(11, 0),
+					   DIV_ROUND_CLOSEST(word * MP2925_VOUT_OVUV_DIV,
+							     MP2925_VOUT_OVUV_UINT)));
+		break;
+	case PMBUS_OT_FAULT_LIMIT:
+	case PMBUS_OT_WARN_LIMIT:
+		/*
+		 * The PMBUS_OT_FAULT_LIMIT and PMBUS_OT_WARN_LIMIT of
+		 * MP2925 is linear11 format, and the exponent is a
+		 * constant value(5'b00000), so the exponent of word
+		 * parameter should be converted to 5'b00000.
+		 */
+		ret = pmbus_write_word_data(client, page, reg,
+					    mp2925_linear_exp_transfer(word, 0x00));
+		if (ret < 0)
+			return ret;
+		break;
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_WARN_LIMIT:
+		/*
+		 * The PMBUS_IOUT_OC_FAULT_LIMIT and PMBUS_IOUT_OC_WARN_LIMIT
+		 * of MP2925 is linear11 format, and the exponent is a
+		 * can not be changed.
+		 */
+		ret = pmbus_read_word_data(client, page, 0xff, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = pmbus_write_word_data(client, page, reg,
+					    mp2925_linear_exp_transfer(word,
+								       FIELD_GET(GENMASK(15, 11),
+										 ret)));
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int
+mp2925_identify_vout_scale(struct i2c_client *client, struct pmbus_driver_info *info,
+			   int page)
+{
+	struct mp2925_data *data = to_mp2925_data(info);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_byte_data(client, PMBUS_VOUT_MODE);
+	if (ret < 0)
+		return ret;
+
+	if (FIELD_GET(GENMASK(5, 5), ret)) {
+		ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE,
+						page == 0 ? 3 : 4);
+		if (ret < 0)
+			return ret;
+
+		ret = i2c_smbus_read_word_data(client, MFR_VR_MULTI_CONFIG);
+		if (ret < 0)
+			return ret;
+
+		if (FIELD_GET(GENMASK(5, 5), ret))
+			data->vout_scale[page] = 2560;
+		else
+			data->vout_scale[page] = 5120;
+	} else if (FIELD_GET(GENMASK(4, 4), ret)) {
+		data->vout_scale[page] = 1;
+	} else {
+		data->vout_scale[page] = 512;
+	}
+
+	return 0;
+}
+
+static int mp2925_identify(struct i2c_client *client, struct pmbus_driver_info *info)
+{
+	int ret;
+
+	ret = mp2925_identify_vout_scale(client, info, 0);
+	if (ret < 0)
+		return ret;
+
+	return mp2925_identify_vout_scale(client, info, 1);
+}
+
+static const struct pmbus_driver_info mp2925_info = {
+	.pages = MP2925_PAGE_NUM,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_POWER] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.format[PSC_VOLTAGE_OUT] = direct,
+
+	.m[PSC_VOLTAGE_OUT] = 1,
+	.R[PSC_VOLTAGE_OUT] = 3,
+	.b[PSC_VOLTAGE_OUT] = 0,
+
+	.func[0] = MP2925_RAIL1_FUNC,
+	.func[1] = MP2925_RAIL2_FUNC,
+	.read_word_data = mp2925_read_word_data,
+	.read_byte_data = mp2925_read_byte_data,
+	.write_word_data = mp2925_write_word_data,
+	.identify = mp2925_identify,
+};
+
+static int mp2925_probe(struct i2c_client *client)
+{
+	struct mp2925_data *data;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct mp2925_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	memcpy(&data->info, &mp2925_info, sizeof(mp2925_info));
+
+	return pmbus_do_probe(client, &data->info);
+}
+
+static const struct i2c_device_id mp2925_id[] = {
+	{"mp2925", 0},
+	{"mp2929", 1},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mp2925_id);
+
+static const struct of_device_id __maybe_unused mp2925_of_match[] = {
+	{.compatible = "mps,mp2925", .data = (void *)0},
+	{.compatible = "mps,mp2929", .data = (void *)1},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mp2925_of_match);
+
+static struct i2c_driver mp2925_driver = {
+	.driver = {
+		.name = "mp2925",
+		.of_match_table = mp2925_of_match,
+	},
+	.probe = mp2925_probe,
+	.id_table = mp2925_id,
+};
+
+module_i2c_driver(mp2925_driver);
+
+MODULE_AUTHOR("Wensheng Wang <wenswang@yeah.net>");
+MODULE_DESCRIPTION("PMBus driver for MPS MP2925");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("PMBUS");
-- 
2.25.1


