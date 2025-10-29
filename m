Return-Path: <linux-kernel+bounces-876200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9A9C1AC14
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C833634B453
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FBD347BB4;
	Wed, 29 Oct 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zb+dQGXT"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B3346E51
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744654; cv=none; b=apMMuy5qhE+CnuROxl6/Zok1yeJA5mKocp1/u5uhz0HxDmeCJgIPch929bwWLTeSVimp+gQ0MwqA9FNZg89x8u0tOThY+/JyRpu/Zlh2xiBvX9zKnRgQj9TtbT8aVgIPUn7qO+6ZMO2yzte+KSQOW7SlJOSxioTgvsl+kOATFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744654; c=relaxed/simple;
	bh=C/MMRwVv7tqxhyIue1VDDpDHYOcgFuMbnkd6mU2hgRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j9Z1aiTRPGI/ECR0x73xJcRdE3SXXn9EVFR1qFPQs6WaSIWJ2byKjfpZpuA3VifNpYC88PylsdcTHDXuEpJzze2oI7OE4yM8tRf62qC6H2lDnwBTbx8OiKcE5aoRglo4St3RfT612g8scNk5/TeL5eE1YExVT/JbqdYDyE22fO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zb+dQGXT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2EA214E413CE;
	Wed, 29 Oct 2025 13:30:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 04068606E8;
	Wed, 29 Oct 2025 13:30:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B99A5117F809A;
	Wed, 29 Oct 2025 14:30:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744650; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+evWkGwW+11FOg/3gUJ1wDOagGB2wDut1Bio9XWm4W4=;
	b=zb+dQGXTUqAH3BlHDxxPOFWGyQODIqR/QLXKX3SfYDcW7PKLNLNbeUL2rp65G0sP3Lpe7d
	vmF/r81Y5wW9pSWURfuPrKZLrl/BW7tMv99DsffxZcT2S0iU6BhUuq4H9zKVheXzu811G2
	nMN7B0ibOqRoarU+wmbqV2l4bENeK6oijU1OCDKFsbSCIm/y858PIbINwz5zNfNiDAVwl8
	6gBuN7b7geqsRfkeiS13CCc0j8ZTVusdJ21VX+ZFXCq/9OwIeVn96mXlWTjdFQwcEBs2+q
	Uuoa63j6qXApeVGIPISR5+RZ2Ro08+PMHTCjXI/bwEXtWtehK23s1+XYO1EiJw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:25 +0100
Subject: [PATCH v2 15/32] drm/vkms: Introduce configfs for plane color
 range
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-15-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5958;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=C/MMRwVv7tqxhyIue1VDDpDHYOcgFuMbnkd6mU2hgRk=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbqDkl576Eyq7/m+Wt9htCFCFnB46sosP0Jh
 12KTPvp04uJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6gAKCRAgrS7GWxAs
 4jgXD/9Gm9+e2USYCUxFzNaZfTXxeBQqMepLfz1CMyLW7a/YhIYt8/+ViBkGnhQIYnZuhELFDmI
 fvSNBHqM7t2JOjwwF2H7+UnA25dgWVdNoGQK3owwDS1KShWh8a0av6rQ6qw07wuk/TJnCg0sbmK
 Nvf6eL8RYtR1Brp3qRTO8mNBTtF4Sg/JDS7aw1cLOec/BYecOvqbnbSqO4aHROhfUFarMhFfVaX
 WgXOWA2z1+KgafiEyfX7ZdOai3OQulQLepb3pRfZCznJs4buIOi9Uc0c/q2f/NRiK31EvptOenc
 p6KaASMLQTbliM5cr5dgLKnPRydlyGPo5RnYtDeFjAQF6LBGB824qaLOEUfPRWwTxJKCvqfpGhl
 /MaicfGZJRBwSiBLayqrfKhZg3BHzY+VpSzS9rYBRy9k0q4hcHbEpDLPY2LCj81Iak8LfaCWPRV
 uWVHWtHVSOfyfCC3V/hDuvgt1gOxjFnO6WWpz2QklpKF6OuLNfujPAJNStBmFgNRxgVp2baujDk
 yshZpYP05ZlntvJE5f1LycGeeIuaTYFwQQEjeC2gFdvnJyHa+uOzheNRn9NJM61oesahBTQ5ATx
 DJvkYScRZQLk5JEFtHlMtx0MvFfof7hD56YCIDfalnrM425TjyZ19q8cdawHajFW7Mwjm6+wocZ
 X8lSlGcMak5m9dw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

To allows the userspace to test many hardware configuration, introduce a
new interface to configure the available color ranges per planes. VKMS
supports multiple color ranges, so the userspace can choose any
combination.

The supported color ranges are configured by writing a color range bitmask
to the file `supported_color_ranges` and the default color range is
chosen by writing a color encoding bitmask to `default_color_range`.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst           | 11 ++++-
 drivers/gpu/drm/vkms/vkms_configfs.c | 89 ++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index dab6811687a2..8383e1b94668 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -87,7 +87,7 @@ Start by creating one or more planes::
 
   sudo mkdir /config/vkms/my-vkms/planes/plane0
 
-Planes have 6 configurable attributes:
+Planes have 8 configurable attributes:
 
 - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
   exposed by the "type" property of a plane)
@@ -99,9 +99,16 @@ Planes have 6 configurable attributes:
   possible_rotations.
 - supported_color_encoding: Available encoding for a plane, as a bitmask:
   0x01 YCBCR_BT601, 0x02: YCBCR_BT709, 0x04 YCBCR_BT2020 (same values as those exposed
-  by the COLOR_ENCODING property of a plane)
+  by the COLOR_ENCODING property of a plane). If set, supported_color_range
+  must be set too.
 - default_color_encoding: Default color encoding presented to the userspace, same
   values as supported_color_encoding
+- supported_color_range: Available color range for a plane, as a bitmask:
+  0x1 DRM_COLOR_YCBCR_LIMITED_RANGE, 0x2 DRM_COLOR_YCBCR_FULL_RANGE (same values as
+  those exposed by the COLOR_RANGE property of a plane). If set, supported_color_encoding
+  must be set too.
+- default_color_range: Default color range presented to the userspace, same
+  values as supported_color_range
 
 Continue by creating one or more CRTCs::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index ee2e8d141f9e..3f658dd41272 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -439,6 +439,91 @@ static ssize_t plane_default_rotation_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t plane_supported_color_ranges_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int supported_color_range;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		supported_color_range = vkms_config_plane_get_supported_color_ranges(plane->config);
+	}
+
+	return sprintf(page, "%u", supported_color_range);
+}
+
+static ssize_t plane_supported_color_ranges_store(struct config_item *item,
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
+	if (val & ~(BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+		    BIT(DRM_COLOR_YCBCR_FULL_RANGE)))
+		return -EINVAL;
+	/* Should at least provide one color range */
+	if ((val & (BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+		    BIT(DRM_COLOR_YCBCR_FULL_RANGE))) == 0)
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		/* Ensures that the default rotation is included in supported rotation */
+		if (plane->dev->enabled)
+			return -EINVAL;
+		vkms_config_plane_set_supported_color_ranges(plane->config, val);
+	}
+
+	return count;
+}
+
+static ssize_t plane_default_color_range_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_plane *plane;
+	unsigned int default_color_range;
+
+	plane = plane_item_to_vkms_configfs_plane(item);
+
+	scoped_guard(mutex, &plane->dev->lock)
+		default_color_range = vkms_config_plane_get_default_color_range(plane->config);
+
+	return sprintf(page, "%u", default_color_range);
+}
+
+static ssize_t plane_default_color_range_store(struct config_item *item,
+					       const char *page, size_t count)
+{
+	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
+	int ret, val = 0;
+
+	ret = kstrtouint(page, 10, &val);
+	if (ret)
+		return ret;
+
+	/* Should be a supported value */
+	if (val & ~(BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+		    BIT(DRM_COLOR_YCBCR_FULL_RANGE)))
+		return -EINVAL;
+	/* Should at least provide one color range */
+	if ((val & (BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+		    BIT(DRM_COLOR_YCBCR_FULL_RANGE))) == 0)
+		return -EINVAL;
+
+	scoped_guard(mutex, &plane->dev->lock) {
+		/* Ensures that the default rotation is included in supported rotation */
+		if (plane->dev->enabled)
+			return -EINVAL;
+		vkms_config_plane_set_default_color_range(plane->config, val);
+	}
+
+	return count;
+}
+
 static ssize_t plane_supported_color_encodings_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_plane *plane;
@@ -537,6 +622,8 @@ CONFIGFS_ATTR(plane_, type);
 CONFIGFS_ATTR(plane_, name);
 CONFIGFS_ATTR(plane_, supported_rotations);
 CONFIGFS_ATTR(plane_, default_rotation);
+CONFIGFS_ATTR(plane_, supported_color_ranges);
+CONFIGFS_ATTR(plane_, default_color_range);
 CONFIGFS_ATTR(plane_, supported_color_encodings);
 CONFIGFS_ATTR(plane_, default_color_encoding);
 
@@ -545,6 +632,8 @@ static struct configfs_attribute *plane_item_attrs[] = {
 	&plane_attr_name,
 	&plane_attr_supported_rotations,
 	&plane_attr_default_rotation,
+	&plane_attr_supported_color_ranges,
+	&plane_attr_default_color_range,
 	&plane_attr_supported_color_encodings,
 	&plane_attr_default_color_encoding,
 	NULL,

-- 
2.51.0


