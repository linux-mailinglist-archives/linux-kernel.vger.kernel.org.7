Return-Path: <linux-kernel+bounces-858945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C757BBEC4E6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D7F189AC2D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F4825EF81;
	Sat, 18 Oct 2025 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VirI7Bc8"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A3D25784E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752961; cv=none; b=oT9tHdiPLLST4CgF2IvMnyigAjqgc51TIEOJJNJExgKUoqA9FYxzY+AX5LVnP2RcnJsXGmgj35H0vvR1JlyhOamJBfhoGQs9iEtAmJYnnjN3RRDNQHrryRqg6XB5MBgUM7xgCodio0cSRPEGP9hZkNgfXDUpTW3h5i4Wr5jZXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752961; c=relaxed/simple;
	bh=l0QqTuIRUdCVYpHuUyY5RP2VDM8HCO8Ik2svVn7zny8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N1MK4hFZ6ohGXkz7vWCnJFavOMaXwdz6z/FRfo1S5E2XZSZ7ZxNMsP1FCQGfcv6LISc0W5cmwvReUfl6N5c6Bp79uBiJu/Zik7/tN4fD9i0NY1XgQHuD9s0DvUEAAAQ2CVBJL+bUB7kOs/yK5loWLtKKg3lz5LQSLd09Q2jnlsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VirI7Bc8; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 18D61C003FD;
	Sat, 18 Oct 2025 02:02:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6E85360701;
	Sat, 18 Oct 2025 02:02:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E652102F2374;
	Sat, 18 Oct 2025 04:02:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760752956; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ikMUTSdUdPHc35mX+I2cW0QqiGa0ceHwAYivaRjc9xM=;
	b=VirI7Bc8AUQ7wbT1JSe0bREwo5LKfew0qVq9FT2/5vrLTG8rf/A8zkBHdCRPKDBiJI32gf
	tRxDD3M0/Uxs4LKvps5KycxSakLWYUvoM5R3/CV08y9bLfJv8qiCQ5757LObSdjynWXsMX
	hnhdCaj3Xsr3eBMmkToEoVRwo76g2Y3FTPz26tn2XeL2V0bBd0KNBcBFrpDAJ/jEnl2/2A
	NrrvP0Y2Yl1flKZ/MfX84OQrbotNbHKLgS4wTtwoZWL60sQkZfsWbca/9M0sH/X5h5PksE
	LlT6uy3tpgpahaSLSECmlXMHZ6h+LGhouaR7Un7goyBflBy67SovRS9kMFKPLg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 18 Oct 2025 04:01:22 +0200
Subject: [PATCH 22/22] drm/vkms: Allows the creation of connector at
 runtime
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251018-vkms-all-config-v1-22-a7760755d92d@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9690;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=l0QqTuIRUdCVYpHuUyY5RP2VDM8HCO8Ik2svVn7zny8=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBo8vT/mFddf9A8YjhbEe8wcx3NUxmkZviyUae4u
 I95Mwj5bEqJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaPL0/wAKCRAgrS7GWxAs
 4uOwEADEu1Us9VwD4VF/tUT1WC91mutz7Oot30nLy2TzNR3G6wmbdMWvurGdN4SxqFAgm5tSB9O
 3hif+vWd1LOzXmJqWAwu4j24C9LqnhNEn7Db38BF1q6px1J69b4OBr6GPQCi+QxG8hbkWbKJT8W
 kmPaAiSW5JBB91sBF7eHQ8si5Ms36FY/fgO9FXj0h4jVaSc5cYV/BjGEg39W2qY3rYbh949yrNS
 TzJUmi5edM9z/hJSttblq+AnoC9cQk/MHpbIkrhBFuM3bgKSZ9OpJn/c3SjpXgu+++MZc9mNRfm
 Nha16RIaFZAoDo+6tV81z1KNduUiJUb7s2CMSaqjzNP4e0nzsgbNXwnwD0TzbfGPRgjT7pNSloL
 fKqXeScqk1DVcrfStkYV09QDR5mgBuId0O27TUKeJG526M9pLSDYvcUsccbM60TGHOWTgrxwlCk
 nTKx0QGkIDvGOL6jS/NAYnDvXRiTUObBK2Ee9c58Jc8NKS9CS4uZ3bQCJ7tpi57wo0/y5yY2ktK
 aOrZKOU3BPuWywkh/VU+hPZ6Ybz8wfBwHmyk9gjL4oE/b2XsncrastFivmc5WM+DzMQE1piBLSV
 WbJ0uChY+oUzAQzIu1q4H6DOcrz8Ec1hSbaaEiFhbEG1YRrEaa/F3KM4+hOs8RnQcsNfy5DaSkg
 YODXwDEUHfGkzuQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

DRM allows the connector to be created after the device. To allows
emulating this, add two configfs attributes to connector to allows this.

Using the dynamic attribute you can set if a connector will be dynamic or
not.
Using the enabled attribute, you can set at runtime if a dynamic connector
is present or not.

Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst           |   6 +-
 drivers/gpu/drm/vkms/vkms_configfs.c | 146 ++++++++++++++++++++++++++++++++---
 2 files changed, 139 insertions(+), 13 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index bbd03f61e61c..8b17aaa28eeb 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -135,7 +135,7 @@ Last but not least, create one or more connectors::
 
   sudo mkdir /config/vkms/my-vkms/connectors/connector0
 
-Connectors have 5 configurable attribute:
+Connectors have 7 configurable attribute:
 
 - status: Connection status: 1 connected, 2 disconnected, 3 unknown (same values
   as those exposed by the "status" property of a connector)
@@ -147,7 +147,9 @@ Connectors have 5 configurable attribute:
 - edid_enabled: Enable or not EDID for this connector. Some connectors may not have an
   EDID but just a list of modes, this attribute allows to disable EDID property.
 - edid: Content of the EDID. Ignored if edid_enabled is not set
-
+- dynamic: Set to 1 while configuring the device to create a dynamic connector. A dynamic
+  connector can be used to emulate DP MST connectors.
+- enabled: For dynamic connector, set it to 1 to create the connector, 0 to remove it.
 
 To finish the configuration, link the different pipeline items::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index a977c0842cd6..937b749142ad 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1115,8 +1115,12 @@ static ssize_t connector_status_store(struct config_item *item,
 	scoped_guard(mutex, &connector->dev->lock) {
 		vkms_config_connector_set_status(connector->config, status);
 
-		if (connector->dev->enabled)
-			vkms_trigger_connector_hotplug(connector->dev->config->dev);
+		if (connector->dev->enabled) {
+			if (connector->config->dynamic && connector->config->enabled)
+				vkms_trigger_connector_hotplug(connector->dev->config->dev);
+			if (!connector->config->dynamic)
+				vkms_trigger_connector_hotplug(connector->dev->config->dev);
+		}
 	}
 
 	return (ssize_t)count;
@@ -1176,8 +1180,12 @@ static ssize_t connector_type_store(struct config_item *item,
 	}
 
 	scoped_guard(mutex, &connector->dev->lock) {
-		if (connector->dev->enabled)
-			return -EINVAL;
+		if (connector->dev->enabled) {
+			if (connector->config->dynamic && connector->config->enabled)
+				return -EBUSY;
+			if (!connector->config->dynamic)
+				return -EBUSY;
+		}
 		vkms_config_connector_set_type(connector->config, val);
 	}
 
@@ -1293,6 +1301,102 @@ static ssize_t connector_edid_store(struct config_item *item,
 		    connector_status_disconnected)
 			vkms_trigger_connector_hotplug(connector->dev->config->dev);
 	}
+	return count;
+}
+
+static ssize_t connector_enabled_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	bool enabled;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock)
+		enabled = vkms_config_connector_is_enabled(connector->config);
+
+	return sprintf(page, "%d\n", enabled);
+}
+
+static ssize_t connector_enabled_store(struct config_item *item,
+				       const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
+	bool enabled, was_enabled;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+	connector_cfg = connector->config;
+
+	if (kstrtobool(page, &enabled))
+		return -EINVAL;
+
+	if (!connector->dev->enabled) {
+		vkms_config_connector_set_enabled(connector_cfg, enabled);
+	} else {
+		// Only dynamic connector can be enabled/disabled at runtime
+		if (!connector_cfg->dynamic)
+			return -EBUSY;
+
+		was_enabled = vkms_config_connector_is_enabled(connector_cfg);
+		vkms_config_connector_set_enabled(connector_cfg, enabled);
+
+		// Resulting configuration is invalid (missing encoder for example)
+		// Early return to avoid drm core issue
+		if (!vkms_config_is_valid(connector->dev->config)) {
+			vkms_config_connector_set_enabled(connector_cfg, was_enabled);
+			return -EINVAL;
+		}
+
+		if (!was_enabled && enabled) {
+			// Adding the connector
+			connector_cfg->connector = vkms_connector_hot_add(connector->dev->config->dev,
+									  connector_cfg);
+			if (IS_ERR(connector_cfg->connector)) {
+				vkms_config_connector_set_enabled(connector_cfg, was_enabled);
+				return PTR_ERR(connector_cfg->connector);
+			}
+		} else if (was_enabled && !enabled) {
+			vkms_connector_hot_remove(connector->dev->config->dev,
+						  connector_cfg->connector);
+		}
+	}
+	return count;
+}
+
+static ssize_t connector_dynamic_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	bool enabled;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		enabled = vkms_config_connector_is_dynamic(connector->config);
+	}
+
+	return sprintf(page, "%d\n", enabled);
+}
+
+static ssize_t connector_dynamic_store(struct config_item *item,
+				       const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
+	bool dynamic;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+	connector_cfg = connector->config;
+
+	if (kstrtobool(page, &dynamic))
+		return -EINVAL;
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		// Can't change the dynamic status when the device is activated
+		if (connector->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_connector_set_dynamic(connector_cfg, dynamic);
+	}
 
 	return count;
 }
@@ -1302,6 +1406,8 @@ CONFIGFS_ATTR(connector_, type);
 CONFIGFS_ATTR(connector_, supported_colorspaces);
 CONFIGFS_ATTR(connector_, edid_enabled);
 CONFIGFS_ATTR(connector_, edid);
+CONFIGFS_ATTR(connector_, dynamic);
+CONFIGFS_ATTR(connector_, enabled);
 
 static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_status,
@@ -1309,19 +1415,28 @@ static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_supported_colorspaces,
 	&connector_attr_edid_enabled,
 	&connector_attr_edid,
+	&connector_attr_dynamic,
+	&connector_attr_enabled,
 	NULL,
 };
 
 static void connector_release(struct config_item *item)
 {
 	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
 	struct mutex *lock;
 
 	connector = connector_item_to_vkms_configfs_connector(item);
+	connector_cfg = connector->config;
 	lock = &connector->dev->lock;
 
 	scoped_guard(mutex, lock) {
+		if (connector->dev->enabled && connector_cfg->dynamic && connector_cfg->enabled)
+			vkms_connector_hot_remove(connector->dev->config->dev,
+						  connector_cfg->connector);
+
 		vkms_config_destroy_connector(connector->config);
+
 		kfree(connector);
 	}
 }
@@ -1340,6 +1455,7 @@ static int connector_possible_encoders_allow_link(struct config_item *src,
 						  struct config_item *target)
 {
 	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
 	struct vkms_configfs_encoder *encoder;
 	int ret;
 
@@ -1347,16 +1463,25 @@ static int connector_possible_encoders_allow_link(struct config_item *src,
 		return -EINVAL;
 
 	connector = connector_possible_encoders_item_to_vkms_configfs_connector(src);
+	connector_cfg = connector->config;
 	encoder = encoder_item_to_vkms_configfs_encoder(target);
 
 	scoped_guard(mutex, &connector->dev->lock) {
-		if (connector->dev->enabled)
-			return -EBUSY;
+		if (connector->dev->enabled && connector_cfg->enabled) {
+			if (!connector_cfg->dynamic)
+				return -EBUSY;
+			ret = vkms_connector_hot_attach_encoder(connector->dev->config->dev,
+								connector->config->connector,
+								encoder->config->encoder);
+			if (ret)
+				return ret;
+		}
 
 		ret = vkms_config_connector_attach_encoder(connector->config,
 							   encoder->config);
+		if (ret)
+			return ret;
 	}
-
 	return ret;
 }
 
@@ -1394,9 +1519,6 @@ static struct config_group *make_connector_group(struct config_group *group,
 	dev = child_group_to_vkms_configfs_device(group);
 
 	scoped_guard(mutex, &dev->lock) {
-		if (dev->enabled)
-			return ERR_PTR(-EBUSY);
-
 		connector = kzalloc(sizeof(*connector), GFP_KERNEL);
 		if (!connector)
 			return ERR_PTR(-ENOMEM);
@@ -1409,9 +1531,11 @@ static struct config_group *make_connector_group(struct config_group *group,
 			return ERR_CAST(connector->config);
 		}
 
+		vkms_config_connector_set_dynamic(connector->config, connector->dev->enabled);
+		vkms_config_connector_set_enabled(connector->config, !connector->dev->enabled);
+
 		config_group_init_type_name(&connector->group, name,
 					    &connector_item_type);
-
 		config_group_init_type_name(&connector->possible_encoders_group,
 					    "possible_encoders",
 					    &connector_possible_encoders_group_type);

-- 
2.51.0


