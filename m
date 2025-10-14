Return-Path: <linux-kernel+bounces-852997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65961BDA6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515663E195C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2E4307481;
	Tue, 14 Oct 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Og5oQqcE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F4A3054F8;
	Tue, 14 Oct 2025 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455815; cv=none; b=epa+YPxZmHwtCPuHBPAKauMEsPUNvByU2Go3pUL+Yshkgw6Nw2HcIXyU+Wcvzsxn9QCcoeaC0rrPDZJh5L6Oxk2I6U7HUdZm2Rbjul24EUoL90FfLaPZwMyt4KE9Emp/drMZPVvgRyvQ4IzT4M403Jj3yEJc8ox521EhsCxh8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455815; c=relaxed/simple;
	bh=MFnFv9d3xt1vf/MPIoUFAkY1AMxFAwUt3JMO8lZ7920=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c+OBrYMcJahG1HsfDBgmM4cJREfNXkUyDreRT3Y2zFj/uDEiPiJRf4r124WQ4Jd/qPjMeDA2WHf2ZhhQW98Do59lQaNNUif6ilGIAaq1MIVK0VMab6r718mYCdwSyTkObRHnqOKxncKPjyKPHWH7HqbuKP+JZPkCpbHsjx/W/j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Og5oQqcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09454C4CEE7;
	Tue, 14 Oct 2025 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760455815;
	bh=MFnFv9d3xt1vf/MPIoUFAkY1AMxFAwUt3JMO8lZ7920=;
	h=From:To:Cc:Subject:Date:From;
	b=Og5oQqcEWINQUf63s7d/31hL40MuxUdYfUwlY07fEsykiqeUI8utZ2wOifFSaQaGN
	 s5bJmYbcRxy9aCnMcrzmasLRu+kUhiUnhb9a0b2dZ1tyQKuJl0zSaEgrJWHNc0Vcdp
	 C+GeyhjiRd6F752au1+Utl4e2sAgqO4PjY0PxDlHt/QeM5dJSmXyZ1oiT7d7I0tMc4
	 4nKlsYKoKExJRXhLZ+u+ERXi+Z8UbDk0JECa6CF4ah2jv5DqHwpeHE24WpV4EozYGZ
	 xSID1cnYsoSJmb8D56GA/OCZkZGcpmtJF338XtYvD7235Em7OhuIiHHXqw1hWf5YyL
	 7W2jYNtlWl5DA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: bus: Convert cznic,moxtet to DT schema
Date: Tue, 14 Oct 2025 10:30:05 -0500
Message-ID: <20251014153009.3783183-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the cznic,moxtet binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/bus/cznic,moxtet.yaml | 94 +++++++++++++++++++
 .../devicetree/bindings/bus/moxtet.txt        | 46 ---------
 MAINTAINERS                                   |  2 +-
 3 files changed, 95 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/cznic,moxtet.yaml
 delete mode 100644 Documentation/devicetree/bindings/bus/moxtet.txt

diff --git a/Documentation/devicetree/bindings/bus/cznic,moxtet.yaml b/Documentation/devicetree/bindings/bus/cznic,moxtet.yaml
new file mode 100644
index 000000000000..d340899ca5f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/cznic,moxtet.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/cznic,moxtet.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Turris Moxtet SPI bus
+
+maintainers:
+  - Marek Behún <kabel@kernel.org>
+
+description: >
+  Turris Mox module status and configuration bus (over SPI)
+
+  The driver finds the devices connected to the bus by itself, but it may be
+  needed to reference some of them from other parts of the device tree. In that
+  case the devices can be defined as subnodes of the moxtet node.
+
+properties:
+  compatible:
+    const: cznic,moxtet
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  spi-cpol: true
+
+  spi-cpha: true
+
+  spi-max-frequency: true
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - spi-cpol
+  - spi-cpha
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+additionalProperties:
+  type: object
+
+  required:
+    - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        moxtet@1 {
+            compatible = "cznic,moxtet";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <1>;
+            spi-max-frequency = <10000000>;
+            spi-cpol;
+            spi-cpha;
+            interrupt-controller;
+            #interrupt-cells = <1>;
+            interrupt-parent = <&gpiosb>;
+            interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+
+            gpio@0 {
+                compatible = "cznic,moxtet-gpio";
+                gpio-controller;
+                #gpio-cells = <2>;
+                reg = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/bus/moxtet.txt b/Documentation/devicetree/bindings/bus/moxtet.txt
deleted file mode 100644
index fb50fc865336..000000000000
--- a/Documentation/devicetree/bindings/bus/moxtet.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-Turris Mox module status and configuration bus (over SPI)
-
-Required properties:
- - compatible		: Should be "cznic,moxtet"
- - #address-cells	: Has to be 1
- - #size-cells		: Has to be 0
- - spi-cpol		: Required inverted clock polarity
- - spi-cpha		: Required shifted clock phase
- - interrupts		: Must contain reference to the shared interrupt line
- - interrupt-controller	: Required
- - #interrupt-cells	: Has to be 1
-
-For other required and optional properties of SPI slave nodes please refer to
-../spi/spi-bus.txt.
-
-Required properties of subnodes:
- - reg			: Should be position on the Moxtet bus (how many Moxtet
-			  modules are between this module and CPU module, so
-			  either 0 or a positive integer)
-
-The driver finds the devices connected to the bus by itself, but it may be
-needed to reference some of them from other parts of the device tree. In that
-case the devices can be defined as subnodes of the moxtet node.
-
-Example:
-
-	moxtet@1 {
-		compatible = "cznic,moxtet";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <1>;
-		spi-max-frequency = <10000000>;
-		spi-cpol;
-		spi-cpha;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-		interrupt-parent = <&gpiosb>;
-		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
-
-		moxtet_sfp: gpio@0 {
-			compatible = "cznic,moxtet-gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-			reg = <0>;
-		}
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 1741b9f549d2..7196970eed39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2658,7 +2658,7 @@ F:	Documentation/ABI/testing/debugfs-moxtet
 F:	Documentation/ABI/testing/sysfs-bus-i2c-devices-turris-omnia-mcu
 F:	Documentation/ABI/testing/sysfs-bus-moxtet-devices
 F:	Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm
-F:	Documentation/devicetree/bindings/bus/moxtet.txt
+F:	Documentation/devicetree/bindings/bus/cznic,moxtet.yaml
 F:	Documentation/devicetree/bindings/firmware/cznic,turris-mox-rwtm.txt
 F:	Documentation/devicetree/bindings/firmware/cznic,turris-omnia-mcu.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/marvell,mpic.yaml
-- 
2.51.0


