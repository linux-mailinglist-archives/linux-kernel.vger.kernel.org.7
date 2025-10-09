Return-Path: <linux-kernel+bounces-846728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09F2BC8DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E93E19E72FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E392E6CBD;
	Thu,  9 Oct 2025 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zjedaNTp"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602AD2E62A1
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009976; cv=none; b=kE/UfGaO3u3He1/zpek/ncUDozwfGF6dNNd6a1qIunl0xE71m36+6KsOt9ZmYMoUa05bl8hTxRwPjf/MjMLXsnt9d3C6kMwY0YT3R9r+Vyic4SjHe1aT7P0JOlP4wWbl4FSPL2vIfW8qlAET7ZleJdHJiZpqleDb+kMLORyrqMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009976; c=relaxed/simple;
	bh=LsJTzNL9GP1SZyKaCtyH3fYiJQtrEZje61Jyxv7Unn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3LDQxLYI1peVXFt9od9s9uGCLssn3LIlW9RH7k7uXbggnc9YqV7agKwlbKTE4UCyQJxwxdgklFeN89fA8dgJtu5rHBYuiwN2qiKNzcDboIZ6gB5GS1L7kVnBNFXLBtnOe5bUxw6PMXhPmRpselwOzXD83klfUC/E0BG6CVCKWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zjedaNTp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AA72C1A1246;
	Thu,  9 Oct 2025 11:39:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 78D046062C;
	Thu,  9 Oct 2025 11:39:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE677102F21DE;
	Thu,  9 Oct 2025 13:39:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760009971; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cROwU6Ms4+UsvzTSG4tIGvWS6XIhP0itMLTwI7puvS4=;
	b=zjedaNTpVPQU14BT98jIkKrLEG2Yye8FdgI1Rq+60U5OoNHzm5TDKiSfylIkxP/5mRCnJv
	fqZffACi8JdO4InpdLZw+fSXjFWIInZQ5ckwjd2BXGF30+F9lr+fNePLqusCfl5Obla3V4
	ygo41LUYX1XY2NYLoYf5GkbfdbyOnD5fyYn4J7XaabBWWdTPudEjnSosLz8qJ8Mnqger/9
	Q07uZ7Hux//4D+s4E2szUGgIbNCq8c3ASO4xAJYsIYWepn3c2DgH+pK9SyymYOVfrXhCgc
	7aESyX8tI4ceamu8SNu6xuExN6gsHWROfhXoOUAxv8WzadpELVM4gLOkI6UHhw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 09 Oct 2025 13:39:01 +0200
Subject: [PATCH v3 6/7] drm/bridge: prevent encoder chain changes while
 iterating with list_for_each_entry_reverse()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-6-c90ed744efec@bootlin.com>
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
index a56547a7bcfd05b17c07a03bd4ce52b0994e7cd8..6de9b296c0be247f861815b7f558a80fd7938fae 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -701,6 +701,7 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
 		return;
 
 	encoder = bridge->encoder;
+	mutex_lock(&encoder->bridge_chain_mutex);
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
 		if (iter->funcs->atomic_disable) {
 			iter->funcs->atomic_disable(iter, state);
@@ -711,6 +712,7 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
 		if (iter == bridge)
 			break;
 	}
+	mutex_unlock(&encoder->bridge_chain_mutex);
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_disable);
 
@@ -1215,25 +1217,27 @@ int drm_atomic_bridge_chain_check(struct drm_bridge *bridge,
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
2.51.0


