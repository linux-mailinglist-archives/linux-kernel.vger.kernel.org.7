Return-Path: <linux-kernel+bounces-752343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C7EB17458
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26311C2432C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4AD22F764;
	Thu, 31 Jul 2025 15:53:10 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3539C1E32D7;
	Thu, 31 Jul 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977189; cv=none; b=FlpS60Bpp134F5GFSWZAgd3lgm83jIr9yK1XQQGYRYyaCUoDIyTgrOV12RuXELgZX6c3fKCXssPda/FJPESqYx6r5gHNX9swhFnH56l1PYvSXApg+FLjbFgPpp727S35DmpWnUgJEbZg3Ohnjz+msnCgwYSuB+qBSuEA+ECysks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977189; c=relaxed/simple;
	bh=4bxQLOtRkyl6SeRQbTil/FKNSHg0sfy6UDXeqn90ijA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LRmDmHYxBwRft+P5dUS+wh7t+hcSxWBqxNfzJvPh9V5IORhcGfufJfx1lBawnpTa0x/p6aEWo62M7SS8XKYpy29LQ1W1V8+XmHuxQG/HubP/YZ4Yqhtw1WKFxmHpJpU7ISvGyb2H2RuSdtHP+BDjHrI6AU9hITCM95qv/HOlRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 710FD1C2727;
	Thu, 31 Jul 2025 17:52:59 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdc9:0:1347:874c:9851:58c6])
	by srv01.abscue.de (Postfix) with ESMTPSA id BFFE11C2715;
	Thu, 31 Jul 2025 17:52:58 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Thu, 31 Jul 2025 17:51:25 +0200
Subject: [PATCH v3 12/16] drm: sprd: add support for newer DPU versions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-ums9230-drm-v3-12-06d4f57c4b08@abscue.de>
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

Newer DPU revisions with the same register layout, such as the one used
in UMS9230 (version 5), require different defaults for the display
interface configuration but otherwise remain compatible with the version
this driver was originally written for.

Check the DPU version register to account for these configuration
differences.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/sprd/sprd_dpu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
index 9d274600e6a80bdfc435f6c6eff77c9dd71cb38c..978d4947e1bc5cd5b13b1f25719268fa08b77297 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.c
+++ b/drivers/gpu/drm/sprd/sprd_dpu.c
@@ -27,6 +27,7 @@
 #include "sprd_dsi.h"
 
 /* Global control registers */
+#define REG_DPU_VERSION	0x00
 #define REG_DPU_CTRL	0x04
 #define REG_DPU_CFG0	0x08
 #define REG_PANEL_SIZE	0x20
@@ -406,6 +407,7 @@ static void sprd_dpu_init(struct sprd_dpu *dpu)
 {
 	struct dpu_context *ctx = &dpu->ctx;
 	u32 int_mask = 0;
+	u32 dpu_version = readl(ctx->base + REG_DPU_VERSION);
 
 	writel(0x00, ctx->base + REG_BG_COLOR);
 	writel(0x00, ctx->base + REG_MMU_EN);
@@ -418,10 +420,16 @@ static void sprd_dpu_init(struct sprd_dpu *dpu)
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

