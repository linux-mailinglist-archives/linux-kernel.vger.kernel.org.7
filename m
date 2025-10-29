Return-Path: <linux-kernel+bounces-876216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E313C1B034
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C8DC5A7E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0543C354AFE;
	Wed, 29 Oct 2025 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="q8E4WCfe"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E334354AC1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744683; cv=none; b=TawioCTH/ut2RX6yNwsmrRZaer1c4lUElsuM8qnh3c8S8yQL5Bda679Hd6Fcth6OpX5NgZ0wD8eYIxo0zhsUhyML/mq3iiNxfrR5P+YvZjkvQ8WRIWBL7qpfDoFqUK3bROhPUi9CvtC2gi0LbfQgC7e65mC+Gtqf8Yb/DxJA2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744683; c=relaxed/simple;
	bh=xrzdaraOFExxLukUGdDstkMZ2KqagA/b+HcZMmpJXPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OuushLKl0N2geNc/TBAI/KMcn5SmZf0Atcjlw7V6k/Y127Lzh+dp+OPNYjzkRFvPLj0jw87enw1kzbBxCPs9STMu5/oyeXJ+/G5YG7CLVtisk7nE7yXpxd+skH9r6YJPjE085yQPypAcUc1G5IZYuKD+AtBBz60Q2/jql8U8bOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=q8E4WCfe; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8780D4E413CF;
	Wed, 29 Oct 2025 13:31:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5CF3E606E8;
	Wed, 29 Oct 2025 13:31:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37F19117F809D;
	Wed, 29 Oct 2025 14:31:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744677; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=z9Dd9IU6DX4wrDs84ZKPS92OQlwhgVAYGOu5dRcVDJU=;
	b=q8E4WCfe3uYydDzydauG5K9/7tUeQXsLEL/ZCO0mnoTyHbLr/SD8j9bDFzCl7GvjdcXL4E
	SVK4c12maJhuxYhFFN9s9EIaq4QSnC/qIw/4xv2IDR1eKrl1IbiYHEYPkRMNKYkEXXMYlR
	u4Ae6pPjvKxXU7gINfdipkuIupgfrIm82xGGNIgBexTyegb5lRxFcdzs+GciT7EFERehwF
	Jvbq0YHyq+P5lcZJ2iV75f3xH3m/T7b3npZNEBYBN2aGdV7xSaQdnwe1Tx59FRK4cENcq7
	B5SKZswcUOEpMDSYkQWX6/ijrL2fgGr0kNaPpavuyemTXMVr1RV94ZjvD/uc8Q==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:41 +0100
Subject: [PATCH v2 31/32] drm/vkms: Allow to hot-add connectors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-vkms-all-config-v2-31-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5808;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=xrzdaraOFExxLukUGdDstkMZ2KqagA/b+HcZMmpJXPU=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbsWoDlB9kliDkPzNj8WixbIE2ATtL00itUo
 BQKubLgvkOJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW7AAKCRAgrS7GWxAs
 4m33D/9V40p3piBhYNkkZ/F25ATVTfq/IheJ6RNp9zmjb3B6GzVG5isxP1DXDlgHVDB4oMXIaeC
 UEQkOqhg2rQoF2/crSGVZTbgft8PMBXCH2+kHfNVGffHOAtv5uqRzeF1zGensP5NhfKldhYrOjs
 TuqieaVZT1Dhphci5GHdCFmJqjnTx0ohzbCxmkQNaCcRJZLuTaVQGdPflNLz8bn+7O0rbpfti42
 aIOW8vNYGo6ukc/CdInoQaVTRVt/BpU2YLPi2wgoKhXmSwPPm2FCQnb4fRYI7v/jtkEyUFVujR0
 vHHaO9THzorH7pzNMT64R++2g98/dbNpKktx/vtpp45PU82p2+de8bi9WYmAJHpNA177PgIkFPx
 p+TMlMFpNxn4pmAcREaJx6mZxKnAfTBGAl0etqpgMy9Go6FPgyHzEjmN27XvUYWTT12pt5HLRFZ
 vWtUEYafwx4h+VpWCdnFW0gzdtzkpygzHGt/clfq13jAvztnLJLN2NUvnThfGOMZqdAiWPknt1j
 8J+Anza9hrHFv0Pze1TQAGljg23v3odQXjXGx8dwD3vjmvijFyogEtuoDKmbr+mOpGLGhP6S9ZW
 TmjU9WrWSBlU2VZHonXnfC79GPYqfUdVtjDWpJ9sEg1i9XUlW7mhUxjASE6cbHIS/Mpw3qlqICq
 ML1YpriCiWxwQOg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

In order to allow creating dynamic connector, add the required
infrastructure in vkms_connector.

Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
[Louis Chauvet: use drm_atomic_helper_connector_reset instead of
drm_mode_config_reset because connector is not yet registered]
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_connector.c | 81 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.h | 32 ++++++++++++++
 drivers/gpu/drm/vkms/vkms_output.c    |  9 ++++
 3 files changed, 122 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 2c5f04af8784..bd0e368d5598 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -161,9 +161,90 @@ struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
 	return connector;
 }
 
+static void vkms_connector_dynamic_destroy(struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+	struct vkms_connector *vkms_connector;
+
+	drm_connector_cleanup(connector);
+
+	vkms_connector = drm_connector_to_vkms_connector(connector);
+	drmm_kfree(dev, vkms_connector);
+}
+
+static const struct drm_connector_funcs vkms_dynamic_connector_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.destroy = vkms_connector_dynamic_destroy,
+	.detect = vkms_connector_detect,
+};
+
 void vkms_trigger_connector_hotplug(struct vkms_device *vkmsdev)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 
 	drm_kms_helper_hotplug_event(dev);
 }
+
+struct vkms_connector *vkms_connector_hot_add(struct vkms_device *vkmsdev,
+					      struct vkms_config_connector *connector_cfg)
+{
+	struct vkms_config_encoder *encoder_cfg;
+	struct vkms_connector *connector;
+	int ret;
+	unsigned long idx = 0;
+
+	connector = drmm_kzalloc(&vkmsdev->drm, sizeof(*connector), GFP_KERNEL);
+	if (IS_ERR(connector))
+		return connector;
+	ret = drm_connector_dynamic_init(&vkmsdev->drm,
+					 &connector->base,
+					 &vkms_dynamic_connector_funcs,
+					 connector_cfg->type,
+					 NULL);
+	if (ret)
+		return ERR_PTR(ret);
+	drm_connector_helper_add(&connector->base, &vkms_conn_helper_funcs);
+
+	vkms_config_connector_for_each_possible_encoder(connector_cfg, idx, encoder_cfg) {
+		ret = drm_connector_attach_encoder(&connector->base,
+						   encoder_cfg->encoder);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	drm_atomic_helper_connector_reset(&connector->base);
+
+	vkms_connector_init(vkmsdev, connector, connector_cfg);
+
+	ret = drm_connector_dynamic_register(&connector->base);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return connector;
+}
+
+void vkms_connector_hot_remove(struct vkms_device *vkmsdev,
+			       struct vkms_connector *connector)
+{
+	drm_connector_unregister(&connector->base);
+	drm_mode_config_reset(&vkmsdev->drm);
+	drm_connector_put(&connector->base);
+}
+
+int vkms_connector_hot_attach_encoder(struct vkms_device *vkmsdev,
+				      struct vkms_connector *connector,
+				      struct drm_encoder *encoder)
+{
+	int ret;
+
+	ret = drm_connector_attach_encoder(&connector->base, encoder);
+	if (ret)
+		return ret;
+
+	drm_mode_config_reset(&vkmsdev->drm);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index 85f9082c710e..f53e3f85c684 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -34,4 +34,36 @@ struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
  */
 void vkms_trigger_connector_hotplug(struct vkms_device *vkmsdev);
 
+/**
+ * vkms_connector_hot_add() - Create a connector after the device is created
+ * @vkmsdev: Device to hot-add the connector to
+ * @connector_cfg: Connector's configuration
+ *
+ * Returns:
+ * The connector or an error on failure.
+ */
+struct vkms_connector *vkms_connector_hot_add(struct vkms_device *vkmsdev,
+					      struct vkms_config_connector *connector_cfg);
+
+/**
+ * vkms_connector_hot_remove() - Remove a connector after a device is created
+ * @connector: The connector to hot-remove
+ */
+void vkms_connector_hot_remove(struct vkms_device *vkmsdev,
+			       struct vkms_connector *connector);
+
+/**
+ * vkms_connector_hot_attach_encoder() - Attach a connector to a encoder after
+ * the device is created.
+ * @vkmsdev: Device containing the connector and the encoder
+ * @connector: Connector to attach to @encoder
+ * @encoder: Target encoder
+ *
+ * Returns:
+ * 0 on success or an error on failure.
+ */
+int vkms_connector_hot_attach_encoder(struct vkms_device *vkmsdev,
+				      struct vkms_connector *connector,
+				      struct drm_encoder *encoder);
+
 #endif /* _VKMS_CONNECTOR_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 44f8f53c9194..56c9c0b56151 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -116,5 +116,14 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 
 	drm_mode_config_reset(dev);
 
+	vkms_config_for_each_connector_dynamic(vkmsdev->config, connector_cfg) {
+		if (connector_cfg->enabled) {
+			connector_cfg->connector = vkms_connector_hot_add(vkmsdev, connector_cfg);
+
+			if (IS_ERR(connector_cfg->connector))
+				return PTR_ERR(connector_cfg->connector);
+		}
+	}
+
 	return 0;
 }

-- 
2.51.0


