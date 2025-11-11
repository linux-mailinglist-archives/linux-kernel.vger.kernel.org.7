Return-Path: <linux-kernel+bounces-895362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56EFC4D964
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4B13B1F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5430135971E;
	Tue, 11 Nov 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mkjuM7uc"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8E93587A3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862507; cv=none; b=CHcapcNw9KY0ikBMeRSXCApujHi6l+TgIPxDpRRFt5k6Q//W+BOEXXGMtti3VKpnL/9xkMAnwBNz9be7daBn3823Co5LteYkV1LCEVkJTRvj9/uhiUAA0EPXZc9H8GlXS4ZzBk11at73GRpKDSUIlHVz2/+pKaZHTJrwupWx7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862507; c=relaxed/simple;
	bh=pTVtwtaHZlz4jvjtf4bXZ8F5B4dNQekstKY773ofiwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lR0k3O8MEMz/zwwEmCzC4o2S+TnpVsfrsCM87+8AMJBXy0uQ46zUxDj6/Z/8dxfmzCRHO/dB+lZPQVpPgmv1rG2IfBr8lfX9GbFUkQGJcSV9JPCgXee3b1xkm8LW4Kk5ccYHcae3LWaLu0Cn4KTMHXfmSMtuFwyV/Ayeh/eRY1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mkjuM7uc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 209F2C0F544;
	Tue, 11 Nov 2025 12:01:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A2678606FB;
	Tue, 11 Nov 2025 12:01:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E17F01037194B;
	Tue, 11 Nov 2025 13:01:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762862503; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PnYF/WVZ8teADO7+ckgdcFUlsnZ8kt+JkbUC+EyFzls=;
	b=mkjuM7ucmizitTP2HZ89qJvFxamtghtTBXhh+wSny5JLPy6QGXMR33TgwJDQJuBuxrQgGx
	OTE3WsJ8dQIWPD3OXd4u9bYK1XWghAAeH5TpK3m0nuHXZqXDygy70hSiInvPgXD5BxgZbz
	ZhYJAEA0Jo1hz3cvjkEsMB0LmsTH/nkjVrp6ZFJl6n48uf+kPH48JpytIip2jjpgx8Ctzk
	mAsLMbqUrS5R22mi92nRxvtjwdCKxR+R22u3U2+1Y1Q016XK8HEo5DL+My3BiIiKVUIvms
	JGr+Mvy7fAYnNkvqfUwsIxM/f8VAfqglNPSaZyIbsbKzrmjTqN8A50hyX/V0pA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 11 Nov 2025 13:01:27 +0100
Subject: [PATCH v4 7/7] drm/bridge: prevent encoder chain changes in
 pre_enable/post_disable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-drm-bridge-alloc-encoder-chain-mutex-v4-7-12b13eb8c0f8@bootlin.com>
References: <20251111-drm-bridge-alloc-encoder-chain-mutex-v4-0-12b13eb8c0f8@bootlin.com>
In-Reply-To: <20251111-drm-bridge-alloc-encoder-chain-mutex-v4-0-12b13eb8c0f8@bootlin.com>
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

Reviewed-by: Maxime Ripard <mripard@kernel.org>
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
index eca138eadbc579013db3f588e260489a026baf67..76895b0f84d3828034c965b3786c24bfe8b31bfd 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -769,6 +769,7 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 
 	encoder = bridge->encoder;
 
+	mutex_lock(&encoder->bridge_chain_mutex);
 	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
 		limit = NULL;
 
@@ -817,6 +818,7 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 			/* Jump all bridges that we have already post_disabled */
 			bridge = limit;
 	}
+	mutex_unlock(&encoder->bridge_chain_mutex);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_post_disable);
 
@@ -863,6 +865,7 @@ void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 
 	encoder = bridge->encoder;
 
+	mutex_lock(&encoder->bridge_chain_mutex);
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
 		if (iter->pre_enable_prev_first) {
 			next = iter;
@@ -905,6 +908,7 @@ void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 		if (iter == bridge)
 			break;
 	}
+	mutex_unlock(&encoder->bridge_chain_mutex);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
 

-- 
2.51.1


