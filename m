Return-Path: <linux-kernel+bounces-723676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCA2AFE9D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89075A6C12
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FCE2DEA62;
	Wed,  9 Jul 2025 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="H9f70dZ+"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD82DEA68
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066910; cv=none; b=owg18rAp5R3uffqpBaygzyBv2mGW2aec0pPxsjmpj1bMKoGdaEjgmJpV31vTwbt7p4COT5D7cbbN/F3PRJiZWq97atybySRYAn3bEv2S/VgSQxUmmFHmSBM6CEDMi5hWPxmqQCp+dzq78TNE8o/Fq3LPk+eOBzTxXsb2SwDstM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066910; c=relaxed/simple;
	bh=mrkQj7/BqMIjY9Rlpe+a0hMhAi0HmkMDjDgpAOHfrGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJyv9nKiBINq2QxRu4bPMkyk5FbY9XKtPA8Leux/a89GfIrInzoKTsVehlwSdxJHbffgGCoa2KIs04jaGlY5FF6IH/YDmzl6Chii6rKdvNtGbKG+Z3yXP4mpb3LteutPUs8FfaMw/+qrEmXK4HJRLaIYtL425nQdk/KBcHsTpLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=H9f70dZ+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so1635671a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752066906; x=1752671706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JaPsQN+6dS4u1/QpYDZ1OHQVijJnm/PiUBk/+LDnZj8=;
        b=H9f70dZ+KMe8UzFNMfrFMgFRRONxSU1co0f7SxbC5nA3hb2B+iqx9TDlqJTecWXwAQ
         McdMhnJjT80AQ9T3x3K7SLCaMqmb/bHtTvIhtW96ZJ6GsFrjVFYC9s3s0DwYSob25v1p
         FixF79IUrgue8HCHF1YZCvcgH0GE1buljJK/gdRVoIGVno+uBLe6mkXq3oJtfl1Ufb90
         92JycLcNMkmP18haVmC8xSgYsR+Ob32ZMkh32+WaMQWPSOdjKhUZnEFy+DV4f677wX09
         EXL8tQAqQZsgsz4DISDkRo585XUgSNz9nhrGBNUPbXIWbchK87Vp3dRg/E9F10pTWXrL
         FLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752066906; x=1752671706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaPsQN+6dS4u1/QpYDZ1OHQVijJnm/PiUBk/+LDnZj8=;
        b=QfmHipbyCB+uDARaAjZk/0X9qgtsprqhBxlXG+YSshVuT1JdGugwU3tGWAUfe/u4/z
         +zF3YNuG0EHWYl0KzAdL70g7vZwKitpolGoI/DyeqU6k8/nF/UoLb/klaVZqtMqHYRt2
         Z+yiXobX1RSHDS7c3nY+aTdoPV2DYzGsD4s0F7C2b+1GouRGgCLHHZi0qiKlErR62tBY
         1eOmbUrvf7tLdQwJ+f1jbkczOBmIhYBunBeN7OfzpZWbD5TVphlpoppvszG1TB+UYHvJ
         MJy8w3TKtfX04JHFZmcnKkGum3zWfybOkU8VSj9CtY93orKSIzWs1iNdRvUt7QVgHqpr
         wi1A==
X-Forwarded-Encrypted: i=1; AJvYcCU0/XzpDYTnz8bR7fJgF0e0ShchfsFF3Y+l0dFyHiH/0/AlKo80K5pazJYc/LIgSID9F87Gi4NNf/ENFY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28uMQic6MGXQlxic8va1xMQRllb1VBesA8byT/CN+2BtmCfLk
	PxKAL3M27OSiFCBaRWYj+e914hjevhbl7JtA+xyCG5J3dTa2+MPxqJBXOV2Po8PpKgM=
X-Gm-Gg: ASbGncsmJiLki/7JoOh3PEAYZS0zP/SUDRj4rQQrq82iOQOueCCLasOtzUGtTKtGmLc
	B89R5JnB45I1zUOKKumUK56qkgYg1gdRnuPpaF9Sn81GTjiuOLVPX/CmrU1UFFaJnl8gGW1A9NX
	4dLDs4uxSxi8cP94jyRP0bMLAGIEN/C36EAhEK+g4qc9O2Em45AZiVAVLGFLLM/0Yh3nrSBr3Ac
	FlEjhbr2L9EIGh/BuHTaSaoz9yAMJwb7/EQtbrfnGcBqJnE2Hv0lcvr8oJj35NFK/x3Ilc4c4t/
	r8FrXaivSegZXJoKWj8FjdaNObdBTuD74jzBBq4LhstlqROWsZlBENl4+im7fe3lVya0/SJiZh4
	tlhQtpuzNYyfTPyu11lKC4g/6P+nZT7bw
X-Google-Smtp-Source: AGHT+IHEAKqfTaKJP0T/ISRGuLl9MW6E/zyylXqm+I79HN3LHaMikEeK1JgYHa3utFeQUcRg7cY4jA==
X-Received: by 2002:a17:906:3114:b0:ae0:a464:99d with SMTP id a640c23a62f3a-ae6b26f9190mr614441566b.17.1752066905705;
        Wed, 09 Jul 2025 06:15:05 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d91ffsm1105542766b.14.2025.07.09.06.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 06:15:05 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 15:14:49 +0200
Subject: [PATCH v3 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip Interconnect in Qualcomm Milos SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-icc-v3-1-c446203c3b3a@fairphone.com>
References: <20250709-sm7635-icc-v3-0-c446203c3b3a@fairphone.com>
In-Reply-To: <20250709-sm7635-icc-v3-0-c446203c3b3a@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752066904; l=8727;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=mrkQj7/BqMIjY9Rlpe+a0hMhAi0HmkMDjDgpAOHfrGw=;
 b=iHYf5PXeT+ZIkB8fE4IUnH09m+ux0rujZaWFXEKHmob4icewsoso3R5ieofWWBHoEmPJwFNC4
 ZrzJK9gnLQiCzj5seGiQ5QR5PE+wCH6j7aPgdItW1Im4fk9oPHTXKR1
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the RPMh Network-On-Chip Interconnect of the Milos (e.g.
SM7635) SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/interconnect/qcom,milos-rpmh.yaml     | 136 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,milos-rpmh.h | 141 +++++++++++++++++++++
 2 files changed, 277 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,milos-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,milos-rpmh.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..00b7a4108d45156d0832bbffe1607ac9b9fecff9
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,milos-rpmh.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,milos-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on Milos SoC
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also: include/dt-bindings/interconnect/qcom,milos-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,milos-aggre1-noc
+      - qcom,milos-aggre2-noc
+      - qcom,milos-clk-virt
+      - qcom,milos-cnoc-cfg
+      - qcom,milos-cnoc-main
+      - qcom,milos-gem-noc
+      - qcom,milos-lpass-ag-noc
+      - qcom,milos-mc-virt
+      - qcom,milos-mmss-noc
+      - qcom,milos-nsp-noc
+      - qcom,milos-pcie-anoc
+      - qcom,milos-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
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
+              - qcom,milos-clk-virt
+              - qcom,milos-mc-virt
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
+              - qcom,milos-pcie-anoc
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
+              - qcom,milos-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre USB3 PRIM AXI clock
+            - description: aggre UFS PHY AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,milos-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,milos-aggre1-noc
+              - qcom,milos-aggre2-noc
+              - qcom,milos-pcie-anoc
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
+    #include <dt-bindings/clock/qcom,milos-gcc.h>
+
+    interconnect-0 {
+        compatible = "qcom,milos-clk-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    interconnect@16e0000 {
+        compatible = "qcom,milos-aggre1-noc";
+        reg = <0x016e0000 0x16400>;
+        #interconnect-cells = <2>;
+        clocks = <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+                 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,milos-rpmh.h b/include/dt-bindings/interconnect/qcom,milos-rpmh.h
new file mode 100644
index 0000000000000000000000000000000000000000..9326d7d9c2a3b360aec62797963de9b07b8f6f9e
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,milos-rpmh.h
@@ -0,0 +1,141 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MILOS_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MILOS_H
+
+#define MASTER_QUP_1				0
+#define MASTER_UFS_MEM				1
+#define MASTER_USB3_0				2
+#define SLAVE_A1NOC_SNOC			3
+
+#define MASTER_QDSS_BAM				0
+#define MASTER_QSPI_0				1
+#define MASTER_QUP_0				2
+#define MASTER_CRYPTO				3
+#define MASTER_IPA				4
+#define MASTER_QDSS_ETR				5
+#define MASTER_QDSS_ETR_1			6
+#define MASTER_SDCC_1				7
+#define MASTER_SDCC_2				8
+#define SLAVE_A2NOC_SNOC			9
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define SLAVE_QUP_CORE_0			2
+#define SLAVE_QUP_CORE_1			3
+
+#define MASTER_CNOC_CFG				0
+#define SLAVE_AHB2PHY_SOUTH			1
+#define SLAVE_AHB2PHY_NORTH			2
+#define SLAVE_CAMERA_CFG			3
+#define SLAVE_CLK_CTL				4
+#define SLAVE_RBCPR_CX_CFG			5
+#define SLAVE_RBCPR_MXA_CFG			6
+#define SLAVE_CRYPTO_0_CFG			7
+#define SLAVE_CX_RDPM				8
+#define SLAVE_GFX3D_CFG				9
+#define SLAVE_IMEM_CFG				10
+#define SLAVE_CNOC_MSS				11
+#define SLAVE_MX_2_RDPM				12
+#define SLAVE_MX_RDPM				13
+#define SLAVE_PDM				14
+#define SLAVE_QDSS_CFG				15
+#define SLAVE_QSPI_0				16
+#define SLAVE_QUP_0				17
+#define SLAVE_QUP_1				18
+#define SLAVE_SDC1				19
+#define SLAVE_SDCC_2				20
+#define SLAVE_TCSR				21
+#define SLAVE_TLMM				22
+#define SLAVE_UFS_MEM_CFG			23
+#define SLAVE_USB3_0				24
+#define SLAVE_VENUS_CFG				25
+#define SLAVE_VSENSE_CTRL_CFG			26
+#define SLAVE_WLAN				27
+#define SLAVE_CNOC_MNOC_HF_CFG			28
+#define SLAVE_CNOC_MNOC_SF_CFG			29
+#define SLAVE_NSP_QTB_CFG			30
+#define SLAVE_PCIE_ANOC_CFG			31
+#define SLAVE_WLAN_Q6_THROTTLE_CFG		32
+#define SLAVE_SERVICE_CNOC_CFG			33
+#define SLAVE_QDSS_STM				34
+#define SLAVE_TCU				35
+
+#define MASTER_GEM_NOC_CNOC			0
+#define MASTER_GEM_NOC_PCIE_SNOC		1
+#define SLAVE_AOSS				2
+#define SLAVE_DISPLAY_CFG			3
+#define SLAVE_IPA_CFG				4
+#define SLAVE_IPC_ROUTER_CFG			5
+#define SLAVE_PCIE_0_CFG			6
+#define SLAVE_PCIE_1_CFG			7
+#define SLAVE_PRNG				8
+#define SLAVE_TME_CFG				9
+#define SLAVE_APPSS				10
+#define SLAVE_CNOC_CFG				11
+#define SLAVE_DDRSS_CFG				12
+#define SLAVE_IMEM				13
+#define SLAVE_PIMEM				14
+#define SLAVE_SERVICE_CNOC			15
+#define SLAVE_PCIE_0				16
+#define SLAVE_PCIE_1				17
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
+#define MASTER_SNOC_GC_MEM_NOC			10
+#define MASTER_SNOC_SF_MEM_NOC			11
+#define MASTER_WLAN_Q6				12
+#define SLAVE_GEM_NOC_CNOC			13
+#define SLAVE_LLCC				14
+#define SLAVE_MEM_NOC_PCIE_SNOC			15
+
+#define MASTER_LPASS_PROC			0
+#define SLAVE_LPASS_GEM_NOC			1
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_CAMNOC_ICP			1
+#define MASTER_CAMNOC_SF			2
+#define MASTER_MDP				3
+#define MASTER_VIDEO				4
+#define MASTER_CNOC_MNOC_HF_CFG			5
+#define MASTER_CNOC_MNOC_SF_CFG			6
+#define SLAVE_MNOC_HF_MEM_NOC			7
+#define SLAVE_MNOC_SF_MEM_NOC			8
+#define SLAVE_SERVICE_MNOC_HF			9
+#define SLAVE_SERVICE_MNOC_SF			10
+
+#define MASTER_CDSP_PROC			0
+#define SLAVE_CDSP_MEM_NOC			1
+
+#define MASTER_PCIE_ANOC_CFG			0
+#define MASTER_PCIE_0				1
+#define MASTER_PCIE_1				2
+#define SLAVE_ANOC_PCIE_GEM_NOC			3
+#define SLAVE_SERVICE_PCIE_ANOC			4
+
+#define MASTER_A1NOC_SNOC			0
+#define MASTER_A2NOC_SNOC			1
+#define MASTER_APSS_NOC				2
+#define MASTER_CNOC_SNOC			3
+#define MASTER_PIMEM				4
+#define MASTER_GIC				5
+#define SLAVE_SNOC_GEM_NOC_GC			6
+#define SLAVE_SNOC_GEM_NOC_SF			7
+
+
+#endif

-- 
2.50.0


