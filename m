Return-Path: <linux-kernel+bounces-845872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D52CBC6625
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58733C1605
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8032C2ABF;
	Wed,  8 Oct 2025 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfIJ2IpX"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D175A2C11E6
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949822; cv=none; b=I5si8CQSxe6Pt3nYp5HOEXCTV+OThjUB8W+eqDEpBu3t+8P9mZeiN7hTKX6UHnMxdipLWBo4B1JXxtiV2SCcgh8f0Sv076dWc6PhGxDnwscup7fFG16QAH6YMNLpEGeAfBRs8SboWbxVudmctglnioaCU83F588KvYC+jrvUOjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949822; c=relaxed/simple;
	bh=cByQlT3iuF6qwVWiTyCdysRZHmuUR8iTELF05kVhH4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WkWIhsAS4tKRxquTlLMDO/L98r5nHRi0NSWJJ1gA7IU0pGFnvqsCRLK0E2dzSWshHI5rZpY8almTBzU7HrMOe1QrI0+hjYDjnabO6CStIM+Rd1muBNENOWS8N7Y6bz/QyBMdVORH+xvg9wF+yAFewORPOTithFUI/Qe9DR9FxIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HfIJ2IpX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4256866958bso155449f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759949817; x=1760554617; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0itgt9GoA3qaJoGcHH9KbPanWl4AsRntW2zkPUp6kYA=;
        b=HfIJ2IpXncwimR1T006O6kAWxC9IzuSbXQyBgjUQpyhm/1sWWHaTnN/SnVSB1W12ot
         w0VoBzpmLqa19wkks8WvdTDcoMl6eMb9D7TY1ygMFAtx9Iy76YJIIjGaQPYDPSbMYNqy
         DnJLooJFDKa2UmLfoGY6t4/CY1wHTo+nxU/Bj05FToJv5k94pz0fNxZiGMGihsSCk16A
         kFFY2V03uOi5PctQRG7FZQidbZkLiP1MX+IRxUyGwHb8b2NiKrvsev9v9CmQBoK7KMp1
         6aDd9tfEMGiv5owzE7QXwWOADKAd6YaNBlgJbzxko5hT8ORMcBezNDp9yVcYziSoI6oo
         20/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759949817; x=1760554617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0itgt9GoA3qaJoGcHH9KbPanWl4AsRntW2zkPUp6kYA=;
        b=e249sUKrJUSwv9MXcheR1mp6jl/6X98LCXz8bIRna8E88maa1wLLL0CNmN6gCIZvlS
         G2RC3e+xj/ksVUuU5OmmjNoCX8z3FCxa6q9M83RLXoE7NcCPQFfzm/jvKN0w7enUZ+Pq
         HlS1KjKyMSuYnW6VKQpFvDJA7tTZ2B0xeONXOY80W0FJAjfC3GZLnSGkJOtpbNmITFkI
         sTHsECSFFGS/Gkqp/TSLS0TRNXtXyfBVpREexZXvbDq63GeUzJW5wEHIU0NBk/+irM6t
         bq251eNs0b3gXwr8pzUSMBmklGUbF03T0IyBn9JqPLY2EgUc1G2iiHXpnMDrcRU6fVpR
         6x0A==
X-Forwarded-Encrypted: i=1; AJvYcCWUZFSSLMpeX4vMkrMKMhxi7MT43nXsOn0+198zq6jujY8cT1D7dv5fWC1xWzMY6BKxA+Z1YQEQeKQz+gk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+VjEy7quxS0HAhBDCeYLnE/6MKsK3SwcY/UcDdCveoif6Wxw
	EannCxWxK4Z+8eZuqi3hPwPQMTjW79PZ3iuhVelogVcw1TCah8gQ9vShlxhc60HP++c=
X-Gm-Gg: ASbGncuBsX5/7WZ1DjPvsTCSQ2wFpyHUee7+iv5tuIpSor42+i07d+fO/QcI2JbNfX6
	bCWL6AQaqBAjUQ++m2S6WFJU9Kz92GnHziF8/a6FWa73d37VCg0FKX3Kwg2AtfkXuFCsdhrzsmD
	tl22t9YfFF7/vhLR5kLAqpzC0Ft25ZvDSP+MQljicUlJaozhJ2IX/5FIoSdrb7w1fSDjzD0YDy9
	avx/dlZorQlNr8ml0I10gX2qieJ9VZGFaehYnOXnu+KAl5XBA9F0GxlP6HtuKT+XDAAa51Cshs9
	YklWA65QvwKfVPa8Rv3YphqzBPEqxGdbXUU+xx7hUx0AIG9RhnKSQBxrcUdlYaIHyc/yzeMzmJG
	hoEeAf5cQiPl+dBWtMoFuJctfUv+p0u/oQ+Q4qcLvjCIFFQFdWiNlJTymlJ1N8IkWrOgMtis/GQ
	nJv0M05A==
X-Google-Smtp-Source: AGHT+IE8cg6SIT+q7qzMGY3i3e0nRUZSSkizPqDWX4+SgEmTuUU2OeYJeSYBxCj4oE+C6fSiom9+Mg==
X-Received: by 2002:a05:6000:2087:b0:425:86f1:5861 with SMTP id ffacd0b85a97d-4266e7dfb44mr2642984f8f.30.1759949816973;
        Wed, 08 Oct 2025 11:56:56 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e96e0sm31029735f8f.33.2025.10.08.11.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:56:56 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 08 Oct 2025 20:56:50 +0200
Subject: [PATCH RFC v2 3/6] ASoC: soc: qcom: sc8280xp: add support for I2S
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-topic-sm8x50-next-hdk-i2s-v2-3-6b7d38d4ad5e@linaro.org>
References: <20251008-topic-sm8x50-next-hdk-i2s-v2-0-6b7d38d4ad5e@linaro.org>
In-Reply-To: <20251008-topic-sm8x50-next-hdk-i2s-v2-0-6b7d38d4ad5e@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6868;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=cByQlT3iuF6qwVWiTyCdysRZHmuUR8iTELF05kVhH4g=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo5rPz0lFUOljOJZuXmrJM1vNjeQQjMEI++pslKGcs
 P0FjBH+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOaz8wAKCRB33NvayMhJ0URpD/
 41RfpXBNvNIz5LpUgjtUNF52+Y6MHNZfI9PHSmMTnoBZ9e6QPBwNqKJ0J7ZJBv2gRfjq7p3roE4R7h
 SkNG49Sy4YI0iU2QXd8r/PSoZZWnuWb0lQRS21PR6mpNjMkGP7bhFVL4DFgb6YmNeoClhmeyWc14dl
 iJbIXt0qYSUmB+i4diAS2va/ysBggYTEVlkGNClLhMwKyQQJ3YPQqGZMaq3xN4ffWmtigfN/pSBEcL
 yE/W4eWDLaJD1Op+a+T6c5/G5ToJ/BehOrzfa/1DB8GSDkLBNunIBeAwXKSw4fA1GxE8GNrpeQ94Ta
 Na/qWCYlPcblqiRxRItZ1GMpih1m2b/pNDaHTUvHryztAbOq9QqxHneQNFl6vJUm8hFcghYjTIwDBH
 BPvoZAd4wJqF6M44G/w7jYwmmHwxz/umcpnd0KF/cUnquFvsCzZeWHMvmsrq9ckJf7t675fzu8QmI/
 QJmOJyTcPxi/drY4cpOuSfOsVuRcW2597oRLJ87A9U27pRgQl0uGtjsAUkYj6sluQTUCrcyLoMxbUk
 gf6CFBGz1HAqf56i58Elddd4Av2fS+kSOdS7GoiS5TnUwIMW/Cq8GUQ9kCfGF16wZ6Nvr62Q7Dwkxo
 ftX8uz5a2vjkIwPHLWFGeT5FFeHqmIF/5U3CxlcxOSvxRV4+ng2LGDLa3Cww==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add support for getting the I2S clocks used for the MI2S
interfaces, and enable/disable the clocks on the PCM
startup and shutdown card callbacks.

The rate can be easily calculated since the card forces 48Hz,
2 channels at 16bit slot size.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 sound/soc/qcom/sc8280xp.c | 132 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 78e327bc2f07767b1032f09af7f45b947e7eb67a..82b173c2dabbd1478df49ba9f0cc53e82bf2f8d2 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -4,6 +4,8 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/of_clk.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
@@ -15,15 +17,47 @@
 #include "common.h"
 #include "sdw.h"
 
+#define I2S_MAX_CLKS	5
+
+#define I2S_MCLKFS	256
+#define I2S_SLOTSIZE	16
+#define I2S_MCLK_RATE(rate, channels) \
+		((rate) * (channels) * I2S_MCLKFS)
+#define I2S_BIT_RATE(rate, channels) \
+		((rate) * (channels) * I2S_SLOTSIZE)
+
+#define I2S_DEFAULT_RATE	48000
+#define I2S_DEFAULT_CHANNELS	2
+
 struct sc8280xp_snd_data {
 	bool stream_prepared[AFE_PORT_MAX];
 	struct snd_soc_card *card;
 	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
 	struct snd_soc_jack jack;
 	struct snd_soc_jack dp_jack[8];
+	struct clk *i2s_clk[I2S_MAX_CLKS];
+	struct clk *i2s_mclk[I2S_MAX_CLKS];
 	bool jack_setup;
 };
 
+static int sc8280xp_snd_i2s_index(struct snd_soc_dai *dai)
+{
+	switch (dai->id) {
+	case PRIMARY_MI2S_RX...PRIMARY_MI2S_TX:
+		return 0;
+	case  SECONDARY_MI2S_RX...SECONDARY_MI2S_TX:
+		return 1;
+	case TERTIARY_MI2S_RX...TERTIARY_MI2S_TX:
+		return 2;
+	case QUATERNARY_MI2S_RX...QUATERNARY_MI2S_TX:
+		return 3;
+	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
+		return 4;
+	default:
+		return -1;
+	}
+}
+
 static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
@@ -31,10 +65,22 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_card *card = rtd->card;
 	struct snd_soc_jack *dp_jack  = NULL;
 	int dp_pcm_id = 0;
+	int index, ret;
 
 	switch (cpu_dai->id) {
 	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
 	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
+		index = sc8280xp_snd_i2s_index(cpu_dai);
+		ret = clk_set_rate(data->i2s_mclk[index],
+				   I2S_MCLK_RATE(I2S_DEFAULT_RATE,
+						 I2S_DEFAULT_CHANNELS));
+		if (ret)
+			dev_err(data->card->dev, "Unable to set mclk rate\n");
+		ret = clk_set_rate(data->i2s_clk[index],
+				   I2S_BIT_RATE(I2S_DEFAULT_RATE,
+						I2S_DEFAULT_CHANNELS));
+		if (ret)
+			dev_err(data->card->dev, "Unable to set bit rate\n");
 		snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_BP_FP);
 		break;
 	case WSA_CODEC_DMA_RX_0:
@@ -68,12 +114,54 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
 }
 
+static int sc8280xp_snd_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sc8280xp_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
+	unsigned int codec_dai_fmt = SND_SOC_DAIFMT_BC_FC |
+				     SND_SOC_DAIFMT_NB_NF |
+				     SND_SOC_DAIFMT_I2S;
+	int index, ret;
+
+	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
+	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
+		index = sc8280xp_snd_i2s_index(cpu_dai);
+		ret = clk_prepare_enable(pdata->i2s_mclk[index]);
+		if (ret)
+			dev_err(pdata->card->dev, "Unable to enable bit clock\n");
+		ret = clk_prepare_enable(pdata->i2s_clk[index]);
+		if (ret)
+			dev_err(pdata->card->dev, "Unable to enable master clock\n");
+		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
+		break;
+	default:
+		break;
+	}
+
+	return qcom_snd_sdw_startup(substream);
+}
+
 static void sc8280xp_snd_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sc8280xp_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
 	struct sdw_stream_runtime *sruntime = pdata->sruntime[cpu_dai->id];
+	int index;
+
+	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX...TERTIARY_MI2S_RX:
+	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
+		index = sc8280xp_snd_i2s_index(cpu_dai);
+		clk_disable_unprepare(pdata->i2s_clk[index]);
+		clk_disable_unprepare(pdata->i2s_mclk[index]);
+		break;
+	default:
+		break;
+	}
 
 	pdata->sruntime[cpu_dai->id] = NULL;
 	sdw_release_stream(sruntime);
@@ -141,7 +229,7 @@ static int sc8280xp_snd_hw_free(struct snd_pcm_substream *substream)
 }
 
 static const struct snd_soc_ops sc8280xp_be_ops = {
-	.startup = qcom_snd_sdw_startup,
+	.startup = sc8280xp_snd_startup,
 	.shutdown = sc8280xp_snd_shutdown,
 	.hw_params = sc8280xp_snd_hw_params,
 	.hw_free = sc8280xp_snd_hw_free,
@@ -162,6 +250,44 @@ static void sc8280xp_add_be_ops(struct snd_soc_card *card)
 	}
 }
 
+static const char * const i2s_bus_names[I2S_MAX_CLKS] = {
+	"primary",
+	"secondary",
+	"tertiary",
+	"quaternary",
+	"quinary",
+};
+
+static int sc8280xp_get_i2s_clocks(struct platform_device *pdev,
+				   struct sc8280xp_snd_data *data)
+{
+	struct device *dev = &pdev->dev;
+	int i;
+
+	if (!device_property_present(dev, "clocks"))
+		return 0;
+
+	for (i = 0; i < I2S_MAX_CLKS; ++i) {
+		char name[32];
+
+		snprintf(name, 32, "%s-mi2s", i2s_bus_names[i]);
+		data->i2s_clk[i] = devm_clk_get_optional(dev, name);
+		if (IS_ERR(data->i2s_clk[i]))
+			return dev_err_probe(dev, PTR_ERR(data->i2s_clk[i]),
+					     "unable to get %s clock\n",
+					     name);
+
+		snprintf(name, 32, "%s-mclk", i2s_bus_names[i]);
+		data->i2s_mclk[i] = devm_clk_get_optional(dev, name);
+		if (IS_ERR(data->i2s_mclk[i]))
+			return dev_err_probe(dev, PTR_ERR(data->i2s_mclk[i]),
+					     "unable to get %s clock\n",
+					     name);
+	}
+
+	return 0;
+}
+
 static int sc8280xp_platform_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
@@ -185,6 +311,10 @@ static int sc8280xp_platform_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = sc8280xp_get_i2s_clocks(pdev, data);
+	if (ret)
+		return ret;
+
 	card->driver_name = of_device_get_match_data(dev);
 	sc8280xp_add_be_ops(card);
 	return devm_snd_soc_register_card(dev, card);

-- 
2.34.1


