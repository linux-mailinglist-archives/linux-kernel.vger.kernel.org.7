Return-Path: <linux-kernel+bounces-834360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A47DBA4880
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8161A563272
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5AC23184A;
	Fri, 26 Sep 2025 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YPFU0VV8"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6B235BE8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902458; cv=none; b=KKLqO4dJ/+/E+kcrWjGoE9D/3McL3uhS+Dszs5ZkwOceOaO/iw7WuFOa8wTdLc7VgG+eglIh7D9WLaXxwN27uKqRAju1isJTciu1ad7eR6G2VLVt2V4Ds5W/J58rNfbhNkSR1nfnRXwDVIbjKXSXFtlZJVaUGVbBeqhj2wDPe3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902458; c=relaxed/simple;
	bh=tc05hBsrp+6+igOBupAwrof6JjuQ7aPtrI0SQBCnEKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gAZYjHsYq5TJUPHz+e3QbQEbmyDJl/fgOpfdlxOTRJol0aBwrvmlEyghvUcr7s17SzDKXuElpi9WOuxji9cy+RhzT1x6voisaAuOI1mOVdbdZvJp/fHpAqd9EXMSfSzKzzsvpnc7En1VwYLICjQLkKbmXjilBzSv0bBJNGXxaqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YPFU0VV8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 555A31A0FFB;
	Fri, 26 Sep 2025 16:00:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A51E606B5;
	Fri, 26 Sep 2025 16:00:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0758102F197D;
	Fri, 26 Sep 2025 18:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758902448; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ff9fZeQb1F7MsGgDHiibGZyIrv+Z1+eAxMY8Mv7A+RM=;
	b=YPFU0VV8h/9XJmajQkQbiSnoYqjzbO/+CZRytTgjsHNm1mRgcjZoBdvtsRlhxghUlK58l1
	RqEbEpBV1lsTnUwOZXnDKfEJT+TP0UfzQLp5ucnmcC0T2DtKkO/Z3z896+/RUv2cDwf41I
	YmNUjxgdE2AF7cPDcc0QV5z4EVBzM1kWcZ/6o9uDCIIMomPYQgUO5gj1jRhMmvGgB2aJNu
	6XywxGEOd1EcoR3+dQsS1qDBCIuU1m+Q/SsT6+3wziFzDHmLmVLhXmcQV20QloNVhLvmd0
	FVeH6GXFPhoeMgJyYkGDnxuYNumPBDt0hampa7FY9HFMgWPLRBuGSIqevnJtmA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Sep 2025 17:59:44 +0200
Subject: [PATCH 3/7] drm/bridge: lock the encoder bridge chain mutex during
 insertion
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-3-23b62c47356a@bootlin.com>
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

drm_bridge_attach() modifies the encoder bridge chain, so take a mutex
around such operations to allow users of the chain to protect themselves
from chain modifications while iterating.

This change does not apply to drm_bridge_detach() because:
 * only the drm_encoder.c calls it, not bridge drivers (unlike
   drm_bridge_attach())
 * the only drm_bridge_detach() caller is drm_encoder_cleanup() which
   already locks the mutex for the entire cleanup loop, thus additionally
   locking it here would deadlock
 * drm_bridge_detach() is recursively calling itself along the chain, so
   care would be needed to avoid deadlocks
Add a comment to clarify that is intended.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 630b5e6594e0affad9ba48791207c7b403da5db8..90e467cf91a134342c80d2f958b928472aaf0d8b 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -453,10 +453,12 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	bridge->dev = encoder->dev;
 	bridge->encoder = encoder;
 
+	drm_encoder_chain_lock(encoder);
 	if (previous)
 		list_add(&bridge->chain_node, &previous->chain_node);
 	else
 		list_add(&bridge->chain_node, &encoder->bridge_chain);
+	drm_encoder_chain_unlock(encoder);
 
 	if (bridge->funcs->attach) {
 		ret = bridge->funcs->attach(bridge, encoder, flags);
@@ -487,7 +489,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 err_reset_bridge:
 	bridge->dev = NULL;
 	bridge->encoder = NULL;
+	drm_encoder_chain_lock(encoder);
 	list_del(&bridge->chain_node);
+	drm_encoder_chain_unlock(encoder);
 
 	if (ret != -EPROBE_DEFER)
 		DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
@@ -503,6 +507,11 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 }
 EXPORT_SYMBOL(drm_bridge_attach);
 
+/*
+ * Invoked by the encoder during encoder cleanup in drm_encoder_cleanup(),
+ * so should generally *not* be called by driver code. As opposed to
+ * drm_bridge_attach(), does not lock the encoder chain mutex.
+ */
 void drm_bridge_detach(struct drm_bridge *bridge)
 {
 	if (WARN_ON(!bridge))

-- 
2.51.0


