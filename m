Return-Path: <linux-kernel+bounces-761188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E23FB1F582
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 19:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF263AEFA7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDD427780D;
	Sat,  9 Aug 2025 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TP7Ouw/H"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D766623B629
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754758936; cv=none; b=fO1jDcgM9VB23KnCCtEpv3rm37DYKmf996zkeItvcH9SSPI/iD9h/L2bbSZBM/XyqNwne+wicDqCurYXSMp6EAyHT6OGBuY1pTOsgiDYciFk0E53qVDUz96mcSshW7IDtPGO5OLN7ZnXFFMUqGCe0ygqjXkU/janCJNCxcbWESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754758936; c=relaxed/simple;
	bh=oLlStNjf365/EBYlY8hMiCgpuMw8R0zVvmxK0owNE/w=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type:
	 References; b=cER7OK2tqUemHjMBgxkG1qBsvomOePGy9Z5RKb/LB3wXdcMgdkCmKwAeBC8wfHKsLfwoP1LpXVYqP+51IP8wcX90FW5suPek2VKhWvsjoMUELgcS6RXwVoPYYH8V+XwVYh9ITwR8po5T6zlzAd+hzOnU9SqG+ONYpDJMfumPCWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TP7Ouw/H; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250809170205euoutp02e6c459cd81d31953b3f719efcb311479~aJ-ImyLDG2355123551euoutp02d
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 17:02:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250809170205euoutp02e6c459cd81d31953b3f719efcb311479~aJ-ImyLDG2355123551euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754758925;
	bh=cXcpoYqKpw2AYordukgrvKibmr+AtiKeIGTwu6IdZyU=;
	h=From:Date:Subject:To:Cc:References:From;
	b=TP7Ouw/HTL6FWk+4PiiYStebOLdHCpAs/QPn2IJmwzfLMgpG48W8H6SYYBQpAa1ZU
	 hgjphUeUE1vTifDvFt5PIqn+75iHD4z9lyfog8q9IbdyRuKN5hragcmJHlJ2H4zPqQ
	 wSuXoCI6KmrIHGMOF5wL5yUd/vo4iiahJDtXrAdk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250809170205eucas1p2da20fc85d38c98195d2ce36422592bee~aJ-IVxL3m1297712977eucas1p2r;
	Sat,  9 Aug 2025 17:02:05 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250809170205eusmtip12b6ca9982d2161a1964893ca1ae913dd~aJ-H8om130374003740eusmtip1Y;
	Sat,  9 Aug 2025 17:02:05 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Sat, 09 Aug 2025 19:02:00 +0200
Subject: [PATCH] clk: thead: Correct parent for DPU pixel clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-fix_clocks_thead_aug_9-v1-1-299c33d7a593@samsung.com>
X-B4-Tracking: v=1; b=H4sIAAd/l2gC/x2MSwqAMAwFryJZW6ifgnoVkVLSVIOi0qoI4t0Nz
	m5g3nsgUWRK0GUPRLo48baKFHkGOLl1JMVeHEpdGt3oVgW+LS4bzskeEzlv3TnaVhkMQu01Vg3
	IeI8k5X/cD+/7ASvvqsFoAAAA
X-Change-ID: 20250809-fix_clocks_thead_aug_9-5cffff4d0c38
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Michael Turquette <mturquette@baylibre.com>,  Stephen
	Boyd <sboyd@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,  Michal
	Wilczynski <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250809170205eucas1p2da20fc85d38c98195d2ce36422592bee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250809170205eucas1p2da20fc85d38c98195d2ce36422592bee
X-EPHeader: CA
X-CMS-RootMailID: 20250809170205eucas1p2da20fc85d38c98195d2ce36422592bee
References: <CGME20250809170205eucas1p2da20fc85d38c98195d2ce36422592bee@eucas1p2.samsung.com>

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
---
 drivers/clk/thead/clk-th1520-ap.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index cf1bba58f641e9b053cdda5fa52640590c5fa215..dd6359441f7e8a2c9d4a00c640b07af606627cc4 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -767,6 +767,10 @@ static struct ccu_div dpu0_clk = {
 	},
 };
 
+static const struct clk_parent_data dpu0_clk_pd[] = {
+	{ .hw = &dpu0_clk.common.hw }
+};
+
 static struct ccu_div dpu1_clk = {
 	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
 	.common		= {
@@ -779,6 +783,10 @@ static struct ccu_div dpu1_clk = {
 	},
 };
 
+static const struct clk_parent_data dpu1_clk_pd[] = {
+	{ .hw = &dpu1_clk.common.hw }
+};
+
 static CLK_FIXED_FACTOR_HW(emmc_sdio_ref_clk, "emmc-sdio-ref",
 			   &video_pll_clk.common.hw, 4, 1, 0);
 
@@ -855,9 +863,9 @@ static CCU_GATE(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk", video_pll_clk_pd,
 static CCU_GATE(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
 		video_pll_clk_pd, 0x0, BIT(4), 0);
 static CCU_GATE(CLK_DPU_PIXELCLK0, dpu0_pixelclk, "dpu0-pixelclk",
-		video_pll_clk_pd, 0x0, BIT(5), 0);
+		dpu0_clk_pd, 0x0, BIT(5), 0);
 static CCU_GATE(CLK_DPU_PIXELCLK1, dpu1_pixelclk, "dpu1-pixelclk",
-		video_pll_clk_pd, 0x0, BIT(6), 0);
+		dpu1_clk_pd, 0x0, BIT(6), 0);
 static CCU_GATE(CLK_DPU_HCLK, dpu_hclk, "dpu-hclk", video_pll_clk_pd, 0x0,
 		BIT(7), 0);
 static CCU_GATE(CLK_DPU_ACLK, dpu_aclk, "dpu-aclk", video_pll_clk_pd, 0x0,

---
base-commit: 561c80369df0733ba0574882a1635287b20f9de2
change-id: 20250809-fix_clocks_thead_aug_9-5cffff4d0c38

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


