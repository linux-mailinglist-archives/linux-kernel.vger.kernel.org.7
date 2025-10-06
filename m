Return-Path: <linux-kernel+bounces-843350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC4BBEFEE
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A1B3C1A22
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8A02DF13F;
	Mon,  6 Oct 2025 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IfwCwJu/"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52922C339
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775852; cv=none; b=LCRZA1u/eQ11w3AeWH+7ox1cYg/Ow8I1jshlat+0INKLPYJ0xwCPgZERJjRa0gykTo3y+OqHfh/ZvbpUBuhEyWNHuFQ8YX3zk42fOc0GjtifHReTFoOVivL0fuAgYDFGSFtwKaUjrdaN1ciK+K0DOlp6MAjYaR44n8h7XpEDSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775852; c=relaxed/simple;
	bh=M5GD77yVYPF4Q7GbK/5MsLgJ13pQ7XTyeq/dx8K3o3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IKFEee9h0kAWmmWznUweSV+RgjPoYkQ17sc9tfDcHEH5a5Qjg9Z/cyBSz0U2EybOKON8gu4PFDrkUKBAA3Bw8aSmYhkFDYWE2znvE7vcEx9jaTbYD3iiVdilzp9aDlFMgYWGz37/+2E8EhiRhGRY9Gynbb5W4W50xIzYZ2qre4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IfwCwJu/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4256866958bso2259498f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759775848; x=1760380648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dI8wUrz4/k851DETHwU7YXPmi9b0tL6nAakNVDCwCbw=;
        b=IfwCwJu/+kr7FMaUWFNdJ9LM/zfhGIYfzkP2fWVuhzgEsiO6VeQeLk4LOjWUZa3B6Z
         DkKka+wkfKXx2ejpENi/Kv1TARkV05efs02RYFxdBIn+LYlWD+1Z6S06D8Rn6D5Bm2Ow
         Fl4SMZOIMk6sT0P5RTMTkwFL3ClpH3GFBQxG0BQ3mEo7A06REYHUr8lHDQu13zx9LMj7
         ierM2Lm4W39m7BiLq/LUOOM5rzHxM+U9j9IGZsfxmeZH07BrkEBE1c6heu0r9aAhFWdm
         cC+oIbI/wgOAmrVOskbOrzmzn/53/Zqw1JACGhlbEeUqoLV1Adoup7GaPQ7IDyBxIB7J
         JQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759775848; x=1760380648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dI8wUrz4/k851DETHwU7YXPmi9b0tL6nAakNVDCwCbw=;
        b=LyCJRZkX3/mG8sUkK/BcWnI2JNl1J9zvNyXyasbU3x6OhPgR54JEQZF/rtwct7E9nR
         /bobLuoHT9R9wrjex0WET5yy4W8VgWUgZDXfS6uv6erTP3rugVO2cMRyHdUlb7satzkX
         oHiaIOqOrI8TBc4STkxsrnBiRMuviAww10y6C3YK2Oo3VNE3GQ2Wsmiyh2s280nkAWel
         C11qMs6icqKS7MAKb5pF9toPNS5ZZzoX3Jg5WqelMxW5ocg15rUEjBLI9lPNM4ydomvy
         ToE4MyXVJGxH7yo7sQ8nws6XYd6xJoiask7VMT0npq7ajzAaaOUQtPZ8BUY/BNV0X66w
         HijA==
X-Forwarded-Encrypted: i=1; AJvYcCXMiwpAfon3lQSynem1bKh+9H5Rxia7MtMSBhDPrdklcBI4g2aEq3QJhsPOhB2ycl9A1F1g4xtdVHjNoIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuIIb1zKijLvv3ym4iZp3MC2OwNFCTbQsb3HreyJd+8t9lEMuk
	0ndhzIonslcrXQryu33yR9B3aASJ5FBgD7wm36ihRN34dTcZ/VMrZl9ER+xviqeVaoM=
X-Gm-Gg: ASbGncssELLXDYNl2ce7z3F0PxasSJ/i/OHaVTWuOPk0s/+WIqq2AtfCd6+CYOcBX+w
	T0DYzOKDws6rwuWdyakpmkR6mDziZDKtcB/HLZ1hzs8TZhbwCJyHNPS88IwQQnbdKbJGZP4HMMP
	Gy+UJuUF3JJREJWiBQ2zGAe/IDZpkUElaYgauCWnkeDLFQwe3RWbNiVSjvH4Q0DmLkuL8/FlPMZ
	/Z9+pREKPtxQ9KuA1Uh6mv01kcGLVj0U5dwS7l+UtTwTZ5qGAh60qdWgKXSRrGHEsmhEztO2xGV
	D67jjlTG+s+PqSrXz+aoukVbfuWIm1SX0v2d7W8glQYVyG23Ue5BcFUOCNqvP6WlS46CN4ipEoU
	f4Kwuh3HtTBN+gCFwGVeLV1YlgeprpsrF84i/E2B6fFzQ8MfQFguXEVX2xGrKb16TJA3S8ik=
X-Google-Smtp-Source: AGHT+IH5WFHXj0MAsogmXEFsMguBCEu2+LGzAK6Up3vXAWYFmLrYzU7DqZUEVx2h3vNb0guaFYMCFQ==
X-Received: by 2002:a05:6000:1862:b0:3f4:8579:3692 with SMTP id ffacd0b85a97d-42567139e8bmr8755978f8f.11.1759775848188;
        Mon, 06 Oct 2025 11:37:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a022d8sm254997085e9.12.2025.10.06.11.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 11:37:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 06 Oct 2025 20:37:16 +0200
Subject: [PATCH RFC 3/6] ASoC: soc: qcom: sc8280xp: add support for I2S
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-topic-sm8x50-next-hdk-i2s-v1-3-184b15a87e0a@linaro.org>
References: <20251006-topic-sm8x50-next-hdk-i2s-v1-0-184b15a87e0a@linaro.org>
In-Reply-To: <20251006-topic-sm8x50-next-hdk-i2s-v1-0-184b15a87e0a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5267;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=M5GD77yVYPF4Q7GbK/5MsLgJ13pQ7XTyeq/dx8K3o3k=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo5Axji7KylYpPsvsncc7vt5nwH771LHGNHt5tDHXN
 VaqKniiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOQMYwAKCRB33NvayMhJ0QVAD/
 9BlLFEVSfpcHuKOUy3obt8YQw32WcWZiI8dQOAWS7EDVQoJ5KDE7p5akSn/PbxH7mq/8qQRCpwF8a0
 f57TEFun9bTcnIkXFtHgkIvivsffMRqFYgShb9+Yi8VITe5lFy/9nAjyj8gh821QK9vQo8OEHpdzPR
 TidqLnmUZxEqkAFr0SkLhmy5XZeWfudvtIfGWBwDNT4r+fMTIFdaFexMjH+ioiRt0L/6/CRdknfqUD
 xS+xMqKOIzlgVpUVhDsuJhG7U3Wf5gtqqDVGKBaX4Vywa/OwQfzlQkqgSSgspYMrOfX3xB+1E/QtJ4
 CF+YhV68XMGO5hqgbht9Aj1CS5nANkdLXrKOMzVerZQ/2PYDl/Dk1M12bg3RBFlnacqKaZsGW3bWx4
 4Zga3Th4MG54eSB0zBUO4eqyuoWk20C9rDklS9Pl+uUVlC8ZPJ6eTWfIXBbLAmF6LyvgyOrSFpmd7O
 PWaqaesE9Llv3lsQhgo7F5f8TFQrcWupHXxukioy6oMp7uhMvx+zJj81E4TJvyzNRr2dQIeN+oeJCc
 DLEmBbnhD3Ai3PMO8ojtIzO9wuJh9wd3PRBXQuK2vqVraHcp3xTchNS4K3wEKUvvYrkFL050uL0AVm
 Kiy2nZcXzIogLzpY13E1PR6fbPk7TAXTa/E78yeV+zYa5RR/LL7f8KiyexvQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add support for getting the I2S clocks used for the MI2S
interfaces, and enable/disable the clocks on the PCM
startup and shutdown card callbacks.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 sound/soc/qcom/sc8280xp.c | 104 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 78e327bc2f07767b1032f09af7f45b947e7eb67a..ad4ee5c6fab8994f18de572842f3dab6f4f5397e 100644
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
@@ -15,12 +17,16 @@
 #include "common.h"
 #include "sdw.h"
 
+#define I2S_MAX_CLKS	5
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
 
@@ -68,12 +74,66 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
 }
 
+static int sc8280xp_snd_i2s_index(struct snd_soc_dai *dai)
+{
+	switch (dai->id) {
+	case PRIMARY_MI2S_RX..PRIMARY_MI2S_TX:
+		return 0;
+	case  SECONDARY_MI2S_RX.. SECONDARY_MI2S_TX:
+		return 1;
+	case TERTIARY_MI2S_RX..TERTIARY_MI2S_TX:
+		return 2;
+	case QUATERNARY_MI2S_RX..QUATERNARY_MI2S_TX:
+		return 3;
+	case QUINARY_MI2S_RX..QUINARY_MI2S_TX:
+		return 4;
+	default:
+		return -1;
+	}
+}
+
+static int sc8280xp_snd_startup(struct snd_pcm_substream *substream)
+{
+	unsigned int codec_dai_fmt = SND_SOC_DAIFMT_BC_FC | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sc8280xp_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
+	int index;
+
+	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
+	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
+		index = sc8280xp_snd_i2s_index(cpu_dai);
+		clk_enable(pdata->i2s_mclk[index]);
+		clk_enable(pdata->i2s_clk[index]);
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
+	case PRIMARY_MI2S_RX..TERTIARY_MI2S_RX:
+	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
+		index = sc8280xp_snd_i2s_index(cpu_dai);
+		clk_disable(pdata->i2s_clk[index]);
+		clk_disable(pdata->i2s_mclk[index]);
+		break;
+	default:
+		break;
+	}
 
 	pdata->sruntime[cpu_dai->id] = NULL;
 	sdw_release_stream(sruntime);
@@ -141,7 +201,7 @@ static int sc8280xp_snd_hw_free(struct snd_pcm_substream *substream)
 }
 
 static const struct snd_soc_ops sc8280xp_be_ops = {
-	.startup = qcom_snd_sdw_startup,
+	.startup = sc8280xp_snd_startup,
 	.shutdown = sc8280xp_snd_shutdown,
 	.hw_params = sc8280xp_snd_hw_params,
 	.hw_free = sc8280xp_snd_hw_free,
@@ -162,6 +222,44 @@ static void sc8280xp_add_be_ops(struct snd_soc_card *card)
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
+static int sc8280xp_get_i2c_clocks(struct platform_device *pdev,
+				   struct sc8280xp_snd_data *data)
+{
+	struct device *dev = &pdev->dev;
+	int i;
+
+	if (!device_property_present(dev))
+		return 0;
+
+	for (i = 0; i < I2S_MAX_CLKS; ++i) {
+		char name[16];
+
+		snprintf(name, 16, "%s-mi2s", i2s_bus_names, i);
+		data->i2s_clk[i] = devm_clk_get_optional_prepared(dev, name);
+		if (IS_ERR(data->i2s_clk[i]))
+			return dev_err_probe(dev, PTR_ERR(data->i2s_clk[i]),
+					     "unable to get %s clock\n",
+					     name);
+
+		snprintf(name, 16, "%s-mclk", i2s_bus_names, i);
+		data->i2s_mclk[i] = devm_clk_get_optional_prepared(dev, name);
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
@@ -185,6 +283,10 @@ static int sc8280xp_platform_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = sc8280xp_get_i2c_clocks(pdev, data);
+	if (ret)
+		return ret;
+
 	card->driver_name = of_device_get_match_data(dev);
 	sc8280xp_add_be_ops(card);
 	return devm_snd_soc_register_card(dev, card);

-- 
2.34.1


