Return-Path: <linux-kernel+bounces-771857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A88B28C48
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0055AC6D6E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE43A23D7EF;
	Sat, 16 Aug 2025 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="Uwps/YAx"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE02417E0;
	Sat, 16 Aug 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755335533; cv=pass; b=qqP+soVOzUE/gxJDC7ErP3rsE55ALAVha8Ym/kEVHHvNg8v8vAanxzd5vaBb7HNsESn7ZjSuL9oVj2j33Eh9/+M3Ywi3xLrpRPNoFQBXdbTT1N4V651/rRYImfYU9mTAoWfTMo8UW2EZo9dh5Wocm7dEpSv+P4dMrsOMh3RzEiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755335533; c=relaxed/simple;
	bh=aGkUmGlN10yE179iWrLQIRgpG+c0jWbhO5rLjjAXVyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPGj/lCAYu5of6FQ42tRPubgA1C5Ny2bzXm3HU/I/uEJkET1/oeA2YvcUeolIajBe8ciwfsXLyt2H/8BRUkFn/fqCCMdX2ZKPjrtcZUy/VOMFm2E2YHuOAlAlO35k4ISPlcvsCLzzRNcIcSrwjRlj/Lj4fzQYu2KR4Oj9+EROu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=Uwps/YAx; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755335518; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U6CIFpug0xxziIokhoB9i8HmWgDeTbjc/nJMo5OpOmicc7kv4SlEIpUeGpwyw9mHKWAEmQoIbvHahXRwDpfMuxmmc6y8PWQNfW3znzddYcqY7vTKd7xEkBBtlfH5A/nU9RWHlXiwFX58papjOevjl90YDzwhvcJe8aFm48pTfU4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755335518; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IfOkSg/KZHgyMQVZKkN/1zZNGFiTPGDUVuPxklU9Law=; 
	b=gQBIKRRMQX8q6Wb481adO4hGZz2mZPeyoeb1g1tPZuP+XD/hZR22M4YDPvYFb//1fyic+trAMlE+J2bOj5RFs4f2kFCLChuxmjonlpVfj2CFfM4ESNXImH1EKFzrM1u/yD2LhU81lk3gW6Oaf4Akir4381vrrnaIczCl4Rn5tuY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755335518;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IfOkSg/KZHgyMQVZKkN/1zZNGFiTPGDUVuPxklU9Law=;
	b=Uwps/YAxhPfmAeEVPNYgRMHMFbPxaGHdoQD68MhN/n1kXe11RJtOsWBBUOO4q0sq
	9shQUr3gxKpxS983HVmz/smd14plLp7Kmm1jpoLR/u1ndYdvsUUvhlVQ2kwA2mwt1E/
	xdOFsab+mE7pkwTGOTg0o5dUYQWncMc262zTYr5FIDL7JRg7psIYjM+HEqZv5glM2x4
	3Wj8fV1mSvsr2ilQNM9cLBVrIF5/iz4DcdkirC+RhEvby4UAlynYsb/oUpAPfCDLFGC
	XO8Z71ElqTXxYHXxWC0ZXhKLbWJKdKW3TIM9LBPSBxogMDRi+kKCG6ar/Gcm44TuDxv
	tQqs31eSEw==
Received: by mx.zohomail.com with SMTPS id 1755335515864443.2720325754219;
	Sat, 16 Aug 2025 02:11:55 -0700 (PDT)
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
Subject: [PATCH v3 3/4] clk: thead: support changing DPU pixel clock rate
Date: Sat, 16 Aug 2025 17:11:12 +0800
Message-ID: <20250816091113.2596048-4-uwu@icenowy.me>
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

The DPU pixel clock rate corresponds to the required dot clock of the
display mode, so it needs to be tweakable.

Add support to change it, by adding generic divider setting code,
arming the code to the dpu0/dpu1 clocks, and setting the pixel clock
connected to the DPU (after a gate) to CLK_SET_RATE_PARENT to propagate
it to the dividers.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Reviewed-by: Drew Fustini <fustini@kernel.org>
---
Changes in v2:
- Dropped round_rate() because of deprecation.
- Changed the logic of determine_rate() to early return if the divider
  could be changed.
Changes in v3:
- Rebased atop ccu_gate refactor.
- Fixed alignment issue of ccu_div_set_rate()'s signature.
- Removed a meaningless assignment to curr_val in ccu_div_set_rate()
  because of being immediately overriden.
- Added Drew's R-b.

 drivers/clk/thead/clk-th1520-ap.c | 63 ++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index d81445e24a96a..54222b3219ccf 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -56,6 +56,7 @@ struct ccu_gate {
 
 struct ccu_div {
 	u32			enable;
+	u32			div_en;
 	struct ccu_div_internal	div;
 	struct ccu_internal	mux;
 	struct ccu_common	common;
@@ -192,6 +193,55 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
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
+			    unsigned long parent_rate)
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
+	curr_val = reg_val >> cd->div.shift;
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
@@ -234,7 +284,8 @@ static const struct clk_ops ccu_div_ops = {
 	.get_parent	= ccu_div_get_parent,
 	.set_parent	= ccu_div_set_parent,
 	.recalc_rate	= ccu_div_recalc_rate,
-	.determine_rate	= clk_hw_determine_rate_no_reparent,
+	.set_rate	= ccu_div_set_rate,
+	.determine_rate = ccu_div_determine_rate,
 };
 
 static void ccu_pll_disable(struct clk_hw *hw)
@@ -778,6 +829,7 @@ static struct ccu_div venc_clk = {
 };
 
 static struct ccu_div dpu0_clk = {
+	.div_en		= BIT(8),
 	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
 	.common		= {
 		.clkid          = CLK_DPU0,
@@ -785,7 +837,7 @@ static struct ccu_div dpu0_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_HW("dpu0",
 					      dpu0_pll_clk_parent,
 					      &ccu_div_ops,
-					      0),
+					      CLK_SET_RATE_UNGATE),
 	},
 };
 
@@ -794,6 +846,7 @@ static const struct clk_parent_data dpu0_clk_pd[] = {
 };
 
 static struct ccu_div dpu1_clk = {
+	.div_en		= BIT(8),
 	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
 	.common		= {
 		.clkid          = CLK_DPU1,
@@ -801,7 +854,7 @@ static struct ccu_div dpu1_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_HW("dpu1",
 					      dpu1_pll_clk_parent,
 					      &ccu_div_ops,
-					      0),
+					      CLK_SET_RATE_UNGATE),
 	},
 };
 
@@ -889,9 +942,9 @@ static CCU_GATE(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk", video_pll_clk_pd,
 static CCU_GATE(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
 		video_pll_clk_pd, 0x0, 4, 0);
 static CCU_GATE(CLK_DPU_PIXELCLK0, dpu0_pixelclk, "dpu0-pixelclk",
-		dpu0_clk_pd, 0x0, 5, 0);
+		dpu0_clk_pd, 0x0, 5, CLK_SET_RATE_PARENT);
 static CCU_GATE(CLK_DPU_PIXELCLK1, dpu1_pixelclk, "dpu1-pixelclk",
-		dpu1_clk_pd, 0x0, 6, 0);
+		dpu1_clk_pd, 0x0, 6, CLK_SET_RATE_PARENT);
 static CCU_GATE(CLK_DPU_HCLK, dpu_hclk, "dpu-hclk", video_pll_clk_pd, 0x0,
 		7, 0);
 static CCU_GATE(CLK_DPU_ACLK, dpu_aclk, "dpu-aclk", video_pll_clk_pd, 0x0,
-- 
2.50.1


