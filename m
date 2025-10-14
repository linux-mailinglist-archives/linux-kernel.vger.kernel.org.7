Return-Path: <linux-kernel+bounces-852263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00619BD88CF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5041923D86
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE8C2FCBEA;
	Tue, 14 Oct 2025 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A1F21jEd"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79C12EBB98
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435213; cv=none; b=OAEujjzOc5mZ95FatCNmHjybgDFsGkDnMNvLEi3nFFcvjdEDxroT1Uzh5gmELIqlV/44hX0clNcdCpGzzy+aWHaZ9NFWqs40SY6xKvvfz9K64QobHUnkeXC1FJU3VyIuk7P3DACeJvgAlwpd2kgz29f/O8Mquu3lkqUK1dExyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435213; c=relaxed/simple;
	bh=On5R3LWlsd3PYHTpGMzsiynihZ5ryBLo6IV7fBN3ZHs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbhUrYXxxT90CUoxyDpz+6jWNLyU5hnZNvVRrtIq59cPihud6y9aREEgGSCvPAEyeZl0P22yyLVARuQBzQXbXwcFvke2dXxf5CVGNFcx2ei3wNWI0RY+ipK1BHVk6FzegjBZablJWIbkEqguz42OsgeQ/TSZSecQlF1XrVMS3iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A1F21jEd; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59E9kHcp1118620;
	Tue, 14 Oct 2025 04:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760435177;
	bh=O6gISXFAw9VI8vW9Gp4gmJ8yOkZNaeDhjskPoc76tQE=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=A1F21jEd5NOeVK98Vng/bYurP16XYxInwsBH6KXGpY6FdwdK2W6q6sPZ61Y3QK66O
	 uLMgkHQZXAWWMy3xpFLmiodONIxDs4t2jZXjHCkCKJ9N1V5wLjblvMNdEj5p+EREgg
	 FFS9DA2xrZ7+E7sqze7ePVAf3u+UDfL+Fp6h5GNU=
Received: from DFLE207.ent.ti.com (dfle207.ent.ti.com [10.64.6.65])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59E9kHV73917383
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 04:46:17 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 04:46:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 04:46:17 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59E9jSjY3359281;
	Tue, 14 Oct 2025 04:46:10 -0500
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
Subject: [PATCH v8 6/6] drm/bridge: cadence: cdns-mhdp8546-core: Handle HDCP state in bridge atomic check
Date: Tue, 14 Oct 2025 15:15:27 +0530
Message-ID: <20251014094527.3916421-7-h-shenoy@ti.com>
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

Now that we have DBANC framework and legacy connector functions removed,
handle the HDCP disabling in bridge atomic check rather than in connector
atomic check in !(DBANC) usecase.

Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
---
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 06ac5c2ee78f..120eb7ffe20c 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1962,6 +1962,10 @@ static int cdns_mhdp_atomic_check(struct drm_bridge *bridge,
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
 	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
+	struct drm_connector_state *old_state, *new_state;
+	struct drm_atomic_state *state = crtc_state->state;
+	struct drm_connector *conn = mhdp->connector;
+	u64 old_cp, new_cp;
 
 	mutex_lock(&mhdp->link_mutex);
 
@@ -1981,6 +1985,25 @@ static int cdns_mhdp_atomic_check(struct drm_bridge *bridge,
 	if (mhdp->info)
 		bridge_state->input_bus_cfg.flags = *mhdp->info->input_bus_flags;
 
+	if (conn && mhdp->hdcp_supported) {
+		old_state = drm_atomic_get_old_connector_state(state, conn);
+		new_state = drm_atomic_get_new_connector_state(state, conn);
+		old_cp = old_state->content_protection;
+		new_cp = new_state->content_protection;
+
+		if (old_state->hdcp_content_type != new_state->hdcp_content_type &&
+		    new_cp != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
+			new_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+			crtc_state = drm_atomic_get_new_crtc_state(state, new_state->crtc);
+			crtc_state->mode_changed = true;
+		}
+
+		if (!new_state->crtc) {
+			if (old_cp == DRM_MODE_CONTENT_PROTECTION_ENABLED)
+				new_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+		}
+	}
+
 	mutex_unlock(&mhdp->link_mutex);
 	return 0;
 }
-- 
2.34.1


