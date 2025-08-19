Return-Path: <linux-kernel+bounces-776400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A43AB2CCE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8DB24E4834
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E2335BA3;
	Tue, 19 Aug 2025 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YPLEpoOg"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C0C30C36D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631328; cv=none; b=P9Vsd5cP24TURUUr/lj8dhu48DvN1ZngE0OzFpOiE9jFR4Ojqqi42btArzJAv7bSYtreRVwTI6HNxEqRv1VuPrU9p9fxiUwjG9Pd6uehq0WJJ6pHScbLHgisJk+mbPfVVhiNsU+8UWQ1oDKK29SIDvUQpaU0hPxWaRNJ1y79WCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631328; c=relaxed/simple;
	bh=pqqPptYID/uBLYFPDtBBa5eI0JLa1ASclCxbm2h8UUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBi9OiWUSpuRpqngBNtcwzJu0yyMjsruooej+7YHLkdwuVdblt1Gp7/QfrR/YJpZbFh6Hqw5xKl0YLcJJPRTBykvrt5IyfRXhJ57n7KBcr92DgsKObAuwiordRRsbh8BqqsuB1Eo7Dz6iXkPpU7rE0J6IjgcRFlQwcuBZ8pxoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YPLEpoOg; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JJLPal078555;
	Tue, 19 Aug 2025 14:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755631285;
	bh=vVOO6khqKk6iQpJs0Jq4UkrjuDFbeX59ixEiFbuwTAU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YPLEpoOgecseLQI4CAp+ECg7gj7rQAbuDBty3v65JCZzBkd4sOh4FCwlUUtDLgj/h
	 sO3CqJuxFzEHTAjEUUQ907WeI83k+C1e+yfUu9jEa3O6DRabLIHFH4eRAfJ+K0CZbl
	 9+n05g0lXHrLIla+J/jPd6zf/aXmTBBAED//Ugu0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JJLOIm1494144
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 14:21:24 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 14:21:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 14:21:24 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JJLEiE3205034;
	Tue, 19 Aug 2025 14:21:19 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <aradhya.bhatia@linux.dev>
CC: <h-shenoy@ti.com>, <devarsht@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
        <u-kumar1@ti.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <s-jain1@ti.com>
Subject: [PATCH v5 1/3] drm/tidss: oldi: Add property to identify OLDI supported VP
Date: Wed, 20 Aug 2025 00:51:11 +0530
Message-ID: <20250819192113.2420396-2-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819192113.2420396-1-s-jain1@ti.com>
References: <20250819192113.2420396-1-s-jain1@ti.com>
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

TIDSS should know which VP has OLDI output to avoid calling clock
functions for that VP as those are controlled by OLDI driver. Add a
property "is_ext_vp_clk" to "tidss_device" structure for that. Mark it
'true' in tidss_oldi_init() and 'false' in tidss_oldi_deinit().

Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 drivers/gpu/drm/tidss/tidss_drv.h  | 2 ++
 drivers/gpu/drm/tidss/tidss_oldi.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.h b/drivers/gpu/drm/tidss/tidss_drv.h
index d14d5d28f0a3..4e38cfa99e84 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.h
+++ b/drivers/gpu/drm/tidss/tidss_drv.h
@@ -22,6 +22,8 @@ struct tidss_device {
 
 	const struct dispc_features *feat;
 	struct dispc_device *dispc;
+	bool is_ext_vp_clk[TIDSS_MAX_PORTS];
+
 
 	unsigned int num_crtcs;
 	struct drm_crtc *crtcs[TIDSS_MAX_PORTS];
diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 8f25159d0666..ef01ecc17a12 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -430,6 +430,7 @@ void tidss_oldi_deinit(struct tidss_device *tidss)
 	for (int i = 0; i < tidss->num_oldis; i++) {
 		if (tidss->oldis[i]) {
 			drm_bridge_remove(&tidss->oldis[i]->bridge);
+			tidss->is_ext_vp_clk[tidss->oldis[i]->parent_vp] = false;
 			tidss->oldis[i] = NULL;
 		}
 	}
@@ -581,6 +582,7 @@ int tidss_oldi_init(struct tidss_device *tidss)
 		oldi->bridge.timings = &default_tidss_oldi_timings;
 
 		tidss->oldis[tidss->num_oldis++] = oldi;
+		tidss->is_ext_vp_clk[oldi->parent_vp] = true;
 		oldi->tidss = tidss;
 
 		drm_bridge_add(&oldi->bridge);

