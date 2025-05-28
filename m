Return-Path: <linux-kernel+bounces-666046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E0BAC71E7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 22:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068E9502445
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E5B221D87;
	Wed, 28 May 2025 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kc+Z8zok"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0E1220F2D
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748462415; cv=none; b=OjRTWs3O9yh/t9ffEevIav6IaJoTGcVqR/Kiyyml2j1M8A6O6IZ7zR+l7bVSCiYN9LCFmroI2AqeX+suMxnhpgccJLQiQIkadSOoaGBUuwkSsBPgzkyMZDxJiBkR0XUea7bnrI49RDWIhohV4A/LPh7HEgV2wzP6wXJJmCsdccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748462415; c=relaxed/simple;
	bh=0ZRY/+q+W8Hjs6RGmmOVXS/0Gcaj4yO/XRQKw0A/w7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HynWGXitpGyNoD3Nbj302DNsTdblk+2+Z4BKpjEE6sJIcEb2pFX8YEwCkSf29+ZvdBG0yn9demjEm0pjx7W3gOp6RCV9amGLXh0uZmWj+/e9EmqAk8fxVkAw/WQLsLQzWdFW7FlFLCGak6jw8eRo/VqtqxWaS5WFmYx93ZyP6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kc+Z8zok; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4e62619afso26821f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 13:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748462412; x=1749067212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7yDCQi4rHSCnETU9ud9r++MJrTNq+R9cHXXFxzlNlc=;
        b=Kc+Z8zokSQfSKSSoX+O9BcaJvf6OaKxwKmfMF9KHmxlZ2upNYxx/dEvwKN74KJeY0n
         /rVqdC4BjAQRyBNy677tQTUsvdIW8EJN98D8DLgmXH/DRmUZS0RAlvhDuRyHj2eHjWzO
         ykCUZgg7xqk0SmV7+yDKGluGa0ess1L/OV5pKn5VypGEtX8CnHWoACVm9rHrsrEWYjag
         em1JXvuRRRQ3miEGXa26+iZSkssZuLnMXFbyMNiSA3BCJY65/KU8AyKcnmVOyW7bcp87
         x4O5LT/UdThdPGFTODNLTlMzTePfQjqc8JPu+cWV1Ob36nqERHuIu8INarX2U10eVFyO
         r0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748462412; x=1749067212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7yDCQi4rHSCnETU9ud9r++MJrTNq+R9cHXXFxzlNlc=;
        b=VIPG5fzUlWHCzQ0TL0kpF6neJ2BVv21k1EClythgbZVbT4X83QvpU609sdelK07Ndc
         obyqYYr/Zye2F2ZwoYF5gJTiE/syYGU2SA6s3i7wiuUJk1CPTQVwJTy2t4Skn+gO+Xsg
         80Dls9n+sxrC1/7n4YwMAQYbMyWaAEZ8Glw6M3u7HVg5c2zeLwZzGeQYgWIqOPahLqo+
         flQUkh5PXAnGHXVH8tC85n+B5AVNI5s1kdfaTkqxZd5CyyY8KhTQIovMAHmXLMRYaB7V
         2NSPW8eycAzlASltadkSvr5stA9mZbcLMUKOuu1IGXN+ZPJZ9sbpepqo0oeR9DMgLlBF
         UrlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUacnVs/blcKPN/UTy/R6R5gTmu/Vn+GQxH3rBpyzBwBb9qsU/N4YJyVV1iOWZ6746eNEhdXFlJhhza4n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnAOKVuEv3pdoMXUTryPhxcNRZV7puep4BrHVaSEY7wFmbSnL1
	z+dyKoAHik5zX00clzYtV/kDoSj/WCmHdluVoUCXrtdorq5bSeH8yaY8fMdDxGzDE/8IR/3xk9T
	EeRjT
X-Gm-Gg: ASbGncuXkFzUt1tOVHTvAyp/CSdec7hamYtTFYcJSkBGIYz7HXFk1H6MjWaOVYh2toL
	eJbhwk3YM4UQxSmlMfSu5IBvgc9pu0tXVuDbzu0n8jJ0/GFwE111NWYe7XPAblLenMyJLeUKyj/
	UTwaATfpnmnyCxaE7dHUIA//NDBk8moQ/NmcfuZYYJfehHfQxji2pMwVDxvGmEHZPFJPvjmjRrK
	YW+mzANvjZ5VWNCMP0wjwkjVUm2Tuc3FXrnzQRUEzEU67/i20/c8Dz4A722Z9KwGyIWibGHGnBN
	KtVcDmnu1KWyGHKlB2i2n7dqznFZyel0QOZkQPgSA8Ch5h+kCDcIIpYHS3CHqa8dpc8NWgs=
X-Google-Smtp-Source: AGHT+IFQP0FibM1rqz/lOLHDDJIP46KUlhvU3MMzWhlSZjooZREosH5m2BiFsQxW10TootF1bWqdog==
X-Received: by 2002:a05:600c:4f0c:b0:439:a30f:2e49 with SMTP id 5b1f17b1804b1-44ff407200bmr13873405e9.5.1748462412453;
        Wed, 28 May 2025 13:00:12 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44fcbd61553sm53347665e9.0.2025.05.28.13.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 13:00:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 28 May 2025 21:59:57 +0200
Subject: [PATCH 3/8] ASoC: codecs: wcd9335: Drop unused sido_input_src
 field
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-asoc-const-unused-v1-3-19a5d07b9d5c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1807;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=0ZRY/+q+W8Hjs6RGmmOVXS/0Gcaj4yO/XRQKw0A/w7A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoN2s/W7KGWelejUXL5jEOanL3Ib8Zn2ryY+42I
 viAZm3zT/uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDdrPwAKCRDBN2bmhouD
 1w1mD/0TE/pr2WWpzbfzTZpzuf9Ihpzqt5a1AGUtL71i8JsTXwd7jut9/Gm0IH0nme0q1yGZ9dZ
 praHkDhRMtcT9pyzKbMwyz9ZqNFlKSJPWmGG0tA5kd+cSFAOUcqyIVknxv2katMudoqLAXi72XX
 VzqQrT4YVsoP95hFaKGCb0lOnpIiHu56DJKJvdGSPV8SOkVmh45MIILx6SgMXVWfJKnNKITmrsP
 iLTUF2HnE8S5rNM7WCdCxn87Tevk6EREKKWi2BXjLwMPjKYzHGm4sbITJuZ9/Ondk+CZIJGGk37
 I6U9dMaoCm9v5m3MNpIW9e+tLL3h1VIUrqfd/egIrkSkMGZZC+HWN8aL4rPPry604hZy4iIt2+/
 GoN1EA4gtuKpwN9/1fw/5baSiNgZSkW0b8HIXp/VN8XSAJ/Dy3DTv+8fT55ulerizsBTcpo9RC8
 vwIFOktKU74Op6kLo0q2t3TVsCf8YELIge+FEFKbAbORWdq8anQvYDdElWqDxh4JUtI3OzTLb8X
 jGt5qZZIMoNLTh896qRPaEDJKVnKFsjCOBdxXi59aSKFqEjVUjszRZx0ktaQa/xcUwvi0JKSR9i
 iSzmtn7L6KTu2Mh8MRgpkPdkbNSXRJQlMteUkQdPsCw3zshP3vKJjvovpudc7fz6o1mBNfGeA/W
 b6EdcUurjtIG3VQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Member wcd9335_codec.sido_input_src is not read anywhere after
assignment, so it can be safely dropped.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 5e19e813748dfa0d065287494240007d60478dea..1c050b8c19de43cf494583d2c96f50f65aefe567 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -312,7 +312,6 @@ struct wcd9335_codec {
 	u32 num_rx_port;
 	u32 num_tx_port;
 
-	int sido_input_src;
 	enum wcd9335_sido_voltage sido_voltage;
 
 	struct wcd_slim_codec_dai_data dai[NUM_CODEC_DAIS];
@@ -4725,8 +4724,6 @@ static const struct snd_soc_dapm_widget wcd9335_dapm_widgets[] = {
 
 static void wcd9335_enable_sido_buck(struct snd_soc_component *component)
 {
-	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
-
 	snd_soc_component_update_bits(component, WCD9335_ANA_RCO,
 					WCD9335_ANA_RCO_BG_EN_MASK,
 					WCD9335_ANA_RCO_BG_ENABLE);
@@ -4740,7 +4737,6 @@ static void wcd9335_enable_sido_buck(struct snd_soc_component *component)
 					WCD9335_ANA_BUCK_CTL_VOUT_D_VREF_EXT);
 	/* 100us sleep needed after VREF settings */
 	usleep_range(100, 110);
-	wcd->sido_input_src = SIDO_SOURCE_RCO_BG;
 }
 
 static int wcd9335_enable_efuse_sensing(struct snd_soc_component *comp)
@@ -4871,7 +4867,6 @@ static int wcd9335_probe(struct wcd9335_codec *wcd)
 	memcpy(wcd->rx_chs, wcd9335_rx_chs, sizeof(wcd9335_rx_chs));
 	memcpy(wcd->tx_chs, wcd9335_tx_chs, sizeof(wcd9335_tx_chs));
 
-	wcd->sido_input_src = SIDO_SOURCE_INTERNAL;
 	wcd->sido_voltage = SIDO_VOLTAGE_NOMINAL_MV;
 
 	return devm_snd_soc_register_component(dev, &wcd9335_component_drv,

-- 
2.45.2


