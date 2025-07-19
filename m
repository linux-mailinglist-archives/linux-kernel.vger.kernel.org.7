Return-Path: <linux-kernel+bounces-737723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9029FB0AFC1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B065654AD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D57123B625;
	Sat, 19 Jul 2025 12:11:43 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B342264D9;
	Sat, 19 Jul 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752927102; cv=none; b=O5bfiEoieDUHsV2GaShGt3dTO6BEX5WojMTZmt1BlVuSudBmz95gI/VV2qOhjxzK2IX/ZiGd9Z3CBdaMYzKbo/wDAt9FxxhB4CdLmYqoDtp8ZQNxfI+Nt0Z3DScVn7VvL9ZLQyVzJ56lAlyI0KQnn5HMT2fFDVRCmDQ/bX7YbFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752927102; c=relaxed/simple;
	bh=ZiQUQF+BjeNHywjLEVTjcwSGXmOeIYTG6vQ1lL4MdWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rXN/0ZzkdK/RXtyxwHOfxuxkbDEynUNr0Hxu6BzxMK+2mLGnp//uFWl8p35L6g10Yd+l+NexwE+Z3RDqztGc8wnGgE0JkiWUM0zJkCR9ym4Ithmnl6sGBmnkzXdiynW54bixBdJRyJP7Dq0w+F55xxqvW3s6RnPzNT4dlVis/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 8743E1C233D;
	Sat, 19 Jul 2025 14:11:34 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdf7:4000:ceae:3606:9020:cd4f])
	by srv01.abscue.de (Postfix) with ESMTPSA id EC0041C233C;
	Sat, 19 Jul 2025 14:11:33 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Sat, 19 Jul 2025 14:09:46 +0200
Subject: [PATCH 10/12] drm: sprd: always initialize DPU and DSI registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250719-ums9230-drm-v1-10-e4344a05eb3d@abscue.de>
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

When the Unisoc DRM driver is initialized for the first time to display
an image on the screen, reinitialize the display properly instead of
relying on the bootloader.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/sprd/sprd_dpu.c | 8 ++++++++
 drivers/gpu/drm/sprd/sprd_dsi.c | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
index 01906243a93e3306fbce5bf617838b517822a2b6..be7758ef445b1b87b8ce6bd2001a15fa0f24f4d3 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.c
+++ b/drivers/gpu/drm/sprd/sprd_dpu.c
@@ -458,6 +458,14 @@ static void sprd_dpu_init(struct sprd_dpu *dpu)
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
index e781e6c84860402f37352e768244d88ca6ffd4c9..dd9e3179cef985ec39155994c122a6288ac4b2f8 100644
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

