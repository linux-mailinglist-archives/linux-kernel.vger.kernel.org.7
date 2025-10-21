Return-Path: <linux-kernel+bounces-863058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 337C6BF6E81
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1DA3505206
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B696D33B946;
	Tue, 21 Oct 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPuoL1HI"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60813338931
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054669; cv=none; b=B3xqI6qn2vaNpXqy582Sis+5tjwKImXQSvdPs/JKV2q7pMtzjO0Zt26KgfK8h6avKNWpY+gC9tqSEb/Zw7xPEkSGttEmDZd9TXr7Rxr5IRtidiKRRwBfd+AG0ZfDVGqh1lsgu6tT2eWdRL2AbxNj/Ml1deouNULcdZG7Uou0PnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054669; c=relaxed/simple;
	bh=ItD1w3fYZyJkpkUo2pyCHq0hC3jYRO0g3nZPTjnaz9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWzQWypjTLBh8pc/hCvtAYH6lqeClWfvZSMsX5K9IUk6W5pYKLKEqSxnAa9AISEgWHUcMUlVV4q0L3ZrNUb57mTfmXM2qut8eQhJOsoEOs3eNrdGmhWus1XJ2y2Sl5tIKwtDKtJN3ZFBW/J7qFuMs2cVQ9u3kHoKGgLzjnjzsl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XPuoL1HI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471191ac79dso47377325e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761054666; x=1761659466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k371KaQpzSfrSY7A+8d/OOUWlGtO1WXGc8SBkB6TQ9o=;
        b=XPuoL1HIpNmbawE9jlnWHQx0xwdAzGziyNgLXnLXYeHFI8SHUxUNADZ3DlRMQw7DHh
         M5b0hYRsClMgNEk0RNY/YmcZG32y2SfmSudIPhEmudWil2K2JSxvFYqrebwt/TYIM5HY
         KpsMGHw0/ruj49jVqhuD2WX7KRupcQSCFc9ebRlIPgv9jIrPktF5QmAhMmINceWch0cv
         sFQUBzJQ9e6s2N4RL7+VVdqDxvkmuYwZG30z9O3BPXWy30IpUK8Fqf/u/lYnchd1of7a
         52qn05ye5JYfgbbC9svgyaq1ZT280J+XZmed5ytDlCTNz5aQY8AcYD+v4cQz8dw5oRHq
         EByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054666; x=1761659466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k371KaQpzSfrSY7A+8d/OOUWlGtO1WXGc8SBkB6TQ9o=;
        b=njNx3wCt5J9t63jF0T6054qHTJNlIBTb7rKevmkE6wz73mVIwZG4ZflU7EFcARiSMV
         IaQuu48e8LT8x8PwKmj3XRgWj47VaUlDxphtaPDJF3lAuvBkvued7h6veMsR3t1neOLc
         dWiboWiSPEiCZ+2eQ5jtuX46kI0kvwNp0c9/qY48kx7HJiIvUknMUNf2csVzfRlLib+I
         FvGj3saR8XLNKI4aYl9R/tzNaSMJZIsZxmDJ4gRr7iMSD1mh7G+2w458OLPdghKvd1ed
         tYtMdouS5beO2Bz46t8ItjKfRZ0mDbBwuadwJisQETZOOLqmXEbvZkHKSzYNDitoJ/P1
         vlnw==
X-Forwarded-Encrypted: i=1; AJvYcCUnmue+YqWYHLRoeQrbnNcKu3rg1IIsdhqwZk+Geui+UDVTxqmqhp37+EiY0sHRENRoB9B16Zxeg8njAwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3kU3UMgn6/5Y2FCcCvqKgsqDYNl2S2ksrsX/hFzCPNpPdxkrL
	3JipE2pqenuFyWddNCJV2h6x78TMhMo0dS3x08kqTou9TErrb3999NFzQYfdkO6eoyk=
X-Gm-Gg: ASbGncvlILnZt8dVA+sJlky6EDqGyRZOQOz/GKaG5iNG13Ln7dtAmChMVK8QyY05pj9
	9SIqvVeQQIoYXlxJx/vMl7LfkHeICA3PnHVBJYfGcOd6prQyC/fX3gHA8TIZ70pfly0+2eAb9YM
	ZRUARFYEb1QLkuE6zWXOfYFOJ/VBEZl83haZWws+tLGWBo9N1JPGD86sLSRLmr3deS7gMHLJ3s2
	z2E9FSrYYJ4XnHaU3qa05/fpXGxx68SDn09FFnU1H3ctjcFpYZ4FR26K75ICZ9rT6qPd4QNBseR
	J71GRERQSJW6wYTyiRjH9tT/OwVXpQ9AZmgwSO489iKlKKH0Gtc1T23TWEZlxgyzzE+7ye17/yK
	qQ/4ClQ2xJnlTRSZYslUg6GdK/nVoJkcCzt8D65y+bYDbHNeUGSQYE2wgtoB5qhrdw78iehjVNC
	qkDc4EaCy6
X-Google-Smtp-Source: AGHT+IGjw/S1hNGLDFHdmUn97UDLVHB/Qxb9mbhMt+WxyITjF/QUF5tftfUNRbXorKB7Tp9SE8SxOw==
X-Received: by 2002:a05:600c:3e0b:b0:46e:3cd9:e56f with SMTP id 5b1f17b1804b1-471178726bfmr123732205e9.6.1761054665459;
        Tue, 21 Oct 2025 06:51:05 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm20124378f8f.36.2025.10.21.06.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:51:04 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 21 Oct 2025 16:50:46 +0300
Subject: [PATCH RFC 3/3] arm64: dts: qcom: x1e80100-dell-xps13-9345: Add
 Left/Right Speakers and Tweeter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dell-xps13-9345-enable-audio-v1-3-6f3f6bbd977b@linaro.org>
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
 Abel Vesa <abel.vesa@linaro.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4697; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=M8w8f1RPSf6k+hOThLXGlLV5SvXfagjt4HRyYETwRxc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo94/BFJhguW80AgiEG/Qh3hQALJXtAuYwKvFKE
 3xP/bLJK+mJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaPePwQAKCRAbX0TJAJUV
 Vr95D/0RIzFevoW8FYvlsOGI6lKHA+nRoG+T4imudzy9+imWAUzcxFGVQkVAEsVI0kF+ZV1PrDP
 JFs7bKDuLKh1TIVYjV7dtFfnO2s8otfsPZQt4cj/VN4nz/tK38v5MD4v8UoXNiuHYxy+EbsnpZs
 PnbkAZcU9RPzJJL3ScFa7XgFarDIjTCr3vC4CwrNzzq6BChKUXyZJUdBrBtCStOp7O0TH+bahX/
 6hVcWLVO3tj47GM4/jhEIrn0A1lluZpeIiZol0cdIFw+IsaQcn+ptg+XfTD8Eqchco8m7qpyxPl
 FiFDrxFInkpes2yHoB99n/IZ/v9kgsoKZq01lVqJFyyc6NZkJoAWWe14wm53NTPain16+eopX9X
 IfRiGiqfo6ynOUtxDK4AkxlnWGk3rkMPE1M7naMLdzBOVeAKYsxlN0nQuitY1E1NpoS2YjhBgw/
 ujXW1V6sicsBTC5SpGVuMp5/RutT5I3TYGX3Saumh+hnEYVmctqcm14SotbGCkjTyw4szI/2K+R
 p/azQ0c+nXc7sPOQktGDjwilCNKItEdFA2Z8+Yyp+vi7xL6UdS/+2opzHY2xPP7vfeZOmyVHo2G
 FX9rEf4oqEj0nNEwZDt2YvzTFMzobbO7vk0LsMX60FQ/UXr5RGt2gzNZXqLPRzTFAbMVGXJentj
 WiFIhe66JOUTH+w==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

Enable left and right speakers/tweeters on the X1E80100 Dell XPS13 9345.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     | 139 +++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index 58f8caaa7258077d2c267048ca048279109ddb71..a05dfe2c51364b3ec04963590d9b02b9fda9f336 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -151,6 +151,50 @@ linux,cma {
 		};
 	};
 
+	sound {
+		compatible = "dell,xps13-9345-sndcard";
+		model = "X1E80100-Dell-XPS-13-9345";
+		audio-routing = "WooferLeft IN", "WSA WSA_SPK1 OUT",
+				"TweeterLeft IN", "WSA WSA_SPK2 OUT",
+				"WooferRight IN", "WSA2 WSA_SPK1 OUT",
+				"TweeterRight IN", "WSA2 WSA_SPK2 OUT";
+
+		wsa-dai-link {
+			link-name = "WSA Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&left_woofer>, <&left_tweeter>,
+					    <&swr0 0>, <&lpass_wsamacro 0>,
+					    <&right_woofer>, <&right_tweeter>,
+					    <&swr3 0>, <&lpass_wsa2macro 0>;
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
 	vreg_edp_3p3: regulator-edp-3p3 {
 		compatible = "regulator-fixed";
 
@@ -415,6 +459,13 @@ vreg_bob2: bob2 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l1b_1p8: ldo1 {
+			regulator-name = "vreg_l1b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l2b_3p0: ldo2 {
 			regulator-name = "vreg_l2b_3p0";
 			regulator-min-microvolt = <3072000>;
@@ -880,6 +931,32 @@ &iris {
 	status = "okay";
 };
 
+&lpass_tlmm {
+	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
+		pins = "gpio12";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+
+	spkr_23_sd_n_active: spkr-23-sd-n-active-state {
+		pins = "gpio13";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+};
+
+&lpass_vamacro {
+	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
+	pinctrl-names = "default";
+
+	vdd-micb-supply = <&vreg_l1b_1p8>;
+	qcom,dmic-sample-rate = <4800000>;
+};
+
 &mdss {
 	status = "okay";
 };
@@ -1067,6 +1144,68 @@ &smb2360_1_eusb2_repeater {
 	vdd3-supply = <&vreg_l14b_3p0>;
 };
 
+&swr0 {
+	status = "okay";
+
+	pinctrl-0 = <&wsa_swr_active>, <&spkr_01_sd_n_active>;
+	pinctrl-names = "default";
+
+	/* WSA8845, Left Woofer */
+	left_woofer: speaker@0,0 {
+		compatible = "sdw20217020400";
+		reg = <0 0>;
+		reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "WooferLeft";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l12b_1p2>;
+		qcom,port-mapping = <1 2 3 7 10 13>;
+	};
+
+	/* WSA8845, Left Tweeter */
+	left_tweeter: speaker@0,1 {
+		compatible = "sdw20217020400";
+		reg = <0 1>;
+		reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TweeterLeft";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l12b_1p2>;
+		qcom,port-mapping = <4 5 6 7 11 13>;
+	};
+};
+
+&swr3 {
+	status = "okay";
+
+	pinctrl-0 = <&wsa2_swr_active>, <&spkr_23_sd_n_active>;
+	pinctrl-names = "default";
+
+	/* WSA8845, Right Woofer */
+	right_woofer: speaker@0,0 {
+		compatible = "sdw20217020400";
+		reg = <0 0>;
+		reset-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "WooferRight";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l12b_1p2>;
+		qcom,port-mapping = <1 2 3 7 10 13>;
+	};
+
+	/* WSA8845, Right Tweeter */
+	right_tweeter: speaker@0,1 {
+		compatible = "sdw20217020400";
+		reg = <0 1>;
+		reset-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TweeterRight";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l12b_1p2>;
+		qcom,port-mapping = <4 5 6 7 11 13>;
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <44 4>,  /* SPI11 (TPM) */
 			       <76 4>,  /* SPI19 (TZ Protected) */

-- 
2.48.1


