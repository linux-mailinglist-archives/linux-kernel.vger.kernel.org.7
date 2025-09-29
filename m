Return-Path: <linux-kernel+bounces-835964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC6ABA8757
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86878189D010
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BD227E1A1;
	Mon, 29 Sep 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A5YGbj/X"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4514826B77B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135911; cv=none; b=GpN0aLzLhdh7K9T9guLSqjod3czfBDAYnrLuVOB2j8/+6rSfCZYmcUtSBjN/VP1ziy2SAv4wWz73eymnOiHK78+8aJ2gS/VIhvfs24mTtlUvQYXtLld6kSQZTpuNVEXXGXpjbi8vQOHEcQiKuJU5vIj67sPBFeJ6jd4Ol5PExjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135911; c=relaxed/simple;
	bh=Auuonxg1Bxl3wp5b/NzADL9ZEb0tqwW7ducHFJC77TQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nh4/KjYazxUyWMYgiqE8QXesltQK7I5vz9lan9SnO5j8ch/gA305twCf87tkyuREIUvuo04dZqnc3VTIM/ZbuBStsQTC7lt2WrOyXOpv5zktc+xKh3fdXibQ0FJrii6WC3fctFZcDw8AXpqFpcfNYLRDA3nPrue6fBujE1YEgOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A5YGbj/X; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58T8e6ov2642370;
	Mon, 29 Sep 2025 03:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759135206;
	bh=2byyI4oeqdtRJFIjW18DSWz4SLJCIoLXm/WhHIgRt4A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=A5YGbj/XIky3Xaf0e8Va5Y0N9pHKEoW3YqNzyxREGhF+C+7mKziYUjGCCD12N/pYz
	 E2Hjl0cEZkSR+J0qtrq8OB1Lwy7tnhjp2Ldzf57zN4DBy08wUPlSzuqf6tutrxzY4O
	 tNUxS1p/m/rKwzj8YPmPinUb848G1k3THxU7Yp9I=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58T8e6Ef2996021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 29 Sep 2025 03:40:06 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 29
 Sep 2025 03:40:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Sep 2025 03:40:05 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58T8daaQ927539;
	Mon, 29 Sep 2025 03:39:59 -0500
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
Subject: [PATCH v7 3/6] drm/bridge: cadence: cdns-mhdp8546-core: Set the mhdp connector earlier in atomic_enable()
Date: Mon, 29 Sep 2025 14:09:33 +0530
Message-ID: <20250929083936.1575685-4-h-shenoy@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929083936.1575685-1-h-shenoy@ti.com>
References: <20250929083936.1575685-1-h-shenoy@ti.com>
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
connector initialised in bridge_attach(). Now that we have the connector
pointer in mhdp bridge structure, so set the mhdp->connector in
atomic_enable() earlier to avoid possible NULL pointer dereference
in recovery paths like modeset_retry_fn() with the DBANC flag set.

Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
---
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index c2ce3d6e5a88..b2f5a48cac2d 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1759,12 +1759,21 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	struct drm_bridge_state *new_state;
 	const struct drm_display_mode *mode;
 	u32 resp;
-	int ret;
+	int ret = 0;
 
 	dev_dbg(mhdp->dev, "bridge enable\n");
 
 	mutex_lock(&mhdp->link_mutex);
 
+	mhdp->connector = drm_atomic_get_new_connector_for_encoder(state,
+								   bridge->encoder);
+	if (WARN_ON(!mhdp->connector))
+		goto out;
+
+	conn_state = drm_atomic_get_new_connector_state(state, mhdp->connector);
+	if (WARN_ON(!conn_state))
+		goto out;
+
 	if (mhdp->plugged && !mhdp->link_up) {
 		ret = cdns_mhdp_link_up(mhdp);
 		if (ret < 0)
@@ -1784,15 +1793,6 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_CAR,
 			    resp | CDNS_VIF_CLK_EN | CDNS_VIF_CLK_RSTN);
 
-	mhdp->connector = drm_atomic_get_new_connector_for_encoder(state,
-								   bridge->encoder);
-	if (WARN_ON(!mhdp->connector))
-		goto out;
-
-	conn_state = drm_atomic_get_new_connector_state(state, mhdp->connector);
-	if (WARN_ON(!conn_state))
-		goto out;
-
 	if (mhdp->hdcp_supported &&
 	    mhdp->hw_state == MHDP_HW_READY &&
 	    conn_state->content_protection ==
-- 
2.34.1


