Return-Path: <linux-kernel+bounces-721937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC7AFCFAD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B0B3B1A45
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ACB2E499C;
	Tue,  8 Jul 2025 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZWJ5CgL3"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523F2E425D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989747; cv=none; b=FUWp+vxUkWx89MSxUb8uvaLjJjIKwJnt4sx/xvyU9UCwoUDgIyO+8R1/Azeelr3wt5VlwRldTaG7+Sy5vgOcuO6DHa1xU4c7FtU5VmgHlxXSMvuBGM46KtY8+418YLaSn/XXhxFDGUpP6ZTE2xh8vD3wVnBwnwDi+RZuCyGXMwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989747; c=relaxed/simple;
	bh=zSLH44C0/VlajipBiOgDJBEIXSMjw8kHg60hc2+0MdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=StlwWorbg8BaRMS7elO+bBvX/1X14cgNOe1pyqLPyWkGa5OOirDlCIa8mPxXSNGNztPngcMr8ZB6ecN2+WyGItrCIAFMYbGAeYtt8DKbzDMNJ9CjCS1kRH4WUHIAGHnCfHrW9wXNSlDenQRoEdXhEhX8tVLts5+nWqRCE5UJj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZWJ5CgL3; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA347443FE;
	Tue,  8 Jul 2025 15:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751989743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzrCMMjmiwe9eE9IVUJli+lIpyyZBeUxNuauzmTsOYc=;
	b=ZWJ5CgL3ZKMkxnggS4VOYdocqmsYq+x8MK2VTJ9EdEA0munPnu1iM26+lzyc2ddBR/d6dk
	svF0nyc7+nE05KJqKz/5nFxF5l/EUo2UPjJ8d9vnv7rhNk5nisMj4i9pXKy0Oh7BUXVzhU
	yJyo0wXNr04e2uAfhLd4PKuWjZnhVOsNKESJzi1UCk6DPugZVFuZSwAWOV/SsWFEde7HrX
	hFBwqhFTYn1HUcCKX+8rXMEBteG0YYNvZlT1Pap0haGLVThvgTy5Ntcizjo4qy+vCq8i6r
	yynh+IitInSnRfG1XSS3ahVkqJvGGh4iDqSHlBp1erugH2+l5xp9fgVAbUvqhg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 08 Jul 2025 17:48:21 +0200
Subject: [PATCH v9 4/5] drm/atomic-helper: put the bridge returned by
 drm_bridge_chain_get_first_bridge()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-v9-4-db1ba3df7f58@bootlin.com>
References: <20250708-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-v9-0-db1ba3df7f58@bootlin.com>
In-Reply-To: <20250708-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-v9-0-db1ba3df7f58@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Liu Ying <victor.liu@nxp.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefhedtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieeiuedvffetgfeuudelheeutefggfejieettdetteekueeuueeukeevvedvueevnecukfhppeekjedruddvtddrvddukedrvddtjeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpeekjedruddvtddrvddukedrvddtjedphhgvlhhopegludelvddrudeikedruddrudefngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdprhgtphhtt
 hhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

The bridge returned by drm_bridge_chain_get_first_bridge() is
refcounted. Put it when done.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---

Changes in v9:
- Added R-by Maxime

Changes in v8:
- reworked after the changes in pre_enable/post_disable order:
  f6ee26f58870 ("drm/atomic-helper: Refactor crtc & encoder-bridge op loops into separate functions")
  d5bef6430c85 ("drm/atomic-helper: Separate out bridge pre_enable/post_disable from enable/disable")
  c9b1150a68d9 ("drm/atomic-helper: Re-order bridge chain pre-enable and post-disable")
- Removed R-by Maxime as the diff is not identical, even though it is in
  principle the same (there are 2 new drm_bridge_chain_get_first_bridge
  calls, thus added the corresponding drm_bridge_put calls)

This patch was added in v7.
---
 drivers/gpu/drm/drm_atomic_helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index ef56b474acf599bb9cd341674dc83b04ae247eb7..d5ebe6ea0acbc5a08aef7fa41ecb9ed5d8fa8e80 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -456,6 +456,7 @@ mode_fixup(struct drm_atomic_state *state)
 		ret = drm_atomic_bridge_chain_check(bridge,
 						    new_crtc_state,
 						    new_conn_state);
+		drm_bridge_put(bridge);
 		if (ret) {
 			drm_dbg_atomic(encoder->dev, "Bridge atomic check failed\n");
 			return ret;
@@ -527,6 +528,7 @@ static enum drm_mode_status mode_valid_path(struct drm_connector *connector,
 	bridge = drm_bridge_chain_get_first_bridge(encoder);
 	ret = drm_bridge_chain_mode_valid(bridge, &connector->display_info,
 					  mode);
+	drm_bridge_put(bridge);
 	if (ret != MODE_OK) {
 		drm_dbg_atomic(encoder->dev, "[BRIDGE] mode_valid() failed\n");
 		return ret;
@@ -1212,6 +1214,7 @@ encoder_bridge_disable(struct drm_device *dev, struct drm_atomic_state *state)
 		 */
 		bridge = drm_bridge_chain_get_first_bridge(encoder);
 		drm_atomic_bridge_chain_disable(bridge, state);
+		drm_bridge_put(bridge);
 
 		/* Right function depends upon target state. */
 		if (funcs) {
@@ -1329,6 +1332,7 @@ encoder_bridge_post_disable(struct drm_device *dev, struct drm_atomic_state *sta
 		 */
 		bridge = drm_bridge_chain_get_first_bridge(encoder);
 		drm_atomic_bridge_chain_post_disable(bridge, state);
+		drm_bridge_put(bridge);
 	}
 }
 
@@ -1501,6 +1505,7 @@ crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *state)
 
 		bridge = drm_bridge_chain_get_first_bridge(encoder);
 		drm_bridge_chain_mode_set(bridge, mode, adjusted_mode);
+		drm_bridge_put(bridge);
 	}
 }
 
@@ -1580,6 +1585,7 @@ encoder_bridge_pre_enable(struct drm_device *dev, struct drm_atomic_state *state
 		 */
 		bridge = drm_bridge_chain_get_first_bridge(encoder);
 		drm_atomic_bridge_chain_pre_enable(bridge, state);
+		drm_bridge_put(bridge);
 	}
 }
 
@@ -1655,6 +1661,7 @@ encoder_bridge_enable(struct drm_device *dev, struct drm_atomic_state *state)
 		}
 
 		drm_atomic_bridge_chain_enable(bridge, state);
+		drm_bridge_put(bridge);
 	}
 }
 

-- 
2.50.0


