Return-Path: <linux-kernel+bounces-680993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A604AD4CC0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 09:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8C016503E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 07:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66372367AE;
	Wed, 11 Jun 2025 07:31:52 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBAC235BF3;
	Wed, 11 Jun 2025 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627111; cv=none; b=lrZq0W0UnJSxWsXFV8rYzXWdlaME3IaEm37i7EjqFydSCeCkZF7ctKj72yXe231Xoo7rBPdwN1aZsyAJzUqss/EZ4JtAxVD1c/bAKFvCofv3PXBGg+JrrLdbIFH/3WVtaH3UKCwbVeqPIg/hCdwti1JZ8MbmbxJa77HGgzxp9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627111; c=relaxed/simple;
	bh=nx+4yfd9amSKz8Vz+UsLsXfmfgGbrOOOX1pI9xGm/uo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwTr/rPtP6N66kN6mNhFhH5NIC/6HMAbBWgK0ZDAugvAdDNT64YXiY63H0+BLQGz2yu2u/bL+SxibZQsMRjDBClNJQf7YN2ANVOHoAVYAT7K5LFvK5t8tc0rngxlkJppQQTOGB0hCoqcy8wmHkgTe/sqT5/8B1cO8KLpNj0Iq5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 11 Jun
 2025 15:31:40 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 11 Jun 2025 15:31:40 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mo Elbadry <elbadrym@google.com>, "Rom
 Lemarchand" <romlem@google.com>, William Kennington <wak@google.com>, "Yuxiao
 Zhang" <yuxiaozhang@google.com>, <wthai@nvidia.com>, <leohu@nvidia.com>,
	<dkodihalli@nvidia.com>, <spuranik@nvidia.com>
Subject: [PATCH v10 2/3] reset: aspeed: register AST2700 reset auxiliary bus device
Date: Wed, 11 Jun 2025 15:31:38 +0800
Message-ID: <20250611073139.636724-3-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611073139.636724-1-ryan_chen@aspeedtech.com>
References: <20250611073139.636724-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AST2700 reset driver is registered as an auxiliary device
due to reset and clock controller share the same register region.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Kconfig        |   7 +
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-aspeed.c | 253 +++++++++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+)
 create mode 100644 drivers/reset/reset-aspeed.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index d85be5899da6..76918f714eff 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -22,6 +22,13 @@ config RESET_A10SR
 	  This option enables support for the external reset functions for
 	  peripheral PHYs on the Altera Arria10 System Resource Chip.
 
+config RESET_ASPEED
+	tristate "ASPEED Reset Driver"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	select AUXILIARY_BUS
+	help
+	  This enables the reset controller driver for AST2700.
+
 config RESET_ATH79
 	bool "AR71xx Reset Driver" if COMPILE_TEST
 	default ATH79
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 91e6348e3351..3c40a4e44f6b 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -6,6 +6,7 @@ obj-y += starfive/
 obj-y += sti/
 obj-y += tegra/
 obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
+obj-$(CONFIG_RESET_ASPEED) += reset-aspeed.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_AXS10X) += reset-axs10x.o
 obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
diff --git a/drivers/reset/reset-aspeed.c b/drivers/reset/reset-aspeed.c
new file mode 100644
index 000000000000..dd2f860a69d7
--- /dev/null
+++ b/drivers/reset/reset-aspeed.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 ASPEED Technology Inc.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/reset/aspeed,ast2700-scu.h>
+
+#define SCU0_RESET_CTRL1 0x200
+#define SCU0_RESET_CTRL2 0x220
+#define SCU1_RESET_CTRL1 0x200
+#define SCU1_RESET_CTRL2 0x220
+#define SCU1_PCIE3_CTRL 0x908
+
+struct ast2700_reset_signal {
+	bool dedicated_clr; /* dedicated reset clr offset */
+	u32 offset, bit;
+};
+
+struct aspeed_reset_info {
+	unsigned int nr_resets;
+	const struct ast2700_reset_signal *signal;
+};
+
+struct aspeed_reset {
+	struct reset_controller_dev rcdev;
+	struct aspeed_reset_info *info;
+	spinlock_t lock; /* Protect read-modify-write cycle */
+	void __iomem *base;
+};
+
+static const struct ast2700_reset_signal ast2700_reset0_signals[] = {
+	[SCU0_RESET_SDRAM] = { true, SCU0_RESET_CTRL1, BIT(0) },
+	[SCU0_RESET_DDRPHY] = { true, SCU0_RESET_CTRL1, BIT(1) },
+	[SCU0_RESET_RSA] = { true, SCU0_RESET_CTRL1, BIT(2) },
+	[SCU0_RESET_SHA3] = { true, SCU0_RESET_CTRL1, BIT(3) },
+	[SCU0_RESET_HACE] = { true, SCU0_RESET_CTRL1, BIT(4) },
+	[SCU0_RESET_SOC] = { true, SCU0_RESET_CTRL1, BIT(5) },
+	[SCU0_RESET_VIDEO] = { true, SCU0_RESET_CTRL1, BIT(6) },
+	[SCU0_RESET_2D] = { true, SCU0_RESET_CTRL1, BIT(7) },
+	[SCU0_RESET_PCIS] = { true, SCU0_RESET_CTRL1, BIT(8) },
+	[SCU0_RESET_RVAS0] = { true, SCU0_RESET_CTRL1, BIT(9) },
+	[SCU0_RESET_RVAS1] = { true, SCU0_RESET_CTRL1, BIT(10) },
+	[SCU0_RESET_SM3] = { true, SCU0_RESET_CTRL1, BIT(11) },
+	[SCU0_RESET_SM4] = { true, SCU0_RESET_CTRL1, BIT(12) },
+	[SCU0_RESET_CRT0] = { true, SCU0_RESET_CTRL1, BIT(13) },
+	[SCU0_RESET_ECC] = { true, SCU0_RESET_CTRL1, BIT(14) },
+	[SCU0_RESET_DP_PCI] = { true, SCU0_RESET_CTRL1, BIT(15) },
+	[SCU0_RESET_UFS] = { true, SCU0_RESET_CTRL1, BIT(16) },
+	[SCU0_RESET_EMMC] = { true, SCU0_RESET_CTRL1, BIT(17) },
+	[SCU0_RESET_PCIE1RST] = { true, SCU0_RESET_CTRL1, BIT(18) },
+	[SCU0_RESET_PCIE1RSTOE] = { true, SCU0_RESET_CTRL1, BIT(19) },
+	[SCU0_RESET_PCIE0RST] = { true, SCU0_RESET_CTRL1, BIT(20) },
+	[SCU0_RESET_PCIE0RSTOE] = { true, SCU0_RESET_CTRL1, BIT(21) },
+	[SCU0_RESET_JTAG] = { true, SCU0_RESET_CTRL1, BIT(22) },
+	[SCU0_RESET_MCTP0] = { true, SCU0_RESET_CTRL1, BIT(23) },
+	[SCU0_RESET_MCTP1] = { true, SCU0_RESET_CTRL1, BIT(24) },
+	[SCU0_RESET_XDMA0] = { true, SCU0_RESET_CTRL1, BIT(25) },
+	[SCU0_RESET_XDMA1] = { true, SCU0_RESET_CTRL1, BIT(26) },
+	[SCU0_RESET_H2X1] = { true, SCU0_RESET_CTRL1, BIT(27) },
+	[SCU0_RESET_DP] = { true, SCU0_RESET_CTRL1, BIT(28) },
+	[SCU0_RESET_DP_MCU] = { true, SCU0_RESET_CTRL1, BIT(29) },
+	[SCU0_RESET_SSP] = { true, SCU0_RESET_CTRL1, BIT(30) },
+	[SCU0_RESET_H2X0] = { true, SCU0_RESET_CTRL1, BIT(31) },
+	[SCU0_RESET_PORTA_VHUB] = { true, SCU0_RESET_CTRL2, BIT(0) },
+	[SCU0_RESET_PORTA_PHY3] = { true, SCU0_RESET_CTRL2, BIT(1) },
+	[SCU0_RESET_PORTA_XHCI] = { true, SCU0_RESET_CTRL2, BIT(2) },
+	[SCU0_RESET_PORTB_VHUB] = { true, SCU0_RESET_CTRL2, BIT(3) },
+	[SCU0_RESET_PORTB_PHY3] = { true, SCU0_RESET_CTRL2, BIT(4) },
+	[SCU0_RESET_PORTB_XHCI] = { true, SCU0_RESET_CTRL2, BIT(5) },
+	[SCU0_RESET_PORTA_VHUB_EHCI] = { true, SCU0_RESET_CTRL2, BIT(6) },
+	[SCU0_RESET_PORTB_VHUB_EHCI] = { true, SCU0_RESET_CTRL2, BIT(7) },
+	[SCU0_RESET_UHCI] = { true, SCU0_RESET_CTRL2, BIT(8) },
+	[SCU0_RESET_TSP] = { true, SCU0_RESET_CTRL2, BIT(9) },
+	[SCU0_RESET_E2M0] = { true, SCU0_RESET_CTRL2, BIT(10) },
+	[SCU0_RESET_E2M1] = { true, SCU0_RESET_CTRL2, BIT(11) },
+	[SCU0_RESET_VLINK] = { true, SCU0_RESET_CTRL2, BIT(12) },
+};
+
+static const struct ast2700_reset_signal ast2700_reset1_signals[] = {
+	[SCU1_RESET_LPC0] = { true, SCU1_RESET_CTRL1, BIT(0) },
+	[SCU1_RESET_LPC1] = { true, SCU1_RESET_CTRL1, BIT(1) },
+	[SCU1_RESET_MII] = { true, SCU1_RESET_CTRL1, BIT(2) },
+	[SCU1_RESET_PECI] = { true, SCU1_RESET_CTRL1, BIT(3) },
+	[SCU1_RESET_PWM] = { true, SCU1_RESET_CTRL1, BIT(4) },
+	[SCU1_RESET_MAC0] = { true, SCU1_RESET_CTRL1, BIT(5) },
+	[SCU1_RESET_MAC1] = { true, SCU1_RESET_CTRL1, BIT(6) },
+	[SCU1_RESET_MAC2] = { true, SCU1_RESET_CTRL1, BIT(7) },
+	[SCU1_RESET_ADC] = { true, SCU1_RESET_CTRL1, BIT(8) },
+	[SCU1_RESET_SD] = { true, SCU1_RESET_CTRL1, BIT(9) },
+	[SCU1_RESET_ESPI0] = { true, SCU1_RESET_CTRL1, BIT(10) },
+	[SCU1_RESET_ESPI1] = { true, SCU1_RESET_CTRL1, BIT(11) },
+	[SCU1_RESET_JTAG1] = { true, SCU1_RESET_CTRL1, BIT(12) },
+	[SCU1_RESET_SPI0] = { true, SCU1_RESET_CTRL1, BIT(13) },
+	[SCU1_RESET_SPI1] = { true, SCU1_RESET_CTRL1, BIT(14) },
+	[SCU1_RESET_SPI2] = { true, SCU1_RESET_CTRL1, BIT(15) },
+	[SCU1_RESET_I3C0] = { true, SCU1_RESET_CTRL1, BIT(16) },
+	[SCU1_RESET_I3C1] = { true, SCU1_RESET_CTRL1, BIT(17) },
+	[SCU1_RESET_I3C2] = { true, SCU1_RESET_CTRL1, BIT(18) },
+	[SCU1_RESET_I3C3] = { true, SCU1_RESET_CTRL1, BIT(19) },
+	[SCU1_RESET_I3C4] = { true, SCU1_RESET_CTRL1, BIT(20) },
+	[SCU1_RESET_I3C5] = { true, SCU1_RESET_CTRL1, BIT(21) },
+	[SCU1_RESET_I3C6] = { true, SCU1_RESET_CTRL1, BIT(22) },
+	[SCU1_RESET_I3C7] = { true, SCU1_RESET_CTRL1, BIT(23) },
+	[SCU1_RESET_I3C8] = { true, SCU1_RESET_CTRL1, BIT(24) },
+	[SCU1_RESET_I3C9] = { true, SCU1_RESET_CTRL1, BIT(25) },
+	[SCU1_RESET_I3C10] = { true, SCU1_RESET_CTRL1, BIT(26) },
+	[SCU1_RESET_I3C11] = { true, SCU1_RESET_CTRL1, BIT(27) },
+	[SCU1_RESET_I3C12] = { true, SCU1_RESET_CTRL1, BIT(28) },
+	[SCU1_RESET_I3C13] = { true, SCU1_RESET_CTRL1, BIT(29) },
+	[SCU1_RESET_I3C14] = { true, SCU1_RESET_CTRL1, BIT(30) },
+	[SCU1_RESET_I3C15] = { true, SCU1_RESET_CTRL1, BIT(31) },
+	[SCU1_RESET_MCU0] = { true, SCU1_RESET_CTRL2, BIT(0) },
+	[SCU1_RESET_MCU1] = { true, SCU1_RESET_CTRL2, BIT(1) },
+	[SCU1_RESET_H2A_SPI1] = { true, SCU1_RESET_CTRL2, BIT(2) },
+	[SCU1_RESET_H2A_SPI2] = { true, SCU1_RESET_CTRL2, BIT(3) },
+	[SCU1_RESET_UART0] = { true, SCU1_RESET_CTRL2, BIT(4) },
+	[SCU1_RESET_UART1] = { true, SCU1_RESET_CTRL2, BIT(5) },
+	[SCU1_RESET_UART2] = { true, SCU1_RESET_CTRL2, BIT(6) },
+	[SCU1_RESET_UART3] = { true, SCU1_RESET_CTRL2, BIT(7) },
+	[SCU1_RESET_I2C_FILTER] = { true, SCU1_RESET_CTRL2, BIT(8) },
+	[SCU1_RESET_CALIPTRA] = { true, SCU1_RESET_CTRL2, BIT(9) },
+	[SCU1_RESET_XDMA] = { true, SCU1_RESET_CTRL2, BIT(10) },
+	[SCU1_RESET_FSI] = { true, SCU1_RESET_CTRL2, BIT(12) },
+	[SCU1_RESET_CAN] = { true, SCU1_RESET_CTRL2, BIT(13) },
+	[SCU1_RESET_MCTP] = { true, SCU1_RESET_CTRL2, BIT(14) },
+	[SCU1_RESET_I2C] = { true, SCU1_RESET_CTRL2, BIT(15) },
+	[SCU1_RESET_UART6] = { true, SCU1_RESET_CTRL2, BIT(16) },
+	[SCU1_RESET_UART7] = { true, SCU1_RESET_CTRL2, BIT(17) },
+	[SCU1_RESET_UART8] = { true, SCU1_RESET_CTRL2, BIT(18) },
+	[SCU1_RESET_UART9] = { true, SCU1_RESET_CTRL2, BIT(19) },
+	[SCU1_RESET_LTPI0] = { true, SCU1_RESET_CTRL2, BIT(20) },
+	[SCU1_RESET_VGAL] = { true, SCU1_RESET_CTRL2, BIT(21) },
+	[SCU1_RESET_LTPI1] = { true, SCU1_RESET_CTRL2, BIT(22) },
+	[SCU1_RESET_ACE] = { true, SCU1_RESET_CTRL2, BIT(23) },
+	[SCU1_RESET_E2M] = { true, SCU1_RESET_CTRL2, BIT(24) },
+	[SCU1_RESET_UHCI] = { true, SCU1_RESET_CTRL2, BIT(25) },
+	[SCU1_RESET_PORTC_USB2UART] = { true, SCU1_RESET_CTRL2, BIT(26) },
+	[SCU1_RESET_PORTC_VHUB_EHCI] = { true, SCU1_RESET_CTRL2, BIT(27) },
+	[SCU1_RESET_PORTD_USB2UART] = { true, SCU1_RESET_CTRL2, BIT(28) },
+	[SCU1_RESET_PORTD_VHUB_EHCI] = { true, SCU1_RESET_CTRL2, BIT(29) },
+	[SCU1_RESET_H2X] = { true, SCU1_RESET_CTRL2, BIT(30) },
+	[SCU1_RESET_I3CDMA] = { true, SCU1_RESET_CTRL2, BIT(31) },
+	[SCU1_RESET_PCIE2RST] = { false, SCU1_PCIE3_CTRL, BIT(0) },
+};
+
+static inline struct aspeed_reset *to_aspeed_reset(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct aspeed_reset, rcdev);
+}
+
+static int aspeed_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct aspeed_reset *rc = to_aspeed_reset(rcdev);
+	void __iomem *reg_offset = rc->base + rc->info->signal[id].offset;
+
+	if (rc->info->signal[id].dedicated_clr) {
+		writel(rc->info->signal[id].bit, reg_offset);
+	} else {
+		guard(spinlock_irqsave)(&rc->lock);
+		writel(readl(reg_offset) & ~rc->info->signal[id].bit, reg_offset);
+	}
+
+	return 0;
+}
+
+static int aspeed_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct aspeed_reset *rc = to_aspeed_reset(rcdev);
+	void __iomem *reg_offset = rc->base + rc->info->signal[id].offset;
+
+	if (rc->info->signal[id].dedicated_clr) {
+		writel(rc->info->signal[id].bit, reg_offset + 0x04);
+	} else {
+		guard(spinlock_irqsave)(&rc->lock);
+		writel(readl(reg_offset) | rc->info->signal[id].bit, reg_offset);
+	}
+
+	return 0;
+}
+
+static int aspeed_reset_status(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct aspeed_reset *rc = to_aspeed_reset(rcdev);
+	void __iomem *reg_offset = rc->base + rc->info->signal[id].offset;
+
+	return (readl(reg_offset) & rc->info->signal[id].bit) ? 1 : 0;
+}
+
+static const struct reset_control_ops aspeed_reset_ops = {
+	.assert = aspeed_reset_assert,
+	.deassert = aspeed_reset_deassert,
+	.status = aspeed_reset_status,
+};
+
+static int aspeed_reset_probe(struct auxiliary_device *adev,
+			      const struct auxiliary_device_id *id)
+{
+	struct aspeed_reset *reset;
+	struct device *dev = &adev->dev;
+
+	reset = devm_kzalloc(dev, sizeof(*reset), GFP_KERNEL);
+	if (!reset)
+		return -ENOMEM;
+
+	spin_lock_init(&reset->lock);
+
+	reset->info = (struct aspeed_reset_info *)id->driver_data;
+	reset->rcdev.owner = THIS_MODULE;
+	reset->rcdev.nr_resets = reset->info->nr_resets;
+	reset->rcdev.ops = &aspeed_reset_ops;
+	reset->rcdev.of_node = dev->parent->of_node;
+	reset->rcdev.dev = dev;
+	reset->rcdev.of_reset_n_cells = 1;
+	reset->base = (void __iomem *)adev->dev.platform_data;
+
+	return devm_reset_controller_register(dev, &reset->rcdev);
+}
+
+static const struct aspeed_reset_info ast2700_reset0_info = {
+	.nr_resets = ARRAY_SIZE(ast2700_reset0_signals),
+	.signal = ast2700_reset0_signals,
+};
+
+static const struct aspeed_reset_info ast2700_reset1_info = {
+	.nr_resets = ARRAY_SIZE(ast2700_reset1_signals),
+	.signal = ast2700_reset1_signals,
+};
+
+static const struct auxiliary_device_id aspeed_reset_ids[] = {
+	{ .name = "clk_ast2700.reset0", .driver_data = (kernel_ulong_t)&ast2700_reset0_info },
+	{ .name = "clk_ast2700.reset1", .driver_data = (kernel_ulong_t)&ast2700_reset1_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, aspeed_reset_ids);
+
+static struct auxiliary_driver aspeed_reset_driver = {
+	.probe		= aspeed_reset_probe,
+	.id_table	= aspeed_reset_ids,
+};
+
+module_auxiliary_driver(aspeed_reset_driver);
+
+MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
+MODULE_DESCRIPTION("ASPEED SoC Reset Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


