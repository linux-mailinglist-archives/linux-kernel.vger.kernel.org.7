Return-Path: <linux-kernel+bounces-857845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0321FBE80FB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16363B1DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C25311C3A;
	Fri, 17 Oct 2025 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b="b1WOEnxa"
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8231A262FF6;
	Fri, 17 Oct 2025 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696830; cv=none; b=UL//SOj5rc4tegkIB1aLnq5oNp+Gylj5N9ywngB4xCvA8i8mgsCGGiRD8FIeIvCUVwrSAxjvep6H8g3Nf5Vz1xsi2Nrr8U7cNuNIgXFD03p4ST3/FAqVpRXG+csQg/h2d7dUoxc58gEOGszhDniVkzUsYHID3K0cPUKOseMljIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696830; c=relaxed/simple;
	bh=wVC4BBQNLQMA19LOd4eq3G+meDZflAkcXfvGZ9sgVqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3Nl511tS6BJ4QGx95DGp+KS/8jjsqmpIjDH/Nl0fV3ZPkAmasYd8PLMfoQ19mgKJ98vwnKaHk4S5Iha7NrkMCNsXCtCd0n6B35PlHIqAzpVJlCOx4/cu1fIvn/T5f9Au6C94Q5Md4lmgy44+BMON7saYwv0HVWKaOiQ5UxAbKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b=b1WOEnxa; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=awinic.com; s=default;
	t=1760696821; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3X2BDWrFIcDEQ/rUhfgjfd+JurrAHOPxxNWAoaDvW20=;
	b=b1WOEnxafqSTG59QmoeczB2cpWACKtYq+9sEZdeB2asxdTWvp2IDRNu1YOWV1YzHeelXORnXPRFI+aPndrOwJdOjRVzTGuvnOPkvWwaXULx/THSIiRh5YohKDbKP5lIVu9Mn+bVrqA7J4W+f0ydDNfMfJvNfTxYtCbO7lomHpy+UH1P6DBed4JeaumkygdFHqoyESjVBHteT+36AI0bUh4fjCZh8V5Ovwk3Y2rHDnD1Vh7ikCuSRW0wkizk2PQHq29vko36rYb/YbDqtWWfcD5f1Szx1Arh//YCfmNwpRfSA5N6Z/S7C1jbjxVH6nBhe+eostzEGL192H3ZulwidkQ==
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.f0sBYEU_1760695881 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 18:11:22 +0800
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
Subject: [PATCH V2 6/7] ASoC: codecs: Rework the aw88261 driver
Date: Fri, 17 Oct 2025 18:11:04 +0800
Message-ID: <20251017101106.370742-7-wangweidong.a@awinic.com>
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

Modify the interface for calling the aw88261 driver
to adapt it for aw-common-device.c and aw-common-firmware.c

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88261.c | 427 ++++++++-----------------------------
 sound/soc/codecs/aw88261.h |  52 -----
 2 files changed, 93 insertions(+), 386 deletions(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index de11ae8dd9d9..48a40b9b5445 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -13,8 +13,22 @@
 #include <linux/regmap.h>
 #include <sound/soc.h>
 #include "aw88261.h"
-#include "aw88395/aw88395_data_type.h"
-#include "aw88395/aw88395_device.h"
+#include "aw-common-device.h"
+#include "aw-common-firmware.h"
+
+struct aw88261 {
+	struct aw_device *aw_pa;
+	struct mutex lock;
+	struct delayed_work start_work;
+	struct regmap *regmap;
+
+	int efuse_check;
+	int frcset_en;
+	unsigned int mute_st;
+	unsigned int amppd_st;
+
+	bool phase_sync;
+};
 
 static const struct regmap_config aw88261_remap_config = {
 	.val_bits = 16,
@@ -24,7 +38,7 @@ static const struct regmap_config aw88261_remap_config = {
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 };
 
-static void aw88261_dev_set_volume(struct aw_device *aw_dev, unsigned int value)
+static void aw88261_set_volume(struct aw_device *aw_dev, unsigned int value)
 {
 	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
 	unsigned int real_value, volume;
@@ -42,105 +56,19 @@ static void aw88261_dev_set_volume(struct aw_device *aw_dev, unsigned int value)
 	regmap_write(aw_dev->regmap, AW88261_SYSCTRL2_REG, real_value);
 }
 
-static void aw88261_dev_fade_in(struct aw_device *aw_dev)
-{
-	struct aw_volume_desc *desc = &aw_dev->volume_desc;
-	int fade_in_vol = desc->ctl_volume;
-	int fade_step = aw_dev->fade_step;
-	int i;
-
-	if (fade_step == 0 || aw_dev->fade_in_time == 0) {
-		aw88261_dev_set_volume(aw_dev, fade_in_vol);
-		return;
-	}
-
-	for (i = AW88261_MUTE_VOL; i >= fade_in_vol; i -= fade_step) {
-		aw88261_dev_set_volume(aw_dev, i);
-		usleep_range(aw_dev->fade_in_time,
-					aw_dev->fade_in_time + 10);
-	}
-
-	if (i != fade_in_vol)
-		aw88261_dev_set_volume(aw_dev, fade_in_vol);
-}
-
-static void aw88261_dev_fade_out(struct aw_device *aw_dev)
-{
-	struct aw_volume_desc *desc = &aw_dev->volume_desc;
-	int fade_step = aw_dev->fade_step;
-	int i;
-
-	if (fade_step == 0 || aw_dev->fade_out_time == 0) {
-		aw88261_dev_set_volume(aw_dev, AW88261_MUTE_VOL);
-		return;
-	}
-
-	for (i = desc->ctl_volume; i <= AW88261_MUTE_VOL; i += fade_step) {
-		aw88261_dev_set_volume(aw_dev, i);
-		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
-	}
-
-	if (i != AW88261_MUTE_VOL) {
-		aw88261_dev_set_volume(aw_dev, AW88261_MUTE_VOL);
-		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
-	}
-}
-
-static void aw88261_dev_i2s_tx_enable(struct aw_device *aw_dev, bool flag)
-{
-	if (flag)
-		regmap_update_bits(aw_dev->regmap, AW88261_I2SCFG1_REG,
-			~AW88261_I2STXEN_MASK, AW88261_I2STXEN_ENABLE_VALUE);
-	else
-		regmap_update_bits(aw_dev->regmap, AW88261_I2SCFG1_REG,
-			~AW88261_I2STXEN_MASK, AW88261_I2STXEN_DISABLE_VALUE);
-}
-
-static void aw88261_dev_pwd(struct aw_device *aw_dev, bool pwd)
-{
-	if (pwd)
-		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
-				~AW88261_PWDN_MASK, AW88261_PWDN_POWER_DOWN_VALUE);
-	else
-		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
-				~AW88261_PWDN_MASK, AW88261_PWDN_WORKING_VALUE);
-}
-
-static void aw88261_dev_amppd(struct aw_device *aw_dev, bool amppd)
-{
-	if (amppd)
-		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
-				~AW88261_AMPPD_MASK, AW88261_AMPPD_POWER_DOWN_VALUE);
-	else
-		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
-				~AW88261_AMPPD_MASK, AW88261_AMPPD_WORKING_VALUE);
-}
-
 static void aw88261_dev_mute(struct aw_device *aw_dev, bool is_mute)
 {
 	if (is_mute) {
-		aw88261_dev_fade_out(aw_dev);
+		aw_dev_fade_out(aw_dev, aw88261_set_volume);
 		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
 				~AW88261_HMUTE_MASK, AW88261_HMUTE_ENABLE_VALUE);
 	} else {
 		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
 				~AW88261_HMUTE_MASK, AW88261_HMUTE_DISABLE_VALUE);
-		aw88261_dev_fade_in(aw_dev);
+		aw_dev_fade_in(aw_dev, aw88261_set_volume);
 	}
 }
 
-static void aw88261_dev_clear_int_status(struct aw_device *aw_dev)
-{
-	unsigned int int_status;
-
-	/* read int status and clear */
-	regmap_read(aw_dev->regmap, AW88261_SYSINT_REG, &int_status);
-	/* make sure int status is clear */
-	regmap_read(aw_dev->regmap, AW88261_SYSINT_REG, &int_status);
-
-	dev_dbg(aw_dev->dev, "read interrupt reg = 0x%04x", int_status);
-}
-
 static int aw88261_dev_get_iis_status(struct aw_device *aw_dev)
 {
 	unsigned int reg_val;
@@ -165,7 +93,7 @@ static int aw88261_dev_check_mode1_pll(struct aw_device *aw_dev)
 		ret = aw88261_dev_get_iis_status(aw_dev);
 		if (ret) {
 			dev_err(aw_dev->dev, "mode1 iis signal check error");
-			usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
 		} else {
 			return ret;
 		}
@@ -199,7 +127,7 @@ static int aw88261_dev_check_mode2_pll(struct aw_device *aw_dev)
 		ret = aw88261_dev_get_iis_status(aw_dev);
 		if (ret) {
 			dev_err(aw_dev->dev, "mode2 iis signal check error");
-			usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
 		} else {
 			break;
 		}
@@ -209,12 +137,12 @@ static int aw88261_dev_check_mode2_pll(struct aw_device *aw_dev)
 	ret = regmap_update_bits(aw_dev->regmap, AW88261_PLLCTRL1_REG,
 			~AW88261_CCO_MUX_MASK, AW88261_CCO_MUX_BYPASS_VALUE);
 	if (ret == 0) {
-		usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+		usleep_range(AW_2000_US, AW_2000_US + 10);
 		for (i = 0; i < AW88261_DEV_SYSST_CHECK_MAX; i++) {
 			ret = aw88261_dev_check_mode1_pll(aw_dev);
 			if (ret) {
 				dev_err(aw_dev->dev, "mode2 switch to mode1, iis signal check error");
-				usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+				usleep_range(AW_2000_US, AW_2000_US + 10);
 			} else {
 				break;
 			}
@@ -257,7 +185,7 @@ static int aw88261_dev_check_sysst(struct aw_device *aw_dev)
 		if (check_val != AW88261_BIT_SYSST_CHECK) {
 			dev_err(aw_dev->dev, "check sysst fail, reg_val=0x%04x, check:0x%x",
 				reg_val, AW88261_BIT_SYSST_CHECK);
-			usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+			usleep_range(AW_2000_US, AW_2000_US + 10);
 		} else {
 			return 0;
 		}
@@ -266,18 +194,6 @@ static int aw88261_dev_check_sysst(struct aw_device *aw_dev)
 	return -EPERM;
 }
 
-static void aw88261_dev_uls_hmute(struct aw_device *aw_dev, bool uls_hmute)
-{
-	if (uls_hmute)
-		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
-				~AW88261_ULS_HMUTE_MASK,
-				AW88261_ULS_HMUTE_ENABLE_VALUE);
-	else
-		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
-				~AW88261_ULS_HMUTE_MASK,
-				AW88261_ULS_HMUTE_DISABLE_VALUE);
-}
-
 static void aw88261_reg_force_set(struct aw88261 *aw88261)
 {
 	if (aw88261->frcset_en == AW88261_FRCSET_ENABLE) {
@@ -471,43 +387,11 @@ static int aw88261_dev_reg_update(struct aw88261 *aw88261,
 		vol_desc->ctl_volume = 0;
 
 	/* keep min volume */
-	aw88261_dev_set_volume(aw_dev, vol_desc->mute_volume);
+	aw88261_set_volume(aw_dev, vol_desc->mute_volume);
 
 	return ret;
 }
 
-static int aw88261_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name)
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
-static int aw88261_dev_get_prof_data(struct aw_device *aw_dev, int index,
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
-
 static int aw88261_dev_fw_update(struct aw88261 *aw88261)
 {
 	struct aw_device *aw_dev = aw88261->aw_pa;
@@ -516,7 +400,7 @@ static int aw88261_dev_fw_update(struct aw88261 *aw88261)
 	char *prof_name;
 	int ret;
 
-	ret = aw88261_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
+	ret = aw_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
 	if (ret) {
 		dev_err(aw_dev->dev, "get prof name failed");
 		return -EINVAL;
@@ -524,14 +408,14 @@ static int aw88261_dev_fw_update(struct aw88261 *aw88261)
 
 	dev_dbg(aw_dev->dev, "start update %s", prof_name);
 
-	ret = aw88261_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
+	ret = aw_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
 	if (ret)
 		return ret;
 
 	/* update reg */
 	sec_desc = prof_index_desc->sec_desc;
-	ret = aw88261_dev_reg_update(aw88261, sec_desc[AW88395_DATA_TYPE_REG].data,
-					sec_desc[AW88395_DATA_TYPE_REG].len);
+	ret = aw88261_dev_reg_update(aw88261, sec_desc[AW_DATA_TYPE_REG].data,
+					sec_desc[AW_DATA_TYPE_REG].len);
 	if (ret) {
 		dev_err(aw_dev->dev, "update reg failed");
 		return ret;
@@ -547,14 +431,15 @@ static int aw88261_dev_start(struct aw88261 *aw88261)
 	struct aw_device *aw_dev = aw88261->aw_pa;
 	int ret;
 
-	if (aw_dev->status == AW88261_DEV_PW_ON) {
+	if (aw_dev->status == AW_DEV_PW_ON) {
 		dev_info(aw_dev->dev, "already power on");
 		return 0;
 	}
 
 	/* power on */
-	aw88261_dev_pwd(aw_dev, false);
-	usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+	regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_PWDN_MASK, AW88261_PWDN_WORKING_VALUE);
+	usleep_range(AW_2000_US, AW_2000_US + 10);
 
 	ret = aw88261_dev_check_syspll(aw_dev);
 	if (ret) {
@@ -563,8 +448,9 @@ static int aw88261_dev_start(struct aw88261 *aw88261)
 	}
 
 	/* amppd on */
-	aw88261_dev_amppd(aw_dev, false);
-	usleep_range(AW88261_1000_US, AW88261_1000_US + 50);
+	regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_AMPPD_MASK, AW88261_AMPPD_WORKING_VALUE);
+	usleep_range(AW_1000_US, AW_1000_US + 50);
 
 	/* check i2s status */
 	ret = aw88261_dev_check_sysst(aw_dev);
@@ -574,62 +460,72 @@ static int aw88261_dev_start(struct aw88261 *aw88261)
 	}
 
 	/* enable tx feedback */
-	aw88261_dev_i2s_tx_enable(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88261_I2SCFG1_REG,
+				~AW88261_I2STXEN_MASK, AW88261_I2STXEN_ENABLE_VALUE);
 
 	if (aw88261->amppd_st)
-		aw88261_dev_amppd(aw_dev, true);
+		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_AMPPD_MASK, AW88261_AMPPD_POWER_DOWN_VALUE);
 
 	aw88261_reg_force_set(aw88261);
 
 	/* close uls mute */
-	aw88261_dev_uls_hmute(aw_dev, false);
+	regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_ULS_HMUTE_MASK, AW88261_ULS_HMUTE_DISABLE_VALUE);
 
 	/* close mute */
 	if (!aw88261->mute_st)
 		aw88261_dev_mute(aw_dev, false);
 
 	/* clear inturrupt */
-	aw88261_dev_clear_int_status(aw_dev);
-	aw_dev->status = AW88261_DEV_PW_ON;
+	aw_dev_clear_int_status(aw_dev);
+	aw_dev->status = AW_DEV_PW_ON;
 
 	return 0;
 
 sysst_check_fail:
-	aw88261_dev_i2s_tx_enable(aw_dev, false);
-	aw88261_dev_clear_int_status(aw_dev);
-	aw88261_dev_amppd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88261_I2SCFG1_REG,
+				~AW88261_I2STXEN_MASK, AW88261_I2STXEN_DISABLE_VALUE);
+	aw_dev_clear_int_status(aw_dev);
+	regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_AMPPD_MASK, AW88261_AMPPD_POWER_DOWN_VALUE);
 pll_check_fail:
-	aw88261_dev_pwd(aw_dev, true);
-	aw_dev->status = AW88261_DEV_PW_OFF;
+	regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_PWDN_MASK, AW88261_PWDN_POWER_DOWN_VALUE);
+	aw_dev->status = AW_DEV_PW_OFF;
 
 	return ret;
 }
 
 static int aw88261_dev_stop(struct aw_device *aw_dev)
 {
-	if (aw_dev->status == AW88261_DEV_PW_OFF) {
+	if (aw_dev->status == AW_DEV_PW_OFF) {
 		dev_info(aw_dev->dev, "already power off");
 		return 0;
 	}
 
-	aw_dev->status = AW88261_DEV_PW_OFF;
+	aw_dev->status = AW_DEV_PW_OFF;
 
 	/* clear inturrupt */
-	aw88261_dev_clear_int_status(aw_dev);
+	aw_dev_clear_int_status(aw_dev);
 
-	aw88261_dev_uls_hmute(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_ULS_HMUTE_MASK, AW88261_ULS_HMUTE_ENABLE_VALUE);
 	/* set mute */
 	aw88261_dev_mute(aw_dev, true);
 
 	/* close tx feedback */
-	aw88261_dev_i2s_tx_enable(aw_dev, false);
-	usleep_range(AW88261_1000_US, AW88261_1000_US + 100);
+	regmap_update_bits(aw_dev->regmap, AW88261_I2SCFG1_REG,
+				~AW88261_I2STXEN_MASK, AW88261_I2STXEN_DISABLE_VALUE);
+	usleep_range(AW_1000_US, AW_1000_US + 100);
 
 	/* enable amppd */
-	aw88261_dev_amppd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_AMPPD_MASK, AW88261_AMPPD_POWER_DOWN_VALUE);
 
 	/* set power down */
-	aw88261_dev_pwd(aw_dev, true);
+	regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_PWDN_MASK, AW88261_PWDN_POWER_DOWN_VALUE);
 
 	return 0;
 }
@@ -696,18 +592,17 @@ static void aw88261_startup_work(struct work_struct *work)
 
 static void aw88261_start(struct aw88261 *aw88261, bool sync_start)
 {
-	if (aw88261->aw_pa->fw_status != AW88261_DEV_FW_OK)
+	if (aw88261->aw_pa->fw_status != AW_DEV_FW_OK)
 		return;
 
-	if (aw88261->aw_pa->status == AW88261_DEV_PW_ON)
+	if (aw88261->aw_pa->status == AW_DEV_PW_ON)
 		return;
 
-	if (sync_start == AW88261_SYNC_START)
+	if (sync_start == AW_SYNC_START)
 		aw88261_start_pa(aw88261);
 	else
 		queue_delayed_work(system_wq,
-			&aw88261->start_work,
-			AW88261_START_WORK_DELAY_MS);
+			&aw88261->start_work, AW88261_START_WORK_DELAY_MS);
 }
 
 static struct snd_soc_dai_driver aw88261_dai[] = {
@@ -838,7 +733,7 @@ static int aw88261_profile_info(struct snd_kcontrol *kcontrol,
 
 	count = uinfo->value.enumerated.item;
 
-	ret = aw88261_dev_get_prof_name(aw88261->aw_pa, count, &prof_name);
+	ret = aw_dev_get_prof_name(aw88261->aw_pa, count, &prof_name);
 	if (ret) {
 		strscpy(uinfo->value.enumerated.name, "null");
 		return 0;
@@ -878,7 +773,7 @@ static int aw88261_profile_set(struct snd_kcontrol *kcontrol,
 
 	if (aw88261->aw_pa->status) {
 		aw88261_dev_stop(aw88261->aw_pa);
-		aw88261_start(aw88261, AW88261_SYNC_START);
+		aw88261_start(aw88261, AW_SYNC_START);
 	}
 
 	mutex_unlock(&aw88261->lock);
@@ -915,7 +810,7 @@ static int aw88261_volume_set(struct snd_kcontrol *kcontrol,
 
 	if (vol_desc->ctl_volume != value) {
 		vol_desc->ctl_volume = value;
-		aw88261_dev_set_volume(aw88261->aw_pa, vol_desc->ctl_volume);
+		aw88261_set_volume(aw88261->aw_pa, vol_desc->ctl_volume);
 
 		return 1;
 	}
@@ -965,7 +860,7 @@ static const struct snd_kcontrol_new aw88261_controls[] = {
 		aw88261_get_fade_in_time, aw88261_set_fade_in_time),
 	SOC_SINGLE_EXT("Volume Ramp Down Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
 		aw88261_get_fade_out_time, aw88261_set_fade_out_time),
-	AW88261_PROFILE_EXT("Profile Set", aw88261_profile_info,
+	AW_PROFILE_EXT("Profile Set", aw88261_profile_info,
 		aw88261_profile_get, aw88261_profile_set),
 };
 
@@ -978,7 +873,7 @@ static int aw88261_playback_event(struct snd_soc_dapm_widget *w,
 	mutex_lock(&aw88261->lock);
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		aw88261_start(aw88261, AW88261_ASYNC_START);
+		aw88261_start(aw88261, AW_ASYNC_START);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		aw88261_dev_stop(aw88261->aw_pa);
@@ -993,7 +888,7 @@ static int aw88261_playback_event(struct snd_soc_dapm_widget *w,
 
 static const struct snd_soc_dapm_widget aw88261_dapm_widgets[] = {
 	 /* playback */
-	SND_SOC_DAPM_AIF_IN_E("AIF_RX", "Speaker_Playback", 0, 0, 0, 0,
+	SND_SOC_DAPM_AIF_IN_E("AIF_RX", "Speaker_Playback", 0, SND_SOC_NOPM, 0, 0,
 					aw88261_playback_event,
 					SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_OUTPUT("DAC Output"),
@@ -1040,123 +935,31 @@ static int aw88261_frcset_check(struct aw88261 *aw88261)
 	return ret;
 }
 
-static int aw88261_dev_init(struct aw88261 *aw88261, struct aw_container *aw_cfg)
+static int aw88261_codec_probe(struct snd_soc_component *component)
 {
-	struct aw_device *aw_dev = aw88261->aw_pa;
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	ret = aw88395_dev_cfg_load(aw_dev, aw_cfg);
-	if (ret) {
-		dev_err(aw_dev->dev, "aw_dev acf parse failed");
-		return -EINVAL;
-	}
+	INIT_DELAYED_WORK(&aw88261->start_work, aw88261_startup_work);
 
-	ret = regmap_write(aw_dev->regmap, AW88261_ID_REG, AW88261_SOFT_RESET_VALUE);
+	ret = aw_dev_request_firmware_file(aw88261->aw_pa, AW88261_ACF_FILE);
 	if (ret)
-		return ret;
+		return dev_err_probe(aw88261->aw_pa->dev, ret,
+				"aw88261_request_firmware_file failed\n");
 
-	aw_dev->fade_in_time = AW88261_500_US;
-	aw_dev->fade_out_time = AW88261_500_US;
-	aw_dev->prof_cur = AW88261_INIT_PROFILE;
-	aw_dev->prof_index = AW88261_INIT_PROFILE;
 
 	ret = aw88261_dev_fw_update(aw88261);
 	if (ret) {
-		dev_err(aw_dev->dev, "fw update failed ret = %d\n", ret);
+		dev_err(aw88261->aw_pa->dev, "fw update failed ret = %d\n", ret);
 		return ret;
 	}
 
 	ret = aw88261_frcset_check(aw88261);
 	if (ret) {
-		dev_err(aw_dev->dev, "aw88261_frcset_check ret = %d\n", ret);
+		dev_err(aw88261->aw_pa->dev, "aw88261_frcset_check ret = %d\n", ret);
 		return ret;
 	}
 
-	aw88261_dev_clear_int_status(aw_dev);
-
-	aw88261_dev_uls_hmute(aw_dev, true);
-
-	aw88261_dev_mute(aw_dev, true);
-
-	aw88261_dev_i2s_tx_enable(aw_dev, false);
-
-	usleep_range(AW88261_1000_US, AW88261_1000_US + 100);
-
-	aw88261_dev_amppd(aw_dev, true);
-
-	aw88261_dev_pwd(aw_dev, true);
-
-	return 0;
-}
-
-static int aw88261_request_firmware_file(struct aw88261 *aw88261)
-{
-	const struct firmware *cont = NULL;
-	int ret;
-
-	aw88261->aw_pa->fw_status = AW88261_DEV_FW_FAILED;
-
-	ret = request_firmware(&cont, AW88261_ACF_FILE, aw88261->aw_pa->dev);
-	if (ret)
-		return dev_err_probe(aw88261->aw_pa->dev, ret,
-					"load [%s] failed!", AW88261_ACF_FILE);
-
-	dev_info(aw88261->aw_pa->dev, "loaded %s - size: %zu\n",
-			AW88261_ACF_FILE, cont ? cont->size : 0);
-
-	aw88261->aw_cfg = devm_kzalloc(aw88261->aw_pa->dev, cont->size + sizeof(int), GFP_KERNEL);
-	if (!aw88261->aw_cfg) {
-		release_firmware(cont);
-		return -ENOMEM;
-	}
-	aw88261->aw_cfg->len = (int)cont->size;
-	memcpy(aw88261->aw_cfg->data, cont->data, cont->size);
-	release_firmware(cont);
-
-	ret = aw88395_dev_load_acf_check(aw88261->aw_pa, aw88261->aw_cfg);
-	if (ret) {
-		dev_err(aw88261->aw_pa->dev, "load [%s] failed !", AW88261_ACF_FILE);
-		return ret;
-	}
-
-	mutex_lock(&aw88261->lock);
-	/* aw device init */
-	ret = aw88261_dev_init(aw88261, aw88261->aw_cfg);
-	if (ret)
-		dev_err(aw88261->aw_pa->dev, "dev init failed");
-	mutex_unlock(&aw88261->lock);
-
-	return ret;
-}
-
-static int aw88261_codec_probe(struct snd_soc_component *component)
-{
-	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
-	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(component);
-	int ret;
-
-	INIT_DELAYED_WORK(&aw88261->start_work, aw88261_startup_work);
-
-	ret = aw88261_request_firmware_file(aw88261);
-	if (ret)
-		return dev_err_probe(aw88261->aw_pa->dev, ret,
-				"aw88261_request_firmware_file failed\n");
-
-	/* add widgets */
-	ret = snd_soc_dapm_new_controls(dapm, aw88261_dapm_widgets,
-							ARRAY_SIZE(aw88261_dapm_widgets));
-	if (ret)
-		return ret;
-
-	/* add route */
-	ret = snd_soc_dapm_add_routes(dapm, aw88261_audio_map,
-							ARRAY_SIZE(aw88261_audio_map));
-	if (ret)
-		return ret;
-
-	ret = snd_soc_add_component_controls(component, aw88261_controls,
-							ARRAY_SIZE(aw88261_controls));
-
 	return ret;
 }
 
@@ -1170,62 +973,14 @@ static void aw88261_codec_remove(struct snd_soc_component *aw_codec)
 static const struct snd_soc_component_driver soc_codec_dev_aw88261 = {
 	.probe = aw88261_codec_probe,
 	.remove = aw88261_codec_remove,
+	.dapm_widgets = aw88261_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(aw88261_dapm_widgets),
+	.dapm_routes = aw88261_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(aw88261_audio_map),
+	.controls = aw88261_controls,
+	.num_controls = ARRAY_SIZE(aw88261_controls),
 };
 
-static void aw88261_parse_channel_dt(struct aw88261 *aw88261)
-{
-	struct aw_device *aw_dev = aw88261->aw_pa;
-	struct device_node *np = aw_dev->dev->of_node;
-	u32 channel_value = AW88261_DEV_DEFAULT_CH;
-
-	of_property_read_u32(np, "awinic,audio-channel", &channel_value);
-	aw88261->phase_sync = of_property_read_bool(np, "awinic,sync-flag");
-
-	aw_dev->channel = channel_value;
-}
-
-static int aw88261_init(struct aw88261 **aw88261, struct i2c_client *i2c, struct regmap *regmap)
-{
-	struct aw_device *aw_dev;
-	unsigned int chip_id;
-	int ret;
-
-	/* read chip id */
-	ret = regmap_read(regmap, AW88261_ID_REG, &chip_id);
-	if (ret) {
-		dev_err(&i2c->dev, "%s read chipid error. ret = %d", __func__, ret);
-		return ret;
-	}
-	if (chip_id != AW88261_CHIP_ID) {
-		dev_err(&i2c->dev, "unsupported device");
-		return -ENXIO;
-	}
-
-	dev_info(&i2c->dev, "chip id = %x\n", chip_id);
-
-	aw_dev = devm_kzalloc(&i2c->dev, sizeof(*aw_dev), GFP_KERNEL);
-	if (!aw_dev)
-		return -ENOMEM;
-
-	(*aw88261)->aw_pa = aw_dev;
-	aw_dev->i2c = i2c;
-	aw_dev->regmap = regmap;
-	aw_dev->dev = &i2c->dev;
-	aw_dev->chip_id = AW88261_CHIP_ID;
-	aw_dev->acf = NULL;
-	aw_dev->prof_info.prof_desc = NULL;
-	aw_dev->prof_info.count = 0;
-	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
-	aw_dev->channel = 0;
-	aw_dev->fw_status = AW88261_DEV_FW_FAILED;
-	aw_dev->fade_step = AW88261_VOLUME_STEP_DB;
-	aw_dev->volume_desc.ctl_volume = AW88261_VOL_DEFAULT_VALUE;
-	aw_dev->volume_desc.mute_volume = AW88261_MUTE_VOL;
-	aw88261_parse_channel_dt(*aw88261);
-
-	return ret;
-}
-
 static int aw88261_i2c_probe(struct i2c_client *i2c)
 {
 	struct aw88261 *aw88261;
@@ -1249,8 +1004,12 @@ static int aw88261_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, ret, "failed to init regmap: %d\n", ret);
 	}
 
+	aw88261->aw_pa = devm_kzalloc(&i2c->dev, sizeof(*aw88261->aw_pa), GFP_KERNEL);
+	if (!aw88261->aw_pa)
+		return -ENOMEM;
+
 	/* aw pa init */
-	ret = aw88261_init(&aw88261, i2c, aw88261->regmap);
+	ret = aw_dev_init(aw88261->aw_pa, i2c, aw88261->regmap);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/codecs/aw88261.h b/sound/soc/codecs/aw88261.h
index 734d0f93ced9..4ec0fe3ad033 100644
--- a/sound/soc/codecs/aw88261.h
+++ b/sound/soc/codecs/aw88261.h
@@ -378,8 +378,6 @@
 			SNDRV_PCM_FMTBIT_S24_LE | \
 			SNDRV_PCM_FMTBIT_S32_LE)
 
-#define FADE_TIME_MAX			100000
-#define FADE_TIME_MIN			0
 
 #define AW88261_DEV_DEFAULT_CH		(0)
 #define AW88261_ACF_FILE		"aw88261_acf.bin"
@@ -396,40 +394,6 @@
 					AW88261_VOL_6DB_START) + \
 					((value) % AW88261_VOLUME_STEP_DB))
 
-#define AW88261_PROFILE_EXT(xname, profile_info, profile_get, profile_set) \
-{ \
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name = xname, \
-	.info = profile_info, \
-	.get = profile_get, \
-	.put = profile_set, \
-}
-
-enum {
-	AW88261_SYNC_START = 0,
-	AW88261_ASYNC_START,
-};
-
-enum aw88261_id {
-	AW88261_CHIP_ID = 0x2113,
-};
-
-enum {
-	AW88261_500_US = 500,
-	AW88261_1000_US = 1000,
-	AW88261_2000_US = 2000,
-};
-
-enum {
-	AW88261_DEV_PW_OFF = 0,
-	AW88261_DEV_PW_ON,
-};
-
-enum {
-	AW88261_DEV_FW_FAILED = 0,
-	AW88261_DEV_FW_OK,
-};
-
 enum {
 	AW88261_EF_AND_CHECK = 0,
 	AW88261_EF_OR_CHECK,
@@ -440,20 +404,4 @@ enum {
 	AW88261_FRCSET_ENABLE,
 };
 
-struct aw88261 {
-	struct aw_device *aw_pa;
-	struct mutex lock;
-	struct gpio_desc *reset_gpio;
-	struct delayed_work start_work;
-	struct regmap *regmap;
-	struct aw_container *aw_cfg;
-
-	int efuse_check;
-	int frcset_en;
-	unsigned int mute_st;
-	unsigned int amppd_st;
-
-	bool phase_sync;
-};
-
 #endif
-- 
2.47.0


