Return-Path: <linux-kernel+bounces-757149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276D6B1BE56
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418371810E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26C619005E;
	Wed,  6 Aug 2025 01:34:23 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC372622;
	Wed,  6 Aug 2025 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754444063; cv=none; b=UEoHrvZDKaE173KuM7US8/1Gt3cc1/ZDOP0db/7RcW15pVHnBEOR9N9Rz2L8DbLhqsxdMoghV7FlgjUtzBMaQ2fMAkCFM/q+YF4li2g3bXNxTfNxibX/r+o6lwzNyPhjBSmHtebJ7eLILQhhhgSS6QM3BQGI8mGeS3uDfHRcfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754444063; c=relaxed/simple;
	bh=IvanukU+UNXQOoA/r/ovJh3AmSbHnkCZN2XDfm043jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BumNWj7/QKoVJOjWTLTSH29D5r3MDlojAEsyxTNJ0Jcy9yL1Olyf5nwWH2/5rAZKsN7ZG29SR64GGoYhJzD+gx3UgcthrwHvgO2Kb+xUxYR+jfdLw51Aj4cH9D8X4s79fNFxkCfMc0/okG55cYdHYmZk0AJJT+AHlSd2jZtszkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 91C6F1A0E05;
	Wed,  6 Aug 2025 03:34:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 54BAC1A0DEB;
	Wed,  6 Aug 2025 03:34:13 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8AD4018000A0;
	Wed,  6 Aug 2025 09:34:10 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Date: Wed, 06 Aug 2025 10:33:32 +0900
Subject: [PATCH v3 1/3] dt-bindings: display: bridge: Add waveshare DSI2DPI
 unit support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-waveshare-v3-1-fd28e01f064f@nxp.com>
References: <20250806-waveshare-v3-0-fd28e01f064f@nxp.com>
In-Reply-To: <20250806-waveshare-v3-0-fd28e01f064f@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, victor.liu@nxp.com, 
 Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754444048; l=3102;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=IvanukU+UNXQOoA/r/ovJh3AmSbHnkCZN2XDfm043jg=;
 b=85WSx0/z0ijxXeVwi3YN5+mo0atmZw7LORIwXCOKztIXkVQ8BOSy59oQJoDcChaL1oabBQjbN
 0P/6auivAaQC9QasMxDZ+0M01ixcWZDwjQSJOTC4SKOqLYOClRKXbgd
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP

Add dt-binding documentation for waveshare DSI2DPI unit

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
Suggested-by: Liu Ying <victor.liu@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Change from v1 to v2
- /s/i2c0/i2c/
---
 .../bindings/display/bridge/waveshare,dsi2dpi.yaml | 103 +++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml b/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..5e8498c8303dd7415ecca97d12ac97362db73cf5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/waveshare,dsi2dpi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Waveshare MIPI-DSI to DPI Converter bridge
+
+maintainers:
+  - Joseph Guo <qijian.guo@nxp.com>
+
+description:
+  Waveshare bridge board is part of Waveshare panel which converts DSI to DPI.
+
+properties:
+  compatible:
+    const: waveshare,dsi2dpi
+
+  reg:
+    maxItems: 1
+    description: base I2C address of the device
+
+  power-supply: true
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Video port for MIPI DSI input
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                description: array of physical DSI data lane indexes.
+                items:
+                  - const: 1
+                  - const: 2
+
+            required:
+              - data-lanes
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Video port for MIPI DPI output panel.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - ports
+  - power-supply
+
+additionalProperties: false
+
+examples:
+  - |
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      bridge@45 {
+        compatible = "waveshare,dsi2dpi";
+        reg = <0x45>;
+        power-supply = <&reg_3p3v>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+
+            waveshare_from_dsim: endpoint {
+              data-lanes = <1 2>;
+              remote-endpoint = <&dsim_to_waveshare>;
+            };
+          };
+
+          port@1 {
+            reg = <1>;
+
+            waveshare_to_panel: endpoint {
+              remote-endpoint = <&panel_to_waveshare>;
+            };
+          };
+        };
+      };
+    };
+
+...

-- 
2.34.1


