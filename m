Return-Path: <linux-kernel+bounces-876388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01633C1B620
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5833A5A6AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BC033B6FD;
	Wed, 29 Oct 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MtZB+f6F"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C53533A026
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748649; cv=none; b=aP5SogccKIUs4pfpGbfr3sbMmEDHcYmEgB9iY/D5aujh3GmehcwDqUpxll6SFoupjgbQAXVt+rUc31iiAi3zS34UrQnOFEzCIgsuCujgRdCDnWdX+C0zBjI9e5yKNxjS2AABUEr3hUq/QVThxw7YC/v7JgrOjPSgatZCkeeMpXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748649; c=relaxed/simple;
	bh=P0mWYpyiiMrPDse27em7Q4FFig+ra+2u7mDuWs/kj0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t6tBkZwz0rXKsrYc0MKQ+ScfgICPKeEm5OW0eoxzj/hft4afUZIovYr+YAEdgEi3Dg11oYHMbO0v2SOG8nohbSuXdjQ9eCu+cJI2abICnVxIaPv6rJ5Qz5+XuMth1xs1oPd0hdAdYvpDdCERvxaFh6et9ErIgAviFKP9sNFCEyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MtZB+f6F; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 271584E413CB;
	Wed, 29 Oct 2025 14:37:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EF7BE606E8;
	Wed, 29 Oct 2025 14:37:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8A7D117F81B3;
	Wed, 29 Oct 2025 15:37:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748645; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zFCTYSXu8zR0H2WC/3HxAVrv/TDK9xKwNmxiQq5HQMo=;
	b=MtZB+f6FSuRLl6WhWgw+ezB8kMst28HkQognLdXPWXX32SUkQhtrR6dLFuGXj2MpwyiHLM
	TE9lbAzFH44n7yQZO/XUvOYyHsQK1u1qUJ6nPB8ZPuptJ7F4pviIITQcWto5oOBAjln+nk
	jKvxfITpc8Ucz2+4ni42+6pujnxxilyF9Np8e6TJ/fPvJsxIz4dvnlkGzY4kNVQCY7oGKg
	zhJxOKAaIiNK0P21tLQ97rwBWojbG3WfdZBttCBziJ+eoRAfrzs57LVL1OXhV1KCxLeAfY
	dDKMZCdBOqBN69SbREkk8Mbf1wKfDZCiAOeEsYJ+E3SrR8s6JYO0EONWLxoavA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:36:57 +0100
Subject: [PATCH RESEND v2 20/32] drm/vkms: Introduce configfs for plane
 zpos property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-20-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7640;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=P0mWYpyiiMrPDse27em7Q4FFig+ra+2u7mDuWs/kj0I=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ8IvGV0tDNx8wFUM6wAS88DLbJbUNENpXIt
 /A2Jn/af5SJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImfAAKCRAgrS7GWxAs
 4p59D/oDPHMZmAgxTje/69ETTyMnUWoVs2zsNM1ckOFfzcW/RYnPSJE/UsR7LitMUk9uqxg6wc5
 tSieDUk8x4oFyOE3xxVJD6IbKe7niBLeG8cq1FxoCAAJJfdsRNpV1VFXAFxO/dFI03lbyrwJqG0
 OC0I+UAAZy3T0NpVwnVCBIhbkAIJi+gajQdFh+xIiePpWWFn94eBEcs6DNhbgSWz5ISARE7x5Io
 fysw6unT3VbKSA8qVFjWdoE1kpj/OMyLDhpDrDICaG//ZvlklGXXQMF6tKbkWr7A0NFl61B2Xfw
 I/Ot+OETqPx6rAdLgbRqvUu58fneMb6EijeJn3iz35y+3lgkuBicHKUQiz3vxlQGNbA0qP0lIPl
 k2vrp89CuO//xMIdPxQPp3KyoCDgCvBJcKvP2vd5f5OZBkIdfvuqJ06ZSVZwbAWLLjz8virYfE7
 3Aofc73zLmIurpYKsWBBAxuRClJtgJ6q9ZRRYLrhZ4xlzTBKIZoxtuSlFuh6mtoND2Z3jiHx6Du
 GUyxdA6tGCho1Osq/PRiz4Qw0GMsf4+2FKch18KvpHjsjBcsCRCXr4V6tu2KrVIB8CIlQfC6f+d
 zUywppKqGxeTlc5MkFrg+KE01yUqtsngtsKaBGuIItJpFRblCkQDyq6TeaVTT1M3Vjf1y/ojozx
 SWlARm1JiUGpMpQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Modern compositor rely on zpos management to offload some processing to
deticated hardware. In order to test multiple configurations, add zpos
configuration to configFS.

Introduce multiple attributes to configure zpos:
- zpos_enabled - Create or not the zpos property. If not created, the zpos
  is undefined.
- zpos_mutable - If the zpos property is created, allow or not the
  userspace to modify it
- zpos_initial - Initial value for zpos property. Must be between zpos_min
  and zpos_max
- zpos_min - Minimal zpos value for this plane. Must be smaller than or
  equals to zpos_max
- zpos_max - Maximal zpos value for this plane. Must be greater than or
  equals to zpos_min

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst           |   9 +-
 drivers/gpu/drm/vkms/vkms_configfs.c | 180 +++++++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 779ae363110d..32858f9a3357 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -87,7 +87,7 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
-Planes have 9 configurable attributes:
+Planes have 14 configurable attributes:
 
 - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
   exposed by the "type" property of a plane)
@@ -114,6 +114,13 @@ Planes have 9 configurable attributes:
   To remove a format, use a minus and its fourcc: -XR24
   To add all formats use +*
   To remove all formats, use -*
+- zpos_enabled: Enable or not the zpos property: 1 enable, 0 disable
+- zpos_mutable: Create the zpos property as a mutable or imutable property: 1 mutable,
+  0 disable. No effect if zpos_enabled is not set.
+- zpos_initial: Set the initial zpos value. Must be between zpos_min and zpos_max. No
+  effect if zpos_enabled is not set.
+- zpos_min: Set the minimal zpos value. No effect if zpos_enabled is not set.
+- zpos_max: Set the maximal zpos value. No effect if zpos_enabled is not set.
 
 Continue by creating one or more CRTCs::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index b0a26c4dbebe..1c0a6ecf2f29 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -735,6 +735,176 @@ static ssize_t plane_supported_formats_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t plane_zpos_enabled_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	bool enabled;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock)
+		enabled = vkms_config_plane_get_zpos_enabled(plane->config);
+
+	return sprintf(page, "%d\n", enabled);
+}
+
+static ssize_t plane_zpos_enabled_store(struct config_item *item, const char *page,
+					size_t count)
+{
+	struct vkms_configfs_plane *plane;
+	bool enabled;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	if (kstrtobool(page, &enabled))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_zpos_enabled(plane->config, enabled);
+	}
+
+	return (ssize_t)count;
+}
+
+static ssize_t plane_zpos_mutable_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	bool mutable;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock)
+		mutable = vkms_config_plane_get_zpos_mutable(plane->config);
+
+	return sprintf(page, "%d\n", mutable);
+}
+
+static ssize_t plane_zpos_mutable_store(struct config_item *item, const char *page,
+					size_t count)
+{
+	struct vkms_configfs_plane *plane;
+	bool mutable;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	if (kstrtobool(page, &mutable))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_zpos_mutable(plane->config, mutable);
+	}
+
+	return (ssize_t)count;
+}
+
+static ssize_t plane_zpos_initial_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int initial;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock)
+		initial = vkms_config_plane_get_zpos_initial(plane->config);
+
+	return sprintf(page, "%u\n", initial);
+}
+
+static ssize_t plane_zpos_initial_store(struct config_item *item, const char *page,
+					size_t count)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int initial;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	if (kstrtouint(page, 10, &initial))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_zpos_initial(plane->config, initial);
+	}
+
+	return (ssize_t)count;
+}
+
+static ssize_t plane_zpos_min_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int min;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock)
+		min = vkms_config_plane_get_zpos_min(plane->config);
+
+	return sprintf(page, "%u\n", min);
+}
+
+static ssize_t plane_zpos_min_store(struct config_item *item, const char *page,
+				    size_t count)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int min;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	if (kstrtouint(page, 10, &min))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_zpos_min(plane->config, min);
+	}
+
+	return (ssize_t)count;
+}
+
+static ssize_t plane_zpos_max_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int max;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock)
+		max = vkms_config_plane_get_zpos_max(plane->config);
+
+	return sprintf(page, "%u\n", max);
+}
+
+static ssize_t plane_zpos_max_store(struct config_item *item, const char *page,
+				    size_t count)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int max;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	if (kstrtouint(page, 10, &max))
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		if (plane->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_plane_set_zpos_max(plane->config, max);
+	}
+
+	return (ssize_t)count;
+}
+
 CONFIGFS_ATTR(plane_, type);
 CONFIGFS_ATTR(plane_, name);
 CONFIGFS_ATTR(plane_, supported_rotations);
@@ -744,6 +914,11 @@ CONFIGFS_ATTR(plane_, default_color_range);
 CONFIGFS_ATTR(plane_, supported_color_encodings);
 CONFIGFS_ATTR(plane_, default_color_encoding);
 CONFIGFS_ATTR(plane_, supported_formats);
+CONFIGFS_ATTR(plane_, zpos_enabled);
+CONFIGFS_ATTR(plane_, zpos_mutable);
+CONFIGFS_ATTR(plane_, zpos_initial);
+CONFIGFS_ATTR(plane_, zpos_min);
+CONFIGFS_ATTR(plane_, zpos_max);
 
 static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_type,
@@ -755,6 +930,11 @@ static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_supported_color_encodings,
 	&plane_attr_default_color_encoding,
 	&plane_attr_supported_formats,
+	&plane_attr_zpos_enabled,
+	&plane_attr_zpos_mutable,
+	&plane_attr_zpos_initial,
+	&plane_attr_zpos_min,
+	&plane_attr_zpos_max,
 	NULL,
 };
 

-- 
2.51.0


