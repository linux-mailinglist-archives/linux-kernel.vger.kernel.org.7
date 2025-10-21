Return-Path: <linux-kernel+bounces-863057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 542A4BF6E63
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C620550672E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E67D338F43;
	Tue, 21 Oct 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbr8IPQW"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790C5339711
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054667; cv=none; b=roeXbwmOTk2ILikfaJ5bCq1yR2BxvCUSbx+CL/CL35ShKUW+qJEwxsUfvM3fACp0n4919nnzwYOII4KarNV0B9GB5wrTPaXetZJ2P/mSjcUpxlhKYqYiswW6Tf8kCJXOGDpgOVPNYnk8ZDu2qEyfxSNdsLiX3TUcsCFYcuPkFx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054667; c=relaxed/simple;
	bh=K2jOnkW1IsfbbGeogypIYlrDxXiV/U7Y6TILjFAX1/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bT31g5LM9pDT8IeMpnlHWarI6uDBxpT0u560wOIBV9DqatbLuPEX55CtdZyXey4QRHPxK8YOzuYhLruGryQohklEjFkEoBGpvQc+i9SXRnpZAHCp8BRqYZYAR7lajxk03stiA0sb+eB6vinolb8na486a1U9edWQq3bWMpcYfu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lbr8IPQW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-426ff694c1fso907149f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761054664; x=1761659464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWW5rpiL3fXVP4SacOcVtEnuu9Zwh6Lw21oGD01RkRw=;
        b=lbr8IPQWRYG9GBBw8BCwSfaJyYR6moo9IodUx5J7cJf/Z+s+r4FaXz9DeHe9natYHP
         Bw6/o9Ll4Le6chTKdp5eZWIapnL0rTnmrRjPyooppXoSprODKpGJj9CsoQkg3borTFXI
         QVddDrGEk+/A5AwxClXx/4AH5rmPesgHSag09HczNRg9W6isaItWGR6SJ5kcBYreAaUu
         86RGbRbHlGhvWVfAc5jZSi2JqBKeftr87Swwkm8puY+zLP+fDVwwqcCspUKut4R8iaQq
         qLI6KFlQPzfx/3vDV13ido3kwKPNdue6EIvJxBAMTtnS7C2hUeJdMXcueRpzSbgIjx5q
         E+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054664; x=1761659464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWW5rpiL3fXVP4SacOcVtEnuu9Zwh6Lw21oGD01RkRw=;
        b=iNfpXP+mirPlDc2cQjZzSVJfyYxuS+lWnaaNNPHk4AJGGN2vufG/tg9A2tKPKLcJ5E
         ssZ6WyEJp1t779MmprO+oEwZzvlfasIFFioK18blVGl9PJCdXpEqqBkAJvzMXIo+U3ov
         hTkle3T5YyXHaoMYH+Dc2sVD1nk1F46v6YG7eVTCtvsyJ6KPIHvi32ruYow93p588rPY
         HZNl+a9BygORHlLa3haDhDeZHbcdkeLbW+ZZnRlL8fBgrD/nRhDKqYwseMsHWRCYh89Y
         SE4jcXLKcs7WNJSo49pLwGRdnX+FQ9vVpA9YlHOb5CIZqSpiTbk102X/Jf1QFoFGaho+
         6Vxw==
X-Forwarded-Encrypted: i=1; AJvYcCWMFYhfHowkHZM6wZQaEbMofYAisUFggvBDK5OKRPQVtlgBAp6vbkVKwnqHyX5LBFz/c/9+MgzIm2YXBD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNtbZ6wmdQemLqG7GkbfujKBvsqfVkR72MS3eXvpXGJYxlgga+
	Z393udrhJWsT4Xg2C+C0enlzMI2Icvown/IOq4aNLXRkRF8pgoI+y4zJt0yMgvfO3xw=
X-Gm-Gg: ASbGncv/d8oIMKPDFxNy390gQJoSkEXggRei/EXP1SuMNGLTqpZFD9adXwes5/Pzr1e
	IZMwWFSVVbZkW+Kg5kA9vobg67L6hh/edCPgsbPJw3lq4l3JZcW+R+RqHBn3cfKTfX1U4EvfiRI
	SN9jD+QRUEAszygnnQyhGl/mLxiJ1KBEGfTo4zMpEfttzd2O84XJWJOCFI4tjwE6Bogup4Tz1Nx
	9OEsopllnZTuCQ1MWEpK58z+ojRraUx7vhL/SiInk2e1ZhnAjIe0srfE4MlEvPzWDgIdASdqJTa
	vmTWjNqBOUyUA7pBoFJix5whL7mt0HEdWW5Vam0bhPt+b7PkaKFzix4MxSJjljS8BJtekqOwvLk
	LkJgGq6hz5jrgpTHbnd324eAG0P/VQOv5Mg4uKoBYfqnSvHJgjqz3B7SSRWt5SgBpG0KFw5IkrA
	==
X-Google-Smtp-Source: AGHT+IEVarB8hPd9oTaPMzVW88VSh7bgsSwShOtuu9cb1VFtLqYXTOEOEnjKaYmdkaTGgMDCDNPnsw==
X-Received: by 2002:a05:6000:3101:b0:3ff:17ac:a34b with SMTP id ffacd0b85a97d-42704db8d8fmr12866650f8f.42.1761054663604;
        Tue, 21 Oct 2025 06:51:03 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm20124378f8f.36.2025.10.21.06.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:51:02 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 21 Oct 2025 16:50:45 +0300
Subject: [PATCH RFC 2/3] ASoC: qcom: x1e80100: Add Dell XPS13 9345 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dell-xps13-9345-enable-audio-v1-2-6f3f6bbd977b@linaro.org>
References: <20251021-dell-xps13-9345-enable-audio-v1-0-6f3f6bbd977b@linaro.org>
In-Reply-To: <20251021-dell-xps13-9345-enable-audio-v1-0-6f3f6bbd977b@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3561; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=K2jOnkW1IsfbbGeogypIYlrDxXiV/U7Y6TILjFAX1/c=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo94+/wao7msGfzrKycnoNRBsxGkf+jr3yIVSag
 doPwABdLfmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaPePvwAKCRAbX0TJAJUV
 Vik0D/9yRlW7mzDOHEZOM4jU8YAieeym5Qv4zPGKoJZs2lKTlP77jfPT+8ouLYC/f6lUvG43tpq
 fgWnbwhFpZI5mAmZM1NZ/q8Eph63OH8zrCh+ei3r+IhefciJ1FxlujC9RUOjMzQByrA83141md1
 0qSgE6YQwgqNT1Rq0xSV+QgEo6IdPIFC2B1NaJVnUVEBpXhrzlvng9WH0sRIpgGSiwTFP6pUgCi
 VvPhfza6NsrEKTpPUiK4qJckRcRQjVYFJbRM2KSfMuSJFxmrKJint/PgIKT0j34Dl0gq2MNefX1
 hVHdRD31Ctmv/0pBz9g6Ll8pRr6GW7lq0LSehX1lD2dl2AE6nbUa+v2ErDLz1wUbYs+mV7Kdk1S
 9fEN7GXLKX+pwzZxxJGITtuoR+Nqx6poFcnkZob2UHb2lk/fKUf79HlEYLkWL7xIDdkuXoFgLIO
 R2iOxtqH32/tkaUWU74VF7DWI22wp1oU7yZ/H/HO7HFJa45LKpKiyNlC83wwfZPNfthz84YFPSp
 /X7AI4jJMtG4dcolrPS9x2wXzUS18/V/ubyT3wqDFGMXigpwotemHsfNQ7A8JffbXRStfjTX32T
 APjxSfVyXPeF9nlrMUk2vYF8ERvnxgzn4KnoTjAi9cR47Ux26yrSjon476SQw/SoevCoQmXspIK
 YSFzwxWlX8ZiTew==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On Dell XPS13 9345, the PCM channels are mapped starting with right
hand side instead of left. So in order to support this, we need to
hardcode the mapping and tie it up to a dedicated board compatible.

So define a match data that brings the mapping as well, for the XPS 13,
while the rest of the boards will fallback to use the mapping based
on number of channels.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 sound/soc/qcom/x1e80100.c | 49 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/x1e80100.c b/sound/soc/qcom/x1e80100.c
index 444f2162889f7d9d4b6b06bddc980d8a15dd988b..e21cf534b2ac3875b694f381f260164acb2e3ae4 100644
--- a/sound/soc/qcom/x1e80100.c
+++ b/sound/soc/qcom/x1e80100.c
@@ -15,10 +15,17 @@
 #include "qdsp6/q6dsp-common.h"
 #include "sdw.h"
 
+struct x1e80100_snd_cfg {
+	const char *driver_name;
+	const unsigned int *channels_map;
+	int channels_num;
+};
+
 struct x1e80100_snd_data {
 	bool stream_prepared[AFE_PORT_MAX];
 	struct snd_soc_card *card;
 	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
+	const struct x1e80100_snd_cfg *cfg;
 	struct snd_soc_jack jack;
 	struct snd_soc_jack dp_jack[8];
 	bool jack_setup;
@@ -95,8 +102,16 @@ static int x1e80100_snd_hw_params(struct snd_pcm_substream *substream,
 	return qcom_snd_sdw_hw_params(substream, params, &data->sruntime[cpu_dai->id]);
 }
 
-static int x1e80100_snd_hw_map_channels(unsigned int *ch_map, int num)
+static int x1e80100_snd_hw_map_channels(struct x1e80100_snd_data *data,
+					unsigned int *ch_map, int num)
 {
+	if (data->cfg->channels_map) {
+		for (int i = 0; i < data->cfg->channels_num; i++)
+			ch_map[i] = data->cfg->channels_map[i];
+
+		return 0;
+	}
+
 	switch (num) {
 	case 1:
 		ch_map[0] = PCM_CHANNEL_FC;
@@ -136,7 +151,7 @@ static int x1e80100_snd_prepare(struct snd_pcm_substream *substream)
 	switch (cpu_dai->id) {
 	case WSA_CODEC_DMA_RX_0:
 	case WSA_CODEC_DMA_RX_1:
-		ret = x1e80100_snd_hw_map_channels(rx_slot, channels);
+		ret = x1e80100_snd_hw_map_channels(data, rx_slot, channels);
 		if (ret)
 			return ret;
 
@@ -210,15 +225,39 @@ static int x1e80100_platform_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	card->driver_name = of_device_get_match_data(dev);
+	data->cfg = of_device_get_match_data(dev);
+
+	card->driver_name = data->cfg->driver_name;
 	x1e80100_add_be_ops(card);
 
 	return devm_snd_soc_register_card(dev, card);
 }
 
+static const struct x1e80100_snd_cfg x1e80100_cfg = {
+	.driver_name = "x1e80100",
+};
+
+static const struct x1e80100_snd_cfg glymur_cfg = {
+	.driver_name = "glymur",
+};
+
+static const unsigned int right_left_4_channels_map[] = {
+	PCM_CHANNEL_FR,
+	PCM_CHANNEL_RB,
+	PCM_CHANNEL_FL,
+	PCM_CHANNEL_LB,
+};
+
+static const struct x1e80100_snd_cfg dell_xps13_9345_cfg = {
+	.driver_name = "x1e80100",
+	.channels_map = right_left_4_channels_map,
+	.channels_num = ARRAY_SIZE(right_left_4_channels_map),
+};
+
 static const struct of_device_id snd_x1e80100_dt_match[] = {
-	{ .compatible = "qcom,x1e80100-sndcard", .data = "x1e80100" },
-	{ .compatible = "qcom,glymur-sndcard", .data = "glymur" },
+	{ .compatible = "qcom,x1e80100-sndcard", .data = &x1e80100_cfg, },
+	{ .compatible = "dell,xps13-9345-sndcard", .data = &dell_xps13_9345_cfg, },
+	{ .compatible = "qcom,glymur-sndcard", .data = &glymur_cfg, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, snd_x1e80100_dt_match);

-- 
2.48.1


