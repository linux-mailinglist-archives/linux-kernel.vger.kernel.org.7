Return-Path: <linux-kernel+bounces-811902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CDFB52F91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05A1487EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A758319845;
	Thu, 11 Sep 2025 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I/7RTDxh"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BC53176F4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588876; cv=none; b=fZR/YSzvhRvtD1IocIveilElQ1ceCnYrperhEwRa7n56gDs34LWpZf3N2qSu42i0QLKIzXgqksJ9ModVk6zAfgvzvTXF/3sdiFmRW/OxbZLz0Er1qFkPEvm7IuCCBVMyeY2ELiACTwho7P6b2X1Zuo2deNYqztrm4txNJmmVwZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588876; c=relaxed/simple;
	bh=rtoGwOGvgmKInZwM2Qm8/5eaQawmdlilvfZFMjo8T2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ms194cUi6bCXVXG6KaH/zYJ3lDPlQzNr3gElvrhccqly77W+qgMCjrKHupSiaL6+OnmLMBekK8JCxJHjWRpxlXrjqmnY4/udDqm0lY2i0j0rTGjdyEsOPUZKBMa9XBBzstM4MNLQZmFePwIZJ6hPANacHfMz5yO5oGBUN4K6n+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I/7RTDxh; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BB7QKe731290;
	Thu, 11 Sep 2025 06:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757588846;
	bh=qO+VhbXYIysM2Mf7i4Pp5L1ZOP0kI1GsjnLInfeFpJ8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=I/7RTDxhnUle8n/jj5EV6rWz0Pfn0av/6BphDkeFSeYZ9IaELbMEjsclmpy2Srfrw
	 D6WhyjcvHO0XVkZRKCb/e0kl7DfmFWOkapDpVXGJVuO1VBC2J5G75y4NvYbVJStc4C
	 pQZPg97g7OZ82GB+znrkc/FRbPRUp/fMGvrISlPw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BB7QbV1895185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 11 Sep 2025 06:07:26 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 06:07:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 06:07:26 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BB7FP42031347;
	Thu, 11 Sep 2025 06:07:21 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <aradhya.bhatia@linux.dev>
CC: <h-shenoy@ti.com>, <devarsht@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
        <u-kumar1@ti.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <s-jain1@ti.com>
Subject: [PATCH v6 1/3] drm/tidss: oldi: Add property to identify OLDI supported VP
Date: Thu, 11 Sep 2025 16:37:13 +0530
Message-ID: <20250911110715.2873596-2-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911110715.2873596-1-s-jain1@ti.com>
References: <20250911110715.2873596-1-s-jain1@ti.com>
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
functions for that VP as those are controlled by oldi driver. Add a
property "is_ext_vp_clk" to "tidss_device" structure for that. Mark it
'true' in tidss_oldi_init() and 'false' in tidss_oldi_deinit().

Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
Tested-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 drivers/gpu/drm/tidss/tidss_drv.h  | 2 ++
 drivers/gpu/drm/tidss/tidss_oldi.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.h b/drivers/gpu/drm/tidss/tidss_drv.h
index 84454a4855d1..e1c1f41d8b4b 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.h
+++ b/drivers/gpu/drm/tidss/tidss_drv.h
@@ -24,6 +24,8 @@ struct tidss_device {
 
 	const struct dispc_features *feat;
 	struct dispc_device *dispc;
+	bool is_ext_vp_clk[TIDSS_MAX_PORTS];
+
 
 	unsigned int num_crtcs;
 	struct drm_crtc *crtcs[TIDSS_MAX_PORTS];
diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 7688251beba2..7ecbb2c3d0a2 100644
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
@@ -580,6 +581,7 @@ int tidss_oldi_init(struct tidss_device *tidss)
 		oldi->bridge.timings = &default_tidss_oldi_timings;
 
 		tidss->oldis[tidss->num_oldis++] = oldi;
+		tidss->is_ext_vp_clk[oldi->parent_vp] = true;
 		oldi->tidss = tidss;
 
 		drm_bridge_add(&oldi->bridge);

