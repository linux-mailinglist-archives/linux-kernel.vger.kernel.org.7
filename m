Return-Path: <linux-kernel+bounces-635239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C0EAABAC6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 09:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77AC17A5642
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 07:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E287290D8B;
	Tue,  6 May 2025 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bNAWBAUQ"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28DE27F17E;
	Tue,  6 May 2025 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746509966; cv=none; b=I66Ur9MwwI0HBQD738QP9RchnG5gi4o7ZGnqDnDoye12x+yEihf5fCBoDWTKvrAKFbzx2vp4BG2UUvxAM4UtvB/lqKpaBzFRifjjFmfKHVXHM4SmvRjAotuflrKnttVNOdkE4Nb5RJnklQVY+REGKnY0nxYuC+0lkNGeBiuQYYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746509966; c=relaxed/simple;
	bh=Iu853oJ10IKHTPyf/QniE0pyPeiYOUpdPsBizc/ICww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TtpoP0GD2rX6xOWwBr6rVyayjE1YCrU7HpjZRZDw3owNltDnYjvMcEcYwCFLL3Q7MPvmYnoj+ENRYi6KKTcEozuS3JBIJAq0BE1UwYTHPJWL8xNT95HNxmyIvpa5BEE/UBlGT3mbAUgf3rs6tGdR/Y1fqiM3vMiQXbaC/dVaa3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bNAWBAUQ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=KdfptK1YCbegOuFP5s
	5wFBBAXhpnHZfvK0674BR0rAQ=; b=bNAWBAUQbo3bTN8gSE9Mq0k+T69+6G+6ba
	fTJ5IHiL6FdiYnBEpJDVNvD+n7fK0Im4VvowCiX6zwNS1AcadKtkTXnQsZQn1TpK
	D7VIflydaWq+O05H8UvCXNxVtLuQACtdzmM9QjAVA9sccLFbmm8nM+QvEyFYnukr
	XXL6FazR4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHxSpEoBloZ2M1Ew--.50689S4;
	Tue, 06 May 2025 13:38:21 +0800 (CST)
From: Wenliang Yan <wenliang202407@163.com>
To: linux@roeck-us.net,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jean Delvare <jdelvare@suse.com>
Cc: Wenliang Yan <wenliang202407@163.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	derek.lin@silergycorp.com,
	miguel.lee@silergycorp.com,
	chris.ho@silergycorp.com,
	eason.liao@silergycorp.com
Subject: [PATCH v7 2/4] hwmon:(ina238)Add support for SQ52206
Date: Tue,  6 May 2025 01:37:39 -0400
Message-Id: <20250506053741.4837-3-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250506053741.4837-1-wenliang202407@163.com>
References: <20250506053741.4837-1-wenliang202407@163.com>
X-CM-TRANSID:_____wBHxSpEoBloZ2M1Ew--.50689S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Cr47uw1UXw4fGrW5AFWfAFb_yoWkGrW7pF
	ZxJayfKr4UJFWxW393tr48uF13Gwn7Gr47Ar4kWw1fZFs8J34vvFy2qF4FvFW3K34rZF45
	Jr1kt3y5CwsFyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUb0edUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/xtbBDRJF02gZn3wSKQABsh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add support for SQ52206 to the Ina238 driver. Add registers,
increase compatibility, add compatibility programs for
multiple chips.

Signed-off-by: Wenliang Yan <wenliang202407@163.com>
---

v6->v7:Maintain the previous changes

v5->v6:Split the patch, this patch add support for SQ52206:

1.Incorporate four additional registers to the original register
set of SQ52206 beyond INA238.
2.The ADC measurement range of SQ52206 is divided into 1/2/4, so
change the configuration of INA238_ADC_CONFIG.
3.Add an introduction note to the power and energy formulas
4.Configure the properties of SQ52206
5.Add a 40 bit data reading function to prepare for energy reading.
6.Add peak power reading and add HWMON_P_INPUT_HIGHEST for power.
7.Energy attributes are 5bytes wide, so modified the function for
energy1_input to use u64.

Current_LSB is 1mA/lsb, so the SQ52206's Energy calculation formula is
Energy (mJ) = 16 * 0.24 * register value * 1 * 20000 / rshunt / 4 * gain,
where 20000 is the default resistance value. 4 is the default gain of 4,
20000*gain/ (rshunt*4) indicates the conversion ratio based on the actual
resistance value and the gain ratio. 16 and 0.24 are fixed parameters.
'data->config->power_calculate_factor/100 == 0.24'.

8.Add a corresponding compatible to the driver.

 Documentation/hwmon/ina238.rst |  15 +++++
 drivers/hwmon/ina238.c         | 113 ++++++++++++++++++++++++++++++---
 2 files changed, 120 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/ina238.rst b/Documentation/hwmon/ina238.rst
index d9f479984420..d1b93cf8627f 100644
--- a/Documentation/hwmon/ina238.rst
+++ b/Documentation/hwmon/ina238.rst
@@ -14,6 +14,12 @@ Supported chips:
     Datasheet:
 	https://www.ti.com/lit/gpn/ina238
 
+  * Silergy SQ52206
+
+    Prefix: 'SQ52206'
+
+    Addresses: I2C 0x40 - 0x4f
+
 Author: Nathan Rossi <nathan.rossi@digi.com>
 
 Description
@@ -54,3 +60,12 @@ temp1_input		Die temperature measurement (mC)
 temp1_max		Maximum die temperature threshold (mC)
 temp1_max_alarm		Maximum die temperature alarm
 ======================= =======================================================
+
+Additional sysfs entries for sq52206
+------------------------------------
+
+======================= =======================================================
+energy1_input		Energy measurement (mJ)
+
+power1_input_highest	Peak Power (uW)
+======================= =======================================================
diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
index c8d6bd3041b3..1bf4c850b04d 100644
--- a/drivers/hwmon/ina238.c
+++ b/drivers/hwmon/ina238.c
@@ -21,11 +21,14 @@
 #define INA238_CONFIG			0x0
 #define INA238_ADC_CONFIG		0x1
 #define INA238_SHUNT_CALIBRATION	0x2
+#define SQ52206_SHUNT_TEMPCO		0x3
 #define INA238_SHUNT_VOLTAGE		0x4
 #define INA238_BUS_VOLTAGE		0x5
 #define INA238_DIE_TEMP			0x6
 #define INA238_CURRENT			0x7
 #define INA238_POWER			0x8
+#define SQ52206_ENERGY			0x9
+#define SQ52206_CHARGE			0xa
 #define INA238_DIAG_ALERT		0xb
 #define INA238_SHUNT_OVER_VOLTAGE	0xc
 #define INA238_SHUNT_UNDER_VOLTAGE	0xd
@@ -33,9 +36,12 @@
 #define INA238_BUS_UNDER_VOLTAGE	0xf
 #define INA238_TEMP_LIMIT		0x10
 #define INA238_POWER_LIMIT		0x11
+#define SQ52206_POWER_PEAK		0x20
 #define INA238_DEVICE_ID		0x3f /* not available on INA237 */
 
 #define INA238_CONFIG_ADCRANGE		BIT(4)
+#define SQ52206_CONFIG_ADCRANGE_HIGH	BIT(4)
+#define SQ52206_CONFIG_ADCRANGE_LOW		BIT(3)
 
 #define INA238_DIAG_ALERT_TMPOL		BIT(7)
 #define INA238_DIAG_ALERT_SHNTOL	BIT(6)
@@ -44,12 +50,13 @@
 #define INA238_DIAG_ALERT_BUSUL		BIT(3)
 #define INA238_DIAG_ALERT_POL		BIT(2)
 
-#define INA238_REGISTERS		0x11
+#define INA238_REGISTERS		0x20
 
 #define INA238_RSHUNT_DEFAULT		10000 /* uOhm */
 
 /* Default configuration of device on reset. */
 #define INA238_CONFIG_DEFAULT		0
+#define SQ52206_CONFIG_DEFAULT		0x0005
 /* 16 sample averaging, 1052us conversion time, continuous mode */
 #define INA238_ADC_CONFIG_DEFAULT	0xfb6a
 /* Configure alerts to be based on averaged value (SLOWALERT) */
@@ -87,14 +94,19 @@
  *  shunt = 0x4000 / (819.2 * 10^6) / 0.001 = 20000 uOhms (with 1mA/lsb)
  *
  *  Current (mA) = register value * 20000 / rshunt / 4 * gain
- *  Power (W) = 0.2 * register value * 20000 / rshunt / 4 * gain
+ *  Power (mW) = 0.2 * register value * 20000 / rshunt / 4 * gain
+ *  (Specific for SQ52206)
+ *  Power (mW) = 0.24 * register value * 20000 / rshunt / 4 * gain
+ *  Energy (mJ) = 16 * 0.24 * register value * 20000 / rshunt / 4 * gain
  */
 #define INA238_CALIBRATION_VALUE	16384
 #define INA238_FIXED_SHUNT		20000
 
 #define INA238_SHUNT_VOLTAGE_LSB	5 /* 5 uV/lsb */
 #define INA238_BUS_VOLTAGE_LSB		3125 /* 3.125 mV/lsb */
-#define INA238_DIE_TEMP_LSB		125 /* 125 mC/lsb */
+#define INA238_DIE_TEMP_LSB			1250000 /* 125.0000 mC/lsb */
+#define SQ52206_BUS_VOLTAGE_LSB		3750 /* 3.75 mV/lsb */
+#define SQ52206_DIE_TEMP_LSB		78125 /* 7.8125 mC/lsb */
 
 static const struct regmap_config ina238_regmap_config = {
 	.max_register = INA238_REGISTERS,
@@ -102,7 +114,7 @@ static const struct regmap_config ina238_regmap_config = {
 	.val_bits = 16,
 };
 
-enum ina238_ids { ina238, ina237 };
+enum ina238_ids { ina238, ina237, sq52206 };
 
 struct ina238_config {
 	bool has_power_highest;		/* chip detection power peak */
@@ -142,6 +154,15 @@ static const struct ina238_config ina238_config[] = {
 		.bus_voltage_lsb = INA238_BUS_VOLTAGE_LSB,
 		.temp_lsb = INA238_DIE_TEMP_LSB,
 	},
+	[sq52206] = {
+		.has_energy = true,
+		.has_power_highest = true,
+		.temp_shift = 0,
+		.power_calculate_factor = 24,
+		.config_default = SQ52206_CONFIG_DEFAULT,
+		.bus_voltage_lsb = SQ52206_BUS_VOLTAGE_LSB,
+		.temp_lsb = SQ52206_DIE_TEMP_LSB,
+	},
 };
 
 static int ina238_read_reg24(const struct i2c_client *client, u8 reg, u32 *val)
@@ -160,6 +181,24 @@ static int ina238_read_reg24(const struct i2c_client *client, u8 reg, u32 *val)
 	return 0;
 }
 
+static int ina238_read_reg40(const struct i2c_client *client, u8 reg, u64 *val)
+{
+	u8 data[5];
+	u32 low;
+	int err;
+
+	/* 40-bit register read */
+	err = i2c_smbus_read_i2c_block_data(client, reg, 5, data);
+	if (err < 0)
+		return err;
+	if (err != 5)
+		return -EIO;
+	low = (data[1] << 24) | (data[2] << 16) | (data[3] << 8) | data[4];
+	*val = ((long long)data[0] << 32) | low;
+
+	return 0;
+}
+
 static int ina238_read_in(struct device *dev, u32 attr, int channel,
 			  long *val)
 {
@@ -330,6 +369,17 @@ static int ina238_read_power(struct device *dev, u32 attr, long *val)
 		if (err)
 			return err;
 
+		/* Fixed 1mA lsb, scaled by 1000000 to have result in uW */
+		power = div_u64(regval * 1000ULL * INA238_FIXED_SHUNT *
+				data->gain, 20 * data->rshunt);
+		/* Clamp value to maximum value of long */
+		*val = clamp_val(power, 0, LONG_MAX);
+		break;
+	case hwmon_power_input_highest:
+		err = ina238_read_reg24(data->client, SQ52206_POWER_PEAK, &regval);
+		if (err)
+			return err;
+
 		/* Fixed 1mA lsb, scaled by 1000000 to have result in uW */
 		power = div_u64(regval * 1000ULL * INA238_FIXED_SHUNT *
 				data->gain, 20 * data->rshunt);
@@ -437,6 +487,25 @@ static int ina238_write_temp(struct device *dev, u32 attr, long val)
 	return regmap_write(data->regmap, INA238_TEMP_LIMIT, regval);
 }
 
+static ssize_t energy1_input_show(struct device *dev,
+				  struct device_attribute *da, char *buf)
+{
+	struct ina238_data *data = dev_get_drvdata(dev);
+	int ret;
+	u64 regval;
+	u64 energy;
+
+	ret = ina238_read_reg40(data->client, SQ52206_ENERGY, &regval);
+	if (ret)
+		return ret;
+
+	/* result in mJ */
+	energy = div_u64(regval * INA238_FIXED_SHUNT *	data->gain * 16 *
+				data->config->power_calculate_factor, 4 * 100 * data->rshunt);
+
+	return sysfs_emit(buf, "%llu\n", energy);
+}
+
 static int ina238_read(struct device *dev, enum hwmon_sensor_types type,
 		       u32 attr, int channel, long *val)
 {
@@ -486,6 +555,9 @@ static umode_t ina238_is_visible(const void *drvdata,
 				 enum hwmon_sensor_types type,
 				 u32 attr, int channel)
 {
+	const struct ina238_data *data = drvdata;
+	bool has_power_highest = data->config->has_power_highest;
+
 	switch (type) {
 	case hwmon_in:
 		switch (attr) {
@@ -513,6 +585,10 @@ static umode_t ina238_is_visible(const void *drvdata,
 			return 0444;
 		case hwmon_power_max:
 			return 0644;
+		case hwmon_power_input_highest:
+			if (has_power_highest)
+				return 0444;
+			return 0;
 		default:
 			return 0;
 		}
@@ -546,7 +622,8 @@ static const struct hwmon_channel_info * const ina238_info[] = {
 			   HWMON_C_INPUT),
 	HWMON_CHANNEL_INFO(power,
 			   /* 0: power */
-			   HWMON_P_INPUT | HWMON_P_MAX | HWMON_P_MAX_ALARM),
+			   HWMON_P_INPUT | HWMON_P_MAX |
+			   HWMON_P_MAX_ALARM | HWMON_P_INPUT_HIGHEST),
 	HWMON_CHANNEL_INFO(temp,
 			   /* 0: die temperature */
 			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_ALARM),
@@ -564,6 +641,15 @@ static const struct hwmon_chip_info ina238_chip_info = {
 	.info = ina238_info,
 };
 
+/* energy attributes are 5 bytes wide so we need u64 */
+static DEVICE_ATTR_RO(energy1_input);
+
+static struct attribute *ina238_attrs[] = {
+	&dev_attr_energy1_input.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(ina238);
+
 static int ina238_probe(struct i2c_client *client)
 {
 	struct ina2xx_platform_data *pdata = dev_get_platdata(&client->dev);
@@ -604,14 +690,19 @@ static int ina238_probe(struct i2c_client *client)
 	/* load shunt gain value */
 	if (device_property_read_u32(dev, "ti,shunt-gain", &data->gain) < 0)
 		data->gain = 4; /* Default of ADCRANGE = 0 */
-	if (data->gain != 1 && data->gain != 4) {
+	if (data->gain != 1 && data->gain != 2 && data->gain != 4) {
 		dev_err(dev, "invalid shunt gain value %u\n", data->gain);
 		return -EINVAL;
 	}
 
 	/* Setup CONFIG register */
 	config = data->config->config_default;
-	if (data->gain == 1)
+	if (chip == sq52206) {
+		if (data->gain == 1)
+			config |= SQ52206_CONFIG_ADCRANGE_HIGH; /* ADCRANGE = 10/11 is /1 */
+		else if (data->gain == 2)
+			config |= SQ52206_CONFIG_ADCRANGE_LOW; /* ADCRANGE = 01 is /2 */
+	} else if (data->gain == 1)
 		config |= INA238_CONFIG_ADCRANGE; /* ADCRANGE = 1 is /1 */
 	ret = regmap_write(data->regmap, INA238_CONFIG, config);
 	if (ret < 0) {
@@ -645,7 +736,8 @@ static int ina238_probe(struct i2c_client *client)
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data,
 							 &ina238_chip_info,
-							 NULL);
+							 data->config->has_energy ?
+								ina238_groups : NULL);
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
 
@@ -658,6 +750,7 @@ static int ina238_probe(struct i2c_client *client)
 static const struct i2c_device_id ina238_id[] = {
 	{ "ina237", ina237 },
 	{ "ina238", ina238 },
+	{ "sq52206", sq52206 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ina238_id);
@@ -671,6 +764,10 @@ static const struct of_device_id __maybe_unused ina238_of_match[] = {
 		.compatible = "ti,ina238",
 		.data = (void *)ina238
 	},
+	{
+		.compatible = "silergy,sq52206",
+		.data = (void *)sq52206
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ina238_of_match);
-- 
2.17.1


