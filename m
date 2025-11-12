Return-Path: <linux-kernel+bounces-897758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CC4C53864
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0450C566943
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A81341661;
	Wed, 12 Nov 2025 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N5q44cJc"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E9733A026
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965298; cv=none; b=TmXm9te561GQzEEh0PcYV3wbV5JIwLrb4PhDOCSCODnl7JS7ZrJYsCZP7GE9YlPNIUiPKd0i3XfusC20Mvfs+FGozRAfydxAfteItHq/weH9qquDxH1+fwZXZnDxFyeG0bTuyM0WED7g1fV/R6xT1jZ7dGyX3cdno72i5lbxMVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965298; c=relaxed/simple;
	bh=m7pFqUbehQFZT3TAGqXcOGURwuIsoFlYDExsqXsTh2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0+6B+t2fm7suhFCzBc2DnpiopB3QacsKSO62Thbk6KEk3Q+ffduD3ZNlIzG03yy4EKVyRFXKGAvWHr9oVQpbZ61md7vSUfW80EbAj/qIkm7I+iRhiCPmRdjx0orDxcvBo26A6g8KN4TqYizoVaRDqCA9nXhRJWTNQKd3hcj6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N5q44cJc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DA370C0F574;
	Wed, 12 Nov 2025 16:34:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 801DF6070B;
	Wed, 12 Nov 2025 16:34:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D1DD102F084F;
	Wed, 12 Nov 2025 17:34:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762965292; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AbBF9YK95hha/G3M+Fz+28OT4bWjR1IMawslI9+BHEU=;
	b=N5q44cJcURD+I6ZaGZujoY1LJ5r+oAAO9Dn/gr8R9vqI56UPqbOCi5YrhPJwh9oijOD6Ay
	zoRctqubfuVasY/rqGGVY/SK55fhWBh/60qss3SrDtXSUUuPiKZj+cPsJz+qJ4QdrEL3tZ
	q4b3nra6CdfdshIGXnTN5oWiimBDKoP2045flPsJH6oKIim+a3EWx6xMRXsEj4fzSKiqbZ
	coxHQdv9wghleS1WepYu3/3pOBZUTHviW2Oinv3gSSFpnxK+fr21OezJU0sN8DV9gTeuTs
	a0MRxSR5/SMlTzDhxOh+3vNxMqOQOb4hUk83sgPpMFmk+h2m1FcoOntk/hvt9w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 12 Nov 2025 17:34:34 +0100
Subject: [PATCH v3 1/2] drm/bridge: add drm_bridge_unplug() and
 drm_bridge_enter/exit()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-drm-bridge-atomic-vs-remove-v3-1-85db717ce094@bootlin.com>
References: <20251112-drm-bridge-atomic-vs-remove-v3-0-85db717ce094@bootlin.com>
In-Reply-To: <20251112-drm-bridge-atomic-vs-remove-v3-0-85db717ce094@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

To allow DRM bridges to be removable, add synchronization functions
allowing to tell when a bridge hardware has been physically unplugged and
to mark a critical section that should not be entered after that.

This is inspired by the drm_dev_unplugged/enter/exit() functions for struct
drm_device.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Link: https://lore.kernel.org/all/20250106-vigorous-talented-viper-fa49d9@houat/
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- call drm_bridge_remove() in drm_bridge_unplug()
- Fixed kerneldoc variable names (reported here:
  https://lore.kernel.org/lkml/202509271654.j3IsjsAJ-lkp@intel.com/)
---
 drivers/gpu/drm/drm_bridge.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     | 12 +++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 8f355df883d8ac8de9d361ec302f4ccbf3bca0d6..db40c26d1cb354f818f12a5a53f9baa6a7fc3574 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -27,6 +27,7 @@
 #include <linux/media-bus-format.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/srcu.h>
 
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
@@ -202,6 +203,67 @@ static DEFINE_MUTEX(bridge_lock);
 static LIST_HEAD(bridge_list);
 static LIST_HEAD(bridge_lingering_list);
 
+DEFINE_STATIC_SRCU(drm_bridge_unplug_srcu);
+
+/**
+ * drm_bridge_enter - Enter DRM bridge critical section
+ * @bridge: DRM bridge
+ * @idx: Pointer to index that will be passed to the matching drm_bridge_exit()
+ *
+ * This function marks and protects the beginning of a section that should not
+ * be entered after the bridge has been unplugged. The section end is marked
+ * with drm_bridge_exit(). Calls to this function can be nested.
+ *
+ * Returns:
+ * True if it is OK to enter the section, false otherwise.
+ */
+bool drm_bridge_enter(struct drm_bridge *bridge, int *idx)
+{
+	*idx = srcu_read_lock(&drm_bridge_unplug_srcu);
+
+	if (bridge->unplugged) {
+		srcu_read_unlock(&drm_bridge_unplug_srcu, *idx);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(drm_bridge_enter);
+
+/**
+ * drm_bridge_exit - Exit DRM bridge critical section
+ * @idx: index returned by drm_bridge_enter()
+ *
+ * This function marks the end of a section that should not be entered after
+ * the bridge has been unplugged.
+ */
+void drm_bridge_exit(int idx)
+{
+	srcu_read_unlock(&drm_bridge_unplug_srcu, idx);
+}
+EXPORT_SYMBOL(drm_bridge_exit);
+
+/**
+ * drm_bridge_unplug - declare a DRM bridge was unplugged and remove it
+ * @bridge: DRM bridge
+ *
+ * This tells the bridge has been physically unplugged and no operations on
+ * device resources must be done anymore. Entry-points can use
+ * drm_bridge_enter() and drm_bridge_exit() to protect device resources in
+ * a race free manner.
+ *
+ * Also unregisters the bridge.
+ */
+void drm_bridge_unplug(struct drm_bridge *bridge)
+{
+	bridge->unplugged = true;
+
+	synchronize_srcu(&drm_bridge_unplug_srcu);
+
+	drm_bridge_remove(bridge);
+}
+EXPORT_SYMBOL(drm_bridge_unplug);
+
 static void __drm_bridge_free(struct kref *kref)
 {
 	struct drm_bridge *bridge = container_of(kref, struct drm_bridge, refcount);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 0ff7ab4aa8689a022458f935a7ffb23a2b715802..d2683846cc619007f85a6f605b9d23ce971e04b3 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1143,6 +1143,14 @@ struct drm_bridge {
 	 */
 	struct kref refcount;
 
+	/**
+	 * @unplugged:
+	 *
+	 * Flag to tell if the bridge has been unplugged.
+	 * See drm_bridge_enter() and drm_bridge_unplug().
+	 */
+	bool unplugged;
+
 	/** @driver_private: pointer to the bridge driver's internal context */
 	void *driver_private;
 	/** @ops: bitmask of operations supported by the bridge */
@@ -1278,6 +1286,10 @@ drm_priv_to_bridge(struct drm_private_obj *priv)
 	return container_of(priv, struct drm_bridge, base);
 }
 
+bool drm_bridge_enter(struct drm_bridge *bridge, int *idx);
+void drm_bridge_exit(int idx);
+void drm_bridge_unplug(struct drm_bridge *bridge);
+
 struct drm_bridge *drm_bridge_get(struct drm_bridge *bridge);
 void drm_bridge_put(struct drm_bridge *bridge);
 

-- 
2.51.1


