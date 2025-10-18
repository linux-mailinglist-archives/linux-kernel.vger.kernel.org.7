Return-Path: <linux-kernel+bounces-858929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0226BEC486
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EADC1AA5B3C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641E12264AD;
	Sat, 18 Oct 2025 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bC3/FC3P"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74F224AEF
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752924; cv=none; b=oMg69gP71IWK/bsFbaSJqCCehQVKqpAbiWOjjtpDPitjgCdIy5prmypwl/PfLGBfBSOUF4aw/5E0Uoaah5F8nM/RG4ktDzdnuojd7E4HLpbj1MFdUY7aj+LxOcAE/uJgY+JU3EZ7xC0Jd0GtFXJ0yoe45djkYdnOtj6tgulsy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752924; c=relaxed/simple;
	bh=mh+IW1eZTRLhBSalLL+EiK3RLAsPJbyKHaX58DjJBaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iP3KkVWYTWjLd7ZpiNRadK/NTQLChNGZwKwHGXC114HAkS9bQLMJd8xHHXv1TGRFatgNIiVRNOg6fNULa3c61hM3lAukN+Ee3ExkLm43m8HlCdLkQ9W6Ojz/iH3cT+/SBkXD1fzvFrQpc6cqSA4LAGiL2Iogw7K5IxO/Bgq3HT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bC3/FC3P; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CAAD4C041FD;
	Sat, 18 Oct 2025 02:01:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2B24560701;
	Sat, 18 Oct 2025 02:02:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4CE9D102F237F;
	Sat, 18 Oct 2025 04:01:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760752920; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JnSE13gC1MR7BSBM0cc/TrTHLHePZlRwuf5e8aoIewk=;
	b=bC3/FC3PB960vSvW2WTWYO29IAeDmNuP3CjTNq/5R5auQuY+4PewFUO9tQQN5aVzakxMGd
	EmFzgUM65DUZlj4oKdm8e3BVbqnQcXpVeLYcVsmeFo+OPH8ww+VTP7o/A9FN8990n6/7gG
	ZIiCE2PyWOpKkGyNse3RW8XmAnEblRl1bXbPi9JyWYqA91BqQiY//K8jC3QDSCCAzEjKRH
	Mh16LDYFVLlWM3+HW5li2fLpRu/5robJggGq8/9AZOWJI7S1YYr03E/4BS8romNn4rly/5
	V5v3bTzM6rTVQscije4ehjZSiPbwmKVeReohD1ajTKHcHNqO4348lr3OcmQUUw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 18 Oct 2025 04:01:06 +0200
Subject: [PATCH 06/22] drm/vkms: Introduce configfs for plane color
 encoding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-vkms-all-config-v1-6-a7760755d92d@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5765;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=mh+IW1eZTRLhBSalLL+EiK3RLAsPJbyKHaX58DjJBaE=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBo8vT9tDEWWjD8RRzDB0vNgImJpbLT7tuO+oOBS
 uzK1l+0uy+JAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaPL0/QAKCRAgrS7GWxAs
 4nkkEACEWEuXEcvgqoi4XwnApjOwsDHXnduvhCTDdU+pmx9HmrboSxoaI5D28RPz2AfUmPK5zB7
 hDfx71bUCriEhR5qTQgJDk4Piu/zn7eihYvLt+WUGurMVKIFwMI8lM4+kHBqYfUuRgdRsFGHnQv
 r0hevEl/IjkOTYl+fei5dX/p8au3ubUuh9hS/nEr14sKTKBoH9TuPay+QokeHpNSwLaZAn/JzUA
 iYlXKHeDVnAzxB5bOrm8RYuceYSZV3XvAholWyLRAN6BibHUsXf34A25s6QRbytM96J6YV7TRyv
 m4dLH3ZSb8k0ISwxxrGqM3dFhgK3vh1+eRhCDmxri6IxRSAsA0KpmTmWCcfyoCGbojQ2k+qY40X
 dOhrAsFxshbiGwyl8k1N52kYzB8KrU2fD9S622k7uwdqHH6TrwGtC4Y2dXYl1xchmX79qMQkKeU
 1HjtY6nCd0d1xdmKhqgZNRhfBY+Q0JxDlzbi5PQcW3lpo7ZsGZXIs14+7Z4cbIkBhU1ihykgDlM
 3DM2mHot3dJC1i7D5nv4xc2LcUlvU717viRYgVVzkZ31n8k0EfOHxBGDIm2Ml57HN6Zh+7xRaFP
 uZm21tyWYH7reHPTCeN1tBYlNYnLgEHCKB5empnJn5HYdL8GUdszc9JgGSN4wMGsuy7xeRzGr3S
 RNSzEvEmIcDPEeQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

To allows the userspace to test many hardware configuration, introduce a
new interface to configure the available color encoding per planes. VKMS
supports multiple color encoding, so the userspace can choose any
combination.

The supported color encoding are configured by writing a color encoding
bitmask to the file `supported_color_encoding` and the default color
encoding is chosen by writing a color encoding bitmask to
`default_color_encoding`.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst           |   7 ++-
 drivers/gpu/drm/vkms/vkms_configfs.c | 102 +++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index a432968cc711..4ff75b53a386 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -87,7 +87,7 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
-Planes have 3 configurable attribute:
+Planes have 5 configurable attribute:
 
 - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
   exposed by the "type" property of a plane)
@@ -96,6 +96,11 @@ Planes have 3 configurable attribute:
   (same values as those exposed by the "rotation" property of a plane)
 - default_rotation: Default rotation presented to the userspace, same values as
   possible_rotations.
+- supported_color_encoding: Available encoding for a plane, as a bitmask:
+  0x01 YCBCR_BT601, 0x02: YCBCR_BT709, 0x04 YCBCR_BT2020 (same values as those exposed
+  by the COLOR_ENCODING property of a plane)
+- default_color_encoding: Default color encoding presented to the userspace, same
+  values as supported_color_encoding
 
 Continue by creating one or more CRTCs::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 450e45e66a45..a4e0e054cf2d 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -412,14 +412,116 @@ static ssize_t plane_default_rotation_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t plane_supported_color_encoding_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int supported_color_encoding;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		supported_color_encoding = vkms_config_plane_get_supported_color_encoding(plane->config);
+	}
+
+	return sprintf(page, "%u", supported_color_encoding);
+}
+
+static ssize_t plane_supported_color_encoding_store(struct config_item *item,
+						    const char *page, size_t count)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	int ret, val = 0;
+
+	ret = kstrtouint(page, 10, &val);
+	if (ret)
+		return ret;
+
+	/* Should be a supported value */
+	if (val & ~(BIT(DRM_COLOR_YCBCR_BT601) |
+		    BIT(DRM_COLOR_YCBCR_BT709) |
+		    BIT(DRM_COLOR_YCBCR_BT2020)))
+		return -EINVAL;
+	/* Should at least provide one color range */
+	if ((val & (BIT(DRM_COLOR_YCBCR_BT601) |
+		    BIT(DRM_COLOR_YCBCR_BT709) |
+		    BIT(DRM_COLOR_YCBCR_BT2020))) == 0)
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		/* Ensures that the default rotation is included in supported rotation */
+		if (plane->dev->enabled ||
+		    (val & vkms_config_plane_get_default_color_encoding(plane->config)) !=
+		     vkms_config_plane_get_default_color_encoding(plane->config))
+			return -EINVAL;
+
+		vkms_config_plane_set_supported_color_encoding(plane->config, val);
+	}
+
+	return count;
+}
+
+/* Plane default_color_encoding : vkms/<device>/planes/<plane>/default_color_encoding */
+
+static ssize_t plane_default_color_encoding_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int default_color_encoding;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		default_color_encoding = vkms_config_plane_get_default_color_encoding(plane->config);
+	}
+
+	return sprintf(page, "%u", default_color_encoding);
+}
+
+static ssize_t plane_default_color_encoding_store(struct config_item *item,
+						  const char *page, size_t count)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	int ret, val = 0;
+
+	ret = kstrtouint(page, 10, &val);
+	if (ret)
+		return ret;
+
+	/* Should be a supported value */
+	if (val & ~(BIT(DRM_COLOR_YCBCR_BT601) |
+		    BIT(DRM_COLOR_YCBCR_BT709) |
+		    BIT(DRM_COLOR_YCBCR_BT2020)))
+		return -EINVAL;
+	/* Should at least provide one color range */
+	if ((val & (BIT(DRM_COLOR_YCBCR_BT601) |
+		    BIT(DRM_COLOR_YCBCR_BT709) |
+		    BIT(DRM_COLOR_YCBCR_BT2020))) == 0)
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		/* Ensures that the default rotation is included in supported rotation */
+		if (plane->dev->enabled ||
+		    (val & vkms_config_plane_get_supported_color_encoding(plane->config)) !=
+		     val)
+			return -EINVAL;
+
+		vkms_config_plane_set_default_color_encoding(plane->config, val);
+	}
+
+	return count;
+}
+
 CONFIGFS_ATTR(plane_, type);
 CONFIGFS_ATTR(plane_, supported_rotations);
 CONFIGFS_ATTR(plane_, default_rotation);
+CONFIGFS_ATTR(plane_, supported_color_encoding);
+CONFIGFS_ATTR(plane_, default_color_encoding);
 
 static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_type,
 	&plane_attr_supported_rotations,
 	&plane_attr_default_rotation,
+	&plane_attr_supported_color_encoding,
+	&plane_attr_default_color_encoding,
 	NULL,
 };
 

-- 
2.51.0


