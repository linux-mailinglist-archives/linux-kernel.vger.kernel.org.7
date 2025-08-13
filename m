Return-Path: <linux-kernel+bounces-765769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5443DB23E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0751A27BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9F21BCA0E;
	Wed, 13 Aug 2025 02:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="hSptJEJc"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51611249E5;
	Wed, 13 Aug 2025 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755050915; cv=none; b=FwOSaIbROjucURNjiZyq1AqwOGp8Cv2Iz47m93nOyPUaMYZOa/298Us6jOH3llKDbnzX4+eA1KzSDpJUogy2y0BfzW0bj5dVI1uf4Niv0QLMyz+GGMSI0Z/q9fV3B5i+YdZweq70+NWeEF2J4wz/ku+2HVOx46iUc6WQdDBNLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755050915; c=relaxed/simple;
	bh=kEpv9iolwS2Rxb0y6U69i0xqapUsQEC4vDC5Sve/Lsk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SEIZ/Xv3jJgR+JIFktQwkDXCYh/ka43uWp+DrPSnxWC9Ac+XdzvCytIhJ9gDvL+h6Nbp5O2x5MxA7z5Qo6LJnQ1gcYnUOVNXUC9chh0wOorqcNyV/cEMtTq2PxZbnxtp+n5op8bNSEvr7VaEE6fy3VearpZbBnlCKtEA/gyBIGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=hSptJEJc; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1755050909;
	bh=NPZ8X6T8/MfTLU37aBhrTkasnyxxlzjf6Dgfk2dpEYs=; l=7194;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=hSptJEJctuTjEAskHviKbwoYLCVZGYqIFbmadL9DSVq77hFBiI/pAl5d6RqIvz69z
	 mMA1KHgVEVviCqmt4rd3Pb7bpVxEnmiiVWNyqUZq98l/EcZd2/Bb/Xq9hVHGTWiGa9
	 Fx8Gy6syKOapPC2eSygCQZ/aWkSv/Qls8LMhWSz+bUIYXYhpX0Et0p5y1jvo/61+wa
	 NKHJaL2w7QRvNiWMt6JK2HS2gwMYOgZzmXKLhPImRVik1BSITW7ZvwtrycBtEe5kVM
	 iKJUdCwtn4oosmilguXVOL6oH7lNbVGAk08gMbpfhKwxIU5kAMlNqsqkEpG9G8KduI
	 9JGlst5iScCyg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(817444:0:AUTH_RELAY)
	(envelope-from <jeff_chang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 13 Aug 2025 10:08:20 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 10:08:19 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Wed, 13 Aug 2025 10:08:19 +0800
From: <jeff_chang@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <jeff_chang@richtek.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 RESEND 1/2] regulator: dt-bindings: Add Richtek RT5133 Support
Date: Wed, 13 Aug 2025 10:08:50 +0800
Message-ID: <20250813020910.2977555-1-jeff_chang@richtek.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v7
1. Add Reviewed-by tag

Changes in v6
1. Using regulator subsystem prefix.
2. Wrapped well.
3. Remove wakeup-source from required.
4. Using additionalProperties instead.
5. Using GPIO_ACTIVE_HIGH.
6. Remove rt5133 prefix and commas.
7. Add all changes for each version.

Changes in v5
1. Fix Subject RT5133
2. Update Base regulator description.
3. Move richtek,oc-shutdown-all and richtek,pgb-shutdown-all to chip layer.
4. Update richtek,oc-shutdown-all and richtek,pgb-shutdown-all description.
5. Remove rt5133-ldo-supply, just using vin-supply for pvin7 and pvin8.
   Pvin7,8 are power source for LDO7,8. Referecne is LDO1 Vout.
6. Using standard examples. (Node name and IRQ type)

Changes in v4
1. Add commit message and also /script/checkpatch --strict to fix warning.
2. Using subject prefixes matching dt-binding subsystem.
3. Re-order patches. DT patch before driver patch.
4. Fix description of yaml.
5. Add more description for base regulator.
6. Drop regulator-compatible proeprty.
7. Add prefix for vendor property richtek,oc-shutdown-all and
   richtek,pgb-shutdown-all.
8. Add more description for shutdown-all property.
9. Interrupts-extended -> interrupts.
10. pio->gpio for proper defines.
11. Drop unused labels. Keep rt5133_ldo1 label for ldo7 and ldo8.

Changes in v3:
1. Fix typo intefrated -> integrated
2. Remove yaml file
3. Remove soft-start-time-sel property
4. Remove GPL-4.0, using GPL-2.0
5. Using C++ comment
6. Using standard dev_dbg
7. Remove driver version
8. Using dev_dbg for base event occurred. And return IRQ_HANDLED 9. Because of
   CRC8 for IO, we don't use cache for regmap_config 10. Remove tracing logs.
11. Set can_sleep = true for gpio operations.
12. Kconfig add depends on OF

Changes in v2:
1. Fix typo intefrated -> integrated
2. Remove yaml file
3. Remove soft-start-time-sel property
4. Remove GPL-4.0, using GPL-2.0
5. Using C++ comment
6. Using standard dev_dbg
7. Remove driver version
8. Using dev_dbg for base event occurred. And return IRQ_HANDLED
9. Because of CRC8 for IO, we don't use cache for regmap_config
10. Remove tracing logs.
11. Set can_sleep = true for gpio operations.

 .../bindings/regulator/richtek,rt5133.yaml    | 178 ++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
new file mode 100644
index 000000000000..d2e007fee6ba
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
+description:
+  The RT5133 is an integrated Power Management IC for portable devices,
+  featuring 8 LDOs and 3 GPOs. It allows programmable output voltages,
+  soft-start times, and protections via I2C. GPO operation depends on LDO1
+  voltage.
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
+  richtek,oc-shutdown-all:
+    type: boolean
+    description:
+      Controls the behavior when any LDO (Low Dropout Regulator) enters an
+      Over Current state.
+      If set to true, all LDO channels will be shut down.
+      If set to false, only the affected LDO channel will shut down itself.
+
+  richtek,pgb-shutdown-all:
+    type: boolean
+    description:
+      Controls the behavior when any LDO enters a Power Good Bad state.
+      If set to true, all LDO channels will be shut down.
+      If set to false, only the affected LDO channel will shut down itself.
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
+          Properties for the base regulator, which is the top-level supply for
+          LDO1 to LDO6. It functions merely as an on/off switch rather than
+          regulating voltages. If none of LDO1 to LDO6 are in use, switching
+          off the base will reduce the quiescent current.
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
+          vin-supply: true
+
+        required:
+          - regulator-name
+          - vin-supply
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@18 {
+        compatible = "richtek,rt5133";
+        reg = <0x18>;
+        wakeup-source;
+        interrupts-extended = <&gpio 0 IRQ_TYPE_EDGE_FALLING>;
+        enable-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        richtek,oc-shutdown-all;
+        richtek,pgb-shutdown-all;
+        regulators {
+          base {
+            regulator-name = "base";
+          };
+          pvin78: ldo1 {
+            regulator-name = "ldo1";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3199998>;
+            regulator-active-discharge = <1>;
+          };
+          ldo2 {
+            regulator-name = "ldo2";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3200000>;
+            regulator-active-discharge = <1>;
+          };
+          ldo3 {
+            regulator-name = "ldo3";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge = <1>;
+          };
+          ldo4 {
+            regulator-name = "ldo4";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge = <1>;
+          };
+          ldo5 {
+            regulator-name = "ldo5";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge = <1>;
+          };
+          ldo6 {
+            regulator-name = "ldo6";
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-active-discharge = <1>;
+          };
+          ldo7 {
+            regulator-name = "ldo7";
+            regulator-min-microvolt = <900000>;
+            regulator-max-microvolt = <1200000>;
+            regulator-active-discharge = <1>;
+            vin-supply = <&pvin78>;
+          };
+          ldo8 {
+            regulator-name = "ldo8";
+            regulator-min-microvolt = <855000>;
+            regulator-max-microvolt = <1200000>;
+            regulator-active-discharge = <1>;
+            vin-supply = <&pvin78>;
+          };
+        };
+      };
+    };
-- 
2.43.0


