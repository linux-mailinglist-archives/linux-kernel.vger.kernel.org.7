Return-Path: <linux-kernel+bounces-752337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CB5B1744B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D15416B290
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E446201270;
	Thu, 31 Jul 2025 15:53:08 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF921714C6;
	Thu, 31 Jul 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977188; cv=none; b=GVs41/KNqGIgTvlbnL7qqB7Q3V6RvDilzU8NRagyiRjdqMHOh4CInzh1fPDXugZCAD1eNskkdqDKXC5+RHfRTVXWSd+P0M1hc6eXgdje57/TW5iowOKqKAx1YppzEEj6sWvLWNBvEUH3VLB6pcNFpmvTKoQYm7t4m1hHridEUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977188; c=relaxed/simple;
	bh=g0G7XYNv76Ui/n2QbdZ3v+0NlnsKXvm8GwhIBAxnAB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVNMDZw17fDPX3jmUL+VXsgGCnSlGJSlhvQ5UgW//BoO+jd4oARDh/gCqTxohxUZ6IQWQQBuxVUYaXPaw/l+Fo6Yt+fDhI4sVN8c1iGjS1qJKMx6Kms0Ovbfvjx+7XkKd9JB0ICsLXkVWxKEasYjzkPCv5XytsvTQS789LDu2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 45CB71C26E9;
	Thu, 31 Jul 2025 17:52:57 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdc9:0:1347:874c:9851:58c6])
	by srv01.abscue.de (Postfix) with ESMTPSA id 93AB61C2712;
	Thu, 31 Jul 2025 17:52:56 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Thu, 31 Jul 2025 17:51:22 +0200
Subject: [PATCH v3 09/16] drm: sprd: fix DSI rate and PLL setup code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-ums9230-drm-v3-9-06d4f57c4b08@abscue.de>
References: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
In-Reply-To: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>, 
 Liviu Dudau <Liviu.Dudau@arm.com>, 
 Russell King <rmk+kernel@arm.linux.org.uk>, Eric Anholt <eric@anholt.net>, 
 Kevin Tang <kevin3.tang@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

Correct the initialization code to treat the hs_rate and lp_rate values
as hertz instead of kilohertz. While at it, fix a bit operation bug in
the PLL initialization code which caused a PLL register to be set to
zero instead of the desired value.

Fixes: 1c66496b1391 ("drm/sprd: add Unisoc's drm mipi dsi&dphy driver")
Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/sprd/megacores_pll.c | 7 +++----
 drivers/gpu/drm/sprd/sprd_dsi.c      | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sprd/megacores_pll.c b/drivers/gpu/drm/sprd/megacores_pll.c
index e5a18599678ab6e3771cd732dcca409ab2d59f72..f214f906b58fb006c4305de9b8b86b4a934f2074 100644
--- a/drivers/gpu/drm/sprd/megacores_pll.c
+++ b/drivers/gpu/drm/sprd/megacores_pll.c
@@ -23,13 +23,12 @@
 
 static int dphy_calc_pll_param(struct dphy_pll *pll)
 {
-	const u32 khz = 1000;
 	const u32 mhz = 1000000;
 	const unsigned long long factor = 100;
 	unsigned long long tmp;
 	int i;
 
-	pll->potential_fvco = pll->freq / khz;
+	pll->potential_fvco = pll->freq / mhz;
 
 	for (i = 0; i < 4; ++i) {
 		if (pll->potential_fvco >= pll->platform->band_low &&
@@ -89,7 +88,7 @@ static void dphy_set_pll_reg(struct dphy_pll *pll, struct regmap *regmap)
 	reg_val[3] = pll->vco_band | (pll->sdm_en << 1) | (pll->refin << 2);
 	reg_val[4] = pll->kint >> 12;
 	reg_val[5] = pll->kint >> 4;
-	reg_val[6] = pll->out_sel | ((pll->kint << 4) & 0xf);
+	reg_val[6] = pll->out_sel | ((pll->kint & 0xf) << 4);
 	reg_val[7] = 1 << 4;
 	reg_val[8] = pll->det_delay;
 
@@ -218,7 +217,7 @@ void dphy_timing_config(struct dsi_context *ctx)
 	u32 tmp = 0;
 
 	/* t_ui: 1 ui, byteck: 8 ui, half byteck: 4 ui */
-	t_ui = 1000 * scale / (pll->freq / 1000);
+	t_ui = 1000 * scale / (pll->freq / 1000000);
 	t_byteck = t_ui << 3;
 	t_half_byteck = t_ui << 2;
 	constant = t_ui << 1;
diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_dsi.c
index 106a0e7dac5cb89e6a96cc33a1698ec48c9f2745..071313b605447525326f6b869bc09991d4fcd691 100644
--- a/drivers/gpu/drm/sprd/sprd_dsi.c
+++ b/drivers/gpu/drm/sprd/sprd_dsi.c
@@ -390,7 +390,7 @@ static u32 fmt_to_coding(u32 fmt)
 static void sprd_dsi_init(struct dsi_context *ctx)
 {
 	struct sprd_dsi *dsi = container_of(ctx, struct sprd_dsi, ctx);
-	u32 byte_clk = dsi->slave->hs_rate / 8;
+	u32 byte_clk = dsi->slave->hs_rate / 8000;
 	u16 data_hs2lp, data_lp2hs, clk_hs2lp, clk_lp2hs;
 	u16 max_rd_time;
 	int div;
@@ -407,7 +407,7 @@ static void sprd_dsi_init(struct dsi_context *ctx)
 	dsi_reg_up(ctx, VIRTUAL_CHANNEL_ID, VIDEO_PKT_VCID, 0);
 	dsi_reg_up(ctx, VIRTUAL_CHANNEL_ID, GEN_RX_VCID, 0);
 
-	div = DIV_ROUND_UP(byte_clk, dsi->slave->lp_rate);
+	div = DIV_ROUND_UP(byte_clk, dsi->slave->lp_rate / 1000);
 	writel(div, ctx->base + TX_ESC_CLK_CONFIG);
 
 	max_rd_time = ns_to_cycle(ctx->max_rd_time, byte_clk);
@@ -449,7 +449,6 @@ static int sprd_dsi_dpi_video(struct dsi_context *ctx)
 {
 	struct sprd_dsi *dsi = container_of(ctx, struct sprd_dsi, ctx);
 	struct videomode *vm = &ctx->vm;
-	u32 byte_clk = dsi->slave->hs_rate / 8;
 	u16 bpp_x100;
 	u16 video_size;
 	u32 ratio_x1000;
@@ -471,7 +470,7 @@ static int sprd_dsi_dpi_video(struct dsi_context *ctx)
 	video_size = round_video_size(coding, vm->hactive);
 	bpp_x100 = calc_bytes_per_pixel_x100(coding);
 	video_size_step = calc_video_size_step(coding);
-	ratio_x1000 = byte_clk * 1000 / (vm->pixelclock / 1000);
+	ratio_x1000 = dsi->slave->hs_rate / 8 / (vm->pixelclock / 1000);
 	hline = vm->hactive + vm->hsync_len + vm->hfront_porch +
 		vm->hback_porch;
 

-- 
2.50.0

