Return-Path: <linux-kernel+bounces-760327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5CDB1E995
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80E3A0796F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A0C14BFA2;
	Fri,  8 Aug 2025 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LnZsYBMH"
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E055413AD38
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661183; cv=none; b=PBy0/epgg49YzZl4sfwq248pQ8O9Mk5mg+1GpkcPE7R6cRGD+Jysuhax/gaXGgAY/H04zVSmabX/slIs8yjn5JT0SWMtWf8fN//f4n7B7rs/XdFmnLNf9RHxQmDlpLj7t3hMP7LdAa3zl95N+ls0YpNgMzTSYyXPXaSAKlfZp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661183; c=relaxed/simple;
	bh=XWrN8dP52L0IECQzWlmUPJVMRWiGNv48/cj4Jc07Mns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RNFSp8Z4vjuG56a+wprAIRYtkUha5msf19knfVY8bvMy2zE15WvTV920fNQXSkQvTbGpJlfAK8F6HFauoBiwmlat1i2grqLWIp6kudCdVAuRx1JxjhhzrZaTDoP5m3DZxRU6+/k024t+lkOpmeVp/DOMD2uTx7dHsB9PbQLPP1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LnZsYBMH; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 4ECDA580D99
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:24:45 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5396643271;
	Fri,  8 Aug 2025 13:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754659477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=treXRwqi4SRhQJUrldc4icMQ5j0ZarZub9IcestONf4=;
	b=LnZsYBMH5x0nLG1bjCVBAqIegeaQq6J+L/4HRYo+gDF37gKN3itJENXn5swEhkp3DEleOH
	Z0neTAr+2M9qr07S4vk4MeG1EX2LTqFQf3twG35lnHTqYuvgMNGDaLskSFYalDtpfK/rBQ
	c4krbd2Qn88uDfRtIq2cJLX4prRCFCCZxMldaBMGKYH1bzcyFiaXVoAz67zuP2fdDurI6Q
	BoJ0IHVGCHyyFqoDGHsSiRT/2466G6V8hVuSota+le9fOffoEfw9Rc2CD2PxBQEorlQiV9
	QayyUNwuNB843hkExT03ThkJxPSTffjHUGViqOlifHWOxk01HzVG4HvV6DagZQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 08 Aug 2025 15:24:28 +0200
Subject: [PATCH 1/2] drm/bridge: add drm_bridge_unplug() and
 drm_bridge_enter/exit()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-drm-bridge-atomic-vs-remove-v1-1-a52e933b08a8@bootlin.com>
References: <20250808-drm-bridge-atomic-vs-remove-v1-0-a52e933b08a8@bootlin.com>
In-Reply-To: <20250808-drm-bridge-atomic-vs-remove-v1-0-a52e933b08a8@bootlin.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdefleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehjefgudegvddukeegvedtgfduudehtdfgteefvefgheekjeehvdeihfdtfffhkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeejkedrvdduvddrvdejrdduudehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepjeekrddvuddvrddvjedrudduhedphhgvlhhopegludejvddrudeirddtrddungdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghssehkfihisghoo
 hdrshgvpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggv
X-GND-Sasl: luca.ceresoli@bootlin.com

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
index c3bfcd735a3c426a147bf0a7427b3d2cd0df3524..486bc48881c6a05ebe3c911754a40530f0d08e3e 100644
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
index 620e119cc24c3491c2be5f08efaf51dfa8f708b3..0c6869ebb2be9b89499ee5c42692fd94ca5b3161 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1095,6 +1095,14 @@ struct drm_bridge {
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
@@ -1226,6 +1234,10 @@ drm_priv_to_bridge(struct drm_private_obj *priv)
 	return container_of(priv, struct drm_bridge, base);
 }
 
+bool drm_bridge_enter(struct drm_bridge *bridge, int *idx);
+void drm_bridge_exit(int idx);
+void drm_bridge_unplug(struct drm_bridge *bridge);
+
 struct drm_bridge *drm_bridge_get(struct drm_bridge *bridge);
 void drm_bridge_put(struct drm_bridge *bridge);
 

-- 
2.50.1


