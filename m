Return-Path: <linux-kernel+bounces-760394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F1CB1EAA2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F9D178013
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2776D27F012;
	Fri,  8 Aug 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZXyx1wel"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BE927EFFB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664580; cv=none; b=SXfl7OIS/MibFJ4QoW/Yw6tex9exqODgwQTFHotKGB61ZryHsxP5u3CJODjFgFVljNGEqsE00df82xR0HMxAmv8gI1CSZ+Apb1cKv6jcLTcQsWo1aGznd5quI+eRzdc7yT5N4/iBeRxwuKDMi0n+9UW2PysA32RsYrBLuWTKjf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664580; c=relaxed/simple;
	bh=Xw7sWYWXoTQY+Q25UDP+cL1PHF1a6wb/vR2cpP9s1is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kcm5lQqmH7VA5UDAUZUonbd0A0xIK8j1Fes7T3q9yrOTs6+XQUfUsQfYObCI1oRbqed8RTUSMY8nrPnoh0MRzYWwAXTX5icquUDVmHAFEl4o6VeZUx42pOc20/Qcsu0YT50V9EEa12fSEZ6VccyNZZXRhLrLCEVb/rJ4hMY49n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZXyx1wel; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7EE143989;
	Fri,  8 Aug 2025 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754664577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKWKLjPvrLn+3l2rPdp1dYCYLrCa8Kpq+XSvfS93uLo=;
	b=ZXyx1welBEtu3ZlHt29TlZlp52sSUtKcrV2tyKfwvspWnTMUK3K7RlTPNpKAXfcrPBbLar
	89Qm5zqh6d8qrdGpRF81mx5YNC9hb16GKdji3uKyhyi6yPj5vZrkhweGX2DfZNukB4fn1j
	c+IwNpJy7qYSDJbmFSkCS50JGHe30LqznI3JmrJ3HrWyFnDcnPWq0CWw/0tEf0soosM+3r
	YD5GuTHr/Jb/6EHu2kaEINVjOyhnkvEPpt1ewyvtGsvkm6z5rEfi9ejBuhzkuxaa9UFiWH
	i8WFIo0iS3oeI3ykD8wF7l6794MlbJlyBTYByVTOJP2YiIHRawLAsU3+ZXshQQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 08 Aug 2025 16:49:10 +0200
Subject: [PATCH v2 3/9] drm/bridge: add
 drm_for_each_bridge_in_chain_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-drm-bridge-alloc-getput-for_each_bridge-v2-3-edb6ee81edf1@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegtdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieeuvdfftefgueduleehueetgffgjeeitedtteetkeeuueeuueekveevvdeuveenucfkphepjeekrddvuddvrddvjedrudduheenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeejkedrvdduvddrvdejrdduudehpdhhvghloheplgdujedvrdduiedrtddrudgnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdehpdhrtghpthhtohepnhhitghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthhopehmohhrsghosehgohhoghhlvgdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehtohhmihdrvhgrlhhkvghin
 hgvnhesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

drm_for_each_bridge_in_chain() iterates ofer the bridges in an encoder
chain without protecting the lifetime of the bridges using
drm_bridge_get/put(). This creates a risk window where the bridge could be
freed while iterating on it. Users of drm_for_each_bridge_in_chain() cannot
solve this reliably.

Add variant of drm_for_each_bridge_in_chain() that gets/puts the bridge
reference at the beginning/end of each iteration, and puts it if breaking
ot of the loop.

Note that this requires adding a new drm_bridge_get_next_bridge_and_put()
function because, unlike similar functions as __of_get_next_child(),
drm_bridge_get_next_bridge() gets the "next" pointer but does not put the
"prev" pointer. Unfortunately drm_bridge_get_next_bridge() cannot be
modified to put the "prev" pointer because some of its users rely on
this, such as drm_atomic_bridge_propagate_bus_flags().

Also deprecate drm_for_each_bridge_in_chain(), in preparation for removing
it after converting all users to the scoped version.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2:
- clarified commit message and mention an example where the current
  behaviour of drm_bridge_get_next_bridge() is wanted

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
index 620e119cc24c3491c2be5f08efaf51dfa8f708b3..a8e2f599aea764c705da3582df0ca428bb32f19c 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1365,10 +1365,51 @@ drm_bridge_chain_get_first_bridge(struct drm_encoder *encoder)
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


