Return-Path: <linux-kernel+bounces-754610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E82B3B19A12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E9A7A9292
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 02:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F94E1F5838;
	Mon,  4 Aug 2025 02:08:11 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564BB2E36EB;
	Mon,  4 Aug 2025 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754273291; cv=none; b=ZLcOWzJ1fva0fUJsv7jXETDSsV+6C/xJgEQNB8FYDQRFnqLnF2gwvp0IEmM6xMG1SUC4WfKPAKsrETE2U++G0Ost5uj4bBtZmoPSQGiGI3u68850P1huP3vnThkKCbCqHyG4Wi5n8Q8+9o/faSOJ2vovJY1Aj0dlluXl0Q8/ngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754273291; c=relaxed/simple;
	bh=8FvrtUOnAGgo3ba+1Br9rPQoipPb1zI8c5qdiu/PVGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYyFdxp2riWcJF0Es3Rx6ZBjuABBln7CuMKBGQgJK2nC4rzeZY13+AzA1uKs602kxrTj9MAYzTUSzTtWRlLOngJl3RUmaquRn/vd8ZPWXuDMbR4IP3BnSsey8l9Rc+DEsYg5crwKClwztRvDf0G1VumwR9UHV2C9lAEClWpG268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C56A1A0323;
	Mon,  4 Aug 2025 04:08:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 14C521A0306;
	Mon,  4 Aug 2025 04:08:02 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A272718000AF;
	Mon,  4 Aug 2025 10:07:59 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Date: Mon, 04 Aug 2025 11:07:40 +0900
Subject: [PATCH v2 1/3] dt-bindings: display: bridge: Add waveshare DSI2DPI
 unit support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-waveshare-v2-1-0a1b3ce92a95@nxp.com>
References: <20250804-waveshare-v2-0-0a1b3ce92a95@nxp.com>
In-Reply-To: <20250804-waveshare-v2-0-0a1b3ce92a95@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754273277; l=3057;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=8FvrtUOnAGgo3ba+1Br9rPQoipPb1zI8c5qdiu/PVGM=;
 b=OO8i0h8Ryb2vADcTqqbImHNc57YcSIiSJX3PgkQpzVrpMCfdlanGGBdowIRWNEhiAWTAsFDEY
 wCdHx5XRHU2C4Jy9/ziuzgOOiH2KjZTNglt/zqNQyCUIiOBZRI8Ifx8
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP

Add dt-binding documentation for waveshare DSI2DPI unit

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
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


