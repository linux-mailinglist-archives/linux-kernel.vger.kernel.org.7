Return-Path: <linux-kernel+bounces-760293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18332B1E910
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CDE1891831
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C913327CB0A;
	Fri,  8 Aug 2025 13:20:49 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F308520ED;
	Fri,  8 Aug 2025 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754659249; cv=none; b=RphkgG+Zmp2UACwRu8QvgwGyRiIyfCzV/+T6llwlPfJv2c0YPy51HtqP8zeX2Mm4g/sBgxUSpHV0WXIdM+wvsW5hEL8hQnzSPlxIWjI9rlY6fiT1grcZIgs7VLrllKwd5NQdyQn66g6xP4S8m2oTFgg4ato/r+eAgg+SgEBb11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754659249; c=relaxed/simple;
	bh=ccSlfqK98k4Z4CeD+PTJ/CnCVK7D8bzIrMfyEBolLS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gd+72hq+3E4W0TatDtHiKfgzS1i8r2lgno6SgH3XUciR1S4qyFEyvZ4imjtM3B7ljJiPqEpUxAQ5GSG7pcACP6eoZ4/SofZixuL7ZuRT9ruBiehTA2/0Bnwwx4RFIG1fbuMuhZL8mL3nNw+m1P93eAAQmceWu2JgFSgeNktOl30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0BE64201BE9;
	Fri,  8 Aug 2025 15:20:39 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E8FE7201BE4;
	Fri,  8 Aug 2025 15:20:38 +0200 (CEST)
Received: from lsv15573.swis.ro-buh01.nxp.com (lsv15573.swis.ro-buh01.nxp.com [10.172.0.77])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CB8AD2035C;
	Fri,  8 Aug 2025 15:20:37 +0200 (CEST)
From: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
To: linux-kernel@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	alexandre.belloni@bootlin.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	lee@kernel.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com,
	Frank.Li@nxp.com,
	Aman Kumar Pandey <aman.kumarpandey@nxp.com>
Subject: [PATCH v3 1/2] dt-bindings: i3c: Add NXP P3H2x4x i3c-hub support
Date: Fri,  8 Aug 2025 16:20:32 +0300
Message-Id: <20250808132033.3996614-1-aman.kumarpandey@nxp.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add bindings for the NXP P3H2x4x (P3H2440/P3H2441/P3H2840/P3H2841)
multiport I3C hub family. These devices connect to a host via
I3C/I2C/SMBus and allow communication with multiple downstream
peripherals.

Signed-off-by: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
Signed-off-by: Vikash Bansal <vikash.bansal@nxp.com>

---
V1 -> V2: Cleaned up coding style and addressed review comments
V2 -> V3: Added mfd device support for i3c hub and regulator.
---
 .../bindings/mfd/nxp,p3h2840-i3c-hub.yaml     | 320 ++++++++++++++++++
 MAINTAINERS                                   |   8 +
 2 files changed, 328 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/nxp,p3h2840-i3c-hub.yaml

diff --git a/Documentation/devicetree/bindings/mfd/nxp,p3h2840-i3c-hub.yaml b/Documentation/devicetree/bindings/mfd/nxp,p3h2840-i3c-hub.yaml
new file mode 100644
index 000000000000..490595c94627
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/nxp,p3h2840-i3c-hub.yaml
@@ -0,0 +1,320 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 NXP
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/nxp,p3h2840-i3c-hub.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP P3H2X4X I3C HUB
+
+maintainers:
+  - Aman Kumar Pandey <aman.kumarpandey@nxp.com>
+  - Vikash Bansal <vikash.bansal@nxp.com>
+
+description: |
+  P3H2x4x (P3H2440/P3H2441/P3H2840/P3H2841) is a family of multiport I3C
+  hub devices that connect to:-
+  1. A host CPU via I3C/I2C/SMBus bus on upstream side and connect to multiple
+     peripheral devices on the downstream  side.
+  2. Have two Controller Ports which can support either
+     I2C/SMBus or I3C buses and connect to a CPU, BMC or SOC.
+  3. P3H2840/ P3H2841 are 8 port I3C hub with eight I3C/I2C Target Port.
+  4. P3H2440/ P3H2441 are 4 port I3C hub with four I3C/I2C Target Port.
+     Target ports can be configured as I2C/SMBus, I3C or GPIO and connect to
+     peripherals.
+
+allOf:
+  - $ref: i3c.yaml#
+
+properties:
+  compatible:
+   items:
+     - const: nxp,p3h2840
+
+  cp0-ldo-microvolt:
+    description:
+      Selects the voltage for controller Port 0, in microvolts.
+    enum: [1000000, 1100000, 1200000, 1800000]
+    default: 1000000
+
+  cp1-ldo-microvolt:
+    description:
+      Selects the voltage for controller Port 1, in microvolts.
+    enum: [1000000, 1100000, 1200000, 1800000]
+    default: 1000000
+
+  tp0145-ldo-microvolt:
+    description:
+      Selects the voltage for target Port 0/1/4/5, in microvolts.
+    enum: [1000000, 1100000, 1200000, 1800000]
+    default: 1000000
+
+  tp2367-ldo-microvolt:
+    description:
+      Selects the voltage for target Port 2/3/6/7, in microvolts.
+    enum: [1000000, 1100000, 1200000, 1800000]
+    default: 1000000
+
+  tp0145-pullup-ohms:
+    description:
+      Selects the pull up resistance for target Port 0/1/4/5, in ohms.
+    enum: [250, 500, 1000, 2000]
+    default: 500
+
+  tp2367-pullup-ohms:
+    description:
+      Selects the pull up resistance for target Port 2/3/6/7, in ohms.
+    enum: [250, 500, 1000, 2000]
+    default: 500
+
+  cp0-io-strength-ohms:
+    description:
+      Selects the IO drive strength for controller Port 0, in ohms.
+    enum: [20, 30, 40, 50]
+    default: 20
+
+  cp1-io-strength-ohms:
+    description:
+      Selects the IO drive strength for controller Port 1, in ohms.
+    enum: [20, 30, 40, 50]
+    default: 20
+
+  tp0145-io-strength-ohms:
+    description:
+      Selects the IO drive strength for target port 0/1/4/5, in ohms.
+    enum: [20, 30, 40, 50]
+    default: 20
+
+  tp2367-io-strength-ohms:
+    description:
+      Selects the IO drive strength for target port 2/3/6/7, in ohms.
+    enum: [20, 30, 40, 50]
+    default: 20
+
+  cp0-supply:
+    description: Phandle to voltage regulator providing power to controller port 0.
+
+  cp1-supply:
+    description: Phandle to voltage regulator providing power to controller port 1.
+
+  tp0145-supply:
+    description: Phandle to voltage regulator providing power to target port 0/1/4/5.
+
+  tp2367-supply:
+    description: Phandle to voltage regulator providing power to target port 2/3/6/7.
+
+  regulators:
+    type: object
+    additionalProperties: false
+
+    properties:
+      cp0:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+      cp1:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+      tp0145:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+      tp2367:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+patternProperties:
+  "@[0-7]$":
+    type: object
+    additionalProperties: false
+    description:
+      I3C HUB Target Port child, should be named as target-port@<target-port-id>
+
+    properties:
+      reg:
+        description:
+          The I3C HUB Target Port number.
+        minimum: 0
+        maximum: 0x07
+
+      mode:
+        enum: [i3c, smbus, i2c, gpio]
+        description:
+          I3C HUB Target Port mode setting to control Target Port functionality.
+          As per now it is only supporting SMBus, i2c and i3c( i2c mode will work
+          with hub network).
+
+      pullup-enable:
+        type: boolean
+        description:
+          Enables the on-die pull-up for Target Port.
+
+      ibi-enable:
+        type: boolean
+        description:
+          Enables the IBI for Target Port.
+
+      local-dev:
+        $ref: /schemas/types.yaml#/definitions/uint8-array
+        description:
+          SMBus Target Agent can discard transactions of downstream device and not generate an IBI to upstream I3C Hub
+          Controller Port. Up to 8 device (addresses) can be configured as local Devices.
+
+          This property is optional. If not provided, local device list will empty.
+
+      hub_bridge_en:
+        type: boolean
+        description:
+          Enables the hub network (Controller port -> target port).
+
+    patternProperties:
+      "@[0-9a-f]+$":
+        type: object
+        additionalProperties: false
+        description: |
+          I2C child, should be named: <device-type>@<i2c-address>
+
+        properties:
+          compatible:
+            description:
+              Compatible of the I2C/SMBus downstream device.
+
+          reg:
+            description: |
+              I2C address, Downstream device address which are connected to target port.
+            minimum: 0
+            maximum: 0x7f
+
+        required:
+          - compatible
+          - reg
+
+      "@[0-9a-f]+,[0-9a-f]+$":
+        type: object
+        additionalProperties: false
+        description: |
+          I3C child, should be named: <device-type>@<static-i2c-address>,<i3c-pid>
+
+        properties:
+          reg:
+            items:
+              - items:
+                  - description:
+                      Encodes the static I2C address. Should be 0 if the device does
+                      not have one (0 is not a valid I2C address).
+                    minimum: 0
+                    maximum: 0x7f
+                  - description: |
+                      First half of the Provisioned ID (following the PID
+                      definition provided by the I3C specification).
+
+                      Contains the manufacturer ID left-shifted by 1.
+                  - description: |
+                      Second half of the Provisioned ID (following the PID
+                      definition provided by the I3C specification).
+
+                      Contains the ORing of the part ID left-shifted by 16,
+                      the instance ID left-shifted by 12 and extra information.
+
+          assigned-address:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0x1
+            maximum: 0xff
+            description:
+              Dynamic address to be assigned to this device. In case static address is
+              present (first cell of the reg property != 0), this address is assigned
+              through SETDASA. If static address is not present, this address is assigned
+              through SETNEWDA after assigning a temporary address via ENTDAA.
+
+        required:
+          - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i3c {
+        #address-cells = <3>;
+        #size-cells = <0>;
+
+        hub@70,236153000c2 {
+            reg = <0x70 0x236 0x3000c2>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            assigned-address = <0x50>;
+
+            cp0-ldo-microvolt = <1800000>;
+            cp1-ldo-microvolt = <1800000>;
+            tp0145-ldo-microvolt = <1800000>;
+            tp2367-ldo-microvolt = <1800000>;
+            tp0145-pullup-ohm = <1000>;
+            tp2367-pullup-ohm = <1000>;
+            cp0-io-strength-ohm = <50>;
+            cp1-io-strength-ohm = <50>;
+            tp0145-io-strength-ohm = <50>;
+            tp2367-io-strength-ohm = <50>;
+            cp0-supply = <&cp0>;
+            tp0145-supply = <&tp0145>;
+
+            regulators {
+              cp0 {
+                regulator-name = "cp0";
+                regulator-min-microvolt = <1000000>;
+                regulator-max-microvolt = <1800000>;
+              };
+
+              cp1 {
+                regulator-name = "cp1";
+                regulator-min-microvolt = <1000000>;
+                regulator-max-microvolt = <1800000>;
+              };
+
+              tp0145 {
+                regulator-name = "tp0145";
+                regulator-min-microvolt = <1000000>;
+                regulator-max-microvolt = <1800000>;
+              };
+
+              tp2367 {
+                regulator-name = "tp2367";
+                regulator-min-microvolt = <1000000>;
+                regulator-max-microvolt = <1800000>;
+              };
+            };
+
+            target-port@0 {
+                reg = <0x0>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                mode = "smbus";
+                pullup-enable;
+
+                eeprom@57 {
+                    compatible = "atmel,24c32";
+                    reg = <0x57>;
+                    pagesize = <32>;
+                    wp-gpios = <&gpio2 2 0>;
+                    num-addresses = <8>;
+                };
+            };
+
+            target-port@2 {
+                reg = <0x2>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                mode = "i3c";
+                pullup-enable;
+
+                sensor@68,39200144004 {
+                  reg = <0x68 0x392 0x144004>;
+                  assigned-address = <0xa>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 4262e8d833c4..b33e90030188 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15477,6 +15477,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
 F:	sound/soc/codecs/tfa989x.c
 
+NXP P3H2X4X I3C-HUB DRIVER
+M:	Vikash Bansal <vikash.bansal@nxp.com>
+M:	Aman Kumar Pandey <aman.kumarpandey@nxp.com>
+L:	linux-kernel@vger.kernel.org
+L:	linux-i3c-owner@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml
+
 NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
 M:	Jonas Malaco <jonas@protocubo.io>
 L:	linux-hwmon@vger.kernel.org
-- 
2.25.1


