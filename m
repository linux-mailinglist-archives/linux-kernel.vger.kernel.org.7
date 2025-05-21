Return-Path: <linux-kernel+bounces-658223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0321ABFEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 23:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E66E3B58F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 21:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D912BCF79;
	Wed, 21 May 2025 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJxKPDCI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B71624CE;
	Wed, 21 May 2025 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747861656; cv=none; b=HcFjB0MI6q8/xjr2hfWtapbgniqCOy+VGhQ2ZBC66ca5JPIeTMVmz2oNJVWaFYrQIRWqX4o4+PeZ9uPSle9m7DNGp/fBPDs3O/xc56H2tytluFOocxLs5k66uYE7kMTKtPeRzh9vGbRrBgtSos4dUAh0mbwP0xnR0q11MDkXbMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747861656; c=relaxed/simple;
	bh=0jrEvkNUilMLzAL9sGC5s9EMfEPqGKWMOCkajjERj9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f20wi607St37gpO1FFn8LNwIoR1HTpui84mi/S65Wiai09YuHnJ7zTXxd37vENMm6AsLyBT8tZQ534DzRKDAOKV7VL1ez0dXas+vVMKPNq9g5fg+O1ON66Nqu/WoVcqzzGcSoBkcvMBrcwODWCuoZ3dChWm+DJP0Ztd2NECKnag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJxKPDCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FEDC4CEE4;
	Wed, 21 May 2025 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747861655;
	bh=0jrEvkNUilMLzAL9sGC5s9EMfEPqGKWMOCkajjERj9A=;
	h=From:To:Cc:Subject:Date:From;
	b=dJxKPDCICX03tN/d53HzsKM964f7bekhAzh/vbj2UDPVIa+fhTMD9B0OTVYp08ILu
	 hXF+W27eDVHVvg9vGUmG67irHv4QGIMASvEUSRrUQy0NNJLdCaUsj8t311Z33BlFI2
	 tAWNrwkbwhMQzLy9tUDIrnq3rUzUqSnwDRrTKEh2gLum9maKMZPxVo24e0bn0k0Wx+
	 1Pbckgt0IauwQosDrcmED7Lb5F6mFjzu/DjNEq4TVQ6kk5FAf+3SkYhJa/Csxsu1ef
	 Ulk/GbBQrtsOdy2BVs47aC4l5EtK3PR+9dAOqHFK96+jfExK1pgDrDFfuIODsWZUA/
	 AwuwiRqpmRpQg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Bresticker <abrestic@chromium.org>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: Convert img,pistachio-clk to DT schema
Date: Wed, 21 May 2025 16:07:11 -0500
Message-ID: <20250521210712.59742-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/clock/img,pistachio-clk.yaml     | 136 ++++++++++++++++++
 .../bindings/clock/pistachio-clock.txt        | 123 ----------------
 2 files changed, 136 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/img,pistachio-clk.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/pistachio-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/img,pistachio-clk.yaml b/Documentation/devicetree/bindings/clock/img,pistachio-clk.yaml
new file mode 100644
index 000000000000..e70feee8e894
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/img,pistachio-clk.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/img,pistachio-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagination Technologies Pistachio SoC clock controllers
+
+maintainers:
+  - Andrew Bresticker <abrestic@chromium.org>
+
+description: |
+  Pistachio has four clock controllers (core clock, peripheral clock, peripheral
+  general control, and top general control) which are instantiated individually
+  from the device-tree.
+
+  Core clock controller:
+
+  The core clock controller generates clocks for the CPU, RPU (WiFi + BT
+  co-processor), audio, and several peripherals.
+
+  Peripheral clock controller:
+
+  The peripheral clock controller generates clocks for the DDR, ROM, and other
+  peripherals. The peripheral system clock ("periph_sys") generated by the core
+  clock controller is the input clock to the peripheral clock controller.
+
+  Peripheral general control:
+
+  The peripheral general control block generates system interface clocks and
+  resets for various peripherals. It also contains miscellaneous peripheral
+  control registers.
+
+  Top-level general control:
+
+  The top-level general control block contains miscellaneous control registers
+  and gates for the external clocks "audio_clk_in" and "enet_clk_in".
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - img,pistachio-clk
+          - img,pistachio-clk-periph
+          - img,pistachio-cr-periph
+          - img,pistachio-cr-top
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - clocks
+  - clock-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: img,pistachio-clk
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External 52Mhz oscillator
+            - description: Alternate audio reference clock
+            - description: Alternate ethernet PHY clock
+
+        clock-names:
+          items:
+            - const: xtal
+            - const: audio_refclk_ext_gate
+            - const: ext_enet_in_gate
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: img,pistachio-clk-periph
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Peripheral system clock
+
+        clock-names:
+          items:
+            - const: periph_sys_core
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: img,pistachio-cr-periph
+    then:
+      properties:
+        clocks:
+          items:
+            - description: System interface clock
+
+        clock-names:
+          items:
+            - const: sys
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: img,pistachio-cr-top
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External audio reference clock
+            - description: External ethernet PHY clock
+
+        clock-names:
+          items:
+            - const: audio_clk_in
+            - const: enet_clk_in
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/clock/pistachio-clock.txt b/Documentation/devicetree/bindings/clock/pistachio-clock.txt
deleted file mode 100644
index 868db499eed2..000000000000
--- a/Documentation/devicetree/bindings/clock/pistachio-clock.txt
+++ /dev/null
@@ -1,123 +0,0 @@
-Imagination Technologies Pistachio SoC clock controllers
-========================================================
-
-Pistachio has four clock controllers (core clock, peripheral clock, peripheral
-general control, and top general control) which are instantiated individually
-from the device-tree.
-
-External clocks:
-----------------
-
-There are three external inputs to the clock controllers which should be
-defined with the following clock-output-names:
-- "xtal": External 52Mhz oscillator (required)
-- "audio_clk_in": Alternate audio reference clock (optional)
-- "enet_clk_in": Alternate ethernet PHY clock (optional)
-
-Core clock controller:
-----------------------
-
-The core clock controller generates clocks for the CPU, RPU (WiFi + BT
-co-processor), audio, and several peripherals.
-
-Required properties:
-- compatible: Must be "img,pistachio-clk".
-- reg: Must contain the base address and length of the core clock controller.
-- #clock-cells: Must be 1.  The single cell is the clock identifier.
-  See dt-bindings/clock/pistachio-clk.h for the list of valid identifiers.
-- clocks: Must contain an entry for each clock in clock-names.
-- clock-names: Must include "xtal" (see "External clocks") and
-  "audio_clk_in_gate", "enet_clk_in_gate" which are generated by the
-  top-level general control.
-
-Example:
-	clk_core: clock-controller@18144000 {
-		compatible = "img,pistachio-clk";
-		reg = <0x18144000 0x800>;
-		clocks = <&xtal>, <&cr_top EXT_CLK_AUDIO_IN>,
-			 <&cr_top EXT_CLK_ENET_IN>;
-		clock-names = "xtal", "audio_clk_in_gate", "enet_clk_in_gate";
-
-		#clock-cells = <1>;
-	};
-
-Peripheral clock controller:
-----------------------------
-
-The peripheral clock controller generates clocks for the DDR, ROM, and other
-peripherals.  The peripheral system clock ("periph_sys") generated by the core
-clock controller is the input clock to the peripheral clock controller.
-
-Required properties:
-- compatible: Must be "img,pistachio-periph-clk".
-- reg: Must contain the base address and length of the peripheral clock
-  controller.
-- #clock-cells: Must be 1.  The single cell is the clock identifier.
-  See dt-bindings/clock/pistachio-clk.h for the list of valid identifiers.
-- clocks: Must contain an entry for each clock in clock-names.
-- clock-names: Must include "periph_sys", the peripheral system clock generated
-  by the core clock controller.
-
-Example:
-	clk_periph: clock-controller@18144800 {
-		compatible = "img,pistachio-clk-periph";
-		reg = <0x18144800 0x800>;
-		clocks = <&clk_core CLK_PERIPH_SYS>;
-		clock-names = "periph_sys";
-
-		#clock-cells = <1>;
-	};
-
-Peripheral general control:
----------------------------
-
-The peripheral general control block generates system interface clocks and
-resets for various peripherals.  It also contains miscellaneous peripheral
-control registers.  The system clock ("sys") generated by the peripheral clock
-controller is the input clock to the system clock controller.
-
-Required properties:
-- compatible: Must include "img,pistachio-periph-cr" and "syscon".
-- reg: Must contain the base address and length of the peripheral general
-  control registers.
-- #clock-cells: Must be 1.  The single cell is the clock identifier.
-  See dt-bindings/clock/pistachio-clk.h for the list of valid identifiers.
-- clocks: Must contain an entry for each clock in clock-names.
-- clock-names: Must include "sys", the system clock generated by the peripheral
-  clock controller.
-
-Example:
-	cr_periph: syscon@18144800 {
-		compatible = "img,pistachio-cr-periph", "syscon";
-		reg = <0x18148000 0x1000>;
-		clocks = <&clock_periph PERIPH_CLK_PERIPH_SYS>;
-		clock-names = "sys";
-
-		#clock-cells = <1>;
-	};
-
-Top-level general control:
---------------------------
-
-The top-level general control block contains miscellaneous control registers and
-gates for the external clocks "audio_clk_in" and "enet_clk_in".
-
-Required properties:
-- compatible: Must include "img,pistachio-cr-top" and "syscon".
-- reg: Must contain the base address and length of the top-level
-  control registers.
-- clocks: Must contain an entry for each clock in clock-names.
-- clock-names: Two optional clocks, "audio_clk_in" and "enet_clk_in" (see
-  "External clocks").
-- #clock-cells: Must be 1.  The single cell is the clock identifier.
-  See dt-bindings/clock/pistachio-clk.h for the list of valid identifiers.
-
-Example:
-	cr_top: syscon@18144800 {
-		compatible = "img,pistachio-cr-top", "syscon";
-		reg = <0x18149000 0x200>;
-		clocks = <&audio_refclk>, <&ext_enet_in>;
-		clock-names = "audio_clk_in", "enet_clk_in";
-
-		#clock-cells = <1>;
-	};
-- 
2.47.2


