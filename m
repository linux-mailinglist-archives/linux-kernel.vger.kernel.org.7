Return-Path: <linux-kernel+bounces-814538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0705B5554D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B481D66653
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BD5324B22;
	Fri, 12 Sep 2025 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WB3kqPDw"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB432253A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696656; cv=none; b=LK4d2va06hbBZ06qA9Qmn3EdIifZiFwlmmCStOxj8+zWAlq3ZFD0dBSb2IZlGQ43CX8E2+2Y9Az9LY/WfyLWzEMBnn7rE/BwbJhJTNgQk1FObN92P6R3K8H63pZFxC/7YdKvInGo3wIUwpd+x3+BW3s+lFLr11HRfQWaow1mWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696656; c=relaxed/simple;
	bh=bLV44phdZF6IwzElEWY6DCNKe/BP3KfKgsfZQgqScks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VVeeesgQVQmb7oTn58v5wx3dH01a8rftH7LtYlp+k079TEG9bZRLjOLvuSGM0zIPeip3dPu/ImbbUgL1hhyJ/8YqzvNW4FQDwwkQO8mD2MFwTT8Z3sVqb1nkKFbBYqYT27cdGvRm7X7YYnDebU3oqPrdfFqdWAcvWigA1ga5SnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WB3kqPDw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D6C41C6B3A1;
	Fri, 12 Sep 2025 17:03:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D733960638;
	Fri, 12 Sep 2025 17:04:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97C05102F29DE;
	Fri, 12 Sep 2025 19:04:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757696650; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VeIuv3p4vjC6zIz1+BgG4iyoBoMir2Kb6ZfTMyf/iCE=;
	b=WB3kqPDwQLyNQe/deyMo2e6Unw4gHLGsq63w2MTopgrErcUwzgWytMgUprczAUlUlafGQY
	WGJvwBaoOA8iTVCJKuOGzA0KaE1f8Mprd1g38NbeLBkD/bVibEkg6sdfmH3lvhwEEsQTaX
	WkWBh0hM6uggb2a83DY9/R9D/6PfjJNgsoTUgNqfBflytZcvv+0KLdTxCpebDbzTVfgDxe
	OlARIpUFYxbZFNEYoLVmWQi7gpsCxBD89JaGQq2nNXi3pOiXfV14K08LCcknf4B/jZDaIy
	Hy2/uKlu6ECy5ssS4KTPNV/ZmEnLBSEbCgEjOEeAHKBTSGKc5UOqn5bY5Qf1CA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 12 Sep 2025 19:03:41 +0200
Subject: [PATCH v8 1/3] drm/bridge: add list of removed refcounted bridges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-drm-bridge-debugfs-removed-v8-1-5c33d87ccb55@bootlin.com>
References: <20250912-drm-bridge-debugfs-removed-v8-0-5c33d87ccb55@bootlin.com>
In-Reply-To: <20250912-drm-bridge-debugfs-removed-v8-0-5c33d87ccb55@bootlin.com>
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


