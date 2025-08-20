Return-Path: <linux-kernel+bounces-777944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7B1B2DF70
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330A51C86808
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DEB2E3AE9;
	Wed, 20 Aug 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iCk+uVwJ"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E40274B42;
	Wed, 20 Aug 2025 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699949; cv=none; b=RWaTV7dgXgLfA3CZarfCEkh+aYUDCH4i9FeIkj+JM0DJ38c++gutbe1R3YGGDcyEYamnIWN+n1eocxBtTPQGHnpciHRxePRxHL27oh/MUENTmffG4uA924xe52lCrjcLENEgpHN1EzYeUjRapiG8yO5TdIMRXEVncEZVxKSjd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699949; c=relaxed/simple;
	bh=p7l3ijfCEWwQJ+xrSJN3btKzJvTlfULqoMFEd7FhHC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kpYWrQQXNmD6kn40lvI2aQzI1KO9EGiBSD2+HMKaIsNbvFZU+QsVEedtoJ/Oh084ksS8npPjdWdfMGld7ipolEl9PWMPEAMiwQiFQAiRTrNIyCbjonuBB57/a3lKITpVGeZ6+0xMx0ruBixhHLbPvBVec6UtLyavpoEZRRcHwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iCk+uVwJ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2CFB622F3F;
	Wed, 20 Aug 2025 16:25:46 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O9dk9dUKxJOp; Wed, 20 Aug 2025 16:25:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755699945; bh=p7l3ijfCEWwQJ+xrSJN3btKzJvTlfULqoMFEd7FhHC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iCk+uVwJYTF4ISiDamqdwpqzqX7vkHGAnhzS5CMSgiLXeY9+81MtY1V/JNYeP28RO
	 rTEt0uHL5SWoRmizqEWGxaXZxORRECP5WYkQGBFS0HVHls34xdw433PQf7YPf9HpIx
	 f9/2b9a3krShWojFWAnwfVCAOpudAAKkpPGAinIopMhNTsbVtdW0xs+fBtgBg9LCoW
	 iSAEy5AdLPHig/KD6LfSMqonXvPjX8SM2Hf46OqJ8HMWuKhF+1BaCbQGzRJp5lRCve
	 6WOZnaQ5qyxOcJ9GMNeDEU+rzSrhv1GHXLsAs5c9vji5tLZM5UBBHDmiaUx/WzKItE
	 Pt4jRvOyq4E8Q==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 20 Aug 2025 19:54:26 +0530
Subject: [PATCH v5 1/2] dt-bindings: display: panel: document Synaptics
 TDDI panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-panel-synaptics-tddi-v5-1-d4e3fd4987c6@disroot.org>
References: <20250820-panel-synaptics-tddi-v5-0-d4e3fd4987c6@disroot.org>
In-Reply-To: <20250820-panel-synaptics-tddi-v5-0-d4e3fd4987c6@disroot.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755699927; l=3076;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=p7l3ijfCEWwQJ+xrSJN3btKzJvTlfULqoMFEd7FhHC8=;
 b=jV7L/GzC3cvQmWimQ20MbHPJ9c2wUl8vEhWIAIDffxMypnsbk18glDZrGRaCgJHVMfyIFd2sW
 ESDcD4juD2fAntkPqRsbfQwGBOoA3u39wKN24DRvl0P3pLlRV1S3stj
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
2.50.0


