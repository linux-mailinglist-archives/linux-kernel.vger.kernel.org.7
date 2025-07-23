Return-Path: <linux-kernel+bounces-742171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F507B0EE40
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8993AB5C0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D76285C80;
	Wed, 23 Jul 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jQ8AgMYU"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25F827A907
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262421; cv=none; b=UO49aZbDtNFlr7VDH8/SfTVBi3oZPm9Yasl735EFODn08EdvlVhkdfZukZ1VtLvaY5GGS5UMvY3PJPalfwMC9xzRQQo9UFDtCV93NIGQi4oXXGYP4uEatBD4w5Y8jryIsWDRXIletpP9ilU/GICuXMn1LaDf/3RVJp6a62Jx+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262421; c=relaxed/simple;
	bh=ODou1hMcvFPHXSy6uZveAERgEdp3OytuUqZprLeJYxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KLx0q0s9ZFmS+dmCSKq/xO10JRbYZOaOCzPJysvORdxsF4uoyJ180IwRzESJ3bwP60IAuBDSH4hszjSPW60FIW+lbI4KzaDGI32lwoB43ueiUgG7hXvpLAUfbkgbwK5RZLn5Qrjboq8y1RgBIQkGSwqCbwBLXdUEsiyGXs81NE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jQ8AgMYU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso3443684b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753262419; x=1753867219; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5ohlcswCHUarwQMsmPE06bAiOj6zoZwHyM9beSDSD8=;
        b=jQ8AgMYUKKOXKNECopVUMRC8E0i1bbB6nHJ/gMouBVIL4JrHbJ/PXnfZUMSIMj0yD3
         dfHazOjHkGJb0+436TRMPdW0+OCBBKLRZyn4oWdekESSy3zBcNgEBGke2Z08S0g6hQSN
         tABn8r83FvGEvazRJWz8kImu34eWmfuhogT8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753262419; x=1753867219;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5ohlcswCHUarwQMsmPE06bAiOj6zoZwHyM9beSDSD8=;
        b=dr5Cie7hi/c9ARsyozd46LX3P/nCtPlIzM4AIZZ4ob0tF2o5Isij47eM5SIIm4KNKI
         wYlb4ZHur2L4Y0zPOuQPTuoFYnWk1C2MIOaKy9bcDeyBnfUsaQeI9S3Vkk+GZVgY2WWA
         44214S1p86k2nyLWljH0gNMZtFU+WoSql2cyn6mMf23HSMOOb5KBkDbeLFApaiIfA4td
         RJrHh/1ElMfDGJlBkZUptJOeM52aVOMWafrju2cO40JbAcQcC/Mjb0Z76K/ha8QdS7ym
         za9lq6v5chRLU4CH3SkJLsfATVmxbAX/r7/ZZfSYJujGmUK83uZ5lQKbBAyfkfxmGpZz
         U45g==
X-Forwarded-Encrypted: i=1; AJvYcCWZ7UjX6J/gnCTcra68j39uHD0ETMQ/xLAukPX3uEv++vRuCuPAAWeR62zkRmBlozyUzklRKPAfvmGKiRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY3mFDcYRLnA+doWy5yU3cZxNCaRnsQ6cRf3Xn2Ji7+IfwV3X5
	oAt2xibHdzFbuldqDb4cdHnfVkBlvlhoaVD8y27XGx92bQQD2fS0ezacaYDuW619PA==
X-Gm-Gg: ASbGncuXSrPKVepVcEI7uIGQidmOnr7EEI/Scfz8T7mukxhn+/BCAPzZ//mxUtxG6Xn
	Lo3OccZ5gErOjtvyawRD7UDpcsA/G+0hGqci7wHGSAnbpwJbrqdCoWNe5To1kM8ZABm/mpWyLAR
	Fg527xHKCmtgI03cIHAfTjXmZN+zwYDc11seY91j4QW01+q7wTLK1vNWcN2pehgzeS9PXuITiWh
	skRWmuLEdVVCMDQgHtZOVSX6FZ7CEWBhHqPGgiLZusZWfx4AJ9NWI6qSm9LCeQjO3HscuY2/Bx+
	J/xLoM7NMD7mmy+q0XSSmg20bDqFTowZqW4Voqg25wnsdoPiECJv0iOHIsk+FHkGztBcjwWIn7c
	/qn9jo5I+ooXEOFOSGjuWkpUOzdIgz3ravkLhiQaPfU34iWNg179aBdpzWoQR
X-Google-Smtp-Source: AGHT+IG7/nlgACJp+VfqCvvLKN8+mhu1LidQEOhNCH9PEZufUuMCmSN6xu9KROi8r7za7e9D6ENl4Q==
X-Received: by 2002:a05:6a00:a0b:b0:74c:efae:fd8f with SMTP id d2e1a72fcca58-76035df4f41mr2885545b3a.15.1753262419160;
        Wed, 23 Jul 2025 02:20:19 -0700 (PDT)
Received: from htcheong-p620.tpe.corp.google.com ([2401:fa00:1:17:5a52:716c:aaf0:9c18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbb71f6bsm9297359b3a.124.2025.07.23.02.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:20:18 -0700 (PDT)
From: Terry Cheong <htcheong@chromium.org>
Date: Wed, 23 Jul 2025 17:20:11 +0800
Subject: [PATCH] ASoC: mediatek: Use SND_JACK_AVOUT for HDMI/DP jacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-mtk-hdmi-v1-1-4ff945eb6136@chromium.org>
X-B4-Tracking: v=1; b=H4sIAEqpgGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyNj3dySbN2MlNxM3WSLNNO0FKM0U3MTAyWg8oKi1LTMCrBR0bG1tQC
 Bxi+xWgAAAA==
X-Change-ID: 20250723-mtk-hdmi-c8f5fd2f5740
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Baili Deng <bailideng@google.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Terry Cheong <htcheong@chromium.org>
X-Mailer: b4 0.14.2

The SND_JACK_AVOUT is a more specific jack type for HDMI and DisplayPort.
Updatae the MediaTek drivers to use such jack type, allowing system to
determine the device type based on jack event.

Signed-off-by: Terry Cheong <htcheong@chromium.org>
---
 sound/soc/mediatek/mt8173/mt8173-rt5650.c                  | 2 +-
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c         | 2 +-
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 2 +-
 sound/soc/mediatek/mt8186/mt8186-mt6366.c                  | 2 +-
 sound/soc/mediatek/mt8188/mt8188-mt6359.c                  | 8 ++++----
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c    | 2 +-
 sound/soc/mediatek/mt8195/mt8195-mt6359.c                  | 4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index 7d6a3586cdd55734358f66428467466ae756da38..3d6d7bc05b8721a27483d5d7e51ba87fe7363b8b 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -159,7 +159,7 @@ static int mt8173_rt5650_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
 
-	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_AVOUT,
 				    &mt8173_rt5650_hdmi_jack);
 	if (ret)
 		return ret;
diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 3388e076ccc9ee4d372713571f459cff81dec1e5..983f3b91119a9253796c6017bad155161c747904 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -378,7 +378,7 @@ static int mt8183_da7219_max98357_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 		snd_soc_card_get_drvdata(rtd->card);
 	int ret;
 
-	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_AVOUT,
 				    &priv->hdmi_jack);
 	if (ret)
 		return ret;
diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 497a9043be7bb62405b9ec3b0b4a9e09e0153be7..0bc1f11e17aa7a40688d706966dd0bb1ed414751 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -383,7 +383,7 @@ mt8183_mt6358_ts3a227_max98357_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 		snd_soc_card_get_drvdata(rtd->card);
 	int ret;
 
-	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_AVOUT,
 				    &priv->hdmi_jack);
 	if (ret)
 		return ret;
diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366.c b/sound/soc/mediatek/mt8186/mt8186-mt6366.c
index 43546012cf61341ad87d9084465af4a430c96230..45df69809cbabf7af571576d230bd44dd9d89f1e 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366.c
@@ -362,7 +362,7 @@ static int mt8186_mt6366_rt1019_rt5682s_hdmi_init(struct snd_soc_pcm_runtime *rt
 		return ret;
 	}
 
-	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT, jack);
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_AVOUT, jack);
 	if (ret) {
 		dev_err(rtd->dev, "HDMI Jack creation failed: %d\n", ret);
 		return ret;
diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index a2a76b6df63118a016ca414c39943f7a30f27a71..e12537c400e5fdd7565f8322470997f30947ee26 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -250,14 +250,14 @@ enum mt8188_jacks {
 static struct snd_soc_jack_pin mt8188_hdmi_jack_pins[] = {
 	{
 		.pin = "HDMI",
-		.mask = SND_JACK_LINEOUT,
+		.mask = SND_JACK_AVOUT,
 	},
 };
 
 static struct snd_soc_jack_pin mt8188_dp_jack_pins[] = {
 	{
 		.pin = "DP",
-		.mask = SND_JACK_LINEOUT,
+		.mask = SND_JACK_AVOUT,
 	},
 };
 
@@ -638,7 +638,7 @@ static int mt8188_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
 	int ret = 0;
 
 	ret = snd_soc_card_jack_new_pins(rtd->card, "HDMI Jack",
-					 SND_JACK_LINEOUT, jack,
+					 SND_JACK_AVOUT, jack,
 					 mt8188_hdmi_jack_pins,
 					 ARRAY_SIZE(mt8188_hdmi_jack_pins));
 	if (ret) {
@@ -663,7 +663,7 @@ static int mt8188_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_component *component = snd_soc_rtd_to_codec(rtd, 0)->component;
 	int ret = 0;
 
-	ret = snd_soc_card_jack_new_pins(rtd->card, "DP Jack", SND_JACK_LINEOUT,
+	ret = snd_soc_card_jack_new_pins(rtd->card, "DP Jack", SND_JACK_AVOUT,
 					 jack, mt8188_dp_jack_pins,
 					 ARRAY_SIZE(mt8188_dp_jack_pins));
 	if (ret) {
diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index bf483a8fb34a482a76b1c8d799b9e9c8472d0f57..91c57765ab57b2d556d82629b98a36f837b3c995 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -368,7 +368,7 @@ static int mt8192_mt6359_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 		snd_soc_rtd_to_codec(rtd, 0)->component;
 	int ret;
 
-	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT, jack);
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_AVOUT, jack);
 	if (ret) {
 		dev_err(rtd->dev, "HDMI Jack creation failed: %d\n", ret);
 		return ret;
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index e57391c213e7d2bea375cb6006927af3abf503da..7b96c843a14a5b461b9e9a7e7026252e8a1ce19c 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -360,7 +360,7 @@ static int mt8195_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
 		snd_soc_rtd_to_codec(rtd, 0)->component;
 	int ret;
 
-	ret = snd_soc_card_jack_new(rtd->card, "DP Jack", SND_JACK_LINEOUT, jack);
+	ret = snd_soc_card_jack_new(rtd->card, "DP Jack", SND_JACK_AVOUT, jack);
 	if (ret)
 		return ret;
 
@@ -375,7 +375,7 @@ static int mt8195_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
 		snd_soc_rtd_to_codec(rtd, 0)->component;
 	int ret;
 
-	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT, jack);
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_AVOUT, jack);
 	if (ret)
 		return ret;
 

---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250723-mtk-hdmi-c8f5fd2f5740

Best regards,
-- 
Terry Cheong <htcheong@chromium.org>


