Return-Path: <linux-kernel+bounces-841194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03920BB676E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3835345113
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8D62EB84A;
	Fri,  3 Oct 2025 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eRdfyp0n"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD3C2EACF0
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759487987; cv=none; b=pG4RjFdSLEYgELWVeuERYck69H5HvxO9sObVamUa7YMCA+DEoSIxSzERGp/70ywIzbvoFpt3VqzTtIuD5mHDGAikqphE6wgtXuDDM+LnKvV3xUBiYIYF+mbxtAV27dNvGaRpmYaSnhpcTc7ORe2E322+rXjI4cMZNkBbvonaUss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759487987; c=relaxed/simple;
	bh=HMvi2j0QlEMQyT/jCSYHu0a121jZL0pa33H1GYrotIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVmkCfbZY3AJsuaOjCMe35TpPlhBtJyatjSglIntksdw/3cFvhX743QPJE3Pyxn+Kqs5lk5viZHndGVgLqYHkp8Obl2eLYOhf3kygekSSIxpxhGwCkfZxO/YKvbSfgnN+tFsbFFIKIZSm+G2UYWwP7UVSiT0VLb3GeSlaKQC4mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eRdfyp0n; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D04744E40E8F;
	Fri,  3 Oct 2025 10:39:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A612A60683;
	Fri,  3 Oct 2025 10:39:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 21F0A102F1C38;
	Fri,  3 Oct 2025 12:39:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759487982; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kfCgGhXzegBkEi7/jTiC8TroMsKwhRsoP8qpHUK1OHg=;
	b=eRdfyp0n1w8OILY1RNCEU5BvMLz+Xfe4lWwMagXQg++17EnQ69cKqNm8NQTJMUfpsqsmfs
	FCmk/y/qBF9RFRTWCDLz+3HaCw3WsALzfIxGdnXVUvbGWyByBjpukT+MzsEmgoxj4BoLIH
	T2A8tbcgGLtHWQvaTkjCJa7ml3/CLXeu1JttTXQIl0OGs+1vlCg8l1xwp4XkIIa/Qd2qnS
	wrG9jOclv9ErWAilDgyjrgo0k6j9WjkTfk+nb1U4I7ptO8x6eN55oEcSoro4Sgoh0isqwO
	fw10qS7OdKfgeF7UYRsjvJQGy9jQSSm/RLqK0KjbaISwB2MczlruMXnGRvQFNQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 03 Oct 2025 12:39:24 +0200
Subject: [PATCH v2 2/7] drm/encoder: drm_encoder_cleanup: take chain mutex
 while tearing down
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-2-78bf61580a06@bootlin.com>
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

drm_encoder_cleanup() modifies the encoder chain by removing bridges via
drm_bridge_detach(). Protect this whole operation by taking the mutex, so
that:

 * any users iterating over the chain will not access it during the change
 * any other code willing to modify the list (e.g. drm_bridge_attach())
   will wait until drm_encoder_cleanup() is done

Note that the _safe macro in use here is providing a different kind of
protection than the mutex:

 1. list_for_each_entry_safe() allows removing the current entry from the
    list it is iterating on, synchronously; the non-safe version would be
    unable to find the next entry when the current entry has been removed
 2. the mutex being added allows to ensure that the list is not used
    concurrently by other code while it is being modified; this prevents
    such other concurrent code to derail because it is iterating over an
    element while it is removed

The _safe macro, which works by taking the "next" pointer in addition to
the "current" one, is insufficient to provide the protection at item
2. This is visible e.g. when the "next" element is removed by other
concurrent code. This is what would happen without the added mutex:

 1. start loop: list_for_each_entry_safe(pos, n, ...) sets;
    pos = list_first_entry()   = (bridge 1)
    n   = list_next_entry(pos) = (bridge 2)
 2. enter the loop 1st time, do something with *pos (bridge 1)
 3. in the meanwhile bridge 2 is hot-unplugged
    -> another thread removes bridge 2
       -> drm_bridge_detach()
          -> list_del() sets (bridge 2)->next = LIST_POISON1
 4. loop iteration 1 finishes, list_for_each_entry_safe() sets:
    pos = n (previously set to bridge 2)
    n   = (bridge 2)->next = LIST_POISON1
 5. enter the loop 2nd time, do something with *pos (bridge 2)
 6. loop iteration 2 finishes, list_for_each_entry_safe() sets:
    pos = n = LIST_POISON1 ==> bug!

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2:
- Expanded commit messge with rationale, as discussed
---
 drivers/gpu/drm/drm_encoder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
index 3261f142baea30c516499d23dbf8d0acf5952cd6..3a04bedf9b759acd6826864b7f2cc9b861a8f170 100644
--- a/drivers/gpu/drm/drm_encoder.c
+++ b/drivers/gpu/drm/drm_encoder.c
@@ -195,9 +195,11 @@ void drm_encoder_cleanup(struct drm_encoder *encoder)
 	 * the indices on the drm_encoder after us in the encoder_list.
 	 */
 
+	mutex_lock(&encoder->bridge_chain_mutex);
 	list_for_each_entry_safe(bridge, next, &encoder->bridge_chain,
 				 chain_node)
 		drm_bridge_detach(bridge);
+	mutex_unlock(&encoder->bridge_chain_mutex);
 
 	drm_mode_object_unregister(dev, &encoder->base);
 	kfree(encoder->name);

-- 
2.51.0


