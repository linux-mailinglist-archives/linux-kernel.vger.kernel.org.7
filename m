Return-Path: <linux-kernel+bounces-868507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0190C055B1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0031A08793
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2C330BB81;
	Fri, 24 Oct 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PVxUHoqQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFAC30AADC
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298416; cv=none; b=pHc8+xjwTMdCPM1Rv2pfQQsFeAixCb4tqtIZDtuW2ik0UwsttB/Hi1v1eHcuybU0pOT21mV+hPvR2T6s5kZ0Fb7TufpHJoRqAlrLwq8YkeaYotjk3zCLrOrrPNj64MEFMiNP9D0GGYXmoq4TdlKjLyTK7IszC6LhHh5HFrhJP20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298416; c=relaxed/simple;
	bh=sLfc6/pV30D5lq+QPBhYvo6G/wXhYAzok8S7hahT+7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CV/sqPgjjZo5IEGF0vzi/Oeeb1gx2DBmIHf6m1nM+lJ8dLcQoddvn0FTsmoecNR4CI4yGjss+pfQXmqMy4gs6fAvGMB2+yimSdC8eCy2MnrcY4DaaDObev3qPMcGaRzsRcpXPHUbfESJqNk1AKQvx3KJqNpua2o7XNbyYMfqIGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PVxUHoqQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FLaB014872
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BFsQ8QDek/CRCSn3Sn2QCbGXL9ljG8jJXnynkhQ8/wA=; b=PVxUHoqQpdk3Qd3Z
	zenZ8FkKkE5N79dpFY5gw3CrMyiuzk3gl8xjqFB3SHr6n8xb3ICBBjST0e3WmYmv
	xE8yRYNonw93SQXilO6LHegF9k7wwtZTZPJYH2ykRYn1IVFykUg+YHSWJA8VuLbP
	OsnGGSNyYYUHnjmcchB1kq/JhUp68gKqnphIoQCxHFFgwf8gj9Sd6viP0JNFSgim
	iTO5WMOaqGBT03b2+PaRm+cZ4xt4TxYcl5zURZYMx4sSypWUYWc0F88v0U47IU+1
	a6GMErki3GUKHh4c1/qC1KFNISRD3ldSU1SLjYDuPV0qYXOzT5Wfj8oOGH7IgQLM
	/5MCuw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08puse3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:33:33 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e60221fso3607246b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298412; x=1761903212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFsQ8QDek/CRCSn3Sn2QCbGXL9ljG8jJXnynkhQ8/wA=;
        b=UQ4V4P3wU0U5b/7MuzvYqkENLgU2I2K6ECe0CvEpgsqGoa3tfXr1g2M7T/sTqFRnHr
         66psCbzK9DmaWtUT30EsLhEiRIy2Juz+6pOJt4Om2KIPmFqxoP5XjVdifJsZtMS17NUN
         3OiTj/0wjGABXTivN4r+1bZKUfg3PSXlrZnBv13Ocf87RSHt0uTDYaLYIar1jgpYnkLr
         kdjwy3sr1mCjWtGKmSGX8UXheHbu6ZFFw+LFj1uExeR+iXy3kQmDjQxyKPM2gLINZfOF
         WgmseXpqoABMiwWhkb+JenzHIlW7gCLF134tfmISqk1lfXRUbYD16+K0irJvoWe7VoRT
         0V7A==
X-Forwarded-Encrypted: i=1; AJvYcCUmj1mH9QKlukApfEQu5Wh3oWs6R5gfglToX4PGCg6mMOBf4bNJqn5jg4e2XJQe+aWVmJQ9LDuy+9mrgvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZY7K/JN7KCcjQvx4MvtbiX/+ViShoeF88LAwlNOIAMqssmdl
	x6dsHKP2r+pmCjsZQ8R8jzqUAXYG0cowQT0d9AmFPkS3tlb4cQ+32S0nhTLQ0ClQtVevMuzEN2A
	/QEEQW66tSXG0hysSqISbNSZsZelUrAVwF/7WGiz1d1XOB0Ziy+8+r24A4LXcbiVnmUA=
X-Gm-Gg: ASbGncvvyTizal3GM7PcHisbw/PB9xK/JA4Pv09l7oGBUcV6AN+WwpHOVMp0PuqiI0n
	yreft2EYvRfDMHiTZn4ZZNIWcSj2aLHf1HyWUagwgDUN8e9yMyA+KXl40XycvqgaixGPAHi1/Qp
	J/CYLkdODtwlXwUvJa11G2yfHalXSPvrtRrbGIu+uxMDE5Zm+enVpO8fgqj+3zcvNn3iUeqknrP
	30ikdoVKleYxPLZ9yNlkKKytQDgQQH7/MJI1TKKBw9JmExF0uZVgFM42yEr840g1F/L82ik7Wmq
	nzjj8k02xWfDda+2+OvbpvmXVPyXQtu7Ir6/HYp614RGiEugqOp6OcrfX0vSqPnb9qqBLIH6OIo
	8E5b/sMGf8gwn++94Um0MxuzjdrrG5LMdjA==
X-Received: by 2002:a05:6a00:1916:b0:793:11fc:783f with SMTP id d2e1a72fcca58-7a220d2ebb7mr32870197b3a.29.1761298412277;
        Fri, 24 Oct 2025 02:33:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXf9hXKUbGYeXNisbeDICxOQKlKaEkz3DZyx21OlN2Wx/k/LrRUL017iNPl39reqGmwOs8Tg==
X-Received: by 2002:a05:6a00:1916:b0:793:11fc:783f with SMTP id d2e1a72fcca58-7a220d2ebb7mr32870160b3a.29.1761298411772;
        Fri, 24 Oct 2025 02:33:31 -0700 (PDT)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc33easm5270332b3a.68.2025.10.24.02.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:33:31 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 15:03:21 +0530
Subject: [PATCH v3 1/3] dt-bindings: spmi: split out common QCOM SPMI PMIC
 arbiter properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-pmic_arb_v8-v3-1-cad8d6a2cbc0@oss.qualcomm.com>
References: <20251024-pmic_arb_v8-v3-0-cad8d6a2cbc0@oss.qualcomm.com>
In-Reply-To: <20251024-pmic_arb_v8-v3-0-cad8d6a2cbc0@oss.qualcomm.com>
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Collins <david.collins@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        aiqun.yu@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com,
        jingyi.wang@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761298404; l=4364;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=sLfc6/pV30D5lq+QPBhYvo6G/wXhYAzok8S7hahT+7E=;
 b=OOLipLvIqkKmby+XtgeiARJi6Q7hKTpNM25DoMrZf+1ImHEB9gLCCWLjrEN/4eub69Fcm3ndG
 QwZwUkOhoXvB13EsfFcmh3e5beeU3+/8jYkxnNU886bDrXj+HuEE7w5
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX8COuLqDU0ySv
 R28s7ddbQa/VT/H9RchcONt86K+k6sd2P3COsfbu4lDdJFqfonmwSaXIGlcoPUeKYZPkMUHpFGv
 +PQMOVnx4W66f9lM7zlNrvMTssEdpsm/raafa0SCRT6cCsNc2DNrvGOGjJgUJIQO6/nQwalqp+p
 O54Tj9+GsrNmSm8m4T84KpwDetab0ekX+t3fJD6ykwfdIMmC3X760MGBT+V+If5dLBCiDR13Je4
 /Q+XZCWSbhc0W5DzZrCDaNXNoLUwdvadZXXG3VBzVZFdFYmW/iawHlob3f02wXRM2MgQpN3+rXL
 jm+4EMemtWqjnGcvr9bokgW7JKqoKuVFO3mhz3tW3kaftjZYTmQS5hqYWPmRaKAKfO3i4yIf9z4
 pcdle8Pd9ICd3TQJfY9rN35zxu7beA==
X-Proofpoint-GUID: k5bGFETTHQBp5fHDTLdvAjL_4oF_TI6Y
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68fb47ed cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=w24Q35eUI-_Cj95TU7gA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: k5bGFETTHQBp5fHDTLdvAjL_4oF_TI6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

Split out the common SPMI PMIC arbiter properties for QCOM devices into a
separate file so that it can be included as a reference for devices
using them. This will be needed for the upcoming PMIC v8 arbiter
support patch, as the v8 arbiter also uses these common properties.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 .../bindings/spmi/qcom,spmi-pmic-arb-common.yaml   | 35 ++++++++++++++++++++++
 .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 17 +----------
 .../bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml | 21 +++----------
 3 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb-common.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb-common.yaml
new file mode 100644
index 000000000000..8c38ed145e74
--- /dev/null
+++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb-common.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spmi/qcom,spmi-pmic-arb-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SPMI Controller (common)
+
+maintainers:
+  - David Collins <david.collins@oss.qualcomm.com>
+
+description: |
+  This defines some common properties used to define Qualcomm SPMI controllers
+  for PMIC arbiter.
+
+properties:
+  qcom,ee:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 5
+    description:
+      indicates the active Execution Environment identifier
+
+  qcom,channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 5
+    description:
+      which of the PMIC Arb provided channels to use for accesses
+
+required:
+  - qcom,ee
+  - qcom,channel
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
index 51daf1b847a9..d0c683dd5284 100644
--- a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
+++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
@@ -19,6 +19,7 @@ description: |
 
 allOf:
   - $ref: spmi.yaml
+  - $ref: qcom,spmi-pmic-arb-common.yaml
 
 properties:
   compatible:
@@ -71,20 +72,6 @@ properties:
 
   '#size-cells': true
 
-  qcom,ee:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0
-    maximum: 5
-    description: >
-      indicates the active Execution Environment identifier
-
-  qcom,channel:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0
-    maximum: 5
-    description: >
-      which of the PMIC Arb provided channels to use for accesses
-
   qcom,bus-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
@@ -97,8 +84,6 @@ properties:
 required:
   - compatible
   - reg-names
-  - qcom,ee
-  - qcom,channel
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml
index 7c3cc20a80d6..08369fdd2161 100644
--- a/Documentation/devicetree/bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml
+++ b/Documentation/devicetree/bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml
@@ -17,6 +17,9 @@ description: |
   The PMIC Arbiter can also act as an interrupt controller, providing interrupts
   to slave devices.
 
+allOf:
+  - $ref: qcom,spmi-pmic-arb-common.yaml
+
 properties:
   compatible:
     oneOf:
@@ -45,20 +48,6 @@ properties:
   '#size-cells':
     const: 2
 
-  qcom,ee:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0
-    maximum: 5
-    description: >
-      indicates the active Execution Environment identifier
-
-  qcom,channel:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    minimum: 0
-    maximum: 5
-    description: >
-      which of the PMIC Arb provided channels to use for accesses
-
 patternProperties:
   "^spmi@[a-f0-9]+$":
     type: object
@@ -96,10 +85,8 @@ patternProperties:
 required:
   - compatible
   - reg-names
-  - qcom,ee
-  - qcom,channel
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.25.1


