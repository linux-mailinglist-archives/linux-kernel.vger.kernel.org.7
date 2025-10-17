Return-Path: <linux-kernel+bounces-857829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 351F6BE8066
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BA84086ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D90311C1F;
	Fri, 17 Oct 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b="O0AeaRnL"
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3641217648;
	Fri, 17 Oct 2025 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696201; cv=none; b=h12PkgpWlVyxeaI7TLUbufhQFalv5hW05IyPCHDWOU6WnV16VyxTVrBfoIjUa10vcWfwKCsB+4fqwPvevGAc/oGAlRPETnMNGYS/50qWestKIQWSko0M4jffgAJq0EtoDqMEZFmbxLgIi/Aeur98zkV/dEBeMf2MlADUsKzQd5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696201; c=relaxed/simple;
	bh=NtiEfhwSlKvzv9fCYiBBQbEDi6VnIxvDsTFjKOnXB88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlxX42EpNnai1Kcpsd9tQuL2H/yc9qdmh3DbQfGK12tWvD/GEDyWp5FooTJe4my0EYoOnM7RKuRyHtLxjBA4G7ETNsASejMxEX5177AQ7YytIYTnDZGwmVOovUr1g70GYkkJt1oZMWtukdJ0E0lq7OGv5rfqQxvtpAjFx/BSOvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b=O0AeaRnL; arc=none smtp.client-ip=115.124.28.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=awinic.com; s=default;
	t=1760696192; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lFnQMyyYc/KgKmbw6mN+bE402KYmH6G1SaLLjzUZmgw=;
	b=O0AeaRnL3j7h0+2nQr4wv+KwN0X3YOF9PvMCeJv4WQgw0U0lbPaGllwVTZlkYJuO6jpJvP3Cb9cWXl4KRjmsKdEpAigS6L+yBxXJlLmlbklRxDY2VQgntlL8LPf39qeh87fCluXF4yvZuyWNOuhe5fALluLBeHRx+pOIkUSaFamGIgSLGWhGde8UoIhuMejJxh2S8QivM+MUc7uGiweEVEryQD47Il8l3O/lM5RVt6C8E4BeTKufO/9zY2Ke7C1Q+6+YxWJiWd2Cvv+j1Y1d9FpMM3/8fBBudW5kUF4Oq8D/nHTNrVVZCdxjzxuYAEF5qzLGq/hejeTX+vVrOyLFAQ==
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.f0sBXz6_1760695870 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 18:11:11 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	arnd@arndb.de,
	wangweidong.a@awinic.com,
	srinivas.kandagatla@oss.qualcomm.com,
	cy_huang@richtek.com,
	nick.li@foursemi.com,
	hangyi@everest-semi.com,
	alexey.klimov@linaro.org,
	niranjan.hy@ti.com,
	shenghao-ding@ti.com,
	linux@treblig.org,
	rf@opensource.cirrus.com,
	thorsten.blum@linux.dev,
	yesanishhere@gmail.com,
	ardb@kernel.org,
	ebiggers@google.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V2 1/7] ASoC: codecs:Rework the awinic driver lib
Date: Fri, 17 Oct 2025 18:10:59 +0800
Message-ID: <20251017101106.370742-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251017101106.370742-1-wangweidong.a@awinic.com>
References: <20251017101106.370742-1-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

Extract the awxxxx driver common interfaces into
aw-common-firmware and aw-common-device
to facilitate subsequent driver usage.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw-common-device.c           |  508 +++++
 sound/soc/codecs/aw-common-device.h           |  206 ++
 .../aw88395_lib.c => aw-common-firmware.c}    |  150 +-
 sound/soc/codecs/aw-common-firmware.h         |  211 ++
 sound/soc/codecs/aw88395/aw88395_data_type.h  |  142 --
 sound/soc/codecs/aw88395/aw88395_device.c     | 1720 -----------------
 sound/soc/codecs/aw88395/aw88395_device.h     |  214 --
 sound/soc/codecs/aw88395/aw88395_lib.h        |   92 -
 8 files changed, 1001 insertions(+), 2242 deletions(-)
 create mode 100644 sound/soc/codecs/aw-common-device.c
 create mode 100644 sound/soc/codecs/aw-common-device.h
 rename sound/soc/codecs/{aw88395/aw88395_lib.c => aw-common-firmware.c} (89%)
 create mode 100644 sound/soc/codecs/aw-common-firmware.h
 delete mode 100644 sound/soc/codecs/aw88395/aw88395_data_type.h
 delete mode 100644 sound/soc/codecs/aw88395/aw88395_device.c
 delete mode 100644 sound/soc/codecs/aw88395/aw88395_device.h
 delete mode 100644 sound/soc/codecs/aw88395/aw88395_lib.h

diff --git a/sound/soc/codecs/aw-common-device.c b/sound/soc/codecs/aw-common-device.c
new file mode 100644
index 000000000000..772064a015f6
--- /dev/null
+++ b/sound/soc/codecs/aw-common-device.c
@@ -0,0 +1,508 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw-dev-common.h --  awinic amp common driver interface
+//
+// Copyright (c) 2025 AWINIC Technology CO., LTD
+//
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#include <linux/crc8.h>
+#include <linux/i2c.h>
+#include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regmap.h>
+#include "aw-common-device.h"
+#include "aw-common-firmware.h"
+
+static int aw_dev_dsp_write_16bit(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int dsp_data)
+{
+	int ret;
+
+	ret = regmap_write(aw_dev->regmap, AW_DSPMADD_REG, dsp_addr);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s write addr error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	ret = regmap_write(aw_dev->regmap, AW_DSPMDAT_REG, (u16)dsp_data);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s write data error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int aw_dev_dsp_write_32bit(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int dsp_data)
+{
+	u16 temp_data;
+	int ret;
+
+	ret = regmap_write(aw_dev->regmap, AW_DSPMADD_REG, dsp_addr);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s write addr error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	temp_data = dsp_data & AW_DSP_16_DATA_MASK;
+	ret = regmap_write(aw_dev->regmap, AW_DSPMDAT_REG, (u16)temp_data);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s write datal error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	temp_data = dsp_data >> 16;
+	ret = regmap_write(aw_dev->regmap, AW_DSPMDAT_REG, (u16)temp_data);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s write datah error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int aw_dev_dsp_write(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int dsp_data, unsigned char data_type)
+{
+	u32 reg_value;
+	int ret;
+
+	mutex_lock(&aw_dev->dsp_lock);
+	switch (data_type) {
+	case AW_DSP_16_DATA:
+		ret = aw_dev_dsp_write_16bit(aw_dev, dsp_addr, dsp_data);
+		if (ret)
+			dev_err(aw_dev->dev, "write dsp_addr[0x%x] 16-bit dsp_data[0x%x] failed",
+					dsp_addr, dsp_data);
+		break;
+	case AW_DSP_32_DATA:
+		ret = aw_dev_dsp_write_32bit(aw_dev, dsp_addr, dsp_data);
+		if (ret)
+			dev_err(aw_dev->dev, "write dsp_addr[0x%x] 32-bit dsp_data[0x%x] failed",
+					dsp_addr, dsp_data);
+		break;
+	default:
+		dev_err(aw_dev->dev, "data type[%d] unsupported", data_type);
+		ret = -EINVAL;
+		break;
+	}
+
+	/* clear dsp chip select state */
+	if (regmap_read(aw_dev->regmap, AW_ID_REG, &reg_value))
+		dev_err(aw_dev->dev, "%s fail to clear chip state. Err=%d\n", __func__, ret);
+	mutex_unlock(&aw_dev->dsp_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(aw_dev_dsp_write);
+
+int aw_dev_dsp_read_16bit(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int *dsp_data)
+{
+	unsigned int temp_data;
+	int ret;
+
+	ret = regmap_write(aw_dev->regmap, AW_DSPMADD_REG, dsp_addr);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	ret = regmap_read(aw_dev->regmap, AW_DSPMDAT_REG, &temp_data);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
+		return ret;
+	}
+	*dsp_data = temp_data;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aw_dev_dsp_read_16bit);
+
+static int aw_dev_dsp_read_32bit(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int *dsp_data)
+{
+	unsigned int temp_data;
+	int ret;
+
+	ret = regmap_write(aw_dev->regmap, AW_DSPMADD_REG, dsp_addr);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	ret = regmap_read(aw_dev->regmap, AW_DSPMDAT_REG, &temp_data);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
+		return ret;
+	}
+	*dsp_data = temp_data;
+
+	ret = regmap_read(aw_dev->regmap, AW_DSPMDAT_REG, &temp_data);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
+		return ret;
+	}
+	*dsp_data |= (temp_data << 16);
+
+	return 0;
+}
+
+int aw_dev_dsp_read(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int *dsp_data, unsigned char data_type)
+{
+	u32 reg_value;
+	int ret;
+
+	mutex_lock(&aw_dev->dsp_lock);
+	switch (data_type) {
+	case AW_DSP_16_DATA:
+		ret = aw_dev_dsp_read_16bit(aw_dev, dsp_addr, dsp_data);
+		if (ret)
+			dev_err(aw_dev->dev, "read dsp_addr[0x%x] 16-bit dsp_data[0x%x] failed",
+					dsp_addr, *dsp_data);
+		break;
+	case AW_DSP_32_DATA:
+		ret = aw_dev_dsp_read_32bit(aw_dev, dsp_addr, dsp_data);
+		if (ret)
+			dev_err(aw_dev->dev, "read dsp_addr[0x%x] 32r-bit dsp_data[0x%x] failed",
+					dsp_addr, *dsp_data);
+		break;
+	default:
+		dev_err(aw_dev->dev, "data type[%d] unsupported", data_type);
+		ret = -EINVAL;
+		break;
+	}
+
+	/* clear dsp chip select state */
+	if (regmap_read(aw_dev->regmap, AW_ID_REG, &reg_value))
+		dev_err(aw_dev->dev, "%s fail to clear chip state. Err=%d\n", __func__, ret);
+	mutex_unlock(&aw_dev->dsp_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(aw_dev_dsp_read);
+
+int aw_dev_get_dsp_status(struct aw_device *aw_dev)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW_WDT_REG, &reg_val);
+	if (ret)
+		return ret;
+	if (!(reg_val & (~AW_WDT_CNT_MASK)))
+		ret = -EPERM;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(aw_dev_get_dsp_status);
+
+void aw_dev_get_int_status(struct aw_device *aw_dev, unsigned short *int_status)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW_SYSINT_REG, &reg_val);
+	if (ret)
+		dev_err(aw_dev->dev, "read interrupt reg fail, ret=%d", ret);
+	else
+		*int_status = reg_val;
+
+	dev_dbg(aw_dev->dev, "read interrupt reg = 0x%04x", *int_status);
+}
+EXPORT_SYMBOL_GPL(aw_dev_get_int_status);
+
+void aw_dev_clear_int_status(struct aw_device *aw_dev)
+{
+	u16 int_status;
+
+	/* read int status and clear */
+	aw_dev_get_int_status(aw_dev, &int_status);
+	/* make sure int status is clear */
+	aw_dev_get_int_status(aw_dev, &int_status);
+	if (int_status)
+		dev_info(aw_dev->dev, "int status(%d) is not cleaned.\n", int_status);
+}
+EXPORT_SYMBOL_GPL(aw_dev_clear_int_status);
+
+static int aw_dev_dsp_update_container(struct aw_device *aw_dev,
+			unsigned char *data, unsigned int len, unsigned short base)
+{
+	u32 tmp_len;
+	int i, ret;
+
+	mutex_lock(&aw_dev->dsp_lock);
+	ret = regmap_write(aw_dev->regmap, AW_DSPMADD_REG, base);
+	if (ret)
+		goto error_operation;
+
+	for (i = 0; i < len; i += AW_MAX_RAM_WRITE_BYTE_SIZE) {
+		tmp_len = min(len - i, AW_MAX_RAM_WRITE_BYTE_SIZE);
+		ret = regmap_raw_write(aw_dev->regmap, AW_DSPMDAT_REG,
+					&data[i], tmp_len);
+		if (ret)
+			goto error_operation;
+	}
+	mutex_unlock(&aw_dev->dsp_lock);
+
+	return 0;
+
+error_operation:
+	mutex_unlock(&aw_dev->dsp_lock);
+	return ret;
+}
+
+int aw_dev_dsp_update_fw(struct aw_device *aw_dev,
+			unsigned char *data, unsigned int len, unsigned int addr)
+{
+	dev_dbg(aw_dev->dev, "dsp firmware len:%d", len);
+
+	if (!len || !data) {
+		dev_err(aw_dev->dev, "dsp firmware data is null or len is 0");
+		return -EINVAL;
+	}
+	aw_dev_dsp_update_container(aw_dev, data, len, addr);
+	aw_dev->dsp_fw_len = len;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aw_dev_dsp_update_fw);
+
+int aw_dev_dsp_update_cfg(struct aw_device *aw_dev,
+			unsigned char *data, unsigned int len, unsigned int addr)
+{
+	dev_dbg(aw_dev->dev, "dsp config len:%d", len);
+
+	if (!len || !data) {
+		dev_err(aw_dev->dev, "dsp config data is null or len is 0");
+		return -EINVAL;
+	}
+
+	aw_dev_dsp_update_container(aw_dev, data, len, addr);
+	aw_dev->dsp_cfg_len = len;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aw_dev_dsp_update_cfg);
+
+int aw_dev_set_profile_index(struct aw_device *aw_dev, int index)
+{
+	/* check the index whether is valid */
+	if ((index >= aw_dev->prof_info.count) || (index < 0))
+		return -EINVAL;
+	/* check the index whether change */
+	if (aw_dev->prof_index == index)
+		return -EINVAL;
+
+	aw_dev->prof_index = index;
+	dev_dbg(aw_dev->dev, "set prof[%s]",
+		aw_dev->prof_info.prof_name_list[aw_dev->prof_info.prof_desc[index].id]);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aw_dev_set_profile_index);
+
+int aw_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name)
+{
+	struct aw_prof_info *prof_info = &aw_dev->prof_info;
+	struct aw_prof_desc *prof_desc;
+
+	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
+		dev_err(aw_dev->dev, "index[%d] overflow count[%d]",
+			index, aw_dev->prof_info.count);
+		return -EINVAL;
+	}
+
+	prof_desc = &aw_dev->prof_info.prof_desc[index];
+
+	*prof_name = prof_info->prof_name_list[prof_desc->id];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aw_dev_get_prof_name);
+
+int aw_dev_get_prof_data(struct aw_device *aw_dev, int index,
+			struct aw_prof_desc **prof_desc)
+{
+	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
+		dev_err(aw_dev->dev, "%s: index[%d] overflow count[%d]\n",
+				__func__, index, aw_dev->prof_info.count);
+		return -EINVAL;
+	}
+
+	*prof_desc = &aw_dev->prof_info.prof_desc[index];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aw_dev_get_prof_data);
+
+static int aw_dev_read_chipid(struct aw_device *aw_dev, u16 *chip_id)
+{
+	int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW_ID_REG, &reg_val);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s read chipid error. ret = %d", __func__, ret);
+		return ret;
+	}
+
+	dev_info(aw_dev->dev, "chip id = %x\n", reg_val);
+	*chip_id = reg_val;
+
+	return 0;
+}
+
+static void aw_parse_channel_dt(struct aw_device *aw_dev)
+{
+	struct device_node *np = aw_dev->dev->of_node;
+	u32 channel_value;
+
+	of_property_read_u32(np, "awinic,audio-channel", &channel_value);
+	aw_dev->channel = channel_value;
+	aw_dev->phase_sync = of_property_read_bool(np, "awinic,sync-flag");
+}
+
+int aw_dev_init(struct aw_device *aw_dev, struct i2c_client *i2c, struct regmap *regmap)
+{
+	u16 chip_id;
+	int ret;
+
+	aw_dev->i2c = i2c;
+	aw_dev->dev = &i2c->dev;
+	aw_dev->regmap = regmap;
+	mutex_init(&aw_dev->dsp_lock);
+
+	/* read chip id */
+	ret = aw_dev_read_chipid(aw_dev, &chip_id);
+	if (ret) {
+		dev_err(&i2c->dev, "dev_read_chipid failed ret=%d", ret);
+		return ret;
+	}
+
+	aw_dev->chip_id = chip_id;
+	aw_dev->acf = NULL;
+	aw_dev->prof_info.prof_desc = NULL;
+	aw_dev->prof_info.count = 0;
+	aw_dev->prof_info.prof_type = AW_DEV_NONE_TYPE_ID;
+	aw_dev->channel = 0;
+	aw_dev->fw_status = AW_DEV_FW_FAILED;
+
+	aw_dev->fade_step = AW_VOLUME_STEP_DB;
+	aw_dev->volume_desc.ctl_volume = AW_VOL_DEFAULT_VALUE;
+
+	aw_dev->fade_in_time = AW_1000_US / 10;
+	aw_dev->fade_out_time = AW_1000_US >> 1;
+
+	aw_parse_channel_dt(aw_dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aw_dev_init);
+
+int aw_dev_request_firmware_file(struct aw_device *aw_dev, char *acf_name)
+{
+	const struct firmware *cont = NULL;
+	int ret;
+
+	aw_dev->fw_status = AW_DEV_FW_FAILED;
+
+	ret = request_firmware(&cont, acf_name, aw_dev->dev);
+	if ((ret < 0) || (!cont)) {
+		dev_err(aw_dev->dev, "load [%s] failed!", acf_name);
+		return ret;
+	}
+
+	dev_dbg(aw_dev->dev, "loaded %s - size: %zu\n", acf_name, cont ? cont->size : 0);
+
+	aw_dev->aw_cfg = devm_kzalloc(aw_dev->dev, cont->size + sizeof(int), GFP_KERNEL);
+	if (!aw_dev->aw_cfg) {
+		release_firmware(cont);
+		return -ENOMEM;
+	}
+
+	aw_dev->aw_cfg->len = (int)cont->size;
+	memcpy(aw_dev->aw_cfg->data, cont->data, cont->size);
+	release_firmware(cont);
+
+	ret = aw_dev_load_acf_check(aw_dev, aw_dev->aw_cfg);
+	if (ret < 0) {
+		dev_err(aw_dev->dev, "Load [%s] failed ....!", acf_name);
+		return ret;
+	}
+
+	ret = aw_dev_cfg_load(aw_dev, aw_dev->aw_cfg);
+	if (ret) {
+		dev_err(aw_dev->dev, "aw_dev acf parse failed");
+		return -EINVAL;
+	}
+
+	aw_dev->prof_cur = aw_dev->prof_info.prof_desc[0].id;
+	aw_dev->prof_index = aw_dev->prof_info.prof_desc[0].id;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(aw_dev_request_firmware_file);
+
+void aw_dev_fade_in(struct aw_device *aw_dev,
+	void (*set_volume)(struct aw_device *aw_dev, unsigned int value))
+{
+	struct aw_volume_desc *desc = &aw_dev->volume_desc;
+	u16 fade_in_vol = desc->ctl_volume;
+	int fade_step = aw_dev->fade_step;
+	int i;
+
+	if (fade_step == 0 || aw_dev->fade_in_time == 0) {
+		set_volume(aw_dev, fade_in_vol);
+		return;
+	}
+
+	for (i = desc->mute_volume; i >= fade_in_vol; i -= fade_step) {
+		set_volume(aw_dev, i);
+		usleep_range(aw_dev->fade_in_time, aw_dev->fade_in_time + 10);
+	}
+
+	if (i != fade_in_vol)
+		set_volume(aw_dev, fade_in_vol);
+}
+EXPORT_SYMBOL_GPL(aw_dev_fade_in);
+
+void aw_dev_fade_out(struct aw_device *aw_dev,
+	void (*set_volume)(struct aw_device *aw_dev, unsigned int value))
+{
+	struct aw_volume_desc *desc = &aw_dev->volume_desc;
+	int fade_step = aw_dev->fade_step;
+	int i;
+
+	if (fade_step == 0 || aw_dev->fade_out_time == 0) {
+		set_volume(aw_dev, desc->mute_volume);
+		return;
+	}
+
+	for (i = desc->ctl_volume; i <= desc->mute_volume; i += fade_step) {
+		set_volume(aw_dev, i);
+		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
+	}
+
+	if (i != desc->mute_volume) {
+		set_volume(aw_dev, desc->mute_volume);
+		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
+	}
+}
+EXPORT_SYMBOL_GPL(aw_dev_fade_out);
+
+void aw_hw_reset(struct aw_device *aw_dev)
+{
+	gpiod_set_value_cansleep(aw_dev->reset_gpio, 1);
+	usleep_range(AW_1000_US, AW_1000_US + 10);
+	gpiod_set_value_cansleep(aw_dev->reset_gpio, 0);
+	usleep_range(AW_1000_US, AW_1000_US + 10);
+}
+EXPORT_SYMBOL_GPL(aw_hw_reset);
+
+MODULE_DESCRIPTION("awinic device lib");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/aw-common-device.h b/sound/soc/codecs/aw-common-device.h
new file mode 100644
index 000000000000..32d21c428455
--- /dev/null
+++ b/sound/soc/codecs/aw-common-device.h
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw-dev-common.h --  awinic amp common driver interface
+//
+// Copyright (c) 2025 AWINIC Technology CO., LTD
+//
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#ifndef __AW_COMMON_DEVICE_H__
+#define __AW_COMMON_DEVICE_H__
+
+#define AW_ID_REG		(0x00)
+#define AW_SYSINT_REG		(0x02)
+#define AW_DSPMADD_REG		(0x40)
+#define AW_DSPMDAT_REG		(0x41)
+#define AW_WDT_REG		(0x42)
+#define AW_DSP_16_DATA_MASK	(0x0000ffff)
+#define AW_WDT_CNT_START_BIT	(0)
+#define AW_WDT_CNT_BITS_LEN	(8)
+#define AW_WDT_CNT_MASK		\
+	(~(((1<<AW_WDT_CNT_BITS_LEN)-1) << AW_WDT_CNT_START_BIT))
+
+#define AW_VOLUME_STEP_DB		(6 * 8)
+#define AW_VOL_DEFAULT_VALUE		(0)
+#define AW_DSP_I2C_WRITES
+#define AW_MAX_RAM_WRITE_BYTE_SIZE	(128)
+#define AW_DATA_TYPE_NUM		(3)
+#define FADE_TIME_MAX			100000
+#define FADE_TIME_MIN			0
+#define AW_PROFILE_NUM_MAX		10
+
+#define AW_PROFILE_EXT(xname, profile_info, profile_get, profile_set) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.info = profile_info, \
+	.get = profile_get, \
+	.put = profile_set, \
+}
+
+enum {
+	AW_DSP_FW_UPDATE_OFF = 0,
+	AW_DSP_FW_UPDATE_ON = 1,
+};
+
+enum {
+	AW_FORCE_UPDATE_OFF = 0,
+	AW_FORCE_UPDATE_ON = 1,
+};
+
+enum {
+	AW_1000_US = 1000,
+	AW_2000_US = 2000,
+	AW_3000_US = 3000,
+	AW_4000_US = 4000,
+	AW_5000_US = 5000,
+	AW_10000_US = 10000,
+	AW_100000_US = 100000,
+};
+
+enum AW_DEV_PW_STATUS {
+	AW_DEV_PW_OFF = 0,
+	AW_DEV_PW_ON,
+};
+
+enum AW_DEV_FW_STATUS {
+	AW_DEV_FW_FAILED = 0,
+	AW_DEV_FW_OK,
+};
+
+enum AW_DEV_DSP_CFG {
+	AW_DEV_DSP_WORK = 0,
+	AW_DEV_DSP_BYPASS = 1,
+};
+
+enum {
+	AW_DSP_16_DATA = 0,
+	AW_DSP_32_DATA = 1,
+};
+
+enum {
+	CALI_RESULT_NORMAL,
+	CALI_RESULT_ERROR,
+};
+
+enum {
+	AW_SYNC_START = 0,
+	AW_ASYNC_START,
+};
+
+#define AW_CALI_CFG_NUM (4)
+struct cali_cfg {
+	uint32_t data[AW_CALI_CFG_NUM];
+};
+
+struct aw_cali_backup_desc {
+	unsigned int dsp_ng_cfg;
+	unsigned int dsp_lp_cfg;
+};
+
+struct aw_cali_desc {
+	u32 cali_re;
+	u32 ra;
+	bool cali_switch;
+	bool cali_running;
+	uint16_t cali_result;
+	uint16_t store_vol;
+	struct cali_cfg cali_cfg;
+	struct aw_cali_backup_desc backup_info;
+};
+
+struct aw_sec_data_desc {
+	u32 addr;
+	u32 len;
+	u8 *data;
+};
+
+struct aw_prof_desc {
+	u32 id;
+	u32 prof_st;
+	char *prf_str;
+	u32 fw_ver;
+	struct aw_sec_data_desc sec_desc[AW_DATA_TYPE_NUM];
+};
+
+struct aw_all_prof_info {
+	struct aw_prof_desc prof_desc[AW_PROFILE_NUM_MAX];
+};
+
+struct aw_prof_info {
+	int count;
+	int prof_type;
+	char **prof_name_list;
+	struct aw_prof_desc *prof_desc;
+};
+
+struct aw_volume_desc {
+	unsigned int init_volume;
+	unsigned int mute_volume;
+	unsigned int ctl_volume;
+	unsigned int max_volume;
+};
+
+struct aw_device {
+	int status;
+	struct mutex dsp_lock;
+
+	unsigned char prof_cur;
+	unsigned char prof_index;
+	unsigned char dsp_crc_st;
+	unsigned char dsp_cfg;
+	u16 chip_id;
+
+	unsigned int channel;
+	unsigned int fade_step;
+	unsigned int prof_data_type;
+
+	struct i2c_client *i2c;
+	struct gpio_desc *reset_gpio;
+	struct device *dev;
+	struct regmap *regmap;
+	char *acf;
+
+	u32 dsp_fw_len;
+	u32 dsp_cfg_len;
+	u32 fw_ver;
+	u8 fw_status;
+	bool phase_sync;
+
+	unsigned int fade_in_time;
+	unsigned int fade_out_time;
+
+	struct aw_container *aw_cfg;
+	struct aw_prof_info prof_info;
+	struct aw_sec_data_desc crc_dsp_cfg;
+	struct aw_volume_desc volume_desc;
+
+	struct aw_cali_desc cali_desc;
+};
+
+int aw_dev_init(struct aw_device *aw_dev, struct i2c_client *i2c, struct regmap *regmap);
+int aw_dev_request_firmware_file(struct aw_device *aw_dev, char *acf_name);
+int aw_dev_get_prof_data(struct aw_device *aw_dev, int index, struct aw_prof_desc **prof_desc);
+int aw_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name);
+int aw_dev_set_profile_index(struct aw_device *aw_dev, int index);
+int aw_dev_dsp_update_fw(struct aw_device *aw_dev, unsigned char *data,
+		unsigned int len, unsigned int addr);
+int aw_dev_dsp_update_cfg(struct aw_device *aw_dev,
+		unsigned char *data, unsigned int len, unsigned int addr);
+int aw_dev_dsp_read_16bit(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int *dsp_data);
+int aw_dev_get_dsp_status(struct aw_device *aw_dev);
+int aw_dev_dsp_read(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int *dsp_data, unsigned char data_type);
+int aw_dev_dsp_write(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int dsp_data, unsigned char data_type);
+void aw_dev_get_int_status(struct aw_device *aw_dev, unsigned short *int_status);
+void aw_dev_clear_int_status(struct aw_device *aw_dev);
+void aw_dev_fade_out(struct aw_device *aw_dev,
+	void (*set_volume)(struct aw_device *aw_dev, unsigned int value));
+void aw_dev_fade_in(struct aw_device *aw_dev,
+	void (*set_volume)(struct aw_device *aw_dev, unsigned int value));
+void aw_hw_reset(struct aw_device *aw_dev);
+
+#endif
diff --git a/sound/soc/codecs/aw88395/aw88395_lib.c b/sound/soc/codecs/aw-common-firmware.c
similarity index 89%
rename from sound/soc/codecs/aw88395/aw88395_lib.c
rename to sound/soc/codecs/aw-common-firmware.c
index ceb7fc43d018..120b6511fd99 100644
--- a/sound/soc/codecs/aw88395/aw88395_lib.c
+++ b/sound/soc/codecs/aw-common-firmware.c
@@ -1,22 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0-only
 //
-// aw88395_lib.c  -- ACF bin parsing and check library file for aw88395
+// aw-common-firmware.h --  awinic amp common firmware interface
 //
-// Copyright (c) 2022-2023 AWINIC Technology CO., LTD
+// Copyright (c) 2025 AWINIC Technology CO., LTD
 //
-// Author: Bruce zhao <zhaolei@awinic.com>
+// Author: Weidong Wang <wangweidong.a@awinic.com>
 //
 
 #include <linux/cleanup.h>
 #include <linux/crc8.h>
 #include <linux/i2c.h>
-#include "aw88395_lib.h"
-#include "aw88395_device.h"
+#include "aw-common-firmware.h"
 
-#define AW88395_CRC8_POLYNOMIAL 0x8C
+#define AW_CRC8_POLYNOMIAL 0x8C
 DECLARE_CRC8_TABLE(aw_crc8_table);
 
-static char *profile_name[AW88395_PROFILE_MAX] = {
+static char *profile_name[AW_PROFILE_MAX] = {
 	"Music", "Voice", "Voip", "Ringtone",
 	"Ringtone_hs", "Lowpower", "Bypass",
 	"Mmi", "Fm", "Notification", "Receiver"
@@ -319,10 +318,10 @@ static int aw_parsing_bin_file(struct aw_device *aw_dev, struct aw_bin *bin)
 static int aw_dev_parse_raw_reg(unsigned char *data, unsigned int data_len,
 		struct aw_prof_desc *prof_desc)
 {
-	prof_desc->sec_desc[AW88395_DATA_TYPE_REG].data = data;
-	prof_desc->sec_desc[AW88395_DATA_TYPE_REG].len = data_len;
+	prof_desc->sec_desc[AW_DATA_TYPE_REG].data = data;
+	prof_desc->sec_desc[AW_DATA_TYPE_REG].len = data_len;
 
-	prof_desc->prof_st = AW88395_PROFILE_OK;
+	prof_desc->prof_st = AW_PROFILE_OK;
 
 	return 0;
 }
@@ -335,10 +334,10 @@ static int aw_dev_parse_raw_dsp_cfg(unsigned char *data, unsigned int data_len,
 
 	swab16_array((u16 *)data, data_len >> 1);
 
-	prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_CFG].data = data;
-	prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_CFG].len = data_len;
+	prof_desc->sec_desc[AW_DATA_TYPE_DSP_CFG].data = data;
+	prof_desc->sec_desc[AW_DATA_TYPE_DSP_CFG].len = data_len;
 
-	prof_desc->prof_st = AW88395_PROFILE_OK;
+	prof_desc->prof_st = AW_PROFILE_OK;
 
 	return 0;
 }
@@ -351,10 +350,10 @@ static int aw_dev_parse_raw_dsp_fw(unsigned char *data,	unsigned int data_len,
 
 	swab16_array((u16 *)data, data_len >> 1);
 
-	prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_FW].data = data;
-	prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_FW].len = data_len;
+	prof_desc->sec_desc[AW_DATA_TYPE_DSP_FW].data = data;
+	prof_desc->sec_desc[AW_DATA_TYPE_DSP_FW].len = data_len;
 
-	prof_desc->prof_st = AW88395_PROFILE_OK;
+	prof_desc->prof_st = AW_PROFILE_OK;
 
 	return 0;
 }
@@ -362,8 +361,7 @@ static int aw_dev_parse_raw_dsp_fw(unsigned char *data,	unsigned int data_len,
 static int aw_dev_prof_parse_multi_bin(struct aw_device *aw_dev, unsigned char *data,
 				unsigned int data_len, struct aw_prof_desc *prof_desc)
 {
-	int ret;
-	int i;
+	int ret, i;
 
 	struct aw_bin *aw_bin __free(kfree) = kzalloc(data_len + sizeof(struct aw_bin),
 						     GFP_KERNEL);
@@ -382,9 +380,9 @@ static int aw_dev_prof_parse_multi_bin(struct aw_device *aw_dev, unsigned char *
 	for (i = 0; i < aw_bin->all_bin_parse_num; i++) {
 		switch (aw_bin->header_info[i].bin_data_type) {
 		case DATA_TYPE_REGISTER:
-			prof_desc->sec_desc[AW88395_DATA_TYPE_REG].len =
+			prof_desc->sec_desc[AW_DATA_TYPE_REG].len =
 					aw_bin->header_info[i].valid_data_len;
-			prof_desc->sec_desc[AW88395_DATA_TYPE_REG].data =
+			prof_desc->sec_desc[AW_DATA_TYPE_REG].data =
 					data + aw_bin->header_info[i].valid_data_addr;
 			break;
 		case DATA_TYPE_DSP_REG:
@@ -394,10 +392,12 @@ static int aw_dev_prof_parse_multi_bin(struct aw_device *aw_dev, unsigned char *
 			swab16_array((u16 *)(data + aw_bin->header_info[i].valid_data_addr),
 					aw_bin->header_info[i].valid_data_len >> 1);
 
-			prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_CFG].len =
+			prof_desc->sec_desc[AW_DATA_TYPE_DSP_CFG].len =
 					aw_bin->header_info[i].valid_data_len;
-			prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_CFG].data =
+			prof_desc->sec_desc[AW_DATA_TYPE_DSP_CFG].data =
 					data + aw_bin->header_info[i].valid_data_addr;
+			prof_desc->sec_desc[AW_DATA_TYPE_DSP_CFG].addr =
+					aw_bin->header_info[i].download_addr;
 			break;
 		case DATA_TYPE_DSP_FW:
 		case DATA_TYPE_SOC_APP:
@@ -408,17 +408,19 @@ static int aw_dev_prof_parse_multi_bin(struct aw_device *aw_dev, unsigned char *
 					aw_bin->header_info[i].valid_data_len >> 1);
 
 			prof_desc->fw_ver = aw_bin->header_info[i].app_version;
-			prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_FW].len =
+			prof_desc->sec_desc[AW_DATA_TYPE_DSP_FW].len =
 					aw_bin->header_info[i].valid_data_len;
-			prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_FW].data =
+			prof_desc->sec_desc[AW_DATA_TYPE_DSP_FW].data =
 					data + aw_bin->header_info[i].valid_data_addr;
+			prof_desc->sec_desc[AW_DATA_TYPE_DSP_FW].addr =
+					aw_bin->header_info[i].download_addr;
 			break;
 		default:
 			dev_dbg(aw_dev->dev, "bin_data_type not found");
 			break;
 		}
 	}
-	prof_desc->prof_st = AW88395_PROFILE_OK;
+	prof_desc->prof_st = AW_PROFILE_OK;
 
 	return 0;
 }
@@ -448,11 +450,11 @@ static int aw_dev_parse_reg_bin_with_hdr(struct aw_device *aw_dev,
 		return -EINVAL;
 	}
 
-	prof_desc->sec_desc[AW88395_DATA_TYPE_REG].data =
+	prof_desc->sec_desc[AW_DATA_TYPE_REG].data =
 				data + aw_bin->header_info[0].valid_data_addr;
-	prof_desc->sec_desc[AW88395_DATA_TYPE_REG].len =
+	prof_desc->sec_desc[AW_DATA_TYPE_REG].len =
 				aw_bin->header_info[0].valid_data_len;
-	prof_desc->prof_st = AW88395_PROFILE_OK;
+	prof_desc->prof_st = AW_PROFILE_OK;
 
 	return 0;
 }
@@ -497,9 +499,9 @@ static int aw_dev_parse_dev_type(struct aw_device *aw_dev,
 	for (i = 0; i < prof_hdr->ddt_num; i++) {
 		if ((aw_dev->i2c->adapter->nr == cfg_dde[i].dev_bus) &&
 		    (aw_dev->i2c->addr == cfg_dde[i].dev_addr) &&
-		    (cfg_dde[i].type == AW88395_DEV_TYPE_ID) &&
+		    (cfg_dde[i].type == AW_DEV_TYPE_ID) &&
 		    (cfg_dde[i].data_type != ACF_SEC_TYPE_MONITOR)) {
-			if (cfg_dde[i].dev_profile >= AW88395_PROFILE_MAX) {
+			if (cfg_dde[i].dev_profile >= AW_PROFILE_MAX) {
 				dev_err(aw_dev->dev, "dev_profile [%d] overflow",
 							cfg_dde[i].dev_profile);
 				return -EINVAL;
@@ -517,10 +519,10 @@ static int aw_dev_parse_dev_type(struct aw_device *aw_dev,
 
 	if (sec_num == 0) {
 		dev_dbg(aw_dev->dev, "get dev type num is %d, please use default", sec_num);
-		return AW88395_DEV_TYPE_NONE;
+		return AW_DEV_TYPE_NONE;
 	}
 
-	return AW88395_DEV_TYPE_OK;
+	return AW_DEV_TYPE_OK;
 }
 
 static int aw_dev_parse_dev_default_type(struct aw_device *aw_dev,
@@ -533,9 +535,9 @@ static int aw_dev_parse_dev_default_type(struct aw_device *aw_dev,
 
 	for (i = 0; i < prof_hdr->ddt_num; i++) {
 		if ((aw_dev->channel == cfg_dde[i].dev_index) &&
-		    (cfg_dde[i].type == AW88395_DEV_DEFAULT_TYPE_ID) &&
+		    (cfg_dde[i].type == AW_DEV_DEFAULT_TYPE_ID) &&
 		    (cfg_dde[i].data_type != ACF_SEC_TYPE_MONITOR)) {
-			if (cfg_dde[i].dev_profile >= AW88395_PROFILE_MAX) {
+			if (cfg_dde[i].dev_profile >= AW_PROFILE_MAX) {
 				dev_err(aw_dev->dev, "dev_profile [%d] overflow",
 					cfg_dde[i].dev_profile);
 				return -EINVAL;
@@ -567,8 +569,8 @@ static int aw_dev_cfg_get_reg_valid_prof(struct aw_device *aw_dev,
 	int num = 0;
 	int i;
 
-	for (i = 0; i < AW88395_PROFILE_MAX; i++) {
-		if (prof_desc[i].prof_st == AW88395_PROFILE_OK)
+	for (i = 0; i < AW_PROFILE_MAX; i++) {
+		if (prof_desc[i].prof_st == AW_PROFILE_OK)
 			prof_info->count++;
 	}
 
@@ -585,8 +587,8 @@ static int aw_dev_cfg_get_reg_valid_prof(struct aw_device *aw_dev,
 	if (!prof_info->prof_desc)
 		return -ENOMEM;
 
-	for (i = 0; i < AW88395_PROFILE_MAX; i++) {
-		if (prof_desc[i].prof_st == AW88395_PROFILE_OK) {
+	for (i = 0; i < AW_PROFILE_MAX; i++) {
+		if (prof_desc[i].prof_st == AW_PROFILE_OK) {
 			if (num >= prof_info->count) {
 				dev_err(aw_dev->dev, "overflow count[%d]",
 						prof_info->count);
@@ -610,15 +612,15 @@ static int aw_dev_cfg_get_multiple_valid_prof(struct aw_device *aw_dev,
 	int num = 0;
 	int i;
 
-	for (i = 0; i < AW88395_PROFILE_MAX; i++) {
-		if (prof_desc[i].prof_st == AW88395_PROFILE_OK) {
+	for (i = 0; i < AW_PROFILE_MAX; i++) {
+		if (prof_desc[i].prof_st == AW_PROFILE_OK) {
 			sec_desc = prof_desc[i].sec_desc;
-			if ((sec_desc[AW88395_DATA_TYPE_REG].data != NULL) &&
-			    (sec_desc[AW88395_DATA_TYPE_REG].len != 0) &&
-			    (sec_desc[AW88395_DATA_TYPE_DSP_CFG].data != NULL) &&
-			    (sec_desc[AW88395_DATA_TYPE_DSP_CFG].len != 0) &&
-			    (sec_desc[AW88395_DATA_TYPE_DSP_FW].data != NULL) &&
-			    (sec_desc[AW88395_DATA_TYPE_DSP_FW].len != 0))
+			if ((sec_desc[AW_DATA_TYPE_REG].data != NULL) &&
+			    (sec_desc[AW_DATA_TYPE_REG].len != 0) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_CFG].data != NULL) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_CFG].len != 0) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_FW].data != NULL) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_FW].len != 0))
 				prof_info->count++;
 		}
 	}
@@ -636,15 +638,15 @@ static int aw_dev_cfg_get_multiple_valid_prof(struct aw_device *aw_dev,
 	if (!prof_info->prof_desc)
 		return -ENOMEM;
 
-	for (i = 0; i < AW88395_PROFILE_MAX; i++) {
-		if (prof_desc[i].prof_st == AW88395_PROFILE_OK) {
+	for (i = 0; i < AW_PROFILE_MAX; i++) {
+		if (prof_desc[i].prof_st == AW_PROFILE_OK) {
 			sec_desc = prof_desc[i].sec_desc;
-			if ((sec_desc[AW88395_DATA_TYPE_REG].data != NULL) &&
-			    (sec_desc[AW88395_DATA_TYPE_REG].len != 0) &&
-			    (sec_desc[AW88395_DATA_TYPE_DSP_CFG].data != NULL) &&
-			    (sec_desc[AW88395_DATA_TYPE_DSP_CFG].len != 0) &&
-			    (sec_desc[AW88395_DATA_TYPE_DSP_FW].data != NULL) &&
-			    (sec_desc[AW88395_DATA_TYPE_DSP_FW].len != 0)) {
+			if ((sec_desc[AW_DATA_TYPE_REG].data != NULL) &&
+			    (sec_desc[AW_DATA_TYPE_REG].len != 0) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_CFG].data != NULL) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_CFG].len != 0) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_FW].data != NULL) &&
+			    (sec_desc[AW_DATA_TYPE_DSP_FW].len != 0)) {
 				if (num >= prof_info->count) {
 					dev_err(aw_dev->dev, "overflow count[%d]",
 							prof_info->count);
@@ -673,7 +675,7 @@ static int aw_dev_load_cfg_by_hdr(struct aw_device *aw_dev,
 	ret = aw_dev_parse_dev_type(aw_dev, prof_hdr, all_prof_info);
 	if (ret < 0) {
 		return ret;
-	} else if (ret == AW88395_DEV_TYPE_NONE) {
+	} else if (ret == AW_DEV_TYPE_NONE) {
 		dev_dbg(aw_dev->dev, "get dev type num is 0, parse default dev");
 		ret = aw_dev_parse_dev_default_type(aw_dev, prof_hdr, all_prof_info);
 		if (ret < 0)
@@ -734,17 +736,17 @@ static int aw_get_dde_type_info(struct aw_device *aw_dev, struct aw_container *a
 	unsigned int i;
 
 	for (i = 0; i < cfg_hdr->ddt_num; i++) {
-		if (cfg_dde[i].type == AW88395_DEV_TYPE_ID)
+		if (cfg_dde[i].type == AW_DEV_TYPE_ID)
 			dev_num++;
 
-		if (cfg_dde[i].type == AW88395_DEV_DEFAULT_TYPE_ID)
+		if (cfg_dde[i].type == AW_DEV_DEFAULT_TYPE_ID)
 			default_num++;
 	}
 
 	if (dev_num != 0) {
-		aw_dev->prof_info.prof_type = AW88395_DEV_TYPE_ID;
+		aw_dev->prof_info.prof_type = AW_DEV_TYPE_ID;
 	} else if (default_num != 0) {
-		aw_dev->prof_info.prof_type = AW88395_DEV_DEFAULT_TYPE_ID;
+		aw_dev->prof_info.prof_type = AW_DEV_DEFAULT_TYPE_ID;
 	} else {
 		dev_err(aw_dev->dev, "can't find scene");
 		return -EINVAL;
@@ -817,10 +819,10 @@ static int aw_dev_parse_scene_count_v1(struct aw_device *aw_dev,
 		return ret;
 
 	switch (aw_dev->prof_info.prof_type) {
-	case AW88395_DEV_TYPE_ID:
+	case AW_DEV_TYPE_ID:
 		ret = aw_get_dev_scene_count_v1(aw_dev, aw_cfg, count);
 		break;
-	case AW88395_DEV_DEFAULT_TYPE_ID:
+	case AW_DEV_DEFAULT_TYPE_ID:
 		ret = aw_get_default_scene_count_v1(aw_dev, aw_cfg, count);
 		break;
 	default:
@@ -937,10 +939,10 @@ static int aw_dev_parse_by_hdr_v1(struct aw_device *aw_dev,
 	int ret;
 
 	switch (aw_dev->prof_info.prof_type) {
-	case AW88395_DEV_TYPE_ID:
+	case AW_DEV_TYPE_ID:
 		ret = aw_dev_parse_dev_type_v1(aw_dev, cfg_hdr);
 		break;
-	case AW88395_DEV_DEFAULT_TYPE_ID:
+	case AW_DEV_DEFAULT_TYPE_ID:
 		ret = aw_dev_parse_default_type_v1(aw_dev, cfg_hdr);
 		break;
 	default:
@@ -987,7 +989,7 @@ static int aw_dev_load_cfg_by_hdr_v1(struct aw_device *aw_dev,
 	return 0;
 }
 
-int aw88395_dev_cfg_load(struct aw_device *aw_dev, struct aw_container *aw_cfg)
+int aw_dev_cfg_load(struct aw_device *aw_dev, struct aw_container *aw_cfg)
 {
 	struct aw_cfg_hdr *cfg_hdr;
 	int ret;
@@ -995,7 +997,7 @@ int aw88395_dev_cfg_load(struct aw_device *aw_dev, struct aw_container *aw_cfg)
 	cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
 
 	switch (cfg_hdr->hdr_version) {
-	case AW88395_CFG_HDR_VER:
+	case AW_CFG_HDR_VER:
 		ret = aw_dev_load_cfg_by_hdr(aw_dev, cfg_hdr);
 		if (ret < 0) {
 			dev_err(aw_dev->dev, "hdr_version[0x%x] parse failed",
@@ -1003,7 +1005,7 @@ int aw88395_dev_cfg_load(struct aw_device *aw_dev, struct aw_container *aw_cfg)
 			return ret;
 		}
 		break;
-	case AW88395_CFG_HDR_VER_V1:
+	case AW_CFG_HDR_VER_V1:
 		ret = aw_dev_load_cfg_by_hdr_v1(aw_dev, aw_cfg);
 		if (ret < 0) {
 			dev_err(aw_dev->dev, "hdr_version[0x%x] parse failed",
@@ -1015,11 +1017,11 @@ int aw88395_dev_cfg_load(struct aw_device *aw_dev, struct aw_container *aw_cfg)
 		dev_err(aw_dev->dev, "unsupported hdr_version [0x%x]", cfg_hdr->hdr_version);
 		return -EINVAL;
 	}
-	aw_dev->fw_status = AW88395_DEV_FW_OK;
+	aw_dev->fw_status = AW_DEV_FW_OK;
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(aw88395_dev_cfg_load);
+EXPORT_SYMBOL_GPL(aw_dev_cfg_load);
 
 static int aw_dev_check_cfg_by_hdr(struct aw_device *aw_dev, struct aw_container *aw_cfg)
 {
@@ -1138,7 +1140,7 @@ static int aw_dev_check_acf_by_hdr_v1(struct aw_device *aw_dev, struct aw_contai
 	return 0;
 }
 
-int aw88395_dev_load_acf_check(struct aw_device *aw_dev, struct aw_container *aw_cfg)
+int aw_dev_load_acf_check(struct aw_device *aw_dev, struct aw_container *aw_cfg)
 {
 	struct aw_cfg_hdr *cfg_hdr;
 
@@ -1153,13 +1155,13 @@ int aw88395_dev_load_acf_check(struct aw_device *aw_dev, struct aw_container *aw
 		return -EINVAL;
 	}
 
-	crc8_populate_lsb(aw_crc8_table, AW88395_CRC8_POLYNOMIAL);
+	crc8_populate_lsb(aw_crc8_table, AW_CRC8_POLYNOMIAL);
 
 	cfg_hdr = (struct aw_cfg_hdr *)aw_cfg->data;
 	switch (cfg_hdr->hdr_version) {
-	case AW88395_CFG_HDR_VER:
+	case AW_CFG_HDR_VER:
 		return aw_dev_check_cfg_by_hdr(aw_dev, aw_cfg);
-	case AW88395_CFG_HDR_VER_V1:
+	case AW_CFG_HDR_VER_V1:
 		return aw_dev_check_acf_by_hdr_v1(aw_dev, aw_cfg);
 	default:
 		dev_err(aw_dev->dev, "unsupported hdr_version [0x%x]", cfg_hdr->hdr_version);
@@ -1168,7 +1170,7 @@ int aw88395_dev_load_acf_check(struct aw_device *aw_dev, struct aw_container *aw
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(aw88395_dev_load_acf_check);
+EXPORT_SYMBOL_GPL(aw_dev_load_acf_check);
 
-MODULE_DESCRIPTION("AW88395 ACF File Parsing Lib");
+MODULE_DESCRIPTION("awinic firmware lib");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/aw-common-firmware.h b/sound/soc/codecs/aw-common-firmware.h
new file mode 100644
index 000000000000..e6722a4448a2
--- /dev/null
+++ b/sound/soc/codecs/aw-common-firmware.h
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw-common-firmware.h --  awinic amp common firmware interface
+//
+// Copyright (c) 2025 AWINIC Technology CO., LTD
+//
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#ifndef __AW_COMMON_FIRMWARE_H__
+#define __AW_COMMON_FIRMWARE_H__
+
+#include "aw-common-device.h"
+
+#define CHECK_REGISTER_NUM_OFFSET	(4)
+#define VALID_DATA_LEN			(4)
+#define VALID_DATA_ADDR		(4)
+#define PARSE_DSP_REG_NUM		(4)
+#define REG_DATA_BYTP_LEN		(8)
+#define CHECK_DSP_REG_NUM		(12)
+#define DSP_VALID_DATA_LEN		(12)
+#define DSP_VALID_DATA_ADDR		(12)
+#define PARSE_SOC_APP_NUM		(8)
+#define CHECK_SOC_APP_NUM		(12)
+#define APP_DOWNLOAD_ADDR		(4)
+#define APP_VALID_DATA_LEN		(12)
+#define APP_VALID_DATA_ADDR		(12)
+#define BIN_NUM_MAX			(100)
+#define HEADER_LEN			(60)
+#define BIN_DATA_TYPE_OFFSET		(8)
+#define DATA_LEN			(44)
+#define VALID_DATA_ADDR_OFFSET		(60)
+#define START_ADDR_OFFSET		(64)
+
+#define HDADER_LEN			(60)
+
+#define HEADER_VERSION_OFFSET		(4)
+
+#define PROJECT_NAME_MAX		(24)
+#define CUSTOMER_NAME_MAX		(16)
+#define CFG_VERSION_MAX		(4)
+#define DEV_NAME_MAX			(16)
+#define PROFILE_STR_MAX		(32)
+
+#define ACF_FILE_ID			(0xa15f908)
+
+enum bin_header_version_enum {
+	HEADER_VERSION_V1 = 0x01000000,
+};
+
+enum data_type_enum {
+	DATA_TYPE_REGISTER   = 0x00000000,
+	DATA_TYPE_DSP_REG    = 0x00000010,
+	DATA_TYPE_DSP_CFG    = 0x00000011,
+	DATA_TYPE_SOC_REG    = 0x00000020,
+	DATA_TYPE_SOC_APP    = 0x00000021,
+	DATA_TYPE_DSP_FW     = 0x00000022,
+	DATA_TYPE_MULTI_BINS = 0x00002000,
+};
+
+enum data_version_enum {
+	DATA_VERSION_V1 = 0x00000001,
+	DATA_VERSION_MAX,
+};
+
+enum aw_sec_type {
+	ACF_SEC_TYPE_REG = 0,
+	ACF_SEC_TYPE_DSP,
+	ACF_SEC_TYPE_DSP_CFG,
+	ACF_SEC_TYPE_DSP_FW,
+	ACF_SEC_TYPE_HDR_REG,
+	ACF_SEC_TYPE_HDR_DSP_CFG,
+	ACF_SEC_TYPE_HDR_DSP_FW,
+	ACF_SEC_TYPE_MULTIPLE_BIN,
+	ACF_SEC_TYPE_SKT_PROJECT,
+	ACF_SEC_TYPE_DSP_PROJECT,
+	ACF_SEC_TYPE_MONITOR,
+	ACF_SEC_TYPE_MAX,
+};
+
+enum aw_prof_type {
+	AW_PROFILE_MUSIC = 0,
+	AW_PROFILE_VOICE,
+	AW_PROFILE_VOIP,
+	AW_PROFILE_RINGTONE,
+	AW_PROFILE_RINGTONE_HS,
+	AW_PROFILE_LOWPOWER,
+	AW_PROFILE_BYPASS,
+	AW_PROFILE_MMI,
+	AW_PROFILE_FM,
+	AW_PROFILE_NOTIFICATION,
+	AW_PROFILE_RECEIVER,
+	AW_PROFILE_MAX,
+};
+
+enum profile_data_type {
+	AW_DATA_TYPE_REG = 0,
+	AW_DATA_TYPE_DSP_CFG,
+	AW_DATA_TYPE_DSP_FW,
+	AW_DATA_TYPE_MAX,
+};
+
+enum {
+	AW_DEV_TYPE_OK = 0,
+	AW_DEV_TYPE_NONE = 1,
+};
+
+enum aw_cfg_dde_type {
+	AW_DEV_NONE_TYPE_ID	= 0xFFFFFFFF,
+	AW_DEV_TYPE_ID		= 0x00000000,
+	AW_SKT_TYPE_ID		= 0x00000001,
+	AW_DEV_DEFAULT_TYPE_ID	= 0x00000002,
+};
+
+enum aw_profile_status {
+	AW_PROFILE_WAIT = 0,
+	AW_PROFILE_OK,
+};
+
+enum aw_cfg_hdr_version {
+	AW_CFG_HDR_VER = 0x00000001,
+	AW_CFG_HDR_VER_V1 = 0x01000000,
+};
+
+struct aw_cfg_hdr {
+	u32 id;
+	char project[PROJECT_NAME_MAX];
+	char custom[CUSTOMER_NAME_MAX];
+	char version[CFG_VERSION_MAX];
+	u32 author_id;
+	u32 ddt_size;
+	u32 ddt_num;
+	u32 hdr_offset;
+	u32 hdr_version;
+	u32 reserved[3];
+};
+
+struct aw_cfg_dde {
+	u32 type;
+	char dev_name[DEV_NAME_MAX];
+	u16 dev_index;
+	u16 dev_bus;
+	u16 dev_addr;
+	u16 dev_profile;
+	u32 data_type;
+	u32 data_size;
+	u32 data_offset;
+	u32 data_crc;
+	u32 reserved[5];
+};
+
+struct aw_cfg_dde_v1 {
+	u32 type;
+	char dev_name[DEV_NAME_MAX];
+	u16 dev_index;
+	u16 dev_bus;
+	u16 dev_addr;
+	u16 dev_profile;
+	u32 data_type;
+	u32 data_size;
+	u32 data_offset;
+	u32 data_crc;
+	char dev_profile_str[PROFILE_STR_MAX];
+	u32 chip_id;
+	u32 reserved[4];
+};
+
+struct bin_header_info {
+	unsigned int check_sum;
+	unsigned int header_ver;
+	unsigned int bin_data_type;
+	unsigned int bin_data_ver;
+	unsigned int bin_data_len;
+	unsigned int ui_ver;
+	unsigned char chip_type[8];
+	unsigned int reg_byte_len;
+	unsigned int data_byte_len;
+	unsigned int device_addr;
+	unsigned int valid_data_len;
+	unsigned int valid_data_addr;
+
+	unsigned int reg_num;
+	unsigned int reg_data_byte_len;
+	unsigned int download_addr;
+	unsigned int app_version;
+	unsigned int header_len;
+};
+
+struct aw_container {
+	int len;
+	u8 data[];
+};
+
+struct bin_container {
+	unsigned int len;
+	unsigned char data[];
+};
+
+struct aw_bin {
+	unsigned char *p_addr;
+	unsigned int all_bin_parse_num;
+	unsigned int multi_bin_parse_num;
+	unsigned int single_bin_parse_num;
+	struct bin_header_info header_info[BIN_NUM_MAX];
+	struct bin_container info;
+};
+
+int aw_dev_load_acf_check(struct aw_device *aw_dev, struct aw_container *aw_cfg);
+int aw_dev_cfg_load(struct aw_device *aw_dev, struct aw_container *aw_cfg);
+
+#endif
diff --git a/sound/soc/codecs/aw88395/aw88395_data_type.h b/sound/soc/codecs/aw88395/aw88395_data_type.h
deleted file mode 100644
index e7aa56178b36..000000000000
--- a/sound/soc/codecs/aw88395/aw88395_data_type.h
+++ /dev/null
@@ -1,142 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-//
-// aw883_data_type.h --  The data type of the AW88395 chip
-//
-// Copyright (c) 2022-2023 AWINIC Technology CO., LTD
-//
-// Author: Bruce zhao <zhaolei@awinic.com>
-//
-
-#ifndef __AW88395_DATA_TYPE_H__
-#define __AW88395_DATA_TYPE_H__
-
-#define PROJECT_NAME_MAX		(24)
-#define CUSTOMER_NAME_MAX		(16)
-#define CFG_VERSION_MAX		(4)
-#define DEV_NAME_MAX			(16)
-#define PROFILE_STR_MAX		(32)
-
-#define ACF_FILE_ID			(0xa15f908)
-
-enum aw_cfg_hdr_version {
-	AW88395_CFG_HDR_VER	= 0x00000001,
-	AW88395_CFG_HDR_VER_V1	= 0x01000000,
-};
-
-enum aw_cfg_dde_type {
-	AW88395_DEV_NONE_TYPE_ID	= 0xFFFFFFFF,
-	AW88395_DEV_TYPE_ID		= 0x00000000,
-	AW88395_SKT_TYPE_ID		= 0x00000001,
-	AW88395_DEV_DEFAULT_TYPE_ID	= 0x00000002,
-};
-
-enum aw_sec_type {
-	ACF_SEC_TYPE_REG = 0,
-	ACF_SEC_TYPE_DSP,
-	ACF_SEC_TYPE_DSP_CFG,
-	ACF_SEC_TYPE_DSP_FW,
-	ACF_SEC_TYPE_HDR_REG,
-	ACF_SEC_TYPE_HDR_DSP_CFG,
-	ACF_SEC_TYPE_HDR_DSP_FW,
-	ACF_SEC_TYPE_MULTIPLE_BIN,
-	ACF_SEC_TYPE_SKT_PROJECT,
-	ACF_SEC_TYPE_DSP_PROJECT,
-	ACF_SEC_TYPE_MONITOR,
-	ACF_SEC_TYPE_MAX,
-};
-
-enum profile_data_type {
-	AW88395_DATA_TYPE_REG = 0,
-	AW88395_DATA_TYPE_DSP_CFG,
-	AW88395_DATA_TYPE_DSP_FW,
-	AW88395_DATA_TYPE_MAX,
-};
-
-enum aw_prof_type {
-	AW88395_PROFILE_MUSIC = 0,
-	AW88395_PROFILE_VOICE,
-	AW88395_PROFILE_VOIP,
-	AW88395_PROFILE_RINGTONE,
-	AW88395_PROFILE_RINGTONE_HS,
-	AW88395_PROFILE_LOWPOWER,
-	AW88395_PROFILE_BYPASS,
-	AW88395_PROFILE_MMI,
-	AW88395_PROFILE_FM,
-	AW88395_PROFILE_NOTIFICATION,
-	AW88395_PROFILE_RECEIVER,
-	AW88395_PROFILE_MAX,
-};
-
-enum aw_profile_status {
-	AW88395_PROFILE_WAIT = 0,
-	AW88395_PROFILE_OK,
-};
-
-struct aw_cfg_hdr {
-	u32 id;
-	char project[PROJECT_NAME_MAX];
-	char custom[CUSTOMER_NAME_MAX];
-	char version[CFG_VERSION_MAX];
-	u32 author_id;
-	u32 ddt_size;
-	u32 ddt_num;
-	u32 hdr_offset;
-	u32 hdr_version;
-	u32 reserved[3];
-};
-
-struct aw_cfg_dde {
-	u32 type;
-	char dev_name[DEV_NAME_MAX];
-	u16 dev_index;
-	u16 dev_bus;
-	u16 dev_addr;
-	u16 dev_profile;
-	u32 data_type;
-	u32 data_size;
-	u32 data_offset;
-	u32 data_crc;
-	u32 reserved[5];
-};
-
-struct aw_cfg_dde_v1 {
-	u32 type;
-	char dev_name[DEV_NAME_MAX];
-	u16 dev_index;
-	u16 dev_bus;
-	u16 dev_addr;
-	u16 dev_profile;
-	u32 data_type;
-	u32 data_size;
-	u32 data_offset;
-	u32 data_crc;
-	char dev_profile_str[PROFILE_STR_MAX];
-	u32 chip_id;
-	u32 reserved[4];
-};
-
-struct aw_sec_data_desc {
-	u32 len;
-	u8 *data;
-};
-
-struct aw_prof_desc {
-	u32 id;
-	u32 prof_st;
-	char *prf_str;
-	u32 fw_ver;
-	struct aw_sec_data_desc sec_desc[AW88395_DATA_TYPE_MAX];
-};
-
-struct aw_all_prof_info {
-	struct aw_prof_desc prof_desc[AW88395_PROFILE_MAX];
-};
-
-struct aw_prof_info {
-	int count;
-	int prof_type;
-	char **prof_name_list;
-	struct aw_prof_desc *prof_desc;
-};
-
-#endif
diff --git a/sound/soc/codecs/aw88395/aw88395_device.c b/sound/soc/codecs/aw88395/aw88395_device.c
deleted file mode 100644
index e1430940015d..000000000000
--- a/sound/soc/codecs/aw88395/aw88395_device.c
+++ /dev/null
@@ -1,1720 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-//
-// aw88395_device.c --  AW88395 function for ALSA Audio Driver
-//
-// Copyright (c) 2022-2023 AWINIC Technology CO., LTD
-//
-// Author: Bruce zhao <zhaolei@awinic.com>
-// Author: Ben Yi <yijiangtao@awinic.com>
-//
-
-#include <linux/crc32.h>
-#include <linux/i2c.h>
-#include <linux/minmax.h>
-#include <linux/regmap.h>
-#include "aw88395_device.h"
-#include "aw88395_reg.h"
-
-static int aw_dev_dsp_write_16bit(struct aw_device *aw_dev,
-		unsigned short dsp_addr, unsigned int dsp_data)
-{
-	int ret;
-
-	ret = regmap_write(aw_dev->regmap, AW88395_DSPMADD_REG, dsp_addr);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write addr error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	ret = regmap_write(aw_dev->regmap, AW88395_DSPMDAT_REG, (u16)dsp_data);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write data error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int aw_dev_dsp_write_32bit(struct aw_device *aw_dev,
-		unsigned short dsp_addr, unsigned int dsp_data)
-{
-	u16 temp_data;
-	int ret;
-
-	ret = regmap_write(aw_dev->regmap, AW88395_DSPMADD_REG, dsp_addr);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write addr error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	temp_data = dsp_data & AW88395_DSP_16_DATA_MASK;
-	ret = regmap_write(aw_dev->regmap, AW88395_DSPMDAT_REG, (u16)temp_data);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write datal error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	temp_data = dsp_data >> 16;
-	ret = regmap_write(aw_dev->regmap, AW88395_DSPMDAT_REG, (u16)temp_data);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write datah error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int aw_dev_dsp_write(struct aw_device *aw_dev,
-		unsigned short dsp_addr, unsigned int dsp_data, unsigned char data_type)
-{
-	u32 reg_value;
-	int ret;
-
-	mutex_lock(&aw_dev->dsp_lock);
-	switch (data_type) {
-	case AW88395_DSP_16_DATA:
-		ret = aw_dev_dsp_write_16bit(aw_dev, dsp_addr, dsp_data);
-		if (ret)
-			dev_err(aw_dev->dev, "write dsp_addr[0x%x] 16-bit dsp_data[0x%x] failed",
-					(u32)dsp_addr, dsp_data);
-		break;
-	case AW88395_DSP_32_DATA:
-		ret = aw_dev_dsp_write_32bit(aw_dev, dsp_addr, dsp_data);
-		if (ret)
-			dev_err(aw_dev->dev, "write dsp_addr[0x%x] 32-bit dsp_data[0x%x] failed",
-					(u32)dsp_addr, dsp_data);
-		break;
-	default:
-		dev_err(aw_dev->dev, "data type[%d] unsupported", data_type);
-		ret = -EINVAL;
-		break;
-	}
-
-	/* clear dsp chip select state*/
-	if (regmap_read(aw_dev->regmap, AW88395_ID_REG, &reg_value))
-		dev_err(aw_dev->dev, "%s fail to clear chip state. Err=%d\n", __func__, ret);
-	mutex_unlock(&aw_dev->dsp_lock);
-
-	return ret;
-}
-
-static int aw_dev_dsp_read_16bit(struct aw_device *aw_dev,
-		unsigned short dsp_addr, unsigned int *dsp_data)
-{
-	unsigned int temp_data;
-	int ret;
-
-	ret = regmap_write(aw_dev->regmap, AW88395_DSPMADD_REG, dsp_addr);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	ret = regmap_read(aw_dev->regmap, AW88395_DSPMDAT_REG, &temp_data);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
-		return ret;
-	}
-	*dsp_data = temp_data;
-
-	return 0;
-}
-
-static int aw_dev_dsp_read_32bit(struct aw_device *aw_dev,
-		unsigned short dsp_addr, unsigned int *dsp_data)
-{
-	unsigned int temp_data;
-	int ret;
-
-	ret = regmap_write(aw_dev->regmap, AW88395_DSPMADD_REG, dsp_addr);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	ret = regmap_read(aw_dev->regmap, AW88395_DSPMDAT_REG, &temp_data);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
-		return ret;
-	}
-	*dsp_data = temp_data;
-
-	ret = regmap_read(aw_dev->regmap, AW88395_DSPMDAT_REG, &temp_data);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
-		return ret;
-	}
-	*dsp_data |= (temp_data << 16);
-
-	return 0;
-}
-
-static int aw_dev_dsp_read(struct aw_device *aw_dev,
-		unsigned short dsp_addr, unsigned int *dsp_data, unsigned char data_type)
-{
-	u32 reg_value;
-	int ret;
-
-	mutex_lock(&aw_dev->dsp_lock);
-	switch (data_type) {
-	case AW88395_DSP_16_DATA:
-		ret = aw_dev_dsp_read_16bit(aw_dev, dsp_addr, dsp_data);
-		if (ret)
-			dev_err(aw_dev->dev, "read dsp_addr[0x%x] 16-bit dsp_data[0x%x] failed",
-					(u32)dsp_addr, *dsp_data);
-		break;
-	case AW88395_DSP_32_DATA:
-		ret = aw_dev_dsp_read_32bit(aw_dev, dsp_addr, dsp_data);
-		if (ret)
-			dev_err(aw_dev->dev, "read dsp_addr[0x%x] 32r-bit dsp_data[0x%x] failed",
-					(u32)dsp_addr, *dsp_data);
-		break;
-	default:
-		dev_err(aw_dev->dev, "data type[%d] unsupported", data_type);
-		ret = -EINVAL;
-		break;
-	}
-
-	/* clear dsp chip select state*/
-	if (regmap_read(aw_dev->regmap, AW88395_ID_REG, &reg_value))
-		dev_err(aw_dev->dev, "%s fail to clear chip state. Err=%d\n", __func__, ret);
-	mutex_unlock(&aw_dev->dsp_lock);
-
-	return ret;
-}
-
-
-static int aw_dev_read_chipid(struct aw_device *aw_dev, u16 *chip_id)
-{
-	int reg_val;
-	int ret;
-
-	ret = regmap_read(aw_dev->regmap, AW88395_CHIP_ID_REG, &reg_val);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s read chipid error. ret = %d", __func__, ret);
-		return ret;
-	}
-
-	dev_info(aw_dev->dev, "chip id = %x\n", reg_val);
-	*chip_id = reg_val;
-
-	return 0;
-}
-
-static unsigned int reg_val_to_db(unsigned int value)
-{
-	return (((value >> AW88395_VOL_6DB_START) * AW88395_VOLUME_STEP_DB) +
-			((value & 0x3f) % AW88395_VOLUME_STEP_DB));
-}
-
-static unsigned short db_to_reg_val(unsigned short value)
-{
-	return (((value / AW88395_VOLUME_STEP_DB) << AW88395_VOL_6DB_START) +
-			(value % AW88395_VOLUME_STEP_DB));
-}
-
-static int aw_dev_dsp_fw_check(struct aw_device *aw_dev)
-{
-	struct aw_sec_data_desc *dsp_fw_desc;
-	struct aw_prof_desc *set_prof_desc;
-	u16 base_addr = AW88395_DSP_FW_ADDR;
-	u16 addr = base_addr;
-	u32 dsp_val;
-	u16 bin_val;
-	int ret, i;
-
-	ret = aw88395_dev_get_prof_data(aw_dev, aw_dev->prof_cur, &set_prof_desc);
-	if (ret)
-		return ret;
-
-	/* update reg */
-	dsp_fw_desc = &set_prof_desc->sec_desc[AW88395_DATA_TYPE_DSP_FW];
-
-	for (i = 0; i < AW88395_FW_CHECK_PART; i++) {
-		ret = aw_dev_dsp_read(aw_dev, addr, &dsp_val, AW88395_DSP_16_DATA);
-		if (ret) {
-			dev_err(aw_dev->dev, "dsp read failed");
-			return ret;
-		}
-
-		bin_val = be16_to_cpup((void *)&dsp_fw_desc->data[2 * (addr - base_addr)]);
-
-		if (dsp_val != bin_val) {
-			dev_err(aw_dev->dev, "fw check failed, addr[0x%x], read[0x%x] != bindata[0x%x]",
-					addr, dsp_val, bin_val);
-			return -EINVAL;
-		}
-
-		addr += (dsp_fw_desc->len / 2) / AW88395_FW_CHECK_PART;
-		if ((addr - base_addr) > dsp_fw_desc->len) {
-			dev_err(aw_dev->dev, "fw check failed, addr[0x%x] too large", addr);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
-static int aw_dev_set_volume(struct aw_device *aw_dev, unsigned int value)
-{
-	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
-	unsigned int reg_value;
-	u16 real_value, volume;
-	int ret;
-
-	volume = min((value + vol_desc->init_volume), (unsigned int)AW88395_MUTE_VOL);
-	real_value = db_to_reg_val(volume);
-
-	/* cal real value */
-	ret = regmap_read(aw_dev->regmap, AW88395_SYSCTRL2_REG, &reg_value);
-	if (ret)
-		return ret;
-
-	dev_dbg(aw_dev->dev, "value 0x%x , reg:0x%x", value, real_value);
-
-	/* [15 : 6] volume */
-	real_value = (real_value << AW88395_VOL_START_BIT) | (reg_value & AW88395_VOL_MASK);
-
-	/* write value */
-	ret = regmap_write(aw_dev->regmap, AW88395_SYSCTRL2_REG, real_value);
-
-	return ret;
-}
-
-void aw88395_dev_set_volume(struct aw_device *aw_dev, unsigned short set_vol)
-{
-	int ret;
-
-	ret = aw_dev_set_volume(aw_dev, set_vol);
-	if (ret)
-		dev_dbg(aw_dev->dev, "set volume failed");
-}
-EXPORT_SYMBOL_GPL(aw88395_dev_set_volume);
-
-static void aw_dev_fade_in(struct aw_device *aw_dev)
-{
-	struct aw_volume_desc *desc = &aw_dev->volume_desc;
-	u16 fade_in_vol = desc->ctl_volume;
-	int fade_step = aw_dev->fade_step;
-	int i;
-
-	if (fade_step == 0 || aw_dev->fade_in_time == 0) {
-		aw_dev_set_volume(aw_dev, fade_in_vol);
-		return;
-	}
-
-	for (i = AW88395_MUTE_VOL; i >= fade_in_vol; i -= fade_step) {
-		aw_dev_set_volume(aw_dev, i);
-		usleep_range(aw_dev->fade_in_time, aw_dev->fade_in_time + 10);
-	}
-
-	if (i != fade_in_vol)
-		aw_dev_set_volume(aw_dev, fade_in_vol);
-}
-
-static void aw_dev_fade_out(struct aw_device *aw_dev)
-{
-	struct aw_volume_desc *desc = &aw_dev->volume_desc;
-	int fade_step = aw_dev->fade_step;
-	int i;
-
-	if (fade_step == 0 || aw_dev->fade_out_time == 0) {
-		aw_dev_set_volume(aw_dev, AW88395_MUTE_VOL);
-		return;
-	}
-
-	for (i = desc->ctl_volume; i <= AW88395_MUTE_VOL; i += fade_step) {
-		aw_dev_set_volume(aw_dev, i);
-		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
-	}
-
-	if (i != AW88395_MUTE_VOL) {
-		aw_dev_set_volume(aw_dev, AW88395_MUTE_VOL);
-		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
-	}
-}
-
-static int aw_dev_modify_dsp_cfg(struct aw_device *aw_dev,
-			unsigned int addr, unsigned int dsp_data, unsigned char data_type)
-{
-	struct aw_sec_data_desc *crc_dsp_cfg = &aw_dev->crc_dsp_cfg;
-	unsigned int addr_offset;
-	__le16 data1;
-	__le32 data2;
-
-	dev_dbg(aw_dev->dev, "addr:0x%x, dsp_data:0x%x", addr, dsp_data);
-
-	addr_offset = (addr - AW88395_DSP_CFG_ADDR) * 2;
-	if (addr_offset > crc_dsp_cfg->len) {
-		dev_err(aw_dev->dev, "addr_offset[%d] > crc_dsp_cfg->len[%d]",
-				addr_offset, crc_dsp_cfg->len);
-		return -EINVAL;
-	}
-	switch (data_type) {
-	case AW88395_DSP_16_DATA:
-		data1 = cpu_to_le16((u16)dsp_data);
-		memcpy(crc_dsp_cfg->data + addr_offset, (u8 *)&data1, 2);
-		break;
-	case AW88395_DSP_32_DATA:
-		data2 = cpu_to_le32(dsp_data);
-		memcpy(crc_dsp_cfg->data + addr_offset, (u8 *)&data2, 4);
-		break;
-	default:
-		dev_err(aw_dev->dev, "data type[%d] unsupported", data_type);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int aw_dev_dsp_set_cali_re(struct aw_device *aw_dev)
-{
-	u32 cali_re;
-	int ret;
-
-	cali_re = AW88395_SHOW_RE_TO_DSP_RE((aw_dev->cali_desc.cali_re +
-		aw_dev->cali_desc.ra), AW88395_DSP_RE_SHIFT);
-
-	/* set cali re to device */
-	ret = aw_dev_dsp_write(aw_dev,
-			AW88395_DSP_REG_CFG_ADPZ_RE, cali_re, AW88395_DSP_32_DATA);
-	if (ret) {
-		dev_err(aw_dev->dev, "set cali re error");
-		return ret;
-	}
-
-	ret = aw_dev_modify_dsp_cfg(aw_dev, AW88395_DSP_REG_CFG_ADPZ_RE,
-				cali_re, AW88395_DSP_32_DATA);
-	if (ret)
-		dev_err(aw_dev->dev, "modify dsp cfg failed");
-
-	return ret;
-}
-
-static void aw_dev_i2s_tx_enable(struct aw_device *aw_dev, bool flag)
-{
-	int ret;
-
-	if (flag) {
-		ret = regmap_update_bits(aw_dev->regmap, AW88395_I2SCFG1_REG,
-			~AW88395_I2STXEN_MASK, AW88395_I2STXEN_ENABLE_VALUE);
-	} else {
-		ret = regmap_update_bits(aw_dev->regmap, AW88395_I2SCFG1_REG,
-			~AW88395_I2STXEN_MASK, AW88395_I2STXEN_DISABLE_VALUE);
-	}
-
-	if (ret)
-		dev_dbg(aw_dev->dev, "%s failed", __func__);
-}
-
-static int aw_dev_dsp_set_crc32(struct aw_device *aw_dev)
-{
-	struct aw_sec_data_desc *crc_dsp_cfg = &aw_dev->crc_dsp_cfg;
-	u32 crc_value, crc_data_len;
-
-	/* get crc data len */
-	crc_data_len = (AW88395_DSP_REG_CRC_ADDR - AW88395_DSP_CFG_ADDR) * 2;
-	if (crc_data_len > crc_dsp_cfg->len) {
-		dev_err(aw_dev->dev, "crc data len :%d > cfg_data len:%d",
-			crc_data_len, crc_dsp_cfg->len);
-		return -EINVAL;
-	}
-
-	if (crc_data_len & 0x11) {
-		dev_err(aw_dev->dev, "The crc data len :%d unsupport", crc_data_len);
-		return -EINVAL;
-	}
-
-	crc_value = crc32c(0xFFFFFFFF, crc_dsp_cfg->data, crc_data_len) ^ 0xFFFFFFFF;
-
-	return aw_dev_dsp_write(aw_dev, AW88395_DSP_REG_CRC_ADDR, crc_value,
-						AW88395_DSP_32_DATA);
-}
-
-static void aw_dev_dsp_check_crc_enable(struct aw_device *aw_dev, bool flag)
-{
-	int ret;
-
-	if (flag) {
-		ret = regmap_update_bits(aw_dev->regmap, AW88395_HAGCCFG7_REG,
-			~AW88395_AGC_DSP_CTL_MASK, AW88395_AGC_DSP_CTL_ENABLE_VALUE);
-	} else {
-		ret = regmap_update_bits(aw_dev->regmap, AW88395_HAGCCFG7_REG,
-			~AW88395_AGC_DSP_CTL_MASK, AW88395_AGC_DSP_CTL_DISABLE_VALUE);
-	}
-	if (ret)
-		dev_dbg(aw_dev->dev, "%s failed", __func__);
-}
-
-static int aw_dev_dsp_check_st(struct aw_device *aw_dev)
-{
-	unsigned int reg_val;
-	int ret;
-	int i;
-
-	for (i = 0; i < AW88395_DSP_ST_CHECK_MAX; i++) {
-		ret = regmap_read(aw_dev->regmap, AW88395_SYSST_REG, &reg_val);
-		if (ret) {
-			dev_err(aw_dev->dev, "read reg0x%x failed", AW88395_SYSST_REG);
-			continue;
-		}
-
-		if ((reg_val & (~AW88395_DSPS_MASK)) != AW88395_DSPS_NORMAL_VALUE) {
-			dev_err(aw_dev->dev, "check dsp st fail,reg_val:0x%04x", reg_val);
-			ret = -EPERM;
-			continue;
-		} else {
-			dev_dbg(aw_dev->dev, "dsp st check ok, reg_val:0x%04x", reg_val);
-			return 0;
-		}
-	}
-
-	return ret;
-}
-
-static void aw_dev_dsp_enable(struct aw_device *aw_dev, bool is_enable)
-{
-	int ret;
-
-	if (is_enable) {
-		ret = regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
-					~AW88395_DSPBY_MASK, AW88395_DSPBY_WORKING_VALUE);
-		if (ret)
-			dev_dbg(aw_dev->dev, "enable dsp failed");
-	} else {
-		ret = regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
-					~AW88395_DSPBY_MASK, AW88395_DSPBY_BYPASS_VALUE);
-		if (ret)
-			dev_dbg(aw_dev->dev, "disable dsp failed");
-	}
-}
-
-static int aw_dev_dsp_check_crc32(struct aw_device *aw_dev)
-{
-	int ret;
-
-	if (aw_dev->dsp_cfg == AW88395_DEV_DSP_BYPASS) {
-		dev_info(aw_dev->dev, "dsp bypass");
-		return 0;
-	}
-
-	ret = aw_dev_dsp_set_crc32(aw_dev);
-	if (ret) {
-		dev_err(aw_dev->dev, "set dsp crc32 failed");
-		return ret;
-	}
-
-	aw_dev_dsp_check_crc_enable(aw_dev, true);
-
-	/* dsp enable */
-	aw_dev_dsp_enable(aw_dev, true);
-	usleep_range(AW88395_5000_US, AW88395_5000_US + 100);
-
-	ret = aw_dev_dsp_check_st(aw_dev);
-	if (ret) {
-		dev_err(aw_dev->dev, "check crc32 fail");
-	} else {
-		aw_dev_dsp_check_crc_enable(aw_dev, false);
-		aw_dev->dsp_crc_st = AW88395_DSP_CRC_OK;
-	}
-
-	return ret;
-}
-
-static void aw_dev_pwd(struct aw_device *aw_dev, bool pwd)
-{
-	int ret;
-
-	if (pwd) {
-		ret = regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
-				~AW88395_PWDN_MASK,	AW88395_PWDN_POWER_DOWN_VALUE);
-	} else {
-		ret = regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
-				~AW88395_PWDN_MASK,	AW88395_PWDN_WORKING_VALUE);
-	}
-	if (ret)
-		dev_dbg(aw_dev->dev, "%s failed", __func__);
-}
-
-static void aw_dev_amppd(struct aw_device *aw_dev, bool amppd)
-{
-	int ret;
-
-	if (amppd) {
-		ret = regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
-				~AW88395_AMPPD_MASK, AW88395_AMPPD_POWER_DOWN_VALUE);
-	} else {
-		ret = regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
-				~AW88395_AMPPD_MASK, AW88395_AMPPD_WORKING_VALUE);
-	}
-	if (ret)
-		dev_dbg(aw_dev->dev, "%s failed", __func__);
-}
-
-void aw88395_dev_mute(struct aw_device *aw_dev, bool is_mute)
-{
-	int ret;
-
-	if (is_mute) {
-		aw_dev_fade_out(aw_dev);
-		ret = regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
-				~AW88395_HMUTE_MASK, AW88395_HMUTE_ENABLE_VALUE);
-	} else {
-		ret = regmap_update_bits(aw_dev->regmap, AW88395_SYSCTRL_REG,
-				~AW88395_HMUTE_MASK, AW88395_HMUTE_DISABLE_VALUE);
-		aw_dev_fade_in(aw_dev);
-	}
-
-	if (ret)
-		dev_dbg(aw_dev->dev, "%s failed", __func__);
-}
-EXPORT_SYMBOL_GPL(aw88395_dev_mute);
-
-static int aw_dev_get_icalk(struct aw_device *aw_dev, int16_t *icalk)
-{
-	unsigned int reg_val;
-	u16 reg_icalk;
-	int ret;
-
-	ret = regmap_read(aw_dev->regmap, AW88395_EFRM2_REG, &reg_val);
-	if (ret)
-		return ret;
-
-	reg_icalk = reg_val & (~AW88395_EF_ISN_GESLP_MASK);
-
-	if (reg_icalk & (~AW88395_EF_ISN_GESLP_SIGN_MASK))
-		reg_icalk = reg_icalk | AW88395_EF_ISN_GESLP_SIGN_NEG;
-
-	*icalk = (int16_t)reg_icalk;
-
-	return ret;
-}
-
-static int aw_dev_get_vcalk(struct aw_device *aw_dev, int16_t *vcalk)
-{
-	unsigned int reg_val;
-	u16 reg_vcalk;
-	int ret;
-
-	ret = regmap_read(aw_dev->regmap, AW88395_EFRH_REG, &reg_val);
-	if (ret)
-		return ret;
-
-	reg_val = reg_val >> AW88395_EF_VSENSE_GAIN_SHIFT;
-
-	reg_vcalk = (u16)reg_val & (~AW88395_EF_VSN_GESLP_MASK);
-
-	if (reg_vcalk & (~AW88395_EF_VSN_GESLP_SIGN_MASK))
-		reg_vcalk = reg_vcalk | AW88395_EF_VSN_GESLP_SIGN_NEG;
-
-	*vcalk = (int16_t)reg_vcalk;
-
-	return ret;
-}
-
-static int aw_dev_get_vcalk_dac(struct aw_device *aw_dev, int16_t *vcalk)
-{
-	unsigned int reg_val;
-	u16 reg_vcalk;
-	int ret;
-
-	ret = regmap_read(aw_dev->regmap, AW88395_EFRM2_REG, &reg_val);
-	if (ret)
-		return ret;
-
-	reg_vcalk = reg_val >> AW88395_EF_DAC_GESLP_SHIFT;
-
-	if (reg_vcalk & AW88395_EF_DAC_GESLP_SIGN_MASK)
-		reg_vcalk = reg_vcalk | AW88395_EF_DAC_GESLP_SIGN_NEG;
-
-	*vcalk = (int16_t)reg_vcalk;
-
-	return ret;
-}
-
-static int aw_dev_vsense_select(struct aw_device *aw_dev, int *vsense_select)
-{
-	unsigned int vsense_reg_val;
-	int ret;
-
-	ret = regmap_read(aw_dev->regmap, AW88395_I2SCFG3_REG, &vsense_reg_val);
-	if (ret) {
-		dev_err(aw_dev->dev, "read vsense_reg_val failed");
-		return ret;
-	}
-	dev_dbg(aw_dev->dev, "vsense_reg = 0x%x", vsense_reg_val);
-
-	if (vsense_reg_val & (~AW88395_VDSEL_MASK)) {
-		*vsense_select = AW88395_DEV_VDSEL_VSENSE;
-		dev_dbg(aw_dev->dev, "vsense outside");
-	} else {
-		*vsense_select = AW88395_DEV_VDSEL_DAC;
-		dev_dbg(aw_dev->dev, "vsense inside");
-	}
-
-	return 0;
-}
-
-static int aw_dev_set_vcalb(struct aw_device *aw_dev)
-{
-	int16_t icalk_val, vcalk_val;
-	int icalk, vsense_select;
-	u32 vcalb_adj, reg_val;
-	int vcalb, vcalk;
-	int ret;
-
-	ret = aw_dev_dsp_read(aw_dev, AW88395_DSP_REG_VCALB, &vcalb_adj, AW88395_DSP_16_DATA);
-	if (ret) {
-		dev_err(aw_dev->dev, "read vcalb_adj failed");
-		return ret;
-	}
-
-	ret = aw_dev_vsense_select(aw_dev, &vsense_select);
-	if (ret)
-		return ret;
-	dev_dbg(aw_dev->dev, "vsense_select = %d", vsense_select);
-
-	ret = aw_dev_get_icalk(aw_dev, &icalk_val);
-	if (ret)
-		return ret;
-	icalk = AW88395_CABL_BASE_VALUE + AW88395_ICABLK_FACTOR * icalk_val;
-
-	switch (vsense_select) {
-	case AW88395_DEV_VDSEL_VSENSE:
-		ret = aw_dev_get_vcalk(aw_dev, &vcalk_val);
-		if (ret)
-			return ret;
-		vcalk = AW88395_CABL_BASE_VALUE + AW88395_VCABLK_FACTOR * vcalk_val;
-		vcalb = AW88395_VCAL_FACTOR * AW88395_VSCAL_FACTOR /
-			AW88395_ISCAL_FACTOR * icalk / vcalk * vcalb_adj;
-
-		dev_dbg(aw_dev->dev, "vcalk_factor=%d, vscal_factor=%d, icalk=%d, vcalk=%d",
-				AW88395_VCABLK_FACTOR, AW88395_VSCAL_FACTOR, icalk, vcalk);
-		break;
-	case AW88395_DEV_VDSEL_DAC:
-		ret = aw_dev_get_vcalk_dac(aw_dev, &vcalk_val);
-		if (ret)
-			return ret;
-		vcalk = AW88395_CABL_BASE_VALUE + AW88395_VCABLK_FACTOR_DAC * vcalk_val;
-		vcalb = AW88395_VCAL_FACTOR * AW88395_VSCAL_FACTOR_DAC /
-			AW88395_ISCAL_FACTOR * icalk / vcalk * vcalb_adj;
-
-		dev_dbg(aw_dev->dev, "vcalk_dac_factor=%d, vscal_dac_factor=%d, icalk=%d, vcalk=%d",
-				AW88395_VCABLK_FACTOR_DAC,
-				AW88395_VSCAL_FACTOR_DAC, icalk, vcalk);
-		break;
-	default:
-		dev_err(aw_dev->dev, "unsupported vsense status");
-		return -EINVAL;
-	}
-
-	if ((vcalk == 0) || (AW88395_ISCAL_FACTOR == 0)) {
-		dev_err(aw_dev->dev, "vcalk:%d or desc->iscal_factor:%d unsupported",
-			vcalk, AW88395_ISCAL_FACTOR);
-		return -EINVAL;
-	}
-
-	vcalb = vcalb >> AW88395_VCALB_ADJ_FACTOR;
-	reg_val = (u32)vcalb;
-
-	dev_dbg(aw_dev->dev, "vcalb=%d, reg_val=0x%x, vcalb_adj =0x%x",
-				vcalb, reg_val, vcalb_adj);
-
-	ret = aw_dev_dsp_write(aw_dev, AW88395_DSP_REG_VCALB, reg_val, AW88395_DSP_16_DATA);
-	if (ret) {
-		dev_err(aw_dev->dev, "write vcalb failed");
-		return ret;
-	}
-
-	ret = aw_dev_modify_dsp_cfg(aw_dev, AW88395_DSP_REG_VCALB,
-					(u32)reg_val, AW88395_DSP_16_DATA);
-	if (ret)
-		dev_err(aw_dev->dev, "modify dsp cfg failed");
-
-	return ret;
-}
-
-static int aw_dev_get_cali_f0_delay(struct aw_device *aw_dev)
-{
-	struct aw_cali_delay_desc *desc = &aw_dev->cali_delay_desc;
-	u32 cali_delay;
-	int ret;
-
-	ret = aw_dev_dsp_read(aw_dev,
-			AW88395_DSP_CALI_F0_DELAY, &cali_delay, AW88395_DSP_16_DATA);
-	if (ret)
-		dev_err(aw_dev->dev, "read cali delay failed, ret=%d", ret);
-	else
-		desc->delay = AW88395_CALI_DELAY_CACL(cali_delay);
-
-	dev_dbg(aw_dev->dev, "read cali delay: %d ms", desc->delay);
-
-	return ret;
-}
-
-static void aw_dev_get_int_status(struct aw_device *aw_dev, unsigned short *int_status)
-{
-	unsigned int reg_val;
-	int ret;
-
-	ret = regmap_read(aw_dev->regmap, AW88395_SYSINT_REG, &reg_val);
-	if (ret)
-		dev_err(aw_dev->dev, "read interrupt reg fail, ret=%d", ret);
-	else
-		*int_status = reg_val;
-
-	dev_dbg(aw_dev->dev, "read interrupt reg = 0x%04x", *int_status);
-}
-
-static void aw_dev_clear_int_status(struct aw_device *aw_dev)
-{
-	u16 int_status;
-
-	/* read int status and clear */
-	aw_dev_get_int_status(aw_dev, &int_status);
-	/* make sure int status is clear */
-	aw_dev_get_int_status(aw_dev, &int_status);
-	if (int_status)
-		dev_info(aw_dev->dev, "int status(%d) is not cleaned.\n", int_status);
-}
-
-static int aw_dev_get_iis_status(struct aw_device *aw_dev)
-{
-	unsigned int reg_val;
-	int ret;
-
-	ret = regmap_read(aw_dev->regmap, AW88395_SYSST_REG, &reg_val);
-	if (ret)
-		return -EIO;
-	if ((reg_val & AW88395_BIT_PLL_CHECK) != AW88395_BIT_PLL_CHECK) {
-		dev_err(aw_dev->dev, "check pll lock fail,reg_val:0x%04x", reg_val);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int aw_dev_check_mode1_pll(struct aw_device *aw_dev)
-{
-	int ret, i;
-
-	for (i = 0; i < AW88395_DEV_SYSST_CHECK_MAX; i++) {
-		ret = aw_dev_get_iis_status(aw_dev);
-		if (ret < 0) {
-			dev_err(aw_dev->dev, "mode1 iis signal check error");
-			usleep_range(AW88395_2000_US, AW88395_2000_US + 10);
-		} else {
-			return 0;
-		}
-	}
-
-	return -EPERM;
-}
-
-static int aw_dev_check_mode2_pll(struct aw_device *aw_dev)
-{
-	unsigned int reg_val;
-	int ret, i;
-
-	ret = regmap_read(aw_dev->regmap, AW88395_PLLCTRL1_REG, &reg_val);
-	if (ret)
-		return ret;
-
-	reg_val &= (~AW88395_CCO_MUX_MASK);
-	if (reg_val == AW88395_CCO_MUX_DIVIDED_VALUE) {
-		dev_dbg(aw_dev->dev, "CCO_MUX is already divider");
-		return -EPERM;
-	}
-
-	/* change mode2 */
-	ret = regmap_update_bits(aw_dev->regmap, AW88395_PLLCTRL1_REG,
-			~AW88395_CCO_MUX_MASK, AW88395_CCO_MUX_DIVIDED_VALUE);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < AW88395_DEV_SYSST_CHECK_MAX; i++) {
-		ret = aw_dev_get_iis_status(aw_dev);
-		if (ret) {
-			dev_err(aw_dev->dev, "mode2 iis signal check error");
-			usleep_range(AW88395_2000_US, AW88395_2000_US + 10);
-		} else {
-			break;
-		}
-	}
-
-	/* change mode1 */
-	ret = regmap_update_bits(aw_dev->regmap, AW88395_PLLCTRL1_REG,
-			~AW88395_CCO_MUX_MASK, AW88395_CCO_MUX_BYPASS_VALUE);
-	if (ret == 0) {
-		usleep_range(AW88395_2000_US, AW88395_2000_US + 10);
-		for (i = 0; i < AW88395_DEV_SYSST_CHECK_MAX; i++) {
-			ret = aw_dev_check_mode1_pll(aw_dev);
-			if (ret < 0) {
-				dev_err(aw_dev->dev, "mode2 switch to mode1, iis signal check error");
-				usleep_range(AW88395_2000_US, AW88395_2000_US + 10);
-			} else {
-				break;
-			}
-		}
-	}
-
-	return ret;
-}
-
-static int aw_dev_check_syspll(struct aw_device *aw_dev)
-{
-	int ret;
-
-	ret = aw_dev_check_mode1_pll(aw_dev);
-	if (ret) {
-		dev_dbg(aw_dev->dev, "mode1 check iis failed try switch to mode2 check");
-		ret = aw_dev_check_mode2_pll(aw_dev);
-		if (ret) {
-			dev_err(aw_dev->dev, "mode2 check iis failed");
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
-static int aw_dev_check_sysst(struct aw_device *aw_dev)
-{
-	unsigned int check_val;
-	unsigned int reg_val;
-	int ret, i;
-
-	for (i = 0; i < AW88395_DEV_SYSST_CHECK_MAX; i++) {
-		ret = regmap_read(aw_dev->regmap, AW88395_SYSST_REG, &reg_val);
-		if (ret)
-			return ret;
-
-		check_val = reg_val & (~AW88395_BIT_SYSST_CHECK_MASK)
-							& AW88395_BIT_SYSST_CHECK;
-		if (check_val != AW88395_BIT_SYSST_CHECK) {
-			dev_err(aw_dev->dev, "check sysst fail, cnt=%d, reg_val=0x%04x, check:0x%x",
-				i, reg_val, AW88395_BIT_SYSST_CHECK);
-			usleep_range(AW88395_2000_US, AW88395_2000_US + 10);
-		} else {
-			return 0;
-		}
-	}
-
-	return -EPERM;
-}
-
-static int aw_dev_check_sysint(struct aw_device *aw_dev)
-{
-	u16 reg_val;
-
-	aw_dev_get_int_status(aw_dev, &reg_val);
-
-	if (reg_val & AW88395_BIT_SYSINT_CHECK) {
-		dev_err(aw_dev->dev, "pa stop check fail:0x%04x", reg_val);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static void aw_dev_get_cur_mode_st(struct aw_device *aw_dev)
-{
-	struct aw_profctrl_desc *profctrl_desc = &aw_dev->profctrl_desc;
-	unsigned int reg_val;
-	int ret;
-
-	ret = regmap_read(aw_dev->regmap, AW88395_SYSCTRL_REG, &reg_val);
-	if (ret) {
-		dev_dbg(aw_dev->dev, "%s failed", __func__);
-		return;
-	}
-	if ((reg_val & (~AW88395_RCV_MODE_MASK)) == AW88395_RCV_MODE_RECEIVER_VALUE)
-		profctrl_desc->cur_mode = AW88395_RCV_MODE;
-	else
-		profctrl_desc->cur_mode = AW88395_NOT_RCV_MODE;
-}
-
-static void aw_dev_get_dsp_config(struct aw_device *aw_dev, unsigned char *dsp_cfg)
-{
-	unsigned int reg_val = 0;
-	int ret;
-
-	ret = regmap_read(aw_dev->regmap, AW88395_SYSCTRL_REG, &reg_val);
-	if (ret) {
-		dev_dbg(aw_dev->dev, "%s failed", __func__);
-		return;
-	}
-	if (reg_val & (~AW88395_DSPBY_MASK))
-		*dsp_cfg = AW88395_DEV_DSP_BYPASS;
-	else
-		*dsp_cfg = AW88395_DEV_DSP_WORK;
-}
-
-static void aw_dev_select_memclk(struct aw_device *aw_dev, unsigned char flag)
-{
-	int ret;
-
-	switch (flag) {
-	case AW88395_DEV_MEMCLK_PLL:
-		ret = regmap_update_bits(aw_dev->regmap, AW88395_DBGCTRL_REG,
-					~AW88395_MEM_CLKSEL_MASK,
-					AW88395_MEM_CLKSEL_DAP_HCLK_VALUE);
-		if (ret)
-			dev_err(aw_dev->dev, "memclk select pll failed");
-		break;
-	case AW88395_DEV_MEMCLK_OSC:
-		ret = regmap_update_bits(aw_dev->regmap, AW88395_DBGCTRL_REG,
-					~AW88395_MEM_CLKSEL_MASK,
-					AW88395_MEM_CLKSEL_OSC_CLK_VALUE);
-		if (ret)
-			dev_err(aw_dev->dev, "memclk select OSC failed");
-		break;
-	default:
-		dev_err(aw_dev->dev, "unknown memclk config, flag=0x%x", flag);
-		break;
-	}
-}
-
-static int aw_dev_get_dsp_status(struct aw_device *aw_dev)
-{
-	unsigned int reg_val;
-	int ret;
-
-	ret = regmap_read(aw_dev->regmap, AW88395_WDT_REG, &reg_val);
-	if (ret)
-		return ret;
-	if (!(reg_val & (~AW88395_WDT_CNT_MASK)))
-		ret = -EPERM;
-
-	return ret;
-}
-
-static int aw_dev_get_vmax(struct aw_device *aw_dev, unsigned int *vmax)
-{
-	return aw_dev_dsp_read(aw_dev, AW88395_DSP_REG_VMAX, vmax, AW88395_DSP_16_DATA);
-}
-
-static int aw_dev_update_reg_container(struct aw_device *aw_dev,
-				unsigned char *data, unsigned int len)
-{
-	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
-	unsigned int read_val;
-	int16_t *reg_data;
-	int data_len;
-	u16 read_vol;
-	u16 reg_val;
-	u8 reg_addr;
-	int i, ret;
-
-	reg_data = (int16_t *)data;
-	data_len = len >> 1;
-
-	if (data_len & 0x1) {
-		dev_err(aw_dev->dev, "data len:%d unsupported",	data_len);
-		return -EINVAL;
-	}
-
-	for (i = 0; i < data_len; i += 2) {
-		reg_addr = reg_data[i];
-		reg_val = reg_data[i + 1];
-
-		if (reg_addr == AW88395_SYSCTRL_REG) {
-			ret = regmap_read(aw_dev->regmap, reg_addr, &read_val);
-			if (ret)
-				break;
-			read_val &= (~AW88395_HMUTE_MASK);
-			reg_val &= AW88395_HMUTE_MASK;
-			reg_val |= read_val;
-		}
-		if (reg_addr == AW88395_HAGCCFG7_REG)
-			reg_val &= AW88395_AGC_DSP_CTL_MASK;
-
-		if (reg_addr == AW88395_I2SCFG1_REG) {
-			/* close tx */
-			reg_val &= AW88395_I2STXEN_MASK;
-			reg_val |= AW88395_I2STXEN_DISABLE_VALUE;
-		}
-
-		if (reg_addr == AW88395_SYSCTRL2_REG) {
-			read_vol = (reg_val & (~AW88395_VOL_MASK)) >>
-				AW88395_VOL_START_BIT;
-			aw_dev->volume_desc.init_volume =
-				reg_val_to_db(read_vol);
-		}
-		ret = regmap_write(aw_dev->regmap, reg_addr, reg_val);
-		if (ret)
-			break;
-
-	}
-
-	aw_dev_get_cur_mode_st(aw_dev);
-
-	if (aw_dev->prof_cur != aw_dev->prof_index) {
-		/* clear control volume when PA change profile */
-		vol_desc->ctl_volume = 0;
-	} else {
-		/* keep control volume when PA start with sync mode */
-		aw_dev_set_volume(aw_dev, vol_desc->ctl_volume);
-	}
-
-	aw_dev_get_dsp_config(aw_dev, &aw_dev->dsp_cfg);
-
-	return ret;
-}
-
-static int aw_dev_reg_update(struct aw_device *aw_dev,
-					unsigned char *data, unsigned int len)
-{
-	int ret;
-
-	if (!len || !data) {
-		dev_err(aw_dev->dev, "reg data is null or len is 0");
-		return -EINVAL;
-	}
-
-	ret = aw_dev_update_reg_container(aw_dev, data, len);
-	if (ret) {
-		dev_err(aw_dev->dev, "reg update failed");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int aw_dev_get_ra(struct aw_cali_desc *cali_desc)
-{
-	struct aw_device *aw_dev =
-		container_of(cali_desc, struct aw_device, cali_desc);
-	u32 dsp_ra;
-	int ret;
-
-	ret = aw_dev_dsp_read(aw_dev, AW88395_DSP_REG_CFG_ADPZ_RA,
-				&dsp_ra, AW88395_DSP_32_DATA);
-	if (ret) {
-		dev_err(aw_dev->dev, "read ra error");
-		return ret;
-	}
-
-	cali_desc->ra = AW88395_DSP_RE_TO_SHOW_RE(dsp_ra,
-					AW88395_DSP_RE_SHIFT);
-
-	return ret;
-}
-
-static int aw_dev_dsp_update_container(struct aw_device *aw_dev,
-			unsigned char *data, unsigned int len, unsigned short base)
-{
-	int i, ret;
-
-#ifdef AW88395_DSP_I2C_WRITES
-	u32 tmp_len;
-
-	mutex_lock(&aw_dev->dsp_lock);
-	ret = regmap_write(aw_dev->regmap, AW88395_DSPMADD_REG, base);
-	if (ret)
-		goto error_operation;
-
-	for (i = 0; i < len; i += AW88395_MAX_RAM_WRITE_BYTE_SIZE) {
-		tmp_len = min(len - i, AW88395_MAX_RAM_WRITE_BYTE_SIZE);
-		ret = regmap_raw_write(aw_dev->regmap, AW88395_DSPMDAT_REG,
-					&data[i], tmp_len);
-		if (ret)
-			goto error_operation;
-	}
-	mutex_unlock(&aw_dev->dsp_lock);
-#else
-	__be16 reg_val;
-
-	mutex_lock(&aw_dev->dsp_lock);
-	/* i2c write */
-	ret = regmap_write(aw_dev->regmap, AW88395_DSPMADD_REG, base);
-	if (ret)
-		goto error_operation;
-	for (i = 0; i < len; i += 2) {
-		reg_val = cpu_to_be16p((u16 *)(data + i));
-		ret = regmap_write(aw_dev->regmap, AW88395_DSPMDAT_REG,
-					(u16)reg_val);
-		if (ret)
-			goto error_operation;
-	}
-	mutex_unlock(&aw_dev->dsp_lock);
-#endif
-
-	return 0;
-
-error_operation:
-	mutex_unlock(&aw_dev->dsp_lock);
-	return ret;
-}
-
-static int aw_dev_dsp_update_fw(struct aw_device *aw_dev,
-			unsigned char *data, unsigned int len)
-{
-
-	dev_dbg(aw_dev->dev, "dsp firmware len:%d", len);
-
-	if (!len || !data) {
-		dev_err(aw_dev->dev, "dsp firmware data is null or len is 0");
-		return -EINVAL;
-	}
-	aw_dev_dsp_update_container(aw_dev, data, len, AW88395_DSP_FW_ADDR);
-	aw_dev->dsp_fw_len = len;
-
-	return 0;
-}
-
-static int aw_dev_copy_to_crc_dsp_cfg(struct aw_device *aw_dev,
-			unsigned char *data, unsigned int size)
-{
-	struct aw_sec_data_desc *crc_dsp_cfg = &aw_dev->crc_dsp_cfg;
-
-	if (!crc_dsp_cfg->data) {
-		crc_dsp_cfg->data = devm_kzalloc(aw_dev->dev, size, GFP_KERNEL);
-		if (!crc_dsp_cfg->data)
-			return -ENOMEM;
-		crc_dsp_cfg->len = size;
-	} else if (crc_dsp_cfg->len < size) {
-		devm_kfree(aw_dev->dev, crc_dsp_cfg->data);
-		crc_dsp_cfg->data = devm_kzalloc(aw_dev->dev, size, GFP_KERNEL);
-		if (!crc_dsp_cfg->data)
-			return -ENOMEM;
-		crc_dsp_cfg->len = size;
-	}
-	memcpy(crc_dsp_cfg->data, data, size);
-	swab16_array((u16 *)crc_dsp_cfg->data, size >> 1);
-
-	return 0;
-}
-
-static int aw_dev_dsp_update_cfg(struct aw_device *aw_dev,
-			unsigned char *data, unsigned int len)
-{
-	int ret;
-
-	dev_dbg(aw_dev->dev, "dsp config len:%d", len);
-
-	if (!len || !data) {
-		dev_err(aw_dev->dev, "dsp config data is null or len is 0");
-		return -EINVAL;
-	}
-
-	aw_dev_dsp_update_container(aw_dev, data, len, AW88395_DSP_CFG_ADDR);
-	aw_dev->dsp_cfg_len = len;
-
-	ret = aw_dev_copy_to_crc_dsp_cfg(aw_dev, data, len);
-	if (ret)
-		return ret;
-
-	ret = aw_dev_set_vcalb(aw_dev);
-	if (ret)
-		return ret;
-	ret = aw_dev_get_ra(&aw_dev->cali_desc);
-	if (ret)
-		return ret;
-	ret = aw_dev_get_cali_f0_delay(aw_dev);
-	if (ret)
-		return ret;
-
-	ret = aw_dev_get_vmax(aw_dev, &aw_dev->vmax_desc.init_vmax);
-	if (ret) {
-		dev_err(aw_dev->dev, "get vmax failed");
-		return ret;
-	}
-	dev_dbg(aw_dev->dev, "get init vmax:0x%x", aw_dev->vmax_desc.init_vmax);
-	aw_dev->dsp_crc_st = AW88395_DSP_CRC_NA;
-
-	return 0;
-}
-
-static int aw_dev_check_sram(struct aw_device *aw_dev)
-{
-	unsigned int reg_val;
-
-	mutex_lock(&aw_dev->dsp_lock);
-	/* check the odd bits of reg 0x40 */
-	regmap_write(aw_dev->regmap, AW88395_DSPMADD_REG, AW88395_DSP_ODD_NUM_BIT_TEST);
-	regmap_read(aw_dev->regmap, AW88395_DSPMADD_REG, &reg_val);
-	if (reg_val != AW88395_DSP_ODD_NUM_BIT_TEST) {
-		dev_err(aw_dev->dev, "check reg 0x40 odd bit failed, read[0x%x] != write[0x%x]",
-				reg_val, AW88395_DSP_ODD_NUM_BIT_TEST);
-		goto error;
-	}
-
-	/* check the even bits of reg 0x40 */
-	regmap_write(aw_dev->regmap, AW88395_DSPMADD_REG, AW88395_DSP_EVEN_NUM_BIT_TEST);
-	regmap_read(aw_dev->regmap, AW88395_DSPMADD_REG, &reg_val);
-	if (reg_val != AW88395_DSP_EVEN_NUM_BIT_TEST) {
-		dev_err(aw_dev->dev, "check reg 0x40 even bit failed, read[0x%x] != write[0x%x]",
-				reg_val, AW88395_DSP_EVEN_NUM_BIT_TEST);
-		goto error;
-	}
-
-	/* check dsp_fw_base_addr */
-	aw_dev_dsp_write_16bit(aw_dev, AW88395_DSP_FW_ADDR,	AW88395_DSP_EVEN_NUM_BIT_TEST);
-	aw_dev_dsp_read_16bit(aw_dev, AW88395_DSP_FW_ADDR, &reg_val);
-	if (reg_val != AW88395_DSP_EVEN_NUM_BIT_TEST) {
-		dev_err(aw_dev->dev, "check dsp fw addr failed, read[0x%x] != write[0x%x]",
-						reg_val, AW88395_DSP_EVEN_NUM_BIT_TEST);
-		goto error;
-	}
-
-	/* check dsp_cfg_base_addr */
-	aw_dev_dsp_write_16bit(aw_dev, AW88395_DSP_CFG_ADDR, AW88395_DSP_ODD_NUM_BIT_TEST);
-	aw_dev_dsp_read_16bit(aw_dev, AW88395_DSP_CFG_ADDR, &reg_val);
-	if (reg_val != AW88395_DSP_ODD_NUM_BIT_TEST) {
-		dev_err(aw_dev->dev, "check dsp cfg failed, read[0x%x] != write[0x%x]",
-						reg_val, AW88395_DSP_ODD_NUM_BIT_TEST);
-		goto error;
-	}
-	mutex_unlock(&aw_dev->dsp_lock);
-
-	return 0;
-
-error:
-	mutex_unlock(&aw_dev->dsp_lock);
-	return -EPERM;
-}
-
-int aw88395_dev_fw_update(struct aw_device *aw_dev, bool up_dsp_fw_en, bool force_up_en)
-{
-	struct aw_prof_desc *prof_index_desc;
-	struct aw_sec_data_desc *sec_desc;
-	char *prof_name;
-	int ret;
-
-	if ((aw_dev->prof_cur == aw_dev->prof_index) &&
-			(force_up_en == AW88395_FORCE_UPDATE_OFF)) {
-		dev_dbg(aw_dev->dev, "scene no change, not update");
-		return 0;
-	}
-
-	if (aw_dev->fw_status == AW88395_DEV_FW_FAILED) {
-		dev_err(aw_dev->dev, "fw status[%d] error", aw_dev->fw_status);
-		return -EPERM;
-	}
-
-	ret = aw88395_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
-	if (ret)
-		return ret;
-
-	dev_dbg(aw_dev->dev, "start update %s", prof_name);
-
-	ret = aw88395_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
-	if (ret)
-		return ret;
-
-	/* update reg */
-	sec_desc = prof_index_desc->sec_desc;
-	ret = aw_dev_reg_update(aw_dev, sec_desc[AW88395_DATA_TYPE_REG].data,
-					sec_desc[AW88395_DATA_TYPE_REG].len);
-	if (ret) {
-		dev_err(aw_dev->dev, "update reg failed");
-		return ret;
-	}
-
-	aw88395_dev_mute(aw_dev, true);
-
-	if (aw_dev->dsp_cfg == AW88395_DEV_DSP_WORK)
-		aw_dev_dsp_enable(aw_dev, false);
-
-	aw_dev_select_memclk(aw_dev, AW88395_DEV_MEMCLK_OSC);
-
-	if (up_dsp_fw_en) {
-		ret = aw_dev_check_sram(aw_dev);
-		if (ret) {
-			dev_err(aw_dev->dev, "check sram failed");
-			goto error;
-		}
-
-		/* update dsp firmware */
-		dev_dbg(aw_dev->dev, "fw_ver: [%x]", prof_index_desc->fw_ver);
-		ret = aw_dev_dsp_update_fw(aw_dev, sec_desc[AW88395_DATA_TYPE_DSP_FW].data,
-					sec_desc[AW88395_DATA_TYPE_DSP_FW].len);
-		if (ret) {
-			dev_err(aw_dev->dev, "update dsp fw failed");
-			goto error;
-		}
-	}
-
-	/* update dsp config */
-	ret = aw_dev_dsp_update_cfg(aw_dev, sec_desc[AW88395_DATA_TYPE_DSP_CFG].data,
-					sec_desc[AW88395_DATA_TYPE_DSP_CFG].len);
-	if (ret) {
-		dev_err(aw_dev->dev, "update dsp cfg failed");
-		goto error;
-	}
-
-	aw_dev_select_memclk(aw_dev, AW88395_DEV_MEMCLK_PLL);
-
-	aw_dev->prof_cur = aw_dev->prof_index;
-
-	return 0;
-
-error:
-	aw_dev_select_memclk(aw_dev, AW88395_DEV_MEMCLK_PLL);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(aw88395_dev_fw_update);
-
-static int aw_dev_dsp_check(struct aw_device *aw_dev)
-{
-	int ret, i;
-
-	switch (aw_dev->dsp_cfg) {
-	case AW88395_DEV_DSP_BYPASS:
-		dev_dbg(aw_dev->dev, "dsp bypass");
-		ret = 0;
-		break;
-	case AW88395_DEV_DSP_WORK:
-		aw_dev_dsp_enable(aw_dev, false);
-		aw_dev_dsp_enable(aw_dev, true);
-		usleep_range(AW88395_1000_US, AW88395_1000_US + 10);
-		for (i = 0; i < AW88395_DEV_DSP_CHECK_MAX; i++) {
-			ret = aw_dev_get_dsp_status(aw_dev);
-			if (ret) {
-				dev_err(aw_dev->dev, "dsp wdt status error=%d", ret);
-				usleep_range(AW88395_2000_US, AW88395_2000_US + 10);
-			}
-		}
-		break;
-	default:
-		dev_err(aw_dev->dev, "unknown dsp cfg=%d", aw_dev->dsp_cfg);
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static void aw_dev_update_cali_re(struct aw_cali_desc *cali_desc)
-{
-	struct aw_device *aw_dev =
-		container_of(cali_desc, struct aw_device, cali_desc);
-	int ret;
-
-	if ((aw_dev->cali_desc.cali_re < AW88395_CALI_RE_MAX) &&
-		(aw_dev->cali_desc.cali_re > AW88395_CALI_RE_MIN)) {
-
-		ret = aw_dev_dsp_set_cali_re(aw_dev);
-		if (ret)
-			dev_err(aw_dev->dev, "set cali re failed");
-	}
-}
-
-int aw88395_dev_start(struct aw_device *aw_dev)
-{
-	int ret;
-
-	if (aw_dev->status == AW88395_DEV_PW_ON) {
-		dev_info(aw_dev->dev, "already power on");
-		return 0;
-	}
-	/* power on */
-	aw_dev_pwd(aw_dev, false);
-	usleep_range(AW88395_2000_US, AW88395_2000_US + 10);
-
-	ret = aw_dev_check_syspll(aw_dev);
-	if (ret) {
-		dev_err(aw_dev->dev, "pll check failed cannot start");
-		goto pll_check_fail;
-	}
-
-	/* amppd on */
-	aw_dev_amppd(aw_dev, false);
-	usleep_range(AW88395_1000_US, AW88395_1000_US + 50);
-
-	/* check i2s status */
-	ret = aw_dev_check_sysst(aw_dev);
-	if (ret) {
-		dev_err(aw_dev->dev, "sysst check failed");
-		goto sysst_check_fail;
-	}
-
-	if (aw_dev->dsp_cfg == AW88395_DEV_DSP_WORK) {
-		/* dsp bypass */
-		aw_dev_dsp_enable(aw_dev, false);
-		ret = aw_dev_dsp_fw_check(aw_dev);
-		if (ret)
-			goto dev_dsp_fw_check_fail;
-
-		aw_dev_update_cali_re(&aw_dev->cali_desc);
-
-		if (aw_dev->dsp_crc_st != AW88395_DSP_CRC_OK) {
-			ret = aw_dev_dsp_check_crc32(aw_dev);
-			if (ret) {
-				dev_err(aw_dev->dev, "dsp crc check failed");
-				goto crc_check_fail;
-			}
-		}
-
-		ret = aw_dev_dsp_check(aw_dev);
-		if (ret) {
-			dev_err(aw_dev->dev, "dsp status check failed");
-			goto dsp_check_fail;
-		}
-	} else {
-		dev_dbg(aw_dev->dev, "start pa with dsp bypass");
-	}
-
-	/* enable tx feedback */
-	aw_dev_i2s_tx_enable(aw_dev, true);
-
-	/* close mute */
-	aw88395_dev_mute(aw_dev, false);
-	/* clear inturrupt */
-	aw_dev_clear_int_status(aw_dev);
-	aw_dev->status = AW88395_DEV_PW_ON;
-
-	return 0;
-
-dsp_check_fail:
-crc_check_fail:
-	aw_dev_dsp_enable(aw_dev, false);
-dev_dsp_fw_check_fail:
-sysst_check_fail:
-	aw_dev_clear_int_status(aw_dev);
-	aw_dev_amppd(aw_dev, true);
-pll_check_fail:
-	aw_dev_pwd(aw_dev, true);
-	aw_dev->status = AW88395_DEV_PW_OFF;
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(aw88395_dev_start);
-
-int aw88395_dev_stop(struct aw_device *aw_dev)
-{
-	struct aw_sec_data_desc *dsp_cfg =
-		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW88395_DATA_TYPE_DSP_CFG];
-	struct aw_sec_data_desc *dsp_fw =
-		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW88395_DATA_TYPE_DSP_FW];
-	int int_st = 0;
-	int ret;
-
-	if (aw_dev->status == AW88395_DEV_PW_OFF) {
-		dev_info(aw_dev->dev, "already power off");
-		return 0;
-	}
-
-	aw_dev->status = AW88395_DEV_PW_OFF;
-
-	/* set mute */
-	aw88395_dev_mute(aw_dev, true);
-	usleep_range(AW88395_4000_US, AW88395_4000_US + 100);
-
-	/* close tx feedback */
-	aw_dev_i2s_tx_enable(aw_dev, false);
-	usleep_range(AW88395_1000_US, AW88395_1000_US + 100);
-
-	/* check sysint state */
-	int_st = aw_dev_check_sysint(aw_dev);
-
-	/* close dsp */
-	aw_dev_dsp_enable(aw_dev, false);
-
-	/* enable amppd */
-	aw_dev_amppd(aw_dev, true);
-
-	if (int_st < 0) {
-		/* system status anomaly */
-		aw_dev_select_memclk(aw_dev, AW88395_DEV_MEMCLK_OSC);
-		ret = aw_dev_dsp_update_fw(aw_dev, dsp_fw->data, dsp_fw->len);
-		if (ret)
-			dev_err(aw_dev->dev, "update dsp fw failed");
-		ret = aw_dev_dsp_update_cfg(aw_dev, dsp_cfg->data, dsp_cfg->len);
-		if (ret)
-			dev_err(aw_dev->dev, "update dsp cfg failed");
-		aw_dev_select_memclk(aw_dev, AW88395_DEV_MEMCLK_PLL);
-	}
-
-	/* set power down */
-	aw_dev_pwd(aw_dev, true);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(aw88395_dev_stop);
-
-int aw88395_dev_init(struct aw_device *aw_dev, struct aw_container *aw_cfg)
-{
-	int ret;
-
-	if ((!aw_dev) || (!aw_cfg)) {
-		pr_err("aw_dev is NULL or aw_cfg is NULL");
-		return -ENOMEM;
-	}
-	ret = aw88395_dev_cfg_load(aw_dev, aw_cfg);
-	if (ret) {
-		dev_err(aw_dev->dev, "aw_dev acf parse failed");
-		return -EINVAL;
-	}
-	aw_dev->fade_in_time = AW88395_1000_US / 10;
-	aw_dev->fade_out_time = AW88395_1000_US >> 1;
-	aw_dev->prof_cur = aw_dev->prof_info.prof_desc[0].id;
-	aw_dev->prof_index = aw_dev->prof_info.prof_desc[0].id;
-
-	ret = aw88395_dev_fw_update(aw_dev, AW88395_FORCE_UPDATE_ON,	AW88395_DSP_FW_UPDATE_ON);
-	if (ret) {
-		dev_err(aw_dev->dev, "fw update failed ret = %d\n", ret);
-		return ret;
-	}
-
-	/* set mute */
-	aw88395_dev_mute(aw_dev, true);
-	usleep_range(AW88395_4000_US, AW88395_4000_US + 100);
-
-	/* close tx feedback */
-	aw_dev_i2s_tx_enable(aw_dev, false);
-	usleep_range(AW88395_1000_US, AW88395_1000_US + 100);
-
-	/* close dsp */
-	aw_dev_dsp_enable(aw_dev, false);
-	/* enable amppd */
-	aw_dev_amppd(aw_dev, true);
-	/* set power down */
-	aw_dev_pwd(aw_dev, true);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(aw88395_dev_init);
-
-static void aw88395_parse_channel_dt(struct aw_device *aw_dev)
-{
-	struct device_node *np = aw_dev->dev->of_node;
-	u32 channel_value;
-	int ret;
-
-	ret = of_property_read_u32(np, "awinic,audio-channel", &channel_value);
-	if (ret) {
-		dev_dbg(aw_dev->dev,
-			"read audio-channel failed,use default 0");
-		aw_dev->channel = AW88395_DEV_DEFAULT_CH;
-		return;
-	}
-
-	dev_dbg(aw_dev->dev, "read audio-channel value is: %d",
-			channel_value);
-	aw_dev->channel = channel_value;
-}
-
-static int aw_dev_init(struct aw_device *aw_dev)
-{
-	aw_dev->chip_id = AW88395_CHIP_ID;
-	/* call aw device init func */
-	aw_dev->acf = NULL;
-	aw_dev->prof_info.prof_desc = NULL;
-	aw_dev->prof_info.count = 0;
-	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
-	aw_dev->channel = 0;
-	aw_dev->fw_status = AW88395_DEV_FW_FAILED;
-
-	aw_dev->fade_step = AW88395_VOLUME_STEP_DB;
-	aw_dev->volume_desc.ctl_volume = AW88395_VOL_DEFAULT_VALUE;
-	aw88395_parse_channel_dt(aw_dev);
-
-	return 0;
-}
-
-int aw88395_dev_get_profile_count(struct aw_device *aw_dev)
-{
-	return aw_dev->prof_info.count;
-}
-EXPORT_SYMBOL_GPL(aw88395_dev_get_profile_count);
-
-int aw88395_dev_get_profile_index(struct aw_device *aw_dev)
-{
-	return aw_dev->prof_index;
-}
-EXPORT_SYMBOL_GPL(aw88395_dev_get_profile_index);
-
-int aw88395_dev_set_profile_index(struct aw_device *aw_dev, int index)
-{
-	/* check the index whether is valid */
-	if ((index >= aw_dev->prof_info.count) || (index < 0))
-		return -EINVAL;
-	/* check the index whether change */
-	if (aw_dev->prof_index == index)
-		return -EINVAL;
-
-	aw_dev->prof_index = index;
-	dev_dbg(aw_dev->dev, "set prof[%s]",
-		aw_dev->prof_info.prof_name_list[aw_dev->prof_info.prof_desc[index].id]);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(aw88395_dev_set_profile_index);
-
-int aw88395_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name)
-{
-	struct aw_prof_info *prof_info = &aw_dev->prof_info;
-	struct aw_prof_desc *prof_desc;
-
-	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
-		dev_err(aw_dev->dev, "index[%d] overflow count[%d]",
-			index, aw_dev->prof_info.count);
-		return -EINVAL;
-	}
-
-	prof_desc = &aw_dev->prof_info.prof_desc[index];
-
-	*prof_name = prof_info->prof_name_list[prof_desc->id];
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(aw88395_dev_get_prof_name);
-
-int aw88395_dev_get_prof_data(struct aw_device *aw_dev, int index,
-			struct aw_prof_desc **prof_desc)
-{
-	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
-		dev_err(aw_dev->dev, "%s: index[%d] overflow count[%d]\n",
-				__func__, index, aw_dev->prof_info.count);
-		return -EINVAL;
-	}
-
-	*prof_desc = &aw_dev->prof_info.prof_desc[index];
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(aw88395_dev_get_prof_data);
-
-int aw88395_init(struct aw_device **aw_dev, struct i2c_client *i2c, struct regmap *regmap)
-{
-	u16 chip_id;
-	int ret;
-
-	if (*aw_dev) {
-		dev_info(&i2c->dev, "it should be initialized here.\n");
-	} else {
-		*aw_dev = devm_kzalloc(&i2c->dev, sizeof(struct aw_device), GFP_KERNEL);
-		if (!(*aw_dev))
-			return -ENOMEM;
-	}
-
-	(*aw_dev)->i2c = i2c;
-	(*aw_dev)->dev = &i2c->dev;
-	(*aw_dev)->regmap = regmap;
-	mutex_init(&(*aw_dev)->dsp_lock);
-
-	/* read chip id */
-	ret = aw_dev_read_chipid((*aw_dev), &chip_id);
-	if (ret) {
-		dev_err(&i2c->dev, "dev_read_chipid failed ret=%d", ret);
-		return ret;
-	}
-
-	switch (chip_id) {
-	case AW88395_CHIP_ID:
-		ret = aw_dev_init((*aw_dev));
-		break;
-	default:
-		ret = -EINVAL;
-		dev_err((*aw_dev)->dev, "unsupported device");
-		break;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(aw88395_init);
-
-MODULE_DESCRIPTION("AW88395 device lib");
-MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/aw88395/aw88395_device.h b/sound/soc/codecs/aw88395/aw88395_device.h
deleted file mode 100644
index 6f8b30b475da..000000000000
--- a/sound/soc/codecs/aw88395/aw88395_device.h
+++ /dev/null
@@ -1,214 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-//
-// aw88395_device.h --  AW88395 function for ALSA Audio Driver
-//
-// Copyright (c) 2022-2023 AWINIC Technology CO., LTD
-//
-// Author: Bruce zhao <zhaolei@awinic.com>
-//
-
-#ifndef __AW88395_DEVICE_FILE_H__
-#define __AW88395_DEVICE_FILE_H__
-
-#include "aw88395.h"
-#include "aw88395_data_type.h"
-#include "aw88395_lib.h"
-
-#define AW88395_DEV_DEFAULT_CH				(0)
-#define AW88395_DEV_DSP_CHECK_MAX			(5)
-#define AW88395_DSP_I2C_WRITES
-#define AW88395_MAX_RAM_WRITE_BYTE_SIZE		(128)
-#define AW88395_DSP_ODD_NUM_BIT_TEST			(0x5555)
-#define AW88395_DSP_EVEN_NUM_BIT_TEST			(0xAAAA)
-#define AW88395_DSP_ST_CHECK_MAX			(2)
-#define AW88395_FADE_IN_OUT_DEFAULT			(0)
-#define AW88395_CALI_RE_MAX				(15000)
-#define AW88395_CALI_RE_MIN				(4000)
-#define AW88395_CALI_DELAY_CACL(value)			((value * 32) / 48)
-
-#define AW88395_DSP_RE_TO_SHOW_RE(re, shift)		(((re) * (1000)) >> (shift))
-#define AW88395_SHOW_RE_TO_DSP_RE(re, shift)		(((re) << shift) / (1000))
-
-#define AW88395_ACF_FILE				"aw88395_acf.bin"
-#define AW88395_DEV_SYSST_CHECK_MAX			(10)
-
-enum {
-	AW88395_DEV_VDSEL_DAC = 0,
-	AW88395_DEV_VDSEL_VSENSE = 1,
-};
-
-enum {
-	AW88395_DSP_CRC_NA = 0,
-	AW88395_DSP_CRC_OK = 1,
-};
-
-enum {
-	AW88395_DSP_FW_UPDATE_OFF = 0,
-	AW88395_DSP_FW_UPDATE_ON = 1,
-};
-
-enum {
-	AW88395_FORCE_UPDATE_OFF = 0,
-	AW88395_FORCE_UPDATE_ON = 1,
-};
-
-enum {
-	AW88395_1000_US = 1000,
-	AW88395_2000_US = 2000,
-	AW88395_3000_US = 3000,
-	AW88395_4000_US = 4000,
-	AW88395_5000_US = 5000,
-	AW88395_10000_US = 10000,
-	AW88395_100000_US = 100000,
-};
-
-enum {
-	AW88395_DEV_TYPE_OK = 0,
-	AW88395_DEV_TYPE_NONE = 1,
-};
-
-
-enum AW88395_DEV_STATUS {
-	AW88395_DEV_PW_OFF = 0,
-	AW88395_DEV_PW_ON,
-};
-
-enum AW88395_DEV_FW_STATUS {
-	AW88395_DEV_FW_FAILED = 0,
-	AW88395_DEV_FW_OK,
-};
-
-enum AW88395_DEV_MEMCLK {
-	AW88395_DEV_MEMCLK_OSC = 0,
-	AW88395_DEV_MEMCLK_PLL = 1,
-};
-
-enum AW88395_DEV_DSP_CFG {
-	AW88395_DEV_DSP_WORK = 0,
-	AW88395_DEV_DSP_BYPASS = 1,
-};
-
-enum {
-	AW88395_DSP_16_DATA = 0,
-	AW88395_DSP_32_DATA = 1,
-};
-
-enum {
-	AW88395_NOT_RCV_MODE = 0,
-	AW88395_RCV_MODE = 1,
-};
-
-struct aw_profctrl_desc {
-	unsigned int cur_mode;
-};
-
-enum {
-	CALI_RESULT_NORMAL,
-	CALI_RESULT_ERROR,
-};
-
-struct aw_volume_desc {
-	unsigned int init_volume;
-	unsigned int mute_volume;
-	unsigned int ctl_volume;
-	unsigned int max_volume;
-};
-
-struct aw_dsp_mem_desc {
-	unsigned int dsp_madd_reg;
-	unsigned int dsp_mdat_reg;
-	unsigned int dsp_fw_base_addr;
-	unsigned int dsp_cfg_base_addr;
-};
-
-struct aw_vmax_desc {
-	unsigned int init_vmax;
-};
-
-struct aw_cali_delay_desc {
-	unsigned int delay;
-};
-
-#define AW_CALI_CFG_NUM (4)
-struct cali_cfg {
-	uint32_t data[AW_CALI_CFG_NUM];
-};
-
-struct aw_cali_backup_desc {
-	unsigned int dsp_ng_cfg;
-	unsigned int dsp_lp_cfg;
-};
-
-struct aw_cali_desc {
-	u32 cali_re;
-	u32 ra;
-	bool cali_switch;
-	bool cali_running;
-	uint16_t cali_result;
-	uint16_t store_vol;
-	struct cali_cfg cali_cfg;
-	struct aw_cali_backup_desc backup_info;
-};
-
-struct aw_container {
-	int len;
-	u8 data[];
-};
-
-struct aw_device {
-	int status;
-	struct mutex dsp_lock;
-
-	unsigned char prof_cur;
-	unsigned char prof_index;
-	unsigned char dsp_crc_st;
-	unsigned char dsp_cfg;
-	u16 chip_id;
-
-	unsigned int channel;
-	unsigned int fade_step;
-	unsigned int prof_data_type;
-
-	struct i2c_client *i2c;
-	struct device *dev;
-	struct regmap *regmap;
-	char *acf;
-
-	u32 dsp_fw_len;
-	u32 dsp_cfg_len;
-	u8 platform;
-	u8 fw_status;
-
-	unsigned int fade_in_time;
-	unsigned int fade_out_time;
-
-	struct aw_prof_info prof_info;
-	struct aw_sec_data_desc crc_dsp_cfg;
-	struct aw_profctrl_desc profctrl_desc;
-	struct aw_volume_desc volume_desc;
-	struct aw_dsp_mem_desc dsp_mem_desc;
-	struct aw_vmax_desc vmax_desc;
-
-	struct aw_cali_delay_desc cali_delay_desc;
-	struct aw_cali_desc cali_desc;
-
-};
-
-int aw88395_init(struct aw_device **aw_dev, struct i2c_client *i2c, struct regmap *regmap);
-int aw88395_dev_init(struct aw_device *aw_dev, struct aw_container *aw_cfg);
-int aw88395_dev_start(struct aw_device *aw_dev);
-int aw88395_dev_stop(struct aw_device *aw_dev);
-int aw88395_dev_fw_update(struct aw_device *aw_dev, bool up_dsp_fw_en, bool force_up_en);
-
-void aw88395_dev_set_volume(struct aw_device *aw_dev, unsigned short set_vol);
-int aw88395_dev_get_prof_data(struct aw_device *aw_dev, int index,
-			struct aw_prof_desc **prof_desc);
-int aw88395_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name);
-int aw88395_dev_set_profile_index(struct aw_device *aw_dev, int index);
-int aw88395_dev_get_profile_index(struct aw_device *aw_dev);
-int aw88395_dev_get_profile_count(struct aw_device *aw_dev);
-int aw88395_dev_load_acf_check(struct aw_device *aw_dev, struct aw_container *aw_cfg);
-int aw88395_dev_cfg_load(struct aw_device *aw_dev, struct aw_container *aw_cfg);
-void aw88395_dev_mute(struct aw_device *aw_dev, bool is_mute);
-
-#endif
diff --git a/sound/soc/codecs/aw88395/aw88395_lib.h b/sound/soc/codecs/aw88395/aw88395_lib.h
deleted file mode 100644
index 8a620920d8bd..000000000000
--- a/sound/soc/codecs/aw88395/aw88395_lib.h
+++ /dev/null
@@ -1,92 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-//
-// aw88395_lib.h  -- ACF bin parsing and check library file for aw88395
-//
-// Copyright (c) 2022-2023 AWINIC Technology CO., LTD
-//
-// Author: Bruce zhao <zhaolei@awinic.com>
-//
-
-#ifndef __AW88395_LIB_H__
-#define __AW88395_LIB_H__
-
-#define CHECK_REGISTER_NUM_OFFSET	(4)
-#define VALID_DATA_LEN			(4)
-#define VALID_DATA_ADDR		(4)
-#define PARSE_DSP_REG_NUM		(4)
-#define REG_DATA_BYTP_LEN		(8)
-#define CHECK_DSP_REG_NUM		(12)
-#define DSP_VALID_DATA_LEN		(12)
-#define DSP_VALID_DATA_ADDR		(12)
-#define PARSE_SOC_APP_NUM		(8)
-#define CHECK_SOC_APP_NUM		(12)
-#define APP_DOWNLOAD_ADDR		(4)
-#define APP_VALID_DATA_LEN		(12)
-#define APP_VALID_DATA_ADDR		(12)
-#define BIN_NUM_MAX			(100)
-#define HEADER_LEN			(60)
-#define BIN_DATA_TYPE_OFFSET		(8)
-#define DATA_LEN			(44)
-#define VALID_DATA_ADDR_OFFSET		(60)
-#define START_ADDR_OFFSET		(64)
-
-#define AW88395_FW_CHECK_PART		(10)
-#define HDADER_LEN			(60)
-
-#define HEADER_VERSION_OFFSET		(4)
-
-enum bin_header_version_enum {
-	HEADER_VERSION_V1 = 0x01000000,
-};
-
-enum data_type_enum {
-	DATA_TYPE_REGISTER   = 0x00000000,
-	DATA_TYPE_DSP_REG    = 0x00000010,
-	DATA_TYPE_DSP_CFG    = 0x00000011,
-	DATA_TYPE_SOC_REG    = 0x00000020,
-	DATA_TYPE_SOC_APP    = 0x00000021,
-	DATA_TYPE_DSP_FW     = 0x00000022,
-	DATA_TYPE_MULTI_BINS = 0x00002000,
-};
-
-enum data_version_enum {
-	DATA_VERSION_V1 = 0x00000001,
-	DATA_VERSION_MAX,
-};
-
-struct bin_header_info {
-	unsigned int check_sum;
-	unsigned int header_ver;
-	unsigned int bin_data_type;
-	unsigned int bin_data_ver;
-	unsigned int bin_data_len;
-	unsigned int ui_ver;
-	unsigned char chip_type[8];
-	unsigned int reg_byte_len;
-	unsigned int data_byte_len;
-	unsigned int device_addr;
-	unsigned int valid_data_len;
-	unsigned int valid_data_addr;
-
-	unsigned int reg_num;
-	unsigned int reg_data_byte_len;
-	unsigned int download_addr;
-	unsigned int app_version;
-	unsigned int header_len;
-};
-
-struct bin_container {
-	unsigned int len;
-	unsigned char data[];
-};
-
-struct aw_bin {
-	unsigned char *p_addr;
-	unsigned int all_bin_parse_num;
-	unsigned int multi_bin_parse_num;
-	unsigned int single_bin_parse_num;
-	struct bin_header_info header_info[BIN_NUM_MAX];
-	struct bin_container info;
-};
-
-#endif
-- 
2.47.0


