Return-Path: <linux-kernel+bounces-876194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD2BC1B0B9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32B025A617A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2996F28B4F0;
	Wed, 29 Oct 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XS6RVZK/"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3AB33F376
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744644; cv=none; b=g4H1zNb1AhP+S4bpHiRitzp9zC+cWTNfMa9/OmHBGBDqYnSFeusfq1lY5ic9ka25kYzkl1+wjSRNr1Qr7cas8sX4+j1fX36t/69c+3cYllZ6BiiF8PrbE2eSBzz1mp2ag2aKVv4mPfznVmJ9j5gtdsBlti1Gzp6iXc1VBFoVoeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744644; c=relaxed/simple;
	bh=Dv+LTI2ccj4n/EV0vGVog8BjMGvNzDlPlpeBGi9mOcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tQVsMMfLzKN/Ka3q5s+dYY7ccSkv1CjCi18y1/gzkZ0MElBrE+2jOXzwkdJHhl5cfsU5tjGKrviaVRCnTa/AmOF63whUNYyQawju2D1SCTuBLce8HhwmUBQsB+CN633GdmLlWxi4jxA+H1ZGAFcNd5Nq9fgeojffzVOU+Nsfuzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XS6RVZK/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D91584E413CE;
	Wed, 29 Oct 2025 13:30:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B000D606E8;
	Wed, 29 Oct 2025 13:30:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88694117F809E;
	Wed, 29 Oct 2025 14:30:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744639; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iqMVLDuN4ai0MP2bHzX+4+j1XnBiI2VvRCwM5QgdY5E=;
	b=XS6RVZK/LSBiJ5sBzFx4KsvDZnS4+eTz0MxLnK7fX9QV/AH1itFPUAelUav5PlWThoUN3/
	jNj0RbGlkNyTK6ZR3iFniklPIhQq8paCtQq7adJeMoQC0o1juQnKDGoNUQe1Bhul0Hz0Ws
	rJf8rSEg0CvEPgRKRhRf24kFh0pxg8CPue90NGb8yTA7+a/Xfl898LTJzKIbP7dXgr0DNu
	toUaaMlpmUnjg+tnz85as+fgwI7EVawVIS6QDmmx9pVZvxTZNkwo5N86mFF/Z0/5I4Thcj
	yAanEn93lXkTDBnBHUERyPY5Zip/WeWLjoiFONhDe2blo71s/Vxz+BmQspNlwQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:19 +0100
Subject: [PATCH v2 09/32] drm/vkms: Introduce configfs for plane rotation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-vkms-all-config-v2-9-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4874;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Dv+LTI2ccj4n/EV0vGVog8BjMGvNzDlPlpeBGi9mOcY=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbqJHR/L52167D6TUK2ZsRO4iasVIoZq8uiL
 MfvBmrUT46JAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6gAKCRAgrS7GWxAs
 4nogD/9FHvKHFsm1qN5HYhzd09CAF/KdjohECQGuaA4pYS8yyrfTBFCqdXli1YAt+Vd7QCry46Q
 RiFreHKEsnCYC0kS1935pdI1GOKUEmSh9rBk9dCgmFrxC5uhO8yCe134XBkpkTVcK4LZAsWm41X
 gzzxKJK8qAtQIMOV5bP8U1aSqLiBZPBIE/5wClNGFUCU4RiNPe7Oab0BFKA787Ya8/eqt+Z7EE+
 L+Mm8XGvMzY75Hiq28ebozIxA8hwpMKrd//cxqG6WhEE8DR3ryaseUuFmGYG3J+yTL5s4B2Wloz
 tLq70/2r2DL85JsviMTek6VrEZWBA1KikvxVGRmJCz5+BmCLm/4Bidj8JhUv03K6zh6auY6K+HG
 SQwGG/o+3dtfbwqQO9HtWpCTG5HlZUpR+Ds+2RNZvM3Oi5ux6zdnKfPaZDmZuFmiN36NWSzSFh9
 ySyU2tojaaxHrH+MjmG2erRUxmlKYfnaKku1JHoCY6sfcaqBmJCKq/d+rFLF2blJar3CHHp6pIh
 6s0bdKP5vjAINuvThbKHiOPjd8LfgsiK4ohglTSAN3d5rBm/p5LFsEwsOHZs8LKPQZ7Ewzewh6d
 DBmILNBsRq7Pi1lQcIHG5nwibqwwE1PcJolkBsSDVCP/yLkaA6Nt50TuK+jyJfTHvu/3AHQrr4T
 BuIemq3HsYogYeQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

To allows the userspace to test many hardware configuration, introduce a
new interface to configure the available rotation per planes. VKMS
supports any rotation and reflection, so the userspace can choose any
combination.

The supported rotations are configured by writing a rotation bitmask to
the file `supported_rotations` and the default rotation is chosen by
writing a rotation bitmask to `default_rotation`.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst           |  7 ++-
 drivers/gpu/drm/vkms/vkms_configfs.c | 91 ++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 1fe6e420c963..eac1a942d6c4 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -87,11 +87,16 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
-Planes have 2 configurable attributes:
+Planes have 4 configurable attributes:
 
 - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
   exposed by the "type" property of a plane)
 - name: Name of the plane
+- possible_rotations: Available rotation for a plane, as a bitmask: 0x01 no rotation,
+  0x02 rotate 90°, 0x04 rotate 180°, 0x08 rotate 270°, 0x10 reflect x, 0x20 reflect y
+  (same values as those exposed by the "rotation" property of a plane)
+- default_rotation: Default rotation presented to the userspace, same values as
+  possible_rotations.
 
 Continue by creating one or more CRTCs::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index be6c3ba998b9..7cc8ba315ef0 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -352,12 +352,103 @@ static ssize_t plane_name_store(struct config_item *item, const char *page,
 	return (ssize_t)count;
 }
 
+static ssize_t plane_supported_rotations_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int plane_supported_rotations;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		plane_supported_rotations = vkms_config_plane_get_supported_rotations(plane->config);
+	}
+
+	return sprintf(page, "%u", plane_supported_rotations);
+}
+
+static ssize_t plane_supported_rotations_store(struct config_item *item,
+					       const char *page, size_t count)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	int ret, val = 0;
+
+	ret = kstrtouint(page, 0, &val);
+	if (ret)
+		return ret;
+
+	/* Should be a supported value */
+	if (val & ~(DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK))
+		return -EINVAL;
+	/* Should at least provide one rotation */
+	if (!(val & DRM_MODE_ROTATE_MASK))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		/* Ensures that the default rotation is included in supported rotation */
+		if (plane->dev->enabled)
+			return -EINVAL;
+
+		vkms_config_plane_set_supported_rotations(plane->config, val);
+	}
+
+	return count;
+}
+
+static ssize_t plane_default_rotation_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int plane_default_rotation;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		plane_default_rotation = vkms_config_plane_get_default_rotation(plane->config);
+	}
+
+	return sprintf(page, "%u", plane_default_rotation);
+}
+
+static ssize_t plane_default_rotation_store(struct config_item *item,
+					    const char *page, size_t count)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	int ret, val = 0;
+
+	ret = kstrtouint(page, 10, &val);
+	if (ret)
+		return ret;
+
+	/* Should be a supported value */
+	if (val & ~(DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK))
+		return -EINVAL;
+	/* Should at least provide one rotation */
+	if ((val & DRM_MODE_ROTATE_MASK) == 0)
+		return -EINVAL;
+	/* Should contains only one rotation */
+	if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		/* Ensures that the default rotation is included in supported rotation */
+		if (plane->dev->enabled)
+			return -EINVAL;
+
+		vkms_config_plane_set_default_rotation(plane->config, val);
+	}
+
+	return count;
+}
+
 CONFIGFS_ATTR(plane_, type);
 CONFIGFS_ATTR(plane_, name);
+CONFIGFS_ATTR(plane_, supported_rotations);
+CONFIGFS_ATTR(plane_, default_rotation);
 
 static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_type,
 	&plane_attr_name,
+	&plane_attr_supported_rotations,
+	&plane_attr_default_rotation,
 	NULL,
 };
 

-- 
2.51.0


