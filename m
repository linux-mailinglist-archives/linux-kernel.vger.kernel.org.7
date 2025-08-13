Return-Path: <linux-kernel+bounces-767115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 791D8B24F87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970395C8309
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A94B288C0D;
	Wed, 13 Aug 2025 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="chhraYuh"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D22877C3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101782; cv=none; b=IRlNKekm4SnYL5RSSx9WoqwqSXIudNru46cWDOrWX61z0Y+i14lYnJ8kH7483CDLOaazhgjfzEB08FFds2CIyAImN3yBfXgtLM5DSxNAzxfqZdbV1pmw4yAXxznMl8IfnHjBQ7dYMYDBbCRlcPb7XoD8DiKm1tw+qCJm1YRGDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101782; c=relaxed/simple;
	bh=FIeAx184lp1cPCMahPnkFsmHFENmSOnDHKo8FH6kVEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enVCC59+/oRuFPdw5LP1tG2izpXPofZrzog9gHzIAttRmAErMllLHl/YAhgA4VUWrg5BPEafzw0nOxmySFkShu+yg3efqq8NsWXY8nav5rwCriXgOiK2+XTnYkGc6a+n0nYSnqEOCsFVZG7F09YHWFgfJrIgMiORvLK531GELMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=chhraYuh; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=rscZdjzTgJUz3a4ulIohYT16Ky1iRHb8vU8CbuiEAr8=; b=chhraY
	uh/3c4VVm9mVdF1HCsLk4fzgNFY07jnXOJdMstzCTZsjz21F3ZHHwvIT1geOTMP4
	rvs500bmH5X/qcdPN+qshRgTGQx9pkBt2/6zdZ8xxD42gCZd7UbXybBtAvDNVLNR
	hwS/eOPhraUjsS/ikE9c7cpxHL48h4HDSLJK3xPsEBCDs/6FdFeTbF/iCfsU1CK3
	TA21zQ0qpuWZ+o9DRfDQrld8xA/mHWksgxBrRCv/BLbwt1akZoiA0/bTRAQxQFQc
	CMzzG/k8dDrjb8wirxizHSJtgK7/vr/B07cRRWLcnRHe2nx60V+/RYMYCmGZh7Vr
	nQ/2YhnvWDglODYA==
Received: (qmail 694707 invoked from network); 13 Aug 2025 18:16:04 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Aug 2025 18:16:04 +0200
X-UD-Smtp-Session: l3s3148p1@VvoxeUE8JpVtKLKq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Liu Ying <victor.liu@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 04/21] drm: remove unneeded 'fast_io' parameter in regmap_config
Date: Wed, 13 Aug 2025 18:14:50 +0200
Message-ID: <20250813161517.4746-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using MMIO with regmap, fast_io is implied. No need to set it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
No dependencies, can be applied directly to the subsystem tree. Buildbot is
happy, too.

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c   | 1 -
 drivers/gpu/drm/imx/dc/dc-cf.c                   | 1 -
 drivers/gpu/drm/imx/dc/dc-de.c                   | 1 -
 drivers/gpu/drm/imx/dc/dc-ed.c                   | 2 --
 drivers/gpu/drm/imx/dc/dc-fg.c                   | 1 -
 drivers/gpu/drm/imx/dc/dc-fl.c                   | 1 -
 drivers/gpu/drm/imx/dc/dc-fw.c                   | 2 --
 drivers/gpu/drm/imx/dc/dc-ic.c                   | 1 -
 drivers/gpu/drm/imx/dc/dc-lb.c                   | 2 --
 drivers/gpu/drm/imx/dc/dc-tc.c                   | 1 -
 drivers/gpu/drm/imx/ipuv3/imx-tve.c              | 2 --
 drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c | 1 -
 12 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
index 5926a3a05d79..d046740a1d57 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
@@ -903,7 +903,6 @@ static const struct regmap_config dw_mipi_dsi2_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.fast_io = true,
 };
 
 static struct dw_mipi_dsi2 *
diff --git a/drivers/gpu/drm/imx/dc/dc-cf.c b/drivers/gpu/drm/imx/dc/dc-cf.c
index 2f077161e912..6431ecd442c9 100644
--- a/drivers/gpu/drm/imx/dc/dc-cf.c
+++ b/drivers/gpu/drm/imx/dc/dc-cf.c
@@ -45,7 +45,6 @@ static const struct regmap_config dc_cf_cfg_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.wr_table = &dc_cf_regmap_access_table,
 	.rd_table = &dc_cf_regmap_access_table,
 	.max_register = CONSTANTCOLOR,
diff --git a/drivers/gpu/drm/imx/dc/dc-de.c b/drivers/gpu/drm/imx/dc/dc-de.c
index 5a3125596fdf..7a93dda20c59 100644
--- a/drivers/gpu/drm/imx/dc/dc-de.c
+++ b/drivers/gpu/drm/imx/dc/dc-de.c
@@ -37,7 +37,6 @@ static const struct regmap_config dc_de_top_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.wr_table = &dc_de_regmap_access_table,
 	.rd_table = &dc_de_regmap_access_table,
 	.max_register = POLARITYCTRL,
diff --git a/drivers/gpu/drm/imx/dc/dc-ed.c b/drivers/gpu/drm/imx/dc/dc-ed.c
index 86ecc22d0a55..4d86a886d47e 100644
--- a/drivers/gpu/drm/imx/dc/dc-ed.c
+++ b/drivers/gpu/drm/imx/dc/dc-ed.c
@@ -77,7 +77,6 @@ static const struct regmap_config dc_ed_pec_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.wr_table = &dc_ed_pec_regmap_write_table,
 	.rd_table = &dc_ed_pec_regmap_read_table,
 	.volatile_table = &dc_ed_pec_regmap_volatile_table,
@@ -99,7 +98,6 @@ static const struct regmap_config dc_ed_cfg_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.wr_table = &dc_ed_regmap_access_table,
 	.rd_table = &dc_ed_regmap_access_table,
 	.max_register = CONTROL,
diff --git a/drivers/gpu/drm/imx/dc/dc-fg.c b/drivers/gpu/drm/imx/dc/dc-fg.c
index 7f6c1852bf72..24826d676c5c 100644
--- a/drivers/gpu/drm/imx/dc/dc-fg.c
+++ b/drivers/gpu/drm/imx/dc/dc-fg.c
@@ -122,7 +122,6 @@ static const struct regmap_config dc_fg_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.wr_table = &dc_fg_regmap_write_table,
 	.rd_table = &dc_fg_regmap_read_table,
 	.max_register = FGCHSTATCLR,
diff --git a/drivers/gpu/drm/imx/dc/dc-fl.c b/drivers/gpu/drm/imx/dc/dc-fl.c
index 3ce24c72aa13..003476ac2fa1 100644
--- a/drivers/gpu/drm/imx/dc/dc-fl.c
+++ b/drivers/gpu/drm/imx/dc/dc-fl.c
@@ -49,7 +49,6 @@ static const struct regmap_config dc_fl_cfg_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.wr_table = &dc_fl_regmap_access_table,
 	.rd_table = &dc_fl_regmap_access_table,
 	.max_register = FRAMEDIMENSIONS,
diff --git a/drivers/gpu/drm/imx/dc/dc-fw.c b/drivers/gpu/drm/imx/dc/dc-fw.c
index acb2d4d9e2ec..96bc3c7c8f9b 100644
--- a/drivers/gpu/drm/imx/dc/dc-fw.c
+++ b/drivers/gpu/drm/imx/dc/dc-fw.c
@@ -51,7 +51,6 @@ static const struct regmap_config dc_fw_pec_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.wr_table = &dc_fw_pec_regmap_access_table,
 	.rd_table = &dc_fw_pec_regmap_access_table,
 	.max_register = PIXENGCFG_DYNAMIC,
@@ -72,7 +71,6 @@ static const struct regmap_config dc_fw_cfg_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.wr_table = &dc_fw_regmap_access_table,
 	.rd_table = &dc_fw_regmap_access_table,
 	.max_register = CONTROL,
diff --git a/drivers/gpu/drm/imx/dc/dc-ic.c b/drivers/gpu/drm/imx/dc/dc-ic.c
index a270ae4030cd..f1c371a95cae 100644
--- a/drivers/gpu/drm/imx/dc/dc-ic.c
+++ b/drivers/gpu/drm/imx/dc/dc-ic.c
@@ -76,7 +76,6 @@ static const struct regmap_config dc_ic_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.wr_table = &dc_ic_regmap_write_table,
 	.rd_table = &dc_ic_regmap_read_table,
 	.volatile_table = &dc_ic_regmap_volatile_table,
diff --git a/drivers/gpu/drm/imx/dc/dc-lb.c b/drivers/gpu/drm/imx/dc/dc-lb.c
index 38f966625d38..9fd39f824f11 100644
--- a/drivers/gpu/drm/imx/dc/dc-lb.c
+++ b/drivers/gpu/drm/imx/dc/dc-lb.c
@@ -92,7 +92,6 @@ static const struct regmap_config dc_lb_pec_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.wr_table = &dc_lb_pec_regmap_access_table,
 	.rd_table = &dc_lb_pec_regmap_access_table,
 	.max_register = PIXENGCFG_DYNAMIC,
@@ -112,7 +111,6 @@ static const struct regmap_config dc_lb_cfg_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.wr_table = &dc_lb_regmap_access_table,
 	.rd_table = &dc_lb_regmap_access_table,
 	.max_register = POSITION,
diff --git a/drivers/gpu/drm/imx/dc/dc-tc.c b/drivers/gpu/drm/imx/dc/dc-tc.c
index 0bfd381b2cea..54b56dadbe36 100644
--- a/drivers/gpu/drm/imx/dc/dc-tc.c
+++ b/drivers/gpu/drm/imx/dc/dc-tc.c
@@ -44,7 +44,6 @@ static const struct regmap_config dc_tc_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.wr_table = &dc_tc_regmap_access_table,
 	.rd_table = &dc_tc_regmap_access_table,
 	.max_register = MAPBIT31_28,
diff --git a/drivers/gpu/drm/imx/ipuv3/imx-tve.c b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
index c5629e155d25..b34037d0d7a8 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
@@ -457,8 +457,6 @@ static struct regmap_config tve_regmap_config = {
 
 	.readable_reg = imx_tve_readable_reg,
 
-	.fast_io = true,
-
 	.max_register = 0xdc,
 };
 
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
index cdd490778756..a30d973f925f 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
@@ -368,7 +368,6 @@ static const struct regmap_config dw_mipi_dsi2_rockchip_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.fast_io = true,
 };
 
 static int dw_mipi_dsi2_rockchip_probe(struct platform_device *pdev)
-- 
2.47.2


