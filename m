Return-Path: <linux-kernel+bounces-798851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C39B423E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8478B5684A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67841211A35;
	Wed,  3 Sep 2025 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lontium.com header.i=@lontium.com header.b="VTCPQ7Ok"
Received: from out198-2.us.a.mail.aliyun.com (out198-2.us.a.mail.aliyun.com [47.90.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A7D213E7A;
	Wed,  3 Sep 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910426; cv=none; b=c8JU9xiJpSOthTmtK3c+fbfjI4BNVfK4wxTd4upYTC74Yyvkm7A1giq9+oC5xl4uAc49z+eiEqyMnfde09V4rvWp607yXBE47jUTx4WYf0l5IMm4Une3DrBYPyJusbCzBvKGUaWvxwRyD7NiPjOx7GbSN9J4TxHggU9QO5ZnVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910426; c=relaxed/simple;
	bh=tk2pZSv2aZyRVulNklw6EeKhD8m4cGiWut91yoi5sQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NxpYAJ2l+MS3Ohz/CPkIe/6YkPBWmacIRy692FnGVnw1CTgsiaXmhTlvl17SI9cWvfVrMC66ixDWChq4vADS7hGcJSsb/5BBUOJoWsyAXhVv987jJpoSxveCFfklx7IMCIschNccLynMBZ6Y8Bslk9V3kS+J1wvbWT1iYwUJnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lontium.com; spf=pass smtp.mailfrom=lontium.com; dkim=pass (2048-bit key) header.d=lontium.com header.i=@lontium.com header.b=VTCPQ7Ok; arc=none smtp.client-ip=47.90.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lontium.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lontium.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lontium.com; s=default;
	t=1756910410; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/E5SrmsOd5Nl6csTcBofnkAyJO039YSJ5yvT+R3J/xk=;
	b=VTCPQ7OkJitrkKiAjex+N2vUAUBb90dQ7sFNFyToG5uXJw7EqzJ8Z4es2C4MIrkunhL6leIxEB9VunbgQZq5izSgN36iRhehxGTg0Z/75SnHnZHpqoGzZ5Flp2q9sBtsk/u/NcDYqNJ3PH3JBVp692nAUn7dnsmibUhj3FNrvBnRbPWsgPAmLg9k4ySi8gizGsCoJiP1ig7HY2NcdbC4EEkxdTLUPs+FIuDRHSNoxPOwWfO3QxhxpIqsT/l33CuFSqlnNYhfFks8JrDKWo5H2K5aETV9kGYx0U/PbyE9XJdq1fZ3/ZQjdYEDPGZZf0hpJcDW1hsO2Ues4H1jnLxjZw==
Received: from ubuntu.localdomain(mailfrom:syyang@lontium.com fp:SMTPD_---.eWhncZr_1756903113 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 03 Sep 2025 20:38:36 +0800
From: syyang <syyang@lontium.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	yangsunyun1993@gmail.com,
	syyang <syyang@lontium.com>
Subject: [PATCH v1 1/2] This patch adds a new device tree binding documentation.
Date: Wed,  3 Sep 2025 05:38:24 -0700
Message-Id: <20250903123825.1721443-2-syyang@lontium.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250903123825.1721443-1-syyang@lontium.com>
References: <20250903123825.1721443-1-syyang@lontium.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- New device tree binding documentation at
  Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml

Signed-off-by: syyang <syyang@lontium.com>
---
 .../display/bridge/lontium,lt9611c.yaml       | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml
new file mode 100644
index 000000000000..e8f204c71a95
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lontium LT9611C 2 Port MIPI to HDMI Bridge
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description: |
+  The LT9611C are bridge devices which convert DSI to HDMI
+
+properties:
+  compatible:
+    enum:
+      - lontium,lt9611c
+      - lontium,lt9611uxd
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to active high RESET pin.
+
+  vdd-supply:
+    description: Regulator for 1.2V MIPI phy power.
+
+  vcc-supply:
+    description: Regulator for 3.3V IO power.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Primary MIPI port-1 for MIPI input
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Additional MIPI port-2 for MIPI input, used in combination
+          with primary MIPI port-1 to drive higher resolution displays
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          HDMI port for HDMI output
+
+    required:
+      - port@0
+      - port@2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+  - vcc-supply
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c10 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      hdmi-bridge@41 {
+        compatible = "lontium,lt9611c";
+        reg = <0x41>;
+        #sound-dai-cells = <0>;
+        interrupts-extended = <&pio 128 GPIO_ACTIVE_HIGH>;
+        reset-gpios = <&pio 127 GPIO_ACTIVE_HIGH>;
+        vdd-supply = <&lt9611_1v2>;
+        vcc-supply = <&lt9611_3v3>;
+        dsi-lanes = <4>;
+        status = "okay";
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+            lt9611_a: endpoint {
+              remote-endpoint = <&dsi0_out>;
+            };
+          };
+
+          port@1 {
+            reg = <1>;
+            lt9611_b: endpoint {
+              remote-endpoint = <&dsi1_out>;
+            };
+          };
+
+          port@2 {
+            reg = <2>;
+            lt9611_out: endpoint {
+              remote-endpoint = <&hdmi_con>;
+            };
+          };
+        };
+      };
+    };
+
+...
+
-- 
2.25.1


