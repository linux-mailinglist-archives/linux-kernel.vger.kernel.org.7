Return-Path: <linux-kernel+bounces-760400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A7B1EAAE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5112B188FC52
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982DD283C89;
	Fri,  8 Aug 2025 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mdZWaVvY"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5850A280CCE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664590; cv=none; b=gqEKNR403bDSrZuiGtXuzCg513xtairGxVX4/ZxERPXsFpimOVQFcMcb+tbRZoqsq4cET8QdYHy/2g+QIO6cOtlGVPksa7N5hNYgFaTnnwlH4PK2ikUgXukbqRaHNRv6CYixA1M/DTwXWNroZJP2MITJWJaybUa5Z5NeJabBVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664590; c=relaxed/simple;
	bh=SQ4PKLbtpAlx9fmAQZmaVNLiTmhMfNOfPW/TkGdjOCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RCmVisRSzIxtQ2PxgbN/Rxh/uf3LdbrkKdGl2oUbIPG+gJIZgcRdmjl8/kLY3Gql822Z9D1VC7r/m+Fwst2P9uGjAKqkar8SBdd9NrIyalKPsJjZT3mQxxSyrJKixbQ+8Xui0SR1wXjs5Rea0EOpkffLXLIntJxWL7v+IqHEKJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mdZWaVvY; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A29544396F;
	Fri,  8 Aug 2025 14:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754664587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFmUiaJiX5nsFGYVqshO0Rsg745o2+ArF7mgdf+Q5BM=;
	b=mdZWaVvYVgj0uumtjM1kb5geiljIOtCEZu0e1KaorUCK8ZzNsIlJxmBFmKlg9UlndlFs3U
	0tBhZ0wTkOse+f+iGSaIxlhVnaqhJfpiAtLSyO6JdW/orVLxgbWFOq5N/nJIzE7xvXFsMf
	dZ2BtZN5sd1OtKbuMvvwijosha+mTWfF19JqscVixHnaFkjFYty41Uf2AzCZkbDjCwkXr2
	UvuuU24FOnV9Lzzhq/Ioz4cwWeKeudpw4uBQs7AB/oR1Ihwilx0E1A2ZhYeSAOgOD4oq4n
	zS6w3S+fKiU4P4gABrTPjBzQ12QwGcFBYqDDXkSOeGWfm3omyzBXZ2PO/ImZlA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 08 Aug 2025 16:49:14 +0200
Subject: [PATCH v2 7/9] drm/bridge: remove drm_for_each_bridge_in_chain()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-7-edb6ee81edf1@bootlin.com>
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
index a8e2f599aea764c705da3582df0ca428bb32f19c..6adf9221c2d462ec8e0e4e281c97b39081b3da24 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1358,20 +1358,6 @@ drm_bridge_chain_get_first_bridge(struct drm_encoder *encoder)
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


