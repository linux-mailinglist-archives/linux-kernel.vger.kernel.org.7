Return-Path: <linux-kernel+bounces-831842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35721B9DAE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E78242066E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1AC2F1FCF;
	Thu, 25 Sep 2025 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OjjOL4I1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446CA2F067D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782039; cv=none; b=d3la3DcYFUVdAAay068KGdbB8lxLMqA5IWSWd7ZRpNSKGXSehIIBf+Q69DlmZI4IC/xB1hiFCBP2yg4cV563Wi/WNp+AomFwH0Jymego+dmuhVuRkZc/SpHcAAtRjQxiRmXQ4FJZ5CbqXvJmTAiqT7aYoJyRSQgumiSPI4mgURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782039; c=relaxed/simple;
	bh=yDgdM8Of2hyqaQlw4iDJh/MVPzu7jFD1m4YshkXg0a4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j3XJIRv2nnMcHkL1rnDN+pJJW3XT/Ox5zHdRAPPmbhR1JoIxfAHiLrMFFTtYzD8IIry/NWy3PGS5Twk2lXOhch5M9MDJSi2Hg+hjtR8FnGeyalFvmuFZUhVYGCjAYEmSCRullFKjXw24Tm9snEzsEIsIgTljzIXO+4ItuWEekQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OjjOL4I1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P16KiP025283
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pRUMfA49GMLn5RJ9Yoh5tMe7BcGYfvc9dHpNmBw4CMI=; b=OjjOL4I1y41jrzd5
	N+zp3P1gu3UMov8jjHxHqT9pGcWLlskQvbkUNdVMJzOvSDtwwilmS00SRyBjakeB
	OajgcwqpLKKN7Rxghdq12srKCkpMdjX8o5g7kFf8EMzBwbQ9Z3APsiX49djRE0Yp
	0p3t69RFxpxdFuOkPH212dctkG2XomimVAW6aiFyda0HBZovEBHvcVixbcRGF79u
	kubqXo0vyQ65601COQ8f5IZS754Gn1omU4zELhZvvEjlxwofXmh9VJT2btKAT6ZC
	e+RVnejL/iH++5r8o2tkyyJI7yw8XaBI8zgMjZMKMNh+Ec86XpPF6CIUT7eOTVHK
	XikcIQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyeybyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-277f0ea6ee6so7266215ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782036; x=1759386836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRUMfA49GMLn5RJ9Yoh5tMe7BcGYfvc9dHpNmBw4CMI=;
        b=iVJyPPrP8h2pR8A+/2ScdP+NHLSZnMYGONadYCBicMM3iqFXXiAGuxESgQDqxid+H7
         H3eUJMzclr3Sv0/zpDlwwpNfGpgGEJumd1Ta1U2hnP4wXW3E6X1m44SZix2pVqo0BrC8
         a1HsvqvYJ2gz4jKhlgYQOIzkxnKRajMvwpPmgxgntwbuowHzXnIBrTaG+WRVed4LXyJa
         Y1SgQamT8nZOCjkAjNdmj58DqntwQ2sWmQMh4VanIf2/FJ0JT2C2+wwk/gkU4C1AX1SM
         01v+ZCTg3K2uTB4SPcB5/28TRmHkjGldN/EmwxHv4rhuJBvQevnVO0+Osf1nuJfnrrQK
         8nIw==
X-Forwarded-Encrypted: i=1; AJvYcCWEQZyIMvCjEvlAHutKhVGEf7IePnvJ2p1Zy7Aivl1+cI1d8fzE0qW6H47XuH85ECVKesR//Sd0PCDUJgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYp/7gaQvYwD74MtaKI8mScAca2pVWMpAtYoqoxVO7dKQr4nOw
	W6IaXQAHzGn356deRPdHuEVCHpOI8rcmSIoENkB4NGONsGlklL0i/CtMta+NJlqaenVh7D5Up/c
	FHs/LSZciYuhCTGGHhVX2l9TgJ2wzazIicxhRIawEHCfP2jM0j1q1YDtZWUNfTEUoJiQ=
X-Gm-Gg: ASbGncszqnhOAODs0c13OM+XxBtbQ+b0Dl5f+8PYTZOAQqBtjxswnIgdROPFsk3mmET
	0hPz/xvG/O2Q9i5z6NhkyPuzNu1/+mmK1M1yqrzRhq24uuzLOGy+wxoNWODe0HTiBBI3YjChOIP
	1IImz9XzMnVsKSHyBJh0enTGHvBuEvZlk3UKhl34ghOFijxlwg1k8/INLX9HNw55m6eFh7rnLjc
	JfVq4MHy5gavCZBCL64cc4HVJYD4WiCsMBENvPhNLCDkzsqjz74AiEVRdihp6dUbCTCQC6h1Znz
	AY4P4DHtPA8dsLOUXeOK/rQPuYY7gqGE2Zbdi6BfrqwwgtMyxXNntEZ5Dd3qz6T7uHj+rmpg7xN
	2c6S8RaOoIfeLCggPGCYqj7+Qn3Xk31BZzVNRytL0nNiLJCDM5Xd1O6bRf/ul
X-Received: by 2002:a17:903:ac4:b0:25c:76f1:b024 with SMTP id d9443c01a7336-27ed4a0e498mr28589655ad.25.1758782035690;
        Wed, 24 Sep 2025 23:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2LvbtRU1TM+vT096Iuf+SpAzs8/uamGMv8ofQmta/LcDScBT6DUZzfTUwhbJe4wRHBkRkSw==
X-Received: by 2002:a17:903:ac4:b0:25c:76f1:b024 with SMTP id d9443c01a7336-27ed4a0e498mr28589325ad.25.1758782035198;
        Wed, 24 Sep 2025 23:33:55 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:33:54 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:19 +0530
Subject: [PATCH 11/24] arm64: dts: qcom: Add PMCX0102 pmic dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-11-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: k3RCbya14YDZTCityWfYBsFOEUsPNOoZ
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d4e254 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=u-g3E67TlB3pepnp-YkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX6cNrRghioLo9
 hIdSQX6TUFJx6HZ5xZwYORhfKrZ9SMObCOEtZUqIql7IevE/Hnu81GFE9jRDikSBPUFzFeOHT7D
 0a+ve6VrBKDzGM68D9pgAeVmYI8edI3kq0PaInnhKgBz6PASx/4XfimIfcn7/ijMS4Sfdu8vH4D
 oqzRn644mMMCLORFuFoc+Bwtg53LH/8nRD4glh3ka+Rd6a0UNwynK7QoWaCofq/4lCXXNN80U0J
 ske9ygAO75q4t20oRlRIrQEEb9DbisHFwW2X3LBik2X12wcFtr1tqn+D8zXg864Jx8PUisCcgw1
 szdjrgc4hCCGKK+JG7hWX/9CO0Xm3fa6RsUV1EF2Sw8D4xhD+qtXSIjANp4pg7jwsrIvCsu3goe
 FJjvWFHp
X-Proofpoint-ORIG-GUID: k3RCbya14YDZTCityWfYBsFOEUsPNOoZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Add base DTS file for PMCX0102 along with temp-alarm and GPIO
nodes.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/pmcx0102.dtsi | 179 +++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmcx0102.dtsi b/arch/arm64/boot/dts/qcom/pmcx0102.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..839738dda6cd5016df134a2fddd92d3ae7c56133
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmcx0102.dtsi
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus0 {
+	pmcx0102_c_e0: pmic@2 {
+		compatible = "qcom,pmcx0102", "qcom,spmi-pmic";
+		reg = <0x2 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmcx0102_c_e0_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmcx0102_c_e0_gpios: gpio@8800 {
+			compatible = "qcom,pmcx0102-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmcx0102_c_e0_gpios 0 0 14>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmcx0102_d_e0: pmic@3 {
+		compatible = "qcom,pmcx0102", "qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmcx0102_d_e0_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x3 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmcx0102_d_e0_gpios: gpio@8800 {
+			compatible = "qcom,pmcx0102-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmcx0102_d_e0_gpios 0 0 14>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmcx0102_e_e0: pmic@4 {
+		compatible = "qcom,pmcx0102", "qcom,spmi-pmic";
+		reg = <0x4 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmcx0102_e_e0_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x4 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmcx0102_e_e0_gpios: gpio@8800 {
+			compatible = "qcom,pmcx0102-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmcx0102_e_e0_gpios 0 0 14>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmcx0102_g_e0: pmic@5 {
+		compatible = "qcom,pmcx0102", "qcom,spmi-pmic";
+		reg = <0x6 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmcx0102_g_e0_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x6 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmcx0102_g_e0_gpios: gpio@8800 {
+			compatible = "qcom,pmcx0102-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmcx0102_g_e0_gpios 0 0 14>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
+
+&spmi_bus1 {
+	pmcx0102_c_e1: pmic@2 {
+		compatible = "qcom,pmcx0102", "qcom,spmi-pmic";
+		reg = <0x2 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmcx0102_c_e1_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmcx0102_c_e1_gpios: gpio@8800 {
+			compatible = "qcom,pmcx0102-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmcx0102_c_e1_gpios 0 0 14>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmcx0102_d_e1: pmic@3 {
+		compatible = "qcom,pmcx0102", "qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmcx0102_d_e1_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x3 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmcx0102_d_e1_gpios: gpio@8800 {
+			compatible = "qcom,pmcx0102-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmcx0102_d_e1_gpios 0 0 14>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmcx0102_e_e1: pmic@4 {
+		compatible = "qcom,pmcx0102", "qcom,spmi-pmic";
+		reg = <0x4 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmcx0102_e_e1_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x4 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmcx0102_e_e1_gpios: gpio@8800 {
+			compatible = "qcom,pmcx0102-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmcx0102_e_e0_gpios 0 0 14>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};

-- 
2.34.1


