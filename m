Return-Path: <linux-kernel+bounces-666050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0711AC71F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 22:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25B23A8EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 20:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AD2223DDD;
	Wed, 28 May 2025 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XaZNYvoG"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E5B2236F3
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748462424; cv=none; b=N/GtnfsTwg5OIjUPOUOV7CS0DGE1+Ov27b2JrUQ7a0tNcJBzIDJ27Psn4qEAwGifmbWMga9FX8ZQLgkZd9bl4TaGRLFKyG1pTA2DZg8zlQVpwXm5Me3cSm/KcohJOXHyqG7iYGt2TFU8G70pNqQQdwwHzdQj7+JFbsXERgqYQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748462424; c=relaxed/simple;
	bh=vpHnKSsMPwOT5apYVShhmLQTAWNAh/9Zf7Yg24ClShA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mhg+rrdy8N96cgQJMwhdU+E+Hwkkx4UhK1xl1lvOKslLokT+tVK6DJOzm6VLrNPZaiZ8l+U0FEyRb27gMeiY25Ej7ji28ySVPp+XsUNBtpY+52/BDoMRBDagQQ8dXFOsnAZ+pOd9EEDK2JGRjVEyo31NpPFQI2bJ7CnRW8VuyZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XaZNYvoG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4e749d7b2so37151f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748462421; x=1749067221; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhFsa53Dn3tZ/YQodrCRFl/D/vPq2gHvZA39y3H6S1o=;
        b=XaZNYvoGPgIpE2BoBu5v833ASfjIiQgifzIifW2naDWNwRqiBekhhuWpkliJ4FYBy7
         7yc+xwEgzCBGXbLMpnFYfIKiQ3t/DQT0EhgN0LGng9j7SU38EVorV0zwEJ0neaxHBDNt
         xzPfdO+6yGSBMXavDWkd71v55C2WrL/fkZ5XW378szujaOgHkkaODEgbKb818wW023aa
         LCEhi2qt+ycOZ3C41+Wjm4/fHY35tMyVGAUWN+AyUtC9brUJzHl4dd3ChG0U5SL64dKL
         c6+cwlXmBhn5qp8MlbbJxDNbx6RQimPOAwjhPNxK7/2Fe6kpjxFs8SA1XOIqZ/J1eYHV
         VQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748462421; x=1749067221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhFsa53Dn3tZ/YQodrCRFl/D/vPq2gHvZA39y3H6S1o=;
        b=c0AIhszcsn6kB8e+mEwYUwyMqZfdDTi7caOZwd3GjSqDgdXFPhtMRzypKIoa13RHV+
         mzyStufGaXj5JL669jNBmRxghkR+dnLNz+wRUB48Y4SKQfXHCLSnYnxASCr2VMkYO0Cn
         TfyCIoLZTl595FXQepZgoULCME26YwTSamUN2RK3rrQKdCFJ7WBw1n1QShXV/sI/c/qR
         qKCVu/P7TPv3u816Luc1PDDt6HIb4zvv5iUH9OSH3y6NQdD3xozC7CosN3t1RLRvoDYB
         Me6l6I7HheyHL10uYWt07mW6a1V9bpUsiuLN/DrF5OvCOtRKkrqhssOFma3iadMPwCTI
         232w==
X-Forwarded-Encrypted: i=1; AJvYcCVXwGWhZMoYHwN3lO2TFzyis82suYnd6xYgRVfjp3uHjNwezteFi//BFM+66t6cpbh7DB6SAsxLBIsOObA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzck1m1/Qe1n/YTh0AFbs4Gyro3YFIqsi6/0JMScYBqFtFPj8en
	8ASQnuGDCNUZ0pzGnAI3quDTYPUcXf5O2dwSZCCL3Ukk/rbFlG4yrnkft2stRNNX1gux9JoSqkf
	aLjTF
X-Gm-Gg: ASbGncum3tydCdNHt2vMqCve94LmSwhGxdv7/sVTjh8AooPl06aGoGas5/OcqYyFfpw
	l/+SoopCC+xOkgoRij1ndcFVERKbEnF+4ZzQt2c+QAFkA29quYASQHMk5tRDKHeD6YwESetvDeX
	HoseOMroM+w0nwGiVPn/2/eJ0TpPYnFskIqLJH9ZZMt52YL68VfXpKsCtlEHrmbt3V084jQ/jIP
	IOCYW8/Uhy3AEUDDrsealG9nA4LD2Vhx2OVcHCxBrUCGlnBrFNmClWP/5rLKf+m6J8aKd3q7k88
	iPCs1Cl7C4bmA+6IB/wdhiqn6OxWfwTUS1eftJVJ5Cr3cSmEALP1WEHsUQq4F67akrqyVGU=
X-Google-Smtp-Source: AGHT+IFgK2K2RWnYXZ98CP7PqDkbOJ7HD/Q61UfK0JTIS6/x1cpTvbtFdyCFL4yZitYpbOagT+DMiA==
X-Received: by 2002:a05:600c:3b99:b0:439:8c80:6aee with SMTP id 5b1f17b1804b1-44ff4071f7dmr15017665e9.4.1748462420725;
        Wed, 28 May 2025 13:00:20 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44fcbd61553sm53347665e9.0.2025.05.28.13.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 13:00:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 28 May 2025 22:00:01 +0200
Subject: [PATCH 7/8] ASoC: codecs: wcd938x: Drop unused variant field
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-asoc-const-unused-v1-7-19a5d07b9d5c@linaro.org>
References: <20250528-asoc-const-unused-v1-0-19a5d07b9d5c@linaro.org>
In-Reply-To: <20250528-asoc-const-unused-v1-0-19a5d07b9d5c@linaro.org>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Oder Chiou <oder_chiou@realtek.com>, Srinivas Kandagatla <srini@kernel.org>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2615;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vpHnKSsMPwOT5apYVShhmLQTAWNAh/9Zf7Yg24ClShA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoN2tCjfNAV+kCU10X2cqnxwpT+fWymWyuVDFrl
 /mM6y3R76iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDdrQgAKCRDBN2bmhouD
 17OSD/9sy1aTm6SlmWbrKPTB24a9SyULGvFc6f8kqmmjgsEgGsx7bS2Sshyxn55QGKOe0ABB2oK
 kx0dUHpTHoxUnYz1QLaAVl9uHNHNkZkvFx9YfpJkVSJy1O5nK83aqEunkX9blBQ0c1vnFegsPuk
 3oygNoAGFieGEpTLsGsHEndt5D+uRBdqWTqwi+BNSom8HvfFN5z21tmO0lRi0dva7fiGwRuED/S
 Fdx+hpru1FRbJcBAUcnycfOdK3Etc3XAw6gX1gYsERZFT3K2llZoggkubN/jbC9AkDEYYsTHJxo
 WwxIT5bD18zwQkirmjAeP4oYZ7bUKxsW8VllKXlpNrvsvqEJ+mubb0RuYO1OyeXyphex198W4GH
 87yClKM7xjncSPQsTvhavYxQMaNZui6lcQX6Ri8YAuUoIKQns+c7AG5OldMjoKgZC/RnEELjIoP
 UXc6AeQxYyp56GOQ6tna7ra+FoutpkwAXNX80pvSYaygp2Ca2Ol5Zr7y+IKdWXcO0uQdk8HZDjP
 GNnvMh0p7TgTTtxYkn0SO015It+ceZYz91KYO1j9glfiZWOBFnaooLovnMMWvKD9a6hJsLjHeaL
 kmTfNTMgyZWy1hVL4iQ/+vmk6wG33yxjLIUjyLikKYV12gIehXJEahkLId6eIxy7ozrsP9sExAG
 Jpwt+bKhJF86kUw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Member wcd938x_priv.variant is assigned in probe() function and used
immediately thereafter, thus it can be just a local variable for less
variables stored in 'struct wcd938x_priv' device-wide state.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 43347c14070ca6dd8035b0c290f0dacb0326122b..5a751056a98a5d4cc5716aafc25af27e3ab22786 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -168,7 +168,6 @@ struct wcd938x_priv {
 	u32 tx_mode[TX_ADC_MAX];
 	int flyback_cur_det_disable;
 	int ear_rx_path;
-	int variant;
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *us_euro_gpio;
 	struct mux_control *us_euro_mux;
@@ -3044,6 +3043,7 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 	struct sdw_slave *tx_sdw_dev = wcd938x->tx_sdw_dev;
 	struct device *dev = component->dev;
 	unsigned long time_left;
+	unsigned int variant;
 	int ret, i;
 
 	time_left = wait_for_completion_timeout(&tx_sdw_dev->initialization_complete,
@@ -3059,9 +3059,9 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
-	wcd938x->variant = snd_soc_component_read_field(component,
-						 WCD938X_DIGITAL_EFUSE_REG_0,
-						 WCD938X_ID_MASK);
+	variant = snd_soc_component_read_field(component,
+					       WCD938X_DIGITAL_EFUSE_REG_0,
+					       WCD938X_ID_MASK);
 
 	wcd938x->clsh_info = wcd_clsh_ctrl_alloc(component, WCD938X);
 	if (IS_ERR(wcd938x->clsh_info)) {
@@ -3115,14 +3115,14 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 	disable_irq_nosync(wcd938x->hphl_pdm_wd_int);
 	disable_irq_nosync(wcd938x->aux_pdm_wd_int);
 
-	switch (wcd938x->variant) {
+	switch (variant) {
 	case WCD9380:
 		ret = snd_soc_add_component_controls(component, wcd9380_snd_controls,
 					ARRAY_SIZE(wcd9380_snd_controls));
 		if (ret < 0) {
 			dev_err(component->dev,
 				"%s: Failed to add snd ctrls for variant: %d\n",
-				__func__, wcd938x->variant);
+				__func__, variant);
 			goto err_free_aux_pdm_wd_int;
 		}
 		break;
@@ -3132,7 +3132,7 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 		if (ret < 0) {
 			dev_err(component->dev,
 				"%s: Failed to add snd ctrls for variant: %d\n",
-				__func__, wcd938x->variant);
+				__func__, variant);
 			goto err_free_aux_pdm_wd_int;
 		}
 		break;

-- 
2.45.2


