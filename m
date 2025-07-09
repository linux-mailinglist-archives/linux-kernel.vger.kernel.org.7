Return-Path: <linux-kernel+bounces-724150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DA9AFEF35
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAF01881919
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE9E224B04;
	Wed,  9 Jul 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SSY3iiiq"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E9204C0C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079762; cv=none; b=C4hh4NDsTWU2xZWv2jiLQeWTwDyUX/R4BNXEz7sIbH/I3cfn7T6F7JEEg+zGZFY90nplIi2x5jixOTuuOmKkOsBrmK86HUr7vio0hyQcmm4Zy+Hl4CVUfZaBdEptxqjOyfmSJbZomS+82BgxszW0mAOAGwLiPIRVshava4NGVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079762; c=relaxed/simple;
	bh=CecccEEp6xMqqwq13Yq1RsvGYSP4oxbH6K1TCkmW148=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xrd0h5SXjJSoGiU83koQlnW3DStQkrTV4jOLxuw7aYmgj7W2SMDIbGQa8xFwfKBOqL0cHOG2RTxil6A0SnYqIc1J9Nw65Ot6B00iL4rIH5aGk8wNZ6lsI/pbyTCPWkhs361C5FPutzXtMti3F8iSrDqTXeXg4x2a7yOZGD+D01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SSY3iiiq; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1F5A4446A;
	Wed,  9 Jul 2025 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752079741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urTGCRx+pagS/LllFzv+AWPNdvP9WA8Q7pk3WEs5H7Y=;
	b=SSY3iiiqZgfxbjO7Ed2YqlkJe2nr+7rAgE+hoeE2MfKPpYNCv6lWS2ZSqJR3JnBvrcr31i
	4LemqgQUZkjZkGxr5NtL/bd0S+s0BeKoiFoaFAEXWEnHrotV2POodQfllkeQ4qDVCXdvVF
	feLgtzlXLRNavm/fHEmzkD5Jn95GFCj7wGccQ2slHCbzyqJ1iNhjDBCsVJ2gZ9XuBNS2YN
	nQrldlk8z+T4VDI84nbT954u6MaVtF8HJw8RIGeCvoEKr/qH+J1SNodfEqTMy7Z1cVFYJ8
	6MuVv01k6Udu7LFeLaQ9IvWJumSkk/uXGRAi6SrqO+ozAw5OmKOow3INqlYwNw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 09 Jul 2025 18:48:08 +0200
Subject: [PATCH 9/9] drm/imx: parallel-display: put the bridge returned by
 drm_bridge_get_next_bridge()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-9-48920b9cf369@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkedtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieeiuedvffetgfeuudelheeutefggfejieettdetteekueeuueeukeevvedvueevnecukfhppeekjedruddvtddrvddukedrvddtjeenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepihhnvghtpeekjedruddvtddrvddukedrvddtjedphhgvlhhopegludelvddrudeikedruddrudefngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopefjuhhirdfruhesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepthhomhhirdhvrghlkhgvihhnvghnsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehvihgtthhorhdrlhhiuhesn
 higphdrtghomhdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepphdriigrsggvlhesphgvnhhguhhtrhhonhhigidruggv
X-GND-Sasl: luca.ceresoli@bootlin.com

The bridge returned by drm_bridge_get_next_bridge() is refcounted. Put it
when done.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/imx/ipuv3/parallel-display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
index 6d8325c766979aa3ba98970f00806e99c139d3c3..44b2ce3c2a3a1641c4483a610607555dfbedff9e 100644
--- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
+++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
@@ -138,9 +138,11 @@ static int imx_pd_bridge_atomic_check(struct drm_bridge *bridge,
 	u32 bus_flags, bus_fmt;
 
 	next_bridge = drm_bridge_get_next_bridge(bridge);
-	if (next_bridge)
+	if (next_bridge) {
 		next_bridge_state = drm_atomic_get_new_bridge_state(crtc_state->state,
 								    next_bridge);
+		drm_bridge_put(next_bridge);
+	}
 
 	if (next_bridge_state)
 		bus_flags = next_bridge_state->input_bus_cfg.flags;

-- 
2.50.0


