Return-Path: <linux-kernel+bounces-707572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16747AEC579
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 09:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E881C268BB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 07:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8977225A4F;
	Sat, 28 Jun 2025 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gBYYzJiJ"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38519E82A;
	Sat, 28 Jun 2025 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751094911; cv=none; b=Abexdpe+Jh12C+a6H5CzGuuLVXv6cbjfexKuJMbLpspKt8fmazB0oab82WR1I3VzD86YGl8FNuHl6jc7rukPGX8vAkrjcxxiRnREhKyXEj46iiWBE0BmEc+5Jr4WX5AMEki5VHRNttpE80yDRcslwoMFA7mq1vaJ7ayDq0OOeDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751094911; c=relaxed/simple;
	bh=XkOgWVaB47FVr9oN5SVfeT22w6zvU0n+5NecfQrH3O4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvI4G0KvSrV6xpCGl/S/Rxt704zp9Q6AB02tfVl7nivdXIuG2NbkuT+qyb9qtCUSPifGWzdzK3ASEuGlQm5qQLTsxiKCfNsvRW+qmdyS8fBugv1WRwC9Dgk0ZiSi00NINdXjK4EQ+OImSlQ/i8TWOIYf0qyOHyV6q8b37iZHsjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gBYYzJiJ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9738a8f253ef11f0b1510d84776b8c0b-20250628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AYjdtWAinWVdjdI17L0bmvLh/NxuD8B38aQcNgP/Mj0=;
	b=gBYYzJiJA/geVHdUVIlMyW69PGsRPVJgpnSljFGRzdCOlZE9K7veMTz/pKbSYqyr8aiN4wT5XaSv8jTyd6tHIgBJW+dQWeVgBfJVV/2nECnLqqbJhELzkfhNLFUjo7F36s12pKTf8DFrvhPpaGWkSlPdSFEA62C35pqwBojJjeA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:0984acd2-7456-4c3a-b0be-7d03a377739b,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:d6b14a82-cc21-4267-87cf-e75829fa6365,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9738a8f253ef11f0b1510d84776b8c0b-20250628
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <cyril.chao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2029492043; Sat, 28 Jun 2025 15:14:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sat, 28 Jun 2025 15:14:53 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sat, 28 Jun 2025 15:14:52 +0800
From: Cyril <Cyril.Chao@mediatek.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<cyril.chao@mediatek.com>, Cyril Chao <Cyril.Chao@mediatek.com>
Subject: [PATCH 03/10] ASoC: mediatek: mt8189: support ADDA in platform driver
Date: Sat, 28 Jun 2025 15:14:11 +0800
Message-ID: <20250628071442.31155-4-Cyril.Chao@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250628071442.31155-1-Cyril.Chao@mediatek.com>
References: <20250628071442.31155-1-Cyril.Chao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Cyril Chao <Cyril.Chao@mediatek.com>

Add mt8189 ADDA DAI driver support.

Signed-off-by: Cyril Chao <Cyril.Chao@mediatek.com>
---
 sound/soc/mediatek/mt8189/mt8189-dai-adda.c | 1327 +++++++++++++++++++
 1 file changed, 1327 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8189/mt8189-dai-adda.c

diff --git a/sound/soc/mediatek/mt8189/mt8189-dai-adda.c b/sound/soc/mediatek/mt8189/mt8189-dai-adda.c
new file mode 100644
index 000000000..c37183331
--- /dev/null
+++ b/sound/soc/mediatek/mt8189/mt8189-dai-adda.c
@@ -0,0 +1,1327 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  MediaTek ALSA SoC Audio DAI ADDA Control
+ *
+ *  Copyright (c) 2025 MediaTek Inc.
+ *  Author: Darren Ye <darren.ye@mediatek.com>
+ */
+
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include "mt8189-afe-clk.h"
+#include "mt8189-afe-common.h"
+#include "mt8189-interconnection.h"
+
+/* mt6363 vs1 voter */
+#define RG_BUCK_VS1_VOTER_EN_LO			0x189a
+#define RG_BUCK_VS1_VOTER_EN_LO_SET		0x189b
+#define RG_BUCK_VS1_VOTER_EN_LO_CLR		0x189c
+
+#define VS1_MT6338_MSK				0x1
+#define ADDA_UL_MUX_MASK			0x3
+#define AUDIO_SDM_LEVEL_NORMAL			0x1d
+#define SDM_AUTO_RESET_THRESHOLD		0x190000
+
+enum {
+	UL_IIR_SW = 0,
+	UL_IIR_5HZ,
+	UL_IIR_10HZ,
+	UL_IIR_25HZ,
+	UL_IIR_50HZ,
+	UL_IIR_75HZ,
+};
+
+enum {
+	AUDIO_SDM_2ND = 0,
+	AUDIO_SDM_3RD,
+};
+
+enum {
+	DELAY_DATA_MISO1 = 0,
+	DELAY_DATA_MISO2,
+};
+
+enum {
+	MTK_AFE_ADDA_DL_RATE_8K = 0,
+	MTK_AFE_ADDA_DL_RATE_11K = 1,
+	MTK_AFE_ADDA_DL_RATE_12K = 2,
+	MTK_AFE_ADDA_DL_RATE_16K = 4,
+	MTK_AFE_ADDA_DL_RATE_22K = 5,
+	MTK_AFE_ADDA_DL_RATE_24K = 6,
+	MTK_AFE_ADDA_DL_RATE_32K = 8,
+	MTK_AFE_ADDA_DL_RATE_44K = 9,
+	MTK_AFE_ADDA_DL_RATE_48K = 10,
+	MTK_AFE_ADDA_DL_RATE_88K = 13,
+	MTK_AFE_ADDA_DL_RATE_96K = 14,
+	MTK_AFE_ADDA_DL_RATE_176K = 17,
+	MTK_AFE_ADDA_DL_RATE_192K = 18,
+	MTK_AFE_ADDA_DL_RATE_352K = 21,
+	MTK_AFE_ADDA_DL_RATE_384K = 22,
+};
+
+enum {
+	MTK_AFE_ADDA_UL_RATE_8K = 0,
+	MTK_AFE_ADDA_UL_RATE_16K = 1,
+	MTK_AFE_ADDA_UL_RATE_32K = 2,
+	MTK_AFE_ADDA_UL_RATE_48K = 3,
+	MTK_AFE_ADDA_UL_RATE_96K = 4,
+	MTK_AFE_ADDA_UL_RATE_192K = 5,
+	MTK_AFE_ADDA_UL_RATE_48K_HD = 6,
+};
+
+struct mtk_afe_adda_priv {
+	int dl_rate;
+	int ul_rate;
+};
+
+static unsigned int adda_dl_rate_transform(struct mtk_base_afe *afe,
+					   unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return MTK_AFE_ADDA_DL_RATE_8K;
+	case 11025:
+		return MTK_AFE_ADDA_DL_RATE_11K;
+	case 12000:
+		return MTK_AFE_ADDA_DL_RATE_12K;
+	case 16000:
+		return MTK_AFE_ADDA_DL_RATE_16K;
+	case 22050:
+		return MTK_AFE_ADDA_DL_RATE_22K;
+	case 24000:
+		return MTK_AFE_ADDA_DL_RATE_24K;
+	case 32000:
+		return MTK_AFE_ADDA_DL_RATE_32K;
+	case 44100:
+		return MTK_AFE_ADDA_DL_RATE_44K;
+	case 48000:
+		return MTK_AFE_ADDA_DL_RATE_48K;
+	case 96000:
+		return MTK_AFE_ADDA_DL_RATE_96K;
+	case 192000:
+		return MTK_AFE_ADDA_DL_RATE_192K;
+	default:
+		dev_warn(afe->dev, "%s(), rate %d invalid, use 48kHz!!!\n",
+			 __func__, rate);
+		return MTK_AFE_ADDA_DL_RATE_48K;
+	}
+}
+
+static unsigned int adda_ul_rate_transform(struct mtk_base_afe *afe,
+					   unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return MTK_AFE_ADDA_UL_RATE_8K;
+	case 16000:
+		return MTK_AFE_ADDA_UL_RATE_16K;
+	case 32000:
+		return MTK_AFE_ADDA_UL_RATE_32K;
+	case 48000:
+		return MTK_AFE_ADDA_UL_RATE_48K;
+	case 96000:
+		return MTK_AFE_ADDA_UL_RATE_96K;
+	case 192000:
+		return MTK_AFE_ADDA_UL_RATE_192K;
+	default:
+		dev_warn(afe->dev, "%s(), rate %d invalid, use 48kHz!!!\n",
+			 __func__, rate);
+		return MTK_AFE_ADDA_UL_RATE_48K;
+	}
+}
+
+/* dai component */
+static const struct snd_kcontrol_new mtk_adda_dl_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL0_CH1", AFE_CONN014_1, I_DL0_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1", AFE_CONN014_1, I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1", AFE_CONN014_1, I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1", AFE_CONN014_1, I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH1", AFE_CONN014_1, I_DL4_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH1", AFE_CONN014_1, I_DL5_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL6_CH1", AFE_CONN014_1, I_DL6_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL7_CH1", AFE_CONN014_1, I_DL7_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL8_CH1", AFE_CONN014_1, I_DL8_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL_24CH_CH1", AFE_CONN014_1, I_DL_24CH_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL24_CH1", AFE_CONN014_2, I_DL24_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH3", AFE_CONN014_0,
+				    I_ADDA_UL_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN014_0,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN014_0,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_GAIN0_OUT_CH1", AFE_CONN014_0,
+				    I_GAIN0_OUT_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_0_CAP_CH1", AFE_CONN014_4,
+				    I_PCM_0_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC_0_OUT_CH1", AFE_CONN014_6,
+				    I_SRC_0_OUT_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC_1_OUT_CH1", AFE_CONN014_6,
+				    I_SRC_1_OUT_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC_2_OUT_CH1", AFE_CONN014_6,
+				    I_SRC_2_OUT_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_adda_dl_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL0_CH2", AFE_CONN015_1, I_DL0_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL0_CH1", AFE_CONN015_1, I_DL0_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2", AFE_CONN015_1, I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2", AFE_CONN015_1, I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2", AFE_CONN015_1, I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH2", AFE_CONN015_1, I_DL4_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH2", AFE_CONN015_1, I_DL5_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL6_CH2", AFE_CONN015_1, I_DL6_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL7_CH2", AFE_CONN015_1, I_DL7_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL8_CH2", AFE_CONN015_1, I_DL8_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL_24CH_CH2", AFE_CONN015_1, I_DL_24CH_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL24_CH2", AFE_CONN015_2, I_DL24_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH3", AFE_CONN015_0,
+				    I_ADDA_UL_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN015_0,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN015_0,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_GAIN0_OUT_CH2", AFE_CONN015_0,
+				    I_GAIN0_OUT_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_0_CAP_CH1", AFE_CONN015_4,
+				    I_PCM_0_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_0_CAP_CH2", AFE_CONN015_4,
+				    I_PCM_0_CAP_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC_0_OUT_CH2", AFE_CONN015_6,
+				    I_SRC_0_OUT_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC_1_OUT_CH2", AFE_CONN015_6,
+				    I_SRC_1_OUT_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC_2_OUT_CH2", AFE_CONN015_6,
+				    I_SRC_2_OUT_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_adda_dl_ch3_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL0_CH1", AFE_CONN016_1, I_DL0_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1", AFE_CONN016_1, I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1", AFE_CONN016_1, I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1", AFE_CONN016_1, I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH1", AFE_CONN016_1, I_DL4_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH1", AFE_CONN016_1, I_DL5_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL6_CH1", AFE_CONN016_1, I_DL6_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL7_CH1", AFE_CONN016_1, I_DL7_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL8_CH1", AFE_CONN016_1, I_DL8_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL_24CH_CH1", AFE_CONN016_1, I_DL_24CH_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL_24CH_CH3", AFE_CONN016_1, I_DL_24CH_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL24_CH1", AFE_CONN016_2, I_DL24_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH3", AFE_CONN016_0,
+				    I_ADDA_UL_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN016_0,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN016_0,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_GAIN0_OUT_CH1", AFE_CONN016_0,
+				    I_GAIN0_OUT_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_0_CAP_CH1", AFE_CONN016_4,
+				    I_PCM_0_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC_0_OUT_CH1", AFE_CONN016_6,
+				    I_SRC_0_OUT_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC_1_OUT_CH1", AFE_CONN016_6,
+				    I_SRC_1_OUT_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC_2_OUT_CH1", AFE_CONN016_6,
+				    I_SRC_2_OUT_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_adda_dl_ch4_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL0_CH2", AFE_CONN017_1, I_DL0_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2", AFE_CONN017_1, I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2", AFE_CONN017_1, I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2", AFE_CONN017_1, I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH2", AFE_CONN017_1, I_DL4_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH2", AFE_CONN017_1, I_DL5_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL6_CH2", AFE_CONN017_1, I_DL6_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL7_CH2", AFE_CONN017_1, I_DL7_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL8_CH2", AFE_CONN017_1, I_DL8_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL_24CH_CH2", AFE_CONN017_1, I_DL_24CH_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL_24CH_CH4", AFE_CONN017_1, I_DL_24CH_CH4, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL24_CH2", AFE_CONN017_2, I_DL24_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH3", AFE_CONN017_0,
+				    I_ADDA_UL_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN017_0,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN017_0,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_GAIN0_OUT_CH2", AFE_CONN017_0,
+				    I_GAIN0_OUT_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_0_CAP_CH1", AFE_CONN017_4,
+				    I_PCM_0_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_0_CAP_CH2", AFE_CONN017_4,
+				    I_PCM_0_CAP_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC_0_OUT_CH2", AFE_CONN017_6,
+				    I_SRC_0_OUT_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC_1_OUT_CH2", AFE_CONN017_6,
+				    I_SRC_1_OUT_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC_2_OUT_CH2", AFE_CONN017_6,
+				    I_SRC_2_OUT_CH2, 1, 0),
+};
+
+static const char * const adda_mux_map[] = {
+	"Normal", "Dummy_Widget",
+};
+
+static int adda_mux_map_value[] = {
+	0, 1,
+};
+
+static SOC_VALUE_ENUM_SINGLE_AUTODISABLE_DECL(adda_mux_map_enum,
+					      SND_SOC_NOPM,
+					      0,
+					      1,
+					      adda_mux_map,
+					      adda_mux_map_value);
+
+static const struct snd_kcontrol_new adda_out_mux_control =
+	SOC_DAPM_ENUM("ADDA Out Select", adda_mux_map_enum);
+
+static const struct snd_kcontrol_new adda_in_mux_control =
+	SOC_DAPM_ENUM("ADDA In Select", adda_mux_map_enum);
+
+enum {
+	SUPPLY_SEQ_ADDA_AFE_ON,
+	SUPPLY_SEQ_ADDA_DL_ON,
+	SUPPLY_SEQ_ADDA_AUD_PAD_TOP,
+	SUPPLY_SEQ_ADDA_MTKAIF_CFG,
+	SUPPLY_SEQ_ADDA6_MTKAIF_CFG,
+	SUPPLY_SEQ_ADDA_FIFO,
+	SUPPLY_SEQ_ADDA_AP_DMIC,
+	SUPPLY_SEQ_ADDA_UL_ON,
+};
+
+static int mtk_adda_ul_src_dmic(struct mtk_base_afe *afe, int id)
+{
+	unsigned int reg, reg1;
+
+	switch (id) {
+	case MT8189_DAI_ADDA:
+		reg = AFE_ADDA_UL0_SRC_CON0;
+		reg1 = AFE_ADDA_UL0_SRC_CON1;
+		break;
+	case MT8189_DAI_AP_DMIC:
+		reg = AFE_ADDA_DMIC0_SRC_CON0;
+		reg1 = AFE_ADDA_DMIC0_SRC_CON1;
+		break;
+	case MT8189_DAI_AP_DMIC_CH34:
+		reg = AFE_ADDA_DMIC1_SRC_CON0;
+		reg1 = AFE_ADDA_DMIC1_SRC_CON1;
+		break;
+	default:
+		return -EINVAL;
+	}
+	/* choose Phase */
+	regmap_update_bits(afe->regmap, reg,
+			   UL_DMIC_PHASE_SEL_CH1_MASK_SFT,
+			   0x0 << UL_DMIC_PHASE_SEL_CH1_SFT);
+	regmap_update_bits(afe->regmap, reg,
+			   UL_DMIC_PHASE_SEL_CH2_MASK_SFT,
+			   0x4 << UL_DMIC_PHASE_SEL_CH2_SFT);
+
+	/* dmic mode, 3.25M*/
+	regmap_update_bits(afe->regmap, reg,
+			   DIGMIC_3P25M_1P625M_SEL_CTL_MASK_SFT,
+			   0x0);
+	regmap_update_bits(afe->regmap, reg,
+			   DMIC_LOW_POWER_MODE_CTL_MASK_SFT,
+			   0x0);
+
+	/* turn on dmic, ch1, ch2 */
+	regmap_update_bits(afe->regmap, reg,
+			   UL_SDM_3_LEVEL_CTL_MASK_SFT,
+			   0x1 << UL_SDM_3_LEVEL_CTL_SFT);
+	regmap_update_bits(afe->regmap, reg,
+			   UL_MODE_3P25M_CH1_CTL_MASK_SFT,
+			   0x1 << UL_MODE_3P25M_CH1_CTL_SFT);
+	regmap_update_bits(afe->regmap, reg,
+			   UL_MODE_3P25M_CH2_CTL_MASK_SFT,
+			   0x1 << UL_MODE_3P25M_CH2_CTL_SFT);
+
+	/* ul gain:  gain = 0x7fff/positive_gain = 0x0/gain_mode = 0x10 */
+	regmap_update_bits(afe->regmap, reg1,
+			   ADDA_UL_GAIN_VALUE_MASK_SFT,
+			   0x7fff << ADDA_UL_GAIN_VALUE_SFT);
+	regmap_update_bits(afe->regmap, reg1,
+			   ADDA_UL_POSTIVEGAIN_MASK_SFT,
+			   0x0 << ADDA_UL_POSTIVEGAIN_SFT);
+	/* gain_mode = 0x02: Add 0.5 gain at CIC output */
+	regmap_update_bits(afe->regmap, reg1,
+			   GAIN_MODE_MASK_SFT,
+			   0x02 << GAIN_MODE_SFT);
+	return 0;
+}
+
+static int mtk_adda_ul_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol,
+			     int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+	int mtkaif_dmic = afe_priv->mtkaif_dmic;
+
+	dev_dbg(afe->dev, "%s(), name %s, event 0x%x, mtkaif_dmic %d\n",
+		__func__, w->name, event, mtkaif_dmic);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* update setting to dmic */
+		if (mtkaif_dmic) {
+			/* mtkaif_rxif_data_mode = 1, dmic */
+			regmap_update_bits(afe->regmap, AFE_MTKAIF0_RX_CFG0,
+					   0x1, 0x1);
+
+			/* dmic mode, 3.25M*/
+			regmap_update_bits(afe->regmap, AFE_MTKAIF0_RX_CFG0,
+					   RG_MTKAIF0_RXIF_VOICE_MODE_MASK_SFT,
+					   0x0);
+			mtk_adda_ul_src_dmic(afe, MT8189_DAI_ADDA);
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* should delayed 1/fs(smallest is 8k) = 125us before afe off */
+		usleep_range(120, 130);
+
+		/* reset dmic */
+		afe_priv->mtkaif_dmic = 0;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mtk_adda_pad_top_event(struct snd_soc_dapm_widget *w,
+				  struct snd_kcontrol *kcontrol,
+				  int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+
+	if (event == SND_SOC_DAPM_PRE_PMU) {
+		if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2_CLK_P2)
+			regmap_write(afe->regmap, AFE_AUD_PAD_TOP_CFG0, 0xB8);
+		else if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2)
+			regmap_write(afe->regmap, AFE_AUD_PAD_TOP_CFG0, 0xB0);
+		else
+			regmap_write(afe->regmap, AFE_AUD_PAD_TOP_CFG0, 0xB0);
+	}
+
+	return 0;
+}
+
+static bool is_adda_mtkaif_need_phase_delay(struct mt8189_afe_private *afe_priv)
+{
+	return afe_priv->mtkaif_chosen_phase[0] >= 0 &&
+	       afe_priv->mtkaif_chosen_phase[1] >= 0;
+}
+
+static int mtk_adda_mtkaif_cfg_event(struct snd_soc_dapm_widget *w,
+				     struct snd_kcontrol *kcontrol,
+				     int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+	int delay_data;
+	int delay_cycle;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2_CLK_P2) {
+			/* set protocol 2 */
+			regmap_write(afe->regmap, AFE_MTKAIF0_CFG0,
+				     0x00010000);
+			regmap_write(afe->regmap, AFE_MTKAIF1_CFG0,
+				     0x00010000);
+
+			/* mtkaif_rxif_clkinv_adc inverse for calibration */
+			regmap_update_bits(afe->regmap, AFE_MTKAIF0_CFG0,
+					   RG_MTKAIF0_RXIF_CLKINV_MASK_SFT,
+					   0x1 << RG_MTKAIF0_RXIF_CLKINV_SFT);
+			regmap_update_bits(afe->regmap, AFE_MTKAIF1_CFG0,
+					   RG_MTKAIF1_RXIF_CLKINV_ADC_MASK_SFT,
+					   0x1 << RG_MTKAIF1_RXIF_CLKINV_ADC_SFT);
+
+			/* This event align the phase of every miso pin */
+			/* If only 1 miso is used, there is no need to do phase delay. */
+			if (strcmp(w->name, "ADDA_MTKAIF_CFG") == 0 &&
+			    !is_adda_mtkaif_need_phase_delay(afe_priv)) {
+				dev_dbg(afe->dev,
+					"%s(), check adda mtkaif_chosen_phase[0/1]:%d/%d\n",
+					__func__,
+					afe_priv->mtkaif_chosen_phase[0],
+					afe_priv->mtkaif_chosen_phase[1]);
+				break;
+			} else if (strcmp(w->name, "ADDA6_MTKAIF_CFG") == 0 &&
+				   afe_priv->mtkaif_chosen_phase[2] < 0) {
+				dev_dbg(afe->dev,
+					"%s(), check adda6 mtkaif_chosen_phase[2]:%d\n",
+					__func__,
+					afe_priv->mtkaif_chosen_phase[2]);
+				break;
+			}
+
+			/* set delay for ch12 to align phase of miso0 and miso1 */
+			if (afe_priv->mtkaif_phase_cycle[0] >=
+			    afe_priv->mtkaif_phase_cycle[1]) {
+				delay_data = DELAY_DATA_MISO1;
+				delay_cycle = afe_priv->mtkaif_phase_cycle[0] -
+					      afe_priv->mtkaif_phase_cycle[1];
+			} else {
+				delay_data = DELAY_DATA_MISO2;
+				delay_cycle = afe_priv->mtkaif_phase_cycle[1] -
+					      afe_priv->mtkaif_phase_cycle[0];
+			}
+
+			regmap_update_bits(afe->regmap,
+					   AFE_MTKAIF0_RX_CFG2,
+					   RG_MTKAIF0_RXIF_DELAY_DATA_MASK_SFT,
+					   delay_data <<
+					   RG_MTKAIF0_RXIF_DELAY_DATA_SFT);
+
+			regmap_update_bits(afe->regmap,
+					   AFE_MTKAIF0_RX_CFG2,
+					   RG_MTKAIF0_RXIF_DELAY_CYCLE_MASK_SFT,
+					   delay_cycle <<
+					   RG_MTKAIF0_RXIF_DELAY_CYCLE_SFT);
+
+			/* set delay between ch3 and ch2 */
+			if (afe_priv->mtkaif_phase_cycle[2] >=
+			    afe_priv->mtkaif_phase_cycle[1]) {
+				delay_data = DELAY_DATA_MISO1;  /* ch3 */
+				delay_cycle = afe_priv->mtkaif_phase_cycle[2] -
+					      afe_priv->mtkaif_phase_cycle[1];
+			} else {
+				delay_data = DELAY_DATA_MISO2;  /* ch2 */
+				delay_cycle = afe_priv->mtkaif_phase_cycle[1] -
+					      afe_priv->mtkaif_phase_cycle[2];
+			}
+
+			regmap_update_bits(afe->regmap,
+					   AFE_MTKAIF1_RX_CFG2,
+					   RG_MTKAIF1_RXIF_DELAY_DATA_MASK_SFT,
+					   delay_data <<
+					   RG_MTKAIF1_RXIF_DELAY_DATA_SFT);
+			regmap_update_bits(afe->regmap,
+					   AFE_MTKAIF1_RX_CFG2,
+					   RG_MTKAIF1_RXIF_DELAY_CYCLE_MASK_SFT,
+					   delay_cycle <<
+					   RG_MTKAIF1_RXIF_DELAY_CYCLE_SFT);
+		} else if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2) {
+			regmap_write(afe->regmap, AFE_MTKAIF0_CFG0,
+				     0x00010000);
+			regmap_write(afe->regmap, AFE_MTKAIF1_CFG0,
+				     0x00010000);
+		} else {
+			regmap_write(afe->regmap, AFE_MTKAIF0_CFG0, 0x0);
+			regmap_write(afe->regmap, AFE_MTKAIF1_CFG0, 0x0);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mtk_adda_dl_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol,
+			     int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+
+	dev_dbg(afe->dev, "%s(), name %s, event 0x%x\n",
+		__func__, w->name, event);
+
+	/* should delayed 1/fs(smallest is 8k) = 125us before afe off */
+	if (event == SND_SOC_DAPM_POST_PMD)
+		usleep_range(120, 130);
+
+	return 0;
+}
+
+static void mt6363_vs1_vote(struct mtk_base_afe *afe)
+{
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+	bool pre_enable = afe_priv->is_mt6363_vote;
+	bool enable = false;
+
+	if (!afe_priv->pmic_regmap)
+		return;
+
+	enable = (afe_priv->is_adda_dl_on && afe_priv->is_adda_dl_max_vol) ||
+		 (afe_priv->is_adda_ul_on);
+	if (enable == pre_enable) {
+		dev_dbg(afe->dev, "%s() enable == pre_enable = %d\n",
+			__func__, enable);
+		return;
+	}
+	afe_priv->is_mt6363_vote = enable;
+	dev_dbg(afe->dev, "%s() enable = %d\n", __func__, enable);
+	if (enable)
+		regmap_update_bits(afe_priv->pmic_regmap, RG_BUCK_VS1_VOTER_EN_LO_SET,
+				   VS1_MT6338_MSK, VS1_MT6338_MSK);
+	else
+		regmap_update_bits(afe_priv->pmic_regmap, RG_BUCK_VS1_VOTER_EN_LO_CLR,
+				   VS1_MT6338_MSK, VS1_MT6338_MSK);
+}
+
+static int mt_vs1_voter_dl_event(struct snd_soc_dapm_widget *w,
+				 struct snd_kcontrol *kcontrol,
+				 int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+
+	dev_dbg(afe->dev, "%s(), event = 0x%x\n", __func__, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		afe_priv->is_adda_dl_on = true;
+		mt6363_vs1_vote(afe);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		afe_priv->is_adda_dl_on = false;
+		mt6363_vs1_vote(afe);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mt_vs1_voter_ul_event(struct snd_soc_dapm_widget *w,
+				 struct snd_kcontrol *kcontrol,
+				 int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+
+	dev_dbg(afe->dev, "%s(), event = 0x%x\n", __func__, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		afe_priv->is_adda_ul_on = true;
+		mt6363_vs1_vote(afe);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		afe_priv->is_adda_ul_on = false;
+		mt6363_vs1_vote(afe);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/* mtkaif dmic */
+static const char *const mt8189_adda_off_on_str[] = {
+	"Off", "On"
+};
+
+static const struct soc_enum mt8189_adda_enum[] = {
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8189_adda_off_on_str),
+			    mt8189_adda_off_on_str),
+};
+
+static int mt8189_adda_ap_dmic_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+
+	ucontrol->value.integer.value[0] = afe_priv->ap_dmic;
+	return 0;
+}
+
+static int mt8189_adda_ap_dmic_set(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int ap_dmic_on;
+
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
+	ap_dmic_on = ucontrol->value.integer.value[0];
+
+	dev_dbg(afe->dev, "%s(), kcontrol name %s, ap_dmic_on %d\n",
+		__func__, kcontrol->id.name, ap_dmic_on);
+
+	afe_priv->ap_dmic = ap_dmic_on;
+	return 0;
+}
+
+static int mt8189_adda_dmic_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+
+	ucontrol->value.integer.value[0] = afe_priv->mtkaif_dmic;
+	return 0;
+}
+
+static int mt8189_adda_dmic_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int dmic_on;
+
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
+	dmic_on = ucontrol->value.integer.value[0];
+
+	dev_dbg(afe->dev, "%s(), kcontrol name %s, dmic_on %d\n",
+		__func__, kcontrol->id.name, dmic_on);
+
+	afe_priv->mtkaif_dmic = dmic_on;
+	afe_priv->mtkaif_dmic_ch34 = dmic_on;
+	return 0;
+}
+
+static int mt8189_adda6_only_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+
+	ucontrol->value.integer.value[0] = afe_priv->mtkaif_adda6_only;
+	return 0;
+}
+
+static int mt8189_adda6_only_set(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int mtkaif_adda6_only;
+
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
+	mtkaif_adda6_only = ucontrol->value.integer.value[0];
+
+	dev_dbg(afe->dev, "%s(), kcontrol name %s, mtkaif_adda6_only %d\n",
+		__func__, kcontrol->id.name, mtkaif_adda6_only);
+
+	afe_priv->mtkaif_adda6_only = mtkaif_adda6_only;
+	return 0;
+}
+
+static int mt8189_adda_dl_max_vol_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+
+	ucontrol->value.integer.value[0] = afe_priv->is_adda_dl_max_vol;
+
+	return 0;
+}
+
+static int mt8189_adda_dl_max_vol_set(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+	bool is_adda_dl_max_vol = ucontrol->value.integer.value[0];
+
+	afe_priv->is_adda_dl_max_vol = is_adda_dl_max_vol;
+	mt6363_vs1_vote(afe);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new mtk_adda_controls[] = {
+	SOC_SINGLE("ADDA_DL_GAIN", AFE_ADDA_DL_SRC_CON1,
+		   AFE_DL_GAIN1_CTL_PRE_SFT, AFE_DL_GAIN1_CTL_PRE_MASK, 0),
+	SOC_ENUM_EXT("MTKAIF_DMIC", mt8189_adda_enum[0],
+		     mt8189_adda_dmic_get, mt8189_adda_dmic_set),
+	SOC_ENUM_EXT("MTKAIF_ADDA6_ONLY", mt8189_adda_enum[0],
+		     mt8189_adda6_only_get, mt8189_adda6_only_set),
+	SOC_SINGLE_EXT("ADDA_DL_MAX_VOL",
+		       SND_SOC_NOPM, 0, 0x1, 0,
+		       mt8189_adda_dl_max_vol_get,
+		       mt8189_adda_dl_max_vol_set),
+	SOC_ENUM_EXT("AP DMIC Used", mt8189_adda_enum[0],
+		     mt8189_adda_ap_dmic_get, mt8189_adda_ap_dmic_set),
+};
+
+/* ADDA UL MUX */
+enum {
+	ADDA_UL_MUX_MTKAIF = 0,
+	ADDA_UL_MUX_AP_DMIC,
+	ADDA_UL_MUX_AP_DMIC_MULTICH,
+};
+
+static const char *const adda_ul_mux_map[] = {
+	"MTKAIF", "AP_DMIC", "AP_DMIC_MULTI_CH",
+};
+
+static int adda_ul_map_value[] = {
+	ADDA_UL_MUX_MTKAIF,
+	ADDA_UL_MUX_AP_DMIC,
+	ADDA_UL_MUX_AP_DMIC_MULTICH,
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(adda_ul_mux_map_enum,
+				  SND_SOC_NOPM,
+				  0,
+				  ADDA_UL_MUX_MASK,
+				  adda_ul_mux_map,
+				  adda_ul_map_value);
+
+static const struct snd_kcontrol_new adda_ul_mux_control =
+	SOC_DAPM_ENUM("ADDA_UL_MUX Select", adda_ul_mux_map_enum);
+
+static const struct snd_kcontrol_new adda_ch34_ul_mux_control =
+	SOC_DAPM_ENUM("ADDA_CH34_UL_MUX Select", adda_ul_mux_map_enum);
+
+static const struct snd_soc_dapm_widget mtk_dai_adda_widgets[] = {
+	/* inter-connections */
+	SND_SOC_DAPM_MIXER("ADDA_DL_CH1", SND_SOC_NOPM, 0, 0,
+			   mtk_adda_dl_ch1_mix,
+			   ARRAY_SIZE(mtk_adda_dl_ch1_mix)),
+	SND_SOC_DAPM_MIXER("ADDA_DL_CH2", SND_SOC_NOPM, 0, 0,
+			   mtk_adda_dl_ch2_mix,
+			   ARRAY_SIZE(mtk_adda_dl_ch2_mix)),
+
+	SND_SOC_DAPM_MIXER("ADDA_DL_CH3", SND_SOC_NOPM, 0, 0,
+			   mtk_adda_dl_ch3_mix,
+			   ARRAY_SIZE(mtk_adda_dl_ch3_mix)),
+	SND_SOC_DAPM_MIXER("ADDA_DL_CH4", SND_SOC_NOPM, 0, 0,
+			   mtk_adda_dl_ch4_mix,
+			   ARRAY_SIZE(mtk_adda_dl_ch4_mix)),
+
+	SND_SOC_DAPM_SUPPLY_S("ADDA Enable", SUPPLY_SEQ_ADDA_AFE_ON,
+			      AUDIO_ENGEN_CON0, AUDIO_F3P25M_EN_ON_SFT, 0,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADDA_DL0_CG", SUPPLY_SEQ_ADDA_DL_ON,
+			      AUDIO_TOP_CON0,
+			      PDN_DL0_DAC_SFT, 1,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADDA_UL0_CG", SUPPLY_SEQ_ADDA_UL_ON,
+			      AUDIO_TOP_CON1,
+			      PDN_UL0_ADC_SFT, 1,
+			      NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY_S("ADDA Playback Enable", SUPPLY_SEQ_ADDA_DL_ON,
+			      AFE_ADDA_DL_SRC_CON0,
+			      AFE_DL_SRC_ON_TMP_CTL_PRE_SFT, 0,
+			      mtk_adda_dl_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SUPPLY_S("ADDA Capture Enable", SUPPLY_SEQ_ADDA_UL_ON,
+			      AFE_ADDA_UL0_SRC_CON0,
+			      UL_SRC_ON_TMP_CTL_SFT, 0,
+			      mtk_adda_ul_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SUPPLY_S("AP DMIC Capture Enable", SUPPLY_SEQ_ADDA_UL_ON,
+			      AFE_ADDA_DMIC0_SRC_CON0,
+			      UL_SRC_ON_TMP_CTL_SFT, 0,
+			      NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY_S("AP DMIC CH34 Capture Enable", SUPPLY_SEQ_ADDA_UL_ON,
+			      AFE_ADDA_DMIC1_SRC_CON0,
+			      UL_SRC_ON_TMP_CTL_SFT, 0,
+			      NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY_S("AUD_PAD_TOP", SUPPLY_SEQ_ADDA_AUD_PAD_TOP,
+			      AFE_AUD_PAD_TOP_CFG0,
+			      RG_RX_FIFO_ON_SFT, 0,
+			      mtk_adda_pad_top_event,
+			      SND_SOC_DAPM_PRE_PMU),
+	SND_SOC_DAPM_SUPPLY_S("ADDA_MTKAIF_CFG", SUPPLY_SEQ_ADDA_MTKAIF_CFG,
+			      SND_SOC_NOPM, 0, 0,
+			      mtk_adda_mtkaif_cfg_event,
+			      SND_SOC_DAPM_PRE_PMU),
+	SND_SOC_DAPM_SUPPLY_S("ADDA6_MTKAIF_CFG", SUPPLY_SEQ_ADDA6_MTKAIF_CFG,
+			      SND_SOC_NOPM, 0, 0,
+			      mtk_adda_mtkaif_cfg_event,
+			      SND_SOC_DAPM_PRE_PMU),
+	SND_SOC_DAPM_SUPPLY_S("AP_DMIC_EN", SUPPLY_SEQ_ADDA_AP_DMIC,
+			      AFE_ADDA_DMIC0_SRC_CON0,
+			      UL_AP_DMIC_ON_SFT, 0,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("AP_DMIC0_CG", SUPPLY_SEQ_ADDA_AP_DMIC,
+			      AUDIO_TOP_CON1,
+			      PDN_DMIC0_ADC_SFT, 1,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("AP_DMIC_CH34_EN", SUPPLY_SEQ_ADDA_AP_DMIC,
+			      AFE_ADDA_DMIC1_SRC_CON0,
+			      UL_AP_DMIC_ON_SFT, 0,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("AP_DMIC1_CG", SUPPLY_SEQ_ADDA_AP_DMIC,
+			      AUDIO_TOP_CON1,
+			      PDN_DMIC1_ADC_SFT, 1,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADDA_FIFO", SUPPLY_SEQ_ADDA_FIFO,
+			      AFE_ADDA_UL0_SRC_CON1,
+			      FIFO_SOFT_RST_SFT, 1,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("AP_DMIC_FIFO", SUPPLY_SEQ_ADDA_FIFO,
+			      AFE_ADDA_DMIC0_SRC_CON1,
+			      FIFO_SOFT_RST_SFT, 1,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("AP_DMIC_CH34_FIFO", SUPPLY_SEQ_ADDA_FIFO,
+			      AFE_ADDA_DMIC1_SRC_CON1,
+			      FIFO_SOFT_RST_SFT, 1,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("VS1_VOTER_DL", SUPPLY_SEQ_ADDA_AFE_ON,
+			      SND_SOC_NOPM, 0, 0,
+			      mt_vs1_voter_dl_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SUPPLY_S("VS1_VOTER_UL", SUPPLY_SEQ_ADDA_AFE_ON,
+			      SND_SOC_NOPM, 0, 0,
+			      mt_vs1_voter_ul_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MUX("ADDA_UL_Mux", SND_SOC_NOPM, 0, 0,
+			 &adda_ul_mux_control),
+	SND_SOC_DAPM_MUX("ADDA_CH34_UL_Mux", SND_SOC_NOPM, 0, 0,
+			 &adda_ch34_ul_mux_control),
+
+	SND_SOC_DAPM_INPUT("AP_DMIC_INPUT"),
+	SND_SOC_DAPM_INPUT("AP_DMIC_CH34_INPUT"),
+
+	/* allow i2s on without codec on */
+	SND_SOC_DAPM_OUTPUT("ADDA_DUMMY_OUT"),
+	SND_SOC_DAPM_MUX("ADDA_Out_Mux",
+			 SND_SOC_NOPM, 0, 0, &adda_out_mux_control),
+	SND_SOC_DAPM_INPUT("ADDA_DUMMY_IN"),
+	SND_SOC_DAPM_MUX("ADDA_In_Mux",
+			 SND_SOC_NOPM, 0, 0, &adda_in_mux_control),
+};
+
+static const struct snd_soc_dapm_route mtk_dai_adda_routes[] = {
+	/* playback */
+	{"ADDA_DL_CH1", "DL0_CH1", "DL0"},
+	{"ADDA_DL_CH2", "DL0_CH1", "DL0"},
+	{"ADDA_DL_CH2", "DL0_CH2", "DL0"},
+
+	{"ADDA_DL_CH1", "DL1_CH1", "DL1"},
+	{"ADDA_DL_CH2", "DL1_CH2", "DL1"},
+
+	{"ADDA_DL_CH1", "DL2_CH1", "DL2"},
+	{"ADDA_DL_CH2", "DL2_CH2", "DL2"},
+
+	{"ADDA_DL_CH1", "DL3_CH1", "DL3"},
+	{"ADDA_DL_CH2", "DL3_CH2", "DL3"},
+
+	{"ADDA_DL_CH1", "DL4_CH1", "DL4"},
+	{"ADDA_DL_CH2", "DL4_CH2", "DL4"},
+
+	{"ADDA_DL_CH1", "DL5_CH1", "DL5"},
+	{"ADDA_DL_CH2", "DL5_CH2", "DL5"},
+
+	{"ADDA_DL_CH1", "DL6_CH1", "DL6"},
+	{"ADDA_DL_CH2", "DL6_CH2", "DL6"},
+
+	{"ADDA_DL_CH1", "DL7_CH1", "DL7"},
+	{"ADDA_DL_CH2", "DL7_CH2", "DL7"},
+
+	{"ADDA_DL_CH1", "DL8_CH1", "DL8"},
+	{"ADDA_DL_CH2", "DL8_CH2", "DL8"},
+
+	{"ADDA_DL_CH1", "DL_24CH_CH1", "DL_24CH"},
+	{"ADDA_DL_CH2", "DL_24CH_CH2", "DL_24CH"},
+
+	{"ADDA_DL_CH1", "DL24_CH1", "DL24"},
+	{"ADDA_DL_CH2", "DL24_CH2", "DL24"},
+
+	{"ADDA Playback", NULL, "ADDA_DL_CH1"},
+	{"ADDA Playback", NULL, "ADDA_DL_CH2"},
+
+	{"ADDA Playback", NULL, "ADDA Enable"},
+	{"ADDA Playback", NULL, "ADDA Playback Enable"},
+	{"ADDA Playback", NULL, "AUD_PAD_TOP"},
+	{"ADDA Playback", NULL, "VS1_VOTER_DL"},
+	{"ADDA Playback", NULL, "ADDA_DL0_CG"},
+
+	{"ADDA_DL_CH3", "DL0_CH1", "DL0"},
+	{"ADDA_DL_CH4", "DL0_CH2", "DL0"},
+
+	{"ADDA_DL_CH3", "DL1_CH1", "DL1"},
+	{"ADDA_DL_CH4", "DL1_CH2", "DL1"},
+
+	{"ADDA_DL_CH3", "DL2_CH1", "DL2"},
+	{"ADDA_DL_CH4", "DL2_CH2", "DL2"},
+
+	{"ADDA_DL_CH3", "DL3_CH1", "DL3"},
+	{"ADDA_DL_CH4", "DL3_CH2", "DL3"},
+
+	{"ADDA_DL_CH3", "DL4_CH1", "DL4"},
+	{"ADDA_DL_CH4", "DL4_CH2", "DL4"},
+
+	{"ADDA_DL_CH3", "DL5_CH1", "DL5"},
+	{"ADDA_DL_CH4", "DL5_CH2", "DL5"},
+
+	{"ADDA_DL_CH3", "DL6_CH1", "DL6"},
+	{"ADDA_DL_CH4", "DL6_CH2", "DL6"},
+
+	{"ADDA_DL_CH3", "DL7_CH1", "DL7"},
+	{"ADDA_DL_CH4", "DL7_CH2", "DL7"},
+
+	{"ADDA_DL_CH3", "DL8_CH1", "DL8"},
+	{"ADDA_DL_CH4", "DL8_CH2", "DL8"},
+
+	{"ADDA_DL_CH3", "DL_24CH_CH1", "DL_24CH"},
+	{"ADDA_DL_CH4", "DL_24CH_CH2", "DL_24CH"},
+	{"ADDA_DL_CH3", "DL_24CH_CH3", "DL_24CH"},
+	{"ADDA_DL_CH4", "DL_24CH_CH4", "DL_24CH"},
+
+	{"ADDA_DL_CH3", "DL24_CH1", "DL24"},
+	{"ADDA_DL_CH4", "DL24_CH2", "DL24"},
+
+	{"ADDA Capture", NULL, "ADDA Enable"},
+	{"ADDA Capture", NULL, "ADDA Capture Enable"},
+	{"ADDA Capture", NULL, "AUD_PAD_TOP"},
+	{"ADDA Capture", NULL, "ADDA_MTKAIF_CFG"},
+	{"ADDA Capture", NULL, "VS1_VOTER_UL"},
+	{"ADDA Capture", NULL, "ADDA_UL0_CG"},
+
+	/* capture */
+	{"ADDA_UL_Mux", "MTKAIF", "ADDA Capture"},
+	{"ADDA_UL_Mux", "AP_DMIC", "AP DMIC Capture"},
+	{"ADDA_CH34_UL_Mux", "AP_DMIC", "AP DMIC CH34 Capture"},
+
+	{"AP DMIC Capture", NULL, "ADDA Enable"},
+	{"AP DMIC Capture", NULL, "AP DMIC Capture Enable"},
+	{"AP DMIC Capture", NULL, "AP_DMIC_FIFO"},
+	{"AP DMIC Capture", NULL, "AP_DMIC_EN"},
+	{"AP DMIC Capture", NULL, "AP_DMIC0_CG"},
+
+	{"AP DMIC CH34 Capture", NULL, "ADDA Enable"},
+	{"AP DMIC CH34 Capture", NULL, "AP DMIC CH34 Capture Enable"},
+	{"AP DMIC CH34 Capture", NULL, "AP_DMIC_CH34_FIFO"},
+	{"AP DMIC CH34 Capture", NULL, "AP_DMIC_CH34_EN"},
+	{"AP DMIC CH34 Capture", NULL, "AP_DMIC1_CG"},
+
+	{"AP DMIC Capture", NULL, "AP_DMIC_INPUT"},
+	{"AP DMIC CH34 Capture", NULL, "AP_DMIC_CH34_INPUT"},
+
+	/* allow i2s on without codec on */
+	{"ADDA Capture", NULL, "ADDA_In_Mux"},
+	{"ADDA_In_Mux", "Dummy_Widget", "ADDA_DUMMY_IN"},
+	{"ADDA_Out_Mux", "Dummy_Widget", "ADDA Playback"},
+	{"ADDA_DUMMY_OUT", NULL, "ADDA_Out_Mux"},
+};
+
+/* dai ops */
+static int mtk_dai_adda_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+	unsigned int rate = params_rate(params);
+	int id = dai->id;
+	struct mtk_afe_adda_priv *adda_priv = afe_priv->dai_priv[id];
+
+	dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %d\n",
+		__func__, id, substream->stream, rate);
+
+	if (!adda_priv)
+		return -EINVAL;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		unsigned int dl_src_con0 = 0;
+		unsigned int dl_src_con1 = 0;
+
+		adda_priv->dl_rate = rate;
+
+		/* set sampling rate */
+		dl_src_con0 = adda_dl_rate_transform(afe, rate) <<
+				AFE_DL_INPUT_MODE_CTL_SFT;
+
+		/* set output mode, UP_SAMPLING_RATE_X8 */
+		dl_src_con0 |= (0x3 << AFE_DL_OUTPUT_SEL_CTL_SFT);
+
+		/* turn off mute function */
+		dl_src_con0 |= (0x01 << AFE_DL_MUTE_CH2_OFF_CTL_PRE_SFT);
+		dl_src_con0 |= (0x01 << AFE_DL_MUTE_CH1_OFF_CTL_PRE_SFT);
+
+		/* set voice input data if input sample rate is 8k or 16k */
+		if (rate == 8000 || rate == 16000)
+			dl_src_con0 |= 0x01 << AFE_DL_VOICE_MODE_CTL_PRE_SFT;
+
+		/* SA suggest apply -0.3db to audio/speech path */
+		dl_src_con1 = MTK_AFE_ADDA_DL_GAIN_NORMAL <<
+			      AFE_DL_GAIN1_CTL_PRE_SFT;
+		dl_src_con1 |= MTK_AFE_ADDA_DL_GAIN_NORMAL <<
+			       AFE_DL_GAIN2_CTL_PRE_SFT;
+
+		/* turn on down-link gain */
+		dl_src_con0 |= (0x01 << AFE_DL_GAIN_ON_CTL_PRE_SFT);
+
+		if (id == MT8189_DAI_ADDA) {
+			/* clean predistortion */
+			regmap_write(afe->regmap, AFE_ADDA_DL_PREDIS_CON0, 0);
+			regmap_write(afe->regmap, AFE_ADDA_DL_PREDIS_CON1, 0);
+
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DL_SRC_CON0, dl_src_con0);
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DL_SRC_CON1, dl_src_con1);
+
+			/* set sdm gain */
+			regmap_update_bits(afe->regmap,
+					   AFE_ADDA_DL_SDM_DCCOMP_CON,
+					   AFE_DL_ATTGAIN_CTL_MASK_SFT,
+					   AUDIO_SDM_LEVEL_NORMAL <<
+					   AFE_DL_ATTGAIN_CTL_SFT);
+
+			/* 2nd sdm */
+			regmap_update_bits(afe->regmap,
+					   AFE_ADDA_DL_SDM_DCCOMP_CON,
+					   AFE_DL_USE_3RD_SDM_MASK_SFT,
+					   AUDIO_SDM_2ND << AFE_DL_USE_3RD_SDM_SFT);
+
+			/* sdm auto reset */
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DL_SDM_AUTO_RESET_CON,
+				     SDM_AUTO_RESET_THRESHOLD);
+			regmap_update_bits(afe->regmap,
+					   AFE_ADDA_DL_SDM_AUTO_RESET_CON,
+					   AFE_DL_SDM_AUTO_RESET_TEST_ON_SFT,
+					   0x1 << AFE_DL_SDM_AUTO_RESET_TEST_ON_SFT);
+		}
+	} else {
+		unsigned int voice_mode = 0;
+		unsigned int ul_src_con0 = 0;   /* default value */
+
+		adda_priv->ul_rate = rate;
+
+		voice_mode = adda_ul_rate_transform(afe, rate);
+
+		ul_src_con0 |= (voice_mode << 17) & (0x7 << 17);
+
+		/* enable iir */
+		ul_src_con0 |= (1 << UL_IIR_ON_TMP_CTL_SFT) &
+			       UL_IIR_ON_TMP_CTL_MASK_SFT;
+		ul_src_con0 |= (UL_IIR_SW << UL_IIRMODE_CTL_SFT) &
+			       UL_IIRMODE_CTL_MASK_SFT;
+
+		switch (id) {
+		case MT8189_DAI_ADDA:
+			/* 35Hz @ 48k */
+			regmap_write(afe->regmap,
+				     AFE_ADDA_UL0_IIR_COEF_02_01, 0x00000000);
+			regmap_write(afe->regmap,
+				     AFE_ADDA_UL0_IIR_COEF_04_03, 0x00003FB8);
+			regmap_write(afe->regmap,
+				     AFE_ADDA_UL0_IIR_COEF_06_05, 0x3FB80000);
+			regmap_write(afe->regmap,
+				     AFE_ADDA_UL0_IIR_COEF_08_07, 0x3FB80000);
+			regmap_write(afe->regmap,
+				     AFE_ADDA_UL0_IIR_COEF_10_09, 0x0000C048);
+
+			regmap_write(afe->regmap,
+				     AFE_ADDA_UL0_SRC_CON0, ul_src_con0);
+
+			/* mtkaif_rxif_data_mode = 0, amic */
+			regmap_update_bits(afe->regmap,
+					   AFE_MTKAIF0_RX_CFG0,
+					   0x1 << 0,
+					   0x0 << 0);
+			break;
+		case MT8189_DAI_AP_DMIC:
+			/* 35Hz @ 48k */
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DMIC0_IIR_COEF_02_01, 0x00000000);
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DMIC0_IIR_COEF_04_03, 0x00003FB8);
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DMIC0_IIR_COEF_06_05, 0x3FB80000);
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DMIC0_IIR_COEF_08_07, 0x3FB80000);
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DMIC0_IIR_COEF_10_09, 0x0000C048);
+
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DMIC0_SRC_CON0, ul_src_con0);
+			break;
+		case MT8189_DAI_AP_DMIC_CH34:
+			/* 35Hz @ 48k */
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DMIC1_IIR_COEF_02_01, 0x00000000);
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DMIC1_IIR_COEF_04_03, 0x00003FB8);
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DMIC1_IIR_COEF_06_05, 0x3FB80000);
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DMIC1_IIR_COEF_08_07, 0x3FB80000);
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DMIC1_IIR_COEF_10_09, 0x0000C048);
+
+			regmap_write(afe->regmap,
+				     AFE_ADDA_DMIC1_SRC_CON0, ul_src_con0);
+			break;
+		default:
+			break;
+		}
+
+		/* ap dmic */
+		switch (id) {
+		case MT8189_DAI_AP_DMIC:
+		case MT8189_DAI_AP_DMIC_CH34:
+			mtk_adda_ul_src_dmic(afe, id);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mtk_dai_adda_ops = {
+	.hw_params = mtk_dai_adda_hw_params,
+};
+
+/* dai driver */
+#define MTK_ADDA_PLAYBACK_RATES (SNDRV_PCM_RATE_8000_48000)
+
+#define MTK_ADDA_CAPTURE_RATES (SNDRV_PCM_RATE_8000 |\
+				SNDRV_PCM_RATE_16000 |\
+				SNDRV_PCM_RATE_32000 |\
+				SNDRV_PCM_RATE_48000)
+
+#define MTK_ADDA_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			  SNDRV_PCM_FMTBIT_S24_LE |\
+			  SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_adda_driver[] = {
+	{
+		.name = "ADDA",
+		.id = MT8189_DAI_ADDA,
+		.playback = {
+			.stream_name = "ADDA Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_ADDA_PLAYBACK_RATES,
+			.formats = MTK_ADDA_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ADDA Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_ADDA_CAPTURE_RATES,
+			.formats = MTK_ADDA_FORMATS,
+		},
+		.ops = &mtk_dai_adda_ops,
+	},
+	{
+		.name = "ADDA_CH34",
+		.id = MT8189_DAI_ADDA_CH34,
+		.playback = {
+			.stream_name = "ADDA CH34 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_ADDA_PLAYBACK_RATES,
+			.formats = MTK_ADDA_FORMATS,
+		},
+		.ops = &mtk_dai_adda_ops,
+	},
+	{
+		.name = "AP_DMIC",
+		.id = MT8189_DAI_AP_DMIC,
+		.capture = {
+			.stream_name = "AP DMIC Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_ADDA_CAPTURE_RATES,
+			.formats = MTK_ADDA_FORMATS,
+		},
+		.ops = &mtk_dai_adda_ops,
+	},
+	{
+		.name = "AP_DMIC_CH34",
+		.id = MT8189_DAI_AP_DMIC_CH34,
+		.capture = {
+			.stream_name = "AP DMIC CH34 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_ADDA_CAPTURE_RATES,
+			.formats = MTK_ADDA_FORMATS,
+		},
+		.ops = &mtk_dai_adda_ops,
+	},
+};
+
+static int init_adda_priv_data(struct mtk_base_afe *afe)
+{
+	struct mt8189_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_afe_adda_priv *adda_priv;
+	static const int adda_dai_list[] = {
+		MT8189_DAI_ADDA,
+		MT8189_DAI_ADDA_CH34,
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(adda_dai_list); i++) {
+		adda_priv = devm_kzalloc(afe->dev,
+					 sizeof(struct mtk_afe_adda_priv),
+					 GFP_KERNEL);
+		if (!adda_priv)
+			return -ENOMEM;
+
+		afe_priv->dai_priv[adda_dai_list[i]] = adda_priv;
+	}
+
+	/* ap dmic priv share with adda */
+	afe_priv->dai_priv[MT8189_DAI_AP_DMIC] =
+		afe_priv->dai_priv[MT8189_DAI_ADDA];
+	afe_priv->dai_priv[MT8189_DAI_AP_DMIC_CH34] =
+		afe_priv->dai_priv[MT8189_DAI_ADDA_CH34];
+
+	return 0;
+}
+
+int mt8189_dai_adda_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_adda_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_adda_driver);
+
+	dai->controls = mtk_adda_controls;
+	dai->num_controls = ARRAY_SIZE(mtk_adda_controls);
+	dai->dapm_widgets = mtk_dai_adda_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_adda_widgets);
+	dai->dapm_routes = mtk_dai_adda_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_adda_routes);
+
+	return init_adda_priv_data(afe);
+}
-- 
2.46.0


