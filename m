Return-Path: <linux-kernel+bounces-776044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF7CB2C7D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5C67262B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC622857CB;
	Tue, 19 Aug 2025 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CP4gC+O0"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36B828504B;
	Tue, 19 Aug 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615433; cv=none; b=hw6heSlLyW3xrNUb9gCXywSNQhqSV0qz/AcInaHThNAzO+JqkrhMQmNBncT54ZIhJeGaAXx1UFnsh41NJ1LPOrj4NB/ljVZWdI5UFO9HDMDA3PxnOkZ1viQ7sjj6wLu1Bn37YJNpWgJO3XePn5PLQWFzNlQo0o+MnWT2EREX+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615433; c=relaxed/simple;
	bh=We7amH1B4SyPPjeaqUpaFP4DU6xAfLuufxsp/dk8cPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cOqQ8Sa38yOh8Sb/4qRc4VhKIJizNvmJ7S7r92ZMrOY4H7AHc9/8iuKjv8aw/CRIjdTQjVeqie+FqaRJjiIdxXGZy4lQS3l3bpnHjrCvIAdJLgcpB/7gqMUV5t7KcIcKhNw74afs98u3knZkpgN4rivsE1XqxIznnnVS48GVqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CP4gC+O0; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5A6A920D2A;
	Tue, 19 Aug 2025 16:57:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w_9U3BbE2EY6; Tue, 19 Aug 2025 16:57:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755615429; bh=We7amH1B4SyPPjeaqUpaFP4DU6xAfLuufxsp/dk8cPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CP4gC+O0vh/j1nF/ZcZyYYmcySop5s8U3QTZfohi3qs6XH6StcQwGvga65dWbVvIa
	 52EpDPqf+jmTKk3c/2BbI8XOJ8mHtmn8ymDqJCXbwoS38/tRVVN44fsABM11k0CxgQ
	 DyfDJVFmckjZ6OB45AGgSEMwKl1HWQOJ7RAGf7RMvKS8Q64zFZMl7yfQPYJrFHRp8G
	 t7a0fEU290lVPra4OiupPycCNTnyiIq5YhIPZQcel9joc7Nk1fSUBNb44yj3d8rVwi
	 fcM3P5zwyrMk99e4lLqkXqTHUG+QOtAC2WQ4CZG9VFi/icNfkwLfHUsNmX5bq/HlqF
	 4rrBAT3URohbQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 19 Aug 2025 20:26:44 +0530
Subject: [PATCH v4 1/2] dt-bindings: display: panel: document Synaptics
 TDDI panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-panel-synaptics-tddi-v4-1-448f466d16a6@disroot.org>
References: <20250819-panel-synaptics-tddi-v4-0-448f466d16a6@disroot.org>
In-Reply-To: <20250819-panel-synaptics-tddi-v4-0-448f466d16a6@disroot.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755615411; l=3009;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=We7amH1B4SyPPjeaqUpaFP4DU6xAfLuufxsp/dk8cPI=;
 b=KF2t3a6LrkLl90sKyXsE4ARvF2XMo2o4RvpKcOi9iXgz2dunnxjikdRuzCA0/+JEUQDr5Semf
 FIVOGkYJWFlCcxSIC34nT3hnZPavMc+8QAvMKplPmDrx1b5NKESmU4m
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Document the Synaptics TDDI (Touch/Display Integration) panel hardware.
Along with the MIPI-DSI panel, these devices also have an in-built LED
backlight device and a touchscreen, all packed together in a single chip.

Also, add compatibles for supported panels - TD4101 and TD4300. Both
have the '-panel' suffix so as to remove any ambiguity between the panel
and touchscreen chips.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../display/panel/synaptics,td4300-panel.yaml      | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/synaptics,td4300-panel.yaml b/Documentation/devicetree/bindings/display/panel/synaptics,td4300-panel.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..152d94367130e9d80a885fe87a2da53db88e3393
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/synaptics,td4300-panel.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/synaptics,td4300-panel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synaptics TDDI Display Panel Controller
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - syna,td4101-panel
+      - syna,td4300-panel
+
+  reg:
+    maxItems: 1
+
+  vio-supply:
+    description: core I/O voltage supply
+
+  vsn-supply:
+    description: negative voltage supply for analog circuits
+
+  vsp-supply:
+    description: positive voltage supply for analog circuits
+
+  backlight-gpios:
+    maxItems: 1
+    description: backlight enable GPIO
+
+  reset-gpios: true
+  width-mm: true
+  height-mm: true
+  panel-timing: true
+
+required:
+  - compatible
+  - reg
+  - width-mm
+  - height-mm
+  - panel-timing
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "syna,td4300-panel";
+            reg = <0>;
+
+            vio-supply = <&panel_vio_reg>;
+            vsn-supply = <&panel_vsn_reg>;
+            vsp-supply = <&panel_vsp_reg>;
+
+            backlight-gpios = <&gpd3 5 GPIO_ACTIVE_LOW>;
+            reset-gpios = <&gpd3 4 GPIO_ACTIVE_LOW>;
+
+            width-mm = <68>;
+            height-mm = <121>;
+
+            panel-timing {
+                clock-frequency = <144389520>;
+
+                hactive = <1080>;
+                hsync-len = <4>;
+                hfront-porch = <120>;
+                hback-porch = <32>;
+
+                vactive = <1920>;
+                vsync-len = <2>;
+                vfront-porch = <21>;
+                vback-porch = <4>;
+            };
+        };
+    };
+
+...

-- 
2.50.0


