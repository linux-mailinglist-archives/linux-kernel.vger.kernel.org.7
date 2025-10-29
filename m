Return-Path: <linux-kernel+bounces-876387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3235C1B4C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F1B3348944
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BCD33B6EC;
	Wed, 29 Oct 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sdg3tShF"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7602D12EB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748648; cv=none; b=SEW2XyqFuuOwcZ6P76rspnESiJyRMCPRK/P58o45JxMhogr512xMk4KdKI049+5o85ksVIqaD0bnzyQra3QF5ixODshi/V8lQqeGOW6YUxsBP0+6Xqs7/wyoRce2hhD8+nHUSfr1wwhpu1khlcBI8s+5n26oHgYCmKkV5wyM7aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748648; c=relaxed/simple;
	bh=mKwvYcW2Hz25Zl72QZxI3VVT1IcCPbam0gHPfRqJ4iY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VoK6cpEJcpNni2378r46Gfa6yn1P7ppeo9pjeWbjsSUvYukC9UF/fwqRIflBhlNWL31//KOIp/Y9EV/QV0Gv/pmE1HDx3IzkFtBpbfRrmuSPsDeoregbw8GvkDIqONiluaT2di144BQ+D+wBJr+EBeQ37AJErt5QRYLZOGlQYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sdg3tShF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 784F91A174B;
	Wed, 29 Oct 2025 14:37:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E754606E8;
	Wed, 29 Oct 2025 14:37:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EAC7117F81B1;
	Wed, 29 Oct 2025 15:37:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748643; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZDoaOquusQDSLp7HQRJOshugz0KBDod0mdS1BtA/zy4=;
	b=Sdg3tShFUtRDpgGUgJUIzMqE6tN8dOQ7n3uKGhlHX629agac37j1taB6cA3T/Np2phMpF7
	U3gsIO8RIucHBG9Cr/Y/grdkpUl7/5QCxP1ZTBAnqGyHPoYSSV+eyww7HX+Fg2NbPeaZVZ
	BLipYiGnlMrLiIMODxSbXx12Gttc+d9m/prr+Lm5Oh7HNIRDd8pDDttZyS8Okv1lHQMp/k
	TUP1Y4WusPutnvvyIrMjpPngI50s+qjS79ImOOGcZbZMRyEbPNi033kLT3201nBRssT4Vx
	POB+pjIQ65w1/qQatYQS68UkxXd3r7xe+8i8hTOEXW27TAKobPEdqMiq40xHmA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:36:56 +0100
Subject: [PATCH RESEND v2 19/32] drm/vkms: Introduce config for plane zpos
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-19-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15646;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=mKwvYcW2Hz25Zl72QZxI3VVT1IcCPbam0gHPfRqJ4iY=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ8+g54u1JWgPgjDQnaIomrRkzuQAS3NxDKP
 z0cNIWQij6JAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImfAAKCRAgrS7GWxAs
 4nkVEACVXkTz7VusjKMBFOF90P2k43qMsgYRScr8M6vzoF+BmaEUMb732lFM7qSu6pX9GnUEb0U
 Phb4iLHkkSr9/SZUT4M0icFHeEJxyXplTxNkvYjKqit890y+31V7SQhucil6u5uzH9YthgREMcv
 dAc1nA+5nvSTJfptjSyhDiOyilOui6YtBkSl222N4saNTwfgonK0ojHcXQmVudMWpURqnZUdVt1
 +0V0FppmrMCfb1/kD4jJPPo2jAdla6IfMTz3qM3mynYuadpEKAHRg3n/tQwBW3nMXe1JOKUhayH
 1IRRSYZZmZNDuMGOktR7Rx26RMLzxnPHK7coqgAAHaTdMIKyAy2OiUnSAe54wqT/UYa/us0JWfT
 1Qi7+STzjkgoZ/qtbRFDNms0NbeLLvJBZgrknTyzJbdG7F8FPEefwu4j5yWXwtSHynC0PR8Yl+c
 C4mH/F00ZN0t8qI5NpjvUPm5yXLnxuezIYgn2gSHFYftMbn3uBWBS2h7JRfnFFN3ikmkv1drQ/Y
 MROqy042H3i+NDfBTY64IHUQ9PX+frVL869CQV4SRLxTUZCkecLzIbGapkvkzPvkDJ3srI+m62d
 oyuKnhmOKZ03xhiM4ru8o18MI+mfS6endmUwfVpHmAkG1bRIuFGefnHdftG8Z7fF+mhOGnvkqj5
 0i670bzAnCTTy8A==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

VKMS can render plane in any order. Introduce the appropriate
configuration.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  92 ++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            |  47 ++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 147 ++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c             |  11 ++
 4 files changed, 297 insertions(+)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index d962fec8d3b3..518e68c17122 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -188,6 +188,9 @@ static void vkms_config_test_default_config(struct kunit *test)
 		KUNIT_EXPECT_EQ(test,
 				vkms_config_plane_get_default_color_encoding(plane_cfg),
 				DRM_COLOR_YCBCR_BT601);
+		KUNIT_EXPECT_EQ(test, vkms_config_plane_get_zpos_enabled(plane_cfg), false);
+		// No need to test the other zpos configurations as they are discarded if
+		// the zpos property is not created.
 	}
 
 	/* Encoders */
@@ -606,6 +609,94 @@ static void vkms_config_test_valid_plane_color_range(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_valid_plane_zpos(struct kunit *test)
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
+	plane_cfg = get_first_plane(config);
+
+	/* Valid, zpos disabled */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, false);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, false);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 0);
+	vkms_config_plane_set_zpos_min(plane_cfg, 0);
+	vkms_config_plane_set_zpos_max(plane_cfg, 0);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid, zpos disabled, min/max are ignored */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, false);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, false);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 8);
+	vkms_config_plane_set_zpos_min(plane_cfg, 3);
+	vkms_config_plane_set_zpos_max(plane_cfg, 2);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid, zpos enabled but initial value is out of range */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, true);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, false);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 1);
+	vkms_config_plane_set_zpos_min(plane_cfg, 0);
+	vkms_config_plane_set_zpos_max(plane_cfg, 0);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid, zpos enabled with valid initial value */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, true);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, false);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 0);
+	vkms_config_plane_set_zpos_min(plane_cfg, 0);
+	vkms_config_plane_set_zpos_max(plane_cfg, 0);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Invalid, zpos enabled with min > max */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, true);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, true);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 0);
+	vkms_config_plane_set_zpos_min(plane_cfg, 1);
+	vkms_config_plane_set_zpos_max(plane_cfg, 0);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Valid, zpos enabled with min <= max */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, true);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, true);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 0);
+	vkms_config_plane_set_zpos_min(plane_cfg, 0);
+	vkms_config_plane_set_zpos_max(plane_cfg, 1);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Invalid, zpos enabled with initial < min */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, true);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, true);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 0);
+	vkms_config_plane_set_zpos_min(plane_cfg, 1);
+	vkms_config_plane_set_zpos_max(plane_cfg, 2);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Invalid, zpos enabled with initial > max */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, true);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, true);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 3);
+	vkms_config_plane_set_zpos_min(plane_cfg, 1);
+	vkms_config_plane_set_zpos_max(plane_cfg, 2);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Valid, zpos enabled with initial between min and max */
+	vkms_config_plane_set_zpos_enabled(plane_cfg, true);
+	vkms_config_plane_set_zpos_mutable(plane_cfg, true);
+	vkms_config_plane_set_zpos_initial(plane_cfg, 1);
+	vkms_config_plane_set_zpos_min(plane_cfg, 0);
+	vkms_config_plane_set_zpos_max(plane_cfg, 2);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
 static void vkms_config_test_valid_plane_possible_crtcs(struct kunit *test)
 {
 	struct vkms_config *config;
@@ -1131,6 +1222,7 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_valid_plane_rotations),
 	KUNIT_CASE(vkms_config_test_valid_plane_color_encoding),
 	KUNIT_CASE(vkms_config_test_valid_plane_color_range),
+	KUNIT_CASE(vkms_config_test_valid_plane_zpos),
 	KUNIT_CASE(vkms_config_test_valid_plane_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_invalid_crtc_number),
 	KUNIT_CASE(vkms_config_test_invalid_encoder_number),
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index a3fb80451b30..801019cf04c1 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -90,6 +90,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 	if (IS_ERR(plane_cfg))
 		goto err_alloc;
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
+	vkms_config_plane_set_zpos_enabled(plane_cfg, false);
 
 	crtc_cfg = vkms_config_create_crtc(config);
 	if (IS_ERR(crtc_cfg))
@@ -107,6 +108,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 
 			vkms_config_plane_set_type(plane_cfg,
 						   DRM_PLANE_TYPE_OVERLAY);
+			vkms_config_plane_set_zpos_enabled(plane_cfg, false);
 
 			if (vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg))
 				goto err_alloc;
@@ -119,6 +121,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 			goto err_alloc;
 
 		vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_CURSOR);
+		vkms_config_plane_set_zpos_enabled(plane_cfg, false);
 
 		if (vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg))
 			goto err_alloc;
@@ -249,6 +252,37 @@ bool vkms_config_valid_plane_color_range(const struct vkms_config *config,
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_valid_plane_color_range);
 
+VISIBLE_IF_KUNIT
+bool vkms_config_valid_plane_zpos(const struct vkms_config *config,
+				  const struct vkms_config_plane *plane_cfg)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+
+	if (!vkms_config_plane_get_zpos_enabled(plane_cfg) ||
+	    !vkms_config_plane_get_zpos_mutable(plane_cfg))
+		return true;
+
+	if (vkms_config_plane_get_zpos_initial(plane_cfg) >
+	    vkms_config_plane_get_zpos_max(plane_cfg)) {
+		drm_info(dev, "Configured initial zpos value bigger than zpos max\n");
+		return false;
+	}
+
+	if (vkms_config_plane_get_zpos_max(plane_cfg) <
+	    vkms_config_plane_get_zpos_min(plane_cfg)) {
+		drm_info(dev, "Configured zpos max value smaller than zpos min\n");
+		return false;
+	}
+
+	if (vkms_config_plane_get_zpos_initial(plane_cfg) <
+	    vkms_config_plane_get_zpos_min(plane_cfg)) {
+		drm_info(dev, "Configured initial zpos value smaller than zpos min\n");
+		return false;
+	}
+
+	return true;
+}
+
 static bool valid_planes_for_crtc(const struct vkms_config *config,
 				  struct vkms_config_crtc *crtc_cfg)
 {
@@ -425,6 +459,9 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 				 "Both supported color encoding and color range must be set, or none\n");
 			return false;
 		}
+
+		if (!vkms_config_valid_plane_zpos(config, plane_cfg))
+			return false;
 	}
 
 	if (!valid_plane_number(config))
@@ -526,6 +563,16 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		show_formats(m, vkms_config_plane_get_supported_formats(plane_cfg),
 			     vkms_config_plane_get_supported_formats_count(plane_cfg));
 		seq_puts(m, "\n");
+		seq_printf(m, "\tzpos_enabled=%s\n",
+			   str_true_false(vkms_config_plane_get_zpos_enabled(plane_cfg)));
+		seq_printf(m, "\tzpos_mutable=%s\n",
+			   str_true_false(vkms_config_plane_get_zpos_mutable(plane_cfg)));
+		seq_printf(m, "\tzpos_min=%d\n",
+			   vkms_config_plane_get_zpos_min(plane_cfg));
+		seq_printf(m, "\tzpos_initial=%d\n",
+			   vkms_config_plane_get_zpos_initial(plane_cfg));
+		seq_printf(m, "\tzpos_max=%d\n",
+			   vkms_config_plane_get_zpos_max(plane_cfg));
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 2d9e35b7caad..baed036a07cd 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -51,6 +51,11 @@ struct vkms_config {
  * @supported_color_ranges: Color range that this plane will support
  * @supported_formats: List of supported formats
  * @supported_formats_count: Length of @supported_formats
+ * @zpos_enabled: Enable or disable the zpos property
+ * @zpos_mutable: Make the zpos property mutable or not (ignored if @zpos_enabled is false)
+ * @zpos_initial: Initial value for zpos property (ignored if @zpos_enabled is false)
+ * @zpos_min: Minimal value for zpos property (ignored if @zpos_enabled is false)
+ * @zpos_max: Maximal value for zpos property (ignored if @zpos_enabled is false)
  */
 struct vkms_config_plane {
 	struct list_head link;
@@ -67,6 +72,11 @@ struct vkms_config_plane {
 	u32 *supported_formats;
 	unsigned int supported_formats_count;
 	struct xarray possible_crtcs;
+	bool zpos_enabled;
+	bool zpos_mutable;
+	unsigned int zpos_initial;
+	unsigned int zpos_min;
+	unsigned int zpos_max;
 
 	/* Internal usage */
 	struct vkms_plane *plane;
@@ -523,6 +533,143 @@ vkms_config_plane_get_name(const struct vkms_config_plane *plane_cfg)
 	return plane_cfg->name;
 }
 
+/**
+ * vkms_config_plane_set_zpos_enabled() - Enable or disable zpos property for a plane
+ * @plane_cfg: Plane configuration to modify
+ * @zpos_enabled: Whether to enable the zpos property
+ */
+static inline
+void vkms_config_plane_set_zpos_enabled(struct vkms_config_plane *plane_cfg,
+					bool zpos_enabled)
+{
+	plane_cfg->zpos_enabled = zpos_enabled;
+}
+
+/**
+ * vkms_config_plane_set_zpos_mutable() - Set whether zpos property is mutable
+ * @plane_cfg: Plane configuration to modify
+ * @zpos_mutable: Whether the zpos property should be mutable
+ */
+static inline
+void vkms_config_plane_set_zpos_mutable(struct vkms_config_plane *plane_cfg,
+					bool zpos_mutable)
+{
+	plane_cfg->zpos_mutable = zpos_mutable;
+}
+
+/**
+ * vkms_config_plane_set_zpos_initial() - Set the initial zpos value
+ * @plane_cfg: Plane configuration to modify
+ * @zpos_initial: Initial zpos value
+ */
+static inline
+void vkms_config_plane_set_zpos_initial(struct vkms_config_plane *plane_cfg,
+					unsigned int zpos_initial)
+{
+	plane_cfg->zpos_initial = zpos_initial;
+}
+
+/**
+ * vkms_config_plane_set_zpos_min() - Set the minimum zpos value
+ * @plane_cfg: Plane configuration to modify
+ * @zpos_min: Minimum zpos value
+ */
+static inline
+void vkms_config_plane_set_zpos_min(struct vkms_config_plane *plane_cfg,
+				    unsigned int zpos_min)
+{
+	plane_cfg->zpos_min = zpos_min;
+}
+
+/**
+ * vkms_config_plane_set_zpos_max() - Set the maximum zpos value
+ * @plane_cfg: Plane configuration to modify
+ * @zpos_max: Maximum zpos value
+ *
+ * Sets the maximum allowed value for the zpos property. This setting is
+ * ignored if zpos is disabled.
+ */
+static inline
+void vkms_config_plane_set_zpos_max(struct vkms_config_plane *plane_cfg,
+				    unsigned int zpos_max)
+{
+	plane_cfg->zpos_max = zpos_max;
+}
+
+/**
+ * vkms_config_plane_get_zpos_enabled() - Check if zpos property is enabled
+ * @plane_cfg: Plane configuration to check
+ *
+ * Returns:
+ * True if the zpos property is enabled for this plane, false otherwise.
+ */
+static inline
+bool vkms_config_plane_get_zpos_enabled(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->zpos_enabled;
+}
+
+/**
+ * vkms_config_plane_get_zpos_mutable() - Check if zpos property is mutable
+ * @plane_cfg: Plane configuration to check
+ *
+ * Returns:
+ * True if the zpos property is mutable for this plane, false otherwise.
+ * Returns false if zpos is disabled.
+ */
+static inline
+bool vkms_config_plane_get_zpos_mutable(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->zpos_mutable;
+}
+
+/**
+ * vkms_config_plane_get_zpos_initial() - Get the initial zpos value
+ * @plane_cfg: Plane configuration to check
+ *
+ * Returns:
+ * The initial zpos value for this plane. The return value is undefined if
+ * zpos is disabled.
+ */
+static inline
+unsigned int vkms_config_plane_get_zpos_initial(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->zpos_initial;
+}
+
+/**
+ * vkms_config_plane_get_zpos_min() - Get the minimum zpos value
+ * @plane_cfg: Plane configuration to check
+ *
+ * Returns:
+ * The minimum allowed zpos value for this plane. The return value is undefined
+ * if zpos is disabled.
+ */
+static inline
+unsigned int vkms_config_plane_get_zpos_min(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->zpos_min;
+}
+
+/**
+ * vkms_config_plane_get_zpos_max() - Get the maximum zpos value
+ * @plane_cfg: Plane configuration to check
+ *
+ * Returns:
+ * The maximum allowed zpos value for this plane. The return value is undefined
+ * if zpos is disabled.
+ */
+static inline
+unsigned int vkms_config_plane_get_zpos_max(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->zpos_max;
+}
+
+#if IS_ENABLED(CONFIG_KUNIT)
+bool vkms_config_valid_plane_zpos(const struct vkms_config *config,
+				  const struct vkms_config_plane *plane_cfg);
+#endif
+
 /**
  * vkms_config_plane_attach_crtc - Attach a plane to a CRTC
  * @plane_cfg: Plane to attach
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 945abbbeac99..11a6b7bc74a7 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -211,5 +211,16 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 						  vkms_config_plane_get_default_color_encoding(config),
 						  vkms_config_plane_get_default_color_range(config));
 
+	if (vkms_config_plane_get_zpos_enabled(config)) {
+		if (vkms_config_plane_get_zpos_mutable(config))
+			drm_plane_create_zpos_property(&plane->base,
+						       vkms_config_plane_get_zpos_initial(config),
+						       vkms_config_plane_get_zpos_min(config),
+						       vkms_config_plane_get_zpos_max(config));
+		else
+			drm_plane_create_zpos_immutable_property(&plane->base,
+								 vkms_config_plane_get_zpos_initial(config));
+	}
+
 	return plane;
 }

-- 
2.51.0


