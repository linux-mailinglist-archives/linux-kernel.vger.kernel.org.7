Return-Path: <linux-kernel+bounces-841401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10250BB7359
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3731B202F8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AC920F08D;
	Fri,  3 Oct 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cPuHCayY"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEB51E2834
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502242; cv=none; b=octHsPq16kaRbBXyZilODDLcxWcqCZ/KraR8IV4ydTw/2BPVBK7n5tpV2cb26Lo65JGBYXNyt2O8wyRck2pEDZb81Qw93twkOD5EzFL0o++ioi1bwy4Cb3jLNcTgV6Wdu1veo1HAYhufR47WddpFNN9VHIC0BjHQpYWtaTyNfkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502242; c=relaxed/simple;
	bh=YecjOBPir7TQVu1swnAX28W6RvTOlunwfIAzG2xu5y4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bo6Ehl3fMDJdbaNB2u2OuPYwkyb0NWR4aDYDkhhfE4guGnTgZ6WySXUPEFitOPqdCuyLBpKgzP9BmGOLn9bod4mXqCiyi9Oh0rs9Gd1zmbuxxtuWk7KBh1/XulfU0+aH0OXpP1MSO1QredkawIKzGGU1IenOwk609zL9I9w2haE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cPuHCayY; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 593EajN53108431;
	Fri, 3 Oct 2025 09:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759502205;
	bh=eRtwW9kgEmfhupb6hjqTLv6iszrEJJkIhoAnFqn8n3A=;
	h=From:To:CC:Subject:Date;
	b=cPuHCayYoQazD6DeLfmxdU8jEVMZVThf/aEtKFTL2LphdcLYkF8HSZFznHOYxnn8N
	 F88DQVxiIiJPl0WBGx6sU1YScfyrnkjnof82KNfNeyvI4oEYZiZodOE3klQFcd8Pa+
	 8/kknAK8yFw24k/vX0/LHuog1BCCgAwiO/7tVtdU=
Received: from DLEE210.ent.ti.com (dlee210.ent.ti.com [157.170.170.112])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 593EaiHO821490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Oct 2025 09:36:44 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Oct
 2025 09:36:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 3 Oct 2025 09:36:44 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.233.157] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 593EahG43514627;
	Fri, 3 Oct 2025 09:36:44 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <airlied@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <simona@ffwll.ch>,
        <linux-kernel@vger.kernel.org>
CC: <tomi.valkeinen@ideasonboard.com>, <jani.nikula@intel.com>,
        <praneeth@ti.com>, <vigneshr@ti.com>, <aradhya.bhatia@linux.dev>,
        <s-jain1@ti.com>, <s-wang12@ti.com>, <r-donadkar@ti.com>,
        <h-shenoy@ti.com>, <devarsht@ti.com>
Subject: [PATCH] drm/bridge: sii902x: Fix HDMI detection with DRM_BRIDGE_ATTACH_NO_CONNECTOR
Date: Fri, 3 Oct 2025 20:06:42 +0530
Message-ID: <20251003143642.4072918-1-devarsht@ti.com>
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
 drivers/gpu/drm/bridge/sii902x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index d537b1d036fb..3d169b9fac70 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -292,10 +292,16 @@ static const struct drm_edid *sii902x_edid_read(struct sii902x *sii902x,
 						struct drm_connector *connector)
 {
 	const struct drm_edid *drm_edid;
+	const struct edid *edid;
 
 	mutex_lock(&sii902x->mutex);
 
 	drm_edid = drm_edid_read_ddc(connector, sii902x->i2cmux->adapter[0]);
+	if (drm_edid) {
+		edid = drm_edid_raw(drm_edid);
+		if (edid && drm_detect_hdmi_monitor(edid))
+			sii902x->sink_is_hdmi = true;
+	}
 
 	mutex_unlock(&sii902x->mutex);
 
@@ -315,8 +321,6 @@ static int sii902x_get_modes(struct drm_connector *connector)
 		drm_edid_free(drm_edid);
 	}
 
-	sii902x->sink_is_hdmi = connector->display_info.is_hdmi;
-
 	return num;
 }
 
-- 
2.39.1


