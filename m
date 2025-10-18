Return-Path: <linux-kernel+bounces-858924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2886BBEC435
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8566E1AA56D9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD73211A35;
	Sat, 18 Oct 2025 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nmgII/h1"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329891B425C;
	Sat, 18 Oct 2025 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752915; cv=none; b=HqJ0+PALJL9chxspjUYIPuxOLKo2ohTZioeAqF6yzgsAFlu+A4+gUV2kvPluOMmaLSC56q7t4VO+8vOKZhgQ1hvWwAijM9i54JxRx4gupveVo8ADXGA3f4J6HEYXhiqhz/vEAFSVOR0L/LjFtS7b8vYdXNvd4c++Xbc6cA+LTfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752915; c=relaxed/simple;
	bh=MLS9g/NpckWYbbJ6erVOl7QRiaiJ2oNsg6Sk2z+gRnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XS6jvSWdxNGbFkAkg9cIqdh6abelC5Zlykeqe72loHjNoPjIy6+N2AEaMld229M24t0mCCFnBvaU84umwGfEFz4/VazTAS6epiTiXPjRIF3AlEL1Om/mSWLadnCilkZLOSx5UHbm4+1FvNUqbVee3HABufBTPiWZuAGR1LQscZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nmgII/h1; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7E59A4E4115B;
	Sat, 18 Oct 2025 02:01:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5417B60701;
	Sat, 18 Oct 2025 02:01:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC69C102F236F;
	Sat, 18 Oct 2025 04:01:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760752909; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mnv27ovYNz38usZbzkAYTlGQ14nBpYD431Z4+TIHANM=;
	b=nmgII/h1krwbElwZn8xpCGJU+b78/hg9w91qEAW8pbSXhX6W3WbOK8JXyTasrWysvz9XsI
	45+oPOBYJEkSCTGsyll0WtJsoMipIEqK/pB3rq+VGVUiQD0Sh1RWXUgovlvTZWEc4FVJT7
	mTBhNpO814Xv+KXwXbf3GHtqoLdTd1HHdb/h145ofDZdTIoN4c0V39zBzGGj/q8zGueItG
	m8k14kaqvc8TAFhpU4nhR3Gzb3zXRlcf/GHNvM3bugKe0nF0JG3GURa2fcKgqq98d51kfs
	4Aip95PIeLSnpJS8nTreYrzPQzyERi1AUa5Eqc+euh1WR/1BdKcHgsr1nkiRvg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 18 Oct 2025 04:01:01 +0200
Subject: [PATCH 01/22] drm/vkms: Introduce config for plane name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-vkms-all-config-v1-1-a7760755d92d@bootlin.com>
References: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
In-Reply-To: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5960;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=MLS9g/NpckWYbbJ6erVOl7QRiaiJ2oNsg6Sk2z+gRnQ=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBo8vT9pcd2hSq9HuzMJddMH+kvfVu4GWWq1vSXs
 zsoTOFU24eJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaPL0/QAKCRAgrS7GWxAs
 4jEeD/0R73U6k89+5gVeDYqTQ6fkhZpG2tOpKK4T+QeQeOC0LLDxXWIle3xRl26ZbJWo6vLzT9F
 mDHqTB3ZVz8kGXRrDxZ2PW+LJOruz4sxuymNZEtWfrczc7jLKiBR7fpBevaUToxrTSe9vU4NsqG
 /nXnoOujAhTmR9gZqCZ/C4Yyt3mVCMSf+TyD3oQOBpXMQ5Z+IDXNVF8/hGlkTfcXgrIzqZpqZLJ
 mxgphAh6sblseKPKn7NZ3/A+YsPkOcBrEGFRLJoOncoEdJfsr5Fpn5fn+TLWKjW6i3SyG7Nqujn
 afSQKjopvmOsjIHE9ue4LQZx+VJ6vYvSwhYOfkfcuYzF2qvhFefxk21Q+4dUiWI9IAKJ1RSGyoh
 s/huHiWsOMgeA5gq8YYpFwxRGEqkVM7PnjGiDxbv8Sq6OXqJFVHVWMa8BqLpcjqcvcZUiPj8aEB
 U+dNgml19i9/ckuY1W76iyq2eIfDtaewTfVmA6y62OrSs2kSzkfSeToDoPYNGmyFLxfi3FeyL4v
 bHmxJQBQX9+VF8h97EoAYHmp91rejk3mTTcJb7mFAnBTr3H8gWVqxTnI6ZOS2Ti4cE2dtesv/Xp
 ftM8pLHIYsDwPRQkYwxcSwbyiiqo0n7Lr+1R1+gpySRh46pBKGshE5afzvM8ouxkysZ4+xEI1TD
 PN61p2JrGxIPj9Q==
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
index f8394a063ecf..ed172f800685 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -350,6 +350,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		seq_puts(m, "plane:\n");
 		seq_printf(m, "\ttype=%d\n",
 			   vkms_config_plane_get_type(plane_cfg));
+		seq_printf(m, "\tname=%s\n",
+			   vkms_config_plane_get_name(plane_cfg));
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -390,6 +392,7 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
 
 	plane_cfg->config = config;
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
+	vkms_config_plane_set_name(plane_cfg, NULL);
 	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
 	list_add_tail(&plane_cfg->link, &config->planes);
@@ -402,6 +405,7 @@ void vkms_config_destroy_plane(struct vkms_config_plane *plane_cfg)
 {
 	xa_destroy(&plane_cfg->possible_crtcs);
 	list_del(&plane_cfg->link);
+	kfree_const(plane_cfg->name);
 	kfree(plane_cfg);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_plane);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 4c8d668e7ef8..b69c35097ba0 100644
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
+vkms_config_plane_get_name(struct vkms_config_plane *plane_cfg)
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
index e592e47a5736..263376686794 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -11,6 +11,7 @@
 
 #include "vkms_drv.h"
 #include "vkms_formats.h"
+#include "vkms_config.h"
 
 static const u32 vkms_formats[] = {
 	DRM_FORMAT_ARGB8888,
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


