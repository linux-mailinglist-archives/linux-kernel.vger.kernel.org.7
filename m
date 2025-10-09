Return-Path: <linux-kernel+bounces-846729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29751BC8DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B1F19E73BE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFE52E6CC8;
	Thu,  9 Oct 2025 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SbdI8vDI"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B52E62B5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009976; cv=none; b=nksvuVo/ucysoaEhot3hiRQRI+bwZUgE6ioPLfKJtAYUYvDRdroCcLo7nPF3F9nYwuryMLNuEiYCKUBbcPpQIHtcLi8lerFyYxawOiwk0IaWi59HJV/NY1kGNHQ6eMhw6IGCFkHKrY6sXaF0tWoMGoPpRcB0UIHXeIvNWc5b7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009976; c=relaxed/simple;
	bh=EvA8NhhhmK7Du+Lh4o/b0KeBJ1kZtJE6BpMo3Vq+Vbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/1Br5nsc+W1XbBR+ASpzRrKN7wgIuQrY3HXDXtYS8DBlhANwe7Krpwwf6qJd702xt6OCKRIuYnelxIRByeBEDpqus1dWdR1rwbUoZ+xGCQ0zvvnzvinADREQFIP47Q3yH/odEUWMQYW82qKm8tM2tmyyZH6FtcxJZgYT6C0TK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SbdI8vDI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0386D4E40FB4;
	Thu,  9 Oct 2025 11:39:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CD5B86062C;
	Thu,  9 Oct 2025 11:39:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25CB7102F21DB;
	Thu,  9 Oct 2025 13:39:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760009965; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=E4wwcagFmHgWy4N2yyidvfaDuAWl41fSvBPSX9B+tdI=;
	b=SbdI8vDIYCZvAzcu5u6FKzuYtiuTesBAoL+3fu9ufYH6wbC0DHoxRW67sFGMz9OORnNFZ2
	z/pl9uRZYSEH5mV6PE48ecrWYMCUYOiCJOS4F3DqfVjI9pLgYfl//yDBJpikmdDFYsgdDn
	fUgUJwi1tUUdc8Z90RVVXr4ztnK1AvAvo5gznrObb65+zkFUu4BW/5sEzkTEQekZyOM94y
	W6KtBXW9gZx+UJdRP8FGN9dcnJ/73nYnHs/SOaTHYByVL5/WZ9GtENpo1YAyj1gehqtqML
	CMTFsnGblpPphyPY8cfogb4x0Awe9IzObWEy1gFUxJ6meQO3uJbJTXTsom6/lw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 09 Oct 2025 13:38:59 +0200
Subject: [PATCH v3 4/7] drm/bridge: lock the encoder chain in scoped
 for_each loops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-4-c90ed744efec@bootlin.com>
References: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-0-c90ed744efec@bootlin.com>
In-Reply-To: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-0-c90ed744efec@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

drm_for_each_bridge_in_chain_scoped() and
drm_for_each_bridge_in_chain_from() currently get/put the bridge at each
iteration. But they don't protect the encoder chain, so it could change
(bridges added/removed) while some code is iterating over the list
itself. Such code can then derail on incorrect pointers.

To make iterations safe, augment these for_each macros to lock the encoder
chain mutex at the beginning and unlock it at the end of the loop (be it at
the end of the list, or earlier due to a 'break' or 'return' statement).

This change requires more operations when starting and ending the loop. To
avoid making the macros even more complex, move these operations to helper
functions. Also remname some of the existing helper functions for
consistency.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v3:
- Re-add drm_bridge_get/put()

Changed in v2:
- Fixed infinite loop in drm_for_each_bridge_in_chain_scoped() when
  encoder->bridge_chain is empty, reported here:
  https://lore.kernel.org/lkml/202509301358.38036b85-lkp@intel.com/
- Slightly improved commit message
---
 include/drm/drm_bridge.h | 73 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 26 deletions(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 0ff7ab4aa8689a022458f935a7ffb23a2b715802..d9eefe903208c0bd2464b9d4991456c93dc285aa 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1440,26 +1440,37 @@ drm_bridge_chain_get_last_bridge(struct drm_encoder *encoder)
 						      struct drm_bridge, chain_node));
 }
 
-/**
- * drm_bridge_get_next_bridge_and_put - Get the next bridge in the chain
- *                                      and put the previous
- * @bridge: bridge object
- *
- * Same as drm_bridge_get_next_bridge() but additionally puts the @bridge.
- *
- * RETURNS:
- * the next bridge in the chain after @bridge, or NULL if @bridge is the last.
- */
-static inline struct drm_bridge *
-drm_bridge_get_next_bridge_and_put(struct drm_bridge *bridge)
+/* Internal to drm_for_each_bridge_in_chain*() */
+static inline struct drm_bridge *__drm_for_each_bridge_in_chain_next(struct drm_bridge *bridge)
 {
 	struct drm_bridge *next = drm_bridge_get_next_bridge(bridge);
 
+	if (!next)
+		mutex_unlock(&bridge->encoder->bridge_chain_mutex);
+
 	drm_bridge_put(bridge);
 
 	return next;
 }
 
+/* Internal to drm_for_each_bridge_in_chain*() */
+DEFINE_FREE(__drm_for_each_bridge_in_chain_cleanup, struct drm_bridge *,
+	if (_T) { mutex_unlock(&_T->encoder->bridge_chain_mutex); drm_bridge_put(_T); })
+
+/* Internal to drm_for_each_bridge_in_chain_scoped() */
+static inline struct drm_bridge *
+__drm_for_each_bridge_in_chain_scoped_start(struct drm_encoder *encoder)
+{
+	mutex_lock(&encoder->bridge_chain_mutex);
+
+	struct drm_bridge *bridge = drm_bridge_chain_get_first_bridge(encoder);
+
+	if (!bridge)
+		mutex_unlock(&encoder->bridge_chain_mutex);
+
+	return bridge;
+}
+
 /**
  * drm_for_each_bridge_in_chain_scoped - iterate over all bridges attached
  *                                       to an encoder
@@ -1469,14 +1480,24 @@ drm_bridge_get_next_bridge_and_put(struct drm_bridge *bridge)
  *
  * Iterate over all bridges present in the bridge chain attached to @encoder.
  *
- * Automatically gets/puts the bridge reference while iterating, and puts
- * the reference even if returning or breaking in the middle of the loop.
+ * Automatically locks the encoder chain mutex to prevent chain
+ * modifications while iterating.
  */
-#define drm_for_each_bridge_in_chain_scoped(encoder, bridge)		\
-	for (struct drm_bridge *bridge __free(drm_bridge_put) =		\
-	     drm_bridge_chain_get_first_bridge(encoder);		\
-	     bridge;							\
-	     bridge = drm_bridge_get_next_bridge_and_put(bridge))
+#define drm_for_each_bridge_in_chain_scoped(encoder, bridge)				\
+	for (struct drm_bridge *bridge __free(__drm_for_each_bridge_in_chain_cleanup) =	\
+		__drm_for_each_bridge_in_chain_scoped_start((encoder));			\
+	     bridge;									\
+	     bridge = __drm_for_each_bridge_in_chain_next(bridge))			\
+
+/* Internal to drm_for_each_bridge_in_chain_from() */
+static inline struct drm_bridge *
+__drm_for_each_bridge_in_chain_from_start(struct drm_bridge *bridge)
+{
+	drm_bridge_get(bridge);
+	mutex_lock(&bridge->encoder->bridge_chain_mutex);
+
+	return bridge;
+}
 
 /**
  * drm_for_each_bridge_in_chain_from - iterate over all bridges starting
@@ -1488,14 +1509,14 @@ drm_bridge_get_next_bridge_and_put(struct drm_bridge *bridge)
  * Iterate over all bridges in the encoder chain starting from
  * @first_bridge, included.
  *
- * Automatically gets/puts the bridge reference while iterating, and puts
- * the reference even if returning or breaking in the middle of the loop.
+ * Automatically locks the encoder chain mutex to prevent chain
+ * modifications while iterating.
  */
-#define drm_for_each_bridge_in_chain_from(first_bridge, bridge)		\
-	for (struct drm_bridge *bridge __free(drm_bridge_put) =		\
-		     drm_bridge_get(first_bridge);			\
-	     bridge;							\
-	     bridge = drm_bridge_get_next_bridge_and_put(bridge))
+#define drm_for_each_bridge_in_chain_from(first_bridge, bridge)				\
+	for (struct drm_bridge *bridge __free(__drm_for_each_bridge_in_chain_cleanup) =	\
+		__drm_for_each_bridge_in_chain_from_start(first_bridge);		\
+	     bridge;									\
+	     bridge = __drm_for_each_bridge_in_chain_next(bridge))			\
 
 enum drm_mode_status
 drm_bridge_chain_mode_valid(struct drm_bridge *bridge,

-- 
2.51.0


