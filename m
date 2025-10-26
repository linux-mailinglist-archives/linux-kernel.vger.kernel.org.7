Return-Path: <linux-kernel+bounces-870375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFD0C0A8C9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60E60349263
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB6C247280;
	Sun, 26 Oct 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcF5CUHI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2DD35959;
	Sun, 26 Oct 2025 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761486730; cv=none; b=rpigeW0JpOyKQPr7PtATCrzxUxhP79THVqhUmdEOF/26vg4YLMO9mx21WXq9tgMYH3TpDr7ro6fwqn2pDWps36h1tAtIaorm6IQx8OKZSyNue9q/zzKlFkNOv4zu3QXPLyzSl5Wdv9LGpJOcA6mVlAZqunTvIbpiMxljZIKAcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761486730; c=relaxed/simple;
	bh=yZ3IEkl1n9erkdmjtZuGOoV1888UoPVwWdqzFE/L10w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=miyiGmS7lVYE8QN1fHykiGu5QNoEu/SGe4NrCJJ7+QMdoLY0FjN5cWfvlVgbQnViio0dF2u/1FXif9TI5/1lPb93ulqVrs6DQr+TWwOxOhROJBCDBotr16Scyfox6AuuS2ZhjDVIl/mglbOjxA7rEsfDSRyTRI03zL55gWV512U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcF5CUHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28FE1C4AF0B;
	Sun, 26 Oct 2025 13:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761486730;
	bh=yZ3IEkl1n9erkdmjtZuGOoV1888UoPVwWdqzFE/L10w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PcF5CUHIlRuj5af+DC4pIXve7YKgAmVusbzwao0bkS/pg4u5z7/rIRmGevg6xN+hI
	 TdZ7517YZilPK5SA6Zvy8peRuRtaNKP+bKb64zPldsBZl77e/z6ed+ECSsnRrdhcgv
	 oxpYgn4VmpVuWacEHdvwLtENBJgE5qH2j7W3WUo1zITBaPAW3AUrVU41WrIqKPx+24
	 snwY4q8VzWZ5AuZyqi4Xw47XuSsA1cEzuQnCkLTzzjzFzaxK6v3YOYifXQmkEZAPBa
	 xFcpc7FIP25+ecwkEWz4DRHtXNXj/NlODGllzykWLd/9nlZJV50KHLdksc+k3asBej
	 K6tHbYp9Qlr+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F21CCF9EB;
	Sun, 26 Oct 2025 13:52:10 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sun, 26 Oct 2025 13:52:02 +0000
Subject: [PATCH 2/3] dt-bindings: phy: Add Apple Type-C PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-b4-atcphy-v1-2-f81b1225f9c6@kernel.org>
References: <20251026-b4-atcphy-v1-0-f81b1225f9c6@kernel.org>
In-Reply-To: <20251026-b4-atcphy-v1-0-f81b1225f9c6@kernel.org>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8145; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=yZ3IEkl1n9erkdmjtZuGOoV1888UoPVwWdqzFE/L10w=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8Y/9RbXwBkz1HxrAvuSXX0OG3h8XKv33PdTaIyz5Nlnx
 hYRHxZ0lLIwiHEwyIopsmzfb2/65OEbwaWbLr2HmcPKBDKEgYtTACayeynDP0NnT9vXpVYLN12w
 T+s8dLhAS+1lSb5escj/9v9TllQvv87wh2PqzSef9KWvXWdds9uMu/x4UJeYfK+Nv0+nyHw/xu+
 vmQE=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Apple's Type-C PHY (ATCPHY) is a PHY for USB 2.0, USB 3.x,
USB4/Thunderbolt, and DisplayPort connectivity found in Apple Silicon
SoCs.

The PHY handles muxing between these different protocols and also provides
the reset controller for the attached dwc3 USB controller.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 .../devicetree/bindings/phy/apple,atcphy.yaml      | 222 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 223 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/apple,atcphy.yaml b/Documentation/devicetree/bindings/phy/apple,atcphy.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..0acac7e3ee67ef2f03ffe1e04b0ac0fb414af362
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/apple,atcphy.yaml
@@ -0,0 +1,222 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/apple,atcphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Type-C PHY (ATCPHY)
+
+maintainers:
+  - Sven Peter <sven@kernel.org>
+
+description: >
+  The Apple Type-C PHY (ATCPHY) is a combined PHY for USB 2.0, USB 3.x,
+  USB4/Thunderbolt, and DisplayPort connectivity via Type-C ports found in
+  Apple Silicon SoCs.
+
+  The PHY handles muxing between these different protocols and also provides the
+  reset controller for the attached DWC3 USB controller.
+
+  It is designed for USB4 operation and does not handle individual differential
+  pairs as distinct DisplayPort lanes. Any reference to lane in this binding
+  hence refers to two differential pairs (RX and TX) as used in USB terminology.
+
+  In order to correctly setup these lanes for the various modes calibration
+  values copied from Apple's firmware and converted to the format described
+  below by our bootloader m1n1 are required. Without these only USB2 operation
+  is possible.
+
+allOf:
+  - $ref: /schemas/usb/usb-switch.yaml#
+
+$defs:
+  apple,tunable:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: Register offset
+        - description: Mask to be applied to the register value
+        - description: Bits to be set after applying the mask
+    description: >
+      List of (register offset, mask, value) tuples copied from Apple's Device
+      Tree by our bootloader m1n1 and used to configure the PHY. These values
+      even vary for a single product/device and likely contain calibration
+      values determined by Apple at manufacturing time.
+      Unless otherwise noted these tunables are always applied to the core
+      register region.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - apple,t6000-atcphy
+              - apple,t6020-atcphy
+              - apple,t8112-atcphy
+          - const: apple,t8103-atcphy
+      - const: apple,t8103-atcphy
+
+  reg:
+    items:
+      - description: Common controls for all PHYs (USB2/3/4, DisplayPort, TBT)
+      - description: DisplayPort Alternate Mode PHY specific controls
+      - description: Type-C PHY AXI to Apple Fabric interconnect controls
+      - description: USB2 PHY specific controls
+      - description: USB3 PIPE interface controls
+
+  reg-names:
+    items:
+      - const: core
+      - const: lpdptx
+      - const: axi2af
+      - const: usb2phy
+      - const: pipehandler
+
+  "#phy-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 0
+
+  mode-switch: true
+  orientation-switch: true
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Outgoing connection to the SS port of the Type-C connector.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Incoming endpoint from the USB3 controller.
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Incoming endpoint from the DisplayPort controller.
+
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Incoming endpoint from the USB4/Thunderbolt controller.
+
+  apple,tunable-common-a:
+    $ref: "#/$defs/apple,tunable"
+    description: >
+      Common tunables required for all modes, applied before tunable-axi2af.
+
+  apple,tunable-axi2af:
+    $ref: "#/$defs/apple,tunable"
+    description: >
+      AXI to Apple Fabric tunables, required for all modes. Unlike all other
+      tunables these are applied to the axi2af region.
+
+  apple,tunable-common-b:
+    $ref: "#/$defs/apple,tunable"
+    description: >
+      Common tunables required for all modes, applied after tunable-axi2af.
+
+  apple,tunable-lane0-usb:
+    $ref: "#/$defs/apple,tunable"
+    description: USB3 tunables for lane 0.
+
+  apple,tunable-lane1-usb:
+    $ref: "#/$defs/apple,tunable"
+    description: USB3 tunables for lane 1.
+
+  apple,tunable-lane0-cio:
+    $ref: "#/$defs/apple,tunable"
+    description: USB4/Thunderbolt ("Converged IO") tunables for lane 0.
+
+  apple,tunable-lane1-cio:
+    $ref: "#/$defs/apple,tunable"
+    description: USB4/Thunderbolt ("Converged IO") tunables for lane 1.
+
+  apple,tunable-lane0-dp:
+    $ref: "#/$defs/apple,tunable"
+    description: >
+      DisplayPort tunables for lane 0.
+
+      Note that lane here refers to a USB RX and TX pair re-used for DisplayPort
+      and not to an individual DisplayPort differential lane.
+
+  apple,tunable-lane1-dp:
+    $ref: "#/$defs/apple,tunable"
+    description: >
+      DisplayPort tunables for lane 1.
+
+      Note that lane here refers to a USB RX and TX pair re-used for DisplayPort
+      and not to an individual DisplayPort differential lane.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#phy-cells"
+  - "#reset-cells"
+  - orientation-switch
+  - mode-switch
+  - power-domains
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@83000000 {
+      compatible = "apple,t8103-atcphy";
+      reg = <0x83000000 0x4c000>,
+            <0x83050000 0x8000>,
+            <0x80000000 0x4000>,
+            <0x82a90000 0x4000>,
+            <0x82a84000 0x4000>;
+      reg-names = "core", "lpdptx", "axi2af", "usb2phy",
+                  "pipehandler";
+
+      #phy-cells = <1>;
+      #reset-cells = <0>;
+
+      orientation-switch;
+      mode-switch;
+      power-domains = <&ps_atc0_usb>;
+
+      ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+
+          endpoint {
+            remote-endpoint = <&typec_connector_ss>;
+          };
+        };
+
+        port@1 {
+          reg = <1>;
+
+          endpoint {
+            remote-endpoint = <&dwc3_ss_out>;
+          };
+        };
+
+        port@2 {
+          reg = <2>;
+
+          endpoint {
+            remote-endpoint = <&dcp_dp_out>;
+          };
+        };
+
+        port@3 {
+          reg = <3>;
+
+          endpoint {
+            remote-endpoint = <&acio_tbt_out>;
+          };
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..83487fea4e654171190f6e934203d3f6a881dd34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2431,6 +2431,7 @@ F:	Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
 F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 F:	Documentation/devicetree/bindings/nvmem/apple,spmi-nvmem.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
+F:	Documentation/devicetree/bindings/phy/apple,atcphy.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
 F:	Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml

-- 
2.34.1



