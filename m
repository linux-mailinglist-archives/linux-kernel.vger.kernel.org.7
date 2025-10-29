Return-Path: <linux-kernel+bounces-876215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B925C1AD10
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21E5934E411
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66700354AC2;
	Wed, 29 Oct 2025 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="krZNDUu8"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E28D350A34;
	Wed, 29 Oct 2025 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744681; cv=none; b=Dj64jCoMQEHyPNT9EDM60C3j/ZGV++Rl5FW0FK1d4D8V5vdq8kSTpPVfFjLJrI6PPxlwPHz/AcB+mi/orVCEsiui9zH7yodPssulep0K/Ju7yENeng2Mb+4j8XQNEryq9wUbLYri8fspYbXxLdzgdKHOvocqjGjUlpZ0WEz+PJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744681; c=relaxed/simple;
	bh=vHE+KXN44+uY83YhKjAEjkHqNWJmb39F47iujVDrYRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrbaCYm3qv4MUS2oBs4OUcBq2s6ixPfrGgjO6AIzjknUtfd1HrJM2gZ7u1XcuNP8Kqyv3Jm2sfYSEL+vCzoFbcp1JdSK4Kt1ChzD89GbWm91oW4nu3Pyq93dFUikVTtrkfmLiP8C68Ui366wAkQZSd44yqk1Oyop07DZr/VRpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=krZNDUu8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D31574E413CE;
	Wed, 29 Oct 2025 13:31:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A91A6606E8;
	Wed, 29 Oct 2025 13:31:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9404F117F809C;
	Wed, 29 Oct 2025 14:31:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744676; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=g6EoLHIVrvJ3bH8/8VH0gkiHKWy94ZpuwGW0qU4+WeE=;
	b=krZNDUu8TLo1N01nEfcEx4RUysrOrM1G6mWBS+pX7Tf0lqswG7Be8SaCFYQxFSXQ26xhKT
	1XLjOOadfHPVloZ88ByPFezDPVvvpvdDVLa51veNAHNtSlHVrjYuuwUqjslgNzvU3oKphY
	AqlQqwupQl0EK2fuElhYMkJD8n7YBgJo3ifF61SeCsdXmAzEaIZND+OSoYNGrkHZA6rU2b
	WyKf0Hj+xG59Leblx0k8MXuWnIAlXC6oviAuCP2miXnNN7DqIxLEuo+N6KfXBiTF5S3okE
	zxP2TO8HRmO21FTODJQJsqX1zyGTNRiwE8S3sJhJXoIluoqDcphZfhzScSWUgg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:40 +0100
Subject: [PATCH v2 30/32] drm/vkms: Extract common code for connector
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-30-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2773;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=vHE+KXN44+uY83YhKjAEjkHqNWJmb39F47iujVDrYRg=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbsWl+W2r/EunJZp/5j3i+vTGWzu/KgcZjO3
 bcgPIpXi/CJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW7AAKCRAgrS7GWxAs
 4oT4D/44VpPqqvbDLykiOSd2QAiMSlRNzlF7o9FeEL+EnpWRQRyyP/2uqTSWhYnogbzmrGNc0l4
 Bf0aRPY3VhhK9DoNhj3V+1nf0VgRjYogLajzsOGREYgFEWvpO9qYlinmaogceO8jUXrMpTj/Tec
 kXzjQjJMsz3l9mUZCoUmCsJc5O+u6AtZV087hck7U0LEwGtujfEcDnuD8xBIS9biOm0SBgBBBRh
 d2TGASxLSV9J1bJxIRUZAUv2yyA0YU58ZZ4IJWlkdH3F85NVFfu/iaSsG2/lg2kOvUlWGw6GSO1
 T1NC9VH8njwQ1Q2d8r4YqQWNUvgM1Tfs5rPaox5oC1Jvyi9nHb9Y16PC23zpQBU/EAP3HQurWD1
 0gq8ESNNsEK7w3PfLdX+W73b5v2ch2DallRemkWVUvOLTzh3n7VurnHcWUiO0BcXcybswwcl6q+
 CzPGcNNnXf/AcoI9LveIy4NxSQ+RaBxPpaf4gY8xiLMbDTAK7pwFFmZtgCTZdLh63SVi+2osoYJ
 zIK6SEDlQFcFAjE+lg6tuhEPkNfVpGlYVOeC/5bup+zYGzM/UjgMth2cXmIEobxzjS1dJB1FnAE
 ap/uEIjGAj2N/u5RN9qV3SlybvFRgY5uWRlahHutzZL7Hm4zxnsQikr/c8GOXR7UGxT805VXbj1
 26l6Ad/u2R/ihyA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

With the introduction of dynamic connector, some code will be shared
between dynamic and static connectors. Extract this part to avoid code
duplication

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_connector.c | 44 +++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 1b7ccca2abc0..2c5f04af8784 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -108,22 +108,17 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.best_encoder = vkms_conn_best_encoder,
 };
 
-struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
-						  struct vkms_config_connector *connector_cfg)
+/**
+ * vkms_connector_init() - Common initialization of vkms connector
+ * @vkmsdev: VKMS device containing the device
+ * @connector: VKMS connector to init. @connector->base must be
+ *             already initialized by DRM core.
+ * @connector_cfg: Connector configuration to apply
+ */
+static void vkms_connector_init(struct vkms_device *vkmsdev,
+				struct vkms_connector *connector,
+				const struct vkms_config_connector *connector_cfg)
 {
-	struct drm_device *dev = &vkmsdev->drm;
-	struct vkms_connector *connector;
-	int ret;
-
-	connector = drmm_kzalloc(dev, sizeof(*connector), GFP_KERNEL);
-	if (!connector)
-		return ERR_PTR(-ENOMEM);
-
-	ret = drmm_connector_init(dev, &connector->base, &vkms_connector_funcs,
-				  vkms_config_connector_get_type(connector_cfg), NULL);
-	if (ret)
-		return ERR_PTR(ret);
-
 	if (vkms_config_connector_get_supported_colorspaces(connector_cfg)) {
 		if (connector_cfg->type == DRM_MODE_CONNECTOR_HDMIA) {
 			drm_mode_create_hdmi_colorspace_property(&connector->base,
@@ -143,6 +138,25 @@ struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
 
 	if (vkms_config_connector_get_edid_enabled(connector_cfg))
 		drm_connector_attach_edid_property(&connector->base);
+}
+
+struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
+						  struct vkms_config_connector *connector_cfg)
+{
+	struct drm_device *dev = &vkmsdev->drm;
+	struct vkms_connector *connector;
+	int ret;
+
+	connector = drmm_kzalloc(dev, sizeof(*connector), GFP_KERNEL);
+	if (!connector)
+		return ERR_PTR(-ENOMEM);
+
+	ret = drmm_connector_init(dev, &connector->base, &vkms_connector_funcs,
+				  vkms_config_connector_get_type(connector_cfg), NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	vkms_connector_init(vkmsdev, connector, connector_cfg);
 
 	return connector;
 }

-- 
2.51.0


