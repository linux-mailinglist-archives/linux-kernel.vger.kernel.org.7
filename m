Return-Path: <linux-kernel+bounces-800134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95582B433D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF9D3AB92C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC60D29BD81;
	Thu,  4 Sep 2025 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jhLEI/44"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FCC29BD9A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970640; cv=none; b=o2U2xeRhRmCA2rjDnpDrtb6D/moR9j8Ve2ZgXTle5Z3EtTaaVM/yhq7euL54PNuIHH3jH0rvIPfoUHQBhG9+zz9Zvdem/Za9cKqLp5oXoh8MkKyJJ9GQW1ylrSazUQQR7jJ7wrCjh/8Y6nnJ/l8pC8kyvQVSqXUaqmO27eOXwRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970640; c=relaxed/simple;
	bh=+O3JVszsjnLSrzFlB2OH9FsEdDEqIq5Fgx/8nAIsEh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kjCog3/dyyNySryFUAghUu1x4oa9YBn5lVsS9//hp/dXmrWg5HBInDX84QqhPoreeqAbQAUWIXlO95j62MMXX6UXJnW2szjcHNBlxZpPj+MGOeeubHM8+ZIMElQGu18izDW3ZHQaFVewCjjj1uiqYcO/EEfk6YVS9N2nI1QIvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jhLEI/44; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5840YXF9005254
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 07:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IU5cufGmzzYIjzid/BiRcbiln05RcV2CZkR0KkZBDZM=; b=jhLEI/449Th/2S0b
	yB8jz/PzwDHvlUpWEAPaa/Jk5QypLvBhbqDWuh5OtQYE0kCukp2ceCjYn4OF1iHZ
	vOzdV7M1Qat7F78FCVN5VOGpFtWwh36/BKtdNAoM//LhEtwLA59dz+c9PIrF0tc0
	5Zzs1vGtoO5qe/9S9fInBMq8zIxKSVc/VLA16XEnr+h7U++k7q1Vjg/ajm8pqGZA
	8gLhdvK/COpiqzYObN8UUC0N10sc4C4ff0ve19l24Q4+2s8wIRSxiUVBPQRY5U1F
	DAsSAvcsldRx/kFAnxNk18dPluyPWOYxKNTLnv8P3pBCSsHBaxeBCd3+jcJERSCV
	j+XUog==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjpj2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:23:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4fc06ba4c1so352330a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756970636; x=1757575436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IU5cufGmzzYIjzid/BiRcbiln05RcV2CZkR0KkZBDZM=;
        b=LETlHQbzhgwrFjRHlU7vqzrhJvw2l8VwIAOOrCDSx4qz7h9Yvj/lw/F+hLhW0gQDKJ
         bjznNggYM9lAIpO1ug7CX91E6STpOnLOuIjkAIs7DbycafAJFnkdWwGOAzH9CGDK4edp
         hyMVBjqrxzqhJ/H49A+jS252G/uOP56LOlm723C69XjgindMd3FFTtgHWrVCv0k25Phl
         WtjHzvl3xSYEWu7d4sITWmaoNvt6JOuoJr1ovCI8bEg1zT0yp6ut3nTNO+ro35pBVvTX
         yaiPcAH2sms+nvyWgzVjSAKOIqMG2bDuxHdT1E+kTnUQYfWoeBsLWr/XoULyskaXEFFy
         93TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEdWxX9wnRpDaj2XLm0lWdAJztZe6Eeg+fOUkEclJVdmPUu9MHz2yT1xeCAzvl7gq3HBKBdGzF43DFFRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOLN8pObklbY2jvKubezl7zr7uHKZtCo8ScSuee99RHEnIPA72
	2AbMoE9TH85BZqFhv4Ox+9nzXmNfAY8Ts3V9s3AMp9z3NY44kLBrLiPuy2d3Ez6q60b8wDHm442
	cAPQULx6B8wjoL5isK9Y5iQOQWGn3JtBiyUeIVs+LFXTZKdkKKCWI8Ns7GXSFX/vfNKU=
X-Gm-Gg: ASbGncsGOTa5Bh/Pw88qvvU5dg5K/jj/viSZruJGuLCxejO1oiYHWce1Kjf9LiquVrL
	6D/CagLawh5c+DxG9bHZThWlsjsg+I435CB6mGA+4P4ILttTUzA0UXi4jl382zmdJqgR1OWi17X
	Drq61HD5Al60HUNWKa4kIvo8MBB3YdVc98vrntxQeBWjS/CRzC3LZ3l0HuwfXDCGp9v04WasiIs
	r/Yh5hKOALqoM51611Jaoq0L9DnvkYAXzZY6AgglfMjDG7MhtWH5NhIYrN4hHkGg6M2RC0l7YR8
	8YX1zdBNwv2HMme48Tuyu9oU9RbAhJvHEB/Y9CS4KgsJhxB/zQfVlcnSJmAcHyfKPt/P+N4=
X-Received: by 2002:a05:6300:218e:b0:243:aa4c:afd9 with SMTP id adf61e73a8af0-243d6f03239mr24769346637.35.1756970635750;
        Thu, 04 Sep 2025 00:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDePBQvO93ASzEYF1+34i/DP2V1A20QvNO3VpmRY7W2WN8nqtwQh7SOiu6OgkszsPY/xvBAA==
X-Received: by 2002:a05:6300:218e:b0:243:aa4c:afd9 with SMTP id adf61e73a8af0-243d6f03239mr24769313637.35.1756970635249;
        Thu, 04 Sep 2025 00:23:55 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77243ffcebasm14656452b3a.51.2025.09.04.00.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 00:23:54 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 15:22:37 +0800
Subject: [PATCH v11 2/6] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-qcs8300_mdss-v11-2-bc8761964d76@oss.qualcomm.com>
References: <20250904-qcs8300_mdss-v11-0-bc8761964d76@oss.qualcomm.com>
In-Reply-To: <20250904-qcs8300_mdss-v11-0-bc8761964d76@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756970611; l=1783;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=+O3JVszsjnLSrzFlB2OH9FsEdDEqIq5Fgx/8nAIsEh4=;
 b=Kfi4EmWe6GawXwHy9Ndco2Y9vej8kL59cvhYCKx46sfAb4L2FFOtnKHbKSIfKrGR8u3g6mTY3
 am8xMIDU7JFCQjofxPqxW9QOtw2NWgL+ViIv0KJj0LSh+8VgL2QTKhx
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b93e8d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=EzsmDbvTTSquCHoeoRYA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 8bUNYQLF6pdbSMBNIhQbjNePcLtKZRYj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXwfrCY8qndOsJ
 rgYdR0ewn4TpRv1oFRXXVC5MJndgPam2pyg5HIfd0GxJtJF3rxqNOndYxO9IZgPZQAdDPoEC+vb
 uVUyULDhFxAdF5VNOC0WN736SZfw7TGaANSvOMlKF9k1QeoDP8BsnAIgvX2qbZUj4/MPmq6nRkB
 vELr6KONyEjbgqnhyNoKvUEpfjbBIBYa9hAKyFZVP2/VIAZtgMatYE6Ko9F4zqPsi61C3qDx9HX
 ZC8xf4nj4lkVyFIv7WMz5mKk6QiqNA5Au6NFoqy+xo0SuuHOcSzt12THo1JYr3VFi0pwavFEEkD
 YMivECsPmbyS0p4WDxg5T0inoYdFZ3EPcpfkYogm/Iyz2HI2SSspp7sDn9XYHr8R7PS0CAcvWd2
 wH4EZmhQ
X-Proofpoint-ORIG-GUID: 8bUNYQLF6pdbSMBNIhQbjNePcLtKZRYj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

Add compatible string for the DisplayPort controller found on the
Qualcomm QCS8300 SoC.

The Qualcomm QCS8300 platform comes with one DisplayPort controller
that supports 4 MST streams.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../bindings/display/msm/dp-controller.yaml        | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index aeb4e4f36044a0ff1e78ad47b867e232b21df509..ad08fd11588c45698f7e63ecc3218a749fc8ca67 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,qcs8300-dp
           - qcom,sa8775p-dp
           - qcom,sc7180-dp
           - qcom,sc7280-dp
@@ -195,6 +196,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - qcom,qcs8300-dp
                 - qcom,sa8775p-dp
                 - qcom,x1e80100-dp
       then:
@@ -295,6 +297,26 @@ allOf:
           minItems: 6
           maxItems: 8
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              # QCS8300 only has one DP controller that supports 4
+              # streams MST.
+              - qcom,qcs8300-dp
+    then:
+      properties:
+        reg:
+          minItems: 9
+          maxItems: 9
+        clocks:
+          minItems: 8
+          maxItems: 8
+        clocks-names:
+          minItems: 8
+          maxItems: 8
+
 additionalProperties: false
 
 examples:

-- 
2.34.1


