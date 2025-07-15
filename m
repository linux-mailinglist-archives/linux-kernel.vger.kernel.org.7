Return-Path: <linux-kernel+bounces-732526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29139B0681D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63A24E1268
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB82E2EEA;
	Tue, 15 Jul 2025 20:49:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422472C08CC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612566; cv=none; b=mIjh1eYtAHDNroEMCv3/FVEmtEw+jrQxVb4JnBPT4HLfdbgpvhcBOX2NQGUzF2bEs+XxGNGgGf1gyq6nTOvw5cAAfLSN20miTKDzMinLsHE3I0qJpTJLiJH1QAjT7GHEktDV9FLJ9WZ3LcwP9rYGvob2731e1JtSiLWLPRLCHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612566; c=relaxed/simple;
	bh=qeSiSEChF8vkI7U3jprp57CemwGFZH0pwj0CrxbU60w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eBPRTitd85/2T2KIo/hBtvmSf+NJ7ky8nEUQuZ3mbk3nlGQwI2L8Y7aHk6cYms15EXZXoD+Dk4eVXG98NY8nNGHo/tIA5qRVwhxxZnst3BNh2EFkEMzpkiXYDud0pz1Zo9GOqkqcElV0hMbLSrUnsAdM18KIfBC8iOt9B/OYUV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1ubmaI-0008KV-KY; Tue, 15 Jul 2025 22:49:06 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Tue, 15 Jul 2025 22:49:03 +0200
Subject: [PATCH 4/4] hwmon: ina238: Add support for INA228
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-ina228-v1-4-3302fae4434b@pengutronix.de>
References: <20250715-ina228-v1-0-3302fae4434b@pengutronix.de>
In-Reply-To: <20250715-ina228-v1-0-3302fae4434b@pengutronix.de>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7020; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=qeSiSEChF8vkI7U3jprp57CemwGFZH0pwj0CrxbU60w=;
 b=owGbwMvMwCF2ZcYT3onnbjcwnlZLYsgo23fwhFXjrqaVHNlptausf8kwHyy9VKmbk3o007v30
 uyV32vXd5SyMIhxMMiKKbLEqskpCBn7XzertIuFmcPKBDKEgYtTACaibszIMMnsXqbGzBjvhEvH
 J+/ImFIerSCWelzKs7/WrGXTFBfxfkaGK+k64j8MNs0UWXmyP0X1bnb82dOu7n0/t+y+9qir+xg
 TEwA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add support for the Texas Instruments INA228 Ultra-Precise
Power/Energy/Charge Monitor.

The INA228 is very similar to the INA238 but offers four bits of extra
precision in the temperature, voltage and current measurement fields.
It also supports energy and charge monitoring, the latter of which is
not supported through this patch.

While it seems in the datasheet that some constants such as LSB values
differ between the 228 and the 238, they differ only for those registers
where four bits of precision have been added and they differ by a factor
of 16 (VBUS, VSHUNT, DIETEMP, CURRENT).

Therefore, the INA238 constants are still applicable with regard
to the bit of the same significance.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 drivers/hwmon/ina238.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
index 44f7ce3c1d7b5a91f67d12c1d29e1e560024a04c..f8c74317344a5bbdf933a32b8c7e5aba13beda30 100644
--- a/drivers/hwmon/ina238.c
+++ b/drivers/hwmon/ina238.c
@@ -107,6 +107,7 @@
 #define INA238_DIE_TEMP_LSB		1250000 /* 125.0000 mC/lsb */
 #define SQ52206_BUS_VOLTAGE_LSB		3750 /* 3.75 mV/lsb */
 #define SQ52206_DIE_TEMP_LSB		78125 /* 7.8125 mC/lsb */
+#define INA228_DIE_TEMP_LSB		78125 /* 7.8125 mC/lsb */
 
 static const struct regmap_config ina238_regmap_config = {
 	.max_register = INA238_REGISTERS,
@@ -114,9 +115,10 @@ static const struct regmap_config ina238_regmap_config = {
 	.val_bits = 16,
 };
 
-enum ina238_ids { ina238, ina237, sq52206 };
+enum ina238_ids { ina238, ina237, sq52206, ina228 };
 
 struct ina238_config {
+	bool has_20bit_voltage_current; /* vshunt, vbus and current are 20-bit fields */
 	bool has_power_highest;		/* chip detection power peak */
 	bool has_energy;		/* chip detection energy */
 	u8 temp_shift;			/* fixed parameters for temp calculate */
@@ -137,6 +139,7 @@ struct ina238_data {
 
 static const struct ina238_config ina238_config[] = {
 	[ina238] = {
+		.has_20bit_voltage_current = false,
 		.has_energy = false,
 		.has_power_highest = false,
 		.temp_shift = 4,
@@ -146,6 +149,7 @@ static const struct ina238_config ina238_config[] = {
 		.temp_lsb = INA238_DIE_TEMP_LSB,
 	},
 	[ina237] = {
+		.has_20bit_voltage_current = false,
 		.has_energy = false,
 		.has_power_highest = false,
 		.temp_shift = 4,
@@ -155,6 +159,7 @@ static const struct ina238_config ina238_config[] = {
 		.temp_lsb = INA238_DIE_TEMP_LSB,
 	},
 	[sq52206] = {
+		.has_20bit_voltage_current = false,
 		.has_energy = true,
 		.has_power_highest = true,
 		.temp_shift = 0,
@@ -163,6 +168,16 @@ static const struct ina238_config ina238_config[] = {
 		.bus_voltage_lsb = SQ52206_BUS_VOLTAGE_LSB,
 		.temp_lsb = SQ52206_DIE_TEMP_LSB,
 	},
+	[ina228] = {
+		.has_20bit_voltage_current = true,
+		.has_energy = true,
+		.has_power_highest = false,
+		.temp_shift = 0,
+		.power_calculate_factor = 20,
+		.config_default = INA238_CONFIG_DEFAULT,
+		.bus_voltage_lsb = INA238_BUS_VOLTAGE_LSB,
+		.temp_lsb = INA228_DIE_TEMP_LSB,
+	},
 };
 
 static int ina238_read_reg24(const struct i2c_client *client, u8 reg, u32 *val)
@@ -199,6 +214,56 @@ static int ina238_read_reg40(const struct i2c_client *client, u8 reg, u64 *val)
 	return 0;
 }
 
+static int ina228_read_shunt_voltage(struct device *dev, u32 attr, int channel,
+				     long *val)
+{
+	struct ina238_data *data = dev_get_drvdata(dev);
+	int regval;
+	int field;
+	int err;
+
+	err = ina238_read_reg24(data->client, INA238_SHUNT_VOLTAGE, &regval);
+	if (err)
+		return err;
+
+	/* bits 3-0 Reserved, always zero */
+	field = regval >> 4;
+
+	/*
+	 * gain of 1 -> LSB / 4
+	 * This field has 16 bit on ina238. ina228 adds another 4 bits of
+	 * precision. ina238 conversion factors can still be applied when
+	 * dividing by 16.
+	 */
+	*val = (field * INA238_SHUNT_VOLTAGE_LSB) * data->gain / (1000 * 4) / 16;
+	return 0;
+}
+
+static int ina228_read_bus_voltage(struct device *dev, u32 attr, int channel,
+				   long *val)
+{
+	struct ina238_data *data = dev_get_drvdata(dev);
+	int regval;
+	int field;
+	int err;
+
+	err = ina238_read_reg24(data->client, INA238_BUS_VOLTAGE, &regval);
+	if (err)
+		return err;
+
+	/* bits 3-0 Reserved, always zero */
+	field = regval >> 4;
+
+	/*
+	 * gain of 1 -> LSB / 4
+	 * This field has 16 bit on ina238. ina228 adds another 4 bits of
+	 * precision. ina238 conversion factors can still be applied when
+	 * dividing by 16.
+	 */
+	*val = (field * data->config->bus_voltage_lsb) / 1000 / 16;
+	return 0;
+}
+
 static int ina238_read_in(struct device *dev, u32 attr, int channel,
 			  long *val)
 {
@@ -211,6 +276,8 @@ static int ina238_read_in(struct device *dev, u32 attr, int channel,
 	case 0:
 		switch (attr) {
 		case hwmon_in_input:
+			if (data->config->has_20bit_voltage_current)
+				return ina228_read_shunt_voltage(dev, attr, channel, val);
 			reg = INA238_SHUNT_VOLTAGE;
 			break;
 		case hwmon_in_max:
@@ -234,6 +301,8 @@ static int ina238_read_in(struct device *dev, u32 attr, int channel,
 	case 1:
 		switch (attr) {
 		case hwmon_in_input:
+			if (data->config->has_20bit_voltage_current)
+				return ina228_read_bus_voltage(dev, attr, channel, val);
 			reg = INA238_BUS_VOLTAGE;
 			break;
 		case hwmon_in_max:
@@ -341,13 +410,27 @@ static int ina238_read_current(struct device *dev, u32 attr, long *val)
 
 	switch (attr) {
 	case hwmon_curr_input:
-		err = regmap_read(data->regmap, INA238_CURRENT, &regval);
-		if (err < 0)
-			return err;
+		if (data->config->has_20bit_voltage_current) {
+			err = ina238_read_reg24(data->client, INA238_CURRENT, &regval);
+			if (err)
+				return err;
+			/* 4 Lowest 4 bits reserved zero */
+			regval >>= 4;
+		} else {
+			err = regmap_read(data->regmap, INA238_CURRENT, &regval);
+			if (err < 0)
+				return err;
+			/* sign-extend */
+			regval = (s16)regval;
+		}
 
 		/* Signed register, fixed 1mA current lsb. result in mA */
-		*val = div_s64((s16)regval * INA238_FIXED_SHUNT * data->gain,
+		*val = div_s64(regval * INA238_FIXED_SHUNT * data->gain,
 			       data->rshunt * 4);
+
+		/* Account for 4 bit offset */
+		if (data->config->has_20bit_voltage_current)
+			*val /= 16;
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -773,6 +856,7 @@ static int ina238_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ina238_id[] = {
+	{ "ina228", ina228 },
 	{ "ina237", ina237 },
 	{ "ina238", ina238 },
 	{ "sq52206", sq52206 },
@@ -781,6 +865,10 @@ static const struct i2c_device_id ina238_id[] = {
 MODULE_DEVICE_TABLE(i2c, ina238_id);
 
 static const struct of_device_id __maybe_unused ina238_of_match[] = {
+	{
+		.compatible = "ti,ina228",
+		.data = (void *)ina228
+	},
 	{
 		.compatible = "ti,ina237",
 		.data = (void *)ina237

-- 
2.39.5


