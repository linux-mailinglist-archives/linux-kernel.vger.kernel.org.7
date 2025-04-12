Return-Path: <linux-kernel+bounces-601388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC6EA86D39
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 15:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 716387B6475
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 13:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38771EE02E;
	Sat, 12 Apr 2025 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As+PVqeA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C01EB180;
	Sat, 12 Apr 2025 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744463776; cv=none; b=e+AN9TPD6pMHryxCtKOkJK+/g6R/Apc3O/XxhX0mGGWJ/vFtF/NuMpB8fA7vi1ddCGkaLtaREVFEhOZiSwUZjd5b1YybWzsmRYgy6BoG2dPZ3MqXmRjMNDu2EASfeYT9SGBwnwn5aTHdAW0fD5QV/QvSLvXyHjpIeJdCh57nZZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744463776; c=relaxed/simple;
	bh=MURwsuyoUYpu+J9Sp8ByVAlVg6BvIk5LgpENmqd0/OM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/MASMgrb6aW5n0/Sj9A48Haow6+MLXif7P2RikzV7cO/YBpnG9U7VgwpXDQ0/rt4SOng+VhTbNwJz6575F3LlVGDI7YXZhgdnAKzU2Q8ZE7PmC1sQcoFEqbWdjKMzSTKZSTnHFY4lWoxVCAxCftD8obubhAX4i4KGpqrayFVKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As+PVqeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0B24C4CEF5;
	Sat, 12 Apr 2025 13:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744463775;
	bh=MURwsuyoUYpu+J9Sp8ByVAlVg6BvIk5LgpENmqd0/OM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=As+PVqeAMhwZROsaGQzza0reSyqZkcAMRRB93psPnUaj/4BUQSJj+y7ZI5z/oe3KS
	 wtuGblLFel5cKvgceFyGXwEvlYOm7D2tbTxvWB8+8IjI9FjyGfNb922g/0iiRe+G5O
	 Lv9aejNuZ2zVRVl4pHHZiN0FLcGO2a3Ps7ekptd8sXVN5hFx5wYEPkuP4MlBYw+Jf4
	 vCO6SzMpHO3MQaJ2ETI7pnrA9zZBwg5eWduErBH7IN6m5iNGmFkw7OEYQtqGTAq0V3
	 sx7FATJ4VNEdZeYe2dpfxH42xfr7syvGuOMbsUv6D8EvJFWrTblyZQ1Uh4u3CejlRj
	 8uzt0dFePVTDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F2C369B5;
	Sat, 12 Apr 2025 13:16:15 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sat, 12 Apr 2025 15:16:05 +0200
Subject: [PATCH v5 4/4] dt-bindings: memory-controllers: Convert fsl,elbc
 to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250412-ppcyaml-elbc-v5-4-03f0e577139f@posteo.net>
References: <20250412-ppcyaml-elbc-v5-0-03f0e577139f@posteo.net>
In-Reply-To: <20250412-ppcyaml-elbc-v5-0-03f0e577139f@posteo.net>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Crystal Wood <oss@buserror.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744463772; l=9297;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=x6nGrqs6VM0yQmH2zllPJ1GAbrECSG8dXA1TtNTrcHY=;
 b=hg2aoNhvqxqi85PQ7vbKOSMOmWuEXgqqh4fFGs8hhOXrhXoDbt6Csr5dSX+Zs2hLa8V47Ay0I
 VJ+I4HyK743AfAUhbCVkzJLtohurN87EUq5CBCguVXr3f7k6b10zfIu
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Convert the Freescale localbus controller bindings from text form to
YAML. Compared to the .txt version, the YAML binding contains a new
usage example with FCM NAND flash, and a full list of compatible strings
based on current usage in arch/powerpc/boot/dts/.

Note that the both the compatible strings and the unit address format
are kept as-is, for compatibility with existing kernels and device
trees, as well as unit address readability. This results in dts
validation warnings:

  Warning (simple_bus_reg): /example-0/localbus@f0010100/board-control@1,0:
  simple-bus unit address format error, expected "100000000"

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V5:
- fix reference to fsl/lbc.txt in
  Documentation/devicetree/bindings/display/ssd1289fb.txt

V4:
- no changes

V3:
- move this patch after the GPCM/FCM patches to dtschema/dtc warnings
  due to missing bindings for fsl,elbc-gpcm-uio and fsl,elbc-fcm-nand
- add "simple-bus" again, for compatibility with existing DTs/drivers
  based on discussion with Crystal Wood and Rob Herring
- fix fsl,pq2-localbus compatible properties based on mgcoge.dts / ep8248e.dts
  (was missing "simple-bus")
- add board-control (bcsr) example again, now using the compatible
  string listed in Documentation/devicetree/bindings/board/fsl,bcsr.yaml
- remove interrupt-parent property from example
- rework the commit message

V2:
- fix order of properties in examples, according to dts coding style
- move to Documentation/devicetree/bindings/memory-controllers
- clarify the commit message a tiny bit
- remove unnecessary multiline markers (|)
- define address format in patternProperties
- trim subject line (remove "binding")
- remove use of "simple-bus", because it's technically incorrect
---
 .../devicetree/bindings/display/ssd1289fb.txt      |   2 +-
 .../bindings/memory-controllers/fsl,elbc.yaml      | 158 +++++++++++++++++++++
 .../devicetree/bindings/powerpc/fsl/lbc.txt        |  43 ------
 3 files changed, 159 insertions(+), 44 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ssd1289fb.txt b/Documentation/devicetree/bindings/display/ssd1289fb.txt
index 4fcd5e68cb6e005927f87c0c36d843de640de525..8cb59359352c6834aff73771ba2e12d0e4563ded 100644
--- a/Documentation/devicetree/bindings/display/ssd1289fb.txt
+++ b/Documentation/devicetree/bindings/display/ssd1289fb.txt
@@ -4,7 +4,7 @@ Required properties:
   - compatible: Should be "solomon,ssd1289fb". The only supported bus for
     now is lbc.
   - reg: Should contain address of the controller on the LBC bus. The detail
-    was described in Documentation/devicetree/bindings/powerpc/fsl/lbc.txt
+    was described in Documentation/devicetree/bindings/memory-controllers/fsl,elbc.yaml
 
 Examples:
 display@2,0 {
diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl,elbc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl,elbc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..620d7e7c62df35c754a01498391d35ede03cdf87
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl,elbc.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/fsl,elbc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Enhanced Local Bus Controller
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+properties:
+  $nodename:
+    pattern: "^localbus@[0-9a-f]+$"
+
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,mpc8313-elbc
+              - fsl,mpc8315-elbc
+              - fsl,mpc8377-elbc
+              - fsl,mpc8378-elbc
+              - fsl,mpc8379-elbc
+              - fsl,mpc8536-elbc
+              - fsl,mpc8569-elbc
+              - fsl,mpc8572-elbc
+              - fsl,p1020-elbc
+              - fsl,p1021-elbc
+              - fsl,p1023-elbc
+              - fsl,p2020-elbc
+              - fsl,p2041-elbc
+              - fsl,p3041-elbc
+              - fsl,p4080-elbc
+              - fsl,p5020-elbc
+              - fsl,p5040-elbc
+          - const: fsl,elbc
+          - const: simple-bus
+
+      - items:
+          - enum:
+              - fsl,mpc8247-localbus
+              - fsl,mpc8248-localbus
+              - fsl,mpc8272-localbus
+          - const: fsl,pq2-localbus
+          - const: simple-bus
+
+      - items:
+          - enum:
+              - fsl,mpc8247-localbus
+              - fsl,mpc8248-localbus
+              - fsl,mpc8360-localbus
+          - const: fsl,pq2pro-localbus
+          - const: simple-bus
+
+      - items:
+          - enum:
+              - fsl,mpc8540-localbus
+              - fsl,mpc8544-lbc
+              - fsl,mpc8544-localbus
+              - fsl,mpc8548-lbc
+              - fsl,mpc8548-localbus
+              - fsl,mpc8560-localbus
+              - fsl,mpc8568-localbus
+          - const: fsl,pq3-localbus
+          - const: simple-bus
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#address-cells":
+    enum: [2, 3]
+    description:
+      The first cell is the chipselect number, and the remaining cells are the
+      offset into the chipselect.
+
+  "#size-cells":
+    enum: [1, 2]
+    description:
+      Either one or two, depending on how large each chipselect can be.
+
+  ranges:
+    description:
+      Each range corresponds to a single chipselect, and covers the entire
+      access window as configured.
+
+patternProperties:
+  # format: name@chipselect,address
+  "^.*@[0-9a-f]+,[0-9a-f]+$":
+    type: object
+
+additionalProperties: false
+
+examples:
+  - |
+    localbus@f0010100 {
+        compatible = "fsl,mpc8272-localbus",
+                     "fsl,pq2-localbus",
+                     "simple-bus";
+        reg = <0xf0010100 0x40>;
+        ranges = <0x0 0x0 0xfe000000 0x02000000
+                  0x1 0x0 0xf4500000 0x00008000
+                  0x2 0x0 0xfd810000 0x00010000>;
+        #address-cells = <2>;
+        #size-cells = <1>;
+
+        flash@0,0 {
+            compatible = "jedec-flash";
+            reg = <0x0 0x0 0x2000000>;
+            bank-width = <4>;
+            device-width = <1>;
+        };
+
+        board-control@1,0 {
+            reg = <0x1 0x0 0x20>;
+            compatible = "fsl,mpc8360mds-bcsr";
+        };
+
+        simple-periph@2,0 {
+            compatible = "fsl,elbc-gpcm-uio";
+            reg = <0x2 0x0 0x10000>;
+            elbc-gpcm-br = <0xfd810800>;
+            elbc-gpcm-or = <0xffff09f7>;
+        };
+    };
+
+  - |
+    localbus@e0005000 {
+        compatible = "fsl,mpc8315-elbc", "fsl,elbc", "simple-bus";
+        reg = <0xe0005000 0x1000>;
+        ranges = <0x0 0x0 0xfe000000 0x00800000
+                  0x1 0x0 0xe0600000 0x00002000
+                  0x2 0x0 0xf0000000 0x00020000
+                  0x3 0x0 0xfa000000 0x00008000>;
+        #address-cells = <2>;
+        #size-cells = <1>;
+        interrupts = <77 0x8>;
+
+        flash@0,0 {
+            compatible = "cfi-flash";
+            reg = <0x0 0x0 0x800000>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            bank-width = <2>;
+            device-width = <1>;
+        };
+
+        nand@1,0 {
+            compatible = "fsl,mpc8315-fcm-nand",
+                         "fsl,elbc-fcm-nand";
+            reg = <0x1 0x0 0x2000>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/lbc.txt b/Documentation/devicetree/bindings/powerpc/fsl/lbc.txt
deleted file mode 100644
index 1c80fcedebb52049721fbd61c4dd4c57133bd47c..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/powerpc/fsl/lbc.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-* Chipselect/Local Bus
-
-Properties:
-- name : Should be localbus
-- #address-cells : Should be either two or three.  The first cell is the
-                   chipselect number, and the remaining cells are the
-                   offset into the chipselect.
-- #size-cells : Either one or two, depending on how large each chipselect
-                can be.
-- ranges : Each range corresponds to a single chipselect, and cover
-           the entire access window as configured.
-
-Example:
-	localbus@f0010100 {
-		compatible = "fsl,mpc8272-localbus",
-			   "fsl,pq2-localbus";
-		#address-cells = <2>;
-		#size-cells = <1>;
-		reg = <0xf0010100 0x40>;
-
-		ranges = <0x0 0x0 0xfe000000 0x02000000
-			  0x1 0x0 0xf4500000 0x00008000
-			  0x2 0x0 0xfd810000 0x00010000>;
-
-		flash@0,0 {
-			compatible = "jedec-flash";
-			reg = <0x0 0x0 0x2000000>;
-			bank-width = <4>;
-			device-width = <1>;
-		};
-
-		board-control@1,0 {
-			reg = <0x1 0x0 0x20>;
-			compatible = "fsl,mpc8272ads-bcsr";
-		};
-
-		simple-periph@2,0 {
-			compatible = "fsl,elbc-gpcm-uio";
-			reg = <0x2 0x0 0x10000>;
-			elbc-gpcm-br = <0xfd810800>;
-			elbc-gpcm-or = <0xffff09f7>;
-		};
-	};

-- 
2.48.0.rc1.219.gb6b6757d772



