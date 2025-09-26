Return-Path: <linux-kernel+bounces-834363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC7BBA4893
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0775633F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCEF25B1DA;
	Fri, 26 Sep 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FBqxXVd5"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310682376F8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902463; cv=none; b=N9YJE1RGL9u4TgJ0FX4ghwtZdwAjjPzpSi4Pm74C+F0dz03HyOPq3IGVZGSyLzMgz9QaDYZ/OUBfTdHu9/dasf19fRRehqx9A19+CJsdsWXcFKWcoZn78BGadcFEgeFtUUtZPBgEIP49kExjSdWf9KY1poSE6koAo9DaiXpoAtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902463; c=relaxed/simple;
	bh=icxZCjEnGm+TcTdFPyM09RWrz0BD5/vIpSXdbWLeZEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QLuw6PUg2RoFO5I5uCxrgBa+5R8YGWrhHTiYyMU9etpwNVF1RBsSpJHeHT0vR9gfFYlGfMGQO3vPxRLcLbc4b9HqhYvroXyUf2HrKK5v0wp7P2+2aiuUCDT4YzvQ7IzwwGmIBeoziq8NABSkphxtDyBUQSJ0hhG6CTb+SLWtY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FBqxXVd5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BC8571A0FF6;
	Fri, 26 Sep 2025 16:00:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90E1A606B5;
	Fri, 26 Sep 2025 16:00:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEEF9102F197F;
	Fri, 26 Sep 2025 18:00:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758902452; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=w6A6V6/jZ/f0JuPvAgDY4bvkUhD541wfb8QDR/S/VXA=;
	b=FBqxXVd5/B4URlVU2UdLmdlPpFpdqszAfyf5egj/9BUIkh7nsKfSrbGvg2GH0Fj+2sASXp
	mRPGtu18mo95KKRoe7KIO6LKubsW9eUL3vHGFAsNbMoeJX0YjQfz/Y2/uOa24hJAFk5pKO
	2w3ssnhmv3+xZs21CkNVqq6eykYs4UBlGSPJfU5OeOU+bp16RC43VrmF6jIHQGuxCddcs1
	mQBR+QatRlOhjwRdjUzQ6x2Zl6flU4NAPVvHfSu+CAAbojH+t2yhcC0HSSQRBM/kyMaIO0
	OuZUSRyC+QaYe8wJnXjj2frxxIKBcXK5bRDQePRItdsc4zZpF8RqrvbfChJzZg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Sep 2025 17:59:46 +0200
Subject: [PATCH 5/7] drm/bridge: prevent encoder chain changes while
 iterating with list_for_each_entry_from()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-5-23b62c47356a@bootlin.com>
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

These loops in drm_bridge.c iterate over the encoder chain using
list_for_each_entry_from(), which does not prevent changes to the bridge
chain while iterating over it.

Convert most of those loops to instead use
drm_for_each_bridge_in_chain_from(), which locks the chain.

This also simplifies code.

All the "simple" loops are converted here. The only ones not touched are
those in drm_atomic_bridge_chain_pre_enable() and
drm_atomic_bridge_chain_post_disable(), because they have nested loops
which are not well handled by drm_for_each_bridge_in_chain_from(). These
two functions are handled by a separate commit.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 90e467cf91a134342c80d2f958b928472aaf0d8b..554959147a00efa9807c245290cba8977ce88fc5 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -623,7 +623,7 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 /**
  * drm_bridge_chain_mode_valid - validate the mode against all bridges in the
  *				 encoder chain.
- * @bridge: bridge control structure
+ * @first_bridge: bridge control structure
  * @info: display info against which the mode shall be validated
  * @mode: desired mode to be validated
  *
@@ -637,17 +637,14 @@ void drm_bridge_detach(struct drm_bridge *bridge)
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
@@ -665,7 +662,7 @@ EXPORT_SYMBOL(drm_bridge_chain_mode_valid);
 /**
  * drm_bridge_chain_mode_set - set proposed mode for all bridges in the
  *			       encoder chain
- * @bridge: bridge control structure
+ * @first_bridge: bridge control structure
  * @mode: desired mode to be set for the encoder chain
  * @adjusted_mode: updated mode that works for this encoder chain
  *
@@ -674,20 +671,16 @@ EXPORT_SYMBOL(drm_bridge_chain_mode_valid);
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
 
@@ -911,7 +904,7 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
 
 /**
  * drm_atomic_bridge_chain_enable - enables all bridges in the encoder chain
- * @bridge: bridge control structure
+ * @first_bridge: bridge control structure
  * @state: atomic state being committed
  *
  * Calls &drm_bridge_funcs.atomic_enable (falls back on
@@ -921,22 +914,18 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
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
2.51.0


