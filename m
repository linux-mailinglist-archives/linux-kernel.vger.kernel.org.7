Return-Path: <linux-kernel+bounces-837420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30248BAC478
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02413219CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF1D2F3C1D;
	Tue, 30 Sep 2025 09:32:36 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC6E2773C6;
	Tue, 30 Sep 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224755; cv=none; b=Yl4Cuq+IoLWvbpFrj3tOvGU4Yvhoh708TdJ4QZzxvQPeo2riW0Xnu1daSF7ZM+Z4ZQPl7uE0TT5+SeoRY07KZmALvNStwvZDjbz0pRlQkuXoB7zGJRfqidWG9IEtPDm7rK1JlqkPUc4UFzQgDiwfNrfcqFbYzWg6bUFjoxZJpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224755; c=relaxed/simple;
	bh=kIdv5oM8h12qT9mHHkemlr6g7UVS5d1Rq0R+IFcZp9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nx8INqS3H5m+q2pAcD4N7LoolAf2c/8XJLWy+/OKNOEDcXii4sliGlIGPqcOCq97QO7CRA0JPJuw5GKRWqfD3eZ5UpWDc7jkR3aimEd+P23XvaQxIXK7ix3CvAZEV6N40JHA5ApQG5PA3VNqciGyjBdXWh+BnemVbRIUFQRGA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgBXexGko9toS9PuAA--.2382S2;
	Tue, 30 Sep 2025 17:32:22 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/2] dt-bindings: reset: eswin: Documentation for eic7700 SoC
Date: Tue, 30 Sep 2025 17:32:18 +0800
Message-Id: <20250930093218.2061-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20250930093132.2003-1-dongxuyang@eswincomputing.com>
References: <20250930093132.2003-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgBXexGko9toS9PuAA--.2382S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Aw1xAF1ktF4xKF13Jw18Xwb_yoW8GF1xCo
	WrGFnxJw4UK34IvrZIkw1xW398Cw4xtr1UXrWYq34ftrn7Jr1DKrykArW0grW3trWj9r15
	Cw4kK3srCrWYkFWrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUrdb1DUUUU
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

Add device tree binding documentation and header file for the ESWIN
eic7700 reset controller module.

Signed-off-by: Yifeng Huang <huangyifeng@eswincomputing.com>
Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/reset/eswin,eic7700-reset.yaml   |  42 +++
 .../dt-bindings/reset/eswin,eic7700-reset.h   | 298 ++++++++++++++++++
 2 files changed, 340 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/eswin,eic7700-reset.yaml
 create mode 100644 include/dt-bindings/reset/eswin,eic7700-reset.h

diff --git a/Documentation/devicetree/bindings/reset/eswin,eic7700-reset.yaml b/Documentation/devicetree/bindings/reset/eswin,eic7700-reset.yaml
new file mode 100644
index 000000000000..cf2fdb907571
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/eswin,eic7700-reset.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/eswin,eic7700-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ESWIN EIC7700 SoC reset controller
+
+maintainers:
+  - Yifeng Huang <huangyifeng@eswincomputing.com>
+  - Xuyang Dong <dongxuyang@eswincomputing.com>
+
+description:
+  The system reset controller can be used to reset various peripheral
+  controllers in ESWIN eic7700 SoC.
+
+properties:
+  compatible:
+    const: eswin,eic7700-reset
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/eswin,eic7700-reset.h>
+
+    reset-controller@51828300 {
+        compatible = "eswin,eic7700-reset";
+        reg = <0x51828300 0x200>;
+        #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/reset/eswin,eic7700-reset.h b/include/dt-bindings/reset/eswin,eic7700-reset.h
new file mode 100644
index 000000000000..a370c9f74307
--- /dev/null
+++ b/include/dt-bindings/reset/eswin,eic7700-reset.h
@@ -0,0 +1,298 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd..
+ * All rights reserved.
+ *
+ * Device Tree binding constants for EIC7700 reset controller.
+ *
+ * Authors:
+ *	Yifeng Huang <huangyifeng@eswincomputing.com>
+ *	Xuyang Dong <dongxuyang@eswincomputing.com>
+ */
+
+#ifndef __DT_ESWIN_EIC7700_RESET_H__
+#define __DT_ESWIN_EIC7700_RESET_H__
+
+#define EIC7700_RESET_NOC_NSP		0
+#define EIC7700_RESET_NOC_CFG		1
+#define EIC7700_RESET_RNOC_NSP		2
+#define EIC7700_RESET_SNOC_TCU		3
+#define EIC7700_RESET_SNOC_U84		4
+#define EIC7700_RESET_SNOC_PCIE_XSR	5
+#define EIC7700_RESET_SNOC_PCIE_XMR	6
+#define EIC7700_RESET_SNOC_PCIE_PR	7
+#define EIC7700_RESET_SNOC_NPU		8
+#define EIC7700_RESET_SNOC_JTAG		9
+#define EIC7700_RESET_SNOC_DSP		10
+#define EIC7700_RESET_SNOC_DDRC1_P2	11
+#define EIC7700_RESET_SNOC_DDRC1_P1	12
+#define EIC7700_RESET_SNOC_DDRC0_P2	13
+#define EIC7700_RESET_SNOC_DDRC0_P1	14
+#define EIC7700_RESET_SNOC_D2D		15
+#define EIC7700_RESET_SNOC_AON		16
+#define EIC7700_RESET_GPU_AXI		17
+#define EIC7700_RESET_GPU_CFG		18
+#define EIC7700_RESET_GPU_GRAY		19
+#define EIC7700_RESET_GPU_JONES		20
+#define EIC7700_RESET_GPU_SPU		21
+#define EIC7700_RESET_DSP_AXI		22
+#define EIC7700_RESET_DSP_CFG		23
+#define EIC7700_RESET_DSP_DIV4		24
+#define EIC7700_RESET_DSP_DIV0		25
+#define EIC7700_RESET_DSP_DIV1		26
+#define EIC7700_RESET_DSP_DIV2		27
+#define EIC7700_RESET_DSP_DIV3		28
+#define EIC7700_RESET_D2D_AXI		29
+#define EIC7700_RESET_D2D_CFG		30
+#define EIC7700_RESET_D2D_PRST		31
+#define EIC7700_RESET_D2D_RAW_PCS	32
+#define EIC7700_RESET_D2D_RX		33
+#define EIC7700_RESET_D2D_TX		34
+#define EIC7700_RESET_D2D_CORE		35
+#define EIC7700_RESET_DDR1_ARST		36
+#define EIC7700_RESET_DDR1_TRACE	37
+#define EIC7700_RESET_DDR0_ARST		38
+#define EIC7700_RESET_DDR_CFG		39
+#define EIC7700_RESET_DDR0_TRACE	40
+#define EIC7700_RESET_DDR_CORE		41
+#define EIC7700_RESET_DDR_PRST		42
+#define EIC7700_RESET_TCU_AXI		43
+#define EIC7700_RESET_TCU_CFG		44
+#define EIC7700_RESET_TCU_TBU0		45
+#define EIC7700_RESET_TCU_TBU1		46
+#define EIC7700_RESET_TCU_TBU2		47
+#define EIC7700_RESET_TCU_TBU3		48
+#define EIC7700_RESET_TCU_TBU4		49
+#define EIC7700_RESET_TCU_TBU5		50
+#define EIC7700_RESET_TCU_TBU6		51
+#define EIC7700_RESET_TCU_TBU7		52
+#define EIC7700_RESET_TCU_TBU8		53
+#define EIC7700_RESET_TCU_TBU9		54
+#define EIC7700_RESET_TCU_TBU10		55
+#define EIC7700_RESET_TCU_TBU11		56
+#define EIC7700_RESET_TCU_TBU12		57
+#define EIC7700_RESET_TCU_TBU13		58
+#define EIC7700_RESET_TCU_TBU14		59
+#define EIC7700_RESET_TCU_TBU15		60
+#define EIC7700_RESET_TCU_TBU16		61
+#define EIC7700_RESET_NPU_AXI		62
+#define EIC7700_RESET_NPU_CFG		63
+#define EIC7700_RESET_NPU_CORE		64
+#define EIC7700_RESET_NPU_E31CORE	65
+#define EIC7700_RESET_NPU_E31BUS	66
+#define EIC7700_RESET_NPU_E31DBG	67
+#define EIC7700_RESET_NPU_LLC		68
+#define EIC7700_RESET_HSP_AXI		69
+#define EIC7700_RESET_HSP_CFG		70
+#define EIC7700_RESET_HSP_POR		71
+#define EIC7700_RESET_MSHC0_PHY		72
+#define EIC7700_RESET_MSHC1_PHY		73
+#define EIC7700_RESET_MSHC2_PHY		74
+#define EIC7700_RESET_MSHC0_TXRX	75
+#define EIC7700_RESET_MSHC1_TXRX	76
+#define EIC7700_RESET_MSHC2_TXRX	77
+#define EIC7700_RESET_SATA_ASIC0	78
+#define EIC7700_RESET_SATA_OOB		79
+#define EIC7700_RESET_SATA_PMALIVE	80
+#define EIC7700_RESET_SATA_RBC		81
+#define EIC7700_RESET_DMA0		82
+#define EIC7700_RESET_HSP_DMA		83
+#define EIC7700_RESET_USB0_VAUX		84
+#define EIC7700_RESET_USB1_VAUX		85
+#define EIC7700_RESET_HSP_SD1_PRST	86
+#define EIC7700_RESET_HSP_SD0_PRST	87
+#define EIC7700_RESET_HSP_EMMC_PRST	88
+#define EIC7700_RESET_HSP_DMA_PRST	89
+#define EIC7700_RESET_HSP_SD1_ARST	90
+#define EIC7700_RESET_HSP_SD0_ARST	91
+#define EIC7700_RESET_HSP_EMMC_ARST	92
+#define EIC7700_RESET_HSP_DMA_ARST	93
+#define EIC7700_RESET_HSP_ETH1_ARST	94
+#define EIC7700_RESET_HSP_ETH0_ARST	95
+#define EIC7700_RESET_SATA_ARST		96
+#define EIC7700_RESET_PCIE_CFG		97
+#define EIC7700_RESET_PCIE_POWEUP	98
+#define EIC7700_RESET_PCIE_PERST	99
+#define EIC7700_RESET_I2C0		100
+#define EIC7700_RESET_I2C1		101
+#define EIC7700_RESET_I2C2		102
+#define EIC7700_RESET_I2C3		103
+#define EIC7700_RESET_I2C4		104
+#define EIC7700_RESET_I2C5		105
+#define EIC7700_RESET_I2C6		106
+#define EIC7700_RESET_I2C7		107
+#define EIC7700_RESET_I2C8		108
+#define EIC7700_RESET_I2C9		109
+#define EIC7700_RESET_FAN		110
+#define EIC7700_RESET_PVT0		111
+#define EIC7700_RESET_PVT1		112
+#define EIC7700_RESET_MBOX0		113
+#define EIC7700_RESET_MBOX1		114
+#define EIC7700_RESET_MBOX2		115
+#define EIC7700_RESET_MBOX3		116
+#define EIC7700_RESET_MBOX4		117
+#define EIC7700_RESET_MBOX5		118
+#define EIC7700_RESET_MBOX6		119
+#define EIC7700_RESET_MBOX7		120
+#define EIC7700_RESET_MBOX8		121
+#define EIC7700_RESET_MBOX9		122
+#define EIC7700_RESET_MBOX10		123
+#define EIC7700_RESET_MBOX11		124
+#define EIC7700_RESET_MBOX12		125
+#define EIC7700_RESET_MBOX13		126
+#define EIC7700_RESET_MBOX14		127
+#define EIC7700_RESET_MBOX15		128
+#define EIC7700_RESET_UART0		129
+#define EIC7700_RESET_UART1		130
+#define EIC7700_RESET_UART2		131
+#define EIC7700_RESET_UART3		132
+#define EIC7700_RESET_UART4		133
+#define EIC7700_RESET_GPIO0		134
+#define EIC7700_RESET_GPIO1		135
+#define EIC7700_RESET_TIMER		136
+#define EIC7700_RESET_SSI0		137
+#define EIC7700_RESET_SSI1		138
+#define EIC7700_RESET_WDT0		139
+#define EIC7700_RESET_WDT1		140
+#define EIC7700_RESET_WDT2		141
+#define EIC7700_RESET_WDT3		142
+#define EIC7700_RESET_LSP_CFG		143
+#define EIC7700_RESET_U84_CORE0		144
+#define EIC7700_RESET_U84_CORE1		145
+#define EIC7700_RESET_U84_CORE2		146
+#define EIC7700_RESET_U84_CORE3		147
+#define EIC7700_RESET_U84_BUS		148
+#define EIC7700_RESET_U84_DBG		149
+#define EIC7700_RESET_U84_TRACECOM	150
+#define EIC7700_RESET_U84_TRACE0	151
+#define EIC7700_RESET_U84_TRACE1	152
+#define EIC7700_RESET_U84_TRACE2	153
+#define EIC7700_RESET_U84_TRACE3	154
+#define EIC7700_RESET_SCPU_CORE		155
+#define EIC7700_RESET_SCPU_BUS		156
+#define EIC7700_RESET_SCPU_DBG		157
+#define EIC7700_RESET_LPCPU_CORE	158
+#define EIC7700_RESET_LPCPU_BUS		159
+#define EIC7700_RESET_LPCPU_DBG		160
+#define EIC7700_RESET_VC_CFG		161
+#define EIC7700_RESET_VC_AXI		162
+#define EIC7700_RESET_VC_MONCFG		163
+#define EIC7700_RESET_JD_CFG		164
+#define EIC7700_RESET_JD_AXI		165
+#define EIC7700_RESET_JE_CFG		166
+#define EIC7700_RESET_JE_AXI		167
+#define EIC7700_RESET_VD_CFG		168
+#define EIC7700_RESET_VD_AXI		169
+#define EIC7700_RESET_VE_AXI		170
+#define EIC7700_RESET_VE_CFG		171
+#define EIC7700_RESET_G2D_CORE		172
+#define EIC7700_RESET_G2D_CFG		173
+#define EIC7700_RESET_G2D_AXI		174
+#define EIC7700_RESET_VI_AXI		175
+#define EIC7700_RESET_VI_CFG		176
+#define EIC7700_RESET_VI_DWE		177
+#define EIC7700_RESET_DVP		178
+#define EIC7700_RESET_ISP0		179
+#define EIC7700_RESET_ISP1		180
+#define EIC7700_RESET_SHUTTR0		181
+#define EIC7700_RESET_SHUTTR1		182
+#define EIC7700_RESET_SHUTTR2		183
+#define EIC7700_RESET_SHUTTR3		184
+#define EIC7700_RESET_SHUTTR4		185
+#define EIC7700_RESET_SHUTTR5		186
+#define EIC7700_RESET_VO_MIPI		187
+#define EIC7700_RESET_VO_PRST		188
+#define EIC7700_RESET_VO_HDMI_PRST	189
+#define EIC7700_RESET_VO_HDMI_PHY	190
+#define EIC7700_RESET_VO_HDMI		191
+#define EIC7700_RESET_VO_I2S		192
+#define EIC7700_RESET_VO_I2S_PRST	193
+#define EIC7700_RESET_VO_AXI		194
+#define EIC7700_RESET_VO_CFG		195
+#define EIC7700_RESET_VO_DC		196
+#define EIC7700_RESET_VO_DC_PRST	197
+#define EIC7700_RESET_BOOTSPI_HRST	198
+#define EIC7700_RESET_BOOTSPI		199
+#define EIC7700_RESET_ANO1		200
+#define EIC7700_RESET_ANO0		201
+#define EIC7700_RESET_DMA1_ARST		202
+#define EIC7700_RESET_DMA1_HRST		203
+#define EIC7700_RESET_FPRT		204
+#define EIC7700_RESET_HBLOCK		205
+#define EIC7700_RESET_SECSR		206
+#define EIC7700_RESET_OTP		207
+#define EIC7700_RESET_PKA		208
+#define EIC7700_RESET_SPACC		209
+#define EIC7700_RESET_TRNG		210
+#define EIC7700_RESET_TIMER0_0		211
+#define EIC7700_RESET_TIMER0_1		212
+#define EIC7700_RESET_TIMER0_2		213
+#define EIC7700_RESET_TIMER0_3		214
+#define EIC7700_RESET_TIMER0_4		215
+#define EIC7700_RESET_TIMER0_5		216
+#define EIC7700_RESET_TIMER0_6		217
+#define EIC7700_RESET_TIMER0_7		218
+#define EIC7700_RESET_TIMER0_N		219
+#define EIC7700_RESET_TIMER1_0		220
+#define EIC7700_RESET_TIMER1_1		221
+#define EIC7700_RESET_TIMER1_2		222
+#define EIC7700_RESET_TIMER1_3		223
+#define EIC7700_RESET_TIMER1_4		224
+#define EIC7700_RESET_TIMER1_5		225
+#define EIC7700_RESET_TIMER1_6		226
+#define EIC7700_RESET_TIMER1_7		227
+#define EIC7700_RESET_TIMER1_N		228
+#define EIC7700_RESET_TIMER2_0		229
+#define EIC7700_RESET_TIMER2_1		230
+#define EIC7700_RESET_TIMER2_2		231
+#define EIC7700_RESET_TIMER2_3		232
+#define EIC7700_RESET_TIMER2_4		233
+#define EIC7700_RESET_TIMER2_5		234
+#define EIC7700_RESET_TIMER2_6		235
+#define EIC7700_RESET_TIMER2_7		236
+#define EIC7700_RESET_TIMER2_N		237
+#define EIC7700_RESET_TIMER3_0		238
+#define EIC7700_RESET_TIMER3_1		239
+#define EIC7700_RESET_TIMER3_2		240
+#define EIC7700_RESET_TIMER3_3		241
+#define EIC7700_RESET_TIMER3_4		242
+#define EIC7700_RESET_TIMER3_5		243
+#define EIC7700_RESET_TIMER3_6		244
+#define EIC7700_RESET_TIMER3_7		245
+#define EIC7700_RESET_TIMER3_N		246
+#define EIC7700_RESET_RTC		247
+#define EIC7700_RESET_MNOC_SNOC_NSP	248
+#define EIC7700_RESET_MNOC_VC		249
+#define EIC7700_RESET_MNOC_CFG		250
+#define EIC7700_RESET_MNOC_HSP		251
+#define EIC7700_RESET_MNOC_GPU		252
+#define EIC7700_RESET_MNOC_DDRC1_P3	253
+#define EIC7700_RESET_MNOC_DDRC0_P3	254
+#define EIC7700_RESET_RNOC_VO		255
+#define EIC7700_RESET_RNOC_VI		256
+#define EIC7700_RESET_RNOC_SNOC_NSP	257
+#define EIC7700_RESET_RNOC_CFG		258
+#define EIC7700_RESET_MNOC_DDRC1_P4	259
+#define EIC7700_RESET_MNOC_DDRC0_P4	260
+#define EIC7700_RESET_CNOC_VO_CFG	261
+#define EIC7700_RESET_CNOC_VI_CFG	262
+#define EIC7700_RESET_CNOC_VC_CFG	263
+#define EIC7700_RESET_CNOC_TCU_CFG	264
+#define EIC7700_RESET_CNOC_PCIE_CFG	265
+#define EIC7700_RESET_CNOC_NPU_CFG	266
+#define EIC7700_RESET_CNOC_LSP_CFG	267
+#define EIC7700_RESET_CNOC_HSP_CFG	268
+#define EIC7700_RESET_CNOC_GPU_CFG	269
+#define EIC7700_RESET_CNOC_DSPT_CFG	270
+#define EIC7700_RESET_CNOC_DDRT1_CFG	271
+#define EIC7700_RESET_CNOC_DDRT0_CFG	272
+#define EIC7700_RESET_CNOC_D2D_CFG	273
+#define EIC7700_RESET_CNOC_CFG		274
+#define EIC7700_RESET_CNOC_CLMM_CFG	275
+#define EIC7700_RESET_CNOC_AON_CFG	276
+#define EIC7700_RESET_LNOC_CFG		277
+#define EIC7700_RESET_LNOC_NPU_LLC	278
+#define EIC7700_RESET_LNOC_DDRC1_P0	279
+#define EIC7700_RESET_LNOC_DDRC0_P0	280
+
+#endif /* __DT_ESWIN_EIC7700_RESET_H__ */
-- 
2.43.0


