Return-Path: <linux-kernel+bounces-724092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D79AFEE82
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8641C85124
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906F32E9733;
	Wed,  9 Jul 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hhi53dIw"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3EE20B7F4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076820; cv=none; b=Mf5Ylw5vIaxCficuSfPVY6L/3rnD6BYVfids17+gF6qewiElNKcvBMWrtROqAG0cXs9c18bUJ+RtgTdnhePl0MDhm45kXLjv/vNeTu2qwVJtEgmiV5e+K2YYm9NzbJhY0GqktQ014ljCprI4cMh8UcV+0dYHQ0106Wx423cY1U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076820; c=relaxed/simple;
	bh=eRkzVxJoJzveViCZFC3zhgHLciJ/OsU9Yhd73ktSx6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DB58xJofEiYLEqBRSCm/R83L3uJSbvP4FNfyhl85aMdo93HTVGM/HddBW/I//VNk/X+k4lL92z/3leLHBwIYh3LhUaqDo21epFBG9t61TCSkApT6RUz5ZhZVK7JK/W4ogNIAX+eAs8li6tOpbNFrNWCUtOHAUojcTNIO0VuRugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hhi53dIw; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61DD4442B6;
	Wed,  9 Jul 2025 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752076811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhSMeYx+c6fgyaDaz6bbicG3581JLtvv+WbtzwJTwJ0=;
	b=hhi53dIwlfyPoK39oPv6RXb+7GqdRqFzu6j5vCz4MhaG0tobku7x7VsagSAQ4jZnYlLN90
	Sj+jmeS1Hhj7Sf0VE7RfTpjnWf9F1JLsJLTypsNXkuz+BSS3ds2twcbMWAqqfdWa9KXhIX
	o4eHoNP3wCOy8gE0GpUVRxAmw7fRzlcdd+nWVIi4yI7err7iXEfCTknVVtm1sC8SoI0uC/
	85qf1l+LlB+w+9cOMdy3hQS/kJq11WzHplpbJ+kVPAGQfDsrXVeC2Kpw6J7NMaln2Rbp5h
	KBizk6vzm/4UWAkHrYr4ASx4ZUN2u2dn/AVRWIRXclFYbn5eA3kN6U0tMsYdyw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 09 Jul 2025 17:59:39 +0200
Subject: [PATCH 3/3] drm/bridge: display-connector: put the bridge obtained
 by drm_bridge_get_prev_bridge()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-drm-bridge-alloc-getput-drm_bridge_get_prev_bridge-v1-3-34ba6f395aaa@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieeiuedvffetgfeuudelheeutefggfejieettdetteekueeuueeukeevvedvueevnecukfhppeekjedruddvtddrvddukedrvddtjeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpeekjedruddvtddrvddukedrvddtjedphhgvlhhopegludelvddrudeikedruddrudefngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgvpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdprhgtphhtthhop
 ehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

The bridge returned by drm_bridge_get_prev_bridge() is refcounted. Put it
when done.

To keep the code clean and future-proof use a scope-based free.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/display-connector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index badd2c7f91a186e9a47c5a4ddc870d269f3798ab..b33f67d1ce49a8bd0b0ac3f13d15d332d9c95cf1 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -103,7 +103,7 @@ static u32 *display_connector_get_output_bus_fmts(struct drm_bridge *bridge,
 					struct drm_connector_state *conn_state,
 					unsigned int *num_output_fmts)
 {
-	struct drm_bridge *prev_bridge = drm_bridge_get_prev_bridge(bridge);
+	struct drm_bridge *prev_bridge __free(drm_bridge_put) = drm_bridge_get_prev_bridge(bridge);
 	struct drm_bridge_state *prev_bridge_state;
 
 	if (!prev_bridge || !prev_bridge->funcs->atomic_get_output_bus_fmts) {
@@ -146,7 +146,7 @@ static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
 					u32 output_fmt,
 					unsigned int *num_input_fmts)
 {
-	struct drm_bridge *prev_bridge = drm_bridge_get_prev_bridge(bridge);
+	struct drm_bridge *prev_bridge __free(drm_bridge_put) = drm_bridge_get_prev_bridge(bridge);
 	struct drm_bridge_state *prev_bridge_state;
 
 	if (!prev_bridge || !prev_bridge->funcs->atomic_get_input_bus_fmts) {

-- 
2.50.0


