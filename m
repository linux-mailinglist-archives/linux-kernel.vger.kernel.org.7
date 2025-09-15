Return-Path: <linux-kernel+bounces-816555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967A7B57551
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BC017F8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4032FAC17;
	Mon, 15 Sep 2025 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PHJodGZS"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA912F9C29;
	Mon, 15 Sep 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930130; cv=none; b=IYxWGATd27ZIgCIDPZYgchWWmY8fz0xATh4VLu2t/XE7LUGKGQid+UX1wm/PibrYt1gwh/QA26Gh8aSsZx1UXB3BTB28vmvsJwj1HuGoGNSPk60SUGSAwfGufIQUYdHrA+oMOAPjh4W3YryzaDLbW9YmdeCsYLtB51bJ7CJ2Yjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930130; c=relaxed/simple;
	bh=wMfyu2mJ32RXn85J3zGKswXTVynVcyfYpa47hNhoBNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ga2bSwThtHEOTa8Ur0x3nMiOzhFHeHFJQ/OKLKOWMDua3xSAqDIWm8/PVM/7QjPaVrBrBErc2UUantimil0E82lcA5hiRzZGFRpuw5QyOHIF+cdbPAvu7Dv4jAWs5VUA9wYHp/ahSlp0ULd0JEGfMLBF8lk/q0vGqMIzkreklc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PHJodGZS; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BABCE25D5F;
	Mon, 15 Sep 2025 11:55:25 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d-9t2E7EjzB0; Mon, 15 Sep 2025 11:55:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757930124; bh=wMfyu2mJ32RXn85J3zGKswXTVynVcyfYpa47hNhoBNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PHJodGZSR7wF+K996bbo5huIXJzqZXsXVzBQKh8A48K7gY55+LtKrvRdtWeIdTqUM
	 /DcxiFc8AKFFLS3jjRkNN7U0ZWdRmWYkvok82XumcgyC1oeeH8y2gWwr1SGhnVqj0U
	 G7fQE2hdXnyirtK1Q/P7tAuVSWi/9oma4wXl7TF5f7xQfbCTFXq1Mo//aQsrbVrzBY
	 gTeaCoPzeTPISsN761GE5cddsIKaDP3Eb9RJnyF2uBimCs8uTjOISfqn1N8ZlhxRQx
	 RpLfTz4Og56NfS9ojad5NibO0ZXx4v3HWw7fz029FD5VihERNKupwBjHdzIT59XYo7
	 JnjltBoKZgL1w==
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
Subject: [PATCH v2 4/5] reset: th1520: Support reset controllers in more subsystems
Date: Mon, 15 Sep 2025 09:53:30 +0000
Message-ID: <20250915095331.53350-5-ziyao@disroot.org>
In-Reply-To: <20250915095331.53350-1-ziyao@disroot.org>
References: <20250915095331.53350-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce reset controllers for AP, MISC, VI, VP and DSP subsystems and
add their reset signal mappings.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/reset/reset-th1520.c | 793 +++++++++++++++++++++++++++++++++++
 1 file changed, 793 insertions(+)

diff --git a/drivers/reset/reset-th1520.c b/drivers/reset/reset-th1520.c
index 2b65a95ed021..fd32e991c4cb 100644
--- a/drivers/reset/reset-th1520.c
+++ b/drivers/reset/reset-th1520.c
@@ -11,6 +11,85 @@
 
 #include <dt-bindings/reset/thead,th1520-reset.h>
 
+ /* register offset in RSTGEN_R */
+#define TH1520_BROM_RST_CFG		0x0
+#define TH1520_C910_RST_CFG		0x4
+#define TH1520_CHIP_DBG_RST_CFG		0xc
+#define TH1520_AXI4_CPUSYS2_RST_CFG	0x10
+#define TH1520_X2H_CPUSYS_RST_CFG	0x18
+#define TH1520_AHB2_CPUSYS_RST_CFG	0x1c
+#define TH1520_APB3_CPUSYS_RST_CFG	0x20
+#define TH1520_MBOX0_RST_CFG		0x24
+#define TH1520_MBOX1_RST_CFG		0x28
+#define TH1520_MBOX2_RST_CFG		0x2c
+#define TH1520_MBOX3_RST_CFG		0x30
+#define TH1520_WDT0_RST_CFG		0x34
+#define TH1520_WDT1_RST_CFG		0x38
+#define TH1520_TIMER0_RST_CFG		0x3c
+#define TH1520_TIMER1_RST_CFG		0x40
+#define TH1520_PERISYS_AHB_RST_CFG	0x44
+#define TH1520_PERISYS_APB1_RST_CFG	0x48
+#define TH1520_PERISYS_APB2_RST_CFG	0x4c
+#define TH1520_GMAC0_RST_CFG		0x68
+#define TH1520_UART0_RST_CFG		0x70
+#define TH1520_UART1_RST_CFG		0x74
+#define TH1520_UART2_RST_CFG		0x78
+#define TH1520_UART3_RST_CFG		0x7c
+#define TH1520_UART4_RST_CFG		0x80
+#define TH1520_UART5_RST_CFG		0x84
+#define TH1520_QSPI0_RST_CFG		0x8c
+#define TH1520_QSPI1_RST_CFG		0x90
+#define TH1520_SPI_RST_CFG		0x94
+#define TH1520_I2C0_RST_CFG		0x98
+#define TH1520_I2C1_RST_CFG		0x9c
+#define TH1520_I2C2_RST_CFG		0xa0
+#define TH1520_I2C3_RST_CFG		0xa4
+#define TH1520_I2C4_RST_CFG		0xa8
+#define TH1520_I2C5_RST_CFG		0xac
+#define TH1520_GPIO0_RST_CFG		0xb0
+#define TH1520_GPIO1_RST_CFG		0xb4
+#define TH1520_GPIO2_RST_CFG		0xb8
+#define TH1520_PWM_RST_CFG		0xc0
+#define TH1520_PADCTRL0_APSYS_RST_CFG	0xc4
+#define TH1520_CPU2PERI_X2H_RST_CFG	0xcc
+#define TH1520_CPU2AON_X2H_RST_CFG	0xe4
+#define TH1520_AON2CPU_A2X_RST_CFG	0xfc
+#define TH1520_NPUSYS_AXI_RST_CFG	0x128
+#define TH1520_CPU2VP_X2P_RST_CFG	0x12c
+#define TH1520_CPU2VI_X2H_RST_CFG	0x138
+#define TH1520_BMU_C910_RST_CFG		0x148
+#define TH1520_DMAC_CPUSYS_RST_CFG	0x14c
+#define TH1520_SPINLOCK_RST_CFG		0x178
+#define TH1520_CFG2TEE_X2H_RST_CFG	0x188
+#define TH1520_DSMART_RST_CFG		0x18c
+#define TH1520_GPIO3_RST_CFG		0x1a8
+#define TH1520_I2S_RST_CFG		0x1ac
+#define TH1520_IMG_NNA_RST_CFG		0x1b0
+#define TH1520_PERI_APB3_RST_CFG	0x1dc
+#define TH1520_VP_SUBSYS_RST_CFG	0x1ec
+#define TH1520_PERISYS_APB4_RST_CFG	0x1f8
+#define TH1520_GMAC1_RST_CFG		0x204
+#define TH1520_GMAC_AXI_RST_CFG		0x208
+#define TH1520_PADCTRL1_APSYS_RST_CFG	0x20c
+#define TH1520_VOSYS_AXI_RST_CFG	0x210
+#define TH1520_VOSYS_X2X_RST_CFG	0x214
+#define TH1520_MISC2VP_X2X_RST_CFG	0x218
+#define TH1520_SUBSYS_RST_CFG		0x220
+
+ /* register offset in DSP_REGMAP */
+#define TH1520_DSPSYS_RST_CFG		0x0
+
+ /* register offset in MISCSYS_REGMAP */
+#define TH1520_EMMC_RST_CFG		0x0
+#define TH1520_MISCSYS_AXI_RST_CFG	0x8
+#define TH1520_SDIO0_RST_CFG		0xc
+#define TH1520_SDIO1_RST_CFG		0x10
+#define TH1520_USB3_DRD_RST_CFG		0x14
+
+ /* register offset in VISYS_REGMAP */
+#define TH1520_VISYS_RST_CFG		0x0
+#define TH1520_VISYS_2_RST_CFG		0x4
+
  /* register offset in VOSYS_REGMAP */
 #define TH1520_GPU_RST_CFG		0x0
 #define TH1520_GPU_RST_CFG_MASK		GENMASK(1, 0)
@@ -18,6 +97,8 @@
 #define TH1520_DSI0_RST_CFG		0x8
 #define TH1520_DSI1_RST_CFG		0xc
 #define TH1520_HDMI_RST_CFG		0x14
+#define TH1520_AXI4_VO_DW_AXI_RST_CFG	0x18
+#define TH1520_X2H_X4_VOSYS_DW_RST_CFG	0x20
 
 /* register values */
 #define TH1520_GPU_SW_GPU_RST		BIT(0)
@@ -29,6 +110,13 @@
 #define TH1520_HDMI_SW_MAIN_RST		BIT(0)
 #define TH1520_HDMI_SW_PRST		BIT(1)
 
+ /* register offset in VPSYS_REGMAP */
+#define TH1520_AXIBUS_RST_CFG		0x0
+#define TH1520_FCE_RST_CFG		0x4
+#define TH1520_G2D_RST_CFG		0x8
+#define TH1520_VDEC_RST_CFG		0xc
+#define TH1520_VENC_RST_CFG		0x10
+
 struct th1520_reset_map {
 	u32 bit;
 	u32 reg;
@@ -82,6 +170,681 @@ static const struct th1520_reset_map th1520_resets[] = {
 		.bit = TH1520_HDMI_SW_PRST,
 		.reg = TH1520_HDMI_RST_CFG,
 	},
+	[TH1520_RESET_ID_VOAXI] = {
+		.bit = BIT(0),
+		.reg = TH1520_AXI4_VO_DW_AXI_RST_CFG,
+	},
+	[TH1520_RESET_ID_VOAXI_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_AXI4_VO_DW_AXI_RST_CFG,
+	},
+	[TH1520_RESET_ID_X2H_DPU_AXI] = {
+		.bit = BIT(0),
+		.reg = TH1520_X2H_X4_VOSYS_DW_RST_CFG,
+	},
+	[TH1520_RESET_ID_X2H_DPU_AHB] = {
+		.bit = BIT(1),
+		.reg = TH1520_X2H_X4_VOSYS_DW_RST_CFG,
+	},
+	[TH1520_RESET_ID_X2H_DPU1_AXI] = {
+		.bit = BIT(2),
+		.reg = TH1520_X2H_X4_VOSYS_DW_RST_CFG,
+	},
+	[TH1520_RESET_ID_X2H_DPU1_AHB] = {
+		.bit = BIT(3),
+		.reg = TH1520_X2H_X4_VOSYS_DW_RST_CFG,
+	},
+};
+
+static const struct th1520_reset_map th1520_ap_resets[] = {
+	[TH1520_RESET_ID_BROM] = {
+		.bit = BIT(0),
+		.reg = TH1520_BROM_RST_CFG,
+	},
+	[TH1520_RESET_ID_C910_TOP] = {
+		.bit = BIT(0),
+		.reg = TH1520_C910_RST_CFG,
+	},
+	[TH1520_RESET_ID_NPU] =  {
+		.bit = BIT(0),
+		.reg = TH1520_IMG_NNA_RST_CFG,
+	},
+	[TH1520_RESET_ID_WDT0] = {
+		.bit = BIT(0),
+		.reg = TH1520_WDT0_RST_CFG,
+	},
+	[TH1520_RESET_ID_WDT1] = {
+		.bit = BIT(0),
+		.reg = TH1520_WDT1_RST_CFG,
+	},
+	[TH1520_RESET_ID_C910_C0] = {
+		.bit = BIT(1),
+		.reg = TH1520_C910_RST_CFG,
+	},
+	[TH1520_RESET_ID_C910_C1] = {
+		.bit = BIT(2),
+		.reg = TH1520_C910_RST_CFG,
+	},
+	[TH1520_RESET_ID_C910_C2] = {
+		.bit = BIT(3),
+		.reg = TH1520_C910_RST_CFG,
+	},
+	[TH1520_RESET_ID_C910_C3] = {
+		.bit = BIT(4),
+		.reg = TH1520_C910_RST_CFG,
+	},
+	[TH1520_RESET_ID_CHIP_DBG_CORE] = {
+		.bit = BIT(0),
+		.reg = TH1520_CHIP_DBG_RST_CFG,
+	},
+	[TH1520_RESET_ID_CHIP_DBG_AXI] = {
+		.bit = BIT(1),
+		.reg = TH1520_CHIP_DBG_RST_CFG,
+	},
+	[TH1520_RESET_ID_AXI4_CPUSYS2_AXI] = {
+		.bit = BIT(0),
+		.reg = TH1520_AXI4_CPUSYS2_RST_CFG,
+	},
+	[TH1520_RESET_ID_AXI4_CPUSYS2_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_AXI4_CPUSYS2_RST_CFG,
+	},
+	[TH1520_RESET_ID_X2H_CPUSYS] = {
+		.bit = BIT(0),
+		.reg = TH1520_X2H_CPUSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_AHB2_CPUSYS] = {
+		.bit = BIT(0),
+		.reg = TH1520_AHB2_CPUSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_APB3_CPUSYS] = {
+		.bit = BIT(0),
+		.reg = TH1520_APB3_CPUSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_MBOX0_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_MBOX0_RST_CFG,
+	},
+	[TH1520_RESET_ID_MBOX1_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_MBOX1_RST_CFG,
+	},
+	[TH1520_RESET_ID_MBOX2_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_MBOX2_RST_CFG,
+	},
+	[TH1520_RESET_ID_MBOX3_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_MBOX3_RST_CFG,
+	},
+	[TH1520_RESET_ID_TIMER0_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_TIMER0_RST_CFG,
+	},
+	[TH1520_RESET_ID_TIMER0_CORE] = {
+		.bit = BIT(1),
+		.reg = TH1520_TIMER0_RST_CFG,
+	},
+	[TH1520_RESET_ID_TIMER1_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_TIMER1_RST_CFG,
+	},
+	[TH1520_RESET_ID_TIMER1_CORE] = {
+		.bit = BIT(1),
+		.reg = TH1520_TIMER1_RST_CFG,
+	},
+	[TH1520_RESET_ID_PERISYS_AHB] = {
+		.bit = BIT(0),
+		.reg = TH1520_PERISYS_AHB_RST_CFG,
+	},
+	[TH1520_RESET_ID_PERISYS_APB1] = {
+		.bit = BIT(0),
+		.reg = TH1520_PERISYS_APB1_RST_CFG,
+	},
+	[TH1520_RESET_ID_PERISYS_APB2] = {
+		.bit = BIT(0),
+		.reg = TH1520_PERISYS_APB2_RST_CFG,
+	},
+	[TH1520_RESET_ID_GMAC0_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_GMAC0_RST_CFG,
+	},
+	[TH1520_RESET_ID_GMAC0_AHB] = {
+		.bit = BIT(1),
+		.reg = TH1520_GMAC0_RST_CFG,
+	},
+	[TH1520_RESET_ID_GMAC0_CLKGEN] = {
+		.bit = BIT(2),
+		.reg = TH1520_GMAC0_RST_CFG,
+	},
+	[TH1520_RESET_ID_GMAC0_AXI] = {
+		.bit = BIT(3),
+		.reg = TH1520_GMAC0_RST_CFG,
+	},
+	[TH1520_RESET_ID_UART0_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_UART0_RST_CFG,
+	},
+	[TH1520_RESET_ID_UART0_IF] = {
+		.bit = BIT(1),
+		.reg = TH1520_UART0_RST_CFG,
+	},
+	[TH1520_RESET_ID_UART1_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_UART1_RST_CFG,
+	},
+	[TH1520_RESET_ID_UART1_IF] = {
+		.bit = BIT(1),
+		.reg = TH1520_UART1_RST_CFG,
+	},
+	[TH1520_RESET_ID_UART2_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_UART2_RST_CFG,
+	},
+	[TH1520_RESET_ID_UART2_IF] = {
+		.bit = BIT(1),
+		.reg = TH1520_UART2_RST_CFG,
+	},
+	[TH1520_RESET_ID_UART3_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_UART3_RST_CFG,
+	},
+	[TH1520_RESET_ID_UART3_IF] = {
+		.bit = BIT(1),
+		.reg = TH1520_UART3_RST_CFG,
+	},
+	[TH1520_RESET_ID_UART4_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_UART4_RST_CFG,
+	},
+	[TH1520_RESET_ID_UART4_IF] = {
+		.bit = BIT(1),
+		.reg = TH1520_UART4_RST_CFG,
+	},
+	[TH1520_RESET_ID_UART5_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_UART5_RST_CFG,
+	},
+	[TH1520_RESET_ID_UART5_IF] = {
+		.bit = BIT(1),
+		.reg = TH1520_UART5_RST_CFG,
+	},
+	[TH1520_RESET_ID_QSPI0_IF] = {
+		.bit = BIT(0),
+		.reg = TH1520_QSPI0_RST_CFG,
+	},
+	[TH1520_RESET_ID_QSPI0_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_QSPI0_RST_CFG,
+	},
+	[TH1520_RESET_ID_QSPI1_IF] = {
+		.bit = BIT(0),
+		.reg = TH1520_QSPI1_RST_CFG,
+	},
+	[TH1520_RESET_ID_QSPI1_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_QSPI1_RST_CFG,
+	},
+	[TH1520_RESET_ID_SPI_IF] = {
+		.bit = BIT(0),
+		.reg = TH1520_SPI_RST_CFG,
+	},
+	[TH1520_RESET_ID_SPI_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_SPI_RST_CFG,
+	},
+	[TH1520_RESET_ID_I2C0_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_I2C0_RST_CFG,
+	},
+	[TH1520_RESET_ID_I2C0_CORE] = {
+		.bit = BIT(1),
+		.reg = TH1520_I2C0_RST_CFG,
+	},
+	[TH1520_RESET_ID_I2C1_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_I2C1_RST_CFG,
+	},
+	[TH1520_RESET_ID_I2C1_CORE] = {
+		.bit = BIT(1),
+		.reg = TH1520_I2C1_RST_CFG,
+	},
+	[TH1520_RESET_ID_I2C2_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_I2C2_RST_CFG,
+	},
+	[TH1520_RESET_ID_I2C2_CORE] = {
+		.bit = BIT(1),
+		.reg = TH1520_I2C2_RST_CFG,
+	},
+	[TH1520_RESET_ID_I2C3_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_I2C3_RST_CFG,
+	},
+	[TH1520_RESET_ID_I2C3_CORE] = {
+		.bit = BIT(1),
+		.reg = TH1520_I2C3_RST_CFG,
+	},
+	[TH1520_RESET_ID_I2C4_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_I2C4_RST_CFG,
+	},
+	[TH1520_RESET_ID_I2C4_CORE] = {
+		.bit = BIT(1),
+		.reg = TH1520_I2C4_RST_CFG,
+	},
+	[TH1520_RESET_ID_I2C5_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_I2C5_RST_CFG,
+	},
+	[TH1520_RESET_ID_I2C5_CORE] = {
+		.bit = BIT(1),
+		.reg = TH1520_I2C5_RST_CFG,
+	},
+	[TH1520_RESET_ID_GPIO0_DB] = {
+		.bit = BIT(0),
+		.reg = TH1520_GPIO0_RST_CFG,
+	},
+	[TH1520_RESET_ID_GPIO0_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_GPIO0_RST_CFG,
+	},
+	[TH1520_RESET_ID_GPIO1_DB] = {
+		.bit = BIT(0),
+		.reg = TH1520_GPIO1_RST_CFG,
+	},
+	[TH1520_RESET_ID_GPIO1_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_GPIO1_RST_CFG,
+	},
+	[TH1520_RESET_ID_GPIO2_DB] = {
+		.bit = BIT(0),
+		.reg = TH1520_GPIO2_RST_CFG,
+	},
+	[TH1520_RESET_ID_GPIO2_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_GPIO2_RST_CFG,
+	},
+	[TH1520_RESET_ID_PWM_COUNTER] = {
+		.bit = BIT(0),
+		.reg = TH1520_PWM_RST_CFG,
+	},
+	[TH1520_RESET_ID_PWM_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_PWM_RST_CFG,
+	},
+	[TH1520_RESET_ID_PADCTRL0_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_PADCTRL0_APSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_CPU2PERI_X2H] = {
+		.bit = BIT(1),
+		.reg = TH1520_CPU2PERI_X2H_RST_CFG,
+	},
+	[TH1520_RESET_ID_CPU2AON_X2H] = {
+		.bit = BIT(0),
+		.reg = TH1520_CPU2AON_X2H_RST_CFG,
+	},
+	[TH1520_RESET_ID_AON2CPU_A2X] = {
+		.bit = BIT(0),
+		.reg = TH1520_AON2CPU_A2X_RST_CFG,
+	},
+	[TH1520_RESET_ID_NPUSYS_AXI] = {
+		.bit = BIT(0),
+		.reg = TH1520_NPUSYS_AXI_RST_CFG,
+	},
+	[TH1520_RESET_ID_NPUSYS_AXI_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_NPUSYS_AXI_RST_CFG,
+	},
+	[TH1520_RESET_ID_CPU2VP_X2P] = {
+		.bit = BIT(0),
+		.reg = TH1520_CPU2VP_X2P_RST_CFG,
+	},
+	[TH1520_RESET_ID_CPU2VI_X2H] = {
+		.bit = BIT(0),
+		.reg = TH1520_CPU2VI_X2H_RST_CFG,
+	},
+	[TH1520_RESET_ID_BMU_AXI] = {
+		.bit = BIT(0),
+		.reg = TH1520_BMU_C910_RST_CFG,
+	},
+	[TH1520_RESET_ID_BMU_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_BMU_C910_RST_CFG,
+	},
+	[TH1520_RESET_ID_DMAC_CPUSYS_AXI] = {
+		.bit = BIT(0),
+		.reg = TH1520_DMAC_CPUSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_DMAC_CPUSYS_AHB] = {
+		.bit = BIT(1),
+		.reg = TH1520_DMAC_CPUSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_SPINLOCK] = {
+		.bit = BIT(0),
+		.reg = TH1520_SPINLOCK_RST_CFG,
+	},
+	[TH1520_RESET_ID_CFG2TEE] = {
+		.bit = BIT(0),
+		.reg = TH1520_CFG2TEE_X2H_RST_CFG,
+	},
+	[TH1520_RESET_ID_DSMART] = {
+		.bit = BIT(0),
+		.reg = TH1520_DSMART_RST_CFG,
+	},
+	[TH1520_RESET_ID_GPIO3_DB] = {
+		.bit = BIT(0),
+		.reg = TH1520_GPIO3_RST_CFG,
+	},
+	[TH1520_RESET_ID_GPIO3_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_GPIO3_RST_CFG,
+	},
+	[TH1520_RESET_ID_PERI_I2S] = {
+		.bit = BIT(0),
+		.reg = TH1520_I2S_RST_CFG,
+	},
+	[TH1520_RESET_ID_PERI_APB3] = {
+		.bit = BIT(0),
+		.reg = TH1520_PERI_APB3_RST_CFG,
+	},
+	[TH1520_RESET_ID_PERI2PERI1_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_PERI_APB3_RST_CFG,
+	},
+	[TH1520_RESET_ID_VPSYS_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_VP_SUBSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_PERISYS_APB4] = {
+		.bit = BIT(0),
+		.reg = TH1520_PERISYS_APB4_RST_CFG,
+	},
+	[TH1520_RESET_ID_GMAC1_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_GMAC1_RST_CFG,
+	},
+	[TH1520_RESET_ID_GMAC1_AHB] = {
+		.bit = BIT(1),
+		.reg = TH1520_GMAC1_RST_CFG,
+	},
+	[TH1520_RESET_ID_GMAC1_CLKGEN] = {
+		.bit = BIT(2),
+		.reg = TH1520_GMAC1_RST_CFG,
+	},
+	[TH1520_RESET_ID_GMAC1_AXI] = {
+		.bit = BIT(3),
+		.reg = TH1520_GMAC1_RST_CFG,
+	},
+	[TH1520_RESET_ID_GMAC_AXI] = {
+		.bit = BIT(0),
+		.reg = TH1520_GMAC_AXI_RST_CFG,
+	},
+	[TH1520_RESET_ID_GMAC_AXI_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_GMAC_AXI_RST_CFG,
+	},
+	[TH1520_RESET_ID_PADCTRL1_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_PADCTRL1_APSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_VOSYS_AXI] = {
+		.bit = BIT(0),
+		.reg = TH1520_VOSYS_AXI_RST_CFG,
+	},
+	[TH1520_RESET_ID_VOSYS_AXI_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_VOSYS_AXI_RST_CFG,
+	},
+	[TH1520_RESET_ID_VOSYS_AXI_X2X] = {
+		.bit = BIT(0),
+		.reg = TH1520_VOSYS_X2X_RST_CFG,
+	},
+	[TH1520_RESET_ID_MISC2VP_X2X] = {
+		.bit = BIT(0),
+		.reg = TH1520_MISC2VP_X2X_RST_CFG,
+	},
+	[TH1520_RESET_ID_DSPSYS] = {
+		.bit = BIT(0),
+		.reg = TH1520_SUBSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_VISYS] = {
+		.bit = BIT(1),
+		.reg = TH1520_SUBSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_VOSYS] = {
+		.bit = BIT(2),
+		.reg = TH1520_SUBSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_VPSYS] = {
+		.bit = BIT(3),
+		.reg = TH1520_SUBSYS_RST_CFG,
+	},
+};
+
+static const struct th1520_reset_map th1520_dsp_resets[] = {
+	[TH1520_RESET_ID_X2X_DSP1] = {
+		.bit = BIT(0),
+		.reg = TH1520_DSPSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_X2X_DSP0] = {
+		.bit = BIT(1),
+		.reg = TH1520_DSPSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_X2X_SLAVE_DSP1] = {
+		.bit = BIT(2),
+		.reg = TH1520_DSPSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_X2X_SLAVE_DSP0] = {
+		.bit = BIT(3),
+		.reg = TH1520_DSPSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_DSP0_CORE] = {
+		.bit = BIT(8),
+		.reg = TH1520_DSPSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_DSP0_DEBUG] = {
+		.bit = BIT(9),
+		.reg = TH1520_DSPSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_DSP0_APB] = {
+		.bit = BIT(10),
+		.reg = TH1520_DSPSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_DSP1_CORE] = {
+		.bit = BIT(12),
+		.reg = TH1520_DSPSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_DSP1_DEBUG] = {
+		.bit = BIT(13),
+		.reg = TH1520_DSPSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_DSP1_APB] = {
+		.bit = BIT(14),
+		.reg = TH1520_DSPSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_DSPSYS_APB] = {
+		.bit = BIT(16),
+		.reg = TH1520_DSPSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_AXI4_DSPSYS_SLV] = {
+		.bit = BIT(20),
+		.reg = TH1520_DSPSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_AXI4_DSPSYS] = {
+		.bit = BIT(24),
+		.reg = TH1520_DSPSYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_AXI4_DSP_RS] = {
+		.bit = BIT(26),
+		.reg = TH1520_DSPSYS_RST_CFG,
+	},
+};
+
+static const struct th1520_reset_map th1520_misc_resets[] = {
+	[TH1520_RESET_ID_EMMC_SDIO_CLKGEN] = {
+		.bit = BIT(0),
+		.reg = TH1520_EMMC_RST_CFG,
+	},
+	[TH1520_RESET_ID_EMMC] = {
+		.bit = BIT(1),
+		.reg = TH1520_EMMC_RST_CFG,
+	},
+	[TH1520_RESET_ID_MISCSYS_AXI] = {
+		.bit = BIT(0),
+		.reg = TH1520_MISCSYS_AXI_RST_CFG,
+	},
+	[TH1520_RESET_ID_MISCSYS_AXI_APB] = {
+		.bit = BIT(1),
+		.reg = TH1520_MISCSYS_AXI_RST_CFG,
+	},
+	[TH1520_RESET_ID_SDIO0] = {
+		.bit = BIT(0),
+		.reg = TH1520_SDIO0_RST_CFG,
+	},
+	[TH1520_RESET_ID_SDIO1] = {
+		.bit = BIT(1),
+		.reg = TH1520_SDIO1_RST_CFG,
+	},
+	[TH1520_RESET_ID_USB3_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_USB3_DRD_RST_CFG,
+	},
+	[TH1520_RESET_ID_USB3_PHY] = {
+		.bit = BIT(1),
+		.reg = TH1520_USB3_DRD_RST_CFG,
+	},
+	[TH1520_RESET_ID_USB3_VCC] = {
+		.bit = BIT(2),
+		.reg = TH1520_USB3_DRD_RST_CFG,
+	},
+};
+
+static const struct th1520_reset_map th1520_vi_resets[] = {
+	[TH1520_RESET_ID_ISP0] = {
+		.bit = BIT(0),
+		.reg = TH1520_VISYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_ISP1] = {
+		.bit = BIT(4),
+		.reg = TH1520_VISYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_CSI0_APB] = {
+		.bit = BIT(16),
+		.reg = TH1520_VISYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_CSI1_APB] = {
+		.bit = BIT(17),
+		.reg = TH1520_VISYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_CSI2_APB] = {
+		.bit = BIT(18),
+		.reg = TH1520_VISYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_MIPI_FIFO] = {
+		.bit = BIT(20),
+		.reg = TH1520_VISYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_ISP_VENC_APB] = {
+		.bit = BIT(24),
+		.reg = TH1520_VISYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_VIPRE_APB] = {
+		.bit = BIT(28),
+		.reg = TH1520_VISYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_VIPRE_AXI] = {
+		.bit = BIT(29),
+		.reg = TH1520_VISYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_DW200_APB] = {
+		.bit = BIT(31),
+		.reg = TH1520_VISYS_RST_CFG,
+	},
+	[TH1520_RESET_ID_VISYS3_AXI] = {
+		.bit = BIT(8),
+		.reg = TH1520_VISYS_2_RST_CFG,
+	},
+	[TH1520_RESET_ID_VISYS2_AXI] = {
+		.bit = BIT(9),
+		.reg = TH1520_VISYS_2_RST_CFG,
+	},
+	[TH1520_RESET_ID_VISYS1_AXI] = {
+		.bit = BIT(10),
+		.reg = TH1520_VISYS_2_RST_CFG,
+	},
+	[TH1520_RESET_ID_VISYS_AXI] = {
+		.bit = BIT(12),
+		.reg = TH1520_VISYS_2_RST_CFG,
+	},
+	[TH1520_RESET_ID_VISYS_APB] = {
+		.bit = BIT(16),
+		.reg = TH1520_VISYS_2_RST_CFG,
+	},
+	[TH1520_RESET_ID_ISP_VENC_AXI] = {
+		.bit = BIT(20),
+		.reg = TH1520_VISYS_2_RST_CFG,
+	},
+};
+
+static const struct th1520_reset_map th1520_vp_resets[] = {
+	[TH1520_RESET_ID_VPSYS_AXI_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_AXIBUS_RST_CFG,
+	},
+	[TH1520_RESET_ID_VPSYS_AXI] = {
+		.bit = BIT(1),
+		.reg = TH1520_AXIBUS_RST_CFG,
+	},
+	[TH1520_RESET_ID_FCE_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_FCE_RST_CFG,
+	},
+	[TH1520_RESET_ID_FCE_CORE] = {
+		.bit = BIT(1),
+		.reg = TH1520_FCE_RST_CFG,
+	},
+	[TH1520_RESET_ID_FCE_X2X_MASTER] = {
+		.bit = BIT(4),
+		.reg = TH1520_FCE_RST_CFG,
+	},
+	[TH1520_RESET_ID_FCE_X2X_SLAVE] = {
+		.bit = BIT(5),
+		.reg = TH1520_FCE_RST_CFG,
+	},
+	[TH1520_RESET_ID_G2D_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_G2D_RST_CFG,
+	},
+	[TH1520_RESET_ID_G2D_ACLK] = {
+		.bit = BIT(1),
+		.reg = TH1520_G2D_RST_CFG,
+	},
+	[TH1520_RESET_ID_G2D_CORE] = {
+		.bit = BIT(2),
+		.reg = TH1520_G2D_RST_CFG,
+	},
+	[TH1520_RESET_ID_VDEC_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_VDEC_RST_CFG,
+	},
+	[TH1520_RESET_ID_VDEC_ACLK] = {
+		.bit = BIT(1),
+		.reg = TH1520_VDEC_RST_CFG,
+	},
+	[TH1520_RESET_ID_VDEC_CORE] = {
+		.bit = BIT(2),
+		.reg = TH1520_VDEC_RST_CFG,
+	},
+	[TH1520_RESET_ID_VENC_APB] = {
+		.bit = BIT(0),
+		.reg = TH1520_VENC_RST_CFG,
+	},
+	[TH1520_RESET_ID_VENC_CORE] = {
+		.bit = BIT(1),
+		.reg = TH1520_VENC_RST_CFG,
+	},
 };
 
 static inline struct th1520_reset_priv *
@@ -170,8 +933,38 @@ static const struct th1520_reset_data th1520_reset_data = {
 	.num = ARRAY_SIZE(th1520_resets),
 };
 
+static const struct th1520_reset_data th1520_ap_reset_data = {
+	.resets = th1520_ap_resets,
+	.num = ARRAY_SIZE(th1520_ap_resets),
+};
+
+static const struct th1520_reset_data th1520_dsp_reset_data = {
+	.resets = th1520_dsp_resets,
+	.num = ARRAY_SIZE(th1520_dsp_resets),
+};
+
+static const struct th1520_reset_data th1520_misc_reset_data = {
+	.resets = th1520_misc_resets,
+	.num = ARRAY_SIZE(th1520_misc_resets),
+};
+
+static const struct th1520_reset_data th1520_vi_reset_data = {
+	.resets = th1520_vi_resets,
+	.num = ARRAY_SIZE(th1520_vi_resets),
+};
+
+static const struct th1520_reset_data th1520_vp_reset_data = {
+	.resets = th1520_vp_resets,
+	.num = ARRAY_SIZE(th1520_vp_resets),
+};
+
 static const struct of_device_id th1520_reset_match[] = {
 	{ .compatible = "thead,th1520-reset", .data = &th1520_reset_data },
+	{ .compatible = "thead,th1520-reset-ap", .data = &th1520_ap_reset_data },
+	{ .compatible = "thead,th1520-reset-dsp", .data = &th1520_dsp_reset_data },
+	{ .compatible = "thead,th1520-reset-misc", .data = &th1520_misc_reset_data },
+	{ .compatible = "thead,th1520-reset-vi", .data = &th1520_vi_reset_data },
+	{ .compatible = "thead,th1520-reset-vp", .data = &th1520_vp_reset_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, th1520_reset_match);
-- 
2.50.1


