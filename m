Return-Path: <linux-kernel+bounces-841198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3CEBB677D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED5219E1E32
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804032EC081;
	Fri,  3 Oct 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2vTnHhmj"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B482EC099
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759487996; cv=none; b=YDv2lVpow0aoJCXY3fTRIO1TJ7xZJysDY/aYrfaMk28c45QafIlu+NaacqRbUzg/4GVy2WlfwIT1kwsBftMkwWMQsJqNgjycw3L+NTjmK6lGFTQdrec+fVwkgKEAxc8oT95/ZlZE/P12UNso8SgVOaqdj7VV9Py59lAx9qSBbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759487996; c=relaxed/simple;
	bh=+6rLZEJVLUoBOu0HBcjpZGnC3LT1sYS2H2pxgugg1Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kGBltqYcOX9285rin9xgTwcNdAEAqN4Ha7lmZ/8N3Wwh6BrQcVIgRcXjy52AM2PPYcBXtA33Ggh8chbpGhumFseRU2A7IdGvKGQq9ZXPngo2qveZkAIUSa5906knI0KAa9JR7CgfCvtGkHnpzDveGpsQ17smNQtNFy6PComuyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2vTnHhmj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 947464E40E91;
	Fri,  3 Oct 2025 10:39:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 64C6560683;
	Fri,  3 Oct 2025 10:39:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E31A102F1C74;
	Fri,  3 Oct 2025 12:39:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759487992; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tT/vWu3Z8SdD0NgF7BlgEpJEzKECdpNxQ6B86Lk3qJo=;
	b=2vTnHhmjgRWgLDLzVfDUrVTs5+0gLfY4ZlR864hzh+1CNwTuiDz+Yy1qn3nbP5fX1BjwrB
	lOYQq//h4MwSkj/AfeKRA8JAbA0e73ruUHxUtU2dzqPbjOyP3e5GkOkFJerF3roLQVIRKQ
	pCNLdPjwWyDLCMW+/td+WRpndSRqu8eYHkcpfCXv3SYfPxaBmW2MbUwbuka5E2hRBx7a0S
	BhJZEjYY76tGyAWPOhf58XohVIK7GkJ7IAQKNKp+ew9WetP3EwmrWdamJS0geepZiRieOq
	fhdSubgvdKud+R0n1xRbOy6hPX+VqPH0PWzs7GTjBh2bU6a0ZocONGPry5rn/w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 03 Oct 2025 12:39:28 +0200
Subject: [PATCH v2 6/7] drm/bridge: prevent encoder chain changes while
 iterating with list_for_each_entry_reverse()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-6-78bf61580a06@bootlin.com>
References: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-0-78bf61580a06@bootlin.com>
In-Reply-To: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-0-78bf61580a06@bootlin.com>
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

These loops in drm_bridge.c iterate over the encoder chain using
list_for_each_entry_reverse(), which does not prevent changes to the bridge
chain while iterating over it.

Take the encoder chain mutex while iterating to avoid chain changes while
iterating.

All the "simple" loops are converted. drm_atomic_bridge_chain_pre_enable()
and drm_atomic_bridge_chain_post_disable() are handled by a separate
commit.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index be38dd7eefed0539795f721738e1f1df324d9a6f..2a55ac5697e0b4faa21f01728bbe287a95cd99a6 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -701,6 +701,7 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
 		return;
 
 	encoder = bridge->encoder;
+	drm_encoder_chain_lock(encoder);
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
 		if (iter->funcs->atomic_disable) {
 			iter->funcs->atomic_disable(iter, state);
@@ -711,6 +712,7 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
 		if (iter == bridge)
 			break;
 	}
+	drm_encoder_chain_unlock(encoder);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_disable);
 
@@ -1215,6 +1217,7 @@ int drm_atomic_bridge_chain_check(struct drm_bridge *bridge,
 		return ret;
 
 	encoder = bridge->encoder;
+	drm_encoder_chain_lock(encoder);
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
 		int ret;
 
@@ -1229,12 +1232,15 @@ int drm_atomic_bridge_chain_check(struct drm_bridge *bridge,
 						      crtc_state->state);
 
 		ret = drm_atomic_bridge_check(iter, crtc_state, conn_state);
-		if (ret)
+		if (ret) {
+			drm_encoder_chain_unlock(encoder);
 			return ret;
+		}
 
 		if (iter == bridge)
 			break;
 	}
+	drm_encoder_chain_unlock(encoder);
 
 	return 0;
 }

-- 
2.51.0


