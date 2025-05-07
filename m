Return-Path: <linux-kernel+bounces-638038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6845BAAE0BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 15:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B88018952B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D1288CA9;
	Wed,  7 May 2025 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="pfX2xBHg"
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58951258CC1;
	Wed,  7 May 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624418; cv=pass; b=tKhK0htxcouO5gf+xV0+x025oKANV83rdhn9MxfeFEG60MkaB407AUtSxSVGV8y7mI3ppnfPDK0R6IOyypIQkM+u1Uhwtf3axRST576t3krL7fpP9qHKbmV8chw/uV1qON+VVhV7BDmXyzbOMsw9GjxSM92q/gdeHj7oWAy7mTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624418; c=relaxed/simple;
	bh=2fkvWes/KdZN+OCW4LRGRDWFvs2u5/nv7qmdvA3NugY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KErPHstgE2rexvzPMvty7Ae9ALVU5uFDEPA0ASneSrZh4I9gsfOB/kNZE/u9l2hYPv6Zi7k+PBflXZWbo5aUsQkVIAWWOiFqz/kqLQEMKYcdgIrjKaw2zjJnbdbPXyIeURp5soPc0vLJCV/ThVj+f5TGtAyvXwFkzqrZB3/i65g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=pfX2xBHg; arc=pass smtp.client-ip=136.143.188.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1746624401; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RXyEg9VEGZhYQOW4oPzTkZsVWX/7pEJe9gM+A8PIXqeRLUllKZvNp2g/oMTwVoVdmi+BfR7bixUcGMrynSRceIKuWRQw4fbI5il4+JnKKmE1eKqHvI34Uqv0MtWU/fGSE648w8v51V17gW/6jmeAy1ofsjkGJ0caua38dAWLFJU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746624401; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Vldb6HmY7ABtJSOhaexBx5PgUqvnKp5m3yXPbkZBrr8=; 
	b=PxiGS0x3ivelBAoqcTC4FUpCprEtIl7atalnIMD3xH0Q2o3n2nwnNdn/Tgq4Qzq8v0uxwhZsS+ZrOg+3DffKj71eMoXRTs75LUR1Z7VK9uwJ1hF6+triQII6XG6MAesUVwLQX6/z7vYglQMVqXTa03Z8GmYAcJneC/y+O9dIzJE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746624401;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Vldb6HmY7ABtJSOhaexBx5PgUqvnKp5m3yXPbkZBrr8=;
	b=pfX2xBHg29Z65yVRAKVi3YASIKlmMngpt1v4U9FAi38eDlZ8Ia7hxWOulsvufs5G
	dz1XvhtckJBHgzwsaQM6gXptVopPYPw4Krt4KobOlvVIq7ySkv349BF01EdHmY6pqfx
	3upnjk62D8ssJFYWBivFFRStRM2w7yGIjSzY4iuM=
Received: by mx.zohomail.com with SMTPS id 1746624398899331.4732733259341;
	Wed, 7 May 2025 06:26:38 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Wed, 07 May 2025 21:25:34 +0800
Subject: [PATCH v3 2/2] reset: canaan: add reset driver for Kendryte K230
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250507-k230-reset-v3-2-c85240782ea5@pigmoral.tech>
References: <20250507-k230-reset-v3-0-c85240782ea5@pigmoral.tech>
In-Reply-To: <20250507-k230-reset-v3-0-c85240782ea5@pigmoral.tech>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Junhui Liu <junhui.liu@pigmoral.tech>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746624358; l=15769;
 i=junhui.liu@pigmoral.tech; s=20250507; h=from:subject:message-id;
 bh=2fkvWes/KdZN+OCW4LRGRDWFvs2u5/nv7qmdvA3NugY=;
 b=gSP7IsXOAb767WZ8jCBGlFp+RnW/sv/Mzb4EovUY9whpPv+KEQL8Y5emelVvrZZ85mWEp0OfI
 01Osvi6O1VLCFCkeE0E4AS2PEUKt9E07FKa6jKZPlja5b48jY3fd0XO
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=d3i4H2mg9LUn4SQemoLAjLRQy0nTcyknIv6zgKMwiBA=
X-ZohoMailClient: External

Add support for the resets on Canaan Kendryte K230 SoC. The driver
support CPU0, CPU1, L2 cache flush, hardware auto clear and software
clear resets.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/reset/Kconfig      |   9 ++
 drivers/reset/Makefile     |   1 +
 drivers/reset/reset-k230.c | 371 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 381 insertions(+)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 99f6f9784e6865faddf8621ccfca095778c4dc47..248138ffba3bfbf859c74ba1aed7ba2f72819f7a 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -140,6 +140,15 @@ config RESET_K210
 	  Say Y if you want to control reset signals provided by this
 	  controller.
 
+config RESET_K230
+	tristate "Reset controller driver for Canaan Kendryte K230 SoC"
+	depends on ARCH_CANAAN || COMPILE_TEST
+	depends on OF
+	help
+	  Support for the Canaan Kendryte K230 RISC-V SoC reset controller.
+	  Say Y if you want to control reset signals provided by this
+	  controller.
+
 config RESET_LANTIQ
 	bool "Lantiq XWAY Reset Driver" if COMPILE_TEST
 	default SOC_TYPE_XWAY
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 31f9904d13f9c3a107fc1ee1ec9f9baba016d101..13fe94531bea1eb91268b1804e1321b167815a4b 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_IMX8MP_AUDIOMIX) += reset-imx8mp-audiomix.o
 obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
 obj-$(CONFIG_RESET_K210) += reset-k210.o
+obj-$(CONFIG_RESET_K230) += reset-k230.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
diff --git a/drivers/reset/reset-k230.c b/drivers/reset/reset-k230.c
new file mode 100644
index 0000000000000000000000000000000000000000..c81045bb4a142af7eb5ab648f04d04cc95919255
--- /dev/null
+++ b/drivers/reset/reset-k230.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022-2024 Canaan Bright Sight Co., Ltd
+ * Copyright (C) 2024-2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ *
+ * The reset management module in the K230 SoC provides reset time control
+ * registers. For RST_TYPE_CPU0, RST_TYPE_CPU1 and RST_TYPE_SW_DONE, the period
+ * during which reset is applied or removed while the clock is stopped can be
+ * set up to 15 * 0.25 = 3.75 µs. For RST_TYPE_HW_DONE, that period can be set
+ * up to 255 * 0.25 = 63.75 µs. For RST_TYPE_FLUSH, the reset bit is
+ * automatically cleared by hardware when flush completes.
+ *
+ * Although this driver does not configure the reset time registers, delays have
+ * been added to the assert, deassert, and reset operations to cover the maximum
+ * reset time. Some reset types include done bits whose toggle does not
+ * unambiguously signal whether hardware reset removal or clock-stop period
+ * expiration occurred first. Delays are therefore retained for types with done
+ * bits to ensure safe timing.
+ *
+ * Reference: K230 Technical Reference Manual V0.3.1
+ * https://kendryte-download.canaan-creative.com/developer/k230/HDK/K230%E7%A1%AC%E4%BB%B6%E6%96%87%E6%A1%A3/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ */
+
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+
+#include <dt-bindings/reset/canaan,k230-rst.h>
+
+/**
+ * enum k230_rst_type - K230 reset types
+ * @RST_TYPE_CPU0: Reset type for CPU0
+ *	Automatically clears, has write enable and done bit, active high
+ * @RST_TYPE_CPU1: Reset type for CPU1
+ *	Manually clears, has write enable and done bit, active high
+ * @RST_TYPE_FLUSH: Reset type for CPU L2 cache flush
+ *	Automatically clears, has write enable, no done bit, active high
+ * @RST_TYPE_HW_DONE: Reset type for hardware auto clear
+ *	Automatically clears, no write enable, has done bit, active high
+ * @RST_TYPE_SW_DONE: Reset type for software manual clear
+ *	Manually clears, no write enable and done bit,
+ *	active high if ID is RST_SPI2AXI, otherwise active low
+ */
+enum k230_rst_type {
+	RST_TYPE_CPU0,
+	RST_TYPE_CPU1,
+	RST_TYPE_FLUSH,
+	RST_TYPE_HW_DONE,
+	RST_TYPE_SW_DONE,
+};
+
+struct k230_rst_map {
+	u32			offset;
+	enum k230_rst_type	type;
+	u32			done;
+	u32			reset;
+};
+
+struct k230_rst {
+	struct reset_controller_dev	rcdev;
+	void __iomem			*base;
+	/* protect register read-modify-write */
+	spinlock_t			lock;
+};
+
+static const struct k230_rst_map k230_resets[] = {
+	[RST_CPU0]		= { 0x4,  RST_TYPE_CPU0,    BIT(12), BIT(0) },
+	[RST_CPU1]		= { 0xc,  RST_TYPE_CPU1,    BIT(12), BIT(0) },
+	[RST_CPU0_FLUSH]	= { 0x4,  RST_TYPE_FLUSH,   0,       BIT(4) },
+	[RST_CPU1_FLUSH]	= { 0xc,  RST_TYPE_FLUSH,   0,       BIT(4) },
+	[RST_AI]		= { 0x14, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_VPU]		= { 0x1c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_HISYS]		= { 0x2c, RST_TYPE_HW_DONE, BIT(4),  BIT(0) },
+	[RST_HISYS_AHB]		= { 0x2c, RST_TYPE_HW_DONE, BIT(5),  BIT(1) },
+	[RST_SDIO0]		= { 0x34, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
+	[RST_SDIO1]		= { 0x34, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
+	[RST_SDIO_AXI]		= { 0x34, RST_TYPE_HW_DONE, BIT(30), BIT(2) },
+	[RST_USB0]		= { 0x3c, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
+	[RST_USB1]		= { 0x3c, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
+	[RST_USB0_AHB]		= { 0x3c, RST_TYPE_HW_DONE, BIT(30), BIT(0) },
+	[RST_USB1_AHB]		= { 0x3c, RST_TYPE_HW_DONE, BIT(31), BIT(1) },
+	[RST_SPI0]		= { 0x44, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
+	[RST_SPI1]		= { 0x44, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
+	[RST_SPI2]		= { 0x44, RST_TYPE_HW_DONE, BIT(30), BIT(2) },
+	[RST_SEC]		= { 0x4c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_PDMA]		= { 0x54, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
+	[RST_SDMA]		= { 0x54, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
+	[RST_DECOMPRESS]	= { 0x5c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_SRAM]		= { 0x64, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
+	[RST_SHRM_AXIM]		= { 0x64, RST_TYPE_HW_DONE, BIT(30), BIT(2) },
+	[RST_SHRM_AXIS]		= { 0x64, RST_TYPE_HW_DONE, BIT(31), BIT(3) },
+	[RST_NONAI2D]		= { 0x6c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_MCTL]		= { 0x74, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_ISP]		= { 0x80, RST_TYPE_HW_DONE, BIT(29), BIT(6) },
+	[RST_ISP_DW]		= { 0x80, RST_TYPE_HW_DONE, BIT(28), BIT(5) },
+	[RST_DPU]		= { 0x88, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_DISP]		= { 0x90, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_GPU]		= { 0x98, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_AUDIO]		= { 0xa4, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
+	[RST_TIMER0]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(0) },
+	[RST_TIMER1]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(1) },
+	[RST_TIMER2]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(2) },
+	[RST_TIMER3]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(3) },
+	[RST_TIMER4]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(4) },
+	[RST_TIMER5]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(5) },
+	[RST_TIMER_APB]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(6) },
+	[RST_HDI]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(7) },
+	[RST_WDT0]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(12) },
+	[RST_WDT1]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(13) },
+	[RST_WDT0_APB]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(14) },
+	[RST_WDT1_APB]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(15) },
+	[RST_TS_APB]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(16) },
+	[RST_MAILBOX]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(17) },
+	[RST_STC]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(18) },
+	[RST_PMU]		= { 0x20, RST_TYPE_SW_DONE, 0,       BIT(19) },
+	[RST_LOSYS_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(0) },
+	[RST_UART0]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(1) },
+	[RST_UART1]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(2) },
+	[RST_UART2]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(3) },
+	[RST_UART3]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(4) },
+	[RST_UART4]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(5) },
+	[RST_I2C0]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(6) },
+	[RST_I2C1]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(7) },
+	[RST_I2C2]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(8) },
+	[RST_I2C3]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(9) },
+	[RST_I2C4]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(10) },
+	[RST_JAMLINK0_APB]	= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(11) },
+	[RST_JAMLINK1_APB]	= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(12) },
+	[RST_JAMLINK2_APB]	= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(13) },
+	[RST_JAMLINK3_APB]	= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(14) },
+	[RST_CODEC_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(17) },
+	[RST_GPIO_DB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(18) },
+	[RST_GPIO_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(19) },
+	[RST_ADC]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(20) },
+	[RST_ADC_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(21) },
+	[RST_PWM_APB]		= { 0x24, RST_TYPE_SW_DONE, 0,       BIT(22) },
+	[RST_SHRM_APB]		= { 0x64, RST_TYPE_SW_DONE, 0,       BIT(1) },
+	[RST_CSI0]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(0) },
+	[RST_CSI1]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(1) },
+	[RST_CSI2]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(2) },
+	[RST_CSI_DPHY]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(3) },
+	[RST_ISP_AHB]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(4) },
+	[RST_M0]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(7) },
+	[RST_M1]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(8) },
+	[RST_M2]		= { 0x80, RST_TYPE_SW_DONE, 0,       BIT(9) },
+	[RST_SPI2AXI]		= { 0xa8, RST_TYPE_SW_DONE, 0,       BIT(0) }
+};
+
+static inline struct k230_rst *to_k230_rst(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct k230_rst, rcdev);
+}
+
+static void k230_rst_clear_done(struct k230_rst *rstc, unsigned long id,
+				bool write_en)
+{
+	const struct k230_rst_map *rmap = &k230_resets[id];
+	u32 reg;
+
+	guard(spinlock_irqsave)(&rstc->lock);
+
+	reg = readl(rstc->base + rmap->offset);
+	reg |= rmap->done; /* write 1 to clear */
+	if (write_en)
+		reg |= rmap->done << 16;
+	writel(reg, rstc->base + rmap->offset);
+}
+
+static int k230_rst_wait_and_clear_done(struct k230_rst *rstc, unsigned long id,
+					bool write_en)
+{
+	const struct k230_rst_map *rmap = &k230_resets[id];
+	u32 reg;
+	int ret;
+
+	ret = readl_poll_timeout(rstc->base + rmap->offset, reg,
+				 reg & rmap->done, 10, 1000);
+	if (ret) {
+		dev_err(rstc->rcdev.dev, "Wait for reset done timeout\n");
+		return ret;
+	}
+
+	k230_rst_clear_done(rstc, id, write_en);
+
+	return 0;
+}
+
+static void k230_rst_update(struct k230_rst *rstc, unsigned long id,
+			    bool assert, bool write_en, bool active_low)
+{
+	const struct k230_rst_map *rmap = &k230_resets[id];
+	u32 reg;
+
+	guard(spinlock_irqsave)(&rstc->lock);
+
+	reg = readl(rstc->base + rmap->offset);
+	if (assert ^ active_low)
+		reg |= rmap->reset;
+	else
+		reg &= ~rmap->reset;
+	if (write_en)
+		reg |= rmap->reset << 16;
+	writel(reg, rstc->base + rmap->offset);
+}
+
+static int k230_rst_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct k230_rst *rstc = to_k230_rst(rcdev);
+
+	switch (k230_resets[id].type) {
+	case RST_TYPE_CPU1:
+		k230_rst_update(rstc, id, true, true, false);
+		break;
+	case RST_TYPE_SW_DONE:
+		k230_rst_update(rstc, id, true, false,
+				id == RST_SPI2AXI ? false : true);
+		break;
+	case RST_TYPE_CPU0:
+	case RST_TYPE_FLUSH:
+	case RST_TYPE_HW_DONE:
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * The time period when reset is applied but the clock is stopped for
+	 * RST_TYPE_CPU1 and RST_TYPE_SW_DONE can be set up to 3.75us. Delay
+	 * 10us to ensure proper reset timing.
+	 */
+	udelay(10);
+
+	return 0;
+}
+
+static int k230_rst_deassert(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	struct k230_rst *rstc = to_k230_rst(rcdev);
+	int ret = 0;
+
+	switch (k230_resets[id].type) {
+	case RST_TYPE_CPU1:
+		k230_rst_update(rstc, id, false, true, false);
+		ret = k230_rst_wait_and_clear_done(rstc, id, true);
+		break;
+	case RST_TYPE_SW_DONE:
+		k230_rst_update(rstc, id, false, false,
+				id == RST_SPI2AXI ? false : true);
+		break;
+	case RST_TYPE_CPU0:
+	case RST_TYPE_FLUSH:
+	case RST_TYPE_HW_DONE:
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * The time period when reset is removed but the clock is stopped for
+	 * RST_TYPE_CPU1 and RST_TYPE_SW_DONE can be set up to 3.75us. Delay
+	 * 10us to ensure proper reset timing.
+	 */
+	udelay(10);
+
+	return ret;
+}
+
+static int k230_rst_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct k230_rst *rstc = to_k230_rst(rcdev);
+	const struct k230_rst_map *rmap = &k230_resets[id];
+	u32 reg;
+	int ret = 0;
+
+	switch (rmap->type) {
+	case RST_TYPE_CPU0:
+		k230_rst_clear_done(rstc, id, true);
+		k230_rst_update(rstc, id, true, true, false);
+		ret = k230_rst_wait_and_clear_done(rstc, id, true);
+
+		/*
+		 * The time period when reset is applied and removed but the
+		 * clock is stopped for RST_TYPE_CPU0 can be set up to 7.5us.
+		 * Delay 10us to ensure proper reset timing.
+		 */
+		udelay(10);
+
+		break;
+	case RST_TYPE_FLUSH:
+		k230_rst_update(rstc, id, true, true, false);
+
+		/* Wait flush request bit auto cleared by hardware */
+		ret = readl_poll_timeout(rstc->base + rmap->offset, reg,
+					!(reg & rmap->reset), 10, 1000);
+		if (ret)
+			dev_err(rcdev->dev, "Wait for flush done timeout\n");
+
+		break;
+	case RST_TYPE_HW_DONE:
+		k230_rst_clear_done(rstc, id, false);
+		k230_rst_update(rstc, id, true, false, false);
+		ret = k230_rst_wait_and_clear_done(rstc, id, false);
+
+		/*
+		 * The time period when reset is applied and removed but the
+		 * clock is stopped for RST_TYPE_HW_DONE can be set up to
+		 * 127.5us. Delay 200us to ensure proper reset timing.
+		 */
+		fsleep(200);
+
+		break;
+	case RST_TYPE_CPU1:
+	case RST_TYPE_SW_DONE:
+		k230_rst_assert(rcdev, id);
+		ret = k230_rst_deassert(rcdev, id);
+		break;
+	}
+
+	return ret;
+}
+
+static const struct reset_control_ops k230_rst_ops = {
+	.reset		= k230_rst_reset,
+	.assert		= k230_rst_assert,
+	.deassert	= k230_rst_deassert,
+};
+
+static int k230_rst_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct k230_rst *rstc;
+
+	rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
+	if (!rstc)
+		return -ENOMEM;
+
+	rstc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rstc->base))
+		return PTR_ERR(rstc->base);
+
+	spin_lock_init(&rstc->lock);
+
+	rstc->rcdev.dev		= dev;
+	rstc->rcdev.owner	= THIS_MODULE;
+	rstc->rcdev.ops		= &k230_rst_ops;
+	rstc->rcdev.nr_resets	= ARRAY_SIZE(k230_resets);
+	rstc->rcdev.of_node	= dev->of_node;
+
+	return devm_reset_controller_register(dev, &rstc->rcdev);
+}
+
+static const struct of_device_id k230_rst_match[] = {
+	{ .compatible = "canaan,k230-rst", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, k230_rst_match);
+
+static struct platform_driver k230_rst_driver = {
+	.probe = k230_rst_probe,
+	.driver = {
+		.name = "k230-rst",
+		.of_match_table = k230_rst_match,
+	}
+};
+module_platform_driver(k230_rst_driver);
+
+MODULE_AUTHOR("Junhui Liu <junhui.liu@pigmoral.tech>");
+MODULE_DESCRIPTION("Canaan K230 reset driver");
+MODULE_LICENSE("GPL");

-- 
2.49.0


