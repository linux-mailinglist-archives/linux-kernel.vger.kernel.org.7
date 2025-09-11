Return-Path: <linux-kernel+bounces-812626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C86B53AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0848B188E586
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFCE3629BA;
	Thu, 11 Sep 2025 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eioH7piU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D73248F48;
	Thu, 11 Sep 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612834; cv=none; b=P+zOJb25t69u/yO7NrM6fsj7HtaGt/a/PR2JtkdY4wQp0P+JRcMcAchMRh2CXkHas7YgA2HmqG486Pl5zN+8n0Oiu75aMuBuwRve7otR1Shqf49lte+uTEvti021n84+OiwrUeH9UVyuoU3CBdXLcWRD4U0nM80RgkAwvZ7yjic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612834; c=relaxed/simple;
	bh=Q3Bq96TZlKcAyxsYaW5NK7Z7jsH62AFVMSMZMWwZAZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSzwU3Lx227NhoErAI2ExUemuM3nPC3IkO2fxY3vpIpHPfWcr/+GV99pQkEwS7W5g6S6SgMJFAk6ygnrrpSkr9dsGYmjSO2Ak74NT0dlzYAoJda10Rq5y8KM+m34aZTndzgqmH7Sdtfk62rVf/x90TD+XAXh9fv/W636DjiRO4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eioH7piU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FB9C4CEF9;
	Thu, 11 Sep 2025 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757612834;
	bh=Q3Bq96TZlKcAyxsYaW5NK7Z7jsH62AFVMSMZMWwZAZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eioH7piUxt6gprqkiVToK4rfU/Xupd6Mn1pE3NkbKtJIyE7oQ6nvApZ+G4vhFmqdu
	 HPe11lS0dnZp1MN+1fpKJIUym3im+wiQkzf0Lh0Da+ZRAMdV9BGe/jmz7D0y/xxeg4
	 upmixnqzth9A7vd3GpzgyWpT8Xxs3HJsjfMgXH5KKhcaL1K8TkvGhSZw6+Qs5me/8y
	 bx1mFzJsBqbiVVCe/d+RN2LUZneMpmXEqHmsFxoAnuJ0fpPs1NdS1B6Fc+9bsAaU+F
	 rZjGqFP8dQ7YeCj6ClNuJBawQxIZLmsV5NiB09DMnqvUseBvFH4WYS03XKDi8FKkpR
	 LADvn2mWscqFQ==
Received: by wens.tw (Postfix, from userid 1000)
	id D3AE45FE52; Fri, 12 Sep 2025 01:47:11 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/7] dt-bindings: clock: sun55i-a523-ccu: Add A523 MCU CCU clock controller
Date: Fri, 12 Sep 2025 01:47:05 +0800
Message-Id: <20250911174710.3149589-3-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250911174710.3149589-1-wens@kernel.org>
References: <20250911174710.3149589-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

There are four clock controllers in the A523 SoC. The existing binding
already covers two of them that are critical for basic operation. The
remaining ones are the MCU clock controller and CPU PLL clock
controller.

Add a description for the MCU CCU. This unit controls and provides
clocks to the MCU (RISC-V) subsystem and peripherals meant to operate
under low power conditions.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v1:
- Moved "r-ahb" clock to the end of the list and added "r-apb0" clock

Reviewed-by not dropped since this is a minor change.
---
 .../clock/allwinner,sun55i-a523-ccu.yaml      | 37 ++++++++++++-
 .../dt-bindings/clock/sun55i-a523-mcu-ccu.h   | 54 +++++++++++++++++++
 .../dt-bindings/reset/sun55i-a523-mcu-ccu.h   | 30 +++++++++++
 3 files changed, 119 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/clock/sun55i-a523-mcu-ccu.h
 create mode 100644 include/dt-bindings/reset/sun55i-a523-mcu-ccu.h

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
index f5f62e9a10a1..58be701a720e 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun55i-a523-ccu.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - allwinner,sun55i-a523-ccu
+      - allwinner,sun55i-a523-mcu-ccu
       - allwinner,sun55i-a523-r-ccu
 
   reg:
@@ -26,11 +27,11 @@ properties:
 
   clocks:
     minItems: 4
-    maxItems: 5
+    maxItems: 9
 
   clock-names:
     minItems: 4
-    maxItems: 5
+    maxItems: 9
 
 required:
   - "#clock-cells"
@@ -63,6 +64,38 @@ allOf:
             - const: iosc
             - const: losc-fanout
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - allwinner,sun55i-a523-mcu-ccu
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: High Frequency Oscillator (usually at 24MHz)
+            - description: Low Frequency Oscillator (usually at 32kHz)
+            - description: Internal Oscillator
+            - description: Audio PLL (4x)
+            - description: Peripherals PLL 0 (300 MHz output)
+            - description: DSP module clock
+            - description: MBUS clock
+            - description: PRCM AHB clock
+            - description: PRCM APB0 clock
+
+        clock-names:
+          items:
+            - const: hosc
+            - const: losc
+            - const: iosc
+            - const: pll-audio0-4x
+            - const: pll-periph0-300m
+            - const: dsp
+            - const: mbus
+            - const: r-ahb
+            - const: r-apb0
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/clock/sun55i-a523-mcu-ccu.h b/include/dt-bindings/clock/sun55i-a523-mcu-ccu.h
new file mode 100644
index 000000000000..6efc6bc7e11a
--- /dev/null
+++ b/include/dt-bindings/clock/sun55i-a523-mcu-ccu.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2025 Chen-Yu Tsai <wens@csie.org>
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN55I_A523_MCU_CCU_H_
+#define _DT_BINDINGS_CLK_SUN55I_A523_MCU_CCU_H_
+
+#define CLK_MCU_PLL_AUDIO1	0
+#define CLK_MCU_PLL_AUDIO1_DIV2	1
+#define CLK_MCU_PLL_AUDIO1_DIV5	2
+#define CLK_MCU_AUDIO_OUT	3
+#define CLK_MCU_DSP		4
+#define CLK_MCU_I2S0		5
+#define CLK_MCU_I2S1		6
+#define CLK_MCU_I2S2		7
+#define CLK_MCU_I2S3		8
+#define CLK_MCU_I2S3_ASRC	9
+#define CLK_BUS_MCU_I2S0	10
+#define CLK_BUS_MCU_I2S1	11
+#define CLK_BUS_MCU_I2S2	12
+#define CLK_BUS_MCU_I2S3	13
+#define CLK_MCU_SPDIF_TX	14
+#define CLK_MCU_SPDIF_RX	15
+#define CLK_BUS_MCU_SPDIF	16
+#define CLK_MCU_DMIC		17
+#define CLK_BUS_MCU_DMIC	18
+#define CLK_MCU_AUDIO_CODEC_DAC	19
+#define CLK_MCU_AUDIO_CODEC_ADC	20
+#define CLK_BUS_MCU_AUDIO_CODEC	21
+#define CLK_BUS_MCU_DSP_MSGBOX	22
+#define CLK_BUS_MCU_DSP_CFG	23
+#define CLK_BUS_MCU_NPU_HCLK	24
+#define CLK_BUS_MCU_NPU_ACLK	25
+#define CLK_MCU_TIMER0		26
+#define CLK_MCU_TIMER1		27
+#define CLK_MCU_TIMER2		28
+#define CLK_MCU_TIMER3		29
+#define CLK_MCU_TIMER4		30
+#define CLK_MCU_TIMER5		31
+#define CLK_BUS_MCU_TIMER	32
+#define CLK_BUS_MCU_DMA		33
+#define CLK_MCU_TZMA0		34
+#define CLK_MCU_TZMA1		35
+#define CLK_BUS_MCU_PUBSRAM	36
+#define CLK_MCU_MBUS_DMA	37
+#define CLK_MCU_MBUS		38
+#define CLK_MCU_RISCV		39
+#define CLK_BUS_MCU_RISCV_CFG	40
+#define CLK_BUS_MCU_RISCV_MSGBOX	41
+#define CLK_MCU_PWM0		42
+#define CLK_BUS_MCU_PWM0	43
+
+#endif /* _DT_BINDINGS_CLK_SUN55I_A523_MCU_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun55i-a523-mcu-ccu.h b/include/dt-bindings/reset/sun55i-a523-mcu-ccu.h
new file mode 100644
index 000000000000..a89a0b44f08b
--- /dev/null
+++ b/include/dt-bindings/reset/sun55i-a523-mcu-ccu.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2025 Chen-Yu Tsai <wens@csie.org>
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN55I_A523_MCU_CCU_H_
+#define _DT_BINDINGS_RST_SUN55I_A523_MCU_CCU_H_
+
+#define RST_BUS_MCU_I2S0		0
+#define RST_BUS_MCU_I2S1		1
+#define RST_BUS_MCU_I2S2		2
+#define RST_BUS_MCU_I2S3		3
+#define RST_BUS_MCU_SPDIF		4
+#define RST_BUS_MCU_DMIC		5
+#define RST_BUS_MCU_AUDIO_CODEC		6
+#define RST_BUS_MCU_DSP_MSGBOX		7
+#define RST_BUS_MCU_DSP_CFG		8
+#define RST_BUS_MCU_NPU			9
+#define RST_BUS_MCU_TIMER		10
+#define RST_BUS_MCU_DSP_DEBUG		11
+#define RST_BUS_MCU_DSP			12
+#define RST_BUS_MCU_DMA			13
+#define RST_BUS_MCU_PUBSRAM		14
+#define RST_BUS_MCU_RISCV_CFG		15
+#define RST_BUS_MCU_RISCV_DEBUG		16
+#define RST_BUS_MCU_RISCV_CORE		17
+#define RST_BUS_MCU_RISCV_MSGBOX	18
+#define RST_BUS_MCU_PWM0		19
+
+#endif /* _DT_BINDINGS_RST_SUN55I_A523_MCU_CCU_H_ */
-- 
2.39.5


