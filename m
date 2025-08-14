Return-Path: <linux-kernel+bounces-769311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38864B26CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CEB1CC06F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7862FAC0F;
	Thu, 14 Aug 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="fABAvV/6"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD532E2654;
	Thu, 14 Aug 2025 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189769; cv=pass; b=HzfU8EMvDHPcYjdzE76e9X/CxThaugekLJsG1Clen9jsJIeo8vvtDpaulXltVfIDQJk1bVBOGGJ6g+aE8ydOTA/P45iTXAzOTV0RkmLYFtQaGJqtVPksGh+V+sq8Iqm2Hoh4HU98VCtUJEdImonjeGLK8yoeB43wNjGle12GbgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189769; c=relaxed/simple;
	bh=ScBUgk+S5mNAc4FVpd4UGUti6uVzU5eNX0n3azPdLhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiYA1gUtemEIs82Fw0E5+liSNtUz+XZtqsQI4gYHeXgTcsYgXPnq3R57eSqmFN3G362KKyLhMiV165hjs4rwT37wB/eeONKYEW4Z/rdfWtIqytcnLMBJbRpFrSNnVqMzBF3Ld5GtRRQjPzVBTRiVtoe7IHpKVBR7pKX++C06074=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=fABAvV/6; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755189734; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ExGj8PYVDQrNGN+PHQvoPCTT5JJOqVbM7/gAtbrPb9F7pvxYyArbRMi1ora8LGm2vDhaHXDbdQfdiblsXafTJvE4bVk4+nwo78Q4j5tcgV/jYr6R4Tklp7qEv4W0jlPZfBw3SJYDS8bdQQPePS4//PVixnJpgAN9RDtUm+n+Wbk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755189734; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xT73VSOAWFqcNR9QaJalEbid5M45X4zPD1e4xI85pnM=; 
	b=YgWfNlYe8J2QrquK+vXg43RvhhNaQm0N9sk+A9MZ5o1m33/a4v8vxhLTAxRraviwkfCnUxw2CqGJ3bWv2TNB/i/LDODY2QydQyVwKnCvdT1cWBuMU+ch3L/5E7b1K2QlCIr3bLHY3IzyGQHRn1eRcYTUkvYmQGp5od+bstxaFCY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755189734;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xT73VSOAWFqcNR9QaJalEbid5M45X4zPD1e4xI85pnM=;
	b=fABAvV/6NKqD2ji5lIuWriodDvyeHFQq8w70zg7wVEMgWi4vz3GxdVtJS7rWzy5B
	Q01w5Z4Vjh+7cTRLXvzE9TdaZSeQYgpp1cL6q0tlEwS19oGA1Fhbuw6obXOaXKH9ilO
	sF8v77XYDUIzqIuNI1OcM+QYAU4OVVyc+EgWNgZKgoveFQoa8ELr6sGw+q0gnaltzOR
	mHrK00XXiJu92XwYfG8skNOwwShe93JPnw2bmnyBuTE2AbkKfolJB+8lcvfuGpBa+Ja
	1xx35EC35BjthQfVFKFYSimsq2JoJSMLrMnbW4BVsa0B3vt8cn+2sXS/wXrJTyvGp52
	KOwwRyni3g==
Received: by mx.zohomail.com with SMTPS id 1755189733254667.9457856333667;
	Thu, 14 Aug 2025 09:42:13 -0700 (PDT)
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
Subject: [RFC PATCH 4/8] dt-bindings: display/bridge: add binding for TH1520 HDMI controller
Date: Fri, 15 Aug 2025 00:40:44 +0800
Message-ID: <20250814164048.2336043-5-uwu@icenowy.me>
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

T-Head TH1520 SoC contains a Synopsys DesignWare HDMI controller paired
with DesignWare HDMI PHY, with an extra clock gate for HDMI pixel clock
and two reset controls.

Add a device tree binding to it.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 .../display/bridge/thead,th1520-dw-hdmi.yaml  | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/thead,th1520-dw-hdmi.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/thead,th1520-dw-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/thead,th1520-dw-hdmi.yaml
new file mode 100644
index 0000000000000..3d2b502b08eb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/thead,th1520-dw-hdmi.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/thead,th1520-dw-hdmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-Head TH1520 DesignWare HDMI TX Encoder
+
+maintainers:
+  - Icenowy Zheng <uwu@icenowy.me>
+
+description:
+  The HDMI transmitter is a Synopsys DesignWare HDMI TX controller
+  paired with a DesignWare HDMI Gen2 TX PHY.
+
+allOf:
+  - $ref: /schemas/display/bridge/synopsys,dw-hdmi.yaml#
+
+properties:
+  compatible:
+    enum:
+      - thead,th1520-dw-hdmi
+
+  reg-io-width:
+    const: 4
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: iahb
+      - const: isfr
+      - const: cec
+      - const: pix
+
+  resets:
+    items:
+      - description: Main reset
+      - description: Configuration APB reset
+
+  reset-names:
+    items:
+      - const: main
+      - const: apb
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Input port connected to DC8200 DPU "DP" output
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: HDMI output port
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - reg-io-width
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - interrupts
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
+    #include <dt-bindings/reset/thead,th1520-reset.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      hdmi@ffef540000 {
+        compatible = "thead,th1520-dw-hdmi";
+        reg = <0xff 0xef540000 0x0 0x40000>;
+        reg-io-width = <4>;
+        interrupts = <111 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk_vo CLK_HDMI_PCLK>,
+          <&clk_vo CLK_HDMI_SFR>,
+          <&clk_vo CLK_HDMI_CEC>,
+          <&clk_vo CLK_HDMI_PIXCLK>;
+        clock-names = "iahb", "isfr", "cec", "pix";
+        resets = <&rst_vo TH1520_RESET_ID_HDMI>,
+          <&rst_vo TH1520_RESET_ID_HDMI_APB>;
+        reset-names = "main", "apb";
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          port@0 {
+            reg = <0>;
+
+            hdmi_in: endpoint {
+              remote-endpoint = <&dpu_out_dp1>;
+            };
+          };
+
+          port@1 {
+            reg = <1>;
+
+            hdmi_out_conn: endpoint {
+              remote-endpoint = <&hdmi_conn_in>;
+            };
+          };
+        };
+      };
+    };
-- 
2.50.1


