Return-Path: <linux-kernel+bounces-798325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6D2B41C53
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479E5560536
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6262F3626;
	Wed,  3 Sep 2025 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="prIY2sMy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F352F90F9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896726; cv=none; b=is22EzQDjBU94aIZ8ydzGWMeJiLUCoq9MjroHcytlyb2/haOwK9QyhdlnP/5v3MSX/Exmv9TL9sVRvL/f/gDn04e6eAxQSYar1OFgUFItMxZakhThuQPagaoE2atz2lMFAQyfJB/2qI3wt9HFP+ebRE4RS24Zq8QXR4TWmKhGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896726; c=relaxed/simple;
	bh=nKzM8+DhB3mWRo1Uw19AVwyiwRjw8Y1noKAdLwZJkWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dNUywpxEYyhkl41yjoqGnLLz47FxbSAjnxsZpRYb4g6FNmSbwD25UEmd6XA3RXB+DZuXXP1oRYM/ScBdlJ1g2SVJXU6IKPHVlDdUu6FkCM+nu16ujIC3Hvo33PoGH3POkxY6iNAcr+VIy+D4skZaq/ZIvb0Kges0k3fef1R/SSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=prIY2sMy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583A7cZb001619
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 10:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0K02dLIrIWIN69se35x4CnkEpVg0hHnCCy6M9lvO6aU=; b=prIY2sMyZbKWgYwH
	GCsQ9fWpeHi++m9j7p4EAr0OQ7ac6bg8gv8N22jr8AUMwlswT+yn065udi/SJlBO
	Gn20Fo1Vw5ieHnEI8OKtw+p/E0Z1WPR1QNVSZlpDGjz8IxWAESeYipCwDaI6FtCg
	iHuzu2uCY42YgbLBOYMy3d1mX40pHY54nrRTvE3kfo+L5hnTdQNf7yHotv6qRE2g
	bIT9N+Vyde2LaNj9ekzjWCY/eC1mSAKZ8bPleTVGRLFK8E1YDesB6QcikgYYfQSJ
	gA0Fm9Y0f3huA51qgSuqPHlngoMZM9go95VSFXYVJX16qIeo22NIimnHnislbNrj
	4smD7Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy78as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:52:04 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4c229e2a42so4632361a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756896723; x=1757501523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0K02dLIrIWIN69se35x4CnkEpVg0hHnCCy6M9lvO6aU=;
        b=fE0ryP8tW3F4Y/xEhSGGDH6+2z6rsyWUeZX3I0GROE+c8r/pXK0wFMj6L2dZdkK8+M
         wRqV/LZDMfyAj2g+aO46FTybE0ufu8PTTMgCNL7+z25TtWMA8zikPK5B+mFYIwnZeVEo
         O4TJmVKLCo50DzaBiQTgtJ7/NQKlI08Y2oWt8WJ82349+Dep4vomLAHWp916KVNABt4+
         LrDkYUZVykUa9QhGY5MO0Y2ed4PC2OCd4S3cTdmK5lqZPDnQT0+Mz5aAtW0Bbnapu1H/
         cYBCiUwVfp3NeUg5Ylhg8q/I+j+Qt09lC58hJ+9A/JS/2Xh1rIZpo1kqCKRB86Qe6fNn
         SSGA==
X-Forwarded-Encrypted: i=1; AJvYcCVQQslKuK8w4swOsb575h4GNptRI6lztWjlsb2Fy16lsSeAphrpN66JslhDz1LhT2zbayUE8m/1aAYBwtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1omkBO2swsqHS0IlQn8hKWzgHVHMujROG8K1CL2iCFvzzSc6Y
	6oy7fCIY7d7bMZleS8Ki7DIm+19mNsaQUSkmqKe/TOlaLTH/yAmKhHsTaFHhrufyiI4f3VziFu0
	PDLdXBEywNiMWjgDiFxoSWQT/bu9Vm4DcpkNPPeA1sTbgRkGy7AplVspoc77YEXa/rDk=
X-Gm-Gg: ASbGnctsEiqaw/pnGCzerRgpSNvSU5DN4VFc6qEN2NRlfA9+AQAF23ioMXIRSrgqnlK
	RduC6EWcsSBK8HpYDz7tVMn0dOD6QrCoYB5r13LCtkfP2A8AsqUMClhncJuG3TO8cfb7IltExDa
	6nWXfBbjojUNQxhRRBJDOLYd26MplfVrVeuvZB1/UlcDbYnhMz373fgti9evmN5OZssMUOxhtEl
	962ONCZKLIYUeR+qLCwPJiwT8jZ+vFXiy055mEShZ6AlnPlafk1dhjwrpZ+YCGZJ7ioH8HMTpjg
	EiZsBr5H/o/rRTsEBxgZB/H9RSxDzCVNSBZktbhuQNMsTwBehxY8B233UFwBDot5IoGB8L4FVvj
	fPKemJKdiCMGob3Eeu0T/Wx5X9pGc8jkvNlLsVciEwDeuwgSb4fIeJT26
X-Received: by 2002:a17:90b:1848:b0:327:6de3:24b6 with SMTP id 98e67ed59e1d1-3281541223dmr18814948a91.8.1756896722886;
        Wed, 03 Sep 2025 03:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHzZzZ6b8RjjgvGoFeQd4E+IrJe/7VCVvhzz++1+LGXDEpaAQ+0Bgxwr1THYhd550qoHz+tg==
X-Received: by 2002:a17:90b:1848:b0:327:6de3:24b6 with SMTP id 98e67ed59e1d1-3281541223dmr18814911a91.8.1756896722363;
        Wed, 03 Sep 2025 03:52:02 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e3a6720asm4856888a91.11.2025.09.03.03.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 03:52:01 -0700 (PDT)
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 18:49:28 +0800
Subject: [PATCH v8 1/2] arm64: dts: qcom: Add display support for QCS615
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-add-display-support-for-qcs615-platform-v8-1-7971c05d1262@oss.qualcomm.com>
References: <20250903-add-display-support-for-qcs615-platform-v8-0-7971c05d1262@oss.qualcomm.com>
In-Reply-To: <20250903-add-display-support-for-qcs615-platform-v8-0-7971c05d1262@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        xiangxu.yin@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Li Liu <li.liu@oss.qualcomm.com>,
        Fange Zhang <fange.zhang@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756896714; l=5827;
 i=fange.zhang@oss.qualcomm.com; s=20250714; h=from:subject:message-id;
 bh=uXlwezLY7U3gqs8X4zeTpdCd9Lux78E+OqnciVI8/Jk=;
 b=nJMMlMxwmLRBPOm8DOtATHaZV3jr336k5oN3dKsp8USIFCY8D7t9Q2Bg+o/o8b1NgUhZCNBc0
 ThYkwUazfukDErkAalcbvZZb8ctAO1ZbyLXAF4qHodyLLWc2GJkgHVP
X-Developer-Key: i=fange.zhang@oss.qualcomm.com; a=ed25519;
 pk=tn190A7bjF3/EyH7AYy/eNzPoS9lwXGznYamlMv6TE0=
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b81dd4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=Roi-LC9FDB9nNxv02foA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: IVLx_gafQnrv-YOs0C4SKxk7Mg7ofi6f
X-Proofpoint-ORIG-GUID: IVLx_gafQnrv-YOs0C4SKxk7Mg7ofi6f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfXyc5qg8vuN5OT
 +lZbuB3b+z+p48oUC+MP/cl3EIimtlE6JiXJdqUZH4sBJ77Ynea/VbXal/yE691aijqemQQGpLw
 RG5WiEsc+XL9VHWqmBUDOacxsy3posO/m1IU3qB8RhVurIdCqmpvMegwfmanhFqjCpx6lWFPACS
 PP2lE/TAkChHLpVyJQY8E9kr/96Gs7yiiJ57zJ1ri2Wt9Z8MD7sdm+7VqU6Xyc0qdSlbIVzcX0d
 RnjT0+TQ2NSc2rUJMWBhwb8AzWOlkh4TYVw1ETqyOzK6hpdPZr4M8Ll112UzItsq7Kp9c9IrxxC
 lYQcDWm54dKKRK4Iq6oJPpx2wDIsD46peEpBXcN+ouMC2NtnEcI7JRZ71ccg+o7Hfjnro4SVtO7
 TB12wZg3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

From: Li Liu <li.liu@oss.qualcomm.com>

Add display MDSS and DSI configuration for QCS615 platform.
QCS615 has a DP port, and DP support will be added in a later patch.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Li Liu <li.liu@oss.qualcomm.com>
Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm6150.dtsi | 182 ++++++++++++++++++++++++++++++++++-
 1 file changed, 180 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index 53496241479a05fec7bffa893b96b2d12b2d7614..c0e6485c148a059f6c0b2d221a9ee34b0220ea06 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <dt-bindings/clock/qcom,dsi-phy-28nm.h>
 #include <dt-bindings/clock/qcom,qcs615-camcc.h>
 #include <dt-bindings/clock/qcom,qcs615-dispcc.h>
 #include <dt-bindings/clock/qcom,qcs615-gcc.h>
@@ -3579,14 +3580,191 @@ camcc: clock-controller@ad00000 {
 			#power-domain-cells = <1>;
 		};
 
+		mdss: display-subsystem@ae00000 {
+			compatible = "qcom,sm6150-mdss";
+			reg = <0x0 0x0ae00000 0x0 0x1000>;
+			reg-names = "mdss";
+
+			interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "mdp0-mem",
+					     "cpu-cfg";
+
+			power-domains = <&dispcc MDSS_CORE_GDSC>;
+
+			clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				 <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			iommus = <&apps_smmu 0x800 0x0>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			mdss_mdp: display-controller@ae01000 {
+				compatible = "qcom,sm6150-dpu";
+				reg = <0x0 0x0ae01000 0x0 0x8f000>,
+				      <0x0 0x0aeb0000 0x0 0x2008>;
+				reg-names = "mdp",
+					    "vbif";
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&gcc GCC_DISP_HF_AXI_CLK>,
+					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
+					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				clock-names = "iface",
+					      "bus",
+					      "core",
+					      "vsync";
+
+				operating-points-v2 = <&mdp_opp_table>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
+
+				interrupts-extended = <&mdss 0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						dpu_intf0_out: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						dpu_intf1_out: endpoint {
+							remote-endpoint = <&mdss_dsi0_in>;
+						};
+					};
+				};
+
+				mdp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-192000000 {
+						opp-hz = /bits/ 64 <192000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-256000000 {
+						opp-hz = /bits/ 64 <256000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-307200000 {
+						opp-hz = /bits/ 64 <307200000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+
+			mdss_dsi0: dsi@ae94000 {
+				compatible = "qcom,sm6150-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+				reg = <0x0 0x0ae94000 0x0 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupts-extended = <&mdss 4>;
+
+				clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
+					 <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
+					 <&dispcc DISP_CC_MDSS_ESC0_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&gcc GCC_DISP_HF_AXI_CLK>;
+				clock-names = "byte",
+					      "byte_intf",
+					      "pixel",
+					      "core",
+					      "iface",
+					      "bus";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi0_phy DSI_BYTE_PLL_CLK>,
+							 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>;
+
+				operating-points-v2 = <&dsi0_opp_table>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
+
+				phys = <&mdss_dsi0_phy>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+
+				dsi0_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-164000000 {
+						opp-hz = /bits/ 64 <164000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+				};
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						mdss_dsi0_in: endpoint {
+							remote-endpoint = <&dpu_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						mdss_dsi0_out: endpoint {
+						};
+					};
+				};
+			};
+
+			mdss_dsi0_phy: phy@ae94400 {
+				compatible = "qcom,sm6150-dsi-phy-14nm";
+				reg = <0x0 0x0ae94400 0x0 0x100>,
+				      <0x0 0x0ae94500 0x0 0x300>,
+				      <0x0 0x0ae94800 0x0 0x124>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names = "iface",
+					      "ref";
+
+				status = "disabled";
+			};
+		};
+
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,qcs615-dispcc";
 			reg = <0 0x0af00000 0 0x20000>;
 
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
-				 <0>,
-				 <0>,
+				 <&mdss_dsi0_phy DSI_BYTE_PLL_CLK>,
+				 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>,
 				 <0>,
 				 <0>,
 				 <0>;

-- 
2.34.1


