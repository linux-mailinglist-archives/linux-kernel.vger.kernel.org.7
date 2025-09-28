Return-Path: <linux-kernel+bounces-835345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD24DBA6CE1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4093BCE7C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782F52D5926;
	Sun, 28 Sep 2025 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZxCgX/0Y"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3401B040D;
	Sun, 28 Sep 2025 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759050988; cv=none; b=PMSPsdjOoyTwJ1clWHg2xDF2vVg6H+JCxl/pNAjZD9KTnvePIzCGFw2UngsKBDRcMlKry95AbL5AH0GDi6U7nEkTJgkUKpD0vYjFfwpLlDnNJ6x+1q2hFJ3XIkyJ5JpoOpw9elRY+l04s5whksiOycvfd+VfO+0UChzcplXC7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759050988; c=relaxed/simple;
	bh=WO7Z27tSHE6owtiehN79kmQW9T13C+BHAgmOEsVzu04=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XTQ0UrWR1m3r3jeaC9MqfENIVEHbaxP2ZK49frpQEufnNXXVm5Lh505hZH7Vz00VU/+rUfasg1GvQHB1bEtBVTrdUBM+nORskdAnRF8WTzig1XDq+XGMaQxrmfnx/q7+YzPCwLIBtUCpIdzSDSFp0xtPBOjrZ2XsCWEb/Nw1NxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZxCgX/0Y; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58S9Fo5L2465593;
	Sun, 28 Sep 2025 04:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759050950;
	bh=R2ArzWR5Ub6mQ0s7zPGpsiwGYk24aZaU/fNB1tecknM=;
	h=From:To:CC:Subject:Date;
	b=ZxCgX/0YuJRCrYXeCBFnB4vcpBaFbE+qjp8x/zvE0067xAr2lxIo2OqGF0JKNxB48
	 uQ7tALujY96as+YmODriFNMfeFLBaoDES6dfp+LbkUT19sbKnz30xml6WqAAiroI19
	 2Vy4XX9K+4C04CFQ7+5QMkWfRh67D8MwRYto6PX8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58S9Fo7j526884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 28 Sep 2025 04:15:50 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 28
 Sep 2025 04:15:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 04:15:50 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.138])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58S9FbHr3697526;
	Sun, 28 Sep 2025 04:15:39 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>, <tiwai@suse.de>
CC: <andriy.shevchenko@linux.intel.com>, <13916275206@139.com>,
        <alsa-devel@alsa-project.org>, <shenghao-ding@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <k-yi@ti.com>, <henry.lo@ti.com>,
        <robinchen@ti.com>, <jesse-ji@ti.com>, <will-wang@ti.com>,
        <jim.shil@goertek.com>, <toastcheng@google.com>,
        <chinkaiting@google.com>
Subject: [PATCH v3 1/2] ASoC: tas2781: Support two newly-released amplifiers tas5815 and tas5828 in the driver
Date: Sun, 28 Sep 2025 17:15:13 +0800
Message-ID: <20250928091514.12349-1-baojun.xu@ti.com>
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

TAS5815/TAS5828 has on-chip DSP without current/voltage feedback.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

---
v3:
 - Rewrite the patch title
 - Add for TAS5815 support
v2:
 - Update description for TAS5828
 - Change commit tree to .../tiwai/sound.git
---
 include/sound/tas2781.h        |  2 ++
 sound/soc/codecs/tas2781-i2c.c | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index ddd997ac3..8675ceeaf 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -120,8 +120,10 @@ enum audio_device {
 	TAS2570,
 	TAS2572,
 	TAS2781,
+	TAS5815,
 	TAS5825,
 	TAS5827,
+	TAS5828,
 	TAS_OTHERS,
 };
 
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 1539b7088..0f5e6c85e 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -108,8 +108,10 @@ static const struct i2c_device_id tasdevice_id[] = {
 	{ "tas2570", TAS2570 },
 	{ "tas2572", TAS2572 },
 	{ "tas2781", TAS2781 },
+	{ "tas5815", TAS5815 },
 	{ "tas5825", TAS5825 },
 	{ "tas5827", TAS5827 },
+	{ "tas5828", TAS5828 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, tasdevice_id);
@@ -124,8 +126,10 @@ static const struct of_device_id tasdevice_of_match[] = {
 	{ .compatible = "ti,tas2570" },
 	{ .compatible = "ti,tas2572" },
 	{ .compatible = "ti,tas2781" },
+	{ .compatible = "ti,tas5815" },
 	{ .compatible = "ti,tas5825" },
 	{ .compatible = "ti,tas5827" },
+	{ .compatible = "ti,tas5828" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tasdevice_of_match);
@@ -1665,8 +1669,10 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 	}
 	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
 
-	/* There is no calibration required for TAS5825/TAS5827. */
-	if (tas_priv->chip_id < TAS5825) {
+	/* There is no calibration required for
+	 * TAS5815/TAS5825/TAS5827/TAS5828.
+	 */
+	if (tas_priv->chip_id < TAS5815) {
 		ret = tasdevice_create_cali_ctrls(tas_priv);
 		if (ret) {
 			dev_err(tas_priv->dev, "cali controls error\n");
@@ -1720,8 +1726,10 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 		switch (tas_priv->chip_id) {
 		case TAS2563:
 		case TAS2781:
+		case TAS5815:
 		case TAS5825:
 		case TAS5827:
+		case TAS5828:
 			/* If DSP FW fail, DSP kcontrol won't be created. */
 			tasdevice_dsp_remove(tas_priv);
 		}
@@ -1882,8 +1890,10 @@ static int tasdevice_codec_probe(struct snd_soc_component *codec)
 		p = (struct snd_kcontrol_new *)tas2781_snd_controls;
 		size = ARRAY_SIZE(tas2781_snd_controls);
 		break;
+	case TAS5815:
 	case TAS5825:
 	case TAS5827:
+	case TAS5828:
 		p = (struct snd_kcontrol_new *)tas5825_snd_controls;
 		size = ARRAY_SIZE(tas5825_snd_controls);
 		break;
@@ -2054,8 +2064,10 @@ static const struct acpi_device_id tasdevice_acpi_match[] = {
 	{ "TXNW2570", TAS2570 },
 	{ "TXNW2572", TAS2572 },
 	{ "TXNW2781", TAS2781 },
+	{ "TXNW5815", TAS5815 },
 	{ "TXNW5825", TAS5825 },
 	{ "TXNW5827", TAS5827 },
+	{ "TXNW5828", TAS5828 },
 	{},
 };
 
-- 
2.25.1


