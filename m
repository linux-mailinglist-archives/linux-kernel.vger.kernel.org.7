Return-Path: <linux-kernel+bounces-846730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4524CBC8DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FF184F902F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5832E762D;
	Thu,  9 Oct 2025 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N133HeLJ"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6792E6CA5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009978; cv=none; b=fvHZBipx+SUp7JtS3S+S1dwzrpdNi1JxNOK5wRiBuPpyTgKhtylXpopHrNHgbCFSntIXMiQ7qhADRMfdv+WTIaMMKFkq80e12lhLp4cjD/MhD9fRyjw8ESNkeX6loPdM7mN+GHxGDaj2MsxwOTh4xpkUtIdAweds3jMIsyECvns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009978; c=relaxed/simple;
	bh=WIda6DAZJ7I4bIJaPb17UW71bqwYq6YXRPtLF0Yj3v4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNbJvLmgf5hDy8tOdOL4Vf5SCsC80XFLZ4AawE9/SyISxG1t0lxuQmMQZOrEoBqSsw3rIA8kjmno5fWlkdmC3oMNyIxztUY+ZVo05KIBL4K4f4U4Lpyi+NT0wseRX4rgwecTqPpr5npW+KcChS6bH9IwnY5bnzQ3XLvWjJ5Ny7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N133HeLJ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D3B7F4E40FB3;
	Thu,  9 Oct 2025 11:39:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA1246062C;
	Thu,  9 Oct 2025 11:39:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D13A3102F21DF;
	Thu,  9 Oct 2025 13:39:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760009973; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+6w2LGFkAPvd0Ovd15hto8M5BEHW4sdwoZVyfuKtfTQ=;
	b=N133HeLJc45ll/GgeFG7ZLBOSkhuj0RlYV8M3jsfp/2tTZK6+UixQnzoasWf21cgPNqa0/
	HbAAi9W817kDHbFGAiCSup+6yBzZ/8xdbZpdYjUDkYbnVqq5PUgdRgnB/BqmGlOJNooCWp
	TyGnzlC6X9ZoYBmKLW4/T6sTbaH7lNasJUTcaAeE7CIXIGOcGn/NRW3trEL06uju8tVF7Y
	cNeUxCEr8dADPwS9zBcncey8FVNrG0XUSY/p70MIS/z4Cs2jvb+tA0qQRGFQEKph3j6Ca6
	RTYwoDQrvayQdaYEfayBQVlnUXvhQ3tVtOc1vhPoxe48W0JVfIngglFGHU2VxA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 09 Oct 2025 13:39:02 +0200
Subject: [PATCH v3 7/7] drm/bridge: prevent encoder chain changes in
 pre_enable/post_disable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-7-c90ed744efec@bootlin.com>
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

Take the encoder chain mutex while iterating over the encoder chain in
drm_atomic_bridge_chain_pre_enable() and
drm_atomic_bridge_chain_post_disable() to ensure the lists won't change
while being inspected.

These functions have nested list_for_each_*() loops, which makes them
complicated. list_for_each_entry_from() loops could be replaced by
drm_for_each_bridge_in_chain_from(), but it would not work in a nested way
in its current implementation. Besides, there is no "_reverse" variant of
drm_for_each_bridge_in_chain_from().

Keep code simple and readable by explicitly locking around the outer
loop. Thankfully there are no break or return points inside the loops, so
the change is trivial and readable.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- Lock encoder->bridge_chain_mutex directly, no wrappers
- Improved commit message

Changes in v2:
- Improved commit message
---
 drivers/gpu/drm/drm_bridge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 6de9b296c0be247f861815b7f558a80fd7938fae..a84aa68064513c654d6cc908718c79179f776ee7 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -760,6 +760,7 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 
 	encoder = bridge->encoder;
 
+	mutex_lock(&encoder->bridge_chain_mutex);
 	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
 		limit = NULL;
 
@@ -808,6 +809,7 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 			/* Jump all bridges that we have already post_disabled */
 			bridge = limit;
 	}
+	mutex_unlock(&encoder->bridge_chain_mutex);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_post_disable);
 
@@ -854,6 +856,7 @@ void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 
 	encoder = bridge->encoder;
 
+	mutex_lock(&encoder->bridge_chain_mutex);
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
 		if (iter->pre_enable_prev_first) {
 			next = iter;
@@ -896,6 +899,7 @@ void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 		if (iter == bridge)
 			break;
 	}
+	mutex_unlock(&encoder->bridge_chain_mutex);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
 

-- 
2.51.0


