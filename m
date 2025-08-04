Return-Path: <linux-kernel+bounces-755716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61989B1AAD6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 00:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C393A7A98AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 22:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFD029186F;
	Mon,  4 Aug 2025 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKJMQtCJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A052A28FAB3;
	Mon,  4 Aug 2025 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346046; cv=none; b=mJiUbcXjuyjRl/cPiaFXFALIoEOudF0P279C7bRFmk7Tw1K0PIasAaFN9yU6+1+6EPqR3oVP8UqB98FOmfs8ptUYJ/gzi/bn8h3RdISOYWsOhEm6VRov00wTf6NYzgcb5CthEp8pYdws0EP4wJcgOx7DW6WebQtFfHeBtPq68Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346046; c=relaxed/simple;
	bh=2mn5RqVbUfym8V59eqVfDF+BU2PEE4o4r392r1lvcAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ttG3zu+UnQwfhXfDg9UFrUpich9OFQi7zbIIZtnG5q4OdVO24kbmOiiVubJ9yJIdXuDJaGddQwoOZ6FW9WAgsKxtVr8eoIIpPtVLA+8NXz2+PP2hvIABTStcyAuLfSQZAprY6By9WxncTiWV9njfQesfAsI8tje4I7tWuy+JmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKJMQtCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20034C4CEE7;
	Mon,  4 Aug 2025 22:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754346046;
	bh=2mn5RqVbUfym8V59eqVfDF+BU2PEE4o4r392r1lvcAw=;
	h=From:To:Cc:Subject:Date:From;
	b=SKJMQtCJfRgnzXyZFcASx2TXB6KCWHzDson+Uga4ox3EpXUAYcH5vGUorvG4/KZx+
	 hXtMn/IDAJZ5BixV9D3I6KDE0eim3/cGvZ6fwkjznfbWjDqqHZu8CYM/BicEMq2LEb
	 vETud1INyotWAtxoLtzZ3fx5RCDbMjla0+ljxfxc05coEgKVmTiPW5Q86SC25nQSRx
	 lcFg/B0wyIujx6u298MLnOlKbo2cyEWdrOWJUGO5lvX1BOVRYV+3dJKzzcX4s5Mxxu
	 pcGh6IWzFPiG505JJ4IabrgpGyN/Cb5sAvGiWFVISMLIZNEaMn8yddApgIr86dmxsP
	 rYoBZxlDW7THQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: Convert silabs,si514/544 to DT schema
Date: Mon,  4 Aug 2025 17:20:40 -0500
Message-ID: <20250804222042.4083656-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Silicon Labs SI514 and SI544 bindings to DT schema format.
Combine the bindings into a single schema as they are the same.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/clock/silabs,si514.txt           | 24 ---------
 .../bindings/clock/silabs,si544.txt           | 25 ---------
 .../bindings/clock/silabs,si544.yaml          | 54 +++++++++++++++++++
 3 files changed, 54 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/silabs,si514.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/silabs,si544.txt
 create mode 100644 Documentation/devicetree/bindings/clock/silabs,si544.yaml

diff --git a/Documentation/devicetree/bindings/clock/silabs,si514.txt b/Documentation/devicetree/bindings/clock/silabs,si514.txt
deleted file mode 100644
index a4f28ec86f35..000000000000
--- a/Documentation/devicetree/bindings/clock/silabs,si514.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Binding for Silicon Labs 514 programmable I2C clock generator.
-
-Reference
-This binding uses the common clock binding[1]. Details about the device can be
-found in the datasheet[2].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Si514 datasheet
-    https://www.silabs.com/Support%20Documents/TechnicalDocs/si514.pdf
-
-Required properties:
- - compatible: Shall be "silabs,si514"
- - reg: I2C device address.
- - #clock-cells: From common clock bindings: Shall be 0.
-
-Optional properties:
- - clock-output-names: From common clock bindings. Recommended to be "si514".
-
-Example:
-	si514: clock-generator@55 {
-		reg = <0x55>;
-		#clock-cells = <0>;
-		compatible = "silabs,si514";
-	};
diff --git a/Documentation/devicetree/bindings/clock/silabs,si544.txt b/Documentation/devicetree/bindings/clock/silabs,si544.txt
deleted file mode 100644
index b86535b80920..000000000000
--- a/Documentation/devicetree/bindings/clock/silabs,si544.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Binding for Silicon Labs 544 programmable I2C clock generator.
-
-Reference
-This binding uses the common clock binding[1]. Details about the device can be
-found in the datasheet[2].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Si544 datasheet
-    https://www.silabs.com/documents/public/data-sheets/si544-datasheet.pdf
-
-Required properties:
- - compatible: One of "silabs,si514a", "silabs,si514b" "silabs,si514c" according
-               to the speed grade of the chip.
- - reg: I2C device address.
- - #clock-cells: From common clock bindings: Shall be 0.
-
-Optional properties:
- - clock-output-names: From common clock bindings. Recommended to be "si544".
-
-Example:
-	si544: clock-controller@55 {
-		reg = <0x55>;
-		#clock-cells = <0>;
-		compatible = "silabs,si544b";
-	};
diff --git a/Documentation/devicetree/bindings/clock/silabs,si544.yaml b/Documentation/devicetree/bindings/clock/silabs,si544.yaml
new file mode 100644
index 000000000000..f87e71867108
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/silabs,si544.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/silabs,si544.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Labs SI514/SI544 clock generator
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+description: >
+  Silicon Labs 514/544 programmable I2C clock generator. Details about the device
+  can be found in the datasheet:
+
+    https://www.silabs.com/Support%20Documents/TechnicalDocs/si514.pdf
+    https://www.silabs.com/documents/public/data-sheets/si544-datasheet.pdf
+
+properties:
+  compatible:
+    enum:
+      - silabs,si514
+      - silabs,si544a
+      - silabs,si544b
+      - silabs,si544c
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        clock-controller@55 {
+            reg = <0x55>;
+            #clock-cells = <0>;
+            compatible = "silabs,si544b";
+        };
+    };
-- 
2.47.2


