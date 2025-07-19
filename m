Return-Path: <linux-kernel+bounces-737721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE1EB0AFBB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25AA5653D6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55999239E7C;
	Sat, 19 Jul 2025 12:11:42 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ACC2264D0;
	Sat, 19 Jul 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752927101; cv=none; b=VSpPXx8uNpaN/moUh2m9cM6uuv0B/2wA1CCPoKPjX9O+JHruG9ME+TmrzSUxcRTr8wrNLbvfzhx+m9ye/zVJuTEtGXi0qLwn76nbJGNdruiuc2NOaIa4lqN/qNLWjvr45P3YLRtNjmcmVCU513g8hL+Xs9Dtzy1URrJzr4Kr2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752927101; c=relaxed/simple;
	bh=9kPI1mkOtT6JXNjSwzYEdE3cWgabfX6YNYnMxmr8Hic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RARzybuqj711Fqi8XeO7w9qufU0jeInt8NZAA9AIhveLryZmh5SLqRaAJk4bqos0N1DDbFfWS6RG8vv4WlhDUdqXbNRwtSSktIh8MUB5QZdnnUpf+/Br9y4H0oLJwhvVcWdt7UBhFiiiVQUB4s4c94v0BP89U6HuSTXBplBHD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id DD22E1C07FA;
	Sat, 19 Jul 2025 14:11:33 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdf7:4000:ceae:3606:9020:cd4f])
	by srv01.abscue.de (Postfix) with ESMTPSA id 4B0101C233B;
	Sat, 19 Jul 2025 14:11:33 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Sat, 19 Jul 2025 14:09:45 +0200
Subject: [PATCH 09/12] drm: sprd: add support for newer DPU versions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250719-ums9230-drm-v1-9-e4344a05eb3d@abscue.de>
References: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
In-Reply-To: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
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

Newer DPU revisions such as the one used in UMS9230 (version 5) do not
have internal MMU registers and also require different defaults for the
display interface configuration.

Check the DPU version register to account for these configuration
differences.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/sprd/sprd_dpu.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
index 575bcdb0e0bb30055ac5c3d0e65178cc9f6611f3..01906243a93e3306fbce5bf617838b517822a2b6 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.c
+++ b/drivers/gpu/drm/sprd/sprd_dpu.c
@@ -27,6 +27,7 @@
 #include "sprd_dsi.h"
 
 /* Global control registers */
+#define REG_DPU_VERSION	0x00
 #define REG_DPU_CTRL	0x04
 #define REG_DPU_CFG0	0x08
 #define REG_PANEL_SIZE	0x20
@@ -406,22 +407,31 @@ static void sprd_dpu_init(struct sprd_dpu *dpu)
 {
 	struct dpu_context *ctx = &dpu->ctx;
 	u32 int_mask = 0;
+	u32 dpu_version = readl(ctx->base + REG_DPU_VERSION);
 
 	writel(0x00, ctx->base + REG_BG_COLOR);
-	writel(0x00, ctx->base + REG_MMU_EN);
-	writel(0x00, ctx->base + REG_MMU_PPN1);
-	writel(0xffff, ctx->base + REG_MMU_RANGE1);
-	writel(0x00, ctx->base + REG_MMU_PPN2);
-	writel(0xffff, ctx->base + REG_MMU_RANGE2);
-	writel(0x1ffff, ctx->base + REG_MMU_VPN_RANGE);
+	if (dpu_version < 0x300) {
+		writel(0x00, ctx->base + REG_MMU_EN);
+		writel(0x00, ctx->base + REG_MMU_PPN1);
+		writel(0xffff, ctx->base + REG_MMU_RANGE1);
+		writel(0x00, ctx->base + REG_MMU_PPN2);
+		writel(0xffff, ctx->base + REG_MMU_RANGE2);
+		writel(0x1ffff, ctx->base + REG_MMU_VPN_RANGE);
+	}
 
 	if (ctx->if_type == SPRD_DPU_IF_DPI) {
 		/* use dpi as interface */
 		dpu_reg_clr(ctx, REG_DPU_CFG0, BIT_DPU_IF_EDPI);
-		/* disable Halt function for SPRD DSI */
-		dpu_reg_clr(ctx, REG_DPI_CTRL, BIT_DPU_DPI_HALT_EN);
-		/* select te from external pad */
-		dpu_reg_set(ctx, REG_DPI_CTRL, BIT_DPU_EDPI_FROM_EXTERNAL_PAD);
+
+		if (dpu_version < 0x300) {
+			/* disable Halt function for SPRD DSI */
+			dpu_reg_clr(ctx, REG_DPI_CTRL, BIT_DPU_DPI_HALT_EN);
+			/* select te from external pad */
+			dpu_reg_set(ctx, REG_DPI_CTRL, BIT_DPU_EDPI_FROM_EXTERNAL_PAD);
+		} else {
+			/* enable Halt function for SPRD DSI */
+			dpu_reg_set(ctx, REG_DPI_CTRL, BIT_DPU_DPI_HALT_EN);
+		}
 
 		/* enable dpu update done INT */
 		int_mask |= BIT_DPU_INT_UPDATE_DONE;

-- 
2.50.0

