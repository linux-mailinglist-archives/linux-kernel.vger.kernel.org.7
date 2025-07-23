Return-Path: <linux-kernel+bounces-742222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B55B0EEDE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02AC1635AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D5628B4EC;
	Wed, 23 Jul 2025 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IGF0ZUkh"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D18D288C24
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264479; cv=none; b=m+kpFOeSZUIGuotwLce2bZeH5G3MZBr9X5V52GkDRwNsSZPHjB49MZpG85+kx9hoGZukALb+psyaTsfN51aqPDxbqiTM+I90/GCzYJH89Gc9UJa69MkmWs1/fN2gkzfnXj19nLS+OOVVDDa25BC+9jHqjBSglJygLept58zF0dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264479; c=relaxed/simple;
	bh=TR6H9vhB/qFJMc8S7OFtQFjgbVhU9R6LQz2RKnpHAa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9I9JP3kc9HHVmCNB6V7Q7NFPMB3OPrxREuuWJJ0Snh1+u+zUnNKDVsHx4SkKuAdVYU8Lp1I/TpTTkkMlB0C72i3COAVGM2n8guppyUrfpUpgsin7rmJo5mpJm1p9+IWfMl0NuQL45DnA7CJZg1fHXWMIiz/Iz/kbusgF6ov5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IGF0ZUkh; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A6C14336F;
	Wed, 23 Jul 2025 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753264474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+FAywltmFU9dB2pOTz2lEsEdD9YeBwzzMU9uV0qEppY=;
	b=IGF0ZUkhuWgd7hbMZFwfFNWAOiPI3e6zy/JvOhDXuT8YAWkCPdH2Zo23I/Akeuz40kfFW2
	fmsaJ27ZwmTlrgw0gRUENOJA03VO57mDoFa4WjuvFt1rYssc9wzXuRGwlJJcdlGI8PqMQ0
	i5UCaWdilSXugNAgkP+Qu8EWQG9qJx+aexCOPfcH+I4p+iRkaO+cOR1UTk2pktTzY1Heu5
	QCvG8o7wSNltRk1mIgPQrwRgytu19hx7jElxfiRus73vI09D1xT7dFKmGVmi2rzXNTpIYG
	SOWs7NKxaRuDc3acS4lfXJ+uqD7cCDBE/OKtHa6N3JVIRDVYiFpu1hxOnKSCIg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 23 Jul 2025 11:54:08 +0200
Subject: [PATCH 1/9] drm/display: bridge-connector: use scope-specific
 variable for the bridge pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-drm-bridge-alloc-getput-for_each_bridge-v1-1-be8f4ae006e9@bootlin.com>
References: <20250723-drm-bridge-alloc-getput-for_each_bridge-v1-0-be8f4ae006e9@bootlin.com>
In-Reply-To: <20250723-drm-bridge-alloc-getput-for_each_bridge-v1-0-be8f4ae006e9@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieeiuedvffetgfeuudelheeutefggfejieettdetteekueeuueeukeevvedvueevnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedrjeehngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehth
 hhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepnhhitghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

Currently drm_bridge_connector_init() reuses the 'bridge' variable, first
as a loop variable in the long drm_for_each_bridge_in_chain() and then in
the HDMI-specific code as a shortcut to bridge_connector->bridge_cec.

We are about to remove the 'bridge' loop variable for
drm_for_each_bridge_in_chain() by moving to a scoped version of the same
macro, which implies removing the 'bridge' variable from the main function
scope. Additionally reusing the variable can make such long function less
readable.

Similarly to what commit 6f727c838ea8 ("drm/bridge-connector: Fix bridge in
drm_connector_hdmi_audio_init()") already did for the audio HDMI bridge,
use n local variable inside the scopes where it is needed as a
bridge_connector->bridge_hdmi_cec shortcut to make its scope clearer as
well as to allow removing the 'bridge' variable in an upcoming commit.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 8c915427d0538435661d771940efe38b462027a1..3ddde53b28131c3ce026413eb5518e9c8ed08b4d 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -816,7 +816,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 
 	if (bridge_connector->bridge_hdmi_cec &&
 	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
-		bridge = bridge_connector->bridge_hdmi_cec;
+		struct drm_bridge *bridge = bridge_connector->bridge_hdmi_cec;
 
 		ret = drmm_connector_hdmi_cec_notifier_register(connector,
 								NULL,
@@ -827,7 +827,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 
 	if (bridge_connector->bridge_hdmi_cec &&
 	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
-		bridge = bridge_connector->bridge_hdmi_cec;
+		struct drm_bridge *bridge = bridge_connector->bridge_hdmi_cec;
 
 		ret = drmm_connector_hdmi_cec_register(connector,
 						       &drm_bridge_connector_hdmi_cec_funcs,

-- 
2.50.1


