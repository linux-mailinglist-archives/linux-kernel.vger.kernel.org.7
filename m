Return-Path: <linux-kernel+bounces-841193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C7ABB6768
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41C344E614D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1401C2EACF9;
	Fri,  3 Oct 2025 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="upwAZc38"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722681720
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759487985; cv=none; b=M+F8aKMcWQVp219ko2XeENtizNv3rH8MlbatO6g1ZoAhq2SHVj72y+rIJ6drPLGzy8bnb/NuJdbZZz5bIc+W6sz4IDxmLCGvwoqojPI0Ct1I+VHeJh0Ii60PNB6ewZGxxHdspat9nmM3Y2WZlK+QrAejORcmyc1xyCtq4dmlh/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759487985; c=relaxed/simple;
	bh=KX49EIdCKMoNVJPsWgELjfff+Y5Kp5R86U4uS+ZpzDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hYNutGfsQJlGyQQcuspmLNlgd5ELcrSjrm5oKDtV2IIp0mE5NJEYjA9of/ocYENKNqbJ897suVGF11U8vs8r2XqaVy7rxWaieyFfbMIYG+KAo7zf6zOzEbNk4otyTetzkwqI6JzqIltu9vJICsQ5Fzk+x9sjewGEAWxHZtp6OaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=upwAZc38; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 85783C00D99;
	Fri,  3 Oct 2025 10:39:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 84F6760683;
	Fri,  3 Oct 2025 10:39:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12F32102F1C67;
	Fri,  3 Oct 2025 12:39:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759487980; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Qfu3JgcIsjrYY7+XbEdTvSNI3rVgt39kSDML/1Ac/9c=;
	b=upwAZc38H/sjoI9c8mcboj6oeXPAJsQPew3TzYvjqR+/+DCQJwSLAKqGKNyNWl756zzr49
	szwqN8H2FHqMLIev5WxWCl6dT+Wwz6ciHofzvk1iB8weZj+lBuM0NmH+ws2oFdnYk/j7BN
	HzNerP9hTrCEbPd7JD5cpY7FUpMnRL358Z9SYCmjyZg+wK7ZYh2vvFzrRbpLplUIbSpFur
	TAAQfT9x6VmEUUTX4ZESiiqEW1o3inCegiUwVczkpuU1YdHUfhC6fkp64ocqe4fpPb87iX
	PAp5jgCBjTqcovr1HSJPLjoOFNCjjSdXH33jTGxuDYlJRKsGCSGugzpZotDUxg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 03 Oct 2025 12:39:23 +0200
Subject: [PATCH v2 1/7] drm/encoder: add mutex to protect the bridge chain
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-1-78bf61580a06@bootlin.com>
References: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-0-78bf61580a06@bootlin.com>
In-Reply-To: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-0-78bf61580a06@bootlin.com>
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

The per-encoder bridge chain is currently assumed to be static once it is
fully initialized. Work is in progress to add hot-pluggable bridges,
breaking that assumption.

With bridge removal, the encoder chain can change without notice, removing
tail bridges. This can be problematic while iterating over the chain.

Add a mutex to be taken whenever looping or changing the encoder chain.

Also add two APIs to lock/unlock the mutex without the need to manipulate
internal struct drm_encoder fields.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2:
- Added documentation to new APIs
---
 drivers/gpu/drm/drm_encoder.c |  2 ++
 include/drm/drm_encoder.h     | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
index 8f2bc6a28482229fd0b030a1958f87753ad7885f..3261f142baea30c516499d23dbf8d0acf5952cd6 100644
--- a/drivers/gpu/drm/drm_encoder.c
+++ b/drivers/gpu/drm/drm_encoder.c
@@ -129,6 +129,7 @@ static int __drm_encoder_init(struct drm_device *dev,
 	}
 
 	INIT_LIST_HEAD(&encoder->bridge_chain);
+	mutex_init(&encoder->bridge_chain_mutex);
 	list_add_tail(&encoder->head, &dev->mode_config.encoder_list);
 	encoder->index = dev->mode_config.num_encoder++;
 
@@ -202,6 +203,7 @@ void drm_encoder_cleanup(struct drm_encoder *encoder)
 	kfree(encoder->name);
 	list_del(&encoder->head);
 	dev->mode_config.num_encoder--;
+	mutex_destroy(&encoder->bridge_chain_mutex);
 
 	memset(encoder, 0, sizeof(*encoder));
 }
diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index 977a9381c8ba943b4d3e021635ea14856df8a17d..449281c37e39f67a0037603762f347f5086df983 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -25,6 +25,7 @@
 
 #include <linux/list.h>
 #include <linux/ctype.h>
+#include <linux/mutex.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_mode_object.h>
@@ -189,6 +190,9 @@ struct drm_encoder {
 	 */
 	struct list_head bridge_chain;
 
+	/** @bridge_chain_mutex: protect bridge_chain from changes while iterating */
+	struct mutex bridge_chain_mutex;
+
 	const struct drm_encoder_funcs *funcs;
 	const struct drm_encoder_helper_funcs *helper_private;
 
@@ -319,6 +323,41 @@ static inline struct drm_encoder *drm_encoder_find(struct drm_device *dev,
 	return mo ? obj_to_encoder(mo) : NULL;
 }
 
+/**
+ * drm_encoder_chain_lock - lock the encoder bridge chain
+ * @encoder: encoder whose bridge chain must be locked
+ *
+ * Locks the mutex protecting the bridge chain from concurrent access.
+ * To be called by code modifying ot iterating over the bridge chain to
+ * prevent the list from changing while iterating over it.
+ * Call drm_encoder_chain_unlock() when done to unlock the mutex.
+ *
+ * Returns:
+ * Pointer to @encoder. Useful to lock the chain and then operate on the
+ * in the same statement, e.g.:
+ * list_first_entry_or_null(&drm_encoder_chain_lock(encoder)->bridge_chain)
+ */
+static inline struct drm_encoder *drm_encoder_chain_lock(struct drm_encoder *encoder)
+{
+	if (!WARN_ON_ONCE(!encoder))
+		mutex_lock(&encoder->bridge_chain_mutex);
+
+	return encoder;
+}
+
+/**
+ * drm_encoder_chain_unlock - unlock the encoder bridge chain
+ * @encoder: encoder whose bridge chain must be unlocked
+ *
+ * Unlocks the mutex protecting the bridge chain from concurrent access,
+ * matching drm_encoder_chain_lock().
+ */
+static inline void drm_encoder_chain_unlock(struct drm_encoder *encoder)
+{
+	if (!WARN_ON_ONCE(!encoder))
+		mutex_unlock(&encoder->bridge_chain_mutex);
+}
+
 void drm_encoder_cleanup(struct drm_encoder *encoder);
 
 /**

-- 
2.51.0


