Return-Path: <linux-kernel+bounces-769309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11630B26CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C0E173B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939012FCBE4;
	Thu, 14 Aug 2025 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="jmCeCKxc"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405442F39B2;
	Thu, 14 Aug 2025 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189745; cv=pass; b=X9OLq+TJCj595XCKKqbcqX77yceM17DHiUKIVBpJouvX6mt5EvNuYvtxFoujdv4KrMKDeonxep/B4PH+3Pbd4OSxmBK7F75Nw6SUaqXnnqNssqGTtZkXXN+LxAuwgEsxc9sPT67vGoQl04ip0AMV45/mFk2xK71Xe4FQJ+WcXPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189745; c=relaxed/simple;
	bh=Yhg7bufrEVCfqXdaVVspyidAZr+cUmizdINznUdMnkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIzL4SQhe+luLjvWMTTlRWE4y+2SFkeoPDGTa1T3Li550hL1uz8SgFew+R5MzDDH8x1l9Y9Mxp7EedRrl8WfWR1jBPS6rpDYCvswLvdgg4t10WcJzTWn/VHuBlVCuK7pAk6umULNTKEi5ZgyeK4yP66ynTHLaqZtFNlSD8mBUcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=jmCeCKxc; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755189708; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZDl531s6lAw51Lvk8RBZruW6gA9zcVhrI1R/nANGUgaT3or+S7o/S/Jv8ZJp64WeF80mJ8StAdjTXq5NbeEFnTkgtDi/IdEgO1P5utjuNrRpafjs0Dnpqh+04wO2QRJA/3uLAvhyW/00aFxVtoQpdodYP0yhivQABx3oQIb5zkk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755189708; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+Pu02Z4Nc8T8i9wTtv8O+nCC0w80iVjz0cu/motI15U=; 
	b=WIQKOrTHgc+IWtodF4jyUrwx2vL1+2c2WQknxRnm2K67h845Na7tNsSDeZF7O81t+qxC2Ulshm0sZHsihIFDsBEq+jGKEr3n209EZR6REK9oEDe/+wE/o0f6X+XXTOzvZsALdSN/OztKQmR8U0nDNob/zWlT6xM9KaFFh9vYrFE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755189708;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+Pu02Z4Nc8T8i9wTtv8O+nCC0w80iVjz0cu/motI15U=;
	b=jmCeCKxcoNmAT/1MzrByvccicCJ7UiUGxpWPht53oHo2WaJwoSZpsDcYv89H6s8e
	I9fO0VLWjGJyD5VWyxhRKqG+p+FhAUJ5RL9q2da810a0w3i12nZfUFvrs2mOt270Z4Q
	19wtzlV+uProOAkrxKO/8+V+9T8ARCupCaHaK1TAgn4+6X7DPmlB2reTmEQ4ax+JxPC
	6EzfKw97v6Vm+j001t2NAtI5hSv3yctQuMM5TkEpH0fM67up6BFUXh/ZM1VRv1Jh0wn
	JhRNaFHRbYVb00dzA/tjyCxhhJwFhkDOqtSZp/f6oFbm+iu0A5ri0W0Omw561P4MCtA
	sLTn6QiO1Q==
Received: by mx.zohomail.com with SMTPS id 1755189705347108.64266144678243;
	Thu, 14 Aug 2025 09:41:45 -0700 (PDT)
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
Subject: [RFC PATCH 2/8] dt-bindings: display: add versilicon,dc
Date: Fri, 15 Aug 2025 00:40:42 +0800
Message-ID: <20250814164048.2336043-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814164048.2336043-1-uwu@icenowy.me>
References: <20250814164048.2336043-1-uwu@icenowy.me>
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
 .../bindings/display/verisilicon,dc.yaml      | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/verisilicon,dc.yaml

diff --git a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
new file mode 100644
index 0000000000000..2f71a811786aa
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
+    items:
+      - description: DC Core clock
+      - description: DMA AXI bus clock
+      - description: Configuration AHB bus clock
+      - description: Pixel clock of output 0
+      - description: Pixel clock of output 1
+    minItems: 4
+
+  clock-names:
+    items:
+      - const: core
+      - const: axi
+      - const: ahb
+      - const: pix0
+      - const: pix1
+    minItems: 4
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
+           <&clk_vo CLK_DPU_ACLK>,
+           <&clk_vo CLK_DPU_HCLK>,
+           <&clk_vo CLK_DPU_PIXELCLK0>,
+           <&clk_vo CLK_DPU_PIXELCLK1>;
+        clock-names = "core", "axi", "ahb", "pix0", "pix1";
+        resets = <&rst TH1520_RESET_ID_DPU_CORE>,
+           <&rst TH1520_RESET_ID_DPU_AXI>,
+           <&rst TH1520_RESET_ID_DPU_AHB>;
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
2.50.1


