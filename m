Return-Path: <linux-kernel+bounces-771831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C106FB28C02
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405E51CE4851
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26E623A562;
	Sat, 16 Aug 2025 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="q1n7ZxVI"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3854AD21;
	Sat, 16 Aug 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755333946; cv=pass; b=WM4DzIQ5rajzZYoGqXy1gOrfxju+h73Sm5fVOJ3FvpWjTCfBbe0+t48LZFhe6ZaQbXm31QsEJ6Q2FXkQtZ8Mg+irYaSu6lqqCjyL116F6YmdV4A0ZTvOBIh1JHWFQng9PyapJUrOWYnjSVvf22XJfMFywUsDohubUXKNBXrZAas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755333946; c=relaxed/simple;
	bh=Rwp2Zj8GBuI2/ZTvL+BTWNbJHNTp5GqXPetyT32LPxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvXt7UFpyHxGvy+ADwhP2cBiqmJGaQYdjpZDMP8GFLPKgnqI0+sMUHaIrgKO2FxkZ5bNpbCo5+KmCUgRciR3lQtcZcrunKJITr/E6NyQ55+9Z0he+2afZYmcfS0lxLBy6xsOi+P5sWfF7nScS669ZKVm+9Uw69ybO171nHoVGuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=q1n7ZxVI; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755333918; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GZ/6WbEBc6H8WI9yyDGOPSO8rx3bGj1cSKYWeD6HVXmoMbjXkugFGECxDGyYHNkjbChPDfuUjGwgpz/daCQpyU2C72hrDB8OQmdKALStLCJTgzTdxk+KpBYErAe3g6PYSGV3od4MwmCkEIeNeMf9GnX8y6YOV7zaw64g83liv7A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755333918; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Nv6EMwQ3hnEwU4qVzZNwEJO9BBi52COvmPnVyeNmGOg=; 
	b=RxRgscksHR702yFfVatsh4O2OhCiLhJmGL7tOpH0iQYWnSSxI850jxOi540kMGdFT2LLG5f37b3gYoCHyJe8SQx72VABJOQGpcbZhmvO5oEfmoh3y/tgmCcroH80IvHyVG3Ht+xrCVMzI9P0cpUxxJBzPsVUe0ZUXbsEl64jAH0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755333918;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Nv6EMwQ3hnEwU4qVzZNwEJO9BBi52COvmPnVyeNmGOg=;
	b=q1n7ZxVIRNwzJYobcx4V6yCrh44ZcGOftxvN3382pRTtsj2c9me2iyjT4YN1v0f3
	m/G1L4GEb1LbyXJiv7THiGJyCLKy4ksDJ+r1Pll1KLjRw5YmSGit8Jh/TWcKPK9kI4F
	wKMkZoWw3WxO6ONOenzPGLhvWCmSSBfLlaABcWe2dymezdLgqNs+cSwvbbq+/JfcZEp
	HtNfHc0vcRe4DMT3i3gXXHCVynBGTXjsK5aCDuERpvnEGwrieYs2Gg+TxsK//nPWIDX
	veEz/HoYTvkHjuIGwFY3NFBAfh0xNpBBX5Md2KROr20ijnVQOGSHskObffgdg5eWvnB
	WFlAGVrhRg==
Received: by mx.zohomail.com with SMTPS id 1755333915661293.24643184419165;
	Sat, 16 Aug 2025 01:45:15 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: [PATCH v2 2/2] clk: thead: th1520-ap: fix parent of padctrl0 clock
Date: Sat, 16 Aug 2025 16:44:45 +0800
Message-ID: <20250816084445.2582692-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816084445.2582692-1-uwu@icenowy.me>
References: <20250816084445.2582692-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The padctrl0 clock seems to be a child of the perisys_apb4_hclk clock,
gating the later makes padctrl0 registers stuck too.

Fix this relationship.

Fixes: ae81b69fd2b1 ("clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks")
Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Reviewed-by: Drew Fustini <fustini@kernel.org>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
---
Changes in v2:
- Rebased on top of origin/master (a little newer than v6.17-rc1).
- Added an empty line to satisfy checkpatch.pl .
- Added Drew's and Troy's R-b.

 drivers/clk/thead/clk-th1520-ap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 4dbd1df9a86d4..8a5d699638379 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -798,13 +798,17 @@ static CCU_GATE(CLK_PERISYS_APB3_HCLK, perisys_apb3_hclk, "perisys-apb3-hclk", p
 		0x150, 11, CLK_IGNORE_UNUSED);
 static CCU_GATE(CLK_PERISYS_APB4_HCLK, perisys_apb4_hclk, "perisys-apb4-hclk", perisys_ahb_hclk_pd,
 		0x150, 12, 0);
+static const struct clk_parent_data perisys_apb4_hclk_pd[] = {
+	{ .hw = &perisys_apb4_hclk.gate.hw },
+};
+
 static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, 5, 0);
 static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e0, 13, 0);
 static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio", emmc_sdio_ref_clk_pd, 0x204, 30, 0);
 static CCU_GATE(CLK_GMAC1, gmac1_clk, "gmac1", gmac_pll_clk_pd, 0x204, 26, 0);
 static CCU_GATE(CLK_PADCTRL1, padctrl1_clk, "padctrl1", perisys_apb_pclk_pd, 0x204, 24, 0);
 static CCU_GATE(CLK_DSMART, dsmart_clk, "dsmart", perisys_apb_pclk_pd, 0x204, 23, 0);
-static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb_pclk_pd, 0x204, 22, 0);
+static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb4_hclk_pd, 0x204, 22, 0);
 static CCU_GATE(CLK_GMAC_AXI, gmac_axi_clk, "gmac-axi", axi4_cpusys2_aclk_pd, 0x204, 21, 0);
 static CCU_GATE(CLK_GPIO3, gpio3_clk, "gpio3-clk", peri2sys_apb_pclk_pd, 0x204, 20, 0);
 static CCU_GATE(CLK_GMAC0, gmac0_clk, "gmac0", gmac_pll_clk_pd, 0x204, 19, 0);
-- 
2.50.1


