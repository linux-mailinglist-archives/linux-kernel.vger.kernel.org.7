Return-Path: <linux-kernel+bounces-831734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21985B9D6F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D224A16EDC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED10C2E7F06;
	Thu, 25 Sep 2025 05:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y6+lRP1t"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27E02BB13;
	Thu, 25 Sep 2025 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758777251; cv=none; b=aVmSSpjoCwAVQ+e2VXcIa0ej/hEyMzidQ6A/pNqoP3M9E9yzQYWpRhZvzuSfOSFNpLNYcDPcArSgRuCqjrftvfa8ajx9WvwoYmPkaRAI/uo2FPZpq1O1ZZZ4U5bbMQZHkPXVIDaX+Gd3+qek9+JpdjmGYAo4balDj/Yphi2JPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758777251; c=relaxed/simple;
	bh=MI1wPF47cj51v5gvx1moxrS8OunCrtPVd0XamHKKp6g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pq4FJf12fk8tH5W/DwrtN1W5S8amwZ+FEuRQNrv1rNLZcsDqZoy2Q30ysfkUlDKi5gxuPWX+YgubR/D4MSHGoRT0IAdIH1rWDZ3F31zNYR2Y2WpcS9ftxSt8t76vQD9GL+Vxy4oscNzYqeR7X0HwQS8TLjwzPl2mK7l4dho3mMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y6+lRP1t; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58P5DiCX1383667;
	Thu, 25 Sep 2025 00:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758777224;
	bh=EluPOJeo58opOTN0eM8mPRt7xvguHqP3916XoJ6Zljw=;
	h=From:To:CC:Subject:Date;
	b=y6+lRP1tCNmDgymVYyJyyPg1W1iO0sv0nSKAMNGn6K/MTXJ/JP6puDrx0LR0L6mDt
	 5vn2GTHIGkTaTtJJJ5Zqytgn9+ROiR98jIaUapjPn8a/55B+C3ggvLM5Ei8zVveBs2
	 WhwxMYuTZiVtQsE1+ufm5rGEhQ4yfdcJddR8h5QY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58P5DiVb3304012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 25 Sep 2025 00:13:44 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 25
 Sep 2025 00:13:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 25 Sep 2025 00:13:43 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.138])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58P5DVio2924111;
	Thu, 25 Sep 2025 00:13:33 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lgirdwood@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>, <k-yi@ti.com>,
        <henry.lo@ti.com>, <robinchen@ti.com>, <jesse-ji@ti.com>,
        <will-wang@ti.com>, <jim.shil@goertek.com>, <toastcheng@google.com>,
        <chinkaiting@google.com>
Subject: [PATCH v1 1/2] ASoC: tas2781: Add tas5828 support
Date: Thu, 25 Sep 2025 13:13:01 +0800
Message-ID: <20250925051302.6805-1-baojun.xu@ti.com>
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

TAS5828 have on-chip DSP but have no calibration required stereo
smart amplifier.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 include/sound/tas2781.h        | 1 +
 sound/soc/codecs/tas2781-i2c.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index ddd997ac3216..a37b4d67c137 100644
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
index 1539b70881d1..f62a71dca36c 100644
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
2.43.0


