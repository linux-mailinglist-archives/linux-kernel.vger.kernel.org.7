Return-Path: <linux-kernel+bounces-876394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6F6C1BA3A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E852A645E35
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F453446C5;
	Wed, 29 Oct 2025 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C7P1oVIW"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8CD345CAD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748661; cv=none; b=rx0GZru6rQ2qzgz9RuLWYmf8hfOU5AtxuOII7OmSYdj25Ys+ALToA8MIBrnAHWh1FbSn0Vuu59Sf5dPoRUyYZuWnU8YLD+iplfU+jlH5aJOxRWI7hKeJ3IBmDN3WlfX697LoD46fpKxAhwJN89CQuinAQUsrVgk5EjyH+83/Og0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748661; c=relaxed/simple;
	bh=fQn1DhxGfYNX8VU/HCeunjh+etuTG9Na/6C5gWSAOrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTFCcD2zxntQVk5yfvHf6/TxoHOIKovtzOLtGbSB1jctXV45SED+xqLUFH7heFP/2aJF1SVtU6K8dTKj2w+z6zvvH1317t5ZGb8LR0T6EINStmxUbNeYMfBT5Pq3xX+PRB28jvlXauTyJH2e5OyEOqfe1JWr3XkT9RG/v4vxUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C7P1oVIW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 100214E413CD;
	Wed, 29 Oct 2025 14:37:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA000606E8;
	Wed, 29 Oct 2025 14:37:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CAE6102F24F9;
	Wed, 29 Oct 2025 15:37:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748656; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PdR/lV4Aq38fLSZTr2GyyE929TgZeBjpNA3qwiY4csA=;
	b=C7P1oVIWD2EqirvtwHa6PvAe+8PZF4yq6ItQLlMI+9qE61lRMMCClWJvPm/jzfDuzDs+YM
	IQvxnUpiwBqxYdzLJqYnhtZ5xsDTCI6/rBSiMM8VIPhOTewEZxycYaU8YP9YOA70xZ+fz+
	iROta0YDG6wY7sREM6yk6Q3om5v/ABJ/oSnNBXvfWXnAjVeJBnh1iqiqz1/tr9J2nnrHtV
	ylXwibBv7EzODMvmR/YpBQ69B4eR+gTexnWLEFOtc3FxMJw3jSS9MsrAYesjwulYRzLYrC
	864xDTnPHXy+tR3JWc3+czMRABN+SjSMpyG0VrE8TuHSPK9jwf1jt99SQUwqLw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:37:03 +0100
Subject: [PATCH RESEND v2 26/32] drm/vkms: Introduce config for connector
 EDID
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-26-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8011;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=fQn1DhxGfYNX8VU/HCeunjh+etuTG9Na/6C5gWSAOrE=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ9OaO+hFxXOMW7VTFWj5vChywvDroMG4/gI
 unFlz+Fld6JAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImfQAKCRAgrS7GWxAs
 4l1AD/0Zb76CiV2++5JjKc5MtWrFVqRNCkq5oawlBSo2X8641GdK1TIPx7wBznAiRUEOjsa7KE4
 c7NOxSUZcp0/7DXp7gjiqQHt2Sozn+aRm0A+OMmYqNIxM75slCszXbX+/Afm7nNxuoyeE6KlZmN
 K5GnUkNY+g9t8934Jto3RkqUpu+I880qqy5pMi/1ye7iQfvpmZEHAA8f/hdMsey0bywUoUPUC2j
 RBlJ7PuHrYXPp1zMOEj+jr+vD7PO5zBuYV3QLJfJDBH3QCVzYdewPZmAbE1ar+KPTRvt4q5yzrR
 KX3Op0SPc4k/SO+gbaPrM2w9HeEQ7jMTsF3nI178bGob/6xY0VPWpeqtQEh98U/1EJNrvn6Njey
 MJJVtQXjHVBhkNrG0q9XplBbxip4zbPmPxb4+MyVlBJikvpIO+mJUTdWpnC0ITw2dTeJ3i8KJ93
 2hSaKrM6othazqiCB1021iAfIyy8EaDUW0aKzW9Jzkf0EIhcAAQqMANwFPvHu9Ddb6PxqZ3Qa3B
 1DkB3YMbhC37hRIju7eGxgmANmazxeAEnXubhtF6NFdmiI0YkOz/yBVmnXLxiJAY218bc1FGNdP
 FVh86DTsO9zhhjmQo0qLiDAaxqALh8UYHJR+NqFIg10bgtG9pozw+bZBajdYz8A7p1RbXX21OKi
 akgzFn52OOuuhUw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Allows configuration of EDID for each connector.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  2 +
 drivers/gpu/drm/vkms/vkms_config.c            |  6 +++
 drivers/gpu/drm/vkms/vkms_config.h            | 75 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c         | 48 +++++++++++++++--
 4 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index e0ceecf2e2dd..531c3b76b58d 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -205,6 +205,8 @@ static void vkms_config_test_default_config(struct kunit *test)
 		KUNIT_EXPECT_EQ(test,
 				vkms_config_connector_get_supported_colorspaces(connector_cfg),
 				0);
+		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_edid_enabled(connector_cfg),
+				false);
 	}
 
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 6f939b82c33f..02c0e944adf8 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -525,6 +525,7 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	struct drm_device *dev = entry->dev;
 	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
 	const char *dev_name;
+	int edid_len;
 	struct vkms_config_plane *plane_cfg;
 	struct vkms_config_crtc *crtc_cfg;
 	struct vkms_config_encoder *encoder_cfg;
@@ -594,6 +595,11 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		show_bitfield(m, vkms_config_connector_get_supported_colorspaces(connector_cfg),
 			      drm_get_colorspace_name);
 		seq_puts(m, "\n");
+		vkms_config_connector_get_edid(connector_cfg, &edid_len);
+		seq_printf(m, "\tEDID=%s (len=%d)\n",
+			   str_enabled_disabled(vkms_config_connector_get_edid_enabled(connector_cfg)),
+			   edid_len
+		);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index d68133723444..42f5b5edaf1d 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -135,6 +135,9 @@ struct vkms_config_encoder {
  *                         are the sames as ones accepted by
  *                         drm_mode_create_hdmi_colorspace_property() and
  *                         drm_mode_create_dp_colorspace_property()
+ * @edid_enabled: If true, create the EDID property
+ * @edid: Stores the current EDID. The value will be ignored if @edid_enabled is false
+ * @edid_len: Current EDID length. The value will be ignored if @edid_enabled is false
  * @possible_encoders: Array of encoders that can be used with this connector
  * @connector: Internal usage. This pointer should never be considered as valid.
  *             It can be used to store a temporary reference to a VKMS connector
@@ -148,6 +151,9 @@ struct vkms_config_connector {
 	int type;
 	enum drm_connector_status status;
 	u32 supported_colorspaces;
+	bool edid_enabled;
+	u8 *edid;
+	unsigned int edid_len;
 	struct xarray possible_encoders;
 
 	/* Internal usage */
@@ -271,6 +277,75 @@ vkms_config_connector_get_supported_colorspaces(const struct vkms_config_connect
 	return connector_cfg->supported_colorspaces;
 }
 
+/**
+ * vkms_config_connector_get_edid_enabled() - Check if EDID is enabled for a connector
+ * @connector_cfg: Connector configuration to check
+ *
+ * Returns:
+ * True if EDID is enabled for this connector, false otherwise.
+ */
+static inline bool
+vkms_config_connector_get_edid_enabled(const struct vkms_config_connector *connector_cfg)
+{
+	return connector_cfg->edid_enabled;
+}
+
+/**
+ * vkms_config_connector_set_edid_enabled() - Enable or disable EDID for a connector
+ * @connector_cfg: Connector configuration to modify
+ * @enabled: Whether to enable EDID for this connector
+ */
+static inline void
+vkms_config_connector_set_edid_enabled(struct vkms_config_connector *connector_cfg,
+				       bool enabled)
+{
+	connector_cfg->edid_enabled = enabled;
+}
+
+/**
+ * vkms_config_connector_get_edid() - Get the EDID data for a connector
+ * @connector_cfg: Connector configuration to get the EDID from
+ * @len: Pointer to store the length of the EDID data
+ *
+ * Returns:
+ * Pointer to the EDID data buffer, or NULL if no EDID is set.
+ * The length of the EDID data is stored in @len.
+ */
+static inline const u8 *
+vkms_config_connector_get_edid(const struct vkms_config_connector *connector_cfg, int *len)
+{
+	*len = connector_cfg->edid_len;
+	return connector_cfg->edid;
+}
+
+/**
+ * vkms_config_connector_set_edid() - Set the EDID data for a connector
+ * @connector_cfg: Connector configuration to modify
+ * @edid: Pointer to the EDID data buffer
+ * @len: Length of the EDID data
+ *
+ * If @len is 0, the EDID data will be cleared. If memory allocation fails,
+ * the existing EDID data will be preserved.
+ */
+static inline void
+vkms_config_connector_set_edid(struct vkms_config_connector *connector_cfg,
+			       const u8 *edid, unsigned int len)
+{
+	if (len) {
+		void *edid_tmp = krealloc(connector_cfg->edid, len, GFP_KERNEL);
+
+		if (edid_tmp) {
+			connector_cfg->edid = edid_tmp;
+			memcpy(connector_cfg->edid, edid, len);
+			connector_cfg->edid_len = len;
+		}
+	} else {
+		kfree(connector_cfg->edid);
+		connector_cfg->edid = NULL;
+		connector_cfg->edid_len = len;
+	}
+}
+
 /**
  * vkms_config_get_device_name() - Return the name of the device
  * @config: Configuration to get the device name from
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index cc59d13c2d22..339d747e729e 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -42,13 +42,53 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
+static int vkms_connector_read_block(void *context, u8 *buf, unsigned int block, size_t len)
+{
+	struct vkms_config_connector *config = context;
+	unsigned int edid_len;
+	const u8 *edid = vkms_config_connector_get_edid(config, &edid_len);
+
+	if (block * len + len > edid_len)
+		return 1;
+	memcpy(buf, &edid[block * len], len);
+	return 0;
+}
+
 static int vkms_conn_get_modes(struct drm_connector *connector)
 {
-	int count;
+	struct vkms_connector *vkms_connector = drm_connector_to_vkms_connector(connector);
+	const struct drm_edid *drm_edid = NULL;
+	int count = 0;
+	struct vkms_config_connector *context = NULL;
+	struct drm_device *dev = connector->dev;
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
+	struct vkms_config_connector *connector_cfg;
 
-	/* Use the default modes list from DRM */
-	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
-	drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
+	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
+		if (connector_cfg->connector == vkms_connector)
+			context = connector_cfg;
+	}
+	if (context) {
+		if (vkms_config_connector_get_edid_enabled(context)) {
+			drm_edid = drm_edid_read_custom(connector,
+							vkms_connector_read_block, context);
+
+			/*
+			 * Unconditionally update the connector. If the EDID was read
+			 * successfully, fill in the connector information derived from the
+			 * EDID. Otherwise, if the EDID is NULL, clear the connector
+			 * information.
+			 */
+			drm_edid_connector_update(connector, drm_edid);
+
+			count = drm_edid_connector_add_modes(connector);
+
+			drm_edid_free(drm_edid);
+		} else {
+			count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
+			drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
+		}
+	}
 
 	return count;
 }

-- 
2.51.0


