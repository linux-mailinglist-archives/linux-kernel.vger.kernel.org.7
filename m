Return-Path: <linux-kernel+bounces-862240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5416EBF4C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A387D407CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07A726E17A;
	Tue, 21 Oct 2025 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="B4V+BP26"
Received: from mail-m49244.qiye.163.com (mail-m49244.qiye.163.com [45.254.49.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05126B955;
	Tue, 21 Oct 2025 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029577; cv=none; b=uWHeXDum7RNPsyHp/pHgco1trJrMMl8bsfbXTawogH4QYzmr7IqyDvhUCkqIYU3GVvI2YCObRlj3U2ZUnilzTahqNk3CF7mRhJ+lrRjP9L3eGwWrxNmUWELvJOlSIx5ImT5m5IVj6IuDlhrZu7prR81ohQhqrH7IokGKH3Man+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029577; c=relaxed/simple;
	bh=Jd1Y6ifRO9rlsnGxJIsXGdrZ24fSOQuOaWpYU8vuVv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h005x/GeYOD7MmXIrsExRTbjiijzBdsHv5VoQucozgW9gT+kI4oLRCFPEWt4W6Zs3LLBJVDANnx+YZkTivKe5hjpceMKpZHZLe+kIl1QkZ+x2Bl0UBWTXW59S4bX3/kNwUE2QsV4viI3uYq3Eg8i5t6Bi8NtZh00jFAmfQYmI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=B4V+BP26; arc=none smtp.client-ip=45.254.49.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 269f91a69;
	Tue, 21 Oct 2025 14:52:44 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	sugar.zhang@rock-chips.com,
	zhangqing@rock-chips.com,
	heiko@sntech.de,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com,
	finley.xiao@rock-chips.com
Subject: [PATCH v4 6/7] dt-bindings: clock: rockchip: Add RK3506 clock and reset unit
Date: Tue, 21 Oct 2025 14:52:31 +0800
Message-Id: <20251021065232.2201500-7-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021065232.2201500-1-zhangqing@rock-chips.com>
References: <20251021065232.2201500-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a058aa80f03a3kunm647d21e85ed7fc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh1MGlZNSUxLSRlOSEMdHxhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=B4V+BP26wq/wcIJlKEW5WobKqdBpO68LW574XlWi2z8TsQA11p5SxYJPZyVnJiYjC+IlhGpHTFQ0KpQAdekS4VpDD6B/qtRLNSKKNgyV/RMyWZsqiVe1uAdrTMM7xuOwcOYow54CCf/NI0KEWLK3r3HnrMXlt/TaMwaD/cY9g2k=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=r1YOSC5lMmLh33iBzf/L49mNil1UpGuYXwcko9LYDmI=;
	h=date:mime-version:subject:message-id:from;

From: Finley Xiao <finley.xiao@rock-chips.com>

Add device tree bindings for clock and reset unit on RK3506 SoC.
Add clock and reset IDs for RK3506 SoC.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 .../bindings/clock/rockchip,rk3506-cru.yaml   |  45 +++
 .../dt-bindings/clock/rockchip,rk3506-cru.h   | 285 ++++++++++++++++++
 .../dt-bindings/reset/rockchip,rk3506-cru.h   | 211 +++++++++++++
 3 files changed, 541 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
 create mode 100644 include/dt-bindings/clock/rockchip,rk3506-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3506-cru.h

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
new file mode 100644
index 000000000000..43e192d9b2af
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3506-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3506 Clock and Reset Unit (CRU)
+
+maintainers:
+  - Finley Xiao <finley.xiao@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RK3506 CRU generates the clock and also implements reset for SoC
+  peripherals.
+
+properties:
+  compatible:
+    const: rockchip,rk3506-cru
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@ff9a0000 {
+      compatible = "rockchip,rk3506-cru";
+      reg = <0xff9a0000 0x20000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/rockchip,rk3506-cru.h b/include/dt-bindings/clock/rockchip,rk3506-cru.h
new file mode 100644
index 000000000000..f629b6fa75c3
--- /dev/null
+++ b/include/dt-bindings/clock/rockchip,rk3506-cru.h
@@ -0,0 +1,285 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023-2025 Rockchip Electronics Co., Ltd.
+ * Author: Finley Xiao <finley.xiao@rock-chips.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3506_H
+#define _DT_BINDINGS_CLK_ROCKCHIP_RK3506_H
+
+/* cru plls */
+#define PLL_GPLL			1
+#define PLL_V0PLL			2
+#define PLL_V1PLL			3
+
+/* cru-clocks indices */
+#define ARMCLK				15
+#define CLK_DDR				16
+#define XIN24M_GATE			17
+#define CLK_GPLL_GATE			18
+#define CLK_V0PLL_GATE			19
+#define CLK_V1PLL_GATE			20
+#define CLK_GPLL_DIV			21
+#define CLK_GPLL_DIV_100M		22
+#define CLK_V0PLL_DIV			23
+#define CLK_V1PLL_DIV			24
+#define CLK_INT_VOICE_MATRIX0		25
+#define CLK_INT_VOICE_MATRIX1		26
+#define CLK_INT_VOICE_MATRIX2		27
+#define CLK_FRAC_UART_MATRIX0_MUX	28
+#define CLK_FRAC_UART_MATRIX1_MUX	29
+#define CLK_FRAC_VOICE_MATRIX0_MUX	30
+#define CLK_FRAC_VOICE_MATRIX1_MUX	31
+#define CLK_FRAC_COMMON_MATRIX0_MUX	32
+#define CLK_FRAC_COMMON_MATRIX1_MUX	33
+#define CLK_FRAC_COMMON_MATRIX2_MUX	34
+#define CLK_FRAC_UART_MATRIX0		35
+#define CLK_FRAC_UART_MATRIX1		36
+#define CLK_FRAC_VOICE_MATRIX0		37
+#define CLK_FRAC_VOICE_MATRIX1		38
+#define CLK_FRAC_COMMON_MATRIX0		39
+#define CLK_FRAC_COMMON_MATRIX1		40
+#define CLK_FRAC_COMMON_MATRIX2		41
+#define CLK_REF_USBPHY_TOP		42
+#define CLK_REF_DPHY_TOP		43
+#define ACLK_CORE_ROOT			44
+#define PCLK_CORE_ROOT			45
+#define PCLK_DBG			48
+#define PCLK_CORE_GRF			49
+#define PCLK_CORE_CRU			50
+#define CLK_CORE_EMA_DETECT		51
+#define CLK_REF_PVTPLL_CORE		52
+#define PCLK_GPIO1			53
+#define DBCLK_GPIO1			54
+#define ACLK_CORE_PERI_ROOT		55
+#define HCLK_CORE_PERI_ROOT		56
+#define PCLK_CORE_PERI_ROOT		57
+#define CLK_DSMC			58
+#define ACLK_DSMC			59
+#define PCLK_DSMC			60
+#define CLK_FLEXBUS_TX			61
+#define CLK_FLEXBUS_RX			62
+#define ACLK_FLEXBUS			63
+#define HCLK_FLEXBUS			64
+#define ACLK_DSMC_SLV			65
+#define HCLK_DSMC_SLV			66
+#define ACLK_BUS_ROOT			67
+#define HCLK_BUS_ROOT			68
+#define PCLK_BUS_ROOT			69
+#define ACLK_SYSRAM			70
+#define HCLK_SYSRAM			71
+#define ACLK_DMAC0			72
+#define ACLK_DMAC1			73
+#define HCLK_M0				74
+#define PCLK_BUS_GRF			75
+#define PCLK_TIMER			76
+#define CLK_TIMER0_CH0			77
+#define CLK_TIMER0_CH1			78
+#define CLK_TIMER0_CH2			79
+#define CLK_TIMER0_CH3			80
+#define CLK_TIMER0_CH4			81
+#define CLK_TIMER0_CH5			82
+#define PCLK_WDT0			83
+#define TCLK_WDT0			84
+#define PCLK_WDT1			85
+#define TCLK_WDT1			86
+#define PCLK_MAILBOX			87
+#define PCLK_INTMUX			88
+#define PCLK_SPINLOCK			89
+#define PCLK_DDRC			90
+#define HCLK_DDRPHY			91
+#define PCLK_DDRMON			92
+#define CLK_DDRMON_OSC			93
+#define PCLK_STDBY			94
+#define HCLK_USBOTG0			95
+#define HCLK_USBOTG0_PMU		96
+#define CLK_USBOTG0_ADP			97
+#define HCLK_USBOTG1			98
+#define HCLK_USBOTG1_PMU		99
+#define CLK_USBOTG1_ADP			100
+#define PCLK_USBPHY			101
+#define ACLK_DMA2DDR			102
+#define PCLK_DMA2DDR			103
+#define STCLK_M0			104
+#define CLK_DDRPHY			105
+#define CLK_DDRC_SRC			106
+#define ACLK_DDRC_0			107
+#define ACLK_DDRC_1			108
+#define CLK_DDRC			109
+#define CLK_DDRMON			110
+#define HCLK_LSPERI_ROOT		111
+#define PCLK_LSPERI_ROOT		112
+#define PCLK_UART0			113
+#define PCLK_UART1			114
+#define PCLK_UART2			115
+#define PCLK_UART3			116
+#define PCLK_UART4			117
+#define SCLK_UART0			118
+#define SCLK_UART1			119
+#define SCLK_UART2			120
+#define SCLK_UART3			121
+#define SCLK_UART4			122
+#define PCLK_I2C0			123
+#define CLK_I2C0			124
+#define PCLK_I2C1			125
+#define CLK_I2C1			126
+#define PCLK_I2C2			127
+#define CLK_I2C2			128
+#define PCLK_PWM1			129
+#define CLK_PWM1			130
+#define CLK_OSC_PWM1			131
+#define CLK_RC_PWM1			132
+#define CLK_FREQ_PWM1			133
+#define CLK_COUNTER_PWM1		134
+#define PCLK_SPI0			135
+#define CLK_SPI0			136
+#define PCLK_SPI1			137
+#define CLK_SPI1			138
+#define PCLK_GPIO2			139
+#define DBCLK_GPIO2			140
+#define PCLK_GPIO3			141
+#define DBCLK_GPIO3			142
+#define PCLK_GPIO4			143
+#define DBCLK_GPIO4			144
+#define HCLK_CAN0			145
+#define CLK_CAN0			146
+#define HCLK_CAN1			147
+#define CLK_CAN1			148
+#define HCLK_PDM			149
+#define MCLK_PDM			150
+#define CLKOUT_PDM			151
+#define MCLK_SPDIFTX			152
+#define HCLK_SPDIFTX			153
+#define HCLK_SPDIFRX			154
+#define MCLK_SPDIFRX			155
+#define MCLK_SAI0			156
+#define HCLK_SAI0			157
+#define MCLK_OUT_SAI0			158
+#define MCLK_SAI1			159
+#define HCLK_SAI1			160
+#define MCLK_OUT_SAI1			161
+#define HCLK_ASRC0			162
+#define CLK_ASRC0			163
+#define HCLK_ASRC1			164
+#define CLK_ASRC1			165
+#define PCLK_CRU			166
+#define PCLK_PMU_ROOT			167
+#define MCLK_ASRC0			168
+#define MCLK_ASRC1			169
+#define MCLK_ASRC2			170
+#define MCLK_ASRC3			171
+#define LRCK_ASRC0_SRC			172
+#define LRCK_ASRC0_DST			173
+#define LRCK_ASRC1_SRC			174
+#define LRCK_ASRC1_DST			175
+#define ACLK_HSPERI_ROOT		176
+#define HCLK_HSPERI_ROOT		177
+#define PCLK_HSPERI_ROOT		178
+#define CCLK_SRC_SDMMC			179
+#define HCLK_SDMMC			180
+#define HCLK_FSPI			181
+#define SCLK_FSPI			182
+#define PCLK_SPI2			183
+#define ACLK_MAC0			184
+#define ACLK_MAC1			185
+#define PCLK_MAC0			186
+#define PCLK_MAC1			187
+#define CLK_MAC_ROOT			188
+#define CLK_MAC0			189
+#define CLK_MAC1			190
+#define MCLK_SAI2			191
+#define HCLK_SAI2			192
+#define MCLK_OUT_SAI2			193
+#define MCLK_SAI3_SRC			194
+#define HCLK_SAI3			195
+#define MCLK_SAI3			196
+#define MCLK_OUT_SAI3			197
+#define MCLK_SAI4_SRC			198
+#define HCLK_SAI4			199
+#define MCLK_SAI4			200
+#define HCLK_DSM			201
+#define MCLK_DSM			202
+#define PCLK_AUDIO_ADC			203
+#define MCLK_AUDIO_ADC			204
+#define MCLK_AUDIO_ADC_DIV4		205
+#define PCLK_SARADC			206
+#define CLK_SARADC			207
+#define PCLK_OTPC_NS			208
+#define CLK_SBPI_OTPC_NS		209
+#define CLK_USER_OTPC_NS		210
+#define PCLK_UART5			211
+#define SCLK_UART5			212
+#define PCLK_GPIO234_IOC		213
+#define CLK_MAC_PTP_ROOT		214
+#define CLK_MAC0_PTP			215
+#define CLK_MAC1_PTP			216
+#define CLK_SPI2			217
+#define ACLK_VIO_ROOT			218
+#define HCLK_VIO_ROOT			219
+#define PCLK_VIO_ROOT			220
+#define HCLK_RGA			221
+#define ACLK_RGA			222
+#define CLK_CORE_RGA			223
+#define ACLK_VOP			224
+#define HCLK_VOP			225
+#define DCLK_VOP			226
+#define PCLK_DPHY			227
+#define PCLK_DSI_HOST			228
+#define PCLK_TSADC			229
+#define CLK_TSADC			230
+#define CLK_TSADC_TSEN			231
+#define PCLK_GPIO1_IOC			232
+#define PCLK_OTPC_S			233
+#define CLK_SBPI_OTPC_S			234
+#define CLK_USER_OTPC_S			235
+#define PCLK_OTP_MASK			236
+#define PCLK_KEYREADER			237
+#define HCLK_BOOTROM			238
+#define PCLK_DDR_SERVICE		239
+#define HCLK_CRYPTO_S			240
+#define HCLK_KEYLAD			241
+#define CLK_CORE_CRYPTO			242
+#define CLK_PKA_CRYPTO			243
+#define CLK_CORE_CRYPTO_S		244
+#define CLK_PKA_CRYPTO_S		245
+#define ACLK_CRYPTO_S			246
+#define HCLK_RNG_S			247
+#define CLK_CORE_CRYPTO_NS		248
+#define CLK_PKA_CRYPTO_NS		249
+#define ACLK_CRYPTO_NS			250
+#define HCLK_CRYPTO_NS			251
+#define HCLK_RNG			252
+#define CLK_PMU				253
+#define PCLK_PMU			254
+#define CLK_PMU_32K			255
+#define PCLK_PMU_CRU			256
+#define PCLK_PMU_GRF			257
+#define PCLK_GPIO0_IOC			258
+#define PCLK_GPIO0			259
+#define DBCLK_GPIO0			260
+#define PCLK_GPIO1_SHADOW		261
+#define DBCLK_GPIO1_SHADOW		262
+#define PCLK_PMU_HP_TIMER		263
+#define CLK_PMU_HP_TIMER		264
+#define CLK_PMU_HP_TIMER_32K		265
+#define PCLK_PWM0			266
+#define CLK_PWM0			267
+#define CLK_OSC_PWM0			268
+#define CLK_RC_PWM0			269
+#define CLK_MAC_OUT			270
+#define CLK_REF_OUT0			271
+#define CLK_REF_OUT1			272
+#define CLK_32K_FRAC			273
+#define CLK_32K_RC			274
+#define CLK_32K				275
+#define CLK_32K_PMU			276
+#define PCLK_TOUCH_KEY			277
+#define CLK_TOUCH_KEY			278
+#define CLK_REF_PHY_PLL			279
+#define CLK_REF_PHY_PMU_MUX		280
+#define CLK_WIFI_OUT			281
+#define CLK_V0PLL_REF			282
+#define CLK_V1PLL_REF			283
+#define CLK_32K_FRAC_MUX		284
+
+#endif
diff --git a/include/dt-bindings/reset/rockchip,rk3506-cru.h b/include/dt-bindings/reset/rockchip,rk3506-cru.h
new file mode 100644
index 000000000000..f38cc066009b
--- /dev/null
+++ b/include/dt-bindings/reset/rockchip,rk3506-cru.h
@@ -0,0 +1,211 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023-2025 Rockchip Electronics Co., Ltd.
+ * Author: Finley Xiao <finley.xiao@rock-chips.com>
+ */
+
+#ifndef _DT_BINDINGS_REST_ROCKCHIP_RK3506_H
+#define _DT_BINDINGS_REST_ROCKCHIP_RK3506_H
+
+/* CRU-->SOFTRST_CON00 */
+#define SRST_NCOREPORESET0_AC		0
+#define SRST_NCOREPORESET1_AC		1
+#define SRST_NCOREPORESET2_AC		2
+#define SRST_NCORESET0_AC		3
+#define SRST_NCORESET1_AC		4
+#define SRST_NCORESET2_AC		5
+#define SRST_NL2RESET_AC		6
+#define SRST_ARESETN_CORE_BIU_AC	7
+#define SRST_HRESETN_M0_AC		8
+
+/* CRU-->SOFTRST_CON02 */
+#define SRST_NDBGRESET			9
+#define SRST_PRESETN_CORE_BIU		10
+#define SRST_RESETN_PMU			11
+
+/* CRU-->SOFTRST_CON03 */
+#define SRST_PRESETN_DBG		12
+#define SRST_POTRESETN_DBG		13
+#define SRST_PRESETN_CORE_GRF		14
+#define SRST_RESETN_CORE_EMA_DETECT	15
+#define SRST_RESETN_REF_PVTPLL_CORE	16
+#define SRST_PRESETN_GPIO1		17
+#define SRST_DBRESETN_GPIO1		18
+
+/* CRU-->SOFTRST_CON04 */
+#define SRST_ARESETN_CORE_PERI_BIU	19
+#define SRST_ARESETN_DSMC		20
+#define SRST_PRESETN_DSMC		21
+#define SRST_RESETN_FLEXBUS		22
+#define SRST_ARESETN_FLEXBUS		23
+#define SRST_HRESETN_FLEXBUS		24
+#define SRST_ARESETN_DSMC_SLV		25
+#define SRST_HRESETN_DSMC_SLV		26
+#define SRST_RESETN_DSMC_SLV		27
+
+/* CRU-->SOFTRST_CON05 */
+#define SRST_ARESETN_BUS_BIU		28
+#define SRST_HRESETN_BUS_BIU		29
+#define SRST_PRESETN_BUS_BIU		30
+#define SRST_ARESETN_SYSRAM		31
+#define SRST_HRESETN_SYSRAM		32
+#define SRST_ARESETN_DMAC0		33
+#define SRST_ARESETN_DMAC1		34
+#define SRST_HRESETN_M0			35
+#define SRST_RESETN_M0_JTAG		36
+#define SRST_HRESETN_CRYPTO		37
+
+/* CRU-->SOFTRST_CON06 */
+#define SRST_HRESETN_RNG		38
+#define SRST_PRESETN_BUS_GRF		39
+#define SRST_PRESETN_TIMER0		40
+#define SRST_RESETN_TIMER0_CH0		41
+#define SRST_RESETN_TIMER0_CH1		42
+#define SRST_RESETN_TIMER0_CH2		43
+#define SRST_RESETN_TIMER0_CH3		44
+#define SRST_RESETN_TIMER0_CH4		45
+#define SRST_RESETN_TIMER0_CH5		46
+#define SRST_PRESETN_WDT0		47
+#define SRST_TRESETN_WDT0		48
+#define SRST_PRESETN_WDT1		49
+#define SRST_TRESETN_WDT1		50
+#define SRST_PRESETN_MAILBOX		51
+#define SRST_PRESETN_INTMUX		52
+#define SRST_PRESETN_SPINLOCK		53
+
+/* CRU-->SOFTRST_CON07 */
+#define SRST_PRESETN_DDRC		54
+#define SRST_HRESETN_DDRPHY		55
+#define SRST_PRESETN_DDRMON		56
+#define SRST_RESETN_DDRMON_OSC		57
+#define SRST_PRESETN_DDR_LPC		58
+#define SRST_HRESETN_USBOTG0		59
+#define SRST_RESETN_USBOTG0_ADP		60
+#define SRST_HRESETN_USBOTG1		61
+#define SRST_RESETN_USBOTG1_ADP		62
+#define SRST_PRESETN_USBPHY		63
+#define SRST_RESETN_USBPHY_POR		64
+#define SRST_RESETN_USBPHY_OTG0		65
+#define SRST_RESETN_USBPHY_OTG1		66
+
+/* CRU-->SOFTRST_CON08 */
+#define SRST_ARESETN_DMA2DDR		67
+#define SRST_PRESETN_DMA2DDR		68
+
+/* CRU-->SOFTRST_CON09 */
+#define SRST_RESETN_USBOTG0_UTMI	69
+#define SRST_RESETN_USBOTG1_UTMI	70
+
+/* CRU-->SOFTRST_CON10 */
+#define SRST_ARESETN_DDRC_0		71
+#define SRST_ARESETN_DDRC_1		72
+#define SRST_ARESETN_DDR_BIU		73
+#define SRST_RESETN_DDRC		74
+#define SRST_RESETN_DDRMON		75
+
+/* CRU-->SOFTRST_CON11 */
+#define SRST_HRESETN_LSPERI_BIU		76
+#define SRST_PRESETN_UART0		77
+#define SRST_PRESETN_UART1		78
+#define SRST_PRESETN_UART2		79
+#define SRST_PRESETN_UART3		80
+#define SRST_PRESETN_UART4		81
+#define SRST_RESETN_UART0		82
+#define SRST_RESETN_UART1		83
+#define SRST_RESETN_UART2		84
+#define SRST_RESETN_UART3		85
+#define SRST_RESETN_UART4		86
+#define SRST_PRESETN_I2C0		87
+#define SRST_RESETN_I2C0		88
+
+/* CRU-->SOFTRST_CON12 */
+#define SRST_PRESETN_I2C1		89
+#define SRST_RESETN_I2C1		90
+#define SRST_PRESETN_I2C2		91
+#define SRST_RESETN_I2C2		92
+#define SRST_PRESETN_PWM1		93
+#define SRST_RESETN_PWM1		94
+#define SRST_PRESETN_SPI0		95
+#define SRST_RESETN_SPI0		96
+#define SRST_PRESETN_SPI1		97
+#define SRST_RESETN_SPI1		98
+#define SRST_PRESETN_GPIO2		99
+#define SRST_DBRESETN_GPIO2		100
+
+/* CRU-->SOFTRST_CON13 */
+#define SRST_PRESETN_GPIO3		101
+#define SRST_DBRESETN_GPIO3		102
+#define SRST_PRESETN_GPIO4		103
+#define SRST_DBRESETN_GPIO4		104
+#define SRST_HRESETN_CAN0		105
+#define SRST_RESETN_CAN0		106
+#define SRST_HRESETN_CAN1		107
+#define SRST_RESETN_CAN1		108
+#define SRST_HRESETN_PDM		109
+#define SRST_MRESETN_PDM		110
+#define SRST_RESETN_PDM			111
+#define SRST_RESETN_SPDIFTX		112
+#define SRST_HRESETN_SPDIFTX		113
+#define SRST_HRESETN_SPDIFRX		114
+#define SRST_RESETN_SPDIFRX		115
+#define SRST_MRESETN_SAI0		116
+
+/* CRU-->SOFTRST_CON14 */
+#define SRST_HRESETN_SAI0		117
+#define SRST_MRESETN_SAI1		118
+#define SRST_HRESETN_SAI1		119
+#define SRST_HRESETN_ASRC0		120
+#define SRST_RESETN_ASRC0		121
+#define SRST_HRESETN_ASRC1		122
+#define SRST_RESETN_ASRC1		123
+
+/* CRU-->SOFTRST_CON17 */
+#define SRST_HRESETN_HSPERI_BIU		124
+#define SRST_HRESETN_SDMMC		125
+#define SRST_HRESETN_FSPI		126
+#define SRST_SRESETN_FSPI		127
+#define SRST_PRESETN_SPI2		128
+#define SRST_ARESETN_MAC0		129
+#define SRST_ARESETN_MAC1		130
+
+/* CRU-->SOFTRST_CON18 */
+#define SRST_MRESETN_SAI2		131
+#define SRST_HRESETN_SAI2		132
+#define SRST_HRESETN_SAI3		133
+#define SRST_MRESETN_SAI3		134
+#define SRST_HRESETN_SAI4		135
+#define SRST_MRESETN_SAI4		136
+#define SRST_HRESETN_DSM		137
+#define SRST_MRESETN_DSM		138
+#define SRST_PRESETN_AUDIO_ADC		139
+#define SRST_MRESETN_AUDIO_ADC		140
+
+/* CRU-->SOFTRST_CON19 */
+#define SRST_PRESETN_SARADC		141
+#define SRST_RESETN_SARADC		142
+#define SRST_RESETN_SARADC_PHY		143
+#define SRST_PRESETN_OTPC_NS		144
+#define SRST_RESETN_SBPI_OTPC_NS	145
+#define SRST_RESETN_USER_OTPC_NS	146
+#define SRST_PRESETN_UART5		147
+#define SRST_RESETN_UART5		148
+#define SRST_PRESETN_GPIO234_IOC	149
+
+/* CRU-->SOFTRST_CON21 */
+#define SRST_ARESETN_VIO_BIU		150
+#define SRST_HRESETN_VIO_BIU		151
+#define SRST_HRESETN_RGA		152
+#define SRST_ARESETN_RGA		153
+#define SRST_RESETN_CORE_RGA		154
+#define SRST_ARESETN_VOP		155
+#define SRST_HRESETN_VOP		156
+#define SRST_RESETN_VOP			157
+#define SRST_PRESETN_DPHY		158
+#define SRST_PRESETN_DSI_HOST		159
+#define SRST_PRESETN_TSADC		160
+#define SRST_RESETN_TSADC		161
+
+/* CRU-->SOFTRST_CON22 */
+#define SRST_PRESETN_GPIO1_IOC		162
+
+#endif
-- 
2.34.1


