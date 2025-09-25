Return-Path: <linux-kernel+bounces-831838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE09B9DABF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BEF3AE4F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05D02EA16C;
	Thu, 25 Sep 2025 06:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CP5MHwAs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC882EC096
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782026; cv=none; b=IcfnNe+wol8omqyOlbIsPlvFfgyOC823YXesCxXeTTGrzoOE02bVxXTmOyOqU3PT5QON4QYwdDM1WfaDXMFduZw0Vkd06WatMAq+Z/ys99vIGN9Vc1A3DOTr08YhyWQr1B+UD89jXhwIUmk0YsWSI2e3APPtZRAi6QOOZkwG7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782026; c=relaxed/simple;
	bh=fElO3EF9R19NDeX+BG2YF39Vf8D4oJXDjBMGCwiMl4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aYw7vk3L/KMPbrXu1HSIapQlIkWkTGX49P4VMF5+lrHAL73DuhLdkrb5CKwgc+7+p10FCyqtVZT1FyTk1FL9xwge0OnnGGVgeCLsE8gWeGcgGIGoZV038S8FFij0RsqouhvBLxrsUUb/Av+WO2zlvVfnBW2p6aIo/hRKt9p4PDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CP5MHwAs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONhlbt025089
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3WpjX+QZdNG8Jvf4TjOewFLRT3V458PXcjB0O7zeIxY=; b=CP5MHwAs+Khkwx0Q
	cexV0XhC+MbenEekz++KjV2yYi8RB5ZE4vf8zJjbn9ZexVQw1qHs5AuNroM0DeUx
	d3BNuXum+TUoh7pDJt1NwIs8LgByDsqNvS5TUxn7yxSRlvCcnL8U/YeoYl/Nwpxj
	DpdkYGiEoRLPGf5cVU9by04qnJhkdYuGqYuDGsARCyoVjRU4awIsuBq1KRSvpDxC
	L7PSDHQXZxF/lhKjwRsuNvRPAdSKGvYZB5w4mCGV0EPp9AnaZJU0250C0OZ4cAox
	qINTEPEYGaC8y3yQUYpQv7SRtMsacb69Tb+qReZpUc5q1qE3R3ogM8QP3bQdoVSK
	8V5+CQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyeyby0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-272ed8c106eso4390705ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782023; x=1759386823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WpjX+QZdNG8Jvf4TjOewFLRT3V458PXcjB0O7zeIxY=;
        b=oHVfZlWSVu85kHYHWQiFiF+tSuEz5KmiKZCowwU/fkPhZ4l+paYPtJUi3y6ZiZXiAr
         t7zoOdmiwd/k0zjS+OhhQZABLQ0/iM75Onf3tod4eTU5CixrHzrP4/cbS+LVRZKBbVJH
         yg1c9SgbewwhoqglpSokL/KHHozV5eIw15+zmb1a04oDHNpU8zXMYDHrcE83Rn4tdRes
         gWbxHU4VdaAh07wZEpM52VRfUqKnTEWkJX7ShLBkCCHz/KxlSj212nLCjzp/jQPPIiSo
         pg28BKNwJ2fWQy9qp85QIgP+NcDru+cCy2IiTdRfmYxvWhoJXQB/HY0oh+IaUq9eE+iJ
         5/tg==
X-Forwarded-Encrypted: i=1; AJvYcCWb67hSST/PeeSAEfDPF9pl5A0GhUmp2JfvHbv8IQ9KlmVvf1fZJgR0EDbSb9T9fvIq57j9tAg1agqCxac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNHxe7NsjnLtYwwS3wD4F0gciV/WxnaC3nW4x3Hn/ZcIOwrFmi
	dvv0xpC9Hj/wXowoZXx/D2Fvsgssz5V2L2RRZpIa81QiGeSIkqGU/AOWw8KcN6Db7dEHeLIYbKm
	sNY+0h/a0av5iAHgCQTQFdDouuEBF6NaRQ6NpwBXMKLoavp6u3dg7llKoxvL8KSjQ7WA=
X-Gm-Gg: ASbGnctS4e18/dBJqT8+v2hoAv+eYBXUXmhtnEQgIiMna3c1eO4Forc9acoa07heIng
	PPfaTt2qG9lOSoW9r+iGoh66Yb5jFEV4XARgZhW7T8ZwnbMx07biDG2N3jxsWcmPgwVqAE9gpN2
	jwAOgdN5bffvc36lyCHp0mMu//bPJLEKnUfEOnpbzd+g3/cd3SIobUnlq7jDUr2lDIWJJqXoR+C
	5IkGe1p2b0qewaXFVdTub9yepp/iwLI63PbWyHH3olH+Ac9aqqjgShPcC3Jk/TdYLs4JR6OEdt+
	31Q6fdDObpSKj6bl/GP0AVivnPaMldqbp6nBEnBbQAETRAS6yTjQlGK5vDEsPQoxHQIMSWU8Coe
	Pv8oArUTchvySfSIosyVo+sylmo2VjPfV5br7SUckK2wCYVuAaA1J8bKyzFK7
X-Received: by 2002:a17:903:3847:b0:269:a75f:e9d5 with SMTP id d9443c01a7336-27ed4a96168mr32119025ad.42.1758782023124;
        Wed, 24 Sep 2025 23:33:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/rLnV166PB2nfOvkNzUURdaTx9x00dPd2J0KV43WuHEDm+FLOXC1UQ3gr41Q1F+zAb6X4nw==
X-Received: by 2002:a17:903:3847:b0:269:a75f:e9d5 with SMTP id d9443c01a7336-27ed4a96168mr32118715ad.42.1758782022658;
        Wed, 24 Sep 2025 23:33:42 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:33:42 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:15 +0530
Subject: [PATCH 07/24] arm64: dts: qcom: glymur: Enable cpu dvfs for CPU
 scaling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-7-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Taniya Das <taniya.das@qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: kCD-VFAQAgQej4RYr_6t9o0KlGqpKnrN
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d4e248 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gdhpWjMKO13w-baniFsA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX+IkA3xXTT2Km
 U+HjgOo1gMhGv58OYAg75xk8p+ns41I+fX21OVQc2OVh1/8+/4gs5vO51Y94259i3a4k4YqrVQJ
 +K62bVp7wggyuq3I6SRqpqwRMEw4kPcvAtVQ0EhWHRoD+xT6bjInIvqqRABCt39rwA48UZvyQWi
 fq8l7hl3Gx05M6i0SdTTRK2r0XvUw569Ugi9asuC5lmIxd0qzWqLtY95e4z6JWKXepMKjsvt/40
 r6Qi1Cx4zqF7YbF8sDSvApSfUwWG5YGpVQZPdVZYc34rC/PU0e7/Merr9nz7HgTLHqycWQjZYYI
 qF9RV4R/f7xSMaPpJ2lhVNG47g/nSYdoMm7lu1lNMOrrdlT5sOl6t3BuSuYgRcs+0gQVJGpso+O
 EG0kg3d1
X-Proofpoint-ORIG-GUID: kCD-VFAQAgQej4RYr_6t9o0KlGqpKnrN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

From: Taniya Das <taniya.das@oss.qualcomm.com>

Add sram and scmi nodes required to have a functional cpu dvfs
on Glymur SoCs.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 87 +++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index ae013c64e096b7c90c0aa4cfc50f078a85518acb..d924b4778fd37af8fe7b0bceca466dee73269481 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -46,8 +46,8 @@ cpu0: cpu0@0 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD0>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD0>, <&scmi_perf 0>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER0_C4>;
 			next-level-cache = <&l2_0>;
 
@@ -63,8 +63,8 @@ cpu1: cpu1@100 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD1>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD1>, <&scmi_perf 0>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER0_C4>;
 			next-level-cache = <&l2_0>;
 		};
@@ -74,8 +74,8 @@ cpu2: cpu2@200 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD2>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD2>, <&scmi_perf 0>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER0_C4>;
 			next-level-cache = <&l2_0>;
 		};
@@ -85,8 +85,8 @@ cpu3: cpu3@300 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD3>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD3>, <&scmi_perf 0>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER0_C4>;
 			next-level-cache = <&l2_0>;
 		};
@@ -96,8 +96,8 @@ cpu4: cpu4@400 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD4>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD4>, <&scmi_perf 0>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER0_C4>;
 			next-level-cache = <&l2_0>;
 		};
@@ -107,8 +107,8 @@ cpu5: cpu5@500 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD5>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD5>, <&scmi_perf 0>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER0_C4>;
 			next-level-cache = <&l2_0>;
 		};
@@ -118,8 +118,8 @@ cpu6: cpu6@10000 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10000>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD6>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD6>, <&scmi_perf 1>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER1_C4>;
 			next-level-cache = <&l2_1>;
 
@@ -135,8 +135,8 @@ cpu7: cpu7@10100 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10100>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD7>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD7>, <&scmi_perf 1>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER1_C4>;
 			next-level-cache = <&l2_1>;
 		};
@@ -146,8 +146,8 @@ cpu8: cpu8@10200 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10200>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD8>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD8>, <&scmi_perf 1>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER1_C4>;
 			next-level-cache = <&l2_1>;
 		};
@@ -157,8 +157,8 @@ cpu9: cpu9@10300 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10300>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD9>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD9>, <&scmi_perf 1>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER1_C4>;
 			next-level-cache = <&l2_1>;
 		};
@@ -168,8 +168,8 @@ cpu10: cpu10@10400 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10400>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD10>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD10>, <&scmi_perf 1>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER1_C4>;
 			next-level-cache = <&l2_1>;
 		};
@@ -179,8 +179,8 @@ cpu11: cpu11@10500 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x10500>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD11>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD11>, <&scmi_perf 1>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER1_C4>;
 			next-level-cache = <&l2_1>;
 		};
@@ -190,8 +190,8 @@ cpu12: cpu12@20000 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20000>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD12>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD12>, <&scmi_perf 2>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER2_C4>;
 			next-level-cache = <&l2_2>;
 
@@ -207,8 +207,8 @@ cpu13: cpu13@20100 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20100>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD13>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD13>, <&scmi_perf 2>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER2_C4>;
 			next-level-cache = <&l2_2>;
 		};
@@ -218,8 +218,8 @@ cpu14: cpu14@20200 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20200>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD14>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD14>, <&scmi_perf 2>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER2_C4>;
 			next-level-cache = <&l2_2>;
 		};
@@ -229,8 +229,8 @@ cpu15: cpu15@20300 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20300>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD15>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD15>, <&scmi_perf 2>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER2_C4>;
 			next-level-cache = <&l2_2>;
 		};
@@ -240,8 +240,8 @@ cpu16: cpu16@20400 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20400>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD16>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD16>, <&scmi_perf 2>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER2_C4>;
 			next-level-cache = <&l2_2>;
 		};
@@ -251,8 +251,8 @@ cpu17: cpu17@20500 {
 			compatible = "qcom,oryon";
 			reg = <0x0 0x20500>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD17>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD17>, <&scmi_perf 2>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER2_C4>;
 			next-level-cache = <&l2_2>;
 		};
@@ -397,6 +397,21 @@ scm: scm {
 			interconnects = <&aggre2_noc MASTER_CRYPTO QCOM_ICC_TAG_ALWAYS
 					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
+
+		scmi {
+			compatible = "arm,scmi";
+			mboxes = <&pdp0_mbox 0>, <&pdp0_mbox 1>;
+			mbox-names = "tx", "rx";
+			shmem = <&cpu_scp_lpri1>, <&cpu_scp_lpri0>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_perf: protocol@13 {
+				reg = <0x13>;
+				#power-domain-cells = <1>;
+			};
+		};
 	};
 
 	reserved-memory {

-- 
2.34.1


