Return-Path: <linux-kernel+bounces-846534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA588BC8467
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A621E3AD8AA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBE62D481C;
	Thu,  9 Oct 2025 09:21:36 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FFC28CF42;
	Thu,  9 Oct 2025 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001695; cv=none; b=Fu0kPmrlEoN+1YXVoSJizMXslq+jcs3Zs1arsY2ruYjrmZK1INblLd21ACdQFR5toN8O1p/Z8KCTbcsGgfCw2atgnp5t8yDwUj6NHAl4wCg+cfZLOuKeN44QcOVj8t1eOpkMdpn4FWJ1JFZPRecTeJtLCDjDl/BE8qGiLEddYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001695; c=relaxed/simple;
	bh=dHmIvkdEburiIKhnV+XASYOVR32MkGeOikoVYguWD9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dm64N/0bSpumuhlM54ATUKu5Vtk+AYBspGXpdp8+rLvzflxvFI+RE0x+QFWdD4kFsMiq266Vtq8az5ycu/S7C303mWKKa9pku2HcvSKDNiMKRHRiiN+E3emQFcmUWVDmZOD9VN7jJ3rtDZ12MEvohpfNET+JqXMTl/nnmkTjUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgDn_Q6QfudoW5wCAQ--.3171S2;
	Thu, 09 Oct 2025 17:21:22 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH v6 1/2] dt-bindings: clock: eswin: Documentation for eic7700 SoC
Date: Thu,  9 Oct 2025 17:21:19 +0800
Message-Id: <20251009092119.198-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20251009092029.140-1-dongxuyang@eswincomputing.com>
References: <20251009092029.140-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgDn_Q6QfudoW5wCAQ--.3171S2
X-Coremail-Antispam: 1UD129KBjvAXoW3ZF4UuF45ur18Zr13Xw15XFb_yoW8Xw1rto
	W8C3Zxu3yUKw1IvrsxGw1xX3yYkr47Jr1DXF13Xa4fKF1xJrnFkry8Jr40934ftryj9r90
	kwsrKwn7ZrWY9FW7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
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

Add device tree binding documentation for the ESWIN eic7700
clock controller module.

Signed-off-by: Yifeng Huang <huangyifeng@eswincomputing.com>
Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
---
 .../bindings/clock/eswin,eic7700-clock.yaml   |  46 +++
 .../dt-bindings/clock/eswin,eic7700-clock.h   | 280 ++++++++++++++++++
 2 files changed, 326 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/eswin,eic7700-clock.yaml
 create mode 100644 include/dt-bindings/clock/eswin,eic7700-clock.h

diff --git a/Documentation/devicetree/bindings/clock/eswin,eic7700-clock.yaml b/Documentation/devicetree/bindings/clock/eswin,eic7700-clock.yaml
new file mode 100644
index 000000000000..3125ae52bde6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/eswin,eic7700-clock.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/eswin,eic7700-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Eswin EIC7700 SoC clock controller
+
+maintainers:
+  - Yifeng Huang <huangyifeng@eswincomputing.com>
+  - Xuyang Dong <dongxuyang@eswincomputing.com>
+
+description:
+  The clock controller generates and supplies clock to all the modules
+  for eic7700 SoC.
+
+properties:
+  compatible:
+    const: eswin,eic7700-clock
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: External 24MHz oscillator clock
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@51828000 {
+        compatible = "eswin,eic7700-clock";
+        reg = <0x51828000 0x300>;
+        clocks = <&xtal24m>;
+        #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/eswin,eic7700-clock.h b/include/dt-bindings/clock/eswin,eic7700-clock.h
new file mode 100644
index 000000000000..544d7648e17e
--- /dev/null
+++ b/include/dt-bindings/clock/eswin,eic7700-clock.h
@@ -0,0 +1,280 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd..
+ * All rights reserved.
+ *
+ * Device Tree binding constants for EIC7700 clock controller.
+ *
+ * Authors:
+ *	Yifeng Huang <huangyifeng@eswincomputing.com>
+ *	Xuyang Dong <dongxuyang@eswincomputing.com>
+ */
+
+#ifndef _DT_BINDINGS_ESWIN_EIC7700_CLOCK_H_
+#define _DT_BINDINGS_ESWIN_EIC7700_CLOCK_H_
+
+#define EIC7700_CLK_XTAL_32K				0
+#define EIC7700_CLK_PLL_CPU				1
+#define EIC7700_CLK_SPLL0_FOUT1				2
+#define EIC7700_CLK_SPLL0_FOUT2				3
+#define EIC7700_CLK_SPLL0_FOUT3				4
+#define EIC7700_CLK_SPLL1_FOUT1				5
+#define EIC7700_CLK_SPLL1_FOUT2				6
+#define EIC7700_CLK_SPLL1_FOUT3				7
+#define EIC7700_CLK_SPLL2_FOUT1				8
+#define EIC7700_CLK_SPLL2_FOUT2				9
+#define EIC7700_CLK_SPLL2_FOUT3				10
+#define EIC7700_CLK_VPLL_FOUT1				11
+#define EIC7700_CLK_VPLL_FOUT2				12
+#define EIC7700_CLK_VPLL_FOUT3				13
+#define EIC7700_CLK_APLL_FOUT1				14
+#define EIC7700_CLK_APLL_FOUT2				15
+#define EIC7700_CLK_APLL_FOUT3				16
+#define EIC7700_CLK_EXT_MCLK				17
+#define EIC7700_CLK_LPDDR_REF_BAK			18
+#define EIC7700_CLK_MUX_CPU_ROOT_3MUX1_GFREE		19
+#define EIC7700_CLK_MUX_CPU_ACLK_2MUX1_GFREE		20
+#define EIC7700_CLK_MUX_DSP_ACLK_ROOT_2MUX1_GFREE	21
+#define EIC7700_CLK_MUX_D2D_ACLK_ROOT_2MUX1_GFREE	22
+#define EIC7700_CLK_MUX_MSHCORE_ROOT_3MUX1_0		23
+#define EIC7700_CLK_MUX_MSHCORE_ROOT_3MUX1_1		24
+#define EIC7700_CLK_MUX_MSHCORE_ROOT_3MUX1_2		25
+#define EIC7700_CLK_MUX_NPU_LLCLK_3MUX1_GFREE		26
+#define EIC7700_CLK_MUX_NPU_CORE_3MUX1_GFREE		27
+#define EIC7700_CLK_MUX_VI_ACLK_ROOT_2MUX1_GFREE	28
+#define EIC7700_CLK_MUX_VI_DVP_ROOT_2MUX1_GFREE		29
+#define EIC7700_CLK_MUX_VI_DIG_ISP_ROOT_2MUX1_GFREE	30
+#define EIC7700_CLK_MUX_VO_ACLK_ROOT_2MUX1_GFREE	31
+#define EIC7700_CLK_MUX_VO_PIXEL_ROOT_2MUX1		32
+#define EIC7700_CLK_MUX_VCDEC_ROOT_2MUX1_GFREE		33
+#define EIC7700_CLK_MUX_VCACLK_ROOT_2MUX1_GFREE		34
+#define EIC7700_CLK_MUX_SYSCFG_CLK_ROOT_2MUX1_GFREE	35
+#define EIC7700_CLK_MUX_BOOTSPI_CLK_2MUX1_GFREE		36
+#define EIC7700_CLK_MUX_SCPU_CORE_CLK_2MUX1_GFREE	37
+#define EIC7700_CLK_MUX_LPCPU_CORE_CLK_2MUX1_GFREE	38
+#define EIC7700_CLK_MUX_VO_MCLK_2MUX_EXT_MCLK		39
+#define EIC7700_CLK_MUX_SATA_PHY_2MUX1			40
+#define EIC7700_CLK_MUX_AONDMA_AXI2MUX1_GFREE		41
+#define EIC7700_CLK_MUX_RMII_REF_2MUX			42
+#define EIC7700_CLK_MUX_ETH_CORE_2MUX1			43
+#define EIC7700_CLK_MUX_VI_DW_ROOT_2MUX1		44
+#define EIC7700_CLK_MUX_NPU_E31_3MUX1_GFREE		45
+#define EIC7700_CLK_MUX_DDR_ACLK_ROOT_2MUX1_GFREE	46
+#define EIC7700_CLK_DIV_SYS_CFG_DYNM			47
+#define EIC7700_CLK_DIV_NOC_NSP_DYNM			48
+#define EIC7700_CLK_DIV_BOOTSPI_DYNM			49
+#define EIC7700_CLK_DIV_SCPU_CORE_DYNM			50
+#define EIC7700_CLK_DIV_LPCPU_CORE_DYNM			51
+#define EIC7700_CLK_DIV_GPU_ACLK_DYNM			52
+#define EIC7700_CLK_DIV_DSP_ACLK_DYNM			53
+#define EIC7700_CLK_DIV_D2D_ACLK_DYNM			54
+#define EIC7700_CLK_DIV_HSP_ACLK_DYNM			55
+#define EIC7700_CLK_DIV_ETH_TXCLK_DYNM_0		56
+#define EIC7700_CLK_DIV_ETH_TXCLK_DYNM_1		57
+#define EIC7700_CLK_DIV_MSHC_CORE_DYNM_0		58
+#define EIC7700_CLK_DIV_MSHC_CORE_DYNM_1		59
+#define EIC7700_CLK_DIV_MSHC_CORE_DYNM_2		60
+#define EIC7700_CLK_DIV_PCIE_ACLK_DYNM			61
+#define EIC7700_CLK_DIV_NPU_ACLK_DYNM			62
+#define EIC7700_CLK_DIV_NPU_LLC_SRC0_DYNM		63
+#define EIC7700_CLK_DIV_NPU_LLC_SRC1_DYNM		64
+#define EIC7700_CLK_DIV_NPU_CORECLK_DYNM		65
+#define EIC7700_CLK_DIV_VI_ACLK_DYNM			66
+#define EIC7700_CLK_DIV_VI_DVP_DYNM			67
+#define EIC7700_CLK_DIV_VI_DIG_ISP_DYNM			68
+#define EIC7700_CLK_DIV_VI_SHUTTER_DYNM_0		69
+#define EIC7700_CLK_DIV_VI_SHUTTER_DYNM_1		70
+#define EIC7700_CLK_DIV_VI_SHUTTER_DYNM_2		71
+#define EIC7700_CLK_DIV_VI_SHUTTER_DYNM_3		72
+#define EIC7700_CLK_DIV_VI_SHUTTER_DYNM_4		73
+#define EIC7700_CLK_DIV_VI_SHUTTER_DYNM_5		74
+#define EIC7700_CLK_DIV_VO_ACLK_DYNM			75
+#define EIC7700_CLK_DIV_IESMCLK_DYNM			76
+#define EIC7700_CLK_DIV_VO_PIXEL_DYNM			77
+#define EIC7700_CLK_DIV_VO_MCLK_DYNM			78
+#define EIC7700_CLK_DIV_VC_ACLK_DYNM			79
+#define EIC7700_CLK_DIV_JD_DYNM				80
+#define EIC7700_CLK_DIV_JE_DYNM				81
+#define EIC7700_CLK_DIV_VE_DYNM				82
+#define EIC7700_CLK_DIV_VD_DYNM				83
+#define EIC7700_CLK_DIV_G2D_DYNM			84
+#define EIC7700_CLK_DIV_AONDMA_AXI_DYNM			85
+#define EIC7700_CLK_DIV_CRYPTO_DYNM			86
+#define EIC7700_CLK_DIV_VI_DW_DYNM			87
+#define EIC7700_CLK_DIV_NPU_E31_DYNM			88
+#define EIC7700_CLK_DIV_SATA_PHY_REF_DYNM		89
+#define EIC7700_CLK_DIV_DSP_0_ACLK_DYNM			90
+#define EIC7700_CLK_DIV_DSP_1_ACLK_DYNM			91
+#define EIC7700_CLK_DIV_DSP_2_ACLK_DYNM			92
+#define EIC7700_CLK_DIV_DSP_3_ACLK_DYNM			93
+#define EIC7700_CLK_DIV_DDR_ACLK_DYNM			94
+#define EIC7700_CLK_DIV_AON_RTC_DYNM			95
+#define EIC7700_CLK_DIV_U84_RTC_TOGGLE_DYNM		96
+#define EIC7700_CLK_DIV_VO_CEC_DYNM			97
+#define EIC7700_CLK_GATE_CPU_EXT_SRC_CORE_CLK_0		98
+#define EIC7700_CLK_GATE_CPU_EXT_SRC_CORE_CLK_1		99
+#define EIC7700_CLK_GATE_CPU_EXT_SRC_CORE_CLK_2		100
+#define EIC7700_CLK_GATE_CPU_EXT_SRC_CORE_CLK_3		101
+#define EIC7700_CLK_GATE_CPU_TRACE_CLK_0		102
+#define EIC7700_CLK_GATE_CPU_TRACE_CLK_1		103
+#define EIC7700_CLK_GATE_CPU_TRACE_CLK_2		104
+#define EIC7700_CLK_GATE_CPU_TRACE_CLK_3		105
+#define EIC7700_CLK_GATE_CPU_TRACE_COM_CLK		106
+#define EIC7700_CLK_GATE_SPLL0_FOUT2			107
+#define EIC7700_CLK_GATE_NOC_NSP_CLK			108
+#define EIC7700_CLK_GATE_BOOTSPI			109
+#define EIC7700_CLK_GATE_BOOTSPI_CFG			110
+#define EIC7700_CLK_GATE_SCPU_CORE			111
+#define EIC7700_CLK_GATE_SCPU_BUS			112
+#define EIC7700_CLK_GATE_LPCPU_CORE			113
+#define EIC7700_CLK_GATE_LPCPU_BUS			114
+#define EIC7700_CLK_GATE_GPU_ACLK			115
+#define EIC7700_CLK_GATE_GPU_GRAY_CLK			116
+#define EIC7700_CLK_GATE_GPU_CFG_CLK			117
+#define EIC7700_CLK_GATE_DSPT_ACLK			118
+#define EIC7700_CLK_GATE_DSPT_CFG_CLK			119
+#define EIC7700_CLK_GATE_D2D_ACLK			120
+#define EIC7700_CLK_GATE_D2D_CFG_CLK			121
+#define EIC7700_CLK_GATE_TCU_ACLK			122
+#define EIC7700_CLK_GATE_TCU_CFG_CLK			123
+#define EIC7700_CLK_GATE_DDRT_CFG_CLK			124
+#define EIC7700_CLK_GATE_DDRT0_P0_ACLK			125
+#define EIC7700_CLK_GATE_DDRT0_P1_ACLK			126
+#define EIC7700_CLK_GATE_DDRT0_P2_ACLK			127
+#define EIC7700_CLK_GATE_DDRT0_P3_ACLK			128
+#define EIC7700_CLK_GATE_DDRT0_P4_ACLK			129
+#define EIC7700_CLK_GATE_DDRT1_P0_ACLK			130
+#define EIC7700_CLK_GATE_DDRT1_P1_ACLK			131
+#define EIC7700_CLK_GATE_DDRT1_P2_ACLK			132
+#define EIC7700_CLK_GATE_DDRT1_P3_ACLK			133
+#define EIC7700_CLK_GATE_DDRT1_P4_ACLK			134
+#define EIC7700_CLK_GATE_HSP_ACLK			135
+#define EIC7700_CLK_GATE_HSP_CFG_CLK			136
+#define EIC7700_CLK_GATE_HSP_SATA_RBC_CLK		137
+#define EIC7700_CLK_GATE_HSP_SATA_OOB_CLK		138
+#define EIC7700_CLK_GATE_HSP_ETH0_CORE_CLK		139
+#define EIC7700_CLK_GATE_HSP_ETH1_CORE_CLK		140
+#define EIC7700_CLK_GATE_HSP_MSHC0_CORE_CLK		141
+#define EIC7700_CLK_GATE_HSP_MSHC1_CORE_CLK		142
+#define EIC7700_CLK_GATE_HSP_MSHC2_CORE_CLK		143
+#define EIC7700_CLK_GATE_PCIET_ACLK			144
+#define EIC7700_CLK_GATE_PCIET_CFG_CLK			145
+#define EIC7700_CLK_GATE_PCIET_CR_CLK			146
+#define EIC7700_CLK_GATE_PCIET_AUX_CLK			147
+#define EIC7700_CLK_GATE_NPU_ACLK			148
+#define EIC7700_CLK_GATE_NPU_CFG_CLK			149
+#define EIC7700_CLK_GATE_NPU_LLC_ACLK			150
+#define EIC7700_CLK_GATE_NPU_CLK			151
+#define EIC7700_CLK_GATE_NPU_E31_CLK			152
+#define EIC7700_CLK_GATE_VI_ACLK			153
+#define EIC7700_CLK_GATE_VI_DVP_CLK			154
+#define EIC7700_CLK_GATE_VI_CFG_CLK			155
+#define EIC7700_CLK_GATE_VI_DIG_DW_CLK			156
+#define EIC7700_CLK_GATE_VI_DIG_ISP_CLK			157
+#define EIC7700_CLK_GATE_VI_SHUTTER_0			158
+#define EIC7700_CLK_GATE_VI_SHUTTER_1			159
+#define EIC7700_CLK_GATE_VI_SHUTTER_2			160
+#define EIC7700_CLK_GATE_VI_SHUTTER_3			161
+#define EIC7700_CLK_GATE_VI_SHUTTER_4			162
+#define EIC7700_CLK_GATE_VI_SHUTTER_5			163
+#define EIC7700_CLK_GATE_VI_PHY_TXCLKESC		164
+#define EIC7700_CLK_GATE_VI_PHY_CFG			165
+#define EIC7700_CLK_GATE_VO_ACLK			166
+#define EIC7700_CLK_GATE_VO_CFG_CLK			167
+#define EIC7700_CLK_GATE_VO_HDMI_IESMCLK		168
+#define EIC7700_CLK_GATE_VO_PIXEL_CLK			169
+#define EIC7700_CLK_GATE_VO_I2S_MCLK			170
+#define EIC7700_CLK_GATE_VO_CR_CLK			171
+#define EIC7700_CLK_GATE_VC_ACLK			172
+#define EIC7700_CLK_GATE_VC_CFG_CLK			173
+#define EIC7700_CLK_GATE_VC_JE_CLK			174
+#define EIC7700_CLK_GATE_VC_JD_CLK			175
+#define EIC7700_CLK_GATE_VC_VE_CLK			176
+#define EIC7700_CLK_GATE_VC_VD_CLK			177
+#define EIC7700_CLK_GATE_G2D_CFG_CLK			178
+#define EIC7700_CLK_GATE_G2D_CLK			179
+#define EIC7700_CLK_GATE_G2D_ACLK			180
+#define EIC7700_CLK_GATE_AONDMA_CFG			181
+#define EIC7700_CLK_GATE_AONDMA_ACLK			182
+#define EIC7700_CLK_GATE_AON_ACLK			183
+#define EIC7700_CLK_GATE_TIMER_CLK_0			184
+#define EIC7700_CLK_GATE_TIMER_CLK_1			185
+#define EIC7700_CLK_GATE_TIMER_CLK_2			186
+#define EIC7700_CLK_GATE_TIMER_CLK_3			187
+#define EIC7700_CLK_GATE_TIMER_PCLK_0			188
+#define EIC7700_CLK_GATE_TIMER_PCLK_1			189
+#define EIC7700_CLK_GATE_TIMER_PCLK_2			190
+#define EIC7700_CLK_GATE_TIMER_PCLK_3			191
+#define EIC7700_CLK_GATE_TIMER3_CLK8			192
+#define EIC7700_CLK_GATE_RTC_CFG			193
+#define EIC7700_CLK_GATE_RTC				194
+#define EIC7700_CLK_GATE_HSP_RMII_REF_0			195
+#define EIC7700_CLK_GATE_HSP_RMII_REF_1			196
+#define EIC7700_CLK_GATE_PKA_CFG			197
+#define EIC7700_CLK_GATE_SPACC_CFG			198
+#define EIC7700_CLK_GATE_CRYPTO				199
+#define EIC7700_CLK_GATE_TRNG_CFG			200
+#define EIC7700_CLK_GATE_OTP_CFG			201
+#define EIC7700_CLK_GATE_MAILBOX_0			202
+#define EIC7700_CLK_GATE_MAILBOX_1			203
+#define EIC7700_CLK_GATE_MAILBOX_2			204
+#define EIC7700_CLK_GATE_MAILBOX_3			205
+#define EIC7700_CLK_GATE_MAILBOX_4			206
+#define EIC7700_CLK_GATE_MAILBOX_5			207
+#define EIC7700_CLK_GATE_MAILBOX_6			208
+#define EIC7700_CLK_GATE_MAILBOX_7			209
+#define EIC7700_CLK_GATE_MAILBOX_8			210
+#define EIC7700_CLK_GATE_MAILBOX_9			211
+#define EIC7700_CLK_GATE_MAILBOX_10			212
+#define EIC7700_CLK_GATE_MAILBOX_11			213
+#define EIC7700_CLK_GATE_MAILBOX_12			214
+#define EIC7700_CLK_GATE_MAILBOX_13			215
+#define EIC7700_CLK_GATE_MAILBOX_14			216
+#define EIC7700_CLK_GATE_MAILBOX_15			217
+#define EIC7700_CLK_GATE_LSP_I2C0_PCLK			218
+#define EIC7700_CLK_GATE_LSP_I2C1_PCLK			219
+#define EIC7700_CLK_GATE_LSP_I2C2_PCLK			220
+#define EIC7700_CLK_GATE_LSP_I2C3_PCLK			221
+#define EIC7700_CLK_GATE_LSP_I2C4_PCLK			222
+#define EIC7700_CLK_GATE_LSP_I2C5_PCLK			223
+#define EIC7700_CLK_GATE_LSP_I2C6_PCLK			224
+#define EIC7700_CLK_GATE_LSP_I2C7_PCLK			225
+#define EIC7700_CLK_GATE_LSP_I2C8_PCLK			226
+#define EIC7700_CLK_GATE_LSP_I2C9_PCLK			227
+#define EIC7700_CLK_GATE_LSP_WDT0_PCLK			228
+#define EIC7700_CLK_GATE_LSP_WDT1_PCLK			229
+#define EIC7700_CLK_GATE_LSP_WDT2_PCLK			230
+#define EIC7700_CLK_GATE_LSP_WDT3_PCLK			231
+#define EIC7700_CLK_GATE_LSP_SSI0_PCLK			232
+#define EIC7700_CLK_GATE_LSP_SSI1_PCLK			233
+#define EIC7700_CLK_GATE_LSP_PVT_PCLK			234
+#define EIC7700_CLK_GATE_AON_I2C0_PCLK			235
+#define EIC7700_CLK_GATE_AON_I2C1_PCLK			236
+#define EIC7700_CLK_GATE_LSP_UART0_PCLK			237
+#define EIC7700_CLK_GATE_LSP_UART1_PCLK			238
+#define EIC7700_CLK_GATE_LSP_UART2_PCLK			239
+#define EIC7700_CLK_GATE_LSP_UART3_PCLK			240
+#define EIC7700_CLK_GATE_LSP_UART4_PCLK			241
+#define EIC7700_CLK_GATE_LSP_TIMER_PCLK			242
+#define EIC7700_CLK_GATE_LSP_FAN_PCLK			243
+#define EIC7700_CLK_GATE_LSP_PVT0_CLK			244
+#define EIC7700_CLK_GATE_LSP_PVT1_CLK			245
+#define EIC7700_CLK_GATE_VC_JE_PCLK			246
+#define EIC7700_CLK_GATE_VC_JD_PCLK			247
+#define EIC7700_CLK_GATE_VC_VE_PCLK			248
+#define EIC7700_CLK_GATE_VC_VD_PCLK			249
+#define EIC7700_CLK_GATE_VC_MON_PCLK			250
+#define EIC7700_CLK_GATE_HSP_DMA0_CLK			251
+#define EIC7700_CLK_GATE_HSP_DMA0_CLK_TEST		252
+#define EIC7700_CLK_FIXED_FACTOR_CPU_DIV2		253
+#define EIC7700_CLK_FIXED_FACTOR_CLK_1M_DIV24		254
+#define EIC7700_CLK_FIXED_FACTOR_MIPI_TXESC_DIV10	255
+#define EIC7700_CLK_FIXED_FACTOR_U84_CORE_LP_DIV2	256
+#define EIC7700_CLK_FIXED_FACTOR_SCPU_BUS_DIV2		257
+#define EIC7700_CLK_FIXED_FACTOR_LPCPU_BUS_DIV2		258
+#define EIC7700_CLK_FIXED_FACTOR_PCIE_CR_DIV2		259
+#define EIC7700_CLK_FIXED_FACTOR_PCIE_AUX_DIV4		260
+#define EIC7700_CLK_FIXED_FACTOR_PVT_DIV20		261
+#define EIC7700_CLK_FIXED_FACTOR_HSP_RMII_REF_DIV6	262
+
+#endif /* _DT_BINDINGS_ESWIN_EIC7700_CLOCK_H_ */
-- 
2.43.0


