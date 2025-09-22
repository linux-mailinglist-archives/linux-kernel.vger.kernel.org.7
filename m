Return-Path: <linux-kernel+bounces-827457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50039B91D04
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1987A294D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F3F2D7386;
	Mon, 22 Sep 2025 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="G9hKiqHZ"
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02332BE49;
	Mon, 22 Sep 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552921; cv=pass; b=sYL6CmyR/VeuDCby7vcKelknZIaXhCwfWrJV7WPrGsdJMjWDlOHbbNtgmN1o27mU33u3HR5n3Hqrw6Rhcw1gKuh6lXOi6TiKbPaZmB8O3928WwAylCixP8XX2I7Gegu77Pn/hQOfpQIhPcEfFSj53dkdiFb7pxN/7FOkTtZPosU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552921; c=relaxed/simple;
	bh=WFluuIf1SDJRVTTtlOH4QZu9CbhyX9v+Jdb36gXJQRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SaGThnp7xpi/LX0WwidkNJHZpAsH2i5TBM3XBIkJanDL2z7fuFqxpkegf14i55GSdlyFsP+tltvgDGN6hXbYRKMi7eXG6uJpE2dbQZ7cdKBILA2Mu887kLorNVy3+eaN9OESr9D4RjZKMZ0yuAHK/cFOhvuPllG5JJUHjM4kDOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=G9hKiqHZ; arc=pass smtp.client-ip=136.143.188.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1758552896; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OcpokqqCxOIiaDV13z0t/lf/HWuLUPBIdbDS2p4rk8xSXNo8blTp9UujF2FtzqdPqv3D1Dk6n23IYLBxEy+V5t896Nh6EP0VD2EQaiVm9rzoAfL9w+SMxIXDVpwXgAMGzOdBU03CFUh6O+rBP1DS6F7Uan3RGQ+RNRC0xZGN6NI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758552896; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mLp3ZMo/giWVFh9OCiJLFBIPuGvtpgKq2hcTvkWk2Jo=; 
	b=MK/Kk+r6lw8iqgyNZK2F6neVzo8tr/HBEgpgAIxZdY8D4YFE+yggm+xD4Xj69o/E5dyJPI1CZ+wzIg71YBSOROL4NW0G7vrE2nr4tG3eGhUVMdQHIpYp4r9POjvl4WxcRkNd9ThEmy2PDK2GUx1BIvUz7RDVHVrDEqUQgzr/HPM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758552896;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=mLp3ZMo/giWVFh9OCiJLFBIPuGvtpgKq2hcTvkWk2Jo=;
	b=G9hKiqHZw8NlMYPQEGRnTE3fyVGb+uMWvJCn5KjH5p7sz2dZ9KpmaLJP7VTVKNT6
	G1+KKYeHMA0HTMhQmVUfaJWYhupcj7AFXQvFFpe5ADzNsxnAc1lsGKUkzMTXiHJkCec
	wmYgJhxh8JnCfNaGMhGCvSJoh3gJ+EbuW37uAEJU=
Received: by mx.zohomail.com with SMTPS id 1758552894861235.5444135181881;
	Mon, 22 Sep 2025 07:54:54 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 22 Sep 2025 22:51:49 +0800
Subject: [PATCH 3/5] clk: anlogic: add cru support for Anlogic DR1V90 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-dr1v90-cru-v1-3-e393d758de4e@pigmoral.tech>
References: <20250922-dr1v90-cru-v1-0-e393d758de4e@pigmoral.tech>
In-Reply-To: <20250922-dr1v90-cru-v1-0-e393d758de4e@pigmoral.tech>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 "fushan.zeng" <fushan.zeng@anlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758552834; l=22107;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=WFluuIf1SDJRVTTtlOH4QZu9CbhyX9v+Jdb36gXJQRw=;
 b=fRGZoLjVvWriqP/GdxcFgs1nwVG7PqhtCL7cFE6da7MbCsjNGM9PkUIMp7wOpU3U40T+eElZh
 541TMicmNlWC9h4DKAXRJDP9B9UTEEiArqE5tGIWn2Qgj3G3pQC7uua
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

The Clock and Reset Unit (CRU) in the Anlogic DR1V90 SoC provides
management for the clock and reset.

The clock driver includes support for:
- Generic clocks: fixed-factor, divider, mux and gate.
- PLL: "nm" type (parent * n / m) and "c" type (parent / c). These PLLs
  are set up by the FSBL and mared as "don't touch" in the datasheet, so
  only the recal_rate() op is provided.
- Divider with gate: support both division and gating (by setting value
  to 0); some of them require a minimum divider value to avoid timing
  issues.

This also prepares the structure for the reset controller support,
registering an auxiliary device for resets.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/Kconfig              |   1 +
 drivers/clk/Makefile             |   1 +
 drivers/clk/anlogic/Kconfig      |   9 ++
 drivers/clk/anlogic/Makefile     |   5 +
 drivers/clk/anlogic/cru-dr1v90.c | 190 ++++++++++++++++++++++++++++
 drivers/clk/anlogic/cru_dr1.c    | 258 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/anlogic/cru_dr1.h    | 117 ++++++++++++++++++
 7 files changed, 581 insertions(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4d56475f94fc1e28823fe6aee626a96847d4e6d5..c5a29c55cddac8b136b2dc1511cc11ff69f0a55f 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -503,6 +503,7 @@ config COMMON_CLK_SP7021
 
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/analogbits/Kconfig"
+source "drivers/clk/anlogic/Kconfig"
 source "drivers/clk/baikal-t1/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 18ed29cfdc1133b6c254190c6092eb263366d5ac..9ce3fdc12aa6b7b9a47f80bfe43b2af5635cb0bf 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -113,6 +113,7 @@ obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
 # please keep this section sorted lexicographically by directory path name
 obj-y					+= actions/
 obj-y					+= analogbits/
+obj-y					+= anlogic/
 obj-$(CONFIG_COMMON_CLK_AT91)		+= at91/
 obj-$(CONFIG_ARCH_ARTPEC)		+= axis/
 obj-$(CONFIG_ARC_PLAT_AXS10X)		+= axs10x/
diff --git a/drivers/clk/anlogic/Kconfig b/drivers/clk/anlogic/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..63cf08d43ba85d160dcefc9c67eadf679af3c08e
--- /dev/null
+++ b/drivers/clk/anlogic/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config ANLOGIC_DR1V90_CRU
+	tristate "Anlogic DR1V90 clock support"
+	depends on ARCH_ANLOGIC || COMPILE_TEST
+	select AUXILIARY_BUS
+	default ARCH_ANLOGIC
+	help
+	  Support for the Clock and Reset Unit in Anlogic DR1V90 SoCs.
diff --git a/drivers/clk/anlogic/Makefile b/drivers/clk/anlogic/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..b16d93b2e190ce075e52fc767998662ef28ee270
--- /dev/null
+++ b/drivers/clk/anlogic/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_ANLOGIC_DR1V90_CRU)	+= anlogic-dr1v90-cru.o
+anlogic-dr1v90-cru-y			+= cru_dr1.o
+anlogic-dr1v90-cru-y			+= cru-dr1v90.o
diff --git a/drivers/clk/anlogic/cru-dr1v90.c b/drivers/clk/anlogic/cru-dr1v90.c
new file mode 100644
index 0000000000000000000000000000000000000000..c538289c2ee3e24642412cf66c39f605335d668d
--- /dev/null
+++ b/drivers/clk/anlogic/cru-dr1v90.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Shanghai Anlogic Infotech Co., Ltd.
+ * Copyright (c) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#include <linux/array_size.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "cru_dr1.h"
+
+#include <dt-bindings/clock/anlogic,dr1v90-cru.h>
+
+static const struct clk_div_table cru_div_table_24[] = {
+	{ 0xFFFFFF, 1 },  { 0x555555, 2 },  { 0x249249, 3 },  { 0x111111, 4 },
+	{ 0x084210, 5 },  { 0x041041, 6 },  { 0x020408, 7 },  { 0x010101, 8 },
+	{ 0x008040, 9 },  { 0x004010, 10 }, { 0x002004, 11 }, { 0x001001, 12 },
+	{ 0x000800, 13 }, { 0x000400, 14 }, { 0x000200, 15 }, { 0x000100, 16 },
+	{ 0x000080, 17 }, { 0x000040, 18 }, { 0x000020, 19 }, { 0x000010, 20 },
+	{ 0x000008, 21 }, { 0x000004, 22 }, { 0x000002, 23 }, { 0x000001, 24 },
+	{ /* sentinel */ }
+};
+
+static const struct clk_div_table cru_div_table_32[] = {
+	{ 0xFFFFFFFF, 1 },  { 0x55555555, 2 },	{ 0x24924924, 3 },
+	{ 0x11111111, 4 },  { 0x08421084, 5 },	{ 0x04104104, 6 },
+	{ 0x02040810, 7 },  { 0x01010101, 8 },	{ 0x00804020, 9 },
+	{ 0x00401004, 10 }, { 0x00200400, 11 }, { 0x00100100, 12 },
+	{ 0x00080040, 13 }, { 0x00040010, 14 }, { 0x00020004, 15 },
+	{ 0x00010001, 16 }, { 0x00008000, 17 }, { 0x00004000, 18 },
+	{ 0x00002000, 19 }, { 0x00001000, 20 }, { 0x00000800, 21 },
+	{ 0x00000400, 22 }, { 0x00000200, 23 }, { 0x00000100, 24 },
+	{ 0x00000080, 25 }, { 0x00000040, 26 }, { 0x00000020, 27 },
+	{ 0x00000010, 28 }, { 0x00000008, 29 }, { 0x00000004, 30 },
+	{ 0x00000002, 31 }, { 0x00000001, 32 }, { /* sentinel */ }
+};
+
+CLK_FIXED_FACTOR_FW_NAME(osc_div2, "osc_div2", "osc_33m", 2, 1, 0);
+
+CRU_PLL_NM_DEFINE(cpu_pll, CRU_PARENT_NAME(osc_33m), 0x120);
+CRU_PLL_C_DEFINE(cpu_pll_4x, CRU_PARENT_HW(cpu_pll), 0x14c);
+
+CRU_DIV_DEFINE(cpu_4x_div1, CRU_PARENT_HW(cpu_pll_4x), 0x010, 0, 24,
+	       cru_div_table_24, CLK_DIVIDER_READ_ONLY);
+CRU_DIV_DEFINE(cpu_4x_div2, CRU_PARENT_HW(cpu_pll_4x), 0x014, 0, 24,
+	       cru_div_table_24, CLK_DIVIDER_READ_ONLY);
+CRU_DIV_DEFINE(cpu_4x_div4, CRU_PARENT_HW(cpu_pll_4x), 0x018, 0, 24,
+	       cru_div_table_24, CLK_DIVIDER_READ_ONLY);
+
+CRU_PLL_NM_DEFINE(io_pll, CRU_PARENT_NAME(osc_33m), 0x220);
+CRU_PLL_C_DEFINE(io_1000m, CRU_PARENT_HW(io_pll), 0x248);
+CRU_PLL_C_DEFINE(io_400m, CRU_PARENT_HW(io_pll), 0x24c);
+CRU_PLL_C_DEFINE(io_25m, CRU_PARENT_HW(io_pll), 0x250);
+CRU_PLL_C_DEFINE(io_80m, CRU_PARENT_HW(io_pll), 0x254);
+
+CRU_DIV_DEFINE(io_400m_div2, CRU_PARENT_HW(io_400m), 0x020, 0, 32,
+	       cru_div_table_32, CLK_DIVIDER_READ_ONLY);
+CRU_DIV_DEFINE(io_400m_div4, CRU_PARENT_HW(io_400m), 0x024, 0, 32,
+	       cru_div_table_32, CLK_DIVIDER_READ_ONLY);
+CRU_DIV_DEFINE(io_400m_div8, CRU_PARENT_HW(io_400m), 0x028, 0, 32,
+	       cru_div_table_32, CLK_DIVIDER_READ_ONLY);
+CRU_DIV_DEFINE(io_400m_div16, CRU_PARENT_HW(io_400m), 0x02c, 0, 32,
+	       cru_div_table_32, CLK_DIVIDER_READ_ONLY);
+
+CRU_DIV_GATE_DEFINE(qspi, CRU_PARENT_HW(io_1000m), 0x030, 0, 6, NULL, 0, 2);
+CRU_DIV_GATE_DEFINE(spi, CRU_PARENT_HW(io_1000m), 0x030, 8, 6, NULL, 0, 4);
+CRU_DIV_GATE_DEFINE(smc, CRU_PARENT_HW(io_1000m), 0x030, 16, 6, NULL, 0, 4);
+CRU_DIV_DEFINE(sdio, CRU_PARENT_HW(io_400m), 0x030, 24, 6, NULL, 0);
+
+CRU_DIV_GATE_DEFINE(gpio_db, CRU_PARENT_HW(io_25m), 0x034, 0, 6, NULL, 0, 1);
+CRU_DIV_GATE_DEFINE(efuse, CRU_PARENT_HW(io_25m), 0x034, 8, 6, NULL, 0, 1);
+CRU_DIV_GATE_DEFINE(tvs, CRU_PARENT_HW(io_25m), 0x034, 16, 6, NULL, 0, 1);
+CRU_DIV_GATE_DEFINE(trng, CRU_PARENT_HW(io_25m), 0x034, 24, 7, NULL, 0, 1);
+
+CRU_DIV_GATE_DEFINE(osc_div, CRU_PARENT_NAME(osc_33m), 0x038, 0, 6, NULL, 0, 1);
+CRU_DIV_GATE_DEFINE(pwm, CRU_PARENT_NAME(osc_33m), 0x038, 8, 12, NULL, 0, 1);
+
+CRU_DIV_GATE_DEFINE(fclk0, CRU_PARENT_HW(io_400m), 0x03c, 0, 6, NULL, 0, 1);
+CRU_DIV_GATE_DEFINE(fclk1, CRU_PARENT_HW(io_400m), 0x03c, 8, 6, NULL, 0, 1);
+CRU_DIV_GATE_DEFINE(fclk2, CRU_PARENT_HW(io_400m), 0x03c, 16, 6, NULL, 0, 1);
+CRU_DIV_GATE_DEFINE(fclk3, CRU_PARENT_HW(io_400m), 0x03c, 24, 6, NULL, 0, 1);
+
+static const struct clk_parent_data wdt_parents[] = {
+	CRU_PARENT_HW(osc_div2),
+	CRU_PARENT_NAME(wdt_ext)
+};
+CRU_MUX_DEFINE(wdt_sel, wdt_parents, 0x040, 1, 1);
+
+static const struct clk_parent_data efuse_parents[] = {
+	CRU_PARENT_NAME(osc_33m),
+	CRU_PARENT_DIV_HW(efuse)
+};
+CRU_MUX_DEFINE(efuse_sel, efuse_parents, 0x040, 2, 1);
+
+static const struct clk_parent_data can_parents[] = {
+	CRU_PARENT_HW(io_80m),
+	CRU_PARENT_NAME(can_ext)
+};
+CRU_MUX_DEFINE(can_sel, can_parents, 0x040, 3, 1);
+
+static const struct clk_parent_data cpu_parents[] = {
+	CRU_PARENT_HW(cpu_4x_div1),
+	CRU_PARENT_HW(cpu_4x_div2)
+};
+CRU_MUX_DEFINE(cpu_sel, cpu_parents, 0x040, 5, 1);
+
+CRU_GATE_DEFINE(can0, CRU_PARENT_HW(can_sel), 0x08c, 20, CLK_GATE_SET_TO_DISABLE);
+CRU_GATE_DEFINE(can1, CRU_PARENT_HW(can_sel), 0x08c, 21, CLK_GATE_SET_TO_DISABLE);
+
+static const struct cru_clk dr1v90_cru_clks[] = {
+	[CLK_OSC_DIV2]		= { &osc_div2.hw,	NULL },
+	[CLK_CPU_PLL]		= { &cpu_pll.hw,	&cpu_pll.reg },
+	[CLK_CPU_PLL_4X]	= { &cpu_pll_4x.hw,	&cpu_pll_4x.reg },
+	[CLK_CPU_4X]		= { &cpu_4x_div1.hw,	&cpu_4x_div1.reg },
+	[CLK_CPU_2X]		= { &cpu_4x_div2.hw,	&cpu_4x_div2.reg },
+	[CLK_CPU_1X]		= { &cpu_4x_div4.hw,	&cpu_4x_div4.reg },
+	[CLK_IO_PLL]		= { &io_pll.hw,		&io_pll.reg },
+	[CLK_IO_1000M]		= { &io_1000m.hw,	&io_1000m.reg },
+	[CLK_IO_400M]		= { &io_400m.hw,	&io_400m.reg },
+	[CLK_IO_25M]		= { &io_25m.hw,		&io_25m.reg },
+	[CLK_IO_80M]		= { &io_80m.hw,		&io_80m.reg },
+	[CLK_IO_400M_DIV2]	= { &io_400m_div2.hw,	&io_400m_div2.reg },
+	[CLK_IO_400M_DIV4]	= { &io_400m_div4.hw,	&io_400m_div4.reg },
+	[CLK_IO_400M_DIV8]	= { &io_400m_div8.hw,	&io_400m_div8.reg },
+	[CLK_IO_400M_DIV16]	= { &io_400m_div16.hw,	&io_400m_div16.reg },
+	[CLK_QSPI]		= { &qspi.divider.hw,	&qspi.divider.reg },
+	[CLK_SPI]		= { &spi.divider.hw,	&spi.divider.reg },
+	[CLK_SMC]		= { &smc.divider.hw,	&smc.divider.reg },
+	[CLK_SDIO]		= { &sdio.hw,		&sdio.reg },
+	[CLK_GPIO_DB]		= { &gpio_db.divider.hw, &gpio_db.divider.reg },
+	[CLK_EFUSE]		= { &efuse.divider.hw,	&efuse.divider.reg },
+	[CLK_TVS]		= { &tvs.divider.hw,	&tvs.divider.reg },
+	[CLK_TRNG]		= { &trng.divider.hw,	&trng.divider.reg },
+	[CLK_OSC_DIV]		= { &osc_div.divider.hw, &osc_div.divider.reg },
+	[CLK_PWM]		= { &pwm.divider.hw,	&pwm.divider.reg },
+	[CLK_FCLK0]		= { &fclk0.divider.hw,	&fclk0.divider.reg },
+	[CLK_FCLK1]		= { &fclk1.divider.hw,	&fclk1.divider.reg },
+	[CLK_FCLK2]		= { &fclk2.divider.hw,	&fclk2.divider.reg },
+	[CLK_FCLK3]		= { &fclk3.divider.hw,	&fclk3.divider.reg },
+	[CLK_WDT_SEL]		= { &wdt_sel.hw,	&wdt_sel.reg },
+	[CLK_EFUSE_SEL]		= { &efuse_sel.hw,	&efuse_sel.reg },
+	[CLK_CAN_SEL]		= { &can_sel.hw,	&can_sel.reg },
+	[CLK_CPU_SEL]		= { &cpu_sel.hw,	&cpu_sel.reg },
+	[CLK_CAN0]		= { &can0.hw,		&can0.reg },
+	[CLK_CAN1]		= { &can1.hw,		&can1.reg }
+};
+
+static int dr1v90_cru_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	int ret;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ret = dr1_cru_clk_register(dev, base, dr1v90_cru_clks,
+				   ARRAY_SIZE(dr1v90_cru_clks));
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register clocks\n");
+
+	ret = dr1_cru_reset_register(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register resets\n");
+
+	return 0;
+}
+
+static const struct of_device_id dr1v90_cru_ids[] = {
+	{ .compatible = "anlogic,dr1v90-cru" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, dr1v90_cru_ids);
+
+static struct platform_driver dr1v90_cru_driver = {
+	.driver = {
+		.name = "dr1v90-cru",
+		.of_match_table = dr1v90_cru_ids,
+	},
+	.probe = dr1v90_cru_probe,
+};
+module_platform_driver(dr1v90_cru_driver);
+
+MODULE_AUTHOR("Junhui Liu <junhui.liu@pigmoral.tech>");
+MODULE_DESCRIPTION("Anlogic DR1V90 CRU driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/anlogic/cru_dr1.c b/drivers/clk/anlogic/cru_dr1.c
new file mode 100644
index 0000000000000000000000000000000000000000..5645149fd8cd9195b9075eaa278f37bb3cb118e7
--- /dev/null
+++ b/drivers/clk/anlogic/cru_dr1.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Shanghai Anlogic Infotech Co., Ltd.
+ * Copyright (c) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "cru_dr1.h"
+
+static unsigned long cru_pll_nm_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct cru_pll *pll = hw_to_cru_pll(hw);
+	u32 mult, div;
+
+	div = FIELD_GET(GENMASK(6, 0), readl(pll->reg)) + 1;
+	mult = FIELD_GET(GENMASK(6, 0), readl(pll->reg + 4)) + 1;
+
+	return parent_rate * mult / div;
+}
+
+const struct clk_ops dr1_cru_pll_nm_ops = {
+	.recalc_rate = cru_pll_nm_recalc_rate,
+};
+
+static unsigned long cru_pll_c_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct cru_pll *pll = hw_to_cru_pll(hw);
+	u32 div;
+
+	div = FIELD_GET(GENMASK(30, 24), readl(pll->reg)) + 1;
+
+	return parent_rate / div;
+}
+
+const struct clk_ops dr1_cru_pll_c_ops = {
+	.recalc_rate = cru_pll_c_recalc_rate,
+};
+
+static void cru_div_gate_endisable(struct clk_hw *hw, int enable)
+{
+	struct cru_div_gate *div_gate = hw_to_cru_div_gate(hw);
+	struct clk_divider *divider = &div_gate->divider;
+	u32 reg;
+
+	reg = readl(divider->reg);
+	reg &= ~(clk_div_mask(divider->width) << divider->shift);
+
+	if (enable)
+		reg |= div_gate->val << divider->shift;
+
+	writel(reg, divider->reg);
+}
+
+static int cru_div_gate_enable(struct clk_hw *hw)
+{
+	cru_div_gate_endisable(hw, 1);
+
+	return 0;
+}
+
+static void cru_div_gate_disable(struct clk_hw *hw)
+{
+	cru_div_gate_endisable(hw, 0);
+}
+
+static int cru_div_gate_is_enabled(struct clk_hw *hw)
+{
+	struct cru_div_gate *div_gate = hw_to_cru_div_gate(hw);
+	struct clk_divider *divider = &div_gate->divider;
+	u32 val;
+
+	val = readl(divider->reg) >> divider->shift;
+	val &= clk_div_mask(divider->width);
+
+	return !!val;
+}
+
+static unsigned long cru_div_gate_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	struct cru_div_gate *div_gate = hw_to_cru_div_gate(hw);
+	struct clk_divider *divider = &div_gate->divider;
+	unsigned int val;
+
+	val = readl(divider->reg) >> divider->shift;
+	val &= clk_div_mask(divider->width);
+
+	if (val < div_gate->min)
+		return 0;
+
+	return divider_recalc_rate(hw, parent_rate, val, divider->table,
+				   divider->flags, divider->width);
+}
+
+static long cru_div_gate_round_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long *prate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+
+	return divider_round_rate(hw, rate, prate, divider->table,
+				  divider->width, divider->flags);
+}
+
+static int cru_div_gate_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
+{
+	struct cru_div_gate *div_gate = hw_to_cru_div_gate(hw);
+	struct clk_divider *divider = &div_gate->divider;
+	unsigned long maxdiv, mindiv;
+	int div = 0;
+
+	maxdiv = clk_div_mask(divider->width) + 1;
+	mindiv = div_gate->min + 1;
+
+	div = DIV_ROUND_UP_ULL(req->best_parent_rate, req->rate);
+	div = div > maxdiv ? maxdiv : div;
+	div = div < mindiv ? mindiv : div;
+
+	req->rate = DIV_ROUND_UP_ULL(req->best_parent_rate, div);
+
+	return 0;
+}
+
+static int cru_div_gate_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	struct cru_div_gate *div_gate = hw_to_cru_div_gate(hw);
+	struct clk_divider *divider = &div_gate->divider;
+	int value;
+	u32 reg;
+
+	if (!__clk_get_enable_count(hw->clk))
+		return 0;
+
+	value = divider_get_val(rate, parent_rate, divider->table,
+				divider->width, divider->flags);
+	if (value < 0)
+		return value;
+
+	if (value < div_gate->min)
+		value = div_gate->min;
+
+	reg = readl(divider->reg);
+	reg &= ~(clk_div_mask(divider->width) << divider->shift);
+	reg |= (u32)value << divider->shift;
+	writel(reg, divider->reg);
+
+	div_gate->val = reg;
+
+	return 0;
+}
+
+static int cru_div_gate_init(struct clk_hw *hw)
+{
+	struct cru_div_gate *div_gate = hw_to_cru_div_gate(hw);
+	struct clk_divider *divider = &div_gate->divider;
+	u32 val;
+
+	val = readl(divider->reg) >> divider->shift;
+	val &= clk_div_mask(divider->width);
+	div_gate->val = val;
+
+	return 0;
+}
+
+const struct clk_ops dr1_cru_div_gate_ops = {
+	.enable = cru_div_gate_enable,
+	.disable = cru_div_gate_disable,
+	.is_enabled = cru_div_gate_is_enabled,
+	.recalc_rate = cru_div_gate_recalc_rate,
+	.round_rate = cru_div_gate_round_rate,
+	.determine_rate = cru_div_gate_determine_rate,
+	.set_rate = cru_div_gate_set_rate,
+	.init = cru_div_gate_init,
+};
+
+int dr1_cru_clk_register(struct device *dev, void __iomem *base,
+			 const struct cru_clk *clks, int nr_clks)
+{
+	struct clk_hw_onecell_data *priv;
+	int i, ret;
+
+	priv = devm_kzalloc(dev, struct_size(priv, hws, nr_clks), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_clks; i++) {
+		const struct cru_clk *clk = &clks[i];
+
+		if (clk->reg)
+			*(clk->reg) += (uintptr_t)base;
+
+		ret = devm_clk_hw_register(dev, clk->hw);
+		if (ret)
+			return ret;
+
+		priv->hws[i] = clk->hw;
+	}
+
+	priv->num = nr_clks;
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, priv);
+	if (ret)
+		dev_err(dev, "failed to add clock hardware provider\n");
+
+	return ret;
+}
+
+static void dr1_cru_cadev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	kfree(adev);
+}
+
+static void dr1_cru_adev_unregister(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+int dr1_cru_reset_register(struct device *dev)
+{
+	struct auxiliary_device *adev __free(kfree);
+	int ret;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->name = "reset";
+	adev->dev.parent = dev;
+	adev->dev.release = dr1_cru_cadev_release;
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(dev, dr1_cru_adev_unregister, adev);
+}
diff --git a/drivers/clk/anlogic/cru_dr1.h b/drivers/clk/anlogic/cru_dr1.h
new file mode 100644
index 0000000000000000000000000000000000000000..4599a3c36d08e8d20105a225336b87426821143b
--- /dev/null
+++ b/drivers/clk/anlogic/cru_dr1.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 Shanghai Anlogic Infotech Co., Ltd.
+ * Copyright (c) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#ifndef _CRU_DR1_H_
+#define _CRU_DR1_H_
+
+#include "linux/clk-provider.h"
+
+struct cru_pll {
+	struct clk_hw hw;
+	void __iomem *reg;
+};
+
+struct cru_div_gate {
+	struct clk_divider divider;
+	u32 val;
+	u8 min; /* Minimum divider value to avoid timing issues */
+};
+
+struct cru_clk {
+	struct clk_hw *hw;
+	void **reg;
+};
+
+#define CRU_PARENT_NAME(_name)		{ .fw_name = #_name }
+#define CRU_PARENT_HW(_parent)		{ .hw = &_parent.hw }
+#define CRU_PARENT_DIV_HW(_parent)	{ .hw = &_parent.divider.hw }
+
+#define CRU_INITHW(_name, _parent, _ops)				\
+	.hw.init = &(struct clk_init_data) {				\
+		.name		= #_name,				\
+		.parent_data	= (const struct clk_parent_data[])	\
+					{ _parent },			\
+		.num_parents	= 1,					\
+		.ops		= &_ops,				\
+	}
+
+#define CRU_INITHW_PARENTS(_name, _parents, _ops)			\
+	.hw.init = CLK_HW_INIT_PARENTS_DATA(#_name, _parents, &_ops, 0)
+
+#define CRU_PLL_NM_DEFINE(_name, _parent, _reg)				\
+static struct cru_pll _name = {						\
+	.reg = (void __iomem *)(_reg),					\
+	CRU_INITHW(_name, _parent, dr1_cru_pll_nm_ops),			\
+}
+
+#define CRU_PLL_C_DEFINE(_name, _parent, _reg)				\
+static struct cru_pll _name = {						\
+	.reg = (void __iomem *)(_reg),					\
+	CRU_INITHW(_name, _parent, dr1_cru_pll_c_ops),			\
+}
+
+#define CRU_DIV_DEFINE(_name, _parent, _reg, _shift, _width, _table,	\
+		       _flags)						\
+static struct clk_divider _name = {					\
+	.shift = _shift,						\
+	.width = _width,						\
+	.flags = _flags,						\
+	.table = _table,						\
+	.reg = (void __iomem *)(_reg),					\
+	CRU_INITHW(_name, _parent, clk_divider_ops),			\
+}
+
+#define CRU_DIV_GATE_DEFINE(_name, _parent, _reg, _shift, _width,	\
+			    _table, _flags, _min)			\
+static struct cru_div_gate _name = {					\
+	.min = _min,							\
+	.divider = {							\
+		.shift = _shift,					\
+		.width = _width,					\
+		.flags = _flags,					\
+		.table = _table,					\
+		.reg = (void __iomem *)(_reg),				\
+		CRU_INITHW(_name, _parent, dr1_cru_div_gate_ops),	\
+	}								\
+}
+
+#define CRU_MUX_DEFINE(_name, _parents, _reg, _shift, _width)		\
+static struct clk_mux _name = {						\
+	.shift = _shift,						\
+	.mask = GENMASK(_width - 1, 0),					\
+	.reg = (void __iomem *)(_reg),					\
+	CRU_INITHW_PARENTS(_name, _parents, clk_mux_ops)		\
+}
+
+#define CRU_GATE_DEFINE(_name, _parent, _reg, _bit_idx, _flags)		\
+static struct clk_gate _name = {					\
+	.bit_idx = _bit_idx,						\
+	.flags = _flags,						\
+	.reg = (void __iomem *)(_reg),					\
+	CRU_INITHW(_name, _parent, clk_gate_ops)			\
+}
+
+static inline struct cru_pll *hw_to_cru_pll(struct clk_hw *hw)
+{
+	return container_of(hw, struct cru_pll, hw);
+}
+
+static inline struct cru_div_gate *hw_to_cru_div_gate(struct clk_hw *hw)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+
+	return container_of(divider, struct cru_div_gate, divider);
+}
+
+extern const struct clk_ops dr1_cru_pll_nm_ops;
+extern const struct clk_ops dr1_cru_pll_c_ops;
+extern const struct clk_ops dr1_cru_div_gate_ops;
+
+int dr1_cru_clk_register(struct device *dev, void __iomem *base,
+			 const struct cru_clk *clks, int nr_clks);
+int dr1_cru_reset_register(struct device *dev);
+
+#endif /* _CRU_DR1_H_ */

-- 
2.51.0


