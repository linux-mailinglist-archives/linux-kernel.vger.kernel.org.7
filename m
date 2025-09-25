Return-Path: <linux-kernel+bounces-832941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B902BA0CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2E54A0E14
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3385130BF79;
	Thu, 25 Sep 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QA8pCY8/"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEBB30C61E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820819; cv=none; b=XN+CI1RXvjWlNoG/Mzpkn8pMRlTYueX0vPQiYCDyT99yz3QEEqX2AVeaEit9En7ia0WSbi/ocwN+FeE2MCGt2Lh6U6qTJLqEu3oq+GXKSuu+1wLfMcLZObcVr3SjsvtEuP6BvHJ1l6DSzGsewRH5UZsH9gaSbgA2zRlgO6ZqatI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820819; c=relaxed/simple;
	bh=hNgK/Uzgk3tiejJ33kqYpwo+r70mcWbyh9veVNBb6RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fop2vBDXJ2l2lJGgXhbH7TnVvrOACqV7nC+x8hhSHpIfSKkojGo559/qDK/L9ma2+h74eqFrXkXNmdvbFlgeCatdvu2RTBlxqQFrYE0n0vo1uIrcFW78rwtDr9IZREplmpMd52KW2g8GMhX9CFx4wRdmZ4XjWUJi7KIOuGbDxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QA8pCY8/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B756C1A0FB7;
	Thu, 25 Sep 2025 17:20:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 87FD560665;
	Thu, 25 Sep 2025 17:20:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE065102F18A1;
	Thu, 25 Sep 2025 19:20:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758820813; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0sMYzovaJDmQt5RrIh8C89vIF4dc6AtroV+cbqJJWgU=;
	b=QA8pCY8/lmMejdNVj6KIydE8Qkk4gdDe8/XOJjLefAcgEAkBdflA+weSm/6Vu8r6wqpf49
	o64OyAmPuNTMwzTli/wwq1g+CbhuHtMI4arIp3Hgv23mncEJx1H8MlkP7PCEMkd+2TbsA2
	7HWkI0RcaEgMNiknk26vYc4ljZc5+Nudfn0QopkQEpf9WgG4GRMPS8O4WsW5R/90SW1JTT
	+eqTHTi+zLt5iDkGEbrm1/oZDxmUlWfSE3Xgp1H4O9rJBMGs/x+MFL4gSDhbd8TaiNDWVK
	R875WN1DDIuVoSbJ0ihc8txc5auR1k5L4yQp4/mCBTKDrhiiXE8os8olQ1tcRw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 25 Sep 2025 19:19:50 +0200
Subject: [PATCH 2/2] drm/display: bridge-connector: get/put the stored
 bridges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-drm-bridge-alloc-getput-bridge-connector-v1-2-f0736e1c73ee@bootlin.com>
References: <20250925-drm-bridge-alloc-getput-bridge-connector-v1-0-f0736e1c73ee@bootlin.com>
In-Reply-To: <20250925-drm-bridge-alloc-getput-bridge-connector-v1-0-f0736e1c73ee@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

drm_bridge_connector_init() takes eight pointers to various bridges, some
of which can be identical, and stores them in pointers inside struct
drm_bridge_connector. Get a reference to each of the taken bridges and put
it on cleanup.

This is tricky because the pointers are currently stored directly in the
drm_bridge_connector in the loop, but there is no nice and clean way to put
those pointers on error return paths. To overcome this, store all pointers
in temporary local variables with a cleanup action, and only on success
copy them into struct drm_bridge_connector (getting another ref while
copying).

Additionally four of these pointers (edid, hpd, detect and modes) can be
written in multiple loop iterations, in order to eventually store the last
matching bridge. However when one of those pointers is overwritten once we
need to put the reference that we got during the previous assignment. Add a
drm_bridge_put() before writing them to handle this.

Finally, there is also a function-local panel_bridge pointer taken inside
the loop and used after the loop. Due to the various return points, use a
__free() cleanup action to ensure it is put on return.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 112 +++++++++++++++++--------
 1 file changed, 76 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index a5bdd6c1064399ece6b19560f145b877c9e0680e..4bcebbb8c9935fa55010a9d317f3d9e70b2ff7a3 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -268,11 +268,27 @@ static void drm_bridge_connector_reset(struct drm_connector *connector)
 							 connector->state);
 }
 
+static void drm_bridge_connector_destroy(struct drm_connector *connector)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+
+	drm_bridge_put(bridge_connector->bridge_edid);
+	drm_bridge_put(bridge_connector->bridge_hpd);
+	drm_bridge_put(bridge_connector->bridge_detect);
+	drm_bridge_put(bridge_connector->bridge_modes);
+	drm_bridge_put(bridge_connector->bridge_hdmi);
+	drm_bridge_put(bridge_connector->bridge_hdmi_audio);
+	drm_bridge_put(bridge_connector->bridge_dp_audio);
+	drm_bridge_put(bridge_connector->bridge_hdmi_cec);
+}
+
 static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.reset = drm_bridge_connector_reset,
 	.detect = drm_bridge_connector_detect,
 	.force = drm_bridge_connector_force,
 	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_bridge_connector_destroy,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.debugfs_init = drm_bridge_connector_debugfs_init,
@@ -638,7 +654,15 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	struct drm_bridge_connector *bridge_connector;
 	struct drm_connector *connector;
 	struct i2c_adapter *ddc = NULL;
-	struct drm_bridge *panel_bridge = NULL;
+	struct drm_bridge *panel_bridge      __free(drm_bridge_put) = NULL;
+	struct drm_bridge *bridge_edid       __free(drm_bridge_put) = NULL;
+	struct drm_bridge *bridge_hpd        __free(drm_bridge_put) = NULL;
+	struct drm_bridge *bridge_detect     __free(drm_bridge_put) = NULL;
+	struct drm_bridge *bridge_modes      __free(drm_bridge_put) = NULL;
+	struct drm_bridge *bridge_hdmi       __free(drm_bridge_put) = NULL;
+	struct drm_bridge *bridge_hdmi_audio __free(drm_bridge_put) = NULL;
+	struct drm_bridge *bridge_dp_audio   __free(drm_bridge_put) = NULL;
+	struct drm_bridge *bridge_hdmi_cec   __free(drm_bridge_put) = NULL;
 	unsigned int supported_formats = BIT(HDMI_COLORSPACE_RGB);
 	unsigned int max_bpc = 8;
 	bool support_hdcp = false;
@@ -672,22 +696,30 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		if (!bridge->ycbcr_420_allowed)
 			connector->ycbcr_420_allowed = false;
 
-		if (bridge->ops & DRM_BRIDGE_OP_EDID)
-			bridge_connector->bridge_edid = bridge;
-		if (bridge->ops & DRM_BRIDGE_OP_HPD)
-			bridge_connector->bridge_hpd = bridge;
-		if (bridge->ops & DRM_BRIDGE_OP_DETECT)
-			bridge_connector->bridge_detect = bridge;
-		if (bridge->ops & DRM_BRIDGE_OP_MODES)
-			bridge_connector->bridge_modes = bridge;
+		if (bridge->ops & DRM_BRIDGE_OP_EDID) {
+			drm_bridge_put(bridge_edid);
+			bridge_edid = drm_bridge_get(bridge);
+		}
+		if (bridge->ops & DRM_BRIDGE_OP_HPD) {
+			drm_bridge_put(bridge_hpd);
+			bridge_hpd = drm_bridge_get(bridge);
+		}
+		if (bridge->ops & DRM_BRIDGE_OP_DETECT) {
+			drm_bridge_put(bridge_detect);
+			bridge_detect = drm_bridge_get(bridge);
+		}
+		if (bridge->ops & DRM_BRIDGE_OP_MODES) {
+			drm_bridge_put(bridge_modes);
+			bridge_modes = drm_bridge_get(bridge);
+		}
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI) {
-			if (bridge_connector->bridge_hdmi)
+			if (bridge_hdmi)
 				return ERR_PTR(-EBUSY);
 			if (!bridge->funcs->hdmi_write_infoframe ||
 			    !bridge->funcs->hdmi_clear_infoframe)
 				return ERR_PTR(-EINVAL);
 
-			bridge_connector->bridge_hdmi = bridge;
+			bridge_hdmi = drm_bridge_get(bridge);
 
 			if (bridge->supported_formats)
 				supported_formats = bridge->supported_formats;
@@ -696,10 +728,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI_AUDIO) {
-			if (bridge_connector->bridge_hdmi_audio)
+			if (bridge_hdmi_audio)
 				return ERR_PTR(-EBUSY);
 
-			if (bridge_connector->bridge_dp_audio)
+			if (bridge_dp_audio)
 				return ERR_PTR(-EBUSY);
 
 			if (!bridge->hdmi_audio_max_i2s_playback_channels &&
@@ -710,14 +742,14 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			    !bridge->funcs->hdmi_audio_shutdown)
 				return ERR_PTR(-EINVAL);
 
-			bridge_connector->bridge_hdmi_audio = bridge;
+			bridge_hdmi_audio = drm_bridge_get(bridge);
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_DP_AUDIO) {
-			if (bridge_connector->bridge_dp_audio)
+			if (bridge_dp_audio)
 				return ERR_PTR(-EBUSY);
 
-			if (bridge_connector->bridge_hdmi_audio)
+			if (bridge_hdmi_audio)
 				return ERR_PTR(-EBUSY);
 
 			if (!bridge->hdmi_audio_max_i2s_playback_channels &&
@@ -728,7 +760,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			    !bridge->funcs->dp_audio_shutdown)
 				return ERR_PTR(-EINVAL);
 
-			bridge_connector->bridge_dp_audio = bridge;
+			bridge_dp_audio = drm_bridge_get(bridge);
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
@@ -739,10 +771,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
-			if (bridge_connector->bridge_hdmi_cec)
+			if (bridge_hdmi_cec)
 				return ERR_PTR(-EBUSY);
 
-			bridge_connector->bridge_hdmi_cec = bridge;
+			bridge_hdmi_cec = drm_bridge_get(bridge);
 
 			if (!bridge->funcs->hdmi_cec_enable ||
 			    !bridge->funcs->hdmi_cec_log_addr ||
@@ -762,7 +794,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			ddc = bridge->ddc;
 
 		if (drm_bridge_is_panel(bridge))
-			panel_bridge = bridge;
+			panel_bridge = drm_bridge_get(bridge);
 
 		if (bridge->support_hdcp)
 			support_hdcp = true;
@@ -771,13 +803,13 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
 		return ERR_PTR(-EINVAL);
 
-	if (bridge_connector->bridge_hdmi) {
+	if (bridge_hdmi) {
 		if (!connector->ycbcr_420_allowed)
 			supported_formats &= ~BIT(HDMI_COLORSPACE_YUV420);
 
 		ret = drmm_connector_hdmi_init(drm, connector,
-					       bridge_connector->bridge_hdmi->vendor,
-					       bridge_connector->bridge_hdmi->product,
+					       bridge_hdmi->vendor,
+					       bridge_hdmi->product,
 					       &drm_bridge_connector_funcs,
 					       &drm_bridge_connector_hdmi_funcs,
 					       connector_type, ddc,
@@ -793,15 +825,14 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			return ERR_PTR(ret);
 	}
 
-	if (bridge_connector->bridge_hdmi_audio ||
-	    bridge_connector->bridge_dp_audio) {
+	if (bridge_hdmi_audio || bridge_dp_audio) {
 		struct device *dev;
 		struct drm_bridge *bridge;
 
-		if (bridge_connector->bridge_hdmi_audio)
-			bridge = bridge_connector->bridge_hdmi_audio;
+		if (bridge_hdmi_audio)
+			bridge = bridge_hdmi_audio;
 		else
-			bridge = bridge_connector->bridge_dp_audio;
+			bridge = bridge_dp_audio;
 
 		dev = bridge->hdmi_audio_dev;
 
@@ -815,9 +846,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			return ERR_PTR(ret);
 	}
 
-	if (bridge_connector->bridge_hdmi_cec &&
-	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
-		struct drm_bridge *bridge = bridge_connector->bridge_hdmi_cec;
+	if (bridge_hdmi_cec &&
+	    bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
+		struct drm_bridge *bridge = bridge_hdmi_cec;
 
 		ret = drmm_connector_hdmi_cec_notifier_register(connector,
 								NULL,
@@ -826,9 +857,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			return ERR_PTR(ret);
 	}
 
-	if (bridge_connector->bridge_hdmi_cec &&
-	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
-		struct drm_bridge *bridge = bridge_connector->bridge_hdmi_cec;
+	if (bridge_hdmi_cec &&
+	    bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
+		struct drm_bridge *bridge = bridge_hdmi_cec;
 
 		ret = drmm_connector_hdmi_cec_register(connector,
 						       &drm_bridge_connector_hdmi_cec_funcs,
@@ -841,9 +872,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 
 	drm_connector_helper_add(connector, &drm_bridge_connector_helper_funcs);
 
-	if (bridge_connector->bridge_hpd)
+	if (bridge_hpd)
 		connector->polled = DRM_CONNECTOR_POLL_HPD;
-	else if (bridge_connector->bridge_detect)
+	else if (bridge_detect)
 		connector->polled = DRM_CONNECTOR_POLL_CONNECT
 				  | DRM_CONNECTOR_POLL_DISCONNECT;
 
@@ -854,6 +885,15 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
 		drm_connector_attach_content_protection_property(connector, true);
 
+	bridge_connector->bridge_edid       = drm_bridge_get(bridge_edid);
+	bridge_connector->bridge_hpd        = drm_bridge_get(bridge_hpd);
+	bridge_connector->bridge_detect     = drm_bridge_get(bridge_detect);
+	bridge_connector->bridge_modes      = drm_bridge_get(bridge_modes);
+	bridge_connector->bridge_hdmi       = drm_bridge_get(bridge_hdmi);
+	bridge_connector->bridge_hdmi_audio = drm_bridge_get(bridge_hdmi_audio);
+	bridge_connector->bridge_dp_audio   = drm_bridge_get(bridge_dp_audio);
+	bridge_connector->bridge_hdmi_cec   = drm_bridge_get(bridge_hdmi_cec);
+
 	return connector;
 }
 EXPORT_SYMBOL_GPL(drm_bridge_connector_init);

-- 
2.51.0


