Return-Path: <linux-kernel+bounces-763913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D6FB21B82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7904F4E13B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4413A27932B;
	Tue, 12 Aug 2025 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MBDFxaVb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C73248F47
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968599; cv=none; b=RNq39/N23zcJFE/UK3N2h4teKIjMz1TNKg9C6rfGjyMLdt0jPYPaleTEVbluni3WXAY/a6SJIBbpSotIYDifDJF5l/26JRhF99VJkOAfQ5XdsxuoSzKv2lPilg4GnDZQCwhJqYg3CFB7zTvsvu3Ctftd4zPAqIKyC15OYkbBlhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968599; c=relaxed/simple;
	bh=skyJQGwtjusd2fTyqK4jZTr1TkF8k+4YfPyQ2SN6Icg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gBI2XTbA3FlTVxgw2Vdip4IZW8iarp2yq1RtdUD1efoCtWNws0tPO6TDWe7SDfol7uhBpaassuFqhN1QDQmQE0oF3tegHWPu8kxQg0SykX7Evx16pGZrCI4qFbRhe4ZG2WqxPKeDZCR235EsjBx5/j2+wma/PTOz7iM7idT1hfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MBDFxaVb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BJNS9o004991
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GaQleQ/0rrosjfb5eT4ezc
	NW4HeipC8aVP0mq7Y4vTg=; b=MBDFxaVbYOYRauagAVm3o0hlUDWxRl4+qPT7yM
	dpJuXgD/tvyabIT9sCmw7oCiUa8nY2vR9k84SUu8XDpq9YFJ6290O5GvX74nwmzL
	t1ccJVeQKSGm4ISoDC+AopmOGBeLCXP0abSWk+kIZZZmgWmNnBJ6xdzm5aTjTCvD
	UYpdw5TaEDbv7j009yQ/WnrVi+bNm7tk6wKgNyu4NIn3h/UI+IdMorM1I7ydkyUI
	0ELCaFDodPgrcMZ95qHNHciKnbpshdLeZ3sGaupktmqaIfPTTrl+HHFuSML9gY6k
	+TCcpGB7TLellTwegQDXHy3pV6YxkFEUbDxUrzXOfUoSTDEQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6jeg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:16:37 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-741ab0f2e82so799658a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754968596; x=1755573396;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaQleQ/0rrosjfb5eT4ezcNW4HeipC8aVP0mq7Y4vTg=;
        b=mWhdfPg0FULLQfaBNXg2LHYQrNeIw5glV0sxUJOPaaG2CPhWMN4CeMwnQhXgEFWp8d
         BOChdnWY/ynJEIj/0kTScCfu73swreFvAmAE3/3AtZabI4rgv26OEhDkm6P8cJ9D9QrI
         tUqE8s3cOIbi4lXdU+UlvEbhLQlIPqJCKI1/1uEIeZFnDZ3om11iKkS0R+YKpjPxjjJo
         3EaMm2FNtVSw51FYf8zDLqjicKyXz7LaodVwIl3mc3N0EbmIdzcdSTY7Zcv0IJjqYdKW
         gPkHSbSkbUlKB0hCxw9RCtuiKXRnQH4ggMFEHW4v/diH9V0IeEaF1bMsteH5BzSYXUqU
         QU1A==
X-Forwarded-Encrypted: i=1; AJvYcCVKP6KUbMoguO3WiaRJg/caBQTzg3QGMOnxTYrzzUOd9TdUET66sd+LlfX/Dlu1cSubjhkV38iyV3srR6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIUz7iehDXbIipg56L9+q98H9j0yV6mhObRdL2XC0PEdso+p3x
	ulydJFJMsHFMSfWQTrHEbf/Oyzz9OFZHOLpw2BTk9Xct2QUT83j+xEqdEXp0p1DJ2/MYosjEa7f
	lNXfBUa0MCySChRtHjblUJOIS/b950IqwiwVPHiVrlhaz6ZscBngJMNYB3zCP7C/0jlA=
X-Gm-Gg: ASbGnctQLYPNHfZHRlckxAmVyOkQTniuZqap/NKmL2cMlxIvsmTTIgsMCQpambAfkd8
	XML1ORRwVh7byHPu1E6jreXtu6du74DJ3obbG84ff9MYEY1oDJvt0ylL3udnrOPeLBi2zaO70PZ
	Cwp+DL8mQFg6YEXAGMcHhmvD6GWahDE3S2cWv2moUg73r7rLWJV72kz3Y4vn6OAqvYPD5Wc7DWc
	oDTKndYs8SkmOeRbK+7K7wqVX8/YP3kd0oi0fjHJA7CcK2KHdNU+XlEbLmKdFkAi0+0Oim8AGbp
	l2A8aa3WAcijQTaEUhIawmftjTu0nPcqHkERnBx51Mr0pK5DrsQVzbg5PuY9ztirH8G4fyCVzNt
	GojwsjU/NF5dcyu3PC2Wq6Yg56bIxx+Liu159JSg=
X-Received: by 2002:a05:6830:f83:b0:731:e808:be5f with SMTP id 46e09a7af769-74366d42fccmr1737419a34.28.1754968596039;
        Mon, 11 Aug 2025 20:16:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBUd+3O9UKn6bkdVs8e2VoBB59jxJamZEy/9WNxBHWOenHV77k0glG9E2TLdjfYhHXksaD6A==
X-Received: by 2002:a05:6830:f83:b0:731:e808:be5f with SMTP id 46e09a7af769-74366d42fccmr1737404a34.28.1754968595655;
        Mon, 11 Aug 2025 20:16:35 -0700 (PDT)
Received: from [192.168.86.68] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61b7c8905e1sm1251129eaf.9.2025.08.11.20.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 20:16:35 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 22:16:29 -0500
Subject: [PATCH] arm64: dts: qcom: sc7280: Describe the first PCIe
 controller and PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-sc7280-pcie0-v1-1-6093e5b208f9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAyymmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0ND3eJkcyMLA92C5MxUA11DM2MjY/MkU8OkxDQloJaCotS0zAqwcdG
 xtbUAC4GePl4AAAA=
X-Change-ID: 20250811-sc7280-pcie0-163237b51baf
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4939;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=skyJQGwtjusd2fTyqK4jZTr1TkF8k+4YfPyQ2SN6Icg=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBomrISIZSeuj4FYKAuRReAwOUK3oe0oyISoHypu
 A76YnT8bcyJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaJqyEhUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcXGjhAAgnvRW0Kfci0GhBs/HKWfGL9HrK9Sa1BXInP3qi/
 dNbJfSzGQxtTAYz7UCPa7QMpIh9UhaVVRLC/QXTJz0TOvHCRbObnQmhcFi++uefNBAfA2OyryDw
 /e8U+X8+u3wc+98fcDzkxiDit+Ew7cRj/AbTI8AqoD+dxHWTrpY6mweMzoCtcS1W0jw7lEhvU6Y
 IDBc41MOLsL0XpMCWfHm3sAAoP1gmQ508Ns4Qy8TR2FbOTPnBnPyylPTSUwr0iBSNSDbLezKqkF
 9AG2/b3jnDvM2gyQJA9cUS9ySGNDJrJBczzTrN2Mxkp/MNC4bFP6+C8sLbIq8trXMHjWP06Yecr
 KEwgwzcPEZJ74QEsIhxd1UylRpl8xTrJNnNfO7xDRtci2A18UHVBr1Qe+KIAZX9Puqv378Op7P7
 K82XLGjp4A9iCpC5wKSOZwkFO3YGuPsdrUFornQfD4rMbfgJJ2dqS/6DJHDrNyj7ozRVz9DEKA0
 Jpfa0G5jTgGbSg14XCWRZHpqNTDy2ayIBzj5vmzIw3jyHpt+I+Kyn8DHYt/+eteaWg5AFPAD7f5
 zthottp3mug0XunYZv1TLxkjjyJ8p1EATNxdqrAqXdW75lCGO9JtyQqOj1eBSjrL1wshWWCjLOu
 GJhWSffjVjdxQODhZv91+VUBT4KLLkLFpDQOy6ZL3D1M=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfXwHbP+DFhu+du
 rEkyQfkPr8rEH/BOwKJtf3dZs2Yki4ZJCOh+i3fPzbbKYcgAfl60A7sg+wZr+cR2pFdo0QHfZso
 fxojjPC4lOTwPJAQvmfpc4lconP3Kn20ohEXOuTqgL5pcyWNbg1+5HV843P7qJPjRODpis2z8/x
 e5yGNtiZKOJa2P38WzlzliH5HuzTvdsG/J2v/2CGU3Yr8yneG+zyCPqtNML/EI+X+JLOI5nFkuW
 ggvhm1GUZZ17j+UK1bqTfyiiooUkhkZXwmVFPOzkX86SK/9GTXbi1CwJ38t2DqH98UbL7zgLJHQ
 5kyyZ8YwmJ+qaWcThImBu8cYU425rrgca/RdUVWv8ztXXvjwvfzbo+6K2aRzAo6PxGip+S4t3bW
 MFSWUoEp
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689ab215 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=SrWXOAHHq75Mue0GltgA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-GUID: EXwrCpqfB1fLlNnytfpJoOCVdqUxLUdo
X-Proofpoint-ORIG-GUID: EXwrCpqfB1fLlNnytfpJoOCVdqUxLUdo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

Only one PCIe controller has been described so far, but the SC7280 has
two controllers/phys. Describe the second one as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 134 +++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 64a2abd3010018e94eb50c534a509d6b4cf2473b..e44678b27226b8a911d8d2afa39092aa33396bec 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2200,6 +2200,135 @@ wifi: wifi@17a10040 {
 			qcom,smem-state-names = "wlan-smp2p-out";
 		};
 
+		pcie0: pcie@1c00000 {
+			compatible = "qcom,pcie-sc7280";
+			reg = <0 0x01c00000 0 0x3000>,
+			      <0 0x60000000 0 0xf1d>,
+			      <0 0x60000f20 0 0xa8>,
+			      <0 0x60001000 0 0x1000>,
+			      <0 0x60100000 0 0x100000>,
+			      <0 0x01c03000 0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
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
+			iommu-map = <0x0   &apps_smmu 0x1c00 0x1>,
+				    <0x100 &apps_smmu 0x1c01 0x1>;
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
+			pinctrl-0 = <&pcie0_clkreq_n>;
+			dma-coherent;
+
+			status = "disabled";
+
+			pcie0_port: pcie@0 {
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
+			compatible = "qcom,sm8250-qmp-gen3x1-pcie-phy";
+			reg = <0 0x01c06000 0 0x1000>;
+
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
@@ -5285,6 +5414,11 @@ mi2s1_ws: mi2s1-ws-state {
 				function = "mi2s1_ws";
 			};
 
+			pcie0_clkreq_n: pcie0-clkreq-n-state {
+				pins = "gpio88";
+				function = "pcie0_clkreqn";
+			};
+
 			pcie1_clkreq_n: pcie1-clkreq-n-state {
 				pins = "gpio79";
 				function = "pcie1_clkreqn";

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250811-sc7280-pcie0-163237b51baf

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>


