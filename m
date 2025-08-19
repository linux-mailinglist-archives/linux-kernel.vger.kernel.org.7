Return-Path: <linux-kernel+bounces-775415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF51B2BEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6E81B6263C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D16C322552;
	Tue, 19 Aug 2025 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="npO2sc59"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D931AF05
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599277; cv=none; b=MPJpBZ/BiVLH90ryRTezflPVhL/JOhMttwnmsTmd8P6o/TRPFz5hO3kf7C1jtfTVFV4E3x9InziFFZ0ZHhlIT7wAXU0VkvSnFrhUWAOw9o74Gyrvr+FYJLSL+GEQDJa3ufklunLyiBRPKipLfJzmkmiMEwofNs7Okc1uCw2meoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599277; c=relaxed/simple;
	bh=tQ05n+agtjzfIoEEl+pcrxkf/9blP9P5GoyB0C6eaAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uanVJNTjL69fAEz/tFLdm0KScfDTegh+oDDiGve/SrFMY2KA3QDGxRQFSzoIqtkEMfxPvclQZIQI2SCH7JM6P/ekjsWkMPDEd4xz9+5jv6Z+qGHwmdzMQ34C3CvLQTQoBHGc86gyWOyCkOYLD4aWMQD4h7bsDtkIOPLLvOpWZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=npO2sc59; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90iHQ021904
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wEdGbWq87BOSltbprYnwWF4RZ7he4+5VSXWrmFWd0CY=; b=npO2sc595+mPFs1p
	bgeSg/6YNoGqKUc/Z/J8ljwS1T4mMQEj4BidSafIxAKwCsI//V5k+JBBFFTLkK2g
	gM4HeVAP7Q4kcI1T8L1LEdTxccCSttvC7fTC/Rh7/KiDg2QiwHqnWz5jiofaxof4
	4CwexG3Hc6fYVbZq2Fl/EPG+AJouiy8BLzCWM4uHLaG3nrIte/O4rJhijGTYoYYQ
	f2zO7gsfxNun7vzY5l0u141BrOmZ3FZL56Tb763CyjxzCI5YvXIKggQ4gSnjL7Sb
	8MtRcZVsvll2xf9h2T35FQhKiI+bNyNW++tAuUotXXWD+soAYXStkgYZNvwliJSk
	OutH8Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m71cjvrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:27:55 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-323267858edso5204955a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755599274; x=1756204074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEdGbWq87BOSltbprYnwWF4RZ7he4+5VSXWrmFWd0CY=;
        b=ql+vMosggv4OjH7pYAsiaNkCZ/3Bq3P1dAgnfftK1ORRU0cIHNOmxdx/+wTX/aFvWo
         ta9wjEtiYPr65rc2uBGLJj7KPBpCB+CTTgNgFsH+JLOZunjUSaQk57CKmE5/dtHBR/PK
         eCgIT+XOLVcaJWPQYYTx4SjMquZeVpZCFAgrkhRnVgSbZ8soDcW9hpb/yreg7wasHBPs
         lOXg2Brjb4avz/CpFDRrZuF3+b7Z7K2O+vfF/Ip8yvmjAihL0l6NukdTfAXojzXBP0hP
         8Qnsdb/6IzLZIo1wE5KjxYdYRi7T3jJCQbcK3sRHYSzHEUkokVSsC1cJCtjiY19Bx0bz
         7HeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaHY+HUqy38GnxMxsx4H52SMZ20PcmYaZQGoN8ENBN5ofhvMi4zpfRf245h+KV2nuCnAYTYPvYvQ7AeEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGFwl/wxnMVcKODmmrb9wykVVj1ydHjivHKOMrzGDc7zyczhpp
	Smfjjym8388SNbh+YN87n/NY1XJsQbIbLjbXRhPqTLP1qwihAisxCZQpXIhD3hFdVbUmqXypqQ5
	BfVgREp1pyaRoesLBI0UPHVq7qxy2HkToC2b6MKhWbdiyzmDzqkbvxhW1vL0O0ncDStM=
X-Gm-Gg: ASbGncs/bg75lsxyL0MK5CyvrrUXCvrVeJ8Y8Gu/rRoaFQzBYNylQWXEV2/s/RIb/cA
	xLP9QMbhq6MxNC4pJHvC1o7P0NKnBAH0/pdJtwbJMISlWybDf8JK+w0jZcjn6GDbFZvbbvqj5CO
	+zYUnoisYk/RXDjkS0gnDR8zHOv26Nkv8TKZPlDnxnDsg9+fULWq0nSw+LOqI07PXSHzPt+wwlz
	oMnFytLlv23cLYyYF9/vbFrW3/3jpmHKNxL+xGHptkpycfGmUHxcBuzjCmz3xVW0+4EXY+pV0T+
	6t5yDXCD7hLq2IP6DbIPqWlP5av58J+Da+zzRMgFzst8y8ue3T0BH+06uihHpwLHeLDe/IqBxWA
	dBdOMfNNFlH7Rr5xNnlIB2g==
X-Received: by 2002:a17:90b:3ecb:b0:312:f0d0:bb0 with SMTP id 98e67ed59e1d1-3245e5924bemr3339734a91.12.1755599274380;
        Tue, 19 Aug 2025 03:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzH9MaydU+HiMP1j8Tl1S25IjTE5wgQq+251PtIAOURf+OGaUlPYSwcZfx6cQecBKjY9tovA==
X-Received: by 2002:a17:90b:3ecb:b0:312:f0d0:bb0 with SMTP id 98e67ed59e1d1-3245e5924bemr3339703a91.12.1755599273837;
        Tue, 19 Aug 2025 03:27:53 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3237e3eef8fsm2499643a91.18.2025.08.19.03.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:27:53 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 03:27:43 -0700
Subject: [PATCH v2 1/3] dt-bindings: arm: qcom: Add Coresight Interconnect
 TNOC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-itnoc-v2-1-2d0e6be44e2f@oss.qualcomm.com>
References: <20250819-itnoc-v2-0-2d0e6be44e2f@oss.qualcomm.com>
In-Reply-To: <20250819-itnoc-v2-0-2d0e6be44e2f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755599271; l=3133;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=tQ05n+agtjzfIoEEl+pcrxkf/9blP9P5GoyB0C6eaAI=;
 b=mE9YPIyAqbS6QDWBbNpiVAJTT5ZFdJCGl4Kr/hB6l8eARNZFh2wAEZsPNQez9E0hDyfhjEt/T
 diszuxdhqtwBBDF4tFwXf4zjLrwbh75feDvrqqyYilKFG8n+m+vwSF4
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Proofpoint-ORIG-GUID: m2LrPu7seJ4tD4EVhYnzF1o1YWH6xKpZ
X-Proofpoint-GUID: m2LrPu7seJ4tD4EVhYnzF1o1YWH6xKpZ
X-Authority-Analysis: v=2.4 cv=IvQecK/g c=1 sm=1 tr=0 ts=68a451ab cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=SwV635huW2jmLeR2jBMA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0NyBTYWx0ZWRfXw8Dxh+gS+mf5
 RuK1+ypSTJ4FLM97u4n1zImBHRYIQFUpYj0Yt9GaiRsdglJaZh+pponQxgG/vlvycP0fwpVq4s8
 TtkzxWxCRg9Ziy49i5vq94YQZTfGLTMl3kq7LTlyiE9nDwZn4XkFc5W4M2cY70eZSi9ROp8J0CT
 sVQLXbyC7rXJ0KQTrXD+jecKgOSXY43pORWOcxyXIBFzSvT7sUPcBm4Z6lgghsX0P/HwPNL7bzt
 dDsJ6oHZo1ey9q/KLqae8/nHKsDW0NcdgW+EyJGaEJqHwE9c1sXMZiViAX2yYttfz8RtK8EpfXP
 3+9tXefkSNOUGzNnnIMZi859q5BzgVRejoyfdn+fJtai00GH/Av4+H+POtOKUlXuX3HgodIJe4u
 cm5rNZY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180147

Add device tree binding for Qualcomm Coresight Interconnect Trace
Network On Chip (ITNOC). This TNOC acts as a CoreSight
graph link that forwards trace data from a subsystem to the
Aggregator TNOC, without aggregation or ATID functionality.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 .../bindings/arm/qcom,coresight-itnoc.yaml         | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a3b5f2b949f69617a014d0ae2831c9c767178f8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml
@@ -0,0 +1,96 @@
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
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
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


