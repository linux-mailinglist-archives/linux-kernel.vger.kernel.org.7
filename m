Return-Path: <linux-kernel+bounces-795860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAB5B3F8B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D931A171C68
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8982EC57E;
	Tue,  2 Sep 2025 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPbTkk3B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2A82EC572
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802054; cv=none; b=Rvhvdy/1K1GmTz50agLDt3yjkodSxVb/B/8sfBIccz2+S4WbLz5RUnMtr30c7hIvKhq8GooGWwX/PubLdbyK0XeTR+VY3fHI22D6dxxq3AOZaqJKpKKUvfntxcNq9DTvOCyZ6oUW7M+CPk21WCBmUCxhMJ8GBsTwZW+rI9y8/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802054; c=relaxed/simple;
	bh=8MPmTxUTV3g1rzAZxNPkLlwzM2lhv8IEy3sLqM4qcjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A99GobEs5Ttdx30uBfX21eGtU+qrfUWJb6HwykY31uYpMQnQp1r861zMV1boK64jZPPFgpOfs+E7nYIhaiHRLsgtq8cUiqN+Plnb3AyVMspRLGdDvUx/oSImQbQ8Nq0uVO1MVHHOkjdFHEBm2tTBh7+tYMMmkkK0PEys8wPFuNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPbTkk3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB54C4CEED;
	Tue,  2 Sep 2025 08:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802053;
	bh=8MPmTxUTV3g1rzAZxNPkLlwzM2lhv8IEy3sLqM4qcjM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NPbTkk3BdqK9YFrNnktddrvvZYhOIcwi7pmv6ifLQt/TsekHBob3GXp7dUT3sCxQj
	 eoAiD1gfGnwueKMtFMkSMPUI8SLukB5BjVx4vBFqDF4fK2x/GXBo2WtSypKYOsNR+I
	 ErqiQdYbCsijVZKkAi97pq8yBXHcOlwEHcWZY//gVl96jBKGLEiOJWomzMi5J8LH4F
	 U3qhUp9vmFO7kYlJzWZo8pP3OXOsot2jTO8Hy+xm1cYMqR+smsKuGqIM6m/Lvquudo
	 SXEDVA/qhEa5RwqxPesZU0EDFCjfjwCOqEDhZgp28YNE4GKPeagUW8ste7CG2/ignV
	 LG3GzTNsx+Irw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:52 +0200
Subject: [PATCH 24/29] drm/tidss: dispc: Improve mode checking logs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-24-14ad5315da3f@kernel.org>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
In-Reply-To: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4279; i=mripard@kernel.org;
 h=from:subject:message-id; bh=8MPmTxUTV3g1rzAZxNPkLlwzM2lhv8IEy3sLqM4qcjM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVu9vFH0+3zxEZtvCBUJvQ84lz/kWK3Rd3mRfN/fsW
 JvE7++mdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJtD1mbDj7vmd++jkeh5TV
 7z45hW3Sf3rjgItJfG54XV5uUOPNDyE9+/IO/blXVRGwb3fKLumEmYwNb0UCm+2D+OMnZzHrGRV
 uuXFx7qact3EHN7PJ1366xbkk4nkHj1b7/amyjnt04t66pAgDAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The dispc_vp_mode_valid() function checks whether a mode can be handled
by the display controller.

There's a whole bunch of criteria, and it's not clear when a rejection
happens why it did. Let's add a bunch of logs on error to make it
clearer.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 47 +++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 32248b5f71b7566dc33d7a7db0efb26d3a9ed1c3..ef948e3041e10bc65cf2c4794a4e4cffa7e3fb3a 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1349,47 +1349,63 @@ static void dispc_vp_set_default_color(struct dispc_device *dispc,
 
 enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 					 u32 hw_videoport,
 					 const struct drm_display_mode *mode)
 {
+	struct tidss_device *tidss = dispc->tidss;
+	struct drm_device *dev = &tidss->ddev;
 	u32 hsw, hfp, hbp, vsw, vfp, vbp;
 	enum dispc_vp_bus_type bus_type;
 	int max_pclk;
 
 	bus_type = dispc->feat->vp_bus_type[hw_videoport];
 
 	max_pclk = dispc->feat->max_pclk_khz[bus_type];
 
-	if (WARN_ON(max_pclk == 0))
+	if (WARN_ON(max_pclk == 0)) {
+		drm_dbg(dev, "Invalid maximum pixel clock");
 		return MODE_BAD;
+	}
 
-	if (mode->clock < dispc->feat->min_pclk_khz)
+	if (mode->clock < dispc->feat->min_pclk_khz) {
+		drm_dbg(dev, "Mode pixel clock below hardware minimum pixel clock");
 		return MODE_CLOCK_LOW;
+	}
 
-	if (mode->clock > max_pclk)
+	if (mode->clock > max_pclk) {
+		drm_dbg(dev, "Mode pixel clock above hardware maximum pixel clock");
 		return MODE_CLOCK_HIGH;
+	}
 
-	if (mode->hdisplay > 4096)
+	if (mode->hdisplay > 4096) {
+		drm_dbg(dev, "Number of active horizontal pixels above hardware limits.");
 		return MODE_BAD;
+	}
 
-	if (mode->vdisplay > 4096)
+	if (mode->vdisplay > 4096) {
+		drm_dbg(dev, "Number of active vertical lines above hardware limits.");
 		return MODE_BAD;
+	}
 
 	/* TODO: add interlace support */
-	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE) {
+		drm_dbg(dev, "Interlace modes not suppported.");
 		return MODE_NO_INTERLACE;
+	}
 
 	/*
 	 * Enforce the output width is divisible by 2. Actually this
 	 * is only needed in following cases:
 	 * - YUV output selected (BT656, BT1120)
 	 * - Dithering enabled
 	 * - TDM with TDMCycleFormat == 3
 	 * But for simplicity we enforce that always.
 	 */
-	if ((mode->hdisplay % 2) != 0)
+	if ((mode->hdisplay % 2) != 0) {
+		drm_dbg(dev, "Number of active horizontal pixels must be even.");
 		return MODE_BAD_HVALUE;
+	}
 
 	hfp = mode->hsync_start - mode->hdisplay;
 	hsw = mode->hsync_end - mode->hsync_start;
 	hbp = mode->htotal - mode->hsync_end;
 
@@ -1397,29 +1413,40 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 	vsw = mode->vsync_end - mode->vsync_start;
 	vbp = mode->vtotal - mode->vsync_end;
 
 	if (hsw < 1 || hsw > 256 ||
 	    hfp < 1 || hfp > 4096 ||
-	    hbp < 1 || hbp > 4096)
+	    hbp < 1 || hbp > 4096) {
+		drm_dbg(dev,
+			"Horizontal blanking or sync outside of hardware limits (fp: %u, sw: %u, bp: %u).",
+			hfp, hsw, hbp);
 		return MODE_BAD_HVALUE;
+	}
 
 	if (vsw < 1 || vsw > 256 ||
-	    vfp > 4095 || vbp > 4095)
+	    vfp > 4095 || vbp > 4095) {
+		drm_dbg(dev,
+			"Vertical blanking or sync outside of hardware limits (fp: %u, sw: %u, bp: %u).",
+			vfp, vsw, vbp);
 		return MODE_BAD_VVALUE;
+	}
 
 	if (dispc->memory_bandwidth_limit) {
 		const unsigned int bpp = 4;
 		u64 bandwidth;
 
 		bandwidth = 1000 * mode->clock;
 		bandwidth = bandwidth * mode->hdisplay * mode->vdisplay * bpp;
 		bandwidth = div_u64(bandwidth, mode->htotal * mode->vtotal);
 
-		if (dispc->memory_bandwidth_limit < bandwidth)
+		if (dispc->memory_bandwidth_limit < bandwidth) {
+			drm_dbg(dev, "Required memory bandwidth outside of hardware limits.");
 			return MODE_BAD;
+		}
 	}
 
+	drm_dbg(dev, "Mode is valid.");
 	return MODE_OK;
 }
 
 int dispc_vp_enable_clk(struct dispc_device *dispc, u32 hw_videoport)
 {

-- 
2.50.1


