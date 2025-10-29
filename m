Return-Path: <linux-kernel+bounces-876395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0559C1B738
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFFCA569764
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF653347FC6;
	Wed, 29 Oct 2025 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zhEyh2Wc"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5A346A11
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748663; cv=none; b=GKqnd2eNjFiiIgc9woq09s+pR9iJlyFVLLFCE2BqI2dt/Jgi5igZfHNh2XF1k2nM7hj0qxR/q83HHaOfkkQ24t1D0CB3RdswGJrahy+vzZWvIiuHIkCP0cIXUyeJu0fNAq39slz26+rUTpalu3XLDqwsyhq4U/qHfZBl1LtAv78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748663; c=relaxed/simple;
	bh=cfHMITCkhuA9xDg6rR5Pf2S96MFpLvOh5N7v63PxojQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r27dkEpqnRs6q+4b1akmrd4ruBAnRqMirBKY58RzOdy4vSAcBuioceYgYee1HNUzaC4N93A1ZKsVhJXdazAoth5UI1pEJrFKjot0roIhYUW6TzPM13BJcYJ+Ewx5wOTdXGG1sw1OkMf3qPNjChvKsuTAg08iWaQm46CXUn+TnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zhEyh2Wc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 62CE04E413CF;
	Wed, 29 Oct 2025 14:37:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 33FBD606E8;
	Wed, 29 Oct 2025 14:37:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3DB12117F81B5;
	Wed, 29 Oct 2025 15:37:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748658; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zs7cFfDnZhyAxSYFH45RdpuYGVq+BUPOPTG7RxnjHZc=;
	b=zhEyh2Wc3M22YiW14zB+NlN4hmLGR8Csix5S4OMutycu4eMw2nxZZOVTB2H9SX0tz/Yx8c
	WeyXa4wrzXSNbHmFzEVO2SJ1LdtGoTgcggoe64uU/Pr6mR0i0iObGd4sriLp7lM34Ie0Ai
	cGpSZMrSqHHr4n53aUaL1CO0RmjFkcxtZF7Mslnim8rbdQRY22iDMQL8nNbXuy4IHLIU6C
	LvyHKUdr1UNfIhUxaifHIxx43ilpxM+KhONQRBE/Oqp8Kvu/++0UUmEP+9R0urWsjIDZEI
	dFbgQaL+Qjpa81mfyXlVfVz13xjCoHIYfy7zUWwadypXORHDZTuQCRbOUOiFag==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:37:04 +0100
Subject: [PATCH RESEND v2 27/32] drm/vkms: Introduce configfs for connector
 EDID
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-27-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5286;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=cfHMITCkhuA9xDg6rR5Pf2S96MFpLvOh5N7v63PxojQ=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ9QZXTe3vOpXepw9nuYtb3Y4yisFW2olhnp
 SZA+trfPaWJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImfQAKCRAgrS7GWxAs
 4hxDD/4y5QG7UGhC3l9vvaNlm2b2jriMyxoU2wTRUnnQbyKYIO/Y3SWTYJg7xu3gZUSFSbT3wRB
 T+kCRh9S/aTQvhtqdlr/3wVJQ2KcNHv4z1r5ZUJhCW84+KP0+P5uBh+HJ7TMKdqzeXyTUjXyYlx
 XItkpZTU4lW7q0yGTVGn/rUAXPy4N3b8+ACSG+uUhrICqiqXJfok4VS7tDihbSrk5U+54v7y49q
 rlOhFcQ5NEvesYQjThdEfA0OqPHSaEfn/Vk3WcbUOX4eThGyKDDiuZCSaUnB66RvFJh+MdDnYSf
 uqjeXfeXGrBMJQ/c7K7QgiS9W/Gx1eQnw1wT9wWP9psR9vnSir8Jq6HwRm5T0gARZ/dHuOvCE16
 6PvAuQrLgDglYzWO/iKUKNdT6a3er5TF4BT12hyXLIsBE6EGxB63DIchi5lo7hyqRJyz3pPzvsT
 c1gN+VQhzThoBaNB5Ctfq+rfGTRXMIVhUsGoh9xM98GgYb2jql9qOdYGfptURunVRjfUdREpa3T
 u149TCN1GOdPq89nGtq7IqJorWuwIt2fKGNTZSPjbup+CUtVghOgPKjlBEcHYSwDa84pKGuOjMD
 BsagDPkJ2nnPykxMBjVwoh7O4BzedGvcQ37j++eSDJ2dMbc1GOom9pCE9oYkp998Lw886cBniZq
 RJ6WoRG2V4BLTfQ==
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


