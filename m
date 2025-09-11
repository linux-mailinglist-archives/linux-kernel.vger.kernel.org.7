Return-Path: <linux-kernel+bounces-811903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD818B52F95
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638E9A031F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4208311942;
	Thu, 11 Sep 2025 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JKT2UrZ3"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE3F3115BC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588892; cv=none; b=JggF2cm7LvJHPlzi9msx1n+wX/mNRiBDfdZ/msEk3A1w6gztx4k7P/w5SxUo5xVUv++tHIEluYsme7bbiTSHpwi2Cc7UrOhPjbywT8gLYhwWU0DeFeghS0a2DrnRzosaDjM9A5N0caDy8uKAdQuRyHOOMRx8Gl97MMqV37HzZ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588892; c=relaxed/simple;
	bh=abTsncboxoliomRCfbh7TuigNLZE3C3mR4XD03tCFMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DF/ujsUkzX5gYYyB6w61jkPVjxiEtHsdlnUCm24JiAsh2l82osJdLHzTz3TDlzsMkwQZud3AS+EJnNtY4CWWevVVImmp/VPN9vSrzBK5RGG90oiwSB1gUebZEyK1x1Xbx52xeL92flvEAQ3V6DxsiRuAqTP9D2y+maDceJIdiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JKT2UrZ3; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BB7aZU789617;
	Thu, 11 Sep 2025 06:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757588856;
	bh=uoECzCi0KYXpbNKQqTVn4uD0rKnPiWLWGwsfZoKZLgo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JKT2UrZ3nRoWRq1DMkqvHMvFY72wnmagKzfHFUAH5s98k/yX/Gw9Baju6bVzExUWX
	 7G94P2Xmo2CVZGg5c3gQJHsC4OQO5s2Eu4cH5JNHAyJIHE0MMeb50367u+hfmXnKk7
	 7rySWO63JhYh2DS2OZv9N5CR8yp7Fz0CbMC4X9oQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BB7a6r1112666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 11 Sep 2025 06:07:36 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 06:07:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 06:07:36 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BB7FP62031347;
	Thu, 11 Sep 2025 06:07:31 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <aradhya.bhatia@linux.dev>
CC: <h-shenoy@ti.com>, <devarsht@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
        <u-kumar1@ti.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <s-jain1@ti.com>
Subject: [PATCH v6 3/3] drm/tidss: oldi: Add atomic_check hook for oldi bridge
Date: Thu, 11 Sep 2025 16:37:15 +0530
Message-ID: <20250911110715.2873596-4-s-jain1@ti.com>
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

Since OLDI consumes DSS VP clock directly as serial clock, mode_valid()
check cannot be performed in tidss driver which should be checked
in OLDI driver.

Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
Tested-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 drivers/gpu/drm/tidss/tidss_oldi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 7ecbb2c3d0a2..ada691839ef3 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -309,6 +309,26 @@ static u32 *tidss_oldi_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
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
+	round_clock = clk_round_rate(oldi->serial, adjusted_mode->clock * 7 * 1000);
+	/*
+	 * To keep the check consistent with dispc_vp_set_clk_rate(),
+	 * we use the same 5% check here.
+	 */
+	if (dispc_pclk_diff(adjusted_mode->clock * 7 * 1000, round_clock) > 5)
+		return -EINVAL;
+	return 0;
+}
+
 static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
 	.attach	= tidss_oldi_bridge_attach,
 	.atomic_pre_enable = tidss_oldi_atomic_pre_enable,
@@ -317,6 +337,7 @@ static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_check = tidss_oldi_atomic_check,
 };
 
 static int get_oldi_mode(struct device_node *oldi_tx, int *companion_instance)

