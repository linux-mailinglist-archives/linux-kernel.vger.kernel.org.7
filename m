Return-Path: <linux-kernel+bounces-876213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F3FC1B1D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA774626A4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4A29D29F;
	Wed, 29 Oct 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dODOcM/z"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A057350D5E;
	Wed, 29 Oct 2025 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744677; cv=none; b=ojSqU3zzwh93Xo51Nm6oc9/IrzUC5Gyeo6OmOax7UMbepwwGA4XI3p1AWpWTfpx3vaN3Ewio0LWMECD/a4TNAuLa4dwiAFmTCzDqXb+LwNxmdulwjMKdN8JJxtAVYnaooJVBl9jG4UpsnwmWY2UNZXf2SP+5c2Km1UfkFyCAy7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744677; c=relaxed/simple;
	bh=SxSapH92H7+R0YRpp8ZbmLEJQdfxderXgSB2dmTAdXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ba+uGC0AFrbu8qETsMcyG0t7TBJkqXqz5B4I0ElOYSS69u2gO7w+BWT+T+4GFO5cVqyHrk9wKx2FQ0a8bcqVmR+UbgiGyAbf6mQxBM3jvJwLQbz9H0EIOx+cBQwK0+JJazydam9c4zA4WEMkv/0O43fUFTlbCfLThvOQA4V5yI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dODOcM/z; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B5F4C4E413D0;
	Wed, 29 Oct 2025 13:31:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8BE45606E8;
	Wed, 29 Oct 2025 13:31:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F09B117F8047;
	Wed, 29 Oct 2025 14:31:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744672; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BHhX5HD+lytwOesCtdB6a6t4OMHVoG/mXwydRLC0kYA=;
	b=dODOcM/zPlrR30s/2e2B2C5OJy/6HGZhD7iWgaRWsICUoXC9BTMUTZnZKu6QEiPg3A+PEA
	ljHH1uHzIA0c8Qbb6gbWF++h62Za+qLHQLI5W9X+qV+k8RxTQeigynwzb7A5i8MLEKHFxS
	3BjmWWAFsZMqrcBKebQ9pKFy4XwyGm1315/vTf6AVbktauJe3CJZF4ope8IdQXjpTPMAzR
	O7npByt4NLW0PfFNKXkHmJOWIF1VIpjSo+BNYVQJuCm//SpDvf4z7x8F00ml3bPNub2b9y
	bNrzRAVWCX+ucnq9dzednqZi26VNCUtDCfHXioYNMzEVXxJ1v5DU1P74D2UhVw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:38 +0100
Subject: [PATCH v2 28/32] drm/vkms: Store the enabled/disabled status for
 connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-vkms-all-config-v2-28-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6498;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=SxSapH92H7+R0YRpp8ZbmLEJQdfxderXgSB2dmTAdXE=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbskt/94KLcVLFddwwI9yyx3VfGw0+NrlKDG
 ufqUiiRaKuJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW7AAKCRAgrS7GWxAs
 4qmrEADPFDDZln01Ox+7Hruexgv2Isy+Rr5arhNUHLZ7ygeCfj04Pao21PoV8kMoHyqSo5eoQ5Y
 BzikIo51t6mSQxXmdGWuQRjmBiaqAqD7y64Rl1zUlzDGIpWNczOCujennR85j7OHRttrlDSkHRx
 xz+ITfgJC/fdHCkSQGf5K8EgMjh454WekmJxQ9Oi9RUFpqJyx5kOCp+13PvSQvlW+gAU0azMIMM
 2FvkR6aLGciYCPnrhUBe07H7TM/z+BrKgDQ8xiO+stBjB22SXnyJ8DFAsesMtEMkLCZ8QxF6gQe
 FsKByR6pdHhfVwQJT8fsZK+OjFK50ypCCDCgmtPyfHfyZvMQBd/tgmp099wMYD9Ikw9xkzLjJJh
 K+ft9X4ZDKcndkQyTuefvKpK8xf5Dy3A2hah/c6PEQwu9Exw87BWacggex9itvUEFtj/fxLAqD6
 +qQS2E2IM/a46C5wz9hcUJKb4IraXwcbZy2KTSY0xNqzrd7BnyYCgnSjreHbOYMGHEvh4q403gK
 iR1fcN9FfMr+E2ZQpzntYbfQrLeI9YwJQLBztBeNX1rsRnCWmLIMCqgPdVrASLY5LwzxuRvIIF+
 DFgtM628gHZwhv2maOgmgevAZcMPq7eAmZ2tUU8DlXnoBtO4luWeLnd0GDd6nNEQRehGUTuwMZJ
 dwbM8cBaAICXmSg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

In order to prepare for dynamic connector configuration, we need to store
if a connector is dynamic and if it is enabled.

The two new vkms_config_connector fields will helps for that.

Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  4 ++
 drivers/gpu/drm/vkms/vkms_config.c            |  6 +++
 drivers/gpu/drm/vkms/vkms_config.h            | 66 +++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index 531c3b76b58d..b1d95385263f 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -207,6 +207,10 @@ static void vkms_config_test_default_config(struct kunit *test)
 				0);
 		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_edid_enabled(connector_cfg),
 				false);
+		KUNIT_EXPECT_EQ(test, vkms_config_connector_is_enabled(connector_cfg),
+				true);
+		KUNIT_EXPECT_EQ(test, vkms_config_connector_is_dynamic(connector_cfg),
+				false);
 	}
 
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 02c0e944adf8..e86173ad61a6 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -587,6 +587,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
 
 	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
 		seq_puts(m, "connector:\n");
+		seq_printf(m, "\t%s\n",
+			   str_enabled_disabled(vkms_config_connector_is_enabled(connector_cfg)));
 		seq_printf(m, "\tstatus=%s\n",
 			   drm_get_connector_status_name(vkms_config_connector_get_status(connector_cfg)));
 		seq_printf(m, "\ttype=%s\n",
@@ -600,6 +602,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
 			   str_enabled_disabled(vkms_config_connector_get_edid_enabled(connector_cfg)),
 			   edid_len
 		);
+		seq_printf(m, "\tdynamic=%s\n",
+			   str_true_false(vkms_config_connector_is_dynamic(connector_cfg)));
 	}
 
 	return 0;
@@ -907,6 +911,8 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 	connector_cfg->status = connector_status_connected;
 	vkms_config_connector_set_type(connector_cfg, DRM_MODE_CONNECTOR_VIRTUAL);
 	vkms_config_connector_set_supported_colorspaces(connector_cfg, 0);
+	vkms_config_connector_set_dynamic(connector_cfg, false);
+	vkms_config_connector_set_enabled(connector_cfg, true);
 	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
 
 	list_add_tail(&connector_cfg->link, &config->connectors);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 42f5b5edaf1d..a4aa7ad7be71 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -130,6 +130,8 @@ struct vkms_config_encoder {
  * @link: Link to the others connector in vkms_config
  * @type: Store the type of connector using DRM_MODE_CONNECTOR_* values
  * @config: The vkms_config this connector belongs to
+ * @dynamic: Store if a connector should be created with drm_connector_dynamic_init
+ * @enabled: If @dynamic, this means that the correct is currently registered in drm
  * @status: Status (connected, disconnected...) of the connector
  * @supported_colorspaces: Bitmask of all the supported colorspaces. Values
  *                         are the sames as ones accepted by
@@ -149,6 +151,8 @@ struct vkms_config_connector {
 	struct vkms_config *config;
 
 	int type;
+	bool enabled;
+	bool dynamic;
 	enum drm_connector_status status;
 	u32 supported_colorspaces;
 	bool edid_enabled;
@@ -192,6 +196,24 @@ struct vkms_config_connector {
 #define vkms_config_for_each_connector(config, connector_cfg) \
 	list_for_each_entry((connector_cfg), &(config)->connectors, link)
 
+/**
+ * vkms_config_for_each_connector_static - Iterate over the static vkms_config connectors
+ * @config: &struct vkms_config pointer
+ * @connector_cfg: &struct vkms_config_connector pointer used as cursor
+ */
+#define vkms_config_for_each_connector_static(config, connector_cfg) \
+	vkms_config_for_each_connector((config), (connector_cfg)) \
+		if (!(connector_cfg)->dynamic)
+
+/**
+ * vkms_config_for_each_connector_dynamic - Iterate over the dynamic vkms_config connectors
+ * @config: &struct vkms_config pointer
+ * @connector_cfg: &struct vkms_config_connector pointer used as cursor
+ */
+#define vkms_config_for_each_connector_dynamic(config, connector_cfg) \
+	vkms_config_for_each_connector((config), (connector_cfg)) \
+		if ((connector_cfg)->dynamic)
+
 /**
  * vkms_config_plane_for_each_possible_crtc - Iterate over the vkms_config_plane
  * possible CRTCs
@@ -445,6 +467,50 @@ vkms_config_connector_set_type(struct vkms_config_connector *connector_cfg,
 	connector_cfg->type = type;
 }
 
+/**
+ * vkms_config_connector_set_enabled() - If the connector is part of the device
+ * @crtc_cfg: Target connector
+ * @enabled: Add or remove the connector
+ */
+static inline void
+vkms_config_connector_set_enabled(struct vkms_config_connector *connector_cfg,
+				  bool enabled)
+{
+	connector_cfg->enabled = enabled;
+}
+
+/**
+ * vkms_config_connector_is_enabled() - If the connector is part of the device
+ * @connector_cfg: The connector
+ */
+static inline bool
+vkms_config_connector_is_enabled(const struct vkms_config_connector *connector_cfg)
+{
+	return connector_cfg->enabled;
+}
+
+/**
+ * vkms_config_connector_set_dynamic() - If the connector is dynamic
+ * @crtc_cfg: Target connector
+ * @enabled: Enable or disable the dynamic status
+ */
+static inline void
+vkms_config_connector_set_dynamic(struct vkms_config_connector *connector_cfg,
+				  bool dynamic)
+{
+	connector_cfg->dynamic = dynamic;
+}
+
+/**
+ * vkms_config_connector_is_enabled() - If the connector is dynamic
+ * @connector_cfg: The connector
+ */
+static inline bool
+vkms_config_connector_is_dynamic(struct vkms_config_connector *connector_cfg)
+{
+	return connector_cfg->dynamic;
+}
+
 /*
  * vkms_config_plane_get_default_rotation() - Get the default rotation for a plane
  * @plane_cfg: Plane to get the default rotation from

-- 
2.51.0


