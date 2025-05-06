Return-Path: <linux-kernel+bounces-635642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D226AAC051
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 11:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3EE162476
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 09:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB4226B2B1;
	Tue,  6 May 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TwcxafqT"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EDF38DEC
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524927; cv=none; b=ePfMB3DS2FO+I8C3sy3QVr7B1SsdbISZQSF6xZdXM0V8cMZQtQS1rPTgj9MjTAcQRWZCm+cSUJg83nkMtIfrS4MyM+nRDdy9+fIBMyfv1T1r0X73c6pviqCL9ybAwvq+sblbqdLeVACSXqdn731tiMhS27L2dn9cBOOkEqhZZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524927; c=relaxed/simple;
	bh=KGVRcgNxNLqEwNMrGa+Hkc1e+bOdicu8n/SdmBXGtFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g08JQkRaTHZSywO16Hs4QH0jZBCMGE1hYP/wWZcDejKwLp9yvIVXQUfUsFANRrMzyE+AvAVzRx3uYxPmN3tRGeMip+d3B8HunPCGk4dbJLTQsnyL4VBcJZHOoKcwGT8OH5r0UG9DlPRXUZ6IwRBnVfo/I2fhRGErL4Wo/IA4Rjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TwcxafqT; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hv8tt
	vlMQ81tnSj8hJhZN65kdlnbwAC/Lmt/5hy6h0M=; b=TwcxafqTyu9ugXYf5+1Dy
	KtRLmqEp5NG10qjWEfyLbHXK/g/WUDcAJL0BiGF8ZY+wcxfLJNiFAP+23SeX/k3K
	T/BLYVUEO0Nyjk+5iRzeKp1lAcm7HLaEgoW/Fly39l5z9bVW7qwDPuieJJnsUECc
	N2jcW+yahMp/ZhfrLMG4qg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAHzmK_2hloI9kMFA--.14234S2;
	Tue, 06 May 2025 17:47:45 +0800 (CST)
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
Subject: [PATCH v2 1/3] drm/shmem-helper: Import dmabuf without mapping its sg_table
Date: Tue,  6 May 2025 17:47:38 +0800
Message-Id: <20250506094740.621420-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHzmK_2hloI9kMFA--.14234S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar43Gr1UWryrWF4fZF4fZrb_yoWxZw4Upa
	n8AryUKrW5trWqgrZ7Ar1kAa4Y9w40kF4IqFWfJ3yY9F4ktF1qyF1Fkr98ZFW7Cry7Jr1Y
	qryUAFyrKryjkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn2-5UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbBYwlFD2gZ2bcW-gAAsX

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
	patch rebase.

 drivers/gpu/drm/drm_gem_shmem_helper.c | 95 ++++++++++++++++++++++++++
 include/drm/drm_gem_shmem_helper.h     | 25 +++++++
 2 files changed, 120 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index aa43265f4f4f..0c81a4f97684 100644
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
@@ -800,6 +801,100 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import_sg_table);
 
+const struct dma_buf_ops drm_gem_shmem_prime_dmabuf_ops =  {
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
+EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_export);
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
index b4f993da3cae..f2b4cc85b7f9 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -121,6 +121,8 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 				 struct iosys_map *map);
 int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct *vma);
+struct dma_buf *drm_gem_shmem_prime_export(struct drm_gem_shmem_object *shmem,
+					   int flags);
 
 int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem);
@@ -179,6 +181,19 @@ static inline void drm_gem_shmem_object_print_info(struct drm_printer *p, unsign
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
+
 /**
  * drm_gem_shmem_object_pin - GEM object function for drm_gem_shmem_pin()
  * @obj: GEM object
@@ -287,6 +302,8 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device *dev,
 				    struct sg_table *sgt);
 int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			      struct drm_mode_create_dumb *args);
+struct drm_gem_object *drm_gem_shmem_prime_import(struct drm_device *dev,
+						  struct dma_buf *buf);
 
 /**
  * DRM_GEM_SHMEM_DRIVER_OPS - Default shmem GEM operations
@@ -298,4 +315,12 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table, \
 	.dumb_create		   = drm_gem_shmem_dumb_create
 
+/**
+ * This macro provides a shmem GEM operations that implementate a simple
+ * gem_prime_import.
+ */
+#define DRM_GEM_SHMEM_SIMPLE_DRIVER_OPS \
+	.gem_prime_import       = drm_gem_shmem_prime_import, \
+	.dumb_create            = drm_gem_shmem_dumb_create
+
 #endif /* __DRM_GEM_SHMEM_HELPER_H__ */
-- 
2.17.1


