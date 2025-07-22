Return-Path: <linux-kernel+bounces-741039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CE5B0DF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1021C5807FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6A32ECD3F;
	Tue, 22 Jul 2025 14:41:56 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFFF2EB5D6;
	Tue, 22 Jul 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195315; cv=none; b=K46bbEGE77vqapqaNK6vm5knprBGJhcECOnEqJ2wa2Knjs+/BHYbAa/uNiO/VtPYdB/S3kfzy9B3YQVt2Dlz1QVtkgYwq90SslGuTJ/Dlw0IPB/SD/ToQbU62OgGV94CAz7Fz6tQ1PmAZOCLSa0FVOj/wbdGAJBe3The60PI2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195315; c=relaxed/simple;
	bh=FiT2Q45UrQFxr8dzUDpwjn5sQC5u7j1tzukTU1PlS7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QKwni0aaOUw15Q1O0cP+3eNucVPiSne+rHWVek9scFQpVQwI61Jg6L1Qh4HfYnrAo/rCRXOlbh2Pjd0Gjj/0fLW87X1vLnNTGCcEUVmrDWJa47324JpxFClxkePn94ThXO8U9K6cPbUSsq0eEHCKEerQjJ7nhAxxkdBbNTiXo38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 03F951C0628;
	Tue, 22 Jul 2025 16:41:43 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdcb:3c00:ce39:8bff:5db4:1ef8])
	by srv01.abscue.de (Postfix) with ESMTPSA id 5482A1C06CA;
	Tue, 22 Jul 2025 16:41:42 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Tue, 22 Jul 2025 16:41:12 +0200
Subject: [PATCH v2 10/15] drm: sprd: add clock gating support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250722-ums9230-drm-v2-10-054276ec213d@abscue.de>
References: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
In-Reply-To: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>
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
index e01d1d28fe579644ec2e0c83ec9170269932adfe..2af4273a6c73185084290c9d14b8ac18914d514b 100644
--- a/drivers/gpu/drm/sprd/sprd_dsi.c
+++ b/drivers/gpu/drm/sprd/sprd_dsi.c
@@ -828,6 +828,8 @@ static void sprd_dsi_bridge_pre_enable(struct drm_bridge *bridge)
 	struct sprd_dsi *dsi = bridge_to_dsi(bridge);
 	struct dsi_context *ctx = &dsi->ctx;
 
+	clk_prepare_enable(ctx->clk);
+
 	if (ctx->enabled) {
 		drm_warn(dsi->drm, "dsi is initialized\n");
 		return;
@@ -875,6 +877,8 @@ static void sprd_dsi_bridge_post_disable(struct drm_bridge *bridge)
 	sprd_dphy_fini(ctx);
 	sprd_dsi_fini(ctx);
 
+	clk_disable_unprepare(ctx->clk);
+
 	ctx->enabled = false;
 }
 
@@ -1098,6 +1102,11 @@ static int sprd_dsi_probe(struct platform_device *pdev)
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
index e5a0bd42eb548a9b85a60d79a74412b39ffa5c7c..f8bcef13ffd36aa7d98403ea22d50b8532043473 100644
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
 	bool enabled;

-- 
2.50.0

