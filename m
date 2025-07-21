Return-Path: <linux-kernel+bounces-738713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A85B0BC36
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2865C189A9FA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AF521C9E9;
	Mon, 21 Jul 2025 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="FwVvH0tw"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5DE56A;
	Mon, 21 Jul 2025 06:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753077722; cv=none; b=favsKlLz9T1NRg/XN56NDzief68qwF3XBikhM329aIL8syBaMQeYF7HXIRKrOOcW7kiWP6LtjidFsds818DSqoQ3YfHU4j1ShSc6oVOSdU6KcajGAgIaBOqgCNwLkwXIh6eu9O25r0Zsj1rK3bOcZw/Si22NKJzsdIcwYBddvNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753077722; c=relaxed/simple;
	bh=BI50glS4pPj1b3Jmqc5B2atgvHld9feWkDMDS8h36f0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jO1e/0lJl6mGxdnQwedGpjSS/I/HuqcHYCttqHa2z7Boo16bW0c7EGJkqdcwCgmEoaFKVd2110ljaw5pd2bpnBLq0xbCNtMEMjnEA1NwnRggF/n6VtAn5yfpG7efHs5+z469VgXcAo+5IwkB9xGfNi42x1yKYuJ/5Pv0IeBexbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=FwVvH0tw; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753077711;
	bh=1k41fu9oSqY47vXlqDbM8+ZgNn+dfOods0hJKN0l4H4=; l=5769;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=FwVvH0twIARpwtnd6qfgjjBsqqaSuBxOywL4CR+3yJaLLpEuGAaWHcWN0aCuHWMS0
	 VEzwLJANL0fa52z57DyRa0PdMlZncUFSChOznTFF2698Lgav+8zRzeJpIzvdlwuR3K
	 383lRWSsMEsBtICpikkoLmUK/69HYWs7N/Kfq6raTanh//h8w6TtkXTES5cvlZd8/1
	 BjgEtcYgjB3b35VjrYMEYadq43BTVhqZEiWiWr1uayu/cDh3hEDY2MLD1htaSQXSnd
	 tL55cTSmV8Rxk57bLGlrmnZqvzZU+UOHe0Xl+9nyCGwvFsCiXRKiN6JO66pWcxly9L
	 NUAxT4aOOrMcg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244589:0:AUTH_RELAY)
	(envelope-from <jeff_chang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 21 Jul 2025 14:01:38 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 21 Jul
 2025 14:01:37 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Mon, 21 Jul 2025 14:01:37 +0800
From: <jeff_chang@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <jeff_chang@richtek.com>
Subject: [PATCH v3 2/2] dt-bindings: regulator: Add Richtek RTR5133 DT Binding Documentation
Date: Mon, 21 Jul 2025 14:01:35 +0800
Message-ID: <20250721060215.2718217-2-jeff_chang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250721060215.2718217-1-jeff_chang@richtek.com>
References: <20250721060215.2718217-1-jeff_chang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Jeff Chang <jeff_chang@richtek.com>

Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
---

PATCH v3
1. fix Subject format
2. using correct patches version
3. remove '|'
4. remove allOf: &ref regulator.yaml#
5. remove redundant description
6. move BASE to base property with correct indentation
7. only using lowercase node name
8. make DT_CHECKER_FLAG=-m DT_SCHEMA_FILES=richtek,rt5133.yaml dt_binding_check pass


 .../bindings/regulator/richtek,rt5133.yaml    | 197 ++++++++++++++++++
 1 file changed, 197 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
new file mode 100644
index 000000000000..a92e7f775832
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
@@ -0,0 +1,197 @@
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
+  RT5133 is an integrated chip. It includes 8 LDOs and 3 GPOs that can be
+  used to drive output high/low purpose. The dependency of the GPO block
+  is internally LDO1 Voltage. If LDO1 voltage output disabled, GPO cannot
+  be used to drive output high. It need to pay more attention on the usage.
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
+          Properties for base regulator which for force-off base circuit
+
+        properties:
+          regulator-compatible:
+            description: Compatible string for regulator
+            $ref: /schemas/types.yaml#/definitions/string
+
+          oc-shutdown-all:
+            type: boolean
+            description:
+              Anyone of LDO OC state, shut down all channels.
+
+          pgb-shutdown-all:
+            type: boolean
+            description:
+              Anyone of PGB OC state, shut down all channels.
+
+        required:
+          - regulator-name
+          - regulator-compatible
+
+    patternProperties:
+      "^ldo([1-6])$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+        description:
+          Properties for single LDO regulator
+
+        properties:
+          regulator-compatible:
+            description: Compatible string for regulator
+            $ref: /schemas/types.yaml#/definitions/string
+
+        required:
+          - regulator-name
+          - regulator-compatible
+
+      "^ldo([7-8])$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+        description:
+          Properties for single LDO regulator
+
+        properties:
+          regulator-compatible:
+            description: Compatible string for regulator
+            $ref: /schemas/types.yaml#/definitions/string
+
+          rt5133-ldo1-supply:
+            description: |
+              Only for ldo7 ldo8, pvin7 and pvin8 reference design are RT5133 ldo1.
+              If not connect to ldo1 vout, this property for pvin7 and pvin8 is necessary.
+
+        required:
+          - regulator-name
+          - regulator-compatible
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
+          base {
+            regulator-compatible = "BASE";
+            regulator-name = "rt5133,base";
+            oc-shutdown-all;
+            pgb-shutdown-all;
+          };
+          rt5133_ldo1: ldo1 {
+            regulator-compatible = "LDO1";
+            regulator-name = "rt5133-ldo1";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3199998>;
+            regulator-active-discharge = <1>;
+          };
+          rt5133_ldo2: ldo2 {
+            regulator-compatible = "LDO2";
+            regulator-name = "rt5133-ldo2";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3200000>;
+            regulator-active-discharge = <1>;
+          };
+          rt5133_ldo3: ldo3 {
+            regulator-compatible = "LDO3";
+            regulator-name = "rt5133-ldo3";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge = <1>;
+          };
+          rt5133_ldo4: ldo4 {
+            regulator-compatible = "LDO4";
+            regulator-name = "rt5133-ldo4";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge = <1>;
+          };
+          rt5133_ldo5: ldo5 {
+            regulator-compatible = "LDO5";
+            regulator-name = "rt5133-ldo5";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge = <1>;
+          };
+          rt5133_ldo6: ldo6 {
+            regulator-compatible = "LDO6";
+            regulator-name = "rt5133-ldo6";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge = <1>;
+          };
+          rt5133_ldo7: ldo7 {
+            regulator-compatible = "LDO7";
+            regulator-name = "rt5133-ldo7";
+            regulator-min-microvolt = <900000>;
+            regulator-max-microvolt = <1200000>;
+            regulator-active-discharge = <1>;
+            rt5133-ldo1-supply = <&rt5133_ldo1>;
+          };
+          rt5133_ldo8: ldo8 {
+            regulator-compatible = "LDO8";
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


