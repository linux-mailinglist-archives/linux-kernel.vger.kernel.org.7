Return-Path: <linux-kernel+bounces-894858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A09CEC4C3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9592C34C62E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD412F7AB4;
	Tue, 11 Nov 2025 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZkM7/ght"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939BA231A30;
	Tue, 11 Nov 2025 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848413; cv=none; b=UfYGCrBB/DaOkSmUBnvIOa6ukHtiXZgvHzQVy+CaIrg0d3zHxwT+P3Cp84MOFaqOAzZVudUONrs/izVgepuLeBypc3nS1gw3Z2soU6+io83FcPVMQKCMfkHS/VMb6Gf5nJn5C3VFCwnElXDwtDmNCpRgJDZxsJsvcISnqveEzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848413; c=relaxed/simple;
	bh=2/1cvaRQNmLbWNfXH2IHq3wirvMjh17yqDgS7BCiXhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SfMNhxyIPLsjCGQBfutI7ihciqpYReH+iXy6M24UIYz1oEyeQjpuIRccN8ZpKV7XZmIrbgX+A7dkIbW5lQuTThy0ofY2+UTGx7NLKd4nDB+vqFcYrDMjmSN/fZl7xCrKjy1nH/GyrYqwCaFs8nwmUOTM64TjbdBYrqs4mwzEUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZkM7/ght; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=jyygY7O70/zK+La
	2Mnqd8X8wqYmBF5ypQLHKNTfsnys=; b=ZkM7/ghttr2Jkzu89YXMoWvuBREPVSi
	ok/agrJUxWlUq1vY2LYYllVNLTZuYyfLJkrdwyzipTWJvbqTGq3olwMvUzyTfnFu
	q3dw8iI37uOXC5LCd3qdmGB8eH87XgCXXo6U2IWYoGIa4e8FJBHxdL0PVfluydAI
	Wj6+U8Y4OkZU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnq6ln7hJpK0KCDA--.117S6;
	Tue, 11 Nov 2025 16:06:10 +0800 (CST)
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
Subject: [PATCH 4/8] hwmon:(ina3221)Pre-calculate current and power LSB
Date: Tue, 11 Nov 2025 03:05:42 -0500
Message-Id: <20251111080546.32421-5-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111080546.32421-1-wenliang202407@163.com>
References: <20251111080546.32421-1-wenliang202407@163.com>
X-CM-TRANSID:_____wCnq6ln7hJpK0KCDA--.117S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy7WFW8ZF4UWr1rZr43Jrb_yoW7Jr45pF
	4fGFy5ta4jq3WSga9Ikan7GF1rt34xJF47trsrG34IqanrKryq9ayrJa4DtFy5Ary5ZF17
	X3yDtr4DCan7AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUFLvNUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbiRxoD02kS5gDbPgAAs1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The LSB for current and power can be pre-calculated for data read/write
operations. The current LSB is determined by the calibration value and
shunt resistor value, with the calibration value fixed within the driver.
The power LSB can be derived from the current LSB.

Use DIV_ROUND_CLOSEST function to replace division operations and reduce
rouding errors.

Signed-off-by: Wenliang Yan <wenliang202407@163.com>
---
 drivers/hwmon/ina3221.c | 71 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index ee9ad022e255..e339860ed3a2 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -69,6 +69,7 @@
 
 #define INA3221_CONFIG_DEFAULT		0x7127
 #define INA3221_RSHUNT_DEFAULT		10000
+#define SQ52210_SHUNT_LSB			40000000	/* pV/LSB */
 
 enum ina3221_fields {
 	/* Configuration */
@@ -134,6 +135,8 @@ struct ina3221_config {
 	bool has_alerts;	/* chip supports alerts and limits */
 	bool has_current;	/* chip has internal current reg */
 	bool has_power;		/* chip has internal power reg */
+	int calibration_value;	/* calculate current_lsb */
+	int power_lsb_factor;
 };
 
 /**
@@ -148,6 +151,8 @@ struct ina3221_config {
  * @summation_shunt_resistor: equivalent shunt resistor value for summation
  * @summation_channel_control: Value written to SCC field in INA3221_MASK_ENABLE
  * @alert_type_select: Used to store the alert trigger type
+ * @current_lsb_uA: The value of one LSB corresponding to the current register
+ * @power_lsb_uW: The value of one LSB corresponding to the power register
  * @single_shot: running in single-shot operating mode
  */
 struct ina3221_data {
@@ -162,6 +167,8 @@ struct ina3221_data {
 	int summation_shunt_resistor;
 	u32 summation_channel_control;
 	u32 alert_type_select;
+	long current_lsb_uA;
+	long power_lsb_uW;
 
 	bool single_shot;
 };
@@ -176,6 +183,13 @@ static const struct ina3221_config ina3221_config[] = {
 		.has_alerts = true,
 		.has_current = true,
 		.has_power = true,
+		/*
+		 * With this default value configuration,
+		 * the following formula can be obtained:
+		 * Current_LSB = Shunt_LSB / Rshunt
+		 */
+		.calibration_value = 256,
+		.power_lsb_factor = 20,
 	},
 };
 
@@ -729,6 +743,25 @@ static const struct hwmon_chip_info ina3221_chip_info = {
 };
 
 /* Extra attribute groups */
+
+/*
+ * Calculate the value corresponding to one LSB of the current and
+ * power registers.
+ * formula : Current_LSB = Shunt_LSB / Rshunt
+ *			 Power_LSB = power_lsb_factor * Current_LSB
+ */
+static int ina3221_set_shunt(struct ina3221_data *ina, unsigned long val)
+{
+	if (!val || val > SQ52210_SHUNT_LSB)
+		return -EINVAL;
+
+	ina->current_lsb_uA = DIV_ROUND_CLOSEST(SQ52210_SHUNT_LSB, val);
+	ina->power_lsb_uW = ina->config->power_lsb_factor *
+			    ina->current_lsb_uA;
+
+	return 0;
+}
+
 static ssize_t ina3221_shunt_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -761,7 +794,17 @@ static ssize_t ina3221_shunt_store(struct device *dev,
 
 	/* Update summation_shunt_resistor for summation channel */
 	ina->summation_shunt_resistor = ina3221_summation_shunt_resistor(ina);
-
+	/*
+	 * The current and power registers can only be used when
+	 * all enabled channels have identical shunt resistors
+	 */
+	if (ina->summation_shunt_resistor) {
+		if (ina->config->has_current) {
+			ret = ina3221_set_shunt(ina, val);
+			if (ret < 0)
+				return ret;
+		}
+	}
 	return count;
 }
 
@@ -953,6 +996,16 @@ static int ina3221_probe(struct i2c_client *client)
 			ina->summation_channel_control |= BIT(14 - i);
 	}
 
+	/*
+	 * The current and power registers can only be used when
+	 * all enabled channels have identical shunt resistors
+	 */
+	if (ina->summation_shunt_resistor) {
+		ret = ina3221_set_shunt(ina, ina->summation_shunt_resistor);
+		if (ret < 0)
+			return ret;
+	}
+
 	ina->pm_dev = dev;
 	dev_set_drvdata(dev, ina);
 
@@ -970,8 +1023,8 @@ static int ina3221_probe(struct i2c_client *client)
 	}
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, ina,
-							 &ina3221_chip_info,
-							 ina3221_groups);
+							&ina3221_chip_info,
+							ina3221_groups);
 	if (IS_ERR(hwmon_dev)) {
 		dev_err(dev, "Unable to register hwmon device\n");
 		ret = PTR_ERR(hwmon_dev);
@@ -1070,6 +1123,18 @@ static int ina3221_resume(struct device *dev)
 			dev_err(dev, "Unable to control summation channel\n");
 			return ret;
 		}
+		/*
+		 * The calibration register can only be enabled when all
+		 * shunt resistor values are identical.
+		 */
+		if (ina->config->has_current) {
+			ret = regmap_write(ina->regmap, SQ52210_CALIBRATION,
+						ina->config->calibration_value);
+			if (ret) {
+				dev_err(dev, "Unable to set calibration value\n");
+				return ret;
+			}
+		}
 	}
 
 	/* Restore alert config register value to hardware */
-- 
2.17.1


