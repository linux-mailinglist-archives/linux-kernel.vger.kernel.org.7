Return-Path: <linux-kernel+bounces-801616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C2EB4479F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5684A586BE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F17B285CB4;
	Thu,  4 Sep 2025 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNL6U9lg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7A228468D;
	Thu,  4 Sep 2025 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018682; cv=none; b=Vw1sGYas42TCDQhbn4Ot0s+UCkuXhNZ3Ih6Ehbx0fAlbWlCisCb9caoSVbLcF4XADhaTbtafLHL0g/cR97Yu2/DZ+VqJjyikZhKbl5TTEn4cDto5PNvWUNYlSwzwSmbH1nTSVSmyE4i55PdFxT7lVKNfjTQAb7Y7RG9inJQcmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018682; c=relaxed/simple;
	bh=yRhBN8Cg8Mh2IvqxC8lT4PdkpIOwKSFChvp58UPwuT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dR1lX59pTu+TsepLdJJE8Fv1YOBcGH/pE9Qbivk/Nl79rzLfiKRZpRORewpvwy6G0Rgzf2fRuEpiz5lFSACdcdA57zIrw3PIGcjiHVnCKt8few8rK0Fw6BAzSZzAKZfNVYqwLdZE5VvyZpyAZOFqrhpvB+asIlFKysJAqHAP8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNL6U9lg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D5B9C4CEF5;
	Thu,  4 Sep 2025 20:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757018681;
	bh=yRhBN8Cg8Mh2IvqxC8lT4PdkpIOwKSFChvp58UPwuT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dNL6U9lg7bepoRy8FshYBD7oANBt8vLnVRvLkqVieZ8+PBMbs4mVDmLmhSkCJ55I7
	 BhzpyBB+XbF48jSNcTYSISxcnqrBK7sfbLN2GGDLmtObJJasnTTfTqlfU8wXMPL/LW
	 U2ISk6Uo9JDV9ck8HVWWszXr1D3xjlZFGvexzz6W5cdUAjCqU/ngi7do/GfML7JCHv
	 BPc5EbMpzIRmkMRSY9oswWlzHU+MBH+qzNE2k5ODcyjJ13I1TTP//laoIcHsqYfUHn
	 kyJzXLYq7OdQIomARGY80zWaBVmZ5WfGC99hyOPQcf2ZDsMJ47N5bx8Os6iDurjub0
	 qYrn+eWc70TpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866D7CA1015;
	Thu,  4 Sep 2025 20:44:41 +0000 (UTC)
From: Woodrow Douglass via B4 Relay <devnull+wdouglass.carnegierobotics.com@kernel.org>
Date: Thu, 04 Sep 2025 16:44:36 -0400
Subject: [PATCH v6 2/2] regulator: pf530x: Add a driver for the NXP PF5300
 Regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-pf530x-v6-2-ae5efea2198d@carnegierobotics.com>
References: <20250902-pf530x-v6-0-ae5efea2198d@carnegierobotics.com>
In-Reply-To: <20250902-pf530x-v6-0-ae5efea2198d@carnegierobotics.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Woodrow Douglass <wdouglass@carnegierobotics.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12876;
 i=wdouglass@carnegierobotics.com; h=from:subject:message-id;
 bh=4xomC22sZeoE0/GjeYr2EJnfhRct4GMD+4LxZDoHdEI=;
 b=owEBbQGS/pANAwAKAewLuLlPNh4UAcsmYgBoufo4fynAjrWSJTy/4kXH0bwqT8Tm/bL79Yn6y
 jvRTa236FaJATMEAAEKAB0WIQSIUqjrbDLQw0mgxHLsC7i5TzYeFAUCaLn6OAAKCRDsC7i5TzYe
 FBI8B/0QwBgKL4IeQ6gh2CC0jSCAYdPFsxWIzfKw4JEHG7CGzOkIQuoE5TvXH5mTkyKszGbe26x
 I0xuiCRYQNllL1aTxGFcH6Ndu7StzknUoNqwd0UrxPEZHpraMmbOIuqtn/qhd6Fp3l39v35O6lF
 zwsAtovnm8kJGTIPHLPZ1earmHxWkWEmgnZreC1QSxiMi7+hmZbRMmWvu5KvOLpwOnKLItipYFx
 xtPN4AKRwHafDoD72hkTETiUxQHHgxpcz8lXqo9i3B3xf9av1zJzlmVEQY9m3q62vLuUG2g/GOK
 RPDgfSWiMylw7ZunS3kVb5WV7J0/a7j4Av7GrB+86nWM8r9C
X-Developer-Key: i=wdouglass@carnegierobotics.com; a=openpgp;
 fpr=8852A8EB6C32D0C349A0C472EC0BB8B94F361E14
X-Endpoint-Received: by B4 Relay for wdouglass@carnegierobotics.com/default
 with auth_id=514
X-Original-From: Woodrow Douglass <wdouglass@carnegierobotics.com>
Reply-To: wdouglass@carnegierobotics.com

From: Woodrow Douglass <wdouglass@carnegierobotics.com>

This driver allows reading some regulator settings and adjusting
output voltage. It is based on information from the datasheet
at https://www.nxp.com/docs/en/data-sheet/PF5300.pdf

Signed-off-by: Woodrow Douglass <wdouglass@carnegierobotics.com>
---
 MAINTAINERS                          |   6 +
 drivers/regulator/Kconfig            |  12 ++
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/pf530x-regulator.c | 378 +++++++++++++++++++++++++++++++++++
 4 files changed, 397 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcfbd11efef..7374cb0ae5d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18291,6 +18291,12 @@ F:	Documentation/devicetree/bindings/clock/*imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/*imx*
 
+NXP PF5300/PF5301/PF5302 PMIC REGULATOR DEVICE DRIVER
+M:	Woodrow Douglass <wdouglass@carnegierobotics.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
+F:	drivers/regulator/pf530x-regulator.c
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index eaa6df1c9f80..611356bea09d 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1006,6 +1006,18 @@ config REGULATOR_PCAP
 	 This driver provides support for the voltage regulators of the
 	 PCAP2 PMIC.
 
+config REGULATOR_PF530X
+	tristate "NXP PF5300/PF5301/PF5302 regulator driver"
+	depends on I2C && OF
+	select REGMAP_I2C
+	help
+	  Say y here to support the regulators found on the NXP
+	  PF5300/PF5301/PF5302 PMIC.
+
+	  Say M here if you want to support for the regulators found
+	  on the NXP PF5300/PF5301/PF5302 PMIC. The module will be named
+	  "pf530x-regulator".
+
 config REGULATOR_PF8X00
 	tristate "NXP PF8100/PF8121A/PF8200 regulator driver"
 	depends on I2C && OF
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index be98b29d6675..60ca55d04aef 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -125,6 +125,7 @@ obj-$(CONFIG_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
 obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
+obj-$(CONFIG_REGULATOR_PF530X) += pf530x-regulator.o
 obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
 obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
diff --git a/drivers/regulator/pf530x-regulator.c b/drivers/regulator/pf530x-regulator.c
new file mode 100644
index 000000000000..509e08953685
--- /dev/null
+++ b/drivers/regulator/pf530x-regulator.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+// documentation of this device is available at
+// https://www.nxp.com/docs/en/data-sheet/PF5300.pdf
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+/* registers */
+#define PF530X_DEVICEID			0x00
+#define PF530X_REV				0x01
+#define PF530X_EMREV			0x02
+#define PF530X_PROGID			0x03
+#define PF530X_CONFIG1			0x04
+#define PF530X_INT_STATUS1		0x05
+#define PF530X_INT_SENSE1		0x06
+#define PF530X_INT_STATUS2		0x07
+#define PF530X_INT_SENSE2		0x08
+#define PF530X_BIST_STAT1		0x09
+#define PF530X_BIST_CTRL		0x0a
+#define PF530X_STATE			0x0b
+#define PF530X_STATE_CTRL		0x0c
+#define PF530X_SW1_VOLT			0x0d
+#define PF530X_SW1_STBY_VOLT	0x0e
+#define PF530X_SW1_CTRL1		0x0f
+#define PF530X_SW1_CTRL2		0x10
+#define PF530X_CLK_CTRL			0x11
+#define PF530X_SEQ_CTRL1		0x12
+#define PF530X_SEQ_CTRL2		0x13
+#define PF530X_RANDOM_CHK		0x14
+#define PF530X_RANDOM_GEN		0x15
+#define PF530X_WD_CTRL1			0x16
+#define PF530X_WD_SEED			0x17
+#define PF530X_WD_ANSWER		0x18
+#define PF530X_FLT_CNT1			0x19
+#define PF530X_FLT_CNT2			0x1a
+#define PF530X_OTP_MODE			0x2f
+
+enum pf530x_states {
+	PF530X_STATE_POF,
+	PF530X_STATE_FUSE_LOAD,
+	PF530X_STATE_LP_OFF,
+	PF530X_STATE_SELF_TEST,
+	PF530X_STATE_POWER_UP,
+	PF530X_STATE_INIT,
+	PF530X_STATE_IO_RELEASE,
+	PF530X_STATE_RUN,
+	PF530X_STATE_STANDBY,
+	PF530X_STATE_FAULT,
+	PF530X_STATE_FAILSAFE,
+	PF530X_STATE_POWER_DOWN,
+	PF530X_STATE_2MS_SELFTEST_RETRY,
+	PF530X_STATE_OFF_DLY,
+};
+
+#define PF530_FAM			0x50
+enum pf530x_devid {
+	PF5300			= 0x3,
+	PF5301			= 0x4,
+	PF5302			= 0x5,
+};
+
+#define PF530x_FAM			0x50
+#define PF530x_DEVICE_FAM_MASK		GENMASK(7, 4)
+#define PF530x_DEVICE_ID_MASK		GENMASK(3, 0)
+
+#define PF530x_STATE_MASK		GENMASK(3, 0)
+#define PF530x_STATE_RUN		0x07
+#define PF530x_STATE_STANDBY	0x08
+#define PF530x_STATE_LP_OFF		0x02
+
+#define PF530X_OTP_STBY_MODE	GENMASK(3, 2)
+#define PF530X_OTP_RUN_MODE		GENMASK(1, 0)
+
+#define PF530X_INT_STATUS_OV	BIT(1)
+#define PF530X_INT_STATUS_UV	BIT(2)
+#define PF530X_INT_STATUS_ILIM	BIT(3)
+
+#define SW1_ILIM_S	BIT(0)
+#define VMON_UV_S	BIT(1)
+#define VMON_OV_S	BIT(2)
+#define VIN_OVLO_S	BIT(3)
+#define BG_ERR_S	BIT(6)
+
+#define THERM_155_S	BIT(3)
+#define THERM_140_S	BIT(2)
+#define THERM_125_S	BIT(1)
+#define THERM_110_S	BIT(0)
+
+struct pf530x_chip {
+	struct regmap *regmap;
+	struct device *dev;
+};
+
+static const struct regmap_config pf530x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = PF530X_OTP_MODE,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static int pf530x_get_status(struct regulator_dev *rdev)
+{
+	unsigned int state;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, PF530X_INT_SENSE1, &state);
+	if (ret != 0)
+		return ret;
+
+	if ((state & (BG_ERR_S | SW1_ILIM_S | VMON_UV_S | VMON_OV_S | VIN_OVLO_S))
+			!= 0)
+		return REGULATOR_STATUS_ERROR;
+
+	// no errors, check if what non-error state we're in
+	ret = regmap_read(rdev->regmap, PF530X_STATE, &state);
+	if (ret != 0)
+		return ret;
+
+	state &= PF530x_STATE_MASK;
+
+	switch (state) {
+	case PF530x_STATE_RUN:
+		ret = REGULATOR_STATUS_NORMAL;
+		break;
+	case PF530x_STATE_STANDBY:
+		ret = REGULATOR_STATUS_STANDBY;
+		break;
+	case PF530x_STATE_LP_OFF:
+		ret = REGULATOR_STATUS_OFF;
+		break;
+	default:
+		ret = REGULATOR_STATUS_ERROR;
+		break;
+	}
+	return ret;
+}
+
+static int pf530x_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+{
+	unsigned int status;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, PF530X_INT_STATUS1, &status);
+
+	if (ret != 0)
+		return ret;
+
+	*flags = 0;
+
+	if (status & PF530X_INT_STATUS_OV)
+		*flags |= REGULATOR_ERROR_OVER_VOLTAGE_WARN;
+
+	if (status & PF530X_INT_STATUS_UV)
+		*flags |= REGULATOR_ERROR_UNDER_VOLTAGE;
+
+	if (status & PF530X_INT_STATUS_ILIM)
+		*flags |= REGULATOR_ERROR_OVER_CURRENT;
+
+	ret = regmap_read(rdev->regmap, PF530X_INT_SENSE2, &status);
+
+	if (ret != 0)
+		return ret;
+
+	if ((status & (THERM_155_S |
+		       THERM_140_S |
+		       THERM_125_S |
+		       THERM_110_S)) != 0)
+		*flags |= REGULATOR_ERROR_OVER_TEMP_WARN;
+
+	return 0;
+}
+
+static const struct regulator_ops pf530x_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.get_status = pf530x_get_status,
+	.get_error_flags = pf530x_get_error_flags,
+	.set_bypass = regulator_set_bypass_regmap,
+	.get_bypass = regulator_get_bypass_regmap,
+};
+
+static struct linear_range vrange = REGULATOR_LINEAR_RANGE(500000, 0, 140, 5000);
+
+static struct regulator_desc pf530x_reg_desc = {
+	.name = "SW1",
+	.ops = &pf530x_regulator_ops,
+	.linear_ranges = &vrange,
+	.n_linear_ranges = 1,
+	.type = REGULATOR_VOLTAGE,
+	.id = 0,
+	.owner = THIS_MODULE,
+	.vsel_reg = PF530X_SW1_VOLT,
+	.vsel_mask = 0xFF,
+	.bypass_reg = PF530X_SW1_CTRL2,
+	.bypass_mask = 0x07,
+	.bypass_val_on = 0x07,
+	.bypass_val_off = 0x00,
+	.enable_reg = PF530X_SW1_CTRL1,
+	.enable_mask = GENMASK(5, 2),
+	.enable_val = GENMASK(5, 2),
+	.disable_val = 0,
+};
+
+static int pf530x_identify(struct pf530x_chip *chip)
+{
+	unsigned int value;
+	u8 dev_fam, dev_id, full_layer_rev, metal_layer_rev, prog_idh, prog_idl, emrev;
+	const char *name = NULL;
+	int ret;
+
+	ret = regmap_read(chip->regmap, PF530X_DEVICEID, &value);
+	if (ret) {
+		dev_err(chip->dev, "failed to read chip family\n");
+		return ret;
+	}
+
+	dev_fam = value & PF530x_DEVICE_FAM_MASK;
+	switch (dev_fam) {
+	case PF530x_FAM:
+		break;
+	default:
+		dev_err(chip->dev,
+			"Chip 0x%x is not from PF530X family\n", dev_fam);
+		return ret;
+	}
+
+	dev_id = value & PF530x_DEVICE_ID_MASK;
+	switch (dev_id) {
+	case PF5300:
+		name = "PF5300";
+		break;
+	case PF5301:
+		name = "PF5301";
+		break;
+	case PF5302:
+		name = "PF5302";
+		break;
+	default:
+		dev_err(chip->dev, "Unknown pf530x device id 0x%x\n", dev_id);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(chip->regmap, PF530X_REV, &value);
+	if (ret) {
+		dev_err(chip->dev, "failed to read chip rev\n");
+		return ret;
+	}
+
+	full_layer_rev = ((value & 0xF0) == 0) ? '0' : ((((value & 0xF0) >> 4) - 1) + 'A');
+	metal_layer_rev = value & 0xF;
+
+	ret = regmap_read(chip->regmap, PF530X_EMREV, &value);
+	if (ret) {
+		dev_err(chip->dev, "failed to read chip emrev register\n");
+		return ret;
+	}
+
+	prog_idh = (value >> 4) + 'A';
+	// prog_idh skips 'O', per page 96 of the datasheet
+	if (prog_idh >= 'O')
+		prog_idh += 1;
+
+	emrev = value & 0x7;
+
+	ret = regmap_read(chip->regmap, PF530X_PROGID, &value);
+	if (ret) {
+		dev_err(chip->dev, "failed to read chip progid register\n");
+		return ret;
+	}
+
+	if (value >= 0x22) {
+		dev_err(chip->dev, "invalid value for progid register\n");
+		return -ENODEV;
+	} else if (value < 10) {
+		prog_idl = value + '0';
+	} else {
+		prog_idl = (value - 10) + 'A';
+		// prog_idh skips 'O', per page 97 of the datasheet
+		if (prog_idl >= 'O')
+			prog_idl += 1;
+	}
+
+	dev_info(chip->dev, "%s Regulator found (Rev %c%d ProgID %c%c EMREV %x).\n",
+		 name, full_layer_rev, metal_layer_rev, prog_idh, prog_idl, emrev);
+
+	return 0;
+}
+
+static int pf530x_i2c_probe(struct i2c_client *client)
+{
+	struct regulator_config config = { NULL, };
+	struct pf530x_chip *chip;
+	int ret;
+	struct regulator_dev *rdev;
+	struct regulator_init_data *init_data;
+
+	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, chip);
+	chip->dev = &client->dev;
+
+	chip->regmap = devm_regmap_init_i2c(client, &pf530x_regmap_config);
+	if (IS_ERR(chip->regmap)) {
+		ret = PTR_ERR(chip->regmap);
+		dev_err(&client->dev,
+			"regmap allocation failed with err %d\n", ret);
+		return ret;
+	}
+
+	ret = pf530x_identify(chip);
+	if (ret)
+		return ret;
+
+	init_data = of_get_regulator_init_data(chip->dev, chip->dev->of_node, &pf530x_reg_desc);
+	if (!init_data)
+		return -ENODATA;
+
+	config.dev = chip->dev;
+	config.driver_data = &pf530x_reg_desc;
+	config.of_node = chip->dev->of_node;
+	config.regmap = chip->regmap;
+	config.init_data = init_data;
+
+	// the config parameter gets copied, it's ok to pass a pointer on the stack here
+	rdev = devm_regulator_register(&client->dev, &pf530x_reg_desc, &config);
+	if (IS_ERR(rdev)) {
+		dev_err(&client->dev, "failed to register %s regulator\n", pf530x_reg_desc.name);
+		return PTR_ERR(rdev);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id pf530x_dt_ids[] = {
+	{ .compatible = "nxp,pf5300",},
+	{ .compatible = "nxp,pf5301",},
+	{ .compatible = "nxp,pf5302",},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pf530x_dt_ids);
+
+static const struct i2c_device_id pf530x_i2c_id[] = {
+	{ "pf5300", 0 },
+	{ "pf5301", 0 },
+	{ "pf5302", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, pf530x_i2c_id);
+
+static struct i2c_driver pf530x_regulator_driver = {
+	.id_table = pf530x_i2c_id,
+	.driver = {
+		.name = "pf530x",
+		.of_match_table = pf530x_dt_ids,
+	},
+	.probe = pf530x_i2c_probe,
+};
+module_i2c_driver(pf530x_regulator_driver);
+
+MODULE_AUTHOR("Woodrow Douglass <wdouglass@carnegierobotics.com>");
+MODULE_DESCRIPTION("Regulator Driver for NXP's PF5300/PF5301/PF5302 PMIC");
+MODULE_LICENSE("GPL");

-- 
2.39.5



