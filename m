Return-Path: <linux-kernel+bounces-845043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F12DCBC35AC
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E511889D61
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415562BFC8F;
	Wed,  8 Oct 2025 04:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DZ1iiTnm"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4B52BEFE1;
	Wed,  8 Oct 2025 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759899376; cv=none; b=dbDXMMOAP7gw66cIeaGFyMLiIErSkjgS0glufDgMsJtmm38eM1It7VARZ7+o/QzUbHQEdDo8yM6TodYlYHoa+h4E66e8Nr+GGlzS5iAUoNKz+g1/4khRZ0CWPnWV0ME0vVkpUJ0FuJ19p0AArWOnlUbUTA9IXe/2LFkQabVmUME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759899376; c=relaxed/simple;
	bh=S7Q5Y0YGVCC3nn1T4FsWAQz6NZfyfRQweOboLaIEizM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IBBoSu4SAcj8bN9mEVydTfB+94U+c2WdTbwQkRB6Jehb12yF8n417tybfK+as+vTT5j5HwskYVTzjHrY44K53trd87uioMgb3cAh3kXl2dxaej07s5FxM+7r9Bp4c0nYemBbtWT/ECG3AnjnBsFP/MdEexqBa9nPt/JX/JJ2KIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DZ1iiTnm; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5984tZYg155481;
	Tue, 7 Oct 2025 23:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759899335;
	bh=/YFIlRBTwo4xlAlLEtr1OnSAe1qvK11ScWHshsz1AG0=;
	h=From:To:CC:Subject:Date;
	b=DZ1iiTnm6+AfQS36KroktqE1uNjGeqvysKlTe2Bh/Y0pnMQZmfTzw1tF36S5DaPls
	 PjEesEHwyPvwMQxABPWFt0QEWYDd2rc7w5cTCZlXq8GrUV8flNkc7YQ16Uw7/xmoiw
	 MBzW8yjRmOD8tZjV/EelPwPaIofVh3L4Ge1D8bpU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5984tYYA388689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 7 Oct 2025 23:55:34 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 7
 Oct 2025 23:55:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Oct 2025 23:55:34 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5984tQt72223240;
	Tue, 7 Oct 2025 23:55:27 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>, <tiwai@suse.de>
CC: <andriy.shevchenko@linux.intel.com>, <13916275206@139.com>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lgirdwood@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>, <k-yi@ti.com>,
        <henry.lo@ti.com>, <robinchen@ti.com>, <jesse-ji@ti.com>,
        <will-wang@ti.com>, <jim.shil@goertek.com>, <toastcheng@google.com>,
        <chinkaiting@google.com>
Subject: [PATCH v5 1/2] ASoC: tas2781: Support more newly-released amplifiers tas58xx in the driver
Date: Wed, 8 Oct 2025 12:54:58 +0800
Message-ID: <20251008045500.44477-1-baojun.xu@ti.com>
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

TAS5802/TAS5815/TAS5828 has on-chip DSP without current/voltage feedback.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

---
v5:
 - No update for this patch
v4:
 - Change the patch title
 - Add for TAS5802 support
v3:
 - Rewrite the patch title
 - Add for TAS5815 support
v2:
 - Update description for TAS5828
 - Change commit tree to .../tiwai/sound.git
---
 include/sound/tas2781.h        |  3 +++
 sound/soc/codecs/tas2781-i2c.c | 21 +++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index ddd997ac3216..0fbcdb15c74b 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -120,8 +120,11 @@ enum audio_device {
 	TAS2570,
 	TAS2572,
 	TAS2781,
+	TAS5802,
+	TAS5815,
 	TAS5825,
 	TAS5827,
+	TAS5828,
 	TAS_OTHERS,
 };
 
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 1539b70881d1..ba880b5de7e8 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -108,8 +108,11 @@ static const struct i2c_device_id tasdevice_id[] = {
 	{ "tas2570", TAS2570 },
 	{ "tas2572", TAS2572 },
 	{ "tas2781", TAS2781 },
+	{ "tas5802", TAS5802 },
+	{ "tas5815", TAS5815 },
 	{ "tas5825", TAS5825 },
 	{ "tas5827", TAS5827 },
+	{ "tas5828", TAS5828 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, tasdevice_id);
@@ -124,8 +127,11 @@ static const struct of_device_id tasdevice_of_match[] = {
 	{ .compatible = "ti,tas2570" },
 	{ .compatible = "ti,tas2572" },
 	{ .compatible = "ti,tas2781" },
+	{ .compatible = "ti,tas5802" },
+	{ .compatible = "ti,tas5815" },
 	{ .compatible = "ti,tas5825" },
 	{ .compatible = "ti,tas5827" },
+	{ .compatible = "ti,tas5828" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tasdevice_of_match);
@@ -1665,8 +1671,10 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 	}
 	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
 
-	/* There is no calibration required for TAS5825/TAS5827. */
-	if (tas_priv->chip_id < TAS5825) {
+	/* There is no calibration required for
+	 * TAS5802/TAS5815/TAS5825/TAS5827/TAS5828.
+	 */
+	if (tas_priv->chip_id < TAS5802) {
 		ret = tasdevice_create_cali_ctrls(tas_priv);
 		if (ret) {
 			dev_err(tas_priv->dev, "cali controls error\n");
@@ -1720,8 +1728,11 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 		switch (tas_priv->chip_id) {
 		case TAS2563:
 		case TAS2781:
+		case TAS5802:
+		case TAS5815:
 		case TAS5825:
 		case TAS5827:
+		case TAS5828:
 			/* If DSP FW fail, DSP kcontrol won't be created. */
 			tasdevice_dsp_remove(tas_priv);
 		}
@@ -1882,8 +1893,11 @@ static int tasdevice_codec_probe(struct snd_soc_component *codec)
 		p = (struct snd_kcontrol_new *)tas2781_snd_controls;
 		size = ARRAY_SIZE(tas2781_snd_controls);
 		break;
+	case TAS5802:
+	case TAS5815:
 	case TAS5825:
 	case TAS5827:
+	case TAS5828:
 		p = (struct snd_kcontrol_new *)tas5825_snd_controls;
 		size = ARRAY_SIZE(tas5825_snd_controls);
 		break;
@@ -2054,8 +2068,11 @@ static const struct acpi_device_id tasdevice_acpi_match[] = {
 	{ "TXNW2570", TAS2570 },
 	{ "TXNW2572", TAS2572 },
 	{ "TXNW2781", TAS2781 },
+	{ "TXNW5802", TAS5802 },
+	{ "TXNW5815", TAS5815 },
 	{ "TXNW5825", TAS5825 },
 	{ "TXNW5827", TAS5827 },
+	{ "TXNW5828", TAS5828 },
 	{},
 };
 
-- 
2.25.1


