Return-Path: <linux-kernel+bounces-755714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0683BB1AAD0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 00:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BD8189D66B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 22:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5125D28FFC7;
	Mon,  4 Aug 2025 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im+NznBF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6D6238C07;
	Mon,  4 Aug 2025 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346030; cv=none; b=C7+KJT7Mm8bvWdvtelhxmOpNdKfsd1aAF0s6UAcsfust1QrYZqujjOdJDAYWGM3CU+9a6lAVcGbt9BbYs2b9cPkFhwJOjL+mViMbK7SSaKC2fQEPpZzeHZo6laHBuMyHsLAzspDVNHPLSxCx3q3O9b38E73bIa+mxiDJT3NsFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346030; c=relaxed/simple;
	bh=DVYWSBFwTSr15UcNlPu6a/Ns2qL5toqSnGkQ2dXq2ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hr7R7tz9nelycf1hjBwVT6YPXgzEq3O8HZmQiyk2siZVYhrQlYmepzFW4CpFvOqFjk2y03XmFTs0G7IwI/ptqIJuookrGq0nzZ9jNeiKnRUCduJIiCwjuRZR9ktB72xJQ2SmIdfbhAgwadlSYqhzIbY5QdDjbBb6CapnXuy92vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im+NznBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0080DC4CEE7;
	Mon,  4 Aug 2025 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754346030;
	bh=DVYWSBFwTSr15UcNlPu6a/Ns2qL5toqSnGkQ2dXq2ck=;
	h=From:To:Cc:Subject:Date:From;
	b=im+NznBFDCsRNR5x0GiD9D9xVNJyDVyuDNjpbNpckEuWlvde+WW1Zof1bxaDap3yL
	 3EqOqBs5WD/ZzYCL9S0iDwHaAFYaV8D++b0htYqgr5vB31y9XQ3f8lhs23iAafXOJw
	 F/cCNOB3rygot1cOgAWMxYJTfnxNa0igxsjwUkVUn7VS8DBqrcEaxODw/tyNxNbImE
	 SuJp1tCS/RKa78jWbnv7u0UWl3xX46rwSx+7q23N2//JxSWb1snbwvbGGS+3IiiiTW
	 Y0riuruf8XgNz0qtc0b0/kccwHWi8G2dqZvRE8GC3VLFh6yhWoAk9ERjceAUhrrtlp
	 AZbtbjaIjSn2g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: Convert silabs,si570 to DT schema
Date: Mon,  4 Aug 2025 17:20:08 -0500
Message-ID: <20250804222010.4082782-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Silicon Labs SI570 binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/clock/silabs,si570.txt           | 41 ----------
 .../bindings/clock/silabs,si570.yaml          | 80 +++++++++++++++++++
 2 files changed, 80 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/silabs,si570.txt
 create mode 100644 Documentation/devicetree/bindings/clock/silabs,si570.yaml

diff --git a/Documentation/devicetree/bindings/clock/silabs,si570.txt b/Documentation/devicetree/bindings/clock/silabs,si570.txt
deleted file mode 100644
index 5dda17df1ac5..000000000000
--- a/Documentation/devicetree/bindings/clock/silabs,si570.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Binding for Silicon Labs 570, 571, 598 and 599 programmable
-I2C clock generators.
-
-Reference
-This binding uses the common clock binding[1]. Details about the devices can be
-found in the data sheets[2][3].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Si570/571 Data Sheet
-    https://www.silabs.com/Support%20Documents/TechnicalDocs/si570.pdf
-[3] Si598/599 Data Sheet
-    https://www.silabs.com/Support%20Documents/TechnicalDocs/si598-99.pdf
-
-Required properties:
- - compatible: Shall be one of "silabs,si570", "silabs,si571",
-			       "silabs,si598", "silabs,si599"
- - reg: I2C device address.
- - #clock-cells: From common clock bindings: Shall be 0.
- - factory-fout: Factory set default frequency. This frequency is part specific.
-		 The correct frequency for the part used has to be provided in
-		 order to generate the correct output frequencies. For more
-		 details, please refer to the data sheet.
- - temperature-stability: Temperature stability of the device in PPM. Should be
-			  one of: 7, 20, 50 or 100.
-
-Optional properties:
- - clock-output-names: From common clock bindings. Recommended to be "si570".
- - clock-frequency: Output frequency to generate. This defines the output
-		    frequency set during boot. It can be reprogrammed during
-		    runtime through the common clock framework.
- - silabs,skip-recall: Do not perform NVM->RAM recall operation. It will rely
-		       on hardware loading of RAM from NVM at power on.
-
-Example:
-	si570: clock-generator@5d {
-		#clock-cells = <0>;
-		compatible = "silabs,si570";
-		temperature-stability = <50>;
-		reg = <0x5d>;
-		factory-fout = <156250000>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/silabs,si570.yaml b/Documentation/devicetree/bindings/clock/silabs,si570.yaml
new file mode 100644
index 000000000000..90e2f79e2b2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/silabs,si570.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/silabs,si570.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Labs Si570/Si571/Si598/Si599 programmable I2C clock generator
+
+maintainers:
+  - Soren Brinkmann <soren.brinkmann@xilinx.com>
+
+description: >
+  Silicon Labs 570, 571, 598 and 599 programmable I2C clock generators. Details
+  about the devices can be found in the data sheets[1][2].
+
+  [1] Si570/571 Data Sheet
+      https://www.silabs.com/Support%20Documents/TechnicalDocs/si570.pdf
+  [2] Si598/599 Data Sheet
+      https://www.silabs.com/Support%20Documents/TechnicalDocs/si598-99.pdf
+
+properties:
+  compatible:
+    enum:
+      - silabs,si570
+      - silabs,si571
+      - silabs,si598
+      - silabs,si599
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 0
+
+  factory-fout:
+    description: Factory-set default frequency in Hz.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  temperature-stability:
+    description: Temperature stability of the device in PPM.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 7
+      - 20
+      - 50
+      - 100
+
+  clock-output-names:
+    maxItems: 1
+
+  clock-frequency:
+    description: Output frequency to generate at boot; can be reprogrammed at runtime.
+
+  silabs,skip-recall:
+    description: Skip the NVM-to-RAM recall operation during boot.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - factory-fout
+  - temperature-stability
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        clock-generator@5d {
+            compatible = "silabs,si570";
+            reg = <0x5d>;
+            #clock-cells = <0>;
+            temperature-stability = <50>;
+            factory-fout = <156250000>;
+        };
+    };
-- 
2.47.2


