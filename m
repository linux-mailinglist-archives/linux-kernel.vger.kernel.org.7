Return-Path: <linux-kernel+bounces-895359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BEBC4D940
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901733B1A08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11B73590D0;
	Tue, 11 Nov 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nd/M9dum"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780F13587C6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862503; cv=none; b=lZFF0AHiGxa3qPtEIw3tRcxCc0dN8GUvPgaD1OEmbfuUSOc6AYlqijY0G6ggUav4Zv6DY2L44o8oa0hL5g5fAfuOf1DNMmxMvBrZ7zuanLn8CpKanrKCbpQPefSJgLfffsYcENm8vqJvO2IoKoeMwd1fkqTGfF5GYF5MCaMVYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862503; c=relaxed/simple;
	bh=LB+IQzj/RyfVCejVXNOII9LYP9ZlKVcMW0+E8mu9ozU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kd7RE17VWyDixHxy8xXIKWwzGpI/WqZ/sv2DlpN01aE/HCchBauZ/tjQjFl1se6Okxd1L1i+fySmvJbnm9HghcgQKvK+79LifehELWlxhHfAyiNmS877AzoZ1xsqANEhc+9YZwSQpTtwu4glj+o1d2GTdjqcHn0hqsNX4q94IiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nd/M9dum; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 54CBDC0F544;
	Tue, 11 Nov 2025 12:01:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D7034606FB;
	Tue, 11 Nov 2025 12:01:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4444810371945;
	Tue, 11 Nov 2025 13:01:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762862499; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vFc4z5mhwogLuh5bJMqJoG/EPcrk5zOmeXK43n/q6e4=;
	b=nd/M9dumS9jfFht1mi1IHQgUT9ADWmkX7fbbov4XhGU3THhePmrttRfyvNPWebICWPplgY
	fzT2UVCdvp7xLLtzkbPoZp32qfNGGsmTjcolnWvqZq+cfor+DgmP0GnWLiTG81LEeTtRTr
	1QZJR/uM1E+2KVGxbVafCGx37ERKphrNah8sFJCq/ahQGCi+MVlOFbHAcSMBN3JOjolqZd
	exs7AHHN6Ru671X7pZAJ7Sikr6IeTHO2yM+SwOYrUfMh5DwrG1ZynpaTcP/7dPFzdRX6Pl
	bMF1i6Q8jtzTYdTZHomu4jHPczrvZ3Aii/T9+NJyMzKN6hmC4AEG0KIGZ4i07g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 11 Nov 2025 13:01:25 +0100
Subject: [PATCH v4 5/7] drm/bridge: prevent encoder chain changes while
 iterating with list_for_each_entry_from()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-drm-bridge-alloc-encoder-chain-mutex-v4-5-12b13eb8c0f8@bootlin.com>
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

These loops in drm_bridge.c iterate over the encoder chain using
list_for_each_entry_from(), which does not prevent changes to the bridge
chain while iterating over it.

Convert most of those loops to instead use
drm_for_each_bridge_in_chain_from(), which locks the chain.

This also simplifies code.

All the "simple" loops are converted here. The only ones not touched are
those in drm_atomic_bridge_chain_pre_enable() and
drm_atomic_bridge_chain_post_disable(), because they have nested loops
which are not well handled by drm_for_each_bridge_in_chain_from(). Those
two functions are handled by a separate commit.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index c8389383e0d286c0d576ae1864ee783e002d44be..9b4a075b5361c34c61316c6e52fe55c8928fbc13 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -627,7 +627,7 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 /**
  * drm_bridge_chain_mode_valid - validate the mode against all bridges in the
  *				 encoder chain.
- * @bridge: bridge control structure
+ * @first_bridge: bridge control structure
  * @info: display info against which the mode shall be validated
  * @mode: desired mode to be validated
  *
@@ -641,17 +641,14 @@ void drm_bridge_detach(struct drm_bridge *bridge)
  * MODE_OK on success, drm_mode_status Enum error code on failure
  */
 enum drm_mode_status
-drm_bridge_chain_mode_valid(struct drm_bridge *bridge,
+drm_bridge_chain_mode_valid(struct drm_bridge *first_bridge,
 			    const struct drm_display_info *info,
 			    const struct drm_display_mode *mode)
 {
-	struct drm_encoder *encoder;
-
-	if (!bridge)
+	if (!first_bridge)
 		return MODE_OK;
 
-	encoder = bridge->encoder;
-	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
+	drm_for_each_bridge_in_chain_from(first_bridge, bridge) {
 		enum drm_mode_status ret;
 
 		if (!bridge->funcs->mode_valid)
@@ -669,7 +666,7 @@ EXPORT_SYMBOL(drm_bridge_chain_mode_valid);
 /**
  * drm_bridge_chain_mode_set - set proposed mode for all bridges in the
  *			       encoder chain
- * @bridge: bridge control structure
+ * @first_bridge: bridge control structure
  * @mode: desired mode to be set for the encoder chain
  * @adjusted_mode: updated mode that works for this encoder chain
  *
@@ -678,20 +675,16 @@ EXPORT_SYMBOL(drm_bridge_chain_mode_valid);
  *
  * Note: the bridge passed should be the one closest to the encoder
  */
-void drm_bridge_chain_mode_set(struct drm_bridge *bridge,
+void drm_bridge_chain_mode_set(struct drm_bridge *first_bridge,
 			       const struct drm_display_mode *mode,
 			       const struct drm_display_mode *adjusted_mode)
 {
-	struct drm_encoder *encoder;
-
-	if (!bridge)
+	if (!first_bridge)
 		return;
 
-	encoder = bridge->encoder;
-	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
+	drm_for_each_bridge_in_chain_from(first_bridge, bridge)
 		if (bridge->funcs->mode_set)
 			bridge->funcs->mode_set(bridge, mode, adjusted_mode);
-	}
 }
 EXPORT_SYMBOL(drm_bridge_chain_mode_set);
 
@@ -915,7 +908,7 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
 
 /**
  * drm_atomic_bridge_chain_enable - enables all bridges in the encoder chain
- * @bridge: bridge control structure
+ * @first_bridge: bridge control structure
  * @state: atomic state being committed
  *
  * Calls &drm_bridge_funcs.atomic_enable (falls back on
@@ -925,22 +918,18 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
  *
  * Note: the bridge passed should be the one closest to the encoder
  */
-void drm_atomic_bridge_chain_enable(struct drm_bridge *bridge,
+void drm_atomic_bridge_chain_enable(struct drm_bridge *first_bridge,
 				    struct drm_atomic_state *state)
 {
-	struct drm_encoder *encoder;
-
-	if (!bridge)
+	if (!first_bridge)
 		return;
 
-	encoder = bridge->encoder;
-	list_for_each_entry_from(bridge, &encoder->bridge_chain, chain_node) {
+	drm_for_each_bridge_in_chain_from(first_bridge, bridge)
 		if (bridge->funcs->atomic_enable) {
 			bridge->funcs->atomic_enable(bridge, state);
 		} else if (bridge->funcs->enable) {
 			bridge->funcs->enable(bridge);
 		}
-	}
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_enable);
 

-- 
2.51.1


