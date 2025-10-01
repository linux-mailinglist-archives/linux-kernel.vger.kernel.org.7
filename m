Return-Path: <linux-kernel+bounces-838536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCD3BAF6C0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692604A456A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D49274B34;
	Wed,  1 Oct 2025 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YNRpy4Rr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C02749F2
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304057; cv=none; b=WnxZjpah/fWhL29oot0BH9MGxC0f7ZGQ8+8HKj2jHOSRtAc7PR03qwntshtjHoFgPiYlwmA0e+LRFjRxprZffeFCxnOwa9ajNmgfe3MUnR/esc2a1vUF+CAiSUKg7e4YYbHtZTkM5v36SF+NwU+A1uEPyp4uPKWeUK0gWwp+fCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304057; c=relaxed/simple;
	bh=8fCLXWu3MGxxQqh4/DRKlu28a5eh5vLEq8h4kXwAYfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hg7T3IlvAr33G00aMLilU5TKQsOFgWIAPIClgXKZp8pyigl7vOsoGhjaQcbjlFpo7iIWJGwNx+yHlxUvGpWYj+zh6Rvn9Z/4TPhveCV3rOZCYP/LL0k0GxuQwaYPFao1YxU6vDajwJtofuyA9vL+XVJ5JMvBbQG3trcXTJn8j8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YNRpy4Rr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UJ7QmO012433
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 07:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=YVYgJqy9pl6Jh6Ezns5hMgLaW2BpmEvKFteq7/wkIuU=; b=YN
	Rpy4RruWMCkE7UPl5goJo5Kc1WvrH+MwRjgHQqDtciTdBcWmdDcGBneKOxPa4zuQ
	G7I4RvfzbxXOjkkMnzy1VsdPHTHZ5Ypae2He39laEfogU36l7tvxqsTdWPFyJZJz
	LSJo42y8tFDiBU52viKjsUTl/31q0SkEeNlHXXN8PG7hDWhoJEfZhZ+1HM664BF8
	nFdaG0An01hlCSWCy/TURar45oNjQ6IOGz+ocZAH2snxCb2AmKzcz43ql87BEd98
	64aSFA3pyFNnuTT8hTqawcL0/oykvlffU+3nrHE7oTbSbt5rhOnf+mmreqj1l8E/
	rJ+2hBFUhGZNqkMZwPhQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a63rv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:34:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27ee41e062cso66210825ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759304052; x=1759908852;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVYgJqy9pl6Jh6Ezns5hMgLaW2BpmEvKFteq7/wkIuU=;
        b=TClC3JLZwKih5l/caCcCAD5MqRJnYG7IC9+lRuFXDqTDMgORlnC7DYTwpUqpWijQW5
         wrfOZ6pbYv0qjM16QpJ6dNB/YmTgikIDDCvn6AVwDZGMr8x6CoubI4xHFkXlwssOS8z4
         7ccBovgQY0Qakmny+31AzVb82I9wt5a2itSstCOcLDOviRAKY/JBcfo26xiopfVAJCEg
         vuDX5fKxYTV53Cj4gGug9tfzkjmsWR0u8ZN4Hsl0BLTmOcT9NvD0QF42OZgQ5+LFNvBt
         ZINp+KAOvaO2J3XiO9hsBZJWSDC1zByAEHMxvXeAIqBZl1/0Ji3jGzLi1eGJi7mZOW96
         /36A==
X-Forwarded-Encrypted: i=1; AJvYcCXAWwX+x5uJGMsKaUOfjHU+JzCOcEQZ/4Xten5WuOnrXgD3mLiIj2783kr2+x2e/fgcNUNp5oFwS2AIqnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLDSUf2aM1clQpK4ZQGNKIqKmNNfqR0K/y9yRav9/lArmrI1S
	M/pvv8jENweV/ZOHfEM2futEPZEfjV7Rh+GwxtT2//XZPg1K3ICVH8EKBPYJq0YjePHLHPM2et+
	H5zxIMjlAjiI2g8lqxXim0EW1r1UFurYQa8gL5lA2CHBcj7tD0AGuoqpPnj8LWaSDdeo=
X-Gm-Gg: ASbGncsggV3tqs6EOTc1K8INOlE7bPx/jA3wRAPcQDUoRPhDca7h4oUcSfSdKY1MR91
	IiYNs7UhJ3D4T+FZBhMHR2UYRcUFO3mpIwP/F8P+xae+onr8stHDywuImd7SiEonaTCCR3J/4Kj
	cn0pldXT3fuziSq7e+gDHZG4zMzha1Mxzn/KFgUzc1k9oWg6KSHkaSqdFQDFNpJEDefrsDzQdJD
	phLCndgbjWmjskXvywy98aoDXtHFgpD85DKvqXTDM+RaWV9wbDKkMJ7lCRMsNc7McoAN47ia0jn
	jAzgZtC0j/TExBxUnAIRHwuCnq6OhId6F/Q3AabS94ocDzhnBXRKQgy/mcTpqAKGDM5AN/h45WR
	NYXc=
X-Received: by 2002:a17:903:1b24:b0:267:6649:ec17 with SMTP id d9443c01a7336-28e7f2a37c3mr29063425ad.23.1759304051947;
        Wed, 01 Oct 2025 00:34:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCLP1TOKpobDKWLKfNm9Qikln5EHMckIY7xiu+WSlRq7tmz7s1XxvSY8y3mjf7W0+v35p0Ng==
X-Received: by 2002:a17:903:1b24:b0:267:6649:ec17 with SMTP id d9443c01a7336-28e7f2a37c3mr29063155ad.23.1759304051505;
        Wed, 01 Oct 2025 00:34:11 -0700 (PDT)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6effe77sm1642127a91.17.2025.10.01.00.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 00:34:11 -0700 (PDT)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH v2 1/3] dt-bindings: interconnect: add reg and clocks properties to enable QoS on sa8775p
Date: Wed,  1 Oct 2025 13:03:42 +0530
Message-Id: <20251001073344.6599-2-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
References: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68dcd975 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=8b92ao9AcM591oi5rHMA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 8UQ0EiZCXwnUcxxBsKei3w60KKSds_AH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX/vda4xgDrYwQ
 xuRxrDdGhM6/NrKx+doB+VfTc2QsxOrY5YkfSccwHKp0x5uSlzkDA0dt0zUcTTsrW1XGihzajdK
 7vQ/VJTy8HHZZEARgC37ejPo8UPohuHXI4+irOOJSjr2oTGMlqPDRXFBllPSsmPUkUe2bvtl2ft
 xmljEKRueChYI95gF1eNSdJnsq3pDN2BUgeMAwzYMHfKyOIGBiBHreQZo9REmUmbKRk7JQ80XFo
 BZP82JvRn6n48vTKL0fXFAHN61nORy6xlzgW2lnUO9e4xEES/pD3w8Ggw4sqYAP8RybQb14YHNq
 6eCqwKZuzBt5xisDrKi+YQxO2SSWF3GFErFiTgkhSol79sWGA1Jert5QNRzEzJkGZqCuiWfcE9o
 GSU3QpV43HPoLVMpOhk/bcGqjMizZQ==
X-Proofpoint-ORIG-GUID: 8UQ0EiZCXwnUcxxBsKei3w60KKSds_AH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add 'reg' and 'clocks' properties to enable QoS configuration. These
properties enable access to QoS registers and necessary clocks for
configuration.

QoS configuration is essential for ensuring that latency sensitive
components such as CPUs and multimedia engines receive prioritized
access to memory and interconnect resources. This helps to manage
bandwidth and latency across subsystems, improving system responsiveness
and performance in concurrent workloads.

Both 'reg' and 'clocks' properties are optional. If either is missing,
QoS configuration will be skipped. This behavior is controlled by the
'qos_requires_clocks' flag in the driver, which ensures that QoS
configuration is bypassed when required clocks are not defined.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 .../interconnect/qcom,sa8775p-rpmh.yaml       | 50 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
index db19fd5c5708..71428d2cce18 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
@@ -33,18 +33,66 @@ properties:
       - qcom,sa8775p-pcie-anoc
       - qcom,sa8775p-system-noc
 
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 5
+
 required:
   - compatible
 
 allOf:
   - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre QUP PRIM AXI clock
+            - description: aggre USB2 PRIM AXI clock
+            - description: aggre USB3 PRIM AXI clock
+            - description: aggre USB3 SEC AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS CARD AXI clock
+            - description: RPMH CC IPA clock
 
 unevaluatedProperties: false
 
 examples:
   - |
-    aggre1_noc: interconnect-aggre1-noc {
+    #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
+    clk_virt: interconnect-clk-virt {
+        compatible = "qcom,sa8775p-clk-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre1_noc: interconnect@16c0000 {
         compatible = "qcom,sa8775p-aggre1-noc";
+        reg = <0x016c0000 0x18080>;
         #interconnect-cells = <2>;
         qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+                 <&gcc GCC_AGGRE_NOC_QUPV3_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB2_PRIM_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>;
     };
-- 
2.17.1


