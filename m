Return-Path: <linux-kernel+bounces-841199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5E7BB6786
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A1F3C0194
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6EA2ECD0E;
	Fri,  3 Oct 2025 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wtYD1khi"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDFA2EC0BF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759487998; cv=none; b=Dg0yatAlyBVotGXP25Nh6JdpiLtcLR9FWkdjAwStE8tadURT7Le68rtM5oAxd3UNeItR9FQWum4Mu60LBN0xU0S8CqjXGfXxKPk6IwJ2JZWS+5ryhtX3Dj2Z3QYzRv5AqvnsHkeVYPzSY7uteVYfMIruveFoRP6chEaTesfslq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759487998; c=relaxed/simple;
	bh=VOr5eBoNc9FnNHnP9I1a7YeygagW6If0Sow2UvyqWHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CiK78NoWz3bVCRVlUq1ltt2p3rbgt5LJBqjGOJdqKp9c9hy4QJzaZhASDU3h4onn+m2WTcniVlPC1qHbm0pKT1mRVDDV4blYn/UTMKr8oIJCbS+AJMPm8hP0gB6qPFtNNycoTHPNCiLq/A4IOSJ5t5EEnMQq/CgfSb8YPpibsSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wtYD1khi; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 808D9C00D98;
	Fri,  3 Oct 2025 10:39:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8103560683;
	Fri,  3 Oct 2025 10:39:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1134102F1C6C;
	Fri,  3 Oct 2025 12:39:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759487994; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tbt/7EiW1spKYTs5CQJj03xNV0I741bKU71RrfYpRZA=;
	b=wtYD1khie8pKkgE+AJBUeKyUOUNq8cQJOHgD94ksjKwHFbBS2F6nPLkC1LSz2dvNsFWhd3
	QFHGsvUL5GYWCJnDlmRok6dqb53ovlMujxwrl/D0C5dAtDNqNRDWxdEVGtFQ2UgM6dBNct
	NnUet2rzjjqbF+TcJCtTafPA0wWkWM3qJMm7WBRtfNXrYXkp9EVU0mNSFS1egijheh1pfa
	9ivubEtXhh3DxPhU/mea4OxAYFKE/+xhmStjUPP7XBEBTYAfrUkeVG69eaNw4rHs9rCmfH
	//qxhniDxsWvLoA1kwBfW9bicTeClWf+0SlpsqbVuf+VOC7/rBwWrK/nTMORVg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 03 Oct 2025 12:39:29 +0200
Subject: [PATCH v2 7/7] drm/bridge: prevent encoder chain changes in
 pre_enable/post_disable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-7-78bf61580a06@bootlin.com>
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
loop. Thankfully there are no return points inside the loops, so the change
is trivial and readable.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2:
- Improved commit message
---
 drivers/gpu/drm/drm_bridge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 2a55ac5697e0b4faa21f01728bbe287a95cd99a6..840ea4ef4bb27ea035cda784f8ec39cd768ed704 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -760,6 +760,7 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 
 	encoder = bridge->encoder;
 
+	drm_encoder_chain_lock(encoder);
 	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
 		limit = NULL;
 
@@ -808,6 +809,7 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 			/* Jump all bridges that we have already post_disabled */
 			bridge = limit;
 	}
+	drm_encoder_chain_unlock(encoder);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_post_disable);
 
@@ -854,6 +856,7 @@ void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 
 	encoder = bridge->encoder;
 
+	drm_encoder_chain_lock(encoder);
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
 		if (iter->pre_enable_prev_first) {
 			next = iter;
@@ -896,6 +899,7 @@ void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 		if (iter == bridge)
 			break;
 	}
+	drm_encoder_chain_unlock(encoder);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
 

-- 
2.51.0


