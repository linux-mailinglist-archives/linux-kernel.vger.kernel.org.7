Return-Path: <linux-kernel+bounces-876375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E78F9C1B525
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AA91AA4C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651B82DA77E;
	Wed, 29 Oct 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SGBIFUvN"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD3B2DEA9B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748626; cv=none; b=YXdc05PqdgYfu6pv0qrXWzFVA1Z+FtUDczaGrQz1rtsbfVjW3tvsIajIH6LYPgEhAPpshOVCCSYe7myzPNHzhmBxU6ueDgin7YXCNHw1VyrEwDKtiYwfDETd52jcVYdzSUpPVmt9+8PbIBNnitRwppeAQApEyZykqdieWWHJQaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748626; c=relaxed/simple;
	bh=Pl8/wLHil1+4yaisV9T8jn/VjcUTIXsuX+80D3wrKXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fAPlGeWunncf3XqxvRW8rkke3oCCC34VHzQmkRqNVMgONIhE/FSn+qG57Hu7t/woAq1rK66zkOgnCgFZodSjVWrbo87pWYGnBhuW4Bezy3d6hHkV2xr/zwHZKgrLSckKRs1cP4eHPTyhfKeou+Ctty65ltPNpKWIHj8JpQN1mH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SGBIFUvN; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 36F674E413CB;
	Wed, 29 Oct 2025 14:37:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0BE7E606E8;
	Wed, 29 Oct 2025 14:37:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98AE7117F81A9;
	Wed, 29 Oct 2025 15:37:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748622; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gZH4XqHEnkgG+WiGf4L3QVJCg6jApM4gvYwyfSScQxU=;
	b=SGBIFUvNgkvxzALshu7uZRgC/6m33HWE96lB+htAPa5eJmAuvZop1qi9dakIqwwcv6Ik0X
	JECpYAm6EB0hGWZon7ZUlqn0toStq8OoU9HoIxDPbIGip9FQgcaNAVvQVChFcDXbwRyfUJ
	wvGOrDCYMAG7gHiQr5PHW3IzGBbJzSt0awTJmL3rRuiQPphH+HmRS58Fjh9NDK3ayT2Ort
	rVv+8m+J9Ctxw+7NP0SC98VrLrrDpWPExGCxYnIkHZWx1ULuiF++XufBadpiB0GdTh7tqr
	GBxZHYURPIrhGRzOXsBLH/ygdoeWeWmVYnXqGWcqqLdnJxUSZq8IkIME0Vbj0w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:36:44 +0100
Subject: [PATCH RESEND v2 07/32] drm/blend: Get a rotation name from it's
 bitfield
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-7-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3321;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Pl8/wLHil1+4yaisV9T8jn/VjcUTIXsuX+80D3wrKXM=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ7f0FokT9zbt4H75Ux7Gi1z9UBY3E04ndK1
 LaXAHSYYQmJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImewAKCRAgrS7GWxAs
 4u6tD/9v7Oce9o8e3V/RCjZhhBS6FHRp7LdcCaev5iu3YO8Sqkgn88tyalFUMSUs1JVgyNuYej4
 6mX1qu+Dh0mrJvfyO7vyPnrFFQmGX6O84+2OUYkVqFhSQYQlNB3opr/cjJbhPsS65CbqT4ql4qX
 B/UDbjpeY3rPs1k4/jCXDe1rG+ClWGiQGz2MwC+56bT6VvmsLgnUjJaU/r6rKW3M9EXVWsgRuiy
 0zEKi3VFcGGS4EIHz1j0AFt9l3a+N8hYDwvhbfFsdMzMzR4+LtTDNsir6qm3H3ob7ANEn47xiIN
 OLqwAPt5TbX+LQCWSPhFIDRucRxOVaj44r/wTfpjgFk4VjeFCOkEOtGnfNdEnNvTCUJyzKOKLY+
 44NcTnTyQOKFuO8kEaVnuXtrNBvt5KMKMPQFSj+Ja//qjr4a0Gmy8aI2S3/+7GrS9dLKry+/7XQ
 R2eEWuQCrT0ljVLou7tiFkfCMWewSSd8cZ+gsyXkjLm062ST5qVP1mFmmgYB53EsZ61lLENolvL
 osFx1odxRLoDjpBEQVWvKs+eUeyPFhgIlCAfCOlXoggyIfPBPMzUVJhLfr1pLww8BwR2Oaj5iNs
 9uh/fp01i3JEizdhpUiJCoJFWaQmBfG6nzjr57BIk+XbOkD39/qvMo/AcaCikRFgVFiOyVkZBaa
 6pjvCa0aeUeMHaQ==
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


