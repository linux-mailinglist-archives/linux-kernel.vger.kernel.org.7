Return-Path: <linux-kernel+bounces-795853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AF9B3F8AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D275165BE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B92EBB85;
	Tue,  2 Sep 2025 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2F/k5jz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738972E762E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802038; cv=none; b=N9Ju21QRXYhbUfiqWADjYjzmj9EDZQEWe5WyWkBqTcd3n0/k47SDEwvBovj3A6P/1fNIvSERfpcg2xPegaeheYhZgPW7EjRUo0e5mSLCI2lkWGdpYpGVUzlCY3pK8AfBJjN5EiVjSwhOEqt2bQ3GvWYmo1IR1kc1AwKqHj50E2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802038; c=relaxed/simple;
	bh=d/ff0PDuWLbHG6Z1QmLyzIm6dtfVTMyQzlWGkSFNkGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oRA3U3+KGNAVoejwxwI/noOF21YKF3NoCNhkLH7Tgj+WMdt7oRojEZ7R8kGj5qEs8LzwBfNNYkzsstyefz4v77geqyEY0vTJxoUm7vJm0Xd4WS6X+T3BIYb9pl7lHPKR6mqeUGn0iGuZkc96DdB5ZXAPZjAzls3BHUIzVR+MZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2F/k5jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E19C4CEED;
	Tue,  2 Sep 2025 08:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802037;
	bh=d/ff0PDuWLbHG6Z1QmLyzIm6dtfVTMyQzlWGkSFNkGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K2F/k5jzK6w96n2awx0veEjVNayfWcUn3hY9VVOb+i4fcI5fTxl8ktwSqm2rUzAuY
	 YHCeV0IWGlWfCkDZSca7zp1nH8lIFLa0rfv8oXXl2yIQWRJePFVu3+wrmJpW1DzHb7
	 RK9baULFMOzZW7SPfzNvZRAU3Py+I1y2XvxvFixSMZW1HPh0WJOF9vrmZd0rYsuBdc
	 YPjg0rNcyKIwqRLwDQwhF88izsJJsRGIMO0QZyQamJXUidTnfEmbcuZEzxybvIQp7K
	 NWs9yJR8ndnk+uijtsxMnm5JaixpuqHK4Ov/Dg2hB583DQhTSo/jK9SqSNfdXavRJi
	 eesjs/0B+IF+g==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:46 +0200
Subject: [PATCH 18/29] drm/tidss: Convert to drm logging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-18-14ad5315da3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2942; i=mripard@kernel.org;
 h=from:subject:message-id; bh=d/ff0PDuWLbHG6Z1QmLyzIm6dtfVTMyQzlWGkSFNkGg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVu+5/Yfd7ld+cNceB6dMRoMwO/Fr739zRcnXRG+av
 vTvXv83HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi918y1js7hGa++eteVeAe
 OjkxqCvSI+nWrKW7owLvqCpzNfVOfB49O+Z3q9k2MdY138+HGV9Yy1hn2jJFZ6pfQdfdAuWbbRE
 ZfV8C3k74fHvxrEvdXL9F5h+IP2xa/bl3ncuDhGNJxZ+f/30FAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

DRM drivers should prefer the drm logging functions to the dev logging
ones when possible. Let's convert the existing dev_* logs to their drm
counterparts.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_crtc.c  | 4 ++--
 drivers/gpu/drm/tidss/tidss_dispc.c | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index da89fd01c3376352840185cd4ac355dd41fd5bb1..f497138ad053ed4be207e12eeee6c304e1c949bd 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -101,11 +101,11 @@ static int tidss_crtc_atomic_check(struct drm_crtc *crtc,
 
 	mode = &crtc_state->adjusted_mode;
 
 	ok = dispc_vp_mode_valid(dispc, hw_videoport, mode);
 	if (ok != MODE_OK) {
-		dev_dbg(ddev->dev, "%s: bad mode: %ux%u pclk %u kHz\n",
+		drm_dbg(ddev, "%s: bad mode: %ux%u pclk %u kHz\n",
 			__func__, mode->hdisplay, mode->vdisplay, mode->clock);
 		return -EINVAL;
 	}
 
 	if (drm_atomic_crtc_needs_modeset(crtc_state))
@@ -170,11 +170,11 @@ static void tidss_crtc_atomic_flush(struct drm_crtc *crtc,
 	struct tidss_crtc *tcrtc = to_tidss_crtc(crtc);
 	struct drm_device *ddev = crtc->dev;
 	struct tidss_device *tidss = to_tidss(ddev);
 	unsigned long flags;
 
-	dev_dbg(ddev->dev, "%s: %s is %sactive, %s modeset, event %p\n",
+	drm_dbg(ddev, "%s: %s is %sactive, %s modeset, event %p\n",
 		__func__, crtc->name, crtc->state->active ? "" : "not ",
 		drm_atomic_crtc_needs_modeset(crtc->state) ? "needs" : "doesn't need",
 		crtc->state->event);
 
 	/*
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 190d32ed53f84371456ccb997d1898ed5cef9db1..8b1d6b72f303b91fbf86f7d0e351800804757126 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1063,24 +1063,26 @@ struct dispc_bus_format *dispc_vp_find_bus_fmt(struct dispc_device *dispc,
 }
 
 int dispc_vp_bus_check(struct dispc_device *dispc, u32 hw_videoport,
 		       const struct drm_crtc_state *state)
 {
+	struct tidss_device *tidss = dispc->tidss;
+	struct drm_device *dev = &tidss->ddev;
 	const struct tidss_crtc_state *tstate = to_tidss_crtc_state(state);
 	const struct dispc_bus_format *fmt;
 
 	fmt = dispc_vp_find_bus_fmt(dispc, hw_videoport, tstate->bus_format,
 				    tstate->bus_flags);
 	if (!fmt) {
-		dev_dbg(dispc->dev, "%s: Unsupported bus format: %u\n",
+		drm_dbg(dev, "%s: Unsupported bus format: %u\n",
 			__func__, tstate->bus_format);
 		return -EINVAL;
 	}
 
 	if (dispc->feat->vp_bus_type[hw_videoport] != DISPC_VP_OLDI_AM65X &&
 	    fmt->is_oldi_fmt) {
-		dev_dbg(dispc->dev, "%s: %s is not OLDI-port\n",
+		drm_dbg(dev, "%s: %s is not OLDI-port\n",
 			__func__, dispc->feat->vp_name[hw_videoport]);
 		return -EINVAL;
 	}
 
 	return 0;

-- 
2.50.1


