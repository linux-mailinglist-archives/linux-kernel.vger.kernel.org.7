Return-Path: <linux-kernel+bounces-841144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFD4BB6583
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 747F24EB514
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA772EAD05;
	Fri,  3 Oct 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aFhuMm/h"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5BF2DCF7C;
	Fri,  3 Oct 2025 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482733; cv=none; b=r8wOYSPd84uRg2pm/NHojIjA9ZaM7UHK5FQKAdmrAmkTVjK5YgSn8V2Ka+W8OQs6TxqcnVXUNdyzwo8ff2PR27+Lo01Z2DzmUm5hwJU/VyFasnSN7NNHTEc3EvPunhy2oRLu3/1/co2KD1Vt/QCD5TFebFSb8mTe8P4fxt4060o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482733; c=relaxed/simple;
	bh=TZW3NB4/OAPrx3REXijGTRzYymbTmMvwT8YxeXIwCCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpKunbM9VThO3mnVT10WXBtPoFLYzRqrr5YG3W5Ug8anDUZZv6jNDxH5lhVgCeYcQbc5X0EHBbtN5GyqXOaTmiuJmXFKQcyzjMSkWslQMCJAjBZ3aLd5KC43E+SuyDqLpd1jxonqqqz0I7EzStboe9gKuMEzWv/aLReYkmVZfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aFhuMm/h; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759482727;
	bh=TZW3NB4/OAPrx3REXijGTRzYymbTmMvwT8YxeXIwCCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFhuMm/hXG4JpG3JhhMnBG8wXrAj5KL5LNQek8WqupkZww9lLvxacuMGPg3VG3RqL
	 NGNiRX/twGiIhNbUM7bzpQs/X1vjZT2S+fJRxdCuU9B6OvYF2H0tmFdd9khsCkVWK5
	 3HMI/nm27G69odjVuWKh6L6clBOVaRi/b18OkWcr+hq7kwsOxFcwpbniBLd5fd8cAo
	 1bRDQw+t6+mBXCueF3vdn4IfPPI+kprou8GGET/RMoSID2dM/2t8i3TkgSXiP7g9HE
	 QIvo+YR/RSbscLXWq/e9Nq5oLq2HzJtodfeh0oFNNO0Fnc1ZK7B2ZRAcF6MF2mNbpB
	 l6Wwf0gjlnfXA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F149E17E13C1;
	Fri,  3 Oct 2025 11:12:06 +0200 (CEST)
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
	igor.belwon@mentallysanemainliners.org,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v8 8/9] dt-bindings: mfd: Add binding for MediaTek MT6363 series SPMI PMIC
Date: Fri,  3 Oct 2025 11:11:57 +0200
Message-ID: <20251003091158.26748-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003091158.26748-1-angelogioacchino.delregno@collabora.com>
References: <20251003091158.26748-1-angelogioacchino.delregno@collabora.com>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/mfd/mediatek,mt6363.yaml         | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
new file mode 100644
index 000000000000..8cfb2e9a9389
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
@@ -0,0 +1,116 @@
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
+  - '#size-cells'
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
+
+          vio18 {
+            regulator-name = "pp1800-vio18-s3";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+            regulator-allowed-modes = <0 2>;
+            regulator-allow-set-load;
+            regulator-over-current-protection;
+          };
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
2.51.0


