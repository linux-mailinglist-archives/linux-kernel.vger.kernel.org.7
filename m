Return-Path: <linux-kernel+bounces-855537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D554BE190E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F90480AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A92459C5;
	Thu, 16 Oct 2025 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yd67VGBI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029423C8C7
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593781; cv=none; b=buMH7Z4mxEmJCfvJ7XzDffRZ4aG1autLPhzJJiABSc6HMDOmYu3J7Iq11jy3PNH33xKOADWdYDcUjUOCQgUSDqquZvlYkMXlaGJKEPZNisEz1gF0tmwYflRCPEhJCkpKHi5+a96tDyH///OeEPcCcxHErphA83oJb+THGQCAVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593781; c=relaxed/simple;
	bh=Y867aF4IBjLOR2gpmZC8PqfLpe9/4Juk6DhmSLbLZ8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sgq07JEj8RUXRJJzw8H38lbJnzt+WwdN2us1sPkjhTcXzlTO/P1B/lKhPetFoltGbosgYpYVQ7N1XZyxD1UAVTmAwvfGxNz1L7uJt+1KP07Ma4WGPkj2tEkIoR6C/H1pTGMDqopYiKe9QyjZXmg0WlQwJ5RHyBfMe+5SiJUIh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yd67VGBI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FI5SeJ003473
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R2ZenOczyNRPh+gBJvOKUiI+2zJ13iDNHmu85jEHTew=; b=Yd67VGBI58dErsGh
	isd/1zx7yOpKb3m7HkpVF+9HJkwanhUQqM3yBcXDQV/LrkBkq7jZk0l/KCjKCzh3
	kKjRccqkbEk3KgXbrEqIxDXWn4d2Lsi2gKhkIBbyHfR3hJRwYKtNdFC3griq9xbw
	oM8gLtFl+vfCQDahH37taNmXBIUdHlWP98Ty8bhlbGeaLPoOXd9/W2WR324LYwDs
	61Q2yuQfGEbjzxaMDxY4iYsr0Qdlf+8adhxqBjtpr7AII56dASlgx+8JlP7oQ2zf
	qnZj6+sQjJY5XbYr+4WiocmcZM/F9ib73WDke9TrtOKjXwt41yQ8gQ3CrJssQXc5
	zfqbHg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8nqwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:49:38 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b5533921eb2so245696a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760593777; x=1761198577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2ZenOczyNRPh+gBJvOKUiI+2zJ13iDNHmu85jEHTew=;
        b=AZ1FkMzre4PLGrDRmgVGAbYuNZGXnEiZ+ncdL5n1iXT4GU+36TBK+JvXYWU8lKni8I
         /nhuzJZ9+jBztuYAD1sBnKxgCySjHnafupbd3v+5yUR136cvjxzILZ78YRR/EdILpheC
         lIK47qWZ/ykWEMTIprrRqu8lJgHTMDv4B86SORdteW4yR4czHm9L6umcZA5uWI3q00Mu
         aUCQTLBacCWYVyzNENXfIOkbYxzp3Pe9uZkLqBkpyIM++7Q9aCAfbLdzzVRRAoPxTtCL
         BJ4DAV2l0szcQJ67hjlbzNcA/n7iqWd0lsVEct4WeGg0HtBcz1Aqe3APWJOxrllWuY3o
         h5uw==
X-Forwarded-Encrypted: i=1; AJvYcCVcDUyVEiiL9ymWZPalBG9Dix1jrHWRa682fjIW4syeMQ7Ziril7P0X7+j9sDm0NeKNXSiIpb4rTMUu9uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFP73rDYowGfA151DhRNFfRgaYMrORZtrA81fmTNLmOJWmwSX2
	bIWxTIhIFQpEHaFXkOTUWiGYYq7VNPL8Sr0GCEp4COeQbw9mo6Fj4eijzzHNujjtSv8Gacz4bzP
	3L+rcfZAloNoC+XNmQQauwfa8eQb8eWIDs6Hikxh0xj8YREUdY66BdpzxWlPW9Crptvc=
X-Gm-Gg: ASbGncsOxBo1oJGp4Z9jY6LA3pZ6XUDD2kArtlTO+wj33Wjs5nizqO/mRFBD1tI1lDe
	SCXcZ43+jpo/HdlpS9mrX4Iywn4/SykamUm/qeTav+S3wBtb/sLtPWa6amu86X+Hkc5hD7jYjBf
	bvQuW5Xxq5bx95RAfyMdocjZZI6nyA02lgNVrMDFfRV8RZjdLdJUG7hvwuaj6VebECrLMWFEQXi
	dQ90LNUBu8xEewdQHuwXbR0zNQ/TjuGVpmMvrMWF+DxlX93FK5uKLwx1yEqZKahTpmgiElu4jSA
	DGMQjGSaRZeiL3e7f+2l0H+6v0cich91ddxxbTdfEb0aaKngKbe5LYmjEwSK49WZ7AdKfP9/4Fq
	SGT0mMhL9Plpi6IHQA0APjvIRlkvSfFEGbKlXZ7yR4rVY9C43kmTBdi7d
X-Received: by 2002:a05:6a20:918d:b0:334:a261:862f with SMTP id adf61e73a8af0-334a26186b3mr150094637.26.1760593777488;
        Wed, 15 Oct 2025 22:49:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRjYvscNvn4E0vQBfwvASCV4Pqf0m+pOtdqzRYlI5lGMnrf4heuypJ8w8YWbvPn9A6D3ZaOA==
X-Received: by 2002:a05:6a20:918d:b0:334:a261:862f with SMTP id adf61e73a8af0-334a26186b3mr150055637.26.1760593777038;
        Wed, 15 Oct 2025 22:49:37 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e1336sm20657931b3a.59.2025.10.15.22.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 22:49:36 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 22:49:30 -0700
Subject: [PATCH v5 1/3] dt-bindings: arm: qcom: Add Coresight Interconnect
 TNOC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-itnoc-v5-1-d7ca2b1cc6df@oss.qualcomm.com>
References: <20251015-itnoc-v5-0-d7ca2b1cc6df@oss.qualcomm.com>
In-Reply-To: <20251015-itnoc-v5-0-d7ca2b1cc6df@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760593774; l=3075;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=Y867aF4IBjLOR2gpmZC8PqfLpe9/4Juk6DhmSLbLZ8U=;
 b=cliWJQ3cCm/Fg7j1zfG3GF1la0aaPjQALYORA+TGbWnntK956NJJ0g8VbCrYQRc+v5A9cc4jL
 zoeEtsiuSbLAXyvjitBHF6kaYuoH4vz3sV7bCFgyhDTdYSQhvw9uak6
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Proofpoint-GUID: dvN-pfzEdKZ5H7jT_zB-SGYjz7xFvsai
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f08772 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=-QmmxQN2S_yWG1-YAlkA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfXzkETCECd09GN
 2iPKh+RcLsi9W223gJQAgxAU9+AMAQEQaI6H8EAy9bAXJwJSah4xAKmnht2e0XM7Sy/q6Qo+XKQ
 cyfEYHpx9HWmcXJas8yzeIli0Dne/w9SWumFdYM7oZnEUTI0Y+akyzCyPttOJY0VWQg39ZMmWWI
 Qg1o16wsOxk4ULk0BSkYSter4LUMHcTfastVtwCkoitfOQAhJCZu5UftQFWOhC4GD18wX1AAzVH
 Bz+Ej/Uj1nRm/bGQr+2d7tXjGnC5F1Wg+rvZx3xjRzcb1X042r6upmrQ/5YpR5kH7v94Q3BsPel
 0SwdcXr9FnYvkq5W8+EohkrimnXRSpYX1hfo6XPNf/Lqy+7Bqq5vTSlsK+G9FMFG4TL+DJAOk+r
 R4uiW9mWUTqiehWcQwd60whKhSiTNg==
X-Proofpoint-ORIG-GUID: dvN-pfzEdKZ5H7jT_zB-SGYjz7xFvsai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134

Add device tree binding for Qualcomm Coresight Interconnect Trace
Network On Chip (ITNOC). This TNOC acts as a CoreSight
graph link that forwards trace data from a subsystem to the
Aggregator TNOC, without aggregation or ATID functionality.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/arm/qcom,coresight-itnoc.yaml         | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..8936bb7c3e8ea267ca66e0cc3fc4dac33ba6de30
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom,coresight-itnoc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Interconnect Trace Network On Chip - ITNOC
+
+maintainers:
+  - Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
+
+description:
+  The Interconnect TNOC is a CoreSight graph link that forwards trace data
+  from a subsystem to the Aggregator TNOC. Compared to Aggregator TNOC, it
+  does not have aggregation and ATID functionality.
+
+properties:
+  $nodename:
+    pattern: "^itnoc(@[0-9a-f]+)?$"
+
+  compatible:
+    const: qcom,coresight-itnoc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    patternProperties:
+      '^port(@[0-9a-f]{1,2})?$':
+        description: Input connections from CoreSight Trace Bus
+        $ref: /schemas/graph.yaml#/properties/port
+
+  out-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description: out connections to aggregator TNOC
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - in-ports
+  - out-ports
+
+additionalProperties: false
+
+examples:
+  - |
+    itnoc@109ac000 {
+        compatible = "qcom,coresight-itnoc";
+        reg = <0x109ac000 0x1000>;
+
+        clocks = <&aoss_qmp>;
+        clock-names = "apb";
+
+        in-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@0 {
+                reg = <0>;
+                tn_ic_in_tpdm_dcc: endpoint {
+                    remote-endpoint = <&tpdm_dcc_out_tn_ic>;
+                };
+            };
+        };
+
+        out-ports {
+            port {
+                tn_ic_out_tnoc_aggr: endpoint {
+                    /* to Aggregator TNOC input */
+                    remote-endpoint = <&tn_ag_in_tn_ic>;
+                };
+            };
+        };
+    };
+...

-- 
2.34.1


