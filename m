Return-Path: <linux-kernel+bounces-760401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEBEB1EAAF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0451C1C23F4F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3929F283FFB;
	Fri,  8 Aug 2025 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GBJyfvRB"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C19283FE2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664592; cv=none; b=POYuzYSYGy7KT3M1D7kGp9HNS8xHumgtLWwaQO4WmsHCqXFOiX4cUSsYz0kaPrEv72B6xofM1t+J+/921xqcpdsFbDGv7jd+h2iStkCqJs9BEhU5yd87m85msvk6nasbHrBhtp0COB918iON+M4opYFsRxJvLI844WsOvBCVVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664592; c=relaxed/simple;
	bh=yehcEDEmUW4yLjbK5IRC+dYmbna0EzoYrEVkGZiPWus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9v1At5K0a29B4jiW8ycs6qwb/EbcIWBuuEw8D4xy9M6owUCRi2neOzgDuGUzkphBYJwz2bHu/uuQ4tejtxHCKoqNX14yiEQzlFpWcW8u7u5JEo1Ftsps2NGcZEfFVKrxJWD0Qk2QcQc6rmTgxOjcHXXiBKAy6IXbtujHCRUUDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GBJyfvRB; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2733B43987;
	Fri,  8 Aug 2025 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754664589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/2wX00WAoUxU/CboHSklDrYBEFuvVE2Nu58abNNKUU=;
	b=GBJyfvRBnK3I5H1JUEykygQSRAOi+dzlPpCvBwbu3OgCNjyHqVh9MoPnBmlj0A0Rxmn672
	/lLktv9+F3lhNO62WvAQmjemanHGv9OtGvnPfSR8EStUa4iJZyJsdqS+sW89ynXdsjZaox
	UDG+jDivYIwj8W+xcnSsC88pis9yDOlzSdVXXEPAXHcVAe/VXtcAGVB6Sf7A+hS2fUIgjY
	b7eogYCCSMjmXyVEGlAjcND/Hh+VlUxY1bCg60IH49uKaB1QdVKa/Ld71psxTdzDNFOx00
	Pz5JMxbsvS7VSWU/Wajbajl5EkdcVlAKFzJpGkQ0wEZF4g7PLWkRZMHV8g0Xnw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 08 Aug 2025 16:49:15 +0200
Subject: [PATCH v2 8/9] drm/bridge: add drm_for_each_bridge_in_chain_from()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-8-edb6ee81edf1@bootlin.com>
References: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-0-edb6ee81edf1@bootlin.com>
In-Reply-To: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-0-edb6ee81edf1@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegtdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieeuvdfftefgueduleehueetgffgjeeitedtteetkeeuueeuueekveevvdeuveenucfkphepjeekrddvuddvrddvjedrudduheenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepihhnvghtpeejkedrvdduvddrvdejrdduudehpdhhvghloheplgdujedvrdduiedrtddrudgnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdehpdhrtghpthhtohepnhhitghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthhopehmohhrsghosehgohhoghhlvgdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehtohhmihdrvhgrlhhkvghin
 hgvnhesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

Add variant of drm_for_each_bridge_in_chain_scoped() that iterates on the
encoder bridge from a given bridge until the end of the chain.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 include/drm/drm_bridge.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 6adf9221c2d462ec8e0e4e281c97b39081b3da24..6a79edcb4a8476a8eefa6ff00771b0f919de0f6b 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1396,6 +1396,25 @@ drm_bridge_get_next_bridge_and_put(struct drm_bridge *bridge)
 	     bridge;							\
 	     bridge = drm_bridge_get_next_bridge_and_put(bridge))
 
+/**
+ * drm_for_each_bridge_in_chain_from - iterate over all bridges starting
+ *                                     from the given bridge
+ * @first_bridge: the bridge to start from
+ * @bridge: a bridge pointer updated to point to the current bridge at each
+ *	    iteration
+ *
+ * Iterate over all bridges in the encoder chain starting from
+ * @first_bridge, included.
+ *
+ * Automatically gets/puts the bridge reference while iterating, and puts
+ * the reference even if returning or breaking in the middle of the loop.
+ */
+#define drm_for_each_bridge_in_chain_from(first_bridge, bridge)		\
+	for (struct drm_bridge *bridge __free(drm_bridge_put) =		\
+		     drm_bridge_get(first_bridge);			\
+	     bridge;							\
+	     bridge = drm_bridge_get_next_bridge_and_put(bridge))
+
 enum drm_mode_status
 drm_bridge_chain_mode_valid(struct drm_bridge *bridge,
 			    const struct drm_display_info *info,

-- 
2.50.1


