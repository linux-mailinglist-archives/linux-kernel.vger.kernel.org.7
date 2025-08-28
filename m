Return-Path: <linux-kernel+bounces-789222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0150B3925F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C4E367BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A32413957E;
	Thu, 28 Aug 2025 04:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="WC0SZWJl"
Received: from ironport.ite.com.tw (219-87-157-213.static.tfn.net.tw [219.87.157.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C4520B7F4;
	Thu, 28 Aug 2025 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.87.157.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756353809; cv=none; b=B2/JWfmnG0BduGjajzM5IFQEK5FWUg3VM4UNql24j5Wz1j0m8yelrSTroHVHDGlE6ot/HbkZ4neS4CXEKHUnFWjEpFUx4eSo7rdTHRw7xZXQxZQ+gmVczjo+6Sl6iim6LOU79tZ6Js+NPSHJEMoOowTd+BxOTSnSXp26UHULjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756353809; c=relaxed/simple;
	bh=73ezne6M5Rsy6fYsYzyQy918r3sxdU5QXZ0HlmkKzJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jG7ZzEkwFIJ7C/80/ophq/lvsOetTI2NFwNUVLJaDXcxUy+qz7UHHMn/K/GrTzNW1jAUeRBNtAe5fSnjj+7v/RzsdxnFDg7te5SMbuimcx6b2U5zXJev1+XZmm4SVy+ZjUt7fkbkIj3LGpWORt5IXh7kz6tv1uxs3tk2IaXhFwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=WC0SZWJl; arc=none smtp.client-ip=219.87.157.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pvGULG+5sjt1fRfMEv928tGmfusxECJ2cQpzVS3kLb4=;
  b=WC0SZWJl0/w3XKTYornmnMyNmKyhUGgrtXgvRL/XUDHy1EbNXl02S71R
   Tg8Q8zhUpUyhmjo3rfU3t6CKuRebnxahcvIgGJQy4Lqq0GEvVNasWW+nW
   BKVGtVIiyWdLv4FKPElPeejd8nEt9p2K8Z3k81zN2GJkjV5nZMtwC527v
   uKL0q+7SVb5X28/fjtq1oMHnqlZBIZMDTcvRZroTHMJ5YkvoF9VGMuFiY
   DX04XXiXeJL05T3Vy0OJyb3aOfrMwiQPV5f+WGgCVxElBNQpLNsJphTg0
   ir47cOnFJp3rdJCW+a6E5oBcu9lliTZ/iewJDY0+q9zESG7c5JTqSSMGD
   w==;
X-CSE-ConnectionGUID: XDwxhCDZTvKnL8kCWEg5yw==
X-CSE-MsgGUID: fj6JBOO/Q2uxa0wrk9EtiA==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 28 Aug 2025 12:02:14 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 57S42829028019;
	Thu, 28 Aug 2025 12:02:08 +0800 (+08)
	(envelope-from Pet.Weng@ite.com.tw)
Received: from [127.0.1.1] (192.168.72.40) by CSBMAIL1.internal.ite.com.tw
 (192.168.65.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 12:02:07 +0800
From: Pet Weng <pet.weng@ite.com.tw>
Date: Thu, 28 Aug 2025 12:01:18 +0800
Subject: [PATCH v2 1/3] dt-binding: display: Add ITE IT61620 MIPI DSI to
 HDMI bridge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250828-it61620-0714-v2-1-586f5934d5f8@ite.com.tw>
References: <20250828-it61620-0714-v2-0-586f5934d5f8@ite.com.tw>
In-Reply-To: <20250828-it61620-0714-v2-0-586f5934d5f8@ite.com.tw>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hermes Wu <hermes.Wu@ite.com.tw>,
        Kenneth
 Hung <kenneth.Hung@ite.com.tw>,
        Pet Weng <pet.weng@ite.com.tw>, Pin-yen Lin
	<treapking@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756353731; l=4585;
 i=pet.weng@ite.com.tw; s=20250702; h=from:subject:message-id;
 bh=73ezne6M5Rsy6fYsYzyQy918r3sxdU5QXZ0HlmkKzJI=;
 b=yjL7kd4orJ+za/mql/RzawGDOs8i8ZY+8PfTugHo/KwIdqPukTp3mEAkEjtiX/u2hIX27Vr4+
 JtUky97HlLfASvBgbm8c4fEM7pBC3OOHu+pOUAPW8z03m7cq19RBi8I
X-Developer-Key: i=pet.weng@ite.com.tw; a=ed25519;
 pk=wd08uBtTLb93x2ixbKVNsxiZPdMh1Ov4z5klodh2bqo=
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP:
	6E2576DFD6919CCBDF3EEA1DE6FC3620B1700D72708749A6AB489DFFDDC08D4C2002:8
X-MAIL:mse.ite.com.tw 57S42829028019

This chip receives MIPI DSI input and outputs HDMI, and is commonly
connected to SoCs via I2C and DSI.

Signed-off-by: Pet Weng <pet.weng@ite.com.tw>
---
 .../bindings/display/bridge/ite,it61620.yaml       | 143 +++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it61620.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it61620.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..dd8a54a1e0aa9bbbd9d02e68398bb5df65b821a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ite,it61620.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/ite,it61620.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ITE IT61620 MIPI DSI to HDMI Bridge
+
+maintainers:
+  - Pet Weng <pet.weng@ite.com.tw>
+
+description: |
+  The ITE IT61620 is a high-performance, low-power HDMI bridge that converts
+  MIPI DSI input to HDMI 1.4b TMDS output. It supports up to 4 lanes of MIPI
+  D-PHY 2.0 input at 2.5Gbps per lane (10Gbps total), compatible with DSI-2 v2.0.
+
+  The HDMI transmitter side supports up to 4Kx2K@30Hz resolutions, and is
+  compliant with HDMI 1.4b and HDCP 1.4.
+
+  For audio, the IT61620 supports up to 8-channel LPCM via I2S (multi-line or
+  TDM mode), with optional S/PDIF or DSD (for SACD). It supports audio
+  sampling rates up to 192kHz.
+
+allOf:
+  - $ref: /schemas/sound/dai-common.yaml#
+
+properties:
+  compatible:
+    const: ite,it61620
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: interrupt specifier of INT pin
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO specifier of RESET pin
+
+  ivdd-supply:
+    description: core voltage
+
+  ovdd-supply:
+    description: I/O voltage
+
+  ovdd1833-supply:
+    description: flexible I/O votage
+
+  pinctrl-names:
+    items:
+      - const: default
+
+  pinctrl-0:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: Input port for MIPI DSI
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes: true
+
+            required:
+              - data-lanes
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Output port for HDMI output
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - ivdd-supply
+  - ovdd-supply
+  - ovdd1833-supply
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ite61620@58 {
+                compatible = "ite,it61620";
+                reg = <0x58>;
+                #sound-dai-cells = <0>;
+                interrupt-parent = <&pio>;
+                interrupts = <128 IRQ_TYPE_LEVEL_LOW>;
+                pinctrl-names = "default";
+                pinctrl-0 = <&it61620_pins>;
+                reset-gpios = <&pio 127 GPIO_ACTIVE_LOW>;
+                ivdd-supply = <&pp1000_hdmi_x>;
+                ovdd-supply = <&pp3300_vio28_x>;
+                ovdd1833-supply = <&pp1800_vcamio_x>;
+
+                ports {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+
+                        port@0 {
+                                reg = <0>;
+                                it61620_dsi_in: endpoint {
+                                        data-lanes = <0 1 2 3>;
+                                        remote-endpoint = <&dsi_out>;
+                                };
+                        };
+
+                        port@1 {
+                                reg = <1>;
+                                it61620_hdmi_out: endpoint {
+                                        remote-endpoint = <&hdmi_connector_in>;
+                                };
+                        };
+                };
+        };
+    };

-- 
2.34.1


