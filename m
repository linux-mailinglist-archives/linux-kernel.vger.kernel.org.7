Return-Path: <linux-kernel+bounces-807606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C08B4A6E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76D21897BDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F827C154;
	Tue,  9 Sep 2025 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vHa5E5M0"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC7E27AC28
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408964; cv=none; b=kVP+u/vR6OlnJrxACyO9PD/Yb1joMlsktSXwd/8I0Rbyqm0GjIPLakX23LmKGewmVqbXdyXGeoENjz96r94iiHCBkzroQT4kx927YKSbrLPxyE1bd6F8s7n7eRZeawRoBsVp5i9gE53QQx4xKxLXKDF2vlLKg9129QVhSCCyXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408964; c=relaxed/simple;
	bh=ZN1hdRW1+rjh/N2FKmXv3tQ5R5w05mDhRfgPnd8I6Yg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jB/DE4JGp0fF7xKp/iSQSshGEEPnUn1F7w4HuBgLbO+Tn1JBQ9rPby97ogfOPwJqG21sqjexpZOeGVbEg7LjAu5dYPlGneb2RvAl9aLeL/klNcYzg/uiLTxcuHT0+yTSQTlTBhNq4r7CO9kUTDKw3USXQaUpBUO1sodFjq21OVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vHa5E5M0; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58998fdh305695;
	Tue, 9 Sep 2025 04:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757408921;
	bh=BzdSyrnO5lLaEBzSqEti3Zpo+4+s5/JC1JPRp8zVh+0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vHa5E5M0Xnr9q2y0WGMtZXFXoCNqlQUglNDCaSRNNTNuMj7iPGkrfPkn12vNeodCj
	 FJc7DN+TEP2Jm0Beu0WIt2vQc7O6oXS2ZFcPtQMVIH/REDMPZQTroAq1ywGoHV4rHT
	 hQk/TVdzuEURlT3rajRPcNyJkuwLDZe6UCiXu6d8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58998f1u3606677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 04:08:41 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 04:08:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 04:08:41 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58998Pkr2399851;
	Tue, 9 Sep 2025 04:08:33 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <lumag@kernel.org>, <dianders@chromium.org>,
        <andy.yan@rock-chips.com>, <mordan@ispras.ru>, <linux@treblig.org>,
        <viro@zeniv.linux.org.uk>, <aradhya.bhatia@linux.dev>,
        <javierm@redhat.com>, <tomi.valkeinen@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <u-kumar1@ti.com>, <s-jain1@ti.com>
CC: <lyude@redhat.com>, <luca.ceresoli@bootlin.com>
Subject: [PATCH v6 1/6] drm/bridge: cadence: cdns-mhdp8546-core: Remove legacy support for connector initialisation in bridge
Date: Tue, 9 Sep 2025 14:38:19 +0530
Message-ID: <20250909090824.1655537-2-h-shenoy@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909090824.1655537-1-h-shenoy@ti.com>
References: <20250909090824.1655537-1-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Jayesh Choudhary <j-choudhary@ti.com>

Now that we have DBANC framework, remove the connector initialisation code
as that piece of code is not called if DRM_BRIDGE_ATTACH_NO_CONNECTOR flag
is used. Only TI K3 platforms consume this driver and tidss (their display
controller) has this flag set. So this legacy support can be dropped.

Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 187 +-----------------
 1 file changed, 10 insertions(+), 177 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index a614d1384f71..08702ade2903 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -739,12 +739,8 @@ static void cdns_mhdp_fw_cb(const struct firmware *fw, void *context)
 	spin_lock(&mhdp->start_lock);
 	bridge_attached = mhdp->bridge_attached;
 	spin_unlock(&mhdp->start_lock);
-	if (bridge_attached) {
-		if (mhdp->connector.dev)
-			drm_kms_helper_hotplug_event(mhdp->bridge.dev);
-		else
-			drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
-	}
+	if (bridge_attached)
+		drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
 }
 
 static int cdns_mhdp_load_firmware(struct cdns_mhdp_device *mhdp)
@@ -1444,56 +1440,6 @@ static const struct drm_edid *cdns_mhdp_edid_read(struct cdns_mhdp_device *mhdp,
 	return drm_edid_read_custom(connector, cdns_mhdp_get_edid_block, mhdp);
 }
 
-static int cdns_mhdp_get_modes(struct drm_connector *connector)
-{
-	struct cdns_mhdp_device *mhdp = connector_to_mhdp(connector);
-	const struct drm_edid *drm_edid;
-	int num_modes;
-
-	if (!mhdp->plugged)
-		return 0;
-
-	drm_edid = cdns_mhdp_edid_read(mhdp, connector);
-
-	drm_edid_connector_update(connector, drm_edid);
-
-	if (!drm_edid) {
-		dev_err(mhdp->dev, "Failed to read EDID\n");
-		return 0;
-	}
-
-	num_modes = drm_edid_connector_add_modes(connector);
-	drm_edid_free(drm_edid);
-
-	/*
-	 * HACK: Warn about unsupported display formats until we deal
-	 *       with them correctly.
-	 */
-	if (connector->display_info.color_formats &&
-	    !(connector->display_info.color_formats &
-	      mhdp->display_fmt.color_format))
-		dev_warn(mhdp->dev,
-			 "%s: No supported color_format found (0x%08x)\n",
-			__func__, connector->display_info.color_formats);
-
-	if (connector->display_info.bpc &&
-	    connector->display_info.bpc < mhdp->display_fmt.bpc)
-		dev_warn(mhdp->dev, "%s: Display bpc only %d < %d\n",
-			 __func__, connector->display_info.bpc,
-			 mhdp->display_fmt.bpc);
-
-	return num_modes;
-}
-
-static int cdns_mhdp_connector_detect(struct drm_connector *conn,
-				      struct drm_modeset_acquire_ctx *ctx,
-				      bool force)
-{
-	struct cdns_mhdp_device *mhdp = connector_to_mhdp(conn);
-
-	return cdns_mhdp_detect(mhdp);
-}
-
 static u32 cdns_mhdp_get_bpp(struct cdns_mhdp_display_fmt *fmt)
 {
 	u32 bpp;
@@ -1547,114 +1493,6 @@ bool cdns_mhdp_bandwidth_ok(struct cdns_mhdp_device *mhdp,
 	return true;
 }
 
-static
-enum drm_mode_status cdns_mhdp_mode_valid(struct drm_connector *conn,
-					  const struct drm_display_mode *mode)
-{
-	struct cdns_mhdp_device *mhdp = connector_to_mhdp(conn);
-
-	mutex_lock(&mhdp->link_mutex);
-
-	if (!cdns_mhdp_bandwidth_ok(mhdp, mode, mhdp->link.num_lanes,
-				    mhdp->link.rate)) {
-		mutex_unlock(&mhdp->link_mutex);
-		return MODE_CLOCK_HIGH;
-	}
-
-	mutex_unlock(&mhdp->link_mutex);
-	return MODE_OK;
-}
-
-static int cdns_mhdp_connector_atomic_check(struct drm_connector *conn,
-					    struct drm_atomic_state *state)
-{
-	struct cdns_mhdp_device *mhdp = connector_to_mhdp(conn);
-	struct drm_connector_state *old_state, *new_state;
-	struct drm_crtc_state *crtc_state;
-	u64 old_cp, new_cp;
-
-	if (!mhdp->hdcp_supported)
-		return 0;
-
-	old_state = drm_atomic_get_old_connector_state(state, conn);
-	new_state = drm_atomic_get_new_connector_state(state, conn);
-	old_cp = old_state->content_protection;
-	new_cp = new_state->content_protection;
-
-	if (old_state->hdcp_content_type != new_state->hdcp_content_type &&
-	    new_cp != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
-		new_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
-		goto mode_changed;
-	}
-
-	if (!new_state->crtc) {
-		if (old_cp == DRM_MODE_CONTENT_PROTECTION_ENABLED)
-			new_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
-		return 0;
-	}
-
-	if (old_cp == new_cp ||
-	    (old_cp == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
-	     new_cp == DRM_MODE_CONTENT_PROTECTION_ENABLED))
-		return 0;
-
-mode_changed:
-	crtc_state = drm_atomic_get_new_crtc_state(state, new_state->crtc);
-	crtc_state->mode_changed = true;
-
-	return 0;
-}
-
-static const struct drm_connector_helper_funcs cdns_mhdp_conn_helper_funcs = {
-	.detect_ctx = cdns_mhdp_connector_detect,
-	.get_modes = cdns_mhdp_get_modes,
-	.mode_valid = cdns_mhdp_mode_valid,
-	.atomic_check = cdns_mhdp_connector_atomic_check,
-};
-
-static const struct drm_connector_funcs cdns_mhdp_conn_funcs = {
-	.fill_modes = drm_helper_probe_single_connector_modes,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
-	.reset = drm_atomic_helper_connector_reset,
-	.destroy = drm_connector_cleanup,
-};
-
-static int cdns_mhdp_connector_init(struct cdns_mhdp_device *mhdp)
-{
-	u32 bus_format = MEDIA_BUS_FMT_RGB121212_1X36;
-	struct drm_connector *conn = &mhdp->connector;
-	struct drm_bridge *bridge = &mhdp->bridge;
-	int ret;
-
-	conn->polled = DRM_CONNECTOR_POLL_HPD;
-
-	ret = drm_connector_init(bridge->dev, conn, &cdns_mhdp_conn_funcs,
-				 DRM_MODE_CONNECTOR_DisplayPort);
-	if (ret) {
-		dev_err(mhdp->dev, "Failed to initialize connector with drm\n");
-		return ret;
-	}
-
-	drm_connector_helper_add(conn, &cdns_mhdp_conn_helper_funcs);
-
-	ret = drm_display_info_set_bus_formats(&conn->display_info,
-					       &bus_format, 1);
-	if (ret)
-		return ret;
-
-	ret = drm_connector_attach_encoder(conn, bridge->encoder);
-	if (ret) {
-		dev_err(mhdp->dev, "Failed to attach connector to encoder\n");
-		return ret;
-	}
-
-	if (mhdp->hdcp_supported)
-		ret = drm_connector_attach_content_protection_property(conn, true);
-
-	return ret;
-}
-
 static int cdns_mhdp_attach(struct drm_bridge *bridge,
 			    struct drm_encoder *encoder,
 			    enum drm_bridge_attach_flags flags)
@@ -1671,9 +1509,11 @@ static int cdns_mhdp_attach(struct drm_bridge *bridge,
 		return ret;
 
 	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
-		ret = cdns_mhdp_connector_init(mhdp);
-		if (ret)
-			goto aux_unregister;
+		ret = -EINVAL;
+		dev_err(mhdp->dev,
+			"Connector initialisation not supported in bridge_attach %d\n",
+			ret);
+		goto aux_unregister;
 	}
 
 	spin_lock(&mhdp->start_lock);
@@ -2368,17 +2208,10 @@ static void cdns_mhdp_hpd_work(struct work_struct *work)
 	struct cdns_mhdp_device *mhdp = container_of(work,
 						     struct cdns_mhdp_device,
 						     hpd_work);
-	int ret;
 
-	ret = cdns_mhdp_update_link_status(mhdp);
-	if (mhdp->connector.dev) {
-		if (ret < 0)
-			schedule_work(&mhdp->modeset_retry_work);
-		else
-			drm_kms_helper_hotplug_event(mhdp->bridge.dev);
-	} else {
-		drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
-	}
+	cdns_mhdp_update_link_status(mhdp);
+
+	drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
 }
 
 static int cdns_mhdp_probe(struct platform_device *pdev)
-- 
2.34.1


