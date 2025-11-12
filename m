Return-Path: <linux-kernel+bounces-897752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B929BC5379B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3AB135B87D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E334252D;
	Wed, 12 Nov 2025 16:33:28 +0000 (UTC)
Received: from mail.prodrive-technologies.com (mail.prodrive-technologies.com [212.61.153.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4FF34250C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.61.153.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965207; cv=none; b=fU8dzuybE9NCy7g/yC9/Q83vBFQ3Si3l4IgFtZWQ0+yiCAtlZt0i2KcJL8WWujgo+xU9MYCejheKqvJX0oDB0ZJTJk8CvZrBU9Xxz5a0lOTADuV6wzFAIM7H68qfjb+SjYtJ5wkCmSRxBtSENmH/ApDXiC3eGIHZolFZLJ7Hty4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965207; c=relaxed/simple;
	bh=9vWMazpI5btDdSq2LNtxK3ucEth8RCVpHckot45FST0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnT6b0W26ciKy++y6zQ5FprUsKw76K75xcA3vIlD+3qCWu7TOF28GZEeQOyq/w0/WjMjn570U/38sSgNFY729qxjNU4KdAx9a2vzzkWILEDkq0UHwiLAFvKoZf0TSZ/KPKc1gdaIQNj/ApdpjgybNPQF7LwMGHQfz9wyRKEtivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; arc=none smtp.client-ip=212.61.153.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Nov
 2025 17:33:23 +0100
Received: from lnxdevrm02.prodrive.nl (10.1.1.121) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport;
 Wed, 12 Nov 2025 17:33:23 +0100
From: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
CC: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] regulator: pca9450: Add support for setting debounce settings
Date: Wed, 12 Nov 2025 17:33:09 +0100
Message-ID: <20251112163311.720331-2-martijn.de.gouw@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251112163311.720331-1-martijn.de.gouw@prodrive-technologies.com>
References: <20251112163311.720331-1-martijn.de.gouw@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Make the different debounce timers configurable from the devicetree.
Depending on the board design, these have to be set different than the
default register values.

Signed-off-by: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
---
 drivers/regulator/pca9450-regulator.c | 158 ++++++++++++++++++++++----
 include/linux/regulator/pca9450.h     |  32 ++++++
 2 files changed, 171 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 4be270f4d6c35..82084d122cc12 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -1117,6 +1117,143 @@ static int pca9450_i2c_restart_handler(struct sys_off_data *data)
 	return 0;
 }
 
+static int pca9450_of_init(struct pca9450 *pca9450)
+{
+	struct i2c_client *i2c = container_of(pca9450->dev, struct i2c_client, dev);
+	int ret;
+	unsigned int val;
+	unsigned int reset_ctrl;
+	unsigned int rstb_deb_ctrl;
+	unsigned int t_on_deb, t_off_deb;
+	unsigned int t_on_step, t_off_step;
+	unsigned int t_restart;
+
+	if (of_property_read_bool(i2c->dev.of_node, "nxp,wdog_b-warm-reset"))
+		reset_ctrl = WDOG_B_CFG_WARM;
+	else
+		reset_ctrl = WDOG_B_CFG_COLD_LDO12;
+
+	/* Set reset behavior on assertion of WDOG_B signal */
+	ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_RESET_CTRL,
+				 WDOG_B_CFG_MASK, reset_ctrl);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Failed to set WDOG_B reset behavior\n");
+
+	ret = of_property_read_u32(i2c->dev.of_node, "npx,pmic_rst_b-debounce-ms", &val);
+	if (ret == -EINVAL)
+		rstb_deb_ctrl = T_PMIC_RST_DEB_50MS;
+	else if (ret)
+		return ret;
+	else {
+		switch (val) {
+		case 10: rstb_deb_ctrl = T_PMIC_RST_DEB_10MS; break;
+		case 50: rstb_deb_ctrl = T_PMIC_RST_DEB_50MS; break;
+		case 100: rstb_deb_ctrl = T_PMIC_RST_DEB_100MS; break;
+		case 500: rstb_deb_ctrl = T_PMIC_RST_DEB_500MS; break;
+		case 1000: rstb_deb_ctrl = T_PMIC_RST_DEB_1S; break;
+		case 2000: rstb_deb_ctrl = T_PMIC_RST_DEB_2S; break;
+		case 4000: rstb_deb_ctrl = T_PMIC_RST_DEB_4S; break;
+		case 8000: rstb_deb_ctrl = T_PMIC_RST_DEB_8S; break;
+		default: return -EINVAL;
+		}
+	}
+	ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_RESET_CTRL,
+				 T_PMIC_RST_DEB_MASK, rstb_deb_ctrl);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Failed to set PMIC_RST_B debounce time\n");
+
+	ret = of_property_read_u32(i2c->dev.of_node, "nxp,pmic_on_req-on-debounce-us", &val);
+	if (ret == -EINVAL)
+		t_on_deb = T_ON_DEB_20MS;
+	else if (ret)
+		return ret;
+	else {
+		switch (val) {
+		case 120: t_on_deb = T_ON_DEB_120US; break;
+		case 20000: t_on_deb = T_ON_DEB_20MS; break;
+		case 100000: t_on_deb = T_ON_DEB_100MS; break;
+		case 750000: t_on_deb = T_ON_DEB_750MS; break;
+		default: return -EINVAL;
+		}
+	}
+
+	ret = of_property_read_u32(i2c->dev.of_node, "nxp,pmic_on_req-off-debounce-us", &val);
+	if (ret == -EINVAL)
+		t_off_deb = T_OFF_DEB_120US;
+	else if (ret)
+		return ret;
+	else {
+		switch (val) {
+		case 120: t_off_deb = T_OFF_DEB_120US; break;
+		case 2000: t_off_deb = T_OFF_DEB_2MS; break;
+		default: return -EINVAL;
+		}
+	}
+
+	ret = of_property_read_u32(i2c->dev.of_node, "nxp,power-on-step-ms", &val);
+	if (ret == -EINVAL)
+		t_on_step = T_ON_STEP_2MS;
+	else if (ret)
+		return ret;
+	else {
+		switch (val) {
+		case 1: t_on_step = T_ON_STEP_1MS; break;
+		case 2: t_on_step = T_ON_STEP_2MS; break;
+		case 4: t_on_step = T_ON_STEP_4MS; break;
+		case 8: t_on_step = T_ON_STEP_8MS; break;
+		default: return -EINVAL;
+		}
+	}
+
+	ret = of_property_read_u32(i2c->dev.of_node, "nxp,power-down-step-ms", &val);
+	if (ret == -EINVAL)
+		t_off_step = T_OFF_STEP_8MS;
+	else if (ret)
+		return ret;
+	else {
+		switch (val) {
+		case 2: t_off_step = T_OFF_STEP_2MS; break;
+		case 4: t_off_step = T_OFF_STEP_4MS; break;
+		case 8: t_off_step = T_OFF_STEP_8MS; break;
+		case 16: t_off_step = T_OFF_STEP_16MS; break;
+		default: return -EINVAL;
+		}
+	}
+
+	ret = of_property_read_u32(i2c->dev.of_node, "nxp,restart-ms", &val);
+	if (ret == -EINVAL)
+		t_restart = T_RESTART_250MS;
+	else if (ret)
+		return ret;
+	else {
+		switch (val) {
+		case 250: t_restart = T_RESTART_250MS; break;
+		case 500: t_restart = T_RESTART_500MS; break;
+		default: return -EINVAL;
+		}
+	}
+
+	ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_PWRCTRL,
+				 T_ON_DEB_MASK | T_OFF_DEB_MASK | T_ON_STEP_MASK |
+				 T_OFF_STEP_MASK | T_RESTART_MASK,
+				 t_on_deb | t_off_deb | t_on_step |
+				 t_off_step | t_restart);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret,
+				     "Failed to set PWR_CTRL debounce configuration\n");
+
+	if (of_property_read_bool(i2c->dev.of_node, "nxp,i2c-lt-enable")) {
+		/* Enable I2C Level Translator */
+		ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_CONFIG2,
+					 I2C_LT_MASK, I2C_LT_ON_STANDBY_RUN);
+		if (ret)
+			return dev_err_probe(&i2c->dev, ret,
+					     "Failed to enable I2C level translator\n");
+	}
+
+	return 0;
+}
+
 static int pca9450_i2c_probe(struct i2c_client *i2c)
 {
 	enum pca9450_chip_type type = (unsigned int)(uintptr_t)
@@ -1126,7 +1263,6 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	struct regulator_dev *ldo5;
 	struct pca9450 *pca9450;
 	unsigned int device_id, i;
-	unsigned int reset_ctrl;
 	int ret;
 
 	pca9450 = devm_kzalloc(&i2c->dev, sizeof(struct pca9450), GFP_KERNEL);
@@ -1224,25 +1360,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return dev_err_probe(&i2c->dev, ret,  "Failed to clear PRESET_EN bit\n");
 
-	if (of_property_read_bool(i2c->dev.of_node, "nxp,wdog_b-warm-reset"))
-		reset_ctrl = WDOG_B_CFG_WARM;
-	else
-		reset_ctrl = WDOG_B_CFG_COLD_LDO12;
-
-	/* Set reset behavior on assertion of WDOG_B signal */
-	ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_RESET_CTRL,
-				 WDOG_B_CFG_MASK, reset_ctrl);
+	ret = pca9450_of_init(pca9450);
 	if (ret)
-		return dev_err_probe(&i2c->dev, ret, "Failed to set WDOG_B reset behavior\n");
-
-	if (of_property_read_bool(i2c->dev.of_node, "nxp,i2c-lt-enable")) {
-		/* Enable I2C Level Translator */
-		ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_CONFIG2,
-					 I2C_LT_MASK, I2C_LT_ON_STANDBY_RUN);
-		if (ret)
-			return dev_err_probe(&i2c->dev, ret,
-					     "Failed to enable I2C level translator\n");
-	}
+		return dev_err_probe(&i2c->dev, ret, "Unable to parse OF data\n");
 
 	/*
 	 * For LDO5 we need to be able to check the status of the SD_VSEL input in
diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
index 85b4fecc10d82..0df8b3c48082f 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -223,12 +223,44 @@ enum {
 #define IRQ_THERM_105			0x02
 #define IRQ_THERM_125			0x01
 
+/* PCA9450_REG_PWRCTRL bits */
+#define T_ON_DEB_MASK			0xC0
+#define T_ON_DEB_120US			(0 << 6)
+#define T_ON_DEB_20MS			(1 << 6)
+#define T_ON_DEB_100MS			(2 << 6)
+#define T_ON_DEB_750MS			(3 << 6)
+#define T_OFF_DEB_MASK			0x20
+#define T_OFF_DEB_120US			(0 << 5)
+#define T_OFF_DEB_2MS			(1 << 5)
+#define T_ON_STEP_MASK			0x18
+#define T_ON_STEP_1MS			(0 << 3)
+#define T_ON_STEP_2MS			(1 << 3)
+#define T_ON_STEP_4MS			(2 << 3)
+#define T_ON_STEP_8MS			(3 << 3)
+#define T_OFF_STEP_MASK			0x06
+#define T_OFF_STEP_2MS			(0 << 1)
+#define T_OFF_STEP_4MS			(1 << 1)
+#define T_OFF_STEP_8MS			(2 << 1)
+#define T_OFF_STEP_16MS			(3 << 1)
+#define T_RESTART_MASK			0x01
+#define T_RESTART_250MS			0
+#define T_RESTART_500MS			1
+
 /* PCA9450_REG_RESET_CTRL bits */
 #define WDOG_B_CFG_MASK			0xC0
 #define WDOG_B_CFG_NONE			0x00
 #define WDOG_B_CFG_WARM			0x40
 #define WDOG_B_CFG_COLD_LDO12		0x80
 #define WDOG_B_CFG_COLD			0xC0
+#define T_PMIC_RST_DEB_MASK		0x07
+#define T_PMIC_RST_DEB_10MS		0x00
+#define T_PMIC_RST_DEB_50MS		0x01
+#define T_PMIC_RST_DEB_100MS		0x02
+#define T_PMIC_RST_DEB_500MS		0x03
+#define T_PMIC_RST_DEB_1S		0x04
+#define T_PMIC_RST_DEB_2S		0x05
+#define T_PMIC_RST_DEB_4S		0x06
+#define T_PMIC_RST_DEB_8S		0x07
 
 /* PCA9450_REG_CONFIG2 bits */
 #define I2C_LT_MASK			0x03
-- 
2.39.2


