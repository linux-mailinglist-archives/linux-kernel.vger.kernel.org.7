Return-Path: <linux-kernel+bounces-857844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB90BE80F8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849911AA195E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1666311C05;
	Fri, 17 Oct 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b="PJVETTIa"
Received: from out198-24.us.a.mail.aliyun.com (out198-24.us.a.mail.aliyun.com [47.90.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F9B27FD5B;
	Fri, 17 Oct 2025 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696830; cv=none; b=i7MnB9lB/Kv2iY5TbtlkVb7tKYo/Aj1ixbALL/V5xVL+bpTcDJT+yi+jqab4TWVX9Y/r6xiKQkNyYFmDv7SCoBnb6eaEon3PktdcmjnYJIigTBFbD6jYt+mb268xDcCZCpTqCSDUjZtauGE7wAIlUy4hlEuejaq6ON5rww9k4T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696830; c=relaxed/simple;
	bh=ycdqKx049ec96ztt5legE1xGnQlokmuCPb4oXnPK5kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwOAdg+tdBbAP46uKozdbQ4kt/eJZsgN6K5YcO/E+5TrFNbNwB4a3VjIyKQnUE8MEsxE2A6s7uE7pG3uqowv2AUEDcZn4yi7GWHPGcj3yw7GStoxKiaOqY+lDJbLwpV1dajrSq/+f7SRc+8Cr1/gLFGKB7pHNKzRTdg8xYLs/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b=PJVETTIa; arc=none smtp.client-ip=47.90.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=awinic.com; s=default;
	t=1760696814; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=N3NMHu79bWTQmAi1Ox9IMsWEADEFAdTNFM0K+1AfHXg=;
	b=PJVETTIazzYVXQzHFnF0J7j2OpldDaKeGJ0r3tsfzmqipPhAo0omclyvD+drdVzsIkinXzx8FY3/3sxaiHKt5D+1v5WLx0Qa/nlPvqFdImJqlO6HYefySnlOEmkkx9KUbR8/KedrWPvc7vk7v2bJ+u70qohIbKocHq7z7C6K4xxEeOr5WdsAcRuQjoS78rZ0591luHbvo7n7l2qjVU/2SOuk9970qaUS0Ru0ifLe344tGypvQvG1KShZfaRASaofer2NyV+4TPeYs2diyi9PQXcwUzKtchxHbJkTBFVYFBfWhKAg0WmCIg7eXzXQkF3s+RjKh7xq7U0BYFPppmQCCg==
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.f0sBY58_1760695875 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 18:11:16 +0800
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
Subject: [PATCH V2 3/7] ASoC: codecs: Rework the aw87390 driver
Date: Fri, 17 Oct 2025 18:11:01 +0800
Message-ID: <20251017101106.370742-4-wangweidong.a@awinic.com>
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

Modify the interface for calling the aw87380 driver
to adapt it for aw-common-device.c and aw-common-firmware.c

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw87390.c | 118 ++++++-------------------------------
 sound/soc/codecs/aw87390.h |  16 -----
 2 files changed, 18 insertions(+), 116 deletions(-)

diff --git a/sound/soc/codecs/aw87390.c b/sound/soc/codecs/aw87390.c
index ef6f64856988..4ed7045a3844 100644
--- a/sound/soc/codecs/aw87390.c
+++ b/sound/soc/codecs/aw87390.c
@@ -12,8 +12,14 @@
 #include <linux/regmap.h>
 #include <sound/soc.h>
 #include "aw87390.h"
-#include "aw88395/aw88395_data_type.h"
-#include "aw88395/aw88395_device.h"
+#include "aw-common-device.h"
+#include "aw-common-firmware.h"
+
+struct aw87390 {
+	struct aw_device *aw_pa;
+	struct mutex lock;
+	struct regmap *regmap;
+};
 
 static const struct regmap_config aw87390_remap_config = {
 	.val_bits = 8,
@@ -47,38 +53,6 @@ static int aw87390_dev_reg_update(struct aw_device *aw_dev,
 	return 0;
 }
 
-static int aw87390_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name)
-{
-	struct aw_prof_info *prof_info = &aw_dev->prof_info;
-	struct aw_prof_desc *prof_desc;
-
-	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
-		dev_err(aw_dev->dev, "index[%d] overflow count[%d]\n",
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
-static int aw87390_dev_get_prof_data(struct aw_device *aw_dev, int index,
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
 static int aw87390_dev_fw_update(struct aw_device *aw_dev)
 {
 	struct aw_prof_desc *prof_index_desc;
@@ -86,7 +60,7 @@ static int aw87390_dev_fw_update(struct aw_device *aw_dev)
 	char *prof_name;
 	int ret;
 
-	ret = aw87390_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
+	ret = aw_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
 	if (ret) {
 		dev_err(aw_dev->dev, "get prof name failed\n");
 		return -EINVAL;
@@ -94,7 +68,7 @@ static int aw87390_dev_fw_update(struct aw_device *aw_dev)
 
 	dev_dbg(aw_dev->dev, "start update %s", prof_name);
 
-	ret = aw87390_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
+	ret = aw_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
 	if (ret) {
 		dev_err(aw_dev->dev, "aw87390_dev_get_prof_data failed\n");
 		return ret;
@@ -102,8 +76,8 @@ static int aw87390_dev_fw_update(struct aw_device *aw_dev)
 
 	/* update reg */
 	sec_desc = prof_index_desc->sec_desc;
-	ret = aw87390_dev_reg_update(aw_dev, sec_desc[AW88395_DATA_TYPE_REG].data,
-					sec_desc[AW88395_DATA_TYPE_REG].len);
+	ret = aw87390_dev_reg_update(aw_dev, sec_desc[AW_DATA_TYPE_REG].data,
+					sec_desc[AW_DATA_TYPE_REG].len);
 	if (ret) {
 		dev_err(aw_dev->dev, "update reg failed\n");
 		return ret;
@@ -159,19 +133,6 @@ static int aw87390_power_on(struct aw_device *aw_dev)
 	return 0;
 }
 
-static int aw87390_dev_set_profile_index(struct aw_device *aw_dev, int index)
-{
-	if ((index >= aw_dev->prof_info.count) || (index < 0))
-		return -EINVAL;
-
-	if (aw_dev->prof_index == index)
-		return -EPERM;
-
-	aw_dev->prof_index = index;
-
-	return 0;
-}
-
 static int aw87390_profile_info(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_info *uinfo)
 {
@@ -196,7 +157,7 @@ static int aw87390_profile_info(struct snd_kcontrol *kcontrol,
 
 	count = uinfo->value.enumerated.item;
 
-	ret = aw87390_dev_get_prof_name(aw87390->aw_pa, count, &prof_name);
+	ret = aw_dev_get_prof_name(aw87390->aw_pa, count, &prof_name);
 	if (ret) {
 		strscpy(uinfo->value.enumerated.name, "null");
 		return 0;
@@ -226,7 +187,7 @@ static int aw87390_profile_set(struct snd_kcontrol *kcontrol,
 	int ret;
 
 	mutex_lock(&aw87390->lock);
-	ret = aw87390_dev_set_profile_index(aw87390->aw_pa, ucontrol->value.integer.value[0]);
+	ret = aw_dev_set_profile_index(aw87390->aw_pa, ucontrol->value.integer.value[0]);
 	if (ret) {
 		dev_dbg(codec->dev, "profile index does not change\n");
 		mutex_unlock(&aw87390->lock);
@@ -244,53 +205,10 @@ static int aw87390_profile_set(struct snd_kcontrol *kcontrol,
 }
 
 static const struct snd_kcontrol_new aw87390_controls[] = {
-	AW87390_PROFILE_EXT("AW87390 Profile Set", aw87390_profile_info,
+	AW_PROFILE_EXT("AW87390 Profile Set", aw87390_profile_info,
 		aw87390_profile_get, aw87390_profile_set),
 };
 
-static int aw87390_request_firmware_file(struct aw87390 *aw87390)
-{
-	const struct firmware *cont = NULL;
-	int ret;
-
-	aw87390->aw_pa->fw_status = AW87390_DEV_FW_FAILED;
-
-	ret = request_firmware(&cont, AW87390_ACF_FILE, aw87390->aw_pa->dev);
-	if (ret)
-		return dev_err_probe(aw87390->aw_pa->dev, ret,
-					"load [%s] failed!\n", AW87390_ACF_FILE);
-
-	dev_dbg(aw87390->aw_pa->dev, "loaded %s - size: %zu\n",
-			AW87390_ACF_FILE, cont ? cont->size : 0);
-
-	aw87390->aw_cfg = devm_kzalloc(aw87390->aw_pa->dev,
-				struct_size(aw87390->aw_cfg, data, cont->size), GFP_KERNEL);
-	if (!aw87390->aw_cfg) {
-		release_firmware(cont);
-		return -ENOMEM;
-	}
-
-	aw87390->aw_cfg->len = cont->size;
-	memcpy(aw87390->aw_cfg->data, cont->data, cont->size);
-	release_firmware(cont);
-
-	ret = aw88395_dev_load_acf_check(aw87390->aw_pa, aw87390->aw_cfg);
-	if (ret) {
-		dev_err(aw87390->aw_pa->dev, "load [%s] failed!\n", AW87390_ACF_FILE);
-		return ret;
-	}
-
-	mutex_lock(&aw87390->lock);
-
-	ret = aw88395_dev_cfg_load(aw87390->aw_pa, aw87390->aw_cfg);
-	if (ret)
-		dev_err(aw87390->aw_pa->dev, "aw_dev acf parse failed\n");
-
-	mutex_unlock(&aw87390->lock);
-
-	return ret;
-}
-
 static int aw87390_drv_event(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *kcontrol, int event)
 {
@@ -331,10 +249,10 @@ static int aw87390_codec_probe(struct snd_soc_component *component)
 	struct aw87390 *aw87390 = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	ret = aw87390_request_firmware_file(aw87390);
+	ret = aw_dev_request_firmware_file(aw87390->aw_pa, AW87390_ACF_FILE);
 	if (ret)
 		return dev_err_probe(aw87390->aw_pa->dev, ret,
-				"aw87390_request_firmware_file failed\n");
+				"aw_request_firmware_file failed\n");
 
 	return 0;
 }
@@ -392,7 +310,7 @@ static int aw87390_init(struct aw87390 **aw87390, struct i2c_client *i2c, struct
 	aw_dev->acf = NULL;
 	aw_dev->prof_info.prof_desc = NULL;
 	aw_dev->prof_info.count = 0;
-	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
+	aw_dev->prof_info.prof_type = AW_DEV_NONE_TYPE_ID;
 	aw_dev->channel = AW87390_DEV_DEFAULT_CH;
 	aw_dev->fw_status = AW87390_DEV_FW_FAILED;
 	aw_dev->prof_index = AW87390_INIT_PROFILE;
diff --git a/sound/soc/codecs/aw87390.h b/sound/soc/codecs/aw87390.h
index d0d049e65991..6023d4d5a0f9 100644
--- a/sound/soc/codecs/aw87390.h
+++ b/sound/soc/codecs/aw87390.h
@@ -52,15 +52,6 @@
 #define AW87390_I2C_NAME		"aw87390"
 #define AW87390_ACF_FILE		"aw87390_acf.bin"
 
-#define AW87390_PROFILE_EXT(xname, profile_info, profile_get, profile_set) \
-{ \
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name = xname, \
-	.info = profile_info, \
-	.get = profile_get, \
-	.put = profile_set, \
-}
-
 enum aw87390_id {
 	AW87390_CHIP_ID = 0x76,
 };
@@ -75,11 +66,4 @@ enum {
 	AW87390_DEV_PW_ON,
 };
 
-struct aw87390 {
-	struct aw_device *aw_pa;
-	struct mutex lock;
-	struct regmap *regmap;
-	struct aw_container *aw_cfg;
-};
-
 #endif
-- 
2.47.0


