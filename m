Return-Path: <linux-kernel+bounces-877947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE74DC1F690
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B18614E9199
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CFB34E76A;
	Thu, 30 Oct 2025 09:59:03 +0000 (UTC)
Received: from mail-sh.amlogic.com (unknown [114.94.151.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086034DCF4;
	Thu, 30 Oct 2025 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.94.151.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818343; cv=none; b=uFXwyGnkjQKZ8SOxWSIrZU0HpJI2GWBiLe+vQ1E0wIGQw+dou9b7mfYvTTpjjXhSH8K9GJhK/lay7qp6EOORQUnYlEHlnooaU5u9nA/FRCiyTT8vfPBdba3N7OYd8ima8qW0OEH60RUQ6AeRaoWy1IKowuVcot4mOk/trxUJ7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818343; c=relaxed/simple;
	bh=E5igYXBmCyNyaq/a26aueEflhZpCWAta5CLO4LkMre8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3Hf23WB6fB762SY0Z7j6C7QiBFRsHj5Y+319Sjk1dqyyRKdq2kqB4wsHPugN42n9YsNnIqfvpUFqACi7f2nZUMx2/8Q16EFNSbbSeg+5poKQB7YnZx72OLp53wA+ocHOpjSVpjG67ltShTAecM1jGdMCZW6q1eqlyfOablkPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=114.94.151.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from rd03-sz.software.amlogic (10.28.11.121) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.61; Thu, 30 Oct 2025
 17:43:49 +0800
From: Jian Hu <jian.hu@amlogic.com>
To: Jerome Brunet <jbrunet@baylibre.com>, Xianwei Zhao
	<xianwei.zhao@amlogic.com>, Chuan Liu <chuan.liu@amlogic.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "Stephen
 Boyd" <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	"Dmitry Rokosov" <ddrokosov@sberdevices.ru>, robh+dt <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
CC: Jian Hu <jian.hu@amlogic.com>, Conor Dooley <conor.dooley@microchip.com>,
	devicetree <devicetree@vger.kernel.org>, linux-clk
	<linux-clk@vger.kernel.org>, linux-amlogic
	<linux-amlogic@lists.infradead.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 1/5] dt-bindings: clock: add Amlogic T7 PLL clock controller
Date: Thu, 30 Oct 2025 17:43:41 +0800
Message-ID: <20251030094345.2571222-2-jian.hu@amlogic.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251030094345.2571222-1-jian.hu@amlogic.com>
References: <20251030094345.2571222-1-jian.hu@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add DT bindings for the PLL clock controller of the Amlogic T7 SoC family.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/clock/amlogic,t7-pll-clkc.yaml   | 114 ++++++++++++++++++
 .../dt-bindings/clock/amlogic,t7-pll-clkc.h   |  56 +++++++++
 2 files changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,t7-pll-clkc.yaml
 create mode 100644 include/dt-bindings/clock/amlogic,t7-pll-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,t7-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,t7-pll-clkc.yaml
new file mode 100644
index 000000000000..49c61f65deff
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,t7-pll-clkc.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024-2025 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,t7-pll-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic T7 PLL Clock Control Controller
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+  - Jerome Brunet <jbrunet@baylibre.com>
+  - Jian Hu <jian.hu@amlogic.com>
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+
+properties:
+  compatible:
+    enum:
+      - amlogic,t7-gp0-pll
+      - amlogic,t7-gp1-pll
+      - amlogic,t7-hifi-pll
+      - amlogic,t7-pcie-pll
+      - amlogic,t7-mpll
+      - amlogic,t7-hdmi-pll
+      - amlogic,t7-mclk-pll
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  clocks:
+    items:
+      - description: mclk pll input oscillator gate
+      - description: oscillator input clock source for mclk_sel_0
+      - description: fixed input clock source for mclk_sel_0
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: in0
+      - const: in1
+      - const: in2
+    minItems: 1
+
+required:
+  - compatible
+  - '#clock-cells'
+  - reg
+  - clocks
+  - clock-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amlogic,t7-mclk-pll
+
+    then:
+      properties:
+        clocks:
+          minItems: 3
+
+        clock-names:
+          minItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,t7-gp0-pll
+              - amlogic,t7-gp1--pll
+              - amlogic,t7-hifi-pll
+              - amlogic,t7-pcie-pll
+              - amlogic,t7-mpll
+              - amlogic,t7-hdmi-pll
+
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          maxItems: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    apb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@8080 {
+            compatible = "amlogic,t7-gp0-pll";
+            reg = <0 0x8080 0 0x20>;
+            clocks = <&scmi_clk 2>;
+            clock-names = "in0";
+            #clock-cells = <1>;
+        };
+
+        clock-controller@8300 {
+            compatible = "amlogic,t7-mclk-pll";
+            reg = <0 0x8300 0 0x18>;
+            clocks = <&scmi_clk 2>,
+                     <&xtal>,
+                     <&scmi_clk 31>;
+            clock-names = "in0", "in1", "in2";
+            #clock-cells = <1>;
+        };
+    };
diff --git a/include/dt-bindings/clock/amlogic,t7-pll-clkc.h b/include/dt-bindings/clock/amlogic,t7-pll-clkc.h
new file mode 100644
index 000000000000..e2481f2f1163
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,t7-pll-clkc.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2024-2025 Amlogic, Inc. All rights reserved
+ */
+
+#ifndef __T7_PLL_CLKC_H
+#define __T7_PLL_CLKC_H
+
+/* GP0 */
+#define CLKID_GP0_PLL_DCO	0
+#define CLKID_GP0_PLL		1
+
+/* GP1 */
+#define CLKID_GP1_PLL_DCO	0
+#define CLKID_GP1_PLL		1
+
+/* HIFI */
+#define CLKID_HIFI_PLL_DCO	0
+#define CLKID_HIFI_PLL		1
+
+/* PCIE */
+#define CLKID_PCIE_PLL_DCO	0
+#define CLKID_PCIE_PLL_DCO_DIV2	1
+#define CLKID_PCIE_PLL_OD	2
+#define CLKID_PCIE_PLL		3
+
+/* MPLL */
+#define CLKID_MPLL_PREDIV	0
+#define CLKID_MPLL0_DIV		1
+#define CLKID_MPLL0		2
+#define CLKID_MPLL1_DIV		3
+#define CLKID_MPLL1		4
+#define CLKID_MPLL2_DIV		5
+#define CLKID_MPLL2		6
+#define CLKID_MPLL3_DIV		7
+#define CLKID_MPLL3		8
+
+/* HDMI */
+#define CLKID_HDMI_PLL_DCO	0
+#define CLKID_HDMI_PLL_OD	1
+#define CLKID_HDMI_PLL		2
+
+/* MCLK */
+#define CLKID_MCLK_PLL_DCO	0
+#define CLKID_MCLK_PRE		1
+#define CLKID_MCLK_PLL		2
+#define CLKID_MCLK_0_SEL	3
+#define CLKID_MCLK_0_DIV2	4
+#define CLKID_MCLK_0_PRE	5
+#define CLKID_MCLK_0		6
+#define CLKID_MCLK_1_SEL	7
+#define CLKID_MCLK_1_DIV2	8
+#define CLKID_MCLK_1_PRE	9
+#define CLKID_MCLK_1		10
+
+#endif /* __T7_PLL_CLKC_H */
-- 
2.47.1


