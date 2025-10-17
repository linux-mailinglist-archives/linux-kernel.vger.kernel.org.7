Return-Path: <linux-kernel+bounces-858403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E67ABEA971
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7E6835EEBB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017062BEC32;
	Fri, 17 Oct 2025 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yLQWAAaF"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FAC2BE7CD
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717750; cv=none; b=fJRsLnhmnuPnGf/RWcHMvdbA4i2P1V+ylh5lVKndjPvFYfLcyUVo7WIkeQd2MczYkyuMsm+h2EAXAUH29KKnyA/49Z5tF83C1RfFRhuNjopffKl3Ay+xBsegHHvLAVTEI9wlLD0hgGR2BifcJ2bTM/bx9LPKB/7YYe7xHZTFU1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717750; c=relaxed/simple;
	bh=czoOsq71YeBmeZTSfCv8GRKj2niLLuNt4X6xQprXSY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=So2h9kzGnoNuxDLFr65T+R9zuXk9Ji4cU2386jBbEqpG5KGP9/DJDipeRpJyVuvciuWggxOLF+Tm7edUyI1BXs3ApTvZA2Az3gBxss80coZKXXi1IYASdXeyNw+oa4Htm0aDMWZ0/L1ZIEAG+AG/sN4sETa3AqhEqU+WNxxslyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yLQWAAaF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BD7561A1476;
	Fri, 17 Oct 2025 16:15:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 93AC6606DB;
	Fri, 17 Oct 2025 16:15:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99207102F235B;
	Fri, 17 Oct 2025 18:15:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760717744; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+Lxo9LHWsvDkpogxDakPiZH8k4KgCyFe/SU/GRt++l4=;
	b=yLQWAAaFWvMLhdbGJ1R1W447C8ntabI1PCc4kQg1APlfK9G4E5fqUdjXN13r3Cjwe+9Rxv
	I46bEY3CdUyTwKzOCtIExfGCpwbcqSgLQgnTIJJyKrFJCl86SdIcohx1cvxZmF/Zu/XSR3
	0ts6aBa2dJgHe9OQHDTVXIvObM93//Mq9gr6GrXqJDTYgoSgX2lbc0x2ILzoBPY5Wt2o8B
	cgNglUc7RkflxxPKNy8rNhjyougA7AGQP31S7Gm+zjlNigKmrqbjgcbHIu7UDbhMiCJx4E
	0kLIwuqKe7dNh24Xmoqkl44CMnb+YAPBJICeh1lJF23Yxz82/ShK+AV8QMkD0A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 17 Oct 2025 18:15:04 +0200
Subject: [PATCH v2 1/3] Revert "drm/display: bridge_connector: get/put the
 stored bridges"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-1-667abf6d47c0@bootlin.com>
References: <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com>
In-Reply-To: <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Naresh Kamboju <naresh.kamboju@linaro.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

This reverts commit 2be300f9a0b6f6b0ae2a90be97e558ec0535be54.

The commit being reverted moved all the bridge_connector->bridge_*
assignments to just before the final successful return in order to handle
the bridge refcounting in a clean way.

This introduced a bug, because a bit before the successful return
drmm_connector_hdmi_cec_register() is called, which calls funcs->init()
which is drm_bridge_connector_hdmi_cec_init() which needs
bridge_connector->bridge_hdmi_cec to be set.

The reported bug may be fixed in a relatively simple way, but other similar
patterns are potentially present, so just revert the offending commit. A
different approach will be implemented.

Fixes: 2be300f9a0b6 ("drm/display: bridge_connector: get/put the stored bridges")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/336fbfdd-c424-490e-b5d1-8ee84043dc80@samsung.com/
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/r/CA+G9fYuKHp3QgPKjgFY3TfkDdh5Vf=Ae5pCW+eU41Bu=D7th2g@mail.gmail.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2: none
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 114 ++++++++-----------------
 1 file changed, 36 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 7b18be3ff9a32b362468351835bdab43c3f524f1..a5bdd6c1064399ece6b19560f145b877c9e0680e 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -618,20 +618,6 @@ static const struct drm_connector_hdmi_cec_funcs drm_bridge_connector_hdmi_cec_f
  * Bridge Connector Initialisation
  */
 
-static void drm_bridge_connector_put_bridges(struct drm_device *dev, void *data)
-{
-	struct drm_bridge_connector *bridge_connector = (struct drm_bridge_connector *)data;
-
-	drm_bridge_put(bridge_connector->bridge_edid);
-	drm_bridge_put(bridge_connector->bridge_hpd);
-	drm_bridge_put(bridge_connector->bridge_detect);
-	drm_bridge_put(bridge_connector->bridge_modes);
-	drm_bridge_put(bridge_connector->bridge_hdmi);
-	drm_bridge_put(bridge_connector->bridge_hdmi_audio);
-	drm_bridge_put(bridge_connector->bridge_dp_audio);
-	drm_bridge_put(bridge_connector->bridge_hdmi_cec);
-}
-
 /**
  * drm_bridge_connector_init - Initialise a connector for a chain of bridges
  * @drm: the DRM device
@@ -652,15 +638,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	struct drm_bridge_connector *bridge_connector;
 	struct drm_connector *connector;
 	struct i2c_adapter *ddc = NULL;
-	struct drm_bridge *panel_bridge      __free(drm_bridge_put) = NULL;
-	struct drm_bridge *bridge_edid       __free(drm_bridge_put) = NULL;
-	struct drm_bridge *bridge_hpd        __free(drm_bridge_put) = NULL;
-	struct drm_bridge *bridge_detect     __free(drm_bridge_put) = NULL;
-	struct drm_bridge *bridge_modes      __free(drm_bridge_put) = NULL;
-	struct drm_bridge *bridge_hdmi       __free(drm_bridge_put) = NULL;
-	struct drm_bridge *bridge_hdmi_audio __free(drm_bridge_put) = NULL;
-	struct drm_bridge *bridge_dp_audio   __free(drm_bridge_put) = NULL;
-	struct drm_bridge *bridge_hdmi_cec   __free(drm_bridge_put) = NULL;
+	struct drm_bridge *panel_bridge = NULL;
 	unsigned int supported_formats = BIT(HDMI_COLORSPACE_RGB);
 	unsigned int max_bpc = 8;
 	bool support_hdcp = false;
@@ -671,10 +649,6 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (!bridge_connector)
 		return ERR_PTR(-ENOMEM);
 
-	ret = drmm_add_action(drm, drm_bridge_connector_put_bridges, bridge_connector);
-	if (ret)
-		return ERR_PTR(ret);
-
 	bridge_connector->encoder = encoder;
 
 	/*
@@ -698,30 +672,22 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		if (!bridge->ycbcr_420_allowed)
 			connector->ycbcr_420_allowed = false;
 
-		if (bridge->ops & DRM_BRIDGE_OP_EDID) {
-			drm_bridge_put(bridge_edid);
-			bridge_edid = drm_bridge_get(bridge);
-		}
-		if (bridge->ops & DRM_BRIDGE_OP_HPD) {
-			drm_bridge_put(bridge_hpd);
-			bridge_hpd = drm_bridge_get(bridge);
-		}
-		if (bridge->ops & DRM_BRIDGE_OP_DETECT) {
-			drm_bridge_put(bridge_detect);
-			bridge_detect = drm_bridge_get(bridge);
-		}
-		if (bridge->ops & DRM_BRIDGE_OP_MODES) {
-			drm_bridge_put(bridge_modes);
-			bridge_modes = drm_bridge_get(bridge);
-		}
+		if (bridge->ops & DRM_BRIDGE_OP_EDID)
+			bridge_connector->bridge_edid = bridge;
+		if (bridge->ops & DRM_BRIDGE_OP_HPD)
+			bridge_connector->bridge_hpd = bridge;
+		if (bridge->ops & DRM_BRIDGE_OP_DETECT)
+			bridge_connector->bridge_detect = bridge;
+		if (bridge->ops & DRM_BRIDGE_OP_MODES)
+			bridge_connector->bridge_modes = bridge;
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI) {
-			if (bridge_hdmi)
+			if (bridge_connector->bridge_hdmi)
 				return ERR_PTR(-EBUSY);
 			if (!bridge->funcs->hdmi_write_infoframe ||
 			    !bridge->funcs->hdmi_clear_infoframe)
 				return ERR_PTR(-EINVAL);
 
-			bridge_hdmi = drm_bridge_get(bridge);
+			bridge_connector->bridge_hdmi = bridge;
 
 			if (bridge->supported_formats)
 				supported_formats = bridge->supported_formats;
@@ -730,10 +696,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI_AUDIO) {
-			if (bridge_hdmi_audio)
+			if (bridge_connector->bridge_hdmi_audio)
 				return ERR_PTR(-EBUSY);
 
-			if (bridge_dp_audio)
+			if (bridge_connector->bridge_dp_audio)
 				return ERR_PTR(-EBUSY);
 
 			if (!bridge->hdmi_audio_max_i2s_playback_channels &&
@@ -744,14 +710,14 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			    !bridge->funcs->hdmi_audio_shutdown)
 				return ERR_PTR(-EINVAL);
 
-			bridge_hdmi_audio = drm_bridge_get(bridge);
+			bridge_connector->bridge_hdmi_audio = bridge;
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_DP_AUDIO) {
-			if (bridge_dp_audio)
+			if (bridge_connector->bridge_dp_audio)
 				return ERR_PTR(-EBUSY);
 
-			if (bridge_hdmi_audio)
+			if (bridge_connector->bridge_hdmi_audio)
 				return ERR_PTR(-EBUSY);
 
 			if (!bridge->hdmi_audio_max_i2s_playback_channels &&
@@ -762,7 +728,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			    !bridge->funcs->dp_audio_shutdown)
 				return ERR_PTR(-EINVAL);
 
-			bridge_dp_audio = drm_bridge_get(bridge);
+			bridge_connector->bridge_dp_audio = bridge;
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
@@ -773,10 +739,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
-			if (bridge_hdmi_cec)
+			if (bridge_connector->bridge_hdmi_cec)
 				return ERR_PTR(-EBUSY);
 
-			bridge_hdmi_cec = drm_bridge_get(bridge);
+			bridge_connector->bridge_hdmi_cec = bridge;
 
 			if (!bridge->funcs->hdmi_cec_enable ||
 			    !bridge->funcs->hdmi_cec_log_addr ||
@@ -796,7 +762,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			ddc = bridge->ddc;
 
 		if (drm_bridge_is_panel(bridge))
-			panel_bridge = drm_bridge_get(bridge);
+			panel_bridge = bridge;
 
 		if (bridge->support_hdcp)
 			support_hdcp = true;
@@ -805,13 +771,13 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
 		return ERR_PTR(-EINVAL);
 
-	if (bridge_hdmi) {
+	if (bridge_connector->bridge_hdmi) {
 		if (!connector->ycbcr_420_allowed)
 			supported_formats &= ~BIT(HDMI_COLORSPACE_YUV420);
 
 		ret = drmm_connector_hdmi_init(drm, connector,
-					       bridge_hdmi->vendor,
-					       bridge_hdmi->product,
+					       bridge_connector->bridge_hdmi->vendor,
+					       bridge_connector->bridge_hdmi->product,
 					       &drm_bridge_connector_funcs,
 					       &drm_bridge_connector_hdmi_funcs,
 					       connector_type, ddc,
@@ -827,14 +793,15 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			return ERR_PTR(ret);
 	}
 
-	if (bridge_hdmi_audio || bridge_dp_audio) {
+	if (bridge_connector->bridge_hdmi_audio ||
+	    bridge_connector->bridge_dp_audio) {
 		struct device *dev;
 		struct drm_bridge *bridge;
 
-		if (bridge_hdmi_audio)
-			bridge = bridge_hdmi_audio;
+		if (bridge_connector->bridge_hdmi_audio)
+			bridge = bridge_connector->bridge_hdmi_audio;
 		else
-			bridge = bridge_dp_audio;
+			bridge = bridge_connector->bridge_dp_audio;
 
 		dev = bridge->hdmi_audio_dev;
 
@@ -848,9 +815,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			return ERR_PTR(ret);
 	}
 
-	if (bridge_hdmi_cec &&
-	    bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
-		struct drm_bridge *bridge = bridge_hdmi_cec;
+	if (bridge_connector->bridge_hdmi_cec &&
+	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
+		struct drm_bridge *bridge = bridge_connector->bridge_hdmi_cec;
 
 		ret = drmm_connector_hdmi_cec_notifier_register(connector,
 								NULL,
@@ -859,9 +826,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			return ERR_PTR(ret);
 	}
 
-	if (bridge_hdmi_cec &&
-	    bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
-		struct drm_bridge *bridge = bridge_hdmi_cec;
+	if (bridge_connector->bridge_hdmi_cec &&
+	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
+		struct drm_bridge *bridge = bridge_connector->bridge_hdmi_cec;
 
 		ret = drmm_connector_hdmi_cec_register(connector,
 						       &drm_bridge_connector_hdmi_cec_funcs,
@@ -874,9 +841,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 
 	drm_connector_helper_add(connector, &drm_bridge_connector_helper_funcs);
 
-	if (bridge_hpd)
+	if (bridge_connector->bridge_hpd)
 		connector->polled = DRM_CONNECTOR_POLL_HPD;
-	else if (bridge_detect)
+	else if (bridge_connector->bridge_detect)
 		connector->polled = DRM_CONNECTOR_POLL_CONNECT
 				  | DRM_CONNECTOR_POLL_DISCONNECT;
 
@@ -887,15 +854,6 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
 		drm_connector_attach_content_protection_property(connector, true);
 
-	bridge_connector->bridge_edid       = drm_bridge_get(bridge_edid);
-	bridge_connector->bridge_hpd        = drm_bridge_get(bridge_hpd);
-	bridge_connector->bridge_detect     = drm_bridge_get(bridge_detect);
-	bridge_connector->bridge_modes      = drm_bridge_get(bridge_modes);
-	bridge_connector->bridge_hdmi       = drm_bridge_get(bridge_hdmi);
-	bridge_connector->bridge_hdmi_audio = drm_bridge_get(bridge_hdmi_audio);
-	bridge_connector->bridge_dp_audio   = drm_bridge_get(bridge_dp_audio);
-	bridge_connector->bridge_hdmi_cec   = drm_bridge_get(bridge_hdmi_cec);
-
 	return connector;
 }
 EXPORT_SYMBOL_GPL(drm_bridge_connector_init);

-- 
2.51.0


