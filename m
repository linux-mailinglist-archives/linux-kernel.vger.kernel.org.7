Return-Path: <linux-kernel+bounces-894859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE26C4C43B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA31B188D26C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1632FE592;
	Tue, 11 Nov 2025 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DG9tKP4o"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517DA2DC76C;
	Tue, 11 Nov 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848415; cv=none; b=l+3Iaz+zkjaljmwfr/kOO59Hd5ZVF8VAMMM1EhCulQ4gM+hSl4M/GwTb5pWzNMJhcwU2fqJec9zwEq4iicLG0z6DPWFuLxZxdNf/PboJJfUl7l6Q0EEZI3BszRSOJ9CioHVXvzz7tFS0J//9CP3NzrLRvL6w4iItgTEO75ulrOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848415; c=relaxed/simple;
	bh=tCJwoIaGiZq8Ti0DKR9c2/aeT8QkjsEKAC6DwjQ/L5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SH70KeXtUwn89GHHXTQ9YFVHH6TdnLS3NtlhsB1TjZjtxgdI3R8BgVZZFznEkJhnFN/Wk9dE9ldCyueSfCFn2LS9dXgAId12gq93uNQKnah+IWjxUkYtwX1CvtrY8ofYFgrFVrxfAlQpqqGomIpyNIs8perHssv2ZOmAPLhqeM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DG9tKP4o; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=3t0h6n+eqtjIrFM
	pOBvIO1k86GOu1HiS+K0i+CYmE0M=; b=DG9tKP4oGXDyjYP/uvMpDRWOmDdkSNx
	cWRw6iPpnSlcoJ64JZGUSPyAoeR+b+cnczhXjLdBAoSvJL7R2bHJwZGnah0NzKm2
	eqshPTH+EHOEqJBXl/BaCwU7Ux0EicvkZQR/GQB9nnEARqvBHlJEAf3KujtWKNjE
	bDwwQzY/dqF8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnq6ln7hJpK0KCDA--.117S5;
	Tue, 11 Nov 2025 16:06:08 +0800 (CST)
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
Subject: [PATCH 3/8] hwmon:(ina3221)Support alert-type
Date: Tue, 11 Nov 2025 03:05:41 -0500
Message-Id: <20251111080546.32421-4-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111080546.32421-1-wenliang202407@163.com>
References: <20251111080546.32421-1-wenliang202407@163.com>
X-CM-TRANSID:_____wCnq6ln7hJpK0KCDA--.117S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4rCFyfKF1kAw47Jw45trb_yoWrCF1fpa
	yYyFyrtr12qF4Sg393KFs5CF1Fyw4xXrW7trn3W340vF47JryjvFyrGF1DtFyYkr1rZF17
	J3y7tFWUCw4DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUEfOwUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbibgED02kS5prMFwAAsj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

SQ52210 supports setting alert-type, and this parameter has been
described in the devicetree. Add support for it to the driver.

Signed-off-by: Wenliang Yan <wenliang202407@163.com>
---
 drivers/hwmon/ina3221.c | 73 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 80c1bcc7edd7..ee9ad022e255 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -65,6 +65,8 @@
 
 #define INA3221_MASK_ENABLE_SCC_MASK	GENMASK(14, 12)
 
+#define SQ52210_ALERT_CONFIG_MASK	GENMASK(15, 4)
+
 #define INA3221_CONFIG_DEFAULT		0x7127
 #define INA3221_RSHUNT_DEFAULT		10000
 
@@ -105,6 +107,13 @@ enum ina3221_channels {
 	INA3221_NUM_CHANNELS
 };
 
+enum ina3221_alert_type {
+	SUL,
+	BOL,
+	BUL,
+	POL
+};
+
 /**
  * struct ina3221_input - channel input source specific information
  * @label: label of channel input source
@@ -121,9 +130,15 @@ struct ina3221_input {
 
 enum ina3221_ids { ina3221, sq52210 };
 
+struct ina3221_config {
+	bool has_alerts;	/* chip supports alerts and limits */
+	bool has_current;	/* chip has internal current reg */
+	bool has_power;		/* chip has internal power reg */
+};
 
 /**
  * struct ina3221_data - device specific information
+ * @config:	Used to store characteristics of different chips
  * @chip: Chip type identifier
  * @pm_dev: Device pointer for pm runtime
  * @regmap: Register map of the device
@@ -132,9 +147,11 @@ enum ina3221_ids { ina3221, sq52210 };
  * @reg_config: Register value of INA3221_CONFIG
  * @summation_shunt_resistor: equivalent shunt resistor value for summation
  * @summation_channel_control: Value written to SCC field in INA3221_MASK_ENABLE
+ * @alert_type_select: Used to store the alert trigger type
  * @single_shot: running in single-shot operating mode
  */
 struct ina3221_data {
+	const struct ina3221_config *config;
 	enum ina3221_ids chip;
 
 	struct device *pm_dev;
@@ -144,10 +161,24 @@ struct ina3221_data {
 	u32 reg_config;
 	int summation_shunt_resistor;
 	u32 summation_channel_control;
+	u32 alert_type_select;
 
 	bool single_shot;
 };
 
+static const struct ina3221_config ina3221_config[] = {
+	[ina3221] = {
+		.has_alerts = false,
+		.has_current = false,
+		.has_power = false,
+	},
+	[sq52210] = {
+		.has_alerts = true,
+		.has_current = true,
+		.has_power = true,
+	},
+};
+
 static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
 {
 	/* Summation channel checks shunt resistor values */
@@ -772,7 +803,7 @@ static int ina3221_probe_child_from_dt(struct device *dev,
 				       struct ina3221_data *ina)
 {
 	struct ina3221_input *input;
-	u32 val;
+	u32 val, alert_type;
 	int ret;
 
 	ret = of_property_read_u32(child, "reg", &val);
@@ -792,6 +823,34 @@ static int ina3221_probe_child_from_dt(struct device *dev,
 		return 0;
 	}
 
+	if (ina->config->has_alerts) {
+		ret = of_property_read_u32(child, "alert-type", &alert_type);
+		if (ret < 0) {
+			dev_err(dev, "missing alert-type property of %pOFn\n", child);
+			return ret;
+		} else if (alert_type > POL) {
+			dev_err(dev, "invalid alert-type of %pOFn\n", child);
+			return -EINVAL;
+		}
+		switch (alert_type) {
+		/* val is channel value*/
+		case SUL:
+			ina->alert_type_select |= BIT(15 - val);
+			break;
+		case BOL:
+			ina->alert_type_select |= BIT(12 - val);
+			break;
+		case BUL:
+			ina->alert_type_select |= BIT(9 - val);
+			break;
+		case POL:
+			ina->alert_type_select |= BIT(6 - val);
+			break;
+		default:
+			break;
+		}
+	}
+
 	/* Save the connected input label if available */
 	of_property_read_string(child, "label", &input->label);
 
@@ -847,6 +906,7 @@ static int ina3221_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	ina->chip = chip;
+	ina->config = &ina3221_config[chip];
 
 	ina->regmap = devm_regmap_init_i2c(client, &ina3221_regmap_config);
 	if (IS_ERR(ina->regmap)) {
@@ -1012,6 +1072,17 @@ static int ina3221_resume(struct device *dev)
 		}
 	}
 
+	/* Restore alert config register value to hardware */
+	if (ina->config->has_alerts) {
+		ret = regmap_update_bits(ina->regmap, SQ52210_ALERT_CONFIG,
+					 SQ52210_ALERT_CONFIG_MASK,
+					 ina->alert_type_select);
+		if (ret) {
+			dev_err(dev, "Unable to select alert type\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.17.1


