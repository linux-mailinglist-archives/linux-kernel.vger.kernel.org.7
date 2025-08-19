Return-Path: <linux-kernel+bounces-776399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE55B2CCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68821C202B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9AC322C69;
	Tue, 19 Aug 2025 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F2DWWTFm"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B09251791
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631327; cv=none; b=fxOq6pkB8IGJR/08TV6uPXSdredQPHcf5LWN5ABEci2JW3Y2j1N6XuBAGXH4sGLcJf3hPB2rFkR6tqsrYLZEe6MpiqqBgXQXAnKAGFufMVVszZuEVyLW5PqF4B1r45blJSCRJzgEZA7tpRuSkbTc+7rzHGnj5tlrpJ3LERCuQL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631327; c=relaxed/simple;
	bh=JvG79/A18JiNVCCW/b9XFoktP0r4/BnCxJrroqcW3NQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiAvu80pCIhzkyYI8loCOMjE+NXtfkG4j0w6s7s40DpuoTcGmujp9MFcuCzCg3D5zQ/w4WOH+HefmCVCE10URdGLuwi5aTZjGRp4yL+wqyPKVI4/ZQpKv3ZCGcgdhHwGZpeLo7KwHVTjcqsnoI2JhHHVCarNYw6RZ1rUWUgSU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=F2DWWTFm; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JJLYJd077505;
	Tue, 19 Aug 2025 14:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755631294;
	bh=KEWtfyyQkT9tRZpfdG7hNcR2xGLiowOykyBqNg1YDaU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=F2DWWTFmX+4R9qWF0a7DcuyfRe8u7NloGSWCNdx+fyN2FqrgI+8qgboLGKctLl9EI
	 9RmNSV+D2/5K5mEKeBcMd18105rxZqF4B3ZuSWOGTayF+j378YRTZwmsw5OuPLVuSE
	 tr4FZGvTBTFs8zC67XiJwg+YbqvFB1vCzCOJ2hj4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JJLYk81494171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 14:21:34 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 14:21:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 14:21:33 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JJLEiG3205034;
	Tue, 19 Aug 2025 14:21:29 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <aradhya.bhatia@linux.dev>
CC: <h-shenoy@ti.com>, <devarsht@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
        <u-kumar1@ti.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <s-jain1@ti.com>
Subject: [PATCH v5 3/3] drm/tidss: oldi: Add atomic_check hook for oldi bridge
Date: Wed, 20 Aug 2025 00:51:13 +0530
Message-ID: <20250819192113.2420396-4-s-jain1@ti.com>
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

Since OLDI consumes DSS VP clock directly as serial clock, certain
checks cannot be performed in tidss driver which should be checked
in OLDI driver. Add check for mode clock and set max_successful_rate
and max_attempted_rate field for tidss in case the VP is OLDI.

Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 drivers/gpu/drm/tidss/tidss_oldi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index ef01ecc17a12..2ed2d0666ccb 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -309,6 +309,30 @@ static u32 *tidss_oldi_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	return input_fmts;
 }
 
+static int tidss_oldi_atomic_check(struct drm_bridge *bridge,
+				   struct drm_bridge_state *bridge_state,
+				   struct drm_crtc_state *crtc_state,
+				   struct drm_connector_state *conn_state)
+{
+	struct tidss_oldi *oldi = drm_bridge_to_tidss_oldi(bridge);
+	struct drm_display_mode *adjusted_mode;
+	unsigned long round_clock;
+
+	adjusted_mode = &crtc_state->adjusted_mode;
+
+	if (adjusted_mode->clock > oldi->tidss->max_successful_rate[oldi->parent_vp]) {
+		round_clock = clk_round_rate(oldi->serial, adjusted_mode->clock * 7 * 1000);
+
+		if (dispc_pclk_diff(adjusted_mode->clock * 7 * 1000, round_clock) > 5)
+			return -EINVAL;
+
+		oldi->tidss->max_successful_rate[oldi->parent_vp] = round_clock;
+		oldi->tidss->max_attempted_rate[oldi->parent_vp] = adjusted_mode->clock * 7 * 1000;
+	}
+
+	return 0;
+}
+
 static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
 	.attach	= tidss_oldi_bridge_attach,
 	.atomic_pre_enable = tidss_oldi_atomic_pre_enable,
@@ -317,6 +341,7 @@ static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_check = tidss_oldi_atomic_check,
 };
 
 static int get_oldi_mode(struct device_node *oldi_tx, int *companion_instance)

