Return-Path: <linux-kernel+bounces-862992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4C2BF6BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 815415049D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDB5337BB7;
	Tue, 21 Oct 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="A0/p/8sK"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD77B337B86
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053022; cv=none; b=jLRaQWkDGnzPUMRUHMB1sTeG/14wOSHsB4Peu7OtI4nTGpV3H/yNaG6XpZjK0x6d8MxnsCghU+6/HWyAZKrkazv6zHX8+66WJ3TXuQx6Bl17KGaHV2/5LmQwfxS4uU6dpiV0HQGBqVPV0rMdOnGgBQZf1XcrIBbv6dKz/kiQCkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053022; c=relaxed/simple;
	bh=TJPT0LieahSnk5Eq/06H6MhVA9q7usSPmShU4un2ep4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnBPesFMz7PQpn6zFfFDehF8pOo3OYQndrYy+Z+GYaXr/YiMRLqdMtDwNjZ3zGPbuKZwIRW/ynWmvXU0WhQCX1OdIL7qsMglrnS8zUt00YD4/+WoH0+ckjuUHVKcRN8vFDpdfd3NsKIE9aA2xbRCum/QrI4ZIFXNd+enNNw0jIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=A0/p/8sK; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C63291121;
	Tue, 21 Oct 2025 15:21:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761052909;
	bh=TJPT0LieahSnk5Eq/06H6MhVA9q7usSPmShU4un2ep4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A0/p/8sKgbZUg5jUJ+C+sWzSuXcdcATBrEBzwqjgcBJhWWlHTMyvp4Xl/c0RgN14L
	 5UPNfKWXsig2XETlcc2VBHO/7pPUJCtBfH7EYJkQjNlx3rk/YT3Xs2HvhvPO/nv3DE
	 pq5j4g8OnqKjppzvwJBN68w76JqsSBRwYWYiUbqE=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 21 Oct 2025 16:22:59 +0300
Subject: [PATCH 3/7] drm/bridge: tc358768: Separate indirect register
 writes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-tc358768-v1-3-d590dc6a1a0c@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3907;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=TJPT0LieahSnk5Eq/06H6MhVA9q7usSPmShU4un2ep4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo94lPvq9UztZYZACDQgcbYBbcPmZgU8xYx76I/
 tKA8emJmTiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaPeJTwAKCRD6PaqMvJYe
 9SBcEACCV9kOijU18AuwGCpU+a+qwqHUmOv8b9lcwqyVYDJ8ORfBGbyrTbGYxqX+G6rnndX6MH6
 9my+aNEOep/KlTJoqkAog9KkvrwpuLXRiDW7INkFMMa7ZsrgNJf67EQ722a5HF2cEJAFkmUSxBW
 j1LUa/33AnhdXlV1v+Voeyo/CVmiRHuvMT5zQpteEf3IB7zmQ78wc8AQ+Q6MmcgUhIC55GqcQrs
 ZmKT3CnRIM7KGqFumI0oUazPEMkkIHqWuakfqeZsbI3kOG3WCDlAG/wOt7vN9RTJpF/0BQj5oBc
 ohR7XBC4NVKfmIEJqQ3ceEjAklz2ty2IwUH7GLGJS3V8mXrpxnijPkscZxrisoLRmmj6t3Brv5k
 07PI9vWICa3QK409d8fd+is0fobRePBtlfJmopLa+unp+eW9cMFLKOnS7m+cHCj5gVov60dmk3Y
 5+7XDDihtdgoDG04AOVaLkr63/MnAs+tfBhOeJzSw4sabJpCX9uOnBxLHB1GVScVI30F7qWILfH
 whLpTYxx1ejmUrStJqDHB1eua7aiKxe8y2WB9e4oCWvJ0HlTy0/cCTisK4bEGwmzZ+QTvzoLn4g
 4Fw3oIu2Dg6za45SDExlMuiFyOzk/gLJyhObNZD2ku8SkaRUoknQRUnOHVq/2NAy4F6fuOhM347
 JnqsII2IAP2nd8A==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Some registers can only be written indirectly, using DSI_CONFW register.
We don't have many uses for those registers (in fact, only DSI_CONTROL
is currently written), but the code to do those writes inline is a bit
confusing.

Add a new function, tc358768_confw_update_bits() which can be used to
write the bits indirectly. Only DSI_CONTROL is currently supported.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 52 +++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index dab9cdf5cb98..755ed6483b2e 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -123,7 +123,7 @@
 /* TC358768_DSI_CONFW (0x0500) register */
 #define TC358768_DSI_CONFW_MODE_SET	(5 << 29)
 #define TC358768_DSI_CONFW_MODE_CLR	(6 << 29)
-#define TC358768_DSI_CONFW_ADDR_DSI_CONTROL	(0x3 << 24)
+#define TC358768_DSI_CONFW_ADDR(x)	((x) << 24)
 
 /* TC358768_DSICMD_TX (0x0600) register */
 #define TC358768_DSI_CMDTX_DC_START	BIT(0)
@@ -232,6 +232,36 @@ static void tc358768_update_bits(struct tc358768_priv *priv, u32 reg, u32 mask,
 		tc358768_write(priv, reg, tmp);
 }
 
+static void tc358768_confw_update_bits(struct tc358768_priv *priv, u16 reg,
+				       u16 mask, u16 val)
+{
+	u8 confw_addr;
+	u32 confw_val;
+
+	switch (reg) {
+	case TC358768_DSI_CONTROL:
+		confw_addr = 0x3;
+		break;
+	default:
+		priv->error = -EINVAL;
+		return;
+	}
+
+	if (mask != val) {
+		confw_val = TC358768_DSI_CONFW_MODE_CLR |
+			TC358768_DSI_CONFW_ADDR(confw_addr) |
+			mask;
+		tc358768_write(priv, TC358768_DSI_CONFW, confw_val);
+	}
+
+	if (val & mask) {
+		confw_val = TC358768_DSI_CONFW_MODE_SET |
+			TC358768_DSI_CONFW_ADDR(confw_addr) |
+			(val & mask);
+		tc358768_write(priv, TC358768_DSI_CONFW, confw_val);
+	}
+}
+
 static void tc358768_dsicmd_tx(struct tc358768_priv *priv)
 {
 	u32 val;
@@ -693,7 +723,7 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
 	struct mipi_dsi_device *dsi_dev = priv->output.dev;
 	unsigned long mode_flags = dsi_dev->mode_flags;
-	u32 val, val2, lptxcnt, hact, data_type;
+	u32 val, mask, val2, lptxcnt, hact, data_type;
 	s32 raw_val;
 	struct drm_crtc_state *crtc_state;
 	struct drm_connector_state *conn_state;
@@ -1065,13 +1095,7 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	tc358768_write(priv, TC358768_DSI_START, 0x1);
 
 	/* Configure DSI_Control register */
-	val = TC358768_DSI_CONFW_MODE_CLR | TC358768_DSI_CONFW_ADDR_DSI_CONTROL;
-	val |= TC358768_DSI_CONTROL_TXMD | TC358768_DSI_CONTROL_HSCKMD |
-	       0x3 << 1 | TC358768_DSI_CONTROL_EOTDIS;
-	tc358768_write(priv, TC358768_DSI_CONFW, val);
-
-	val = TC358768_DSI_CONFW_MODE_SET | TC358768_DSI_CONFW_ADDR_DSI_CONTROL;
-	val |= (dsi_dev->lanes - 1) << 1;
+	val = (dsi_dev->lanes - 1) << 1;
 
 	val |= TC358768_DSI_CONTROL_TXMD;
 
@@ -1081,11 +1105,13 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	if (dsi_dev->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)
 		val |= TC358768_DSI_CONTROL_EOTDIS;
 
-	tc358768_write(priv, TC358768_DSI_CONFW, val);
+	mask = TC358768_DSI_CONTROL_TXMD | TC358768_DSI_CONTROL_HSCKMD |
+	       0x3 << 1 | TC358768_DSI_CONTROL_EOTDIS;
+
+	tc358768_confw_update_bits(priv, TC358768_DSI_CONTROL, mask, val);
 
-	val = TC358768_DSI_CONFW_MODE_CLR | TC358768_DSI_CONFW_ADDR_DSI_CONTROL;
-	val |= TC358768_DSI_CONTROL_DSI_MODE;
-	tc358768_write(priv, TC358768_DSI_CONFW, val);
+	tc358768_confw_update_bits(priv, TC358768_DSI_CONTROL,
+				   TC358768_DSI_CONTROL_DSI_MODE, 0);
 
 	ret = tc358768_clear_error(priv);
 	if (ret)

-- 
2.43.0


