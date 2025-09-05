Return-Path: <linux-kernel+bounces-802534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 377D6B45352
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20E11B222E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6031F27C17F;
	Fri,  5 Sep 2025 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="117F2ch/"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FC01E487
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065034; cv=none; b=K4+7+v6OIiEuzE7+QtECRcQotClU6O9ekkXBCPeuTvwIgbRy/OMx7AKNNfgkbAaBuq4vJB+VCloz7l2NKZ1+TKbasVm+kkeg8zb+vd34q9agiDDM7zYCQVpOt/KjWnamhq4R5De607XmZW8rSNDw6sgt6/lOzSK1q3QaBdrBEVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065034; c=relaxed/simple;
	bh=WanJed64TSNwNGZNhu7PllxnSri4C0kCk0vjp8eirmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BIFDQouENlCP4uOIG0Y7ykl6yUIOoxnODT/g0YMVTBkEEOQJMkO56Nr29pEIvWz7TwdZRf7mX40N+wIMp/SofNJvIsu7pUHyLQLG3hqRYSF9J9J08VBrZfSTff9NWeIuM2t5I/1Q1bdb4TCLHKKJwjoOpeYoY1IFezSOP1YVcww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=117F2ch/; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-afcb78ead12so310833666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1757065031; x=1757669831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gxHPJln64uaPKAQBsFUXX+sYbTr+DxuaR2UtObdr64=;
        b=117F2ch/FHzZewcdumhADXfCEgiooXV+9TPunyEgxq05vfVf41u7hpHA1X/Yitjf/U
         vgJfLS/b8yLU+Abgvc4PrpNZNenwtbX+UnGLhtWNtDfiGaDrvnd3YLwqV819w+VVNBQ4
         rz+72+fX80J7wTn3c1Oyqi33DL2zdFdROlmgYQm8sNjWlrWU/8FpAU8ou7uvyTp68XLN
         WFFartOz9F3Qkv6NQh7lo5yuflcErtOY7MoI1sfmKE+tL6r5SorroSYvuuOGbH7tB3J1
         UrL6fqSHmx0xyZaaf16GwC76sjbqzHr5kd23bnTE/3C7EjctKFlAMscr/cL/yzfQYNUg
         S3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757065031; x=1757669831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gxHPJln64uaPKAQBsFUXX+sYbTr+DxuaR2UtObdr64=;
        b=NV+xSvGJmEIVsJh/dG8MUjeaTGpVHW3IheNKMmYtb0FrIvkvv+y3ICvGiPXrpqRcBn
         PSbp/HtmvYz5rnn4/BWDaQrKXoseq+VxanA0nHX+NgckJ1jcPHUrJB58eSNWNiruYGds
         wbnaebM9p3HLmRYyuX8kgCgJCbTm2cZe5KEzxdCXDlCXTWLLvR0zF1arkOEqSNpw6bZe
         hLTLd1kWj3atewyZygg9BWLsIRMYSY5bqq3Wox/dcgyZLFqMP1yeRcLtaSGR5ebn8yki
         DtlCDrLsxNTuelWsPXeKQ1a7YUJl6vMuZSMIwvrLujB9PCXYi5TTX7P/f2p/xQzbLP6D
         4jsg==
X-Forwarded-Encrypted: i=1; AJvYcCWGc6S5Msq03FpFlVN2EOhZOA0muzq4yidvFxwCKooYlWLhPFcd43FfUO67RZ2qCswUKLK4doXilYbsUZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFcW5JhDOcyK9DVsL/eKJCzvxwxTNbNkonIVFVTIi05xeBvD/
	zyReImR8M54MJbBFhsYPbxp0NJA7Lh0Vc6F8YM9HboBp3qSMOT+3UdDCWYyLsaSXs/w=
X-Gm-Gg: ASbGncubAWnaS3OTBbH8gExn0OzHd0dwzv6dDBPXroUGUMKPVn0bT2+x6cGIC07rMdo
	Ybedl0OJCBXoohKRD4glViXFaZosvjiVzDokAqe9TS+o6rPT4uTCAd34/xoBCdgJ0OMJ8TlnGH7
	nCrk246Z3vE1Pl1Wwdw0q7sw5JKVbKnNMXyZjaC+ZBq9LDH8iq0V9P2pjuXuZ5+ucpyQNmcHYct
	zUE8M0htNlQ6TY9QuQKTzfmp0J8w6PuH9/d9FL0Cf3ty8gWn4aiUIQGz5YgMB9UE3X7p3aZRgSN
	M4fLtMObUbp0KZ+ABK2LnC0x+84hvHZAB/DmAArAEa4z/uQtW39NyYTngP5fC9e8zek54yG6002
	axc0LOnPa5N1oBKzPozzOlaJ7CjTgZlYC+rgXQzzqiAsmvUd+dnML94Xo4DtmR8gQ69YLBoFgUK
	HC8fEHCHPeEHnJdbIpcGO5NmK5XAOBNw==
X-Google-Smtp-Source: AGHT+IEjE3/kdcdoU0TRHnFqVVC+QkaRMtcUEY7t9i41zivu24QfXLZpgNR88N0OT0jPXc1Q+7Nymg==
X-Received: by 2002:a17:907:94c9:b0:b04:32ff:5d1e with SMTP id a640c23a62f3a-b0432ffd0abmr1598272566b.60.1757065030867;
        Fri, 05 Sep 2025 02:37:10 -0700 (PDT)
Received: from [172.18.170.139] (ip-185-104-138-158.ptr.icomera.net. [185.104.138.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0416842ffasm1361597866b.38.2025.09.05.02.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:37:10 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 05 Sep 2025 11:37:04 +0200
Subject: [PATCH v4 1/2] dt-bindings: remoteproc: qcom,milos-pas: Document
 remoteprocs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sm7635-remoteprocs-v4-1-9e24febcb246@fairphone.com>
References: <20250905-sm7635-remoteprocs-v4-0-9e24febcb246@fairphone.com>
In-Reply-To: <20250905-sm7635-remoteprocs-v4-0-9e24febcb246@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757065028; l=6238;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=WanJed64TSNwNGZNhu7PllxnSri4C0kCk0vjp8eirmg=;
 b=zOvwwfh6cAKkgMS9/Xi8oJWQ+IbFNSt1BFUv7GQV/8XipSepdOKb5qU7WlgaG680B8K2OybUo
 6HExOnBAlx6D0cX12Qo5hJR1sfz0MJrPgr3Km5qpYb24qMarfuUcyeq
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the bindings for the ADSP, CDSP, MPSS and WPSS PAS on the Milos
(e.g. SM7635) SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/remoteproc/qcom,milos-pas.yaml        | 201 +++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,milos-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,milos-pas.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..790ad38a0330bf81f6333e887522ddb97690edbc
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,milos-pas.yaml
@@ -0,0 +1,201 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,milos-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Milos SoC Peripheral Authentication Service
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+
+description:
+  Qualcomm Milos SoC Peripheral Authentication Service loads and boots firmware
+  on the Qualcomm DSP Hexagon cores.
+
+properties:
+  compatible:
+    enum:
+      - qcom,milos-adsp-pas
+      - qcom,milos-cdsp-pas
+      - qcom,milos-mpss-pas
+      - qcom,milos-wpss-pas
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: XO clock
+
+  clock-names:
+    items:
+      - const: xo
+
+  interrupts:
+    minItems: 6
+    maxItems: 6
+
+  interrupt-names:
+    minItems: 6
+    maxItems: 6
+
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AOSS side-channel message RAM.
+
+  smd-edge: false
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    minItems: 1
+    items:
+      - description: Firmware name of the Hexagon core
+      - description: Firmware name of the Hexagon Devicetree
+
+  memory-region:
+    minItems: 1
+    items:
+      - description: Memory region for core Firmware authentication
+      - description: Memory region for Devicetree Firmware authentication
+
+required:
+  - compatible
+  - reg
+  - memory-region
+
+allOf:
+  - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,milos-adsp-pas
+            - qcom,milos-cdsp-pas
+    then:
+      properties:
+        memory-region:
+          minItems: 2
+          maxItems: 2
+        firmware-name:
+          minItems: 2
+          maxItems: 2
+    else:
+      properties:
+        memory-region:
+          maxItems: 1
+        firmware-name:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,milos-adsp-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: LCX power domain
+            - description: LMX power domain
+        power-domain-names:
+          items:
+            - const: lcx
+            - const: lmx
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,milos-cdsp-pas
+            - qcom,milos-wpss-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MX power domain
+        power-domain-names:
+          items:
+            - const: cx
+            - const: mx
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,milos-mpss-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MSS power domain
+        power-domain-names:
+          items:
+            - const: cx
+            - const: mss
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,milos-rpmh.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    remoteproc@3000000 {
+        compatible = "qcom,milos-adsp-pas";
+        reg = <0x03000000 0x10000>;
+
+        interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 7 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog",
+                          "fatal",
+                          "ready",
+                          "handover",
+                          "stop-ack",
+                          "shutdown-ack";
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "xo";
+
+        power-domains = <&rpmhpd RPMHPD_LCX>,
+                        <&rpmhpd RPMHPD_LMX>;
+        power-domain-names = "lcx",
+                             "lmx";
+
+        interconnects = <&lpass_ag_noc MASTER_LPASS_PROC QCOM_ICC_TAG_ALWAYS
+                         &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+
+        memory-region = <&adspslpi_mem>, <&q6_adsp_dtb_mem>;
+
+        firmware-name = "qcom/milos/vendor/device/adsp.mbn",
+                        "qcom/milos/vendor/device/adsp_dtb.mbn";
+
+        qcom,qmp = <&aoss_qmp>;
+
+        qcom,smem-states = <&smp2p_adsp_out 0>;
+        qcom,smem-state-names = "stop";
+
+        glink-edge {
+            interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+                                         IPCC_MPROC_SIGNAL_GLINK_QMP
+                                         IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&ipcc IPCC_CLIENT_LPASS
+                            IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+            label = "lpass";
+            qcom,remote-pid = <2>;
+
+            /* ... */
+        };
+    };

-- 
2.51.0


