Return-Path: <linux-kernel+bounces-731208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCA0B050EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09D61AA7DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EE42D3A7D;
	Tue, 15 Jul 2025 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A7JL0RoC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7AA2D46DC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557278; cv=none; b=Nfd7s5VWDjfHAGoMsRfTc8/zJMW/sXefM8GxwOaXyJxfAkwPYK0mf7LQUOWZXEler3hiI+ztfbQZMcedw0VuFe+nRda8JpAU+8/XC4DQB0AGDJx8keflRUMFMGncXL96VBqsg2HLDSE0QHRGfcNUrIrJXBf0Ba6/YWo4D+i5i+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557278; c=relaxed/simple;
	bh=51MNdtYntNLG/1os/32nm2tn39F84TmPT8pKmGrGibA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FMjQ3y7jEjRzuJ2C2MCHaMENXZAr/r+A1hyUExaNNzlKkhERqqI2c7J/5Qa+Sve0NTBZqooGQXfJ3o7yvm7OwCj8TUMvl24BPthVhhqfIH+I553ecJHGSjOKm6pNO4g537V7GQftoE+a+fbpUFiNJkKDLaBlCDFsxDs8YjJmQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A7JL0RoC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGwDTU013581
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8svhojvKcb7
	NeDzSyV+TkkbBI6w4vDzPtOZ0qIkJ7gE=; b=A7JL0RoCWXi0oX9Q/bmKWsJQiEv
	YnIbkWSmAnYgjE2XuRB+h01q5y0bBqDNn6bdXtSpCSxxkSslqHNnEBkBysjzD/MO
	FMd6FmV5wvsDK5wQow13gv3wKrAmfcqpQNm37y/favgO3t5+5isedEoPoY9rjQGc
	xv6+bbnAw9wouxWPyAdREf/0xQnmsBloMR9bG1JvSyyHcAOQCDe4xvhs+jnYEEOQ
	o/+N0Lkg4dRs5uCNUkgFVKqXEok5aqgmqrO8kd68x7ldITInnNP0YLVVG/+u6rX+
	pgiGixfuqmVih6Eza7TG2J4SezvWcV+P4dsZy2y/gFdehSn2Uf7BwOvxeSA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugvmy8uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:27:56 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74d15d8dcd1so3842462b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752557276; x=1753162076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8svhojvKcb7NeDzSyV+TkkbBI6w4vDzPtOZ0qIkJ7gE=;
        b=HoA2fINEwM7hedXaRZlBCZFUGtZEDgM4yirIybi5aJvYgUwqqOxJvxZ9wfHK38OJN7
         rDjxCI/+SmiUeqIfAM1IPtZuUDOp2ESr3huoTBwUYHUqfvu3pySzlc0zb/cUYHoJ8+P9
         SjJQrmtTGnhLyNZTMGtOVnyvyp2Lyy2N+U0PRGsdtFSzqI2VBDibDg/UewY6dAAyeWOH
         Q4sTLlJb5JzDuVJzBK7rfxlA+MrnUGWJ54hTRv6NAF42jH40ykGh9+rPkbPKb9skREk2
         vAzBCjI1YGcCqdQTM3vJVIaEG7+3BAWHnuSDBK9t8G9ceJIK6vnq5Mxsm0vFjmyQwKmY
         KSHw==
X-Gm-Message-State: AOJu0Yw79htwGE50iDXeIn+3yZyyJU5uwpX+CH0dAMAk84KSddqmg4QH
	1RJE3W9Zyj0tKvfc6NdLztd26J6PG1Rd+ThlqeVmkf4ZVuabDfteNGH+i5AAOVC4vNT8jJFChfS
	+Q7R3bty8FX83bNMZ4U1wQK3xim5bWAbCSXnb4pHMTXtHNB2cWP1RO+osKRhECGdViVQ=
X-Gm-Gg: ASbGncs6Cb0+wzrUBFjkG4M0F6G38IqQq/2JIqB9avPzgRV769f4f3cO5sW2jAXwyu1
	YYDRcb7c/X8uXCNpS+h179hqVuOSxqt6BVNRgb02hhNvzPt3HOg3lXfWyxwbpLCLJmjOc6FzoFT
	KV+wsEVEttd90yOtfvrRLLWFOfCnFC9Csif912yn9I1ST1fWgp3Fa48ymLWF8rxOhg5OUbxCNtr
	Gpf8UCWYneJhqpunh9flWQlF5vixKwyRoYWqaVWQByEzcbReJS/YnSxLNdLvyc3pGXe1xFJZfar
	rP4VUukc1Kd+ugBwvOqGgIvKBPYGADA0k0mXKC6eWMa3bHTmdS2jAuwH69avDa9KrcwZ26HKphM
	EJQ==
X-Received: by 2002:a05:6a00:2d08:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-74ee244a324mr21806844b3a.15.1752557275074;
        Mon, 14 Jul 2025 22:27:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0XeD/jbWxNWVKjRc2RmOnbSWjKirb5GC/CXswIUjkI8gpKZdySaeo7WrtYjWSqlw+VPpy9Q==
X-Received: by 2002:a05:6a00:2d08:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-74ee244a324mr21806812b3a.15.1752557274619;
        Mon, 14 Jul 2025 22:27:54 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f8f24dsm11071535b3a.156.2025.07.14.22.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 22:27:54 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, neil.armstrong@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v4 2/2] arm64: dts: qcom: sm8450: Flatten usb controller node
Date: Tue, 15 Jul 2025 10:57:39 +0530
Message-Id: <20250715052739.3831549-3-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715052739.3831549-1-krishna.kurapati@oss.qualcomm.com>
References: <20250715052739.3831549-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Qv9q5RrcqK8Te9KcQYIQslyxFE3GPYQ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA0NyBTYWx0ZWRfX4Y2TcOM7zAGE
 B/HG2vvwcBhrPQKif2g1Iie94rD5x8mN9sMOkMlplQa/G98N2hBn/H3rauL+7buE9WAtjfLM1hg
 reRygq84Aj9nopsv7uIjTtnOPjLXKhtoIfSSrZQCuUndKUgxxNeGw0QFlwzTtG577NG8h4og6Yj
 PcmRDrbXhGHecOHpEeJQhG+WRHbscISilWw4SnQ4BC6d3oihUNTZTmoYmGvc8sfIPFSZvfTbdUr
 +loIJP4yhya/ti7j9H4gDn8cEdzS3647N2nqqAUSY1ymXuE0ShHmLCPmz4+EyegnqGWCx0uOF/w
 aewFv7CXhDb2K8ogi/yNwrZcY+jkSdNIRdrp/Etgx4JGiRLDardBNJO6WqIy84sYsACABcDpjl1
 z2cXdSXYhAQd+95lfKTn2ajuHUaebLsajh/nCtwzOVs8Pdl7IDzohHYcm/SALZHhUCmxLgiH
X-Proofpoint-ORIG-GUID: Qv9q5RrcqK8Te9KcQYIQslyxFE3GPYQ8
X-Authority-Analysis: v=2.4 cv=C4fpyRP+ c=1 sm=1 tr=0 ts=6875e6dc cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=xmYAXJzybh8o0rWYL1AA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150047

Flatten usb controller node and update to using latest bindings
and flattened driver approach.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
index 54c6d0fdb2af..89dbac3bdd2b 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -5417,12 +5417,9 @@ opp-202000000 {
 		};
 
 		usb_1: usb@a6f8800 {
-			compatible = "qcom,sm8450-dwc3", "qcom,dwc3";
-			reg = <0 0x0a6f8800 0 0x400>;
+			compatible = "qcom,sm8450-dwc3", "qcom,snps-dwc3";
+			reg = <0 0x0a600000 0 0xfc100>;
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


