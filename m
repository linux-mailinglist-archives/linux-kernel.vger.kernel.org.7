Return-Path: <linux-kernel+bounces-876376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C1BC1B531
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562261AA5442
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A812E6CC2;
	Wed, 29 Oct 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rEIvVSAF"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996832E093C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748628; cv=none; b=MqUerpNgmzvDbOZ+pUzJFc3QKl65ZB7tg+weD1tTp33Gv+fuYYgxpknPOjTIKu/Cykzj+bA8jy6uS3fFDyhUqHD8Q2WA6/HAi0KpQDwO7/cM6N1xubRqSu00KWlZ0NWtzoOPgEu25ZL5rKa/37yKziCoYfsYNthSNNH8LwTiVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748628; c=relaxed/simple;
	bh=EWVgtj5CqLfQMmBn4PxWSe+Ra69UhyW4oe1nnFTIWxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WLIM70/1Tlder7la1T4ryyjGtM2RLdis5J8DS2eX135QwBJnusy5Pqw36aXIwB5qV0t0dXkTmCCm6irH5FrBfXXXeIOf12aw8KO/vwisXOh4tPNt6Jz7LkdA2zg7LisXXTmxWNs5DsY8NebtCG4/UilPAnl9gtoytNND5nkEkLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rEIvVSAF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CE5DE4E413CF;
	Wed, 29 Oct 2025 14:37:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A2672606E8;
	Wed, 29 Oct 2025 14:37:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D850117F81B3;
	Wed, 29 Oct 2025 15:37:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748623; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DiQB9CvqPCMSCmfCQm+BM0yWoh/K98ULkreAzLkudAw=;
	b=rEIvVSAFBJVqP2kWkuvDv4tBTWrUMjT/HWF0WsW8PKtakZLthMr5N5xsYbj6cf35YL+cPA
	FSqKoH24AGzJRcNMORxiWMbKe4b6RAZYm8uPP9xRhGCeqpSA88enrIxmSlCydcBiHvk53l
	MBwbWX8YKnzkSIiAabZuPfQL6tDOeoAiQIoVnqLC+9zGP+0ZelGM9swB0CjjLnf6SPULr8
	dHNKYBwppdnZINlg3V46aPYFHtXgPWfCRbqUuu674IHaX5qcYe3y4fQVHA32+K1GcsvxX6
	dH8SY/Q1LQTa/TyQSrnN33rPCBklcIUb7+q/Za5rhhqhj4e8u3mQ77QtzQjUcg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:36:45 +0100
Subject: [PATCH RESEND v2 08/32] drm/vkms: Introduce config for plane
 rotation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-8-a49a2d4cba26@bootlin.com>
References: <20251029-vkms-all-config-v2-0-a49a2d4cba26@bootlin.com>
In-Reply-To: <20251029-vkms-all-config-v2-0-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11951;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=EWVgtj5CqLfQMmBn4PxWSe+Ra69UhyW4oe1nnFTIWxY=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ7ewS7jOCcxzhGDbAAD3UJ5s5lT+gAkyfYj
 aqeTDzb9g2JAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImewAKCRAgrS7GWxAs
 4sr3D/9a5A1bmt74uypnnEsBFSuTpwS9KC+OkRiCtU+bZ4ImoLQpSY54CAwSt/7OdiN7Qbnz0Gf
 HOTqAWDB1EGX9Dbb/ebdOHQzSvyrpTMswzoN2u+8+jCPvuqTmBMHm7rOvBU8FbWgze40EjLyjqB
 1b8Krz1OdJyvPMH0FjFwyxIwv/9wJaJTb5D1rSL50fui5ofHMr8h8bizeRGB4hPEn0bGJOgF2bi
 9pcHPi0ymgAiU1aG6/QWVFBO3UlRcqllm2M4L2jKwOf31ViGw76zJ17TA+AhhCg9rVwuSyeTG2c
 knmUdXcGYNuRFoew9tK4mna1dxd8nQytZuY0Mf+8PsijcaOVwBpCvl3f/s80+6LTCGDtLXkmj8l
 6wNBjQzyfdGbeFJPvHw9odMbmHbq0ph+D5eihg5tSsksf1zazp/G4cIpcROXDJqq1FbqVBBT0Da
 pUfvd1q0rxaEJQmCJkPUok7MZ3QxIuMgGhAogB1vFXQ/2pR5bWICX4JpDdz8EZvu4/RIrkQP+OA
 PdBnHr+CUn1D4PWR3C6FssGxHgLHAs5aghJ180pnvwNne2ZWqi9bkVTReO9VAxVCwlaBszEPqOx
 PVdDx1b/SzO2ZskL78Yye2KHK0zmPRwJtRrCIW14xHZ22i5pqjSI1SE0zYH+VbC07XhKLjvOdnf
 TKjBXoXEMw5PRcg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

VKMS driver supports all the rotation on planes, but for testing it can be
useful to only advertise few of them. This new configuration interface
will allow configuring the rotation per planes.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 46 +++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            | 63 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 59 +++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c             |  6 ++-
 4 files changed, 172 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index d75a6252e4d2..8d805084ad96 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <drm/drm_mode.h>
 #include <kunit/test.h>
 
 #include "../vkms_config.h"
@@ -172,6 +173,12 @@ static void vkms_config_test_default_config(struct kunit *test)
 			n_possible_crtcs++;
 		}
 		KUNIT_EXPECT_EQ(test, n_possible_crtcs, 1);
+		KUNIT_EXPECT_EQ(test,
+				vkms_config_plane_get_supported_rotations(plane_cfg),
+				DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
+		KUNIT_EXPECT_EQ(test,
+				vkms_config_plane_get_default_rotation(plane_cfg),
+				DRM_MODE_ROTATE_0);
 	}
 
 	/* Encoders */
@@ -468,6 +475,44 @@ static void vkms_config_test_valid_plane_type(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_valid_plane_rotations(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_plane *plane_cfg;
+
+	config = vkms_config_default_create(false, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	plane_cfg = get_first_plane(config);
+
+	/* Valid, no rotation, no reflection */
+	vkms_config_plane_set_supported_rotations(plane_cfg, DRM_MODE_ROTATE_0);
+	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_ROTATE_0);
+	KUNIT_EXPECT_TRUE(test, vkms_config_valid_plane_rotation(config, plane_cfg));
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Invalid, default rotation is not supported */
+	vkms_config_plane_set_supported_rotations(plane_cfg, DRM_MODE_ROTATE_0);
+	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_ROTATE_90);
+	KUNIT_EXPECT_FALSE(test, vkms_config_valid_plane_rotation(config, plane_cfg));
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Invalid, supported rotations must contains at least one rotation */
+	vkms_config_plane_set_supported_rotations(plane_cfg, DRM_MODE_REFLECT_MASK);
+	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_REFLECT_X | DRM_MODE_ROTATE_0);
+	KUNIT_EXPECT_FALSE(test, vkms_config_valid_plane_rotation(config, plane_cfg));
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Invalid, default rotation must contains at least one rotation */
+	vkms_config_plane_set_supported_rotations(plane_cfg,
+						  DRM_MODE_REFLECT_MASK | DRM_MODE_ROTATE_0);
+	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_REFLECT_X);
+	KUNIT_EXPECT_FALSE(test, vkms_config_valid_plane_rotation(config, plane_cfg));
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
 static void vkms_config_test_valid_plane_possible_crtcs(struct kunit *test)
 {
 	struct vkms_config *config;
@@ -990,6 +1035,7 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_get_connectors),
 	KUNIT_CASE(vkms_config_test_invalid_plane_number),
 	KUNIT_CASE(vkms_config_test_valid_plane_type),
+	KUNIT_CASE(vkms_config_test_valid_plane_rotations),
 	KUNIT_CASE(vkms_config_test_valid_plane_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_invalid_crtc_number),
 	KUNIT_CASE(vkms_config_test_invalid_encoder_number),
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index bfafb5d2504d..dd951db88888 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -3,7 +3,9 @@
 #include <linux/slab.h>
 #include <linux/string_choices.h>
 
+#include <drm/drm_blend.h>
 #include <drm/drm_connector.h>
+#include <drm/drm_mode.h>
 #include <drm/drm_print.h>
 #include <drm/drm_debugfs.h>
 #include <kunit/visibility.h>
@@ -146,6 +148,33 @@ static bool valid_plane_number(const struct vkms_config *config)
 	return true;
 }
 
+VISIBLE_IF_KUNIT
+bool vkms_config_valid_plane_rotation(const struct vkms_config *config,
+				      const struct vkms_config_plane *plane_cfg)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+
+	if ((vkms_config_plane_get_default_rotation(plane_cfg) &
+	     vkms_config_plane_get_supported_rotations(plane_cfg)) !=
+	    vkms_config_plane_get_default_rotation(plane_cfg)) {
+		drm_info(dev, "Configured default rotation is not supported by the plane\n");
+		return false;
+	}
+
+	if ((vkms_config_plane_get_default_rotation(plane_cfg) & DRM_MODE_ROTATE_MASK) == 0) {
+		drm_info(dev, "Configured default rotation must contains at least one possible rotation\n");
+		return false;
+	}
+
+	if ((vkms_config_plane_get_supported_rotations(plane_cfg) & DRM_MODE_ROTATE_MASK) == 0) {
+		drm_info(dev, "Configured supported rotations must contains at least one possible rotation\n");
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_valid_plane_rotation);
+
 static bool valid_planes_for_crtc(const struct vkms_config *config,
 				  struct vkms_config_crtc *crtc_cfg)
 {
@@ -303,6 +332,12 @@ static bool valid_connector_possible_encoders(const struct vkms_config *config)
 bool vkms_config_is_valid(const struct vkms_config *config)
 {
 	struct vkms_config_crtc *crtc_cfg;
+	struct vkms_config_plane *plane_cfg;
+
+	vkms_config_for_each_plane(config, plane_cfg) {
+		if (!vkms_config_valid_plane_rotation(config, plane_cfg))
+			return false;
+	}
 
 	if (!valid_plane_number(config))
 		return false;
@@ -334,6 +369,22 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);
 
+static void show_bitfield(struct seq_file *m, uint32_t value, const char *callback(unsigned int))
+{
+	u32 offset = 0;
+	bool first = true;
+
+	while (value >= BIT(offset) && offset < 32) {
+		if (value & BIT(offset)) {
+			if (!first)
+				seq_puts(m, ",");
+			seq_printf(m, callback(offset));
+			first = false;
+		}
+		offset += 1;
+	}
+}
+
 static int vkms_config_show(struct seq_file *m, void *data)
 {
 	struct drm_debugfs_entry *entry = m->private;
@@ -354,6 +405,14 @@ static int vkms_config_show(struct seq_file *m, void *data)
 			   drm_get_plane_type_name(vkms_config_plane_get_type(plane_cfg)));
 		seq_printf(m, "\tname=%s\n",
 			   vkms_config_plane_get_name(plane_cfg));
+		seq_puts(m, "\tsupported rotations=");
+		show_bitfield(m, vkms_config_plane_get_supported_rotations(plane_cfg),
+			      drm_get_rotation_name);
+		seq_puts(m, "\n");
+		seq_puts(m, "\tdefault rotation=");
+		show_bitfield(m, vkms_config_plane_get_default_rotation(plane_cfg),
+			      drm_get_rotation_name);
+		seq_puts(m, "\n");
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -395,6 +454,10 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
 	plane_cfg->config = config;
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
 	vkms_config_plane_set_name(plane_cfg, NULL);
+	vkms_config_plane_set_supported_rotations(plane_cfg,
+						  DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
+	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_ROTATE_0);
+
 	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
 	list_add_tail(&plane_cfg->link, &config->planes);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 57342db5795a..8d413e02180a 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -39,6 +39,8 @@ struct vkms_config {
  * @type: Type of the plane. The creator of configuration needs to ensures that
  *        at least one primary plane is present.
  * @possible_crtcs: Array of CRTCs that can be used with this plane
+ * @default_rotation: Default rotation that should be used by this plane
+ * @supported_rotation: Rotation that this plane will support
  * @plane: Internal usage. This pointer should never be considered as valid.
  *         It can be used to store a temporary reference to a VKMS plane during
  *         device creation. This pointer is not managed by the configuration and
@@ -50,6 +52,8 @@ struct vkms_config_plane {
 
 	const char *name;
 	enum drm_plane_type type;
+	unsigned int default_rotation;
+	unsigned int supported_rotations;
 	struct xarray possible_crtcs;
 
 	/* Internal usage */
@@ -290,6 +294,61 @@ vkms_config_plane_set_type(struct vkms_config_plane *plane_cfg,
 	plane_cfg->type = type;
 }
 
+/**
+ * vkms_config_plane_get_default_rotation() - Get the default rotation for a plane
+ * @plane_cfg: Plane to get the default rotation from
+ *
+ * Returns:
+ * The default rotation for the plane.
+ */
+static inline unsigned int
+vkms_config_plane_get_default_rotation(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->default_rotation;
+}
+
+/**
+ * vkms_config_plane_set_default_rotation() - Set the default rotation for a plane
+ * @plane_cfg: Plane to set the default rotation to
+ * @default_rotation: New default rotation for the plane
+ */
+static inline void
+vkms_config_plane_set_default_rotation(struct vkms_config_plane *plane_cfg,
+				       unsigned int default_rotation)
+{
+	plane_cfg->default_rotation = default_rotation;
+}
+
+/**
+ * vkms_config_plane_get_supported_rotations() - Get the supported rotations for a plane
+ * @plane_cfg: Plane to get the supported rotations from
+ *
+ * Returns:
+ * The supported rotations for the plane.
+ */
+static inline unsigned int
+vkms_config_plane_get_supported_rotations(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->supported_rotations;
+}
+
+/**
+ * vkms_config_plane_set_supported_rotations() - Set the supported rotations for a plane
+ * @plane_cfg: Plane to set the supported rotations to
+ * @supported_rotations: New supported rotations for the plane
+ */
+static inline void
+vkms_config_plane_set_supported_rotations(struct vkms_config_plane *plane_cfg,
+					  unsigned int supported_rotations)
+{
+	plane_cfg->supported_rotations = supported_rotations;
+}
+
+#if IS_ENABLED(CONFIG_KUNIT)
+bool vkms_config_valid_plane_rotation(const struct vkms_config *config,
+				      const struct vkms_config_plane *plane_cfg);
+#endif
+
 /**
  * vkms_config_plane_set_name() - Set the plane name
  * @plane_cfg: Plane to set the name to
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 73180cbb78b1..d147b70692fa 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include "vkms_config.h"
 #include <linux/iosys-map.h>
 
 #include <drm/drm_atomic.h>
@@ -233,8 +234,9 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 
 	drm_plane_helper_add(&plane->base, &vkms_plane_helper_funcs);
 
-	drm_plane_create_rotation_property(&plane->base, DRM_MODE_ROTATE_0,
-					   DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
+	drm_plane_create_rotation_property(&plane->base,
+					   vkms_config_plane_get_default_rotation(config),
+					   vkms_config_plane_get_supported_rotations(config));
 
 	drm_plane_create_color_properties(&plane->base,
 					  BIT(DRM_COLOR_YCBCR_BT601) |

-- 
2.51.0


