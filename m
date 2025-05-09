Return-Path: <linux-kernel+bounces-641944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C2CAB186E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 17:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572E1A01FBD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 15:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF3F222595;
	Fri,  9 May 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2uNbo/F"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4FF2163B2
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804510; cv=none; b=QWGQV2TBw6mFGJkfwlOwTLR/Q/gLAoTUx381RsYNcLga4lpTUhgcafDHZzSDV2dC+MJq/DmI0v8dujOqQBkk4e6kpWEva3zX5NeTvmSNjmVox4s3La2NSXA7bgcL7H+M1/r3Gl2Izz6SL9kzhwwVeOp/speYO63xpg+hLQL0QxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804510; c=relaxed/simple;
	bh=0Zp+4rH5PI+hyXzfoQEydKvkJLlmG0cNFdeKIrnFtsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uTkqgxy4xRv8fG6CWrIsKsD5PCedcmLjiLX+1PNABtml33eccMgW778ceYlP6qjChYrgRYCS/SF0QvnXm6f3IbYU+poDLCutxzNi8HTv4g4ioQj2rvFtdcPbIo1JJbogICSHsXGi5nAEjg8DUdDcX0Ybn+VRaGW8P3E45X3v/Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X2uNbo/F; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so11874375e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746804506; x=1747409306; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tfGizqbq7nuIeZrlu1d/p+687hpoKqn9LANEb6sdVXQ=;
        b=X2uNbo/FXuzktshQ43nh2Ft4SBisdn/356iYclwcULH853VXei7UkVxzZ3qKKuIsEA
         4e/sy1sNcnwKPKo7GJyR/tSNTUpGumvqaVOASPAAsSIZlUhRh8wYzbgwDE5zHeHiQ+Vw
         ojzgp/EUDlTguHYlOEIcvqbicup6ZTE6jaabRdRmT1f8SUNjwCFpQEwJyuTrT8Wd726n
         vDVpLnFFTJeKyY621Bs5jtq0s+JcDbO3Izi8Uv791C32MBCdEhdG9VTsn5PooIOnIZxc
         ha8DXEBAPve2AwFN9EkNhX173ZZxuTaty+aWVEtS0YHOfbgIhXJ74ekyxmqCYVfgzkwX
         37IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746804506; x=1747409306;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfGizqbq7nuIeZrlu1d/p+687hpoKqn9LANEb6sdVXQ=;
        b=piEWVPk2i7J4h5nCg/Onh2uVkQrd9KrednbkTReF000yz8fPTN0W4+jjIsPek2R8SF
         kZ3c8wUj4i/UJ/jKHRgH3eb1O2dTpEP1g0/lkQlPdQ+aGnjBBTOjePo4eJ3Z7l/6MlYi
         Q3jT0+BqTagpIcCLruiwZUkR1pyX1lDwZYFh+AjaJbQunJF/ugVGQIpP8GLowQGZEvN6
         ro8AtHINVO9Gvq5vjRIKOJR2A7Le6RhCCir9GMy+2FP0A2qgrR7mrJeaDX525VnuMDyD
         yeUDS6ZpXdlbcE6muybyi5wjvRNRKGZMXVt8R7JKJz8j7v1XF8sKb3ncGfA2V31kLljR
         FV3w==
X-Forwarded-Encrypted: i=1; AJvYcCVNZLfi2OCihQ+YdQ7zXPEO9w04U6jXeypgdQnni2i6TVDfq3LG0jmeq1QMnPl8JeftGzFMms7C2cBVHnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfTQii0fN1B/dMUVFpnorgI73iNV0Ms+CB84RwtueWdSuQ0Smp
	8EysndCpXqHWOBvNWUfoGQOvitr2IjnH454EApTHEFeX2AA5szlualIo7l1H/2Y=
X-Gm-Gg: ASbGnctW2qFas5CamHaOrM/NUn3YxEbAWaZ0879kUJQA90q2t/91Nk+X5W4y3jQuXTG
	NiuWi6PrN/TMSnQ9OSONLpEQ9XMTi8AMYxn5XgfK3LtW/yk5bIdk9QLdQzpb3HFo2TcmSMqiJXg
	RNEQECdhiV23b+4CMrStktAIDHgx5LM3FeWBcWO+6gXZmmpB8UGuPQg39gbd3a06mFeMkVqmadR
	Kib2O6YC9Tixsg+2yqsluXEXHzqWkTnRZO8imbANnDldxEh/kYU7I0oqbmcc5Wlo9j+iHue9D4E
	shTN5ygmUoMjxDyhaf1RRqdKh7IrFdS4MZke6dpp2550Y542PbfbJnKYmGQ1Gw==
X-Google-Smtp-Source: AGHT+IHexcEAkmuoVCrQnHs327DV7IVAnWdt2iAb3A4HUMvJoyWUf8FVxzA4b2/jnVDLjE6ONY72yA==
X-Received: by 2002:a05:600c:4e46:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-442d6d3dafbmr37212485e9.12.1746804506380;
        Fri, 09 May 2025 08:28:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d5c7bsm33733945e9.4.2025.05.09.08.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 08:28:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 09 May 2025 17:28:22 +0200
Subject: [PATCH v3] arm64: dts: qcom: sm8650: add iris DT node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-topic-sm8x50-upstream-iris-8650-dt-v3-1-f6842e0a8208@linaro.org>
X-B4-Tracking: v=1; b=H4sIABUfHmgC/5XNsQ6CMBSF4Vchnb2mrRSLk+9hHApt4SZCSVsbD
 OHdLUy66fif4TsLCcajCeRSLMSbhAHdmON0KEjbq7EzgDo34ZQLWjIJ0U3YQhjkLCg8pxC9UQO
 gxwCyypOOoHlblUrUggpLMjR5Y3HeT2733D2G6Pxr/0xsW//iEwMGkqpKGUEby+j1gaPy7uh8R
 zY/8Q+Tlz+ZPJta14zKxgp5tl/muq5vrRW5BykBAAA=
X-Change-ID: 20250418-topic-sm8x50-upstream-iris-8650-dt-d2c64a59505f
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5322;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=0Zp+4rH5PI+hyXzfoQEydKvkJLlmG0cNFdeKIrnFtsI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoHh8ZLhKHUyg6R3B56hlSAmGgpeZYqqUiZIb47iDU
 5SYGPHCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaB4fGQAKCRB33NvayMhJ0bp/D/
 9xDuitym1ShXZ22g6IyWff1FuxqGYTKDA6RqMRJND7IysG17TFMuLE4MePX9W6fOOn8McFSpNagB4q
 z3DbB+zO3V0dNKXAtLC9jbFXhyOVGwM2JUW+81aO8lJBD8uaM3xtVFKLdAoRK6BKVWZ8em/ZWkj24C
 jv17nbNRe3exHjt7BUrcljBu+UiSfte8Lm1urR/gWX8QAhCvijKAy1EIxUJpsXUBf2TZkBFK07JriX
 5aFYzcc1jvebNiAU4n6lO3W8N8qUQlqiIR1hwaOo/BKh6tiAooktIHHFuPgu04qE97dVnfViv7xNtC
 qBxNLsRw/6WxC4pTulcNKnlGiItJWZnX9PZbb0x0c8pmiJr0jbpKpgrwLcYpHFlucYU3uQroRZtSYc
 FPgDxdRqCcM2fEkBpsi4VVzjzuC3Cv7Ss5FcUm3/txAe8K7d7kb5+Xs35zHwLEZAvLdci+t5wIyEyn
 mYZ0avDdIdgRRdlsXPSDXs4oWPrdf6MR2ngdo9QziKBej3+yl6hyjqXD6Q/CDssk6cB/48/c8b3nIm
 OhFUBpX1qSYbwQ3S4FjzHE0tBJRb9M+OXOe/BX7G2uOoeGYc7AJc/K3Y+KYVNJ82tdjgH0aET1VUNf
 jLL/+f829mtVmxIW/XhhfZskdnB9ZXEAF6tPTWdNmfO+nvMG4K0T8Itci+2g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add DT entries for the sm8650 iris decoder.

Since the firmware is required to be signed, only enable
on Qualcomm development boards where the firmware is
available.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Removed useless comment
- Fixed opp required-opps
- Link to v2: https://lore.kernel.org/r/20250424-topic-sm8x50-upstream-iris-8650-dt-v2-1-dd9108bf587f@linaro.org

Changes in v2:
- removed useless firmware-name
- Link to v1: https://lore.kernel.org/r/20250418-topic-sm8x50-upstream-iris-8650-dt-v1-1-80a6ae50bf10@linaro.org
---
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts |  4 ++
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts |  4 ++
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts |  4 ++
 arch/arm64/boot/dts/qcom/sm8650.dtsi    | 93 +++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index d0912735b54e5090f9f213c2c9341e03effbbbff..259649d7dcd768ecf93c9473adc1738e7d715b6c 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -894,6 +894,10 @@ &ipa {
 	status = "okay";
 };
 
+&iris {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
index 76ef43c10f77d8329ccf0a05c9d590a46372315f..8a957adbfb383411153506e46d4c9acfb02e3114 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
@@ -585,6 +585,10 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&iris {
+	status = "okay";
+};
+
 &lpass_tlmm {
 	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
 		pins = "gpio21";
diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 71033fba21b56bc63620dca3e453c14191739675..7552d5d3fb4020e61d47242b447c9ecbec5f8d55 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -824,6 +824,10 @@ &ipa {
 	status = "okay";
 };
 
+&iris {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index c2937f7217943c4ca91a91eadc8259b2d6a01372..30dc4937acc62df582768403db3ff9c919f11e72 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4955,6 +4955,99 @@ opp-202000000 {
 			};
 		};
 
+		iris: video-codec@aa00000 {
+			compatible = "qcom,sm8650-iris";
+			reg = <0 0x0aa00000 0 0xf0000>;
+
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH 0>;
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
+			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>,
+				 <&videocc VIDEO_CC_XO_CLK_ARES>,
+				 <&videocc VIDEO_CC_MVS0C_CLK_ARES>;
+			reset-names = "bus",
+				      "xo",
+				      "core";
+
+			iommus = <&apps_smmu 0x1940 0>,
+				 <&apps_smmu 0x1947 0>;
+
+			dma-coherent;
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
+				opp-196000000 {
+					opp-hz = /bits/ 64 <196000000>;
+					required-opps = <&rpmhpd_opp_low_svs_d1>,
+							<&rpmhpd_opp_low_svs_d1>;
+				};
+
+				opp-300000000 {
+					opp-hz = /bits/ 64 <300000000>;
+					required-opps = <&rpmhpd_opp_low_svs>,
+							<&rpmhpd_opp_low_svs>;
+				};
+
+				opp-380000000 {
+					opp-hz = /bits/ 64 <380000000>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_svs>;
+				};
+
+				opp-435000000 {
+					opp-hz = /bits/ 64 <435000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-480000000 {
+					opp-hz = /bits/ 64 <480000000>;
+					required-opps = <&rpmhpd_opp_nom>,
+							<&rpmhpd_opp_nom>;
+				};
+
+				opp-533333334 {
+					opp-hz = /bits/ 64 <533333334>;
+					required-opps = <&rpmhpd_opp_turbo>,
+							<&rpmhpd_opp_turbo>;
+				};
+			};
+		};
+
 		videocc: clock-controller@aaf0000 {
 			compatible = "qcom,sm8650-videocc";
 			reg = <0 0x0aaf0000 0 0x10000>;

---
base-commit: a7dca088884312d607fff89f2666c670cb7073ac
change-id: 20250418-topic-sm8x50-upstream-iris-8650-dt-d2c64a59505f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


