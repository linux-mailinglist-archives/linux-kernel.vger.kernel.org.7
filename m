Return-Path: <linux-kernel+bounces-858939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2731BEC4C2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2803535517C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64181248F4E;
	Sat, 18 Oct 2025 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AjclbMl5"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8CA23D7F3;
	Sat, 18 Oct 2025 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752948; cv=none; b=dY/4HlcL4KlJ/vzWbJ6aFBOBk+OeXAsCUVzMO2ar79B4PaGQDalJwYFAR1EIN1AhbwWBT4q99zlcEyKWELEOdKcq4wxeDuHWtyqJGAJcPDToo/OzN+fAqMNsoFvfCl/Tp/XvgtshUwEltU1SmbaeOxRJFM/rmzkXj4JFDc1C60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752948; c=relaxed/simple;
	bh=gp/as8jslPeYVJaMphS7S8r4C2Q8kY1KGjqD1XYJms4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CPqSxKAsxh+GtsFVk/j0lZpRo5VezX/dwTlo5cmWb45nWl+6+tp0FI0vLhxh6vL50ftAZPOC8L3+/NcJtCgrJkK7+kIXHl1Yze9zMGso25NgjpcWg0CDxAi/I55j90MxmZzG9h2uiVkaqrAOGHEBsous5h+86yPRdpy1IYqZYXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AjclbMl5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DE4781A14AB;
	Sat, 18 Oct 2025 02:02:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B3FD260701;
	Sat, 18 Oct 2025 02:02:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFE73102F236C;
	Sat, 18 Oct 2025 04:02:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760752943; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XrzBloffEesAzM4+cYe1LjABY2oUa0qa917OjW4iAmA=;
	b=AjclbMl5fx0w0ScnEnIPJKon9gF5HKAvmi1JJ+Ndi+rATxEWN/zy8Hqv/IoAy7xZebN7w6
	mk3n1XxOJrxN1CpNpxESJKFgicHaXETQef2YTg0iZxoqmd6u0zcVp+0UoREvYqJin3dFmX
	T5b6GLozi1KnKKUVS16k7UWkR3VxOUnCgfYMC5ybhy9CeMEQ6LIw2XR/KU1V0nSdQQoLo2
	kPFcO4PJyTiFPaM1Arae/rTN22ZJkuo1rA8OfuDutSMslBzvIAcmxvFQGY0h2nGVZy3KFa
	GXqaN+AMXOYK6Bnzc4g7sYbZri2gJ4NHzfkHgJNlXe0eVSbkt7dVZO6QxlaN9g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 18 Oct 2025 04:01:16 +0200
Subject: [PATCH 16/22] drm/vkms: Introduce config for connector supported
 colorspace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-vkms-all-config-v1-16-a7760755d92d@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4737;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=gp/as8jslPeYVJaMphS7S8r4C2Q8kY1KGjqD1XYJms4=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBo8vT+/TjTwuE9NbM24YpWBq9aPvOtzhn1Jer0K
 iQ98kpH2RCJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaPL0/gAKCRAgrS7GWxAs
 4sUhEACw0SouOSO0spLRYfDp0bG36dxyvtlCPxkKQzM2uh6TPBOOpH9jL17xZt5SeYX9tG6C9s6
 Uoq8SPO5iYDzeUyJyQKpIKOeA1cYcxPOnWlef/yoBART8Omda9gT3WX/XIS9W/qiKEuA0+vzZJl
 gh3KGJ2CSH/MFbuZIb7mykU+uBAqL3D+vpd7RVvdBFKrCsqANOtVavitwFEjk2CQKwYLo+uGtoA
 OFznZ+HMNA2wekGAJDxy3+eyFgQOit8GQcjdL+aUIxoHl31hCMFVUaNPX9Chi5rG0WuJTy+gjhz
 f14Mzsc0wOBDEXjy6STfa00N9anme50wc6+jh0d2MWEW5ZEIqp77iOPBkd44hkSKTK4tmL4eLvG
 rFVSD36zSyRH/rShVJrA5R/6ysvgmsLD9Ut/vMbG+yGVdZdxPxiV+zDDzoGr90t9gLe3LrNOnXV
 atrpdi2Vrhn8m+nemApfR6A9hnyuZHVI2GUea0+XayisbEiM9o8XfC3/cb3NvMgM9/YMrKnyEXu
 EOpztPcJVWEeLWyP2d7kglrL4fE4hsalPq7hjM95+yjliCZT9V0rnPGk+j7pWmPezGfF1HmlpY0
 U1hcxPBtFZBdmVGMnFtN6sAGtdf49Ieuyd5usKWobugD8OYBeueOA/FxCeWjdWZsXzF+uJqbPEG
 9CmD3httFMdh3LA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

To emulate some HDR features of displays, it is required to expose some
properties on HDMI, eDP and DP connectors.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  3 +++
 drivers/gpu/drm/vkms/vkms_config.c            |  1 +
 drivers/gpu/drm/vkms/vkms_config.h            | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c         | 15 +++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index 8633210342a4..a89ccd75060d 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -187,6 +187,9 @@ static void vkms_config_test_default_config(struct kunit *test)
 	vkms_config_for_each_connector(config, connector_cfg) {
 		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_type(connector_cfg),
 				DRM_MODE_CONNECTOR_VIRTUAL);
+		KUNIT_EXPECT_EQ(test,
+				vkms_config_connector_get_supported_colorspaces(connector_cfg),
+				0);
 	}
 
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 20750c9f6d08..56e2082b91c9 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -772,6 +772,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 	connector_cfg->config = config;
 	connector_cfg->status = connector_status_connected;
 	vkms_config_connector_set_type(connector_cfg, DRM_MODE_CONNECTOR_VIRTUAL);
+	vkms_config_connector_set_supported_colorspaces(connector_cfg, 0);
 	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
 
 	list_add_tail(&connector_cfg->link, &config->connectors);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 36d289a010f6..ec614c2d4a30 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -141,6 +141,7 @@ struct vkms_config_connector {
 
 	int type;
 	enum drm_connector_status status;
+	u32 supported_colorspaces;
 	struct xarray possible_encoders;
 
 	/* Internal usage */
@@ -239,6 +240,31 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
  */
 void vkms_config_destroy(struct vkms_config *config);
 
+/**
+ * vkms_config_connector_set_supported_colorspaces() - Set the supported colorspaces for a connector
+ * @connector_cfg: Connector configuration to modify
+ * @supported_colorspaces: Bitmask of supported colorspaces (DRM_COLOR_YCBCR_*)
+ */
+static inline void
+vkms_config_connector_set_supported_colorspaces(struct vkms_config_connector *connector_cfg,
+						u32 supported_colorspaces)
+{
+	connector_cfg->supported_colorspaces = supported_colorspaces;
+}
+
+/**
+ * vkms_config_connector_get_supported_colorspaces() - Get the supported colorspaces for a connector
+ * @connector_cfg: Connector configuration to query
+ *
+ * Returns:
+ * Bitmask of supported colorspaces (DRM_COLOR_YCBCR_*)
+ */
+static inline u32
+vkms_config_connector_get_supported_colorspaces(struct vkms_config_connector *connector_cfg)
+{
+	return connector_cfg->supported_colorspaces;
+}
+
 /**
  * vkms_config_get_device_name() - Return the name of the device
  * @config: Configuration to get the device name from
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 5a87dc2d4c63..cc59d13c2d22 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -84,6 +84,21 @@ struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
 	if (ret)
 		return ERR_PTR(ret);
 
+	if (vkms_config_connector_get_supported_colorspaces(connector_cfg)) {
+		if (connector_cfg->type == DRM_MODE_CONNECTOR_HDMIA) {
+			drm_mode_create_hdmi_colorspace_property(&connector->base,
+								 vkms_config_connector_get_supported_colorspaces(connector_cfg));
+			drm_connector_attach_hdr_output_metadata_property(&connector->base);
+			drm_connector_attach_colorspace_property(&connector->base);
+		} else if (connector_cfg->type == DRM_MODE_CONNECTOR_DisplayPort ||
+			   connector_cfg->type == DRM_MODE_CONNECTOR_eDP) {
+			drm_mode_create_dp_colorspace_property(&connector->base,
+							       vkms_config_connector_get_supported_colorspaces(connector_cfg));
+			drm_connector_attach_hdr_output_metadata_property(&connector->base);
+			drm_connector_attach_colorspace_property(&connector->base);
+		}
+	}
+
 	drm_connector_helper_add(&connector->base, &vkms_conn_helper_funcs);
 
 	return connector;

-- 
2.51.0


