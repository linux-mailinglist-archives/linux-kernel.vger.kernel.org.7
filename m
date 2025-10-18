Return-Path: <linux-kernel+bounces-858941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AECABEC4CE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BDC62104F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A899525394A;
	Sat, 18 Oct 2025 02:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BIkNl81f"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA2E23ED5E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752951; cv=none; b=s7dkCjkUJbxkOgxSclpwZxL/EKpCEaZ3FpgUaJ9Lk7MCVycfFQucH3NuXAU3bhOzYWUKbX2tcgF9LHLE/mEI+J34kqsjdneHWS8rPoR1beerIYl8OQIfB8YOBdrYOwiCTYKhYk8ADLTT+/mcX71s3y9GuOBRIh+hyVN6R34AR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752951; c=relaxed/simple;
	bh=YCshRJ9iZSgkDt526dfmqKnCSvnelBSFC+J5vxTUkug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PjoKB+jr2fgBkGX3MQdfFIkDs3So3i2uRWnqW5mjOBQjlJ/e8ehH8IF72f/IJP2O2t/pbmSaGAVvAOXrCaspyKJA03ASbNRlFwoYNAmMb4EmpEMziGWK0vz4pAkfHgthY2ZFZY18Qm/B04xI2h3E7D7u0oK8hOJ281apgkbJY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BIkNl81f; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2ED2CC035A7;
	Sat, 18 Oct 2025 02:02:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 84FA160701;
	Sat, 18 Oct 2025 02:02:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3613A102F236F;
	Sat, 18 Oct 2025 04:02:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760752947; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=j18n1xqJ/n23mu+nfKOjoC1n/Jmz1a8pcemwIbutF6s=;
	b=BIkNl81fl8h1nBwz1l3scG0jT2tGql2LiD9ucYWJAmWyJ0bUGhD/snTIcQZB2yI+NDX6NX
	8wTF90u6Ryv4456NAhbOckE5YrqtDrn9lDiHkDAI9s6X8UgVTmOwb98miFzg8f8cqtNgWW
	jNFtSGSu2ABJfiQohj8VJpvlExq1mJ6A3KbfiD8M57zFIg56dQAwK5fESkmibNvK2Dn2GY
	lyAqkamFlybgbfUrK0BqfBuRsmNj425f4pOmfBnpw5Sk7JsyGkkJhhliTuDr+hsZTrjVig
	acGNLRPR3dVrMDvPIZeyyEMA2j4iLaWysge3OMcsPgE4GxwfTIHII5A3kTaUrw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 18 Oct 2025 04:01:18 +0200
Subject: [PATCH 18/22] drm/vkms: Introduce config for connector EDID
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-vkms-all-config-v1-18-a7760755d92d@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6834;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=YCshRJ9iZSgkDt526dfmqKnCSvnelBSFC+J5vxTUkug=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBo8vT+YGVaIJ0xr2TExZUChUmUDy1OTr7xeemzL
 4bkQfvLbGqJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaPL0/gAKCRAgrS7GWxAs
 4p09EAC6HAAgNB9DxaV4KUipen+esFrnBuI0hN04CR/puyupBa+U+BRVmcvIIotQWNuPEb1ieXc
 caR14SAHF5Zzfi5fW/5mR+Atj1qpufcopudhSuWsFGu4QcELvGSS287knuriZhmj8HYl7tpuBgS
 4cUKY7gr21tOEkpuCOyD+7lALB43tBVXLiCUGZqrJ5kL4+QYP5knTnf8Y2FGI7fO3BCyQzVL40r
 Fu+QUvsU5O7H5dCXvxXnkNmrZHmj7EqvdCif/GpEL9VLDMEGma4rpCYIT1WJJRq+yABmTkkjzhI
 MJ5x99ZJj4L9FbXFwdpOW6Mxm3acSOFgjjUqfV2I/pRd/BBEvQ0TFPRU7nkIgJF5m8ICyszpxc6
 rA/3dJ0DWfnILzim0F48UqRiVAnTCgZYGme7w9NjWag1Pyy1B8BB4jjf2PFWtaJAOKqu0YH8VYY
 0ga2uVmCZpiPGvDq1nvGVRUpkVi+n+5ZkGVsOEH53Vg5tPHoauZrIg0rSjEQo+A3fyADsHRYYGi
 ASZUAM3dJpRR51N7PngRCyvQoMDYghLXAx9E3iArB+T9N2Bxr+wCorSEKJOatr3Ags0+H622cfF
 846KP0p7iS6Ohn0QSLP18wNpUj5CDumCqS5XZap10wdOL002vdQtHJF0SlDQzqMTl2I/WXZvXRz
 bnWGpDixqn6R0hA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Allows configuration of EDID for each connector.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  2 +
 drivers/gpu/drm/vkms/vkms_config.h            | 77 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c         | 48 +++++++++++++++--
 3 files changed, 123 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index a89ccd75060d..d1e380da31ff 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -190,6 +190,8 @@ static void vkms_config_test_default_config(struct kunit *test)
 		KUNIT_EXPECT_EQ(test,
 				vkms_config_connector_get_supported_colorspaces(connector_cfg),
 				0);
+		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_edid_enabled(connector_cfg),
+				false);
 	}
 
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index ec614c2d4a30..eaf76a58aab6 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -129,6 +129,8 @@ struct vkms_config_encoder {
  * @type: Store the type of connector using DRM_MODE_CONNECTOR_* values
  * @config: The vkms_config this connector belongs to
  * @status: Status (connected, disconnected...) of the connector
+ * @edid: Stores the current EDID
+ * @edid_len: Current EDID length
  * @possible_encoders: Array of encoders that can be used with this connector
  * @connector: Internal usage. This pointer should never be considered as valid.
  *             It can be used to store a temporary reference to a VKMS connector
@@ -142,6 +144,9 @@ struct vkms_config_connector {
 	int type;
 	enum drm_connector_status status;
 	u32 supported_colorspaces;
+	bool edid_enabled;
+	u8 *edid;
+	unsigned int edid_len;
 	struct xarray possible_encoders;
 
 	/* Internal usage */
@@ -265,6 +270,78 @@ vkms_config_connector_get_supported_colorspaces(struct vkms_config_connector *co
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
+vkms_config_connector_get_edid_enabled(struct vkms_config_connector *connector_cfg)
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
+		} else {
+			kfree(connector_cfg->edid);
+			connector_cfg->edid_len = 0;
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


