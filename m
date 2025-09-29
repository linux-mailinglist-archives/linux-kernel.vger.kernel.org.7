Return-Path: <linux-kernel+bounces-836785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0A3BAA904
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8F13C5465
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48FE2512E6;
	Mon, 29 Sep 2025 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NsPTtOcO"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C32225A62E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176286; cv=none; b=tHNS4+dMGyvB+mYX1R8JaFp8g5Z2UfcNaUojaXWAzHtWAVJs2Lf9/EORsj97MX8uQ3ZnxtNKKEIaOEcLgKA3E8RAPil71wTUEhXBqHbLAnk85WtOzu2+M0Lw0u89Uv5KzO05FOi7LZPPTSMJ35JT43oK0VoqZoOOdm+/cunylmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176286; c=relaxed/simple;
	bh=a1OTsZzaI6EEmq0fje1Ikud5+W73fZPK2sKTjtGd50M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHr0X91MV4S92XZfI42vWzuxDRvnImcNxK+4G2TK5fjHA/hwN0Nx8lwvtEBGhuWQ/Jo58ksth8DxOVm9FpjViZBn8FSBzFDS8i7D0S3RhW7mVozrAU9zPfLy+S1zFYAud97YHWBHTROtJFSfPkzhYNNUrUTUkKj9SLIi5o3K+zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NsPTtOcO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759176282;
	bh=a1OTsZzaI6EEmq0fje1Ikud5+W73fZPK2sKTjtGd50M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NsPTtOcOEHo6cW63wk9JJipS+qzyQ8sHXNj879h5rkribjPEw84HRvxMqHaQ05b+w
	 J4gu/pYX19JDrTPCdtYdGgBhCljDur2Y0f87EiLvGPFbW+2WgHVFyVGVO74UcWa68m
	 DMHCvcE6aHxYRJzvDjzd6sDC9hBILg5/ODsLdhO4QW9vsz0uji7XZDaPQgKKYtYXIe
	 Lbj1KfzaJkRMDrFWJIE3j89nZHkePNMj9Gy2mZjK1DgSJhXGyfA2j42ErLmYiTQ+uY
	 b3qbqt8R1+dcN0/jlJzVu74LmXZq3eID+eqlVqXYDERTBJmBMQ9sx1o+Pe5UtDOB11
	 EAdeyoJizW/2g==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:826d:bc07:e98c:84a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B4B2A17E13D8;
	Mon, 29 Sep 2025 22:04:41 +0200 (CEST)
From: =?UTF-8?q?Lo=C3=AFc=20Molinari?= <loic.molinari@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Lo=C3=AFc=20Molinari?= <loic.molinari@collabora.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	=?UTF-8?q?Miko=C5=82aj=20Wasiak?= <mikolaj.wasiak@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	kernel@collabora.com
Subject: [PATCH 3/8] drm/shmem-helper: Add huge tmpfs mount point helpers
Date: Mon, 29 Sep 2025 22:03:11 +0200
Message-ID: <20250929200316.18417-4-loic.molinari@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250929200316.18417-1-loic.molinari@collabora.com>
References: <20250929200316.18417-1-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the drm_gem_shmem_helper_huge_mnt_create() and
drm_gem_shmem_helper_huge_mnt_free() helpers to avoid code duplication
in the i915 and v3d drivers (and soon panfrost/panthor).

Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 56 ++++++++++++++++++++++++++
 include/drm/drm_gem_shmem_helper.h     | 14 +++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 22c4b09e10a3..808721b8be3e 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -5,7 +5,9 @@
 
 #include <linux/dma-buf.h>
 #include <linux/export.h>
+#include <linux/fs_context.h>
 #include <linux/module.h>
+#include <linux/mount.h>
 #include <linux/mutex.h>
 #include <linux/shmem_fs.h>
 #include <linux/slab.h>
@@ -36,6 +38,60 @@ MODULE_IMPORT_NS("DMA_BUF");
  * drm_gem_shmem_vmap()). These helpers perform the necessary type conversion.
  */
 
+static int drm_gem_shmem_add_fc_param(struct fs_context *fc, const char *key,
+				      const char *value)
+{
+	return vfs_parse_fs_string(fc, key, value, strlen(value));
+}
+
+/**
+ * drm_gem_shmem_huge_mnt_create - Create a huge tmpfs mountpoint
+ * @value: huge tmpfs mount option value
+ *
+ * This function creates and mounts an internal huge tmpfs mountpoint for use
+ * with the drm_gem_shmem_create_with_mnt() function.
+ *
+ * The most common option value is "within_size" which only allocates huge pages
+ * if the page will be fully within the GEM object size. "always", "advise" and
+ * "never" are supported too but the latter would just create a mountpoint
+ * similar to default "shm_mnt" one. See shmemfs and Transparent Hugepage for
+ * more information.
+ *
+ * Returns:
+ * A struct vfsmount * on success or an ERR_PTR()-encoded negative error code on
+ * failure.
+ */
+struct vfsmount *drm_gem_shmem_huge_mnt_create(const char *value)
+{
+	struct file_system_type *type;
+	struct fs_context *fc;
+	struct vfsmount *mnt;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	type = get_fs_type("tmpfs");
+	if (!type)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	fc = fs_context_for_mount(type, SB_KERNMOUNT);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
+	ret = drm_gem_shmem_add_fc_param(fc, "source", "tmpfs");
+	if (ret)
+		return ERR_PTR(-ENOPARAM);
+	ret = drm_gem_shmem_add_fc_param(fc, "huge", value);
+	if (ret)
+		return ERR_PTR(-ENOPARAM);
+
+	mnt = fc_mount_longterm(fc);
+	put_fs_context(fc);
+
+	return mnt;
+}
+EXPORT_SYMBOL_GPL(drm_gem_shmem_huge_mnt_create);
+
 static const struct drm_gem_object_funcs drm_gem_shmem_funcs = {
 	.free = drm_gem_shmem_object_free,
 	.print_info = drm_gem_shmem_object_print_info,
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 589f7bfe7506..5e153fb63f38 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -107,6 +107,20 @@ struct drm_gem_shmem_object {
 #define to_drm_gem_shmem_obj(obj) \
 	container_of(obj, struct drm_gem_shmem_object, base)
 
+struct vfsmount *drm_gem_shmem_huge_mnt_create(const char *value);
+
+/**
+ * drm_gem_shmem_huge_mnt_free - Release a huge tmpfs mountpoint.
+ * @mnt: struct vfsmount * to release
+ *
+ * This function unmounts and releases an internal huge tmpfs mountpoint. If
+ * @mnt is NULL, no operation is performed.
+ */
+static inline void drm_gem_shmem_huge_mnt_free(struct vfsmount *mnt)
+{
+	kern_unmount(mnt);
+}
+
 int drm_gem_shmem_init(struct drm_device *dev, struct drm_gem_shmem_object *shmem, size_t size);
 struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
 struct drm_gem_shmem_object *drm_gem_shmem_create_with_mnt(struct drm_device *dev,
-- 
2.47.3


