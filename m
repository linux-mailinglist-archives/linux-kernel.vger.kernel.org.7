Return-Path: <linux-kernel+bounces-804342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BBEB47297
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E9A3BE40A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CCF302164;
	Sat,  6 Sep 2025 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNlgs0cg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D492F067F;
	Sat,  6 Sep 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173420; cv=none; b=LeahsBqpyUcVYMzbMBerJXfqdWJguMmJvJABtI41Ht0+b+81WQyhDsFXuHG32KbxpnDJ6gI1QMWYw/L+qZ1LcYiKIkU0C+WkezeraG/+0Xk+tRLHo36odLe3vUuGoLMqTwY7SIq0TquUu8gA8N1trpTpL3bJaOhM6Ug4HNGh1wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173420; c=relaxed/simple;
	bh=osM0eVhm5EoDlyY0FaSY3Lj8njN0B4a30sboZPHWvdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgtJTqIkAo06TpeC5bQH+SAXJl2yYzr4Skksc2IL3qSwkywv4dSKh0H7nzxbCRJ3WiJQmCAsOL9leVlmcc8D2GHNih+bKRQNmUgC+RMHpUdgmQlGV7LUf62v+58CtAkQEfimFNtbjyUkVMDyr0JOQ4xUho+KD3p1RI0LBCb3apA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNlgs0cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B8C8C4AF10;
	Sat,  6 Sep 2025 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173420;
	bh=osM0eVhm5EoDlyY0FaSY3Lj8njN0B4a30sboZPHWvdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uNlgs0cgIfXVTqUOgzBPJyDbsBhQ5DgX8JsXcG5fxshtzIkJbR6KTgFdguI4+YX7X
	 gldL7olsKsz+941SFtMWC/8G2NhbkmtS67EfPSMO+8Ay3nLOtsB0fQkGZAwP6/YQt/
	 /oq5oZ7ejnATZcX4g7iCIfjeuxWf5dUjZKB4f7ybLAD+QjKstelg5liiXoSpacdf+5
	 o23W9Xzj+s7PdXa8ARh8fAoIHiinMzdnmlRRzsYrg7/iPfrwmqA3Aq397BCjiFrJZk
	 14jZWORpn+ztYMYw2qsH1V5tXoPrYmUQZHQGwGGYySFW9axJd2ZJc7zkcX1tae433W
	 ilp1fS7jg125A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32424CA1012;
	Sat,  6 Sep 2025 15:43:40 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sat, 06 Sep 2025 15:43:29 +0000
Subject: [PATCH v2 16/22] dt-bindings: phy: Add Apple Type-C PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-atcphy-6-17-v2-16-52c348623ef6@kernel.org>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
In-Reply-To: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7993; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=osM0eVhm5EoDlyY0FaSY3Lj8njN0B4a30sboZPHWvdE=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8aesCX61T8PcMzoLs+VkV5dP5frQfnk3W+9O7tu5Rqym
 5w9XZ3aUcrCIMbBICumyLJ9v73pk4dvBJduuvQeZg4rE8gQBi5OAZjI5zUM//TaEk33/1SYHdl7
 1jrvbWsfS4JT/4SHRTpuK2xS/rf3/WZkmJB/WfqI+Pyz3y9GGxqEepqknuhviFXqWipx2fLxrhU
 lDAA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Apple's Type-C PHY (ATCPHY) is a PHY for USB 2.0, USB 3.x,
USB4/Thunderbolt, and DisplayPort connectivity found in Apple Silicon
SoCs.

The PHY handles muxing between these different protocols and also provides
the reset controller for the attached dwc3 USB controller.

Signed-off-by: Sven Peter <sven@kernel.org>
---
 .../devicetree/bindings/phy/apple,atcphy.yaml      | 213 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 214 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/apple,atcphy.yaml b/Documentation/devicetree/bindings/phy/apple,atcphy.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a863fe3a8f6d80a113e495e8425775c91e4cd10c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/apple,atcphy.yaml
@@ -0,0 +1,213 @@
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
+description:
+  The Apple Type-C PHY (ATCPHY) is a PHY for USB 2.0, USB 3.x,
+  USB4/Thunderbolt, and DisplayPort connectivity found in Apple Silicon SoCs.
+
+  The PHY handles muxing between these different protocols and also provides the
+  reset controller for the attached DWC3 USB controller.
+
+  The PHY is designed for USB4 operation and does not handle individual
+  differential pairs as distinct DisplayPort lanes. Any reference to lane in
+  this binding hence refers to two differential pairs (RX and TX) as used in USB
+  terminology.
+
+allOf:
+  - $ref: /schemas/usb/usb-switch.yaml#
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
+      - description: Common controls for all PHYs (USB2/3/4, DisplayPort, Thunderbolt)
+      - description: DisplayPort Alternate Mode PHY specific controls
+      - description: AXI to Apple Fabric interconnect controls, only modified by tunables
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
+        description: Output endpoint of the PHY to the Type-C connector
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Incoming endpoint from the USB3 controller
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Incoming endpoint from the DisplayPort controller
+
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Incoming endpoint from the USB4/Thunderbolt controller
+
+  apple,tunable-axi2af:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      AXI2AF tunables.
+
+      This array is filled with 3-tuples each containing three 32-bit values
+      <register offset>, <mask>, and <value> by the bootloader.
+      The driver will use these to configure the PHY by reading from each
+      register, ANDing it with <mask>, ORing it with <value>, and storing the
+      result back to the register.
+      These values slightly differ even between different chips of the same
+      generation and are likely calibration values determined by Apple at
+      manufacturing time.
+
+  apple,tunable-common:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Common tunables required for all modes, see apple,tunable-axi2af for details.
+
+  apple,tunable-fuses:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Fuse based tunables required for all modes, see apple,tunable-axi2af for details.
+
+  apple,tunable-lane0-usb:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      USB tunables on lane 0, see apple,tunable-axi2af for details.
+
+  apple,tunable-lane1-usb:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      USB tunables on lane 1, see apple,tunable-axi2af for details.
+
+  apple,tunable-lane0-cio:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      USB4/Thunderbolt ("converged IO") tunables on lane 0, see apple,tunable-axi2af for details.
+
+  apple,tunable-lane1-cio:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      USB4/Thunderbolt ("converged IO") tunables on lane 1, see apple,tunable-axi2af for details.
+
+  apple,tunable-lane0-dp:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      DisplayPort tunables on lane 0, see apple,tunable-axi2af for details.
+
+      Note that lane here refers to a USB RX and TX pair re-used for DisplayPort
+      and not to an individual DisplayPort differential lane.
+
+  apple,tunable-lane1-dp:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      DisplayPort tunables on lane 1, see apple,tunable-axi2af for details.
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
index e147e1b919d5737a34e684ec587872ce591c641a..c4cbae63b0c0d42042e12d366e4a32d7ca3711ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2393,6 +2393,7 @@ F:	Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
 F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 F:	Documentation/devicetree/bindings/nvmem/apple,spmi-nvmem.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
+F:	Documentation/devicetree/bindings/phy/apple,atcphy.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
 F:	Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml

-- 
2.34.1



