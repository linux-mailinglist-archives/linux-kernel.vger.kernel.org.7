Return-Path: <linux-kernel+bounces-873764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC1FC14A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9789B5660F2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F1732E158;
	Tue, 28 Oct 2025 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b="cnR8TMPm"
Received: from out198-23.us.a.mail.aliyun.com (out198-23.us.a.mail.aliyun.com [47.90.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85932BF5B;
	Tue, 28 Oct 2025 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654870; cv=none; b=WsDbfjreTwqtJTtXCQCoySLNvucY+tHUbTbF98PEqZUIFgivlj38ggi8QGoGBVgtEA7c6h/DUsyX7r48F8kNhTTTKPX+xNBfOvBtBwXfMAqSA74+C0cduotXUSabta51Bfr47CsiKvEx4k+913kIOkb5zlyhPTdKegygP/2GNeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654870; c=relaxed/simple;
	bh=VuEnwqvbtyp9zrV7y7H0RaWhWmEyxk+VDj79aU/8KpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0y4tnrxOLIwUMItEcBTxwc5gwKL5J0SE087AqP9RrHSh0kyVKRGjMI38S0LxwbRiok4A8EXmMS2TrRJowmBrDvw5r3ufxaxy/Ru5hJcqmttN6VtNbk0J7E7ahh8MNF4bgTFdJRvFa2Kemf8rPm7FMXdml7u2U96XCG5VjRFALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b=cnR8TMPm; arc=none smtp.client-ip=47.90.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=awinic.com; s=default;
	t=1761654849; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yTaZ9WKK6+Wog8z8pdZcMi56u0KyufhqBxn/sQxeM7M=;
	b=cnR8TMPmI4yYG0E3mDfEkFcw4l1N0Fmv6TeV4SFA1MVA+Y2KVB0Yq09LRAo0llZmG07NunVkn1y1//Fsfoo70VdmNZnR725dFzDzuPLpTnSPCi9xdky+WIeYu1ey6M5BRKuPW3b0qIktC9L7h+KpUbXGRWKo+N6ZYEqs0pACuX1pWwSWxz7LfpnYER3jswx0QHXoNaNqP4cJIljRcCMlRq8+wR0rgOxHFigOIqAp73KYVoJLsN0Nt+oaY9/G19Bv2IWsFzIYMEhRnZV3Fqm9f35z575DJNbLG4e+OOAXG4quDUpH9QAkqQMYK3jCiKPjEGP9G5L/hYjNCCbzqhG5hA==
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.f9Oy7GJ_1761654846 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 28 Oct 2025 20:34:07 +0800
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
Subject: [PATCH V3 3/7] ASoC: codecs: Rework the aw87390 driver
Date: Tue, 28 Oct 2025 20:33:53 +0800
Message-ID: <20251028123357.46161-4-wangweidong.a@awinic.com>
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

Modify the interface for calling the aw87390 driver
to adapt it for aw-common-device.c and aw-common-firmware.c

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw87390.c | 118 ++++++-------------------------------
 sound/soc/codecs/aw87390.h |  16 -----
 2 files changed, 18 insertions(+), 116 deletions(-)

diff --git a/sound/soc/codecs/aw87390.c b/sound/soc/codecs/aw87390.c
index 460b782e96a1..4ac0a5eaa9a4 100644
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


