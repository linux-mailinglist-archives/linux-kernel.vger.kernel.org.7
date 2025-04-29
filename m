Return-Path: <linux-kernel+bounces-625546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF7CAA16B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 19:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8579846BA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD2021883E;
	Tue, 29 Apr 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lzSDBjNr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B2253326;
	Tue, 29 Apr 2025 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948028; cv=none; b=VZ0B4InfUna6HyThmLh5rGD3LLOJe+vbxc2T61Ig8NdktmPPtwtmEYcXSyW2seCb++oyIaGLFcBKJONRslgSkitrXstcPBBN9wYkr/dxC5Dc1WoZgG/IFYMXQDXwML94UUyuZL3vkTyoWNHToYOveMi0U0ILUjDmBvrD4+yw28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948028; c=relaxed/simple;
	bh=t6/hWCA1grGHoIHiFtvOmFAEBTfNbaRNZd2pncBhxus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uf5AQBMCcloND/vH4qDtnlWHaEpUPjOMPAFZPtnx1QMiloH3dkGJBolkY3acd431evBTFbjRb3XjlI5RQ/LWYMXX91U7xuQUZVeBnNuXf94DTTLShtmpnH1ukyP0JThCkOurC8fO7L9CiFpfXRppkefLSw9m2dpXEIxuF9FKFAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lzSDBjNr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TA1wrN020416;
	Tue, 29 Apr 2025 17:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XEJ8wBoGTSbgfPw8axk/vj/pO/WGoBzlNOx
	8Anv+Ta4=; b=lzSDBjNrHK+77mrXJJ2gYkN2BzdpwBqtuxMSaXtHRaCV6niFasL
	lLmL5QgCvpZC4wvorD4UKs7EMb0QUdOnWoXYkGNzCCNNKhH/+KGQUqh+RNTeLrk1
	jvS6Nk2tJoXf0PH7DvX+eci6TP8zSUFPpvbBy/nC5Rsz1DQyvJXdb0YsYY/7bcAp
	UIGgPoXfu9wUuFinsLcm2IToyEpLK2M+ULtDJ+fpTZrmVBOfoFRAM0XGaixay8T3
	bICoA4pN/xHm+puukBZdRbqsUUbO9Z3JEBC3QNQ0rYieYcYzdFSdQoJdOUSQ2RLa
	Df11MePERg+9JLGkJ6icx+hJcqRjOiOU3qg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468n6jmnqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 17:33:40 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 53THXbXb009354;
	Tue, 29 Apr 2025 17:33:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 468rjm1s8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 17:33:37 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53THXbhw009349;
	Tue, 29 Apr 2025 17:33:37 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com ([10.213.97.252])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 53THXba0009346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 17:33:37 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4047106)
	id 802F956E; Tue, 29 Apr 2025 23:03:36 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v3] arm64: dts: qcom: sa8775p: Add default pin configurations for QUP SEs
Date: Tue, 29 Apr 2025 23:03:34 +0530
Message-Id: <20250429173334.303003-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEyOSBTYWx0ZWRfX0Z+7Iyju49ug p5GTr3m/R0idHAZK2zKYR3ZqqNBDttjBppSO1Xp/qAzAc6gfRhNCVrf/nIaKqqUr5CS1WNnO30I gDMScuTsl52cI2kVLOIKfh3sOeIV7v2wJQoDIc78pneIQ56UWAfP1iL9LXVjfOLURqiWdtVVPZJ
 IyceL/VTflfdskgQTkGa08hLmmGlUVPXy89/6Bg0vP4CHHpfAJAuFwnP4PKuD1N5jCsbmxm0LEF Rhnhr3XOWeqj7C/XuuvvN+pzZXu59empHSTGfNKBunJWpjRKzAtLSbwaXcuynpLn+vgJG1xXzf1 gUQC1TX3hHv5MCad7/6rN6JcxYJvtJdQRme2RJIJUD1IlrSjjnv9hrdZfivIGg4DpBSx0D/SQGW
 Vk0O14t2b3kNmcckmQNVkezKl/mIpr+vOWNiabogWfJYgAd8iwkgqb/FYSBnGVotqm+gzNH6
X-Proofpoint-GUID: uUeIVF0JF6e_SBjNSrQeLcncATl_YsQm
X-Proofpoint-ORIG-GUID: uUeIVF0JF6e_SBjNSrQeLcncATl_YsQm
X-Authority-Analysis: v=2.4 cv=C8fpyRP+ c=1 sm=1 tr=0 ts=68110d75 cx=c_pps a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=OHcT9Z7ZhKYpY54tha0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290129

Default pinctrl configurations for all QUP (Qualcomm Universal Peripheral)
Serial Engines (SEs) are missing in the SoC device tree. These
configurations are required by client teams when enabling any SEs as I2C,
SPI, or Serial protocols.

Add default pin configurations for Serial Engines (SEs) for all supported
protocols, including I2C, SPI, and UART, to the sa8775p device tree.  This
change facilitates slave device driver clients to enable usecase with
minimal modifications.

Remove duplicate pin configurations from target-specific file as same pin
configuration is included in the SoC device tree.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
v2 -> v3:

- Remove duplicate pin configurations from target-specific file.

v2 Link: https://lore.kernel.org/lkml/20250324151047.842648-1-quic_vdadhani@quicinc.com/

v1 -> v2:

- Drop drive-strength and bias property from soc dtsi.
- Update commit log.

v1 Link: https://lore.kernel.org/lkml/20250225154136.3052757-1-quic_vdadhani@quicinc.com/
---
---
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi |  35 -
 arch/arm64/boot/dts/qcom/sa8775p.dtsi      | 750 +++++++++++++++++++++
 2 files changed, 750 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
index 967913169539..3b4243ef37e7 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
@@ -508,15 +508,11 @@ queue3 {
 
 &i2c11 {
 	clock-frequency = <400000>;
-	pinctrl-0 = <&qup_i2c11_default>;
-	pinctrl-names = "default";
 	status = "okay";
 };
 
 &i2c18 {
 	clock-frequency = <400000>;
-	pinctrl-0 = <&qup_i2c18_default>;
-	pinctrl-names = "default";
 	status = "okay";
 };
 
@@ -678,8 +674,6 @@ &sleep_clk {
 };
 
 &spi16 {
-	pinctrl-0 = <&qup_spi16_default>;
-	pinctrl-names = "default";
 	status = "okay";
 };
 
@@ -712,80 +706,53 @@ ethernet0_mdio: ethernet0-mdio-pins {
 		};
 	};
 
-	qup_uart10_default: qup-uart10-state {
-		pins = "gpio46", "gpio47";
-		function = "qup1_se3";
-	};
-
 	qup_spi16_default: qup-spi16-state {
-		pins = "gpio86", "gpio87", "gpio88", "gpio89";
-		function = "qup2_se2";
 		drive-strength = <6>;
 		bias-disable;
 	};
 
 	qup_i2c11_default: qup-i2c11-state {
-		pins = "gpio48", "gpio49";
-		function = "qup1_se4";
 		drive-strength = <2>;
 		bias-pull-up;
 	};
 
 	qup_i2c18_default: qup-i2c18-state {
-		pins = "gpio95", "gpio96";
-		function = "qup2_se4";
 		drive-strength = <2>;
 		bias-pull-up;
 	};
 
 	qup_uart12_default: qup-uart12-state {
 		qup_uart12_cts: qup-uart12-cts-pins {
-			pins = "gpio52";
-			function = "qup1_se5";
 			bias-disable;
 		};
 
 		qup_uart12_rts: qup-uart12-rts-pins {
-			pins = "gpio53";
-			function = "qup1_se5";
 			bias-pull-down;
 		};
 
 		qup_uart12_tx: qup-uart12-tx-pins {
-			pins = "gpio54";
-			function = "qup1_se5";
 			bias-pull-up;
 		};
 
 		qup_uart12_rx: qup-uart12-rx-pins {
-			pins = "gpio55";
-			function = "qup1_se5";
 			bias-pull-down;
 		};
 	};
 
 	qup_uart17_default: qup-uart17-state {
 		qup_uart17_cts: qup-uart17-cts-pins {
-			pins = "gpio91";
-			function = "qup2_se3";
 			bias-disable;
 		};
 
 		qup_uart17_rts: qup0-uart17-rts-pins {
-			pins = "gpio92";
-			function = "qup2_se3";
 			bias-pull-down;
 		};
 
 		qup_uart17_tx: qup0-uart17-tx-pins {
-			pins = "gpio93";
-			function = "qup2_se3";
 			bias-pull-up;
 		};
 
 		qup_uart17_rx: qup0-uart17-rx-pins {
-			pins = "gpio94";
-			function = "qup2_se3";
 			bias-pull-down;
 		};
 	};
@@ -917,8 +884,6 @@ &remoteproc_gpdsp1 {
 
 &uart10 {
 	compatible = "qcom,geni-debug-uart";
-	pinctrl-0 = <&qup_uart10_default>;
-	pinctrl-names = "default";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 5bd0c03476b1..3261c243940c 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -913,6 +913,8 @@ i2c14: i2c@880000 {
 				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c14_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -938,6 +940,8 @@ spi14: spi@880000 {
 				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi14_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -961,6 +965,8 @@ uart14: serial@880000 {
 				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart14_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -978,6 +984,8 @@ i2c15: i2c@884000 {
 				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c15_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1003,6 +1011,8 @@ spi15: spi@884000 {
 				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi15_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1026,6 +1036,8 @@ uart15: serial@884000 {
 				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S1_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart15_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1043,6 +1055,8 @@ i2c16: i2c@888000 {
 				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c16_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1066,6 +1080,8 @@ spi16: spi@888000 {
 				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi16_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1091,6 +1107,8 @@ uart16: serial@888000 {
 				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S2_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart16_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1108,6 +1126,8 @@ i2c17: i2c@88c000 {
 				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c17_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1133,6 +1153,8 @@ spi17: spi@88c000 {
 				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi17_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1156,6 +1178,8 @@ uart17: serial@88c000 {
 				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart17_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1171,6 +1195,8 @@ i2c18: i2c@890000 {
 				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c18_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1198,6 +1224,8 @@ spi18: spi@890000 {
 				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi18_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1221,6 +1249,8 @@ uart18: serial@890000 {
 				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S4_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart18_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1238,6 +1268,8 @@ i2c19: i2c@894000 {
 				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c19_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1263,6 +1295,8 @@ spi19: spi@894000 {
 				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi19_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1286,6 +1320,8 @@ uart19: serial@894000 {
 				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart19_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1303,6 +1339,8 @@ i2c20: i2c@898000 {
 				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c20_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1328,6 +1366,8 @@ spi20: spi@898000 {
 				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi20_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1351,6 +1391,8 @@ uart20: serial@898000 {
 				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart20_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1404,6 +1446,8 @@ i2c0: i2c@980000 {
 				interrupts = <GIC_SPI 550 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c0_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1429,6 +1473,8 @@ spi0: spi@980000 {
 				interrupts = <GIC_SPI 550 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi0_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1452,6 +1498,8 @@ uart0: serial@980000 {
 				interrupts = <GIC_SPI 550 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart0_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1469,6 +1517,8 @@ i2c1: i2c@984000 {
 				interrupts = <GIC_SPI 551 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c1_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1494,6 +1544,8 @@ spi1: spi@984000 {
 				interrupts = <GIC_SPI 551 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi1_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1517,6 +1569,8 @@ uart1: serial@984000 {
 				interrupts = <GIC_SPI 551 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart1_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1534,6 +1588,8 @@ i2c2: i2c@988000 {
 				interrupts = <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c2_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1559,6 +1615,8 @@ spi2: spi@988000 {
 				interrupts = <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi2_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1582,6 +1640,8 @@ uart2: serial@988000 {
 				interrupts = <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart2_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1599,6 +1659,8 @@ i2c3: i2c@98c000 {
 				interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c3_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1624,6 +1686,8 @@ spi3: spi@98c000 {
 				interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi3_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1647,6 +1711,8 @@ uart3: serial@98c000 {
 				interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart3_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1664,6 +1730,8 @@ i2c4: i2c@990000 {
 				interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c4_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1689,6 +1757,8 @@ spi4: spi@990000 {
 				interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi4_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1712,6 +1782,8 @@ uart4: serial@990000 {
 				interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart4_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1729,6 +1801,8 @@ i2c5: i2c@994000 {
 				interrupts = <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c5_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1754,6 +1828,8 @@ spi5: spi@994000 {
 				interrupts = <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi5_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1777,6 +1853,8 @@ uart5: serial@994000 {
 				interrupts = <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart5_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1829,6 +1907,8 @@ i2c7: i2c@a80000 {
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c7_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1854,6 +1934,8 @@ spi7: spi@a80000 {
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi7_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1877,6 +1959,8 @@ uart7: serial@a80000 {
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				pinctrl-0 = <&qup_uart7_default>;
+				pinctrl-names = "default";
 				interconnect-names = "qup-core", "qup-config";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
@@ -1895,6 +1979,8 @@ i2c8: i2c@a84000 {
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c8_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1920,6 +2006,8 @@ spi8: spi@a84000 {
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi8_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1943,6 +2031,8 @@ uart8: serial@a84000 {
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				pinctrl-0 = <&qup_uart8_default>;
+				pinctrl-names = "default";
 				interconnect-names = "qup-core", "qup-config";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
@@ -1961,6 +2051,8 @@ i2c9: i2c@a88000 {
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c9_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1986,6 +2078,8 @@ spi9: spi@a88000 {
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi9_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -2009,6 +2103,8 @@ uart9: serial@a88000 {
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart9_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -2026,6 +2122,8 @@ i2c10: i2c@a8c000 {
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c10_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -2051,6 +2149,8 @@ spi10: spi@a8c000 {
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi10_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -2074,6 +2174,8 @@ uart10: serial@a8c000 {
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				pinctrl-0 = <&qup_uart10_default>;
+				pinctrl-names = "default";
 				interconnect-names = "qup-core", "qup-config";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 0
 						 &clk_virt SLAVE_QUP_CORE_1 0>,
@@ -2092,6 +2194,8 @@ i2c11: i2c@a90000 {
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c11_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -2117,6 +2221,8 @@ spi11: spi@a90000 {
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi11_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -2140,6 +2246,8 @@ uart11: serial@a90000 {
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				pinctrl-0 = <&qup_uart11_default>;
+				pinctrl-names = "default";
 				interconnect-names = "qup-core", "qup-config";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
@@ -2158,6 +2266,8 @@ i2c12: i2c@a94000 {
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c12_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -2183,6 +2293,8 @@ spi12: spi@a94000 {
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi12_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -2206,6 +2318,8 @@ uart12: serial@a94000 {
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_uart12_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -2223,6 +2337,8 @@ i2c13: i2c@a98000 {
 				interrupts = <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c13_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -2276,6 +2392,8 @@ i2c21: i2c@b80000 {
 				interrupts = <GIC_SPI 831 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP3_S0_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_i2c21_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_3 QCOM_ICC_TAG_ALWAYS
 						&clk_virt SLAVE_QUP_CORE_3 QCOM_ICC_TAG_ALWAYS>,
 					   <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -2301,6 +2419,8 @@ spi21: spi@b80000 {
 				interrupts = <GIC_SPI 831 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP3_S0_CLK>;
 				clock-names = "se";
+				pinctrl-0 = <&qup_spi21_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_3 QCOM_ICC_TAG_ALWAYS
 						&clk_virt SLAVE_QUP_CORE_3 QCOM_ICC_TAG_ALWAYS>,
 					   <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -2325,6 +2445,8 @@ uart21: serial@b80000 {
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP3_S0_CLK>;
 				interconnect-names = "qup-core", "qup-config";
+				pinctrl-0 = <&qup_uart21_default>;
+				pinctrl-names = "default";
 				interconnects = <&clk_virt MASTER_QUP_CORE_3 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_3 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -4412,6 +4534,634 @@ tlmm: pinctrl@f000000 {
 			#interrupt-cells = <2>;
 			gpio-ranges = <&tlmm 0 0 149>;
 			wakeup-parent = <&pdc>;
+
+			qup_i2c0_default: qup-i2c0-state {
+				pins = "gpio20", "gpio21";
+				function = "qup0_se0";
+			};
+
+			qup_i2c1_default: qup-i2c1-state {
+				pins = "gpio24", "gpio25";
+				function = "qup0_se1";
+			};
+
+			qup_i2c2_default: qup-i2c2-state {
+				pins = "gpio36", "gpio37";
+				function = "qup0_se2";
+			};
+
+			qup_i2c3_default: qup-i2c3-state {
+				pins = "gpio28", "gpio29";
+				function = "qup0_se3";
+			};
+
+			qup_i2c4_default: qup-i2c4-state {
+				pins = "gpio32", "gpio33";
+				function = "qup0_se4";
+			};
+
+			qup_i2c5_default: qup-i2c5-state {
+				pins = "gpio36", "gpio37";
+				function = "qup0_se5";
+			};
+
+			qup_i2c7_default: qup-i2c7-state {
+				pins = "gpio40", "gpio41";
+				function = "qup1_se0";
+			};
+
+			qup_i2c8_default: qup-i2c8-state {
+				pins = "gpio42", "gpio43";
+				function = "qup1_se1";
+			};
+
+			qup_i2c9_default: qup-i2c9-state {
+				pins = "gpio46", "gpio47";
+				function = "qup1_se2";
+			};
+
+			qup_i2c10_default: qup-i2c10-state {
+				pins = "gpio44", "gpio45";
+				function = "qup1_se3";
+			};
+
+			qup_i2c11_default: qup-i2c11-state {
+				pins = "gpio48", "gpio49";
+				function = "qup1_se4";
+			};
+
+			qup_i2c12_default: qup-i2c12-state {
+				pins = "gpio52", "gpio53";
+				function = "qup1_se5";
+			};
+
+			qup_i2c13_default: qup-i2c13-state {
+				pins = "gpio56", "gpio57";
+				function = "qup1_se6";
+			};
+
+			qup_i2c14_default: qup-i2c14-state {
+				pins = "gpio80", "gpio81";
+				function = "qup2_se0";
+			};
+
+			qup_i2c15_default: qup-i2c15-state {
+				pins = "gpio84", "gpio85";
+				function = "qup2_se1";
+			};
+
+			qup_i2c16_default: qup-i2c16-state {
+				pins = "gpio86", "gpio87";
+				function = "qup2_se2";
+			};
+
+			qup_i2c17_default: qup-i2c17-state {
+				pins = "gpio91", "gpio92";
+				function = "qup2_se3";
+			};
+
+			qup_i2c18_default: qup-i2c18-state {
+				pins = "gpio95", "gpio96";
+				function = "qup2_se4";
+			};
+
+			qup_i2c19_default: qup-i2c19-state {
+				pins = "gpio99", "gpio100";
+				function = "qup2_se5";
+			};
+
+			qup_i2c20_default: qup-i2c20-state {
+				pins = "gpio97", "gpio98";
+				function = "qup2_se6";
+			};
+
+			qup_i2c21_default: qup-i2c21-state {
+				pins = "gpio13", "gpio14";
+				function = "qup3_se0";
+			};
+
+			qup_spi0_default: qup-spi0-state {
+				pins = "gpio20", "gpio21", "gpio22", "gpio23";
+				function = "qup0_se0";
+			};
+
+			qup_spi1_default: qup-spi1-state {
+				pins = "gpio24", "gpio25", "gpio26", "gpio27";
+				function = "qup0_se1";
+			};
+
+			qup_spi2_default: qup-spi2-state {
+				pins = "gpio36", "gpio37", "gpio38", "gpio39";
+				function = "qup0_se2";
+			};
+
+			qup_spi3_default: qup-spi3-state {
+				pins = "gpio28", "gpio29", "gpio30", "gpio31";
+				function = "qup0_se3";
+			};
+
+			qup_spi4_default: qup-spi4-state {
+				pins = "gpio32", "gpio33", "gpio34", "gpio35";
+				function = "qup0_se4";
+			};
+
+			qup_spi5_default: qup-spi5-state {
+				pins = "gpio36", "gpio37", "gpio38", "gpio39";
+				function = "qup0_se5";
+			};
+
+			qup_spi7_default: qup-spi7-state {
+				pins = "gpio40", "gpio41", "gpio42", "gpio43";
+				function = "qup1_se0";
+			};
+
+			qup_spi8_default: qup-spi8-state {
+				pins = "gpio42", "gpio43", "gpio40", "gpio41";
+				function = "qup1_se1";
+			};
+
+			qup_spi9_default: qup-spi9-state {
+				pins = "gpio46", "gpio47", "gpio44", "gpio45";
+				function = "qup1_se2";
+			};
+
+			qup_spi10_default: qup-spi10-state {
+				pins = "gpio44", "gpio45", "gpio46", "gpio47";
+				function = "qup1_se3";
+			};
+
+			qup_spi11_default: qup-spi11-state {
+				pins = "gpio48", "gpio49", "gpio50", "gpio51";
+				function = "qup1_se4";
+			};
+
+			qup_spi12_default: qup-spi12-state {
+				pins = "gpio52", "gpio53", "gpio54", "gpio55";
+				function = "qup1_se5";
+			};
+
+			qup_spi14_default: qup-spi14-state {
+				pins = "gpio80", "gpio81", "gpio82", "gpio83";
+				function = "qup2_se0";
+			};
+
+			qup_spi15_default: qup-spi15-state {
+				pins = "gpio84", "gpio85", "gpio99", "gpio100";
+				function = "qup2_se1";
+			};
+
+			qup_spi16_default: qup-spi16-state {
+				pins = "gpio86", "gpio87", "gpio88", "gpio89";
+				function = "qup2_se2";
+			};
+
+			qup_spi17_default: qup-spi17-state {
+				pins = "gpio91", "gpio92", "gpio93", "gpio94";
+				function = "qup2_se3";
+			};
+
+			qup_spi18_default: qup-spi18-state {
+				pins = "gpio95", "gpio96", "gpio97", "gpio98";
+				function = "qup2_se4";
+			};
+
+			qup_spi19_default: qup-spi19-state {
+				pins = "gpio99", "gpio100", "gpio84", "gpio85";
+				function = "qup2_se5";
+			};
+
+			qup_spi20_default: qup-spi20-state {
+				pins = "gpio97", "gpio98", "gpio95", "gpio96";
+				function = "qup2_se6";
+			};
+
+			qup_spi21_default: qup-spi21-state {
+				pins = "gpio13", "gpio14", "gpio15", "gpio16";
+				function = "qup3_se0";
+			};
+
+			qup_uart0_default: qup-uart0-state {
+				qup_uart0_cts: qup-uart0-cts-pins {
+					pins = "gpio20";
+					function = "qup0_se0";
+				};
+
+				qup_uart0_rts: qup-uart0-rts-pins {
+					pins = "gpio21";
+					function = "qup0_se0";
+				};
+
+				qup_uart0_tx: qup-uart0-tx-pins {
+					pins = "gpio22";
+					function = "qup0_se0";
+				};
+
+				qup_uart0_rx: qup-uart0-rx-pins {
+					pins = "gpio23";
+					function = "qup0_se0";
+				};
+			};
+
+			qup_uart1_default: qup-uart1-state {
+				qup_uart1_cts: qup-uart1-cts-pins {
+					pins = "gpio24";
+					function = "qup0_se1";
+				};
+
+				qup_uart1_rts: qup-uart1-rts-pins {
+					pins = "gpio25";
+					function = "qup0_se1";
+				};
+
+				qup_uart1_tx: qup-uart1-tx-pins {
+					pins = "gpio26";
+					function = "qup0_se1";
+				};
+
+				qup_uart1_rx: qup-uart1-rx-pins {
+					pins = "gpio27";
+					function = "qup0_se1";
+				};
+			};
+
+			qup_uart2_default: qup-uart2-state {
+				qup_uart2_cts: qup-uart2-cts-pins {
+					pins = "gpio36";
+					function = "qup0_se2";
+				};
+
+				qup_uart2_rts: qup-uart2-rts-pins {
+					pins = "gpio37";
+					function = "qup0_se2";
+				};
+
+				qup_uart2_tx: qup-uart2-tx-pins {
+					pins = "gpio38";
+					function = "qup0_se2";
+				};
+
+				qup_uart2_rx: qup-uart2-rx-pins {
+					pins = "gpio39";
+					function = "qup0_se2";
+				};
+			};
+
+			qup_uart3_default: qup-uart3-state {
+				qup_uart3_cts: qup-uart3-cts-pins {
+					pins = "gpio28";
+					function = "qup0_se3";
+				};
+
+				qup_uart3_rts: qup-uart3-rts-pins {
+					pins = "gpio29";
+					function = "qup0_se3";
+				};
+
+				qup_uart3_tx: qup-uart3-tx-pins {
+					pins = "gpio30";
+					function = "qup0_se3";
+				};
+
+				qup_uart3_rx: qup-uart3-rx-pins {
+					pins = "gpio31";
+					function = "qup0_se3";
+				};
+			};
+
+			qup_uart4_default: qup-uart4-state {
+				qup_uart4_cts: qup-uart4-cts-pins {
+					pins = "gpio32";
+					function = "qup0_se4";
+				};
+
+				qup_uart4_rts: qup-uart4-rts-pins {
+					pins = "gpio33";
+					function = "qup0_se4";
+				};
+
+				qup_uart4_tx: qup-uart4-tx-pins {
+					pins = "gpio34";
+					function = "qup0_se4";
+				};
+
+				qup_uart4_rx: qup-uart4-rx-pins {
+					pins = "gpio35";
+					function = "qup0_se4";
+				};
+			};
+
+			qup_uart5_default: qup-uart5-state {
+				qup_uart5_cts: qup-uart5-cts-pins {
+					pins = "gpio36";
+					function = "qup0_se5";
+				};
+
+				qup_uart5_rts: qup-uart5-rts-pins {
+					pins = "gpio37";
+					function = "qup0_se5";
+				};
+
+				qup_uart5_tx: qup-uart5-tx-pins {
+					pins = "gpio38";
+					function = "qup0_se5";
+				};
+
+				qup_uart5_rx: qup-uart5-rx-pins {
+					pins = "gpio39";
+					function = "qup0_se5";
+				};
+			};
+
+			qup_uart7_default: qup-uart7-state {
+				qup_uart7_cts: qup-uart7-cts-pins {
+					pins = "gpio40";
+					function = "qup1_se0";
+				};
+
+				qup_uart7_rts: qup-uart7-rts-pins {
+					pins = "gpio41";
+					function = "qup1_se0";
+				};
+
+				qup_uart7_tx: qup-uart7-tx-pins {
+					pins = "gpio42";
+					function = "qup1_se0";
+				};
+
+				qup_uart7_rx: qup-uart7-rx-pins {
+					pins = "gpio43";
+					function = "qup1_se0";
+				};
+			};
+
+			qup_uart8_default: qup-uart8-state {
+				qup_uart8_cts: qup-uart8-cts-pins {
+					pins = "gpio42";
+					function = "qup1_se1";
+				};
+
+				qup_uart8_rts: qup-uart8-rts-pins {
+					pins = "gpio43";
+					function = "qup1_se1";
+				};
+
+				qup_uart8_tx: qup-uart8-tx-pins {
+					pins = "gpio40";
+					function = "qup1_se1";
+				};
+
+				qup_uart8_rx: qup-uart8-rx-pins {
+					pins = "gpio41";
+					function = "qup1_se1";
+				};
+			};
+
+			qup_uart9_default: qup-uart9-state {
+				qup_uart9_cts: qup-uart9-cts-pins {
+					pins = "gpio46";
+					function = "qup1_se2";
+				};
+
+				qup_uart9_rts: qup-uart9-rts-pins {
+					pins = "gpio47";
+					function = "qup1_se2";
+				};
+
+				qup_uart9_tx: qup-uart9-tx-pins {
+					pins = "gpio44";
+					function = "qup1_se2";
+				};
+
+				qup_uart9_rx: qup-uart9-rx-pins {
+					pins = "gpio45";
+					function = "qup1_se2";
+				};
+			};
+
+			qup_uart10_default: qup-uart10-state {
+				pins = "gpio46", "gpio47";
+				function = "qup1_se3";
+			};
+
+			qup_uart11_default: qup-uart11-state {
+				qup_uart11_cts: qup-uart11-cts-pins {
+					pins = "gpio48";
+					function = "qup1_se4";
+				};
+
+				qup_uart11_rts: qup-uart11-rts-pins {
+					pins = "gpio49";
+					function = "qup1_se4";
+				};
+
+				qup_uart11_tx: qup-uart11-tx-pins {
+					pins = "gpio50";
+					function = "qup1_se4";
+				};
+
+				qup_uart11_rx: qup-uart11-rx-pins {
+					pins = "gpio51";
+					function = "qup1_se4";
+				};
+			};
+
+			qup_uart12_default: qup-uart12-state {
+				qup_uart12_cts: qup-uart12-cts-pins {
+					pins = "gpio52";
+					function = "qup1_se5";
+				};
+
+				qup_uart12_rts: qup-uart12-rts-pins {
+					pins = "gpio53";
+					function = "qup1_se5";
+				};
+
+				qup_uart12_tx: qup-uart12-tx-pins {
+					pins = "gpio54";
+					function = "qup1_se5";
+				};
+
+				qup_uart12_rx: qup-uart12-rx-pins {
+					pins = "gpio55";
+					function = "qup1_se5";
+				};
+			};
+
+			qup_uart14_default: qup-uart14-state {
+				qup_uart14_cts: qup-uart14-cts-pins {
+					pins = "gpio80";
+					function = "qup2_se0";
+				};
+
+				qup_uart14_rts: qup-uart14-rts-pins {
+					pins = "gpio81";
+					function = "qup2_se0";
+				};
+
+				qup_uart14_tx: qup-uart14-tx-pins {
+					pins = "gpio82";
+					function = "qup2_se0";
+				};
+
+				qup_uart14_rx: qup-uart14-rx-pins {
+					pins = "gpio83";
+					function = "qup2_se0";
+				};
+			};
+
+			qup_uart15_default: qup-uart15-state {
+				qup_uart15_cts: qup-uart15-cts-pins {
+					pins = "gpio84";
+					function = "qup2_se1";
+				};
+
+				qup_uart15_rts: qup-uart15-rts-pins {
+					pins = "gpio85";
+					function = "qup2_se1";
+				};
+
+				qup_uart15_tx: qup-uart15-tx-pins {
+					pins = "gpio99";
+					function = "qup2_se1";
+				};
+
+				qup_uart15_rx: qup-uart15-rx-pins {
+					pins = "gpio100";
+					function = "qup2_se1";
+				};
+			};
+
+			qup_uart16_default: qup-uart16-state {
+				qup_uart16_cts: qup-uart16-cts-pins {
+					pins = "gpio86";
+					function = "qup2_se2";
+				};
+
+				qup_uart16_rts: qup-uart16-rts-pins {
+					pins = "gpio87";
+					function = "qup2_se2";
+				};
+
+				qup_uart16_tx: qup-uart16-tx-pins {
+					pins = "gpio88";
+					function = "qup2_se2";
+				};
+
+				qup_uart16_rx: qup-uart16-rx-pins {
+					pins = "gpio89";
+					function = "qup2_se2";
+				};
+			};
+
+			qup_uart17_default: qup-uart17-state {
+				qup_uart17_cts: qup-uart17-cts-pins {
+					pins = "gpio91";
+					function = "qup2_se3";
+				};
+
+				qup_uart17_rts: qup0-uart17-rts-pins {
+					pins = "gpio92";
+					function = "qup2_se3";
+				};
+
+				qup_uart17_tx: qup0-uart17-tx-pins {
+					pins = "gpio93";
+					function = "qup2_se3";
+				};
+
+				qup_uart17_rx: qup0-uart17-rx-pins {
+					pins = "gpio94";
+					function = "qup2_se3";
+				};
+			};
+
+			qup_uart18_default: qup-uart18-state {
+				qup_uart18_cts: qup-uart18-cts-pins {
+					pins = "gpio95";
+					function = "qup2_se4";
+				};
+
+				qup_uart18_rts: qup-uart18-rts-pins {
+					pins = "gpio96";
+					function = "qup2_se4";
+				};
+
+				qup_uart18_tx: qup-uart18-tx-pins {
+					pins = "gpio97";
+					function = "qup2_se4";
+				};
+
+				qup_uart18_rx: qup-uart18-rx-pins {
+					pins = "gpio98";
+					function = "qup2_se4";
+				};
+			};
+
+			qup_uart19_default: qup-uart19-state {
+				qup_uart19_cts: qup-uart19-cts-pins {
+					pins = "gpio99";
+					function = "qup2_se5";
+				};
+
+				qup_uart19_rts: qup-uart19-rts-pins {
+					pins = "gpio100";
+					function = "qup2_se5";
+				};
+
+				qup_uart19_tx: qup-uart19-tx-pins {
+					pins = "gpio84";
+					function = "qup2_se5";
+				};
+
+				qup_uart19_rx: qup-uart19-rx-pins {
+					pins = "gpio85";
+					function = "qup2_se5";
+				};
+			};
+
+			qup_uart20_default: qup-uart20-state {
+				qup_uart20_cts: qup-uart20-cts-pins {
+					pins = "gpio97";
+					function = "qup2_se6";
+				};
+
+				qup_uart20_rts: qup-uart20-rts-pins {
+					pins = "gpio98";
+					function = "qup2_se6";
+				};
+
+				qup_uart20_tx: qup-uart20-tx-pins {
+					pins = "gpio95";
+					function = "qup2_se6";
+				};
+
+				qup_uart20_rx: qup-uart20-rx-pins {
+					pins = "gpio96";
+					function = "qup2_se6";
+				};
+			};
+
+			qup_uart21_default: qup-uart21-state {
+				qup_uart21_cts: qup-uart21-cts-pins {
+					pins = "gpio13";
+					function = "qup3_se0";
+				};
+
+				qup_uart21_rts: qup-uart21-rts-pins {
+					pins = "gpio14";
+					function = "qup3_se0";
+				};
+
+				qup_uart21_tx: qup-uart21-tx-pins {
+					pins = "gpio15";
+					function = "qup3_se0";
+				};
+
+				qup_uart21_rx: qup-uart21-rx-pins {
+					pins = "gpio16";
+					function = "qup3_se0";
+				};
+			};
 		};
 
 		sram: sram@146d8000 {
-- 
2.34.1


