Return-Path: <linux-kernel+bounces-833602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196FABA2638
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6AC385D12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA79273D60;
	Fri, 26 Sep 2025 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="exU1Zv5i"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95264288A2;
	Fri, 26 Sep 2025 04:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758861305; cv=none; b=MrIL7wLiy2GLGU7Lv9kHstnX23ELk26+CGSfhmZBpXQBPjHdUH9AojbI3+sVy0yjafE4PDtPZe9LHiexQUKkSUusx8Ch02e9cGUfm2/1bfFtcbvPzdT6JbcH9oyIMkl17RMunquT39+MFN3Gdl816VYW5zmZ+F2Vxl1WDkYNmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758861305; c=relaxed/simple;
	bh=gbR2TSMQbckrmpa/ceAxtHBUo755C4BIsl+4HfZBDjs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fnbwd7lLZdDDUg8mHk2U1mQ1c78TCJRhwqDIHfyiwz0p28isn6lRPHGzG3e4klYQSAC3vtAsd2+dPPYYuKnnGCMjuEBmt6Q1e7JLDM9uFinzR63swbEw5ue1pIP+tYWbCqTR+yomrNm/rJjOxFrHOQKTpcAFf/coMLdSFugt4k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=exU1Zv5i; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58Q4YLKM1603549;
	Thu, 25 Sep 2025 23:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758861261;
	bh=a9CuTCH8YiWQ/wckmvFOcN7KFtv7UGLibRXcbhugvWQ=;
	h=From:To:CC:Subject:Date;
	b=exU1Zv5ijqNpbQXYCyYdDdnsIM3mhGs6TWQqcBIFT3Tjxf0hJ9n5rbR4DdSb/u3zV
	 jUFAYrMl6dTprvZc3FN3nFVv2UB56A5wg210UEwMWgQQZts4veReSsdEQ2zrfl1Vxh
	 AQaRhLZEBioDG2nVpBh47D0vpRtfXs7MShrdifFo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58Q4YLAn4070702
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 25 Sep 2025 23:34:21 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 25
 Sep 2025 23:34:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 25 Sep 2025 23:34:20 -0500
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58Q4Y72M685509;
	Thu, 25 Sep 2025 23:34:11 -0500
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
Subject: [PATCH v2 1/2] ASoC: tas2781: Add tas5828 support
Date: Fri, 26 Sep 2025 12:33:38 +0800
Message-ID: <20250926043339.8419-1-baojun.xu@ti.com>
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

TAS5828 have on-chip DSP without current/voltage feedback.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

---
v2:
 - Update description for TAS5828
 - Change commit tree to .../tiwai/sound.git.
---
 include/sound/tas2781.h        | 1 +
 sound/soc/codecs/tas2781-i2c.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index ddd997ac3..a37b4d67c 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -122,6 +122,7 @@ enum audio_device {
 	TAS2781,
 	TAS5825,
 	TAS5827,
+	TAS5828,
 	TAS_OTHERS,
 };
 
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 1539b7088..f62a71dca 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -110,6 +110,7 @@ static const struct i2c_device_id tasdevice_id[] = {
 	{ "tas2781", TAS2781 },
 	{ "tas5825", TAS5825 },
 	{ "tas5827", TAS5827 },
+	{ "tas5828", TAS5828 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, tasdevice_id);
@@ -126,6 +127,7 @@ static const struct of_device_id tasdevice_of_match[] = {
 	{ .compatible = "ti,tas2781" },
 	{ .compatible = "ti,tas5825" },
 	{ .compatible = "ti,tas5827" },
+	{ .compatible = "ti,tas5828" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tasdevice_of_match);
@@ -1665,7 +1667,7 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 	}
 	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
 
-	/* There is no calibration required for TAS5825/TAS5827. */
+	/* There is no calibration required for TAS5825/TAS5827/TAS5828. */
 	if (tas_priv->chip_id < TAS5825) {
 		ret = tasdevice_create_cali_ctrls(tas_priv);
 		if (ret) {
@@ -1722,6 +1724,7 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 		case TAS2781:
 		case TAS5825:
 		case TAS5827:
+		case TAS5828:
 			/* If DSP FW fail, DSP kcontrol won't be created. */
 			tasdevice_dsp_remove(tas_priv);
 		}
@@ -1884,6 +1887,7 @@ static int tasdevice_codec_probe(struct snd_soc_component *codec)
 		break;
 	case TAS5825:
 	case TAS5827:
+	case TAS5828:
 		p = (struct snd_kcontrol_new *)tas5825_snd_controls;
 		size = ARRAY_SIZE(tas5825_snd_controls);
 		break;
@@ -2056,6 +2060,7 @@ static const struct acpi_device_id tasdevice_acpi_match[] = {
 	{ "TXNW2781", TAS2781 },
 	{ "TXNW5825", TAS5825 },
 	{ "TXNW5827", TAS5827 },
+	{ "TXNW5828", TAS5828 },
 	{},
 };
 
-- 
2.25.1


