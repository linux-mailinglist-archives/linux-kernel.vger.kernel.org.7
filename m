Return-Path: <linux-kernel+bounces-847697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3385BCB6DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAFA3A9C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB95A239E63;
	Fri, 10 Oct 2025 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J17EiIyn"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4D612FF6F;
	Fri, 10 Oct 2025 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063449; cv=none; b=EFgL2vMVPZawLytikEwdQVUP3VcfP8wd8jQJ2n+qGyvWYZCLeM6bYuaUc/fnjQ35fNslQRJG2rVi7pXinPeNIQW/KGXxHT2VrknsHqrvRt/6OgDdlu0/6mWLvynj4z5drFTy15tIdr8oSF4lVHINed+RFud0cdkKwoOOzv43Dfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063449; c=relaxed/simple;
	bh=6UVlYCsHbqYnw9sE1A8Eu+fbbJ7XGJ+gRkR3KAKfTKQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U8izKGglBCCEj0hmixyZDE45mxT7Xj8z7rjRrNOo6zG52OdJIxcbMCh1jpn/101B1IAVRjCfWkzwQPUrifTaCc3pJx5r8NtZJDaiF4INKUSt8q5Is4dafQSJW18WIwqRFNeI0S1FYckLSUrME5Dz7B8Zpz0Hz9fuouvIsb6766I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J17EiIyn; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59A2UOBe146613;
	Thu, 9 Oct 2025 21:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760063424;
	bh=CHIoSrvI0mSQaH7ULEnBcdpRHWzR5mrtK2CR4UZNe8I=;
	h=From:To:CC:Subject:Date;
	b=J17EiIynBEoPe0ZIv5pkPxtqJWJTgMQjPHkq4Dyl+CN7VEPysWKGS/W/FqttVOUmX
	 9FahEeODOoI3kZUZEy2hrs5fPUIhN7KDvmIYMlRx8Tc9Rn7XVygEHp7Mi9vr3WrnIn
	 sNRgLx+KYI4WW6KEcMgCN2beu43SIoqjsIY73XmI=
Received: from DLEE206.ent.ti.com (dlee206.ent.ti.com [157.170.170.90])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59A2UN3Y736654
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Oct 2025 21:30:23 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Oct
 2025 21:30:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Oct 2025 21:30:23 -0500
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59A2UFnT1184350;
	Thu, 9 Oct 2025 21:30:16 -0500
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
Subject: [PATCH v6 1/2] ASoC: tas2781: Support more newly-released amplifiers tas5802, tas5815, and tas5828 in the driver
Date: Fri, 10 Oct 2025 10:29:50 +0800
Message-ID: <20251010022951.51581-1-baojun.xu@ti.com>
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
v6:
 - Updated the patch title
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


