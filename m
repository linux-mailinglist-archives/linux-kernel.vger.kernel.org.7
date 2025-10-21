Return-Path: <linux-kernel+bounces-862252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8027BF4C77
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C21466F13
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A634626F478;
	Tue, 21 Oct 2025 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="E8yxhBpc"
Received: from mail-m15566.qiye.163.com (mail-m15566.qiye.163.com [101.71.155.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC625C822;
	Tue, 21 Oct 2025 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029879; cv=none; b=vAYyetlrd6rlVz0Ve7S3V9rboxe83BoluEu7gDZ462ij199VHGZ4AYL2BjZMyA7zVQcXRKWBQQDWnuMxEES9oXwL0tXAOmoOGvmkQT4F6jaUmUXubwlTTMJyyB16wTuEwHW50ONLIhsoFurctJckex73eyO8qwwSOdIjIImHUmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029879; c=relaxed/simple;
	bh=81kVAdJzgPW2D0svZ7otIefkT8c+BwtATsJR5+KAVr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FSFeERcAOsIzBxluHUI785PdBdPrGoSQiVy+IEU1VLlS9+5P63F1dWsyr7oYxmEqV6A/XJnRZMlQuX8r3tA0soW6ho9ZYNQTSbOJPSgTPUiFY/YH6vmUuaSvP9l6MjuoTOQmlvusBpGZAT4swMgBr4kCLvif/ciLGUe79WUwns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=E8yxhBpc; arc=none smtp.client-ip=101.71.155.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 269f91a34;
	Tue, 21 Oct 2025 14:52:37 +0800 (GMT+08:00)
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
	finley.xiao@rock-chips.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 2/7] dt-bindings: clock, reset: Add support for rv1126b
Date: Tue, 21 Oct 2025 14:52:27 +0800
Message-Id: <20251021065232.2201500-3-zhangqing@rock-chips.com>
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
X-HM-Tid: 0a9a058a8c5c03a3kunm647d21e85ed735
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhgfGlZLGE5MHx8fSB0aThhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=E8yxhBpcYcY7n86qGM4YwpWDXMLPfbHbO4jce8Ykk/u1fNibV0soKOCWjS0PWpClOoagOfK+lJPWcFMQRTOrED1sgbq4Kveu39n60fbihEZ2QCC8lJo7GByocbS9oAOKXPehpKf9dhjJAvmJWEckWDvZt2BeuTaBZynf0rxZqtU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=WIM++XL4CmETMnFAcAqcW/G+z2snkDGveVCgCNkGMzQ=;
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
index 000000000000..d6040058c21f
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
+#define PLL_GPLL				1
+#define PLL_CPLL				2
+#define PLL_AUPLL				3
+#define ARMCLK					4
+#define SCLK_DDR				5
+
+/* clk (clocks) */
+#define CLK_CPLL_DIV20				8
+#define CLK_CPLL_DIV10				9
+#define CLK_CPLL_DIV8				10
+#define CLK_GPLL_DIV8				11
+#define CLK_GPLL_DIV6				12
+#define CLK_GPLL_DIV4				13
+#define CLK_CPLL_DIV3				14
+#define CLK_GPLL_DIV3				15
+#define CLK_CPLL_DIV2				16
+#define CLK_GPLL_DIV2				17
+#define CLK_CM_FRAC0				18
+#define CLK_CM_FRAC1				19
+#define CLK_CM_FRAC2				20
+#define CLK_UART_FRAC0				21
+#define CLK_UART_FRAC1				22
+#define CLK_AUDIO_FRAC0				23
+#define CLK_AUDIO_FRAC1				24
+#define CLK_AUDIO_INT0				25
+#define CLK_AUDIO_INT1				26
+#define SCLK_UART0_SRC				27
+#define SCLK_UART1				28
+#define SCLK_UART2				29
+#define SCLK_UART3				30
+#define SCLK_UART4				31
+#define SCLK_UART5				32
+#define SCLK_UART6				33
+#define SCLK_UART7				34
+#define MCLK_SAI0				35
+#define MCLK_SAI1				36
+#define MCLK_SAI2				37
+#define MCLK_PDM				38
+#define CLKOUT_PDM				39
+#define MCLK_ASRC0				40
+#define MCLK_ASRC1				41
+#define MCLK_ASRC2				42
+#define MCLK_ASRC3				43
+#define CLK_ASRC0				44
+#define CLK_ASRC1				45
+#define CLK_CORE_PLL				46
+#define CLK_NPU_PLL				47
+#define CLK_VEPU_PLL				48
+#define CLK_ISP_PLL				49
+#define CLK_AISP_PLL				50
+#define CLK_SARADC0_SRC				51
+#define CLK_SARADC1_SRC				52
+#define CLK_SARADC2_SRC				53
+#define HCLK_NPU_ROOT				54
+#define PCLK_NPU_ROOT				55
+#define ACLK_VEPU_ROOT				56
+#define HCLK_VEPU_ROOT				57
+#define PCLK_VEPU_ROOT				58
+#define CLK_CORE_RGA_SRC			59
+#define ACLK_GMAC_ROOT				60
+#define ACLK_VI_ROOT				61
+#define HCLK_VI_ROOT				62
+#define PCLK_VI_ROOT				63
+#define DCLK_VICAP_ROOT				64
+#define CLK_SYS_DSMC_ROOT			65
+#define ACLK_VDO_ROOT				66
+#define ACLK_RKVDEC_ROOT			67
+#define HCLK_VDO_ROOT				68
+#define PCLK_VDO_ROOT				69
+#define DCLK_OOC_SRC				70
+#define DCLK_VOP				71
+#define DCLK_DECOM_SRC				72
+#define PCLK_DDR_ROOT				73
+#define ACLK_SYSMEM_SRC				74
+#define ACLK_TOP_ROOT				75
+#define ACLK_BUS_ROOT				76
+#define HCLK_BUS_ROOT				77
+#define PCLK_BUS_ROOT				78
+#define CCLK_SDMMC0				79
+#define CCLK_SDMMC1				80
+#define CCLK_EMMC				81
+#define SCLK_2X_FSPI0				82
+#define CLK_GMAC_PTP_REF_SRC			83
+#define CLK_GMAC_125M				84
+#define CLK_TIMER_ROOT				85
+#define TCLK_WDT_NS_SRC				86
+#define TCLK_WDT_S_SRC				87
+#define TCLK_WDT_HPMCU				88
+#define CLK_CAN0				89
+#define CLK_CAN1				90
+#define PCLK_PERI_ROOT				91
+#define ACLK_PERI_ROOT				92
+#define CLK_I2C_BUS_SRC				93
+#define CLK_SPI0				94
+#define CLK_SPI1				95
+#define BUSCLK_PMU_SRC				96
+#define CLK_PWM0				97
+#define CLK_PWM2				98
+#define CLK_PWM3				99
+#define CLK_PKA_RKCE_SRC			100
+#define ACLK_RKCE_SRC				101
+#define ACLK_VCP_ROOT				102
+#define HCLK_VCP_ROOT				103
+#define PCLK_VCP_ROOT				104
+#define CLK_CORE_FEC_SRC			105
+#define CLK_CORE_AVSP_SRC			106
+#define CLK_50M_GMAC_IOBUF_VI			107
+#define PCLK_TOP_ROOT				108
+#define CLK_MIPI0_OUT2IO			109
+#define CLK_MIPI1_OUT2IO			110
+#define CLK_MIPI2_OUT2IO			111
+#define CLK_MIPI3_OUT2IO			112
+#define CLK_CIF_OUT2IO				113
+#define CLK_MAC_OUT2IO				114
+#define MCLK_SAI0_OUT2IO			115
+#define MCLK_SAI1_OUT2IO			116
+#define MCLK_SAI2_OUT2IO			117
+#define CLK_CM_FRAC0_SRC			118
+#define CLK_CM_FRAC1_SRC			119
+#define CLK_CM_FRAC2_SRC			120
+#define CLK_UART_FRAC0_SRC			121
+#define CLK_UART_FRAC1_SRC			122
+#define CLK_AUDIO_FRAC0_SRC			123
+#define CLK_AUDIO_FRAC1_SRC			124
+#define ACLK_NPU_ROOT				125
+#define HCLK_RKNN				126
+#define ACLK_RKNN				127
+#define PCLK_GPIO3				128
+#define DBCLK_GPIO3				129
+#define PCLK_IOC_VCCIO3				130
+#define PCLK_SARADC0				131
+#define CLK_SARADC0				132
+#define HCLK_SDMMC1				133
+#define HCLK_VEPU				134
+#define ACLK_VEPU				135
+#define CLK_CORE_VEPU				136
+#define HCLK_FEC				137
+#define ACLK_FEC				138
+#define CLK_CORE_FEC				139
+#define HCLK_AVSP				140
+#define ACLK_AVSP				141
+#define BUSCLK_PMU1_ROOT			142
+#define HCLK_AISP				143
+#define ACLK_AISP				144
+#define CLK_CORE_AISP				145
+#define CLK_CORE_ISP_ROOT			146
+#define PCLK_DSMC				147
+#define ACLK_DSMC				148
+#define HCLK_CAN0				149
+#define HCLK_CAN1				150
+#define PCLK_GPIO2				151
+#define DBCLK_GPIO2				152
+#define PCLK_GPIO4				153
+#define DBCLK_GPIO4				154
+#define PCLK_GPIO5				155
+#define DBCLK_GPIO5				156
+#define PCLK_GPIO6				157
+#define DBCLK_GPIO6				158
+#define PCLK_GPIO7				159
+#define DBCLK_GPIO7				160
+#define PCLK_IOC_VCCIO2				161
+#define PCLK_IOC_VCCIO4				162
+#define PCLK_IOC_VCCIO5				163
+#define PCLK_IOC_VCCIO6				164
+#define PCLK_IOC_VCCIO7				165
+#define HCLK_ISP				166
+#define ACLK_ISP				167
+#define CLK_CORE_ISP				168
+#define HCLK_VICAP				169
+#define ACLK_VICAP				170
+#define DCLK_VICAP				171
+#define ISP0CLK_VICAP				172
+#define HCLK_VPSS				173
+#define ACLK_VPSS				174
+#define CLK_CORE_VPSS				175
+#define PCLK_CSI2HOST0				176
+#define DCLK_CSI2HOST0				177
+#define PCLK_CSI2HOST1				178
+#define DCLK_CSI2HOST1				179
+#define PCLK_CSI2HOST2				180
+#define DCLK_CSI2HOST2				181
+#define PCLK_CSI2HOST3				182
+#define DCLK_CSI2HOST3				183
+#define HCLK_SDMMC0				184
+#define ACLK_GMAC				185
+#define PCLK_GMAC				186
+#define CLK_GMAC_PTP_REF			187
+#define PCLK_CSIPHY0				188
+#define PCLK_CSIPHY1				189
+#define PCLK_MACPHY				190
+#define PCLK_SARADC1				191
+#define CLK_SARADC1				192
+#define PCLK_SARADC2				193
+#define CLK_SARADC2				194
+#define ACLK_RKVDEC				195
+#define HCLK_RKVDEC				196
+#define CLK_HEVC_CA_RKVDEC			197
+#define ACLK_VOP				198
+#define HCLK_VOP				199
+#define HCLK_RKJPEG				200
+#define ACLK_RKJPEG				201
+#define ACLK_RKMMU_DECOM			202
+#define HCLK_RKMMU_DECOM			203
+#define DCLK_DECOM				204
+#define ACLK_DECOM				205
+#define PCLK_DECOM				206
+#define PCLK_MIPI_DSI				207
+#define PCLK_DSIPHY				208
+#define ACLK_OOC				209
+#define ACLK_SYSMEM				210
+#define PCLK_DDRC				211
+#define PCLK_DDRMON				212
+#define CLK_TIMER_DDRMON			213
+#define PCLK_DFICTRL				214
+#define PCLK_DDRPHY				215
+#define PCLK_DMA2DDR				216
+#define CLK_RCOSC_SRC				217
+#define BUSCLK_PMU_MUX				218
+#define BUSCLK_PMU_ROOT				219
+#define PCLK_PMU				220
+#define CLK_XIN_RC_DIV				221
+#define CLK_32K					222
+#define PCLK_PMU_GPIO0				223
+#define DBCLK_PMU_GPIO0				224
+#define PCLK_PMU_HP_TIMER			225
+#define CLK_PMU_HP_TIMER			226
+#define CLK_PMU_32K_HP_TIMER			227
+#define PCLK_PWM1				228
+#define CLK_PWM1				229
+#define CLK_OSC_PWM1				230
+#define CLK_RC_PWM1				231
+#define CLK_FREQ_PWM1				232
+#define CLK_COUNTER_PWM1			233
+#define PCLK_I2C2				234
+#define CLK_I2C2				235
+#define PCLK_UART0				236
+#define SCLK_UART0				237
+#define PCLK_RCOSC_CTRL				238
+#define CLK_OSC_RCOSC_CTRL			239
+#define CLK_REF_RCOSC_CTRL			240
+#define PCLK_IOC_PMUIO0				241
+#define CLK_REFOUT				242
+#define CLK_PREROLL				243
+#define CLK_PREROLL_32K				244
+#define HCLK_PMU_SRAM				245
+#define PCLK_WDT_LPMCU				246
+#define TCLK_WDT_LPMCU				247
+#define CLK_LPMCU				248
+#define CLK_LPMCU_RTC				249
+#define PCLK_LPMCU_MAILBOX			250
+#define HCLK_OOC				251
+#define PCLK_SPI2AHB				252
+#define HCLK_SPI2AHB				253
+#define HCLK_FSPI1				254
+#define HCLK_XIP_FSPI1				255
+#define SCLK_1X_FSPI1				256
+#define PCLK_IOC_PMUIO1				257
+#define PCLK_AUDIO_ADC_PMU			258
+#define MCLK_AUDIO_ADC_PMU			259
+#define MCLK_AUDIO_ADC_DIV4_PMU			260
+#define MCLK_LPSAI				261
+#define ACLK_GIC400				262
+#define PCLK_WDT_NS				263
+#define TCLK_WDT_NS				264
+#define PCLK_WDT_HPMCU				265
+#define HCLK_CACHE				266
+#define PCLK_HPMCU_MAILBOX			267
+#define PCLK_HPMCU_INTMUX			268
+#define CLK_HPMCU				269
+#define CLK_HPMCU_RTC				270
+#define PCLK_RKDMA				271
+#define ACLK_RKDMA				272
+#define PCLK_DCF				273
+#define ACLK_DCF				274
+#define HCLK_RGA				275
+#define ACLK_RGA				276
+#define CLK_CORE_RGA				277
+#define PCLK_TIMER				278
+#define CLK_TIMER0				279
+#define CLK_TIMER1				280
+#define CLK_TIMER2				281
+#define CLK_TIMER3				282
+#define CLK_TIMER4				283
+#define CLK_TIMER5				284
+#define PCLK_I2C0				285
+#define CLK_I2C0				286
+#define PCLK_I2C1				287
+#define CLK_I2C1				288
+#define PCLK_I2C3				289
+#define CLK_I2C3				290
+#define PCLK_I2C4				291
+#define CLK_I2C4				292
+#define PCLK_I2C5				293
+#define CLK_I2C5				294
+#define PCLK_SPI0				295
+#define PCLK_SPI1				296
+#define PCLK_PWM0				297
+#define CLK_OSC_PWM0				298
+#define CLK_RC_PWM0				299
+#define PCLK_PWM2				300
+#define CLK_OSC_PWM2				301
+#define CLK_RC_PWM2				302
+#define PCLK_PWM3				303
+#define CLK_OSC_PWM3				304
+#define CLK_RC_PWM3				305
+#define PCLK_UART1				306
+#define PCLK_UART2				307
+#define PCLK_UART3				308
+#define PCLK_UART4				309
+#define PCLK_UART5				310
+#define PCLK_UART6				311
+#define PCLK_UART7				312
+#define PCLK_TSADC				313
+#define CLK_TSADC				314
+#define HCLK_SAI0				315
+#define HCLK_SAI1				316
+#define HCLK_SAI2				317
+#define HCLK_RKDSM				318
+#define MCLK_RKDSM				319
+#define HCLK_PDM				320
+#define HCLK_ASRC0				321
+#define HCLK_ASRC1				322
+#define PCLK_AUDIO_ADC_BUS			323
+#define MCLK_AUDIO_ADC_BUS			324
+#define MCLK_AUDIO_ADC_DIV4_BUS			325
+#define PCLK_RKCE				326
+#define HCLK_NS_RKCE				327
+#define PCLK_OTPC_NS				328
+#define CLK_SBPI_OTPC_NS			329
+#define CLK_USER_OTPC_NS			330
+#define CLK_OTPC_ARB				331
+#define PCLK_OTP_MASK				332
+#define CLK_TSADC_PHYCTRL			333
+#define LRCK_SRC_ASRC0				334
+#define LRCK_DST_ASRC0				335
+#define LRCK_SRC_ASRC1				336
+#define LRCK_DST_ASRC1				337
+#define PCLK_KEY_READER				338
+#define ACLK_NSRKCE				339
+#define CLK_PKA_NSRKCE				340
+#define PCLK_RTC_ROOT				341
+#define PCLK_GPIO1				342
+#define DBCLK_GPIO1				343
+#define PCLK_IOC_VCCIO1				344
+#define ACLK_USB3OTG				345
+#define CLK_REF_USB3OTG				346
+#define CLK_SUSPEND_USB3OTG			347
+#define HCLK_USB2HOST				348
+#define HCLK_ARB_USB2HOST			349
+#define PCLK_RTC_TEST				350
+#define HCLK_EMMC				351
+#define HCLK_FSPI0				352
+#define HCLK_XIP_FSPI0				353
+#define PCLK_PIPEPHY				354
+#define PCLK_USB2PHY				355
+#define CLK_REF_PIPEPHY_CPLL_SRC		356
+#define CLK_REF_PIPEPHY				357
+#define HCLK_VPSL				358
+#define ACLK_VPSL				359
+#define CLK_CORE_VPSL				360
+#define CLK_MACPHY				361
+#define HCLK_RKRNG_NS				362
+#define HCLK_RKRNG_S_NS				363
+#define CLK_AISP_PLL_SRC			364
+
+/* secure clks */
+#define CLK_USER_OTPC_S				400
+#define CLK_SBPI_OTPC_S				401
+#define PCLK_OTPC_S				402
+#define PCLK_KEY_READER_S			403
+#define HCLK_KL_RKCE_S				404
+#define HCLK_RKCE_S				405
+#define PCLK_WDT_S				406
+#define TCLK_WDT_S				407
+#define CLK_STIMER0				408
+#define CLK_STIMER1				409
+#define PLK_STIMER				410
+#define HCLK_RKRNG_S				411
+#define CLK_PKA_RKCE_S				412
+#define ACLK_RKCE_S				413
+
+#endif
diff --git a/include/dt-bindings/reset/rockchip,rv1126b-cru.h b/include/dt-bindings/reset/rockchip,rv1126b-cru.h
new file mode 100644
index 000000000000..19d6de2c054f
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
+#define SRST_PRESETN_CRU				0
+#define SRST_PRESETN_CRU_BIU				1
+
+/* BUSCRU-->SOFTRST_CON00 */
+#define SRST_ARESETN_TOP_BIU				2
+#define SRST_ARESETN_RKCE_BIU				3
+#define SRST_ARESETN_BUS_BIU				4
+#define SRST_HRESETN_BUS_BIU				5
+#define SRST_PRESETN_BUS_BIU				6
+#define SRST_PRESETN_CRU_BUS				7
+#define SRST_PRESETN_SYS_GRF				8
+#define SRST_HRESETN_BOOTROM				9
+#define SRST_ARESETN_GIC400				10
+#define SRST_ARESETN_SPINLOCK				11
+#define SRST_PRESETN_WDT_NS				12
+#define SRST_TRESETN_WDT_NS				13
+
+/* BUSCRU-->SOFTRST_CON01 */
+#define SRST_PRESETN_WDT_HPMCU				14
+#define SRST_TRESETN_WDT_HPMCU				15
+#define SRST_HRESETN_CACHE				16
+#define SRST_PRESETN_HPMCU_MAILBOX			17
+#define SRST_PRESETN_HPMCU_INTMUX			18
+#define SRST_RESETN_HPMCU_FULL_CLUSTER			19
+#define SRST_RESETN_HPMCU_PWUP				20
+#define SRST_RESETN_HPMCU_ONLY_CORE			21
+#define SRST_TRESETN_HPMCU_JTAG				22
+#define SRST_PRESETN_RKDMA				23
+#define SRST_ARESETN_RKDMA				24
+
+/* BUSCRU-->SOFTRST_CON02 */
+#define SRST_PRESETN_DCF				25
+#define SRST_ARESETN_DCF				26
+#define SRST_HRESETN_RGA				27
+#define SRST_ARESETN_RGA				28
+#define SRST_RESETN_CORE_RGA				29
+#define SRST_PRESETN_TIMER				30
+#define SRST_RESETN_TIMER0				31
+#define SRST_RESETN_TIMER1				32
+#define SRST_RESETN_TIMER2				33
+#define SRST_RESETN_TIMER3				34
+#define SRST_RESETN_TIMER4				35
+#define SRST_RESETN_TIMER5				36
+#define SRST_ARESETN_RKCE				37
+#define SRST_RESETN_PKA_RKCE				38
+#define SRST_HRESETN_RKRNG_S				39
+#define SRST_HRESETN_RKRNG_NS				40
+
+/* BUSCRU-->SOFTRST_CON03 */
+#define SRST_PRESETN_I2C0				41
+#define SRST_RESETN_I2C0				42
+#define SRST_PRESETN_I2C1				43
+#define SRST_RESETN_I2C1				44
+#define SRST_PRESETN_I2C3				45
+#define SRST_RESETN_I2C3				46
+#define SRST_PRESETN_I2C4				47
+#define SRST_RESETN_I2C4				48
+#define SRST_PRESETN_I2C5				49
+#define SRST_RESETN_I2C5				50
+#define SRST_PRESETN_SPI0				51
+#define SRST_RESETN_SPI0				52
+#define SRST_PRESETN_SPI1				53
+#define SRST_RESETN_SPI1				54
+
+/* BUSCRU-->SOFTRST_CON04 */
+#define SRST_PRESETN_PWM0				55
+#define SRST_RESETN_PWM0				56
+#define SRST_PRESETN_PWM2				57
+#define SRST_RESETN_PWM2				58
+#define SRST_PRESETN_PWM3				59
+#define SRST_RESETN_PWM3				60
+
+/* BUSCRU-->SOFTRST_CON05 */
+#define SRST_PRESETN_UART1				61
+#define SRST_SRESETN_UART1				62
+#define SRST_PRESETN_UART2				63
+#define SRST_SRESETN_UART2				64
+#define SRST_PRESETN_UART3				65
+#define SRST_SRESETN_UART3				66
+#define SRST_PRESETN_UART4				67
+#define SRST_SRESETN_UART4				68
+#define SRST_PRESETN_UART5				69
+#define SRST_SRESETN_UART5				70
+#define SRST_PRESETN_UART6				71
+#define SRST_SRESETN_UART6				72
+#define SRST_PRESETN_UART7				73
+#define SRST_SRESETN_UART7				74
+
+/* BUSCRU-->SOFTRST_CON06 */
+#define SRST_PRESETN_TSADC				75
+#define SRST_RESETN_TSADC				76
+#define SRST_HRESETN_SAI0				77
+#define SRST_MRESETN_SAI0				78
+#define SRST_HRESETN_SAI1				79
+#define SRST_MRESETN_SAI1				80
+#define SRST_HRESETN_SAI2				81
+#define SRST_MRESETN_SAI2				82
+#define SRST_HRESETN_RKDSM				83
+#define SRST_MRESETN_RKDSM				84
+#define SRST_HRESETN_PDM				85
+#define SRST_MRESETN_PDM				86
+#define SRST_RESETN_PDM					87
+
+/* BUSCRU-->SOFTRST_CON07 */
+#define SRST_HRESETN_ASRC0				88
+#define SRST_RESETN_ASRC0				89
+#define SRST_HRESETN_ASRC1				90
+#define SRST_RESETN_ASRC1				91
+#define SRST_PRESETN_AUDIO_ADC_BUS			92
+#define SRST_MRESETN_AUDIO_ADC_BUS			93
+#define SRST_PRESETN_RKCE				94
+#define SRST_HRESETN_NS_RKCE				95
+#define SRST_PRESETN_OTPC_NS				96
+#define SRST_RESETN_SBPI_OTPC_NS			97
+#define SRST_RESETN_USER_OTPC_NS			98
+#define SRST_RESETN_OTPC_ARB				99
+#define SRST_PRESETN_OTP_MASK				100
+
+/* PERICRU-->SOFTRST_CON00 */
+#define SRST_ARESETN_PERI_BIU				101
+#define SRST_PRESETN_PERI_BIU				102
+#define SRST_PRESETN_RTC_BIU				103
+#define SRST_PRESETN_CRU_PERI				104
+#define SRST_PRESETN_PERI_GRF				105
+#define SRST_PRESETN_GPIO1				106
+#define SRST_DBRESETN_GPIO1				107
+#define SRST_PRESETN_IOC_VCCIO1				108
+#define SRST_ARESETN_USB3OTG				109
+#define SRST_HRESETN_USB2HOST				110
+#define SRST_HRESETN_ARB_USB2HOST			111
+#define SRST_PRESETN_RTC_TEST				112
+
+/* PERICRU-->SOFTRST_CON01 */
+#define SRST_HRESETN_EMMC				113
+#define SRST_HRESETN_FSPI0				114
+#define SRST_HRESETN_XIP_FSPI0				115
+#define SRST_SRESETN_2X_FSPI0				116
+#define SRST_RESETN_UTMI_USB2HOST			117
+#define SRST_RESETN_REF_PIPEPHY				118
+#define SRST_PRESETN_PIPEPHY				119
+#define SRST_PRESETN_PIPEPHY_GRF			120
+#define SRST_PRESETN_USB2PHY				121
+#define SRST_RESETN_POR_USB2PHY				122
+#define SRST_RESETN_OTG_USB2PHY				123
+#define SRST_RESETN_HOST_USB2PHY			124
+
+/* CORECRU-->SOFTRST_CON00 */
+#define SRST_RESETN_REF_PVTPLL_CORE			125
+#define SRST_NCOREPORESET0				126
+#define SRST_NCORESET0					127
+#define SRST_NCOREPORESET1				128
+#define SRST_NCORESET1					129
+#define SRST_NCOREPORESET2				130
+#define SRST_NCORESET2					131
+#define SRST_NCOREPORESET3				132
+#define SRST_NCORESET3					133
+#define SRST_NDBGRESET					134
+#define SRST_NL2RESET					135
+
+/* CORECRU-->SOFTRST_CON01 */
+#define SRST_ARESETN_CORE_BIU				136
+#define SRST_PRESETN_CORE_BIU				137
+#define SRST_HRESETN_CORE_BIU				138
+#define SRST_PRESETN_DBG				139
+#define SRST_POTRESETN_DBG				140
+#define SRST_NTRESETN_DBG				141
+#define SRST_PRESETN_CORE_PVTPLL			142
+#define SRST_PRESETN_CRU_CORE				143
+#define SRST_PRESETN_CORE_GRF				144
+#define SRST_PRESETN_DFT2APB				145
+
+/* PMUCRU-->SOFTRST_CON00 */
+#define SRST_HRESETN_PMU_BIU				146
+#define SRST_PRESETN_PMU_GPIO0				147
+#define SRST_DBRESETN_PMU_GPIO0				148
+#define SRST_PRESETN_PMU_HP_TIMER			149
+#define SRST_RESETN_PMU_HP_TIMER			150
+#define SRST_RESETN_PMU_32K_HP_TIMER			151
+
+/* PMUCRU-->SOFTRST_CON01 */
+#define SRST_PRESETN_PWM1				152
+#define SRST_RESETN_PWM1				153
+#define SRST_PRESETN_I2C2				154
+#define SRST_RESETN_I2C2				155
+#define SRST_PRESETN_UART0				156
+#define SRST_SRESETN_UART0				157
+
+/* PMUCRU-->SOFTRST_CON02 */
+#define SRST_PRESETN_RCOSC_CTRL				158
+#define SRST_RESETN_REF_RCOSC_CTRL			159
+#define SRST_PRESETN_IOC_PMUIO0				160
+#define SRST_PRESETN_CRU_PMU				161
+#define SRST_PRESETN_PMU_GRF				162
+#define SRST_RESETN_PREROLL				163
+#define SRST_RESETN_PREROLL_32K				164
+#define SRST_HRESETN_PMU_SRAM				165
+
+/* PMUCRU-->SOFTRST_CON03 */
+#define SRST_PRESETN_WDT_LPMCU				166
+#define SRST_TRESETN_WDT_LPMCU				167
+#define SRST_RESETN_LPMCU_FULL_CLUSTER			168
+#define SRST_RESETN_LPMCU_PWUP				169
+#define SRST_RESETN_LPMCU_ONLY_CORE			170
+#define SRST_TRESETN_LPMCU_JTAG				171
+#define SRST_PRESETN_LPMCU_MAILBOX			172
+
+/* PMU1CRU-->SOFTRST_CON00 */
+#define SRST_PRESETN_SPI2AHB				173
+#define SRST_HRESETN_SPI2AHB				174
+#define SRST_HRESETN_FSPI1				175
+#define SRST_HRESETN_XIP_FSPI1				176
+#define SRST_SRESETN_1X_FSPI1				177
+#define SRST_PRESETN_IOC_PMUIO1				178
+#define SRST_PRESETN_CRU_PMU1				179
+#define SRST_PRESETN_AUDIO_ADC_PMU			180
+#define SRST_MRESETN_AUDIO_ADC_PMU			181
+#define SRST_HRESETN_PMU1_BIU				182
+
+/* PMU1CRU-->SOFTRST_CON01 */
+#define SRST_PRESETN_LPDMA				183
+#define SRST_ARESETN_LPDMA				184
+#define SRST_HRESETN_LPSAI				185
+#define SRST_MRESETN_LPSAI				186
+#define SRST_PRESETN_AOA_TDD				187
+#define SRST_PRESETN_AOA_FE				188
+#define SRST_PRESETN_AOA_AAD				189
+#define SRST_PRESETN_AOA_APB				190
+#define SRST_PRESETN_AOA_SRAM				191
+
+/* DDRCRU-->SOFTRST_CON00 */
+#define SRST_PRESETN_DDR_BIU				192
+#define SRST_PRESETN_DDRC				193
+#define SRST_PRESETN_DDRMON				194
+#define SRST_RESETN_TIMER_DDRMON			195
+#define SRST_PRESETN_DFICTRL				196
+#define SRST_PRESETN_DDR_GRF				197
+#define SRST_PRESETN_CRU_DDR				198
+#define SRST_PRESETN_DDRPHY				199
+#define SRST_PRESETN_DMA2DDR				200
+
+/* SUBDDRCRU-->SOFTRST_CON00 */
+#define SRST_ARESETN_SYSMEM_BIU				201
+#define SRST_ARESETN_SYSMEM				202
+#define SRST_ARESETN_DDR_BIU				203
+#define SRST_ARESETN_DDRSCH0_CPU			204
+#define SRST_ARESETN_DDRSCH1_NPU			205
+#define SRST_ARESETN_DDRSCH2_POE			206
+#define SRST_ARESETN_DDRSCH3_VI				207
+#define SRST_RESETN_CORE_DDRC				208
+#define SRST_RESETN_DDRMON				209
+#define SRST_RESETN_DFICTRL				210
+#define SRST_RESETN_RS					211
+#define SRST_ARESETN_DMA2DDR				212
+#define SRST_RESETN_DDRPHY				213
+
+/* VICRU-->SOFTRST_CON00 */
+#define SRST_RESETN_REF_PVTPLL_ISP			214
+#define SRST_ARESETN_GMAC_BIU				215
+#define SRST_ARESETN_VI_BIU				216
+#define SRST_HRESETN_VI_BIU				217
+#define SRST_PRESETN_VI_BIU				218
+#define SRST_PRESETN_CRU_VI				219
+#define SRST_PRESETN_VI_GRF				220
+#define SRST_PRESETN_VI_PVTPLL				221
+#define SRST_PRESETN_DSMC				222
+#define SRST_ARESETN_DSMC				223
+#define SRST_HRESETN_CAN0				224
+#define SRST_RESETN_CAN0				225
+#define SRST_HRESETN_CAN1				226
+#define SRST_RESETN_CAN1				227
+
+/* VICRU-->SOFTRST_CON01 */
+#define SRST_PRESETN_GPIO2				228
+#define SRST_DBRESETN_GPIO2				229
+#define SRST_PRESETN_GPIO4				230
+#define SRST_DBRESETN_GPIO4				231
+#define SRST_PRESETN_GPIO5				232
+#define SRST_DBRESETN_GPIO5				233
+#define SRST_PRESETN_GPIO6				234
+#define SRST_DBRESETN_GPIO6				235
+#define SRST_PRESETN_GPIO7				236
+#define SRST_DBRESETN_GPIO7				237
+#define SRST_PRESETN_IOC_VCCIO2				238
+#define SRST_PRESETN_IOC_VCCIO4				239
+#define SRST_PRESETN_IOC_VCCIO5				240
+#define SRST_PRESETN_IOC_VCCIO6				241
+#define SRST_PRESETN_IOC_VCCIO7				242
+
+/* VICRU-->SOFTRST_CON02 */
+#define SRST_RESETN_CORE_ISP				243
+#define SRST_HRESETN_VICAP				244
+#define SRST_ARESETN_VICAP				245
+#define SRST_DRESETN_VICAP				246
+#define SRST_ISP0RESETN_VICAP				247
+#define SRST_RESETN_CORE_VPSS				248
+#define SRST_RESETN_CORE_VPSL				249
+#define SRST_PRESETN_CSI2HOST0				250
+#define SRST_PRESETN_CSI2HOST1				251
+#define SRST_PRESETN_CSI2HOST2				252
+#define SRST_PRESETN_CSI2HOST3				253
+#define SRST_HRESETN_SDMMC0				254
+#define SRST_ARESETN_GMAC				255
+#define SRST_PRESETN_CSIPHY0				256
+#define SRST_PRESETN_CSIPHY1				257
+
+/* VICRU-->SOFTRST_CON03 */
+#define SRST_PRESETN_MACPHY				258
+#define SRST_RESETN_MACPHY				259
+#define SRST_PRESETN_SARADC1				260
+#define SRST_RESETN_SARADC1				261
+#define SRST_PRESETN_SARADC2				262
+#define SRST_RESETN_SARADC2				263
+
+/* VEPUCRU-->SOFTRST_CON00 */
+#define SRST_RESETN_REF_PVTPLL_VEPU			264
+#define SRST_ARESETN_VEPU_BIU				265
+#define SRST_HRESETN_VEPU_BIU				266
+#define SRST_PRESETN_VEPU_BIU				267
+#define SRST_PRESETN_CRU_VEPU				268
+#define SRST_PRESETN_VEPU_GRF				269
+#define SRST_PRESETN_GPIO3				270
+#define SRST_DBRESETN_GPIO3				271
+#define SRST_PRESETN_IOC_VCCIO3				272
+#define SRST_PRESETN_SARADC0				273
+#define SRST_RESETN_SARADC0				274
+#define SRST_HRESETN_SDMMC1				275
+
+/* VEPUCRU-->SOFTRST_CON01 */
+#define SRST_PRESETN_VEPU_PVTPLL			276
+#define SRST_HRESETN_VEPU				277
+#define SRST_ARESETN_VEPU				278
+#define SRST_RESETN_CORE_VEPU				279
+
+/* NPUCRU-->SOFTRST_CON00 */
+#define SRST_RESETN_REF_PVTPLL_NPU			280
+#define SRST_ARESETN_NPU_BIU				281
+#define SRST_HRESETN_NPU_BIU				282
+#define SRST_PRESETN_NPU_BIU				283
+#define SRST_PRESETN_CRU_NPU				284
+#define SRST_PRESETN_NPU_GRF				285
+#define SRST_PRESETN_NPU_PVTPLL				286
+#define SRST_HRESETN_RKNN				287
+#define SRST_ARESETN_RKNN				288
+
+/* VDOCRU-->SOFTRST_CON00 */
+#define SRST_ARESETN_RKVDEC_BIU				289
+#define SRST_ARESETN_VDO_BIU				290
+#define SRST_HRESETN_VDO_BIU				291
+#define SRST_PRESETN_VDO_BIU				292
+#define SRST_PRESETN_CRU_VDO				293
+#define SRST_PRESETN_VDO_GRF				294
+#define SRST_ARESETN_RKVDEC				295
+#define SRST_HRESETN_RKVDEC				296
+#define SRST_RESETN_HEVC_CA_RKVDEC			297
+#define SRST_ARESETN_VOP				298
+#define SRST_HRESETN_VOP				299
+#define SRST_DRESETN_VOP				300
+#define SRST_ARESETN_OOC				301
+#define SRST_HRESETN_OOC				302
+#define SRST_DRESETN_OOC				303
+
+/* VDOCRU-->SOFTRST_CON01 */
+#define SRST_HRESETN_RKJPEG				304
+#define SRST_ARESETN_RKJPEG				305
+#define SRST_ARESETN_RKMMU_DECOM			306
+#define SRST_HRESETN_RKMMU_DECOM			307
+#define SRST_DRESETN_DECOM				308
+#define SRST_ARESETN_DECOM				309
+#define SRST_PRESETN_DECOM				310
+#define SRST_PRESETN_MIPI_DSI				311
+#define SRST_PRESETN_DSIPHY				312
+
+/* VCPCRU-->SOFTRST_CON00 */
+#define SRST_RESETN_REF_PVTPLL_VCP			313
+#define SRST_ARESETN_VCP_BIU				314
+#define SRST_HRESETN_VCP_BIU				315
+#define SRST_PRESETN_VCP_BIU				316
+#define SRST_PRESETN_CRU_VCP				317
+#define SRST_PRESETN_VCP_GRF				318
+#define SRST_PRESETN_VCP_PVTPLL				319
+#define SRST_ARESETN_AISP_BIU				320
+#define SRST_HRESETN_AISP_BIU				321
+#define SRST_RESETN_CORE_AISP				322
+
+/* VCPCRU-->SOFTRST_CON01 */
+#define SRST_HRESETN_FEC				323
+#define SRST_ARESETN_FEC				324
+#define SRST_RESETN_CORE_FEC				325
+#define SRST_HRESETN_AVSP				326
+#define SRST_ARESETN_AVSP				327
+
+#endif
-- 
2.34.1


