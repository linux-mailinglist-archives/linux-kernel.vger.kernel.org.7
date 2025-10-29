Return-Path: <linux-kernel+bounces-876192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5E4C1AF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10BD6240B9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8230733CEB2;
	Wed, 29 Oct 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H6kGmU6x"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6E33B6E6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744640; cv=none; b=sJFq9DjAOP7srPU6ePFNep1X4tDoMNXaFUktpW6K5/27/Q/9nvoqEOqls9w3ovZpiCt7xBycTBoLGElDPz7R4hRmlFm8bNVZrwxzxPeKp+j7YrgpUuE4dynoi80NB/G+SgktRHdFD+STvcwqDH/hlFbgw8KOrxoAw4hU6KXGll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744640; c=relaxed/simple;
	bh=Pl8/wLHil1+4yaisV9T8jn/VjcUTIXsuX+80D3wrKXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLIf4kaxU9FEOsqUEpVpQuBjmeOcGkvCd7SDw+jKzbZmYcpHqkypZGvxK5oFCINoXsUMbGEdc1NESPWqx8BrrwqdeAF/v2KdscXpDHam5O3BdeQFNkQEDhgKDsLziPOC387Bq5TV6KJc8D7jMfRDiUfhkJacrJE7cTJ/eLxWAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H6kGmU6x; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 601191A1744;
	Wed, 29 Oct 2025 13:30:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 30167606E8;
	Wed, 29 Oct 2025 13:30:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 172A2117F809D;
	Wed, 29 Oct 2025 14:30:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744636; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gZH4XqHEnkgG+WiGf4L3QVJCg6jApM4gvYwyfSScQxU=;
	b=H6kGmU6xvde7Lsv/zGgksKMvtDaWaqZa+dLq1SUu/J2AqnTsaPFhp4B4nRhDygTWZctegz
	vBoaEFw+0m7Fl4n/jSXy87YMb9Mqba0n/kPaNWb01GY1gGtKzUprsyJ/05Q55eg3dffzcD
	poMZaaA9YDFV3ZbRgMCfM2bGGcgIqbSITXibyjfBT1QH7ieCNjsT6i+H1NmH+xi5U1+ZoO
	a2fsoEr8IuN4tZXWx6IeIH1Z9vbQDkAdOWPF31tjSGDidGsJXSuqyjU0Ps0dExtsjC6LQt
	wo+3jP/byZAc3ERUEVyUJZPOwWB7Cw6GBBTiOzpPnCw80UEtqdjtoaoevPVvKA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:17 +0100
Subject: [PATCH v2 07/32] drm/blend: Get a rotation name from it's bitfield
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-7-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3321;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Pl8/wLHil1+4yaisV9T8jn/VjcUTIXsuX+80D3wrKXM=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbqzxK7XWGtL5zJytb1q/bSIFCIo/o18iw6q
 lT7hxDn0kaJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6gAKCRAgrS7GWxAs
 4k4ID/0Vx8MJyB+BkiQ6MlTbL/jbSVpp2c67uCBpQgHYmIZLD7Zb5Rt3cqHcHcs9ubF+tJa5qJc
 OFT4GfK5pSWHeBWMOTJMFNU0fMLZHSqcXJxw1I7CQ7dW45M+vTEugNYOBR6LsqtcLtp8LY7ODxh
 +ACNwCJWHI0vkVXOcmUKljdECAsMBp4Ep5Hk2KCoSugYHBy3ypTOhbXbOA6DqNnIEvFDYJyNjKu
 oMq16CXZHuhP8op/tNfO3b4WyzFJKUwgDtWw40a8THQ8kg+j2huUOV1SIhtgm4oHBGi8+yGW56k
 Ilm8CISuCOfV6SLktKJtITOrfjdqBpwezhBA7XnMIKbmegyelsB44458j/dUJ77Nmtu0BNuQwQ7
 KyGE1u9WYVOr3jwoCVtGAtHkk72CJpvmFzEZN5ZOFlByra6nlipjirI9cy+YwN/XNeaJOgnjLP+
 MNFYyTxVesFlee3eWqNwnoj1SMIXWOenCst4viT/5G874+bki0VuWp6GaYIRd/0Oox0tTQFYo6U
 xkSZAfadUEk4jRJa/WT7nBGmdEx4BAMYB0ylnYr5/cEglWR02+4dXaEvo5jy4wUvxfJOthbW+1f
 3St5BKOuCnq4GWmxYEez8S4W/K1JcH+wdkLE8rpiPJq0D6LqlPdNNCCFg/SvxzLU04Ue1z4yFaR
 mX5+HNOC5p+WfkA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Having the rotation/reflection name from its value can be useful for
debugging purpose. Extract the rotation property table and implement
drm_get_rotation_name.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_blend.c | 35 ++++++++++++++++++++++++++---------
 include/drm/drm_blend.h     |  2 ++
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index 6852d73c931c..bc7c05e20242 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -241,6 +241,31 @@ int drm_plane_create_alpha_property(struct drm_plane *plane)
 }
 EXPORT_SYMBOL(drm_plane_create_alpha_property);
 
+static const struct drm_prop_enum_list rotation_props[] = {
+	{ __builtin_ffs(DRM_MODE_ROTATE_0) - 1,   "rotate-0" },
+	{ __builtin_ffs(DRM_MODE_ROTATE_90) - 1,  "rotate-90" },
+	{ __builtin_ffs(DRM_MODE_ROTATE_180) - 1, "rotate-180" },
+	{ __builtin_ffs(DRM_MODE_ROTATE_270) - 1, "rotate-270" },
+	{ __builtin_ffs(DRM_MODE_REFLECT_X) - 1,  "reflect-x" },
+	{ __builtin_ffs(DRM_MODE_REFLECT_Y) - 1,  "reflect-y" },
+};
+
+/**
+ * drm_get_rotation_name - Return the name of a rotation
+ * @rotation: The rotation mask (DRM_MODE_ROTATE_* | DRM_MODE_REFLECT_*)
+ *
+ * Returns: the name of the rotation type (unknown) if rotation is not
+ * a known rotation/reflection
+ */
+const char *drm_get_rotation_name(unsigned int rotation)
+{
+	if (rotation < ARRAY_SIZE(rotation_props))
+		return rotation_props[rotation].name;
+
+	return "(unknown)";
+}
+EXPORT_SYMBOL(drm_get_rotation_name);
+
 /**
  * drm_plane_create_rotation_property - create a new rotation property
  * @plane: drm plane
@@ -279,14 +304,6 @@ int drm_plane_create_rotation_property(struct drm_plane *plane,
 				       unsigned int rotation,
 				       unsigned int supported_rotations)
 {
-	static const struct drm_prop_enum_list props[] = {
-		{ __builtin_ffs(DRM_MODE_ROTATE_0) - 1,   "rotate-0" },
-		{ __builtin_ffs(DRM_MODE_ROTATE_90) - 1,  "rotate-90" },
-		{ __builtin_ffs(DRM_MODE_ROTATE_180) - 1, "rotate-180" },
-		{ __builtin_ffs(DRM_MODE_ROTATE_270) - 1, "rotate-270" },
-		{ __builtin_ffs(DRM_MODE_REFLECT_X) - 1,  "reflect-x" },
-		{ __builtin_ffs(DRM_MODE_REFLECT_Y) - 1,  "reflect-y" },
-	};
 	struct drm_property *prop;
 
 	WARN_ON((supported_rotations & DRM_MODE_ROTATE_MASK) == 0);
@@ -294,7 +311,7 @@ int drm_plane_create_rotation_property(struct drm_plane *plane,
 	WARN_ON(rotation & ~supported_rotations);
 
 	prop = drm_property_create_bitmask(plane->dev, 0, "rotation",
-					   props, ARRAY_SIZE(props),
+					   rotation_props, ARRAY_SIZE(rotation_props),
 					   supported_rotations);
 	if (!prop)
 		return -ENOMEM;
diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
index 88bdfec3bd88..381d1f8d815b 100644
--- a/include/drm/drm_blend.h
+++ b/include/drm/drm_blend.h
@@ -42,6 +42,8 @@ static inline bool drm_rotation_90_or_270(unsigned int rotation)
 
 #define DRM_BLEND_ALPHA_OPAQUE		0xffff
 
+const char *drm_get_rotation_name(unsigned int rotation);
+
 int drm_plane_create_alpha_property(struct drm_plane *plane);
 int drm_plane_create_rotation_property(struct drm_plane *plane,
 				       unsigned int rotation,

-- 
2.51.0


