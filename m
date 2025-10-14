Return-Path: <linux-kernel+bounces-852258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F839BD88AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA271923C06
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A1F308F15;
	Tue, 14 Oct 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l3RLF2i0"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D5B302CCA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435199; cv=none; b=FLVBpFS9YrUHEIB4UF9Eqes223tlqXoCcwrPHtrVt1UySPu9vZakBo/9W5IVIn4NbISaZfLjy8di+vgQF/TiRVOFrwOSaLyx8KwIDOvTrXENTPaNHZIUxRiOOpzgLN9RPW/kjeRfz0LGbgbL5rS+uuoUYKNezuie5JyC6jGk7kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435199; c=relaxed/simple;
	bh=oWDM8Y0QzM1M/9gOZ7msqyFqaNWOuZL64iKMoTU5ll8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWyrNyFFP55bKuSu//nAGCPM8XmK1af8ErgqTGiDyWBcYd8jmAd7cNr6RYRsMIBd6OpLgFekdT+GdUBoUcT7//+213nxtp1Sg9y+zdf4icUBSBu8T6zf2T1E65R29tlfJzF+6kXDb2v+Rt5TKR9SqiT7wIeoRz/FW8hmahv1NYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=l3RLF2i0; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59E9jhJd1039165;
	Tue, 14 Oct 2025 04:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760435143;
	bh=T6S2MvM9uF1TV1afGaorNdjfES/u5wtrBI7oyO7jP4o=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=l3RLF2i0kWYJH1mOOboT+5MB4EWPjdg185kqalxxRSGB7P7PCWC5ltCvU1Mju+sW1
	 76SSQUDoFeQg3MaKcybqFvNcueo7JVCuaz8HyWMc2DYZtM3Jw6tNhnrhB54fxJie89
	 afFPiQN+6+pb90T9HEY0NhmpfA36bBxUB3y0M1mU=
Received: from DLEE204.ent.ti.com (dlee204.ent.ti.com [157.170.170.84])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59E9jgnC3713461
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 04:45:42 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 04:45:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 04:45:42 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59E9jSjT3359281;
	Tue, 14 Oct 2025 04:45:35 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <Laurent.pinchart@ideasonboard.com>, <airlied@gmail.com>,
        <andrzej.hajda@intel.com>, <andy.yan@rock-chips.com>,
        <aradhya.bhatia@linux.dev>, <devarsht@ti.com>, <dianders@chromium.org>,
        <dri-devel@lists.freedesktop.org>, <javierm@redhat.com>,
        <jernej.skrabec@gmail.com>, <jonas@kwiboo.se>,
        <linux-kernel@vger.kernel.org>, <linux@treblig.org>,
        <luca.ceresoli@bootlin.com>, <lumag@kernel.org>, <lyude@redhat.com>,
        <maarten.lankhorst@linux.intel.com>, <mordan@ispras.ru>,
        <mripard@kernel.org>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <s-jain1@ti.com>, <simona@ffwll.ch>, <tomi.valkeinen@ideasonboard.com>,
        <tzimmermann@suse.de>, <u-kumar1@ti.com>
Subject: [PATCH v8 1/6] drm/bridge: cadence: cdns-mhdp8546-core: Set the mhdp connector earlier in atomic_enable()
Date: Tue, 14 Oct 2025 15:15:22 +0530
Message-ID: <20251014094527.3916421-2-h-shenoy@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014094527.3916421-1-h-shenoy@ti.com>
References: <20251014094527.3916421-1-h-shenoy@ti.com>
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

In case if we get errors in cdns_mhdp_link_up() or cdns_mhdp_reg_read()
in atomic_enable, we will go to cdns_mhdp_modeset_retry_fn() and will hit
NULL pointer while trying to access the mutex. We need the connector to
be set before that. Unlike in legacy !(DBANC) cases, we do not have
connector initialised in bridge_attach(), so add the mhdp->connector_ptr
in device structure to handle both DBANC and !DBANC case and set it in
atomic_enable() earlier to avoid possible NULL pointer dereference in
recovery paths like modeset_retry_fn() with the DBANC flag set.

Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
---
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 29 ++++++++++---------
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 38726ae1bf15..f3076e9cdabb 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -740,7 +740,7 @@ static void cdns_mhdp_fw_cb(const struct firmware *fw, void *context)
 	bridge_attached = mhdp->bridge_attached;
 	spin_unlock(&mhdp->start_lock);
 	if (bridge_attached) {
-		if (mhdp->connector.dev)
+		if (mhdp->connector_ptr && mhdp->connector_ptr->dev)
 			drm_kms_helper_hotplug_event(mhdp->bridge.dev);
 		else
 			drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
@@ -1636,6 +1636,7 @@ static int cdns_mhdp_connector_init(struct cdns_mhdp_device *mhdp)
 		return ret;
 	}
 
+	mhdp->connector_ptr = conn;
 	drm_connector_helper_add(conn, &cdns_mhdp_conn_helper_funcs);
 
 	ret = drm_display_info_set_bus_formats(&conn->display_info,
@@ -1915,17 +1916,25 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
 	struct cdns_mhdp_bridge_state *mhdp_state;
 	struct drm_crtc_state *crtc_state;
-	struct drm_connector *connector;
 	struct drm_connector_state *conn_state;
 	struct drm_bridge_state *new_state;
 	const struct drm_display_mode *mode;
 	u32 resp;
-	int ret;
+	int ret = 0;
 
 	dev_dbg(mhdp->dev, "bridge enable\n");
 
 	mutex_lock(&mhdp->link_mutex);
 
+	mhdp->connector_ptr = drm_atomic_get_new_connector_for_encoder(state,
+								       bridge->encoder);
+	if (WARN_ON(!mhdp->connector_ptr))
+		goto out;
+
+	conn_state = drm_atomic_get_new_connector_state(state, mhdp->connector_ptr);
+	if (WARN_ON(!conn_state))
+		goto out;
+
 	if (mhdp->plugged && !mhdp->link_up) {
 		ret = cdns_mhdp_link_up(mhdp);
 		if (ret < 0)
@@ -1945,15 +1954,6 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_CAR,
 			    resp | CDNS_VIF_CLK_EN | CDNS_VIF_CLK_RSTN);
 
-	connector = drm_atomic_get_new_connector_for_encoder(state,
-							     bridge->encoder);
-	if (WARN_ON(!connector))
-		goto out;
-
-	conn_state = drm_atomic_get_new_connector_state(state, connector);
-	if (WARN_ON(!conn_state))
-		goto out;
-
 	if (mhdp->hdcp_supported &&
 	    mhdp->hw_state == MHDP_HW_READY &&
 	    conn_state->content_protection ==
@@ -2030,6 +2030,7 @@ static void cdns_mhdp_atomic_disable(struct drm_bridge *bridge,
 	if (mhdp->info && mhdp->info->ops && mhdp->info->ops->disable)
 		mhdp->info->ops->disable(mhdp);
 
+	mhdp->connector_ptr = NULL;
 	mutex_unlock(&mhdp->link_mutex);
 }
 
@@ -2296,7 +2297,7 @@ static void cdns_mhdp_modeset_retry_fn(struct work_struct *work)
 
 	mhdp = container_of(work, typeof(*mhdp), modeset_retry_work);
 
-	conn = &mhdp->connector;
+	conn = mhdp->connector_ptr;
 
 	/* Grab the locks before changing connector property */
 	mutex_lock(&conn->dev->mode_config.mutex);
@@ -2373,7 +2374,7 @@ static void cdns_mhdp_hpd_work(struct work_struct *work)
 	int ret;
 
 	ret = cdns_mhdp_update_link_status(mhdp);
-	if (mhdp->connector.dev) {
+	if (mhdp->connector_ptr && mhdp->connector_ptr->dev) {
 		if (ret < 0)
 			schedule_work(&mhdp->modeset_retry_work);
 		else
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
index bad2fc0c7306..a76775c76895 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
@@ -376,6 +376,7 @@ struct cdns_mhdp_device {
 	struct mutex link_mutex;
 
 	struct drm_connector connector;
+	struct drm_connector *connector_ptr;
 	struct drm_bridge bridge;
 
 	struct cdns_mhdp_link link;
-- 
2.34.1


