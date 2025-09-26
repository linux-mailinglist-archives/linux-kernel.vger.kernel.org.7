Return-Path: <linux-kernel+bounces-833940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D62BA35FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D4D1668A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952C22D5410;
	Fri, 26 Sep 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b="bEbqj8+O"
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9781A58D;
	Fri, 26 Sep 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882995; cv=none; b=QwlmtexqmcXdgi29mgqGOIdO9ld+HxKlh2XWZKCNH2PuMRXq3V4HNL0jmHnRwsa5xCtxE+sU2I7Ko5bGPrAeWCtQnU9JXZg6+yzrVx1zUdAXkfYMQiWJFss8HDxydckIXKWFJrviH8cj/RFrRZfsqOYQuiAQk4gU6WyMq/7nwng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882995; c=relaxed/simple;
	bh=KWH0BqsCaHGYrNL8ZEOgTY93SQThzGUSbtzaQPdu4Nw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPxLeIB5/yWLAg+dPuIV8kvFk1kXR8R3c5mVJUdmsEtOxrpeZqjGs1HxBwLKaiGMD2twbTs156yCQtNTEfOnXR6mhU1tvGH3OqDk0T+Ew1EqY79Dt+LZPXy0UyJm2nj4dTUXC3y4ujvSEAveKMI2cNIqie0tlaTBD2v9r4Fa53g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b=bEbqj8+O; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=awinic.com; s=default;
	t=1758882984; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eOocW7XO87KQGoWcWy6jZGqpK2EvZcfN7Tih9Jvg6zE=;
	b=bEbqj8+OEWNHkwWMqYGR+GQVkb8biy4BT3E6kdBsGfuaJhz+bHhiQRYHcgC8geZ1pm87//prridwaBzXLfolfsajHDu2skT2OS+buAYjzMBI5GZEkHDkIVX618/Z1H/R9nSLoj07HxQp4H0qAB3m3MPoPdQBbLLaM0uqXvlJOfiBG0ZDgwNssktnjIcxX+0kndPo90C/EJO1Ap4FsSm7DMbPdM0K7tRS3jW0O1TQ+Z85acm35IcOodBk86kjut0GwEabgLADckO3n+/S2sQq2Zekz7JUvgAdTYIqNAvRgEBVsMrT/1ySyu1sthZ53duezJ++ULtzXJqPpUp6vdxFjQ==
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.ensjOxn_1758882044 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 26 Sep 2025 18:20:45 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	cy_huang@richtek.com,
	ivprusov@salutedevices.com,
	zhoubinbin@loongson.cn,
	zhangyi@everest-semi.com,
	jack.yu@realtek.com,
	shenghao-ding@ti.com,
	rf@opensource.cirrus.com,
	git@apitzsch.eu,
	nuno.sa@analog.com,
	colin.i.king@gmail.com,
	thorsten.blum@linux.dev,
	yesanishhere@gmail.com,
	ebiggers@google.com,
	ardb@kernel.org,
	zhujun2@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH V1 2/7] ASoC: codecs: Rework the aw88395 driver
Date: Fri, 26 Sep 2025 18:20:32 +0800
Message-ID: <20250926102037.27697-3-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250926102037.27697-1-wangweidong.a@awinic.com>
References: <20250926102037.27697-1-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

Modify the interface for calling the aw88395 driver
to adapt it for aw-common-device.c and aw-common-firmware.c

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/Kconfig                      |   14 +-
 sound/soc/codecs/Makefile                     |    8 +-
 sound/soc/codecs/aw88395.c                    | 1337 +++++++++++++++++
 .../{aw88395/aw88395_reg.h => aw88395.h}      |   58 +-
 sound/soc/codecs/aw88395/aw88395.c            |  576 -------
 sound/soc/codecs/aw88395/aw88395.h            |   58 -
 6 files changed, 1383 insertions(+), 668 deletions(-)
 create mode 100644 sound/soc/codecs/aw88395.c
 rename sound/soc/codecs/{aw88395/aw88395_reg.h => aw88395.h} (91%)
 delete mode 100644 sound/soc/codecs/aw88395/aw88395.c
 delete mode 100644 sound/soc/codecs/aw88395/aw88395.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6d7e4725d89c..a46665802b4f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -667,7 +667,7 @@ config SND_SOC_AW8738
 	  SND_SOC_SIMPLE_AMPLIFIER, but additionally allows setting the
 	  operation mode using the Awinic-specific one-wire pulse control.
 
-config SND_SOC_AW88395_LIB
+config SND_SOC_AWCOMMON_LIB
 	select CRC8
 	tristate
 
@@ -677,7 +677,7 @@ config SND_SOC_AW88395
 	select CRC32
 	select REGMAP_I2C
 	select GPIOLIB
-	select SND_SOC_AW88395_LIB
+	select SND_SOC_AWCOMMON_LIB
 	help
 	  this option enables support for aw88395 Smart PA.
 	  The Awinic AW88395 is an I2S/TDM input, high efficiency
@@ -689,7 +689,7 @@ config SND_SOC_AW88166
 	depends on I2C
 	select REGMAP_I2C
 	select GPIOLIB
-	select SND_SOC_AW88395_LIB
+	select SND_SOC_AWCOMMON_LIB
 	help
 	  This option enables support for aw88166 Smart PA.
 	  The awinic AW88166 is an I2S/TDM input, high efficiency
@@ -701,7 +701,7 @@ config SND_SOC_AW88261
 	depends on I2C
 	select REGMAP_I2C
 	select GPIOLIB
-	select SND_SOC_AW88395_LIB
+	select SND_SOC_AWCOMMON_LIB
 	help
 	  This option enables support for aw88261 Smart PA.
 	  The awinic AW88261 is an I2S/TDM input, high efficiency
@@ -713,7 +713,7 @@ config SND_SOC_AW88081
 	tristate "Soc Audio for awinic aw88081/aw88083"
 	depends on I2C
 	select REGMAP_I2C
-	select SND_SOC_AW88395_LIB
+	select SND_SOC_AWCOMMON_LIB
 	help
 	  This option enables support for aw88081 Smart PA.
 	  The awinic AW88081 is an I2S/TDM input, high efficiency
@@ -724,7 +724,7 @@ config SND_SOC_AW87390
 	tristate "Soc Audio for awinic aw87390"
 	depends on I2C
 	select REGMAP_I2C
-	select SND_SOC_AW88395_LIB
+	select SND_SOC_AWCOMMON_LIB
 	help
 	  The awinic aw87390 is specifically designed to improve
 	  the musical output dynamic range, enhance the overall
@@ -737,7 +737,7 @@ config SND_SOC_AW88399
 	select CRC8
 	select REGMAP_I2C
 	select GPIOLIB
-	select SND_SOC_AW88395_LIB
+	select SND_SOC_AWCOMMON_LIB
 	help
 	  This option enables support for aw88399 Smart PA.
 	  The awinic AW88399 is an I2S/TDM input, high efficiency
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index a68c3d192a1b..de775563def9 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -50,9 +50,9 @@ snd-soc-audio-iio-aux-y := audio-iio-aux.o
 snd-soc-aw8738-y := aw8738.o
 snd-soc-aw87390-y := aw87390.o
 snd-soc-aw88081-y := aw88081.o
-snd-soc-aw88395-lib-y := aw88395/aw88395_lib.o
-snd-soc-aw88395-y := aw88395/aw88395.o \
-			aw88395/aw88395_device.o
+snd-soc-awcommon-lib-y := aw-common-device.o \
+							aw-common-firmware.o
+snd-soc-aw88395-y := aw88395.o
 snd-soc-aw88166-y := aw88166.o
 snd-soc-aw88261-y := aw88261.o
 snd-soc-aw88399-y := aw88399.o
@@ -476,7 +476,7 @@ obj-$(CONFIG_SND_SOC_AUDIO_IIO_AUX)	+= snd-soc-audio-iio-aux.o
 obj-$(CONFIG_SND_SOC_AW8738)	+= snd-soc-aw8738.o
 obj-$(CONFIG_SND_SOC_AW87390)	+= snd-soc-aw87390.o
 obj-$(CONFIG_SND_SOC_AW88081)	+= snd-soc-aw88081.o
-obj-$(CONFIG_SND_SOC_AW88395_LIB) += snd-soc-aw88395-lib.o
+obj-$(CONFIG_SND_SOC_AWCOMMON_LIB) += snd-soc-awcommon-lib.o
 obj-$(CONFIG_SND_SOC_AW88395)	+=snd-soc-aw88395.o
 obj-$(CONFIG_SND_SOC_AW88166)	+=snd-soc-aw88166.o
 obj-$(CONFIG_SND_SOC_AW88261)	+=snd-soc-aw88261.o
diff --git a/sound/soc/codecs/aw88395.c b/sound/soc/codecs/aw88395.c
new file mode 100644
index 000000000000..3ed77e0f0df2
--- /dev/null
+++ b/sound/soc/codecs/aw88395.c
@@ -0,0 +1,1337 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw88395.c --  ALSA SoC AW88395 codec support
+//
+// Copyright (c) 2022-2023 AWINIC Technology CO., LTD
+//
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#include <linux/crc32.h>
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+#include "aw88395.h"
+#include "aw-common-device.h"
+#include "aw-common-firmware.h"
+
+struct aw88395 {
+	struct aw_device *aw_pa;
+	struct mutex lock;
+	struct delayed_work start_work;
+	struct regmap *regmap;
+};
+
+static const struct regmap_config aw88395_remap_config = {
+	.val_bits = 16,
+	.reg_bits = 8,
+	.max_register = AW88395_REG_MAX - 1,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+
+static unsigned int reg_val_to_db(unsigned int value)
+{
+	return (((value >> AW88395_VOL_6DB_START) * AW_VOLUME_STEP_DB) +
+			((value & 0x3f) % AW_VOLUME_STEP_DB));
+}
+
+static unsigned short db_to_reg_val(unsigned short value)
+{
+	return (((value / AW_VOLUME_STEP_DB) << AW88395_VOL_6DB_START) +
+			(value % AW_VOLUME_STEP_DB));
+}
+
+static void aw88395_set_volume(struct aw_device *aw_dev, unsigned int value)
+{
+	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
+	unsigned int reg_value;
+	u16 real_value, volume;
+
+	volume = min((value + vol_desc->init_volume), (unsigned int)AW88395_MUTE_VOL);
+	real_value = db_to_reg_val(volume);
+
+	/* cal real value */
+	regmap_read(aw_dev->regmap, AW88395_SYSCTRL2_REG, &reg_value);
+
+	dev_dbg(aw_dev->dev, "value 0x%x , reg:0x%x", value, real_value);
+
+	/* [15 : 6] volume */
+	real_value = (real_value << AW88395_VOL_START_BIT) | (reg_value & AW88395_VOL_MASK);
+
+	/* write value */
+	regmap_write(aw_dev->regmap, AW88395_SYSCTRL2_REG, real_value);
+}
+
+static int aw88395_check_sram(struct aw_device *aw_dev)
+{
+	unsigned int reg_val;
+
+	/* read dsp_rom_check_reg */
+	aw_dev_dsp_read(aw_dev, AW88395_DSP_ROM_CHECK_ADDR, &reg_val, AW_DSP_16_DATA);
+	if (reg_val != AW88395_DSP_ROM_CHECK_DATA) {
+		dev_err(aw_dev->dev, "check dsp rom failed ");
+		goto error;
+	}
+
+	/* check dsp_fw_base_addr */
+	aw_dev_dsp_write(aw_dev, AW88395_DSP_FW_ADDR, AW88395_DSP_ODD_NUM_BIT_TEST, AW_DSP_16_DATA);
+	aw_dev_dsp_read(aw_dev, AW88395_DSP_FW_ADDR, &reg_val, AW_DSP_16_DATA);
+	if (reg_val != AW88395_DSP_ODD_NUM_BIT_TEST) {
+		dev_err(aw_dev->dev, "check dsp fw addr failed");
+		goto error;
+	}
+
+	return 0;
+
+error:
+	return -EPERM;
+}
+
+static int aw88395_get_iis_status(struct aw_device *aw_dev)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88395_SYSST_REG, &reg_val);
+	if (ret)
+		return -EIO;
+	if ((reg_val & AW88395_BIT_PLL_CHECK) != AW88395_BIT_PLL_CHECK) {
+		dev_err(aw_dev->dev, "check pll lock fail,reg_val:0x%04x", reg_val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw88395_check_mode1_pll(struct aw_device *aw_dev)
+{
+	int ret, i;
+
+	for (i = 0; i < AW88395_DEV_SYSST_CHECK_MAX; i++) {
+		ret = aw88395_get_iis_status(aw_dev);
+		if (ret < 0) {
+			dev_err(aw_dev->dev, "mode1 iis signal check error");
+			usleep_range(AW_2000_US, AW_2000_US + 10);
+		} else {
+			return 0;
+		}
+	}
+
+	return -EPERM;
+}
+
+static int aw88395_check_mode2_pll(struct aw_device *aw_dev)
+{
+	unsigned int reg_val;
+	int ret, i;
+
+	ret = regmap_read(aw_dev->regmap, AW88395_PLLCTRL1_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_val &= (~AW88395_CCO_MUX_MASK);
+	if (reg_val == AW88395_CCO_MUX_DIVIDED_VALUE) {
+		dev_dbg(aw_dev->dev, "CCO_MUX is already divider");
+		return -EPERM;
+	}
+
+	/* change mode2 */
+	ret = regmap_update_bits(aw_dev->regmap, AW88395_PLLCTRL1_REG,
+			~AW88395_CCO_MUX_MASK, AW88395_CCO_MUX_DIVIDED_VALUE);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < AW88395_DEV_SYSST_CHECK_MAX; i++) {
+		ret = aw88395_get_iis_status(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "mode2 iis signal check error");
+			usleep_range(AW_2000_US, AW_2000_US + 10);
+		} else {
+			break;
+		}
+	}
+
+	/* change mode1 */
+	ret = regmap_update_bits(aw_dev->regmap, AW88395_PLLCTRL1_REG,
+			~AW88395_CCO_MUX_MASK, AW88395_CCO_MUX_BYPASS_VALUE);
+	if (ret == 0) {
+		usleep_range(AW_2000_US, AW_2000_US + 10);
+		for (i = 0; i < AW88395_DEV_SYSST_CHECK_MAX; i++) {
+			ret = aw88395_check_mode1_pll(aw_dev);
+			if (ret < 0) {
+				dev_err(aw_dev->dev, "mode2 switch to mode1, iis signal check error");
+				usleep_range(AW_2000_US, AW_2000_US + 10);
+			} else {
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int aw88395_check_syspll(struct aw_device *aw_dev)
+{
+	int ret;
+
+	ret = aw88395_check_mode1_pll(aw_dev);
+	if (ret) {
+		dev_dbg(aw_dev->dev, "mode1 check iis failed try switch to mode2 check");
+		ret = aw88395_check_mode2_pll(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "mode2 check iis failed");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int aw88395_check_sysst(struct aw_device *aw_dev)
+{
+	unsigned int check_val;
+	unsigned int reg_val;
+	int ret, i;
+
+	for (i = 0; i < AW88395_DEV_SYSST_CHECK_MAX; i++) {
+		ret = regmap_read(aw_dev->regmap, AW88395_SYSST_REG, &reg_val);
+		if (ret)
+			return ret;
+
+		check_val = reg_val & (~AW88395_BIT_SYSST_CHECK_MASK) & AW88395_BIT_SYSST_CHECK;
+		if (check_val != AW88395_BIT_SYSST_CHECK) {
+			dev_err(aw_dev->dev, "check sysst fail, cnt=%d, reg_val=0x%04x, check:0x%x",
+					i, reg_val, AW88395_BIT_SYSST_CHECK);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
+		} else {
+			return 0;
+		}
+	}
+
+	return -EPERM;
+}
+
+static int aw88395_check_sysint(struct aw_device *aw_dev)
+{
+	u16 reg_val;
+
+	aw_dev_get_int_status(aw_dev, &reg_val);
+
+	if (reg_val & AW88395_BIT_SYSINT_CHECK) {
+		dev_err(aw_dev->dev, "pa stop check fail:0x%04x", reg_val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void aw88395_dev_mute(struct aw_device *aw_dev, bool is_mute)
+{
+	int ret;
+
+	if (is_mute) {
+		aw_dev_fade_out(aw_dev, aw88395_set_volume);
+		ret = regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
+				~AW88395_HMUTE_MASK, AW88395_HMUTE_ENABLE_VALUE);
+	} else {
+		ret = regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
+				~AW88395_HMUTE_MASK, AW88395_HMUTE_DISABLE_VALUE);
+		aw_dev_fade_in(aw_dev, aw88395_set_volume);
+	}
+
+	if (ret)
+		dev_dbg(aw_dev->dev, "%s failed", __func__);
+}
+
+static int aw888395_cali_get_ra(struct aw_device *aw_dev)
+{
+	struct aw_cali_desc *cali_desc = &aw_dev->cali_desc;
+	uint32_t dsp_ra;
+	int ret;
+
+	ret = aw_dev_dsp_read(aw_dev, AW88395_DSP_REG_CFG_ADPZ_RA,
+				&dsp_ra, AW_DSP_32_DATA);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "read ra error");
+		return ret;
+	}
+
+	cali_desc->ra = AW88395_DSP_RE_TO_SHOW_RE(dsp_ra, AW88395_DSP_RE_SHIFT);
+
+	return 0;
+}
+
+static int aw88395_dsp_set_cali_re(struct aw_device *aw_dev)
+{
+	u32 cali_re;
+	int ret;
+
+	cali_re = AW88395_SHOW_RE_TO_DSP_RE((aw_dev->cali_desc.cali_re +
+		aw_dev->cali_desc.ra), AW88395_DSP_RE_SHIFT);
+
+	/* set cali re to device */
+	ret = aw_dev_dsp_write(aw_dev,
+			AW88395_DSP_REG_CFG_ADPZ_RE, cali_re, AW_DSP_32_DATA);
+	if (ret)
+		dev_err(aw_dev->dev, "set cali re error");
+
+	return ret;
+}
+
+static int aw88395_update_cali_re(struct aw_cali_desc *cali_desc)
+{
+	struct aw_device *aw_dev =
+		container_of(cali_desc, struct aw_device, cali_desc);
+	int ret;
+
+	if ((aw_dev->cali_desc.cali_re >= AW88395_CALI_RE_MAX) ||
+	    (aw_dev->cali_desc.cali_re <= AW88395_CALI_RE_MIN)) {
+		return -EINVAL;
+	}
+
+	ret = aw88395_dsp_set_cali_re(aw_dev);
+	if (ret)
+		dev_err(aw_dev->dev, "set cali re failed");
+
+	return ret;
+}
+
+static int aw88395_dsp_check_st(struct aw_device *aw_dev)
+{
+	unsigned int reg_val;
+	int ret;
+	int i;
+
+	for (i = 0; i < AW88395_DSP_ST_CHECK_MAX; i++) {
+		ret = regmap_read(aw_dev->regmap, AW88395_SYSST_REG, &reg_val);
+		if (ret) {
+			dev_err(aw_dev->dev, "read reg0x%x failed", AW88395_SYSST_REG);
+			continue;
+		}
+
+		if ((reg_val & (~AW88395_DSPS_MASK)) != AW88395_DSPS_NORMAL_VALUE) {
+			dev_err(aw_dev->dev, "check dsp st fail,reg_val:0x%04x", reg_val);
+			ret = -EPERM;
+			continue;
+		} else {
+			dev_dbg(aw_dev->dev, "dsp st check ok, reg_val:0x%04x", reg_val);
+			return 0;
+		}
+	}
+
+	return ret;
+}
+
+static int aw88395_copy_to_crc_dsp_cfg(struct aw_device *aw_dev,
+			unsigned char *data, unsigned int size)
+{
+	struct aw_sec_data_desc *crc_dsp_cfg = &aw_dev->crc_dsp_cfg;
+
+	if (!crc_dsp_cfg->data) {
+		crc_dsp_cfg->data = devm_kzalloc(aw_dev->dev, size, GFP_KERNEL);
+		if (!crc_dsp_cfg->data)
+			return -ENOMEM;
+		crc_dsp_cfg->len = size;
+	} else if (crc_dsp_cfg->len < size) {
+		devm_kfree(aw_dev->dev, crc_dsp_cfg->data);
+		crc_dsp_cfg->data = devm_kzalloc(aw_dev->dev, size, GFP_KERNEL);
+		if (!crc_dsp_cfg->data)
+			return -ENOMEM;
+		crc_dsp_cfg->len = size;
+	}
+	memcpy(crc_dsp_cfg->data, data, size);
+	swab16_array((u16 *)crc_dsp_cfg->data, size >> 1);
+
+	return 0;
+}
+
+static int aw88395_dsp_set_crc32(struct aw_device *aw_dev)
+{
+	struct aw_sec_data_desc *crc_dsp_cfg = &aw_dev->crc_dsp_cfg;
+	struct aw_prof_desc *set_prof_desc = NULL;
+	u32 crc_value, crc_data_len;
+	int ret;
+
+	ret = aw_dev_get_prof_data(aw_dev, aw_dev->prof_cur, &set_prof_desc);
+	if (ret)
+		return ret;
+
+	ret = aw88395_copy_to_crc_dsp_cfg(aw_dev,
+				set_prof_desc->sec_desc[AW_DATA_TYPE_DSP_CFG].data,
+				set_prof_desc->sec_desc[AW_DATA_TYPE_DSP_CFG].len);
+	if (ret)
+		return ret;
+
+	/* get crc data len */
+	crc_data_len = (AW88395_DSP_REG_CRC_ADDR - AW88395_DSP_CFG_ADDR) * 2;
+	if (crc_data_len > crc_dsp_cfg->len) {
+		dev_err(aw_dev->dev, "crc data len :%d > cfg_data len:%d",
+			crc_data_len, crc_dsp_cfg->len);
+		return -EINVAL;
+	}
+
+	if (crc_data_len & 0x11) {
+		dev_err(aw_dev->dev, "The crc data len :%d unsupport", crc_data_len);
+		return -EINVAL;
+	}
+
+	crc_value = crc32c(0xFFFFFFFF, crc_dsp_cfg->data, crc_data_len) ^ 0xFFFFFFFF;
+
+	return aw_dev_dsp_write(aw_dev, AW88395_DSP_REG_CRC_ADDR, crc_value, AW_DSP_32_DATA);
+}
+
+static int aw88395_dsp_crc_check(struct aw_device *aw_dev)
+{
+	int ret;
+
+	if (aw_dev->fw_ver < AW88395_FIRMWARE_VERSION) {
+		ret = aw88395_dsp_set_crc32(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "set dsp crc32 failed");
+			return ret;
+		}
+	}
+
+	regmap_update_bits(aw_dev->regmap, AW88395_HAGCCFG7_REG,
+				~AW88395_AGC_DSP_CTL_MASK, AW88395_AGC_DSP_CTL_ENABLE_VALUE);
+
+	/* dsp enable */
+	regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
+				~AW88395_DSPBY_MASK, AW88395_DSPBY_WORKING_VALUE);
+	usleep_range(AW_5000_US, AW_5000_US + 100);
+
+	ret = aw88395_dsp_check_st(aw_dev);
+	if (ret)
+		dev_err(aw_dev->dev, "check crc32 fail");
+
+	regmap_update_bits(aw_dev->regmap, AW88395_HAGCCFG7_REG,
+		~AW88395_AGC_DSP_CTL_MASK, AW88395_AGC_DSP_CTL_DISABLE_VALUE);
+
+	return ret;
+}
+
+static int aw88395_dsp_check(struct aw_device *aw_dev)
+{
+	int ret, i;
+
+	regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
+			~AW88395_DSPBY_MASK, AW88395_DSPBY_BYPASS_VALUE);
+	regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
+			~AW88395_DSPBY_MASK, AW88395_DSPBY_WORKING_VALUE);
+	usleep_range(AW_1000_US, AW_1000_US + 10);
+
+	for (i = 0; i < AW88395_DEV_DSP_CHECK_MAX; i++) {
+		ret = aw_dev_get_dsp_status(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "dsp wdt status error=%d", ret);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
+		} else {
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int aw88395_get_icalk(struct aw_device *aw_dev, int16_t *icalk)
+{
+	unsigned int reg_val;
+	u16 reg_icalk;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88395_EFRM2_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_icalk = reg_val & (~AW88395_EF_ISN_GESLP_MASK);
+
+	if (reg_icalk & (~AW88395_EF_ISN_GESLP_SIGN_MASK))
+		reg_icalk = reg_icalk | AW88395_EF_ISN_GESLP_SIGN_NEG;
+
+	*icalk = (int16_t)reg_icalk;
+
+	return ret;
+}
+
+static int aw88395_get_vcalk(struct aw_device *aw_dev, int16_t *vcalk)
+{
+	unsigned int reg_val;
+	u16 reg_vcalk;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88395_EFRH_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_val = reg_val >> AW88395_EF_VSENSE_GAIN_SHIFT;
+
+	reg_vcalk = (u16)reg_val & (~AW88395_EF_VSN_GESLP_MASK);
+
+	if (reg_vcalk & (~AW88395_EF_VSN_GESLP_SIGN_MASK))
+		reg_vcalk = reg_vcalk | AW88395_EF_VSN_GESLP_SIGN_NEG;
+
+	*vcalk = (int16_t)reg_vcalk;
+
+	return ret;
+}
+
+static int aw88395_get_vcalk_dac(struct aw_device *aw_dev, int16_t *vcalk)
+{
+	unsigned int reg_val;
+	u16 reg_vcalk;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88395_EFRM2_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_vcalk = reg_val >> AW88395_EF_DAC_GESLP_SHIFT;
+
+	if (reg_vcalk & AW88395_EF_DAC_GESLP_SIGN_MASK)
+		reg_vcalk = reg_vcalk | AW88395_EF_DAC_GESLP_SIGN_NEG;
+
+	*vcalk = (int16_t)reg_vcalk;
+
+	return ret;
+}
+
+static int aw88395_set_vcalb(struct aw_device *aw_dev)
+{
+	int16_t icalk_val, vcalk_val;
+	int icalk, vsense_select;
+	u32 vcalb_adj, reg_val;
+	int vcalb, vcalk;
+	int ret;
+
+	ret = aw_dev_dsp_read(aw_dev, AW88395_DSP_REG_VCALB, &vcalb_adj, AW_DSP_16_DATA);
+	if (ret) {
+		dev_err(aw_dev->dev, "read vcalb_adj failed");
+		return ret;
+	}
+
+	ret = aw88395_get_icalk(aw_dev, &icalk_val);
+	if (ret)
+		return ret;
+	icalk = AW88395_CABL_BASE_VALUE + AW88395_ICABLK_FACTOR * icalk_val;
+
+	ret = regmap_read(aw_dev->regmap, AW88395_I2SCFG3_REG, &vsense_select);
+	if (ret) {
+		dev_err(aw_dev->dev, "read vsense_reg_val failed");
+		return ret;
+	}
+	vsense_select = vsense_select & (~AW88395_VDSEL_MASK);
+
+	dev_dbg(aw_dev->dev, "vsense_select = %d", vsense_select);
+
+	switch (vsense_select) {
+	case AW88395_DEV_VDSEL_VSENSE:
+		ret = aw88395_get_vcalk(aw_dev, &vcalk_val);
+		if (ret)
+			return ret;
+		vcalk = AW88395_CABL_BASE_VALUE + AW88395_VCABLK_FACTOR * vcalk_val;
+		vcalb = AW88395_VCAL_FACTOR * AW88395_VSCAL_FACTOR /
+			AW88395_ISCAL_FACTOR * icalk / vcalk * vcalb_adj;
+
+		dev_dbg(aw_dev->dev, "vcalk_factor=%d, vscal_factor=%d, icalk=%d, vcalk=%d",
+				AW88395_VCABLK_FACTOR, AW88395_VSCAL_FACTOR, icalk, vcalk);
+		break;
+	case AW88395_DEV_VDSEL_DAC:
+		ret = aw88395_get_vcalk_dac(aw_dev, &vcalk_val);
+		if (ret)
+			return ret;
+		vcalk = AW88395_CABL_BASE_VALUE + AW88395_VCABLK_FACTOR_DAC * vcalk_val;
+		vcalb = AW88395_VCAL_FACTOR * AW88395_VSCAL_FACTOR_DAC /
+			AW88395_ISCAL_FACTOR * icalk / vcalk * vcalb_adj;
+
+		dev_dbg(aw_dev->dev, "vcalk_dac_factor=%d, vscal_dac_factor=%d, icalk=%d, vcalk=%d",
+				AW88395_VCABLK_FACTOR_DAC,
+				AW88395_VSCAL_FACTOR_DAC, icalk, vcalk);
+		break;
+	default:
+		dev_err(aw_dev->dev, "unsupported vsense status");
+		return -EINVAL;
+	}
+
+	if ((vcalk == 0) || (AW88395_ISCAL_FACTOR == 0)) {
+		dev_err(aw_dev->dev, "vcalk:%d or desc->iscal_factor:%d unsupported",
+			vcalk, AW88395_ISCAL_FACTOR);
+		return -EINVAL;
+	}
+
+	vcalb = vcalb >> AW88395_VCALB_ADJ_FACTOR;
+	reg_val = (u32)vcalb;
+
+	dev_dbg(aw_dev->dev, "vcalb=%d, reg_val=0x%x, vcalb_adj =0x%x",
+				vcalb, reg_val, vcalb_adj);
+
+	ret = aw_dev_dsp_write(aw_dev, AW88395_DSP_REG_VCALB, reg_val, AW_DSP_16_DATA);
+	if (ret)
+		dev_err(aw_dev->dev, "write vcalb failed");
+
+	return ret;
+}
+
+static int aw88395_reg_update(struct aw_device *aw_dev,
+	unsigned char *data, unsigned int len)
+{
+	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
+	int16_t *reg_data;
+	int data_len;
+	u16 read_vol;
+	u16 reg_val;
+	u8 reg_addr;
+	int i, ret;
+
+	reg_data = (int16_t *)data;
+	data_len = len >> 1;
+
+	if (data_len & 0x1) {
+		dev_err(aw_dev->dev, "data len:%d unsupported",	data_len);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < data_len; i += 2) {
+		reg_addr = reg_data[i];
+		reg_val = reg_data[i + 1];
+
+		if (reg_addr == AW88395_SYSCTRL_REG) {
+			if (reg_val & (~AW88395_DSPBY_MASK))
+				aw_dev->dsp_cfg = AW_DEV_DSP_BYPASS;
+			else
+				aw_dev->dsp_cfg = AW_DEV_DSP_WORK;
+
+			reg_val &= (AW88395_HMUTE_MASK | AW88395_PWDN_MASK | AW88395_AMPPD_MASK |
+					AW88395_DSPBY_MASK);
+			reg_val |= (AW88395_HMUTE_DISABLE_VALUE | AW88395_PWDN_POWER_DOWN_VALUE |
+				AW88395_AMPPD_POWER_DOWN_VALUE | AW88395_DSPBY_BYPASS_VALUE);
+		}
+
+		if (reg_addr == AW88395_I2SCFG1_REG) {
+			reg_val &= AW88395_I2STXEN_MASK;
+			reg_val |= AW88395_I2STXEN_DISABLE_VALUE;
+		}
+
+		if (reg_addr == AW88395_SYSCTRL2_REG) {
+			read_vol = (reg_val & (~AW88395_VOL_MASK)) >> AW88395_VOL_START_BIT;
+			aw_dev->volume_desc.init_volume = reg_val_to_db(read_vol);
+		}
+
+		if (reg_addr == AW88395_HAGCCFG7_REG)
+			reg_val &= AW88395_AGC_DSP_CTL_MASK;
+
+		ret = regmap_write(aw_dev->regmap, reg_addr, reg_val);
+		if (ret)
+			break;
+
+	}
+
+	if (aw_dev->prof_cur != aw_dev->prof_index) {
+		/* clear control volume when PA change profile */
+		vol_desc->ctl_volume = 0;
+	} else {
+		/* keep control volume when PA start with sync mode */
+		aw88395_set_volume(aw_dev, vol_desc->ctl_volume);
+	}
+
+	return ret;
+}
+
+static int aw88395_fw_update(struct aw_device *aw_dev, bool up_dsp_fw_en, bool force_up_en)
+{
+	struct aw_prof_desc *prof_index_desc;
+	struct aw_sec_data_desc *sec_desc;
+	char *prof_name;
+	int ret;
+
+	if ((aw_dev->prof_cur == aw_dev->prof_index) &&
+			(force_up_en == AW_FORCE_UPDATE_OFF)) {
+		dev_info(aw_dev->dev, "scene no change, not update");
+		return 0;
+	}
+
+	if (aw_dev->fw_status == AW_DEV_FW_FAILED) {
+		dev_err(aw_dev->dev, "fw status[%d] error", aw_dev->fw_status);
+		return -EPERM;
+	}
+
+	ret = aw_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
+	if (ret)
+		return ret;
+
+	dev_dbg(aw_dev->dev, "start update %s", prof_name);
+
+	ret = aw_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
+	if (ret)
+		return ret;
+
+	/* update reg */
+	sec_desc = prof_index_desc->sec_desc;
+	ret = aw88395_reg_update(aw_dev, sec_desc[AW_DATA_TYPE_REG].data,
+			sec_desc[AW_DATA_TYPE_REG].len);
+	if (ret) {
+		dev_err(aw_dev->dev, "update reg failed");
+		return ret;
+	}
+
+	regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG, ~AW88395_PWDN_MASK,
+					AW88395_PWDN_WORKING_VALUE);
+
+	regmap_update_bits(aw_dev->regmap, AW88395_DBGCTRL_REG, ~AW88395_MEM_CLKSEL_MASK,
+					AW88395_MEM_CLKSEL_OSC_CLK_VALUE);
+
+	if (up_dsp_fw_en) {
+		ret = aw88395_check_sram(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "check sram failed");
+			goto error;
+		}
+
+		/* update dsp firmware */
+		dev_dbg(aw_dev->dev, "fw_ver: [%x]", prof_index_desc->fw_ver);
+		ret = aw_dev_dsp_update_fw(aw_dev, sec_desc[AW_DATA_TYPE_DSP_FW].data,
+					sec_desc[AW_DATA_TYPE_DSP_FW].len,
+					sec_desc[AW_DATA_TYPE_DSP_FW].addr);
+		if (ret) {
+			dev_err(aw_dev->dev, "update dsp fw failed");
+			goto error;
+		}
+	}
+
+	/* update dsp config */
+	ret = aw_dev_dsp_update_cfg(aw_dev, sec_desc[AW_DATA_TYPE_DSP_CFG].data,
+					sec_desc[AW_DATA_TYPE_DSP_CFG].len,
+					sec_desc[AW_DATA_TYPE_DSP_CFG].addr);
+	if (ret) {
+		dev_err(aw_dev->dev, "update dsp cfg failed");
+		goto error;
+	}
+
+	aw_dev_dsp_read(aw_dev, AW88395_FIRMWARE_VERSION_ADDR,
+					&aw_dev->fw_ver, AW_DSP_16_DATA);
+	aw888395_cali_get_ra(aw_dev);
+
+	regmap_update_bits(aw_dev->regmap, AW88395_DBGCTRL_REG, ~AW88395_MEM_CLKSEL_MASK,
+					AW88395_MEM_CLKSEL_DAP_HCLK_VALUE);
+	regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG, ~AW88395_PWDN_MASK,
+					AW88395_PWDN_POWER_DOWN_VALUE);
+
+	aw_dev->prof_cur = aw_dev->prof_index;
+
+	return 0;
+
+error:
+	regmap_update_bits(aw_dev->regmap, AW88395_DBGCTRL_REG, ~AW88395_MEM_CLKSEL_MASK,
+					AW88395_MEM_CLKSEL_DAP_HCLK_VALUE);
+	regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG, ~AW88395_PWDN_MASK,
+					AW88395_PWDN_POWER_DOWN_VALUE);
+	return ret;
+}
+
+static int aw88395_dev_start(struct aw_device *aw_dev)
+{
+	int ret;
+
+	if (aw_dev->status == AW_DEV_PW_ON) {
+		dev_info(aw_dev->dev, "already power on");
+		return 0;
+	}
+
+	/* power on */
+	regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
+				~AW88395_PWDN_MASK, AW88395_PWDN_WORKING_VALUE);
+	usleep_range(AW_2000_US, AW_2000_US + 10);
+
+	ret = aw88395_check_syspll(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "pll check failed cannot start");
+		goto pll_check_fail;
+	}
+
+	/* amppd on */
+	regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
+				~AW88395_AMPPD_MASK, AW88395_AMPPD_WORKING_VALUE);
+	usleep_range(AW_1000_US, AW_1000_US + 50);
+
+	/* check i2s status */
+	ret = aw88395_check_sysst(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "sysst check failed");
+		goto sysst_check_fail;
+	}
+
+	if (aw_dev->dsp_cfg == AW_DEV_DSP_WORK) {
+		ret = aw88395_dsp_crc_check(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "dsp crc check failed");
+			goto crc_check_fail;
+		}
+		/* dsp bypass */
+		regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
+					~AW88395_DSPBY_MASK, AW88395_DSPBY_BYPASS_VALUE);
+		aw88395_set_vcalb(aw_dev);
+		aw88395_update_cali_re(&aw_dev->cali_desc);
+		ret = aw88395_dsp_check(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "dsp status check failed");
+			goto dsp_check_fail;
+		}
+	}
+
+	/* enable tx feedback */
+	regmap_update_bits(aw_dev->regmap, AW88395_I2SCFG1_REG,
+			~AW88395_I2STXEN_MASK, AW88395_I2STXEN_ENABLE_VALUE);
+
+	/* close mute */
+	aw88395_dev_mute(aw_dev, false);
+	/* clear inturrupt */
+	aw_dev_clear_int_status(aw_dev);
+	aw_dev->status = AW_DEV_PW_ON;
+
+	return 0;
+
+dsp_check_fail:
+crc_check_fail:
+	regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
+					~AW88395_DSPBY_MASK, AW88395_DSPBY_BYPASS_VALUE);
+sysst_check_fail:
+	aw_dev_clear_int_status(aw_dev);
+	regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
+				~AW88395_AMPPD_MASK, AW88395_AMPPD_POWER_DOWN_VALUE);
+pll_check_fail:
+	regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
+				~AW88395_PWDN_MASK, AW88395_PWDN_POWER_DOWN_VALUE);
+	aw_dev->status = AW_DEV_PW_OFF;
+
+	return ret;
+}
+
+static int aw88395_dev_stop(struct aw_device *aw_dev)
+{
+	struct aw_sec_data_desc *dsp_cfg =
+		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW_DATA_TYPE_DSP_CFG];
+	struct aw_sec_data_desc *dsp_fw =
+		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW_DATA_TYPE_DSP_FW];
+	int int_st = 0;
+	int ret;
+
+	if (aw_dev->status == AW_DEV_PW_OFF) {
+		dev_info(aw_dev->dev, "already power off");
+		return 0;
+	}
+
+	aw_dev->status = AW_DEV_PW_OFF;
+
+	/* set mute */
+	aw88395_dev_mute(aw_dev, true);
+	usleep_range(AW_4000_US, AW_4000_US + 100);
+
+	/* close tx feedback */
+	regmap_update_bits(aw_dev->regmap, AW88395_I2SCFG1_REG,
+			~AW88395_I2STXEN_MASK, AW88395_I2STXEN_ENABLE_VALUE);
+	usleep_range(AW_1000_US, AW_1000_US + 100);
+
+	/* check sysint state */
+	int_st = aw88395_check_sysint(aw_dev);
+
+	/* close dsp */
+	regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
+					~AW88395_DSPBY_MASK, AW88395_DSPBY_BYPASS_VALUE);
+
+	/* enable amppd */
+	regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
+				~AW88395_AMPPD_MASK, AW88395_AMPPD_POWER_DOWN_VALUE);
+
+	if (int_st < 0) {
+		/* system status anomaly */
+		regmap_update_bits(aw_dev->regmap, AW88395_DBGCTRL_REG,
+					~AW88395_MEM_CLKSEL_MASK,
+					AW88395_MEM_CLKSEL_OSC_CLK_VALUE);
+		ret = aw_dev_dsp_update_fw(aw_dev, dsp_fw->data, dsp_fw->len, dsp_fw->addr);
+		if (ret)
+			dev_err(aw_dev->dev, "update dsp fw failed");
+		ret = aw_dev_dsp_update_cfg(aw_dev, dsp_cfg->data, dsp_cfg->len, dsp_cfg->addr);
+		if (ret)
+			dev_err(aw_dev->dev, "update dsp cfg failed");
+		regmap_update_bits(aw_dev->regmap, AW88395_DBGCTRL_REG,
+					~AW88395_MEM_CLKSEL_MASK,
+					AW88395_MEM_CLKSEL_DAP_HCLK_VALUE);
+	}
+
+	/* set power down */
+	regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
+				~AW88395_PWDN_MASK, AW88395_PWDN_POWER_DOWN_VALUE);
+
+	return 0;
+}
+
+static void aw88395_start_pa(struct aw88395 *aw88395)
+{
+	int ret, i;
+
+	for (i = 0; i < AW88395_START_RETRIES; i++) {
+		ret = aw88395_dev_start(aw88395->aw_pa);
+		if (ret) {
+			dev_err(aw88395->aw_pa->dev, "aw88395 device start failed. retry = %d", i);
+			ret = aw88395_fw_update(aw88395->aw_pa, AW_DSP_FW_UPDATE_ON, true);
+			if (ret < 0) {
+				dev_err(aw88395->aw_pa->dev, "fw update failed");
+				continue;
+			}
+		} else {
+			dev_info(aw88395->aw_pa->dev, "start success\n");
+			break;
+		}
+	}
+}
+
+static void aw88395_startup_work(struct work_struct *work)
+{
+	struct aw88395 *aw88395 =
+		container_of(work, struct aw88395, start_work.work);
+
+	mutex_lock(&aw88395->lock);
+	aw88395_start_pa(aw88395);
+	mutex_unlock(&aw88395->lock);
+}
+
+static void aw88395_start(struct aw88395 *aw88395, bool sync_start)
+{
+	int ret;
+
+	if (aw88395->aw_pa->fw_status != AW_DEV_FW_OK)
+		return;
+
+	if (aw88395->aw_pa->status == AW_DEV_PW_ON)
+		return;
+
+	ret = aw88395_fw_update(aw88395->aw_pa, AW_DSP_FW_UPDATE_OFF,
+							aw88395->aw_pa->phase_sync);
+	if (ret < 0) {
+		dev_err(aw88395->aw_pa->dev, "fw update failed.");
+		return;
+	}
+
+	if (sync_start == AW_SYNC_START)
+		aw88395_start_pa(aw88395);
+	else
+		queue_delayed_work(system_wq,
+			&aw88395->start_work,
+			AW88395_START_WORK_DELAY_MS);
+}
+
+static struct snd_soc_dai_driver aw88395_dai[] = {
+	{
+		.name = "aw88395-aif",
+		.id = 1,
+		.playback = {
+			.stream_name = "Speaker_Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = AW88395_RATES,
+			.formats = AW88395_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Speaker_Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = AW88395_RATES,
+			.formats = AW88395_FORMATS,
+		},
+	},
+};
+
+static int aw88395_get_fade_in_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(component);
+	struct aw_device *aw_dev = aw88395->aw_pa;
+
+	ucontrol->value.integer.value[0] = aw_dev->fade_in_time;
+
+	return 0;
+}
+
+static int aw88395_set_fade_in_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct aw_device *aw_dev = aw88395->aw_pa;
+	int time;
+
+	time = ucontrol->value.integer.value[0];
+
+	if (time < mc->min || time > mc->max)
+		return -EINVAL;
+
+	if (time != aw_dev->fade_in_time) {
+		aw_dev->fade_in_time = time;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw88395_get_fade_out_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(component);
+	struct aw_device *aw_dev = aw88395->aw_pa;
+
+	ucontrol->value.integer.value[0] = aw_dev->fade_out_time;
+
+	return 0;
+}
+
+static int aw88395_set_fade_out_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct aw_device *aw_dev = aw88395->aw_pa;
+	int time;
+
+	time = ucontrol->value.integer.value[0];
+	if (time < mc->min || time > mc->max)
+		return -EINVAL;
+
+	if (time != aw_dev->fade_out_time) {
+		aw_dev->fade_out_time = time;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw88395_profile_info(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
+	char *prof_name;
+	int count, ret;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+
+	count = aw88395->aw_pa->prof_info.count;
+	if (count <= 0) {
+		uinfo->value.enumerated.items = 0;
+		return 0;
+	}
+
+	uinfo->value.enumerated.items = count;
+
+	if (uinfo->value.enumerated.item >= count)
+		uinfo->value.enumerated.item = count - 1;
+
+	count = uinfo->value.enumerated.item;
+
+	ret = aw_dev_get_prof_name(aw88395->aw_pa, count, &prof_name);
+	if (ret) {
+		strscpy(uinfo->value.enumerated.name, "null");
+		return 0;
+	}
+
+	strscpy(uinfo->value.enumerated.name, prof_name);
+
+	return 0;
+}
+
+static int aw88395_profile_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = aw88395->aw_pa->prof_index;
+
+	return 0;
+}
+
+static int aw88395_profile_set(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
+	int ret;
+
+	/* pa stop or stopping just set profile */
+	mutex_lock(&aw88395->lock);
+	ret = aw_dev_set_profile_index(aw88395->aw_pa, ucontrol->value.integer.value[0]);
+	if (ret < 0) {
+		dev_dbg(codec->dev, "profile index does not change");
+		mutex_unlock(&aw88395->lock);
+		return 0;
+	}
+
+	if (aw88395->aw_pa->status) {
+		aw88395_dev_stop(aw88395->aw_pa);
+		aw88395_start(aw88395, AW_SYNC_START);
+	}
+
+	mutex_unlock(&aw88395->lock);
+
+	return 1;
+}
+
+static int aw88395_volume_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
+	struct aw_volume_desc *vol_desc = &aw88395->aw_pa->volume_desc;
+
+	ucontrol->value.integer.value[0] = vol_desc->ctl_volume;
+
+	return 0;
+}
+
+static int aw88395_volume_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
+	struct aw_volume_desc *vol_desc = &aw88395->aw_pa->volume_desc;
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int value;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < mc->min || value > mc->max)
+		return -EINVAL;
+
+	if (vol_desc->ctl_volume != value) {
+		vol_desc->ctl_volume = value;
+		aw88395_set_volume(aw88395->aw_pa, vol_desc->ctl_volume);
+
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw88395_get_fade_step(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = aw88395->aw_pa->fade_step;
+
+	return 0;
+}
+
+static int aw88395_set_fade_step(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int value;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < mc->min || value > mc->max)
+		return -EINVAL;
+
+	if (aw88395->aw_pa->fade_step != value) {
+		aw88395->aw_pa->fade_step = value;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw88395_re_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
+	struct aw_device *aw_dev = aw88395->aw_pa;
+
+	ucontrol->value.integer.value[0] = aw_dev->cali_desc.cali_re;
+
+	return 0;
+}
+
+static int aw88395_re_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct aw_device *aw_dev = aw88395->aw_pa;
+	int value;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < mc->min || value > mc->max)
+		return -EINVAL;
+
+	if (aw_dev->cali_desc.cali_re != value) {
+		aw_dev->cali_desc.cali_re = value;
+		return 1;
+	}
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new aw88395_controls[] = {
+	SOC_SINGLE_EXT("PCM Playback Volume", AW88395_SYSCTRL2_REG,
+		6, AW88395_MUTE_VOL, 0, aw88395_volume_get,
+		aw88395_volume_set),
+	SOC_SINGLE_EXT("Fade Step", 0, 0, AW88395_MUTE_VOL, 0,
+		aw88395_get_fade_step, aw88395_set_fade_step),
+	SOC_SINGLE_EXT("Volume Ramp Up Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
+		aw88395_get_fade_in_time, aw88395_set_fade_in_time),
+	SOC_SINGLE_EXT("Volume Ramp Down Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
+		aw88395_get_fade_out_time, aw88395_set_fade_out_time),
+	SOC_SINGLE_EXT("Calib", 0, 0, AW88395_CALI_RE_MAX, 0,
+		aw88395_re_get, aw88395_re_set),
+	AW_PROFILE_EXT("Profile Set", aw88395_profile_info,
+		aw88395_profile_get, aw88395_profile_set),
+};
+
+static int aw88395_playback_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(component);
+
+	mutex_lock(&aw88395->lock);
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		aw88395_start(aw88395, AW_ASYNC_START);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		aw88395_dev_stop(aw88395->aw_pa);
+		break;
+	default:
+		break;
+	}
+	mutex_unlock(&aw88395->lock);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget aw88395_dapm_widgets[] = {
+	 /* playback */
+	SND_SOC_DAPM_AIF_IN_E("AIF_RX", "Speaker_Playback", 0, SND_SOC_NOPM, 0, 0,
+					aw88395_playback_event,
+					SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_OUTPUT("DAC Output"),
+
+	/* capture */
+	SND_SOC_DAPM_AIF_OUT("AIF_TX", "Speaker_Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_INPUT("ADC Input"),
+};
+
+static const struct snd_soc_dapm_route aw88395_audio_map[] = {
+	{"DAC Output", NULL, "AIF_RX"},
+	{"AIF_TX", NULL, "ADC Input"},
+};
+
+static int aw88395_codec_probe(struct snd_soc_component *component)
+{
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	INIT_DELAYED_WORK(&aw88395->start_work, aw88395_startup_work);
+
+	ret = aw_dev_request_firmware_file(aw88395->aw_pa, AW88395_ACF_FILE);
+	if (ret) {
+		dev_err(aw88395->aw_pa->dev, "%s failed\n", __func__);
+		return ret;
+	}
+
+	ret = aw88395_fw_update(aw88395->aw_pa, AW_FORCE_UPDATE_ON, AW_DSP_FW_UPDATE_ON);
+	if (ret)
+		dev_err(aw88395->aw_pa->dev, "fw update failed ret = %d\n", ret);
+
+	return ret;
+}
+
+static void aw88395_codec_remove(struct snd_soc_component *aw_codec)
+{
+	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(aw_codec);
+
+	cancel_delayed_work_sync(&aw88395->start_work);
+}
+
+static const struct snd_soc_component_driver soc_codec_dev_aw88395 = {
+	.probe = aw88395_codec_probe,
+	.remove = aw88395_codec_remove,
+	.dapm_widgets = aw88395_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(aw88395_dapm_widgets),
+	.dapm_routes = aw88395_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(aw88395_audio_map),
+	.controls = aw88395_controls,
+	.num_controls = ARRAY_SIZE(aw88395_controls),
+};
+
+static int aw88395_i2c_probe(struct i2c_client *i2c)
+{
+	struct aw88395 *aw88395;
+	int ret;
+
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C))
+		return dev_err_probe(&i2c->dev, -ENXIO, "check_functionality failed");
+
+	aw88395 = devm_kzalloc(&i2c->dev, sizeof(*aw88395), GFP_KERNEL);
+	if (!aw88395)
+		return -ENOMEM;
+
+	mutex_init(&aw88395->lock);
+	i2c_set_clientdata(i2c, aw88395);
+
+	aw88395->aw_pa = devm_kzalloc(&i2c->dev, sizeof(*aw88395->aw_pa), GFP_KERNEL);
+	if (!aw88395->aw_pa)
+		return -ENOMEM;
+
+	aw88395->aw_pa->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(aw88395->aw_pa->reset_gpio))
+		dev_info(&i2c->dev, "reset gpio not defined\n");
+	else
+		aw_hw_reset(aw88395->aw_pa);
+
+	aw88395->regmap = devm_regmap_init_i2c(i2c, &aw88395_remap_config);
+	if (IS_ERR(aw88395->regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(aw88395->regmap),
+							"failed to init regmap\n");
+
+	/* aw pa init */
+	ret = aw_dev_init(aw88395->aw_pa, i2c, aw88395->regmap);
+	if (ret)
+		return ret;
+
+	return devm_snd_soc_register_component(&i2c->dev, &soc_codec_dev_aw88395,
+						aw88395_dai, ARRAY_SIZE(aw88395_dai));
+}
+
+static const struct i2c_device_id aw88395_i2c_id[] = {
+	{ AW88395_I2C_NAME },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aw88395_i2c_id);
+
+static struct i2c_driver aw88395_i2c_driver = {
+	.driver = {
+		.name = AW88395_I2C_NAME,
+	},
+	.probe = aw88395_i2c_probe,
+	.id_table = aw88395_i2c_id,
+};
+module_i2c_driver(aw88395_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC AW88395 Smart PA Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/aw88395/aw88395_reg.h b/sound/soc/codecs/aw88395.h
similarity index 91%
rename from sound/soc/codecs/aw88395/aw88395_reg.h
rename to sound/soc/codecs/aw88395.h
index e64f24e97150..436d314e8df7 100644
--- a/sound/soc/codecs/aw88395/aw88395_reg.h
+++ b/sound/soc/codecs/aw88395.h
@@ -1,14 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 //
-// aw88395_reg.h --  AW88395 chip register file
+// aw88395.h --  ALSA SoC AW88395 codec support
 //
 // Copyright (c) 2022-2023 AWINIC Technology CO., LTD
 //
-// Author: Bruce zhao <zhaolei@awinic.com>
+// Author: Weidong Wang <wangweidong.a@awinic.com>
 //
 
-#ifndef __AW88395_REG_H__
-#define __AW88395_REG_H__
+#ifndef __AW88395_H__
+#define __AW88395_H___
 
 #define AW88395_ID_REG			(0x00)
 #define AW88395_SYSST_REG		(0x01)
@@ -94,14 +94,8 @@
 #define AW88395_EFRL_REG		(0x7B)
 #define AW88395_TM_REG			(0x7C)
 
-enum aw88395_id {
-	AW88395_CHIP_ID = 0x2049,
-};
-
 #define AW88395_REG_MAX		(0x7D)
 
-#define AW88395_VOLUME_STEP_DB		(6 * 8)
-
 #define AW88395_UVLS_START_BIT		(14)
 #define AW88395_UVLS_NORMAL		(0)
 #define AW88395_UVLS_NORMAL_VALUE	\
@@ -216,15 +210,6 @@ enum aw88395_id {
 #define AW88395_HMUTE_ENABLE_VALUE	\
 	(AW88395_HMUTE_ENABLE << AW88395_HMUTE_START_BIT)
 
-#define AW88395_RCV_MODE_START_BIT	(7)
-#define AW88395_RCV_MODE_BITS_LEN	(1)
-#define AW88395_RCV_MODE_MASK		\
-	(~(((1<<AW88395_RCV_MODE_BITS_LEN)-1) << AW88395_RCV_MODE_START_BIT))
-
-#define AW88395_RCV_MODE_RECEIVER	(1)
-#define AW88395_RCV_MODE_RECEIVER_VALUE	\
-	(AW88395_RCV_MODE_RECEIVER << AW88395_RCV_MODE_START_BIT)
-
 #define AW88395_DSPBY_START_BIT	(2)
 #define AW88395_DSPBY_BITS_LEN		(1)
 #define AW88395_DSPBY_MASK		\
@@ -265,7 +250,6 @@ enum aw88395_id {
 	(AW88395_PWDN_POWER_DOWN << AW88395_PWDN_START_BIT)
 
 #define AW88395_MUTE_VOL		(90 * 8)
-#define AW88395_VOLUME_STEP_DB		(6 * 8)
 
 #define AW88395_VOL_6DB_START		(6)
 #define AW88395_VOL_START_BIT		(6)
@@ -273,8 +257,6 @@ enum aw88395_id {
 #define AW88395_VOL_MASK		\
 	(~(((1<<AW88395_VOL_BITS_LEN)-1) << AW88395_VOL_START_BIT))
 
-#define AW88395_VOL_DEFAULT_VALUE	(0)
-
 #define AW88395_I2STXEN_START_BIT	(0)
 #define AW88395_I2STXEN_BITS_LEN	(1)
 #define AW88395_I2STXEN_MASK		\
@@ -375,9 +357,39 @@ enum aw88395_id {
 #define AW88395_DSP_REG_CFG_ADPZ_RE	(0x9D00)
 #define AW88395_DSP_REG_VCALB		(0x9CF7)
 #define AW88395_DSP_RE_SHIFT		(12)
+#define AW88395_FIRMWARE_VERSION_ADDR	(0x8CD0)
 
 #define AW88395_DSP_REG_CFG_ADPZ_RA	(0x9D02)
 #define AW88395_DSP_REG_CRC_ADDR	(0x9F42)
-#define AW88395_DSP_CALI_F0_DELAY	(0x9CFD)
+
+#define AW88395_DSP_ROM_CHECK_ADDR	(0x12C8)
+#define AW88395_DSP_ROM_CHECK_DATA	(0xF7FE)
+
+#define AW88395_START_RETRIES			(5)
+#define AW88395_START_WORK_DELAY_MS		(0)
+
+#define AW88395_DEV_DSP_CHECK_MAX		(5)
+#define AW88395_DSP_ODD_NUM_BIT_TEST		(0x5555)
+#define AW88395_DSP_ST_CHECK_MAX		(2)
+#define AW88395_CALI_RE_MAX			(15000)
+#define AW88395_CALI_RE_MIN			(4000)
+#define AW88395_DSP_RE_TO_SHOW_RE(re, shift)	(((re) * (1000)) >> (shift))
+#define AW88395_SHOW_RE_TO_DSP_RE(re, shift)	(((re) << shift) / (1000))
+#define AW88395_DEV_SYSST_CHECK_MAX		(10)
+
+#define AW88395_FIRMWARE_VERSION		(0x0002)
+#define AW88395_I2C_NAME			"aw88395"
+#define AW88395_ACF_FILE			"aw88395_acf.bin"
+
+#define AW88395_RATES (SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_96000)
+
+#define AW88395_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE)
+
+enum {
+	AW88395_DEV_VDSEL_DAC = 0,
+	AW88395_DEV_VDSEL_VSENSE = 1,
+};
 
 #endif
diff --git a/sound/soc/codecs/aw88395/aw88395.c b/sound/soc/codecs/aw88395/aw88395.c
deleted file mode 100644
index fb563b4c6971..000000000000
--- a/sound/soc/codecs/aw88395/aw88395.c
+++ /dev/null
@@ -1,576 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-//
-// aw88395.c --  ALSA SoC AW88395 codec support
-//
-// Copyright (c) 2022-2023 AWINIC Technology CO., LTD
-//
-// Author: Bruce zhao <zhaolei@awinic.com>
-// Author: Weidong Wang <wangweidong.a@awinic.com>
-//
-
-#include <linux/gpio/consumer.h>
-#include <linux/i2c.h>
-#include <linux/firmware.h>
-#include <linux/regmap.h>
-#include <sound/soc.h>
-#include "aw88395.h"
-#include "aw88395_device.h"
-#include "aw88395_lib.h"
-#include "aw88395_reg.h"
-
-static const struct regmap_config aw88395_remap_config = {
-	.val_bits = 16,
-	.reg_bits = 8,
-	.max_register = AW88395_REG_MAX - 1,
-	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
-	.val_format_endian = REGMAP_ENDIAN_BIG,
-};
-
-static void aw88395_start_pa(struct aw88395 *aw88395)
-{
-	int ret, i;
-
-	for (i = 0; i < AW88395_START_RETRIES; i++) {
-		ret = aw88395_dev_start(aw88395->aw_pa);
-		if (ret) {
-			dev_err(aw88395->aw_pa->dev, "aw88395 device start failed. retry = %d", i);
-			ret = aw88395_dev_fw_update(aw88395->aw_pa, AW88395_DSP_FW_UPDATE_ON, true);
-			if (ret < 0) {
-				dev_err(aw88395->aw_pa->dev, "fw update failed");
-				continue;
-			}
-		} else {
-			dev_info(aw88395->aw_pa->dev, "start success\n");
-			break;
-		}
-	}
-}
-
-static void aw88395_startup_work(struct work_struct *work)
-{
-	struct aw88395 *aw88395 =
-		container_of(work, struct aw88395, start_work.work);
-
-	mutex_lock(&aw88395->lock);
-	aw88395_start_pa(aw88395);
-	mutex_unlock(&aw88395->lock);
-}
-
-static void aw88395_start(struct aw88395 *aw88395, bool sync_start)
-{
-	int ret;
-
-	if (aw88395->aw_pa->fw_status != AW88395_DEV_FW_OK)
-		return;
-
-	if (aw88395->aw_pa->status == AW88395_DEV_PW_ON)
-		return;
-
-	ret = aw88395_dev_fw_update(aw88395->aw_pa, AW88395_DSP_FW_UPDATE_OFF, true);
-	if (ret < 0) {
-		dev_err(aw88395->aw_pa->dev, "fw update failed.");
-		return;
-	}
-
-	if (sync_start == AW88395_SYNC_START)
-		aw88395_start_pa(aw88395);
-	else
-		queue_delayed_work(system_wq,
-			&aw88395->start_work,
-			AW88395_START_WORK_DELAY_MS);
-}
-
-static struct snd_soc_dai_driver aw88395_dai[] = {
-	{
-		.name = "aw88395-aif",
-		.id = 1,
-		.playback = {
-			.stream_name = "Speaker_Playback",
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = AW88395_RATES,
-			.formats = AW88395_FORMATS,
-		},
-		.capture = {
-			.stream_name = "Speaker_Capture",
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = AW88395_RATES,
-			.formats = AW88395_FORMATS,
-		},
-	},
-};
-
-static int aw88395_get_fade_in_time(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(component);
-	struct aw_device *aw_dev = aw88395->aw_pa;
-
-	ucontrol->value.integer.value[0] = aw_dev->fade_in_time;
-
-	return 0;
-}
-
-static int aw88395_set_fade_in_time(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(component);
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	struct aw_device *aw_dev = aw88395->aw_pa;
-	int time;
-
-	time = ucontrol->value.integer.value[0];
-
-	if (time < mc->min || time > mc->max)
-		return -EINVAL;
-
-	if (time != aw_dev->fade_in_time) {
-		aw_dev->fade_in_time = time;
-		return 1;
-	}
-
-	return 0;
-}
-
-static int aw88395_get_fade_out_time(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(component);
-	struct aw_device *aw_dev = aw88395->aw_pa;
-
-	ucontrol->value.integer.value[0] = aw_dev->fade_out_time;
-
-	return 0;
-}
-
-static int aw88395_set_fade_out_time(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(component);
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	struct aw_device *aw_dev = aw88395->aw_pa;
-	int time;
-
-	time = ucontrol->value.integer.value[0];
-	if (time < mc->min || time > mc->max)
-		return -EINVAL;
-
-	if (time != aw_dev->fade_out_time) {
-		aw_dev->fade_out_time = time;
-		return 1;
-	}
-
-	return 0;
-}
-
-static int aw88395_profile_info(struct snd_kcontrol *kcontrol,
-			 struct snd_ctl_elem_info *uinfo)
-{
-	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
-	char *prof_name;
-	int count, ret;
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-
-	count = aw88395_dev_get_profile_count(aw88395->aw_pa);
-	if (count <= 0) {
-		uinfo->value.enumerated.items = 0;
-		return 0;
-	}
-
-	uinfo->value.enumerated.items = count;
-
-	if (uinfo->value.enumerated.item >= count)
-		uinfo->value.enumerated.item = count - 1;
-
-	count = uinfo->value.enumerated.item;
-
-	ret = aw88395_dev_get_prof_name(aw88395->aw_pa, count, &prof_name);
-	if (ret) {
-		strscpy(uinfo->value.enumerated.name, "null");
-		return 0;
-	}
-
-	strscpy(uinfo->value.enumerated.name, prof_name);
-
-	return 0;
-}
-
-static int aw88395_profile_get(struct snd_kcontrol *kcontrol,
-			struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
-
-	ucontrol->value.integer.value[0] = aw88395_dev_get_profile_index(aw88395->aw_pa);
-
-	return 0;
-}
-
-static int aw88395_profile_set(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
-	int ret;
-
-	/* pa stop or stopping just set profile */
-	mutex_lock(&aw88395->lock);
-	ret = aw88395_dev_set_profile_index(aw88395->aw_pa, ucontrol->value.integer.value[0]);
-	if (ret < 0) {
-		dev_dbg(codec->dev, "profile index does not change");
-		mutex_unlock(&aw88395->lock);
-		return 0;
-	}
-
-	if (aw88395->aw_pa->status) {
-		aw88395_dev_stop(aw88395->aw_pa);
-		aw88395_start(aw88395, AW88395_SYNC_START);
-	}
-
-	mutex_unlock(&aw88395->lock);
-
-	return 1;
-}
-
-static int aw88395_volume_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
-	struct aw_volume_desc *vol_desc = &aw88395->aw_pa->volume_desc;
-
-	ucontrol->value.integer.value[0] = vol_desc->ctl_volume;
-
-	return 0;
-}
-
-static int aw88395_volume_set(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
-	struct aw_volume_desc *vol_desc = &aw88395->aw_pa->volume_desc;
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	int value;
-
-	value = ucontrol->value.integer.value[0];
-	if (value < mc->min || value > mc->max)
-		return -EINVAL;
-
-	if (vol_desc->ctl_volume != value) {
-		vol_desc->ctl_volume = value;
-		aw88395_dev_set_volume(aw88395->aw_pa, vol_desc->ctl_volume);
-
-		return 1;
-	}
-
-	return 0;
-}
-
-static int aw88395_get_fade_step(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
-
-	ucontrol->value.integer.value[0] = aw88395->aw_pa->fade_step;
-
-	return 0;
-}
-
-static int aw88395_set_fade_step(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	int value;
-
-	value = ucontrol->value.integer.value[0];
-	if (value < mc->min || value > mc->max)
-		return -EINVAL;
-
-	if (aw88395->aw_pa->fade_step != value) {
-		aw88395->aw_pa->fade_step = value;
-		return 1;
-	}
-
-	return 0;
-}
-
-static int aw88395_re_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
-	struct aw_device *aw_dev = aw88395->aw_pa;
-
-	ucontrol->value.integer.value[0] = aw_dev->cali_desc.cali_re;
-
-	return 0;
-}
-
-static int aw88395_re_set(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	struct aw_device *aw_dev = aw88395->aw_pa;
-	int value;
-
-	value = ucontrol->value.integer.value[0];
-	if (value < mc->min || value > mc->max)
-		return -EINVAL;
-
-	if (aw_dev->cali_desc.cali_re != value) {
-		aw_dev->cali_desc.cali_re = value;
-		return 1;
-	}
-
-	return 0;
-}
-
-static const struct snd_kcontrol_new aw88395_controls[] = {
-	SOC_SINGLE_EXT("PCM Playback Volume", AW88395_SYSCTRL2_REG,
-		6, AW88395_MUTE_VOL, 0, aw88395_volume_get,
-		aw88395_volume_set),
-	SOC_SINGLE_EXT("Fade Step", 0, 0, AW88395_MUTE_VOL, 0,
-		aw88395_get_fade_step, aw88395_set_fade_step),
-	SOC_SINGLE_EXT("Volume Ramp Up Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
-		aw88395_get_fade_in_time, aw88395_set_fade_in_time),
-	SOC_SINGLE_EXT("Volume Ramp Down Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
-		aw88395_get_fade_out_time, aw88395_set_fade_out_time),
-	SOC_SINGLE_EXT("Calib", 0, 0, AW88395_CALI_RE_MAX, 0,
-		aw88395_re_get, aw88395_re_set),
-	AW88395_PROFILE_EXT("Profile Set", aw88395_profile_info,
-		aw88395_profile_get, aw88395_profile_set),
-};
-
-static int aw88395_playback_event(struct snd_soc_dapm_widget *w,
-				struct snd_kcontrol *k, int event)
-{
-	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(component);
-
-	mutex_lock(&aw88395->lock);
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		aw88395_start(aw88395, AW88395_ASYNC_START);
-		break;
-	case SND_SOC_DAPM_POST_PMD:
-		aw88395_dev_stop(aw88395->aw_pa);
-		break;
-	default:
-		break;
-	}
-	mutex_unlock(&aw88395->lock);
-
-	return 0;
-}
-
-static const struct snd_soc_dapm_widget aw88395_dapm_widgets[] = {
-	 /* playback */
-	SND_SOC_DAPM_AIF_IN_E("AIF_RX", "Speaker_Playback", 0, 0, 0, 0,
-					aw88395_playback_event,
-					SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_OUTPUT("DAC Output"),
-
-	/* capture */
-	SND_SOC_DAPM_AIF_OUT("AIF_TX", "Speaker_Capture", 0, SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_INPUT("ADC Input"),
-};
-
-static const struct snd_soc_dapm_route aw88395_audio_map[] = {
-	{"DAC Output", NULL, "AIF_RX"},
-	{"AIF_TX", NULL, "ADC Input"},
-};
-
-static int aw88395_codec_probe(struct snd_soc_component *component)
-{
-	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(component);
-	int ret;
-
-	INIT_DELAYED_WORK(&aw88395->start_work, aw88395_startup_work);
-
-	/* add widgets */
-	ret = snd_soc_dapm_new_controls(dapm, aw88395_dapm_widgets,
-							ARRAY_SIZE(aw88395_dapm_widgets));
-	if (ret < 0)
-		return ret;
-
-	/* add route */
-	ret = snd_soc_dapm_add_routes(dapm, aw88395_audio_map,
-							ARRAY_SIZE(aw88395_audio_map));
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_add_component_controls(component, aw88395_controls,
-							ARRAY_SIZE(aw88395_controls));
-
-	return ret;
-}
-
-static void aw88395_codec_remove(struct snd_soc_component *aw_codec)
-{
-	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(aw_codec);
-
-	cancel_delayed_work_sync(&aw88395->start_work);
-}
-
-static const struct snd_soc_component_driver soc_codec_dev_aw88395 = {
-	.probe = aw88395_codec_probe,
-	.remove = aw88395_codec_remove,
-};
-
-static struct aw88395 *aw88395_malloc_init(struct i2c_client *i2c)
-{
-	struct aw88395 *aw88395 = devm_kzalloc(&i2c->dev,
-			sizeof(struct aw88395), GFP_KERNEL);
-	if (!aw88395)
-		return NULL;
-
-	mutex_init(&aw88395->lock);
-
-	return aw88395;
-}
-
-static void aw88395_hw_reset(struct aw88395 *aw88395)
-{
-	if (aw88395->reset_gpio) {
-		gpiod_set_value_cansleep(aw88395->reset_gpio, 0);
-		usleep_range(AW88395_1000_US, AW88395_1000_US + 10);
-		gpiod_set_value_cansleep(aw88395->reset_gpio, 1);
-		usleep_range(AW88395_1000_US, AW88395_1000_US + 10);
-	} else {
-		dev_err(aw88395->aw_pa->dev, "%s failed", __func__);
-	}
-}
-
-static int aw88395_request_firmware_file(struct aw88395 *aw88395)
-{
-	const struct firmware *cont = NULL;
-	int ret;
-
-	aw88395->aw_pa->fw_status = AW88395_DEV_FW_FAILED;
-
-	ret = request_firmware(&cont, AW88395_ACF_FILE, aw88395->aw_pa->dev);
-	if ((ret < 0) || (!cont)) {
-		dev_err(aw88395->aw_pa->dev, "load [%s] failed!", AW88395_ACF_FILE);
-		return ret;
-	}
-
-	dev_info(aw88395->aw_pa->dev, "loaded %s - size: %zu\n",
-			AW88395_ACF_FILE, cont ? cont->size : 0);
-
-	aw88395->aw_cfg = devm_kzalloc(aw88395->aw_pa->dev, cont->size + sizeof(int), GFP_KERNEL);
-	if (!aw88395->aw_cfg) {
-		release_firmware(cont);
-		return -ENOMEM;
-	}
-	aw88395->aw_cfg->len = (int)cont->size;
-	memcpy(aw88395->aw_cfg->data, cont->data, cont->size);
-	release_firmware(cont);
-
-	ret = aw88395_dev_load_acf_check(aw88395->aw_pa, aw88395->aw_cfg);
-	if (ret < 0) {
-		dev_err(aw88395->aw_pa->dev, "Load [%s] failed ....!", AW88395_ACF_FILE);
-		return ret;
-	}
-
-	dev_dbg(aw88395->aw_pa->dev, "%s : bin load success\n", __func__);
-
-	mutex_lock(&aw88395->lock);
-	/* aw device init */
-	ret = aw88395_dev_init(aw88395->aw_pa, aw88395->aw_cfg);
-	if (ret < 0)
-		dev_err(aw88395->aw_pa->dev, "dev init failed");
-	mutex_unlock(&aw88395->lock);
-
-	return ret;
-}
-
-static int aw88395_i2c_probe(struct i2c_client *i2c)
-{
-	struct aw88395 *aw88395;
-	int ret;
-
-	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
-		dev_err(&i2c->dev, "check_functionality failed");
-		return -EIO;
-	}
-
-	aw88395 = aw88395_malloc_init(i2c);
-	if (!aw88395) {
-		dev_err(&i2c->dev, "malloc aw88395 failed");
-		return -ENOMEM;
-	}
-	i2c_set_clientdata(i2c, aw88395);
-
-	aw88395->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(aw88395->reset_gpio))
-		dev_info(&i2c->dev, "reset gpio not defined\n");
-
-	/* hardware reset */
-	aw88395_hw_reset(aw88395);
-
-	aw88395->regmap = devm_regmap_init_i2c(i2c, &aw88395_remap_config);
-	if (IS_ERR(aw88395->regmap)) {
-		ret = PTR_ERR(aw88395->regmap);
-		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
-		return ret;
-	}
-
-	/* aw pa init */
-	ret = aw88395_init(&aw88395->aw_pa, i2c, aw88395->regmap);
-	if (ret < 0)
-		return ret;
-
-	ret = aw88395_request_firmware_file(aw88395);
-	if (ret < 0) {
-		dev_err(&i2c->dev, "%s failed\n", __func__);
-		return ret;
-	}
-
-	ret = devm_snd_soc_register_component(&i2c->dev,
-			&soc_codec_dev_aw88395,
-			aw88395_dai, ARRAY_SIZE(aw88395_dai));
-	if (ret < 0) {
-		dev_err(&i2c->dev, "failed to register aw88395: %d", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct i2c_device_id aw88395_i2c_id[] = {
-	{ AW88395_I2C_NAME },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, aw88395_i2c_id);
-
-static struct i2c_driver aw88395_i2c_driver = {
-	.driver = {
-		.name = AW88395_I2C_NAME,
-	},
-	.probe = aw88395_i2c_probe,
-	.id_table = aw88395_i2c_id,
-};
-module_i2c_driver(aw88395_i2c_driver);
-
-MODULE_DESCRIPTION("ASoC AW88395 Smart PA Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/aw88395/aw88395.h b/sound/soc/codecs/aw88395/aw88395.h
deleted file mode 100644
index c2a4f0cb8cd5..000000000000
--- a/sound/soc/codecs/aw88395/aw88395.h
+++ /dev/null
@@ -1,58 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-//
-// aw88395.h --  ALSA SoC AW88395 codec support
-//
-// Copyright (c) 2022-2023 AWINIC Technology CO., LTD
-//
-// Author: Bruce zhao <zhaolei@awinic.com>
-//
-
-#ifndef __AW88395_H__
-#define __AW88395_H__
-
-#define AW88395_CHIP_ID_REG			(0x00)
-#define AW88395_START_RETRIES			(5)
-#define AW88395_START_WORK_DELAY_MS		(0)
-
-#define AW88395_DSP_16_DATA_MASK		(0x0000ffff)
-
-#define AW88395_I2C_NAME			"aw88395"
-
-#define AW88395_RATES (SNDRV_PCM_RATE_8000_48000 | \
-			SNDRV_PCM_RATE_96000)
-#define AW88395_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
-			SNDRV_PCM_FMTBIT_S24_LE | \
-			SNDRV_PCM_FMTBIT_S32_LE)
-
-#define FADE_TIME_MAX			100000
-#define FADE_TIME_MIN			0
-
-#define AW88395_PROFILE_EXT(xname, profile_info, profile_get, profile_set) \
-{ \
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name = xname, \
-	.info = profile_info, \
-	.get = profile_get, \
-	.put = profile_set, \
-}
-
-enum {
-	AW88395_SYNC_START = 0,
-	AW88395_ASYNC_START,
-};
-
-enum {
-	AW88395_STREAM_CLOSE = 0,
-	AW88395_STREAM_OPEN,
-};
-
-struct aw88395 {
-	struct aw_device *aw_pa;
-	struct mutex lock;
-	struct gpio_desc *reset_gpio;
-	struct delayed_work start_work;
-	struct regmap *regmap;
-	struct aw_container *aw_cfg;
-};
-
-#endif
-- 
2.47.0


