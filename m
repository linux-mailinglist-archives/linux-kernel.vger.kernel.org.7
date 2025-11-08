Return-Path: <linux-kernel+bounces-891229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEDEC4231D
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 02:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B5EE4FA608
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 01:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE542D8399;
	Sat,  8 Nov 2025 01:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MAhVfJnc"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D782C0270;
	Sat,  8 Nov 2025 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762563909; cv=none; b=LX/3NJ5BWp033Mv3p8mjQptKBkwUF7Q3LE1whisXtOQWKWTHA+hGlOTEltzWrSxQaZg1rwOnZ+3VMmKei12BOj+VA5r4XnOCSl+koB0M4H8FSwuC7FOqbQzsA871qKdGPo0wgdLJvsCxfLXZj66yYQvz6DPm4UDzdFTX7ueallQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762563909; c=relaxed/simple;
	bh=IL50dWIWoULIVTXkUbrvxTBHbeoqJTdavhAf46m5m6o=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=aUd7MLOjBPlCvxdsCvzsOOSXn+WoKnz/IEbcFvf+NVAyawpumvpDpSYDySDfy1GVdQ7WXeegvIke6ztUxg0s8a6ul0UqxJa8MuoQNCIyITqqhadlzfM2XqYWeJkhS/gRZ8R5FECXmQVZbjTWmtP761oAs3sp6xVLWguLwQP5fWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MAhVfJnc; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251108010458euoutp022d59f4ee6aaf2e13e7f8ea5cb44de0f7~14ocFRP-X2548125481euoutp02H;
	Sat,  8 Nov 2025 01:04:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251108010458euoutp022d59f4ee6aaf2e13e7f8ea5cb44de0f7~14ocFRP-X2548125481euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1762563898;
	bh=/QbRhzoSqc6Kv0+UPWm7UMN69qTYmm3jyyY2q/N346k=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=MAhVfJncS1bxNlKGupldY7Yv+UKmxfhuEPAsklUTiUSqQUz/ZnngVoQpD4KruLKmc
	 cqLcnTRPe6HkFybdVakXTe3vwY6i9KtCQyQ6PgYLZGSLr3Ns9oR1KGfJCYuxoexXcq
	 dI1+YiVoVfOhsQTzk/rSedMQF7t0P9AWHU7PSpjg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251108010458eucas1p11d128a6dd0aab3171db7c001e69ecfc8~14obcWBjA2620826208eucas1p1A;
	Sat,  8 Nov 2025 01:04:58 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251108010456eusmtip2b27901863ee07c5126f2c8becf11da34~14oaCLnXI0912409124eusmtip2S;
	Sat,  8 Nov 2025 01:04:56 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Sat, 08 Nov 2025 02:04:38 +0100
Subject: [PATCH RFC 04/13] dt-bindings: display: bridge: Add
 starfive,jh7110-hdmi-controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-jh7110-clean-send-v1-4-06bf43bb76b1@samsung.com>
In-Reply-To: <20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>,  Conor Dooley
	<conor@kernel.org>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
	<hal.feng@starfivetech.com>,  Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Xingyu
	Wu <xingyu.wu@starfivetech.com>, Vinod Koul <vkoul@kernel.org>,  Kishon
	Vijay Abraham I <kishon@kernel.org>,  Andrzej Hajda
	<andrzej.hajda@intel.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,  Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,  Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,  Lee Jones <lee@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Marek Szyprowski
	<m.szyprowski@samsung.com>, Icenowy Zheng <uwu@icenowy.me>,  Maud Spierings
	<maudspierings@gocontroll.com>, Andy Yan <andyshrk@163.com>,  Heiko Stuebner
	<heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20251108010458eucas1p11d128a6dd0aab3171db7c001e69ecfc8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251108010458eucas1p11d128a6dd0aab3171db7c001e69ecfc8
X-EPHeader: CA
X-CMS-RootMailID: 20251108010458eucas1p11d128a6dd0aab3171db7c001e69ecfc8
References: <20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com>
	<CGME20251108010458eucas1p11d128a6dd0aab3171db7c001e69ecfc8@eucas1p1.samsung.com>

Add the dt-binding for the StarFive JH7110 Innosilicon HDMI controller
(DRM bridge).

This device is the second child of the starfive,jh7110-hdmi-mfd node. It
consumes register access clocks (sys, mclk, bclk) from the voutcrg and
both the pixel clock (pclk) and the PHY from its hdmi_phy sibling.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../starfive,jh7110-inno-hdmi-controller.yaml      | 123 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 124 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml b/Documentation/devicetree/bindings/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..3707c9dbff9c9fdc0ed7db4720a6dd8eabeeb774
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 Innosilicon HDMI Controller
+
+maintainers:
+  - Michal Wilczynski <m.wilczynski@samsung.com>
+
+description:
+  The controller portion of the StarFive JH7110 INNO HDMI IP.
+
+properties:
+  compatible:
+    const: starfive,jh7110-inno-hdmi-controller
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: System clock for register access
+      - description: Module clock
+      - description: Bus clock
+      - description: Pixel clock from PHY
+
+  clock-names:
+    items:
+      - const: sys
+      - const: mclk
+      - const: bclk
+      - const: pclk
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: hdmi_tx
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: hdmi-phy
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description:
+      A graph node with one input port and one output port.
+
+required:
+  - compatible
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - phys
+  - phy-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh7110-crg.h>
+    #include <dt-bindings/reset/starfive,jh7110-crg.h>
+
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        hdmi_mfd: hdmi@29590000 {
+            compatible = "starfive,jh7110-hdmi-mfd";
+            reg = <0x29590000 0x4000>;
+
+            hdmi_phy: phy {
+                compatible = "starfive,jh7110-inno-hdmi-phy";
+                clocks = <&xin24m>;
+                clock-names = "refoclk";
+                #clock-cells = <0>;
+                clock-output-names = "hdmi_pclk";
+                #phy-cells = <0>;
+            };
+
+            hdmi_controller: controller {
+                compatible = "starfive,jh7110-inno-hdmi-controller";
+                interrupts = <99>;
+                clocks = <&voutcrg JH7110_VOUTCLK_HDMI_TX_SYS>,
+                         <&voutcrg JH7110_VOUTCLK_HDMI_TX_MCLK>,
+                         <&voutcrg JH7110_VOUTCLK_HDMI_TX_BCLK>,
+                         <&hdmi_phy>;
+                clock-names = "sys", "mclk", "bclk", "pclk";
+                resets = <&voutcrg JH7110_VOUTRST_HDMI_TX_HDMI>;
+                reset-names = "hdmi_tx";
+                phys = <&hdmi_phy>;
+                phy-names = "hdmi-phy";
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+                        hdmi_in: endpoint {
+                            remote-endpoint = <&dpu_out_dpi0>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+                        hdmi_out: endpoint {
+                            remote-endpoint = <&hdmi_con_in>;
+                        };
+                    };
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a75ba7a44ee84db6a75b91c1a0867a37db2ebcdb..66fab45bbee8c1a5f73d09bb470d28029b8c6139 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24047,6 +24047,7 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
 STARFIVE JH7110 DISPLAY SUBSYSTEM
 M:	Michal Wilczynski <m.wilczynski@samsung.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml
 F:	Documentation/devicetree/bindings/phy/starfive,jh7110-inno-hdmi-phy.yaml
 F:	Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-vout-subsystem.yaml
 

-- 
2.34.1


