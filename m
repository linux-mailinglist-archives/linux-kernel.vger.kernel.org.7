Return-Path: <linux-kernel+bounces-742275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33547B0EF73
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9FF7BAC48
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02622D3EFB;
	Wed, 23 Jul 2025 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="e9lJ3tYR"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688982C15B3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265163; cv=none; b=b5BIb9qtmI8ANG2G21wmNbnnqci+UY6sCAgSgAHaKroqPZJmdA23gMEqUzb0iTOaaqYgZk5NaDJ9QVC+RPzAxSbA/mE/MLr2eqp51gxJLdXmtpBK7jYu/VYlTDVfIa66W8z5cgfhEIsel2/ljaiPSO59cHWqEvS9/OPwkAw+dQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265163; c=relaxed/simple;
	bh=TAARgGSo5VvgDvrqW//e5b9U1FyJn3Y3DDx/qPszZzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHgWxDxeFQzdyAYlkBXxtdSCqLbqUuq7tFz/UY468eOzBhu3IJUteFFNgMUgSO5zGMCnQ3UICTmOYfpPaYA4Y27eBvD7gCQtIbWrI/iJlL3EtbDu2wG/gcM6LzYz7cW/4986NYQsgnCaaQBFTnbCl6LtzHz8audzPgre2xGD8c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=e9lJ3tYR; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8D50F1121;
	Wed, 23 Jul 2025 12:05:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753265116;
	bh=TAARgGSo5VvgDvrqW//e5b9U1FyJn3Y3DDx/qPszZzo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e9lJ3tYRvIiN4gTbfsZ3EuAtZSOHFqiYGJ2ZDppdA3MT6nBWvTRH8URMhL/qfFUZ5
	 hFfQd2ICWmnEhODzG/7Rz6PzWzEiN7FYvpf8L5Tisy7+yYIyLn1wyWH9a6/hxdl6I/
	 Ug86gpJk1hotzRaH/JEA6Bx0ZCN7TnoEmNGzUdF8=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 23 Jul 2025 13:05:20 +0300
Subject: [PATCH v5 14/15] drm/bridge: cdns-dsi: Tune adjusted_mode->clock
 according to dsi needs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-cdns-dsi-impro-v5-14-e61cc06074c2@ideasonboard.com>
References: <20250723-cdns-dsi-impro-v5-0-e61cc06074c2@ideasonboard.com>
In-Reply-To: <20250723-cdns-dsi-impro-v5-0-e61cc06074c2@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3522;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=TAARgGSo5VvgDvrqW//e5b9U1FyJn3Y3DDx/qPszZzo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBogLPueytK2oz3NDrTGEBgDIlq2WgZ8+DGrC8FW
 ns9YV6xSfGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaICz7gAKCRD6PaqMvJYe
 9eriD/4pIHN9Rm3E0LzNDo8ZOx37832WGp4LtgcNRixqbv8JNK+htXIOChsdCJJHxkDZTCRkjbv
 TeHcgg1uBhIloppnLvT0myzktbfiIlAWTH4dZZmuhcbSEjNik1on8xV/8dgVBq/jQ7V1KIy8Iam
 oSNw7UICXJuzJMJ6oZeo+ZRFQbUvk4vYon9Lpri1nVVxtKkAcG5z/R+cDdX0ShePwLOvyiTWeRA
 kaV+4N5S/jYBPovTNUF5f3bBl5A53Iy3xYegMhoFt31qWm9wrP3i3zGesLBzR8v93GfkoWTnYoS
 bbQEPdB6gxHQahAXkTZUUA/HtVoiV5pwEIH44H/daLPxKunK7uupuCL8p9xQfYrrXNkac2775Na
 c3l2UIegAHSoVvvVcl8fGigSx4iz2iODGYbcQIhYhGW2O+GIRt8MET8hDv4QBtWBA3VyszLeFCA
 MsGWUs7w90QXf4PDDuZbhGFdKJ2yOASVzLtYWpGNF+oVmWbvzQR7+m2F1sRIueHvEtmiNP9Lwdx
 zRJwwIdDWE2HSYGO2qOnGrKijX69aXowTk6eQf9dtPRlJeEDvveXWo/uy9BXPyikK/6g0uI0JQy
 0NyzXFom1QnBqFnetK2FBqWdogyStM9LNFHTfRkk8FTUmGvX4REpjGvSL51p2Ni//o1ei09Fgk0
 nhnhzr8eHXKdz/w==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The driver currently expects the pixel clock and the HS clock to be
compatible, but the DPHY PLL doesn't give very finely grained rates.
This often leads to the situation where the pipeline just fails, as the
resulting HS clock is just too off.

We could change the driver to do a better job on adjusting the DSI
blanking values, hopefully getting a working pipeline even if the pclk
and HS clocks are not exactly compatible. But that is a bigger work.

What we can do easily is to see in .atomic_check() what HS clock rate we
can get, based on the pixel clock rate, and then convert the HS clock
rate back to pixel clock rate and ask that rate from the crtc. If the
crtc has a good PLL (which is the case for TI K3 SoCs), this will fix
any issues wrt. the clock rates.

If the crtc cannot provide the requested clock, well, we're no worse off
with this patch than what we have at the moment.

Tested-by: Parth Pancholi <parth.pancholi@toradex.com>
Tested-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 3bc4d011b4c6..114d883c65dc 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -915,6 +915,28 @@ static u32 *cdns_dsi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
 	return input_fmts;
 }
 
+static long cdns_dsi_round_pclk(struct cdns_dsi *dsi, unsigned long pclk)
+{
+	struct cdns_dsi_output *output = &dsi->output;
+	unsigned int nlanes = output->dev->lanes;
+	union phy_configure_opts phy_opts = { 0 };
+	u32 bitspp;
+	int ret;
+
+	bitspp = mipi_dsi_pixel_format_to_bpp(output->dev->format);
+
+	ret = phy_mipi_dphy_get_default_config(pclk, bitspp, nlanes,
+					       &phy_opts.mipi_dphy);
+	if (ret)
+		return ret;
+
+	ret = phy_validate(dsi->dphy, PHY_MODE_MIPI_DPHY, 0, &phy_opts);
+	if (ret)
+		return ret;
+
+	return div_u64((u64)phy_opts.mipi_dphy.hs_clk_rate * nlanes, bitspp);
+}
+
 static int cdns_dsi_bridge_atomic_check(struct drm_bridge *bridge,
 					struct drm_bridge_state *bridge_state,
 					struct drm_crtc_state *crtc_state,
@@ -926,11 +948,26 @@ static int cdns_dsi_bridge_atomic_check(struct drm_bridge *bridge,
 	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
 	struct cdns_dsi_cfg *dsi_cfg = &dsi_state->dsi_cfg;
 	struct videomode vm;
+	long pclk;
 
 	/* cdns-dsi requires negative syncs */
 	adjusted_mode->flags &= ~(DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
 	adjusted_mode->flags |= DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC;
 
+	/*
+	 * The DPHY PLL has quite a coarsely grained clock rate options. See
+	 * what hsclk rate we can achieve based on the pixel clock, convert it
+	 * back to pixel clock, set that to the adjusted_mode->clock. This is
+	 * all in hopes that the CRTC will be able to provide us the requested
+	 * clock, as otherwise the DPI and DSI clocks will be out of sync.
+	 */
+
+	pclk = cdns_dsi_round_pclk(dsi, adjusted_mode->clock * 1000);
+	if (pclk < 0)
+		return (int)pclk;
+
+	adjusted_mode->clock = pclk / 1000;
+
 	drm_display_mode_to_videomode(adjusted_mode, &vm);
 
 	return cdns_dsi_check_conf(dsi, &vm, dsi_cfg);

-- 
2.43.0


