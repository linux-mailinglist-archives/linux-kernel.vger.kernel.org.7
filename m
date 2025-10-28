Return-Path: <linux-kernel+bounces-873763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B1AC14A53
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEAC565A26
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A624D1A9FBA;
	Tue, 28 Oct 2025 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b="g9RNNG17"
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C22D5957;
	Tue, 28 Oct 2025 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654865; cv=none; b=d+y2EVOGhSOylIWFCiBe62OP/3/0PBPK5O5NLJqcHn+PTZRylrFnf5/bYvFNulDil2V2V/q1GCGhlb8aFuIuZPZ//cGRhKPk9Gt9aev9/XIx5iRxGxtyjsAb5YCA/Mh2uixd3YgT/hCQY30hy4x/GBGCzdGIq3MCGNZ3CP6JCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654865; c=relaxed/simple;
	bh=9qJvjcVfuT4bP4pO9FohU4w3nZQb1nnjGGajOKPGWqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDFaoluT8gYg2yh9e/Ysdebo5KlWR4Pqlp3nUM+Coz1hwvscZrbmC7t5aZAvRIZdhVLpSUAHdQY0rtWbCDyGW4e03HLu1B8dLfqqlLQ7Uav1HljDzUt3QzXV7HUVGYikj9Q5jJo+el6+rBcdpphBFk6+xKKg9H9G5YG7Nci3ezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b=g9RNNG17; arc=none smtp.client-ip=115.124.28.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=awinic.com; s=default;
	t=1761654852; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bF/MTdBeYeqxnb1y/xnsWTjA7VFSKv4KmRuyd7sBT4U=;
	b=g9RNNG17ABIKALAYLHC/E4QEdE7JcLFQ3sGIVp2xC9fxt+yQ0xtaZ9gXDwbqC8unTqkjAOb2IUNAEJiVnn+bWFo04Ac4funqgfGQLqUm8uI7uLbGUXs53IRlDcNaJJq2wEVpqBxJG+2dyuhKpyvdyguiHViQD++PFpZ5ILekQQP8nBBoJBP2zB8vQNFivaB9bdIpETcLZpTRw6YWwsJpe1rsX8lvMr0pzVfcY5Mw6e/SEQRLdbD9bVPHKNg0qb3WhF3on5HOFLcXSAPWzX7P0wOhGkGKk6wLBKdOMPKreNtzknrLQeWHoSaavF78sEzK7qGx3LCzaGl5cRKoNPUe5Q==
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.f9Oy7Id_1761654848 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 28 Oct 2025 20:34:09 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	srinivas.kandagatla@oss.qualcomm.com,
	wangweidong.a@awinic.com,
	arnd@arndb.de,
	cy_huang@richtek.com,
	nick.li@foursemi.com,
	shenghao-ding@ti.com,
	alexey.klimov@linaro.org,
	niranjan.hy@ti.com,
	linux@treblig.org,
	zhangyi@everest-semi.com,
	thorsten.blum@linux.dev,
	kuninori.morimoto.gx@renesas.com,
	yesanishhere@gmail.com,
	marco.crivellari@suse.com,
	ebiggers@google.com,
	ardb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V3 4/7] ASoC: codecs: Rework the aw88081 driver
Date: Tue, 28 Oct 2025 20:33:54 +0800
Message-ID: <20251028123357.46161-5-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251028123357.46161-1-wangweidong.a@awinic.com>
References: <20251028123357.46161-1-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

Modify the interface for calling the aw88081 driver
to adapt it for aw-common-device.c and aw-common-firmware.c

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88081.c | 357 +++++++++----------------------------
 sound/soc/codecs/aw88081.h |  33 ----
 2 files changed, 83 insertions(+), 307 deletions(-)

diff --git a/sound/soc/codecs/aw88081.c b/sound/soc/codecs/aw88081.c
index fbd1fd12381a..85e51b27aed2 100644
--- a/sound/soc/codecs/aw88081.c
+++ b/sound/soc/codecs/aw88081.c
@@ -12,7 +12,8 @@
 #include <linux/regmap.h>
 #include <sound/soc.h>
 #include "aw88081.h"
-#include "aw88395/aw88395_device.h"
+#include "aw-common-device.h"
+#include "aw-common-firmware.h"
 
 enum aw8808x_type {
 	AW88081,
@@ -69,7 +70,7 @@ static int aw88081_dev_check_mode1_pll(struct aw_device *aw_dev)
 		ret = aw88081_dev_get_iis_status(aw_dev);
 		if (ret) {
 			dev_err(aw_dev->dev, "mode1 iis signal check error");
-			usleep_range(AW88081_2000_US, AW88081_2000_US + 10);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
 		} else {
 			return 0;
 		}
@@ -103,7 +104,7 @@ static int aw88081_dev_check_mode2_pll(struct aw_device *aw_dev)
 		ret = aw88081_dev_get_iis_status(aw_dev);
 		if (ret) {
 			dev_err(aw_dev->dev, "mode2 iis check error");
-			usleep_range(AW88081_2000_US, AW88081_2000_US + 10);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
 		} else {
 			break;
 		}
@@ -113,12 +114,12 @@ static int aw88081_dev_check_mode2_pll(struct aw_device *aw_dev)
 	ret = regmap_update_bits(aw_dev->regmap, AW88081_PLLCTRL1_REG,
 			~AW88081_CCO_MUX_MASK, AW88081_CCO_MUX_BYPASS_VALUE);
 	if (ret == 0) {
-		usleep_range(AW88081_2000_US, AW88081_2000_US + 10);
+		usleep_range(AW_2000_US, AW_2000_US + 10);
 		for (i = 0; i < AW88081_DEV_SYSST_CHECK_MAX; i++) {
 			ret = aw88081_dev_check_mode1_pll(aw_dev);
 			if (ret) {
 				dev_err(aw_dev->dev, "mode2 switch to mode1, iis check error");
-				usleep_range(AW88081_2000_US, AW88081_2000_US + 10);
+				usleep_range(AW_2000_US, AW_2000_US + 10);
 			} else {
 				break;
 			}
@@ -170,7 +171,7 @@ static int aw88081_dev_check_sysst(struct aw_device *aw_dev)
 		if (value != check_val) {
 			dev_err(aw_dev->dev, "check sysst fail, reg_val=0x%04x, check:0x%x",
 				reg_val, check_val);
-			usleep_range(AW88081_2000_US, AW88081_2000_US + 10);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
 		} else {
 			return 0;
 		}
@@ -179,36 +180,6 @@ static int aw88081_dev_check_sysst(struct aw_device *aw_dev)
 	return -EPERM;
 }
 
-static void aw88081_dev_i2s_tx_enable(struct aw_device *aw_dev, bool flag)
-{
-	if (flag)
-		regmap_update_bits(aw_dev->regmap, AW88081_I2SCTRL3_REG,
-			~AW88081_I2STXEN_MASK, AW88081_I2STXEN_ENABLE_VALUE);
-	else
-		regmap_update_bits(aw_dev->regmap, AW88081_I2SCTRL3_REG,
-			~AW88081_I2STXEN_MASK, AW88081_I2STXEN_DISABLE_VALUE);
-}
-
-static void aw88081_dev_pwd(struct aw_device *aw_dev, bool pwd)
-{
-	if (pwd)
-		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
-				~AW88081_PWDN_MASK, AW88081_PWDN_POWER_DOWN_VALUE);
-	else
-		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
-				~AW88081_PWDN_MASK, AW88081_PWDN_WORKING_VALUE);
-}
-
-static void aw88081_dev_amppd(struct aw_device *aw_dev, bool amppd)
-{
-	if (amppd)
-		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
-				~AW88081_EN_PA_MASK, AW88081_EN_PA_POWER_DOWN_VALUE);
-	else
-		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
-				~AW88081_EN_PA_MASK, AW88081_EN_PA_WORKING_VALUE);
-}
-
 static void aw88083_i2c_wen(struct aw88081 *aw88081, bool flag)
 {
 	struct aw_device *aw_dev = aw88081->aw_pa;
@@ -224,39 +195,7 @@ static void aw88083_i2c_wen(struct aw88081 *aw88081, bool flag)
 				~AW88083_I2C_WEN_MASK, AW88083_I2C_WEN_DISABLE_VALUE);
 }
 
-static void aw88083_dev_amppd(struct aw_device *aw_dev, bool amppd)
-{
-	if (amppd)
-		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
-				~AW88083_AMPPD_MASK, AW88083_AMPPD_POWER_DOWN_VALUE);
-	else
-		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
-				~AW88083_AMPPD_MASK, AW88083_AMPPD_WORKING_VALUE);
-}
-
-static void aw88083_dev_pllpd(struct aw_device *aw_dev, bool pllpd)
-{
-	if (pllpd)
-		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
-				~AW88083_PLL_PD_MASK, AW88083_PLL_PD_WORKING_VALUE);
-	else
-		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
-				~AW88083_PLL_PD_MASK, AW88083_PLL_PD_POWER_DOWN_VALUE);
-}
-
-static void aw88081_dev_clear_int_status(struct aw_device *aw_dev)
-{
-	unsigned int int_status;
-
-	/* read int status and clear */
-	regmap_read(aw_dev->regmap, AW88081_SYSINT_REG, &int_status);
-	/* make sure int status is clear */
-	regmap_read(aw_dev->regmap, AW88081_SYSINT_REG, &int_status);
-
-	dev_dbg(aw_dev->dev, "read interrupt reg = 0x%04x", int_status);
-}
-
-static void aw88081_dev_set_volume(struct aw_device *aw_dev, unsigned int value)
+static void aw88081_set_volume(struct aw_device *aw_dev, unsigned int value)
 {
 	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
 	unsigned int volume;
@@ -266,72 +205,19 @@ static void aw88081_dev_set_volume(struct aw_device *aw_dev, unsigned int value)
 	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL2_REG, ~AW88081_VOL_MASK, volume);
 }
 
-static void aw88081_dev_fade_in(struct aw_device *aw_dev)
-{
-	struct aw_volume_desc *desc = &aw_dev->volume_desc;
-	int fade_in_vol = desc->ctl_volume;
-	int fade_step = aw_dev->fade_step;
-	int i;
-
-	if (fade_step == 0 || aw_dev->fade_in_time == 0) {
-		aw88081_dev_set_volume(aw_dev, fade_in_vol);
-		return;
-	}
-
-	for (i = AW88081_MUTE_VOL; i >= fade_in_vol; i -= fade_step) {
-		aw88081_dev_set_volume(aw_dev, i);
-		usleep_range(aw_dev->fade_in_time, aw_dev->fade_in_time + 10);
-	}
-
-	if (i != fade_in_vol)
-		aw88081_dev_set_volume(aw_dev, fade_in_vol);
-}
-
-static void aw88081_dev_fade_out(struct aw_device *aw_dev)
-{
-	struct aw_volume_desc *desc = &aw_dev->volume_desc;
-	int fade_step = aw_dev->fade_step;
-	int i;
-
-	if (fade_step == 0 || aw_dev->fade_out_time == 0) {
-		aw88081_dev_set_volume(aw_dev, AW88081_MUTE_VOL);
-		return;
-	}
-
-	for (i = desc->ctl_volume; i <= AW88081_MUTE_VOL; i += fade_step) {
-		aw88081_dev_set_volume(aw_dev, i);
-		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
-	}
-
-	if (i != AW88081_MUTE_VOL)
-		aw88081_dev_set_volume(aw_dev, AW88081_MUTE_VOL);
-}
-
 static void aw88081_dev_mute(struct aw_device *aw_dev, bool is_mute)
 {
 	if (is_mute) {
-		aw88081_dev_fade_out(aw_dev);
+		aw_dev_fade_out(aw_dev, aw88081_set_volume);
 		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
 				~AW88081_HMUTE_MASK, AW88081_HMUTE_ENABLE_VALUE);
 	} else {
 		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
 				~AW88081_HMUTE_MASK, AW88081_HMUTE_DISABLE_VALUE);
-		aw88081_dev_fade_in(aw_dev);
+		aw_dev_fade_in(aw_dev, aw88081_set_volume);
 	}
 }
 
-static void aw88081_dev_uls_hmute(struct aw_device *aw_dev, bool uls_hmute)
-{
-	if (uls_hmute)
-		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
-				~AW88081_ULS_HMUTE_MASK,
-				AW88081_ULS_HMUTE_ENABLE_VALUE);
-	else
-		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
-				~AW88081_ULS_HMUTE_MASK,
-				AW88081_ULS_HMUTE_DISABLE_VALUE);
-}
-
 static int aw88081_dev_reg_value_check(struct aw_device *aw_dev,
 					unsigned char reg_addr, unsigned short *reg_val)
 {
@@ -451,39 +337,7 @@ static int aw88081_dev_reg_update(struct aw88081 *aw88081,
 		vol_desc->ctl_volume = 0;
 
 	/* keep min volume */
-	aw88081_dev_set_volume(aw_dev, vol_desc->mute_volume);
-
-	return 0;
-}
-
-static int aw88081_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name)
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
-static int aw88081_dev_get_prof_data(struct aw_device *aw_dev, int index,
-			struct aw_prof_desc **prof_desc)
-{
-	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
-		dev_err(aw_dev->dev, "%s: index[%d] overflow count[%d]\n",
-				__func__, index, aw_dev->prof_info.count);
-		return -EINVAL;
-	}
-
-	*prof_desc = &aw_dev->prof_info.prof_desc[index];
+	aw88081_set_volume(aw_dev, vol_desc->mute_volume);
 
 	return 0;
 }
@@ -496,7 +350,7 @@ static int aw88081_dev_fw_update(struct aw88081 *aw88081)
 	char *prof_name;
 	int ret;
 
-	ret = aw88081_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
+	ret = aw_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
 	if (ret) {
 		dev_err(aw_dev->dev, "get prof name failed");
 		return -EINVAL;
@@ -504,14 +358,14 @@ static int aw88081_dev_fw_update(struct aw88081 *aw88081)
 
 	dev_dbg(aw_dev->dev, "start update %s", prof_name);
 
-	ret = aw88081_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
+	ret = aw_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
 	if (ret)
 		return ret;
 
 	/* update reg */
 	sec_desc = prof_index_desc->sec_desc;
-	ret = aw88081_dev_reg_update(aw88081, sec_desc[AW88395_DATA_TYPE_REG].data,
-					sec_desc[AW88395_DATA_TYPE_REG].len);
+	ret = aw88081_dev_reg_update(aw88081, sec_desc[AW_DATA_TYPE_REG].data,
+					sec_desc[AW_DATA_TYPE_REG].len);
 	if (ret) {
 		dev_err(aw_dev->dev, "update reg failed");
 		return ret;
@@ -527,14 +381,15 @@ static int aw88081_dev_start(struct aw88081 *aw88081)
 	struct aw_device *aw_dev = aw88081->aw_pa;
 	int ret;
 
-	if (aw_dev->status == AW88081_DEV_PW_ON) {
+	if (aw_dev->status == AW_DEV_PW_ON) {
 		dev_dbg(aw_dev->dev, "already power on");
 		return 0;
 	}
 
 	/* power on */
-	aw88081_dev_pwd(aw_dev, false);
-	usleep_range(AW88081_2000_US, AW88081_2000_US + 10);
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_PWDN_MASK, AW88081_PWDN_WORKING_VALUE);
+	usleep_range(AW_2000_US, AW_2000_US + 10);
 
 	ret = aw88081_dev_check_syspll(aw_dev);
 	if (ret) {
@@ -543,8 +398,9 @@ static int aw88081_dev_start(struct aw88081 *aw88081)
 	}
 
 	/* amppd on */
-	aw88081_dev_amppd(aw_dev, false);
-	usleep_range(AW88081_1000_US, AW88081_1000_US + 50);
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_EN_PA_MASK, AW88081_EN_PA_WORKING_VALUE);
+	usleep_range(AW_1000_US, AW_1000_US + 50);
 
 	/* check i2s status */
 	ret = aw88081_dev_check_sysst(aw_dev);
@@ -554,27 +410,32 @@ static int aw88081_dev_start(struct aw88081 *aw88081)
 	}
 
 	/* enable tx feedback */
-	aw88081_dev_i2s_tx_enable(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88081_I2SCTRL3_REG,
+				~AW88081_I2STXEN_MASK, AW88081_I2STXEN_ENABLE_VALUE);
 
 	/* close uls mute */
-	aw88081_dev_uls_hmute(aw_dev, false);
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_ULS_HMUTE_MASK, AW88081_ULS_HMUTE_DISABLE_VALUE);
 
 	/* close mute */
 	aw88081_dev_mute(aw_dev, false);
 
 	/* clear inturrupt */
-	aw88081_dev_clear_int_status(aw_dev);
-	aw_dev->status = AW88081_DEV_PW_ON;
+	aw_dev_clear_int_status(aw_dev);
+	aw_dev->status = AW_DEV_PW_ON;
 
 	return 0;
 
 sysst_check_fail:
-	aw88081_dev_i2s_tx_enable(aw_dev, false);
-	aw88081_dev_clear_int_status(aw_dev);
-	aw88081_dev_amppd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88081_I2SCTRL3_REG,
+				~AW88081_I2STXEN_MASK, AW88081_I2STXEN_DISABLE_VALUE);
+	aw_dev_clear_int_status(aw_dev);
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_EN_PA_MASK, AW88081_EN_PA_POWER_DOWN_VALUE);
 pll_check_fail:
-	aw88081_dev_pwd(aw_dev, true);
-	aw_dev->status = AW88081_DEV_PW_OFF;
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_PWDN_MASK, AW88081_PWDN_POWER_DOWN_VALUE);
+	aw_dev->status = AW_DEV_PW_OFF;
 
 	return ret;
 }
@@ -583,7 +444,7 @@ static int aw88083_dev_start(struct aw88081 *aw88081)
 {
 	struct aw_device *aw_dev = aw88081->aw_pa;
 
-	if (aw_dev->status == AW88081_DEV_PW_ON) {
+	if (aw_dev->status == AW_DEV_PW_ON) {
 		dev_dbg(aw_dev->dev, "already power on");
 		return 0;
 	}
@@ -591,20 +452,23 @@ static int aw88083_dev_start(struct aw88081 *aw88081)
 	aw88083_i2c_wen(aw88081, true);
 
 	/* power on */
-	aw88081_dev_pwd(aw_dev, false);
-	usleep_range(AW88081_2000_US, AW88081_2000_US + 10);
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_PWDN_MASK, AW88081_PWDN_WORKING_VALUE);
+	usleep_range(AW_2000_US, AW_2000_US + 10);
 
-	aw88083_dev_pllpd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88083_PLL_PD_MASK, AW88083_PLL_PD_WORKING_VALUE);
 	/* amppd on */
-	aw88083_dev_amppd(aw_dev, false);
-	usleep_range(AW88081_2000_US, AW88081_2000_US + 50);
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88083_AMPPD_MASK, AW88083_AMPPD_WORKING_VALUE);
+	usleep_range(AW_2000_US, AW_2000_US + 50);
 
 	/* close mute */
 	aw88081_dev_mute(aw_dev, false);
 
 	aw88083_i2c_wen(aw88081, false);
 
-	aw_dev->status = AW88081_DEV_PW_ON;
+	aw_dev->status = AW_DEV_PW_ON;
 
 	return 0;
 }
@@ -633,29 +497,33 @@ static int aw88081_dev_stop(struct aw88081 *aw88081)
 {
 	struct aw_device *aw_dev = aw88081->aw_pa;
 
-	if (aw_dev->status == AW88081_DEV_PW_OFF) {
+	if (aw_dev->status == AW_DEV_PW_OFF) {
 		dev_dbg(aw_dev->dev, "already power off");
 		return 0;
 	}
 
-	aw_dev->status = AW88081_DEV_PW_OFF;
+	aw_dev->status = AW_DEV_PW_OFF;
 
 	/* clear inturrupt */
-	aw88081_dev_clear_int_status(aw_dev);
+	aw_dev_clear_int_status(aw_dev);
 
-	aw88081_dev_uls_hmute(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_ULS_HMUTE_MASK, AW88081_ULS_HMUTE_ENABLE_VALUE);
 	/* set mute */
 	aw88081_dev_mute(aw_dev, true);
 
 	/* close tx feedback */
-	aw88081_dev_i2s_tx_enable(aw_dev, false);
-	usleep_range(AW88081_1000_US, AW88081_1000_US + 100);
+	regmap_update_bits(aw_dev->regmap, AW88081_I2SCTRL3_REG,
+				~AW88081_I2STXEN_MASK, AW88081_I2STXEN_DISABLE_VALUE);
+	usleep_range(AW_1000_US, AW_1000_US + 100);
 
 	/* enable amppd */
-	aw88081_dev_amppd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_EN_PA_MASK, AW88081_EN_PA_POWER_DOWN_VALUE);
 
 	/* set power down */
-	aw88081_dev_pwd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_PWDN_MASK, AW88081_PWDN_POWER_DOWN_VALUE);
 
 	return 0;
 }
@@ -664,26 +532,29 @@ static int aw88083_dev_stop(struct aw88081 *aw88081)
 {
 	struct aw_device *aw_dev = aw88081->aw_pa;
 
-	if (aw_dev->status == AW88081_DEV_PW_OFF) {
+	if (aw_dev->status == AW_DEV_PW_OFF) {
 		dev_dbg(aw_dev->dev, "already power off");
 		return 0;
 	}
 
-	aw_dev->status = AW88081_DEV_PW_OFF;
+	aw_dev->status = AW_DEV_PW_OFF;
 
 	aw88083_i2c_wen(aw88081, true);
 	/* set mute */
 	aw88081_dev_mute(aw_dev, true);
 
-	usleep_range(AW88081_2000_US, AW88081_2000_US + 100);
+	usleep_range(AW_2000_US, AW_2000_US + 100);
 
 	/* enable amppd */
-	aw88083_dev_amppd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88083_AMPPD_MASK, AW88083_AMPPD_POWER_DOWN_VALUE);
 
-	aw88083_dev_pllpd(aw_dev, false);
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88083_PLL_PD_MASK, AW88083_PLL_PD_POWER_DOWN_VALUE);
 
 	/* set power down */
-	aw88081_dev_pwd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_PWDN_MASK, AW88081_PWDN_POWER_DOWN_VALUE);
 
 	aw88083_i2c_wen(aw88081, false);
 
@@ -770,13 +641,13 @@ static void aw88081_startup_work(struct work_struct *work)
 
 static void aw88081_start(struct aw88081 *aw88081, bool sync_start)
 {
-	if (aw88081->aw_pa->fw_status != AW88081_DEV_FW_OK)
+	if (aw88081->aw_pa->fw_status != AW_DEV_FW_OK)
 		return;
 
-	if (aw88081->aw_pa->status == AW88081_DEV_PW_ON)
+	if (aw88081->aw_pa->status == AW_DEV_PW_ON)
 		return;
 
-	if (sync_start == AW88081_SYNC_START)
+	if (sync_start == AW_SYNC_START)
 		aw88081_start_pa(aw88081);
 	else
 		queue_delayed_work(system_dfl_wq,
@@ -912,7 +783,7 @@ static int aw88081_profile_info(struct snd_kcontrol *kcontrol,
 
 	count = uinfo->value.enumerated.item;
 
-	ret = aw88081_dev_get_prof_name(aw88081->aw_pa, count, &prof_name);
+	ret = aw_dev_get_prof_name(aw88081->aw_pa, count, &prof_name);
 	if (ret) {
 		strscpy(uinfo->value.enumerated.name, "null");
 		return 0;
@@ -952,7 +823,7 @@ static int aw88081_profile_set(struct snd_kcontrol *kcontrol,
 
 	if (aw88081->aw_pa->status) {
 		aw88081_stop(aw88081);
-		aw88081_start(aw88081, AW88081_SYNC_START);
+		aw88081_start(aw88081, AW_SYNC_START);
 	}
 
 	mutex_unlock(&aw88081->lock);
@@ -991,7 +862,7 @@ static int aw88081_volume_set(struct snd_kcontrol *kcontrol,
 
 	if (vol_desc->ctl_volume != value) {
 		vol_desc->ctl_volume = value;
-		aw88081_dev_set_volume(aw88081->aw_pa, vol_desc->ctl_volume);
+		aw88081_set_volume(aw88081->aw_pa, vol_desc->ctl_volume);
 		return 1;
 	}
 
@@ -1042,7 +913,7 @@ static const struct snd_kcontrol_new aw88081_controls[] = {
 		aw88081_get_fade_in_time, aw88081_set_fade_in_time),
 	SOC_SINGLE_EXT("Volume Ramp Down Step", 0, 0, FADE_TIME_MAX, 0,
 		aw88081_get_fade_out_time, aw88081_set_fade_out_time),
-	AW88081_PROFILE_EXT("Profile Set", aw88081_profile_info,
+	AW_PROFILE_EXT("Profile Set", aw88081_profile_info,
 		aw88081_profile_get, aw88081_profile_set),
 };
 
@@ -1094,7 +965,7 @@ static int aw88081_init(struct aw88081 *aw88081, struct i2c_client *i2c, struct
 	aw_dev->chip_id = chip_id;
 	aw_dev->acf = NULL;
 	aw_dev->prof_info.prof_desc = NULL;
-	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
+	aw_dev->prof_info.prof_type = AW_DEV_NONE_TYPE_ID;
 	aw_dev->fade_step = AW88081_VOLUME_STEP_DB;
 	aw_dev->volume_desc.mute_volume = AW88081_MUTE_VOL;
 	aw88081_parse_channel_dt(aw88081);
@@ -1102,72 +973,6 @@ static int aw88081_init(struct aw88081 *aw88081, struct i2c_client *i2c, struct
 	return 0;
 }
 
-static int aw88081_dev_init(struct aw88081 *aw88081, struct aw_container *aw_cfg)
-{
-	struct aw_device *aw_dev = aw88081->aw_pa;
-	int ret;
-
-	ret = aw88395_dev_cfg_load(aw_dev, aw_cfg);
-	if (ret) {
-		dev_err(aw_dev->dev, "aw_dev acf parse failed");
-		return -EINVAL;
-	}
-
-	ret = regmap_write(aw_dev->regmap, AW88081_ID_REG, AW88081_SOFT_RESET_VALUE);
-	if (ret)
-		return ret;
-
-	aw_dev->fade_in_time = AW88081_500_US;
-	aw_dev->fade_out_time = AW88081_500_US;
-	aw_dev->prof_cur = AW88081_INIT_PROFILE;
-	aw_dev->prof_index = AW88081_INIT_PROFILE;
-
-	ret = aw88081_dev_fw_update(aw88081);
-	if (ret) {
-		dev_err(aw_dev->dev, "fw update failed ret = %d\n", ret);
-		return ret;
-	}
-
-	aw_dev->status = AW88081_DEV_PW_ON;
-	aw88081_stop(aw88081);
-
-	return 0;
-}
-
-static int aw88081_request_firmware_file(struct aw88081 *aw88081)
-{
-	const struct firmware *cont = NULL;
-	int ret;
-
-	aw88081->aw_pa->fw_status = AW88081_DEV_FW_FAILED;
-
-	ret = request_firmware(&cont, AW88081_ACF_FILE, aw88081->aw_pa->dev);
-	if (ret)
-		return ret;
-
-	dev_dbg(aw88081->aw_pa->dev, "loaded %s - size: %zu\n",
-			AW88081_ACF_FILE, cont ? cont->size : 0);
-
-	aw88081->aw_cfg = devm_kzalloc(aw88081->aw_pa->dev, cont->size + sizeof(int), GFP_KERNEL);
-	if (!aw88081->aw_cfg) {
-		release_firmware(cont);
-		return -ENOMEM;
-	}
-	aw88081->aw_cfg->len = (int)cont->size;
-	memcpy(aw88081->aw_cfg->data, cont->data, cont->size);
-	release_firmware(cont);
-
-	ret = aw88395_dev_load_acf_check(aw88081->aw_pa, aw88081->aw_cfg);
-	if (ret)
-		return ret;
-
-	mutex_lock(&aw88081->lock);
-	ret = aw88081_dev_init(aw88081, aw88081->aw_cfg);
-	mutex_unlock(&aw88081->lock);
-
-	return ret;
-}
-
 static int aw88081_playback_event(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *k, int event)
 {
@@ -1177,7 +982,7 @@ static int aw88081_playback_event(struct snd_soc_dapm_widget *w,
 	mutex_lock(&aw88081->lock);
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		aw88081_start(aw88081, AW88081_ASYNC_START);
+		aw88081_start(aw88081, AW_ASYNC_START);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		aw88081_stop(aw88081);
@@ -1214,9 +1019,13 @@ static int aw88081_codec_probe(struct snd_soc_component *component)
 
 	INIT_DELAYED_WORK(&aw88081->start_work, aw88081_startup_work);
 
-	ret = aw88081_request_firmware_file(aw88081);
-	if (ret)
-		dev_err(aw88081->aw_pa->dev, "%s: request firmware failed\n", __func__);
+	ret = aw_dev_request_firmware_file(aw88081->aw_pa, AW88081_ACF_FILE);
+	if (ret) {
+		dev_err(aw88081->aw_pa->dev, "%s failed\n", __func__);
+		return ret;
+	}
+
+	ret = aw88081_dev_fw_update(aw88081);
 
 	return ret;
 }
diff --git a/sound/soc/codecs/aw88081.h b/sound/soc/codecs/aw88081.h
index 7a4564270ab3..4e356bf0e010 100644
--- a/sound/soc/codecs/aw88081.h
+++ b/sound/soc/codecs/aw88081.h
@@ -286,8 +286,6 @@
 			SNDRV_PCM_FMTBIT_S24_LE | \
 			SNDRV_PCM_FMTBIT_S32_LE)
 
-#define FADE_TIME_MAX			100000
-
 #define AW88081_DEV_DEFAULT_CH		(0)
 #define AW88081_ACF_FILE		"aw88081_acf.bin"
 #define AW88081_DEV_SYSST_CHECK_MAX	(10)
@@ -295,35 +293,4 @@
 
 #define AW88081_INIT_PROFILE		(0)
 
-#define AW88081_PROFILE_EXT(xname, profile_info, profile_get, profile_set) \
-{ \
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name = xname, \
-	.info = profile_info, \
-	.get = profile_get, \
-	.put = profile_set, \
-}
-
-enum {
-	AW88081_SYNC_START = 0,
-	AW88081_ASYNC_START,
-};
-
-enum {
-	AW88081_500_US = 500,
-	AW88081_1000_US = 1000,
-	AW88081_2000_US = 2000,
-	AW88081_5000_US = 5000,
-};
-
-enum {
-	AW88081_DEV_PW_OFF = 0,
-	AW88081_DEV_PW_ON,
-};
-
-enum {
-	AW88081_DEV_FW_FAILED = 0,
-	AW88081_DEV_FW_OK,
-};
-
 #endif
-- 
2.47.0


