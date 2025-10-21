Return-Path: <linux-kernel+bounces-862995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF67BF6C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85D15438CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E1D337B86;
	Tue, 21 Oct 2025 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jlMiv3AK"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82432338583
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053027; cv=none; b=rvj67ZxWgTUALsszfRQNpb/jn7oxQLc+fHfZrlV9NZDeHthbU8ZYio/FugaOimoz/x6EpRxZuilbZaabYxg5hojQIlas6r+y/oFkX7H8IPlYX8CaY/5u6ENWyxwV8mZhHHSmjdj+HEif4ur/Mu6Jjc2XsUAIDq8lBnff05aC0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053027; c=relaxed/simple;
	bh=xl8LY50t1nFK7zo4QzL7OcSdYgLXevi6DdqZ8vAxkZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZhvC4d7klkZfC+JasQSH26iUlLh7FiribEsYCFvxmO4e3y5lARsvNfTIC8OKh5Mc1mXiqBdah/c4vufVBq7CaRFpsxg+0K+QT78BTZozkHuTvY/LrF/d9ODKZI4DZRSS3vj/GBRgTpCGQ8smF1Xr/+9XUAcFZTKLMqMe1taaeHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jlMiv3AK; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CA85C1387;
	Tue, 21 Oct 2025 15:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761052912;
	bh=xl8LY50t1nFK7zo4QzL7OcSdYgLXevi6DdqZ8vAxkZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jlMiv3AKx9bOhdxMU2qjoo4hNQrVsbTBgEwwnMy7ZwXpJ+ihjVWlXDug90uCo3T+7
	 WdAiou0SevEWkyJuKRFO3edfodSjKFpzwWm5g9l+MXpCQZAizOHnxLuFHIo8dNYoQb
	 WG4GzfVxk8Quq8Cs/mFMwXGKEpb4IlLDOEuSa3FM=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 21 Oct 2025 16:23:02 +0300
Subject: [PATCH 6/7] drm/bridge: tc358768: Separate video format config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-tc358768-v1-6-d590dc6a1a0c@ideasonboard.com>
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4393;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=xl8LY50t1nFK7zo4QzL7OcSdYgLXevi6DdqZ8vAxkZc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo94lQtX58PnZsZyqBj8eP8d4yuGewfVKxFzG1X
 wi8ZD0+mIWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaPeJUAAKCRD6PaqMvJYe
 9YrYD/4qklqPfSrDnIP20YzrHXaO2FCZlFjV6WzMPDi69e9xb8/6kVhVx7lvASWfPnzSCRDVwpn
 SsbK4p2hOaq46mH/zkByg+LdRj2wbkxcef2jM+kI/iiDgM5yckpm0/MBFC+A2SsbVapSBjlPwG3
 WHnNutdTUWRb7QvUvtI+kzM/yDWCHhzPUyiXKp7RhB8J9q6hytOTq3AWG6BvOdWZ7tH9/NLYpKY
 h1o3mpABMlG7dRut8nEalIPhpvoqBH/jTCHaaSH/NBEGaty0qChhzquLcJ69zzB0kr2u5LYZ6xt
 MjZ+EUUGKmVoHZXU9O8JmySr9UpBdcEPT7JWxc0U3DdI6F4xGN7dQRYrvUaSRPLbwKgebtPnLhE
 PedJDZhJ2n60SBhN8EU4PYTH4UiRPHoQh2j3lap74INrEv1m4KQVBbseZ4HIRH/HI6hVKqNToa7
 TLOuN/0CgZ6W5+mR7juDbZrF6MMs9MvfkHlrmlv6x8Rn8dFpi5Ehyl1DllkllSQCNR9mpNqI/Dj
 xk0zfWa8jgoCWNdUxGjsuqITsh1KEVpqXH+HLVAaSjmRdHZ/npaI4dlHLXRaWP0mSQrlAcy1+FF
 RQkVkf9fNNk/rAvflcnG0txyHSB6JsNSvPzCBmMGKNRnVectaXU/cbN3R5JGZyDSLJmrZjNDbfG
 /zGVugup6J4IJ7w==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Sending long commands using the video buffer (to be implemented in
following patches) requires setting TC358768_DATAFMT and
TC358768_DSITX_DT registers for command transfer. The same registers
also need to be configured properly for video transfer.

The long commands will be sent between the bridge's pre_enable() and
enable(), and currently we configure the registers for video transfer in
pre_enable(). Thus, they would be overwritten by the long command
transfer code.

To prevent that from happening, set those registers for video transfer
in enable(), not in pre_enable().

Based on code from Parth Pancholi <parth.pancholi@toradex.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 51 ++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index a7a14c125ac4..e1ed4003b3c5 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -722,7 +722,7 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 {
 	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
 	struct mipi_dsi_device *dsi_dev = priv->output.dev;
-	u32 val, mask, val2, lptxcnt, hact, data_type;
+	u32 val, mask, val2, lptxcnt, hact;
 	s32 raw_val;
 	struct drm_crtc_state *crtc_state;
 	struct drm_connector_state *conn_state;
@@ -768,30 +768,20 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	dsiclk = priv->dsiclk;
 	hsbyteclk = dsiclk / 4;
 
-	/* Data Format Control Register */
-	val = BIT(2) | BIT(1) | BIT(0); /* rdswap_en | dsitx_en | txdt_en */
 	switch (dsi_dev->format) {
 	case MIPI_DSI_FMT_RGB888:
-		val |= (0x3 << 4);
 		hact = vm.hactive * 3;
-		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_24;
 		break;
 	case MIPI_DSI_FMT_RGB666:
-		val |= (0x4 << 4);
 		hact = vm.hactive * 3;
-		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_18;
 		break;
 
 	case MIPI_DSI_FMT_RGB666_PACKED:
-		val |= (0x4 << 4) | BIT(3);
 		hact = vm.hactive * 18 / 8;
-		data_type = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
 		break;
 
 	case MIPI_DSI_FMT_RGB565:
-		val |= (0x5 << 4);
 		hact = vm.hactive * 2;
-		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_16;
 		break;
 	default:
 		dev_err(dev, "Invalid data format (%u)\n",
@@ -947,9 +937,6 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	/* VSDly[9:0] */
 	tc358768_write(priv, TC358768_VSDLY, dsi_vsdly - internal_dly);
 
-	tc358768_write(priv, TC358768_DATAFMT, val);
-	tc358768_write(priv, TC358768_DSITX_DT, data_type);
-
 	/* Enable D-PHY (HiZ->LP11) */
 	tc358768_write(priv, TC358768_CLW_CNTRL, 0x0000);
 	/* Enable lanes */
@@ -1113,6 +1100,39 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 		dev_err(dev, "Bridge pre_enable failed: %d\n", ret);
 }
 
+static void tc358768_config_video_format(struct tc358768_priv *priv)
+{
+	struct mipi_dsi_device *dsi_dev = priv->output.dev;
+	u32 val, data_type;
+
+	/* Data Format Control Register */
+	val = BIT(2) | BIT(1) | BIT(0); /* rdswap_en | dsitx_en | txdt_en */
+	switch (dsi_dev->format) {
+	case MIPI_DSI_FMT_RGB888:
+		val |= (0x3 << 4);
+		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_24;
+		break;
+	case MIPI_DSI_FMT_RGB666:
+		val |= (0x4 << 4);
+		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_18;
+		break;
+	case MIPI_DSI_FMT_RGB666_PACKED:
+		val |= (0x4 << 4) | BIT(3);
+		data_type = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
+		break;
+	case MIPI_DSI_FMT_RGB565:
+		val |= (0x5 << 4);
+		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_16;
+		break;
+	default:
+		dev_err(priv->dev, "Invalid data format (%u)\n", dsi_dev->format);
+		return;
+	}
+
+	tc358768_write(priv, TC358768_DATAFMT, val);
+	tc358768_write(priv, TC358768_DSITX_DT, data_type);
+}
+
 static void tc358768_bridge_atomic_enable(struct drm_bridge *bridge,
 					  struct drm_atomic_state *state)
 {
@@ -1124,6 +1144,9 @@ static void tc358768_bridge_atomic_enable(struct drm_bridge *bridge,
 		return;
 	}
 
+	/* Configure video format registers */
+	tc358768_config_video_format(priv);
+
 	/* Enable HS mode for video TX */
 	tc358768_confw_update_bits(priv, TC358768_DSI_CONTROL,
 				   TC358768_DSI_CONTROL_TXMD,

-- 
2.43.0


