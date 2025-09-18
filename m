Return-Path: <linux-kernel+bounces-762587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6772FB208BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB83C423A45
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90462D3733;
	Mon, 11 Aug 2025 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVLQSNaS"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8EB2D3A94
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915126; cv=none; b=nBjNJLfejicjhVHYSF6LX2GcsYJHoKnp7jBQBjc/b9s5+IZ0XuK6ZfVYOlxCoutTgMNVITSQQkw3uEAK0Mg66Cc3iSPORe1quh06Z99NWqBELlJ0X6swSOukEh5qHiqVmG7WCrAxIPovvZwCyqRimjf1/GGcGHek8j7Qcc0rMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915126; c=relaxed/simple;
	bh=n6T5GhUysgMZGgbWj0uqn+CFLJN1qzaodZC5ot+Vkv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PHf3t4XMIFvpU8HycjgqraEGHIu7jZq2htUvAXtrPQD/jXkF7vyAbfsqa0svqn/dJFKW7ussE0m8v2nLKhd5bMyHY84KCd2xi/02kom9++WdTdMU2Vvx+cwYHICD3q9VM2JWEN+VSQi0Sqvjs/T6XAY/dG5XEhCbmFcdCfFWreo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UVLQSNaS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so21423555e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754915122; x=1755519922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLqlhHSdqib3orjcSPHkGKRVwVxunkxH/1/tKc5ugRo=;
        b=UVLQSNaSrPilO4B1iGxIoK2cQT5/xoR474Za3zKeqNcIVKwpslYWP8Yq4FuyUPkun/
         HTdjMXY25RJn1XY0XtiNLrQM6W2BnuiDwCmAoxEBVEDT2dkiA73g/bEQtZakt2sA8yTp
         b7WxfOJoI9zs3qq15ut1lh44BNqepOr3dZzXinfnLIN5NyM/piD2aDeN3jYmviD6gO70
         Pb1Drd2SjbCnFPK2SHMsLl0A5mnuCBe6r8w85KdujXyRCPfNQgAFh665OVFkMnp1vfIx
         cScjj2E8An38X75KPU9ua5OFblY/bmlGJGXUMRiy1WGwj2g7Kenqpe3/Y1+zeHKpTJZE
         nTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754915122; x=1755519922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLqlhHSdqib3orjcSPHkGKRVwVxunkxH/1/tKc5ugRo=;
        b=hr2YErMsWWoomv7D/pNKYxuhFi96HYG8nbaUeVfSTeknLO9PsI+X0w78X9aTgy5YOM
         Zx0+lFfDyXQSCLWIWKrnC/2qLq/WLZ1umoTC15TQuLN7DvN+f6H9FHA9XKm77dMoPhlm
         IeVpoDy/z370RqHjmqRcCfx9kHBwYlTIOhh4ciX2TXWbBjqvqE2+ZPHcvDsoMOJJsAlx
         rSlXZ/SXbMTPwNYyeO8zD44Eanu+rRpftM0olhoRkJP314LhjPBXrGFNjiz8jEh7fU/d
         pgQxhfrXXcGShXu1HslkXyYVwvBHWkrRvUMw7KAuetJhUmuiROVYdUQPONRizi5tsbHS
         lOZg==
X-Forwarded-Encrypted: i=1; AJvYcCXFrrzl7S7W9bVsmom0LaXmB+X0oDk3/WuqczSzg1ErneI1NBs1AMs33jW1+keDkAPGRjm8xtKO4fGZvFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ5bG2rqlamVx3DlljXhcoUX/qeS/QMG7dgFnUPkaA08AV1sK4
	O3NRB1btTcvRlA5MrreVojJrbeVwrK3BYuP/Al6AVCXd9XhwYHwqLxWMCw+AaI7BgS0=
X-Gm-Gg: ASbGncvQJzJfHWfyIenm3W+jF6tfDIssWATkrQx9UIUc6tmFTJvgsIwfR+26gvVmqWD
	UpvIK2N/RhmBw8x7vsLgMjyj+F060eN1Ak1lBmPE+Z8/Buv81PYUp167k3hwIZxraB5AB48k56e
	qhyRkOK2oPOLVK/ZUeK5KlOvl/Ao/QYdZxi4eUkczB+miRVuO6vH/eGmluLV40gqJSjHIyzlHzt
	kTA/lflIG17Usu6e+SoW/082FvLfkSyEUTgdmP3FHG5l68vdd0KrbbUaLzrxHB5Zk1EOXUiM3eX
	5bTtrcVOqhntk+wXRap5fS/3y+G9u9RYT/WkXwqTU3AO5N+lWfOxke8pQ29ylyA351ZYFD5H72p
	NA/unmZUBC9jVXbi2zpE2Dp4nbL1jFBTyKt6qmsayXaQ=
X-Google-Smtp-Source: AGHT+IEO/D3Kf0FEExOrijHou096dDtBPWCLjC1WgVsjGIgzijMpCDE2xPmlCCIGCuY8d0Y0NY1PGg==
X-Received: by 2002:a05:600c:3b9e:b0:456:285b:db3c with SMTP id 5b1f17b1804b1-459ff5a7a67mr70226905e9.3.1754915122311;
        Mon, 11 Aug 2025 05:25:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5d0b1afsm248013475e9.26.2025.08.11.05.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:25:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 11 Aug 2025 14:25:18 +0200
Subject: [PATCH v2 2/2] arm64: dts: qcom: sm8650: Flatten the USB nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-topic-sm8x50-usb-flatten-v2-2-0bbb3ac292e4@linaro.org>
References: <20250811-topic-sm8x50-usb-flatten-v2-0-0bbb3ac292e4@linaro.org>
In-Reply-To: <20250811-topic-sm8x50-usb-flatten-v2-0-0bbb3ac292e4@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5739;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=n6T5GhUysgMZGgbWj0uqn+CFLJN1qzaodZC5ot+Vkv0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBomeEvWsHn0f5DU/lw77i8DW5ulsIAcomwTc/Vozd6
 aR/PJvmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaJnhLwAKCRB33NvayMhJ0UuuEA
 CCh99wAzxF8LXcnzalK3YrahyKbv6dAkIHdvBXq0KXe9sHglhMt+5sj+wl0ZhchXIDfW7aSxwevdAv
 ruLKqjPSgq5/SABUqQcUrKJ3lvfD6/hLPqxDfpN18cB3QRpaOgetkDRGVta5CmWvwJxROwftwr3kLP
 iBVn0iPdM2AFRMGJ5QktipG9n7WvKHJ/g8eub7uZtPtqYW+C6ia1qhiwg8AVVLq4ZDYdUQbnvhrkvw
 cI856VZjp7imiw4EYnxzxslTAc8V6VsqPAEXa+7YZ5kl5ZY54ZiKR9qD5jOvCnPCK/X7hu3g8hJu2I
 68TKyRyJxxhenEfT1CrS11KJl2lfhMlLOMW52tKKNtqBwREPxpO0hGGn/V9bc1u65UCfNyiIL4Kprf
 Gydsr7AXPhipTzRFZXlpSEliclmMRh1OvJzHn4y2KmdfLlt1qVb3WT1Oydn5s3ha1CY2CWbj/cCzud
 wf+WLZ3eKAeMzYMP4Lk6jtTQ6NSM8pDhV5UBHgIxq+RNAmU33+E6ICSA70XSM6x21pqDTp6sQ/vAmH
 sE2O7CWftIJ46/d3n45zpcS5o9eYg5CDkBLzTBqi5GAaLr4QyE5/JPKivaRLCPqSbUI9lsPQezCHJN
 aprBbphUzxCjRPXr1Wf/7AAon2MnHiCJN5IT1Iz0mKQ0nvUEmYZPD7cV8boA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Transition the USB controllers found in the SM8650 SoC to the newly
introduced, flattened representation of the Qualcomm USB block.

The reg and interrupts properties from the usb child node are merged
with their counterpart in the outer node, remaining properties and child
nodes are simply moved.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts |  6 +--
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts |  6 +--
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts |  6 +--
 arch/arm64/boot/dts/qcom/sm8650.dtsi    | 86 +++++++++++++++------------------
 4 files changed, 46 insertions(+), 58 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index 259649d7dcd768ecf93c9473adc1738e7d715b6c..a00da76a60620b998973cab189f12eeaa0a448fa 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -1310,12 +1310,10 @@ &ufs_mem_phy {
  */
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "otg";
 	usb-role-switch;
+
+	status = "okay";
 };
 
 &usb_1_dwc3_hs {
diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
index 8a957adbfb383411153506e46d4c9acfb02e3114..c67bbace27439ad67cfb247a88aec633f93f5a6d 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
@@ -857,12 +857,10 @@ &ufs_mem_phy {
  */
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "otg";
 	usb-role-switch;
+
+	status = "okay";
 };
 
 &usb_1_dwc3_hs {
diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 7552d5d3fb4020e61d47242b447c9ecbec5f8d55..081b7e40f5742120a611cbfa57a59dfb1dc19b9f 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -1293,12 +1293,10 @@ &ufs_mem_phy {
  */
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "otg";
 	usb-role-switch;
+
+	status = "okay";
 };
 
 &usb_1_dwc3_hs {
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index e14d3d778b71bbbd0c8fcc851eebc9df9ac09c31..bcafd9cf3eae6ad10d1ddb681829b1561d57e8f3 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5651,16 +5651,18 @@ usb_dp_qmpphy_dp_in: endpoint {
 			};
 		};
 
-		usb_1: usb@a6f8800 {
-			compatible = "qcom,sm8650-dwc3", "qcom,dwc3";
-			reg = <0 0x0a6f8800 0 0x400>;
+		usb_1: usb@a600000 {
+			compatible = "qcom,sm8650-dwc3", "qcom,snps-dwc3";
+			reg = <0 0x0a600000 0 0xfc100>;
 
-			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH 0>,
+			interrupts-extended = <&intc GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH 0>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH 0>,
 					      <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>,
 					      <&pdc 14 IRQ_TYPE_EDGE_RISING>,
 					      <&pdc 15 IRQ_TYPE_EDGE_RISING>,
 					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "pwr_event",
+			interrupt-names = "dwc_usb3",
+					  "pwr_event",
 					  "hs_phy_irq",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq",
@@ -5685,6 +5687,11 @@ usb_1: usb@a6f8800 {
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 
+			phys = <&usb_1_hsphy>,
+			       <&usb_dp_qmpphy QMP_USB43DP_USB3_PHY>;
+			phy-names = "usb2-phy",
+				    "usb3-phy";
+
 			interconnects = <&aggre1_noc MASTER_USB3_0 QCOM_ICC_TAG_ALWAYS
 					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
@@ -5692,59 +5699,46 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			interconnect-names = "usb-ddr",
 					     "apps-usb";
 
+			iommus = <&apps_smmu 0x40 0>;
+
 			power-domains = <&gcc USB30_PRIM_GDSC>;
 			required-opps = <&rpmhpd_opp_nom>;
 
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-
-			status = "disabled";
-
-			usb_1_dwc3: usb@a600000 {
-				compatible = "snps,dwc3";
-				reg = <0 0x0a600000 0 0xcd00>;
+			snps,hird-threshold = /bits/ 8 <0x0>;
+			snps,usb2-gadget-lpm-disable;
+			snps,dis_u2_susphy_quirk;
+			snps,dis_enblslpm_quirk;
+			snps,dis-u1-entry-quirk;
+			snps,dis-u2-entry-quirk;
+			snps,is-utmi-l1-suspend;
+			snps,usb3_lpm_capable;
+			snps,usb2-lpm-disable;
+			snps,has-lpm-erratum;
+			tx-fifo-resize;
 
-				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH 0>;
-
-				iommus = <&apps_smmu 0x40 0>;
-
-				phys = <&usb_1_hsphy>,
-				       <&usb_dp_qmpphy QMP_USB43DP_USB3_PHY>;
-				phy-names = "usb2-phy",
-					    "usb3-phy";
+			dma-coherent;
 
-				snps,hird-threshold = /bits/ 8 <0x0>;
-				snps,usb2-gadget-lpm-disable;
-				snps,dis_u2_susphy_quirk;
-				snps,dis_enblslpm_quirk;
-				snps,dis-u1-entry-quirk;
-				snps,dis-u2-entry-quirk;
-				snps,is-utmi-l1-suspend;
-				snps,usb3_lpm_capable;
-				snps,usb2-lpm-disable;
-				snps,has-lpm-erratum;
-				tx-fifo-resize;
+			#address-cells = <1>;
+			#size-cells = <0>;
 
-				dma-coherent;
+			status = "disabled";
 
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-					port@0 {
-						reg = <0>;
+				port@0 {
+					reg = <0>;
 
-						usb_1_dwc3_hs: endpoint {
-						};
+					usb_1_dwc3_hs: endpoint {
 					};
+				};
 
-					port@1 {
-						reg = <1>;
+				port@1 {
+					reg = <1>;
 
-						usb_1_dwc3_ss: endpoint {
-							remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
-						};
+					usb_1_dwc3_ss: endpoint {
+						remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 					};
 				};
 			};

-- 
2.34.1


