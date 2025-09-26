Return-Path: <linux-kernel+bounces-834427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CD6BA4AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B673B9A97
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D8F2EAD16;
	Fri, 26 Sep 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UQc9EmEw"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8523506F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904511; cv=none; b=A37gICfKwubiqqUU12zrk4Zdx279GDk5pQbzPY8L9MMUi20pz/eI6s3bUx27g7ApQgV3nJdVr1vKvQQ+H5PiMnNNteM1i8Zky16gKg62FpGE+TD3jpsYWybPXQPurX0ZezJ4VXFrqc6HewxXXkp1bMxZ07EqyEbT85K+iPOMRW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904511; c=relaxed/simple;
	bh=Tjtf+qkmGfwEJxwpsS39gFlyPr9z1XY1oZupy2jZouE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g6DXrOdKBH+iRqxPNT5vyupT6S8arJGqCl2osTbL5gf7btOQrBmPZquNXUcfwVwMFEAiXD6+eL89HNx5Ow6JQGNzggMp0feRv1UtnOWMWZJ46n7++5OaYjWaAYDSZqtgTctjLDb9Fl9KPFYfZBzoDLY7aAL3dhqVtWwDM7T0pYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UQc9EmEw; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 686704E40E11;
	Fri, 26 Sep 2025 16:35:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3EBD9606B5;
	Fri, 26 Sep 2025 16:35:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 40313102F18CE;
	Fri, 26 Sep 2025 18:35:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758904506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6xVw/khtwiX9YEqRoJlZJqW1RWke6AJC8b2cUTe6EF4=;
	b=UQc9EmEwq8CeuvRpDVvNT+LRASjb0Nqr+P7f9zDqVMuUWvFi4hWxc1WDDzwGItwtZWJNdt
	TpFuTAAIbE+A5eO4BXnILDMzL5YC2H1dJUM6BEVk39vQ+gegdqm5HWRmCkr1o5X8J7q5+f
	kdq5fdMjbc/mQzZxLASB8sPjdXb9OhhSAsZ1+xOu54z3urts6qVMnfznsTEko9x9isPI8q
	6TKsKDQLmdm77Tzdq4S41ryzJ4KCXKn2SPmR88UXMGCntvX7kateFedm4jNV6ihl1JLh+P
	tZB2VUFFqKMv2F5VqNWygXcCtwP/ReY+ZqmE37GBiXbmVvaheCAa3ncm+mR1Yg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 26 Sep 2025 18:33:27 +0200
Subject: [PATCH v2 1/2] drm/bridge: add drm_bridge_unplug() and
 drm_bridge_enter/exit()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-drm-bridge-atomic-vs-remove-v2-1-69f7d5ca1a92@bootlin.com>
References: <20250926-drm-bridge-atomic-vs-remove-v2-0-69f7d5ca1a92@bootlin.com>
In-Reply-To: <20250926-drm-bridge-atomic-vs-remove-v2-0-69f7d5ca1a92@bootlin.com>
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

To allow DRM bridges to be removable, add synchronization functions
allowing to tell when a bridge hardware has been physically unplugged and
to mark a critical section that should not be entered after that.

This is inspired by the drm_dev_unplugged/enter/exit() functions for struct
drm_device.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Link: https://lore.kernel.org/all/20250106-vigorous-talented-viper-fa49d9@houat/
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_bridge.c | 58 ++++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     | 12 +++++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index d031447eebc955efcf1e018d39c015b62b969eae..3ebf6cc820e058a67f712763c341a75c671c82d1 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -27,6 +27,7 @@
 #include <linux/media-bus-format.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/srcu.h>
 
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
@@ -200,6 +201,63 @@
 static DEFINE_MUTEX(bridge_lock);
 static LIST_HEAD(bridge_list);
 
+DEFINE_STATIC_SRCU(drm_bridge_unplug_srcu);
+
+/**
+ * drm_bridge_enter - Enter DRM bridge critical section
+ * @dev: DRM bridge
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
+ * drm_bridge_unplug - unplug a DRM bridge
+ * @dev: DRM bridge
+ *
+ * This tells the bridge has been physically unplugged and no operations on
+ * device resources must be done anymore. Entry-points can use
+ * drm_bridge_enter() and drm_bridge_exit() to protect device resources in
+ * a race free manner.
+ */
+void drm_bridge_unplug(struct drm_bridge *bridge)
+{
+	bridge->unplugged = true;
+
+	synchronize_srcu(&drm_bridge_unplug_srcu);
+}
+EXPORT_SYMBOL(drm_bridge_unplug);
+
 static void __drm_bridge_free(struct kref *kref)
 {
 	struct drm_bridge *bridge = container_of(kref, struct drm_bridge, refcount);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 76e05930f50e00f6ef5999b3f5a476215951028d..6b325de9e41ba7ee3649eaa60dfe105d6155f824 100644
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
2.51.0


