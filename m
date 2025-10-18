Return-Path: <linux-kernel+bounces-858930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4955BBEC489
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0988C406D92
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E348224AEF;
	Sat, 18 Oct 2025 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a87nOdCB"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5725227EB9
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752928; cv=none; b=qOx1rdrZyil8JvjDP0oesriUYC3NreH9BSP9Rnx3A0sfD4hcUDuiLlZQl2yuql9tFI7pIUdNvlJzWyQ9G9FRk9d7fYL2+oiKDW46tlMWhrSdicqDLaTp0659uiTCy1qthVxv0cIPfZDWNVqB7t3S0X1xt8BrD1FLeG1E4cwwXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752928; c=relaxed/simple;
	bh=gfv2BQBOZAy9jJ2tfKGQ6nr7uZbAqBeZPxmntTqESvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARSYbm/1rKa816NnCTWNw0iYqSCbVHKwUnL91XiB4t0tZ79vwmbpCsbTq26+/XHh6T3NTFJCcxWq5Y1fvm3GVL56Hzs73e9EcAodBqPKOALGk7lmOsqcOdqnTGES+S83Lw1O12BFpIHajo/W1xKrLksAa2tSOuxNJym4X8JFzkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a87nOdCB; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E85A5C035A7;
	Sat, 18 Oct 2025 02:01:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4867E60701;
	Sat, 18 Oct 2025 02:02:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2ABD102F236C;
	Sat, 18 Oct 2025 04:02:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760752922; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uC+LBZs8BYsUf6d367L33XjtRRfZ9EajiPX+Z3nZuU8=;
	b=a87nOdCBwF+OkvkmhaF5ZHzClJOYpUtPTMwuYxVbidu4D0QivN/uR+DdZKuKBiuBabkBqg
	o/PHs5dao2zHcN+sw3uS0M1GxqrAHbw0vlkFyHu5PCK5sYfFxXKsspUltdzcpr7Jb5PlRq
	+MLq7EIb6K/nykSKGab2sRrmqSDWCKgHAfgCupvaFgWC9lfnhs8CCpi/RQHeO7G+ze9qxd
	LN7zmZYfO4h+TogX1L/HjfB95J0wTl7tQE4nNDc4+1JAoYFk6GOtw/i6dIARpd6wQR5/qk
	gIU+MbN8vhrveVSVchgeMtWjyFKuJL5MXlkeUr1j95E7QTnMn8oHlcKX7gwahA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 18 Oct 2025 04:01:07 +0200
Subject: [PATCH 07/22] drm/vkms: Introduce config for plane color range
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-vkms-all-config-v1-7-a7760755d92d@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5199;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=gfv2BQBOZAy9jJ2tfKGQ6nr7uZbAqBeZPxmntTqESvA=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBo8vT9TiOfgRfGFzig74lsDu958RZAJa404WQzT
 +WBpy5/bLSJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaPL0/QAKCRAgrS7GWxAs
 4mk7D/sFRUh1GqjzPqh4AOA8J0szuIjCKdZqorsi5U+GxtoXRWZEx1P1QS2TzZ7gxnvrqh776eY
 HO261zPgqFycG05Jbp/y+AFMrtK64/VEnUejD5XINfX8q0Yggds+ssRkir6HLu6wq1F/9dSJAOE
 w3HPRR0AgyVESLj8VuekQRD+baYuNZw/qeYvMKVCxjYuT21mFlSC9H0nIiw5pOqz2ZLcYDFrhUx
 IkdA/0q9bXeT36NU9jiIQ652HGdD26wPuk5yMopg3LgwyP0feYh4xVSDeMtPzvxjjYxJixvxAEF
 29FemDNV8Xw+UpfsphtFWdZzZruQBlFMwjlG+r25aa+Cs66rSXhMeTlTj2z4xABh/OHKpmPDpwh
 5KlIMKUhz3cqreheVhX/ZXtOOMisCodBlaUbRQxXQdLlHUMh/dRN16qTCTz+jvJTrINk3IPuSYh
 /7lCfm1zghngBfFSvoTi8sf4WY2GtfKQXdvlyGTk2smAmVJ83xMTTx3T+6nL5IBFUahx8BJgR+U
 WfW3HQGHlTkl30Tk+ha/REhsK0JgMQn6Q7vDaXj3gQ6QBrVNB4Gn7pJ7xxtps2wfcfBuVqsTXMk
 wuk3JYe7o1eN0T74v2H4Mx8pZrghE8jLc1UZdqlyMTbOjhMToD+7ysQBYmYozo0jP3nY/pCNLA4
 cV8YAqtvbB4QVMA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

VKMS driver supports all the color range on planes, but for testing it can
be useful to only advertise few of them. This new configuration interface
will allow configuring the color range per planes.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 14 ++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h | 30 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c  |  5 ++---
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 5353719a476d..8f00ca21ed6e 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -163,6 +163,13 @@ static bool valid_plane_properties(const struct vkms_config *config)
 			drm_info(dev, "Configured default color encoding is not supported by the plane\n");
 			return false;
 		}
+
+		if ((BIT(vkms_config_plane_get_default_color_range(plane_cfg)) &
+		     vkms_config_plane_get_supported_color_range(plane_cfg)) !=
+		    BIT(vkms_config_plane_get_default_color_range(plane_cfg))) {
+			drm_info(dev, "Configured default color range is not supported by the plane\n");
+			return false;
+		}
 	}
 	return true;
 }
@@ -386,6 +393,10 @@ static int vkms_config_show(struct seq_file *m, void *data)
 			   vkms_config_plane_get_supported_color_encoding(plane_cfg));
 		seq_printf(m, "\tdefault color encoding: %d\n",
 			   vkms_config_plane_get_default_color_encoding(plane_cfg));
+		seq_printf(m, "\tsupported color range: 0x%x\n",
+			   vkms_config_plane_get_supported_color_range(plane_cfg));
+		seq_printf(m, "\tdefault color range: %d\n",
+			   vkms_config_plane_get_default_color_range(plane_cfg));
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -433,6 +444,9 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
 							BIT(DRM_COLOR_YCBCR_BT709) |
 							BIT(DRM_COLOR_YCBCR_BT2020));
 	vkms_config_plane_set_default_color_encoding(plane_cfg, DRM_COLOR_YCBCR_BT601);
+	vkms_config_plane_set_supported_color_range(plane_cfg, BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+							       BIT(DRM_COLOR_YCBCR_FULL_RANGE));
+	vkms_config_plane_set_default_color_range(plane_cfg, DRM_COLOR_YCBCR_FULL_RANGE);
 
 	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 11160c3c13bc..8127e12f00dc 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -47,6 +47,8 @@ struct vkms_config {
  *         must be managed by other means.
  * @default_color_encoding: Default color encoding that should be used by this plane
  * @supported_color_encoding: Color encoding that this plane will support
+ * @default_color_range: Default color range that should be used by this plane
+ * @supported_color_range: Color range that this plane will support
  */
 struct vkms_config_plane {
 	struct list_head link;
@@ -58,6 +60,8 @@ struct vkms_config_plane {
 	unsigned int supported_rotations;
 	enum drm_color_encoding default_color_encoding;
 	unsigned int supported_color_encoding;
+	enum drm_color_range default_color_range;
+	unsigned int supported_color_range;
 	struct xarray possible_crtcs;
 
 	/* Internal usage */
@@ -374,6 +378,32 @@ vkms_config_plane_set_supported_color_encoding(struct vkms_config_plane *plane_c
 	plane_cfg->supported_color_encoding = supported_color_encoding;
 }
 
+static inline enum drm_color_range
+vkms_config_plane_get_default_color_range(struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->default_color_range;
+}
+
+static inline void
+vkms_config_plane_set_default_color_range(struct vkms_config_plane *plane_cfg,
+					  enum drm_color_range default_color_range)
+{
+	plane_cfg->default_color_range = default_color_range;
+}
+
+static inline unsigned int
+vkms_config_plane_get_supported_color_range(struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->supported_color_range;
+}
+
+static inline void
+vkms_config_plane_set_supported_color_range(struct vkms_config_plane *plane_cfg,
+					    unsigned int supported_color_range)
+{
+	plane_cfg->supported_color_range = supported_color_range;
+}
+
 /**
  * vkms_config_plane_set_name() - Set the plane name
  * @plane_cfg: Plane to set the name to
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 5869000415e4..ab719da2ca0b 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -240,10 +240,9 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 
 	drm_plane_create_color_properties(&plane->base,
 					  vkms_config_plane_get_supported_color_encoding(config),
-					  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
-					  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
+					  vkms_config_plane_get_supported_color_range(config),
 					  vkms_config_plane_get_default_color_encoding(config),
-					  DRM_COLOR_YCBCR_FULL_RANGE);
+					  vkms_config_plane_get_default_color_range(config));
 
 	return plane;
 }

-- 
2.51.0


