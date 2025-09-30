Return-Path: <linux-kernel+bounces-837426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD50BAC509
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7B31927267
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E672F8BE4;
	Tue, 30 Sep 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2YMv6mb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F22F5333;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225051; cv=none; b=YiY7fppCtcPmEiRQ3nKVQXk+vjJdxv7Yt+S+BzUnCxrcP8pwOvK0FuovactPB64WDqi3qlHCSUuxzCFSm6Vhg4Pxvtnp7TnOiwG/dA9XM4mDSRzsfqeAS0U0e7mY+0Ip+/wRF0QHcdjz2X2G8ErO0KkUl/Acmmaqy0IbNOAIIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225051; c=relaxed/simple;
	bh=Ln6ckunYF1rhHX/pMi0GZqFO1vw1cbwS0hhp7CdYdMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kLWotdpB4D/2hG7iPaDEAtGJDluqt9/NaOZOMhVkOlqFCm9nDqAyHFJvCU3ow7l2z7ZOW5HRn3rfCDo+OORfh7sa2unyHee/Ft1w8R96siv0qQYMQue01rXUR4qCsy8CpUYbUDg7jbur0SFtrsfFyt6qzIoltDXmZ76n7TYhv2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2YMv6mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 645D0C4AF0C;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759225051;
	bh=Ln6ckunYF1rhHX/pMi0GZqFO1vw1cbwS0hhp7CdYdMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O2YMv6mbgT79WBGL2LXGTHx37t3nbjWEkdBv8EjwFiEyXCMERsfnMFP+jM7O9BH4M
	 hHOpXyWAVr+LAKZ9ayK7LtVizPGDADJ45BNEnEyhUChIBBn8BD7T9wP0vkv9MBDTFy
	 SbpQ6RnqK4PHEMaQZWpJL5AOYWK1wTuylb4gzMg0/lm9luJJKkQK3Q/9NasUqqbBYP
	 QAeWG37tQYSsq5hWJGrvip2kh5AJ6qSobxFsjWSarOW1weWrp9l8KLEM7zipwdxijk
	 dYj2afvD1CHfI58mk4/7TSoYAic9U1BAPRa3zp/JfMQgROWlCuefoPWuDk3b8i96cB
	 EEmH4GlmuDuew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F978CAC5B9;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 30 Sep 2025 17:37:15 +0800
Subject: [PATCH 02/19] dt-bindings: clock: Add Amlogic A4 PLL clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-a4_a5_add_clock_driver-v1-2-a9acf7951589@amlogic.com>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
In-Reply-To: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759225047; l=2798;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=Ft6yNqo0TZ3QMKb3Jm5Wur9+935/1unmm660KRVPRPE=;
 b=2dpRYtAPCMjQbgEd7EMDfUTMrfRTEis8Y4GdAn4NjLc4KD01/8j89KXgL4Txe0Cy3rKTBvv3o
 eLsPuSQ6X+GBUiNTGLkXxVH9r6bIYzfxMxgIszPdqOkuCly5YWFwrHs
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the PLL clock controller dt-bindings for Amlogic A4 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 .../bindings/clock/amlogic,a4-pll-clkc.yaml        | 61 ++++++++++++++++++++++
 include/dt-bindings/clock/amlogic,a4-pll-clkc.h    | 15 ++++++
 2 files changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,a4-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a4-pll-clkc.yaml
new file mode 100644
index 000000000000..dafad7bd4407
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,a4-pll-clkc.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2025 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,a4-pll-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic A4 series PLL Clock Controller
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+  - Jerome Brunet <jbrunet@baylibre.com>
+  - Chuan Liu <chuan.liu@amlogic.com>
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+
+properties:
+  compatible:
+    const: amlogic,a4-pll-clkc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: input oscillator
+      - description: input fix pll
+
+  clock-names:
+    items:
+      - const: xtal
+      - const: fix
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/amlogic,a4-scmi-clkc.h>
+    apb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@8000 {
+            compatible = "amlogic,a4-pll-clkc";
+            reg = <0x0 0x8000 0x0 0x110>;
+            clocks = <&xtal>,
+                     <&scmi_clk CLKID_FIXED_PLL>;
+            clock-names = "xtal",
+                          "fix";
+            #clock-cells = <1>;
+        };
+    };
diff --git a/include/dt-bindings/clock/amlogic,a4-pll-clkc.h b/include/dt-bindings/clock/amlogic,a4-pll-clkc.h
new file mode 100644
index 000000000000..0950dcd68e0a
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,a4-pll-clkc.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2025 Amlogic, Inc. All rights reserved.
+ * Author: Chuan Liu <chuan.liu@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_A4_PLL_CLKC_H
+#define _DT_BINDINGS_CLOCK_AMLOGIC_A4_PLL_CLKC_H
+
+#define CLKID_GP0_PLL_DCO			0
+#define CLKID_GP0_PLL				1
+#define CLKID_HIFI_PLL_DCO			2
+#define CLKID_HIFI_PLL				3
+
+#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_A4_PLL_CLKC_H */

-- 
2.42.0



