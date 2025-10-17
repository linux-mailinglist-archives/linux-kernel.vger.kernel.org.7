Return-Path: <linux-kernel+bounces-857819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E96BE8022
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81838568862
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C3531064E;
	Fri, 17 Oct 2025 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b="grbbP0h0"
Received: from out198-24.us.a.mail.aliyun.com (out198-24.us.a.mail.aliyun.com [47.90.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCF63128D6;
	Fri, 17 Oct 2025 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695908; cv=none; b=MjaIm4377iZtnAr5hggtHVveKo5Xu7jKypQa7JwXG31OSRmkpjCQOgvUKgJsUw1azAGiI0pzi2VEL99AvU4e6jJnbwBsKoWPCWtunIJJr4uhDycYiNC5adjqG0Yji9Ke3gxW3dwEPFTh90dV76FJd7BbMNSYCK1EdY63Kb4rhnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695908; c=relaxed/simple;
	bh=4zkD37wO62AqS1GPwEREk04B2NJB5HgbW7SpNUITg20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMzdkySKPgnpumb9BAn0CyDzO93/zNTnbFJ2XCLAeZW3+T/Zt1qsE2/XXiG5ZScZv1SKnxGW6WPgJEo/Or5J6EVCjUzIknTQSQ58V4PkL+VYEjFKvRnwGD38iDYc8LfAlfVwun10htpZtCCtfxvPmPyTPCJR1TdiBXbuH7cf3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b=grbbP0h0; arc=none smtp.client-ip=47.90.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=awinic.com; s=default;
	t=1760695886; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=EUSr8dxXXq+zPy+Bqmz5d69jiFHJQtC+CUsIoFrsT+E=;
	b=grbbP0h0crFow4ulww71hJDuG47QtMU9IhH3+uFErgcjfjhZsvBqGDkWCMSfeKiQlapG5TZf9/lLvoObvFUaqCdXV9+D7vg46Fcg6W4Sgfo5WKykO6HNhjAWwp9rAkUUgRh4yHKR1luJEJBtxpKiGUp7u6vGVZWCRhxq5Arzgl3RcO6jotEn9A0VEhfehqELdySOeVss8QWhQLKKsXGDArm9yvjphmtTU60w54EiL0zX8SPvQnApIhFHZdz2WO36kqEouAEbGWZR8XULTlrveJhkRQNCS1kuO1J56tp6a4+yw6U+DUmX7tIq+lAZrXPpwXE5ji3jh2T7L8IS+jSEmA==
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.f0sBYHi_1760695883 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 18:11:24 +0800
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
Subject: [PATCH V2 7/7] ASoC: codecs: Rework the aw88399 driver
Date: Fri, 17 Oct 2025 18:11:05 +0800
Message-ID: <20251017101106.370742-8-wangweidong.a@awinic.com>
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

Modify the interface for calling the aw88399 driver
to adapt it for aw-common-device.c and aw-common-firmware.c

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88399.c | 1027 ++++++++----------------------------
 sound/soc/codecs/aw88399.h |   93 +---
 2 files changed, 218 insertions(+), 902 deletions(-)

diff --git a/sound/soc/codecs/aw88399.c b/sound/soc/codecs/aw88399.c
index 58846feb013d..bb781f486a56 100644
--- a/sound/soc/codecs/aw88399.c
+++ b/sound/soc/codecs/aw88399.c
@@ -11,12 +11,23 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/firmware.h>
-#include <linux/minmax.h>
 #include <linux/regmap.h>
-#include <linux/sort.h>
 #include <sound/soc.h>
+#include <linux/sort.h>
 #include "aw88399.h"
-#include "aw88395/aw88395_device.h"
+#include "aw-common-device.h"
+#include "aw-common-firmware.h"
+
+struct aw88399 {
+	struct aw_device *aw_pa;
+	struct mutex lock;
+	struct delayed_work start_work;
+	struct regmap *regmap;
+	unsigned int check_val;
+	unsigned int crc_init_val;
+	unsigned int vcalb_init_val;
+	unsigned int dither_st;
+};
 
 static const struct regmap_config aw88399_remap_config = {
 	.val_bits = 16,
@@ -26,214 +37,7 @@ static const struct regmap_config aw88399_remap_config = {
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 };
 
-static int aw_dev_dsp_write_16bit(struct aw_device *aw_dev,
-		unsigned short dsp_addr, unsigned int dsp_data)
-{
-	int ret;
-
-	ret = regmap_write(aw_dev->regmap, AW88399_DSPMADD_REG, dsp_addr);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write addr error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	ret = regmap_write(aw_dev->regmap, AW88399_DSPMDAT_REG, (u16)dsp_data);
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
-	unsigned int temp_data;
-	int ret;
-
-	ret = regmap_write(aw_dev->regmap, AW88399_DSPMADD_REG, dsp_addr);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write addr error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	temp_data = dsp_data & AW88395_DSP_16_DATA_MASK;
-	ret = regmap_write(aw_dev->regmap, AW88399_DSPMDAT_REG, temp_data);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write datal error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	temp_data = dsp_data >> 16;
-	ret = regmap_write(aw_dev->regmap, AW88399_DSPMDAT_REG, temp_data);
-	if (ret)
-		dev_err(aw_dev->dev, "%s write datah error, ret=%d", __func__, ret);
-
-	return ret;
-}
-
-static int aw_dev_dsp_write(struct aw_device *aw_dev,
-		unsigned short dsp_addr, unsigned int dsp_data, unsigned char data_type)
-{
-	unsigned int reg_value;
-	int ret;
-
-	mutex_lock(&aw_dev->dsp_lock);
-	switch (data_type) {
-	case AW88395_DSP_16_DATA:
-		ret = aw_dev_dsp_write_16bit(aw_dev, dsp_addr, dsp_data);
-		if (ret)
-			dev_err(aw_dev->dev, "write dsp_addr[0x%x] 16-bit dsp_data[0x%x] failed",
-					dsp_addr, dsp_data);
-		break;
-	case AW88395_DSP_32_DATA:
-		ret = aw_dev_dsp_write_32bit(aw_dev, dsp_addr, dsp_data);
-		if (ret)
-			dev_err(aw_dev->dev, "write dsp_addr[0x%x] 32-bit dsp_data[0x%x] failed",
-					dsp_addr, dsp_data);
-		break;
-	default:
-		dev_err(aw_dev->dev, "data type[%d] unsupported", data_type);
-		ret = -EINVAL;
-		break;
-	}
-
-	/* clear dsp chip select state */
-	if (regmap_read(aw_dev->regmap, 0x00, &reg_value))
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
-	ret = regmap_write(aw_dev->regmap, AW88399_DSPMADD_REG, dsp_addr);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	ret = regmap_read(aw_dev->regmap, AW88399_DSPMDAT_REG, &temp_data);
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
-	ret = regmap_write(aw_dev->regmap, AW88399_DSPMADD_REG, dsp_addr);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
-		return ret;
-	}
-
-	ret = regmap_read(aw_dev->regmap, AW88399_DSPMDAT_REG, &temp_data);
-	if (ret) {
-		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
-		return ret;
-	}
-	*dsp_data = temp_data;
-
-	ret = regmap_read(aw_dev->regmap, AW88399_DSPMDAT_REG, &temp_data);
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
-	case AW88399_DSP_16_DATA:
-		ret = aw_dev_dsp_read_16bit(aw_dev, dsp_addr, dsp_data);
-		if (ret)
-			dev_err(aw_dev->dev, "read dsp_addr[0x%x] 16-bit dsp_data[0x%x] failed",
-					(u32)dsp_addr, *dsp_data);
-		break;
-	case AW88399_DSP_32_DATA:
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
-	/* clear dsp chip select state */
-	if (regmap_read(aw_dev->regmap, AW88399_ID_REG, &reg_value))
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
-		ret = regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
-				~AW88399_PWDN_MASK, AW88399_PWDN_POWER_DOWN_VALUE);
-	else
-		ret = regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
-				~AW88399_PWDN_MASK, AW88399_PWDN_WORKING_VALUE);
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
-	ret = regmap_read(aw_dev->regmap, AW88399_SYSINT_REG, &reg_val);
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
-static int aw_dev_get_iis_status(struct aw_device *aw_dev)
+static int aw88399_get_iis_status(struct aw_device *aw_dev)
 {
 	unsigned int reg_val;
 	int ret;
@@ -249,15 +53,15 @@ static int aw_dev_get_iis_status(struct aw_device *aw_dev)
 	return 0;
 }
 
-static int aw_dev_check_mode1_pll(struct aw_device *aw_dev)
+static int aw88399_check_mode1_pll(struct aw_device *aw_dev)
 {
 	int ret, i;
 
 	for (i = 0; i < AW88399_DEV_SYSST_CHECK_MAX; i++) {
-		ret = aw_dev_get_iis_status(aw_dev);
+		ret = aw88399_get_iis_status(aw_dev);
 		if (ret) {
 			dev_err(aw_dev->dev, "mode1 iis signal check error");
-			usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
 		} else {
 			return 0;
 		}
@@ -266,7 +70,7 @@ static int aw_dev_check_mode1_pll(struct aw_device *aw_dev)
 	return -EPERM;
 }
 
-static int aw_dev_check_mode2_pll(struct aw_device *aw_dev)
+static int aw88399_check_mode2_pll(struct aw_device *aw_dev)
 {
 	unsigned int reg_val;
 	int ret, i;
@@ -288,10 +92,10 @@ static int aw_dev_check_mode2_pll(struct aw_device *aw_dev)
 		return ret;
 
 	for (i = 0; i < AW88399_DEV_SYSST_CHECK_MAX; i++) {
-		ret = aw_dev_get_iis_status(aw_dev);
+		ret = aw88399_get_iis_status(aw_dev);
 		if (ret) {
 			dev_err(aw_dev->dev, "mode2 iis signal check error");
-			usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
 		} else {
 			break;
 		}
@@ -301,12 +105,12 @@ static int aw_dev_check_mode2_pll(struct aw_device *aw_dev)
 	regmap_update_bits(aw_dev->regmap, AW88399_PLLCTRL2_REG,
 			~AW88399_CCO_MUX_MASK, AW88399_CCO_MUX_BYPASS_VALUE);
 	if (ret == 0) {
-		usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+		usleep_range(AW_2000_US, AW_2000_US + 10);
 		for (i = 0; i < AW88399_DEV_SYSST_CHECK_MAX; i++) {
-			ret = aw_dev_get_iis_status(aw_dev);
+			ret = aw88399_get_iis_status(aw_dev);
 			if (ret) {
 				dev_err(aw_dev->dev, "mode2 switch to mode1, iis signal check error");
-				usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+				usleep_range(AW_2000_US, AW_2000_US + 10);
 			} else {
 				break;
 			}
@@ -316,14 +120,14 @@ static int aw_dev_check_mode2_pll(struct aw_device *aw_dev)
 	return ret;
 }
 
-static int aw_dev_check_syspll(struct aw_device *aw_dev)
+static int aw88399_check_syspll(struct aw_device *aw_dev)
 {
 	int ret;
 
-	ret = aw_dev_check_mode1_pll(aw_dev);
+	ret = aw88399_check_mode1_pll(aw_dev);
 	if (ret) {
 		dev_dbg(aw_dev->dev, "mode1 check iis failed try switch to mode2 check");
-		ret = aw_dev_check_mode2_pll(aw_dev);
+		ret = aw88399_check_mode2_pll(aw_dev);
 		if (ret) {
 			dev_err(aw_dev->dev, "mode2 check iis failed");
 			return ret;
@@ -333,7 +137,7 @@ static int aw_dev_check_syspll(struct aw_device *aw_dev)
 	return 0;
 }
 
-static int aw_dev_check_sysst(struct aw_device *aw_dev)
+static int aw88399_check_sysst(struct aw_device *aw_dev)
 {
 	unsigned int check_val;
 	unsigned int reg_val;
@@ -356,7 +160,7 @@ static int aw_dev_check_sysst(struct aw_device *aw_dev)
 		if ((reg_val & (~AW88399_BIT_SYSST_CHECK_MASK) & check_val) != check_val) {
 			dev_err(aw_dev->dev, "check sysst fail, cnt=%d, reg_val=0x%04x, check:0x%x",
 				i, reg_val, AW88399_BIT_SYSST_NOSWS_CHECK);
-			usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
 		} else {
 			return 0;
 		}
@@ -365,36 +169,6 @@ static int aw_dev_check_sysst(struct aw_device *aw_dev)
 	return -EPERM;
 }
 
-static void aw_dev_amppd(struct aw_device *aw_dev, bool amppd)
-{
-	int ret;
-
-	if (amppd)
-		ret = regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
-				~AW88399_AMPPD_MASK, AW88399_AMPPD_POWER_DOWN_VALUE);
-	else
-		ret = regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
-				~AW88399_AMPPD_MASK, AW88399_AMPPD_WORKING_VALUE);
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
-		ret = regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
-					~AW88399_DSPBY_MASK, AW88399_DSPBY_WORKING_VALUE);
-	else
-		ret = regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
-					~AW88399_DSPBY_MASK, AW88399_DSPBY_BYPASS_VALUE);
-
-	if (ret)
-		dev_dbg(aw_dev->dev, "%s failed\n", __func__);
-}
-
 static int aw88399_dev_get_icalk(struct aw88399 *aw88399, int16_t *icalk)
 {
 	uint16_t icalkh_val, icalkl_val, icalk_val;
@@ -487,7 +261,7 @@ static int aw88399_dev_get_internal_vcalk(struct aw88399 *aw88399, int16_t *vcal
 	return 0;
 }
 
-static int aw_dev_set_vcalb(struct aw88399 *aw88399)
+static int aw88399_set_vcalb(struct aw88399 *aw88399)
 {
 	struct aw_device *aw_dev = aw88399->aw_pa;
 	unsigned int vsense_select, vsense_value;
@@ -540,7 +314,7 @@ static int aw_dev_set_vcalb(struct aw88399 *aw88399)
 	return 0;
 }
 
-static int aw_dev_update_cali_re(struct aw_cali_desc *cali_desc)
+static int aw88399_update_cali_re(struct aw_cali_desc *cali_desc)
 {
 	struct aw_device *aw_dev =
 		container_of(cali_desc, struct aw_device, cali_desc);
@@ -571,7 +345,7 @@ static int aw_dev_update_cali_re(struct aw_cali_desc *cali_desc)
 	return ret;
 }
 
-static int aw_dev_fw_crc_check(struct aw_device *aw_dev)
+static int aw88399_fw_crc_check(struct aw_device *aw_dev)
 {
 	uint16_t check_val, fw_len_val;
 	unsigned int reg_val;
@@ -589,7 +363,7 @@ static int aw_dev_fw_crc_check(struct aw_device *aw_dev)
 	ret = regmap_update_bits(aw_dev->regmap, AW88399_CRCCTRL_REG,
 		~AW88399_CRC_CODE_EN_MASK, AW88399_CRC_CODE_EN_ENABLE_VALUE);
 
-	usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+	usleep_range(AW_2000_US, AW_2000_US + 10);
 
 	/* read crc check result */
 	regmap_read(aw_dev->regmap, AW88399_HAGCST_REG, &reg_val);
@@ -613,7 +387,7 @@ static int aw_dev_fw_crc_check(struct aw_device *aw_dev)
 	return ret;
 }
 
-static int aw_dev_cfg_crc_check(struct aw_device *aw_dev)
+static int aw88399_cfg_crc_check(struct aw_device *aw_dev)
 {
 	uint16_t check_val, cfg_len_val;
 	unsigned int reg_val;
@@ -634,7 +408,7 @@ static int aw_dev_cfg_crc_check(struct aw_device *aw_dev)
 	if (ret)
 		return ret;
 
-	usleep_range(AW88399_1000_US, AW88399_1000_US + 10);
+	usleep_range(AW_1000_US, AW_1000_US + 10);
 
 	/* read crc check result */
 	ret = regmap_read(aw_dev->regmap, AW88399_HAGCST_REG, &reg_val);
@@ -658,7 +432,7 @@ static int aw_dev_cfg_crc_check(struct aw_device *aw_dev)
 	return ret;
 }
 
-static int aw_dev_hw_crc_check(struct aw88399 *aw88399)
+static int aw88399_hw_crc_check(struct aw88399 *aw88399)
 {
 	struct aw_device *aw_dev = aw88399->aw_pa;
 	int ret;
@@ -668,13 +442,13 @@ static int aw_dev_hw_crc_check(struct aw88399 *aw88399)
 	if (ret)
 		return ret;
 
-	ret = aw_dev_fw_crc_check(aw_dev);
+	ret = aw88399_fw_crc_check(aw_dev);
 	if (ret) {
 		dev_err(aw_dev->dev, "fw_crc_check failed\n");
 		goto crc_check_failed;
 	}
 
-	ret = aw_dev_cfg_crc_check(aw_dev);
+	ret = aw88399_cfg_crc_check(aw_dev);
 	if (ret) {
 		dev_err(aw_dev->dev, "cfg_crc_check failed\n");
 		goto crc_check_failed;
@@ -695,199 +469,104 @@ static int aw_dev_hw_crc_check(struct aw88399 *aw88399)
 	return ret;
 }
 
-static void aw_dev_i2s_tx_enable(struct aw_device *aw_dev, bool flag)
-{
-	int ret;
-
-	if (flag)
-		ret = regmap_update_bits(aw_dev->regmap, AW88399_I2SCTRL3_REG,
-			~AW88399_I2STXEN_MASK, AW88399_I2STXEN_ENABLE_VALUE);
-	else
-		ret = regmap_update_bits(aw_dev->regmap, AW88399_I2SCFG1_REG,
-			~AW88399_I2STXEN_MASK, AW88399_I2STXEN_DISABLE_VALUE);
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
-	ret = regmap_read(aw_dev->regmap, AW88399_WDT_REG, &reg_val);
-	if (ret)
-		return ret;
-	if (!(reg_val & (~AW88399_WDT_CNT_MASK)))
-		return -EPERM;
-
-	return 0;
-}
-
-static int aw_dev_dsp_check(struct aw_device *aw_dev)
+static int aw88399_dsp_check(struct aw_device *aw_dev)
 {
 	int ret, i;
 
-	switch (aw_dev->dsp_cfg) {
-	case AW88399_DEV_DSP_BYPASS:
-		dev_dbg(aw_dev->dev, "dsp bypass");
-		ret = 0;
-		break;
-	case AW88399_DEV_DSP_WORK:
-		aw_dev_dsp_enable(aw_dev, false);
-		aw_dev_dsp_enable(aw_dev, true);
-		usleep_range(AW88399_1000_US, AW88399_1000_US + 10);
-		for (i = 0; i < AW88399_DEV_DSP_CHECK_MAX; i++) {
-			ret = aw_dev_get_dsp_status(aw_dev);
-			if (ret) {
-				dev_err(aw_dev->dev, "dsp wdt status error=%d", ret);
-				usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
-			}
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+					~AW88399_DSPBY_MASK, AW88399_DSPBY_BYPASS_VALUE);
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+					~AW88399_DSPBY_MASK, AW88399_DSPBY_WORKING_VALUE);
+	usleep_range(AW_1000_US, AW_1000_US + 10);
+	for (i = 0; i < AW88399_DEV_DSP_CHECK_MAX; i++) {
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
+static void aw88399_set_volume(struct aw_device *aw_dev, unsigned int value)
 {
 	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
 	unsigned int reg_value;
 	u16 real_value;
-	int ret;
 
 	real_value = min((value + vol_desc->init_volume), (unsigned int)AW88399_MUTE_VOL);
 
-	ret = regmap_read(aw_dev->regmap, AW88399_SYSCTRL2_REG, &reg_value);
-	if (ret)
-		return ret;
+	regmap_read(aw_dev->regmap, AW88399_SYSCTRL2_REG, &reg_value);
 
 	dev_dbg(aw_dev->dev, "value 0x%x , reg:0x%x", value, real_value);
 
 	real_value = (real_value << AW88399_VOL_START_BIT) | (reg_value & AW88399_VOL_MASK);
 
-	ret = regmap_write(aw_dev->regmap, AW88399_SYSCTRL2_REG, real_value);
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
-	for (i = AW88399_MUTE_VOL; i >= fade_in_vol; i -= fade_step) {
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
-		aw_dev_set_volume(aw_dev, AW88399_MUTE_VOL);
-		return;
-	}
-
-	for (i = desc->ctl_volume; i <= AW88399_MUTE_VOL; i += fade_step) {
-		aw_dev_set_volume(aw_dev, i);
-		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
-	}
-
-	if (i != AW88399_MUTE_VOL) {
-		aw_dev_set_volume(aw_dev, AW88399_MUTE_VOL);
-		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
-	}
+	regmap_write(aw_dev->regmap, AW88399_SYSCTRL2_REG, real_value);
 }
 
 static void aw88399_dev_mute(struct aw_device *aw_dev, bool is_mute)
 {
 	if (is_mute) {
-		aw_dev_fade_out(aw_dev);
+		aw_dev_fade_out(aw_dev, aw88399_set_volume);
 		regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
 				~AW88399_HMUTE_MASK, AW88399_HMUTE_ENABLE_VALUE);
 	} else {
 		regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
 				~AW88399_HMUTE_MASK, AW88399_HMUTE_DISABLE_VALUE);
-		aw_dev_fade_in(aw_dev);
+		aw_dev_fade_in(aw_dev, aw88399_set_volume);
 	}
 }
 
-static void aw88399_dev_set_dither(struct aw88399 *aw88399, bool dither)
-{
-	struct aw_device *aw_dev = aw88399->aw_pa;
-
-	if (dither)
-		regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
-				~AW88399_DITHER_EN_MASK, AW88399_DITHER_EN_ENABLE_VALUE);
-	else
-		regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
-				~AW88399_DITHER_EN_MASK, AW88399_DITHER_EN_DISABLE_VALUE);
-}
-
 static int aw88399_dev_start(struct aw88399 *aw88399)
 {
 	struct aw_device *aw_dev = aw88399->aw_pa;
 	int ret;
 
-	if (aw_dev->status == AW88399_DEV_PW_ON) {
+	if (aw_dev->status == AW_DEV_PW_ON) {
 		dev_dbg(aw_dev->dev, "already power on");
 		return 0;
 	}
 
-	aw88399_dev_set_dither(aw88399, false);
+	regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
+			~AW88399_DITHER_EN_MASK, AW88399_DITHER_EN_DISABLE_VALUE);
 
 	/* power on */
-	aw_dev_pwd(aw_dev, false);
-	usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+			~AW88399_PWDN_MASK, AW88399_PWDN_WORKING_VALUE);
+	usleep_range(AW_2000_US, AW_2000_US + 10);
 
-	ret = aw_dev_check_syspll(aw_dev);
+	ret = aw88399_check_syspll(aw_dev);
 	if (ret) {
 		dev_err(aw_dev->dev, "pll check failed cannot start");
 		goto pll_check_fail;
 	}
 
 	/* amppd on */
-	aw_dev_amppd(aw_dev, false);
-	usleep_range(AW88399_1000_US, AW88399_1000_US + 50);
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+			~AW88399_PWDN_MASK, AW88399_PWDN_WORKING_VALUE);
+	usleep_range(AW_1000_US, AW_1000_US + 50);
 
 	/* check i2s status */
-	ret = aw_dev_check_sysst(aw_dev);
+	ret = aw88399_check_sysst(aw_dev);
 	if (ret) {
 		dev_err(aw_dev->dev, "sysst check failed");
 		goto sysst_check_fail;
 	}
 
-	if (aw_dev->dsp_cfg == AW88399_DEV_DSP_WORK) {
-		ret = aw_dev_hw_crc_check(aw88399);
+	if (aw_dev->dsp_cfg == AW_DEV_DSP_WORK) {
+		ret = aw88399_hw_crc_check(aw88399);
 		if (ret) {
 			dev_err(aw_dev->dev, "dsp crc check failed");
 			goto crc_check_fail;
 		}
-		aw_dev_dsp_enable(aw_dev, false);
-		aw_dev_set_vcalb(aw88399);
-		aw_dev_update_cali_re(&aw_dev->cali_desc);
+		regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+				~AW88399_DSPBY_MASK, AW88399_DSPBY_BYPASS_VALUE);
+		aw88399_set_vcalb(aw88399);
+		aw88399_update_cali_re(&aw_dev->cali_desc);
 
-		ret = aw_dev_dsp_check(aw_dev);
+		ret = aw88399_dsp_check(aw_dev);
 		if (ret) {
 			dev_err(aw_dev->dev, "dsp status check failed");
 			goto dsp_check_fail;
@@ -897,127 +576,61 @@ static int aw88399_dev_start(struct aw88399 *aw88399)
 	}
 
 	/* enable tx feedback */
-	aw_dev_i2s_tx_enable(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88399_I2SCTRL3_REG,
+			~AW88399_I2STXEN_MASK, AW88399_I2STXEN_ENABLE_VALUE);
 
 	if (aw88399->dither_st == AW88399_DITHER_EN_ENABLE_VALUE)
-		aw88399_dev_set_dither(aw88399, true);
+		regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
+			~AW88399_DITHER_EN_MASK, AW88399_DITHER_EN_ENABLE_VALUE);
 
 	/* close mute */
 	aw88399_dev_mute(aw_dev, false);
 	/* clear inturrupt */
 	aw_dev_clear_int_status(aw_dev);
-	aw_dev->status = AW88399_DEV_PW_ON;
+	aw_dev->status = AW_DEV_PW_ON;
 
 	return 0;
 
 dsp_check_fail:
 crc_check_fail:
-	aw_dev_dsp_enable(aw_dev, false);
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+			~AW88399_DSPBY_MASK, AW88399_DSPBY_BYPASS_VALUE);
 sysst_check_fail:
 	aw_dev_clear_int_status(aw_dev);
-	aw_dev_amppd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+			~AW88399_AMPPD_MASK, AW88399_AMPPD_POWER_DOWN_VALUE);
 pll_check_fail:
-	aw_dev_pwd(aw_dev, true);
-	aw_dev->status = AW88399_DEV_PW_OFF;
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+			~AW88399_PWDN_MASK, AW88399_PWDN_POWER_DOWN_VALUE);
+	aw_dev->status = AW_DEV_PW_OFF;
 
 	return ret;
 }
 
-static int aw_dev_dsp_update_container(struct aw_device *aw_dev,
-			unsigned char *data, unsigned int len, unsigned short base)
+static int aw88399_get_ra(struct aw_device *aw_dev)
 {
-	u32 tmp_len;
-	int i, ret;
-
-	mutex_lock(&aw_dev->dsp_lock);
-	ret = regmap_write(aw_dev->regmap, AW88399_DSPMADD_REG, base);
-	if (ret)
-		goto error_operation;
-
-	for (i = 0; i < len; i += AW88399_MAX_RAM_WRITE_BYTE_SIZE) {
-		tmp_len = min(len - i, AW88399_MAX_RAM_WRITE_BYTE_SIZE);
-		ret = regmap_raw_write(aw_dev->regmap, AW88399_DSPMDAT_REG,
-					&data[i], tmp_len);
-		if (ret)
-			goto error_operation;
-	}
-	mutex_unlock(&aw_dev->dsp_lock);
-
-	return 0;
-
-error_operation:
-	mutex_unlock(&aw_dev->dsp_lock);
-	return ret;
-}
-
-static int aw_dev_get_ra(struct aw_cali_desc *cali_desc)
-{
-	struct aw_device *aw_dev =
-		container_of(cali_desc, struct aw_device, cali_desc);
+	struct aw_cali_desc *cali_desc = &aw_dev->cali_desc;
 	u32 dsp_ra;
 	int ret;
 
 	ret = aw_dev_dsp_read(aw_dev, AW88399_DSP_REG_CFG_ADPZ_RA,
-				&dsp_ra, AW88399_DSP_32_DATA);
+				&dsp_ra, AW_DSP_32_DATA);
 	if (ret) {
 		dev_err(aw_dev->dev, "read ra error");
 		return ret;
 	}
 
-	cali_desc->ra = AW88399_DSP_RE_TO_SHOW_RE(dsp_ra,
-					AW88399_DSP_RE_SHIFT);
+	cali_desc->ra = AW88399_DSP_RE_TO_SHOW_RE(dsp_ra, AW88399_DSP_RE_SHIFT);
 
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
-		dev_err(aw_dev->dev, "dsp config data is null or len is 0");
-		return -EINVAL;
-	}
-
-	ret = aw_dev_dsp_update_container(aw_dev, data, len, AW88399_DSP_CFG_ADDR);
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
-		dev_err(aw_dev->dev, "dsp firmware data is null or len is 0");
-		return -EINVAL;
-	}
-
-	aw_dev->dsp_fw_len = len;
-	ret = aw_dev_dsp_update_container(aw_dev, data, len, AW88399_DSP_FW_ADDR);
-
-	return ret;
-}
-
-static int aw_dev_check_sram(struct aw_device *aw_dev)
+static int aw88399_check_sram(struct aw_device *aw_dev)
 {
 	unsigned int reg_val;
 
-	mutex_lock(&aw_dev->dsp_lock);
 	/* read dsp_rom_check_reg */
-	aw_dev_dsp_read_16bit(aw_dev, AW88399_DSP_ROM_CHECK_ADDR, &reg_val);
+	aw_dev_dsp_read(aw_dev, AW88399_DSP_ROM_CHECK_ADDR, &reg_val, AW_DSP_16_DATA);
 	if (reg_val != AW88399_DSP_ROM_CHECK_DATA) {
 		dev_err(aw_dev->dev, "check dsp rom failed, read[0x%x] != check[0x%x]",
 						reg_val, AW88399_DSP_ROM_CHECK_DATA);
@@ -1025,64 +638,22 @@ static int aw_dev_check_sram(struct aw_device *aw_dev)
 	}
 
 	/* check dsp_cfg_base_addr */
-	aw_dev_dsp_write_16bit(aw_dev, AW88399_DSP_CFG_ADDR, AW88399_DSP_ODD_NUM_BIT_TEST);
-	aw_dev_dsp_read_16bit(aw_dev, AW88399_DSP_CFG_ADDR, &reg_val);
+	aw_dev_dsp_write(aw_dev, AW88399_DSP_CFG_ADDR,
+				AW88399_DSP_ODD_NUM_BIT_TEST, AW_DSP_16_DATA);
+	aw_dev_dsp_read(aw_dev, AW88399_DSP_CFG_ADDR, &reg_val, AW_DSP_16_DATA);
 	if (reg_val != AW88399_DSP_ODD_NUM_BIT_TEST) {
 		dev_err(aw_dev->dev, "check dsp cfg failed, read[0x%x] != write[0x%x]",
 						reg_val, AW88399_DSP_ODD_NUM_BIT_TEST);
 		goto error;
 	}
-	mutex_unlock(&aw_dev->dsp_lock);
 
 	return 0;
+
 error:
-	mutex_unlock(&aw_dev->dsp_lock);
 	return -EPERM;
 }
 
-static void aw_dev_select_memclk(struct aw_device *aw_dev, unsigned char flag)
-{
-	int ret;
-
-	switch (flag) {
-	case AW88399_DEV_MEMCLK_PLL:
-		ret = regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
-					~AW88399_MEM_CLKSEL_MASK,
-					AW88399_MEM_CLKSEL_DAPHCLK_VALUE);
-		if (ret)
-			dev_err(aw_dev->dev, "memclk select pll failed");
-		break;
-	case AW88399_DEV_MEMCLK_OSC:
-		ret = regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
-					~AW88399_MEM_CLKSEL_MASK,
-					AW88399_MEM_CLKSEL_OSCCLK_VALUE);
-		if (ret)
-			dev_err(aw_dev->dev, "memclk select OSC failed");
-		break;
-	default:
-		dev_err(aw_dev->dev, "unknown memclk config, flag=0x%x", flag);
-		break;
-	}
-}
-
-static void aw_dev_get_cur_mode_st(struct aw_device *aw_dev)
-{
-	struct aw_profctrl_desc *profctrl_desc = &aw_dev->profctrl_desc;
-	unsigned int reg_val;
-	int ret;
-
-	ret = regmap_read(aw_dev->regmap, AW88399_SYSCTRL_REG, &reg_val);
-	if (ret) {
-		dev_dbg(aw_dev->dev, "%s failed", __func__);
-		return;
-	}
-	if ((reg_val & (~AW88399_RCV_MODE_MASK)) == AW88399_RCV_MODE_RECEIVER_VALUE)
-		profctrl_desc->cur_mode = AW88399_RCV_MODE;
-	else
-		profctrl_desc->cur_mode = AW88399_NOT_RCV_MODE;
-}
-
-static int aw_dev_update_reg_container(struct aw88399 *aw88399,
+static int aw88399_reg_update(struct aw88399 *aw88399,
 				unsigned char *data, unsigned int len)
 {
 	struct aw_device *aw_dev = aw88399->aw_pa;
@@ -1111,9 +682,9 @@ static int aw_dev_update_reg_container(struct aw88399 *aw88399,
 
 		if (reg_addr == AW88399_SYSCTRL_REG) {
 			if (reg_val & (~AW88399_DSPBY_MASK))
-				aw_dev->dsp_cfg = AW88399_DEV_DSP_BYPASS;
+				aw_dev->dsp_cfg = AW_DEV_DSP_BYPASS;
 			else
-				aw_dev->dsp_cfg = AW88399_DEV_DSP_WORK;
+				aw_dev->dsp_cfg = AW_DEV_DSP_WORK;
 
 			reg_val &= (AW88399_HMUTE_MASK | AW88399_PWDN_MASK |
 						AW88399_DSPBY_MASK);
@@ -1136,7 +707,7 @@ static int aw_dev_update_reg_container(struct aw88399 *aw88399,
 			if ((reg_val & (~AW88399_EF_DBMD_MASK)) == AW88399_EF_DBMD_OR_VALUE)
 				aw88399->check_val = AW_EF_OR_CHECK;
 			else
-				aw88399->check_val = AW_EF_AND_CHECK;
+				aw88399->check_val  = AW_EF_AND_CHECK;
 
 			aw88399->dither_st = reg_val & (~AW88399_DITHER_EN_MASK);
 		}
@@ -1149,69 +720,17 @@ static int aw_dev_update_reg_container(struct aw88399 *aw88399,
 			return ret;
 	}
 
-	aw_dev_pwd(aw_dev, false);
-	usleep_range(AW88399_1000_US, AW88399_1000_US + 10);
-
-	aw_dev_get_cur_mode_st(aw_dev);
+	usleep_range(AW_1000_US, AW_1000_US + 10);
 
 	if (aw_dev->prof_cur != aw_dev->prof_index)
 		vol_desc->ctl_volume = 0;
 	else
-		aw_dev_set_volume(aw_dev, vol_desc->ctl_volume);
-
-	return 0;
-}
-
-static int aw_dev_reg_update(struct aw88399 *aw88399,
-					unsigned char *data, unsigned int len)
-{
-	int ret;
-
-	if (!len || !data) {
-		dev_err(aw88399->aw_pa->dev, "reg data is null or len is 0");
-		return -EINVAL;
-	}
-
-	ret = aw_dev_update_reg_container(aw88399, data, len);
-	if (ret)
-		dev_err(aw88399->aw_pa->dev, "reg update failed");
-
-	return ret;
-}
-
-static int aw88399_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name)
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
-
-static int aw88399_dev_get_prof_data(struct aw_device *aw_dev, int index,
-			struct aw_prof_desc **prof_desc)
-{
-	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
-		dev_err(aw_dev->dev, "%s: index[%d] overflow count[%d]\n",
-				__func__, index, aw_dev->prof_info.count);
-		return -EINVAL;
-	}
-
-	*prof_desc = &aw_dev->prof_info.prof_desc[index];
+		aw88399_set_volume(aw_dev, vol_desc->ctl_volume);
 
 	return 0;
 }
 
-static int aw88399_dev_fw_update(struct aw88399 *aw88399, bool up_dsp_fw_en, bool force_up_en)
+static int aw88399_fw_update(struct aw88399 *aw88399, bool up_dsp_fw_en, bool force_up_en)
 {
 	struct aw_device *aw_dev = aw88399->aw_pa;
 	struct aw_prof_desc *prof_index_desc;
@@ -1220,52 +739,52 @@ static int aw88399_dev_fw_update(struct aw88399 *aw88399, bool up_dsp_fw_en, boo
 	int ret;
 
 	if ((aw_dev->prof_cur == aw_dev->prof_index) &&
-			(force_up_en == AW88399_FORCE_UPDATE_OFF)) {
+			(force_up_en == AW_FORCE_UPDATE_OFF)) {
 		dev_dbg(aw_dev->dev, "scene no change, not update");
 		return 0;
 	}
 
-	if (aw_dev->fw_status == AW88399_DEV_FW_FAILED) {
+	if (aw_dev->fw_status == AW_DEV_FW_FAILED) {
 		dev_err(aw_dev->dev, "fw status[%d] error", aw_dev->fw_status);
 		return -EPERM;
 	}
 
-	ret = aw88399_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
+	ret = aw_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
 	if (ret)
 		return ret;
 
 	dev_dbg(aw_dev->dev, "start update %s", prof_name);
 
-	ret = aw88399_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
+	ret = aw_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
 	if (ret)
 		return ret;
 
 	/* update reg */
 	sec_desc = prof_index_desc->sec_desc;
-	ret = aw_dev_reg_update(aw88399, sec_desc[AW88395_DATA_TYPE_REG].data,
-					sec_desc[AW88395_DATA_TYPE_REG].len);
+	ret = aw88399_reg_update(aw88399, sec_desc[AW_DATA_TYPE_REG].data,
+					sec_desc[AW_DATA_TYPE_REG].len);
 	if (ret) {
 		dev_err(aw_dev->dev, "update reg failed");
 		return ret;
 	}
 
-	aw88399_dev_mute(aw_dev, true);
-
-	if (aw_dev->dsp_cfg == AW88399_DEV_DSP_WORK)
-		aw_dev_dsp_enable(aw_dev, false);
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+			~AW88399_PWDN_MASK, AW88399_PWDN_WORKING_VALUE);
 
-	aw_dev_select_memclk(aw_dev, AW88399_DEV_MEMCLK_OSC);
-
-	ret = aw_dev_check_sram(aw_dev);
-	if (ret) {
-		dev_err(aw_dev->dev, "check sram failed");
-		goto error;
-	}
+	regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
+			~AW88399_MEM_CLKSEL_MASK, AW88399_MEM_CLKSEL_OSCCLK_VALUE);
 
 	if (up_dsp_fw_en) {
+		ret = aw88399_check_sram(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "check sram failed");
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
 			dev_err(aw_dev->dev, "update dsp fw failed");
 			goto error;
@@ -1273,21 +792,25 @@ static int aw88399_dev_fw_update(struct aw88399 *aw88399, bool up_dsp_fw_en, boo
 	}
 
 	/* update dsp config */
-	ret = aw_dev_dsp_update_cfg(aw_dev, sec_desc[AW88395_DATA_TYPE_DSP_CFG].data,
-					sec_desc[AW88395_DATA_TYPE_DSP_CFG].len);
+	ret = aw_dev_dsp_update_cfg(aw_dev, sec_desc[AW_DATA_TYPE_DSP_CFG].data,
+					sec_desc[AW_DATA_TYPE_DSP_CFG].len,
+					sec_desc[AW_DATA_TYPE_DSP_CFG].addr);
 	if (ret) {
 		dev_err(aw_dev->dev, "update dsp cfg failed");
 		goto error;
 	}
 
-	aw_dev_select_memclk(aw_dev, AW88399_DEV_MEMCLK_PLL);
+	aw88399_get_ra(aw_dev);
+	regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
+			~AW88399_MEM_CLKSEL_MASK, AW88399_MEM_CLKSEL_DAPHCLK_VALUE);
 
 	aw_dev->prof_cur = aw_dev->prof_index;
 
 	return 0;
 
 error:
-	aw_dev_select_memclk(aw_dev, AW88399_DEV_MEMCLK_PLL);
+	regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
+			~AW88399_MEM_CLKSEL_MASK, AW88399_MEM_CLKSEL_DAPHCLK_VALUE);
 	return ret;
 }
 
@@ -1299,7 +822,7 @@ static void aw88399_start_pa(struct aw88399 *aw88399)
 		ret = aw88399_dev_start(aw88399);
 		if (ret) {
 			dev_err(aw88399->aw_pa->dev, "aw88399 device start failed. retry = %d", i);
-			ret = aw88399_dev_fw_update(aw88399, AW88399_DSP_FW_UPDATE_ON, true);
+			ret = aw88399_fw_update(aw88399, AW_DSP_FW_UPDATE_ON, true);
 			if (ret) {
 				dev_err(aw88399->aw_pa->dev, "fw update failed");
 				continue;
@@ -1325,27 +848,27 @@ static void aw88399_start(struct aw88399 *aw88399, bool sync_start)
 {
 	int ret;
 
-	if (aw88399->aw_pa->fw_status != AW88399_DEV_FW_OK)
+	if (aw88399->aw_pa->fw_status != AW_DEV_FW_OK)
 		return;
 
-	if (aw88399->aw_pa->status == AW88399_DEV_PW_ON)
+	if (aw88399->aw_pa->status == AW_DEV_PW_ON)
 		return;
 
-	ret = aw88399_dev_fw_update(aw88399, AW88399_DSP_FW_UPDATE_OFF, true);
+	ret = aw88399_fw_update(aw88399, AW_DSP_FW_UPDATE_OFF,
+						aw88399->aw_pa->phase_sync);
 	if (ret) {
 		dev_err(aw88399->aw_pa->dev, "fw update failed.");
 		return;
 	}
 
-	if (sync_start == AW88399_SYNC_START)
+	if (sync_start == AW_SYNC_START)
 		aw88399_start_pa(aw88399);
 	else
 		queue_delayed_work(system_wq,
-			&aw88399->start_work,
-			AW88399_START_WORK_DELAY_MS);
+			&aw88399->start_work, AW88399_START_WORK_DELAY_MS);
 }
 
-static int aw_dev_check_sysint(struct aw_device *aw_dev)
+static int aw88399_check_sysint(struct aw_device *aw_dev)
 {
 	u16 reg_val;
 
@@ -1361,38 +884,44 @@ static int aw_dev_check_sysint(struct aw_device *aw_dev)
 static int aw88399_stop(struct aw_device *aw_dev)
 {
 	struct aw_sec_data_desc *dsp_cfg =
-		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW88395_DATA_TYPE_DSP_CFG];
+		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW_DATA_TYPE_DSP_CFG];
 	struct aw_sec_data_desc *dsp_fw =
-		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW88395_DATA_TYPE_DSP_FW];
+		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW_DATA_TYPE_DSP_FW];
 	int int_st;
 
-	if (aw_dev->status == AW88399_DEV_PW_OFF) {
+	if (aw_dev->status == AW_DEV_PW_OFF) {
 		dev_dbg(aw_dev->dev, "already power off");
 		return 0;
 	}
 
-	aw_dev->status = AW88399_DEV_PW_OFF;
+	aw_dev->status = AW_DEV_PW_OFF;
 
 	aw88399_dev_mute(aw_dev, true);
-	usleep_range(AW88399_4000_US, AW88399_4000_US + 100);
+	usleep_range(AW_4000_US, AW_4000_US + 100);
 
-	aw_dev_i2s_tx_enable(aw_dev, false);
-	usleep_range(AW88399_1000_US, AW88399_1000_US + 100);
+	regmap_update_bits(aw_dev->regmap, AW88399_I2SCFG1_REG,
+			~AW88399_I2STXEN_MASK, AW88399_I2STXEN_DISABLE_VALUE);
+	usleep_range(AW_1000_US, AW_1000_US + 100);
 
-	int_st = aw_dev_check_sysint(aw_dev);
+	int_st = aw88399_check_sysint(aw_dev);
 
-	aw_dev_dsp_enable(aw_dev, false);
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+			~AW88399_DSPBY_MASK, AW88399_DSPBY_BYPASS_VALUE);
 
-	aw_dev_amppd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+			~AW88399_AMPPD_MASK, AW88399_AMPPD_POWER_DOWN_VALUE);
 
 	if (int_st) {
-		aw_dev_select_memclk(aw_dev, AW88399_DEV_MEMCLK_OSC);
-		aw_dev_dsp_update_fw(aw_dev, dsp_fw->data, dsp_fw->len);
-		aw_dev_dsp_update_cfg(aw_dev, dsp_cfg->data, dsp_cfg->len);
-		aw_dev_select_memclk(aw_dev, AW88399_DEV_MEMCLK_PLL);
+		regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
+				~AW88399_MEM_CLKSEL_MASK, AW88399_MEM_CLKSEL_OSCCLK_VALUE);
+		aw_dev_dsp_update_fw(aw_dev, dsp_fw->data, dsp_fw->len, dsp_fw->addr);
+		aw_dev_dsp_update_cfg(aw_dev, dsp_cfg->data, dsp_cfg->len, dsp_cfg->addr);
+		regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
+				~AW88399_MEM_CLKSEL_MASK, AW88399_MEM_CLKSEL_DAPHCLK_VALUE);
 	}
 
-	aw_dev_pwd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+				~AW88399_PWDN_MASK, AW88399_PWDN_POWER_DOWN_VALUE);
 
 	return 0;
 }
@@ -1432,22 +961,22 @@ static int aw_cali_svc_get_cali_cfg(struct aw_device *aw_dev)
 	int ret;
 
 	ret = aw_dev_dsp_read(aw_dev, AW88399_DSP_REG_CFG_MBMEC_ACTAMPTH,
-					&cali_cfg->data[0], AW88399_DSP_32_DATA);
+					&cali_cfg->data[0], AW_DSP_32_DATA);
 	if (ret)
 		return ret;
 
 	ret = aw_dev_dsp_read(aw_dev, AW88399_DSP_REG_CFG_MBMEC_NOISEAMPTH,
-					&cali_cfg->data[1], AW88399_DSP_32_DATA);
+					&cali_cfg->data[1], AW_DSP_32_DATA);
 	if (ret)
 		return ret;
 
 	ret = aw_dev_dsp_read(aw_dev, AW88399_DSP_REG_CFG_ADPZ_USTEPN,
-					&cali_cfg->data[2], AW88399_DSP_16_DATA);
+					&cali_cfg->data[2], AW_DSP_16_DATA);
 	if (ret)
 		return ret;
 
 	ret = aw_dev_dsp_read(aw_dev, AW88399_DSP_REG_CFG_RE_ALPHA,
-					&cali_cfg->data[3], AW88399_DSP_16_DATA);
+					&cali_cfg->data[3], AW_DSP_16_DATA);
 
 	return ret;
 }
@@ -1458,22 +987,22 @@ static int aw_cali_svc_set_cali_cfg(struct aw_device *aw_dev,
 	int ret;
 
 	ret = aw_dev_dsp_write(aw_dev, AW88399_DSP_REG_CFG_MBMEC_ACTAMPTH,
-					cali_cfg.data[0], AW88399_DSP_32_DATA);
+					cali_cfg.data[0], AW_DSP_32_DATA);
 	if (ret)
 		return ret;
 
 	ret = aw_dev_dsp_write(aw_dev, AW88399_DSP_REG_CFG_MBMEC_NOISEAMPTH,
-					cali_cfg.data[1], AW88399_DSP_32_DATA);
+					cali_cfg.data[1], AW_DSP_32_DATA);
 	if (ret)
 		return ret;
 
 	ret = aw_dev_dsp_write(aw_dev, AW88399_DSP_REG_CFG_ADPZ_USTEPN,
-					cali_cfg.data[2], AW88399_DSP_16_DATA);
+					cali_cfg.data[2], AW_DSP_16_DATA);
 	if (ret)
 		return ret;
 
 	ret = aw_dev_dsp_write(aw_dev, AW88399_DSP_REG_CFG_RE_ALPHA,
-					cali_cfg.data[3], AW88399_DSP_16_DATA);
+					cali_cfg.data[3], AW_DSP_16_DATA);
 
 	return ret;
 }
@@ -1483,17 +1012,19 @@ static int aw_cali_svc_cali_en(struct aw_device *aw_dev, bool cali_en)
 	struct cali_cfg set_cfg;
 	int ret;
 
-	aw_dev_dsp_enable(aw_dev, false);
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+			~AW88399_DSPBY_MASK, AW88399_DSPBY_BYPASS_VALUE);
 	if (cali_en) {
 		regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
-				~AW883XX_DSP_NG_EN_MASK, AW883XX_DSP_NG_EN_DISABLE_VALUE);
+				~AW88399_DSP_NG_EN_MASK, AW88399_DSP_NG_EN_DISABLE_VALUE);
 		aw_dev_dsp_write(aw_dev, AW88399_DSP_LOW_POWER_SWITCH_CFG_ADDR,
-				AW88399_DSP_LOW_POWER_SWITCH_DISABLE, AW88399_DSP_16_DATA);
+				AW88399_DSP_LOW_POWER_SWITCH_DISABLE, AW_DSP_16_DATA);
 
 		ret = aw_cali_svc_get_cali_cfg(aw_dev);
 		if (ret) {
 			dev_err(aw_dev->dev, "get cali cfg failed\n");
-			aw_dev_dsp_enable(aw_dev, true);
+			regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+					~AW88399_DSPBY_MASK, AW88399_DSPBY_WORKING_VALUE);
 			return ret;
 		}
 		set_cfg.data[0] = 0;
@@ -1505,14 +1036,16 @@ static int aw_cali_svc_cali_en(struct aw_device *aw_dev, bool cali_en)
 		if (ret) {
 			dev_err(aw_dev->dev, "set cali cfg failed\n");
 			aw_cali_svc_set_cali_cfg(aw_dev, aw_dev->cali_desc.cali_cfg);
-			aw_dev_dsp_enable(aw_dev, true);
+			regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+					~AW88399_DSPBY_MASK, AW88399_DSPBY_WORKING_VALUE);
 			return ret;
 		}
 	} else {
 		aw_cali_svc_set_cali_cfg(aw_dev, aw_dev->cali_desc.cali_cfg);
 	}
 
-	aw_dev_dsp_enable(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+			~AW88399_DSPBY_MASK, AW88399_DSPBY_WORKING_VALUE);
 
 	return 0;
 }
@@ -1546,10 +1079,10 @@ static void aw_cali_svc_backup_info(struct aw_device *aw_dev)
 	unsigned int reg_val, dsp_val;
 
 	regmap_read(aw_dev->regmap, AW88399_DBGCTRL_REG, &reg_val);
-	backup_desc->dsp_ng_cfg = reg_val & (~AW883XX_DSP_NG_EN_MASK);
+	backup_desc->dsp_ng_cfg = reg_val & (~AW88399_DSP_NG_EN_MASK);
 
 	aw_dev_dsp_read(aw_dev, AW88399_DSP_LOW_POWER_SWITCH_CFG_ADDR,
-			&dsp_val, AW88399_DSP_16_DATA);
+			&dsp_val, AW_DSP_16_DATA);
 
 	backup_desc->dsp_lp_cfg = dsp_val;
 }
@@ -1559,10 +1092,10 @@ static void aw_cali_svc_recover_info(struct aw_device *aw_dev)
 	struct aw_cali_backup_desc *backup_desc = &aw_dev->cali_desc.backup_info;
 
 	regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
-			~AW883XX_DSP_NG_EN_MASK, backup_desc->dsp_ng_cfg);
+			~AW88399_DSP_NG_EN_MASK, backup_desc->dsp_ng_cfg);
 
 	aw_dev_dsp_write(aw_dev, AW88399_DSP_LOW_POWER_SWITCH_CFG_ADDR,
-			backup_desc->dsp_lp_cfg, AW88399_DSP_16_DATA);
+			backup_desc->dsp_lp_cfg, AW_DSP_16_DATA);
 }
 
 static int aw_cali_svc_cali_re_mode_enable(struct aw_device *aw_dev, bool is_enable)
@@ -1570,7 +1103,7 @@ static int aw_cali_svc_cali_re_mode_enable(struct aw_device *aw_dev, bool is_ena
 	int ret;
 
 	if (is_enable) {
-		ret = aw_dev_check_syspll(aw_dev);
+		ret = aw88399_check_syspll(aw_dev);
 		if (ret) {
 			dev_err(aw_dev->dev, "pll check failed cannot start\n");
 			return ret;
@@ -1609,7 +1142,7 @@ static int aw_cali_svc_get_dev_re(struct aw_device *aw_dev, uint32_t *re)
 	uint32_t dsp_re, show_re;
 	int ret;
 
-	ret = aw_dev_dsp_read(aw_dev, AW88399_DSP_REG_CALRE, &dsp_re, AW88399_DSP_16_DATA);
+	ret = aw_dev_dsp_read(aw_dev, AW88399_DSP_REG_CALRE, &dsp_re, AW_DSP_16_DATA);
 	if (ret)
 		return ret;
 
@@ -1695,9 +1228,11 @@ static int aw_cali_svc_get_smooth_cali_re(struct aw_device *aw_dev)
 	aw_dev->cali_desc.cali_re = dsp_re;
 	dev_dbg(aw_dev->dev, "re[%d]mohm\n", aw_dev->cali_desc.cali_re);
 
-	aw_dev_dsp_enable(aw_dev, false);
-	aw_dev_update_cali_re(&aw_dev->cali_desc);
-	aw_dev_dsp_enable(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+			~AW88399_DSPBY_MASK, AW88399_DSPBY_BYPASS_VALUE);
+	aw88399_update_cali_re(&aw_dev->cali_desc);
+	regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+			~AW88399_DSPBY_MASK, AW88399_DSPBY_WORKING_VALUE);
 
 	return 0;
 
@@ -1850,7 +1385,7 @@ static int aw88399_profile_info(struct snd_kcontrol *kcontrol,
 
 	count = uinfo->value.enumerated.item;
 
-	ret = aw88399_dev_get_prof_name(aw88399->aw_pa, count, &prof_name);
+	ret = aw_dev_get_prof_name(aw88399->aw_pa, count, &prof_name);
 	if (ret) {
 		strscpy(uinfo->value.enumerated.name, "null");
 		return 0;
@@ -1889,7 +1424,7 @@ static int aw88399_profile_set(struct snd_kcontrol *kcontrol,
 
 	if (aw88399->aw_pa->status) {
 		aw88399_stop(aw88399->aw_pa);
-		aw88399_start(aw88399, AW88399_SYNC_START);
+		aw88399_start(aw88399, AW_SYNC_START);
 	}
 
 	mutex_unlock(&aw88399->lock);
@@ -1925,7 +1460,7 @@ static int aw88399_volume_set(struct snd_kcontrol *kcontrol,
 
 	if (vol_desc->ctl_volume != value) {
 		vol_desc->ctl_volume = value;
-		aw_dev_set_volume(aw88399->aw_pa, vol_desc->ctl_volume);
+		aw88399_set_volume(aw88399->aw_pa, vol_desc->ctl_volume);
 
 		return 1;
 	}
@@ -2046,86 +1581,6 @@ static int aw88399_calib_set(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int aw88399_dev_init(struct aw88399 *aw88399, struct aw_container *aw_cfg)
-{
-	struct aw_device *aw_dev = aw88399->aw_pa;
-	int ret;
-
-	ret = aw88395_dev_cfg_load(aw_dev, aw_cfg);
-	if (ret) {
-		dev_err(aw_dev->dev, "aw_dev acf parse failed");
-		return -EINVAL;
-	}
-	aw_dev->fade_in_time = AW88399_1000_US / 10;
-	aw_dev->fade_out_time = AW88399_1000_US >> 1;
-	aw_dev->prof_cur = aw_dev->prof_info.prof_desc[0].id;
-	aw_dev->prof_index = aw_dev->prof_info.prof_desc[0].id;
-
-	ret = aw88399_dev_fw_update(aw88399, AW88399_FORCE_UPDATE_ON, AW88399_DSP_FW_UPDATE_ON);
-	if (ret) {
-		dev_err(aw_dev->dev, "fw update failed ret = %d\n", ret);
-		return ret;
-	}
-
-	aw88399_dev_mute(aw_dev, true);
-
-	/* close tx feedback */
-	aw_dev_i2s_tx_enable(aw_dev, false);
-	usleep_range(AW88399_1000_US, AW88399_1000_US + 100);
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
-static int aw88399_request_firmware_file(struct aw88399 *aw88399)
-{
-	const struct firmware *cont = NULL;
-	int ret;
-
-	aw88399->aw_pa->fw_status = AW88399_DEV_FW_FAILED;
-
-	ret = request_firmware(&cont, AW88399_ACF_FILE, aw88399->aw_pa->dev);
-	if (ret) {
-		dev_err(aw88399->aw_pa->dev, "request [%s] failed!", AW88399_ACF_FILE);
-		return ret;
-	}
-
-	dev_dbg(aw88399->aw_pa->dev, "loaded %s - size: %zu\n",
-			AW88399_ACF_FILE, cont ? cont->size : 0);
-
-	aw88399->aw_cfg = devm_kzalloc(aw88399->aw_pa->dev,
-			struct_size(aw88399->aw_cfg, data, cont->size), GFP_KERNEL);
-	if (!aw88399->aw_cfg) {
-		release_firmware(cont);
-		return -ENOMEM;
-	}
-	aw88399->aw_cfg->len = (int)cont->size;
-	memcpy(aw88399->aw_cfg->data, cont->data, cont->size);
-	release_firmware(cont);
-
-	ret = aw88395_dev_load_acf_check(aw88399->aw_pa, aw88399->aw_cfg);
-	if (ret) {
-		dev_err(aw88399->aw_pa->dev, "load [%s] failed!", AW88399_ACF_FILE);
-		return ret;
-	}
-
-	mutex_lock(&aw88399->lock);
-	/* aw device init */
-	ret = aw88399_dev_init(aw88399, aw88399->aw_cfg);
-	if (ret)
-		dev_err(aw88399->aw_pa->dev, "dev init failed");
-	mutex_unlock(&aw88399->lock);
-
-	return ret;
-}
-
 static const struct snd_kcontrol_new aw88399_controls[] = {
 	SOC_SINGLE_EXT("PCM Playback Volume", AW88399_SYSCTRL2_REG,
 		6, AW88399_MUTE_VOL, 0, aw88399_volume_get,
@@ -2142,7 +1597,7 @@ static const struct snd_kcontrol_new aw88399_controls[] = {
 		aw88399_calib_switch_get, aw88399_calib_switch_set),
 	SOC_SINGLE_EXT("Trigger Calib", SND_SOC_NOPM, 0, 1, 0,
 		aw88399_calib_get, aw88399_calib_set),
-	AW88399_PROFILE_EXT("AW88399 Profile Set", aw88399_profile_info,
+	AW_PROFILE_EXT("AW88399 Profile Set", aw88399_profile_info,
 		aw88399_profile_get, aw88399_profile_set),
 };
 
@@ -2155,7 +1610,7 @@ static int aw88399_playback_event(struct snd_soc_dapm_widget *w,
 	mutex_lock(&aw88399->lock);
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		aw88399_start(aw88399, AW88399_ASYNC_START);
+		aw88399_start(aw88399, AW_ASYNC_START);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		aw88399_stop(aw88399->aw_pa);
@@ -2170,7 +1625,7 @@ static int aw88399_playback_event(struct snd_soc_dapm_widget *w,
 
 static const struct snd_soc_dapm_widget aw88399_dapm_widgets[] = {
 	 /* playback */
-	SND_SOC_DAPM_AIF_IN_E("AIF_RX", "Speaker_Playback", 0, 0, 0, 0,
+	SND_SOC_DAPM_AIF_IN_E("AIF_RX", "Speaker_Playback", 0, SND_SOC_NOPM, 0, 0,
 					aw88399_playback_event,
 					SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_OUTPUT("DAC Output"),
@@ -2192,9 +1647,15 @@ static int aw88399_codec_probe(struct snd_soc_component *component)
 
 	INIT_DELAYED_WORK(&aw88399->start_work, aw88399_startup_work);
 
-	ret = aw88399_request_firmware_file(aw88399);
-	if (ret)
+	ret = aw_dev_request_firmware_file(aw88399->aw_pa, AW88399_ACF_FILE);
+	if (ret) {
 		dev_err(aw88399->aw_pa->dev, "%s failed\n", __func__);
+		return ret;
+	}
+
+	ret = aw88399_fw_update(aw88399, AW_FORCE_UPDATE_ON, AW_DSP_FW_UPDATE_ON);
+	if (ret)
+		dev_err(aw88399->aw_pa->dev, "fw update failed ret = %d\n", ret);
 
 	return ret;
 }
@@ -2217,70 +1678,6 @@ static const struct snd_soc_component_driver soc_codec_dev_aw88399 = {
 	.num_controls = ARRAY_SIZE(aw88399_controls),
 };
 
-static void aw88399_hw_reset(struct aw88399 *aw88399)
-{
-	if (aw88399->reset_gpio) {
-		gpiod_set_value_cansleep(aw88399->reset_gpio, 1);
-		usleep_range(AW88399_1000_US, AW88399_1000_US + 10);
-		gpiod_set_value_cansleep(aw88399->reset_gpio, 0);
-		usleep_range(AW88399_1000_US, AW88399_1000_US + 10);
-		gpiod_set_value_cansleep(aw88399->reset_gpio, 1);
-		usleep_range(AW88399_1000_US, AW88399_1000_US + 10);
-	}
-}
-
-static void aw88399_parse_channel_dt(struct aw_device *aw_dev)
-{
-	struct device_node *np = aw_dev->dev->of_node;
-	u32 channel_value;
-
-	of_property_read_u32(np, "awinic,audio-channel", &channel_value);
-	aw_dev->channel = channel_value;
-}
-
-static int aw88399_init(struct aw88399 *aw88399, struct i2c_client *i2c, struct regmap *regmap)
-{
-	struct aw_device *aw_dev;
-	unsigned int chip_id;
-	int ret;
-
-	ret = regmap_read(regmap, AW88399_ID_REG, &chip_id);
-	if (ret) {
-		dev_err(&i2c->dev, "%s read chipid error. ret = %d", __func__, ret);
-		return ret;
-	}
-	if (chip_id != AW88399_CHIP_ID) {
-		dev_err(&i2c->dev, "unsupported device");
-		return -ENXIO;
-	}
-	dev_dbg(&i2c->dev, "chip id = %x\n", chip_id);
-
-	aw_dev = devm_kzalloc(&i2c->dev, sizeof(*aw_dev), GFP_KERNEL);
-	if (!aw_dev)
-		return -ENOMEM;
-	aw88399->aw_pa = aw_dev;
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
-	aw_dev->channel = AW88399_DEV_DEFAULT_CH;
-	aw_dev->fw_status = AW88399_DEV_FW_FAILED;
-
-	aw_dev->fade_step = AW88399_VOLUME_STEP_DB;
-	aw_dev->volume_desc.ctl_volume = AW88399_VOL_DEFAULT_VALUE;
-
-	aw88399_parse_channel_dt(aw_dev);
-
-	return 0;
-}
-
 static int aw88399_i2c_probe(struct i2c_client *i2c)
 {
 	struct aw88399 *aw88399;
@@ -2294,14 +1691,17 @@ static int aw88399_i2c_probe(struct i2c_client *i2c)
 		return -ENOMEM;
 
 	mutex_init(&aw88399->lock);
-
 	i2c_set_clientdata(i2c, aw88399);
 
-	aw88399->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(aw88399->reset_gpio))
-		return dev_err_probe(&i2c->dev, PTR_ERR(aw88399->reset_gpio),
+	aw88399->aw_pa = devm_kzalloc(&i2c->dev, sizeof(struct aw_device), GFP_KERNEL);
+	if (!aw88399->aw_pa)
+		return -ENOMEM;
+
+	aw88399->aw_pa->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(aw88399->aw_pa->reset_gpio))
+		return dev_err_probe(&i2c->dev, PTR_ERR(aw88399->aw_pa->reset_gpio),
 							"reset gpio not defined\n");
-	aw88399_hw_reset(aw88399);
+	aw_hw_reset(aw88399->aw_pa);
 
 	aw88399->regmap = devm_regmap_init_i2c(i2c, &aw88399_remap_config);
 	if (IS_ERR(aw88399->regmap))
@@ -2309,17 +1709,12 @@ static int aw88399_i2c_probe(struct i2c_client *i2c)
 							"failed to init regmap\n");
 
 	/* aw pa init */
-	ret = aw88399_init(aw88399, i2c, aw88399->regmap);
+	ret = aw_dev_init(aw88399->aw_pa, i2c, aw88399->regmap);
 	if (ret)
 		return ret;
 
-	ret = devm_snd_soc_register_component(&i2c->dev,
-			&soc_codec_dev_aw88399,
-			aw88399_dai, ARRAY_SIZE(aw88399_dai));
-	if (ret)
-		dev_err(&i2c->dev, "failed to register aw88399: %d", ret);
-
-	return ret;
+	return devm_snd_soc_register_component(&i2c->dev, &soc_codec_dev_aw88399,
+						aw88399_dai, ARRAY_SIZE(aw88399_dai));
 }
 
 static const struct i2c_device_id aw88399_i2c_id[] = {
diff --git a/sound/soc/codecs/aw88399.h b/sound/soc/codecs/aw88399.h
index cacc03b1eefa..45684513dbab 100644
--- a/sound/soc/codecs/aw88399.h
+++ b/sound/soc/codecs/aw88399.h
@@ -461,13 +461,13 @@
 #define AW88399_DSP_VOL_MASK		\
 	(~(((1<<AW88399_DSP_VOL_BITS_LEN)-1) << AW88399_DSP_VOL_START_BIT))
 
-#define AW883XX_DSP_NG_EN_START	(13)
-#define AW883XX_DSP_NG_EN_LEN		(1)
-#define AW883XX_DSP_NG_EN_MASK		\
-	(~(((1 << AW883XX_DSP_NG_EN_LEN) - 1) << AW883XX_DSP_NG_EN_START))
-#define AW883XX_DSP_NG_EN_DISABLE	(0)
-#define AW883XX_DSP_NG_EN_DISABLE_VALUE	\
-	(AW883XX_DSP_NG_EN_DISABLE << AW883XX_DSP_NG_EN_START)
+#define AW88399_DSP_NG_EN_START	(13)
+#define AW88399_DSP_NG_EN_LEN		(1)
+#define AW88399_DSP_NG_EN_MASK		\
+	(~(((1 << AW88399_DSP_NG_EN_LEN) - 1) << AW88399_DSP_NG_EN_START))
+#define AW88399_DSP_NG_EN_DISABLE	(0)
+#define AW88399_DSP_NG_EN_DISABLE_VALUE	\
+	(AW88399_DSP_NG_EN_DISABLE << AW88399_DSP_NG_EN_START)
 
 #define AW88399_VOLUME_STEP_DB			(64)
 #define AW88399_VOL_DEFAULT_VALUE		(0)
@@ -509,7 +509,6 @@
 #define AW88399_CRC_FW_BASE_ADDR		(0x4C0)
 #define AW88399_ACF_FILE			"aw88399_acf.bin"
 #define AW88399_DEV_SYSST_CHECK_MAX		(10)
-#define AW88399_CHIP_ID			0x2183
 
 #define AW88399_I2C_NAME			"aw88399"
 
@@ -522,9 +521,6 @@
 			SNDRV_PCM_FMTBIT_S24_LE | \
 			SNDRV_PCM_FMTBIT_S32_LE)
 
-#define FADE_TIME_MAX		100000
-#define FADE_TIME_MIN		0
-
 #define AW_CALI_READ_CNT_MAX			(8)
 #define AW88399_DSP_REG_CALRE			(0x8141)
 #define AW88399_DSP_REG_CALRE_SHIFT		(10)
@@ -541,15 +537,6 @@
 #define AW88399_DSP_LOW_POWER_SWITCH_CFG_ADDR	(0x9BEC)
 #define AW88399_DSP_LOW_POWER_SWITCH_DISABLE	(0x110b)
 
-#define AW88399_PROFILE_EXT(xname, profile_info, profile_get, profile_set) \
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
@@ -565,70 +552,4 @@ enum {
 	AW88399_DSP_CRC_OK = 1,
 };
 
-enum {
-	AW88399_DSP_FW_UPDATE_OFF = 0,
-	AW88399_DSP_FW_UPDATE_ON = 1,
-};
-
-enum {
-	AW88399_FORCE_UPDATE_OFF = 0,
-	AW88399_FORCE_UPDATE_ON = 1,
-};
-
-enum {
-	AW88399_1000_US = 1000,
-	AW88399_2000_US = 2000,
-	AW88399_3000_US = 3000,
-	AW88399_4000_US = 4000,
-};
-
-enum AW88399_DEV_STATUS {
-	AW88399_DEV_PW_OFF = 0,
-	AW88399_DEV_PW_ON,
-};
-
-enum AW88399_DEV_FW_STATUS {
-	AW88399_DEV_FW_FAILED = 0,
-	AW88399_DEV_FW_OK,
-};
-
-enum AW88399_DEV_MEMCLK {
-	AW88399_DEV_MEMCLK_OSC = 0,
-	AW88399_DEV_MEMCLK_PLL = 1,
-};
-
-enum AW88399_DEV_DSP_CFG {
-	AW88399_DEV_DSP_WORK = 0,
-	AW88399_DEV_DSP_BYPASS = 1,
-};
-
-enum {
-	AW88399_DSP_16_DATA = 0,
-	AW88399_DSP_32_DATA = 1,
-};
-
-enum {
-	AW88399_NOT_RCV_MODE = 0,
-	AW88399_RCV_MODE = 1,
-};
-
-enum {
-	AW88399_SYNC_START = 0,
-	AW88399_ASYNC_START,
-};
-
-struct aw88399 {
-	struct aw_device *aw_pa;
-	struct mutex lock;
-	struct gpio_desc *reset_gpio;
-	struct delayed_work start_work;
-	struct regmap *regmap;
-	struct aw_container *aw_cfg;
-
-	unsigned int check_val;
-	unsigned int crc_init_val;
-	unsigned int vcalb_init_val;
-	unsigned int dither_st;
-};
-
 #endif
-- 
2.47.0


