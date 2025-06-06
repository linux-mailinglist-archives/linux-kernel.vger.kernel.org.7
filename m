Return-Path: <linux-kernel+bounces-675702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E58AD01BE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 14:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8DF5189DAE3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 12:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39141286D7E;
	Fri,  6 Jun 2025 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Es386YUI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9381D2882CD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749211594; cv=none; b=SIUZtJTAc7id16+SFttNXKFTR5kEvDOidHfmVBwbPgUl9eH6odd1myLQTTgiMQukAhypevPplOqUVMm5KYx/NZ08wwmZ0cF5GG+xyI0Jn1jLe3K8wFgspGpcPsqzQMpPSHsPvyARbr0qm73zLCdd8IQfnLlbXWbvcMH2yvgdK6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749211594; c=relaxed/simple;
	bh=n5acZZkmSqIXAvjWkjYTFVqJaLn0apCicfOWTCJYD2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3/G/N2VnWco8KqdhIJr2314KzIv6J8rWNgGO33/qbO9SdSvterv8GkKpY2TYWZDUlaMI9P25/e2WjbjACiSLKugngKSuBQ+L62r1ZJYbgYmXr3/Dj9fhoETqDmnke2+Vc8tU4TFWlJNEAlo74X5Ufp+bAe/PqAurnikUU34rWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Es386YUI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749211591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=deJBe+dw+c7pFRTX7PwmH5oQvdEyNmO/6Njb6mekRlc=;
	b=Es386YUI5JMKtHlaSF/dEWXEG3+H1HTqgKsc3ZVF4aF7QpnqzVJshizML4w5GVMTjswGx3
	hcDnjK34uqxswu/yQF4Vc/OQe5OEiX9Zbd+HfxzZsQ+Eh9JfcLhxht3ytho3QYnVMluMMT
	zifNH1FpjJRIHf+pxnTzxwhQBXX5gSo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-uOIuhcEuONG7YWYwCyin-Q-1; Fri,
 06 Jun 2025 08:06:28 -0400
X-MC-Unique: uOIuhcEuONG7YWYwCyin-Q-1
X-Mimecast-MFC-AGG-ID: uOIuhcEuONG7YWYwCyin-Q_1749211586
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A6F91800772;
	Fri,  6 Jun 2025 12:06:26 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.44.33.65])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED5CD18002A5;
	Fri,  6 Jun 2025 12:06:19 +0000 (UTC)
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
Subject: [PATCH v8 5/9] drm/i915: Add intel_bo_panic_setup and intel_bo_panic_finish
Date: Fri,  6 Jun 2025 13:48:09 +0200
Message-ID: <20250606120519.753928-6-jfalempe@redhat.com>
In-Reply-To: <20250606120519.753928-1-jfalempe@redhat.com>
References: <20250606120519.753928-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
   to call from a panic handler

 drivers/gpu/drm/i915/display/intel_bo.c    | 11 +++
 drivers/gpu/drm/i915/display/intel_bo.h    |  3 +
 drivers/gpu/drm/i915/gem/i915_gem_object.h |  4 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c  | 92 ++++++++++++++++++++++
 drivers/gpu/drm/xe/display/intel_bo.c      | 55 +++++++++++++
 5 files changed, 165 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_bo.c b/drivers/gpu/drm/i915/display/intel_bo.c
index fbd16d7b58d9..83dbd8ae16fe 100644
--- a/drivers/gpu/drm/i915/display/intel_bo.c
+++ b/drivers/gpu/drm/i915/display/intel_bo.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: MIT
 /* Copyright © 2024 Intel Corporation */
 
+#include <drm/drm_panic.h>
 #include "gem/i915_gem_mman.h"
 #include "gem/i915_gem_object.h"
 #include "gem/i915_gem_object_frontbuffer.h"
@@ -57,3 +58,13 @@ void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj)
 {
 	i915_debugfs_describe_obj(m, to_intel_bo(obj));
 }
+
+int intel_bo_panic_setup(struct drm_gem_object *obj, struct drm_scanout_buffer *sb)
+{
+	return i915_gem_object_panic_setup(to_intel_bo(obj), sb);
+}
+
+void intel_bo_panic_finish(struct drm_gem_object *obj)
+{
+	return i915_gem_object_panic_finish(to_intel_bo(obj));
+}
diff --git a/drivers/gpu/drm/i915/display/intel_bo.h b/drivers/gpu/drm/i915/display/intel_bo.h
index ea7a2253aaa5..9ac087ea275d 100644
--- a/drivers/gpu/drm/i915/display/intel_bo.h
+++ b/drivers/gpu/drm/i915/display/intel_bo.h
@@ -4,6 +4,7 @@
 #ifndef __INTEL_BO__
 #define __INTEL_BO__
 
+#include <drm/drm_panic.h>
 #include <linux/types.h>
 
 struct drm_gem_object;
@@ -23,5 +24,7 @@ struct intel_frontbuffer *intel_bo_set_frontbuffer(struct drm_gem_object *obj,
 						   struct intel_frontbuffer *front);
 
 void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj);
+int intel_bo_panic_setup(struct drm_gem_object *obj, struct drm_scanout_buffer *sb);
+void intel_bo_panic_finish(struct drm_gem_object *obj);
 
 #endif /* __INTEL_BO__ */
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index c34f41605b46..9a0c1019dcad 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -9,6 +9,7 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_file.h>
 #include <drm/drm_device.h>
+#include <drm/drm_panic.h>
 
 #include "intel_memory_region.h"
 #include "i915_gem_object_types.h"
@@ -691,6 +692,9 @@ i915_gem_object_unpin_pages(struct drm_i915_gem_object *obj)
 int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj);
 int i915_gem_object_truncate(struct drm_i915_gem_object *obj);
 
+int i915_gem_object_panic_setup(struct drm_i915_gem_object *obj, struct drm_scanout_buffer *sb);
+void i915_gem_object_panic_finish(struct drm_i915_gem_object *obj);
+
 /**
  * i915_gem_object_pin_map - return a contiguous mapping of the entire object
  * @obj: the object to map into kernel address space
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 7f83f8bdc8fb..9bdbac3d9433 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -3,6 +3,7 @@
  * Copyright © 2014-2016 Intel Corporation
  */
 
+#include <drm/drm_panic.h>
 #include <drm/drm_cache.h>
 #include <linux/vmalloc.h>
 
@@ -354,6 +355,97 @@ static void *i915_gem_object_map_pfn(struct drm_i915_gem_object *obj,
 	return vaddr ?: ERR_PTR(-ENOMEM);
 }
 
+static struct page **i915_panic_pages;
+static int i915_panic_page = -1;
+static void *i915_panic_vaddr;
+
+static void i915_panic_kunmap(void)
+{
+	if (i915_panic_vaddr) {
+		drm_clflush_virt_range(i915_panic_vaddr, PAGE_SIZE);
+		kunmap_local(i915_panic_vaddr);
+		i915_panic_vaddr = NULL;
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
+	pages = kvmalloc_array(n_pages, sizeof(*pages), GFP_ATOMIC);
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
+
+	offset = y * sb->pitch[0] + x * sb->format->cpp[0];
+
+	new_page = offset >> PAGE_SHIFT;
+	offset = offset % PAGE_SIZE;
+	if (new_page != i915_panic_page) {
+		i915_panic_kunmap();
+		i915_panic_page = new_page;
+		i915_panic_vaddr = kmap_local_page_try_from_panic(
+				   i915_panic_pages[i915_panic_page]);
+	}
+	if (i915_panic_vaddr) {
+		u32 *pix = i915_panic_vaddr + offset;
+		*pix = color;
+	}
+}
+
+/*
+ * Setup the gem framebuffer for drm_panic access.
+ * Use current vaddr if it exists, or setup a list of pages.
+ * pfn is not supported yet.
+ */
+int i915_gem_object_panic_setup(struct drm_i915_gem_object *obj, struct drm_scanout_buffer *sb)
+{
+	enum i915_map_type has_type;
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
+		i915_panic_pages = i915_gem_object_panic_pages(obj);
+		sb->set_pixel = i915_gem_object_panic_page_set_pixel;
+		i915_panic_page = -1;
+		return 0;
+	}
+	return -EOPNOTSUPP;
+}
+
+void i915_gem_object_panic_finish(struct drm_i915_gem_object *obj)
+{
+	i915_panic_kunmap();
+	i915_panic_page = -1;
+}
+
 /* get, pin, and map the pages of the object into kernel space */
 void *i915_gem_object_pin_map(struct drm_i915_gem_object *obj,
 			      enum i915_map_type type)
diff --git a/drivers/gpu/drm/xe/display/intel_bo.c b/drivers/gpu/drm/xe/display/intel_bo.c
index 27437c22bd70..eb9a3400c110 100644
--- a/drivers/gpu/drm/xe/display/intel_bo.c
+++ b/drivers/gpu/drm/xe/display/intel_bo.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: MIT
 /* Copyright © 2024 Intel Corporation */
 
+#include <drm/drm_cache.h>
 #include <drm/drm_gem.h>
 
 #include "xe_bo.h"
@@ -59,3 +60,57 @@ void intel_bo_describe(struct seq_file *m, struct drm_gem_object *obj)
 {
 	/* FIXME */
 }
+
+static int xe_panic_page = -1;
+static void *xe_panic_vaddr;
+static struct xe_bo *xe_panic_bo;
+
+static void xe_panic_kunmap(void)
+{
+	if (xe_panic_vaddr) {
+		drm_clflush_virt_range(xe_panic_vaddr, PAGE_SIZE);
+		kunmap_local(xe_panic_vaddr);
+		xe_panic_vaddr = NULL;
+	}
+}
+/*
+ * The scanout buffer pages are not mapped, so for each pixel,
+ * use kmap_local_page_try_from_panic() to map the page, and write the pixel.
+ * Try to keep the map from the previous pixel, to avoid too much map/unmap.
+ */
+static void xe_panic_page_set_pixel(struct drm_scanout_buffer *sb, unsigned int x,
+				    unsigned int y, u32 color)
+{
+	unsigned int new_page;
+	unsigned int offset;
+
+	offset = y * sb->pitch[0] + x * sb->format->cpp[0];
+
+	new_page = offset >> PAGE_SHIFT;
+	offset = offset % PAGE_SIZE;
+	if (new_page != xe_panic_page) {
+		xe_panic_kunmap();
+		xe_panic_page = new_page;
+		xe_panic_vaddr = ttm_bo_kmap_try_from_panic(&xe_panic_bo->ttm,
+							    xe_panic_page);
+	}
+	if (xe_panic_vaddr) {
+		u32 *pix = xe_panic_vaddr + offset;
+		*pix = color;
+	}
+}
+
+int intel_bo_panic_setup(struct drm_gem_object *obj, struct drm_scanout_buffer *sb)
+{
+	struct xe_bo *bo = gem_to_xe_bo(obj);
+
+	xe_panic_bo = bo;
+	sb->set_pixel = xe_panic_page_set_pixel;
+	return 0;
+}
+
+void intel_bo_panic_finish(struct drm_gem_object *obj)
+{
+	xe_panic_kunmap();
+	xe_panic_page = -1;
+}
-- 
2.49.0


