Return-Path: <linux-kernel+bounces-852696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D743CBD9ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA8E188C2BD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF60A315783;
	Tue, 14 Oct 2025 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="W1beLoKd"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7368831961A;
	Tue, 14 Oct 2025 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447474; cv=none; b=ul+l/yW+b8qARLOwCpbi7JCBSS2vieS2jX0nTW3B9bPUJtf1I3wHOwMjpNKeQi4w9vMw8JpyJN3xf/EwxF7yfwWUnFB1B3PhwQ/pYgxAynlNsVeNcpRdDPbY/lwjYc65jO4iDoF1fejx2+spdQazx2JMi80x0PCp78B/4hfu9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447474; c=relaxed/simple;
	bh=lvMDZF7RwQWAJn+DrXmr1M/rPA+6HNKxhiqOts6o5LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAdIFDecBpKg2xSnf3MYZwf7JkDsI/4JwggNwqCnkX6cKFjzssFqZchxRjVOYoK+5SBGhfrWsgtmn5DGuNd28i4/LfleCYHvjF8PvDyP75+f0gF0+lGHg9fED6QTflU+bbvM5vQsvYa0cDSyIakSBeKYO9uyWIaFP7wnYc5KC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=W1beLoKd; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id ADE9B22BF5;
	Tue, 14 Oct 2025 15:11:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5wVFJQEXtT27; Tue, 14 Oct 2025 15:11:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760447469; bh=lvMDZF7RwQWAJn+DrXmr1M/rPA+6HNKxhiqOts6o5LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W1beLoKd126cJDerInsI0vJAgMcZCv4buHuQiuJkVFrOWP7JW0cKZawKz/fYxOPPj
	 ShasYEY88xrJjxE0LYpmueMMivG24FT+iu2YbjVxnSdpiGMbRXUMHbCUsnV2c+uc1F
	 CxPuKIrKF3OUGq2i90DsPtSmHZRZcxcuT6eaHh7rgZxogj6AX6+xkp2ZBOwuafUasv
	 CcYxpNkUJDKUZrKSYdV0NzAkPSMNC/fvsFhajT2rG7fPWqw7HgWwQKqYixbsJlZ47r
	 VHOe5F3i5Zs8pgb8ix+I6theo13KH52P0+1NR3Uv+RrssbdcmD4nJB3/ff018FEwke
	 louNiOOFcJeVA==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v3 2/5] dt-bindings: reset: thead,th1520-reset: Add controllers for more subsys
Date: Tue, 14 Oct 2025 13:10:29 +0000
Message-ID: <20251014131032.49616-3-ziyao@disroot.org>
In-Reply-To: <20251014131032.49616-1-ziyao@disroot.org>
References: <20251014131032.49616-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TH1520 SoC is divided into several subsystems, most of them have
distinct reset controllers. Let's document reset controllers other than
the one for VO subsystem and IDs for their reset signals.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/reset/thead,th1520-reset.yaml    |   8 +-
 .../dt-bindings/reset/thead,th1520-reset.h    | 216 ++++++++++++++++++
 2 files changed, 223 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
index f2e91d0add7a..7b5053c177fe 100644
--- a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
@@ -16,7 +16,13 @@ maintainers:
 properties:
   compatible:
     enum:
-      - thead,th1520-reset
+      - thead,th1520-reset # Reset controller for VO subsystem
+      - thead,th1520-reset-ao
+      - thead,th1520-reset-ap
+      - thead,th1520-reset-dsp
+      - thead,th1520-reset-misc
+      - thead,th1520-reset-vi
+      - thead,th1520-reset-vp
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/reset/thead,th1520-reset.h b/include/dt-bindings/reset/thead,th1520-reset.h
index e51d6314d131..ba6805b6b12a 100644
--- a/include/dt-bindings/reset/thead,th1520-reset.h
+++ b/include/dt-bindings/reset/thead,th1520-reset.h
@@ -7,6 +7,200 @@
 #ifndef _DT_BINDINGS_TH1520_RESET_H
 #define _DT_BINDINGS_TH1520_RESET_H
 
+/* AO Subsystem */
+#define TH1520_RESET_ID_SYSTEM		0
+#define TH1520_RESET_ID_RTC_APB		1
+#define TH1520_RESET_ID_RTC_REF		2
+#define TH1520_RESET_ID_AOGPIO_DB	3
+#define TH1520_RESET_ID_AOGPIO_APB	4
+#define TH1520_RESET_ID_AOI2C_APB	5
+#define TH1520_RESET_ID_PVT_APB		6
+#define TH1520_RESET_ID_E902_CORE	7
+#define TH1520_RESET_ID_E902_HAD	8
+#define TH1520_RESET_ID_AOTIMER_APB	9
+#define TH1520_RESET_ID_AOTIMER_CORE	10
+#define TH1520_RESET_ID_AOWDT_APB	11
+#define TH1520_RESET_ID_APSYS		12
+#define TH1520_RESET_ID_NPUSYS		13
+#define TH1520_RESET_ID_DDRSYS		14
+#define TH1520_RESET_ID_AXI_AP2CP	15
+#define TH1520_RESET_ID_AXI_CP2AP	16
+#define TH1520_RESET_ID_AXI_CP2SRAM	17
+#define TH1520_RESET_ID_AUDSYS_CORE	18
+#define TH1520_RESET_ID_AUDSYS_IOPMP	19
+#define TH1520_RESET_ID_AUDSYS		20
+#define TH1520_RESET_ID_DSP0		21
+#define TH1520_RESET_ID_DSP1		22
+#define TH1520_RESET_ID_GPU_MODULE	23
+#define TH1520_RESET_ID_VDEC		24
+#define TH1520_RESET_ID_VENC		25
+#define TH1520_RESET_ID_ADC_APB		26
+#define TH1520_RESET_ID_AUDGPIO_DB	27
+#define TH1520_RESET_ID_AUDGPIO_APB	28
+#define TH1520_RESET_ID_AOUART_IF	29
+#define TH1520_RESET_ID_AOUART_APB	30
+#define TH1520_RESET_ID_SRAM_AXI_P0	31
+#define TH1520_RESET_ID_SRAM_AXI_P1	32
+#define TH1520_RESET_ID_SRAM_AXI_P2	33
+#define TH1520_RESET_ID_SRAM_AXI_P3	34
+#define TH1520_RESET_ID_SRAM_AXI_P4	35
+#define TH1520_RESET_ID_SRAM_AXI_CORE	36
+#define TH1520_RESET_ID_SE		37
+
+/* AP Subsystem */
+#define TH1520_RESET_ID_BROM			0
+#define TH1520_RESET_ID_C910_TOP		1
+#define TH1520_RESET_ID_NPU			2
+#define TH1520_RESET_ID_WDT0			3
+#define TH1520_RESET_ID_WDT1			4
+#define TH1520_RESET_ID_C910_C0			5
+#define TH1520_RESET_ID_C910_C1			6
+#define TH1520_RESET_ID_C910_C2			7
+#define TH1520_RESET_ID_C910_C3			8
+#define TH1520_RESET_ID_CHIP_DBG_CORE		9
+#define TH1520_RESET_ID_CHIP_DBG_AXI		10
+#define TH1520_RESET_ID_AXI4_CPUSYS2_AXI	11
+#define TH1520_RESET_ID_AXI4_CPUSYS2_APB	12
+#define TH1520_RESET_ID_X2H_CPUSYS		13
+#define TH1520_RESET_ID_AHB2_CPUSYS		14
+#define TH1520_RESET_ID_APB3_CPUSYS		15
+#define TH1520_RESET_ID_MBOX0_APB		16
+#define TH1520_RESET_ID_MBOX1_APB		17
+#define TH1520_RESET_ID_MBOX2_APB		18
+#define TH1520_RESET_ID_MBOX3_APB		19
+#define TH1520_RESET_ID_TIMER0_APB		20
+#define TH1520_RESET_ID_TIMER0_CORE		21
+#define TH1520_RESET_ID_TIMER1_APB		22
+#define TH1520_RESET_ID_TIMER1_CORE		23
+#define TH1520_RESET_ID_PERISYS_AHB		24
+#define TH1520_RESET_ID_PERISYS_APB1		25
+#define TH1520_RESET_ID_PERISYS_APB2		26
+#define TH1520_RESET_ID_GMAC0_APB		27
+#define TH1520_RESET_ID_GMAC0_AHB		28
+#define TH1520_RESET_ID_GMAC0_CLKGEN		29
+#define TH1520_RESET_ID_GMAC0_AXI		30
+#define TH1520_RESET_ID_UART0_APB		31
+#define TH1520_RESET_ID_UART0_IF		32
+#define TH1520_RESET_ID_UART1_APB		33
+#define TH1520_RESET_ID_UART1_IF		34
+#define TH1520_RESET_ID_UART2_APB		35
+#define TH1520_RESET_ID_UART2_IF		36
+#define TH1520_RESET_ID_UART3_APB		37
+#define TH1520_RESET_ID_UART3_IF		38
+#define TH1520_RESET_ID_UART4_APB		39
+#define TH1520_RESET_ID_UART4_IF		40
+#define TH1520_RESET_ID_UART5_APB		41
+#define TH1520_RESET_ID_UART5_IF		42
+#define TH1520_RESET_ID_QSPI0_IF		43
+#define TH1520_RESET_ID_QSPI0_APB		44
+#define TH1520_RESET_ID_QSPI1_IF		45
+#define TH1520_RESET_ID_QSPI1_APB		46
+#define TH1520_RESET_ID_SPI_IF			47
+#define TH1520_RESET_ID_SPI_APB			48
+#define TH1520_RESET_ID_I2C0_APB		49
+#define TH1520_RESET_ID_I2C0_CORE		50
+#define TH1520_RESET_ID_I2C1_APB		51
+#define TH1520_RESET_ID_I2C1_CORE		52
+#define TH1520_RESET_ID_I2C2_APB		53
+#define TH1520_RESET_ID_I2C2_CORE		54
+#define TH1520_RESET_ID_I2C3_APB		55
+#define TH1520_RESET_ID_I2C3_CORE		56
+#define TH1520_RESET_ID_I2C4_APB		57
+#define TH1520_RESET_ID_I2C4_CORE		58
+#define TH1520_RESET_ID_I2C5_APB		59
+#define TH1520_RESET_ID_I2C5_CORE		60
+#define TH1520_RESET_ID_GPIO0_DB		61
+#define TH1520_RESET_ID_GPIO0_APB		62
+#define TH1520_RESET_ID_GPIO1_DB		63
+#define TH1520_RESET_ID_GPIO1_APB		64
+#define TH1520_RESET_ID_GPIO2_DB		65
+#define TH1520_RESET_ID_GPIO2_APB		66
+#define TH1520_RESET_ID_PWM_COUNTER		67
+#define TH1520_RESET_ID_PWM_APB			68
+#define TH1520_RESET_ID_PADCTRL0_APB		69
+#define TH1520_RESET_ID_CPU2PERI_X2H		70
+#define TH1520_RESET_ID_CPU2AON_X2H		71
+#define TH1520_RESET_ID_AON2CPU_A2X		72
+#define TH1520_RESET_ID_NPUSYS_AXI		73
+#define TH1520_RESET_ID_NPUSYS_AXI_APB		74
+#define TH1520_RESET_ID_CPU2VP_X2P		75
+#define TH1520_RESET_ID_CPU2VI_X2H		76
+#define TH1520_RESET_ID_BMU_AXI			77
+#define TH1520_RESET_ID_BMU_APB			78
+#define TH1520_RESET_ID_DMAC_CPUSYS_AXI		79
+#define TH1520_RESET_ID_DMAC_CPUSYS_AHB		80
+#define TH1520_RESET_ID_SPINLOCK		81
+#define TH1520_RESET_ID_CFG2TEE			82
+#define TH1520_RESET_ID_DSMART			83
+#define TH1520_RESET_ID_GPIO3_DB		84
+#define TH1520_RESET_ID_GPIO3_APB		85
+#define TH1520_RESET_ID_PERI_I2S		86
+#define TH1520_RESET_ID_PERI_APB3		87
+#define TH1520_RESET_ID_PERI2PERI1_APB		88
+#define TH1520_RESET_ID_VPSYS_APB		89
+#define TH1520_RESET_ID_PERISYS_APB4		90
+#define TH1520_RESET_ID_GMAC1_APB		91
+#define TH1520_RESET_ID_GMAC1_AHB		92
+#define TH1520_RESET_ID_GMAC1_CLKGEN		93
+#define TH1520_RESET_ID_GMAC1_AXI		94
+#define TH1520_RESET_ID_GMAC_AXI		95
+#define TH1520_RESET_ID_GMAC_AXI_APB		96
+#define TH1520_RESET_ID_PADCTRL1_APB		97
+#define TH1520_RESET_ID_VOSYS_AXI		98
+#define TH1520_RESET_ID_VOSYS_AXI_APB		99
+#define TH1520_RESET_ID_VOSYS_AXI_X2X		100
+#define TH1520_RESET_ID_MISC2VP_X2X		101
+#define TH1520_RESET_ID_DSPSYS			102
+#define TH1520_RESET_ID_VISYS			103
+#define TH1520_RESET_ID_VOSYS			104
+#define TH1520_RESET_ID_VPSYS			105
+
+/* DSP Subsystem */
+#define TH1520_RESET_ID_X2X_DSP1	0
+#define TH1520_RESET_ID_X2X_DSP0	1
+#define TH1520_RESET_ID_X2X_SLAVE_DSP1	2
+#define TH1520_RESET_ID_X2X_SLAVE_DSP0	3
+#define TH1520_RESET_ID_DSP0_CORE	4
+#define TH1520_RESET_ID_DSP0_DEBUG	5
+#define TH1520_RESET_ID_DSP0_APB	6
+#define TH1520_RESET_ID_DSP1_CORE	7
+#define TH1520_RESET_ID_DSP1_DEBUG	8
+#define TH1520_RESET_ID_DSP1_APB	9
+#define TH1520_RESET_ID_DSPSYS_APB	10
+#define TH1520_RESET_ID_AXI4_DSPSYS_SLV	11
+#define TH1520_RESET_ID_AXI4_DSPSYS	12
+#define TH1520_RESET_ID_AXI4_DSP_RS	13
+
+/* MISC Subsystem */
+#define TH1520_RESET_ID_EMMC_SDIO_CLKGEN	0
+#define TH1520_RESET_ID_EMMC			1
+#define TH1520_RESET_ID_MISCSYS_AXI		2
+#define TH1520_RESET_ID_MISCSYS_AXI_APB		3
+#define TH1520_RESET_ID_SDIO0			4
+#define TH1520_RESET_ID_SDIO1			5
+#define TH1520_RESET_ID_USB3_APB		6
+#define TH1520_RESET_ID_USB3_PHY		7
+#define TH1520_RESET_ID_USB3_VCC		8
+
+/* VI Subsystem */
+#define TH1520_RESET_ID_ISP0		0
+#define TH1520_RESET_ID_ISP1		1
+#define TH1520_RESET_ID_CSI0_APB	2
+#define TH1520_RESET_ID_CSI1_APB	3
+#define TH1520_RESET_ID_CSI2_APB	4
+#define TH1520_RESET_ID_MIPI_FIFO	5
+#define TH1520_RESET_ID_ISP_VENC_APB	6
+#define TH1520_RESET_ID_VIPRE_APB	7
+#define TH1520_RESET_ID_VIPRE_AXI	8
+#define TH1520_RESET_ID_DW200_APB	9
+#define TH1520_RESET_ID_VISYS3_AXI	10
+#define TH1520_RESET_ID_VISYS2_AXI	11
+#define TH1520_RESET_ID_VISYS1_AXI	12
+#define TH1520_RESET_ID_VISYS_AXI	13
+#define TH1520_RESET_ID_VISYS_APB	14
+#define TH1520_RESET_ID_ISP_VENC_AXI	15
+
+/* VO Subsystem */
 #define TH1520_RESET_ID_GPU		0
 #define TH1520_RESET_ID_GPU_CLKGEN	1
 #define TH1520_RESET_ID_DPU_AHB		5
@@ -16,5 +210,27 @@
 #define TH1520_RESET_ID_DSI1_APB	9
 #define TH1520_RESET_ID_HDMI		10
 #define TH1520_RESET_ID_HDMI_APB	11
+#define TH1520_RESET_ID_VOAXI		12
+#define TH1520_RESET_ID_VOAXI_APB	13
+#define TH1520_RESET_ID_X2H_DPU_AXI	14
+#define TH1520_RESET_ID_X2H_DPU_AHB	15
+#define TH1520_RESET_ID_X2H_DPU1_AXI	16
+#define TH1520_RESET_ID_X2H_DPU1_AHB	17
+
+/* VP Subsystem */
+#define TH1520_RESET_ID_VPSYS_AXI_APB	0
+#define TH1520_RESET_ID_VPSYS_AXI	1
+#define TH1520_RESET_ID_FCE_APB		2
+#define TH1520_RESET_ID_FCE_CORE	3
+#define TH1520_RESET_ID_FCE_X2X_MASTER	4
+#define TH1520_RESET_ID_FCE_X2X_SLAVE	5
+#define TH1520_RESET_ID_G2D_APB		6
+#define TH1520_RESET_ID_G2D_ACLK	7
+#define TH1520_RESET_ID_G2D_CORE	8
+#define TH1520_RESET_ID_VDEC_APB	9
+#define TH1520_RESET_ID_VDEC_ACLK	10
+#define TH1520_RESET_ID_VDEC_CORE	11
+#define TH1520_RESET_ID_VENC_APB	12
+#define TH1520_RESET_ID_VENC_CORE	13
 
 #endif /* _DT_BINDINGS_TH1520_RESET_H */
-- 
2.50.1


