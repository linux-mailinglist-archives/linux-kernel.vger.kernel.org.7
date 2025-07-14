Return-Path: <linux-kernel+bounces-729359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BF8B03563
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BEDE3B9B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDBF22A807;
	Mon, 14 Jul 2025 04:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HsgihV6R"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0D5229B36
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468815; cv=none; b=A6/QB74NWUQZyppU0hhxWJAsI1pww6P2g8Niy9P+94Yy4xy7HxRCMoH/aRdrNuC1SJllCrcf4C8bMxz4Pr0gf7fXvMWdqTQJYFG0jt4KZUlDD+yQ6uOuyJOUlasa7NG4AYokSmjAiPxS7cSI+j4DTBpgenm2YarCGg0U5bnvhKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468815; c=relaxed/simple;
	bh=NmP+z2gJhCckmjfrrn6o5QQ2wttiVpsior0DP9i+DfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R4L7xfE/XQ9jLMPcJeysdgEO3vySAqlAKT2mhVfUKRufM8Roc4jG3B+wIYxnLEPGcoyhqLx0nUlR+8ifyo0lBC6nVBHfpwh7iiH5BourpuNAJjSei8hIeaDV3HPG+ZnKDn1324v41b/Q5nQhFsZxtuSlM5SsACpV3aRjxsINmKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HsgihV6R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DLO34l005981
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=u43++Fr6U58
	TyPcHVzc+ZU40XgfyA9QmeiVTvprQmbs=; b=HsgihV6RAnsZpdrY+WGkb+qQfo9
	Tooe25XcGGqmmJjakZkRZLvfGlS2/bPeom8UzZ2N5guCena/tUcD4drHsmETEXL7
	/i7eQ2K2ffiWmc1U7DwVZSdu98a9t8j0c8JNOLcreRVy6bny0tzZ5HlCYgn4tgQ4
	LYN56ZGDe+l9ViIUPnV8IDFKaJe+4Gy+QA5BojhGyC2JzrYKL2GOIHeap4OUYKdy
	cZUaq2g124pCHFjk6L56DMemJxasyvt/GG6nPgQZTOw5Ly2BaFte4REkw8gXSnUv
	lFG4qMh00FM75HZRWNhzHt9VEmf0WcXNnx/0xx1MQ9AdKxEsVhBNvVMpwCw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxau9ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:53:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235e7550f7bso37834365ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 21:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752468811; x=1753073611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u43++Fr6U58TyPcHVzc+ZU40XgfyA9QmeiVTvprQmbs=;
        b=K8xDYl+lnfFdZANvhONeIXH0Wx5ZgFXJaCjcvHA16Jol+TgDYqn5WZnTybjYj8FaEO
         0qEW7VbeX/xgXyO6PPzQ/4ldoz3BfCe9TdPFrQGgcKE644V9xKwn+FutSzxgWTAUbOeD
         O4pEy+O3zpvcWC+N6oFHWnluP/cAYGBp0LAiBLdJJFlLEq787dlr7cEDMPDuhBVqGgT0
         F0wdcpu9DaK6k53DIIjPb6ZUoZKPlCP2B16VnMn9fumZbGCHikNSNm+tLQ4zCcvmrutP
         2MKFy41cUbdaVpaw+cxFldJG+R3Zcf4n23On0zW92m4s4w6JShY1jgKD6+wNFi7+O4nS
         hCZA==
X-Gm-Message-State: AOJu0YxkyEslIm1ypG/vVqASmfIeD+xtj6L9A6ubeFkCjszr/BFuDwvC
	QzW4lWlMo2n5PAiApJzNSHNd5+Cn5WksMTKFioId9+AIShM+k5Ztb51q+UNKD3diMX5Fn6jZRUc
	ni4Kt0m3lhGsKv5XDvA8ie5+aNoOoUHR4NJE7VlIDibeXgky1JIgUXx2Isekk/eJs5pHeANt2IO
	s=
X-Gm-Gg: ASbGncu7sSCVAPfreXRfIMZ7ZNcKo9mjEvVttKqMChi4OoQ4VfdvqtEvgIHGidwTygn
	XVip5gVJrY9jX4Ol7SvYx3/VEQIP19h0tqmP46d9HjGgrhxTGVpbzj15P49xGRv4zaw0rJUtDud
	vzz+Riywfz2R+/QbZ3sCyS3f3YSPSw7cQ7tFhCy30oH3AlHEWB7o1nQkr/alagcRLv1FMvz/opR
	jmOwF7QTyM7Yfrob8kLPkuUx9WQWyfy38rNVTiMeqv9B94kgb+9mMGQI9BisrYdIsfPws4xHMVF
	bW8fzdr2zv7ZPi+iMtP4x8Fqqvyzd1TTO/K0Z6eUfXogem9sqMFOltLn+ySLFZOIZyoDCkIRYkh
	UaQ==
X-Received: by 2002:a17:902:db0f:b0:236:7050:74af with SMTP id d9443c01a7336-23dede2eba2mr163384005ad.9.1752468811361;
        Sun, 13 Jul 2025 21:53:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6EU8TSHV5uuBurO9qW84gRt/Y6qmDB6VzkjDqa3YDrOiAXIDj4JW8F75hHUYBybfWtcVO5g==
X-Received: by 2002:a17:902:db0f:b0:236:7050:74af with SMTP id d9443c01a7336-23dede2eba2mr163383785ad.9.1752468810933;
        Sun, 13 Jul 2025 21:53:30 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42864a8sm85664325ad.42.2025.07.13.21.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 21:53:30 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, neil.armstrong@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v3 2/2] arm64: dts: qcom: sm8450: Flatten usb controller node
Date: Mon, 14 Jul 2025 10:23:10 +0530
Message-Id: <20250714045310.2092385-3-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714045310.2092385-1-krishna.kurapati@oss.qualcomm.com>
References: <20250714045310.2092385-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ROuaXaO_NYewA-zukkLknQYfmNwTXaft
X-Proofpoint-ORIG-GUID: ROuaXaO_NYewA-zukkLknQYfmNwTXaft
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAyNiBTYWx0ZWRfXwQp00jqx0B2s
 BEjpPQI+2XGPKUYQHciCMwtqdFY1rJaN4oeAjrBCvPniyckqek7IcUVPRdZ6JkivewTRRUywMwG
 ByCEDE6mPwhbDdbJHi16qHL5tt758Hr4zArONH86Qs5c5vWBn1PCtveATBJkL7ELw4zsxINkCC8
 Jw952Lf8JdBGdpFQCIj44U4cwIYztlNw/4FiZB+CyJIRY7rQW9FCDfXoAqf/e4K9q/XNmCe1oBJ
 BW57IqboWBEe3puCVstMSO3qKkR8Hv0evdFSlolfE0X3LNDiPFb76fp2MJIHveCh7lcrV7scoeo
 rig7nvJH27eF2H/in4AZUl0/XIxwQLuWL+qaaR+WrCBn3fsM+oeu6+ACunln7G/9B1y14Cb4Gj4
 c6i7YQCeUBgjojGFOfVjsek9bfWLvVDC7huIf7MXLfQKSdggudoKhS8fmslGw5vEOzyJSNkp
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=68748d4d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=xmYAXJzybh8o0rWYL1AA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140026

Flatten usb controller node and update to using latest bindings
and flattened driver approach.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |  5 --
 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   |  5 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 57 +++++++++----------
 3 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 2ff40a120aad..0c6aa7ddf432 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -1199,11 +1199,6 @@ &usb_1 {
 	status = "okay";
 };
 
-&usb_1_dwc3 {
-	dr_mode = "otg";
-	usb-role-switch;
-};
-
 &usb_1_dwc3_hs {
 	remote-endpoint = <&pmic_glink_hs_in>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
index cc1335a07a35..6bd315e10992 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
@@ -781,11 +781,8 @@ &uart7 {
 };
 
 &usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
 	dr_mode = "peripheral";
+	status = "okay";
 };
 
 &usb_1_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 54c6d0fdb2af..77104def5ced 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -5417,12 +5417,9 @@ opp-202000000 {
 		};
 
 		usb_1: usb@a6f8800 {
-			compatible = "qcom,sm8450-dwc3", "qcom,dwc3";
-			reg = <0 0x0a6f8800 0 0x400>;
+			compatible = "qcom,sm8450-dwc3", "qcom,snps-dwc3";
+			reg = <0 0x0a600000 0 0x10000>;
 			status = "disabled";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
 
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
@@ -5441,12 +5438,14 @@ usb_1: usb@a6f8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					      <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "pwr_event",
+			interrupt-names = "dwc_usb3",
+					  "pwr_event",
 					  "hs_phy_irq",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq",
@@ -5460,36 +5459,32 @@ usb_1: usb@a6f8800 {
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
-			usb_1_dwc3: usb@a600000 {
-				compatible = "snps,dwc3";
-				reg = <0 0x0a600000 0 0xcd00>;
-				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-				iommus = <&apps_smmu 0x0 0x0>;
-				snps,dis_u2_susphy_quirk;
-				snps,dis_u3_susphy_quirk;
-				snps,dis_enblslpm_quirk;
-				snps,dis-u1-entry-quirk;
-				snps,dis-u2-entry-quirk;
-				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
-				phy-names = "usb2-phy", "usb3-phy";
+			iommus = <&apps_smmu 0x0 0x0>;
+			snps,dis_u2_susphy_quirk;
+			snps,dis_u3_susphy_quirk;
+			snps,dis_enblslpm_quirk;
+			snps,dis-u1-entry-quirk;
+			snps,dis-u2-entry-quirk;
+			phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
+			phy-names = "usb2-phy", "usb3-phy";
+			usb-role-switch;
 
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
-							remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
-						};
+					usb_1_dwc3_ss: endpoint {
+						remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
 					};
 				};
 			};
-- 
2.34.1


