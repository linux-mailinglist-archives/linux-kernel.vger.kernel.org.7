Return-Path: <linux-kernel+bounces-780204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA5B2FEF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F971C807E6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8F62F5311;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8SMCgr3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96428278E63;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790803; cv=none; b=I4Kab+DTle7trxUXJkJBMJNEUPZCE27gRcOB27FOzBsJDe0Mmn+QZZs5qaIhA/YchLEmZRk5mVdxIvjP3AFWUfJenRKz4AxaxSZ4ahXctvb7BPFLiPn7WKE/fu9I9IKMDDiTQC7UYu7/yHVwWEbHGDV3sMU3mfCOTUJaIwGOUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790803; c=relaxed/simple;
	bh=ZBquEoju0Ehd8uVDnoJAdyF7CKQqE2ec9LJ2isJ/Imo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AgYVBvbocx+kWWO55SiIYO5eWS6nJO+HaYTlwY6Lw2WHkcgyDtEBbeqGVrHrHR5rX/m2lq46JdFMCni0xOxeozFXPQYJuoUtE/h8lJBzgM6Ju5fiVXqtxfe3etL35/pDXfZNwzx3Ivyy4ULyuZyr9XsHIfpcIMK3LojJc6ZiqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8SMCgr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2793AC19421;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790803;
	bh=ZBquEoju0Ehd8uVDnoJAdyF7CKQqE2ec9LJ2isJ/Imo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U8SMCgr3syM411Yn6WJ7OC4buYDhASv9lMOVJzcfmTS00Ij2CJAJ+ZH9I/YVH5VyQ
	 CnEBDYAA6Vhr2bXeMz/jRX5B7EQ0Nt3n/dFcS9745BrRdGSgqL27XIQMcfC/j/UlLQ
	 PVb6F7D/kQHGbNk52Mu9UIgmeYH0ZvUzGycA5yqwm/OC3HjE/gfEzl7+kPuMoYAJ/l
	 eZUAF2FCneetm3NXQP+jsxlvIZrrFQyjeevw5dEuTAU8lLAOgUMJZuoAQIetAVKtPh
	 tIY9FPr8mmCj65/9MOQjJBhLbDHb5/+VZu5BbtYIZ7gHTWanEu++nzMSyb79IkTCNJ
	 JjXGSIXmP46nA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCD9CA0FE1;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 21 Aug 2025 15:38:55 +0000
Subject: [PATCH RFC 03/22] dt-bindings: phy: Add Apple Type-C PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-atcphy-6-17-v1-3-172beda182b8@kernel.org>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
In-Reply-To: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7858; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=ZBquEoju0Ehd8uVDnoJAdyF7CKQqE2ec9LJ2isJ/Imo=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8Zy20X6NQ1LN35NFuTu+Hlz8SvjC1Uvmf8Urvr52lP91
 KOvytv4O0pZGMQ4GGTFFFm277c3ffLwjeDSTZfew8xhZQIZwsDFKQATKa5jZJjOvEmyWz2/xezy
 ooDavK/H3+9eUyTU9rdv42t90Xu6iZ8YGRY8uDNv7651G05EGjm4yqz6abI+ZbmVd1Z0VtWFI7+
 vSXMBAA==
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
 .../devicetree/bindings/phy/apple,atcphy.yaml      | 210 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 211 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/apple,atcphy.yaml b/Documentation/devicetree/bindings/phy/apple,atcphy.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..eb14010557c94f313b54b528e2d4039fe540062a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/apple,atcphy.yaml
@@ -0,0 +1,210 @@
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
+  reset controller for the attached dwc3 USB controller.
+
+  The PHY is designed for USB4 operation and does not handle individual
+  differential pairs as distinct DisplayPort lanes. Any reference to lane in
+  this binding hence refers to two differential pairs (RX and TX) as used in USB
+  terminology.
+
+properties:
+  compatible:
+    enum:
+      - apple,t6000-atcphy
+      - apple,t6000-atcphy-dp-only # PHY hardwired to DP-to-HDMI converter on M2 Pro MacBook
+      - apple,t6020-atcphy
+      - apple,t8103-atcphy
+      - apple,t8112-atcphy
+
+  reg:
+    minItems: 5
+    maxItems: 5
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
+  orientation-switch:
+    type: boolean
+    description:
+      The PHY handles swapping lanes if the Type-C connector is flipped.
+
+  mode-switch:
+    type: boolean
+    description:
+      The PHY handles muxing between USB 2.0, USB 3.x, USB4/Thunderbolt, and DisplayPort.
+
+  power-domains:
+    minItems: 1
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
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@383000000 {
+      compatible = "apple,t8103-atcphy";
+      reg = <0x3 0x83000000 0x0 0x4c000>,
+            <0x3 0x83050000 0x0 0x8000>,
+            <0x3 0x80000000 0x0 0x4000>,
+            <0x3 0x82a90000 0x0 0x4000>,
+            <0x3 0x82a84000 0x0 0x4000>;
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
index 0e085cb0762f765958d67be61ae0d3d773503431..11a9b084a2e51d7b9b2e4c1777a2439df4a6858b 100644
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



