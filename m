Return-Path: <linux-kernel+bounces-876207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6437C1AEDF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 301C658747D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB3634EF03;
	Wed, 29 Oct 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SFJ1+IXg"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23996348877;
	Wed, 29 Oct 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744665; cv=none; b=o/6zpxSPqtcbEZbl4FJ3ZBbIWUr/B2DAeS4Kicc5cqlNKooORa+psWmhg79l16Pi6CQaNSTCnTPaUrLnSciY194/qR/rsrsqedt3co2LhtRncCGsYiaGBXZlBsj7HZZ01DPmQFE4gZuBHaYROI3c1jj98/q9HoDzaJVu3Te0KfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744665; c=relaxed/simple;
	bh=LUx3WgpJ+5BY9H52t76Y/Q40Ik9Sz02o7+/xgILTIdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIpoLSZVXn7zweWmKDwSZY1vg3ZF7sxzRyAdwOrjKkoOBlQiSeuj10dLaiBWrMjZUK3mwFGjlXzVPXi8K75eOpUAtWPHhp62xsVaI0JV3tC5AkaMZEe3mvVBIO6a0Wz+TGWM/kH5NKoYvyhEFYwAZibQWa68Av7iyTesjT/Sz/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SFJ1+IXg; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8E936C0DB00;
	Wed, 29 Oct 2025 13:30:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E35B1606E8;
	Wed, 29 Oct 2025 13:31:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7714117F80A1;
	Wed, 29 Oct 2025 14:31:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744662; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TiSP9apTRMTQa/+Qm2OMWAOpekvvQHx/ArvOL/FMv3k=;
	b=SFJ1+IXgGzZdn/sKastjsp4rPpjTT8efJI2eBlQN3KH/bvjas8GCYjSWzBym3BE5WuDacK
	G3P64CgesZTgmiI71buol0vDAtQw8c3AS/PnwWvzh1wuxF1yCbJesQxrl2WZU6ZKM8ciBn
	+7pbuQAtFuRWpfqy0/qDBHc0uB8gCqtHkb/4MVAxLn2ZJYBwYiG9VGd0YKRXmnsNRY770p
	tPMhldvXAkyWbVUOzVA2jUHgBJo/HdnvI9+rf8QMxhyOT/tFQ6ve1xZ84Isl7BnoVTFwVh
	yyb/OL5mvdSVziBESKEdXKyhpEgsxVHnurEGyN1T8JF8t8/CW8Mxa6pVWAZe6Q==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:32 +0100
Subject: [PATCH v2 22/32] drm/vkms: Introduce configfs for connector type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-22-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3281;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=LUx3WgpJ+5BY9H52t76Y/Q40Ik9Sz02o7+/xgILTIdY=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbrzftPuWCVBhOPaQZWdYU1MCCIu1yeDM14t
 oWibudteqyJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6wAKCRAgrS7GWxAs
 4nOzEACzKB9I1hsBPD3cz/cdvtoUFo3YysXlD7C3i2OLw3+U99nQGkzEr6+B8QMRAvKy/PCrnlu
 XPw1Yqxh1MQDLvcns7De4igEnbhV0eBZly8h2PIpHzDTUH/OwfDalMHXpTfqWDEgXIibSdXnGP1
 +i6Z56cNBtEi5AyQgAklTYqmLLq3e9ctAJ5Hws9PSWofrfpH5HCv0r+z0aFPx79A4kdrpcvOk3u
 8NNNUUJLJP9vrKLh0VvfR5N7//VHfuX2yOgxZqk4s2zFs/5BkX47ZbUaVfjGj11F+oBo4iwyPGr
 DsigKKvy3Yno6IiIrvzLmmt0/Ox+iIzUDT6yuMxAsSbGjv0gvTnqB90VKWHFTcLZx4A7Lhy4/Oj
 g2WR2zQA0jmIDvSBWi68mKC6h5NvUDOJnmaSE3mGrIlSm1PnXG4Bp4Q7vmBQd2M5766LuT68dJ+
 aQwO3r2jiLB1uJDk2bNWxFFFvoej5yQ8fVzel6RINNHTRpflTO2GQaxVbj3zNWBGXlp5N7f0G9k
 P8zMwcy5kWrV6TyZ7jsvybKj/ODCYPQWbbKVmz2F/4r+0X6hpuarWfZtYIhlT71pXAdefrAYHxV
 2TE9TNWtJeZoygXIe7kzAXpOS3Yr2yvEImTvfUDCALizjdwFrx09Gm0zLnptMxmScWL6zLo4FA9
 1VnFWtaXZMFqfZQ==
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


