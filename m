Return-Path: <linux-kernel+bounces-876398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43823C1B9D0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D35B5E0976
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539C34845C;
	Wed, 29 Oct 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T5YSSU1w"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCCF347FEC;
	Wed, 29 Oct 2025 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748666; cv=none; b=tOGXHO4Xa3X5IzVjL0NgbzJfu4IhdPdYaGNLv3A3ba4/7gGakgHZw1muhgecaZQn2mqT9Q7zU1psPC0VWZW77ekCve2cUy0oE4fyUQlg/+h23lpEV6DfGVqf52EmaO/25IrOzJ5GH/05+SERmrXJ/rnWXAag4SjqmAGrGbC+jaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748666; c=relaxed/simple;
	bh=GNdCT1aWfEW/qQlyX1iY1PDslsm0v0L9+mabaSCFgjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XgHgrDIzlv4Pg3GFUOeMgte8Nwibn0WS9JrExxBC7cfPqE/qfj042kec/MPDpjeRi57iuwiyvvZzTyVr/ofwMhONTwdoQsfOIUKfLNiShpin8TsmzYYHunIP1LS0A+4BWKg+40fZxZRoWKxgibUEP2jDkbxorKdDc3KYBWtaERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T5YSSU1w; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 13C9FC0DA83;
	Wed, 29 Oct 2025 14:37:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6B995606E8;
	Wed, 29 Oct 2025 14:37:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0FDB117F81B1;
	Wed, 29 Oct 2025 15:37:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748662; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1ieovVEGpwnQqb90fB7Ngr7zVzD1mSM9AkeaTdc+irk=;
	b=T5YSSU1wvQNqcc6rNh/2C4BRhuc+nYxcgwcnsynSEyO2CozaB/we6zQGJOTiPJ0KWPRiW9
	cYCTm64iAwoPiFWqZTprfc267INgck5jHMdPgVOBmPBFnK5vrsCVTla5qSr4ko13uUs7gP
	qGIT2cn1+xm7Xsa445PTsGnt+4q5z7bCbFkyl02u5g6y0q2lg1bdBdg55m/RRMsuv2/dYG
	RiME2wqahwCyVv4KdFmcfZS+O+uemK133VjOf6xU0RzEcwsFOx5mZEOYiOqCXlgc6gSC2A
	LibunI+puZbf2oo/xrSUWNJQ/7CkZe6lNQKs/OdA5m37So5RZAzqD4lDh4IArg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:37:06 +0100
Subject: [PATCH RESEND v2 29/32] drm/vkms: Rename vkms_connector_init to
 vkms_connector_init_static
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-29-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3042;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=GNdCT1aWfEW/qQlyX1iY1PDslsm0v0L9+mabaSCFgjo=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ+usbluoyz+CVfmPQXVAXXfGDxuzYNqVvoa
 2ohYNQaJQyJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImfgAKCRAgrS7GWxAs
 4nJGD/4oPPsr2RLiMOtmF96vYPcdYsC+1EeKdAwcEv8q7E27qGzoniikcQujb5YvgFR+73BNINc
 I9MgDxWVRO10GJPYJAfPmJ2UVLHY7qezORxrfYLSHmOCN0Tgs5lfaAt+cjXkzhS4bVZ32AGj9vW
 1qbH2lgsREbgSTYYjX9n9PhIX7QWgo81jQpPXpt3SHLzPziN8k4iydWCWJ6XU93K2UzC1AF+SfU
 WeBKog6NZAEsrDOqiqWcvrFPl2lOy/jo02HWgoOsNRxhHlWVaukYi36cRvhRST3j7eb0nPRQ+Bi
 9IsY4diLOc10z9xDjVo+zWsE5R2Brj9iowHGDCa5kRLiY42Fhm2PKcLf1Vqz9Vr1AdCqUdLuffw
 gI4PGckVPYr4bOTY25LHxD1NI846c7IpenZ7DTLgCR93N4+ni6lb8Sl13D5fxAaPsG/Qw1x6npj
 mby3ml+AeCJjJzT/cwQUrOV7lqjXF1a8Irk2bXiyKEaNnpl13xIimTHXAeICfAGMIZmoCfq1XMr
 nOTqHcVlV7d7U0hILu8SRn4w2XOX3EggAklZKPWQq0Y1RNHABNyYjl45ekPErsgFX3CKj9MeWEv
 OAiuYqG/vkhHJ4adKUmEzhtO6Qu6txdESMFCZN8i29UqJ+VQXV5kFGF9+KTi+mLMhlgAR56dRSZ
 2/IBUzcnUtdgsug==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

With the introduction of dynamic connectors we will have two way of
initializing a VKMS connector. Rename the current function to clarify
the case.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_connector.c | 4 ++--
 drivers/gpu/drm/vkms/vkms_connector.h | 7 ++++---
 drivers/gpu/drm/vkms/vkms_output.c    | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 699b6779a46c..1b7ccca2abc0 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -108,8 +108,8 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.best_encoder = vkms_conn_best_encoder,
 };
 
-struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
-					   struct vkms_config_connector *connector_cfg)
+struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
+						  struct vkms_config_connector *connector_cfg)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	struct vkms_connector *connector;
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index a124c5403697..85f9082c710e 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -4,6 +4,7 @@
 #define _VKMS_CONNECTOR_H_
 
 #include "vkms_drv.h"
+#include "vkms_config.h"
 
 #define drm_connector_to_vkms_connector(target) \
 	container_of(target, struct vkms_connector, base)
@@ -18,14 +19,14 @@ struct vkms_connector {
 };
 
 /**
- * vkms_connector_init() - Initialize a connector
+ * vkms_connector_init_static() - Initialize a connector
  * @vkmsdev: VKMS device containing the connector
  *
  * Returns:
  * The connector or an error on failure.
  */
-struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
-					   struct vkms_config_connector *connector_cfg);
+struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
+						  struct vkms_config_connector *connector_cfg);
 
 /**
  * vkms_trigger_connector_hotplug() - Update the device's connectors status
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 217f054d9598..44f8f53c9194 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -92,11 +92,11 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		}
 	}
 
-	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
+	vkms_config_for_each_connector_static(vkmsdev->config, connector_cfg) {
 		struct vkms_config_encoder *possible_encoder;
 		unsigned long idx = 0;
 
-		connector_cfg->connector = vkms_connector_init(vkmsdev, connector_cfg);
+		connector_cfg->connector = vkms_connector_init_static(vkmsdev, connector_cfg);
 		if (IS_ERR(connector_cfg->connector)) {
 			DRM_ERROR("Failed to init connector\n");
 			return PTR_ERR(connector_cfg->connector);

-- 
2.51.0


