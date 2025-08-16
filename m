Return-Path: <linux-kernel+bounces-771854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CF3B28C41
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0C83AEA7E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B4923D7CE;
	Sat, 16 Aug 2025 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="ARPjtAaH"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC8D11713;
	Sat, 16 Aug 2025 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755335522; cv=pass; b=tfiRPqrZGCL6nRbt9Qx2e7nBL8hIViRB+EZFqPVU8kYHOySKMZ058NBL/H0TLd/RTQ916P3qz0ntELq35iwTXoq/rbXaFdfVaR2rh20EuaNcvEXs1rjnzTXPa5Xs4zK7UhIthCbjldlIC+nTO9pIjyFLmud9abQtLRqbxhB0LBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755335522; c=relaxed/simple;
	bh=KAw3oWdlMD4tYuz/Q1EVYOc8isIt+msWO5h3a/6y1co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOTJeGzWF5zH1w4mx4quQXygSkwOGHpG76AvsqI6hJ8Ij6KWISgwduiOO1t399oy70ecAsys8mRRz4swbd1c3S6rOdYcccMnN+f/QloLHo5fDE+DcnpZV3qjIhuC6MwX5opy5jU64F4xqTIBj8VqHdJPWSD2xVlPpOgWKg2agaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=ARPjtAaH; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755335499; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PVc6NoeTR6YKm0QNmvUEJqGNsofza7y17lApa9d1iXK1yzX5FGY4ZNPY3YtFFRnWFBiInwnTkFFAtReDzgNOK5PPN8T4dLhZ3MPUb4vyro4UVWrqHVOoRfQ1/ST50x8PLx0Y/3FNpZSKVk/qdL5Zy4p/ryiSVNC8RLrObVSxG24=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755335499; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fCVzUEHjBk9WIXhQ2mFElRGPPA6pTX38mHJTTDFKnsY=; 
	b=hKB3GaKCUFLy/e3dLOg7dBayC0GMg0U+MTIaH5G5JG0WHqCTEdvXAzG+Jzmd7VRk7aWLhoZCL8huET0z7vD+4d313jWv78NOaDtGoR2heskZvzlbPquNoh4YaOTX7/0wnrPKasmGvQ621O1qRZy4Mycc2+NZJrM5qC68jhWoiI8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755335499;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fCVzUEHjBk9WIXhQ2mFElRGPPA6pTX38mHJTTDFKnsY=;
	b=ARPjtAaHoCheB7GM4nhAYyz0p0UMfVSgTSjwSUrpMamONbOnzQU8WJvuNul7tPKB
	b0yA6xBLsbzau7ryG47c4OWG4MUsStihQN/pt2ALtxGx8GtzSzk+KYcnub/zhIX++sa
	Q+8n5F+yr9aiO8Fuhj71JB1gdVLNz46dZeBpM875KIeXuXrTD22sJt6TQ7U7BdmyO07
	3VRg/Yvc0/TIPvubMpkh6rczdjwsA7b+cUZQr465CRwyBBegdFvhBm2gRtC2aJmWbp2
	kjsRgqJTU0vvUr+hPg3k36sHEgKs0lTtnuYsKypjP4GXcGGM6vrV32wy/5W2WF4z/zr
	3ZGqNXeKRg==
Received: by mx.zohomail.com with SMTPS id 1755335497092175.64907767078034;
	Sat, 16 Aug 2025 02:11:37 -0700 (PDT)
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
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v3 1/4] clk: thead: Correct parent for DPU pixel clocks
Date: Sat, 16 Aug 2025 17:11:10 +0800
Message-ID: <20250816091113.2596048-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816091113.2596048-1-uwu@icenowy.me>
References: <20250816091113.2596048-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Michal Wilczynski <m.wilczynski@samsung.com>

The dpu0_pixelclk and dpu1_pixelclk gates were incorrectly parented to
the video_pll_clk.

According to the TH1520 TRM, the "dpu0_pixelclk" should be sourced from
"DPU0 PLL DIV CLK". In this driver, "DPU0 PLL DIV CLK" corresponds to
the `dpu0_clk` clock, which is a divider whose parent is the
`dpu0_pll_clk`.

This patch corrects the clock hierarchy by reparenting `dpu0_pixelclk`
to `dpu0_clk`. By symmetry, `dpu1_pixelclk` is also reparented to its
correct source, `dpu1_clk`.

Fixes: 50d4b157fa96 ("clk: thead: Add clock support for VO subsystem in T-HEAD TH1520 SoC")
Reported-by: Icenowy Zheng <uwu@icenowy.me>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
[Icenowy: add Drew's R-b and rebased atop ccu_gate refactor]
Reviewed-by: Drew Fustini <fustini@kernel.org>
Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
Pulled into this patchset in v3 because of rebasing.

 drivers/clk/thead/clk-th1520-ap.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 8a5d699638379..ec52726fbea95 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -761,6 +761,10 @@ static struct ccu_div dpu0_clk = {
 	},
 };
 
+static const struct clk_parent_data dpu0_clk_pd[] = {
+	{ .hw = &dpu0_clk.common.hw }
+};
+
 static struct ccu_div dpu1_clk = {
 	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
 	.common		= {
@@ -773,6 +777,10 @@ static struct ccu_div dpu1_clk = {
 	},
 };
 
+static const struct clk_parent_data dpu1_clk_pd[] = {
+	{ .hw = &dpu1_clk.common.hw }
+};
+
 static CLK_FIXED_FACTOR_HW(emmc_sdio_ref_clk, "emmc-sdio-ref",
 			   &video_pll_clk.common.hw, 4, 1, 0);
 
@@ -853,9 +861,9 @@ static CCU_GATE(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk", video_pll_clk_pd,
 static CCU_GATE(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
 		video_pll_clk_pd, 0x0, 4, 0);
 static CCU_GATE(CLK_DPU_PIXELCLK0, dpu0_pixelclk, "dpu0-pixelclk",
-		video_pll_clk_pd, 0x0, 5, 0);
+		dpu0_clk_pd, 0x0, 5, 0);
 static CCU_GATE(CLK_DPU_PIXELCLK1, dpu1_pixelclk, "dpu1-pixelclk",
-		video_pll_clk_pd, 0x0, 6, 0);
+		dpu1_clk_pd, 0x0, 6, 0);
 static CCU_GATE(CLK_DPU_HCLK, dpu_hclk, "dpu-hclk", video_pll_clk_pd, 0x0,
 		7, 0);
 static CCU_GATE(CLK_DPU_ACLK, dpu_aclk, "dpu-aclk", video_pll_clk_pd, 0x0,
-- 
2.50.1


