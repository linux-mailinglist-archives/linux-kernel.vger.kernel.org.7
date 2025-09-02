Return-Path: <linux-kernel+bounces-795866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1A4B3F8C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4E418819B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8A82ED873;
	Tue,  2 Sep 2025 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5PU6oYp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3D2ECEB9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802066; cv=none; b=VHwcjm1mtZeFRnH5w1Er4mZ92o9coWNTikO5Fi9VciiashWa5Ks5rB0aM9BugPcEO2n+kYUFE2SyVpL7/13/O1dxOr1GxQXQ/DSEhApwecMAlNDKV7/pMYiLpBHhoiBrn1T6GrI78SnqY0+I3aGCc/Kt2Iqzj5SEnJPn1ifqEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802066; c=relaxed/simple;
	bh=nreBoH6ThRerXR2wNJa5hb8U1Wgw8f5LJn4gcdb2KpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xt7zkCqP/vHUuTdTLWFSPIeIJq8zVpLS5Cdmn9rCYow4SY41f3uH1diNDj00byhk/enq0WfClYEagXRehHlQlVDnVwcs0yYMRgo3glZadvv/xAq9902XecFRI3oZmj3Aa17uv2VVmdxmRVkYGcaFAx0sAzijVzjFZnlIUCHukeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5PU6oYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6186DC4CEF5;
	Tue,  2 Sep 2025 08:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802066;
	bh=nreBoH6ThRerXR2wNJa5hb8U1Wgw8f5LJn4gcdb2KpY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b5PU6oYphv9O+QNCyshbf1R2+dTpKQkl8jJqMnC38IA+GupA1IZGeAP6v6ydv1VuS
	 i1iK8w+x/GFYmWQzQlmJ3eRzCIqyK6iua9GZARjfIzmqXW7m5hHNW2CHKfvHgwQ2uo
	 r5/qxjFZ8oY+XFTxmQnxYBjyMa9FwAmzDXO26WJXDn+VCOw9A2NWlT5oKdz16RSs8j
	 mneyfwSydEia0VoIV+1KDLq7Defdk3xBtKU6hcf40oqlIVrqOSrBcWZJHRJYIY7+2C
	 vyMyIRPn6AVJwsm6XBtEHOO/sfAka4TWKXKakm6uTv9pbQwMZDjXvo7MhoX+6alcpG
	 /0cGUygBbNo+A==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:57 +0200
Subject: [PATCH 29/29] drm/bridge: sii902x: Implement hw state readout
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-29-14ad5315da3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3469; i=mripard@kernel.org;
 h=from:subject:message-id; bh=nreBoH6ThRerXR2wNJa5hb8U1Wgw8f5LJn4gcdb2KpY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVh/U9Zm/efutmxbKefuehdkHG+67+WPnq8gv176u6
 vd/Jyor2zGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmovCLsaHv0nqvrh1bpsUv
 qfryTEkj5ESnoil/xqKlTDtl7y45ZffZYV6BcG1o9awAVznDDieHHMaGxtBjSjxGyefzmS6tPj5
 RRmyL+aQw0c1PuNdEv5pipXJaeamOaMb5hmyWnB8PbGt2eD8FAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Let's implement the hardware state readout for the sii902x bridge now
that we have all the infrastructure in place.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/sii902x.c | 51 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index d537b1d036fb09ce55a690a0809dcc28fc0f41be..5ffceb9131540d2cb1b82a74b4f7cec9bc7fd8ca 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -540,17 +540,66 @@ sii902x_bridge_mode_valid(struct drm_bridge *bridge,
 		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
 }
 
+static int sii902x_bridge_connector_hw_readout(struct drm_bridge *bridge,
+					       struct drm_atomic_state *state,
+					       struct drm_connector_state *conn_state)
+{
+	struct sii902x *sii902x = bridge_to_sii902x(bridge);
+	struct drm_connector *connector = conn_state->connector;
+	struct drm_crtc_state *crtc_state;
+	struct drm_encoder *encoder;
+	struct drm_crtc *crtc;
+
+	if (regmap_test_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA, SII902X_SYS_CTRL_PWR_DWN))
+		return 0;
+
+	encoder = bridge->encoder;
+	crtc = encoder->funcs->get_current_crtc(encoder);
+	if (!crtc)
+		return -ENODEV;
+
+	crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
+	if (!crtc_state)
+		return -ENODEV;
+
+	crtc_state->encoder_mask |= drm_encoder_mask(encoder);
+	crtc_state->connector_mask |= drm_connector_mask(connector);
+
+	conn_state->crtc = crtc;
+	conn_state->best_encoder = encoder;
+
+	return 0;
+}
+
+static int sii902x_bridge_readout_state(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state)
+{
+	struct sii902x *sii902x = bridge_to_sii902x(bridge);
+
+	if (regmap_test_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA, SII902X_SYS_CTRL_PWR_DWN))
+		return 0;
+
+	/* bridge_state is pretty trivial, we don't have anything to do here */
+
+	return 0;
+}
+
 static const struct drm_bridge_funcs sii902x_bridge_funcs = {
 	.attach = sii902x_bridge_attach,
 	.mode_set = sii902x_bridge_mode_set,
 	.atomic_disable = sii902x_bridge_atomic_disable,
 	.atomic_enable = sii902x_bridge_atomic_enable,
+	.connector_hw_readout = sii902x_bridge_connector_hw_readout,
 	.detect = sii902x_bridge_detect,
 	.edid_read = sii902x_bridge_edid_read,
+	.atomic_compare_state = drm_atomic_helper_bridge_compare_state,
+	.atomic_readout_state = sii902x_bridge_readout_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = sii902x_bridge_atomic_get_input_bus_fmts,
 	.atomic_check = sii902x_bridge_atomic_check,
@@ -1136,11 +1185,11 @@ static int sii902x_init(struct sii902x *sii902x)
 	if (ret)
 		goto err_unreg_audio;
 
 	sii902x->bridge.of_node = dev->of_node;
 	sii902x->bridge.timings = &default_sii902x_timings;
-	sii902x->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
+	sii902x->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_CONNECTOR_HW_READOUT;
 	sii902x->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 
 	if (sii902x->i2c->irq > 0)
 		sii902x->bridge.ops |= DRM_BRIDGE_OP_HPD;
 

-- 
2.50.1


