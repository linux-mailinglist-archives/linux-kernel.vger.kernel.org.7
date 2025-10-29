Return-Path: <linux-kernel+bounces-876212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0258BC1AE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BCE1C20495
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84D7350D71;
	Wed, 29 Oct 2025 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Tc4Ckwgw"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647CE350A34;
	Wed, 29 Oct 2025 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744675; cv=none; b=mBRwcvKwGBInervxRyXWYFjxs/FpOz8NxIkY2JuooMeUFbEgSgLY6ixu7kLBtVHQJCO15yqbkcMIHQ8jVndoBS9py50fGXaU1F2bI9NevCIm9wSa722DoWEKJXg7XDYnoCWsGWOE9D21neMjhuyuoxr9SxP+tlCKK2xIcrL21WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744675; c=relaxed/simple;
	bh=cfHMITCkhuA9xDg6rR5Pf2S96MFpLvOh5N7v63PxojQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EIirqWxvDaPp16Axc2arGb/rOimwrV6Si1xE9QzEc/D3HYtYHxro8XC/77uPVc4CJWvBRYnfXTfbZV4ZwmwkheF9+2SsQKD6zGtWkZdjmN6swT0VJ3vGekYacdacHak5iGXVCsLXv7Su5AMdO/zMF5RkPIbjhf0SR4vOt8jz1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Tc4Ckwgw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 630D0C0DB01;
	Wed, 29 Oct 2025 13:30:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B9A71606E8;
	Wed, 29 Oct 2025 13:31:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8AA1F117F809A;
	Wed, 29 Oct 2025 14:31:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744670; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zs7cFfDnZhyAxSYFH45RdpuYGVq+BUPOPTG7RxnjHZc=;
	b=Tc4CkwgwOlr5qnKvcniqzIXc3OcSYP3MXAWryIKLsyoC4IdcokIckFkjpT5j3Bn+VImeW0
	rxg8GXyOl5C6J2C0P0qQ9uqL2njU+a1ONr1aagUOuHO2KQfrv8QWiPrDuCFQdN9taDs7sH
	PO/jMsZKIkpjikRyq44iCJmjZFzkyq5x8g84hMYdBPCY3qxD1tPdngfVYaEVVH42jlBGLE
	5hiY8uDaFBqf863ODT1HN36jdhF45TyfvGrLpMfnIF794KgfeqmGFt3fKF68SS+AZ6RbKb
	AUoC/5e59FqzupDIrda9UaygkjO6dn+Ty4Rkp+7HlxrHReVpc3ZSG/aAwNmXig==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:37 +0100
Subject: [PATCH v2 27/32] drm/vkms: Introduce configfs for connector EDID
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-27-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5286;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=cfHMITCkhuA9xDg6rR5Pf2S96MFpLvOh5N7v63PxojQ=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbsh0HPuDufJv/gUgLtQvOv2SdN/v1M2Tpue
 bJQ7dfWa3SJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW7AAKCRAgrS7GWxAs
 4jVmD/9CYGR3BZu6d9UBIEyctto9HZIBajWjuQ/miv6ESZOphSSoxWGUOEZXrWEtsgRtYB0j1kA
 D0YqcCDQQx27r+L4Fw0M4eGqklgrvatxzeg5pq8ZZWDLKU0fxXGkTDfUwEzuPgxfgTKNITl7VvZ
 EDioZcnd4aHcWISv8a5XfBBDvlNixWoMl0ygIqiONtzjCEczCs7YR3j+sFedrv7+DP4o+Cs7Wkd
 fFNf9mXIe7o0vi2HxmHpsu3kARK4gbMYVmstOCax/hRYV4k3bLZkOmpLTvLc4dgpBk/r22882EB
 1J2lO3ZK8aMJpFFQD0elw5LmMiBX18Gcn5FVhj/9OJrg+DfTTUQH/r3MLqED9fR0BpE4COKDx55
 XoiEIju6BCTls2cV2JZ4NWTZkzqtLsM8JQXmGwgTzy6/D6CM7oHIDrgWfjRwYtnrqYUt7ZjweBU
 Ik9d0zcqn3D94kcmNSozuEKeQWswPmzKQejvnzuoBW/dOKpxPnPVKcQ1YXcZqHHMIfNjEW75DFo
 KbkdLLHI4mNHWEOU//mBrSfOsxM7siEjI1mEEMXXYFEbPonNXqYv5ra91n5ohQ6VbrfdI5Ii77e
 k2PTOQXMzhGusQ5V5ohBFYrIKPXKKCSwrFg0UcX3BQEu3X7b1NQmAWjV9dcyslcF35tkvFXzQ7W
 YfwyraNsHYmPLVQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Introduce new attributes to configure EDID of a connector:
- edid_enable - chose if the connector will have an EDD or not
- edid - raw edid content

Due to limitation of ConfigFS, the max len of EDID is PAGE_SIZE (4kB on
x86), it should be sufficient for many tests. One possible evolution is
using a ConfigFS blob to allow bigger EDID.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst            |  5 ++-
 drivers/gpu/drm/vkms/vkms_configfs.c  | 80 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c |  3 ++
 3 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index c762cadac6f4..0cc7897d7b83 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -138,7 +138,7 @@ Last but not least, create one or more connectors::
 
   sudo mkdir /config/vkms/my-vkms/connectors/connector0
 
-Connectors have 3 configurable attribute:
+Connectors have 5 configurable attribute:
 
 - status: Connection status: 1 connected, 2 disconnected, 3 unknown (same values
   as those exposed by the "status" property of a connector)
@@ -147,6 +147,9 @@ Connectors have 3 configurable attribute:
   If supported_colorspaces is not 0, the HDR_OUTPUT_METADATA will also be created.
   Value is a bitfield, 0x1 = NO_DATA, 0x2 = SMPTE_170M_YCC... see enum drm_colorspace
   for full list.
+- edid_enabled: Enable or not EDID for this connector. Some connectors may not have an
+  EDID but just a list of modes, this attribute allows to disable EDID property.
+- edid: Content of the EDID. Ignored if edid_enabled is not set
 
 
 To finish the configuration, link the different pipeline items::
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index a7f4589403ce..1843e5d9e1e1 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1260,14 +1260,94 @@ static ssize_t connector_supported_colorspaces_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t connector_edid_enabled_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	bool enabled;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock)
+		enabled = vkms_config_connector_get_edid_enabled(connector->config);
+
+	return sprintf(page, "%d\n", enabled);
+}
+
+static ssize_t connector_edid_enabled_store(struct config_item *item,
+					    const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
+	bool enabled;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+	connector_cfg = connector->config;
+
+	if (kstrtobool(page, &enabled))
+		return -EINVAL;
+
+	scoped_guard(mutex, &connector->dev->lock)
+	{
+		vkms_config_connector_set_edid_enabled(connector_cfg, enabled);
+
+		if (connector->dev->enabled &&
+		    vkms_config_connector_get_status(connector_cfg) !=
+		    connector_status_disconnected)
+			vkms_trigger_connector_hotplug(connector->dev->config->dev);
+	}
+	return count;
+}
+
+static ssize_t connector_edid_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock)
+	{
+		unsigned int len = 0;
+		const u8 *edid = vkms_config_connector_get_edid(connector->config, &len);
+
+		memcpy(page, edid, min(len, PAGE_SIZE));
+		return min(len, PAGE_SIZE);
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t connector_edid_store(struct config_item *item,
+				    const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock)
+	{
+		vkms_config_connector_set_edid(connector->config, page, count);
+
+		if (connector->dev->enabled &&
+		    vkms_config_connector_get_status(connector->config) !=
+		    connector_status_disconnected)
+			vkms_trigger_connector_hotplug(connector->dev->config->dev);
+	}
+
+	return count;
+}
+
 CONFIGFS_ATTR(connector_, status);
 CONFIGFS_ATTR(connector_, type);
 CONFIGFS_ATTR(connector_, supported_colorspaces);
+CONFIGFS_ATTR(connector_, edid_enabled);
+CONFIGFS_ATTR(connector_, edid);
 
 static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_status,
 	&connector_attr_type,
 	&connector_attr_supported_colorspaces,
+	&connector_attr_edid_enabled,
+	&connector_attr_edid,
 	NULL,
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 339d747e729e..699b6779a46c 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -141,6 +141,9 @@ struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
 
 	drm_connector_helper_add(&connector->base, &vkms_conn_helper_funcs);
 
+	if (vkms_config_connector_get_edid_enabled(connector_cfg))
+		drm_connector_attach_edid_property(&connector->base);
+
 	return connector;
 }
 

-- 
2.51.0


