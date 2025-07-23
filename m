Return-Path: <linux-kernel+bounces-742224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70259B0EEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9A41C83CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFB828C2D2;
	Wed, 23 Jul 2025 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m7XMOkwo"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37328A73C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264482; cv=none; b=nZjIkxnHesTp55vo3PQYwCSUuK2aYRy0/eMBfIABAucYpYz43VrMM8YKOic7kRivUYmch6UJkVQx81TTe0VilPyjKGyGddN9bar6jEvm2QdnBWf7FUPFusyb9+wZPVwtuFuhOWLazpDRDlTfCTbksw/Ywq9f9AwSW2DgjA6vsj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264482; c=relaxed/simple;
	bh=TCwCIwOwbWhbbDPYROKZRf33jwFfhp0mOqznmCqm3Og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DIUTDfSM6SeWHVs872V2VJtI071FzE15IrsPxGATAysSY9CamSx6wq2w6VvnwbdTZLhHwI3uXVNCvYRy9yei+qf6H0muuqCBrNOWkmNja7wHc4oiGQG2vm3d9m2x1p8J2PDSB8SxUVv6Ank9MEuDOtXKOBPaumdehty0/YXG74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m7XMOkwo; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2995043383;
	Wed, 23 Jul 2025 09:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753264477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgckLiMksu9NnI+G7de0Tf4Zyv3AuB7uM1WmnD7AIR8=;
	b=m7XMOkwoMvAIY87rt0wpG2TyTg46a2ZpVK/x0b2uwlezL35OUxXUNxLlpqmKLno/GRNh2A
	b+JpzKD8q/8VDvjJtQQoWwrTbSdyK40Je4ysoiwtC7qg3iYVMZs2F2j1FPVsWPhOC39+Ka
	jpDp++b19o9990TSytJaEGFP8nuZQndY1WGkoA5g481YAX/wvffBqDqeBdC8zkEu9zzfml
	PD/A4B1ymz7lfB1muexdWiPABVtPefnaukY0k1QBB0D/42+EViQ0AQMrqg4b19e9ci3PgE
	2c9hcJ07kl9yAi9WFLu50jVuawgwOUkX1QTmOvriCbJ3RZtlqiq4SaM06883Zg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 23 Jul 2025 11:54:10 +0200
Subject: [PATCH 3/9] drm/bridge: add drm_for_each_bridge_in_chain_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-drm-bridge-alloc-getput-for_each_bridge-v1-3-be8f4ae006e9@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieeiuedvffetgfeuudelheeutefggfejieettdetteekueeuueeukeevvedvueevnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedrjeehngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehth
 hhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepnhhitghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

Add variant of drm_for_each_bridge_in_chain() that gets/puts the bridge
reference at the beginning/end of each iteration, and puts it if breaking
ot of the loop.

Note that this requires adding a new drm_bridge_get_next_bridge_and_put()
function because, unlike similar functions as __of_get_next_child(),
drm_bridge_get_next_bridge() gets the "next" pointer but does not put the
"prev" pointer, and some of its users rely on this.

Also deprecate drm_for_each_bridge_in_chain(), in preparation for removing
it after converting all users to the scoped version.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Note 1: drm_for_each_bridge_in_chain_scoped() could be renamed removing the
        _scoped suffix after removing all the users of the current macro
        and eventually the current macro itself. Even though this series is
        converting all users, I'd at least wait one kernel release before
        renaming, to minimize issues with existing patches which would fail
        building.

Note 2: Yes, the drm_bridge_get_next_bridge_and_put() name is ugly, but we
        do need a "next_bridge" function that does not put the "prev"
        bridge and one that does. Any proposal for a better name or a
        different implementation is welcome.
---
 .clang-format            |  1 +
 include/drm/drm_bridge.h | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/.clang-format b/.clang-format
index 48405c54ef271e9546da08893d200a4cf48f3a55..1cac7d4976644c8f083f801e98f619782c2e23cc 100644
--- a/.clang-format
+++ b/.clang-format
@@ -168,6 +168,7 @@ ForEachMacros:
   - 'drm_exec_for_each_locked_object'
   - 'drm_exec_for_each_locked_object_reverse'
   - 'drm_for_each_bridge_in_chain'
+  - 'drm_for_each_bridge_in_chain_scoped'
   - 'drm_for_each_connector_iter'
   - 'drm_for_each_crtc'
   - 'drm_for_each_crtc_reverse'
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 717171d0e58725ed854209c3355260e415b4c5d7..990ef98011c96619b269787ebe01a2ad3b225c42 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1358,10 +1358,51 @@ drm_bridge_chain_get_first_bridge(struct drm_encoder *encoder)
  *	    iteration
  *
  * Iterate over all bridges present in the bridge chain attached to @encoder.
+ *
+ * This is deprecated, do not use!
+ * New drivers shall use drm_for_each_bridge_in_chain_scoped().
  */
 #define drm_for_each_bridge_in_chain(encoder, bridge)			\
 	list_for_each_entry(bridge, &(encoder)->bridge_chain, chain_node)
 
+/**
+ * drm_bridge_get_next_bridge_and_put - Get the next bridge in the chain
+ *                                      and put the previous
+ * @bridge: bridge object
+ *
+ * Same as drm_bridge_get_next_bridge() but additionally puts the @bridge.
+ *
+ * RETURNS:
+ * the next bridge in the chain after @bridge, or NULL if @bridge is the last.
+ */
+static inline struct drm_bridge *
+drm_bridge_get_next_bridge_and_put(struct drm_bridge *bridge)
+{
+	struct drm_bridge *next = drm_bridge_get_next_bridge(bridge);
+
+	drm_bridge_put(bridge);
+
+	return next;
+}
+
+/**
+ * drm_for_each_bridge_in_chain_scoped - iterate over all bridges attached
+ *                                       to an encoder
+ * @encoder: the encoder to iterate bridges on
+ * @bridge: a bridge pointer updated to point to the current bridge at each
+ *	    iteration
+ *
+ * Iterate over all bridges present in the bridge chain attached to @encoder.
+ *
+ * Automatically gets/puts the bridge reference while iterating, and puts
+ * the reference even if returning or breaking in the middle of the loop.
+ */
+#define drm_for_each_bridge_in_chain_scoped(encoder, bridge)		\
+	for (struct drm_bridge *bridge __free(drm_bridge_put) =		\
+	     drm_bridge_chain_get_first_bridge(encoder);		\
+	     bridge;							\
+	     bridge = drm_bridge_get_next_bridge_and_put(bridge))
+
 enum drm_mode_status
 drm_bridge_chain_mode_valid(struct drm_bridge *bridge,
 			    const struct drm_display_info *info,

-- 
2.50.1


