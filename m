Return-Path: <linux-kernel+bounces-831504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BC9B9CD8D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44AA84A791D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6C71DD0EF;
	Thu, 25 Sep 2025 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jR9JXxTR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92F2148FE6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758759462; cv=none; b=hS89bClhrcx1YCA6Kxg/FzGxWa9DJ5V5831MeYvqmZA9OFSCatdyvJc60G4uhCWVBmWxB0tCHREk16Ye6LSGPvrbK1OZzxYgde4HyqCEw1lQ4hKGubcDiE/xTzIEDSUQUY9PvRG5+hiLx0KJ7uYTXZWEgQjjueW9rLtxeyxAl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758759462; c=relaxed/simple;
	bh=cn/nZ1gPtYYMV0yuUp/fPOftXOXmuRTZ5yr26XnZg8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kCCrFCGjWhICPZ3X8BRxiOy/F9dw5VPRPO7pzemh58B81g89Ep3lf0A3sWcRrLBy8swsxJbQ/7Xp47IwoKjzc+mCV1E859i8tfFhsXPnWVGw4ohuq2feTpboT43o/dGvgPoIxQ+co7PkwHLnIh291kA8pF+HLIMOgmH8TtR6W0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jR9JXxTR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD36d4027759
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fPwJ9SS2tSq3qs578pTRyH7GMOQ8HnHNrsubQZOgTJY=; b=jR9JXxTRMt7Ak2FJ
	M5M0ZgMuipcH3/0ta3ko8zbAeD5FewiWn+27E6rND/CR7XUE8A+AyVJGoHhCHyAp
	RbR1RQajS+2SV7ZGk63lKdm62+APvE4ePpIUC+uIM0NEOjFcMp5T1XtI9Mu0Loyo
	AXeskcn+ia20Rv8yQA/6h4d+8GCXXf2VHXNOfQmQ5aQ0DbR8SmPyB1lqW55EzLzG
	+vBjucrC9SHTgJ6QxvEOTt+cnNkt6JCqUYs81jNJlXSS8VEVoy2mPPJ6reOMO9fa
	nriGqlsMUjlKnowo+jdKmS+Kuy+pODiKYD5UQwXF21LJAQgD48FHNYGERgJHbtYW
	fzewkw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnxg8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810289cd5eso225262b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758759458; x=1759364258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPwJ9SS2tSq3qs578pTRyH7GMOQ8HnHNrsubQZOgTJY=;
        b=ByxvhihUTt4lqs9OUfspdzB4xjIJM4HN4U7pET4/l/uLywwQ8rTJdAaGwpXfcZb3X9
         BH4NNIQviryEdHDWSs6a9mMAyLGxv73TV+M6mE3g9uiU+ZvZGCtsmRdiRl7yE4gMZ+xC
         KZxPPeh1JSKzGPdnUWbiC1xr8K64ZWrgN5SqTahoz474v2vAOndHIAQGQEg/GGyz3uS+
         igHrtWpDHWLjZAFxtF5byCi5pDQuqiQLicrm/xy3WEKUc86fFBBBRs+6NhoKgmPJjpal
         lzWV+4/JxqIqFrEg9fgJZvBo4QfB2nXz3rKQmHPAcg+ZtUJ4fQ1ab95kYazDNK7XvXxd
         r+FA==
X-Forwarded-Encrypted: i=1; AJvYcCW1GcV+f93b46RS5K9BoIbWXiU0ZlXOFs8kEx+Uf1aPhdPfFVYWVok+K66V5wYmk3ezkJROK+pU103NNy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5bW5k7QHY15dR22Y7058zpKuYZs4L4OqzSMPvedSshUrOzSw+
	vcTRJxAbzEEaRDJnieJNhryG/4SMb/7nKV7t/gy66OJcmdw6MI9W0wMNIGRwehNNNISvaPx1oP2
	nBcrJPuqr98CLrls38bj7/mPa06CFYFFeiR8fc5M4WNLzftaamoaYFBfVXLIYZwPduaU=
X-Gm-Gg: ASbGncv+A6/dUMSuYuJruPJQZvnfbghJdEBvVg7mZmJ6EvLGbyqioYJhtVCpm93JJMa
	Huy0MaVyrxJZOM2xNwG1U/iuIrOuF1CwODmLATFVwOyDt+CUKiuG6pbadrbEkuYxvwo63Iw8yqg
	xS/Kg9J5SIwxPpOaxeCwTKCbaBd0zwz349izxZQzz/kqMULEULsfBB6x0R9CLySO33RbG2kOLb5
	oJO9DoV1NbbFYBQ6su5peTxUAgYQPByWM9J/ZP7o8k+bEJUT3AsoOI+o3cx3070lfZR6/L8sb2L
	VCMfk3AfwFnwca0LAIz51z3u9E8HkMldfVG/HSbA8XCjyh+qSVm0fKLd4XIJmymvJvZ6MLFjXuU
	DViIUxvVukVmAglY=
X-Received: by 2002:a05:6a00:3e14:b0:77f:532f:94d0 with SMTP id d2e1a72fcca58-780fced9344mr2018109b3a.28.1758759458453;
        Wed, 24 Sep 2025 17:17:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBphEhREZW/7Dj48Qj7LZDHf93yHFd4ARtP0RHB1ba4zNuWLD2pz2KaEuCbLwyaWo1//RiPw==
X-Received: by 2002:a05:6a00:3e14:b0:77f:532f:94d0 with SMTP id d2e1a72fcca58-780fced9344mr2018085b3a.28.1758759458001;
        Wed, 24 Sep 2025 17:17:38 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238e6fasm262748b3a.1.2025.09.24.17.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:17:37 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 17:17:23 -0700
Subject: [PATCH 06/20] arm64: dts: qcom: kaanapali: Add USB support for
 Kaanapali SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-dts-v1-6-3fdbc4b9e1b1@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758759448; l=5093;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=9QxhPaI89ZIIuqaCvsyX1YypMQp3NmQD7te+LtKtAHM=;
 b=tYLL7f/+n5tsznHnX62frR8yT8XJYIaSs7aEUwnHON3E9XIAFeuaBY24nEqKDWM/Ca2gBJpwr
 9lzQ1B4NeztDQYFsJxqa4zik0XaKvf9XodcvSFtg/3ZXzpw8HdhJSTM
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d48a23 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=EhTt_HtFeX8hmfPM-OEA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 4ESrrfOYitLcBO3ieKr7dzmKIPjOzIuQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX+mZDo5O/j5bT
 gwQbjaSZKcsqWYS+9+mkLM3XvwX9AM98axdepM0DzQV1EoIdGtP3TGeqjUQMl2FctxcR52noVq/
 H41OQdpPOJaPKd7iicu42+94Mh8JoE/G3Ju3osjTB/z+x6r6hUJ64nkvXKyxUC6ow+Rwg2qXHFS
 +P5Y+1eiqY1tSc8gJHe62m/aTt9qfe1U9wuAkhqxrcbXXpCIYGVUcCIVMqSQcHSf9cprQGWsELC
 7FH2TnV5xrSNoGBga41l7P8/Ri4YXaG29vJ1CwGNQPZ/0c5cMUABYq3TojDoaHoJPwL3UA02n8l
 cecXxKG8dOqY29jwJkImjX2nMKaoWBufnjMmwhdu9+YV59brZr+fBDson/fsqgFBldfYTC0Im6Y
 tVP5a4YX
X-Proofpoint-GUID: 4ESrrfOYitLcBO3ieKr7dzmKIPjOzIuQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>

Add the base USB devicetree definitions for Kaanapali platform. The overall
chipset contains a single DWC3 USB3 controller (rev. 200a), SS QMP PHY
(rev. v8) and M31 eUSB2 PHY.

Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 155 ++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index ae1721cfbffc..08ab267bf9a7 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interconnect/qcom,kaanapali-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -958,6 +959,160 @@ opp-202000000 {
 			};
 		};
 
+		usb_1_hsphy: phy@88e3000 {
+			compatible = "qcom,kaanapali-m31-eusb2-phy",
+				     "qcom,sm8750-m31-eusb2-phy";
+			reg = <0x0 0x88e3000 0x0 0x29c>;
+
+			clocks = <&tcsrcc TCSR_USB2_CLKREF_EN>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		usb_dp_qmpphy: phy@88e8000 {
+			compatible = "qcom,kaanapali-qmp-usb3-dp-phy",
+				     "qcom,sm8750-qmp-usb3-dp-phy";
+			reg = <0x0 0x088e8000 0x0 0x4000>;
+
+			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+				 <&tcsrcc TCSR_USB3_CLKREF_EN>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+			clock-names = "aux",
+				      "ref",
+				      "com_aux",
+				      "usb3_pipe";
+
+			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
+				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
+			reset-names = "phy",
+				      "common";
+
+			power-domains = <&gcc GCC_USB3_PHY_GDSC>;
+
+			#clock-cells = <1>;
+			#phy-cells = <1>;
+
+			orientation-switch;
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_dp_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_dp_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_dp_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
+		};
+
+		usb_1: usb@a600000 {
+			compatible = "qcom,kaanapali-dwc3", "qcom,snps-dwc3";
+			reg = <0x0 0x0a600000 0x0 0xfc100>;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
+
+			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <200000000>;
+
+			interrupts-extended = <&intc GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dwc_usb3",
+					  "pwr_event",
+					  "hs_phy_irq",
+					  "dp_hs_phy_irq",
+					  "dm_hs_phy_irq",
+					  "ss_phy_irq";
+
+			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
+
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+
+			interconnects = <&aggre_noc MASTER_USB3 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_USB3 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "usb-ddr", "apps-usb";
+			iommus = <&apps_smmu 0x40 0x0>;
+
+			phys = <&usb_1_hsphy>, <&usb_dp_qmpphy QMP_USB43DP_USB3_PHY>;
+			phy-names = "usb2-phy", "usb3-phy";
+
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
+			dma-coherent;
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_dwc3_hs: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_dwc3_ss: endpoint {
+						remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
+					};
+				};
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,kaanapali-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x10000>,

-- 
2.25.1


