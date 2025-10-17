Return-Path: <linux-kernel+bounces-858404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB51BEA974
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70BB1A6475F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0762857C1;
	Fri, 17 Oct 2025 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1fHduYnJ"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8E2BE64C
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717752; cv=none; b=E5okPf+tlIkHlxjpEEubdmVddDAYjbR/JDfuYyL4z8DKF5Ab6DcCvWbEAln75DqTfhF8XeET8B3BnDaBldpXkmiSwvcpgdyR1vRgL3Qj6aobPPEauiqOYYAoCA88DJdYGSFq8y2V0OI+8c04JKTLkHq933lKkaINWFMKmc1+zPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717752; c=relaxed/simple;
	bh=XBMOcB5q4xrcoFGgvtQ/jzvKHjTGs1MimnWOMlogoDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qwFQXO1VuudL/LppRnXMW9z3HqXUP3YHSVEgueMtpJsRQxjU2DIs2Ox7WGM/3AX4zOUt9mSGPyf1qlhOAAOFH65B0dv0qQh/p/Zn3cH37dBYeqc3+Cw3yx4c9ZYbyWMdArFchn3t+7BBFWBrNcHNFKpzjDCXT0bUU3+iGxFYENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1fHduYnJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C3D331A1483;
	Fri, 17 Oct 2025 16:15:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9881E606DB;
	Fri, 17 Oct 2025 16:15:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 252E6102F2361;
	Fri, 17 Oct 2025 18:15:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760717747; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TcoDsORlor4mmaUdW6zET3q7u/9c8G/+kpyV7LHDxM8=;
	b=1fHduYnJ4bACBS4Bsxt2cTDAt0BI41fTKq800HE5xPlbrJmMa1ei/RlsVgpBu9iXT9HFN/
	VtPa64oHRtWkDqZ936Ee6Ai+v5U4KE44VLBPtPfgt2iHQu1V0a5TGdxuJZxrWpGmioNxi9
	Yo1o2Hd4rzhx+RoxczPYHkrXMoZz5f4m0RxR02T1W1adrdjrh+tjBeJPX+iq4/5yxL1qmP
	wMJDHsXak1OIyc/kmXXSYZGQr7mWiEt3UxsY4CGhXGlzJFHi0HX4BboPFz0CGSvgRFpaFq
	XsxczabVC9u9m0uCPAcDVOB5mFXNJ/mEkAUuizUrX7/fVd+S/h8Ul0YVYz6z/Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 17 Oct 2025 18:15:05 +0200
Subject: [PATCH v2 2/3] drm/display: bridge_connector: get/put the stored
 bridges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-2-667abf6d47c0@bootlin.com>
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

drm_bridge_connector_init() takes eight pointers to various bridges, some
of which can be identical, and stores them in pointers inside struct
drm_bridge_connector. Get a reference to each of the taken bridges and put
it on cleanup.

Achieve this by adding a drmm cleanup callback whic puts all the non-NULL
bridges. Using drmm ensures the cleanup happens on drm_device teardown,
whichever is the return value of this function.

Four of these pointers (edid, hpd, detect and modes) can be written
multiple times (up to once per loop iterations), in order to eventually
store the last matching bridge. So when one of those pointers is
overwritten, we need to put the reference that we got during the previous
assignment. Add a drm_bridge_put() before writing them to handle this.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

This patch was added in v2:
- it is a rewrite of the original (buggy) patch, but simpler after
  realizing thanks to drmm we don't need the temporary pointers as the
  stored pointers will be put just before deallocating
- compared to the original patch, moved the panel_bridge changes to a
  separate patch for clarity
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 52 +++++++++++++++++++-------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index a5bdd6c1064399ece6b19560f145b877c9e0680e..95ccf86527129edaa6fcc75c6202985e73c46da8 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -618,6 +618,20 @@ static const struct drm_connector_hdmi_cec_funcs drm_bridge_connector_hdmi_cec_f
  * Bridge Connector Initialisation
  */
 
+static void drm_bridge_connector_put_bridges(struct drm_device *dev, void *data)
+{
+	struct drm_bridge_connector *bridge_connector = (struct drm_bridge_connector *)data;
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
 /**
  * drm_bridge_connector_init - Initialise a connector for a chain of bridges
  * @drm: the DRM device
@@ -649,6 +663,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (!bridge_connector)
 		return ERR_PTR(-ENOMEM);
 
+	ret = drmm_add_action(drm, drm_bridge_connector_put_bridges, bridge_connector);
+	if (ret)
+		return ERR_PTR(ret);
+
 	bridge_connector->encoder = encoder;
 
 	/*
@@ -672,14 +690,22 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
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
+			drm_bridge_put(bridge_connector->bridge_edid);
+			bridge_connector->bridge_edid = drm_bridge_get(bridge);
+		}
+		if (bridge->ops & DRM_BRIDGE_OP_HPD) {
+			drm_bridge_put(bridge_connector->bridge_hpd);
+			bridge_connector->bridge_hpd = drm_bridge_get(bridge);
+		}
+		if (bridge->ops & DRM_BRIDGE_OP_DETECT) {
+			drm_bridge_put(bridge_connector->bridge_detect);
+			bridge_connector->bridge_detect = drm_bridge_get(bridge);
+		}
+		if (bridge->ops & DRM_BRIDGE_OP_MODES) {
+			drm_bridge_put(bridge_connector->bridge_modes);
+			bridge_connector->bridge_modes = drm_bridge_get(bridge);
+		}
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI) {
 			if (bridge_connector->bridge_hdmi)
 				return ERR_PTR(-EBUSY);
@@ -687,7 +713,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			    !bridge->funcs->hdmi_clear_infoframe)
 				return ERR_PTR(-EINVAL);
 
-			bridge_connector->bridge_hdmi = bridge;
+			bridge_connector->bridge_hdmi = drm_bridge_get(bridge);
 
 			if (bridge->supported_formats)
 				supported_formats = bridge->supported_formats;
@@ -710,7 +736,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			    !bridge->funcs->hdmi_audio_shutdown)
 				return ERR_PTR(-EINVAL);
 
-			bridge_connector->bridge_hdmi_audio = bridge;
+			bridge_connector->bridge_hdmi_audio = drm_bridge_get(bridge);
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_DP_AUDIO) {
@@ -728,21 +754,21 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			    !bridge->funcs->dp_audio_shutdown)
 				return ERR_PTR(-EINVAL);
 
-			bridge_connector->bridge_dp_audio = bridge;
+			bridge_connector->bridge_dp_audio = drm_bridge_get(bridge);
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
 			if (bridge_connector->bridge_hdmi_cec)
 				return ERR_PTR(-EBUSY);
 
-			bridge_connector->bridge_hdmi_cec = bridge;
+			bridge_connector->bridge_hdmi_cec = drm_bridge_get(bridge);
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
 			if (bridge_connector->bridge_hdmi_cec)
 				return ERR_PTR(-EBUSY);
 
-			bridge_connector->bridge_hdmi_cec = bridge;
+			bridge_connector->bridge_hdmi_cec = drm_bridge_get(bridge);
 
 			if (!bridge->funcs->hdmi_cec_enable ||
 			    !bridge->funcs->hdmi_cec_log_addr ||

-- 
2.51.0


