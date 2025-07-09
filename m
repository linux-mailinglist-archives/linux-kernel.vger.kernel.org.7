Return-Path: <linux-kernel+bounces-724094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E99AFEE8F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22964A4002
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F4C2E9ECA;
	Wed,  9 Jul 2025 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jS9ei2Fh"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797AF21D3FD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076820; cv=none; b=EagmEvbWcU/yz+yKSdDhhFIGZlunQwsRt1dLh/cpgFI/nK9utwo4FjAJb8a43pWcnNRIGNcGLVvrtbrkQK5No1X1oL2FICiF/NCG5gI7UhiP19vNralPQ1WxjP7CCkb1vIt0W4iWyWjgFhCoAbo+I7XZLAaOxyFo72Uf7hwbTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076820; c=relaxed/simple;
	bh=FOB6NVAdj77B7etl+3vdpp5HV6WqmidtI8qLeekpu30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n94Yl39f2WpVkcCLupgHMXpw9RtBAEfg7Bh1kfR7su5fIwjzHgT0t7fOrzzzw+bqqovRpaRKxkpaCY1tpDZdd7wHfEFn5cJFi+1PNo+BircQMGXhBBezYzvqUIlxPONhaqRqAnavAp3lkPUhq70h+zh04tXjgGkXPKKuXPXrapw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jS9ei2Fh; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63016442A0;
	Wed,  9 Jul 2025 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752076807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4Fu6uRN35M9ABH71ptDERBQIMFiqhxT4jo9+8kKo8A=;
	b=jS9ei2FhMYXKfStq4TPwBdGvCAQhjn4oGRqJjQFS9ahnQwa9YToFLpY7TgSN3fSJx3g3A6
	Ugsn5iUv9wCQ3B++QsfVkQNPorH6jVk9cSRTqe44b2UMUVFDwuyeaKwjmwXOYEe21qSPOQ
	CQbFF4dfVYCc7fY+P6l7/lF533qBbl/My0zTvQ6b06SxPOwvBrWfFqPVxbQD4nFqimYnMA
	u9LozLNpg1J2SrOHSsuWX5wauHgJD6xdX3gOxt6M84f9lqejs98L7yxZ9pbnms4j8BZyxk
	UBY/o4t7RkdGOIhFHZ8JiBcwUTeH4owCf5js0q+o98JMtQmOdLObkCq4xkwpUA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 09 Jul 2025 17:59:37 +0200
Subject: [PATCH 1/3] drm/bridge: get the bridge returned by
 drm_bridge_get_prev_bridge()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-v1-1-34ba6f395aaa@bootlin.com>
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

drm_bridge_get_prev_bridge() returns a bridge pointer that the
caller could hold for a long time. Increment the refcount of the returned
bridge and document it must be put by the caller.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 include/drm/drm_bridge.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index d2454ba83db36f8f0d475b0b37468c2ebe7e921d..1963fa61b7f3aa41c7112cb9902790962aff8808 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1316,6 +1316,13 @@ drm_bridge_get_next_bridge(struct drm_bridge *bridge)
  * drm_bridge_get_prev_bridge() - Get the previous bridge in the chain
  * @bridge: bridge object
  *
+ * The caller is responsible of having a reference to @bridge via
+ * drm_bridge_get() or equivalent. This function leaves the refcount of
+ * @bridge unmodified.
+ *
+ * The refcount of the returned bridge is incremented. Use drm_bridge_put()
+ * when done with it.
+ *
  * RETURNS:
  * the previous bridge in the chain, or NULL if @bridge is the first.
  */
@@ -1325,7 +1332,7 @@ drm_bridge_get_prev_bridge(struct drm_bridge *bridge)
 	if (list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain))
 		return NULL;
 
-	return list_prev_entry(bridge, chain_node);
+	return drm_bridge_get(list_prev_entry(bridge, chain_node));
 }
 
 /**

-- 
2.50.0


