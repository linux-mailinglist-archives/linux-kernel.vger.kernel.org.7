Return-Path: <linux-kernel+bounces-789612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 706B9B39838
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510A87B2A61
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150DB2EACF0;
	Thu, 28 Aug 2025 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LMiOlCT0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D12E03EC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373251; cv=none; b=bDKkh/aU19NV/GSHKZRXOWJu/lty7f/qzuQ7VjU861S0qltgtuGwKJcRnonJngqJmpLJ9RR67e2Nln6u2WPI1uZ4ODW42zklYoX5ftRLiFEcUYyuf1sVtNjVp9a2qSxpEuw7IX0IK6MNPqcnuzxx/aGvyUSlQYd0FJOFDhRiZjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373251; c=relaxed/simple;
	bh=ubXxXSq3HRpwyGgZB9pVBtD7LlF/Et+jBwYXGMM3AgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cz4K2384ZNnUQxBmQw8PuivLsATpr1+hGaeHgu5GcHAyiH0yJZN4+GXqftYlpUrKdT1OQ3JUUVH5frqHxrsOeG9tZ5jA+ozMkAKZjIekXEB0V52f6JXJRh6rZ9TLbgXsffboSkfaUC8KMROvS6hgvm0p+pHE3StXWqtaSkEN0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LMiOlCT0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5NqQ6029178
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5RBCQZAQQ3qbcPWi42TsUywUHN03HVpohWHspiY+9TU=; b=LMiOlCT0S04iqj/M
	7w+l3wHyTY3M9Te/rVK14U4cUyYxVR0uN+cAgQzCb3pAcABaK3fZ52hKSLqLyb0V
	3gy+MtcermJl5oqY+A5Xrvbcms3M43cogbmOKvpjfzeTpOxzHdO+0u+P+arChA8T
	D6fDq/4a3E+jbvJUzHMQzzzd311QgmtA8VYBjY+3VUgi/ML8IrBF+w7zIA6T9Ci6
	WXW8Vm/5ydGCyE51HKa9SoSIcwVCuD98WpTqdQW23nJsva9kwiqCPb4qiU6bCr0V
	LCSeLS+k+Wearw1FKPxyjVxONSzynfdLVkFgn28M/7/8vs+pD1sLP4SfUHDh1TZT
	5oo6Bw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5umfugs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:27:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-248981c02cfso8953485ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756373248; x=1756978048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RBCQZAQQ3qbcPWi42TsUywUHN03HVpohWHspiY+9TU=;
        b=nGcxkPv+FVliSUGmh57tbpGL/mJ+b4bdVxBWTYs2rI2l9KjL9k53BOL7ljcyhhtxu8
         2Nq0juGcKdqHORcU5LECwvKKFD1pl2h99g5qUwaXbeA/gxS4c6J3NfoEVMmIBchit0Lk
         sZnZFz4sTkUOiEaCFzKOyOTsFEqkJgQFfhP8oUw19UWrO6nI689CdCCdK7cnZtwK5J48
         7BmDYFiM1l65R3dbrnsxdhWipM/9CZHgD/BHCW1L0wCKiv7qap3K+xjFhaR+cuqBuAJL
         BViMn4I6zIy36Rg8feCsBMKrW/PjxJWa+H+4CDcYQ2Mbvk10KsN5TKWGdlQDtTUCIJiO
         +3Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWixBRQWzTOd5/Q/Ncidf/u80v/jT2ToVPzshqM2jrmQ/gONzOX9UyPXRAAAW95IC+4KAM8WmcungVeNeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1hbkDyznuEh4ZltpxaX5Rv1K3UaenlZ7Pgq0iqwR/NL+bPOCb
	N+8nX3axeFE0wgrAcT4ovrsVm4Wd2LSqxEHxXB5iXNmM6gmycXwtHidEgXt0+IIMMB6MuZKws/W
	U5wYMu6/WUXTcjDhyEEqrM2DB3LaXKhELvaoQaeM3Nf/XsAha5w8fBHLBZkMnVcsJBms=
X-Gm-Gg: ASbGncufg95n9uUEqQCsSMww21vksIkbJIlAyNcEzJgjixuXT3tkk54XJexcnt8ahrn
	FfhmzPEATLu3x+J7sQd2Cq7+IZxC3nUCeFCdgcG6Nu+JdTa9vq9NBWWSh/WsLnLNlbGVW3VFvBD
	AnLJOwJxl/dAwB46RijKSyq1F5zzK0L174gatkRuQkQYjo1qlYjVKH0b27jARTJCAyGXmecm260
	tud7Rj8/tTeHji8HMAX70VWvLXolrM9mIROAXuhbDZ/XP3T0vScP1nuCp6/hDkShzNHclWdMysl
	AtsNVKzUG4ZGAQxXuhiY8EZLjFEijd+q16CktSqwe+fQBd6cBYKRLUdWpwiCICVk1UdaqX5gHQw
	RsZiW+fCEaePPnfeoztCuVw==
X-Received: by 2002:a17:902:ecc6:b0:243:12d5:db43 with SMTP id d9443c01a7336-2462eb44c45mr315240685ad.0.1756373248071;
        Thu, 28 Aug 2025 02:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhgSpOuOEMqNem7SfvViYQxUPC2kynQsuvn/YrvRYMejOOvFbxYueIAMEDlNDix/TQ6ccBgQ==
X-Received: by 2002:a17:902:ecc6:b0:243:12d5:db43 with SMTP id d9443c01a7336-2462eb44c45mr315240355ad.0.1756373247541;
        Thu, 28 Aug 2025 02:27:27 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246ed91ee20sm92497015ad.136.2025.08.28.02.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:27:27 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 02:27:22 -0700
Subject: [PATCH v3 1/3] dt-bindings: arm: qcom: Add Coresight Interconnect
 TNOC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-itnoc-v3-1-f1b55dea7a27@oss.qualcomm.com>
References: <20250828-itnoc-v3-0-f1b55dea7a27@oss.qualcomm.com>
In-Reply-To: <20250828-itnoc-v3-0-f1b55dea7a27@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756373245; l=3025;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=ubXxXSq3HRpwyGgZB9pVBtD7LlF/Et+jBwYXGMM3AgA=;
 b=Zgwlt3jRD02lL12U66KU4jhzO1e2GLLqoZX5wl63ys0VNVc0JVoilJq8ycPw8K9YZrM2ChWM9
 6TEHNPVDzgxDr88uDQC8FjEDBveI9a2wEv/4o604J5gJoL0jiXMHGkV
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68b02101 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=-QmmxQN2S_yWG1-YAlkA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfXx3kwYFxMF5xk
 xQeU5Pd5QUbABnRNuImWiz9QAKjcjBaejvFd+BcbBmgJMr2onAl7ghl+yl3y0tkjfKlxltugkJR
 kOpDBTxcvIgD4v6XVBSWzBurlZvqyZMKUuAUN3D3/SUP7dgeF9bVFWjy/KueySNW0JA4tCyzJFn
 kIwfyU8fL8MbE5hmkNBYQe2YhJNnvnnt228D06FaC5lorWAbET8igeiYj55oqmMZrIVGQr4vnKK
 KwyLlLnz+12y7eFNzcz1yAkYnj59y273c/dfk2F4tzABHPxTHwJKKnM/knBV0JnZPc8dOGyDnTs
 96+pekMfxE+U1VhAfgUKMnxQ8yBczkpw0v0D1DcF404KI7D6Vn7V9tKGG3+/RvEXxLmz6hDk1oi
 cs+2VRgr
X-Proofpoint-GUID: GGRkIwEaMw7ViyXSszH720sbOI24zKKr
X-Proofpoint-ORIG-GUID: GGRkIwEaMw7ViyXSszH720sbOI24zKKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

Add device tree binding for Qualcomm Coresight Interconnect Trace
Network On Chip (ITNOC). This TNOC acts as a CoreSight
graph link that forwards trace data from a subsystem to the
Aggregator TNOC, without aggregation or ATID functionality.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
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


