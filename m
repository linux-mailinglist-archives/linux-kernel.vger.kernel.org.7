Return-Path: <linux-kernel+bounces-724144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1E5AFEF2D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9631889F53
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB162233128;
	Wed,  9 Jul 2025 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fV0Tw45C"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AE8221561
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079732; cv=none; b=U1764lE3qnDoSLImkesHwiCcRk8lzp/Ix97G0qMDMFOoxgbaJ+2sEBAj+aMmlv6VSatPOOTgzqIXX1YNGgNgTTrTWRddLRfxttHTXXaMtLCT6k3ocSGiEgkf1GLNv63q+PaJDYqe2pPmgNVdnGPtZibLhbQQXa/PzlPvKYQWT8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079732; c=relaxed/simple;
	bh=uDB2q7TvEObnSZYaPRyZnO7kWP062OGp1X7eA6BMG74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MOgM5R3Usk6wlv/YGDAGyPf4vq1QDApt6ilP3i0McqPPODVnnC7UF/NabfMxF6H2P/BlEoUWEbdmpH+N49QUFsLzQv4R4rn/e+d3cxbOR8oH+SJx1AeX802WYc01a5OaFF6sGRdQcYz4kQf7szrp2qHgA/foyb1qt9NpBrsxeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fV0Tw45C; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F05DF43B29;
	Wed,  9 Jul 2025 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752079729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlBByp9ti89jRGF9OoLKlYZnjR1rawwpMH2ftXRDETg=;
	b=fV0Tw45CmoH2FMF+8e2uW9Y7+dLKZv3owi6Iv3XklJgDA/vlAlNCZEDIRB0iYIBvzfpmo7
	mWxe5y+tS49OMCzJof3OYG1Vy1TvEh35xQRny55ZkFALtcTtn+P72RaK1HVPe1s+CCaaoz
	/MiG9LWYqaZXB9QwCSTU2GQpJz4PEMa/q0CbJw+WXQu03v0s39rcyTKZUND5jyK7AvpccN
	LoUsve8upOSeaz512WO0M2uSEgDR/U/87Tb/lgccnHtYEXviFNXC2Qzkequ5tf1SXuPzYX
	D8yE+cSLDjMOLoGoUQEW9KdB+bX6v0L9YxQweFwY3VNAuYv4qQ51uIbj9HrGgA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 09 Jul 2025 18:48:02 +0200
Subject: [PATCH 3/9] drm/bridge: imx93-mipi-dsi: use
 drm_bridge_chain_get_last_bridge()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-3-48920b9cf369@bootlin.com>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-0-48920b9cf369@bootlin.com>
In-Reply-To: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-0-48920b9cf369@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkedtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieeiuedvffetgfeuudelheeutefggfejieettdetteekueeuueeukeevvedvueevnecukfhppeekjedruddvtddrvddukedrvddtjeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpeekjedruddvtddrvddukedrvddtjedphhgvlhhopegludelvddrudeikedruddrudefngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopefjuhhirdfruhesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepthhomhhirdhvrghlkhgvihhnvghnsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehvihgtthhorhdrlhhiuhesn
 higphdrtghomhdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepphdriigrsggvlhesphgvnhhguhhtrhhonhhigidruggv
X-GND-Sasl: luca.ceresoli@bootlin.com

Use drm_bridge_chain_get_last_bridge() instead of open coding a loop with
two invocations of drm_bridge_get_next_bridge() per iteration.

Besides being cleaner and more efficient, this change is necessary in
preparation for drm_bridge_get_next_bridge() to get a reference to the
returned bridge.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
index bea8346515b8c8ce150040f58d288ac564eeb563..8f7a0d46601a41e1bfc04587398b0f1536a6a16c 100644
--- a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
@@ -492,14 +492,12 @@ static int imx93_dsi_get_phy_configure_opts(struct imx93_dsi *dsi,
 static enum drm_mode_status
 imx93_dsi_validate_mode(struct imx93_dsi *dsi, const struct drm_display_mode *mode)
 {
-	struct drm_bridge *bridge = dw_mipi_dsi_get_bridge(dsi->dmd);
+	struct drm_bridge *dmd_bridge = dw_mipi_dsi_get_bridge(dsi->dmd);
+	struct drm_bridge *last_bridge __free(drm_bridge_put) =
+		drm_bridge_chain_get_last_bridge(dmd_bridge->encoder);
 
-	/* Get the last bridge */
-	while (drm_bridge_get_next_bridge(bridge))
-		bridge = drm_bridge_get_next_bridge(bridge);
-
-	if ((bridge->ops & DRM_BRIDGE_OP_DETECT) &&
-	    (bridge->ops & DRM_BRIDGE_OP_EDID)) {
+	if ((last_bridge->ops & DRM_BRIDGE_OP_DETECT) &&
+	    (last_bridge->ops & DRM_BRIDGE_OP_EDID)) {
 		unsigned long pixel_clock_rate = mode->clock * 1000;
 		unsigned long rounded_rate;
 

-- 
2.50.0


