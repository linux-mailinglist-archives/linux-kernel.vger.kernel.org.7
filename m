Return-Path: <linux-kernel+bounces-876377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D220C1BB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6ACA644B74
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E322DEA9B;
	Wed, 29 Oct 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BMTZjA2P"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE3E2D5C6C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748630; cv=none; b=qifyhr/LmFxpDxF5ZSgO3yURpkMyRL9zmlGrMHl8n5t/KKiNhcSz+5ynds8gDw1R5zjTBIU2RdUyrP3MBilYCaoSVt5sMziUw9Bd37QzhZK/yFftNvs+8aF6IXXdU7Xqej4RVN3NH2gtFroGPlPUQfu7993aLmqmNe3crF8V36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748630; c=relaxed/simple;
	bh=Dv+LTI2ccj4n/EV0vGVog8BjMGvNzDlPlpeBGi9mOcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQmabB/gfTazo7NwRfVpkZUUy6VFbncIXfpws6pcnunGKK1bvN63oUCZcrLqxZnCeXzabu4av8vPAu6ao8r15YwttHBywpQ3Q4MS9CYJeqesxQPmzZm3Luc7uXJ5hCawnwE5IH3XBEZFtqCAQ65k+09FboqcYYIou2q9jxpytOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BMTZjA2P; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8CC464E413CD;
	Wed, 29 Oct 2025 14:37:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5FD05606E8;
	Wed, 29 Oct 2025 14:37:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2562B117F81B0;
	Wed, 29 Oct 2025 15:37:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748625; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iqMVLDuN4ai0MP2bHzX+4+j1XnBiI2VvRCwM5QgdY5E=;
	b=BMTZjA2Pvjs5jSnws+Oa7xbu+CTkBt0d1AxX95ba8GDtE0gqV5x6Q+Ruw2Aof6JmQtMqZN
	DNabOeN+t8SdVzTTRd472OtzE++VDPaQ2xaB5tT43SYzYjOFW/8EgG9W94E5kJxMt3Qc1w
	Ftt19J6lU56kdTv3Xjddb8XAop531QuRMUFqfBNkLR9JZRH/b8xPq+GzI4exlS+E4OaDSz
	ubasmz/lDv7pUkwIyHcKwUgAiYL8M2p7sGLrIDmLPpi4oXnnMn5gKgxUNHG4Xcbyjw3sC5
	PoLbZ16ascBTypRohq1RAvVOCyCeeUjxokTB5dFQJPWxo3Nuoa7zi63j++h86A==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:36:46 +0100
Subject: [PATCH RESEND v2 09/32] drm/vkms: Introduce configfs for plane
 rotation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-vkms-all-config-v2-9-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4874;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Dv+LTI2ccj4n/EV0vGVog8BjMGvNzDlPlpeBGi9mOcY=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ7YNP9XXMDrcnEpQgcHgNfI8K5oQV5Wsbk8
 MSmunogl0+JAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImewAKCRAgrS7GWxAs
 4tiGEADMtOf6Q6j/mf3hw8cA7hMigthOuclQTLk3/siF5eq2tAKJXYerW5cYJ+SAwANdlNgTC6S
 VdgfooiYs02K3ZelEcw61ZEiyu7O1yiz01P4ktW6b3HAxxTp9Ru7LIJV2ShXOYiSoCtIWfC95Xa
 6aC+EY20c18r8MjBRZO9B6AaeBKL9sM2rEoBnW6KGixbxWMsIFq+pxLnT8xXLowkQ8naF5Ol0+m
 1Fiq87LAJSoIq8WKZNcpp5AYabIwL5aICbgQGz8rcUYeJUEHum9WF08njnI1TXI8avjKUe/Ggs6
 RzdcwsDqX1r4meZ/FHB9ktuWVX42m/Hr7rbf0GJ6/gikYnD3jQz8VY1as2yZqyYmY43x+9Gpd0d
 EaXazISN8/RLVCVrQQHjSF8jZSzwbwuZapyubhdciCz9xkfWeqeZr0+YaqBKLM3e0D6bRAhgkRx
 gJ/H89q1gI4IZxZ1xHjCE/asZtb0VMTVCV49Abv9USlDa0d/y1l25strh6lo7qDuE+puXPCc6xD
 MlQKNG/9hY91ywa+5M5gfTr+TP6hvmhyPuWmShs6/qlR6M1LH17IJ+vqlI+r56Ul4GhsE/JaS+6
 0PgLZskezt4m+mYdhlbntLCtd6dpa5UDw3nUFNdxjrinRoqWAvrFMDMc0HEWT34VNkqMd4bC890
 OPECg4pVPw4LqTA==
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


