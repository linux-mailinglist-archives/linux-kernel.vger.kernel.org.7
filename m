Return-Path: <linux-kernel+bounces-790816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0368BB3AD86
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE36986055
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E79266584;
	Thu, 28 Aug 2025 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIwdGivq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4BF347C3;
	Thu, 28 Aug 2025 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756420234; cv=none; b=PPzFz2AW0BHikeHB8LK+Un61Wkbi/aNyLX0OnPHf/Sv6LJX/kCGwqHOz/WfpSRzQXxxgPuNsWTqt0UG2C0exIWbG2BNhIb0ImahOG0Zlys28Y7qA0O7cEVwUkPGzxHb5yZWHk+OGBH4tbVlKVDJAEZ56cr53tpFRZ9MgM8HbqMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756420234; c=relaxed/simple;
	bh=mUumE1SeF0jvWl4o41tu71i7s0T2juB++irBrMpJ/i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=du6n3AlFPF0YVV5nOXY3jZVSCDd/HTlexBXjYOLDXLe8Ztl11+WOzG14Nbyv8jHhJX+LpHkyOgrrXC1EVnsts3nzWmHzuP6l7+TcYOPOenPagpaXtzjy4y8qXtp4C2I29FtI99yzssx0b8sOApV8RRaJ882hZbwE1AQjlUqsG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIwdGivq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF415C4CEEB;
	Thu, 28 Aug 2025 22:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756420234;
	bh=mUumE1SeF0jvWl4o41tu71i7s0T2juB++irBrMpJ/i4=;
	h=From:To:Cc:Subject:Date:From;
	b=fIwdGivqPneVH13tyyy9atndpWIbtC6c5GjkW1LTQSQQJALU/Ya2k4RUseHcsw2vK
	 xJXlwTmDI9w1EJlCjVb+D8pgsOxAk8V6rZrkJOZWF/Dnr8pLxKaxolydMcYq6ynL7Z
	 TU/xVpgyXXmJlrI0aAs3Re7fAhOnme/HT1Br6bztdocFgxo90VyZ3kkYodD2DDZco8
	 PilJwlmTHRkPGZYxwznklovShC+G1OJ176jo48szHekGMyWoXf9QyhYsPjqfC90dSY
	 kAfGT3uFO80JTV/wqg40Kl4LM2rS7phDvZcO5IRSahv3KNjfHlB7fq8u6jONRwtAsP
	 EpOWoWfKD3ELw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Khuong Dinh <khuong@os.amperecomputing.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: edac: Convert apm,xgene-edac to DT schema
Date: Thu, 28 Aug 2025 17:30:21 -0500
Message-ID: <20250828223023.2409337-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the APM XGene EDAC binding to DT schema. Add the missing
"apm,xgene-edac-soc" compatible, and drop the unused
"apm,xgene-edac-pmd-v2" compatible.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/edac/apm,xgene-edac.yaml         | 203 ++++++++++++++++++
 .../bindings/edac/apm-xgene-edac.txt          | 112 ----------
 MAINTAINERS                                   |   2 +-
 3 files changed, 204 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/apm,xgene-edac.yaml
 delete mode 100644 Documentation/devicetree/bindings/edac/apm-xgene-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/apm,xgene-edac.yaml b/Documentation/devicetree/bindings/edac/apm,xgene-edac.yaml
new file mode 100644
index 000000000000..9afc78254cc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/apm,xgene-edac.yaml
@@ -0,0 +1,203 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/apm,xgene-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: APM X-Gene SoC EDAC
+
+maintainers:
+  - Khuong Dinh <khuong@os.amperecomputing.com>
+
+description: >
+  EDAC node is defined to describe on-chip error detection and correction.
+
+  The following error types are supported:
+
+    memory controller  - Memory controller
+    PMD (L1/L2)        - Processor module unit (PMD) L1/L2 cache
+    L3                 - L3 cache controller
+    SoC                - SoC IPs such as Ethernet, SATA, etc
+
+properties:
+  compatible:
+    const: apm,xgene-edac
+
+  reg:
+    items:
+      - description: CPU bus (PCP) resource
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+  ranges: true
+
+  interrupts:
+    description: Interrupt-specifier for MCU, PMD, L3, or SoC error IRQ(s).
+    items:
+      - description: MCU error IRQ
+      - description: PMD error IRQ
+      - description: L3 error IRQ
+      - description: SoC error IRQ
+    minItems: 1
+
+  regmap-csw:
+    description: Regmap of the CPU switch fabric (CSW) resource.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  regmap-mcba:
+    description: Regmap of the MCB-A (memory bridge) resource.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  regmap-mcbb:
+    description: Regmap of the MCB-B (memory bridge) resource.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  regmap-efuse:
+    description: Regmap of the PMD efuse resource.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  regmap-rb:
+    description: Regmap of the register bus resource (optional for compatibility).
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - regmap-csw
+  - regmap-mcba
+  - regmap-mcbb
+  - regmap-efuse
+  - reg
+  - interrupts
+
+# Child-node bindings
+patternProperties:
+  '^edacmc@':
+    description: Memory controller subnode
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: apm,xgene-edac-mc
+
+      reg:
+        maxItems: 1
+
+      memory-controller:
+        description: Instance number of the memory controller.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maximum: 3
+
+    required:
+      - compatible
+      - reg
+      - memory-controller
+
+
+  '^edacpmd@':
+    description: PMD subnode
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: apm,xgene-edac-pmd
+
+      reg:
+        maxItems: 1
+
+      pmd-controller:
+        description: Instance number of the PMD controller.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maximum: 3
+
+    required:
+      - compatible
+      - reg
+      - pmd-controller
+
+  '^edacl3@':
+    description: L3 subnode
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        enum:
+          - apm,xgene-edac-l3
+          - apm,xgene-edac-l3-v2
+
+      reg:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+
+  '^edacsoc@':
+    description: SoC subnode
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        enum:
+          - apm,xgene-edac-soc
+          - apm,xgene-edac-soc-v1
+
+      reg:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        edac@78800000 {
+            compatible = "apm,xgene-edac";
+            reg = <0x0 0x78800000 0x0 0x100>;
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+            interrupts = <0x0 0x20 0x4>, <0x0 0x21 0x4>, <0x0 0x27 0x4>;
+
+            regmap-csw = <&csw>;
+            regmap-mcba = <&mcba>;
+            regmap-mcbb = <&mcbb>;
+            regmap-efuse = <&efuse>;
+            regmap-rb = <&rb>;
+
+            edacmc@7e800000 {
+                compatible = "apm,xgene-edac-mc";
+                reg = <0x0 0x7e800000 0x0 0x1000>;
+                memory-controller = <0>;
+            };
+
+            edacpmd@7c000000 {
+                compatible = "apm,xgene-edac-pmd";
+                reg = <0x0 0x7c000000 0x0 0x200000>;
+                pmd-controller = <0>;
+            };
+
+            edacl3@7e600000 {
+                compatible = "apm,xgene-edac-l3";
+                reg = <0x0 0x7e600000 0x0 0x1000>;
+            };
+
+            edacsoc@7e930000 {
+                compatible = "apm,xgene-edac-soc-v1";
+                reg = <0x0 0x7e930000 0x0 0x1000>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
deleted file mode 100644
index 1006b0489464..000000000000
--- a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
+++ /dev/null
@@ -1,112 +0,0 @@
-* APM X-Gene SoC EDAC node
-
-EDAC node is defined to describe on-chip error detection and correction.
-The follow error types are supported:
-
-  memory controller	- Memory controller
-  PMD (L1/L2)		- Processor module unit (PMD) L1/L2 cache
-  L3			- L3 cache controller
-  SoC			- SoC IP's such as Ethernet, SATA, and etc
-
-The following section describes the EDAC DT node binding.
-
-Required properties:
-- compatible		: Shall be "apm,xgene-edac".
-- regmap-csw		: Regmap of the CPU switch fabric (CSW) resource.
-- regmap-mcba		: Regmap of the MCB-A (memory bridge) resource.
-- regmap-mcbb		: Regmap of the MCB-B (memory bridge) resource.
-- regmap-efuse		: Regmap of the PMD efuse resource.
-- regmap-rb		: Regmap of the register bus resource. This property
-			  is optional only for compatibility. If the RB
-			  error conditions are not cleared, it will
-			  continuously generate interrupt.
-- reg			: First resource shall be the CPU bus (PCP) resource.
-- interrupts            : Interrupt-specifier for MCU, PMD, L3, or SoC error
-			  IRQ(s).
-
-Required properties for memory controller subnode:
-- compatible		: Shall be "apm,xgene-edac-mc".
-- reg			: First resource shall be the memory controller unit
-                          (MCU) resource.
-- memory-controller	: Instance number of the memory controller.
-
-Required properties for PMD subnode:
-- compatible		: Shall be "apm,xgene-edac-pmd" or
-                          "apm,xgene-edac-pmd-v2".
-- reg			: First resource shall be the PMD resource.
-- pmd-controller	: Instance number of the PMD controller.
-
-Required properties for L3 subnode:
-- compatible		: Shall be "apm,xgene-edac-l3" or
-                          "apm,xgene-edac-l3-v2".
-- reg			: First resource shall be the L3 EDAC resource.
-
-Required properties for SoC subnode:
-- compatible		: Shall be "apm,xgene-edac-soc-v1" for revision 1 or
-                          "apm,xgene-edac-l3-soc" for general value reporting
-                          only.
-- reg			: First resource shall be the SoC EDAC resource.
-
-Example:
-	csw: csw@7e200000 {
-		compatible = "apm,xgene-csw", "syscon";
-		reg = <0x0 0x7e200000 0x0 0x1000>;
-	};
-
-	mcba: mcba@7e700000 {
-		compatible = "apm,xgene-mcb", "syscon";
-		reg = <0x0 0x7e700000 0x0 0x1000>;
-	};
-
-	mcbb: mcbb@7e720000 {
-		compatible = "apm,xgene-mcb", "syscon";
-		reg = <0x0 0x7e720000 0x0 0x1000>;
-	};
-
-	efuse: efuse@1054a000 {
-		compatible = "apm,xgene-efuse", "syscon";
-		reg = <0x0 0x1054a000 0x0 0x20>;
-	};
-
-	rb: rb@7e000000 {
-		compatible = "apm,xgene-rb", "syscon";
-		reg = <0x0 0x7e000000 0x0 0x10>;
-	};
-
-	edac@78800000 {
-		compatible = "apm,xgene-edac";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-		regmap-csw = <&csw>;
-		regmap-mcba = <&mcba>;
-		regmap-mcbb = <&mcbb>;
-		regmap-efuse = <&efuse>;
-		regmap-rb = <&rb>;
-		reg = <0x0 0x78800000 0x0 0x100>;
-		interrupts = <0x0 0x20 0x4>,
-			     <0x0 0x21 0x4>,
-			     <0x0 0x27 0x4>;
-
-		edacmc@7e800000 {
-			compatible = "apm,xgene-edac-mc";
-			reg = <0x0 0x7e800000 0x0 0x1000>;
-			memory-controller = <0>;
-		};
-
-		edacpmd@7c000000 {
-			compatible = "apm,xgene-edac-pmd";
-			reg = <0x0 0x7c000000 0x0 0x200000>;
-			pmd-controller = <0>;
-		};
-
-		edacl3@7e600000 {
-			compatible = "apm,xgene-edac-l3";
-			reg = <0x0 0x7e600000 0x0 0x1000>;
-		};
-
-		edacsoc@7e930000 {
-			compatible = "apm,xgene-edac-soc-v1";
-			reg = <0x0 0x7e930000 0x0 0x1000>;
-		};
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 0428593ce489..9dd234ca0e89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1878,7 +1878,7 @@ F:	arch/arm64/boot/dts/apm/
 APPLIED MICRO (APM) X-GENE SOC EDAC
 M:	Khuong Dinh <khuong@os.amperecomputing.com>
 S:	Supported
-F:	Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
+F:	Documentation/devicetree/bindings/edac/apm,xgene-edac.yaml
 F:	drivers/edac/xgene_edac.c
 
 APPLIED MICRO (APM) X-GENE SOC ETHERNET (V2) DRIVER
-- 
2.50.1


