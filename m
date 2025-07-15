Return-Path: <linux-kernel+bounces-731047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D8B04DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2831AA430D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5E12C3278;
	Tue, 15 Jul 2025 02:43:04 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4ED2CCC5;
	Tue, 15 Jul 2025 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547383; cv=none; b=FCMthHPaVB14feaKyIFmPLKex6td2nd2XjE3BSKjT39jmRGgPk51DxCp4Kst1m3UfU2i7dc7XrsnL84985eucCTGXpW3563hLI4ePN250H+EVrh4+FbrCI3HogXu6SMK7//jygygS/LscnzFSzGK1Nzhp00TBmqdfXlFeYSYiLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547383; c=relaxed/simple;
	bh=eMv0F3fXuUauLibfl+hyEwRbRQe07zvknY974G17nIA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lLjSRkSP1lDPcty0JxegYT7FvB9NQb93Jn0twgfJLuaKejGkR1dYPZgXvvnan9m7+36KFKvyqjozHELBijYSfl2pY1kiodG8xwmbloWcoof5mF51z6AjrzB6KnaFcF1c1/m4YJRLc82YbGv4IN1nYq+C8fsl6XBSVgGNSHHrmN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 15 Jul
 2025 10:42:58 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 15 Jul 2025 10:42:58 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v2] dt-bindings: interrupt-controller: aspeed: Add parent node compatibles and refine documentation
Date: Tue, 15 Jul 2025 10:42:58 +0800
Message-ID: <20250715024258.2304665-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

- Add 'aspeed,ast2700-intc0' and 'aspeed,ast2700-intc1' compatible
strings for parent interrupt controller nodes, in addition to the
existing 'aspeed,ast2700-intc-ic' for child nodes.
- Clarify the relationship and function of INTC0, INTC1, and the GIC.
- Update and clarify documentation, block diagram, and examples
to reflect the hierarchy and compatible usage.
- Documentation and example refine.

This change allows the device tree and driver to distinguish between
parent (top-level) and child (group) interrupt controller nodes,
enabling more precise driver matching SOC register space allocation.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---

v2:
make dt_binding_check check
 address-cells,size-cells -> #address-cells,#size-cells.
 add oneOf required, parent us interrupts, child use interrupts-extended.
 fix intc0_11 size-cells.

---
 .../aspeed,ast2700-intc.yaml                  | 158 +++++++++++++-----
 1 file changed, 115 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
index 55636d06a674..bdc4d8835843 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
@@ -10,6 +10,33 @@ description:
   This interrupt controller hardware is second level interrupt controller that
   is hooked to a parent interrupt controller. It's useful to combine multiple
   interrupt sources into 1 interrupt to parent interrupt controller.
+  Depend to which INTC0 or INTC1 used.
+  INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
+  status registers for use.
+  INTC0 is used to assert GIC if interrupt in INTC1 asserted.
+  INTC1 is used to assert INTC0 if interrupt of modules asserted.
+  +-----+   +---------+
+  | GIC |---|  INTC0  |
+  +-----+   +---------+
+            +---------+
+            |         |---module0
+            | INTC0_0 |---module1
+            |         |---...
+            +---------+---module31
+            |---....  |
+            +---------+
+            |         |     +---------+
+            | INTC0_11| +---| INTC1   |
+            |         |     +---------+
+            +---------+     +---------+---module0
+                            | INTC1_0 |---module1
+                            |         |---...
+                            +---------+---module31
+                            ...
+                            +---------+---module0
+                            | INTC1_5 |---module1
+                            |         |---...
+                            +---------+---module31
 
 maintainers:
   - Kevin Chen <kevin_chen@aspeedtech.com>
@@ -17,49 +44,70 @@ maintainers:
 properties:
   compatible:
     enum:
-      - aspeed,ast2700-intc-ic
+      - aspeed,ast2700-intc0
+      - aspeed,ast2700-intc1
 
   reg:
     maxItems: 1
 
-  interrupt-controller: true
+  '#address-cells':
+    const: 2
 
-  '#interrupt-cells':
+  '#size-cells':
     const: 2
-    description:
-      The first cell is the IRQ number, the second cell is the trigger
-      type as defined in interrupt.txt in this directory.
-
-  interrupts:
-    maxItems: 6
-    description: |
-      Depend to which INTC0 or INTC1 used.
-      INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
-      status registers for use.
-      INTC0 is used to assert GIC if interrupt in INTC1 asserted.
-      INTC1 is used to assert INTC0 if interrupt of modules asserted.
-      +-----+   +-------+     +---------+---module0
-      | GIC |---| INTC0 |--+--| INTC1_0 |---module2
-      |     |   |       |  |  |         |---...
-      +-----+   +-------+  |  +---------+---module31
-                           |
-                           |   +---------+---module0
-                           +---| INTC1_1 |---module2
-                           |   |         |---...
-                           |   +---------+---module31
-                          ...
-                           |   +---------+---module0
-                           +---| INTC1_5 |---module2
-                               |         |---...
-                               +---------+---module31
 
+  ranges: true
+
+patternProperties:
+  "^interrupt-controller@":
+    type: object
+    description: Interrupt group child nodes
+    additionalProperties: false
+
+    properties:
+      compatible:
+        enum:
+          - aspeed,ast2700-intc-ic
+
+      reg:
+        maxItems: 1
+
+      interrupt-controller: true
+
+      '#interrupt-cells':
+        const: 2
+        description: |
+          The first cell is the IRQ number, the second cell is the trigger
+          type as defined in interrupt.txt in this directory.
+
+      interrupts:
+        minItems: 1
+        maxItems: 6
+        description: |
+          The interrupts provided by this interrupt controller.
+
+      interrupts-extended:
+        minItems: 1
+        maxItems: 6
+        description: |
+          This property is required when defining a cascaded interrupt controller
+          that is connected under another interrupt controller. It specifies the
+          parent interrupt(s) in the upstream controller to which this controller
+          is connected.
+
+    oneOf:
+      - required: [interrupts]
+      - required: [interrupts-extended]
+
+    required:
+      - compatible
+      - reg
+      - interrupt-controller
+      - '#interrupt-cells'
 
 required:
   - compatible
   - reg
-  - interrupt-controller
-  - '#interrupt-cells'
-  - interrupts
 
 additionalProperties: false
 
@@ -68,19 +116,43 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      intc0: interrupt-controller@12100000 {
+        compatible = "aspeed,ast2700-intc0";
+        reg = <0 0x12100000 0 0x4000>;
+        ranges = <0x0 0x0 0x0 0x12100000 0x0 0x4000>;
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        intc0_11: interrupt-controller@1b00 {
+          compatible = "aspeed,ast2700-intc-ic";
+          reg = <0 0x12101b00 0 0x10>;
+          #interrupt-cells = <2>;
+          interrupt-controller;
+          interrupts = <GIC_SPI 192 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 193 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 194 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 195 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 196 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 197 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+        };
+      };
+
+      intc1: interrupt-controller@14c18000 {
+        compatible = "aspeed,ast2700-intc1";
+        reg = <0 0x14c18000 0 0x400>;
+        ranges = <0x0 0x0 0x0 0x14c18000 0x0 0x400>;
         #address-cells = <2>;
         #size-cells = <2>;
 
-        interrupt-controller@12101b00 {
-            compatible = "aspeed,ast2700-intc-ic";
-            reg = <0 0x12101b00 0 0x10>;
-            #interrupt-cells = <2>;
-            interrupt-controller;
-            interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+        intc1_0: interrupt-controller@100 {
+          compatible = "aspeed,ast2700-intc-ic";
+          reg = <0x0 0x100 0x0 0x10>;
+          #interrupt-cells = <2>;
+          interrupt-controller;
+          interrupts-extended = <&intc0_11 0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
         };
+      };
     };
-- 
2.34.1


