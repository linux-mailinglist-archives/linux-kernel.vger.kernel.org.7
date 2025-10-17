Return-Path: <linux-kernel+bounces-857833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6E1BE807B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B75422EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44D73128D3;
	Fri, 17 Oct 2025 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b="Z3Fkc3TZ"
Received: from out198-9.us.a.mail.aliyun.com (out198-9.us.a.mail.aliyun.com [47.90.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93804312830;
	Fri, 17 Oct 2025 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696217; cv=none; b=kAT1inKKQnyciUcVhBF+Rna3ZN5hRxPbHeyxuPkHIgOnOlW8L+4O+WJEax812QoDeLyNXyyui/oiALJE0bCEWN7Ox57K7kL8G4rUudImc3KND3x1owlKDqSULQ7GYCxaNTrfvpaOsxnT1zg0aUKmzNEqZC7MBwZ7L1/9mrr95Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696217; c=relaxed/simple;
	bh=7NvnIO4QEXgPSPghRReS84SF60yA5o4Wh6gpcGIjerA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnwIpJoIctj8Ij54z18VKeQSwiag1G6ffBTKjY034MgaEX0GZevcRBz7Jc6M3ElHQmriOPrzWIo0tGAyeKJExGNGa3qYcY0dAEsINVnIQxWCDRQ7GZ7zKPCjmAJcWTtIhHaZKCYcVPANVZiXscrVJYTEgIR8bO1Rfu2aSu0I+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b=Z3Fkc3TZ; arc=none smtp.client-ip=47.90.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=awinic.com; s=default;
	t=1760696200; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tZu/1Qb8XZ8AV/1oSSraEMWY1Cty8nEpT6InaGChhQ8=;
	b=Z3Fkc3TZfuUd8ogB2eTxr4L+DdDVtSfnZMxCqi06Xc24dV3HUoPeNJNw4La//od/4AupYnVFA0NAhd4GMYV7KqCljK6GI1HqdO9idIVTxLvkLxdXsLMtSnaMQMgZ++mFPBU9eKpWwtTYxcts59ppdUHFF1gPIgKshXxzFTcW8Q1rFA18CUgJiyLdkPoeN8TwHKNsjC/QX8QqYPDwB1UNPCbeq4AmkytOWW6kRxrYWSa0Mh3bN3+5+e6dKFjIQPYOYVVsN6EaGQgznAo8sopDvNm17DvqxHmrJHHRBFIpVZGNbQBU1zfVHU11fJ6233IEKLPCBwEcTzIybdKHTbdM9A==
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.f0sBYB7_1760695879 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 18:11:20 +0800
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
Subject: [PATCH V2 5/7] ASoC: codecs: Rework the aw88166 driver
Date: Fri, 17 Oct 2025 18:11:03 +0800
Message-ID: <20251017101106.370742-6-wangweidong.a@awinic.com>
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

Modify the interface for calling the aw88166 driver
to adapt it for aw-common-device.c and aw-common-firmware.c

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88166.c | 819 +++++++------------------------------
 sound/soc/codecs/aw88166.h |  58 ---
 2 files changed, 137 insertions(+), 740 deletions(-)

diff --git a/sound/soc/codecs/aw88166.c b/sound/soc/codecs/aw88166.c
index 28f62b991ef2..57d42e2bc424 100644
--- a/sound/soc/codecs/aw88166.c
+++ b/sound/soc/codecs/aw88166.c
@@ -11,11 +11,11 @@
 #include <linux/firmware.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
-#include <linux/minmax.h>
 #include <linux/regmap.h>
 #include <sound/soc.h>
 #include "aw88166.h"
-#include "aw88395/aw88395_device.h"
+#include "aw-common-device.h"
+#include "aw-common-firmware.h"
 
 struct aw88166 {
 	struct aw_device *aw_pa;
@@ -41,150 +41,6 @@ static const struct regmap_config aw88166_remap_config = {
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 };
 
-static int aw_dev_dsp_write_16bit(struct aw_device *aw_dev,
-		unsigned short dsp_addr, unsigned int dsp_data)
-{
-	int ret;
-
-	ret = regmap_write(aw_dev->regmap, AW88166_DSPMADD_REG, dsp_addr);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write addr error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	ret = regmap_write(aw_dev->regmap, AW88166_DSPMDAT_REG, (u16)dsp_data);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write data error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int aw_dev_dsp_read_16bit(struct aw_device *aw_dev,
-		unsigned short dsp_addr, unsigned int *dsp_data)
-{
-	unsigned int temp_data;
-	int ret;
-
-	ret = regmap_write(aw_dev->regmap, AW88166_DSPMADD_REG, dsp_addr);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	ret = regmap_read(aw_dev->regmap, AW88166_DSPMDAT_REG, &temp_data);
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
-	ret = regmap_write(aw_dev->regmap, AW88166_DSPMADD_REG, dsp_addr);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	ret = regmap_read(aw_dev->regmap, AW88166_DSPMDAT_REG, &temp_data);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
-		return ret;
-	}
-	*dsp_data = temp_data;
-
-	ret = regmap_read(aw_dev->regmap, AW88166_DSPMDAT_REG, &temp_data);
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
-	case AW88166_DSP_16_DATA:
-		ret = aw_dev_dsp_read_16bit(aw_dev, dsp_addr, dsp_data);
-		if (ret)
-			dev_err(aw_dev->dev, "read dsp_addr[0x%x] 16-bit failed", (u32)dsp_addr);
-		break;
-	case AW88166_DSP_32_DATA:
-		ret = aw_dev_dsp_read_32bit(aw_dev, dsp_addr, dsp_data);
-		if (ret)
-			dev_err(aw_dev->dev, "read dsp_addr[0x%x] 32-bit failed", (u32)dsp_addr);
-		break;
-	default:
-		dev_err(aw_dev->dev, "data type[%d] unsupported", data_type);
-		ret = -EINVAL;
-		break;
-	}
-
-	/* clear dsp chip select state */
-	if (regmap_read(aw_dev->regmap, AW88166_ID_REG, &reg_value))
-		dev_err(aw_dev->dev, "%s fail to clear chip state. ret=%d\n", __func__, ret);
-	mutex_unlock(&aw_dev->dsp_lock);
-
-	return ret;
-}
-
-static void aw_dev_pwd(struct aw_device *aw_dev, bool pwd)
-{
-	int ret;
-
-	if (pwd)
-		ret = regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
-				~AW88166_PWDN_MASK, AW88166_PWDN_POWER_DOWN_VALUE);
-	else
-		ret = regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
-				~AW88166_PWDN_MASK, AW88166_PWDN_WORKING_VALUE);
-
-	if (ret)
-		dev_dbg(aw_dev->dev, "%s failed", __func__);
-}
-
-static void aw_dev_get_int_status(struct aw_device *aw_dev, unsigned short *int_status)
-{
-	unsigned int reg_val;
-	int ret;
-
-	ret = regmap_read(aw_dev->regmap, AW88166_SYSINT_REG, &reg_val);
-	if (ret)
-		dev_err(aw_dev->dev, "read interrupt reg fail, ret=%d", ret);
-	else
-		*int_status = reg_val;
-
-	dev_dbg(aw_dev->dev, "read interrupt reg=0x%04x", *int_status);
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
-		dev_dbg(aw_dev->dev, "int status(%d) is not cleaned.\n", int_status);
-}
-
 static int aw_dev_get_iis_status(struct aw_device *aw_dev)
 {
 	unsigned int reg_val;
@@ -209,7 +65,7 @@ static int aw_dev_check_mode1_pll(struct aw_device *aw_dev)
 		ret = aw_dev_get_iis_status(aw_dev);
 		if (ret) {
 			dev_err(aw_dev->dev, "mode1 iis signal check error");
-			usleep_range(AW88166_2000_US, AW88166_2000_US + 10);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
 		} else {
 			return 0;
 		}
@@ -243,7 +99,7 @@ static int aw_dev_check_mode2_pll(struct aw_device *aw_dev)
 		ret = aw_dev_get_iis_status(aw_dev);
 		if (ret) {
 			dev_err(aw_dev->dev, "mode2 iis signal check error");
-			usleep_range(AW88166_2000_US, AW88166_2000_US + 10);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
 		} else {
 			break;
 		}
@@ -253,12 +109,12 @@ static int aw_dev_check_mode2_pll(struct aw_device *aw_dev)
 	regmap_update_bits(aw_dev->regmap, AW88166_PLLCTRL2_REG,
 			~AW88166_CCO_MUX_MASK, AW88166_CCO_MUX_BYPASS_VALUE);
 	if (ret == 0) {
-		usleep_range(AW88166_2000_US, AW88166_2000_US + 10);
+		usleep_range(AW_2000_US, AW_2000_US + 10);
 		for (i = 0; i < AW88166_DEV_SYSST_CHECK_MAX; i++) {
 			ret = aw_dev_get_iis_status(aw_dev);
 			if (ret) {
 				dev_err(aw_dev->dev, "mode2 switch to mode1, iis signal check error");
-				usleep_range(AW88166_2000_US, AW88166_2000_US + 10);
+				usleep_range(AW_2000_US, AW_2000_US + 10);
 			} else {
 				break;
 			}
@@ -308,7 +164,7 @@ static int aw_dev_check_sysst(struct aw_device *aw_dev)
 		if ((reg_val & (~AW88166_BIT_SYSST_CHECK_MASK) & check_val) != check_val) {
 			dev_err(aw_dev->dev, "check sysst fail, cnt=%d, reg_val=0x%04x, check:0x%x",
 				i, reg_val, AW88166_BIT_SYSST_NOSWS_CHECK);
-			usleep_range(AW88166_2000_US, AW88166_2000_US + 10);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
 		} else {
 			return 0;
 		}
@@ -317,36 +173,6 @@ static int aw_dev_check_sysst(struct aw_device *aw_dev)
 	return -EPERM;
 }
 
-static void aw_dev_amppd(struct aw_device *aw_dev, bool amppd)
-{
-	int ret;
-
-	if (amppd)
-		ret = regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
-				~AW88166_AMPPD_MASK, AW88166_AMPPD_POWER_DOWN_VALUE);
-	else
-		ret = regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
-				~AW88166_AMPPD_MASK, AW88166_AMPPD_WORKING_VALUE);
-
-	if (ret)
-		dev_dbg(aw_dev->dev, "%s failed", __func__);
-}
-
-static void aw_dev_dsp_enable(struct aw_device *aw_dev, bool is_enable)
-{
-	int ret;
-
-	if (is_enable)
-		ret = regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
-					~AW88166_DSPBY_MASK, AW88166_DSPBY_WORKING_VALUE);
-	else
-		ret = regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
-					~AW88166_DSPBY_MASK, AW88166_DSPBY_BYPASS_VALUE);
-
-	if (ret)
-		dev_dbg(aw_dev->dev, "%s failed\n", __func__);
-}
-
 static int aw88166_dev_get_icalk(struct aw88166 *aw88166, int16_t *icalk)
 {
 	struct aw_device *aw_dev = aw88166->aw_pa;
@@ -564,7 +390,7 @@ static int aw_dev_fw_crc_check(struct aw_device *aw_dev)
 	ret = regmap_update_bits(aw_dev->regmap, AW88166_CRCCTRL_REG,
 		~AW88166_CRC_CODE_EN_MASK, AW88166_CRC_CODE_EN_ENABLE_VALUE);
 
-	usleep_range(AW88166_2000_US, AW88166_2000_US + 10);
+	usleep_range(AW_2000_US, AW_2000_US + 10);
 
 	/* read crc check result */
 	regmap_read(aw_dev->regmap, AW88166_HAGCST_REG, &reg_val);
@@ -609,7 +435,7 @@ static int aw_dev_cfg_crc_check(struct aw_device *aw_dev)
 	if (ret)
 		return ret;
 
-	usleep_range(AW88166_1000_US, AW88166_1000_US + 10);
+	usleep_range(AW_1000_US, AW_1000_US + 10);
 
 	/* read crc check result */
 	ret = regmap_read(aw_dev->regmap, AW88166_HAGCST_REG, &reg_val);
@@ -670,170 +496,74 @@ static int aw_dev_hw_crc_check(struct aw88166 *aw88166)
 	return ret;
 }
 
-static void aw_dev_i2s_tx_enable(struct aw_device *aw_dev, bool flag)
-{
-	int ret;
-
-	if (flag)
-		ret = regmap_update_bits(aw_dev->regmap, AW88166_I2SCTRL3_REG,
-			~AW88166_I2STXEN_MASK, AW88166_I2STXEN_ENABLE_VALUE);
-	else
-		ret = regmap_update_bits(aw_dev->regmap, AW88166_I2SCTRL3_REG,
-			~AW88166_I2STXEN_MASK, AW88166_I2STXEN_DISABLE_VALUE);
-
-	if (ret)
-		dev_dbg(aw_dev->dev, "%s failed", __func__);
-}
-
-static int aw_dev_get_dsp_status(struct aw_device *aw_dev)
-{
-	unsigned int reg_val;
-	int ret;
-
-	ret = regmap_read(aw_dev->regmap, AW88166_WDT_REG, &reg_val);
-	if (ret)
-		return ret;
-	if (!(reg_val & (~AW88166_WDT_CNT_MASK)))
-		return -EPERM;
-
-	return 0;
-}
-
 static int aw_dev_dsp_check(struct aw_device *aw_dev)
 {
 	int ret, i;
 
-	switch (aw_dev->dsp_cfg) {
-	case AW88166_DEV_DSP_BYPASS:
-		dev_dbg(aw_dev->dev, "dsp bypass");
-		ret = 0;
-		break;
-	case AW88166_DEV_DSP_WORK:
-		aw_dev_dsp_enable(aw_dev, false);
-		aw_dev_dsp_enable(aw_dev, true);
-		usleep_range(AW88166_1000_US, AW88166_1000_US + 10);
-		for (i = 0; i < AW88166_DEV_DSP_CHECK_MAX; i++) {
-			ret = aw_dev_get_dsp_status(aw_dev);
-			if (ret) {
-				dev_err(aw_dev->dev, "dsp wdt status error=%d", ret);
-				usleep_range(AW88166_2000_US, AW88166_2000_US + 10);
-			}
+
+	regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
+					~AW88166_DSPBY_MASK, AW88166_DSPBY_BYPASS_VALUE);
+	regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
+					~AW88166_DSPBY_MASK, AW88166_DSPBY_WORKING_VALUE);
+	usleep_range(AW_1000_US, AW_1000_US + 10);
+	for (i = 0; i < AW88166_DEV_DSP_CHECK_MAX; i++) {
+		ret = aw_dev_get_dsp_status(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "dsp wdt status error=%d", ret);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
 		}
-		break;
-	default:
-		dev_err(aw_dev->dev, "unknown dsp cfg=%d", aw_dev->dsp_cfg);
-		ret = -EINVAL;
-		break;
 	}
 
 	return ret;
 }
 
-static int aw_dev_set_volume(struct aw_device *aw_dev, unsigned int value)
+static void aw88166_set_volume(struct aw_device *aw_dev, unsigned int value)
 {
 	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
 	unsigned int reg_value;
 	u16 real_value;
-	int ret;
 
 	real_value = min((value + vol_desc->init_volume), (unsigned int)AW88166_MUTE_VOL);
 
-	ret = regmap_read(aw_dev->regmap, AW88166_SYSCTRL2_REG, &reg_value);
-	if (ret)
-		return ret;
+	regmap_read(aw_dev->regmap, AW88166_SYSCTRL2_REG, &reg_value);
 
 	dev_dbg(aw_dev->dev, "value 0x%x , reg:0x%x", value, real_value);
 
 	real_value = (real_value << AW88166_VOL_START_BIT) | (reg_value & AW88166_VOL_MASK);
 
-	ret = regmap_write(aw_dev->regmap, AW88166_SYSCTRL2_REG, real_value);
-
-	return ret;
-}
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
-	for (i = AW88166_MUTE_VOL; i >= fade_in_vol; i -= fade_step) {
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
-		aw_dev_set_volume(aw_dev, AW88166_MUTE_VOL);
-		return;
-	}
-
-	for (i = desc->ctl_volume; i <= AW88166_MUTE_VOL; i += fade_step) {
-		aw_dev_set_volume(aw_dev, i);
-		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
-	}
-
-	if (i != AW88166_MUTE_VOL) {
-		aw_dev_set_volume(aw_dev, AW88166_MUTE_VOL);
-		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
-	}
+	regmap_write(aw_dev->regmap, AW88166_SYSCTRL2_REG, real_value);
 }
 
 static void aw88166_dev_mute(struct aw_device *aw_dev, bool is_mute)
 {
 	if (is_mute) {
-		aw_dev_fade_out(aw_dev);
+		aw_dev_fade_out(aw_dev, aw88166_set_volume);
 		regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
 				~AW88166_HMUTE_MASK, AW88166_HMUTE_ENABLE_VALUE);
 	} else {
 		regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
 				~AW88166_HMUTE_MASK, AW88166_HMUTE_DISABLE_VALUE);
-		aw_dev_fade_in(aw_dev);
+		aw_dev_fade_in(aw_dev, aw88166_set_volume);
 	}
 }
 
-static void aw88166_dev_set_dither(struct aw88166 *aw88166, bool dither)
-{
-	struct aw_device *aw_dev = aw88166->aw_pa;
-
-	if (dither)
-		regmap_update_bits(aw_dev->regmap, AW88166_DBGCTRL_REG,
-				~AW88166_DITHER_EN_MASK, AW88166_DITHER_EN_ENABLE_VALUE);
-	else
-		regmap_update_bits(aw_dev->regmap, AW88166_DBGCTRL_REG,
-				~AW88166_DITHER_EN_MASK, AW88166_DITHER_EN_DISABLE_VALUE);
-}
-
 static int aw88166_dev_start(struct aw88166 *aw88166)
 {
 	struct aw_device *aw_dev = aw88166->aw_pa;
 	int ret;
 
-	if (aw_dev->status == AW88166_DEV_PW_ON) {
+	if (aw_dev->status == AW_DEV_PW_ON) {
 		dev_dbg(aw_dev->dev, "already power on");
 		return 0;
 	}
 
-	aw88166_dev_set_dither(aw88166, false);
+	regmap_update_bits(aw_dev->regmap, AW88166_DBGCTRL_REG,
+				~AW88166_DITHER_EN_MASK, AW88166_DITHER_EN_DISABLE_VALUE);
 
 	/* power on */
-	aw_dev_pwd(aw_dev, false);
-	usleep_range(AW88166_2000_US, AW88166_2000_US + 10);
+	regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
+				~AW88166_PWDN_MASK, AW88166_PWDN_WORKING_VALUE);
+	usleep_range(AW_2000_US, AW_2000_US + 10);
 
 	ret = aw_dev_check_syspll(aw_dev);
 	if (ret) {
@@ -842,8 +572,9 @@ static int aw88166_dev_start(struct aw88166 *aw88166)
 	}
 
 	/* amppd on */
-	aw_dev_amppd(aw_dev, false);
-	usleep_range(AW88166_1000_US, AW88166_1000_US + 50);
+	regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
+				~AW88166_AMPPD_MASK, AW88166_AMPPD_WORKING_VALUE);
+	usleep_range(AW_1000_US, AW_1000_US + 50);
 
 	/* check i2s status */
 	ret = aw_dev_check_sysst(aw_dev);
@@ -852,14 +583,15 @@ static int aw88166_dev_start(struct aw88166 *aw88166)
 		goto sysst_check_fail;
 	}
 
-	if (aw_dev->dsp_cfg == AW88166_DEV_DSP_WORK) {
+	if (aw_dev->dsp_cfg == AW_DEV_DSP_WORK) {
 		aw_dev_backup_sec_recovery(aw88166);
 		ret = aw_dev_hw_crc_check(aw88166);
 		if (ret) {
 			dev_err(aw_dev->dev, "dsp crc check failed\n");
 			goto crc_check_fail;
 		}
-		aw_dev_dsp_enable(aw_dev, false);
+		regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
+					~AW88166_DSPBY_MASK, AW88166_DSPBY_BYPASS_VALUE);
 		aw88166_dev_set_vcalb(aw88166);
 		aw_dev_update_cali_re(&aw_dev->cali_desc);
 		ret = aw_dev_dsp_check(aw_dev);
@@ -872,68 +604,45 @@ static int aw88166_dev_start(struct aw88166 *aw88166)
 	}
 
 	/* enable tx feedback */
-	aw_dev_i2s_tx_enable(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88166_I2SCTRL3_REG,
+			~AW88166_I2STXEN_MASK, AW88166_I2STXEN_ENABLE_VALUE);
 
 	if (aw88166->dither_st == AW88166_DITHER_EN_ENABLE_VALUE)
-		aw88166_dev_set_dither(aw88166, true);
+		regmap_update_bits(aw_dev->regmap, AW88166_DBGCTRL_REG,
+				~AW88166_DITHER_EN_MASK, AW88166_DITHER_EN_ENABLE_VALUE);
 
 	/* close mute */
 	aw88166_dev_mute(aw_dev, false);
 	/* clear inturrupt */
 	aw_dev_clear_int_status(aw_dev);
-	aw_dev->status = AW88166_DEV_PW_ON;
+	aw_dev->status = AW_DEV_PW_ON;
 
 	return 0;
 
 dsp_check_fail:
 crc_check_fail:
-	aw_dev_dsp_enable(aw_dev, false);
+	regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
+				~AW88166_DSPBY_MASK, AW88166_DSPBY_BYPASS_VALUE);
 sysst_check_fail:
 	aw_dev_clear_int_status(aw_dev);
-	aw_dev_amppd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
+				~AW88166_AMPPD_MASK, AW88166_AMPPD_POWER_DOWN_VALUE);
 pll_check_fail:
-	aw_dev_pwd(aw_dev, true);
-	aw_dev->status = AW88166_DEV_PW_OFF;
-
-	return ret;
-}
-
-static int aw_dev_dsp_update_container(struct aw_device *aw_dev,
-			unsigned char *data, unsigned int len, unsigned short base)
-{
-	u32 tmp_len;
-	int i, ret;
-
-	mutex_lock(&aw_dev->dsp_lock);
-	ret = regmap_write(aw_dev->regmap, AW88166_DSPMADD_REG, base);
-	if (ret)
-		goto error_operation;
-
-	for (i = 0; i < len; i += AW88166_MAX_RAM_WRITE_BYTE_SIZE) {
-		tmp_len = min(len - i, AW88166_MAX_RAM_WRITE_BYTE_SIZE);
-		ret = regmap_raw_write(aw_dev->regmap, AW88166_DSPMDAT_REG,
-					&data[i], tmp_len);
-		if (ret)
-			goto error_operation;
-	}
-	mutex_unlock(&aw_dev->dsp_lock);
-
-	return 0;
+	regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
+				~AW88166_PWDN_MASK, AW88166_PWDN_POWER_DOWN_VALUE);
+	aw_dev->status = AW_DEV_PW_OFF;
 
-error_operation:
-	mutex_unlock(&aw_dev->dsp_lock);
 	return ret;
 }
 
-static int aw_dev_get_ra(struct aw_cali_desc *cali_desc)
+static int aw_dev_get_ra(struct aw_device *aw_dev)
 {
-	struct aw_device *aw_dev =
-		container_of(cali_desc, struct aw_device, cali_desc);
+	struct aw_cali_desc *cali_desc = &aw_dev->cali_desc;
 	u32 dsp_ra;
 	int ret;
 
 	ret = aw_dev_dsp_read(aw_dev, AW88166_DSP_REG_CFG_ADPZ_RA,
-				&dsp_ra, AW88166_DSP_32_DATA);
+				&dsp_ra, AW_DSP_32_DATA);
 	if (ret) {
 		dev_err(aw_dev->dev, "read ra error\n");
 		return ret;
@@ -945,54 +654,12 @@ static int aw_dev_get_ra(struct aw_cali_desc *cali_desc)
 	return 0;
 }
 
-static int aw_dev_dsp_update_cfg(struct aw_device *aw_dev,
-			unsigned char *data, unsigned int len)
-{
-	int ret;
-
-	dev_dbg(aw_dev->dev, "dsp config len:%d", len);
-
-	if (!len || !data) {
-		dev_err(aw_dev->dev, "dsp config data is null or len is 0\n");
-		return -EINVAL;
-	}
-
-	ret = aw_dev_dsp_update_container(aw_dev, data, len, AW88166_DSP_CFG_ADDR);
-	if (ret)
-		return ret;
-
-	aw_dev->dsp_cfg_len = len;
-
-	ret = aw_dev_get_ra(&aw_dev->cali_desc);
-
-	return ret;
-}
-
-static int aw_dev_dsp_update_fw(struct aw_device *aw_dev,
-			unsigned char *data, unsigned int len)
-{
-	int ret;
-
-	dev_dbg(aw_dev->dev, "dsp firmware len:%d", len);
-
-	if (!len || !data) {
-		dev_err(aw_dev->dev, "dsp firmware data is null or len is 0\n");
-		return -EINVAL;
-	}
-
-	aw_dev->dsp_fw_len = len;
-	ret = aw_dev_dsp_update_container(aw_dev, data, len, AW88166_DSP_FW_ADDR);
-
-	return ret;
-}
-
-static int aw_dev_check_sram(struct aw_device *aw_dev)
+static int aw88166_check_sram(struct aw_device *aw_dev)
 {
 	unsigned int reg_val;
 
-	mutex_lock(&aw_dev->dsp_lock);
 	/* read dsp_rom_check_reg */
-	aw_dev_dsp_read_16bit(aw_dev, AW88166_DSP_ROM_CHECK_ADDR, &reg_val);
+	aw_dev_dsp_read(aw_dev, AW88166_DSP_ROM_CHECK_ADDR, &reg_val, AW_DSP_16_DATA);
 	if (reg_val != AW88166_DSP_ROM_CHECK_DATA) {
 		dev_err(aw_dev->dev, "check dsp rom failed, read[0x%x] != check[0x%x]\n",
 						reg_val, AW88166_DSP_ROM_CHECK_DATA);
@@ -1000,47 +667,21 @@ static int aw_dev_check_sram(struct aw_device *aw_dev)
 	}
 
 	/* check dsp_cfg_base_addr */
-	aw_dev_dsp_write_16bit(aw_dev, AW88166_DSP_CFG_ADDR, AW88166_DSP_ODD_NUM_BIT_TEST);
-	aw_dev_dsp_read_16bit(aw_dev, AW88166_DSP_CFG_ADDR, &reg_val);
+	aw_dev_dsp_write(aw_dev, AW88166_DSP_CFG_ADDR,
+					AW88166_DSP_ODD_NUM_BIT_TEST, AW_DSP_16_DATA);
+	aw_dev_dsp_read(aw_dev, AW88166_DSP_CFG_ADDR, &reg_val, AW_DSP_16_DATA);
 	if (reg_val != AW88166_DSP_ODD_NUM_BIT_TEST) {
 		dev_err(aw_dev->dev, "check dsp cfg failed, read[0x%x] != write[0x%x]\n",
 						reg_val, AW88166_DSP_ODD_NUM_BIT_TEST);
 		goto error;
 	}
-	mutex_unlock(&aw_dev->dsp_lock);
 
 	return 0;
 error:
-	mutex_unlock(&aw_dev->dsp_lock);
 	return -EPERM;
 }
 
-static void aw_dev_select_memclk(struct aw_device *aw_dev, unsigned char flag)
-{
-	int ret;
-
-	switch (flag) {
-	case AW88166_DEV_MEMCLK_PLL:
-		ret = regmap_update_bits(aw_dev->regmap, AW88166_DBGCTRL_REG,
-					~AW88166_MEM_CLKSEL_MASK,
-					AW88166_MEM_CLKSEL_DAPHCLK_VALUE);
-		if (ret)
-			dev_err(aw_dev->dev, "memclk select pll failed\n");
-		break;
-	case AW88166_DEV_MEMCLK_OSC:
-		ret = regmap_update_bits(aw_dev->regmap, AW88166_DBGCTRL_REG,
-					~AW88166_MEM_CLKSEL_MASK,
-					AW88166_MEM_CLKSEL_OSCCLK_VALUE);
-		if (ret)
-			dev_err(aw_dev->dev, "memclk select OSC failed\n");
-		break;
-	default:
-		dev_err(aw_dev->dev, "unknown memclk config, flag=0x%x\n", flag);
-		break;
-	}
-}
-
-static int aw_dev_update_reg_container(struct aw88166 *aw88166,
+static int aw88166_reg_update(struct aw88166 *aw88166,
 				unsigned char *data, unsigned int len)
 {
 	struct aw_device *aw_dev = aw88166->aw_pa;
@@ -1054,7 +695,7 @@ static int aw_dev_update_reg_container(struct aw88166 *aw88166,
 	data_len = len >> 1;
 
 	if (data_len & 0x1) {
-		dev_err(aw_dev->dev, "data len:%d unsupported\n",	data_len);
+		dev_err(aw_dev->dev, "data len:%d unsupported\n", data_len);
 		return -EINVAL;
 	}
 
@@ -1069,9 +710,9 @@ static int aw_dev_update_reg_container(struct aw88166 *aw88166,
 
 		if (reg_addr == AW88166_SYSCTRL_REG) {
 			if (reg_val & (~AW88166_DSPBY_MASK))
-				aw_dev->dsp_cfg = AW88166_DEV_DSP_BYPASS;
+				aw_dev->dsp_cfg = AW_DEV_DSP_BYPASS;
 			else
-				aw_dev->dsp_cfg = AW88166_DEV_DSP_WORK;
+				aw_dev->dsp_cfg = AW_DEV_DSP_WORK;
 
 			reg_val &= (AW88166_HMUTE_MASK | AW88166_PWDN_MASK |
 						AW88166_DSPBY_MASK);
@@ -1117,62 +758,14 @@ static int aw_dev_update_reg_container(struct aw88166 *aw88166,
 			return ret;
 	}
 
-	aw_dev_pwd(aw_dev, false);
-	usleep_range(AW88166_1000_US, AW88166_1000_US + 10);
+	regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
+				~AW88166_PWDN_MASK, AW88166_PWDN_WORKING_VALUE);
+	usleep_range(AW_1000_US, AW_1000_US + 10);
 
 	if (aw_dev->prof_cur != aw_dev->prof_index)
 		vol_desc->ctl_volume = 0;
 	else
-		aw_dev_set_volume(aw_dev, vol_desc->ctl_volume);
-
-	return 0;
-}
-
-static int aw_dev_reg_update(struct aw88166 *aw88166,
-					unsigned char *data, unsigned int len)
-{
-	int ret;
-
-	if (!len || !data) {
-		dev_err(aw88166->aw_pa->dev, "reg data is null or len is 0\n");
-		return -EINVAL;
-	}
-
-	ret = aw_dev_update_reg_container(aw88166, data, len);
-	if (ret)
-		dev_err(aw88166->aw_pa->dev, "reg update failed\n");
-
-	return ret;
-}
-
-static int aw88166_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name)
-{
-	struct aw_prof_info *prof_info = &aw_dev->prof_info;
-	struct aw_prof_desc *prof_desc;
-
-	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
-		dev_err(aw_dev->dev, "index[%d] overflow count[%d]\n",
-						index, aw_dev->prof_info.count);
-		return -EINVAL;
-	}
-
-	prof_desc = &aw_dev->prof_info.prof_desc[index];
-
-	*prof_name = prof_info->prof_name_list[prof_desc->id];
-
-	return 0;
-}
-
-static int aw88166_dev_get_prof_data(struct aw_device *aw_dev, int index,
-			struct aw_prof_desc **prof_desc)
-{
-	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
-		dev_err(aw_dev->dev, "%s: index[%d] overflow count[%d]\n",
-				__func__, index, aw_dev->prof_info.count);
-		return -EINVAL;
-	}
-
-	*prof_desc = &aw_dev->prof_info.prof_desc[index];
+		aw88166_set_volume(aw_dev, vol_desc->ctl_volume);
 
 	return 0;
 }
@@ -1186,54 +779,51 @@ static int aw88166_dev_fw_update(struct aw88166 *aw88166, bool up_dsp_fw_en, boo
 	int ret;
 
 	if ((aw_dev->prof_cur == aw_dev->prof_index) &&
-			(force_up_en == AW88166_FORCE_UPDATE_OFF)) {
+			(force_up_en == AW_FORCE_UPDATE_OFF)) {
 		dev_dbg(aw_dev->dev, "scene no change, not update");
 		return 0;
 	}
 
-	if (aw_dev->fw_status == AW88166_DEV_FW_FAILED) {
+	if (aw_dev->fw_status == AW_DEV_FW_FAILED) {
 		dev_err(aw_dev->dev, "fw status[%d] error\n", aw_dev->fw_status);
 		return -EPERM;
 	}
 
-	ret = aw88166_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
+	ret = aw_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
 	if (ret)
 		return ret;
 
 	dev_dbg(aw_dev->dev, "start update %s", prof_name);
 
-	ret = aw88166_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
+	ret = aw_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
 	if (ret)
 		return ret;
 
 	/* update reg */
 	sec_desc = prof_index_desc->sec_desc;
-	ret = aw_dev_reg_update(aw88166, sec_desc[AW88395_DATA_TYPE_REG].data,
-					sec_desc[AW88395_DATA_TYPE_REG].len);
+	ret = aw88166_reg_update(aw88166, sec_desc[AW_DATA_TYPE_REG].data,
+					sec_desc[AW_DATA_TYPE_REG].len);
 	if (ret) {
 		dev_err(aw_dev->dev, "update reg failed\n");
 		return ret;
 	}
 
-	aw88166_dev_mute(aw_dev, true);
-
-	if (aw_dev->dsp_cfg == AW88166_DEV_DSP_WORK)
-		aw_dev_dsp_enable(aw_dev, false);
-
-	aw_dev_select_memclk(aw_dev, AW88166_DEV_MEMCLK_OSC);
-
-	ret = aw_dev_check_sram(aw_dev);
-	if (ret) {
-		dev_err(aw_dev->dev, "check sram failed\n");
-		goto error;
-	}
+	regmap_update_bits(aw_dev->regmap, AW88166_DBGCTRL_REG, ~AW88166_MEM_CLKSEL_MASK,
+					AW88166_MEM_CLKSEL_OSCCLK_VALUE);
 
 	aw_dev_backup_sec_recovery(aw88166);
 
 	if (up_dsp_fw_en) {
+		ret = aw88166_check_sram(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "check sram failed\n");
+			goto error;
+		}
+
 		dev_dbg(aw_dev->dev, "fw_ver: [%x]", prof_index_desc->fw_ver);
-		ret = aw_dev_dsp_update_fw(aw_dev, sec_desc[AW88395_DATA_TYPE_DSP_FW].data,
-					sec_desc[AW88395_DATA_TYPE_DSP_FW].len);
+		ret = aw_dev_dsp_update_fw(aw_dev, sec_desc[AW_DATA_TYPE_DSP_FW].data,
+					sec_desc[AW_DATA_TYPE_DSP_FW].len,
+					sec_desc[AW_DATA_TYPE_DSP_FW].addr);
 		if (ret) {
 			dev_err(aw_dev->dev, "update dsp fw failed\n");
 			goto error;
@@ -1241,23 +831,27 @@ static int aw88166_dev_fw_update(struct aw88166 *aw88166, bool up_dsp_fw_en, boo
 	}
 
 	/* update dsp config */
-	ret = aw_dev_dsp_update_cfg(aw_dev, sec_desc[AW88395_DATA_TYPE_DSP_CFG].data,
-					sec_desc[AW88395_DATA_TYPE_DSP_CFG].len);
+	ret = aw_dev_dsp_update_cfg(aw_dev, sec_desc[AW_DATA_TYPE_DSP_CFG].data,
+					sec_desc[AW_DATA_TYPE_DSP_CFG].len,
+					sec_desc[AW_DATA_TYPE_DSP_CFG].addr);
 	if (ret) {
 		dev_err(aw_dev->dev, "update dsp cfg failed\n");
 		goto error;
 	}
 
+	aw_dev_get_ra(aw_dev);
 	aw_dev_backup_sec_record(aw88166);
 
-	aw_dev_select_memclk(aw_dev, AW88166_DEV_MEMCLK_PLL);
+	regmap_update_bits(aw_dev->regmap, AW88166_DBGCTRL_REG, ~AW88166_MEM_CLKSEL_MASK,
+					AW88166_MEM_CLKSEL_DAPHCLK_VALUE);
 
 	aw_dev->prof_cur = aw_dev->prof_index;
 
 	return 0;
 
 error:
-	aw_dev_select_memclk(aw_dev, AW88166_DEV_MEMCLK_PLL);
+	regmap_update_bits(aw_dev->regmap, AW88166_DBGCTRL_REG, ~AW88166_MEM_CLKSEL_MASK,
+					AW88166_MEM_CLKSEL_DAPHCLK_VALUE);
 	return ret;
 }
 
@@ -1269,7 +863,7 @@ static void aw88166_start_pa(struct aw88166 *aw88166)
 		ret = aw88166_dev_start(aw88166);
 		if (ret) {
 			dev_err(aw88166->aw_pa->dev, "aw88166 device start failed. retry = %d", i);
-			ret = aw88166_dev_fw_update(aw88166, AW88166_DSP_FW_UPDATE_ON, true);
+			ret = aw88166_dev_fw_update(aw88166, AW_DSP_FW_UPDATE_ON, true);
 			if (ret) {
 				dev_err(aw88166->aw_pa->dev, "fw update failed");
 				continue;
@@ -1295,19 +889,19 @@ static void aw88166_start(struct aw88166 *aw88166, bool sync_start)
 {
 	int ret;
 
-	if (aw88166->aw_pa->fw_status != AW88166_DEV_FW_OK)
+	if (aw88166->aw_pa->fw_status != AW_DEV_FW_OK)
 		return;
 
-	if (aw88166->aw_pa->status == AW88166_DEV_PW_ON)
+	if (aw88166->aw_pa->status == AW_DEV_PW_ON)
 		return;
 
-	ret = aw88166_dev_fw_update(aw88166, AW88166_DSP_FW_UPDATE_OFF, aw88166->phase_sync);
+	ret = aw88166_dev_fw_update(aw88166, AW_DSP_FW_UPDATE_OFF, aw88166->phase_sync);
 	if (ret) {
 		dev_err(aw88166->aw_pa->dev, "fw update failed\n");
 		return;
 	}
 
-	if (sync_start == AW88166_SYNC_START)
+	if (sync_start == AW_SYNC_START)
 		aw88166_start_pa(aw88166);
 	else
 		queue_delayed_work(system_wq,
@@ -1331,38 +925,44 @@ static int aw_dev_check_sysint(struct aw_device *aw_dev)
 static int aw88166_stop(struct aw_device *aw_dev)
 {
 	struct aw_sec_data_desc *dsp_cfg =
-		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW88395_DATA_TYPE_DSP_CFG];
+		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW_DATA_TYPE_DSP_CFG];
 	struct aw_sec_data_desc *dsp_fw =
-		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW88395_DATA_TYPE_DSP_FW];
+		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW_DATA_TYPE_DSP_FW];
 	int int_st;
 
-	if (aw_dev->status == AW88166_DEV_PW_OFF) {
+	if (aw_dev->status == AW_DEV_PW_OFF) {
 		dev_dbg(aw_dev->dev, "already power off");
 		return 0;
 	}
 
-	aw_dev->status = AW88166_DEV_PW_OFF;
+	aw_dev->status = AW_DEV_PW_OFF;
 
 	aw88166_dev_mute(aw_dev, true);
-	usleep_range(AW88166_4000_US, AW88166_4000_US + 100);
+	usleep_range(AW_4000_US, AW_4000_US + 100);
 
-	aw_dev_i2s_tx_enable(aw_dev, false);
-	usleep_range(AW88166_1000_US, AW88166_1000_US + 100);
+	regmap_update_bits(aw_dev->regmap, AW88166_I2SCTRL3_REG,
+			~AW88166_I2STXEN_MASK, AW88166_I2STXEN_DISABLE_VALUE);
+	usleep_range(AW_1000_US, AW_1000_US + 100);
 
 	int_st = aw_dev_check_sysint(aw_dev);
 
-	aw_dev_dsp_enable(aw_dev, false);
+	regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
+			~AW88166_DSPBY_MASK, AW88166_DSPBY_BYPASS_VALUE);
 
-	aw_dev_amppd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
+			~AW88166_AMPPD_MASK, AW88166_AMPPD_POWER_DOWN_VALUE);
 
 	if (int_st) {
-		aw_dev_select_memclk(aw_dev, AW88166_DEV_MEMCLK_OSC);
-		aw_dev_dsp_update_fw(aw_dev, dsp_fw->data, dsp_fw->len);
-		aw_dev_dsp_update_cfg(aw_dev, dsp_cfg->data, dsp_cfg->len);
-		aw_dev_select_memclk(aw_dev, AW88166_DEV_MEMCLK_PLL);
+		regmap_update_bits(aw_dev->regmap, AW88166_DBGCTRL_REG, ~AW88166_MEM_CLKSEL_MASK,
+					AW88166_MEM_CLKSEL_OSCCLK_VALUE);
+		aw_dev_dsp_update_fw(aw_dev, dsp_fw->data, dsp_fw->len, dsp_fw->addr);
+		aw_dev_dsp_update_cfg(aw_dev, dsp_cfg->data, dsp_cfg->len, dsp_cfg->addr);
+		regmap_update_bits(aw_dev->regmap, AW88166_DBGCTRL_REG, ~AW88166_MEM_CLKSEL_MASK,
+					AW88166_MEM_CLKSEL_DAPHCLK_VALUE);
 	}
 
-	aw_dev_pwd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88166_SYSCTRL_REG,
+			~AW88166_PWDN_MASK, AW88166_PWDN_POWER_DOWN_VALUE);
 
 	return 0;
 }
@@ -1457,22 +1057,6 @@ static int aw88166_set_fade_out_time(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int aw88166_dev_set_profile_index(struct aw_device *aw_dev, int index)
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
-
 static int aw88166_profile_info(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_info *uinfo)
 {
@@ -1497,7 +1081,7 @@ static int aw88166_profile_info(struct snd_kcontrol *kcontrol,
 
 	count = uinfo->value.enumerated.item;
 
-	ret = aw88166_dev_get_prof_name(aw88166->aw_pa, count, &prof_name);
+	ret = aw_dev_get_prof_name(aw88166->aw_pa, count, &prof_name);
 	if (ret) {
 		strscpy(uinfo->value.enumerated.name, "null");
 		return 0;
@@ -1527,7 +1111,7 @@ static int aw88166_profile_set(struct snd_kcontrol *kcontrol,
 	int ret;
 
 	mutex_lock(&aw88166->lock);
-	ret = aw88166_dev_set_profile_index(aw88166->aw_pa, ucontrol->value.integer.value[0]);
+	ret = aw_dev_set_profile_index(aw88166->aw_pa, ucontrol->value.integer.value[0]);
 	if (ret) {
 		dev_dbg(codec->dev, "profile index does not change");
 		mutex_unlock(&aw88166->lock);
@@ -1536,7 +1120,7 @@ static int aw88166_profile_set(struct snd_kcontrol *kcontrol,
 
 	if (aw88166->aw_pa->status) {
 		aw88166_stop(aw88166->aw_pa);
-		aw88166_start(aw88166, AW88166_SYNC_START);
+		aw88166_start(aw88166, AW_SYNC_START);
 	}
 
 	mutex_unlock(&aw88166->lock);
@@ -1572,7 +1156,7 @@ static int aw88166_volume_set(struct snd_kcontrol *kcontrol,
 
 	if (vol_desc->ctl_volume != value) {
 		vol_desc->ctl_volume = value;
-		aw_dev_set_volume(aw88166->aw_pa, vol_desc->ctl_volume);
+		aw88166_set_volume(aw88166->aw_pa, vol_desc->ctl_volume);
 
 		return 1;
 	}
@@ -1646,86 +1230,6 @@ static int aw88166_re_set(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int aw88166_dev_init(struct aw88166 *aw88166, struct aw_container *aw_cfg)
-{
-	struct aw_device *aw_dev = aw88166->aw_pa;
-	int ret;
-
-	ret = aw88395_dev_cfg_load(aw_dev, aw_cfg);
-	if (ret) {
-		dev_err(aw_dev->dev, "aw_dev acf parse failed\n");
-		return -EINVAL;
-	}
-	aw_dev->fade_in_time = AW88166_1000_US / 10;
-	aw_dev->fade_out_time = AW88166_1000_US >> 1;
-	aw_dev->prof_cur = aw_dev->prof_info.prof_desc[0].id;
-	aw_dev->prof_index = aw_dev->prof_info.prof_desc[0].id;
-
-	ret = aw88166_dev_fw_update(aw88166, AW88166_FORCE_UPDATE_ON, AW88166_DSP_FW_UPDATE_ON);
-	if (ret) {
-		dev_err(aw_dev->dev, "fw update failed ret = %d\n", ret);
-		return ret;
-	}
-
-	aw88166_dev_mute(aw_dev, true);
-
-	/* close tx feedback */
-	aw_dev_i2s_tx_enable(aw_dev, false);
-	usleep_range(AW88166_1000_US, AW88166_1000_US + 100);
-
-	/* enable amppd */
-	aw_dev_amppd(aw_dev, true);
-
-	/* close dsp */
-	aw_dev_dsp_enable(aw_dev, false);
-	/* set power down */
-	aw_dev_pwd(aw_dev, true);
-
-	return 0;
-}
-
-static int aw88166_request_firmware_file(struct aw88166 *aw88166)
-{
-	const struct firmware *cont = NULL;
-	int ret;
-
-	aw88166->aw_pa->fw_status = AW88166_DEV_FW_FAILED;
-
-	ret = request_firmware(&cont, AW88166_ACF_FILE, aw88166->aw_pa->dev);
-	if (ret) {
-		dev_err(aw88166->aw_pa->dev, "request [%s] failed!\n", AW88166_ACF_FILE);
-		return ret;
-	}
-
-	dev_dbg(aw88166->aw_pa->dev, "loaded %s - size: %zu\n",
-			AW88166_ACF_FILE, cont ? cont->size : 0);
-
-	aw88166->aw_cfg = devm_kzalloc(aw88166->aw_pa->dev,
-			struct_size(aw88166->aw_cfg, data, cont->size), GFP_KERNEL);
-	if (!aw88166->aw_cfg) {
-		release_firmware(cont);
-		return -ENOMEM;
-	}
-	aw88166->aw_cfg->len = (int)cont->size;
-	memcpy(aw88166->aw_cfg->data, cont->data, cont->size);
-	release_firmware(cont);
-
-	ret = aw88395_dev_load_acf_check(aw88166->aw_pa, aw88166->aw_cfg);
-	if (ret) {
-		dev_err(aw88166->aw_pa->dev, "load [%s] failed!\n", AW88166_ACF_FILE);
-		return ret;
-	}
-
-	mutex_lock(&aw88166->lock);
-	/* aw device init */
-	ret = aw88166_dev_init(aw88166, aw88166->aw_cfg);
-	if (ret)
-		dev_err(aw88166->aw_pa->dev, "dev init failed\n");
-	mutex_unlock(&aw88166->lock);
-
-	return ret;
-}
-
 static const struct snd_kcontrol_new aw88166_controls[] = {
 	SOC_SINGLE_EXT("PCM Playback Volume", AW88166_SYSCTRL2_REG,
 		6, AW88166_MUTE_VOL, 0, aw88166_volume_get,
@@ -1738,7 +1242,7 @@ static const struct snd_kcontrol_new aw88166_controls[] = {
 		aw88166_get_fade_out_time, aw88166_set_fade_out_time),
 	SOC_SINGLE_EXT("Calib", 0, 0, AW88166_CALI_RE_MAX, 0,
 		aw88166_re_get, aw88166_re_set),
-	AW88166_PROFILE_EXT("AW88166 Profile Set", aw88166_profile_info,
+	AW_PROFILE_EXT("AW88166 Profile Set", aw88166_profile_info,
 		aw88166_profile_get, aw88166_profile_set),
 };
 
@@ -1751,7 +1255,7 @@ static int aw88166_playback_event(struct snd_soc_dapm_widget *w,
 	mutex_lock(&aw88166->lock);
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		aw88166_start(aw88166, AW88166_ASYNC_START);
+		aw88166_start(aw88166, AW_ASYNC_START);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		aw88166_stop(aw88166->aw_pa);
@@ -1788,9 +1292,15 @@ static int aw88166_codec_probe(struct snd_soc_component *component)
 
 	INIT_DELAYED_WORK(&aw88166->start_work, aw88166_startup_work);
 
-	ret = aw88166_request_firmware_file(aw88166);
-	if (ret)
+	ret = aw_dev_request_firmware_file(aw88166->aw_pa, AW88166_ACF_FILE);
+	if (ret) {
 		dev_err(aw88166->aw_pa->dev, "%s failed\n", __func__);
+		return ret;
+	}
+
+	ret = aw88166_dev_fw_update(aw88166, AW_FORCE_UPDATE_ON, AW_DSP_FW_UPDATE_ON);
+	if (ret)
+		dev_err(aw88166->aw_pa->dev, "fw update failed ret = %d\n", ret);
 
 	return ret;
 }
@@ -1813,65 +1323,6 @@ static const struct snd_soc_component_driver soc_codec_dev_aw88166 = {
 	.num_controls = ARRAY_SIZE(aw88166_controls),
 };
 
-static void aw88166_hw_reset(struct aw88166 *aw88166)
-{
-	if (aw88166->reset_gpio) {
-		gpiod_set_value_cansleep(aw88166->reset_gpio, 1);
-		usleep_range(AW88166_1000_US, AW88166_1000_US + 10);
-		gpiod_set_value_cansleep(aw88166->reset_gpio, 0);
-		usleep_range(AW88166_1000_US, AW88166_1000_US + 10);
-	}
-}
-
-static void aw88166_parse_channel_dt(struct aw88166 *aw88166)
-{
-	struct aw_device *aw_dev = aw88166->aw_pa;
-	struct device_node *np = aw_dev->dev->of_node;
-	u32 channel_value;
-
-	of_property_read_u32(np, "awinic,audio-channel", &channel_value);
-	aw_dev->channel = channel_value;
-	aw88166->phase_sync = of_property_read_bool(np, "awinic,sync-flag");
-}
-
-static int aw88166_init(struct aw88166 *aw88166, struct i2c_client *i2c, struct regmap *regmap)
-{
-	struct aw_device *aw_dev;
-	unsigned int chip_id;
-	int ret;
-
-	ret = regmap_read(regmap, AW88166_ID_REG, &chip_id);
-	if (ret) {
-		dev_err(&i2c->dev, "%s read chipid error. ret = %d\n", __func__, ret);
-		return ret;
-	}
-
-	aw_dev = devm_kzalloc(&i2c->dev, sizeof(*aw_dev), GFP_KERNEL);
-	if (!aw_dev)
-		return -ENOMEM;
-	aw88166->aw_pa = aw_dev;
-
-	aw_dev->i2c = i2c;
-	aw_dev->dev = &i2c->dev;
-	aw_dev->regmap = regmap;
-	mutex_init(&aw_dev->dsp_lock);
-
-	aw_dev->chip_id = chip_id;
-	aw_dev->acf = NULL;
-	aw_dev->prof_info.prof_desc = NULL;
-	aw_dev->prof_info.count = 0;
-	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
-	aw_dev->channel = AW88166_DEV_DEFAULT_CH;
-	aw_dev->fw_status = AW88166_DEV_FW_FAILED;
-
-	aw_dev->fade_step = AW88166_VOLUME_STEP_DB;
-	aw_dev->volume_desc.ctl_volume = AW88166_VOL_DEFAULT_VALUE;
-
-	aw88166_parse_channel_dt(aw88166);
-
-	return 0;
-}
-
 static int aw88166_i2c_probe(struct i2c_client *i2c)
 {
 	struct aw88166 *aw88166;
@@ -1888,11 +1339,15 @@ static int aw88166_i2c_probe(struct i2c_client *i2c)
 
 	i2c_set_clientdata(i2c, aw88166);
 
-	aw88166->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(aw88166->reset_gpio))
+	aw88166->aw_pa = devm_kzalloc(&i2c->dev, sizeof(struct aw_device), GFP_KERNEL);
+	if (!aw88166->aw_pa)
+		return -ENOMEM;
+
+	aw88166->aw_pa->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(aw88166->aw_pa->reset_gpio))
 		return dev_err_probe(&i2c->dev, PTR_ERR(aw88166->reset_gpio),
 							"reset gpio not defined\n");
-	aw88166_hw_reset(aw88166);
+	aw_hw_reset(aw88166->aw_pa);
 
 	aw88166->regmap = devm_regmap_init_i2c(i2c, &aw88166_remap_config);
 	if (IS_ERR(aw88166->regmap))
@@ -1900,7 +1355,7 @@ static int aw88166_i2c_probe(struct i2c_client *i2c)
 							"failed to init regmap\n");
 
 	/* aw pa init */
-	ret = aw88166_init(aw88166, i2c, aw88166->regmap);
+	ret = aw_dev_init(aw88166->aw_pa, i2c, aw88166->regmap);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/codecs/aw88166.h b/sound/soc/codecs/aw88166.h
index 3a53ba0ac625..3b90fdaf76b7 100644
--- a/sound/soc/codecs/aw88166.h
+++ b/sound/soc/codecs/aw88166.h
@@ -453,8 +453,6 @@
 #define AW88166_DEV_SYSST_CHECK_MAX		(10)
 #define AW88166_START_RETRIES			(5)
 #define AW88166_START_WORK_DELAY_MS		(0)
-#define FADE_TIME_MAX				100000
-#define FADE_TIME_MIN				0
 #define AW88166_CHIP_ID			(0x2066)
 #define AW88166_I2C_NAME			"aw88166"
 #define AW88166_ACF_FILE			"aw88166_acf.bin"
@@ -465,67 +463,11 @@
 			SNDRV_PCM_FMTBIT_S24_LE | \
 			SNDRV_PCM_FMTBIT_S32_LE)
 
-#define AW88166_PROFILE_EXT(xname, profile_info, profile_get, profile_set) \
-{ \
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name = xname, \
-	.info = profile_info, \
-	.get = profile_get, \
-	.put = profile_set, \
-}
-
 enum {
 	AW_EF_AND_CHECK = 0,
 	AW_EF_OR_CHECK,
 };
 
-enum {
-	AW88166_DSP_FW_UPDATE_OFF = 0,
-	AW88166_DSP_FW_UPDATE_ON = 1,
-};
-
-enum {
-	AW88166_FORCE_UPDATE_OFF = 0,
-	AW88166_FORCE_UPDATE_ON = 1,
-};
-
-enum {
-	AW88166_1000_US = 1000,
-	AW88166_2000_US = 2000,
-	AW88166_3000_US = 3000,
-	AW88166_4000_US = 4000,
-};
-
-enum AW88166_DEV_STATUS {
-	AW88166_DEV_PW_OFF = 0,
-	AW88166_DEV_PW_ON,
-};
-
-enum AW88166_DEV_FW_STATUS {
-	AW88166_DEV_FW_FAILED = 0,
-	AW88166_DEV_FW_OK,
-};
-
-enum AW88166_DEV_MEMCLK {
-	AW88166_DEV_MEMCLK_OSC = 0,
-	AW88166_DEV_MEMCLK_PLL = 1,
-};
-
-enum AW88166_DEV_DSP_CFG {
-	AW88166_DEV_DSP_WORK = 0,
-	AW88166_DEV_DSP_BYPASS = 1,
-};
-
-enum {
-	AW88166_DSP_16_DATA = 0,
-	AW88166_DSP_32_DATA = 1,
-};
-
-enum {
-	AW88166_SYNC_START = 0,
-	AW88166_ASYNC_START,
-};
-
 enum {
 	AW88166_RECORD_SEC_DATA = 0,
 	AW88166_RECOVERY_SEC_DATA = 1,
-- 
2.47.0


