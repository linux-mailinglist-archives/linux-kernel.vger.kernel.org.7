Return-Path: <linux-kernel+bounces-846726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE99EBC8DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 150B0352E9F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B5F2E2EEF;
	Thu,  9 Oct 2025 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oGo12hxS"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6612E11CB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009970; cv=none; b=aoUgzN0qk0UeChPgh/LQxUPQWKrjsO97BHd9tvVVAAhLrB2joXX9hRLGoVPxz5M2bP+TT76UsJfusP3RJLcxteTFmNmC5JCZPGhNZPGeZdyYku/CojFQndVIwZQ35TeDVR0F9BCgPT1hVdVoZwA+e0Z1QqvyLMQAg4H6azxXiIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009970; c=relaxed/simple;
	bh=uv56G89x8xvxNTFs4owqJ81BSEogNAWcC6B1PZTwKMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xkl9UKxe8TKZ+2tm+cM8WIlO6oIPNE8ctoHz3bz97YrlFfS4m/SDFUFzwQ1CR2xAYzJLlkcTp6OjNMtDAqk57kNZbTDYy/9ZaN7TW26idxh7Go+pWQAiTEwqviWDHJEo03IvPJASPt9CdEyJ3IPHVVruGHyJcjHdYHEdG450VOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oGo12hxS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 083AE1A1248;
	Thu,  9 Oct 2025 11:39:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D22816062C;
	Thu,  9 Oct 2025 11:39:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFDD6102F21D7;
	Thu,  9 Oct 2025 13:39:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760009958; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0n8c6A/a9bi0O5qFMAGMEnTzF69U4YZ6WigeDXrfPLw=;
	b=oGo12hxSth6cSbGDtUTUJ8oqBEAzp6QsoHk7S3YeKMyImIxLF/8hXhTTS2oJOjqZwTxtwA
	ZbH75hUUry266WdRqbr6s2PFp2OdmC6749sJ5PuqIDgFHIjCRda+Xz/7FqET2LWuqkblcM
	D0R05zKCUsa31vUN2day4CR7/kqdHDY3X8PuOfEaVm/6QX3j4ca5/B2eGBjizrY5/gGqGj
	lJx5K59Ruq6LRVH2ROwOv0HcgDdDiRtbpx/W4LSZ3ydmgvS/x81f/SwweeiMVF8snkylrm
	Z+fnjwCcsCJFT6us+EOFDEHcI2FMkvCK2tsRlFoPPFdHZ1A5QKpIPDTt1YVeaw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 09 Oct 2025 13:38:57 +0200
Subject: [PATCH v3 2/7] drm/encoder: drm_encoder_cleanup: lock the encoder
 chain mutex during removal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-2-c90ed744efec@bootlin.com>
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

drm_encoder_cleanup() modifies the encoder chain by removing bridges via
drm_bridge_detach(). Protect this whole operation by taking the mutex, so
that:

 * any users iterating over the chain will not access it during the change
 * other code willing to modify the list (drm_bridge_attach()) will wait
   until drm_encoder_cleanup() is done

Note that the _safe macro in use here is providing a different and
orthogonal kind of protection than the mutex:

 1. list_for_each_entry_safe() allows removing the current entry from the
    list it is iterating on, synchronously; the non-safe version would be
    unable to find the next entry after the current entry has been removed
 2. the mutex being added allows to ensure that the list is not used
    asynchronously by other code while it is being modified; this prevents
    such other concurrent code to derail because it is iterating over an
    element while it is removed

The _safe macro, which works by taking the "next" pointer in addition to
the "current" one, is insufficient to provide the protection at item 2
above. This is visible e.g. when the "next" element is removed by other
concurrent code. This is what would happen without the added mutex:

 1. start loop: list_for_each_entry_safe(pos, n, ...) sets:
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

However, simply adding mutex_[un]lock(&encoder->bridge_chain_mutex)
before/after the list_for_each_entry_safe() seems a simple and good
solution, but it is introducing a possible ABBA deadlock (found by
PROVE_LOCKING). The two code paths involved are:

 * drm_encoder_cleanup():
   - takes the bridge_chain_mutex (A)
   - calls drm_bridge_detach -> drm_atomic_private_obj_fini ->
     DRM_MODESET_LOCK_ALL_BEGIN() which takes all locks in the
     acquisition context (B)
 * drm_mode_getconnector() (and other code paths):
   - calls drm_helper_probe_single_connector_modes() which:
     - takes a drm_modeset_lock in the acquisition context (B)
     - calls __drm_helper_update_and_validate ->
       drm_bridge_chain_mode_valid -> drm_for_each_bridge_in_chain_from()
       which takes the bridge_chain_mutex (A)

To avoid this potential ABBA deadlock, move all list items to a temporary
list while holding the bridge_chain_mutex, then detach all elements from
the temporary list without the mutex.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- Prevent ABBA deadlock by using a temporary list
- Improve commit message

Changes in v2:
- Expanded commit messge with rationale, as discussed
---
 drivers/gpu/drm/drm_encoder.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
index 3261f142baea30c516499d23dbf8d0acf5952cd6..0d5dbed06db4461263d28b47e152dc55a7a88bb4 100644
--- a/drivers/gpu/drm/drm_encoder.c
+++ b/drivers/gpu/drm/drm_encoder.c
@@ -189,14 +189,26 @@ void drm_encoder_cleanup(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
 	struct drm_bridge *bridge, *next;
+	LIST_HEAD(tmplist);
 
 	/* Note that the encoder_list is considered to be static; should we
 	 * remove the drm_encoder at runtime we would have to decrement all
 	 * the indices on the drm_encoder after us in the encoder_list.
 	 */
 
-	list_for_each_entry_safe(bridge, next, &encoder->bridge_chain,
-				 chain_node)
+	/*
+	 * We need the bridge_chain_mutex to modify the chain, but
+	 * drm_bridge_detach() will call DRM_MODESET_LOCK_ALL_BEGIN() (in
+	 * drm_modeset_lock_fini()), resulting in a possible ABBA circular
+	 * deadlock. Avoid it by first moving all the bridges to a
+	 * temporary list holding the lock, and then calling
+	 * drm_bridge_detach() without the lock.
+	 */
+	mutex_lock(&encoder->bridge_chain_mutex);
+	list_cut_before(&tmplist, &encoder->bridge_chain, &encoder->bridge_chain);
+	mutex_unlock(&encoder->bridge_chain_mutex);
+
+	list_for_each_entry_safe(bridge, next, &tmplist, chain_node)
 		drm_bridge_detach(bridge);
 
 	drm_mode_object_unregister(dev, &encoder->base);

-- 
2.51.0


