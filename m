Return-Path: <linux-kernel+bounces-742228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9683B0EEE8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A330962ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D9728A705;
	Wed, 23 Jul 2025 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NyO0e86L"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36CC28CF47
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264488; cv=none; b=PYlqs+BZQasQI7QNVnN8/9TSkU9fMRhAZKx4NiLSFzR5/1cL4m+7LeEkqRfnJTi1IJq1wruH+Mf/PeibqyNnKzLgvu22bZPHVHow1TbdjgBwUt8R6+R9jQLxDM4H13OSYTeZd7s/NybJWfE9IMxIY6+cuQLQM70OqcQbr9XHf10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264488; c=relaxed/simple;
	bh=mRYS39zNc769MPF6cqrwELZCDV9+yoOTGAq/3MYHuTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MYW6P1+prjtfncJys72xLP2ym55yjZ4cf6MtYbbSFZFv6NhqbkCkARW6Ih2vLFDc9ZmOEMZUwKyUxz2D9A3wvT0Mdoca3NJAUP4c1XtJ7Jf1AOb3Oc8VhF/ryydGEGjxD0OZQAfyZh8qoS4m7lniZbxufTm5m/SBdmw+ypFMojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NyO0e86L; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A75CB43383;
	Wed, 23 Jul 2025 09:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753264485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1aT9UvQsypJ5FnvT7oFv2tdykMxUGRvv4TCDw3cO58=;
	b=NyO0e86L5Ew9FQ+ZDvPWICbl2ZELRq6JoavXwU3d8ghvpUnCGDP6t7o9f+z5p7Rg0dcnjA
	SV9eRA6ghquPknMnGniCLiapzOYVHG/kC4LJ6DI056nK+S2LkbgMETG5TFsVrP1uDG+QJw
	Qj4uXKK83ubRf//72U5nlbCCXJkjnwKn96sdm5T83gkqYI1+vuPKLrL1z+2TBpvGKal094
	4gU7D+wyWGqemkxLCAGul9JwPxq2J8cOeqIEQb6clUta60vWYIQWMeDDYFeEKwmpW4b/nU
	V0boCTBoor2r1tANrcwg+3QavKSzCdDZa0uCISkxoaQIzNDJ7xZhSo/HsWmS+Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 23 Jul 2025 11:54:14 +0200
Subject: [PATCH 7/9] drm/bridge: remove drm_for_each_bridge_in_chain()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-drm-bridge-alloc-getput-for_each_bridge-v1-7-be8f4ae006e9@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieeiuedvffetgfeuudelheeutefggfejieettdetteekueeuueeukeevvedvueevnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedrjeehngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehth
 hhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepnhhitghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

All users have been replaced by drm_for_each_bridge_in_chain_scoped().

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 .clang-format            |  1 -
 include/drm/drm_bridge.h | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/.clang-format b/.clang-format
index 1cac7d4976644c8f083f801e98f619782c2e23cc..d5c05db1a0d96476b711b95912d2b82b2e780397 100644
--- a/.clang-format
+++ b/.clang-format
@@ -167,7 +167,6 @@ ForEachMacros:
   - 'drm_connector_for_each_possible_encoder'
   - 'drm_exec_for_each_locked_object'
   - 'drm_exec_for_each_locked_object_reverse'
-  - 'drm_for_each_bridge_in_chain'
   - 'drm_for_each_bridge_in_chain_scoped'
   - 'drm_for_each_connector_iter'
   - 'drm_for_each_crtc'
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 990ef98011c96619b269787ebe01a2ad3b225c42..0a45ed862ca3293bd0b12dacf3ba2c5429800d00 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1351,20 +1351,6 @@ drm_bridge_chain_get_first_bridge(struct drm_encoder *encoder)
 						       struct drm_bridge, chain_node));
 }
 
-/**
- * drm_for_each_bridge_in_chain() - Iterate over all bridges present in a chain
- * @encoder: the encoder to iterate bridges on
- * @bridge: a bridge pointer updated to point to the current bridge at each
- *	    iteration
- *
- * Iterate over all bridges present in the bridge chain attached to @encoder.
- *
- * This is deprecated, do not use!
- * New drivers shall use drm_for_each_bridge_in_chain_scoped().
- */
-#define drm_for_each_bridge_in_chain(encoder, bridge)			\
-	list_for_each_entry(bridge, &(encoder)->bridge_chain, chain_node)
-
 /**
  * drm_bridge_get_next_bridge_and_put - Get the next bridge in the chain
  *                                      and put the previous

-- 
2.50.1


