Return-Path: <linux-kernel+bounces-894539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D4DC4B43B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763BC1891ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB2B34A764;
	Tue, 11 Nov 2025 02:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="K395m92T"
Received: from mail-m32110.qiye.163.com (mail-m32110.qiye.163.com [220.197.32.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2798934676F;
	Tue, 11 Nov 2025 02:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829876; cv=none; b=mxla1FU23Fg5f+IjRpBJWFOCLkKuRPMbJjUnrZvS28P7Rw1BLYW0zvL5FTfRF0a7wJ9rOx1Tt1MC6XXv/tAvMPCSQWvlTY2gYJ6zzvpIppVSnlEt0FyZ1YJy/RbxFa/ZZPKxq5/X48BdBi3SKnTOVopxa3DaWN6EXTGtkQPxE+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829876; c=relaxed/simple;
	bh=1ujk2q48WiObtM3WlblydrhRScm8tyE+VGiKUMhcyOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sTyAEZwAX5guqJmwDjOpSDOY7uKo6We9m9cWo89NDzIUPj/Lf4PKYbxCKKtAt2QFWvw/mpdIhNysXRRGczHNOQL27Ucj+d7vDWwTuShiMPPQkNcf8gDNXjInZlSXudI30CmEUPARqx8UM1OtsHgfznhaqKWgzTC8FPfBs7gpDXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=K395m92T; arc=none smtp.client-ip=220.197.32.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 291f57ba8;
	Tue, 11 Nov 2025 10:57:42 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	zhangqing@rock-chips.com,
	heiko@sntech.de,
	robh@kernel.org,
	p.zabel@pengutronix.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	finley.xiao@rock-chips.com,
	sugar.zhang@rock-chips.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 2/5] dt-bindings: clock, reset: Add support for rv1126b
Date: Tue, 11 Nov 2025 10:57:35 +0800
Message-Id: <20251111025738.869847-3-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111025738.869847-1-zhangqing@rock-chips.com>
References: <20251111025738.869847-1-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a70d9079703a3kunmb98a0103a1311
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk0eQ1ZKSUhKSkMZSk4dThlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=K395m92Ts4wgiUGmtsNnvU9Vy+K5VjD1cIB9gVHluX4OnGFsFeXvLP768WLXjGQRbPgpXtKabbzNHFXVReP9yFV5gQ9PkDM6cIVywsz4RYL0ZeyGZvJC29dfkKM1s7Mrhbglmja9R9VDgJQEbiJYbOTVKoKIeAH6ffsnhMm+C58=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=0nK/nwwYUraEKCC7SnOUVoDQvRCbRb5pqk4e87Zl/vk=;
	h=date:mime-version:subject:message-id:from;

Add clock and reset ID defines for rv1126b.
Also add documentation for the rv1126b CRU core.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/clock/rockchip,rv1126b-cru.yaml  |  52 +++
 .../dt-bindings/clock/rockchip,rv1126b-cru.h  | 392 +++++++++++++++++
 .../dt-bindings/reset/rockchip,rv1126b-cru.h  | 405 ++++++++++++++++++
 3 files changed, 849 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
 create mode 100644 include/dt-bindings/clock/rockchip,rv1126b-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rv1126b-cru.h

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
new file mode 100644
index 000000000000..04b0a5c51e4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rv1126b-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RV1126B Clock and Reset Unit
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description:
+  The rv1126b clock controller generates the clock and also implements a
+  reset controller for SoC peripherals.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rv1126b-cru
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
+    clock-controller@20000000 {
+      compatible = "rockchip,rv1126b-cru";
+      reg = <0x20000000 0xc0000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/rockchip,rv1126b-cru.h b/include/dt-bindings/clock/rockchip,rv1126b-cru.h
new file mode 100644
index 000000000000..721d50a1419f
--- /dev/null
+++ b/include/dt-bindings/clock/rockchip,rv1126b-cru.h
@@ -0,0 +1,392 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2025 Rockchip Electronics Co., Ltd.
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RV1126B_H
+#define _DT_BINDINGS_CLK_ROCKCHIP_RV1126B_H
+
+/* pll clocks */
+#define PLL_GPLL				0
+#define PLL_CPLL				1
+#define PLL_AUPLL				2
+#define ARMCLK					3
+#define SCLK_DDR				4
+
+/* clk (clocks) */
+#define CLK_CPLL_DIV20				5
+#define CLK_CPLL_DIV10				6
+#define CLK_CPLL_DIV8				7
+#define CLK_GPLL_DIV8				8
+#define CLK_GPLL_DIV6				9
+#define CLK_GPLL_DIV4				10
+#define CLK_CPLL_DIV3				11
+#define CLK_GPLL_DIV3				12
+#define CLK_CPLL_DIV2				13
+#define CLK_GPLL_DIV2				14
+#define CLK_CM_FRAC0				15
+#define CLK_CM_FRAC1				16
+#define CLK_CM_FRAC2				17
+#define CLK_UART_FRAC0				18
+#define CLK_UART_FRAC1				19
+#define CLK_AUDIO_FRAC0				20
+#define CLK_AUDIO_FRAC1				21
+#define CLK_AUDIO_INT0				22
+#define CLK_AUDIO_INT1				23
+#define SCLK_UART0_SRC				24
+#define SCLK_UART1				25
+#define SCLK_UART2				26
+#define SCLK_UART3				27
+#define SCLK_UART4				28
+#define SCLK_UART5				29
+#define SCLK_UART6				30
+#define SCLK_UART7				31
+#define MCLK_SAI0				32
+#define MCLK_SAI1				33
+#define MCLK_SAI2				34
+#define MCLK_PDM				35
+#define CLKOUT_PDM				36
+#define MCLK_ASRC0				37
+#define MCLK_ASRC1				38
+#define MCLK_ASRC2				39
+#define MCLK_ASRC3				40
+#define CLK_ASRC0				41
+#define CLK_ASRC1				42
+#define CLK_CORE_PLL				43
+#define CLK_NPU_PLL				44
+#define CLK_VEPU_PLL				45
+#define CLK_ISP_PLL				46
+#define CLK_AISP_PLL				47
+#define CLK_SARADC0_SRC				48
+#define CLK_SARADC1_SRC				49
+#define CLK_SARADC2_SRC				50
+#define HCLK_NPU_ROOT				51
+#define PCLK_NPU_ROOT				52
+#define ACLK_VEPU_ROOT				53
+#define HCLK_VEPU_ROOT				54
+#define PCLK_VEPU_ROOT				55
+#define CLK_CORE_RGA_SRC			56
+#define ACLK_GMAC_ROOT				57
+#define ACLK_VI_ROOT				58
+#define HCLK_VI_ROOT				59
+#define PCLK_VI_ROOT				60
+#define DCLK_VICAP_ROOT				61
+#define CLK_SYS_DSMC_ROOT			62
+#define ACLK_VDO_ROOT				63
+#define ACLK_RKVDEC_ROOT			64
+#define HCLK_VDO_ROOT				65
+#define PCLK_VDO_ROOT				66
+#define DCLK_OOC_SRC				67
+#define DCLK_VOP				68
+#define DCLK_DECOM_SRC				69
+#define PCLK_DDR_ROOT				70
+#define ACLK_SYSMEM_SRC				71
+#define ACLK_TOP_ROOT				72
+#define ACLK_BUS_ROOT				73
+#define HCLK_BUS_ROOT				74
+#define PCLK_BUS_ROOT				75
+#define CCLK_SDMMC0				76
+#define CCLK_SDMMC1				77
+#define CCLK_EMMC				78
+#define SCLK_2X_FSPI0				79
+#define CLK_GMAC_PTP_REF_SRC			80
+#define CLK_GMAC_125M				81
+#define CLK_TIMER_ROOT				82
+#define TCLK_WDT_NS_SRC				83
+#define TCLK_WDT_S_SRC				84
+#define TCLK_WDT_HPMCU				85
+#define CLK_CAN0				86
+#define CLK_CAN1				87
+#define PCLK_PERI_ROOT				88
+#define ACLK_PERI_ROOT				89
+#define CLK_I2C_BUS_SRC				90
+#define CLK_SPI0				91
+#define CLK_SPI1				92
+#define BUSCLK_PMU_SRC				93
+#define CLK_PWM0				94
+#define CLK_PWM2				95
+#define CLK_PWM3				96
+#define CLK_PKA_RKCE_SRC			97
+#define ACLK_RKCE_SRC				98
+#define ACLK_VCP_ROOT				99
+#define HCLK_VCP_ROOT				100
+#define PCLK_VCP_ROOT				101
+#define CLK_CORE_FEC_SRC			102
+#define CLK_CORE_AVSP_SRC			103
+#define CLK_50M_GMAC_IOBUF_VI			104
+#define PCLK_TOP_ROOT				105
+#define CLK_MIPI0_OUT2IO			106
+#define CLK_MIPI1_OUT2IO			107
+#define CLK_MIPI2_OUT2IO			108
+#define CLK_MIPI3_OUT2IO			109
+#define CLK_CIF_OUT2IO				110
+#define CLK_MAC_OUT2IO				111
+#define MCLK_SAI0_OUT2IO			112
+#define MCLK_SAI1_OUT2IO			113
+#define MCLK_SAI2_OUT2IO			114
+#define CLK_CM_FRAC0_SRC			115
+#define CLK_CM_FRAC1_SRC			116
+#define CLK_CM_FRAC2_SRC			117
+#define CLK_UART_FRAC0_SRC			118
+#define CLK_UART_FRAC1_SRC			119
+#define CLK_AUDIO_FRAC0_SRC			120
+#define CLK_AUDIO_FRAC1_SRC			121
+#define ACLK_NPU_ROOT				122
+#define HCLK_RKNN				123
+#define ACLK_RKNN				124
+#define PCLK_GPIO3				125
+#define DBCLK_GPIO3				126
+#define PCLK_IOC_VCCIO3				127
+#define PCLK_SARADC0				128
+#define CLK_SARADC0				129
+#define HCLK_SDMMC1				130
+#define HCLK_VEPU				131
+#define ACLK_VEPU				132
+#define CLK_CORE_VEPU				133
+#define HCLK_FEC				134
+#define ACLK_FEC				135
+#define CLK_CORE_FEC				136
+#define HCLK_AVSP				137
+#define ACLK_AVSP				138
+#define BUSCLK_PMU1_ROOT			139
+#define HCLK_AISP				140
+#define ACLK_AISP				141
+#define CLK_CORE_AISP				142
+#define CLK_CORE_ISP_ROOT			143
+#define PCLK_DSMC				144
+#define ACLK_DSMC				145
+#define HCLK_CAN0				146
+#define HCLK_CAN1				147
+#define PCLK_GPIO2				148
+#define DBCLK_GPIO2				149
+#define PCLK_GPIO4				150
+#define DBCLK_GPIO4				151
+#define PCLK_GPIO5				152
+#define DBCLK_GPIO5				153
+#define PCLK_GPIO6				154
+#define DBCLK_GPIO6				155
+#define PCLK_GPIO7				156
+#define DBCLK_GPIO7				157
+#define PCLK_IOC_VCCIO2				158
+#define PCLK_IOC_VCCIO4				159
+#define PCLK_IOC_VCCIO5				160
+#define PCLK_IOC_VCCIO6				161
+#define PCLK_IOC_VCCIO7				162
+#define HCLK_ISP				163
+#define ACLK_ISP				164
+#define CLK_CORE_ISP				165
+#define HCLK_VICAP				166
+#define ACLK_VICAP				167
+#define DCLK_VICAP				168
+#define ISP0CLK_VICAP				169
+#define HCLK_VPSS				170
+#define ACLK_VPSS				171
+#define CLK_CORE_VPSS				172
+#define PCLK_CSI2HOST0				173
+#define DCLK_CSI2HOST0				174
+#define PCLK_CSI2HOST1				175
+#define DCLK_CSI2HOST1				176
+#define PCLK_CSI2HOST2				177
+#define DCLK_CSI2HOST2				178
+#define PCLK_CSI2HOST3				179
+#define DCLK_CSI2HOST3				180
+#define HCLK_SDMMC0				181
+#define ACLK_GMAC				182
+#define PCLK_GMAC				183
+#define CLK_GMAC_PTP_REF			184
+#define PCLK_CSIPHY0				185
+#define PCLK_CSIPHY1				186
+#define PCLK_MACPHY				187
+#define PCLK_SARADC1				188
+#define CLK_SARADC1				189
+#define PCLK_SARADC2				190
+#define CLK_SARADC2				191
+#define ACLK_RKVDEC				192
+#define HCLK_RKVDEC				193
+#define CLK_HEVC_CA_RKVDEC			194
+#define ACLK_VOP				195
+#define HCLK_VOP				196
+#define HCLK_RKJPEG				197
+#define ACLK_RKJPEG				198
+#define ACLK_RKMMU_DECOM			199
+#define HCLK_RKMMU_DECOM			200
+#define DCLK_DECOM				201
+#define ACLK_DECOM				202
+#define PCLK_DECOM				203
+#define PCLK_MIPI_DSI				204
+#define PCLK_DSIPHY				205
+#define ACLK_OOC				206
+#define ACLK_SYSMEM				207
+#define PCLK_DDRC				208
+#define PCLK_DDRMON				209
+#define CLK_TIMER_DDRMON			210
+#define PCLK_DFICTRL				211
+#define PCLK_DDRPHY				212
+#define PCLK_DMA2DDR				213
+#define CLK_RCOSC_SRC				214
+#define BUSCLK_PMU_MUX				215
+#define BUSCLK_PMU_ROOT				216
+#define PCLK_PMU				217
+#define CLK_XIN_RC_DIV				218
+#define CLK_32K					219
+#define PCLK_PMU_GPIO0				220
+#define DBCLK_PMU_GPIO0				221
+#define PCLK_PMU_HP_TIMER			222
+#define CLK_PMU_HP_TIMER			223
+#define CLK_PMU_32K_HP_TIMER			224
+#define PCLK_PWM1				225
+#define CLK_PWM1				226
+#define CLK_OSC_PWM1				227
+#define CLK_RC_PWM1				228
+#define CLK_FREQ_PWM1				229
+#define CLK_COUNTER_PWM1			230
+#define PCLK_I2C2				231
+#define CLK_I2C2				232
+#define PCLK_UART0				233
+#define SCLK_UART0				234
+#define PCLK_RCOSC_CTRL				235
+#define CLK_OSC_RCOSC_CTRL			236
+#define CLK_REF_RCOSC_CTRL			237
+#define PCLK_IOC_PMUIO0				238
+#define CLK_REFOUT				239
+#define CLK_PREROLL				240
+#define CLK_PREROLL_32K				241
+#define HCLK_PMU_SRAM				242
+#define PCLK_WDT_LPMCU				243
+#define TCLK_WDT_LPMCU				244
+#define CLK_LPMCU				245
+#define CLK_LPMCU_RTC				246
+#define PCLK_LPMCU_MAILBOX			247
+#define HCLK_OOC				248
+#define PCLK_SPI2AHB				249
+#define HCLK_SPI2AHB				250
+#define HCLK_FSPI1				251
+#define HCLK_XIP_FSPI1				252
+#define SCLK_1X_FSPI1				253
+#define PCLK_IOC_PMUIO1				254
+#define PCLK_AUDIO_ADC_PMU			255
+#define MCLK_AUDIO_ADC_PMU			256
+#define MCLK_AUDIO_ADC_DIV4_PMU			257
+#define MCLK_LPSAI				258
+#define ACLK_GIC400				259
+#define PCLK_WDT_NS				260
+#define TCLK_WDT_NS				261
+#define PCLK_WDT_HPMCU				262
+#define HCLK_CACHE				263
+#define PCLK_HPMCU_MAILBOX			264
+#define PCLK_HPMCU_INTMUX			265
+#define CLK_HPMCU				266
+#define CLK_HPMCU_RTC				267
+#define PCLK_RKDMA				268
+#define ACLK_RKDMA				269
+#define PCLK_DCF				270
+#define ACLK_DCF				271
+#define HCLK_RGA				272
+#define ACLK_RGA				273
+#define CLK_CORE_RGA				274
+#define PCLK_TIMER				275
+#define CLK_TIMER0				276
+#define CLK_TIMER1				277
+#define CLK_TIMER2				278
+#define CLK_TIMER3				279
+#define CLK_TIMER4				280
+#define CLK_TIMER5				281
+#define PCLK_I2C0				282
+#define CLK_I2C0				283
+#define PCLK_I2C1				284
+#define CLK_I2C1				285
+#define PCLK_I2C3				286
+#define CLK_I2C3				287
+#define PCLK_I2C4				288
+#define CLK_I2C4				289
+#define PCLK_I2C5				290
+#define CLK_I2C5				291
+#define PCLK_SPI0				292
+#define PCLK_SPI1				293
+#define PCLK_PWM0				294
+#define CLK_OSC_PWM0				295
+#define CLK_RC_PWM0				296
+#define PCLK_PWM2				297
+#define CLK_OSC_PWM2				298
+#define CLK_RC_PWM2				299
+#define PCLK_PWM3				300
+#define CLK_OSC_PWM3				301
+#define CLK_RC_PWM3				302
+#define PCLK_UART1				303
+#define PCLK_UART2				304
+#define PCLK_UART3				305
+#define PCLK_UART4				306
+#define PCLK_UART5				307
+#define PCLK_UART6				308
+#define PCLK_UART7				309
+#define PCLK_TSADC				310
+#define CLK_TSADC				311
+#define HCLK_SAI0				312
+#define HCLK_SAI1				313
+#define HCLK_SAI2				314
+#define HCLK_RKDSM				315
+#define MCLK_RKDSM				316
+#define HCLK_PDM				317
+#define HCLK_ASRC0				318
+#define HCLK_ASRC1				319
+#define PCLK_AUDIO_ADC_BUS			320
+#define MCLK_AUDIO_ADC_BUS			321
+#define MCLK_AUDIO_ADC_DIV4_BUS			322
+#define PCLK_RKCE				323
+#define HCLK_NS_RKCE				324
+#define PCLK_OTPC_NS				325
+#define CLK_SBPI_OTPC_NS			326
+#define CLK_USER_OTPC_NS			327
+#define CLK_OTPC_ARB				328
+#define PCLK_OTP_MASK				329
+#define CLK_TSADC_PHYCTRL			330
+#define LRCK_SRC_ASRC0				331
+#define LRCK_DST_ASRC0				332
+#define LRCK_SRC_ASRC1				333
+#define LRCK_DST_ASRC1				334
+#define PCLK_KEY_READER				335
+#define ACLK_NSRKCE				336
+#define CLK_PKA_NSRKCE				337
+#define PCLK_RTC_ROOT				338
+#define PCLK_GPIO1				339
+#define DBCLK_GPIO1				340
+#define PCLK_IOC_VCCIO1				341
+#define ACLK_USB3OTG				342
+#define CLK_REF_USB3OTG				343
+#define CLK_SUSPEND_USB3OTG			344
+#define HCLK_USB2HOST				345
+#define HCLK_ARB_USB2HOST			346
+#define PCLK_RTC_TEST				347
+#define HCLK_EMMC				348
+#define HCLK_FSPI0				349
+#define HCLK_XIP_FSPI0				350
+#define PCLK_PIPEPHY				351
+#define PCLK_USB2PHY				352
+#define CLK_REF_PIPEPHY_CPLL_SRC		353
+#define CLK_REF_PIPEPHY				354
+#define HCLK_VPSL				355
+#define ACLK_VPSL				356
+#define CLK_CORE_VPSL				357
+#define CLK_MACPHY				358
+#define HCLK_RKRNG_NS				359
+#define HCLK_RKRNG_S_NS				360
+#define CLK_AISP_PLL_SRC			361
+
+/* secure clks */
+#define CLK_USER_OTPC_S				362
+#define CLK_SBPI_OTPC_S				363
+#define PCLK_OTPC_S				364
+#define PCLK_KEY_READER_S			365
+#define HCLK_KL_RKCE_S				366
+#define HCLK_RKCE_S				367
+#define PCLK_WDT_S				368
+#define TCLK_WDT_S				369
+#define CLK_STIMER0				370
+#define CLK_STIMER1				371
+#define PLK_STIMER				372
+#define HCLK_RKRNG_S				373
+#define CLK_PKA_RKCE_S				374
+#define ACLK_RKCE_S				375
+
+#endif
diff --git a/include/dt-bindings/reset/rockchip,rv1126b-cru.h b/include/dt-bindings/reset/rockchip,rv1126b-cru.h
new file mode 100644
index 000000000000..a7712db319d0
--- /dev/null
+++ b/include/dt-bindings/reset/rockchip,rv1126b-cru.h
@@ -0,0 +1,405 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2025 Rockchip Electronics Co., Ltd.
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_ROCKCHIP_RV1126B_H
+#define _DT_BINDINGS_RESET_ROCKCHIP_RV1126B_H
+
+/* ==========================list all of reset fields id=========================== */
+/* TOPCRU-->SOFTRST_CON00 */
+
+/* TOPCRU-->SOFTRST_CON15 */
+#define SRST_P_CRU				0
+#define SRST_P_CRU_BIU				1
+
+/* BUSCRU-->SOFTRST_CON00 */
+#define SRST_A_TOP_BIU				2
+#define SRST_A_RKCE_BIU				3
+#define SRST_A_BUS_BIU				4
+#define SRST_H_BUS_BIU				5
+#define SRST_P_BUS_BIU				6
+#define SRST_P_CRU_BUS				7
+#define SRST_P_SYS_GRF				8
+#define SRST_H_BOOTROM				9
+#define SRST_A_GIC400				10
+#define SRST_A_SPINLOCK				11
+#define SRST_P_WDT_NS				12
+#define SRST_T_WDT_NS				13
+
+/* BUSCRU-->SOFTRST_CON01 */
+#define SRST_P_WDT_HPMCU			14
+#define SRST_T_WDT_HPMCU			15
+#define SRST_H_CACHE				16
+#define SRST_P_HPMCU_MAILBOX			17
+#define SRST_P_HPMCU_INTMUX			18
+#define SRST_HPMCU_FULL_CLUSTER			19
+#define SRST_HPMCU_PWUP				20
+#define SRST_HPMCU_ONLY_CORE			21
+#define SRST_T_HPMCU_JTAG			22
+#define SRST_P_RKDMA				23
+#define SRST_A_RKDMA				24
+
+/* BUSCRU-->SOFTRST_CON02 */
+#define SRST_P_DCF				25
+#define SRST_A_DCF				26
+#define SRST_H_RGA				27
+#define SRST_A_RGA				28
+#define SRST_CORE_RGA				29
+#define SRST_P_TIMER				30
+#define SRST_TIMER0				31
+#define SRST_TIMER1				32
+#define SRST_TIMER2				33
+#define SRST_TIMER3				34
+#define SRST_TIMER4				35
+#define SRST_TIMER5				36
+#define SRST_A_RKCE				37
+#define SRST_PKA_RKCE				38
+#define SRST_H_RKRNG_S				39
+#define SRST_H_RKRNG_NS				40
+
+/* BUSCRU-->SOFTRST_CON03 */
+#define SRST_P_I2C0				41
+#define SRST_I2C0				42
+#define SRST_P_I2C1				43
+#define SRST_I2C1				44
+#define SRST_P_I2C3				45
+#define SRST_I2C3				46
+#define SRST_P_I2C4				47
+#define SRST_I2C4				48
+#define SRST_P_I2C5				49
+#define SRST_I2C5				50
+#define SRST_P_SPI0				51
+#define SRST_SPI0				52
+#define SRST_P_SPI1				53
+#define SRST_SPI1				54
+
+/* BUSCRU-->SOFTRST_CON04 */
+#define SRST_P_PWM0				55
+#define SRST_PWM0				56
+#define SRST_P_PWM2				57
+#define SRST_PWM2				58
+#define SRST_P_PWM3				59
+#define SRST_PWM3				60
+
+/* BUSCRU-->SOFTRST_CON05 */
+#define SRST_P_UART1				61
+#define SRST_S_UART1				62
+#define SRST_P_UART2				63
+#define SRST_S_UART2				64
+#define SRST_P_UART3				65
+#define SRST_S_UART3				66
+#define SRST_P_UART4				67
+#define SRST_S_UART4				68
+#define SRST_P_UART5				69
+#define SRST_S_UART5				70
+#define SRST_P_UART6				71
+#define SRST_S_UART6				72
+#define SRST_P_UART7				73
+#define SRST_S_UART7				74
+
+/* BUSCRU-->SOFTRST_CON06 */
+#define SRST_P_TSADC				75
+#define SRST_TSADC				76
+#define SRST_H_SAI0				77
+#define SRST_M_SAI0				78
+#define SRST_H_SAI1				79
+#define SRST_M_SAI1				80
+#define SRST_H_SAI2				81
+#define SRST_M_SAI2				82
+#define SRST_H_RKDSM				83
+#define SRST_M_RKDSM				84
+#define SRST_H_PDM				85
+#define SRST_M_PDM				86
+#define SRST_PDM				87
+
+/* BUSCRU-->SOFTRST_CON07 */
+#define SRST_H_ASRC0				88
+#define SRST_ASRC0				89
+#define SRST_H_ASRC1				90
+#define SRST_ASRC1				91
+#define SRST_P_AUDIO_ADC_BUS			92
+#define SRST_M_AUDIO_ADC_BUS			93
+#define SRST_P_RKCE				94
+#define SRST_H_NS_RKCE				95
+#define SRST_P_OTPC_NS				96
+#define SRST_SBPI_OTPC_NS			97
+#define SRST_USER_OTPC_NS			98
+#define SRST_OTPC_ARB				99
+#define SRST_P_OTP_MASK				100
+
+/* PERICRU-->SOFTRST_CON00 */
+#define SRST_A_PERI_BIU				101
+#define SRST_P_PERI_BIU				102
+#define SRST_P_RTC_BIU				103
+#define SRST_P_CRU_PERI				104
+#define SRST_P_PERI_GRF				105
+#define SRST_P_GPIO1				106
+#define SRST_DB_GPIO1				107
+#define SRST_P_IOC_VCCIO1			108
+#define SRST_A_USB3OTG				109
+#define SRST_H_USB2HOST				110
+#define SRST_H_ARB_USB2HOST			111
+#define SRST_P_RTC_TEST				112
+
+/* PERICRU-->SOFTRST_CON01 */
+#define SRST_H_EMMC				113
+#define SRST_H_FSPI0				114
+#define SRST_H_XIP_FSPI0			115
+#define SRST_S_2X_FSPI0				116
+#define SRST_UTMI_USB2HOST			117
+#define SRST_REF_PIPEPHY			118
+#define SRST_P_PIPEPHY				119
+#define SRST_P_PIPEPHY_GRF			120
+#define SRST_P_USB2PHY				121
+#define SRST_POR_USB2PHY			122
+#define SRST_OTG_USB2PHY			123
+#define SRST_HOST_USB2PHY			124
+
+/* CORECRU-->SOFTRST_CON00 */
+#define SRST_REF_PVTPLL_CORE			125
+#define SRST_NCOREPORESET0			126
+#define SRST_NCORESET0				127
+#define SRST_NCOREPORESET1			128
+#define SRST_NCORESET1				129
+#define SRST_NCOREPORESET2			130
+#define SRST_NCORESET2				131
+#define SRST_NCOREPORESET3			132
+#define SRST_NCORESET3				133
+#define SRST_NDBGRESET				134
+#define SRST_NL2RESET				135
+
+/* CORECRU-->SOFTRST_CON01 */
+#define SRST_A_CORE_BIU				136
+#define SRST_P_CORE_BIU				137
+#define SRST_H_CORE_BIU				138
+#define SRST_P_DBG				139
+#define SRST_POT_DBG				140
+#define SRST_NT_DBG				141
+#define SRST_P_CORE_PVTPLL			142
+#define SRST_P_CRU_CORE				143
+#define SRST_P_CORE_GRF				144
+#define SRST_P_DFT2APB				145
+
+/* PMUCRU-->SOFTRST_CON00 */
+#define SRST_H_PMU_BIU				146
+#define SRST_P_PMU_GPIO0			147
+#define SRST_DB_PMU_GPIO0			148
+#define SRST_P_PMU_HP_TIMER			149
+#define SRST_PMU_HP_TIMER			150
+#define SRST_PMU_32K_HP_TIMER			151
+
+/* PMUCRU-->SOFTRST_CON01 */
+#define SRST_P_PWM1				152
+#define SRST_PWM1				153
+#define SRST_P_I2C2				154
+#define SRST_I2C2				155
+#define SRST_P_UART0				156
+#define SRST_S_UART0				157
+
+/* PMUCRU-->SOFTRST_CON02 */
+#define SRST_P_RCOSC_CTRL			158
+#define SRST_REF_RCOSC_CTRL			159
+#define SRST_P_IOC_PMUIO0			160
+#define SRST_P_CRU_PMU				161
+#define SRST_P_PMU_GRF				162
+#define SRST_PREROLL				163
+#define SRST_PREROLL_32K			164
+#define SRST_H_PMU_SRAM				165
+
+/* PMUCRU-->SOFTRST_CON03 */
+#define SRST_P_WDT_LPMCU			166
+#define SRST_T_WDT_LPMCU			167
+#define SRST_LPMCU_FULL_CLUSTER			168
+#define SRST_LPMCU_PWUP				169
+#define SRST_LPMCU_ONLY_CORE			170
+#define SRST_T_LPMCU_JTAG			171
+#define SRST_P_LPMCU_MAILBOX			172
+
+/* PMU1CRU-->SOFTRST_CON00 */
+#define SRST_P_SPI2AHB				173
+#define SRST_H_SPI2AHB				174
+#define SRST_H_FSPI1				175
+#define SRST_H_XIP_FSPI1			176
+#define SRST_S_1X_FSPI1				177
+#define SRST_P_IOC_PMUIO1			178
+#define SRST_P_CRU_PMU1				179
+#define SRST_P_AUDIO_ADC_PMU			180
+#define SRST_M_AUDIO_ADC_PMU			181
+#define SRST_H_PMU1_BIU				182
+
+/* PMU1CRU-->SOFTRST_CON01 */
+#define SRST_P_LPDMA				183
+#define SRST_A_LPDMA				184
+#define SRST_H_LPSAI				185
+#define SRST_M_LPSAI				186
+#define SRST_P_AOA_TDD				187
+#define SRST_P_AOA_FE				188
+#define SRST_P_AOA_AAD				189
+#define SRST_P_AOA_APB				190
+#define SRST_P_AOA_SRAM				191
+
+/* DDRCRU-->SOFTRST_CON00 */
+#define SRST_P_DDR_BIU				192
+#define SRST_P_DDRC				193
+#define SRST_P_DDRMON				194
+#define SRST_TIMER_DDRMON			195
+#define SRST_P_DFICTRL				196
+#define SRST_P_DDR_GRF				197
+#define SRST_P_CRU_DDR				198
+#define SRST_P_DDRPHY				199
+#define SRST_P_DMA2DDR				200
+
+/* SUBDDRCRU-->SOFTRST_CON00 */
+#define SRST_A_SYSMEM_BIU			201
+#define SRST_A_SYSMEM				202
+#define SRST_A_DDR_BIU				203
+#define SRST_A_DDRSCH0_CPU			204
+#define SRST_A_DDRSCH1_NPU			205
+#define SRST_A_DDRSCH2_POE			206
+#define SRST_A_DDRSCH3_VI			207
+#define SRST_CORE_DDRC				208
+#define SRST_DDRMON				209
+#define SRST_DFICTRL				210
+#define SRST_RS					211
+#define SRST_A_DMA2DDR				212
+#define SRST_DDRPHY				213
+
+/* VICRU-->SOFTRST_CON00 */
+#define SRST_REF_PVTPLL_ISP			214
+#define SRST_A_GMAC_BIU				215
+#define SRST_A_VI_BIU				216
+#define SRST_H_VI_BIU				217
+#define SRST_P_VI_BIU				218
+#define SRST_P_CRU_VI				219
+#define SRST_P_VI_GRF				220
+#define SRST_P_VI_PVTPLL			221
+#define SRST_P_DSMC				222
+#define SRST_A_DSMC				223
+#define SRST_H_CAN0				224
+#define SRST_CAN0				225
+#define SRST_H_CAN1				226
+#define SRST_CAN1				227
+
+/* VICRU-->SOFTRST_CON01 */
+#define SRST_P_GPIO2				228
+#define SRST_DB_GPIO2				229
+#define SRST_P_GPIO4				230
+#define SRST_DB_GPIO4				231
+#define SRST_P_GPIO5				232
+#define SRST_DB_GPIO5				233
+#define SRST_P_GPIO6				234
+#define SRST_DB_GPIO6				235
+#define SRST_P_GPIO7				236
+#define SRST_DB_GPIO7				237
+#define SRST_P_IOC_VCCIO2			238
+#define SRST_P_IOC_VCCIO4			239
+#define SRST_P_IOC_VCCIO5			240
+#define SRST_P_IOC_VCCIO6			241
+#define SRST_P_IOC_VCCIO7			242
+
+/* VICRU-->SOFTRST_CON02 */
+#define SRST_CORE_ISP				243
+#define SRST_H_VICAP				244
+#define SRST_A_VICAP				245
+#define SRST_D_VICAP				246
+#define SRST_ISP0_VICAP				247
+#define SRST_CORE_VPSS				248
+#define SRST_CORE_VPSL				249
+#define SRST_P_CSI2HOST0			250
+#define SRST_P_CSI2HOST1			251
+#define SRST_P_CSI2HOST2			252
+#define SRST_P_CSI2HOST3			253
+#define SRST_H_SDMMC0				254
+#define SRST_A_GMAC				255
+#define SRST_P_CSIPHY0				256
+#define SRST_P_CSIPHY1				257
+
+/* VICRU-->SOFTRST_CON03 */
+#define SRST_P_MACPHY				258
+#define SRST_MACPHY				259
+#define SRST_P_SARADC1				260
+#define SRST_SARADC1				261
+#define SRST_P_SARADC2				262
+#define SRST_SARADC2				263
+
+/* VEPUCRU-->SOFTRST_CON00 */
+#define SRST_REF_PVTPLL_VEPU			264
+#define SRST_A_VEPU_BIU				265
+#define SRST_H_VEPU_BIU				266
+#define SRST_P_VEPU_BIU				267
+#define SRST_P_CRU_VEPU				268
+#define SRST_P_VEPU_GRF				269
+#define SRST_P_GPIO3				270
+#define SRST_DB_GPIO3				271
+#define SRST_P_IOC_VCCIO3			272
+#define SRST_P_SARADC0				273
+#define SRST_SARADC0				274
+#define SRST_H_SDMMC1				275
+
+/* VEPUCRU-->SOFTRST_CON01 */
+#define SRST_P_VEPU_PVTPLL			276
+#define SRST_H_VEPU				277
+#define SRST_A_VEPU				278
+#define SRST_CORE_VEPU				279
+
+/* NPUCRU-->SOFTRST_CON00 */
+#define SRST_REF_PVTPLL_NPU			280
+#define SRST_A_NPU_BIU				281
+#define SRST_H_NPU_BIU				282
+#define SRST_P_NPU_BIU				283
+#define SRST_P_CRU_NPU				284
+#define SRST_P_NPU_GRF				285
+#define SRST_P_NPU_PVTPLL			286
+#define SRST_H_RKNN				287
+#define SRST_A_RKNN				288
+
+/* VDOCRU-->SOFTRST_CON00 */
+#define SRST_A_RKVDEC_BIU			289
+#define SRST_A_VDO_BIU				290
+#define SRST_H_VDO_BIU				291
+#define SRST_P_VDO_BIU				292
+#define SRST_P_CRU_VDO				293
+#define SRST_P_VDO_GRF				294
+#define SRST_A_RKVDEC				295
+#define SRST_H_RKVDEC				296
+#define SRST_HEVC_CA_RKVDEC			297
+#define SRST_A_VOP				298
+#define SRST_H_VOP				299
+#define SRST_D_VOP				300
+#define SRST_A_OOC				301
+#define SRST_H_OOC				302
+#define SRST_D_OOC				303
+
+/* VDOCRU-->SOFTRST_CON01 */
+#define SRST_H_RKJPEG				304
+#define SRST_A_RKJPEG				305
+#define SRST_A_RKMMU_DECOM			306
+#define SRST_H_RKMMU_DECOM			307
+#define SRST_D_DECOM				308
+#define SRST_A_DECOM				309
+#define SRST_P_DECOM				310
+#define SRST_P_MIPI_DSI				311
+#define SRST_P_DSIPHY				312
+
+/* VCPCRU-->SOFTRST_CON00 */
+#define SRST_REF_PVTPLL_VCP			313
+#define SRST_A_VCP_BIU				314
+#define SRST_H_VCP_BIU				315
+#define SRST_P_VCP_BIU				316
+#define SRST_P_CRU_VCP				317
+#define SRST_P_VCP_GRF				318
+#define SRST_P_VCP_PVTPLL			319
+#define SRST_A_AISP_BIU				320
+#define SRST_H_AISP_BIU				321
+#define SRST_CORE_AISP				322
+
+/* VCPCRU-->SOFTRST_CON01 */
+#define SRST_H_FEC				323
+#define SRST_A_FEC				324
+#define SRST_CORE_FEC				325
+#define SRST_H_AVSP				326
+#define SRST_A_AVSP				327
+
+#endif
-- 
2.34.1


