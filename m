Return-Path: <linux-kernel+bounces-732524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C553B0681B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30015665B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3F82C324F;
	Tue, 15 Jul 2025 20:49:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5602C08A8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612565; cv=none; b=Hfa/fBt5XUyfFk5krn5OD82dxzjjBsp8CRSpyDBlStas6NwMGKtJldXdKmBt6Xtnn4JbpuLBaC7H7S08WeI2pqUNgMn/COHF/SnMDONkqJTH6bzWjmvrQIJCjLlmif6fkZWO+xjmj/p4Z85Vf+D/9oTrM/HiUOeDAnT7O3IMsgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612565; c=relaxed/simple;
	bh=1HTJF7mGCNgEMHWLWzAwyOkhpvpJhNMskIEhjSYFLw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhqFlUIbvkcorD4e+t4AOt642gsJBxXy9YqJXfuCu1DbhOTjs9nzfnlYQg2DYXC2Z+IbI/Ib87oLL4nPAIIIAJ3A5uC26UQm73Eyj1x5YTmHNAmIKyIa7cT/bkiQ5t+WyGk1KUNh6kPNqg8rtTj5VC3IwZk2Thi1Q82VhWvDSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1ubmaI-0008KV-Dj; Tue, 15 Jul 2025 22:49:06 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Tue, 15 Jul 2025 22:49:00 +0200
Subject: [PATCH 1/4] hwmon: ina238: Fix inconsistent whitespace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-ina228-v1-1-3302fae4434b@pengutronix.de>
References: <20250715-ina228-v1-0-3302fae4434b@pengutronix.de>
In-Reply-To: <20250715-ina228-v1-0-3302fae4434b@pengutronix.de>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5373; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=1HTJF7mGCNgEMHWLWzAwyOkhpvpJhNMskIEhjSYFLw8=;
 b=owGbwMvMwCF2ZcYT3onnbjcwnlZLYsgo27dfqFEnJSdDQ1s3QNNYkl/M3aODJ1lPwXnGsQ0/W
 TYt2b22o5SFQYyDQVZMkSVWTU5ByNj/ulmlXSzMHFYmkCEMXJwCMJFnrxj+l0z49fL8ybm/f3OW
 x0exP9NaqxrncIuPZ5LSz+SFk+IZLRj+WV47r7qtXeLnvckHLGZ3J36Ov+Ztk9bgvs3yzWeLmbX
 ZXAA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Some purely cosmetic changes in ina238.c:

 - When aligning definitions, do so consistently with tab stop of 8.
 - Use spaces instead of tabs around operators.
 - Align wrapped lines.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 drivers/hwmon/ina238.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
index 9a5fd16a4ec2a6d5a6cd5e8070d0442e1ef0135a..d603d4990c928984350c1f414431219b1489a546 100644
--- a/drivers/hwmon/ina238.c
+++ b/drivers/hwmon/ina238.c
@@ -41,7 +41,7 @@
 
 #define INA238_CONFIG_ADCRANGE		BIT(4)
 #define SQ52206_CONFIG_ADCRANGE_HIGH	BIT(4)
-#define SQ52206_CONFIG_ADCRANGE_LOW		BIT(3)
+#define SQ52206_CONFIG_ADCRANGE_LOW	BIT(3)
 
 #define INA238_DIAG_ALERT_TMPOL		BIT(7)
 #define INA238_DIAG_ALERT_SHNTOL	BIT(6)
@@ -104,7 +104,7 @@
 
 #define INA238_SHUNT_VOLTAGE_LSB	5 /* 5 uV/lsb */
 #define INA238_BUS_VOLTAGE_LSB		3125 /* 3.125 mV/lsb */
-#define INA238_DIE_TEMP_LSB			1250000 /* 125.0000 mC/lsb */
+#define INA238_DIE_TEMP_LSB		1250000 /* 125.0000 mC/lsb */
 #define SQ52206_BUS_VOLTAGE_LSB		3750 /* 3.75 mV/lsb */
 #define SQ52206_DIE_TEMP_LSB		78125 /* 7.8125 mC/lsb */
 
@@ -118,12 +118,12 @@ enum ina238_ids { ina238, ina237, sq52206 };
 
 struct ina238_config {
 	bool has_power_highest;		/* chip detection power peak */
-	bool has_energy;			/* chip detection energy */
-	u8 temp_shift;				/* fixed parameters for temp calculate */
+	bool has_energy;		/* chip detection energy */
+	u8 temp_shift;			/* fixed parameters for temp calculate */
 	u32 power_calculate_factor;	/* fixed parameters for power calculate */
-	u16 config_default;			/* Power-on default state */
+	u16 config_default;		/* Power-on default state */
 	int bus_voltage_lsb;		/* use for temperature calculate, uV/lsb */
-	int temp_lsb;				/* use for temperature calculate */
+	int temp_lsb;			/* use for temperature calculate */
 };
 
 struct ina238_data {
@@ -271,7 +271,7 @@ static int ina238_read_in(struct device *dev, u32 attr, int channel,
 		if (channel == 0)
 			/* gain of 1 -> LSB / 4 */
 			*val = (regval * INA238_SHUNT_VOLTAGE_LSB) *
-					data->gain / (1000 * 4);
+				data->gain / (1000 * 4);
 		else
 			*val = (regval * data->config->bus_voltage_lsb) / 1000;
 		break;
@@ -370,7 +370,7 @@ static int ina238_read_power(struct device *dev, u32 attr, long *val)
 			return err;
 
 		/* Fixed 1mA lsb, scaled by 1000000 to have result in uW */
-		power = div_u64(regval * 1000ULL * INA238_FIXED_SHUNT *	data->gain *
+		power = div_u64(regval * 1000ULL * INA238_FIXED_SHUNT * data->gain *
 				data->config->power_calculate_factor, 4 * 100 * data->rshunt);
 		/* Clamp value to maximum value of long */
 		*val = clamp_val(power, 0, LONG_MAX);
@@ -381,7 +381,7 @@ static int ina238_read_power(struct device *dev, u32 attr, long *val)
 			return err;
 
 		/* Fixed 1mA lsb, scaled by 1000000 to have result in uW */
-		power = div_u64(regval * 1000ULL * INA238_FIXED_SHUNT *	data->gain *
+		power = div_u64(regval * 1000ULL * INA238_FIXED_SHUNT * data->gain *
 				data->config->power_calculate_factor, 4 * 100 * data->rshunt);
 		/* Clamp value to maximum value of long */
 		*val = clamp_val(power, 0, LONG_MAX);
@@ -395,7 +395,7 @@ static int ina238_read_power(struct device *dev, u32 attr, long *val)
 		 * Truncated 24-bit compare register, lower 8-bits are
 		 * truncated. Same conversion to/from uW as POWER register.
 		 */
-		power = div_u64((regval << 8) * 1000ULL * INA238_FIXED_SHUNT *	data->gain *
+		power = div_u64((regval << 8) * 1000ULL * INA238_FIXED_SHUNT * data->gain *
 				data->config->power_calculate_factor, 4 * 100 * data->rshunt);
 		/* Clamp value to maximum value of long */
 		*val = clamp_val(power, 0, LONG_MAX);
@@ -448,7 +448,7 @@ static int ina238_read_temp(struct device *dev, u32 attr, long *val)
 			return err;
 		/* Signed, result in mC */
 		*val = div_s64(((s64)((s16)regval) >> data->config->temp_shift) *
-						(s64)data->config->temp_lsb, 10000);
+			       (s64)data->config->temp_lsb, 10000);
 		break;
 	case hwmon_temp_max:
 		err = regmap_read(data->regmap, INA238_TEMP_LIMIT, &regval);
@@ -456,7 +456,7 @@ static int ina238_read_temp(struct device *dev, u32 attr, long *val)
 			return err;
 		/* Signed, result in mC */
 		*val = div_s64(((s64)((s16)regval) >> data->config->temp_shift) *
-						(s64)data->config->temp_lsb, 10000);
+			       (s64)data->config->temp_lsb, 10000);
 		break;
 	case hwmon_temp_max_alarm:
 		err = regmap_read(data->regmap, INA238_DIAG_ALERT, &regval);
@@ -501,8 +501,8 @@ static ssize_t energy1_input_show(struct device *dev,
 		return ret;
 
 	/* result in uJ */
-	energy = div_u64(regval * INA238_FIXED_SHUNT *	data->gain * 16 * 10 *
-				data->config->power_calculate_factor, 4 * data->rshunt);
+	energy = div_u64(regval * INA238_FIXED_SHUNT * data->gain * 16 * 10 *
+			 data->config->power_calculate_factor, 4 * data->rshunt);
 
 	return sysfs_emit(buf, "%llu\n", energy);
 }
@@ -776,7 +776,7 @@ MODULE_DEVICE_TABLE(of, ina238_of_match);
 
 static struct i2c_driver ina238_driver = {
 	.driver = {
-		.name	= "ina238",
+		.name = "ina238",
 		.of_match_table = of_match_ptr(ina238_of_match),
 	},
 	.probe		= ina238_probe,

-- 
2.39.5


