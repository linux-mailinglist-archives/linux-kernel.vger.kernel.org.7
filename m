Return-Path: <linux-kernel+bounces-890981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E78BEC4182D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 039464E40B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E0230217B;
	Fri,  7 Nov 2025 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="mNNlMGyR"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09A309DDB;
	Fri,  7 Nov 2025 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546028; cv=none; b=WYJ5MFMf1llOQsKkvegXm5yw1fMT4j3bF2GTLdXMHTnVKnqsjgH+YBRjAkeTKD60MJY21iPTDPpzB9hjgRYF7k3zlwLCIIqhackPSjYWDhjohOhG4J8t+FtSbg6YzITPUemRt7mfNsrvtIVyRfy9yFvKV6uhTudlbywboqsewt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546028; c=relaxed/simple;
	bh=t81QjKKQ7s4IGEzpGGmmyx85FztlfnG3X0NKrW19n9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rYdw+/PY/pi6IeJTisi971uHsKRh//evVd+f1Y9RfsoCrbNxSvZGLM590iB99U88Sv3TQlVx3B0vgNAaT+egrwBO6aoBUbijA4rYY5TieZVr09AEZGoc4RaDK+Oe6XLdA625ZlczuI2PZ79Id9eqn2gXsPW7ym4PNTQ4xYR9Smw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=mNNlMGyR; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:In-Reply-To:References:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VwgObd5S5HmYEkuJUCRFlgZQikxIUpHLfGALkiwov+A=; b=mNNlMGyR91WI8Bz5+SqGDSbNSk
	VvhRAxzmE4uaFjNunrFqVMvUHwGLcCJV1dppd3P2SR1Cluv0kQsH60NNreVk4NdAIS7xa0+q91U5c
	3seWjhUnQdgf14SRkh+5odnondNeGsxbJFAQTAt6zXSKtvdTKA8Er7BfMEDWVoUj1mo8xm0Ydac+T
	5F+ool83xp+NWVEAxRvnuAx92SyV7Rqy4KOZWnK/1DQrfAhy8TZzeD9YYg1psa4VcJMQYWFK/zKI2
	gTJYM0WGKyDjdqNXu+o5LYjGQm+IpyJlAS2d2//OVFJJBxaXlsxqILjO3kFCXaznGbOAzeplNbkPD
	8HQbuxKQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Fri, 07 Nov 2025 21:06:46 +0100
Subject: [PATCH 3/3] regulator: Add FP9931/JD9930 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-fp9931-submit-v1-3-aa7b79d9abb6@kemnade.info>
References: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
In-Reply-To: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=17079; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=t81QjKKQ7s4IGEzpGGmmyx85FztlfnG3X0NKrW19n9k=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDJl8gbHW/1a0MkZK11UmT9uyi2VSvffj5zsXbl739yO3O
 luHbV56RykLgxgXg6yYIssvawW3TyrPcoOnRtjDzGFlAhnCwMUpABMxN2NkmDzJlFv5b5eg/uED
 sqck+8/8P7BgWryQwpaTwQl71yRu3svw39dAcVHzfYHChOTkaQ/zz+j8zan6pT3jfl91sz/r7cn
 r2QE=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Add a driver for the FP9931/JD9930 regulator. Implement handling of the PG
(power good), TS_EN (temperature sensor enable), and EN (enable regulators)
pins. Implement the pair of symmetric LDOs as a single regulator because
they share a single voltage set register. For simplicity, just add the
temperature sensor (depending on external NTC) directly.

Limitations:
- As these regulators are controlled together with the VCOM regulator via
  the EN pin, some kind of management must be in place. As the enable op
  is not called when the regulator is already enabled, simple refcounting
  seems not to work to avoid clearing EN when one regulator is still
  enabled. As these regulators are typically used together, this
  limitation should not hurt hard, just provide the is_enabled op.
- As the VCOM step is quite odd (5V/255 steps), rounding is needed.
  Due to some limitations in the regulator core, the max/min voltages in
  the devicetree must match the idea of the driver how to round things
  exactly.
- Night mode is not implemented, so only the FP9931 compatible is needed in
  the driver, there is no REGULATOR_MODE_NIGHT and no clear definition in
  the datasheet what it does, also the XON pin which seems to be an input
  related to that night mode is not used.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/regulator/Kconfig  |  10 +
 drivers/regulator/Makefile |   1 +
 drivers/regulator/fp9931.c | 567 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 578 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index d84f3d054c59..c817a4cc00c8 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -500,6 +500,16 @@ config REGULATOR_ISL6271A
 	help
 	  This driver supports ISL6271A voltage regulator chip.
 
+config REGULATOR_FP9931
+	tristate "FitiPower FP9931/JD9930 EPD regulator"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver supports the FP9931/JD9930 voltage regulator chip
+	  which is used to provide power to Electronic Paper Displays
+	  so it is found in E-Book readers.
+	  If HWWON is enabled, it also provides temperature measurement.
+
 config REGULATOR_LM363X
 	tristate "TI LM363X voltage regulators"
 	depends on MFD_TI_LMU
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b3101376029d..98a02c854044 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_REGULATOR_HI6421V600) += hi6421v600-regulator.o
 obj-$(CONFIG_REGULATOR_HI655X) += hi655x-regulator.o
 obj-$(CONFIG_REGULATOR_ISL6271A) += isl6271a-regulator.o
 obj-$(CONFIG_REGULATOR_ISL9305) += isl9305.o
+obj-$(CONFIG_REGULATOR_FP9931) += fp9931.o
 obj-$(CONFIG_REGULATOR_LM363X) += lm363x-regulator.o
 obj-$(CONFIG_REGULATOR_LOCHNAGAR) += lochnagar-regulator.o
 obj-$(CONFIG_REGULATOR_LP3971) += lp3971.o
diff --git a/drivers/regulator/fp9931.c b/drivers/regulator/fp9931.c
new file mode 100644
index 000000000000..3b6341d4944a
--- /dev/null
+++ b/drivers/regulator/fp9931.c
@@ -0,0 +1,567 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2025 Andreas Kemnade
+
+/* Datasheet: https://www.fitipower.com/dl/file/flXa6hIchVeu0W3K */
+
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/hwmon.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regmap.h>
+
+#define FP9931_REG_TMST_VALUE 0
+#define FP9931_REG_VCOM_SETTING 1
+#define FP9931_REG_VPOSNEG_SETTING 2
+#define FP9931_REG_PWRON_DELAY 3
+#define FP9931_REG_CONTROL_REG1 11
+
+#define PGOOD_TIMEOUT_MSECS 200
+
+struct fp9931_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regulator *vin_reg;
+	struct gpio_desc *pgood_gpio;
+	struct gpio_desc *en_gpio;
+	struct gpio_desc *ts_en_gpio;
+	struct completion pgood_completion;
+	int pgood_irq;
+};
+
+static const unsigned int VPOSNEG_table[] = {
+	7040000,
+	7040000,
+	7040000,
+	7040000,
+	7040000,
+	7040000,
+	7260000,
+	7490000,
+	7710000,
+	7930000,
+	8150000,
+	8380000,
+	8600000,
+	8820000,
+	9040000,
+	9270000,
+	9490000,
+	9710000,
+	9940000,
+	10160000,
+	10380000,
+	10600000,
+	10830000,
+	11050000,
+	11270000,
+	11490000,
+	11720000,
+	11940000,
+	12160000,
+	12380000,
+	12610000,
+	12830000,
+	13050000,
+	13280000,
+	13500000,
+	13720000,
+	13940000,
+	14170000,
+	14390000,
+	14610000,
+	14830000,
+	15060000,
+};
+
+static const struct hwmon_channel_info *fp9931_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static int setup_timings(struct fp9931_data *data)
+{
+	u32 tdly[4];
+	u8 tdlys = 0;
+	int i;
+	int ret;
+
+	ret = device_property_count_u32(data->dev, "fiti,tdly");
+	if (ret == -EINVAL) /* property is optional */
+		return 0;
+
+	if (ret < 0)
+		return ret;
+
+	if (ret != ARRAY_SIZE(tdly)) {
+		dev_err(data->dev, "invalid delay specification");
+		return -EINVAL;
+	}
+
+	ret = device_property_read_u32_array(data->dev, "fiti,tdly", tdly, ARRAY_SIZE(tdly));
+	if (ret)
+		return ret;
+
+	for (i = ARRAY_SIZE(tdly) - 1; i >= 0; i--) {
+		if (tdly[i] > 3)
+			return -EINVAL;
+
+		tdlys <<= 2;
+		tdlys |= tdly[i];
+	}
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(data->regmap, FP9931_REG_PWRON_DELAY, tdlys);
+	pm_runtime_put_autosuspend(data->dev);
+
+	return ret;
+}
+
+static int fp9931_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			     u32 attr, int channel, long *temp)
+{
+	struct fp9931_data *data = dev_get_drvdata(dev);
+	unsigned int val;
+	s8 signed_val;
+	int ret;
+
+	if (attr != hwmon_temp_input)
+		return -EOPNOTSUPP;
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(data->regmap, FP9931_REG_TMST_VALUE, &val);
+	if (ret)
+		return ret;
+
+	pm_runtime_put_autosuspend(data->dev);
+	signed_val = (s8)val;
+
+	*temp = signed_val;
+	*temp = *temp * 1000;
+
+	return 0;
+}
+
+static umode_t fp9931_hwmon_is_visible(const void *data,
+				       enum hwmon_sensor_types type,
+				       u32 attr, int channel)
+{
+	if (type != hwmon_temp)
+		return 0;
+
+	if (attr != hwmon_temp_input)
+		return 0;
+
+	return 0444;
+}
+
+static const struct hwmon_ops fp9931_hwmon_ops = {
+	.is_visible = fp9931_hwmon_is_visible,
+	.read = fp9931_hwmon_read,
+};
+
+static const struct hwmon_chip_info fp9931_chip_info = {
+	.ops = &fp9931_hwmon_ops,
+	.info = fp9931_info,
+};
+
+static int fp9931_runtime_suspend(struct device *dev)
+{
+	int ret = 0;
+	struct fp9931_data *data = dev_get_drvdata(dev);
+
+	if (data->ts_en_gpio)
+		gpiod_set_value_cansleep(data->ts_en_gpio, 0);
+
+	if (data->vin_reg) {
+		ret = regulator_disable(data->vin_reg);
+		regcache_mark_dirty(data->regmap);
+	}
+
+	return ret;
+}
+
+static int fp9931_runtime_resume(struct device *dev)
+{
+	int ret = 0;
+	struct fp9931_data *data = dev_get_drvdata(dev);
+
+	if (data->vin_reg)
+		ret = regulator_enable(data->vin_reg);
+
+	if (ret)
+		return ret;
+
+	if (data->ts_en_gpio) {
+		gpiod_set_value_cansleep(data->ts_en_gpio, 1);
+		/* wait for one ADC conversion to have sane temperature */
+		usleep_range(10000, 15000);
+	}
+
+	ret = regcache_sync(data->regmap);
+
+	return ret;
+}
+
+static bool fp9931_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return reg == FP9931_REG_TMST_VALUE;
+}
+
+static const struct reg_default fp9931_reg_default = {
+	.reg = FP9931_REG_VCOM_SETTING,
+	.def = 0x80,
+};
+
+static const struct regmap_config regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 12,
+	.cache_type = REGCACHE_FLAT,
+	.volatile_reg = fp9931_volatile_reg,
+	.reg_defaults = &fp9931_reg_default,
+	.num_reg_defaults = 1,
+};
+
+static void disable_nopm(void *d)
+{
+	struct fp9931_data *data = d;
+
+	fp9931_runtime_suspend(data->dev);
+}
+
+static int fp9931_v3p3_enable(struct regulator_dev *rdev)
+{
+	struct fp9931_data *data = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = regulator_enable_regmap(rdev);
+	if (ret < 0)
+		pm_runtime_put_autosuspend(data->dev);
+
+	return ret;
+}
+
+static int fp9931_v3p3_disable(struct regulator_dev *rdev)
+{
+	struct fp9931_data *data = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = regulator_disable_regmap(rdev);
+	pm_runtime_put_autosuspend(data->dev);
+
+	return ret;
+}
+
+static int fp9931_v3p3_is_enabled(struct regulator_dev *rdev)
+{
+	struct fp9931_data *data = rdev_get_drvdata(rdev);
+	int ret;
+
+	if (pm_runtime_status_suspended(data->dev))
+		return 0;
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return 0;
+
+	ret = regulator_is_enabled_regmap(rdev);
+
+	pm_runtime_put_autosuspend(data->dev);
+	return ret;
+}
+
+static const struct regulator_ops fp9931_v3p3ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = fp9931_v3p3_enable,
+	.disable = fp9931_v3p3_disable,
+	.is_enabled = fp9931_v3p3_is_enabled,
+};
+
+static int fp9931_check_powergood(struct regulator_dev *rdev)
+{
+	struct fp9931_data *data = rdev_get_drvdata(rdev);
+
+	if (pm_runtime_status_suspended(data->dev))
+		return 0;
+
+	return gpiod_get_value_cansleep(data->pgood_gpio);
+}
+
+static int fp9931_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct fp9931_data *data = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = regulator_get_voltage_sel_regmap(rdev);
+	pm_runtime_put_autosuspend(data->dev);
+
+	return ret;
+}
+
+static int fp9931_set_voltage_sel(struct regulator_dev *rdev, unsigned int selector)
+{
+	struct fp9931_data *data = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = regulator_set_voltage_sel_regmap(rdev, selector);
+	pm_runtime_put_autosuspend(data->dev);
+
+	return ret;
+}
+
+static irqreturn_t pgood_handler(int irq, void *dev_id)
+{
+	struct fp9931_data *data = dev_id;
+
+	complete(&data->pgood_completion);
+
+	return IRQ_HANDLED;
+}
+
+static int fp9931_set_enable(struct regulator_dev *rdev)
+{
+	struct fp9931_data *data = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
+	reinit_completion(&data->pgood_completion);
+	gpiod_set_value_cansleep(data->en_gpio, 1);
+	dev_dbg(data->dev, "turning on...");
+	wait_for_completion_timeout(&data->pgood_completion,
+				    msecs_to_jiffies(PGOOD_TIMEOUT_MSECS));
+	dev_dbg(data->dev, "turned on");
+	if (gpiod_get_value_cansleep(data->pgood_gpio) != 1) {
+		pm_runtime_put_autosuspend(data->dev);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int fp9931_clear_enable(struct regulator_dev *rdev)
+{
+	struct fp9931_data *data = rdev_get_drvdata(rdev);
+
+	gpiod_set_value_cansleep(data->en_gpio, 0);
+	pm_runtime_put_autosuspend(data->dev);
+	return 0;
+}
+
+static const struct regulator_ops fp9931_vcom_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.enable = fp9931_set_enable,
+	.disable = fp9931_clear_enable,
+	.is_enabled = fp9931_check_powergood,
+	.set_voltage_sel = fp9931_set_voltage_sel,
+	.get_voltage_sel = fp9931_get_voltage_sel,
+};
+
+static const struct regulator_ops fp9931_vposneg_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_ascend,
+	/* gets enabled by enabling vcom, too */
+	.is_enabled = fp9931_check_powergood,
+	.set_voltage_sel = fp9931_set_voltage_sel,
+	.get_voltage_sel = fp9931_get_voltage_sel,
+};
+
+static const struct regulator_desc regulators[] = {
+	{
+		.name = "V3P3",
+		.of_match = of_match_ptr("V3P3"),
+		.id = 0,
+		.ops = &fp9931_v3p3ops,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.enable_reg = FP9931_REG_CONTROL_REG1,
+		.enable_mask = BIT(1),
+		.of_match = of_match_ptr("v3p3"),
+		.n_voltages = 1,
+		.min_uV = 3300000
+	},
+	{
+		.name = "VPOSNEG",
+		.of_match = of_match_ptr("VPOSNEG"),
+		.id = 1,
+		.ops = &fp9931_vposneg_ops,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.n_voltages = ARRAY_SIZE(VPOSNEG_table),
+		.vsel_reg = FP9931_REG_VPOSNEG_SETTING,
+		.vsel_mask = 0x3F,
+		.volt_table = VPOSNEG_table,
+	},
+	{
+		.name = "VCOM",
+		.of_match = of_match_ptr("VCOM"),
+		.id = 2,
+		.ops = &fp9931_vcom_ops,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.n_voltages = 255,
+		.min_uV = 0,
+		.uV_step = 5000000 / 255,
+		.vsel_reg = FP9931_REG_VCOM_SETTING,
+		.vsel_mask = 0xFF
+	},
+};
+
+static int fp9931_probe(struct i2c_client *client)
+{
+	struct fp9931_data *data;
+	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	int ret = 0;
+	int i;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct fp9931_data), GFP_KERNEL);
+	data->regmap = devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
+				     "failed to allocate regmap!\n");
+
+	data->vin_reg = devm_regulator_get_optional(&client->dev, "vin");
+	if (IS_ERR(data->vin_reg))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vin_reg),
+				     "failid to get vin regulator\n");
+
+	data->pgood_gpio = devm_gpiod_get(&client->dev, "pg",
+					  GPIOD_IN);
+	if (IS_ERR(data->pgood_gpio))
+		return dev_err_probe(&client->dev,
+				     PTR_ERR(data->pgood_gpio),
+				     "failed to get power good gpio\n");
+
+	data->pgood_irq = gpiod_to_irq(data->pgood_gpio);
+	if (data->pgood_irq < 0)
+		return data->pgood_irq;
+
+	data->en_gpio = devm_gpiod_get(&client->dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(data->en_gpio))
+		return dev_err_probe(&client->dev,
+				     PTR_ERR(data->en_gpio),
+				     "failed to get en gpio\n");
+
+	data->ts_en_gpio = devm_gpiod_get_optional(&client->dev, "ts-en", GPIOD_OUT_LOW);
+	if (IS_ERR(data->ts_en_gpio))
+		return dev_err_probe(&client->dev,
+				     PTR_ERR(data->ts_en_gpio),
+				     "failed to get en gpio\n");
+
+	data->dev = &client->dev;
+	i2c_set_clientdata(client, data);
+
+	init_completion(&data->pgood_completion);
+
+	ret = devm_request_threaded_irq(&client->dev, data->pgood_irq, NULL,
+					pgood_handler,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					"PGOOD", data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to request irq\n");
+
+	if (IS_ENABLED(CONFIG_PM)) {
+		devm_pm_runtime_enable(&client->dev);
+		pm_runtime_set_autosuspend_delay(&client->dev, 4000);
+		pm_runtime_use_autosuspend(&client->dev);
+	} else {
+		ret = fp9931_runtime_resume(&client->dev);
+		if (ret < 0)
+			return ret;
+
+		devm_add_action_or_reset(&client->dev, disable_nopm, data);
+	}
+
+	ret = setup_timings(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "failed to setup timings\n");
+
+	config.driver_data = data;
+	config.dev = &client->dev;
+	config.regmap = data->regmap;
+
+	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
+		rdev = devm_regulator_register(&client->dev,
+					       &regulators[i],
+					       &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(&client->dev, PTR_ERR(rdev),
+					     "failed to register %s regulator\n",
+					     regulators[i].name);
+	}
+
+	if (IS_REACHABLE(CONFIG_HWMON)) {
+		struct device *hwmon_dev;
+
+		hwmon_dev = devm_hwmon_device_register_with_info(&client->dev, "fp9931", data,
+								 &fp9931_chip_info, NULL);
+		if (IS_ERR(hwmon_dev))
+			dev_err(&client->dev, "failed to register hwmon\n");
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops fp9931_pm_ops = {
+	SET_RUNTIME_PM_OPS(fp9931_runtime_suspend, fp9931_runtime_resume, NULL)
+};
+
+static const struct of_device_id fp9931_dt_ids[] = {
+	{
+		.compatible = "fiti,fp9931",
+	}, {
+		.compatible = "fiti,fp9931", /* no night mode */
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, fp9931_dt_ids);
+
+static struct i2c_driver fp9931_i2c_driver = {
+	.driver = {
+		   .name = "fp9931",
+		   .owner = THIS_MODULE,
+		   .of_match_table = fp9931_dt_ids,
+		   .pm = (&fp9931_pm_ops),
+	},
+	.probe = fp9931_probe,
+};
+
+module_i2c_driver(fp9931_i2c_driver);
+
+/* Module information */
+MODULE_DESCRIPTION("FP9931 regulator driver");
+MODULE_LICENSE("GPL");
+

-- 
2.47.3


