Return-Path: <linux-kernel+bounces-766137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C912B242BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD46816B679
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C072D8363;
	Wed, 13 Aug 2025 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="QAIiYdQk"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A92D3209;
	Wed, 13 Aug 2025 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070082; cv=pass; b=khTSZU4qqKypqo4J7fD9n0hlE3E2gF2uOtlk4AENFRYoZrzY412veBl48JiTlYKYVquLPmXAMPDtsyyPkfgMR5SelpOf3djLGi1i9zYzRjq74+KP4+UetOKpOY9goQMq3ZK7SgWYHunklQaCXZLfu8hqM31H31kMR0h2JEyn6LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070082; c=relaxed/simple;
	bh=R6r7z1JaPCFbycjugyKgKfj2inaFHaxk/9ypGbKQBOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2BK4a+ZNIlBsWC2NSpNWuBtr/jkoRge4wwfTkS2AIoH9vp6+5SXMY+H9qKxP9Y8HySnCHYqZFy8hPj3wV5+J3qgjz/ct7DwSuWyoplhQf0LaKpB5HVsHZUl2Qtomakfpkbts08a8LCJgXcxuaVYvYDCKUSAADi6c1hqMq3DX0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=QAIiYdQk; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755070065; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G3nmuitR1k/Ow+Rf2lxeSTk1D5Ws5XFFafRcdVzZZxbBmByt2QO3Uc9vgAdLhWtnvU/8cHDTMKAeTeOoKUJhDlCdoq9A2E4xxCE9TSJpUTSwBMUbIsItyDnliuXnJONV/IiQYne4kw+9h1DVyiheXXQ0Ajl5Q0h8YeJIqw1/KdM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755070065; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qwCeVmGEu53ejk/m7Jpzmrjz6RmDqpItk7zrX+KeOYM=; 
	b=R5LIf2uZW6hBdwFn8P55OwqeCgIoPTMWDpjUm+vEcbSnw8YarAE+MF6GVi31cj3qDvbxNOItGlSnd2dTqf940btpCi52CMWRLUOve/LSgO1MrO3TCgkC3U0S99/Sfta3fhKYV2DXyy2xYBPqDmrJ6Vgzs8KtmYli+ve/s+EcqS8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755070065;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qwCeVmGEu53ejk/m7Jpzmrjz6RmDqpItk7zrX+KeOYM=;
	b=QAIiYdQk+dKpOA7XIhab9I69BaBfapHnhsFfLXGIQFXq5MJdw7DefEvIRsCiRVQl
	JRlfhVO3OKv8EcWZ6ap5FbXzljY1/ApslUtPdpddE0L8Tla5fFXiID0miXsUq9/8gCE
	AHi8BMBlWutfYhidxBcaMppQqwOQzi984RK1MYuKRsqapE+TCMQYpa5Nj/P6UOKnxvI
	PatPAo2j88neRvOJgJ4XRhs5I3b4crYKnDnTTJ1P+vdfYforHOMi5lq66DiL/hDLRyc
	9+lHf5PZ8UZmaTdXuhFR2pfl7L2uRI6OIKTlij8wAoK417RUUN7mQpvYJdjdDkZ7p0k
	LX1aZyXskA==
Received: by mx.zohomail.com with SMTPS id 1755070064343777.9781912401827;
	Wed, 13 Aug 2025 00:27:44 -0700 (PDT)
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
Subject: [PATCH v2 2/3] clk: thead: support changing DPU pixel clock rate
Date: Wed, 13 Aug 2025 15:27:01 +0800
Message-ID: <20250813072702.2176993-3-uwu@icenowy.me>
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

The DPU pixel clock rate corresponds to the required dot clock of the
display mode, so it needs to be tweakable.

Add support to change it, by adding generic divider setting code,
arming the code to the dpu0/dpu1 clocks, and setting the pixel clock
connected to the DPU (after a gate) to CLK_SET_RATE_PARENT to propagate
it to the dividers.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
Changes in v2:
- Dropped round_rate() because of deprecation.
- Changed the logic of determine_rate() to early return if the divider
  could be changed.

 drivers/clk/thead/clk-th1520-ap.c | 64 ++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 0b5458af8c550..b220a8ed22607 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -55,6 +55,7 @@ struct ccu_gate {
 
 struct ccu_div {
 	u32			enable;
+	u32			div_en;
 	struct ccu_div_internal	div;
 	struct ccu_internal	mux;
 	struct ccu_common	common;
@@ -198,6 +199,56 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
+static int ccu_div_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+	unsigned int val;
+
+	if (cd->div_en)
+		return divider_determine_rate(hw, req, NULL,
+					      cd->div.width, cd->div.flags);
+
+	regmap_read(cd->common.map, cd->common.cfg0, &val);
+	val = val >> cd->div.shift;
+	val &= GENMASK(cd->div.width - 1, 0);
+	return divider_ro_determine_rate(hw, req, NULL, cd->div.width,
+					 cd->div.flags, val);
+}
+
+static int ccu_div_set_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long parent_rate)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+	int val = divider_get_val(rate, parent_rate, NULL,
+				  cd->div.width, cd->div.flags);
+	unsigned int curr_val, reg_val;
+
+	if (val < 0)
+		return val;
+
+	regmap_read(cd->common.map, cd->common.cfg0, &reg_val);
+	curr_val = reg_val;
+	curr_val = curr_val >> cd->div.shift;
+	curr_val &= GENMASK(cd->div.width - 1, 0);
+
+	if (!cd->div_en && curr_val != val)
+		return -EINVAL;
+
+	reg_val &= ~cd->div_en;
+	regmap_write(cd->common.map, cd->common.cfg0, reg_val);
+	udelay(1);
+
+	reg_val &= ~GENMASK(cd->div.width + cd->div.shift - 1, cd->div.shift);
+	reg_val |= val << cd->div.shift;
+	regmap_write(cd->common.map, cd->common.cfg0, reg_val);
+
+	reg_val |= cd->div_en;
+	regmap_write(cd->common.map, cd->common.cfg0, reg_val);
+
+	return 0;
+}
+
 static u8 ccu_div_get_parent(struct clk_hw *hw)
 {
 	struct ccu_div *cd = hw_to_ccu_div(hw);
@@ -240,7 +291,8 @@ static const struct clk_ops ccu_div_ops = {
 	.get_parent	= ccu_div_get_parent,
 	.set_parent	= ccu_div_set_parent,
 	.recalc_rate	= ccu_div_recalc_rate,
-	.determine_rate	= clk_hw_determine_rate_no_reparent,
+	.set_rate	= ccu_div_set_rate,
+	.determine_rate = ccu_div_determine_rate,
 };
 
 static void ccu_pll_disable(struct clk_hw *hw)
@@ -784,6 +836,7 @@ static struct ccu_div venc_clk = {
 };
 
 static struct ccu_div dpu0_clk = {
+	.div_en		= BIT(8),
 	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
 	.common		= {
 		.clkid          = CLK_DPU0,
@@ -791,7 +844,7 @@ static struct ccu_div dpu0_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_HW("dpu0",
 					      dpu0_pll_clk_parent,
 					      &ccu_div_ops,
-					      0),
+					      CLK_SET_RATE_UNGATE),
 	},
 };
 
@@ -800,6 +853,7 @@ static const struct clk_parent_data dpu0_clk_pd[] = {
 };
 
 static struct ccu_div dpu1_clk = {
+	.div_en		= BIT(8),
 	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
 	.common		= {
 		.clkid          = CLK_DPU1,
@@ -807,7 +861,7 @@ static struct ccu_div dpu1_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_HW("dpu1",
 					      dpu1_pll_clk_parent,
 					      &ccu_div_ops,
-					      0),
+					      CLK_SET_RATE_UNGATE),
 	},
 };
 
@@ -891,9 +945,9 @@ static CCU_GATE(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk", video_pll_clk_pd,
 static CCU_GATE(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
 		video_pll_clk_pd, 0x0, BIT(4), 0);
 static CCU_GATE(CLK_DPU_PIXELCLK0, dpu0_pixelclk, "dpu0-pixelclk",
-		dpu0_clk_pd, 0x0, BIT(5), 0);
+		dpu0_clk_pd, 0x0, BIT(5), CLK_SET_RATE_PARENT);
 static CCU_GATE(CLK_DPU_PIXELCLK1, dpu1_pixelclk, "dpu1-pixelclk",
-		dpu1_clk_pd, 0x0, BIT(6), 0);
+		dpu1_clk_pd, 0x0, BIT(6), CLK_SET_RATE_PARENT);
 static CCU_GATE(CLK_DPU_HCLK, dpu_hclk, "dpu-hclk", video_pll_clk_pd, 0x0,
 		BIT(7), 0);
 static CCU_GATE(CLK_DPU_ACLK, dpu_aclk, "dpu-aclk", video_pll_clk_pd, 0x0,
-- 
2.50.1


