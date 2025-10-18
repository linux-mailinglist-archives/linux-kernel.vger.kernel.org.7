Return-Path: <linux-kernel+bounces-858926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AA4BEC465
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682E4406E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730D822173F;
	Sat, 18 Oct 2025 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E7IVOwf5"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBEE20D4E9
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752918; cv=none; b=rU6PByaN5gg2e3J490bfs3T4lwDSN6h7+S9t/EYMxcJXx1ySPiZ7XLKhXXu18SRDFVl2rLoJpi7YPY9nKKgyejzQaQFLihxqzKudZmiZLbCJ7D2+xx2ns36gFbSLe6pA8WqNVefzmim7wWU6cTfap11o4ekK34e3ePJTXnS3Tbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752918; c=relaxed/simple;
	bh=bMqgzxaPOkbUjyJt7vujalDG4HEZknk683/aA6OSnyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JbvOtp53umZ9PjFr9ZOaJjLLEQ5kKKZ5nMAS/WNNnH+elwdscX2ePJDqDHxTY9KR3YoBjDHIlJi3IkliX6GH3Uqq1jefOK9CkKDFOU7lkrA6kSTv3orF7cO0r46bc5xjYfNG+gtr/VLUHivVaYhohNlUVyS5WHsNXPa5TGshIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E7IVOwf5; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2BC74C003FD;
	Sat, 18 Oct 2025 02:01:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8113060701;
	Sat, 18 Oct 2025 02:01:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12038102F236C;
	Sat, 18 Oct 2025 04:01:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760752913; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ESq4Ftul8ZQ5lD/S/H9FzihryysQij/M8JZfPZn0lNc=;
	b=E7IVOwf5ZoAhvGlzMR58h7n/OiTXVY4ZOQ5avgxDtOs+NARcH0RixdEbPFcZiPlzhLeZe4
	9/O093Gltfn6RFWVseU2pTyr7oiSz8Cn7pV25eJarb9oqehHfNTM8ggLOoZLKkI0xaHqVq
	XeFUzSj0C4c/IuDceVf/yZH9prGj7k/aorPejuDkdABw1Ku2RGGAqviiYDzbraB/QzZ9lU
	/UjvdRKNg1TEm5jWsp6JhkQflvMl0Kyhb2P2xq8N/h4nisAQ3yk575x11TD0QxS335LimB
	PCxK/q3uOKUC50tHPRTgmSyccCAqnFdDZDzR1MHHqRuLcCKr/hipigqeJKdHyw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 18 Oct 2025 04:01:03 +0200
Subject: [PATCH 03/22] drm/vkms: Introduce config for plane rotation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-vkms-all-config-v1-3-a7760755d92d@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6587;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=bMqgzxaPOkbUjyJt7vujalDG4HEZknk683/aA6OSnyE=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBo8vT9PrlWxxIk6AfW7+HHB1AyKB3MX+LdBcuEO
 sep1StPz/mJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaPL0/QAKCRAgrS7GWxAs
 4mV7EACAoBGdVE1vgHcQAI7TqRjn3gy7WNRfBCeIjoA2t0FD6Yz8o1No6wwfMHlykdx6TgW3jug
 5/nUUDMhfLVIkcC45wd8SSbLcTE+4PKkLZsPy9MIg8CtS5wzIqPm8W2uQft6xWjK4MDlaF6Mr+3
 MK9QECIe1qAHwMP92lY8Mzlkh+XFsZjlE7PGgg1csIuo093341AAACA9tq1+rNjKSs/9P1ZAK6n
 htEM/jlHN6EjmpOycCzx+VIxBZIKwetmzSVaDlwHNq46YVy7ccuuTvu5YbDBAgnPXm7lZl69lnG
 uMbzIlUYzyNVuLzbe6P030s9ZYgA9p3r46/yBLoIaibCvkFlJKhVMY+98pe5YUtLbVbwrDUh/49
 cCAbgZ61Q3fxAch+rXdpRONntKzbsfKQGo3JinI4xxIPvynf0mxEdVDBMOb6GTCLcItzTV4OyxO
 Dq1wGwsW2KEaus3bMyfniCBjyk3Y+kpnAjpPb2aQbbqHOo5VlxzmSp0pEhAovRSDIofFaxPX236
 7ukxc+gRD6QPycPsWr1ql7q3roCNehh3K4e6ltAU3l5Se13yQnrqIRUqtgCK5dQXlSd86k6xTNR
 MXVZsq66CUTMUowhnc/47I9rhbJRtX0J3PG7pEqej78RRycO02IbN6S7VFo8VTMWiFJV6VrGZ01
 JypOs1aYLs9CjlQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

VKMS driver supports all the rotation on planes, but for testing it can be
useful to only advertise few of them. This new configuration interface
will allow configuring the rotation per planes.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 26 ++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h | 54 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c  |  6 +++--
 3 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index ed172f800685..b8cabe6f6cf8 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -144,6 +144,22 @@ static bool valid_plane_number(const struct vkms_config *config)
 	return true;
 }
 
+static bool valid_plane_properties(const struct vkms_config *config)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+	struct vkms_config_plane *plane_cfg;
+
+	vkms_config_for_each_plane(config, plane_cfg) {
+		if ((vkms_config_plane_get_default_rotation(plane_cfg) &
+		     vkms_config_plane_get_supported_rotations(plane_cfg)) !=
+		    vkms_config_plane_get_default_rotation(plane_cfg)) {
+			drm_info(dev, "Configured default rotation is not supported by the plane\n");
+			return false;
+		}
+	}
+	return true;
+}
+
 static bool valid_planes_for_crtc(const struct vkms_config *config,
 				  struct vkms_config_crtc *crtc_cfg)
 {
@@ -302,6 +318,9 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 {
 	struct vkms_config_crtc *crtc_cfg;
 
+	if (!valid_plane_properties(config))
+		return false;
+
 	if (!valid_plane_number(config))
 		return false;
 
@@ -352,6 +371,10 @@ static int vkms_config_show(struct seq_file *m, void *data)
 			   vkms_config_plane_get_type(plane_cfg));
 		seq_printf(m, "\tname=%s\n",
 			   vkms_config_plane_get_name(plane_cfg));
+		seq_printf(m, "\tsupported rotations: 0x%x\n",
+			   vkms_config_plane_get_supported_rotations(plane_cfg));
+		seq_printf(m, "\tdefault rotation: 0x%x\n",
+			   vkms_config_plane_get_default_rotation(plane_cfg));
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -393,6 +416,9 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
 	plane_cfg->config = config;
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
 	vkms_config_plane_set_name(plane_cfg, NULL);
+	vkms_config_plane_set_supported_rotations(plane_cfg, DRM_MODE_ROTATE_MASK);
+	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_ROTATE_0);
+
 	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
 	list_add_tail(&plane_cfg->link, &config->planes);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index b69c35097ba0..3c3cbefcc67f 100644
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
@@ -290,6 +294,56 @@ vkms_config_plane_set_type(struct vkms_config_plane *plane_cfg,
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
+vkms_config_plane_get_default_rotation(struct vkms_config_plane *plane_cfg)
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
+vkms_config_plane_get_supported_rotations(struct vkms_config_plane *plane_cfg)
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
 /**
  * vkms_config_plane_set_name() - Set the plane name
  * @plane_cfg: Plane to set the name to
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 263376686794..6e6bfe1b7400 100644
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


