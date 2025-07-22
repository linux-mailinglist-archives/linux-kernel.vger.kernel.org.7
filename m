Return-Path: <linux-kernel+bounces-741044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C197B0DF5B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9295BAC4527
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDE62ED146;
	Tue, 22 Jul 2025 14:41:56 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421AA2EBDC9;
	Tue, 22 Jul 2025 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195316; cv=none; b=TSRQ6GclKBUXSDMu1EV9eB8y+j3kjHRon+1A1zi18W4N65+Zr9tRZ9rqhe6WpOXUUl7tws9or84tMwR5tn6b+M/f+iqN5+Lusl1cA+5yThw6T6SK/ONABOWwNM0RTR26FQonxyTFWZS4Rwxku2ojV8x+FiYqrida0zZjHY10w+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195316; c=relaxed/simple;
	bh=TVTK872zpCQy8TG4vNuCBNcOPICQ66ZIPu3eNxgpM20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s//m3I3XE5crZiFV6yq0Cg2c3VDDRUcCQzyT0DforRRXxplAi/PZEC9HBHwEXJqAwkTNOTVWAKv5gQ46lTxJe7lvQrFepwHHLQsWW5uppLfKPtZMrTHqARR9lVG8x8SpWQZF1FqLXDWWIAimTZaMuKohljABdQIYWOo1mGDdO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 4442F1C06FD;
	Tue, 22 Jul 2025 16:41:44 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdcb:3c00:ce39:8bff:5db4:1ef8])
	by srv01.abscue.de (Postfix) with ESMTPSA id A92BA1C06E1;
	Tue, 22 Jul 2025 16:41:43 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Tue, 22 Jul 2025 16:41:14 +0200
Subject: [PATCH v2 12/15] drm: sprd: always initialize DPU and DSI
 registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250722-ums9230-drm-v2-12-054276ec213d@abscue.de>
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

When the Unisoc DRM driver is initialized for the first time to display
an image on the screen, reinitialize the display properly instead of
relying on the bootloader.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/sprd/sprd_dpu.c | 8 ++++++++
 drivers/gpu/drm/sprd/sprd_dsi.c | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
index 978d4947e1bc5cd5b13b1f25719268fa08b77297..b946d015133db44d2d3d0b18803ed887b2b7ae2e 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.c
+++ b/drivers/gpu/drm/sprd/sprd_dpu.c
@@ -456,6 +456,14 @@ static void sprd_dpu_init(struct sprd_dpu *dpu)
 	}
 
 	writel(int_mask, ctx->base + REG_DPU_INT_EN);
+
+	/*
+	 * The DPU is usually enabled by the bootloader to show
+	 * a splash screen. Stop it here when the kernel initializes
+	 * the display.
+	 */
+	if (!ctx->stopped)
+		sprd_dpu_stop(dpu);
 }
 
 static void sprd_dpu_fini(struct sprd_dpu *dpu)
diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_dsi.c
index 2af4273a6c73185084290c9d14b8ac18914d514b..7186d11bbdc753f52aba18995f4863b572f4fecb 100644
--- a/drivers/gpu/drm/sprd/sprd_dsi.c
+++ b/drivers/gpu/drm/sprd/sprd_dsi.c
@@ -954,7 +954,6 @@ static int sprd_dsi_context_init(struct sprd_dsi *dsi,
 	ctx->max_rd_time = 6000;
 	ctx->int0_mask = 0xffffffff;
 	ctx->int1_mask = 0xffffffff;
-	ctx->enabled = true;
 
 	return 0;
 }

-- 
2.50.0

