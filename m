Return-Path: <linux-kernel+bounces-843124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2E9BBE721
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0B8FB343B29
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A512D5957;
	Mon,  6 Oct 2025 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XL3pViJD"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA73B1A9FB7
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763303; cv=none; b=qI0hUos2CFCSWZ+QjBIY+V9dXh9gyQcwNoqdtvyUsc1/msiThxuN953EFtApvRkRFanPFehM33T8yLR8FUhqfVtRaKB0HSrUri22dnL+r7EWc0fxKV98lAK+pEtmYsxf8hLnXqs1tHza7IrdG+TTQCwjSSTIihqS0+8THIDMvpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763303; c=relaxed/simple;
	bh=07vU6oiRrRzsgoD2VInpfU7cC06TtdMZku5It85qMSg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=erxsD9HcF8zZJ1OYZyBtiiJx3doVE14pN6MbFFuBOvIOnzMWqQ0ldOrd62WB4I1XDJY6VbKN6BN4BqWBULp3hAkMAhd53vHuo93GkN4jHdxN9ZJdvXoA09kutJ8hycYkUabI4Ye/DtCncP7jvyL2iDjmc5ceFU8G0RuLWp3f8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XL3pViJD; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 596F7G393570378;
	Mon, 6 Oct 2025 10:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759763236;
	bh=VhlYXKXvfz60GKTlzmuU86WNYZsPhjumUk0p9txNzUg=;
	h=From:To:CC:Subject:Date;
	b=XL3pViJDYtfG5o2S7CP6cioqDPD8X6/+3zUE6WMwRiMyCZu8Lzxq5a6G4CUt30j7T
	 +6WB3QrWtWzOUqp489hoDK5ljbZZxMvwETuu9QlDOy5Lw8g0orQPXYSEZoxzDlipQg
	 pdah6viWTNEizdUxMpZgWP53qZWmQtvh9/4400Ic=
Received: from DLEE200.ent.ti.com (dlee200.ent.ti.com [157.170.170.75])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 596F7GE33389740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 6 Oct 2025 10:07:16 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Oct
 2025 10:07:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 10:07:15 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.233.157] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 596F7Ej63616485;
	Mon, 6 Oct 2025 10:07:15 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <airlied@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <simona@ffwll.ch>,
        <linux-kernel@vger.kernel.org>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <tomi.valkeinen@ideasonboard.com>, <jani.nikula@intel.com>,
        <praneeth@ti.com>, <vigneshr@ti.com>, <aradhya.bhatia@linux.dev>,
        <s-jain1@ti.com>, <s-wang12@ti.com>, <r-donadkar@ti.com>,
        <h-shenoy@ti.com>, <devarsht@ti.com>
Subject: [PATCH v2] drm/bridge: sii902x: Fix HDMI detection with DRM_BRIDGE_ATTACH_NO_CONNECTOR
Date: Mon, 6 Oct 2025 20:37:14 +0530
Message-ID: <20251006150714.3144368-1-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The SII902x HDMI bridge driver wasn't working properly with drivers that
use the newer bridge connector architecture with the
DRM_BRIDGE_ATTACH_NO_CONNECTOR flag, like TIDSS.  This caused HDMI audio to
fail since the driver wasn't properly setting the sink_is_hdmi flag when
the bridge was attached without a connector since .get_modes() is never
called in this case. Fix it by setting sink_is_hdmi flag when reading
the EDID block itself.

Fixes: 3de47e1309c2 ("drm/bridge: sii902x: use display info is_hdmi")
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2: Use drm_edid_connector_update to detect HDMI as suggested

Link to V1:
https://lore.kernel.org/all/20251003143642.4072918-1-devarsht@ti.com/
---
 drivers/gpu/drm/bridge/sii902x.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index d537b1d036fb..d36466d73385 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -296,6 +296,10 @@ static const struct drm_edid *sii902x_edid_read(struct sii902x *sii902x,
 	mutex_lock(&sii902x->mutex);
 
 	drm_edid = drm_edid_read_ddc(connector, sii902x->i2cmux->adapter[0]);
+	if (drm_edid) {
+		drm_edid_connector_update(connector, drm_edid);
+		sii902x->sink_is_hdmi = connector->display_info.is_hdmi;
+	}
 
 	mutex_unlock(&sii902x->mutex);
 
@@ -309,14 +313,11 @@ static int sii902x_get_modes(struct drm_connector *connector)
 	int num = 0;
 
 	drm_edid = sii902x_edid_read(sii902x, connector);
-	drm_edid_connector_update(connector, drm_edid);
 	if (drm_edid) {
 		num = drm_edid_connector_add_modes(connector);
 		drm_edid_free(drm_edid);
 	}
 
-	sii902x->sink_is_hdmi = connector->display_info.is_hdmi;
-
 	return num;
 }
 
-- 
2.39.1


