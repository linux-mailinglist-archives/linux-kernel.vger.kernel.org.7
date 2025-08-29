Return-Path: <linux-kernel+bounces-792551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7584CB3C579
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377885A4323
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7274435AAA7;
	Fri, 29 Aug 2025 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n40IqzHf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B676635A2B3;
	Fri, 29 Aug 2025 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756508687; cv=none; b=KPg+xXqmyX3AArzpq8XZ1mctFhW/Vj2ExSgW3ojnSwNfXqxqunqd79eWPNVL9OUCdhFMvpeGMGTgSJe0P9MJywPUYOjTm7SM6Opw9bvAfwES4EdM1p/xyDjdTbdk/fYPOmY+mywtngIIi+Bi/vDHuKJsRCexRP3y3hBIk3etiVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756508687; c=relaxed/simple;
	bh=lVy0nGCp4W9LsUGnCrLcZC8nGhc9aZD0sfWzO1ugqb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOCw+GVbpKbfOwllbDbrVIf4MqjVz8ugZG83PNBrlDQJXoS4J5YDgxO3U48mJmEb+Q3R+pzaqZ55nEgjXqGvhwBKyiDRsEnvI6K7M261kRuO1UuI4NwSiRFoXpefe40C+tixTdKpCS1bcZkoG+3syMRxwEUOESdh5EhabCTBd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n40IqzHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12622C4CEF0;
	Fri, 29 Aug 2025 23:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756508687;
	bh=lVy0nGCp4W9LsUGnCrLcZC8nGhc9aZD0sfWzO1ugqb0=;
	h=From:To:Cc:Subject:Date:From;
	b=n40IqzHf8NlGH+zlDQkwIjiMqxccwyPOgUi2Gb97TUhyJ0HxLOqJBAgDX/+Ruqrn2
	 VGsGBVNI6hYorMB0LNfKslKl/xi6j1aEkFz5hRGbFm1MrZiPpLVNItHg7mVbW0Uuom
	 yLXEkP8LY3BW/7XulqzHf4v6FbZy0xC4EHYRm0roxM3lCLz2QweX9EQVMczT6uTnXg
	 IXL0w2yvzWfotuDdrbCoAYa3kw44y185fDNL3IbiY6+EDuqEwNL3xyOuZ9D+IXFzVQ
	 wjvPjr8hfrAFVbxIiPjqDb13MgyUy2G318dovaYNXLWqU/hs5XByEtw7hU89n2o3/w
	 V0EV0ZL8fXwhg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Joel Stanley <joel@jms.id.au>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>
Cc: linux-aspeed@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: gpu: Convert aspeed,ast2400-gfx to DT schema
Date: Fri, 29 Aug 2025 18:04:40 -0500
Message-ID: <20250829230442.1495926-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the ASpeed GFX Display Controller binding to DT schema format.
There was a duplicate, incomplete binding in mfd which can be dropped.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/gpu/aspeed,ast2400-gfx.yaml      | 58 +++++++++++++++++++
 .../devicetree/bindings/gpu/aspeed-gfx.txt    | 41 -------------
 .../devicetree/bindings/mfd/aspeed-gfx.txt    | 17 ------
 MAINTAINERS                                   |  2 +-
 4 files changed, 59 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/aspeed,ast2400-gfx.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-gfx.txt

diff --git a/Documentation/devicetree/bindings/gpu/aspeed,ast2400-gfx.yaml b/Documentation/devicetree/bindings/gpu/aspeed,ast2400-gfx.yaml
new file mode 100644
index 000000000000..77ec5ad10ac6
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/aspeed,ast2400-gfx.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/aspeed,ast2400-gfx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED GFX Display Controller
+
+maintainers:
+  - Joel Stanley <joel@jms.id.au>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2500-gfx
+          - aspeed,ast2400-gfx
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  memory-region:
+    maxItems: 1
+    description:
+      a reserved-memory region to use for the framebuffer.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+
+    display@1e6e6000 {
+        compatible = "aspeed,ast2500-gfx", "syscon";
+        reg = <0x1e6e6000 0x1000>;
+        clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
+        resets = <&syscon ASPEED_RESET_CRT1>;
+        interrupts = <0x19>;
+        memory-region = <&gfx_memory>;
+    };
diff --git a/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt b/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
deleted file mode 100644
index 958bdf962339..000000000000
--- a/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Device tree configuration for the GFX display device on the ASPEED SoCs
-
-Required properties:
-  - compatible
-    * Must be one of the following:
-      + aspeed,ast2500-gfx
-      + aspeed,ast2400-gfx
-    * In addition, the ASPEED pinctrl bindings require the 'syscon' property to
-      be present
-
-  - reg: Physical base address and length of the GFX registers
-
-  - interrupts: interrupt number for the GFX device
-
-  - clocks: clock number used to generate the pixel clock
-
-  - resets: reset line that must be released to use the GFX device
-
-  - memory-region:
-    Phandle to a memory region to allocate from, as defined in
-    Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
-
-
-Example:
-
-gfx: display@1e6e6000 {
-	compatible = "aspeed,ast2500-gfx", "syscon";
-	reg = <0x1e6e6000 0x1000>;
-	reg-io-width = <4>;
-	clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
-	resets = <&syscon ASPEED_RESET_CRT1>;
-	interrupts = <0x19>;
-	memory-region = <&gfx_memory>;
-};
-
-gfx_memory: framebuffer {
-	size = <0x01000000>;
-	alignment = <0x01000000>;
-	compatible = "shared-dma-pool";
-	reusable;
-};
diff --git a/Documentation/devicetree/bindings/mfd/aspeed-gfx.txt b/Documentation/devicetree/bindings/mfd/aspeed-gfx.txt
deleted file mode 100644
index aea5370efd97..000000000000
--- a/Documentation/devicetree/bindings/mfd/aspeed-gfx.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* Device tree bindings for Aspeed SoC Display Controller (GFX)
-
-The Aspeed SoC Display Controller primarily does as its name suggests, but also
-participates in pinmux requests on the g5 SoCs. It is therefore considered a
-syscon device.
-
-Required properties:
-- compatible:		"aspeed,ast2500-gfx", "syscon"
-- reg:			contains offset/length value of the GFX memory
-			region.
-
-Example:
-
-gfx: display@1e6e6000 {
-	compatible = "aspeed,ast2500-gfx", "syscon";
-	reg = <0x1e6e6000 0x1000>;
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index 11a58d3279ec..536a0403edda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7592,7 +7592,7 @@ M:	Joel Stanley <joel@jms.id.au>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-F:	Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
+F:	Documentation/devicetree/bindings/gpu/aspeed,ast2400-gfx.yaml
 F:	drivers/gpu/drm/aspeed/
 
 DRM DRIVER FOR AST SERVER GRAPHICS CHIPS
-- 
2.50.1


