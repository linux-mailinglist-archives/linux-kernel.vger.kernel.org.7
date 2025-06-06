Return-Path: <linux-kernel+bounces-675704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BBFAD01BF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 14:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0B917A121
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 12:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C996288524;
	Fri,  6 Jun 2025 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFbAPOFE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72577288C09
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749211608; cv=none; b=pnqvIc3Py6GZXVMreFwuTwEA34ADjzFlJPs6vg9oDHvW3alONILcqhiUkfg1pRRiUN5eKuZy9G2KznJRkpB6NSkxJ/NCHYCpT1eHL2S3N3etS+mNgLNgUgJSKiKo1/iPQjI1KEBGsszSA4yRMEGoHb74NlUDv0F6rTJ4nSVu2CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749211608; c=relaxed/simple;
	bh=j+cODd6m/VlELnGDpwFpT8ZEc30hawiI2g94AmUkhcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8tXVC8kvOgHXoUOtUi6Y0GTFeVWigfgkarurnaFxes7xPAnAOUViZujT/eeRyWnQ6W7mXtQvM7nMHMa+3g6c5wQ+V7sDfeo1MGOpPPcEqcihdnaSa3bx0K7Kxs2BJNbsIbD83UUeApfR3Uj6ZWevkmsUE5CUSM37K368k183ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFbAPOFE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749211605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04LRSvqeoLp7K6hiMt+5nhRqp6hRGXKPyGrTB58OXbY=;
	b=bFbAPOFE97xQ8TUXm380kzsXyoSlrfpj/FdfUaL/k2o2/EaUjbMjxKUkzu7ZWMkkhZnRIw
	VyfqK+cEODza06VnUreFMUVnwTOv+owRg2OxS+5wTE7rjSgqjfZcua4uZEQBpdQ5KaxeVy
	XfWu2cW4MNokM4uhzt6v20O8H2+GSoU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-tYOC6bZiOBi7uTbL3bbC5A-1; Fri,
 06 Jun 2025 08:06:40 -0400
X-MC-Unique: tYOC6bZiOBi7uTbL3bbC5A-1
X-Mimecast-MFC-AGG-ID: tYOC6bZiOBi7uTbL3bbC5A_1749211598
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF518180036E;
	Fri,  6 Jun 2025 12:06:37 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.44.33.65])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F49D18002A5;
	Fri,  6 Jun 2025 12:06:32 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
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
Subject: [PATCH v8 7/9] drm/i915/display: Add drm_panic support for Y-tiling with DPT
Date: Fri,  6 Jun 2025 13:48:11 +0200
Message-ID: <20250606120519.753928-8-jfalempe@redhat.com>
In-Reply-To: <20250606120519.753928-1-jfalempe@redhat.com>
References: <20250606120519.753928-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Alder Lake and later, it's not possible to disable tiling when DPT
is enabled.
So this commit implements Y-Tiling support, to still be able to draw
the panic screen.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---

v8:
 * Pass the tiling function to intel_bo_panic_setup()

 .../gpu/drm/i915/display/intel_atomic_plane.c | 66 ++++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_bo.c       |  5 +-
 drivers/gpu/drm/i915/display/intel_bo.h       |  3 +-
 .../drm/i915/display/skl_universal_plane.c    | 15 +++--
 drivers/gpu/drm/i915/gem/i915_gem_object.h    |  3 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c     | 21 +++++-
 drivers/gpu/drm/xe/display/intel_bo.c         | 10 ++-
 7 files changed, 108 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index 4095d69924db..ce5471bd3c43 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -1271,6 +1271,31 @@ intel_cleanup_plane_fb(struct drm_plane *plane,
 	intel_plane_unpin_fb(old_plane_state);
 }
 
+/* Handle Y-tiling, only if DPT is enabled (otherwise disabling tiling is easier)
+ * All DPT hardware have 128-bytes width tiling, so Y-tile dimension is 32x32
+ * pixels for 32bits pixels.
+ */
+#define YTILE_WIDTH	32
+#define YTILE_HEIGHT	32
+#define YTILE_SIZE (YTILE_WIDTH * YTILE_HEIGHT * 4)
+
+static unsigned int intel_ytile_get_offset(unsigned int width, unsigned int x, unsigned int y)
+{
+	u32 offset;
+	unsigned int swizzle;
+	unsigned int width_in_blocks = DIV_ROUND_UP(width, 32);
+
+	/* Block offset */
+	offset = ((y / YTILE_HEIGHT) * width_in_blocks + (x / YTILE_WIDTH)) * YTILE_SIZE;
+
+	x = x % YTILE_WIDTH;
+	y = y % YTILE_HEIGHT;
+
+	/* bit order inside a block is x4 x3 x2 y4 y3 y2 y1 y0 x1 x0 */
+	swizzle = (x & 3) | ((y & 0x1f) << 2) | ((x & 0x1c) << 5);
+	offset += swizzle * 4;
+	return offset;
+}
 
 static void intel_panic_flush(struct drm_plane *plane)
 {
@@ -1297,6 +1322,35 @@ static void intel_panic_flush(struct drm_plane *plane)
 		iplane->disable_tiling(iplane);
 }
 
+static unsigned int (*intel_get_tiling_func(u64 fb_modifier))(unsigned int width,
+							      unsigned int x,
+							      unsigned int y)
+{
+	switch (fb_modifier) {
+	case I915_FORMAT_MOD_Y_TILED:
+	case I915_FORMAT_MOD_Y_TILED_CCS:
+	case I915_FORMAT_MOD_Y_TILED_GEN12_RC_CCS_CC:
+	case I915_FORMAT_MOD_Y_TILED_GEN12_RC_CCS:
+	case I915_FORMAT_MOD_Y_TILED_GEN12_MC_CCS:
+		return intel_ytile_get_offset;
+	case I915_FORMAT_MOD_4_TILED:
+	case I915_FORMAT_MOD_4_TILED_DG2_RC_CCS:
+	case I915_FORMAT_MOD_4_TILED_DG2_MC_CCS:
+	case I915_FORMAT_MOD_4_TILED_DG2_RC_CCS_CC:
+	case I915_FORMAT_MOD_4_TILED_MTL_RC_CCS:
+	case I915_FORMAT_MOD_4_TILED_MTL_RC_CCS_CC:
+	case I915_FORMAT_MOD_4_TILED_MTL_MC_CCS:
+	case I915_FORMAT_MOD_4_TILED_BMG_CCS:
+	case I915_FORMAT_MOD_4_TILED_LNL_CCS:
+	case I915_FORMAT_MOD_X_TILED:
+	case I915_FORMAT_MOD_Yf_TILED:
+	case I915_FORMAT_MOD_Yf_TILED_CCS:
+	default:
+	/* Not supported yet */
+		return NULL;
+	}
+}
+
 static int intel_get_scanout_buffer(struct drm_plane *plane,
 				    struct drm_scanout_buffer *sb)
 {
@@ -1304,6 +1358,7 @@ static int intel_get_scanout_buffer(struct drm_plane *plane,
 	struct drm_gem_object *obj;
 	struct drm_framebuffer *fb;
 	struct intel_display *display = to_intel_display(plane->dev);
+	unsigned int (*tiling)(unsigned int width, unsigned int x, unsigned int y) = NULL;
 
 	if (!plane->state || !plane->state->fb || !plane->state->visible)
 		return -ENODEV;
@@ -1319,9 +1374,14 @@ static int intel_get_scanout_buffer(struct drm_plane *plane,
 	} else {
 		int ret;
 		/* Can't disable tiling if DPT is in use */
-		if (intel_fb_uses_dpt(fb))
-			return -EOPNOTSUPP;
-		ret = intel_bo_panic_setup(obj, sb);
+		if (intel_fb_uses_dpt(fb)) {
+			if (fb->format->cpp[0] != 4)
+				return -EOPNOTSUPP;
+			tiling = intel_get_tiling_func(fb->modifier);
+			if (!tiling)
+				return -EOPNOTSUPP;
+		}
+		ret = intel_bo_panic_setup(obj, sb, tiling);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/i915/display/intel_bo.c b/drivers/gpu/drm/i915/display/intel_bo.c
index 83dbd8ae16fe..16c4ef30133c 100644
--- a/drivers/gpu/drm/i915/display/intel_bo.c
+++ b/drivers/gpu/drm/i915/display/intel_bo.c
@@ -59,9 +59,10 @@ void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj)
 	i915_debugfs_describe_obj(m, to_intel_bo(obj));
 }
 
-int intel_bo_panic_setup(struct drm_gem_object *obj, struct drm_scanout_buffer *sb)
+int intel_bo_panic_setup(struct drm_gem_object *obj, struct drm_scanout_buffer *sb,
+			 unsigned int (*tiling)(unsigned int, unsigned int, unsigned int))
 {
-	return i915_gem_object_panic_setup(to_intel_bo(obj), sb);
+	return i915_gem_object_panic_setup(to_intel_bo(obj), sb, tiling);
 }
 
 void intel_bo_panic_finish(struct drm_gem_object *obj)
diff --git a/drivers/gpu/drm/i915/display/intel_bo.h b/drivers/gpu/drm/i915/display/intel_bo.h
index 9ac087ea275d..9eecc18005ae 100644
--- a/drivers/gpu/drm/i915/display/intel_bo.h
+++ b/drivers/gpu/drm/i915/display/intel_bo.h
@@ -24,7 +24,8 @@ struct intel_frontbuffer *intel_bo_set_frontbuffer(struct drm_gem_object *obj,
 						   struct intel_frontbuffer *front);
 
 void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj);
-int intel_bo_panic_setup(struct drm_gem_object *obj, struct drm_scanout_buffer *sb);
+int intel_bo_panic_setup(struct drm_gem_object *obj, struct drm_scanout_buffer *sb,
+			 unsigned int (*tiling)(unsigned int, unsigned int, unsigned int));
 void intel_bo_panic_finish(struct drm_gem_object *obj);
 
 #endif /* __INTEL_BO__ */
diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index ffcf50443c0c..e73f171988f3 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -2795,15 +2795,22 @@ static void skl_disable_tiling(struct intel_plane *plane)
 {
 	struct intel_plane_state *state = to_intel_plane_state(plane->base.state);
 	struct intel_display *display = to_intel_display(plane);
-	u32 stride = state->view.color_plane[0].scanout_stride / 64;
+	const struct drm_framebuffer *fb = state->hw.fb;
 	u32 plane_ctl;
 
 	plane_ctl = intel_de_read(display, PLANE_CTL(plane->pipe, plane->id));
-	plane_ctl &= ~PLANE_CTL_TILED_MASK;
 
-	intel_de_write_fw(display, PLANE_STRIDE(plane->pipe, plane->id),
-			  PLANE_STRIDE_(stride));
+	if (intel_fb_uses_dpt(fb)) {
+		/* if DPT is enabled, keep tiling, but disable compression */
+		plane_ctl &= ~PLANE_CTL_RENDER_DECOMPRESSION_ENABLE;
+	} else {
+		/* if DPT is not supported, disable tiling, and update stride */
+		u32 stride = state->view.color_plane[0].scanout_stride / 64;
 
+		plane_ctl &= ~PLANE_CTL_TILED_MASK;
+		intel_de_write_fw(display, PLANE_STRIDE(plane->pipe, plane->id),
+				  PLANE_STRIDE_(stride));
+	}
 	intel_de_write_fw(display, PLANE_CTL(plane->pipe, plane->id), plane_ctl);
 
 	intel_de_write_fw(display, PLANE_SURF(plane->pipe, plane->id),
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index 9a0c1019dcad..a9d4e7f93c1f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -692,7 +692,8 @@ i915_gem_object_unpin_pages(struct drm_i915_gem_object *obj)
 int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj);
 int i915_gem_object_truncate(struct drm_i915_gem_object *obj);
 
-int i915_gem_object_panic_setup(struct drm_i915_gem_object *obj, struct drm_scanout_buffer *sb);
+int i915_gem_object_panic_setup(struct drm_i915_gem_object *obj, struct drm_scanout_buffer *sb,
+				unsigned int (*tiling)(unsigned int, unsigned int, unsigned int));
 void i915_gem_object_panic_finish(struct drm_i915_gem_object *obj);
 
 /**
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 9bdbac3d9433..6a1cc0213ad0 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -358,6 +358,7 @@ static void *i915_gem_object_map_pfn(struct drm_i915_gem_object *obj,
 static struct page **i915_panic_pages;
 static int i915_panic_page = -1;
 static void *i915_panic_vaddr;
+static unsigned int (*i915_panic_tiling)(unsigned int, unsigned int, unsigned int);
 
 static void i915_panic_kunmap(void)
 {
@@ -385,6 +386,14 @@ static struct page **i915_gem_object_panic_pages(struct drm_i915_gem_object *obj
 	return pages;
 }
 
+static void i915_gem_object_panic_map_set_pixel(struct drm_scanout_buffer *sb, unsigned int x,
+						unsigned int y, u32 color)
+{
+	unsigned int offset = i915_panic_tiling(sb->width, x, y);
+
+	iosys_map_wr(&sb->map[0], offset, u32, color);
+}
+
 /*
  * The scanout buffer pages are not mapped, so for each pixel,
  * use kmap_local_page_try_from_panic() to map the page, and write the pixel.
@@ -396,7 +405,10 @@ static void i915_gem_object_panic_page_set_pixel(struct drm_scanout_buffer *sb,
 	unsigned int new_page;
 	unsigned int offset;
 
-	offset = y * sb->pitch[0] + x * sb->format->cpp[0];
+	if (i915_panic_tiling)
+		offset = i915_panic_tiling(sb->width, x, y);
+	else
+		offset = y * sb->pitch[0] + x * sb->format->cpp[0];
 
 	new_page = offset >> PAGE_SHIFT;
 	offset = offset % PAGE_SIZE;
@@ -417,11 +429,14 @@ static void i915_gem_object_panic_page_set_pixel(struct drm_scanout_buffer *sb,
  * Use current vaddr if it exists, or setup a list of pages.
  * pfn is not supported yet.
  */
-int i915_gem_object_panic_setup(struct drm_i915_gem_object *obj, struct drm_scanout_buffer *sb)
+int i915_gem_object_panic_setup(struct drm_i915_gem_object *obj, struct drm_scanout_buffer *sb,
+				unsigned int (*tiling)(unsigned int, unsigned int, unsigned int))
 {
 	enum i915_map_type has_type;
 	void *ptr;
 
+	i915_panic_tiling = tiling;
+
 	ptr = page_unpack_bits(obj->mm.mapping, &has_type);
 	if (ptr) {
 		if (i915_gem_object_has_iomem(obj))
@@ -429,6 +444,8 @@ int i915_gem_object_panic_setup(struct drm_i915_gem_object *obj, struct drm_scan
 		else
 			iosys_map_set_vaddr(&sb->map[0], ptr);
 
+		if (tiling)
+			sb->set_pixel = i915_gem_object_panic_map_set_pixel;
 		return 0;
 	}
 	if (i915_gem_object_has_struct_page(obj)) {
diff --git a/drivers/gpu/drm/xe/display/intel_bo.c b/drivers/gpu/drm/xe/display/intel_bo.c
index eb9a3400c110..af990a8cd674 100644
--- a/drivers/gpu/drm/xe/display/intel_bo.c
+++ b/drivers/gpu/drm/xe/display/intel_bo.c
@@ -64,6 +64,7 @@ void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj)
 static int xe_panic_page = -1;
 static void *xe_panic_vaddr;
 static struct xe_bo *xe_panic_bo;
+static unsigned int (*xe_panic_tiling)(unsigned int, unsigned int, unsigned int);
 
 static void xe_panic_kunmap(void)
 {
@@ -84,7 +85,10 @@ static void xe_panic_page_set_pixel(struct drm_scanout_buffer *sb, unsigned int
 	unsigned int new_page;
 	unsigned int offset;
 
-	offset = y * sb->pitch[0] + x * sb->format->cpp[0];
+	if (xe_panic_tiling)
+		offset = xe_panic_tiling(sb->width, x, y);
+	else
+		offset = y * sb->pitch[0] + x * sb->format->cpp[0];
 
 	new_page = offset >> PAGE_SHIFT;
 	offset = offset % PAGE_SIZE;
@@ -100,11 +104,13 @@ static void xe_panic_page_set_pixel(struct drm_scanout_buffer *sb, unsigned int
 	}
 }
 
-int intel_bo_panic_setup(struct drm_gem_object *obj, struct drm_scanout_buffer *sb)
+int intel_bo_panic_setup(struct drm_gem_object *obj, struct drm_scanout_buffer *sb,
+			 unsigned int (*tiling)(unsigned int, unsigned int, unsigned int))
 {
 	struct xe_bo *bo = gem_to_xe_bo(obj);
 
 	xe_panic_bo = bo;
+	xe_panic_tiling = tiling;
 	sb->set_pixel = xe_panic_page_set_pixel;
 	return 0;
 }
-- 
2.49.0


