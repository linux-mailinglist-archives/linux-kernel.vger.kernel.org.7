Return-Path: <linux-kernel+bounces-728561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70283B02A00
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 10:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC037B57FD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 08:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B8026B768;
	Sat, 12 Jul 2025 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dUe/skNM"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79AC4A11;
	Sat, 12 Jul 2025 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752308313; cv=none; b=VTkcuFxUmG+onQR1i5wa7Edz25pTX5y1ZTHSuPPYKK7Ge2de3W+ZjOTtIjJ8BAvpT7spm1VsA1LmSPX9M9EEJjg85zSDQ81xGo1wtzVBnUo+ALcrSUfNpnw5000DEOty64iSlxvq5q3cDikd0mS9udsRFJtwoAD9btpU4XYNHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752308313; c=relaxed/simple;
	bh=5QmlZdq9lk3oD+l/SlfTydozUqEL/49FswAFukZBz1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FpX5Q3cL4aeoazbl9jyZbZWee9xVBtUpsUTD/+LZ0/F/YBoWv+kaHVAEHM1NzBQHDUWJnGHSqwEUj4Q79+MaHaPLNIgcGt/AjpQRjvfSdswPpMvVv8BT2f0ORVj37cJimUVKxaPiCKFPwXsWnSAohnkqdnl0xyAPxzqQKtPYNAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dUe/skNM; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56C8I37x2213549;
	Sat, 12 Jul 2025 03:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752308283;
	bh=nhjS0HucAZWDT2G9PZFl8rKVFR+c+E/KvSR61Qe4jNg=;
	h=From:To:CC:Subject:Date;
	b=dUe/skNMVztVVwCshv/M2DFqAXUTwUNcElrWVN6HQTmuNUvWl93QlxvrWlsxp/eD5
	 mkRQdjA+eWpf26sufU1U27YTBwT6+wZWDQHaHiZhtYE0a5XXxccGX3d730OLfVmLXl
	 yk8546WzXLhbtptKX6ZyAa/GY6WSjKh0e4dBK2Vc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56C8I2wl2036460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 12 Jul 2025 03:18:02 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 12
 Jul 2025 03:18:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 12 Jul 2025 03:18:02 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.138])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56C8Hvt1557207;
	Sat, 12 Jul 2025 03:17:58 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <shenghao-ding@ti.com>, <navada@ti.com>,
        <13916275206@139.com>, <v-hampiholi@ti.com>, <v-po@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <baojun.xu@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Add TAS2770 support
Date: Sat, 12 Jul 2025 16:17:33 +0800
Message-ID: <20250712081733.12881-1-baojun.xu@ti.com>
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

Add TAS2770 support in HDA.
Create a header file include/sound/tas2770-tlv.h,
Set chip_id in i2c probe, check it while sound control is created,
and the DSP firmware binary file parser.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 include/sound/tas2770-tlv.h     | 20 ++++++++++++
 include/sound/tas2781.h         |  4 +++
 sound/pci/hda/tas2781_hda_i2c.c | 58 +++++++++++++++++++++++++--------
 3 files changed, 69 insertions(+), 13 deletions(-)
 create mode 100644 include/sound/tas2770-tlv.h

diff --git a/include/sound/tas2770-tlv.h b/include/sound/tas2770-tlv.h
new file mode 100644
index 000000000000..2a2a74372366
--- /dev/null
+++ b/include/sound/tas2770-tlv.h
@@ -0,0 +1,20 @@
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
+static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2770_dvc_tlv, 1650, 50, 0);
+static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2770_amp_tlv, 1100, 50, 0);
+
+#endif
diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index 3875e92f1ec5..f3d9c80fad36 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -63,6 +63,9 @@
 
 /* Volume control */
 #define TAS2563_DVC_LVL			TASDEVICE_REG(0x00, 0x02, 0x0c)
+#define TAS2770_DVC_LVL			TASDEVICE_REG(0x0, 0x0, 0x17)
+#define TAS2770_AMP_LEVEL		TASDEVICE_REG(0x0, 0x0, 0x03)
+
 #define TAS2781_DVC_LVL			TASDEVICE_REG(0x0, 0x0, 0x1a)
 #define TAS2781_AMP_LEVEL		TASDEVICE_REG(0x0, 0x0, 0x03)
 #define TAS2781_AMP_LEVEL_MASK		GENMASK(5, 1)
@@ -111,6 +114,7 @@
 
 enum audio_device {
 	TAS2563,
+	TAS2770,
 	TAS2781,
 };
 
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index b7ee22840d78..39f00e33e49d 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -24,6 +24,7 @@
 #include <sound/tas2781.h>
 #include <sound/tas2781-comlib-i2c.h>
 #include <sound/tlv.h>
+#include <sound/tas2770-tlv.h>
 #include <sound/tas2781-tlv.h>
 
 #include "hda_local.h"
@@ -245,6 +246,12 @@ static int tas2781_force_fwload_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
+static const struct snd_kcontrol_new tas2770_snd_controls[] = {
+	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Volume", TAS2770_AMP_LEVEL,
+		0, 0, 20, 0, tas2781_amp_getvol,
+		tas2781_amp_putvol, tas2770_amp_tlv),
+};
+
 static const struct snd_kcontrol_new tas2781_snd_controls[] = {
 	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEVEL,
 		1, 0, 20, 0, tas2781_amp_getvol,
@@ -253,7 +260,7 @@ static const struct snd_kcontrol_new tas2781_snd_controls[] = {
 		tas2781_force_fwload_get, tas2781_force_fwload_put),
 };
 
-static const struct snd_kcontrol_new tas2781_prof_ctrl = {
+static const struct snd_kcontrol_new tas27xx_prof_ctrl = {
 	.name = "Speaker Profile Id",
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.info = tasdevice_info_profile,
@@ -393,26 +400,45 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	if (ret)
 		goto out;
 
-	tas_hda->prof_ctl = snd_ctl_new1(&tas2781_prof_ctrl, tas_priv);
+	tas_hda->prof_ctl = snd_ctl_new1(&tas27xx_prof_ctrl, tas_priv);
 	ret = snd_ctl_add(codec->card, tas_hda->prof_ctl);
 	if (ret) {
 		dev_err(tas_priv->dev,
 			"Failed to add KControl %s = %d\n",
-			tas2781_prof_ctrl.name, ret);
+			tas27xx_prof_ctrl.name, ret);
 		goto out;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(tas2781_snd_controls); i++) {
-		hda_priv->snd_ctls[i] = snd_ctl_new1(&tas2781_snd_controls[i],
-			tas_priv);
-		ret = snd_ctl_add(codec->card, hda_priv->snd_ctls[i]);
-		if (ret) {
-			dev_err(tas_priv->dev,
-				"Failed to add KControl %s = %d\n",
-				tas2781_snd_controls[i].name, ret);
-			goto out;
+	if (tas_priv->chip_id == TAS2770) {
+		for (i = 0; i < ARRAY_SIZE(tas2770_snd_controls); i++) {
+			hda_priv->snd_ctls[i] = snd_ctl_new1(
+				&tas2770_snd_controls[i], tas_priv);
+			ret = snd_ctl_add(codec->card, hda_priv->snd_ctls[i]);
+			if (ret) {
+				dev_err(tas_priv->dev,
+					"Failed to add KControl %s = %d\n",
+					tas2770_snd_controls[i].name, ret);
+				goto out;
+			}
+		}
+	} else if (tas_priv->chip_id == TAS2781) {
+		for (i = 0; i < ARRAY_SIZE(tas2781_snd_controls); i++) {
+			hda_priv->snd_ctls[i] = snd_ctl_new1(
+				&tas2781_snd_controls[i], tas_priv);
+			ret = snd_ctl_add(codec->card, hda_priv->snd_ctls[i]);
+			if (ret) {
+				dev_err(tas_priv->dev,
+					"Failed to add KControl %s = %d\n",
+					tas2781_snd_controls[i].name, ret);
+				goto out;
+			}
 		}
 	}
+	// No dsp supported in TAS2770.
+	if (tas_priv->chip_id == TAS2770) {
+		tas_hda->priv->playback_started = true;
+		goto out;
+	}
 
 	tasdevice_dsp_remove(tas_priv);
 
@@ -453,7 +479,6 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 			tas2781_dsp_prog_ctrl.name, ret);
 		goto out;
 	}
-
 	tas_hda->dsp_conf_ctl = snd_ctl_new1(&tas2781_dsp_conf_ctrl,
 		tas_priv);
 	ret = snd_ctl_add(codec->card, tas_hda->dsp_conf_ctl);
@@ -582,15 +607,21 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 
 	if (strstr(dev_name(&clt->dev), "TIAS2781")) {
 		device_name = "TIAS2781";
+		tas_hda->priv->chip_id = TAS2781;
 		hda_priv->save_calibration = tas2781_save_calibration;
 		tas_hda->priv->global_addr = TAS2781_GLOBAL_ADDR;
+	} else if (strstarts(dev_name(&clt->dev), "i2c-TXNW2770")) {
+		device_name = "TXNW2770";
+		tas_hda->priv->chip_id = TAS2770;
 	} else if (strstarts(dev_name(&clt->dev),
 			     "i2c-TXNW2781:00-tas2781-hda.0")) {
 		device_name = "TXNW2781";
+		tas_hda->priv->chip_id = TAS2781;
 		hda_priv->save_calibration = tas2781_save_calibration;
 		tas_hda->priv->global_addr = TAS2781_GLOBAL_ADDR;
 	} else if (strstr(dev_name(&clt->dev), "INT8866")) {
 		device_name = "INT8866";
+		tas_hda->priv->chip_id = TAS2563;
 		hda_priv->save_calibration = tas2563_save_calibration;
 		tas_hda->priv->global_addr = TAS2563_GLOBAL_ADDR;
 	} else {
@@ -727,6 +758,7 @@ static const struct i2c_device_id tas2781_hda_i2c_id[] = {
 static const struct acpi_device_id tas2781_acpi_hda_match[] = {
 	{"INT8866", 0 },
 	{"TIAS2781", 0 },
+	{"TXNW2770", 0 },
 	{"TXNW2781", 0 },
 	{}
 };
-- 
2.43.0


