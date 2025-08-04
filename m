Return-Path: <linux-kernel+bounces-755715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E718B1AAD3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 00:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE58C17D8DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 22:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9B7290D85;
	Mon,  4 Aug 2025 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9A6zOOx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DB9238C07;
	Mon,  4 Aug 2025 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346038; cv=none; b=Xx+zceDGcCDXhITzcQcSH7oxbsN/uLkBeTd/k798Z+jPepG8jUXBs5pA8eKYNPbDCEBJe2CCH+JhAc34BM2Me3PQlxiqEf8R0FY0f/jFAoeNsNpI9DRl9owHNNbf8o72VITiGkLcUjvNv0rA+wqguMyXpL+6gwx7pPchjS2USYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346038; c=relaxed/simple;
	bh=eRGMV5Wey5m4sUoQ8SFHlm/ii4cWW2wdYIodmb7Jiwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UI7FUDbTRghMgyahLjMc23ToKWuMCM+2fpJ7FKCdZjTtE5uFfsWw5sXns08r+IfV0QHQq995+c/81ocBdIkdRr96qRzeSUNjrpMc+edlu251XZNKWMmtzT2PU4jp/waZSC148E9LIKuhMeQpMPMEhpamuOA7a/+xEeC39pAoxio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9A6zOOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3C4C4CEE7;
	Mon,  4 Aug 2025 22:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754346037;
	bh=eRGMV5Wey5m4sUoQ8SFHlm/ii4cWW2wdYIodmb7Jiwo=;
	h=From:To:Cc:Subject:Date:From;
	b=S9A6zOOxlLulKJEGHAflV5so2ybexePFmf7b5yuR5akLdT2Knmq//46tiZN3GGuVS
	 893f5Q0XjAe/JvxkyOWS7tgrhsgn2LbK0mxD6nnDDp8G81mgPhh9Ixeca1vHKiCO2+
	 Ua3XMtWJCC0rAfj1QypW+tVvl2Q+JyLHCHApUsUT5N/8pWuEiLEmldje5r50MR1YBe
	 f8JBNQKzL7xVqTMbesan5u3oxYEolTiEKB9Z7Gr32nv9+21lFJji2iuAozl80CfDtS
	 yl/WGTKo35prBKRHMoiIsi9z1vLrO/FP0eKsivNnu1CTVqq4faH4Dqh3Pq/+bYtWnd
	 uZUSNYir5FBEg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: Convert silabs,si5341 to DT schema
Date: Mon,  4 Aug 2025 17:20:32 -0500
Message-ID: <20250804222034.4083410-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Silicon Labs SI5341 binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/clock/silabs,si5341.txt          | 175 --------------
 .../bindings/clock/silabs,si5341.yaml         | 217 ++++++++++++++++++
 2 files changed, 217 insertions(+), 175 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/silabs,si5341.txt
 create mode 100644 Documentation/devicetree/bindings/clock/silabs,si5341.yaml

diff --git a/Documentation/devicetree/bindings/clock/silabs,si5341.txt b/Documentation/devicetree/bindings/clock/silabs,si5341.txt
deleted file mode 100644
index ce55aba0ce22..000000000000
--- a/Documentation/devicetree/bindings/clock/silabs,si5341.txt
+++ /dev/null
@@ -1,175 +0,0 @@
-Binding for Silicon Labs Si5340, Si5341 Si5342, Si5344 and Si5345 programmable
-i2c clock generator.
-
-Reference
-[1] Si5341 Data Sheet
-    https://www.silabs.com/documents/public/data-sheets/Si5341-40-D-DataSheet.pdf
-[2] Si5341 Reference Manual
-    https://www.silabs.com/documents/public/reference-manuals/Si5341-40-D-RM.pdf
-[3] Si5345 Reference Manual
-    https://www.silabs.com/documents/public/reference-manuals/Si5345-44-42-D-RM.pdf
-
-The Si5341 and Si5340 are programmable i2c clock generators with up to 10 output
-clocks. The chip contains a PLL that sources 5 (or 4) multisynth clocks, which
-in turn can be directed to any of the 10 (or 4) outputs through a divider.
-The internal structure of the clock generators can be found in [2].
-The Si5345 is similar to the Si5341 with the addition of fractional input
-dividers and automatic input selection, as described in [3].
-The Si5342 and Si5344 are smaller versions of the Si5345, with 2 or 4 outputs.
-
-The driver can be used in "as is" mode, reading the current settings from the
-chip at boot, in case you have a (pre-)programmed device. If the PLL is not
-configured when the driver probes, it assumes the driver must fully initialize
-it.
-
-The device type, speed grade and revision are determined runtime by probing.
-
-The driver currently does not support any fancy input configurations. They can
-still be programmed into the chip and the driver will leave them "as is".
-
-==I2C device node==
-
-Required properties:
-- compatible: shall be one of the following:
-	"silabs,si5340" - Si5340 A/B/C/D
-	"silabs,si5341" - Si5341 A/B/C/D
-	"silabs,si5342" - Si5342 A/B/C/D
-	"silabs,si5344" - Si5344 A/B/C/D
-	"silabs,si5345" - Si5345 A/B/C/D
-- reg: i2c device address, usually 0x74
-- #clock-cells: from common clock binding; shall be set to 2.
-	The first value is "0" for outputs, "1" for synthesizers.
-	The second value is the output or synthesizer index.
-- clocks: from common clock binding; list of parent clock  handles,
-	corresponding to inputs. Use a fixed clock for the "xtal" input.
-	At least one must be present.
-- clock-names: One of: "xtal", "in0", "in1", "in2"
-
-Optional properties:
-- vdd-supply: Regulator node for VDD
-- vdda-supply: Regulator node for VDDA
-- vdds-supply: Regulator node for VDDS
-- silabs,pll-m-num, silabs,pll-m-den: Numerator and denominator for PLL
-  feedback divider. Must be such that the PLL output is in the valid range. For
-  example, to create 14GHz from a 48MHz xtal, use m-num=14000 and m-den=48. Only
-  the fraction matters, using 3500 and 12 will deliver the exact same result.
-  If these are not specified, and the PLL is not yet programmed when the driver
-  probes, the PLL will be set to 14GHz.
-- silabs,reprogram: When present, the driver will always assume the device must
-  be initialized, and always performs the soft-reset routine. Since this will
-  temporarily stop all output clocks, don't do this if the chip is generating
-  the CPU clock for example.
-- silabs,xaxb-ext-clk: When present, indicates that the XA/XB pins are used
-  in EXTCLK (external reference clock) rather than XTAL (crystal) mode.
-- interrupts: Interrupt for INTRb pin.
-- silabs,iovdd-33: When present, indicates that the I2C lines are using 3.3V
-  rather than 1.8V thresholds.
-- vddoX-supply (where X is an output index): Regulator node for VDDO for the
-  specified output. The driver selects the output VDD_SEL setting based on this
-  voltage.
-- #address-cells: shall be set to 1.
-- #size-cells: shall be set to 0.
-
-
-== Child nodes: Outputs ==
-
-The child nodes list the output clocks.
-
-Each of the clock outputs can be overwritten individually by using a child node.
-If a child node for a clock output is not set, the configuration remains
-unchanged.
-
-Required child node properties:
-- reg: number of clock output.
-
-Optional child node properties:
-- silabs,format: Output format, one of:
-	1 = differential (defaults to LVDS levels)
-	2 = low-power (defaults to HCSL levels)
-	4 = LVCMOS
-- silabs,common-mode: Manually override output common mode, see [2] for values
-- silabs,amplitude: Manually override output amplitude, see [2] for values
-- silabs,synth-master: boolean. If present, this output is allowed to change the
-	multisynth frequency dynamically.
-- silabs,silabs,disable-high: boolean. If set, the clock output is driven HIGH
-	when disabled, otherwise it's driven LOW.
-
-==Example==
-
-/* 48MHz reference crystal */
-ref48: ref48M {
-	compatible = "fixed-clock";
-	#clock-cells = <0>;
-	clock-frequency = <48000000>;
-};
-
-i2c-master-node {
-	/* Programmable clock (for logic) */
-	si5341: clock-generator@74 {
-		reg = <0x74>;
-		compatible = "silabs,si5341";
-		#clock-cells = <2>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&ref48>;
-		clock-names = "xtal";
-
-		silabs,pll-m-num = <14000>; /* PLL at 14.0 GHz */
-		silabs,pll-m-den = <48>;
-		silabs,reprogram; /* Chips are not programmed, always reset */
-
-		out@0 {
-			reg = <0>;
-			silabs,format = <1>; /* LVDS 3v3 */
-			silabs,common-mode = <3>;
-			silabs,amplitude = <3>;
-			silabs,synth-master;
-		};
-
-		/*
-		 * Output 6 configuration:
-		 *  LVDS 1v8
-		 */
-		out@6 {
-			reg = <6>;
-			silabs,format = <1>; /* LVDS 1v8 */
-			silabs,common-mode = <13>;
-			silabs,amplitude = <3>;
-		};
-
-		/*
-		 * Output 8 configuration:
-		 *  HCSL 3v3
-		 */
-		out@8 {
-			reg = <8>;
-			silabs,format = <2>;
-			silabs,common-mode = <11>;
-			silabs,amplitude = <3>;
-		};
-	};
-};
-
-some-video-node {
-	/* Standard clock bindings */
-	clock-names = "pixel";
-	clocks = <&si5341 0 7>; /* Output 7 */
-
-	/* Set output 7 to use syntesizer 3 as its parent */
-	assigned-clocks = <&si5341 0 7>, <&si5341 1 3>;
-	assigned-clock-parents = <&si5341 1 3>;
-	/* Set output 7 to 148.5 MHz using a synth frequency of 594 MHz */
-	assigned-clock-rates = <148500000>, <594000000>;
-};
-
-some-audio-node {
-	clock-names = "i2s-clk";
-	clocks = <&si5341 0 0>;
-	/*
-	 * since output 0 is a synth-master, the synth will be automatically set
-	 * to an appropriate frequency when the audio driver requests another
-	 * frequency. We give control over synth 2 to this output here.
-	 */
-	assigned-clocks = <&si5341 0 0>;
-	assigned-clock-parents = <&si5341 1 2>;
-};
diff --git a/Documentation/devicetree/bindings/clock/silabs,si5341.yaml b/Documentation/devicetree/bindings/clock/silabs,si5341.yaml
new file mode 100644
index 000000000000..b4f7efdf0b7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/silabs,si5341.yaml
@@ -0,0 +1,217 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/silabs,si5341.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Labs Si5340/1/2/4/5 programmable i2c clock generator
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+description: >
+  Silicon Labs Si5340, Si5341 Si5342, Si5344 and Si5345 programmable i2c clock
+  generator.
+
+  Reference
+  [1] Si5341 Data Sheet
+      https://www.silabs.com/documents/public/data-sheets/Si5341-40-D-DataSheet.pdf
+  [2] Si5341 Reference Manual
+      https://www.silabs.com/documents/public/reference-manuals/Si5341-40-D-RM.pdf
+  [3] Si5345 Reference Manual
+      https://www.silabs.com/documents/public/reference-manuals/Si5345-44-42-D-RM.pdf
+
+  The Si5341 and Si5340 are programmable i2c clock generators with up to 10 output
+  clocks. The chip contains a PLL that sources 5 (or 4) multisynth clocks, which
+  in turn can be directed to any of the 10 (or 4) outputs through a divider.
+  The internal structure of the clock generators can be found in [2].
+  The Si5345 is similar to the Si5341 with the addition of fractional input
+  dividers and automatic input selection, as described in [3].
+  The Si5342 and Si5344 are smaller versions of the Si5345, with 2 or 4 outputs.
+
+  The driver can be used in "as is" mode, reading the current settings from the
+  chip at boot, in case you have a (pre-)programmed device. If the PLL is not
+  configured when the driver probes, it assumes the driver must fully initialize
+  it.
+
+  The device type, speed grade and revision are determined runtime by probing.
+
+properties:
+  compatible:
+    enum:
+      - silabs,si5340
+      - silabs,si5341
+      - silabs,si5342
+      - silabs,si5344
+      - silabs,si5345
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 2
+    description: >
+      The first value is "0" for outputs, "1" for synthesizers.
+
+      The second value is the output or synthesizer index.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: xtal
+      - const: in0
+      - const: in1
+      - const: in2
+
+  interrupts:
+    maxItems: 1
+    description: Interrupt for INTRb pin
+
+  vdd-supply:
+    description: Regulator node for VDD
+
+  vdda-supply:
+    description: Regulator node for VDDA
+
+  vdds-supply:
+    description: Regulator node for VDDS
+
+  silabs,pll-m-num:
+    description:
+      Numerator for PLL feedback divider. Must be such that the PLL output is in
+      the valid range. For example, to create 14GHz from a 48MHz xtal, use
+      m-num=14000 and m-den=48. Only the fraction matters, using 3500 and 12
+      will deliver the exact same result. If these are not specified, and the
+      PLL is not yet programmed when the driver probes, the PLL will be set to
+      14GHz.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  silabs,pll-m-den:
+    description: Denominator for PLL feedback divider
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  silabs,reprogram:
+    description: Always perform soft-reset and reinitialize PLL
+    type: boolean
+
+  silabs,xaxb-ext-clk:
+    description: Use XA/XB pins as external reference clock
+    type: boolean
+
+  silabs,iovdd-33:
+    description: I2C lines use 3.3V thresholds
+    type: boolean
+
+patternProperties:
+  "^vddo[0-9]-supply$": true
+
+  "^out@[0-9]$":
+    description: >
+      Output-specific override nodes
+
+      Each of the clock outputs can be overwritten individually by using a child
+      node. If a child node for a clock output is not set, the configuration
+      remains unchanged.
+    type: object
+    additionalProperties: false
+
+    properties:
+      reg:
+        description: Number of clock output
+        maximum: 9
+
+      silabs,format:
+        description: Output format
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [1, 2, 4]
+
+      silabs,common-mode:
+        description: Override output common mode
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      silabs,amplitude:
+        description: Override output amplitude
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      silabs,synth-master:
+        description: Allow dynamic multisynth rate control
+        type: boolean
+
+      silabs,disable-high:
+        description: Drive output HIGH when disabled
+        type: boolean
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#address-cells"
+  - "#size-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        clock-generator@74 {
+            reg = <0x74>;
+            compatible = "silabs,si5341";
+            #clock-cells = <2>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&ref48>;
+            clock-names = "xtal";
+
+            silabs,pll-m-num = <14000>; /* PLL at 14.0 GHz */
+            silabs,pll-m-den = <48>;
+            silabs,reprogram; /* Chips are not programmed, always reset */
+
+            out@0 {
+                reg = <0>;
+                silabs,format = <1>; /* LVDS 3v3 */
+                silabs,common-mode = <3>;
+                silabs,amplitude = <3>;
+                silabs,synth-master;
+            };
+
+            /*
+              * Output 6 configuration:
+              *  LVDS 1v8
+              */
+            out@6 {
+                reg = <6>;
+                silabs,format = <1>; /* LVDS 1v8 */
+                silabs,common-mode = <13>;
+                silabs,amplitude = <3>;
+            };
+
+            /*
+              * Output 8 configuration:
+              *  HCSL 3v3
+              */
+            out@8 {
+                reg = <8>;
+                silabs,format = <2>;
+                silabs,common-mode = <11>;
+                silabs,amplitude = <3>;
+            };
+        };
+    };
-- 
2.47.2


