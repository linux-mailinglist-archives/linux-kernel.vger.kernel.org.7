Return-Path: <linux-kernel+bounces-864513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803FEBFAF2B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC34424B21
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFE430DD04;
	Wed, 22 Oct 2025 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ijoNlGpH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D0630DED3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122470; cv=none; b=g9equRqHcOF49vqcPW3fMyPZvu++yhunYFA9r+9+vxJEHoLGAnDyU1zY8oXEKg32nYfZOB+UbSMCzvCnuyLVMgPWm/3DMJ5hSrsxX7jyiyZlOpKXPqZzn13RcEQPn6m/lfNCqsLRkI1nDYS+OLctv7VFZ//BEOza4ZMEmNcvkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122470; c=relaxed/simple;
	bh=W5JHrMf93bRLE2Ita34LzLH/vdLFwAFadbe4MH0UnwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kzB5b57lsu3M48VdV7H1ZgffN9x64YI6DPFQ5QF8d5YSfrS8XH6SYvc0rI5FN5oK+zNYJSBv43i2pxBULKW/lVCTs+9GmsCi7VA9IguKfN0atvcVYvxdgY6M0+VwXlYucKXaOXtHW9HJpLCZpnGL1xtrCyJPcKMuOSCbTvkPDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ijoNlGpH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7EjEf012401
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pyLQTdOZaFo
	GC1dIB3L3ICKj1tOzHQgV21EQ2wSriAw=; b=ijoNlGpH5P5Pn7lGnTAt780V+bc
	PH0z2elTrQ/tBDlNJP4KPQsb5ffGpYMdEzFIhhg46tT07i4OFusxtiajHN+wa6Uj
	ktgTh+5MbLuM4xvERTgNUrYsU6koHiwdndTLmGxw5dNY0LycaUFIHsdYl63gYzA/
	iwcT8A3XmVwFZ+isNr2heqJVWWxvSyHdGc2gsszjokqsON+rtMobaGN0JjmHe4xB
	bUOyhZ7L/d3iCTMq9s4LCwxRjtzrubhjWhjeiWc/DSW7shzj1ERv85CY+l8e28+v
	ncM2U+WHofm97cWLl8qcc2U82TqwsOclvIqKrtI7oQorsheYgzMxEmClO3w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0hrt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:41:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-79e43c51e6fso541155b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122466; x=1761727266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyLQTdOZaFoGC1dIB3L3ICKj1tOzHQgV21EQ2wSriAw=;
        b=qAEMJ1ImLFG6A2eYsKIKiq/PnjBMFRkb024pjNdDimPVS9iexgz6nSfNrultcp1KeZ
         Y43tk0DnQc6D4dOm4mazhUMRueVVK+BXoec6IRX31lLiCADE9GH5QrgOOdpxFX3RMQU+
         iBHFcwTrduWc7O+YpLUaz4DAvuHPAan2hPJiNmuJIxN4oXu4mo1vXlWzSrdjFyVRdGp/
         XpQkFyJfvN9ksPuLFtK9tsTKDAan2fcimq7L/MwMfTXwIGRJkVIfbefzzZqV28OebVLw
         viBEBromb9xouasnpJ2DRkC1Fff3IkmeDlHGNKcNf/uqLA34101jMnEiqJTGgkIj0dwS
         /lCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdaKq8ahZduwz01ur2EufhmqJlBgqaqevDBIShK7YMRQhXt2zb248B7+JiylluvxmcF7ZOxr54OVfZIRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeqQl7X8HPFcWb4AXmYsQqzox4MUGUzVcY8Vqev9A64dGrzZ44
	bdnIhzwuLBh3dGPmozB4qi2ZGkgHCU/wkgAiTXgWTu0DxSZjN6gmyVGLiRLFBLdtFWZBrYeEqK6
	7j3uOi2+hfQTv9i3EdRPliH93qqkkbVJar0+0jM8TIrrX1fJakRFxrDVt/8NB876bSG0=
X-Gm-Gg: ASbGncuAAofoTfdUCTSnwuedEcwhlUeUMzTgeqli1At9+cykFanaDZcQ/xLLpvZCoHP
	WN5GJHJDlT6uvWAAq31ZAKU3C32r2AqeGzk2M8oEOPd0hGG/rMPYwpYNAU5fywP4IwfCckyShNV
	QmF2ALN+nd0T5ZuRd3INN3UzboJPnOGGpS1pu4X6qkWKb0m9bW47yj/zVf1AJJrYi4gDvXG/PGI
	em2bzYBKxBYfMWGlwNSshjo5AH+RHMZWaPgjkXcgsk4mDjga9zFQ2/yOK9xl1d0ZUOUtlhOjn62
	jeNg8I5ZqeVYlXVFsX2VYpOXwwfJYlIWRAYuq26pD3/+DhR1XTUCZ6+8aVtKaSe10jSFZ7MI9G7
	mgU3mSRRIBtiJGU3NdvflZQvbASifuejkEtEV
X-Received: by 2002:a05:6a00:1817:b0:78a:f7cb:1e81 with SMTP id d2e1a72fcca58-7a2647c8eccmr3235840b3a.13.1761122465572;
        Wed, 22 Oct 2025 01:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb91OwEUPXSLbVPj+Cd6pyUWYUNUbhUhWolXQs0W0Kwo71NvZHu8POb8y8sNsk2y7/uHctWQ==
X-Received: by 2002:a05:6a00:1817:b0:78a:f7cb:1e81 with SMTP id d2e1a72fcca58-7a2647c8eccmr3235811b3a.13.1761122464870;
        Wed, 22 Oct 2025 01:41:04 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a25e9be9f3sm3740317b3a.71.2025.10.22.01.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:41:04 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v8 1/3] arm64: dts: qcom: sm8750: Add USB support to SM8750 SoCs
Date: Wed, 22 Oct 2025 14:10:50 +0530
Message-Id: <20251022084052.218043-2-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022084052.218043-1-krishna.kurapati@oss.qualcomm.com>
References: <20251022084052.218043-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX15aBAMQ56uy1
 59wa6UPUo/RyOV2Q9kV+pGoHNtQqPTGopQgdccy9p0dVD6FbTr80zv5XqaBQCKFfDe7IoUJaGFY
 +Y5fIz+ynQ5uEVh2N1hgCsHaSU3qcDiQh3fMujo10zYsxQO1Yj6jRZnaiRpa0pUF3GEUMngKBsv
 4mMNY0L1/6J04eIdMZ+JxC8gEhL2hyWSwEbfjoEQ5zz1nOWE+bPvZKgL4HcE5il5o3ljCfcSN4H
 59kVIYBVjKT/7Wnc7YTgCeSWA1yJaITnonuaDcczN6wKYfCY6Sauw5Y3bx5VVe41g3E9HMuOVzx
 xplIi2RGhszDWWwtQImhY0e6BJdlnT5dDFzw5JqKCuFcUjHbyORH9JeEPDQzyMt84llsfn81ZCF
 Es972nNNlUN33C83o9QE7rBklFQWeQ==
X-Proofpoint-ORIG-GUID: I9e0CwEzUsMKz2bbovxyAUSfyoUUZ1aV
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f898a3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=n1SQX4eW7R_9Zp26JX0A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: I9e0CwEzUsMKz2bbovxyAUSfyoUUZ1aV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>

Add the base USB devicetree definitions for SM8750 platforms.  The overall
chipset contains a single DWC3 USB3 controller (rev. 200a), SS QMP PHY
(rev. v8) and M31 eUSB2 PHY.  The major difference for SM8750 is the
transition to using the M31 eUSB2 PHY compared to previous SoCs.

Enable USB support on SM8750 MTP and QRD variants. SM8750 has a QMP combo
PHY for the SSUSB path, and a M31 eUSB2 PHY for the HSUSB path.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
[Konrad: Suggestion to flatten DT]
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 158 +++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index a82d9867c7cb..d933c378bd8d 100644
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
@@ -2581,6 +2582,163 @@ data-pins {
 			};
 		};
 
+		usb_1_hsphy: phy@88e3000 {
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
+			phys = <&usb_1_hsphy>,
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
 			compatible = "qcom,sm8750-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x10000>, <0x0 0x164400f0 0x0 0x64>;
-- 
2.34.1


