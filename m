Return-Path: <linux-kernel+bounces-876210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E3FC1B14B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A74D75A3EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17E2350A25;
	Wed, 29 Oct 2025 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JgqTkuzb"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789AD35028E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744671; cv=none; b=jkibYL1Adzsl49TYOtCZeIEaqQmoRNixv2gIRPztBTULxDn3Hf7LAHGy2630YPOJo1bzH3XWUQeXtPC0iX/cdoDslsnmDI8MwnJqwljLyzebzrA93Rft+DTVfMwF3x5zLdX2Uvgas01NjZE7nNvReVhuRSQIpUm6Oxb6tthRHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744671; c=relaxed/simple;
	bh=v5g2/tFW6cJCpWfZKG7ctdaqLbdAUNKogwWbJ6drI8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TS1KFmjQ+dg7BKBVm7CO151zUFXR9p+cubYkGeYZETGhBvQFbu95dRyxJ9uH6L4gQ1oSUR/l0kPNYmM9bXLaA7BUz0m3uezE6jH+40rSABEW6wOnxj3FsNVV2X8cRZZmKskFg6IOWr1w4r7tqvBCBB+5pu7LPbm/2zpMkt5Sh1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JgqTkuzb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F1E35C0DB01;
	Wed, 29 Oct 2025 13:30:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 54492606E8;
	Wed, 29 Oct 2025 13:31:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DFDA117F80A4;
	Wed, 29 Oct 2025 14:31:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744667; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/SkxqVl9RtXMg923ohzK0NptHaF/IbRJVg/+pganUWk=;
	b=JgqTkuzbY3+L1y0mmRxvnxair70GfxKsKxe9ukvPdT35B8K8ZnSyEZKl81nniOlv3fRXMc
	9mtRlROu7bg9P5lGMWZ42oNbMGPg6DOmMVkCaHI4LO0RuNFS82qNq2z/zqGiMMaWiKL/ZR
	nFWVzpoM7oZUYkR2rqK6kaV/KxSrLKBYf5lxyDA7GtqkSuD4R/v6iqqdDW6XS2JqEyvai+
	uf9U276bVIgNh+gHatUXwY4O9m6K+hM26Tx7n246tcmwrDsRy0r8zP/2bfcZYwXQRWJ4W2
	IfEPn/B7LFXWNrHWp9a+VC5IJUFR7d8BHb7H59Ft5Gaz7M1gd7oOaTNvkJQBPg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:35 +0100
Subject: [PATCH v2 25/32] drm/vkms: Introduce configfs for connector
 supported colorspace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-25-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3130;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=v5g2/tFW6cJCpWfZKG7ctdaqLbdAUNKogwWbJ6drI8c=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbspkryN96quLjbPBv5BqhaHOnB4SNSMUPht
 QUlwyjqQEyJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW7AAKCRAgrS7GWxAs
 4qC/EACtMtRnvfWj5jXVa99ay5thF0GydfJjj8vSHtXP9W0bv+ID6jmBFVrPr0vjHHuTScX14pW
 9M5ac22xHI6No2Gx+zqbcLojNWksTxgwUisVTZSH5fRsrnHQefoEMR2dbYf8K0Knc5LCwnapt1z
 F64BP+bx0apEGwx+/T7IFDmuvOZPQz8V8sN7Q8qIVx5ukayACg9wDKut8skdhn+y3GU/9GoJueH
 Bl1IcZxUpLBLLBSCWLQztQBefbn4qScB0/vYp8qTTiCeuipH2PIWaU2mPz9jj+Qpj4s766YjihB
 fvUfwZVPCYLH8jIOg4mAgECPw/woH+SDkfUgrLmp8HFqo40LaSYzT92sf6efQ0tyStD2DxKSPYT
 ZsPLbPwrtvuIKdycATdRUgOvdbKfmpKgMUKEpAHsRZ5WkAWc5snOxb/mSv5BYjC+fXN/k7dPyWK
 FBgfwk09SW/10WFsvTpKsUu8JcYxNokyug9v9SIZla/JxhJOymwEHTMv8SFZ/XjAMaR+Bxx6VJU
 NGZBXHp11x0xHsEMz8kTZ+8UMBd2LKYee0e2HjblZ6LgwstB4IYnHalzzKOn9yHNWuIBIbQ/9Dh
 haxmw6rc2F/EXYVaTt8LbnSLnP7/Zd4zuAzlnJzj9Rbx3yt5ffTa2wurddsW8R7t7rnQR1+uqk9
 vwD2CV7yqjyJBCA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Add the attribute supported_colorspaces to configure the supported
colorspace of a connector. It will allows emulating some HDR features of
displays. This feature is only supported for HDMI, DP and eDP connectors.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst           |  7 ++++++-
 drivers/gpu/drm/vkms/vkms_configfs.c | 39 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 99c5cf3dbd78..c762cadac6f4 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -138,11 +138,16 @@ Last but not least, create one or more connectors::
 
   sudo mkdir /config/vkms/my-vkms/connectors/connector0
 
-Connectors have 2 configurable attribute:
+Connectors have 3 configurable attribute:
 
 - status: Connection status: 1 connected, 2 disconnected, 3 unknown (same values
   as those exposed by the "status" property of a connector)
 - type: Type of connector. Same values as exposed by the "type" field in drm_connector.
+- supported_colorspaces: Supported colorspaces values for HDMI, DP and eDP connectors.
+  If supported_colorspaces is not 0, the HDR_OUTPUT_METADATA will also be created.
+  Value is a bitfield, 0x1 = NO_DATA, 0x2 = SMPTE_170M_YCC... see enum drm_colorspace
+  for full list.
+
 
 To finish the configuration, link the different pipeline items::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index b03e9af569b6..a7f4589403ce 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1223,12 +1223,51 @@ static ssize_t connector_type_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t connector_supported_colorspaces_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	int type;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock)
+		type = vkms_config_connector_get_supported_colorspaces(connector->config);
+
+	return sprintf(page, "%u", type);
+}
+
+static ssize_t connector_supported_colorspaces_store(struct config_item *item,
+						     const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+	int val, ret;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	ret = kstrtouint(page, 10, &val);
+	if (ret)
+		return ret;
+
+	if ((val & -BIT(DRM_MODE_COLORIMETRY_COUNT)) != 0)
+		return -EINVAL;
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		if (connector->dev->enabled)
+			return -EBUSY;
+		vkms_config_connector_set_supported_colorspaces(connector->config, val);
+	}
+
+	return count;
+}
+
 CONFIGFS_ATTR(connector_, status);
 CONFIGFS_ATTR(connector_, type);
+CONFIGFS_ATTR(connector_, supported_colorspaces);
 
 static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_status,
 	&connector_attr_type,
+	&connector_attr_supported_colorspaces,
 	NULL,
 };
 

-- 
2.51.0


