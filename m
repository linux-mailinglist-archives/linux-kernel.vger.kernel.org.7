Return-Path: <linux-kernel+bounces-622049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C23A9E26E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 12:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52271899D57
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 10:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948B524A067;
	Sun, 27 Apr 2025 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7z0ZI70"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F3A19CC0A
	for <linux-kernel@vger.kernel.org>; Sun, 27 Apr 2025 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745749145; cv=none; b=S+9yJMA0Eutqk4d3hCm8XvRylLM9DqZwKsVpTkUhx1MD/Weyb/FjC2x+vpSQKGqlVbcJFL/AgFvADSPaI9FDEpxivjMkzghlUIxSECrVNOdvFGtCaLzJ+nh2wjc2nVZk2s5pHwTzMHLYITVq/BpZ1Gwsf3yR6eGjrqVPsrxhL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745749145; c=relaxed/simple;
	bh=f6oQAHv8XcTji16n4WFZF4JPbhq5JuIoJQUdN7c2sJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRDRG2dL6wYWuWadgEkcIFu+LsLMGLIPONT0dlWBej6SiNfq65WqsISSY9adsfvkgeFf9MAZVwauI+bkXe9HAjCjtHLrdc9KbOHuKXO702Dr5IkBKClM/UqubDo7tz5KjgHPZCi8eccedEBDmRiqf0SWqQFi7hNRjm5ynMJcqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7z0ZI70; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745749142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9+v4wOCNV6tvzFhwPQJvKPdmrruUARfRcsDWPDyGn/4=;
	b=C7z0ZI70B700KdN6stQqdUPh4hXRZQIfjTaxzzmy+Xbt/ouWapkoPfKCDx1/X3I82xS2CU
	DSHTeHwr8U7dw9EjSZjEUR4oJBYqheFmDVrjsYRkOOWg7hFXNEIZCc2ATMejoYCqOZ1ct1
	cstdHMM1ymEqdPUxnb2oluLo4q7auXc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-svf7pwkSNeaF_ksqG4h-Ng-1; Sun, 27 Apr 2025 06:19:00 -0400
X-MC-Unique: svf7pwkSNeaF_ksqG4h-Ng-1
X-Mimecast-MFC-AGG-ID: svf7pwkSNeaF_ksqG4h-Ng_1745749140
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-229668c8659so27268165ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Apr 2025 03:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745749139; x=1746353939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+v4wOCNV6tvzFhwPQJvKPdmrruUARfRcsDWPDyGn/4=;
        b=DLJrktgRU8Xh8zxdXGwUY+6nzxEn0OrW8E54IumhKIGKAhuV4fvNhICHwPEjr8sJLD
         rpo/FxXxajgx6SC3SHlh+YdBA4zsuZ4LYrZok7S05P/1d7ARPzUyd94u/wjVIC37emAY
         4cUV50U4Up73w1Vzd18njzOCdeqZJj1mgtCtP0aE03hdggAFlx11CuBfi9dshTVhSC2x
         T+VH0E9qQ0WG8hElb+QXMdiMCq1aN7GL1lns5WTjX8EcxjCIxyoSA5MdoRrNImV4qQUF
         S9rPRRifiZ7y9Yjm26QlXIVdxK8u6zmZ2aD4U8fMCVbgeYs6AECcEzLKULRhDRKjxOLm
         fQvA==
X-Forwarded-Encrypted: i=1; AJvYcCXEP8u+H/UQEWJQ71fSXEewLr3uEyWYqzngdLhmpTdK7VlKk7SdGdNGhAysbLVldSiOPwHLJ+ZMmVv7Rio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7I4wTyuo780N5mUahGWVXQvAAHMXvRPPJEzz9X26sKtUaPvi
	wCBYIdr/8y3Yd7U1QGNbcGEfCMu5ZPU3Scq/btbxFfcyMd45TyTr+EZOffbNmNuhIEj/p10OcWZ
	fd0VowGaGqdAf02s0Ya/wlbuCR8G+zCzREqUJvRpi+4SvHas+LBWZhpTvSCnqcA==
X-Gm-Gg: ASbGncstXKZxnQq1vZZmX45LnesOmRv5dxssWFPQkY6fSAFua4hXF7R4BzOBGZfXHbS
	mrtkA0f4JHVHtbn6wMx4PH/jzrx7EVANViTVH8RE1gElXGd386cXhN9raytl58q3M1HDje/tRMy
	A+PNWdwUIRCMJtqQmh7SF3RrCp5lvqcZ1kUfU2MV9H6kR4nHuUKVH/KZTDdZvLinVOqB2IQV9vq
	FvPmgHfj3n+9ukzzimyQXI0HYMDsOo+0Vhr0P6pIaclz+UoL7STB/xIvMEaAMcN4dd532c1zhcq
	DrYA6I3QayWV
X-Received: by 2002:a17:903:2f8b:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-22dbf5f6beemr128109605ad.29.1745749139550;
        Sun, 27 Apr 2025 03:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK7Jkqi9vj3wlE/4s3AevP7Y0WYnPDmdeX5KtI/4burvDq4WIg9Amk17i/XjHIWtNKayWsaQ==
X-Received: by 2002:a17:903:2f8b:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-22dbf5f6beemr128109375ad.29.1745749139189;
        Sun, 27 Apr 2025 03:18:59 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d771b3sm61710855ad.36.2025.04.27.03.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 03:18:58 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: drawat.floss@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	javierm@redhat.com,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH drm-next v3] drm/hyperv: Replace simple-KMS with regular atomic helpers
Date: Sun, 27 Apr 2025 19:18:23 +0900
Message-ID: <20250427101825.812766-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop simple-KMS in favor of regular atomic helpers to make the code more
modular. The simple-KMS helper mix up plane and CRTC state, so it is
obsolete and should go away [1]. Since it just split the simple-pipe
functions into per-plane and per-CRTC, no functional changes is
expected.

[1] https://lore.kernel.org/lkml/dae5089d-e214-4518-b927-5c4149babad8@suse.de/

Acked-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>

---
v3:
- Remove hyperv_crtc_helper_atomic_disable
- Use drm_atomic_get_new_plane_state instead of accessing the
  plane->state directly
- Iterate and handle each damage areas instead of merge these damage
  areas

v2:
https://lore.kernel.org/lkml/20250425063234.757344-1-ryasuoka@redhat.com/

- Remove hyperv_crtc_helper_mode_valid
- Remove hyperv_format_mod_supported
- Call helper_add after {plane,crtc}_init
- Move drm_plane_enable_fb_damage_clips to a place close to plane init
- Move hyperv_conn_init() into hyperv_pipe_init
- Remove hyperv_blit_to_vram_fullscreen
- Remove format check
- Replace hyperv_crtc_helper_atomic_check to drm_crtc_helper_atomic_check

v1:
https://lore.kernel.org/all/20250420121945.573915-1-ryasuoka@redhat.com/

 drivers/gpu/drm/hyperv/hyperv_drm.h         |   4 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 172 +++++++++++++-------
 2 files changed, 115 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h b/drivers/gpu/drm/hyperv/hyperv_drm.h
index d2d8582b36df..9e776112c03e 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm.h
+++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
@@ -11,7 +11,9 @@
 struct hyperv_drm_device {
 	/* drm */
 	struct drm_device dev;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 	struct drm_connector connector;
 
 	/* mode */
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 6c6b57298797..f7d2e973f79e 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -5,6 +5,8 @@
 
 #include <linux/hyperv.h>
 
+#include <drm/drm_atomic.h>
+#include <drm/drm_crtc_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
@@ -15,7 +17,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_plane.h>
 
 #include "hyperv_drm.h"
 
@@ -38,18 +40,6 @@ static int hyperv_blit_to_vram_rect(struct drm_framebuffer *fb,
 	return 0;
 }
 
-static int hyperv_blit_to_vram_fullscreen(struct drm_framebuffer *fb,
-					  const struct iosys_map *map)
-{
-	struct drm_rect fullscreen = {
-		.x1 = 0,
-		.x2 = fb->width,
-		.y1 = 0,
-		.y2 = fb->height,
-	};
-	return hyperv_blit_to_vram_rect(fb, map, &fullscreen);
-}
-
 static int hyperv_connector_get_modes(struct drm_connector *connector)
 {
 	struct hyperv_drm_device *hv = to_hv(connector->dev);
@@ -98,30 +88,66 @@ static int hyperv_check_size(struct hyperv_drm_device *hv, int w, int h,
 	return 0;
 }
 
-static void hyperv_pipe_enable(struct drm_simple_display_pipe *pipe,
-			       struct drm_crtc_state *crtc_state,
-			       struct drm_plane_state *plane_state)
+static const uint32_t hyperv_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+static const uint64_t hyperv_modifiers[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_INVALID
+};
+
+static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					     struct drm_atomic_state *state)
 {
-	struct hyperv_drm_device *hv = to_hv(pipe->crtc.dev);
-	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct hyperv_drm_device *hv = to_hv(crtc->dev);
+	struct drm_plane *plane = &hv->plane;
+	struct drm_plane_state *plane_state = plane->state;
+	struct drm_crtc_state *crtc_state = crtc->state;
 
 	hyperv_hide_hw_ptr(hv->hdev);
 	hyperv_update_situation(hv->hdev, 1,  hv->screen_depth,
 				crtc_state->mode.hdisplay,
 				crtc_state->mode.vdisplay,
 				plane_state->fb->pitches[0]);
-	hyperv_blit_to_vram_fullscreen(plane_state->fb, &shadow_plane_state->data[0]);
 }
 
-static int hyperv_pipe_check(struct drm_simple_display_pipe *pipe,
-			     struct drm_plane_state *plane_state,
-			     struct drm_crtc_state *crtc_state)
+static const struct drm_crtc_helper_funcs hyperv_crtc_helper_funcs = {
+	.atomic_check = drm_crtc_helper_atomic_check,
+	.atomic_enable = hyperv_crtc_helper_atomic_enable,
+};
+
+static const struct drm_crtc_funcs hyperv_crtc_funcs = {
+	.reset = drm_atomic_helper_crtc_reset,
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static int hyperv_plane_atomic_check(struct drm_plane *plane,
+				     struct drm_atomic_state *state)
 {
-	struct hyperv_drm_device *hv = to_hv(pipe->crtc.dev);
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct hyperv_drm_device *hv = to_hv(plane->dev);
 	struct drm_framebuffer *fb = plane_state->fb;
+	struct drm_crtc *crtc = plane_state->crtc;
+	struct drm_crtc_state *crtc_state = NULL;
+	int ret;
 
-	if (fb->format->format != DRM_FORMAT_XRGB8888)
-		return -EINVAL;
+	if (crtc)
+		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, false);
+	if (ret)
+		return ret;
+
+	if (!plane_state->visible)
+		return 0;
 
 	if (fb->pitches[0] * fb->height > hv->fb_size) {
 		drm_err(&hv->dev, "fb size requested by %s for %dX%d (pitch %d) greater than %ld\n",
@@ -132,53 +158,85 @@ static int hyperv_pipe_check(struct drm_simple_display_pipe *pipe,
 	return 0;
 }
 
-static void hyperv_pipe_update(struct drm_simple_display_pipe *pipe,
-			       struct drm_plane_state *old_state)
+static void hyperv_plane_atomic_update(struct drm_plane *plane,
+				       struct drm_atomic_state *state)
 {
-	struct hyperv_drm_device *hv = to_hv(pipe->crtc.dev);
-	struct drm_plane_state *state = pipe->plane.state;
-	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
-	struct drm_rect rect;
-
-	if (drm_atomic_helper_damage_merged(old_state, state, &rect)) {
-		hyperv_blit_to_vram_rect(state->fb, &shadow_plane_state->data[0], &rect);
-		hyperv_update_dirt(hv->hdev, &rect);
+	struct hyperv_drm_device *hv = to_hv(plane->dev);
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
+	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(new_state);
+	struct drm_rect damage;
+	struct drm_rect dst_clip;
+	struct drm_atomic_helper_damage_iter iter;
+
+	drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
+	drm_atomic_for_each_plane_damage(&iter, &damage) {
+		dst_clip = new_state->dst;
+
+		if (!drm_rect_intersect(&dst_clip, &damage))
+			continue;
+
+		hyperv_blit_to_vram_rect(new_state->fb, &shadow_plane_state->data[0], &damage);
+		hyperv_update_dirt(hv->hdev, &damage);
 	}
 }
 
-static const struct drm_simple_display_pipe_funcs hyperv_pipe_funcs = {
-	.enable	= hyperv_pipe_enable,
-	.check = hyperv_pipe_check,
-	.update	= hyperv_pipe_update,
-	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
+static const struct drm_plane_helper_funcs hyperv_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check = hyperv_plane_atomic_check,
+	.atomic_update = hyperv_plane_atomic_update,
 };
 
-static const uint32_t hyperv_formats[] = {
-	DRM_FORMAT_XRGB8888,
+static const struct drm_plane_funcs hyperv_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.destroy		= drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
 };
 
-static const uint64_t hyperv_modifiers[] = {
-	DRM_FORMAT_MOD_LINEAR,
-	DRM_FORMAT_MOD_INVALID
+static const struct drm_encoder_funcs hyperv_drm_simple_encoder_funcs_cleanup = {
+	.destroy = drm_encoder_cleanup,
 };
 
 static inline int hyperv_pipe_init(struct hyperv_drm_device *hv)
 {
+	struct drm_device *dev = &hv->dev;
+	struct drm_encoder *encoder = &hv->encoder;
+	struct drm_plane *plane = &hv->plane;
+	struct drm_crtc *crtc = &hv->crtc;
+	struct drm_connector *connector = &hv->connector;
 	int ret;
 
-	ret = drm_simple_display_pipe_init(&hv->dev,
-					   &hv->pipe,
-					   &hyperv_pipe_funcs,
-					   hyperv_formats,
-					   ARRAY_SIZE(hyperv_formats),
-					   hyperv_modifiers,
-					   &hv->connector);
+	ret = drm_universal_plane_init(dev, plane, 0,
+				       &hyperv_plane_funcs,
+				       hyperv_formats, ARRAY_SIZE(hyperv_formats),
+				       hyperv_modifiers,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(plane, &hyperv_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(plane);
+
+	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
+					&hyperv_crtc_funcs, NULL);
 	if (ret)
 		return ret;
+	drm_crtc_helper_add(crtc, &hyperv_crtc_helper_funcs);
 
-	drm_plane_enable_fb_damage_clips(&hv->pipe.plane);
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+	ret = drm_encoder_init(dev, encoder,
+			       &hyperv_drm_simple_encoder_funcs_cleanup,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
 
-	return 0;
+	ret = hyperv_conn_init(hv);
+	if (ret) {
+		drm_err(dev, "Failed to initialized connector.\n");
+		return ret;
+	}
+
+	return drm_connector_attach_encoder(connector, encoder);
 }
 
 static enum drm_mode_status
@@ -221,12 +279,6 @@ int hyperv_mode_config_init(struct hyperv_drm_device *hv)
 
 	dev->mode_config.funcs = &hyperv_mode_config_funcs;
 
-	ret = hyperv_conn_init(hv);
-	if (ret) {
-		drm_err(dev, "Failed to initialized connector.\n");
-		return ret;
-	}
-
 	ret = hyperv_pipe_init(hv);
 	if (ret) {
 		drm_err(dev, "Failed to initialized pipe.\n");

base-commit: d2b9e2f8a15d53121ae8f2c67b69cf06b6fa586c
-- 
2.49.0


