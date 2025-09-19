Return-Path: <linux-kernel+bounces-824659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3178DB89D01
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25F81BC82BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBB3313E0F;
	Fri, 19 Sep 2025 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D6LdSlJh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B5313D73
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291012; cv=none; b=RkrHsv/zmTzsKoy5VNtexHEpG2wqE1lRV2/Zhf/z6jKbVkv54400GjUSlS0qEBq+4xRhYYL9GdUrfB5NTM/iGDw7quIKQdnQhtmijeT0mmoEDetRExt6bU175IRLFwoywjeUrj0CdLAFQdyk+c963GoI2Moo3OQt67uJLxsJ1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291012; c=relaxed/simple;
	bh=Ftr7Rk2E1qjIyAAxEeFjq3bv/Y1G9PinJpwEVFKfAsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K6wu2wYjZOIiqHbs64v1eUGQPoBnJsK4ubRvMtPhzQ127ie0COTKPNCU+ubug8orDX/DPUyIVBGu6e9P3chigr9m/l2lQryK3D2+/hdoB+T88m74w1uC7q9cKlETUQgFByebYVTPJMl3SgVEH0omrkQGgKd6MSJEwj/O5Z5L2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D6LdSlJh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JA4IG2007410
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=aU9rrRsxGZJ5bX1FLuguMvGEjwygXeBO7pH
	/6CBxlLU=; b=D6LdSlJhpc+XiY64JauFr8ypgVbgv7P8ZdpFhuLKe9EPPFpsU3K
	ns8NKvi/65CNTkcxJqTd0mMHeki/aW/IAdAeOdo0rm53+r9tAwIcqm2grBH/cJLI
	ZAiZZF7KivCkaow5i0S/seO/exGgAnyVRnGw5eSUbQhd9fUVGoTyOcSJb0YFFcV2
	uuMvi+HUKMpj7EEFrQ8vvRDWZxV9hYxWMFCmqCjkNIpj+4U9EPPbZO2QetGbZNxl
	4aGbgKE63aa3pnKtSFORw22Vw/3EGjRb99DJ6Qw2U7Mhsk1GZA5cjV0loRXUgJof
	lzbGPcTFAsPDU+jLmoFFGjKSPQ5zsowjjzg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498ebew5kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:10:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so2118788a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291009; x=1758895809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aU9rrRsxGZJ5bX1FLuguMvGEjwygXeBO7pH/6CBxlLU=;
        b=cDHsqrUyiBKsBgt5WHq4yfPfPCG+8SokTHa9Fd/+C1zsclG+E6SYzntzxnmKzcSHah
         oVyNqadqEMcJcR5GDHTFGCTH1ChngZ6O8+ewzLkpwesZDZwM+n6yJ5G0MbjrGk6gcSVJ
         26lkvGSYbq05XVhK2ltcornGchiTEEedJ94Mbq49OlG//4+EXV/IAozV/L7PVGCs2W9o
         X5QoHC7gqYk+C3adQLjpRLw3LckIQu+6AcdS4n0jw0bUhKIgP9lgJ/eB1XN6h1SNOoVu
         MNmH7w+mp541MwO++GvhyfDMM/o8KRAw9xkAPcT6QDfARAhmvltvSYeLVnDFwayl8sxm
         QVzg==
X-Forwarded-Encrypted: i=1; AJvYcCV0ggQfulvl3JQ2bOY1CirSeSGUopBuZgYMMKJeUJjxr+zE+8R7TB+ol/equm9pFjHw0z5doJdU3c41SnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRSq0e7yMgExjOTcp4Zfjxp+3K7j8IKHv46fp2rqS2VeBJnT3V
	raKWRy4V7n97CyZK+E/yk/ELMJcwtmfJQzaKAKjUOM4MTT5G886APIeX52kntQhFz8AP81CMIVf
	zyIxrkbFSeVEipHqpwTGsV1bsHdM53xORtpxFLBNRRca4b2+rQSX7XXm2lDc2cfg/5L/M/32W6x
	E=
X-Gm-Gg: ASbGncuLOHdUw5K2AE6+bDsCvRdqizuqxlkcJIOBJqh59zpOd3/UuxqGTusUmGCFsOj
	pyLyPamZsS2p04pSHT7W9eczOWDMfXt7owMqhKWocP0cMh8+SxZVO5YZHPzB+J+75dvAJu720bS
	NDnkaCs2EaG7LOzkf7hnhU4Kdz03BI5gWZhC2DRTNUlz4Kj77XrgRBnteAApFr5SMzTdq5I849w
	BCjZTo3KPiGTLLAFwmbr+TT711/RP7/Usj3nMgPwwhTmZ8LuWoPdESIhtw5WTgVSa00Qfyqc+h/
	wT0A/7Uy0zwjb9wh5CAl4pdJpFSJ/oQqZsmrU3k2keZQv9Bktoxfh/V/raUW5AeZQTbM5j66hB/
	8jvu9BHDgg/CsOMU5R48M+Zi+LEtW0twhcIxXOiNkbe5VK5PqH11x+qrGyEE1
X-Received: by 2002:a17:90b:3e86:b0:32b:cafc:e339 with SMTP id 98e67ed59e1d1-33098398714mr3989295a91.36.1758291008725;
        Fri, 19 Sep 2025 07:10:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErQzIaSQcEsJdQnvxCy8h4m+hTnW8xaHFZBBjCr29z5XzZ5zG99MiqrvIyNHbXCP515qCgpQ==
X-Received: by 2002:a17:90b:3e86:b0:32b:cafc:e339 with SMTP id 98e67ed59e1d1-33098398714mr3989250a91.36.1758291008086;
        Fri, 19 Sep 2025 07:10:08 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060619245sm5644272a91.1.2025.09.19.07.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:10:07 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: spmi: add bindings for glymur-spmi-pmic-arb (arbiter v8)
Date: Fri, 19 Sep 2025 19:39:52 +0530
Message-Id: <20250919140952.1057737-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: L-dyiCnwFarAcE2rTx4dU1WTSOJ0fE9T
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cd6441 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=t41Tp4pyULMMg2XcS3IA:9 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: L-dyiCnwFarAcE2rTx4dU1WTSOJ0fE9T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX3pc7dSmjf/jQ
 dQofrsmaoh9/lcFOA4BlEwSCdoBGrc/EiQOJQbHSlq3cOEF/rNsk3MNXYf/Wj9w6eYcD/VD07tf
 /nOVjiJa1OnS3mVLbuCz0T+zBtd/urt9SbKVh7iLmBcWcwMSVeebSEfHeVvw9R24+N3D4olUmsm
 siZ7G4o1Nz/aeD+rbAnVWuvRi8F7mr5pKC1foY0Ho+Zd+2oT7mX1n5vKN/glHRwi1PneEXEcSKC
 td/6T8oj8WjWREqSxORYY0X5wKDVYHdYyY5F5IMk7fP9LG1qsCxyYgKBwGqnL/AdNNBM04XAywd
 7pmyAvb98MhLNTn+3VWXA7Euw15fSvEGS7y1hUkLg9gOHbJEYIEZTGh/w3zTPNgtqu1mp4HWbxn
 g46Xczg2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074

From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

SPMI PMIC Arbiter version 8 builds upon version 7 with support for
up to four SPMI buses.  To achieve this, the register map was
slightly rearranged.  Add a new binding file and compatible string
for version 8 using the name 'glymur' as the Qualcomm Technologies,
Inc. Glymur SoC is the first one to use PMIC arbiter version 8.  This
specifies the new register ranges needed only for version 8.

Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 .../spmi/qcom,glymur-spmi-pmic-arb.yaml       | 158 ++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spmi/qcom,glymur-spmi-pmic-arb.yaml

diff --git a/Documentation/devicetree/bindings/spmi/qcom,glymur-spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,glymur-spmi-pmic-arb.yaml
new file mode 100644
index 000000000000..e80997a5fb4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spmi/qcom,glymur-spmi-pmic-arb.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spmi/qcom,glymur-spmi-pmic-arb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. Glymur SPMI Controller (PMIC Arbiter v8)
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+
+description: |
+  The Glymur SPMI PMIC Arbiter implements HW version 8 and it's an SPMI
+  controller with wrapping arbitration logic to allow for multiple on-chip
+  devices to control up to 4 SPMI separate buses.
+
+  The PMIC Arbiter can also act as an interrupt controller, providing interrupts
+  to slave devices.
+
+properties:
+  compatible:
+    enum:
+      - qcom,glymur-spmi-pmic-arb
+
+  reg:
+    items:
+      - description: core registers
+      - description: tx-channel per virtual slave registers
+      - description: rx-channel (called observer) per virtual slave registers
+      - description: channel to PMIC peripheral mapping registers
+
+  reg-names:
+    items:
+      - const: core
+      - const: chnls
+      - const: obsrvr
+      - const: chnl_map
+
+  ranges: true
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+  qcom,ee:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 5
+    description: >
+      indicates the active Execution Environment identifier
+
+  qcom,channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 5
+    description: >
+      which of the PMIC Arb provided channels to use for accesses
+
+patternProperties:
+  "^spmi@[a-f0-9]+$":
+    type: object
+    $ref: /schemas/spmi/spmi.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        items:
+          - description: configuration registers
+          - description: interrupt controller registers
+          - description: channel owner EE mapping registers
+
+      reg-names:
+        items:
+          - const: cnfg
+          - const: intr
+          - const: chnl_owner
+
+      interrupts:
+        maxItems: 1
+
+      interrupt-names:
+        const: periph_irq
+
+      interrupt-controller: true
+
+      '#interrupt-cells':
+        const: 4
+        description: |
+          cell 1: slave ID for the requested interrupt (0-15)
+          cell 2: peripheral ID for requested interrupt (0-255)
+          cell 3: the requested peripheral interrupt (0-7)
+          cell 4: interrupt flags indicating level-sense information,
+                  as defined in dt-bindings/interrupt-controller/irq.h
+
+required:
+  - compatible
+  - reg-names
+  - qcom,ee
+  - qcom,channel
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        arbiter@c400000 {
+            compatible = "qcom,glymur-spmi-pmic-arb";
+            reg = <0x0 0xc400000 0x0 0x3000>,
+                  <0x0 0xc900000 0x0 0x400000>,
+                  <0x0 0xc4c0000 0x0 0x400000>,
+                  <0x0 0xc403000 0x0 0x8000>;
+            reg-names = "core", "chnls", "obsrvr", "chnl_map";
+
+            qcom,ee = <0>;
+            qcom,channel = <0>;
+
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+
+            spmi@c426000 {
+                reg = <0x0 0xc426000 0x0 0x4000>,
+                      <0x0 0xc8c0000 0x0 0x10000>,
+                      <0x0 0xc42a000 0x0 0x8000>;
+                reg-names = "cnfg", "intr", "chnl_owner";
+
+                interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
+                interrupt-names = "periph_irq";
+                interrupt-controller;
+                #interrupt-cells = <4>;
+
+                #address-cells = <2>;
+                #size-cells = <0>;
+            };
+
+            spmi@c437000 {
+                reg = <0x0 0xc437000 0x0 0x4000>,
+                      <0x0 0xc8d0000 0x0 0x10000>,
+                      <0x0 0xc43b000 0x0 0x8000>;
+                reg-names = "cnfg", "intr", "chnl_owner";
+
+                interrupts-extended = <&pdc 3 IRQ_TYPE_LEVEL_HIGH>;
+                interrupt-names = "periph_irq";
+                interrupt-controller;
+                #interrupt-cells = <4>;
+
+                #address-cells = <2>;
+                #size-cells = <0>;
+            };
+        };
+    };
-- 
2.34.1


