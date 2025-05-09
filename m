Return-Path: <linux-kernel+bounces-641270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA65AB0F16
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 11:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8065C4E18C8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614C527A130;
	Fri,  9 May 2025 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Nvw9jKvu"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E182827604E
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783293; cv=none; b=SJo/jPtrn9S0Ewb71SQfbF0EhF9NVhinkxXYY6m3lmiYf/Gj9xpqSIvDMYCCji0OHJ4OENkNsol/ljToOxQt760rU8Y9KaHLFD23N3IqSQ64aHKRhaTjReWrv0ZYjMpD/9Xa/m9pKyFxNktxxBV/2b+yV7B+Sqr3HeBfgUUNTSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783293; c=relaxed/simple;
	bh=LPw2HOuGWOtaEQtY8Q/dIcXVuDx9xTolb+0SbY9H/Is=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B2YvzNu6Tf9Q4piG/WmLPdGqraUJlickTvgusPb9ASocoaV+7N/QLq+RNZM79IgyFgrxHCyXwUlalFMZNPJE+cvgVvuEWeYHcDkLBLEq10jvwwt6Wd+VlM4s30MfuiHd5yV/4zej3kXJ7qUZ35nk7gDkXiDRjimMKVyCukBdeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Nvw9jKvu; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZZ
	Ttms7TBRD0y7cEZYRdqCrECvVlyVPosONMUJm1U7I=; b=Nvw9jKvu3ETO9uxlak
	BvEsDVZZ4BNFDtZyGs1BGqENzS+B9XQniqxuvTgTgWltuikJbrUQbZgNr1vp8VnP
	J3lOmDpl+tPGBXYIs5bkKNThP1Vuqv5xh2JTpbDwaIRQApX5vUFyz0f4gvJjyGt2
	USJKTzj7SEUv9s0IlC7mAfsS8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3fmEVzB1oyGRhAA--.7417S2;
	Fri, 09 May 2025 17:34:14 +0800 (CST)
From: oushixiong1025@163.com
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sean Paul <sean@poorly.run>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH v5 1/3] drm/shmem-helper: Import dmabuf without mapping its sg_table
Date: Fri,  9 May 2025 17:34:06 +0800
Message-Id: <20250509093408.611642-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3fmEVzB1oyGRhAA--.7417S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtryrGFW8uF1kJw4rKF18uFg_yoWxKF45pF
	sxAryUKrW5tFWqg3s3Awn7Zas09w409F4Iq3yfJw4Y93WktF1qkFn5Ar90vFy7AryDJFyS
	qFWDAFyrCryjkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn2-5UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbBYwRID2gdt39r5wABsQ

From: Shixiong Ou <oushixiong@kylinos.cn>

[WHY]
1. Drivers using DRM_GEM_SHADOW_PLANE_HELPER_FUNCS and
   DRM_GEM_SHMEM_DRIVER_OPS (e.g., udl, ast) do not require
   sg_table import.
   They only need dma_buf_vmap() to access the shared buffer's
   kernel virtual address.

2. On certain Aspeed-based boards, a dma_mask of 0xffff_ffff may
   trigger SWIOTLB during dmabuf import. However, IO_TLB_SEGSIZE
   restricts the maximum DMA streaming mapping memory, resulting in
   errors like:

   ast 0000:07:00.0: swiotlb buffer is full (sz: 3145728 bytes), total 32768 (slots), used 0 (slots)

[HOW]
Provide a gem_prime_import implementation without sg_table mapping
to avoid issues (e.g., "swiotlb buffer is full"). Drivers that do not
require sg_table can adopt this.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
v1->v2:
	Patch rebase.
v2->v3:
	Rename the import callback function.
	Remove drm_gem_shmem_prime_export() and separate some codes
	to drm_gem_prime_import_self(). 
v3->v4:
	Separate the test from the policy.
	Rename the macro.
v4->v5:
	Rename some functions.

 drivers/gpu/drm/drm_gem_shmem_helper.c | 57 ++++++++++++++++++++++++++
 drivers/gpu/drm/drm_prime.c            | 36 ++++++++++++----
 include/drm/drm_gem_shmem_helper.h     | 15 +++++++
 include/drm/drm_prime.h                |  3 ++
 4 files changed, 102 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index aa43265f4f4f..126aa79042ad 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -800,6 +800,63 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import_sg_table);
 
+/**
+ * drm_gem_shmem_prime_import_no_map - Import dmabuf without mapping its sg_table
+ * @dev: Device to import into
+ * @dma_buf: dma-buf object to import
+ *
+ * Drivers that use the shmem helpers but also wants to import dmabuf without
+ * mapping its sg_table can use this as their &drm_driver.gem_prime_import
+ * implementation.
+ */
+struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
+							 struct dma_buf *dma_buf)
+{
+	struct dma_buf_attachment *attach;
+	struct drm_gem_shmem_object *shmem;
+	struct drm_gem_object *obj;
+	size_t size;
+	int ret;
+
+	if (drm_gem_is_prime_exported_dma_buf(dev, dma_buf)) {
+		/*
+		 * Importing dmabuf exported from our own gem increases
+		 * refcount on gem itself instead of f_count of dmabuf.
+		 */
+		obj = dma_buf->priv;
+		drm_gem_object_get(obj);
+		return obj;
+	}
+
+	attach = dma_buf_attach(dma_buf, dev->dev);
+	if (IS_ERR(attach))
+		return ERR_CAST(attach);
+
+	get_dma_buf(dma_buf);
+
+	size = PAGE_ALIGN(attach->dmabuf->size);
+
+	shmem = __drm_gem_shmem_create(dev, size, true, NULL);
+	if (IS_ERR(shmem)) {
+		ret = PTR_ERR(shmem);
+		goto fail_detach;
+	}
+
+	drm_dbg_prime(dev, "size = %zu\n", size);
+
+	shmem->base.import_attach = attach;
+	shmem->base.resv = dma_buf->resv;
+
+	return &shmem->base;
+
+fail_detach:
+	dma_buf_detach(dma_buf, attach);
+	dma_buf_put(dma_buf);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import_no_map);
+
 MODULE_DESCRIPTION("DRM SHMEM memory-management helpers");
 MODULE_IMPORT_NS("DMA_BUF");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index d828502268b8..b825b71038d6 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -910,6 +910,26 @@ struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
 }
 EXPORT_SYMBOL(drm_gem_prime_export);
 
+
+/**
+ * drm_gem_is_prime_exported_dma_buf -
+ * checks if the DMA-BUF was exported from a GEM object belonging to @dev.
+ * @dev: drm_device to check against
+ * @dma_buf: dma-buf object to import
+ *
+ * Return: true if the DMA-BUF was exported from a GEM object belonging
+ * to @dev, false otherwise.
+ */
+
+bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
+				       struct dma_buf *dma_buf)
+{
+	struct drm_gem_object *obj = dma_buf->priv;
+
+	return (dma_buf->ops == &drm_gem_prime_dmabuf_ops) && (obj->dev == dev);
+}
+EXPORT_SYMBOL(drm_gem_is_prime_exported_dma_buf);
+
 /**
  * drm_gem_prime_import_dev - core implementation of the import callback
  * @dev: drm_device to import into
@@ -933,16 +953,14 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	int ret;
 
-	if (dma_buf->ops == &drm_gem_prime_dmabuf_ops) {
+	if (drm_gem_is_prime_exported_dma_buf(dev, dma_buf)) {
+		/*
+		 * Importing dmabuf exported from our own gem increases
+		 * refcount on gem itself instead of f_count of dmabuf.
+		 */
 		obj = dma_buf->priv;
-		if (obj->dev == dev) {
-			/*
-			 * Importing dmabuf exported from our own gem increases
-			 * refcount on gem itself instead of f_count of dmabuf.
-			 */
-			drm_gem_object_get(obj);
-			return obj;
-		}
+		drm_gem_object_get(obj);
+		return obj;
 	}
 
 	if (!dev->driver->gem_prime_import_sg_table)
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index b4f993da3cae..35f7466dca84 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -287,6 +287,8 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
 				    struct sg_table *sgt);
 int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			      struct drm_mode_create_dumb *args);
+struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
+							 struct dma_buf *buf);
 
 /**
  * DRM_GEM_SHMEM_DRIVER_OPS - Default shmem GEM operations
@@ -298,4 +300,17 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table, \
 	.dumb_create		   = drm_gem_shmem_dumb_create
 
+/**
+ * DRM_GEM_SHMEM_DRIVER_OPS_NO_MAP_SGT - shmem GEM operations
+ *                                       without mapping sg_table on
+ *                                       imported buffer.
+ *
+ * This macro provides a shortcut for setting the shmem GEM operations in
+ * the &drm_driver structure for drivers that do not require a sg_table on
+ * imported buffers.
+ */
+#define DRM_GEM_SHMEM_DRIVER_OPS_NO_MAP_SGT \
+	.gem_prime_import       = drm_gem_shmem_prime_import_no_map, \
+	.dumb_create            = drm_gem_shmem_dumb_create
+
 #endif /* __DRM_GEM_SHMEM_HELPER_H__ */
diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
index fa085c44d4ca..f50f862f0d8b 100644
--- a/include/drm/drm_prime.h
+++ b/include/drm/drm_prime.h
@@ -100,6 +100,9 @@ struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
 unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt);
 
 /* helper functions for importing */
+bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
+				       struct dma_buf *dma_buf);
+
 struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
 						struct dma_buf *dma_buf,
 						struct device *attach_dev);
-- 
2.17.1


