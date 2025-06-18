Return-Path: <linux-kernel+bounces-691664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0358ADE75D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 11:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBC73A61DF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3B2285CA6;
	Wed, 18 Jun 2025 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFQzJKeO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD413285C8B
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239675; cv=none; b=BxjDhEQKFxbSZNGGg/cgUGPnztswarrjqFZWfaR9CCm0wVTsv7W5aqCZmtEkvcM+CKAJqZcznAM6BRvuKWttnQzvA+zIa+hcmnnPHMR79/bwUH03PGfKxqOr+/kEfZ7j05mYVUalTAWaFVU5f/zMesPzNade7MQapseL/ydZkYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239675; c=relaxed/simple;
	bh=s/zJhdjBmT7rJprTRReGIId0uI3RgYx4DUBa+LNIVM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkTqiwNKOLGQNhY1y4bmqCMkIeM5QSjWmhLqk6q65ozZZ22/qSIZo/dkt5ZE8dL3YbC9pMQle2ntMOR/OEmWRFtGIYtEimwl3D35/gsl/ABkSv4duBzll9S1tGnd2t1NBZj5I56Do0+dLV0kf6Y6+Nz1AFK/+EnS3vNVHGvficM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gFQzJKeO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750239672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YE4mmw+7SWkL0qGNWtQE75zd9z4cscp0CO71gbO16o=;
	b=gFQzJKeOUTTkRX15pqxBUHxgHOV6N68ILkFmG717ienfgUWrW8+nHXFNh3r9+7/VeKIOPK
	H3RFDsalad91r2+LcZ5XK92jyoKm0oyruoM260ZTzZFNqeWdoPqu9WpbAzDzKMi7CLkKCI
	hDZDRyTHjKBY56u/1WKPVyTPc2IKh74=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-R-hvakBhMiqwlwnv8l4_sw-1; Wed,
 18 Jun 2025 05:41:09 -0400
X-MC-Unique: R-hvakBhMiqwlwnv8l4_sw-1
X-Mimecast-MFC-AGG-ID: R-hvakBhMiqwlwnv8l4_sw_1750239667
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FC7F1800286;
	Wed, 18 Jun 2025 09:41:07 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.137])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 421DF19560A3;
	Wed, 18 Jun 2025 09:41:01 +0000 (UTC)
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
Subject: [PATCH v10 06/10] drm/i915: Add intel_bo_panic_setup and intel_bo_panic_finish
Date: Wed, 18 Jun 2025 11:31:24 +0200
Message-ID: <20250618094011.238154-7-jfalempe@redhat.com>
In-Reply-To: <20250618094011.238154-1-jfalempe@redhat.com>
References: <20250618094011.238154-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Implement both functions for i915 and xe, they prepare the work for
drm_panic support.
They both use kmap_try_from_panic(), and map one page at a time, to
write the panic screen on the framebuffer.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---

v5:
 * Use iosys_map for intel_bo_panic_map().

v7:
 * Return int for i915_gem_object_panic_map() (Ville Syrjälä)

v8:
 * Complete rewrite, to use kmap_try_from_panic() which is safe
   to call from a panic handler.

v9:
 * Fix missing kfree() for i915_panic_pages in i915_gem_object_panic_finish()
   Also change i915_panic_pages allocation to kmalloc, as kvmalloc is not
   safe to call from the panic handler.

v10:
 * Replace static variables with new fields in struct intel_framebuffer
   (Maarten Lankhorst)
 * Add error handling if i915_gem_object_panic_pages() returns NULL
 * Declare struct drm_scanout_buffer instead of including <drm/drm_panic.h>
   in intel_bo.h

 drivers/gpu/drm/i915/display/intel_bo.c       | 12 +++
 drivers/gpu/drm/i915/display/intel_bo.h       |  4 +
 .../drm/i915/display/intel_display_types.h    |  8 ++
 drivers/gpu/drm/i915/gem/i915_gem_object.h    |  5 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c     | 98 +++++++++++++++++++
 drivers/gpu/drm/xe/display/intel_bo.c         | 58 +++++++++++
 6 files changed, 185 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_bo.c b/drivers/gpu/drm/i915/display/intel_bo.c
index fbd16d7b58d9..4e8ffeec6180 100644
--- a/drivers/gpu/drm/i915/display/intel_bo.c
+++ b/drivers/gpu/drm/i915/display/intel_bo.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: MIT
 /* Copyright © 2024 Intel Corporation */
 
+#include <drm/drm_panic.h>
+#include "display/intel_display_types.h"
 #include "gem/i915_gem_mman.h"
 #include "gem/i915_gem_object.h"
 #include "gem/i915_gem_object_frontbuffer.h"
@@ -57,3 +59,13 @@ void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj)
 {
 	i915_debugfs_describe_obj(m, to_intel_bo(obj));
 }
+
+int intel_bo_panic_setup(struct drm_scanout_buffer *sb)
+{
+	return i915_gem_object_panic_setup(sb);
+}
+
+void intel_bo_panic_finish(struct intel_framebuffer *fb)
+{
+	return i915_gem_object_panic_finish(fb);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_bo.h b/drivers/gpu/drm/i915/display/intel_bo.h
index ea7a2253aaa5..a1a6a5329f91 100644
--- a/drivers/gpu/drm/i915/display/intel_bo.h
+++ b/drivers/gpu/drm/i915/display/intel_bo.h
@@ -7,6 +7,8 @@
 #include <linux/types.h>
 
 struct drm_gem_object;
+struct drm_scanout_buffer;
+struct intel_framebuffer;
 struct seq_file;
 struct vm_area_struct;
 
@@ -23,5 +25,7 @@ struct intel_frontbuffer *intel_bo_set_frontbuffer(struct drm_gem_object *obj,
 						   struct intel_frontbuffer *front);
 
 void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj);
+int intel_bo_panic_setup(struct drm_scanout_buffer *sb);
+void intel_bo_panic_finish(struct intel_framebuffer *fb);
 
 #endif /* __INTEL_BO__ */
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 3654d88e9c5f..6d6d2d948886 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -130,6 +130,12 @@ struct intel_fb_view {
 	} color_plane[4];
 };
 
+struct intel_panic_data {
+	struct page **pages;
+	int page;
+	void *vaddr;
+};
+
 struct intel_framebuffer {
 	struct drm_framebuffer base;
 	struct intel_frontbuffer *frontbuffer;
@@ -145,6 +151,8 @@ struct intel_framebuffer {
 
 	unsigned int min_alignment;
 	unsigned int vtd_guard;
+
+	struct intel_panic_data panic;
 };
 
 enum intel_hotplug_state {
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index c34f41605b46..0fd8faa174ad 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -16,7 +16,9 @@
 #include "i915_gem_ww.h"
 #include "i915_vma_types.h"
 
+struct drm_scanout_buffer;
 enum intel_region_id;
+struct intel_framebuffer;
 
 #define obj_to_i915(obj__) to_i915((obj__)->base.dev)
 
@@ -691,6 +693,9 @@ i915_gem_object_unpin_pages(struct drm_i915_gem_object *obj)
 int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj);
 int i915_gem_object_truncate(struct drm_i915_gem_object *obj);
 
+int i915_gem_object_panic_setup(struct drm_scanout_buffer *sb);
+void i915_gem_object_panic_finish(struct intel_framebuffer *fb);
+
 /**
  * i915_gem_object_pin_map - return a contiguous mapping of the entire object
  * @obj: the object to map into kernel address space
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 7f83f8bdc8fb..0bcf4647a2a0 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -4,8 +4,11 @@
  */
 
 #include <drm/drm_cache.h>
+#include <drm/drm_panic.h>
 #include <linux/vmalloc.h>
 
+#include "display/intel_fb.h"
+#include "display/intel_display_types.h"
 #include "gt/intel_gt.h"
 #include "gt/intel_tlb.h"
 
@@ -354,6 +357,101 @@ static void *i915_gem_object_map_pfn(struct drm_i915_gem_object *obj,
 	return vaddr ?: ERR_PTR(-ENOMEM);
 }
 
+static void i915_panic_kunmap(struct intel_panic_data *panic)
+{
+	if (panic->vaddr) {
+		drm_clflush_virt_range(panic->vaddr, PAGE_SIZE);
+		kunmap_local(panic->vaddr);
+		panic->vaddr = NULL;
+	}
+}
+
+static struct page **i915_gem_object_panic_pages(struct drm_i915_gem_object *obj)
+{
+	unsigned long n_pages = obj->base.size >> PAGE_SHIFT, i;
+	struct page *page;
+	struct page **pages;
+	struct sgt_iter iter;
+
+	/* For a 3840x2160 32 bits Framebuffer, this should require ~64K */
+	pages = kmalloc_array(n_pages, sizeof(*pages), GFP_ATOMIC);
+	if (!pages)
+		return NULL;
+
+	i = 0;
+	for_each_sgt_page(page, iter, obj->mm.pages)
+		pages[i++] = page;
+	return pages;
+}
+
+/*
+ * The scanout buffer pages are not mapped, so for each pixel,
+ * use kmap_local_page_try_from_panic() to map the page, and write the pixel.
+ * Try to keep the map from the previous pixel, to avoid too much map/unmap.
+ */
+static void i915_gem_object_panic_page_set_pixel(struct drm_scanout_buffer *sb, unsigned int x,
+						 unsigned int y, u32 color)
+{
+	unsigned int new_page;
+	unsigned int offset;
+	struct intel_framebuffer *fb = (struct intel_framebuffer *)sb->private;
+
+	offset = y * sb->pitch[0] + x * sb->format->cpp[0];
+
+	new_page = offset >> PAGE_SHIFT;
+	offset = offset % PAGE_SIZE;
+	if (new_page != fb->panic.page) {
+		i915_panic_kunmap(&fb->panic);
+		fb->panic.page = new_page;
+		fb->panic.vaddr =
+			kmap_local_page_try_from_panic(fb->panic.pages[fb->panic.page]);
+	}
+	if (fb->panic.vaddr) {
+		u32 *pix = fb->panic.vaddr + offset;
+		*pix = color;
+	}
+}
+
+/*
+ * Setup the gem framebuffer for drm_panic access.
+ * Use current vaddr if it exists, or setup a list of pages.
+ * pfn is not supported yet.
+ */
+int i915_gem_object_panic_setup(struct drm_scanout_buffer *sb)
+{
+	enum i915_map_type has_type;
+	struct intel_framebuffer *fb = (struct intel_framebuffer *)sb->private;
+	struct drm_i915_gem_object *obj = to_intel_bo(intel_fb_bo(&fb->base));
+	void *ptr;
+
+	ptr = page_unpack_bits(obj->mm.mapping, &has_type);
+	if (ptr) {
+		if (i915_gem_object_has_iomem(obj))
+			iosys_map_set_vaddr_iomem(&sb->map[0], (void __iomem *)ptr);
+		else
+			iosys_map_set_vaddr(&sb->map[0], ptr);
+
+		return 0;
+	}
+	if (i915_gem_object_has_struct_page(obj)) {
+		fb->panic.pages = i915_gem_object_panic_pages(obj);
+		if (!fb->panic.pages)
+			return -ENOMEM;
+		fb->panic.page = -1;
+		sb->set_pixel = i915_gem_object_panic_page_set_pixel;
+		return 0;
+	}
+	return -EOPNOTSUPP;
+}
+
+void i915_gem_object_panic_finish(struct intel_framebuffer *fb)
+{
+	i915_panic_kunmap(&fb->panic);
+	fb->panic.page = -1;
+	kfree(fb->panic.pages);
+	fb->panic.pages = NULL;
+}
+
 /* get, pin, and map the pages of the object into kernel space */
 void *i915_gem_object_pin_map(struct drm_i915_gem_object *obj,
 			      enum i915_map_type type)
diff --git a/drivers/gpu/drm/xe/display/intel_bo.c b/drivers/gpu/drm/xe/display/intel_bo.c
index 27437c22bd70..8a6de2dda88c 100644
--- a/drivers/gpu/drm/xe/display/intel_bo.c
+++ b/drivers/gpu/drm/xe/display/intel_bo.c
@@ -1,7 +1,12 @@
 // SPDX-License-Identifier: MIT
 /* Copyright © 2024 Intel Corporation */
 
+#include <drm/drm_cache.h>
 #include <drm/drm_gem.h>
+#include <drm/drm_panic.h>
+
+#include "intel_fb.h"
+#include "intel_display_types.h"
 
 #include "xe_bo.h"
 #include "intel_bo.h"
@@ -59,3 +64,56 @@ void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj)
 {
 	/* FIXME */
 }
+
+static void xe_panic_kunmap(struct intel_panic_data *panic)
+{
+	if (panic->vaddr) {
+		drm_clflush_virt_range(panic->vaddr, PAGE_SIZE);
+		kunmap_local(panic->vaddr);
+		panic->vaddr = NULL;
+	}
+}
+
+/*
+ * The scanout buffer pages are not mapped, so for each pixel,
+ * use kmap_local_page_try_from_panic() to map the page, and write the pixel.
+ * Try to keep the map from the previous pixel, to avoid too much map/unmap.
+ */
+static void xe_panic_page_set_pixel(struct drm_scanout_buffer *sb, unsigned int x,
+				    unsigned int y, u32 color)
+{
+	struct intel_framebuffer *fb = (struct intel_framebuffer *)sb->private;
+	struct xe_bo *bo = gem_to_xe_bo(intel_fb_bo(&fb->base));
+	unsigned int new_page;
+	unsigned int offset;
+
+	offset = y * sb->pitch[0] + x * sb->format->cpp[0];
+
+	new_page = offset >> PAGE_SHIFT;
+	offset = offset % PAGE_SIZE;
+	if (new_page != fb->panic.page) {
+		xe_panic_kunmap(&fb->panic);
+		fb->panic.page = new_page;
+		fb->panic.vaddr = ttm_bo_kmap_try_from_panic(&bo->ttm,
+							     fb->panic.page);
+	}
+	if (fb->panic.vaddr) {
+		u32 *pix = fb->panic.vaddr + offset;
+		*pix = color;
+	}
+}
+
+int intel_bo_panic_setup(struct drm_scanout_buffer *sb)
+{
+	struct intel_framebuffer *fb = (struct intel_framebuffer *)sb->private;
+
+	fb->panic.page = -1;
+	sb->set_pixel = xe_panic_page_set_pixel;
+	return 0;
+}
+
+void intel_bo_panic_finish(struct intel_framebuffer *fb)
+{
+	xe_panic_kunmap(&fb->panic);
+	fb->panic.page = -1;
+}
-- 
2.49.0


