Return-Path: <linux-kernel+bounces-720241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B932AFB905
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6944A5EFE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A642356A4;
	Mon,  7 Jul 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="AIKF8kQR"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F477233737;
	Mon,  7 Jul 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906989; cv=none; b=QH1jwPmvoxP/Qc1TshUV+lv+3netYYxQOwP/+8WLLOT7YsBxmPY/VE2Ot0POyTGsEJNtYSUH6bFPuSeb+jb4Ca2+/l+HtRF+2+2Q/YGI6+gqugxvdEFUYNg+V5dz1e7nXjOrejvKZfONn5hvCjqyTyAg3HyUwKC6osfk/06qN4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906989; c=relaxed/simple;
	bh=buO8iFOzPG0Hv2jwbinSmPF51YI6H9mT+HmKeO6CpD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5FEfZsho9FWpqlE70u7LvAwxEaPRHrJhlCiGfcZkhmPfKBrmt2WfD0gblwtFdc1MNMN2adlbVaYL+VX1szRFF70O02qP5X+rINuaUYkdsxcN5I0auep0YrQH+PQ1KFEulHQW5zLZKYmZsQ+a3N3yNNNtGMle5mVePdZocnCcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=AIKF8kQR; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=YpitKWsGYdvkCnrR1mHFS1FP2h9VNXePXRkQPh7Xnq8=; b=AIKF8kQRHi8mNwcFM+zhxqLyl6
	Ge/ez06ZIr4EFSDUVGczPLCZiaO3f+uSZ/kjawcOUBkqqKpCWZmXisTdeZhMnqsvmmQa3W84mTdOl
	MepxtMwXCbvF4G4403s+qSumq4ZnBZZ9K0wbi8Igi7UHOjqfIUYTeyyy+qNjHUQDHo6s+Z0xbx2mk
	5e0BZm/C0w33YqocUYHABh26i0o7cTQHBrrd1Dhrn6BnMVAAu8WgeUqEJuPu5lUQNYrxVY2OPy0GQ
	OAyekpgppxNmuEd7UKIG3qkt/GJ0x9fy8Rea+CNQH8R0AYcbVI/L7I98pr9USHRgf0e7CZInB0mf5
	7vUZrHxw==;
Received: from i53875bf5.versanet.de ([83.135.91.245] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uYp1q-0004yl-A5; Mon, 07 Jul 2025 18:49:18 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	andyshrk@163.com,
	nicolas.frattaroli@collabora.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 02/13] drm/panel: ilitek-ili9881c: move display_on/_off dcs calls to (un-)prepare
Date: Mon,  7 Jul 2025 18:48:55 +0200
Message-ID: <20250707164906.1445288-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250707164906.1445288-1-heiko@sntech.de>
References: <20250707164906.1445288-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At least for panel-bridges, the atomic_enable call is defined as being
called right after the preceding element in the display pipe is enabled.

It is also stated that "The bridge can assume that the display pipe (i.e.
clocks and timing signals) feeding it is running when this callback is
called"

This means the DSI controller driving this display would have already
switched over to video-mode from command mode and thus dcs functions
should not be called anymore at this point.

This caused a non-working display for me, when trying to enable
the rk3576 dsi controller using a display using this controller.

Therefore move the display_on/off calls the more appropriate
prepare/unprepare callbacks.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 27 +++++--------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index d7a17dca2a9c..a20b52181ea0 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -1315,35 +1315,24 @@ static int ili9881c_prepare(struct drm_panel *panel)
 	if (ret)
 		goto disable_power;
 
-	return 0;
-
-disable_power:
-	regulator_disable(ctx->power);
-	return ret;
-}
-
-static int ili9881c_enable(struct drm_panel *panel)
-{
-	struct ili9881c *ctx = panel_to_ili9881c(panel);
-
 	msleep(120);
 
-	mipi_dsi_dcs_set_display_on(ctx->dsi);
+	ret = mipi_dsi_dcs_set_display_on(ctx->dsi);
+	if (ret)
+		goto disable_power;
 
 	return 0;
-}
 
-static int ili9881c_disable(struct drm_panel *panel)
-{
-	struct ili9881c *ctx = panel_to_ili9881c(panel);
-
-	return mipi_dsi_dcs_set_display_off(ctx->dsi);
+disable_power:
+	regulator_disable(ctx->power);
+	return ret;
 }
 
 static int ili9881c_unprepare(struct drm_panel *panel)
 {
 	struct ili9881c *ctx = panel_to_ili9881c(panel);
 
+	mipi_dsi_dcs_set_display_off(ctx->dsi);
 	mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
 	regulator_disable(ctx->power);
 	gpiod_set_value_cansleep(ctx->reset, 1);
@@ -1499,8 +1488,6 @@ static enum drm_panel_orientation ili9881c_get_orientation(struct drm_panel *pan
 static const struct drm_panel_funcs ili9881c_funcs = {
 	.prepare	= ili9881c_prepare,
 	.unprepare	= ili9881c_unprepare,
-	.enable		= ili9881c_enable,
-	.disable	= ili9881c_disable,
 	.get_modes	= ili9881c_get_modes,
 	.get_orientation = ili9881c_get_orientation,
 };
-- 
2.47.2


