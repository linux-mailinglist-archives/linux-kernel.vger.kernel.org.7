Return-Path: <linux-kernel+bounces-757128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6368B1BE0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B1163599
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2309A17A306;
	Wed,  6 Aug 2025 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="uhvgD4lj"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E8764A8F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754441506; cv=none; b=enbQrBYgtOndedzrV1NeppvnPEc8HrUhPEzmqQmoDSuldYWswBrmWD3L7J4sVOg6RZCbQzwlJP7UllAwUHbetH8plf9xXTE2SM9WC1Lu3ndw2tnJXV9q4IIjnW1JH7bMhk0qMw4msqA/eq2kG5YsGX1MsnKA/gkC8N3DCXTAyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754441506; c=relaxed/simple;
	bh=kCjwEMASjmh5kon1lw5PCMXTYrU3mXaUze5/VEljYps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aka/cMGLGU2v9umLiw0Z/xnGAJ5VDEBezXNIxtiesi9Cl5nJ9gr2Y+ZwR7Gu9eKU+eSvvZK4l9Fk/q5HrAbncSskutLoztHo7vO4MijOGpqTeAvViSsiA093mIudp47cZuVaFP6yLhW10WeyO8KN/t4+CHIxklOgBBbgf16bjCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=uhvgD4lj; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 288D32C0422;
	Wed,  6 Aug 2025 12:51:36 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1754441496;
	bh=HLiSFVtVy+gKGhA+HX6b+4jx8QXzRVLf9y7jIpS+GMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhvgD4ljxzwVWS/K+3eiZJV0haiDj9ZROZXFaG4GipLJXKaRNw8HpkRqteIQlde3g
	 oMtNaZCPtoCWBU/NQoa2ShwnGhcYJQQqZeCI+ysNZ5SyM6gNNy7gcWpy1VZfDyCqel
	 jvQi2uc89b+VjJDsqbO2JC41p7FqLcRjezD6NKI78t0iMSaJjWnvjHIGHCpgWZLBSN
	 wyZshD4+ogpvUcn0btM5stZwtO5DbbL6rimj39CmJwtFrSTYWVYC51sEEi4nhgybU/
	 CslMVDdQady6Idm2bHcVQXfJfQwTU2lmutHgAriyQyqiQtB6TNZkYBKDE2D9he15Yi
	 EePQ12P6jVN+A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6892a7170000>; Wed, 06 Aug 2025 12:51:35 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id DD5C913EE2B;
	Wed,  6 Aug 2025 12:51:35 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id DA7B1280564; Wed,  6 Aug 2025 12:51:35 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] hwmon: (ina780) Add driver for TI INA780
Date: Wed,  6 Aug 2025 12:51:27 +1200
Message-ID: <20250806005127.542298-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806005127.542298-1-chris.packham@alliedtelesis.co.nz>
References: <20250806005127.542298-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dtt4CEg4 c=1 sm=1 tr=0 ts=6892a717 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=2OwXVqhp2XgA:10 a=sozttTNsAAAA:8 a=rXU1nIjY8bzPZG-gVpIA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add support for the TI INA780 Digital Power Monitor.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/hwmon/Kconfig  |  11 +
 drivers/hwmon/Makefile |   1 +
 drivers/hwmon/ina780.c | 566 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 578 insertions(+)
 create mode 100644 drivers/hwmon/ina780.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 079620dd4286..d11aebb6a1c1 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2264,6 +2264,17 @@ config SENSORS_INA3221
 	  This driver can also be built as a module. If so, the module
 	  will be called ina3221.
=20
+config SENSORS_INA780
+	tristate "Texas Instruments INA780 Power Monitor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for  the TI INA780 Digital
+	  Power Monitor.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called ina780.
+
 config SENSORS_SPD5118
 	tristate "SPD5118 Compliant Temperature Sensors"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 48e5866c0c9a..e4acef261f14 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_SENSORS_INA209)	+=3D ina209.o
 obj-$(CONFIG_SENSORS_INA2XX)	+=3D ina2xx.o
 obj-$(CONFIG_SENSORS_INA238)	+=3D ina238.o
 obj-$(CONFIG_SENSORS_INA3221)	+=3D ina3221.o
+obj-$(CONFIG_SENSORS_INA780)	+=3D ina780.o
 obj-$(CONFIG_SENSORS_INTEL_M10_BMC_HWMON) +=3D intel-m10-bmc-hwmon.o
 obj-$(CONFIG_SENSORS_ISL28022)	+=3D isl28022.o
 obj-$(CONFIG_SENSORS_IT87)	+=3D it87.o
diff --git a/drivers/hwmon/ina780.c b/drivers/hwmon/ina780.c
new file mode 100644
index 000000000000..b6a31fca400a
--- /dev/null
+++ b/drivers/hwmon/ina780.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the Texas Instruments INA780 Digital Power Monitor
+ *
+ * Datasheet:
+ * https://www.ti.com/lit/gpn/ina780a
+ */
+
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#define INA780_CONFIG		0x0
+#define INA780_ADC_CONFIG	0x1
+#define INA780_VBUS		0x5
+#define INA780_DIETEMP		0x6
+#define INA780_CURRENT		0x7
+#define INA780_POWER		0x8
+#define INA780_ENERGY		0x9
+#define INA780_CHARGE		0xa
+#define INA780_DIAG_ALRT	0xb
+#define INA780_COL		0xc
+#define INA780_CUL		0xd
+#define INA780_BOVL		0xe
+#define INA780_BUVL		0xf
+#define INA780_TEMP_LIMIT	0x10
+#define INA780_PWR_LIMIT	0x11
+#define INA780_MANUFACTURER_ID	0x3e
+
+#define INA780_DIAG_ALRT_TMPOL		BIT(7)
+#define INA780_DIAG_ALRT_CURRENTOL	BIT(6)
+#define INA780_DIAG_ALRT_CURRENTUL	BIT(5)
+#define INA780_DIAG_ALRT_BUSOL		BIT(4)
+#define INA780_DIAG_ALRT_BUSUL		BIT(3)
+#define INA780_DIAG_ALRT_POL		BIT(2)
+
+#define INA780_BUS_VOLTAGE_LSB		3125	/* 3.125 mV/lsb */
+#define INA780_CURRENT_LSB		2400	/* 2.4 mA/lsb  */
+#define INA780_TEMP_LSB			125000	/* 125 mC/lsb */
+#define INA780_ENERGY_LSB		7680	/* 7.68 mJ/lsb */
+#define INA780_POWER_LSB		480000	/* 480 uW/lsb */
+#define INA780_PWR_LIMIT_LSB		(256 * INA780_POWER_LSB)  /* 122.88 mW/lsb=
 */
+
+#define INA780_ID			0x5449
+
+static const struct regmap_config ina780_regmap_config =3D {
+	.max_register =3D INA780_MANUFACTURER_ID,
+	.reg_bits =3D 8,
+	.val_bits =3D 16,
+};
+
+struct ina780_data {
+	struct mutex lock;
+	struct i2c_client *client;
+	struct regmap *regmap;
+};
+
+static int ina780_read_reg24(const struct i2c_client *client, u8 reg, u3=
2 *val)
+{
+	u8 data[3];
+	int err;
+
+	err =3D i2c_smbus_read_i2c_block_data(client, reg, 3, data);
+	if (err < 0)
+		return err;
+	if (err !=3D 3)
+		return -EIO;
+	*val =3D (data[0] << 16) | (data[1] << 8) | data[2];
+
+	return 0;
+}
+
+static int ina780_read_reg40(struct i2c_client *client, int reg, u64 *va=
l)
+{
+	u8 data[5];
+	u32 low;
+	int err;
+
+	err =3D i2c_smbus_read_i2c_block_data(client, reg, 5, data);
+	if (err < 0)
+		return err;
+	if (err !=3D 5)
+		return -EIO;
+
+	low =3D (data[1] << 24) | (data[2] << 16) | (data[3] << 8) | data[4];
+	*val =3D ((long long)data[0] << 32) | low;
+
+	return 0;
+}
+
+static int ina780_read_in(struct device *dev, u32 attr, long *val)
+{
+	struct ina780_data *data =3D dev_get_drvdata(dev);
+	unsigned int regval;
+	int reg, mask;
+	int err;
+
+	switch (attr) {
+	case hwmon_in_input:
+		reg =3D INA780_VBUS;
+		break;
+	case hwmon_in_max:
+		reg =3D INA780_BOVL;
+		break;
+	case hwmon_in_min:
+		reg =3D INA780_BUVL;
+		break;
+	case hwmon_in_max_alarm:
+		reg =3D INA780_DIAG_ALRT;
+		mask =3D INA780_DIAG_ALRT_BUSOL;
+		break;
+	case hwmon_in_min_alarm:
+		reg =3D INA780_DIAG_ALRT;
+		mask =3D INA780_DIAG_ALRT_BUSUL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	switch (attr) {
+	case hwmon_in_input:
+	case hwmon_in_max:
+	case hwmon_in_min:
+		err =3D regmap_read(data->regmap, reg, &regval);
+		if (err)
+			return err;
+
+		*val =3D (regval * INA780_BUS_VOLTAGE_LSB) / 1000;
+		break;
+	case hwmon_in_max_alarm:
+	case hwmon_in_min_alarm:
+		err =3D regmap_read(data->regmap, reg, &regval);
+		if (err)
+			return err;
+		*val =3D !!(regval & mask);
+		break;
+	}
+
+	return 0;
+}
+
+static int ina780_write_in(struct device *dev, u32 attr, long val)
+{
+	struct ina780_data *data =3D dev_get_drvdata(dev);
+	unsigned int regval;
+	int reg;
+
+	switch (attr) {
+	case hwmon_in_max:
+		reg =3D INA780_BOVL;
+		break;
+	case hwmon_in_min:
+		reg =3D INA780_BUVL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	val =3D clamp_val(val, 0, 102396);
+	regval =3D div_u64(val * 1000ULL, INA780_BUS_VOLTAGE_LSB);
+
+	return regmap_write(data->regmap, reg, regval);
+}
+
+static int ina780_read_curr(struct device *dev, u32 attr, long *val)
+{
+	struct ina780_data *data =3D dev_get_drvdata(dev);
+	unsigned int regval;
+	int reg, mask;
+	int err;
+
+	switch (attr) {
+	case hwmon_curr_input:
+		reg =3D INA780_CURRENT;
+		break;
+	case hwmon_curr_max:
+		reg =3D INA780_COL;
+		break;
+	case hwmon_curr_min:
+		reg =3D INA780_CUL;
+		break;
+	case hwmon_curr_max_alarm:
+		reg =3D INA780_DIAG_ALRT;
+		mask =3D INA780_DIAG_ALRT_CURRENTOL;
+		break;
+	case hwmon_curr_min_alarm:
+		reg =3D INA780_DIAG_ALRT;
+		mask =3D INA780_DIAG_ALRT_CURRENTUL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	switch (attr) {
+	case hwmon_curr_input:
+	case hwmon_curr_max:
+	case hwmon_curr_min:
+		err =3D regmap_read(data->regmap, reg, &regval);
+		if (err)
+			return err;
+		*val =3D div_s64((s16)regval * INA780_CURRENT_LSB, 1000);
+		break;
+	case hwmon_curr_max_alarm:
+	case hwmon_curr_min_alarm:
+		err =3D regmap_read(data->regmap, reg, &regval);
+		if (err)
+			return err;
+		*val =3D !!(regval & mask);
+		break;
+	}
+
+	return 0;
+}
+
+static int ina780_write_curr(struct device *dev, u32 attr, long val)
+{
+	struct ina780_data *data =3D dev_get_drvdata(dev);
+	unsigned int regval;
+	int reg;
+
+	switch (attr) {
+	case hwmon_curr_max:
+		reg =3D INA780_COL;
+		break;
+	case hwmon_curr_min:
+		reg =3D INA780_CUL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	clamp_val(val, -78643, 78640);
+	regval =3D div_s64(val * 1000ULL, INA780_CURRENT_LSB);
+
+	return regmap_write(data->regmap, reg, regval);
+}
+
+static int ina780_read_power(struct device *dev, u32 attr, long *val)
+{
+	struct ina780_data *data =3D dev_get_drvdata(dev);
+	unsigned int regval;
+	int err;
+
+	switch (attr) {
+	case hwmon_power_input:
+		err =3D ina780_read_reg24(data->client, INA780_POWER, &regval);
+		if (err)
+			return err;
+		*val =3D div_u64((u64)regval * INA780_POWER_LSB, 1000);
+		break;
+	case hwmon_power_max:
+		err =3D regmap_read(data->regmap, INA780_PWR_LIMIT, &regval);
+		if (err)
+			return err;
+		*val =3D div_u64((u64)regval * INA780_PWR_LIMIT_LSB, 1000);
+		break;
+	case hwmon_power_max_alarm:
+		err =3D regmap_read(data->regmap, INA780_DIAG_ALRT, &regval);
+		if (err)
+			return err;
+		*val =3D !!(regval & INA780_DIAG_ALRT_POL);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int ina780_write_power(struct device *dev, u32 attr, long val)
+{
+	struct ina780_data *data =3D dev_get_drvdata(dev);
+	int regval;
+
+	switch (attr) {
+	case hwmon_power_max:
+		val =3D clamp_val(val, 0, 8052940800);
+		regval =3D div_u64(val * 1000ULL, INA780_PWR_LIMIT_LSB);
+		return regmap_write(data->regmap, INA780_PWR_LIMIT, regval);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ina780_read_temp(struct device *dev, u32 attr, long *val)
+{
+	struct ina780_data *data =3D dev_get_drvdata(dev);
+	int reg, mask;
+	int regval;
+	int err;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		reg =3D INA780_DIETEMP;
+		break;
+	case hwmon_temp_max:
+		reg =3D INA780_TEMP_LIMIT;
+		break;
+	case hwmon_temp_max_alarm:
+		reg =3D INA780_DIAG_ALRT;
+		mask =3D INA780_DIAG_ALRT_TMPOL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_max:
+		err =3D regmap_read(data->regmap, reg, &regval);
+		if (err)
+			return err;
+		*val =3D div_s64(((s64)((s16)regval) >> 4) * INA780_TEMP_LSB, 1000);
+		break;
+	case hwmon_temp_max_alarm:
+		err =3D regmap_read(data->regmap, INA780_DIAG_ALRT, &regval);
+		*val =3D !!(regval & INA780_DIAG_ALRT_TMPOL);
+		break;
+	}
+
+	return 0;
+}
+
+static int ina780_write_temp(struct device *dev, u32 attr, long val)
+{
+	struct ina780_data *data =3D dev_get_drvdata(dev);
+	int regval;
+
+	if (attr !=3D hwmon_temp_max)
+		return -EOPNOTSUPP;
+
+	val =3D clamp_val(val, -40000, 150000);
+	regval =3D div_s64(val * 1000, INA780_TEMP_LSB) << 4;
+
+	return regmap_write(data->regmap, INA780_TEMP_LIMIT, regval);
+}
+
+static int ina780_read_energy(struct device *dev, u32 attr, long *val)
+{
+	struct ina780_data *data =3D dev_get_drvdata(dev);
+	u64 regval;
+	int err;
+
+	if (attr !=3D hwmon_energy_input)
+		return -EOPNOTSUPP;
+
+	err =3D ina780_read_reg40(data->client, INA780_ENERGY, &regval);
+	if (err)
+		return err;
+
+	*val =3D div_u64(regval * INA780_ENERGY_LSB, 1000);
+
+	return 0;
+}
+
+static int ina780_read(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, long *val)
+{
+	struct ina780_data *data =3D dev_get_drvdata(dev);
+
+	guard(mutex)(&data->lock);
+
+	switch (type) {
+	case hwmon_in:
+		return ina780_read_in(dev, attr, val);
+	case hwmon_curr:
+		return ina780_read_curr(dev, attr, val);
+	case hwmon_power:
+		return ina780_read_power(dev, attr, val);
+	case hwmon_temp:
+		return ina780_read_temp(dev, attr, val);
+	case hwmon_energy:
+		return ina780_read_energy(dev, attr, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ina780_write(struct device *dev, enum hwmon_sensor_types type=
,
+			u32 attr, int channel, long val)
+{
+	struct ina780_data *data =3D dev_get_drvdata(dev);
+
+	guard(mutex)(&data->lock);
+
+	switch (type) {
+	case hwmon_in:
+		return ina780_write_in(dev, attr, val);
+	case hwmon_curr:
+		return ina780_write_curr(dev, attr, val);
+	case hwmon_power:
+		return ina780_write_power(dev, attr, val);
+	case hwmon_temp:
+		return ina780_write_temp(dev, attr, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t ina780_is_visible(const void *drvdata,
+				 enum hwmon_sensor_types type,
+				 u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+		case hwmon_in_max_alarm:
+		case hwmon_in_min_alarm:
+			return 0444;
+		case hwmon_in_max:
+		case hwmon_in_min:
+			return 0644;
+		default:
+			return 0;
+		}
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+		case hwmon_curr_max_alarm:
+		case hwmon_curr_min_alarm:
+			return 0444;
+		case hwmon_curr_max:
+		case hwmon_curr_min:
+			return 0644;
+		default:
+			return 0;
+		}
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+		case hwmon_power_max_alarm:
+			return 0444;
+		case hwmon_power_max:
+			return 0644;
+		default:
+			return 0;
+		}
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+		case hwmon_temp_max_alarm:
+			return 0444;
+		case hwmon_temp_max:
+			return 0644;
+		default:
+			return 0;
+		}
+	case hwmon_energy:
+		switch (attr) {
+		case hwmon_energy_input:
+			return 0444;
+		default:
+			return 0;
+		}
+	default:
+		return 0;
+	}
+}
+
+static const struct hwmon_channel_info * const ina238_info[] =3D {
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT |
+			   HWMON_I_MAX | HWMON_I_MAX_ALARM |
+			   HWMON_I_MIN | HWMON_I_MIN_ALARM),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT |
+			   HWMON_C_MAX | HWMON_C_MAX_ALARM |
+			   HWMON_C_MIN | HWMON_C_MIN_ALARM),
+	HWMON_CHANNEL_INFO(power,
+			   HWMON_P_INPUT | HWMON_P_MAX | HWMON_P_MAX_ALARM),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_ALARM),
+	HWMON_CHANNEL_INFO(energy,
+			   HWMON_E_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops ina780_hwmon_ops =3D {
+	.is_visible =3D ina780_is_visible,
+	.read =3D ina780_read,
+	.write =3D ina780_write,
+};
+
+static const struct hwmon_chip_info ina780_chip_info =3D {
+	.ops =3D &ina780_hwmon_ops,
+	.info =3D ina238_info,
+};
+
+static int ina780_probe(struct i2c_client *client)
+{
+	struct device *dev =3D &client->dev;
+	struct ina780_data *data;
+	struct device *hwmon_dev;
+	unsigned int val;
+	int err;
+
+	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client =3D client;
+	data->regmap =3D devm_regmap_init_i2c(client, &ina780_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		dev_err(dev, "Failed to allocate register map\n");
+		return PTR_ERR(data->regmap);
+	}
+
+	err =3D regmap_read(data->regmap, INA780_MANUFACTURER_ID, &val);
+	if (err) {
+		dev_err(dev, "Error reading device ID\n");
+		return err;
+	}
+
+	if (val !=3D INA780_ID)
+		dev_warn(dev, "Unexpected device ID %04x\n", val);
+
+	mutex_init(&data->lock);
+
+	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, client->name, d=
ata,
+							 &ina780_chip_info,
+							 NULL);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+
+	/* Temp limit register can go to 255 C but actual max is 150 C*/
+	err =3D ina780_write_temp(hwmon_dev, hwmon_temp_max, 150000);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static const struct i2c_device_id ina780_id[] =3D {
+	{ "ina780a" },
+	{ "ina780b" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ina780_id);
+
+static const struct of_device_id ina780_of_match[] =3D {
+	{ .compatible =3D "ti,ina780a" },
+	{ .compatible =3D "ti,ina780b" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ina780_of_match);
+
+static struct i2c_driver ina780_driver =3D {
+	.driver =3D {
+		.name =3D "ina780",
+		.of_match_table =3D ina780_of_match,
+	},
+	.probe =3D ina780_probe,
+	.id_table =3D ina780_id,
+};
+
+module_i2c_driver(ina780_driver);
+
+MODULE_AUTHOR("Chris Packham <chris.packham@alliedtelesis.co.nz>");
+MODULE_DESCRIPTION("INA780 driver");
+MODULE_LICENSE("GPL");
--=20
2.50.1


