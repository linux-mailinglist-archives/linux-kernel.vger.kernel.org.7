Return-Path: <linux-kernel+bounces-601282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9265EA86BA2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 09:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BE98C7E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 07:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D024919DFAB;
	Sat, 12 Apr 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="tc/PoEiJ";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="MoyPKylo"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56C19CD1E;
	Sat, 12 Apr 2025 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744443921; cv=none; b=gqHRtdaufIMkCuMy7PP/rFT0WNx+kGjynnStcwSdilGlRCSsSNrZzBHRhTIp4SjXwfiDlljcAffWf+eCh7a0JSoHsrL3cUhoDSMgxnaOb61rAyNbgfgVblDEUja6TRKa/dslbMurqFL7rM2JA2UI7Vsn7rk/MC43Mncu7blzIRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744443921; c=relaxed/simple;
	bh=cIIoKSdXbCXQi73gVsBTQjqN3pcAWiUIwgR+alT5BwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKnJOUYk5ZqR6I5jVj5IgVOW2imqCSKtb4OhmA0MozawwDvCR274ICJx0SkEFroGjMUxb7KZ+sjDRAjTzX8I4LTUq2i52sh0lQJpv1RifDcW25iKQb4VsjiiZXij1uC+64VtBrPZ0BBu0u1y3uSuthjhGTbP8z/1aURIYkSmGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=tc/PoEiJ; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=MoyPKylo; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 7CA4212FB435;
	Sat, 12 Apr 2025 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1744443916; bh=cIIoKSdXbCXQi73gVsBTQjqN3pcAWiUIwgR+alT5BwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tc/PoEiJH1b+zqu07hEoibL3ALfJU0hfThtU1oUf8vLC5WTFc3rcPTpp4afvErrV5
	 eGg87+x6YlZf8Bdl/jH6hAkGhllY6KxjQ/8LDiqBL1viHXLiqC3reyx0jonu0o0BbK
	 mWWwAWa/n7V78C73UzmG/k025Dotd6czQl8kwRxpvYM9xZwQ52lOvb+kO3atX2aVJO
	 b1aT45uMEBUURTnu2REVbLgft8XeELyUn8vKW8LeHsaqiJGhnmTJu6pj+eMoiXbmj+
	 lEZld33No4ufvdJI5ZiCmhl9McJXX+g7q+NrYoTlsqwHuNjFhQcSonv0P+SNo/D/sv
	 b/fMjzurVcUOg==
X-Virus-Scanned: amavisd-new at 4d2.org
Authentication-Results: bayard.4d2.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ua2LUmMbDiVu; Sat, 12 Apr 2025 00:45:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [183.217.81.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id DC4EA12FB432;
	Sat, 12 Apr 2025 00:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1744443914; bh=cIIoKSdXbCXQi73gVsBTQjqN3pcAWiUIwgR+alT5BwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MoyPKyloVRZ508JzbrJRA2FCGmHgXMjW2beEOhM7DStcdwPZvKaid2Tz+lVkgmmVl
	 AU5K0fadzs98HhYPdl1aWN3h7xWG/bSykTEPea2x3Zt7wiAcLd0GRUUDdw8j1MKIaF
	 HLhVfUrngpOHjxzELwx2y9nrvhX6HGykZTs/DTYfZqmjELhLMke7jSjydXI6sY+Hc7
	 k+YeYfuFTt+RH+AZh/aRjjO0edVOTePFyKqt2jk0zuUGoSXI6T/d5Za2M9++13Jd/D
	 Sa+ViPDCtxIsfF2/pxE7RCBB3kDLN9ywyhxmV2UvlpPOVZ5KksbMecVUGHseX1OAqd
	 K0H66upK3/NIA==
From: Haylen Chu <heylenay@4d2.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Haylen Chu <heylenay@4d2.org>
Subject: [PATCH v7 3/6] clk: spacemit: Add clock support for SpacemiT K1 SoC
Date: Sat, 12 Apr 2025 07:44:21 +0000
Message-ID: <20250412074423.38517-5-heylenay@4d2.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250412074423.38517-2-heylenay@4d2.org>
References: <20250412074423.38517-2-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clock tree of K1 SoC contains three main types of clock hardware
(PLL/DDN/MIX) and has control registers split into several multifunction
devices: APBS (PLLs), MPMU, APBC and APMU.

All register operations are done through regmap to ensure atomiciy
between concurrent operations of clock driver and reset,
power-domain driver that will be introduced in the future.

Signed-off-by: Haylen Chu <heylenay@4d2.org>
---
 drivers/clk/Kconfig               |    1 +
 drivers/clk/Makefile              |    1 +
 drivers/clk/spacemit/Kconfig      |   18 +
 drivers/clk/spacemit/Makefile     |    5 +
 drivers/clk/spacemit/ccu-k1.c     | 1154 +++++++++++++++++++++++++++++
 drivers/clk/spacemit/ccu_common.h |   48 ++
 drivers/clk/spacemit/ccu_ddn.c    |   83 +++
 drivers/clk/spacemit/ccu_ddn.h    |   47 ++
 drivers/clk/spacemit/ccu_mix.c    |  268 +++++++
 drivers/clk/spacemit/ccu_mix.h    |  218 ++++++
 drivers/clk/spacemit/ccu_pll.c    |  157 ++++
 drivers/clk/spacemit/ccu_pll.h    |   86 +++
 12 files changed, 2086 insertions(+)
 create mode 100644 drivers/clk/spacemit/Kconfig
 create mode 100644 drivers/clk/spacemit/Makefile
 create mode 100644 drivers/clk/spacemit/ccu-k1.c
 create mode 100644 drivers/clk/spacemit/ccu_common.h
 create mode 100644 drivers/clk/spacemit/ccu_ddn.c
 create mode 100644 drivers/clk/spacemit/ccu_ddn.h
 create mode 100644 drivers/clk/spacemit/ccu_mix.c
 create mode 100644 drivers/clk/spacemit/ccu_mix.h
 create mode 100644 drivers/clk/spacemit/ccu_pll.c
 create mode 100644 drivers/clk/spacemit/ccu_pll.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 713573b6c86c..19c1ed280fd7 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -517,6 +517,7 @@ source "drivers/clk/samsung/Kconfig"
 source "drivers/clk/sifive/Kconfig"
 source "drivers/clk/socfpga/Kconfig"
 source "drivers/clk/sophgo/Kconfig"
+source "drivers/clk/spacemit/Kconfig"
 source "drivers/clk/sprd/Kconfig"
 source "drivers/clk/starfive/Kconfig"
 source "drivers/clk/sunxi/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index bf4bd45adc3a..42867cd37c33 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -145,6 +145,7 @@ obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
 obj-y					+= socfpga/
 obj-y					+= sophgo/
+obj-y					+= spacemit/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
 obj-y					+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
diff --git a/drivers/clk/spacemit/Kconfig b/drivers/clk/spacemit/Kconfig
new file mode 100644
index 000000000000..4c4df845b3cb
--- /dev/null
+++ b/drivers/clk/spacemit/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SPACEMIT_CCU
+	tristate "Clock support for SpacemiT SoCs"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	select MFD_SYSCON
+	help
+	  Say Y to enable clock controller unit support for SpacemiT SoCs.
+
+if SPACEMIT_CCU
+
+config SPACEMIT_K1_CCU
+	tristate "Support for SpacemiT K1 SoC"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	help
+	  Support for clock controller unit in SpacemiT K1 SoC.
+
+endif
diff --git a/drivers/clk/spacemit/Makefile b/drivers/clk/spacemit/Makefile
new file mode 100644
index 000000000000..5ec6da61db98
--- /dev/null
+++ b/drivers/clk/spacemit/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SPACEMIT_K1_CCU)	= spacemit-ccu-k1.o
+spacemit-ccu-k1-y		= ccu_pll.o ccu_mix.o ccu_ddn.o
+spacemit-ccu-k1-y		+= ccu-k1.o
diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
new file mode 100644
index 000000000000..f1ed9ae08939
--- /dev/null
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -0,0 +1,1154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ */
+
+#include <linux/array_size.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "ccu_common.h"
+#include "ccu_pll.h"
+#include "ccu_mix.h"
+#include "ccu_ddn.h"
+
+#include <dt-bindings/clock/spacemit,k1-syscon.h>
+
+/* APBS register offset */
+#define APBS_PLL1_SWCR1			0x100
+#define APBS_PLL1_SWCR2			0x104
+#define APBS_PLL1_SWCR3			0x108
+#define APBS_PLL2_SWCR1			0x118
+#define APBS_PLL2_SWCR2			0x11c
+#define APBS_PLL2_SWCR3			0x120
+#define APBS_PLL3_SWCR1			0x124
+#define APBS_PLL3_SWCR2			0x128
+#define APBS_PLL3_SWCR3			0x12c
+
+/* MPMU register offset */
+#define MPMU_POSR			0x0010
+#define  POSR_PLL1_LOCK			BIT(27)
+#define  POSR_PLL2_LOCK			BIT(28)
+#define  POSR_PLL3_LOCK			BIT(29)
+#define MPMU_SUCCR			0x0014
+#define MPMU_ISCCR			0x0044
+#define MPMU_WDTPCR			0x0200
+#define MPMU_RIPCCR			0x0210
+#define MPMU_ACGR			0x1024
+#define MPMU_APBCSCR			0x1050
+#define MPMU_SUCCR_1			0x10b0
+
+/* APBC register offset */
+#define APBC_UART1_CLK_RST		0x00
+#define APBC_UART2_CLK_RST		0x04
+#define APBC_GPIO_CLK_RST		0x08
+#define APBC_PWM0_CLK_RST		0x0c
+#define APBC_PWM1_CLK_RST		0x10
+#define APBC_PWM2_CLK_RST		0x14
+#define APBC_PWM3_CLK_RST		0x18
+#define APBC_TWSI8_CLK_RST		0x20
+#define APBC_UART3_CLK_RST		0x24
+#define APBC_RTC_CLK_RST		0x28
+#define APBC_TWSI0_CLK_RST		0x2c
+#define APBC_TWSI1_CLK_RST		0x30
+#define APBC_TIMERS1_CLK_RST		0x34
+#define APBC_TWSI2_CLK_RST		0x38
+#define APBC_AIB_CLK_RST		0x3c
+#define APBC_TWSI4_CLK_RST		0x40
+#define APBC_TIMERS2_CLK_RST		0x44
+#define APBC_ONEWIRE_CLK_RST		0x48
+#define APBC_TWSI5_CLK_RST		0x4c
+#define APBC_DRO_CLK_RST		0x58
+#define APBC_IR_CLK_RST			0x5c
+#define APBC_TWSI6_CLK_RST		0x60
+#define APBC_COUNTER_CLK_SEL		0x64
+#define APBC_TWSI7_CLK_RST		0x68
+#define APBC_TSEN_CLK_RST		0x6c
+#define APBC_UART4_CLK_RST		0x70
+#define APBC_UART5_CLK_RST		0x74
+#define APBC_UART6_CLK_RST		0x78
+#define APBC_SSP3_CLK_RST		0x7c
+#define APBC_SSPA0_CLK_RST		0x80
+#define APBC_SSPA1_CLK_RST		0x84
+#define APBC_IPC_AP2AUD_CLK_RST		0x90
+#define APBC_UART7_CLK_RST		0x94
+#define APBC_UART8_CLK_RST		0x98
+#define APBC_UART9_CLK_RST		0x9c
+#define APBC_CAN0_CLK_RST		0xa0
+#define APBC_PWM4_CLK_RST		0xa8
+#define APBC_PWM5_CLK_RST		0xac
+#define APBC_PWM6_CLK_RST		0xb0
+#define APBC_PWM7_CLK_RST		0xb4
+#define APBC_PWM8_CLK_RST		0xb8
+#define APBC_PWM9_CLK_RST		0xbc
+#define APBC_PWM10_CLK_RST		0xc0
+#define APBC_PWM11_CLK_RST		0xc4
+#define APBC_PWM12_CLK_RST		0xc8
+#define APBC_PWM13_CLK_RST		0xcc
+#define APBC_PWM14_CLK_RST		0xd0
+#define APBC_PWM15_CLK_RST		0xd4
+#define APBC_PWM16_CLK_RST		0xd8
+#define APBC_PWM17_CLK_RST		0xdc
+#define APBC_PWM18_CLK_RST		0xe0
+#define APBC_PWM19_CLK_RST		0xe4
+
+/* APMU register offset */
+#define APMU_JPG_CLK_RES_CTRL		0x020
+#define APMU_CSI_CCIC2_CLK_RES_CTRL	0x024
+#define APMU_ISP_CLK_RES_CTRL		0x038
+#define APMU_LCD_CLK_RES_CTRL1		0x044
+#define APMU_LCD_SPI_CLK_RES_CTRL	0x048
+#define APMU_LCD_CLK_RES_CTRL2		0x04c
+#define APMU_CCIC_CLK_RES_CTRL		0x050
+#define APMU_SDH0_CLK_RES_CTRL		0x054
+#define APMU_SDH1_CLK_RES_CTRL		0x058
+#define APMU_USB_CLK_RES_CTRL		0x05c
+#define APMU_QSPI_CLK_RES_CTRL		0x060
+#define APMU_DMA_CLK_RES_CTRL		0x064
+#define APMU_AES_CLK_RES_CTRL		0x068
+#define APMU_VPU_CLK_RES_CTRL		0x0a4
+#define APMU_GPU_CLK_RES_CTRL		0x0cc
+#define APMU_SDH2_CLK_RES_CTRL		0x0e0
+#define APMU_PMUA_MC_CTRL		0x0e8
+#define APMU_PMU_CC2_AP			0x100
+#define APMU_PMUA_EM_CLK_RES_CTRL	0x104
+#define APMU_AUDIO_CLK_RES_CTRL		0x14c
+#define APMU_HDMI_CLK_RES_CTRL		0x1b8
+#define APMU_CCI550_CLK_CTRL		0x300
+#define APMU_ACLK_CLK_CTRL		0x388
+#define APMU_CPU_C0_CLK_CTRL		0x38C
+#define APMU_CPU_C1_CLK_CTRL		0x390
+#define APMU_PCIE_CLK_RES_CTRL_0	0x3cc
+#define APMU_PCIE_CLK_RES_CTRL_1	0x3d4
+#define APMU_PCIE_CLK_RES_CTRL_2	0x3dc
+#define APMU_EMAC0_CLK_RES_CTRL		0x3e4
+#define APMU_EMAC1_CLK_RES_CTRL		0x3ec
+
+struct spacemit_ccu_data {
+	struct clk_hw **hws;
+	size_t num;
+};
+
+/* APBS clocks start, APBS region contains and only contains all PLL clocks */
+
+/*
+ * PLL{1,2} must run at fixed frequencies to provide clocks in correct rates for
+ * peripherals.
+ */
+static const struct ccu_pll_rate_tbl pll1_rate_tbl[] = {
+	CCU_PLL_RATE(2457600000UL, 0x0050dd64, 0x330ccccd),
+};
+
+static const struct ccu_pll_rate_tbl pll2_rate_tbl[] = {
+	CCU_PLL_RATE(3000000000UL, 0x0050dd66, 0x3fe00000),
+};
+
+static const struct ccu_pll_rate_tbl pll3_rate_tbl[] = {
+	CCU_PLL_RATE(1600000000UL, 0x0050cd61, 0x43eaaaab),
+	CCU_PLL_RATE(1800000000UL, 0x0050cd61, 0x4b000000),
+	CCU_PLL_RATE(2000000000UL, 0x0050dd62, 0x2aeaaaab),
+	CCU_PLL_RATE(2457600000UL, 0x0050dd64, 0x330ccccd),
+	CCU_PLL_RATE(3000000000UL, 0x0050dd66, 0x3fe00000),
+	CCU_PLL_RATE(3200000000UL, 0x0050dd67, 0x43eaaaab),
+};
+
+CCU_PLL_DEFINE(pll1, pll1_rate_tbl, APBS_PLL1_SWCR1, APBS_PLL1_SWCR3, MPMU_POSR, POSR_PLL1_LOCK,
+	       CLK_SET_RATE_GATE);
+CCU_PLL_DEFINE(pll2, pll2_rate_tbl, APBS_PLL2_SWCR1, APBS_PLL2_SWCR3, MPMU_POSR, POSR_PLL2_LOCK,
+	       CLK_SET_RATE_GATE);
+CCU_PLL_DEFINE(pll3, pll3_rate_tbl, APBS_PLL3_SWCR1, APBS_PLL3_SWCR3, MPMU_POSR, POSR_PLL3_LOCK,
+	       CLK_SET_RATE_GATE);
+
+CCU_FACTOR_GATE_DEFINE(pll1_d2, CCU_PARENT_HW(pll1), APBS_PLL1_SWCR2, BIT(1), 2, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d3, CCU_PARENT_HW(pll1), APBS_PLL1_SWCR2, BIT(2), 3, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d4, CCU_PARENT_HW(pll1), APBS_PLL1_SWCR2, BIT(3), 4, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d5, CCU_PARENT_HW(pll1), APBS_PLL1_SWCR2, BIT(4), 5, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d6, CCU_PARENT_HW(pll1), APBS_PLL1_SWCR2, BIT(5), 6, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d7, CCU_PARENT_HW(pll1), APBS_PLL1_SWCR2, BIT(6), 7, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d8, CCU_PARENT_HW(pll1), APBS_PLL1_SWCR2, BIT(7), 8, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d11_223p4, CCU_PARENT_HW(pll1), APBS_PLL1_SWCR2, BIT(15), 11, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d13_189, CCU_PARENT_HW(pll1), APBS_PLL1_SWCR2, BIT(16), 13, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d23_106p8, CCU_PARENT_HW(pll1), APBS_PLL1_SWCR2, BIT(20), 23, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d64_38p4, CCU_PARENT_HW(pll1), APBS_PLL1_SWCR2, BIT(0), 64, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_aud_245p7, CCU_PARENT_HW(pll1), APBS_PLL1_SWCR2, BIT(10), 10, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_aud_24p5, CCU_PARENT_HW(pll1), APBS_PLL1_SWCR2, BIT(11), 100, 1);
+
+CCU_FACTOR_GATE_DEFINE(pll2_d1, CCU_PARENT_HW(pll2), APBS_PLL2_SWCR2, BIT(0), 1, 1);
+CCU_FACTOR_GATE_DEFINE(pll2_d2, CCU_PARENT_HW(pll2), APBS_PLL2_SWCR2, BIT(1), 2, 1);
+CCU_FACTOR_GATE_DEFINE(pll2_d3, CCU_PARENT_HW(pll2), APBS_PLL2_SWCR2, BIT(2), 3, 1);
+CCU_FACTOR_GATE_DEFINE(pll2_d4, CCU_PARENT_HW(pll2), APBS_PLL2_SWCR2, BIT(3), 4, 1);
+CCU_FACTOR_GATE_DEFINE(pll2_d5, CCU_PARENT_HW(pll2), APBS_PLL2_SWCR2, BIT(4), 5, 1);
+CCU_FACTOR_GATE_DEFINE(pll2_d6, CCU_PARENT_HW(pll2), APBS_PLL2_SWCR2, BIT(5), 6, 1);
+CCU_FACTOR_GATE_DEFINE(pll2_d7, CCU_PARENT_HW(pll2), APBS_PLL2_SWCR2, BIT(6), 7, 1);
+CCU_FACTOR_GATE_DEFINE(pll2_d8, CCU_PARENT_HW(pll2), APBS_PLL2_SWCR2, BIT(7), 8, 1);
+
+CCU_FACTOR_GATE_DEFINE(pll3_d1, CCU_PARENT_HW(pll3), APBS_PLL3_SWCR2, BIT(0), 1, 1);
+CCU_FACTOR_GATE_DEFINE(pll3_d2, CCU_PARENT_HW(pll3), APBS_PLL3_SWCR2, BIT(1), 2, 1);
+CCU_FACTOR_GATE_DEFINE(pll3_d3, CCU_PARENT_HW(pll3), APBS_PLL3_SWCR2, BIT(2), 3, 1);
+CCU_FACTOR_GATE_DEFINE(pll3_d4, CCU_PARENT_HW(pll3), APBS_PLL3_SWCR2, BIT(3), 4, 1);
+CCU_FACTOR_GATE_DEFINE(pll3_d5, CCU_PARENT_HW(pll3), APBS_PLL3_SWCR2, BIT(4), 5, 1);
+CCU_FACTOR_GATE_DEFINE(pll3_d6, CCU_PARENT_HW(pll3), APBS_PLL3_SWCR2, BIT(5), 6, 1);
+CCU_FACTOR_GATE_DEFINE(pll3_d7, CCU_PARENT_HW(pll3), APBS_PLL3_SWCR2, BIT(6), 7, 1);
+CCU_FACTOR_GATE_DEFINE(pll3_d8, CCU_PARENT_HW(pll3), APBS_PLL3_SWCR2, BIT(7), 8, 1);
+
+CCU_FACTOR_DEFINE(pll3_20, CCU_PARENT_HW(pll3_d8), 20, 1);
+CCU_FACTOR_DEFINE(pll3_40, CCU_PARENT_HW(pll3_d8), 10, 1);
+CCU_FACTOR_DEFINE(pll3_80, CCU_PARENT_HW(pll3_d8), 5, 1);
+
+/* APBS clocks end */
+
+/* MPMU clocks start */
+CCU_GATE_DEFINE(pll1_d8_307p2, CCU_PARENT_HW(pll1_d8), MPMU_ACGR, BIT(13), 0);
+
+CCU_FACTOR_DEFINE(pll1_d32_76p8, CCU_PARENT_HW(pll1_d8_307p2), 4, 1);
+
+CCU_FACTOR_DEFINE(pll1_d40_61p44, CCU_PARENT_HW(pll1_d8_307p2), 5, 1);
+
+CCU_FACTOR_DEFINE(pll1_d16_153p6, CCU_PARENT_HW(pll1_d8), 2, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d24_102p4, CCU_PARENT_HW(pll1_d8), MPMU_ACGR, BIT(12), 3, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d48_51p2, CCU_PARENT_HW(pll1_d8), MPMU_ACGR, BIT(7), 6, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d48_51p2_ap, CCU_PARENT_HW(pll1_d8), MPMU_ACGR, BIT(11), 6, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_m3d128_57p6, CCU_PARENT_HW(pll1_d8), MPMU_ACGR, BIT(8), 16, 3);
+CCU_FACTOR_GATE_DEFINE(pll1_d96_25p6, CCU_PARENT_HW(pll1_d8), MPMU_ACGR, BIT(4), 12, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d192_12p8, CCU_PARENT_HW(pll1_d8), MPMU_ACGR, BIT(3), 24, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d192_12p8_wdt, CCU_PARENT_HW(pll1_d8), MPMU_ACGR, BIT(19), 24, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d384_6p4, CCU_PARENT_HW(pll1_d8), MPMU_ACGR, BIT(2), 48, 1);
+
+CCU_FACTOR_DEFINE(pll1_d768_3p2, CCU_PARENT_HW(pll1_d384_6p4), 2, 1);
+CCU_FACTOR_DEFINE(pll1_d1536_1p6, CCU_PARENT_HW(pll1_d384_6p4), 4, 1);
+CCU_FACTOR_DEFINE(pll1_d3072_0p8, CCU_PARENT_HW(pll1_d384_6p4), 8, 1);
+
+CCU_GATE_DEFINE(pll1_d6_409p6, CCU_PARENT_HW(pll1_d6), MPMU_ACGR, BIT(0), 0);
+CCU_FACTOR_GATE_DEFINE(pll1_d12_204p8, CCU_PARENT_HW(pll1_d6), MPMU_ACGR, BIT(5), 2, 1);
+
+CCU_GATE_DEFINE(pll1_d5_491p52, CCU_PARENT_HW(pll1_d5), MPMU_ACGR, BIT(21), 0);
+CCU_FACTOR_GATE_DEFINE(pll1_d10_245p76, CCU_PARENT_HW(pll1_d5), MPMU_ACGR, BIT(18), 2, 1);
+
+CCU_GATE_DEFINE(pll1_d4_614p4, CCU_PARENT_HW(pll1_d4), MPMU_ACGR, BIT(15), 0);
+CCU_FACTOR_GATE_DEFINE(pll1_d52_47p26, CCU_PARENT_HW(pll1_d4), MPMU_ACGR, BIT(10), 13, 1);
+CCU_FACTOR_GATE_DEFINE(pll1_d78_31p5, CCU_PARENT_HW(pll1_d4), MPMU_ACGR, BIT(6), 39, 2);
+
+CCU_GATE_DEFINE(pll1_d3_819p2, CCU_PARENT_HW(pll1_d3), MPMU_ACGR, BIT(14), 0);
+
+CCU_GATE_DEFINE(pll1_d2_1228p8, CCU_PARENT_HW(pll1_d2), MPMU_ACGR, BIT(16), 0);
+
+CCU_GATE_DEFINE(slow_uart, CCU_PARENT_NAME(osc), MPMU_ACGR, BIT(1), CLK_IGNORE_UNUSED);
+CCU_DDN_DEFINE(slow_uart1_14p74, pll1_d16_153p6, MPMU_SUCCR, GENMASK(28, 16), GENMASK(12, 0), 0);
+CCU_DDN_DEFINE(slow_uart2_48, pll1_d4_614p4, MPMU_SUCCR_1, GENMASK(28, 16), GENMASK(12, 0), 0);
+
+CCU_GATE_DEFINE(wdt_clk, CCU_PARENT_HW(pll1_d96_25p6), MPMU_WDTPCR, BIT(1), 0);
+
+CCU_FACTOR_GATE_DEFINE(i2s_sysclk, CCU_PARENT_HW(pll1_d16_153p6), MPMU_ISCCR, BIT(31), 50, 1);
+CCU_FACTOR_GATE_DEFINE(i2s_bclk, CCU_PARENT_HW(i2s_sysclk), MPMU_ISCCR, BIT(29), 1, 1);
+
+static const struct clk_parent_data apb_parents[] = {
+	CCU_PARENT_HW(pll1_d96_25p6),
+	CCU_PARENT_HW(pll1_d48_51p2),
+	CCU_PARENT_HW(pll1_d96_25p6),
+	CCU_PARENT_HW(pll1_d24_102p4),
+};
+CCU_MUX_DEFINE(apb_clk, apb_parents, MPMU_APBCSCR, 0, 2, 0);
+
+CCU_GATE_DEFINE(wdt_bus_clk, CCU_PARENT_HW(apb_clk), MPMU_WDTPCR, BIT(0), 0);
+
+CCU_GATE_DEFINE(ripc_clk, CCU_PARENT_HW(apb_clk), MPMU_RIPCCR, 0x1, 0);
+/* MPMU clocks end */
+
+/* APBC clocks start */
+static const struct clk_parent_data uart_clk_parents[] = {
+	CCU_PARENT_HW(pll1_m3d128_57p6),
+	CCU_PARENT_HW(slow_uart1_14p74),
+	CCU_PARENT_HW(slow_uart2_48),
+};
+CCU_MUX_GATE_DEFINE(uart0_clk, uart_clk_parents, APBC_UART1_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(uart2_clk, uart_clk_parents, APBC_UART2_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(uart3_clk, uart_clk_parents, APBC_UART3_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(uart4_clk, uart_clk_parents, APBC_UART4_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(uart5_clk, uart_clk_parents, APBC_UART5_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(uart6_clk, uart_clk_parents, APBC_UART6_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(uart7_clk, uart_clk_parents, APBC_UART7_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(uart8_clk, uart_clk_parents, APBC_UART8_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(uart9_clk, uart_clk_parents, APBC_UART9_CLK_RST, 4, 3, BIT(1), 0);
+
+CCU_GATE_DEFINE(gpio_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_GPIO_CLK_RST, BIT(1), 0);
+
+static const struct clk_parent_data pwm_parents[] = {
+	CCU_PARENT_HW(pll1_d192_12p8),
+	CCU_PARENT_NAME(osc),
+};
+CCU_MUX_GATE_DEFINE(pwm0_clk, pwm_parents, APBC_PWM0_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm1_clk, pwm_parents, APBC_PWM1_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm2_clk, pwm_parents, APBC_PWM2_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm3_clk, pwm_parents, APBC_PWM3_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm4_clk, pwm_parents, APBC_PWM4_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm5_clk, pwm_parents, APBC_PWM5_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm6_clk, pwm_parents, APBC_PWM6_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm7_clk, pwm_parents, APBC_PWM7_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm8_clk, pwm_parents, APBC_PWM8_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm9_clk, pwm_parents, APBC_PWM9_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm10_clk, pwm_parents, APBC_PWM10_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm11_clk, pwm_parents, APBC_PWM11_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm12_clk, pwm_parents, APBC_PWM12_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm13_clk, pwm_parents, APBC_PWM13_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm14_clk, pwm_parents, APBC_PWM14_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm15_clk, pwm_parents, APBC_PWM15_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm16_clk, pwm_parents, APBC_PWM16_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm17_clk, pwm_parents, APBC_PWM17_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm18_clk, pwm_parents, APBC_PWM18_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(pwm19_clk, pwm_parents, APBC_PWM19_CLK_RST, 4, 3, BIT(1), 0);
+
+static const struct clk_parent_data ssp_parents[] = {
+	CCU_PARENT_HW(pll1_d384_6p4),
+	CCU_PARENT_HW(pll1_d192_12p8),
+	CCU_PARENT_HW(pll1_d96_25p6),
+	CCU_PARENT_HW(pll1_d48_51p2),
+	CCU_PARENT_HW(pll1_d768_3p2),
+	CCU_PARENT_HW(pll1_d1536_1p6),
+	CCU_PARENT_HW(pll1_d3072_0p8),
+};
+CCU_MUX_GATE_DEFINE(ssp3_clk, ssp_parents, APBC_SSP3_CLK_RST, 4, 3, BIT(1), 0);
+
+CCU_GATE_DEFINE(rtc_clk, CCU_PARENT_NAME(osc), APBC_RTC_CLK_RST,
+		BIT(7) | BIT(1), 0);
+
+static const struct clk_parent_data twsi_parents[] = {
+	CCU_PARENT_HW(pll1_d78_31p5),
+	CCU_PARENT_HW(pll1_d48_51p2),
+	CCU_PARENT_HW(pll1_d40_61p44),
+};
+CCU_MUX_GATE_DEFINE(twsi0_clk, twsi_parents, APBC_TWSI0_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(twsi1_clk, twsi_parents, APBC_TWSI1_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(twsi2_clk, twsi_parents, APBC_TWSI2_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(twsi4_clk, twsi_parents, APBC_TWSI4_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(twsi5_clk, twsi_parents, APBC_TWSI5_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(twsi6_clk, twsi_parents, APBC_TWSI6_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(twsi7_clk, twsi_parents, APBC_TWSI7_CLK_RST, 4, 3, BIT(1), 0);
+
+static const struct clk_parent_data timer_parents[] = {
+	CCU_PARENT_HW(pll1_d192_12p8),
+	CCU_PARENT_NAME(osc),
+	CCU_PARENT_HW(pll1_d384_6p4),
+	CCU_PARENT_NAME(vctcxo_3m),
+	CCU_PARENT_NAME(vctcxo_1m),
+};
+CCU_MUX_GATE_DEFINE(timers1_clk, timer_parents, APBC_TIMERS1_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(timers2_clk, timer_parents, APBC_TIMERS2_CLK_RST, 4, 3, BIT(1), 0);
+
+CCU_GATE_DEFINE(aib_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_AIB_CLK_RST, BIT(1), 0);
+
+CCU_GATE_DEFINE(onewire_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_ONEWIRE_CLK_RST, BIT(1), 0);
+
+static const struct clk_parent_data sspa_parents[] = {
+	CCU_PARENT_HW(pll1_d384_6p4),
+	CCU_PARENT_HW(pll1_d192_12p8),
+	CCU_PARENT_HW(pll1_d96_25p6),
+	CCU_PARENT_HW(pll1_d48_51p2),
+	CCU_PARENT_HW(pll1_d768_3p2),
+	CCU_PARENT_HW(pll1_d1536_1p6),
+	CCU_PARENT_HW(pll1_d3072_0p8),
+	CCU_PARENT_HW(i2s_bclk),
+};
+CCU_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
+CCU_GATE_DEFINE(dro_clk, CCU_PARENT_HW(apb_clk), APBC_DRO_CLK_RST, BIT(1), 0);
+CCU_GATE_DEFINE(ir_clk, CCU_PARENT_HW(apb_clk), APBC_IR_CLK_RST, BIT(1), 0);
+CCU_GATE_DEFINE(tsen_clk, CCU_PARENT_HW(apb_clk), APBC_TSEN_CLK_RST, BIT(1), 0);
+CCU_GATE_DEFINE(ipc_ap2aud_clk, CCU_PARENT_HW(apb_clk), APBC_IPC_AP2AUD_CLK_RST, BIT(1), 0);
+
+static const struct clk_parent_data can_parents[] = {
+	CCU_PARENT_HW(pll3_20),
+	CCU_PARENT_HW(pll3_40),
+	CCU_PARENT_HW(pll3_80),
+};
+CCU_MUX_GATE_DEFINE(can0_clk, can_parents, APBC_CAN0_CLK_RST, 4, 3, BIT(1), 0);
+CCU_GATE_DEFINE(can0_bus_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_CAN0_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(uart0_bus_clk, CCU_PARENT_HW(apb_clk), APBC_UART1_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(uart2_bus_clk, CCU_PARENT_HW(apb_clk), APBC_UART2_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(uart3_bus_clk, CCU_PARENT_HW(apb_clk), APBC_UART3_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(uart4_bus_clk, CCU_PARENT_HW(apb_clk), APBC_UART4_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(uart5_bus_clk, CCU_PARENT_HW(apb_clk), APBC_UART5_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(uart6_bus_clk, CCU_PARENT_HW(apb_clk), APBC_UART6_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(uart7_bus_clk, CCU_PARENT_HW(apb_clk), APBC_UART7_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(uart8_bus_clk, CCU_PARENT_HW(apb_clk), APBC_UART8_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(uart9_bus_clk, CCU_PARENT_HW(apb_clk), APBC_UART9_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(gpio_bus_clk, CCU_PARENT_HW(apb_clk), APBC_GPIO_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(pwm0_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM0_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm1_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM1_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm2_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM2_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm3_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM3_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm4_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM4_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm5_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM5_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm6_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM6_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm7_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM7_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm8_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM8_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm9_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM9_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm10_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM10_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm11_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM11_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm12_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM12_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm13_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM13_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm14_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM14_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm15_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM15_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm16_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM16_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm17_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM17_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm18_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM18_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(pwm19_bus_clk, CCU_PARENT_HW(apb_clk), APBC_PWM19_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(ssp3_bus_clk, CCU_PARENT_HW(apb_clk), APBC_SSP3_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(rtc_bus_clk, CCU_PARENT_HW(apb_clk), APBC_RTC_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(twsi0_bus_clk, CCU_PARENT_HW(apb_clk), APBC_TWSI0_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(twsi1_bus_clk, CCU_PARENT_HW(apb_clk), APBC_TWSI1_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(twsi2_bus_clk, CCU_PARENT_HW(apb_clk), APBC_TWSI2_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(twsi4_bus_clk, CCU_PARENT_HW(apb_clk), APBC_TWSI4_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(twsi5_bus_clk, CCU_PARENT_HW(apb_clk), APBC_TWSI5_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(twsi6_bus_clk, CCU_PARENT_HW(apb_clk), APBC_TWSI6_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(twsi7_bus_clk, CCU_PARENT_HW(apb_clk), APBC_TWSI7_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(timers1_bus_clk, CCU_PARENT_HW(apb_clk), APBC_TIMERS1_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(timers2_bus_clk, CCU_PARENT_HW(apb_clk), APBC_TIMERS2_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(aib_bus_clk, CCU_PARENT_HW(apb_clk), APBC_AIB_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(onewire_bus_clk, CCU_PARENT_HW(apb_clk), APBC_ONEWIRE_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(sspa0_bus_clk, CCU_PARENT_HW(apb_clk), APBC_SSPA0_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(sspa1_bus_clk, CCU_PARENT_HW(apb_clk), APBC_SSPA1_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(tsen_bus_clk, CCU_PARENT_HW(apb_clk), APBC_TSEN_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(ipc_ap2aud_bus_clk, CCU_PARENT_HW(apb_clk), APBC_IPC_AP2AUD_CLK_RST, BIT(0), 0);
+/* APBC clocks end */
+
+/* APMU clocks start */
+static const struct clk_parent_data pmua_aclk_parents[] = {
+	CCU_PARENT_HW(pll1_d10_245p76),
+	CCU_PARENT_HW(pll1_d8_307p2),
+};
+CCU_MUX_DIV_FC_DEFINE(pmua_aclk, pmua_aclk_parents, APMU_ACLK_CLK_CTRL, 1, 2, BIT(4), 0, 1, 0);
+
+static const struct clk_parent_data cci550_clk_parents[] = {
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll1_d3_819p2),
+	CCU_PARENT_HW(pll2_d3),
+};
+CCU_MUX_DIV_FC_DEFINE(cci550_clk, cci550_clk_parents, APMU_CCI550_CLK_CTRL, 8, 3, BIT(12), 0, 2,
+		      CLK_IS_CRITICAL);
+
+static const struct clk_parent_data cpu_c0_hi_clk_parents[] = {
+	CCU_PARENT_HW(pll3_d2),
+	CCU_PARENT_HW(pll3_d1),
+};
+CCU_MUX_DEFINE(cpu_c0_hi_clk, cpu_c0_hi_clk_parents, APMU_CPU_C0_CLK_CTRL, 13, 1, 0);
+static const struct clk_parent_data cpu_c0_clk_parents[] = {
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll1_d3_819p2),
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d2_1228p8),
+	CCU_PARENT_HW(pll3_d3),
+	CCU_PARENT_HW(pll2_d3),
+	CCU_PARENT_HW(cpu_c0_hi_clk),
+};
+CCU_MUX_FC_DEFINE(cpu_c0_core_clk, cpu_c0_clk_parents, APMU_CPU_C0_CLK_CTRL, BIT(12), 0, 3,
+		  CLK_IS_CRITICAL);
+CCU_DIV_DEFINE(cpu_c0_ace_clk, CCU_PARENT_HW(cpu_c0_core_clk), APMU_CPU_C0_CLK_CTRL, 6, 3,
+	       CLK_IS_CRITICAL);
+CCU_DIV_DEFINE(cpu_c0_tcm_clk, CCU_PARENT_HW(cpu_c0_core_clk), APMU_CPU_C0_CLK_CTRL, 9, 3,
+	       CLK_IS_CRITICAL);
+
+static const struct clk_parent_data cpu_c1_hi_clk_parents[] = {
+	CCU_PARENT_HW(pll3_d2),
+	CCU_PARENT_HW(pll3_d1),
+};
+CCU_MUX_DEFINE(cpu_c1_hi_clk, cpu_c1_hi_clk_parents, APMU_CPU_C1_CLK_CTRL, 13, 1, 0);
+static const struct clk_parent_data cpu_c1_clk_parents[] = {
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll1_d3_819p2),
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d2_1228p8),
+	CCU_PARENT_HW(pll3_d3),
+	CCU_PARENT_HW(pll2_d3),
+	CCU_PARENT_HW(cpu_c1_hi_clk),
+};
+CCU_MUX_FC_DEFINE(cpu_c1_core_clk, cpu_c1_clk_parents, APMU_CPU_C1_CLK_CTRL, BIT(12), 0, 3,
+		  CLK_IS_CRITICAL);
+CCU_DIV_DEFINE(cpu_c1_ace_clk, CCU_PARENT_HW(cpu_c1_core_clk), APMU_CPU_C1_CLK_CTRL, 6, 3,
+	       CLK_IS_CRITICAL);
+
+static const struct clk_parent_data jpg_parents[] = {
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d3_819p2),
+	CCU_PARENT_HW(pll1_d2_1228p8),
+	CCU_PARENT_HW(pll2_d4),
+	CCU_PARENT_HW(pll2_d3),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(jpg_clk, jpg_parents, APMU_JPG_CLK_RES_CTRL, 5, 3, BIT(15), 2, 3,
+			   BIT(1), 0);
+
+static const struct clk_parent_data ccic2phy_parents[] = {
+	CCU_PARENT_HW(pll1_d24_102p4),
+	CCU_PARENT_HW(pll1_d48_51p2_ap),
+};
+CCU_MUX_GATE_DEFINE(ccic2phy_clk, ccic2phy_parents, APMU_CSI_CCIC2_CLK_RES_CTRL, 7, 1, BIT(5), 0);
+
+static const struct clk_parent_data ccic3phy_parents[] = {
+	CCU_PARENT_HW(pll1_d24_102p4),
+	CCU_PARENT_HW(pll1_d48_51p2_ap),
+};
+CCU_MUX_GATE_DEFINE(ccic3phy_clk, ccic3phy_parents, APMU_CSI_CCIC2_CLK_RES_CTRL, 31, 1, BIT(30), 0);
+
+static const struct clk_parent_data csi_parents[] = {
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll1_d3_819p2),
+	CCU_PARENT_HW(pll2_d2),
+	CCU_PARENT_HW(pll2_d3),
+	CCU_PARENT_HW(pll2_d4),
+	CCU_PARENT_HW(pll1_d2_1228p8),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(csi_clk, csi_parents, APMU_CSI_CCIC2_CLK_RES_CTRL, 20, 3, BIT(15),
+			   16, 3, BIT(4), 0);
+
+static const struct clk_parent_data camm_parents[] = {
+	CCU_PARENT_HW(pll1_d8_307p2),
+	CCU_PARENT_HW(pll2_d5),
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_NAME(vctcxo_24m),
+};
+CCU_MUX_DIV_GATE_DEFINE(camm0_clk, camm_parents, APMU_CSI_CCIC2_CLK_RES_CTRL, 23, 4, 8, 2,
+			BIT(28), 0);
+CCU_MUX_DIV_GATE_DEFINE(camm1_clk, camm_parents, APMU_CSI_CCIC2_CLK_RES_CTRL, 23, 4, 8, 2,
+			BIT(6), 0);
+CCU_MUX_DIV_GATE_DEFINE(camm2_clk, camm_parents, APMU_CSI_CCIC2_CLK_RES_CTRL, 23, 4, 8, 2,
+			BIT(3), 0);
+
+static const struct clk_parent_data isp_cpp_parents[] = {
+	CCU_PARENT_HW(pll1_d8_307p2),
+	CCU_PARENT_HW(pll1_d6_409p6),
+};
+CCU_MUX_DIV_GATE_DEFINE(isp_cpp_clk, isp_cpp_parents, APMU_ISP_CLK_RES_CTRL, 24, 2, 26, 1,
+			BIT(28), 0);
+static const struct clk_parent_data isp_bus_parents[] = {
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d8_307p2),
+	CCU_PARENT_HW(pll1_d10_245p76),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(isp_bus_clk, isp_bus_parents, APMU_ISP_CLK_RES_CTRL, 18, 3, BIT(23),
+			   21, 2, BIT(17), 0);
+static const struct clk_parent_data isp_parents[] = {
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll1_d8_307p2),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(isp_clk, isp_parents, APMU_ISP_CLK_RES_CTRL, 4, 3, BIT(7), 8, 2,
+			   BIT(1), 0);
+
+static const struct clk_parent_data dpumclk_parents[] = {
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll1_d8_307p2),
+};
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(dpu_mclk, dpumclk_parents, APMU_LCD_CLK_RES_CTRL2,
+				 APMU_LCD_CLK_RES_CTRL1, 1, 4, BIT(29), 5, 3, BIT(0), 0);
+
+static const struct clk_parent_data dpuesc_parents[] = {
+	CCU_PARENT_HW(pll1_d48_51p2_ap),
+	CCU_PARENT_HW(pll1_d52_47p26),
+	CCU_PARENT_HW(pll1_d96_25p6),
+	CCU_PARENT_HW(pll1_d32_76p8),
+};
+CCU_MUX_GATE_DEFINE(dpu_esc_clk, dpuesc_parents, APMU_LCD_CLK_RES_CTRL1, 0, 2, BIT(2), 0);
+
+static const struct clk_parent_data dpubit_parents[] = {
+	CCU_PARENT_HW(pll1_d3_819p2),
+	CCU_PARENT_HW(pll2_d2),
+	CCU_PARENT_HW(pll2_d3),
+	CCU_PARENT_HW(pll1_d2_1228p8),
+	CCU_PARENT_HW(pll2_d4),
+	CCU_PARENT_HW(pll2_d5),
+	CCU_PARENT_HW(pll2_d7),
+	CCU_PARENT_HW(pll2_d8),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(dpu_bit_clk, dpubit_parents, APMU_LCD_CLK_RES_CTRL1, 17, 3, BIT(31),
+			   20, 3, BIT(16), 0);
+
+static const struct clk_parent_data dpupx_parents[] = {
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll1_d8_307p2),
+	CCU_PARENT_HW(pll2_d7),
+	CCU_PARENT_HW(pll2_d8),
+};
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(dpu_pxclk, dpupx_parents, APMU_LCD_CLK_RES_CTRL2,
+				 APMU_LCD_CLK_RES_CTRL1, 17, 4, BIT(30), 21, 3, BIT(16), 0);
+
+CCU_GATE_DEFINE(dpu_hclk, CCU_PARENT_HW(pmua_aclk), APMU_LCD_CLK_RES_CTRL1,
+		BIT(5), 0);
+
+static const struct clk_parent_data dpu_spi_parents[] = {
+	CCU_PARENT_HW(pll1_d8_307p2),
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d10_245p76),
+	CCU_PARENT_HW(pll1_d11_223p4),
+	CCU_PARENT_HW(pll1_d13_189),
+	CCU_PARENT_HW(pll1_d23_106p8),
+	CCU_PARENT_HW(pll2_d3),
+	CCU_PARENT_HW(pll2_d5),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(dpu_spi_clk, dpu_spi_parents, APMU_LCD_SPI_CLK_RES_CTRL, 8, 3,
+			   BIT(7), 12, 3, BIT(1), 0);
+CCU_GATE_DEFINE(dpu_spi_hbus_clk, CCU_PARENT_HW(pmua_aclk), APMU_LCD_SPI_CLK_RES_CTRL, BIT(3), 0);
+CCU_GATE_DEFINE(dpu_spi_bus_clk, CCU_PARENT_HW(pmua_aclk), APMU_LCD_SPI_CLK_RES_CTRL, BIT(5), 0);
+CCU_GATE_DEFINE(dpu_spi_aclk, CCU_PARENT_HW(pmua_aclk), APMU_LCD_SPI_CLK_RES_CTRL, BIT(6), 0);
+
+static const struct clk_parent_data v2d_parents[] = {
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d8_307p2),
+	CCU_PARENT_HW(pll1_d4_614p4),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(v2d_clk, v2d_parents, APMU_LCD_CLK_RES_CTRL1, 9, 3, BIT(28), 12, 2,
+			   BIT(8), 0);
+
+static const struct clk_parent_data ccic_4x_parents[] = {
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll1_d3_819p2),
+	CCU_PARENT_HW(pll2_d2),
+	CCU_PARENT_HW(pll2_d3),
+	CCU_PARENT_HW(pll2_d4),
+	CCU_PARENT_HW(pll1_d2_1228p8),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(ccic_4x_clk, ccic_4x_parents, APMU_CCIC_CLK_RES_CTRL, 18, 3,
+			   BIT(15), 23, 2, BIT(4), 0);
+
+static const struct clk_parent_data ccic1phy_parents[] = {
+	CCU_PARENT_HW(pll1_d24_102p4),
+	CCU_PARENT_HW(pll1_d48_51p2_ap),
+};
+CCU_MUX_GATE_DEFINE(ccic1phy_clk, ccic1phy_parents, APMU_CCIC_CLK_RES_CTRL, 7, 1, BIT(5), 0);
+
+CCU_GATE_DEFINE(sdh_axi_aclk, CCU_PARENT_HW(pmua_aclk), APMU_SDH0_CLK_RES_CTRL, BIT(3), 0);
+static const struct clk_parent_data sdh01_parents[] = {
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll2_d8),
+	CCU_PARENT_HW(pll2_d5),
+	CCU_PARENT_HW(pll1_d11_223p4),
+	CCU_PARENT_HW(pll1_d13_189),
+	CCU_PARENT_HW(pll1_d23_106p8),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(sdh0_clk, sdh01_parents, APMU_SDH0_CLK_RES_CTRL, 8, 3, BIT(11), 5, 3,
+			   BIT(4), 0);
+CCU_MUX_DIV_GATE_FC_DEFINE(sdh1_clk, sdh01_parents, APMU_SDH1_CLK_RES_CTRL, 8, 3, BIT(11), 5, 3,
+			   BIT(4), 0);
+static const struct clk_parent_data sdh2_parents[] = {
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll2_d8),
+	CCU_PARENT_HW(pll1_d3_819p2),
+	CCU_PARENT_HW(pll1_d11_223p4),
+	CCU_PARENT_HW(pll1_d13_189),
+	CCU_PARENT_HW(pll1_d23_106p8),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(sdh2_clk, sdh2_parents, APMU_SDH2_CLK_RES_CTRL, 8, 3, BIT(11), 5, 3,
+			   BIT(4), 0);
+
+CCU_GATE_DEFINE(usb_axi_clk, CCU_PARENT_HW(pmua_aclk), APMU_USB_CLK_RES_CTRL, BIT(1), 0);
+CCU_GATE_DEFINE(usb_p1_aclk, CCU_PARENT_HW(pmua_aclk), APMU_USB_CLK_RES_CTRL, BIT(5), 0);
+CCU_GATE_DEFINE(usb30_clk, CCU_PARENT_HW(pmua_aclk), APMU_USB_CLK_RES_CTRL, BIT(8), 0);
+
+static const struct clk_parent_data qspi_parents[] = {
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll2_d8),
+	CCU_PARENT_HW(pll1_d8_307p2),
+	CCU_PARENT_HW(pll1_d10_245p76),
+	CCU_PARENT_HW(pll1_d11_223p4),
+	CCU_PARENT_HW(pll1_d23_106p8),
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d13_189),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(qspi_clk, qspi_parents, APMU_QSPI_CLK_RES_CTRL, 9, 3, BIT(12), 6, 3,
+			   BIT(4), 0);
+CCU_GATE_DEFINE(qspi_bus_clk, CCU_PARENT_HW(pmua_aclk), APMU_QSPI_CLK_RES_CTRL, BIT(3), 0);
+CCU_GATE_DEFINE(dma_clk, CCU_PARENT_HW(pmua_aclk), APMU_DMA_CLK_RES_CTRL, BIT(3), 0);
+
+static const struct clk_parent_data aes_parents[] = {
+	CCU_PARENT_HW(pll1_d12_204p8),
+	CCU_PARENT_HW(pll1_d24_102p4),
+};
+CCU_MUX_GATE_DEFINE(aes_clk, aes_parents, APMU_AES_CLK_RES_CTRL, 6, 1, BIT(5), 0);
+
+static const struct clk_parent_data vpu_parents[] = {
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d3_819p2),
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll3_d6),
+	CCU_PARENT_HW(pll2_d3),
+	CCU_PARENT_HW(pll2_d4),
+	CCU_PARENT_HW(pll2_d5),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(vpu_clk, vpu_parents, APMU_VPU_CLK_RES_CTRL, 13, 3, BIT(21), 10, 3,
+			   BIT(3), 0);
+
+static const struct clk_parent_data gpu_parents[] = {
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d3_819p2),
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll3_d6),
+	CCU_PARENT_HW(pll2_d3),
+	CCU_PARENT_HW(pll2_d4),
+	CCU_PARENT_HW(pll2_d5),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(gpu_clk, gpu_parents, APMU_GPU_CLK_RES_CTRL, 12, 3, BIT(15), 18, 3,
+			   BIT(4), 0);
+
+static const struct clk_parent_data emmc_parents[] = {
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll1_d52_47p26),
+	CCU_PARENT_HW(pll1_d3_819p2),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(emmc_clk, emmc_parents, APMU_PMUA_EM_CLK_RES_CTRL, 8, 3, BIT(11),
+			   6, 2, BIT(4), 0);
+CCU_DIV_GATE_DEFINE(emmc_x_clk, CCU_PARENT_HW(pll1_d2_1228p8), APMU_PMUA_EM_CLK_RES_CTRL, 12,
+		    3, BIT(15), 0);
+
+static const struct clk_parent_data audio_parents[] = {
+	CCU_PARENT_HW(pll1_aud_245p7),
+	CCU_PARENT_HW(pll1_d8_307p2),
+	CCU_PARENT_HW(pll1_d6_409p6),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(audio_clk, audio_parents, APMU_AUDIO_CLK_RES_CTRL, 4, 3, BIT(15),
+			   7, 3, BIT(12), 0);
+
+static const struct clk_parent_data hdmi_parents[] = {
+	CCU_PARENT_HW(pll1_d6_409p6),
+	CCU_PARENT_HW(pll1_d5_491p52),
+	CCU_PARENT_HW(pll1_d4_614p4),
+	CCU_PARENT_HW(pll1_d8_307p2),
+};
+CCU_MUX_DIV_GATE_FC_DEFINE(hdmi_mclk, hdmi_parents, APMU_HDMI_CLK_RES_CTRL, 1, 4, BIT(29), 5,
+			   3, BIT(0), 0);
+
+CCU_GATE_DEFINE(pcie0_master_clk, CCU_PARENT_HW(pmua_aclk), APMU_PCIE_CLK_RES_CTRL_0, BIT(2), 0);
+CCU_GATE_DEFINE(pcie0_slave_clk, CCU_PARENT_HW(pmua_aclk), APMU_PCIE_CLK_RES_CTRL_0, BIT(1), 0);
+CCU_GATE_DEFINE(pcie0_dbi_clk, CCU_PARENT_HW(pmua_aclk), APMU_PCIE_CLK_RES_CTRL_0, BIT(0), 0);
+
+CCU_GATE_DEFINE(pcie1_master_clk, CCU_PARENT_HW(pmua_aclk), APMU_PCIE_CLK_RES_CTRL_1, BIT(2), 0);
+CCU_GATE_DEFINE(pcie1_slave_clk, CCU_PARENT_HW(pmua_aclk), APMU_PCIE_CLK_RES_CTRL_1, BIT(1), 0);
+CCU_GATE_DEFINE(pcie1_dbi_clk, CCU_PARENT_HW(pmua_aclk), APMU_PCIE_CLK_RES_CTRL_1, BIT(0), 0);
+
+CCU_GATE_DEFINE(pcie2_master_clk, CCU_PARENT_HW(pmua_aclk), APMU_PCIE_CLK_RES_CTRL_2, BIT(2), 0);
+CCU_GATE_DEFINE(pcie2_slave_clk, CCU_PARENT_HW(pmua_aclk), APMU_PCIE_CLK_RES_CTRL_2, BIT(1), 0);
+CCU_GATE_DEFINE(pcie2_dbi_clk, CCU_PARENT_HW(pmua_aclk), APMU_PCIE_CLK_RES_CTRL_2, BIT(0), 0);
+
+CCU_GATE_DEFINE(emac0_bus_clk, CCU_PARENT_HW(pmua_aclk), APMU_EMAC0_CLK_RES_CTRL, BIT(0), 0);
+CCU_GATE_DEFINE(emac0_ptp_clk, CCU_PARENT_HW(pll2_d6), APMU_EMAC0_CLK_RES_CTRL, BIT(15), 0);
+CCU_GATE_DEFINE(emac1_bus_clk, CCU_PARENT_HW(pmua_aclk), APMU_EMAC1_CLK_RES_CTRL, BIT(0), 0);
+CCU_GATE_DEFINE(emac1_ptp_clk, CCU_PARENT_HW(pll2_d6), APMU_EMAC1_CLK_RES_CTRL, BIT(15), 0);
+
+CCU_GATE_DEFINE(emmc_bus_clk, CCU_PARENT_HW(pmua_aclk), APMU_PMUA_EM_CLK_RES_CTRL, BIT(3), 0);
+/* APMU clocks end */
+
+static struct clk_hw *k1_ccu_pll_hws[] = {
+	[CLK_PLL1]		= &pll1.common.hw,
+	[CLK_PLL2]		= &pll2.common.hw,
+	[CLK_PLL3]		= &pll3.common.hw,
+	[CLK_PLL1_D2]		= &pll1_d2.common.hw,
+	[CLK_PLL1_D3]		= &pll1_d3.common.hw,
+	[CLK_PLL1_D4]		= &pll1_d4.common.hw,
+	[CLK_PLL1_D5]		= &pll1_d5.common.hw,
+	[CLK_PLL1_D6]		= &pll1_d6.common.hw,
+	[CLK_PLL1_D7]		= &pll1_d7.common.hw,
+	[CLK_PLL1_D8]		= &pll1_d8.common.hw,
+	[CLK_PLL1_D11]		= &pll1_d11_223p4.common.hw,
+	[CLK_PLL1_D13]		= &pll1_d13_189.common.hw,
+	[CLK_PLL1_D23]		= &pll1_d23_106p8.common.hw,
+	[CLK_PLL1_D64]		= &pll1_d64_38p4.common.hw,
+	[CLK_PLL1_D10_AUD]	= &pll1_aud_245p7.common.hw,
+	[CLK_PLL1_D100_AUD]	= &pll1_aud_24p5.common.hw,
+	[CLK_PLL2_D1]		= &pll2_d1.common.hw,
+	[CLK_PLL2_D2]		= &pll2_d2.common.hw,
+	[CLK_PLL2_D3]		= &pll2_d3.common.hw,
+	[CLK_PLL2_D4]		= &pll2_d4.common.hw,
+	[CLK_PLL2_D5]		= &pll2_d5.common.hw,
+	[CLK_PLL2_D6]		= &pll2_d6.common.hw,
+	[CLK_PLL2_D7]		= &pll2_d7.common.hw,
+	[CLK_PLL2_D8]		= &pll2_d8.common.hw,
+	[CLK_PLL3_D1]		= &pll3_d1.common.hw,
+	[CLK_PLL3_D2]		= &pll3_d2.common.hw,
+	[CLK_PLL3_D3]		= &pll3_d3.common.hw,
+	[CLK_PLL3_D4]		= &pll3_d4.common.hw,
+	[CLK_PLL3_D5]		= &pll3_d5.common.hw,
+	[CLK_PLL3_D6]		= &pll3_d6.common.hw,
+	[CLK_PLL3_D7]		= &pll3_d7.common.hw,
+	[CLK_PLL3_D8]		= &pll3_d8.common.hw,
+	[CLK_PLL3_80]		= &pll3_80.common.hw,
+	[CLK_PLL3_40]		= &pll3_40.common.hw,
+	[CLK_PLL3_20]		= &pll3_20.common.hw,
+};
+
+static const struct spacemit_ccu_data k1_ccu_pll_data = {
+	.hws	= k1_ccu_pll_hws,
+	.num	= ARRAY_SIZE(k1_ccu_pll_hws),
+};
+
+static struct clk_hw *k1_ccu_mpmu_hws[] = {
+	[CLK_PLL1_307P2]	= &pll1_d8_307p2.common.hw,
+	[CLK_PLL1_76P8]		= &pll1_d32_76p8.common.hw,
+	[CLK_PLL1_61P44]	= &pll1_d40_61p44.common.hw,
+	[CLK_PLL1_153P6]	= &pll1_d16_153p6.common.hw,
+	[CLK_PLL1_102P4]	= &pll1_d24_102p4.common.hw,
+	[CLK_PLL1_51P2]		= &pll1_d48_51p2.common.hw,
+	[CLK_PLL1_51P2_AP]	= &pll1_d48_51p2_ap.common.hw,
+	[CLK_PLL1_57P6]		= &pll1_m3d128_57p6.common.hw,
+	[CLK_PLL1_25P6]		= &pll1_d96_25p6.common.hw,
+	[CLK_PLL1_12P8]		= &pll1_d192_12p8.common.hw,
+	[CLK_PLL1_12P8_WDT]	= &pll1_d192_12p8_wdt.common.hw,
+	[CLK_PLL1_6P4]		= &pll1_d384_6p4.common.hw,
+	[CLK_PLL1_3P2]		= &pll1_d768_3p2.common.hw,
+	[CLK_PLL1_1P6]		= &pll1_d1536_1p6.common.hw,
+	[CLK_PLL1_0P8]		= &pll1_d3072_0p8.common.hw,
+	[CLK_PLL1_409P6]	= &pll1_d6_409p6.common.hw,
+	[CLK_PLL1_204P8]	= &pll1_d12_204p8.common.hw,
+	[CLK_PLL1_491]		= &pll1_d5_491p52.common.hw,
+	[CLK_PLL1_245P76]	= &pll1_d10_245p76.common.hw,
+	[CLK_PLL1_614]		= &pll1_d4_614p4.common.hw,
+	[CLK_PLL1_47P26]	= &pll1_d52_47p26.common.hw,
+	[CLK_PLL1_31P5]		= &pll1_d78_31p5.common.hw,
+	[CLK_PLL1_819]		= &pll1_d3_819p2.common.hw,
+	[CLK_PLL1_1228]		= &pll1_d2_1228p8.common.hw,
+	[CLK_SLOW_UART]		= &slow_uart.common.hw,
+	[CLK_SLOW_UART1]	= &slow_uart1_14p74.common.hw,
+	[CLK_SLOW_UART2]	= &slow_uart2_48.common.hw,
+	[CLK_WDT]		= &wdt_clk.common.hw,
+	[CLK_RIPC]		= &ripc_clk.common.hw,
+	[CLK_I2S_SYSCLK]	= &i2s_sysclk.common.hw,
+	[CLK_I2S_BCLK]		= &i2s_bclk.common.hw,
+	[CLK_APB]		= &apb_clk.common.hw,
+	[CLK_WDT_BUS]		= &wdt_bus_clk.common.hw,
+};
+
+static const struct spacemit_ccu_data k1_ccu_mpmu_data = {
+	.hws	= k1_ccu_mpmu_hws,
+	.num	= ARRAY_SIZE(k1_ccu_mpmu_hws),
+};
+
+static struct clk_hw *k1_ccu_apbc_hws[] = {
+	[CLK_UART0]		= &uart0_clk.common.hw,
+	[CLK_UART2]		= &uart2_clk.common.hw,
+	[CLK_UART3]		= &uart3_clk.common.hw,
+	[CLK_UART4]		= &uart4_clk.common.hw,
+	[CLK_UART5]		= &uart5_clk.common.hw,
+	[CLK_UART6]		= &uart6_clk.common.hw,
+	[CLK_UART7]		= &uart7_clk.common.hw,
+	[CLK_UART8]		= &uart8_clk.common.hw,
+	[CLK_UART9]		= &uart9_clk.common.hw,
+	[CLK_GPIO]		= &gpio_clk.common.hw,
+	[CLK_PWM0]		= &pwm0_clk.common.hw,
+	[CLK_PWM1]		= &pwm1_clk.common.hw,
+	[CLK_PWM2]		= &pwm2_clk.common.hw,
+	[CLK_PWM3]		= &pwm3_clk.common.hw,
+	[CLK_PWM4]		= &pwm4_clk.common.hw,
+	[CLK_PWM5]		= &pwm5_clk.common.hw,
+	[CLK_PWM6]		= &pwm6_clk.common.hw,
+	[CLK_PWM7]		= &pwm7_clk.common.hw,
+	[CLK_PWM8]		= &pwm8_clk.common.hw,
+	[CLK_PWM9]		= &pwm9_clk.common.hw,
+	[CLK_PWM10]		= &pwm10_clk.common.hw,
+	[CLK_PWM11]		= &pwm11_clk.common.hw,
+	[CLK_PWM12]		= &pwm12_clk.common.hw,
+	[CLK_PWM13]		= &pwm13_clk.common.hw,
+	[CLK_PWM14]		= &pwm14_clk.common.hw,
+	[CLK_PWM15]		= &pwm15_clk.common.hw,
+	[CLK_PWM16]		= &pwm16_clk.common.hw,
+	[CLK_PWM17]		= &pwm17_clk.common.hw,
+	[CLK_PWM18]		= &pwm18_clk.common.hw,
+	[CLK_PWM19]		= &pwm19_clk.common.hw,
+	[CLK_SSP3]		= &ssp3_clk.common.hw,
+	[CLK_RTC]		= &rtc_clk.common.hw,
+	[CLK_TWSI0]		= &twsi0_clk.common.hw,
+	[CLK_TWSI1]		= &twsi1_clk.common.hw,
+	[CLK_TWSI2]		= &twsi2_clk.common.hw,
+	[CLK_TWSI4]		= &twsi4_clk.common.hw,
+	[CLK_TWSI5]		= &twsi5_clk.common.hw,
+	[CLK_TWSI6]		= &twsi6_clk.common.hw,
+	[CLK_TWSI7]		= &twsi7_clk.common.hw,
+	[CLK_TIMERS1]		= &timers1_clk.common.hw,
+	[CLK_TIMERS2]		= &timers2_clk.common.hw,
+	[CLK_AIB]		= &aib_clk.common.hw,
+	[CLK_ONEWIRE]		= &onewire_clk.common.hw,
+	[CLK_SSPA0]		= &sspa0_clk.common.hw,
+	[CLK_SSPA1]		= &sspa1_clk.common.hw,
+	[CLK_DRO]		= &dro_clk.common.hw,
+	[CLK_IR]		= &ir_clk.common.hw,
+	[CLK_TSEN]		= &tsen_clk.common.hw,
+	[CLK_IPC_AP2AUD]	= &ipc_ap2aud_clk.common.hw,
+	[CLK_CAN0]		= &can0_clk.common.hw,
+	[CLK_CAN0_BUS]		= &can0_bus_clk.common.hw,
+	[CLK_UART0_BUS]		= &uart0_bus_clk.common.hw,
+	[CLK_UART2_BUS]		= &uart2_bus_clk.common.hw,
+	[CLK_UART3_BUS]		= &uart3_bus_clk.common.hw,
+	[CLK_UART4_BUS]		= &uart4_bus_clk.common.hw,
+	[CLK_UART5_BUS]		= &uart5_bus_clk.common.hw,
+	[CLK_UART6_BUS]		= &uart6_bus_clk.common.hw,
+	[CLK_UART7_BUS]		= &uart7_bus_clk.common.hw,
+	[CLK_UART8_BUS]		= &uart8_bus_clk.common.hw,
+	[CLK_UART9_BUS]		= &uart9_bus_clk.common.hw,
+	[CLK_GPIO_BUS]		= &gpio_bus_clk.common.hw,
+	[CLK_PWM0_BUS]		= &pwm0_bus_clk.common.hw,
+	[CLK_PWM1_BUS]		= &pwm1_bus_clk.common.hw,
+	[CLK_PWM2_BUS]		= &pwm2_bus_clk.common.hw,
+	[CLK_PWM3_BUS]		= &pwm3_bus_clk.common.hw,
+	[CLK_PWM4_BUS]		= &pwm4_bus_clk.common.hw,
+	[CLK_PWM5_BUS]		= &pwm5_bus_clk.common.hw,
+	[CLK_PWM6_BUS]		= &pwm6_bus_clk.common.hw,
+	[CLK_PWM7_BUS]		= &pwm7_bus_clk.common.hw,
+	[CLK_PWM8_BUS]		= &pwm8_bus_clk.common.hw,
+	[CLK_PWM9_BUS]		= &pwm9_bus_clk.common.hw,
+	[CLK_PWM10_BUS]		= &pwm10_bus_clk.common.hw,
+	[CLK_PWM11_BUS]		= &pwm11_bus_clk.common.hw,
+	[CLK_PWM12_BUS]		= &pwm12_bus_clk.common.hw,
+	[CLK_PWM13_BUS]		= &pwm13_bus_clk.common.hw,
+	[CLK_PWM14_BUS]		= &pwm14_bus_clk.common.hw,
+	[CLK_PWM15_BUS]		= &pwm15_bus_clk.common.hw,
+	[CLK_PWM16_BUS]		= &pwm16_bus_clk.common.hw,
+	[CLK_PWM17_BUS]		= &pwm17_bus_clk.common.hw,
+	[CLK_PWM18_BUS]		= &pwm18_bus_clk.common.hw,
+	[CLK_PWM19_BUS]		= &pwm19_bus_clk.common.hw,
+	[CLK_SSP3_BUS]		= &ssp3_bus_clk.common.hw,
+	[CLK_RTC_BUS]		= &rtc_bus_clk.common.hw,
+	[CLK_TWSI0_BUS]		= &twsi0_bus_clk.common.hw,
+	[CLK_TWSI1_BUS]		= &twsi1_bus_clk.common.hw,
+	[CLK_TWSI2_BUS]		= &twsi2_bus_clk.common.hw,
+	[CLK_TWSI4_BUS]		= &twsi4_bus_clk.common.hw,
+	[CLK_TWSI5_BUS]		= &twsi5_bus_clk.common.hw,
+	[CLK_TWSI6_BUS]		= &twsi6_bus_clk.common.hw,
+	[CLK_TWSI7_BUS]		= &twsi7_bus_clk.common.hw,
+	[CLK_TIMERS1_BUS]	= &timers1_bus_clk.common.hw,
+	[CLK_TIMERS2_BUS]	= &timers2_bus_clk.common.hw,
+	[CLK_AIB_BUS]		= &aib_bus_clk.common.hw,
+	[CLK_ONEWIRE_BUS]	= &onewire_bus_clk.common.hw,
+	[CLK_SSPA0_BUS]		= &sspa0_bus_clk.common.hw,
+	[CLK_SSPA1_BUS]		= &sspa1_bus_clk.common.hw,
+	[CLK_TSEN_BUS]		= &tsen_bus_clk.common.hw,
+	[CLK_IPC_AP2AUD_BUS]	= &ipc_ap2aud_bus_clk.common.hw,
+};
+
+static const struct spacemit_ccu_data k1_ccu_apbc_data = {
+	.hws	= k1_ccu_apbc_hws,
+	.num	= ARRAY_SIZE(k1_ccu_apbc_hws),
+};
+
+static struct clk_hw *k1_ccu_apmu_hws[] = {
+	[CLK_CCI550]		= &cci550_clk.common.hw,
+	[CLK_CPU_C0_HI]		= &cpu_c0_hi_clk.common.hw,
+	[CLK_CPU_C0_CORE]	= &cpu_c0_core_clk.common.hw,
+	[CLK_CPU_C0_ACE]	= &cpu_c0_ace_clk.common.hw,
+	[CLK_CPU_C0_TCM]	= &cpu_c0_tcm_clk.common.hw,
+	[CLK_CPU_C1_HI]		= &cpu_c1_hi_clk.common.hw,
+	[CLK_CPU_C1_CORE]	= &cpu_c1_core_clk.common.hw,
+	[CLK_CPU_C1_ACE]	= &cpu_c1_ace_clk.common.hw,
+	[CLK_CCIC_4X]		= &ccic_4x_clk.common.hw,
+	[CLK_CCIC1PHY]		= &ccic1phy_clk.common.hw,
+	[CLK_SDH_AXI]		= &sdh_axi_aclk.common.hw,
+	[CLK_SDH0]		= &sdh0_clk.common.hw,
+	[CLK_SDH1]		= &sdh1_clk.common.hw,
+	[CLK_SDH2]		= &sdh2_clk.common.hw,
+	[CLK_USB_P1]		= &usb_p1_aclk.common.hw,
+	[CLK_USB_AXI]		= &usb_axi_clk.common.hw,
+	[CLK_USB30]		= &usb30_clk.common.hw,
+	[CLK_QSPI]		= &qspi_clk.common.hw,
+	[CLK_QSPI_BUS]		= &qspi_bus_clk.common.hw,
+	[CLK_DMA]		= &dma_clk.common.hw,
+	[CLK_AES]		= &aes_clk.common.hw,
+	[CLK_VPU]		= &vpu_clk.common.hw,
+	[CLK_GPU]		= &gpu_clk.common.hw,
+	[CLK_EMMC]		= &emmc_clk.common.hw,
+	[CLK_EMMC_X]		= &emmc_x_clk.common.hw,
+	[CLK_AUDIO]		= &audio_clk.common.hw,
+	[CLK_HDMI]		= &hdmi_mclk.common.hw,
+	[CLK_PMUA_ACLK]		= &pmua_aclk.common.hw,
+	[CLK_PCIE0_MASTER]	= &pcie0_master_clk.common.hw,
+	[CLK_PCIE0_SLAVE]	= &pcie0_slave_clk.common.hw,
+	[CLK_PCIE0_DBI]		= &pcie0_dbi_clk.common.hw,
+	[CLK_PCIE1_MASTER]	= &pcie1_master_clk.common.hw,
+	[CLK_PCIE1_SLAVE]	= &pcie1_slave_clk.common.hw,
+	[CLK_PCIE1_DBI]		= &pcie1_dbi_clk.common.hw,
+	[CLK_PCIE2_MASTER]	= &pcie2_master_clk.common.hw,
+	[CLK_PCIE2_SLAVE]	= &pcie2_slave_clk.common.hw,
+	[CLK_PCIE2_DBI]		= &pcie2_dbi_clk.common.hw,
+	[CLK_EMAC0_BUS]		= &emac0_bus_clk.common.hw,
+	[CLK_EMAC0_PTP]		= &emac0_ptp_clk.common.hw,
+	[CLK_EMAC1_BUS]		= &emac1_bus_clk.common.hw,
+	[CLK_EMAC1_PTP]		= &emac1_ptp_clk.common.hw,
+	[CLK_JPG]		= &jpg_clk.common.hw,
+	[CLK_CCIC2PHY]		= &ccic2phy_clk.common.hw,
+	[CLK_CCIC3PHY]		= &ccic3phy_clk.common.hw,
+	[CLK_CSI]		= &csi_clk.common.hw,
+	[CLK_CAMM0]		= &camm0_clk.common.hw,
+	[CLK_CAMM1]		= &camm1_clk.common.hw,
+	[CLK_CAMM2]		= &camm2_clk.common.hw,
+	[CLK_ISP_CPP]		= &isp_cpp_clk.common.hw,
+	[CLK_ISP_BUS]		= &isp_bus_clk.common.hw,
+	[CLK_ISP]		= &isp_clk.common.hw,
+	[CLK_DPU_MCLK]		= &dpu_mclk.common.hw,
+	[CLK_DPU_ESC]		= &dpu_esc_clk.common.hw,
+	[CLK_DPU_BIT]		= &dpu_bit_clk.common.hw,
+	[CLK_DPU_PXCLK]		= &dpu_pxclk.common.hw,
+	[CLK_DPU_HCLK]		= &dpu_hclk.common.hw,
+	[CLK_DPU_SPI]		= &dpu_spi_clk.common.hw,
+	[CLK_DPU_SPI_HBUS]	= &dpu_spi_hbus_clk.common.hw,
+	[CLK_DPU_SPIBUS]	= &dpu_spi_bus_clk.common.hw,
+	[CLK_DPU_SPI_ACLK]	= &dpu_spi_aclk.common.hw,
+	[CLK_V2D]		= &v2d_clk.common.hw,
+	[CLK_EMMC_BUS]		= &emmc_bus_clk.common.hw,
+};
+
+static const struct spacemit_ccu_data k1_ccu_apmu_data = {
+	.hws	= k1_ccu_apmu_hws,
+	.num	= ARRAY_SIZE(k1_ccu_apmu_hws),
+};
+
+static int spacemit_ccu_register(struct device *dev,
+				 struct regmap *regmap,
+				 struct regmap *lock_regmap,
+				 const struct spacemit_ccu_data *data)
+{
+	struct clk_hw_onecell_data *clk_data;
+	int i, ret;
+
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, data->num),
+				GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	for (i = 0; i < data->num; i++) {
+		struct clk_hw *hw = data->hws[i];
+		struct ccu_common *common;
+		const char *name;
+
+		if (!hw) {
+			clk_data->hws[i] = ERR_PTR(-ENOENT);
+			continue;
+		}
+
+		name = hw->init->name;
+
+		common = hw_to_ccu_common(hw);
+		common->regmap		= regmap;
+		common->lock_regmap	= lock_regmap;
+
+		ret = devm_clk_hw_register(dev, hw);
+		if (ret) {
+			dev_err(dev, "Cannot register clock %d - %s\n",
+				i, name);
+			return ret;
+		}
+
+		clk_data->hws[i] = hw;
+	}
+
+	clk_data->num = data->num;
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
+	if (ret)
+		dev_err(dev, "failed to add clock hardware provider (%d)\n", ret);
+
+	return ret;
+}
+
+static int k1_ccu_probe(struct platform_device *pdev)
+{
+	struct regmap *base_regmap, *lock_regmap = NULL;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	base_regmap = device_node_to_regmap(dev->of_node);
+	if (IS_ERR(base_regmap))
+		return dev_err_probe(dev, PTR_ERR(base_regmap),
+				     "failed to get regmap\n");
+
+	/*
+	 * The lock status of PLLs locate in MPMU region, while PLLs themselves
+	 * are in APBS region. Reference to MPMU syscon is required to check PLL
+	 * status.
+	 */
+	if (of_device_is_compatible(dev->of_node, "spacemit,k1-pll")) {
+		struct device_node *mpmu = of_parse_phandle(dev->of_node,
+							    "spacemit,mpmu", 0);
+		if (!mpmu)
+			return dev_err_probe(dev, -ENODEV,
+					     "Cannot parse MPMU region\n");
+
+		lock_regmap = device_node_to_regmap(mpmu);
+		of_node_put(mpmu);
+
+		if (IS_ERR(lock_regmap))
+			return dev_err_probe(dev, PTR_ERR(lock_regmap),
+					     "failed to get lock regmap\n");
+	}
+
+	ret = spacemit_ccu_register(dev, base_regmap, lock_regmap,
+				    of_device_get_match_data(dev));
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register clocks\n");
+
+	return 0;
+}
+
+static const struct of_device_id of_k1_ccu_match[] = {
+	{
+		.compatible	= "spacemit,k1-pll",
+		.data		= &k1_ccu_pll_data,
+	},
+	{
+		.compatible	= "spacemit,k1-syscon-mpmu",
+		.data		= &k1_ccu_mpmu_data,
+	},
+	{
+		.compatible	= "spacemit,k1-syscon-apbc",
+		.data		= &k1_ccu_apbc_data,
+	},
+	{
+		.compatible	= "spacemit,k1-syscon-apmu",
+		.data		= &k1_ccu_apmu_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, of_k1_ccu_match);
+
+static struct platform_driver k1_ccu_driver = {
+	.driver = {
+		.name		= "spacemit,k1-ccu",
+		.of_match_table = of_k1_ccu_match,
+	},
+	.probe	= k1_ccu_probe,
+};
+module_platform_driver(k1_ccu_driver);
+
+MODULE_DESCRIPTION("SpacemiT K1 CCU driver");
+MODULE_AUTHOR("Haylen Chu <heylenay@4d2.org>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/spacemit/ccu_common.h b/drivers/clk/spacemit/ccu_common.h
new file mode 100644
index 000000000000..da72f3836e0b
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_common.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ */
+
+#ifndef _CCU_COMMON_H_
+#define _CCU_COMMON_H_
+
+#include <linux/regmap.h>
+
+struct ccu_common {
+	struct regmap *regmap;
+	struct regmap *lock_regmap;
+
+	union {
+		/* For DDN and MIX */
+		struct {
+			u32 reg_ctrl;
+			u32 reg_fc;
+			u32 mask_fc;
+		};
+
+		/* For PLL */
+		struct {
+			u32 reg_swcr1;
+			u32 reg_swcr3;
+		};
+	};
+
+	struct clk_hw hw;
+};
+
+static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
+{
+	return container_of(hw, struct ccu_common, hw);
+}
+
+#define ccu_read(c, reg)						\
+	({								\
+		u32 tmp;						\
+		regmap_read((c)->regmap, (c)->reg_##reg, &tmp);		\
+		tmp;							\
+	 })
+#define ccu_update(c, reg, mask, val) \
+	regmap_update_bits((c)->regmap, (c)->reg_##reg, mask, val)
+
+#endif /* _CCU_COMMON_H_ */
diff --git a/drivers/clk/spacemit/ccu_ddn.c b/drivers/clk/spacemit/ccu_ddn.c
new file mode 100644
index 000000000000..be311b045698
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_ddn.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ *
+ * DDN stands for "Divider Denominator Numerator", it's M/N clock with a
+ * constant x2 factor. This clock hardware follows the equation below,
+ *
+ *	      numerator       Fin
+ *	2 * ------------- = -------
+ *	     denominator      Fout
+ *
+ * Thus, Fout could be calculated with,
+ *
+ *		Fin	denominator
+ *	Fout = ----- * -------------
+ *		 2	 numerator
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/rational.h>
+
+#include "ccu_ddn.h"
+
+static unsigned long ccu_ddn_calc_rate(unsigned long prate,
+				       unsigned long num, unsigned long den)
+{
+	return prate * den / 2 / num;
+}
+
+static unsigned long ccu_ddn_calc_best_rate(struct ccu_ddn *ddn,
+					    unsigned long rate, unsigned long prate,
+					    unsigned long *num, unsigned long *den)
+{
+	rational_best_approximation(rate, prate / 2,
+				    ddn->den_mask >> ddn->den_shift,
+				    ddn->num_mask >> ddn->num_shift,
+				    den, num);
+	return ccu_ddn_calc_rate(prate, *num, *den);
+}
+
+static long ccu_ddn_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	unsigned long num, den;
+
+	return ccu_ddn_calc_best_rate(ddn, rate, *prate, &num, &den);
+}
+
+static unsigned long ccu_ddn_recalc_rate(struct clk_hw *hw, unsigned long prate)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	unsigned int val, num, den;
+
+	val = ccu_read(&ddn->common, ctrl);
+
+	num = (val & ddn->num_mask) >> ddn->num_shift;
+	den = (val & ddn->den_mask) >> ddn->den_shift;
+
+	return ccu_ddn_calc_rate(prate, num, den);
+}
+
+static int ccu_ddn_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long prate)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	unsigned long num, den;
+
+	ccu_ddn_calc_best_rate(ddn, rate, prate, &num, &den);
+
+	ccu_update(&ddn->common, ctrl,
+		   ddn->num_mask | ddn->den_mask,
+		   (num << ddn->num_shift) | (den << ddn->den_shift));
+
+	return 0;
+}
+
+const struct clk_ops spacemit_ccu_ddn_ops = {
+	.recalc_rate	= ccu_ddn_recalc_rate,
+	.round_rate	= ccu_ddn_round_rate,
+	.set_rate	= ccu_ddn_set_rate,
+};
diff --git a/drivers/clk/spacemit/ccu_ddn.h b/drivers/clk/spacemit/ccu_ddn.h
new file mode 100644
index 000000000000..65fca648b7fc
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_ddn.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ */
+
+#ifndef _CCU_DDN_H_
+#define _CCU_DDN_H_
+
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+
+struct ccu_ddn {
+	struct ccu_common common;
+	unsigned int num_mask;
+	unsigned int num_shift;
+	unsigned int den_mask;
+	unsigned int den_shift;
+};
+
+#define CCU_DDN_INIT(_name, _parent, _flags) \
+	CLK_HW_INIT_HW(#_name, &_parent.common.hw, &spacemit_ccu_ddn_ops, _flags)
+
+#define CCU_DDN_DEFINE(_name, _parent, _reg_ctrl, _num_mask, _den_mask, _flags)	\
+static struct ccu_ddn _name = {							\
+	.common = {								\
+		.reg_ctrl	= _reg_ctrl,					\
+		.hw.init	= CCU_DDN_INIT(_name, _parent, _flags),		\
+	},									\
+	.num_mask	= _num_mask,						\
+	.num_shift	= __ffs(_num_mask),					\
+	.den_mask	= _den_mask,						\
+	.den_shift	= __ffs(_den_mask),					\
+}
+
+static inline struct ccu_ddn *hw_to_ccu_ddn(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_ddn, common);
+}
+
+extern const struct clk_ops spacemit_ccu_ddn_ops;
+
+#endif
diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
new file mode 100644
index 000000000000..9b852aa61f78
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_mix.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ *
+ * MIX clock type is the combination of mux, factor or divider, and gate
+ */
+
+#include <linux/clk-provider.h>
+
+#include "ccu_mix.h"
+
+#define MIX_FC_TIMEOUT_US	10000
+#define MIX_FC_DELAY_US		5
+
+static void ccu_gate_disable(struct clk_hw *hw)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+
+	ccu_update(&mix->common, ctrl, mix->gate.mask, 0);
+}
+
+static int ccu_gate_enable(struct clk_hw *hw)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_gate_config *gate = &mix->gate;
+
+	ccu_update(&mix->common, ctrl, gate->mask, gate->mask);
+
+	return 0;
+}
+
+static int ccu_gate_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_gate_config *gate = &mix->gate;
+
+	return (ccu_read(&mix->common, ctrl) & gate->mask) == gate->mask;
+}
+
+static unsigned long ccu_factor_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+
+	return parent_rate * mix->factor.mul / mix->factor.div;
+}
+
+static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_div_config *div = &mix->div;
+	unsigned long val;
+
+	val = ccu_read(&mix->common, ctrl) >> div->shift;
+	val &= (1 << div->width) - 1;
+
+	return divider_recalc_rate(hw, parent_rate, val, NULL, 0, div->width);
+}
+
+/*
+ * Some clocks require a "FC" (frequency change) bit to be set after changing
+ * their rates or reparenting. This bit will be automatically cleared by
+ * hardware in MIX_FC_TIMEOUT_US, which indicates the operation is completed.
+ */
+static int ccu_mix_trigger_fc(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+	unsigned int val;
+
+	if (common->reg_fc)
+		return 0;
+
+	ccu_update(common, fc, common->mask_fc, common->mask_fc);
+
+	return regmap_read_poll_timeout_atomic(common->regmap, common->reg_fc,
+					       val, !(val & common->mask_fc),
+					       MIX_FC_DELAY_US,
+					       MIX_FC_TIMEOUT_US);
+}
+
+static long ccu_factor_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *prate)
+{
+	return ccu_factor_recalc_rate(hw, *prate);
+}
+
+static int ccu_factor_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	return 0;
+}
+
+static unsigned long
+ccu_mix_calc_best_rate(struct clk_hw *hw, unsigned long rate,
+		       struct clk_hw **best_parent,
+		       unsigned long *best_parent_rate,
+		       u32 *div_val)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	unsigned int parent_num = clk_hw_get_num_parents(hw);
+	struct ccu_div_config *div = &mix->div;
+	u32 div_max = 1 << div->width;
+	unsigned long best_rate = 0;
+
+	for (int i = 0; i < parent_num; i++) {
+		struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
+		unsigned long parent_rate;
+
+		if (!parent)
+			continue;
+
+		parent_rate = clk_hw_get_rate(parent);
+
+		for (int j = 1; j <= div_max; j++) {
+			unsigned long tmp = DIV_ROUND_CLOSEST_ULL(parent_rate, j);
+
+			if (abs(tmp - rate) < abs(best_rate - rate)) {
+				best_rate = tmp;
+
+				if (div_val)
+					*div_val = j - 1;
+
+				if (best_parent) {
+					*best_parent      = parent;
+					*best_parent_rate = parent_rate;
+				}
+			}
+		}
+	}
+
+	return best_rate;
+}
+
+static int ccu_mix_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
+{
+	req->rate = ccu_mix_calc_best_rate(hw, req->rate,
+					   &req->best_parent_hw,
+					   &req->best_parent_rate,
+					   NULL);
+	return 0;
+}
+
+static int ccu_mix_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_div_config *div = &mix->div;
+	u32 current_div, target_div, mask;
+
+	ccu_mix_calc_best_rate(hw, rate, NULL, NULL, &target_div);
+
+	current_div = ccu_read(common, ctrl) >> div->shift;
+	current_div &= (1 << div->width) - 1;
+
+	if (current_div == target_div)
+		return 0;
+
+	mask = GENMASK(div->width + div->shift - 1, div->shift);
+
+	ccu_update(common, ctrl, mask, target_div << div->shift);
+
+	return ccu_mix_trigger_fc(hw);
+}
+
+static u8 ccu_mux_get_parent(struct clk_hw *hw)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_mux_config *mux = &mix->mux;
+	u8 parent;
+
+	parent = ccu_read(&mix->common, ctrl) >> mux->shift;
+	parent &= (1 << mux->width) - 1;
+
+	return parent;
+}
+
+static int ccu_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_mux_config *mux = &mix->mux;
+	u32 mask;
+
+	mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
+
+	ccu_update(&mix->common, ctrl, mask, index << mux->shift);
+
+	return ccu_mix_trigger_fc(hw);
+}
+
+const struct clk_ops spacemit_ccu_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.is_enabled	= ccu_gate_is_enabled,
+};
+
+const struct clk_ops spacemit_ccu_factor_ops = {
+	.round_rate	= ccu_factor_round_rate,
+	.recalc_rate	= ccu_factor_recalc_rate,
+	.set_rate	= ccu_factor_set_rate,
+};
+
+const struct clk_ops spacemit_ccu_mux_ops = {
+	.determine_rate = ccu_mix_determine_rate,
+	.get_parent	= ccu_mux_get_parent,
+	.set_parent	= ccu_mux_set_parent,
+};
+
+const struct clk_ops spacemit_ccu_div_ops = {
+	.determine_rate = ccu_mix_determine_rate,
+	.recalc_rate	= ccu_div_recalc_rate,
+	.set_rate	= ccu_mix_set_rate,
+};
+
+const struct clk_ops spacemit_ccu_factor_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.is_enabled	= ccu_gate_is_enabled,
+
+	.round_rate	= ccu_factor_round_rate,
+	.recalc_rate	= ccu_factor_recalc_rate,
+	.set_rate	= ccu_factor_set_rate,
+};
+
+const struct clk_ops spacemit_ccu_mux_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.is_enabled	= ccu_gate_is_enabled,
+
+	.determine_rate = ccu_mix_determine_rate,
+	.get_parent	= ccu_mux_get_parent,
+	.set_parent	= ccu_mux_set_parent,
+};
+
+const struct clk_ops spacemit_ccu_div_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.is_enabled	= ccu_gate_is_enabled,
+
+	.determine_rate = ccu_mix_determine_rate,
+	.recalc_rate	= ccu_div_recalc_rate,
+	.set_rate	= ccu_mix_set_rate,
+};
+
+const struct clk_ops spacemit_ccu_mux_div_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.is_enabled	= ccu_gate_is_enabled,
+
+	.get_parent	= ccu_mux_get_parent,
+	.set_parent	= ccu_mux_set_parent,
+
+	.determine_rate = ccu_mix_determine_rate,
+	.recalc_rate	= ccu_div_recalc_rate,
+	.set_rate	= ccu_mix_set_rate,
+};
+
+const struct clk_ops spacemit_ccu_mux_div_ops = {
+	.get_parent	= ccu_mux_get_parent,
+	.set_parent	= ccu_mux_set_parent,
+
+	.determine_rate = ccu_mix_determine_rate,
+	.recalc_rate	= ccu_div_recalc_rate,
+	.set_rate	= ccu_mix_set_rate,
+};
diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
new file mode 100644
index 000000000000..51d19f5d6aac
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_mix.h
@@ -0,0 +1,218 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ */
+
+#ifndef _CCU_MIX_H_
+#define _CCU_MIX_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+
+/**
+ * struct ccu_gate_config - Gate configuration
+ *
+ * @mask:	Mask to enable the gate. Some clocks may have more than one bit
+ *		set in this field.
+ */
+struct ccu_gate_config {
+	u32 mask;
+};
+
+struct ccu_factor_config {
+	u32 div;
+	u32 mul;
+};
+
+struct ccu_mux_config {
+	u8 shift;
+	u8 width;
+};
+
+struct ccu_div_config {
+	u8 shift;
+	u8 width;
+};
+
+struct ccu_mix {
+	struct ccu_factor_config factor;
+	struct ccu_gate_config gate;
+	struct ccu_div_config div;
+	struct ccu_mux_config mux;
+	struct ccu_common common;
+};
+
+#define CCU_GATE_INIT(_mask)		{ .mask = _mask }
+#define CCU_FACTOR_INIT(_div, _mul)	{ .div = _div, .mul = _mul }
+#define CCU_MUX_INIT(_shift, _width)	{ .shift = _shift, .width = _width }
+#define CCU_DIV_INIT(_shift, _width)	{ .shift = _shift, .width = _width }
+
+#define CCU_PARENT_HW(_parent)		{ .hw = &_parent.common.hw }
+#define CCU_PARENT_NAME(_name)		{ .fw_name = #_name }
+
+#define CCU_MIX_INITHW(_name, _parent, _ops, _flags)			\
+	.hw.init = &(struct clk_init_data) {				\
+		.flags		= _flags,				\
+		.name		= #_name,				\
+		.parent_data	= (const struct clk_parent_data[])	\
+					{ _parent },			\
+		.num_parents	= 1,					\
+		.ops		= &_ops,				\
+	}
+
+#define CCU_MIX_INITHW_PARENTS(_name, _parents, _ops, _flags)		\
+	.hw.init = CLK_HW_INIT_PARENTS_DATA(#_name, _parents, &_ops, _flags)
+
+#define CCU_GATE_DEFINE(_name, _parent, _reg_ctrl, _mask_gate, _flags)		\
+static struct ccu_mix _name = {							\
+	.gate	= CCU_GATE_INIT(_mask_gate),					\
+	.common	= {								\
+		.reg_ctrl	= _reg_ctrl,					\
+		CCU_MIX_INITHW(_name, _parent, spacemit_ccu_gate_ops, _flags),	\
+	}									\
+}
+
+#define CCU_FACTOR_DEFINE(_name, _parent, _div, _mul)				\
+static struct ccu_mix _name = {							\
+	.factor	= CCU_FACTOR_INIT(_div, _mul),					\
+	.common = {								\
+		CCU_MIX_INITHW(_name, _parent, spacemit_ccu_factor_ops, 0),	\
+	}									\
+}
+
+#define CCU_MUX_DEFINE(_name, _parents, _reg_ctrl, _shift, _width, _flags)	\
+static struct ccu_mix _name = {							\
+	.mux	= CCU_MUX_INIT(_shift, _width),					\
+	.common = {								\
+		.reg_ctrl	= _reg_ctrl,					\
+		CCU_MIX_INITHW_PARENTS(_name, _parents, spacemit_ccu_mux_ops,	\
+				       _flags),					\
+	}									\
+}
+
+#define CCU_DIV_DEFINE(_name, _parent, _reg_ctrl, _shift, _width, _flags)	\
+static struct ccu_mix _name = {							\
+	.div	= CCU_DIV_INIT(_shift, _width),					\
+	.common = {								\
+		.reg_ctrl	= _reg_ctrl,					\
+		CCU_MIX_INITHW(_name, _parent, spacemit_ccu_div_ops, _flags)	\
+	}									\
+}
+
+#define CCU_FACTOR_GATE_DEFINE(_name, _parent, _reg_ctrl, _mask_gate, _div,	\
+			       _mul)						\
+static struct ccu_mix _name = {							\
+	.gate	= CCU_GATE_INIT(_mask_gate),					\
+	.factor	= CCU_FACTOR_INIT(_div, _mul),					\
+	.common = {								\
+		.reg_ctrl	= _reg_ctrl,					\
+		CCU_MIX_INITHW(_name, _parent, spacemit_ccu_factor_gate_ops, 0)	\
+	}									\
+}
+
+#define CCU_MUX_GATE_DEFINE(_name, _parents, _reg_ctrl, _shift, _width,		\
+			    _mask_gate, _flags)					\
+static struct ccu_mix _name = {							\
+	.gate	= CCU_GATE_INIT(_mask_gate),					\
+	.mux	= CCU_MUX_INIT(_shift, _width),					\
+	.common = {								\
+		.reg_ctrl	= _reg_ctrl,					\
+		CCU_MIX_INITHW_PARENTS(_name, _parents,				\
+				       spacemit_ccu_mux_gate_ops, _flags),	\
+	}									\
+}
+
+#define CCU_DIV_GATE_DEFINE(_name, _parent, _reg_ctrl, _shift, _width,		\
+			    _mask_gate,	_flags)					\
+static struct ccu_mix _name = {							\
+	.gate	= CCU_GATE_INIT(_mask_gate),					\
+	.div	= CCU_DIV_INIT(_shift, _width),					\
+	.common = {								\
+		.reg_ctrl	= _reg_ctrl,					\
+		CCU_MIX_INITHW(_name, _parent, spacemit_ccu_div_gate_ops,	\
+			       _flags),						\
+	}									\
+}
+
+#define CCU_MUX_DIV_GATE_DEFINE(_name, _parents, _reg_ctrl, _mshift, _mwidth,	\
+				 _muxshift, _muxwidth, _mask_gate, _flags)	\
+static struct ccu_mix _name = {							\
+	.gate	= CCU_GATE_INIT(_mask_gate),					\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth),				\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),				\
+	.common	= {								\
+		.reg_ctrl	= _reg_ctrl,					\
+		CCU_MIX_INITHW_PARENTS(_name, _parents,				\
+				       spacemit_ccu_mux_div_gate_ops, _flags),	\
+	},									\
+}
+
+#define CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(_name, _parents, _reg_ctrl, _reg_fc,	\
+					 _mshift, _mwidth, _mask_fc, _muxshift,	\
+					 _muxwidth, _mask_gate, _flags)		\
+static struct ccu_mix _name = {							\
+	.gate	= CCU_GATE_INIT(_mask_gate),					\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth),				\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),				\
+	.common = {								\
+		.reg_ctrl	= _reg_ctrl,					\
+		.reg_fc		= _reg_fc,					\
+		.mask_fc	= _mask_fc,					\
+		CCU_MIX_INITHW_PARENTS(_name, _parents,				\
+				       spacemit_ccu_mux_div_gate_ops, _flags),	\
+	},									\
+}
+
+#define CCU_MUX_DIV_GATE_FC_DEFINE(_name, _parents, _reg_ctrl, _mshift, _mwidth,\
+				   _mask_fc, _muxshift, _muxwidth, _mask_gate,	\
+				   _flags)					\
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(_name, _parents, _reg_ctrl, _reg_ctrl, _mshift,\
+				 _mwidth, _mask_fc, _muxshift, _muxwidth,	\
+				 _mask_gate, _flags)
+
+#define CCU_MUX_DIV_FC_DEFINE(_name, _parents, _reg_ctrl, _mshift, _mwidth,	\
+			      _mask_fc, _muxshift, _muxwidth, _flags)		\
+static struct ccu_mix _name = {							\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth),				\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),				\
+	.common = {								\
+		.reg_ctrl	= _reg_ctrl,					\
+		.reg_fc		= _reg_ctrl,					\
+		.mask_fc	= _mask_fc,					\
+		CCU_MIX_INITHW_PARENTS(_name, _parents,				\
+				       spacemit_ccu_mux_div_ops, _flags),	\
+	},									\
+}
+
+#define CCU_MUX_FC_DEFINE(_name, _parents, _reg_ctrl, _mask_fc,	_muxshift,	\
+			  _muxwidth, _flags)					\
+static struct ccu_mix _name = {							\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),				\
+	.common = {								\
+		.reg_ctrl	= _reg_ctrl,					\
+		.reg_fc		= _reg_ctrl,					\
+		.mask_fc	= _mask_fc,					\
+		CCU_MIX_INITHW_PARENTS(_name, _parents, spacemit_ccu_mux_ops,	\
+				       _flags)					\
+	},									\
+}
+
+static inline struct ccu_mix *hw_to_ccu_mix(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_mix, common);
+}
+
+extern const struct clk_ops spacemit_ccu_gate_ops;
+extern const struct clk_ops spacemit_ccu_factor_ops;
+extern const struct clk_ops spacemit_ccu_mux_ops;
+extern const struct clk_ops spacemit_ccu_div_ops;
+extern const struct clk_ops spacemit_ccu_factor_gate_ops;
+extern const struct clk_ops spacemit_ccu_div_gate_ops;
+extern const struct clk_ops spacemit_ccu_mux_gate_ops;
+extern const struct clk_ops spacemit_ccu_mux_div_ops;
+extern const struct clk_ops spacemit_ccu_mux_div_gate_ops;
+#endif /* _CCU_DIV_H_ */
diff --git a/drivers/clk/spacemit/ccu_pll.c b/drivers/clk/spacemit/ccu_pll.c
new file mode 100644
index 000000000000..4427dcfbbb97
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_pll.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/math.h>
+#include <linux/regmap.h>
+
+#include "ccu_common.h"
+#include "ccu_pll.h"
+
+#define PLL_TIMEOUT_US		3000
+#define PLL_DELAY_US		5
+
+#define PLL_SWCR3_EN		((u32)BIT(31))
+#define PLL_SWCR3_MASK		GENMASK(30, 0)
+
+static const struct ccu_pll_rate_tbl *ccu_pll_lookup_best_rate(struct ccu_pll *pll,
+							       unsigned long rate)
+{
+	struct ccu_pll_config *config = &pll->config;
+	const struct ccu_pll_rate_tbl *best_entry;
+	unsigned long best_delta = ULONG_MAX;
+	int i;
+
+	for (i = 0; i < config->tbl_num; i++) {
+		const struct ccu_pll_rate_tbl *entry = &config->rate_tbl[i];
+		unsigned long delta = abs_diff(entry->rate, rate);
+
+		if (delta < best_delta) {
+			best_delta = delta;
+			best_entry = entry;
+		}
+	}
+
+	return best_entry;
+}
+
+static const struct ccu_pll_rate_tbl *ccu_pll_lookup_matched_entry(struct ccu_pll *pll)
+{
+	struct ccu_pll_config *config = &pll->config;
+	u32 swcr1, swcr3;
+	int i;
+
+	swcr1 = ccu_read(&pll->common, swcr1);
+	swcr3 = ccu_read(&pll->common, swcr3);
+	swcr3 &= PLL_SWCR3_MASK;
+
+	for (i = 0; i < config->tbl_num; i++) {
+		const struct ccu_pll_rate_tbl *entry = &config->rate_tbl[i];
+
+		if (swcr1 == entry->swcr1 && swcr3 == entry->swcr3)
+			return entry;
+	}
+
+	return NULL;
+}
+
+static void ccu_pll_update_param(struct ccu_pll *pll, const struct ccu_pll_rate_tbl *entry)
+{
+	struct ccu_common *common = &pll->common;
+
+	regmap_write(common->regmap, common->reg_swcr1, entry->swcr1);
+	ccu_update(common, swcr3, PLL_SWCR3_MASK, entry->swcr3);
+}
+
+static int ccu_pll_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return ccu_read(common, swcr3) & PLL_SWCR3_EN;
+}
+
+static int ccu_pll_enable(struct clk_hw *hw)
+{
+	struct ccu_pll *pll = hw_to_ccu_pll(hw);
+	struct ccu_common *common = &pll->common;
+	unsigned int tmp;
+
+	ccu_update(common, swcr3, PLL_SWCR3_EN, PLL_SWCR3_EN);
+
+	/* check lock status */
+	return regmap_read_poll_timeout_atomic(common->lock_regmap,
+					       pll->config.reg_lock,
+					       tmp,
+					       tmp & pll->config.mask_lock,
+					       PLL_DELAY_US, PLL_TIMEOUT_US);
+}
+
+static void ccu_pll_disable(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	ccu_update(common, swcr3, PLL_SWCR3_EN, 0);
+}
+
+/*
+ * PLLs must be gated before changing rate, which is ensured by
+ * flag CLK_SET_RATE_GATE.
+ */
+static int ccu_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct ccu_pll *pll = hw_to_ccu_pll(hw);
+	const struct ccu_pll_rate_tbl *entry;
+
+	entry = ccu_pll_lookup_best_rate(pll, rate);
+	ccu_pll_update_param(pll, entry);
+
+	return 0;
+}
+
+static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct ccu_pll *pll = hw_to_ccu_pll(hw);
+	const struct ccu_pll_rate_tbl *entry;
+
+	entry = ccu_pll_lookup_matched_entry(pll);
+
+	WARN_ON_ONCE(!entry);
+
+	return entry ? entry->rate : -EINVAL;
+}
+
+static long ccu_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	struct ccu_pll *pll = hw_to_ccu_pll(hw);
+
+	return ccu_pll_lookup_best_rate(pll, rate)->rate;
+}
+
+static int ccu_pll_init(struct clk_hw *hw)
+{
+	struct ccu_pll *pll = hw_to_ccu_pll(hw);
+
+	if (ccu_pll_lookup_matched_entry(pll))
+		return 0;
+
+	ccu_pll_disable(hw);
+	ccu_pll_update_param(pll, &pll->config.rate_tbl[0]);
+
+	return 0;
+}
+
+const struct clk_ops spacemit_ccu_pll_ops = {
+	.init		= ccu_pll_init,
+	.enable		= ccu_pll_enable,
+	.disable	= ccu_pll_disable,
+	.set_rate	= ccu_pll_set_rate,
+	.recalc_rate	= ccu_pll_recalc_rate,
+	.round_rate	= ccu_pll_round_rate,
+	.is_enabled	= ccu_pll_is_enabled,
+};
diff --git a/drivers/clk/spacemit/ccu_pll.h b/drivers/clk/spacemit/ccu_pll.h
new file mode 100644
index 000000000000..0592f4c3068c
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_pll.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ */
+
+#ifndef _CCU_PLL_H_
+#define _CCU_PLL_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+
+/**
+ * struct ccu_pll_rate_tbl - Structure mapping between PLL rate and register
+ * configuration.
+ *
+ * @rate:	PLL rate
+ * @swcr1:	Register value of PLLX_SW1_CTRL (PLLx_SWCR1).
+ * @swcr3:	Register value of the PLLx_SW3_CTRL's lowest 31 bits of
+ *		PLLx_SW3_CTRL (PLLx_SWCR3). This highest bit is for enabling
+ *		the PLL and not contained in this field.
+ */
+struct ccu_pll_rate_tbl {
+	unsigned long rate;
+	u32 swcr1;
+	u32 swcr3;
+};
+
+struct ccu_pll_config {
+	const struct ccu_pll_rate_tbl *rate_tbl;
+	u32 tbl_num;
+	u32 reg_lock;
+	u32 mask_lock;
+};
+
+#define CCU_PLL_RATE(_rate, _swcr1, _swcr3) \
+	{									\
+		.rate	= _rate,							\
+		.swcr1	= _swcr1,						\
+		.swcr3	= _swcr3,						\
+	}
+
+struct ccu_pll {
+	struct ccu_common	common;
+	struct ccu_pll_config	config;
+};
+
+#define CCU_PLL_CONFIG(_table, _reg_lock, _mask_lock) \
+	{									\
+		.rate_tbl	= _table,					\
+		.tbl_num	= ARRAY_SIZE(_table),				\
+		.reg_lock	= (_reg_lock),					\
+		.mask_lock	= (_mask_lock),					\
+	}
+
+#define CCU_PLL_HWINIT(_name, _flags)						\
+	(&(struct clk_init_data) {						\
+		.name		= #_name,					\
+		.ops		= &spacemit_ccu_pll_ops,			\
+		.parent_data	= &(struct clk_parent_data) { .index = 0 },	\
+		.num_parents	= 1,						\
+		.flags		= _flags,					\
+	})
+
+#define CCU_PLL_DEFINE(_name, _table, _reg_swcr1, _reg_swcr3, _reg_lock,	\
+		       _mask_lock, _flags)					\
+static struct ccu_pll _name = {							\
+	.config	= CCU_PLL_CONFIG(_table, _reg_lock, _mask_lock),		\
+	.common = {								\
+		.reg_swcr1	= _reg_swcr1,					\
+		.reg_swcr3	= _reg_swcr3,					\
+		.hw.init	= CCU_PLL_HWINIT(_name, _flags)			\
+	}									\
+}
+
+static inline struct ccu_pll *hw_to_ccu_pll(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_pll, common);
+}
+
+extern const struct clk_ops spacemit_ccu_pll_ops;
+
+#endif
-- 
2.49.0


