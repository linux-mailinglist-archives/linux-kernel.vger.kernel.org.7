Return-Path: <linux-kernel+bounces-764037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E132BB21D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E591A26D07
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65782C21E6;
	Tue, 12 Aug 2025 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="GsX8dMU6"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594882C21CA;
	Tue, 12 Aug 2025 05:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977428; cv=pass; b=GNTtj8guc9IlMxk5ZGU+QfNE2orPUkhTJbQqLqjwA3ynNwRmcX7dqieRxuyIrTEeLX4Aae5OGoBFVhbvzv/m1GeewSCDeUcEMEpqKyZO/DpXLKOKqejMJXlESU1IVwIxzyPDmJuJOI13OgvBXHE/JZbcaCQJMbNeFon7AJ69XzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977428; c=relaxed/simple;
	bh=Wu220zc6p3km7Rbp9OhMi7wlQ4l+2JDEpYuH/S59DMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIPjIk3G6pyevUJBP4BmRuqZG/qGaiR9LeyORx3+0MZ5Yz90nUMLECYZupbYQ2UB2sIHBI0YoaTZDt2tEUPp5HccCikPyDnhLUCQ1mkQo2DeEn+2TRbspESx2x0cWPRKNltxCU1/lvj3OBP5Gz+UFlkbECpHjRTQCNR7moDQWbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=GsX8dMU6; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1754977416; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jTa4kReGla+i9FaNIqUx2M0EjqQ6aDG6gJKhYfP3NiD0y2SmflqQU1NIKld9juo7WOtgFxQP+vfy3kEhF10NeIkX5v547KwFoTIPCM53kAGUYXU9mUobVFihdflG2QxvLjbEgoCeIoeatLyJLs/QvM5JoQt+dcJN44qufepkfTo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754977416; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=guBz41lPC7DvB/lzb2XzSOW9gC2s99ipDDYDjHrfLz0=; 
	b=BSHUNpee1RGTqu9yErYDfwaL/bJnfBOW+lYOfz+gZzn0M2YzIRWKRhrn60cWOSZv18n6jY5/BHYIaNnoMriFqvMES9sCG+hHKdcM8cXEKQAS/EacLcBG23eXtTLkYizECLOtkYPcam5s1jmMBt1nmjFLmq8nl4oBJtLiJME9M+8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754977416;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=guBz41lPC7DvB/lzb2XzSOW9gC2s99ipDDYDjHrfLz0=;
	b=GsX8dMU6lFWvIeRcBIndLbRsaYdLiWPz1/iuvx/XMrEaRxH9e+hncM4AYrq3euKC
	b3dRC1D8FPimt+NXyBMAjYSx6mhYxmo1VqEc4acrjo/qpImEaE2NP9zFJhu8+fxZuk/
	bOGD5Vg3zZdu7z9fApQ3OWtgAPcfAExoF+UFyzfcglsmw/NOBhE1i7rFR25+iJK3wyn
	vocFuZH6NWTysgLCWUzedd5ggKu0gSPkxsoZ3WundoKFTM3iyfelH1KzMsExQy0d6bH
	YTUSKCdtBaefHN12t1MrZo3Ft8LM+FwZUUaRofMDulVA+lqdwcKoBbAm4Io23v0G3LF
	fxxluq4qbw==
Received: by mx.zohomail.com with SMTPS id 1754977413726883.2183651266567;
	Mon, 11 Aug 2025 22:43:33 -0700 (PDT)
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
Subject: [PATCH 2/4] clk: thead: support changing DPU pixel clock rate
Date: Tue, 12 Aug 2025 13:42:56 +0800
Message-ID: <20250812054258.1968351-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812054258.1968351-1-uwu@icenowy.me>
References: <20250812054258.1968351-1-uwu@icenowy.me>
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
 drivers/clk/thead/clk-th1520-ap.c | 87 +++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 2f87c7c2c3baf..3e81f3051cd6c 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -55,6 +55,7 @@ struct ccu_gate {
 
 struct ccu_div {
 	u32			enable;
+	u32			div_en;
 	struct ccu_div_internal	div;
 	struct ccu_internal	mux;
 	struct ccu_common	common;
@@ -198,6 +199,78 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
+static long ccu_div_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *parent_rate)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+	unsigned int val;
+
+	if (!cd->div_en) {
+		regmap_read(cd->common.map, cd->common.cfg0, &val);
+		val = val >> cd->div.shift;
+		val &= GENMASK(cd->div.width - 1, 0);
+		return divider_ro_round_rate(hw, rate, parent_rate,
+					     NULL, cd->div.width, cd->div.flags,
+					     val);
+	} else {
+		return divider_round_rate(hw, rate, parent_rate,
+					  NULL, cd->div.width, cd->div.flags);
+	}
+}
+
+static int ccu_div_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+	unsigned int val;
+
+	if (!cd->div_en) {
+		regmap_read(cd->common.map, cd->common.cfg0, &val);
+		val = val >> cd->div.shift;
+		val &= GENMASK(cd->div.width - 1, 0);
+		return divider_ro_determine_rate(hw, req, NULL,
+						 cd->div.width,
+						 cd->div.flags,
+						 val);
+	} else {
+		return divider_determine_rate(hw, req, NULL,
+					      cd->div.width, cd->div.flags);
+	}
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
@@ -240,7 +313,9 @@ static const struct clk_ops ccu_div_ops = {
 	.get_parent	= ccu_div_get_parent,
 	.set_parent	= ccu_div_set_parent,
 	.recalc_rate	= ccu_div_recalc_rate,
-	.determine_rate	= clk_hw_determine_rate_no_reparent,
+	.round_rate	= ccu_div_round_rate,
+	.set_rate	= ccu_div_set_rate,
+	.determine_rate = ccu_div_determine_rate,
 };
 
 static void ccu_pll_disable(struct clk_hw *hw)
@@ -784,6 +859,7 @@ static struct ccu_div venc_clk = {
 };
 
 static struct ccu_div dpu0_clk = {
+	.div_en		= BIT(8),
 	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
 	.common		= {
 		.clkid          = CLK_DPU0,
@@ -791,7 +867,7 @@ static struct ccu_div dpu0_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_HW("dpu0",
 					      dpu0_pll_clk_parent,
 					      &ccu_div_ops,
-					      0),
+					      CLK_SET_RATE_UNGATE),
 	},
 };
 
@@ -800,6 +876,7 @@ static const struct clk_parent_data dpu0_clk_pd[] = {
 };
 
 static struct ccu_div dpu1_clk = {
+	.div_en		= BIT(8),
 	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
 	.common		= {
 		.clkid          = CLK_DPU1,
@@ -807,7 +884,7 @@ static struct ccu_div dpu1_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_HW("dpu1",
 					      dpu1_pll_clk_parent,
 					      &ccu_div_ops,
-					      0),
+					      CLK_SET_RATE_UNGATE),
 	},
 };
 
@@ -891,9 +968,9 @@ static CCU_GATE(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk", video_pll_clk_pd,
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


