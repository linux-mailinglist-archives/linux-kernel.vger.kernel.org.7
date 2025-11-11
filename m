Return-Path: <linux-kernel+bounces-894862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A71C4C4CD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDF03A799F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A97432ABC2;
	Tue, 11 Nov 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BhF6FnYV"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87D02FE048;
	Tue, 11 Nov 2025 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848418; cv=none; b=VfOZlK0yYa83BkWxaN40Ri4FkSGQU0PdXiVLYdVPTkGZHudiQ568mcLRF0AXVBN/mH+AW7scqAXhvmHGR3sQclosqSRAEIVT2DPT948P32YrCwDn2DouPdzoVt1qvB7Wwt0OoQgIYgn7iyju1oWN05nJEM7HuZgUmMypAs2v6TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848418; c=relaxed/simple;
	bh=/CQD0JuXmJsLneSrO8cvd0Zi3WkiFrrhr9la3zE8qpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SF88ydUY4tlJ9QKEiNk9HxjODEj+Co1hAj9xpwrvklDD/HXCQKvMK3zjBHfCpPBlDDcsnsfH7ahPvOBwlGHoIP2Qc3hFqYKkHSdk0M7Ay7JKXE2H1DfGensNubbVyot6gIZHIz3HwxF6/KHjtbFUH0HduT9oaIthafZzw1+xPBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BhF6FnYV; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=uIk9YEbVqKa78zM
	3O+6rXPgrFM9bXFI0U3T7LjIm8UI=; b=BhF6FnYV4oz1h5x59flWJGMnZkNRABG
	UN53Z4JYCLJ4gzD0Ggq+al9i9o7sXm2NoYZMX8+i7U1fVg4sARPqLbidIFBgvaxf
	H4sfX1/DkIB0FN2ccjrx0/85Y7XioLKbxI47tiFhUu9xE8L41NU6CCT+xJ/Pxo22
	V9rhWdGfGv40=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnq6ln7hJpK0KCDA--.117S8;
	Tue, 11 Nov 2025 16:06:14 +0800 (CST)
From: Wenliang Yan <wenliang202407@163.com>
To: linux@roeck-us.net,
	Jean Delvare <jdelvare@suse.com>
Cc: christophe.jaillet@wanadoo.fr,
	conor+dt@kernel.org,
	corbet@lwn.net,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	wenliang202407@163.com
Subject: [PATCH 6/8] hwmon:(ina3221)Modify read/write functions for 'in' attribute
Date: Tue, 11 Nov 2025 03:05:44 -0500
Message-Id: <20251111080546.32421-7-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111080546.32421-1-wenliang202407@163.com>
References: <20251111080546.32421-1-wenliang202407@163.com>
X-CM-TRANSID:_____wCnq6ln7hJpK0KCDA--.117S8
X-Coremail-Antispam: 1Uf129KBjvJXoW3ArW3tr1DtrW5Cr45ArW5ZFb_yoW3ZryUp3
	yfCFWrtr17tr1S9rs7KFs5Gr1FyrZ7W3y2yr9rK3sava1UAFyku348Ja9Yvry5CryfXan2
	q3y7AFyUCanrJFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUX0ePUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/xtbCvxa3i2kS7nZY9wAA3Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

SQ52210 adds current, power, and alert-limit sensors, with read/write
functions modified to accommodate these new changes.

The ina3221_read_value function has been rewritten to adapt to the
new register format for data reading.

The sq52210_alert_to_reg function has been added to handle reading
of different data types.

Each channel supports four new alert trigger modes, with only one
trigger active at any given time. Alert values are stored in the
same register. The sq52210_alert_limit_write function has been
implemented for writing alert threshold values.

The 'in' read/write functions have been modified to add crit,
lcrit, crit_alarm, and lcrit_alarm characteristics.

Signed-off-by: Wenliang Yan <wenliang202407@163.com>
---
 drivers/hwmon/ina3221.c | 182 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 178 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 77b2505a49a2..abb6049c8eab 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -66,6 +66,9 @@
 #define INA3221_MASK_ENABLE_SCC_MASK	GENMASK(14, 12)
 
 #define SQ52210_ALERT_CONFIG_MASK	GENMASK(15, 4)
+#define SQ52210_MASK_ALERT_CHANNEL1 (BIT(15) | BIT(12) | BIT(9) | BIT(6))
+#define SQ52210_MASK_ALERT_CHANNEL2 (BIT(14) | BIT(11) | BIT(8) | BIT(5))
+#define SQ52210_MASK_ALERT_CHANNEL3 (BIT(13) | BIT(10) | BIT(7) | BIT(4))
 
 #define INA3221_CONFIG_DEFAULT		0x7127
 #define INA3221_RSHUNT_DEFAULT		10000
@@ -84,6 +87,9 @@ enum ina3221_fields {
 	/* Alert Flags: SF is the summation-alert flag */
 	F_SF, F_CF3, F_CF2, F_CF1,
 
+	/* Alert Flags: AFF is the alert function flag */
+	F_AFF3, F_AFF2, F_AFF1,
+
 	/* sentinel */
 	F_MAX_FIELDS
 };
@@ -99,6 +105,10 @@ static const struct reg_field ina3221_reg_fields[] = {
 	[F_CF3] = REG_FIELD(INA3221_MASK_ENABLE, 7, 7),
 	[F_CF2] = REG_FIELD(INA3221_MASK_ENABLE, 8, 8),
 	[F_CF1] = REG_FIELD(INA3221_MASK_ENABLE, 9, 9),
+
+	[F_AFF3] = REG_FIELD(SQ52210_ALERT_CONFIG, 1, 1),
+	[F_AFF2] = REG_FIELD(SQ52210_ALERT_CONFIG, 2, 2),
+	[F_AFF1] = REG_FIELD(SQ52210_ALERT_CONFIG, 3, 3),
 };
 
 enum ina3221_channels {
@@ -293,11 +303,39 @@ static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
 	 * Shunt Voltage Sum register has 14-bit value with 1-bit shift
 	 * Other Shunt Voltage registers have 12 bits with 3-bit shift
 	 */
-	if (reg == INA3221_SHUNT_SUM || reg == INA3221_CRIT_SUM)
+	switch (reg) {
+	case INA3221_SHUNT_SUM:
+	case INA3221_CRIT_SUM:
 		*val = sign_extend32(regval >> 1, 14);
-	else
+		break;
+	case SQ52210_CURRENT1:
+	case SQ52210_CURRENT2:
+	case SQ52210_CURRENT3:
+	case SQ52210_POWER1:
+	case SQ52210_POWER2:
+	case SQ52210_POWER3:
+		*val = regval;
+		break;
+	case INA3221_BUS1:
+	case INA3221_BUS2:
+	case INA3221_BUS3:
+	case INA3221_SHUNT1:
+	case INA3221_SHUNT2:
+	case INA3221_SHUNT3:
+	case INA3221_WARN1:
+	case INA3221_WARN2:
+	case INA3221_WARN3:
+	case INA3221_CRIT1:
+	case INA3221_CRIT2:
+	case INA3221_CRIT3:
 		*val = sign_extend32(regval >> 3, 12);
-
+		break;
+	case SQ52210_ALERT_LIMIT1:
+	case SQ52210_ALERT_LIMIT2:
+	case SQ52210_ALERT_LIMIT3:
+		*val = regval >> 3;
+		break;
+	};
 	return 0;
 }
 
@@ -311,6 +349,56 @@ static const u8 ina3221_in_reg[] = {
 	INA3221_SHUNT_SUM,
 };
 
+static const u8 alert_limit_reg[] = {
+	SQ52210_ALERT_LIMIT1,
+	SQ52210_ALERT_LIMIT2,
+	SQ52210_ALERT_LIMIT3,
+};
+
+static const u8 alert_flag[] = {
+	F_AFF1,
+	F_AFF2,
+	F_AFF3,
+};
+
+/*
+ * Turns alert limit values into register values.
+ * Opposite of the formula in ina3221_read_value().
+ */
+static u16 sq52210_alert_to_reg(struct ina3221_data *ina, int reg, long val)
+{
+	int regval;
+	/*
+	 * Formula to convert voltage_uv to register value:
+	 *     regval = (voltage_mv / scale) << shift
+	 * Results:
+	 *     bus_voltage: (1 / 8mV) << 3 = 1 mV
+	 */
+	switch (reg) {
+	case INA3221_BUS1:
+	case INA3221_BUS2:
+	case INA3221_BUS3:
+		/* clamp voltage */
+		regval = clamp_val(val, -32760, 32760);
+		return regval;
+	case SQ52210_CURRENT1:
+	case SQ52210_CURRENT2:
+	case SQ52210_CURRENT3:
+		/* signed register, result in mA */
+		regval = DIV_ROUND_CLOSEST(val * 8000, ina->current_lsb_uA);
+		return clamp_val(regval, -32760, 32760);
+	case SQ52210_POWER1:
+	case SQ52210_POWER2:
+	case SQ52210_POWER3:
+		regval = DIV_ROUND_CLOSEST(val * 8000, ina->power_lsb_uW);
+		return clamp_val(regval, 0, 65528);
+	default:
+		/* programmer goofed */
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
 static int ina3221_read_chip(struct device *dev, u32 attr, long *val)
 {
 	struct ina3221_data *ina = dev_get_drvdata(dev);
@@ -373,6 +461,25 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
 	case hwmon_in_enable:
 		*val = ina3221_is_enabled(ina, channel);
 		return 0;
+	case hwmon_in_crit:
+	case hwmon_in_lcrit:
+		reg = alert_limit_reg[channel];
+		ret = ina3221_read_value(ina, reg, &regval);
+		if (ret)
+			return ret;
+		/*
+		 * Scale of bus voltage (mV): LSB is 8mV
+		 */
+		*val = regval * 8;
+		return 0;
+	case hwmon_in_crit_alarm:
+	case hwmon_in_lcrit_alarm:
+		reg = alert_flag[channel];
+		ret = regmap_field_read(ina->fields[reg], &regval);
+		if (ret)
+			return ret;
+		*val = regval;
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -450,6 +557,58 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 	}
 }
 
+static const u32 sq52210_alert_mask[][INA3221_NUM_CHANNELS] = {
+	[hwmon_curr_lcrit] = { BIT(15), BIT(14), BIT(13) },
+	[hwmon_in_crit] = { BIT(12), BIT(11), BIT(10) },
+	[hwmon_in_lcrit] = { BIT(9), BIT(8), BIT(7) },
+	[hwmon_power_crit] = { BIT(6), BIT(5), BIT(4) },
+};
+
+static int sq52210_alert_limit_write(struct ina3221_data *ina, u32 attr, int channel, long val)
+{
+	struct regmap *regmap = ina->regmap;
+	int ret, limit_reg, item;
+	u32 alert_group;
+
+	if (val < 0)
+		return -EINVAL;
+	item = channel % INA3221_NUM_CHANNELS;
+	switch (item) {
+	case 0:
+		alert_group = SQ52210_MASK_ALERT_CHANNEL1;
+		limit_reg = SQ52210_ALERT_LIMIT1;
+		break;
+	case 1:
+		alert_group = SQ52210_MASK_ALERT_CHANNEL2;
+		limit_reg = SQ52210_ALERT_LIMIT2;
+		break;
+	case 2:
+		alert_group = SQ52210_MASK_ALERT_CHANNEL3;
+		limit_reg = SQ52210_ALERT_LIMIT3;
+		break;
+	default:
+		break;
+	}
+	/*
+	 * Clear all alerts first to avoid accidentally triggering ALERT pin
+	 * due to register write sequence. Then, only enable the alert
+	 * if the value is non-zero.
+	 */
+	ret = regmap_update_bits(regmap, SQ52210_ALERT_CONFIG,
+				alert_group, 0);
+	if (ret < 0)
+		return ret;
+	ret = regmap_write(regmap, limit_reg,
+			sq52210_alert_to_reg(ina, ina3221_curr_reg[attr][item], val));
+	if (ret < 0)
+		return ret;
+
+	if (val)
+		return regmap_update_bits(regmap, SQ52210_ALERT_CONFIG,
+					alert_group, sq52210_alert_mask[attr][item]);
+	return 0;
+}
+
 static int ina3221_write_chip(struct device *dev, u32 attr, long val)
 {
 	struct ina3221_data *ina = dev_get_drvdata(dev);
@@ -586,6 +745,21 @@ static int ina3221_write_enable(struct device *dev, int channel, bool enable)
 	return ret;
 }
 
+static int ina3221_write_in(struct device *dev, u32 attr, int channel, long val)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_in_lcrit:
+		return sq52210_alert_limit_write(ina, attr, channel, val);
+	case hwmon_in_crit:
+		return sq52210_alert_limit_write(ina, attr, channel, val);
+	case hwmon_in_enable:
+		return ina3221_write_enable(dev, channel, val);
+	default:
+		return 0;
+	}
+}
 static int ina3221_read(struct device *dev, enum hwmon_sensor_types type,
 			u32 attr, int channel, long *val)
 {
@@ -620,7 +794,7 @@ static int ina3221_write(struct device *dev, enum hwmon_sensor_types type,
 		break;
 	case hwmon_in:
 		/* 0-align channel ID */
-		ret = ina3221_write_enable(dev, channel - 1, val);
+		ret = ina3221_write_in(dev, attr, channel - 1, val);
 		break;
 	case hwmon_curr:
 		ret = ina3221_write_curr(dev, attr, channel, val);
-- 
2.17.1


