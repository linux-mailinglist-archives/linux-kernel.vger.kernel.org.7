Return-Path: <linux-kernel+bounces-793787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83987B3D833
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB413189867E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0220C22259D;
	Mon,  1 Sep 2025 04:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="F0YBp+yz"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F311DEFDD;
	Mon,  1 Sep 2025 04:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756700645; cv=none; b=GaQ9/oE7GDfySbPB/AJwhFwhLkz0Mq8B96DaERZVG1rkdRuHsVoD9miKeEJA4j4fVYDT2DPZQenlyBuci511fbOGoLqOVzzqV4q+YP8Db0CwVDteuU6Eq58rQheMXqNqDekzkrovPLPLE28taMc3UXTURlPGsj0l6CoeqTsp29g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756700645; c=relaxed/simple;
	bh=lpuh/P1JaJvF975oPEFRFTVX94rVAa187fxs5AM6K28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMLCc5pn6mBvAXm9mRyz+mdEwZa8/8CNBmj/RtQcidI+RFxarbcdK3wGUu0VLMgJGA6HK1dS1Kny9f0OoKy8P8DAicW7IlvgTShI2iiRDKyrfP365zo8wCLnD/R5sUbX0Dk2T7I7+yaBfj38w6aiCpa88iYewd3VUfDGKv3jtS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=F0YBp+yz; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 08DA020A4A;
	Mon,  1 Sep 2025 06:24:01 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gelxejH5fRVV; Mon,  1 Sep 2025 06:24:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1756700640; bh=lpuh/P1JaJvF975oPEFRFTVX94rVAa187fxs5AM6K28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F0YBp+yz14QtxYUNFlICyKrRa+gYF88OYQSCIipxQ+eqTMde3dyDQvC19qgr427dB
	 v+GiAP+bEWGD655Q0VF+fot9JVXULWcjO1KM23VTA6CdjJ2jur0QEOtZ2cb/Orv8xd
	 LqaSNYqokN4ZQPYhYbPtfvK4L6GgbSqNr+DVQ28iyE1u9PyqLCKlb/94bzUZ9JuzG0
	 XvYQKUvnPzLGcm1JiFEy27S04snFO1aKD2+zW6kjIeQH+ceFl7Mvm1lVTL82UeFLT7
	 hLvLhzSx9u71BYM1yds3ZQCKdTNp3zMFuNOEnF1i0ztsZbmLFulmBGFH/79fKvVlTc
	 9KtCO1NzcXP3g==
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
Subject: [PATCH 1/4] dt-bindings: reset: thead,th1520-reset: Add controllers for more subsys
Date: Mon,  1 Sep 2025 04:23:17 +0000
Message-ID: <20250901042320.22865-2-ziyao@disroot.org>
In-Reply-To: <20250901042320.22865-1-ziyao@disroot.org>
References: <20250901042320.22865-1-ziyao@disroot.org>
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
---
 .../bindings/reset/thead,th1520-reset.yaml    |   8 +-
 .../dt-bindings/reset/thead,th1520-reset.h    | 219 +++++++++++++++++-
 2 files changed, 223 insertions(+), 4 deletions(-)

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
index ee799286c175..927e251edfab 100644
--- a/include/dt-bindings/reset/thead,th1520-reset.h
+++ b/include/dt-bindings/reset/thead,th1520-reset.h
@@ -7,11 +7,186 @@
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
+#define TH1520_RESET_ID_C910_C1			5
+#define TH1520_RESET_ID_C910_C2			5
+#define TH1520_RESET_ID_C910_C3			5
+#define TH1520_RESET_ID_CHIP_DBG_CORE		6
+#define TH1520_RESET_ID_CHIP_DBG_AXI		7
+#define TH1520_RESET_ID_AXI4_CPUSYS2_AXI	8
+#define TH1520_RESET_ID_AXI4_CPUSYS2_APB	9
+#define TH1520_RESET_ID_X2H_CPUSYS		10
+#define TH1520_RESET_ID_AHB2_CPUSYS		11
+#define TH1520_RESET_ID_APB3_CPUSYS		12
+#define TH1520_RESET_ID_MBOX0_APB		13
+#define TH1520_RESET_ID_MBOX1_APB		14
+#define TH1520_RESET_ID_MBOX2_APB		15
+#define TH1520_RESET_ID_MBOX3_APB		16
+#define TH1520_RESET_ID_TIMER0_APB		17
+#define TH1520_RESET_ID_TIMER0_CORE		18
+#define TH1520_RESET_ID_TIMER1_APB		19
+#define TH1520_RESET_ID_TIMER1_CORE		20
+#define TH1520_RESET_ID_PERISYS_AHB		21
+#define TH1520_RESET_ID_PERISYS_APB1		22
+#define TH1520_RESET_ID_PERISYS_APB2		23
+#define TH1520_RESET_ID_GMAC0_APB		24
+#define TH1520_RESET_ID_GMAC0_AHB		25
+#define TH1520_RESET_ID_GMAC0_CLKGEN		26
+#define TH1520_RESET_ID_GMAC0_AXI		27
+#define TH1520_RESET_ID_UART0_APB		28
+#define TH1520_RESET_ID_UART0_IF		29
+#define TH1520_RESET_ID_UART1_APB		30
+#define TH1520_RESET_ID_UART1_IF		31
+#define TH1520_RESET_ID_UART2_APB		32
+#define TH1520_RESET_ID_UART2_IF		33
+#define TH1520_RESET_ID_UART3_APB		34
+#define TH1520_RESET_ID_UART3_IF		35
+#define TH1520_RESET_ID_UART4_APB		36
+#define TH1520_RESET_ID_UART4_IF		37
+#define TH1520_RESET_ID_UART5_APB		38
+#define TH1520_RESET_ID_UART5_IF		39
+#define TH1520_RESET_ID_QSPI0_IF		40
+#define TH1520_RESET_ID_QSPI0_APB		41
+#define TH1520_RESET_ID_QSPI1_IF		42
+#define TH1520_RESET_ID_QSPI1_APB		43
+#define TH1520_RESET_ID_SPI_IF			44
+#define TH1520_RESET_ID_SPI_APB			45
+#define TH1520_RESET_ID_I2C0_APB		46
+#define TH1520_RESET_ID_I2C0_CORE		47
+#define TH1520_RESET_ID_I2C1_APB		48
+#define TH1520_RESET_ID_I2C1_CORE		49
+#define TH1520_RESET_ID_I2C2_APB		50
+#define TH1520_RESET_ID_I2C2_CORE		51
+#define TH1520_RESET_ID_I2C3_APB		52
+#define TH1520_RESET_ID_I2C3_CORE		53
+#define TH1520_RESET_ID_I2C4_APB		54
+#define TH1520_RESET_ID_I2C4_CORE		55
+#define TH1520_RESET_ID_I2C5_APB		56
+#define TH1520_RESET_ID_I2C5_CORE		57
+#define TH1520_RESET_ID_GPIO0_DB		58
+#define TH1520_RESET_ID_GPIO0_APB		59
+#define TH1520_RESET_ID_GPIO1_DB		60
+#define TH1520_RESET_ID_GPIO1_APB		61
+#define TH1520_RESET_ID_GPIO2_DB		62
+#define TH1520_RESET_ID_GPIO2_APB		63
+#define TH1520_RESET_ID_PWM_COUNTER		64
+#define TH1520_RESET_ID_PWM_APB			65
+#define TH1520_RESET_ID_PADCTRL0_APB		66
+#define TH1520_RESET_ID_CPU2PERI_X2H		67
+#define TH1520_RESET_ID_CPU2AON_X2H		68
+#define TH1520_RESET_ID_AON2CPU_A2X		69
+#define TH1520_RESET_ID_NPUSYS_AXI		70
+#define TH1520_RESET_ID_NPUSYS_AXI_APB		71
+#define TH1520_RESET_ID_CPU2VP_X2P		72
+#define TH1520_RESET_ID_CPU2VI_X2H		73
+#define TH1520_RESET_ID_BMU_AXI			74
+#define TH1520_RESET_ID_BMU_APB			75
+#define TH1520_RESET_ID_DMAC_CPUSYS_AXI		76
+#define TH1520_RESET_ID_DMAC_CPUSYS_AHB		77
+#define TH1520_RESET_ID_SPINLOCK		78
+#define TH1520_RESET_ID_CFG2TEE			79
+#define TH1520_RESET_ID_DSMART			80
+#define TH1520_RESET_ID_GPIO3_DB		81
+#define TH1520_RESET_ID_GPIO3_APB		82
+#define TH1520_RESET_ID_PERI_I2S		83
+#define TH1520_RESET_ID_PERI_APB3		84
+#define TH1520_RESET_ID_PERI2PERI1_APB		85
+#define TH1520_RESET_ID_VPSYS_APB		86
+#define TH1520_RESET_ID_PERISYS_APB4		87
+#define TH1520_RESET_ID_GMAC1_APB		88
+#define TH1520_RESET_ID_GMAC1_AHB		89
+#define TH1520_RESET_ID_GMAC1_CLKGEN		90
+#define TH1520_RESET_ID_GMAC1_AXI		91
+#define TH1520_RESET_ID_GMAC_AXI		92
+#define TH1520_RESET_ID_GMAC_AXI_APB		93
+#define TH1520_RESET_ID_PADCTRL1_APB		94
+#define TH1520_RESET_ID_VOSYS_AXI		95
+#define TH1520_RESET_ID_VOSYS_AXI_APB		96
+#define TH1520_RESET_ID_VOSYS_AXI_X2X		97
+#define TH1520_RESET_ID_MISC2VP_X2X		98
+#define TH1520_RESET_ID_DSPSYS			99
+#define TH1520_RESET_ID_VISYS			100
+#define TH1520_RESET_ID_VOSYS			101
+#define TH1520_RESET_ID_VPSYS			102
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
-#define TH1520_RESET_ID_NPU		2
-#define TH1520_RESET_ID_WDT0		3
-#define TH1520_RESET_ID_WDT1		4
 #define TH1520_RESET_ID_DPU_AHB		5
 #define TH1520_RESET_ID_DPU_AXI		6
 #define TH1520_RESET_ID_DPU_CORE	7
@@ -19,5 +194,43 @@
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
+
+/* DSP Subsystem */
+#define TH1520_RESET_ID_X2X_DSP1	0
+#define TH1520_RESET_ID_X2X_DSP0	1
+#define TH1520_RESET_ID_X2X_SLAVE_DSP1	2
+#define TH1520_RESET_ID_X2X_SLAVE_DSP0	3
+#define TH1520_RESET_ID_DSP0_CORE	4
+#define TH1520_RESET_ID_DSP0_DEBUG	5
+#define TH1520_RESET_ID_DSP0_APB	6
+#define TH1520_RESET_ID_DSP1_CORE	4
+#define TH1520_RESET_ID_DSP1_DEBUG	5
+#define TH1520_RESET_ID_DSP1_APB	6
+#define TH1520_RESET_ID_DSPSYS_APB	7
+#define TH1520_RESET_ID_AXI4_DSPSYS_SLV	8
+#define TH1520_RESET_ID_AXI4_DSPSYS	9
+#define TH1520_RESET_ID_AXI4_DSP_RS	10
 
 #endif /* _DT_BINDINGS_TH1520_RESET_H */
-- 
2.50.1


