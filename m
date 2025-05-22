Return-Path: <linux-kernel+bounces-658984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A137AC09F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 12:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEED07B168D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 10:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55DA28A1EC;
	Thu, 22 May 2025 10:36:04 +0000 (UTC)
Received: from smtp134-83.sina.com.cn (smtp134-83.sina.com.cn [180.149.134.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2330289369
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747910163; cv=none; b=srU0UZXNGnmJH1PhLOHKgjm0ryhC7ROso3F4ce+9+8TLZjZiUgyKpejiZ2WqIlsj25HY9UsFuVADfyNAqIb7dPzWpwz5bLKmXLBFFYITMR3Gcth0gGLPakHeo1PSYnFCklKYWHtc1x1SeFhDHyDHNBm48+mQuWBNkWeVhwJSP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747910163; c=relaxed/simple;
	bh=F2boogHM6yOc9Kav+FI8XrE1bo3rPeFo9lENpLOC6pQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mVRwH83uWOegCXZW9iqkq3ZMGQfdpm7DHEknUYeK/w0H4vJBW9allXStM3XupfN/OVI9MxCTHMTZk+ASJ0f1CbB3AehoKZyDR+WsFXBqMIPEm2dyE76MVZDE1XwTxiHasNP8U93Jn6d/Y9X3K78lgb0TsEoZlent1Dk/CPdPsqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everest-semi.com; spf=pass smtp.mailfrom=everest-semi.com; arc=none smtp.client-ip=180.149.134.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everest-semi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everest-semi.com
Received: from unknown (HELO zy-virtual-machine.localdomain)([180.172.39.205])
	by sina.net (10.185.250.29) with ESMTP
	id 682EFE05000009F7; Thu, 22 May 2025 18:35:55 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 75A4AD20AE7346629A87D09FB6A60ADE
X-SMAIL-UIID: 75A4AD20AE7346629A87D09FB6A60ADE-20250522-183555
From: Zhang Yi <zhangyi@everest-semi.com>
To: broonie@kernel.org,
	robh@kernel.org,
	tiwai@suse.com,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	krzk+dt@kernel.org
Cc: amadeuszx.slawinski@linux.intel.com,
	krzk@kernel.org,
	Zhang Yi <zhangyi@everest-semi.com>
Subject: [PATCH v1 2/2] ASoC: codecs: add support for ES8375
Date: Thu, 22 May 2025 18:35:48 +0800
Message-Id: <20250522103548.20134-3-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250522103548.20134-1-zhangyi@everest-semi.com>
References: <20250522103548.20134-1-zhangyi@everest-semi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The driver is for codec es8375 of everest

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505221528.nvWwf9kj-lkp@intel.com/
---
 sound/soc/codecs/Kconfig  |   5 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/es8375.c | 797 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/es8375.h | 123 ++++++
 4 files changed, 927 insertions(+)
 create mode 100644 sound/soc/codecs/es8375.c
 create mode 100644 sound/soc/codecs/es8375.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8fe795504dbb..126f897312d4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -120,6 +120,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_ES8326
 	imply SND_SOC_ES8328_SPI
 	imply SND_SOC_ES8328_I2C
+	imply SND_SOC_ES8375
 	imply SND_SOC_ES8389
 	imply SND_SOC_ES7134
 	imply SND_SOC_ES7241
@@ -1212,6 +1213,10 @@ config SND_SOC_ES8328_SPI
 	depends on SPI_MASTER
 	select SND_SOC_ES8328
 
+config SND_SOC_ES8375
+	tristate "Everest Semi ES8375 CODEC"
+	depends on I2C
+
 config SND_SOC_ES8389
 	tristate "Everest Semi ES8389 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index c92824713df0..6d7aa109ede7 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -134,6 +134,7 @@ snd-soc-es8326-y := es8326.o
 snd-soc-es8328-y := es8328.o
 snd-soc-es8328-i2c-y := es8328-i2c.o
 snd-soc-es8328-spi-y := es8328-spi.o
+snd-soc-es8375-y := es8375.o
 snd-soc-es8389-y := es8389.o
 snd-soc-framer-y := framer-codec.o
 snd-soc-gtm601-y := gtm601.o
@@ -557,6 +558,7 @@ obj-$(CONFIG_SND_SOC_ES8326)    += snd-soc-es8326.o
 obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
+obj-$(CONFIG_SND_SOC_ES8375)    += snd-soc-es8375.o
 obj-$(CONFIG_SND_SOC_ES8389)    += snd-soc-es8389.o
 obj-$(CONFIG_SND_SOC_FRAMER)	+= snd-soc-framer.o
 obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
diff --git a/sound/soc/codecs/es8375.c b/sound/soc/codecs/es8375.c
new file mode 100644
index 000000000000..695b4a3a6294
--- /dev/null
+++ b/sound/soc/codecs/es8375.c
@@ -0,0 +1,797 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * es8375.c  --  ES8375 ALSA SoC Audio Codec
+ *
+ * Copyright Everest Semiconductor Co., Ltd
+ *
+ * Authors:  Michael Zhang (zhangyi@everest-semi.com)
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/tlv.h>
+#include <sound/soc.h>
+#include <linux/acpi.h>
+#include "es8375.h"
+
+struct	es8375_priv {
+	struct regmap *regmap;
+	struct clk *mclk;
+	struct regulator_bulk_data core_supply[2];
+	unsigned int  mclk_freq;
+	int mastermode;
+	u8 mclk_src;
+	u8 vddd;
+	enum snd_soc_bias_level bias_level;
+};
+
+static const char * const es8375_core_supplies[] = {
+	"vddd",
+	"vdda",
+};
+
+static const DECLARE_TLV_DB_SCALE(es8375_adc_osr_gain_tlv, -3100, 100, 0);
+static const DECLARE_TLV_DB_SCALE(es8375_adc_volume_tlv, -9550, 50, 0);
+static const DECLARE_TLV_DB_SCALE(es8375_adc_automute_attn_tlv, 0, 100, 0);
+static const DECLARE_TLV_DB_SCALE(es8375_adc_dmic_volume_tlv, 0, 600, 0);
+static const DECLARE_TLV_DB_SCALE(es8375_dac_volume_tlv, -9550, 50, 0);
+static const DECLARE_TLV_DB_SCALE(es8375_dac_vppscale_tlv, -388, 12, 0);
+static const DECLARE_TLV_DB_SCALE(es8375_dac_automute_attn_tlv, 0, 400, 0);
+static const DECLARE_TLV_DB_SCALE(es8375_automute_ng_tlv, -9600, 600, 0);
+
+static const char *const es8375_ramprate_txt[] = {
+	"0.125dB/LRCK",
+	"0.125dB/2LRCK",
+	"0.125dB/4LRCK",
+	"0.125dB/8LRCK",
+	"0.125dB/16LRCK",
+	"0.125dB/32LRCK",
+	"0.125dB/64LRCK",
+	"0.125dB/128LRCK",
+	"disable softramp",
+};
+static SOC_ENUM_SINGLE_DECL(es8375_adc_ramprate, ES8375_ADC2,
+		ADC_RAMPRATE_SHIFT_0, es8375_ramprate_txt);
+static SOC_ENUM_SINGLE_DECL(es8375_dac_ramprate, ES8375_DAC2,
+		DAC_RAMPRATE_SHIFT_0, es8375_ramprate_txt);
+
+static const char *const es8375_automute_ws_txt[] = {
+	"256 samples",
+	"512 samples",
+	"1024 samples",
+	"2048 samples",
+	"4096 samples",
+	"8192 samples",
+	"16384 samples",
+	"32768 samples",
+};
+static SOC_ENUM_SINGLE_DECL(es8375_adc_automute_ws, ES8375_ADC_AUTOMUTE,
+		ADC_AUTOMUTE_WS_SHIFT_3, es8375_automute_ws_txt);
+static SOC_ENUM_SINGLE_DECL(es8375_dac_automute_ws, ES8375_DAC_AUTOMUTE,
+		DAC_AUTOMUTE_WS_SHIFT_5, es8375_automute_ws_txt);
+
+static const char *const es8375_dmic_pol_txt[] = {
+	"Low",
+	"High",
+};
+
+static SOC_ENUM_SINGLE_DECL(es8375_dmic_pol, ES8375_ADC1,
+		DMIC_POL_SHIFT_4, es8375_dmic_pol_txt);
+
+static const char *const es8375_adc_hpf_txt[] = {
+	"Freeze Offset",
+	"Dynamic HPF",
+};
+
+static SOC_ENUM_SINGLE_DECL(es8375_adc_hpf, ES8375_HPF1,
+		ADC_HPF_SHIFT_5, es8375_adc_hpf_txt);
+
+static const char *const es8375_dmic_mux_txt[] = {
+	"AMIC",
+	"DMIC",
+};
+static const struct soc_enum es8375_dmic_mux_enum =
+	SOC_ENUM_SINGLE(ES8375_ADC1, ADC_SRC_SHIFT_7,
+			ARRAY_SIZE(es8375_dmic_mux_txt), es8375_dmic_mux_txt);
+
+static const struct snd_kcontrol_new es8375_dmic_mux_controls =
+	SOC_DAPM_ENUM("ADC MUX", es8375_dmic_mux_enum);
+
+static const struct snd_kcontrol_new es8375_snd_controls[] = {
+	SOC_SINGLE_TLV("ADC OSR GAIN Volume", ES8375_ADC_OSR_GAIN,
+			ADC_OSR_GAIN_SHIFT_0, ES8375_ADC_OSR_GAIN_MAX, 0,
+			es8375_adc_osr_gain_tlv),
+	SOC_SINGLE("ADC Invert Switch", ES8375_ADC1, ADC_INV_SHIFT_6, 1, 0),
+	SOC_SINGLE("ADC RAM Clear", ES8375_ADC1, ADC_RAMCLR_SHIFT_5, 1, 0),
+	SOC_ENUM("DMIC Polarity", es8375_dmic_pol),
+	SOC_SINGLE_TLV("DMIC Gain Volume", ES8375_ADC1,
+		DMIC_GAIN_SHIFT_2, ES8375_DMIC_GAIN_MAX,
+		0, es8375_adc_dmic_volume_tlv),
+	SOC_ENUM("ADC Ramp Rate", es8375_adc_ramprate),
+	SOC_SINGLE_TLV("ADC Volume", ES8375_ADC_VOLUME,
+			ADC_VOLUME_SHIFT_0, ES8375_ADC_VOLUME_MAX,
+			0, es8375_adc_volume_tlv),
+	SOC_SINGLE("ADC Automute Enable", ES8375_ADC_AUTOMUTE,
+			ADC_AUTOMUTE_SHIFT_7, 1, 0),
+	SOC_ENUM("ADC Automute Winsize", es8375_adc_automute_ws),
+	SOC_SINGLE_TLV("ADC Automute Noise Gate", ES8375_ADC_AUTOMUTE,
+		ADC_AUTOMUTE_NG_SHIFT_0, ES8375_AUTOMUTE_NG_MAX,
+		0, es8375_automute_ng_tlv),
+	SOC_SINGLE_TLV("ADC Automute Attenuation", ES8375_ADC_AUTOMUTE_ATTN,
+			ADC_AUTOMUTE_ATTN_SHIFT_0, ES8375_ADC_AUTOMUTE_ATTN_MAX,
+			0, es8375_adc_automute_attn_tlv),
+	SOC_ENUM("ADC HPF", es8375_adc_hpf),
+
+	SOC_SINGLE("DAC DSM Mute", ES8375_DAC1, DAC_DSMMUTE_SHIFT_7, 1, 0),
+	SOC_SINGLE("DAC DEM Mute", ES8375_DAC1, DAC_DEMMUTE_SHIFT_6, 1, 0),
+	SOC_SINGLE("DAC Invert Switch", ES8375_DAC1, DAC_INV_SHIFT_5, 1, 0),
+	SOC_SINGLE("DAC RAM Clear", ES8375_DAC1, DAC_RAMCLR_SHIFT_4, 1, 0),
+	SOC_ENUM("DAC Ramp Rate", es8375_dac_ramprate),
+	SOC_SINGLE_TLV("DAC Volume", ES8375_DAC_VOLUME,
+			DAC_VOLUME_SHIFT_0, ES8375_DAC_VOLUME_MAX,
+			0, es8375_dac_volume_tlv),
+	SOC_SINGLE_TLV("DAC VPP Scale", ES8375_DAC_VPPSCALE,
+			DAC_VPPSCALE_SHIFT_0, ES8375_DAC_VPPSCALE_MAX,
+			0, es8375_dac_vppscale_tlv),
+	SOC_SINGLE("DAC Automute Enable", ES8375_DAC_AUTOMUTE1,
+			DAC_AUTOMUTE_EN_SHIFT_7, 1, 0),
+	SOC_SINGLE_TLV("DAC Automute Noise Gate", ES8375_DAC_AUTOMUTE1,
+		DAC_AUTOMUTE_NG_SHIFT_0, ES8375_AUTOMUTE_NG_MAX,
+		0, es8375_automute_ng_tlv),
+	SOC_ENUM("DAC Automute Winsize", es8375_dac_automute_ws),
+	SOC_SINGLE_TLV("DAC Automute Attenuation", ES8375_DAC_AUTOMUTE,
+			DAC_AUTOMUTE_ATTN_SHIFT_0, ES8375_DAC_AUTOMUTE_ATTN_MAX,
+			0, es8375_dac_automute_attn_tlv),
+};
+
+static const struct snd_soc_dapm_widget es8375_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("MIC1"),
+	SND_SOC_DAPM_INPUT("DMIC"),
+	SND_SOC_DAPM_PGA("PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_ADC("Mono ADC", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, ES8375_SDP2,
+			ES8375_ADC_P2S_MUTE_SHIFT_5, 1),
+
+	SND_SOC_DAPM_MUX("ADC MUX", SND_SOC_NOPM, 0, 0, &es8375_dmic_mux_controls),
+
+	SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, ES8375_SDP,
+		SND_SOC_NOPM, 0),
+	SND_SOC_DAPM_DAC("Mono DAC", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("OUT"),
+};
+
+static const struct snd_soc_dapm_route es8375_dapm_routes[] = {
+	{"ADC MUX", "AMIC", "MIC1"},
+	{"ADC MUX", "DMIC", "DMIC"},
+	{"PGA", NULL, "ADC MUX"},
+	{"Mono ADC", NULL, "PGA"},
+	{"AIF1TX", NULL, "Mono ADC"},
+
+	{"Mono DAC", NULL, "AIF1RX"},
+	{"OUT", NULL, "Mono DAC"},
+};
+
+struct _coeff_div {
+	u16 mclk_lrck_ratio;
+	u32 mclk;
+	u32 rate;
+	u8 Reg0x04;
+	u8 Reg0x05;
+	u8 Reg0x06;
+	u8 Reg0x07;
+	u8 Reg0x08;
+	u8 Reg0x09;
+	u8 Reg0x0A;
+	u8 Reg0x0B;
+	u8 Reg0x19;
+	u8 dvdd_vol;
+	u8 dmic_sel;
+};
+
+static const struct _coeff_div coeff_div[] = {
+	{32, 256000, 8000, 0x05, 0x34, 0xDD, 0x55, 0x1F, 0x00, 0x95, 0x00, 0x1F, 2, 2},
+	{32, 512000, 16000, 0x05, 0x34, 0xDD, 0x55, 0x1F, 0x00, 0x94, 0x00, 0x1F, 2, 2},
+	{32, 1536000, 48000, 0x05, 0x33, 0xD5, 0x55, 0x1F, 0x00, 0x93, 0x00, 0x1F, 2, 2},
+	{36, 288000, 8000, 0x05, 0x34, 0xDD, 0x55, 0x23, 0x08, 0x95, 0x00, 0x1F, 2, 2},
+	{36, 576000, 16000, 0x05, 0x34, 0xDD, 0x55, 0x23, 0x08, 0x94, 0x00, 0x1F, 2, 2},
+	{36, 1728000, 48000, 0x05, 0x33, 0xD5, 0x55, 0x23, 0x08, 0x93, 0x00, 0x1F, 2, 2},
+	{48, 384000, 8000, 0x05, 0x14, 0x5D, 0x55, 0x17, 0x20, 0x94, 0x00, 0x28, 2, 2},
+	{48, 768000, 16000, 0x05, 0x14, 0x5D, 0x55, 0x17, 0x20, 0x94, 0x00, 0x28, 2, 2},
+	{48, 2304000, 48000, 0x05, 0x11, 0x53, 0x55, 0x17, 0x20, 0x92, 0x00, 0x28, 2, 2},
+	{50, 400000, 8000, 0x05, 0x14, 0x5D, 0x55, 0x18, 0x24, 0x94, 0x00, 0x27, 2, 2},
+	{50, 800000, 16000, 0x05, 0x14, 0x5D, 0x55, 0x18, 0x24, 0x94, 0x00, 0x27, 2, 2},
+	{50, 2400000, 48000, 0x05, 0x11, 0x53, 0x55, 0x18, 0x24, 0x92, 0x00, 0x27, 2, 2},
+	{64, 512000, 8000, 0x05, 0x14, 0x5D, 0x33, 0x1F, 0x00, 0x94, 0x00, 0x1F, 2, 2},
+	{64, 1024000, 16000, 0x05, 0x13, 0x55, 0x33, 0x1F, 0x00, 0x93, 0x00, 0x1F, 2, 2},
+	{64, 3072000, 48000, 0x05, 0x11, 0x53, 0x33, 0x1F, 0x00, 0x92, 0x00, 0x1F, 2, 2},
+	{72, 576000, 8000, 0x05, 0x14, 0x5D, 0x33, 0x23, 0x08, 0x94, 0x00, 0x1F, 2, 2},
+	{72, 1152000, 16000, 0x05, 0x13, 0x55, 0x33, 0x23, 0x08, 0x93, 0x00, 0x1F, 2, 2},
+	{72, 3456000, 48000, 0x05, 0x11, 0x53, 0x33, 0x23, 0x08, 0x92, 0x00, 0x1F, 2, 2},
+	{96, 768000, 8000, 0x15, 0x34, 0xDD, 0x55, 0x1F, 0x00, 0x94, 0x00, 0x1F, 2, 2},
+	{96, 1536000, 16000, 0x15, 0x34, 0xDD, 0x55, 0x1F, 0x00, 0x93, 0x00, 0x1F, 2, 2},
+	{96, 4608000, 48000, 0x15, 0x33, 0xD5, 0x55, 0x1F, 0x00, 0x92, 0x00, 0x1F, 2, 2},
+	{100, 800000, 8000, 0x05, 0x03, 0x35, 0x33, 0x18, 0x24, 0x94, 0x00, 0x27, 2, 2},
+	{100, 1600000, 16000, 0x05, 0x03, 0x35, 0x33, 0x18, 0x24, 0x93, 0x00, 0x27, 2, 2},
+	{100, 4800000, 48000, 0x03, 0x00, 0x31, 0x33, 0x18, 0x24, 0x92, 0x00, 0x27, 2, 2},
+	{128, 1024000, 8000, 0x05, 0x03, 0x35, 0x11, 0x1F, 0x00, 0x93, 0x01, 0x1F, 2, 2},
+	{128, 2048000, 16000, 0x03, 0x01, 0x33, 0x11, 0x1F, 0x00, 0x92, 0x01, 0x1F, 2, 2},
+	{128, 6144000, 48000, 0x03, 0x00, 0x31, 0x11, 0x1F, 0x00, 0x92, 0x01, 0x1F, 2, 2},
+	{144, 1152000, 8000, 0x05, 0x03, 0x35, 0x11, 0x23, 0x08, 0x93, 0x01, 0x1F, 2, 2},
+	{144, 2304000, 16000, 0x03, 0x01, 0x33, 0x11, 0x23, 0x08, 0x92, 0x01, 0x1F, 2, 2},
+	{144, 6912000, 48000, 0x03, 0x00, 0x31, 0x11, 0x23, 0x08, 0x92, 0x01, 0x1F, 2, 2},
+	{192, 1536000, 8000, 0x15, 0x14, 0x5D, 0x33, 0x1F, 0x00, 0x93, 0x02, 0x1F, 2, 2},
+	{192, 3072000, 16000, 0x15, 0x13, 0x55, 0x33, 0x1F, 0x00, 0x92, 0x02, 0x1F, 2, 2},
+	{192, 9216000, 48000, 0x15, 0x11, 0x53, 0x33, 0x1F, 0x00, 0x92, 0x02, 0x1F, 2, 2},
+	{250, 12000000, 48000, 0x25, 0x11, 0x53, 0x55, 0x18, 0x24, 0x92, 0x04, 0x27, 2, 2},
+	{256, 2048000, 8000, 0x0D, 0x03, 0x35, 0x11, 0x1F, 0x00, 0x92, 0x03, 0x1F, 2, 2},
+	{256, 4096000, 16000, 0x0B, 0x01, 0x33, 0x11, 0x1F, 0x00, 0x92, 0x03, 0x1F, 2, 2},
+	{256, 12288000, 48000, 0x0B, 0x00, 0x31, 0x11, 0x1F, 0x00, 0x92, 0x03, 0x1F, 2, 2},
+	{384, 3072000, 8000, 0x15, 0x03, 0x35, 0x11, 0x1F, 0x00, 0x92, 0x05, 0x1F, 2, 2},
+	{384, 6144000, 16000, 0x13, 0x01, 0x33, 0x11, 0x1F, 0x00, 0x92, 0x05, 0x1F, 2, 2},
+	{384, 18432000, 48000, 0x13, 0x00, 0x31, 0x11, 0x1F, 0x00, 0x92, 0x05, 0x1F, 2, 2},
+	{400, 19200000, 48000, 0x1B, 0x00, 0x31, 0x33, 0x18, 0x24, 0x92, 0x04, 0x27, 2, 2},
+	{500, 24000000, 48000, 0x23, 0x00, 0x31, 0x33, 0x18, 0x24, 0x92, 0x04, 0x27, 2, 2},
+	{512, 4096000, 8000, 0x1D, 0x03, 0x35, 0x11, 0x1F, 0x00, 0x92, 0x07, 0x1F, 2, 2},
+	{512, 8192000, 16000, 0x1B, 0x01, 0x33, 0x11, 0x1F, 0x00, 0x92, 0x07, 0x1F, 2, 2},
+	{512, 24576000, 48000, 0x1B, 0x00, 0x31, 0x11, 0x1F, 0x00, 0x92, 0x07, 0x1F, 2, 2},
+	{768, 6144000, 8000, 0x2D, 0x03, 0x35, 0x11, 0x1F, 0x00, 0x92, 0x0B, 0x1F, 2, 2},
+	{768, 12288000, 16000, 0x2B, 0x01, 0x33, 0x11, 0x1F, 0x00, 0x92, 0x0B, 0x1F, 2, 2},
+	{1024, 8192000, 8000, 0x3D, 0x03, 0x35, 0x11, 0x1F, 0x00, 0x92, 0x0F, 0x1F, 2, 2},
+	{1024, 16384000, 16000, 0x3B, 0x01, 0x33, 0x11, 0x1F, 0x00, 0x92, 0x0F, 0x1F, 2, 2},
+	{1152, 9216000, 8000, 0x45, 0x03, 0x35, 0x11, 0x1F, 0x00, 0x92, 0x0F, 0x1F, 2, 2},
+	{1152, 18432000, 16000, 0x43, 0x01, 0x33, 0x11, 0x1F, 0x00, 0x92, 0x0F, 0x1F, 2, 2},
+	{1200, 9600000, 8000, 0x5D, 0x03, 0x35, 0x33, 0x18, 0x24, 0x92, 0x11, 0x27, 2, 2},
+	{1200, 19200000, 16000, 0x5D, 0x03, 0x35, 0x33, 0x18, 0x24, 0x92, 0x11, 0x27, 2, 2},
+	{1536, 12288000, 8000, 0x5D, 0x03, 0x35, 0x11, 0x1F, 0x00, 0x92, 0x17, 0x1F, 2, 2},
+	{1536, 24576000, 16000, 0x5B, 0x01, 0x33, 0x11, 0x1F, 0x00, 0x92, 0x17, 0x1F, 2, 2},
+	{2048, 16384000, 8000, 0x7D, 0x03, 0x35, 0x11, 0x1F, 0x00, 0x92, 0x1F, 0x1F, 2, 2},
+	{2304, 18432000, 8000, 0x8D, 0x03, 0x35, 0x11, 0x1F, 0x00, 0x92, 0x23, 0x1F, 2, 2},
+	{2400, 19200000, 8000, 0xBD, 0x03, 0x35, 0x33, 0x18, 0x24, 0x92, 0x25, 0x27, 2, 2},
+	{3072, 24576000, 8000, 0xBD, 0x03, 0x35, 0x11, 0x1F, 0x00, 0x92, 0x2F, 0x1F, 2, 2},
+	{32, 3072000, 96000, 0x05, 0x11, 0x53, 0x55, 0x0F, 0x00, 0x92, 0x00, 0x37, 2, 2},
+	{64, 6144000, 96000, 0x03, 0x00, 0x31, 0x33, 0x0F, 0x00, 0x92, 0x00, 0x37, 2, 2},
+	{96, 9216000, 96000, 0x15, 0x11, 0x53, 0x55, 0x0F, 0x00, 0x92, 0x00, 0x37, 2, 2},
+	{128, 12288000, 96000, 0x0B, 0x00, 0x31, 0x33, 0x0F, 0x00, 0x92, 0x01, 0x37, 2, 2},
+};
+
+static inline int get_coeff(u8 vddd, u8 dmic, int mclk, int rate)
+{
+	int i;
+	u8 dmic_det, vddd_det;
+
+	for (i = 0; i < ARRAY_SIZE(coeff_div); i++) {
+		if (coeff_div[i].rate == rate && coeff_div[i].mclk == mclk) {
+			vddd_det = ~(coeff_div[i].dvdd_vol ^ vddd) & 0x01;
+			dmic_det = ~(coeff_div[i].dmic_sel ^ dmic) & 0x01;
+			vddd_det |= ~(coeff_div[i].dvdd_vol % 2) & 0x01;
+			dmic_det |= ~(coeff_div[i].dmic_sel % 2) & 0x01;
+
+			if (vddd_det && dmic_det)
+				return i;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int es8375_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct es8375_priv *es8375 = snd_soc_component_get_drvdata(component);
+	int par_width = params_width(params);
+	u8 dmic_enable, iface = 0;
+	unsigned int regv;
+	int coeff, ret;
+
+	if (es8375->mclk_src == ES8375_BCLK_PIN) {
+		if (es8375->mastermode) {
+			dev_err(component->dev, "no mclk, cannot as master\n");
+			return -EINVAL;
+		}
+		regmap_update_bits(es8375->regmap,
+				ES8375_MCLK_SEL, 0x80, 0x80);
+
+		es8375->mclk_freq = 2 * (unsigned int)par_width * params_rate(params);
+	}
+
+	regmap_read(es8375->regmap, ES8375_ADC1, &regv);
+	dmic_enable = regv >> 7 & 0x01;
+
+	ret = regulator_get_voltage(es8375->core_supply[ES8375_SUPPLY_VD].consumer);
+	switch (ret) {
+	case 1800000 ... 2000000:
+		es8375->vddd = ES8375_1V8;
+		break;
+	case 2500000 ... 3300000:
+		es8375->vddd = ES8375_3V3;
+		break;
+	default:
+		es8375->vddd = ES8375_3V3;
+		break;
+	}
+
+	coeff = get_coeff(es8375->vddd, dmic_enable, es8375->mclk_freq, params_rate(params));
+	if (coeff < 0) {
+		dev_warn(component->dev, "Clock coefficients do not match");
+	}
+	regmap_write(es8375->regmap, ES8375_CLK_MGR4,
+			coeff_div[coeff].Reg0x04);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR5,
+			coeff_div[coeff].Reg0x05);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR6,
+			coeff_div[coeff].Reg0x06);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR7,
+			coeff_div[coeff].Reg0x07);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR8,
+			coeff_div[coeff].Reg0x08);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR9,
+			coeff_div[coeff].Reg0x09);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR10,
+			coeff_div[coeff].Reg0x0A);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR11,
+			coeff_div[coeff].Reg0x0B);
+	regmap_write(es8375->regmap, ES8375_ADC_OSR_GAIN,
+			coeff_div[coeff].Reg0x19);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		iface |= 0x0c;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		iface |= 0x04;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		iface |= 0x10;
+		break;
+	}
+
+	regmap_update_bits(es8375->regmap, ES8375_SDP, 0x1c, iface);
+
+	return 0;
+}
+
+static int es8375_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+		unsigned int freq, int dir)
+{
+	struct snd_soc_component *component = dai->component;
+	struct es8375_priv *es8375 = snd_soc_component_get_drvdata(component);
+
+	es8375->mclk_freq = freq;
+
+	return 0;
+}
+
+static int es8375_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *component = dai->component;
+	struct es8375_priv *es8375 = snd_soc_component_get_drvdata(component);
+	unsigned int iface, codeciface;
+
+	regmap_read(es8375->regmap, ES8375_SDP, &codeciface);
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBC_CFP:
+		es8375->mastermode = 1;
+		regmap_update_bits(es8375->regmap, ES8375_RESET1,
+				0x80, 0x80);
+		break;
+	case SND_SOC_DAIFMT_CBC_CFC:
+		es8375->mastermode = 0;
+		regmap_update_bits(es8375->regmap, ES8375_RESET1,
+				0x80, 0x00);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		codeciface &= 0xFC;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		return -EINVAL;
+	case SND_SOC_DAIFMT_LEFT_J:
+		codeciface &= 0xFC;
+		codeciface |= 0x01;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		codeciface &= 0xDC;
+		codeciface |= 0x03;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		codeciface &= 0xDC;
+		codeciface |= 0x23;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_read(es8375->regmap, ES8375_CLK_MGR3, &iface);
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		iface      &= 0xFE;
+		codeciface &= 0xDF;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		iface      |= 0x01;
+		codeciface |= 0x20;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		iface      |= 0x01;
+		codeciface &= 0xDF;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		iface      &= 0xFE;
+		codeciface |= 0x20;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_write(es8375->regmap, ES8375_CLK_MGR3, iface);
+	regmap_write(es8375->regmap, ES8375_SDP, codeciface);
+
+	return 0;
+}
+
+static int es8375_set_bias_level(struct snd_soc_component *component,
+		enum snd_soc_bias_level level)
+{
+	struct es8375_priv *es8375 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		ret = clk_prepare_enable(es8375->mclk);
+		if (ret) {
+			dev_err(component->dev, "unable to prepare mclk\n");
+			return  ret;
+		}
+		regmap_write(es8375->regmap, ES8375_CSM1, 0xA6);
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		regmap_write(es8375->regmap, ES8375_CSM1, 0x96);
+		clk_disable_unprepare(es8375->mclk);
+		break;
+	case SND_SOC_BIAS_OFF:
+		break;
+	}
+	return 0;
+}
+
+static int es8375_mute(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct snd_soc_component *component = dai->component;
+	struct es8375_priv *es8375 = snd_soc_component_get_drvdata(component);
+
+	if (mute) {
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			regmap_update_bits(es8375->regmap, ES8375_SDP, 0x40, 0x40);
+		else
+			regmap_update_bits(es8375->regmap, ES8375_SDP2, 0x20, 0x20);
+	} else {
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			regmap_update_bits(es8375->regmap, ES8375_SDP, 0x40, 0x00);
+		else
+			regmap_update_bits(es8375->regmap, ES8375_SDP2, 0x20, 0x00);
+	}
+
+	return 0;
+}
+
+#define es8375_RATES SNDRV_PCM_RATE_8000_96000
+
+#define es8375_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
+		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static const struct snd_soc_dai_ops es8375_ops = {
+	.hw_params = es8375_hw_params,
+	.mute_stream = es8375_mute,
+	.set_sysclk = es8375_set_sysclk,
+	.set_fmt = es8375_set_dai_fmt,
+};
+
+static struct snd_soc_dai_driver es8375_dai = {
+	.name = "ES8375 HiFi",
+	.playback = {
+		.stream_name = "AIF1 Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = es8375_RATES,
+		.formats = es8375_FORMATS,
+	},
+	.capture = {
+		.stream_name = "AIF1 Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = es8375_RATES,
+		.formats = es8375_FORMATS,
+	},
+	.ops = &es8375_ops,
+	.symmetric_rate = 1,
+};
+
+static void es8375_init(struct snd_soc_component *component)
+{
+	struct es8375_priv *es8375 = snd_soc_component_get_drvdata(component);
+
+	regmap_write(es8375->regmap, ES8375_CLK_MGR10, 0x95);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR3, 0x48);
+	regmap_write(es8375->regmap, ES8375_DIV_SPKCLK, 0x18);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR4, 0x02);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR5, 0x05);
+	regmap_write(es8375->regmap, ES8375_CSM1, 0x82);
+	regmap_write(es8375->regmap, ES8375_VMID_CHARGE2, 0x20);
+	regmap_write(es8375->regmap, ES8375_VMID_CHARGE3, 0x20);
+	regmap_write(es8375->regmap, ES8375_DAC_CAL, 0x28);
+	regmap_write(es8375->regmap, ES8375_ANALOG_SPK1, 0xFC);
+	regmap_write(es8375->regmap, ES8375_ANALOG_SPK2, 0xE0);
+	regmap_write(es8375->regmap, ES8375_VMID_SEL, 0xFE);
+	regmap_write(es8375->regmap, ES8375_ANALOG1, 0xB8);
+	regmap_write(es8375->regmap, ES8375_SYS_CTRL2, 0x03);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR2, 0x16);
+	regmap_write(es8375->regmap, ES8375_RESET1, 0x00);
+	msleep(80);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR3, 0x00);
+	regmap_write(es8375->regmap, ES8375_CSM1, 0x86);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR4, 0x0B);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR5, 0x00);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR6, 0x31);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR7, 0x11);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR8, 0x1F);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR9, 0x00);
+	regmap_write(es8375->regmap, ES8375_ADC_OSR_GAIN, 0x1F);
+	regmap_write(es8375->regmap, ES8375_ADC2, 0x00);
+	regmap_write(es8375->regmap, ES8375_DAC2, 0x00);
+	regmap_write(es8375->regmap, ES8375_DAC_OTP, 0x88);
+	regmap_write(es8375->regmap, ES8375_ANALOG_SPK2, 0xE7);
+	regmap_write(es8375->regmap, ES8375_ANALOG2, 0xF0);
+	regmap_write(es8375->regmap, ES8375_ANALOG3, 0x40);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR2, 0xFE);
+
+	regmap_update_bits(es8375->regmap, ES8375_SDP, 0x40, 0x40);
+	regmap_update_bits(es8375->regmap, ES8375_SDP2, 0x20, 0x20);
+}
+
+static int es8375_suspend(struct snd_soc_component *component)
+{
+	struct es8375_priv *es8375 = snd_soc_component_get_drvdata(component);
+
+	regmap_write(es8375->regmap, ES8375_CSM1, 0x96);
+	regcache_cache_only(es8375->regmap, true);
+	regcache_mark_dirty(es8375->regmap);
+	return 0;
+}
+
+static int es8375_resume(struct snd_soc_component *component)
+{
+	struct es8375_priv *es8375 = snd_soc_component_get_drvdata(component);
+	unsigned int reg;
+
+	regcache_cache_only(es8375->regmap, false);
+	regcache_cache_bypass(es8375->regmap, true);
+	regmap_read(es8375->regmap, ES8375_CLK_MGR2, &reg);
+	regcache_cache_bypass(es8375->regmap, false);
+
+	if (reg == 0x00)
+		es8375_init(component);
+	else
+		es8375_set_bias_level(component, SND_SOC_BIAS_ON);
+
+	regcache_sync(es8375->regmap);
+
+	return 0;
+}
+
+static int es8375_codec_probe(struct snd_soc_component *component)
+{
+	struct es8375_priv *es8375 = snd_soc_component_get_drvdata(component);
+
+	es8375->mastermode = 0;
+
+	es8375_init(component);
+
+	return 0;
+}
+
+static bool es8375_writeable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ES8375_CHIP_VERSION:
+	case ES8375_CHIP_ID0:
+	case ES8375_CHIP_ID1:
+	case ES8375_SPK_OFFSET:
+	case ES8375_FLAGS2:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static struct regmap_config es8375_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = ES8375_REG_MAX,
+	.cache_type = REGCACHE_MAPLE,
+	.use_single_read = true,
+	.use_single_write = true,
+	.writeable_reg = es8375_writeable_register,
+};
+
+static struct snd_soc_component_driver es8375_codec_driver = {
+	.probe = es8375_codec_probe,
+	.suspend = es8375_suspend,
+	.resume = es8375_resume,
+	.set_bias_level = es8375_set_bias_level,
+	.controls = es8375_snd_controls,
+	.num_controls = ARRAY_SIZE(es8375_snd_controls),
+	.dapm_widgets = es8375_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(es8375_dapm_widgets),
+	.dapm_routes = es8375_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(es8375_dapm_routes),
+
+	.idle_bias_on = 1,
+	.suspend_bias_off = 1,
+};
+
+static int es8375_read_device_properities(struct device *dev, struct es8375_priv *es8375)
+{
+	int ret, i;
+
+	ret = device_property_read_u8(dev, "everest,mclk-src", &es8375->mclk_src);
+	if (ret != 0)
+		es8375->mclk_src = ES8375_MCLK_SOURCE;
+	dev_dbg(dev, "mclk-src %x", es8375->mclk_src);
+
+	for (i = 0; i < ARRAY_SIZE(es8375_core_supplies); i++)
+		es8375->core_supply[i].supply = es8375_core_supplies[i];
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(es8375_core_supplies), es8375->core_supply);
+	if (ret) {
+		dev_err(dev, "Failed to request core supplies %d\n", ret);
+		return ret;
+	}
+
+	es8375->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(es8375->mclk))
+		return dev_err_probe(dev, PTR_ERR(es8375->mclk), "unable to get mclk\n");
+
+	if (!es8375->mclk)
+		dev_warn(dev, "assuming static mclk\n");
+
+	ret = clk_prepare_enable(es8375->mclk);
+	if (ret) {
+		dev_err(dev, "unable to enable mclk\n");
+		return ret;
+	}
+	ret = regulator_bulk_enable(ARRAY_SIZE(es8375_core_supplies), es8375->core_supply);
+	if (ret) {
+		dev_err(dev, "Failed to enable core supplies: %d\n", ret);
+		clk_disable_unprepare(es8375->mclk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int es8375_i2c_probe(struct i2c_client *i2c_client)
+{
+	struct es8375_priv *es8375;
+	struct device *dev = &i2c_client->dev;
+	int ret;
+	unsigned int val;
+
+	es8375 = devm_kzalloc(&i2c_client->dev, sizeof(*es8375), GFP_KERNEL);
+	if (!es8375)
+		return -ENOMEM;
+
+	es8375->regmap = devm_regmap_init_i2c(i2c_client,
+			&es8375_regmap_config);
+	if (IS_ERR(es8375->regmap))
+		return dev_err_probe(&i2c_client->dev, PTR_ERR(es8375->regmap),
+			"regmap_init() failed\n");
+
+	i2c_set_clientdata(i2c_client, es8375);
+
+	ret = regmap_read(es8375->regmap, ES8375_CHIP_ID1, &val);
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "failed to read i2c at addr %X\n",
+				i2c_client->addr);
+		return ret;
+	}
+
+	if (val != 0x83) {
+		dev_err(&i2c_client->dev, "device at addr %X is not an es8375\n",
+				i2c_client->addr);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(es8375->regmap, ES8375_CHIP_ID0, &val);
+	if (val != 0x75) {
+		dev_err(&i2c_client->dev, "device at addr %X is not an es8375\n",
+				i2c_client->addr);
+		return -ENODEV;
+	}
+
+	ret = es8375_read_device_properities(dev, es8375);
+	if (ret != 0) {
+		dev_err(&i2c_client->dev, "get an error from dts info %X\n", ret);
+		return ret;
+	}
+
+	return devm_snd_soc_register_component(&i2c_client->dev, &es8375_codec_driver,
+			&es8375_dai, 1);
+}
+
+static void es8375_i2c_shutdown(struct i2c_client *i2c)
+{
+	struct es8375_priv *es8375;
+
+	es8375 = i2c_get_clientdata(i2c);
+
+	regmap_write(es8375->regmap, ES8375_CSM1, 0x3C);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR3, 0x48);
+	regmap_write(es8375->regmap, ES8375_CSM2, 0x80);
+	regmap_write(es8375->regmap, ES8375_CSM1, 0x3E);
+	regmap_write(es8375->regmap, ES8375_CLK_MGR10, 0x15);
+	regmap_write(es8375->regmap, ES8375_SYS_CTRL2, 0x0C);
+	regmap_write(es8375->regmap, ES8375_RESET1, 0x00);
+	regmap_write(es8375->regmap, ES8375_CSM2, 0x00);
+
+	regulator_bulk_disable(ARRAY_SIZE(es8375_core_supplies), es8375->core_supply);
+	clk_disable_unprepare(es8375->mclk);
+}
+
+static const struct i2c_device_id es8375_id[] = {
+	{"es8375"},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, es8375_id);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id es8375_acpi_match[] = {
+	{"ESSX8375", 0},
+	{},
+};
+
+MODULE_DEVICE_TABLE(acpi, es8375_acpi_match);
+#endif
+
+#ifdef CONFIG_OF
+static const struct of_device_id es8375_of_match[] = {
+	{.compatible = "everest,es8375",},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, es8375_of_match);
+#endif
+
+static struct i2c_driver es8375_i2c_driver = {
+	.driver = {
+		.name	= "es8375",
+		.of_match_table = of_match_ptr(es8375_of_match),
+		.acpi_match_table = ACPI_PTR(es8375_acpi_match),
+	},
+	.shutdown = es8375_i2c_shutdown,
+	.probe = es8375_i2c_probe,
+	.id_table = es8375_id,
+};
+module_i2c_driver(es8375_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC ES8375 driver");
+MODULE_AUTHOR("Michael Zhang <zhangyi@everest-semi.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/es8375.h b/sound/soc/codecs/es8375.h
new file mode 100644
index 000000000000..11e3ceec9b68
--- /dev/null
+++ b/sound/soc/codecs/es8375.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+* ES8375.h  --  ES8375 ALSA SoC Audio Codec
+*
+* Authors:
+*
+* Based on ES8375.h by Michael Zhang
+*/
+#ifndef _ES8375_H
+#define _ES8375_H
+
+// Registors
+#define ES8375_RESET1              0x00
+#define ES8375_MCLK_SEL            0x01
+#define ES8375_CLK_MGR2            0x02
+#define ES8375_CLK_MGR3            0x03
+#define ES8375_CLK_MGR4            0x04
+#define ES8375_CLK_MGR5            0x05
+#define ES8375_CLK_MGR6            0x06
+#define ES8375_CLK_MGR7            0x07
+#define ES8375_CLK_MGR8            0x08
+#define ES8375_CLK_MGR9            0x09
+#define ES8375_CLK_MGR10           0x0A
+#define ES8375_CLK_MGR11           0x0B
+#define ES8375_CLK_MGR12           0x0C
+#define ES8375_DIV_SPKCLK          0x0E
+#define ES8375_CSM1                0x0F
+#define ES8375_CSM2                0x10
+#define ES8375_VMID_CHARGE2        0x11
+#define ES8375_VMID_CHARGE3        0x12
+#define ES8375_SDP                 0x15
+#define ES8375_SDP2                0x16
+#define ES8375_ADC1                0x17
+#define ES8375_ADC2                0x18
+#define ES8375_ADC_OSR_GAIN        0x19
+#define ES8375_ADC_VOLUME          0x1A
+#define ES8375_ADC_AUTOMUTE        0x1B
+#define ES8375_ADC_AUTOMUTE_ATTN   0x1C
+#define ES8375_HPF1                0x1D
+#define ES8375_DAC1                0x1F
+#define ES8375_DAC2                0x20
+#define ES8375_DAC_VOLUME          0x21
+#define ES8375_DAC_VPPSCALE        0x22
+#define ES8375_DAC_AUTOMUTE1       0x23
+#define ES8375_DAC_AUTOMUTE        0x24
+#define ES8375_DAC_CAL             0x25
+#define ES8375_DAC_OTP             0x27
+#define ES8375_ANALOG_SPK1         0x28
+#define ES8375_ANALOG_SPK2         0x29
+#define ES8375_VMID_SEL            0x2D
+#define ES8375_ANALOG1             0x2E
+#define ES8375_ANALOG2             0x32
+#define ES8375_ANALOG3             0x37
+#define ES8375_ADC2DAC_CLKTRI      0xF8
+#define ES8375_SYS_CTRL2           0xF9
+#define ES8375_FLAGS2              0xFB
+#define ES8375_SPK_OFFSET          0xFC
+#define ES8375_CHIP_ID1            0xFD
+#define ES8375_CHIP_ID0            0xFE
+#define ES8375_CHIP_VERSION        0xFF
+
+// Bit Shifts
+#define ADC_OSR_GAIN_SHIFT_0        0
+#define ADC_RAMPRATE_SHIFT_0        0
+#define ADC_VOLUME_SHIFT_0          0
+#define ADC_AUTOMUTE_NG_SHIFT_0     0
+#define ADC_AUTOMUTE_ATTN_SHIFT_0   0
+#define DAC_RAMPRATE_SHIFT_0        0
+#define DAC_VOLUME_SHIFT_0          0
+#define DAC_VPPSCALE_SHIFT_0        0
+#define DAC_AUTOMUTE_NG_SHIFT_0     0
+#define DAC_AUTOMUTE_ATTN_SHIFT_0   0
+#define DMIC_GAIN_SHIFT_2           2
+#define ADC_AUTOMUTE_WS_SHIFT_3     3
+#define DMIC_POL_SHIFT_4            4
+#define DAC_RAMCLR_SHIFT_4          4
+#define ES8375_EN_MODL_SHIFT_4      4
+#define ADC_RAMCLR_SHIFT_5          5
+#define ADC_HPF_SHIFT_5             5
+#define DAC_INV_SHIFT_5             5
+#define DAC_AUTOMUTE_WS_SHIFT_5     5
+#define ES8375_EN_PGAL_SHIFT_5      5
+#define ES8375_ADC_P2S_MUTE_SHIFT_5 5
+#define ADC_INV_SHIFT_6             6
+#define DAC_DEMMUTE_SHIFT_6         6
+#define ES8375_DAC_S2P_MUTE_SHIFT_6 6
+#define ADC_SRC_SHIFT_7             7
+#define ADC_AUTOMUTE_SHIFT_7        7
+#define DAC_DSMMUTE_SHIFT_7         7
+#define DAC_AUTOMUTE_EN_SHIFT_7     7
+
+// Function values
+#define ES8375_ADC_OSR_GAIN_MAX         0x3F
+#define ES8375_DMIC_GAIN_MAX            0x04
+#define ES8375_ADC_AUTOMUTE_ATTN_MAX    0x1F
+#define ES8375_AUTOMUTE_NG_MAX          0x07
+#define ES8375_ADC_VOLUME_MAX           0xFF
+#define ES8375_DAC_VOLUME_MAX           0xFF
+#define ES8375_DAC_VPPSCALE_MAX         0x3F
+#define ES8375_DAC_AUTOMUTE_ATTN_MAX    0x17
+#define ES8375_REG_MAX                  0xFF
+
+enum ES8375_supplies {
+	ES8375_SUPPLY_VD = 0,
+	ES8375_SUPPLY_VA,
+};
+
+// Properties
+#define ES8375_3V3  1
+#define ES8375_1V8  0
+
+#define ES8375_MCLK_PIN	0
+#define ES8375_BCLK_PIN 1
+#define ES8375_MCLK_SOURCE	ES8375_MCLK_PIN
+
+#define DMIC_POSITIVE_EDGE  0
+#define DMIC_NEGATIVE_EDGE  1
+#define DMIC_POL  DMIC_POSITIVE_EDGE
+
+#define PA_SHUTDOWN     0
+#define PA_ENABLE       1
+
+#endif
-- 
2.17.1


