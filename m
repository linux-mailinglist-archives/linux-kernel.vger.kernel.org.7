Return-Path: <linux-kernel+bounces-894861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7472CC4C4BE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC853BC72D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AC12DAFAA;
	Tue, 11 Nov 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="efXiPWVK"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87242FD7D0;
	Tue, 11 Nov 2025 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848418; cv=none; b=S3oSlu+t4309uXMhYxRCL52bhLS9rtg9+2bEAfj+AuO06od77PEJz+lEr+SQcJAUXpya9gslcd++AXP1ZHM0yOI/JfoWE8Zib2r+ElCZEFJiNUT8RO/9QmkYdb6RSyD+EHeXutykgPPqvpipAfCMDjKtg+wjM002kTitQowVnsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848418; c=relaxed/simple;
	bh=CX/PSWNrjKc+hEDePDyvgxX6zfLVBi/fR5WqiOSW9TA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UaY3EcyEoUkxOahzEz3yxTg5CISmPjZQ54i+AmckNYztCnO2XcvaGomjkpdji8ZWZyQ+M6+N+8gXzRkBdPN2Vx9oFAIOtl2Wi+D3x1dtgRoL9S7G/en5uBf92Nq9kwWE3gwFaAqIbLYLS2l3KNc6xK2KGlllSD5rBUY+s7mhCXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=efXiPWVK; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=qXolhaRWieEKrGJ
	SOG0StxPvKSJDw5mx4INVPcUdE/A=; b=efXiPWVKl9iwy1kAs5F/tXRUUlx6X3u
	Q9EjprHDErk6ulbKHcukAPPSmMlBp6gF05iLnapNyHWsq1DC6cdGScIYuABNtCVp
	Ytk6tH6CQ6qSLBIMCxj17mbN2f/jCSHHzMC/H5cGLowAkkz/arbFuO24Eu3qJPwp
	//+Q2kK5dD+Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnq6ln7hJpK0KCDA--.117S4;
	Tue, 11 Nov 2025 16:06:07 +0800 (CST)
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
Subject: [PATCH 2/8] hwmon:(ina3221)Add support for SQ52210
Date: Tue, 11 Nov 2025 03:05:40 -0500
Message-Id: <20251111080546.32421-3-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111080546.32421-1-wenliang202407@163.com>
References: <20251111080546.32421-1-wenliang202407@163.com>
X-CM-TRANSID:_____wCnq6ln7hJpK0KCDA--.117S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4rJw48Xry8GFWxAF1fJFb_yoW5Zw4xpa
	n5Ca4rtr45Xr4Ig3yfKFs5tF15tr4xG3yIvrnrK3yIvF4DAry0qF1rKw4qyr98ZFyfZF4U
	X342y3y8uwnrJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR8hL8UUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/xtbCvw+1iWkS7m9YDwAA3h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

SQ52210 is compatible with INA3221, but also includes current registers,
power registers, and registers related to alerts.

Signed-off-by: Wenliang Yan <wenliang202407@163.com>
---
 drivers/hwmon/ina3221.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 5ecc68dcf169..80c1bcc7edd7 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -34,6 +34,17 @@
 #define INA3221_SHUNT_SUM		0x0d
 #define INA3221_CRIT_SUM		0x0e
 #define INA3221_MASK_ENABLE		0x0f
+#define SQ52210_ALERT_CONFIG	0x12
+#define SQ52210_CALIBRATION		0x14
+#define SQ52210_CURRENT1		0x15
+#define SQ52210_CURRENT2		0x16
+#define SQ52210_CURRENT3		0x17
+#define SQ52210_POWER1			0x18
+#define SQ52210_POWER2			0x19
+#define SQ52210_POWER3			0x1A
+#define SQ52210_ALERT_LIMIT1	0x1B
+#define SQ52210_ALERT_LIMIT2	0x1C
+#define SQ52210_ALERT_LIMIT3	0x1D
 
 #define INA3221_CONFIG_MODE_MASK	GENMASK(2, 0)
 #define INA3221_CONFIG_MODE_POWERDOWN	0
@@ -108,8 +119,12 @@ struct ina3221_input {
 	bool summation_disable;
 };
 
+enum ina3221_ids { ina3221, sq52210 };
+
+
 /**
  * struct ina3221_data - device specific information
+ * @chip: Chip type identifier
  * @pm_dev: Device pointer for pm runtime
  * @regmap: Register map of the device
  * @fields: Register fields of the device
@@ -120,6 +135,8 @@ struct ina3221_input {
  * @single_shot: running in single-shot operating mode
  */
 struct ina3221_data {
+	enum ina3221_ids chip;
+
 	struct device *pm_dev;
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
@@ -734,6 +751,7 @@ static const struct regmap_range ina3221_yes_ranges[] = {
 	regmap_reg_range(INA3221_CONFIG, INA3221_BUS3),
 	regmap_reg_range(INA3221_SHUNT_SUM, INA3221_SHUNT_SUM),
 	regmap_reg_range(INA3221_MASK_ENABLE, INA3221_MASK_ENABLE),
+	regmap_reg_range(SQ52210_ALERT_CONFIG, SQ52210_POWER3),
 };
 
 static const struct regmap_access_table ina3221_volatile_table = {
@@ -818,13 +836,18 @@ static int ina3221_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct ina3221_data *ina;
 	struct device *hwmon_dev;
+	enum ina3221_ids chip;
 	char name[32];
 	int i, ret;
 
+	chip = (uintptr_t)i2c_get_match_data(client);
+
 	ina = devm_kzalloc(dev, sizeof(*ina), GFP_KERNEL);
 	if (!ina)
 		return -ENOMEM;
 
+	ina->chip = chip;
+
 	ina->regmap = devm_regmap_init_i2c(client, &ina3221_regmap_config);
 	if (IS_ERR(ina->regmap)) {
 		dev_err(dev, "Unable to allocate register map\n");
@@ -996,13 +1019,21 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ina3221_pm, ina3221_suspend, ina3221_resume,
 				 NULL);
 
 static const struct of_device_id ina3221_of_match_table[] = {
-	{ .compatible = "ti,ina3221", },
+	{
+		.compatible = "silergy,sq52210",
+		.data = (void *)sq52210
+	},
+	{
+		.compatible = "ti,ina3221",
+		.data = (void *)ina3221
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ina3221_of_match_table);
 
 static const struct i2c_device_id ina3221_ids[] = {
-	{ "ina3221" },
+	{ "ina3221", ina3221 },
+	{ "sq52210", sq52210 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, ina3221_ids);
-- 
2.17.1


