Return-Path: <linux-kernel+bounces-802237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2D7B44F4E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2353A8A45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECD02EC08E;
	Fri,  5 Sep 2025 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EOVYPm5K"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20982FFDEA;
	Fri,  5 Sep 2025 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056677; cv=none; b=XaCR4cz91trskEHn+agttB6nWxoONy7BoExorE0LNLzqtNMW7wn5d+m+MRK+qQEE8e8KKLskDVjsytQFULOauzlySW8YQhwOV9OBeHsOWCthlY42KVX5jY4mgO+/Uo28zP2XJpDz//I12GY3oMImCIAHW1rpnGhCHo7kENknouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056677; c=relaxed/simple;
	bh=2A2KRt+mOHqXF9abqFQvf6tQWJ5qQpK9dpbY1tICjFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBcYkiHNovCWIGVQuGiHFeCSLBo0seJOPNFMF17vp8PkJtlNzinrcX8CiswjA7cvGgBERSYhjyzHjYPJQkcFIWvduhTsscUcMZbwneslw6e7oKObEHwC3NaxjD4LnX/O0grTOC+pOx9pxdZqcr6ZmG5pwbYqnwlH25mF/RZ8Vjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EOVYPm5K; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6cdea6288a2811f0b33aeb1e7f16c2b6-20250905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=t4UCQtE0BsPaOpVdNpIZyEkPvM5PpFxXdDMD2ed5go8=;
	b=EOVYPm5KxYcUlcal8G0uurHRB+/eHhIwatgRBj3rFtIOIPHjcjSXN5ociGi16d5pZFMquaYSK99casfCA07OPJMezQC7GeSULZfRWB+qRxVD82R0gbUsI+c28M6CaFlpuj+BzR/TOmJUe0Kn12p1Ea1Iari3fw0H+UgGeIBoRmA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:ac55f421-4300-4d80-a2ce-b3c86da7b2d3,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:17f0f9f7-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6cdea6288a2811f0b33aeb1e7f16c2b6-20250905
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <cyril.chao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1793385100; Fri, 05 Sep 2025 15:17:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 5 Sep 2025 15:17:43 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 5 Sep 2025 15:17:42 +0800
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
Subject: [PATCH v2 10/10] ASoC: mediatek: mt8189: add machine driver with nau8825
Date: Fri, 5 Sep 2025 15:15:55 +0800
Message-ID: <20250905071659.25805-11-Cyril.Chao@mediatek.com>
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

Add support for mt8189 board with nau8825.

Signed-off-by: Cyril Chao <Cyril.Chao@mediatek.com>
---
 sound/soc/mediatek/Kconfig                 |   18 +
 sound/soc/mediatek/mt8189/Makefile         |    3 +
 sound/soc/mediatek/mt8189/mt8189-nau8825.c | 1041 ++++++++++++++++++++
 3 files changed, 1062 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8189/mt8189-nau8825.c

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index b28648e0d913..19689d1838a9 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -256,6 +256,24 @@ config SND_SOC_MT8189
 	  Select Y if you have such device.
 	  If unsure select "N".
 
+config SND_SOC_MT8189_NAU8825
+	tristate "ASoc Audio driver for MT8189 with NAU8825 and I2S codec"
+	depends on SND_SOC_MT8189
+	depends on I2C
+	select SND_SOC_DMIC
+	select SND_SOC_HDMI_CODEC
+	select SND_SOC_NAU8825
+	select SND_SOC_RT5645
+	select SND_SOC_RT9123P
+	select SND_SOC_RT1015P
+	select SND_SOC_RT5682S
+	select SND_SOC_RT5682_I2C
+	help
+	  This adds support for ASoC machine driver for MediaTek MT8189
+	  boards with the NAU8828 and other I2S audio codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
 config SND_SOC_MT8192
 	tristate "ASoC support for Mediatek MT8192 chip"
 	depends on ARCH_MEDIATEK
diff --git a/sound/soc/mediatek/mt8189/Makefile b/sound/soc/mediatek/mt8189/Makefile
index 795b1869bd27..83a033284182 100644
--- a/sound/soc/mediatek/mt8189/Makefile
+++ b/sound/soc/mediatek/mt8189/Makefile
@@ -13,3 +13,6 @@ snd-soc-mt8189-afe-objs += \
 	mt8189-dai-tdm.o
 
 obj-$(CONFIG_SND_SOC_MT8189) += snd-soc-mt8189-afe.o
+
+# machine driver
+obj-$(CONFIG_SND_SOC_MT8189_NAU8825) += mt8189-nau8825.o
diff --git a/sound/soc/mediatek/mt8189/mt8189-nau8825.c b/sound/soc/mediatek/mt8189/mt8189-nau8825.c
new file mode 100644
index 000000000000..bfc1b2a784bd
--- /dev/null
+++ b/sound/soc/mediatek/mt8189/mt8189-nau8825.c
@@ -0,0 +1,1041 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  mt8189-nau8825.c  --  mt8189 nau8825 ALSA SoC machine driver
+ *
+ *  Copyright (c) 2025 MediaTek Inc.
+ *  Author: Darren Ye <darren.ye@mediatek.com>
+ */
+
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include <sound/pcm_params.h>
+
+#include "mt8189-afe-common.h"
+
+#include "../common/mtk-soc-card.h"
+#include "../common/mtk-soundcard-driver.h"
+#include "../common/mtk-afe-platform-driver.h"
+
+#include "../../codecs/nau8825.h"
+#include "../../codecs/rt5682s.h"
+#include "../../codecs/rt5682.h"
+
+#define NAU8825_HS_PRESENT	BIT(0)
+#define RT5682S_HS_PRESENT	BIT(1)
+#define RT5650_HS_PRESENT	BIT(2)
+#define RT5682I_HS_PRESENT	BIT(3)
+
+/*
+ * Nau88l25
+ */
+#define NAU8825_CODEC_DAI  "nau8825-hifi"
+
+/*
+ * Rt5682s
+ */
+#define RT5682S_CODEC_DAI     "rt5682s-aif1"
+
+/*
+ * Rt5650
+ */
+#define RT5650_CODEC_DAI     "rt5645-aif1"
+
+/*
+ * Rt5682i
+ */
+#define RT5682I_CODEC_DAI     "rt5682-aif1"
+
+enum mt8189_jacks {
+	MT8189_JACK_HEADSET,
+	MT8189_JACK_DP,
+	MT8189_JACK_HDMI,
+	MT8189_JACK_MAX,
+};
+
+static struct snd_soc_jack_pin mt8189_dp_jack_pins[] = {
+	{
+		.pin = "DP",
+		.mask = SND_JACK_LINEOUT,
+	},
+};
+
+static struct snd_soc_jack_pin mt8189_hdmi_jack_pins[] = {
+	{
+		.pin = "HDMI",
+		.mask = SND_JACK_LINEOUT,
+	},
+};
+
+static struct snd_soc_jack_pin mt8189_headset_jack_pins[] = {
+	{
+		.pin    = "Headphone Jack",
+		.mask   = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin    = "Headset Mic",
+		.mask   = SND_JACK_MICROPHONE,
+	},
+};
+
+static const struct snd_kcontrol_new mt8189_dumb_spk_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Ext Spk"),
+};
+
+static const struct snd_soc_dapm_widget mt8189_dumb_spk_widgets[] = {
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+static const struct snd_soc_dapm_widget mt8189_headset_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+};
+
+static const struct snd_kcontrol_new mt8189_headset_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
+static const struct snd_soc_dapm_widget mt8189_nau8825_card_widgets[] = {
+	SND_SOC_DAPM_SINK("DP"),
+};
+
+static int mt8189_common_i2s_startup(struct snd_pcm_substream *substream)
+{
+	static const unsigned int rates[] = {
+		48000,
+	};
+	static const struct snd_pcm_hw_constraint_list constraints_rates = {
+		.count = ARRAY_SIZE(rates),
+		.list  = rates,
+	};
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_RATE,
+					  &constraints_rates);
+}
+
+static int mt8189_common_i2s_hw_params(struct snd_pcm_substream *substream,
+				       struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	unsigned int rate = params_rate(params);
+	unsigned int mclk_fs_ratio = 128;
+	unsigned int mclk_fs = rate * mclk_fs_ratio;
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+
+	return snd_soc_dai_set_sysclk(cpu_dai,
+				      0, mclk_fs, SND_SOC_CLOCK_OUT);
+}
+
+static const struct snd_soc_ops mt8189_common_i2s_ops = {
+	.startup = mt8189_common_i2s_startup,
+	.hw_params = mt8189_common_i2s_hw_params,
+};
+
+static int mt8189_dptx_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	unsigned int rate = params_rate(params);
+	unsigned int mclk_fs_ratio = 256;
+	unsigned int mclk_fs = rate * mclk_fs_ratio;
+	struct snd_soc_dai *dai = snd_soc_rtd_to_cpu(rtd, 0);
+
+	return snd_soc_dai_set_sysclk(dai, 0, mclk_fs, SND_SOC_CLOCK_OUT);
+}
+
+static const struct snd_soc_ops mt8189_dptx_ops = {
+	.hw_params = mt8189_dptx_hw_params,
+};
+
+static int mt8189_dptx_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				       struct snd_pcm_hw_params *params)
+{
+	dev_dbg(rtd->dev, "%s(), fix format to 32bit\n", __func__);
+
+	/* fix BE i2s format to 32bit, clean param mask first */
+	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
+			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
+
+	params_set_format(params, SNDRV_PCM_FORMAT_S32_LE);
+
+	return 0;
+}
+
+static const struct snd_soc_ops mt8189_pcm_ops = {
+	.startup = mt8189_common_i2s_startup,
+};
+
+static int mt8189_nau8825_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
+	unsigned int rate = params_rate(params);
+	unsigned int bit_width = params_width(params);
+	int clk_freq, ret;
+
+	clk_freq = rate * 2 * bit_width;
+	dev_dbg(codec_dai->dev, "clk_freq %d, rate: %d, bit_width: %d\n",
+		clk_freq, rate, bit_width);
+
+	/* Configure clock for codec */
+	ret = snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_BLK, 0,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "can't set BCLK clock %d\n", ret);
+		return ret;
+	}
+
+	/* Configure pll for codec */
+	ret = snd_soc_dai_set_pll(codec_dai, 0, 0, clk_freq,
+				  rate * 256);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "can't set BCLK: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_ops mt8189_nau8825_ops = {
+	.startup = mt8189_common_i2s_startup,
+	.hw_params = mt8189_nau8825_hw_params,
+};
+
+static int mt8189_rtxxxx_i2s_hw_params(struct snd_pcm_substream *substream,
+				       struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
+	unsigned int rate = params_rate(params);
+	int bitwidth;
+	int ret;
+
+	bitwidth = snd_pcm_format_width(params_format(params));
+	if (bitwidth < 0) {
+		dev_err(card->dev, "invalid bit width: %d\n", bitwidth);
+		return bitwidth;
+	}
+
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x00, 0x0, 0x2, bitwidth);
+	if (ret) {
+		dev_err(card->dev, "failed to set tdm slot\n");
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_pll(codec_dai, 0, 1, rate * 32, rate * 512);
+	if (ret) {
+		dev_err(card->dev, "failed to set pll\n");
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 1, rate * 512, SND_SOC_CLOCK_IN);
+	if (ret) {
+		dev_err(card->dev, "failed to set sysclk\n");
+		return ret;
+	}
+
+	return snd_soc_dai_set_sysclk(cpu_dai, 0, rate * 512,
+				      SND_SOC_CLOCK_OUT);
+}
+
+static const struct snd_soc_ops mt8189_rtxxxx_i2s_ops = {
+	.startup = mt8189_common_i2s_startup,
+	.hw_params = mt8189_rtxxxx_i2s_hw_params,
+};
+
+static int mt8189_dumb_amp_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(&card->dapm, mt8189_dumb_spk_widgets,
+					ARRAY_SIZE(mt8189_dumb_spk_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add Dumb Speaker dapm, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, mt8189_dumb_spk_controls,
+					ARRAY_SIZE(mt8189_dumb_spk_controls));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add Dumb card controls, ret %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mt8189_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8189_JACK_DP];
+	struct snd_soc_component *component = snd_soc_rtd_to_codec(rtd, 0)->component;
+	int ret;
+
+	ret = snd_soc_card_jack_new_pins(rtd->card, "DP Jack", SND_JACK_LINEOUT,
+					 jack, mt8189_dp_jack_pins,
+					 ARRAY_SIZE(mt8189_dp_jack_pins));
+	if (ret) {
+		dev_err(rtd->dev, "%s, new jack failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = snd_soc_component_set_jack(component, jack, NULL);
+	if (ret) {
+		dev_err(rtd->dev, "%s, set jack failed on %s (ret=%d)\n",
+			__func__, component->name, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mt8189_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8189_JACK_HDMI];
+	struct snd_soc_component *component = snd_soc_rtd_to_codec(rtd, 0)->component;
+	int ret;
+
+	ret = snd_soc_card_jack_new_pins(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
+					 jack, mt8189_hdmi_jack_pins,
+					 ARRAY_SIZE(mt8189_hdmi_jack_pins));
+	if (ret) {
+		dev_err(rtd->dev, "%s, new jack failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = snd_soc_component_set_jack(component, jack, NULL);
+	if (ret) {
+		dev_err(rtd->dev, "%s, set jack failed on %s (ret=%d)\n",
+			__func__, component->name, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mt8189_headset_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(card);
+	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8189_JACK_HEADSET];
+	struct snd_soc_component *component = snd_soc_rtd_to_codec(rtd, 0)->component;
+	int ret;
+	int type;
+
+	ret = snd_soc_dapm_new_controls(&card->dapm, mt8189_headset_widgets,
+					ARRAY_SIZE(mt8189_headset_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add nau8825 card widget, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, mt8189_headset_controls,
+					ARRAY_SIZE(mt8189_headset_controls));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add nau8825 card controls, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_BTN_0 |
+					 SND_JACK_BTN_1 | SND_JACK_BTN_2 |
+					 SND_JACK_BTN_3,
+					 jack,
+					 mt8189_headset_jack_pins,
+					 ARRAY_SIZE(mt8189_headset_jack_pins));
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
+		return ret;
+	}
+
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+
+	type = SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2 | SND_JACK_BTN_3;
+	ret = snd_soc_component_set_jack(component, jack, (void *)&type);
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack call-back failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+};
+
+static void mt8189_headset_codec_exit(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *component = snd_soc_rtd_to_codec(rtd, 0)->component;
+
+	snd_soc_component_set_jack(component, NULL, NULL);
+}
+
+/* FE */
+SND_SOC_DAILINK_DEFS(playback0,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL0")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(playback1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(playback2,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(playback3,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL3")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(playback4,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL4")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(playback5,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL5")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(playback6,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL6")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(playback7,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL7")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(playback8,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL8")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(playback23,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL23")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(playback24,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL24")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(playback25,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL25")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(playback_24ch,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL_24CH")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture0,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL0")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture2,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture3,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL3")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture4,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL4")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture5,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL5")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture6,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL6")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture7,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL7")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture8,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL8")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture9,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL9")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture10,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL10")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture24,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL24")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture25,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL25")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture_cm0,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL_CM0")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture_cm1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL_CM1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture_etdm_in0,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL_ETDM_IN0")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(capture_etdm_in1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL_ETDM_IN1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(playback_hdmi,
+		     DAILINK_COMP_ARRAY(COMP_CPU("HDMI")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+/* BE */
+SND_SOC_DAILINK_DEFS(ap_dmic,
+		     DAILINK_COMP_ARRAY(COMP_CPU("AP_DMIC")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(ap_dmic_ch34,
+		     DAILINK_COMP_ARRAY(COMP_CPU("AP_DMIC_CH34")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(i2sin0,
+		     DAILINK_COMP_ARRAY(COMP_CPU("I2SIN0")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(i2sin1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("I2SIN1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(i2sout0,
+		     DAILINK_COMP_ARRAY(COMP_CPU("I2SOUT0")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(i2sout1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("I2SOUT1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(pcm0,
+		     DAILINK_COMP_ARRAY(COMP_CPU("PCM 0")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+SND_SOC_DAILINK_DEFS(tdm_dptx,
+		     DAILINK_COMP_ARRAY(COMP_CPU("TDM_DPTX")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+static struct snd_soc_dai_link mt8189_nau8825_dai_links[] = {
+	/* Front End DAI links */
+	{
+		.name = "DL0_FE",
+		.stream_name = "DL0 Playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback0),
+	},
+	{
+		.name = "DL1_FE",
+		.stream_name = "DL1 Playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback1),
+	},
+	{
+		.name = "UL0_FE",
+		.stream_name = "UL0 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+				SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture0),
+	},
+	{
+		.name = "UL1_FE",
+		.stream_name = "UL1 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+				SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture1),
+	},
+	{
+		.name = "UL2_FE",
+		.stream_name = "UL2 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+				SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture2),
+	},
+	{
+		.name = "HDMI_FE",
+		.stream_name = "HDMI Playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+				SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback_hdmi),
+	},
+	{
+		.name = "DL2_FE",
+		.stream_name = "DL2 Playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+				SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback2),
+	},
+	{
+		.name = "DL3_FE",
+		.stream_name = "DL3 Playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback3),
+	},
+	{
+		.name = "DL4_FE",
+		.stream_name = "DL4 Playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback4),
+	},
+	{
+		.name = "DL5_FE",
+		.stream_name = "DL5 Playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback5),
+	},
+	{
+		.name = "DL6_FE",
+		.stream_name = "DL6 Playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback6),
+	},
+	{
+		.name = "DL7_FE",
+		.stream_name = "DL7 Playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback7),
+	},
+	{
+		.name = "DL8 FE",
+		.stream_name = "DL8 Playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback8),
+	},
+	{
+		.name = "DL23 FE",
+		.stream_name = "DL23 Playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback23),
+	},
+	{
+		.name = "DL24 FE",
+		.stream_name = "DL24 Playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback24),
+	},
+	{
+		.name = "DL25 FE",
+		.stream_name = "DL25 Playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback25),
+	},
+	{
+		.name = "DL_24CH_FE",
+		.stream_name = "DL_24CH Playback",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.playback_only = 1,
+		SND_SOC_DAILINK_REG(playback_24ch),
+	},
+	{
+		.name = "UL9_FE",
+		.stream_name = "UL9 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture9),
+	},
+	{
+		.name = "UL3_FE",
+		.stream_name = "UL3 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture3),
+	},
+	{
+		.name = "UL7_FE",
+		.stream_name = "UL7 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture7),
+	},
+	{
+		.name = "UL4_FE",
+		.stream_name = "UL4 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture4),
+	},
+	{
+		.name = "UL5_FE",
+		.stream_name = "UL5 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture5),
+	},
+	{
+		.name = "UL_CM0_FE",
+		.stream_name = "UL_CM0 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture_cm0),
+	},
+	{
+		.name = "UL_CM1_FE",
+		.stream_name = "UL_CM1 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture_cm1),
+	},
+	{
+		.name = "UL10_FE",
+		.stream_name = "UL10 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture10),
+	},
+	{
+		.name = "UL6_FE",
+		.stream_name = "UL6 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture6),
+	},
+	{
+		.name = "UL25_FE",
+		.stream_name = "UL25 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture25),
+	},
+	{
+		.name = "UL8_FE",
+		.stream_name = "UL8 Capture_Mono_1",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture8),
+	},
+	{
+		.name = "UL24_FE",
+		.stream_name = "UL24 Capture_Mono_2",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture24),
+	},
+	{
+		.name = "UL_ETDM_In0_FE",
+		.stream_name = "UL_ETDM_In0 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture_etdm_in0),
+	},
+	{
+		.name = "UL_ETDM_In1_FE",
+		.stream_name = "UL_ETDM_In1 Capture",
+		.trigger = {SND_SOC_DPCM_TRIGGER_PRE,
+			    SND_SOC_DPCM_TRIGGER_PRE},
+		.dynamic = 1,
+		.capture_only = 1,
+		SND_SOC_DAILINK_REG(capture_etdm_in1),
+	},
+	/* Back End DAI links */
+	{
+		.name = "I2SIN0_BE",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBC_CFC
+			| SND_SOC_DAIFMT_GATED,
+		.ops = &mt8189_common_i2s_ops,
+		.no_pcm = 1,
+		.capture_only = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(i2sin0),
+	},
+	{
+		.name = "I2SIN1_BE",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBC_CFC
+			| SND_SOC_DAIFMT_GATED,
+		.ops = &mt8189_common_i2s_ops,
+		.no_pcm = 1,
+		.capture_only = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(i2sin1),
+	},
+	{
+		.name = "I2SOUT0_BE",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBC_CFC
+			| SND_SOC_DAIFMT_GATED,
+		.ops = &mt8189_common_i2s_ops,
+		.no_pcm = 1,
+		.playback_only = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(i2sout0),
+	},
+	{
+		.name = "I2SOUT1_BE",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBC_CFC
+			| SND_SOC_DAIFMT_GATED,
+		.ops = &mt8189_common_i2s_ops,
+		.no_pcm = 1,
+		.playback_only = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(i2sout1),
+	},
+	{
+		.name = "AP_DMIC_BE",
+		.no_pcm = 1,
+		.capture_only = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(ap_dmic),
+	},
+	{
+		.name = "AP_DMIC_CH34_BE",
+		.no_pcm = 1,
+		.capture_only = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(ap_dmic_ch34),
+	},
+	{
+		.name = "TDM_DPTX_BE",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBC_CFC
+			| SND_SOC_DAIFMT_GATED,
+		.ops = &mt8189_dptx_ops,
+		.be_hw_params_fixup = mt8189_dptx_hw_params_fixup,
+		.no_pcm = 1,
+		.playback_only = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(tdm_dptx),
+	},
+	{
+		.name = "PCM_0_BE",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBC_CFC
+			| SND_SOC_DAIFMT_GATED,
+		.no_pcm = 1,
+		.ops = &mt8189_pcm_ops,
+		.playback_only = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(pcm0),
+	},
+};
+
+static int mt8189_nau8825_soc_card_probe(struct mtk_soc_card_data *soc_card_data, bool legacy)
+{
+	struct snd_soc_card *card = soc_card_data->card_data->card;
+	struct snd_soc_dai_link *dai_link;
+	bool init_nau8825 = false;
+	bool init_rt5682s = false;
+	bool init_rt5650 = false;
+	bool init_rt5682i = false;
+	bool init_dumb = false;
+	int i;
+
+	for_each_card_prelinks(card, i, dai_link) {
+		if (strcmp(dai_link->name, "TDM_DPTX_BE") == 0) {
+			if (dai_link->num_codecs &&
+			    strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
+				dai_link->init = mt8189_dptx_codec_init;
+		} else if (strcmp(dai_link->name, "PCM_0_BE") == 0) {
+			if (dai_link->num_codecs &&
+			    strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
+				dai_link->init = mt8189_hdmi_codec_init;
+		} else if (strcmp(dai_link->name, "I2SOUT0_BE") == 0 ||
+			   strcmp(dai_link->name, "I2SIN0_BE") == 0) {
+			if (!strcmp(dai_link->codecs->dai_name, NAU8825_CODEC_DAI)) {
+				dai_link->ops = &mt8189_nau8825_ops;
+				if (!init_nau8825) {
+					dai_link->init = mt8189_headset_codec_init;
+					dai_link->exit = mt8189_headset_codec_exit;
+					init_nau8825 = true;
+				}
+			} else if (!strcmp(dai_link->codecs->dai_name, RT5682S_CODEC_DAI)) {
+				dai_link->ops = &mt8189_rtxxxx_i2s_ops;
+				if (!init_rt5682s) {
+					dai_link->init = mt8189_headset_codec_init;
+					dai_link->exit = mt8189_headset_codec_exit;
+					init_rt5682s = true;
+				}
+			} else if (!strcmp(dai_link->codecs->dai_name, RT5650_CODEC_DAI)) {
+				dai_link->ops = &mt8189_rtxxxx_i2s_ops;
+				if (!init_rt5650) {
+					dai_link->init = mt8189_headset_codec_init;
+					dai_link->exit = mt8189_headset_codec_exit;
+					init_rt5650 = true;
+				}
+			} else if (!strcmp(dai_link->codecs->dai_name, RT5682I_CODEC_DAI)) {
+				dai_link->ops = &mt8189_rtxxxx_i2s_ops;
+				if (!init_rt5682i) {
+					dai_link->init = mt8189_headset_codec_init;
+					dai_link->exit = mt8189_headset_codec_exit;
+					init_rt5682i = true;
+				}
+			} else {
+				if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai")) {
+					if (!init_dumb) {
+						dai_link->init = mt8189_dumb_amp_init;
+						init_dumb = true;
+					}
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
+static struct snd_soc_card mt8189_nau8825_soc_card = {
+	.owner = THIS_MODULE,
+	.dai_link = mt8189_nau8825_dai_links,
+	.num_links = ARRAY_SIZE(mt8189_nau8825_dai_links),
+	.dapm_widgets = mt8189_nau8825_card_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt8189_nau8825_card_widgets),
+};
+
+static const struct mtk_soundcard_pdata mt8189_nau8825_card = {
+	.card_name = "mt8189_nau8825",
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8189_nau8825_soc_card,
+		.num_jacks = MT8189_JACK_MAX,
+		.flags = NAU8825_HS_PRESENT
+	},
+	.sof_priv = NULL,
+	.soc_probe = mt8189_nau8825_soc_card_probe,
+};
+
+static const struct mtk_soundcard_pdata mt8189_rt5650_card = {
+	.card_name = "mt8189_rt5650",
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8189_nau8825_soc_card,
+		.num_jacks = MT8189_JACK_MAX,
+		.flags = RT5650_HS_PRESENT
+	},
+	.sof_priv = NULL,
+	.soc_probe = mt8189_nau8825_soc_card_probe,
+};
+
+static const struct mtk_soundcard_pdata mt8189_rt5682s_card = {
+	.card_name = "mt8189_rt5682s",
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8189_nau8825_soc_card,
+		.num_jacks = MT8189_JACK_MAX,
+		.flags = RT5682S_HS_PRESENT
+	},
+	.sof_priv = NULL,
+	.soc_probe = mt8189_nau8825_soc_card_probe,
+};
+
+static const struct mtk_soundcard_pdata mt8189_rt5682i_card = {
+	.card_name = "mt8189_rt5682i",
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8189_nau8825_soc_card,
+		.num_jacks = MT8189_JACK_MAX,
+		.flags = RT5682I_HS_PRESENT
+	},
+	.sof_priv = NULL,
+	.soc_probe = mt8189_nau8825_soc_card_probe,
+};
+
+static const struct of_device_id mt8189_nau8825_dt_match[] = {
+	{.compatible = "mediatek,mt8189-nau8825", .data = &mt8189_nau8825_card,},
+	{.compatible = "mediatek,mt8189-rt5650", .data = &mt8189_rt5650_card,},
+	{.compatible = "mediatek,mt8189-rt5682s", .data = &mt8189_rt5682s_card,},
+	{.compatible = "mediatek,mt8189-rt5682i", .data = &mt8189_rt5682i_card,},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mt8189_nau8825_dt_match);
+
+static struct platform_driver mt8189_nau8825_driver = {
+	.driver = {
+		.name = "mt8189-nau8825",
+		.of_match_table = mt8189_nau8825_dt_match,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = mtk_soundcard_common_probe,
+};
+module_platform_driver(mt8189_nau8825_driver);
+
+/* Module information */
+MODULE_DESCRIPTION("MT8189 NAU8825 ALSA SoC machine driver");
+MODULE_AUTHOR("Darren Ye <darren.ye@mediatek.com>");
+MODULE_AUTHOR("Cyril Chao <cyril.chao@mediatek.com>");
+MODULE_LICENSE("GPL");
-- 
2.45.2


