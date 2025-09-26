Return-Path: <linux-kernel+bounces-834359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3640CBA487D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FE37AB364
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C642356C9;
	Fri, 26 Sep 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XbtvrSPf"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C881923C8AE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902454; cv=none; b=YgGr5o9Gv60jyNHpITgZxsZoAQlulnpNxjeUosa9bxQEOhcwo8E5SOFdHnL0FqnBhwHDkga0vwzqFmx7MfGwg3RUmKHXlmDzR5PJhqhBJYU1DWuiNA3ejIPu4Xf//rEvIzD5rBfBZUMPiICw3x61JBiXluALFrtE7fpcIpo2Wjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902454; c=relaxed/simple;
	bh=mRg4bVedUx+mXpwLwUzJ0+WNh3ExNZll4YLVmSD+zBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=drqhZ2OvqbOOUBWL8xzdjwKwDewevQRRCLAg6A/xf+PCxgfkTBOkdRhfxztm6mxdK0HxElUjTwDxmp/pSimzkimq+HmINrkzqRkUBAIr+mHN3uqd5xPQLKXFR+uj9Ue6LuvkFI2T+L08xaz0rCDPeQMa+orxaZFh8ydTnWnI4y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XbtvrSPf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EC016C00D96;
	Fri, 26 Sep 2025 16:00:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 553C4606B5;
	Fri, 26 Sep 2025 16:00:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ABECA102F18CE;
	Fri, 26 Sep 2025 18:00:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758902450; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tYrS6dqpb9FXjmJD9lscrTlhi/edkc3Eg6c4OrKKbRw=;
	b=XbtvrSPfQR9ZA7XGpi67t3aB9jq2x8uIyJcvxAXb1arVZq8vV3OprAxLhrZPyvM7tlW3y4
	OA+B6NILfxUEw40mM4tGRlLvKs0s9UiJJ4smtuNRfGwkzjTX3Ti0QHybs5YXb/UdS6M4vL
	vvCekEZUtdSvhuZHrG5FmDoqhlH2lGPsG1Dq/ePpu6Ua4bsq9taxU25PkoW3mt/+JLL8TB
	hXapXUJt3GCNfvM1RHCuR+wcO1iR0DRFA1rcBpgwsDwmFcoiSgEgWotqVJq+nOVvsG5m0R
	3FpGdvyxtSidJE0FOowbzh9T49e6sICcK/tMmLl3d1MF1YdL1uPCSaL74nsLWA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Sep 2025 17:59:45 +0200
Subject: [PATCH 4/7] drm/bridge: lock the encoder chain in scoped for_each
 loops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-4-23b62c47356a@bootlin.com>
References: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-0-23b62c47356a@bootlin.com>
In-Reply-To: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-0-23b62c47356a@bootlin.com>
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
itself. To make iterations safe, change the logic of these for_each macros
to lock the encoder chain mutex at the beginning and unlock it at the end
of the loop (be it at the end of the list, or earlier due to a 'break'
statement).

Also remove the get/put on the current bridge because it is not needed
anymore. In fact all bridges in the encoder chain are refcounted already
thanks to the drm_bridge_get() in drm_bridge_attach() and the
drm_bridge_put() in drm_bridge_detach(). So while iterating with the mutex
held the list cannot change _and_ the refcount of all bridges in the list
cannot drop to zero.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 include/drm/drm_bridge.h | 62 ++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 0ff7ab4aa8689a022458f935a7ffb23a2b715802..9b1aa1e29c8915648aef86ba9f8d85e843b22ca0 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1440,26 +1440,29 @@ drm_bridge_chain_get_last_bridge(struct drm_encoder *encoder)
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
+static inline struct drm_bridge *drm_bridge_encoder_chain_lock(struct drm_bridge *bridge)
 {
-	struct drm_bridge *next = drm_bridge_get_next_bridge(bridge);
+	drm_encoder_chain_lock(bridge->encoder);
+
+	return bridge;
+}
 
-	drm_bridge_put(bridge);
+/* Internal to drm_for_each_bridge_in_chain*() */
+static inline struct drm_bridge *__drm_encoder_bridge_chain_next(struct drm_bridge *bridge)
+{
+	if (list_is_last(&bridge->chain_node, &bridge->encoder->bridge_chain)) {
+		drm_encoder_chain_unlock(bridge->encoder);
 
-	return next;
+		return NULL;
+	}
+
+	return list_next_entry(bridge, chain_node);
 }
 
+/* Internal to drm_for_each_bridge_in_chain*() */
+DEFINE_FREE(drm_bridge_encoder_chain_unlock, struct drm_bridge *,
+	    if (_T) drm_encoder_chain_unlock(_T->encoder);)
+
 /**
  * drm_for_each_bridge_in_chain_scoped - iterate over all bridges attached
  *                                       to an encoder
@@ -1469,14 +1472,15 @@ drm_bridge_get_next_bridge_and_put(struct drm_bridge *bridge)
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
+	for (struct drm_bridge *bridge __free(drm_bridge_encoder_chain_unlock) =	\
+		     list_first_entry(&drm_encoder_chain_lock(encoder)->bridge_chain,	\
+				      struct drm_bridge, chain_node);			\
+	     bridge;									\
+	     bridge = __drm_encoder_bridge_chain_next(bridge))				\
 
 /**
  * drm_for_each_bridge_in_chain_from - iterate over all bridges starting
@@ -1488,14 +1492,14 @@ drm_bridge_get_next_bridge_and_put(struct drm_bridge *bridge)
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
+	for (struct drm_bridge *bridge __free(drm_bridge_encoder_chain_unlock) =	\
+		     drm_bridge_encoder_chain_lock(first_bridge);			\
+	     bridge;									\
+	     bridge = __drm_encoder_bridge_chain_next(bridge))				\
 
 enum drm_mode_status
 drm_bridge_chain_mode_valid(struct drm_bridge *bridge,

-- 
2.51.0


