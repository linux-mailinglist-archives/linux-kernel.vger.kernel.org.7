Return-Path: <linux-kernel+bounces-826079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6532B8D787
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B127B189BA10
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA3823ABAF;
	Sun, 21 Sep 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="GYrqDiGw"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF61173;
	Sun, 21 Sep 2025 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758443784; cv=pass; b=iCyK2spYGlKXD+EQCMDBDBWrewXrNhoKA3l4Wc9AIAD9vi1aEukrwx7F5aSUB3czG/vbKTSLHjK1AgsIpLvb2848A0jQZVTPsVEaAbOYvCmAPbDcHDUsZRMzZ8QKQjEOwTKRgQD9qWgU+WMhiFaldyoA6VcDSSoRAt7LPrrM0+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758443784; c=relaxed/simple;
	bh=RqLC0OHabIK2Usoy8P7sOPRsURrsxd+yc0qi1R0srpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ih5HiLT2e+QyRv4qa3RjX55Yl4legwfJtypw5reFzGR2d8yWn97ZXfKn60MKZuRLwqsimcoVA4PfI5UVPywSDxqKoRRGAioQkkrnzScN8qQAlpTHF4gj/eY2efhuxCCOMzUKUCK6Jy+9F9FFpRfQ+gE2idxiDRpvoV7txh2pJRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=GYrqDiGw; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1758443737; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ADDWRgmqXZCDzYwZeoMknYPylFGLq46uTQl+FwNqHYQyQZNi5wYyZ6BcyVegw3O64orDZ+SCrvHFXXRXm3lxn89DA5ytp1GZ+MkhtQ6Bm800gpFGUS4NgqVqRyWa4ybTC5uasmDu3QmKZ4jeDiAfjbiWg/6iNFio4B1CYVGV8pk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758443737; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BzVuxTb2Ec94oHmJJK3j5PrFE2OXgoL9kzrNkPO5Lq4=; 
	b=I1wm7nFsukKdC+rFRfNxzcu09Bj1ShESyD3RpmouPvRGAez1huwG/UUWjYomtd51hgWuFDBgFq9Yo22/fnH0UmCGPZ649Oje5XlkahaDFcaJlFDvy6k6BoyzF1dlfLoh4eSDBnSyuIZYAFsh9jS77LVZnf/sW2D5262uBpT2HUI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758443737;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BzVuxTb2Ec94oHmJJK3j5PrFE2OXgoL9kzrNkPO5Lq4=;
	b=GYrqDiGw+IIN8iBsvyBbPrdKF25NVSGGBFtNd11Nz2HJXFscbq31w9FZpNOl6lid
	TaGlj/mGWT51S+pJhYy3jfOsuQ5PjxRihhCcAQBM7t6wFsGgUbiPVU15FKkmTqb5ILS
	y6vLPb3cUfp3Ofug9F+Q8lqt2HnLWkNh8N1kD3gWCMhb1CKARP1nXM0jEeGkkig+Htr
	oPKkKQB1mxWAX88CtoZWX7s8/oFuPqx6J9UeUii0aGpRkVztfxFsc2NfsEdQNMTmusc
	bry5PcBoT4VbbigpjCeokaxjXoaW8PKlMP1l8kcggFlOADfN6ld3tWfS8HovBzZINxr
	5COB8hm/Nw==
Received: by mx.zohomail.com with SMTPS id 1758443735773654.766181253001;
	Sun, 21 Sep 2025 01:35:35 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 2/8] dt-bindings: display: add verisilicon,dc
Date: Sun, 21 Sep 2025 16:34:40 +0800
Message-ID: <20250921083446.790374-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921083446.790374-1-uwu@icenowy.me>
References: <20250921083446.790374-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Verisilicon has a series of display controllers prefixed with DC and
with self-identification facility like their GC series GPUs.

Add a device tree binding for it.

Depends on the specific DC model, it can have either one or two display
outputs, and each display output could be set to DPI signal or "DP"
signal (which seems to be some plain parallel bus to HDMI controllers).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
Changes in v2:
- Fixed misspelt "versilicon" in title.
- Moved minItems in clock properties to be earlier than items.
- Re-aligned multi-line clocks and resets in example.

 .../bindings/display/verisilicon,dc.yaml      | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/verisilicon,dc.yaml

diff --git a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
new file mode 100644
index 0000000000000..07fedc4c7cc13
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/verisilicon,dc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Verisilicon DC-series display controllers
+
+maintainers:
+  - Icenowy Zheng <uwu@icenowy.me>
+
+properties:
+  $nodename:
+    pattern: "^display@[0-9a-f]+$"
+
+  compatible:
+    const: verisilicon,dc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 4
+    items:
+      - description: DC Core clock
+      - description: DMA AXI bus clock
+      - description: Configuration AHB bus clock
+      - description: Pixel clock of output 0
+      - description: Pixel clock of output 1
+
+  clock-names:
+    minItems: 4
+    items:
+      - const: core
+      - const: axi
+      - const: ahb
+      - const: pix0
+      - const: pix1
+
+  resets:
+    items:
+      - description: DC Core reset
+      - description: DMA AXI bus reset
+      - description: Configuration AHB bus reset
+
+  reset-names:
+    items:
+      - const: core
+      - const: axi
+      - const: ahb
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: The first output channel, endpoint 0 should be
+          used for DPI format output and endpoint 1 should be used
+          for DP format output.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: The second output channel if the DC variant
+          supports and used. Follow the same endpoint addressing
+          rule with the first port.
+
+    required:
+      - port@0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
+    #include <dt-bindings/reset/thead,th1520-reset.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      display@ffef600000 {
+        compatible = "verisilicon,dc";
+        reg = <0xff 0xef600000 0x0 0x100000>;
+        interrupts = <93 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk_vo CLK_DPU_CCLK>,
+                 <&clk_vo CLK_DPU_ACLK>,
+                 <&clk_vo CLK_DPU_HCLK>,
+                 <&clk_vo CLK_DPU_PIXELCLK0>,
+                 <&clk_vo CLK_DPU_PIXELCLK1>;
+        clock-names = "core", "axi", "ahb", "pix0", "pix1";
+        resets = <&rst TH1520_RESET_ID_DPU_CORE>,
+                 <&rst TH1520_RESET_ID_DPU_AXI>,
+                 <&rst TH1520_RESET_ID_DPU_AHB>;
+        reset-names = "core", "axi", "ahb";
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          port@0 {
+            reg = <0>;
+          };
+
+          port@1 {
+            reg = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            dpu_out_dp1: endpoint@1 {
+              reg = <1>;
+              remote-endpoint = <&hdmi_in>;
+            };
+          };
+        };
+      };
+    };
-- 
2.51.0


