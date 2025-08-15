Return-Path: <linux-kernel+bounces-770400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C90CBB27A54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05A717157D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1895923AB96;
	Fri, 15 Aug 2025 07:46:36 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A145948;
	Fri, 15 Aug 2025 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243995; cv=none; b=MggCmMeMtorjwXldYTFbF/2+wcv7tM4pz+xanfrs/mtVuWNaig6vvXinfq5zejyXI45Q11kTqFzQvXwU/rbrotxBoZUaRyCHcsasy+DzObTKXYLA3uJVq/JW3yLlf5pAP64/rVmvMbMltbdkCsU+9CA01Y8DQAn8o2fuT9mOaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243995; c=relaxed/simple;
	bh=tI/6+DEAQfH+v5NbvHBDZ16LwXixN0FnGsYGQtwhoeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BArFnhYPEtHS+IieMRl/a3PpaXrndpemwiVEW4xkBTUcUb043nxIZChHLgF0NcaLYvvUJc1R9N+pCBf/W5+naiaJ+pUvThTfXhf6HEGOCXegvT92OrHvSslbRp8lswBbXChoaO76+QPhH4slBIhvxd9qDnPB20hcQsxUMTOB92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 4A205B4E0036;
	Fri, 15 Aug 2025 09:40:04 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	E Shattow <e@freeshell.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v2 1/3] dt-bindings: memory-controllers: add StarFive JH7110 SoC DMC
Date: Fri, 15 Aug 2025 00:37:21 -0700
Message-ID: <20250815073739.79241-2-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250815073739.79241-1-e@freeshell.de>
References: <20250815073739.79241-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe JH7110 SoC DDR external memory interface.

Signed-off-by: E Shattow <e@freeshell.de>
---
 .../starfive,jh7110-dmc.yaml                  | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/starfive,jh7110-dmc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/starfive,jh7110-dmc.yaml b/Documentation/devicetree/bindings/memory-controllers/starfive,jh7110-dmc.yaml
new file mode 100644
index 000000000000..be31d76f01ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/starfive,jh7110-dmc.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/starfive,jh7110-dmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 DMC
+
+maintainers:
+  - E Shattow <e@freeshell.de>
+
+description:
+  JH7110 DDR external memory interface LPDDR4/DDR4/DDR3/LPDDR3 32-bit at 2133Mbps (up to 2800Mbps).
+
+properties:
+  compatible:
+    items:
+      - const: starfive,jh7110-dmc
+
+  reg:
+    items:
+      - description: controller registers
+      - description: phy registers
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pll1_out
+
+  resets:
+    items:
+      - description: axi
+      - description: osc
+      - description: apb
+
+  reset-names:
+    items:
+      - const: axi
+      - const: osc
+      - const: apb
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh7110-crg.h>
+    #include <dt-bindings/reset/starfive,jh7110-crg.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      memory-controller@15700000 {
+        compatible = "starfive,jh7110-dmc";
+        reg = <0x0 0x15700000 0x0 0x10000>,
+              <0x0 0x13000000 0x0 0x10000>;
+        clocks = <&syscrg JH7110_PLLCLK_PLL1_OUT>;
+        clock-names = "pll1_out";
+        resets = <&syscrg JH7110_SYSRST_DDR_AXI>,
+                 <&syscrg JH7110_SYSRST_DDR_OSC>,
+                 <&syscrg JH7110_SYSRST_DDR_APB>;
+        reset-names = "axi", "osc", "apb";
+      };
+    };
-- 
2.50.0


