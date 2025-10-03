Return-Path: <linux-kernel+bounces-841137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ABCBB6565
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDBEA19C4F03
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDED2DC797;
	Fri,  3 Oct 2025 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PjgCZkFj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CCF284687;
	Fri,  3 Oct 2025 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482727; cv=none; b=dkiOdgdLBfj5jKwzGOuZMNPfmDC2DqLD4jlNHusFD1mbzmkmblriKrX4UW41NQcZmT41uA5/mm5rdS+Z1Rt2ZPevghFDalhwtG6IQstj0vdcEAiu3TacIUQVOpgMQbegYgYbm2+9PLaecpb6Rgd3BDX5B+GnZR0NakHuDiO287o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482727; c=relaxed/simple;
	bh=OJ2WCrlDsNvJIgqvoenQOJhkrHmYAWEaYUOwsHP408k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJrWmKtnKAujWr5/caCxhQwqVqvPxT4VT5DDaQcFgbZxegQk8BiJtSkt9HFk/jYcC3aHF+STFsAMpDEtCvmXuioDIpxdJ3IaJU8fCvaNhmKLi51fOjbBjq/l42MPdcziKPH9Yc8BMs+d5Aytdq3XLdjWAX88xQFvUDY7jqK4Mas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PjgCZkFj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759482723;
	bh=OJ2WCrlDsNvJIgqvoenQOJhkrHmYAWEaYUOwsHP408k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PjgCZkFjIZnA+5INPSCYHvYcP+UdQoatHxOdOCqYfRhpLrtorZBlfrUIi5XWCVHcn
	 GcU43hhtCFBuUxWWP8VXsYmoRLgBmiB7e3aFXEtsf1QbBYC7vIMFpvPzQkMNOCIX4w
	 /x/Lkx2E10iCq2OtuYzfBxmQ9eBqRE7xysnBZbXnilR4b34o7gzncyID/EbOsUhuMW
	 9sHfj4EIzzpc8tLQdP2b5WDHMLcV66uC6dJ2B7VsE5AxNCccVaiAmnnl29ED6UIYxp
	 fnhYe/+idtTSBpcxxzRU+mEfYV3pvNRSyY8VgASQgcRPTydiqURpJqaQebGCe4ykuV
	 3nOYU0Dk/cJ5g==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 48E1D17E12F3;
	Fri,  3 Oct 2025 11:12:03 +0200 (CEST)
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
Subject: [PATCH v8 3/9] dt-bindings: regulator: Document MediaTek MT6363 PMIC Regulators
Date: Fri,  3 Oct 2025 11:11:52 +0200
Message-ID: <20251003091158.26748-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003091158.26748-1-angelogioacchino.delregno@collabora.com>
References: <20251003091158.26748-1-angelogioacchino.delregno@collabora.com>
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../regulator/mediatek,mt6363-regulator.yaml  | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml
new file mode 100644
index 000000000000..4f79d4f81d49
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml
@@ -0,0 +1,146 @@
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
+  vsys-vs1-supply:
+    description: Input supply for vs1
+
+  vsys-vs2-supply:
+    description: Input supply for vs2
+
+  vsys-vs3-supply:
+    description: Input supply for vs3
+
+  vs1-ldo1-supply:
+    description: Input supply for va15, vio0p75, vm18, vrf18, vrf-io18
+
+  vs1-ldo2-supply:
+    description: Input supply for vcn15, vio18, vufs18
+
+  vs2-ldo1-supply:
+    description: Input supply for vsram-cpub, vsram-cpum, vrf12, vrf13, vufs12
+
+  vs2-ldo2-supply:
+    description: Input supply for va12-1, va12-2, vcn13, vsram-cpul
+
+  vs3-ldo1-supply:
+    description: Input supply for vsram-apu, vsram-digrf, vsram-mdfe
+
+  vs3-ldo2-supply:
+    description: Input supply for vsram-modem, vrf0p9
+
+  vsys-ldo1-supply:
+    description: Input supply for vaux18, vemc, vtref18
+
+patternProperties:
+  "^v(buck[1-7]|s[1-3])$":
+    description: Buck regulators
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
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
+
+  "^va(12-1|12-2|15)$":
+    $ref: "#/$defs/ldo-common"
+
+  "^v(aux|m|rf-io|tref)18$":
+    $ref: "#/$defs/ldo-common"
+
+  "^v(cn13|cn15|emc)$":
+    $ref: "#/$defs/ldo-common"
+
+  "^vio(0p75|18)$":
+    $ref: "#/$defs/ldo-common"
+
+  "^vrf(0p9|12|13|18)$":
+    $ref: "#/$defs/ldo-common"
+
+  "^vsram-(apu|cpub|cpum|cpul|digrf|mdfe|modem)$":
+    $ref: "#/$defs/ldo-common"
+
+  "^vufs(12|18)$":
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


