Return-Path: <linux-kernel+bounces-583484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33565A77B77
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 14:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696F03AD601
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A456202C43;
	Tue,  1 Apr 2025 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZKkWnOs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB41FBE83
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743512327; cv=none; b=uKdQtJxMOLvaudy9WYAX8E+ziJLiLfWRa2PG2xC63sT6ipYiOjxmiqALtykLjdQw6K70GOEIH40kF0wpPvYIFbm1ROWrAA/Pl32WSlyfVfZOzc2KVfkh7Dp0fq6qIFGvEW7umEaraPtjlLLyuYyl6IsusuKhiCax8L9DUZ8EYDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743512327; c=relaxed/simple;
	bh=fqxc9+eEnnHlQuergBsYxibkB40FOkfBcREL4rl7lkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F58yaevUzeujsuRC0ik0mQ360p3ibltkhe1iQFAUnhzZ082l9CQVD4yko1/LprMxqSID631ZXwXXJwcstNQJNYNL9sYvv9j+a1VohAk/iDpJ9J2gEoTeBmnK1gYlr0o96fF8jCEUIlsBQUv7l6VtVfef3UTPfV/HsddXFp713QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZKkWnOs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743512323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nj3qCzc4f4ifM0KG5d8Lwvc9Y+5K+4gMJTdGUFQF2Is=;
	b=YZKkWnOsEXdiuiv6DwVagPS0BXnVzE8Ipfbhhrn6v0qF9xGLyQPBc6mqFynHCFJ4ELFvBJ
	Ch/4fN64VRZg3S5Isr1Y8Ogi4UM4690FVOsJx9EqyK97+C7SvA0BiWY9bN5KdV+eH6gmNU
	CmYhclcos8iSd/T94ut8kJe7wlqB2Uc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-XiB9IRkjN_OoBOGQpALg7A-1; Tue,
 01 Apr 2025 08:58:40 -0400
X-MC-Unique: XiB9IRkjN_OoBOGQpALg7A-1
X-Mimecast-MFC-AGG-ID: XiB9IRkjN_OoBOGQpALg7A_1743512318
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 750461955DDE;
	Tue,  1 Apr 2025 12:58:38 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.44.32.206])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22F4B1956094;
	Tue,  1 Apr 2025 12:58:33 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v6 1/8] drm/i915/fbdev: Add intel_fbdev_get_map()
Date: Tue,  1 Apr 2025 14:51:07 +0200
Message-ID: <20250401125818.333033-2-jfalempe@redhat.com>
In-Reply-To: <20250401125818.333033-1-jfalempe@redhat.com>
References: <20250401125818.333033-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The vaddr of the fbdev framebuffer is private to the struct
intel_fbdev, so this function is needed to access it for drm_panic.
Also the struct i915_vma is different between i915 and xe, so it
requires a few functions to access fbdev->vma->iomap.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---

v2:
 * Add intel_fb_get_vaddr() and i915_vma_get_iomap() to build with Xe driver.
 
v4:
 * rename to get_map(), and return the struct iosys_map mapping.
 * implement the Xe variant.

 drivers/gpu/drm/i915/display/intel_fb_pin.c | 5 +++++
 drivers/gpu/drm/i915/display/intel_fb_pin.h | 2 ++
 drivers/gpu/drm/i915/display/intel_fbdev.c  | 5 +++++
 drivers/gpu/drm/i915/display/intel_fbdev.h  | 6 +++++-
 drivers/gpu/drm/i915/i915_vma.h             | 5 +++++
 drivers/gpu/drm/xe/display/xe_fb_pin.c      | 5 +++++
 6 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fb_pin.c b/drivers/gpu/drm/i915/display/intel_fb_pin.c
index c648ab8a93d7..7f1c21eb12e0 100644
--- a/drivers/gpu/drm/i915/display/intel_fb_pin.c
+++ b/drivers/gpu/drm/i915/display/intel_fb_pin.c
@@ -333,3 +333,8 @@ void intel_plane_unpin_fb(struct intel_plane_state *old_plane_state)
 			intel_dpt_unpin_from_ggtt(fb->dpt_vm);
 	}
 }
+
+void intel_fb_get_map(struct i915_vma *vma, struct iosys_map *map)
+{
+	iosys_map_set_vaddr_iomem(map, i915_vma_get_iomap(vma));
+}
diff --git a/drivers/gpu/drm/i915/display/intel_fb_pin.h b/drivers/gpu/drm/i915/display/intel_fb_pin.h
index 01770dbba2e0..81ab79da1af7 100644
--- a/drivers/gpu/drm/i915/display/intel_fb_pin.h
+++ b/drivers/gpu/drm/i915/display/intel_fb_pin.h
@@ -12,6 +12,7 @@ struct drm_framebuffer;
 struct i915_vma;
 struct intel_plane_state;
 struct i915_gtt_view;
+struct iosys_map;
 
 struct i915_vma *
 intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
@@ -27,5 +28,6 @@ void intel_fb_unpin_vma(struct i915_vma *vma, unsigned long flags);
 int intel_plane_pin_fb(struct intel_plane_state *new_plane_state,
 		       const struct intel_plane_state *old_plane_state);
 void intel_plane_unpin_fb(struct intel_plane_state *old_plane_state);
+void intel_fb_get_map(struct i915_vma *vma, struct iosys_map *map);
 
 #endif
diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
index 369f46286e95..5fdf71c3c74e 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
@@ -516,3 +516,8 @@ struct i915_vma *intel_fbdev_vma_pointer(struct intel_fbdev *fbdev)
 {
 	return fbdev ? fbdev->vma : NULL;
 }
+
+void intel_fbdev_get_map(struct intel_fbdev *fbdev, struct iosys_map *map)
+{
+	intel_fb_get_map(fbdev->vma, map);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.h b/drivers/gpu/drm/i915/display/intel_fbdev.h
index 89bad3a2b01a..a4b3d6dd538f 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.h
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.h
@@ -13,6 +13,7 @@ struct drm_fb_helper_surface_size;
 struct drm_i915_private;
 struct intel_fbdev;
 struct intel_framebuffer;
+struct iosys_map;
 
 #ifdef CONFIG_DRM_FBDEV_EMULATION
 int intel_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
@@ -22,7 +23,7 @@ int intel_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 void intel_fbdev_setup(struct drm_i915_private *dev_priv);
 struct intel_framebuffer *intel_fbdev_framebuffer(struct intel_fbdev *fbdev);
 struct i915_vma *intel_fbdev_vma_pointer(struct intel_fbdev *fbdev);
-
+void intel_fbdev_get_map(struct intel_fbdev *fbdev, struct iosys_map *map);
 #else
 #define INTEL_FBDEV_DRIVER_OPS \
 	.fbdev_probe = NULL
@@ -39,6 +40,9 @@ static inline struct i915_vma *intel_fbdev_vma_pointer(struct intel_fbdev *fbdev
 	return NULL;
 }
 
+static inline void intel_fbdev_get_map(struct intel_fbdev *fbdev, struct iosys_map *map)
+{
+}
 #endif
 
 #endif /* __INTEL_FBDEV_H__ */
diff --git a/drivers/gpu/drm/i915/i915_vma.h b/drivers/gpu/drm/i915/i915_vma.h
index 6a6be8048aa8..4ae610927fa7 100644
--- a/drivers/gpu/drm/i915/i915_vma.h
+++ b/drivers/gpu/drm/i915/i915_vma.h
@@ -353,6 +353,11 @@ static inline bool i915_node_color_differs(const struct drm_mm_node *node,
 	return drm_mm_node_allocated(node) && node->color != color;
 }
 
+static inline void __iomem *i915_vma_get_iomap(struct i915_vma *vma)
+{
+	return READ_ONCE(vma->iomap);
+}
+
 /**
  * i915_vma_pin_iomap - calls ioremap_wc to map the GGTT VMA via the aperture
  * @vma: VMA to iomap
diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index b69896baa20c..b10ab7def601 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -463,3 +463,8 @@ u64 intel_dpt_offset(struct i915_vma *dpt_vma)
 {
 	return 0;
 }
+
+void intel_fb_get_map(struct i915_vma *vma, struct iosys_map *map)
+{
+	*map = vma->bo->vmap;
+}
-- 
2.49.0


