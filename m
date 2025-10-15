Return-Path: <linux-kernel+bounces-854783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB5BBDF62D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3C8483A86
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EB630B50B;
	Wed, 15 Oct 2025 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="anvXxSpt"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9BC308F26;
	Wed, 15 Oct 2025 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542241; cv=none; b=jH/9UzdXvIfaKOdDW/kL9bMeeVruLa4Aj8gM7keCJrw5BiixeAKVxbqtzf8RB9I4imanVPQ+1NwY3QihzCgwRwHuAwZvIUWUv0Y+nJ2/rp+NnzRI7+CG1uLcwewCLBc0TtVhLJjJy5w66tLD5ajujf9+wpxdIkTpoUE/iUjQI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542241; c=relaxed/simple;
	bh=2YyHnJ7MG9Sk+eB8X8EQ2czQs/R8vZqVR26EnmlFgQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omm7Qx70qNPiRc3stV4heUmk2XVHoowcCWeVKql5CA2xe312f+1zrV6mpqqmyVIdAM5/91GfLB5Z/ZpDlWNwBgk9VCWPfou/kvBECidlWmk+3jmMZCFXDlDaVRgpSDHWCAcd5A3BaNiuPGAonZZzHckWK3hMa5UO+oHKQNBZ8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=anvXxSpt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760542237;
	bh=2YyHnJ7MG9Sk+eB8X8EQ2czQs/R8vZqVR26EnmlFgQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=anvXxSptCiIgOuEsSH5DjAHWDBZLh4/OWy4y/sLeOha9IsxpqBMOWJtzGnyVjvGr4
	 WQqx8qzJeyzJ7puOnBg7dq6o/RuIDKgWjnBYWcECEJtrlf6nX8RZWB/8dEIL7LZDJc
	 L9HBPWOekFbsGbnW9LvpukRcrPBU2bHB5IPo9SUsO2ycN6l0lC3btFYNbH+Q7CbSDx
	 ezu6N8IZPuOQ6ZC3Y7velZQ80GGHxahF0nrYtgMUixxqU2LG8Cd0z8pnoPxrR5kXru
	 7a+U5qeZ1EMEFPAfuEaHddCtLHMgLPsYXnftfOaedjeszqK5brUqS8SWeTgNMPnnqX
	 vO7qbk4bCp1ag==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:826d:bc07:e98c:84a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0D01E17E0CA3;
	Wed, 15 Oct 2025 17:30:37 +0200 (CEST)
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
	Andi Shyti <andi.shyti@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christopher Healy <healych@amazon.com>,
	Matthew Wilcox <willy@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v4 05/13] drm/gem: Add huge tmpfs mount point helper
Date: Wed, 15 Oct 2025 17:30:09 +0200
Message-ID: <20251015153018.43735-6-loic.molinari@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015153018.43735-1-loic.molinari@collabora.com>
References: <20251015153018.43735-1-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the drm_gem_huge_mnt_create() helper to avoid code duplication in
the i915, V3D, Panfrost and Panthor drivers. It creates and mounts a
dedicated huge tmpfs mountpoint, for the lifetime of a DRM device,
used at GEM object initialization.

The next commits will port drivers to this helper.

v3:
- store huge tmpfs mountpoint in drm_device

v4:
- return 0 in builds with CONFIG_TRANSPARENT_HUGEPAGE=n
- return 0 when huge_mnt already exists

Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
---
 drivers/gpu/drm/drm_gem.c | 58 +++++++++++++++++++++++++++++++++++++++
 include/drm/drm_device.h  | 11 ++++++++
 include/drm/drm_gem.h     |  1 +
 3 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index a98d5744cc6c..db8c0a217add 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -29,6 +29,7 @@
 #include <linux/export.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/iosys-map.h>
 #include <linux/mem_encrypt.h>
 #include <linux/mm.h>
@@ -82,6 +83,63 @@
  * up at a later date, and as our interface with shmfs for memory allocation.
  */
 
+static void drm_gem_huge_mnt_free(struct drm_device *dev, void *data)
+{
+	drm_WARN_ON(dev, dev->huge_mnt == NULL);
+
+	kern_unmount(dev->huge_mnt);
+	dev->huge_mnt = NULL;
+}
+
+/**
+ * drm_gem_huge_mnt_create - Create, mount and use a huge tmpfs mountpoint
+ * @dev: drm_device a huge tmpfs mountpoint should be used with
+ * @value: huge tmpfs mount option value
+ *
+ * This function creates and mounts a dedicated huge tmpfs mountpoint for the
+ * lifetime of the drm device @dev which is used at GEM object initialization
+ * with drm_gem_object_init().
+ *
+ * The most common option value @value is "within_size" which only allocates
+ * huge pages if the page will be fully within the GEM object size. "always",
+ * "advise" and "never" are supported too but the latter would just create a
+ * mountpoint similar to the default one (`shm_mnt`). See shmemfs and
+ * Transparent Hugepage for more information.
+ *
+ * Returns:
+ * 0 on success or a negative error code on failure.
+ */
+int drm_gem_huge_mnt_create(struct drm_device *dev, const char *value)
+{
+	struct file_system_type *type;
+	struct fs_context *fc;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return 0;
+	if (unlikely(dev->huge_mnt))
+		return 0;
+
+	type = get_fs_type("tmpfs");
+	if (unlikely(!type))
+		return -EOPNOTSUPP;
+	fc = fs_context_for_mount(type, SB_KERNMOUNT);
+	if (IS_ERR(fc))
+		return PTR_ERR(fc);
+	ret = vfs_parse_fs_string(fc, "source", "tmpfs");
+	if (unlikely(ret))
+		return -ENOPARAM;
+	ret = vfs_parse_fs_string(fc, "huge", value);
+	if (unlikely(ret))
+		return -ENOPARAM;
+
+	dev->huge_mnt = fc_mount_longterm(fc);
+	put_fs_context(fc);
+
+	return drmm_add_action_or_reset(dev, drm_gem_huge_mnt_free, NULL);
+}
+EXPORT_SYMBOL_GPL(drm_gem_huge_mnt_create);
+
 static void
 drm_gem_init_release(struct drm_device *dev, void *ptr)
 {
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 778b2cca6c49..352e3db402d7 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -3,6 +3,7 @@
 
 #include <linux/list.h>
 #include <linux/kref.h>
+#include <linux/mount.h>
 #include <linux/mutex.h>
 #include <linux/idr.h>
 #include <linux/sched.h>
@@ -168,6 +169,16 @@ struct drm_device {
 	 */
 	struct drm_master *master;
 
+	/**
+	 * @huge_mnt:
+	 *
+	 * Huge tmpfs mountpoint used at GEM object initialization
+	 * drm_gem_object_init(). Drivers can call drm_gem_huge_mnt_create() to
+	 * create a huge tmfps mountpoint. The default tmpfs mountpoint
+	 * (`shm_mnt`) is used if NULL.
+	 */
+	struct vfsmount *huge_mnt;
+
 	/**
 	 * @driver_features: per-device driver features
 	 *
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 7c8bd67d087c..7285a62d9afc 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -492,6 +492,7 @@ struct drm_gem_object {
 		DRM_GEM_FOPS,\
 	}
 
+int drm_gem_huge_mnt_create(struct drm_device *dev, const char *value);
 void drm_gem_object_release(struct drm_gem_object *obj);
 void drm_gem_object_free(struct kref *kref);
 int drm_gem_object_init(struct drm_device *dev,
-- 
2.47.3


