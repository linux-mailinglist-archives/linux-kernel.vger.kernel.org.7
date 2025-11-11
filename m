Return-Path: <linux-kernel+bounces-895361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE11C4D958
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513E93B1C89
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFCC358D3C;
	Tue, 11 Nov 2025 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FK5myhmI"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D03590A8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862506; cv=none; b=jwXmeLlTXniONQHeSSq7B2Py5ZDlnF+74/THC+Acd6DAQscWyR9Fj9nnQTVbViwX09nNHPbI5kQYsJts1WQgpDLG6y7IbaHHjtum7jozp/99ioz4VFXd+GMLjwsRS3Yu4bDMNNLYSSjqgBnL7yP6Dm7TUVB89TuYj+PdHYXmhWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862506; c=relaxed/simple;
	bh=D3Ky43SG0yUCfk5/3CdZYfibE7F9mhWd0r679ZWIvF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pPI9gSwQjeoRRpchQj9q5xmQ0+9wPerja4Hs0q/xc3D8H0cJVX68r4vXortr8uyT5p58GjBrmJNAVKkR+kkViNbLkqg8IHCRC/R1ghtylid4MKRZATOsc/NCmAOgmwXgi5Kbsiv5pkzC1h6OLQw+CmuOnJkd/36HbfaLS6zZoHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FK5myhmI; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D9E50C0F549;
	Tue, 11 Nov 2025 12:01:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 67971606FB;
	Tue, 11 Nov 2025 12:01:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F92110371943;
	Tue, 11 Nov 2025 13:01:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762862501; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VCb6Za5QIMArGVZWZ65WRJEbuxnkXAP2zkUiIdvfPJ8=;
	b=FK5myhmIuHP1WQO7y3LVKzunlWPfdR7lmOK6U1yRf093pTQ2G7baVlzuikvwq1B7fZ3fZr
	X/oYlxa1an04EUT8LqZS6BPBYf9+sAHp1R0T2YNFEe4R6k4AYISWCnRRAJaXbezo/5f+KG
	pU+AsxrNnuzL9TtumjdqNcfWoYPKFTdNpZv3dVP2BEYhFhTRvKyXrtP7hAZ08tXbZAVklY
	xT61IKYFMRsLldjri9ITs+PmvFGk9q5sogL2qcU1/hxUWjQMQZRxGG+W6i3FZgngBYPCgd
	ZYSdoJrKIleYpCfsmuUIBx10HD5sD41jx+RBw6L8FeG08wDuHxeajPRNgXdUOQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 11 Nov 2025 13:01:26 +0100
Subject: [PATCH v4 6/7] drm/bridge: prevent encoder chain changes while
 iterating with list_for_each_entry_reverse()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-drm-bridge-alloc-encoder-chain-mutex-v4-6-12b13eb8c0f8@bootlin.com>
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
list_for_each_entry_reverse(), which does not prevent changes to the bridge
chain while iterating over it.

Take the encoder chain mutex while iterating to avoid chain changes while
iterating.

All the "simple" loops are converted. drm_atomic_bridge_chain_pre_enable()
and drm_atomic_bridge_chain_post_disable() are handled by a separate
commit.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- Lock encoder->bridge_chain_mutex directly, no wrappers

Changes in v2: none
---
 drivers/gpu/drm/drm_bridge.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 9b4a075b5361c34c61316c6e52fe55c8928fbc13..eca138eadbc579013db3f588e260489a026baf67 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -710,6 +710,7 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
 		return;
 
 	encoder = bridge->encoder;
+	mutex_lock(&encoder->bridge_chain_mutex);
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
 		if (iter->funcs->atomic_disable) {
 			iter->funcs->atomic_disable(iter, state);
@@ -720,6 +721,7 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
 		if (iter == bridge)
 			break;
 	}
+	mutex_unlock(&encoder->bridge_chain_mutex);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_disable);
 
@@ -1224,25 +1226,27 @@ int drm_atomic_bridge_chain_check(struct drm_bridge *bridge,
 		return ret;
 
 	encoder = bridge->encoder;
-	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
-		int ret;
-
-		/*
-		 * Bus flags are propagated by default. If a bridge needs to
-		 * tweak the input bus flags for any reason, it should happen
-		 * in its &drm_bridge_funcs.atomic_check() implementation such
-		 * that preceding bridges in the chain can propagate the new
-		 * bus flags.
-		 */
-		drm_atomic_bridge_propagate_bus_flags(iter, conn,
-						      crtc_state->state);
-
-		ret = drm_atomic_bridge_check(iter, crtc_state, conn_state);
-		if (ret)
-			return ret;
+	scoped_guard(mutex, &encoder->bridge_chain_mutex) {
+		list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
+			int ret;
+
+			/*
+			 * Bus flags are propagated by default. If a bridge needs to
+			 * tweak the input bus flags for any reason, it should happen
+			 * in its &drm_bridge_funcs.atomic_check() implementation such
+			 * that preceding bridges in the chain can propagate the new
+			 * bus flags.
+			 */
+			drm_atomic_bridge_propagate_bus_flags(iter, conn,
+							      crtc_state->state);
+
+			ret = drm_atomic_bridge_check(iter, crtc_state, conn_state);
+			if (ret)
+				return ret;
 
-		if (iter == bridge)
-			break;
+			if (iter == bridge)
+				break;
+		}
 	}
 
 	return 0;

-- 
2.51.1


