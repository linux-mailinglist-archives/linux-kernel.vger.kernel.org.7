Return-Path: <linux-kernel+bounces-724151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D967CAFEF30
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4009956472D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A452227BA4;
	Wed,  9 Jul 2025 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aXWvZKQX"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE211220F5B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079764; cv=none; b=faFyMYeP4Zrc7aWEHTcD8xH2/s9P6531mRRJ+8whd8pvcS1eEoomV6Rxaydx42OgC5HsVObtGkHXSxVfD1AUzn/d4AZ4k2QFQ6NGcdkGqyaZwjnljD3x8LaihdOTe+SYMqL4IxqQ/LA/hGu0ssdIY6jwVtiowCMZGflfTDDVleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079764; c=relaxed/simple;
	bh=Nz5ZaJvq2SpeTCXQeHkX4qjMf8EUFCkGQjQYQii2lhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rFJrwcdbfJoeNqvXQRU7T203+j1Bp0ssJvNgWLwZr+9JWMlVLaBsz9YnWxFx8mjhT0YMcv8uTW00XsDvVMQ4Zfh06vX0yp5j3IngtCuzEa+TF5EgSCJKnHWZu28iQfg0fIur50aD/qlNDjbVUlot/cj5fqrfDxjC3vPre6quY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aXWvZKQX; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92B6E4447A;
	Wed,  9 Jul 2025 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752079733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIibqyJNygtdMjhNsAuXg/eB4j41i3y0QJrk3xzhjtk=;
	b=aXWvZKQX+FwJvKOOEwvwnHWJWc5ePsuYjerVgeH3T5AVCZVoQwQQhAFd0x8TJ8ihQTDeR2
	I0PPdSpmgINr7tKF4/jf+8MIpYUixa+0A57tGK0sso7105mcOITrwYQTK6Mhf+uBX8qbV+
	kFO4tI7n88a5ypomXm/Y0D9WrVFuNYvhPDZfPNIm3ocY1DJY1QgF6i4NeZZUSwPAynolPn
	ZAMTdCkd60t5rCE2FO1gmMNglje8zyBmTCWg7GX60TMjDUIpuVV2JcAExetJgfyKYs3NjG
	+Tc+iQcJv4jDo+VVFc0ClbqgGU+Gagp1zvaBHm3ctawFrIVqGfNLv+o6XAXajQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 09 Jul 2025 18:48:04 +0200
Subject: [PATCH 5/9] drm/bridge: add drm_bridge_is_last()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-5-48920b9cf369@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkedtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieeiuedvffetgfeuudelheeutefggfejieettdetteekueeuueeukeevvedvueevnecukfhppeekjedruddvtddrvddukedrvddtjeenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepihhnvghtpeekjedruddvtddrvddukedrvddtjedphhgvlhhopegludelvddrudeikedruddrudefngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopefjuhhirdfruhesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepthhomhhirdhvrghlkhgvihhnvghnsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehvihgtthhorhdrlhhiuhesn
 higphdrtghomhdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepphdriigrsggvlhesphgvnhhguhhtrhhonhhigidruggv
X-GND-Sasl: luca.ceresoli@bootlin.com

Some code needing to know whether a bridge is the last in a chain currently
call drm_bridge_get_next_bridge(). However drm_bridge_get_next_bridge()
will soon increment the refcount of the returned bridge, which would make
such code more annoying to write.

In preparation for drm_bridge_get_next_bridge() to increment the refcount,
as well as to simplify such code, introduce a simple bool function to tell
whether a bridge is the last in the chain.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 include/drm/drm_bridge.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 9a7e9dd8cbfa54eedb82981032a25009e845a037..c2a7a7d2dfc420e9dcf7ea4c093ce1f1b939c820 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1264,6 +1264,11 @@ static inline struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 }
 #endif
 
+static inline bool drm_bridge_is_last(struct drm_bridge *bridge)
+{
+	return list_is_last(&bridge->chain_node, &bridge->encoder->bridge_chain);
+}
+
 /**
  * drm_bridge_get_current_state() - Get the current bridge state
  * @bridge: bridge object

-- 
2.50.0


