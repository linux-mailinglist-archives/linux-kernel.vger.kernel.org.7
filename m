Return-Path: <linux-kernel+bounces-753675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83996B18642
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E19B1C271E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F5C28CF6D;
	Fri,  1 Aug 2025 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R4KIPmXL"
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07428C860
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067949; cv=none; b=Z6oOvv8W1o8QPKGhMJRM7lJUNXvALlOKkh7X3dOXGn0zAoALfHel1MZX5JYcW0QLUzRNV5WNyjU2glusImNds/mC8mcNQGoViYN6TqWhBw9lNLUuf8pp7XIC9bQCKZNPr0QSiuxeDzpS+GgoksHVonujmmnTq+Cc3364H4QcFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067949; c=relaxed/simple;
	bh=OoVOrYPA6wqF4fymShxjqQcm3Bn+yTtym9tejHxTmhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ppxcnPmLmDC++QGKoKqfo7CK1lK/eGRhzESVw9ypsx32t/0y8ijQWGBUUcYkqKNoIX4rC6r/1J5c7SdPzB+ezSLENzpLduAEqVMpJeJfhVVRX8yYjDET19eo8aRhBNxjcpEWAF4wt02dZ7uS9LUcklyWiN4kZOuFSZfbzfKJNgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R4KIPmXL; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D66E442C7;
	Fri,  1 Aug 2025 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754067946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oM95PjcRikyO3sPH9AVOKQwjpoJ/s1h7pZhmKVi6Q4M=;
	b=R4KIPmXLfMb2D5hYOdhjbeFLTMUOBhnAi5q6APf38pqzbdicvp8iNMiwm14Yid68lqhduj
	4ktqdnyVbIHmA3OYfbfV88crIo/miNYH9peK656A57r7LYXygFxBmnEboKgM0+qEtYEpju
	Z2XN5wxmlY9V7MFTLBlOEXucVlLKh2d3DQj9m04h4djEkOw1gpqV2T4z4d7O5rGCbtzyMf
	OgKizfrTaRlnmLSm+wk2tKnnemwC21bzvkZAo18FflV8xqpU/JHgEaJolZJ1DWXnWqXWFF
	tACPDdVrTmqsL08jwlcnq9I03eJBo70aQAlYaRmACEhO0jblZzEI+Z4gEbtKJA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 01 Aug 2025 19:05:27 +0200
Subject: [PATCH v2 5/9] drm/bridge: add drm_bridge_is_last()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-5-888912b0be13@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieeuvdfftefgueduleehueetgffgjeeitedtteetkeeuueeuueekveevvdeuveenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdduudekngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepphdriigrsggvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepshhhrgifnhhguhhosehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopefjuhhirdfruhesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm

Some code needing to know whether a bridge is the last in a chain currently
call drm_bridge_get_next_bridge(). However drm_bridge_get_next_bridge()
will soon increment the refcount of the returned bridge, which would make
such code more annoying to write.

In preparation for drm_bridge_get_next_bridge() to increment the refcount,
as well as to simplify such code, introduce a simple bool function to tell
whether a bridge is the last in the chain.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 include/drm/drm_bridge.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index ce51b73e323ec5e188e84c9577803bd4934daf2b..7aeffb8bb3b2aeeae7a3a19435b6a1cf109a45cd 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1269,6 +1269,11 @@ static inline struct drm_bridge *of_drm_find_bridge(struct device_node *np)
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
2.50.1


