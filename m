Return-Path: <linux-kernel+bounces-740604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BA5B0D654
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE281C26E26
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E892DEA93;
	Tue, 22 Jul 2025 09:52:04 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8AE2E040A;
	Tue, 22 Jul 2025 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177924; cv=none; b=LqtTt8kqLsJqPkrafc1O/8fgvfDdpWKalYwbZCkCwF657R90kEcyeB9rxXEc7inwP+DmD3G80GloqSDExgxJoN7M6BMswmh1N7Spwbl7tJ8MPhCdoYCv1XHwMlyNYD3MJQwH1hx4IuRT2KMFsKNcYk3XKxjTPL8X68xWP1V7BAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177924; c=relaxed/simple;
	bh=jhYhDX8Y3yD3DCsIEaeAfJm+QwI1Wt1k62NbxOhbG38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5yacn4oF77/QmlLSXF2HyXihMLjAFhhA9qLkUEgKiS/4Dkt9BySQf9m+2Xd2KjNDYTqxid+AjhXwzI7OoLJLX6k74rgP478oeqx4+gTokGDs5NbGpfhkaVY3EqEGOgrb7OzPujY3KKGcc5C2SBEwOMrjtaVdJk1nD0jYcQkqWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 22 Jul
 2025 17:51:56 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 22 Jul 2025 17:51:56 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add parent node compatibles and refine documentation
Date: Tue, 22 Jul 2025 17:51:55 +0800
Message-ID: <20250722095156.1672873-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AST2700 SoC contains two independent top-level interrupt controllers
(INTC0 and INTC1), each responsible for handling different peripheral
groups and occupying separate register spaces. Above them, PSP(CA35) GIC
controller acts as the root interrupt aggregator. Accurately describing
this hierarchical hardware structure in the device tree requires distinct
compatible strings for the parent nodes of INTC0 and INTC1.

- Adds 'aspeed,ast2700-intc0' and 'aspeed,ast2700-intc1' compatible
 strings for parent interrupt controller nodes. (in addition to the
 existing 'aspeed,ast2700-intc-ic' for child nodes)
- Clarifies the relationship and function of INTC0 parent
 (intc0_0~x: child), INTC1 parent (intc1_0~x: child), and the GIC
 in the documentation.
- Updates block diagrams and device tree examples to illustrate
 the hierarchy and compatible usage.
- Refines documentation and example formatting.

This change allows the device tree and driver to distinguish between
parent (top-level) and child (group) interrupt controller nodes,
enabling more precise driver matching SOC register space allocation.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
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


