Return-Path: <linux-kernel+bounces-743977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5995DB10673
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971BA189F71F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772E0279323;
	Thu, 24 Jul 2025 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BIucVM/k"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53B2D3752
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349370; cv=none; b=T4bT5aHOhBBMuyjO04vm8bd8llKykBAPHZC3KECd8y0PzxzcUnngvz+AbgU5DUl97KelouYu8Y4MPwnZGNuuudUBUkhf7szmRWbzQi8N6/t2Doqu4bckd4Fe2iLPsFAbLCDSC/3YRbIVpIyDZZa1GbAMSP00cjfXVxDoAIhzNCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349370; c=relaxed/simple;
	bh=ftsZHYmSTdNDK1xhNA6An+wsxiIuArfv5EbhQ/0rruY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7YG9RLeg/FobnvYJ9iBZzvdHYTDx0ALsbPGCnB33X4Ksoua5TuKemU8KFNJEDK93saIYE/HmVbfWRE4RcSinz09psFk6GYa1LGd+70VAl9o2IayeUa+2uJKRC5j6uWDKpTWuuu4HtxuZZNQNDbMi+ud0wWmpPInMoiU2Kh7Ckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BIucVM/k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXNpg022024
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VvkVBusXf/9P1C7z7mb5VbEpYZmMjVfPSXxMRPvLOH4=; b=BIucVM/kUQWEii66
	xqWW/TORZA7g4z1+XKY+bg8t7JUMxSGU+lNQhJL6o6PecB6iFs6QupNmAK7L/3lm
	uINr3ZOqwUXT/w+++Ic+MsPhz08/IHrMlAeLZm4486nf6RmQaLTpfhiQJ43HlQjC
	NpN+OZmVK1dRLUEp2il3Hc2vhrjw7LB0qFmw9zX7WgN1zeH3G7h1+s3VZEm6DBFM
	MLgbsWkfXT84re59R2/uH925FHNgiYiIuE44b+ifG2wmaG0EwMWTaTEIU+iTRp5N
	X6Guw/N7KZs7pGjX//0Qeq3VctmJHGzR9bz9SVQAftWHSfnH/d9btlFuJ+YE52/M
	XTHRuQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dr04y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:29:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2355651d204so8168825ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349366; x=1753954166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvkVBusXf/9P1C7z7mb5VbEpYZmMjVfPSXxMRPvLOH4=;
        b=Lqrgy8gbCpFKcK414EaqYEn9s+Ll5/EUy83M5yR8MTkj6rCiuOge9pBgu12pgZAYgv
         EdjIlwKA/LAv9ExbvnxTZNwcP9huN9nOcdNxlV562ufZg/nvN4rmSN4ONHHAZq2zdUXz
         HqPYqt52PnCnAv/ar9SNfqZktJovdXolFKCFgAKsY5Gl4DsL9jCpMpziw5JYSMFGE2eT
         IArPDI1dILwh3N1wwUH9lzGNazmV8NIP7sAvJg+15ttPHUZtuKoM2GuLUca5B0PFv8cN
         FqXaglNifWpMYDjRQnYoFEoXoHZxFYtnkUt+QZc2pFiyyDsPRazX9j6CcJiTG94z8oJQ
         V7uA==
X-Forwarded-Encrypted: i=1; AJvYcCXuvzzIl/af26KyLOT5T0KDYQQ3EahfB1K1MQq8iG5/4vQcM2nCTlVZCaqWN0N6aQ22X2DAc9Qcms3hJyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYbuuDjJRngcr/2bcUVogsoz32edzVM8IEkpcXnZ6F4STDK2RK
	ymEce3pwQAk3mqptih0XHTn1VmNyElYbMG+/N7r1KjBb4kwW/dE3FyBHfLypgB6jJp9PFNZ1R/W
	iIzK+0ILoiSLDHP5m82R4dboNChbaXugAhJMfYNmAtWDUmJev5/lmCqrpr1GBOshCO1I=
X-Gm-Gg: ASbGncttuPL9pXulukMRHiU4sEJvD8ckGqeF5Z9w1ZHEZ+FgA8f0IxXgcibtMvGhAA8
	JtD0VyPitE/h1ByS90tqPuJ47PkNZQQ8kpA1vYDkZJAofmsNsUDgnIamud7CdtU/T13A9hPd2Hi
	7Xj7kEG60FdzzpxaS01IH8tS1Mc36xVvvDJ6gF5cnBvVZbEqDttnC6w8Lc2EPKnjSq9yMFZ7lnx
	Apww7olLujLKnnkatbbB09a+cf28qNu/E79OIXBsl3XqX093UHbHSDK7vaYJQAXle/8kcNRVuKt
	6xcEAzq/rF3WP6VrhrTrp6yOvG1f0ysNtcdR9C2daVd/Ey8/jf4SrXynpk1TNybU
X-Received: by 2002:a17:903:1b68:b0:234:a44c:18d with SMTP id d9443c01a7336-23f98152403mr103406615ad.22.1753349366474;
        Thu, 24 Jul 2025 02:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESV1RftWuUfUb7+nHHJvX8znKt+IEEEX2BUkusf0xIjZFIwajv/dH7ner8urS8MeOxKxAZjA==
X-Received: by 2002:a17:903:1b68:b0:234:a44c:18d with SMTP id d9443c01a7336-23f98152403mr103406105ad.22.1753349365935;
        Thu, 24 Jul 2025 02:29:25 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f8a0sm11276505ad.24.2025.07.24.02.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 02:29:25 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 14:59:10 +0530
Subject: [PATCH v2 2/7] dt-bindings: clock: qcom: Document the Glymur TCSR
 Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-glymur_clock_controllers-v2-2-ab95c07002b4@oss.qualcomm.com>
References: <20250724-glymur_clock_controllers-v2-0-ab95c07002b4@oss.qualcomm.com>
In-Reply-To: <20250724-glymur_clock_controllers-v2-0-ab95c07002b4@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=6881fcf7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=NoBSHRPQAjGLFGKXj-wA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: aWEJjWl97rtnCAd1rBsG1aDylDJfdO4E
X-Proofpoint-ORIG-GUID: aWEJjWl97rtnCAd1rBsG1aDylDJfdO4E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3MCBTYWx0ZWRfX4uOHMVL1y7Do
 p+9/76lxl/Sz477SciBAuDn3DoaJXmi+KEkZpMSl9oSEG9ZoRzTu6ciqNsZgWpe+BmkefVp+mge
 n1w4eDnx/4JewVlw17A00VFdJmXOToBHeHsD7Rx4GBpqPLejWCugcoLs3PmKk6DP0cPRIYLAiRg
 /b+bMYIpAlkFGtQx2R37RoH1KcZLoDbVzq9Hrm4Z4NR0rG1/HnBercGJxpw92fF/VkJ1RsAU364
 sadQW1oz1ohNtV1E/mT+7fHEobL0VhqKj9yGO1fBWZRJU3SExWPsUg5lHQWm8+PHFywpZczEFOa
 WHl3Te6Py5HtEmV6PrPRTBBhWszJV1gZWtyq9/FioM/9iWeyPWwAABz+/ThZnRFF1G5Ayp3ek/u
 7J9Psl8vAKAISz9bsYxZcFBoSnzg7lI5YrvF1jo/A8B0CMtrYf8pE4F8UP8/ReR1x2r3mD0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240070

Add documentation to support the Glymur Clock Controller, which is
necessary to provide a complete description of the clock control module.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |  3 +++
 include/dt-bindings/clock/qcom,glymur-tcsr.h       | 24 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
index 2ed7d59722fc7e1e8ccc3adbef16e26fc44bf156..2c992b3437f29b38d9c73e3c600f2c55e0b8ae98 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
@@ -8,12 +8,14 @@ title: Qualcomm TCSR Clock Controller on SM8550
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
+  - Taniya Das <taniya.das@oss.qualcomm.com>
 
 description: |
   Qualcomm TCSR clock control module provides the clocks, resets and
   power domains on SM8550
 
   See also:
+  - include/dt-bindings/clock/qcom,glymur-tcsr.h
   - include/dt-bindings/clock/qcom,sm8550-tcsr.h
   - include/dt-bindings/clock/qcom,sm8650-tcsr.h
   - include/dt-bindings/clock/qcom,sm8750-tcsr.h
@@ -22,6 +24,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,glymur-tcsr
           - qcom,milos-tcsr
           - qcom,sar2130p-tcsr
           - qcom,sm8550-tcsr
diff --git a/include/dt-bindings/clock/qcom,glymur-tcsr.h b/include/dt-bindings/clock/qcom,glymur-tcsr.h
new file mode 100644
index 0000000000000000000000000000000000000000..cba5e545a751816fc92d25abb4e61f1b8f4aae7a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,glymur-tcsr.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025, Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_TCSR_CC_GLYMUR_H
+#define _DT_BINDINGS_CLK_QCOM_TCSR_CC_GLYMUR_H
+
+/* TCSR_CC clocks */
+#define TCSR_EDP_CLKREF_EN					0
+#define TCSR_PCIE_1_CLKREF_EN					1
+#define TCSR_PCIE_2_CLKREF_EN					2
+#define TCSR_PCIE_3_CLKREF_EN					3
+#define TCSR_PCIE_4_CLKREF_EN					4
+#define TCSR_USB2_1_CLKREF_EN					5
+#define TCSR_USB2_2_CLKREF_EN					6
+#define TCSR_USB2_3_CLKREF_EN					7
+#define TCSR_USB2_4_CLKREF_EN					8
+#define TCSR_USB3_0_CLKREF_EN					9
+#define TCSR_USB3_1_CLKREF_EN					10
+#define TCSR_USB4_1_CLKREF_EN					11
+#define TCSR_USB4_2_CLKREF_EN					12
+
+#endif

-- 
2.34.1


