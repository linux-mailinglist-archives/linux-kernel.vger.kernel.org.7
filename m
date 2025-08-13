Return-Path: <linux-kernel+bounces-766138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8F4B242C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3142F171648
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183F92DCF55;
	Wed, 13 Aug 2025 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="OtUN4/IU"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835852D7392;
	Wed, 13 Aug 2025 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070100; cv=pass; b=TX/LOiR++DeZf/Jukk7/NTtBsmUo3K7ZaWgDXBIIR0gQZveO+N3t25ZpUUSNy90pzY5qIFRiBgy4tn0lZG/Zf8/HsnkfoN/3/czK8z8Lhm9Did6Qx+mvk0skri2V1Vvy9RDz9aT5GNguWqCFveLeTyEAbhIFUVs727LySR8UaDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070100; c=relaxed/simple;
	bh=WfQGwG6AIli5tQ5UgzKBGZ+liVCl83y9idSDc8vSJfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLoGmWM0UtOF8RuA5vBaAF6WgMNUf7i7LyWoW45hpFFJ+HE4//Xat+ow+umJGrjnKqV9hr1ujnf0s4MPWZ4yn1ZBuiY+K+kant8zwCkm7wcrbp3V820l4WaeMQDwDBKfUG7dAB5RcTRC59teFn6IpnNPSAQ2puCBwYhK49POZmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=OtUN4/IU; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755070084; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GaLTEOdq/Oq83qq10mXn+lrKHQWfpr/HxYEsyqcyCjj6p6aT9dwmTNZoJ90Egzc0egVTuH03UlWxRY9A2BqJSO1ozgENXMvVzSr7lXTi+K7ySl8uAyIQL/Z02ajPN3jjNM0qcqE5qlIT+O8qDJKA51DbT6paQRhLOC4lpC3O3Tc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755070084; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YA5K1QeOw6QZSnl5vIgv8mS6MWi8kYtpfARcgg+9RII=; 
	b=lDupjT7fl9ieLaDG0nZj2TP65OhHp5iAp8P0ZlkXdFnidb/pzq+40ct0HeEbDmBrSBFmzgrFrEsGtXYeDMKO9kViB9ldGgvDrVxBrSDMpGG2okeDcd92oGBW8IVj7JkLHHWM/Phf5TH7VT0rwPXbWla3efeSDrYM4b+kKvtny4E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755070083;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YA5K1QeOw6QZSnl5vIgv8mS6MWi8kYtpfARcgg+9RII=;
	b=OtUN4/IUDTl5mOf48S5cbtEXIHeaV7f5g2Fwkdqnm4jguZji/hWbgD4SUwqNZzl7
	8y2974zLP8LwaxnKoBTuVDqWMGnR/UOws9pGrN2l4XjXFgkoDvkyZzivtjwiI+ClJK2
	3UY93l81raR56nwDYKiownGWsHql+wVz1dVGdTL2yFY0jabQnxT2qI15fo1gKogSKdm
	mDWNwtLmYEnZ4CaDIWxK3HSSJUU51oa6CcRXMa87bFKIBCNy9fUW+riZdvlO0Pez7yY
	BOOeWXDwIIP/DzmNPM2zwqWJ24jCydgQmwcJtCpOi12F/cxY3oSoq6cmB3zd6OJYOGe
	3UEq7vQKKw==
Received: by mx.zohomail.com with SMTPS id 1755070081771781.9115436334819;
	Wed, 13 Aug 2025 00:28:01 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Yao Zi <ziyao@disroot.org>,
	Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 3/3] clk: thead: th1520-ap: set all AXI clocks to CLK_IS_CRITICAL
Date: Wed, 13 Aug 2025 15:27:02 +0800
Message-ID: <20250813072702.2176993-4-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813072702.2176993-1-uwu@icenowy.me>
References: <20250813072702.2176993-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The AXI crossbar of TH1520 has no proper timeout handling, which means
gating AXI clocks can easily lead to bus timeout and thus system hang.

Set all AXI clock gates to CLK_IS_CRITICAL. All these clock gates are
ungated by default on system reset.

In addition, convert all current CLK_IGNORE_UNUSED usage to
CLK_IS_CRITICAL to prevent unwanted clock gating.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
No changes in v2 except for rebasing error fixes (which I sent as FIXED
patches in v1).

 drivers/clk/thead/clk-th1520-ap.c | 44 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index b220a8ed22607..0224f2dde0f63 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -566,7 +566,7 @@ static struct ccu_div axi4_cpusys2_aclk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_HW("axi4-cpusys2-aclk",
 					      gmac_pll_clk_parent,
 					      &ccu_div_ops,
-					      0),
+					      CLK_IS_CRITICAL),
 	},
 };
 
@@ -588,7 +588,7 @@ static struct ccu_div axi_aclk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_DATA("axi-aclk",
 						      axi_parents,
 						      &ccu_div_ops,
-						      0),
+						      CLK_IS_CRITICAL),
 	},
 };
 
@@ -737,7 +737,7 @@ static struct ccu_div apb_pclk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_DATA("apb-pclk",
 						      apb_parents,
 						      &ccu_div_ops,
-						      CLK_IGNORE_UNUSED),
+						      CLK_IS_CRITICAL),
 	},
 };
 
@@ -768,7 +768,7 @@ static struct ccu_div vi_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_HW("vi",
 					      video_pll_clk_parent,
 					      &ccu_div_ops,
-					      0),
+					      CLK_IS_CRITICAL),
 	},
 };
 
@@ -793,7 +793,7 @@ static struct ccu_div vo_axi_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_HW("vo-axi",
 					      video_pll_clk_parent,
 					      &ccu_div_ops,
-					      0),
+					      CLK_IS_CRITICAL),
 	},
 };
 
@@ -818,7 +818,7 @@ static struct ccu_div vp_axi_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_HW("vp-axi",
 					      video_pll_clk_parent,
 					      &ccu_div_ops,
-					      CLK_IGNORE_UNUSED),
+					      CLK_IS_CRITICAL),
 	},
 };
 
@@ -879,23 +879,23 @@ static const struct clk_parent_data emmc_sdio_ref_clk_pd[] = {
 static CCU_GATE(CLK_BROM, brom_clk, "brom", ahb2_cpusys_hclk_pd, 0x100, BIT(4), 0);
 static CCU_GATE(CLK_BMU, bmu_clk, "bmu", axi4_cpusys2_aclk_pd, 0x100, BIT(5), 0);
 static CCU_GATE(CLK_AON2CPU_A2X, aon2cpu_a2x_clk, "aon2cpu-a2x", axi4_cpusys2_aclk_pd,
-		0x134, BIT(8), 0);
+		0x134, BIT(8), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_X2X_CPUSYS, x2x_cpusys_clk, "x2x-cpusys", axi4_cpusys2_aclk_pd,
-		0x134, BIT(7), 0);
+		0x134, BIT(7), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_CPU2AON_X2H, cpu2aon_x2h_clk, "cpu2aon-x2h", axi_aclk_pd,
-		0x138, BIT(8), CLK_IGNORE_UNUSED);
+		0x138, BIT(8), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_CPU2PERI_X2H, cpu2peri_x2h_clk, "cpu2peri-x2h", axi4_cpusys2_aclk_pd,
-		0x140, BIT(9), CLK_IGNORE_UNUSED);
+		0x140, BIT(9), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_PERISYS_APB1_HCLK, perisys_apb1_hclk, "perisys-apb1-hclk", perisys_ahb_hclk_pd,
-		0x150, BIT(9), CLK_IGNORE_UNUSED);
+		0x150, BIT(9), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_PERISYS_APB2_HCLK, perisys_apb2_hclk, "perisys-apb2-hclk", perisys_ahb_hclk_pd,
-		0x150, BIT(10), CLK_IGNORE_UNUSED);
+		0x150, BIT(10), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_PERISYS_APB3_HCLK, perisys_apb3_hclk, "perisys-apb3-hclk", perisys_ahb_hclk_pd,
-		0x150, BIT(11), CLK_IGNORE_UNUSED);
+		0x150, BIT(11), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_PERISYS_APB4_HCLK, perisys_apb4_hclk, "perisys-apb4-hclk", perisys_ahb_hclk_pd,
 		0x150, BIT(12), 0);
-static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, BIT(5), 0);
-static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e0, BIT(13), 0);
+static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, BIT(5), CLK_IS_CRITICAL);
+static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e0, BIT(13), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio", emmc_sdio_ref_clk_pd, 0x204, BIT(30), 0);
 static CCU_GATE(CLK_GMAC1, gmac1_clk, "gmac1", gmac_pll_clk_pd, 0x204, BIT(26), 0);
 static CCU_GATE(CLK_PADCTRL1, padctrl1_clk, "padctrl1", perisys_apb_pclk_pd, 0x204, BIT(24), 0);
@@ -939,11 +939,11 @@ static CCU_GATE(CLK_SRAM2, sram2_clk, "sram2", axi_aclk_pd, 0x20c, BIT(2), 0);
 static CCU_GATE(CLK_SRAM3, sram3_clk, "sram3", axi_aclk_pd, 0x20c, BIT(1), 0);
 
 static CCU_GATE(CLK_AXI4_VO_ACLK, axi4_vo_aclk, "axi4-vo-aclk",
-		video_pll_clk_pd, 0x0, BIT(0), 0);
+		video_pll_clk_pd, 0x0, BIT(0), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk", video_pll_clk_pd,
 		0x0, BIT(3), 0);
 static CCU_GATE(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
-		video_pll_clk_pd, 0x0, BIT(4), 0);
+		video_pll_clk_pd, 0x0, BIT(4), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_DPU_PIXELCLK0, dpu0_pixelclk, "dpu0-pixelclk",
 		dpu0_clk_pd, 0x0, BIT(5), CLK_SET_RATE_PARENT);
 static CCU_GATE(CLK_DPU_PIXELCLK1, dpu1_pixelclk, "dpu1-pixelclk",
@@ -975,9 +975,9 @@ static CCU_GATE(CLK_MIPI_DSI1_REFCLK, mipi_dsi1_refclk, "mipi-dsi1-refclk",
 static CCU_GATE(CLK_HDMI_I2S, hdmi_i2s_clk, "hdmi-i2s-clk", video_pll_clk_pd,
 		0x0, BIT(19), 0);
 static CCU_GATE(CLK_X2H_DPU1_ACLK, x2h_dpu1_aclk, "x2h-dpu1-aclk",
-		video_pll_clk_pd, 0x0, BIT(20), 0);
+		video_pll_clk_pd, 0x0, BIT(20), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_X2H_DPU_ACLK, x2h_dpu_aclk, "x2h-dpu-aclk",
-		video_pll_clk_pd, 0x0, BIT(21), 0);
+		video_pll_clk_pd, 0x0, BIT(21), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_AXI4_VO_PCLK, axi4_vo_pclk, "axi4-vo-pclk",
 		video_pll_clk_pd, 0x0, BIT(22), 0);
 static CCU_GATE(CLK_IOPMP_VOSYS_DPU_PCLK, iopmp_vosys_dpu_pclk,
@@ -987,11 +987,11 @@ static CCU_GATE(CLK_IOPMP_VOSYS_DPU1_PCLK, iopmp_vosys_dpu1_pclk,
 static CCU_GATE(CLK_IOPMP_VOSYS_GPU_PCLK, iopmp_vosys_gpu_pclk,
 		"iopmp-vosys-gpu-pclk", video_pll_clk_pd, 0x0, BIT(25), 0);
 static CCU_GATE(CLK_IOPMP_DPU1_ACLK, iopmp_dpu1_aclk, "iopmp-dpu1-aclk",
-		video_pll_clk_pd, 0x0, BIT(27), 0);
+		video_pll_clk_pd, 0x0, BIT(27), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_IOPMP_DPU_ACLK, iopmp_dpu_aclk, "iopmp-dpu-aclk",
-		video_pll_clk_pd, 0x0, BIT(28), 0);
+		video_pll_clk_pd, 0x0, BIT(28), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_IOPMP_GPU_ACLK, iopmp_gpu_aclk, "iopmp-gpu-aclk",
-		video_pll_clk_pd, 0x0, BIT(29), 0);
+		video_pll_clk_pd, 0x0, BIT(29), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_MIPIDSI0_PIXCLK, mipi_dsi0_pixclk, "mipi-dsi0-pixclk",
 		video_pll_clk_pd, 0x0, BIT(30), 0);
 static CCU_GATE(CLK_MIPIDSI1_PIXCLK, mipi_dsi1_pixclk, "mipi-dsi1-pixclk",
-- 
2.50.1


