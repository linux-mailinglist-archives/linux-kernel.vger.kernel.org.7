Return-Path: <linux-kernel+bounces-834362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B97C8BA4886
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD8F1C07186
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE18F24E00F;
	Fri, 26 Sep 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DguTKvKv"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A72459F7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902461; cv=none; b=BBLHmrKchLw8tQnrFbr7AWQuSeTG0R/Q+OO2KatSwm3Uwqsm9X0+wpo7Oy5WE3shcjswGQbuRHrbhHoxpiR8RsKuTpHcG/LM81W4h87r8+2ngDoS2yMNbdrD5aKQFPEiuM6WOjosDfJjJpF2g+Dk/YwjCbKQXmX3B5KhiLlaMyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902461; c=relaxed/simple;
	bh=+Y2++zYj21q+KEWiAsSAEfIpc1oJGQSTIPtdn+yg2B8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sN5i0WIFILbaaqXJtxGBokhXP4xPlL2Wq0Xk7mLNfx+o7tf2jyj/ZWZUiKv0MHGHUKZ2ZNxcd8j0RrOvcTGNTD5HBY4JXcaoNzoo1jNVhug3Bda/jYR7WF/QUgkv6B0TM4iu0RnvD4zq/iAWzeGgGaujZBtaKn0Lt1sYFcVSmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DguTKvKv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E86EF1A0FEC;
	Fri, 26 Sep 2025 16:00:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BE9EA606B5;
	Fri, 26 Sep 2025 16:00:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EC8A102F1980;
	Fri, 26 Sep 2025 18:00:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758902457; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=t4G6wBu8UnoC2aStDYzdldOpdl6B8KUtUfr4tyax8QI=;
	b=DguTKvKvD//rLvhdqb0VJLcKWpgyEcp+48rm/D8nvSYb1kmBl1EjrXCdrkKf9YL2DrfqV6
	gPebDaCppZ8wPDOFsqE1y1lW6cT0JaaR97O/xCHvi8xcoIvDasCfDROpNAl5SDVyAmtDwl
	vECj0ZbJFiEgx681THe+2xP1o8IT0cWNhplUQecDLpzJj6Pocu6Ye3D6/pffPlzO8pw25u
	/aWZkuE5LVB9ismDQRJBLgZtzAXtGG5dyGX7AKslHZ/O/84aGb+Fdf0YdjCeRxCr/EnmTm
	Zb5bhYCBVdxAs875B3Wnt7ef0+RtRm85I4D5KGd4qM07Nj6W6Ry5NlCujspu0A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Sep 2025 17:59:48 +0200
Subject: [PATCH 7/7] drm/bridge: prevent encoder chain changes while
 iterating in drm_atomic_bridge_chain_post_disable/pre_enable()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-7-23b62c47356a@bootlin.com>
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

Take the encoder chain mutex while iterating over the encoder chain in
drm_atomic_bridge_chain_pre_enable() and
drm_atomic_bridge_chain_post-disable().

These functions have nested list_for_each_*() loops, which makes them
complicated. list_for_each_entry_from() loops could be replaced by
drm_for_each_bridge_in_chain_from(), but it would not work in a nested
way. Besides, there is no "_reverse" variant of
drm_for_each_bridge_in_chain_from().

Keep code simple and readable by explicitly locking around the outer
loop. Thankfully there are no return points inside the loops, so the change
is trivial and readable.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 66c0a80db8426ffb360248895cfe2a11d6007ed7..00e0a88128d0eeabf25911591ad8c482d6c1caf8 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -765,6 +765,7 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 
 	encoder = bridge->encoder;
 
+	drm_encoder_chain_lock(encoder);
 	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
 		limit = NULL;
 
@@ -813,6 +814,7 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 			/* Jump all bridges that we have already post_disabled */
 			bridge = limit;
 	}
+	drm_encoder_chain_unlock(encoder);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_post_disable);
 
@@ -859,6 +861,7 @@ void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 
 	encoder = bridge->encoder;
 
+	drm_encoder_chain_lock(encoder);
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
 		if (iter->pre_enable_prev_first) {
 			next = iter;
@@ -901,6 +904,7 @@ void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 		if (iter == bridge)
 			break;
 	}
+	drm_encoder_chain_unlock(encoder);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
 

-- 
2.51.0


