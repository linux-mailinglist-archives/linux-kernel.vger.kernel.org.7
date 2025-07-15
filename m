Return-Path: <linux-kernel+bounces-731998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D880B060DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F141C46BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB7B243964;
	Tue, 15 Jul 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qRCcEAxl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13822837F;
	Tue, 15 Jul 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588203; cv=none; b=BZz6sQjA1Av1y8MS0TmaDWK9QogdoH1wl/g+EEmS16cp4EcSsvupBepcyOJwA/OES9ti6izsss8sZKZuTSm99H6MMsvQupIJs0dy/UsyYCYn4pKH7vtRAKu6b4XetVB/9UXNmLqpOlMoJZ+kgydIupj1GkG9YyXOM3kzd9q4ZBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588203; c=relaxed/simple;
	bh=0T78hHqBP46sG3iZ6YmlVmz4JbgNfG24m+8uNL7+1UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFg0kW4STYvHRPyMW53VrWEpsYOQsOOTPGI8C5k7oy2+KoACCky+oeZddO0u/91v8sFD4lJZftU/ezB8ok5mA3n7Oj/VwjLR73aA23ChWwZkFmkzM1HV4hOj3YIn5SjKmP99Ppr4QS9ozyPaOj2jMmwN0nxEdju/BCTc00nzzbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qRCcEAxl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752588200;
	bh=0T78hHqBP46sG3iZ6YmlVmz4JbgNfG24m+8uNL7+1UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRCcEAxl9Af92A5tc94dbW8Y5jSat+ZpinET9OR0wSFlwcZ5zsAgVBWwZDwbQROKy
	 NnCE8DlLVixyFYAGnjJ4vP9mXekQzn9S60ttS8aDWoa+2FcBA3+1l87ZTIwS+TPP4y
	 4+3qbxzFtq6gJwjFtM9OikNWg0p1c2EAwPY/saQOZTs+1tII/t2oOISGSaJj8cY3a9
	 /EupXyPfhrr9kI34EkqWFQGGOHjZAeQsFxEmqk7tI6jWvmXOKFvFXwBt71fDrTru0m
	 GIo+S8T9aZhpQ5k52LqpKz2YAXoo8nDPDKaL/VTDo/dv8VKqHwc+HVjluhqVlVPnrN
	 Y7xfEoirp4Pvg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3B92B17E1293;
	Tue, 15 Jul 2025 16:03:19 +0200 (CEST)
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
Subject: [PATCH v5 3/8] dt-bindings: regulator: Document MediaTek MT6363 PMIC Regulators
Date: Tue, 15 Jul 2025 16:02:19 +0200
Message-ID: <20250715140224.206329-4-angelogioacchino.delregno@collabora.com>
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
MT6373 PMICs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../regulator/mediatek,mt6363-regulator.yaml  | 193 ++++++++++++++++++
 1 file changed, 193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml
new file mode 100644
index 000000000000..ea1f6c92cffc
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml
@@ -0,0 +1,193 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mediatek,mt6363-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6363 PMIC Regulators
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description:
+  The MT6363 SPMI PMIC provides 10 BUCK and 25 LDO (Low DropOut) regulators
+  and can optionally provide overcurrent warnings with one ocp interrupt
+  for each voltage regulator.
+
+properties:
+  compatible:
+    const: mediatek,mt6363-regulator
+
+  reg:
+    maxItems: 1
+
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
+  vsys-vs1-supply:
+    description: Input supply for vs1
+  vsys-vs2-supply:
+    description: Input supply for vs2
+  vsys-vs3-supply:
+    description: Input supply for vs3
+  vs1-ldo1-supply:
+    description: Input supply for va15, vio0p75, vm18, vrf18, vrf-io18
+  vs1-ldo2-supply:
+    description: Input supply for vcn15, vio18, vufs18
+  vs2-ldo1-supply:
+    description: Input supply for vsram-cpub, vsram-cpum, vrf12, vrf13, vufs12
+  vs2-ldo2-supply:
+    description: Input supply for va12-1, va12-2, vcn13, vsram-cpul
+  vs3-ldo1-supply:
+    description: Input supply for vsram-apu, vsram-digrf, vsram-mdfe
+  vs3-ldo2-supply:
+    description: Input supply for vsram-modem, vrf0p9
+  vsys-ldo1-supply:
+    description: Input supply for vaux18, vemc, vtref18
+
+patternProperties:
+  "^v(buck[1-7]|s[1-3])$":
+    description: Buck regulators
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
+  "^va(12-1|12-2|15)$":
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        description: |
+          Allowed LDO regulator operating modes allowed. Valid values below.
+            0 - Normal mode with automatic power saving, reducing the switching
+                frequency when light load conditions are detected
+            2 - Forced Low Power mode for improved regulator efficiency, used
+                when no heavy load is expected, does not limit the maximum out
+                current but unless only a light load is applied, there will be
+                regulation accuracy and efficiency losses.
+        maxItems: 2
+        items:
+          enum: [ 0, 2 ]
+    unevaluatedProperties: false
+
+  "^v(aux|m|rf-io|tref)18$":
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        maxItems: 2
+        items:
+          enum: [ 0, 2 ]
+    unevaluatedProperties: false
+
+  "^v(cn13|cn15|emc)$":
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        maxItems: 2
+        items:
+          enum: [ 0, 2 ]
+    unevaluatedProperties: false
+
+  "^vio(0p75|18)$":
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        maxItems: 2
+        items:
+          enum: [ 0, 2 ]
+    unevaluatedProperties: false
+
+  "^vrf(0p9|12|13|18)$":
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        maxItems: 2
+        items:
+          enum: [ 0, 2 ]
+    unevaluatedProperties: false
+
+  "^vsram-(apu|cpub|cpum|cpul|digrf|mdfe|modem)$":
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        maxItems: 2
+        items:
+          enum: [ 0, 2 ]
+    unevaluatedProperties: false
+
+  "^vufs(12|18)$":
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
+        compatible = "mediatek,mt6363-regulator";
+        reg = <0x
+
+        vio18 {
+          regulator-name = "pp1800-vio18-s3";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-allowed-modes = <0 2>;
+          regulator-allow-set-load;
+          regulator-over-current-protection;
+        };
+      };
+    };
+...
-- 
2.50.1


