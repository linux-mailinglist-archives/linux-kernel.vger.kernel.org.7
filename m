Return-Path: <linux-kernel+bounces-831826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 469FBB9DA2F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2A91658CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203C92F1FC8;
	Thu, 25 Sep 2025 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HDZJ2Jnq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F322F28E6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781810; cv=none; b=HY8w5kUurfC4ujzdG43nWagwQXaoPdVn65nEx9l4kFC1TrxyH/6DDSIsJMMciHNT/7jEucFe6v/Q41ZHc5a0VdROer68bt632VQno27pqTWYaNK+IN6V2UPSIFjIJaE7vw5HsKPL6Qglt8/vkLCyqpja3I0ix7UR+12fakFCMN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781810; c=relaxed/simple;
	bh=xP3mwQRtUF+y7ngL4/MSOznuYxF3R1hx7J2yaHJ2mqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U9T+Nqb6RSsfkM1W06wvwxDjXcnvBqpP+k8E12Ti38t+h4p0cGjA5FinZQCTlVJb6v4B/siBbn74GsjGtazVPMmUw9B7X0R/YcUEwgA3lbaev9AZbISO8/IOCH+4AXQh3t4SBU231/g4oDZMh7EiZJ7n4tNoGkTymAPMBn4+28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HDZJ2Jnq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0VesL025075
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y+ym1GIkn6KQx+5G33RyPIpJNvqhHUVvcETu0uk7voE=; b=HDZJ2Jnq9rdYeDI5
	x7ay+diwF7nARlZCaiM4Ai4C69TlOUP1UkWZnsC8rdYASMOJWpTRvJ9c5VZBhVQ2
	8H8sbCvfs7AGC2su4G14YoNtpli465qcs1eeoYyG50+URGGl0t3hdanwK9sZWe9d
	lkl3pM8NOhRIKnWPgXCc+SvL1sSTpmIytIBk/EGV8WsuxGJANoMsG4SJ+r6igDcB
	O7tKjma1VyYMaXc/Vu+wfMJP8ZgOGJPDWmkxSBSsRnrPO0e3EtX04xQpNkDVFrFo
	HHqPLePnOezuJ+ZVc4NlMRnG1+cSUX9z01qv15XKMb8J7z8XRVx8vcz754m385nj
	LBKgrg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyeybhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:30:08 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f3998c607so1049643b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781807; x=1759386607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+ym1GIkn6KQx+5G33RyPIpJNvqhHUVvcETu0uk7voE=;
        b=GUI5zfKvoTmYZxYYcZlFkm7jb2tP5SqvAwOr8L8bDj7YEAJSnas2FshHR2xJLfzewa
         pkO4WfJvM+pjlyoiGelWIXDCIupvyzGtdizpv2ZicoZi6mzghTLfbEuK6lbNjlPFxY/d
         N20AG4XVP0MPlVYPKFuCsGnpiJ0I8z2NuDsfciim8ZGoatXwk73BmMr1m8CW7NaGmenW
         oQXCrs+Ed3/jRGEyIxcfntir/0+D67vcsUffsPwgGEreX3v3eZtQZsL49CipSlydQK2p
         l7HifkbG0oxRbDxp5EG1ZC8NawFaGfgfHxLlweJrWJj0ynXG8tqT6a+xK4+2AMnjMVLg
         O3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXK+OlF7YRvCjyUnw32s4oPIBP4Jk4cHEZUJ/wCikXwhOSOdLToqNdh9MZihEjRed4AIxP5alYSgLkCTTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypl2xdaMJBja4bSAZoPrsocACag38Gar0Qid/LJB1E69NSX4Mf
	GdmQoAiniqyEQ9eze/Rc6DE5yyB7+Y33aUNIejCc4rNZdPNQ75UQIzJgMWi3niE/o2QwoXnIVr3
	KGTGQGB3QWEZ597+tuXv7nAl/BEtXJllePcA7W+oM5XZNYuB/EY65wrcSniWqLHH8BDA=
X-Gm-Gg: ASbGncsrotJh3pHbCU019CZA2GEeXoC1ywM32foq5d3mlERcUXwscOrIhNK9t1uGwvi
	XYFWxUwxQaZbPYizoBwlbmgoiuhhccDBdnSVoBc0BQEQFvV8OGNIvbIMu6/KnEqTAp5oEurc9N+
	gcGRMWykbyladnRyeIMzLnASSrbsC+RIm7ye0dToGlIOoSMoBcfxqJsHSXtmxkVEPkl37RF4l/l
	aYQLC0yR5raicUOBFpFSngg2Zb3NocxvwrUV3jF8uj0+NNs9BhS814ODWWi1nFZneGUQtjkfHt5
	coAHZdngNxXmfYfcylZsV3/nxL+RDOxlozZ9P7hQ6+Sf3OSWyWTA/N0ZfczdnY3i/Yb6W0hOC6K
	wbpZNLAQcz5XMyLkkexLZVje7no5vli04N+428EcnQ+lzbr3ZprX9s0KmAdK2
X-Received: by 2002:a05:6a00:b85:b0:772:40ba:61c0 with SMTP id d2e1a72fcca58-780fcdfd87bmr2805509b3a.5.1758781807227;
        Wed, 24 Sep 2025 23:30:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDyMWV3c4xqIYvQqjTD4r7ImNPNGXQgJ/3o978WKGnQC+yTOlVKlfvpDwMiMVxe5P+cZz10A==
X-Received: by 2002:a05:6a00:b85:b0:772:40ba:61c0 with SMTP id d2e1a72fcca58-780fcdfd87bmr2805486b3a.5.1758781806801;
        Wed, 24 Sep 2025 23:30:06 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:30:06 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:28 +0530
Subject: [PATCH v2 22/24] arm64: dts: qcom: glymur: Add display clock
 controller device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-22-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: vLZkTCEJNOMfyxi76qqDAAlYouwCHWkk
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d4e170 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=xJZpmU4_KKqDGsKAShUA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX9bWNrmiWZUUr
 rzufuZ/qGjct3KiaU0rfnL0OeJllaCmOREPrXLgwEaPdXLrPrvNMpm4Jnp+pI5lr1uBBzNL1FCg
 R8cD6i9d68PxBRaJhvRVT69lnIIjmwZKlwC+e+nBN7c0V1DXU/OdGvwcNCBzjUtVgCWwl5COveD
 3cG1sGDfYnXDZ0ShYr794A6P5sU6YHruKBdkBTOnv9LSQ+2BEhVgMwbeWH3kxwvKJ7CFZ2FKMt7
 rKBuIChzQlhoXfNLcZ7UgUMJm51fv8Ps7G6Qefi2Mb2NpeLm5I/RbFqzJaGxKWAtVJ/MX8Qanjg
 8LghPWmPSu9DRyW1PINC6rtB+HaYWApyOgy41ftZ5aNmBhRpZ/hK0b8K5fC/jTHKZhhnM8gMGps
 j6u5RMdc
X-Proofpoint-ORIG-GUID: vLZkTCEJNOMfyxi76qqDAAlYouwCHWkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

From: Taniya Das <taniya.das@oss.qualcomm.com>

Support the display clock controller for GLYMUR SoC.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 986dc385200029071136068ab79ff8dd66d5284a..8a563d55bdd4902222039946dd75eaf4d3a4895b 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <dt-bindings/clock/qcom,glymur-dispcc.h>
 #include <dt-bindings/clock/qcom,glymur-gcc.h>
 #include <dt-bindings/clock/qcom,glymur-tcsr.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
@@ -13,6 +14,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/spmi/spmi.h>
@@ -2775,6 +2777,34 @@ lpass_ag_noc: interconnect@7e40000 {
 			#interconnect-cells = <2>;
 		};
 
+		dispcc: clock-controller@af00000 {
+			compatible = "qcom,glymur-dispcc";
+			reg = <0 0x0af00000 0 0x20000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&sleep_clk>,
+				 <0>, /* dp0 */
+				 <0>,
+				 <0>, /* dp1 */
+				 <0>,
+				 <0>, /* dp2 */
+				 <0>,
+				 <0>, /* dp3 */
+				 <0>,
+				 <0>, /* dsi0 */
+				 <0>,
+				 <0>, /* dsi1 */
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
+			required-opps = <&rpmhpd_opp_turbo>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,glymur-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x10000>;

-- 
2.34.1


