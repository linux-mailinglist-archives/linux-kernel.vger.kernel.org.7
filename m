Return-Path: <linux-kernel+bounces-847181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5A9BCA2DC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEA2188C4BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218E4282E1;
	Thu,  9 Oct 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="jBRTzmKj"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78AA21B9FD;
	Thu,  9 Oct 2025 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027117; cv=none; b=hARU5krTbixA1k8M6wv5uTCG3WtV9F9o1RjIpQPIweeCQRHFp4/8nB9m+hMGJo7ILwFZLX3uIKPaOkWfV/QC6PMcyDtKbMMcle1OPdW8+2hZ/YWwO9H7FS5HVLXom50XYx0zsY63S+NyXuzfOi7tDkzae5cifnIW+/bAmC0rVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027117; c=relaxed/simple;
	bh=2T0aiUw/0cBFP3RJp7ZrmMIlK7txY5PYqQRd0j7B1Zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bjP2Do7W+Slp0xkgVpODj/WavY7/xZ0wBpOuh1Ozwr5+oNogvbKmElNEMzigGpk/o7FDxwKNkYXh5BETYJ4I2FDwXj2H9gj7LmJZa7q5i5iP8sosycBRV6T7iqtu0AE7jROXlmzmYJr+M6PnE/Oiqe6bxGcXIZhhsSI28qONs+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=jBRTzmKj; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6992925D78;
	Thu,  9 Oct 2025 18:25:14 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HTMYW0T5XTn5; Thu,  9 Oct 2025 18:25:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760027113; bh=2T0aiUw/0cBFP3RJp7ZrmMIlK7txY5PYqQRd0j7B1Zo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jBRTzmKj9btkgHOOt+gH+YIChw7b/Owti5/6d+Pce0oHTDuKvgno8mUA+3bYVIc3O
	 JN3Y9xv78dmyDi8lPfyDSg40bN9ikF4kqyFE0SiRAvxsX4kQf7iwUBkF7zUIrPQYng
	 Gl7ZZ29ryehCFImqKos9Oj6Xd7ewUGkCYHvQl30MZniNle1rL2VMTJ88UFuGpqmxfy
	 xWjnvHLv9VY6G+R+OL4gOLsP4ARMaumSPuRw8YnlQArKluKL1MqIpiUaLIWvpgwI7J
	 bdDoOB5kT1YdSO2BGQrjrrpujqI4uB2vp0kwBN1yPc9PtrH8R+zmHmuCB/4ddqG9Ai
	 9ZaHMAlrBFIZA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Thu, 09 Oct 2025 21:52:10 +0530
Subject: [PATCH RESEND v5 1/2] dt-bindings: display: panel: document
 Synaptics TDDI panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-panel-synaptics-tddi-v5-1-59390997644e@disroot.org>
References: <20251009-panel-synaptics-tddi-v5-0-59390997644e@disroot.org>
In-Reply-To: <20251009-panel-synaptics-tddi-v5-0-59390997644e@disroot.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760027068; l=3076;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=2T0aiUw/0cBFP3RJp7ZrmMIlK7txY5PYqQRd0j7B1Zo=;
 b=vWlP1NK4miUWi3xHSYhW3alaX+XOHqQ70zD3N90cUDuSi0Z7aLFM4fnhOYZIH0c3Dd590ZY7c
 VlhliPRsf8wCEmdT0gkCP/Y8aMZZUoZUC3GxRh7TNUoplPjbnnd9DFx
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Document the Synaptics TDDI (Touch/Display Integration) panel hardware.
Along with the MIPI-DSI panel, these devices also have an in-built LED
backlight device and a touchscreen, all packed together in a single chip.

Also, add compatibles for supported panels - TD4101 and TD4300. Both
have the '-panel' suffix so as to remove any ambiguity between the panel
and touchscreen chips.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.51.0


