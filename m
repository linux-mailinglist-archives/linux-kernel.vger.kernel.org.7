Return-Path: <linux-kernel+bounces-724093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4862AFEE8E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6813417614E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00A22E9EA6;
	Wed,  9 Jul 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e3AGcNFY"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44E21CA02
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076820; cv=none; b=KKE4WxCAXimlXfF4QxhmVCeLbNy4CEW7N3ldcgvSwDCqztSlcEdk6g6fAs4Bx6BOMlIVx/83cCV745orxnc+mUYioqDYjRe6RFYnaiX4qMlr4XO9esh7Dl6Q22OnwyN+wYtXZ5Dny7Rm0Wz9El7chwFSLg7Kcr93FctPwPCDYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076820; c=relaxed/simple;
	bh=5Syu9WnVi7HevXeIrTLiMgwnXFTXHluV3IAstodHJwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jH3+4c2a9on45Rctk2RtO1d81a90t6Tj66EZSprfTE6rswNSusG6NolriyUXkAwomYj3PvxVqAP5zPmRAG4IFseV9OdSOnVu8MwLfgvoLYVzjYmNR9onp1Ao6hCTFTiHsfi3StCt/JMOrt1F4ytqeg7YQXzAVy3z4wqD5nrxO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e3AGcNFY; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEDE2442A3;
	Wed,  9 Jul 2025 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752076809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNxdQDQdPNWABi2+jVMdS0AZAzE6JnkU7tDF4GIU70w=;
	b=e3AGcNFYJy+fFtS4PhF2KK9sXfT4k17j8c/UOseIvZr9O28X+xLntQPevLL1sXw3h12LO4
	ZlCTNXFJq8pmSmDnHLJtHaPiQ0CetTULKhKLZytaqzKQOH5x/4C3ZWOmCAQd9eeWpvd7fH
	i1vIRqoBIq5hdEGgNaUunJh3agyWgxGfBzjWqqRjnz7bItpSeJ8e0U5ZFW2E7xe9PShf4x
	Xxgtdx+lyUXGSG/0kcAOkKKYOUge+5s53VN/rG/CnnXeZl7TSnmrBADMxL561Lrs172KSR
	h6CCI32ucML8FLZM2i58VbNa2ga6HBUblAKj+UfyQ1e2kQerxLrEDgnPktPghQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 09 Jul 2025 17:59:38 +0200
Subject: [PATCH 2/3] drm/bridge: select_bus_fmt_recursive(): put the bridge
 obtained by drm_bridge_get_prev_bridge()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-v1-2-34ba6f395aaa@bootlin.com>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-v1-0-34ba6f395aaa@bootlin.com>
In-Reply-To: <20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-v1-0-34ba6f395aaa@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieeiuedvffetgfeuudelheeutefggfejieettdetteekueeuueeukeevvedvueevnecukfhppeekjedruddvtddrvddukedrvddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekjedruddvtddrvddukedrvddtjedphhgvlhhopegludelvddrudeikedruddrudefngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgvpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdprhgtphhtthhop
 ehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

The bridge returned by drm_bridge_get_prev_bridge() is refcounted. Put it
when done.

select_bus_fmt_recursive() has several return points, and ensuring
drm_bridge_put() is always called in the right place would be error-prone
(especially with future changes to the select_bus_fmt_recursive() code) and
make code uglier. Instead use a scope-based free, which is future-proof and
a lot cleaner.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 0b450b334afd82e0460f18fdd248f79d0a2b153d..e33ccc5cabab72505b839d23bfa5ae644d2105c4 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -941,11 +941,11 @@ static int select_bus_fmt_recursive(struct drm_bridge *first_bridge,
 {
 	unsigned int i, num_in_bus_fmts = 0;
 	struct drm_bridge_state *cur_state;
-	struct drm_bridge *prev_bridge;
+	struct drm_bridge *prev_bridge __free(drm_bridge_put) =
+		drm_bridge_get_prev_bridge(cur_bridge);
 	u32 *in_bus_fmts;
 	int ret;
 
-	prev_bridge = drm_bridge_get_prev_bridge(cur_bridge);
 	cur_state = drm_atomic_get_new_bridge_state(crtc_state->state,
 						    cur_bridge);
 

-- 
2.50.0


