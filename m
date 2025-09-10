Return-Path: <linux-kernel+bounces-809844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C7FB512AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C881C8276C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA7B3126DF;
	Wed, 10 Sep 2025 09:38:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5C313E2D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497080; cv=none; b=Tfc2hqGC53uDVLy36R0STHstmN+hS4qnf/LrrWCJMpyHPOdw9i6kD90zikwOmyvKIn7fvsbAtJ1e9/OTejh9WXD0wcK+EfHm81063uQSEGqJIj+gjWBjh0dw9lbW3nHe2goVf08ro0UyhEe59hNxlKNQGzVVczP29oeYI8S/W08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497080; c=relaxed/simple;
	bh=5SV8L6x3HJ6R7zEONs4fhj8HkTB0HxhgWa8yz90iYk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TT7n8okf8Q7Rtgv7RoRfmX3SjrHpcA4dVn3MtVlpIoBj+NijUGeZ+Gb+AS37AnpjS8PdisC9YUmY9ThmHmPMgqJK3RlMAPGXhgs0ehWs8gj83yf4h9bH9/8+1VdXwX+FStufa8yw4BSXAFqtiA23307ADoZQeJTMcP7evTokv3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uwHGt-0007uO-Ja; Wed, 10 Sep 2025 11:37:47 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uwHGs-000ZLe-3A;
	Wed, 10 Sep 2025 11:37:46 +0200
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uwHGs-000000090kl-3lGO;
	Wed, 10 Sep 2025 11:37:46 +0200
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Date: Wed, 10 Sep 2025 11:34:06 +0200
Subject: [PATCH v2 2/2] ASoC: codecs: pcm1754: add pcm1754 dac driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-v6-12-topic-pcm1754-v2-2-0917dbe73c65@pengutronix.de>
References: <20250910-v6-12-topic-pcm1754-v2-0-0917dbe73c65@pengutronix.de>
In-Reply-To: <20250910-v6-12-topic-pcm1754-v2-0-0917dbe73c65@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Stefan Kerkmann <s.kerkmann@pengutronix.de>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.kerkmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The Texas Instruments PCM1754[1] is a simple stereo DAC without any
digital
management interface but soft mute, PCM input format and 44.1 kHz
digital de-emphasis can be configured via strapping pins. Only soft mute
and PCM input format selection is currently exposed via optional GPIOs
in the driver.

[1]: https://www.ti.com/product/PCM1754

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Co-developed-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Signed-off-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
---
 sound/soc/codecs/Kconfig   |   5 ++
 sound/soc/codecs/Makefile  |   2 +
 sound/soc/codecs/pcm1754.c | 185 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7092842480ef17d705920a6ac62a85158119352e..7b2d677453872b5e8d7c115c5f5618be55b7a4a1 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -170,6 +170,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_NAU8825
 	imply SND_SOC_HDMI_CODEC
 	imply SND_SOC_PCM1681
+	imply SND_SOC_PCM1754
 	imply SND_SOC_PCM1789_I2C
 	imply SND_SOC_PCM179X_I2C
 	imply SND_SOC_PCM179X_SPI
@@ -1367,6 +1368,10 @@ config SND_SOC_PCM1681
 	tristate "Texas Instruments PCM1681 CODEC"
 	depends on I2C
 
+config SND_SOC_PCM1754
+	tristate "Texas Instruments PCM1754 CODEC"
+	depends on GPIOLIB
+
 config SND_SOC_PCM1789
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 54cbc3feae3277ae29d6ea8fe891d4d17e5c9b17..1c6fbdc752309ab75486a979b21be50c3f67fdcf 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -191,6 +191,7 @@ snd-soc-nau8824-y := nau8824.o
 snd-soc-nau8825-y := nau8825.o
 snd-soc-hdmi-codec-y := hdmi-codec.o
 snd-soc-pcm1681-y := pcm1681.o
+snd-soc-pcm1754-y := pcm1754.o
 snd-soc-pcm1789-codec-y := pcm1789.o
 snd-soc-pcm1789-i2c-y := pcm1789-i2c.o
 snd-soc-pcm179x-codec-y := pcm179x.o
@@ -593,6 +594,7 @@ obj-$(CONFIG_SND_SOC_NAU8824)   += snd-soc-nau8824.o
 obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC)	+= snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
+obj-$(CONFIG_SND_SOC_PCM1754)	+= snd-soc-pcm1754.o
 obj-$(CONFIG_SND_SOC_PCM179X)	+= snd-soc-pcm179x-codec.o
 obj-$(CONFIG_SND_SOC_PCM1789_I2C)	+= snd-soc-pcm1789-i2c.o
 obj-$(CONFIG_SND_SOC_PCM1789)	+= snd-soc-pcm1789-codec.o
diff --git a/sound/soc/codecs/pcm1754.c b/sound/soc/codecs/pcm1754.c
new file mode 100644
index 0000000000000000000000000000000000000000..b68a528000be89b15c1d7770ba8f55fbdadeb6b8
--- /dev/null
+++ b/sound/soc/codecs/pcm1754.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PCM1754 DAC ASoC codec driver
+ *
+ * Copyright (c) 2022 Alvin Šipraga <alsi@bang-olufsen.dk>
+ * Copyright (c) 2025 Stefan Kerkmann <s.kerkmann@pengutronix.de>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+struct pcm1754_priv {
+	unsigned int format;
+	struct gpio_desc *gpiod_mute;
+	struct gpio_desc *gpiod_format;
+};
+
+static int pcm1754_set_dai_fmt(struct snd_soc_dai *codec_dai,
+				   unsigned int format)
+{
+	struct snd_soc_component *component = codec_dai->component;
+	struct pcm1754_priv *priv = snd_soc_component_get_drvdata(component);
+
+	priv->format = format;
+
+	return 0;
+}
+
+static int pcm1754_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *codec_dai)
+{
+	struct snd_soc_component *component = codec_dai->component;
+	struct pcm1754_priv *priv = snd_soc_component_get_drvdata(component);
+	int format;
+
+	switch (priv->format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_RIGHT_J:
+		switch (params_width(params)) {
+		case 16:
+			format = 1;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		switch (params_width(params)) {
+		case 16:
+			fallthrough;
+		case 24:
+			format = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_err(component->dev, "Invalid DAI format\n");
+		return -EINVAL;
+	}
+
+	gpiod_set_value_cansleep(priv->gpiod_format, format);
+
+	return 0;
+}
+
+static int pcm1754_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct pcm1754_priv *priv = snd_soc_component_get_drvdata(dai->component);
+
+	gpiod_set_value_cansleep(priv->gpiod_mute, mute);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops pcm1754_dai_ops = {
+	.set_fmt = pcm1754_set_dai_fmt,
+	.hw_params = pcm1754_hw_params,
+	.mute_stream = pcm1754_mute_stream,
+};
+
+static const struct snd_soc_dai_driver pcm1754_dai = {
+	.name = "pcm1754",
+	.playback = {
+		.stream_name	= "Playback",
+		.channels_min	= 2,
+		.channels_max	= 2,
+		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min	= 5000,
+		.rate_max	= 200000,
+		.formats	= SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE
+	},
+	.ops = &pcm1754_dai_ops,
+};
+
+static const struct snd_soc_dapm_widget pcm1754_dapm_widgets[] = {
+	SND_SOC_DAPM_REGULATOR_SUPPLY("VCC", 0, 0),
+
+	SND_SOC_DAPM_DAC("DAC1", "Channel 1 Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DAC2", "Channel 2 Playback", SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_OUTPUT("VOUTL"),
+	SND_SOC_DAPM_OUTPUT("VOUTR"),
+};
+
+static const struct snd_soc_dapm_route pcm1754_dapm_routes[] = {
+	{ "DAC1", NULL, "Playback" },
+	{ "DAC2", NULL, "Playback" },
+
+	{ "DAC1", NULL, "VCC" },
+	{ "DAC2", NULL, "VCC" },
+
+	{ "VOUTL", NULL, "DAC1" },
+	{ "VOUTR", NULL, "DAC2" },
+};
+
+static const struct snd_soc_component_driver soc_component_dev_pcm1754 = {
+	.dapm_widgets = pcm1754_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(pcm1754_dapm_widgets),
+	.dapm_routes = pcm1754_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(pcm1754_dapm_routes),
+};
+
+static int pcm1754_probe(struct platform_device *pdev)
+{
+	struct pcm1754_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct snd_soc_dai_driver *dai_drv;
+	int ret;
+
+	dai_drv = devm_kmemdup(dev, &pcm1754_dai, sizeof(*dai_drv), GFP_KERNEL);
+	if (!dai_drv)
+		return -ENOMEM;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->gpiod_mute = devm_gpiod_get_optional(dev, "mute", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->gpiod_mute))
+		return dev_err_probe(dev, PTR_ERR(priv->gpiod_mute),
+					 "failed to get mute gpio");
+
+	priv->gpiod_format = devm_gpiod_get_optional(dev, "format", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->gpiod_format))
+		return dev_err_probe(dev, PTR_ERR(priv->gpiod_format),
+					 "failed to get format gpio");
+
+	dev_set_drvdata(dev, priv);
+
+	ret = devm_snd_soc_register_component(
+		&pdev->dev, &soc_component_dev_pcm1754, dai_drv, 1);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register");
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id pcm1754_of_match[] = {
+	{ .compatible = "ti,pcm1754" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pcm1754_of_match);
+#endif
+
+static struct platform_driver pcm1754_codec_driver = {
+	.driver = {
+		.name = "pcm1754-codec",
+		.of_match_table = of_match_ptr(pcm1754_of_match),
+	},
+	.probe = pcm1754_probe,
+};
+
+module_platform_driver(pcm1754_codec_driver);
+
+MODULE_DESCRIPTION("ASoC PCM1754 driver");
+MODULE_AUTHOR("Alvin Šipraga <alsi@bang-olufsen.dk>");
+MODULE_AUTHOR("Stefan Kerkmann <s.kerkmann@pengutronix.de>");
+MODULE_LICENSE("GPL");

-- 
2.47.3


