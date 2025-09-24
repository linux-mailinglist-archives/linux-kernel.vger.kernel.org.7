Return-Path: <linux-kernel+bounces-831354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6F6B9C700
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8C31BC25A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD70929D26D;
	Wed, 24 Sep 2025 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kG1zaHMx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E1826F2BE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754985; cv=none; b=oKkVH3wkCtodOgB4+Sd6AhUt27IegbZQbzUX9Cy3D4fEBvJkdxNp4nUBOzMhKs/YhHwABkoRLvL14DXIMNkqMdCVy2ayIwKOa8ZxXvOH6FjpvYTgrPMI5+0R86GEDMxENvGBQ95UbTMJ66UIx64xjQhCDGATNgcVgUBpxrEmbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754985; c=relaxed/simple;
	bh=fD2RlJ7Mi+wF8sPF97LgE+34k8yMXWm/dcaOGS6b63Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gNHAV+/5sDkETR+dW9dCTf//o0fzW7tK4RxAR4hpx0EFDizInxkSrBeubMrjlXONbuHpyZhR4q6ldeysomydd3Qi9mt1W3F4WEMabRU/WqfvGuP3gDiTi05AU4najNKh7TMK2sU0vB6lejL3U2uI9mpJGnHbXdMii70s2WWYyH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kG1zaHMx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCq2cW021483
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Lp8xCNyvq/Qll0MsIImFC7QqvtnHYp9eHlSKxl/08k=; b=kG1zaHMxEFxpZPY0
	+1PvxCSjLjuHaP9YAJgoV4ToLM9FXBr5vzKS386UJSGSLBPfCILiaXqcOzmP4u+s
	FZwGj1HU+ghCD8wzS/NYPW03lqEZt9nQRndFaTNaUArQP3WQq7q5T+pZpA8OTf6L
	HKvcYMk1FdwlJlxmPR5XovbIDydVj7OTOAQ1mmvkHyfM+VsiMEvPhJlVCtQLSyVO
	9n4VPrBR/nW0wZUoiuOKjoNnsKBgyfj8mZEtrRCvfhlauCkC9ZmAIa6cisEhisE+
	/X0xQkYo5KMnwGrvH3gBr8bXDaGCqKpk1MvVRP2juakUhDH26aJcnGCE4qjwewiu
	TY7HzA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budadhmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:03:01 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33428befbbaso369781a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754981; x=1759359781;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Lp8xCNyvq/Qll0MsIImFC7QqvtnHYp9eHlSKxl/08k=;
        b=kRtihrjyDa68sSxAtf1AfemHiIplCRi0R1EnUIzG+nahPHbE+4vJngzn8g9R/fcBcj
         r0Cw5Td/u91d5utyITTPgRP8pdgAtWq5UA3vEJsJantNg8joFEMa3n6NisrPdOLXz3eN
         9NadMOqOmz+B1XL9E8ym307CyxcS0wfxLvtIcNzpmm5bY/a3YGu84e6kAuoNWqcw19yQ
         MWEi9By1TyQ8nZhK1/kLTaXfKZ1QynxwHkSs+CxrXctl4OBWy3WGDTyXALirHL3qOZFj
         CCXcCDP6aeEOA6nNmdR2h460hvhlrWyYGFJ7Q0Z7D7UZWCBnsAkXniDTfpUbc4V1/pLe
         9mbw==
X-Forwarded-Encrypted: i=1; AJvYcCWeCMkCT0bXegHjm2F3mxNLhlvjRQN0cW758Wr+RQ5Pup+WAX9o80tyA7uyXXoYY1Nr04RGQlXBWBOCvVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG6L7d3dFFEY5Fu6c7S8meXBL47dup33Sv7BsSzkY8AFP1UAcQ
	qmcmAb7mxJnL2PfxAGEcYBdQuITEhNgetCVLpj3kqjzqLqhnhML2174B6kumEQvRVMl+SyI3CNj
	dYFHZDkYpxTRWRT8seSdgq3qyvcRzJ8d5Hil1vO6cRfmeJ4RFwN+utYSW3vfRS0X94t4=
X-Gm-Gg: ASbGnctQ4d1FV6e3TvBb2jw2rerQq3srbJc82yXiTPIkujkiMjThasFsR6fQDHPNh3w
	MuoM1vK8w5h/8lM9rluIUZDdPGHWCmt3aKo+qW5cDkmVibNPMSDaptXawG3dMIOcD2vFnCUsD7g
	x44Eq+mlx0oZ+w/3vhrb3gfTgxr03jqUEH8O+aUOYokThEZSicaGhsv6k/S1L3wIXY70IPl//Z0
	yIxGIPJjn9Eq0Ddc9HujYgO5AwJB1Askto5WvE5a9UDvVqeyY/v0SqowbdA3QeW7HJfCENezgie
	BdcE9sXw2SBEW0Rt4/D6n9Gm+KmU2J6dJoqYebaQmlQIeHmlPIQBMAvWYBDtV0xJ5lltyN/GbmL
	Ma3n3V5ZOCdKox+g=
X-Received: by 2002:a17:90b:1e0d:b0:32e:a3bf:e606 with SMTP id 98e67ed59e1d1-3342a2e3a70mr1170486a91.28.1758754980201;
        Wed, 24 Sep 2025 16:03:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2vn/P15Zhcf9gm82c0SkJfTJNe98iufykO+es9ICEAjpWKLP360P78bW6A4XXBWY6dnLcnw==
X-Received: by 2002:a17:90b:1e0d:b0:32e:a3bf:e606 with SMTP id 98e67ed59e1d1-3342a2e3a70mr1170448a91.28.1758754979413;
        Wed, 24 Sep 2025 16:02:59 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347472e49esm153255a91.21.2025.09.24.16.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:02:58 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:02:44 -0700
Subject: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Kaanapali SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com>
References: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
In-Reply-To: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758754976; l=8853;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=mAAw7NKs3aiI1VIev5VzKZTrEETlLAl1ba2gOlY+Zak=;
 b=GylgsCphlaLdzxHAOsuwstNg/f41OlVS4GteuGU4rQDuDcgs67PEqioODUFUnoErDAmoiiMkD
 E6mOXjEuBaDAq4Rg+sOMufH4RbC6UhiGB+gH0ZISS1MDxBMhaU0J55T
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: cfPQ-IZSqQCsWSxyHlikLxXTMDJVuoiu
X-Proofpoint-ORIG-GUID: cfPQ-IZSqQCsWSxyHlikLxXTMDJVuoiu
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d478a5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=pnnlLcg_eiY5x_Nf-RwA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX7w649cN+P4Zb
 bGP/GiisbqUxKUHsbVxdX3uWwDQ6taZ+nJP+8oQFtYmGxLmuTWQI91FnNi6+gmiN9vVsBvWh444
 KC2l99ewtzyovDUuZWw6Jb0PF0lSvurvSWjxuMSKYdfbxsU5zT3SBvCwifAUv+y8UQUJ3Gpxn14
 RDMs3XSav2fns838AFHTXwrq4OIeED8yBv0hq66oSjekn7iu96C38o5a24a19QbA4VgfwxDAs9t
 MK5ORSvsYDRs8LxXmX7M6HA7CSnUhp9oWhzTdzhzScW2c68gNbZdXuU12nooYNtRMbm+N0HQu4t
 0M9Ek/h36PLKWvNZ3XGtWUj/fC/LGKUIszbdTDNzpzkztLVZIWbNkejoSAMPaeir7TFdxWOeuFL
 7NGlwhLo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>

Document the RPMh Network-On-Chip Interconnect of the Kaanapali platform.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,kaanapali-rpmh.yaml | 126 +++++++++++++++++
 .../dt-bindings/interconnect/qcom,kaanapali-rpmh.h | 149 +++++++++++++++++++++
 2 files changed, 275 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml
new file mode 100644
index 000000000000..574150cc4930
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,kaanapali-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on KAANAPALI
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
+  See also: include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,kaanapali-aggre-noc
+      - qcom,kaanapali-clk-virt
+      - qcom,kaanapali-cnoc-main
+      - qcom,kaanapali-cnoc-cfg
+      - qcom,kaanapali-gem-noc
+      - qcom,kaanapali-lpass-ag-noc
+      - qcom,kaanapali-lpass-lpiaon-noc
+      - qcom,kaanapali-lpass-lpicx-noc
+      - qcom,kaanapali-mc-virt
+      - qcom,kaanapali-mmss-noc
+      - qcom,kaanapali-nsp-noc
+      - qcom,kaanapali-pcie-anoc
+      - qcom,kaanapali-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 3
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
+              - qcom,kaanapali-clk-virt
+              - qcom,kaanapali-mc-virt
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
+              - qcom,kaanapali-pcie-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre-NOC PCIe AXI clock
+            - description: cfg-NOC PCIe a-NOC AHB clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,kaanapali-aggre-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB3 PRIM AXI clock
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,kaanapali-aggre-noc
+              - qcom,kaanapali-pcie-anoc
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
+    #include <dt-bindings/clock/qcom,kaanapali-gcc.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clk_virt: interconnect-0 {
+      compatible = "qcom,kaanapali-clk-virt";
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre_noc: interconnect@16e0000 {
+      compatible = "qcom,kaanapali-aggre-noc";
+      reg = <0x016e0000 0x42400>;
+      #interconnect-cells = <2>;
+      clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+               <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+               <&rpmhcc RPMH_IPA_CLK>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h b/include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h
new file mode 100644
index 000000000000..dde3f9abd677
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_KAANAPALI_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_KAANAPALI_H
+
+#define MASTER_QSPI_0				0
+#define MASTER_CRYPTO				1
+#define MASTER_QUP_1				2
+#define MASTER_SDCC_4				3
+#define MASTER_UFS_MEM				4
+#define MASTER_USB3				5
+#define MASTER_QUP_2				6
+#define MASTER_QUP_3				7
+#define MASTER_QUP_4				8
+#define MASTER_IPA				9
+#define MASTER_SOCCP_PROC			10
+#define MASTER_SP				11
+#define MASTER_QDSS_ETR				12
+#define MASTER_QDSS_ETR_1			13
+#define MASTER_SDCC_2				14
+#define SLAVE_A1NOC_SNOC			15
+#define SLAVE_A2NOC_SNOC			16
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define MASTER_QUP_CORE_2			2
+#define MASTER_QUP_CORE_3			3
+#define MASTER_QUP_CORE_4			4
+#define SLAVE_QUP_CORE_0			5
+#define SLAVE_QUP_CORE_1			6
+#define SLAVE_QUP_CORE_2			7
+#define SLAVE_QUP_CORE_3			8
+#define SLAVE_QUP_CORE_4			9
+
+#define MASTER_CNOC_CFG				0
+#define SLAVE_AHB2PHY_SOUTH			1
+#define SLAVE_AHB2PHY_NORTH			2
+#define SLAVE_CAMERA_CFG			3
+#define SLAVE_CLK_CTL				4
+#define SLAVE_CRYPTO_0_CFG			5
+#define SLAVE_DISPLAY_CFG			6
+#define SLAVE_EVA_CFG				7
+#define SLAVE_GFX3D_CFG				8
+#define SLAVE_I2C				9
+#define SLAVE_I3C_IBI0_CFG			10
+#define SLAVE_I3C_IBI1_CFG			11
+#define SLAVE_IMEM_CFG				12
+#define SLAVE_IPC_ROUTER_CFG			13
+#define SLAVE_CNOC_MSS				14
+#define SLAVE_PCIE_CFG				15
+#define SLAVE_PRNG				16
+#define SLAVE_QDSS_CFG				17
+#define SLAVE_QSPI_0				18
+#define SLAVE_QUP_1				19
+#define SLAVE_QUP_2				20
+#define SLAVE_QUP_3				21
+#define SLAVE_QUP_4				22
+#define SLAVE_SDCC_2				23
+#define SLAVE_SDCC_4				24
+#define SLAVE_SPSS_CFG				25
+#define SLAVE_TCSR				26
+#define SLAVE_TLMM				27
+#define SLAVE_UFS_MEM_CFG			28
+#define SLAVE_USB3				29
+#define SLAVE_VENUS_CFG				30
+#define SLAVE_VSENSE_CTRL_CFG			31
+#define SLAVE_CNOC_MNOC_CFG			32
+#define SLAVE_PCIE_ANOC_CFG			33
+#define SLAVE_QDSS_STM				34
+#define SLAVE_TCU				35
+
+#define MASTER_GEM_NOC_CNOC			0
+#define MASTER_GEM_NOC_PCIE_SNOC		1
+#define SLAVE_AOSS				2
+#define SLAVE_IPA_CFG				3
+#define SLAVE_IPC_ROUTER_FENCE			4
+#define SLAVE_SOCCP				5
+#define SLAVE_TME_CFG				6
+#define SLAVE_APPSS				7
+#define SLAVE_CNOC_CFG				8
+#define SLAVE_DDRSS_CFG				9
+#define SLAVE_BOOT_IMEM				10
+#define SLAVE_IMEM				11
+#define SLAVE_PCIE_0				12
+
+#define MASTER_GPU_TCU				0
+#define MASTER_SYS_TCU				1
+#define MASTER_APPSS_PROC			2
+#define MASTER_GFX3D				3
+#define MASTER_LPASS_GEM_NOC			4
+#define MASTER_MSS_PROC				5
+#define MASTER_MNOC_HF_MEM_NOC			6
+#define MASTER_MNOC_SF_MEM_NOC			7
+#define MASTER_COMPUTE_NOC			8
+#define MASTER_ANOC_PCIE_GEM_NOC		9
+#define MASTER_QPACE				10
+#define MASTER_SNOC_SF_MEM_NOC			11
+#define MASTER_WLAN_Q6				12
+#define MASTER_GIC				13
+#define SLAVE_GEM_NOC_CNOC			14
+#define SLAVE_LLCC				15
+#define SLAVE_MEM_NOC_PCIE_SNOC			16
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
+#define MASTER_CAMNOC_HF			0
+#define MASTER_CAMNOC_NRT_ICP_SF		1
+#define MASTER_CAMNOC_RT_CDM_SF			2
+#define MASTER_CAMNOC_SF			3
+#define MASTER_MDP				4
+#define MASTER_MDSS_DCP				5
+#define MASTER_CDSP_HCP				6
+#define MASTER_VIDEO_CV_PROC			7
+#define MASTER_VIDEO_EVA			8
+#define MASTER_VIDEO_MVP			9
+#define MASTER_VIDEO_V_PROC			10
+#define MASTER_CNOC_MNOC_CFG			11
+#define SLAVE_MNOC_HF_MEM_NOC			12
+#define SLAVE_MNOC_SF_MEM_NOC			13
+#define SLAVE_SERVICE_MNOC			14
+
+#define MASTER_CDSP_PROC			0
+#define SLAVE_CDSP_MEM_NOC			1
+
+#define MASTER_PCIE_ANOC_CFG			0
+#define MASTER_PCIE_0				1
+#define SLAVE_ANOC_PCIE_GEM_NOC			2
+#define SLAVE_SERVICE_PCIE_ANOC			3
+
+#define MASTER_A1NOC_SNOC			0
+#define MASTER_A2NOC_SNOC			1
+#define MASTER_APSS_NOC				2
+#define MASTER_CNOC_SNOC			3
+#define SLAVE_SNOC_GEM_NOC_SF			4
+
+#endif

-- 
2.25.1


