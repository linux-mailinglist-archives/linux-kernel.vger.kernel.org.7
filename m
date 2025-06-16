Return-Path: <linux-kernel+bounces-687612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9ABADA700
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 05:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9337A41CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 03:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AC11A23A9;
	Mon, 16 Jun 2025 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LujWeaKO"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB1972626;
	Mon, 16 Jun 2025 03:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750046231; cv=none; b=ES2w7r+Wpfxh5hZb08SYVnBQAICJvre3R9HDdtLV4aBeibSxVqicbH8hXGZas5bup4NMslhcDy9o+STPw5oWxyLY026XFKFke+ZRvntXjVBK/Q0haNMQyhWEwLqow84mAkmqbYl20WC3ifgU1aurJliP3jDrcfxcwAHBk62Nm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750046231; c=relaxed/simple;
	bh=av85PXSp0j0yVNqsy20d9eC8UAShLP5AvEix2MTrAPA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CLJPsj7js/BYbBTKyj7qvSR8w8IZg+Ti8IRQVxibr/MD3EHfwKyJyKoA1Phw+xAx+BnW3Y3+j1rfVFq6LSjqu5Zj86O49qNcesz6+pLQ9FhoKwajnu6cyCWxX55UVZIzvXPrtO69D8UwzczM8odRSQqvsdrhxD8v52uYn5INxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LujWeaKO; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55G3ucrv2475103;
	Sun, 15 Jun 2025 22:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750046198;
	bh=BT6uTsm+SshfGprNywgOdyoXgx2zW871i2OdC9PQSvE=;
	h=From:To:CC:Subject:Date;
	b=LujWeaKO0JSQ8ISUKSKwtQxHYJ+K//qUKDnep0Xh6DTdwkh4uGOr5URoXu+oY4mzX
	 qv5cvOmnDl8KBtmH6u4X41KzlvMOJxGE8QWrbNKZGTWMptOX3MGaVRHzvO6FDEf4Bd
	 g53+B14Fx6NDErW1nC/GSytCAne+zIh7VesyB+W4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55G3ubDu459774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 15 Jun 2025 22:56:37 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 15
 Jun 2025 22:56:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sun, 15 Jun 2025 22:56:37 -0500
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55G3uWFn3386670;
	Sun, 15 Jun 2025 22:56:33 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <shenghao-ding@ti.com>, <navada@ti.com>,
        <13916275206@139.com>, <v-hampiholi@ti.com>, <v-po@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <baojun.xu@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Add compatible for hardware id TIAS2781 and TXNW2781
Date: Mon, 16 Jun 2025 11:56:07 +0800
Message-ID: <20250616035607.2569-1-baojun.xu@ti.com>
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

TIAS2781 is unofficial hardware id in ACPI for tas2781 in HDA,
has been used for several projects. TXNW is the official hardware
id for TI, will be used in new projects, including device on SPI bus,
which was enumerated by drivers/acpi/scan.c, and probed by smi_probe()
in drivers/platform/x86/serial-multi-instantiate.c.
This patch will support both TIAS2781 and TXNW2781 in ACPI with
tas2781 under HDA.
As our I2C driver will handle all of slaver devices, so we probe
first device only: "TXNW2781:00-tas2781-hda.0"

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/pci/hda/patch_realtek.c   | 21 +++++++++++++++++----
 sound/pci/hda/tas2781_hda_i2c.c |  6 ++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bca725bb8..c5ef5e35e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7323,7 +7323,7 @@ static void alc285_fixup_asus_ga403u(struct hda_codec *cdc, const struct hda_fix
 		alc_fixup_inv_dmic(cdc, fix, action);
 }
 
-static void tas2781_fixup_i2c(struct hda_codec *cdc,
+static void tas2781_fixup_tias_i2c(struct hda_codec *cdc,
 	const struct hda_fixup *fix, int action)
 {
 	comp_generic_fixup(cdc, action, "i2c", "TIAS2781", "-%s:00", 1);
@@ -7334,6 +7334,12 @@ static void tas2781_fixup_spi(struct hda_codec *cdc, const struct hda_fixup *fix
 	comp_generic_fixup(cdc, action, "spi", "TXNW2781", "-%s:00-tas2781-hda.%d", 2);
 }
 
+static void tas2781_fixup_txnw_i2c(struct hda_codec *cdc,
+	const struct hda_fixup *fix, int action)
+{
+	comp_generic_fixup(cdc, action, "i2c", "TXNW2781", "-%s:00-tas2781-hda.%d", 1);
+}
+
 static void yoga7_14arb7_fixup_i2c(struct hda_codec *cdc,
 	const struct hda_fixup *fix, int action)
 {
@@ -8001,6 +8007,7 @@ enum {
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
 	ALC287_FIXUP_TAS2781_I2C,
 	ALC245_FIXUP_TAS2781_SPI_2,
+	ALC287_FIXUP_TXNW2781_I2C,
 	ALC287_FIXUP_YOGA7_14ARB7_I2C,
 	ALC245_FIXUP_HP_MUTE_LED_COEFBIT,
 	ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT,
@@ -10251,7 +10258,7 @@ static const struct hda_fixup alc269_fixups[] = {
 	},
 	[ALC287_FIXUP_TAS2781_I2C] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = tas2781_fixup_i2c,
+		.v.func = tas2781_fixup_tias_i2c,
 		.chained = true,
 		.chain_id = ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	},
@@ -10261,6 +10268,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_HP_GPIO_LED,
 	},
+	[ALC287_FIXUP_TXNW2781_I2C] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = tas2781_fixup_txnw_i2c,
+		.chained = true,
+		.chain_id = ALC285_FIXUP_THINKPAD_HEADSET_JACK,
+	},
 	[ALC287_FIXUP_YOGA7_14ARB7_I2C] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = yoga7_14arb7_fixup_i2c,
@@ -11322,8 +11335,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x390d, "Lenovo Yoga Pro 7 14ASP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
-	SND_PCI_QUIRK(0x17aa, 0x391f, "Yoga S990-16 pro Quad YC Quad", ALC287_FIXUP_TAS2781_I2C),
-	SND_PCI_QUIRK(0x17aa, 0x3920, "Yoga S990-16 pro Quad VECO Quad", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x391f, "Yoga S990-16 pro Quad YC Quad", ALC287_FIXUP_TXNW2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x3920, "Yoga S990-16 pro Quad VECO Quad", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index eb2295b49..b9cdbca95 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -587,6 +587,11 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 		device_name = "TIAS2781";
 		hda_priv->save_calibration = tas2781_save_calibration;
 		tas_hda->priv->global_addr = TAS2781_GLOBAL_ADDR;
+	} else if (strstarts(dev_name(&clt->dev),
+			     "TXNW2781:00-tas2781-hda.0")) {
+		device_name = "TXNW2781";
+		hda_priv->save_calibration = tas2781_save_calibration;
+		tas_hda->priv->global_addr = TAS2781_GLOBAL_ADDR;
 	} else if (strstr(dev_name(&clt->dev), "INT8866")) {
 		device_name = "INT8866";
 		hda_priv->save_calibration = tas2563_save_calibration;
@@ -725,6 +730,7 @@ static const struct i2c_device_id tas2781_hda_i2c_id[] = {
 static const struct acpi_device_id tas2781_acpi_hda_match[] = {
 	{"INT8866", 0 },
 	{"TIAS2781", 0 },
+	{"TXNW2781", 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, tas2781_acpi_hda_match);
-- 
2.43.0


