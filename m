Return-Path: <linux-kernel+bounces-876399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0A3C1B826
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42A6584CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2901D2D7DE9;
	Wed, 29 Oct 2025 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oKYdSMPi"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F38B3491FB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748668; cv=none; b=IC8lWkA3JkY1Li09TEBKzX5/mRzV6p6eZgo5fvSQ1IqyrgsE3DomujmQTl0FqIybjnju2GbVzDHGqjvDjgtdKeeaQ5g+MgUjui7MFEqUPP1KBrw6tgvE5q3WZtlenyYxMyAp4w2rP+7mDaTNvszitleb5+/6FKkKoWX403tY/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748668; c=relaxed/simple;
	bh=vHE+KXN44+uY83YhKjAEjkHqNWJmb39F47iujVDrYRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oP02jETr/QwyP6JKB7L51ZctChf5HWWnc++EQpmBvba0NzMDElSa7fFc6u4LCSx4bIIO9uxF6XlCivkbv33/M1OmIUWBDhwNPYEIpT/n+/x1hZAsWOpJ1Nyz9FdWFEVu/EVPWdmHn4MF54RTYPeTkH1In9G78VDpPpluGWXxEvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oKYdSMPi; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2AFAB4E413CF;
	Wed, 29 Oct 2025 14:37:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 001E9606E8;
	Wed, 29 Oct 2025 14:37:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDB87117F81B6;
	Wed, 29 Oct 2025 15:37:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748664; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=g6EoLHIVrvJ3bH8/8VH0gkiHKWy94ZpuwGW0qU4+WeE=;
	b=oKYdSMPiZSk2DOm8uPrfg94cfMUHhxMRy+YQGf+qNgZRgKufiWztXSNfvKonx9zh44Gw1V
	xXt8kME+XRRx6UXXQSaMUaPBI3K+jsOE5aCxLh4vKEsTl8Ov+GJwSNWKAxvDWXTn6UtgwD
	7Judm/z/eJdUkasM2wrc9N7c8EyFoDNAEYBo08KksxkBSq9A1oI8SJnDb78qloYgyHAuik
	xW2cudl6Hv2X0cdOmIJfjCq1DBqXKbHGHprkcD9wp3NhX1TYJ3qn0yhlHHuAP8ZMmevNzJ
	qr9cFjqIS2DpMSGzG3B0OH9rjroYjaHGSDfh9iQqk8b3Vw2Qz896ecsDduTwUA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:37:07 +0100
Subject: [PATCH RESEND v2 30/32] drm/vkms: Extract common code for
 connector initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-30-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2773;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=vHE+KXN44+uY83YhKjAEjkHqNWJmb39F47iujVDrYRg=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ+aT+Hp1j2FV+wXkQMqRjY099iOPC0rTWV+
 10CqY7fnE+JAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImfgAKCRAgrS7GWxAs
 4hsOD/495loX/gzxt0xaWy06ZIi5nyYDBl5hYpWgYAnL3rBeay1pjCoANE1bg3gSwSrRDAYnopb
 17DPTzIBBWwlM5zchMWsLLkgbDmiUY2Q9TZ3ccN+Qapp3yZ687mBTUhLLlOoipvdsANBux4MLb7
 K1URkc6YCbzf7zUJhg6VP3tQ5rr8iCzm5KV4LFu3cnWjhKXKYzir+Tm9rJEvlVj7Lx+eh3Anig0
 thzIRj44BVF4AcxoEXTgCNEaR+3YkKC9VF9fcm8jhoTpOzVEuuTg93iKAsdgGNZU+S74bRyZwZV
 6Xer2pZ/sP9RAc1LpxAJmWsldcmQBf3FN4+D6rf3wl8Ujf+Vso0cDY4WiEvSasWSPruhufKD8PY
 Xnbme4bgrzbi4WnruqD/goVrmGLN1b6r6CCTWTeByLoYwarx/QCxlKWbDnCZiz+1B1HNy+jVYI7
 KAprzh1cNFEB9reEOJpeoSbsFZrTZAvYjudDNzfgnTEALJlnhzlH6n+KlfR7a0yPi7OV06QSB7N
 l23jc2m692Cm6nEhdGk3KG9xd3Kog0RZzInKd5A8FaIUJYMPGoTuaz4oBXeuDoluYM8ZXU9hpa+
 kQaymMAT2YCeGYt/9UJY6BQpdeuDw9DWXfM2a0ibud39FPFOK/QkNpYM3AtxrD8ePK70ZIsfkSe
 NgA6RoZJIJMOhdQ==
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


