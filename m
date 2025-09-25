Return-Path: <linux-kernel+bounces-831503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C45B9CD83
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE477B2C50
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447ED1C861E;
	Thu, 25 Sep 2025 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GzFpf0jp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096618C933
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758759461; cv=none; b=BwIs+cFfUKrbe7hnmbmbyiMM1XGfD5SFicogQmlIUoP0UCo73c8yFtV86ty8zNj/8+eMcjo9JwyIBPAC0P5gLoNIyD/NIa6XeRK/Xn55mm7lA8ibMIp8U679rBkzke9V5unFozZTOnqSbwfdjslk3wOknpNEibJganBzCR/ZmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758759461; c=relaxed/simple;
	bh=btLUTtNG5JoWnxwDPIqHxdM2OEdUq/v1ScItSjsqG9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dC3izppUpzeaBmsXeX+shJJPffmyxipFf2cInxGbGWZ2JA2XtPzHdOGGCnZhQaG/KZzIyfMfRjIZEk176qBokz0YQqoO45MgDKG5Kra9d2vH/cN5+qNfxK13eHVbrdm7KYK5Y8q/pTx6JKP5wSeUPfsOMn8eG/u43+lGW9yvbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GzFpf0jp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONZYSI027782
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vRuCq7CdXqaEeJXm40QabyRKEPowjtauBb1dauAj29g=; b=GzFpf0jpGpRuEqpu
	2kZsLL5o7q0sI7TOAtxujrZxhgBRLSlgzWuAYR8hxXQmxtQhwRmQFvQFt/T+BCyq
	cnVsyL2HwaNqLGbBXV6dv0TVu2sLBXTx7eMTba3/u5bKWC8Y04FLBSpbWLVnjiJL
	BsDGOAui2O8bT1D4/NPTLlW5BOsnDT0OpIUOwYDlaeu17iSP0CJDxM+0Zdp/EAuH
	rhMb1U+u9FxRgc7JQJnXUcQHgjW7uRm8Zy+OD/1+aJaQLqk0aCs2rib79EwAzfYj
	6DA4sxmY2wWinbUWFoi+1TK4ribt8naVbMVOKco0jvoy8XHDU/LThKC9ePgIo5MW
	DT41vQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnxg8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810289cd5eso225236b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758759457; x=1759364257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRuCq7CdXqaEeJXm40QabyRKEPowjtauBb1dauAj29g=;
        b=tPIxpKZwh8nQNqBQWwIkY9t5lSalV62k7lCHpiHNxntUHmgQi4/KYCy9lrYS54thpx
         cuvTTBCScd1nXTCuOv5YcSNtLDLAaLlxDkDJNhsxrBoW2kccAG4LY2ljdw8kd34r19tD
         s4pxDIsPJT4/ClQ1uMNm86iQBuernw+ELYsm0kicUSvNqyXU7waNx2B6CPb20TPvmlJQ
         /P6xqLm0OmrDVMds7M8mII1RKtrPFeS8mHrQ8nWJVdq7AB/itz4rouOzl8vPc0BdxqyA
         FRedwF65X4ywtp6RlWfMTwHERvJTMC4++lDYC29K4AmGQTBE7ednxG7HZdY3m2gD8AaV
         yCcw==
X-Forwarded-Encrypted: i=1; AJvYcCUrhZPZYSS/IVErMU21GZveFAR0ky6pTfnHCjTYpXSVnw0npfnPD26vqPoeCE5BzoMx9Vk9vOzie+bXrTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwgXlmxgtHO7fbWddntPRA2OH3yzjOZpMix+qffqpKU7GlUMO
	e/yqf7r4+ij4kTRYXOVyAgUqSwDSlbpB/kZjCGSN8ymIk8RUolgQGSorLlK3Sa1Ddo/W8D7B4nJ
	XzVXr/OrWwmprr8gXxIBshqU5nmUzEWDPRDyE6Css0wVqzeP+Tg9RZaLzaOol5tpYsKk=
X-Gm-Gg: ASbGnctkQPFItmNmkp6TT22DTHQQKP8GTe9WIE8UfP0oE8sOAzaaCHpw+Jt4IphuL2F
	tbbonEQ2Cb/+ZmrzCjvK7xYKJ3bI4kwbI4qCUZ7qbUYaK4uyQcecMgv2Tgn1XCvXubpFFkYrB+U
	1ntdN10HVgI1AW9reSzO6A2YJvDEBDHWAzXNqKZEHtzVQIxI8Bx9co6O+oJxwx5bLdG2chPCAal
	rVpVOxh9bZqmlmOGw8nqVyptNEvsRSlFgUb4gAIhLn+I97WA9obKEnT4IvGs5ArlVEqxUa94LMu
	TV+70Xjn1XLnCebqmE4I/nxzYepPMKRAbyZAK4zBZLvEWGT85h7R4i1PPru3UdmDyI41PC4IZzv
	gKsJSJ9Y/imPwCEs=
X-Received: by 2002:a05:6a00:3d48:b0:780:fb24:e93d with SMTP id d2e1a72fcca58-780fcc82816mr1725800b3a.0.1758759457173;
        Wed, 24 Sep 2025 17:17:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9BrJiiix5rqTO2Ug1qclnDWToeSTBA29x3FvK/pXHK4VeLpOAgYcuJIt4G8xosrLa1nr40A==
X-Received: by 2002:a05:6a00:3d48:b0:780:fb24:e93d with SMTP id d2e1a72fcca58-780fcc82816mr1725773b3a.0.1758759456685;
        Wed, 24 Sep 2025 17:17:36 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238e6fasm262748b3a.1.2025.09.24.17.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:17:36 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 17:17:22 -0700
Subject: [PATCH 05/20] arm64: dts: qcom: kaanapali: Add SDC2 nodes for
 Kaanapali soc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-dts-v1-5-3fdbc4b9e1b1@oss.qualcomm.com>
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
        Manish Pandey <manish.pandey@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758759448; l=3406;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=4fVfjSvZcQS+KYeJCPCrX//HlUCKShoKtHj8bXIt8/Y=;
 b=NKNUkggaCyyf4BVa3kCocTCJVkjwc9ShvOu1RjkXvOX+lESG+4zWO+JSOczuhMZgxPJd9XyE+
 zo9Imp+mxgzAmPJupZ1Ovv0vrWemAMj6CygDgdWN3IfmtViHo1PdkR5
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d48a22 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gnUYCYxEF1sk4gvoTOwA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: TCGiLvG2yk3Yttr1nA8jhDPnqwHitliz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfXw69iS3kHW/01
 Q1bTMk3DAwSji8CrkX5ajvVVioV8h39IlRuplaqf2jx9PkZUIprwl4ujWG3E+7hPQrCbi+rfEcz
 q2fozsKkgq+D0BSv678sVY/dwC1OyqYCzXhh4XZDz3jxJGVvnyUudDt2mO2bpqP2Bsr/LCapOUL
 KoKnkTfRqq3GHvQ9MWKE9nxB1V4P6tSXShx8Mmk9gytGV+XOHUk7QLZI65dz2pYskcr6X5soWMe
 oMvuAPBffvEDqWdOiHUoYOohAs3VwUxEjYeGf2plvOrv2YjVfn3VriT4J6AMNX4hzlt/CWeWDIg
 XbiGcaZK7CV+nS3EQI4LhmZv5soNGGHgAYaogMX4baVG9BY6ZOfc0eqZxuKmXbeIClbwZ2FF6o+
 2mS/bAo5
X-Proofpoint-GUID: TCGiLvG2yk3Yttr1nA8jhDPnqwHitliz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

From: Manish Pandey <manish.pandey@oss.qualcomm.com>

Add SD Card host controller for kaanapali soc.

Signed-off-by: Manish Pandey <manish.pandey@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 104 ++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 07dc112065d1..ae1721cfbffc 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -908,6 +908,56 @@ lpass_ag_noc: interconnect@7f40000 {
 			#interconnect-cells = <2>;
 		};
 
+		sdhc_2: mmc@8804000 {
+			compatible = "qcom,kaanapali-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x08804000 0 0x1000>;
+
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "core", "xo";
+
+			interconnects = <&aggre_noc MASTER_SDCC_2 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_SDCC_2 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
+
+			power-domains = <&rpmhpd RPMHPD_CX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+
+			qcom,dll-config = <0x0007442c>;
+			qcom,ddr-config = <0x80040868>;
+
+			iommus = <&apps_smmu 0x540 0x0>;
+			dma-coherent;
+
+			resets = <&gcc GCC_SDCC2_BCR>;
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					opp-peak-kBps = <160000 100000>;
+					opp-avg-kBps = <50000 0>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					opp-peak-kBps = <200000 120000>;
+					opp-avg-kBps = <104000 0>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,kaanapali-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x10000>,
@@ -974,6 +1024,60 @@ qup_uart7_default: qup-uart7-state {
 				 drive-strength = <2>;
 				 bias-disable;
 			};
+
+			sdc2_default: sdc2-default-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				card-detect-pins {
+					pins = "gpio55";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			sdc2_sleep: sdc2-sleep-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				card-detect-pins {
+					pins = "gpio55";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
 		};
 
 		sram@14680000 {

-- 
2.25.1


