Return-Path: <linux-kernel+bounces-789905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D5CB39C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F6C1C815F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C24F3101D0;
	Thu, 28 Aug 2025 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AwrcEOBW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A58A30FC18
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383022; cv=none; b=i9xqXYM6ppJXySL322xBvENf6nUIAZATiQkHUSpr9jE2pbcDx3XIiAPONuc2sot+DkeKKIzvcyT+9/o1J3G6AwZQcLoEjDWkoCrovHL9tegCiFXjrQF6VDZYG/5TYJZe71McjFJuQflyuz+/S2c6JD4aEWm7SMjdFK6LgJmEdEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383022; c=relaxed/simple;
	bh=n8CibSDGW6LOAsbVMBvzXuiN9JBP2yv07nnGPm97ghY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTPFKcsEBjhq/ECwLkP2eUZ/gqD0Rzj/o0wSaPhK0ihS0bRzpYQ5h/vUDIMZ87DwE1dJI4lXMMl0GYfiT5QNhiBFNVqpQNBpHFiABuRRny4SRteR0hMj3TbwlZra5NmK5YFTzTf4E/RvoDh8/EfZ+hj2+r8E3gU+mheiklQ5dpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AwrcEOBW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5UeYE031332
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QD2A9FXdBy8jgphnzP4Dp1Qnf+lFGk8RL2fW6YxOKeo=; b=AwrcEOBWI3psTFQH
	N34qF8P4UKb0GSAtBTOkzzoXlCkmIrfFRLCJ5+C5lOv6SLFRYkDZt0xy0E0lB7Xn
	fFRCZGO3/8B/509YpwWTesZTO3bE5Srt1Qc/jU+AZfJS8mYSLf+PQlE98/nLXfKA
	38fUi3AtnRXg14ZfGaY0dUyvjCvNNACRqYeK9jcg9x9MBoIdS6BTGtM8AgVsKasl
	rZyXrxFG9NKZNxJy+zalmDo11nJgHBenWLUrG90QJFXfXoByc6vlDJKtPdJ4j+Ok
	2ELVj972r3nzB+42H4BtLcgMjuyJdOFKpdaiq0nMoX8YjP+iEX+f3gwrh9OWV4dt
	1Jo0TQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615r1w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32771335ce6so930540a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383017; x=1756987817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QD2A9FXdBy8jgphnzP4Dp1Qnf+lFGk8RL2fW6YxOKeo=;
        b=wmRth8gTGeUjnHYK68gfOMSKIUNwvSqKBv75AcwXPHywOwfU2DaxfXFabzOhmC8Glx
         NBTfbVNrLxE78GzLaRqlQIXVq1m0PviZNMBgNHZCj6Ea3Y3Bh4Bsvmd4sTYjB1sEXlPz
         dQa2yxqwLUGbcQ+Utl8TILEsOUZG5dNIiMDtX73WYuCYwNf1oqOiwM7Fikk3YicfGC25
         cy5CTlr5cxiKYiQQyqhy75lN9VPlc14LdGCszw5lAzMjVXeRsIpk6z4nPcf5O3M1tKIe
         UVmbupt4iUenzWrKqINR/UOURhr2mbDeHzHqOlaMI0kehL2KMDPjYFk8TjxB9SztOnk3
         xK1g==
X-Forwarded-Encrypted: i=1; AJvYcCWXnOBNG5zpiJgAw0ZhU7+V6vCyCNEpaHA/LQpiTEodA48d8SLetn7B3M8ommWwhtwylhlL2ngLbRhSQz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkigYtBykReKy/RVWCgNckZ4KmHYcNwz1ndn+l+w/CmwEHawDV
	hiZ6ssRbYNwwfshllGQf+bqZkNCEos0iaBaGQWRyhlgDDqjeg/A2hGbs75k75CqSJcD3XT6A+zt
	WIfnhHVMzIXXEL019vWJYTgM5o/aHfL/SzqerZsYANnEtm4YccaUAiIZPFBmxPJJ9XiI=
X-Gm-Gg: ASbGncu98fPRlVAcvjSybL83XdGvbMf10GIJvuk6f6fjwALCNxTpWmApPWE+cGK4wiV
	g8pzfpXbLF+dr0J7fz5VatGWZq7NuhuZAbtP7wHXfCFF65/izTFO7cwRuPYeaqzu86/v4WBDgjL
	qDYwW2Y+WDqkjc44W2M3jtBBaFtPbeYAfR7mFar2Sh0dInHa2Lr2JEMpC5lfdg5iNKS2oGmrOQN
	lCzD+Pnte9rgV9k3+uZ1ya6ZYkIs73cAI9eVp+idsxqDRmcIrDFkovWE6iyZIum0uoUH52O5Gz2
	4vI+BIZY52wWjda2IWunucOppxlkmATijDNHBoeF5XH+KPAO0N1i+VjkDXJqB2ZAV462tVWBPvI
	=
X-Received: by 2002:a17:90b:2ec7:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-32517b2f78dmr28934723a91.26.1756383016789;
        Thu, 28 Aug 2025 05:10:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMU0B8A5NXSc4XW6YWiuMgcNVOratxHDn2mKFqdBmgUSXAIgy8tSO3FCpdWkWDpp9LMEmetw==
X-Received: by 2002:a17:90b:2ec7:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-32517b2f78dmr28934664a91.26.1756383016208;
        Thu, 28 Aug 2025 05:10:16 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32741503367sm4019070a91.0.2025.08.28.05.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:10:15 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 17:38:59 +0530
Subject: [PATCH v6 2/9] arm64: dts: qcom: qcs6490-rb3gen2: Add TC9563 PCIe
 switch node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-qps615_v4_1-v6-2-985f90a7dd03@oss.qualcomm.com>
References: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
In-Reply-To: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756382994; l=4925;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=n8CibSDGW6LOAsbVMBvzXuiN9JBP2yv07nnGPm97ghY=;
 b=U2c9vFnZy5/c1yfkChdy65ugAsH2zjxUx3I6kV/ChW2PovrY+W+IZJuZ4D10SvAyAPCjD5a60
 SELE5P96AiVB+6sziwPSWmlXNVny9jm3ltfp0jjoGFqBdZMPfU/eMzx
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX+1Unl21AvLq6
 4+Y9q5lvwSlukirD+aMVdpeCxD+ozdfZ3s1J46QZdcE9K/sN7Z0Y+1sKhS69hstTt7GJxKttowB
 /mpps1aYS/miNdJkAexIfXdXNSNEQbBb+2I1YAfNAD4fJOqFGareceGdjorwGDcypmsXF1xWF3c
 ChT9lyXFbLLqVQK28227dAMlMp4fO/zYuMRoJCPLW2vpI3qhccnJqsYkVyRmrtPamDI58M3kQ4c
 AN7LHnEqZljvWcK2wWXCFLiZVHKd/ciGM3nJECzCCvAaZlpaJ8R1Z6PoUTJ96LV7ag6Z3PMlbD6
 ETaz4obtepvTAqZLkOhV7CXG7bWWU3PDRTQM305LydUCX5AZotg9PUac016fnV4F9q9TqI5v4HE
 1ToUj0ua
X-Proofpoint-GUID: MtMda5CQmrq1l-XRugzyF1ccjUU8DlJW
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68b0472b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=UN7QK-OhvXrGNVVRcS8A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MtMda5CQmrq1l-XRugzyF1ccjUU8DlJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

Add a node for the TC9563 PCIe switch, which has three downstream ports.
Two embedded Ethernet devices are present on one of the downstream ports.
As all these ports are present in the node represent the downstream
ports and embedded endpoints.

Power to the TC9563 is supplied through two LDO regulators, controlled by
two GPIOs, which are added as fixed regulators. Configure the TC9563
through I2C.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 128 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
 2 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 5fbcd48f2e2d839835fa464a8d5682f00557f82e..1dc4b498d39565398f83f9bfecbde19e68a61030 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -261,6 +261,30 @@ vph_pwr: vph-pwr-regulator {
 		regulator-max-microvolt = <3700000>;
 	};
 
+	vdd_ntn_0p9: regulator-vdd-ntn-0p9 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_NTN_0P9";
+		gpio = <&pm8350c_gpios 2 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <899400>;
+		regulator-max-microvolt = <899400>;
+		enable-active-high;
+		pinctrl-0 = <&ntn_0p9_en>;
+		pinctrl-names = "default";
+		regulator-enable-ramp-delay = <4300>;
+	};
+
+	vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_NTN_1P8";
+		gpio = <&pm8350c_gpios 3 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		pinctrl-0 = <&ntn_1p8_en>;
+		pinctrl-names = "default";
+		regulator-enable-ramp-delay = <10000>;
+	};
+
 	wcn6750-pmu {
 		compatible = "qcom,wcn6750-pmu";
 		pinctrl-0 = <&bt_en>;
@@ -834,6 +858,78 @@ &pcie1_phy {
 	status = "okay";
 };
 
+&pcie1_port0 {
+	pcie@0,0 {
+		compatible = "pci1179,0623";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		device_type = "pci";
+		ranges;
+		bus-range = <0x2 0xff>;
+
+		vddc-supply = <&vdd_ntn_0p9>;
+		vdd18-supply = <&vdd_ntn_1p8>;
+		vdd09-supply = <&vdd_ntn_0p9>;
+		vddio1-supply = <&vdd_ntn_1p8>;
+		vddio2-supply = <&vdd_ntn_1p8>;
+		vddio18-supply = <&vdd_ntn_1p8>;
+
+		i2c-parent = <&i2c0 0x77>;
+
+		reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&tc9563_rsex_n>;
+		pinctrl-names = "default";
+
+		pcie@1,0 {
+			reg = <0x20800 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			device_type = "pci";
+			ranges;
+			bus-range = <0x3 0xff>;
+		};
+
+		pcie@2,0 {
+			reg = <0x21000 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			device_type = "pci";
+			ranges;
+			bus-range = <0x4 0xff>;
+		};
+
+		pcie@3,0 {
+			reg = <0x21800 0x0 0x0 0x0 0x0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges;
+			bus-range = <0x5 0xff>;
+
+			pci@0,0 {
+				reg = <0x50000 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				ranges;
+			};
+
+			pci@0,1 {
+				reg = <0x50100 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				ranges;
+			};
+		};
+	};
+};
+
 &pm7325_gpios {
 	kypd_vol_up_n: kypd-vol-up-n-state {
 		pins = "gpio6";
@@ -1039,6 +1135,38 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&pm8350c_gpios {
+	ntn_0p9_en: ntn-0p9-en-state {
+		pins = "gpio2";
+		function = "normal";
+
+		bias-disable;
+		input-disable;
+		output-enable;
+		power-source = <0>;
+	};
+
+	ntn_1p8_en: ntn-1p8-en-state {
+		pins = "gpio3";
+		function = "normal";
+
+		bias-disable;
+		input-disable;
+		output-enable;
+		power-source = <0>;
+	};
+
+	tc9563_rsex_n: tc9563-resx-state {
+		pins = "gpio1";
+		function = "normal";
+
+		bias-disable;
+		input-disable;
+		output-enable;
+		power-source = <0>;
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <32 2>, /* ADSP */
 			       <48 4>; /* NFC */
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 64a2abd3010018e94eb50c534a509d6b4cf2473b..7a840c90505e83b3c233ab13c53be818824c9b8d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2294,7 +2294,7 @@ pcie1: pcie@1c08000 {
 
 			status = "disabled";
 
-			pcie@0 {
+			pcie1_port0: pcie@0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.34.1


