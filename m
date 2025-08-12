Return-Path: <linux-kernel+bounces-764995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C24CB22A40
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95D71BC5A44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9482877DA;
	Tue, 12 Aug 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gH8Q6Cou"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF152877C4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007028; cv=none; b=jSFX6W/6cbZBNOY+DIJ/Cur7rEQDerkkHtDDzhK5AW3VREOoS38uL6R9qQivbD75fCvpISd0h4/bVyXU7+ynBuUG2ZpCVCBkOmBKgWg9KT7jsT2PaOBdyvC5k+icpo2eMBJYry1gEAeqcn+EBz9RCm790uhI/MMOWAhB7yr5UL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007028; c=relaxed/simple;
	bh=ZHN1GYoa/UjGJmJso0YGyCQ2QI6I2ebKzKZi1WqJE3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VZTVThQqs5piG9SQglHgH4v0cI8IC8fazvEdM3a7TKvi9iQVS9jvmT0Mqb36AyTYY13X+4rAkjUm0spl5WGU0FzicXtDbcywu5+jWosgSzSUth0pud/N/f/chezGXJyxKaUqybuSrcd+ZHIWoWgUlBPEKXTaitHxyoCyMpnyscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gH8Q6Cou; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvoP1029782
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vC9kVYpsmo7G6F9s1+W/Z0x6YZORmkun/3JdzHvaSEM=; b=gH8Q6CounJqUU6Ez
	jrdnrJknDqh6Y4uLItQBP09lDLP1XINCFIXGFl/TAAxJibD/N/r356F7zDxmnIBq
	Z/KGiwrdQ01XAXIeFC/U/iBrH08jltBNccOA2U2B/MWKI4PPBtbFTGE3gTcgx0PL
	synrXkJLC0yd+sYKYLbPIDyqklB3GG1kj8XpbWxbT1cRzIqE9JKdqVJ3hk7/arXq
	C2ZSWLgTEbns19xJf51c/8cFcZoT+d7Ubt7rQywxs6su7n0Isrc0P2RrXMcqKOBD
	nTM/FzuH4BuWf/PhthPMIg+l+rCjLDjrgI9pBiIRY/a+to8zq91by4bMJ0T9xqXS
	fgyoyA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g8and-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:57:06 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so8607110a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755007025; x=1755611825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vC9kVYpsmo7G6F9s1+W/Z0x6YZORmkun/3JdzHvaSEM=;
        b=EjY2ZfNOSITF3LL2fkHBBcnPaZq7n+dQBlxY579xEZHboGw51yZhN2xOL82z7QxQ8C
         s/E5cnntLtBzhfketq4v0FP8GIrM9Aqa1pelhUGwQvZb1iav2ERb5QigGK2azTe+JIac
         CvFayMccVei0aXxtaawpsDwZbaobE4OHOavzoh7kDbxyTSB3UKnAo++UYLsYYTYwpKZy
         b6OJlwIvT5jD66Aoe6C+qXCtkGcFEEXh3v4HJPnVH8SRyeI8zBTX6yOCdfuNdCY63rhA
         PgQ5ehvNQ43QIPlkoMsQ2zaKiJELIOYaBYwu6DHJUWLhSps1qbQR8/qX5N/PG9PN6wkm
         S4EA==
X-Forwarded-Encrypted: i=1; AJvYcCWd+p3rDRRnf+3rGb0Os0aQrLsMmLDNfb4dlOGBtojUBdeRSSJaCVxsxVS4MS45+jbgv7QmsiG47fMTAzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBsajEYmWnAqp/qBXZ2WF+PrMp/nq19U4ljQ08SOPmd3uTzpeD
	veuEp15+f0PZeryZpNEtwAi4Z4dwZx8mwCkWgjk4EjVNNQFCLU9vgLAHDzBlFZmFdml080eYHYP
	tm5IBcxxpDhn5uk5iHCoOWRt/SHhvvqfsQXBuNc1CB9EoeXy0N8TIONHSHxiALkr/PvbAto4JeC
	k=
X-Gm-Gg: ASbGncsDcnR6ziy5LdjSgs86MahCmhs6nZ6jjWJlT9VFircfDTOMGnaePlKg2yPDEIj
	EG5sP6CP8x0KXRjUN5/5IW66RUQCBYOINzxbyaRD3q+b5/kZXBdRVNRTIjOpZ4EDoMiosZLKJH2
	tiwLScD3J+YRWYMdnkuhy/NzIJpbKlobBlh4EAz49h9/kjwd7KsTdp2GUtgbuIR/MuCXrIoDQYk
	dOw5IuOYsONlQiGbpHw+jGxwcT/RGAF5HlrDum2AQ4QnIiZ+OE1T4o5G3OVx4bgwLyAci2+4zXi
	m6Ay7lLT9cKLVO2w3I/ZGyw1l4RY+FVEmxgJ6nnAPEp4268hmJfsHHpxdd7u1rdTF2N3Op7KugA
	=
X-Received: by 2002:a17:902:d4c1:b0:234:e655:a632 with SMTP id d9443c01a7336-242c225f5edmr251590175ad.51.1755007025180;
        Tue, 12 Aug 2025 06:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2skVoQjxqv2NdGTdZLMTCJHQUl9+Juy6XzRWzaTW6Fsaq0wtQm8R6pVqSia8VInKNIJ0u7Q==
X-Received: by 2002:a17:902:d4c1:b0:234:e655:a632 with SMTP id d9443c01a7336-242c225f5edmr251589645ad.51.1755007024540;
        Tue, 12 Aug 2025 06:57:04 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24302e028dcsm16703265ad.91.2025.08.12.06.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:57:04 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 19:26:45 +0530
Subject: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Add PCIe0 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-sc7280-v2-2-814e36121af0@oss.qualcomm.com>
References: <20250812-sc7280-v2-0-814e36121af0@oss.qualcomm.com>
In-Reply-To: <20250812-sc7280-v2-0-814e36121af0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755007012; l=5970;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=ZHN1GYoa/UjGJmJso0YGyCQ2QI6I2ebKzKZi1WqJE3U=;
 b=tyJEfhajjY7k3a/2MiR5Av5yhH8Wvva+GPaFMZ/KIiYQ8xV7O6o5tNwIgKEfvHctMWTCztqho
 XzKcqisRDjhBx6iAtgQtgJamPszkeG/I6QO5FnozyqaxAGSoMcyDwlo
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689b4832 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=hNZP5i6h11z2s_4BSHIA:9
 a=joUWkbzKA2oh4xZ8:21 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX58DmA13bs+x0
 cZNCSky41o/vzor7sQXfBFDnEeG4q4oIzcTh0xpTiSHjKcxNZ8E7o6LNSRYPVwG3xJLfASYeNFE
 gH+Ph2H82+ex+sTVf0ay6NnVEIKFsuia4BCuOroCp444J5NNTlNmok1I6VBu4udWeD69Ui3DymY
 u64EA1iuykRJVy3uRpkw16DU1L5y1PMsZfw8F13QoAn7E1w1kq0KQKBN8/bTVTE4RdfHGFyec4F
 Xawx93HpqcyY1wvWFSzZAGcgomIPNWQ+N3UuJ/OAWFIh9GXtFW/kHlxuc3ZGTo7mOVNUO/7Ivm8
 FfEAroICRpbjBfGXLf5IKVIEEuV1i56eaMzu5XxXfItAvHx7AsDkVNclbt5VK4hGdmtuHTvwcO8
 4dsjmXYf
X-Proofpoint-GUID: zAOfMSDAan4C3nbCRS_2aCujfpNxi2_G
X-Proofpoint-ORIG-GUID: zAOfMSDAan4C3nbCRS_2aCujfpNxi2_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

Add PCIe dtsi node for PCIe0 controller on sc7280 platform.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 170 ++++++++++++++++++++++++++++++++++-
 1 file changed, 169 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 64a2abd3010018e94eb50c534a509d6b4cf2473b..b0f688ce1c285888c05ed718e58dfafd51e2c1cf 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -970,7 +970,7 @@ gcc: clock-controller@100000 {
 			reg = <0 0x00100000 0 0x1f0000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>,
-				 <0>, <&pcie1_phy>,
+				 <&pcie0_phy>, <&pcie1_phy>,
 				 <&ufs_mem_phy 0>, <&ufs_mem_phy 1>, <&ufs_mem_phy 2>,
 				 <&usb_1_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
 			clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk",
@@ -2200,6 +2200,149 @@ wifi: wifi@17a10040 {
 			qcom,smem-state-names = "wlan-smp2p-out";
 		};
 
+		pcie0: pci@1c00000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-sc7280";
+			reg = <0x0 0x01c00000 0x0 0x3000>,
+			      <0x0 0x60000000 0x0 0xf1d>,
+			      <0x0 0x60000f20 0x0 0xa8>,
+			      <0x0 0x60001000 0x0 0x1000>,
+			      <0x0 0x60100000 0x0 0x100000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
+			bus-range = <0x00 0xff>;
+
+			dma-coherent;
+
+			linux,pci-domain = <0>;
+			num-lanes = <1>;
+
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+				 <&gcc GCC_PCIE_0_PIPE_CLK_SRC>,
+				 <&pcie0_phy>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_CENTER_SF_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>;
+
+			clock-names = "pipe",
+				      "pipe_mux",
+				      "phy_pipe",
+				      "ref",
+				      "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "tbu",
+				      "ddrss_sf_tbu",
+				      "aggre0",
+				      "aggre1";
+
+			assigned-clocks = <&gcc GCC_PCIE_0_AUX_CLK>;
+			assigned-clock-rates = <19200000>;
+
+			interconnects = <&aggre1_noc MASTER_PCIE_0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &cnoc2 SLAVE_PCIE_0 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "pcie-mem",
+					     "cpu-pcie";
+
+			iommu-map = <0x0 &apps_smmu 0x1c00 0x1>,
+				   <0x100 &apps_smmu 0x1c01 0x1>;
+
+			resets = <&gcc GCC_PCIE_0_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc GCC_PCIE_0_GDSC>;
+
+			phys = <&pcie0_phy>;
+			phy-names = "pciephy";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie0_clkreq_n>, <&pcie0_reset_n>, <&pcie0_wake_n>;
+
+			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+		};
+
+		pcie0_phy: phy@1c06000 {
+			compatible = "qcom,sc7280-qmp-gen3x1-pcie-phy", "qcom,sm8250-qmp-gen3x1-pcie-phy";
+			reg = <0 0x01c06000 0 0x1000>;
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_CLKREF_EN>,
+				 <&gcc GCC_PCIE0_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_0_PIPE_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "refgen",
+				      "pipe";
+
+			clock-output-names = "pcie_0_pipe_clk";
+			#clock-cells = <0>;
+
+			#phy-cells = <0>;
+
+			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+			reset-names = "phy";
+
+			assigned-clocks = <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			status = "disabled";
+		};
+
 		pcie1: pcie@1c08000 {
 			compatible = "qcom,pcie-sc7280";
 			reg = <0 0x01c08000 0 0x3000>,
@@ -5285,6 +5428,31 @@ mi2s1_ws: mi2s1-ws-state {
 				function = "mi2s1_ws";
 			};
 
+			pcie0_reset_n: pcie0-reset-n-state {
+				pins = "gpio87";
+				function = "gpio";
+
+				drive-strength = <16>;
+				output-low;
+				bias-disable;
+			};
+
+			pcie0_wake_n: pcie0-wake-n-state {
+				pins = "gpio89";
+				function = "gpio";
+
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			pcie0_clkreq_n: pcie0-clkreq-n-state {
+				pins = "gpio88";
+				function = "pcie0_clkreqn";
+
+				bias-pull-up;
+				drive-strength = <2>;
+			};
+
 			pcie1_clkreq_n: pcie1-clkreq-n-state {
 				pins = "gpio79";
 				function = "pcie1_clkreqn";

-- 
2.34.1


