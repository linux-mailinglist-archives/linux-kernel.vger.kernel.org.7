Return-Path: <linux-kernel+bounces-721936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F01D0AFCFAF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2E81C2055B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721DB2E4269;
	Tue,  8 Jul 2025 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DYjb2dgh"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4C2E3375
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989745; cv=none; b=JXGghTT5lXtZK0ez28glRggNjUvQYYDDB/eRjt+3/HuyOOThWSagJxnBvVH2G0SxqodtIdl3op7wnunGlCijuWGYgXfMrzaIZYNPlVPPAhjGtVFvM1j9ShRSSSYZlsXbEZ/72KKfERlrMPSMeubRTocGmlXL+wKkbheqIbBN4H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989745; c=relaxed/simple;
	bh=Cl8E7CgdZ319yu1ao+0s52fdEwUlNLGk6sf3K1n1E0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fb66usFcShi4zD2NeN2ddBr4zvzTr4FXC2MCLVLVPrDmwQS8i6c8cVdu8bTtbqS+zWgwP2o2wm4zOBgp3vKxU2FqNQ5FIYDAluVt/W9uqlmKXDuihUlyAtKr4OKin4UEtImeYrgGmvR/FKMDprBHJALWhOKIfCHa5Pe3Qhpp4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DYjb2dgh; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96CEF443EB;
	Tue,  8 Jul 2025 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751989741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=364dwlo7n3lm96H5WbZ7sg/Dj/Yi+dx86lYDn85W+Lc=;
	b=DYjb2dghuimIhN/xIQjAaIf6rI+oVoAKZ9pm9qLeAdyuSnPWcxmkEC59EW0nD+fyCkXLO5
	4zPoXrQaiOUEz4ud1I88iGULBfHIA1VWgm2klYRciQL39NSTjz7bnyX/zQ2T6d8GgVHHRn
	gch62s0chCTc9YlIdSZGE5qtqo1ktjDo1HYpX+p8ejNTz924lYMLnrzQ7+y0j66uo32uYX
	8U6HOlE8xCC30tVKUUwBtr5jTGnJcihyC5LFITOnasvjaEZ6SWB3MJew0GRg3lmciCjYfv
	6V4WkRzV9HhvIjUdRywDWEDqy/TKHTEf2At1FY9iGaV79QmTUI7CQnFye1QWmQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 08 Jul 2025 17:48:20 +0200
Subject: [PATCH v9 3/5] drm/mxsfb: put the bridge returned by
 drm_bridge_chain_get_first_bridge()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-drm-bridge-alloc-getput-drm_bridge_chain_get_first_bridge-v9-3-db1ba3df7f58@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefhedtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieeiuedvffetgfeuudelheeutefggfejieettdetteekueeuueeukeevvedvueevnecukfhppeekjedruddvtddrvddukedrvddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekjedruddvtddrvddukedrvddtjedphhgvlhhopegludelvddrudeikedruddrudefngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdprhgtphhtt
 hhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

The bridge returned by drm_bridge_chain_get_first_bridge() is
refcounted. Put it when done. Use a scope-based free action to catch all
the code paths.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---

Changes in v9:
- declare 'bridge' variable on first usage to avoid unnecessary cleanup for
  !connector_state->crtc
- removed Maxime's R-by (diff content changed)

Changes in v8: none

This patch was added in v7.
---
 drivers/gpu/drm/mxsfb/lcdif_kms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
index dbd42cc1da87f82ef9cd4ccc70cdecbe56035174..1c3b33be6c40f5e6e25b0104040bf4eb56e06081 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
@@ -433,7 +433,6 @@ static int lcdif_crtc_atomic_check(struct drm_crtc *crtc,
 	struct drm_connector *connector;
 	struct drm_encoder *encoder;
 	struct drm_bridge_state *bridge_state;
-	struct drm_bridge *bridge;
 	u32 bus_format, bus_flags;
 	bool format_set = false, flags_set = false;
 	int ret, i;
@@ -453,7 +452,8 @@ static int lcdif_crtc_atomic_check(struct drm_crtc *crtc,
 
 		encoder = connector_state->best_encoder;
 
-		bridge = drm_bridge_chain_get_first_bridge(encoder);
+		struct drm_bridge *bridge __free(drm_bridge_put) =
+			drm_bridge_chain_get_first_bridge(encoder);
 		if (!bridge)
 			continue;
 

-- 
2.50.0


