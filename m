Return-Path: <linux-kernel+bounces-858932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F05CBEC498
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96DF13540C4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C64422FE15;
	Sat, 18 Oct 2025 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kmKPl6GO"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B4922E004
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752932; cv=none; b=JO+VvIKq4CMZeRmFXK2V4ybkJlMbSX/oIHm5HyKGZzEE6nLgCXOWquHmuHNc63827EWQVZXXw/36B+13ERmbHg3+LEUOeze9qxyGVBHvOLX/x9NPb0uwSJeGKDX90GHYj6VdwptfG5DMfMo5y4P3//8nfG/nyqJ5t/4VwK/qerk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752932; c=relaxed/simple;
	bh=x5UcdtPSeHv8EtJLCVPWtV+JLqf6qMO+6bUS9mui3fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L8ZVzRL3PFsPu4sM7fZU4l7cTInHoohNeH1NdqV7+58k7utOZKlwXol6SexvykoIhSg1quNCPJp4bKnC8irDlXbReNbwV5SlLn/iKVZD64iQZ8hn7h59XcJhleeXvIZ2NAAO2b3jhLbsJF9QpTlHziofYmhBYPE8fY77lapJjN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kmKPl6GO; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 87A4CC035A7;
	Sat, 18 Oct 2025 02:01:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DCF4A60701;
	Sat, 18 Oct 2025 02:02:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA8A8102F236C;
	Sat, 18 Oct 2025 04:02:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760752927; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pJyOUxsJdvV2xhwBg531OEd5ACjsjyJphAUTsaQMRVg=;
	b=kmKPl6GO27HANwd9eQD3Eg9BzNVt86qcxYZUItjYx09hqZLcKX+xNrOMbsRff1awt3rQAj
	xbtUL+sJP3+wCEpcQma9M3I/pXoNe/koRbqXyyCfIa5Zz4CDvXgJ5FjdUj7gQOzOgEuqjM
	JvFJd0jmgwqg8MXLZU7KvivJekcc4bS7Oska+wUZ57eUvsdkcG1It9Lcxh5hHcVZ4zPaeB
	AjTZiluRVP8zM1YBQQk1g01Ou9xru8T5YaQZe/y9wRmCeW/1R47Xx50KbVaTplK9V3slG1
	fDw4Iahv3QWCphM6ACUbf3EnMrlPUG0AH2cBjN7bX5a7pQrOGZgc/DyfFm2Bfg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 18 Oct 2025 04:01:09 +0200
Subject: [PATCH 09/22] drm/vkms: Introduce config for plane format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-vkms-all-config-v1-9-a7760755d92d@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8463;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=x5UcdtPSeHv8EtJLCVPWtV+JLqf6qMO+6bUS9mui3fo=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBo8vT+7l0GfVXF6pn9pHryMPiulJanIItnFuOE6
 lyNG7wd2q+JAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaPL0/gAKCRAgrS7GWxAs
 4lOXD/41He5uDPKRAmSQvYtlzDvsul4GV+SQ9rEIIuWF9y57MgBa9fIgpSC4+NRs3lg5pWRCI4Y
 yMy3MDudup45Glz2O4zHGSW+FmtjV8d30Agl/nFTNOVOyh2ZjMV9ltk+vzd3rd9qOt09VDFx11B
 wITIohPzANtV49prJbIsXmZLPM6tLeoPYXBCWiaFzVwzEyw6Aj74RBDNDzE2hXX1MkYFE+/jvvo
 /LoTzqTDsxxy+BPKlxsWVFt1kWox0Ot9Irur2xRScH/nlnXP4L9hB/YtHJwxsGlsTKWsTdNtaoY
 Ufw73BHwXYakyeUM76sGEuWlsAfi518xrxz/8Gy9hmHpERbLLPQv4Q+3C/oqAbfJ6REXcJGiSeV
 j2zA5vqI0SPmfnYSaopTr+4Hb2p3MmInr68Hk1Vm5BFgjUVX5s8ACVQLkB/gVQ/n6NfV4QhsmtE
 XvgDTDzkKfpgKdHmB+j3iQ2YXM5c62FO8aAkbxpr/q0V4QTUoHi5lEvV/xuL+C94DRx1y9J4Kdi
 TfqsENWNKhFfFAWw9LhQBsbxoBs9th6UQy7dm3Bg+nlgfPw5YsNR2L1dXfXgVMcEkHy6UvyRwmH
 xteXj3gpA8b4Y09hHtRlcRi6vYV7pIh+vwMNcjGVKlDubBu5v7jIs6pYEmCOjzpFwNPiHNBtOtU
 76Rli0mhCJfhOfg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

VKMS driver supports all the pixel formats for planes, but for testing it
can be useful to only advertise few of them. This new configuration
interface will allow configuring the pixel format per planes.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 99 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h | 49 +++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c  | 39 +--------------
 3 files changed, 150 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 8f00ca21ed6e..0b975a0d47aa 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -8,6 +8,42 @@
 
 #include "vkms_config.h"
 
+static const u32 vkms_supported_plane_formats[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_XRGB16161616,
+	DRM_FORMAT_XBGR16161616,
+	DRM_FORMAT_ARGB16161616,
+	DRM_FORMAT_ABGR16161616,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV24,
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_NV61,
+	DRM_FORMAT_NV42,
+	DRM_FORMAT_YUV420,
+	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YUV444,
+	DRM_FORMAT_YVU420,
+	DRM_FORMAT_YVU422,
+	DRM_FORMAT_YVU444,
+	DRM_FORMAT_P010,
+	DRM_FORMAT_P012,
+	DRM_FORMAT_P016,
+	DRM_FORMAT_R1,
+	DRM_FORMAT_R2,
+	DRM_FORMAT_R4,
+	DRM_FORMAT_R8,
+};
+
 struct vkms_config *vkms_config_create(const char *dev_name)
 {
 	struct vkms_config *config;
@@ -435,6 +471,11 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
 	if (!plane_cfg)
 		return ERR_PTR(-ENOMEM);
 
+	if (vkms_config_plane_add_all_formats(plane_cfg)) {
+		kfree(plane_cfg);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	plane_cfg->config = config;
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
 	vkms_config_plane_set_name(plane_cfg, NULL);
@@ -563,6 +604,64 @@ static struct vkms_config_plane *vkms_config_crtc_get_plane(const struct vkms_co
 	return NULL;
 }
 
+int __must_check vkms_config_plane_add_all_formats(struct vkms_config_plane *plane_cfg)
+{
+	u32 *ret = krealloc_array(plane_cfg->supported_formats,
+				  ARRAY_SIZE(vkms_supported_plane_formats),
+				  sizeof(uint32_t), GFP_KERNEL);
+	if (!ret)
+		return -ENOMEM;
+	plane_cfg->supported_formats = ret;
+
+	memcpy(plane_cfg->supported_formats, vkms_supported_plane_formats,
+	       sizeof(vkms_supported_plane_formats));
+	plane_cfg->supported_formats_count = ARRAY_SIZE(vkms_supported_plane_formats);
+	return 0;
+}
+
+int __must_check vkms_config_plane_add_format(struct vkms_config_plane *plane_cfg, u32 drm_format)
+{
+	bool found = false;
+
+	for (int i = 0; i < ARRAY_SIZE(vkms_supported_plane_formats); i++) {
+		if (vkms_supported_plane_formats[i] == drm_format)
+			found = true;
+	}
+
+	if (!found)
+		return -EINVAL;
+	for (unsigned int i = 0; i < plane_cfg->supported_formats_count; i++) {
+		if (plane_cfg->supported_formats[i] == drm_format)
+			return 0;
+	}
+	u32 *new_ptr = krealloc_array(plane_cfg->supported_formats,
+				      plane_cfg->supported_formats_count + 1,
+				      sizeof(*plane_cfg->supported_formats), GFP_KERNEL);
+	if (!new_ptr)
+		return -ENOMEM;
+
+	plane_cfg->supported_formats = new_ptr;
+	plane_cfg->supported_formats[plane_cfg->supported_formats_count] = drm_format;
+	plane_cfg->supported_formats_count++;
+
+	return 0;
+}
+
+void vkms_config_plane_remove_all_formats(struct vkms_config_plane *plane_cfg)
+{
+	plane_cfg->supported_formats_count = 0;
+}
+
+void vkms_config_plane_remove_format(struct vkms_config_plane *plane_cfg, u32 drm_format)
+{
+	for (unsigned int i = 0; i < plane_cfg->supported_formats_count; i++) {
+		if (plane_cfg->supported_formats[i] == drm_format) {
+			plane_cfg->supported_formats[i] = plane_cfg->supported_formats[plane_cfg->supported_formats_count - 1];
+			plane_cfg->supported_formats_count--;
+		}
+	}
+}
+
 struct vkms_config_plane *vkms_config_crtc_primary_plane(const struct vkms_config *config,
 							 struct vkms_config_crtc *crtc_cfg)
 {
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 8127e12f00dc..0b7067508e5f 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -62,6 +62,8 @@ struct vkms_config_plane {
 	unsigned int supported_color_encoding;
 	enum drm_color_range default_color_range;
 	unsigned int supported_color_range;
+	u32 *supported_formats;
+	unsigned int supported_formats_count;
 	struct xarray possible_crtcs;
 
 	/* Internal usage */
@@ -404,6 +406,53 @@ vkms_config_plane_set_supported_color_range(struct vkms_config_plane *plane_cfg,
 	plane_cfg->supported_color_range = supported_color_range;
 }
 
+static inline u32 *
+vkms_config_plane_get_supported_formats(struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->supported_formats;
+}
+
+static inline unsigned int
+vkms_config_plane_get_supported_formats_count(struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->supported_formats_count;
+}
+
+/** vkms_config_plane_add_format - Add a format to the list of supported format of a plane
+ *
+ * The passed drm_format can already be present in the list. This may fail if the allocation of a
+ * bigger array fails.
+ *
+ * @plane_cfg: Plane to add the format to
+ * @drm_format: Format to add to this plane
+ *
+ * Returns: 0 on success, -ENOMEM if array allocation fails, -EINVAL if the format is not supported
+ * by VKMS
+ */
+int __must_check vkms_config_plane_add_format(struct vkms_config_plane *plane_cfg, u32 drm_format);
+
+/**
+ * vkms_config_plane_add_all_formats - Helper to quickly add all the supported formats
+ * @plane_cfg: Plane to add the formats to
+ *
+ * Returns: 0 on success, -ENOMEM if array allocation fails, -EINVAL if the format is not supported
+ * by VKMS
+ */
+int __must_check vkms_config_plane_add_all_formats(struct vkms_config_plane *plane_cfg);
+
+/**
+ * vkms_config_plane_remove_format - Remove a specific format from a plane
+ * @plane_cfg: Plane to remove the format to
+ * @drm_format: Format to remove
+ */
+void vkms_config_plane_remove_format(struct vkms_config_plane *plane_cfg, u32 drm_format);
+
+/**
+ * vkms_config_plane_remove_all_formats - Remove all formast from a plane
+ * @plane_cfg: Plane to remove the formats from
+ */
+void vkms_config_plane_remove_all_formats(struct vkms_config_plane *plane_cfg);
+
 /**
  * vkms_config_plane_set_name() - Set the plane name
  * @plane_cfg: Plane to set the name to
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index ab719da2ca0b..0414865915d8 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -14,42 +14,6 @@
 #include "vkms_formats.h"
 #include "vkms_config.h"
 
-static const u32 vkms_formats[] = {
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_ABGR8888,
-	DRM_FORMAT_BGRA8888,
-	DRM_FORMAT_RGBA8888,
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_RGB888,
-	DRM_FORMAT_BGR888,
-	DRM_FORMAT_XRGB16161616,
-	DRM_FORMAT_XBGR16161616,
-	DRM_FORMAT_ARGB16161616,
-	DRM_FORMAT_ABGR16161616,
-	DRM_FORMAT_RGB565,
-	DRM_FORMAT_BGR565,
-	DRM_FORMAT_NV12,
-	DRM_FORMAT_NV16,
-	DRM_FORMAT_NV24,
-	DRM_FORMAT_NV21,
-	DRM_FORMAT_NV61,
-	DRM_FORMAT_NV42,
-	DRM_FORMAT_YUV420,
-	DRM_FORMAT_YUV422,
-	DRM_FORMAT_YUV444,
-	DRM_FORMAT_YVU420,
-	DRM_FORMAT_YVU422,
-	DRM_FORMAT_YVU444,
-	DRM_FORMAT_P010,
-	DRM_FORMAT_P012,
-	DRM_FORMAT_P016,
-	DRM_FORMAT_R1,
-	DRM_FORMAT_R2,
-	DRM_FORMAT_R4,
-	DRM_FORMAT_R8,
-};
-
 static struct drm_plane_state *
 vkms_plane_duplicate_state(struct drm_plane *plane)
 {
@@ -226,7 +190,8 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 
 	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
 					   &vkms_plane_funcs,
-					   vkms_formats, ARRAY_SIZE(vkms_formats),
+					   vkms_config_plane_get_supported_formats(config),
+					   vkms_config_plane_get_supported_formats_count(config),
 					   NULL, vkms_config_plane_get_type(config),
 					   vkms_config_plane_get_name(config));
 	if (IS_ERR(plane))

-- 
2.51.0


