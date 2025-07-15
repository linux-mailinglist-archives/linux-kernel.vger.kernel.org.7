Return-Path: <linux-kernel+bounces-731999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B3CB06101
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC810179B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1BA24DCE3;
	Tue, 15 Jul 2025 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cmDwio7O"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EC023956A;
	Tue, 15 Jul 2025 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588205; cv=none; b=EFiQwW4tFVGnbGOtBbqg8XTr7xyHmSLUMHc0z2puM/uOdV/V+2yiFVvJqUuJB385Q2GZuX2vukdHz6tsJVrQ7wmQIsc+VuAi9H+g/emor50enjXmsWNfaO+M3iCf6U7TVQLiRUJJdrRvc6dWp06MFkAItx7CBXGKziJyVLCmOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588205; c=relaxed/simple;
	bh=Ri++bYMrEX68zjvAiAcAZUzVJwMcB/boqbaj8bEwZ2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/kwsfhIOzO8fYpeKO7GB3fUQ+FRZyhmhfLf2OM/At9fv2DcE4XZDBgv5bAnOKpY4lDBjB93L6QSqAaENzgDKa/GN5GedzbpJTcoedZ074vZM0xtRpFOfwCzOLUEiZHjNJDDM+1qQ01qNrlAeVqLxWw9GkoSjtepWozPPyWOR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cmDwio7O; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752588201;
	bh=Ri++bYMrEX68zjvAiAcAZUzVJwMcB/boqbaj8bEwZ2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cmDwio7Oa815n9aR02l8azSKArHfen4vPjatA3GhhY/9FwwvMglBASRh2eIBgB5lJ
	 7snCVO2g+kzSf0cRGqATmokse4SHCEHVtjCBQqhSHyWLwqcZNYQE03q4ZRJjhOoWIm
	 aZsuPta5z/2Yduzu3ggXP8CJbjafJd1v0W+h1brkpxbR7J6jW8+AqfedoFnrIXC6Oq
	 JyjvbMukuNf1Tbiz7vuF9WRoH1wF9EK0JFWx9TBh/N3jrD41+tA7XgtcWl/WuCBD2p
	 sZXEqbNmvrlXWkdR02yZDAQ/a5JHeGDNTXrIEjA+clvoGfQVu1ztMXzewKbDN1R+ue
	 bdRq/AAktRNiw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0F9BB17E1319;
	Tue, 15 Jul 2025 16:03:21 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org
Subject: [PATCH v5 5/8] dt-bindings: regulator: Document MediaTek MT6373 PMIC Regulators
Date: Tue, 15 Jul 2025 16:02:21 +0200
Message-ID: <20250715140224.206329-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715140224.206329-1-angelogioacchino.delregno@collabora.com>
References: <20250715140224.206329-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the regulators found in the MediaTek MT6363 PMIC,
usually found in board designs using the MT6991 Dimensity 9400 and
on MT8196 Kompanio SoC for Chromebooks, along with the MT6316 and
MT6363 PMICs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../regulator/mediatek,mt6373-regulator.yaml  | 174 ++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
new file mode 100644
index 000000000000..3dd853678b51
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
@@ -0,0 +1,174 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mediatek,mt6373-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6373 PMIC Regulators
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description:
+  The MT6373 SPMI PMIC provides 10 BUCK and 23 LDO (Low DropOut) regulators
+  and can optionally provide overcurrent warnings with one ocp interrupt
+  for each voltage regulator.
+
+properties:
+  compatible:
+    const: mediatek,mt6373-regulator
+
+  reg:
+    maxItems: 1
+
+  vsys-vbuck0-supply:
+    description: Input supply for vbuck0
+  vsys-vbuck1-supply:
+    description: Input supply for vbuck1
+  vsys-vbuck2-supply:
+    description: Input supply for vbuck2
+  vsys-vbuck3-supply:
+    description: Input supply for vbuck3
+  vsys-vbuck4-supply:
+    description: Input supply for vbuck4
+  vsys-vbuck5-supply:
+    description: Input supply for vbuck5
+  vsys-vbuck6-supply:
+    description: Input supply for vbuck6
+  vsys-vbuck7-supply:
+    description: Input supply for vbuck7
+  vsys-vbuck8-supply:
+    description: Input supply for vbuck8
+  vsys-vbuck9-supply:
+    description: Input supply for vbuck9
+  vs1-ldo1-supply:
+    description: Input supply for vant18, vaud18, vcn18io
+  vs2-ldo1-supply:
+    description: Input supply for vrf12-aif, vrf13-aif
+  vs3-ldo1-supply:
+    description: Input supply for vrf09-aif, vsram-digrf-aif
+  vsys-ldo1-supply:
+    description: Input supply for vcn33-1, vcn33-2, vmc
+  vsys-ldo2-supply:
+    description:
+      Input supply for vaux18, vcn33-3, vefuse, vfp, vibr, vio28, vtp, vusb
+  vsys-ldo3-supply:
+    description: Input supply for vmch, vmch-eint-high/low
+
+patternProperties:
+  "^v(ant|aud|aux)18$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^vbuck([0-9])$":
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        description: |
+          Allowed Buck regulator operating modes allowed. Valid values below.
+            0 - Normal mode with automatic power saving, reducing the switching
+                frequency when light load conditions are detected
+            1 - Forced Continuous Conduction mode (FCCM) for improved voltage
+                regulation accuracy with constant switching frequency but lower
+                regulator efficiency
+            2 - Forced Low Power mode for improved regulator efficiency, used
+                when no heavy load is expected, does not limit the maximum out
+                current but unless only a light load is applied, there will be
+                regulation accuracy and efficiency losses.
+            3 - Forced Ultra Low Power mode for ultra low load, this greatly
+                reduces the maximum output power, makes the regulator to be
+                efficient only for ultra light load, and greatly reduces the
+                quiescent current (Iq) of the buck.
+        maxItems: 3
+        items:
+          enum: [ 0, 1, 2, 3 ]
+    unevaluatedProperties: false
+
+  "^v(f|t)p":
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        maxItems: 2
+        items:
+          enum: [ 0, 2 ]
+    unevaluatedProperties: false
+
+  "^v(cn18io|cn33-[123]|efuse|ibr|io28|sram-digrf-aif|usb)":
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        maxItems: 2
+        items:
+          enum: [ 0, 2 ]
+    unevaluatedProperties: false
+
+  "^vmc(h)?$":
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        maxItems: 2
+        items:
+          enum: [ 0, 2 ]
+    unevaluatedProperties: false
+
+  "^vmch-eint-(low|high)?$":
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        maxItems: 2
+        items:
+          enum: [ 0, 2 ]
+    unevaluatedProperties: false
+
+  "^vrf(09|12|13|18|io18)-aif$":
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        maxItems: 2
+        items:
+          enum: [ 0, 2 ]
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+      interrupt-controller;
+      #address-cells = <1>;
+      #interrupt-cells = <3>;
+
+      regulators@30 {
+        compatible = "mediatek,mt6373-regulator";
+        reg = <0x30>;
+
+        vaux18 {
+          regulator-name = "avss18-auxadc-mt6373";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-allowed-modes = <0 1 2>;
+          regulator-over-current-protection;
+        };
+
+        vcn33-2 {
+          regulator-name = "pp1800-2900-vmc";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <2900000>;
+          regulator-allowed-modes = <0 2>;
+        };
+      };
+    };
+...
-- 
2.50.1


