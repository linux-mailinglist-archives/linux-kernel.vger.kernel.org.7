Return-Path: <linux-kernel+bounces-742674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2896BB0F539
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFC65418BC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D752EF65E;
	Wed, 23 Jul 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Oj+KUwAJ"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29C2EF2B4;
	Wed, 23 Jul 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280728; cv=none; b=ayt4wuIMSKcyNT7o4UQTIElKLWmVJmP8b+Wyg8dwcVmRbmO53ji0NV+tWwpZV6YjSTJbImbqt29iXFjG+Ic4u1v/UYrQHpo8LSxrv+0KBNpeaohR7jNZwZtn+UKf15ZDsCxxgFC7szuUxV1Kzr92bEv5sVd/bOknCCAu2vGbPKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280728; c=relaxed/simple;
	bh=u5iZQ8dN6yf5D+SM9p9rwTEARRhqkdp06+1ijnDild0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uwbE5RXJDA4Mz73qijdtxuQezVzo5+fhLmhOeHiHvC3F+3qJHkwbhCBvGlJistRWWSUjBS2dV5Hj/MVlGyw2ZgRM0rQVvuieqkrlHB7E8mIOgkCaaN3e7VK4NDHWocw+8V7u6Aun7THD74RRTN5jUSQDSiNHa8n/yLbTkKwVTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Oj+KUwAJ; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56NEP4ZP1293959;
	Wed, 23 Jul 2025 09:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753280704;
	bh=m0I1U8Ta9jnlUKeHE3PthL9OU0Tk6NcNozE1C+8udug=;
	h=From:To:CC:Subject:Date;
	b=Oj+KUwAJb21hNMHl4pcD1oZ/b2Lhj4T+0w+R+xAUf1Sjpv2Og8krNAALyxysD7maN
	 MhmUhI1KhNOFmo5HFksgFJ8a941nXZGFkepu1a3J6qInyo97wIMtycTPsd6KDTACGc
	 taNQojpWQu4FC92qCoTIwa2EJNImOcUr7RoqN36A=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56NEP41m2425924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 23 Jul 2025 09:25:04 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 23
 Jul 2025 09:25:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 23 Jul 2025 09:25:03 -0500
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56NEOtsi2832695;
	Wed, 23 Jul 2025 09:24:56 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <shenghao-ding@ti.com>,
        <13916275206@139.com>, <v-po@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <baojun.xu@ti.com>
Subject: [PATCH v2] ALSA: hda: Add TAS2770 support
Date: Wed, 23 Jul 2025 22:24:23 +0800
Message-ID: <20250723142423.38768-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add TAS2770 support in TI's HDA driver. And add hda_chip_id for
more products. Distinguish DSP and non-DSP in firmware
loading function.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

---
v2:
 - Rewrite the patch description
 - Move registers define for TAS2770 from tas2781.h to tas2770-tlv.h
 - Add new chip ID define for HDA
 - Add digital volume control in tas2770_snd_controls
 - Change public kcontrol name from tas27xx_ to tasdevice_
 - Create new function for kcontrol adding
 - Create new function for DSP binary loading
 - Rename chip_id to hda_chip_id in i2c_probe for the supported devices
---
 include/sound/tas2770-tlv.h                   |  23 +++
 .../hda/codecs/side-codecs/tas2781_hda_i2c.c  | 161 +++++++++++-------
 2 files changed, 127 insertions(+), 57 deletions(-)
 create mode 100644 include/sound/tas2770-tlv.h

diff --git a/include/sound/tas2770-tlv.h b/include/sound/tas2770-tlv.h
new file mode 100644
index 000000000000..c0bd495b4a07
--- /dev/null
+++ b/include/sound/tas2770-tlv.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+//
+// ALSA SoC Texas Instruments TAS2770 Audio Smart Amplifier
+//
+// Copyright (C) 2025 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The TAS2770 hda driver implements for one, two, or even multiple
+// TAS2770 chips.
+//
+// Author: Baojun Xu <baojun.xu@ti.com>
+//
+
+#ifndef __TAS2770_TLV_H__
+#define __TAS2770_TLV_H__
+
+#define TAS2770_DVC_LEVEL		TASDEVICE_REG(0x0, 0x0, 0x17)
+#define TAS2770_AMP_LEVEL		TASDEVICE_REG(0x0, 0x0, 0x03)
+
+static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2770_dvc_tlv, 1650, 50, 0);
+static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2770_amp_tlv, 1100, 50, 0);
+
+#endif
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index bacc3f6ed4bd..65a48326f5b9 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -24,6 +24,7 @@
 #include <sound/tas2781.h>
 #include <sound/tas2781-comlib-i2c.h>
 #include <sound/tlv.h>
+#include <sound/tas2770-tlv.h>
 #include <sound/tas2781-tlv.h>
 
 #include "hda_local.h"
@@ -45,9 +46,18 @@
 #define TAS2563_CAL_TLIM		TASDEVICE_REG(0, 0x10, 0x14)
 #define TAS2563_CAL_R0			TASDEVICE_REG(0, 0x0f, 0x34)
 
+enum device_chip_id {
+	HDA_TAS2563,
+	HDA_TAS2770,
+	HDA_TAS2781,
+	HDA_OTHERS
+};
+
 struct tas2781_hda_i2c_priv {
 	struct snd_kcontrol *snd_ctls[2];
 	int (*save_calibration)(struct tas2781_hda *h);
+
+	int hda_chip_id;
 };
 
 static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
@@ -245,6 +255,15 @@ static int tas2781_force_fwload_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
+static const struct snd_kcontrol_new tas2770_snd_controls[] = {
+	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Volume", TAS2770_AMP_LEVEL,
+		0, 0, 20, 0, tas2781_amp_getvol,
+		tas2781_amp_putvol, tas2770_amp_tlv),
+	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Digital Volume", TAS2770_DVC_LEVEL,
+		0, 0, 31, 0, tas2781_amp_getvol,
+		tas2781_amp_putvol, tas2770_dvc_tlv),
+};
+
 static const struct snd_kcontrol_new tas2781_snd_controls[] = {
 	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEVEL,
 		1, 0, 20, 0, tas2781_amp_getvol,
@@ -253,7 +272,7 @@ static const struct snd_kcontrol_new tas2781_snd_controls[] = {
 		tas2781_force_fwload_get, tas2781_force_fwload_put),
 };
 
-static const struct snd_kcontrol_new tas2781_prof_ctrl = {
+static const struct snd_kcontrol_new tasdevice_prof_ctrl = {
 	.name = "Speaker Profile Id",
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.info = tasdevice_info_profile,
@@ -261,7 +280,7 @@ static const struct snd_kcontrol_new tas2781_prof_ctrl = {
 	.put = tasdevice_set_profile_id,
 };
 
-static const struct snd_kcontrol_new tas2781_dsp_prog_ctrl = {
+static const struct snd_kcontrol_new tasdevice_dsp_prog_ctrl = {
 	.name = "Speaker Program Id",
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.info = tasdevice_info_programs,
@@ -269,7 +288,7 @@ static const struct snd_kcontrol_new tas2781_dsp_prog_ctrl = {
 	.put = tasdevice_program_put,
 };
 
-static const struct snd_kcontrol_new tas2781_dsp_conf_ctrl = {
+static const struct snd_kcontrol_new tasdevice_dsp_conf_ctrl = {
 	.name = "Speaker Config Id",
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.info = tasdevice_info_config,
@@ -378,44 +397,34 @@ static void tas2781_hda_remove_controls(struct tas2781_hda *tas_hda)
 	snd_ctl_remove(codec->card, tas_hda->prof_ctl);
 }
 
-static void tasdev_fw_ready(const struct firmware *fmw, void *context)
+static void tasdev_add_kcontrols(struct tasdevice_priv *tas_priv,
+	struct snd_kcontrol **ctls, struct hda_codec *codec,
+	const struct snd_kcontrol_new *tas_snd_ctrls, int num_ctls)
 {
-	struct tasdevice_priv *tas_priv = context;
-	struct tas2781_hda *tas_hda = dev_get_drvdata(tas_priv->dev);
-	struct tas2781_hda_i2c_priv *hda_priv = tas_hda->hda_priv;
-	struct hda_codec *codec = tas_priv->codec;
-	int i, ret, spk_id;
-
-	pm_runtime_get_sync(tas_priv->dev);
-	mutex_lock(&tas_priv->codec_lock);
+	int i, ret;
 
-	ret = tasdevice_rca_parser(tas_priv, fmw);
-	if (ret)
-		goto out;
-
-	tas_hda->prof_ctl = snd_ctl_new1(&tas2781_prof_ctrl, tas_priv);
-	ret = snd_ctl_add(codec->card, tas_hda->prof_ctl);
-	if (ret) {
-		dev_err(tas_priv->dev,
-			"Failed to add KControl %s = %d\n",
-			tas2781_prof_ctrl.name, ret);
-		goto out;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(tas2781_snd_controls); i++) {
-		hda_priv->snd_ctls[i] = snd_ctl_new1(&tas2781_snd_controls[i],
-			tas_priv);
-		ret = snd_ctl_add(codec->card, hda_priv->snd_ctls[i]);
+	for (i = 0; i < num_ctls; i++) {
+		ctls[i] = snd_ctl_new1(
+			&tas_snd_ctrls[i], tas_priv);
+		ret = snd_ctl_add(codec->card, ctls[i]);
 		if (ret) {
 			dev_err(tas_priv->dev,
 				"Failed to add KControl %s = %d\n",
-				tas2781_snd_controls[i].name, ret);
-			goto out;
+				tas_snd_ctrls[i].name, ret);
+			break;
 		}
 	}
+}
 
-	tasdevice_dsp_remove(tas_priv);
+static void tasdevice_dspfw_init(void *context)
+{
+	struct tasdevice_priv *tas_priv = context;
+	struct tas2781_hda *tas_hda = dev_get_drvdata(tas_priv->dev);
+	struct tas2781_hda_i2c_priv *hda_priv = tas_hda->hda_priv;
+	struct hda_codec *codec = tas_priv->codec;
+	int ret, spk_id;
 
+	tasdevice_dsp_remove(tas_priv);
 	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
 	if (tas_priv->speaker_id != NULL) {
 		// Speaker id need to be checked for ASUS only.
@@ -441,28 +450,12 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 		dev_err(tas_priv->dev, "dspfw load %s error\n",
 			tas_priv->coef_binaryname);
 		tas_priv->fw_state = TASDEVICE_DSP_FW_FAIL;
-		goto out;
-	}
-
-	tas_hda->dsp_prog_ctl = snd_ctl_new1(&tas2781_dsp_prog_ctrl,
-		tas_priv);
-	ret = snd_ctl_add(codec->card, tas_hda->dsp_prog_ctl);
-	if (ret) {
-		dev_err(tas_priv->dev,
-			"Failed to add KControl %s = %d\n",
-			tas2781_dsp_prog_ctrl.name, ret);
-		goto out;
-	}
-
-	tas_hda->dsp_conf_ctl = snd_ctl_new1(&tas2781_dsp_conf_ctrl,
-		tas_priv);
-	ret = snd_ctl_add(codec->card, tas_hda->dsp_conf_ctl);
-	if (ret) {
-		dev_err(tas_priv->dev,
-			"Failed to add KControl %s = %d\n",
-			tas2781_dsp_conf_ctrl.name, ret);
-		goto out;
+		return;
 	}
+	tasdev_add_kcontrols(tas_priv, &tas_hda->dsp_prog_ctl, codec,
+			     &tasdevice_dsp_prog_ctrl, 1);
+	tasdev_add_kcontrols(tas_priv, &tas_hda->dsp_conf_ctl, codec,
+			     &tasdevice_dsp_conf_ctrl, 1);
 
 	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
 	tasdevice_prmg_load(tas_priv, 0);
@@ -475,9 +468,45 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	 * calibrated data inside algo.
 	 */
 	hda_priv->save_calibration(tas_hda);
+}
+
+static void tasdev_fw_ready(const struct firmware *fmw, void *context)
+{
+	struct tasdevice_priv *tas_priv = context;
+	struct tas2781_hda *tas_hda = dev_get_drvdata(tas_priv->dev);
+	struct tas2781_hda_i2c_priv *hda_priv = tas_hda->hda_priv;
+	struct hda_codec *codec = tas_priv->codec;
+	int ret;
+
+	pm_runtime_get_sync(tas_priv->dev);
+	mutex_lock(&tas_priv->codec_lock);
+
+	ret = tasdevice_rca_parser(tas_priv, fmw);
+	if (ret)
+		goto out;
 
-	tasdevice_tuning_switch(tas_hda->priv, 0);
-	tas_hda->priv->playback_started = true;
+	tas_priv->fw_state = TASDEVICE_RCA_FW_OK;
+	tasdev_add_kcontrols(tas_priv, &tas_hda->prof_ctl, codec,
+		&tasdevice_prof_ctrl, 1);
+
+	switch (hda_priv->hda_chip_id) {
+	case HDA_TAS2770:
+		tasdev_add_kcontrols(tas_priv, hda_priv->snd_ctls, codec,
+				     &tas2770_snd_controls[0],
+				     ARRAY_SIZE(tas2770_snd_controls));
+		break;
+	case HDA_TAS2781:
+		tasdev_add_kcontrols(tas_priv, hda_priv->snd_ctls, codec,
+				     &tas2781_snd_controls[0],
+				     ARRAY_SIZE(tas2781_snd_controls));
+		tasdevice_dspfw_init(context);
+		break;
+	case HDA_TAS2563:
+		tasdevice_dspfw_init(context);
+		break;
+	default:
+		break;
+	}
 
 out:
 	mutex_unlock(&tas_hda->priv->codec_lock);
@@ -581,16 +610,33 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 		return -ENOMEM;
 
 	if (strstr(dev_name(&clt->dev), "TIAS2781")) {
-		device_name = "TIAS2781";
+		/*
+		 * TAS2781, integrated on-chip DSP with
+		 * global I2C address supported.
+		 */
+		device_name = "TIAS2781";
+		hda_priv->hda_chip_id = HDA_TAS2781;
 		hda_priv->save_calibration = tas2781_save_calibration;
 		tas_hda->priv->global_addr = TAS2781_GLOBAL_ADDR;
+	} else if (strstarts(dev_name(&clt->dev), "i2c-TXNW2770")) {
+		/*
+		 * TAS2770, has no on-chip DSP, so no calibration data
+		 * required; has no global I2C address supported.
+		 */
+		device_name = "TXNW2770";
+		hda_priv->hda_chip_id = HDA_TAS2770;
 	} else if (strstarts(dev_name(&clt->dev),
 			     "i2c-TXNW2781:00-tas2781-hda.0")) {
 		device_name = "TXNW2781";
 		hda_priv->save_calibration = tas2781_save_calibration;
 		tas_hda->priv->global_addr = TAS2781_GLOBAL_ADDR;
 	} else if (strstr(dev_name(&clt->dev), "INT8866")) {
-		device_name = "INT8866";
+		/*
+		 * TAS2563, integrated on-chip DSP with
+		 * global I2C address supported.
+		 */
+		device_name = "INT8866";
+		hda_priv->hda_chip_id = HDA_TAS2563;
 		hda_priv->save_calibration = tas2563_save_calibration;
 		tas_hda->priv->global_addr = TAS2563_GLOBAL_ADDR;
 	} else {
@@ -727,6 +773,7 @@ static const struct i2c_device_id tas2781_hda_i2c_id[] = {
 static const struct acpi_device_id tas2781_acpi_hda_match[] = {
 	{"INT8866", 0 },
 	{"TIAS2781", 0 },
+	{"TXNW2770", 0 },
 	{"TXNW2781", 0 },
 	{}
 };
-- 
2.43.0


