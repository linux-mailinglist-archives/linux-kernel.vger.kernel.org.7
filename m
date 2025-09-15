Return-Path: <linux-kernel+bounces-816585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6287B575E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4BC1AA1177
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346862FB967;
	Mon, 15 Sep 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p/LGZc6W"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7A2FB604
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931248; cv=none; b=u7ZqyohRvcC0ydV3Vyos30mhMFKXKQGjCPqkUV/PIw2rcSDEyAu6arLsT15qOp9hqIV2CjQq5/uGKLT9kQwsgqiNgHLY02ADiuc8fxUSq6jdQ1HSTcDkiKWzgDyzjtsmfgyfWXP5OH1ZRjtL8CQwueMpLqLR4c0F9aF7HS19t3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931248; c=relaxed/simple;
	bh=49KEp8TvfXCVdIa8TD63bhrs5MUuVkTk7tNfPShLDwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pa0Zf0YTSYg6G0TwQKxzmbvc8l4+WPWqBI8Ax/mSamVcEC/1yLWNQcfuWFXlSennCkoWndstcBxB88tJH4xIRgNPvHntAALZ9ZpjjLPLIjQm6f3J01zVh/EH4MAv/Lb6PtQf2eFb8dIVk+KDmW7mBweb7AdvVdbhGv8vJUG+H0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p/LGZc6W; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2DD751A0E13;
	Mon, 15 Sep 2025 10:14:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 027DF6063F;
	Mon, 15 Sep 2025 10:14:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08D4B102F2ABA;
	Mon, 15 Sep 2025 12:14:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757931242; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IAUhZTmobCaS25Cb7JsVWxwF+BZlLMSGAaomRA5kzc0=;
	b=p/LGZc6WkYkiTaCZTgrE7LSqHbKK6b27BKPq3qvZA1L7MeqlRuKEfkiC76o0bhyGw4dOTg
	BFY8PrtOsTpuOX8/nqPSlSPLxBMZUVd+plB0mfWCLeE0avWhbS0iPRe91kQhKEwUemPxyP
	GL/5MJLj1lOEzTuYboSWOOUyIDCpJMX77WrySKGQC3/+WOZpDYMvHPaqVIcfKgnxusHI5Q
	Iuc9l2ftG/h06ZieZuCGtEtvRDHTNGSDuQ8wzGTo8Ma8okDlC8pDghXR/B3l6htj0ZeH+l
	k8o1m/C1FL3hV4+fd2Eg962cXMaL0x9Ke7fDoGDX3u4fMQeYtsdbGvChQOUuuA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 15 Sep 2025 12:12:46 +0200
Subject: [PATCH v9 1/3] drm/bridge: add list of removed refcounted bridges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-drm-bridge-debugfs-removed-v9-1-6e5c0aff5de9@bootlin.com>
References: <20250915-drm-bridge-debugfs-removed-v9-0-6e5c0aff5de9@bootlin.com>
In-Reply-To: <20250915-drm-bridge-debugfs-removed-v9-0-6e5c0aff5de9@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Between drm_bridge_add() and drm_bridge_remove() bridges are registered to
the DRM core via the global bridge_list and visible in
/sys/kernel/debug/dri/bridges. However between drm_bridge_remove() and the
last drm_bridge_put() memory is still allocated even though the bridge is
not registered, i.e. not in bridges_list, and also not visible in
debugfs. This prevents debugging refcounted bridges lifetime, especially
leaks due to a missing drm_bridge_put().

In order to allow debugfs to also show the removed bridges, move such
bridges into a new ad-hoc list until they are eventually freed.

Note this requires adding INIT_LIST_HEAD(&bridge->list) in the bridge
initialization code. The lack of such init was not exposing any bug so far,
but it would with the new code, for example when a bridge is allocated and
then freed without calling drm_bridge_add(), which is common on probe
errors.

drm_bridge_add() needs special care for bridges being added after having
been previously added and then removed.  This happens for example for many
non-DCS DSI host bridge drivers like samsung-dsim which
drm_bridge_add/remove() themselves every time the DSI device does a DSI
attaches/detach. When the DSI device is hot-pluggable this happens multiple
times in the lifetime of the DSI host bridge.  On every attach after the
first one, drm_bridge_add() finds bridge->list in the removed list, not at
the initialized state as drm_bridge_add() currently expects. Add a
list_del_init() to remove the bridge from the lingering list and bring
bridge->list back to the initialized state.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---

Changes in v8:
- split the documentation changes to a separate patch
- rename "removed" to "lingering"
- improve commits message about the special care needed for "un-removed"
  bridges

Changes in v7:
- rebase on current drm-misc-next
- remove if (drm_bridge_is_refcounted(bridge)), refcounting is now
  mandatory
- add check to detect when re-adding a bridge that is in the removed list
- improve commit message
- fix typo

This patch was added in v6.
---
 drivers/gpu/drm/drm_bridge.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 5ec2ff77da79e51f614f98ebe58b6171c611867a..9491ae7c884d355be4a82fb02a43a42d17fa8e0c 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -197,15 +197,22 @@
  * driver.
  */
 
+/* Protect bridge_list and bridge_lingering_list */
 static DEFINE_MUTEX(bridge_lock);
 static LIST_HEAD(bridge_list);
+static LIST_HEAD(bridge_lingering_list);
 
 static void __drm_bridge_free(struct kref *kref)
 {
 	struct drm_bridge *bridge = container_of(kref, struct drm_bridge, refcount);
 
+	mutex_lock(&bridge_lock);
+	list_del(&bridge->list);
+	mutex_unlock(&bridge_lock);
+
 	if (bridge->funcs->destroy)
 		bridge->funcs->destroy(bridge);
+
 	kfree(bridge->container);
 }
 
@@ -275,6 +282,7 @@ void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
 		return ERR_PTR(-ENOMEM);
 
 	bridge = container + offset;
+	INIT_LIST_HEAD(&bridge->list);
 	bridge->container = container;
 	bridge->funcs = funcs;
 	kref_init(&bridge->refcount);
@@ -304,6 +312,14 @@ void drm_bridge_add(struct drm_bridge *bridge)
 
 	drm_bridge_get(bridge);
 
+	/*
+	 * If the bridge was previously added and then removed, it is now
+	 * in bridge_lingering_list. Remove it or bridge_lingering_list will be
+	 * corrupted when adding this bridge to bridge_list below.
+	 */
+	if (!list_empty(&bridge->list))
+		list_del_init(&bridge->list);
+
 	mutex_init(&bridge->hpd_mutex);
 
 	if (bridge->ops & DRM_BRIDGE_OP_HDMI)
@@ -357,7 +373,7 @@ void drm_bridge_remove(struct drm_bridge *bridge)
 			br->funcs->bridge_event_notify(br, DRM_EVENT_BRIDGE_REMOVING, bridge);
 
 	mutex_lock(&bridge_lock);
-	list_del_init(&bridge->list);
+	list_move_tail(&bridge->list, &bridge_lingering_list);
 	mutex_unlock(&bridge_lock);
 
 	mutex_destroy(&bridge->hpd_mutex);

-- 
2.51.0


