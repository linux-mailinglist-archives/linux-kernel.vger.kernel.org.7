Return-Path: <linux-kernel+bounces-699879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 623C4AE608F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 11:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874493BF961
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4A327C872;
	Tue, 24 Jun 2025 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYwJkG5M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9D279DDD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756580; cv=none; b=s4fza+pxX1zAce8l2qjPCXzDfYrWCZvBkJLGRM5Gv4oDde7rJaGZNse6Z2GTfKzlHcYGLX9piBoXUq4PtAPSsokfeQKzhYxKe16ZwHDKUA26pKnTH+Z5CWWxquVLZB4cWbJo5an2Oe5CiPeHQySkBxep92xcqyUR0VGcNGyN/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756580; c=relaxed/simple;
	bh=6L0aNX8FPlYra9vhJjbPfiRYDyfbx+5k0szCCsCZfKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzeYbx1LEVe5Z4xZUTxSeychc2aWHo6Q3lL5Ghl3Pew4hsfs58/puB3EHXVwmLp8nI0V2SEXLBZgMwNFF0s42wj5xvTBWxwFOfiIULAswTxKZ8gwnKI7MP/0srwdl2u1rQ/Br+s31MkCpAp2sTRuDtRFkMisRIt8bQ6GXGZzacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYwJkG5M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750756576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfY3frOvy5x0jN0nXPrvnBUFmrGpxJmllyDJ0AsAl9Y=;
	b=BYwJkG5M6WyjFrkn91rCN1gkmDFrkYVvcIgg5zWv7dNsYoi5Oi6Y3RavdyaFMvYFOZPf/v
	3t9KWas0HjcvMaBzsKRc8MQjkYDpcyFkTYVGVAKqT+JwMBuuhSs+kcN0UKKbG4VvJYJ8uJ
	jAoTATCkfbgBGlHA+YkiV+9pbKC9L1U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-z4lwXWfFNRuYjKBUkxBzAw-1; Tue,
 24 Jun 2025 05:16:07 -0400
X-MC-Unique: z4lwXWfFNRuYjKBUkxBzAw-1
X-Mimecast-MFC-AGG-ID: z4lwXWfFNRuYjKBUkxBzAw_1750756561
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70E8D195609F;
	Tue, 24 Jun 2025 09:16:01 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.224.209])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4AA7180045B;
	Tue, 24 Jun 2025 09:15:55 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v11 08/11] drm/i915/display: Add drm_panic support
Date: Tue, 24 Jun 2025 11:01:17 +0200
Message-ID: <20250624091501.257661-9-jfalempe@redhat.com>
In-Reply-To: <20250624091501.257661-1-jfalempe@redhat.com>
References: <20250624091501.257661-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This adds drm_panic support for a wide range of Intel GPU. I've
tested it only on 4 laptops, Haswell (with 128MB of eDRAM),
Comet Lake, Raptor Lake, and Lunar Lake.
For hardware using DPT, it's not possible to disable tiling, as you
will need to reconfigure the way the GPU is accessing the
framebuffer, so this will be handled by the following patches.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---

v4:
 * Add support for Xe driver.
 
v6:
 * Use struct intel_display instead of drm_i915_private for intel_atomic_plane.c
 
v7:
 * Fix mismatch {} in intel_panic_flush() (Jani Nikula)

v8:
 * Use intel_bo_panic_setup() and intel_bo_panic_finish().
 
v10:
 * Use struct intel_framebuffer to store the panic variables (Maarten Lankhorst)

 drivers/gpu/drm/i915/display/intel_plane.c | 83 +++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index eae926d998ff..5b889335c4b4 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -33,18 +33,22 @@
 
 #include <linux/dma-fence-chain.h>
 #include <linux/dma-resv.h>
+#include <linux/iosys-map.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
+#include <drm/drm_cache.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_panic.h>
 
 #include "gem/i915_gem_object.h"
 #include "i915_scheduler_types.h"
 #include "i915_vma.h"
 #include "i9xx_plane_regs.h"
+#include "intel_bo.h"
 #include "intel_cdclk.h"
 #include "intel_cursor.h"
 #include "intel_display_rps.h"
@@ -52,6 +56,7 @@
 #include "intel_display_types.h"
 #include "intel_fb.h"
 #include "intel_fb_pin.h"
+#include "intel_fbdev.h"
 #include "intel_plane.h"
 #include "skl_scaler.h"
 #include "skl_universal_plane.h"
@@ -1267,14 +1272,90 @@ intel_cleanup_plane_fb(struct drm_plane *plane,
 	intel_plane_unpin_fb(old_plane_state);
 }
 
+static void intel_panic_flush(struct drm_plane *plane)
+{
+	struct intel_plane_state *plane_state = to_intel_plane_state(plane->state);
+	struct intel_plane *iplane = to_intel_plane(plane);
+	struct intel_display *display = to_intel_display(iplane);
+	struct drm_framebuffer *fb = plane_state->hw.fb;
+	struct intel_framebuffer *intel_fb = to_intel_framebuffer(fb);
+
+	intel_bo_panic_finish(intel_fb);
+
+	/* Flush the cache and don't disable tiling if it's the fbdev framebuffer.*/
+	if (intel_fb == intel_fbdev_framebuffer(display->fbdev.fbdev)) {
+		struct iosys_map map;
+
+		intel_fbdev_get_map(display->fbdev.fbdev, &map);
+		drm_clflush_virt_range(map.vaddr, fb->pitches[0] * fb->height);
+		return;
+	}
+
+	if (fb->modifier && iplane->disable_tiling)
+		iplane->disable_tiling(iplane);
+}
+
+static int intel_get_scanout_buffer(struct drm_plane *plane,
+				    struct drm_scanout_buffer *sb)
+{
+	struct intel_plane_state *plane_state;
+	struct drm_gem_object *obj;
+	struct drm_framebuffer *fb;
+	struct intel_framebuffer *intel_fb;
+	struct intel_display *display = to_intel_display(plane->dev);
+
+	if (!plane->state || !plane->state->fb || !plane->state->visible)
+		return -ENODEV;
+
+	plane_state = to_intel_plane_state(plane->state);
+	fb = plane_state->hw.fb;
+	intel_fb = to_intel_framebuffer(fb);
+
+	obj = intel_fb_bo(fb);
+	if (!obj)
+		return -ENODEV;
+
+	if (intel_fb == intel_fbdev_framebuffer(display->fbdev.fbdev)) {
+		intel_fbdev_get_map(display->fbdev.fbdev, &sb->map[0]);
+	} else {
+		int ret;
+		/* Can't disable tiling if DPT is in use */
+		if (intel_fb_uses_dpt(fb))
+			return -EOPNOTSUPP;
+		sb->private = intel_fb;
+		ret = intel_bo_panic_setup(sb);
+		if (ret)
+			return ret;
+	}
+	sb->width = fb->width;
+	sb->height = fb->height;
+	/* Use the generic linear format, because tiling, RC, CCS, CC
+	 * will be disabled in disable_tiling()
+	 */
+	sb->format = drm_format_info(fb->format->format);
+	sb->pitch[0] = fb->pitches[0];
+
+	return 0;
+}
+
 static const struct drm_plane_helper_funcs intel_plane_helper_funcs = {
 	.prepare_fb = intel_prepare_plane_fb,
 	.cleanup_fb = intel_cleanup_plane_fb,
 };
 
+static const struct drm_plane_helper_funcs intel_primary_plane_helper_funcs = {
+	.prepare_fb = intel_prepare_plane_fb,
+	.cleanup_fb = intel_cleanup_plane_fb,
+	.get_scanout_buffer = intel_get_scanout_buffer,
+	.panic_flush = intel_panic_flush,
+};
+
 void intel_plane_helper_add(struct intel_plane *plane)
 {
-	drm_plane_helper_add(&plane->base, &intel_plane_helper_funcs);
+	if (plane->base.type == DRM_PLANE_TYPE_PRIMARY)
+		drm_plane_helper_add(&plane->base, &intel_primary_plane_helper_funcs);
+	else
+		drm_plane_helper_add(&plane->base, &intel_plane_helper_funcs);
 }
 
 void intel_plane_init_cursor_vblank_work(struct intel_plane_state *old_plane_state,
-- 
2.49.0


