Return-Path: <linux-kernel+bounces-795854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E352B3F8AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7017A165620
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C2D2EBBB3;
	Tue,  2 Sep 2025 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBdvvzeC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64E82EBBA8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802040; cv=none; b=aBMvoCWOJ+Tv4xT1ZHT3QdWb/sCiRav4afKnGOsXyhjU3ohVfeFJ91d6Tc1AvJlGsJuVf+QLu7YqOEZthllF7EfU+wywsKU+zixlOCqEcxlvyqSvTwVuzaOXOiAm7xB8Rjtw6cMfFzjyJ6dq7Wkrm9AtbAjAvIpROk7zRZzNj0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802040; c=relaxed/simple;
	bh=7Svl78fdjkekYvvvmJakT3vl7a++rf9bCz2XsnjQV4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KIBDum4X2ksqw0s0pkQANIeEBdbx/vydU+ZAjPZx8Ef0dtuMyTY5owppZMFgXs3JenAClW+bDFralzNRfVnp4xAntCfvx+aaw2ygKqWKM8BSiXuEfAGWyobUZPhYpqTin2daTltBRk3hqk4Jff+EC1hw/3HC06p0nEHIQAXI4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBdvvzeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10660C4CEED;
	Tue,  2 Sep 2025 08:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802040;
	bh=7Svl78fdjkekYvvvmJakT3vl7a++rf9bCz2XsnjQV4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aBdvvzeCJyAOacNl9ww7tG7Ycex5uHAurRNP0fc7DQDkETUV/4f56Ve/MPP/VZ8l2
	 xuusW6a2nReFzaN4V4M7/fmE/D82E/7NkA8bW81kATxnDRHBhXQaAe8DWEukvmsbu4
	 XxQDTvUzQSBXErRnsRwM50ywtZV6cL+Hqlugqvr39gq36hUO4fPM3um4nSEWj85+Yh
	 OSqIvF/+A4aVu3mNkt+FTFtvB0SgYiOCm49W7qchZ4YuVG92+CUqB70BPfVe+6GQMo
	 WRYRpmDw+YS9P0GpGeportunpvy87rteXc0lJ35RaFTZEoWaOqthkr7yIr5mtaXrzz
	 CQ+asghvEJJ1A==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:47 +0200
Subject: [PATCH 19/29] drm/tidss: Remove ftrace-like logs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-19-14ad5315da3f@kernel.org>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
In-Reply-To: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8372; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7Svl78fdjkekYvvvmJakT3vl7a++rf9bCz2XsnjQV4E=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVu/1KWQUCBYuUm2IkTx9ovBJ0cFH2Y9/RbZarzo46
 4vOnoOZHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiLEGMDTvNg1tXM7FOs/o3
 ++X+LRWMb940u0p/ts1v3V/w6JfuBlMhjSTvTdO2PMrVnP/m0gzNZ4z1yb8vmJ0U5ZZi2tSZtDT
 avejikdWv/D+/8zs32zkieNHmPXuDRV7MWikko20kus/0jd1cAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

These logs don't really log any information and create checkpatch
warnings. Remove them.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_crtc.c  |  6 ------
 drivers/gpu/drm/tidss/tidss_dispc.c |  4 ----
 drivers/gpu/drm/tidss/tidss_drv.c   | 16 ----------------
 drivers/gpu/drm/tidss/tidss_kms.c   |  4 ----
 drivers/gpu/drm/tidss/tidss_plane.c |  8 --------
 5 files changed, 38 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index f497138ad053ed4be207e12eeee6c304e1c949bd..091f82c86f53bc76c572de4723746af2e35ce1c1 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -92,12 +92,10 @@ static int tidss_crtc_atomic_check(struct drm_crtc *crtc,
 	struct tidss_crtc *tcrtc = to_tidss_crtc(crtc);
 	u32 hw_videoport = tcrtc->hw_videoport;
 	struct drm_display_mode *mode;
 	enum drm_mode_status ok;
 
-	dev_dbg(ddev->dev, "%s\n", __func__);
-
 	if (!crtc_state->enable)
 		return 0;
 
 	mode = &crtc_state->adjusted_mode;
 
@@ -326,12 +324,10 @@ static const struct drm_crtc_helper_funcs tidss_crtc_helper_funcs = {
 static int tidss_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct drm_device *ddev = crtc->dev;
 	struct tidss_device *tidss = to_tidss(ddev);
 
-	dev_dbg(ddev->dev, "%s\n", __func__);
-
 	tidss_runtime_get(tidss);
 
 	tidss_irq_enable_vblank(crtc);
 
 	return 0;
@@ -340,12 +336,10 @@ static int tidss_crtc_enable_vblank(struct drm_crtc *crtc)
 static void tidss_crtc_disable_vblank(struct drm_crtc *crtc)
 {
 	struct drm_device *ddev = crtc->dev;
 	struct tidss_device *tidss = to_tidss(ddev);
 
-	dev_dbg(ddev->dev, "%s\n", __func__);
-
 	tidss_irq_disable_vblank(crtc);
 
 	tidss_runtime_put(tidss);
 }
 
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 8b1d6b72f303b91fbf86f7d0e351800804757126..7d94c1142e8083dab00fcf5c652ae40f98baeabf 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -2863,12 +2863,10 @@ int dispc_runtime_resume(struct dispc_device *dispc)
 	return 0;
 }
 
 void dispc_remove(struct tidss_device *tidss)
 {
-	dev_dbg(tidss->dev, "%s\n", __func__);
-
 	tidss->dispc = NULL;
 }
 
 static int dispc_iomap_resource(struct platform_device *pdev, const char *name,
 				void __iomem **base)
@@ -3006,12 +3004,10 @@ int dispc_init(struct tidss_device *tidss)
 	struct dispc_device *dispc;
 	const struct dispc_features *feat;
 	unsigned int i, num_fourccs;
 	int r = 0;
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	feat = tidss->feat;
 
 	if (feat->subrev != DISPC_K2G) {
 		r = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
 		if (r)
diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 27d9a8fd541fc164f2fb2535f148432bd7895f46..1c8cc18bc53c3ea3c50368b9f55ab02a0a02fc77 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -31,45 +31,37 @@
 
 int tidss_runtime_get(struct tidss_device *tidss)
 {
 	int r;
 
-	dev_dbg(tidss->dev, "%s\n", __func__);
-
 	r = pm_runtime_resume_and_get(tidss->dev);
 	WARN_ON(r < 0);
 	return r;
 }
 
 void tidss_runtime_put(struct tidss_device *tidss)
 {
 	int r;
 
-	dev_dbg(tidss->dev, "%s\n", __func__);
-
 	pm_runtime_mark_last_busy(tidss->dev);
 
 	r = pm_runtime_put_autosuspend(tidss->dev);
 	WARN_ON(r < 0);
 }
 
 static int __maybe_unused tidss_pm_runtime_suspend(struct device *dev)
 {
 	struct tidss_device *tidss = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	return dispc_runtime_suspend(tidss->dispc);
 }
 
 static int __maybe_unused tidss_pm_runtime_resume(struct device *dev)
 {
 	struct tidss_device *tidss = dev_get_drvdata(dev);
 	int r;
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	r = dispc_runtime_resume(tidss->dispc);
 	if (r)
 		return r;
 
 	return 0;
@@ -77,21 +69,17 @@ static int __maybe_unused tidss_pm_runtime_resume(struct device *dev)
 
 static int __maybe_unused tidss_suspend(struct device *dev)
 {
 	struct tidss_device *tidss = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	return drm_mode_config_helper_suspend(&tidss->ddev);
 }
 
 static int __maybe_unused tidss_resume(struct device *dev)
 {
 	struct tidss_device *tidss = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	return drm_mode_config_helper_resume(&tidss->ddev);
 }
 
 static __maybe_unused const struct dev_pm_ops tidss_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tidss_suspend, tidss_resume)
@@ -125,12 +113,10 @@ static int tidss_probe(struct platform_device *pdev)
 	struct tidss_device *tidss;
 	struct drm_device *ddev;
 	int ret;
 	int irq;
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	tidss = devm_drm_dev_alloc(&pdev->dev, &tidss_driver,
 				   struct tidss_device, ddev);
 	if (IS_ERR(tidss))
 		return PTR_ERR(tidss);
 
@@ -226,12 +212,10 @@ static void tidss_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct tidss_device *tidss = platform_get_drvdata(pdev);
 	struct drm_device *ddev = &tidss->ddev;
 
-	dev_dbg(dev, "%s\n", __func__);
-
 	drm_dev_unregister(ddev);
 
 	drm_atomic_helper_shutdown(ddev);
 
 	tidss_irq_uninstall(ddev);
diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index c34eb90cddbeac634f281cf163d493ba75b7ea29..86eb5d97410bedced57129c2bbcd35f1719424c2 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -22,12 +22,10 @@
 static void tidss_atomic_commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *ddev = old_state->dev;
 	struct tidss_device *tidss = to_tidss(ddev);
 
-	dev_dbg(ddev->dev, "%s\n", __func__);
-
 	tidss_runtime_get(tidss);
 
 	drm_atomic_helper_commit_modeset_disables(ddev, old_state);
 	drm_atomic_helper_commit_planes(ddev, old_state, DRM_PLANE_COMMIT_ACTIVE_ONLY);
 	drm_atomic_helper_commit_modeset_enables(ddev, old_state);
@@ -243,12 +241,10 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 int tidss_modeset_init(struct tidss_device *tidss)
 {
 	struct drm_device *ddev = &tidss->ddev;
 	int ret;
 
-	dev_dbg(tidss->dev, "%s\n", __func__);
-
 	ret = drmm_mode_config_init(ddev);
 	if (ret)
 		return ret;
 
 	ddev->mode_config.min_width = 8;
diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
index 142ae81951a0916ccf7d3add1b83b011eca7f6b9..bd10bc1b9961571e6c6dee26698149fc9dd135b0 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -40,12 +40,10 @@ static int tidss_plane_atomic_check(struct drm_plane *plane,
 	struct drm_crtc_state *crtc_state;
 	u32 hw_plane = tplane->hw_plane_id;
 	u32 hw_videoport;
 	int ret;
 
-	dev_dbg(ddev->dev, "%s\n", __func__);
-
 	if (!new_plane_state->crtc) {
 		/*
 		 * The visible field is not reset by the DRM core but only
 		 * updated by drm_atomic_helper_check_plane_state(), set it
 		 * manually.
@@ -122,12 +120,10 @@ static void tidss_plane_atomic_update(struct drm_plane *plane,
 	struct tidss_plane *tplane = to_tidss_plane(plane);
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
 									   plane);
 	u32 hw_videoport;
 
-	dev_dbg(ddev->dev, "%s\n", __func__);
-
 	if (!new_state->visible) {
 		dispc_plane_enable(tidss->dispc, tplane->hw_plane_id, false);
 		return;
 	}
 
@@ -141,24 +137,20 @@ static void tidss_plane_atomic_enable(struct drm_plane *plane,
 {
 	struct drm_device *ddev = plane->dev;
 	struct tidss_device *tidss = to_tidss(ddev);
 	struct tidss_plane *tplane = to_tidss_plane(plane);
 
-	dev_dbg(ddev->dev, "%s\n", __func__);
-
 	dispc_plane_enable(tidss->dispc, tplane->hw_plane_id, true);
 }
 
 static void tidss_plane_atomic_disable(struct drm_plane *plane,
 				       struct drm_atomic_state *state)
 {
 	struct drm_device *ddev = plane->dev;
 	struct tidss_device *tidss = to_tidss(ddev);
 	struct tidss_plane *tplane = to_tidss_plane(plane);
 
-	dev_dbg(ddev->dev, "%s\n", __func__);
-
 	dispc_plane_enable(tidss->dispc, tplane->hw_plane_id, false);
 }
 
 static void drm_plane_destroy(struct drm_plane *plane)
 {

-- 
2.50.1


