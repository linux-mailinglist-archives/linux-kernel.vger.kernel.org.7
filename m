Return-Path: <linux-kernel+bounces-736489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D4EB09D80
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D5B16CEF7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0142291C2B;
	Fri, 18 Jul 2025 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="2sQvOxxX"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE8E1D7E42;
	Fri, 18 Jul 2025 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826450; cv=none; b=G3OAH6yAf8xS6O+z2dQ6qiWChf3pbBBwUNUXISges6PKS9pEinOcg3hlpT3tfq+ilQaEIFO9pUz3MLFRm1Bi9cZyAFagQH5Uo+U8Ef/WCRLDhozkvEx/Izxc62nDRvQOcSIAo2Rx+ds4TcmY50otO1bEG07zLc6NO4XEyrSdq7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826450; c=relaxed/simple;
	bh=yD5dXNNrxvSpbvCEQDy0BBoUH7XPShILrR+qIEUqrGk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B56+FpDetIE6Rr566UMZTXkBi5Zr0ZRqOl6CkOlX5hEZb5F9hkdtqFwmkjSgX8m+0CZQy+bu3vrKbAfmEyPlXyZXnokSQlbEm8CyTqMnQ/FmfRs/EZLwzEhi++NVVEZyopsywd71uprbwl8tdXQVO9u5QJRC5Mo1QR8ATn3wM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=2sQvOxxX; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1752826445;
	bh=5ak1btSav96wItCN+ZEpZS4jbXXwfD2DGQFYOMoDV0M=; l=4833;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=2sQvOxxX3wt8EebU2Ex1S97hsdJFsiMJZwIMf0g3BBHmBBBfjYxarafYIMCRPKmCz
	 oqUTo8FvrQy3K5AdEgMtclNa70cEA4PTYcrMLjv10fNSu10y6NEQ8yrd+GDohpdtUg
	 Xv7q5ZMJHiv3EswUiXiuq9YyaSahe7S8iaGZMsUvvKiXEfj5QULdoMxMNi8xy3X2fm
	 YTKI79VRUr3NoAOgoa+s46OEhs2rAo+QvrD5OyDY4wH3GhrtRJinG3s4x0NuFWJZCX
	 ecJAD4Dbx2yUqvCwjU1Maq5rFtozYR883M4ekgTwgsjB67zWRqi3aA0UX5RSlRYaaB
	 ur260nAG6lrgg==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244574:0:AUTH_RELAY)
	(envelope-from <jeff_chang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 18 Jul 2025 16:13:56 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Jul
 2025 16:13:56 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Fri, 18 Jul 2025 16:13:56 +0800
From: <jeff_chang@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <jeff_chang@richtek.com>
Subject: [PATCH] regulator: rt5133: Add DT binding document for Richtek RT5133
Date: Fri, 18 Jul 2025 16:12:57 +0800
Message-ID: <20250718081432.2685902-1-jeff_chang@richtek.com>
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

Add DT binding document for Richtek RT5133 voltage regulator.

Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
---
 .../bindings/regulator/richtek,rt5133.yaml    | 178 ++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
new file mode 100644
index 000000000000..c1ba2d9d83c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
@@ -0,0 +1,178 @@
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
+description: |
+  RT5133 is an integrated chip. It includes 8 LDOs and 3 GPOs that can be
+  used to drive output high/low purpose. The dependency of the GPO block
+  is internally LDO1 Voltage. If LDO1 voltage output disabled, GPO cannot
+  be used to drive output high. It need to pay more attention on the usage.
+
+allOf:
+  - $ref: regulator.yaml#
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
+    description: A connection of the 'enable' gpio line.
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
+
+  BASE:
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for base regulator which for force-off base circuit
+
+    properties:
+      oc-shutdown-all:
+        type: object
+        description: |
+          Anyone of LDO OC state
+            0: LDO OC only shut down itself
+            1: LDO OC shut down all channels
+
+      pgb-shutdown-all:
+        type: object
+        description: |
+          Anyone of PGB OC state
+          0: LDO PGB only shut down itself
+          1: LDO PGB shut down all channels
+
+    required:
+      - regulator-name
+
+patternProperties:
+  "^LDO([1-6])$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for single LDO regulator
+
+    required:
+      - regulator-name
+
+  "^LDO([7-8])$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for single LDO regulator
+
+    properties:
+      rt5133-ldo1-supply:
+        description: |
+          Only for LDO7 LDO8, pvin7 and pvin8 reference design are RT5133 LDO1.
+          If not connect to LDO1 vout, this property for pvin7 and pvin8 is necessary.
+
+    required:
+      - regulator-name
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
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
+      rt5133: rt5133@18 {
+        compatible = "richtek,rt5133";
+        reg = <0x18>;
+        wakeup-source;
+        interrupts-extended = <&pio 187 0x0>;
+        enable-gpios = <&pio 186 0x0>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        regulators {
+          BASE {
+            regulator-name = "rt5133,base";
+            oc-shutdown-all = <0>;
+            pgb-shutdown-all = <0>;
+          };
+          rt5133_ldo1: LDO1 {
+            regulator-name = "rt5133-ldo1";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3199998>;
+            regulator-active-discharge;
+          };
+          rt5133_ldo2: LDO2 {
+            regulator-name = "rt5133-ldo2";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3200000>;
+            regulator-active-discharge;
+          };
+          rt5133_ldo3: LDO3 {
+            regulator-name = "rt5133-ldo3";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge;
+          };
+          rt5133_ldo4: LDO4 {
+            regulator-name = "rt5133-ldo4";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge;
+          };
+          rt5133_ldo5: LDO5 {
+            regulator-name = "rt5133-ldo5";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge;
+          };
+          rt5133_ldo6: LDO6 {
+            regulator-name = "rt5133-ldo6";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge;
+          };
+          rt5133_ldo7: LDO7 {
+            regulator-name = "rt5133-ldo7";
+            regulator-min-microvolt = <900000>;
+            regulator-max-microvolt = <1200000>;
+            regulator-active-discharge;
+            rt5133-ldo1-supply = <&rt5133_ldo1>;
+          };
+          rt5133_ldo8: LDO8 {
+            regulator-name = "rt5133-ldo8";
+            regulator-min-microvolt = <855000>;
+            regulator-max-microvolt = <1200000>;
+            regulator-active-discharge;
+            rt5133-ldo1-supply = <&rt5133_ldo1>;
+          };
+        };
+      };
+    };
-- 
2.43.0


