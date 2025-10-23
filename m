Return-Path: <linux-kernel+bounces-866345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7157FBFF85B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC1D45000BF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFFE2DAFDD;
	Thu, 23 Oct 2025 07:18:42 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB1D2DAFAF;
	Thu, 23 Oct 2025 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203918; cv=none; b=UtsTGcTQ6piDNiJ1g/+93SQC+Rf1rfIxS69828CV/2SvJ6UqsTFFvq32kmoHNM1O0e4VsDVGyK4BSNy0Mu+2lvLdRMUS6QS3CjkBgsJdOVPbo1KGn1et+fMCWueGIvvxU4McveXsNiunon1ZQ042UEAe6j5FFmmj8H7teU/2FMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203918; c=relaxed/simple;
	bh=E/02lUeAEJx/8de5VzjpCP6NVjYqgGkmyos3GG33cCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YSqzERdpqtXcq2Rc31uAqTcf0tsZIcksPYzvgzQPSYiPWdV90/YodRqez/sPzQbPsSrCeGtNPC2PL8sp5cJGMsP5vvoOK7kE/vPhsbqM4WO21Nbtcm8nSm7Lk9yj04xbop6GALo1khwqET5NJgMO2DuU/TddpN2hAQhWPy0pwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app2 (Coremail) with SMTP id TQJkCgBn+ZK51vloc5sqAQ--.49781S2;
	Thu, 23 Oct 2025 15:18:19 +0800 (CST)
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
Subject: [PATCH v7 2/2] clock: eswin: Add eic7700 clock driver
Date: Thu, 23 Oct 2025 15:18:14 +0800
Message-Id: <20251023071814.568-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20251023071658.455-1-dongxuyang@eswincomputing.com>
References: <20251023071658.455-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBn+ZK51vloc5sqAQ--.49781S2
X-Coremail-Antispam: 1UD129KBjvAXoWkJFWxKFyUCr4rAF13AF13Jwb_yoW3KF4xCo
	W8CFsxZrW8Kw1UZrZxCr1fG34Ygw1xAr9Fvr1fXr1xAF17J3srtry8AF4Y9r1ftFyjkr95
	Crn5KrZ3ZFWUWay5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOEfODUUUU
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

Add clock drivers for the EIC7700 SoC. The clock controller on the ESWIN
EIC7700 provides various clocks to different IP blocks within the SoC.

Signed-off-by: Yifeng Huang <huangyifeng@eswincomputing.com>
Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
---
 drivers/clk/Kconfig             |    1 +
 drivers/clk/Makefile            |    1 +
 drivers/clk/eswin/Kconfig       |   15 +
 drivers/clk/eswin/Makefile      |    8 +
 drivers/clk/eswin/clk-eic7700.c | 1033 +++++++++++++++++++++++++++++++
 drivers/clk/eswin/clk-eic7700.h |  122 ++++
 drivers/clk/eswin/clk.c         |  481 ++++++++++++++
 drivers/clk/eswin/clk.h         |  256 ++++++++
 8 files changed, 1917 insertions(+)
 create mode 100644 drivers/clk/eswin/Kconfig
 create mode 100644 drivers/clk/eswin/Makefile
 create mode 100644 drivers/clk/eswin/clk-eic7700.c
 create mode 100644 drivers/clk/eswin/clk-eic7700.h
 create mode 100644 drivers/clk/eswin/clk.c
 create mode 100644 drivers/clk/eswin/clk.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3a1611008e48..2a9056d41093 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -515,6 +515,7 @@ source "drivers/clk/actions/Kconfig"
 source "drivers/clk/analogbits/Kconfig"
 source "drivers/clk/baikal-t1/Kconfig"
 source "drivers/clk/bcm/Kconfig"
+source "drivers/clk/eswin/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
 source "drivers/clk/imx/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index b74a1767ca27..9075f8cabd8d 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -121,6 +121,7 @@ obj-$(CONFIG_CLK_BAIKAL_T1)		+= baikal-t1/
 obj-y					+= bcm/
 obj-$(CONFIG_ARCH_BERLIN)		+= berlin/
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci/
+obj-$(CONFIG_ARCH_ESWIN)		+= eswin/
 obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
 obj-y					+= imgtec/
 obj-y					+= imx/
diff --git a/drivers/clk/eswin/Kconfig b/drivers/clk/eswin/Kconfig
new file mode 100644
index 000000000000..9bc9008d3156
--- /dev/null
+++ b/drivers/clk/eswin/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config COMMON_CLK_ESWIN
+	bool
+
+config COMMON_CLK_EIC7700
+	bool "EIC7700 Clock Driver"
+	depends on ARCH_ESWIN || COMPILE_TEST
+	select COMMON_CLK_ESWIN
+	default ARCH_ESWIN
+	help
+	  This driver provides support for clock controller on ESWIN EIC7700
+	  SoC. The clock controller can generates and supplies clock to various
+	  peripherals within the SoC.
+	  Say yes here to support the clock controller on the EIC7700 SoC.
diff --git a/drivers/clk/eswin/Makefile b/drivers/clk/eswin/Makefile
new file mode 100644
index 000000000000..4a7c2af82164
--- /dev/null
+++ b/drivers/clk/eswin/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Eswin Clock specific Makefile
+#
+
+obj-$(CONFIG_COMMON_CLK_ESWIN)		+= clk.o
+
+obj-$(CONFIG_COMMON_CLK_EIC7700)	+= clk-eic7700.o
diff --git a/drivers/clk/eswin/clk-eic7700.c b/drivers/clk/eswin/clk-eic7700.c
new file mode 100644
index 000000000000..03540db9cb7d
--- /dev/null
+++ b/drivers/clk/eswin/clk-eic7700.c
@@ -0,0 +1,1033 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd..
+ * All rights reserved.
+ *
+ * ESWIN EIC7700 Clk Provider Driver
+ *
+ * Authors:
+ *	Yifeng Huang <huangyifeng@eswincomputing.com>
+ *	Xuyang Dong <dongxuyang@eswincomputing.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/clock/eswin,eic7700-clock.h>
+
+#include "clk.h"
+#include "clk-eic7700.h"
+
+#define EIC7700_NR_CLKS (EIC7700_CLK_FIXED_FACTOR_HSP_RMII_REF_DIV6 + 1)
+
+/* clock parent list */
+PNAME(mux_cpu_root_3mux1_gfree_p) = { "clk_pll_cpu",
+				      "fixed_factor_u84_core_lp_div2",
+				      "xtal24m" };
+PNAME(mux_cpu_aclk_2mux1_gfree_p) = { "fixed_factor_cpu_div2",
+				      "mux_cpu_root_3mux1_gfree" };
+PNAME(dsp_aclk_root_2mux1_gfree_mux_p) = { "fixed_rate_clk_spll2_fout1",
+					   "fixed_rate_clk_spll0_fout1" };
+PNAME(d2d_aclk_root_2mux1_gfree_mux_p) = { "fixed_rate_clk_spll2_fout1",
+					   "fixed_rate_clk_spll0_fout1" };
+PNAME(ddr_aclk_root_2mux1_gfree_mux_p) = { "fixed_rate_clk_spll2_fout1",
+					   "fixed_rate_clk_spll0_fout1" };
+PNAME(mshcore_root_3mux1_0_mux_p) = { "fixed_rate_clk_spll0_fout3",
+				      "fixed_rate_clk_spll2_fout3" };
+PNAME(mshcore_root_3mux1_1_mux_p) = { "fixed_rate_clk_spll0_fout3",
+				      "fixed_rate_clk_spll2_fout3" };
+PNAME(mshcore_root_3mux1_2_mux_p) = { "fixed_rate_clk_spll0_fout3",
+				      "fixed_rate_clk_spll2_fout3" };
+PNAME(npu_llclk_3mux1_gfree_mux_p) = { "divider_npu_llc_src0_div_dynm",
+				       "divider_npu_llc_src1_div_dynm",
+				       "fixed_rate_clk_vpll_fout1" };
+PNAME(npu_core_3mux1_gfree_mux_p) = { "fixed_rate_clk_spll1_fout1",
+				      "fixed_rate_clk_vpll_fout1",
+				      "fixed_rate_clk_spll2_fout2" };
+PNAME(npu_e31_3mux1_gfree_mux_p) = { "fixed_rate_clk_spll1_fout1",
+				     "fixed_rate_clk_vpll_fout1",
+				     "fixed_rate_clk_spll2_fout2" };
+PNAME(vi_aclk_root_2mux1_gfree_mux_p) = { "fixed_rate_clk_spll0_fout1",
+					  "fixed_rate_clk_spll2_fout1" };
+PNAME(mux_vi_dw_root_2mux1_p) = { "fixed_rate_clk_vpll_fout1",
+				  "fixed_rate_clk_spll0_fout1" };
+PNAME(mux_vi_dvp_root_2mux1_gfree_p) = { "fixed_rate_clk_vpll_fout1",
+					 "fixed_rate_clk_spll0_fout1" };
+PNAME(mux_vi_dig_isp_root_2mux1_gfree_p) = { "fixed_rate_clk_vpll_fout1",
+					     "fixed_rate_clk_spll0_fout1" };
+PNAME(mux_vo_aclk_root_2mux1_gfree_p) = { "fixed_rate_clk_spll0_fout1",
+					  "fixed_rate_clk_spll2_fout1" };
+PNAME(mux_vo_pixel_root_2mux1_p) = { "fixed_rate_clk_vpll_fout1",
+				     "fixed_rate_clk_spll2_fout2" };
+PNAME(mux_vcdec_root_2mux1_gfree_p) = { "fixed_rate_clk_spll0_fout1",
+					"fixed_rate_clk_spll2_fout1" };
+PNAME(mux_vcaclk_root_2mux1_gfree_p) = { "fixed_rate_clk_spll0_fout1",
+					 "fixed_rate_clk_spll2_fout1" };
+PNAME(mux_syscfg_clk_root_2mux1_gfree_p) = { "divider_sys_cfg_div_dynm",
+					     "xtal24m" };
+PNAME(mux_bootspi_clk_2mux1_gfree_p) = { "divider_bootspi_div_dynm",
+					 "xtal24m" };
+PNAME(mux_scpu_core_clk_2mux1_gfree_p) = { "divider_scpu_core_div_dynm",
+					   "xtal24m" };
+PNAME(mux_lpcpu_core_clk_2mux1_gfree_p) = { "divider_lpcpu_core_div_dynm",
+					    "xtal24m" };
+PNAME(mux_vo_mclk_2mux_ext_mclk_p) = { "divider_vo_mclk_div_dynm",
+				       "fixed_rate_ext_mclk" };
+PNAME(mux_aondma_axi2mux1_gfree_p) = { "divider_aondma_axi_div_dynm",
+				       "xtal24m" };
+PNAME(mux_rmii_ref_2mux1_p) = { "fixed_factor_hsp_rmii_ref_div6",
+				"fixed_rate_lpddr_ref_bak" };
+PNAME(mux_eth_core_2mux1_p) = { "fixed_rate_clk_spll1_fout3",
+				"fixed_rate_lpddr_ref_bak" };
+PNAME(mux_sata_phy_2mux1_p) = { "divider_sata_phy_ref_div_dynm",
+				"fixed_rate_lpddr_ref_bak" };
+
+/* fixed rate clocks */
+static struct eswin_fixed_rate_clock eic7700_fixed_rate_clks[] = {
+	EIC7700_FIXED(EIC7700_CLK_XTAL_32K, "fixed_rate_clk_xtal_32k", NULL, 0,
+		      32768),
+	EIC7700_FIXED(EIC7700_CLK_SPLL0_FOUT1, "fixed_rate_clk_spll0_fout1",
+		      NULL, 0, 1600000000),
+	EIC7700_FIXED(EIC7700_CLK_SPLL0_FOUT2, "fixed_rate_clk_spll0_fout2",
+		      NULL, 0, 800000000),
+	EIC7700_FIXED(EIC7700_CLK_SPLL0_FOUT3, "fixed_rate_clk_spll0_fout3",
+		      NULL, 0, 400000000),
+	EIC7700_FIXED(EIC7700_CLK_SPLL1_FOUT1, "fixed_rate_clk_spll1_fout1",
+		      NULL, 0, 1500000000),
+	EIC7700_FIXED(EIC7700_CLK_SPLL1_FOUT2, "fixed_rate_clk_spll1_fout2",
+		      NULL, 0, 300000000),
+	EIC7700_FIXED(EIC7700_CLK_SPLL1_FOUT3, "fixed_rate_clk_spll1_fout3",
+		      NULL, 0, 250000000),
+	EIC7700_FIXED(EIC7700_CLK_SPLL2_FOUT1, "fixed_rate_clk_spll2_fout1",
+		      NULL, 0, 2080000000),
+	EIC7700_FIXED(EIC7700_CLK_SPLL2_FOUT2, "fixed_rate_clk_spll2_fout2",
+		      NULL, 0, 1040000000),
+	EIC7700_FIXED(EIC7700_CLK_SPLL2_FOUT3, "fixed_rate_clk_spll2_fout3",
+		      NULL, 0, 416000000),
+	EIC7700_FIXED(EIC7700_CLK_VPLL_FOUT1, "fixed_rate_clk_vpll_fout1",
+		      NULL, 0, 1188000000),
+	EIC7700_FIXED(EIC7700_CLK_VPLL_FOUT2, "fixed_rate_clk_vpll_fout2",
+		      NULL, 0, 594000000),
+	EIC7700_FIXED(EIC7700_CLK_VPLL_FOUT3, "fixed_rate_clk_vpll_fout3",
+		      NULL, 0, 49500000),
+	EIC7700_FIXED(EIC7700_CLK_APLL_FOUT2, "fixed_rate_clk_apll_fout2",
+		      NULL, 0, 0),
+	EIC7700_FIXED(EIC7700_CLK_APLL_FOUT3, "fixed_rate_clk_apll_fout3",
+		      NULL, 0, 0),
+	EIC7700_FIXED(EIC7700_CLK_EXT_MCLK, "fixed_rate_ext_mclk", NULL, 0, 0),
+	EIC7700_FIXED(EIC7700_CLK_LPDDR_REF_BAK, "fixed_rate_lpddr_ref_bak",
+		      NULL, 0, 50000000),
+};
+
+/* pll clocks */
+static struct eswin_pll_clock eic7700_pll_clks[] = {
+	EIC7700_PLL(EIC7700_CLK_APLL_FOUT1, "clk_apll_fout1", NULL,
+		    EIC7700_REG_OFFSET_APLL_CFG_0, 0, 1, 12, 6, 20, 12,
+		    EIC7700_REG_OFFSET_APLL_CFG_1, 4, 24,
+		    EIC7700_REG_OFFSET_APLL_CFG_2, 1, 3, 16, 3,
+		    EIC7700_REG_OFFSET_PLL_STATUS, 4, 1),
+	EIC7700_PLL(EIC7700_CLK_PLL_CPU, "clk_pll_cpu", NULL,
+		    EIC7700_REG_OFFSET_MCPUT_PLL_CFG_0, 0, 1, 12, 6, 20, 12,
+		    EIC7700_REG_OFFSET_MCPUT_PLL_CFG_1, 4, 24,
+		    EIC7700_REG_OFFSET_MCPUT_PLL_CFG_2, 1, 3, 16, 3,
+		    EIC7700_REG_OFFSET_PLL_STATUS, 5, 1),
+};
+
+/* fixed factor clocks */
+static struct eswin_fixed_factor_clock eic7700_fixed_factor_clks[] = {
+	EIC7700_FACTOR(EIC7700_CLK_FIXED_FACTOR_CPU_DIV2,
+		       "fixed_factor_cpu_div2", "mux_cpu_root_3mux1_gfree", 1,
+		       2, 0),
+	EIC7700_FACTOR(EIC7700_CLK_FIXED_FACTOR_CLK_1M_DIV24,
+		       "fixed_factor_clk_1m_div24", "xtal24m", 1, 24, 0),
+	EIC7700_FACTOR(EIC7700_CLK_FIXED_FACTOR_MIPI_TXESC_DIV10,
+		       "fixed_factor_mipi_txesc_div10",
+		       "mux_syscfg_clk_root_2mux1_gfree", 1, 10, 0),
+	EIC7700_FACTOR(EIC7700_CLK_FIXED_FACTOR_U84_CORE_LP_DIV2,
+		       "fixed_factor_u84_core_lp_div2", "gate_clk_spll0_fout2",
+		       1, 2, 0),
+	EIC7700_FACTOR(EIC7700_CLK_FIXED_FACTOR_SCPU_BUS_DIV2,
+		       "fixed_factor_scpu_bus_div2",
+		       "mux_scpu_core_clk_2mux1_gfree", 1, 2, 0),
+	EIC7700_FACTOR(EIC7700_CLK_FIXED_FACTOR_LPCPU_BUS_DIV2,
+		       "fixed_factor_lpcpu_bus_div2",
+		       "mux_lpcpu_core_clk_2mux1_gfree", 1, 2, 0),
+	EIC7700_FACTOR(EIC7700_CLK_FIXED_FACTOR_PCIE_CR_DIV2,
+		       "fixed_factor_pcie_cr_div2",
+		       "mux_syscfg_clk_root_2mux1_gfree", 1, 2, 0),
+	EIC7700_FACTOR(EIC7700_CLK_FIXED_FACTOR_PCIE_AUX_DIV4,
+		       "fixed_factor_pcie_aux_div4",
+		       "mux_syscfg_clk_root_2mux1_gfree", 1, 4, 0),
+	EIC7700_FACTOR(EIC7700_CLK_FIXED_FACTOR_PVT_DIV20,
+		       "fixed_factor_pvt_div20", "xtal24m", 1, 20, 0),
+	EIC7700_FACTOR(EIC7700_CLK_FIXED_FACTOR_HSP_RMII_REF_DIV6,
+		       "fixed_factor_hsp_rmii_ref_div6",
+		       "fixed_rate_clk_spll1_fout2", 1, 6, 0),
+};
+
+/* mux clocks */
+static struct eswin_mux_clock eic7700_mux_clks[] = {
+	EIC7700_MUX(EIC7700_CLK_MUX_CPU_ROOT_3MUX1_GFREE,
+		    "mux_cpu_root_3mux1_gfree", mux_cpu_root_3mux1_gfree_p,
+		    ARRAY_SIZE(mux_cpu_root_3mux1_gfree_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_U84_CTRL, 0, 2, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_CPU_ACLK_2MUX1_GFREE,
+		    "mux_cpu_aclk_2mux1_gfree", mux_cpu_aclk_2mux1_gfree_p,
+		    ARRAY_SIZE(mux_cpu_aclk_2mux1_gfree_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_U84_CTRL, 20, 1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_DSP_ACLK_ROOT_2MUX1_GFREE,
+		    "mux_dsp_aclk_root_2mux1_gfree",
+		    dsp_aclk_root_2mux1_gfree_mux_p,
+		    ARRAY_SIZE(dsp_aclk_root_2mux1_gfree_mux_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_DSP_ACLK_CTRL, 0, 1,
+		    0),
+	EIC7700_MUX(EIC7700_CLK_MUX_D2D_ACLK_ROOT_2MUX1_GFREE,
+		    "mux_d2d_aclk_root_2mux1_gfree",
+		    d2d_aclk_root_2mux1_gfree_mux_p,
+		    ARRAY_SIZE(d2d_aclk_root_2mux1_gfree_mux_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_D2D_ACLK_CTRL, 0,
+		    1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_DDR_ACLK_ROOT_2MUX1_GFREE,
+		    "mux_ddr_aclk_root_2mux1_gfree",
+		    ddr_aclk_root_2mux1_gfree_mux_p,
+		    ARRAY_SIZE(ddr_aclk_root_2mux1_gfree_mux_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_DDR_CTRL, 16, 1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_MSHCORE_ROOT_3MUX1_0,
+		    "mux_mshcore_root_3mux1_0", mshcore_root_3mux1_0_mux_p,
+		    ARRAY_SIZE(mshcore_root_3mux1_0_mux_p), CLK_SET_RATE_PARENT,
+		    EIC7700_REG_OFFSET_MSHC0_CORE_CTRL, 0, 1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_MSHCORE_ROOT_3MUX1_1,
+		    "mux_mshcore_root_3mux1_1", mshcore_root_3mux1_1_mux_p,
+		    ARRAY_SIZE(mshcore_root_3mux1_1_mux_p), CLK_SET_RATE_PARENT,
+		    EIC7700_REG_OFFSET_MSHC1_CORE_CTRL, 0, 1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_MSHCORE_ROOT_3MUX1_2,
+		    "mux_mshcore_root_3mux1_2", mshcore_root_3mux1_2_mux_p,
+		    ARRAY_SIZE(mshcore_root_3mux1_2_mux_p), CLK_SET_RATE_PARENT,
+		    EIC7700_REG_OFFSET_MSHC2_CORE_CTRL, 0, 1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_NPU_LLCLK_3MUX1_GFREE,
+		    "mux_npu_llclk_3mux1_gfree", npu_llclk_3mux1_gfree_mux_p,
+		    ARRAY_SIZE(npu_llclk_3mux1_gfree_mux_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_NPU_LLC_CTRL, 0, 2,
+		    0),
+	EIC7700_MUX(EIC7700_CLK_MUX_NPU_CORE_3MUX1_GFREE,
+		    "mux_npu_core_3mux1_gfree", npu_core_3mux1_gfree_mux_p,
+		    ARRAY_SIZE(npu_core_3mux1_gfree_mux_p), CLK_SET_RATE_PARENT,
+		    EIC7700_REG_OFFSET_NPU_CORE_CTRL, 0, 2, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_NPU_E31_3MUX1_GFREE,
+		    "mux_npu_e31_3mux1_gfree", npu_e31_3mux1_gfree_mux_p,
+		    ARRAY_SIZE(npu_e31_3mux1_gfree_mux_p), CLK_SET_RATE_PARENT,
+		    EIC7700_REG_OFFSET_NPU_CORE_CTRL, 8, 2, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_VI_ACLK_ROOT_2MUX1_GFREE,
+		    "mux_vi_aclk_root_2mux1_gfree",
+		    vi_aclk_root_2mux1_gfree_mux_p,
+		    ARRAY_SIZE(vi_aclk_root_2mux1_gfree_mux_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_VI_ACLK_CTRL, 0, 1,
+		    0),
+	EIC7700_MUX(EIC7700_CLK_MUX_VI_DW_ROOT_2MUX1, "mux_vi_dw_root_2mux1",
+		    mux_vi_dw_root_2mux1_p, ARRAY_SIZE(mux_vi_dw_root_2mux1_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_VI_DWCLK_CTRL, 0,
+		    1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_VI_DVP_ROOT_2MUX1_GFREE,
+		    "mux_vi_dvp_root_2mux1_gfree",
+		    mux_vi_dvp_root_2mux1_gfree_p,
+		    ARRAY_SIZE(mux_vi_dvp_root_2mux1_gfree_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_VI_DVP_CTRL, 0, 1,
+		    0),
+	EIC7700_MUX(EIC7700_CLK_MUX_VI_DIG_ISP_ROOT_2MUX1_GFREE,
+		    "mux_vi_dig_isp_root_2mux1_gfree",
+		    mux_vi_dig_isp_root_2mux1_gfree_p,
+		    ARRAY_SIZE(mux_vi_dig_isp_root_2mux1_gfree_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_VI_DIG_ISP_CTRL, 0,
+		    1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_VO_ACLK_ROOT_2MUX1_GFREE,
+		    "mux_vo_aclk_root_2mux1_gfree",
+		    mux_vo_aclk_root_2mux1_gfree_p,
+		    ARRAY_SIZE(mux_vo_aclk_root_2mux1_gfree_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_VO_ACLK_CTRL, 0, 1,
+		    0),
+	EIC7700_MUX(EIC7700_CLK_MUX_VO_PIXEL_ROOT_2MUX1,
+		    "mux_vo_pixel_root_2mux1", mux_vo_pixel_root_2mux1_p,
+		    ARRAY_SIZE(mux_vo_pixel_root_2mux1_p), CLK_SET_RATE_PARENT,
+		    EIC7700_REG_OFFSET_VO_PIXEL_CTRL, 0, 1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_VCDEC_ROOT_2MUX1_GFREE,
+		    "mux_vcdec_root_2mux1_gfree", mux_vcdec_root_2mux1_gfree_p,
+		    ARRAY_SIZE(mux_vcdec_root_2mux1_gfree_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_VCDEC_ROOT_CTRL, 0,
+		    1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_VCACLK_ROOT_2MUX1_GFREE,
+		    "mux_vcaclk_root_2mux1_gfree",
+		    mux_vcaclk_root_2mux1_gfree_p,
+		    ARRAY_SIZE(mux_vcaclk_root_2mux1_gfree_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_VC_ACLK_CTRL, 0, 1,
+		    0),
+	EIC7700_MUX(EIC7700_CLK_MUX_SYSCFG_CLK_ROOT_2MUX1_GFREE,
+		    "mux_syscfg_clk_root_2mux1_gfree",
+		    mux_syscfg_clk_root_2mux1_gfree_p,
+		    ARRAY_SIZE(mux_syscfg_clk_root_2mux1_gfree_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_SYSCFG_CTRL, 0, 1,
+		    0),
+	EIC7700_MUX(EIC7700_CLK_MUX_BOOTSPI_CLK_2MUX1_GFREE,
+		    "mux_bootspi_clk_2mux1_gfree",
+		    mux_bootspi_clk_2mux1_gfree_p,
+		    ARRAY_SIZE(mux_bootspi_clk_2mux1_gfree_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_BOOTSPI_CTRL, 0, 1,
+		    0),
+	EIC7700_MUX(EIC7700_CLK_MUX_SCPU_CORE_CLK_2MUX1_GFREE,
+		    "mux_scpu_core_clk_2mux1_gfree",
+		    mux_scpu_core_clk_2mux1_gfree_p,
+		    ARRAY_SIZE(mux_scpu_core_clk_2mux1_gfree_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_SCPU_CORE_CTRL, 0,
+		    1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_LPCPU_CORE_CLK_2MUX1_GFREE,
+		    "mux_lpcpu_core_clk_2mux1_gfree",
+		    mux_lpcpu_core_clk_2mux1_gfree_p,
+		    ARRAY_SIZE(mux_lpcpu_core_clk_2mux1_gfree_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_LPCPU_CORE_CTRL, 0,
+		    1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_VO_MCLK_2MUX_EXT_MCLK,
+		    "mux_vo_mclk_2mux_ext_mclk", mux_vo_mclk_2mux_ext_mclk_p,
+		    ARRAY_SIZE(mux_vo_mclk_2mux_ext_mclk_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_VO_MCLK_CTRL, 0, 1,
+		    0),
+	EIC7700_MUX(EIC7700_CLK_MUX_AONDMA_AXI2MUX1_GFREE,
+		    "mux_aondma_axi2mux1_gfree", mux_aondma_axi2mux1_gfree_p,
+		    ARRAY_SIZE(mux_aondma_axi2mux1_gfree_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_AON_DMA_CTRL, 20,
+		    1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_RMII_REF_2MUX, "mux_rmii_ref_2mux1",
+		    mux_rmii_ref_2mux1_p, ARRAY_SIZE(mux_rmii_ref_2mux1_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_ETH0_CTRL, 2, 1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_ETH_CORE_2MUX1, "mux_eth_core_2mux1",
+		    mux_eth_core_2mux1_p, ARRAY_SIZE(mux_eth_core_2mux1_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_ETH0_CTRL, 1, 1, 0),
+	EIC7700_MUX(EIC7700_CLK_MUX_SATA_PHY_2MUX1, "mux_sata_phy_2mux1",
+		    mux_sata_phy_2mux1_p, ARRAY_SIZE(mux_sata_phy_2mux1_p),
+		    CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_SATA_OOB_CTRL, 9,
+		    1, 0),
+};
+
+/* divider clocks */
+static struct eswin_divider_clock eic7700_div_clks[] = {
+	EIC7700_DIV(EIC7700_CLK_DIV_SYS_CFG_DYNM, "divider_sys_cfg_div_dynm",
+		    "fixed_rate_clk_spll0_fout3", 0,
+		    EIC7700_REG_OFFSET_SYSCFG_CTRL, 4, 3,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_NOC_NSP_DYNM, "divider_noc_nsp_div_dynm",
+		    "fixed_rate_clk_spll2_fout1", 0,
+		    EIC7700_REG_OFFSET_NOC_CTRL, 0, 3, CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_BOOTSPI_DYNM, "divider_bootspi_div_dynm",
+		    "gate_clk_spll0_fout2", 0, EIC7700_REG_OFFSET_BOOTSPI_CTRL,
+		    4, 6, CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_SCPU_CORE_DYNM,
+		    "divider_scpu_core_div_dynm", "fixed_rate_clk_spll0_fout1",
+		    0, EIC7700_REG_OFFSET_SCPU_CORE_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_LPCPU_CORE_DYNM,
+		    "divider_lpcpu_core_div_dynm", "fixed_rate_clk_spll0_fout1",
+		    0, EIC7700_REG_OFFSET_LPCPU_CORE_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_GPU_ACLK_DYNM, "divider_gpu_aclk_div_dynm",
+		    "fixed_rate_clk_spll0_fout1", 0,
+		    EIC7700_REG_OFFSET_GPU_ACLK_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_D2D_ACLK_DYNM, "divider_d2d_aclk_div_dynm",
+		    "mux_d2d_aclk_root_2mux1_gfree", 0,
+		    EIC7700_REG_OFFSET_D2D_ACLK_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_DSP_ACLK_DYNM, "divider_dsp_aclk_div_dynm",
+		    "mux_d2d_aclk_root_2mux1_gfree", 0,
+		    EIC7700_REG_OFFSET_D2D_ACLK_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_DDR_ACLK_DYNM, "divider_ddr_aclk_div_dynm",
+		    "mux_ddr_aclk_root_2mux1_gfree", 0,
+		    EIC7700_REG_OFFSET_DDR_CTRL, 20, 4, CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_HSP_ACLK_DYNM, "divider_hsp_aclk_div_dynm",
+		    "fixed_rate_clk_spll0_fout1", 0,
+		    EIC7700_REG_OFFSET_HSP_ACLK_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_ETH_TXCLK_DYNM_0,
+		    "divider_eth_txclk_div_dynm_0", "mux_eth_core_2mux1", 0,
+		    EIC7700_REG_OFFSET_ETH0_CTRL, 4, 7, CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_ETH_TXCLK_DYNM_1,
+		    "divider_eth_txclk_div_dynm_1", "mux_eth_core_2mux1", 0,
+		    EIC7700_REG_OFFSET_ETH1_CTRL, 4, 7, CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_MSHC_CORE_DYNM_0,
+		    "divider_mshc_core_div_dynm_0", "mux_mshcore_root_3mux1_0",
+		    0, EIC7700_REG_OFFSET_MSHC0_CORE_CTRL, 4, 12,
+		    CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST),
+	EIC7700_DIV(EIC7700_CLK_DIV_MSHC_CORE_DYNM_1,
+		    "divider_mshc_core_div_dynm_1", "mux_mshcore_root_3mux1_1",
+		    0, EIC7700_REG_OFFSET_MSHC1_CORE_CTRL, 4, 12,
+		    CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST),
+	EIC7700_DIV(EIC7700_CLK_DIV_MSHC_CORE_DYNM_2,
+		    "divider_mshc_core_div_dynm_2", "mux_mshcore_root_3mux1_2",
+		    0, EIC7700_REG_OFFSET_MSHC2_CORE_CTRL, 4, 12,
+		    CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST),
+	EIC7700_DIV(EIC7700_CLK_DIV_PCIE_ACLK_DYNM,
+		    "divider_pcie_aclk_div_dynm", "fixed_rate_clk_spll2_fout2",
+		    0, EIC7700_REG_OFFSET_PCIE_ACLK_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_NPU_ACLK_DYNM, "divider_npu_aclk_div_dynm",
+		    "fixed_rate_clk_spll0_fout1", 0,
+		    EIC7700_REG_OFFSET_NPU_ACLK_CTRL, 4,  4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_NPU_LLC_SRC0_DYNM,
+		    "divider_npu_llc_src0_div_dynm",
+		    "fixed_rate_clk_spll0_fout1", 0,
+		    EIC7700_REG_OFFSET_NPU_LLC_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_NPU_LLC_SRC1_DYNM,
+		    "divider_npu_llc_src1_div_dynm",
+		    "fixed_rate_clk_spll2_fout1", 0,
+		    EIC7700_REG_OFFSET_NPU_LLC_CTRL, 8, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_NPU_CORECLK_DYNM,
+		    "divider_npu_coreclk_div_dynm", "mux_npu_core_3mux1_gfree",
+		    0, EIC7700_REG_OFFSET_NPU_CORE_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_NPU_E31_DYNM, "divider_npu_e31_div_dynm",
+		    "mux_npu_e31_3mux1_gfree", 0,
+		    EIC7700_REG_OFFSET_NPU_CORE_CTRL, 12, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VI_ACLK_DYNM, "divider_vi_aclk_div_dynm",
+		    "mux_vi_aclk_root_2mux1_gfree", 0,
+		    EIC7700_REG_OFFSET_VI_ACLK_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VI_DW_DYNM, "divider_vi_dw_div_dynm",
+		    "mux_vi_dw_root_2mux1", 0,
+		    EIC7700_REG_OFFSET_VI_DWCLK_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VI_DVP_DYNM, "divider_vi_dvp_div_dynm",
+		    "mux_vi_dvp_root_2mux1_gfree", 0,
+		    EIC7700_REG_OFFSET_VI_DVP_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VI_DIG_ISP_DYNM,
+		    "divider_vi_dig_isp_div_dynm",
+		    "mux_vi_dig_isp_root_2mux1_gfree", 0,
+		    EIC7700_REG_OFFSET_VI_DIG_ISP_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VI_SHUTTER_DYNM_0,
+		    "divider_vi_shutter_div_dynm_0",
+		    "fixed_rate_clk_vpll_fout2", 0,
+		    EIC7700_REG_OFFSET_VI_SHUTTER0, 4, 7,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VI_SHUTTER_DYNM_1,
+		    "divider_vi_shutter_div_dynm_1",
+		    "fixed_rate_clk_vpll_fout2", 0,
+		    EIC7700_REG_OFFSET_VI_SHUTTER1, 4, 7,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VI_SHUTTER_DYNM_2,
+		    "divider_vi_shutter_div_dynm_2",
+		    "fixed_rate_clk_vpll_fout2", 0,
+		    EIC7700_REG_OFFSET_VI_SHUTTER2, 4, 7,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VI_SHUTTER_DYNM_3,
+		    "divider_vi_shutter_div_dynm_3",
+		    "fixed_rate_clk_vpll_fout2", 0,
+		    EIC7700_REG_OFFSET_VI_SHUTTER3, 4, 7,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VI_SHUTTER_DYNM_4,
+		    "divider_vi_shutter_div_dynm_4",
+		    "fixed_rate_clk_vpll_fout2", 0,
+		    EIC7700_REG_OFFSET_VI_SHUTTER4, 4, 7,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VI_SHUTTER_DYNM_5,
+		    "divider_vi_shutter_div_dynm_5",
+		    "fixed_rate_clk_vpll_fout2", 0,
+		    EIC7700_REG_OFFSET_VI_SHUTTER5, 4, 7,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VO_ACLK_DYNM, "divider_vo_aclk_div_dynm",
+		    "mux_vo_aclk_root_2mux1_gfree", 0,
+		    EIC7700_REG_OFFSET_VO_ACLK_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_IESMCLK_DYNM, "divider_iesmclk_div_dynm",
+		    "fixed_rate_clk_spll0_fout3", 0,
+		    EIC7700_REG_OFFSET_VO_IESMCLK_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VO_PIXEL_DYNM, "divider_vo_pixel_div_dynm",
+		    "mux_vo_pixel_root_2mux1", 0,
+		    EIC7700_REG_OFFSET_VO_PIXEL_CTRL, 4, 6,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VO_MCLK_DYNM, "divider_vo_mclk_div_dynm",
+		    "clk_apll_fout1", 0, EIC7700_REG_OFFSET_VO_MCLK_CTRL, 4, 8,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VO_CEC_DYNM, "divider_vo_cec_div_dynm",
+		    "fixed_rate_clk_vpll_fout2", 0,
+		    EIC7700_REG_OFFSET_VO_PHY_CLKCTRL, 16, 16,
+		    CLK_DIVIDER_ROUND_CLOSEST),
+	EIC7700_DIV(EIC7700_CLK_DIV_VC_ACLK_DYNM, "divider_vc_aclk_div_dynm",
+		    "mux_vcaclk_root_2mux1_gfree", 0,
+		    EIC7700_REG_OFFSET_VC_ACLK_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_JD_DYNM, "divider_jd_div_dynm",
+		    "mux_vcdec_root_2mux1_gfree", 0, EIC7700_REG_OFFSET_JD_CTRL,
+		    4, 4, CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_JE_DYNM, "divider_je_div_dynm",
+		    "mux_vcdec_root_2mux1_gfree", 0, EIC7700_REG_OFFSET_JE_CTRL,
+		    4, 4, CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VE_DYNM, "divider_ve_div_dynm",
+		    "mux_vcdec_root_2mux1_gfree", 0, EIC7700_REG_OFFSET_VE_CTRL,
+		    4, 4, CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_VD_DYNM, "divider_vd_div_dynm",
+		    "mux_vcdec_root_2mux1_gfree", 0, EIC7700_REG_OFFSET_VD_CTRL,
+		    4, 4, CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_G2D_DYNM, "divider_g2d_div_dynm",
+		    "mux_dsp_aclk_root_2mux1_gfree", 0,
+		    EIC7700_REG_OFFSET_G2D_CTRL, 4, 4, CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_AONDMA_AXI_DYNM,
+		    "divider_aondma_axi_div_dynm", "fixed_rate_clk_spll0_fout1",
+		    0, EIC7700_REG_OFFSET_AON_DMA_CTRL, 4, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_CRYPTO_DYNM, "divider_crypto_div_dynm",
+		    "fixed_rate_clk_spll0_fout1", 0,
+		    EIC7700_REG_OFFSET_SPACC_CTRL, 4, 4, CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_SATA_PHY_REF_DYNM,
+		    "divider_sata_phy_ref_div_dynm",
+		    "fixed_rate_clk_spll1_fout2", 0,
+		    EIC7700_REG_OFFSET_SATA_OOB_CTRL, 0, 4,
+		    CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_DSP_0_ACLK_DYNM,
+		    "divider_dsp_0_aclk_div_dynm", "gate_dspt_aclk", 0,
+		    EIC7700_REG_OFFSET_DSP_CFG_CTRL, 19, 1, 0),
+	EIC7700_DIV(EIC7700_CLK_DIV_DSP_1_ACLK_DYNM,
+		    "divider_dsp_1_aclk_div_dynm", "gate_dspt_aclk", 0,
+		    EIC7700_REG_OFFSET_DSP_CFG_CTRL, 20, 1, 0),
+	EIC7700_DIV(EIC7700_CLK_DIV_DSP_2_ACLK_DYNM,
+		    "divider_dsp_2_aclk_div_dynm", "gate_dspt_aclk", 0,
+		    EIC7700_REG_OFFSET_DSP_CFG_CTRL, 21, 1, 0),
+	EIC7700_DIV(EIC7700_CLK_DIV_DSP_3_ACLK_DYNM,
+		    "divider_dsp_3_aclk_div_dynm", "gate_dspt_aclk", 0,
+		    EIC7700_REG_OFFSET_DSP_CFG_CTRL, 22, 1, 0),
+	EIC7700_DIV(EIC7700_CLK_DIV_AON_RTC_DYNM, "divider_aon_rtc_div_dynm",
+		    "fixed_factor_clk_1m_div24", 0, EIC7700_REG_OFFSET_RTC_CTRL,
+		    21, 11, CLK_DIVIDER_ONE_BASED),
+	EIC7700_DIV(EIC7700_CLK_DIV_U84_RTC_TOGGLE_DYNM,
+		    "divider_u84_rtc_toggle_dynm", "xtal24m", 0,
+		    EIC7700_REG_OFFSET_RTC_CTRL, 16, 5,
+		    CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST),
+};
+
+/* gate clocks */
+static struct eswin_gate_clock eic7700_gate_clks[] = {
+	EIC7700_GATE(EIC7700_CLK_GATE_CPU_EXT_SRC_CORE_CLK_0,
+		     "gate_clk_cpu_ext_src_core_clk_0",
+		     "mux_cpu_root_3mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_U84_CTRL, 28, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_CPU_EXT_SRC_CORE_CLK_1,
+		     "gate_clk_cpu_ext_src_core_clk_1",
+		     "mux_cpu_root_3mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_U84_CTRL, 29, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_CPU_EXT_SRC_CORE_CLK_2,
+		     "gate_clk_cpu_ext_src_core_clk_2",
+		     "mux_cpu_root_3mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_U84_CTRL, 30, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_CPU_EXT_SRC_CORE_CLK_3,
+		     "gate_clk_cpu_ext_src_core_clk_3",
+		     "mux_cpu_root_3mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_U84_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_CPU_TRACE_CLK_0,
+		     "gate_clk_cpu_trace_clk_0", "mux_cpu_root_3mux1_gfree",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_U84_CTRL, 24, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_CPU_TRACE_CLK_1,
+		     "gate_clk_cpu_trace_clk_1", "mux_cpu_root_3mux1_gfree",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_U84_CTRL, 25, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_CPU_TRACE_CLK_2,
+		     "gate_clk_cpu_trace_clk_2", "mux_cpu_root_3mux1_gfree",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_U84_CTRL, 26, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_CPU_TRACE_CLK_3,
+		     "gate_clk_cpu_trace_clk_3", "mux_cpu_root_3mux1_gfree",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_U84_CTRL, 27, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_CPU_TRACE_COM_CLK,
+		     "gate_clk_cpu_trace_com_clk", "mux_cpu_aclk_2mux1_gfree",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_U84_CTRL, 23, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_SPLL0_FOUT2, "gate_clk_spll0_fout2",
+		     "fixed_rate_clk_spll0_fout2", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_SPLL0_CFG_2, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_NOC_NSP_CLK, "gate_noc_nsp_clk",
+		     "divider_noc_nsp_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_NOC_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_BOOTSPI, "gate_clk_bootspi",
+		     "mux_bootspi_clk_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_BOOTSPI_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_BOOTSPI_CFG, "gate_clk_bootspi_cfg",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_BOOTSPI_CFGCLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_SCPU_CORE, "gate_clk_scpu_core",
+		     "mux_scpu_core_clk_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_SCPU_CORE_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_SCPU_BUS, "gate_clk_scpu_bus",
+		     "fixed_factor_scpu_bus_div2", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_SCPU_BUSCLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LPCPU_CORE, "gate_clk_lpcpu_core",
+		     "mux_lpcpu_core_clk_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LPCPU_CORE_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LPCPU_BUS, "gate_clk_lpcpu_bus",
+		     "fixed_factor_lpcpu_bus_div2", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LPCPU_BUSCLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_GPU_ACLK, "gate_gpu_aclk",
+		     "divider_gpu_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_GPU_ACLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_GPU_GRAY_CLK, "gate_gpu_gray_clk",
+		     "xtal24m", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_GPU_GRAY_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_GPU_CFG_CLK, "gate_gpu_cfg_clk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_GPU_CFG_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_DSPT_ACLK, "gate_dspt_aclk",
+		     "divider_dsp_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_DSP_ACLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_DSPT_CFG_CLK, "gate_dspt_cfg_clk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_DSP_CFG_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_D2D_ACLK, "gate_d2d_aclk",
+		     "divider_d2d_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_D2D_ACLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_D2D_CFG_CLK, "gate_d2d_cfg_clk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_D2D_CFG_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_TCU_ACLK, "gate_tcu_aclk",
+		     "divider_ddr_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_TCU_ACLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_TCU_CFG_CLK, "gate_tcu_cfg_clk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_TCU_CFG_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_DDRT_CFG_CLK, "gate_ddrt_cfg_clk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_DDR_CTRL, 9, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_DDRT0_P0_ACLK, "gate_ddrt0_p0_aclk",
+		     "divider_ddr_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_DDR_CTRL, 4, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_DDRT0_P1_ACLK, "gate_ddrt0_p1_aclk",
+		     "divider_ddr_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_DDR_CTRL, 5, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_DDRT0_P2_ACLK, "gate_ddrt0_p2_aclk",
+		     "divider_ddr_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_DDR_CTRL, 6, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_DDRT0_P3_ACLK, "gate_ddrt0_p3_aclk",
+		     "divider_ddr_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_DDR_CTRL, 7, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_DDRT0_P4_ACLK, "gate_ddrt0_p4_aclk",
+		     "divider_ddr_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_DDR_CTRL, 8, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_DDRT1_P0_ACLK, "gate_ddrt1_p0_aclk",
+		     "divider_ddr_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_DDR1_CTRL, 4, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_DDRT1_P1_ACLK, "gate_ddrt1_p1_aclk",
+		     "divider_ddr_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_DDR1_CTRL, 5, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_DDRT1_P2_ACLK, "gate_ddrt1_p2_aclk",
+		     "divider_ddr_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_DDR1_CTRL, 6, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_DDRT1_P3_ACLK, "gate_ddrt1_p3_aclk",
+		     "divider_ddr_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_DDR1_CTRL, 7, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_DDRT1_P4_ACLK, "gate_ddrt1_p4_aclk",
+		     "divider_ddr_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_DDR1_CTRL, 8, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_HSP_ACLK, "gate_clk_hsp_aclk",
+		     "divider_hsp_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_HSP_ACLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_HSP_CFG_CLK, "gate_clk_hsp_cfg_clk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_HSP_CFG_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_PCIET_ACLK, "gate_pciet_aclk",
+		     "divider_pcie_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_PCIE_ACLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_PCIET_CFG_CLK, "gate_pciet_cfg_clk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_PCIE_CFG_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_PCIET_CR_CLK, "gate_pciet_cr_clk",
+		     "fixed_factor_pcie_cr_div2", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_PCIE_CFG_CTRL, 0, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_PCIET_AUX_CLK, "gate_pciet_aux_clk",
+		     "fixed_factor_pcie_aux_div4", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_PCIE_CFG_CTRL, 1, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_NPU_ACLK, "gate_npu_aclk",
+		     "divider_npu_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_NPU_ACLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_NPU_CFG_CLK, "gate_npu_cfg_clk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_NPU_ACLK_CTRL, 30, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_NPU_LLC_ACLK, "gate_npu_llc_aclk",
+		     "mux_npu_llclk_3mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_NPU_LLC_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_NPU_CLK, "gate_npu_clk",
+		     "divider_npu_coreclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_NPU_CORE_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_NPU_E31_CLK, "gate_npu_e31_clk",
+		     "divider_npu_e31_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_NPU_CORE_CTRL, 30, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VI_ACLK, "gate_vi_aclk",
+		     "divider_vi_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VI_ACLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VI_CFG_CLK, "gate_vi_cfg_clk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VI_ACLK_CTRL, 30, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VI_DIG_DW_CLK, "gate_vi_dig_dw_clk",
+		     "divider_vi_dw_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VI_DWCLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VI_DVP_CLK, "gate_vi_dvp_clk",
+		     "divider_vi_dvp_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VI_DVP_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VI_DIG_ISP_CLK, "gate_vi_dig_isp_clk",
+		     "divider_vi_dig_isp_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VI_DIG_ISP_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VI_SHUTTER_0, "gate_vi_shutter_0",
+		     "divider_vi_shutter_div_dynm_0", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VI_SHUTTER0, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VI_SHUTTER_1, "gate_vi_shutter_1",
+		     "divider_vi_shutter_div_dynm_1", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VI_SHUTTER1, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VI_SHUTTER_2, "gate_vi_shutter_2",
+		     "divider_vi_shutter_div_dynm_2", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VI_SHUTTER2, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VI_SHUTTER_3, "gate_vi_shutter_3",
+		     "divider_vi_shutter_div_dynm_3", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VI_SHUTTER3, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VI_SHUTTER_4, "gate_vi_shutter_4",
+		     "divider_vi_shutter_div_dynm_4", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VI_SHUTTER4, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VI_SHUTTER_5, "gate_vi_shutter_5",
+		     "divider_vi_shutter_div_dynm_5", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VI_SHUTTER5, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VI_PHY_TXCLKESC, "gate_vi_phy_txclkesc",
+		     "fixed_factor_mipi_txesc_div10", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VI_PHY_CTRL, 0, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VI_PHY_CFG, "gate_vi_phy_cfg", "xtal24m",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_VI_PHY_CTRL, 1, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VO_ACLK, "gate_vo_aclk",
+		     "divider_vo_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VO_ACLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VO_CFG_CLK, "gate_vo_cfg_clk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VO_ACLK_CTRL, 30, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VO_HDMI_IESMCLK, "gate_vo_hdmi_iesmclk",
+		     "divider_iesmclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VO_IESMCLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VO_PIXEL_CLK, "gate_vo_pixel_clk",
+		     "divider_vo_pixel_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VO_PIXEL_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VO_I2S_MCLK, "gate_vo_i2s_mclk",
+		     "mux_vo_mclk_2mux_ext_mclk", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VO_MCLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VO_CR_CLK, "gate_vo_cr_clk",
+		     "fixed_factor_mipi_txesc_div10", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VO_PHY_CLKCTRL, 1, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VC_ACLK, "gate_vc_aclk",
+		     "divider_vc_aclk_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VC_ACLK_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VC_CFG_CLK, "gate_vc_cfg_clk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VC_CLKEN_CTRL, 0, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VC_JE_CLK, "gate_vc_je_clk",
+		     "divider_je_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_JE_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VC_JD_CLK, "gate_vc_jd_clk",
+		     "divider_jd_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_JD_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VC_VE_CLK, "gate_vc_ve_clk",
+		     "divider_ve_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VE_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VC_VD_CLK, "gate_vc_vd_clk",
+		     "divider_vd_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VD_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_G2D_CFG_CLK, "gate_g2d_cfg_clk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_G2D_CTRL, 28, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_G2D_CLK, "gate_g2d_clk",
+		     "divider_g2d_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_G2D_CTRL, 30, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_G2D_ACLK, "gate_g2d_aclk",
+		     "divider_g2d_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_G2D_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_AONDMA_CFG, "gate_clk_aondma_cfg",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_AON_DMA_CTRL, 30, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_AONDMA_ACLK, "gate_aondma_aclk",
+		     "mux_aondma_axi2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_AON_DMA_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_AON_ACLK, "gate_aon_aclk",
+		     "mux_aondma_axi2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_AON_DMA_CTRL, 29, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_TIMER_CLK_0, "gate_time_clk_0", "xtal24m",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_TIMER_CTRL, 0, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_TIMER_CLK_1, "gate_time_clk_1", "xtal24m",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_TIMER_CTRL, 1, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_TIMER_CLK_2, "gate_time_clk_2", "xtal24m",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_TIMER_CTRL, 2, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_TIMER_CLK_3, "gate_time_clk_3", "xtal24m",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_TIMER_CTRL, 3, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_TIMER_PCLK_0, "gate_timer_pclk_0",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_TIMER_CTRL, 4, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_TIMER_PCLK_1, "gate_timer_pclk_1",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_TIMER_CTRL, 5, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_TIMER_PCLK_2, "gate_timer_pclk_2",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_TIMER_CTRL, 6, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_TIMER_PCLK_3, "gate_timer_pclk_3",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_TIMER_CTRL, 7, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_TIMER3_CLK8, "gate_timer3_clk8",
+		     "fixed_rate_clk_vpll_fout3", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_TIMER_CTRL, 8, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_RTC_CFG, "gate_clk_rtc_cfg",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_RTC_CTRL, 2, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_RTC, "gate_clk_rtc",
+		     "divider_aon_rtc_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_RTC_CTRL, 1, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_PKA_CFG, "gate_clk_pka_cfg",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_PKA_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_SPACC_CFG, "gate_clk_spacc_cfg",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_SPACC_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_CRYPTO, "gate_clk_crypto",
+		     "divider_crypto_div_dynm", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_SPACC_CTRL, 30, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_TRNG_CFG, "gate_clk_trng_cfg",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_TRNG_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_OTP_CFG, "gate_clk_otp_cfg",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_OTP_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_0, "gate_clk_mailbox_0",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 0, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_1, "gate_clk_mailbox_1",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 1, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_2, "gate_clk_mailbox_2",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 2, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_3, "gate_clk_mailbox_3",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 3, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_4, "gate_clk_mailbox_4",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 4, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_5, "gate_clk_mailbox_5",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 5, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_6, "gate_clk_mailbox_6",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 6, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_7, "gate_clk_mailbox_7",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 7, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_8, "gate_clk_mailbox_8",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 8, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_9, "gate_clk_mailbox_9",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 9, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_10, "gate_clk_mailbox_10",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 10, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_11, "gate_clk_mailbox_11",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 11, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_12, "gate_clk_mailbox_12",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 12, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_13, "gate_clk_mailbox_13",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 13, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_14, "gate_clk_mailbox_14",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 14, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_MAILBOX_15, "gate_clk_mailbox_15",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 15, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_I2C0_PCLK, "gate_i2c0_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 7, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_I2C1_PCLK, "gate_i2c1_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 8, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_I2C2_PCLK, "gate_i2c2_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 9, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_I2C3_PCLK, "gate_i2c3_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 10, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_I2C4_PCLK, "gate_i2c4_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 11, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_I2C5_PCLK, "gate_i2c5_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 12, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_I2C6_PCLK, "gate_i2c6_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 13, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_I2C7_PCLK, "gate_i2c7_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 14, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_I2C8_PCLK, "gate_i2c8_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 15, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_I2C9_PCLK, "gate_i2c9_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 16, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_WDT0_PCLK, "gate_lsp_wdt0_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 28, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_WDT1_PCLK, "gate_lsp_wdt1_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 29, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_WDT2_PCLK, "gate_lsp_wdt2_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 30, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_WDT3_PCLK, "gate_lsp_wdt3_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_SSI0_PCLK, "gate_lsp_ssi0_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 26, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_SSI1_PCLK, "gate_lsp_ssi1_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 27, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_UART0_PCLK, "gate_lsp_uart0_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 17, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_UART1_PCLK, "gate_lsp_uart1_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 18, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_UART2_PCLK, "gate_lsp_uart2_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 19, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_UART3_PCLK, "gate_lsp_uart3_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 20, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_UART4_PCLK, "gate_lsp_uart4_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 21, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_TIMER_PCLK, "gate_lsp_timer_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 25, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_FAN_PCLK, "gate_lsp_fan_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 0, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_PVT_PCLK, "gate_lsp_pvt_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN0, 1, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_PVT0_CLK, "gate_pvt0_clk",
+		     "fixed_factor_pvt_div20", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 16, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_LSP_PVT1_CLK, "gate_pvt1_clk",
+		     "fixed_factor_pvt_div20", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_LSP_EN1, 17, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VC_JE_PCLK, "gate_vc_je_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VC_CLKEN_CTRL, 2, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VC_JD_PCLK, "gate_vc_jd_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VC_CLKEN_CTRL, 1, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VC_VE_PCLK, "gate_vc_ve_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VC_CLKEN_CTRL, 5, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VC_VD_PCLK, "gate_vc_vd_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VC_CLKEN_CTRL, 4, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_VC_MON_PCLK, "gate_vc_mon_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_VC_CLKEN_CTRL, 3, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_HSP_MSHC0_CORE_CLK,
+		     "gate_hsp_mshc0_core_clk", "divider_mshc_core_div_dynm_0",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_MSHC0_CORE_CTRL,
+		     16, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_HSP_MSHC1_CORE_CLK,
+		     "gate_hsp_mshc1_core_clk", "divider_mshc_core_div_dynm_1",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_MSHC1_CORE_CTRL,
+		     16, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_HSP_MSHC2_CORE_CLK,
+		     "gate_hsp_mshc2_core_clk", "divider_mshc_core_div_dynm_2",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_MSHC2_CORE_CTRL,
+		     16, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_HSP_SATA_RBC_CLK, "gate_hsp_sata_rbc_clk",
+		     "fixed_rate_clk_spll1_fout2", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_SATA_RBC_CTRL, 0, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_HSP_SATA_OOB_CLK, "gate_hsp_sata_oob_clk",
+		     "mux_sata_phy_2mux1", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_SATA_OOB_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_HSP_DMA0_CLK_TEST,
+		     "gate_hsp_dma0_clk_test", "gate_clk_hsp_aclk",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_HSP_ACLK_CTRL, 1,
+		     0),
+	EIC7700_GATE(EIC7700_CLK_GATE_HSP_DMA0_CLK, "gate_hsp_dma0_clk",
+		     "gate_clk_hsp_aclk", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_HSP_ACLK_CTRL, 0, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_HSP_ETH0_CORE_CLK,
+		     "gate_hsp_eth0_core_clk", "divider_eth_txclk_div_dynm_0",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_ETH0_CTRL, 0, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_HSP_ETH1_CORE_CLK,
+		     "gate_hsp_eth1_core_clk", "divider_eth_txclk_div_dynm_1",
+		     CLK_SET_RATE_PARENT, EIC7700_REG_OFFSET_ETH1_CTRL, 0, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_HSP_RMII_REF_0, "gate_hsp_rmii_ref_0",
+		     "mux_rmii_ref_2mux1", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_ETH0_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_HSP_RMII_REF_1, "gate_hsp_rmii_ref_1",
+		     "mux_rmii_ref_2mux1", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_ETH1_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_AON_I2C0_PCLK, "gate_aon_i2c0_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_I2C0_CTRL, 31, 0),
+	EIC7700_GATE(EIC7700_CLK_GATE_AON_I2C1_PCLK, "gate_aon_i2c1_pclk",
+		     "mux_syscfg_clk_root_2mux1_gfree", CLK_SET_RATE_PARENT,
+		     EIC7700_REG_OFFSET_I2C1_CTRL, 31, 0),
+};
+
+static int eic7700_clk_probe(struct platform_device *pdev)
+{
+	struct eswin_clock_data *clk_data;
+	struct device *dev = &pdev->dev;
+
+	clk_data = eswin_clk_init(dev, EIC7700_NR_CLKS);
+	if (!clk_data)
+		return dev_err_probe(dev, -EAGAIN, "failed to get clk data!\n");
+
+	eswin_clk_register_fixed_rate(eic7700_fixed_rate_clks,
+				      ARRAY_SIZE(eic7700_fixed_rate_clks),
+				      clk_data, dev);
+
+	eswin_clk_register_pll(eic7700_pll_clks, ARRAY_SIZE(eic7700_pll_clks),
+			       clk_data, dev);
+
+	eswin_clk_register_fixed_factor(eic7700_fixed_factor_clks,
+					ARRAY_SIZE(eic7700_fixed_factor_clks),
+					clk_data, dev);
+
+	eswin_clk_register_mux(eic7700_mux_clks, ARRAY_SIZE(eic7700_mux_clks),
+			       clk_data, dev);
+
+	eswin_clk_register_divider(eic7700_div_clks,
+				   ARRAY_SIZE(eic7700_div_clks), clk_data, dev);
+
+	eswin_clk_register_gate(eic7700_gate_clks,
+				ARRAY_SIZE(eic7700_gate_clks), clk_data, dev);
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   &clk_data->clk_data);
+}
+
+static const struct of_device_id eic7700_clock_dt_ids[] = {
+	{ .compatible = "eswin,eic7700-clock", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, eic7700_clock_dt_ids);
+
+static struct platform_driver eic7700_clock_driver = {
+	.probe	= eic7700_clk_probe,
+	.driver = {
+		.name	= "eic7700-clock",
+		.of_match_table	= eic7700_clock_dt_ids,
+	},
+};
+module_platform_driver(eic7700_clock_driver);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yifeng Huang<huangyifeng@eswincomputing.com>");
+MODULE_AUTHOR("Xuyang Dong<dongxuyang@eswincomputing.com>");
+MODULE_DESCRIPTION("ESWIN EIC7700 clock controller driver");
diff --git a/drivers/clk/eswin/clk-eic7700.h b/drivers/clk/eswin/clk-eic7700.h
new file mode 100644
index 000000000000..625b12306aa3
--- /dev/null
+++ b/drivers/clk/eswin/clk-eic7700.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd..
+ * All rights reserved.
+ *
+ * Authors:
+ *	Yifeng Huang <huangyifeng@eswincomputing.com>
+ *	xuyang Dong <dongxuyang@eswincomputing.com>
+ */
+
+#ifndef __CLK_EIC7700_H__
+#define __CLK_EIC7700_H__
+
+/* REG OFFSET OF SYS-CRG */
+#define EIC7700_REG_OFFSET_SPLL0_CFG_0		0x0
+#define EIC7700_REG_OFFSET_SPLL0_CFG_1		0x4
+#define EIC7700_REG_OFFSET_SPLL0_CFG_2		0x8
+#define EIC7700_REG_OFFSET_SPLL0_DSKEWCAL	0xC
+#define EIC7700_REG_OFFSET_SPLL0_SSC		0x10
+#define EIC7700_REG_OFFSET_SPLL1_CFG_0		0x14
+#define EIC7700_REG_OFFSET_SPLL1_CFG_1		0x18
+#define EIC7700_REG_OFFSET_SPLL1_CFG_2		0x1C
+#define EIC7700_REG_OFFSET_SPLL1_DSKEWCAL	0x20
+#define EIC7700_REG_OFFSET_SPLL1_SSC		0x24
+#define EIC7700_REG_OFFSET_SPLL2_CFG_0		0x28
+#define EIC7700_REG_OFFSET_SPLL2_CFG_1		0x2C
+#define EIC7700_REG_OFFSET_SPLL2_CFG_2		0x30
+#define EIC7700_REG_OFFSET_SPLL2_DSKEWCAL	0x34
+#define EIC7700_REG_OFFSET_SPLL2_SSC		0x38
+#define EIC7700_REG_OFFSET_VPLL_CFG_0		0x3C
+#define EIC7700_REG_OFFSET_VPLL_CFG_1		0x40
+#define EIC7700_REG_OFFSET_VPLL_CFG_2		0x44
+#define EIC7700_REG_OFFSET_VPLL_DSKEWCAL	0x48
+#define EIC7700_REG_OFFSET_VPLL_SSC		0x4C
+#define EIC7700_REG_OFFSET_APLL_CFG_0		0x50
+#define EIC7700_REG_OFFSET_APLL_CFG_1		0x54
+#define EIC7700_REG_OFFSET_APLL_CFG_2		0x58
+#define EIC7700_REG_OFFSET_APLL_DSKEWCAL	0x5C
+#define EIC7700_REG_OFFSET_APLL_SSC		0x60
+#define EIC7700_REG_OFFSET_MCPUT_PLL_CFG_0	0x64
+#define EIC7700_REG_OFFSET_MCPUT_PLL_CFG_1	0x68
+#define EIC7700_REG_OFFSET_MCPUT_PLL_CFG_2	0x6C
+#define EIC7700_REG_OFFSET_MCPUT_PLL_DSKEWCAL	0x70
+#define EIC7700_REG_OFFSET_MCPUT_PLL_SSC	0x74
+#define EIC7700_REG_OFFSET_DDRT_PLL_CFG_0	0x78
+#define EIC7700_REG_OFFSET_DDRT_PLL_CFG_1	0x7C
+#define EIC7700_REG_OFFSET_DDRT_PLL_CFG_2	0x80
+#define EIC7700_REG_OFFSET_DDRT_PLL_DSKEWCAL	0x84
+#define EIC7700_REG_OFFSET_DDRT_PLL_SSC		0x88
+#define EIC7700_REG_OFFSET_PLL_STATUS		0xA4
+#define EIC7700_REG_OFFSET_NOC_CTRL		0x100
+#define EIC7700_REG_OFFSET_BOOTSPI_CTRL		0x104
+#define EIC7700_REG_OFFSET_BOOTSPI_CFGCLK_CTRL	0x108
+#define EIC7700_REG_OFFSET_SCPU_CORE_CTRL	0x10C
+#define EIC7700_REG_OFFSET_SCPU_BUSCLK_CTRL	0x110
+#define EIC7700_REG_OFFSET_LPCPU_CORE_CTRL	0x114
+#define EIC7700_REG_OFFSET_LPCPU_BUSCLK_CTRL	0x118
+#define EIC7700_REG_OFFSET_TCU_ACLK_CTRL	0x11C
+#define EIC7700_REG_OFFSET_TCU_CFG_CTRL		0x120
+#define EIC7700_REG_OFFSET_DDR_CTRL		0x124
+#define EIC7700_REG_OFFSET_DDR1_CTRL		0x128
+#define EIC7700_REG_OFFSET_GPU_ACLK_CTRL	0x12C
+#define EIC7700_REG_OFFSET_GPU_CFG_CTRL		0x130
+#define EIC7700_REG_OFFSET_GPU_GRAY_CTRL	0x134
+#define EIC7700_REG_OFFSET_DSP_ACLK_CTRL	0x138
+#define EIC7700_REG_OFFSET_DSP_CFG_CTRL		0x13C
+#define EIC7700_REG_OFFSET_D2D_ACLK_CTRL	0x140
+#define EIC7700_REG_OFFSET_D2D_CFG_CTRL		0x144
+#define EIC7700_REG_OFFSET_HSP_ACLK_CTRL	0x148
+#define EIC7700_REG_OFFSET_HSP_CFG_CTRL		0x14C
+#define EIC7700_REG_OFFSET_SATA_RBC_CTRL	0x150
+#define EIC7700_REG_OFFSET_SATA_OOB_CTRL	0x154
+#define EIC7700_REG_OFFSET_ETH0_CTRL		0x158
+#define EIC7700_REG_OFFSET_ETH1_CTRL		0x15C
+#define EIC7700_REG_OFFSET_MSHC0_CORE_CTRL	0x160
+#define EIC7700_REG_OFFSET_MSHC1_CORE_CTRL	0x164
+#define EIC7700_REG_OFFSET_MSHC2_CORE_CTRL	0x168
+#define EIC7700_REG_OFFSET_MSHC_USB_SLWCLK	0x16C
+#define EIC7700_REG_OFFSET_PCIE_ACLK_CTRL	0x170
+#define EIC7700_REG_OFFSET_PCIE_CFG_CTRL	0x174
+#define EIC7700_REG_OFFSET_NPU_ACLK_CTRL	0x178
+#define EIC7700_REG_OFFSET_NPU_LLC_CTRL		0x17C
+#define EIC7700_REG_OFFSET_NPU_CORE_CTRL	0x180
+#define EIC7700_REG_OFFSET_VI_DWCLK_CTRL	0x184
+#define EIC7700_REG_OFFSET_VI_ACLK_CTRL		0x188
+#define EIC7700_REG_OFFSET_VI_DIG_ISP_CTRL	0x18C
+#define EIC7700_REG_OFFSET_VI_DVP_CTRL		0x190
+#define EIC7700_REG_OFFSET_VI_SHUTTER0		0x194
+#define EIC7700_REG_OFFSET_VI_SHUTTER1		0x198
+#define EIC7700_REG_OFFSET_VI_SHUTTER2		0x19C
+#define EIC7700_REG_OFFSET_VI_SHUTTER3		0x1A0
+#define EIC7700_REG_OFFSET_VI_SHUTTER4		0x1A4
+#define EIC7700_REG_OFFSET_VI_SHUTTER5		0x1A8
+#define EIC7700_REG_OFFSET_VI_PHY_CTRL		0x1AC
+#define EIC7700_REG_OFFSET_VO_ACLK_CTRL		0x1B0
+#define EIC7700_REG_OFFSET_VO_IESMCLK_CTRL	0x1B4
+#define EIC7700_REG_OFFSET_VO_PIXEL_CTRL	0x1B8
+#define EIC7700_REG_OFFSET_VO_MCLK_CTRL		0x1BC
+#define EIC7700_REG_OFFSET_VO_PHY_CLKCTRL	0x1C0
+#define EIC7700_REG_OFFSET_VC_ACLK_CTRL		0x1C4
+#define EIC7700_REG_OFFSET_VCDEC_ROOT_CTRL	0x1C8
+#define EIC7700_REG_OFFSET_G2D_CTRL		0x1CC
+#define EIC7700_REG_OFFSET_VC_CLKEN_CTRL	0x1D0
+#define EIC7700_REG_OFFSET_JE_CTRL		0x1D4
+#define EIC7700_REG_OFFSET_JD_CTRL		0x1D8
+#define EIC7700_REG_OFFSET_VD_CTRL		0x1DC
+#define EIC7700_REG_OFFSET_VE_CTRL		0x1E0
+#define EIC7700_REG_OFFSET_AON_DMA_CTRL		0x1E4
+#define EIC7700_REG_OFFSET_TIMER_CTRL		0x1E8
+#define EIC7700_REG_OFFSET_RTC_CTRL		0x1EC
+#define EIC7700_REG_OFFSET_PKA_CTRL		0x1F0
+#define EIC7700_REG_OFFSET_SPACC_CTRL		0x1F4
+#define EIC7700_REG_OFFSET_TRNG_CTRL		0x1F8
+#define EIC7700_REG_OFFSET_OTP_CTRL		0x1FC
+#define EIC7700_REG_OFFSET_LSP_EN0		0x200
+#define EIC7700_REG_OFFSET_LSP_EN1		0x204
+#define EIC7700_REG_OFFSET_U84_CTRL		0x208
+#define EIC7700_REG_OFFSET_SYSCFG_CTRL		0x20C
+#define EIC7700_REG_OFFSET_I2C0_CTRL		0x210
+#define EIC7700_REG_OFFSET_I2C1_CTRL		0x214
+
+#endif /* __CLK_EIC7700_H__ */
diff --git a/drivers/clk/eswin/clk.c b/drivers/clk/eswin/clk.c
new file mode 100644
index 000000000000..92998da98009
--- /dev/null
+++ b/drivers/clk/eswin/clk.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd..
+ * All rights reserved.
+ *
+ * Authors:
+ *	Yifeng Huang <huangyifeng@eswincomputing.com>
+ *	Xuyang Dong <dongxuyang@eswincomputing.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/math.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/eswin,eic7700-clock.h>
+
+#include "clk.h"
+
+struct eswin_clock_data *eswin_clk_init(struct device *dev,
+					int nr_clks)
+{
+	struct eswin_clock_data *eclk_data;
+
+	eclk_data = devm_kzalloc(dev, struct_size(eclk_data, clk_data.hws,
+						  nr_clks), GFP_KERNEL);
+	if (!eclk_data)
+		return NULL;
+
+	eclk_data->base = devm_of_iomap(dev, dev->of_node, 0, NULL);
+	if (IS_ERR(eclk_data->base)) {
+		dev_err(dev, "failed to map clock registers\n");
+		return NULL;
+	}
+
+	eclk_data->clk_data.num = nr_clks;
+	/* Avoid returning NULL for unused id */
+	memset_p((void **)eclk_data->clk_data.hws, ERR_PTR(-ENOENT), nr_clks);
+	spin_lock_init(&eclk_data->lock);
+
+	return eclk_data;
+}
+
+/**
+ * eswin_calc_pll - calculate PLL values
+ * @frac_val: fractional divider
+ * @fbdiv_val: feedback divider
+ * @rate: reference rate
+ * @clk: PLL clock
+ *
+ *   Calculate PLL values for frac and fbdiv
+ */
+static int eswin_calc_pll(u32 *frac_val, u32 *fbdiv_val, u64 rate,
+			  const struct eswin_clk_pll *clk)
+{
+	u64 rem = 0;
+	u32 tmp1 = 0, tmp2 = 0;
+
+	if (clk->id == EIC7700_CLK_APLL_FOUT1 ||
+	    clk->id == EIC7700_CLK_PLL_CPU) {
+		rate = rate * 4;
+		rem = do_div(rate, 1000);
+		if (rem)
+			tmp1 = rem;
+
+		rem = do_div(rate, 1000);
+		if (rem)
+			tmp2 = rem;
+
+		rem = do_div(rate, 24);
+		/* fbdiv = rate * 4 / 24000000 */
+		*fbdiv_val = rate;
+		/* frac = rate * 4 % 24000000 * (2 ^ 24) */
+		*frac_val = (u64)((1000 * (1000 * rem + tmp2) + tmp1) << 24)
+				  / 24 / 1000000;
+	} else {
+		pr_err("Invalid pll set req, rate %lld, clk id %d\n", rate,
+		       clk->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline struct eswin_clk_pll *to_pll_clk(struct clk_hw *hw)
+{
+	return container_of(hw, struct eswin_clk_pll, hw);
+}
+
+static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct eswin_clk_pll *clk = to_pll_clk(hw);
+	struct clk *clk_cpu_lp_pll = NULL;
+	struct clk *clk_cpu_mux = NULL;
+	struct clk *clk_cpu_pll = NULL;
+	u32 postdiv1_val = 0, refdiv_val = 1;
+	u32 frac_val, fbdiv_val, val;
+	bool lock_flag = false;
+	int try_count = 0;
+	int ret;
+
+	ret = eswin_calc_pll(&frac_val,  &fbdiv_val, (u64)rate, clk);
+	if (ret)
+		return ret;
+
+	/* Must switch the CPU to other CLK before we change the CPU PLL. */
+	if (clk->id == EIC7700_CLK_PLL_CPU) {
+		clk_cpu_mux = __clk_lookup("mux_cpu_root_3mux1_gfree");
+		if (!clk_cpu_mux) {
+			pr_err("failed to get clk: %s\n",
+			       "mux_cpu_root_3mux1_gfree");
+			return -EINVAL;
+		}
+
+		clk_cpu_lp_pll = __clk_lookup("fixed_factor_u84_core_lp_div2");
+		if (!clk_cpu_lp_pll) {
+			pr_err("failed to get clk: %s\n",
+			       "fixed_factor_u84_core_lp_div2");
+			return -EINVAL;
+		}
+
+		ret = clk_prepare_enable(clk_cpu_lp_pll);
+		if (ret) {
+			pr_err("failed to enable clk: %s, ret = %d\n",
+			       "fixed_factor_u84_core_lp_div2", ret);
+			return ret;
+		}
+
+		clk_cpu_pll = __clk_lookup("clk_pll_cpu");
+		if (!clk_cpu_pll) {
+			pr_err("failed to get clk: %s\n", "clk_pll_cpu");
+			clk_disable_unprepare(clk_cpu_lp_pll);
+			return -EINVAL;
+		}
+
+		ret = clk_set_parent(clk_cpu_mux, clk_cpu_lp_pll);
+		if (ret) {
+			pr_err("failed to switch %s to %s, ret %d\n",
+			       "mux_cpu_root_3mux1_gfree",
+			       "fixed_factor_u84_core_lp_div2", ret);
+			clk_disable_unprepare(clk_cpu_lp_pll);
+			return -EPERM;
+		}
+	}
+
+	/* First, disable pll */
+	val = readl_relaxed(clk->ctrl_reg0);
+	val &= ~(((1 << clk->pllen_width) - 1) << clk->pllen_shift);
+	val |= 0 << clk->pllen_shift;
+	writel_relaxed(val, clk->ctrl_reg0);
+
+	val = readl_relaxed(clk->ctrl_reg0);
+	val &= ~(((1 << clk->fbdiv_width) - 1) << clk->fbdiv_shift);
+	val &= ~(((1 << clk->refdiv_width) - 1) << clk->refdiv_shift);
+	val |= refdiv_val << clk->refdiv_shift;
+	val |= fbdiv_val << clk->fbdiv_shift;
+	writel_relaxed(val, clk->ctrl_reg0);
+
+	val = readl_relaxed(clk->ctrl_reg1);
+	val &= ~(((1 << clk->frac_width) - 1) << clk->frac_shift);
+	val |= frac_val << clk->frac_shift;
+	writel_relaxed(val, clk->ctrl_reg1);
+
+	val = readl_relaxed(clk->ctrl_reg2);
+	val &= ~(((1 << clk->postdiv1_width) - 1) << clk->postdiv1_shift);
+	val |= postdiv1_val << clk->postdiv1_shift;
+	writel_relaxed(val, clk->ctrl_reg2);
+
+	/* Last, enable pll */
+	val = readl_relaxed(clk->ctrl_reg0);
+	val &= ~(((1 << clk->pllen_width) - 1) << clk->pllen_shift);
+	val |= 1 << clk->pllen_shift;
+	writel_relaxed(val, clk->ctrl_reg0);
+
+	/* Usually the pll will lock in 50us */
+	do {
+		usleep_range(refdiv_val * 80, refdiv_val * 80 * 2);
+		val = readl_relaxed(clk->status_reg);
+		if (val & 1 << clk->lock_shift) {
+			lock_flag = true;
+			break;
+		}
+	} while (try_count++ < 10);
+
+	if (!lock_flag) {
+		pr_err("failed to lock the cpu pll!\n");
+		return -EBUSY;
+	}
+
+	if (clk->id == EIC7700_CLK_PLL_CPU) {
+		ret = clk_set_parent(clk_cpu_mux, clk_cpu_pll);
+		if (ret) {
+			pr_err("failed to switch %s to %s, ret %d\n",
+			       "mux_cpu_root_3mux1_gfree", "clk_pll_cpu", ret);
+			return -EPERM;
+		}
+		clk_disable_unprepare(clk_cpu_lp_pll);
+	}
+
+	return ret;
+}
+
+static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct eswin_clk_pll *clk = to_pll_clk(hw);
+	u64 fbdiv_val, frac_val, rem, tmp;
+	u32 val;
+	u64 rate = 0;
+
+	val = readl_relaxed(clk->ctrl_reg0);
+	val = val >> clk->fbdiv_shift;
+	val &= ((1 << clk->fbdiv_width) - 1);
+	fbdiv_val = val;
+
+	val = readl_relaxed(clk->ctrl_reg1);
+	val = val >> clk->frac_shift;
+	val &= ((1 << clk->frac_width) - 1);
+	frac_val = val;
+
+	/* rate = 24000000 * (fbdiv + frac / (2 ^ 24)) / 4 */
+	if (clk->id == EIC7700_CLK_APLL_FOUT1 ||
+	    clk->id == EIC7700_CLK_PLL_CPU) {
+		tmp = 1000 * frac_val;
+		rem = do_div(tmp, BIT(24));
+		if (rem)
+			rate = (u64)(6000 * (1000 * fbdiv_val + tmp) +
+				    ((6000 * rem) >> 24) + 1);
+		else
+			rate = (u64)(6000 * 1000 * fbdiv_val);
+	} else {
+		pr_err("unknown clk id %d\n", clk->id);
+	}
+
+	return rate;
+}
+
+static int clk_pll_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
+{
+	struct eswin_clk_pll *clk = to_pll_clk(hw);
+
+	switch (clk->id) {
+	case EIC7700_CLK_APLL_FOUT1:
+		req->rate = clamp(req->rate, APLL_LOW_FREQ, APLL_HIGH_FREQ);
+		req->min_rate = APLL_LOW_FREQ;
+		req->max_rate = APLL_HIGH_FREQ;
+		break;
+	case EIC7700_CLK_PLL_CPU:
+		req->rate = clamp(req->rate, PLL_LOW_FREQ, PLL_HIGH_FREQ);
+		req->min_rate = PLL_LOW_FREQ;
+		req->max_rate = PLL_HIGH_FREQ;
+		break;
+	default:
+		pr_err("unknown clk id %d\n", clk->id);
+		break;
+	}
+
+	return 0;
+}
+
+int eswin_clk_register_fixed_rate(const struct eswin_fixed_rate_clock *clks,
+				  int nums, struct eswin_clock_data *data,
+				  struct device *dev)
+{
+	struct clk_hw *clk_hw;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk_hw = devm_clk_hw_register_fixed_rate(dev, clks[i].name,
+							 clks[i].parent_name,
+							 clks[i].flags,
+							 clks[i].rate);
+		if (IS_ERR(clk_hw))
+			return dev_err_probe(dev, PTR_ERR(clk_hw),
+					     "failed to register clock\n");
+
+		data->clk_data.hws[clks[i].id] = clk_hw;
+	}
+
+	return 0;
+}
+
+static const struct clk_ops eswin_clk_pll_ops = {
+	.set_rate = clk_pll_set_rate,
+	.recalc_rate = clk_pll_recalc_rate,
+	.determine_rate = clk_pll_determine_rate,
+};
+
+void eswin_clk_register_pll(const struct eswin_pll_clock *clks, int nums,
+			    struct eswin_clock_data *data, struct device *dev)
+{
+	struct eswin_clk_pll *p_clk = NULL;
+	struct clk_init_data init;
+	struct clk_hw *clk_hw;
+	int i, ret;
+
+	p_clk = devm_kzalloc(dev, sizeof(*p_clk) * nums, GFP_KERNEL);
+	if (!p_clk)
+		return;
+
+	for (i = 0; i < nums; i++) {
+		p_clk->id = clks[i].id;
+		p_clk->ctrl_reg0 = data->base + clks[i].ctrl_reg0;
+		p_clk->pllen_shift = clks[i].pllen_shift;
+		p_clk->pllen_width = clks[i].pllen_width;
+		p_clk->refdiv_shift = clks[i].refdiv_shift;
+		p_clk->refdiv_width = clks[i].refdiv_width;
+		p_clk->fbdiv_shift = clks[i].fbdiv_shift;
+		p_clk->fbdiv_width = clks[i].fbdiv_width;
+
+		p_clk->ctrl_reg1 = data->base + clks[i].ctrl_reg1;
+		p_clk->frac_shift = clks[i].frac_shift;
+		p_clk->frac_width = clks[i].frac_width;
+
+		p_clk->ctrl_reg2 = data->base + clks[i].ctrl_reg2;
+		p_clk->postdiv1_shift = clks[i].postdiv1_shift;
+		p_clk->postdiv1_width = clks[i].postdiv1_width;
+		p_clk->postdiv2_shift = clks[i].postdiv2_shift;
+		p_clk->postdiv2_width = clks[i].postdiv2_width;
+
+		p_clk->status_reg = data->base + clks[i].status_reg;
+		p_clk->lock_shift = clks[i].lock_shift;
+		p_clk->lock_width = clks[i].lock_width;
+
+		init.name = clks[i].name;
+		init.flags = 0;
+		init.parent_names = clks[i].parent_name ?
+					&clks[i].parent_name : NULL;
+		init.num_parents = clks[i].parent_name ? 1 : 0;
+		init.ops = &eswin_clk_pll_ops;
+		p_clk->hw.init = &init;
+
+		clk_hw = &p_clk->hw;
+		ret = devm_clk_hw_register(dev, clk_hw);
+		if (ret) {
+			dev_err(dev, "failed to register clock %s\n",
+				clks[i].name);
+			continue;
+		}
+
+		data->clk_data.hws[clks[i].id] = clk_hw;
+		p_clk++;
+	}
+}
+
+int eswin_clk_register_fixed_factor(const struct eswin_fixed_factor_clock *clks,
+				    int nums, struct eswin_clock_data *data,
+				    struct device *dev)
+{
+	struct clk_hw *clk_hw;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk_hw = devm_clk_hw_register_fixed_factor(dev, clks[i].name,
+							   clks[i].parent_name,
+							   clks[i].flags,
+							   clks[i].mult,
+							   clks[i].div);
+		if (IS_ERR(clk_hw))
+			return dev_err_probe(dev, PTR_ERR(clk_hw),
+					     "failed to register clock\n");
+
+		data->clk_data.hws[clks[i].id] = clk_hw;
+	}
+
+	return 0;
+}
+
+int eswin_clk_register_mux(const struct eswin_mux_clock *clks, int nums,
+			   struct eswin_clock_data *data, struct device *dev)
+{
+	struct clk_hw *clk_hw;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk_hw = devm_clk_hw_register_mux(dev, clks[i].name,
+						  clks[i].parent_names,
+						  clks[i].num_parents,
+						  clks[i].flags,
+						  data->base + clks[i].offset,
+						  clks[i].shift,
+						  clks[i].width,
+						  clks[i].mux_flags,
+						  &data->lock);
+		if (IS_ERR(clk_hw))
+			return dev_err_probe(dev, PTR_ERR(clk_hw),
+					     "failed to register clock\n");
+
+		data->clk_data.hws[clks[i].id] = clk_hw;
+	}
+
+	return 0;
+}
+
+int eswin_clk_register_mux_tbl(const struct eswin_mux_clock *clks,
+			       int nums, struct eswin_clock_data *data,
+			       struct device *dev)
+{
+	struct clk_hw *clk_hw;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk_hw = clk_hw_register_mux_table(dev, clks[i].name,
+						   clks[i].parent_names,
+						   clks[i].num_parents,
+						   clks[i].flags,
+						   data->base + clks[i].offset,
+						   clks[i].shift,
+						   BIT(clks[i].width) - 1,
+						   clks[i].mux_flags,
+						   clks[i].table, &data->lock);
+
+		if (IS_ERR(clk_hw)) {
+			while (i--)
+				clk_hw_unregister_mux
+					(data->clk_data.hws[clks[i].id]);
+			return dev_err_probe(dev, PTR_ERR(clk_hw),
+					     "failed to register clock\n");
+		}
+
+		data->clk_data.hws[clks[i].id] = clk_hw;
+	}
+
+	return 0;
+}
+
+int eswin_clk_register_divider(const struct eswin_divider_clock *clks,
+			       int nums, struct eswin_clock_data *data,
+			       struct device *dev)
+{
+	struct clk_hw *clk_hw;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk_hw = devm_clk_hw_register_divider(dev, clks[i].name,
+						      clks[i].parent_name,
+						      clks[i].flags,
+						      data->base +
+							clks[i].offset,
+						      clks[i].shift,
+						      clks[i].width,
+						      clks[i].div_flags,
+						      &data->lock);
+		if (IS_ERR(clk_hw))
+			return dev_err_probe(dev, PTR_ERR(clk_hw),
+					     "failed to register clock\n");
+
+		data->clk_data.hws[clks[i].id] = clk_hw;
+	}
+
+	return 0;
+}
+
+int eswin_clk_register_gate(const struct eswin_gate_clock *clks, int nums,
+			    struct eswin_clock_data *data, struct device *dev)
+{
+	struct clk_hw *clk_hw;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk_hw = devm_clk_hw_register_gate(dev, clks[i].name,
+						   clks[i].parent_name,
+						   clks[i].flags,
+						   data->base + clks[i].offset,
+						   clks[i].bit_idx,
+						   clks[i].gate_flags,
+						   &data->lock);
+
+		if (IS_ERR(clk_hw))
+			return dev_err_probe(dev, PTR_ERR(clk_hw),
+					     "failed to register clock\n");
+
+		data->clk_data.hws[clks[i].id] = clk_hw;
+	}
+
+	return 0;
+}
diff --git a/drivers/clk/eswin/clk.h b/drivers/clk/eswin/clk.h
new file mode 100644
index 000000000000..fa12680f0960
--- /dev/null
+++ b/drivers/clk/eswin/clk.h
@@ -0,0 +1,256 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd..
+ * All rights reserved.
+ *
+ * Authors:
+ *	Yifeng Huang <huangyifeng@eswincomputing.com>
+ *	Xuyang Dong <dongxuyang@eswincomputing.com>
+ */
+
+#ifndef __ESWIN_CLK_H__
+#define __ESWIN_CLK_H__
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#define APLL_HIGH_FREQ 983040000
+#define APLL_LOW_FREQ 225792000
+#define PLL_HIGH_FREQ 1800000000
+#define PLL_LOW_FREQ 24000000
+
+struct eswin_clock_data {
+	void __iomem *base;
+	spinlock_t lock; /* protect register read-modify-write cycle */
+	struct clk_hw_onecell_data clk_data;
+};
+
+struct eswin_divider_clock {
+	unsigned int id;
+	const char *name;
+	const char *parent_name;
+	unsigned long flags;
+	unsigned long offset;
+	u8 shift;
+	u8 width;
+	u8 div_flags;
+};
+
+struct eswin_fixed_rate_clock {
+	unsigned int id;
+	char *name;
+	const char *parent_name;
+	unsigned long flags;
+	unsigned long rate;
+};
+
+struct eswin_fixed_factor_clock {
+	unsigned int id;
+	char *name;
+	const char *parent_name;
+	unsigned long mult;
+	unsigned long div;
+	unsigned long flags;
+};
+
+struct eswin_gate_clock {
+	unsigned int id;
+	const char *name;
+	const char *parent_name;
+	unsigned long flags;
+	unsigned long offset;
+	u8 bit_idx;
+	u8 gate_flags;
+};
+
+struct eswin_mux_clock {
+	unsigned int id;
+	const char *name;
+	const char *const *parent_names;
+	u8 num_parents;
+	unsigned long flags;
+	unsigned long offset;
+	u8 shift;
+	u8 width;
+	u8 mux_flags;
+	u32 *table;
+};
+
+struct eswin_pll_clock {
+	u32 id;
+	const char *name;
+	const char *parent_name;
+	const u32 ctrl_reg0;
+	const u8 pllen_shift;
+	const u8 pllen_width;
+	const u8 refdiv_shift;
+	const u8 refdiv_width;
+	const u8 fbdiv_shift;
+	const u8 fbdiv_width;
+
+	const u32 ctrl_reg1;
+	const u8 frac_shift;
+	const u8 frac_width;
+
+	const u32 ctrl_reg2;
+	const u8 postdiv1_shift;
+	const u8 postdiv1_width;
+	const u8 postdiv2_shift;
+	const u8 postdiv2_width;
+
+	const u32 status_reg;
+	const u8 lock_shift;
+	const u8 lock_width;
+};
+
+struct eswin_clk_pll {
+	struct clk_hw hw;
+	u32 id;
+	void __iomem *ctrl_reg0;
+	u8 pllen_shift;
+	u8 pllen_width;
+	u8 refdiv_shift;
+	u8 refdiv_width;
+	u8 fbdiv_shift;
+	u8 fbdiv_width;
+
+	void __iomem *ctrl_reg1;
+	u8 frac_shift;
+	u8 frac_width;
+
+	void __iomem *ctrl_reg2;
+	u8 postdiv1_shift;
+	u8 postdiv1_width;
+	u8 postdiv2_shift;
+	u8 postdiv2_width;
+
+	void __iomem *status_reg;
+	u8 lock_shift;
+	u8 lock_width;
+};
+
+struct eswin_clock_data *eswin_clk_init(struct device *dev, int nr_clks);
+int eswin_clk_register_fixed_rate(const struct eswin_fixed_rate_clock *clks,
+				  int nums, struct eswin_clock_data *data,
+				  struct device *dev);
+void eswin_clk_register_pll(const struct eswin_pll_clock *clks, int nums,
+			    struct eswin_clock_data *data, struct device *dev);
+int eswin_clk_register_fixed_factor(const struct eswin_fixed_factor_clock *clks,
+				    int nums, struct eswin_clock_data *data,
+				    struct device *dev);
+int eswin_clk_register_mux(const struct eswin_mux_clock *clks, int nums,
+			   struct eswin_clock_data *data, struct device *dev);
+int eswin_clk_register_mux_tbl(const struct eswin_mux_clock *clks,
+			       int nums, struct eswin_clock_data *data,
+			       struct device *dev);
+int eswin_clk_register_divider(const struct eswin_divider_clock *clks,
+			       int nums, struct eswin_clock_data *data,
+			       struct device *dev);
+int eswin_clk_register_gate(const struct eswin_gate_clock *clks, int nums,
+			    struct eswin_clock_data *data, struct device *dev);
+
+#define PNAME(x) static const char *const x[] __initconst
+
+#define EIC7700_DIV(_id, _name, _pname, _flags, _offset, _shift, _width, \
+		    _dflags)						\
+	{								\
+		.id		= _id,					\
+		.name		= _name,				\
+		.parent_name	= _pname,				\
+		.flags		= _flags,				\
+		.offset		= _offset,				\
+		.shift		= _shift,				\
+		.width		= _width,				\
+		.div_flags	= _dflags,				\
+	}
+
+#define EIC7700_FACTOR(_id, _name, _pname, _mult, _div, _flags)	\
+	{							\
+		.id		= _id,				\
+		.name		= _name,			\
+		.parent_name	= _pname,			\
+		.mult		= _mult,			\
+		.div		= _div,				\
+		.flags		= _flags,			\
+	}
+
+#define EIC7700_FIXED(_id, _name, _pname, _flags, _rate)	\
+{								\
+	.id		= _id,					\
+	.name		= _name,				\
+	.parent_name	= _pname,				\
+	.flags		= _flags,				\
+	.rate		= _rate,				\
+}
+
+#define EIC7700_GATE(_id, _name, _pname, _flags, _offset, _idx, _gflags) \
+	{								\
+		.id		= _id,					\
+		.name		= _name,				\
+		.parent_name	= _pname,				\
+		.flags		= _flags,				\
+		.offset		= _offset,				\
+		.bit_idx	= _idx,					\
+		.gate_flags	= _gflags,				\
+	}
+
+#define EIC7700_MUX(_id, _name, _pnames, _num_parents, _flags, _offset,	\
+		    _shift, _width, _mflags)				\
+	{								\
+		.id		= _id,					\
+		.name		= _name,				\
+		.parent_names	= _pnames,				\
+		.num_parents	= _num_parents,				\
+		.flags		= _flags,				\
+		.offset		= _offset,				\
+		.shift		= _shift,				\
+		.width		= _width,				\
+		.mux_flags	= _mflags,				\
+	}
+
+#define EIC7700_MUX_TBL(_id, _name, _pnames, _num_parents, _flags, _offset, \
+			_shift, _width, _mflags, _table)		\
+	{								\
+		.id		= _id,					\
+		.name		= _name,				\
+		.parent_names	= _pnames,				\
+		.num_parents	= _num_parents,				\
+		.flags		= _flags,				\
+		.offset		= _offset,				\
+		.shift		= _shift,				\
+		.width		= _width,				\
+		.mux_flags	= _mflags,				\
+		.table		= _table,				\
+	}
+
+#define EIC7700_PLL(_id, _name, _pname, _reg0, _en_shift, _en_width,	\
+		    _ref_shift, _ref_width, _fb_shift, _fb_width, _reg1,\
+		    _frac_shift, _frac_width, _reg2, _post1_shift,	\
+		    _post1_width, _post2_shift, _post2_width, _reg,	\
+		    _lock_shift, _lock_width)				\
+	{								\
+		.id		= _id,					\
+		.name		= _name,				\
+		.parent_name	= _pname,				\
+		.ctrl_reg0	= _reg0,				\
+		.pllen_shift	= _en_shift,				\
+		.pllen_width	= _en_width,				\
+		.refdiv_shift	= _ref_shift,				\
+		.refdiv_width	= _ref_width,				\
+		.fbdiv_shift	= _fb_shift,				\
+		.fbdiv_width	= _fb_width,				\
+		.ctrl_reg1	= _reg1,				\
+		.frac_shift	= _frac_shift,				\
+		.frac_width	= _frac_width,				\
+		.ctrl_reg2	= _reg2,				\
+		.postdiv1_shift	= _post1_shift,				\
+		.postdiv1_width	= _post1_width,				\
+		.postdiv2_shift	= _post2_shift,				\
+		.postdiv2_width	= _post2_width,				\
+		.status_reg	= _reg,					\
+		.lock_shift	= _lock_shift,				\
+		.lock_width	= _lock_width,				\
+	}
+
+#endif /* __ESWIN_CLK_H__ */
-- 
2.43.0


