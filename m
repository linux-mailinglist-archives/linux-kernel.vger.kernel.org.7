Return-Path: <linux-kernel+bounces-876190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CC2C1AF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA463A91C5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F2733B6DE;
	Wed, 29 Oct 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="npWlK3Gd"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125F3358DA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744637; cv=none; b=JJQIz+GE8OmdWtMp2VSfL7WaXnGKia1FPzhzRLveeKUH+/JHIfatuRD5SPQN8TwslGmYtPuxEdUx0x15iC1FhhNx/u84FiZEKjVYRmqZxoZjFAKyiIocpygZ4LI3wyavMGU7iouNUqbEDEN1oodmfqq4YNefSA3MWkiGtAhqat8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744637; c=relaxed/simple;
	bh=JI6BJsuj4AXbzLKNzvB4FHoZVsIkkY5eZBTNuNhEyrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/Ojfc2FOBltUssIWAFDGPme90o8c9/QkNpb+GWiLOVSLCfzKllAMxWpZU3286Sx21ra2AF/YCnbIK5dxkJ1Vejl73iiGO5nawqqKPSJBeVa29+5LTzbxtrUPT+DXsnm95UhXOWZqXNzsvZsQdRh54xslbAMEvyqzc9v8cZLlPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=npWlK3Gd; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9DC05C0DB02;
	Wed, 29 Oct 2025 13:30:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 01372606E8;
	Wed, 29 Oct 2025 13:30:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9EF55117F8047;
	Wed, 29 Oct 2025 14:30:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744632; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6J4X9HET4WTHRHuQARwrxqHYhuRpm2UMz/V2um5iVtU=;
	b=npWlK3GdPJ98KRGhs+vCVDdXUyug0OQ1X1OKn70J7oL6faCZkBefBEI3fKqGR59/PdW+mE
	+M70fFaHyN1/4FlIuvrM0OLXTz0+c1zGY5LeTd32ia3Ddjfgh1OIgyJjCR/YDhXLZfDDiN
	E4zIDbxmVNsIBNDQdP5H3uih/hhvbvsJzc/rVHvFNoQtR1uskN+7Ax2ZNgaXJvnzQVOsXM
	kHjWPYRdFzwTE17EHl3uZLCm8aW6yYxkEAMKoFDWXDG0ykyWYaUaYyjAc2iv7DirgOjPZo
	2k5DscZJiy/V780OYWINSoZU4j7PseXZ+uU7GILvut6vfcC3T9KnTJYBly1GOw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:15 +0100
Subject: [PATCH v2 05/32] drm/vkms: Introduce config for plane name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-5-be20b9bf146e@bootlin.com>
References: <20251029-vkms-all-config-v2-0-be20b9bf146e@bootlin.com>
In-Reply-To: <20251029-vkms-all-config-v2-0-be20b9bf146e@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>
Cc: victoria@system76.com, sebastian.wick@redhat.com, victoria@system76.com, 
 airlied@gmail.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6014;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=JI6BJsuj4AXbzLKNzvB4FHoZVsIkkY5eZBTNuNhEyrQ=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbpdedlxZb3+bTUdvY0rVCdEYW0Wxbynd2GB
 rcsiw8ODV6JAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6QAKCRAgrS7GWxAs
 4tIIEADHoXtLa/cwWR6rmUlzLUNSGwTqwTqLiSkSQ7NUAMqRc3F+SRkOldtxVB49OeP/VzTrkCp
 XrTZWE0Yk2gzZf1dhaxJcRkHQ9IFdeL+ha+e4GlgKchFPTVU9fMwEI9KCR6ffFjMDWvoWCLhWT7
 d6pIqOJMlcVC3aSjnEN8CL3XuBLAw1noI9Q68IK+YZSYNAqPc44UkV2WVLrjWx4tCqSGoOgm677
 T7YEG6wDt2mf7+K5Bo3klTEf9jpASW1/UHFBGWe6WnfxU+icilzD1DlsrUp1LzU4A1pY0LvAP9J
 cT5YKkl1p4GXhnzxpW3wIrqy6nP4ZovQF4pyks4jY70mETr4vU/Az6DQ++79d7avvyP2w/bpscN
 3if+Fc1K5ncM5V5nzuAotCb+7334D6XyzYKIk7QGQz781hldBdawy+bbKI97Qc+2OObGIv3kqun
 2NhyvbIkoQTvGODnDpmUJXxue/kLjFjMvADxfLLNePb1+41u6Yccst3DBJvJ62h1Y6X+J7wPvMH
 NqC5rY4iDY1dKwoqLqkBXQsfhEw+skYyw02unlZJaH6Ym9NzzBdOsV55vi6xFXg48lnJucNOvNr
 f0RXZ8VpCm7mDe9xNy0iPbjgc20nHzyHcPvK5R6B8li9FG0ikjTWpFtRy1s67PpyXDogzWlBoxg
 Ts0Nq1zpz8ht59g==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

As planes can have a name in DRM, prepare VKMS to configure it using
ConfigFS.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c |  4 ++++
 drivers/gpu/drm/vkms/vkms_config.h | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.h    |  5 +++--
 drivers/gpu/drm/vkms/vkms_output.c |  6 +-----
 drivers/gpu/drm/vkms/vkms_plane.c  |  6 ++++--
 5 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 858bec2d1312..bfafb5d2504d 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -352,6 +352,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		seq_puts(m, "plane:\n");
 		seq_printf(m, "\ttype=%s\n",
 			   drm_get_plane_type_name(vkms_config_plane_get_type(plane_cfg)));
+		seq_printf(m, "\tname=%s\n",
+			   vkms_config_plane_get_name(plane_cfg));
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -392,6 +394,7 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
 
 	plane_cfg->config = config;
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
+	vkms_config_plane_set_name(plane_cfg, NULL);
 	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
 	list_add_tail(&plane_cfg->link, &config->planes);
@@ -404,6 +407,7 @@ void vkms_config_destroy_plane(struct vkms_config_plane *plane_cfg)
 {
 	xa_destroy(&plane_cfg->possible_crtcs);
 	list_del(&plane_cfg->link);
+	kfree_const(plane_cfg->name);
 	kfree(plane_cfg);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_plane);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 4c8d668e7ef8..57342db5795a 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -35,6 +35,7 @@ struct vkms_config {
  *
  * @link: Link to the others planes in vkms_config
  * @config: The vkms_config this plane belongs to
+ * @name: Name of the plane
  * @type: Type of the plane. The creator of configuration needs to ensures that
  *        at least one primary plane is present.
  * @possible_crtcs: Array of CRTCs that can be used with this plane
@@ -47,6 +48,7 @@ struct vkms_config_plane {
 	struct list_head link;
 	struct vkms_config *config;
 
+	const char *name;
 	enum drm_plane_type type;
 	struct xarray possible_crtcs;
 
@@ -288,6 +290,30 @@ vkms_config_plane_set_type(struct vkms_config_plane *plane_cfg,
 	plane_cfg->type = type;
 }
 
+/**
+ * vkms_config_plane_set_name() - Set the plane name
+ * @plane_cfg: Plane to set the name to
+ * @name: New plane name. The name is copied.
+ */
+static inline void
+vkms_config_plane_set_name(struct vkms_config_plane *plane_cfg,
+			   const char *name)
+{
+	if (plane_cfg->name)
+		kfree_const(plane_cfg->name);
+	plane_cfg->name = kstrdup_const(name, GFP_KERNEL);
+}
+
+/**
+ * vkms_config_plane_get_name - Get the plane name
+ * @plane_cfg: Plane to get the name from
+ */
+static inline const char *
+vkms_config_plane_get_name(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->name;
+}
+
 /**
  * vkms_config_plane_attach_crtc - Attach a plane to a CRTC
  * @plane_cfg: Plane to attach
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index db260df1d4f6..9ad286f043b5 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -225,6 +225,7 @@ struct vkms_output {
 };
 
 struct vkms_config;
+struct vkms_config_plane;
 
 /**
  * struct vkms_device - Description of a VKMS device
@@ -298,10 +299,10 @@ int vkms_output_init(struct vkms_device *vkmsdev);
  * vkms_plane_init() - Initialize a plane
  *
  * @vkmsdev: VKMS device containing the plane
- * @type: type of plane to initialize
+ * @config: plane configuration
  */
 struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
-				   enum drm_plane_type type);
+				   struct vkms_config_plane *config);
 
 /* CRC Support */
 const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 2ee3749e2b28..22208d02afa4 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -19,11 +19,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		return -EINVAL;
 
 	vkms_config_for_each_plane(vkmsdev->config, plane_cfg) {
-		enum drm_plane_type type;
-
-		type = vkms_config_plane_get_type(plane_cfg);
-
-		plane_cfg->plane = vkms_plane_init(vkmsdev, type);
+		plane_cfg->plane = vkms_plane_init(vkmsdev, plane_cfg);
 		if (IS_ERR(plane_cfg->plane)) {
 			DRM_DEV_ERROR(dev->dev, "Failed to init vkms plane\n");
 			return PTR_ERR(plane_cfg->plane);
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index e592e47a5736..73180cbb78b1 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -9,6 +9,7 @@
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 
+#include "vkms_config.h"
 #include "vkms_drv.h"
 #include "vkms_formats.h"
 
@@ -217,7 +218,7 @@ static const struct drm_plane_helper_funcs vkms_plane_helper_funcs = {
 };
 
 struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
-				   enum drm_plane_type type)
+				   struct vkms_config_plane *config)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	struct vkms_plane *plane;
@@ -225,7 +226,8 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
 					   &vkms_plane_funcs,
 					   vkms_formats, ARRAY_SIZE(vkms_formats),
-					   NULL, type, NULL);
+					   NULL, vkms_config_plane_get_type(config),
+					   vkms_config_plane_get_name(config));
 	if (IS_ERR(plane))
 		return plane;
 

-- 
2.51.0


