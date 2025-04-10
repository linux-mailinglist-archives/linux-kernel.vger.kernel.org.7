Return-Path: <linux-kernel+bounces-597113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 306EBA8353C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 02:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35E11B664A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 00:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE6E7FBA2;
	Thu, 10 Apr 2025 00:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="JOa14+FK"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA7D132103
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 00:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744246662; cv=none; b=BFBXhch8eT7wCXkyailtIdqEM1vHEntWm4z3RtPPbkDRoouOF2SGcnfImBPhR/l4Bf1kk5pi10mEWwwyKlJveY0kRsEiZV3a/xiHjQinvlWvfCguNS8gGAVWs53FFWweGuVhwvH2Khn4UbjVQsw1ReZv/ufBQSJSdM7ko3N/Qo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744246662; c=relaxed/simple;
	bh=HBKh9LD/EC5SsEvQBYbBhoBm0hFIDpwjp89tb2yRlgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lY9W1HWskqyBVgMFd39Jg1HakdeK1igtrNAvWyDsOHc7xQISZPl0OPiB+eVrXbmCnuPESMHMlcFSlBbBuAaopYpx32nJ2Mwd0NMwFpYr0oclldrlU3ErLFyZkFraMx9BR/0d+sHy4oZedRNeufBKTVaguQIXMVRXkn4TswyYhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=JOa14+FK; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1744246651;
	bh=FlQ5a2nkrUWBkKP45fATstwWTK+WYdI0RNdYUTWULFs=; l=17788;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JOa14+FKVAQayyMW7N/PZjk6dCDG7N1el7Fk80yQs7R24/yq35JP9HxQHXfcpFgpZ
	 MjmR6mRlnfDgqQDngLtTpUWl+OJd/LaBfTUlsI1Ggnakq+OyddObmkoydkotVsadJQ
	 lnCDOG0tVDCKeQJzAEFeCbfuBbwVfXBwNuUrjbcqGKrUOY0uyCi6IdjqPkSIuQ9hyW
	 DFvNA9s62TLehuJcPpwFQZN7dCsS/ZVBSkhnn+cuzaVOhetD72JRQ/n4s7lQm1vdf+
	 1ZjEQt8MNHqsFleQ+oGYV2/lQ8DB5R18qowwRYJehVlJqIDnqR8Rtn0l+9ccRmYNMV
	 cpz8pFVX6Kbrg==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(2132240:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 10 Apr 2025 08:56:57 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Apr
 2025 08:56:56 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Thu, 10 Apr 2025 08:56:56 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, ChiYuan Huang <cy_huang@richtek.com>, Otto lin
	<otto_lin@richtek.com>, Allen Lin <allen_lin@richtek.com>,
	<devicetree@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] ASoC: codecs: Add support for Richtek rt9123
Date: Thu, 10 Apr 2025 08:58:11 +0800
Message-ID: <f467200d7c116f5f34a3c31fafeebd9a410ab8bd.1744245663.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1744245663.git.cy_huang@richtek.com>
References: <cover.1744245663.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

Add codec driver for Richtek rt9123.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
v2
- include bitfield header file to fix kernel test robot issue
  https://lore.kernel.org/oe-kbuild-all/202504052206.HFqFRXUk-lkp@intel.com/
- Use #ifdef CONFIG_PM to only inlucde 'runtime_resume' and
  'runtime_suspend', this will fix kernel test robot issue
  https://lore.kernel.org/oe-kbuild-all/202504052244.bgS5yxev-lkp@intel.com/
- Check vendor-id before triggering SW_RST
- Fix 'SW_RST' write date non swap issue and add the wait delay for sw_reset
- Rename control name from 'SPK Gain Volume' to 'Speaker Volume'
- Change regmap cache type to _MAPLE
- Since ID check run once, to speed up regmap cache init, modify
  num_reg_defaults_raw from 0xf2 'COMBOID' to 0x36 'ANAFLAG'
- Add comments to describe why use pm runtime for RG special handling
---
 sound/soc/codecs/Kconfig  |   9 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/rt9123.c | 503 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 514 insertions(+)
 create mode 100644 sound/soc/codecs/rt9123.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 40bb7a1d44bc..c61b2d3cf284 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -234,6 +234,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_RT1318_SDW
 	imply SND_SOC_RT1320_SDW
 	imply SND_SOC_RT9120
+	imply SND_SOC_RT9123
 	imply SND_SOC_RTQ9128
 	imply SND_SOC_SDW_MOCKUP
 	imply SND_SOC_SGTL5000
@@ -1823,6 +1824,14 @@ config SND_SOC_RT9120
 	  Enable support for Richtek RT9120 20W, stereo, inductor-less,
 	  high-efficiency Class-D audio amplifier.
 
+config SND_SOC_RT9123
+	tristate "Richtek RT9123 Mono Class-D Amplifier"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Enable support for the I2C control mode of Richtek RT9123 3.2W mono
+	  Class-D audio amplifier.
+
 config SND_SOC_RTQ9128
 	tristate "Richtek RTQ9128 45W Digital Input Amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 10f726066b6c..d8d0bc367af8 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -270,6 +270,7 @@ snd-soc-rt715-sdca-y := rt715-sdca.o rt715-sdca-sdw.o
 snd-soc-rt721-sdca-y := rt721-sdca.o rt721-sdca-sdw.o
 snd-soc-rt722-sdca-y := rt722-sdca.o rt722-sdca-sdw.o
 snd-soc-rt9120-y := rt9120.o
+snd-soc-rt9123-y := rt9123.o
 snd-soc-rtq9128-y := rtq9128.o
 snd-soc-sdw-mockup-y := sdw-mockup.o
 snd-soc-sgtl5000-y := sgtl5000.o
@@ -684,6 +685,7 @@ obj-$(CONFIG_SND_SOC_RT715_SDCA_SDW)     += snd-soc-rt715-sdca.o
 obj-$(CONFIG_SND_SOC_RT721_SDCA_SDW)     += snd-soc-rt721-sdca.o
 obj-$(CONFIG_SND_SOC_RT722_SDCA_SDW)     += snd-soc-rt722-sdca.o
 obj-$(CONFIG_SND_SOC_RT9120)	+= snd-soc-rt9120.o
+obj-$(CONFIG_SND_SOC_RT9123)	+= snd-soc-rt9123.o
 obj-$(CONFIG_SND_SOC_RTQ9128)	+= snd-soc-rtq9128.o
 obj-$(CONFIG_SND_SOC_SDW_MOCKUP)     += snd-soc-sdw-mockup.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
diff --git a/sound/soc/codecs/rt9123.c b/sound/soc/codecs/rt9123.c
new file mode 100644
index 000000000000..d9a22fda3d26
--- /dev/null
+++ b/sound/soc/codecs/rt9123.c
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// rt9123.c -- RT9123 (SW I2C Mode) ALSA SoC Codec driver
+//
+// Author: ChiYuan Huang <cy_huang@richtek.com>
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/byteorder/generic.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+
+#define RT9123_REG_AMPCTRL	0x01
+#define RT9123_REG_I2SOPT	0x02
+#define RT9123_REG_TDMRX	0x03
+#define RT9123_REG_SILVOLEN	0x04
+#define RT9123_REG_VOLGAIN	0x12
+#define RT9123_REG_ANAFLAG	0x36
+#define RT9123_REG_COMBOID	0xF7
+
+#define RT9123_MASK_SWRST	BIT(15)
+#define RT9123_MASK_SWMUTE	BIT(14)
+#define RT9123_MASK_AMPON	BIT(12)
+#define RT9123_MASK_AUDBIT	GENMASK(14, 12)
+#define RT9123_MASK_AUDFMT	GENMASK(11, 8)
+#define RT9123_MASK_TDMRXLOC	GENMASK(4, 0)
+#define RT9123_MASK_VENID	GENMASK(15, 4)
+
+#define RT9123_FIXED_VENID	0x340
+
+struct rt9123_priv {
+	struct gpio_desc *enable;
+	unsigned int dai_fmt;
+	int tdm_slots;
+	int tdm_slot_width;
+};
+
+static int rt9123_enable_event(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
+			       int event)
+{
+	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
+	struct device *dev = comp->dev;
+	unsigned int enable;
+	int ret;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		enable = 1;
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		enable = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	/* AMPON bit is located in volatile RG, use pm_runtime to guarantee the RG access */
+	snd_soc_component_write_field(comp, RT9123_REG_AMPCTRL, RT9123_MASK_AMPON, enable);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget rt9123_dapm_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("SPK"),
+	SND_SOC_DAPM_OUT_DRV_E("Amp Drv", SND_SOC_NOPM, 0, 0, NULL, 0, rt9123_enable_event,
+			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route rt9123_dapm_routes[] = {
+	{ "Amp Drv", NULL, "HiFi Playback" },
+	{ "SPK", NULL, "Amp Drv" },
+};
+
+static const DECLARE_TLV_DB_SCALE(dig_tlv, -10375, 25, 0);
+static const DECLARE_TLV_DB_RANGE(ana_tlv,
+				  0, 0, TLV_DB_SCALE_ITEM(-1200, 0, 0),
+				  1, 9, TLV_DB_SCALE_ITEM(0, 150, 0),
+				  10, 10, TLV_DB_SCALE_ITEM(1400, 0, 0));
+static const char * const pwmfreq_text[] = { "300KHz", "325KHz", "350KHz", "375KHz" };
+static const struct soc_enum rt9123_pwm_freq_enum =
+	SOC_ENUM_SINGLE(RT9123_REG_AMPCTRL, 4, ARRAY_SIZE(pwmfreq_text), pwmfreq_text);
+static const char * const i2sch_text[] = { "(L+R)/2", "LCH", "RCH", "(L+R)/2" };
+static const struct soc_enum rt9123_i2sch_select_enum =
+	SOC_ENUM_SINGLE(RT9123_REG_I2SOPT, 4, ARRAY_SIZE(i2sch_text), i2sch_text);
+
+static int rt9123_kcontrol_name_comp(struct snd_kcontrol *kcontrol, const char *s)
+{
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	const char *kctlname = kcontrol->id.name;
+
+	if (comp && comp->name_prefix)
+		kctlname += strlen(comp->name_prefix) + 1;
+
+	return strcmp(kctlname, s);
+}
+
+static int rt9123_xhandler_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct device *dev = comp->dev;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * Since the RG bitfield for 'Speaker Volume' and 'PWM Frequency Select' are located in
+	 * volatile RG address, special handling here with pm runtime API to guarantee RG read
+	 * operation.
+	 */
+	if (rt9123_kcontrol_name_comp(kcontrol, "Speaker Volume") == 0)
+		ret = snd_soc_get_volsw(kcontrol, ucontrol);
+	else
+		ret = snd_soc_get_enum_double(kcontrol, ucontrol);
+
+	if (ret < 0)
+		dev_err(dev, "Failed to get control (%d)\n", ret);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static int rt9123_xhandler_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct device *dev = comp->dev;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * Since the RG bitfield for 'Speaker Volume' and 'PWM Frequency Select' are located in
+	 * volatile RG address, special handling here with pm runtime API to guarantee RG write
+	 * operation.
+	 */
+	if (rt9123_kcontrol_name_comp(kcontrol, "Speaker Volume") == 0)
+		ret = snd_soc_put_volsw(kcontrol, ucontrol);
+	else
+		ret = snd_soc_put_enum_double(kcontrol, ucontrol);
+
+	if (ret < 0)
+		dev_err(dev, "Failed to put control (%d)\n", ret);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static const struct snd_kcontrol_new rt9123_controls[] = {
+	SOC_SINGLE_TLV("Master Volume", RT9123_REG_VOLGAIN, 2, 511, 1, dig_tlv),
+	SOC_SINGLE_EXT_TLV("Speaker Volume", RT9123_REG_AMPCTRL, 0, 10, 0, rt9123_xhandler_get,
+			   rt9123_xhandler_put, ana_tlv),
+	SOC_ENUM_EXT("PWM Frequency Select", rt9123_pwm_freq_enum, rt9123_xhandler_get,
+		     rt9123_xhandler_put),
+	SOC_ENUM("I2S CH Select", rt9123_i2sch_select_enum),
+	SOC_SINGLE("Silence Detect Switch", RT9123_REG_SILVOLEN, 14, 1, 0),
+};
+
+static const struct snd_soc_component_driver rt9123_comp_driver = {
+	.controls		= rt9123_controls,
+	.num_controls		= ARRAY_SIZE(rt9123_controls),
+	.dapm_widgets		= rt9123_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(rt9123_dapm_widgets),
+	.dapm_routes		= rt9123_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(rt9123_dapm_routes),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+};
+
+static int rt9123_dai_set_format(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct rt9123_priv *rt9123 = snd_soc_dai_get_drvdata(dai);
+
+	rt9123->dai_fmt = fmt;
+	return 0;
+}
+
+static int rt9123_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+				   unsigned int rx_mask, int slots, int slot_width)
+{
+	struct rt9123_priv *rt9123 = snd_soc_dai_get_drvdata(dai);
+	struct snd_soc_component *comp = dai->component;
+	struct device *dev = dai->dev;
+	unsigned int rx_loc;
+
+	dev_dbg(dev, "(slots, slot_width) = (%d, %d), (txmask, rxmask) = 0x%x, 0x%x\n", slots,
+		slot_width, tx_mask, rx_mask);
+
+	if (slots <= 0 || slot_width <= 0 || slots % 2 || slot_width % 8 ||
+			slots * slot_width > 256) {
+		dev_err(dev, "Invalid slot parameter (%d, %d)\n", slots, slot_width);
+		return -EINVAL;
+	}
+
+	if (!rx_mask || hweight_long(rx_mask) > 1 || ffs(rx_mask) > slots) {
+		dev_err(dev, "Invalid rx_mask 0x%08x, slots = %d\n", rx_mask, slots);
+		return -EINVAL;
+	}
+
+	/* Configure rx channel data location */
+	rx_loc = (ffs(rx_mask) - 1) * slot_width / 8;
+	snd_soc_component_write_field(comp, RT9123_REG_TDMRX, RT9123_MASK_TDMRXLOC, rx_loc);
+
+	rt9123->tdm_slots = slots;
+	rt9123->tdm_slot_width = slot_width;
+
+	return 0;
+}
+
+static int rt9123_dai_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *param, struct snd_soc_dai *dai)
+{
+	struct rt9123_priv *rt9123 = snd_soc_dai_get_drvdata(dai);
+	struct snd_soc_component *comp = dai->component;
+	unsigned int fmtval, width, slot_width;
+	struct device *dev = dai->dev;
+	unsigned int audfmt, audbit;
+
+	fmtval = FIELD_GET(SND_SOC_DAIFMT_FORMAT_MASK, rt9123->dai_fmt);
+	if (rt9123->tdm_slots && fmtval != SND_SOC_DAIFMT_DSP_A && fmtval != SND_SOC_DAIFMT_DSP_B) {
+		dev_err(dev, "TDM only can support DSP_A or DSP_B format\n");
+		return -EINVAL;
+	}
+
+	switch (fmtval) {
+	case SND_SOC_DAIFMT_I2S:
+		audfmt = 0;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		audfmt = 1;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		audfmt = 2;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		audfmt = rt9123->tdm_slots ? 4 : 3;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		audfmt = rt9123->tdm_slots ? 12 : 11;
+		break;
+	default:
+		dev_err(dev, "Unsupported format %d\n", fmtval);
+		return -EINVAL;
+	}
+
+	switch (width = params_width(param)) {
+	case 16:
+		audbit = 0;
+		break;
+	case 20:
+		audbit = 1;
+		break;
+	case 24:
+		audbit = 2;
+		break;
+	case 32:
+		audbit = 3;
+		break;
+	case 8:
+		audbit = 4;
+		break;
+	default:
+		dev_err(dev, "Unsupported width %d\n", width);
+		return -EINVAL;
+	}
+
+	slot_width = params_physical_width(param);
+	if (rt9123->tdm_slots && slot_width > rt9123->tdm_slot_width) {
+		dev_err(dev, "Slot width is larger than TDM slot width\n");
+		return -EINVAL;
+	}
+
+	snd_soc_component_write_field(comp, RT9123_REG_I2SOPT, RT9123_MASK_AUDFMT, audfmt);
+	snd_soc_component_write_field(comp, RT9123_REG_I2SOPT, RT9123_MASK_AUDBIT, audbit);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops rt9123_dai_ops = {
+	.set_fmt	= rt9123_dai_set_format,
+	.set_tdm_slot	= rt9123_dai_set_tdm_slot,
+	.hw_params	= rt9123_dai_hw_params,
+};
+
+static struct snd_soc_dai_driver rt9123_dai_driver = {
+	.name = "HiFi",
+	.playback = {
+		.stream_name	= "HiFi Playback",
+		.formats	= SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_S24 |
+				  SNDRV_PCM_FMTBIT_S32,
+		.rates		= SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+				  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_24000 |
+				  SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
+				  SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
+				  SNDRV_PCM_RATE_96000,
+		.rate_min	= 8000,
+		.rate_max	= 96000,
+		.channels_min	= 1,
+		.channels_max	= 2,
+	},
+	.ops    = &rt9123_dai_ops,
+};
+
+static bool rt9123_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case 0x00 ... 0x05:
+	case 0x12 ... 0x13:
+	case 0x20 ... 0x21:
+	case 0x36:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rt9123_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case 0x01 ... 0x05:
+	case 0x12 ... 0x13:
+	case 0x20 ... 0x21:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rt9123_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case 0x01:
+	case 0x20:
+	case 0x36:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config rt9123_regmap_config = {
+	.name			= "rt9123",
+	.reg_bits		= 8,
+	.val_bits		= 16,
+	.val_format_endian	= REGMAP_ENDIAN_BIG,
+	.readable_reg		= rt9123_readable_reg,
+	.writeable_reg		= rt9123_writeable_reg,
+	.volatile_reg		= rt9123_volatile_reg,
+	.cache_type		= REGCACHE_MAPLE,
+	.num_reg_defaults_raw	= RT9123_REG_ANAFLAG + 1,
+};
+
+static int rt9123_i2c_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct rt9123_priv *rt9123;
+	struct regmap *regmap;
+	__be16 value;
+	u16 venid;
+	int ret;
+
+	rt9123 = devm_kzalloc(dev, sizeof(*rt9123), GFP_KERNEL);
+	if (!rt9123)
+		return -ENOMEM;
+
+	rt9123->enable = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(rt9123->enable))
+		return PTR_ERR(rt9123->enable);
+	else if (rt9123->enable)
+		usleep_range(250, 350);
+	else
+		dev_dbg(dev, "No 'enable' GPIO specified, treat it as default on\n");
+
+	/* Check vendor id information */
+	ret = i2c_smbus_read_word_data(i2c, RT9123_REG_COMBOID);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to read vendor-id\n");
+
+	venid = be16_to_cpu(ret);
+	if ((venid & RT9123_MASK_VENID) != RT9123_FIXED_VENID)
+		return dev_err_probe(dev, -ENODEV, "Incorrect vendor-id 0x%04x\n", venid);
+
+	/* Trigger RG reset before regmap init cache */
+	value = cpu_to_be16(RT9123_MASK_SWRST);
+	ret = i2c_smbus_write_word_data(i2c, RT9123_REG_AMPCTRL, value);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to trigger RG reset\n");
+
+	/* Need to wait 10ms for the reset to complete */
+	usleep_range(10000, 11000);
+
+	regmap = devm_regmap_init_i2c(i2c, &rt9123_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to init regmap\n");
+
+	i2c_set_clientdata(i2c, rt9123);
+
+	pm_runtime_set_autosuspend_delay(dev, 500);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable pm runtime\n");
+
+	return devm_snd_soc_register_component(dev, &rt9123_comp_driver, &rt9123_dai_driver, 1);
+}
+
+#ifdef CONFIG_PM
+static int rt9123_runtime_suspend(struct device *dev)
+{
+	struct rt9123_priv *rt9123 = dev_get_drvdata(dev);
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+
+	if (rt9123->enable) {
+		regcache_cache_only(regmap, true);
+		regcache_mark_dirty(regmap);
+		gpiod_set_value(rt9123->enable, 0);
+	}
+
+	return 0;
+}
+
+static int rt9123_runtime_resume(struct device *dev)
+{
+	struct rt9123_priv *rt9123 = dev_get_drvdata(dev);
+	struct regmap *regmap = dev_get_regmap(dev, NULL);
+	int ret;
+
+	if (rt9123->enable) {
+		gpiod_set_value(rt9123->enable, 1);
+		usleep_range(250, 350);
+
+		regcache_cache_only(regmap, false);
+		ret = regcache_sync(regmap);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops rt9123_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(rt9123_runtime_suspend, rt9123_runtime_resume, NULL)
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id rt9123_device_id[] = {
+	{ .compatible = "richtek,rt9123" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rt9123_device_id);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id rt9123_acpi_match[] = {
+	{ "RT9123", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, rt9123_acpi_match);
+#endif
+
+static struct i2c_driver rt9123_i2c_driver = {
+	.driver = {
+		.name = "rt9123",
+		.of_match_table = of_match_ptr(rt9123_device_id),
+		.acpi_match_table = ACPI_PTR(rt9123_acpi_match),
+		.pm = pm_ptr(&rt9123_dev_pm_ops),
+	},
+	.probe	= rt9123_i2c_probe,
+};
+module_i2c_driver(rt9123_i2c_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("ASoC rt9123 Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


