Return-Path: <linux-kernel+bounces-738201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E74B0B5BA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDA3189786B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF79220C009;
	Sun, 20 Jul 2025 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="dFQwoIQb"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C65820B7E1;
	Sun, 20 Jul 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013009; cv=none; b=eBW6goVzvlcdZ1X1iorSd+YaPX0lO91NiDDdzdhnTnwFrBHQ4EjJ3dBqUlWKiooOGYBe43rrKzGOGdK+KS+95sj+KUOVHPdue7NTLAU6k36/Qie6RP6Y8TFX16KguFtLwLKJIoYL6cFeSnyooB+Iv0lTf9gUbYDncfwXHWjPpGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013009; c=relaxed/simple;
	bh=V8H2sOCpM7ipVF4MyaUQHDZH0lIhrU9NycxkG2AHxok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bPIT1RHv+XXUnVpybnIIzg2AKecHuyyiegKyok3ABlacGxrx/oABF4W+CcerBlGI/g94v13iQoknLHs5zpkbG6XEYudiMyAXDQ6baBJHhYB+6Son6rAdI+k//zXcPwAkLFe2m4ueOkaH1FkcUi469PXWJprfgYSyRRYhg6pikoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=dFQwoIQb; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BFD3A25DF5;
	Sun, 20 Jul 2025 14:03:25 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y8mTaVHPdMyd; Sun, 20 Jul 2025 14:03:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753013004; bh=V8H2sOCpM7ipVF4MyaUQHDZH0lIhrU9NycxkG2AHxok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dFQwoIQb3TkNUDY7uJY1Q+Ptqa+MHevaOaZwFbVQEKK1pdgGnMMr0sTK6/wZb8BZI
	 OWfDyMxoojzTT9PxqOO1pYdvUMmBihsKmRtEi+NDV69SID6JozQDEyC3VZlmrml49D
	 /QV5FU7ArhDi/yLJpAKv2ie7P7vJe7mNf/PahLavGHkdXSIIA4EjRjCUYiFFWLcdSP
	 5Y0YmYL469eFnvaD1xo2n9zi25deZ1wieqlxNLNILA3jPThReQ4teo2W0yvQrOdBSp
	 CXCHF3CFWBFnDoKCyRwusEkqKuC3ppX0oNWgzs3crBm3IVAyTh9WRzI54umeuRFPv+
	 hGtD09qOf2piw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sun, 20 Jul 2025 17:33:07 +0530
Subject: [PATCH v4 1/2] dt-bindings: display: panel: document Samsung
 AMS561RA01 panel with S6E8AA5X01 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-panel-samsung-s6e8aa5x01-v4-1-7d9258fa3f4a@disroot.org>
References: <20250720-panel-samsung-s6e8aa5x01-v4-0-7d9258fa3f4a@disroot.org>
In-Reply-To: <20250720-panel-samsung-s6e8aa5x01-v4-0-7d9258fa3f4a@disroot.org>
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
 Conor Dooley <conor.dooley@microchip.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753012994; l=2042;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=V8H2sOCpM7ipVF4MyaUQHDZH0lIhrU9NycxkG2AHxok=;
 b=uUpYj+pLrPcs6HR5RAAy/1TInqeC2D5MsVYBtUKzElWZLSajzOFfonzDub+X7PZb1zQxj/Nou
 +PlTXZCiGTAARVlkPEQZ5HbAbK70ScwW//iwMh1+Y/IJbRWduyK6FOd
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Samsung AMS561RA01 is an AMOLED panel, using the Samsung S6E8AA5X01 MIPI
DSI panel controller. Document the compatible and devicetree properties
of this hardware. It has a reset GPIO and two voltage regulators.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../panel/samsung,s6e8aa5x01-ams561ra01.yaml       | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..479621b078976a47ecbc7305a7d5fc5eb600f0ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung AMS561RA01 panel with S6E8AA5X01 controller
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6e8aa5x01-ams561ra01
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: core voltage supply
+
+  vci-supply:
+    description: voltage supply for analog circuits
+
+  reset-gpios: true
+
+required:
+  - compatible
+  - reg
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
+            compatible = "samsung,s6e8aa5x01";
+            reg = <0>;
+
+            vdd-supply = <&panel_vdd_reg>;
+            vci-supply = <&panel_vci_reg>;
+
+            reset-gpios = <&gpd3 4 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
+...

-- 
2.50.0


