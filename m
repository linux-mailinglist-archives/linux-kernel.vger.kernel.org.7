Return-Path: <linux-kernel+bounces-811747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A91BB52D69
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70FC5680A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096AE2EA723;
	Thu, 11 Sep 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kAIiuCpU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D022EAB66
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583454; cv=none; b=TWJqTOpmSLnFApBTaTxxKDhbWLCSNgY5o/aS03EfWMuXB3QBMh+ZSfzB02q8cJUna37e12CsHcq/ZpeZ2sXBmjr9BWqj7IImo5Z8qVyXeXhx9fNiXMBgn9f0OiX3OQopYVcB/u35u4PZ16fRMVVscOHt7VlTmRlsndSK34UuYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583454; c=relaxed/simple;
	bh=HMl3fZ2Rn1YIATYS3PdgIW/HqL1qSbetF4GeJQOJzrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHVXPE1thPQXPQ7q6Gms89vGzyJPwaOzcNqEuveUQ9zfRc/4PM/ogt8kql2D9ypGNUnmml5H/gzyD/WzfHTMtuQP47lGm7P2EqZ24vPJQHhQi4+sxWuaAahqYteH40f9gHXuh+q/oJmGznV01pIKjUa+ddRz+nNCo0qO5JeSwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kAIiuCpU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B8VNKC002780
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gi5oBQd150ml6prGdotl0tqIGqGqxXPGsrnAZADhhF8=; b=kAIiuCpUhWnrEvTX
	eS+Iai3UUJ9KwT9Q0Df2ec4CHtPghELY+riEuCSRrT02sXCHBtgWtR7SKYWYWVjm
	gVI9aZTwkE01h6zyQI1wgoI6gg7NQcqgSSPJIz6x+qIXufKlKp+j94VFYe14Q91x
	8EKnxscvJwJBeZOV2XMEf2MFpB+XfIi9Syxqr61bKOjmHGZwVh5PpUXoq1D14MjY
	4LpDs1Z2LTSVxU8FyxbLn8H3G5BJElTKkcmwtsnWqipw2rMWIXYqu10WEMtrUS32
	+JvWLkRz2Kxr1nRxNvL/Ie5lrSMDO7gLfHrE+iNkQFZnksnMukDwmtMW3+G342VR
	0yJA1g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493tyxr6yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:37:31 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47173afd90so827786a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757583450; x=1758188250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi5oBQd150ml6prGdotl0tqIGqGqxXPGsrnAZADhhF8=;
        b=AF05CevjT7A6DDGgxC6oh2VsPLYuxvAjFp56eWCWzmvbt5hNkq2681I8uCTRjt1F9H
         e9kzTvnCJOlPKlRqmFgQNKRYuMzUgZLWSwARuigAPetw80riHTzeGWluXr06+PSf1FK7
         u494ZNGEzxdNAthI9dnwsp9BqvxGZuyBt7K2diM0QxM8td3ctgGiIyzvqO949t1nPAjJ
         4mMVFPamfqCvw0P+6aon6girE1UCavzR9wcTScdR+0U/jxk2YlN32zB+k4iKF46HvAQC
         webVo0nWftbmmInqN960dBdCXrs/FKNwaPV/yR+/N+4/IzP7kdASv4qXKvMiNM8WeSGQ
         nihA==
X-Forwarded-Encrypted: i=1; AJvYcCUlSVM/tdBsiXVnf+j8ZX5vNAbi+SdGApmNixUTmVcvEcWzcJWYsFRNHRNlx1h3qkWZjAsijt5XIoiRBh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbMWhpO/5hwbA/66x4HXKqVZRn394qnyJKHH3BJk5A/ejXLA6U
	q3aQqIJWioKYZmgki8OIh2SR88nVRz7mLfsjtwByFVrtTxxK52wVkOF92lVV/s0WeqdeLjoNgxl
	OOI66vWjDJjQjjVgMSsa8Xd181eJWGthYy8eX1hUaFdSuCqcU4Q6hNGM8rqTgq9FI228=
X-Gm-Gg: ASbGnct05vNPM5sT41jh9VIrndhvUXqbRxwfw3PsQCpuvz/kqxyWpyTphd0P3OIgHrX
	VRns1sPciE/mf0LsfYjVMkozU+jHwCGtOAP7lUrIMAzZYvKSJeGUPbaD/AW1c9UvJHNYtAfM5T2
	meCIMBHTj/FA+Ju/CfYZUANGSMVjkM7ru8EfJv4kNHmTbOb/6i4vY2d3aDNnTSKLBIOwbVZ2ize
	sJYplzjDrayjYekhxMKTk9KqpO++rQuXCVpFTJH51GTjzK/Fk/dQ1Fvgb1D5iKsI5nrn1/zg6ug
	osU8am7vaq8882/Ie8sCJ6GkepCbAh9OPyV2zA6cMYkTEWQ62sJjvE2xVMiOlAZnzYpQnonwgx9
	3nV3Ycg9ZfHL3u3p3VAFJdQzSttg=
X-Received: by 2002:a05:6a20:6225:b0:25c:3979:ec83 with SMTP id adf61e73a8af0-25c3979ece4mr4829145637.58.1757583450283;
        Thu, 11 Sep 2025 02:37:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGklNx1s9kfakLwf6g2Z92p7sShD0ETtCefU8Z7wCR9fLvQflFFCs7h43CY/eaESOBS1daiqw==
X-Received: by 2002:a05:6a20:6225:b0:25c:3979:ec83 with SMTP id adf61e73a8af0-25c3979ece4mr4829117637.58.1757583449839;
        Thu, 11 Sep 2025 02:37:29 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b730sm1512930b3a.15.2025.09.11.02.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:37:29 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 17:36:56 +0800
Subject: [PATCH v2 1/3] dt-bindings: arm: document the static TPDM
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-add_static_tpdm_support-v2-1-608559d36f74@oss.qualcomm.com>
References: <20250911-add_static_tpdm_support-v2-0-608559d36f74@oss.qualcomm.com>
In-Reply-To: <20250911-add_static_tpdm_support-v2-0-608559d36f74@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>,
        Tao Zhang <tao.zhang@oss.qualcomm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757583439; l=1550;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=HMl3fZ2Rn1YIATYS3PdgIW/HqL1qSbetF4GeJQOJzrk=;
 b=7h5NsGCmSvLr1eV1Pu/oVXpaH3coDnZcUXkOVrXKG+YON1GtXZr2Q+xCI0EWrZLFne7xQDtMQ
 z4gq5OLZsGmDRc+llzA4KT7zZbWCEPttkam8YvHFt0ncS3BUdSwjSnn
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-ORIG-GUID: BMtYQtdPO_GHL0S1GGmPWvuKtQ3BfPaQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA3NCBTYWx0ZWRfXxLl3h85YkTil
 V0X/mqz+uglGETupEktx+yjJI6KGX9OiSQo302PcKSX3reRs13g3EnZcP2YhNDHZhBx0+5Xj7G0
 3Q6+pz9ehTOTeRXICSyeWVgLw0dVsUEAafds1DF38O7e6hHIa+JyrpxUpd7FRLmnBKejg7PU1/O
 sKNoYz+q/E819ymmgPGRUpHJb2BHWlVrSJmRG3KETBisY60iOL7Vju3rNntmmBhZMEr/8FcqbM5
 11gZsiv9HMnFJzVBornQIymRuopt8qbWnheWrCEIA3hppQusggNJyaaMTskVzyYY/Qcx+1s6Hbi
 FYr4dwcw69pN2M0M9U+5goAYrXjoofc7bPWJ9sfhZxnVJyhBhZdN/Qs51nB5CkVDqY+PXePLBgD
 SQP6o5cL
X-Authority-Analysis: v=2.4 cv=VZn3PEp9 c=1 sm=1 tr=0 ts=68c2985b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=5Z_N_GBq0btHVWfAyk4A:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: BMtYQtdPO_GHL0S1GGmPWvuKtQ3BfPaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509110074

The static TPDM device is intended for sources that do not require MMIO
mapping. Its compatible string should be documented clearly, along with
an example illustrating how to define a static TPDM node in the DT.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../bindings/arm/qcom,coresight-tpdm.yaml          | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 07d21a3617f5..7c0acc1f25c5 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -36,9 +36,12 @@ properties:
   $nodename:
     pattern: "^tpdm(@[0-9a-f]+)$"
   compatible:
-    items:
-      - const: qcom,coresight-tpdm
-      - const: arm,primecell
+    oneOf:
+      - items:
+          - const: qcom,coresight-static-tpdm
+      - items:
+          - const: qcom,coresight-tpdm
+          - const: arm,primecell
 
   reg:
     maxItems: 1
@@ -143,4 +146,18 @@ examples:
         };
       };
     };
+
+    turing-llm-tpdm {
+      compatible = "qcom,coresight-static-tpdm";
+
+      qcom,cmb-element-bits = <32>;
+
+      out-ports {
+        port {
+         turing_llm_tpdm_out: endpoint {
+           remote-endpoint = <&turing0_funnel_in1>;
+         };
+        };
+      };
+    };
 ...

-- 
2.34.1


