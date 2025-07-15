Return-Path: <linux-kernel+bounces-731781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B99B4B0596E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5AAC7AFEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451F12E2EE8;
	Tue, 15 Jul 2025 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FJTKcRIn"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384CA2DECBA;
	Tue, 15 Jul 2025 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580657; cv=none; b=SMfYnfWYBld91Cl43gZP/qSgug2Loso7/IWyjLKa8KLM+VpA3fK9nyJMTKCunlwyuZ9lmG/D5V1bfWHYf1ICxVHRW1FtZjVVlGX6yudgBoW0UPftiiZCelktiCSrHS7Xdbcy2NeTpXl2JkZSkvS9/ojOEnx6++bJ73yM/hkKx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580657; c=relaxed/simple;
	bh=grcguUfZdGaKxEu4u85NSbdJw2GhXrB/stEdT483pVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2CDZzLwZrTROl2tWypwgpRl+hTZqOo4XIFy8DApc3qi5kbqFQAXg870yTYPHQSENv+iZ14/V7dxWyRopB9XT390XQy572u8W9UxnaA28VWsnrPuMMtrZX7TTBUHM7DWyxIksZfzzIVSi88P0b2ErFWrN3+ljc6n+W+nCqDV6xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FJTKcRIn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752580650;
	bh=grcguUfZdGaKxEu4u85NSbdJw2GhXrB/stEdT483pVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FJTKcRInLd79IeC7UIa0OrpeE0KHF6a2p6ogb2uDQ7MJdHx1Yjn9Ci3AHnISiXVG7
	 rEnggWbifmypYy46ceysMJIrdKRCcwfI/QHzQJlopCsp5i39W5Xf54LYV7EJAfTlDd
	 wZ2zDOKLR7T86VysT5cwT8MSw+UOyK93ORN6wwZ+tPxBkWAVkHAZFj/vluKzLzS3nM
	 ATgEvI7OIHMljhPKQKIG5QZr7IC6WKXRmk1IhKx/+9hNvwg3zSlTeLXdHK6dKRIOK9
	 qa4hJTFMrMFTCpIsFGIB8idWd9Oa7yydFlns467m+SLQJ6sbPm6waTJQ3iCQmW4J25
	 9sKZIvtlNZSZg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5A8A417E1321;
	Tue, 15 Jul 2025 13:57:29 +0200 (CEST)
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
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v4 7/8] dt-bindings: mfd: Add binding for MediaTek MT6363 series SPMI PMIC
Date: Tue, 15 Jul 2025 13:57:17 +0200
Message-ID: <20250715115718.176495-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715115718.176495-1-angelogioacchino.delregno@collabora.com>
References: <20250715115718.176495-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a binding for the MediaTek MT6363/6373 (and similar) multi
function PMICs connected over SPMI.

These PMICs are found on board designs using newer MediaTek SoCs,
such as the Dimensity 9400 Smartphone chip, or the Chromebook
MT8196 chip.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Link: https://lore.kernel.org/r/20250623120038.108891-2-angelogioacchino.delregno@collabora.com
Link: https://lore.kernel.org/r/20250707134451.154346-8-angelogioacchino.delregno@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/mfd/mediatek,mt6363.yaml         | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
new file mode 100644
index 000000000000..b19755b3104c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/mediatek,mt6363.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6363 series SPMI PMICs multi-function device
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description: |
+  Some MediaTek Power Management ICs (PMICs) found in board designs with
+  the Helio, Dimensity and/or Kompanio series of SoCs are interfaced to
+  the chip via the System Power Management Interface (SPMI) bus.
+
+  These PMICs are multi-function devices with various sub modules.
+  For example, those may include one, or more of the following:
+  - Auxiliary ADC Controller
+  - Clock Controller
+  - eFuses
+  - GPIO Controller
+  - Interrupt Controller
+  - Keys
+  - LEDs Controller
+  - Regulators
+  - RTC
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6363
+      - mediatek,mt6373
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 3
+
+patternProperties:
+  "^adc@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
+    properties:
+      reg:
+        maxItems: 1
+    unevaluatedProperties: false
+
+  "^regulators@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        contains:
+          enum:
+            - mediatek,mt6363-regulator
+            - mediatek,mt6373-regulator
+    oneOf:
+      - $ref: /schemas/regulator/mediatek,mt6363-regulator.yaml#
+      - $ref: /schemas/regulator/mediatek,mt6373-regulator.yaml#
+    additionalProperties: true
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/spmi/spmi.h>
+
+    spmi {
+      #address-cells = <2>;
+      #size-cells = <0>;
+
+      pmic@4 {
+        compatible = "mediatek,mt6363";
+        reg = <0x4 SPMI_USID>;
+        interrupts = <4 64 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #address-cells = <1>;
+        #interrupt-cells = <3>;
+        #size-cells = <0>;
+
+        regulators@30 {
+          compatible = "mediatek,mt6363-regulator";
+          reg = <0x30>;
+        };
+
+        adc@1000 {
+          compatible = "mediatek,mt6363-auxadc";
+          reg = <0x1000>;
+          #io-channel-cells = <1>;
+        };
+      };
+    };
-- 
2.50.1


