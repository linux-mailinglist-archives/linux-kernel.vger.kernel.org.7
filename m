Return-Path: <linux-kernel+bounces-775329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560A9B2BE03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25BF5E3170
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B731AF36;
	Tue, 19 Aug 2025 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gAUWfWpg"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B994319864
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597035; cv=none; b=LeDHtMMi1uwL307H8fkw3VqLek5snjLnMO6/z+N4BUPfphOswphmnZGbljzrJRFHzS48x8QXCjODkTKu6deqyGp19h2aHo5srbd5/9ThFSfgLvz5nMyKVqm3Jpt8G/HW96a4jgtmO0Od0R9bCYzSD3ADjcck5x4tZP8RbSypd4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597035; c=relaxed/simple;
	bh=oOrB2b+SZBEGEr+b2nr2pqWEaC8gpvTrBVDGaPpOngg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JGnZHLblbpeTA2LrVVCEoMYN3aqKzLg9hZr/0634oEL4r0NQgQFypngsZTO3kRzWiFVJCloPVggAvN/pKLPg2aLpsjBCG4m+yOpMrUtjBTsdyD0K3RT2Sd5/rrSfk1PEQTAJHE7puTb+XCdszwy8+aZGNnGaeELMWW/4+XruiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gAUWfWpg; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 66F98C6B3AC;
	Tue, 19 Aug 2025 09:42:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6B0B60697;
	Tue, 19 Aug 2025 09:42:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5D7F1C22A2DF;
	Tue, 19 Aug 2025 11:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755596559; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lVtAOszruAlXRUhdmLlMl09oS5i95scxy0aPVR8uQtM=;
	b=gAUWfWpgDOORglwPXvSNwb2YSMaSGNWaDikxqNfBVqmeNNHjNjQPaShkr4rCIzaK1BbvOA
	nZNfRM3cw0Z8mzHA/YZVI0xQC06jdBtIn+TlNjmUMYS9nSUJG+kyYCiztRaX55v2rtezs/
	LUjnRtXqhghAZJ6iRxgPaey0Sepq+1mfTiFLhPtKSicMZZdci9knU11vgONff+kVkuurqv
	paS6cSrUqkzSLS/Z50dOoNH1ucXePlMnO2TWVfB2WbSwnGGiwzZGubPd82/o96zvV6Ua/K
	txrS6BLUgGX+Uqb624e4q1H7JGX4T4w9CyaecUpzWq1O3ae1qG2wGTHaAhopqQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 Aug 2025 11:42:11 +0200
Subject: [PATCH v7 2/3] drm/bridge: add list of removed refcounted bridges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-drm-bridge-debugfs-removed-v7-2-970702579978@bootlin.com>
References: <20250819-drm-bridge-debugfs-removed-v7-0-970702579978@bootlin.com>
In-Reply-To: <20250819-drm-bridge-debugfs-removed-v7-0-970702579978@bootlin.com>
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

Between drm_bridge_add() and drm_bridge_remove() bridges are "published" to
the DRM core via the global bridge_list and visible in
/sys/kernel/debug/dri/bridges. However between drm_bridge_remove() and the
last drm_bridge_put() memory is still allocated even though the bridge is
not "published", i.e. not in bridges_list, and also not visible in
debugfs. This prevents debugging refcounted bridges lifetime, especially
leaks due to any missing drm_bridge_put().

In order to allow debugfs to also show the removed bridges, move such
bridges into a new ad-hoc list until they are eventually freed.

Note this requires adding INIT_LIST_HEAD(&bridge->list) in the bridge
initialization code. The lack of such init was not exposing any bug so far,
but it would with the new code, for example when a bridge is allocated and
then freed without calling drm_bridge_add(), which is common on probe
errors.

Document the new behaviour of drm_bridge_remove() and update the
drm_bridge_add() documentation to stay consistent.

drm_bridge_add() needs special care for bridges being added after having
been previously added and then removed.  This happens for example for many
non-DCS DSI host bridge drivers like samsung-dsim which
drm_bridge_add/remove() themselves every time the DSI device does a DSI
attaches/detach. When the DSI device is hot-pluggable this happens multiple
times in the lifetime of the DSI host bridge.  When this happens, the
bridge->list is found in the removed list, not at the initialized state as
drm_bridge_add() currently expects.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v7:
- rebase on current drm-misc-next
- remove if (drm_bridge_is_refcounted(bridge)), refcounting is now
  mandatory
- add check to detect when re-adding a bridge that is in the removed list
- improve commit message
- fix typo

This patch was added in v6.
---
 drivers/gpu/drm/drm_bridge.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 36e0829d25c29457cff5da5fec99646c74b6ad5a..2e688ee14b9efbc810bcdb0ab7ecd4b688be8299 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -197,15 +197,22 @@
  * driver.
  */
 
+/* Protect bridge_list and bridge_removed_list */
 static DEFINE_MUTEX(bridge_lock);
 static LIST_HEAD(bridge_list);
+static LIST_HEAD(bridge_removed_list);
 
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
@@ -288,10 +296,13 @@ void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
 EXPORT_SYMBOL(__devm_drm_bridge_alloc);
 
 /**
- * drm_bridge_add - add the given bridge to the global bridge list
+ * drm_bridge_add - publish a bridge
  *
  * @bridge: bridge control structure
  *
+ * Add the given bridge to the global list of "published" bridges, where
+ * they can be found by users via of_drm_find_bridge().
+ *
  * The bridge to be added must have been allocated by
  * devm_drm_bridge_alloc().
  */
@@ -304,6 +315,14 @@ void drm_bridge_add(struct drm_bridge *bridge)
 
 	drm_bridge_get(bridge);
 
+	/*
+	 * If the bridge was previously added and then removed, it is now
+	 * in bridge_removed_list. Remove it or bridge_removed_list will be
+	 * corrupted when adding this bridge to bridge_list below.
+	 */
+	if (!list_empty(&bridge->list))
+		list_del_init(&bridge->list);
+
 	mutex_init(&bridge->hpd_mutex);
 
 	if (bridge->ops & DRM_BRIDGE_OP_HDMI)
@@ -344,9 +363,14 @@ int devm_drm_bridge_add(struct device *dev, struct drm_bridge *bridge)
 EXPORT_SYMBOL(devm_drm_bridge_add);
 
 /**
- * drm_bridge_remove - remove the given bridge from the global bridge list
+ * drm_bridge_remove - unpublish a bridge
  *
  * @bridge: bridge control structure
+ *
+ * Remove the given bridge from the global list of "published" bridges,
+ * so it won't be found by users via of_drm_find_bridge(), and add it to
+ * the removed bridge list, to keep track of removed bridges until their
+ * allocated memory is actually freed.
  */
 void drm_bridge_remove(struct drm_bridge *bridge)
 {
@@ -357,7 +381,7 @@ void drm_bridge_remove(struct drm_bridge *bridge)
 			br->funcs->bridge_event_notify(br, DRM_EVENT_BRIDGE_REMOVING, bridge);
 
 	mutex_lock(&bridge_lock);
-	list_del_init(&bridge->list);
+	list_move_tail(&bridge->list, &bridge_removed_list);
 	mutex_unlock(&bridge_lock);
 
 	mutex_destroy(&bridge->hpd_mutex);

-- 
2.50.1


