Return-Path: <linux-kernel+bounces-731779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36B6B05965
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEA54E5F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEC42E0410;
	Tue, 15 Jul 2025 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RET/kUIM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C612DE704;
	Tue, 15 Jul 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580655; cv=none; b=jUruG7PC8CBBksuwFe+S0aH3oL9U9MaHG0onMeJWSNrqhLJKGN6lOh6zce/osyPP5bBje/SDmeuJGc58k0HuLvvZsXzAXkodjiQATWoEJPAR+4A4JcwkXftAx6c7fSW2TtzFiZWssw7Xh2oc71SDcV43Hn9J311nTIqroyal4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580655; c=relaxed/simple;
	bh=HSvalhHL1QfcTpUS+JqtmcTdZJS9ffRBREKmaODZGpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5lAUPElMFzq5MC7iHuG433Lv4pQSVQJIuVFDpmqyV4ws3oZ2xk52xbhvHo/qYsmlc/7waXS895FYtBnU7wXkUU9ZPp5j7nQthBvzxzoD5bF6ZFQeK4wMUWJ54zPwRlWxeNPBorwU4UVno3zhk5Mo4366unLrc7RnUxyUir+PJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RET/kUIM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752580646;
	bh=HSvalhHL1QfcTpUS+JqtmcTdZJS9ffRBREKmaODZGpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RET/kUIMfHZNUizxiB14bX/dlU50g4J+ijA1eiTj3EQVSVqcqYkX4NmkkpEtR9Zl2
	 /vyYATCDb88Uc4fmXgT144TH6/sGUaVi8lH84WQf2aAwIJCEcrFGPtlN8SICVJzMiq
	 aSIHcepVuVNFcD73Ehtevs14fDouFqXYMKTaNJNnBdPYYnq0cCpLpl4ePye/nEoZQo
	 +QhYRbDjRdU2YmJlpWwW/zb2s8TebRDCETDTSQn88aemkfo000zu2EZf/zVPSjYmZz
	 o4HOTWp1n0xKNBhXKgv6I6/QamLJFvjKZ4kWLXxL9IvGJsJSSFMRbrajYu1Ip55iaQ
	 8ddX7bF9Ge4Bg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5CCE317E1293;
	Tue, 15 Jul 2025 13:57:25 +0200 (CEST)
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
Subject: [PATCH v4 3/8] dt-bindings: regulator: Document MediaTek MT6363 PMIC Regulators
Date: Tue, 15 Jul 2025 13:57:13 +0200
Message-ID: <20250715115718.176495-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715115718.176495-1-angelogioacchino.delregno@collabora.com>
References: <20250715115718.176495-1-angelogioacchino.delregno@collabora.com>
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

Link: https://lore.kernel.org/r/20250624073548.29732-4-angelogioacchino.delregno@collabora.com
Link: https://lore.kernel.org/r/20250707134451.154346-4-angelogioacchino.delregno@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../regulator/mediatek,mt6363-regulator.yaml  | 175 ++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml
new file mode 100644
index 000000000000..9df57b803edb
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml
@@ -0,0 +1,175 @@
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
+  The MT6363 SPMI PMIC provides 13 BUCK and 25 LDO (Low Dropout) regulators
+  and can optionally provide overcurrent warnings with one ocp interrupt
+  for each voltage regulator.
+
+properties:
+  compatible:
+    const: mediatek,mt6363-regulator
+
+  interrupts:
+    description: Overcurrent warning interrupts
+    minItems: 1
+    maxItems: 38
+
+  interrupt-names:
+    description:
+      Names for the overcurrent interrupts are the same as the name
+      of a regulator (hence the same as each regulator's node name).
+      For example, the interrupt name for regulator ldo-vemc will
+      be "ldo-vemc".
+    minItems: 1
+    maxItems: 38
+    contains:
+      enum:
+        - buck-sshub1
+        - buck-sshub2
+        - buck-sshub4
+        - buck-vb1
+        - buck-vb2
+        - buck-vb3
+        - buck-vb4
+        - buck-vb5
+        - buck-vb6
+        - buck-vb7
+        - buck-vs1
+        - buck-vs2
+        - buck-vs3
+        - ldo-va12-1
+        - ldo-va12-2
+        - ldo-va15
+        - ldo-vaux18
+        - ldo-vcn13
+        - ldo-vcn15
+        - ldo-vemc
+        - ldo-vio0p75
+        - ldo-vio18
+        - ldo-vm18
+        - ldo-vrf0p9
+        - ldo-vrf12
+        - ldo-vrf13
+        - ldo-vrf18
+        - ldo-vrf-io18
+        - ldo-vsram-apu
+        - ldo-vsram-cpub
+        - ldo-vsram-cpum
+        - ldo-vsram-cpul
+        - ldo-vsram-digrf
+        - ldo-vsram-mdfe
+        - ldo-vsram-modem
+        - ldo-vtref18
+        - ldo-vufs12
+        - ldo-vufs18
+
+  isink-load:
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  ldo-vemc:
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+patternProperties:
+  "^buck-(sshub[124]|vb[1-7]|vs[1-3])$":
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
+  "^ldo-va(12-1|12-2|15)$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^ldo-v(aux|m|rf-io|tref)18$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^ldo-vcn(13|15)$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^ldo-vio(0p75|18)$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^ldo-vrf(0p9|12|13|18)$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^ldo-vsram-(apu|cpub|cpum|cpul|digrf|mdfe|modem)$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^ldo-vufs(12|18)$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+      interrupt-controller;
+      #interrupt-cells = <3>;
+
+      regulators {
+        compatible = "mediatek,mt6363-regulator";
+        interrupts = <4 16 IRQ_TYPE_LEVEL_HIGH>, <4 17 IRQ_TYPE_LEVEL_HIGH>,
+                     <4 18 IRQ_TYPE_LEVEL_HIGH>, <4 19 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "ldo-vcn15", "ldo-vcn13", "ldo-vrf0p9", "ldo-vrf12";
+
+        ldo-vio18 {
+          regulator-name = "pp1800-vio18-s3";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-allowed-modes = <0 2>;
+          regulator-allow-set-load;
+        };
+      };
+    };
+...
-- 
2.50.1


