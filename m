Return-Path: <linux-kernel+bounces-889649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44377C3E24B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68FE24E88C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848822F6920;
	Fri,  7 Nov 2025 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Jfpmqq0a"
Received: from mail-m49229.qiye.163.com (mail-m49229.qiye.163.com [45.254.49.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BFD450FE;
	Fri,  7 Nov 2025 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762479497; cv=none; b=nxVfwM4FYl30/KEQ7Sgbl3QvSKIwihDNkKJeTaxwGn7u7UMeJ0IE4rJ2Blwwjt/aGwh4S5WlXrDB5cVlpe74pI2Ad6n7VCStTiYV58Aa5bHzBe6WUf1muHMlQR0RAEE/d27GEAk6XVyQDXLUMEyl/y6yU/85m0NGI7QMBtojrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762479497; c=relaxed/simple;
	bh=+S9r5rkJp1EZlLUDfEe1iLCeg840aqUyI6EFFYIJq3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mDhz/WhjBA/LxXZPBea1YNjYKeaM8RAbcyveLN/xOFZBf9fbXFXxXsdocL9PFewD/I/6zIhk0mqIo2qZbIa2dzyeBKBS2I0NQ9vjdQ9oO2wSD5IhMg3eYYvB8/L4aaMFesfeWRHS5+NhoCCpRFaUuRTaA3CZzJZPfqVinCMQRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Jfpmqq0a; arc=none smtp.client-ip=45.254.49.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28b49fefb;
	Fri, 7 Nov 2025 09:38:01 +0800 (GMT+08:00)
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
Subject: [RESEND PATCH v6 4/5] dt-bindings: clock: rockchip: Add RK3506 clock and reset unit
Date: Fri,  7 Nov 2025 09:37:57 +0800
Message-Id: <20251107013757.5013-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a5bf6a3dc03a3kunm466b69c9d0937f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJNHlZISE9IT0kZSR8eS0lWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=Jfpmqq0adfMcglkQnUbNeqjgjJFvr8y/+pEER2c6W/46UoAJ4Bnf8Y367YjtDViLEJ57k/eKjiPutjz20Ad7Xm3TYZbJ8yF9KZpjbpp83oTgZAAYy7Drw7uEHFIrpuQ16TQPjVrX2W7PValuZ5nMV/hVCDPswSvt2XmhdEgrzto=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=3gpsCt12Xw3ejS3aK082FzXr0y+EOOGyXFSeiXrBKZg=;
	h=date:mime-version:subject:message-id:from;

From: Finley Xiao <finley.xiao@rock-chips.com>

Add device tree bindings for clock and reset unit on RK3506 SoC.
Add clock and reset IDs for RK3506 SoC.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 .../bindings/clock/rockchip,rk3506-cru.yaml   |  51 ++++
 .../dt-bindings/clock/rockchip,rk3506-cru.h   | 285 ++++++++++++++++++
 .../dt-bindings/reset/rockchip,rk3506-cru.h   | 211 +++++++++++++
 3 files changed, 547 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
 create mode 100644 include/dt-bindings/clock/rockchip,rk3506-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3506-cru.h

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
new file mode 100644
index 000000000000..ecb5fa497747
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
@@ -0,0 +1,51 @@
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
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: xin24m
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
index 000000000000..71d7dda23cc9
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
+#define PLL_GPLL			0
+#define PLL_V0PLL			1
+#define PLL_V1PLL			2
+
+/* cru-clocks indices */
+#define ARMCLK				3
+#define CLK_DDR				4
+#define XIN24M_GATE			5
+#define CLK_GPLL_GATE			6
+#define CLK_V0PLL_GATE			7
+#define CLK_V1PLL_GATE			8
+#define CLK_GPLL_DIV			9
+#define CLK_GPLL_DIV_100M		10
+#define CLK_V0PLL_DIV			11
+#define CLK_V1PLL_DIV			12
+#define CLK_INT_VOICE_MATRIX0		13
+#define CLK_INT_VOICE_MATRIX1		14
+#define CLK_INT_VOICE_MATRIX2		15
+#define CLK_FRAC_UART_MATRIX0_MUX	16
+#define CLK_FRAC_UART_MATRIX1_MUX	17
+#define CLK_FRAC_VOICE_MATRIX0_MUX	18
+#define CLK_FRAC_VOICE_MATRIX1_MUX	19
+#define CLK_FRAC_COMMON_MATRIX0_MUX	20
+#define CLK_FRAC_COMMON_MATRIX1_MUX	21
+#define CLK_FRAC_COMMON_MATRIX2_MUX	22
+#define CLK_FRAC_UART_MATRIX0		23
+#define CLK_FRAC_UART_MATRIX1		24
+#define CLK_FRAC_VOICE_MATRIX0		25
+#define CLK_FRAC_VOICE_MATRIX1		26
+#define CLK_FRAC_COMMON_MATRIX0		27
+#define CLK_FRAC_COMMON_MATRIX1		28
+#define CLK_FRAC_COMMON_MATRIX2		29
+#define CLK_REF_USBPHY_TOP		30
+#define CLK_REF_DPHY_TOP		31
+#define ACLK_CORE_ROOT			32
+#define PCLK_CORE_ROOT			33
+#define PCLK_DBG			34
+#define PCLK_CORE_GRF			35
+#define PCLK_CORE_CRU			36
+#define CLK_CORE_EMA_DETECT		37
+#define CLK_REF_PVTPLL_CORE		38
+#define PCLK_GPIO1			39
+#define DBCLK_GPIO1			40
+#define ACLK_CORE_PERI_ROOT		41
+#define HCLK_CORE_PERI_ROOT		42
+#define PCLK_CORE_PERI_ROOT		43
+#define CLK_DSMC			44
+#define ACLK_DSMC			45
+#define PCLK_DSMC			46
+#define CLK_FLEXBUS_TX			47
+#define CLK_FLEXBUS_RX			48
+#define ACLK_FLEXBUS			49
+#define HCLK_FLEXBUS			50
+#define ACLK_DSMC_SLV			51
+#define HCLK_DSMC_SLV			52
+#define ACLK_BUS_ROOT			53
+#define HCLK_BUS_ROOT			54
+#define PCLK_BUS_ROOT			55
+#define ACLK_SYSRAM			56
+#define HCLK_SYSRAM			57
+#define ACLK_DMAC0			58
+#define ACLK_DMAC1			59
+#define HCLK_M0				60
+#define PCLK_BUS_GRF			61
+#define PCLK_TIMER			62
+#define CLK_TIMER0_CH0			63
+#define CLK_TIMER0_CH1			64
+#define CLK_TIMER0_CH2			65
+#define CLK_TIMER0_CH3			66
+#define CLK_TIMER0_CH4			67
+#define CLK_TIMER0_CH5			68
+#define PCLK_WDT0			69
+#define TCLK_WDT0			70
+#define PCLK_WDT1			71
+#define TCLK_WDT1			72
+#define PCLK_MAILBOX			73
+#define PCLK_INTMUX			74
+#define PCLK_SPINLOCK			75
+#define PCLK_DDRC			76
+#define HCLK_DDRPHY			77
+#define PCLK_DDRMON			78
+#define CLK_DDRMON_OSC			79
+#define PCLK_STDBY			80
+#define HCLK_USBOTG0			81
+#define HCLK_USBOTG0_PMU		82
+#define CLK_USBOTG0_ADP			83
+#define HCLK_USBOTG1			84
+#define HCLK_USBOTG1_PMU		85
+#define CLK_USBOTG1_ADP			86
+#define PCLK_USBPHY			87
+#define ACLK_DMA2DDR			88
+#define PCLK_DMA2DDR			89
+#define STCLK_M0			90
+#define CLK_DDRPHY			91
+#define CLK_DDRC_SRC			92
+#define ACLK_DDRC_0			93
+#define ACLK_DDRC_1			94
+#define CLK_DDRC			95
+#define CLK_DDRMON			96
+#define HCLK_LSPERI_ROOT		97
+#define PCLK_LSPERI_ROOT		98
+#define PCLK_UART0			99
+#define PCLK_UART1			100
+#define PCLK_UART2			101
+#define PCLK_UART3			102
+#define PCLK_UART4			103
+#define SCLK_UART0			104
+#define SCLK_UART1			105
+#define SCLK_UART2			106
+#define SCLK_UART3			107
+#define SCLK_UART4			108
+#define PCLK_I2C0			109
+#define CLK_I2C0			110
+#define PCLK_I2C1			111
+#define CLK_I2C1			112
+#define PCLK_I2C2			113
+#define CLK_I2C2			114
+#define PCLK_PWM1			115
+#define CLK_PWM1			116
+#define CLK_OSC_PWM1			117
+#define CLK_RC_PWM1			118
+#define CLK_FREQ_PWM1			119
+#define CLK_COUNTER_PWM1		120
+#define PCLK_SPI0			121
+#define CLK_SPI0			122
+#define PCLK_SPI1			123
+#define CLK_SPI1			124
+#define PCLK_GPIO2			125
+#define DBCLK_GPIO2			126
+#define PCLK_GPIO3			127
+#define DBCLK_GPIO3			128
+#define PCLK_GPIO4			129
+#define DBCLK_GPIO4			130
+#define HCLK_CAN0			131
+#define CLK_CAN0			132
+#define HCLK_CAN1			133
+#define CLK_CAN1			134
+#define HCLK_PDM			135
+#define MCLK_PDM			136
+#define CLKOUT_PDM			137
+#define MCLK_SPDIFTX			138
+#define HCLK_SPDIFTX			139
+#define HCLK_SPDIFRX			140
+#define MCLK_SPDIFRX			141
+#define MCLK_SAI0			142
+#define HCLK_SAI0			143
+#define MCLK_OUT_SAI0			144
+#define MCLK_SAI1			145
+#define HCLK_SAI1			146
+#define MCLK_OUT_SAI1			147
+#define HCLK_ASRC0			148
+#define CLK_ASRC0			149
+#define HCLK_ASRC1			150
+#define CLK_ASRC1			151
+#define PCLK_CRU			152
+#define PCLK_PMU_ROOT			153
+#define MCLK_ASRC0			154
+#define MCLK_ASRC1			155
+#define MCLK_ASRC2			156
+#define MCLK_ASRC3			157
+#define LRCK_ASRC0_SRC			158
+#define LRCK_ASRC0_DST			159
+#define LRCK_ASRC1_SRC			160
+#define LRCK_ASRC1_DST			161
+#define ACLK_HSPERI_ROOT		162
+#define HCLK_HSPERI_ROOT		163
+#define PCLK_HSPERI_ROOT		164
+#define CCLK_SRC_SDMMC			165
+#define HCLK_SDMMC			166
+#define HCLK_FSPI			167
+#define SCLK_FSPI			168
+#define PCLK_SPI2			169
+#define ACLK_MAC0			170
+#define ACLK_MAC1			171
+#define PCLK_MAC0			172
+#define PCLK_MAC1			173
+#define CLK_MAC_ROOT			174
+#define CLK_MAC0			175
+#define CLK_MAC1			176
+#define MCLK_SAI2			177
+#define HCLK_SAI2			178
+#define MCLK_OUT_SAI2			179
+#define MCLK_SAI3_SRC			180
+#define HCLK_SAI3			181
+#define MCLK_SAI3			182
+#define MCLK_OUT_SAI3			183
+#define MCLK_SAI4_SRC			184
+#define HCLK_SAI4			185
+#define MCLK_SAI4			186
+#define HCLK_DSM			187
+#define MCLK_DSM			188
+#define PCLK_AUDIO_ADC			189
+#define MCLK_AUDIO_ADC			190
+#define MCLK_AUDIO_ADC_DIV4		191
+#define PCLK_SARADC			192
+#define CLK_SARADC			193
+#define PCLK_OTPC_NS			194
+#define CLK_SBPI_OTPC_NS		195
+#define CLK_USER_OTPC_NS		196
+#define PCLK_UART5			197
+#define SCLK_UART5			198
+#define PCLK_GPIO234_IOC		199
+#define CLK_MAC_PTP_ROOT		200
+#define CLK_MAC0_PTP			201
+#define CLK_MAC1_PTP			202
+#define CLK_SPI2			203
+#define ACLK_VIO_ROOT			204
+#define HCLK_VIO_ROOT			205
+#define PCLK_VIO_ROOT			206
+#define HCLK_RGA			207
+#define ACLK_RGA			208
+#define CLK_CORE_RGA			209
+#define ACLK_VOP			210
+#define HCLK_VOP			211
+#define DCLK_VOP			212
+#define PCLK_DPHY			213
+#define PCLK_DSI_HOST			214
+#define PCLK_TSADC			215
+#define CLK_TSADC			216
+#define CLK_TSADC_TSEN			217
+#define PCLK_GPIO1_IOC			218
+#define PCLK_OTPC_S			219
+#define CLK_SBPI_OTPC_S			220
+#define CLK_USER_OTPC_S			221
+#define PCLK_OTP_MASK			222
+#define PCLK_KEYREADER			223
+#define HCLK_BOOTROM			224
+#define PCLK_DDR_SERVICE		225
+#define HCLK_CRYPTO_S			226
+#define HCLK_KEYLAD			227
+#define CLK_CORE_CRYPTO			228
+#define CLK_PKA_CRYPTO			229
+#define CLK_CORE_CRYPTO_S		230
+#define CLK_PKA_CRYPTO_S		231
+#define ACLK_CRYPTO_S			232
+#define HCLK_RNG_S			233
+#define CLK_CORE_CRYPTO_NS		234
+#define CLK_PKA_CRYPTO_NS		235
+#define ACLK_CRYPTO_NS			236
+#define HCLK_CRYPTO_NS			237
+#define HCLK_RNG			238
+#define CLK_PMU				239
+#define PCLK_PMU			240
+#define CLK_PMU_32K			241
+#define PCLK_PMU_CRU			242
+#define PCLK_PMU_GRF			243
+#define PCLK_GPIO0_IOC			244
+#define PCLK_GPIO0			245
+#define DBCLK_GPIO0			246
+#define PCLK_GPIO1_SHADOW		247
+#define DBCLK_GPIO1_SHADOW		248
+#define PCLK_PMU_HP_TIMER		249
+#define CLK_PMU_HP_TIMER		250
+#define CLK_PMU_HP_TIMER_32K		251
+#define PCLK_PWM0			252
+#define CLK_PWM0			253
+#define CLK_OSC_PWM0			254
+#define CLK_RC_PWM0			255
+#define CLK_MAC_OUT			256
+#define CLK_REF_OUT0			257
+#define CLK_REF_OUT1			258
+#define CLK_32K_FRAC			259
+#define CLK_32K_RC			260
+#define CLK_32K				261
+#define CLK_32K_PMU			262
+#define PCLK_TOUCH_KEY			263
+#define CLK_TOUCH_KEY			264
+#define CLK_REF_PHY_PLL			265
+#define CLK_REF_PHY_PMU_MUX		266
+#define CLK_WIFI_OUT			267
+#define CLK_V0PLL_REF			268
+#define CLK_V1PLL_REF			269
+#define CLK_32K_FRAC_MUX		270
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


