Return-Path: <linux-kernel+bounces-730144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9D6B040B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6954A2907
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A5A2566E2;
	Mon, 14 Jul 2025 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrcSWrPb"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B39A255E27
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501325; cv=none; b=DYjYg3oOqVXXljMubZmQImERJUBTskFHy+Fj0w49I2q8ZkFhf62IMm+g3YI4ob4iT5j0fbARYLvk5a2YMjGVMfUPFOsnT0U256WeAU9fiKuwsndeU4B5SbptG4RRkZsqqi9VnEnedFeGQ4zQ1Yh21BLS4cwzRhwZWTF+jSydtQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501325; c=relaxed/simple;
	bh=o9rUzX9v9qgXDQ3i6rSoF6AnIUbO5gzqz1WzYADRyG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ReAI/AyeVzIvcez1QVcInlQzOQYur5Gx2XWkocfSrr4D4Fi/1NYiEMPMhyGDRtP4GVP1Gxk30UYTjsJVZ2BxLm27hEAhb5tHg62VtC50DzrHt6E/wAM59rWL4w8L5M712j4d/ogpsL87J830p8F2k3uRS4XHSeiNYRoOJVo22VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UrcSWrPb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4e57d018cso634169f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752501321; x=1753106121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oym9Tt+cySSct5QJHwCxmAN8snN3O4CX4rTALRaPP78=;
        b=UrcSWrPb+jMKU48CjQra75iw+YpedVJ9O85cl2ZgcPgHbndgIRPwhDLbSHDGZG/oJ2
         16QqS6tTDIFeSUCSZ56kNNOP+c6h8BW7oISo75rFIIiSGAHIRnfn6XEJgrQkF5eGrhRa
         sO9aaHzhygmz8jBKy8e1iNe4fNJxrbRG3Ht8nyO0nAGCX1cPpGSy5EDidDnI6wtEh0xo
         /ZDZLaBdFFpYLlXNNUIeUgaoMHwQ7VqZcJyml3gHCVnlqPfj4IxqGDX1r7N+S6pDJTSS
         t+BH0vAs3/H4OMFmIMgCaEX51dS7zqP12QBlnq13LWnsoVz/auwmDcSqkHkNG3W8Up76
         RDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501321; x=1753106121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oym9Tt+cySSct5QJHwCxmAN8snN3O4CX4rTALRaPP78=;
        b=xHBMwb6GRRCZriAK0EaRa+oCT28y9xb3dEcTPrsIJeJaPhxPXvD5ygOT1njGtCoCMu
         2udO2orbxj56CELwQfPoHLDXQx804bVjsF69VcHqZYwtnn6u/XdDnR5iNjGEQVZ/Txw6
         x6wvYiEpatgTGFJVpAWtWMaf4ZW3PJGNi/r8CgcnmBi1Xuvsc04+JAbKhbaWbOFSL4xy
         6TS/ZGwdh1Uv2QYAHJWrYmbJERF4++4lcDT9T8D/Wc10GbcIfYirCWObr27JpPbuLl0j
         Mj7ox/uQAKJbEDAAf6pChzqGEgBydErh5yMKxoNFwEFFw0NLhU2CB2FS7Y7SsWZLNxPo
         TEtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1cmSH8H7CKrCmB8uZ6gX256EHsoG/nkPT6t//K0tUDQbia5JFA7/Rdt5V4d0k/6uSPOBKJ+77HYu5v8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfCrIGIados3rFzQ7zv2SOp55+zHKtKOdn197I+b5CNWE8rwW
	Ef1ntuvdRy73AJxMN13vczzU2JBPmni6Kv5yvZoIxlIK0o+9pT0xvQoGEyrXLkJvGbM=
X-Gm-Gg: ASbGncv8jAdJg+Q9IW5JF1A8YMXDROHPH5w5B6Q76QR1aMUJLhaFZeWpwZ9p/ueImnT
	LrIED/ulOPIMy1sct0rOk3kXyl8Qp0EB9HaRtYg8Qx43Ge4JXNxW53yGvThK9+jbkcoizaA6vvL
	FhxFdMudzcq1Dv0rZsOjsBnnk3RN7JjtE8lF0wRmHY60WxypoQ3sOKSxPrv2+z5xij7DPxGia51
	6lVXgqwDxv7/eoTRkUVivQN4aKm1oF0jtV9LqAx2g7TK69B7KGI2j4KVYyCxHV1xbHdl7yXn7y0
	iuv0XJv4ZRK0hPa9/DZWdkSmjM13hChdagjg3PhD6U9+PPLppyRv46yRuEXv7q64fQhQl1f0zcw
	F+LAU1e6/HfPRwt4hzTBbNzhnwE1ZoEP2HJS9
X-Google-Smtp-Source: AGHT+IFsyLCf9kaPtzAmTh5iAuGGJ+hmN0z9UqP2S11iaGtLo6qvSEpqYfdNc6Tsa9m/a2+3H2tCfA==
X-Received: by 2002:a05:6000:2285:b0:3a4:ec9c:fb58 with SMTP id ffacd0b85a97d-3b5f18e7c75mr3637675f8f.9.1752501321410;
        Mon, 14 Jul 2025 06:55:21 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5037fa0sm172291575e9.7.2025.07.14.06.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:55:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 14 Jul 2025 15:55:14 +0200
Subject: [PATCH RFC 1/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-b4-sm8750-iris-dts-v1-1-93629b246d2e@linaro.org>
References: <20250714-b4-sm8750-iris-dts-v1-0-93629b246d2e@linaro.org>
In-Reply-To: <20250714-b4-sm8750-iris-dts-v1-0-93629b246d2e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4638;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=o9rUzX9v9qgXDQ3i6rSoF6AnIUbO5gzqz1WzYADRyG0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBodQxEUFVMVg6H4k1G74O5CE5ifCHPkG5K1eRcI
 /TeafzEjISJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHUMRAAKCRDBN2bmhouD
 1+ztD/0XOHAC3YFOT9rAuQZrCKGYlLOqhCMwgEYc/sZOj5iyG2ZPqqzLMDqkYCjMjIbLr1ibBf2
 EKNXAIjDPTcHpZWF6F5Qkcdm1hsuD9g4QajiHi3WCy31WzUgbNw91Zt6V1Pj9NRNQd3V0KSKwsy
 bKfsZLfeFY57c5rIrNtoa3bxAStPAi0QzgR4S1RwFK66qEZx60D4pZB2ktGYp7XeOpS3X4qh6N8
 BsjAwrtsE9BgFdl30a2I28iEcafjXtPJRSNGjZRKkUcM+gmMKJ8+ej52CHIiMf62hOfSUddDfaX
 WVxsjO7QuNlEBhIHmXFIEBkbxdM1sBCam6T+VzqUIIg/Iacelb8iIRSOGRuN42XutsAPg4srWKK
 2Z/3nK2dgJFyy4znS+WoPRQOaoctaoUe49XLBxARhrQy+FetRtxcVq24Q1DAeOUAMqKGaBi3AI7
 7WzbOAplrRWxNSNT5TdLDqNX59D1tAYbgH9MM6j9kyfCwaJkbTxbtSaLVTmLzAf1Fq3xxRqfsNM
 VwQt5u517wID9VaJU0gFTLUHS5aN0AUUgKb2lJZ3cOa79eQqXr4RmynANSmjWs5pIRVSYPIixqe
 PIkxtkqrjiMqDwIKPfTwjkeHpHLRPqH3epkbM7h8+Ss5zqrISuZT8ZXHJoBbBqJ+BdRTfP0+dCQ
 UnrAAGmzJdV5JDQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add Iris video codec to SM8750 SoC, which comes with significantly
different powering up sequence than previous SM8650, thus different
clocks and resets.  For consistency keep existing clock and clock-names
naming, so the list shares common part.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

qcom,sm8750-videocc bindings and clock headers dependency (will fail
build):
https://lore.kernel.org/all/20241206-sm8750_videocc-v1-0-5da6e7eea2bd@quicinc.com/

qcom,sm8750-iris bindings:
https://lore.kernel.org/r/20250714-sm8750-iris-v1-0-3006293a5bc7@linaro.org
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 112 +++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 4643705021c6ca095a16d8d7cc3adac920b21e82..b569f1dc347ec70f04ca9b1d19d8c0913dd02900 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sm8750-gcc.h>
 #include <dt-bindings/clock/qcom,sm8750-tcsr.h>
+#include <dt-bindings/clock/qcom,sm8750-videocc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
@@ -2581,6 +2582,117 @@ data-pins {
 			};
 		};
 
+		iris: video-codec@aa00000 {
+			compatible = "qcom,sm8750-iris";
+			reg = <0x0 0x0aa00000 0x0 0xf0000>;
+
+			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
+				 <&videocc VIDEO_CC_MVS0C_CLK>,
+				 <&videocc VIDEO_CC_MVS0_CLK>,
+				 <&gcc GCC_VIDEO_AXI1_CLK>,
+				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK>,
+				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK>;
+			clock-names = "iface",
+				      "core",
+				      "vcodec0_core",
+				      "iface1",
+				      "core_freerun",
+				      "vcodec0_core_freerun";
+
+			dma-coherent;
+			iommus = <&apps_smmu 0x1940 0>,
+				 <&apps_smmu 0x1947 0>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mmss_noc MASTER_VIDEO_MVP QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "cpu-cfg",
+					     "video-mem";
+
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+			memory-region = <&video_mem>;
+
+			operating-points-v2 = <&iris_opp_table>;
+
+			power-domains = <&videocc VIDEO_CC_MVS0C_GDSC>,
+					<&videocc VIDEO_CC_MVS0_GDSC>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_MMCX>;
+			power-domain-names = "venus",
+					     "vcodec0",
+					     "mxc",
+					     "mmcx";
+
+			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>,
+				 <&gcc GCC_VIDEO_AXI1_CLK_ARES>,
+				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK_ARES>,
+				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK_ARES>;
+			reset-names = "bus0",
+				      "bus1",
+				      "core",
+				      "vcodec0_core";
+
+			/*
+			 * IRIS firmware is signed by vendors, only
+			 * enable in boards where the proper signed firmware
+			 * is available.
+			 */
+			status = "disabled";
+
+			iris_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-240000000 {
+					opp-hz = /bits/ 64 <240000000>;
+					required-opps = <&rpmhpd_opp_low_svs_d1>,
+							<&rpmhpd_opp_low_svs_d1>;
+				};
+
+				opp-338000000 {
+					opp-hz = /bits/ 64 <338000000>;
+					required-opps = <&rpmhpd_opp_low_svs>,
+							<&rpmhpd_opp_low_svs>;
+				};
+
+				opp-420000000 {
+					opp-hz = /bits/ 64 <420000000>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_svs>;
+				};
+
+				opp-444000000 {
+					opp-hz = /bits/ 64 <444000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-533333334 {
+					opp-hz = /bits/ 64 <533333334>;
+					required-opps = <&rpmhpd_opp_nom>,
+							<&rpmhpd_opp_nom>;
+				};
+
+				opp-630000000 {
+					opp-hz = /bits/ 64 <630000000>;
+					required-opps = <&rpmhpd_opp_turbo>,
+							<&rpmhpd_opp_turbo>;
+				};
+			};
+		};
+
+		videocc: clock-controller@aaf0000 {
+			compatible = "qcom,sm8750-videocc";
+			reg = <0x0 0x0aaf0000 0x0 0x10000>;
+			clocks = <&bi_tcxo_div2>,
+				 <&gcc GCC_VIDEO_AHB_CLK>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm8750-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x10000>, <0x0 0x164400f0 0x0 0x64>;

-- 
2.43.0


