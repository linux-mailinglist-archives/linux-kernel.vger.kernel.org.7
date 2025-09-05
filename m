Return-Path: <linux-kernel+bounces-802232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B664B44F47
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED223AA1E59
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC13C2FE079;
	Fri,  5 Sep 2025 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LAUQ/1zv"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E30B2E717D;
	Fri,  5 Sep 2025 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056667; cv=none; b=WGBzhx3wUHsCe3cTcKBpukP8LdXnsQCsaABvmBjyayafuLpfQ2R4nCx60OdlwHefqz/wL2tGtRdyBiAf0fY1CAGWfSWmiSJP8bw/ssugKSrGQLSNGJZXeaJojbYf4O0hcemZXzPTQlFZ13SbkWWvRjGdn7Q+UTxmeP/2hs07W2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056667; c=relaxed/simple;
	bh=JCrozJ3QK2F0FjEbxOv4K6molMTYNyWYzkz10KlpHGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVdLbDXDB0+AdeUyEJz7v/0RxgKjuVKCITazLLzXn1bZMwHf7x1A1XuT1NxIncdF/8HRcsrMdpeOZOMeKubL7UOQtQOMHLkzdGaj/lhWGbn5baPCNOQ9SsxYYf4lA+BmvERH+LrMxvBWH4kcR5q3AKu6rKU2XjTqeM7lfVg8R+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LAUQ/1zv; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 68109f708a2811f0b33aeb1e7f16c2b6-20250905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xhyzJ7Z7ESPd3yOdaFgRvcCmuMfmlajJp4IO/eIceVk=;
	b=LAUQ/1zv6S79TE3RdVPtGvF8xKIVI6IlBKS4QxRJdukPDKg6V/1wJ7W9ucGgZu/zVgJhhmX0JVenGkTQuUoHynr2lofV+qrfY7m470UJSAD38M7i2bx1FaD1OUCLZN6qnNmyndSw+t/xt2V/8fLi8q2u+rF1GhYQDBGK8rs6D2w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:ca70a4de-9262-4e49-b8f4-8e81fe768542,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:a6eff9f7-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 68109f708a2811f0b33aeb1e7f16c2b6-20250905
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <cyril.chao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 164079890; Fri, 05 Sep 2025 15:17:39 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 5 Sep 2025 15:17:35 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 5 Sep 2025 15:17:34 +0800
From: Cyril Chao <Cyril.Chao@mediatek.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Darren Ye
	<darren.ye@mediatek.com>, Cyril Chao <cyril.chao@mediatek.com>
CC: <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Cyril Chao
	<Cyril.Chao@mediatek.com>
Subject: [PATCH v2 06/10] ASoC: mediatek: mt8189: support PCM in platform driver
Date: Fri, 5 Sep 2025 15:15:51 +0800
Message-ID: <20250905071659.25805-7-Cyril.Chao@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250905071659.25805-1-Cyril.Chao@mediatek.com>
References: <20250905071659.25805-1-Cyril.Chao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add mt8189 PCM DAI driver support.

Signed-off-by: Cyril Chao <Cyril.Chao@mediatek.com>
---
 sound/soc/mediatek/mt8189/mt8189-dai-pcm.c | 332 +++++++++++++++++++++
 1 file changed, 332 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8189/mt8189-dai-pcm.c

diff --git a/sound/soc/mediatek/mt8189/mt8189-dai-pcm.c b/sound/soc/mediatek/mt8189/mt8189-dai-pcm.c
new file mode 100644
index 000000000000..21317c0413e5
--- /dev/null
+++ b/sound/soc/mediatek/mt8189/mt8189-dai-pcm.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  MediaTek ALSA SoC Audio DAI I2S Control
+ *
+ *  Copyright (c) 2025 MediaTek Inc.
+ *  Author: Darren Ye <darren.ye@mediatek.com>
+ */
+
+#include <linux/regmap.h>
+
+#include <sound/pcm_params.h>
+
+#include "mt8189-afe-common.h"
+#include "mt8189-interconnection.h"
+#include "mt8189-afe-clk.h"
+
+enum AUD_TX_LCH_RPT {
+	AUD_TX_LCH_RPT_NO_REPEAT,
+	AUD_TX_LCH_RPT_REPEAT
+};
+
+enum AUD_VBT_16K_MODE {
+	AUD_VBT_16K_MODE_DISABLE,
+	AUD_VBT_16K_MODE_ENABLE
+};
+
+enum AUD_EXT_MODEM {
+	AUD_EXT_MODEM_SELECT_INTERNAL,
+	AUD_EXT_MODEM_SELECT_EXTERNAL
+};
+
+enum AUD_PCM_SYNC_TYPE {
+	/* bck sync length = 1 */
+	AUD_PCM_ONE_BCK_CYCLE_SYNC,
+	/* bck sync length = PCM_INTF_CON1[9:13] */
+	AUD_PCM_EXTENDED_BCK_CYCLE_SYNC
+};
+
+enum AUD_BT_MODE {
+	AUD_BT_MODE_DUAL_MIC_ON_TX,
+	AUD_BT_MODE_SINGLE_MIC_ON_TX
+};
+
+enum AUD_PCM_AFIFO_SRC {
+	/* slave mode & external modem uses different crystal */
+	AUD_PCM_AFIFO_ASRC,
+	/* slave mode & external modem uses the same crystal */
+	AUD_PCM_AFIFO_AFIFO
+};
+
+enum AUD_PCM_CLOCK_SOURCE {
+	AUD_PCM_CLOCK_MASTER_MODE,
+	AUD_PCM_CLOCK_SLAVE_MODE
+};
+
+enum AUD_PCM_WLEN {
+	AUD_PCM_WLEN_PCM_32_BCK_CYCLES,
+	AUD_PCM_WLEN_PCM_64_BCK_CYCLES
+};
+
+enum AUD_PCM_MODE {
+	AUD_PCM_MODE_PCM_MODE_8K,
+	AUD_PCM_MODE_PCM_MODE_16K,
+	AUD_PCM_MODE_PCM_MODE_32K,
+	AUD_PCM_MODE_PCM_MODE_48K
+};
+
+enum AUD_PCM_FMT {
+	AUD_PCM_FMT_I2S,
+	AUD_PCM_FMT_EIAJ,
+	AUD_PCM_FMT_PCM_MODE_A,
+	AUD_PCM_FMT_PCM_MODE_B
+};
+
+enum AUD_BCLK_OUT_INV {
+	AUD_BCLK_OUT_INV_NO_INVERSE,
+	AUD_BCLK_OUT_INV_INVERSE
+};
+
+enum AUD_PCM_EN {
+	AUD_PCM_EN_DISABLE,
+	AUD_PCM_EN_ENABLE
+};
+
+enum AUD_PCM1_1X_EN_DOMAIN {
+	HOPPING_26M,
+	APLL,
+	SLAVE = 6
+};
+
+enum AUD_PCM1_1X_EN_SLAVE_MODE {
+	PCM0_SLAVE_1X_EN,
+	PCM1_SLAVE_1X_EN
+};
+
+enum {
+	PCM_8K,
+	PCM_16K = 4,
+	PCM_32K = 8,
+	PCM_48K = 10
+};
+
+static unsigned int pcm_1x_rate_transform(struct device *dev,
+					  unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return PCM_8K;
+	case 16000:
+		return PCM_16K;
+	case 32000:
+		return PCM_32K;
+	case 48000:
+		return PCM_48K;
+	default:
+		dev_warn(dev, "rate %u invalid, use %d!!!\n",
+			 rate, PCM_48K);
+		return PCM_48K;
+	}
+}
+
+static unsigned int pcm_rate_transform(struct device *dev,
+				       unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return MTK_AFE_PCM_RATE_8K;
+	case 16000:
+		return MTK_AFE_PCM_RATE_16K;
+	case 32000:
+		return MTK_AFE_PCM_RATE_32K;
+	case 48000:
+		return MTK_AFE_PCM_RATE_48K;
+	default:
+		dev_warn(dev, "rate %u invalid, use %d\n",
+			 rate, MTK_AFE_PCM_RATE_48K);
+		return MTK_AFE_PCM_RATE_48K;
+	}
+}
+
+/* dai component */
+static const struct snd_kcontrol_new mtk_pcm_0_playback_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN096_0,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1", AFE_CONN096_1,
+				    I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL_24CH_CH1", AFE_CONN096_1,
+				    I_DL_24CH_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_pcm_0_playback_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN097_0,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2", AFE_CONN097_1,
+				    I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL_24CH_CH2", AFE_CONN097_1,
+				    I_DL_24CH_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_pcm_0_playback_ch4_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I2SIN1_CH1", AFE_CONN099_4,
+				    I_I2SIN1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2SIN1_CH2", AFE_CONN099_4,
+				    I_I2SIN1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL0_CH1", AFE_CONN099_1,
+				    I_DL0_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL_24CH_CH1", AFE_CONN099_1,
+				    I_DL_24CH_CH1, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget mtk_dai_pcm_widgets[] = {
+	/* inter-connections */
+	SND_SOC_DAPM_MIXER("PCM_0_PB_CH1", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_0_playback_ch1_mix,
+			   ARRAY_SIZE(mtk_pcm_0_playback_ch1_mix)),
+	SND_SOC_DAPM_MIXER("PCM_0_PB_CH2", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_0_playback_ch2_mix,
+			   ARRAY_SIZE(mtk_pcm_0_playback_ch2_mix)),
+	SND_SOC_DAPM_MIXER("PCM_0_PB_CH4", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_0_playback_ch4_mix,
+			   ARRAY_SIZE(mtk_pcm_0_playback_ch4_mix)),
+
+	SND_SOC_DAPM_SUPPLY("PCM_0_EN",
+			    AFE_PCM0_INTF_CON0, PCM0_EN_SFT, 0,
+			    NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("PCM0_CG", AUDIO_TOP_CON0, PDN_PCM0_SFT, 1,
+			    NULL, 0),
+
+	SND_SOC_DAPM_INPUT("AFE_PCM_INPUT"),
+	SND_SOC_DAPM_OUTPUT("AFE_PCM_OUTPUT"),
+};
+
+static const struct snd_soc_dapm_route mtk_dai_pcm_routes[] = {
+	{"PCM 0 Playback", NULL, "PCM_0_PB_CH1"},
+	{"PCM 0 Playback", NULL, "PCM_0_PB_CH2"},
+	{"PCM 0 Playback", NULL, "PCM_0_PB_CH4"},
+
+	{"PCM 0 Playback", NULL, "PCM_0_EN"},
+	{"PCM 0 Capture", NULL, "PCM_0_EN"},
+	{"PCM 0 Playback", NULL, "PCM0_CG"},
+	{"PCM 0 Capture", NULL, "PCM0_CG"},
+
+	{"AFE_PCM_OUTPUT", NULL, "PCM 0 Playback"},
+	{"PCM 0 Capture", NULL, "AFE_PCM_INPUT"},
+
+	{"PCM_0_PB_CH1", "DL2_CH1", "DL2"},
+	{"PCM_0_PB_CH2", "DL2_CH2", "DL2"},
+	{"PCM_0_PB_CH4", "DL0_CH1", "DL0"},
+
+	{"PCM_0_PB_CH1", "DL_24CH_CH1", "DL_24CH"},
+	{"PCM_0_PB_CH2", "DL_24CH_CH2", "DL_24CH"},
+	{"PCM_0_PB_CH4", "DL_24CH_CH1", "DL_24CH"},
+};
+
+/* dai ops */
+static int mtk_dai_pcm_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	unsigned int rate = params_rate(params);
+	unsigned int rate_reg = pcm_rate_transform(afe->dev, rate);
+	unsigned int x_rate_reg = pcm_1x_rate_transform(afe->dev, rate);
+	unsigned int pcm_con0;
+	unsigned int pcm_con1;
+	unsigned int playback_active = 0;
+	unsigned int capture_active = 0;
+	struct snd_soc_dapm_widget *playback_widget =
+		snd_soc_dai_get_widget(dai, SNDRV_PCM_STREAM_PLAYBACK);
+	struct snd_soc_dapm_widget *capture_widget =
+		snd_soc_dai_get_widget(dai, SNDRV_PCM_STREAM_CAPTURE);
+
+	if (playback_widget)
+		playback_active = playback_widget->active;
+	if (capture_widget)
+		capture_active = capture_widget->active;
+	dev_dbg(afe->dev,
+		"id %d, stream %d, rate %d, rate_reg %d, active p %d, c %d\n",
+		dai->id, substream->stream, rate, rate_reg,
+		playback_active, capture_active);
+
+	if (playback_active || capture_active)
+		return 0;
+	switch (dai->id) {
+	case MT8189_DAI_PCM_0:
+		pcm_con0 = AUD_BCLK_OUT_INV_NO_INVERSE << PCM0_BCLK_OUT_INV_SFT;
+		pcm_con0 |= AUD_TX_LCH_RPT_NO_REPEAT << PCM0_TX_LCH_RPT_SFT;
+		pcm_con0 |= AUD_VBT_16K_MODE_DISABLE << PCM0_VBT_16K_MODE_SFT;
+		pcm_con0 |= 0 << PCM0_SYNC_LENGTH_SFT;
+		pcm_con0 |= AUD_PCM_ONE_BCK_CYCLE_SYNC << PCM0_SYNC_TYPE_SFT;
+		pcm_con0 |= AUD_PCM_AFIFO_AFIFO << PCM0_BYP_ASRC_SFT;
+		pcm_con0 |= AUD_PCM_CLOCK_MASTER_MODE << PCM0_SLAVE_SFT;
+		pcm_con0 |= rate_reg << PCM0_MODE_SFT;
+		pcm_con0 |= AUD_PCM_FMT_I2S << PCM0_FMT_SFT;
+
+		pcm_con1 = AUD_EXT_MODEM_SELECT_INTERNAL << PCM0_EXT_MODEM_SFT;
+		pcm_con1 |= AUD_BT_MODE_DUAL_MIC_ON_TX << PCM0_BT_MODE_SFT;
+		pcm_con1 |= HOPPING_26M << PCM0_1X_EN_DOMAIN_SFT;
+		pcm_con1 |= x_rate_reg << PCM0_1X_EN_MODE_SFT;
+
+		regmap_update_bits(afe->regmap, AFE_PCM0_INTF_CON0,
+				   ~(unsigned int)PCM0_EN_MASK_SFT, pcm_con0);
+		regmap_update_bits(afe->regmap, AFE_PCM0_INTF_CON1,
+				   AFE_PCM0_INTF_CON1_MASK_MON_MASK_SFT,
+				   pcm_con1);
+		break;
+	default:
+		dev_err(afe->dev, "%s(), id %d not support\n",
+			__func__, dai->id);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mtk_dai_pcm_ops = {
+	.hw_params = mtk_dai_pcm_hw_params,
+};
+
+/* dai driver */
+#define MTK_PCM_RATES (SNDRV_PCM_RATE_8000 |\
+		       SNDRV_PCM_RATE_16000 |\
+		       SNDRV_PCM_RATE_32000 |\
+		       SNDRV_PCM_RATE_48000)
+
+#define MTK_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_pcm_driver[] = {
+	{
+		.name = "PCM 0",
+		.id = MT8189_DAI_PCM_0,
+		.playback = {
+			.stream_name = "PCM 0 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.capture = {
+			.stream_name = "PCM 0 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_dai_pcm_ops,
+		.symmetric_rate = 1,
+		.symmetric_sample_bits = 1,
+	},
+};
+
+int mt8189_dai_pcm_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	dai->dai_drivers = mtk_dai_pcm_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_pcm_driver);
+	dai->dapm_widgets = mtk_dai_pcm_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_pcm_widgets);
+	dai->dapm_routes = mtk_dai_pcm_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_pcm_routes);
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	return 0;
+}
-- 
2.45.2


