Return-Path: <linux-kernel+bounces-840033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC97BB361C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A631189BFFB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7521F30BF66;
	Thu,  2 Oct 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eEgcoj0H"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6253002C4;
	Thu,  2 Oct 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759395640; cv=none; b=HysaDfENLPeQVrUfDv9u8QiAjIE6IbLeKDBlDD890vwFDsi6avBQ4/9++V4/CSmBv6UplsFWefaiPRaQjdTP9qNbSouA3z+4PCfBvS1z/4M4t+/u1kv1T8HddWr07LbmwIruL0oYVWcdbm+vF7TD9puMnudVx6Q0EaJzd+fElaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759395640; c=relaxed/simple;
	bh=E1zmjjlBBxFy/4tW2HdcrJ+ALN1Y5NvGD8okhz9niTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFO/ozuFQioPyxz+BLyCfGNEWQD4j2xT1r8ZO+em83N3VneepHVXHdJAPiZ9OWbAC/7tU5Sway0jjhqk+rqe4caEASZmUs7fJnJ6hM65TIN+bbViUmc+XJgYD4xvJh9dn+23Zr7ECkK61S2aAbxEIsKSzIg95DnUaraA4P7OzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eEgcoj0H; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759395636;
	bh=E1zmjjlBBxFy/4tW2HdcrJ+ALN1Y5NvGD8okhz9niTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eEgcoj0HTUeuPQwZWiDJKza2gIHCVMtt42cKaoN3X2/vNDYUKy4eZElMIsnLlqEOx
	 iG2hObnV+vdyID4+Fb07ANNmf3Ur4LaXJHsRHakzV0q0MxkTW4wSTttNgtKoUdKFZd
	 JKCvgbE0XHIYKZYrFA2X7r1O/eoB5Kp+3ybjoSaTZqYL0kS7bAA4hutKO+0ONRMS9r
	 safwTT/krqeoGpN20Fl8Ny+eYrf0HL84HJpDaq8choxFl1N8aW4frgF89TDMJkWmML
	 2zoSAqHQ5HpBq7YwywFGGkXLPNVfehfPM5aShwO4TmggkP7dC1TQyj6yd4wcSBcrP1
	 cI2IxsZ9Cut8w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A8C6D17E13E0;
	Thu,  2 Oct 2025 11:00:35 +0200 (CEST)
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
	wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: [PATCH v7 5/9] dt-bindings: regulator: Document MediaTek MT6373 PMIC Regulators
Date: Thu,  2 Oct 2025 11:00:24 +0200
Message-ID: <20251002090028.1796462-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002090028.1796462-1-angelogioacchino.delregno@collabora.com>
References: <20251002090028.1796462-1-angelogioacchino.delregno@collabora.com>
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
 .../regulator/mediatek,mt6373-regulator.yaml  | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
new file mode 100644
index 000000000000..4562f291fc0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
@@ -0,0 +1,137 @@
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
+
+  vsys-vbuck1-supply:
+    description: Input supply for vbuck1
+
+  vsys-vbuck2-supply:
+    description: Input supply for vbuck2
+
+  vsys-vbuck3-supply:
+    description: Input supply for vbuck3
+
+  vsys-vbuck4-supply:
+    description: Input supply for vbuck4
+
+  vsys-vbuck5-supply:
+    description: Input supply for vbuck5
+
+  vsys-vbuck6-supply:
+    description: Input supply for vbuck6
+
+  vsys-vbuck7-supply:
+    description: Input supply for vbuck7
+
+  vsys-vbuck8-supply:
+    description: Input supply for vbuck8
+
+  vsys-vbuck9-supply:
+    description: Input supply for vbuck9
+
+  vs1-ldo1-supply:
+    description: Input supply for vant18, vaud18, vcn18io
+
+  vs2-ldo1-supply:
+    description: Input supply for vrf12-aif, vrf13-aif
+
+  vs3-ldo1-supply:
+    description: Input supply for vrf09-aif, vsram-digrf-aif
+
+  vsys-ldo1-supply:
+    description: Input supply for vcn33-1, vcn33-2, vmc
+
+  vsys-ldo2-supply:
+    description:
+      Input supply for vaux18, vcn33-3, vefuse, vfp, vibr, vio28, vtp, vusb
+
+  vsys-ldo3-supply:
+    description: Input supply for vmch, vmch-eint-high/low
+
+patternProperties:
+  "^v(ant|aud|aux)18$":
+    $ref: "#/$defs/ldo-common"
+
+  "^vbuck[0-9]$":
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
+  "^v(cn18io|cn33-[123]|efuse|fp|tp|ibr|io28|sram-digrf-aif|usb)$":
+    $ref: "#/$defs/ldo-common"
+
+  "^vmc(h)?$":
+    $ref: "#/$defs/ldo-common"
+
+  "^vmch-eint-(low|high)$":
+    $ref: "#/$defs/ldo-common"
+
+  "^vrf(09|12|13|18|io18)-aif$":
+    $ref: "#/$defs/ldo-common"
+
+$defs:
+  ldo-common:
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
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
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
-- 
2.51.0


