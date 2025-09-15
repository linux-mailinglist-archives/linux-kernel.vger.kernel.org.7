Return-Path: <linux-kernel+bounces-816568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C319AB57589
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF24F200C52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599782FB96A;
	Mon, 15 Sep 2025 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0vNi0dT"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2992FB603
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930793; cv=none; b=Y+9ON3vPzzh+gtRXI1wX8JSVmL3COfu9gkIKPoxnaWQPFdLj2qfN6JNDxXOTrmxWJn/sDe4Ku/oI3dy+RCICPv/JyvBkU4rTXIUuqW0vcVbFUdSIp9qFfRjC8eCms06s+8p4L1+wVI2Oi4IXc8SJDnefPZrcwT3tDDU1uj5bRgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930793; c=relaxed/simple;
	bh=+ShsOxehK3vPfQPw/3o19HKvX/iAMIQV9RlAhLMzWts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KjhNosvPgRlKBQQXvrn73XVvuWKSpIHIHCNaQFJPXaS8fGAkuNi2+bQVyVfDKFtaTpAuFQOmV9set8GTEoGb6d18vKrdy403ro9ftMDqOJFGbgOtAa8FOIcKI76YfxWB49OTmkPRxo+CaWwhdipkFkTZCk/lSfELr/b4zLNT2L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t0vNi0dT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e957ca53d1so1123673f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757930789; x=1758535589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2ZKUn+jq389hHmKRqBQRwd4GDWbmAFrDZJ0P/TID0k=;
        b=t0vNi0dTSvUT0p9EF92DxaFhINnHfNh91WVXQcv/ZaRKcoxtyKNb270nxMKPAI9CVE
         6J8ZNk3CDAocxOp0YNkPzDb9GkRXc89m7DSVofrdcMyRA4l3PIHqGsXlNHIgMZFF6MJf
         g8OgpX7DrthrCm/HR0k39SDroEV8mBodJRA1Yi9OjCZBShJKQOnFXkKz3i42az9O7GLh
         P7rSG8nfC+uaE3iiCuILHv5ngDyHB+Emfn017RYrskYkVurl0v+GyH58zyHy/UJ3ybOO
         KW2sluPge0wW2uVs92QF5ISYDS3c7n1OfbKJKEib+ywRkpdhvnagJqL2JV2QlV0Mzb4Z
         dAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930789; x=1758535589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2ZKUn+jq389hHmKRqBQRwd4GDWbmAFrDZJ0P/TID0k=;
        b=idhIU8ukwWM14KQFSIruIbXYst3rSm/mTH2y9Ix1IPElTwLxLAVxEtZ+kBT+R/8Wtq
         6bUSmE2nD5tM3h7W3ZW9Beslu427KFlK+YRswsp1rcc1cgLc7CkuFpowFC3oHxyPhpfp
         NemKZbSF24lDA3mT0jv8dEHUXTzD/XLSKAXo/fmU0AQ6JHhXvflO1HGktNYbnIptfNud
         nh6mEZDfSmv1/ruVd9ofCwA1993ciRNnVa8HrOdCoWBq13eRnCEvuahtipxOazYuIAdM
         Xr49OzQEiuIW8hdGKjZhGaadafKDnyliGYotC+g1qwQabdIJdhT9ScSKBKcpcFq8sLcs
         GbKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ciVZdSxFLKFnMCSSI82VAhV+vOeWWa3RKSqGUGccBT2cqVQuKs88gYuPfq19m86c+r8FHjURBMtaNT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRItNnyK6+gpVLuEBUq2KknVOPhATkL94AK/DxRXb9dmdihlcg
	MlTFSXVNQnFQ4gwUIcdfo6ACG9nw1ttqKjyBPH4NLtkH7jZeopcQ6eixkwVl7k42aH4=
X-Gm-Gg: ASbGncsCLtQ1wcn7z/E2tbIjZvammMtp9warN2Myk8O3/YsmkZv9af/EexIK18shAga
	xN8pOC6OLfoMZ4J04TMKLQY85sbaOtJmuU7j44tYh94Cnm+IZvOtZcDlIO+5r7p5b26gtgaa+cw
	ly6Q1HspN4LH7PUafMOicrhZNlJh9dFonTq+mT+/ckDxQzNL1eafuBYV9+2jl4L2np3Ly8rLRjO
	SJFWufTmNG8VRrcxJHWMPzH42hprVzlkGU+8R2ny/FxnBJ5JlMAO7NsJzij+B0jAAo6XtTT9fth
	hQMEkJWH99YEY9+ORovvjEoXiv5crYkikzwr50NrX9ppiQ14b2coSsbKlZdYh9Uah6ACw+CMxYt
	1Z/T48zETfRP8MXUqwBruqw0Ayt4p8uGQ6SzVYUPHKGyF7A==
X-Google-Smtp-Source: AGHT+IFHeDqwo3IJZLE9ouwCOgN9pOpAvjMVBWaO9LQYeV0ooL5G9kS3F+W9S5ouSFSHfB9iUA813g==
X-Received: by 2002:a05:6000:4203:b0:3ea:63d:44c6 with SMTP id ffacd0b85a97d-3ea063d4b22mr3522864f8f.35.1757930788783;
        Mon, 15 Sep 2025 03:06:28 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:eee1:5042:e713:2e9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd4cdsm17209127f8f.37.2025.09.15.03.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:06:28 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Sep 2025 12:06:13 +0200
Subject: [PATCH v2 2/9] arm64: dts: qcom: x1e80100: Add IRIS video codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-x1e-iris-dt-v2-2-1f928de08fd4@linaro.org>
References: <20250915-x1e-iris-dt-v2-0-1f928de08fd4@linaro.org>
In-Reply-To: <20250915-x1e-iris-dt-v2-0-1f928de08fd4@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Anthony Ruhier <aruhier@mailbox.org>, 
 Stefan Schmidt <stefan.schmidt@linaro.org>
X-Mailer: b4 0.14.2

Add the IRIS video codec to accelerate video decoding/encoding. Copied
mostly from sm8550.dtsi, only the opp-table is slightly different for X1E.
For opp-240000000, we need to vote for a higher OPP on one of the power
domains, because the voltage requirements for the PLL and the derived
clocks differ (sm8550.dtsi has the same).

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # x1e Inspiron 14p
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
Tested-by: Anthony Ruhier <aruhier@mailbox.org> # Lenovo Slim 7x
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 87 ++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index ba602eddfb54616ad38205570bc56a1f0e62c023..a6305077f150d59ef8fdbd13fe3ba03d43646c91 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5234,6 +5234,93 @@ usb_1_ss1_dwc3_ss: endpoint {
 			};
 		};
 
+		iris: video-codec@aa00000 {
+			compatible = "qcom,x1e80100-iris", "qcom,sm8550-iris";
+
+			reg = <0 0x0aa00000 0 0xf0000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&videocc VIDEO_CC_MVS0C_GDSC>,
+					<&videocc VIDEO_CC_MVS0_GDSC>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_MMCX>;
+			power-domain-names = "venus",
+					     "vcodec0",
+					     "mxc",
+					     "mmcx";
+			operating-points-v2 = <&iris_opp_table>;
+
+			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
+				 <&videocc VIDEO_CC_MVS0C_CLK>,
+				 <&videocc VIDEO_CC_MVS0_CLK>;
+			clock-names = "iface",
+				      "core",
+				      "vcodec0_core";
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mmss_noc MASTER_VIDEO QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "cpu-cfg",
+					     "video-mem";
+
+			memory-region = <&video_mem>;
+
+			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
+			reset-names = "bus";
+
+			iommus = <&apps_smmu 0x1940 0>,
+				 <&apps_smmu 0x1947 0>;
+			dma-coherent;
+
+			/*
+			 * IRIS firmware is signed by vendors, only
+			 * enable on boards where the proper signed firmware
+			 * is available.
+			 */
+			status = "disabled";
+
+			iris_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-192000000 {
+					opp-hz = /bits/ 64 <192000000>;
+					required-opps = <&rpmhpd_opp_low_svs_d1>,
+							<&rpmhpd_opp_low_svs_d1>;
+				};
+
+				opp-240000000 {
+					opp-hz = /bits/ 64 <240000000>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_low_svs>;
+				};
+
+				opp-338000000 {
+					opp-hz = /bits/ 64 <338000000>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_svs>;
+				};
+
+				opp-366000000 {
+					opp-hz = /bits/ 64 <366000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-444000000 {
+					opp-hz = /bits/ 64 <444000000>;
+					required-opps = <&rpmhpd_opp_nom>,
+							<&rpmhpd_opp_nom>;
+				};
+
+				opp-481000000 {
+					opp-hz = /bits/ 64 <481000000>;
+					required-opps = <&rpmhpd_opp_turbo>,
+							<&rpmhpd_opp_turbo>;
+				};
+			};
+		};
+
 		videocc: clock-controller@aaf0000 {
 			compatible = "qcom,x1e80100-videocc";
 			reg = <0 0x0aaf0000 0 0x10000>;

-- 
2.50.1


