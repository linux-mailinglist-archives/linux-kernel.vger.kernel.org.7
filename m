Return-Path: <linux-kernel+bounces-722207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9193AFD66C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44223B3AD2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D690A2EBDC5;
	Tue,  8 Jul 2025 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X9CVCXtJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BVAWQkJn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F612EB5CC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998849; cv=none; b=ojIplAT056mKcSY6iMMDIyHE2BkbC44+ycpJgBbyOtk9SBfivKc9nJbCnTnqvF6peYXjIyCuZe0Dp2mkwmttEUEPgWzgdzFgyLIAuleP4dL3JTq1H1Kyvb6LcWIwP1n+Lb87x0q1finyZoK5sEvxEPjGjjctJMm4dvIr32iDLB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998849; c=relaxed/simple;
	bh=5SPF7GHScDTZLAkMgAgczV+mvIwdLAUhYTCND/x0UE0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RSpJuzpjpDAaT6ru/gHBGFfNYBridQZTX4YFneK0OTHfQboLeIirJVOT2BGE4tpsY89FqeNKjvSDNMW8jtLLazeAkNCnbzr9sDEnmKo30lW57OqYWxEy7DkvjzDLVa+oXsrMWnx7Gumom3RmU+VnCcL8ITYlCCY3psPpVwULq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X9CVCXtJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BVAWQkJn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7FxFrDKc7ukYPUOey5jHR2YYDRZj8nK9aExk4VU6v0=;
	b=X9CVCXtJXMKxAazLTQ35+jJLlQZSYGTIQfTFeGIxDNOI6DgjF+pBlAmQgRyTipX6nuouT8
	OEvo+3+vHqsRgaq/uE8MRLBwAfaEz7NOQYimDFt24w+N6gre02e+Dgwk9HshEIOwPskFsD
	fHTskmmFXL3OUdL86o5jhOaGz9oOYfYk07nzLgmSQl1gqKoSLKfiYgx510SmGNgm6di2Yw
	PM/KjpJpLY5oqfnKmHWz4EmRsZV/Bt3i2igg/G9fOc+rF44UOO2px2eiHXy839+efv736G
	JmstPooPVMfVt4raIxHRli9TEb2srQxFXl6vZh9lCnb8neiNqHCSfG+f7NUTgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7FxFrDKc7ukYPUOey5jHR2YYDRZj8nK9aExk4VU6v0=;
	b=BVAWQkJn6VYxYWeV5KWMighxOUP32/iOJadMllMcZ+WDvCSXn0SzgFbe9wyE10znKdI6Ta
	IQZbl4VfAvPAmhAA==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject:
 [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller: Add Arm GICv5
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-1-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-1-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199884531.406.16780110117033942355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     7d7299bd07c667e915d62109c10b84cb646fe66a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/7d7299bd07c667e915d62109c10b84cb646fe66a
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:24:51 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:50 +01:00

dt-bindings: interrupt-controller: Add Arm GICv5

The GICv5 interrupt controller architecture is composed of:

- one or more Interrupt Routing Service (IRS)
- zero or more Interrupt Translation Service (ITS)
- zero or more Interrupt Wire Bridge (IWB)

Describe a GICv5 implementation by specifying a top level node
corresponding to the GICv5 system component.

IRS nodes are added as GICv5 system component children.

An ITS is associated with an IRS so ITS nodes are described
as IRS children - use the hierarchy explicitly in the device
tree to define the association.

IWB nodes are described as a separate schema.

An IWB is connected to a single ITS, the connection is made explicit
through the msi-parent property and therefore is not required to be
explicit through a parent-child relationship in the device tree.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-1-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5-iwb.yaml |  78 ++++++++++++++++++++-
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml     | 267 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 MAINTAINERS                                                                |   7 ++-
 3 files changed, 352 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5-iwb.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5-iwb.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5-iwb.yaml
new file mode 100644
index 0000000..99a266a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5-iwb.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/arm,gic-v5-iwb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Generic Interrupt Controller, version 5 Interrupt Wire Bridge (IWB)
+
+maintainers:
+  - Lorenzo Pieralisi <lpieralisi@kernel.org>
+  - Marc Zyngier <maz@kernel.org>
+
+description: |
+  The GICv5 architecture defines the guidelines to implement GICv5
+  compliant interrupt controllers for AArch64 systems.
+
+  The GICv5 specification can be found at
+  https://developer.arm.com/documentation/aes0070
+
+  GICv5 has zero or more Interrupt Wire Bridges (IWB) that are responsible
+  for translating wire signals into interrupt messages to the GICv5 ITS.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    const: arm,gic-v5-iwb
+
+  reg:
+    items:
+      - description: IWB control frame
+
+  "#address-cells":
+    const: 0
+
+  "#interrupt-cells":
+    description: |
+      The 1st cell corresponds to the IWB wire.
+
+      The 2nd cell is the flags, encoded as follows:
+      bits[3:0] trigger type and level flags.
+
+      1 = low-to-high edge triggered
+      2 = high-to-low edge triggered
+      4 = active high level-sensitive
+      8 = active low level-sensitive
+
+    const: 2
+
+  interrupt-controller: true
+
+  msi-parent:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - interrupt-controller
+  - msi-parent
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@2f000000 {
+      compatible = "arm,gic-v5-iwb";
+      reg = <0x2f000000 0x10000>;
+
+      #address-cells = <0>;
+
+      #interrupt-cells = <2>;
+      interrupt-controller;
+
+      msi-parent = <&its0 64>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml
new file mode 100644
index 0000000..86ca7f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml
@@ -0,0 +1,267 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/arm,gic-v5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Generic Interrupt Controller, version 5
+
+maintainers:
+  - Lorenzo Pieralisi <lpieralisi@kernel.org>
+  - Marc Zyngier <maz@kernel.org>
+
+description: |
+  The GICv5 architecture defines the guidelines to implement GICv5
+  compliant interrupt controllers for AArch64 systems.
+
+  The GICv5 specification can be found at
+  https://developer.arm.com/documentation/aes0070
+
+  The GICv5 architecture is composed of multiple components:
+    - one or more IRS (Interrupt Routing Service)
+    - zero or more ITS (Interrupt Translation Service)
+
+  The architecture defines:
+    - PE-Private Peripheral Interrupts (PPI)
+    - Shared Peripheral Interrupts (SPI)
+    - Logical Peripheral Interrupts (LPI)
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    const: arm,gic-v5
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+  ranges: true
+
+  "#interrupt-cells":
+    description: |
+      The 1st cell corresponds to the INTID.Type field in the INTID; 1 for PPI,
+      3 for SPI. LPI interrupts must not be described in the bindings since
+      they are allocated dynamically by the software component managing them.
+
+      The 2nd cell contains the interrupt INTID.ID field.
+
+      The 3rd cell is the flags, encoded as follows:
+      bits[3:0] trigger type and level flags.
+
+        1 = low-to-high edge triggered
+        2 = high-to-low edge triggered
+        4 = active high level-sensitive
+        8 = active low level-sensitive
+
+    const: 3
+
+  interrupt-controller: true
+
+  interrupts:
+    description:
+      The VGIC maintenance interrupt.
+    maxItems: 1
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - "#interrupt-cells"
+  - interrupt-controller
+
+patternProperties:
+  "^irs@[0-9a-f]+$":
+    type: object
+    description:
+      GICv5 has one or more Interrupt Routing Services (IRS) that are
+      responsible for handling IRQ state and routing.
+
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: arm,gic-v5-irs
+
+      reg:
+        minItems: 1
+        items:
+          - description: IRS config frames
+          - description: IRS setlpi frames
+
+      reg-names:
+        description:
+          Describe config and setlpi frames that are present.
+          "ns-" stands for non-secure, "s-" for secure, "realm-" for realm
+          and "el3-" for EL3.
+        minItems: 1
+        maxItems: 8
+        items:
+          enum: [ ns-config, s-config, realm-config, el3-config, ns-setlpi,
+                  s-setlpi, realm-setlpi, el3-setlpi ]
+
+      "#address-cells":
+        enum: [ 1, 2 ]
+
+      "#size-cells":
+        enum: [ 1, 2 ]
+
+      ranges: true
+
+      dma-noncoherent:
+        description:
+          Present if the GIC IRS permits programming shareability and
+          cacheability attributes but is connected to a non-coherent
+          downstream interconnect.
+
+      cpus:
+        description:
+          CPUs managed by the IRS.
+
+      arm,iaffids:
+        $ref: /schemas/types.yaml#/definitions/uint16-array
+        description:
+          Interrupt AFFinity ID (IAFFID) associated with the CPU whose
+          CPU node phandle is at the same index in the cpus array.
+
+    patternProperties:
+      "^its@[0-9a-f]+$":
+        type: object
+        description:
+          GICv5 has zero or more Interrupt Translation Services (ITS) that are
+          used to route Message Signalled Interrupts (MSI) to the CPUs. Each
+          ITS is connected to an IRS.
+        additionalProperties: false
+
+        properties:
+          compatible:
+            const: arm,gic-v5-its
+
+          reg:
+            items:
+              - description: ITS config frames
+
+          reg-names:
+            description:
+              Describe config frames that are present.
+              "ns-" stands for non-secure, "s-" for secure, "realm-" for realm
+              and "el3-" for EL3.
+            minItems: 1
+            maxItems: 4
+            items:
+              enum: [ ns-config, s-config, realm-config, el3-config ]
+
+          "#address-cells":
+            enum: [ 1, 2 ]
+
+          "#size-cells":
+            enum: [ 1, 2 ]
+
+          ranges: true
+
+          dma-noncoherent:
+            description:
+              Present if the GIC ITS permits programming shareability and
+              cacheability attributes but is connected to a non-coherent
+              downstream interconnect.
+
+        patternProperties:
+          "^msi-controller@[0-9a-f]+$":
+            type: object
+            description:
+              GICv5 ITS has one or more translate register frames.
+            additionalProperties: false
+
+            properties:
+              reg:
+                items:
+                  - description: ITS translate frames
+
+              reg-names:
+                description:
+                  Describe translate frames that are present.
+                  "ns-" stands for non-secure, "s-" for secure, "realm-" for realm
+                  and "el3-" for EL3.
+                minItems: 1
+                maxItems: 4
+                items:
+                  enum: [ ns-translate, s-translate, realm-translate, el3-translate ]
+
+              "#msi-cells":
+                description:
+                  The single msi-cell is the DeviceID of the device which will
+                  generate the MSI.
+                const: 1
+
+              msi-controller: true
+
+            required:
+              - reg
+              - reg-names
+              - "#msi-cells"
+              - msi-controller
+
+        required:
+          - compatible
+          - reg
+          - reg-names
+
+    required:
+      - compatible
+      - reg
+      - reg-names
+      - cpus
+      - arm,iaffids
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller {
+      compatible = "arm,gic-v5";
+
+      #interrupt-cells = <3>;
+      interrupt-controller;
+
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+
+      interrupts = <1 25 4>;
+
+      irs@2f1a0000 {
+        compatible = "arm,gic-v5-irs";
+        reg = <0x2f1a0000 0x10000>;  // IRS_CONFIG_FRAME
+        reg-names = "ns-config";
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>, <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
+        arm,iaffids = /bits/ 16 <0 1 2 3 4 5 6 7>;
+
+        its@2f120000 {
+          compatible = "arm,gic-v5-its";
+          reg = <0x2f120000 0x10000>;   // ITS_CONFIG_FRAME
+          reg-names = "ns-config";
+
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges;
+
+          msi-controller@2f130000 {
+            reg = <0x2f130000 0x10000>;   // ITS_TRANSLATE_FRAME
+            reg-names = "ns-translate";
+
+            #msi-cells = <1>;
+            msi-controller;
+          };
+        };
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index c3f7fbd..c545209 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1964,6 +1964,13 @@ F:	drivers/irqchip/irq-gic*.[ch]
 F:	include/linux/irqchip/arm-gic*.h
 F:	include/linux/irqchip/arm-vgic-info.h
 
+ARM GENERIC INTERRUPT CONTROLLER V5 DRIVERS
+M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
+M:	Marc Zyngier <maz@kernel.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5*.yaml
+
 ARM HDLCD DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 S:	Supported

