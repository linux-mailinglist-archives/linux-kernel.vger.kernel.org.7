Return-Path: <linux-kernel+bounces-880171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99306C2507D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B953A467F87
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AE234A3B2;
	Fri, 31 Oct 2025 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LDIrYjp/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MZFX+4Z8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B33491F3
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914051; cv=none; b=W/eAO5KP/5Ib4pJekZ/cooptqgRmBlQiCoDCoYJJM5OmLwO8u1EaR3dijoPuPnL4Sgt/Xn3F4lcOtpGNN7dYY++xkLztXb/iYgTKha7K2RI/aqKhPD/bmk0iIC7esrXIC0Gb0wo36o1hhWjK8dum23bmP8I+qdQTGxC/8cxhL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914051; c=relaxed/simple;
	bh=upFaUwDTtyNvkbghN9e9TjDsqtmURB0UDixiVg6mer0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3JfBZr9CIsBkC/TdiKdIdfEqm7U1Ub741gsOOBRMzjlzYNVK8r72MS37VgoF4GRhpSiYxmHWP+gyeE+AS7ninUdQuVKJ5XsL9287Hc6D51P5bMXiXzbOo/Y3yQwocgya6FLrrt05d05D4ar3LjYQKJtZ2anBN9PlpO1LmmVQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LDIrYjp/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MZFX+4Z8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V6pEBF3115502
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=flReortGwXK
	vgtxcfk4GLcTVcF36ZuZkgxdI+JXLWuM=; b=LDIrYjp/IFitjRTxmhDeXdDH3pH
	Dn+Vlm46iH/RAR3cQrV4YqbRHiTfRXgY+EZRKZvkDDujnb9qfp3128Gk0a6VI7hq
	OOcvNsruQvz0G9uwe4zoqYbb85TIJ0hYupbwQTm0ULQ0jSg7vmO3NxwFw23twYBW
	q2c+X99VaFddPPAuU2pgb22aiDfJfspBsIzoSQ2dfoEQV3revYp9xtzkf0Y5olqi
	NcSZpJy2Iq7RMFNVSdRKPvqThJimrfzX2WshMx+iL96HumF1DwBwymt2FsoW/yM4
	hMX9xrPN4QPztenRD3bTlU3Hryuzl4fwN1arFC6hHyGdmQs5vRWygi1CU8g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b44523-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:34:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a2885329beso1927814b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761914047; x=1762518847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flReortGwXKvgtxcfk4GLcTVcF36ZuZkgxdI+JXLWuM=;
        b=MZFX+4Z8aZC9dHxzQwk9SXf59js1sTwR/PMcX3I/F48khdbOYxFSq5cSa97sRv5cK8
         wip+S7Y89BFSdaMtwCNi137ma45r7T4JgJf/XNv9EvNzByMGwIQfC7tQ3a5WTww02owp
         iV7Qh+dTDH1uvyycjVrzvqkKFb4rMqWUfLi/rPsQY3DOMSWjx2VDFVcAtsuprfz8uAYD
         k6q3EqJ78sSBI1b5wbZ0ff+TYppleTt/XH+ZhQs4Y3IFg/WmWZu4JY1W6HixqUCkFNlm
         FlwR8vDki3HwSqf9mXJ5uELL1gqsEB4tlIXlHJ4sbzhXsdExtjg2yrnyXM45ggDTJ/FI
         FNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761914047; x=1762518847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flReortGwXKvgtxcfk4GLcTVcF36ZuZkgxdI+JXLWuM=;
        b=DTWu35pszDJGtq48QMj/oZrHYLi/L76TH3+MNQp7m5HlcrNXFiC0ThECgaVOf8WsiB
         b4XL6yJCtQQjq/dgPg4yJKuyta+OWMtD3QRplci+ieFMXViXHD5OTX+hin5Gw4UByK/6
         7jkaiQ2tQ8UwBLpC4p004yoGCIzXOoyZbV20oMbxsDeQgXOhueYA01XSbA7I79/lVtMN
         l7xtC74FkM7rvJ0HwzXDz6L+T4xra27vrF6tbeLLUe2usqIaHoRoLIehHuxWiicXWnXo
         aqxAahfjfER7A0Ftdz+Kbo3OapjqkDtFI8mU77b5RM1UOkosiSm0t3uDykuHCzW7L9ul
         SGVw==
X-Forwarded-Encrypted: i=1; AJvYcCXG3336uxM/+iB5AZrbHduzW1/TmW1eWvbE9WVRZlN98Z848vjVpeg15VboMUY80FlRAtd0R0QlyABnIO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5L2vGOmqlbdS3nTh7kXNclUKZj00VhEXqguN+WFgREkXvaVMB
	4z1E/0BSh44Z98ezl0ulr930OEff83agNITEYOdmXANZQFu2Fk5vRq6g0ArT/J/Xs467eJ6cBQQ
	0pgOKGk1yatJ7Eg3aXurrFkp0bnc6awu/Pb01DTuYOy6IQq+mJPNC3atEgcK8+EZbnag=
X-Gm-Gg: ASbGncuyVErPBYMNCNrftflSRCmMkHq2+jAC5dvQ2dmR6E4b7sHRvUZfLcX+10rCNg0
	qkPgUtfQgBIEKJTmED3x1jXkyPyuF4V8Q8GyBAYLmqdpIBpDipvOZxoGwREY4bYAhnQ8beczUMb
	rx81rjLRI4NcyFNy1sbdL+ejm2tEMHHpAA2L1ruatxr+UZbPnM769vxO/yIXS32KQ8Fi14VDRBd
	dGwC8ZZUMhn7em5PK/8WnKZspEd0ogCuY188SCdo9lRMsfI5kbGwMjrWZgdiYpcMu+Z+CW0RxXy
	fPYGIxNbJs8jSmctC7WPv/We25LTGDLC+qh1OTB+tKZiWsAqOJRRYGUxWDDCPt5qyOGqGiObRn0
	wQAk1o90a9KGmYcJnrSvOMGaew/WfNLQD91oq
X-Received: by 2002:a05:6a00:2ea3:b0:7a2:7dab:d51f with SMTP id d2e1a72fcca58-7a7589981ddmr5103091b3a.16.1761914047434;
        Fri, 31 Oct 2025 05:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqmgCkFBZYLgYBH7wquaCa+iyKQLEyVbtLP3pTNPnupb0WKHTh4W4WJd+IM0naPG7iJ1MD0Q==
X-Received: by 2002:a05:6a00:2ea3:b0:7a2:7dab:d51f with SMTP id d2e1a72fcca58-7a7589981ddmr5103042b3a.16.1761914046845;
        Fri, 31 Oct 2025 05:34:06 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8982109sm2131277b3a.1.2025.10.31.05.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:34:06 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v10 1/3] arm64: dts: qcom: sm8750: Add USB support to SM8750 SoCs
Date: Fri, 31 Oct 2025 18:03:52 +0530
Message-Id: <20251031123354.542074-2-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031123354.542074-1-krishna.kurapati@oss.qualcomm.com>
References: <20251031123354.542074-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDExMyBTYWx0ZWRfX4cufYpmpaHwM
 5TIdz/NOr5nW0lFxiBL9g+2oJBYmvR38z0skvCf8BifEqTiiCN32cCDlbUKkz3ZvCnWrVlGqZnL
 Y47hIguU6rAnSIZEX/YL8LczHqHGcC+/LagJZSz4iRB6nlWy1GsN+1PHZitlheZYabguP1IjX6P
 L8GkhUPstg97dONOcNh6pwoFZQJHm7CmydHV0uMc/rniy40MkAIbLffsJ7nZcpnuwmePNP6erAN
 OBI94dh9FiFnHACrjBOBJhpGLZ0lDjUWqz38mPBnecs0PT+IS85BV9IgRYuxtYguGE3GzMK5uPf
 7Y1NCONMRuBfbCxTygjDZez8ATRl1r9Zi1uyG9YO8HSlDF4efvhV3UVV+KudjKdgeP8KF5oTuBa
 MFsljPkgQgXLVc+JSI2T5byQ56jDcA==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=6904acc0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=n1SQX4eW7R_9Zp26JX0A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: u5nhACWg7IsBk7t7cGmXN0E4rSbbVtsm
X-Proofpoint-GUID: u5nhACWg7IsBk7t7cGmXN0E4rSbbVtsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310113

From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>

SM8750 chipset contains a single DWC3 USB3 controller (rev. 200a), SS
QMP PHY (rev. v8) and M31 eUSB2 PHY.  The major difference for SM8750 is
the transition to using the M31 eUSB2 PHY compared to previous SoCs.

Enable USB support on SM8750 MTP and QRD variants. SM8750 has a QMP combo
PHY for the SSUSB path, and a M31 eUSB2 PHY for the HSUSB path.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
[Konrad: Provided diff to flattened USB node]
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 161 ++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index a82d9867c7cb..3f0b57f428bb 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interconnect/qcom,sm8750-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,gpr.h>
@@ -635,7 +636,7 @@ gcc: clock-controller@100000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>;
+				 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
 
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -2581,6 +2582,164 @@ data-pins {
 			};
 		};
 
+		usb_hsphy: phy@88e3000 {
+			compatible = "qcom,sm8750-m31-eusb2-phy";
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
+			compatible = "qcom,sm8750-qmp-usb3-dp-phy";
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
+						remote-endpoint = <&usb_dwc3_ss>;
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
+		usb: usb@a600000 {
+			compatible = "qcom,sm8750-dwc3", "qcom,snps-dwc3";
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
+			assigned-clock-rates = <19200000>,
+					       <200000000>;
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
+			interconnects = <&aggre1_noc MASTER_USB3_0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_USB3_0 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
+			iommus = <&apps_smmu 0x40 0x0>;
+
+			phys = <&usb_hsphy>,
+			       <&usb_dp_qmpphy QMP_USB43DP_USB3_PHY>;
+			phy-names = "usb2-phy",
+				    "usb3-phy";
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
+
+			dma-coherent;
+			usb-role-switch;
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
+					usb_dwc3_hs: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_dwc3_ss: endpoint {
+						remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
+					};
+				};
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm8750-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x10000>, <0x0 0x164400f0 0x0 0x64>;
-- 
2.34.1


