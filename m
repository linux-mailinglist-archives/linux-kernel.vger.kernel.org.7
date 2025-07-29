Return-Path: <linux-kernel+bounces-748985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F8BB1486B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670611889D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB7025F799;
	Tue, 29 Jul 2025 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="MxYzDRRd"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA37204C0C;
	Tue, 29 Jul 2025 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771639; cv=none; b=oLF/nxtGv8IONqp6J7Aj8p6HBbCE8EukklThFaJnyF51Ws/c181aDfM9hGyoSAW38/+VYl3tGv4ihviWunHut5W7r2WlmBFCYMSAXPDSsE4ckMOWNgNzpD+E5SeduPusoZLEA1dhvHGJ5wrdB45EShVRujT9/RgSVby7NmkBk44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771639; c=relaxed/simple;
	bh=BWhg907o2UJbgrcQG1ctqrplOhbIlg60F1a4WvI39EY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E72j4oFPP8GpCrGlRql6Vd3IhsHaTGVbJdH9POIz/tmaj7CLyMMMQIBcCNZ0uVr0zSnXxMgKALW6KKtcibCyilvE1pc5vglgFzSwyAtyD1Hx9ikbYZFva63tWNoOs8H1hlXMOWrBotFRXGRWO73ka1LtpV3v7akO/lsyT31rFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=MxYzDRRd; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753771633;
	bh=+zCjP1vsDmFBHZq0Eyr593G96RtcqlGM8lJyCJiPgQk=; l=5372;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=MxYzDRRdya6rkNM/jvg8/VLqmCtojX1MNIOm9wmArkFsXfOZHiv/3fFV5ltfGlp6G
	 sipsZC8zzar31L/zd2yjOOK0q9Z3mcLugGCFbZcyiwVgTGYdH8rPmuc7Pg8jJ5t9kG
	 mjnX/UnOEUfYxQYKSJ9CCLTJsJTTP5idRhmJgCWSHHwNgl8i3ZBNeM34dqcWKM4FsS
	 z9pANPQdAk31AaGjCc0TTZBkPtzzjDAgtRABm0DIkgQYynsIa95FiBUiV0mskzOz1n
	 6xzzunsgWvg1KcH0KN8ie2Wng0WNc3C6/18zifUCBYOTq28LINwFnJp6pNG2/bpG1N
	 pCU5S+E9/ac0w==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244574:2:AUTH_RELAY)
	(envelope-from <jeff_chang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 29 Jul 2025 14:47:03 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Jul
 2025 14:47:02 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 29 Jul 2025 14:47:02 +0800
From: <jeff_chang@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <jeff_chang@richtek.com>
Subject: [PATCH v5 1/2] dt-bindings: regulator: Add Richtek RT5133 Support
Date: Tue, 29 Jul 2025 14:40:58 +0800
Message-ID: <20250729064719.2810734-1-jeff_chang@richtek.com>
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

PATCH v5
1. Fix Subject RT5133
2. Update Base regulator description.
3. Move richtek,oc-shutdown-all and richtek,pgb-shutdown-all to chip layer.
4. Update richtek,oc-shutdown-all and richtek,pgb-shutdown-all description.
5. Remove rt5133-ldo-supply, just using vin-supply for pvin7 and pvin8.
   Pvin7,8 are power source for LDO7,8. Referecne is LDO1 Vout.
6. Using standard examples. (Node name and IRQ type)

 .../bindings/regulator/richtek,rt5133.yaml    | 176 ++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
new file mode 100644
index 000000000000..c12069ade224
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
@@ -0,0 +1,176 @@
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
+  richtek,oc-shutdown-all:
+    type: boolean
+    description:
+      Controls the behavior when any LDO (Low Dropout Regulator) enters an Over Current state.
+      If set to true, all LDO channels will be shut down.
+      If set to false (default), only the affected LDO channel will shut down itself.
+
+  richtek,pgb-shutdown-all:
+    type: boolean
+    description:
+      Controls the behavior when any LDO enters a Power Bad state.
+      If set to true, all LDO channels will be shut down.
+      If set to false (default), only the affected LDO channel will shut down itself.
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
+          regulating voltages. If none of LDO1 to LDO6 are in use, switching off
+          the base will reduce the quiescent current.
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
+  - wakeup-source
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@18 {
+        compatible = "richtek,rt5133";
+        reg = <0x18>;
+        wakeup-source;
+        interrupts-extended = <&gpio 0 IRQ_TYPE_EDGE_FALLING>;
+        enable-gpios = <&gpio 2 0>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        richtek,oc-shutdown-all;
+        richtek,pgb-shutdown-all;
+        regulators {
+          base {
+            regulator-name = "rt5133,base";
+          };
+          pvin78: ldo1 {
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
+            vin-supply = <&pvin78>;
+          };
+          ldo8 {
+            regulator-name = "rt5133-ldo8";
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


