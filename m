Return-Path: <linux-kernel+bounces-588654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EA3A7BBF4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 13:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E9F189A212
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 11:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CF51EEA42;
	Fri,  4 Apr 2025 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dndSLB66"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF6C1E1E0B;
	Fri,  4 Apr 2025 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743767775; cv=none; b=nshGzq8R3HWLE3lD15y2w1ADn/Ruxo7fhI/4r6TS5CM4Icm4KOaNYpSG9qiS2uYUZ1n6BhCv7VYwfxOReykiNd/KiddRBbk6ODUnvLyFP86K5m6Z3cFNTVgx15vU73O0ZW5NKLtzSO/0A2KpHGqY8i82vCUgBq+Wtn2lfIn3HDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743767775; c=relaxed/simple;
	bh=kZ2hAYyxhv3a7bprmURxbysQjeCuokYHsOAIYJlSwiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHtBo0RrfokrgX08abTMcv5V+A18dk6jJe66wDA1K5Ga8R4LKAv6ILRNYHHg7Dck4bqMhaDbNXAjWPpwMQd4kiJm9c3GYpj9ADhg6SzAEtK8lCWtBLnd2+wmZBdbz/8DWYaU2oYQN5HlsbNToceubtOJe0sk4Ou5ijcSY/xA5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dndSLB66; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53433sx0032324;
	Fri, 4 Apr 2025 11:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fDzXVLp5RrL
	ur48mePRVFZjm/Jgiktt2n41pq7AuiOI=; b=dndSLB66IHYSsxqoGORMmc9Hzn9
	dj7Mtbk6I9aXGG3E2x5d/cLmnvthSSkvMwKrchJWDonjrvXvGj5VfYVHl5gsoxmT
	wLoEigfDtq/GvI1osksesaQWPONObHIKkYG0Py4Nas1F3ClpjrHZIDaoP/soIQo6
	1B4OFYxBk3wco+kqcM8YgBe7WZgTFNYqxapYBS65XFNGjq5P5MO8ZLnbqRK559zY
	SEWkaV1MJxkix/B9fHHnFsckV9V5JrYj+51s8q1LfI02Ye2xXJI0omf0M8spQoWK
	AEccg/95dzb1txbIr0oo/gqVAk9qP4K8b/qULBT4UupzAqZ2V1bv08MzMUQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2dasmgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 11:55:50 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 534BtjGY016527;
	Fri, 4 Apr 2025 11:55:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 45p9xmaejs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 11:55:46 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 534BtjUC016500;
	Fri, 4 Apr 2025 11:55:46 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-amakhija-hyd.qualcomm.com [10.213.99.91])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 534BtkDY016545
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 11:55:46 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4090850)
	id 4908859C; Fri,  4 Apr 2025 17:25:44 +0530 (+0530)
From: Ayushi Makhija <quic_amakhija@quicinc.com>
To: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ayushi Makhija <quic_amakhija@quicinc.com>, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_abhinavk@quicinc.com,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_jesszhan@quicinc.com
Subject: [PATCH v3 07/10] arm64: dts: qcom: sa8775p-ride: add anx7625 DSI to DP bridge nodes
Date: Fri,  4 Apr 2025 17:25:36 +0530
Message-Id: <20250404115539.1151201-8-quic_amakhija@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250404115539.1151201-1-quic_amakhija@quicinc.com>
References: <20250404115539.1151201-1-quic_amakhija@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 3KlfJYU3FZwRuWkL7nfsmf75h6cp9RYq
X-Authority-Analysis: v=2.4 cv=MqFS63ae c=1 sm=1 tr=0 ts=67efc8c6 cx=c_pps a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=K8etQPCKvp1CY5QOYCQA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3KlfJYU3FZwRuWkL7nfsmf75h6cp9RYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_05,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040082

Add anx7625 DSI to DP bridge device nodes.

Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 208 ++++++++++++++++++++-
 1 file changed, 207 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
index 175f8b1e3b2d..8e784ccf4138 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
@@ -28,6 +28,13 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vreg_conn_1p8: vreg_conn_1p8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vreg_conn_1p8";
@@ -128,6 +135,30 @@ dp1_connector_in: endpoint {
 			};
 		};
 	};
+
+	dp-dsi0-connector {
+		compatible = "dp-connector";
+		label = "DSI0";
+		type = "full-size";
+
+		port {
+			dp_dsi0_connector_in: endpoint {
+				remote-endpoint = <&dsi2dp_bridge0_out>;
+			};
+		};
+	};
+
+	dp-dsi1-connector {
+		compatible = "dp-connector";
+		label = "DSI1";
+		type = "full-size";
+
+		port {
+			dp_dsi1_connector_in: endpoint {
+				remote-endpoint = <&dsi2dp_bridge1_out>;
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -517,9 +548,135 @@ &i2c11 {
 
 &i2c18 {
 	clock-frequency = <400000>;
-	pinctrl-0 = <&qup_i2c18_default>;
+	pinctrl-0 = <&qup_i2c18_default>,
+		    <&io_expander_intr_active>,
+		    <&io_expander_reset_active>;
 	pinctrl-names = "default";
+
 	status = "okay";
+
+	io_expander: gpio@74 {
+		compatible = "ti,tca9539";
+		reg = <0x74>;
+		interrupts-extended = <&tlmm 98 IRQ_TYPE_EDGE_BOTH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		gpio2-hog {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "dsi0_int_pin";
+		};
+
+		gpio3-hog {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "dsi0_cbl_det_pin";
+		};
+
+		gpio10-hog {
+			gpio-hog;
+			gpios = <10 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "dsi1_int_pin";
+		};
+
+		gpio11-hog {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "dsi1_cbl_det_pin";
+		};
+	};
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9543";
+		#address-cells = <1>;
+
+		#size-cells = <0>;
+		reg = <0x70>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			bridge@58 {
+				compatible = "analogix,anx7625";
+				reg = <0x58>;
+				interrupts-extended = <&io_expander 2 IRQ_TYPE_EDGE_FALLING>;
+				enable-gpios = <&io_expander 1 GPIO_ACTIVE_HIGH>;
+				reset-gpios = <&io_expander 0 GPIO_ACTIVE_HIGH>;
+				vdd10-supply = <&vph_pwr>;
+				vdd18-supply = <&vph_pwr>;
+				vdd33-supply = <&vph_pwr>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						dsi2dp_bridge0_in: endpoint {
+							remote-endpoint = <&mdss0_dsi0_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						dsi2dp_bridge0_out: endpoint {
+							remote-endpoint = <&dp_dsi0_connector_in>;
+						};
+					};
+				};
+			};
+		};
+
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			bridge@58 {
+				compatible = "analogix,anx7625";
+				reg = <0x58>;
+				interrupts-extended = <&io_expander 10 IRQ_TYPE_EDGE_FALLING>;
+				enable-gpios = <&io_expander 9 GPIO_ACTIVE_HIGH>;
+				reset-gpios = <&io_expander 8 GPIO_ACTIVE_HIGH>;
+				vdd10-supply = <&vph_pwr>;
+				vdd18-supply = <&vph_pwr>;
+				vdd33-supply = <&vph_pwr>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						dsi2dp_bridge1_in: endpoint {
+							remote-endpoint = <&mdss0_dsi1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						dsi2dp_bridge1_out: endpoint {
+							remote-endpoint = <&dp_dsi1_connector_in>;
+						};
+					};
+				};
+			};
+		};
+	};
+
 };
 
 &mdss0 {
@@ -566,6 +723,40 @@ &mdss0_dp1_phy {
 	status = "okay";
 };
 
+&mdss0_dsi0 {
+	vdda-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
+&mdss0_dsi0_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&dsi2dp_bridge0_in>;
+};
+
+&mdss0_dsi0_phy {
+	vdds-supply = <&vreg_l4a>;
+
+	status = "okay";
+};
+
+&mdss0_dsi1 {
+	vdda-supply = <&vreg_l1c>;
+
+	status = "okay";
+};
+
+&mdss0_dsi1_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&dsi2dp_bridge1_in>;
+};
+
+&mdss0_dsi1_phy {
+	vdds-supply = <&vreg_l4a>;
+
+	status = "okay";
+};
+
 &pmm8654au_0_gpios {
 	gpio-line-names = "DS_EN",
 			  "POFF_COMPLETE",
@@ -714,6 +905,21 @@ ethernet0_mdio: ethernet0-mdio-pins {
 		};
 	};
 
+	io_expander_intr_active: io-expander-intr-active-state {
+		pins = "gpio98";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	io_expander_reset_active: io-expander-reset-active-state {
+		pins = "gpio97";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
+
 	qup_uart10_default: qup-uart10-state {
 		pins = "gpio46", "gpio47";
 		function = "qup1_se3";
-- 
2.34.1


