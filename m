Return-Path: <linux-kernel+bounces-665436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A1BAC6937
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 14:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 333707AB5D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B78284B42;
	Wed, 28 May 2025 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wb5xDiwC"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBDF284B5F
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435198; cv=none; b=Q/olXKVHaqLNNsSf0oJgtW6BCEpzq/tlYKy1J/lQ8c43ZBGNlNsPntcq5giFLEito8SB9UsQL2pwq821/YOWEd5Bo02chgLlLguwG+Y9gAwedcGGCWriZE1I1ZcK4uujYvieAk8ZygVaO65lyqb3XOI1htxfKivnqihWOP8sM1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435198; c=relaxed/simple;
	bh=SQbr+ZinjEWEP4YLGM6+CWcQ0s+1BA4gVcYS1jdBRUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fnr9iCQU2xHLPaSBb/jKLbgsQhU9mJtYDK+S8wktrJqIUj3984KMsvL4K9oY6bMFyqHKWiN+uPkQh3WwV1pvgSrmYwh5wvAKbxZy+zVYIt4vxm229iqsqu5RjrmhBJajDAihzQLckZzFMFagTNc92JHDZT46/oI1dX6M8jSSU1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wb5xDiwC; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748435193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkM4H55ivmDMZXBGdEgOR+Sst6rYFvKFCBEs3GnQNXE=;
	b=wb5xDiwC62bN+TWO+VD10rsm8agyPMxJrbZ+17WnDQ2Zjqsa0GOLOILPefKyTJ/ihD3eM0
	laOtJKrv1bu2WY2j7nE8jdbllz6GmADzRg4zSVcwjBWZ/viP4aWi47FBW8sB4CBavmA/r6
	2luQDmChjHwUwA9DPkDm4RU/RW9O54Y=
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Jyri Sarha <jyri.sarha@iki.fi>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Simona Vetter <simona@ffwll.ch>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Devarsh Thakkar <devarsht@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Michael Walle <mwalle@kernel.org>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Devicetree List <devicetree@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>
Subject: [PATCH v9 2/4] dt-bindings: display: ti: Add schema for AM625 OLDI Transmitter
Date: Wed, 28 May 2025 17:55:42 +0530
Message-Id: <20250528122544.817829-3-aradhya.bhatia@linux.dev>
In-Reply-To: <20250528122544.817829-1-aradhya.bhatia@linux.dev>
References: <20250528122544.817829-1-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Aradhya Bhatia <a-bhatia1@ti.com>

The OLDI transmitters (TXes) do not have registers of their own, and are
dependent on the source video-ports (VPs) from the DSS to provide
configuration data. This hardware doesn't directly sit on the internal
bus of the SoC, but does so via the DSS. Hence, the OLDI TXes are
supposed to be child nodes under the DSS, and not independent devices.

Two of the OLDI TXes can function in tandem to output dual-link OLDI
output, or cloned single-link outputs. In these cases, one OLDI will be
the primary OLDI, and the other one, a companion. The following diagram
represents such a configuration.

+-----+-----+         +-------+
|     |     |         |       |
|     | VP1 +----+--->+ OLDI0 |  (Primary - may need companion)
|     |     |    |    |       |
| DSS +-----+    |    +-------+
|     |     |    |
|     | VP2 |    |    +-------+
|     |     |    |    |       |
+-----+-----+    +--->+ OLDI1 |  (Companion OLDI)
                      |       |
                      +-------+

The DSS in AM625 SoC has a configuration like the one above. The AM625
DSS VP1 (port@0) can connect and control 2 OLDI TXes, to use them in
dual-link or cloned single-link OLDI modes. It is only the VP1 that can
connect to either OLDI TXes for the AM625 DSS, and not the VP2.

Alternatively, on some future TI SoCs, along with the above
configuration, the OLDI TX can _also_ connect to separate video sources,
making them work entirely independent of each other. In this case,
neither of the OLDIs are "companion" or "secondary" OLDIs, and nor do
they require one. They both are independent and primary OLDIs. The
following diagram represents such a configuration.

+-----+-----+               +-------+
|     |     |               |       |
|     | VP1 +--+----------->+ OLDI0 |  (Primary - may need companion)
|     |     |  |            |       |
|     +-----+  |            +-------+
|     |     |  |
|     | VP2 |  |
|     |     |  |
| DSS +-----+  |   +---+    +-------+
|     |     |  +-->+ M |    |       |
|     | VP3 +----->+ U +--->+ OLDI1 |  (Companion or Primary)
|     |     |      | X |    |       |
|     +-----+      +---+    +-------+
|     |     |
|     | VP4 |
|     |     |
+-----+-----+

Note that depending on the mux configuration, the OLDIs can either be
working together in tandem - sourced by VP1, OR, they could be working
independently sourced by VP1 and VP3 respectively.
The idea is to support all the configurations with this OLDI TX schema.

The OLDI functionality is further supported by a system-control module,
which contains a few registers to control OLDI IO power and other
electrical characteristics of the IO lanes.

Add devicetree binding schema for the OLDI TXes to support various
configurations, and extend their support to the AM625 DSS.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
---
Changes Log:
V9:
  - Reword the "ti,companion-oldi" property description.
  - Fix the missing "ti,companion-oldi" property in the schema example.
  - v8 of this patch: https://lore.kernel.org/all/20250525151721.567042-3-aradhya.bhatia@linux.dev/

V8:
  - Drop the condition that made the "secondary-oldi" and "companion-oldi"
    properties mutually exclusive.
  - Add "ti,am62l-dss" compatible to the list of compatibles that cannot
    use the multiple endpoints or have "oldi-transmitters", on port@0.
  - Because of above, drop R-b tags from Tomi Valkeinen, and Rob Herring.
  - v7 of this patch: https://lore.kernel.org/all/20250329133943.110698-3-aradhya.bhatia@linux.dev/

---
 .../bindings/display/ti/ti,am625-oldi.yaml    |  79 +++++++++
 .../bindings/display/ti/ti,am65x-dss.yaml     | 157 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 237 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml b/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
new file mode 100644
index 000000000000..8203ec5e5bb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/ti/ti,am625-oldi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments AM625 OLDI Transmitter
+
+maintainers:
+  - Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
+  - Aradhya Bhatia <aradhya.bhatia@linux.dev>
+
+description:
+  The AM625 TI Keystone OpenLDI transmitter (OLDI TX) supports serialized RGB
+  pixel data transmission between host and flat panel display over LVDS (Low
+  Voltage Differential Sampling) interface. The OLDI TX consists of 7-to-1 data
+  serializers, and 4-data and 1-clock LVDS outputs. It supports the LVDS output
+  formats "jeida-18", "jeida-24" and "vesa-18", and can accept 24-bit RGB or
+  padded and un-padded 18-bit RGB bus formats as input.
+
+properties:
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: serial clock input for the OLDI transmitters
+
+  clock-names:
+    const: serial
+
+  ti,companion-oldi:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to companion OLDI transmitter. This property is required for both
+      the OLDI TXes if they are expected to work either in dual-lvds mode or in
+      clone mode. This property should point to the other OLDI TX's phandle.
+
+  ti,secondary-oldi:
+    type: boolean
+    description:
+      Boolean property to mark the OLDI transmitter as the secondary one, when the
+      OLDI hardware is expected to run as a companion HW, in cases of dual-lvds
+      mode or clone mode. The primary OLDI hardware is responsible for all the
+      hardware configuration.
+
+  ti,oldi-io-ctrl:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to syscon device node mapping OLDI IO_CTRL registers found in the
+      control MMR region. These registers are required to toggle the I/O lane
+      power, and control its electrical characteristics.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Parallel RGB input port
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: LVDS output port
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - reg
+  - clocks
+  - clock-names
+  - ti,oldi-io-ctrl
+  - ports
+
+additionalProperties: false
+
+...
diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index 9cebe237bd4e..361e9cae6896 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -100,6 +100,24 @@ properties:
           For AM62A7 DSS, the port is tied off inside the SoC.
           For AM62L DSS, the DSS DPI output port node from video port 1
           or DSI Tx controller node connected to video port 1.
+        properties:
+          endpoint@0:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description:
+              For AM625 DSS, VP Connection to OLDI0.
+              For AM65X DSS, OLDI output from the SoC.
+
+          endpoint@1:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description:
+              For AM625 DSS, VP Connection to OLDI1.
+
+        anyOf:
+          - required:
+              - endpoint
+          - required:
+              - endpoint@0
+              - endpoint@1
 
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
@@ -121,6 +139,25 @@ properties:
       Input memory (from main memory to dispc) bandwidth limit in
       bytes per second
 
+  oldi-transmitters:
+    description:
+      Child node under the DSS, to describe all the OLDI transmitters connected
+      to the DSS videoports.
+    type: object
+    additionalProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      '^oldi@[0-1]$':
+        $ref: ti,am625-oldi.yaml#
+        description: OLDI transmitters connected to the DSS VPs
+
 allOf:
   - if:
       properties:
@@ -129,6 +166,7 @@ allOf:
             const: ti,am62a7-dss
     then:
       properties:
+        oldi-transmitters: false
         ports:
           properties:
             port@0: false
@@ -143,6 +181,22 @@ allOf:
           properties:
             port@1: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,am62l-dss
+              - ti,am65x-dss
+    then:
+      properties:
+        oldi-transmitters: false
+        ports:
+          properties:
+            port@0:
+              properties:
+                endpoint@1: false
+
 required:
   - compatible
   - reg
@@ -190,3 +244,106 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        dss1: dss@30200000 {
+            compatible = "ti,am625-dss";
+            reg = <0x00 0x30200000 0x00 0x1000>, /* common */
+                  <0x00 0x30202000 0x00 0x1000>, /* vidl1 */
+                  <0x00 0x30206000 0x00 0x1000>, /* vid */
+                  <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
+                  <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
+                  <0x00 0x3020a000 0x00 0x1000>, /* vp1 */
+                  <0x00 0x3020b000 0x00 0x1000>, /* vp2 */
+                  <0x00 0x30201000 0x00 0x1000>; /* common1 */
+            reg-names = "common", "vidl1", "vid",
+                        "ovr1", "ovr2", "vp1", "vp2", "common1";
+            power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
+            clocks =        <&k3_clks 186 6>,
+                            <&vp1_clock>,
+                            <&k3_clks 186 2>;
+            clock-names = "fck", "vp1", "vp2";
+            interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+            oldi-transmitters {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                oldi0: oldi@0 {
+                    reg = <0>;
+                    clocks = <&k3_clks 186 0>;
+                    clock-names = "serial";
+                    ti,companion-oldi = <&oldi1>;
+                    ti,oldi-io-ctrl = <&dss_oldi_io_ctrl>;
+                    ports {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+                        port@0 {
+                            reg = <0>;
+                            oldi0_in: endpoint {
+                                remote-endpoint = <&dpi0_out0>;
+                            };
+                        };
+                        port@1 {
+                            reg = <1>;
+                            oldi0_out: endpoint {
+                                remote-endpoint = <&panel_in0>;
+                            };
+                        };
+                    };
+                };
+                oldi1: oldi@1 {
+                    reg = <1>;
+                    clocks = <&k3_clks 186 0>;
+                    clock-names = "serial";
+                    ti,secondary-oldi;
+                    ti,companion-oldi = <&oldi0>;
+                    ti,oldi-io-ctrl = <&dss_oldi_io_ctrl>;
+                    ports {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+                        port@0 {
+                            reg = <0>;
+                            oldi1_in: endpoint {
+                                remote-endpoint = <&dpi0_out1>;
+                            };
+                        };
+                        port@1 {
+                            reg = <1>;
+                            oldi1_out: endpoint {
+                                remote-endpoint = <&panel_in1>;
+                            };
+                        };
+                    };
+                };
+            };
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    reg = <0>;
+                    dpi0_out0: endpoint@0 {
+                        reg = <0>;
+                        remote-endpoint = <&oldi0_in>;
+                    };
+                    dpi0_out1: endpoint@1 {
+                        reg = <1>;
+                        remote-endpoint = <&oldi1_in>;
+                    };
+                };
+                port@1 {
+                    reg = <1>;
+                    dpi1_out: endpoint {
+                        remote-endpoint = <&hdmi_bridge>;
+                    };
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 88b17f23ed4f..1836434ef5fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8097,6 +8097,7 @@ M:	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
 F:	Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
 F:	Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
 F:	Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
-- 
2.34.1


