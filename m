Return-Path: <linux-kernel+bounces-876205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C62C1ADF1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D3B1B27395
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B2C34DB51;
	Wed, 29 Oct 2025 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="db5rRRBy"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095E234C149;
	Wed, 29 Oct 2025 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744662; cv=none; b=VJ+17jWOX/I2IuhbX7ZzLU9MXyRTNZKORWddwdS6smDmt9KgULiw2LhlpaLQmEUx3/9MK7XaCbhyU7DaiCV+/T6NOvfEbSPNa0c6eaNL7bEqvJfL0rpawJsvc/kOpYdLrgPVpWlU+rxMC8qHddsxuLPWrJEg1NNBggRGK8xGdpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744662; c=relaxed/simple;
	bh=P0mWYpyiiMrPDse27em7Q4FFig+ra+2u7mDuWs/kj0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHU8ZWfEVaKnSlcnwAF+eIn6oaWroAPyhtRVWn9p6VoqBMeVZgJA1f9H2ML5hOI4CGgpG2PG723sQnTIBAqdpWYFsvXKfCNI7ii0FXuYAjo6u1m2HFc2sUdXbDaTvGThc8eiqjULDSBWoPOYfZGRYE7ztZjA4l54J7v4bWAx140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=db5rRRBy; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5C722C0DB01;
	Wed, 29 Oct 2025 13:30:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B3D73606E8;
	Wed, 29 Oct 2025 13:30:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 602CF117F809E;
	Wed, 29 Oct 2025 14:30:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744658; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zFCTYSXu8zR0H2WC/3HxAVrv/TDK9xKwNmxiQq5HQMo=;
	b=db5rRRByhaR5sKhs2jy7PXXWmU6Uk3s8lSf7LgIoHlw4SxiZeJsD+1QdmylTXDtA8JNwhk
	wZyzNN0VoxobFazv0oVrz8QSUosPzsXfmVtTTAiclJcLR8WUotT4rpcPH2sJO7k3fj4378
	Ua9/MUlkPIN9v5weibDyTDLBALU1NVY+4zbWGXWu4pctrLs6GtaphWQpV1G2OVv5gSQv8C
	jvcHbKmS2ivZnfHzF2CEgLBJ+E7TYsFa5b8qIjcCFhaV/KroBj5IpJBZzRjQv6L3xDAYVa
	xGa3ddJnxB1njb9+wEOpzRD+0Yq/DfQOeZfQIiA3/jjCWq8IPodfx0uzQkjvGw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:30 +0100
Subject: [PATCH v2 20/32] drm/vkms: Introduce configfs for plane zpos
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-20-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7640;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=P0mWYpyiiMrPDse27em7Q4FFig+ra+2u7mDuWs/kj0I=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbrNYQYHKveWgBEuJADeFEM62+xxvGEEPUt+
 P7RPum4OpyJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6wAKCRAgrS7GWxAs
 4iuyEAChD5Vm+RkIU0HXIK5BW1qxbfpV2iBB+VHG/5J1wvU07xOHqxAiFpzdZa1F9iOIBxlEk8X
 Io4gNszEa19dqSTBE2RePGJmmay/Nsqti+GKqFJMNGeCkTFIQ+ynQ6gvAvvk+9h9XT+sX2qefqa
 mVz+063RfGZ2lxHf0oLQ5n6VW3oXv9wIuGsK3DQ+zt1z5dSqt58yipnomoSX6ASHFL5btFXk+vs
 K/SfjCrAsVqKyPkEjEfF3P4hWKl8TcZROQnikt1I4XDgHJmltAPmJAd71B//BMG8cpPRQIPT22I
 Q28t/2rtztk82GYnk6Q5NRx39rl18bHz2v+3hv5GhuWLLmzuyVbZfc16I0YNQLpqMIvfLoQH4Hr
 z+NpytDHuNzA5CO+6t2zkC/VcGJSAjCZd7XlP6FhjfFsfdCPT60cGfx5goFYt3LRNyw+/MVQ6wn
 PFA1+gA2MYOTtDTIO1xgm/QdfU2uxbbYSe7CJ3oX/wIWyQ5o45/JI31w3kAwA1ObIJqJ3qCIHfL
 9q9B2pIAf2eWLWY5/IrkceqHjlk1kkncxkdkP8+4zgEiZOTtoHkEgtpvE8dtBNJPfPiaQyr8Rod
 prrh4x9T1TdqRMtcqIRfORHdwChy08gXLG9WSGnCFwzuBeYg0rqbGj5bWonlvYM6ba6pk7JzVS6
 oZsPsWyZ1XZgX5w==
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


