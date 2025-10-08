Return-Path: <linux-kernel+bounces-845873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D64BC6628
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6783C1836
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EE82C3260;
	Wed,  8 Oct 2025 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5XtIMr6"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796C42C15AF
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949822; cv=none; b=h9WbNAPaFKFI71EpCIn2ldrvTZejDOPKeKMv6uTCO3PEzxzV3nSV92BpA1vjPFmmeOdw7Z+j651vNYtL9BkGdI/XO9ndgTfQkVpB6Kd5Umi5DzrmYjXG599XtsIHe0VHq91Qq76NI9jZJpsgnM/ovtSBGvS3P2OFEi3Pu5Fgs2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949822; c=relaxed/simple;
	bh=tvBiI4KGZnSVqvWgipWohnIUVWQ3E10+ZkZngbZnKyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCifLR8CBlfqDI0QPVgMBYNuN00gWGxljiivnSRPm6H3zdUuvlgi6iIeWyKLJWSco86a8ubMPYeR9Xrrhr0JNObwCBHRVKv/vTQdr8R81KbAREhBRCsXwCjHHLUFe73YGVO7Pu961Anj3Kc1NdiYJOMgdbrVleNwR+hT/ralo2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I5XtIMr6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-421851bcb25so125122f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759949819; x=1760554619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAg7jbdZTsaB93akt9iaNf7f80J8J4gg3pMCVwLhH8g=;
        b=I5XtIMr6621gnuU9Cbz+NWnLkXYqsXUBT8+WI7CJ2gC9URztSxkkEZ4rS+ZPmvDKgy
         y34E72cGoXTD3skjpVVyU9D/lmXdZzABAG5U6cFc8kehT5IXmm49jneStGcIdbJP+xus
         JmKTY/1Yc+0ZYQKd9HEu8k1Tn4FmdBfXrITX2eLVvtGpkZ9HVsuLg+TAqk/f6K7Wce1/
         L4hrLAdC2W8tsihycHmLDX0aavHC3kkQBYaxMioMNNN9r8oItc8l53vKlD6fwH2o0J0V
         sS1P5iD7hMqRY+LJ9dB1+WWqovv0mvxBdUQ2KOZDvo7N197mp7C3XxQpwbAm5TlOI20U
         hpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759949819; x=1760554619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAg7jbdZTsaB93akt9iaNf7f80J8J4gg3pMCVwLhH8g=;
        b=ds90Hsb+luaqMdfrBFBfuofjmxYwtKMfgXQTzxMUnJLZxM4gqMuBQVce12+ft1k8P2
         5GFaXn7KIW3ZT7mIttBwtBbVwzr3nnksLZkg4wYC170wcTE2quSipgzElGtRx6LNixEO
         terh/d+4mvB7o5mLFQQF/H8t/sQ7je3DjhfSgBXJlDO5tFfiFgMV8VvL+oe7ceUi3bH5
         oI6ap0eTHxuBFv/Dz4+c3fKnm5alBSb4hwnIUdecdhfT0dqkbMyLo7b4b4PAdG2cenHm
         prk25Gk1SrNKwm7g8pTiduXg7WpArgAEewg0B5gcRc9OYMoPp/ctY2sE8W5XdYhXYyIP
         VAEg==
X-Forwarded-Encrypted: i=1; AJvYcCVsRuw/gWifBnEqYlRd4tAAbRSclWm5KcMz+IoQcje5IwNw75Yxeu84n31sm6zs4ARw2jY1kgy/QN1It2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJNK+maoAO+wVh8v++fwL48SNucK1aNRwgbYaPHUi8DzIYhxz
	18he98Cx2x1zSSkMevdIAVoi4uo3eHu1F4nBgqBgMKPRCBc+KRYRGNweWxzdFgOaKUtYlzEHvYg
	3u+Ed
X-Gm-Gg: ASbGncuxEwB4z7OBaJ97wDXYF1Ba7QmAVVpsEwDdySOyL1oEfaQr9wBoShwy3wljEuP
	cwCs8JGFvtQC4g+Xu4cg3YGiY1BmzmhfWrC6Hh7Yp5hAij1UPus3J1x4tfUFd6cKV4DSuwnR9OG
	5zs1yvxWa+I5s3fVFo5Ns7fl+Ptvx1HdxsWu+INJYTzt/HXWciYviSPlxnZE0x/4CmkAzT4frQT
	sOA+DiATeEwpJfBMAlfPQWY8JH7kHkYgrZCjMJjblGjgkL8oNwzhZAYhT+QRMH4LLidTGZI/djz
	WJgfOP66uy9yaDJl8Fly1ZrRxzJKL4f45K6FXXbnOzcrDj9H2Axu4cIAOIweOj3B57xXB9B95EQ
	nVORZkyWuMYpbb9L5qufWTZfkfTq4vs3vGglZTh8bkupfIhYu4BMh3+gEP4kIHspkM1Ag/CaF9i
	jV+BlxMQ==
X-Google-Smtp-Source: AGHT+IHwndQ1C2/jkJD2qahEjeWCgmIKvvmNvN1dz35gSiOO9G9p2R3CpqECjJ4wTaRvhf2VmiLc1Q==
X-Received: by 2002:a05:6000:3101:b0:3ff:d5c5:6b01 with SMTP id ffacd0b85a97d-4266e7bf0c2mr3077869f8f.19.1759949818600;
        Wed, 08 Oct 2025 11:56:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e96e0sm31029735f8f.33.2025.10.08.11.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:56:58 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 08 Oct 2025 20:56:52 +0200
Subject: [PATCH RFC v2 5/6] arm64: dts: qcom: sm8550-hdk: Enable I2S for
 HDMI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-topic-sm8x50-next-hdk-i2s-v2-5-6b7d38d4ad5e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3663;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=tvBiI4KGZnSVqvWgipWohnIUVWQ3E10+ZkZngbZnKyM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo5rP04q+9CfiVZfIElVyL2ST9o/5uK5RYY5LcMdaa
 W2IyS5iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOaz9AAKCRB33NvayMhJ0Q+wEA
 CTs8GwBp4IWTA8WOsrDNCjSehm+m7hmdYQmSv17rQenMoHbfORJ/Z8d+Av9FVxIqcJpwMbkgQTgd9D
 dua8t4ErxhkNccFhpDV0QCKByZiZdfkQoqE7Abt2LQ9dSE+iowZK9oaVszlvof0EDVPxA7MCG9n89n
 /fGA4rVGfQ05PfgZQU0RERbJOYS0YrEU5QD4O/54W7N/kHT8QMR1TeYj8mBApn0kyyzCi81nWL91WH
 RQTa4A6aZQhT09ohSoLWd/pP8oCVKDFPrz79gVNZEuwieFYQ6xPNdSHmbQj8C8BNXMeQNt4z6OXYcs
 L9dnvTp8G7K/yHXQh8EDnx75Iiauj2aGcVRtIXJR9bj0hZ6xZ45kxhEK7XU9EAF0y0vb8p3sYAcRS1
 UMZy8iFJK+gFBE5Ia6xdU6ryoXBEkLuAGpp4pF19OL/IfIQfnsAr5EuVBeJjPAmldfOXI7Id72Fy/N
 rhjCTA7Mqj74fr7sFTx1GYcOW7WGK5AlakShaFG39yS3ZeSB7fzJfFpgYQ/bujOJcKUOiZXRB/dko6
 +3OtVEWRmUa8xghlg1duWarUPSXDTCEIeQkE/T2onwwg2s21sYcYLeIBtuaRoy//8bsu2mxtbkfkMX
 SPEe4EzHQB9hYFl1TLDtYQos3T+PmqhmMB1LYGiOMLHO27gaNCQ4FOLEaprg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the necessary nodes to configure the right I2S interface
to output audio via the DSI HDMI bridge.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 26 ++++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 73 +++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index b5d7f0cd443a18b167c94e450b5b9412897b2ba2..7c163344b064a90bfa4f9629e2aaf409cbe81965 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -215,6 +215,14 @@ sound {
 				"TX SWR_INPUT1", "ADC2_OUTPUT",
 				"TX SWR_INPUT1", "ADC4_OUTPUT";
 
+		pinctrl-0 = <&i2s0_default_state>, <&audio_mclk0_default_state>;
+		pinctrl-names = "default";
+
+		clocks = <&q6prmcc LPASS_CLK_ID_PRI_MI2S_IBIT LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+			 <&q6prmcc LPASS_CLK_ID_MCLK_1 LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+		clock-names = "primary-mi2s",
+			      "primary-mclk";
+
 		wcd-playback-dai-link {
 			link-name = "WCD Playback";
 
@@ -278,6 +286,22 @@ platform {
 				sound-dai = <&q6apm>;
 			};
 		};
+
+		prim-mi2s-dai-link {
+			link-name = "HDMI Playback";
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
 
 	wcn7850-pmu {
@@ -891,6 +915,8 @@ lt9611_codec: hdmi-bridge@2b {
 		pinctrl-0 = <&lt9611_irq_pin>, <&lt9611_rst_pin>;
 		pinctrl-names = "default";
 
+		#sound-dai-cells = <1>;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 7724dba75db79a9e66a2c61e1ea3607bacfdf5bb..73df93288f6e0ed71ec1e7f5ae09276e7593fd60 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -4956,6 +4956,79 @@ data-pins {
 					drive-strength = <10>;
 				};
 			};
+
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
+			audio_mclk1_default_state: audio-mclk1-default-state {
+				pins = "gpio124";
+				function = "audio_ext_mclk1";
+				drive-strength = <8>;
+				bias-disable;
+				output-high;
+			};
+
+			i2s1_default_state: i2s1-default-state {
+				sck-pins {
+					pins = "gpio121";
+					function = "i2s1_sck";
+					drive-strength = <8>;
+					bias-disable;
+					output-high;
+				};
+
+				data0-pins {
+					pins = "gpio122";
+					function = "i2s1_data0";
+					drive-strength = <8>;
+					bias-disable;
+				};
+
+				ws-pins {
+					pins = "gpio123";
+					function = "i2s1_ws";
+					drive-strength = <8>;
+					bias-disable;
+					output-high;
+				};
+			};
 		};
 
 		apps_smmu: iommu@15000000 {

-- 
2.34.1


