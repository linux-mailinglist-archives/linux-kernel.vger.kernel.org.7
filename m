Return-Path: <linux-kernel+bounces-769113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2453AB26A58
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3DDB603AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841E212B0C;
	Thu, 14 Aug 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pn7/385B"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5421C20FAB6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183279; cv=none; b=SVxaA/W4w8pu9QRa47dB7Jq1G77SNy2GNy15jFJAoGVuLsxrGNfo1cJCmi8P5V1uGma18oG7yvMJ+t88HEY7qDQzzPzBk4dx1Y/+Z5joIy6qo5eMQoGGargzv0zIHeBLducOBFfpHiqInZuq0eqkEl4unfLIVaP4qiwm4jkeeK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183279; c=relaxed/simple;
	bh=12SsNMorDUGtYsRncSHM2gf9PHQYGgPW/2x4x1ku52Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Josi7VcNQK/3eUg80+YwdGTjQf4vziDVWj8YoKqrksMoRz81DmfRaVFSr3FMZWdaqABHnmQW8ruKq1+h+bAg0Qn1PTun0GQNj4qmphVLMnTSum/8SeYh3wB9TjrWFsvUFzRMvzhlFLBCqNIzUelV4bZSwK70/CNUzE0SEogt6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pn7/385B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8ssnY020597
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xxneBEWYYJ2VpkLEhHOlRFJVjUIqQWeHs0KiYqf7gI0=; b=pn7/385B7Cvrnmh6
	78dFucwVmeNvLL8kaUDd9JDn2FQNV1yFunvUCSBER34MRdnpNxDlCPvU54UXUJHi
	wvTZBihaNUPBOsZXFllRcwjx0neAYBgw3iWwd1Tf1TWXqajkM+R90hMcVgIvhVsr
	jIdJeXfnjF9BezjH8YLonKis/DAsbXZe8mMVcK47hZfcdk2eXmezj9wxJ/H8SKsJ
	sYi8J8TA/Ra5ux724AVkbjPSYiXkR8gcuI9FZgdYISe3szX3F10V2J4iRHlNE4iu
	QXsWgn910MFaWuyo3Y7lDqFhtx2SUU0YWjSy7kQeiPLvpryBn9cEcBLLC8tlsjun
	oeUEwA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmg2cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:54:34 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e5c4734so989873b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183273; x=1755788073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxneBEWYYJ2VpkLEhHOlRFJVjUIqQWeHs0KiYqf7gI0=;
        b=Pkbl1wn8VNsBq7m3CE4KniwdazZ6m7Kivowc2SIflWXlUCl464RvZGLuH2G65ITR1E
         FOch+UAWz5XYCUt8lD8BiIg+EzQqoRdVbZNdHXDsnW/jPKTm57eG/KT3MwoIQ0GOIOdk
         edCma+DpZNNPVvF3fz9HKNbcoUBqubW+BwKEzH0Iynoa+cEF5nUIdDcYV926+mBfJd0c
         pl0xO4N5Cdtj0EaEtHF/8qpjBFbc5frwXY7ubCjOeyr3rnJa8pYKY26ANgtgq90KlHA8
         Wcf0avBKqHk5IT5cRdCCLmPEj6Lsa0VRF8OwMO3FamduThqR575A16QL5N8vtFeZx5Dw
         qbEg==
X-Forwarded-Encrypted: i=1; AJvYcCWeHotazhmBZx7QxdRfGzWuS5dgoCJuil0mMCIHeCjttAqk14Jrp0N9A83tw6GFnhBn29vJK39JLRgKtOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN42PS3q1P7hDyUPl1t1StQZeNS/pdXDUx/4q/2w+GevvhftsW
	KovG04JMzq3r45KB0D9gsUdcY4rM4tiYVEGVl7gbxYrSawOOvg7Tj3eMlmUzo31ldcQWpxhSVM5
	2X3F2hTP6njOIVg1N05vaCHCMISoUP3fsgf591iIR8SMWUROxJDmQeVUpgPnJhJUBPrQ=
X-Gm-Gg: ASbGncsbBhFqhYUXtO+ioXj4LCDpJDlXTgCeAzXxX5sGkPXOkbz/z1s6PeVKqHCdTVq
	32RTjX0RUfZuWeju3UQOY9jxvQA+UbjXF9MAPmBBkb/3apJlqBSiFozvu3aWM5XY2iw9PskGylc
	nZWqwQhtZK9jk0RilYZ9ypKbv0Ebjq1qo80SehA3V25ZWbZq5bklS08pCOOZGR47OpDIR5XQRfC
	faq37l1KQdxQOdbqhn+GnBAGjKzBfqSr2j/gAFcsuB+cM3Tu0pYUqwecZbdyASoJEQmWbAvA/pf
	3jI39eDABraeLTZ3RhCsbF4i4QDa9raQESkubZL/bwBwefLgeBFBkFGvPRA5SoE=
X-Received: by 2002:a05:6a00:1aca:b0:76b:f8bc:a3a9 with SMTP id d2e1a72fcca58-76e2f928938mr4861291b3a.9.1755183273271;
        Thu, 14 Aug 2025 07:54:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrUMV/C+TOFlvu3kcV0geSGYsyQHjutTpxeJO/J4DXqrqGoxUJQ9mZb1zAvRGrCS3EH++BuQ==
X-Received: by 2002:a05:6a00:1aca:b0:76b:f8bc:a3a9 with SMTP id d2e1a72fcca58-76e2f928938mr4861253b3a.9.1755183272632;
        Thu, 14 Aug 2025 07:54:32 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76be718b2d6sm30715274b3a.56.2025.08.14.07.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:54:31 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 14:54:19 +0000
Subject: [PATCH v2 1/3] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Glymur SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-glymur-icc-v2-1-596cca6b6015@oss.qualcomm.com>
References: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
In-Reply-To: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Mike Tipton <mike.tipton@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX+LgCwqEzPuUO
 vYz1TdmbmoN7vGF93Xb+4w0mRNx2E4+JKGd7PkYgbyHgNGbmhNhT6RbVKgOtDYTQqdKNwuekUv8
 HWMxpL+bfOrWkdx2PT5/WTyTMcwMHu3A+tBqJKVYjkAif/cBUPTd9SMCcfc5u/gQBPYL4Lwb7u+
 u+d+pNKFi1fnAp8u4cuBR3fXqSk/zdKE4wNFrh5ejx7XZxLaGOHFYV8DybkBS59/Y67CI4zfu+q
 +Z4hKsRZF2qRHmiVcSHGXfsQ57+9kYIqX9xyUdVIl0NOyyXjQx4YSx/zMZ/ijnEIjqaq11KS4RO
 vn8QcBiepxvGovDm7V9qlzNAUARk+BqsN+pmeP6faC8TlL4xtSkwFm+MN8yWF06jNjITgQ2veaB
 fYibDIUf
X-Proofpoint-GUID: m0-YFxeiVrCnEjFfUR3y3G4tlDsVQY7u
X-Proofpoint-ORIG-GUID: m0-YFxeiVrCnEjFfUR3y3G4tlDsVQY7u
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689df8aa cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=5oJI0F23VaAtsYo4IHsA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

Document the RPMh Network-On-Chip Interconnect in Glymur platform.

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,glymur-rpmh.yaml    | 172 +++++++++++++++++
 .../dt-bindings/interconnect/qcom,glymur-rpmh.h    | 205 +++++++++++++++++++++
 2 files changed, 377 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..d55a7bcf5591eea79c173a12b12c659321ca3c2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
@@ -0,0 +1,172 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,glymur-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on GLYMUR
+
+maintainers:
+  - Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also: include/dt-bindings/interconnect/qcom,glymur-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,glymur-aggre1-noc
+      - qcom,glymur-aggre2-noc
+      - qcom,glymur-aggre3-noc
+      - qcom,glymur-aggre4-noc
+      - qcom,glymur-clk-virt
+      - qcom,glymur-cnoc-cfg
+      - qcom,glymur-cnoc-main
+      - qcom,glymur-hscnoc
+      - qcom,glymur-lpass-ag-noc
+      - qcom,glymur-lpass-lpiaon-noc
+      - qcom,glymur-lpass-lpicx-noc
+      - qcom,glymur-mc-virt
+      - qcom,glymur-mmss-noc
+      - qcom,glymur-nsinoc
+      - qcom,glymur-nsp-noc
+      - qcom,glymur-oobm-ss-noc
+      - qcom,glymur-pcie-east-anoc
+      - qcom,glymur-pcie-east-slv-noc
+      - qcom,glymur-pcie-west-anoc
+      - qcom,glymur-pcie-west-slv-noc
+      - qcom,glymur-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-clk-virt
+              - qcom,glymur-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-pcie-west-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre PCIE_3A WEST AXI clock
+            - description: aggre PCIE_3B WEST AXI clock
+            - description: aggre PCIE_4 WEST AXI clock
+            - description: aggre PCIE_6 WEST AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-pcie-east-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre PCIE_5 EAST AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre USB3 TERT AXI clock
+            - description: aggre USB4_2 AXI clock
+            - description: aggre UFS PHY AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-aggre4-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre USB3 PRIM AXI clock
+            - description: aggre USB3 SEC AXI clock
+            - description: aggre USB4_0 AXI clock
+            - description: aggre USB4_1 AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-pcie-west-anoc
+              - qcom,glymur-pcie-east-anoc
+              - qcom,glymur-aggre2-noc
+              - qcom,glymur-aggre4-noc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,glymur-gcc.h>
+    clk_virt: interconnect-0 {
+      compatible = "qcom,glymur-clk-virt";
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre1_noc: interconnect@16e0000 {
+      compatible = "qcom,glymur-aggre1-noc";
+      reg = <0x016e0000 0x14400>;
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre4_noc: interconnect@1740000 {
+      compatible = "qcom,glymur-aggre4-noc";
+      reg = <0x01740000 0x14400>;
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+      clocks = <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+               <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
+               <&gcc GCC_AGGRE_USB4_0_AXI_CLK>,
+               <&gcc GCC_AGGRE_USB4_1_AXI_CLK>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,glymur-rpmh.h b/include/dt-bindings/interconnect/qcom,glymur-rpmh.h
new file mode 100644
index 0000000000000000000000000000000000000000..6a0e754345e42576da1955fe9011af8a98cc1eaf
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,glymur-rpmh.h
@@ -0,0 +1,205 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_GLYMUR_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_GLYMUR_H
+
+#define MASTER_CRYPTO				0
+#define MASTER_SOCCP_PROC			1
+#define MASTER_QDSS_ETR				2
+#define MASTER_QDSS_ETR_1			3
+#define SLAVE_A1NOC_SNOC			4
+
+#define MASTER_UFS_MEM				0
+#define MASTER_USB3_2				1
+#define MASTER_USB4_2				2
+#define SLAVE_A2NOC_SNOC			3
+
+#define MASTER_QSPI_0				0
+#define MASTER_QUP_0				1
+#define MASTER_QUP_1				2
+#define MASTER_QUP_2				3
+#define MASTER_SP				4
+#define MASTER_SDCC_2				5
+#define MASTER_SDCC_4				6
+#define MASTER_USB2				7
+#define MASTER_USB3_MP				8
+#define SLAVE_A3NOC_SNOC			9
+
+#define MASTER_USB3_0				0
+#define MASTER_USB3_1				1
+#define MASTER_USB4_0				2
+#define MASTER_USB4_1				3
+#define SLAVE_A4NOC_HSCNOC			4
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define MASTER_QUP_CORE_2			2
+#define SLAVE_QUP_CORE_0			3
+#define SLAVE_QUP_CORE_1			4
+#define SLAVE_QUP_CORE_2			5
+
+#define MASTER_CNOC_CFG				0
+#define SLAVE_AHB2PHY_SOUTH			1
+#define SLAVE_AHB2PHY_NORTH			2
+#define SLAVE_AHB2PHY_2				3
+#define SLAVE_AHB2PHY_3				4
+#define SLAVE_AV1_ENC_CFG			5
+#define SLAVE_CAMERA_CFG			6
+#define SLAVE_CLK_CTL				7
+#define SLAVE_CRYPTO_0_CFG			8
+#define SLAVE_DISPLAY_CFG			9
+#define SLAVE_GFX3D_CFG				10
+#define SLAVE_IMEM_CFG				11
+#define SLAVE_PCIE_0_CFG			12
+#define SLAVE_PCIE_1_CFG			13
+#define SLAVE_PCIE_2_CFG			14
+#define SLAVE_PCIE_3A_CFG			15
+#define SLAVE_PCIE_3B_CFG			16
+#define SLAVE_PCIE_4_CFG			17
+#define SLAVE_PCIE_5_CFG			18
+#define SLAVE_PCIE_6_CFG			19
+#define SLAVE_PCIE_RSCC				20
+#define SLAVE_PDM				21
+#define SLAVE_PRNG				22
+#define SLAVE_QDSS_CFG				23
+#define SLAVE_QSPI_0				24
+#define SLAVE_QUP_0				25
+#define SLAVE_QUP_1				26
+#define SLAVE_QUP_2				27
+#define SLAVE_SDCC_2				28
+#define SLAVE_SDCC_4				29
+#define SLAVE_SMMUV3_CFG			30
+#define SLAVE_TCSR				31
+#define SLAVE_TLMM				32
+#define SLAVE_UFS_MEM_CFG			33
+#define SLAVE_USB2				34
+#define SLAVE_USB3_0				35
+#define SLAVE_USB3_1				36
+#define SLAVE_USB3_2				37
+#define SLAVE_USB3_MP				38
+#define SLAVE_USB4_0				39
+#define SLAVE_USB4_1				40
+#define SLAVE_USB4_2				41
+#define SLAVE_VENUS_CFG				42
+#define SLAVE_CNOC_PCIE_SLAVE_EAST_CFG		43
+#define SLAVE_CNOC_PCIE_SLAVE_WEST_CFG		44
+#define SLAVE_LPASS_QTB_CFG			45
+#define SLAVE_CNOC_MNOC_CFG			46
+#define SLAVE_NSP_QTB_CFG			47
+#define SLAVE_PCIE_EAST_ANOC_CFG		48
+#define SLAVE_PCIE_WEST_ANOC_CFG		49
+#define SLAVE_QDSS_STM				50
+#define SLAVE_TCU				51
+
+#define MASTER_HSCNOC_CNOC			0
+#define SLAVE_AOSS				1
+#define SLAVE_IPC_ROUTER_CFG			2
+#define SLAVE_SOCCP				3
+#define SLAVE_TME_CFG				4
+#define SLAVE_APPSS				5
+#define SLAVE_CNOC_CFG				6
+#define SLAVE_BOOT_IMEM				7
+#define SLAVE_IMEM				8
+
+#define MASTER_GPU_TCU				0
+#define MASTER_PCIE_TCU				1
+#define MASTER_SYS_TCU				2
+#define MASTER_APPSS_PROC			3
+#define MASTER_AGGRE_NOC_EAST			4
+#define MASTER_GFX3D				5
+#define MASTER_LPASS_GEM_NOC			6
+#define MASTER_MNOC_HF_MEM_NOC			7
+#define MASTER_MNOC_SF_MEM_NOC			8
+#define MASTER_COMPUTE_NOC			9
+#define MASTER_PCIE_EAST			10
+#define MASTER_PCIE_WEST			11
+#define MASTER_SNOC_SF_MEM_NOC			12
+#define MASTER_WLAN_Q6				13
+#define MASTER_GIC				14
+#define SLAVE_HSCNOC_CNOC			15
+#define SLAVE_LLCC				16
+#define SLAVE_PCIE_EAST				17
+#define SLAVE_PCIE_WEST				18
+
+#define MASTER_LPIAON_NOC			0
+#define SLAVE_LPASS_GEM_NOC			1
+
+#define MASTER_LPASS_LPINOC			0
+#define SLAVE_LPIAON_NOC_LPASS_AG_NOC		1
+
+#define MASTER_LPASS_PROC			0
+#define SLAVE_LPICX_NOC_LPIAON_NOC		1
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+
+#define MASTER_AV1_ENC				0
+#define MASTER_CAMNOC_HF			1
+#define MASTER_CAMNOC_ICP			2
+#define MASTER_CAMNOC_SF			3
+#define MASTER_EVA				4
+#define MASTER_MDP				5
+#define MASTER_CDSP_HCP				6
+#define MASTER_VIDEO				7
+#define MASTER_VIDEO_CV_PROC			8
+#define MASTER_VIDEO_V_PROC			9
+#define MASTER_CNOC_MNOC_CFG			10
+#define SLAVE_MNOC_HF_MEM_NOC			11
+#define SLAVE_MNOC_SF_MEM_NOC			12
+#define SLAVE_SERVICE_MNOC			13
+
+#define MASTER_CPUCP				0
+#define SLAVE_NSINOC_SYSTEM_NOC			1
+#define SLAVE_SERVICE_NSINOC			2
+
+#define MASTER_CDSP_PROC			0
+#define SLAVE_NSP0_HSC_NOC			1
+
+#define MASTER_OOBMSS_SP_PROC			0
+#define SLAVE_OOBMSS_SNOC			1
+
+#define MASTER_PCIE_EAST_ANOC_CFG		0
+#define MASTER_PCIE_0				1
+#define MASTER_PCIE_1				2
+#define MASTER_PCIE_5				3
+#define SLAVE_PCIE_EAST_MEM_NOC			4
+#define SLAVE_SERVICE_PCIE_EAST_AGGRE_NOC	5
+
+#define MASTER_HSCNOC_PCIE_EAST			0
+#define MASTER_CNOC_PCIE_EAST_SLAVE_CFG		1
+#define SLAVE_HSCNOC_PCIE_EAST_MS_MPU_CFG	2
+#define SLAVE_SERVICE_PCIE_EAST			3
+#define SLAVE_PCIE_0				4
+#define SLAVE_PCIE_1				5
+#define SLAVE_PCIE_5				6
+
+#define MASTER_PCIE_WEST_ANOC_CFG		0
+#define MASTER_PCIE_2				1
+#define MASTER_PCIE_3A				2
+#define MASTER_PCIE_3B				3
+#define MASTER_PCIE_4				4
+#define MASTER_PCIE_6				5
+#define SLAVE_PCIE_WEST_MEM_NOC			6
+#define SLAVE_SERVICE_PCIE_WEST_AGGRE_NOC	7
+
+#define MASTER_HSCNOC_PCIE_WEST			0
+#define MASTER_CNOC_PCIE_WEST_SLAVE_CFG		1
+#define SLAVE_HSCNOC_PCIE_WEST_MS_MPU_CFG	2
+#define SLAVE_SERVICE_PCIE_WEST			3
+#define SLAVE_PCIE_2				4
+#define SLAVE_PCIE_3A				5
+#define SLAVE_PCIE_3B				6
+#define SLAVE_PCIE_4				7
+#define SLAVE_PCIE_6				8
+
+#define MASTER_A1NOC_SNOC			0
+#define MASTER_A2NOC_SNOC			1
+#define MASTER_A3NOC_SNOC			2
+#define MASTER_NSINOC_SNOC			3
+#define MASTER_OOBMSS				4
+#define SLAVE_SNOC_GEM_NOC_SF			5
+
+#endif

-- 
2.43.0


