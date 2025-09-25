Return-Path: <linux-kernel+bounces-831850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208E2B9DB25
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286BD188CE87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A0F2F2911;
	Thu, 25 Sep 2025 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YyL8gUtq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078D02FB60B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782065; cv=none; b=qS2wPyWltDz20hdX9CTtJBi/e7o2QuUNDd/4vuwDhGLNhir/9WvHJ4AEBoOwuffWz81n/TjS813Ab/0LK827MJ61VD7WSSgvJiIrhKn4FoEm3i9gNYQYw4F/XkFtTIsc/4eWN4fitU2cpbC6t9OdP+RjD4e2Wt7V62n3w0Z8/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782065; c=relaxed/simple;
	bh=LIbA7RAUkeBIDw/1Wahxnh2wpqWF5ybKUZRSiQHeCus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNi+ee9mmqZRFFYX4FwszcotK2BNlnFC7LAS5h0V4VmcslD6+7uv+jDs+p7erEp+hdHOG+PcyqeI7W+l/s3RzmMBPFbtYYc1pxKaeYkYoTrFSBFz0WQNM54yS5qWwgDikVcu+g3pZXykzLHog0S0dg+1NGKgQKoE/hGZJ+qA2P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YyL8gUtq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONaxo8018026
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Agx2Jlq7unyxwL0kxfDlK4aS3MTgbllLfbRUmVSbLsM=; b=YyL8gUtq5peZcacr
	WsBCEK70ZXDi/BuoBRpEPReGvmAUl/yXTDauD7Ha0GdGAjpA4cXLrG0Sqq6q3ktu
	pISm2KmmGei8U9+MEuqoxXRYQKgWdjo6FRLTPVbvQ9nNxitJATiIkhoxgop49Dwa
	CHMTm+EPcD1loMrCGQPR/GIEYUWM39i32rDH5GDp0TTaJUFb0MoYNacYvl6oQzkA
	jV3odhbZO6n+KsiGYbh7kl0n0eLjJVTWuDq/fIvTemrC3+7O6ejvQH/JpFRUn2pu
	eceAijsYtSfW4EpmEb4FJP9zZLBriTFEPoZcd86ueB1BxLQqy+5KPJyOe7BXr9MS
	PLN79w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkb0m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-267fa90a2fbso17267555ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782061; x=1759386861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Agx2Jlq7unyxwL0kxfDlK4aS3MTgbllLfbRUmVSbLsM=;
        b=l9nFcxPbS7BtcJkeTBTaUO2R9Yi7BmYK/qUYGY9LQYMJjynTpIobjl8Cg0fQBWvA88
         aLQT2XEuzIKAIdXTXfVWLEe50w3TMGS7nM7f+4hQrb18OAeUp2IdcZY0Tqfu22B6A1aw
         KDB4D93beolPGnEqDfZOwwHsCrlrWXAMpaLTnfVIjJeAIsH93DZtUso167jtc6rrCGQb
         0e1TX5gLsQsDPqj/rinFXua//l1/86VyiZTOYVbFlteb3B5icpyubRvYzT2MNXo0BgCl
         DVTGdlYC6+WlnwHnVPJgaCaEvieVUF2wjVNGJBUrtleB0nycmhDHrX/V1FudxJ3xOZyI
         YcoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU76Sf0UbJN652F9BjMrPetaaM/AMOKaoa0xHGfCLaRE0C929a3gaqETsUioj5Nu/qZZPULBaNysCA8wI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX2rMO/9ADN7NFCodbbq6UibcT38xdQkCQMtZbaz6WzaRrfgPy
	6MqUO4bPcq+stHvcVXMxvuluOUeDQCzfKh6LSX7h7ZWpmPFob+ERewKrKuSY2wWsmvX14o1CoDJ
	woVFyoWuMOvaZZkhQszX5nqN5w7385ezW+OkhPgWKU83C8fn6Ew4FUo0UJycIYY7fdH8=
X-Gm-Gg: ASbGncuuMTyVtUDTORr22pFvFh61oCWK7vrEceiFP5gfwg83QR9fnqgGtLl3vSH0l9G
	3MSNWnzKcVtBd2K/WIOMfTDNfrsRsaDps94GrBcg6/1DRfC/DuhgyfwDYJAzmp1GoOztTofgzAS
	HVaYmianfty/eX0Koz9Rfszln0EQWgrKT9kPumdO8GHMEFbELWlBySJ/FYA166lcoVYGr1+Abck
	zkhoNBVG0YvuwKCUg8BpQB+klkpQ7jz+fqQPk3AwcOYAyvm3msG3iRToGjWz8nPG+EUKI+WYm+7
	9ibBk0jKyKRyd3JE/9KdWU+tQXS0kDQP1mAl07PC5b8c2+A2XMSnlP5uO9ewg+cuN/IeS9kPsu/
	lcicpHQPsHvHXFsFRGDUdus74p4rh4Orfx5z4Sc75n1Wjg5cCyQssCoC1bwz+
X-Received: by 2002:a17:903:234b:b0:269:b2e5:900d with SMTP id d9443c01a7336-27ed6ac9420mr18065965ad.5.1758782061506;
        Wed, 24 Sep 2025 23:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9hXFeGhx9lwr0WTXqzekeuC/e6EoA5JvdWt8Jolx2Jf8qbsZ1xPKnVVw4g1NhSpq5ZI5hiw==
X-Received: by 2002:a17:903:234b:b0:269:b2e5:900d with SMTP id d9443c01a7336-27ed6ac9420mr18065265ad.5.1758782060485;
        Wed, 24 Sep 2025 23:34:20 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:34:20 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:27 +0530
Subject: [PATCH 19/24] arm64: dts: qcom: glymur: Add support for PCIe5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 9AqjgzM9WaC6KtMMjh_ws2LG5mRJ7_8f
X-Proofpoint-ORIG-GUID: 9AqjgzM9WaC6KtMMjh_ws2LG5mRJ7_8f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfXz6pEVdvE06Qd
 2xTu+6L4D3VnfDHh0R4jZAN/ow8e3roLef+ikWEPaJg/vvEpbEldzdH+4zI+dIiCmTrRG+Z+P9L
 SojcP+z0zHIdmA3NqGqcBbl1ndE5umi1ETj/nwb1+h1dqx13elZ4vOOpUvWNzG/rxjicu9esJhD
 UDiLhHyVVDgoiyxK/zh2qX3PInL2JYrDwN7p3ePsHeWbVYcrFMCx0AwP2kaV9CTt/WH42owVVsW
 +ll28VBKuMzdw0amiYplkV2o7W8cGeBo8R+Ni7YQgaCPO4S80JEc5iYsyIjqnPubpGXFGM7IYfa
 Y4xq0jF/f8G55lagxPYO7pyZ4IUfBnOhy7X0l2ZSkOO9dvHRXs/+8QdVeqxR2yRU0t44Uh1Ul86
 9mDs1TDz
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d4e26e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=CvXMyPvPR3rqxJw2tBEA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

Describe PCIe5 controller and PHY. Also add required system resources like
regulators, clocks, interrupts and registers configuration for PCIe5.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 208 ++++++++++++++++++++++++++++++++++-
 1 file changed, 207 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index e6e001485747785fd29c606773cba7793bbd2a5c..17a07d33b9396dba00e61a3b4260fa1a535600f2 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -951,7 +951,7 @@ gcc: clock-controller@100000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>;
+				 <&pcie5_phy>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -2511,6 +2511,212 @@ pcie_west_slv_noc: interconnect@1920000 {
 			#interconnect-cells = <2>;
 		};
 
+		pcie5: pci@1b40000 {
+			device_type = "pci";
+			compatible = "qcom,glymur-pcie", "qcom,pcie-x1e80100";
+			reg = <0x0 0x01b40000 0x0 0x3000>,
+			      <0x7 0xa0000000 0x0 0xf20>,
+			      <0x7 0xa0000f40 0x0 0xa8>,
+			      <0x7 0xb0000000 0x0 0x4000>,
+			      <0x7 0xa0100000 0x0 0x100000>,
+			      <0x0 0x01b43000 0x0 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config",
+				    "mhi";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x02000000 0 0x7a000000 0 0x7a000000 0 0x4000000>;
+			bus-range = <0 0xff>;
+
+			dma-coherent;
+
+			linux,pci-domain = <5>;
+			num-lanes = <4>;
+			max-link-speed = <5>;
+
+			operating-points-v2 = <&pcie5_opp_table>;
+
+			msi-map = <0x0 &gic_its 0xd0000 0x10000>;
+
+			interrupts = <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 519 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 522 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 523 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 524 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 525 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 945 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7",
+					  "global";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 0 526 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 0 428 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 0 429 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE_5_AUX_CLK>,
+				 <&gcc GCC_PCIE_5_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_5_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_5_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_5_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_5_EAST_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "noc_aggr";
+
+			assigned-clocks = <&gcc GCC_PCIE_5_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			interconnects = <&pcie_east_anoc MASTER_PCIE_5 QCOM_ICC_TAG_ALWAYS
+					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&hsc_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					&pcie_east_slv_noc SLAVE_PCIE_5 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "pcie-mem",
+					     "cpu-pcie";
+
+			resets = <&gcc GCC_PCIE_5_BCR>,
+				 <&gcc GCC_PCIE_5_LINK_DOWN_BCR>;
+			reset-names = "pci",
+				      "link_down";
+
+			power-domains = <&gcc GCC_PCIE_5_GDSC>;
+
+			eq-presets-8gts = /bits/ 16 <0x5555 0x5555 0x5555 0x5555>;
+			eq-presets-16gts = /bits/ 8 <0x55 0x55 0x55 0x55>;
+			eq-presets-32gts = /bits/ 8 <0x55 0x55 0x55 0x55>;
+
+			status = "disabled";
+
+			pcie5_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/* GEN 1 x1 */
+				opp-2500000 {
+					opp-hz = /bits/ 64 <2500000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <250000 1>;
+				};
+
+				/* GEN 1 x2 and GEN 2 x1 */
+				opp-5000000 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+				};
+
+				/* GEN 1 x4 and GEN 2 x2 */
+				opp-10000000 {
+					opp-hz = /bits/ 64 <10000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1000000 1>;
+				};
+
+				/* GEN 2 x4 */
+				opp-20000000 {
+					opp-hz = /bits/ 64 <20000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <2000000 1>;
+				};
+
+				/* GEN 3 x1 */
+				opp-8000000 {
+					opp-hz = /bits/ 64 <8000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <984500 1>;
+				};
+
+				/* GEN 3 x2 and GEN 4 x1 */
+				opp-16000000 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <1969000 1>;
+				};
+
+				/* GEN 3 x4, GEN 4 x2 and GEN5 x1*/
+				opp-32000000 {
+					opp-hz = /bits/ 64 <32000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <3938000 1>;
+				};
+
+				/* GEN 4 x4 and GEN 5 x2 */
+				opp-64000000 {
+					opp-hz = /bits/ 64 <64000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <7876000 1>;
+				};
+
+				/* GEN 5 x4 */
+				opp-128000000 {
+					opp-hz = /bits/ 64 <128000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <15753000 1>;
+				};
+			};
+
+			pcie5port0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+				phys = <&pcie5_phy>;
+			};
+		};
+
+		pcie5_phy: phy@1b50000 {
+			compatible = "qcom,glymur-qmp-gen5x4-pcie-phy";
+			reg = <0x0 0x01b50000 0x0 0x10000>;
+
+			clocks = <&gcc GCC_PCIE_PHY_5_AUX_CLK>,
+				 <&gcc GCC_PCIE_5_CFG_AHB_CLK>,
+				 <&tcsrcc TCSR_PCIE_1_CLKREF_EN>,
+				 <&gcc GCC_PCIE_5_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_5_PIPE_CLK>,
+				 <&gcc GCC_PCIE_5_PIPE_DIV2_CLK>;
+			clock-names = "aux",
+					"cfg_ahb",
+					"ref",
+					"rchng",
+					"pipe",
+					"pipediv2";
+
+			resets = <&gcc GCC_PCIE_5_PHY_BCR>,
+				 <&gcc GCC_PCIE_5_NOCSR_COM_PHY_BCR>;
+			reset-names = "phy",
+				      "phy_nocsr";
+
+			assigned-clocks = <&gcc GCC_PCIE_5_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			power-domains = <&gcc GCC_PCIE_5_PHY_GDSC>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie5_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x20000>;

-- 
2.34.1


