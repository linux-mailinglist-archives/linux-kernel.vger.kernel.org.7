Return-Path: <linux-kernel+bounces-753679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FF8B18647
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B66416A6CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE681E51EB;
	Fri,  1 Aug 2025 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZVaSEqkL"
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3818D28DB56
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067957; cv=none; b=QE1RC3zcCYGBxgA0ZOA/oUaW5fbiGoObthlU3s6ygiMmmt2kLuakYoDoof/lq0LVZ7RIWKsC+uagZ42YuwLyP/0oSToRZ/NvtpbsbNmThZnQM+ohh6dIqeFlzNg7RAv8uJJPg+qHoi1Fd1UaF8LxYnZ5NsTw7gatFo47na7c/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067957; c=relaxed/simple;
	bh=gcFvo/JjrVKXXpPE8TUebPahDp9SOQ6p8i5ihc5whYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpKvwunVQI5fsn/4SsFYOfdeup4aVXV/WAny49e+yn0+YgzcO4FZz6j/Voh+Y7V3HEc6M1CfK6rt7Z11m5yFSoyBkScc1Jj1sJ0ycmJNUm0gq1rLQqmfOtd8mH3hJrqv1y7FpX9CCKhCbsrZm2hvViLcuowSwtPOuyXagzQf3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZVaSEqkL; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD64C4422B;
	Fri,  1 Aug 2025 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754067954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XcuTwTnp9hmUdkX4u4R4cvzducFsDjBGc7V31uTMxgU=;
	b=ZVaSEqkLA5dCJMDkriICUJn0u/r70N0foxiL23r6a2Q4qlQea8L9rLuxIKdG3wapqBM0GV
	Kk34eG8bb96YWznUrHv2xBHvNn/RBfwiIx1sJwNcRyUtGf0bTqq53y8z8rE00gYixWRGe9
	axzPSwxEU3Fo6CfczAzJkobm84F3pF6oKjZIHTiqLiC6HVqaYr3qWJOTRu4i+yA57Jecq4
	XVosTWbIgKaLmWDltp0xs/qm1nLHtMi3jsG74UfWx8ovISQsyIUj2b3ANa34rxkd0N25fk
	PpNsYzYlOxJcWVnsda8o+ZDABxLOi/LISJJK7A+VEktYcKffUCLM6Zmq5tp5eQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 01 Aug 2025 19:05:31 +0200
Subject: [PATCH v2 9/9] drm/imx: parallel-display: put the bridge returned
 by drm_bridge_get_next_bridge()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-9-888912b0be13@bootlin.com>
References: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-0-888912b0be13@bootlin.com>
In-Reply-To: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-0-888912b0be13@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieeuvdfftefgueduleehueetgffgjeeitedtteetkeeuueeuueekveevvdeuveenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpeeknecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdduudekngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepphdriigrsggvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepshhhrgifnhhguhhosehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopefjuhhirdfruhesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm

The bridge returned by drm_bridge_get_next_bridge() is refcounted. Put it
when done. We need to ensure it is not put before either next_bridge or
next_bridge_state is in use, thus for simplicity use a cleanup action.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v2:
- use cleanup action instead of explicit drm_bridge_put(), also fixing the
  place where the ref is put
---
 drivers/gpu/drm/imx/ipuv3/parallel-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
index 6d8325c766979aa3ba98970f00806e99c139d3c3..dfdeb926fe9ca395c6843ec7976c8d00791dfbd2 100644
--- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
+++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
@@ -134,10 +134,10 @@ static int imx_pd_bridge_atomic_check(struct drm_bridge *bridge,
 	struct imx_crtc_state *imx_crtc_state = to_imx_crtc_state(crtc_state);
 	struct drm_display_info *di = &conn_state->connector->display_info;
 	struct drm_bridge_state *next_bridge_state = NULL;
-	struct drm_bridge *next_bridge;
 	u32 bus_flags, bus_fmt;
 
-	next_bridge = drm_bridge_get_next_bridge(bridge);
+	struct drm_bridge *next_bridge __free(drm_bridge_put) = drm_bridge_get_next_bridge(bridge);
+
 	if (next_bridge)
 		next_bridge_state = drm_atomic_get_new_bridge_state(crtc_state->state,
 								    next_bridge);

-- 
2.50.1


