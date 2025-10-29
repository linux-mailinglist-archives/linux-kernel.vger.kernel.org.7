Return-Path: <linux-kernel+bounces-876382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CD9C1B579
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CC9189A842
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C16301482;
	Wed, 29 Oct 2025 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kUZPjS1N"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D7D2C0F68
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748639; cv=none; b=Y0p/HpQ96MXoy1I5FQ9ZleCCFnwh4NzvR+wOShq2XXjtVFS2jPMKTgDZSH3oCklaEelLgfJZJA2gLLEM7hIhzYKHtn0aTULqj1sYNqqg3PCObYU4aqUKHN2LrIyxCYrp0R5hvrEZcKpH9GjvZxo2c4mV2eGc5lEguidu9ZI+UQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748639; c=relaxed/simple;
	bh=T760Ea0lymjEwsCgtjQB1XIujALcHIbvM/hl+VMkLp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XzPGs10Jmz0/aWkumLvp4JG9cNN1haCwCGCddpb7aQTEqmLWlHXaEypMRLtKgENmx977R3MhBiawdll/m0q1rfY8HKvTKRG94+3yWoYTQ7xzNLLuAJweuK/+FoeYteA61dGmHHXnjgeUAAzaVOPttHd5DaR+rTKOM56B5lFc2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kUZPjS1N; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 545E44E413CD;
	Wed, 29 Oct 2025 14:37:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 24486606E8;
	Wed, 29 Oct 2025 14:37:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DEF39102F24F9;
	Wed, 29 Oct 2025 15:37:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748635; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uO84+iwcTFjRfhgWoOtSFw3ivQXohz4k3QCtmL+xJPg=;
	b=kUZPjS1NIFn/Kbqv/GHeudV/Q6U1M+0aEfa35J0GCwsOq98hg5CfSz/xY7B563ERDmjMN6
	oj0UyNSUbWbWi9wtVVrSNZ82ptmjkp/lmQO4wOTLXVcDBh1yJ9+Nwk6bjm4Da2s1aYGnzV
	ieZiyESGZn6QeIvIPC4BHx92Cyc53w+cXlM9CpwNBEtxQNVuhrIY1pgpOJP9G0z6Zk0aoP
	SmngF9i95NPgolOEFZb2ZBeIn9cMoiy6gkzNGm88MIjMb5XgIOP4wpLeuO0XBUAOz+KFpD
	1OsVdrXayTGu8mlj5hjn8Pj9QbFqZBBLExbunCcdL2hW+cEG51PR5mlz+Pfu1g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:36:51 +0100
Subject: [PATCH RESEND v2 14/32] drm/vkms: Introduce config for plane color
 range
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-14-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10762;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=T760Ea0lymjEwsCgtjQB1XIujALcHIbvM/hl+VMkLp8=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ7h87AERN393FMuc8vP5AhM55ojRPFkhOQ1
 KAj6c/jrniJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImewAKCRAgrS7GWxAs
 4k0JD/9bfoccv/SFAegyNdMEioIkw0zAU2Nwb0M+r5tjr4XljaqGrXAYyomXlgsKoTiUMlYXKvC
 +M0eC9ETsCJtPqQz2/JsvrGOQblSI3wGUlmFjno+hTkKc51iQeuxWEYjctAtweSydlunYGnRdE0
 q/7MauZTstYmwRqu48zEheRp6hP4LcCTGRzC/5lxcubWzJf54sFPLrTBqbuu245L48WwP7eTt6q
 GacsksnwyPAAXAuyszegICMyqQUVygrxBmaH5raVBg/YIXnt6fl/XB2OarV/0eR5Eyoqutx+pQ4
 AHcVSEICFK/7Te0KPkr6qsOHKPvgmbXWkdfjWj0gnQOm5HE0ZClY9+PMA8q07F5nTKQWdnXQu/R
 g1MIJSez0JSN11rxseOInS9H+R0zAiItv0QN/iuKJs7zdKNElTm7Uy8TSFSkeFHUvo/9P7rDVNT
 b47q2J7RHt0Ebh02gzR+aM1mqMs3C8iflUaqKGTUCpBoFPe8OioZZ64+MGNyrPxXAqA2uDRck2b
 noTkfGLRRhCTRyBkKAkHN+X93Aoaf2GcCeiOTxNy1RcRQKcbQtiMg4HES2auchXVv8F+deqJFAe
 Ujvb6YPIZ6oE9Z4lVSoDyLPemZ56LW8KX+k+PrzR0WPO5h8w+eMJ7Q6Ylaz6DeaAHOCP3wuoRIf
 LDKLO1P0P+I3DYw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

VKMS driver supports all the color range on planes, but for testing it can
be useful to only advertise few of them. This new configuration interface
will allow configuring the color range per planes.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 44 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            | 39 ++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 35 +++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c             |  8 ++---
 4 files changed, 122 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index e9bc051188f9..d962fec8d3b3 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <drm/drm_color_mgmt.h>
 #include <drm/drm_mode.h>
 #include <kunit/test.h>
 
@@ -549,6 +550,7 @@ static void vkms_config_test_valid_plane_color_encoding(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
 	/* Valid, no supported or color encoding */
+	vkms_config_plane_set_supported_color_ranges(plane_cfg, 0);
 	vkms_config_plane_set_supported_color_encodings(plane_cfg, 0);
 	vkms_config_plane_set_default_color_encoding(plane_cfg, 0);
 	KUNIT_EXPECT_TRUE(test, vkms_config_valid_plane_color_encoding(config, plane_cfg));
@@ -563,6 +565,47 @@ static void vkms_config_test_valid_plane_color_encoding(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_valid_plane_color_range(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_plane *plane_cfg;
+
+	config = vkms_config_default_create(false, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	plane_cfg = get_first_plane(config);
+
+	/* Valid, all color range supported */
+	vkms_config_plane_set_supported_color_ranges(plane_cfg,
+						     BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+						     BIT(DRM_COLOR_YCBCR_FULL_RANGE));
+	vkms_config_plane_set_default_color_range(plane_cfg, DRM_COLOR_YCBCR_FULL_RANGE);
+	KUNIT_EXPECT_TRUE(test, vkms_config_valid_plane_color_range(config, plane_cfg));
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Invalid, default color range is not supported */
+	vkms_config_plane_set_supported_color_ranges(plane_cfg,
+						     BIT(DRM_COLOR_YCBCR_FULL_RANGE));
+	vkms_config_plane_set_default_color_range(plane_cfg, DRM_COLOR_YCBCR_LIMITED_RANGE);
+	KUNIT_EXPECT_FALSE(test, vkms_config_valid_plane_color_range(config, plane_cfg));
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Valid, no supported or color range */
+	vkms_config_plane_set_supported_color_encodings(plane_cfg, 0);
+	vkms_config_plane_set_supported_color_ranges(plane_cfg, 0);
+	vkms_config_plane_set_default_color_range(plane_cfg, 0);
+	KUNIT_EXPECT_TRUE(test, vkms_config_valid_plane_color_range(config, plane_cfg));
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid, if no supported color range, default is ignored */
+	vkms_config_plane_set_supported_color_ranges(plane_cfg, 0);
+	vkms_config_plane_set_default_color_range(plane_cfg, DRM_COLOR_YCBCR_LIMITED_RANGE);
+	KUNIT_EXPECT_TRUE(test, vkms_config_valid_plane_color_range(config, plane_cfg));
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
 static void vkms_config_test_valid_plane_possible_crtcs(struct kunit *test)
 {
 	struct vkms_config *config;
@@ -1087,6 +1130,7 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_valid_plane_type),
 	KUNIT_CASE(vkms_config_test_valid_plane_rotations),
 	KUNIT_CASE(vkms_config_test_valid_plane_color_encoding),
+	KUNIT_CASE(vkms_config_test_valid_plane_color_range),
 	KUNIT_CASE(vkms_config_test_valid_plane_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_invalid_crtc_number),
 	KUNIT_CASE(vkms_config_test_invalid_encoder_number),
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 6a3d52c1141d..823039fb4145 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -194,6 +194,25 @@ bool vkms_config_valid_plane_color_encoding(const struct vkms_config *config,
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_valid_plane_color_encoding);
 
+VISIBLE_IF_KUNIT
+bool vkms_config_valid_plane_color_range(const struct vkms_config *config,
+					 const struct vkms_config_plane *plane_cfg)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+
+	if (vkms_config_plane_get_supported_color_ranges(plane_cfg)) {
+		if ((BIT(vkms_config_plane_get_default_color_range(plane_cfg)) &
+		     vkms_config_plane_get_supported_color_ranges(plane_cfg)) !=
+		    BIT(vkms_config_plane_get_default_color_range(plane_cfg))) {
+			drm_info(dev, "Configured default color range is not supported by the plane\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_valid_plane_color_range);
+
 static bool valid_planes_for_crtc(const struct vkms_config *config,
 				  struct vkms_config_crtc *crtc_cfg)
 {
@@ -350,6 +369,7 @@ static bool valid_connector_possible_encoders(const struct vkms_config *config)
 
 bool vkms_config_is_valid(const struct vkms_config *config)
 {
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
 	struct vkms_config_crtc *crtc_cfg;
 	struct vkms_config_plane *plane_cfg;
 
@@ -359,6 +379,16 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 
 		if (!vkms_config_valid_plane_color_encoding(config, plane_cfg))
 			return false;
+
+		if (!vkms_config_valid_plane_color_range(config, plane_cfg))
+			return false;
+
+		if ((vkms_config_plane_get_supported_color_encodings(plane_cfg) == 0) !=
+		    (vkms_config_plane_get_supported_color_ranges(plane_cfg) == 0)) {
+			drm_info(dev,
+				 "Both supported color encoding and color range must be set, or none\n");
+			return false;
+		}
 	}
 
 	if (!valid_plane_number(config))
@@ -441,6 +471,12 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		seq_puts(m, "\n");
 		seq_printf(m, "\tdefault color encoding=%s\n",
 			   drm_get_color_encoding_name(vkms_config_plane_get_default_color_encoding(plane_cfg)));
+		seq_puts(m, "\tsupported color range=");
+		show_bitfield(m, vkms_config_plane_get_supported_color_ranges(plane_cfg),
+			      drm_get_color_range_name);
+		seq_puts(m, "\n");
+		seq_printf(m, "\tdefault color range=%s\n",
+			   drm_get_color_range_name(vkms_config_plane_get_default_color_range(plane_cfg)));
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -489,6 +525,9 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
 							BIT(DRM_COLOR_YCBCR_BT709) |
 							BIT(DRM_COLOR_YCBCR_BT2020));
 	vkms_config_plane_set_default_color_encoding(plane_cfg, DRM_COLOR_YCBCR_BT601);
+	vkms_config_plane_set_supported_color_ranges(plane_cfg, BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+								BIT(DRM_COLOR_YCBCR_FULL_RANGE));
+	vkms_config_plane_set_default_color_range(plane_cfg, DRM_COLOR_YCBCR_FULL_RANGE);
 
 	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index d740c9478256..d8648bf844d4 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -47,6 +47,8 @@ struct vkms_config {
  *         must be managed by other means.
  * @default_color_encoding: Default color encoding that should be used by this plane
  * @supported_color_encodings: Color encoding that this plane will support
+ * @default_color_range: Default color range that should be used by this plane
+ * @supported_color_ranges: Color range that this plane will support
  */
 struct vkms_config_plane {
 	struct list_head link;
@@ -58,6 +60,8 @@ struct vkms_config_plane {
 	unsigned int supported_rotations;
 	enum drm_color_encoding default_color_encoding;
 	unsigned int supported_color_encodings;
+	enum drm_color_range default_color_range;
+	unsigned int supported_color_ranges;
 	struct xarray possible_crtcs;
 
 	/* Internal usage */
@@ -413,6 +417,37 @@ bool vkms_config_valid_plane_color_encoding(const struct vkms_config *config,
 					    const struct vkms_config_plane *plane_cfg);
 #endif
 
+static inline enum drm_color_range
+vkms_config_plane_get_default_color_range(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->default_color_range;
+}
+
+static inline void
+vkms_config_plane_set_default_color_range(struct vkms_config_plane *plane_cfg,
+					  enum drm_color_range default_color_range)
+{
+	plane_cfg->default_color_range = default_color_range;
+}
+
+static inline unsigned int
+vkms_config_plane_get_supported_color_ranges(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->supported_color_ranges;
+}
+
+static inline void
+vkms_config_plane_set_supported_color_ranges(struct vkms_config_plane *plane_cfg,
+					     unsigned int supported_color_ranges)
+{
+	plane_cfg->supported_color_ranges = supported_color_ranges;
+}
+
+#if IS_ENABLED(CONFIG_KUNIT)
+bool vkms_config_valid_plane_color_range(const struct vkms_config *config,
+					 const struct vkms_config_plane *plane_cfg);
+#endif
+
 /**
  * vkms_config_plane_set_name() - Set the plane name
  * @plane_cfg: Plane to set the name to
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 9550831be51a..5dbc7c67de1d 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -238,13 +238,13 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 					   vkms_config_plane_get_default_rotation(config),
 					   vkms_config_plane_get_supported_rotations(config));
 
-	if (vkms_config_plane_get_supported_color_encodings(config) != 0)
+	if (vkms_config_plane_get_supported_color_encodings(config) != 0 &&
+	    vkms_config_plane_get_supported_color_ranges(config) != 0)
 		drm_plane_create_color_properties(&plane->base,
 						  vkms_config_plane_get_supported_color_encodings(config),
-						  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
-						  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
+						  vkms_config_plane_get_supported_color_ranges(config),
 						  vkms_config_plane_get_default_color_encoding(config),
-						  DRM_COLOR_YCBCR_FULL_RANGE);
+						  vkms_config_plane_get_default_color_range(config));
 
 	return plane;
 }

-- 
2.51.0


