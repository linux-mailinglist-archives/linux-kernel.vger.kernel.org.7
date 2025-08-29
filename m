Return-Path: <linux-kernel+bounces-791560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D041BB3B87C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC1217A6BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4665230AAA9;
	Fri, 29 Aug 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XB80ctCD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666530AD1E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462537; cv=none; b=saf1ho23xY/zxs/xybFiicTWw8V5qPDUjB+ooxo7hK5K8UuH1I6r6aios4raCxUEmR6QCXn4cxQ6UuZro7B6jt06v7oULn5Npk0WXcvda/9S7bTI54AJD2YVr/R1ecPW3DwwSX7W4rf3jJ1yceUdp91Bey4bExW4il0XtQ+0lSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462537; c=relaxed/simple;
	bh=e3gKlIgcNEy2r9Mx1i7bMF3/Ao/g9nApBx5pbLsL/sA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zzid8EvfF6L7JGFaKvxIU6rLS+PWfZCTMBNMekgnfTHuysBAUWKl8oJmWxrZZ8JqJkzzX2YeEyuszejI+PGYicFa5FiveT16LuyvLULR3/NelKdko39h3rAv/YkldCg5//49OjtLzqDon1ESnAOMwZc5aHEkwxClpTI1aSyxwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XB80ctCD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85MR7008810
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	spEKHx63+sJKj605M8Bf9cWcS/D+6tO2xX01XfJCvsc=; b=XB80ctCDZ/V39jPL
	2fIQJVIBWU15W4dToNmy77O87oVfb9XXISvxOWSyXJ85KvKGJjn06SWJe4gh/YHq
	k/a+dMYKUXPYogkE+H5cxjwCjVJwD4be/o7uW7qfQ5o8+J0wjcPM+aG6QrjwoVCj
	xPl8aBpKp1Dwk5p9gws22KbwVCo0mRPbJs6u/rvyIRoz1qoacFTnTrPZ297rGeWC
	y2/GuJrflthzEpuojCVG7Imlcqc1WJirW/rGhJPWRDyh6K55T+NF0iO6zTXmNnWE
	3CS3A7aej3ChsxHjqoCfSxcMaKwQBc3ZFeibBF1ZLV4XMTH5diRYVE0LXDKslahm
	eY7n+g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5up3e08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:15:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-248f7745075so19518065ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756462533; x=1757067333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spEKHx63+sJKj605M8Bf9cWcS/D+6tO2xX01XfJCvsc=;
        b=ae3fVB3mnXarFWmtM97Os6fcXUrMIINbg+OTffQDcJ5xHag83OHjaV95AnYRUErA8k
         QN1iqmPW0sctV7ONWk5NmaN22E9BHHPERUkzWuf1yegDnCAPqgxiOPB0OF4ypyKzI8SD
         AoPEBlaqAR5Wkt9XGBXaf0O+aYWvc/KoIe210CfPHEKQ5KkIP8d4IvuhRq5nWHTwP6A6
         YKYPzqAxo+X/VxjKZ0cNjkxHSVEf4WHDiC2tcGns5i5vNS4XuKdgAk4PZCCP8cVp6cL6
         Gqrh0eJVQQC+fsxZhovBTqiJUGvWCoHGFsOqV+8YS6/WwSCxbn4f1DcNLP6gDiHNErMS
         qtgw==
X-Forwarded-Encrypted: i=1; AJvYcCUS9p36oqG0NUej2ta74kzXOMoxhAKyj671YYb5/R/jcwV9gpouWHOwfWEcAKl9v4ezZTrJOxPI0uAyjaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5hiDUleSxeiX0+7nqFo0+g5JF3xOB+MaHDyJl8lD+xFKsY4/L
	JFA9h91gnrxSIRQ1dxrBesPZ9Bqi/kUzloCeR4yuJJclMHCAxJrErKkf0xvCSZ3pt0IMBNYQT2G
	qYIO12cTzRtXUPsv4Jk5vZC14HFjNu4h9r8u2XVd+6+3HT1sP4834JdaBxzMmKRnz1o5CdA4GVk
	0=
X-Gm-Gg: ASbGncvm4/R+e2PIEKgLQmnHKRe3/E2HA4reU9rty2A2zz0IQViEN30UYZN+8DjoY4l
	5vtvpO3jOMhkgeYPITyvFdzbFrSnoqjY/ODBKQmVqvZIDH4dOy2IFsrg0VwYv1+hUaiLijpryEn
	x7WpZkwb9onyA9o4+/fxodYojhN3n7tjgAySPxpAGAnPISl5y1xJtzsWg5NxJorBeJqyDxIyF8O
	obIqP6Pqa2VuNssDwgpSLCN15rWRWllQX1Kzy/7elO4fi2HZJyEfR2y/WTeOmjQHTTU0jsb6o9t
	Va6HHJ1rzWhqESOq15vlYSJCAGxwKrAq6oRNmvuNGwAvpH0SNoPpiAbA/q3QcYCV
X-Received: by 2002:a17:902:c952:b0:245:f7f3:6759 with SMTP id d9443c01a7336-2462ef1571cmr350083295ad.50.1756462532955;
        Fri, 29 Aug 2025 03:15:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA8Xh2vbyvcy6mdjaLep3b6m9rvTPrB3vfrqANTg067b9b8/FGFP60iDb4AjB5RBjfuPIKWA==
X-Received: by 2002:a17:902:c952:b0:245:f7f3:6759 with SMTP id d9443c01a7336-2462ef1571cmr350082855ad.50.1756462532408;
        Fri, 29 Aug 2025 03:15:32 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065d1b19sm20102775ad.131.2025.08.29.03.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 03:15:32 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Fri, 29 Aug 2025 15:45:18 +0530
Subject: [PATCH v2 2/3] dt-bindings: clock: qcom: Add SM8750 video clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-sm8750-videocc-v2-v2-2-4517a5300e41@oss.qualcomm.com>
References: <20250829-sm8750-videocc-v2-v2-0-4517a5300e41@oss.qualcomm.com>
In-Reply-To: <20250829-sm8750-videocc-v2-v2-0-4517a5300e41@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: URL_9Xfck9APajMk5ElejNKkTFkA9Oci
X-Proofpoint-ORIG-GUID: URL_9Xfck9APajMk5ElejNKkTFkA9Oci
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68b17dc6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=1oqufa9daVNmb7UKLHcA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfXzPf+vEAofnvl
 jlJzu7bNqZJ4NVo1SqeOEMfFA6j2azuwx8ZEtdLDvuRFvJjz0HlPh3+r7hjlattOODN6Wg77hRG
 kcLyPS8NJA76VmasZ/fUH463q3dsu00cfyC9Vv1oVM6zG3PcyjJ2rPBzBF+EKcEfmkz9bmmsrxm
 4kunVIj4elCbTZBBGs63m2jbVdUY5mTp1oUJBhgqe4dXauVhRP37S5hNEdgF7F/XK1bUfKgzV2C
 ZHj2eFbAbv6NJMcqHfNfsUd7S2ALoiBYWS9R/zQnCdJ6vr0sCXbnfuAPHAlWfIiyJSFpdcJ3nIK
 Pq5E6rHK4ZzgDZDtQIrfdeSqigJpKfHQmgMVFkAkhMlHIepUV/2LGk/HGJ9MqVf+ZEOUyIcb9II
 LzqdP9fj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

Add compatible string for SM8750 video clock controller and the bindings
for SM8750 Qualcomm SoC.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/clock/qcom,sm8450-videocc.yaml        |  5 ++-
 include/dt-bindings/clock/qcom,sm8750-videocc.h    | 40 ++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
index fcd2727dae46711650fc8fe71221a06630040026..b31bd833552937fa896f69966cfe5c79d9cfdd21 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Video Clock & Reset Controller on SM8450
 
 maintainers:
-  - Taniya Das <quic_tdas@quicinc.com>
+  - Taniya Das <taniya.das@oss.qualcomm.com>
   - Jagadeesh Kona <quic_jkona@quicinc.com>
 
 description: |
@@ -17,6 +17,7 @@ description: |
   See also:
     include/dt-bindings/clock/qcom,sm8450-videocc.h
     include/dt-bindings/clock/qcom,sm8650-videocc.h
+    include/dt-bindings/clock/qcom,sm8750-videocc.h
 
 properties:
   compatible:
@@ -25,6 +26,7 @@ properties:
       - qcom,sm8475-videocc
       - qcom,sm8550-videocc
       - qcom,sm8650-videocc
+      - qcom,sm8750-videocc
       - qcom,x1e80100-videocc
 
   clocks:
@@ -61,6 +63,7 @@ allOf:
             enum:
               - qcom,sm8450-videocc
               - qcom,sm8550-videocc
+              - qcom,sm8750-videocc
     then:
       required:
         - required-opps
diff --git a/include/dt-bindings/clock/qcom,sm8750-videocc.h b/include/dt-bindings/clock/qcom,sm8750-videocc.h
new file mode 100644
index 0000000000000000000000000000000000000000..f3bfa2ba51607d0133efcdad9c7729eb7a49b177
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8750-videocc.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8750_H
+#define _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8750_H
+
+/* VIDEO_CC clocks */
+#define VIDEO_CC_AHB_CLK					0
+#define VIDEO_CC_AHB_CLK_SRC					1
+#define VIDEO_CC_MVS0_CLK					2
+#define VIDEO_CC_MVS0_CLK_SRC					3
+#define VIDEO_CC_MVS0_DIV_CLK_SRC				4
+#define VIDEO_CC_MVS0_FREERUN_CLK				5
+#define VIDEO_CC_MVS0_SHIFT_CLK					6
+#define VIDEO_CC_MVS0C_CLK					7
+#define VIDEO_CC_MVS0C_DIV2_DIV_CLK_SRC				8
+#define VIDEO_CC_MVS0C_FREERUN_CLK				9
+#define VIDEO_CC_MVS0C_SHIFT_CLK				10
+#define VIDEO_CC_PLL0						11
+#define VIDEO_CC_SLEEP_CLK					12
+#define VIDEO_CC_SLEEP_CLK_SRC					13
+#define VIDEO_CC_XO_CLK						14
+#define VIDEO_CC_XO_CLK_SRC					15
+
+/* VIDEO_CC power domains */
+#define VIDEO_CC_MVS0_GDSC					0
+#define VIDEO_CC_MVS0C_GDSC					1
+
+/* VIDEO_CC resets */
+#define VIDEO_CC_INTERFACE_BCR					0
+#define VIDEO_CC_MVS0_BCR					1
+#define VIDEO_CC_MVS0C_CLK_ARES					2
+#define VIDEO_CC_MVS0C_BCR					3
+#define VIDEO_CC_MVS0_FREERUN_CLK_ARES				4
+#define VIDEO_CC_MVS0C_FREERUN_CLK_ARES				5
+#define VIDEO_CC_XO_CLK_ARES					6
+
+#endif

-- 
2.34.1


