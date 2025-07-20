Return-Path: <linux-kernel+bounces-738198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F17DB0B5B1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F453B4997
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE39020C009;
	Sun, 20 Jul 2025 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Lzo0ACJu"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287DB1F419A;
	Sun, 20 Jul 2025 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753012945; cv=none; b=A4+Jj5x+hRNxuhllo+nGeC4OVa2HcJwWphxW3Kjoom9sQVmehjp4RW//CGmxw1RZU9JclBkk2JvMYOIQ7VVdeYYjbhKVE7ORo+dysHmg4vjZZFPJM4CtMiSxAxOE95uYN7Zjbx0tzaCsVBDYsg08Iw0aLcJOwD4r1rNVAR2x6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753012945; c=relaxed/simple;
	bh=We7amH1B4SyPPjeaqUpaFP4DU6xAfLuufxsp/dk8cPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bDigqRJSNKqs1tQH7cBXmNyfSMi2HzNfTE/IfO6hHzCnOT02qeCrF+lLKQLhMvA9wa70gYRwLzGSU2lragLoi/oPNTL2GPKDJiPDEerbu5+P+EbyhJI7B5q0oZtm0kZzBF9zgJ2aQUelUVAMzgikHmT1qMVLXM3N6ltjxHGD+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Lzo0ACJu; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4ED2922F3E;
	Sun, 20 Jul 2025 14:02:21 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SpD6C_8uplgD; Sun, 20 Jul 2025 14:02:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753012939; bh=We7amH1B4SyPPjeaqUpaFP4DU6xAfLuufxsp/dk8cPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Lzo0ACJukD3HzY65fEkk00FxZd0PM44qENHVRnmgGruPUlK13erecsYNidEzNysQ9
	 vnx5p5DCp+8GFpo1mRXo4lGoO6EDH2Ddao3hnpKWKou26G1ZHRPn/SIlBxaB9F1Deu
	 xWWe7uQVXFh+HnMHS4uTL80QqJ85LdlkKGldUgqBdADRZv+5V3KKVybB6Ohw+dA9WS
	 GIQga00QB736mg1+Rvl77yU/X6//CRDDgP/VELOGzNOj6HHf0UJwYfMpT62tkBo0m9
	 ojiqBbwayIOomVv6g7SD7TNLUPikhCFoyn9E4oFnadcBX9MqNFuN2/i9NMIiGd8tju
	 jdPXA1xwMK/IQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sun, 20 Jul 2025 17:31:54 +0530
Subject: [PATCH v3 1/2] dt-bindings: display: panel: document Synaptics
 TDDI panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-panel-synaptics-tddi-v3-1-43a5957f4b24@disroot.org>
References: <20250720-panel-synaptics-tddi-v3-0-43a5957f4b24@disroot.org>
In-Reply-To: <20250720-panel-synaptics-tddi-v3-0-43a5957f4b24@disroot.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753012923; l=3009;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=We7amH1B4SyPPjeaqUpaFP4DU6xAfLuufxsp/dk8cPI=;
 b=73U7JZnBYGPbIOu9f7JOo5/lDGzi7DrOAqgM19A10NkZ79mJvf52G7HI7IIdNwBZhYKIZpCgi
 xCLOqAvLG3fB5QX2DIgbAiGzYVq5AOgyDrZSkSZP/Qgo2lQJYmkH+De
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


