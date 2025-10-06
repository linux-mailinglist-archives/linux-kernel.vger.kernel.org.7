Return-Path: <linux-kernel+bounces-843351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC31BBEFE8
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C8CC4F1436
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C9A2D8DA6;
	Mon,  6 Oct 2025 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gF9D1oM4"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5D264F9C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775852; cv=none; b=KbYaR8AUCnRW6Kif+9UyDpkCaLTmjYJaKqPu0GhHUD/nNqUtzkI4fEHqZOUKl5L/0mq+I6nghOXaYMYoXNaiwS+jwVNZDjUfZk9ubpjn9wOzd95ToCbIbIZLX3fwIDeT1SfC6DIrKEaVTnPd/qz9kYmfC2t/98BoSLFza3G37L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775852; c=relaxed/simple;
	bh=6hz0qvxt77MtIJiKbaXluGcDuauBeIYpemWB7FJpVLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aiGsuq4f4B1AyZau0BFvNwKcIZD84AUNBno+fBW4DWBc6wXuU2uby7PFcIGWzlKJNfFU99gKaxUjf/nvyz3U595NQFFuvqVA0SvLa7GgOb5shz1xfl0uZONS/skYivkNgxXkaYQ565oTf1NktIHhMms8vxc+wUBSCAdyx6aIW9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gF9D1oM4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so41648385e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759775849; x=1760380649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g65eFFR0+zG+/W+NEubGJeEkdLvDm61jkb5dtvjzSQQ=;
        b=gF9D1oM4yxe3/kqbYtViPOv6BYYP//ERvAo9fJIKnsmqrT7d24aYSbj2eeeV29sjK1
         oIxfSo/92D3J2wrrAJdQq1uIo6LGwa4j0uuH4s73+9ow8CE0InBBac+iJ99Ms6k42Uh7
         mKzkjzITFQ5Hkg27/km8/eyTcJSDKzZLDNg5qdylFcpF45nDoWYUe9pCg2NOYNiDhU4p
         H+387tJtYDYDCCeu+2Yopolv6vr7akBPvtWCGI7W7i/nMf5FGQ8RQpsFfKL1S6tRVSTv
         GrP2v5YIFhMEESPvBwxMpcoCN9ge6nPCZFwOC2RQvHeIhKpE6v2OYaB9A9TBCthfKgmH
         i13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759775849; x=1760380649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g65eFFR0+zG+/W+NEubGJeEkdLvDm61jkb5dtvjzSQQ=;
        b=rF1v3pxkg0FPlBuQPw9vLT3bynMPCCYAGJWQZ8MxHGqaBvGxYYJ7zeIrnwVL0trAGl
         wVKfonUZG8DTrIS0o2t3npwKZjRLZVkA9udMzYwHH3AZ3+oDYUOWpEaWYRVuUvlh1SvZ
         xTDp1zhk+6huUauLaDQQ4fIFUu4pCYJSST+W29MtzsKeTGxwIkI2apkldiaNARGFRifI
         RLII6kcRGh6FW8XuvPpWxS8txJ5xv6i5yMNurCbrPkrrwdTh4bn+3y2C7mi3j0vCMeEa
         CO21W2PZxIANeAxwo+V0JMWgag1WBG3633pJfytJy1z+5tEtMnWohDllBdtYwipM9Y/E
         DaBg==
X-Forwarded-Encrypted: i=1; AJvYcCXolE7wehR37NEz71FZCL8gbJdEKzpOPeAKrBspUEEpvZd29Urv13RgoyejoTvSmaaOTOxsOr9BFPyMMig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3MYb8PzpR1dd/kBXvUnX7Kctr9TePt6b22UhNITv+QRqzLKmm
	KsErl1V4Ysqp5JE+UJf9UaeEkS7PC5iSrvc6bunA3WkcHnkfEdXS3GaiantFJu2x52o=
X-Gm-Gg: ASbGncuTyNMxZyPATh8Mb8FIE/4ZblbcKCmx6+FJE2d0UzsRQBaFrm9SFvjoaxepRdJ
	8xUqqQOKEjFvTAvpTbVmaqhG9KPLp6ITGopvdNbovJO3yS3YXBw6/9WnOK+uVL0AQHeAZB+oTXP
	Kzs0FRpS6iBCGD5rH7EjuR0SadkmFgpcV3ERsQ4tESKweZb38qlOLtb3s6lt/vcTGk9SfaymYNR
	A9JPY6XeE27hnfxMx1GTxs5AmNvU3Cy4qzzzHW7JsVUqQsUYHuqPCydYwav87fo2Nt7d//ZVySM
	JXtUf1MTOxYSyWFjSPfx2IRP1C38PmWSnTJfoC4tKOuWAr4lL4WVbm7f6wJCQ3Hnehh8EmHrSAd
	wm+yII43xYhw5DnEswty8G8f0b3IsicQImsm6/qGMW6tYuZbvRwrkS5Ep76qvAvGXZq32rCU=
X-Google-Smtp-Source: AGHT+IEZnmBDj17wLd8kF/rI3tyOfZYroC25YcqmoP9Cjvk6oBwv8ZmWN7YLuLixUXR90j8jKDAYBg==
X-Received: by 2002:a05:600c:1d05:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-46e711002damr81114905e9.1.1759775848917;
        Mon, 06 Oct 2025 11:37:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a022d8sm254997085e9.12.2025.10.06.11.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 11:37:28 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 06 Oct 2025 20:37:17 +0200
Subject: [PATCH RFC 4/6] sm8650-hdk: Enable I2S for HDMI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-topic-sm8x50-next-hdk-i2s-v1-4-184b15a87e0a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3235;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6hz0qvxt77MtIJiKbaXluGcDuauBeIYpemWB7FJpVLM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo5AxjxRdUqm5pvbHIuG32qXOj+QtkE+8x3PwNiLst
 efPkzpuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOQMYwAKCRB33NvayMhJ0UXeD/
 465eN/BuPQwEhzyrNcdAUzHuCuS2G0zvr3e3oatLr127hHgCn3Gq4ue9EBTg9yLmiNd7V51hc708K4
 iNU6L8DNAjbBLW/lxWTO9xvcLxu63il1l4EqpxU2RuSktQMZBsv/zruq0LFSdDLZf6wZ/D/p3vucsr
 gledYwOH8aLmPGxuo1tyEQ/CO6GLIlXreYIIMJDB87cHt8ImEg1B05m07STqLYtJZK0aqeuGRDbDXO
 y60j/7ueQlmCTUQx7QuTANgo4ukcRYKL8AzLMkL2xPyoW79qEni2aVx3YnUZSbk1j3IyOnRBn8V/RW
 LBOYKGsa/+5CyPfHlTqsa+zBtKap27dy/1kZ+kaxZxeqV6ide4aKxuzx9+y+ejPug2IjUsxVoWAuYt
 7CaUeyTbSH6rLKdMppHsOVfoH8Dn4Zh2B9AWwDoJVTpKA+AgxQfaVPSyxwthXxmi+C1m6uMyaNAsqK
 D9gBTuTYI/9cWpH7JqIyJogq3kt410C0sLQIahTEij5f+YLTSPR6LeCOtKlu5o4z7ugillCnYjIuUN
 F7ETBWUyewO8usM49AYbU2roqKHYSgI6CE4lTR/UWrxwTfhD3JOA0jgUjCcod2khNQclDHxtHdOmDF
 LD5lRGeN5OAHHxihE14WcuO05r4XCWnyrBfHncZtlItlMr/C9TW62PkNFUsw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the necessary nodes to configure the right I2S interface
to output audio via the DSI HDMI bridge.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 30 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi    | 40 +++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index 87d7190dc991b11f5d1162aabb693dcadd198c51..1286ce95235d5544322a1877292cbdd426298c11 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -171,6 +171,19 @@ sound {
 				"TX SWR_INPUT1", "ADC2_OUTPUT",
 				"TX SWR_INPUT3", "ADC4_OUTPUT";
 
+		pinctrl-0 = <&i2s0_default_state>, <&audio_mclk0_default_state>;
+		pinctrl-names = "default";
+
+		clocks = <&q6prmcc LPASS_CLK_ID_PRI_MI2S_IBIT LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+			 <&q6prmcc LPASS_CLK_ID_MCLK_1 LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+		clock-names = "pri-mi2s",
+			      "pri-mclk";
+
+		assigned-clocks = <&q6prmcc LPASS_CLK_ID_PRI_MI2S_IBIT LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				  <&q6prmcc LPASS_CLK_ID_MCLK_1 LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+		assigned-clock-rates = <1536000>,
+				       <24576000>;
+
 		wcd-playback-dai-link {
 			link-name = "WCD Playback";
 
@@ -218,6 +231,22 @@ platform {
 				sound-dai = <&q6apm>;
 			};
 		};
+
+		pri-mi2s-dai-link {
+			link-name = "Primary MI2S Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai PRIMARY_MI2S_RX>;
+			};
+
+			codec {
+				sound-dai = <&lt9611_codec 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
 	};
 
 	vph_pwr: regulator-vph-pwr {
@@ -853,6 +882,7 @@ &i2c6 {
 	lt9611_codec: hdmi-bridge@2b {
 		compatible = "lontium,lt9611uxc";
 		reg = <0x2b>;
+		#sound-dai-cells = <1>;
 
 		interrupts-extended = <&tlmm 85 IRQ_TYPE_EDGE_FALLING>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index ebf1971b1bfbebf4df5a80247a6682ac8e413e3b..7cf5073a29ed4aaf72662a4e05ba1c6bfb118a3f 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -6203,6 +6203,46 @@ wake-pins {
 				};
 			};
 
+			audio_mclk0_default_state: audio-mclk0-default-state {
+				pins = "gpio125";
+				function = "audio_ext_mclk0";
+				drive-strength = <8>;
+				bias-disable;
+				output-high;
+			};
+
+			i2s0_default_state: i2s0-default-state {
+				sck-pins {
+					pins = "gpio126";
+					function = "i2s0_sck";
+					drive-strength = <8>;
+					bias-disable;
+					output-high;
+				};
+
+				data0-pins {
+					pins = "gpio127";
+					function = "i2s0_data0";
+					drive-strength = <8>;
+					bias-disable;
+				};
+
+				data1-pins {
+					pins = "gpio128";
+					function = "i2s0_data1";
+					drive-strength = <8>;
+					bias-disable;
+				};
+
+				ws-pins {
+					pins = "gpio129";
+					function = "i2s0_ws";
+					drive-strength = <8>;
+					bias-disable;
+					output-high;
+				};
+			};
+
 			qup_i2c0_data_clk: qup-i2c0-data-clk-state {
 				/* SDA, SCL */
 				pins = "gpio32", "gpio33";

-- 
2.34.1


