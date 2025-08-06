Return-Path: <linux-kernel+bounces-757695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73FEB1C59F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7211A3B3EFC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D54D288CB2;
	Wed,  6 Aug 2025 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnZidwA+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5014885D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482363; cv=none; b=ivJZ9SJu9uZX9dae3UqxelRqMWDTedzxPlztiuyn0ihW0xLwdo3wcrWrHfLI1UGEceI1lsBLQuom5lTaA3iChnI0Bt2ljtIiT7xGh7N+TM2FyjcEV2Xg81OSO4GX1BFk1ts1DYwdGur10ODv4XvF7sLkftaAUWy3ISvFwjC60nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482363; c=relaxed/simple;
	bh=mjSRFkYQWRi/DhpW/R0nsid3OLNzB9r+riIbu/8ICIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SsOSFesgMW8Ae82wiTVtHgas5tEevuo7OMgeZ9dCZzfeXTEI9CK65xwwMa9kSXjbcHSZLGa3pJhlrCVJOfMEcYZZTrH1borxZcXMkUOBV/C7XTpGtI1LZI/MCHOy33Jm25HgLeVxaUAWJUjKzVc3BowIpd866A3gI7dQpuU1ib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnZidwA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC680C4CEE7;
	Wed,  6 Aug 2025 12:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754482362;
	bh=mjSRFkYQWRi/DhpW/R0nsid3OLNzB9r+riIbu/8ICIc=;
	h=From:To:Cc:Subject:Date:From;
	b=lnZidwA+tuaQm2hZQ1afBj8ep4vYIoXGp3JNW2BhJLZMBgFujz4SJ0YA7EO5UOnnw
	 4XmQSpeNjEtnLhpRrN14e9GlpytEy6TaDifuf6uM9fA10VkGeFm1+zFIOVWzJoNoCW
	 sOFmM3OaqHffc0yNkGOBrJSNDUjQv6bY7eOy8tcx/kQgIp8YsD92TVgC1eLjQ/VeLq
	 cpPsCBIxfZ+/6BgbqJhDaucSi4jxLImiAuwRaPfJ1nA1Xkam5DHN/2+JBhErle7zwF
	 2pK1d7jxO7cCbIj9RYhZtktkhg5NHFvQ/rmivf8CPXHv/7ewglXSqVmFUABqyLU2dW
	 wui0CZfb+lB5g==
From: Sasha Levin <sashal@kernel.org>
To: tomi.valkeinen@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	laurent.pinchart+renesas@ideasonboard.com,
	ville.syrjala@linux.intel.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] drm/omapdrm: Pass format info to drm_helper_mode_fill_fb_struct()
Date: Wed,  6 Aug 2025 08:12:35 -0400
Message-Id: <20250806121235.622437-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 41ab92d35ccd ("drm: Make passing of format info to
drm_helper_mode_fill_fb_struct() mandatory") removed the fallback
format lookup in drm_helper_mode_fill_fb_struct(), making the
format info parameter mandatory.

The coccinelle script in commit a34cc7bf1034 ("drm: Allow the caller
to pass in the format info to drm_helper_mode_fill_fb_struct()")
correctly added NULL as the format parameter to omapdrm's call to
drm_helper_mode_fill_fb_struct(). However, omapdrm was subsequently
overlooked in the follow-up series that updated drivers to pass the
actual format info instead of NULL (commits b4d360701b76 through
3f019d749671 updated other drivers like amdgpu, exynos, i915, msm,
tegra, virtio, vmwgfx, etc., but omapdrm was not included).

This causes fb->format to be NULL, triggering a warning in
drm_framebuffer_init() at line 870 and causing framebuffer
initialization to fail with -EINVAL, followed by an oops when
drm_framebuffer_remove() tries to clean up the failed initialization.

Note: Unlike other drivers that were fixed to pass format info from
their fb_create() callbacks all the way down to avoid redundant lookups,
we don't do that here because omap_framebuffer_init() is also called
from the fbdev code path (omap_fbdev.c) which doesn't have the format
info readily available. Changing the function signature to accept format
info would require adding a format lookup in the fbdev caller, so the
total number of lookups would remain the same - we'd just be moving the
lookup from omap_framebuffer_init() to its fbdev caller.

Fixes: 41ab92d35ccd ("drm: Make passing of format info to drm_helper_mode_fill_fb_struct() mandatory")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index 30c81e2e5d6b..42da78bcb5a6 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -440,7 +440,7 @@ struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
 		plane->dma_addr  = 0;
 	}
 
-	drm_helper_mode_fill_fb_struct(dev, fb, NULL, mode_cmd);
+	drm_helper_mode_fill_fb_struct(dev, fb, format, mode_cmd);
 
 	ret = drm_framebuffer_init(dev, fb, &omap_framebuffer_funcs);
 	if (ret) {
-- 
2.39.5


