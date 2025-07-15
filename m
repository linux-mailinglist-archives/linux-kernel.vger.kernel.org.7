Return-Path: <linux-kernel+bounces-731780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A7FB05967
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C1D4E656A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190F62E1738;
	Tue, 15 Jul 2025 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UkVRrZF4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE32DE71C;
	Tue, 15 Jul 2025 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580656; cv=none; b=J3XghM9rSOkuArsnb3R8jHQI7kqDdjdTP3t7N94f3UVBBPq5AAPI2kBWbf2MndWDAZrsBvAAc/sxI2289SzRiri6vSczkwxsw9N0E6BhndP2bS6h2g384H1dNbfKn3he85OGBHs6yYhllBsf7cwAW0u9P4BE201Uw4yKd9GsmPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580656; c=relaxed/simple;
	bh=lBLq2XppSqe8dM1Htia7d5Ef/77fUNAK3eL/ULF0Uk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cV2hLBpi2Xrcu8k8AXAG1d9C89s/lhC6MalN929Z5pb2kF59ezswzvgXH25EGT4zO5mGUQr2EOvY4fBhx5eshZhtjGiqFBMlnPRcitWJW07Vce2C32N48Pl+heqrfj5RXU1zQH03ftohJcUHvCntIBe5eGN7MN4YZoeNS168gaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UkVRrZF4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752580648;
	bh=lBLq2XppSqe8dM1Htia7d5Ef/77fUNAK3eL/ULF0Uk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UkVRrZF4U1h2mzhCidadkCLTq1sWHqx7K6CQ8RP1n6TB9JlUmg1pTXyD6eZuesmmP
	 IGQZVfWQbCykFBRvpS0hG2oHpwSneXUlmEVDUq0CJNZffxKdANDRPJSADfbyuoTSGQ
	 RpbrjJ3IzTuWO9Ttg78oouRLGeJwZIuxEkombv5ag9C1henb8EeKPU36TX39/YHAsd
	 g0IIPP9GVQq2XowrcTmGePIki9Ne+kOiiEqrybEYtMfwQytuZx/ZYUR62i7o+lnvkB
	 xNpIbuhr57qnHjxU8LqmjKMF7/CG8uXPtbsVHP9ZqhQR2q8fTKLLLvMUSPpRiRu3ze
	 6zyMqborcCsdQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5B83317E1301;
	Tue, 15 Jul 2025 13:57:27 +0200 (CEST)
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
Subject: [PATCH v4 5/8] dt-bindings: regulator: Document MediaTek MT6373 PMIC Regulators
Date: Tue, 15 Jul 2025 13:57:15 +0200
Message-ID: <20250715115718.176495-6-angelogioacchino.delregno@collabora.com>
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
MT6363 PMICs.

Link: https://lore.kernel.org/r/20250624073548.29732-6-angelogioacchino.delregno@collabora.com
Link: https://lore.kernel.org/r/20250707134451.154346-6-angelogioacchino.delregno@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../regulator/mediatek,mt6373-regulator.yaml  | 175 ++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
new file mode 100644
index 000000000000..dec4bf90e892
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
@@ -0,0 +1,175 @@
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
+  The MT6373 SPMI PMIC provides 11 BUCK and 23 LDO (Low Dropout) regulators
+  and can optionally provide overcurrent warnings with one ocp interrupt
+  for each voltage regulator.
+
+properties:
+  compatible:
+    const: mediatek,mt6373-regulator
+
+  interrupts:
+    description: Overcurrent warning interrupts
+    minItems: 1
+    maxItems: 34
+
+  interrupt-names:
+    description:
+      Names for the overcurrent interrupts are the same as the name
+      of a regulator (hence the same as each regulator's node name).
+      For example, the interrupt name for regulator vfp will be "vfp".
+    minItems: 1
+    maxItems: 34
+    contains:
+      enum:
+        - vbuck0
+        - vbuck1
+        - vbuck2
+        - vbuck3
+        - vbuck4
+        - vbuck4-ufs
+        - vbuck5
+        - vbuck6
+        - vbuck7
+        - vbuck8
+        - vbuck9
+        - vant18
+        - vaud18
+        - vaux18
+        - vcn33-1
+        - vcn33-2
+        - vcn33-3
+        - vcn18io
+        - vefuse
+        - vfp
+        - vibr
+        - vio28
+        - vmc
+        - vmch
+        - vrfio18-aif
+        - vrf09-aif
+        - vrf12-aif
+        - vrf13-aif
+        - vrf18-aif
+        - vsim1
+        - vsim2
+        - vsram-digrf-aif
+        - vtp
+        - vusb
+
+patternProperties:
+  "^v(ant|aud|aux)18$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^vbuck([0123456789]|4-ufs)$":
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
+  "^vbuck4(-ufs)?$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^vcn33-[123]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^v(f|t)p":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^v(cn18io|efuse|ibr|io28|sram-digrf-aif|usb)":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^vmc(h)?$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^vmch-(eint-low|eint-high)?$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^vrf(09|12|13|18|io18)-aif$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^vsim[12]$":
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
+        compatible = "mediatek,mt6373-regulator";
+        interrupts = <5 17 IRQ_TYPE_LEVEL_HIGH>, <5 18 IRQ_TYPE_LEVEL_HIGH>,
+                     <5 19 IRQ_TYPE_LEVEL_HIGH>, <5 20 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "vusb", "vaux18", "vrf13-aif", "vrf18-aif";
+
+        vaux18 {
+          regulator-name = "avss18-auxadc-mt6373";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-allowed-modes = <0 1 2>;
+        };
+
+        vmc {
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


