Return-Path: <linux-kernel+bounces-765566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035EAB23A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527CE3B2C94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D8E2D5A10;
	Tue, 12 Aug 2025 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aa+vG2Tn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9BD2D0620;
	Tue, 12 Aug 2025 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755030813; cv=none; b=Qd6P0GiEs6CY+ISc044aXeJb29fFknkJeJFtLXO67F0OZC9kQKLuvRDFRGUHv2YxzFuxCxDEtwCp05ZP0QCYQuxf9KF4my05G/vAkXH5ASClksRzGh8p5IFK1+toibh/sF3UOcEl4+25aw5AITbPZebOdKJYE+J07THUKk0tFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755030813; c=relaxed/simple;
	bh=/WxdcxVSVB55aSEvRfOAMjNtTpm8ccMC/c3OiQ0UWUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lz/PWGF8mqtYB0yv14cXBdBpJP6I8+YJiyq/mcUecbAc+6RCT/tOmit2w03a5q4jXRk5lkmWGBMIOVL9fDI+Lo/W5H3Psx3lPcpEYOM/dX7wE0j2L0faY35lZONj87K6YHEjA//TGQ80SsAuirA4xZ4lwusTCHRX7PzFJcQLV84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aa+vG2Tn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBA6C4CEF9;
	Tue, 12 Aug 2025 20:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755030811;
	bh=/WxdcxVSVB55aSEvRfOAMjNtTpm8ccMC/c3OiQ0UWUk=;
	h=From:To:Cc:Subject:Date:From;
	b=Aa+vG2TnRFOJ6eTw3Su47MFPjd/D78hBGV+oN4kdGZBDP6VeXBPiMF9/Elt+Iabcy
	 AYvaAOZ2jr6GWIIUd3IA28Gs9tp+xm0iuNG34wp5skHUuxEtn+KBE2qYCsZfKTtIyr
	 YTDnAbfUvscih0eIrrzykLUmvvslBPV857W+0AWQqx++GCFkzZX77ctD17/TEPhjc8
	 2ggC6brUvht/xbpkqGJ7jNsWavG9DnyiXefjPqy+r9agHJL7M9p18WRZaCuTwTi4A7
	 IvZDkWfw3G8In7PgtJf9kTM6ePPBZHGwroYWSmws1+X/1GpuLXzXCcEibrpVvej15j
	 BJMsPUwF4MPGQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wei Xu <xuwei5@hisilicon.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: interrupt-controller: Convert hisilicon,mbigen-v2 to DT schema
Date: Tue, 12 Aug 2025 15:33:25 -0500
Message-ID: <20250812203327.730393-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the HiSilicon MBIGEN binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../hisilicon,mbigen-v2.txt                   | 84 -------------------
 .../hisilicon,mbigen-v2.yaml                  | 76 +++++++++++++++++
 2 files changed, 76 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
deleted file mode 100644
index a6813a071f15..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
+++ /dev/null
@@ -1,84 +0,0 @@
-Hisilicon mbigen device tree bindings.
-=======================================
-
-Mbigen means: message based interrupt generator.
-
-MBI is kind of msi interrupt only used on Non-PCI devices.
-
-To reduce the wired interrupt number connected to GIC,
-Hisilicon designed mbigen to collect and generate interrupt.
-
-
-Non-pci devices can connect to mbigen and generate the
-interrupt by writing ITS register.
-
-The mbigen chip and devices connect to mbigen have the following properties:
-
-Mbigen main node required properties:
--------------------------------------------
-- compatible: Should be "hisilicon,mbigen-v2"
-
-- reg: Specifies the base physical address and size of the Mbigen
-  registers.
-
-Mbigen sub node required properties:
-------------------------------------------
-- interrupt controller: Identifies the node as an interrupt controller
-
-- msi-parent: Specifies the MSI controller this mbigen use.
-  For more detail information,please refer to the generic msi-parent binding in
-  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
-
-- num-pins: the total number of pins implemented in this Mbigen
-  instance.
-
-- #interrupt-cells : Specifies the number of cells needed to encode an
-  interrupt source. The value must be 2.
-
-  The 1st cell is hardware pin number of the interrupt.This number is local to
-  each mbigen chip and in the range from 0 to the maximum interrupts number
-  of the mbigen.
-
-  The 2nd cell is the interrupt trigger type.
-	The value of this cell should be:
-	1: rising edge triggered
-	or
-	4: high level triggered
-
-Examples:
-
-	mbigen_chip_dsa {
-			compatible = "hisilicon,mbigen-v2";
-			reg = <0x0 0xc0080000 0x0 0x10000>;
-
-			mbigen_gmac:intc_gmac {
-				interrupt-controller;
-				msi-parent = <&its_dsa 0x40b1c>;
-				num-pins = <9>;
-				#interrupt-cells = <2>;
-			};
-
-			mbigen_i2c:intc_i2c {
-				interrupt-controller;
-				msi-parent = <&its_dsa 0x40b0e>;
-				num-pins = <2>;
-				#interrupt-cells = <2>;
-			};
-	};
-
-Devices connect to mbigen required properties:
-----------------------------------------------------
--interrupts:Specifies the interrupt source.
- For the specific information of each cell in this property,please refer to
- the "interrupt-cells" description mentioned above.
-
-Examples:
-	gmac0: ethernet@c2080000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0 0xc2080000 0 0x20000>,
-		      <0 0xc0000000 0 0x1000>;
-		interrupt-parent  = <&mbigen_device_gmac>;
-		interrupts =	<656 1>,
-				<657 1>;
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.yaml b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.yaml
new file mode 100644
index 000000000000..326424e6e02a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/hisilicon,mbigen-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon mbigen v2
+
+maintainers:
+  - Wei Xu <xuwei5@hisilicon.com>
+
+description: >
+  Mbigen means: message based interrupt generator.
+
+  MBI is kind of msi interrupt only used on Non-PCI devices.
+
+  To reduce the wired interrupt number connected to GIC, Hisilicon designed
+  mbigen to collect and generate interrupt.
+
+  Non-pci devices can connect to mbigen and generate the interrupt by writing
+  ITS register.
+
+properties:
+  compatible:
+    const: hisilicon,mbigen-v2
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties:
+  type: object
+  additionalProperties: false
+
+  properties:
+    interrupt-controller: true
+
+    '#interrupt-cells':
+      const: 2
+
+    msi-parent:
+      maxItems: 1
+
+    num-pins:
+      description: The total number of pins implemented in this Mbigen instance.
+      $ref: /schemas/types.yaml#/definitions/uint32
+
+  required:
+    - interrupt-controller
+    - "#interrupt-cells"
+    - msi-parent
+    - num-pins
+
+examples:
+  - |
+    mbigen@c0080000 {
+        compatible = "hisilicon,mbigen-v2";
+        reg = <0xc0080000 0x10000>;
+
+        mbigen_gmac: intc_gmac {
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            msi-parent = <&its_dsa 0x40b1c>;
+            num-pins = <9>;
+        };
+
+        mbigen_i2c: intc_i2c {
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            msi-parent = <&its_dsa 0x40b0e>;
+            num-pins = <2>;
+        };
+    };
-- 
2.47.2


