Return-Path: <linux-kernel+bounces-862993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB2FBF6BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90A2C501192
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C7C33858C;
	Tue, 21 Oct 2025 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EMh6QoKo"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1173370F5
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053024; cv=none; b=M9qj+Ue7lAMY58Pm1XPFEisVJIf5LrXnepbD4q0NAe/7Awrz2CojvbMWOayGWQkO/da5HVaiXwMN/xFjCBprypya35MpDTZ9IMQfqu3PVIF8JPsbLrnVxvRUrSwKDPzOh5XR12A7x4CWZziDLMZVqgfppEyHkndp9LTvGQYkCps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053024; c=relaxed/simple;
	bh=txbD4T+DyxHYi9Le0uXTyexEykDWbpT/xM9Z418ot5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LiXNfADhasKr67LXfZreazRbKWNgUO3wudGLCkVHEGT8FY2UfQL8Yc42Y8/tSOTG+1NabyHyohHd/2j9GTWe+2guvFM8gAqeU1I8NutdjHhhr2IOSJzWpocbFK9in0NRFIkyVVK5byMWMxYM+Tfg20DA6ogV2or3YeMXx16tLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=EMh6QoKo; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B83341123;
	Tue, 21 Oct 2025 15:21:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761052910;
	bh=txbD4T+DyxHYi9Le0uXTyexEykDWbpT/xM9Z418ot5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EMh6QoKoFbalDjgXm1SJ05yR1ZFiN2TnTGL5Q9WcX2wdDCnnl2JNft79SYuANq9IE
	 hny5DB8LCMnWtmT86Ju2HBTDkDifRXkXpgMPX3PEFtMK1cUlu/Uwu2A37aF9Yqrqvk
	 71zsvXDKVsK6sLT3VntNlEuGTg8auTKS2o4wUgcs=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 21 Oct 2025 16:23:00 +0300
Subject: [PATCH 4/7] drm/bridge: tc358768: Support non-continuous clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-tc358768-v1-4-d590dc6a1a0c@ideasonboard.com>
References: <20251021-tc358768-v1-0-d590dc6a1a0c@ideasonboard.com>
In-Reply-To: <20251021-tc358768-v1-0-d590dc6a1a0c@ideasonboard.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Dmitry Osipenko <digetx@gmail.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2547;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=txbD4T+DyxHYi9Le0uXTyexEykDWbpT/xM9Z418ot5I=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo94lPhmNWR4fvfbkoTBnOeTYT1oVn+GNs/KDeg
 ngOaOJjFg2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaPeJTwAKCRD6PaqMvJYe
 9RBtD/9etoXFskGsS7r/UszJl0QPbh7qpjeFqS/DUlXx1Ryr5Vurq1+zVm1zSuhe6Bs/ZLZ942Z
 2CGet9Z9lzzPKEXpe4ViS+z3RgcEua/0aC2D7SsYnefTa3YMdYAmLbSjDhWHephvb3eyxpcPIIT
 Gj3kVfj/bx70Jw6uKd7Ppi3Gg6al5zK+UCMvmm3ysT96yCU203KcJJMlghTIuobbdD4AL/jQGu1
 VEVxYhB8ICEHZE5APR5hseQUHpcTqrZ4YvxPEoGtkCaoEjmw99hk5J4cBa9c9wotVSZdfDOMwvi
 z0oqmE+InHI0lym+7pvSx6yIzwnQdnmbrWvt71vVGSGQ6QEJx8BeLfJ8WHf2B7f2zYEjeQ/vavq
 PBqEZKE0SdCAUGZ4PN58Ls9arddMajVqrkiTDugxsxtp3Obmucw5CpITtDXu6aooAJ0Z1Qq4mww
 s+v80TBpfPyBvoQNP4M4lvv0DIXAputvEoCGs/EtLy265X0gz1WvR/2f65gbl9S/zXI6dUQx6Bm
 +T5ufzb+F70Z/1GsG9W5r77lngghu+ylIO5pfexoLrY7OAwiugaOPr6z4JXDiTBE1SBAvKunm5I
 9LEiLKvjCi9UXYyXyvBog46m8jLKHcC2icei/GjmH3CPeofnEDApAEUGeOvMC2OJI9ZHCTWvKfc
 gFxDJN1D5jjv8Rg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The driver prints a warning if MIPI_DSI_CLOCK_NON_CONTINUOUS is set, and
falls back to continuous clock mode. This was added in commit
fbc5a90e82c1 ("drm/bridge: tc358768: Disable non-continuous clock mode").

However, there have been multiple changes to the driver since then, and
at least in my setup, non-continuous clock mode works: I can see an
image on the panel, and I can see the clock lanes being non-continuous
with an oscilloscope.

So, let's enable MIPI_DSI_CLOCK_NON_CONTINUOUS support.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 755ed6483b2e..a276fbc75dde 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -722,7 +722,6 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 {
 	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
 	struct mipi_dsi_device *dsi_dev = priv->output.dev;
-	unsigned long mode_flags = dsi_dev->mode_flags;
 	u32 val, mask, val2, lptxcnt, hact, data_type;
 	s32 raw_val;
 	struct drm_crtc_state *crtc_state;
@@ -744,11 +743,6 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	u32 dsi_vsdly;
 	const u32 internal_dly = 40;
 
-	if (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
-		dev_warn_once(dev, "Non-continuous mode unimplemented, falling back to continuous\n");
-		mode_flags &= ~MIPI_DSI_CLOCK_NON_CONTINUOUS;
-	}
-
 	tc358768_hw_enable(priv);
 
 	ret = tc358768_sw_reset(priv);
@@ -1032,7 +1026,7 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	tc358768_write(priv, TC358768_HSTXVREGEN, val);
 
 	tc358768_write(priv, TC358768_TXOPTIONCNTRL,
-		       (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0 : BIT(0));
+		       (dsi_dev->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0 : BIT(0));
 
 	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
 	val = tc358768_ps_to_ns((lptxcnt + 1) * hsbyteclk_ps * 4);
@@ -1099,7 +1093,7 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 
 	val |= TC358768_DSI_CONTROL_TXMD;
 
-	if (!(mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
+	if (!(dsi_dev->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
 		val |= TC358768_DSI_CONTROL_HSCKMD;
 
 	if (dsi_dev->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)

-- 
2.43.0


