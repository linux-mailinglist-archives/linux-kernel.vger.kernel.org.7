Return-Path: <linux-kernel+bounces-617996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E088CA9A8DF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 11:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D423B498C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 09:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E035722B8C6;
	Thu, 24 Apr 2025 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lL/C0EU4"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9822A1D4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487669; cv=none; b=Kx4JBP/GE6bipA9HbOGzA7MqU0kflV9ctl9X9waBy6cYa7ZP0BRw9+fB7ksXfqbGV50hnUOq6yv1zLT7W9hLMCiX9zPCpTKmETB+DjeTxShFIQOXmWkzYOJFTztB1meeuNPbNH9b47mWoij9s/G8aEncRdo+daUnz/m3wSc6Ubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487669; c=relaxed/simple;
	bh=TBsg5Gw/8VRnL9eYpB9Ca+nqmePgCSvmXxRDLHsuTtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SgYae6aZoR89sNnNxpUghmaO4DLsYSPxO4mK7Zn53qUTvwXiaNRoHX79+XWl5K5lXMWAjhVzwvS0Evnpm3+WFzdz2Jyu/nCv6sbul7hN99ZnL4ojD9+7RkzDw5nCI2aNZXUJRg7rT8tOOjQgdsTQpjhaRE1c3nlo5NAWXg4vlGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lL/C0EU4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-44069f5f3aaso1070995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745487666; x=1746092466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjIVmmwPwi2abb7R3JFlYVKuU635PTKZL4Ry4YZxTjA=;
        b=lL/C0EU4Ugq2LH4UOkRzI6XZDynDAroY3QiU3uolOdUPdnywpj4Uv6mg6uHWaO/Z+K
         vrYD/oPpepCdSAAYxt4G18EO4QKPanAH3BJhJhgb8bBiFXTCQdjW3hmO7JYmxMWjg9eF
         mi1r3l2pM5LPDBbqcDQK9+7U8J5haTA87cqwANa3pw/wiYff4sphSjh/T5MjoG7Lb7Sk
         x4uS8/sgKzNFTgI5hAn5HvI/MQ15gan1klysREX113KdeRP9vZc5WNpKSFgaNBk8F8Tw
         9yIN9lh3QngXRqVTiqBZ00jMK06k3Xf6u9Dd++NKEsl1uLduW2+5MFasTVgIfqvTrWGs
         e3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745487666; x=1746092466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjIVmmwPwi2abb7R3JFlYVKuU635PTKZL4Ry4YZxTjA=;
        b=rmwJxSHzkAer/zItOTS7tFK8xJa/kvomjH8m2UGIcm+HGIW0Rh66VD8i6HApNA2XaP
         GOTGp5luVfNzUAm16oVloz5Lc8pZ1rRt1ZeXtyyGa6OCK0is80B9HHLY7M8Invrb4st6
         BTo2ntm+agjg3I0dz/ClM2a7+xDVcbgebt0/ePkAndsYrSfnPl+7nzSS8GzcR7fWXtKt
         BzW6pCgZZWbHFXx0poVE7c51oBe0QWrAWDZ2S7gsVg2+1VkY0KPFEYgcwICEFdnAbRxQ
         b9anbO3SaFmGsCePBOi7uu3tCTmuebzTXIjwFJKe8qQBJIE33kJdSX0FpEWiYA+9xH+O
         LIcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDN6csghlFVUzRf6PN7ZnxYhTIrMD6r70WrcIQL64Zku3J+vzJHmtFJ95Wn8LN5+u0za2HVXaTMc4Ebfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrsXnyCW2q2V6NO+41RIZ6U4XuVAlCNGOUIe8BC86bnXc4uXw5
	aCnQY1WzzWFXu/7CjNbVAIhEBij/MpfemxZmUZPHWZGsfOTulARVz7ekchsNxHKTZum/VNfDErG
	Z
X-Gm-Gg: ASbGnctDDnaU5anM+ioE8kYpW+S5lpSySUVpzLgLUm4/Y5uq4VBjeZN4ZSrpmkpezX7
	ZI+k7+KjWaeVp9T2tycPgeQcNgGmwqpAOAiEE2gDIJGjXIUbFo3fk8L7y5Y/10ec/pXLOVvYB0u
	FrSr2OPiZJiqlApxr6+yUyl4gPaljMvX5xSiopU802G3R49nlhPP/cEH7zFZ5ijdQYGbXhxO2KS
	VTJw2R3Ky2CFR5BN1ikxfavj5TabAb5W3anSFjjuKpw+OYNvsHoG+E6vqWt9zvMPB9mBc3Jey22
	VeSA9SborlGlcyK9jOipMFtoilQTzbk8PujlrOwbo73oTB8/k+zNmPgh4tc=
X-Google-Smtp-Source: AGHT+IHO6+G6nbwN5cAabfQNCEyEBsMncf95D8gvWL5KJRsDwm8ofE95JLIy0JYeePV9fJhO30RiYQ==
X-Received: by 2002:a05:600c:1e26:b0:43b:c938:1d0e with SMTP id 5b1f17b1804b1-4409bd0ce01mr6010255e9.2.1745487665819;
        Thu, 24 Apr 2025 02:41:05 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408c8b0ea0sm41526975e9.2.2025.04.24.02.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 02:41:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 24 Apr 2025 11:40:53 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: sm8750-mtp: Add sound (speakers,
 headset codec, dmics)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-sm8750-audio-part-2-v1-2-50133a0ec35f@linaro.org>
References: <20250424-sm8750-audio-part-2-v1-0-50133a0ec35f@linaro.org>
In-Reply-To: <20250424-sm8750-audio-part-2-v1-0-50133a0ec35f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6636;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=TBsg5Gw/8VRnL9eYpB9Ca+nqmePgCSvmXxRDLHsuTtw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoCgcrlv0Hrm+KiCF0Uw74/6za1QWwf6cMXe1GJ
 IcvvrXprSSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaAoHKwAKCRDBN2bmhouD
 17jPD/4usJQWPljbPzU/u73tBnbGfVtehlZpVCF1o7slU/rzS0L05KQcPEluPFE1TLsFUJs1JMw
 Xz7BDapU7u9RLJjrYRBLdWtyh0wXp+kGt96Kpo+pA2J+YLW6x3vCw7RD0BuSgGPMI2W2fOFhP2B
 chP7GR3cpBTQW7YBV3Q+M1WTZj3F8Wosqe1FKx0N+9VrUPd8A0jStQsU3KHhjoIgkRm5zvt5xsm
 wOuGk5yhTtXUIo9R5srpP1FyhV8uHmSViLox8d72hh94mMedmL2gGeLmPiJS9OOWj9kB1uLj758
 LayIlyfVHN7O8PfpVVI0nymToXsEnm+WDqC7i3jL4iFni2iTvaT8v4RNwUs5lgCwk9AWgzpK4ij
 /28/T8TKVzB5VDCElRx2hZe0Ffowzelq3UxB8L7CqpuaCloxPBA98MvvCuwCEJfrRBH60+EKIP3
 eVGP+9G2GEzreCggbeCvRRgOJa8WuwVsScYya4xZuDTDL8MjjOf/G2dAzeIO7zIkepO2o5Of3Xn
 H6uLyZ527vv6Ne8vOBOtxDhiszbRLhd9c+hcMFC8VGxyCi5NgsebtdLEYzbORcsJCkwr9dXmQX/
 abDxTlP9nMJAyWF6GgSrPXMoAW6oglBnnFoZ4cogGeg6ihSba/sud2ptJTUQWn9PIPh7DfZrd6r
 aqwcLfgjApqt7eA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add device nodes for most of the sound support - WSA883x smart speakers,
WCD9395 audio codec (headset) and sound card - which allows sound
playback via speakers and recording via DMIC microphones.  Changes bring
necessary foundation for headset playback/recording via USB, but that
part is not yet ready.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 214 ++++++++++++++++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 72f081a890dfe49bfbee5e91b9e51da53b9d8baf..47645f15e6e327620840de8c3e03105540faf9cc 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -29,6 +29,32 @@ aliases {
 		serial0 = &uart7;
 	};
 
+	wcd939x: audio-codec {
+		compatible = "qcom,wcd9395-codec", "qcom,wcd9390-codec";
+
+		pinctrl-0 = <&wcd_default>;
+		pinctrl-names = "default";
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+
+		reset-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
+
+		vdd-buck-supply = <&vreg_l15b_1p8>;
+		vdd-rxtx-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l15b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob1>;
+
+		#sound-dai-cells = <1>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -81,6 +107,89 @@ key-volume-up {
 		};
 	};
 
+	sound {
+		compatible = "qcom,sm8750-sndcard", "qcom,sm8450-sndcard";
+		model = "SM8750-MTP";
+		audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
+				"SpkrRight IN", "WSA_SPK2 OUT",
+				"IN1_HPHL", "HPHL_OUT",
+				"IN2_HPHR", "HPHR_OUT",
+				"AMIC2", "MIC BIAS2",
+				"VA DMIC0", "MIC BIAS3", /* MIC4 on schematics */
+				"VA DMIC1", "MIC BIAS3", /* MIC1 on schematics */
+				"VA DMIC2", "MIC BIAS1",
+				"VA DMIC3", "MIC BIAS1",
+				"VA DMIC0", "VA MIC BIAS3",
+				"VA DMIC1", "VA MIC BIAS3",
+				"VA DMIC2", "VA MIC BIAS1",
+				"VA DMIC3", "VA MIC BIAS1",
+				"TX SWR_INPUT1", "ADC2_OUTPUT";
+
+		wcd-playback-dai-link {
+			link-name = "WCD Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&wcd939x 0>, <&swr1 0>, <&lpass_rxmacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		wcd-capture-dai-link {
+			link-name = "WCD Capture";
+
+			cpu {
+				sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
+			};
+
+			codec {
+				sound-dai = <&wcd939x 1>, <&swr2 0>, <&lpass_txmacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		wsa-dai-link {
+			link-name = "WSA Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&left_spkr>, <&right_spkr>, <&swr0 0>, <&lpass_wsamacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		va-dai-link {
+			link-name = "VA Capture";
+
+			cpu {
+				sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
+			};
+
+			codec {
+				sound-dai = <&lpass_vamacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 
@@ -702,6 +811,14 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&lpass_vamacro {
+	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
+	pinctrl-names = "default";
+
+	vdd-micb-supply = <&vreg_l1b_1p8>;
+	qcom,dmic-sample-rate = <4800000>;
+};
+
 &pm8550_flash {
 	status = "okay";
 
@@ -806,6 +923,74 @@ &remoteproc_mpss {
 	status = "fail";
 };
 
+&swr0 {
+	status = "okay";
+
+	/* WSA883x, left/front speaker */
+	left_spkr: speaker@0,1 {
+		compatible = "sdw10217020200";
+		reg = <0 1>;
+		pinctrl-0 = <&spkr_0_sd_n_active>;
+		pinctrl-names = "default";
+		powerdown-gpios = <&lpass_tlmm 17 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrLeft";
+		#thermal-sensor-cells = <0>;
+		vdd-supply = <&vreg_l15b_1p8>;
+	};
+
+	/* WSA883x, right/back speaker */
+	right_spkr: speaker@0,2 {
+		compatible = "sdw10217020200";
+		reg = <0 2>;
+		pinctrl-0 = <&spkr_1_sd_n_active>;
+		pinctrl-names = "default";
+		powerdown-gpios = <&lpass_tlmm 18 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrRight";
+		#thermal-sensor-cells = <0>;
+		vdd-supply = <&vreg_l15b_1p8>;
+	};
+};
+
+&swr1 {
+	status = "okay";
+
+	/* WCD9395 RX */
+	wcd_rx: codec@0,4 {
+		compatible = "sdw20217010e00";
+		reg = <0 4>;
+
+		/*
+		 * WCD9395 RX Port 1 (HPH_L/R)      <=> SWR1 Port 1 (HPH_L/R)
+		 * WCD9395 RX Port 2 (CLSH)         <=> SWR1 Port 2 (CLSH)
+		 * WCD9395 RX Port 3 (COMP_L/R)     <=> SWR1 Port 3 (COMP_L/R)
+		 * WCD9395 RX Port 4 (LO)           <=> SWR1 Port 4 (LO)
+		 * WCD9395 RX Port 5 (DSD_L/R)      <=> SWR1 Port 5 (DSD_L/R)
+		 * WCD9395 RX Port 6 (HIFI_PCM_L/R) <=> SWR1 Port 9 (HIFI_PCM_L/R)
+		 */
+		qcom,rx-port-mapping = <1 2 3 4 5 9>;
+	};
+};
+
+&swr2 {
+	status = "okay";
+
+	/* WCD9395 TX */
+	wcd_tx: codec@0,3 {
+		compatible = "sdw20217010e00";
+		reg = <0 3>;
+
+		/*
+		 * WCD9395 TX Port 1 (ADC1,2,3,4)         <=> SWR2 Port 2 (TX SWR_INPUT 0,1,2,3)
+		 * WCD9395 TX Port 2 (ADC3,4 & DMIC0,1)   <=> SWR2 Port 2 (TX SWR_INPUT 0,1,2,3)
+		 * WCD9395 TX Port 3 (DMIC0,1,2,3 & MBHC) <=> SWR2 Port 3 (TX SWR_INPUT 4,5,6,7)
+		 * WCD9395 TX Port 4 (DMIC4,5,6,7)        <=> SWR2 Port 4 (TX SWR_INPUT 8,9,10,11)
+		 */
+		qcom,tx-port-mapping = <2 2 3 4>;
+	};
+};
+
 &tlmm {
 	/* reserved for secure world */
 	gpio-reserved-ranges = <36 4>, <74 1>;
@@ -814,3 +999,32 @@ &tlmm {
 &uart7 {
 	status = "okay";
 };
+
+/* Pinctrl */
+&lpass_tlmm {
+	spkr_0_sd_n_active: spkr-0-sd-n-active-state {
+		pins = "gpio17";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+
+	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
+		pins = "gpio18";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+};
+
+&tlmm {
+	wcd_default: wcd-reset-n-active-state {
+		pins = "gpio101";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+};

-- 
2.45.2


