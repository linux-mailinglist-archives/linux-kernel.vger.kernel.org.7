Return-Path: <linux-kernel+bounces-876199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F748C1AE24
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0D11AA1680
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4373D347FF5;
	Wed, 29 Oct 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YBDPP5vY"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9F345CD6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744653; cv=none; b=OoI04VM6QO9hRX9vQsl6bSrWlIA6wsihmutAtaOXePC2q3gwZv+WG7zlpJl7+ss4Iof0KTU11uOcMdNSHdfFPfT3+OwY1tiX7/IX6gU3lieZ0plVbwlz/n97zYwF7wYmT6szsdRaxtLoEaORvIHeRnsZfVTC1X1shlxcvKqmOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744653; c=relaxed/simple;
	bh=T760Ea0lymjEwsCgtjQB1XIujALcHIbvM/hl+VMkLp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3l8zYFTkbctL0SQuQeQR0J+6aM4t3uahVzJEqndxNR+AfUbQomgf0r7Ybk9ICxsZMvCpiQd9a6O5QbO5CvB5wh/yvxV+/C93ZrTIQ2hVFDDvSU1sPv0SowuOHY/c24lz/2Q67eFj38WXrym0zvsmoGSTVlWtalgAyvVWXTRa3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YBDPP5vY; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 04531C0DB02;
	Wed, 29 Oct 2025 13:30:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A2EC606E8;
	Wed, 29 Oct 2025 13:30:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAF76117F80A4;
	Wed, 29 Oct 2025 14:30:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744648; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uO84+iwcTFjRfhgWoOtSFw3ivQXohz4k3QCtmL+xJPg=;
	b=YBDPP5vY2sODvN7EMRmXzYs7Q3pJSWBVsQUKoCRRQb05X41w2iuOb8JsyqCTTnh30rEWku
	3n/ULTecByi8rnz7AWHqQfLpkXyzhVQx5G9L5FliDVH7RKs/7qBlcPbpPrb9shate7n+Fc
	NkTNs8KIbklUWNHt+KmcuFOsHEgjifxkthkqrp9TDOCCOqwCj0F+Bkv8bbeh6dXuDZEHsW
	duZL5bMxjCD+iB8O715DTY1gODee95/RxKRYCKEJ2ptimEcXo4gZ0iYiurCPVX6wEdIPyE
	2mBrV8QX+UA9yrGbGKvL6WYgmNZC6YfAzWBwf2XTkCNihEeg+gTRfS7vfqdV6w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:24 +0100
Subject: [PATCH v2 14/32] drm/vkms: Introduce config for plane color range
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-14-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10762;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=T760Ea0lymjEwsCgtjQB1XIujALcHIbvM/hl+VMkLp8=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbqNqbvI5hXSUbhpsBEQI/HmMzxecJP+tFRu
 FUZGvzjrWOJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6gAKCRAgrS7GWxAs
 4pHdEACEJD3Kudeg2vodF5yZ80A6+d5UtfR7/IHiqdpVYYg6k5wGrvPgPg0E2T7XoaZvXiKE650
 xxKlNmQPatF7PRO3JkomO9I4ht84AA0q8A6VbyxFrRZSPrkPRqeh1yYgp1pmBShLj9Wa/y7edRR
 vnk5xrieW597C73njVQIunu7AD5YeyYF34D7Ns4DJBwmdt2He8CjGPx1+5QJkC3emoKdkCRAnkC
 a3wOQTRdpl8EQ18v3a5CLcd1xM2MKOuhK4CRkYAHpvOGIeEefR9pR3TvQP0nRW5AlBQJlNOouHl
 5JlnxXOEufm7iSROG4wMkN0WlFJOno8adkLkTfSV8+6EAP3IFulUwWjfGnCxUcU5UOUxfTeRjvG
 wsJx+Edb4mA/FPzv7Z4lKnMYb66ouAsdOOhKI9oFJNBnOABwW4L8Ucg6va+iWN0yJ8J36/Ma9vQ
 5Fp3p1tEg+sG6L4WsANFLtdG9DI0h56cxUGuZd06PeNw91ncbI7LptzkGJfBvhRrE0uR/+ANtpW
 ADBjosoiljHKga8CmVoWsEPlxpelzdH9xsITb7VdDUkkwVwOuMJLh0HIbAAbMW1m7n52tyO7RnA
 qHo+5QCq9vzPSHmHMLhfPaUD9TYFV+02tvjAxHi8Jf75Gj4Yie35Dv/26gzY+R3wm3sTFRJXs2R
 WXBkNdAD9gpBcAA==
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


