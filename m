Return-Path: <linux-kernel+bounces-786501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CEDB35A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D543684478
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72098318142;
	Tue, 26 Aug 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C0vDLJwN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12E030BF64
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206195; cv=none; b=g271t4yHtOMUe3C2vf6NwMXWAxpu2SNBVnKqW9P5LoQBKpkqvr9mho+ErWCy/B2k6Op6uC/d3Bl6bLLHUUUdux5BX8/3l/qaBYJGdHJDNFcsAqMKz+Z76If51wRRtnDPUwkWDSVKeagAKq7D4KeiNZa37+KeEE8fclhGpUN0+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206195; c=relaxed/simple;
	bh=uCwKakbnHqxRUEDYJHDENZK4dZF8AH52XyIcvvLd2js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLRB+p3VRNHGAaShj+UAlh9yAfQGybOdtWzBra99OcrOGi5ELKzgowYLOmeur1qmMiLWy6s7xkiCZJ+9CyrsLYuwHYAWpc9Q0PH+InFhBAWzKDCuGBeutXqdTZv1tyvyhNEd+VqpEuarY2sspNkgqnn2XrPRQFO3c45M3GA75T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C0vDLJwN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q59vmx026863
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IxIQhQomQAS30o8yPqwEl7kh8ZQDR41lcq928axCQDI=; b=C0vDLJwN/4T0rras
	OreYYqwPrknQKoR2LAWQJw8Hott8QWoE+DLoqvzxxH7YFqo3Wdibxbu3olk9I0Fh
	jsN2r7CPxLT9QMglrAtAk6lH8WsBtvkv7aBvdEqBz4HHmO9tNv5PLy2GydSWnZmo
	/VqoEPsIfrFlIV6XzJxu1K8d8Sh6JWtFbSfRLHPl+Qi/9ySAU3oiqIHe1laLjDLC
	OXVWy8AQg2duxEwS6y/mGJRzjwiHajID5kjy9UO5TBWP24mYmkLNJ+Dxc5wX7KB7
	45U8+monzwAMXJjR52oA70jkmDuK0WNsrhhCgS7pPsuhtY4yMWUqQP/YBltYqb9a
	Cf6YUg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6tj0hr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:03:12 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4c20148c54so1298727a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756206191; x=1756810991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxIQhQomQAS30o8yPqwEl7kh8ZQDR41lcq928axCQDI=;
        b=qjRD9rCPEbLyIF9aRY8p5M1aLgilKiSWp+1ZgNtUtEam2IYNjI3QazpasawDfmH0E2
         XfBT0wNZikkvD4V2to0ToYQ+Tv4ESK0vUGyh5X+v3NVrjPt/5hqijLcSir2uC1zdLM9Q
         nwyOUb7fEkxXSYUYSPLkzODgZYeDUPCN98mnIVRe5bPTcxxvOGUEnxp7UoF+z7tW5L/o
         UzMGHXQPnAsiVT+7FbIvuzRGEm0z49e//33NqVcnm5UjQpUgMBF+OKmaRS63EMRU/sb1
         QtDFVAjYsoLYuOcFIdYqAUPYaeAlZ8J/LAfYxbIHaN22aTjqTpGsLMT3hPSS8OG6e+F0
         LX0g==
X-Forwarded-Encrypted: i=1; AJvYcCXa47H1ZHFNRLc7av4nvUQaJDUK0gX6317Srk9XE/GG/QOHCoeDkQfCLVU3q+lARo3wSBXeLyKD9CUdGTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySaOwsOIGhw3cylttUPUlWU6bInGPUobxvYXMJuDgs4XdsnfoN
	wMneGF8kSLYrjkNJrk+2x/PiyrrgLCtWz79VrnPTTZqrjeO3WeremS0Q06Zqfn9USkskGl9d1mU
	VBXx6z357sOk+pLUcDuO9cHKuGSSDJhcTepv5KsExsX30ImDqfgKBIiyz97rcJuZ3HKA=
X-Gm-Gg: ASbGncs7cRU90sqkuGSuO80853IUtlAgqeqJQgGpUKbyB60NEve+7ckgY12mJcb+qUp
	aHEh//c9du/QVXQPa+lX2rBJfAOsMZb20NiEIYIa9VohdAOQL2sJ+SO1VIMNOG03hlidb4g0FS9
	fGUVAuqvU31YQ8kShLcf6FXLgGB3YMP6yEzHQl2HMZlRhy3CpWgPUlBbD8RnHhNyzusQEsKP86q
	+lwGjvxnVxBxgTjA1lqRvFvocq/8FoCtwuY/dg4TsjsOcmmHiLkD91sTIT5JdxTzqYJVejjikoO
	H1qjizRRVgeT8TVuC9k1lu+AaQ0PYba0HZG6hVhK1Xbi/1KiwEOBW0qIMYVUJc4F9LDjgWqOMh4
	=
X-Received: by 2002:a17:902:d590:b0:246:4eb3:9c08 with SMTP id d9443c01a7336-2464eb39dd3mr203060135ad.5.1756206191007;
        Tue, 26 Aug 2025 04:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1CF33K3fWdBghsmS2QyUSIaQzXtwbG3/eEzLG5/hoS5JLEsJ7o+CuX0kLqFRMxvZ8k/RUgA==
X-Received: by 2002:a17:902:d590:b0:246:4eb3:9c08 with SMTP id d9443c01a7336-2464eb39dd3mr203059295ad.5.1756206190440;
        Tue, 26 Aug 2025 04:03:10 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688a5e5esm93207955ad.161.2025.08.26.04.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:03:10 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 16:32:54 +0530
Subject: [PATCH v3 2/3] arm64: dts: qcom: sm8750: Add PCIe PHY and
 controller node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-pakala-v3-2-721627bd5bb0@oss.qualcomm.com>
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
In-Reply-To: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756206175; l=5880;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=uCwKakbnHqxRUEDYJHDENZK4dZF8AH52XyIcvvLd2js=;
 b=7Lftqag6gsk/C0b3geRf3rBbSEpw4AicKs2GdUMMCVp8RN986hP2sjxRZf2O+zGtjezyCRnNX
 wUfGPR2bx+oAlqDU1zHMJRL48l3eJGbL+DgHl7KpcjUrGzhZWSQMx73
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0MyBTYWx0ZWRfX0bOKvjdu8hA5
 ZrrQoomhAYSbBfLTtEcDt2PPbq6MTc5qTFvEZRZXMzRT6MiShzedBWXHJEgXCWiJ8cHwVywAl2e
 ukIpqkRgoDThPHxav/rOFK4UbYcZvC2iha5eH/f3yZlBnnrkgTwS4eECdZXQDRG1iy0WQwQ+704
 3AEVTuFD6zeTRnLQ1OOUNoA5N0tz7iCIL6RUpmIbsaCnayE+qqtXNAvNnh1dnRT5nRz0h80rQ9M
 GR++dLTfCGSVXrhYE5tRfcqZCxwXdy02kB+qlhbLv/wMA8uepqCPqYmbK7tOo5RmzNXeex8rn0T
 jGpFl3H8yueTOBOyvpRcTlNgw5UFwKzJilCCevWRKiR5URvWEKL1zmFU7qi5/Qd4QoRKxeYjvTe
 /U1aYpBJ
X-Proofpoint-ORIG-GUID: LQYZbAaH1CN7t6CtgoLmC5VU1ETLPoM6
X-Proofpoint-GUID: LQYZbAaH1CN7t6CtgoLmC5VU1ETLPoM6
X-Authority-Analysis: v=2.4 cv=W544VQWk c=1 sm=1 tr=0 ts=68ad9471 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=hNZP5i6h11z2s_4BSHIA:9
 a=3hQ7FE4IOERBLyhA:21 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230043

Add PCIe controller and PHY nodes which supports data rates of 8GT/s
and x2 lane.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 180 ++++++++++++++++++++++++++++++++++-
 1 file changed, 179 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 4643705021c6ca095a16d8d7cc3adac920b21e82..b47668a64bcead3e48f58eeb2e41c04660493cb7 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -631,7 +631,7 @@ gcc: clock-controller@100000 {
 			clocks = <&bi_tcxo_div2>,
 				 <0>,
 				 <&sleep_clk>,
-				 <0>,
+				 <&pcie0_phy>,
 				 <0>,
 				 <0>,
 				 <0>,
@@ -3304,6 +3304,184 @@ gic_its: msi-controller@16040000 {
 			};
 		};
 
+		pcie0: pcie@1c00000 {
+			device_type = "pci";
+			compatible = "qcom,pcie-sm8750", "qcom,pcie-sm8550";
+			reg = <0x0 0x01c00000 0x0 0x3000>,
+			      <0x0 0x40000000 0x0 0xf1d>,
+			      <0x0 0x40000f20 0x0 0xa8>,
+			      <0x0 0x40001000 0x0 0x1000>,
+			      <0x0 0x40100000 0x0 0x100000>,
+			      <0x0 0x01C03000 0x0 0x1000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "config",
+				    "mhi";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x23d00000>,
+				 <0x03000000 0x4 0x00000000 0x4 0x00000000 0x3 0x00000000>;
+			bus-range = <0x00 0xff>;
+
+			dma-coherent;
+
+			linux,pci-domain = <0>;
+
+			msi-map = <0x0 &gic_its 0x1400 0x1>,
+				  <0x100 &gic_its 0x1401 0x1>;
+			msi-map-mask = <0xff00>;
+
+			num-lanes = <2>;
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
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
+				 <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_sf_tbu",
+				      "noc_aggr",
+				      "cnoc_sf_axi";
+
+			interconnects = <&pcie_noc MASTER_PCIE_0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &cnoc_main SLAVE_PCIE_0 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "pcie-mem",
+					     "cpu-pcie";
+
+			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
+				    <0x100 &apps_smmu 0x1401 0x1>;
+
+			resets = <&gcc GCC_PCIE_0_BCR>;
+			reset-names = "pci";
+
+			power-domains = <&gcc GCC_PCIE_0_GDSC>;
+
+			operating-points-v2 = <&pcie0_opp_table>;
+
+			status = "disabled";
+
+			pcie0_opp_table: opp-table {
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
+				/* GEN 2 x2 */
+				opp-10000000 {
+					opp-hz = /bits/ 64 <10000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1000000 1>;
+				};
+
+				/* GEN 3 x1 */
+				opp-8000000 {
+					opp-hz = /bits/ 64 <8000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <984500 1>;
+				};
+
+				/* GEN 3 x2 */
+				opp-16000000 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <1969000 1>;
+				};
+
+			};
+
+			pcieport0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+				phys = <&pcie0_phy>;
+			};
+		};
+
+		pcie0_phy: phy@1c06000 {
+			compatible = "qcom,sm8750-qmp-gen3x2-pcie-phy";
+			reg = <0 0x01c06000 0 0x2000>;
+
+			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&tcsrcc TCSR_PCIE_0_CLKREF_EN>,
+				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>,
+				 <&gcc GCC_PCIE_0_PIPE_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "rchng",
+				      "pipe";
+
+			assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
+			assigned-clock-rates = <100000000>;
+
+			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+			reset-names = "phy";
+
+			power-domains = <&gcc GCC_PCIE_0_PHY_GDSC>;
+
+			#clock-cells = <0>;
+			clock-output-names = "pcie0_pipe_clk";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		ufs_mem_phy: phy@1d80000 {
 			compatible = "qcom,sm8750-qmp-ufs-phy";
 			reg = <0x0 0x01d80000 0x0 0x2000>;

-- 
2.34.1


