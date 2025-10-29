Return-Path: <linux-kernel+bounces-876390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F1FC1B8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63EF95C920A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B55133F38A;
	Wed, 29 Oct 2025 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1ZT8Wp7I"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7FC33B6FF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748652; cv=none; b=pm5LqdnIBESTsZZhZZ7tTA89Zt71PBBDUAvBVKx8+aR5u+EZRGwOviuLqwnHt9hcEqMfVPT/v2+EJjejn9bfj/v2wdmVj40Dszt80RB925NKUcB/L5Qbu6h3dGycjCuVaEK0r5KGA0hyLck8sK9XBcyJTR+lpkkLRGoXkQKg9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748652; c=relaxed/simple;
	bh=LUx3WgpJ+5BY9H52t76Y/Q40Ik9Sz02o7+/xgILTIdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eFJ87Inu6bnFyM4C394D1EiYM5fqVLrf4+W/bSj9lhg0Fv3fv8pism5WP3DTLSFk4kyO5lTzSN5ZHioOVhFVrcgUnotBIk7EgO83GdfVediBBVxKsEBzNYCHbw4svsNF8UDRzru/POnjUakU8cIt5brfAflVmRzZWzkgups+fFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1ZT8Wp7I; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5D6034E413CF;
	Wed, 29 Oct 2025 14:37:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 32F23606E8;
	Wed, 29 Oct 2025 14:37:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24ACB117F81B6;
	Wed, 29 Oct 2025 15:37:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748648; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TiSP9apTRMTQa/+Qm2OMWAOpekvvQHx/ArvOL/FMv3k=;
	b=1ZT8Wp7IhA0jpWViW/RL1lMvau22xIyx6MpyZ4NhS+GjZj7+EerXqiBfDrX56WW5EHyLes
	ccHEP4/sQvbyIumX/R/qYmutb7uJ9Hru9PZy7SnAmbkgpcXla2UfuRwdOv+wUoBAGYB5xl
	f/HkC6TDoYP7CDXczsslPF4gP353gtam5QoJUi6cJtdTrdQynxX8OdtY5rAXGTqzjjl3Ge
	K4VqmcKoPMckr4vd8uJ8cE+pZU0ovTPdob8l9R6GtyR5HL7iexHhSyG6u3FjoD4pxqLUxZ
	gPEj3opRcwPyUnfkLm80y/XmxC7zdk+K/VeT/6NO8Q3a9GYKpRt2tTJv6FW2og==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:36:59 +0100
Subject: [PATCH RESEND v2 22/32] drm/vkms: Introduce configfs for connector
 type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-22-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3281;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=LUx3WgpJ+5BY9H52t76Y/Q40Ik9Sz02o7+/xgILTIdY=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ9E+Gt4xDUfca6oSRjlO9l81jkjGC5fN41Q
 wZPk4xKYW+JAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImfQAKCRAgrS7GWxAs
 4tiVD/95NgwtNTW58Dw5zlRj9WzngKn1GBaAFI+2AWbj0K5+yYiR4XoX6KIjCh62WRWxvIRP6ku
 0DhCJ+Lt8h8WZ09G1tk+q8SyuHgxoILusiIjbVF3WI2ZVb9Dmrj+hEmFZpdqLtZIcoZNAL07Yk+
 6vGL8paQ5O6F4NyjF0/3B/YHJ0MCryiFytm9C5RPC7fBxOm5PV9IABmfjylrsZEC89ZiuBxbTmE
 EayYkekH8p6Ij8uGPnwH1k2gtdXYXtrHDj6ZrlhGbwvzXammcPahHrtG1bU/s8xH9WbWmS+6wjm
 Ch43jSMMZqdf+iMzjVrG2h73Br0/qvPIqqqqMbBOr6k+ZUOk9ZLYrTnhXX2sBXFItwKHNrSJaPF
 /2V3h6b2GbSelVVTRxuAYWjGoE22zEANXyIYg4pQ7o9XEIewtPugar2JgswpCtJ7YsUwA2B9A6o
 p2DhUYJG0UkRgv0XlvQ0oJMnJbq1OPLJzxgRvINka/sdhvpK0fiZTK/XGwXqC2Kltcw6/UKSL//
 oxV5Z7/e5sT0Cyo69CDUDuALkP+VPJ+j8FZ2icCCGCDRqbLviSs9Atlurf98Tt8SYabJagR9LRI
 lJcq3BHHwFQm9xLWGv2HauxriIeOtGekElAT7dTu/NEfeZKDSLUzDf76OthN0SiVtfyfVmraSOK
 KXS9xksk+54w0sQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Add a new attribute to connector to change its type. This is mostly
cosmetic and don't have direct effect in VKMS behavior.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst           |  3 +-
 drivers/gpu/drm/vkms/vkms_configfs.c | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 32858f9a3357..99c5cf3dbd78 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -138,10 +138,11 @@ Last but not least, create one or more connectors::
 
   sudo mkdir /config/vkms/my-vkms/connectors/connector0
 
-Connectors have 1 configurable attribute:
+Connectors have 2 configurable attribute:
 
 - status: Connection status: 1 connected, 2 disconnected, 3 unknown (same values
   as those exposed by the "status" property of a connector)
+- type: Type of connector. Same values as exposed by the "type" field in drm_connector.
 
 To finish the configuration, link the different pipeline items::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 1c0a6ecf2f29..b03e9af569b6 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1161,10 +1161,74 @@ static ssize_t connector_status_store(struct config_item *item,
 	return (ssize_t)count;
 }
 
+static ssize_t connector_type_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	int type;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		type = vkms_config_connector_get_type(connector->config);
+	}
+
+	return sprintf(page, "%u", type);
+}
+
+static ssize_t connector_type_store(struct config_item *item,
+				    const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+	int val, ret;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	ret = kstrtouint(page, 10, &val);
+
+	if (ret)
+		return ret;
+
+	switch (val) {
+	case DRM_MODE_CONNECTOR_Unknown:
+	case DRM_MODE_CONNECTOR_VGA:
+	case DRM_MODE_CONNECTOR_DVII:
+	case DRM_MODE_CONNECTOR_DVID:
+	case DRM_MODE_CONNECTOR_DVIA:
+	case DRM_MODE_CONNECTOR_Composite:
+	case DRM_MODE_CONNECTOR_SVIDEO:
+	case DRM_MODE_CONNECTOR_LVDS:
+	case DRM_MODE_CONNECTOR_Component:
+	case DRM_MODE_CONNECTOR_9PinDIN:
+	case DRM_MODE_CONNECTOR_DisplayPort:
+	case DRM_MODE_CONNECTOR_HDMIA:
+	case DRM_MODE_CONNECTOR_HDMIB:
+	case DRM_MODE_CONNECTOR_TV:
+	case DRM_MODE_CONNECTOR_eDP:
+	case DRM_MODE_CONNECTOR_VIRTUAL:
+	case DRM_MODE_CONNECTOR_DSI:
+	case DRM_MODE_CONNECTOR_DPI:
+	case DRM_MODE_CONNECTOR_SPI:
+	case DRM_MODE_CONNECTOR_USB:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		if (connector->dev->enabled)
+			return -EINVAL;
+		vkms_config_connector_set_type(connector->config, val);
+	}
+
+	return count;
+}
+
 CONFIGFS_ATTR(connector_, status);
+CONFIGFS_ATTR(connector_, type);
 
 static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_status,
+	&connector_attr_type,
 	NULL,
 };
 

-- 
2.51.0


