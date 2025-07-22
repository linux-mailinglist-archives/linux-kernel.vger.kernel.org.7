Return-Path: <linux-kernel+bounces-740482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CFFB0D4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9341AA7E35
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576EC2D63FA;
	Tue, 22 Jul 2025 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="jcbtI2Yk"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CBA2D3EFD;
	Tue, 22 Jul 2025 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173330; cv=none; b=qZTDUneO28fhkIIFf5PRVzKlwbbXfYqH/D+BqkySGfKxGt+p65bEG3L5KC3FCTjd/X1PMidUdXn1Bm5gb7KXGq3sw+5Cw1JansbkToc1ICWBUa/LWzmFg6OK9IPnawTGVMBDVv4UxPPP2XKSLL2aXmXFOtP4vIn6Xu/0hbBBUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173330; c=relaxed/simple;
	bh=xQkK5MxAn3VmJv9y6qoY4kmIMEeuaVEhLx7MW2xV0+M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t4uD1J7cDySwoqjt3zORCl4+vRXzQYSa1fI+nhYvKx8wTk1iECOjMO8mrBNnGANOF+Os3zu1ATXn6+M2X9lLWUsLvmjFKlbJaQWbhKtImJbFTCMih3FO3oNiN3LRi+7byKSis9xVpYAXtmNtE+0dJdW8+ueaGJ/DZLbjlSHXJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=jcbtI2Yk; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753173319;
	bh=qIxouJVH9zXNCrYlKGDYe6LlF/DF1yiiOWNonC3KwXg=; l=5428;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jcbtI2YkBP56sM9WMOvmU4nVu04PatdL6bdSzj26vesH93EisC4Ra1kXIhby5UUzj
	 rjVTvu27OXi8JveHac/b0MQrRXEg5aWG4XYcmeL9E5Lalrirf58975fQYZ8rBKnkDC
	 n/fG5Mpm8Y+E73CgZYmw7vqeoLCHXIY6Pd76MLuu/ZPHqY5v9iBmmifL7kG/RH+rYK
	 /00A0h5F7aLNX7vPeNwqNu6shTfNVtLrro3JYdDGZMr1Z37aNAXA7X/l5yaSv3PhWe
	 JCDf2FcUSCzbwQHZzZGUcgZRZP/GVq5NSFAJmYl13Pnda56qQ08/x8e0T01iz6nhaB
	 mGVFAumOON49w==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244587:0:AUTH_RELAY)
	(envelope-from <jeff_chang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 22 Jul 2025 16:35:05 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Jul
 2025 16:35:04 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 22 Jul 2025 16:35:04 +0800
From: <jeff_chang@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <jeff_chang@richtek.com>
Subject: [PATCH v4 1/2] dt-bindings: regulator: Add Richtek RTR5133 Support
Date: Tue, 22 Jul 2025 16:34:17 +0800
Message-ID: <20250722083543.2730796-1-jeff_chang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Jeff Chang <jeff_chang@richtek.com>

Add bindings for Richtek RT5133 IC Controlled PMIC

Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
---

PATCH v4
1. Add commit message and also /script/checkpatch --strict to fix warning.
2. Using subject prefixes matching dt-binding subsystem.
3. Re-order patches. DT patch before driver patch.
4. Fix description of yaml.
5. Add more description for base regulator.
6. Drop regulator-compatible proeprty.
7. Add prefix for vendor property richtek,oc-shutdown-all and richtek,pgb-shutdown-all.
8. Add more description for shutdown-all property.
9. Interrupts-extended -> interrupts.
10. pio->gpio for proper defines.
11. Drop unused labels. Keep rt5133_ldo1 label for ldo7 and ldo8.

 .../bindings/regulator/richtek,rt5133.yaml    | 175 ++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
new file mode 100644
index 000000000000..0da725596a87
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt5133.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5133 PMIC Regulator
+
+maintainers:
+  - ShihChia Chang <jeff_chang@richtek.com>
+
+description:
+  The RT5133 is an integrated Power Management IC for portable devices, featuring
+  8 LDOs and 3 GPOs. It allows programmable output voltages, soft-start times,
+  and protections via I2C. GPO operation depends on LDO1 voltage.
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt5133
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  regulators:
+    type: object
+    additionalProperties: false
+
+    properties:
+      base:
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+        description:
+          Properties for base regulator which control force-off base circuit.
+          Base circuit is the power source for LDO1~LDO6. Disabling it will
+          reduce IQ for Chip.
+
+        properties:
+          richtek,oc-shutdown-all:
+            type: boolean
+            description:
+              Anyone of LDO is in OC state, shut down all channels to protect CHIP.
+              Without this property, only shut down the OC LDO channel.
+
+          richtek,pgb-shutdown-all:
+            type: boolean
+            description:
+              Anyone of LDO is in PGB state, shut down all channels to protect CHIP.
+              Without this property, only shut down the PGB LDO channel.
+
+        required:
+          - regulator-name
+
+    patternProperties:
+      "^ldo([1-6])$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+        description:
+          Properties for single LDO regulator
+
+        required:
+          - regulator-name
+
+      "^ldo([7-8])$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+        description:
+          Properties for single LDO regulator
+
+        properties:
+          rt5133-ldo1-supply:
+            description: |
+              Only for ldo7 ldo8, pvin7 and pvin8 reference design are RT5133 ldo1.
+              If not connect to ldo1 vout, this property for pvin7 and pvin8 is necessary.
+
+        required:
+          - regulator-name
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - wakeup-source
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt5133@18 {
+        compatible = "richtek,rt5133";
+        reg = <0x18>;
+        wakeup-source;
+        interrupts-extended = <&gpio 187 0x0>;
+        enable-gpios = <&gpio 186 0x0>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        regulators {
+          base {
+            regulator-name = "rt5133,base";
+            richtek,oc-shutdown-all;
+            richtek,pgb-shutdown-all;
+          };
+          rt5133_ldo1: ldo1 {
+            regulator-name = "rt5133-ldo1";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3199998>;
+            regulator-active-discharge = <1>;
+          };
+          ldo2 {
+            regulator-name = "rt5133-ldo2";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3200000>;
+            regulator-active-discharge = <1>;
+          };
+          ldo3 {
+            regulator-name = "rt5133-ldo3";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge = <1>;
+          };
+          ldo4 {
+            regulator-name = "rt5133-ldo4";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge = <1>;
+          };
+          ldo5 {
+            regulator-name = "rt5133-ldo5";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge = <1>;
+          };
+          ldo6 {
+            regulator-name = "rt5133-ldo6";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge = <1>;
+          };
+          ldo7 {
+            regulator-name = "rt5133-ldo7";
+            regulator-min-microvolt = <900000>;
+            regulator-max-microvolt = <1200000>;
+            regulator-active-discharge = <1>;
+            rt5133-ldo1-supply = <&rt5133_ldo1>;
+          };
+          ldo8 {
+            regulator-name = "rt5133-ldo8";
+            regulator-min-microvolt = <855000>;
+            regulator-max-microvolt = <1200000>;
+            regulator-active-discharge = <1>;
+            rt5133-ldo1-supply = <&rt5133_ldo1>;
+          };
+        };
+      };
+    };
--
2.43.0


