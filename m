Return-Path: <linux-kernel+bounces-844164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B08CBC1333
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DA63A834B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCFD2DAFA3;
	Tue,  7 Oct 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uuSHBBh2"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FFA2D978D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836210; cv=none; b=T6D/gKde2Ktl6nyT2/SuheEq0BvtI2NPymR2MIs5aNbSHFgvOWVVwCWJdZ6kjU5vpPPQkf2iyqyjBWIdGx2NBobznHEPtJbxsxbZQ+TiaWa8iNmmLmCScR95VaqiaFx4oEabeSWfJ7/TFD0TOZA1LUBAwcW0qLvXM7lpsURwloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836210; c=relaxed/simple;
	bh=fctyKYc2x7DMTuxl7duvS5t5Yb2REEfkf2CXPqpksVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nQcoaTNo6ZPVplnOMO7wsReb2+RFg1+5hXVESnzjKHen8R+EdQkUGomx6xHusp42LaJwkNPFkpvXx90y6mydO0APVZvRsz1zhA0/b2r27m171qqpi9T1u/cht2OAbTb77X5OUAikoSCSGb/2Belz2Oqdr4SSlhy5F4WodQ/PA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uuSHBBh2; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 597BNBo43748368;
	Tue, 7 Oct 2025 06:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759836191;
	bh=4KNIFjNPxwNPgtviTOOqfAT97sq7NEDYsdF9WCpvtF4=;
	h=From:To:CC:Subject:Date;
	b=uuSHBBh2/xiKm8wz6ta+YL1PdG30U/vG9IOaW4Xl91Du/RwYrywFKZFFJz0o41sdV
	 KHXV9IR8RXH9wz2EgZd0sdfaP5PTJ9Y/ZvaXCSbuROaZT1vkLLdNWDTxLyi/9FGKs8
	 TmhyLiQTJdrdvruOYCSzdnfRfQ9Dcqcf741d7XAE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 597BNBEc650378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 7 Oct 2025 06:23:11 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 7
 Oct 2025 06:23:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Oct 2025 06:23:10 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.233.157] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 597BN9Dj1039554;
	Tue, 7 Oct 2025 06:23:10 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <airlied@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <jani.nikula@intel.com>,
        <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
        <dmitry.baryshkov@oss.qualcomm.com>
CC: <tomi.valkeinen@ideasonboard.com>, <praneeth@ti.com>, <vigneshr@ti.com>,
        <aradhya.bhatia@linux.dev>, <s-jain1@ti.com>, <s-wang12@ti.com>,
        <r-donadkar@ti.com>, <h-shenoy@ti.com>, <devarsht@ti.com>
Subject: [PATCH v3] drm/bridge: sii902x: Fix HDMI detection with DRM_BRIDGE_ATTACH_NO_CONNECTOR
Date: Tue, 7 Oct 2025 16:53:09 +0530
Message-ID: <20251007112309.1103811-1-devarsht@ti.com>
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
V3: Use drm_edid_connector_update without edid NULL check
V2: Use drm_edid_connector_update to detect HDMI

Link to V2:
https://lore.kernel.org/all/20251006150714.3144368-1-devarsht@ti.com/
Link to V1:
https://lore.kernel.org/all/20251003143642.4072918-1-devarsht@ti.com/

 drivers/gpu/drm/bridge/sii902x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index d537b1d036fb..bb613d4c281f 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -296,6 +296,8 @@ static const struct drm_edid *sii902x_edid_read(struct sii902x *sii902x,
 	mutex_lock(&sii902x->mutex);
 
 	drm_edid = drm_edid_read_ddc(connector, sii902x->i2cmux->adapter[0]);
+	drm_edid_connector_update(connector, drm_edid);
+	sii902x->sink_is_hdmi = connector->display_info.is_hdmi;
 
 	mutex_unlock(&sii902x->mutex);
 
@@ -309,14 +311,11 @@ static int sii902x_get_modes(struct drm_connector *connector)
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


