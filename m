Return-Path: <linux-kernel+bounces-659599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA759AC127E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 19:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A27B5025C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 17:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B826129CB4C;
	Thu, 22 May 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lfei/3ko"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169DB29ACEF
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935674; cv=none; b=R7VtDqJwTN0yElxfML8EXZxzB59Vp3kGT5O8XWzzHkZlxnqcofVYlnp9ojdeARN5yp8t916xZConLZBIJdl6m5wMo1vGxDX+yFZjYKUsVIIO2oC1fc2OByppkkuh3DyTSG6tSJ8mTzCwwzekUB9FncN2++1gbgdkMtE32Xjf0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935674; c=relaxed/simple;
	bh=S6jZhUI+XAJ2PlE5nePNGPGqQp49fPpI3d6PmNbCvKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5gZhNgb0jGqlInGOvmfVHFE9gaPAgb8f7npdSzDkavvzNB3fq/eQ+nIXYuN6eXcxntpvS4wq5iwfnNNwyGtb6XJe/no4ZZ3gOGIEqowqAHUDQSeDUmE9Wv8LOkdN88TpozMEmMsx+5HrWtdg3kP3lKmDEPLd0F5FIecs5PPWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lfei/3ko; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442f9043f56so48989855e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747935667; x=1748540467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLq9dfH5kw3m9MDlrQzYgeHTL3bjAaliqFaw63+wHMA=;
        b=Lfei/3ko1TmKGManuWlHdW+YkoNPXj/I5U199qy+aVnF0Rizf2NoUjzrKolFl4shgk
         tcexM70t+slg5iS+feIFy6chTIOj4X0gwMvRWiNku1BzK+m00Ke43zw0zwTe7RHCAuhP
         9Dnn3MRFOwuffPrFtrIV2zP50d23ijDbk0yPN5+XjKwVSkmMYwHCkqvZMhcuGPCrE5Kw
         EIrOsDyykJGJA0FF+a1C3bHiIWhaobbD38VYyxg7iCRAlKGxMaohDDwBG6EVDaYt33iD
         GBHJF+f8GyX3dAc7pDZRQYeBR4h/u3Q+zIqbB73SvYahUM6QUv2v/cOszdXtX/UoUOTc
         FBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747935667; x=1748540467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLq9dfH5kw3m9MDlrQzYgeHTL3bjAaliqFaw63+wHMA=;
        b=UFvf/FIiEBFn4Zc6WsDZh8bPZbAgmKz9EpSRJp2AKGB2NE6K/rRbJZ60BK43PZC9Q7
         8c164Hj1H3ONK0ZsGM71nJzSiQqMPXiEH6DgMu+9SLeMmEmcHld8Hg7lvEngeMjLwjp5
         8qbMA2MjeZ+jBVxWJlMg2a+SQ4Vlgf6cuWvObKDuE9FdjQCdvmDnb1g6Qbk/0ElTyw7+
         ha+3oYx5o4Dv1qXNQdGmMOMzLOwDZyDJPw2cviqSZi7PTAVOeGwxMJuhBLiHBTyB7ZO8
         7Vq9Lv9c7Er+3l1T3qLbCwUUexSFJBZ9j6dw/PZUzCWqrXwx8auC8yErC5eM2X9N+Aet
         szRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOtZc8v18p2enADTD+qT/kl6+J6Mcu2UqoLqVJR7yIvpyFRThi9Dp1MxGjU6iu9+83HTuNwT0jcDm3IGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7y9MmxWwOgsHEXMjAXkMWvxQWBkcOMv+VMqMg9OKojgb8YiOs
	TKMNbWPOilnnBxJbWLZm9kFU0jsOoqOi+vhtam2aVjRE6SEyF+7rDIJ+8lYp4ji1eXY=
X-Gm-Gg: ASbGnctyQK/79Wzlnrs046khMVHEqRG06LQ/g+kkOoa+NvQXbdMpcLy+kfkU2MEmFmH
	/NAkQXHKb/wKFb/3NtncOKe8Mw6KD3Iibm1wdYvcqz2qE/t58/3eq60xgOVppKTgaGw6hW7hF8r
	sUfSlXi3+ji6v1Z0IXiV9cLZr1PLp4GE939r/lUmDkVp9ABapZg8uWMy1LrGDDLzz2kZHtYgmUJ
	m7vnHLyJfPYsCd56TfDU/3OPzJpueEp+2rT5qqoJKHJmTXfCRpEoJnovaIWpW/gZzGCWCxI8k/I
	Div/QcApsAxmmh4pmpbrIS7aPZE3BaSp84jnDptxEzRZqFzW8EXURQixVV0=
X-Google-Smtp-Source: AGHT+IFHZ7GRnEumz9miXfhQcVTeLvcllCBZO2l6C+Fp4Xcd0b3neA0piaRSIcSFkbEs+4+lyCZ18g==
X-Received: by 2002:a05:600c:4ed2:b0:43d:8ea:8d7a with SMTP id 5b1f17b1804b1-442fd67504emr198840965e9.28.1747935667099;
        Thu, 22 May 2025 10:41:07 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7213:c700:6c33:c245:91e5:a9f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7bae847sm109563195e9.36.2025.05.22.10.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 10:41:05 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Thu, 22 May 2025 18:41:01 +0100
Subject: [PATCH v3 11/12] arm64: dts: qcom: qrb4210-rb2: add WSA audio
 playback support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-rb2_audio_v3-v3-11-9eeb08cab9dc@linaro.org>
References: <20250522-rb2_audio_v3-v3-0-9eeb08cab9dc@linaro.org>
In-Reply-To: <20250522-rb2_audio_v3-v3-0-9eeb08cab9dc@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, Mark Brown <broonie@kernel.org>, 
 linux-sound@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.14.2

Add support for audio playback via WCD937X/WSA881X. From DSP
and rxmacro the sound stream goes into AUX port of wcd codec.
wcd codec decodes digital audio into analog and outputs it to
single wsa amplifier hence only the mono configuration.

The audio playback is verified using the following commands:

amixer -c0 cset iface=MIXER,name='AUX_RDAC Switch' 1
amixer -c0 cset iface=MIXER,name='RX_RX2 Digital Volume' 80
amixer -c0 cset iface=MIXER,name='RX INT2_1 MIX1 INP0' 'RX2'
amixer -c0 cset iface=MIXER,name='RX_CODEC_DMA_RX_1 Audio Mixer MultiMedia1' 1
amixer -c0 cset iface=MIXER,name='RX_MACRO RX2 MUX' 'AIF2_PB'
amixer -c0 cset iface=MIXER,name='SpkrMono WSA_RDAC' 1
amixer -c0 cset iface=MIXER,name='LO Switch' 1
amixer -c0 cset iface=MIXER,name='RX HPH Mode' 4

aplay -D hw:0,0 /usr/share/sounds/alsa/Front_Center.wav

Cc: Srinivas Kandagatla <srini@kernel.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 4b878e585227ee6b3b362108be96aad99acba21d..1e2b9d2516b62e2e80c40ed6c3a0c4548a02630c 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -111,6 +111,8 @@ sound {
 		pinctrl-0 = <&lpi_i2s2_active>;
 		pinctrl-names = "default";
 		model = "Qualcomm-RB2-WSA8815-Speakers-DMIC0";
+		audio-routing = "IN3_AUX", "AUX_OUT",
+				"SpkrMono WSA_IN", "AUX";
 
 		mm1-dai-link {
 			link-name = "MultiMedia1";
@@ -151,6 +153,22 @@ codec {
 				sound-dai = <&lt9611_codec 0>;
 			};
 		};
+
+		wsa-dai-link {
+			link-name = "WSA Playback";
+
+			codec {
+				sound-dai = <&wsa881x>, <&wcd937x 0>, <&swr1 3>, <&rxmacro 1>;
+			};
+
+			cpu {
+				sound-dai = <&q6afedai RX_CODEC_DMA_RX_1>;
+			};
+
+			platform {
+				sound-dai = <&q6routing>;
+			};
+		};
 	};
 
 	wcd937x: codec {

-- 
2.47.2


