Return-Path: <linux-kernel+bounces-628242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A670AA5B28
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 08:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23EE1B68522
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 06:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB2026C3B4;
	Thu,  1 May 2025 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dHi/mv/b"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C4267731
	for <linux-kernel@vger.kernel.org>; Thu,  1 May 2025 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746081850; cv=none; b=OQR15mHs2Nz8g5w54znvD3dsEC7E3YbsLleG0DNwxX7MtxNgcoWbTuMbBSKBMHj9U+znCFW332HU3dEZAYOxwzJx3+RUHGm+pvrripN0M5DvEIwP0RECf4r5hKAiWSsakJ79q1MsrAPBsBKzc4DmUWn8hQnvI51lxhc47jrJGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746081850; c=relaxed/simple;
	bh=p8eWZGRb8q55wlvcLrN5gUua+GbWrxkUmoTw18sAwQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lXjlFza6anV2p8U//ze9JoeMGzU9ni5iUD0uj645RKHvu0HqL3c5ZT/v/QbTPb2TSXD/5JTnsNbWbrnvbgRFYlNaersULv6MUQ8MPVLfP1B4RR6Mf+0Nh9XArO65sZSVbGgRU1HPRZY6P26u8c25L4vv0Br2nqeaJhDVIu1VId4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dHi/mv/b; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8jfvY
	4U3TE8veb40M8WUjvKXQCFvHK3PBDgszNNiLaw=; b=dHi/mv/b6GorxDa5nOpsZ
	VQ3M+L679RHRQ15AwsTeeGfrZqbI+IQtpwQCGbn/03ZZ8eIIfBPlPwZkcDUbfnJ9
	b4qTqhqltuTYsmrAY/hpO507gLvSj0sjgcH1/pql0qXffXWfpo2iO20swvMTWWt5
	tl510Gpt69wadaxYz6C6Ks=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCHtnsNGBNoXyLXDg--.28203S2;
	Thu, 01 May 2025 14:43:26 +0800 (CST)
From: oushixiong1025@163.com
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sean Paul <sean@poorly.run>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 1/3] drm/shmem-helper: Import dmabuf without mapping its sg_table
Date: Thu,  1 May 2025 14:43:22 +0800
Message-Id: <20250501064324.398650-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHtnsNGBNoXyLXDg--.28203S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JrW7AFyxZFWDCr45GrWUCFg_yoWxZrW7pF
	sxAry5KrW5trWqgrZ7AF1kZa4Y9w48KF4IqFWfX3yY9F4ktF1qyF1Fkr98ZFW7Cry7Jr1Y
	qryDAFyrKryjkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jec_-UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbBYwxAD2gTEM6EMQAAsw

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
 drivers/gpu/drm/drm_gem_shmem_helper.c | 95 ++++++++++++++++++++++++++
 include/drm/drm_gem_shmem_helper.h     | 24 +++++++
 2 files changed, 119 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index d99dee67353a..9e41e350ff6f 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -39,6 +39,7 @@ MODULE_IMPORT_NS("DMA_BUF");
 static const struct drm_gem_object_funcs drm_gem_shmem_funcs = {
 	.free = drm_gem_shmem_object_free,
 	.print_info = drm_gem_shmem_object_print_info,
+	.export = drm_gem_shmem_object_prime_export,
 	.pin = drm_gem_shmem_object_pin,
 	.unpin = drm_gem_shmem_object_unpin,
 	.get_sg_table = drm_gem_shmem_object_get_sg_table,
@@ -799,6 +800,100 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import_sg_table);
 
+const struct dma_buf_ops drm_gem_shmem_prime_dmabuf_ops =  {
+	.cache_sgt_mapping = true,
+	.attach = drm_gem_map_attach,
+	.detach = drm_gem_map_detach,
+	.map_dma_buf = drm_gem_map_dma_buf,
+	.unmap_dma_buf = drm_gem_unmap_dma_buf,
+	.release = drm_gem_dmabuf_release,
+	.mmap = drm_gem_dmabuf_mmap,
+	.vmap = drm_gem_dmabuf_vmap,
+	.vunmap = drm_gem_dmabuf_vunmap,
+};
+
+/**
+ * drm_gem_shmem_prime_export - implementation of the export callback
+ * @shmem: shmem GEM object
+ */
+struct dma_buf *drm_gem_shmem_prime_export(struct drm_gem_shmem_object *shmem,
+					   int flags)
+{
+	struct drm_gem_object *obj = &shmem->base;
+	struct drm_device *dev = obj->dev;
+	struct dma_buf_export_info exp_info = {
+		.exp_name = KBUILD_MODNAME, /* white lie for debug */
+		.owner = dev->driver->fops->owner,
+		.ops = &drm_gem_shmem_prime_dmabuf_ops,
+		.size = obj->size,
+		.flags = flags,
+		.priv = obj,
+		.resv = obj->resv,
+	};
+
+	return drm_gem_dmabuf_export(dev, &exp_info);
+}
+
+/**
+ * drm_gem_shmem_prime_import - Import dmabuf without mapping its sg_table
+ * @dev: Device to import into
+ * @dma_buf: dma-buf object to import
+ *
+ * Drivers that use the shmem helpers but also wants to import dmabuf without
+ * mapping its sg_table can use this as their &drm_driver.gem_prime_import
+ * implementation.
+ */
+struct drm_gem_object *drm_gem_shmem_prime_import(struct drm_device *dev,
+						  struct dma_buf *dma_buf)
+{
+	struct dma_buf_attachment *attach;
+	struct drm_gem_shmem_object *shmem;
+	size_t size;
+	int ret;
+
+	if (dma_buf->ops == &drm_gem_shmem_prime_dmabuf_ops) {
+		struct drm_gem_object *obj;
+
+		obj = dma_buf->priv;
+		if (obj->dev == dev) {
+			/*
+			 * Importing dmabuf exported from our own gem increases
+			 * refcount on gem itself instead of f_count of dmabuf.
+			 */
+			drm_gem_object_get(obj);
+			return obj;
+		}
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
+EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import);
+
 MODULE_DESCRIPTION("DRM SHMEM memory-management helpers");
 MODULE_IMPORT_NS("DMA_BUF");
 MODULE_LICENSE("GPL v2");
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index cef5a6b5a4d6..78ef91593a8e 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -110,6 +110,8 @@ int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
 void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem,
 			  struct iosys_map *map);
 int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct *vma);
+struct dma_buf *drm_gem_shmem_prime_export(struct drm_gem_shmem_object *shmem,
+						  int flags);
 
 int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem);
@@ -168,6 +170,18 @@ static inline void drm_gem_shmem_object_print_info(struct drm_printer *p, unsign
 	drm_gem_shmem_print_info(shmem, p, indent);
 }
 
+/**
+ * drm_gem_shmem_object_prime_export - GEM object function for export()
+ * @obj: GEM object
+ *
+ */
+static inline struct dma_buf *drm_gem_shmem_object_prime_export(struct drm_gem_object *obj,
+								int flags)
+{
+	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
+
+	return drm_gem_shmem_prime_export(shmem, flags);
+}
 /**
  * drm_gem_shmem_object_pin - GEM object function for drm_gem_shmem_pin()
  * @obj: GEM object
@@ -276,6 +290,8 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
 				    struct sg_table *sgt);
 int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			      struct drm_mode_create_dumb *args);
+struct drm_gem_object *drm_gem_shmem_prime_import(struct drm_device *dev,
+						  struct dma_buf *buf);
 
 /**
  * DRM_GEM_SHMEM_DRIVER_OPS - Default shmem GEM operations
@@ -287,4 +303,12 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table, \
 	.dumb_create		   = drm_gem_shmem_dumb_create
 
+/**
+ * This macro provides a shmem GEM operations that implementate a simple
+ * gem_prime_import.
+ */
+#define DRM_GEM_SHMEM_SIMPLE_DRIVER_OPS \
+	.gem_prime_import	= drm_gem_shmem_prime_import, \
+	.dumb_create		= drm_gem_shmem_dumb_create
+
 #endif /* __DRM_GEM_SHMEM_HELPER_H__ */
-- 
2.17.1


