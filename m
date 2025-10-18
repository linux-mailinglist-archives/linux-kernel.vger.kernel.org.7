Return-Path: <linux-kernel+bounces-858938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D898EBEC4BC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B34C44EE619
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3B024337B;
	Sat, 18 Oct 2025 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q1S3Rn7g"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8F523ED5E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760752945; cv=none; b=ILtxYElmnDIAqyOHxDAigk/wblx+hzo6/nhbryhODSQ6yFxa0JN1tp2utlIImMHoLNxiwFgddvYbiQhq5RGSPf12HOvUIYKfw3O0tWtL4hfNOlnPGbtmHvU2ox8/I8RsI5EIX16X0Ec9JPhMn9OxttN7R+mQtz1BM87zGjlGaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760752945; c=relaxed/simple;
	bh=UHrEecd+6C0vF0Cs7qQiOFJxWa/yui46MpN97PZb7A4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BhTD5Yt8ak0yxDzCdf6biUbbHV6tvmhQ4oSXVLoPbHHjAtdyE7DQUZqXq7/jFpudBzlwGsL2u4g+MDu7cxoSJcjxincZMJ+YTJP6UaWjvnkOxWSJIiD0WaxehkjrYnqIl1Me6cVDdTs+pzxEL7C9to3ts8ShC6BQTPlwCr4+qc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q1S3Rn7g; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0B532C041FD;
	Sat, 18 Oct 2025 02:02:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 60D6760701;
	Sat, 18 Oct 2025 02:02:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14D87102F236F;
	Sat, 18 Oct 2025 04:02:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760752941; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=etjMW6U4L5LchIOPFungAA/drZk/ZnoC4fdKX7Yq4YA=;
	b=Q1S3Rn7gqaBWbuZxYizgqUxqJ+nkwrlb3Le0Mr5XbvP60xwcaU7m9nrdQl0/Qg+y8g1g0b
	Rw37INj0oMkmKSkeqMCShbNLSrbGDAWJuEE8zMTq27Cxm0VCuz5gd/Fl+dAhETQ4sQuAz7
	wYmBIJeLpBmJnbV0PgeStEbyatFhoRaMxVUY16dOGHxEuhgkw1V+C12dT4n5SmEC1OZnBu
	0bSs3cylugvkapdjkKNCKvGlKgibONvw/e2wpCDaWryjaGQRpany5PUee3fWBoi/bJK85Q
	pUDxHPkhYGinpSxjNvZxdj1WX5YlsTeeMB1LHHfiFTyBNXNGz/uWpu11SgJu7A==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 18 Oct 2025 04:01:15 +0200
Subject: [PATCH 15/22] drm/vkms: Introduce configfs for connector type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-vkms-all-config-v1-15-a7760755d92d@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3281;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=UHrEecd+6C0vF0Cs7qQiOFJxWa/yui46MpN97PZb7A4=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBo8vT+M3oBga6pCnMTm4riIa8Zm2SKecDtdGm1J
 8SlFiQzjjqJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaPL0/gAKCRAgrS7GWxAs
 4ipeD/9qQfUEabrEd3JjdVzvcIiD4Tc9szZXhXtoIq3zCo/p769JUny/BTO9BOXwPmSTDuz4Vre
 omW/7EvBEgaUNtaGaEk+nOYUxTwN+FCQmiPDskpESwrlooYoodg5MaMzra8SpnClHDs0eB3r1f0
 OrKH7CciY+q9YiKYVyfGN/60f2LcKyZoUEvHG8ZkVg0L5gWhNA9HG+dnangEx4iH02H3ByIe2ze
 4V9Bolx8JYcx5CweajRdT1CgT247Y7En4Cwcak/LFwHqcnbD02LwFdulTZ8gtyaDByVKyZB4xJk
 XhNsS7EwHDpuBTfQkBBZXCyWq8IFpGzIkrz/bf9iVt+MuJzipxl5neiaZL8t+GGFtEkmTTFChvl
 JyrLW/WDjf4UCxmzmV55nUSEh6Fg+oGJXcxax0/Fd/blJOLmBd7x3OHVAOwssylgTZxWttd8tt3
 9hkKYrGnjvG+OKHB9SGWfKrw0uB2h3wW7MlvHolqEtF/v8xBmeUP0pGzQreNmAV9RHD2V5bRJ7E
 CFu9zNzWCpsKpU4d6gJnIiI05mSG6gNqk9Chbq+Z+rqb6265kWaaV7VQoIpuHoEfwuOxP0dmYqB
 yKJh9e813ikUIlFGRL1coIXXZBRo3DvPm2Qd/dAirsrUKvOE2zzfw/oiahEqmoEWZWB8OCM3tFB
 CprgVBwUXoLMjDg==
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
index d4ad4af45414..97ea11a86bd1 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -135,10 +135,11 @@ Last but not least, create one or more connectors::
 
   sudo mkdir /config/vkms/my-vkms/connectors/connector0
 
-Connectors have 1 configurable attribute:
+Connectors have 2 configurable attribute:
 
 - status: Connection status: 1 connected, 2 disconnected, 3 unknown (same values
   as those exposed by the "status" property of a connector)
+- type: Type of connector. Same values as exposed by the "type" field in drm_connector.
 
 To finish the configuration, link the different pipeline items::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index fd1be7292058..0cf7cee4eb0f 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1123,10 +1123,74 @@ static ssize_t connector_status_store(struct config_item *item,
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


