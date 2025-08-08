Return-Path: <linux-kernel+bounces-759662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E740FB1E0CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F3C7216C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4EA1B4138;
	Fri,  8 Aug 2025 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="VLfP9fg0"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ACC1553AA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 03:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754622319; cv=none; b=iNmeUeRUIxm2Y2xQEl9kPXvWK6VPRD5O69Ddf4BMsErLKmbArqjz0Crtn1e+KqS5sQ3N5EAzxe/L1OmZL94PCZxOAyjuuIpGZRZiOu7p065Uj9WZN6Na9baqe2JVKiaLQyLdLEvLwsJWl2s3ZBTp7HlHwas7HfCG12B0fbMW1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754622319; c=relaxed/simple;
	bh=scnK5TkV/iPUZVPOCtMUvL1tuU+EOesME9RHKtg1ptw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=la1Ao2fu2LNiWQPBJ7l7CwS8Yc4gaIscfuq9mCNdjpkMIZRp9lAxVt7OMJaYKNGSDliR+ANQEAx+RbXIZ7EkskKp7fGEnpXvuRdRfSZa5i1j/2yQLgqOYVo0mudQkvcmj2Dd661WGDnxlKY2POrGB1E9QWh2jQ81bQ5UUIf+MTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=VLfP9fg0; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9F6D22C0664;
	Fri,  8 Aug 2025 15:05:13 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1754622313;
	bh=vgQAodzMEDilXkvOTClBhGnOqcd+vjUlb5lQKfNPRUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLfP9fg0/Hhiswm04xJqxbiFYYJZrTUcho0s7jYvsAOWLOSFvDNYnIZznF+L0z8IE
	 nw32QAhN1ROladL/APZ00tvkD2mp+RtwJZsHXNapQuy/K/lP2mPT8V0ES+Cqgv+bV5
	 71UMqGt16t/DmNszoHGGQM9xpJdnJdip+xU81yW900961W+F6otUXkvTKfDeFjp6jS
	 hc4PYedaW8XXZ5SUiyybSplRVaZXvKTOYCFbbgzlgqxo2z+pzcHQ+JGGlFp0je/v0j
	 y64xkwuRXkc3Z3V4bDYO1GzLDcboJMOVhRexaQqI3s5+ROv4NTu/dazssp6bp+spQt
	 s1Fk9EauUmuLA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B689569690002>; Fri, 08 Aug 2025 15:05:13 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 675E113EE8E;
	Fri,  8 Aug 2025 15:05:13 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 65C84280C34; Fri,  8 Aug 2025 15:05:13 +1200 (NZST)
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
Subject: [PATCH v2 2/2] hwmon: (ina238) Add support for INA780
Date: Fri,  8 Aug 2025 15:05:10 +1200
Message-ID: <20250808030510.552724-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808030510.552724-1-chris.packham@alliedtelesis.co.nz>
References: <20250808030510.552724-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dtt4CEg4 c=1 sm=1 tr=0 ts=68956969 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=2OwXVqhp2XgA:10 a=sozttTNsAAAA:8 a=awjjO-qNAAAA:8 a=fXAo8snH_YtPTJ7Dc_MA:9 a=3ZKOabzyN94A:10 a=QBFNEbH8yFitwsIKuSP9:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add support for the TI INA780 Digital Power Monitor. The INA780 uses
EZShunt(tm) technology, which means there are fixed LSB conversions for
a number of fields rather than needing to be calibrated.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/hwmon/ina238.rst |  20 +++
 drivers/hwmon/ina238.c         | 258 ++++++++++++++++++++++++++-------
 2 files changed, 226 insertions(+), 52 deletions(-)

diff --git a/Documentation/hwmon/ina238.rst b/Documentation/hwmon/ina238.=
rst
index 9a24da4786a4..220d36d5c947 100644
--- a/Documentation/hwmon/ina238.rst
+++ b/Documentation/hwmon/ina238.rst
@@ -14,6 +14,11 @@ Supported chips:
     Datasheet:
 	https://www.ti.com/lit/gpn/ina238
=20
+  * Texas Instruments INA780
+
+    Datasheet:
+	https://www.ti.com/product/ina780a
+
   * Silergy SQ52206
=20
     Prefix: 'SQ52206'
@@ -69,3 +74,18 @@ energy1_input		Energy measurement (uJ)
=20
 power1_input_highest	Peak Power (uW)
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+Sysfs differences for ina780
+----------------------------
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+in0_input		Bus voltage (mV)
+in0_min			Minimum bus voltage threshold (mV)
+in0_min_alarm		Minimum shunt voltage alarm
+in0_max			Maximum bus voltage threshold (mV)
+in0_max_alarm		Maximum shunt voltage alarm
+curr1_max		Maximum current threshold
+curr1_max_alarm		Maximum current alarm
+curr1_min		Minimum current threshold
+curr1_min_alarm		Minimum current alarm
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
index a2cb615fa278..424efa99c541 100644
--- a/drivers/hwmon/ina238.c
+++ b/drivers/hwmon/ina238.c
@@ -2,6 +2,7 @@
 /*
  * Driver for Texas Instruments INA238 power monitor chip
  * Datasheet: https://www.ti.com/product/ina238
+ *            https://www.ti.com/product/ina780a
  *
  * Copyright (C) 2021 Nathan Rossi <nathan.rossi@digi.com>
  */
@@ -32,6 +33,8 @@
 #define INA238_DIAG_ALERT		0xb
 #define INA238_SHUNT_OVER_VOLTAGE	0xc
 #define INA238_SHUNT_UNDER_VOLTAGE	0xd
+#define INA780_COL			0xc
+#define INA780_CUL			0xd
 #define INA238_BUS_OVER_VOLTAGE		0xe
 #define INA238_BUS_UNDER_VOLTAGE	0xf
 #define INA238_TEMP_LIMIT		0x10
@@ -49,6 +52,8 @@
 #define INA238_DIAG_ALERT_BUSOL		BIT(4)
 #define INA238_DIAG_ALERT_BUSUL		BIT(3)
 #define INA238_DIAG_ALERT_POL		BIT(2)
+#define INA780_DIAG_ALERT_CURRENTOL	BIT(6)
+#define INA780_DIAG_ALERT_CURRENTUL	BIT(5)
=20
 #define INA238_REGISTERS		0x20
=20
@@ -108,22 +113,29 @@
 #define SQ52206_BUS_VOLTAGE_LSB		3750 /* 3.75 mV/lsb */
 #define SQ52206_DIE_TEMP_LSB		78125 /* 7.8125 mC/lsb */
=20
+#define INA780_CURRENT_LSB		2400	/* 2.4 mA/lsb  */
+#define INA780_ENERGY_LSB		7680	/* 7.68 mJ/lsb */
+
 static const struct regmap_config ina238_regmap_config =3D {
 	.max_register =3D INA238_REGISTERS,
 	.reg_bits =3D 8,
 	.val_bits =3D 16,
 };
=20
-enum ina238_ids { ina238, ina237, sq52206 };
+enum ina238_ids { ina238, ina237, sq52206, ina780 };
=20
 struct ina238_config {
+	bool has_shunt;			/* has shunt resistor */
 	bool has_power_highest;		/* chip detection power peak */
 	bool has_energy;			/* chip detection energy */
+	bool has_curr_min_max;		/* supports COL/CUL */
 	u8 temp_shift;				/* fixed parameters for temp calculate */
 	u32 power_calculate_factor;	/* fixed parameters for power calculate */
 	u16 config_default;			/* Power-on default state */
 	int bus_voltage_lsb;		/* use for temperature calculate, uV/lsb */
 	int temp_lsb;				/* use for temperature calculate */
+	int temp_max;			/* maximum configurable temp limit in mC */
+	int fixed_power_lsb;
 };
=20
 struct ina238_data {
@@ -137,6 +149,7 @@ struct ina238_data {
=20
 static const struct ina238_config ina238_config[] =3D {
 	[ina238] =3D {
+		.has_shunt =3D true,
 		.has_energy =3D false,
 		.has_power_highest =3D false,
 		.temp_shift =3D 4,
@@ -144,8 +157,10 @@ static const struct ina238_config ina238_config[] =3D=
 {
 		.config_default =3D INA238_CONFIG_DEFAULT,
 		.bus_voltage_lsb =3D INA238_BUS_VOLTAGE_LSB,
 		.temp_lsb =3D INA238_DIE_TEMP_LSB,
+		.temp_max =3D 125000,
 	},
 	[ina237] =3D {
+		.has_shunt =3D true,
 		.has_energy =3D false,
 		.has_power_highest =3D false,
 		.temp_shift =3D 4,
@@ -153,8 +168,10 @@ static const struct ina238_config ina238_config[] =3D=
 {
 		.config_default =3D INA238_CONFIG_DEFAULT,
 		.bus_voltage_lsb =3D INA238_BUS_VOLTAGE_LSB,
 		.temp_lsb =3D INA238_DIE_TEMP_LSB,
+		.temp_max =3D 125000,
 	},
 	[sq52206] =3D {
+		.has_shunt =3D true,
 		.has_energy =3D true,
 		.has_power_highest =3D true,
 		.temp_shift =3D 0,
@@ -162,7 +179,20 @@ static const struct ina238_config ina238_config[] =3D=
 {
 		.config_default =3D SQ52206_CONFIG_DEFAULT,
 		.bus_voltage_lsb =3D SQ52206_BUS_VOLTAGE_LSB,
 		.temp_lsb =3D SQ52206_DIE_TEMP_LSB,
+		.temp_max =3D 125000,
 	},
+	[ina780] =3D {
+		.has_shunt =3D false,
+		.has_energy =3D true,
+		.has_power_highest =3D false,
+		.temp_shift =3D 4,
+		.config_default =3D INA238_CONFIG_DEFAULT,
+		.bus_voltage_lsb =3D INA238_BUS_VOLTAGE_LSB,
+		.temp_lsb =3D INA238_DIE_TEMP_LSB,
+		.temp_max =3D 150000,
+		.fixed_power_lsb =3D 480,
+		.has_curr_min_max =3D true,
+	}
 };
=20
 static int ina238_read_reg24(const struct i2c_client *client, u8 reg, u3=
2 *val)
@@ -203,12 +233,12 @@ static int ina238_read_in(struct device *dev, u32 a=
ttr, int channel,
 			  long *val)
 {
 	struct ina238_data *data =3D dev_get_drvdata(dev);
+	bool has_shunt =3D data->config->has_shunt;
 	int reg, mask;
 	int regval;
 	int err;
=20
-	switch (channel) {
-	case 0:
+	if (has_shunt && channel =3D=3D 0) {
 		switch (attr) {
 		case hwmon_in_input:
 			reg =3D INA238_SHUNT_VOLTAGE;
@@ -230,8 +260,7 @@ static int ina238_read_in(struct device *dev, u32 att=
r, int channel,
 		default:
 			return -EOPNOTSUPP;
 		}
-		break;
-	case 1:
+	} else {
 		switch (attr) {
 		case hwmon_in_input:
 			reg =3D INA238_BUS_VOLTAGE;
@@ -253,9 +282,6 @@ static int ina238_read_in(struct device *dev, u32 att=
r, int channel,
 		default:
 			return -EOPNOTSUPP;
 		}
-		break;
-	default:
-		return -EOPNOTSUPP;
 	}
=20
 	err =3D regmap_read(data->regmap, reg, &regval);
@@ -268,7 +294,7 @@ static int ina238_read_in(struct device *dev, u32 att=
r, int channel,
 	case hwmon_in_min:
 		/* signed register, value in mV */
 		regval =3D (s16)regval;
-		if (channel =3D=3D 0)
+		if (has_shunt && channel =3D=3D 0)
 			/* gain of 1 -> LSB / 4 */
 			*val =3D (regval * INA238_SHUNT_VOLTAGE_LSB) *
 					data->gain / (1000 * 4);
@@ -288,14 +314,14 @@ static int ina238_write_in(struct device *dev, u32 =
attr, int channel,
 			   long val)
 {
 	struct ina238_data *data =3D dev_get_drvdata(dev);
+	bool has_shunt =3D data->config->has_shunt;
 	int regval;
=20
 	if (attr !=3D hwmon_in_max && attr !=3D hwmon_in_min)
 		return -EOPNOTSUPP;
=20
 	/* convert decimal to register value */
-	switch (channel) {
-	case 0:
+	if (has_shunt && channel =3D=3D 0) {
 		/* signed value, clamp to max range +/-163 mV */
 		regval =3D clamp_val(val, -163, 163);
 		regval =3D (regval * 1000 * 4) /
@@ -312,7 +338,7 @@ static int ina238_write_in(struct device *dev, u32 at=
tr, int channel,
 		default:
 			return -EOPNOTSUPP;
 		}
-	case 1:
+	} else {
 		/* signed value, positive values only. Clamp to max 102.396 V */
 		regval =3D clamp_val(val, 0, 102396);
 		regval =3D (regval * 1000) / data->config->bus_voltage_lsb;
@@ -328,8 +354,6 @@ static int ina238_write_in(struct device *dev, u32 at=
tr, int channel,
 		default:
 			return -EOPNOTSUPP;
 		}
-	default:
-		return -EOPNOTSUPP;
 	}
 }
=20
@@ -356,9 +380,86 @@ static int ina238_read_current(struct device *dev, u=
32 attr, long *val)
 	return 0;
 }
=20
+static int ina780_read_current(struct device *dev, u32 attr, long *val)
+{
+	struct ina238_data *data =3D dev_get_drvdata(dev);
+	unsigned int regval;
+	int reg, mask;
+	int err;
+
+	switch (attr) {
+	case hwmon_curr_input:
+		reg =3D INA238_CURRENT;
+		break;
+	case hwmon_curr_max:
+		reg =3D INA780_COL;
+		break;
+	case hwmon_curr_min:
+		reg =3D INA780_CUL;
+		break;
+	case hwmon_curr_max_alarm:
+		reg =3D INA238_DIAG_ALERT;
+		mask =3D INA780_DIAG_ALERT_CURRENTOL;
+		break;
+	case hwmon_curr_min_alarm:
+		reg =3D INA238_DIAG_ALERT;
+		mask =3D INA780_DIAG_ALERT_CURRENTUL;
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
+static int ina780_write_current(struct device *dev, u32 attr, long val)
+{
+	struct ina238_data *data =3D dev_get_drvdata(dev);
+	bool has_curr_min_max =3D data->config->has_curr_min_max;
+	unsigned int regval;
+	int reg;
+
+	if (!has_curr_min_max)
+		return -EOPNOTSUPP;
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
 static int ina238_read_power(struct device *dev, u32 attr, long *val)
 {
 	struct ina238_data *data =3D dev_get_drvdata(dev);
+	long long fixed_power_lsb =3D data->config->fixed_power_lsb;
 	long long power;
 	int regval;
 	int err;
@@ -369,9 +470,14 @@ static int ina238_read_power(struct device *dev, u32=
 attr, long *val)
 		if (err)
 			return err;
=20
-		/* Fixed 1mA lsb, scaled by 1000000 to have result in uW */
-		power =3D div_u64(regval * 1000ULL * INA238_FIXED_SHUNT *	data->gain *
-				data->config->power_calculate_factor, 4 * 100 * data->rshunt);
+		if (fixed_power_lsb)
+			power =3D div_u64(regval * fixed_power_lsb, 1000);
+		else
+			/* Fixed 1mA lsb, scaled by 1000000 to have result in uW */
+			power =3D div_u64(regval * 1000ULL * INA238_FIXED_SHUNT * data->gain =
*
+					data->config->power_calculate_factor,
+					4 * 100 * data->rshunt);
+
 		/* Clamp value to maximum value of long */
 		*val =3D clamp_val(power, 0, LONG_MAX);
 		break;
@@ -395,8 +501,12 @@ static int ina238_read_power(struct device *dev, u32=
 attr, long *val)
 		 * Truncated 24-bit compare register, lower 8-bits are
 		 * truncated. Same conversion to/from uW as POWER register.
 		 */
-		power =3D div_u64((regval << 8) * 1000ULL * INA238_FIXED_SHUNT *	data-=
>gain *
-				data->config->power_calculate_factor, 4 * 100 * data->rshunt);
+		if (fixed_power_lsb)
+			power =3D div_u64((regval << 8) * fixed_power_lsb * 256, 1000);
+		else
+			power =3D div_u64((regval << 8) * 1000ULL * INA238_FIXED_SHUNT * data=
->gain *
+					data->config->power_calculate_factor,
+					4 * 100 * data->rshunt);
 		/* Clamp value to maximum value of long */
 		*val =3D clamp_val(power, 0, LONG_MAX);
 		break;
@@ -417,6 +527,7 @@ static int ina238_read_power(struct device *dev, u32 =
attr, long *val)
 static int ina238_write_power(struct device *dev, u32 attr, long val)
 {
 	struct ina238_data *data =3D dev_get_drvdata(dev);
+	int fixed_power_lsb =3D data->config->fixed_power_lsb;
 	long regval;
=20
 	if (attr !=3D hwmon_power_max)
@@ -428,8 +539,12 @@ static int ina238_write_power(struct device *dev, u3=
2 attr, long val)
 	 * register.
 	 */
 	regval =3D clamp_val(val, 0, LONG_MAX);
-	regval =3D div_u64(val * 4 * 100 * data->rshunt, data->config->power_ca=
lculate_factor *
-			1000ULL * INA238_FIXED_SHUNT * data->gain);
+	if (fixed_power_lsb)
+		regval =3D div_u64(val * 1000ULL, fixed_power_lsb);
+	else
+		regval =3D div_u64(val * 4 * 100 * data->rshunt,
+				 data->config->power_calculate_factor *
+				 1000ULL * INA238_FIXED_SHUNT * data->gain);
 	regval =3D clamp_val(regval >> 8, 0, U16_MAX);
=20
 	return regmap_write(data->regmap, INA238_POWER_LIMIT, regval);
@@ -481,7 +596,7 @@ static int ina238_write_temp(struct device *dev, u32 =
attr, long val)
 		return -EOPNOTSUPP;
=20
 	/* Signed */
-	val =3D clamp_val(val, -40000, 125000);
+	val =3D clamp_val(val, -40000, data->config->temp_max);
 	regval =3D div_s64(val * 10000, data->config->temp_lsb) << data->config=
->temp_shift;
 	regval =3D clamp_val(regval, S16_MIN, S16_MAX) & (0xffff << data->confi=
g->temp_shift);
=20
@@ -492,6 +607,7 @@ static ssize_t energy1_input_show(struct device *dev,
 				  struct device_attribute *da, char *buf)
 {
 	struct ina238_data *data =3D dev_get_drvdata(dev);
+	bool has_shunt =3D data->config->has_shunt;
 	int ret;
 	u64 regval;
 	u64 energy;
@@ -501,8 +617,11 @@ static ssize_t energy1_input_show(struct device *dev=
,
 		return ret;
=20
 	/* result in uJ */
-	energy =3D div_u64(regval * INA238_FIXED_SHUNT *	data->gain * 16 * 10 *
-				data->config->power_calculate_factor, 4 * data->rshunt);
+	if (has_shunt)
+		energy =3D div_u64(regval * INA238_FIXED_SHUNT *	data->gain * 16 * 10 =
*
+					data->config->power_calculate_factor, 4 * data->rshunt);
+	else
+		energy =3D div_u64(regval * INA780_ENERGY_LSB, 1000);
=20
 	return sysfs_emit(buf, "%llu\n", energy);
 }
@@ -510,11 +629,17 @@ static ssize_t energy1_input_show(struct device *de=
v,
 static int ina238_read(struct device *dev, enum hwmon_sensor_types type,
 		       u32 attr, int channel, long *val)
 {
+	struct ina238_data *data =3D dev_get_drvdata(dev);
+	bool has_curr_min_max =3D data->config->has_curr_min_max;
+
 	switch (type) {
 	case hwmon_in:
 		return ina238_read_in(dev, attr, channel, val);
 	case hwmon_curr:
-		return ina238_read_current(dev, attr, val);
+		if (has_curr_min_max)
+			return ina780_read_current(dev, attr, val);
+		else
+			return ina238_read_current(dev, attr, val);
 	case hwmon_power:
 		return ina238_read_power(dev, attr, val);
 	case hwmon_temp:
@@ -537,6 +662,9 @@ static int ina238_write(struct device *dev, enum hwmo=
n_sensor_types type,
 	case hwmon_in:
 		err =3D ina238_write_in(dev, attr, channel, val);
 		break;
+	case hwmon_curr:
+		err =3D ina780_write_current(dev, attr, val);
+		break;
 	case hwmon_power:
 		err =3D ina238_write_power(dev, attr, val);
 		break;
@@ -558,6 +686,8 @@ static umode_t ina238_is_visible(const void *drvdata,
 {
 	const struct ina238_data *data =3D drvdata;
 	bool has_power_highest =3D data->config->has_power_highest;
+	bool has_curr_min_max =3D data->config->has_curr_min_max;
+	bool has_shunt =3D data->config->has_shunt;
=20
 	switch (type) {
 	case hwmon_in:
@@ -565,10 +695,14 @@ static umode_t ina238_is_visible(const void *drvdat=
a,
 		case hwmon_in_input:
 		case hwmon_in_max_alarm:
 		case hwmon_in_min_alarm:
-			return 0444;
+			if (channel =3D=3D 0 || has_shunt)
+				return 0444;
+			return 0;
 		case hwmon_in_max:
 		case hwmon_in_min:
-			return 0644;
+			if (channel =3D=3D 0 || has_shunt)
+				return 0644;
+			return 0;
 		default:
 			return 0;
 		}
@@ -576,6 +710,13 @@ static umode_t ina238_is_visible(const void *drvdata=
,
 		switch (attr) {
 		case hwmon_curr_input:
 			return 0444;
+		case hwmon_curr_max:
+		case hwmon_curr_min:
+		case hwmon_curr_max_alarm:
+		case hwmon_curr_min_alarm:
+			if (has_curr_min_max)
+				return 0644;
+			return 0;
 		default:
 			return 0;
 		}
@@ -614,13 +755,16 @@ static umode_t ina238_is_visible(const void *drvdat=
a,
=20
 static const struct hwmon_channel_info * const ina238_info[] =3D {
 	HWMON_CHANNEL_INFO(in,
-			   /* 0: shunt voltage */
+			   /* 0: shunt voltage (bus voltage for ina780)*/
 			   INA238_HWMON_IN_CONFIG,
-			   /* 1: bus voltage */
+			   /* 1: bus voltage (not present on ina780) */
 			   INA238_HWMON_IN_CONFIG),
 	HWMON_CHANNEL_INFO(curr,
 			   /* 0: current through shunt */
-			   HWMON_C_INPUT),
+			   HWMON_C_INPUT |
+			   /* current limits avialble on ina780*/
+			   HWMON_C_MAX | HWMON_C_MAX_ALARM |
+			   HWMON_C_MIN | HWMON_C_MIN_ALARM),
 	HWMON_CHANNEL_INFO(power,
 			   /* 0: power */
 			   HWMON_P_INPUT | HWMON_P_MAX |
@@ -679,21 +823,23 @@ static int ina238_probe(struct i2c_client *client)
 		return PTR_ERR(data->regmap);
 	}
=20
-	/* load shunt value */
-	data->rshunt =3D INA238_RSHUNT_DEFAULT;
-	if (device_property_read_u32(dev, "shunt-resistor", &data->rshunt) < 0 =
&& pdata)
-		data->rshunt =3D pdata->shunt_uohms;
-	if (data->rshunt =3D=3D 0) {
-		dev_err(dev, "invalid shunt resister value %u\n", data->rshunt);
-		return -EINVAL;
-	}
+	if (data->config->has_shunt) {
+		/* load shunt value */
+		data->rshunt =3D INA238_RSHUNT_DEFAULT;
+		if (device_property_read_u32(dev, "shunt-resistor", &data->rshunt) < 0=
 && pdata)
+			data->rshunt =3D pdata->shunt_uohms;
+		if (data->rshunt =3D=3D 0) {
+			dev_err(dev, "invalid shunt resister value %u\n", data->rshunt);
+			return -EINVAL;
+		}
=20
-	/* load shunt gain value */
-	if (device_property_read_u32(dev, "ti,shunt-gain", &data->gain) < 0)
-		data->gain =3D 4; /* Default of ADCRANGE =3D 0 */
-	if (data->gain !=3D 1 && data->gain !=3D 2 && data->gain !=3D 4) {
-		dev_err(dev, "invalid shunt gain value %u\n", data->gain);
-		return -EINVAL;
+		/* load shunt gain value */
+		if (device_property_read_u32(dev, "ti,shunt-gain", &data->gain) < 0)
+			data->gain =3D 4; /* Default of ADCRANGE =3D 0 */
+		if (data->gain !=3D 1 && data->gain !=3D 2 && data->gain !=3D 4) {
+			dev_err(dev, "invalid shunt gain value %u\n", data->gain);
+			return -EINVAL;
+		}
 	}
=20
 	/* Setup CONFIG register */
@@ -720,12 +866,14 @@ static int ina238_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
=20
-	/* Setup SHUNT_CALIBRATION register with fixed value */
-	ret =3D regmap_write(data->regmap, INA238_SHUNT_CALIBRATION,
-			   INA238_CALIBRATION_VALUE);
-	if (ret < 0) {
-		dev_err(dev, "error configuring the device: %d\n", ret);
-		return -ENODEV;
+	if (data->config->has_shunt) {
+		/* Setup SHUNT_CALIBRATION register with fixed value */
+		ret =3D regmap_write(data->regmap, INA238_SHUNT_CALIBRATION,
+				   INA238_CALIBRATION_VALUE);
+		if (ret < 0) {
+			dev_err(dev, "error configuring the device: %d\n", ret);
+			return -ENODEV;
+		}
 	}
=20
 	/* Setup alert/alarm configuration */
@@ -743,8 +891,9 @@ static int ina238_probe(struct i2c_client *client)
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
=20
-	dev_info(dev, "power monitor %s (Rshunt =3D %u uOhm, gain =3D %u)\n",
-		 client->name, data->rshunt, data->gain);
+	if (data->config->has_shunt)
+		dev_info(dev, "power monitor %s (Rshunt =3D %u uOhm, gain =3D %u)\n",
+			 client->name, data->rshunt, data->gain);
=20
 	return 0;
 }
@@ -753,6 +902,7 @@ static const struct i2c_device_id ina238_id[] =3D {
 	{ "ina237", ina237 },
 	{ "ina238", ina238 },
 	{ "sq52206", sq52206 },
+	{ "ina780", ina780 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ina238_id);
@@ -770,6 +920,10 @@ static const struct of_device_id __maybe_unused ina2=
38_of_match[] =3D {
 		.compatible =3D "silergy,sq52206",
 		.data =3D (void *)sq52206
 	},
+	{
+		.compatible =3D "ti,ina780",
+		.data =3D (void *)ina780
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ina238_of_match);
--=20
2.50.1


