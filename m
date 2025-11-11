Return-Path: <linux-kernel+bounces-894863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A48C4C4CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A233BCF61
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E8E32ABC6;
	Tue, 11 Nov 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TuIW0osF"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F097230101C;
	Tue, 11 Nov 2025 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848418; cv=none; b=OphLi70eIKWiQqN3eXv494Jyo7M7Jm2NNzIj4sX05jEjnHpeAc33u/+1rJ4NTCLhHL6DS8fboFoWlEgtS8OOOEyNc2uBjGAU/0w/m4S2O1QFyko7ewZ3j7yEH7SGF37iGtcZiQZ69+YYWqPdMpnwAUvoHkydm7Cz5b2aBZpSFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848418; c=relaxed/simple;
	bh=y1fCoBC0tr7peb4Zw09/a/qXfy64/5c380Uo5N8RblE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kXPS1urKpoWFmJzV/tOwHZ8/5N4oBBdKz8uhsiRI5N9ykHmUi7FdjyQtwREdiZe/CysNTFX1TUMRl9LifOx3s9HdZMn793kWyl/pTzvxL73prGTbWiC4ud4FHXLfhYqULB6jxhSuOYnNUa2Tj7Ro8OG08Jy3CEe0XGxZogsm1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TuIW0osF; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=HW1AjLFpbCzDd1F
	kQpNb+K2o12psfz4Vu11gila8P9o=; b=TuIW0osFnwlSj5aSVaVUVflEev2GhEg
	fqlEXLOJMh0J7U+hapshabBwZmrpJK4IHLjsya+x7lN69FjLSC9Z4HxQmNbyObgi
	MZ+jpHccbKHDYcuYCX8XvQyH4a2Yacxttw1b0bvQPo5p6DlZmFT1qq7CljaHlebx
	GqDNZRfbtD/Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnq6ln7hJpK0KCDA--.117S9;
	Tue, 11 Nov 2025 16:06:15 +0800 (CST)
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
Subject: [PATCH 7/8] hwmon:(ina3221)Support read/write functions for 'power' attribute
Date: Tue, 11 Nov 2025 03:05:45 -0500
Message-Id: <20251111080546.32421-8-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111080546.32421-1-wenliang202407@163.com>
References: <20251111080546.32421-1-wenliang202407@163.com>
X-CM-TRANSID:_____wCnq6ln7hJpK0KCDA--.117S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF45ZFWxCr1rur4DWF48WFg_yoWrWFWkpw
	4DCFy5tw42qF1SvwsakF4DKw1Ykr4xX3y2yr9Fkwnava1UAr90gFyrJa4vyry5Cry3XF47
	JayxJF15u3ZrKr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUX0ePUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbibhED02kS5prMugABsf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

SQ52210 adds power attribute to report power data, and implements
read/write functions for this purpose.

Signed-off-by: Wenliang Yan <wenliang202407@163.com>
---
 drivers/hwmon/ina3221.c | 79 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index abb6049c8eab..ea01687ad1fa 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -348,19 +348,16 @@ static const u8 ina3221_in_reg[] = {
 	INA3221_SHUNT3,
 	INA3221_SHUNT_SUM,
 };
-
 static const u8 alert_limit_reg[] = {
 	SQ52210_ALERT_LIMIT1,
 	SQ52210_ALERT_LIMIT2,
 	SQ52210_ALERT_LIMIT3,
 };
-
 static const u8 alert_flag[] = {
 	F_AFF1,
 	F_AFF2,
 	F_AFF3,
 };
-
 /*
  * Turns alert limit values into register values.
  * Opposite of the formula in ina3221_read_value().
@@ -557,6 +554,61 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 	}
 }
 
+static const u8 ina3221_power_reg[][INA3221_NUM_CHANNELS] = {
+	[hwmon_power_input] = { SQ52210_POWER1, SQ52210_POWER2, SQ52210_POWER3 },
+	[hwmon_power_crit] = { SQ52210_ALERT_LIMIT1, SQ52210_ALERT_LIMIT2,
+						SQ52210_ALERT_LIMIT3 },
+	[hwmon_power_crit_alarm] = { F_AFF1, F_AFF2, F_AFF3 },
+};
+
+static int ina3221_read_power(struct device *dev, u32 attr, int channel, long *val)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	u8 reg = ina3221_power_reg[attr][channel];
+	int regval, ret;
+
+	switch (attr) {
+	case hwmon_power_input:
+		if (!ina3221_is_enabled(ina, channel))
+			return -ENODATA;
+
+		/* Write CONFIG register to trigger a single-shot measurement */
+		if (ina->single_shot) {
+			regmap_write(ina->regmap, INA3221_CONFIG,
+				     ina->reg_config);
+
+			ret = ina3221_wait_for_data(ina);
+			if (ret)
+				return ret;
+		}
+
+		ret = ina3221_read_value(ina, reg, &regval);
+		if (ret)
+			return ret;
+		/* Return power in mW */
+		*val = DIV_ROUND_CLOSEST(regval * ina->power_lsb_uW, 1000);
+		return 0;
+	case hwmon_power_crit:
+		reg = ina3221_power_reg[attr][channel];
+		ret = ina3221_read_value(ina, reg, &regval);
+		if (ret)
+			return ret;
+		/* Return power in mW */
+		*val = DIV_ROUND_CLOSEST(regval * ina->power_lsb_uW, 1000);
+		return 0;
+	case hwmon_power_crit_alarm:
+		reg = ina3221_power_reg[attr][channel];
+		ret = regmap_field_read(ina->fields[reg], &regval);
+		if (ret)
+			return ret;
+		*val = regval;
+		return 0;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const u32 sq52210_alert_mask[][INA3221_NUM_CHANNELS] = {
 	[hwmon_curr_lcrit] = { BIT(15), BIT(14), BIT(13) },
 	[hwmon_in_crit] = { BIT(12), BIT(11), BIT(10) },
@@ -760,6 +812,19 @@ static int ina3221_write_in(struct device *dev, u32 attr, int channel, long val)
 		return 0;
 	}
 }
+
+static int ina3221_write_power(struct device *dev, u32 attr, int channel, long val)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_power_crit:
+		return sq52210_alert_limit_write(ina, attr, channel, val);
+	default:
+		return 0;
+	}
+}
+
 static int ina3221_read(struct device *dev, enum hwmon_sensor_types type,
 			u32 attr, int channel, long *val)
 {
@@ -776,6 +841,9 @@ static int ina3221_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_curr:
 		ret = ina3221_read_curr(dev, attr, channel, val);
 		break;
+	case hwmon_power:
+		ret = ina3221_read_power(dev, attr, channel, val);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
@@ -799,6 +867,9 @@ static int ina3221_write(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_curr:
 		ret = ina3221_write_curr(dev, attr, channel, val);
 		break;
+	case hwmon_power:
+		ret = ina3221_write_power(dev, attr, channel, val);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
@@ -977,7 +1048,7 @@ static int ina3221_set_shunt(struct ina3221_data *ina, unsigned long val)
 
 	ina->current_lsb_uA = DIV_ROUND_CLOSEST(SQ52210_SHUNT_LSB, val);
 	ina->power_lsb_uW = ina->config->power_lsb_factor *
-			    ina->current_lsb_uA;
+			     ina->current_lsb_uA;
 
 	return 0;
 }
-- 
2.17.1


