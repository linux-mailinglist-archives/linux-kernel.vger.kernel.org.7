Return-Path: <linux-kernel+bounces-876209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C03C1B67D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006EE584A57
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AE4350A0B;
	Wed, 29 Oct 2025 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YQD5QWWM"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97234F47C;
	Wed, 29 Oct 2025 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744669; cv=none; b=Mois2wZWFROwX0BRqBYfNvq8W0+tvHx47eSrHf+4yCUGMXIrh45YQcsDB92qQ4kr2+ganZRpzldF/8pFLm5TAqqlCspliTBb1D5bNiUTaXlSjiNm9JX/Iqw31cpa5j3otL50MUuPtGkQ2jW0zJcIa1gccd3vO91l73ZqN7qezWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744669; c=relaxed/simple;
	bh=0+98kTspyGPOT1vZSC+v8rAN3ugo7Kzz9vOSVYqHbkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7wkERSXbAavUV8Y72ip/JSTjo9MKSB7qKNHHFK0FD9bMS4xfi6W+PUcsdU+r3OS/V58ontFfKrJQIyMrCQHxXPNGKXT7KxZ5CaQWEei8Ggx40O0zPDpkUFjp7JmlHgjjD2M310jDuTJxbPWK72ODE0oX1PmWxKlQPm9lLKj+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YQD5QWWM; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2F178C0DB02;
	Wed, 29 Oct 2025 13:30:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 86FAC606E8;
	Wed, 29 Oct 2025 13:31:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FC93117F80A2;
	Wed, 29 Oct 2025 14:31:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744665; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xS/1Ec3oJHE02YD4Fccj9Q73h4DqLCBWTIm+KKVpV/4=;
	b=YQD5QWWMVoYwXYhkpB9Iwr3sha+mebpK6hNsDwENpjcmO1G65Ct7CCjSHlpfDKby+5Jell
	HpMhK/pCwk0pJtGvTXDdSaqfSL2uU7kYqKKEmC239GBYslc/IrBJ3532VXsylYBorve+Qd
	N88hzOVnp7tlUE1lhGK5SCqzmM2aGjdkhsjRq8U06T71TXPz6+3th4dqm9YRB4nra0i7su
	ygyuVuQHuZt9nGruMkvXT41bAc7w49yJAYxnbIvbnGuDbYqtVezeo75R6PPHEzrNDHEqM3
	psul5Fhn7nC4T5xXkT0Ixs3A9SbzbpbUvDh8JTrfhgPtheOSF4X2cDDty8JUKw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:34 +0100
Subject: [PATCH v2 24/32] drm/vkms: Introduce config for connector
 supported colorspace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-24-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6028;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=0+98kTspyGPOT1vZSC+v8rAN3ugo7Kzz9vOSVYqHbkY=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbr5cftV6WPMOehVKQezeU6wtwH2PLp2jNe4
 JyjilbxWW2JAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6wAKCRAgrS7GWxAs
 4rAiEACiqIjp7EGAQKkjH2sUuLjwKV+Kwf5eod93ct5gkiAUCLIMUJ5dvot5PbEWwTrcU+cCfQH
 U+grWxtgs+M2iiLQRwNKX4zgHMqFYXnBqrxSUypCE4SA7LUP6hYCmJDyzO1MlKqbxDeORbZvoHi
 X2CriYROGOw0jVB7M5dS3MMlA99wvzu26DZxKLyhvaijqdIHqpIDP9mVVPP/V/vWaqIKCKQT6Dx
 xNeAW8u5vqvv1haShwI0QfiF5UwE28vhontwNlm8ASP9/efZFVf/vV2kIQXti67lKSH+qbQrKur
 FNDcWLh10F7OSaolOKYhHBxbpL0LiuABbFH8s+XUYUaCwbd9bbk9Q40329XMkPB7E1xoIcuwl+q
 s76e39u4d09ryJ9owNqw0HWpX+klN8QVBr3bRfyhTgAi0bt9hS1Q+pmJw6DpSqTAU5th+1TmMbV
 t534s81/wuhLcTZoVGMcBorh7rKrBHpGjXZYI+Uh1bN+sHPIdXJ33k5qzR7ACd0LGPhWu4olWWv
 3xERcOsy4WwlHW8pQ42VPtvEiawDWN5Awl1tUVlEeRCKpC71y7eYS+7KFv0uaPe/V1U/juVGaMm
 2N1QDiFwhsHkMFCYsshIcPKm1NL2j3pg1quQqgtxKbPRhQ0Bha8+PUqOhw5lfTXfRNB9y4+lsW8
 oZC4309Wz2plu1g==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

To emulate some HDR features of displays, it is required to expose some
properties on HDMI, eDP and DP connectors.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  3 +++
 drivers/gpu/drm/vkms/vkms_config.c            |  5 +++++
 drivers/gpu/drm/vkms/vkms_config.h            | 30 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c         | 15 ++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index c8b885306eed..e0ceecf2e2dd 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -202,6 +202,9 @@ static void vkms_config_test_default_config(struct kunit *test)
 	vkms_config_for_each_connector(config, connector_cfg) {
 		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_type(connector_cfg),
 				DRM_MODE_CONNECTOR_VIRTUAL);
+		KUNIT_EXPECT_EQ(test,
+				vkms_config_connector_get_supported_colorspaces(connector_cfg),
+				0);
 	}
 
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 02e2f0249fb0..6f939b82c33f 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -590,6 +590,10 @@ static int vkms_config_show(struct seq_file *m, void *data)
 			   drm_get_connector_status_name(vkms_config_connector_get_status(connector_cfg)));
 		seq_printf(m, "\ttype=%s\n",
 			   drm_get_connector_type_name(vkms_config_connector_get_type(connector_cfg)));
+		seq_puts(m, "\tsupported colorspaces=");
+		show_bitfield(m, vkms_config_connector_get_supported_colorspaces(connector_cfg),
+			      drm_get_colorspace_name);
+		seq_puts(m, "\n");
 	}
 
 	return 0;
@@ -896,6 +900,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 	connector_cfg->config = config;
 	connector_cfg->status = connector_status_connected;
 	vkms_config_connector_set_type(connector_cfg, DRM_MODE_CONNECTOR_VIRTUAL);
+	vkms_config_connector_set_supported_colorspaces(connector_cfg, 0);
 	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
 
 	list_add_tail(&connector_cfg->link, &config->connectors);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 6a50ec7535af..d68133723444 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -131,6 +131,10 @@ struct vkms_config_encoder {
  * @type: Store the type of connector using DRM_MODE_CONNECTOR_* values
  * @config: The vkms_config this connector belongs to
  * @status: Status (connected, disconnected...) of the connector
+ * @supported_colorspaces: Bitmask of all the supported colorspaces. Values
+ *                         are the sames as ones accepted by
+ *                         drm_mode_create_hdmi_colorspace_property() and
+ *                         drm_mode_create_dp_colorspace_property()
  * @possible_encoders: Array of encoders that can be used with this connector
  * @connector: Internal usage. This pointer should never be considered as valid.
  *             It can be used to store a temporary reference to a VKMS connector
@@ -143,6 +147,7 @@ struct vkms_config_connector {
 
 	int type;
 	enum drm_connector_status status;
+	u32 supported_colorspaces;
 	struct xarray possible_encoders;
 
 	/* Internal usage */
@@ -241,6 +246,31 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
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
+vkms_config_connector_get_supported_colorspaces(const struct vkms_config_connector *connector_cfg)
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


