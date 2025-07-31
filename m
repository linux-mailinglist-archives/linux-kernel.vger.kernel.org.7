Return-Path: <linux-kernel+bounces-752344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D7CB17456
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0425458738D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F74E22F774;
	Thu, 31 Jul 2025 15:53:10 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A641E25F8;
	Thu, 31 Jul 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977189; cv=none; b=CfB3azJGdbhnaGhhCIOSq0ek+o7Qx8a0DaB7awXx0Doq2CIQg/hNaFYfuMEZK9sUifW5p8m3IVnsRxuJc847Qpp+ExIxaMGhAz3yrJo2XfgmNGJM+DuO4/dZLd718mdv733JacbIV0vejlkaCnmoKMbxQ/SdaG8hVks1Olj0Y24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977189; c=relaxed/simple;
	bh=HTPc1UvuM/9u3VpIMl/pl7TbdQEONkbtPQ3JDrKQ0yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fxl0w1Pw+FrXnKemh8vrmdlsnokM3J+wM8ZQIX8zBhxXnBn/YOBoZeURqzdGCpaiI1+uVpF824ZWPm0jwQ9hBwvsX26lerT8+Kw34NyvCvH7qPUyNs9lh5Qwfyu/ouadE2JZ8IJ4bv1SSoU/w/+aI++KDt/kx17x7aPKsM7y2t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id B04891C2714;
	Thu, 31 Jul 2025 17:52:58 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdc9:0:1347:874c:9851:58c6])
	by srv01.abscue.de (Postfix) with ESMTPSA id 114CB1C2713;
	Thu, 31 Jul 2025 17:52:58 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Thu, 31 Jul 2025 17:51:24 +0200
Subject: [PATCH v3 11/16] drm: sprd: add clock gating support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-ums9230-drm-v3-11-06d4f57c4b08@abscue.de>
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

Enable the DPU and DSI clocks specified in the device tree.
Disable the DSI clock when it is not needed.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/sprd/sprd_dpu.c | 7 +++++++
 drivers/gpu/drm/sprd/sprd_dpu.h | 1 +
 drivers/gpu/drm/sprd/sprd_dsi.c | 9 +++++++++
 drivers/gpu/drm/sprd/sprd_dsi.h | 4 +++-
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
index 0d9eb778794d92418b39f8535d94abde3566de43..9d274600e6a80bdfc435f6c6eff77c9dd71cb38c 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.c
+++ b/drivers/gpu/drm/sprd/sprd_dpu.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2020 Unisoc Inc.
  */
 
+#include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/delay.h>
 #include <linux/dma-buf.h>
@@ -794,6 +795,12 @@ static int sprd_dpu_context_init(struct sprd_dpu *dpu,
 	if (ctx->irq < 0)
 		return ctx->irq;
 
+	ctx->clk = devm_clk_get_optional_enabled(dev, "core");
+	if (IS_ERR(ctx->clk)) {
+		dev_err(dev, "failed to get DPU core clock\n");
+		return PTR_ERR(ctx->clk);
+	}
+
 	/* disable and clear interrupts before register dpu IRQ. */
 	writel(0x00, ctx->base + REG_DPU_INT_EN);
 	writel(0xff, ctx->base + REG_DPU_INT_CLR);
diff --git a/drivers/gpu/drm/sprd/sprd_dpu.h b/drivers/gpu/drm/sprd/sprd_dpu.h
index 157a78f24dc18b071602552ea9d005af66525263..d48b922de580a8a4bf07c4610c431d3321f7b810 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.h
+++ b/drivers/gpu/drm/sprd/sprd_dpu.h
@@ -44,6 +44,7 @@ enum {
  */
 struct dpu_context {
 	void __iomem *base;
+	struct clk *clk;
 	int irq;
 	u8 if_type;
 	struct videomode vm;
diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_dsi.c
index 071313b605447525326f6b869bc09991d4fcd691..0edb626eb35a7eeb759c2a2f5b8428cd3b092d1f 100644
--- a/drivers/gpu/drm/sprd/sprd_dsi.c
+++ b/drivers/gpu/drm/sprd/sprd_dsi.c
@@ -832,6 +832,8 @@ static void sprd_dsi_bridge_pre_enable(struct drm_bridge *bridge)
 	struct sprd_dsi *dsi = bridge_to_dsi(bridge);
 	struct dsi_context *ctx = &dsi->ctx;
 
+	clk_prepare_enable(ctx->clk);
+
 	sprd_dsi_init(ctx);
 	if (ctx->work_mode == DSI_MODE_VIDEO)
 		sprd_dsi_dpi_video(ctx);
@@ -886,6 +888,8 @@ static void sprd_dsi_bridge_post_disable(struct drm_bridge *bridge)
 
 	sprd_dphy_fini(ctx);
 	sprd_dsi_fini(ctx);
+
+	clk_disable_unprepare(ctx->clk);
 }
 
 static const struct drm_bridge_funcs sprd_dsi_bridge_funcs = {
@@ -1109,6 +1113,11 @@ static int sprd_dsi_probe(struct platform_device *pdev)
 	if (!dsi->ctx.pll.platform)
 		return -EINVAL;
 
+	dsi->ctx.clk = devm_clk_get_optional(dev, "pclk");
+	if (IS_ERR(dsi->ctx.clk))
+		return dev_err_probe(dev, PTR_ERR(dsi->ctx.clk),
+				     "failed to get pclk\n");
+
 	return mipi_dsi_host_register(&dsi->host);
 }
 
diff --git a/drivers/gpu/drm/sprd/sprd_dsi.h b/drivers/gpu/drm/sprd/sprd_dsi.h
index 1aa609b1da33601217941390673553552f2923b1..14d06236087255f15b2704a0aff2589889fda5e9 100644
--- a/drivers/gpu/drm/sprd/sprd_dsi.h
+++ b/drivers/gpu/drm/sprd/sprd_dsi.h
@@ -6,8 +6,9 @@
 #ifndef __SPRD_DSI_H__
 #define __SPRD_DSI_H__
 
-#include <linux/of.h>
+#include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <video/videomode.h>
 
@@ -93,6 +94,7 @@ struct dphy_pll {
 struct dsi_context {
 	void __iomem *base;
 	struct regmap *regmap;
+	struct clk *clk;
 	struct dphy_pll pll;
 	struct videomode vm;
 

-- 
2.50.0

