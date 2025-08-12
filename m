Return-Path: <linux-kernel+bounces-764094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92279B21DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08937AEB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E727A2E2DE4;
	Tue, 12 Aug 2025 06:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="MMVZjRPw"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914620C478;
	Tue, 12 Aug 2025 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978706; cv=pass; b=m9LhJDwW+MHw+D4S9bIgIO5Ndu4zTxd+5C15qWGRhy0o1QyztBPh7/bRDNg9rv9mjN0ucfg9rtQwc/q9Be6eViuXSOiDanxMaMFLGH5g6j7I62+2F2yxqv3y0LaRnPf1NaheVf6yUPucymwymba3YWgSMejjGP4lvxNTrVpXMrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978706; c=relaxed/simple;
	bh=EzUOIACUt1KmxYumzQmo1PMKVaWaBgvmTxu7Hvc4jDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWnzR4dsqSCmkNY0c1WpF0r6iPbUtX/v6QkTlor1chzjh56G+qps0+YNS43s500Oo8pRoNvAEU64nYm11C0yW4qqoE0Kh1UhArzAO3K+TzDxAZvzkDfeP883eK5FcAHiUicBix+WSnvCTEUiHRGhTm+psU8+dr2tyzYwBU584YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=MMVZjRPw; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1754978687; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lhEHMyl/snY8uIxfzQJiI8041IfgDLHDzB4JRZDC3NkJ8okt2jsPCvVFgc82v+IRRNHsjOk3T4IS7ebvea5K79ZgT3t+lBgcF4FTPagxvDUC6vyw5t6KolkVaj/h9edan4X0KM+LslV1F/63Bp/GYh+GrGadvdJdfZA9UMuTshY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754978687; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6N05Gi0z8r9iMMzOAx3PYV4MnXawFgktXAzKcF+UKt0=; 
	b=HidNwNw+PoHLUrp/RZYAji1z+bmsK0+JuBs5Fus64UC1fAANu8bi//sv0CpzOnTjVoxAFIYB+IYmFgmvimgAFEjo+Oqf0S2Lu4+E7OOaZ8Xw3b1YDzsoBwNyYLEM6rbGWvmby8DuDnFlfPsdc7mPtsmVl2Nblq7dGDnMNcceCV4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754978687;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6N05Gi0z8r9iMMzOAx3PYV4MnXawFgktXAzKcF+UKt0=;
	b=MMVZjRPw/PBiqhXAdqaKcYF+3RNhDrrJtOkHjJD+1WCvNA/V30KXvZ9KPO4Ei40/
	jrEP+iqGiZISJLD3MNejGiVWTfp77O7gk49YLSvis9x5lhiGXysWyePSj57eiodGzGE
	Fe/Jevo8rBaxgFMfAU7it5RKDH7W2AC8zSKubGevyEhX90f153xB29ezufKfAJYuvBV
	xKXbyrPo9Hcpe/8YHwBBs1yWwc6KSRIUBA99U18jY6i9rRy69ExCXAHreq/XIKiXbHt
	jH09BxHAwgGydKG30Cnfs2NZFaMPYXAO3k2h32Oxo8Is58/2VD9ilm51w4HU77DnrP4
	xrvcRFvI2w==
Received: by mx.zohomail.com with SMTPS id 1754978686237125.18407234908796;
	Mon, 11 Aug 2025 23:04:46 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 4/4 FIXED] clk: thead: th1520-ap: fix parent of padctrl0 clock
Date: Tue, 12 Aug 2025 14:04:33 +0800
Message-ID: <20250812060433.1979587-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812054258.1968351-5-uwu@icenowy.me>
References: <20250812054258.1968351-5-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The padctrl0 clock seems to be a child of the perisys_apb4_hclk clock,
gating the later makes padctrl0 registers stuck.

Fix this relationship.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
This is the consequence of fixing 3/4, because these two patches are at
nearly the same position, and unfortunately get dependent by the
algorithm of diff.

Ignore the original 4/4 and look at this too.

 drivers/clk/thead/clk-th1520-ap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 75ea1705cc08f..0ecedac50d6cb 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -917,13 +917,18 @@ static CCU_GATE(CLK_PERISYS_APB3_HCLK, perisys_apb3_hclk, "perisys-apb3-hclk", p
 		0x150, BIT(11), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_PERISYS_APB4_HCLK, perisys_apb4_hclk, "perisys-apb4-hclk", perisys_ahb_hclk_pd,
 		0x150, BIT(12), 0);
+
+static const struct clk_parent_data perisys_apb4_hclk_pd[] = {
+	{ .hw = &perisys_apb4_hclk.common.hw },
+};
+
 static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, BIT(5), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e0, BIT(13), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio", emmc_sdio_ref_clk_pd, 0x204, BIT(30), 0);
 static CCU_GATE(CLK_GMAC1, gmac1_clk, "gmac1", gmac_pll_clk_pd, 0x204, BIT(26), 0);
 static CCU_GATE(CLK_PADCTRL1, padctrl1_clk, "padctrl1", perisys_apb_pclk_pd, 0x204, BIT(24), 0);
 static CCU_GATE(CLK_DSMART, dsmart_clk, "dsmart", perisys_apb_pclk_pd, 0x204, BIT(23), 0);
-static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb_pclk_pd, 0x204, BIT(22), 0);
+static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb4_hclk_pd, 0x204, BIT(22), 0);
 static CCU_GATE(CLK_GMAC_AXI, gmac_axi_clk, "gmac-axi", axi4_cpusys2_aclk_pd, 0x204, BIT(21), 0);
 static CCU_GATE(CLK_GPIO3, gpio3_clk, "gpio3-clk", peri2sys_apb_pclk_pd, 0x204, BIT(20), 0);
 static CCU_GATE(CLK_GMAC0, gmac0_clk, "gmac0", gmac_pll_clk_pd, 0x204, BIT(19), 0);
-- 
2.50.1


