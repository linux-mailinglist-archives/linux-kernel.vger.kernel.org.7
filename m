Return-Path: <linux-kernel+bounces-710630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B864EAEEEF7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 08:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25D11897592
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 06:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7855A25E813;
	Tue,  1 Jul 2025 06:40:08 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E96A25DAFF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352008; cv=none; b=k7Y4JjLkZcrC31LReoU9s06slSasTTb32F4aTV6fTqy5p9nZWSw6MMLq0Ierjd29ORgdwzKqgi4qN0frhrHMjwpUmP8B9mV0q3GS9Ohd7RbE9hIESpijI66AVSpmcxf1satwEzjfBjlx3UhiFsdSWiI6z4WIJaqNhxA2dTwxMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352008; c=relaxed/simple;
	bh=rSEF8HSN8CgFP1N8JPHzQ2rHHEIB+0IdMrs9C+K7g0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tBtH7M9cMbvpwjf6Zxc+my21tlYqG5Eh9j6dJyEIBgRfRr4pRQG5692ddmUMmS5PGb24Yqlie0GGfMWRdsdGYnHOcYuX6EidrPKHSI8fzqnYDjaohRm6ytI5PICjuqMFfrLyZWw/KUaH6kwlGzV69bOjDmjVwYhECfvOdZoFVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 5616X9GW3210752;
	Tue, 1 Jul 2025 12:03:09 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 5616X8i03210727;
	Tue, 1 Jul 2025 12:03:08 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, simona@ffwll.ch, tzimmermann@suse.de,
        tursulin@ursulin.net, phasta@kernel.org, dakr@kernel.org,
        linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>,
        Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v8 1/4] drm: move drm based debugfs funcs to drm_debugfs.c
Date: Tue,  1 Jul 2025 12:03:00 +0530
Message-Id: <20250701063303.3210665-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Requirement is to create per client-id based directories to
hold key debugging information and for that access to
root debugfs dentry is need which is not in one place
and that information cannot be stored in drm_device.

Move the debugfs functionality from drm_drv.c and drm_accel.c
to drm_debugfs.c This enables debugfs root node reference
directly drm_debugfs.c and hence enable to create per client-id
directory.

v8: Create drm_accel dentry only if it's config is enabled (Jeff, Hugo)
v8: Merge drm_drv and drm_accel debugfs patches (Koenig, Christian)

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/accel/drm_accel.c      | 16 ----------------
 drivers/gpu/drm/drm_debugfs.c  | 32 ++++++++++++++++++++++++++------
 drivers/gpu/drm/drm_drv.c      | 14 ++++----------
 drivers/gpu/drm/drm_internal.h |  6 ++----
 include/drm/drm_accel.h        |  5 -----
 include/drm/drm_drv.h          | 14 ++++++++++++--
 6 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
index aa826033b0ce..ca3357acd127 100644
--- a/drivers/accel/drm_accel.c
+++ b/drivers/accel/drm_accel.c
@@ -20,8 +20,6 @@
 
 DEFINE_XARRAY_ALLOC(accel_minors_xa);
 
-static struct dentry *accel_debugfs_root;
-
 static const struct device_type accel_sysfs_device_minor = {
 	.name = "accel_minor"
 };
@@ -73,17 +71,6 @@ static const struct drm_info_list accel_debugfs_list[] = {
 };
 #define ACCEL_DEBUGFS_ENTRIES ARRAY_SIZE(accel_debugfs_list)
 
-/**
- * accel_debugfs_init() - Initialize debugfs for device
- * @dev: Pointer to the device instance.
- *
- * This function creates a root directory for the device in debugfs.
- */
-void accel_debugfs_init(struct drm_device *dev)
-{
-	drm_debugfs_dev_init(dev, accel_debugfs_root);
-}
-
 /**
  * accel_debugfs_register() - Register debugfs for device
  * @dev: Pointer to the device instance.
@@ -194,7 +181,6 @@ static const struct file_operations accel_stub_fops = {
 void accel_core_exit(void)
 {
 	unregister_chrdev(ACCEL_MAJOR, "accel");
-	debugfs_remove(accel_debugfs_root);
 	accel_sysfs_destroy();
 	WARN_ON(!xa_empty(&accel_minors_xa));
 }
@@ -209,8 +195,6 @@ int __init accel_core_init(void)
 		goto error;
 	}
 
-	accel_debugfs_root = debugfs_create_dir("accel", NULL);
-
 	ret = register_chrdev(ACCEL_MAJOR, "accel", &accel_stub_fops);
 	if (ret < 0)
 		DRM_ERROR("Cannot register ACCEL major: %d\n", ret);
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 2d43bda82887..04da7c27ff7c 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -44,6 +44,9 @@
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
 
+static struct dentry *accel_debugfs_root;
+static struct dentry *drm_debugfs_root;
+
 /***************************************************
  * Initialization, etc.
  **************************************************/
@@ -286,16 +289,34 @@ int drm_debugfs_remove_files(const struct drm_info_list *files, int count,
 }
 EXPORT_SYMBOL(drm_debugfs_remove_files);
 
+void drm_debugfs_init_root(void)
+{
+	drm_debugfs_root = debugfs_create_dir("dri", NULL);
+#if IS_ENABLED(CONFIG_DRM_ACCEL)
+	accel_debugfs_root = debugfs_create_dir("accel", NULL);
+#endif
+}
+
+void drm_debugfs_remove_root(void)
+{
+#if IS_ENABLED(CONFIG_DRM_ACCEL)
+	debugfs_remove(accel_debugfs_root);
+#endif
+	debugfs_remove(drm_debugfs_root);
+}
+
 /**
  * drm_debugfs_dev_init - create debugfs directory for the device
  * @dev: the device which we want to create the directory for
- * @root: the parent directory depending on the device type
  *
  * Creates the debugfs directory for the device under the given root directory.
  */
-void drm_debugfs_dev_init(struct drm_device *dev, struct dentry *root)
+void drm_debugfs_dev_init(struct drm_device *dev)
 {
-	dev->debugfs_root = debugfs_create_dir(dev->unique, root);
+	if (drm_core_check_feature(dev, DRIVER_COMPUTE_ACCEL))
+		dev->debugfs_root = debugfs_create_dir(dev->unique, accel_debugfs_root);
+	else
+		dev->debugfs_root = debugfs_create_dir(dev->unique, drm_debugfs_root);
 }
 
 /**
@@ -322,14 +343,13 @@ void drm_debugfs_dev_register(struct drm_device *dev)
 		drm_atomic_debugfs_init(dev);
 }
 
-int drm_debugfs_register(struct drm_minor *minor, int minor_id,
-			 struct dentry *root)
+int drm_debugfs_register(struct drm_minor *minor, int minor_id)
 {
 	struct drm_device *dev = minor->dev;
 	char name[64];
 
 	sprintf(name, "%d", minor_id);
-	minor->debugfs_symlink = debugfs_create_symlink(name, root,
+	minor->debugfs_symlink = debugfs_create_symlink(name, drm_debugfs_root,
 							dev->unique);
 
 	/* TODO: Only for compatibility with drivers */
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 17fc5dc708f4..b9b5c9f953af 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -69,8 +69,6 @@ DEFINE_XARRAY_ALLOC(drm_minors_xa);
  */
 static bool drm_core_init_complete;
 
-static struct dentry *drm_debugfs_root;
-
 DEFINE_STATIC_SRCU(drm_unplug_srcu);
 
 /*
@@ -183,8 +181,7 @@ static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
 		return 0;
 
 	if (minor->type != DRM_MINOR_ACCEL) {
-		ret = drm_debugfs_register(minor, minor->index,
-					   drm_debugfs_root);
+		ret = drm_debugfs_register(minor, minor->index);
 		if (ret) {
 			DRM_ERROR("DRM: Failed to initialize /sys/kernel/debug/dri.\n");
 			goto err_debugfs;
@@ -751,10 +748,7 @@ static int drm_dev_init(struct drm_device *dev,
 		goto err;
 	}
 
-	if (drm_core_check_feature(dev, DRIVER_COMPUTE_ACCEL))
-		accel_debugfs_init(dev);
-	else
-		drm_debugfs_dev_init(dev, drm_debugfs_root);
+	drm_debugfs_dev_init(dev);
 
 	return 0;
 
@@ -1168,7 +1162,7 @@ static void drm_core_exit(void)
 	drm_panic_exit();
 	accel_core_exit();
 	unregister_chrdev(DRM_MAJOR, "drm");
-	debugfs_remove(drm_debugfs_root);
+	drm_debugfs_remove_root();
 	drm_sysfs_destroy();
 	WARN_ON(!xa_empty(&drm_minors_xa));
 	drm_connector_ida_destroy();
@@ -1187,7 +1181,7 @@ static int __init drm_core_init(void)
 		goto error;
 	}
 
-	drm_debugfs_root = debugfs_create_dir("dri", NULL);
+	drm_debugfs_init_root();
 
 	ret = register_chrdev(DRM_MAJOR, "drm", &drm_stub_fops);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index b2b6a8e49dda..d2d8e72f32d9 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -186,8 +186,7 @@ void drm_gem_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
 #if defined(CONFIG_DEBUG_FS)
 void drm_debugfs_dev_fini(struct drm_device *dev);
 void drm_debugfs_dev_register(struct drm_device *dev);
-int drm_debugfs_register(struct drm_minor *minor, int minor_id,
-			 struct dentry *root);
+int drm_debugfs_register(struct drm_minor *minor, int minor_id);
 void drm_debugfs_unregister(struct drm_minor *minor);
 void drm_debugfs_connector_add(struct drm_connector *connector);
 void drm_debugfs_connector_remove(struct drm_connector *connector);
@@ -205,8 +204,7 @@ static inline void drm_debugfs_dev_register(struct drm_device *dev)
 {
 }
 
-static inline int drm_debugfs_register(struct drm_minor *minor, int minor_id,
-				       struct dentry *root)
+static inline int drm_debugfs_register(struct drm_minor *minor, int minor_id)
 {
 	return 0;
 }
diff --git a/include/drm/drm_accel.h b/include/drm/drm_accel.h
index 038ccb02f9a3..20a665ec6f16 100644
--- a/include/drm/drm_accel.h
+++ b/include/drm/drm_accel.h
@@ -58,7 +58,6 @@ void accel_core_exit(void);
 int accel_core_init(void);
 void accel_set_device_instance_params(struct device *kdev, int index);
 int accel_open(struct inode *inode, struct file *filp);
-void accel_debugfs_init(struct drm_device *dev);
 void accel_debugfs_register(struct drm_device *dev);
 
 #else
@@ -77,10 +76,6 @@ static inline void accel_set_device_instance_params(struct device *kdev, int ind
 {
 }
 
-static inline void accel_debugfs_init(struct drm_device *dev)
-{
-}
-
 static inline void accel_debugfs_register(struct drm_device *dev)
 {
 }
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index a43d707b5f36..392baeaaa4a1 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -566,9 +566,19 @@ static inline bool drm_firmware_drivers_only(void)
 }
 
 #if defined(CONFIG_DEBUG_FS)
-void drm_debugfs_dev_init(struct drm_device *dev, struct dentry *root);
+void drm_debugfs_dev_init(struct drm_device *dev);
+void drm_debugfs_init_root(void);
+void drm_debugfs_remove_root(void);
 #else
-static inline void drm_debugfs_dev_init(struct drm_device *dev, struct dentry *root)
+static inline void drm_debugfs_dev_init(struct drm_device *dev)
+{
+}
+
+static inline void drm_debugfs_init_root(void)
+{
+}
+
+static inline void drm_debugfs_remove_root(void)
 {
 }
 #endif
-- 
2.34.1


